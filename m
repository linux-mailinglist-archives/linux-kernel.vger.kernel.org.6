Return-Path: <linux-kernel+bounces-305285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC038962C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696B31F21BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418018A6DC;
	Wed, 28 Aug 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxVeR11E"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DD36130
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859038; cv=none; b=AkKaVdv0449a87SB+NbHWyGYYm10zul3Sb0ekd94U8wkQw1ZFro1rbUvkbnbdOUzUBpv6CdCPntqfMg93NEtB8hyUhNUjSYs3fn3mWAgjZez/Es3Sg61N/aifu3oVLYoF4zZSP32HmaOYeLeH7ct1IKBAvLTgKsxUIR5s4aH7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859038; c=relaxed/simple;
	bh=FnHoNjUva0KtW+wMufS6Hxn+3z+Brh7KdY6y/AuOeho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlQNa3z16EJ/zhp33/7AujxEMTWd/f+72OAcDRfP/RgL3QXhXXUPYEnZRYt55NajMH1P2fDavmKuCq42lvgd4y+pWN8wGXHejk0fRZX7FImsYONsWL9gJ/jthO7MfEBQBZECaw+cXMXP4ar/E0uEuFfQ+aqmsQ0Y+LLzDDWTWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxVeR11E; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-842f40a79a4so173690241.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724859035; x=1725463835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8aSC11rbT+ESzfKC/BjKSIyP+akTjhgeklkN6riloQ=;
        b=TxVeR11Eausu281Pn0K6tfxmTjVvu14j1H5S78DfLctbr06FrqEJa21yI6AIGzLz5G
         tQ1F3L0cOeUlmLtd8EqeME4J3qw2BKvtCcMERfdQjP1JDQiQttpiCTWw7Wp8HQBYCVrb
         dLDpcWvqLr6QrVb7lGi78Z/LD9stQfpUls+tuPceiedK1fTgH2bdg8RneX+ZEn4AapbG
         cE0Kmq4B0N17BtHJv0SqxX75IqhG8R4izBfcA2FWazbhDIhLaW2PAqum/DulLgCcBPrA
         lXZT1jBEXhb9+DrFX5v0yGzeEE5J6SCjWA1w2MkrN+PfcKYumihWVF6UohV4wqiEeN19
         v0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859035; x=1725463835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8aSC11rbT+ESzfKC/BjKSIyP+akTjhgeklkN6riloQ=;
        b=k6J+iC6zbj1VHuDCUPS7wm98d//AiTQn9N/BTlA1e2BhiONzJcbW86kalI/RrxvYCS
         KbLFuLvUAoswK7WZUExmElghyFT4C54/hMzY2k5OWTDbDjca1jmF7EP8vv4IfxJEQeqN
         e8shVi68pT1hW1dSLhsOXGKk3/2oljxwrLsaFNK40eXuZu9OOUrIMpiTUJpgEQrB0dcq
         KbMKW/Wi28l1DEZFoAKpgXexMD1GydrgZcUUT4fcWi6s8D0qE9VvkfA+mpzH0Q9zBybe
         whef1YXrEe13qvURJfOniIZZHOH6SM9nm/6Ms30HCf/YodIdSEfQTykB3G+rCZ+dUndc
         I6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUZj3FM9jR3PAZJMKE/jA/ZnRs2GRwecRGq+5SzcJ8LZJ4XOGbW4XRfjim4hIqBrfF2905sDKK1huErAsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCDrsPdCKf/UBb2aVMWjRxXher0um4HGIe37/kYHITgliVP/y
	eE0tWVAlad46buCLObm3Lzrc2Qin36vaAST5pAiO7yWf/hTj6ZQBzI1IjSMY7bpRAe3Khda2xQB
	/rfVB1Zv7+8HLbX4JM997My2ph3M=
X-Google-Smtp-Source: AGHT+IGPkjK66VjlndHHn76dL6NJfQMquX3Tj33agX4XIk9OqPrCbY99rMMocN3ECpnDxN4e7+WUf5QrCbQXZ0GRW5A=
X-Received: by 2002:a05:6122:7d1:b0:4f9:756:45b4 with SMTP id
 71dfb90a1353d-4fd1a776f99mr9622423e0c.1.1724859034944; Wed, 28 Aug 2024
 08:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3EA7C2B9E8C4D00A+20240828105938.37674-1-wangyuli@uniontech.com>
In-Reply-To: <3EA7C2B9E8C4D00A+20240828105938.37674-1-wangyuli@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Aug 2024 11:30:20 -0400
Message-ID: <CADnq5_P42A81D_VufAdSkwVwC08ZRiT=6XAS3oHmSH325ygbow@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: disable amdgpu_dpm on THTF-SW831-1W-DS25_MB board
To: WangYuli <wangyuli@uniontech.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, lijo.lazar@amd.com, 
	mario.limonciello@amd.com, le.ma@amd.com, Jun.Ma2@amd.com, 
	hamza.mahfooz@amd.com, andrealmeid@igalia.com, wenlunpeng@uniontech.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com, zhanjun@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 7:28=E2=80=AFAM WangYuli <wangyuli@uniontech.com> w=
rote:
>
> From: wenlunpeng <wenlunpeng@uniontech.com>
>
> The quirk is for reboot-stability.
>
> A device reboot stress test has been observed to cause
> random system hangs when amdgpu_dpm is enabled.
>
> Disabling amdgpu_dpm can fix this.
>
> However, a boot-param can still overwrite it to enable
> amdgpu_dpm.
>
> Serial log when error occurs:
> ...
> Console: switching to colour frame buffer device 160x45
> amdgpu 0000:01:00.0: fb0: amdgpudrmfb frame buffer device
> [drm:amdgpu_device_ip_late_init] *ERROR* late_init of IP block <si_dpm> f=
ailed -22
> amdgpu 0000:01:00.0: amdgpu_device_ip_late_init failed
> amdgpu 0000:01:00.0: Fatal error during GPU init
> [drm] amdgpu: finishing device.
> Console: switching to colour dummy device 80x25
> ...
>
> Signed-off-by: wenlunpeng <wenlunpeng@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 094498a0964b..81716fcac7cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -32,6 +32,7 @@
>  #include <drm/drm_vblank.h>
>
>  #include <linux/cc_platform.h>
> +#include <linux/dmi.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/module.h>
>  #include <linux/mmu_notifier.h>
> @@ -3023,10 +3024,32 @@ static struct pci_driver amdgpu_kms_pci_driver =
=3D {
>         .dev_groups =3D amdgpu_sysfs_groups,
>  };
>
> +static int quirk_set_amdgpu_dpm_0(const struct dmi_system_id *dmi)
> +{
> +       amdgpu_dpm =3D 0;

This will disable dpm on all devices that you might install on this
platform.  If this is specific to a particular platform and board
combination, it might be better to check the platform in the
dpm_init() code for the specific chip that is problematic.
Additionally, disabling dpm will result in boot clocks which means
performance will be very low.

Alex

> +       pr_info("Identified '%s', set amdgpu_dpm to 0.\n", dmi->ident);
> +       return 1;
> +}
> +
> +static const struct dmi_system_id amdgpu_quirklist[] =3D {
> +       {
> +               .ident =3D "DS25 Desktop",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "THTF-SW831-1W-DS25_MB"=
),
> +               },
> +               .callback =3D quirk_set_amdgpu_dpm_0,
> +       },
> +       {}
> +};
> +
>  static int __init amdgpu_init(void)
>  {
>         int r;
>
> +       /* quirks for some hardware, applied only when it's untouched */
> +       if (amdgpu_dpm =3D=3D -1)
> +               dmi_check_system(amdgpu_quirklist);
> +
>         if (drm_firmware_drivers_only())
>                 return -EINVAL;
>
> --
> 2.43.4
>

