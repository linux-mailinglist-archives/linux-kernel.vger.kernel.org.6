Return-Path: <linux-kernel+bounces-348053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF998E1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDFA1F23125
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AB1D1E8C;
	Wed,  2 Oct 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OowJ1Dn1"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3821D1E87
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891934; cv=none; b=IvgDts2xRVZBZ9jjOh3+LtWmd8q4Biu3Tqtoh0MkFpxXpolDbDB8GranQr5CQ2vNy6BOKK2mwCL8hpMgMfC3tUQLXhKa4lEo364dyzNdEI+NNRL12Ctr+U1WM/iymt3FQs1zziuKrHNopZS5bJ3GLF0X4DPUeiJuTOSsuVWg9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891934; c=relaxed/simple;
	bh=Sq+TOA7FIo2QaojnVfeonM7GE6KaQKE9dk7pHoijhXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7yMo2+Zir/0HcBGTb3OVM0+EpvKy47iXJrCai/fZDfZuDC5bn2e1gX93pIc8CQz3rBoJJnBnOUkl0V52YvJYMrO/nFZPFEx46rClfOb0d4HwQXeXg2QkWUymWeU905iJrvbDKe/VspEi1ru2axqingpNB4atW9skZvMPb7DQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OowJ1Dn1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71797e61d43so10087b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727891932; x=1728496732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLfkn1lM7ycmc5uJvg9Y+3m1F6E5illHhSwCELlgxaI=;
        b=OowJ1Dn14imPA9/FjXF9EFIiCgWc/QKeRCpD7RHYy/6/8gS732cvxCdwX75c55QRiG
         egjhWIGDwxmPKWAokIPlGD/txKF/OFxU7CUEqow5+uoRgYCW90STg6mMsBSDKj0+xFP+
         YALsy2OUNyhm13HFp1bEJbYCHU9MkUoykC+M93O+YMGBhytu4rJ7c2Y4YbM50Xu0r/2D
         daQvVbG+iK962u7GkdV8T00Ooi7Eon7y/z5iFyndNkjWwUnhORcvqYGOSt8KZnQidLQR
         xBPAfV6HYkhxtVFqft9EblmtlRkx+9q8c5PEdvnL4w280KVsC14xh6IPMyl1PIW19R9Y
         7DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727891932; x=1728496732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLfkn1lM7ycmc5uJvg9Y+3m1F6E5illHhSwCELlgxaI=;
        b=CqF4CWm9NSBvCgsCK4/GBO6ZnbecyquJFLsAskJipjnHygBPas7h5EreVSSI/nHdBG
         93/xtYSr5PzmnQ2ItVQ8ewNbV0UpQVrRIFoGK4v/E7z0AUCy2i+y3SCqE8N7Y6LrFzhy
         i2+fw41x9c7EVAJxZYXehbSj+civg3qAOekSdAXStgyX4cBpRZsjVCKHF96Ph3u833aQ
         4jbpDVbUmQY4vjOh5S50Wq6hrgmtuqaFLz/kC7xxp+KbnYXG67R4+/I6RBzh55La2MDl
         20UiooP4oGut3KRpsr0YZOV9rze5M64Z5/uHqk1Y13Gl25BrzEEUura/RwY0VbJ4e5Db
         el4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUExPpQ5G/isfbJ6PZQDReFpsx4aTKc27jDVq/Z4pEgZB2HRjbat1e/SZhh+C3Iy51el+jWWpV37yfgiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyViwHSQXMwpiiJ1wCnFNqAOl73LIuMDzNUDrvIU0IZ/7j72VH
	NMJUxdypyQIU3M3UpFXtIGS+i4EFuGC2YqPq4651WDyKUBFm56GksDRjLsBh4R7KTnseAr5zdsm
	zAPPGeC6powHDVMSkhm8n4g6VGeU=
X-Google-Smtp-Source: AGHT+IHtlRNM5uRFEVN6FSCHavCcGjEq0D5Hjyp+TCSnmhFR0BtpMClRHIiEQtbc9O2HGYJeKD2+1b6qLbI7bol5+yg=
X-Received: by 2002:a05:6a20:12d3:b0:1cf:4edd:e6f7 with SMTP id
 adf61e73a8af0-1d5bee0be1amr2778540637.0.1727891932175; Wed, 02 Oct 2024
 10:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b3ea9a6-575e-4fe5-98d9-6e53803188fa@amd.com> <20241002130149.1607979-1-Igor.A.Artemiev@mcst.ru>
In-Reply-To: <20241002130149.1607979-1-Igor.A.Artemiev@mcst.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 13:58:40 -0400
Message-ID: <CADnq5_NiUmJ3K0cYcToDQ34D9zkEREfub6CBY3iC8515ss_E3A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: check return value of amdgpu_irq_add_id()
To: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
	Kenneth Feng <kenneth.feng@amd.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Oct 2, 2024 at 9:28=E2=80=AFAM Igor Artemiev <Igor.A.Artemiev@mcst.=
ru> wrote:
>
> amdgpu_irq_ad_id() may fail and the irq handlers will not be registered.
> This patch adds error code check.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
> ---
> v2: Remove the cast to struct amdgpu_device as Christian K=C3=B6nig
> <christian.koenig@amd.com> suggested.
>
>  .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> index 79a566f3564a..50a3085c00aa 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> @@ -647,28 +647,41 @@ int smu9_register_irq_handlers(struct pp_hwmgr *hwm=
gr)
>  {
>         struct amdgpu_irq_src *source =3D
>                 kzalloc(sizeof(struct amdgpu_irq_src), GFP_KERNEL);
> +       int ret;
>
>         if (!source)
>                 return -ENOMEM;
>
>         source->funcs =3D &smu9_irq_funcs;
>
> -       amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
> +       ret =3D amdgpu_irq_add_id(hwmgr->adev,
>                         SOC15_IH_CLIENTID_THM,
>                         THM_9_0__SRCID__THM_DIG_THERM_L2H,
>                         source);
> -       amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
> +       if (ret)
> +               goto err;
> +
> +       ret =3D amdgpu_irq_add_id(hwmgr->adev,
>                         SOC15_IH_CLIENTID_THM,
>                         THM_9_0__SRCID__THM_DIG_THERM_H2L,
>                         source);
> +       if (ret)
> +               goto err;
>
>         /* Register CTF(GPIO_19) interrupt */
> -       amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
> +       ret =3D amdgpu_irq_add_id(hwmgr->adev,
>                         SOC15_IH_CLIENTID_ROM_SMUIO,
>                         SMUIO_9_0__SRCID__SMUIO_GPIO19,
>                         source);
> +       if (ret)
> +               goto err;
>
>         return 0;
> +
> +err:
> +       kfree(source);
> +
> +       return ret;
>  }
>
>  void *smu_atom_get_data_table(void *dev, uint32_t table, uint16_t *size,
> --
> 2.39.2
>

