Return-Path: <linux-kernel+bounces-266323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC493FE23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E76D1F23204
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E4187343;
	Mon, 29 Jul 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FhnctADx"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00831146585
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280610; cv=none; b=JC6cODWKLbvwTkiwU/XP+skUwRf/cc8a8OjkTPnFfKIMnCRU/qvKCJywJnrAOXnJc2+WxbiaBpwZjwaLW6jn7sZY7Y+eoX2loCShMPiO8Y2NiXRlyK2+nXy9ME5IEMoouNr3JWB+GIOXNe7vJzla5Znha1LYdEVACXTMBHWaGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280610; c=relaxed/simple;
	bh=LVVYNh/Q/hDL+l5YEn1iSdbdD0THwuE3gCmjKeRGc4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpMx367/L0Z/wgSWAB9eDI18AFVOD7+wSB4EeNB+/ylDYAnfhyrUhxWC4wpsOGdDDBeCadhVY6Ecxfy7A991Ij9GXfobCrwd+tUtclllStnNS0qTioR575aEZtqcDnM5zAl/ObZHKYNGPW0SBlt2AMHILeNHDwrcPfG1gODmz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FhnctADx; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfdb6122992so1995100276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722280608; x=1722885408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aSdBNepOuMwe3ip16SyZwC9x3sQ/b3cOtgS+xLwo54=;
        b=FhnctADxiJ5QptX4bJNAAygQh2CU/lkXisDKAW8nvSU20ncclTVFMev4hcT58GmHMx
         a872aPb0jOHdV622auqIyC0pdawkb0uE9zHzMDXbornD20KtL4+XVMaG2ruT7cfGlXo0
         6pFezVDMSrsN7X1uJ0dAfMW+0fig86I72QnmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722280608; x=1722885408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aSdBNepOuMwe3ip16SyZwC9x3sQ/b3cOtgS+xLwo54=;
        b=o67FPVz2x7v6oaHhrjqQv84RMEFpivvI1AcFm2NdKqAQsskMNQWNAaI/ui3VtmGmii
         WKofd/SY3u33jRaE38JkJp0p/t329UDy7vyX1DIaAP2MKwWFplnKlCsTvCfUwTFKjko+
         Dw6pWOx7RgcPg/S8M1BmxtvyTH+zOeO7YREbjf0Kp/cFw1fzLtYcqC8SbdN5LX928ya8
         WFCezLC8YKFmzIWT2rxY6grHsCwNXEV1mIJhN41iNvM6aQZyfGSUy2jlxyYiaL2KS4Bc
         xm3O/vRhjFjw9d6ZideVpbf3MzwcW6v52zn4OoZKljksHH0im86RXC9X4LyboPlQ7lgj
         jZHA==
X-Forwarded-Encrypted: i=1; AJvYcCUHnOHdzXKinW0m4LsJQLLNn4PRR3Rtz22b7e5zJlX6alGKv8saP0VyZmnxv9ZktJ6W5Plv8hZDBFZ6152/8C1YxESdIOVB4eJ5pwIb
X-Gm-Message-State: AOJu0YxSDcjj9yCgqpeuqQgL2AgR8EgLImwWP8RksmlNkd9gwiDXJqUj
	C5vNod6CzHgVSiVGVifTl4QH8V6GWdBBFrfdRMgXXAaIKqCQxL/Y/yI/jPtAvHm0yO2j44+gzPq
	ugRFpMf1hmBa1Di8rdotSjpet6gydA+Gk0rZh
X-Google-Smtp-Source: AGHT+IGnAwXRu4C7Y+PVR0T60A7xON2fH9xIYdK2KzYMvBB0JclqD2TJEFzTtyWNuV59HkwKot/gKomKKo9k8ArfpBI=
X-Received: by 2002:a05:6902:704:b0:e05:fcef:c842 with SMTP id
 3f1490d57ef6-e0b54600502mr7711564276.44.1722280607875; Mon, 29 Jul 2024
 12:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83d9bb89-1a16-4ca4-80b4-1965fca498c1@stanley.mountain>
In-Reply-To: <83d9bb89-1a16-4ca4-80b4-1965fca498c1@stanley.mountain>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 29 Jul 2024 15:16:37 -0400
Message-ID: <CABQX2QOoq3H=eHdM83_k5vgHiaMu9Zsto=H7S95QHxT-s16jEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/plane: Fix IS_ERR() vs NULL bug
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 1:32=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The drm_property_create_signed_range() function returns NULL on error,
> it doesn't return error pointers.  Change the IS_ERR() tests to check
> for NULL.
>
> Fixes: 8f7179a1027d ("drm/atomic: Add support for mouse hotspots")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/drm_plane.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index a28b22fdd7a4..4fcb5d486de6 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -328,14 +328,14 @@ static int drm_plane_create_hotspot_properties(stru=
ct drm_plane *plane)
>
>         prop_x =3D drm_property_create_signed_range(plane->dev, 0, "HOTSP=
OT_X",
>                                                   INT_MIN, INT_MAX);
> -       if (IS_ERR(prop_x))
> -               return PTR_ERR(prop_x);
> +       if (!prop_x)
> +               return -ENOMEM;
>
>         prop_y =3D drm_property_create_signed_range(plane->dev, 0, "HOTSP=
OT_Y",
>                                                   INT_MIN, INT_MAX);
> -       if (IS_ERR(prop_y)) {
> +       if (!prop_y) {
>                 drm_property_destroy(plane->dev, prop_x);
> -               return PTR_ERR(prop_y);
> +               return -ENOMEM;
>         }
>
>         drm_object_attach_property(&plane->base, prop_x, 0);

Thanks, that looks good to me.

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

