Return-Path: <linux-kernel+bounces-397381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B399BDB3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE99284562
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F8185B6E;
	Wed,  6 Nov 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANpcxLP8"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D230158DB2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856703; cv=none; b=TCsEZ/o9HMJ3aJA9OMu3uVFQ5rJUnpaPWkp79q55y+MJc7EMqd4Zy0YVOT78FVBPY4OjDud1rNtG4LT5ASoC6Wp1H9Rw8hOcI2mUvcNl9H/xR97PYsSwLXhyrgpDlbfvaeP8QjuLlpiSp54bK/FmTHTae90Vv8lQCGDRYfwhno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856703; c=relaxed/simple;
	bh=5CmSX02hMXqC0tcwAjp+rJhnC2j0lws2C8eH6CXLVfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1Ewfo9FaOa5x9Ub1WpSHv/IZOoD1jHw58m1mHqnxTUxKIDN/AqK21hZaYFleLm9uitLWf7Fh7XY6EM4RqzAhK5h2ui2Knz+gqzlvESGO3aRY0INH5hj9HfJ1EMXPAo7J6ZJGcPfvkyHoPLVrrwp5vfai6DW4XF8SIgJx+Qghvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANpcxLP8; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a6bba54722so15682675ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 17:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730856700; x=1731461500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZEdQ5A4rc3P9ZMICWLA+PiCJDpmRtuPvoqRfEkgQC0=;
        b=ANpcxLP8B/JaT3R3W0Oyii8JdGXjvisFrxv1WpGdXee6scT3fEFKi0eeBMp/pDUrhM
         u07893vK4mpgNAeX0pqVJCojiotcOX9vD+14gxk5cnT+kTrDlcqiQS3RlHQ+qWzCqL0k
         j433VbTxrovqZ0wKm2Sa5GNLpCq4PMYBqu5hUUxNj99rdzbWh0gbyjMlOKzUIpECbT6J
         13wkCHBJ7W2KrPpPWLCMqtAWoBE2qtg6qfugJXWhzzEIlgrHQ064RwTD4Ip2e8YzWY2S
         1rQPbYo52aiMYlzUuLEuXykqsgNxqTU1bXpqAlt7AoQ1e0LGuyAjQjDIbyhLE1QyteL8
         RPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856701; x=1731461501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZEdQ5A4rc3P9ZMICWLA+PiCJDpmRtuPvoqRfEkgQC0=;
        b=HmhaW+E0W0M+hbhrQbsMZqGukdKV/rA3kvsDYo+EsAc+AwNGIeYy4IC89rC2Ny8C+Z
         L0XZTuDoMfO/xmbMwnKtdM7fVjxRRfjnLU7hhbKQOV/2I9QJ+eM3ZCoHFbIFXX1/YAVs
         A6hMQHWv1TAVU4/AcpvNqS4mHxKbY7OiWKz+AXydpqmNLzFo3woOCakBd4B16sdAbKQn
         7y0O8kPMyd8cToemAKO6PQyTenixhu6FvQpyC6hEpw5Q5ZxmpLCtqkdFD33lD03hpCz1
         etKV1ho1lWd7R2cL2WQt5iWH3A1YXwUAdXEQ6zYxrTb2FG/NQrkyFgQwrwRFgpcUxH7z
         9Ayw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ssxRPJf5yRr8kBb80S0VCCHznd0toVh3OXa1ErQ4qB3OB+GqS0efio9Lup+cFZvUQZU5oyxTnPC4rDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9pOySlO9b7iidO8PMeENrwzP+PvKovHq5CeYDzZ1vPIAsfjC
	TtAIdI3Rm8J/Ij8/ceQ+0dHhkkO64Z1NGC41bxKTHCyiZIsd73Dta8deaPQPBtVQ/S8/WgViA+g
	xa6eDvwH5tgqaffkakuhwTVxlbH9iwQ==
X-Google-Smtp-Source: AGHT+IEKU8XnaFKdqE7nB8aAs1Qbr/FQljqOuyQsSN6+XX2borSTMs1XTeUygH5VgMPHRf3Wtb671mQbzY159BQ9UUU=
X-Received: by 2002:a05:6e02:148a:b0:3a6:b37c:6a12 with SMTP id
 e9e14a558f8ab-3a6b37c6cc2mr189320995ab.7.1730856700682; Tue, 05 Nov 2024
 17:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 5 Nov 2024 17:31:28 -0800
Message-ID: <CAF6AEGs2+gPtqOw=LMwVxNkzWgYc11u0VN3DnQOyQc2MPhsJig@mail.gmail.com>
Subject: Re: [PATCH v1] drm/virtio: Don't create a context with default param
 if context_init is supported
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 3:49=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>
> Xorg context creation fails for native contexts that use
> VIRTGPU_CONTEXT_INIT because context is already initialized implicitly
> when dumb buffer is created. Fix it by not creating default vrend context
> if context_init is supported.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virti=
o/virtgpu_gem.c
> index 7db48d17ee3a..67f557e058b4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -127,15 +127,17 @@ int virtio_gpu_gem_object_open(struct drm_gem_objec=
t *obj,
>         /* the context might still be missing when the first ioctl is
>          * DRM_IOCTL_MODE_CREATE_DUMB or DRM_IOCTL_PRIME_FD_TO_HANDLE
>          */
> -       virtio_gpu_create_context(obj->dev, file);
> +       if (!vgdev->has_context_init)
> +               virtio_gpu_create_context(obj->dev, file);
>
>         objs =3D virtio_gpu_array_alloc(1);
>         if (!objs)
>                 return -ENOMEM;
>         virtio_gpu_array_add_obj(objs, obj);
>
> -       virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id,
> -                                              objs);
> +       if (vfpriv->ctx_id)
> +               virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx=
_id, objs);
> +
>  out_notify:
>         virtio_gpu_notify(vgdev);
>         return 0;
> --
> 2.47.0
>

