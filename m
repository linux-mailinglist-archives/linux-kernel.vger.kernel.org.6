Return-Path: <linux-kernel+bounces-408831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0839C8418
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5911A284AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014021EBFF9;
	Thu, 14 Nov 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYeLjG6w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E61F26DF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570036; cv=none; b=jNL5JK4Cvftm6ncqox9r7c//Aatm6QyDG3cLyzgerDnKJb2F2+djr3oVxrtyPuNknBpQ8ho62O7vNEHQkV3tTv2e6/ey3xyKXvB+STwEQ1Uk2qHz7zSPrmEPvrKUYW8b8TIlcBFxVUvzjVsnFn4yANVE7jK316RI6fnq2Udi5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570036; c=relaxed/simple;
	bh=L5fyaTcmXE+0OTLELcU68IrkvwaIdTyleUoThwtZasU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdBCjfiogauPRSjYxb7TuMe/ZpsVvqiEMcWlHer845qpvuQO/HNXyLLx2UFKBnQiGADrnQOuWszSx4k46qKiUZJ3zi5INXXuAtC2gB7M6x+Hq2y0rwavN/eTZbNAbeyr7DCpQ5gC26eZsonwR6uWfEotQu0R8rQ3NbYarFSl6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYeLjG6w; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731570036; x=1763106036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L5fyaTcmXE+0OTLELcU68IrkvwaIdTyleUoThwtZasU=;
  b=GYeLjG6wWjdFwlSk33FoPSrn+LHZ+e/tmp91QiyHENNSS3zJWPsbtK1I
   dQbDIstMXNWDVV2H2BFBHWcpZ8n5Ttt2WC/2hR3xZB7+8zUK2GR6mjAZr
   ZednbAtjEKPOTnmcAD7GlvuLA6XuBolUC20wLUxJNfTSu0JJe0MeFPVEn
   h9MASaidd98nrUTqRJy7ztMfNPTvonbGBgQoVbolPUA7+dHtmcvscvEYp
   OQyE2Ij6Pt1zJYTntc3DYszMfI07O4IryxkUqPwyLbGpFxmUWoXPLTV2t
   gv1ezw7QNHMF/cuZv7OpyFIHQLvXNlwgrK3E9fGJpxtRKtWOGPPQgpwb9
   w==;
X-CSE-ConnectionGUID: UT+fBTqQSjObXHp2unVP/w==
X-CSE-MsgGUID: W0cF13xdTnK3tDDuF3xvsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42917887"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42917887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:40:25 -0800
X-CSE-ConnectionGUID: M1u0CHloTailCxqdhGJHKQ==
X-CSE-MsgGUID: 7EO6T3bqQFWw+RMuUToXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="119049617"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2024 23:40:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 00BE122B; Thu, 14 Nov 2024 09:40:19 +0200 (EET)
Date: Thu, 14 Nov 2024 09:40:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Woodhouse, David" <dwmw@amazon.co.uk>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"kai.huang@intel.com" <kai.huang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
Message-ID: <ZzWpY_zR43Zq5WJh@black.fi.intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
 <20241103054019.3795299-7-dwmw2@infradead.org>
 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
 <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
 <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 05, 2024 at 01:58:40PM -0800, H. Peter Anvin wrote:
> On 11/5/24 13:37, H. Peter Anvin wrote:
> > What is the point of writing this code in assembly in the first place? A
> > much more logical thing to do is to just push the registers you haven't
> > pushed already onto the stack and call a C function to do the actual
> > dumping? It isn't like it is in any shape, way or form performance
> > critical.
> 
> arch/x86/boot/compressed/misc.c has some code that you can crib, both for
> writing to a text screen (not that useful anymore with EFI framebuffers) and
> serial port. If you factor it a little bit then you can probably even share
> the code directly.
> 
> (__putstr perhaps should have a __putchar() factored out of it?)
> 
> Then you can just do the obvious (have your assembly stub point %rdi to the
> base of the register dump; set the frame order to whatever you'd like,
> except rip/err/exc, or reverse the order if you prefer by changing the
> loop):
> 
> static inline __noreturn void die(void)
> {
> 	while (1)
> 		asm volatile("hlt");
> }
> 
> void dump_register_frame(const unsigned long frame[])
> {
> 	static const char regnames[][5] = {
> 		"rax:", "rcx:", "rdx:", "rbx:",
> 		"rsp:", "rbp:", "rsi:", "rdi:",
> 		"r8: ", "r9: ", "r10:", "r11:",
> 		"r12:", "r13:", "r14:", "r15:",
> 		"cr2:", "Exc:", "Err:", "rip:"
> 	};
> 
> 	for (size_t i = 0; i < ARRAY_SIZE(regnames); i++) {
> 		__putstr(regnames[i]);
> 		__puthex(frame[i]);
> 		__putstr("\n");
> 	}
> 
> 	/* Only return from int3 */
> 	if (frame[17] != 3)
> 		die();
> }

+ a mil here!

Please, use existing early_serial_console infra. Also we have
debug_putaddr() / debug_puthex() / debug_putstr() which are
probably ones you want to use.

-- 
With Best Regards,
Andy Shevchenko



