Return-Path: <linux-kernel+bounces-446340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521409F2311
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A4918860BC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4281487D5;
	Sun, 15 Dec 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWoSju31"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBC20322
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734257062; cv=none; b=aQz+5Ygd0OPcHoTgtDeIsk1Ql848RQif4cysojw26bnnMphmN7DIpV5mKbyYZvRw8fFSkFTCM2x86xklf5DqGk0c5eGrW9eASwcm02peX+h7VSsSo/aWia/p0VKUqUX2xmy96Lh4r56M62uA6P9MwGdlTOCfgPoZY0OdV8iO/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734257062; c=relaxed/simple;
	bh=H1G7IHH91ROrvN04mtHIkuzWgAcWgDT7IbRdPfWfXTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf+9vyV/6mB41sBDGU/g/h47NwoPJne+6GBn4tGLyY5teIWyGehldAXP1y+qmAdGO2sPgZ9ZL/PIbRkUZSs76WhcT6XxJsn2YOBhL817OZ4HO/s7CIfPiuujxkBhWILjRB2phbuoP5jhwVAYGl+Fqvo2wPJAe0uxx5exQvvMXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWoSju31; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso2275855276.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734257059; x=1734861859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAJaArqx1AqZ8QGrFyJcHuUfAcUCD/Ft5r8EKpL5/Vc=;
        b=CWoSju3144NveESCNn5i3QRX52ML38OsfrfTWHDB9sCtR1SbUsqCngMcfXznvZsG4b
         BqFTjpIuZmeTuzxTXi013Bz81jrZvC/qlOn9voSMOIDLYQHPN/7qi6P1PtVYmW3Y4isw
         5/xNnNrueA7Oe2WvbeqEEi8gc7dj5k1b0JwI9AltOJoCmmAlLpPu54u151laJcsy99bx
         LEeUEZ99Qrho0CXhF+EA9qjE8+fKSoDaPt5Vd1X1xLU/gKmyz3GlD0LF5CHiEXbUa7Db
         oNxxAS+kf9D8eOlOXZ3+J12KMsNVFZ/wdwHmJS4gRSajHYtf415XkB1r5IWrIeTgs322
         +XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734257059; x=1734861859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAJaArqx1AqZ8QGrFyJcHuUfAcUCD/Ft5r8EKpL5/Vc=;
        b=jKCCIynQ/WbLG3rTAtPf99BpJUcjbKSsfkz5vJmYZZJwjNHzR0dua8zQelCc8nrqRJ
         T4pK9byLUWo8njn9i3nxWg3mzaugczrYQSZ7u6p+S3vHdG+3xNE9B4wWKMQUDHQarCmX
         Bj0GJxa72VO8WmovReO7zSp4c3O33qZ9J6BVk8h0UusLjyxkxUe41Q6kXSEAel3/DYJy
         VtxThHIjemzdtXGDmNGTF5hyMaKN/YO58+rnY1hUc5oEiFDmFo++6JuTZda1b5db3/Mq
         993iCSlnC5q4B5a8Tu5MWG1iVCvu3RN8WXTp3x9/G3BGOu5Azuv0cd3I30S3y1bksSR0
         Elyg==
X-Forwarded-Encrypted: i=1; AJvYcCW9hNyDln1ohvKrP6c1qUf1kJqmyUZdXUC0yj31St1WjZgOE6MCnIuOVOul1v9A1NP8RwzmHqz7MUDJZsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQa/X14srmv3/kcdipwz2tTj9+drST6b1caofQdFPerEC5ARd
	wHf0x5RIEZ2+XOCKLag/oWDXKxDz/Viq8/B6oFH6LViXu+Ryhqmz1dJ7EFM1v+62nKKgtJIY0H6
	bG3y6zGksUzmBeRjJQ/Dh1ZvtjenWdbz/J7b04A==
X-Gm-Gg: ASbGncunYLuZ0I5iZA8VlWAmGXmYfFYnPgmmtC5UcM0L5c9hzQK7MjB1VV/WbhtCObh
	fMBZHEslpzM5ENoYjD1NpRZ0yLcrV9hsVZWWs17ZgfMT3Rq7dY1Zy
X-Google-Smtp-Source: AGHT+IHgTkQqA70oc1CspI5s9VcIDPdAJpQqn9sPiYRcvYJyJgYEC6tFCFhWhgBRPZreJLjJWD+59s/yaSBXx14HJfs=
X-Received: by 2002:a05:6902:1105:b0:e4c:2726:e67e with SMTP id
 3f1490d57ef6-e4c27270453mr464529276.26.1734257059049; Sun, 15 Dec 2024
 02:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org>
 <20241214-nouveau-encoder-slave-v1-2-beda767472e3@linaro.org> <20241214203604.GD8294@pendragon.ideasonboard.com>
In-Reply-To: <20241214203604.GD8294@pendragon.ideasonboard.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 15 Dec 2024 12:04:08 +0200
Message-ID: <CAA8EJpqyhmmf_S4jDRgyV0rjTnN3BiaKZQ_yg3Mnqd8xNzw0nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/nouveau: vendor in drm_encoder_slave API
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 22:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Dmitry,
>
> Thank you for the patch.
>
> On Sat, Dec 14, 2024 at 05:35:45PM +0200, Dmitry Baryshkov wrote:
> > Nouveau driver is the only user of the drm_encoder_slave API. Rework
> > necessary bits of drm_encoder_slave into the nouveau_i2c_encoder API and
> > drop drm_encoder_slave.c from the DRM KMS helper.
> >
> > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/Makefile                           |   1 -
> >  drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   1 +
> >  drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  10 +-
> >  drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c  |  30 +++---
> >  drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c |   8 +-
> >  drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h |   4 +-
> >  drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c  |  30 +++---
> >  .../dispnv04/nouveau_i2c_encoder.c}                |  85 +++++-----------
> >  drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  18 ++--
> >  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   4 +-
> >  .../gpu/drm/nouveau/include/i2c/encoder_i2c.h      | 108 ++++++++-------------
> >  drivers/gpu/drm/nouveau/nouveau_connector.c        |   6 +-
> >  drivers/gpu/drm/nouveau/nouveau_encoder.h          |  13 +--
> >  13 files changed, 127 insertions(+), 191 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 19fb370fbc56772077973c864df71e4b8e0bf99b..85af94bb907d6cdbad7078e2667426e479b1069f 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -135,7 +135,6 @@ drm_kms_helper-y := \
> >       drm_atomic_state_helper.o \
> >       drm_crtc_helper.o \
> >       drm_damage_helper.o \
> > -     drm_encoder_slave.o \
> >       drm_flip_work.o \
> >       drm_format_helper.o \
> >       drm_gem_atomic_helper.o \
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/Kbuild b/drivers/gpu/drm/nouveau/dispnv04/Kbuild
> > index 949802882ebd53c15e124c218a092af9693d36bc..4c7bc6bb81b325ac22286372b0a3e4f1390e78be 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/Kbuild
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/Kbuild
> > @@ -6,6 +6,7 @@ nouveau-y += dispnv04/dac.o
> >  nouveau-y += dispnv04/dfp.o
> >  nouveau-y += dispnv04/disp.o
> >  nouveau-y += dispnv04/hw.o
> > +nouveau-y += dispnv04/nouveau_i2c_encoder.o
> >  nouveau-y += dispnv04/overlay.o
> >  nouveau-y += dispnv04/tvmodesnv17.o
> >  nouveau-y += dispnv04/tvnv04.o
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/dfp.c b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> > index 28a42ab5cb900ebe8a526e154f9e90598333356c..e211602298a5fb9f513203720b3ee5d37cd21122 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> > @@ -171,7 +171,7 @@ static struct drm_encoder *get_tmds_slave(struct drm_encoder *encoder)
> >       list_for_each_entry(slave, &dev->mode_config.encoder_list, head) {
> >               struct dcb_output *slave_dcb = nouveau_encoder(slave)->dcb;
> >
> > -             if (slave_dcb->type == DCB_OUTPUT_TMDS && get_slave_funcs(slave) &&
> > +             if (slave_dcb->type == DCB_OUTPUT_TMDS && get_encoder_i2c_funcs(slave) &&
> >                   slave_dcb->tmdsconf.slave_addr == dcb->tmdsconf.slave_addr)
> >                       return slave;
> >       }
> > @@ -473,7 +473,7 @@ static void nv04_dfp_commit(struct drm_encoder *encoder)
> >       /* Init external transmitters */
> >       slave_encoder = get_tmds_slave(encoder);
> >       if (slave_encoder)
> > -             get_slave_funcs(slave_encoder)->mode_set(
> > +             get_encoder_i2c_funcs(slave_encoder)->mode_set(
> >                       slave_encoder, &nv_encoder->mode, &nv_encoder->mode);
> >
> >       helper->dpms(encoder, DRM_MODE_DPMS_ON);
> > @@ -614,8 +614,8 @@ static void nv04_dfp_destroy(struct drm_encoder *encoder)
> >  {
> >       struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> >
> > -     if (get_slave_funcs(encoder))
> > -             get_slave_funcs(encoder)->destroy(encoder);
> > +     if (get_encoder_i2c_funcs(encoder))
> > +             get_encoder_i2c_funcs(encoder)->destroy(encoder);
> >
> >       drm_encoder_cleanup(encoder);
> >       kfree(nv_encoder);
> > @@ -649,7 +649,7 @@ static void nv04_tmds_slave_init(struct drm_encoder *encoder)
> >       if (type < 0)
> >               return;
> >
> > -     drm_i2c_encoder_init(dev, to_encoder_slave(encoder),
> > +     nouveau_i2c_encoder_init(dev, to_encoder_i2c(encoder),
> >                            &bus->i2c, &info[type].dev);
> >  }
> >
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
> > index 131512a5f3bd996ad1e2eb869ffa09837daba0c7..c9249b58e65459ae61898a246c36da2c3bfe0844 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
> > @@ -47,14 +47,14 @@ static void ch7006_encoder_destroy(struct drm_encoder *encoder)
> >       drm_property_destroy(encoder->dev, priv->scale_property);
> >
> >       kfree(priv);
> > -     to_encoder_slave(encoder)->slave_priv = NULL;
> > +     to_encoder_i2c(encoder)->encoder_i2c_priv = NULL;
> >
> > -     drm_i2c_encoder_destroy(encoder);
> > +     nouveau_i2c_encoder_destroy(encoder);
> >  }
> >
> >  static void  ch7006_encoder_dpms(struct drm_encoder *encoder, int mode)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       struct ch7006_state *state = &priv->state;
> >
> > @@ -71,7 +71,7 @@ static void  ch7006_encoder_dpms(struct drm_encoder *encoder, int mode)
> >
> >  static void ch7006_encoder_save(struct drm_encoder *encoder)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >
> >       ch7006_dbg(client, "\n");
> > @@ -81,7 +81,7 @@ static void ch7006_encoder_save(struct drm_encoder *encoder)
> >
> >  static void ch7006_encoder_restore(struct drm_encoder *encoder)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >
> >       ch7006_dbg(client, "\n");
> > @@ -116,7 +116,7 @@ static void ch7006_encoder_mode_set(struct drm_encoder *encoder,
> >                                    struct drm_display_mode *drm_mode,
> >                                    struct drm_display_mode *adjusted_mode)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       struct ch7006_encoder_params *params = &priv->params;
> >       struct ch7006_state *state = &priv->state;
> > @@ -179,7 +179,7 @@ static void ch7006_encoder_mode_set(struct drm_encoder *encoder,
> >  static enum drm_connector_status ch7006_encoder_detect(struct drm_encoder *encoder,
> >                                                      struct drm_connector *connector)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       struct ch7006_state *state = &priv->state;
> >       int det;
> > @@ -285,7 +285,7 @@ static int ch7006_encoder_set_property(struct drm_encoder *encoder,
> >                                      struct drm_property *property,
> >                                      uint64_t val)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       struct ch7006_state *state = &priv->state;
> >       struct drm_mode_config *conf = &encoder->dev->mode_config;
> > @@ -370,7 +370,7 @@ static int ch7006_encoder_set_property(struct drm_encoder *encoder,
> >       return 0;
> >  }
> >
> > -static const struct drm_encoder_slave_funcs ch7006_encoder_funcs = {
> > +static const struct nouveau_i2c_encoder_funcs ch7006_encoder_funcs = {
> >       .set_config = ch7006_encoder_set_config,
> >       .destroy = ch7006_encoder_destroy,
> >       .dpms = ch7006_encoder_dpms,
> > @@ -437,7 +437,7 @@ static int ch7006_resume(struct device *dev)
> >
> >  static int ch7006_encoder_init(struct i2c_client *client,
> >                              struct drm_device *dev,
> > -                            struct drm_encoder_slave *encoder)
> > +                            struct nouveau_i2c_encoder *encoder)
> >  {
> >       struct ch7006_priv *priv;
> >       int i;
> > @@ -448,8 +448,8 @@ static int ch7006_encoder_init(struct i2c_client *client,
> >       if (!priv)
> >               return -ENOMEM;
> >
> > -     encoder->slave_priv = priv;
> > -     encoder->slave_funcs = &ch7006_encoder_funcs;
> > +     encoder->encoder_i2c_priv = priv;
> > +     encoder->encoder_i2c_funcs = &ch7006_encoder_funcs;
> >
> >       priv->norm = TV_NORM_PAL;
> >       priv->select_subconnector = DRM_MODE_SUBCONNECTOR_Automatic;
> > @@ -495,7 +495,7 @@ static const struct dev_pm_ops ch7006_pm_ops = {
> >       .resume = ch7006_resume,
> >  };
> >
> > -static struct drm_i2c_encoder_driver ch7006_driver = {
> > +static struct nouveau_i2c_encoder_driver ch7006_driver = {
> >       .i2c_driver = {
> >               .probe = ch7006_probe,
> >               .remove = ch7006_remove,
> > @@ -516,12 +516,12 @@ static struct drm_i2c_encoder_driver ch7006_driver = {
> >
> >  static int __init ch7006_init(void)
> >  {
> > -     return drm_i2c_encoder_register(THIS_MODULE, &ch7006_driver);
> > +     return i2c_add_driver(&ch7006_driver.i2c_driver);
> >  }
> >
> >  static void __exit ch7006_exit(void)
> >  {
> > -     drm_i2c_encoder_unregister(&ch7006_driver);
> > +     i2c_del_driver(&ch7006_driver.i2c_driver);
> >  }
> >
> >  int ch7006_debug;
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c
> > index 6afe6d0ee6306db57c3e3bafe2bf1b0b1b49aea5..e58d94451959a2afc01f570ea620d8e6721cb7af 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c
> > @@ -198,7 +198,7 @@ const struct ch7006_mode *ch7006_lookup_mode(struct drm_encoder *encoder,
> >
> >  void ch7006_setup_levels(struct drm_encoder *encoder)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       uint8_t *regs = priv->state.regs;
> >       const struct ch7006_tv_norm_info *norm = &ch7006_tv_norms[priv->norm];
> > @@ -229,7 +229,7 @@ void ch7006_setup_levels(struct drm_encoder *encoder)
> >
> >  void ch7006_setup_subcarrier(struct drm_encoder *encoder)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       struct ch7006_state *state = &priv->state;
> >       const struct ch7006_tv_norm_info *norm = &ch7006_tv_norms[priv->norm];
> > @@ -253,7 +253,7 @@ void ch7006_setup_subcarrier(struct drm_encoder *encoder)
> >
> >  void ch7006_setup_pll(struct drm_encoder *encoder)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       uint8_t *regs = priv->state.regs;
> >       const struct ch7006_mode *mode = priv->mode;
> > @@ -324,7 +324,7 @@ void ch7006_setup_power_state(struct drm_encoder *encoder)
> >
> >  void ch7006_setup_properties(struct drm_encoder *encoder)
> >  {
> > -     struct i2c_client *client = drm_i2c_encoder_get_client(encoder);
> > +     struct i2c_client *client = nouveau_i2c_encoder_get_client(encoder);
> >       struct ch7006_priv *priv = to_ch7006_priv(encoder);
> >       struct ch7006_state *state = &priv->state;
> >       const struct ch7006_tv_norm_info *norm = &ch7006_tv_norms[priv->norm];
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
> > index c66ca7f525034bb9fd113c5edf10c371a01c3c79..a62387ae3af11163cbd64317686a8be5a4f4011c 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
> > @@ -27,9 +27,9 @@
> >  #ifndef __DRM_I2C_CH7006_PRIV_H__
> >  #define __DRM_I2C_CH7006_PRIV_H__
> >
> > -#include <drm/drm_encoder_slave.h>
> >  #include <drm/drm_probe_helper.h>
> >
> > +#include <i2c/encoder_i2c.h>
> >  #include <i2c/ch7006.h>
>
> I don't have a strong opinion on the nouveau driver internals, but I
> think
>
> #include <dispnv04/i2c/encoder_i2c.h>
> #include <dispnv04/i2c/ch7006.h>
>
> could be less ambiguous. Up to you and the nouveau maintainers.

Good question. I'll post v2, fixing the missing Kconfig in patch 1 and
keeping existing includes, but I'm open to the feedback from nouveau
maintainers.

-- 
With best wishes
Dmitry

