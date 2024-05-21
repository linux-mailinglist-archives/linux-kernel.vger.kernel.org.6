Return-Path: <linux-kernel+bounces-185201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D88CB1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F891F22178
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F271C6A7;
	Tue, 21 May 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCo9ASI2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7A1B966
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307769; cv=none; b=oiNG7FRYXDbGIFPg27C5QGh1ebPaUmZhPrGBohokN8QAJVBq++YFwIeRiHDPyI9hhi1cJzgd0VuH+2oE32JKegfsUUgkX1YhQCWlWuZ19mxYz17Tcf01Iepe6C8HWLAVilgtT647qJKYcAu43rZEq/2UWlFTn6eQsHZl+/BZ7nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307769; c=relaxed/simple;
	bh=RkSBxB1mPmJZ/DR8Fr08TnX1zxdKqejkPexNssbR7dQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gf9+GqrXxAXprqQWjoZoIlEUxRBkR1ovZRjNs0085MKoCY3sMmInfpuvdcjqOmi32GBoXJLPhPoI0dPaK7wPJx1FRSJ9evGJt0Kqdw+rAGAOdSr2zFELNey+98N3QwAT0x526aaCfaJU03Q7Z44OcHawxmP4VcX9DJDDuHdFsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCo9ASI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E5AC2BD11;
	Tue, 21 May 2024 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716307769;
	bh=RkSBxB1mPmJZ/DR8Fr08TnX1zxdKqejkPexNssbR7dQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YCo9ASI2Js2y0lYzH+ndmKVe0VBlFTGkycxT7Zujt14aad9AwhyXNS7KaKggq6hOZ
	 CjqBuMvBipIHRI0dSeAnRaGdIWq9dw+lco9sDto8ytsjwHOsLdjahwZxFEMUyF2PJo
	 rsSN3ldZuKLPl165ORt4ogze7omXIAaPwrKrmNWACeG75cOkrx5NAC189ciVuC4xpg
	 Dh8KVRkGsbWFABrokxiEiOf/Gc1ifElhhLSV1S7Fye8UgqFZ5Ir1yPlX4Yr65gHiyY
	 28FCxQDb2DcdZ6d5HsyVkKt/PaQmniprxTRaBhweDbGOnULeN9u2tGzvd6gEdrMkEp
	 /B4suKzHDu8yg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou
 <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Andrew Bresticker
 <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/9] riscv: mm: Pre-allocate vmemmap/direct map PGD
 entries
In-Reply-To: <20240521114830.841660-3-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
 <20240521114830.841660-3-bjorn@kernel.org>
Date: Tue, 21 May 2024 18:09:25 +0200
Message-ID: <87frubdu4q.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V port copies the PGD table from init_mm/swapper_pg_dir to
> all userland page tables, which means that if the PGD level table is
> changed, other page tables has to be updated as well.
>
> Instead of having the PGD changes ripple out to all tables, the
> synchronization can be avoided by pre-allocating the PGD entries/pages
> at boot, avoiding the synchronization all together.
>
> This is currently done for the bpf/modules, and vmalloc PGD regions.
> Extend this scheme for the PGD regions touched by memory hotplugging.
>
> Prepare the RISC-V port for memory hotplug by pre-allocate
> vmemmap/direct map entries at the PGD level. This will roughly waste
> ~128 worth of 4K pages when memory hotplugging is enabled in the
> kernel configuration.
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/kasan.h | 4 ++--
>  arch/riscv/mm/init.c           | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasa=
n.h
> index 0b85e363e778..e6a0071bdb56 100644
> --- a/arch/riscv/include/asm/kasan.h
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -6,8 +6,6 @@
>=20=20
>  #ifndef __ASSEMBLY__
>=20=20
> -#ifdef CONFIG_KASAN
> -
>  /*
>   * The following comment was copied from arm64:
>   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
> @@ -34,6 +32,8 @@
>   */
>  #define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGD=
IR_MASK)
>  #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
> +
> +#ifdef CONFIG_KASAN
>  #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>=20=20
>  void kasan_init(void);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b66f846e7634..c98010ede810 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -27,6 +27,7 @@
>=20=20
>  #include <asm/fixmap.h>
>  #include <asm/io.h>
> +#include <asm/kasan.h>
>  #include <asm/numa.h>
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
> @@ -1488,10 +1489,16 @@ static void __init preallocate_pgd_pages_range(un=
signed long start, unsigned lon
>  	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
>  }
>=20=20
> +#define PAGE_END KASAN_SHADOW_START
> +
>  void __init pgtable_cache_init(void)
>  {
>  	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
>  	if (IS_ENABLED(CONFIG_MODULES))
>  		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
> +		preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
> +		preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direct map");

Alex pointed out that KASAN PGDs should be preallocated as well! I'll
address this in the next revision.


Bj=C3=B6rn

