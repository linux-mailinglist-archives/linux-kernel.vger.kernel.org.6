Return-Path: <linux-kernel+bounces-395455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099A9BBE17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB99A1F22995
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05B21CC150;
	Mon,  4 Nov 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jCbowRGQ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9C1C876D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749034; cv=none; b=X1bfMXEuebrNukP9b8BsPQuZ9LyJz+yApqOe8IXAp3s9TGQDl8COFRrIdusGjAV9aF3V4VpdbnxNdvw8XwLfminMvRsMlUubKfhV4SYWYlGNqwybZ3Rkn2Rp3CTPvfNHnG5k0ALFfJCWRPeaqIKqHVIEE5eMYr0B1Hsmp3r+8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749034; c=relaxed/simple;
	bh=1lBbc+n+/nnQbLbO5BWXZXN0GtOR8CMewX+RwC3SYdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXdF7gR+Fi6/6vIb1cZCCjS4++J69WZqCNsF8PPIWolpXKSEB8fNSFEQJ/JF/6W1Nmiuj47B/vSka7VUlRTgrkO7KTqqkukpK2MNMalXte4a6BsTjGB+S8na+BjqQARhcHVxTXrP3bl73LTukYxpuNFlP8QL0dOkxWd3sX3fSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jCbowRGQ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so67162651fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730749028; x=1731353828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H3MOSyfVCTn2aBJJHJZEtjM6no8KhD2xeVxlGCW/Rw=;
        b=jCbowRGQr0s/24gl3MZsaAHTJzJlCr0iGINjueYCZKSrlagdoCOySQKeZjsTrrV4Oc
         gB83D46EVowhnZFeXNQ96CNui73eqno10+g/Xi3m2YrF7ZZ5KAVbWtw6TRUg5Y9mvIOA
         Ik0AXDtuG3W097CSkFpY5vH3T9a6bkNqFSj9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730749028; x=1731353828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4H3MOSyfVCTn2aBJJHJZEtjM6no8KhD2xeVxlGCW/Rw=;
        b=OAishYHsTQu/BmPp897wJzrBUAb6X5LatnaCfFEymmCgc+QOn8RDEnB0vK+Ibv0n/n
         FscLzMDgZdjTt2QJwzLSUEDU/paqydLWB9oUQRjsOt/Sm9MaGgQU5nSDnG/sS0wRSLOt
         5tttZVwn7UaGOf9i/6sdDDWHy7+GAfgxGvjDphMnMTmESlP8k7heCgK3LUcrXLAyKty/
         +jQJ7AXa4Qn4CSWSzgxRC9IthXj+ouVElkfor1ReRROCZcPyvOOpDAubm6WTCJ2SGlB7
         GHorxlyaeCxanOUC/OkIhivVWSjOvmH5+Vua+8xEFhxPnBIP4WB3+udEjWNIckA6d1WW
         mVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlM8xIu+KbmCOpYwkwofJp2TOLJlTmAUevef67fslhB2giCL+VhecKjR7ohvSlmnQ6v/Eg6FCp2IKt2h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUg18rFGfCXnbHpBrIU0jO+xzPhdsxFGYjTOIO7SDZoY+DjSHB
	WU38lw+zeg4z4MWVl27/BsIS5GsGjLs6VgBcXzRnISHBTfG9V7hoTSMxu28rEZ0asslOlxyaxxU
	Ogw==
X-Google-Smtp-Source: AGHT+IGt94cRx8B0iYBNOWc9DxOedjbeKbZFHqyRXh6hXEzhuYG2YhS7lbDN2jZ90pHFk64sWsdfZA==
X-Received: by 2002:a05:651c:893:b0:2f3:f1ee:2256 with SMTP id 38308e7fff4ca-2fedb84a3a9mr94511361fa.44.1730749027966;
        Mon, 04 Nov 2024 11:37:07 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6410sm17975991fa.97.2024.11.04.11.37.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 11:37:06 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so67160621fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:37:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxtipSrAz3vezOSIQSgBOrB2t/48uh9GdyRfJxRNjWAOHESS9kTUG6Ef1N7/hbnqMtxYd0sGh62vUfp3s=@vger.kernel.org
X-Received: by 2002:a05:651c:550:b0:2fb:3881:35d5 with SMTP id
 38308e7fff4ca-2fedb813966mr95709131fa.35.1730749025443; Mon, 04 Nov 2024
 11:37:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025114642.40793-2-charles.goodix@gmail.com>
 <3ypn62dsgarvmxkmdglugcinxmvpmhdqub2zvkygaonn54odf6@amfgijfcd3l3>
 <ZyLtYdwoJWx9FsdS@ux-UP-WHL01> <CAD=FV=UNKECLn=3VrjsJfA+HTNa9Gag1qw5jOcBvw7=ZtkZEnw@mail.gmail.com>
 <ZyQvxKi8dYOv1AOg@ux-UP-WHL01>
In-Reply-To: <ZyQvxKi8dYOv1AOg@ux-UP-WHL01>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Nov 2024 11:36:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WD5=2SBLD2rDtXXt0dbn-KUvnE0kPsbnyEAkSA_4w-tA@mail.gmail.com>
Message-ID: <CAD=FV=WD5=2SBLD2rDtXXt0dbn-KUvnE0kPsbnyEAkSA_4w-tA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: Goodix SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: dmitry.torokhov@gmail.com, hbarnor@chromium.org, jikos@kernel.org, 
	bentiss@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, conor.dooley@microchip.com, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles,

On Thu, Oct 31, 2024 at 6:33=E2=80=AFPM Charles Wang <charles.goodix@gmail.=
com> wrote:
>
> Hi Doug,
>
> On Thu, Oct 31, 2024 at 10:58:07AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Oct 30, 2024 at 7:37=E2=80=AFPM Charles Wang <charles.goodix@gm=
ail.com> wrote:
> > >
> > > > > +  goodix,hid-report-addr:
> > > >
> > > > I do not see this patch addressing previous review. Sending somethi=
ng
> > > > like this as v1 after long discussions also does not help.
> > > >
> > > > No, you keep sending the same and the same, without improvements.
> > > >
> > >
> > > I apologize for overlooking the discussions regarding this issue.
> > >
> > > I would like to clarify that while the current boards use the same ad=
dress,
> > > but newly designed boards in the future may require different address=
es.
> > >
> > > Retaining this property would likely offer more flexibility.
> >
> > I don't feel very strongly about it, but maybe Krzysztof does?
> > Possibly the path of least resistance would be:
> >
> > 1. You drop the property from the bindings.
> >
> > 2. You hardcode it in the driver to be the normal value.
> >
> > 3. If/when someone actually needs a different value then we can add it
> > as an optional property in the bindings and fall back to the default
> > value if the property isn't present.
> >
> > What do you think? If you feel strongly about keeping the
> > "hid-report-addr" then you can certainly keep making your case.
> > However, it's probably best to wait to get agreement from Krzysztof
> > (or one of the other DT maintainers) before sending your next version
> > unless you're going to take the "path of least resistance" that I talk
> > about above.
> >
>
> Agreed, let's wait and see the opinions of Krzysztof (or the other DT
> maintainers).

As I went back and looked at this again, I'm curious: I don't know
much about how your protocol works, but is there any reason why your
driver can't figure out this "hid-report-addr" dynamically? Is there
some reason you can't talk to the device and ask it what the
"hid-report-addr" should be? From skimming through your driver there
appear to already be a few hardcoded addresses. Can one of those
provide you the info you need?


-Doug

