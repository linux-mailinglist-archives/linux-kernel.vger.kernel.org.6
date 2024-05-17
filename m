Return-Path: <linux-kernel+bounces-182213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8478C882E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F31C21E54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6E7748E;
	Fri, 17 May 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StVEgwD2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262579F0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956797; cv=none; b=ZnVRCaFXCVqqIm+qdICAnQnpqteSpeRzjesbx4m6LR9dSRSPZ+LENnPUCMXx0kb3QCoRd+LaSTXUrcZAEPwicyXtRqAJ8vKKVdVjqLMHfRYAPYkbtXXIFNtmLxklIm20CH9Yhi8VM/fMA6tSphQvAEaU1uyn73NxUZ8v/IQlC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956797; c=relaxed/simple;
	bh=d2i5dDPqJkx8adnPFZl0itpyVtJmwwMOhCHco1pt43E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZM4tyax8wVTEa/gAMQgy09tDGF8S8+MRExgCxcW1bf17pYFPyIoqrEvWEgbWgL4/JYFp7rIdVEQEKnqUBvxQn3IrChuZlT7jgaYElNwNGB7/nKL2C96l8P3qCSo3quTrxYyALi6/eOzCFHyqosrBiWuSCdZcBRTEmrcd5ooER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StVEgwD2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715956796; x=1747492796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2i5dDPqJkx8adnPFZl0itpyVtJmwwMOhCHco1pt43E=;
  b=StVEgwD2w8lPgWqrH/2nz7KIOBI7IJ651bL/5OpDp3GJsqnfb8pnDXz6
   /27T25N6Ih1FA/xVRiWCMMST3pNHo+jT4JLc1kbiRWaa4ICIfS/2hjQdo
   R0zmtrQ7JFMbr0Nuzu+I1QRdpoysu34YXlO4jvseGVzLn0tX4sVmUfjrz
   48kKxRuXwDjRZNmWcypqJVhz8jbHuzGTiTVYZDw5zB8VuVuxJP/vik0aP
   x4036fCJNAjXFyiBwNSyXAzMf2HbtuUX94wAWosZQFiO/c+mS/HJSsrAy
   61ChMf54ovTCyN7JbHPETMS9kHQww2SMYz1zfTFO2HWymWnlkTPELBxD5
   w==;
X-CSE-ConnectionGUID: 7Es76E/ESsOndGeYmGoZeg==
X-CSE-MsgGUID: 1YDdRMx8QxevDMrw81vfbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="11940203"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11940203"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:39:55 -0700
X-CSE-ConnectionGUID: 2dIMDUYbRJOUBO7ndmZjJA==
X-CSE-MsgGUID: jAfqlXhtSbef9aoXD2Du1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31639195"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 17 May 2024 07:39:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AE0E419E; Fri, 17 May 2024 17:39:51 +0300 (EEST)
Date: Fri, 17 May 2024 17:39:51 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Message-ID: <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>

On Fri, May 17, 2024 at 04:08:03PM +0200, Juergen Gross wrote:
> On 17.05.24 15:55, Kirill A. Shutemov wrote:
> > On Fri, May 17, 2024 at 02:14:50PM +0200, Juergen Gross wrote:
> > > While testing TDX host support patches, a crash of the host has been
> > > observed a few instructions after doing a seamcall. Reason was a
> > > clobbered %rbp (set to 0), which occurred in spite of the TDX module
> > > offering the feature NOT to modify %rbp across TDX module calls.
> > > 
> > > In order not having to build the host kernel with CONFIG_FRAME_POINTER,
> > > save %rbp across a seamcall/tdcall.
> > 
> > There's a feature in TDX module 1.5 that prevents RBP modification across
> > TDH.VP.ENTER SEAMCALL. See NO_RBP_MOD in TDX Module 1.5 ABI spec.
> > 
> > I think it has to be enabled for all TDs and TDX modules that don't
> > support it need to be rejected.
> > 
> 
> Yes, I know. I'm using the patch series:
> 
>   [PATCH v19 000/130] KVM TDX basic feature support
> 
> which I think does exactly that (see setup_tdparams() and tdx_module_setup()).

Looks like the check is broken:

https://lore.kernel.org/all/46mh5hinsv5mup2x7jv4iu2floxmajo2igrxb3haru3cgjukbg@v44nspjozm4h/

> Nevertheless the clobbering happened, and saving/restoring %rbp made the
> issue to go away. I suspect there is a path left still clobbering %rbp.

What is your TDX module version? My guess is that NOM_RBP_MOD is not
supported by it and given that the check is broken nobody enforces it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

