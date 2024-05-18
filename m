Return-Path: <linux-kernel+bounces-182757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE1D8C8F59
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 04:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2977D1F21930
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E0523A;
	Sat, 18 May 2024 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSohQT9s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9C1A2C11
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715998654; cv=none; b=sq+l5BGGY6cEXrhD4kJsWMOAzFA3xpbujmE86khixlON4Qc85i9WCTUThC7y9x7tBDLRPXWsKSPSv8cClzJuR76Rffv3vLtOW9WN0HunMGsr10iQJWmFi/0sWhS88NYpEq/SU5k33Kl+anfrSEnafBfMaxL5N2OzC8uZBMFTCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715998654; c=relaxed/simple;
	bh=3BDlydd5i8qSZJF3bOkS5fClIP9/srFle1tq8wrUvzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e9OYZLYZz4ZkNpMno0Qs1WHasXmle3ElP4F4VfcEFjDu9UEahgYcbwmpeR8l1OUEoX49S8naQ7rCNlYjYT37IMWpfK1FI5083EPwGJsVMsMRYFyzCrVa+uwwIH+kz/udcED8q+Dl7qLkVGE3+U0hCNYqVfaGUCKHpVSde/90fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSohQT9s; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715998652; x=1747534652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3BDlydd5i8qSZJF3bOkS5fClIP9/srFle1tq8wrUvzY=;
  b=eSohQT9stLsfw1nzdnih4vM7fZ2CTMcuqANxhuK15NFFflEkk0uvkiNC
   fGL5hALx6tD5+T2WkLDyqDpAQ91ZuHOTr7Yt8X7M9LEKtmyaeNvCPnp5V
   c8edv3ygoRbKOGTUTgdZzMu2bEtxRpZ87+WE6GEL8cMzg9B5dJHloajIk
   RmCcCKO6dP2yqeYX0zD2IagY6MeW8x4LoKLdIbKyQH259hPcHf0oNnuCU
   g7mR4BLjf4fhz+z64xzz/alaz0WmwVk42strzPc/kjUYgJ5Q8/ohdWMKm
   3IREcjRPHfZUg04EFBTJ7Wg0N8sTUpttD9ePWt62Pv2Rbj/t3y939Fs9H
   g==;
X-CSE-ConnectionGUID: FS/Y8QoKSViDMs3LgzqdWQ==
X-CSE-MsgGUID: UyQK7jftSKuF9elvWKXwgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="16029604"
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="16029604"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 19:17:32 -0700
X-CSE-ConnectionGUID: /fRn1f+BT86pzEbSl+rYpQ==
X-CSE-MsgGUID: lxNW3DJNTwGC53fo0pPsQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="32091872"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 17 May 2024 19:17:30 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s89dY-0001X8-1F;
	Sat, 18 May 2024 02:17:28 +0000
Date: Sat, 18 May 2024 10:17:13 +0800
From: kernel test robot <lkp@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_sym_address: .text+0x8): relocation R_RISCV_PCREL_HI20 out of
 range: -524440 is not in [-524288, 524287]; references
 kallsyms_relative_base
Message-ID: <202405181012.4631UqkB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zhen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ee332c9f12bc5b380e36919cd7d056592a7073f
commit: 30f3bb09778de64ef9f23fb4bb5f868c4728a071 kallsyms: Add self-test facility
date:   1 year, 6 months ago
config: riscv-randconfig-r063-20240515 (https://download.01.org/0day-ci/archive/20240518/202405181012.4631UqkB-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405181012.4631UqkB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405181012.4631UqkB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_sym_address: .text+0x8): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_relative_base
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_sym_address: .text+0x12): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_offsets
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

