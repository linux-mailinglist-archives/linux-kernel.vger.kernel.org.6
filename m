Return-Path: <linux-kernel+bounces-285497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDD5950E32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6204B1C2323F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C301A7060;
	Tue, 13 Aug 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuSCHYIp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728D44C61
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582664; cv=none; b=hyTvqfMhaImRvR0UpDzaq2hhCLV8TzH2Iv2G0qxysHslu77hbqWe49EHe9N4Cc6d0XcoTJxb/R/RHySsHbWQj6GWakzQFMF32ExGZJ88t2FOgVrFWZSwsd01E0FtHLeLpl4QPwrQc8XWl2Pgrb0VKZwpOr+dLWvZTzMh7c6Bg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582664; c=relaxed/simple;
	bh=QQb+yoLfcbSuHiQDh6IBowxVUFi4AdCKYv7lkzs4ibs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QChtb/xAcweZvv9r46V33qt/3BRV0ycAXQc4unO8i93ZmqdIAFz+Ii0ENgAAMRbykSI6L9oNYlKCxU2kLZ9WP5Irxq3UsLrt/JLWHXDeAqnhoIVeoWJnOfNEDynQolTTZMMJHzUmhJs3edQxTzPJJM+/kI+xIjj2665A1YBwrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuSCHYIp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723582662; x=1755118662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QQb+yoLfcbSuHiQDh6IBowxVUFi4AdCKYv7lkzs4ibs=;
  b=ZuSCHYIpCP46ei8CdFgXYkY/pWFI0xmW29DeeFX7mfcKdWiax+/CdX5H
   UrzFUgQLsGbCxuicPil62AONbkZjkr9OI2RCin7tXZajjeXal2TN9zOEj
   SiYnamOHRmvbmhOct75TvMzxpklf5sFKRnklHLGg47+98K2uQOMqmTnWh
   dfDh5OAY4P8A0uIpsKur1wxew7tggjP9ZTm3dFNLgaqMXagrIhV8Hz4ku
   UWXLn7ZZbgM7U+pmaq9ZQ/lNEr7/x0la/6xKvFdPpcSVOL794mLXcQzq/
   +9Q25OM1A9wi37gHYKyru+Juk8o5Q3E5dDs5rLOzK1uRHzhcGfDVkBKfK
   A==;
X-CSE-ConnectionGUID: AqHeBk14S2ip8YLDB8OdaQ==
X-CSE-MsgGUID: RYgpIsMsQ7uWLleoN/XTVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32451616"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32451616"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 13:57:41 -0700
X-CSE-ConnectionGUID: tyoaJ9HUR1imQSi7hQLr8w==
X-CSE-MsgGUID: 7E88kVq3Rii7wBX0OV9ikw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="59095734"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Aug 2024 13:57:39 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdyaG-0000iw-2X;
	Tue, 13 Aug 2024 20:57:36 +0000
Date: Wed, 14 Aug 2024 04:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: ld.lld: warning:
 src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6544:0:
 stack frame size (3416) exceeds limit (3072) in function
 'dml_core_mode_support.138133'
Message-ID: <202408140456.k2UqhEiG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6b4aa469f04999c3f244515fa7491b4d093c5167
commit: aa463cc850c464091cb749317372b70415d3e7d9 drm/amd/display: Fix CFLAGS for dml2_core_dcn4_calcs.o
date:   4 months ago
config: x86_64-randconfig-002-20240810 (https://download.01.org/0day-ci/archive/20240814/202408140456.k2UqhEiG-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240814/202408140456.k2UqhEiG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408140456.k2UqhEiG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6711:0: stack frame size (4888) exceeds limit (3072) in function 'dml_core_mode_support'
   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8280:0: stack frame size (3264) exceeds limit (3072) in function 'dml_core_mode_programming'
>> ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6544:0: stack frame size (3416) exceeds limit (3072) in function 'dml_core_mode_support.138133'
   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:755:0: stack frame size (3432) exceeds limit (3072) in function 'dml2_core_shared_mode_support'
   vmlinux.o: warning: objtool: .text.jffs2_erase_pending_blocks: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

