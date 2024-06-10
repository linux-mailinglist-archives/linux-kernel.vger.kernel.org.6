Return-Path: <linux-kernel+bounces-208369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F1902420
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1441F233EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF12136E01;
	Mon, 10 Jun 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdpOOJRm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3213213D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029880; cv=none; b=USNh2f84/EDHI1b0F1oGpgu8cy13VnX5LmR3FMKJ1lc2wEBNoYl2kgn0v3hbCZt41ZXCyt19vI0TCPDzbgI5xDOcHF5F3cvFRWFwFLFyhB2F1p2QdMpRY1UHgamUUdpV6z+xQF14dMiZSrFWyuotla9kdNi5E7XUbN2vLRzvzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029880; c=relaxed/simple;
	bh=V1664uLxF5b82ZVSpeCZtQWSqHB1NRXdy49enW9INw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGmuUdNHFGyMwAW/Hy0sS0v4ZXG0/hyn5j0778mZY2e6eAjKrKcI1O6acI8A28mzY2obZidtBMKdtK79qUJ8icjgMCJ+6xITSUmIuJTcLH24N4RVTcZ/cSUhRsXPcFIvsnLjK1nPySsyLr5Qqk6Wf7jIhu294CxViV0JsVYBH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdpOOJRm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718029879; x=1749565879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1664uLxF5b82ZVSpeCZtQWSqHB1NRXdy49enW9INw0=;
  b=VdpOOJRmYj7wRufBUV6ZVxZArimN27EATiGSdbp4my6c23p7GKaZQC6v
   sboc/9XB1OIXVGKTEa0X6hNjPh1RIZJJ4K4dXvr7bM2ms7kZIfZRq+tti
   YP/oX6Fly4MCMcXh6X/U7FPZA1BY/4INzlbR9ykCLRsKoOYKiQ6WNiru7
   ljjHRNrY0BN17NdkVicd7DAhHYEegt3ngQkdZ+yFbeczDPED4tp4lbdTJ
   vkZQ18jLhU3amTwVigt5NurJCa9h0IZMJoeaYwcrDCiiBO9bcwE0YwzqL
   9fsggqbRy+fry0lHGl/lYPQj8OZzaE0c+RxU7TmjfLwJTAh8CYZZuxjRd
   g==;
X-CSE-ConnectionGUID: 7IO0izl3TZK/nc2WsXfhWA==
X-CSE-MsgGUID: Bz1uICMbTo6GGDIBHXqW+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18479011"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18479011"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 07:31:19 -0700
X-CSE-ConnectionGUID: L87bjZU3T/qAYUEqdtGp5A==
X-CSE-MsgGUID: FnG0LBQfSWOZuDsm57oIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39528182"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 10 Jun 2024 07:31:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 770921FD; Mon, 10 Jun 2024 17:31:14 +0300 (EEST)
Date: Mon, 10 Jun 2024 17:31:14 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cho@microsoft.com, decui@microsoft.com, 
	John.Starks@microsoft.com
Subject: Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Message-ID: <ajxusvtisufqbl644hkdnq6c3tpamoppvjifhbj4nqctl4vyt7@nhak7gkergqf>
References: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>
 <4df2ebee-40c0-4ea3-8909-13b90f049ff1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df2ebee-40c0-4ea3-8909-13b90f049ff1@intel.com>

On Mon, Jun 10, 2024 at 06:55:56AM -0700, Dave Hansen wrote:
> On 5/28/24 03:09, Kirill A. Shutemov wrote:
> > Currently, attempting to perform MMIO from userspace in a TDX guest
> > leads to a warning about an unexpected #VE and SIGSEGV being delivered
> > to the process.
> 
> Does it _always_ result in a #VE?  Or is this only when guests mmap()
> something like from a driver and the host doesn't back the shared memory?

See below.

> > Enlightened userspace may choose to handle MMIO on their own if the
> > kernel does not emulate it.
> > 
> > Handle the EPT_VIOLATION exit reason for userspace and deliver SIGBUS
> > instead of SIGSEGV. SIGBUS is more appropriate for the MMIO situation.
> 
> Is any userspace _actually_ doing this?  Sure, SIGBUS is more
> appropriate but in practice unprepared userspace crashes either way.

Microsoft folks have plans to do this. I don't know if any current code
handles SIGBUS this way.

> > @@ -641,17 +647,20 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
> >  	switch (ve->exit_reason) {
> >  	case EXIT_REASON_CPUID:
> >  		return handle_cpuid(regs, ve);
> > +	case EXIT_REASON_EPT_VIOLATION:
> > +		if (is_private_gpa(ve->gpa))
> > +			panic("Unexpected EPT-violation on private memory.");
> > +
> > +		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)ve->gla);
> > +
> > +		/* Return 0 to avoid incrementing RIP */
> > +		return 0;
> 
> This _really_ needs a comment, probably even a helper function where you
> can actually explain what is going on.
> 
> I could barely remember what this is for today.  There's no hope for me
> in a couple of years.
> 
> Just thinking through the possibilities here:
> 
> Private=> Private      	: no #VE
> Private=> Anything else	: fatal shutdown
> Shared => Shared	: no #VE
> Shared => Private	: #VE (end up here)
> Shared => !Present      : #VE (end up here)

Are you talking about page state vs. page mapping here?

It is wrong frame to think about it.

We get here as result of EPT violation. Either shared or secret EPT.
So we don't have an present EPT entry for the page or allowed permissions
doesn't match the access.

The is_private_gpa() check catches cases when private EPT doesn't have a
valid entry for page accessed via private mapping: page is not accepted or
removed by VMM. This case is only reachable for debug-TD. In for non-debug
TD it leads to unrecoverable TD exit. The same story as for kernel
addresses.

Normal shared memory doesn't cause #VE even if the memory was not
converted to shared explicitly. On the first access to a page via shared
mapping VMM will allocate a new page and fill EPT[*]. Except for GPA
ranges dedicated for MMIO. For these VMM will not fill EPT and it causes
#VE which interpreted as MMIO access.

Note that only emulated devices require such mechanism to get MMIO
working. For device passthrough, device MMIO range mapped directly into
the guest and handled transparently for the guest kernel.

Does it make sense?

[*] I don't like this implicit conversion to shared. I would prefer #VE
here too, but it is what we have.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

