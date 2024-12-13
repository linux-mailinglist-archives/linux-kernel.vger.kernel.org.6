Return-Path: <linux-kernel+bounces-445102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84E9F1146
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A7A1883B47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA441E2854;
	Fri, 13 Dec 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjJpuSeg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F41DF988
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104855; cv=none; b=ImvWLmMW92Nu859Ii4nnWrlQb4gyiMpETqHz2HLpR4g9H6dfC9QYR9JPNuY5xk17xlEmd0CQECSqX1LbgzguO8qBxaBpzoiKtbjD+IUw1UATcFF0eb5CwcRP+421MgZ0jLslbvQU5vbPzdXiNcGExrdtfWlyu2eyVFksl7FMLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104855; c=relaxed/simple;
	bh=dBHOkkQQ3izYxwbqx1+ObHRDcxImubfwHT2P95wk0wo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TFRdKjm+y7TJQHPB6QoYgEinsnWrEBnNs8QWpCI7zBWDyoPTQoOZk88je0VenELo+W/8TDm1+YJRa+ebHWyVPaF6LIL8q0BegfOe+5CS/O1ooh6gpB+ino85v+Z4ZD1uD6Dyz9UZ/zSNl+czHIgMMvxbriRJIhxxZGsF0l7FcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjJpuSeg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734104852; x=1765640852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dBHOkkQQ3izYxwbqx1+ObHRDcxImubfwHT2P95wk0wo=;
  b=SjJpuSegxYBBy53sVvuyWzU3V1SplkYiiEONdCYcsHl3qSwFQxAdwKXY
   k359g5+eG7AecaO78+B8QRiQ+xbwk1fV29pt8RtUPT/etbn0XsGExzFj2
   eKWoewiT3Z899aBKJRcyFQ2q/akew2B4GyB8uiqgtOvlFjLIYArCDp7JN
   JYllTQp83/s1r/ltI6RxMw1b1O0kchJ5Tnt5An14TSolQwRoje5PRePRb
   jbLs6MN7HDTPGOVjpSPCgYeh9TYKRdLnTJ3ufGfMGpTQkBap8VT7Abr1Y
   iiZ57qxf2QkSZP7R/1Vs2bU8gRZFTXXPZpkHMmTOYVdTu+svmKrM00i5J
   A==;
X-CSE-ConnectionGUID: g6mwxsUmRf2SW81J5i3tEg==
X-CSE-MsgGUID: A9jt6KpvQuqMNpWOLAOHIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="22148381"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="22148381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 07:47:31 -0800
X-CSE-ConnectionGUID: wMm9fPoeQz21sBk8juRYbw==
X-CSE-MsgGUID: BxpReNdGSkWm84bT+MGNxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="96468400"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Dec 2024 07:47:30 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tM7t2-000CB1-0Y;
	Fri, 13 Dec 2024 15:47:28 +0000
Date: Fri, 13 Dec 2024 23:46:45 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: arch/x86/kvm/smm.c:651 emulator_leave_smm() warn: inconsistent
 indenting
Message-ID: <202412132356.dMOiC7ev-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f932fb9b40749d1c9a539d89bb3e288c077aafe5
commit: 3f6821aa147b6e6fe07e8b35999724518b74a632 KVM: x86: Forcibly leave nested if RSM to L2 hits shutdown
date:   3 months ago
config: i386-randconfig-141-20241213 (https://download.01.org/0day-ci/archive/20241213/202412132356.dMOiC7ev-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412132356.dMOiC7ev-lkp@intel.com/

New smatch warnings:
arch/x86/kvm/smm.c:651 emulator_leave_smm() warn: inconsistent indenting

Old smatch warnings:
arch/x86/kvm/smm.c:300 enter_smm() warn: inconsistent indenting

vim +651 arch/x86/kvm/smm.c

   625	
   626		/*
   627		 * FIXME: When resuming L2 (a.k.a. guest mode), the transition to guest
   628		 * mode should happen _after_ loading state from SMRAM.  However, KVM
   629		 * piggybacks the nested VM-Enter flows (which is wrong for many other
   630		 * reasons), and so nSVM/nVMX would clobber state that is loaded from
   631		 * SMRAM and from the VMCS/VMCB.
   632		 */
   633		if (kvm_x86_call(leave_smm)(vcpu, &smram))
   634			return X86EMUL_UNHANDLEABLE;
   635	
   636	#ifdef CONFIG_X86_64
   637		if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
   638			ret = rsm_load_state_64(ctxt, &smram.smram64);
   639		else
   640	#endif
   641			ret = rsm_load_state_32(ctxt, &smram.smram32);
   642	
   643		/*
   644		 * If RSM fails and triggers shutdown, architecturally the shutdown
   645		 * occurs *before* the transition to guest mode.  But due to KVM's
   646		 * flawed handling of RSM to L2 (see above), the vCPU may already be
   647		 * in_guest_mode().  Force the vCPU out of guest mode before delivering
   648		 * the shutdown, so that L1 enters shutdown instead of seeing a VM-Exit
   649		 * that architecturally shouldn't be possible.
   650		 */
 > 651		if (ret != X86EMUL_CONTINUE && is_guest_mode(vcpu))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

