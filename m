Return-Path: <linux-kernel+bounces-540825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE2A4B589
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C43516C1D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7A1EF091;
	Sun,  2 Mar 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auNKFjF/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34341ACED2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740959332; cv=none; b=kPA/AgIzqHsnGWp56IrdV5y6SP/xnnH5/Mg5KHds2bjEUTGiWTJmMiuQ5uBuX/2pgP+yOUfSfoialJwB5uNWTQAg3oT8CannXmad2YlnN1vT8nsbDCNM876lb/ywv23HpdZFMdEQy4KIhzX8fTXzXy5UPb+mSgvaOdfa+7xSKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740959332; c=relaxed/simple;
	bh=P4P5q1j0BL73vsYBvmhK3iqresZKXum9b4feznRvNN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C2sbItztQxLpVG97kpUM9nBueWV7LHUt8KqQWQLomRA8wULe/vfGKuKDmQm88vMzc/3/gbdXR7CbbcBGO5oi9xT7neYSlVK7YEAuaw7aIZdipY9w4+u9rnEHmqAPzJldYFVHBC6sFuk+I9XQ75Fg6VOWQCO8ov+dS8lhlbfMsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auNKFjF/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740959331; x=1772495331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P4P5q1j0BL73vsYBvmhK3iqresZKXum9b4feznRvNN0=;
  b=auNKFjF/t7X/Otaeb/84WjYDI3YcmSsnzudCTfTkEuyKP0xQvME1xiJi
   QKIE6Zik6pA9h1Bap2xIfX7QNvWRkEvExy72Zl+vvB8w/5mlbdpFQ7Cre
   nFot0GNoZyD8qIvVtd1xoAOcCwlvnToCHQnLfjPsFJYbYcAtCTbyXsWTb
   bRDD5WgY1muwUVP7RivewCGAxnyc++833N45Ws4Ar56ESnvv5ZRAn0zc1
   8Cv9MvTHcP+hvVKjtSZcIwQsozu0BFM0mRBoEglBhuY1zHBAeCFbh4Ibl
   EocsHiBuN2QHRODQDwgiXaKcoZ9u+b9BLLK8f8/7tkvfDIsAIQffjdSlR
   Q==;
X-CSE-ConnectionGUID: pxdVlEepSoafOjajq18aoQ==
X-CSE-MsgGUID: xyeN7dSlRMWtM8cjo7+/9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41711351"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="41711351"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 15:48:48 -0800
X-CSE-ConnectionGUID: NPdWhZQ8SCeyG7Fp4Arkjw==
X-CSE-MsgGUID: ZtKe+IP2Qmi9vteJez5jKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="118542825"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 02 Mar 2025 15:48:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tot35-000HjG-2j;
	Sun, 02 Mar 2025 23:48:43 +0000
Date: Mon, 3 Mar 2025 07:47:57 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>
Subject: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x276:
 relocation to !ENDBR: .noinstr.text+0x6a60
Message-ID: <202503030704.H9KFysNS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
head:   dfebe7362f6f461d771cdb9ac2c5172a4721f064
commit: 0c92385dc05ee9637c04372ea95a11bbf6e010ff [16/17] x86/ibt: Implement FineIBT-BHI mitigation
config: x86_64-randconfig-071-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

