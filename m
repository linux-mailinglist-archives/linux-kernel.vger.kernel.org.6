Return-Path: <linux-kernel+bounces-210606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F190462C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E851C23482
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF11534EC;
	Tue, 11 Jun 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4ecS30I"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53738DC8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140398; cv=none; b=cJGL+kGC7EfkVoSF0GcezaSOaom35rit9iISKRgGhSvDZaIK6mWej4zQmWYRKkRuwMdPHOpbcba6+D5dR9PXKKyX6/RFpGExED5CoYwmufMGR9Xwk68nRx9A8jk9kwByNszQC6/4dJ5bumbvv5OnZc3xZYfRApzUCZUexR4Kw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140398; c=relaxed/simple;
	bh=7MlrQe8t42aRQ9g2eud96LFaz2KjoHsmxlhySd78PJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRnTm+c64Q0QiW73YL/bhT2WqPDx5ZjAazFIIH9mKv00iQ2dRlfX6DQX4adUES/sULN/9dYiXsZAypx8mXw1HsDXNjC9AmZhgZJa3585xoTzCslg7kn9UQlGaz+OS/fr/JWmOdRYQnDTm1sgENdz9XyWOXkBp4FsWMWqcyuH+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V4ecS30I; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso6703249276.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718140394; x=1718745194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnsIoTs1uwuDmQ5vPMUGoGCQwLbqdaM9DFuaa81UGRo=;
        b=V4ecS30IefRIgN3V0GKy++RsSE7+xI0XBcfU2nudFyhj2g6AXPf7s1GBGC87K1IWYo
         9/q7yzin0PkJglh7/t0+ZV80jcmEvhZWfbsVggFVWKiH0e8N9gRpiJVcoQtoKEF6S2Q3
         Dq3ZIAmS3ZspMCg1PDkcKEkvrAlq3ATK9b6z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140394; x=1718745194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnsIoTs1uwuDmQ5vPMUGoGCQwLbqdaM9DFuaa81UGRo=;
        b=Vxu0jfuumSsiZ06XYBCOrBK3cq7Nw23F7h3/hCB09Riut1N3qyrPOO/uw0TgfuajGV
         jftkuDx/aCfEb1JQX4sls5zl+94MSc/zIsqF866Hya5dqsejd4U0Uq/0+U7LCgvambpc
         rB1ibFSziNOmXK2tPR80wJLboe93+5hAcurhhPQfVVHJw22E7ZwZwndW/7GuZN/VuWls
         jOQKQDz8Dol3T2MID5RYJhE23WzOFW0CU7vkCbhvo7x49YvGXlP0XO1aCqyzR9hwkIbj
         VccTnoK7l+ycPoIuo4Q80NVIN9IxyxOQjFczG/RSEntMzYIlbhwaoFeP321ft3qx4kvf
         zuqA==
X-Forwarded-Encrypted: i=1; AJvYcCVyzE08QvLAYeIcQ+u3OZlLHGmrxOa/AUlOitb+T66/6ItF0qnwHIIzw0gPmqy6Xbg4BdtWCrlmZr7Je12Ugp7+oJ6UtlpW/u5n26Q1
X-Gm-Message-State: AOJu0YyZD0EPC2HvORPIhupN4VNDwxpn6egPPevqd9LKTV445rSZ6wCs
	Kij2oYwKjenrogJgIlxXbSJYWpjT1pJejgiPf5JIGO/wF2zEwFpdpAHxJWgHqxrjINvKAqSVZLE
	=
X-Google-Smtp-Source: AGHT+IEHLDRPTzJLa4+9GZQXSMqEyqrGjzRuT2PoYHk1Bg6MYeIjljUcaM5UdGK/5o+m0ArzhOASIA==
X-Received: by 2002:a05:6902:218e:b0:df1:d0ec:32cb with SMTP id 3f1490d57ef6-dfaf64ed26emr15557674276.23.1718140393660;
        Tue, 11 Jun 2024 14:13:13 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9b4377sm59456966d6.105.2024.06.11.14.13.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:13:13 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4400cc0dad1so130361cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:13:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMrn4B2//JTNQxs3T8oHvIx1+0qFlKtTSa2czy+NxcIAPtInQpr7QcFiyQ9MfVQgtWu12S9H7VJ0H5/tu2MnHUwG+z9WyD31ea5sBr
X-Received: by 2002:ac8:6f16:0:b0:43f:f227:8df7 with SMTP id
 d75a77b69052e-44159ce374amr122811cf.3.1718140391298; Tue, 11 Jun 2024
 14:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3288287d-8344-4b37-a333-722cf12fef13@gmail.com>
 <CAD=FV=XRuU=eh0HzbDCwFrr5h9s-rOdB5dbANAd-BmMhiHR6Ww@mail.gmail.com> <uhnjrzii3ydzdsnhc54sbglpy46drzwg2m6if5ymid7gjabcvd@ppzdg6xz4xx7>
In-Reply-To: <uhnjrzii3ydzdsnhc54sbglpy46drzwg2m6if5ymid7gjabcvd@ppzdg6xz4xx7>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Jun 2024 14:12:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJdp0btifYjGLN5_bfGSEwcEM5nPv8M7872190T3uMRA@mail.gmail.com>
Message-ID: <CAD=FV=WJdp0btifYjGLN5_bfGSEwcEM5nPv8M7872190T3uMRA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel : truly-nt35521: transition to mipi_dsi
 wrapped functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 11, 2024 at 2:10=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, Jun 11, 2024 at 08:57:48AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jun 11, 2024 at 7:44=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail=
.com> wrote:
> > >
> > > Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Intro=
duce
> > > mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> > > ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> > > sony tulip truly nt35521 panel.
> > >
> > > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > > ---
> > >
> > > Changes in v2:
> > >     - Fix patch format
> > >     - Fix code style
> > >
> > > v1: https://lore.kernel.org/all/485eef24-ddad-466a-a89f-f9f226801bb7@=
gmail.com/
> > >
> > > ---
> > >  .../panel/panel-sony-tulip-truly-nt35521.c    | 435 +++++++++-------=
--
> > >  1 file changed, 209 insertions(+), 226 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b=
/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> > > index 6d44970dccd9..5a050352c207 100644
> > > --- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> > > +++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> > > @@ -44,248 +44,231 @@ static void truly_nt35521_reset(struct truly_nt=
35521 *ctx)
> > >  static int truly_nt35521_on(struct truly_nt35521 *ctx)
> > >  {
> > >         struct mipi_dsi_device *dsi =3D ctx->dsi;
> > > -       struct device *dev =3D &dsi->dev;
> > > -       int ret;
> > > +
> > > +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
> >
> > It's not a huge deal, but normally in the kernel all the variable
> > declarations are cuddled together. AKA no blank line between the
> > declaration of "dsi" and the declaration of "dsi_ctx". It would be
> > awesome if you could send a v3 fixing that. When you send v3, feel
> > free to add this above your own Signed-off-by:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > ...with that, the patch will probably sit on the mailing lists for a
> > week or two and then get applied. Neil may want to apply it, but if
> > he's busy I can do it too.
> >
> > I believe you were planning on tackling some more of the panels. Since
> > you're still getting started sending patches, maybe keep it to a
> > smaller batch for now and send another 10 or so? Probably best to keep
> > it as one panel driver per patch.
> >
> > -Doug
>
> Do we want to delay this until the mipi_dsi_msleep() is fixed?

Yeah, that's a good point. I saw the mipi_dsi_msleep() problem after I
reviewed this patch, but you're right that it should be fixed first.

-Doug

