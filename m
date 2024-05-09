Return-Path: <linux-kernel+bounces-175026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7978C1947
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0531F22051
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A0129A7C;
	Thu,  9 May 2024 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHyMfY73"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADFB770E0
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293046; cv=none; b=Fhavu6ZSWJV0lWXiyJIkEQAnNjSD0TcOpu+KCyvaYPiD/GHB+/qZ4DNEYlACqiKwGI7OTxlldLtvUDQ9xqHms0lFOIOV18GrOnsrhWBjW5v6Ix9WfaTIvwSC98uiBOlb81UymLTh2CYClgrIG9Q+bk3JKV1dSWru9ORf3moTZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293046; c=relaxed/simple;
	bh=my5K/hG8Y7wBz+tmEptk9NBFv6kQ+KaoOJUViiniPIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNB/DQh4W/buWdNwgLpt0d7koKyGu73t5ra8W75wWbP4D8KYor3rO0cpbHkcO8IWnRjVxlwIrKEe1Fj8zdkTSmgH+Fn8XWFAUwFGTwizLKEnaHuFWbFFpSDyETvC+nUGRgi6GpL74hXl6HyZR1NQO9J/S2L873mTwYt/xL0Zaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHyMfY73; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715293045; x=1746829045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=my5K/hG8Y7wBz+tmEptk9NBFv6kQ+KaoOJUViiniPIM=;
  b=FHyMfY732gQ3HdOuw9uQJp+1LzTrAxDaPof7dl1kHa331K4+5TePMBgH
   cN9Imt8szKrIJZmNRqh7ihOU4BFGn6cDwMRCZwPTCUSfEFg6xwLPm7kdF
   E9ZHqgAtQMq3jlqZI3vzDsvcxaFKtSRhQSp6lvWhzYWc02vnMJA+VgjXA
   PUNU5xjLizV5B157XXwceeePbRyh8v3Rw2aKfRe9oAaZ5nZrLLyT9Pim5
   pgAtnPNs3CTnpO8nQVtIU8WNBUXdK52LMd2kbrLtVvaZF7aRMkGUKJ33g
   aurJ0HuuxG+5nELeAm1hmN5SN2XvFbD5w97Qs9LXTudqJbyYoVdnIgpVE
   A==;
X-CSE-ConnectionGUID: nAL6xopxQKmiyZ0aur+EJA==
X-CSE-MsgGUID: n83BCL9aRiOB6sKazQhu1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28759438"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="28759438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 15:17:24 -0700
X-CSE-ConnectionGUID: Fo0QRr0pRLmGfWbMiaEbcw==
X-CSE-MsgGUID: tbhiktdVQ8GVmWIAqsdq9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29953367"
Received: from vuongchr-mobl.amr.corp.intel.com (HELO desk) ([10.209.114.189])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 15:17:24 -0700
Date: Thu, 9 May 2024 15:17:17 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: Re: [PATCH] x86/entry_32: Move CLEAR_CPU_BUFFERS before CR3 switch
Message-ID: <20240509221425.zcl6c45thb7wxyza@desk>
References: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
 <5b5e597d-7620-4a5a-9bfa-bae26f0b0fa3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5e597d-7620-4a5a-9bfa-bae26f0b0fa3@intel.com>

On Thu, May 09, 2024 at 09:14:01AM -0700, Dave Hansen wrote:
> On 4/26/24 16:48, Pawan Gupta wrote:
> > As the mitigation for MDS and RFDS, CLEAR_CPU_BUFFERS macro executes VERW
> > instruction that is used to clear the CPU buffers before returning to user
> > space. Currently, VERW is executed after the user CR3 is restored. This
> > leads to vm86() to fault because VERW takes a memory operand that is not
> > mapped in user page tables when vm86() syscall returns. This is an issue
> > with 32-bit kernels only, as 64-bit kernels do not support vm86().
> 
> entry.S has this handy comment:
> 
>  /*
>   * Define the VERW operand that is disguised as entry code so that
>   * it can be referenced with KPTI enabled. This ensure VERW can be
>   * used late in exit-to-user path after page tables are switched.
>   */
> 
> Why isn't that working?

It works in general, but not for vm86() syscall. I don't know much about
how vm86() works, but it seems to emulate 16-bit real mode with limited
memory mapped in user page table. Most likely, user page table doesn't have
a mapping for mds_ver_sel is not mapped resulting in #GP fault.

[...]
> Right now, this code basically does:
> 
> 	STACKLEAK_ERASE
> 	/* Restore user registers and segments */
> 	movl    PT_EIP(%esp), %edx
> 	...
> 	SWITCH_TO_USER_CR3 scratch_reg=%eax
> 	...
> 	CLEAR_CPU_BUFFERS
> 
> The proposed patch is:
> 
> 	STACKLEAK_ERASE
> +	CLEAR_CPU_BUFFERS
> 	/* Restore user registers and segments */
> 	movl    PT_EIP(%esp), %edx
> 	...
> 	SWITCH_TO_USER_CR3 scratch_reg=%eax
> 	...
> -	CLEAR_CPU_BUFFERS
> 
> That's a bit confusing to me.  I would have expected the
> CLEAR_CPU_BUFFERS to go _just_ before the SWITCH_TO_USER_CR3 and after
> the user register restore.
> 
> Is there a reason it can't go there?  I think only %eax is "live" with
> kernel state at that point and it's only an entry stack pointer, so not
> a secret.

It probably can go right before the SWITCH_TO_USER_CR3. I didn't have
32-bit setup with dosemu to experiment with. I will attach a debug patch to
the bugzilla and request the reporter to test it.

> >  	/*
> >  	 * Return back to the vDSO, which will pop ecx and edx.
> > @@ -941,6 +941,7 @@ SYM_FUNC_START(entry_INT80_32)
> >  	STACKLEAK_ERASE
> >  
> >  restore_all_switch_stack:
> > +	CLEAR_CPU_BUFFERS
> >  	SWITCH_TO_ENTRY_STACK
> >  	CHECK_AND_APPLY_ESPFIX
> >  
> > @@ -951,7 +952,6 @@ restore_all_switch_stack:
> >  
> >  	/* Restore user state */
> >  	RESTORE_REGS pop=4			# skip orig_eax/error_code
> > -	CLEAR_CPU_BUFFERS
> >  .Lirq_return:
> >  	/*
> >  	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
> 
> There is a working stack here, on both sides of the CR3 switch.  It's
> annoying to do another push/pop which won't get patched out, but this
> _could_ just do:
> 
> 	RESTORE_REGS pop=4
> 	CLEAR_CPU_BUFFERS
> 
> 	pushl %eax
> 	SWITCH_TO_USER_CR3 scratch_reg=%eax
> 	popl %eax
> 
> right?

We can probably avoid the push/pop as well, because CLEAR_CPU_BUFFERS will
only clobber the ZF.

> That would only expose the CR3 value, which isn't a secret.

Right.

