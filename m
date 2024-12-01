Return-Path: <linux-kernel+bounces-426525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4269DF468
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D933162DF4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 02:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52EE552;
	Sun,  1 Dec 2024 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijdnRZub"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E5A94D
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733020413; cv=none; b=Hy1Vw8yEKRZZjj9LssBaU9+E05qwl305AJZvAGSIXBdq3DqVqvCYU0xZpaj6Bc2qKO9B1xY5giXCWVvWIzzPminnyRbfuqXb80kDaP06/VKyXB4ePWDnXuMEDFH77iU1ET7rEVyBOl5kCVBX+yyQbEM3r2MHkGQvFZ+/oiesLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733020413; c=relaxed/simple;
	bh=OimiFsLOOKPfDXi5SZrnYrVngS//hSi2taR9num6zJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QXM6XWS05YkzE9wmuLMnBLvMVy0sKnBQxqNzF6Z8BbUVmiJ+q5kJ0dgLawaZaSgiYXI4gJJeJiup8MrSbbMLXoUQvYFBYIT2KwCdOr56oEGUVlJGd7HqaMbuuo4qHw/VccUSz8OpqkbEIUY20puC8lHV86Seqy+Tvd20ppNmuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijdnRZub; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733020412; x=1764556412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OimiFsLOOKPfDXi5SZrnYrVngS//hSi2taR9num6zJs=;
  b=ijdnRZub7U1cvRAU8z3UhzqSEGxHTZLoUakUsPlkyPbaHVCCTEdP9Kld
   XYVQG+vE1+zdcoV+u2Xnv01C0YqwvB+vXjBPNICFjGjcJW3wIGYF+WuQU
   bLb2zBI7gmSbzGYBHq6PRN/Hku6x9byZM8rj18+biKKOO/eWPV1jBBHG2
   MtVJoM4hU6Fm4YDiBRG5rM564Yw8top98bM57KtbxPTWmSittEnHVaZd9
   UKOEzsY10Qd/b+2JFOVY5MR/dpUdFu4lWh4P77Bt5VA0rDqgRuI4xDqPZ
   zbdsuZwpg9I86NUBFiXNiJDSmoGyMgsV29mk7Di9+YFOk9wlFsL/RZds1
   Q==;
X-CSE-ConnectionGUID: 4P9RkDGKTKy79HFum3gbQQ==
X-CSE-MsgGUID: M9krsjLjQECwfNpKC8lTXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="44573542"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="44573542"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 18:33:32 -0800
X-CSE-ConnectionGUID: 5Lbfg5RzRZC3VG+PYSo3+Q==
X-CSE-MsgGUID: +7csbx3NT7qZ1ST6r5amQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="92657157"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 30 Nov 2024 18:33:30 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHZlo-00019x-19;
	Sun, 01 Dec 2024 02:33:14 +0000
Date: Sun, 1 Dec 2024 10:32:32 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Terrell <terrelln@fb.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_internal.h:206
 ZSTD_DCtx_get_bmi2() warn: inconsistent indenting
Message-ID: <202412011024.uk7IjTsa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfd47302ac64b595beb0a67a337b81942146448a
commit: 2aa14b1ab2c41a4fe41efae80d58bb77da91f19f zstd: import usptream v1.5.2
date:   2 years, 1 month ago
config: i386-randconfig-141-20241119 (https://download.01.org/0day-ci/archive/20241201/202412011024.uk7IjTsa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011024.uk7IjTsa-lkp@intel.com/

New smatch warnings:
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_internal.h:206 ZSTD_DCtx_get_bmi2() warn: inconsistent indenting
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:894 ZSTD_execSequenceEnd() warn: inconsistent indenting
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:942 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1009 ZSTD_execSequence() warn: inconsistent indenting

Old smatch warnings:
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:598 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:598 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:1292 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:1292 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &

vim +206 arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_internal.h

   200	
   201	MEM_STATIC int ZSTD_DCtx_get_bmi2(const struct ZSTD_DCtx_s *dctx) {
   202	#if DYNAMIC_BMI2 != 0
   203		return dctx->bmi2;
   204	#else
   205	    (void)dctx;
 > 206		return 0;
   207	#endif
   208	}
   209	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

