Return-Path: <linux-kernel+bounces-548387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52D7A5441F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD38188BB7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50951A3176;
	Thu,  6 Mar 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6efhXRc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECBF9F8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248084; cv=none; b=KENq2AEDO4MkgYkCQPyVdJvQmOcnewGuwZKlZDPWctxdK2Q4RAVGpdVM6wO/7TUA/ijdnM6KrZh/dJQXsZCkL0TtV/nbO7zb/Bi+UPqdL1O/eolgHvuMLc/8y//VaEKdqAe7kic14kbrTQvItJkujLB4+nzs4QyXLs1CbzasNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248084; c=relaxed/simple;
	bh=YXfui0KAvTIvMPJoyMI8UxADsy9dy1q4GRghq0oBVCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYx7kIF23vNx402jBwlaKVtTQUj3IGPu3cUZphj90JeBzjXo/VQSY7Xi6ryO3DVTSXtS9aM/5MRBy86HENcD47x5T+r7YtnW70zTuHyrVbWxveitosgpEs3NvpqloLua9BnXfFYl4GVBYP+KU41ka57VErA8lUVb2cQDLv7P50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6efhXRc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741248083; x=1772784083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YXfui0KAvTIvMPJoyMI8UxADsy9dy1q4GRghq0oBVCQ=;
  b=H6efhXRck/WdFnSAFa4NSz2EbrBxUtphbHKeCBLvv8OzFVyXtPUgeQ8t
   lFBhyfG1SLsES/X4iTb/EZJhZPUKnSQU9tVcHALjopqytgniew9W5Boym
   Kk8TQjEn8fCrexyzj2zv2DbkR1PWwQqrCrLVV6E83GvFuk8uHUYC/QPi0
   v1ji+GYbijMW+9hzjU3552GNvfSWiUZDZLc3ePaWvaspPY+YECaZ31IOo
   jQchts7Yb7a5A3BhgUmxHM2x8duiOf9GeWF+55VP5/XaOjBysEC4D7Yi7
   h0FTn7Yf16Uhp8E5IpwFpdk26OP/MkNWsNZlHIYfWLlw1Y57jFww3JrjO
   w==;
X-CSE-ConnectionGUID: iWj2sUrNSHWzCKTaAHDtjw==
X-CSE-MsgGUID: gQ93XVmfQ4SlsXmeBAvRIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42378774"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42378774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:01:23 -0800
X-CSE-ConnectionGUID: DumshYVjTb6zcdY+U4a9Ow==
X-CSE-MsgGUID: p2i4/SkZS96Ap6u64H5YHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119470433"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 06 Mar 2025 00:01:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1A52F20B; Thu, 06 Mar 2025 10:01:17 +0200 (EET)
Date: Thu, 6 Mar 2025 10:01:17 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>, 
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, 
	Larry.Dewey@amd.com, "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>

On Wed, Mar 05, 2025 at 08:40:29AM -0800, Dave Hansen wrote:
> On 3/5/25 07:37, Borislav Petkov wrote:
> >> So this question boils down to whether the parsing of the bits happens
> >> in kernel- or user-space. Actually there is already parsing in
> >> kernel-space to print the status bits into the kernel log:
> >>
> >> 	SEV: Status: SEV SEV-ES SEV-SNP
> >>
> >> ... which is great for a quick glance without needing any tools. The
> >> user-space tools which already exist have their own parsing of the bits
> >> and for them it is much easier to consume the raw value of the
> >> SEV_STATUS MSR. See my changes to snpguest:
> >>
> >> 	https://github.com/virtee/snpguest/pull/88/files
> > Well, I guess we can do both:
> > 
> > cat /sys/...
> > 
> > SEV_STATUS(0xdeadbeef): SEV SEV-ES SEV-SNP
> > 
> > So that people don't have to pick apart the MSR hex value.
> > 
> >> Btw, what is the equivalent on the Intel TDX side for these feature
> >> bits?
> > There is none, AFAICT. That's why the whole discussion.
> 
> TDX's history isn't as exciting as SEV.
> 
> TDX guests have CPUID to tell them that they're running that way.
> 
> TDX hosts are much more arcane. You can't _actually_ know that it's a
> TDX host until you actually start making successful SEAMCALLs and the
> TDX module answers them. But we fudge it by just looking at
> MSR_IA32_MKTME_KEYID_PARTITIONING at boot and assuming that anything
> with that MSR will be able to be a TDX host.
> 
> We've just got X86_FEATUREs for hosts and guests:
> 
> 	#define X86_FEATURE_TDX_HOST_PLATFORM ( 7*32+ 7)
> 	#define X86_FEATURE_TDX_GUEST ( 8*32+22)
> 
> and that's it.
> 
> Folks certainly _want_ something in sysfs to dump the TDX module version
> and so forth, but we've resisted the urge so far.

Alexey looking into exposing TDX module version in sysfs for both guest
and host.

I think it would be useful for guest to make attributes and TD_CTLS
available via sysfs. So far, we only dump them in dmesg on boot (see
564ea84c8c14).

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

