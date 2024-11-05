Return-Path: <linux-kernel+bounces-397283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA039BD9DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A907AB21C70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB32216A08;
	Tue,  5 Nov 2024 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYFYfG1K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B41D1748
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850416; cv=none; b=EbSTZRzT7tuKmEqn9SgRvnHXglS2uwwoFLtmM/NQ5rifJJRrJ+YSszzzuDaMjwOlDInGC3D7A6MHqbRz6osUGsg06+XPJjoIpjSz7qsuImL1LzhyyyYPDhhUmqKgUFaTkgXqy1GYgTQTeOK87GFAdtSL2nCEH2KbCrmo1KiuEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850416; c=relaxed/simple;
	bh=RiWBHEfrgM51BbChyMF3AhTN4dXXQKkZTpzLUcsdi48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qz4Q6LIMwhXgLhHrbG8rElyGlx1Cr+UWrMTRSIRNIRWXFbRd0N6HjdZN/GhbV7gL2sT2IX8c/Ch2EdGI6WKp8kylXIjlCbDFEtLLHhI78OaPDWbMgWJMrr38qu+CVDuQJ8qI4JQU+Mmg5LY3858M//WCL30sgH3rFGECdguWgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYFYfG1K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730850415; x=1762386415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RiWBHEfrgM51BbChyMF3AhTN4dXXQKkZTpzLUcsdi48=;
  b=bYFYfG1K2SZIAA6OkdJLl0Db/Th+kji9/kNODuvEYw/teHa22TghEnvT
   lZv31VsZHDlYSZEv/WpWiBRFsI9UlI/FfrRNom43i//8M+1F1TO2Uv8c3
   V2fGHBaRdVS1VUrE73Pt0uw8olXYViCZPgw53WTkHewagawoWVLHsV49W
   5RcyR9LIY3dAr5cRtl1rwYx1bF4/x/ySxPwCalG1GTHYWrXjhgfVmJ5V0
   BCDpyXfwAkQ3uWcerMFzc171D6EoSvNiV+f6p/mMuyheQ/6eB1Y/4KuhI
   X53L9HGSJgR5wyzB9BkBBnybETlR1rwm6sIdUcmiQuLT5cj6huBqlrpxC
   Q==;
X-CSE-ConnectionGUID: S5oqG+FuRrSaM+kJjEbIaQ==
X-CSE-MsgGUID: 43l3mmdCTBCPzjFJf/2j/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30036987"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30036987"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 15:46:55 -0800
X-CSE-ConnectionGUID: xOHTqc2BQpyJJelOFQUh9Q==
X-CSE-MsgGUID: kipk/S0cTkGdmai7TCe27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="88724730"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Nov 2024 15:46:53 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8TG7-000mcZ-05;
	Tue, 05 Nov 2024 23:46:51 +0000
Date: Wed, 6 Nov 2024 07:46:14 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kees Cook <keescook@chromium.org>
Subject: ld.lld: error: address (0xffff8000815b0000) of section '.init.data'
 does not converge
Message-ID: <202411060736.acyzNp9T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2e1b3cc9d7f790145a80cb705b168f05dab65df2
commit: 417c5643cd67a55f424b203b492082035d0236c3 lsm: replace indirect LSM hook calls with static calls
date:   3 months ago
config: arm64-randconfig-003-20241106 (https://download.01.org/0day-ci/archive/20241106/202411060736.acyzNp9T-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060736.acyzNp9T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060736.acyzNp9T-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: address (0xffff8000815b0000) of section '.init.data' does not converge
   ld.lld: error: assignment to symbol __init_end does not converge

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

