Return-Path: <linux-kernel+bounces-173623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6538C030B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095361F2281B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D5127E34;
	Wed,  8 May 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzNqPoyN"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9259165
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189107; cv=none; b=dXGbpZXbfXcUXFFJ6qz/zJRYbV8PLQJt7/9Y0SfjHJDBRKa+qgOCl/BHK1Iu01gVRuODDiODNFbOQ85t1Z4pmadkAnvq7ZCtj8DxW1x6wm60CrmpSI2SPzs8SY9Z284T9IHXiMGUcTfpdBag6DOeUyNipLDwLKxBATwyNpi/h58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189107; c=relaxed/simple;
	bh=mRchDPxMeHJwLDj1d+HyfPvCH4lFbS4D7KCFGiKd3zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUBqf6/DDnOrwnhWLPm5hrFExLmlgn0NevZXAVqkIhaJwNl/TrhUd4nDlOQhZY8ZAp2lIUlPJ7f5OTQHVOOQeGEU+keEwd8OFjCzGo5T2hoUuRwHmbwvdL0b1P60F+h6fRAf1t/hKtUTP1F6+CAmEnGqJIpG/59M69XLa0FxGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hzNqPoyN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b5ece41dfso115366d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715189103; x=1715793903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+VKTM4P5eufJalRCrDbHQ7nMVvva4ngXjaL2EQ5cWU=;
        b=hzNqPoyNkuwnHwuHdxrfPq7+hg2nM9sxsbJU8Q7k+uuQZzwKI05gAV/d06oI9tMAly
         nl0HlYlnYXN7njM2mkIuKAXmhOapqvXMLuv0cxheRGfHimvY6uyKzI1uAd2BcEUuERdZ
         4sZuhfzippZbaFfx9BjGSvgwh4xPeZ0MBkZLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189103; x=1715793903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+VKTM4P5eufJalRCrDbHQ7nMVvva4ngXjaL2EQ5cWU=;
        b=jIJfSJBGmJGaVN7SVJ5LdKO+v1aJJ6NmlYWkWtTgBb0r2ZRZRNRTLHYn/3qtMu3Twb
         AhYTsr4auwjo+6dfN+6BM/nj26YtaxaPJ/QyunEeBBqU+DScVG6jXxI/ZugAwIEg3BqX
         GjjRDZ7hjAeWgewnJ9J2kMEpCSN5Skqe8MAEKe8tXNL9A1t37vUZzZWwiI4X1SwVTaSf
         cB2d0HGxWuCdwRU35TyyPbP/2PSilKsL6otDEFKyPKYTKxoPZv5jWdPquD6qzupd43ma
         jmewlaJA6TROvoOxV90EjbD09/5Hzu8LIJaT6QoEortB3wksc8tcbjqVyTXzLKnMolUW
         OEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK7jHm3Jiwgpc1vPx0RaiehJZ9Av6uw2J2rWVAnvvuXV8G73QeMBZ0ZK91TAjwJeCEIu4ce1QamAVAFLxv6oxjw7EusB8cqdcqi6pJ
X-Gm-Message-State: AOJu0YyrdkJsOEeq3M6oPit+gl6pu0bS7nzYwoCzjYZv+qYEOdMxvi/w
	Mp+NH8t5KDpS7hUqQeORKJeZ8L7seQCUolJY0v6q1ORub9SOiBz9gVH9yXtN/Z5CjfoYS3cNAGA
	=
X-Google-Smtp-Source: AGHT+IFbixhiSF3q1MEeEb1mqf0gGYdPUv6dlnRr8lyGTpPrw9f7xbmUe1WqH+FH/7ygdN2Ix1m2Aw==
X-Received: by 2002:a05:6214:2a4d:b0:6a0:7a3f:d290 with SMTP id 6a1803df08f44-6a1514cee2fmr37668716d6.51.1715189103190;
        Wed, 08 May 2024 10:25:03 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id a14-20020a0cefce000000b006a0fa61359asm5753269qvt.41.2024.05.08.10.25.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:25:01 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-439b1c72676so30981cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:25:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE9f/a3+RJXE1w44zSomfQwF1GqXLJOTQXuwf0RTG+1oX5EBsY/UZcE9wwluTPJpCp65Kw4JOfVtS6iyz2Yb6sgzD/JsUtA9Or2Ihn
X-Received: by 2002:a05:622a:4e0a:b0:43d:db04:45d1 with SMTP id
 d75a77b69052e-43ddb044c2fmr2760251cf.1.1715189101210; Wed, 08 May 2024
 10:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=Wj5WKcVbNGHQ_BbZa_fsVJkpYb2C8TE8bjhvJvx+N_hw@mail.gmail.com> <CAHwB_NKPswAvE5TjRxWMR8LLV5sNuMmymXr4nhDc3r_AdRKr8A@mail.gmail.com>
In-Reply-To: <CAHwB_NKPswAvE5TjRxWMR8LLV5sNuMmymXr4nhDc3r_AdRKr8A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 8 May 2024 10:24:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJkmAPB1h87o0m+6HSbVg7ehr0Xd+JFpuF+vuezof-hg@mail.gmail.com>
Message-ID: <CAD=FV=UJkmAPB1h87o0m+6HSbVg7ehr0Xd+JFpuF+vuezof-hg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 4:52=E2=80=AFAM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> > > +static int starry_himax83102_j02_init(struct hx83102 *ctx)
> > > +{
> > > +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi=
 };
> > > +
> > > +       hx83102_enable_extended_cmds(ctx, true);
> > > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2c=
, 0xb5, 0xb5, 0x31, 0xf1,
> > > +                                        0x31, 0xd7, 0x2f, 0x36, 0x36=
, 0x36, 0x36, 0x1a, 0x8b, 0x11,
> > > +                                        0x65, 0x00, 0x88, 0xfa, 0xff=
, 0xff, 0x8f, 0xff, 0x08, 0x74,
> > > +                                        0x33);
> >
> > The indentation is still off here. You have 5 tabs followed by a
> > space. To make things line up with the opening brace I think it should
> > be 4 tabs followed by 5 spaces.
>
> Sorry, my  editor 'Visual Studio Code' It seems that the correct indentat=
ion
> is not recognized. I have checked it through the 'vim' editor in the V4 v=
ersion.
> Thanks.

FWIW, I use VS Code and it looks fine to me. Maybe check your VS Code
settings? Tab size should be 8.


> > > +static int hx83102_enable(struct drm_panel *panel)
> > > +{
> > > +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> > > +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> > > +       struct device *dev =3D &dsi->dev;
> > > +       int ret;
> > > +
> > > +       ret =3D ctx->desc->init(ctx);
> > > +       if (ret)
> > > +               return ret;
> >
> > You're still changing behavior here. In the old boe-tv101wum-nl6
> > driver the init() function was invoked at the end of prepare(). Now
> > you've got it at the beginning of enable(). If this change is
> > important it should be in a separate commit and explained.
> >
> >
> > > +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       msleep(120);
> > > +
> > > +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to turn on the display: %d\n", r=
et);
> > > +       }
> >
> > The old boe-tv101wum-nl6 driver didn't call
> > mipi_dsi_dcs_exit_sleep_mode() nor mipi_dsi_dcs_set_display_on() in
> > its enable routine, did it? If this change is important please put it
> > in a separate change and justify it.
>
> In the old boe-tv101wum-nl6 driver inital cmds was invoked at the end of
> prepare() function , and call 0x11 and 0x29 at end of inital. For
> himax-hx83102 driver, we move inital cmds invoked at enable() function.
> For panel timing, I think there is no much difference. They are
> all initial cmds executed after meeting the power-on sequence.
> I will update these in the v4 commit message.

Ah, I see! So the mipi_dsi_dcs_exit_sleep_mode() was the 0x11 in the
old code and the mipi_dsi_dcs_set_display_on() was the 0x29 in the old
code. OK, I agree that it's better like you've done it where those
functions are moved out of the "->init()" function and into the
caller, so please keep that as you have it.

The only thing I would request is to keep the ->init() call to be made
at the end of prepare() instead of the beginning of enable(). It may
not matter too much, but in that case I'd rather keep it how it was or
make it an explicit change and not an implicit part of the refactor.

-Doug

