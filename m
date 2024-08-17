Return-Path: <linux-kernel+bounces-290761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC6C955851
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5871F222A2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812815444E;
	Sat, 17 Aug 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6ve/loF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1F1EEE6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904505; cv=none; b=WkZPVYh9RoIbQMWL3U8dULB4KK201pnHjGK81ZXGRwFh2p9ovOfvE2naSPUIQ4NBso18OfslzEbFwn8prNX+PQImf51EOTcSFB/Z2tisyyu1DGR81o5z5MOZmbGj1VAl93Tu1kQiCOifPUHmTpJCcbVDc6iMn3eBqO9NeHLmUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904505; c=relaxed/simple;
	bh=htRSgoh4HeAnINgrPfrRqDXF/tbWN8laKhf4x5ETh14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tyLYDPS+BscgpoW2RZj8lZMQPLysjURI/oeqCcr37QS3w/JBIA1JCFGRoXfIRLxpWzkFctOowdFoWmaAL0sHFPZyTBRXUeRk/zT1uZ225MgGL7SEgcOF+ZwRAO8gmAqWMsK1vR9LP5hp58oHXSTGhlVtv+WkfjwdOyfJKqzhgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6ve/loF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723904503; x=1755440503;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=htRSgoh4HeAnINgrPfrRqDXF/tbWN8laKhf4x5ETh14=;
  b=U6ve/loFALXdUg4VYgZZT6Yo9YkPrMeVj8Eo7c8/NkZljJAX94wvnnKn
   0ttftRQTiWzp+fYlGMMp+eEt0MqBdN7Swt4PAYvSjhtlECHyw95DI2Sv6
   YiW93KOvPzugjigEnGQZgchPlMvJPytP3g3Czi+g/GFh8usjdTqWHDSKs
   ZaleM28HKbJ4P3Ad3OcDooKicYSSQGe1QG9B2iEIA61eRe5vcYPG+G+Z3
   LA4Y1DR1mxeNL2MkYz+YYgOO2eWXZcHVnyMJEPSR2XUV1jmjx4/VnOQCZ
   AKN51i0w1QWYvF/iqLMEVWWMJ13m24Fh5nqE8NLzJhh32wS8M97SIMty2
   g==;
X-CSE-ConnectionGUID: M3XiBwWtR02/aiijHLLCOg==
X-CSE-MsgGUID: ED/qUTRfTx6kE0b0j4uYXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="26055017"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="26055017"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 07:21:43 -0700
X-CSE-ConnectionGUID: NQDKtBghSU2WdzZWqgGrrA==
X-CSE-MsgGUID: DP/XN7snQpCAvd3zsZf+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="59918083"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Aug 2024 07:21:42 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfKJG-0007Xk-2O;
	Sat, 17 Aug 2024 14:21:38 +0000
Date: Sat, 17 Aug 2024 22:21:33 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: ld.lld: warning:
 src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6544:0:
 stack frame size (3416) exceeds limit (3072) in function
 'dml_core_mode_support'
Message-ID: <202408172241.anNeqaHq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5fa841af679cb830da6c609c740a37bdc0b8b35
commit: aa463cc850c464091cb749317372b70415d3e7d9 drm/amd/display: Fix CFLAGS for dml2_core_dcn4_calcs.o
date:   4 months ago
config: x86_64-randconfig-102-20240817 (https://download.01.org/0day-ci/archive/20240817/202408172241.anNeqaHq-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408172241.anNeqaHq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408172241.anNeqaHq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6711:0: stack frame size (4912) exceeds limit (3072) in function 'dml_core_mode_support'
>> ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6544:0: stack frame size (3416) exceeds limit (3072) in function 'dml_core_mode_support'
   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:755:0: stack frame size (3384) exceeds limit (3072) in function 'dml2_core_shared_mode_support'
   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8280:0: stack frame size (3120) exceeds limit (3072) in function 'dml_core_mode_programming'
   vmlinux.o: warning: objtool: .text.jffs2_erase_pending_blocks: unexpected end of section
   vmlinux.o: warning: objtool: bad call to elf_init_reloc_text_sym() for data symbol .rodata

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

