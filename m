Return-Path: <linux-kernel+bounces-382045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3A9B0841
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB791F22318
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D521A4A1;
	Fri, 25 Oct 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NRaGT+dV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33EB13AF2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870178; cv=none; b=WHQ6YGDhLp6eLhGYI3rh2B/hN66cNBm1qVyia2tLnyQ83e2P8Pz4VeaT8Pz04xUBQt30QFJOjFm5rOP44jfeSp9TLKYdbtZFs70RsC80IG2s9QrjdZP3+Y9nLiVEYoyQCDXO80nJjp5MHf6a4xVVKjKkDUkJ3fH1GgEktvVU60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870178; c=relaxed/simple;
	bh=mfVU3o+HrP2O0BnPv1WlOSU0JlgkC5nDnn2XkoVB8u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS3iJrjWbmLZmAR33T9t/+AcFpTtfqRYGzJGrpjFpK4JXrRiIRVyMOe1IZbhMaHkx1PKDc9/LLD2FrPvsEegNr5Buoqj7MpY34lhcydeyKSZX2TO177INItTGSeuujmeBQ/QVMGvNkVMYhHILgmiKyJqxppnWOH48k8OgNFzvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NRaGT+dV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e59dadebso2889504e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729870172; x=1730474972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGXZTlcKhnhORAVfmpbxlvJi6p/7XxY3P3Hx5lHoMU8=;
        b=NRaGT+dVu4l7ByF1S2KZFQecyLR4ZZfaAY1HsDB7y8Fgy4GJZRhDPMjmPe6AJSvFEB
         6Qkl/3xrOW/B+vHVecgEkf5DbAq3pZVzQgF2ONF1iEtF9Ja6gq7YSMIMmmzZ34AwPHxa
         KXzStMHluzUbeBjrwRxJy2hiNcwUW7UyCYFhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870172; x=1730474972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGXZTlcKhnhORAVfmpbxlvJi6p/7XxY3P3Hx5lHoMU8=;
        b=ZEWwVzlddRJ3xvdokOmONbn8c6xXrmW93H4Fo4ZbLsoR4cXy7btSE6t8qqRZWekjk5
         5DXJcwvNSJxFVW0iYw3iT9OsCxK3tkq+XwNEGnLMrL9zqDCcpVSBadxbymMB9px4U1+X
         Huc7IhjcKT5JKbHU0ijWPtleXpUim8ewb81/WHzqYSDjWb8PvujnP2yBe9G8UpUseDAE
         eSIYHqJcpRG0+mWsiiJfnHv9W/Kk+4YHGiMxckPImRmtCsCmMJOhQMRJgI1de3eP9x1B
         0sppuxKi0YSG8ks3arFitCpmIabnGyQZ7b0cO9V9j8iXAO6gbeLKRWFWNqNpcpkcH2QL
         liDg==
X-Forwarded-Encrypted: i=1; AJvYcCUHdWDuRIB/Lm1Pz69xZvJl79HqITxIwc/S1HElWVtyBYTN3aMiIJZjpc5vbzeY+fS6Ho4mHX8xjrXV4Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTS/G2PgRV/8Yh7g2pw7kd49L9Hv547KpnqnQ254COjRiAu55g
	nAG/aHuRRoiLky/quM13psop5h2ln74kbu4hAB2mfKgBROOE8FAw8YGxWDKPAq055KYkM164YkD
	1997M
X-Google-Smtp-Source: AGHT+IFV2oUsW0F4wv9Zg82dZ7rj5cBE5B9dPN3unHVtqn/nd1Eoo444CXuaNgSt3yW7YGoSttALrg==
X-Received: by 2002:a05:6512:1086:b0:539:e776:71f7 with SMTP id 2adb3069b0e04-53b23e85758mr3898149e87.37.1729870172152;
        Fri, 25 Oct 2024 08:29:32 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1244adsm215712e87.69.2024.10.25.08.29.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 08:29:31 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso24251451fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:29:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQLI7SFvQ5eZA8ZRBnoljNCrLaCxJIpOxY3MXEO7J3OztOeObbcPr3NECGga++PxRmWYE3ZOcO9QC/fow=@vger.kernel.org
X-Received: by 2002:a2e:6112:0:b0:2fb:5ac6:90ef with SMTP id
 38308e7fff4ca-2fca81d665cmr29753751fa.11.1729870170017; Fri, 25 Oct 2024
 08:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025114642.40793-2-charles.goodix@gmail.com> <3ypn62dsgarvmxkmdglugcinxmvpmhdqub2zvkygaonn54odf6@amfgijfcd3l3>
In-Reply-To: <3ypn62dsgarvmxkmdglugcinxmvpmhdqub2zvkygaonn54odf6@amfgijfcd3l3>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 08:29:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1F3QC=eSXcCn-78iQBzHMzT3z9Sis3yXKW_Bzun3+EA@mail.gmail.com>
Message-ID: <CAD=FV=X1F3QC=eSXcCn-78iQBzHMzT3z9Sis3yXKW_Bzun3+EA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: Goodix SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: dmitry.torokhov@gmail.com, hbarnor@chromium.org, 
	conor.dooley@microchip.com, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles,

On Fri, Oct 25, 2024 at 5:03=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - goodix,gt7986u-spi
>
> Compatible is already documented and nothing here explains why we should
> spi variant.
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  goodix,hid-report-addr:
>
> I do not see this patch addressing previous review. Sending something
> like this as v1 after long discussions also does not help.

Krzysztof is right that it's better to wait until we get consensus on
the previous discussion before sending a new patch. I know you were
just trying to help move things forward, but because of the way the
email workflow works, sending a new version tends to fork the
discussion into two threads and adds confusion.

I know Krzysztof and Rob have been silent during our recent
discussion, but it's also a long discussion. I've been assuming that
they will take some time to digest and reply in a little bit. If they
didn't, IMO it would have been reasonable to explicitly ask them for
feedback in the other thread after giving a bit of time.

As Krzysztof mentioned, if/when you send the "goodix,gt7986u-spi"
bindings again you'd want to:

* Make sure it's marked as v2.

* Make sure any previous review feedback has been addressed. For
instance, I think Krzysztof requested that you _remove_ the
goodix,hid-report-addr from the bindings and hardcode this into the
driver because every GT7986U will have the same hid-report-addr. I
know that kinda got lost in the discussion but it still needs to be
addressed or at least responded to. I guess there was at least one
other comment about "additionalProperties" that you should look for
and address.

* Make sure there's some type of version history after-the-cut. Tools
like "patman" and "b4" can help with this.

* The commit message should proactively address concerns that came up
during the review process. In this case if we go with
"goodix,gt7986u-spi" the commit message would want to say something
explaining _why_ the "-spi" suffix is appropriate here even though
normally it wouldn't be. That will help anyone digging through
history.

-Doug

