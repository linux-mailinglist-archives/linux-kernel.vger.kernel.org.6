Return-Path: <linux-kernel+bounces-282211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C130094E0E0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F052B2196B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C183EA83;
	Sun, 11 Aug 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7uv8Z8s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1828E8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723372511; cv=none; b=hNpUSUh+wth4ghDKhqk6s4mCnhAuMyC4gojPEcwLSN6apWoVxA1gw0KMgz4bUaAGy14WYsVUwPPB9myV2K0180nwLMw0uG9qTqKaiJSa11YxH96Y6zxYvrDrr2YGPywBObCUMHqwwdz00BNQoIvqzv4vpKzFu1Ol7vTOQdK3ZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723372511; c=relaxed/simple;
	bh=VJIQmIfB4cDMhKGNa8HmHJlJQgtlHd799QWPQX4eIM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rWA6IzE/6rEsQN64cQjzO6VevDCsByBHBRBCcRbmf87NksZGsWUAz4OdxfGT+lcu8Klcdpp2G5ssxq8i8WIj9Z+hbALBtBS0yypiVBwKsEieay9fn7MEBVdxSdJQXtKbwCiOd1QF3tz9PdJWRMOlxjUkXG6XNto198r7huRGz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7uv8Z8s; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723372510; x=1754908510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VJIQmIfB4cDMhKGNa8HmHJlJQgtlHd799QWPQX4eIM0=;
  b=J7uv8Z8sP6gb6chtQuPgz2/SYmohVj4MuJ5+A21d3sT5RdkHqFeGxVeX
   v/FATV8K5uZmxUONjhh7RPRq11lOfg2JKrxpVTpWB8Z0n8C2rlzVA3gfE
   EH2LQfruapN9YPSTUczYAjbx7XtmuBPwkiVmp0XXcxKTPWyknshzvwf4B
   hbawdrA1uoSe3LuKdjiUtwNb79bWYIfVzpIqQU/EDIptVTFsM1cyh/xwK
   1YPhMrjq9NOrpdLZotEOhurNP8HM62Q0sLruoyp4UO3RvFhvDC0TGgXxq
   x/ECwmA1933KDZRcFfjL33WqHT+vXHTFEj+INXyXDJLfJHkV5pF1ga1Uf
   w==;
X-CSE-ConnectionGUID: BYkTxYyMRomykIhqALXAtQ==
X-CSE-MsgGUID: Hsw1NQY3QquBc91zVlJoFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="44009930"
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="44009930"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 03:35:09 -0700
X-CSE-ConnectionGUID: /4a42Uy3TEWRRW37Gx6n6Q==
X-CSE-MsgGUID: rVnXM2mTSTqjP4DNuKsI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="57635678"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 11 Aug 2024 03:35:07 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sd5ui-000Alz-2k;
	Sun, 11 Aug 2024 10:35:04 +0000
Date: Sun, 11 Aug 2024 18:35:00 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol
 'errata_list'; recompile with -fPIC
Message-ID: <202408111803.JqO5xaZe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5189dafa4cf950e675f02ee04b577dfbbad0d9b1
commit: f79dc03fe68c79d388908182e68d702f7f1786bc kconfig: refactor choice value calculation
date:   4 weeks ago
config: riscv-randconfig-002-20240811 (https://download.01.org/0day-ci/archive/20240811/202408111803.JqO5xaZe-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408111803.JqO5xaZe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408111803.JqO5xaZe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'errata_list'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:99 (arch/riscv/errata/sifive/errata.c:99)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'errata_list'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L.str.8'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L.str.8'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'errata_list'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'errata_list'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:71 (arch/riscv/errata/sifive/errata.c:71)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L.str'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L.str'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

