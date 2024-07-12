Return-Path: <linux-kernel+bounces-250872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4B92FDED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CFA28318B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42E17622F;
	Fri, 12 Jul 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYF2+lN2"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF9172BA6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799453; cv=none; b=i9DywYwfDhTxYNv9onotwGPg0AGJkDQ4oopBWLtkuIsx0liYWG+tH16IUlunNeYLxXkggbF49ilXitcJfsCaycSa/4JGXfXuAAP5nPgSoBb0O+rMXWrEFMXuF3hIiKS3eChDWjp2mT0qMsJQfibEPlPkIP3ECbOE1nGnjVvQ468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799453; c=relaxed/simple;
	bh=Qqzjk+xNooTukKHLFwoefFeTys+iX9WqkiacjI4cAs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJE9JY2+2T0QY1Y6oEQM4AmNIZOd0K+U6h5yMFQaa+ph4+OxethjhnlRv+h0TLnlzzvgd3tDK0c+wO0b9zXQCiLITWexCI20yqR4GCMDWKpcGV0mZADbnKKiKxlEplkUWBlmTuAYNEoGO20NKJZ3QZ1OfZ8zlVpiIkKMF4ScCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JYF2+lN2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70361c6fd50so1078870a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720799450; x=1721404250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG5A4YXtzS1gv1mDoqU9AHeDK5e1XcR6A6PUMNeVCio=;
        b=JYF2+lN2SHw3t4y9A2bRjP07owZMMoq277PXsIkxrp8fwf9b69mQ6m4jJpNuhcCL2Z
         E46dec9Bsx5qIuH6fDtDfqFZGc7hJDxV2mHuCB6iYa6jInGVRtgcvAc9ocBg9B+kIg7z
         PI8yvRuT6c3orblgjoXyiSO3D1kZa9mfcFlto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799450; x=1721404250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iG5A4YXtzS1gv1mDoqU9AHeDK5e1XcR6A6PUMNeVCio=;
        b=gzPg+rEJlaD2SniTpRRHjthEzg2q6m5Q+aQEkYSXo+tIPi4+2QC20zCA8bvClLIQdP
         hNmwGLp5DZXWHRFN5HfFCjOnI60bhlfqfS/LzzTEqoUaoEuOny+8SG6MKUkIaGnWp7+L
         NCEdYD5RUNyMVZEcZyK9qp7NhF6ifU7suvreoe9cdsk9qZTztmW4mYOL8QxzPllm9dRJ
         oI0vdGYLT2T4cCISWpTrvLQv0p0LeozqQuAKTouSD4RUCAWc92KYI8fbc6CdynWl1+Gh
         ND3ntrfKDBWfZKumah2Znn2iok+ibLIAmOLOskNo7Fw9DIbRyRS2kAkvaggj/dKL9SAo
         fA+A==
X-Forwarded-Encrypted: i=1; AJvYcCWzJ4BKmSEpWyFbciHDCt1tVyjXiCSf8d68ij/08BaiKfVO+jY2bIC0BEsfgix+uNYkMpCxkEKKUOT9312DFH663KhIghEJ2t7w3Jwq
X-Gm-Message-State: AOJu0YxWXodfaSm+wT+z0Tg9Hu/LkWX2nDNcdaCknua+ldX5uj2osntI
	FZ6/Gge5st9hDHMdqluKobSNOauwUaKb8nm/+UoJeI977d49SpFTbMGnC0ZAuKUi+P/2LgwYf18
	=
X-Google-Smtp-Source: AGHT+IEeaw/+WnztBpTQBgiNJG3XRctA5ggLcinYz9kRpEJgCF2hh3oGBrQwmhX0oGIiuT8uZwCizg==
X-Received: by 2002:a05:6830:98:b0:703:649e:f91b with SMTP id 46e09a7af769-70375a1f08amr12990651a34.18.1720799449864;
        Fri, 12 Jul 2024 08:50:49 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61baa28e7sm36442486d6.135.2024.07.12.08.50.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 08:50:49 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447df43324fso263191cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:50:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXd7btflFGH/XIUsS8Vo8El8BrBCR6lsME/v/tpWB9UgMuZQl0bjBgWyfbgnH0Xrd7hBr9++MubxNbVbVU7XG8kxm8DafGUlSuNQXAk
X-Received: by 2002:ac8:5dd4:0:b0:447:eeb1:3d2 with SMTP id
 d75a77b69052e-44e9e6589afmr2940221cf.27.1720799448329; Fri, 12 Jul 2024
 08:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-5-yangcong5@huaqin.corp-partner.google.com>
 <D2LQJROQYIY3.2Q88EXS8HUDLQ@kernel.org> <CAD=FV=WAosZPSKdpwR6pjOmiy4hih=jXaMg2guuVgmc+qj-Csw@mail.gmail.com>
 <D2M42ODWQPAU.I0BMEOLKUP29@kernel.org> <CAHwB_NJ+YEMoL18Sr9HFmTVH_ErDztyF7vxxPFAE0Y2ta3dO0A@mail.gmail.com>
 <CAD=FV=VNx5qEyWDvVz6AVDryqvw09tkYRYMjbFuUQS4Wvyok6Q@mail.gmail.com> <4f3b24d6-9638-49d0-8308-00da09c7ed76@linaro.org>
In-Reply-To: <4f3b24d6-9638-49d0-8308-00da09c7ed76@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 12 Jul 2024 08:50:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V5fYweYUoeYD=8qa_jTpF2P_ZjHKJrz0o3ikgrH4XJKQ@mail.gmail.com>
Message-ID: <CAD=FV=V5fYweYUoeYD=8qa_jTpF2P_ZjHKJrz0o3ikgrH4XJKQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] drm/panel: ili9806e: Break some CMDS into helper functions
To: neil.armstrong@linaro.org
Cc: cong yang <yangcong5@huaqin.corp-partner.google.com>, 
	Michael Walle <mwalle@kernel.org>, quic_jesszhan@quicinc.com, linus.walleij@linaro.org, 
	airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 12, 2024 at 7:56=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 11/07/2024 21:36, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Jul 10, 2024 at 6:09=E2=80=AFPM cong yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> >>
> >> Hi,
> >>
> >> Michael Walle <mwalle@kernel.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B 03:38=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> On Wed Jul 10, 2024 at 9:12 PM CEST, Doug Anderson wrote:
> >>>> Hi,
> >>>>
> >>>> On Wed, Jul 10, 2024 at 2:02=E2=80=AFAM Michael Walle <mwalle@kernel=
.org> wrote:
> >>>>>
> >>>>> On Wed Jul 10, 2024 at 10:47 AM CEST, Cong Yang wrote:
> >>>>>> Break select page cmds into helper function.
> >>>>>
> >>>>> Why though? I don't find that anything easier to read. In fact, I
> >>>>> deliberately chose not to factor that out into a function. It's jus=
t
> >>>>> a sequence of magic commands, taken straight from the datasheet. So=
,
> >>>>> I'd like to keep it that way.
> >>>>
> >>>> The consensus of previous discussion on the lists was that folks
> >>>> agreed that we should, where possible, make it more obvious what the=
se
> >>>> magic sequences of commands were doing. IMO separating out the page
> >>>> switch command helps. Certainly I'm always happy to hear other
> >>>> opinions, though.
> >>>
> >>> Fair enough, but in that case, one should take the datasheet (which
> >>> you can find online) and replace all the magic numbers with the
> >>> correct command names from it. E.g. 0xff is the ENEXTC register. To
> >>> be clear, I'm not just talking about the "switch page command".
> >>>
> >>> As patch stands, I don't see much value, TBH. On the contrary, you
> >>> make it harder to compare it with the Ortustech panel datasheet.
> >>>
> >>> just my 2c,
> >>> -michael
> >>
> >> If all drivers replace all the magic numbers with the correct command =
names,
> >> it will be a huge amount of work (assuming that the datasheet can be f=
ound).
> >>   I am afraid I don't have enough time to complete it.  Thanks.
> >
> > Makes sense. I'd be interested in hearing the opinion of others in the
> > DRM community about whether they'd prefer to land something long this
> > patch as-is or drop it.
>
> I don't have a strong opinion, but I think only changing the switch
> page operations doesn't make a lot of sense by itself.

Does that mean you think we should drop this whole series? For the
"panel-ilitek-ili9806e.c" driver dropping seems fine since the switch
page command (and many of the other blocks of commands) is commented,
but for the other panels in this series IMO even just getting the
switch page adds to the readability... I'm happy to just apply patches
#1-#3 or just drop the series.

-Doug

