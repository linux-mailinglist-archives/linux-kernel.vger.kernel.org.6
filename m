Return-Path: <linux-kernel+bounces-259170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2A93921E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240A42820A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0DE16E890;
	Mon, 22 Jul 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUE671zb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95E16E872
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663942; cv=none; b=l7Q64LAuB8reLYP7dnl0TewozKkMntFff9MrqVw7Wh56sWbOWcF8JGsSwgY6bEfzcl6arDuBPgJB/UamV7lAXYkUuMbtp6MDIOHMPGUYeOBcipwcqoOJfQ0Qs2UrjwJCDQXhN7jCAIkQfqm1sc8oyn6EYCzqivrsOoTJz+P8CJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663942; c=relaxed/simple;
	bh=/HXueyEJisXCOZ++d6QYnKno75mWWc/mIT/u/AMmjng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OA66Ab3fai5GgeLjeMPxGacH6cgvStcJNFQfU/GhYQSix+JPPeWwR7+eq7DODYAsm1PZPSxH3SfKvXgRHSOUqrT4KWVRzNjAHMxB90l0pcL4Bkpt69YfrQ6UhOJownu9JY2KdOXcJ5R7j6ew41mktmzJ8PRIQ0pYInD2VBerZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUE671zb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721663940; x=1753199940;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/HXueyEJisXCOZ++d6QYnKno75mWWc/mIT/u/AMmjng=;
  b=WUE671zbmRmHqVaEHMk7qd8rBr/iBAUKAFMyqwZZ4bzsRMuWNP6OrYOv
   dideXURdJIvk0zaTIcOcGNIXajp0W2O2ovDsCAO1RRaFszz24ptZllLOL
   n8/UduQ3ImyfRjUWOCptllm1yEnSKyOb9jRZYa5Zd/UZ3pXKEV8eBJ2iI
   ASQLGXi4um2JSPncX83SadECgvgANYdYBWkMuctCbEp8ltTHkP+BDKkAj
   3/OG9cEw+umGoom2Ih8jPMfdI0CCrRITqB9NWRvcIonvQMC+1tjLEzJ+K
   FudamjBewprHJHd6zd+cBaem9nYpEXu5+ZzVNkSMDnD0Qg/HAllhSfL/S
   g==;
X-CSE-ConnectionGUID: N5JIc2iOQxuEmJKwaGtQhg==
X-CSE-MsgGUID: YmQtqysBRle0SRhbc+pGiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36770852"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="36770852"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 08:58:47 -0700
X-CSE-ConnectionGUID: 1lGBBV6FQ7GEXu29OTZj6w==
X-CSE-MsgGUID: XX0nOE1FQkSOgIr237iEKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="56761669"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Jul 2024 08:58:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVvQy-000lDk-0p;
	Mon, 22 Jul 2024 15:58:44 +0000
Date: Mon, 22 Jul 2024 23:58:12 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: net/core/skbuff.o: warning: objtool: __skb_to_sgvec+0x1dc:
 unreachable instruction
Message-ID: <202407222319.y5uEZ4K6-lkp@intel.com>
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
commit: 0ca84aeaee150796d4b5577b1b0ae52a947e7813 LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE
date:   3 months ago
config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240722/202407222319.y5uEZ4K6-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240722/202407222319.y5uEZ4K6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407222319.y5uEZ4K6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/skbuff.o: warning: objtool: __skb_to_sgvec+0x1dc: unreachable instruction
   net/core/skbuff.o: warning: objtool: pskb_expand_head+0x68: unreachable instruction
   net/core/skbuff.o: warning: objtool: skb_segment+0x41c: unreachable instruction
   net/core/skbuff.o: warning: objtool: skb_shift+0x50: unreachable instruction


objdump-func vmlinux.o __skb_to_sgvec:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

