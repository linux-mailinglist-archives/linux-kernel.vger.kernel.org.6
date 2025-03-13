Return-Path: <linux-kernel+bounces-559241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B85A5F136
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD91F3AF65C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF91EF097;
	Thu, 13 Mar 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLLh1Bwu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2672E3395
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862781; cv=none; b=exe0koO4h20mAc2X6AeqQIL1SYGijlNKo5cMBCvHi6/5q1GJd0CTO2NRFPzHJpdIuTlt9eHPqLNdoRwcWDDjntR+jPXx/1jEDzCn/RHIQ1tiYM4QkIrMF4pes1Ef3Wz1fiK/inJWgnoH5mCS6ccRFSEN6rIdvpLFBjQLM5a8PhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862781; c=relaxed/simple;
	bh=vp6EbvU1rvNWK2KUsT3PKhqiMCwg7EHYtb3O8meg2es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtLEeUsS7s9fF20xZaDwNw2BP/gnCx5uWm2PLnbim5gIwfC9U/uH7gWdDCqPJ/EHU/6qsYj4OUSQk23aipycvCS+dO51W8nzB4Otqrqv4WFHie8Z+bIJwPMWxm2D89lya6tb5C1p/ODi971qu7JwMSznCqktpC2nte5pBnxSkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLLh1Bwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A139C4CEDD;
	Thu, 13 Mar 2025 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862780;
	bh=vp6EbvU1rvNWK2KUsT3PKhqiMCwg7EHYtb3O8meg2es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLLh1Bwu+h7c8wLZOnsoo6txJm3UYCHpIXJ4M3GjWJzoDusKCvkROHfDm92bCWiZk
	 co6XAVN2udWnzHSwWRlfmidQtp9AkGR8Yw+zdFPnXgPjfZEmN0BWG4/G24wRHcNYC8
	 WMdQZVB2DlknBVRFFePGftf3dhM7I8/wblddoL1Oz+6iFr3MtMYyljWw/iLgbWL+d0
	 vdSBAs7LkQRcXtgZk/DIfrzNY1HjE/+jLohlQJ9CzrXQ8cI3beFMV4ytO0UNhg3pLi
	 YURe7XMvIDBQ036BDXYWXzXvgOpd2vKFmPUYpkW6A9RCxNiglwwzsCuxpOZ7Okp6dw
	 oV1635hkw4g3w==
Date: Thu, 13 Mar 2025 11:46:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 0/8] x86/kexec: Add exception handling for
 relocate_kernel
Message-ID: <Z9K3dcMAgu3cot85@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> Debugging kexec failures is painful, as anything going wrong in execution
> of the critical relocate_kernel() function tends to just lead to a triple
> fault. Thus leading to *weeks* of my life that I won't get back. Having
> hacked something up for my own use, I figured I should share it...
> 
> Add a trivial exception handler in the relocate_kernel environment which 
> outputs to the early_printk serial console if configured. Currently only 
> 8250-compatible serial ports are supported, but that could be extended.
> 
> I had to hack up QEMU support for a PCI serial port which matches what
> the existing early_printk code can drive, and the *real* 8250_pci driver
> doesn't seem to cope with that setup at all, but whatever... the kexec
> code now drives the same 32-bit stride which is all that earlyprintk
> supports. We can always add more later, if anyone cares.
> 
> Someone who cares might want to bring the i386 version into line with
> this, although the lack of rip-based addressing makes all the PIC code a
> bit harder.
> 
> David Woodhouse (8):
>       x86/kexec: Debugging support: load a GDT
>       x86/kexec: Debugging support: Load an IDT and basic exception entry points
>       x86/kexec: Debugging support: Dump registers on exception
>       x86/kexec: Add 8250 serial port output
>       x86/kexec: Add 8250 MMIO serial port output
>       x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
>       [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
>       [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()
> 
>  arch/x86/include/asm/kexec.h         |   7 ++
>  arch/x86/kernel/early_printk.c       |   9 ++
>  arch/x86/kernel/machine_kexec_64.c   |  50 ++++++--
>  arch/x86/kernel/relocate_kernel_64.S | 254 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 308 insertions(+), 12 deletions(-)

I applied the first 3 patches to tip:x86/boot for phased-risk-reduction 
reasons, and because I had some questions and suggestions starting at 
patch #4.

Thanks,

	Ingo

