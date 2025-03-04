Return-Path: <linux-kernel+bounces-544142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9276CA4DDD4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28EB1782A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252D820298A;
	Tue,  4 Mar 2025 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg0y9E2s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5478F4C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091119; cv=none; b=Oqefu4Mk6VpIp6yr8Yy5m51j9EhDNaXAm6MUBOEhByOKVoYU5EOp6XiChPSAv+wfDqS19sUiEkfE5ZLJjoZTja1iR9w1NOqZ0fES6xfFa8vDLSdlvuSHtfrNA30I4hKfM7iJO01lE4+Ja1YOCC9pw0YjBRcz8nf7n3zya1oYqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091119; c=relaxed/simple;
	bh=+SQIqfuPQGlhPLydbzZug4XPIpy3ANWjl4UsoMWLAOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGkRGhjzgPdrQ66vvV3lgt9OHcXmcRqVjD3Qj6uEJKhcyDRoiqnbbdxiYlqCkgBsEkAV4+izzoAZjxikLXGphSSx6kbRJ8EzDSU9ce/JkwdNRN3FNrxOiVURxr17z6agz3NhD53yNn2PTgsY3/yfhfSKolhdypgL/pXgHKI9OuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg0y9E2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DFDC4CEEB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741091119;
	bh=+SQIqfuPQGlhPLydbzZug4XPIpy3ANWjl4UsoMWLAOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rg0y9E2srMnpJ0vkn/NxDD/Zo11h+pw4YlXKrOzS1YwzQhkVkUJ2G7EEjCiAR+gzN
	 OvbbkVodyKukw78n6H9nn428+6DK18drFCl/BwVbRgWcOoaJd9hpRmxadg3jkqLYZO
	 MZ0s9NMe78ay6uvwNZMlDJYQUw5QCJvDxlgb4MwucTgeia0t1WmTjMtkYjzquNixWk
	 AfRLsJGv7ASdiGordnYbyBy93TIXXohycU2+ymPmPWKJGwIexlIeZsQu03g469ptSz
	 d9sEuOpDNmEnopbEUD7ejZYcahErYG0OYteuLCrth8ZVVKN7T6AQ7so2VUr0SIfZiT
	 K8UD7zV5fm2Og==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf4802b242so608426266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:25:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuhwRzg1dllMIh6btnrYjYvnsTrR2Ba4+s+pDvce5FcTthhs3A4PqIcprxEf4KSc7zB8Kr50nHmVvGDL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GkiDyVp/YivkPQPnacmxJ6QP2LOaqNJ/kGou/zs7BcSx2rIy
	ED7JZnS/Mr097cQ4TT3pstP5jVLceL1IpQPalmNTV0nQCNqO8W9a+fS1kcB2TB1g+siyUeR3iV2
	OtJ4jOGNDtr/x3QV6XXhwIckUzNc=
X-Google-Smtp-Source: AGHT+IHTM2B6gBG2tuNtbvGhXs0HRVKxnREPumHz+CUuDza6UnEgzUL4jYxv6z9dkqEEldaNE741AH1fQTec1gE2Dgo=
X-Received: by 2002:a17:907:7205:b0:abf:752c:9e33 with SMTP id
 a640c23a62f3a-abf752ca22emr747133766b.2.1741091117515; Tue, 04 Mar 2025
 04:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304112708.1810033-1-maobibo@loongson.cn>
In-Reply-To: <20250304112708.1810033-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 4 Mar 2025 20:25:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7ZAK15ob3M=5eQrOhPvkSFhkrmVHd-mn6RXgQqQV_Ebg@mail.gmail.com>
X-Gm-Features: AQ5f1JqF5QhZxAFTxQdMCNiNL9NNlex1F3CaHUyR2YHD8bmyPO4_3TAL-reJgaI
Message-ID: <CAAhV-H7ZAK15ob3M=5eQrOhPvkSFhkrmVHd-mn6RXgQqQV_Ebg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: mm: Set max_pfn with the PFN of the last page
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Mar 4, 2025 at 7:27=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> The current max_pfn equals to zero. In this case, it caused users cannot
> get some page information through /proc such as kpagecount. The following
> message is displayed by stress-ng test suite with the command
> "stress-ng --verbose --physpage 1 -t 1".
>
>  # stress-ng --verbose --physpage 1 -t 1
>  stress-ng: error: [1691] physpage: cannot read page count for address 0x=
134ac000 in /proc/kpagecount, errno=3D22 (Invalid argument)
>  stress-ng: error: [1691] physpage: cannot read page count for address 0x=
7ffff207c3a8 in /proc/kpagecount, errno=3D22 (Invalid argument)
>  stress-ng: error: [1691] physpage: cannot read page count for address 0x=
134b0000 in /proc/kpagecount, errno=3D22 (Invalid argument)
>  ...
>
> After applying this patch, the kernel can pass the test.
>  # stress-ng --verbose --physpage 1 -t 1
>  stress-ng: debug: [1701] physpage: [1701] started (instance 0 on CPU 3)
>  stress-ng: debug: [1701] physpage: [1701] exited (instance 0 on CPU 3)
>  stress-ng: debug: [1700] physpage: [1701] terminated (success)
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
I think this patch are mainly fix commit
ff6c3d81f2e86b63a3a530683f89ef39 ("NUMA: optimize detection of memory
with no node id assigned by firmware"). So it is better to add a
Fixes: tag and Cc stable.

And the patch itself can be improved. there are three cases of
calculating max_low_pfn:
ACPI with NUMA, handled in numa.c
ACPI without NUMA, handled in mem.c
FDT, handled in setup.c

You have missed the 2nd case. The simplest way is add "max_pfn =3D
max_low_pfn" at the beginning of arch_mem_init() because all cases can
be handled here.

Huacai

> ---
>  arch/loongarch/kernel/numa.c  | 2 +-
>  arch/loongarch/kernel/setup.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 84fe7f854820..002dbe62b329 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -356,7 +356,7 @@ int __init init_numa_memory(void)
>                 node_mem_init(node);
>                 node_set_online(node);
>         }
> -       max_low_pfn =3D PHYS_PFN(memblock_end_of_DRAM());
> +       max_low_pfn =3D max_pfn =3D PHYS_PFN(memblock_end_of_DRAM());
>
>         setup_nr_node_ids();
>         loongson_sysconf.nr_nodes =3D nr_node_ids;
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index edcfdfcad7d2..ab8c9336d8f5 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -294,7 +294,7 @@ static void __init fdt_setup(void)
>         early_init_dt_scan(fdt_pointer, __pa(fdt_pointer));
>         early_init_fdt_reserve_self();
>
> -       max_low_pfn =3D PFN_PHYS(memblock_end_of_DRAM());
> +       max_low_pfn =3D max_pfn =3D PFN_PHYS(memblock_end_of_DRAM());
>  #endif
>  }
>
> --
> 2.39.3
>

