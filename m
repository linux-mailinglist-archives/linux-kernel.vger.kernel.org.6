Return-Path: <linux-kernel+bounces-359979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9718299932F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCF11F21A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4A1CF7B8;
	Thu, 10 Oct 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TwbsnM3o"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FC1C9ED0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589943; cv=none; b=ux4wo0ZbNUw1eqdqLrYZLcuHbt60R7hJzm5szk2g1eRKMtGZXv/yj61IwW5wlOvardboRoCIjoBIXiAOwDKxfBioT/c0rGMxcVEVEOJrDi28XYbmYFTCkHf9XBT5Gi9qKG9/i4h0KHWKGgQ0pIToldCMrDK6GhgeB78ZqBNbYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589943; c=relaxed/simple;
	bh=k1T3SKLXk4xT1EZ+pJJHSjTwS1Rlz/OMeCunvBztblY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMvuRAXA0uWSJWl913S4XtRSpPLxWDwJyJJBxbKpnoO7Ly37SU21TwVQs9srsn+gSRULWCCIIch1NFQQpN0CE9DcYVkwDLQAtDbj9gSPQXDUqvDuU2vFBd/phxIbJh5bxs463tC3HRFceZh0Jey3quVvGwXiMB3ASSQW3oFMy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TwbsnM3o; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e29072f194aso1229053276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728589941; x=1729194741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0yQGGhTqw9cUKWuDIB0GQqeru7Zb3BCIasRnoNpl7I=;
        b=TwbsnM3oGC7matx0Kou9G0z6/L+iRPdDNLmve9ls1XPWl/SidF5b7YB+ea7XqONzKW
         faUjXLJDXysJVZsc+F/qfxL+CU+7obwwxU6k3hiObXBU8eFtsrlT6Ea30NdNhuPDNK1j
         xgS5oE7LnZdkysXUlQzfE+b3mbWavdHxgtHtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589941; x=1729194741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0yQGGhTqw9cUKWuDIB0GQqeru7Zb3BCIasRnoNpl7I=;
        b=m+zxceoFPYFTmcR+pEvtvPol6nM5oo6bSTiKVUgfidTOHIc9GjR9DYE67T/tr2K0Mx
         ViddiueWEdmdOua61mMROXe6jm7cVINTcd0NifuLeuPxoydaTC3E/6Zaiapvyp5LBGDe
         HPmHop7K3u7z1T4cMWv7ovvXAYJdsqRQL0p8gQlpiXho7To6PFfZUxAjFVKtIL1lSi1V
         z0CAqgJkHwW1+QedCVTCEwpDojZHCTETHK/+Jv75jOjVx7hnbOYZjd3dF2y1JNfUloRg
         6ibI+zsbfm0ovbkDPgzjmgcjUeRV+EZBsswldfFvFfzOQgH+y6F5tcxW0y0QwWC3v46U
         QsHA==
X-Gm-Message-State: AOJu0Ywqq4Rd6RGY+XjtlYHRW/4g11rei83WnNqHbHP8GToATRTE1liO
	MAVIeSHBAG7OEZa1vBlXLju7SRBdZaI4JdPxdwUUvZ2vxdYd6Vdd9XZ+pD+fu9vRF+6nTO1enVS
	W/IptmT76ilSOI69zabmzj9pdRd91Lx9jwE9V
X-Google-Smtp-Source: AGHT+IFWC5y7eMICyQT90+3RF+9SJuIQFBfyId6svCfqtZ8VV8P2OhLGTFKN0YGn+Iylgx5+atjoJZzkAL3VP4f/CE0=
X-Received: by 2002:a05:6902:1589:b0:e28:30f5:f33 with SMTP id
 3f1490d57ef6-e2919dadd2amr106480276.28.1728589940760; Thu, 10 Oct 2024
 12:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002122429.1981822-1-kniv@yandex-team.ru>
In-Reply-To: <20241002122429.1981822-1-kniv@yandex-team.ru>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 10 Oct 2024 15:52:10 -0400
Message-ID: <CABQX2QNVpaTqBDzBnwDgW=2fi4QxeywXZRsbhywLkph3JgAmjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Handle surface check failure correctly
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, lvc-project@linuxtesting.org, 
	bcm-kernel-feedback-list@broadcom.com, Sinclair Yeh <syeh@vmware.com>, 
	Thomas Hellstrom <thellstrom@vmware.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 8:26=E2=80=AFAM Nikolay Kuratov <kniv@yandex-team.ru=
> wrote:
>
> Currently if condition (!bo and !vmw_kms_srf_ok()) was met
> we go to err_out with ret =3D=3D 0.
> err_out dereferences vfb if ret =3D=3D 0, but in our case vfb is still NU=
LL.
>
> Fix this by assigning sensible error to ret.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE
>
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> Cc: stable@vger.kernel.org
> Fixes: 810b3e1683d0 ("drm/vmwgfx: Support topology greater than texture s=
ize")
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 288ed0bb75cb..752510a11e1b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -1539,6 +1539,7 @@ static struct drm_framebuffer *vmw_kms_fb_create(st=
ruct drm_device *dev,
>                 DRM_ERROR("Surface size cannot exceed %dx%d\n",
>                         dev_priv->texture_max_width,
>                         dev_priv->texture_max_height);
> +               ret =3D -EINVAL;
>                 goto err_out;
>         }
>
> --
> 2.34.1
>

Thank you. I pushed it to drm-misc-fixes.

z

