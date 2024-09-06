Return-Path: <linux-kernel+bounces-318101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06396E85E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E2C286918
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356863AC2B;
	Fri,  6 Sep 2024 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxVRSOt6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9245945
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594305; cv=none; b=dEODwQab8H5l7O1vL3v/JGdjFrqZ+R5JJFka4O8BIz+zf48uXd1eLV9w8CuyrWWKLUrs3xqhxNTGY7TKVlfJLQWgm2XsuTf4ne+WgeJnJdQ03ihvj6wAWcUwyQI2kfi+K8UkE8fNO9dYKzXkFV13Bciqp6KGkEWr3bbd9ekBnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594305; c=relaxed/simple;
	bh=mO1FgOfI7hqFGlj1Lioe8WtQ0H4w7UkUrUyCFgkBHdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fDvQ5jIF14nNmTTyTmqGaLH2uPZiNyH5w0EkcnbtYIfTM3dXpPUdEG61pu18nI/JEXSnv9TmT6WbbtFQe3HAc/DEycucGTts+uhbBVFxQtLaY4ucE1+Ep+0hWBuNuqKJ93NZo+BE2L5EkZyGN8gSnOHiOnEbWnBh1OyX1buCYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxVRSOt6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725594304; x=1757130304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mO1FgOfI7hqFGlj1Lioe8WtQ0H4w7UkUrUyCFgkBHdE=;
  b=CxVRSOt6s6c6hyAm6MrO2fyIN0hxycG5IEtyvIB3dbSvQB1tdZfwg38o
   1978WphECNls2wrOKborVtDECKpBsajoPe3A673Sw19sIjOUx1FsbPMcn
   Zd9jhPKiGgaGJDxn5jAaZHXCW6mWaxlcUn3kvHdNnbEQ3DwdwByYP+k14
   8mO4GmFtZRqIAHrh+ktfjHI12KQTjaLnT9TMOepvmDugJDIS+OfthtIGK
   TWoyORyZK3MeK+nyY211klu/ubWdEXQxCzzEVo9NC47oFqbKrE/KZNxD/
   2X8QvonlDtMdfUUQNxkN1MCQa0dZTR5STX2iAP16pH9+XF4PAJHHCBLTR
   w==;
X-CSE-ConnectionGUID: jCyyNwjeQ6WyWdtIUfEABg==
X-CSE-MsgGUID: L5cR8qymQVqOYd1WBx+tMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24506121"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="24506121"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:45:03 -0700
X-CSE-ConnectionGUID: 5F4P8ZOGQqyGIRjMhLb6Bw==
X-CSE-MsgGUID: cpdW7omYSbe3vIiWHKNQNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="65475582"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Sep 2024 20:45:01 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smPu7-000AZv-0j;
	Fri, 06 Sep 2024 03:44:59 +0000
Date: Fri, 6 Sep 2024 11:44:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/page_alloc.c:7043:20: error: unused function
 'has_unaccepted_memory'
Message-ID: <202409061101.Jlx5z2fI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad618736883b8970f66af799e34007475fe33a68
commit: 807174a93d24c456503692dc3f5af322ee0b640a mm: fix endless reclaim on machines with unaccepted memory
date:   3 weeks ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20240906/202409061101.Jlx5z2fI-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240906/202409061101.Jlx5z2fI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409061101.Jlx5z2fI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/page_alloc.c:7043:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
    7043 | static inline bool has_unaccepted_memory(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/has_unaccepted_memory +7043 mm/page_alloc.c

dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  7042  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06 @7043  static inline bool has_unaccepted_memory(void)
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  7044  {
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  7045  	return false;
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  7046  }
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  7047  

:::::: The code at line 7043 was first introduced by commit
:::::: dcdfdd40fa82b6704d2841938e5c8ec3051eb0d6 mm: Add support for unaccepted memory

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Borislav Petkov (AMD) <bp@alien8.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

