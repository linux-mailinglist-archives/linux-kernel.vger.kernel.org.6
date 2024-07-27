Return-Path: <linux-kernel+bounces-264303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC693E176
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 01:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D963FB21516
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80279952;
	Sat, 27 Jul 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEGwSf0K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3C374D1
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722124608; cv=none; b=MljR3jflvUKGhPIgytW3R1RSzYp8QpugctkeI7kjJxzzUAF7jF+PE5jie003626IGk+XX3hWCl+Ni0QrLK6kJ3dBNqrmWHe3fWDshEhbB/Zs1J2ZDn1QSW2m/9SMEhqQPCrxdzK2nqidKVbUs8xHDDEXqlT2ovezqA5J1M4/Y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722124608; c=relaxed/simple;
	bh=JtCwE4XCHEFt1ylEL6cxOUJbYcIdIEy1l0hElg5I3yA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tp3vOF6JN8ceVUInmnQkZ8LXn9tzFfYVpXk03vFnJjv67N4sr9W17IiAYz04NlutzB/UZ/4HBFySRSKW9HizbCd/oFMCBfz99e6MqYUtH0hdF2LJFCR2Ag3ZFIKWM0PN0BXv7Td8rpIqSsGLoWRmvBtxkluPBCvEtqKxkcZbrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEGwSf0K; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722124607; x=1753660607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JtCwE4XCHEFt1ylEL6cxOUJbYcIdIEy1l0hElg5I3yA=;
  b=AEGwSf0KsIjqS79HnQlGw90dD3LpNJCZmjktCAtY1/tjGOBBRutxcQB4
   mQgwv9AMFeSvv+hQaRXZQV2/6z7zund4gRU3qmHTw77sNIHeoTPG0m5+m
   po2A6UFOgicgBDS2oapWAfggyqn/gT9B4ei2Z7mO7HQh6I/PmUawHGs0K
   qDRe9LD3ow4K4eA70qqFashpxxP51l2LcjBQ3A1j4FB+Akx18z31tahYX
   yx/VViONEVATRoREWbWo87VON2mS/D/OyRnLPVbJBY5H4xahLBlZmM7Xw
   8U8rExqZFVQD9UMF/G2c4pMuwBWpHkWOmiyYgzski7R32tP3hHy5VFnGK
   g==;
X-CSE-ConnectionGUID: UiCF2rlpSjaP2QmMDxqDEg==
X-CSE-MsgGUID: 2HA4tWEWQ2ymcTDPwyG3dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="12748059"
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="12748059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 16:56:46 -0700
X-CSE-ConnectionGUID: 9WE3M3I+S5ye17l7VKEVgQ==
X-CSE-MsgGUID: rSSvb5/ZSOCc3o1j1o0ZBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="58382888"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Jul 2024 16:56:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXrHF-000qLQ-2H;
	Sat, 27 Jul 2024 23:56:41 +0000
Date: Sun, 28 Jul 2024 07:56:10 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Sa <nuno.sa@analog.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw+0xa3: can't find jump dest instruction at
 .text.adis16400_write_raw+0x222
Message-ID: <202407280732.8oRaogGU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   910bfc26d16d07df5a2bfcbc63f0aa9d1397e2ef
commit: 9d9dae6ae8ab440835981b209ebe6ba8465b46a4 iio: imu: adis16400: make use of the new lock helpers
date:   5 weeks ago
config: x86_64-randconfig-122-20240728 (https://download.01.org/0day-ci/archive/20240728/202407280732.8oRaogGU-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407280732.8oRaogGU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407280732.8oRaogGU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw+0xa3: can't find jump dest instruction at .text.adis16400_write_raw+0x222

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

