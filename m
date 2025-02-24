Return-Path: <linux-kernel+bounces-528045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821DA412CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B11885D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E0195FEC;
	Mon, 24 Feb 2025 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3/Bzsau"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8707BE40
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362061; cv=none; b=jil29X/Pd4Y4BoKFISvCkMLEvAv1AROxR2rephbaWevgsFIaxa0ztPngw3OpzMJHyvD/T+0xd1B9cZIvz7zW9VOM2ZYVRDbfZTmzEXltM6AuZvzTtt5U6NAs99twQiwqGbXPQKapBBk/x9LP6zU5nV3I4lJI4lor4Dw/prYZFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362061; c=relaxed/simple;
	bh=4z78s7yfM+VsfcW4o1xl0pqvWYtQOUkjszN/4Xlk2qw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rwZsKP2rznGAhIWwwim1OX0e0zN0OENU/nZ3AeKbU2eocT5xLiZksZXGKVGVIgfEDbDnQ5N/amqlQQryQDUT79+QCZlrlhpLFANH/IHlf0+s5FZb6LKUvZxOB3DaWZHW4vzs176ek+f8cRUwmbe/m7SenRtPR1IWqbtG1xnbzb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3/Bzsau; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740362060; x=1771898060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4z78s7yfM+VsfcW4o1xl0pqvWYtQOUkjszN/4Xlk2qw=;
  b=V3/BzsauvGH65Z3XA1QbFIUutKpsYRVpj3xtIvZTWVdgyjVSan2LUAGs
   dz4j6QJXvd9Rfy8M248rG0XPrj1FTJM06yeRwj0YigA19McIYHFOmqW2Y
   BLoF4ojl6PeSBL9fyP/oTu+kU5fer+8EkmJ6TUeEhn2ZT3rUOcST+QGhq
   wGRZODpI5XAHfCu2TOjybeJu4FPiG+7ajMafDhHt3YgWFc4UygZTdY9R3
   VQfpD4/Pdt6n4v7NgirL/b6JqUuMaNKY7qc7U0ksiEGlNvS6fVlacRlEL
   qpT1C/1jLND8THSAb+V5o4NGYICfTFn3/3W4iZOjyq2ZI9hz1YoFUq+kf
   g==;
X-CSE-ConnectionGUID: NVd2MrQ8TJWbz3RDDkVkZg==
X-CSE-MsgGUID: 3YmIsMKaTUau3avX6gE0hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="63574189"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="63574189"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 17:54:19 -0800
X-CSE-ConnectionGUID: Vtb/z15cRdmjBkh9/T9VbQ==
X-CSE-MsgGUID: 1VGH8pFhQbGuADa1EltwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115729215"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2025 17:54:17 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmNfj-0007jj-1H;
	Mon, 24 Feb 2025 01:54:15 +0000
Date: Mon, 24 Feb 2025 09:53:19 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol
 'sifive_errata_patch_func.______f'; recompile with -fPIC
Message-ID: <202502240916.8dheDMgU-lkp@intel.com>
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
head:   d082ecbc71e9e0bf49883ee4afd435a77a5101b6
commit: f79dc03fe68c79d388908182e68d702f7f1786bc kconfig: refactor choice value calculation
date:   7 months ago
config: riscv-randconfig-r121-20250223 (https://download.01.org/0day-ci/archive/20250224/202502240916.8dheDMgU-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce: (https://download.01.org/0day-ci/archive/20250224/202502240916.8dheDMgU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502240916.8dheDMgU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'sifive_errata_patch_func.______f'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'sifive_errata_patch_func.______f'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:99 (arch/riscv/errata/sifive/errata.c:99)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'sifive_errata_patch_func.______f.3'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:99 (arch/riscv/errata/sifive/errata.c:99)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'sifive_errata_patch_func.______f.3'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:99 (arch/riscv/errata/sifive/errata.c:99)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

