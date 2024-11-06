Return-Path: <linux-kernel+bounces-397374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A3B9BDB26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CD41F23573
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C4B188A0C;
	Wed,  6 Nov 2024 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS0O069O"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E810E5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856444; cv=none; b=pQ3EkI2YqFdjCrgd+tmVJojmfmw6IWO+zW/Z4GA2cG5srncldPkbCK5HUwAzuQzATF4Vu90M3kUvs0SkWaGkmwNbSER8RFrmEtu4l+0Hgf8KwRsFkoj+vlldmRqhB4h43f+FVhW/O0ank2F7o7TIZVAydBcCu4302go4/qUKEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856444; c=relaxed/simple;
	bh=njdibPXQOQM2lEaEUF7Q6OeOAyl2vAILy1ic5HJUabU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLxs0+Sl5tL0AE852gKjJiT2y3lsXNJXeBc8i8AywFnDrzNNKvdGdhOPcpimqYo1K6QBU2ptf7AP5lMP/YlrUao6Xz+VGSUj+dJxF24v5M8UPxtwTThVXNohhi1e4/fxOZ9jf4eY6Prc/8YDB8TdiLG9+q0Dy/fW/WkORD0Q2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS0O069O; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a6aed064b8so18916005ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 17:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730856441; x=1731461241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcxC+ORh9eBt+jOnM96T6OTZbBwlinEiMNH6d9wvoUs=;
        b=XS0O069OxlcjmExGM5rUicPgg802Fj2DjT+X8Zk2q2WDJlqC3GdwYFNoLqma+CKiXR
         n44V//y3Ocbzj6FcxfpSkXuCatud/IIoefzNbBBLjKaTVDN7FXaBSE94iEGE/sGBYwHs
         8RtW9fjKqiPGtuP9hc92Hcj0g7L+uwJwHkrfPTSseTo2HWZ92E9k1vVFeYz4ZXRRbF2Z
         Wj6Ur/0Z0mYd1I2TurLVQwB9YbVdfngEB/fxerkqTFi+jSHG/bC1nM/CftHGmUzpHw4V
         ANRjTY97BOjF0EeRU4Jjstaxz/3ZwqgcQkBq83onk0ZVIcIqybEoFKcb7Ka0G66R5Hxd
         GFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856441; x=1731461241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcxC+ORh9eBt+jOnM96T6OTZbBwlinEiMNH6d9wvoUs=;
        b=w/5MZdNT+2gOfXf1Hf8CDYlMdtW/Ks/o39WptZ3KGGRSZds4XYMLHrVHAlc2RzeMSG
         QvDR9l97DMIvishe/pTlG9cF7lIjynRINu8RD6McS0byW+tUNy4zZJjRXe4e80aKYO5p
         8Pj+3y7vL/CVttHDRaPzvZ8YKnUU7fmPwxVZK6AQFWHt5OyPKULYGOMDOUaCrmk6xWQK
         YSj8ajKtu/+UvtK/mR2LLYHYbH/vGzzaoq/psnqWMR26GGKmqjrtiDIDl8ceyITUUA4J
         VkDpDvpLKcpmkGefHUrBw+TaMLopYIozIcbXP05/F+SE7W79H1bZF2P/aERsAxryXr5N
         Q1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUbnl5fB1pxy/GwHyoPO5LyJbR1AenYXACy13kzbe0pKtkc/zavBn6k4tQRX+0YuFjjBwAbPVgBEx5KmZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lxpDb1AWBi19gEdz3DLtWbDTRd9aoayqQ3amg9I5XvwE1WnD
	iQ09LQibV8zfnq2mlrF7WCLimO2FM9N1IIiZGIxvCpIOIyaCxG38rpe3dQrGzfCerIcgrjpI75x
	Vko7TxlopV+r5sO3PAQwqHTfaI6g=
X-Google-Smtp-Source: AGHT+IHK8YfN0cWKU5EzbpIzvioDDX+4UjhafdKqkGFG/9144aWhyTmx/bwu2zbbifHRZEYV7AUaD/0tSb65EKVTtMs=
X-Received: by 2002:a05:6e02:1d11:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a6b0393b63mr187747875ab.24.1730856441515; Tue, 05 Nov 2024
 17:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 5 Nov 2024 17:27:09 -0800
Message-ID: <CAF6AEGv73+k4fNm-5ZXTyf5jizx=Yq=HeA5AC7K-DrDA1Edn2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Use drm_gem_plane_helper_prepare_fb()
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Kim Dongwon <dongwon.kim@intel.com>, 
	Kasireddy Vivek <vivek.kasireddy@intel.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 4:08=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Use drm_gem_plane_helper_prepare_fb() helper for explicit framebuffer
> synchronization. We need to wait for explicit fences in a case of
> Venus and native contexts when guest user space uses explicit fencing.
>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> [dmitry.osipenko@collabora.com>: Edit commit message]
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/vir=
tio/virtgpu_plane.c
> index a72a2dbda031..ab7232921cb7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_fourcc.h>
> +#include <drm/drm_gem_atomic_helper.h>
>
>  #include "virtgpu_drv.h"
>
> @@ -254,6 +255,9 @@ static int virtio_gpu_plane_prepare_fb(struct drm_pla=
ne *plane,
>
>         vgfb =3D to_virtio_gpu_framebuffer(new_state->fb);
>         bo =3D gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
> +
> +       drm_gem_plane_helper_prepare_fb(plane, new_state);
> +
>         if (!bo || (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY && !bo->gue=
st_blob))
>                 return 0;
>
> --
> 2.47.0
>

