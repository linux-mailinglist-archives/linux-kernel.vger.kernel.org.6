Return-Path: <linux-kernel+bounces-349538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E498F7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3CF1C20E49
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC001AAE05;
	Thu,  3 Oct 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBSPxLfI"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55932C8B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986855; cv=none; b=i6I2i7YmFO2z4iHRApKfnfqm2z8MdzukwtDjzP9vJuxLb/LDgCqk4pydw/dUKTCsc/wFCvUXXH3W9/CgqV1Fgkah5CBlDiAne7TCxAiW3DBBNa9ccxMS5QySJBhN7rvhQ7s8T+PEqbbHXK36uifNvN7LdykMhgk/WTw0jBpzYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986855; c=relaxed/simple;
	bh=1HqA9KteN1D6noDY7oLA2qZ2y/puqFdmUd8RBWatglc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRT2u4hj+g+o7WmLljLhkEkUemfQOGSb6PNNo4m60/UJrsswx7S67RjzpBF9mJL+2vz0WpBHVYApT0+5extwGW9O3ExUyc5OvdjVsTsPxa3DQJKILXTnylVU6KcDHHuSB0+frIjsiypNGVTY2xQxjxXDYLQQZ/QAp29q+b9cLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBSPxLfI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so963566a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727986852; x=1728591652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbiE8Fwcd7rX+QDGcaE2iE4PLXbaZTOlfpn9YTt6nAU=;
        b=uBSPxLfIGkFJA0lDKtF7ZwsRgcJ+KEtlBz74UT8c5TZTPFNk2fp6LHFKjNS/2POb9g
         ns/vZl59kF+5ZNmt9aCQCaoIsWELgb7riTgpvACbPeVpKLSF6F8zvBZKK7gqjYXNm6tW
         U6esT8PvabkELCijPUgpjt4PLpk8dspNhK6wQ1OAZ8oc0ZBj9z/hqmOjHI1OK4cJLmxU
         QUST33Zx6baAADY/00ZDSh5DRAUKs+SVX+chkBHxOQU0qVe73b6wsxkIeS2UPqO/R5HH
         xb5C49OyUFzPe3g7GBH6MdIXev6N3Ig+vFMtTiLUxaCTKcwcKeN3R5jaeV+Wav7PXoUS
         RX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986852; x=1728591652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbiE8Fwcd7rX+QDGcaE2iE4PLXbaZTOlfpn9YTt6nAU=;
        b=MGNnV6Lz22KIQhjR7iYFomWfe0/IiCluIDse/pTveEo9QrpJ9zj/jRqHoZdr3T4NOk
         puPhvdClTedeK/5KAk+dIQAftwAteZnlu0U0SYci1lG9W0fBChlSEzA7UZiEgFv/gWxV
         9MlltXVnS2DnUyy18x00Ebf74F0GXd4owz/qv9yt8cQ4xawUPp8MIN615Flh5Kim1mhc
         ZgCfDKbkkqb6fM6f9f3VvgfO2S4CwG0hUrGJqjQtNkSo/Gm4Lohc2I6p2vZKuT2Ff3fA
         2EF8VG4LY/Yl8Nq5uvDCDdeRtAzzso7fUX1nHGulltFOW3T8GT6o1xNRNQfY4Kk8yxZX
         4CKA==
X-Forwarded-Encrypted: i=1; AJvYcCUFeXv9Wp+ZYYwZz0AXRbF6gEHN0Sdh0x8g+nRUKTEe6unnx77p+cP/tuZA9//lEux+SjPypgAXpWQqOqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtAUfi+vVGpXgJXMIxxlkOEwptxJMJvsDi/27mxl/YaNaEqOV
	jTD8raYGKP//fFfN3HxVRgpYXCGcqn7gM/v77F8+kioR7b7nKUyrtOvRIX9/VY/p2603Kl2avdP
	I20RLVsT3kegx5AmLjBCltEHr1d+eYglMJy0v
X-Google-Smtp-Source: AGHT+IGoii5GTavodnbmoAzteJqE0sqbwGfZNG8ANhg0hXL3IWG7GenPq51doRWMGZRSZaCvUyqDkTDMmm0zeloQ2x0=
X-Received: by 2002:a17:902:f68e:b0:20b:7a54:fe6f with SMTP id
 d9443c01a7336-20bff039e02mr4274625ad.50.1727986851673; Thu, 03 Oct 2024
 13:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
In-Reply-To: <20241003113840.2972416-1-usamaarif642@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 3 Oct 2024 13:20:10 -0700
Message-ID: <CAGETcx9r+VwMBt=Ra-+-ZFgO66DK1LGjbT8cXFZ7v-c-N20qTQ@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org, 
	catalin.marinas@arm.com, robh@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:38=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
>  __pa() is only intended to be used for linear map addresses and using
> it for initial_boot_params which is in fixmap for arm64 will give an
> incorrect value. Hence stash the physical address when it is known at
> boot time and use it at kexec time instead of converting the virtual
> address using __pa().
>
> Reported-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> ---
>  arch/arm64/kernel/setup.c | 8 ++++++++
>  drivers/of/fdt.c          | 6 ++++++
>  drivers/of/kexec.c        | 8 ++++++--
>  include/linux/of_fdt.h    | 2 ++
>  4 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index b22d28ec8028..a4d96f5e2e05 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_=
phys)
>         /* Early fixups are done, map the FDT as read-only now */
>         fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>
> +       /*
> +        * Save dt_phys address so that it can be used later for kexec. T=
his
> +        * is done as __pa() is only intended to be used for linear map a=
ddresses
> +        * and using it for initial_boot_params which is in fixmap will g=
ive an
> +        * incorrect value.
> +        */
> +       set_initial_boot_params_pa(dt_phys);
> +
>         name =3D of_flat_dt_get_machine_name();
>         if (!name)
>                 return;
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4d528c10df3a..9e312b7c246e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -457,6 +457,7 @@ int __initdata dt_root_addr_cells;
>  int __initdata dt_root_size_cells;
>
>  void *initial_boot_params __ro_after_init;
> +phys_addr_t initial_boot_params_pa __ro_after_init;
>
>  #ifdef CONFIG_OF_EARLY_FLATTREE
>
> @@ -1185,6 +1186,11 @@ bool __init early_init_dt_scan(void *params)
>         return true;
>  }
>
> +void __init set_initial_boot_params_pa(phys_addr_t params)
> +{
> +       initial_boot_params_pa =3D params;
> +}
> +
>  static void *__init copy_device_tree(void *fdt)
>  {
>         int size;
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 9ccde2fd77cb..ca9f27b27f71 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -300,8 +300,12 @@ void *of_kexec_alloc_and_setup_fdt(const struct kima=
ge *image,
>                 goto out;
>         }
>
> -       /* Remove memory reservation for the current device tree. */
> -       ret =3D fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
> +       /* Remove memory reservation for the current device tree.
> +        * For arm64, initial_boot_params is a fixmap address, hence __pa=
(),
> +        * can't be used to get the physical address.
> +        */
> +       ret =3D fdt_find_and_del_mem_rsv(fdt, IS_ENABLED(CONFIG_ARM64) ?
> +                                      initial_boot_params_pa : __pa(init=
ial_boot_params),
>                                        fdt_totalsize(initial_boot_params)=
);

Not sure about the correctness of the patch (not a kexec expert) but
no need to do all of this inside a function parameter. Just create a
variable and use it here.

-Saravana

>         if (ret =3D=3D -EINVAL) {
>                 pr_err("Error removing memory reservation.\n");
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index d69ad5bb1eb1..dbd99bf21ac8 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -31,6 +31,7 @@ extern void *of_fdt_unflatten_tree(const unsigned long =
*blob,
>  extern int __initdata dt_root_addr_cells;
>  extern int __initdata dt_root_size_cells;
>  extern void *initial_boot_params;
> +extern phys_addr_t initial_boot_params_pa;
>
>  extern char __dtb_start[];
>  extern char __dtb_end[];
> @@ -73,6 +74,7 @@ extern int early_init_dt_scan_root(void);
>  extern bool early_init_dt_scan(void *params);
>  extern bool early_init_dt_verify(void *params);
>  extern void early_init_dt_scan_nodes(void);
> +extern void set_initial_boot_params_pa(phys_addr_t params);
>
>  extern const char *of_flat_dt_get_machine_name(void);
>  extern const void *of_flat_dt_match_machine(const void *default_match,
> --
> 2.43.5
>

