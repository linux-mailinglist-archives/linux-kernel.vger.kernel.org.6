Return-Path: <linux-kernel+bounces-259473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F519396BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD8CB21647
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970124438B;
	Mon, 22 Jul 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+BhV9Kt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB61401B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689028; cv=none; b=EKqtIH9UHAhgnC9vHxzh6LGL46gearW2BOdDgUv64DItXDdFW52fpd0BdQlzU6c21vYK1OKIYugK6+4jceTh9HSI3MYqBpOw60K2yW56T5ZWAqpUjaFiUTNb9VWzhBzLzdm0GNcQ53F+Aga2almZMI5hhY0BnDNw+ehLnzk0fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689028; c=relaxed/simple;
	bh=hTZaaadCNgRsiyJJkgcyhjuh3rbYlwXIOezqyckecDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=obHMUf77sbyQ12r1BE6dyGr/lCxTMLWYaU5yjLfR2I8GHOMhZehvfw7/C3nP9Yl0+B7T4A5l4yi7BkJZz/Mq8Oy50RC8pUE6rsD0Nne8YKs2nTiF2oXXcAAXbEuinE85p3k1g4GE0v1CSXDu7twOdVUzzqXKVcU3hv+CA3+6d9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+BhV9Kt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721689027; x=1753225027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hTZaaadCNgRsiyJJkgcyhjuh3rbYlwXIOezqyckecDI=;
  b=S+BhV9KtKle4TkO+KbsffzZxd2nwebw1qGNgmFwOp6l5JboZw4p6eaU7
   wfbFkwEZwTEbvGd5UBuPjcIdSAksDicvSLPmL24WcBjHVfyAoJoCeL6lZ
   C9Our3p5nOfPZ33ut4XA5bGSjNxWR+bBgfRSYCfd2xdN4KE97NNNKXr6I
   SSLHj9wYgCLIFxmewwrv2czAGWs//ehV52sD4Smyjlv+SDJLyt3GdYpcq
   gBsYaGfkyIHRYoEy3niF8gBy/Pv+YmKhGuExeDFm9oi8EgDTKscyWchFb
   Q3SmpbhXnirdg1WVw1pbJKEornd8xciTJ49RpHIV86lbHlTOKre7BKhme
   Q==;
X-CSE-ConnectionGUID: MSvw+EUIQ1m1+f/HPkS+Mg==
X-CSE-MsgGUID: gWLEN/FGT+SR1sqXTPy+nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="41812790"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="41812790"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 15:57:06 -0700
X-CSE-ConnectionGUID: 47gvh1UARmiDFyPrsb9Iow==
X-CSE-MsgGUID: PhmC24vTSkych6ZcxH22Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="56581503"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 22 Jul 2024 15:57:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sW1xm-000lSm-37;
	Mon, 22 Jul 2024 22:57:02 +0000
Date: Tue, 23 Jul 2024 06:56:46 +0800
From: kernel test robot <lkp@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/gup.o: warning: objtool: faultin_page_range+0x100: unreachable
 instruction
Message-ID: <202407230630.3vGhnlFB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   933069701c1b507825b514317d4edd5d3fd9d417
commit: 631426ba1d45a8672b177ee85ad4cabe760dd131 mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly
date:   3 months ago
config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407230630.3vGhnlFB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407230630.3vGhnlFB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407230630.3vGhnlFB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/gup.o: warning: objtool: get_user_pages_remote+0x160: unreachable instruction
   mm/gup.o: warning: objtool: get_user_pages+0x12c: unreachable instruction
   mm/gup.o: warning: objtool: get_user_pages_unlocked+0x138: unreachable instruction
   mm/gup.o: warning: objtool: __gup_longterm_locked+0x3d8: unreachable instruction
>> mm/gup.o: warning: objtool: faultin_page_range+0x100: unreachable instruction


objdump-func vmlinux.o faultin_page_range:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

