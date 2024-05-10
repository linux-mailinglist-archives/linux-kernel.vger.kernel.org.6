Return-Path: <linux-kernel+bounces-175190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1018C1BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC4D28445A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF313B787;
	Fri, 10 May 2024 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndR4Y8oH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37C13AA3E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304168; cv=none; b=R8G+v+hgxeRHskLe/dwU0A4D0bUahe80IDtlJjyO07g/zigLcPunGeu4IBpx6NjTWk9ISjRTOpCzihOWnQa9l5gvpXtiFetcLqMmKbaM3my9gkALoSzIMzq+LJTSKn3Tz2LJmZopdFFeD3K8HTBAaYaS++A7PcagcGnQRiOSwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304168; c=relaxed/simple;
	bh=aq2lp97F1ayHVMqqbVlMnI8OwtOdPjAYe4uEiTNQBmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMq0sdxY0Wayqh0lPya9HkPv2kZ2+ZXfHOQZ2TOTqoKInIsNI1S0JBBS9iGHA3G1P24KtdJJa9N0vGs263ifOCAxMR3hrs7YCjy5Uzw8Ro0CMERYSlU/utR1Ml9WInvQumnF6kfCwdTIXFFnkZqqbzhbITazhqZYCh3WCMg7DtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndR4Y8oH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715304167; x=1746840167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aq2lp97F1ayHVMqqbVlMnI8OwtOdPjAYe4uEiTNQBmE=;
  b=ndR4Y8oH+yN5Topt18Z8/CAJsq10RCpzsCUVvU0QTiupj2DbbPgBmh2G
   OK1d9IeCl+pHB1w+btbVCukPpOgzztrpM1EHNxVGXCELShAE5j8gZlogM
   qbLS6ho/4JfV50L2VtGFzIZ/6eRTdtbTIYYQPf26g9ksjAMHn7GffvjJ/
   iCbFgD+oP4ufjF1Fbn+UVdKjr7qkcIn/ego2H2QV2mordKTrckMHL2Qfm
   //VS7wrWTzjsqFhWbXTOiYPWkntur9kNumdfQRJsJ+bH2LglsZujwx84X
   PXsA7CBpvSeZB9gxqP40jyQM6IB+bZwbLckgq662RyVA7sbwQHuPIl0ZV
   w==;
X-CSE-ConnectionGUID: z0A43o6TQZuJdELRhM16ng==
X-CSE-MsgGUID: vmCZHimnR6GZMBXzSPU79g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11393876"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11393876"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 18:22:46 -0700
X-CSE-ConnectionGUID: guWGgvPjS1Ov0/pklTG8Kg==
X-CSE-MsgGUID: T2cYd80IR/CK81quUEUrXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29538872"
Received: from vuongchr-mobl.amr.corp.intel.com (HELO desk) ([10.209.114.189])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 18:22:47 -0700
Date: Thu, 9 May 2024 18:22:38 -0700
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
Message-ID: <20240510012149.5mdrr4x6suspaasd@desk>
References: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
 <5b9a2cef-7b4f-41c3-9f64-4fea4d007cdf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9a2cef-7b4f-41c3-9f64-4fea4d007cdf@intel.com>

On Thu, May 09, 2024 at 05:20:31PM -0700, Dave Hansen wrote:
> On 4/26/24 16:48, Pawan Gupta wrote:
> > Move the VERW before the CR3 switch for 32-bit kernels as a workaround.
> 
> I look at the 32-bit code so rarely, I seem to forget have to re-learn
> this gunk every time I look at it.  Take a look at RESTORE_INT_REGS.  On
> 32-bit, we actually restore %ds:
> 
> 	popl    %ds
> 
> So even doing this:
> 
> > +       CLEAR_CPU_BUFFERS
> >         /* Restore user state */
> >         RESTORE_REGS pop=4                      # skip orig_eax/error_code
> > -       CLEAR_CPU_BUFFERS
> >  .Lirq_return:
> 
> fixes the issue.  Moving it above the CR3 switch also works of course,
> but I don't think this has anything to do with CR3.  It's just that
> userspace sets a funky %ds value and CLEAR_CPU_BUFFERS uses ds:.

I will test it out, but I think you are right. VERW documentation says:

  #GP(0)	If a memory operand effective address is outside the CS,
		DS, ES, FS, or GS segment limit.

> I don't think any of the segment registers can have secrets in them, can
> they?  I mean, it's possible, but in practice I can't imagine.

I don't think so they are secrets. AFAICT, their values are build-time
constants, and can be easily deduced.

> So why not just do the CLEAR_CPU_BUFFERS in RESTORE_REGS but after
> RESTORE_INT_REGS?  You might be able to do it universally, or you could
> pass in a macro argument to do it conditionally.

Sounds good. I will try that, possibly tomorrow.

> P.S. Can we remove 32-bit support yet?  Please? :)

+1 ... or atleast the mitigations for 32-bit :)

