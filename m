Return-Path: <linux-kernel+bounces-227596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE19153DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96081F24D77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8619DF77;
	Mon, 24 Jun 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ud4YU6UC"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DA1B964
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246692; cv=none; b=B+r0f/ZcKpxcAXJtGNuz+QvU6pX6ftsXEcsfsnSxj4y19WAlQIUrEtQZrqc11U4h2guYpZ+FjWHWoL9oRyLy3zPuST/2LIgbequyQcRfDT3+/bQv123KsAGibEhqQG4LFQF4WGKJhqeITHWfZFtjs3yJgtuOGtFsavPOviJEl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246692; c=relaxed/simple;
	bh=EaHwq9EeajeLVDchJCQ3z2v7Y4OECT3v3mf/IAV+mBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRpD1FkhfxKmXsc+CnYimyTl1icXIyxEI4xkPUbBiClDRGRVNstSKhdIc5hy66aqnVK/gfyAM/hXidNtqCqSkGK98MMJjiaOFKTUaD6xxkSzkJA8KptSyTpmsIAYO+o1qnsQ/iRCPWw/wklSX1wIt80nvo+eB80PxaVNLJzAMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ud4YU6UC; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-443580f290dso1074601cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719246690; x=1719851490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4fofXsIYYcUkuRwyEj47LNTu/GpV5ONYOayCRpxVsE=;
        b=Ud4YU6UCytV4Pxev1+uAx0tqELtzwK4tRkPjPj4wTKBZR67w/T1B7RWLye2gZCDYWz
         XOCn4oIhKFqxypZVbLxVXuOiE6lbHOpVj/2nlGwZIUEs2lsN1Q1pCW9nPB1JS2Y/s3Nt
         aVtHI7LOXA7dFIpbKDYLh2rvVAeEd2FUwpDSOvyysg6c2L095EuJsz6XUYoidtpd3dTd
         NQ+/I2xIIeQgc22OTxfgvFb9Q+9cubJg5X/Z/LHdOaO32/SSqBXaJwnzfR8TRhh3JujR
         ozDfPePoR6im+LT5567zI6GYNukbQJU7lZKFenYjLWdb0UjhnkrAbitE2nA8dkDjJwea
         R9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246690; x=1719851490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4fofXsIYYcUkuRwyEj47LNTu/GpV5ONYOayCRpxVsE=;
        b=uMrt4F//ExyHHfn9p+4RHS/UA+6gtJAUUmYA62Tji1FRn36zsKJHkQB3ZJP3aQB4bO
         sxpdMaqUNTLVzSBg0uKKOKzxxj24GQpYcWDamC/HElGz36KAEyI71cBZbepX+EyhIHFy
         v3+otGrfroaDY2vMMaMR3UMkcVxJqg1IYCnqk1v6IhD8jfL2Ga6kcilxJ+kMpkRAKRHG
         7k05GP93wu5pEniEZssEps0ggyyYtElsaQzuF+qwInIrTKIaTtvn8J8uA+bVljOCNpl1
         fxSC4uJSiD/hPR1VsnrO6dbzCf0em5RCJixzgi4olymRt3iSBjN8faCcxJs9qSkc2cRV
         4E+A==
X-Forwarded-Encrypted: i=1; AJvYcCX7bWfuCP9yj6O36sLqkM8JfkJSpCG5hQMYq+LjdS3CbuvmhNhdMV0FM3DEqykNNzd8Blo/UfWmMimw6vPUVDPsU0l3uDmcG0czoSHy
X-Gm-Message-State: AOJu0YwqLyGZ57WXRnBnDTsez+7rgyV22u8uwUwW4dqiKAjyEuBIskHz
	bbQ3KOxbGDsz/D965W5gRZNLGxZf3bRfqIcvwyNL1b570IU8hyqNYLTEDBxHA8+KsmMNFjtgJFZ
	B2huy8PVut8eD5osXrsu/bHc85PNfTVXsw9pT
X-Google-Smtp-Source: AGHT+IG1zecr1N057X6yYwZ08s24kL36wYtFxRzdL/X3h8Y/3cfMKPcsBorSUybV7L06JvCRqb1FevbPjxKkeKOWoKk=
X-Received: by 2002:a05:622a:6fc7:b0:444:e366:3fda with SMTP id
 d75a77b69052e-444e36643aamr4050431cf.27.1719246690014; Mon, 24 Jun 2024
 09:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240624141926.5250-4-lvzhaoxiong@huaqin.corp-partner.google.com> <zvkl2wyqp3iem4ln4qkbhgvxafsfn5wkkmqwhufabm2gqs3eqw@vmqs3lx72ekk>
In-Reply-To: <zvkl2wyqp3iem4ln4qkbhgvxafsfn5wkkmqwhufabm2gqs3eqw@vmqs3lx72ekk>
From: Doug Anderson <dianders@google.com>
Date: Mon, 24 Jun 2024 09:31:14 -0700
Message-ID: <CAD=FV=V9tjY-g=w1Dwj+9oiTWfku8Bt48OUPJqYUqZaJrY8C1Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] drm/panel: panel-jadard-jd9365da-h3: use wrapped
 MIPI DCS functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, dmitry.torokhov@gmail.com, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jikos@kernel.org, benjamin.tissoires@redhat.co, hsinyi@google.com, 
	jagan@edgeble.ai, neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 8:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Jun 24, 2024 at 10:19:24PM GMT, Zhaoxiong Lv wrote:
> > Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers t=
o
> > simplify driver's init/enable/exit code.
> >
> > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com=
>
> > ---
> >  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 793 +++++++++---------
> >  1 file changed, 390 insertions(+), 403 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers=
/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > index a9c483a7b3fa..e836260338bf 100644
> > --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > @@ -19,17 +19,13 @@
> >  #include <linux/of.h>
> >  #include <linux/regulator/consumer.h>
> >
> > -#define JD9365DA_INIT_CMD_LEN                2
> > -
> > -struct jadard_init_cmd {
> > -     u8 data[JD9365DA_INIT_CMD_LEN];
> > -};
> > +struct jadard;
> >
> >  struct jadard_panel_desc {
> >       const struct drm_display_mode mode;
> >       unsigned int lanes;
> >       enum mipi_dsi_pixel_format format;
> > -     const struct jadard_init_cmd *init_cmds;
> > +     int (*init)(struct jadard *jadard);
> >       u32 num_init_cmds;
> >  };
> >
> > @@ -50,46 +46,33 @@ static inline struct jadard *panel_to_jadard(struct=
 drm_panel *panel)
> >
> >  static int jadard_enable(struct drm_panel *panel)
> >  {
> > -     struct device *dev =3D panel->dev;
> >       struct jadard *jadard =3D panel_to_jadard(panel);
> > -     struct mipi_dsi_device *dsi =3D jadard->dsi;
> > -     int err;
> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi =
};
> >
> >       msleep(120);
> >
> > -     err =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> > -     if (err < 0)
> > -             DRM_DEV_ERROR(dev, "failed to exit sleep mode ret =3D %d\=
n", err);
> > +     mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> >
> > -     err =3D  mipi_dsi_dcs_set_display_on(dsi);
> > -     if (err < 0)
> > -             DRM_DEV_ERROR(dev, "failed to set display on ret =3D %d\n=
", err);
> > +     mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> >
> > -     return 0;
> > +     return dsi_ctx.accum_err;
> >  }
> >
> >  static int jadard_disable(struct drm_panel *panel)
> >  {
> > -     struct device *dev =3D panel->dev;
> >       struct jadard *jadard =3D panel_to_jadard(panel);
> > -     int ret;
> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi =
};
> >
> > -     ret =3D mipi_dsi_dcs_set_display_off(jadard->dsi);
> > -     if (ret < 0)
> > -             DRM_DEV_ERROR(dev, "failed to set display off: %d\n", ret=
);
> > +     mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> >
> > -     ret =3D mipi_dsi_dcs_enter_sleep_mode(jadard->dsi);
> > -     if (ret < 0)
> > -             DRM_DEV_ERROR(dev, "failed to enter sleep mode: %d\n", re=
t);
> > +     mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> >
> > -     return 0;
> > +     return dsi_ctx.accum_err;
> >  }
> >
> >  static int jadard_prepare(struct drm_panel *panel)
> >  {
> >       struct jadard *jadard =3D panel_to_jadard(panel);
> > -     const struct jadard_panel_desc *desc =3D jadard->desc;
> > -     unsigned int i;
> >       int ret;
> >
> >       ret =3D regulator_enable(jadard->vccio);
> > @@ -109,13 +92,9 @@ static int jadard_prepare(struct drm_panel *panel)
> >       gpiod_set_value(jadard->reset, 1);
> >       msleep(130);
> >
> > -     for (i =3D 0; i < desc->num_init_cmds; i++) {
> > -             const struct jadard_init_cmd *cmd =3D &desc->init_cmds[i]=
;
> > -
> > -             ret =3D mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365D=
A_INIT_CMD_LEN);
>
> This function usesd mipi_dsi_dcs_write_buffer()...
>
> > -             if (ret < 0)
> > -                     return ret;
> > -     }
> > +     ret =3D jadard->desc->init(jadard);
> > +     if (ret)
> > +             return ret;
> >
> >       return 0;
>
> [...]
>
> > +static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
> > +{
> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi =
};
> > +
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
>
> ... while your code uses mipi_dsi_dcs_write_seq_multi(), which
> internally calls mipi_dsi_generic_write_multi(). These two function use
> different packet types to send the payload. To be conservatite, please
> use mipi_dsi_dcs_write_buffer_multi().

Are you certain about this? I see that mipi_dsi_dcs_write_seq_multi()
is just a wrapper on mipi_dsi_dcs_write_buffer_multi(). Specifically,
I see:

#define mipi_dsi_dcs_write_seq_multi(ctx, cmd, seq...)                  \
  do {                                                            \
    static const u8 d[] =3D { cmd, seq };                     \
    mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
  } while (0)

Certainly I could be confused...

-Doug

