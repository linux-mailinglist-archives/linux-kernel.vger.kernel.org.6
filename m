Return-Path: <linux-kernel+bounces-300127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BE95DF1E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554DD282977
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F514776E;
	Sat, 24 Aug 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faEd3C6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70D39AEB;
	Sat, 24 Aug 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724518648; cv=none; b=lA+YreZAXi5gQyaqxkZV4aHTSkqvBOfXLqMEAaIDQfmLfm4Upwx7GK2R+dZzmodWFkBnVJQhOg24HiJiBoVxbAUWTZ4C2n2tC4piig2QSVEDg6C0P02BZPGRLOjRptLYkSk5TE79c9/iHEI6XV0t5Rn30yxKNcNs7ZxTLKJp+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724518648; c=relaxed/simple;
	bh=fZXoHykcvD1A1JFjEQWQzA8RfT1FLb1kSJXWvNQuTSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URcmqhs+AB+ONlFJRHKSzN9h+BmEOsionUFpenj+Zn5SUArIGAT/QKiMLNg07QS2HaMnrCx9qQU2Vf12Lhvdw23d7XYD1QRuL31Xt+P7XOJIOwD3oG186mN2AKBggJ3RserJW8Kmf4THSQQqfi4ZMb97BskSolIgYaGuJHGFWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faEd3C6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19277C32781;
	Sat, 24 Aug 2024 16:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724518647;
	bh=fZXoHykcvD1A1JFjEQWQzA8RfT1FLb1kSJXWvNQuTSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faEd3C6xk3bB7/IzcZTbthHs2go8i2t8IzxJbgykL8HKT7I1Cj30ifR1rdfbF45+g
	 Xrurn92tq4+O3tvZGh9+E4N0SrITO6hNo608f24CAFL2w8+s94I8EdvfcxDsdNm8ot
	 Bc5vacQ6lB2cE3mOXSvTGaWOePNyc9V7Gs8iGC/tAhkST47dOsItJHz9kjoc8BG/Yy
	 VUSaNfMcaRuhZ3nlshNWMHCIOXpRyhl2UXGJkot63db3C/KSql0sul34SXMPELXrGD
	 ZtYuV+N+tGWTtEN4m+cl1l7WLqR2SQU6vsDP1Gdw87/lejwxOS2ufAqkEj17XIqnR3
	 5JGiL0AHsoPgw==
Date: Sat, 24 Aug 2024 18:57:20 +0200
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
Subject: Re: [PATCH v4 6/6] x86/tdx: Implement movs for MMIO
Message-ID: <ZsoQ8GCWTHgY3H_e@example.org>
References: <cover.1723807851.git.legion@kernel.org>
 <cover.1724248680.git.legion@kernel.org>
 <9320e721e609e55a020d3eb98f48fc856371c561.1724248680.git.legion@kernel.org>
 <tcngnuglju2mnpfa4o2hw3fpwdkk4ryso5dq2zjfi2wn4yr5yd@2iij74o7ugaf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tcngnuglju2mnpfa4o2hw3fpwdkk4ryso5dq2zjfi2wn4yr5yd@2iij74o7ugaf>

On Thu, Aug 22, 2024 at 11:28:14AM +0300, Kirill A. Shutemov wrote:
> On Wed, Aug 21, 2024 at 04:24:38PM +0200, Alexey Gladkov wrote:
> > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > 
> 
> Please capitalize MOVS in the subject.
> 
> > Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
> > consists of dividing it into a series of read and write operations,
> > which in turn will be validated separately.
> 
> Commit message is pretty sparse. I think we need to elaborate on the
> similarities and differences with SEV implementation. Locking context
> difference is important.

Agree.

> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index a75a07f4931f..45136b1b02cc 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -503,6 +503,10 @@ struct thread_struct {
> >  	struct thread_shstk	shstk;
> >  #endif
> >  
> > +#ifdef CONFIG_INTEL_TDX_GUEST
> > +	unsigned long		mmio_emul;
> > +#endif
> > +
> >  	/* Floating point and extended processor state */
> >  	struct fpu		fpu;
> >  	/*
> 
> Hm. Do we need to track exact target address in the thread struct?
> Wouldn't be single bit be enough to allow MMIO to userspace address from a
> kernel regs->ip?

The flag will identify that a nested exception happened, but it will not
be clear which address cause it.

Perhaps you are right and this approach is unnecessarily paranoid. 

> There is space for the flag next to iopl_warn.

Yes, I can use just a flag to identify a nested exception.

-- 
Rgrds, legion


