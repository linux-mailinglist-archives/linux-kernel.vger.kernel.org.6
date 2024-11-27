Return-Path: <linux-kernel+bounces-423743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83BE9DAC13
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762B2169661
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F7201014;
	Wed, 27 Nov 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrrQMwYp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679C1FF7A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726374; cv=none; b=fUNCmXoYU8Hf4JJpfu5qppoH8jgCUhp71D+ajtKYkN586/7TP8jHE8lDfLHx6QVAKoW9QUaKnHsVFBK+kn4lq/znxa0YxhI2dqUn9EqeovgWrxOYsxtArPIFNYTqbiTwRz/5chhhVx2HmOQej3ukXrlUlRIILv3BgG7pNhXBdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726374; c=relaxed/simple;
	bh=pQFFJkVDgwGGcNT3jNePQjm/pQxkmLBBuFzPz74TwaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FYzw/HWlumrC/eYdOIZIbUQyDDv0ySglT829SEjCLRy3SkPioXxZf7SwRZA0jfpQ6VnzU/7o87XmhE4z/ibfi/QAeoxsrTvnFA+cSpnWKR4pILozqbZyS7ukZ0xkDz2SHwFoD3hE1re59xjbmVpecwXXC18t1694Daxsz0JQVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrrQMwYp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732726373; x=1764262373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pQFFJkVDgwGGcNT3jNePQjm/pQxkmLBBuFzPz74TwaQ=;
  b=OrrQMwYp4nf8qSVxoC+W8HkZ5peu3ExCL9gH6AG/1lKf4ykKN00ho9la
   yYogMjet+PrrGQ55X0X3amCdD9qIsISCOt4SvRTgIlLGl6/QXU97IOn08
   DapWQuSLwqF0NQzudUWt5Q5oPwNvNPLXZDuW93Z8D3hZjqWQkTXEc5rCL
   c1iPcsOGQiBAzAtVcvm1dFVM4Rbg6pqhAd9B6tysb9nKyUHs7BKsjvT45
   HICGfBGJiSZsVj5EBPLM12XC+wC0bFD2i/OmbGcQ4o3WMaYLTD/FO+1MQ
   c2IPNR+kBHluFxVUc73Lqi5LFwMg9b+V77uph2ueQ4+rxqTyTciqEJyVB
   g==;
X-CSE-ConnectionGUID: cb79NLbIQP+ICQlE8OPy4A==
X-CSE-MsgGUID: xtKcAJ39TpCvjzyth8ImbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="44319678"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="44319678"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:52:51 -0800
X-CSE-ConnectionGUID: Vw/1rTUZSwuiQ8dZJqr4jg==
X-CSE-MsgGUID: 2y2bsZxOSkiXBzzqNQcsSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="96750875"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Nov 2024 08:52:49 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGLHT-0008Aq-1B;
	Wed, 27 Nov 2024 16:52:47 +0000
Date: Thu, 28 Nov 2024 00:52:31 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Dalmas <marcelo.dalmas@ge.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/urgent 1/1] ld.lld: error: undefined symbol: __divdi3
Message-ID: <202411280005.IVzoUqkP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
head:   299130166e70124956c865a66a3669a61db1c212
commit: 299130166e70124956c865a66a3669a61db1c212 [1/1] ntp: Remove invalid cast in time offset math
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20241128/202411280005.IVzoUqkP-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411280005.IVzoUqkP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411280005.IVzoUqkP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __divdi3
   >>> referenced by ntp.c
   >>>               kernel/time/ntp.o:(__do_adjtimex) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

