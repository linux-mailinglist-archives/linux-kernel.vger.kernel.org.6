Return-Path: <linux-kernel+bounces-180668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A58C7192
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCE5281C33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57485219E8;
	Thu, 16 May 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4EkGDKC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520592031D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715840197; cv=none; b=ZO3ykMvK4wWvC0XOJvTKzMtgA4viGaFpLjAmsy+Qm06EssEPw7G9aTRd8jy2DJm3PJiCuTQnyf4gkvPjL4JKkSt+et/lC7dnB96xU7KbAeSnNio8mNtkEehcBXvlN0coAX813Q/TMlsiXPdOw6Ojhv4bf5OoXgNucwhoFKApakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715840197; c=relaxed/simple;
	bh=Yl8eButfmyDS9SA16/mNgYevzdrkGdZQBO9SJsfhqJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kEyuHe/wS4iqO/YmR1SLbPj0mWdH5vgc7ZKTPRDnfyWrpxVz7lJIRds5tE502eSpUywxFwtv0ravIId5T5jR8aSD2CxIqLgQ6YQlwKmZgEeeoMZO/vbKCqASqh+DrM4MhHf7cSEwjbyTefldce7XN/JXCqjcff8nIFQAN9UeDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4EkGDKC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715840196; x=1747376196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yl8eButfmyDS9SA16/mNgYevzdrkGdZQBO9SJsfhqJQ=;
  b=l4EkGDKCIk12cuWxLafgq89fpNa9P3PPmeAv2LyUtKjLkJFFgjJt1a6c
   5TcdmBmBvIygBwdhwvr+w5L4ltN0QB68RYpIuVdL2LikNvbajRFRL6n8s
   kWqzcqPZaZb0HO7YLdyeuAuN8BvSt/VT5A34Gh8wTQ34IuYa2uOHAy4FM
   V7qQHOnwgSDY0F0s+6xX5z6wM4FGbYe06tiwOnNOkVdzLCSjPGvDWEyY8
   t4Xx7Wx1XHdai2i849vPV1Ziv0UZc0wIx17LoRMDwD7keeKdU813sRErJ
   S5HAEee87YM+c80fldD1HVFCeEQ3NbuUITWBGEO/M3ItFSpWTPc14O4QZ
   w==;
X-CSE-ConnectionGUID: XZ7UV1hcSHSfdFwV7QKJ5Q==
X-CSE-MsgGUID: sJhqQFUmTCeyMCOUewNg5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29425752"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="29425752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 23:16:35 -0700
X-CSE-ConnectionGUID: COhd9G+ERM+sLcI8LJFYzA==
X-CSE-MsgGUID: 1pNcoLcuRm61zmHSE2kl9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="35758387"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 May 2024 23:16:33 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7UPn-000DjQ-17;
	Thu, 16 May 2024 06:16:31 +0000
Date: Thu, 16 May 2024 14:15:43 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_on_each_symbol: .text+0x17c): relocation R_RISCV_PCREL_HI20 out of
 range: -524478 is not in [-524288, 524287]; references kallsyms_token_index
Message-ID: <202405161456.yVXb0c0v-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
commit: 3216484550610470013b7ce1c9ed272da0a74589 kbuild: use obj-y instead extra-y for objects placed at the head
date:   1 year, 7 months ago
config: riscv-randconfig-r063-20240515 (https://download.01.org/0day-ci/archive/20240516/202405161456.yVXb0c0v-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240516/202405161456.yVXb0c0v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405161456.yVXb0c0v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_symbol: .text+0x17c): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_token_index
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_symbol: .text+0x184): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_token_table
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0xec): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_relative_base
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0xf8): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_offsets
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_symbol: .text+0x142): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_num_syms
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_symbol: .text+0x15c): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_relative_base
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_symbol: .text+0x164): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_names
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_symbol: .text+0x16c): relocation R_RISCV_PCREL_HI20 out of range: -524478 is not in [-524288, 524287]; references kallsyms_offsets
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

