Return-Path: <linux-kernel+bounces-429373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E39E1B45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E5828312C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982501E411D;
	Tue,  3 Dec 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHzPgPeG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAC1E47C7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226593; cv=none; b=sPNqxGA2wIuJYp5CAERR5FFIwsvCQQLtNvnTE3iYWyD7GKskcei1GZDmmVB7zxVbpcWPSduzOIR/YTLLHFzAIEyqMjtfjrESvCkIkKFGAgmotqOKXYYUPjKCB9ErlMlUZqCV42Fgs+EMyMQICb9iEs9SBhRMoL+iSBoGM9PYaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226593; c=relaxed/simple;
	bh=5UcwQIsn40BIxdhHcGTQTDp+iAklLtu32KB1efUjEP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pd92fxoSCLCpkdEej481+Ea/IBoVlnzeCQVUTSti5lO8C+75bVVE9CL/gvkNpkkUhedNYrm+8ChVA+na+C6S+p9NYNGtU5fMZbY+XftiWXPnEV56n0YpgNWCbKtkVO0cMFzWFei+sjjRPSXZE0an8uwEx3h34doBZyzlhe2w20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHzPgPeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257EDC4CEDE;
	Tue,  3 Dec 2024 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733226592;
	bh=5UcwQIsn40BIxdhHcGTQTDp+iAklLtu32KB1efUjEP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EHzPgPeGpADcqtB+nzAh6/4gOdxWmEBX62EIAAwIQZz49u3DB3zDevlgwVGv3NVDK
	 hys0rXPTPkwgaf6dc60Fh1Q8xydQWjJfh+RecyQ8ShoxW2/va2WrTVAFFIgwaXUgOS
	 lqUI246kZ7QHpcSWmSALaj4h/Dky0zw9lohK+wCm9ktUuPp/fPaD82SAL7q0KgDEFn
	 ZE4GL8m7CAjLKuPkfmkp2rqi1+8K5ttdU6Rz/EKIX3PEkeJ17o0n3o8FI6h5ewrGli
	 ssjh4P89ACmzAlUxFuFVePtodkuIv9PFOXk/6pxfSgz8n6/wcqejwTr9pm4JoIhBHT
	 PYgXoTYn/7vKg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: lihangjing@bytedance.com, xieyongji@bytedance.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xu Lu
 <luxu.kernel@bytedance.com>
Subject: Re: [PATCH] riscv: mm: Fix alignment of phys_ram_base
In-Reply-To: <20241202101601.48284-1-luxu.kernel@bytedance.com>
References: <20241202101601.48284-1-luxu.kernel@bytedance.com>
Date: Tue, 03 Dec 2024 12:49:49 +0100
Message-ID: <871pypq942.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xu Lu <luxu.kernel@bytedance.com> writes:

> This commit fixes the alignment of phys_ram_base in RISC-V.
>
> In sparse vmemmap model, the virtual address of vmemmap is calculated as:
> '(struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)'.
> And the struct page's va can be calculated with an offset:
> 'vmemmap + (pfn)'.
>
> However, when initializing struct pages, kernel actually starts from the
> first page from the same section that phys_ram_base belongs to. If the
> first page's physical address is not 'phys_ram_base >> PAGE_SHIFT', then
> we get an va below VMEMMAP_START when calculating va for it's struct page.

Nice catch! I managed to reproduce this on a hacked qemu virt machine.

> For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
> first page in the same section is actually pfn 0x80000. During
> init_unavailage_range, we will initialize struct page for pfn 0x80000

"init_unavailable_range()" spelling for greppability.

> with virtual address '(struct page *)VMEMMAP_START - 0x2000', which is
> below VMEMMAP_START as well as PCI_IO_END.
>
> This commit fixes this bug by aligning phys_ram_base with SECTION_SIZE.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

Please add a fixes tag.

> ---
>  arch/riscv/mm/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0e8c20adcd98..9866de267b74 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -59,6 +59,8 @@ EXPORT_SYMBOL(pgtable_l4_enabled);
>  EXPORT_SYMBOL(pgtable_l5_enabled);
>  #endif
>=20=20
> +#define RISCV_MEMSTART_ALIGN	(1UL << SECTION_SIZE_BITS)
> +
>  phys_addr_t phys_ram_base __ro_after_init;
>  EXPORT_SYMBOL(phys_ram_base);
>=20=20
> @@ -241,7 +243,8 @@ static void __init setup_bootmem(void)
>  	 * at worst, we map the linear mapping with PMD mappings.
>  	 */
>  	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> -		phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> +		phys_ram_base =3D round_down(memblock_start_of_DRAM(),
> +					   RISCV_MEMSTART_ALIGN);

No need to wrap this line. Also, is the RISCV_MEMSTART_ALIGN define
really needed?

The kernel test robot had some build issues as well!


Bj=C3=B6rn

