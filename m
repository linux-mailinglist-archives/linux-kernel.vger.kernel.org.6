Return-Path: <linux-kernel+bounces-438324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904D9E9FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4E7281D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB617DFE3;
	Mon,  9 Dec 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mluxOS7G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2513B584
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773027; cv=none; b=BFO1jQahjc5MEE99lokZfagEEVbY7sJtfYVWisF5S09NHaXtAXEs8q+lC0fDZ/qfDKyWf2E5qCdGI2l+J8Yd5I9MZfA6b46jkoVt2ouVyItgvTNOGDovw8Iz3R7SWPlVWwDalpE8+zoICU0Yi7yM6xzEWMXtXvBQXzHS8H8nkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773027; c=relaxed/simple;
	bh=MReSg/ADihE6zgaGj+frthB/C+MsbysHrihWVPpu0pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9O36nJ0uutAVB+Jw77WfQvxgkAm8shNyoeABlyylHLOhbi4dlu+WvWUNOyVRCOUA6ubYkbbmmetwcAnl3JVDUE54bw5SN7pS26Yxw2hgRVpNbefvQGwpcBMnPMZTLQWcRkskviB3hW/w6wZ4lrCDWBJKAVcWiVtszO8HFcIPLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mluxOS7G; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733773026; x=1765309026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MReSg/ADihE6zgaGj+frthB/C+MsbysHrihWVPpu0pI=;
  b=mluxOS7GgtJbWRZ6N4zprTgJRNwOTsjNqBbo1GwJZWfWth990NgNxutb
   hFskKazNuEWOrwzS/dAZs9CwMY2ujoDJLRLFaQsa2ZVqV1YOzIloRbZEV
   IslcDo5RTt2/Un2BzpNL459/vUNQsDmLLfw9eSN4Zc27cob3gsHjZ8NT6
   QududXF/PmZ9RCMtFA7YxY7RPdlO3MvqhDR9qN07rUza2RXjg3Mvgrh+2
   oD7g20O3GKB03DbmJECwN8LmVQn3Rf349HbOrB8ewaLs6Yqnxkv/4k2jW
   E64eHEoxMKStgrUmTg3bKJKtJvCwwy/EgYif68wdmbmSO2Vbg2MC/c206
   w==;
X-CSE-ConnectionGUID: YDxKC0PwSeq4Hce7YCyUhg==
X-CSE-MsgGUID: c/ClJoDDT0+e/M+uEV/Jsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44770052"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44770052"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:37:02 -0800
X-CSE-ConnectionGUID: ewzXBMAaRu+nvLnpHzj5Lw==
X-CSE-MsgGUID: XfCJLZL/SWKU4aZ9z8kW3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="126004877"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Dec 2024 11:36:58 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKjYt-0004lJ-1X;
	Mon, 09 Dec 2024 19:36:55 +0000
Date: Tue, 10 Dec 2024 03:36:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, maz@kernel.org,
	oliver.upton@linux.dev, christoffer.dall@arm.com,
	suzuki.poulose@arm.com, will@kernel.org, catalin.marinas@arm.com,
	coltonlewis@google.com, joey.gouly@arm.com, yuzenghui@huawei.com,
	darren@os.amperecomputing.com, gankulkarni@os.amperecomputing.com,
	vishnu@os.amperecomputing.com
Subject: Re: [PATCH] KVM: arm64: nv: Set ISTATUS for emulated timers, If
 timer expired
Message-ID: <202412100311.HEYAT0bx-lkp@intel.com>
References: <20241209053201.339939-1-gankulkarni@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209053201.339939-1-gankulkarni@os.amperecomputing.com>

Hi Ganapatrao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvmarm/next]
[also build test WARNING on arm64/for-next/core soc/for-next linus/master arm/for-next arm/fixes v6.13-rc2 next-20241209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ganapatrao-Kulkarni/KVM-arm64-nv-Set-ISTATUS-for-emulated-timers-If-timer-expired/20241209-133651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
patch link:    https://lore.kernel.org/r/20241209053201.339939-1-gankulkarni%40os.amperecomputing.com
patch subject: [PATCH] KVM: arm64: nv: Set ISTATUS for emulated timers, If timer expired
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241210/202412100311.HEYAT0bx-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241210/202412100311.HEYAT0bx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412100311.HEYAT0bx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/arch_timer.c:1202:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    1202 |                 struct timer_map map;
         |                 ^
   1 warning generated.


vim +1202 arch/arm64/kvm/arch_timer.c

  1190	
  1191	static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
  1192					struct arch_timer_context *timer,
  1193					enum kvm_arch_timer_regs treg,
  1194					u64 val)
  1195	{
  1196		switch (treg) {
  1197		case TIMER_REG_TVAL:
  1198			timer_set_cval(timer, kvm_phys_timer_read() - timer_get_offset(timer) + (s32)val);
  1199			break;
  1200	
  1201		case TIMER_REG_CTL:
> 1202			struct timer_map map;
  1203	
  1204			val &= ~ARCH_TIMER_CTRL_IT_STAT;
  1205			get_timer_map(vcpu, &map);
  1206			/* Set ISTATUS bit for emulated timers, if timer expired. */
  1207			if (timer == map.emul_vtimer || timer == map.emul_ptimer) {
  1208				if (!kvm_timer_compute_delta(timer))
  1209					val |= ARCH_TIMER_CTRL_IT_STAT;
  1210			}
  1211			timer_set_ctl(timer, val);
  1212			break;
  1213	
  1214		case TIMER_REG_CVAL:
  1215			timer_set_cval(timer, val);
  1216			break;
  1217	
  1218		case TIMER_REG_VOFF:
  1219			*timer->offset.vcpu_offset = val;
  1220			break;
  1221	
  1222		default:
  1223			BUG();
  1224		}
  1225	}
  1226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

