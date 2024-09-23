Return-Path: <linux-kernel+bounces-335387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E397E4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 04:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4668B20C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9A14437;
	Mon, 23 Sep 2024 02:59:33 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D42CA9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727060372; cv=none; b=sW3wlTiugdiDe94nhlKDTB+lNm6RtaXPNOgoF4aoAz0cai3d3a9GEQ0bNjwFZop5tpVYaTxElPMHit7gjjYaQZonnDe+v4BLWbVms7/opu9lPmDgkFXFf46yqT4DIl8EGWCB/+3z0GfXMRZqaaDEU0M9FRR6va9hOxlCR+cWQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727060372; c=relaxed/simple;
	bh=1TwD2fguqqcYfVxdFJclFZ+WJcPhDSswcuLLQ0U5VuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTLvvV52QE3VAw1RMUxXem51tRJXtf54PT7lXx2y3qRswTYqzxORFRZHmQgrEslE9AE94jDm8elVFyrgmY5diwzqe6bkwv7P8Ldvj+ZtWJnUosTb24pnEMH3XrN1+qAESxXQjO/tH6U59GWQJlG9lOwT3qhqvG7rCkDE9zliW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1727060282tghpij9e
X-QQ-Originating-IP: z6kSYKOZj9tF/CadInEk8vWIdrNPbqJLGykFKaAzUAw=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Sep 2024 10:58:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17443238697871441029
Date: Mon, 23 Sep 2024 10:57:27 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn, luming.yu@gmail.com
Subject: Re: [RFC PATCH] powerpc/tlb: enable arch want batched unmap tlb flush
Message-ID: <3A7F514D32DFA545+ZvDZF58z6KTRqRjG@HX09040029.powercore.com.cn>
References: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
 <87frpsymf2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frpsymf2.fsf@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

On Sun, Sep 22, 2024 at 04:39:53PM +0530, Ritesh Harjani wrote:
> Luming Yu <luming.yu@shingroup.cn> writes:
> 
> > From: Yu Luming <luming.yu@gmail.com>
> >
> > ppc always do its own tracking for batch tlb. By trivially enabling
> > the ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH in ppc, ppc arch can re-use
> > common code in rmap and reduce overhead and do optimization it could not
> > have without a tlb flushing context at low architecture level.
> 
> I looked at this patch and other than the compile failure, this patch
> still won't optimize anything. The idea of this config is that we want
> to batch all the tlb flush operation at the end. By returning false from
> should_defer_flush() (in this patch), we are saying we cannot defer
> the flush and hence we do tlb flush in the same context of unmap.
not exactly, as false return implies, we currently do nothing but relying on
book3S_64's tlb batch implementation which contains a bit of defer optimization
that we need to use a real benchmark to do some performance characterization.

And I need to get my test bed ready for patch testing first. So I have to
defer the real optimization in this area.
> 
> Anyway, I took a quick look at ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> and I have a quick PoC for the same. I will soon post it.
thanks for picking up the barton for the future collaboration on the
potential common performance benefits among us for powerpc arch.
> 
> -ritesh
> 
> >
> > Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> > ---
> >  arch/powerpc/Kconfig                |  1 +
> >  arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >  create mode 100644 arch/powerpc/include/asm/tlbbatch.h
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index e94e7e4bfd40..e6db84dd014a 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -175,6 +175,7 @@ config PPC
> >  	select ARCH_WANT_IPC_PARSE_VERSION
> >  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
> >  	select ARCH_WANT_LD_ORPHAN_WARN
> > +	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> >  	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
> >  	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
> >  	select ARCH_WEAK_RELEASE_ACQUIRE
> > diff --git a/arch/powerpc/include/asm/tlbbatch.h b/arch/powerpc/include/asm/tlbbatch.h
> > new file mode 100644
> > index 000000000000..484628460057
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/tlbbatch.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ARCH_PPC_TLBBATCH_H
> > +#define _ARCH_PPC_TLBBATCH_H
> > +
> > +struct arch_tlbflush_unmap_batch {
> > +	/*
> > +         *
> > +	 */
> > +};
> > +
> > +static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > +{
> > +}
> > +
> > +static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> > +						struct mm_struct *mm,
> > +						unsigned long uarddr)
> > +{
> > +}
> > +
> > +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> > +{
> > +	/*ppc always do tlb flush in batch*/
> > +	return false;
> > +}
> > +
> > +static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> > +{
> > +}
> > +#endif /* _ARCH_PPC_TLBBATCH_H */
> > -- 
> > 2.42.0.windows.2
> 


