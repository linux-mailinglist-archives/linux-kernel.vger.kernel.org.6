Return-Path: <linux-kernel+bounces-448043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB379F3A43
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6420B1883DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48520CCC9;
	Mon, 16 Dec 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjSMpupD"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE620765F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378821; cv=none; b=G//erL5gueWI/SIgFAMwQJCQNSqiNHmkYac7MiL+DT5GnAR5bNjsqeKiJ7mlxqz/j+wpoyWcz99EjGfGDW4CoHzpyyfnjXPq2pa61AQzNjmCKSG4xc/LrM+1TUyZ5oSEJK3hPVngO37weifammOOgHGeSRbGzx9FELon0KclY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378821; c=relaxed/simple;
	bh=ERoRmX/lkyK0ky5QEidGCcIwo9vDygjoeCBidfPNwLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrAhQIHtaRU2ofREwgVjAGpuVfFbNd67NfQHUNVM0ow4/UmmE6pfedthUZQmx9S0+7U3irbrUeDKsDaJnZlfne6dcp1nmNpXWF5HoekCPV+wVTRevc34NLWl6zoLQJod2uKKoV+/umINKqByuglKEG+t7nw25DqJNhRFlbF8OJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjSMpupD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef79243680so792689a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734378819; x=1734983619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIYj4bJCscXDlJoY7W+vXtaBhQexWWb3wrX5bFyCwNs=;
        b=CjSMpupD/b60sMSYg6rVHzoB4Ki582pcw0mpgi1FCAvqRkFuWl6ZI2XoSku3kVHgMw
         0cmSkbEhQ4vOaYdUuoWMAQahgqWA8M0B0v8l6YvkRru2U1ozb+SkN8CsWunx6wbB6e6+
         4Q97VD+itlC/cNe9fCncl1ff8GmFsodKD3ipWYcIPlA87YTHevWH56GBow7tUGnI1TBS
         EtRgYDM79/T/fA3htChq5gr+NkdZ774ibaGU+N3A/bAtcPhGI+1Swz1m62AigQaYCfPW
         RYst/+qbNUmJsdF+PL9SnbX+glNfVn6wTCb6a4aUEpIpmj99QzQxp+CAsqHQJEBpnmYO
         8VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734378819; x=1734983619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIYj4bJCscXDlJoY7W+vXtaBhQexWWb3wrX5bFyCwNs=;
        b=PWLcwdscJyJSSKv4pYGtwI8RLQxpdnEIxDRCT8pZTp5sIIHAtdHB2+Oqd8djOfqOtB
         7cktWIPTzUqzKyxMcBDy5xSHz62tqdtMFKIQwFhIPQ8+p/2Ot8saVXeXRBv08fs2fJY4
         QmcuT/RJkls0s+BeOrD6RC+vXuuqS68W89sxLVEMcvaqKvWyXIN7txp2vdhbQtAEZVhZ
         DVJT7qtff+i6dCMfSTozBJdEGN4KZcQe0foEHCoR+zxWTs961mibSJhwxLTfCvzMDcRY
         lGIRGbmXFuQ7UqSefDHgXHPfbdVil+OsOnTA/xs3FEAVl/p4D4Sgd6iIcUOKhrRi5GCq
         2AKg==
X-Forwarded-Encrypted: i=1; AJvYcCWoAcErdI6YMO4u1uhBu9OG83gI0H+UPloC+kXwGd40YodXZscttk4aZGGM8jcADy7+lmu33dn8VZ2wQPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnraEiZ2e6k4WhynvlUpV50YziW5qMAatt0PKxifFJVFqOsoy
	UobqPHx9tvog+RrDy+yQRMSok+BpxAwqfL1LvaXDS+UExbvDPLbl8gxsaPcPym+tTZiQDKRujbw
	fmYi1MhjFaB9TnXFmZca7/H1+Yqs=
X-Gm-Gg: ASbGncviV51N4qT7w+74eOcEWoLTva3REPD8L/P84agLdZsHlFT0xOfhXiWA8ikDh5O
	e+u1f9NolMi2Gfi5jBFQ6r18A1Za3+pobNSOo3w==
X-Google-Smtp-Source: AGHT+IHw07J50LjkLVhVLiSn1KCIPan7Le0TMFJV6k1ZwY/55RNLENGR9IgNrc4XNQq+FbWOpLs0wM/oMgnVdK0H3xA=
X-Received: by 2002:a17:90b:3509:b0:2ee:3fa7:ef23 with SMTP id
 98e67ed59e1d1-2f2905b4479mr7485753a91.8.1734378818588; Mon, 16 Dec 2024
 11:53:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
 <20241216-sysfs-const-bin_attr-drm-v1-4-210f2b36b9bf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-drm-v1-4-210f2b36b9bf@weissschuh.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2024 14:53:26 -0500
Message-ID: <CADnq5_Md9Oy5LdrNSPLFcH7fbtJqjxZ-usrVwj93OOxLjjEgmA@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Qiang Yu <yuq825@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lima@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:53=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 14 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 13 ++++++-------
>  3 files changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index d272d95dd5b2f5eb83be279281d55af323f7f508..88459de2cd2e47390d33e5939=
875c3322b740b4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -223,7 +223,7 @@ static DEVICE_ATTR(pcie_replay_count, 0444,
>                 amdgpu_device_get_pcie_replay_count, NULL);
>
>  static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject=
 *kobj,
> -                                         struct bin_attribute *attr, cha=
r *buf,
> +                                         const struct bin_attribute *att=
r, char *buf,
>                                           loff_t ppos, size_t count)
>  {
>         struct device *dev =3D kobj_to_dev(kobj);
> @@ -259,8 +259,8 @@ static ssize_t amdgpu_sysfs_reg_state_get(struct file=
 *f, struct kobject *kobj,
>         return bytes_read;
>  }
>
> -BIN_ATTR(reg_state, 0444, amdgpu_sysfs_reg_state_get, NULL,
> -        AMDGPU_SYS_REG_STATE_END);
> +static const BIN_ATTR(reg_state, 0444, amdgpu_sysfs_reg_state_get, NULL,
> +                     AMDGPU_SYS_REG_STATE_END);
>
>  int amdgpu_reg_state_sysfs_init(struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 448f9e742983f3ef0c5fccc18d85f0c2449aa08e..cda25174730a6852bcb6e01ae=
ec858faad172b19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3969,7 +3969,7 @@ int is_psp_fw_valid(struct psp_bin_desc bin)
>  }
>
>  static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobjec=
t *kobj,
> -                                       struct bin_attribute *bin_attr,
> +                                       const struct bin_attribute *bin_a=
ttr,
>                                         char *buffer, loff_t pos, size_t =
count)
>  {
>         struct device *dev =3D kobj_to_dev(kobj);
> @@ -4005,7 +4005,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file=
 *filp, struct kobject *kobj,
>  }
>
>  static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject=
 *kobj,
> -                                      struct bin_attribute *bin_attr, ch=
ar *buffer,
> +                                      const struct bin_attribute *bin_at=
tr, char *buffer,
>                                        loff_t pos, size_t count)
>  {
>         struct device *dev =3D kobj_to_dev(kobj);
> @@ -4057,11 +4057,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct fil=
e *filp, struct kobject *kobj,
>   * Writing to this file will stage an IFWI for update. Reading from this=
 file
>   * will trigger the update process.
>   */
> -static struct bin_attribute psp_vbflash_bin_attr =3D {
> +static const struct bin_attribute psp_vbflash_bin_attr =3D {
>         .attr =3D {.name =3D "psp_vbflash", .mode =3D 0660},
>         .size =3D 0,
> -       .write =3D amdgpu_psp_vbflash_write,
> -       .read =3D amdgpu_psp_vbflash_read,
> +       .write_new =3D amdgpu_psp_vbflash_write,
> +       .read_new =3D amdgpu_psp_vbflash_read,
>  };
>
>  /**
> @@ -4088,7 +4088,7 @@ static ssize_t amdgpu_psp_vbflash_status(struct dev=
ice *dev,
>  }
>  static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, =
NULL);
>
> -static struct bin_attribute *bin_flash_attrs[] =3D {
> +static const struct bin_attribute *const bin_flash_attrs[] =3D {
>         &psp_vbflash_bin_attr,
>         NULL
>  };
> @@ -4124,7 +4124,7 @@ static umode_t amdgpu_bin_flash_attr_is_visible(str=
uct kobject *kobj,
>
>  const struct attribute_group amdgpu_flash_attr_group =3D {
>         .attrs =3D flash_attrs,
> -       .bin_attrs =3D bin_flash_attrs,
> +       .bin_attrs_new =3D bin_flash_attrs,
>         .is_bin_visible =3D amdgpu_bin_flash_attr_is_visible,
>         .is_visible =3D amdgpu_flash_attr_is_visible,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 4c9fa24dd9726a405935907524ed7bf7862779d1..2991e0967b5bfc848328aaa59=
ddfb9a8f202bae9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1732,7 +1732,7 @@ static char *amdgpu_ras_badpage_flags_str(unsigned =
int flags)
>   */
>
>  static ssize_t amdgpu_ras_sysfs_badpages_read(struct file *f,
> -               struct kobject *kobj, struct bin_attribute *attr,
> +               struct kobject *kobj, const struct bin_attribute *attr,
>                 char *buf, loff_t ppos, size_t count)
>  {
>         struct amdgpu_ras *con =3D
> @@ -2063,8 +2063,8 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_de=
vice *adev)
>  /* debugfs end */
>
>  /* ras fs */
> -static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
> -               amdgpu_ras_sysfs_badpages_read, NULL, 0);
> +static const BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
> +                     amdgpu_ras_sysfs_badpages_read, NULL, 0);
>  static DEVICE_ATTR(features, S_IRUGO,
>                 amdgpu_ras_sysfs_features_read, NULL);
>  static DEVICE_ATTR(version, 0444,
> @@ -2086,7 +2086,7 @@ static int amdgpu_ras_fs_init(struct amdgpu_device =
*adev)
>                 &con->event_state_attr.attr,
>                 NULL
>         };
> -       struct bin_attribute *bin_attrs[] =3D {
> +       const struct bin_attribute *bin_attrs[] =3D {
>                 NULL,
>                 NULL,
>         };
> @@ -2112,11 +2112,10 @@ static int amdgpu_ras_fs_init(struct amdgpu_devic=
e *adev)
>
>         if (amdgpu_bad_page_threshold !=3D 0) {
>                 /* add bad_page_features entry */
> -               bin_attr_gpu_vram_bad_pages.private =3D NULL;
>                 con->badpages_attr =3D bin_attr_gpu_vram_bad_pages;
> +               sysfs_bin_attr_init(&con->badpages_attr);
>                 bin_attrs[0] =3D &con->badpages_attr;
> -               group.bin_attrs =3D bin_attrs;
> -               sysfs_bin_attr_init(bin_attrs[0]);
> +               group.bin_attrs_new =3D bin_attrs;
>         }
>
>         r =3D sysfs_create_group(&adev->dev->kobj, &group);
>
> --
> 2.47.1
>

