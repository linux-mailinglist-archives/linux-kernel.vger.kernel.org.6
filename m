Return-Path: <linux-kernel+bounces-292209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317BA956C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D803628374B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6A16B753;
	Mon, 19 Aug 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjiJ/zR3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD71BDCF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075748; cv=none; b=D8As1IKAV+gmDyPHzHZTtm7cns9RWTaFpFoIWVcTQGvyhV+xjjw4E77EEW9N0YXFIIrdhtZlHHYGLF6KhC++2JLjuE7ESkLYUPNrLHD04jDyFmB9L2dQns3lQgDD0199whzGZrauTS+25l8wBROMPUXchBcBc+VVlp6VWkNIM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075748; c=relaxed/simple;
	bh=WUNrRHqmSsLxXpn67ARAQf22SPte6CU0HDAC1zhNoSs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G9U1VbpxYgYn8RXrUcDG/mZeGThZ5VIuyXEMHeDGELptexsn94hcURpDlWaJj/YZy/ENZrjifPfpOL1sZOlS63Jqtu6lFrBbD2npdgHtnA54b54TryT2ciiP2bNFpzsDyuz/0OW3P03Px2ftNfGf9lag0KnhbnSZb4UC1Mke9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjiJ/zR3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724075747; x=1755611747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WUNrRHqmSsLxXpn67ARAQf22SPte6CU0HDAC1zhNoSs=;
  b=gjiJ/zR33zg3h0dgakrmW7zgGGsVHM7UV4f34BiBDZX8iLrdx8d+e58e
   FswBG/JW7uwWqgfGzQGGlfNVTN51JOxzvOzoIBlVs1es2A/s0A4UTsWwH
   MaP6zZ/x7k+AKgvSh3vLSAMIdZ0ycJojip+kA/rzfzKe4wW5z/Idq8d8G
   CTTqQSi5wDEVRQah5ucb1COk2qd8XWLGjbasxM91ZFfjn21O1FFBDeCvo
   WHnS6R+q4uKxmZqay3/zOMJohRKvwIL97aJKcucqvV0vEqWvfG1ma+VBo
   GqcclmOSKfQe8DObZ3ndGM1c5toR5YN9F8csWRjCa6tQQjSAZx3EbBxti
   g==;
X-CSE-ConnectionGUID: i003BdyGRXC/9Rw94oGFzg==
X-CSE-MsgGUID: yTs7T+ePRjKA5G4drcbq4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="32895342"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="32895342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:55:46 -0700
X-CSE-ConnectionGUID: A/XrSvN7TfuVcQd3TKuGww==
X-CSE-MsgGUID: l+kl596LRmylYDbG1a9r6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64773287"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 06:55:44 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg2rG-00091y-0H;
	Mon, 19 Aug 2024 13:55:42 +0000
Date: Mon, 19 Aug 2024 21:55:35 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol
 'errata_list'; recompile with -fPIC
Message-ID: <202408192115.CLzfNikL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47ac09b91befbb6a235ab620c32af719f8208399
commit: f0c83a23fcbb424fdff5b38fbcdda3c04003a210 Bluetooth: btmtk: Fix btmtk.c undefined reference build error
date:   3 weeks ago
config: riscv-randconfig-001-20240819 (https://download.01.org/0day-ci/archive/20240819/202408192115.CLzfNikL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408192115.CLzfNikL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408192115.CLzfNikL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'errata_list'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'errata_list'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L.str.4'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L.str.4'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'riscv_cbom_block_size'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
   >>> referenced by errata.c:113 (arch/riscv/errata/thead/errata.c:113)
   >>>               arch/riscv/errata/thead/errata.o:(thead_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_S cannot be used against symbol 'riscv_cbom_block_size'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
   >>> referenced by errata.c:120 (arch/riscv/errata/thead/errata.c:120)
   >>>               arch/riscv/errata/thead/errata.o:(thead_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'text_mutex'; recompile with -fPIC
   >>> defined in vmlinux.a(kernel/extable.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'text_mutex'; recompile with -fPIC
   >>> defined in vmlinux.a(kernel/extable.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L.str'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L.str'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

