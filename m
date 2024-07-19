Return-Path: <linux-kernel+bounces-257565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1F937BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034BF282994
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B7A146587;
	Fri, 19 Jul 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogeL58es"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BD2746B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412163; cv=none; b=L32Vf3fRvYox7FpU4DShJ44FpWrOC5Bviz7FMsatBWNXgWSXqczt2Jdy4c8cj+OgenfanTJRrRKlM9i/sv5S8y2fZvmN2ey/ZDR32eKEQREncJ6pEhnEHe7aS5s/hB0Y6F0RgXAnJ2vVvINbevsOJvd/yD7AC4Wgm/JVulhWQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412163; c=relaxed/simple;
	bh=n1FqbzjvL4oeiSE+vq0cxm8HZQx17StXvNMY2i+PePY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkumLHFdxEa+jTDE5anbHeVKgVdqHy3KKXmRVaSusJWh8Z2fpWD9BQQkUiB4N7GscWOuDKrERbrmScXWZ+nyZYavKZv/4L/9Cbvtyhga9oTSBpx2Iz+GdvVvF0FlMW4lz/ZwnvA3gAWNBCegGe72flt/8CgyLLlJPko+OFHhwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogeL58es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DB7C4AF0A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721412162;
	bh=n1FqbzjvL4oeiSE+vq0cxm8HZQx17StXvNMY2i+PePY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ogeL58esXl77oq2Zo5Pekycl0w01K+pGYBajI2l2WC/MF2JKvXu849ERSxJm2fe1x
	 LGGZad1Js+G7NFQGe/bpxrAfTYAE6C8tiVOq6ZukWwZ+7YDz4HfM6y2V+3YLLo75pt
	 70jcMtIqeAHLPJkw0SN0k2nXR5+WkhsHD7yBfE6zQ728W9J/mCG56m3STAWH2qbtdy
	 Z/yiCYIodH3DWHd1EGH4CWa4GoomfOlA+V3oA7tasoAVzPdAwoGpoUE3ROHKH6u5rf
	 cxDF5x3Zu8Zb8owLmQAKEKWrVTAU43gZyEMaapQQDpEunzSiOk/BhXAlAM50eX8njk
	 9tN8mdPpybD3A==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so2553986e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:02:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrpttpcvdZcclVjeCKqjOfghlUyiTnsZXBbL5yQcQe5lDt+ZjzUqfUqAbqN2FG4yBCSMOJr14jIugl45VLV/x/eW7m3k52q4jWFbLY
X-Gm-Message-State: AOJu0Ywo1Reys3DWIkxILfgogj3gJFjX1lm+/WC5dmgpenNnrPqSiJF0
	GgqyGMFDWzKkYaoJr/2TjVNu1/KwaboNrpVe/N4fiIVWPklX5AqzCKPMtzkMBqsjsv2WmywAxNu
	qyFJCpKIA6RM0INfNThSD+0nZgjY=
X-Google-Smtp-Source: AGHT+IHdVWJSMOJxE8p+Abn2JQ25UNR6Oqo7buQXEDwsnwYETG8oBRMNNZyFdqWYUNefLoY1WYzkR1+tJv19zPWkQoQ=
X-Received: by 2002:a2e:8ed2:0:b0:2ec:543a:b629 with SMTP id
 38308e7fff4ca-2ef168268d8mr3248841fa.34.1721412161045; Fri, 19 Jul 2024
 11:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net> <20240718131428.GA21243@willie-the-truck>
In-Reply-To: <20240718131428.GA21243@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Jul 2024 11:02:29 -0700
X-Gmail-Original-Message-ID: <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
Message-ID: <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
To: Will Deacon <will@kernel.org>
Cc: Asahi Lina <lina@asahilina.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 06:14, Will Deacon <will@kernel.org> wrote:
>
> Hi Lina, [+Ard, Mark and Ryan],
>
> On Thu, Jul 18, 2024 at 06:39:10PM +0900, Asahi Lina wrote:
> > I ran into this with the Asahi Linux downstream kernel, based on v6.9.9,
> > but I believe the problem is also still upstream. The issue seems to be
> > an interaction between folding one page table level at compile time and
> > another one at runtime.
>
> Thanks for reporting this!
>
> > With this config, we have:
> >
> > CONFIG_PGTABLE_LEVELS=4
> > PAGE_SHIFT=14
> > PMD_SHIFT=25
> > PUD_SHIFT=36
> > PGDIR_SHIFT=47
> > pgtable_l5_enabled() == false (compile time)
> > pgtable_l4_enabled() == false (runtime, due to no LPA2)
>
> I think this is 'defconfig' w/ 16k pages, although I wasn't able to
> trigger the issue quickly under QEMU with that. Your analysis looks
> correct, however.
>
> > With p4d folded at compile-time, and pud folded at runtime when LPA2 is
> > not supported.
> >
> > With this setup, pgd_offset() is broken since the pgd is actually
> > supposed to become a pud but the shift is wrong, as it is set at compile
> > time:
> >
> > #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> >
> > static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
> > {
> >         return (pgd + pgd_index(address));
> > };
> >
> > Then we follow the gup logic (abbreviated):
> >
> > gup_pgd_range:
> >     pgdp = pgd_offset(current->mm, addr);
> >     pgd_t pgd = READ_ONCE(*pgdp);
> >
> > At this point, pgd is just the 0th entry of the top level page table
> > (since those extra address bits will always be 0 for valid 47-bit user
> > addresses).
> >
> > p4d then gets folded via pgtable-nop4d.h:
> >
> > gup_p4d_range:
> >     p4dp = p4d_offset_lockless(pgdp, pgd, addr);
> >          = p4d_offset(&(pgd), address)
> >          = &pgd
> >     p4d_t p4d = READ_ONCE(*p4dp);
> >
> > Now we have p4dp = stack address of pgd, and p4d = pgd.
> >
> > gup_pud_range:
> >     pudp = pud_offset_lockless(p4dp, p4d, addr);
> >          -> if (!pgtable_l4_enabled())
> >            = p4d_to_folded_pud(p4dp, addr);
> >            = (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
> >     pud_t pud = READ_ONCE(*pudp);
> >
> > Which is bad pointer math because it only works if p4dp points to a real
> > page table entry inside a page table, not a single u64 stack address.
>
> Cheers for the explanation; I agree that 6.10 looks like it's affected
> in the same way, even though I couldn't reproduce the crash. I think the
> root of the problem is that p4d_offset_lockless() returns a stack
> address when the p4d level is folded. I wondered about changing the
> dummy pXd_offset_lockless() definitions in linux/pgtable.h to pass the
> real pointer through instead of the address of the local, but then I
> suppose _most_ pXd_offset() implementations are going to dereference
> that and it would break the whole point of having _lockless routines
> to start with.
>
> What if we provided our own implementation of p4d_offset_lockless()
> for the folding case, which could just propagate the page-table pointer?
> Diff below.
>
> > This causes random oopses in internal_get_user_pages_fast and related
> > codepaths.
>
> Do you have a reliable way to trigger those? I tried doing some GUPpy
> things like strace (access_process_vm()) but it all seemed fine.
>

Thanks for the cc, and thanks to Lina for the excellent diagnosis -
this is really helpful.

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index f8efbc128446..3afe624a39e1 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1065,6 +1065,13 @@ static inline bool pgtable_l5_enabled(void) { return false; }
>
>  #define p4d_offset_kimg(dir,addr)      ((p4d_t *)dir)
>
> +static inline
> +p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)

This is in the wrong place, I think - we already define this for the
5-level case (around line 1760).

We'll need to introduce another version for the 4-level case, so
perhaps, to reduce the risk of confusion, we might define it as

static inline
p4d_t *p4d_offset_lockless_folded(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
{
...
}
#ifdef __PAGETABLE_P4D_FOLDED
#define p4d_offset_lockless p4d_offset_lockless_folded
#endif


> +{

We might add

if (pgtable_l4_enabled())
    pgdp = &pgd;

here to preserve the existing 'lockless' behavior when PUDs are not folded.


> +       return p4d_offset(pgdp, addr);
> +}
> +#define p4d_offset_lockless p4d_offset_lockless
> +
>  #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
>

I suggest we also add something like the below so we can catch these
issues more easily

--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -874,9 +874,26 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)

 static inline pud_t *p4d_to_folded_pud(p4d_t *p4dp, unsigned long addr)
 {
+       /*
+        * The transformation below does not work correctly for descriptors
+        * copied to the stack.
+        */
+       VM_WARN_ON((u64)p4dp >= VMALLOC_START && !__is_kernel((u64)p4dp));
+
        return (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
 }

