Return-Path: <linux-kernel+bounces-314873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F5196BA40
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16751F21F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAE1D9D8F;
	Wed,  4 Sep 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jXmA2nWx"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AD1D47D7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448707; cv=none; b=N6TB/K4O+muzPSuFn3QS2YlvAZk4d6eayWDWe8Mwg/t8Dsz3UZzbDQXl5OvX3vFFJvHX8TEHODzdSiY+koivHEYDGagX8nOQyRG1JW5xYbUjO3FGfncayuR5tEE2i3GaSYd20zPh/38xj3Acug/F7JS3suvLcN3DgAXxDjPyAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448707; c=relaxed/simple;
	bh=Rk1Ly7Ga+B2jlbpkI2ZTPsxktCjzUlFNota40E6xMlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amE6hublASK9XZiiT6F2FNvlqOcxQ5gcjTM6ce36Zlc+W2ZCq0w416veHvWwoKT7NQE7QqKQZNX43qQqLXebFbVxlxQwH91ZRe1HfhLPRFzka8wDqkIjJ3PsC5OLf1Pw6pUHNMhNLbHcydl274oRkYa1hyM4hm/vBZCC2agZ1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=jXmA2nWx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso4212740276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1725448705; x=1726053505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THCoybtCjhxZhory7lq+TeYRAfxYhOty2574FQtkWoM=;
        b=jXmA2nWxWbyANjF9S2cJYKSG9elpVJAWNUwXNNFqTU77iC/qfMkPkth8hZeNhXLW15
         3Pf5ZPQcGauIY/TZ/UtuSY/8nbNFymnYxFcOHOSGyute7mAQI05PlaGmodtCDLMwuWRw
         4dJEaI/3uzl+Mnb2ke0C4K8t9enTfKIg/XLBegvW6OE1WbxCD8odQoA8hMMxNhk4JVTr
         vOeyt4YYJRX2c5HBjsweDCsDV2y9dlYuFEFAnkEbCYPJjHCBdAiC6E0IlGO1ihazcxWw
         fP6GuFOrQuDJThNjW9y27s0Pu4b4YKE3VapiUVdiWgZ40MDck8hLVuW/M0DdXVjY77Iq
         IJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725448705; x=1726053505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THCoybtCjhxZhory7lq+TeYRAfxYhOty2574FQtkWoM=;
        b=A+kIFGzciTOQhRluPGa6GlwB5ZaV9LgRyg9yZ5FVNwM2Dp0jqWpX2uJ7bvRWMYQsqM
         TVYmcM8Vd/BbvvBclSN7i/f/mB7Fh8DMK0s12CKTADyxtL/516+R5hQne9mDMRXMQjuM
         Bp6l4EpYcgOn6DDSnT6GBrLBYZkifFIUAuBsRsqie21jrCFeQ01vxeOL/BX6LDzgBFc1
         WlEZ0jHWLJo+Wi5rMMv+CU21OjIdBS9FxA0aFm7LD6aQWTy6evFK4hglF/i0akajdGJl
         GdyqS+TXtnZpykxVhtwyCtc/3drpUBayHSsfgaVqKtkKcCnH3LzkO25jola7/181qFIA
         XMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4sdumwuuPrHbigmDjlPFaGrjgs1INrM59iV4VB+wNbbH3PCTuZynQbtOLUVOrDn7LumuFHdb+nZeOhCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HUnsUnOW3ETnf78osJNjqqT16RwD4E+S9+dJzYoJi2yaiUKP
	HHwE9OhtwDUxgtHh2s94Qjr9ZfQ3vbXNFIsOMCM4y8t9xOrzgabnNqxgD4HPtZLfOZw/W9XH+QH
	2x1eRLAK0LJtHaTAUPfkFNa7XS8EB3A8xU2pYeg==
X-Google-Smtp-Source: AGHT+IGHwLyRn3KC291dpi3j6eIC+AUeCwsK7HHAdhWXMt49M/gC4aJ25UuW0e/7G89DA17z432TxYT+QHbeAI3HDoo=
X-Received: by 2002:a05:6902:2b04:b0:e1a:732c:d980 with SMTP id
 3f1490d57ef6-e1a7a02d66bmr21532499276.29.1725448704650; Wed, 04 Sep 2024
 04:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-12-robh@kernel.org> <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
In-Reply-To: <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 4 Sep 2024 12:18:07 +0100
Message-ID: <CAPY8ntAv3Xpq45ykwX_98WJKFBxqP6Os+6KvD5xzDTFz8a1idQ@mail.gmail.com>
Subject: Re: [PATCH] drm: vc4: Use of_property_present()
To: Rob Herring <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob

On Tue, 3 Sept 2024 at 20:19, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
> >
> > Use of_property_present() to test for property presence rather than
> > of_find_property(). This is part of a larger effort to remove callers
> > of of_find_property() and similar functions. of_find_property() leaks
> > the DT struct property and data pointers which is a problem for
> > dynamically allocated nodes which may be freed.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Ping!

Sorry, this fell through the cracks.

> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
> > index d57c4a5948c8..049de06460d5 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -2211,7 +2211,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *v=
c4_hdmi)
> >         struct device *dev =3D &vc4_hdmi->pdev->dev;
> >         struct platform_device *codec_pdev;
> >         const __be32 *addr;
> > -       int index, len;
> > +       int index;
> >         int ret;
> >
> >         /*
> > @@ -2234,7 +2234,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *v=
c4_hdmi)
> >         BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) !=3D 0);
> >         BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) !=3D 0);
> >
> > -       if (!of_find_property(dev->of_node, "dmas", &len) || !len) {
> > +       if (!of_property_present(dev->of_node, "dmas")) {

The existing conditional is true if the property is not present or is 0 len=
gth.
Your new one is only true if the property isn't present, so it isn't the sa=
me.

Is there a more appropriate of_ call to return the length of the property?

Thanks
  Dave

> >                 dev_warn(dev,
> >                          "'dmas' DT property is missing or empty, no HD=
MI audio\n");
> >                 return 0;
> > --
> > 2.43.0
> >

