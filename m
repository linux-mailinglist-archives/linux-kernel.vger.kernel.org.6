Return-Path: <linux-kernel+bounces-283821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48494F902
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2816F1F22F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0669194A73;
	Mon, 12 Aug 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFsAIJhw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559C186E3C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498607; cv=none; b=c5G841u+urJGSeqAAVv/08VWdyNHjuuO5ai9iEGWMqyDWI6lNA+GIy0qjUkDVvk7CEQ3XvdktQNj5um+4Vpa/3ByF6IeL8oS6WhVgz8c5Htjo+/FEBh5q1IlhMrVtalrnm6uAohEYA34n5GSeLbeaITfbeBJca4E8YKsqCGaea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498607; c=relaxed/simple;
	bh=8z9+1PzvP+5Q68yaNgYtA5o3wmc3B+8FhmL6Cqq9EyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y0RZpAjtmxASujBlTert+kdOyu+taAOA/mtg+KX7sPSZa6uZ9DZR1RJu4YKq9OycIgBCzPKEYWGaV7wDRXqcNvXR2nsfQNPXQTZklB7wNog6439mAVkABUnymmsOen5gKILTavME0K6fSxLSLctxi5xmQsi86HEskv8uenjIU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFsAIJhw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723498605; x=1755034605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8z9+1PzvP+5Q68yaNgYtA5o3wmc3B+8FhmL6Cqq9EyI=;
  b=cFsAIJhwAvB/ueQ2s5R/edQBUtEWLnTs8skdrXByZQzecbVpZhyoHmSj
   eU/B1eqVuFa01qGHiWHzFM3s7C8zsmJvwV+3oyz+s2Yc47h8J6u9C24El
   vR5jZig84eSFNDzvz8WNXe9nfOfkAHn2lCbbWE9w61JlrCl1fQPc4Xvhj
   co1KQkhnvaXrZePfLINsFXPGRXypPtnabxPafXaiPsAcuZZtHLYfar/VJ
   KIBahqXetq2BoMdsC+MFVLXP9jkMAxexyRPiFOsAQ/+0QwT6lteVHh/XB
   Z8tqcmqytyNFzqSW01gpxb1dzut3DC2qCbU1HXQcURnIgfZrsm3Xv1Eyn
   g==;
X-CSE-ConnectionGUID: QFwtIz/RST6BniTeoWtdoQ==
X-CSE-MsgGUID: TvnOH+fxTymWZyf5m9UDJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21777016"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21777016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 14:36:44 -0700
X-CSE-ConnectionGUID: mkiYyRcyRxioi6OB1+WImQ==
X-CSE-MsgGUID: mKQH8xRkRcuCdo+r16JGNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="62830310"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2024 14:36:41 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdciV-000CCd-2L;
	Mon, 12 Aug 2024 21:36:39 +0000
Date: Tue, 13 Aug 2024 05:36:19 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: ld.lld: warning:
 src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:755:0:
 stack frame size (3432) exceeds limit (3072) in function
 'dml2_core_shared_mode_support'
Message-ID: <202408130537.amQPXvmF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d74da846046aeec9333e802f5918bd3261fb5509
commit: 9f4c6256d0cf887ef64fe87a48a34d50b4bde493 drm/amd/display: Add frame_warn_flag to dml2_core_shared.o
date:   4 months ago
config: x86_64-randconfig-002-20240810 (https://download.01.org/0day-ci/archive/20240813/202408130537.amQPXvmF-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408130537.amQPXvmF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408130537.amQPXvmF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6711:0: stack frame size (4888) exceeds limit (3072) in function 'dml_core_mode_support'
   ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8280:0: stack frame size (3264) exceeds limit (3072) in function 'dml_core_mode_programming'
>> ld.lld: warning: src/consumer/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:755:0: stack frame size (3432) exceeds limit (3072) in function 'dml2_core_shared_mode_support'
   vmlinux.o: warning: objtool: .text.jffs2_erase_pending_blocks: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

