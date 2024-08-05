Return-Path: <linux-kernel+bounces-274661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F57947B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E2D1F21B42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AF15ADB4;
	Mon,  5 Aug 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U02RhgKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307CE1E49F;
	Mon,  5 Aug 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862232; cv=none; b=T3chT2XZvZxaEIJN64PG6ogKzQkCcBJigq5Q2sc2lvDOe85boLbipdRa13nEgyJKN1fEzyalUwm3X0dtSuIuTX8ACTBQboUrrn9BiMxNst4ADi6uaghCVejujzsmbr8vD/TsFECNdEEAEEmu3xazmPcdslfhjG+3fy2aYiO4nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862232; c=relaxed/simple;
	bh=uni8GbJ90dEK4yPCsHOXZFDmkXftX7h9gqgR4VgoZg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQRzAzIFptIy8ABT2NvyI0JkwJG9w4Usp9T7DZQqL6Ri7Rrhe+W8OmnC9+6klSoJO7GW3ck5+BzoSLCWKwPO+01aL9OCVAb17Ae0jGwF5aXCV6twPYLccZMaKKtMME5CPprFGyYcf8SHQczB2EAV9O5ZSbOQN02Dol5yVeCmcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U02RhgKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388B6C4AF13;
	Mon,  5 Aug 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862231;
	bh=uni8GbJ90dEK4yPCsHOXZFDmkXftX7h9gqgR4VgoZg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U02RhgKHLpjgNWvzjTEry7OkszkU6xZOSk+3F6LzLAIIFH8Nz2dGUXzXXGQM9o9Ad
	 gGfCWm9+bdCjU9+Bz3p+fCiEW/EeeV5EqhhFvXTbwh2ZeTzv25CVrOoklMOLyjkbzL
	 ronqafd7s2XTOP6ZSzp5itKoSmoALU1FRf+bDoHMMD1EkNDHgmDQwqm6XMjk97B1ao
	 LqnlgpXx/p4j6gNNl5KJx7rCcmUsj4iaieAMHjqy4AypSEuQ/LFD6YZbO4ljyzeuJI
	 orrfy4Z0EBuoYOUGrcqmy2bCht1kyAY3D0bVaSJgNNmxksyBGFJutMvdoGtLKjcKt7
	 MN/rns3EgH5+w==
Date: Mon, 5 Aug 2024 14:50:24 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v1 2/4] x86/tdx: Add validation of userspace MMIO
 instructions
Message-ID: <ZrDKkD4M4AKOFqb8@example.org>
References: <cover.1722356794.git.legion@kernel.org>
 <855a5d97f0e76373e76c5124f415d3abd7ae3699.1722356794.git.legion@kernel.org>
 <mnncaxyk6jsbtlxk6xo5jvs7mzirp3ituyf7anequxy6xjjijm@ogkxlksd4gi6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnncaxyk6jsbtlxk6xo5jvs7mzirp3ituyf7anequxy6xjjijm@ogkxlksd4gi6>

On Fri, Aug 02, 2024 at 10:41:17AM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 30, 2024 at 07:35:57PM +0200, Alexey Gladkov (Intel) wrote:
> > +static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
> > +			unsigned long vaddr)
> > +{
> > +	phys_addr_t phys_addr;
> > +	bool writable = false;
> > +
> > +	/* It's not fatal. This can happen due to swap out or page migration. */
> > +	if (get_phys_addr(vaddr, &phys_addr, &writable) || (ve->gpa != cc_mkdec(phys_addr)))
> > +		return -EAGAIN;
> 
> I think we need big fat comment here why these checks are needed.
> 
> We have ve->gpa and it was valid at the time we got ve_info. But after we
> get ve_info, we enable interrupts allowing tlb shootdown and therefore
> munmap() in parallel thread of the process.
> 
> So by the time we've got here ve->gpa might be unmapped from the process,
> the device it belongs to removed from system and something else could be
> plugged in its place.
> 
> That's why we need to re-check if the GPA is still mapped and writable if
> we are going to write to it.

Make sense. I will add bigger comment here.

> > +
> > +	/* Check whether #VE info matches the instruction that was decoded. */
> > +	switch (mmio) {
> > +	case INSN_MMIO_WRITE:
> > +	case INSN_MMIO_WRITE_IMM:
> > +		if (!writable || !(ve->exit_qual & EPT_VIOLATION_ACC_WRITE))
> > +			return -EFAULT;
> > +		break;
> > +	case INSN_MMIO_READ:
> > +	case INSN_MMIO_READ_ZERO_EXTEND:
> > +	case INSN_MMIO_READ_SIGN_EXTEND:
> > +		if (!(ve->exit_qual & EPT_VIOLATION_ACC_READ))
> > +			return -EFAULT;
> > +		break;
> > +	default:
> > +		WARN_ONCE(1, "Unsupported mmio instruction: %d", mmio);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

-- 
Rgrds, legion


