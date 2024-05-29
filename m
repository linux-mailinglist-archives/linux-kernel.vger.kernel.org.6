Return-Path: <linux-kernel+bounces-194161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221228D37B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE558286072
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C3B12E5B;
	Wed, 29 May 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5MAzU1A"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6FC2ED
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989624; cv=none; b=RfVs6wtj225r4d7pJtEtWu90fg+8foRfTzDM8kc/OnAaMZv5dz+BIGSOWtosvJ5Z79+mqun/0G1nJv3fYvuYQz+rcpETnnPuJzl1TkZiJ1tW0Y8iYpMWTlBu/8QRG5IGJBhBGAvYG5E3QKGyn7I91Dn/YytVrSO9KjtIOzhIB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989624; c=relaxed/simple;
	bh=sa3SsgwWNNcuvc/K/Rval+Kz3Sdsqy57y2eUK4QV1B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry4VAw7xQOw0AMJXg6iJp0yz7sKZ5+ryrzR7BhT3o+yJqMEv4ldNomOATVQyQfBJW82fLCa8/20KfQ2b34MMgzDytMG3fJLSyY3T5VCA84EgC3q8d/tcjKi/cjapmkgfAMMaKRH3SJKAQh3APbD+wOt2/J6SVLlcraKSMd746iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5MAzU1A; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f8eba8dcfcso1586637b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716989623; x=1717594423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7ILJRHnZgMzPyXPFW/iuFELnWd2RBDR56tTLeE9Yro=;
        b=H5MAzU1A9PH2J3QFHzI1z4N7mE0QaPOLG7hXPM//Slg+MeQ79KkHodt/FQu++u8Z+E
         jwHgzZx14vKlY7hHXtoCT+sNOQ6fLybEMVsrXTDcQ1TlP7TI9soN4BLb0XMooFUAwzeF
         Tlx9i9QgUU6PL1q6u32sXKNcDnDLsEv+kKc38IOO21Yn+XPDXlNBmPAtcqfAjUM6SAoD
         37t8rg04x43KwTZmZpm3NMoDpj9GQ/nzBpONstpl/9OwBwl7Vyib190TLbFqVz5Xzn5X
         NNpZYoFgoX9iyMvuMdh+4XFiQ0NF8qj1vaa/feww3TAE29VuITbJmqT1tnNcFZdmnO7k
         UoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989623; x=1717594423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7ILJRHnZgMzPyXPFW/iuFELnWd2RBDR56tTLeE9Yro=;
        b=Nk64gLPGNfUGBk3VfUgXenDPOfFtPno3hRGxW7iKYFRELbsPxvRlv00W3QoA2YSjt3
         mJC1EUuivGlrNjCUNwtpIjSWUtiMujHy21bXcFIpFn76yeAJ8P/dfKkLlLrgo9CARpWR
         MSXDpwwPbVGfBfBKdwnjoP/UoRd7+KTnRuNxgdM+7feogqaDlCHkyRAbPNDV7FcHrxsy
         F9K8L5yAQPWeG0SsVdLVtajJNzoKUaTkcTIslhri6c1DpLhXDiTIZweZY8FmMcjmgrxa
         cZZZxd9OJMfZZeQ7cTeMXka9r29vPe4y/KeldMu7kpZYVb36/G3qpghzdJUJLyNQ4gir
         0nAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT3uM8fu68OvtCH+bsol3Hg+iAgGq7o5vHKsQBnt1Ipu4QMPIYWqA5i+7nYuYSjG+aR4V+Xs6EGPBEL8wdOJg31DtRcGcmvsnP/C5o
X-Gm-Message-State: AOJu0Yyfe/LdeWwW6cGZ9XTH7A9ZK1zPOB6rkEDzXrD8fFIcBYHgu5ZF
	aJkyvmJ4eZchC2yy+nr7b/v5qVVnWibHZTG2+18y7gsYs2TdotpcQHgLKCtaPr558sj0Coid1V/
	9Jbj5dlIQhq1qRMMQ6al7cKJKDt6mVg==
X-Google-Smtp-Source: AGHT+IFouSqDbAzwBwM150OLwdPpTSB7m1v7Y6wLzV8Q4/OAKVxtUZrrKGrd7wE1YwGWYAvClEiQIVSFK8A+NznddFk=
X-Received: by 2002:a17:902:e5c5:b0:1f4:b43f:9c01 with SMTP id
 d9443c01a7336-1f4b43f9d2bmr86352715ad.64.1716989622493; Wed, 29 May 2024
 06:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528210319.1242-1-mario.limonciello@amd.com>
In-Reply-To: <20240528210319.1242-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 May 2024 09:33:31 -0400
Message-ID: <CADnq5_OzPT1MVnsqXs2vjr1L2_6jeM6x7jgs4ZtYpNzdDHM6uA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during initialization
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Chris Bainbridge <chris.bainbridge@gmail.com>, 
	hughsient@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:03=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If the lid on a laptop is closed when eDP connectors are populated
> then it remains enabled when the initial framebuffer configuration
> is built.
>
> When creating the initial framebuffer configuration detect the ACPI
> lid status and if it's closed disable any eDP connectors.
>
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Do you have drm-misc access or do you need someone to apply this for you?

Alex

> ---
> Cc: hughsient@gmail.com
> v1->v2:
>  * Match LVDS as well
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_c=
lient_modeset.c
> index 31af5cf37a09..0b0411086e76 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include "drm/drm_modeset_lock.h"
> +#include <acpi/button.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -257,6 +258,34 @@ static void drm_client_connectors_enabled(struct drm=
_connector **connectors,
>                 enabled[i] =3D drm_connector_enabled(connectors[i], false=
);
>  }
>
> +static void drm_client_match_edp_lid(struct drm_device *dev,
> +                                    struct drm_connector **connectors,
> +                                    unsigned int connector_count,
> +                                    bool *enabled)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < connector_count; i++) {
> +               struct drm_connector *connector =3D connectors[i];
> +
> +               switch (connector->connector_type) {
> +               case DRM_MODE_CONNECTOR_LVDS:
> +               case DRM_MODE_CONNECTOR_eDP:
> +                       if (!enabled[i])
> +                               continue;
> +                       break;
> +               default:
> +                       continue;
> +               }
> +
> +               if (!acpi_lid_open()) {
> +                       drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed=
, disabling\n",
> +                                   connector->base.id, connector->name);
> +                       enabled[i] =3D false;
> +               }
> +       }
> +}
> +
>  static bool drm_client_target_cloned(struct drm_device *dev,
>                                      struct drm_connector **connectors,
>                                      unsigned int connector_count,
> @@ -844,6 +873,7 @@ int drm_client_modeset_probe(struct drm_client_dev *c=
lient, unsigned int width,
>                 memset(crtcs, 0, connector_count * sizeof(*crtcs));
>                 memset(offsets, 0, connector_count * sizeof(*offsets));
>
> +               drm_client_match_edp_lid(dev, connectors, connector_count=
, enabled);
>                 if (!drm_client_target_cloned(dev, connectors, connector_=
count, modes,
>                                               offsets, enabled, width, he=
ight) &&
>                     !drm_client_target_preferred(dev, connectors, connect=
or_count, modes,
> --
> 2.43.0
>

