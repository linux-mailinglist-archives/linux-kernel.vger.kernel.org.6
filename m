Return-Path: <linux-kernel+bounces-322316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2445972745
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F891C21F37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1AF149DFD;
	Tue, 10 Sep 2024 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZ/e3MMU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23C13B2B8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935818; cv=none; b=E/EE7nOBcbL+xXAFCxVBzo/wwlq8UXOyd3I7xiCg48P/8zz0wyxhGbC8NlEbCcurmpEncn/mASbVlZwIbF//kW4ynd4uVygNtMND0hoeMz20QQppAvCAMsmK1wvQlL2VnkuBlbJXajqbcpk5QbCCzhLIMSznwyZfw3bs4RR2o/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935818; c=relaxed/simple;
	bh=3nA2LcrwMB0sxRvlynzUMxy6lDxZxAe7b8lmJnO98k4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W8LMyOIgak94YlHGk7dTexrLA1uyCW3OCbDzIjZrHqQ6AvELu0bxKz1SSekdyN1l812th4Msf4Q4cik/fPAq8j2bOVImRKuDURWxoEamcXMUprQDG1plv+iSICRYf+DMBzQNZkg4RWi2BLN9jLcl1e/Imh3UWL3MnRY25Cxfaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZ/e3MMU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725935817; x=1757471817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3nA2LcrwMB0sxRvlynzUMxy6lDxZxAe7b8lmJnO98k4=;
  b=iZ/e3MMUQVCPKm6SEM3S/4Z9DXsDEE+6ifeyHLuUQLwMK81RFDJLACiS
   wqptlYtPZRidOFcuhaUXnzDluO+8XRQhkMO236S8N8AdAtiN/9zu09SBc
   8yeshIjL2B6lKlkzLiPlCp1FGe2De4Fea8NjR+8fsPrODD8p2eImIcJNd
   nylYHKP0/du4ZjtZAq7KQ3e2x3zTDTa8y6KLxL9wD4PGOxwfbvnm0CSiG
   01tfkx6sbngrBttu+eXnyJogwKaeHz+U4yoPEDfXsnMVN9uO1f4o7QOzN
   1eIp/jxf311BNUQSyGTkL/q9qX2eo6baro/b6T7XaqS6sEk9nfvlirLxJ
   Q==;
X-CSE-ConnectionGUID: iTzJADfZRjGNuF9WpQMoUw==
X-CSE-MsgGUID: Q9H88t4mR+G0HhJesIdfPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24822429"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24822429"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 19:36:51 -0700
X-CSE-ConnectionGUID: WcTgxMxcTuuMCVDy6MtY5A==
X-CSE-MsgGUID: x9e1eAz6TveWblNGpU4aKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="70997297"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2024 19:36:49 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snqkI-000FYa-1o;
	Tue, 10 Sep 2024 02:36:46 +0000
Date: Tue, 10 Sep 2024 10:36:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: llvm-objcopy: error: 'arch/x86/um/vdso/vdso.so.dbg': No such file or
 directory
Message-ID: <202409101055.eK1jaRwC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc83b4d1f08695e85e85d36f7b803da58010161d
commit: 349fde599db65d4827820ef6553e3f9ee75b8c7c arch: enable HAS_LTO_CLANG with KASAN and KCOV
date:   1 year, 1 month ago
config: um-randconfig-002-20240909 (https://download.01.org/0day-ci/archive/20240910/202409101055.eK1jaRwC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101055.eK1jaRwC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101055.eK1jaRwC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> llvm-objcopy: error: 'arch/x86/um/vdso/vdso.so.dbg': No such file or directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

