Return-Path: <linux-kernel+bounces-292006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC490956A00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79749286BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1C167D97;
	Mon, 19 Aug 2024 11:56:08 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6E166F3B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068567; cv=none; b=hF1zE+m8x+XdBE4Adcs9nBmyPzkeB12tRiV4dpqzvHYCWN1+cWd5SjdsLtSvbAMaf3SXC5HSSaAlNYqDAvmwJ7SxjjRP0+NO66Emt9Vwkz4AB3X+ijwTLieSg1pfVw0Mf/MdJ1huJFf0W4yekX+1lI+nzBukwdV0aoonpJ12GKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068567; c=relaxed/simple;
	bh=V+2JVs1WxHSCRsBcxpp1ZwKwkQtmeu4Z5GD4sMZeeY8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWQoDeEmvqeitvaEZmClUjTfkOe1NiwRx1fiHkeuadVEUXx+rWjJYpAeOOvVAVR1C3qRJYx/nPh3Joq8DGAavNET3bEytzli7Va25ACl1Jx63heaLmLSpXHDvON/LqinWsimSw/NdXvTz8PeBJs3VldNbnqusLq1oCL/pNEPahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnWFL2mDwz6K9Hd;
	Mon, 19 Aug 2024 19:53:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A8AA140B2F;
	Mon, 19 Aug 2024 19:56:03 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 12:56:02 +0100
Date: Mon, 19 Aug 2024 12:56:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Tong Tiangen <tongtiangen@huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: Re: [PATCH v12 4/6] arm64: support copy_mc_[user]_highpage()
Message-ID: <20240819125601.0000687b@Huawei.com>
In-Reply-To: <20240528085915.1955987-5-tongtiangen@huawei.com>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
	<20240528085915.1955987-5-tongtiangen@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 28 May 2024 16:59:13 +0800
Tong Tiangen <tongtiangen@huawei.com> wrote:

> Currently, many scenarios that can tolerate memory errors when copying page
> have been supported in the kernel[1~5], all of which are implemented by
> copy_mc_[user]_highpage(). arm64 should also support this mechanism.
> 
> Due to mte, arm64 needs to have its own copy_mc_[user]_highpage()
> architecture implementation, macros __HAVE_ARCH_COPY_MC_HIGHPAGE and
> __HAVE_ARCH_COPY_MC_USER_HIGHPAGE have been added to control it.
> 
> Add new helper copy_mc_page() which provide a page copy implementation with
> hardware memory error safe. The code logic of copy_mc_page() is the same as
> copy_page(), the main difference is that the ldp insn of copy_mc_page()
> contains the fixup type EX_TYPE_KACCESS_ERR_ZERO_ME_SAFE, therefore, the
> main logic is extracted to copy_page_template.S.
> 
> [1] commit d302c2398ba2 ("mm, hwpoison: when copy-on-write hits poison, take page offline")
> [2] commit 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage copy-on-write faults")
> [3] commit 6b970599e807 ("mm: hwpoison: support recovery from ksm_might_need_to_copy()")
> [4] commit 98c76c9f1ef7 ("mm/khugepaged: recover from poisoned anonymous memory")
> [5] commit 12904d953364 ("mm/khugepaged: recover from poisoned file-backed memory")
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Trivial stuff inline.

Jonathan


> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 5018ac03b6bf..50ef24318281 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -80,6 +80,35 @@ SYM_FUNC_START(mte_copy_page_tags)
>  	ret
>  SYM_FUNC_END(mte_copy_page_tags)
>  
> +#ifdef CONFIG_ARCH_HAS_COPY_MC
> +/*
> + * Copy the tags from the source page to the destination one wiht machine check safe
Spell check.
with

Also, maybe reword given machine check doesn't make sense on arm64.


> + *   x0 - address of the destination page
> + *   x1 - address of the source page
> + * Returns:
> + *   x0 - Return 0 if copy success, or
> + *        -EFAULT if anything goes wrong while copying.
> + */
> +SYM_FUNC_START(mte_copy_mc_page_tags)
> +	mov	x2, x0
> +	mov	x3, x1
> +	multitag_transfer_size x5, x6
> +1:
> +KERNEL_ME_SAFE(2f, ldgm	x4, [x3])
> +	stgm	x4, [x2]
> +	add	x2, x2, x5
> +	add	x3, x3, x5
> +	tst	x2, #(PAGE_SIZE - 1)
> +	b.ne	1b
> +
> +	mov x0, #0
> +	ret
> +
> +2:	mov x0, #-EFAULT
> +	ret
> +SYM_FUNC_END(mte_copy_mc_page_tags)
> +#endif
> +
>  /*
>   * Read tags from a user buffer (one tag per byte) and set the corresponding
>   * tags at the given kernel address. Used by PTRACE_POKEMTETAGS.
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index a7bb20055ce0..ff0d9ceea2a4 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -40,3 +40,48 @@ void copy_user_highpage(struct page *to, struct page *from,

> +
> +int copy_mc_user_highpage(struct page *to, struct page *from,
> +			unsigned long vaddr, struct vm_area_struct *vma)
> +{
> +	int ret;
> +
> +	ret = copy_mc_highpage(to, from);
> +	if (!ret)
> +		flush_dcache_page(to);
Personally I'd always keep the error out of line as it tends to be
more readable when reviewing a lot of code.
	if (ret)
		return ret;

	flush_dcache_page(to);

	return 0;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_mc_user_highpage);
> +#endif


