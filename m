Return-Path: <linux-kernel+bounces-197241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A18D6808
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB9D1F288C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D3176AAE;
	Fri, 31 May 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlXkLZcD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFA176AA5
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175851; cv=none; b=fC7i7We0WvCUgGsC5e1+DLaaNKZwVJU0QWWjvaxOOhrK3VXx5TesVohU0sF8WzXaNSnkfrIPLPvBYsnz1Lu/lChbcskiunFo3u5vOdm33GdbMceDa++XROrP1FVpx9E9e16Zh8AiXhccHViwow2tD7p9N6jO+JV1LU7QgoXEtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175851; c=relaxed/simple;
	bh=EM24ru0xgssX+AxI4Bh3Wi1hwAT39CEpJwWf5fD8Kgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqP+yzCn3QQKwFeNx6xJ66vicmg018sQmKBVVARR8WVF9F8rQruqES6GC7K/9NuStBfMVu5ayljfaXRDZidC2SB3S0vP03sZhR3IjNFVW9UxR9hiPO2dFks3bNekvY9VqEROuQlyisV/znDgbWNPz9YdCTMCZ44HYmshVzZ1LEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlXkLZcD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175850; x=1748711850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EM24ru0xgssX+AxI4Bh3Wi1hwAT39CEpJwWf5fD8Kgs=;
  b=OlXkLZcDR/XFL1Cq58o+v06TqdNd8uQhrhB+IvrNSXerjGNwcSv/7Ucm
   IQIookYtnaNvwXEwiFzxI6UOvv3lxe2RH4kA4vdJ/7qigMiDILH2t3nor
   8WtqMYmD3Qme+uheJ6Sg+CzWWLH7TQ0NgdEzlFTzebRagiBsA/5OOakJa
   t/dAZ2PWZTvFxNnGXCs2X+eHGQLwdMlCAy5+VNDbXxy24EpGjIi5BYK42
   lWzEN6a/8/IvDwrOHWqeapAmK3Lm+RhCz/xVlJY21Nk12wdvC28GScZbY
   uZwgxlPT8jkMdSZlsgV5oSqU4h/+vjGCvlo6tct2gqNYVID10mvnashwL
   g==;
X-CSE-ConnectionGUID: QhOENoXITii1SGYnR1k8vg==
X-CSE-MsgGUID: vpMkaz3VTlqs3KSDr/1V0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13923481"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13923481"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:17:20 -0700
X-CSE-ConnectionGUID: QJ6rhGuUToisYq/6XJ85KQ==
X-CSE-MsgGUID: LbT/3AX9TlSQuqg+BbiEbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="59398416"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.54])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:17:20 -0700
Date: Fri, 31 May 2024 10:17:19 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
	bp@alien8.de, kirill.shutemov@linux.intel.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, ashish.kalra@amd.com, chao.gao@intel.com,
	bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com,
	seanjc@google.com
Subject: Re: [PATCH v4 5/5] x86/virt/tdx: Add TDX memory reset notifier to
 reset other private pages
Message-ID: <20240531171719.GA380706@ls.amr.corp.intel.com>
References: <cover.1713439632.git.kai.huang@intel.com>
 <c56350fc0d79724a1206708a436cd2847c3b6ee7.1713439632.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c56350fc0d79724a1206708a436cd2847c3b6ee7.1713439632.git.kai.huang@intel.com>

On Thu, Apr 18, 2024 at 11:48:05PM +1200,
Kai Huang <kai.huang@intel.com> wrote:

> TL;DR:
> 
> To cover both normal kexec and crash kexec, add a TDX specific memory
> reset notifier to let "in-kernel TDX users" use their own way to convert
> TDX private pages (that they manage respectively) in tdx_reset_memory().
> 
> Long version:
> 
> On the platforms with TDX "partial write machine check" erratum, during
> kexec, the kernel needs to convert TDX private memory back to normal
> before jumping to the second kernel to avoid the second kernel seeing
> potential machine check.
> 
> For now tdx_reset_memory() only resets PAMT pages.  KVM will be the
> first in-kernel TDX user to support running TDX guests, and by then
> other TDX private pages will start to exist.  They need to be covered
> too.
> 
> Currently the kernel doesn't have a unified way to tell whether a given
> page is TDX private page or not.  One choice is to add such unified way,
> and there are couple of options to do it:
> 
>  1) Use a bitmap, or Xarray, etc to track TDX private page for all PFNs;
>  2) Use a "software-only" bit in the direct-mapping PTE to mark a given
>     page is TDX private page;
>  3) Use a new flag in 'struct page' to mark TDX private page;
>  4) ... potential other ways.
> 
> Option 1) consumes additional memory.  E.g., if using bitmap, the
> overhead is "number of total RAM pages / 8" bytes.
> 
> Option 2) would cause splitting large-page mapping to 4K mapping in the
> direct mapping when one page is allocated as TDX private page, and cause
> additional TLB flush etc.  It's not ideal for such use case.
> 
> Option 3) apparently contradicts to the effort to reduce the use of the
> flags of 'struct page'.
> 
> None of above is ideal.
> 
> Therefore, instead of providing a unified way to tell whether a given
> page is TDX private page or not, leave "resetting TDX private pages" to
> the "in-kernel user" of TDX.
> 
> This is motivated by the fact that KVM is already maintaining an Xarray
> to track "memory attributes (e.g., private or shared)" for each GFN for
> each guest.  Thus KVM can use its own way to find all TDX private pages
> that it manages and convert them back to normal.
> 
> For the normal kexec the reboot notifier could be used, but it doesn't
> cover the cash kexec.

If we do so, KVM needs to traverse complex data structures.  Anyway, we
can miss TDX private pages in a transitional state between private-shared.
Also, we have to maintain the logic if the data structure changes, both
the KVM code change or TDX module data structure update for future features.

Here are other options.  What do you think?


Option 5) refuse normal kexec when TDX module is initialized.
Enforce the user to go system reset.  For kdump case, we know that TDX
private page resides in the area of the crashed kernel.  Kdump kernel
will use reboot with BIOS after capturing crash image.

Pro: No need to traverse complex data structures
Pro: Keep room for future client support without complication
Con: LINUX_REBOOT_CMD_KEXEC can fail


Option 5.1) refuse normal kexec if TDX guests are running.
The admin needs to kill the TDX guest be kexec.  Perhaps update
systemd unit file.


Option 6) Clear the all pages instead of selected ones.
We can use the e820 entries passed to the second kernel.

Pro: No dependency on in-kernel TDX users.
Pro: Work for possible future TDX module data structure change
Con: It may take long time if the memory size is large.
     If TDX guests use most of the available memory, this is inevitable.
-- 
Isaku Yamahata <isaku.yamahata@intel.com>

