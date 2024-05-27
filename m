Return-Path: <linux-kernel+bounces-190997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7548D054E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0882A1F22B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C917BB22;
	Mon, 27 May 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li6IEBRh"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EE7344A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821064; cv=none; b=N5xVpQzXJPGFx/5gIXvcFMxeuJHMM2irTOqILfyYwTdz36Zw43FViaJ6lqrFCUKNu8gL4JZvv8YgmerOorj9+UMQcTx4SHYH5UUJOVywZ3kAl+cIowqRfVB/ZBKpUReC8BCrCXMU+6TE5mcf0bCqx6V0jhIBSmo5VT4ZdQOj8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821064; c=relaxed/simple;
	bh=naxWkh+jaHwQkl6wdomPYdy1Lu2VRfU+XBoYyk6CnJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kleXGJdsO7qcsYWxGOZfblgg5yOxlgchHS1/7q5vj7/Ztx1iCY8k9kGrLFNrj43T/b97Kjn3Ye3r+RKe7zUR81Zl9P8GJfyVsd/PTKzicZIPoVfJwx1zHAK9L5FxZ8gtoBf0rxIZPcmISmFlMNYHr/SjeMESVFtDDNVnV4936rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li6IEBRh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso609058a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716821062; x=1717425862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33epQlN6HkJRhJOgQtZxq9FfffiSVKippP5QOan7qrs=;
        b=Li6IEBRhkqB5Z+tqwQEI7BhwKaKpWryxucIY2Fn9vXobMWjxpz3uqagmN9ciFh4wwZ
         TFWnp9pAEMpU0+BqJenpql0hB1768q/zV1kAidpyr82Bru+9ysFYR/oAAZkn72CizsL6
         1sTQbUeJlQYcSuaMLHBElrhArobapsQbZnucWc8fVQZ65yzgYbkWvD5IaZt26AWQop3o
         57lWl95ejGO+6FKnlBT3GJuwvJgSWLr/Djrh32VqWU2DPBoWMY9Cj2Kr4wCMUI+wmxzj
         4WwDmE8fs8wxyknRgWKGvRTTpj3Tr/XQarZkMVGXAbNpXV6O7yis+V+K4hnq7s+lEXmR
         3wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821062; x=1717425862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33epQlN6HkJRhJOgQtZxq9FfffiSVKippP5QOan7qrs=;
        b=HVaYtUeUwoVrDprnEfgxXnPmAEocqFDObcbHCI+B4+4VTAyy7lJeSrKpB6TsQxshxb
         wYpPcesF1s5X8XVG1zmoFfnvGfpUp/mokgOIYlIh2jEC+lAknhFljHEa9Cva8D+jyYQa
         UDfu6omM96q+Ng49fGjx3jaL9WKDKWjCayDGMCoqKTMLmE24ETDm+WZU5Wt4jnqWAA9D
         JAiH7lknZDMI7NjNswpM82FgtdM5im17QsKBxWcw9Of8P4Y8XfjuNVEsbO164ffiJ71m
         jf7NNrZDVTlEQdJJ1fK3RrpcjhbFjFebRrFZj7uFFr7H4p5Xv5UZyWqtxKSw1ihCPHIk
         K2og==
X-Forwarded-Encrypted: i=1; AJvYcCXmYkDH0wHJDMdr49ksPSrRVmB2FNJSNEr9/tyciaTIA7FEP6FbdlTX7DajG6TVIvCZktxFPVEYlrIjy5CNf0q7L+mAVFzDnqQxxJEt
X-Gm-Message-State: AOJu0YyVDxADOkGqFNc+GkEMpj0XX7hlDFVPMeGB358tz3B3Rzo4mPDo
	zCuzWCpvHGdeOq1OkMuZhQTF+IMmA32c3UKfs8ShBOoB48W/gWZZG/cYBv3l8PAZu+sn0H2anho
	ExuG3u7uu1ZGxDG6tJhJhfD9Z+SheuQ==
X-Google-Smtp-Source: AGHT+IFm4UmAs6X0gy4NyYZ2+/6TjuN/HpBLYgaJx0duaa4fvNf+tI9o8AmCS25QUej7Si8DFMKmmT76q4H8I9wXtHA=
X-Received: by 2002:a17:90b:1085:b0:2bd:ec55:9f38 with SMTP id
 98e67ed59e1d1-2bf5ee1ff20mr8201233a91.29.1716821062404; Mon, 27 May 2024
 07:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142311.3053-1-mario.limonciello@amd.com>
In-Reply-To: <20240527142311.3053-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 May 2024 10:44:10 -0400
Message-ID: <CADnq5_MxA3JkUkYfu7baP30NKs1W49w-AEA8fM3W+XbTEMdOXw@mail.gmail.com>
Subject: Re: [PATCH] drm/client: Detect when ACPI lid is closed during initialization
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	Chris Bainbridge <chris.bainbridge@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:32=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If the lid on a laptop is closed when eDP connectors are populated
> then it remains enabled when the initial framebuffer configuration
> is built.
>
> When creating the initial framebuffer configuration detect the ACPI
> lid status and if it's closed disable any eDP connectors.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_c=
lient_modeset.c
> index 31af5cf37a09..b76438c31761 100644
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
> @@ -257,6 +258,27 @@ static void drm_client_connectors_enabled(struct drm=
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
> +               if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP=
 || !enabled[i])

Might want to check for LVDS here as well since a lot of laptops used
LVDS prior to eDP.

Alex

> +                       continue;
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
> @@ -844,6 +866,7 @@ int drm_client_modeset_probe(struct drm_client_dev *c=
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

