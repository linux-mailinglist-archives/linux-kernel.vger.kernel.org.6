Return-Path: <linux-kernel+bounces-173181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F858BFCAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD3A285FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F482C6B;
	Wed,  8 May 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DfxI5AKH"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC7823BF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169123; cv=none; b=qGtcG7EvG3E0W9WQoQXTHLBHAxp9eUYnodvd2O62g/bPjOSwoWQZipbFSHvznBD4NsKL0ly6pmydX/DXsNGuB4D2RrNCGZA9frPxMnve/Qio7/moq8IpwFaZumreS/JKYVjl5VAMc2qboo8sMcdTlSTJPEqCtz4IBr/LZzUP74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169123; c=relaxed/simple;
	bh=21WZUZABtoQNfRX1jBAzfALHLDUGBlVG06XSqRlV0fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elXBhz7U/5okWX/4qsjlNNWR1zru+Si999OdTUZfwaw43hDp1WmSe2iH7LA8D3Q5AKjev8iF7LfNCHOIPhTX+qi3LUAGUpj5yZGTTQZskqM+Mmr6nTGhoEdYOC1nwq5HU3SgwnkctCT6MwMJNNGMPO+3XdF+g/iSRMthV0daPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DfxI5AKH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b387e2e355so2884610a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715169121; x=1715773921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYxgECP19KQcIH0PhiMfWn89B9REarDnlrwf/7Dgpy8=;
        b=DfxI5AKHdSr9rHLldL1S5XNs1utg+7iRBgQbin0Xx3Wg2CpzQ94dg0dadOLKkrctJ/
         B/KdAluEflC4hPw3/rTlOHA0IobIWG2rn4A7ibG9mu5A+HPOQox2IMuOC1Cf2fuHITOP
         zwuoHVTbAoUAlZG5UeUYIhTZR6GOzE0pkv3KNpGVZEf0/Jm+3SWV8E7YTVIFg0hTEgcU
         q7F4OuAMtOziMNanddSOlunKGxGk62KcbhmhIfyBKPuNnejqlYf2kZYp+G9QPHbPhV39
         yvrhNc/sJQzD5T9BvCwPAUuhJFOepbMi9iwx+NKlEJDxSIme6X9P/HFTk8HV2FrTy/is
         sQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715169121; x=1715773921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYxgECP19KQcIH0PhiMfWn89B9REarDnlrwf/7Dgpy8=;
        b=I6Fgb6HEqWm2giE4lrr66Z/7vWc8BRbdtPFVJdsKbyx3xb0cJUkEPy+X6xJP0XxTYO
         UU+mmhyHxKGmm7F+xo6ShH0H13IVy1Tj7TOm9cT4+qY7sLb7GkRTI0gnsO1hxhaGssGO
         SWg1ao+Pg3mByJ6eFOP/a9Oglm+I5sKEed4Zq6qQ0PfCPgKEz6d/Sw56aE3fR1M3SPqm
         sF4BzQ53Va+spDy7PdWmYMm5cGfX/s07XWHf9mvz8hhM25Wlfxv847HWiutT2uljHYEu
         3K0GskZ8NNjv/qnEriwczgyP7I7kBQx05Io5iBe38X2Bm8YPHGRGZqj4ovqmy1Hke2mO
         wlVw==
X-Forwarded-Encrypted: i=1; AJvYcCXrjJhWa7q/PSWSt0mObNGn69mAP/8VQUM3ZuH89JULp8Wt3R8K3Gihs8va1ZxLf4VafLvoBqEAmwvJM/0d4XIgDqCDkPu7rFau7+CL
X-Gm-Message-State: AOJu0YwIh7rbbo3sKdgiuhOoLUDzeadIfJlks2LmSrdjKgpfZ23w+xCA
	jYYNzkaeDzMIM1RmVHhgFD9mNMyuxqjtf0+fb/efxtMzQYLF+rrvSkH/GeTYwJ+zC+PrQXm72Mk
	bhTlfHffIiG6RT1zdiTRgoIhbA2lvgQUZdgv3OQ==
X-Google-Smtp-Source: AGHT+IEhdE+GG8XxwKNRlclHRbBSycIrPohs+PTxSK9Z3F9iJMuBG2HZF6XAdrrAJXkCh/xJgPaDBMp9H0/wPUP9epQ=
X-Received: by 2002:a17:90a:d386:b0:2b6:22f0:3b8a with SMTP id
 98e67ed59e1d1-2b622f03bc3mr1840592a91.36.1715169121651; Wed, 08 May 2024
 04:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-3-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=Wj5WKcVbNGHQ_BbZa_fsVJkpYb2C8TE8bjhvJvx+N_hw@mail.gmail.com>
In-Reply-To: <CAD=FV=Wj5WKcVbNGHQ_BbZa_fsVJkpYb2C8TE8bjhvJvx+N_hw@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Wed, 8 May 2024 19:51:50 +0800
Message-ID: <CAHwB_NKPswAvE5TjRxWMR8LLV5sNuMmymXr4nhDc3r_AdRKr8A@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=B8=89 07:35=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, May 7, 2024 at 6:53=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > +static int hx83102_enable_extended_cmds(struct hx83102 *ctx, bool enab=
le)
> > +{
> > +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi }=
;
> > +
> > +       if (enable)
> > +               mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETEXTC,=
 0x83, 0x10, 0x21, 0x55, 0x00);
> > +       else
> > +               mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETEXTC,=
 0x00, 0x00, 0x00);
> > +
> > +       return 0;
>
> You're throwing away the error codes returned by the
> mipi_dsi_dcs_write_seq_multi(), which you shouldn't do. You have two
> options:
>
> Option #1: return dsi_ctx.accum_err here and then check the return
> value in callers.
>
> Option #2: instead of having this function take "struct hx83102 *ctx",
> just have it take "struct mipi_dsi_multi_context *dsi_ctx". Then it
> can return void and everything will be fine.
>
> I'd prefer option #2 but either is OK w/ me.

Ok,I will fix in V4, thanks.

>
>
> > +static int starry_himax83102_j02_init(struct hx83102 *ctx)
> > +{
> > +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi }=
;
> > +
> > +       hx83102_enable_extended_cmds(ctx, true);
> > +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2c, =
0xb5, 0xb5, 0x31, 0xf1,
> > +                                        0x31, 0xd7, 0x2f, 0x36, 0x36, =
0x36, 0x36, 0x1a, 0x8b, 0x11,
> > +                                        0x65, 0x00, 0x88, 0xfa, 0xff, =
0xff, 0x8f, 0xff, 0x08, 0x74,
> > +                                        0x33);
>
> The indentation is still off here. You have 5 tabs followed by a
> space. To make things line up with the opening brace I think it should
> be 4 tabs followed by 5 spaces.

Sorry, my  editor 'Visual Studio Code' It seems that the correct indentatio=
n
is not recognized. I have checked it through the 'vim' editor in the V4 ver=
sion.
Thanks.

>
>
> > +static int hx83102_enable(struct drm_panel *panel)
> > +{
> > +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> > +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> > +       struct device *dev =3D &dsi->dev;
> > +       int ret;
> > +
> > +       ret =3D ctx->desc->init(ctx);
> > +       if (ret)
> > +               return ret;
>
> You're still changing behavior here. In the old boe-tv101wum-nl6
> driver the init() function was invoked at the end of prepare(). Now
> you've got it at the beginning of enable(). If this change is
> important it should be in a separate commit and explained.
>
>
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
> > +       }
>
> The old boe-tv101wum-nl6 driver didn't call
> mipi_dsi_dcs_exit_sleep_mode() nor mipi_dsi_dcs_set_display_on() in
> its enable routine, did it? If this change is important please put it
> in a separate change and justify it.

In the old boe-tv101wum-nl6 driver inital cmds was invoked at the end of
prepare() function , and call 0x11 and 0x29 at end of inital. For
himax-hx83102 driver, we move inital cmds invoked at enable() function.
For panel timing, I think there is no much difference. They are
all initial cmds executed after meeting the power-on sequence.
I will update these in the v4 commit message.

>
>
> -Doug

