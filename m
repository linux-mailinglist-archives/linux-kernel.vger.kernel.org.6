Return-Path: <linux-kernel+bounces-429016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5B9E1651
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626DB1648FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90061DDC39;
	Tue,  3 Dec 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROi4YqB5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915B1CABA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215997; cv=none; b=fIOf/zsbrf6+q3Prx73QAI+yWxXc+xgpgIsBIRxsj6bNsM6KgSz2GPdim1R/zjfoWoPly0YiL0ymqNA+dURslH0ultVR6ms2c9nOekPI6G9jtZ15Fp05hpVfqvqP9x74PmFSBupsxPgrmz5fakFLxjhWoE/PhNU/ZIsg/9ImYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215997; c=relaxed/simple;
	bh=CU0IWkNSCr2UWoykW713NKlpUMFA+dXgB79oDBWgSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lb9yORiqbe/nf1HKMyW4S8Y516yRwW1SLDoBa286D4bHQhDEcq6mHJP21QlycyZW3S4MEkj1DRO+sCcl2TCWI7WwPqEBVWlCdhRQmzGaZwFR2+A6ZqVtFt9gm7MeaTdE9xOK679j+3zGsf8YpwfPecglxAD2fcsO05b2IFfbtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROi4YqB5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733215996; x=1764751996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CU0IWkNSCr2UWoykW713NKlpUMFA+dXgB79oDBWgSXo=;
  b=ROi4YqB5f8a7D9Xu8h6tx1YWVMIFMf6SrcODapGuL+jiN39/Nl/cZwAd
   sjhosmlU8SkFvwGc/VSehruROJ6oYVH++gT8blTQYuL1hfXhU7UHnWJQ9
   Yj5dgPTEbLgU3UMhwz4X8usHOtdhIo7g+9Ar6btZWZGygD+B8MNYfIZuV
   j+jmZ5gv1yRgqe9ToJ/bvmX1tUds6GP9K0uJe4rztdv3YlNBQv1X2tg+4
   3QvFuGz7SknS3FUU/wnlJQ7lBwpluD0mi1S/ydGhXLj3ku/sVPgy/70mk
   XU5ntnIb+8Z+ScrFmTmPiEQHuZio4i5gmwrQ8Imw+oRGWfIsDQkREGlCS
   w==;
X-CSE-ConnectionGUID: 3OymCMX/RcWHit3yFKRlzA==
X-CSE-MsgGUID: JkFadLA8REqtjwCxs0aFYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33337525"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33337525"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 00:53:15 -0800
X-CSE-ConnectionGUID: ittYTnFSSOm0xOwa0vDwwQ==
X-CSE-MsgGUID: dBFeScKkSwqRnxFFtH5o3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93566422"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Dec 2024 00:53:13 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIOec-0000QX-1Y;
	Tue, 03 Dec 2024 08:53:10 +0000
Date: Tue, 3 Dec 2024 16:52:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: sound/pci/oxygen/snd-virtuoso.o: warning: objtool:
 .text.hdmi_write_command: unexpected end of section
Message-ID: <202412031607.GdxibPdr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 349fde599db65d4827820ef6553e3f9ee75b8c7c arch: enable HAS_LTO_CLANG with KASAN and KCOV
date:   1 year, 4 months ago
config: x86_64-randconfig-121-20241113 (https://download.01.org/0day-ci/archive/20241203/202412031607.GdxibPdr-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031607.GdxibPdr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031607.GdxibPdr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/pci/oxygen/snd-virtuoso.o: warning: objtool: .text.hdmi_write_command: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

