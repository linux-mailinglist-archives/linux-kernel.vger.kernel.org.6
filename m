Return-Path: <linux-kernel+bounces-175188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B18C1BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D287BB20E20
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8113A896;
	Fri, 10 May 2024 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jjLZSp8B"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E017C8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303776; cv=none; b=SXwWfa2pHmnEvbd4knT8943nCItF87TYOS63UI6uwE99weI03UJ8i1fvsF11i6Z8/KUOHkjZg14hRyGl0E8wwA6DOYpWWRoisipArjvYIwheyPfzDULhbobXijvRNY7VCu1TMTPDfMqGfNjqsfVknUFghcgMgHHMWSx2EI+ZMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303776; c=relaxed/simple;
	bh=2fcOBVBrfnG9Lcs+jW2LUibg2KTv0EIACX2xMfyYIh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CepVp1BZte3VdvCHUD95/VTVTac1WYkRo+7oCT488/0C6kP0hfumrUTn2MzfACX6gS9NoWL8L9nUO7EFDgJb2a31oHhHNR7LjgM+6eYlJJ6mxfG4x7NIGR/o2IGfvND0N4CKskDfutplBkiQ14TJEYyA6XtPtFTbsAYxHtPupRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjLZSp8B; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b5f3e20615so1402523a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 18:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715303774; x=1715908574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnHzXcqwdMje6zef+rnrR24PpbhWOfPmWy1Mi5rLSKA=;
        b=jjLZSp8BZWpGlAvV5kvg2RJZLevjn6O28/OS3QqS4wIg+cDBnPHCkACXQGGVgiCM7D
         mVpsj4R1rbpA8mNhatsk14vOdp0pVtPXZoCPXU6Yzu2qDfxzsgqruoiWApHoUalV/0jI
         hWVZvI+1QQyNRNZLuSoxwLRVR2xmTHK0y3S8SCqHs/xFub3yBBWs4wtykgbfTPA2Vr68
         QwRxg9AhrrhPJikpZTHSL06xOuZbFWfSaICac/vh20KTdmcZ2Orq3r6fqK/XR8Yv2jvE
         Hcc2cWFsW9UzPjmJEnxz8c5/aJF41i92hALkyz7TTptJsy80CpVEkhVpFw51rtJl+1Kq
         J63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303774; x=1715908574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnHzXcqwdMje6zef+rnrR24PpbhWOfPmWy1Mi5rLSKA=;
        b=a9KrKU2J+uSnqMiXWwNbL4BAX0tZhgMXqbH/wrwUjL6+3RIdO2RX1Y0xLPP0N7JMrI
         m+8ZsnB2ttbFVtB7XRuc50M4amj23dPZKecqL/TGo+Fa9wKnEsMAfe/+7jlBPLJNv9V2
         Ov+xASr7kpO62PmQsfebp7mx1DLbKxsbwjHJsaN5CsoryuKHZfBKGCmQD2qZkGcAlwGo
         B0N2uxmdfzJJWDdPSpy4sKTkPUGATPBunXQsa3/UkpTzDSnH9Xgleqsl/ZiJbCRZGLX5
         EGDzR5Rjq6ZbIRmJ1dWKwlyxYcV7gN4EkXey64I1KgSQtc32U/PfF3MsSYQhOP2T5IYZ
         LYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnNl8CBSxzxXOdAr65peieJS4BBPQDnAN2QvfT5en1mCxMeMMQuCGrv9OxOyeFbj5e5Q+UnampHUjtB3yt6M8TuohA7fw/rIlTaDPV
X-Gm-Message-State: AOJu0Yz4xC+CUfpX+f2Fov2xs0rt2XaHDvse0bhC3WbbGjGb/5EacoZ2
	neAMkqihbiCgbXdzQkp1x6HKKnMlzuxQKPxCQ67dLErgwRP/VeRL6ez3bmLJ1NCTKNP2oBV5V3p
	HWy+3ChPfx6SYyhzSOZuZTmhep8I/ef8CxFC0yA==
X-Google-Smtp-Source: AGHT+IGieCHyqLLzJXlHoooTGbyYocfx4JUS5UcV50/4kEyYvlHyDg3xZp1atR6QdJzTm0NzVCH90GAqfLme1ElBJTg=
X-Received: by 2002:a17:90a:b38c:b0:29c:5708:b922 with SMTP id
 98e67ed59e1d1-2b6cc76f920mr1355513a91.26.1715303774695; Thu, 09 May 2024
 18:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
 <20240509015207.3271370-3-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=UaTj_ojJvc2T22e49MhB-zp1+Z_tp9uULS0r8MesUd2Q@mail.gmail.com>
In-Reply-To: <CAD=FV=UaTj_ojJvc2T22e49MhB-zp1+Z_tp9uULS0r8MesUd2Q@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Fri, 10 May 2024 09:16:03 +0800
Message-ID: <CAHwB_NKtw0AyMgFb4rMFNgr4WF10o9_0pYvbKpnDM45aYma9zg@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=94 00:42=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Wed, May 8, 2024 at 6:53=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > +static int hx83102_enable(struct drm_panel *panel)
> > +{
> > +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> > +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> > +       struct device *dev =3D &dsi->dev;
> > +       int ret;
> > +
> > +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       msleep(120);
> > +
> > +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to turn on the display: %d\n", ret=
);
> > +               return ret;
> > +       }
>
> FWIW, I think that the mipi_dsi_dcs_exit_sleep_mode(), msleep(120),
> and mipi_dsi_dcs_set_display_on() should also be in the prepare() to
> match how they were in the boe-tv101wum-nl6.c driver, right? Then the
> enable() would be left with just the simple "msleep(130)".
>
> I know it doesn't make much difference and it probably doesn't matter
> and maybe I'm just being a little nitpicky, but given that the
> prepare() and enable() functions are unique phases I'd rather be
> explicit if we've moving something from one phase to the other.

Yes, if it is consistent with the boe-tv101wum-nl6.c driver, then it
should be moved to prepare().
However, I was working from the driver readability,
enable() corresponds to 0x11 & 0x29.
disable() corresponds to 0x28 & 0x10.
.
Ok, I'll be happy to send V6 version to fix that, thanks!

>
>
> -Doug

