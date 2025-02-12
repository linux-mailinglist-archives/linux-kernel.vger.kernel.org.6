Return-Path: <linux-kernel+bounces-511523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5AA32C38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8E18824EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6B21D59F;
	Wed, 12 Feb 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JqnA1Bwg"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6A1D5176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378780; cv=none; b=jKcutmtKZ5t4jg9MknLmliQDYP8EZmdtDE6N4KrKnuyjcVe1Body2mOV4SVOXdPj8Ie0q5sNrgdIe5Zsi/Ulrcxxn6OCDJG4dzK0KsWmsZKvTCsdq4LiY3I+ydeOAI2YzAK1JgzDkkP45upNTb4svSPH7FVkTXqRo7396fOedYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378780; c=relaxed/simple;
	bh=BULMItlD7UmqT+FeS+xvhAotN9kxf42G+uPp6a158Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKwk70aScvyW10piaTTE02Pt35LjYRqpcFp6YqHI5jn/qJ3TWPpQ4jAjg18n5sKKrtEvk93rlUF8tadg43tOy7kyXLmBOjAFlaudLMy7uTExysQWINaaric05RBVM8vcoyk61dM6C/ENOarErIjR6+0VFtkxa4WlifQiFDCV8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JqnA1Bwg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7c81b8681so533871366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739378776; x=1739983576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/UVNzfG26hpAhqe/4xRhycTEgEJVFinn+tffb17O7s=;
        b=JqnA1Bwg6SIspD05J8fr5aitVGwR13zgXimBa2KJCJUYpJ9eD/zqDRuo9BOK9aoW77
         I5ChQOhChpogSxsj5O3W7NyvlYKEx//TMABJDOST2+cxTm31fqIIRzmJQaIuRbX0gyFx
         uoo4a4zUDzQv7UUenvYuOww3RqfjJTJIe0VB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378776; x=1739983576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/UVNzfG26hpAhqe/4xRhycTEgEJVFinn+tffb17O7s=;
        b=rYeJ27Pob/vxtHyJRP5J6/mX28n2EGQGFCPlI3stFe564vQlnGSXUS2/ALI42nvsVy
         NlrnndZ7+HU/KJSh8e8qvDyDzRu6DWNejEFUez3j5DA7JGgsUfmFbeYjYWHzjuNQk8+B
         iNOs4tGPkBUa2kk6mnT4CZDJvTQ6Jt5wBkev6TqRYgFwPSkv0if17+xjujPJ1x0rG8WG
         igKhsz8CjGuxa6BcsR+EdoqfrYgaTgAuE4wVPsJWOFEafa009ie+kLvLeBgBSzof3iqG
         MXd/NtDCgThHNJ0fG4dWKCR8xWRIWcwip8VfD/S6nuJXIJPs9Vs9cng3WXSm4ITXTiCE
         3xfw==
X-Forwarded-Encrypted: i=1; AJvYcCVbhDFUot/NPQt03pT8o1PlKtZqa84kQbe2SBLiXuu05VeCrMbOiR+3Pdrj6KfdiaA2uFby8kt4/UCTF2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREZAHjYt1+8syzv/YQjvJlu5YASK7gcgFIZFIrDiwXr32NQ2e
	jpntmrTfWX1bhwVwWWjnJ1XT/HBfCxEdR6rdYbDpwja99Gz71q3cOeI3NSCA46B3aIZ51uiy0h+
	k4csR
X-Gm-Gg: ASbGncu+/ofTFbf8xQI77aYkKvZ1VEuRmrspA2aFSZlrrcW26asvOGAzquUz9x7tYJ0
	h2ky7lF3+HsM3oJmODoJ02G2Og1ypD49ChnERHO7YKkUwm64E0U8DHWljVSf+iJTz+wCcdjssD1
	wdXmdYFLC9dPU9Z/pTg/Bfxwz/z+Uj4mAtz/4k+t7laZbkI8GpVxt2sInEyJkY0pjSFNGv3GL2J
	4gGAHtmeNap3lpbXzX9X2/5beOOKeW+Ccl0NDIwZ674XbsSiMNJPOBmqv+I2XGwp7OSpTiIEAtp
	w8bR/cwZqcZORJ6OEBKO/vZeB+TrdqAsA/MlRr0eAxnf/MMV6DOfrgU=
X-Google-Smtp-Source: AGHT+IH21h8dmCi4iNZo4eX/9PVOAl3jDF0fCn9qQzTh7NI9CLnJePI+WBMytsazM3fjLWWYaCI9CQ==
X-Received: by 2002:a17:907:28d1:b0:ab9:63bd:91be with SMTP id a640c23a62f3a-ab963bd9feamr30650766b.3.1739378775915;
        Wed, 12 Feb 2025 08:46:15 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78d5771easm1121532166b.83.2025.02.12.08.46.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:46:14 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso9213839a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:46:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzdYF+rFK8T09fWU4C00iq1Trws0Yy29z9efZwW97rDEZUVDWO+FNEK8Q6YzR6F5CKpEdkN0wTtVWUqoU=@vger.kernel.org
X-Received: by 2002:a05:6512:1195:b0:545:9e1:e824 with SMTP id
 2adb3069b0e04-545184bc12fmr1571346e87.48.1739378317154; Wed, 12 Feb 2025
 08:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-aux-device-create-helper-v3-0-7edb50524909@baylibre.com> <20250211-aux-device-create-helper-v3-3-7edb50524909@baylibre.com>
In-Reply-To: <20250211-aux-device-create-helper-v3-3-7edb50524909@baylibre.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Feb 2025 08:38:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WQsFzAmpcqSG-eAm6SW-i3Q7EdbxEKyuhyovVXVRxC8A@mail.gmail.com>
X-Gm-Features: AWEUYZnEAQCx0nU_sk8MYOvtfC7Gu1h5Zsl0lbrfbQPnQTV4y2laVQqsVCR6NTE
Message-ID: <CAD=FV=WQsFzAmpcqSG-eAm6SW-i3Q7EdbxEKyuhyovVXVRxC8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drm/bridge: ti-sn65dsi86: use the auxiliary device
 creation helper
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	platform-driver-x86@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 11, 2025 at 9:28=E2=80=AFAM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> The auxiliary device creation of this driver is simple enough to
> use the available auxiliary device creation helper.
>
> Use it and remove some boilerplate code.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 84 +++++++++--------------------=
------
>  1 file changed, 20 insertions(+), 64 deletions(-)

Thanks for creating the helpers and getting rid of some boilerplate!
This conflicts with commit 574f5ee2c85a ("drm/bridge: ti-sn65dsi86:
Fix multiple instances") which is in drm-next, though. Please resolve.

Since nothing here is urgent, I would assume patch #1 would land and
then we'd just wait until it made it to mainline before landing the
other patches in their respective trees?


> -static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
> -                                      struct auxiliary_device **aux_out,
> -                                      const char *name)
> -{
> -       struct device *dev =3D pdata->dev;
> -       struct auxiliary_device *aux;
> -       int ret;
> -
> -       aux =3D kzalloc(sizeof(*aux), GFP_KERNEL);
> -       if (!aux)
> -               return -ENOMEM;
> -
> -       aux->name =3D name;
> -       aux->dev.parent =3D dev;
> -       aux->dev.release =3D ti_sn65dsi86_aux_device_release;
> -       device_set_of_node_from_dev(&aux->dev, dev);
> -       ret =3D auxiliary_device_init(aux);
> -       if (ret) {
> -               kfree(aux);
> -               return ret;
> -       }
> -       ret =3D devm_add_action_or_reset(dev, ti_sn65dsi86_uninit_aux, au=
x);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D auxiliary_device_add(aux);
> -       if (ret)
> -               return ret;
> -       ret =3D devm_add_action_or_reset(dev, ti_sn65dsi86_delete_aux, au=
x);
> -       if (!ret)
> -               *aux_out =3D aux;

I notice that your new code has one fewer devm_add_action_or_reset()
than the code here which you're replacing. That means it needs to call
"uninit" explicitly in one extra place. It still seems clean enough,
though, so I don't have any real objections to the way you're doing it
there. ;-)

-Doug

