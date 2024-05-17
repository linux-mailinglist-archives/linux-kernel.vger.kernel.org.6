Return-Path: <linux-kernel+bounces-182299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6AB8C8957
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E1B28118B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4F12D20E;
	Fri, 17 May 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Us9AlMZl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3E12CDAA
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959722; cv=none; b=g+gPpScl2MYmP+UBSe4EVsSQRMpMzrT/F39vP0gH9k3lj15MnSXgYvv0g+ohuVaIbn17XilMsxzEXshI26WRT5S2n8pid+GZiG9OHprzuVGvSjy50Q2inMtmAkL+u9t5OYko5T8MoK7wTx5x/5U1TLoYaaCuLwGMNyrYQhnoY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959722; c=relaxed/simple;
	bh=EAa3otoDvl6LuRbbh6koX1ce+q3bgRPeXUvurxTEeF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZB0W8HtBapR7Kzu0hwJQDMTP0L4FBzAD/hHleWtNtyxNh8Us6pyjlEizUQN5WVIscbIZ2pRGC/u+K3geBkEf8OUeq+8FwFAhEIqfcWqvB4cZmf6idZVeufGc8VAgFJ6a7/NmlWk3WbqWIfdpHaydphkEVv8Ufn8f36rWnccSQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Us9AlMZl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715959720; x=1747495720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EAa3otoDvl6LuRbbh6koX1ce+q3bgRPeXUvurxTEeF8=;
  b=Us9AlMZlema/1LBxa/lm5Q+GfY3NZwkfSjhMr2JkaPRYsg3rPP4MzVmn
   XJrsXJ2LwIYvB3veFIdyZh276NgfBSfGBSVPKvMf615DHASChCQSZPwho
   QcEIft2qo9pB2x2LJhIl6jlHxMqnt7Hlu7stAbxQxGa2v01dWtpGhEIOQ
   F0c9mUqPuIQRAzIszrqHOm1n2K/0WgbNbduJRjhWB+EzPyZJanJNcyIgn
   U+yh1krjhhB/HVwn69PudSnGmVSJWkcaHbaHmHn6Uuv5k5B5R72B+Qi6k
   dM5nY6u1lJO/LoqY2asSgWS54xhTTccpaAw0yFnOI8wy7gLLKGtodcYys
   g==;
X-CSE-ConnectionGUID: IQk+4mw2RLCpcZ4OZ+9VMQ==
X-CSE-MsgGUID: Ue/fVxm/THqqG+3Hr89A0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12262577"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12262577"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 08:28:40 -0700
X-CSE-ConnectionGUID: bJ2aAk8yTcOMCWOTnKoZ5A==
X-CSE-MsgGUID: lYC6ld3EQouKdULg0ER/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31658117"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 17 May 2024 08:28:38 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7zVc-0000q8-0d;
	Fri, 17 May 2024 15:28:36 +0000
Date: Fri, 17 May 2024 23:28:05 +0800
From: kernel test robot <lkp@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_on_each_match_symbol: .text+0x738): relocation R_RISCV_PCREL_HI20
 out of range: -524441 is not in [-524288, 524287]; references
 kallsyms_relative_base
Message-ID: <202405172310.Wgr78VLw-lkp@intel.com>
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
head:   ea5f6ad9ad9645733b72ab53a98e719b460d36a6
commit: 4dc533e0f2c04174e1ae4aa98e7cffc1c04b9998 kallsyms: Add helper kallsyms_on_each_match_symbol()
date:   1 year, 6 months ago
config: riscv-randconfig-r063-20240515 (https://download.01.org/0day-ci/archive/20240517/202405172310.Wgr78VLw-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405172310.Wgr78VLw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405172310.Wgr78VLw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_match_symbol: .text+0x738): relocation R_RISCV_PCREL_HI20 out of range: -524441 is not in [-524288, 524287]; references kallsyms_relative_base
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_match_symbol: .text+0x74a): relocation R_RISCV_PCREL_HI20 out of range: -524441 is not in [-524288, 524287]; references kallsyms_seqs_of_names
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_on_each_match_symbol: .text+0x752): relocation R_RISCV_PCREL_HI20 out of range: -524441 is not in [-524288, 524287]; references kallsyms_offsets
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_names: .text+0xe4): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_num_syms
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_names: .text+0x106): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_seqs_of_names
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_names: .text+0x10e): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_markers
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_names: .text+0x116): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_names
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_names: .text+0x11e): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_token_index
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)
--
>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_names: .text+0x1dc): relocation R_RISCV_PCREL_HI20 out of range: -524440 is not in [-524288, 524287]; references kallsyms_token_table
   >>> referenced by kallsyms.c
   >>> defined in vmlinux.a(kernel/kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

