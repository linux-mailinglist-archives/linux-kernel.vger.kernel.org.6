Return-Path: <linux-kernel+bounces-180681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D58C71B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789711C20D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4AC2554B;
	Thu, 16 May 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGRqsEoc"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE98171AF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841808; cv=none; b=Lxhrz1gIiJGOzAuA0rSCriJ3obNSfkT48XmEyf66p66R1XPEuJrp63gcKmOJOsu5H4uoPRYCSURtQMt9TKHsaVa4gLh3goiStyl1WmahTejVvv3fs5yN0q1SdFhpRSeii/VgBmW3izMKyuFcbnhVwdEKO5oegGwkD9iANJu28HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841808; c=relaxed/simple;
	bh=c2TcMiJxSBMbGpIdPl05hGl6M7IKIuM8dGzrOTy4jv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8tZXmkXYgUeMgTvOeHRoEFXvu1sNOgoOCDWJry1PFfSvlUn6+vX0KR6ygCu/K3/L1t1/JLmaS1wHYBeAwHXUJRC1LSvRvWtMqhMu64T5rd8tRj9dg4v6s8c35OA/+pIFxNLIsTuGpJ9xELW65hr0cjbXg1L/WTHnTgQ43f9830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGRqsEoc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso6632964b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715841806; x=1716446606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbD9OONNgONi8UaqGSjW3pD6UDCGtAlGXcl7rP3rgjE=;
        b=OGRqsEocTX5txgIVLmUlrRnORuXCHVUILcHg1aX0idMqwh1dgDOXevx8STnIZlcvss
         DF1nola2Er8iiIE+eVRTAwZwvH3MDarLusS76udXCICwnAri/M1jyvzR+Yi/8zAnbUbC
         t3leO++WkyDT+CKYHGedjWs+4JMhn5Qo9rmZYCnLP8d7Z3NG2fJafl6JRregD8mqE7ds
         oIrSDLwXXpGqSbjvXTF8eGQupo2kniKWarFu+gpMvIg+qtXZzhtpodg8lLSYflm85dxV
         2jcg+MPb1OcKPmxF4lvHY5x3V2XSmhak2dKu148PxbW/B4yXl/eKDi9Q02S+8W3SZM59
         +8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715841806; x=1716446606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbD9OONNgONi8UaqGSjW3pD6UDCGtAlGXcl7rP3rgjE=;
        b=RFzxvdQXGy+je8p9YUUixx/ic4XAPkl5VyvGeOwEAFuRD/pJNj45121UsOt14WzcVV
         +oTeseeUOb/OvHo9bkIpvhbKCrHj5EvNT6FJ/O3QOAJsrqt0h4L4QpSiOqXDxjFheDwC
         3fQfCmxip70ba9IRHRQbbGpcm6lYtiuSZd88tyUMEHmleYBBPZavR4uJlvJrkap/qyy5
         8hIt+Upfz38MIhkrlO2e2NwwRi9YwtlgpuGyTkPKdoKVXwzIFhV3nqipyIn9Qeop+VhA
         +WNa53mzqxxBdEGUdC1TeNdiHh4blPdGtymiXJYQDCtdNvjDTpSX+BTeE+kG5j4OHw63
         oLRA==
X-Forwarded-Encrypted: i=1; AJvYcCVWc3HmRasD4I5AcN7+S6n9746xB51iaTesp/ByPqckgy/MIgXdi5rC1l0MusdqPZdGZcJshRqYWfGG7cSYTYWBQEf4PA2hQuWLiFLm
X-Gm-Message-State: AOJu0YxEt9eMsJUVaT3yZJwTrOlDj8P+EozHf9cZH1JcN5lXr3i3FNPi
	zfWY85dCMErT4xRjS5l6R+2qvog2zDby25O3OLEwSHn61sMUdnFEn3wmNCKqQFOS+Br5B5A2LEh
	eH9wCOqkRL7BDUU+DmxbplQl7XTmt1QSPkVIZLw==
X-Google-Smtp-Source: AGHT+IHDppSukXCiHciUkgsTerTNmnDmHK840fw5n4L6dCa9CfJH8j7P5339bVpVAT53uRl05JVp5ugFFtAulpNDsuM=
X-Received: by 2002:a05:6a20:f3a3:b0:1af:acd5:b462 with SMTP id
 adf61e73a8af0-1afde201cbdmr16442323637.50.1715841806422; Wed, 15 May 2024
 23:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-4-yangcong5@huaqin.corp-partner.google.com>
 <0fcdb0ac-2e4a-44b2-a5d6-a67a1d747df8@linaro.org> <CAD=FV=XkBkQUN-93eQDKZcw_66uSeNBBhbiq2hRLcFN+Ck71RQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XkBkQUN-93eQDKZcw_66uSeNBBhbiq2hRLcFN+Ck71RQ@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Thu, 16 May 2024 14:43:15 +0800
Message-ID: <CAHwB_N+foZpCjqUy0dJdS2wBbUjHVRQQP0p7S_eTG1Yrh0bgPw@mail.gmail.com>
Subject: Re: [v7 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi:

If it is determined that a separately patch needs to be sent, then I
will remove this patch in V8 series?

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B 05:28=E5=86=99=E9=81=93=EF=BC=9A

>
> Hi,
>
> On Wed, May 15, 2024 at 2:16=E2=80=AFPM <neil.armstrong@linaro.org> wrote=
:
> >
> > Hi,
> >
> > On 15/05/2024 03:46, Cong Yang wrote:
> > > DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WU=
M_NL6.
> > > Since the arm64 defconfig had the BOE panel driver enabled, let's als=
o
> > > enable the himax driver.
> > >
> > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >   arch/arm64/configs/defconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defcon=
fig
> > > index 2c30d617e180..687c86ddaece 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> > > @@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=3Dm
> > >   CONFIG_DRM_PANEL_LVDS=3Dm
> > >   CONFIG_DRM_PANEL_SIMPLE=3Dm
> > >   CONFIG_DRM_PANEL_EDP=3Dm
> > > +CONFIG_DRM_PANEL_HIMAX_HX83102=3Dm
> > >   CONFIG_DRM_PANEL_ILITEK_ILI9882T=3Dm
> > >   CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=3Dm
> > >   CONFIG_DRM_PANEL_RAYDIUM_RM67191=3Dm
> >
> > You should probably sent this one separately since only an ARM SoC main=
tainer
> > can apply this, probably via the qcom tree.
>
> Really? I always kinda figured that this was a bit like MAINTAINERS
> where it can come through a bunch of different trees. Certainly I've
> landed changes to it before through the drm-misc tree. If that was
> wrong then I'll certainly stop doing it, of course.
>
> -Doug

