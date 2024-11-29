Return-Path: <linux-kernel+bounces-425855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB39DEBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755C7163A65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B731A00D1;
	Fri, 29 Nov 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4sw/K2m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595D19F12D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903119; cv=none; b=I4vSB/36MD5fuKwuGUn5V6wqklJRTgwlmfSxap+jkvtxU3Z8GWNEaun40/Ru4S9Xop3pzxRxClcuiznWDXnRk1zFzQ8xOePsDUuTJar8JcxG7ekOWjwY7mSyAx3ORWwTxbgH2ZmqKvjUmcnq9oa4G3AWAvP1XGSN5h6d+AqEnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903119; c=relaxed/simple;
	bh=21KVD8snpmLEr7oUug2mlyUU2G2RKe6VeqYCLDjDeVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o5lQDyh7mICQWnWjy8H/ymxcnHd2kNS9HBFMXsQsuGvDqIdp2/2WmV5Vkq9Ew6M1/gwvKss39bMpvIORp6TKRBhLvQW2fVZqGeJp1SrvUThT+JFDptg4/SX9hfsJP+ldqdIindrGc24b5BU/asZ9Z0Bw7zk0/nBwVXImS9W8frA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4sw/K2m; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732903117; x=1764439117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=21KVD8snpmLEr7oUug2mlyUU2G2RKe6VeqYCLDjDeVc=;
  b=f4sw/K2mumjo7RgTHlxmgvTFf1DslcXIBBWGOsak8PoBQcmE1tENUeO2
   49520z39Mu9Jxd7fGyEfbCrTxxLJ2DpzsTmCB0+lGHaaa8TabpY2pQs8H
   cyqpst9H9TJf60Dc9sBg+08P4G/mL5mAgMmcPTnAyYUhH82VSTiI9Xpd3
   MWk41892cYzzkxsXRcGRSiHYRfT0xLYqpSHXt7exubHCAMSFhBFebMlHL
   mq6wBM178MPPDoORAo9js1hwCzExO8VBM2T34ym/33d/tyU4r+IbhCETE
   m/cUGuMDjPwTskgEZngvbgHtwdu/iX3MZ3Qw8E9ro6i67GFG2iHEBkuK6
   A==;
X-CSE-ConnectionGUID: Of7jp3HIQCGw15X37ZpoJw==
X-CSE-MsgGUID: VAl6cM0rRfGPKtd8sptTGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="33295665"
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="33295665"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 09:58:37 -0800
X-CSE-ConnectionGUID: oq4UiPPLTKKb9C2dFoQ6Iw==
X-CSE-MsgGUID: RPCx0Eb7QHq1L71cSIGmDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="130023156"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Nov 2024 09:58:36 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tH5GD-0000af-1A;
	Fri, 29 Nov 2024 17:58:33 +0000
Date: Sat, 30 Nov 2024 01:58:22 +0800
From: kernel test robot <lkp@intel.com>
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: WARNING: modpost: "csum_partial" [lib/checksum_kunit.ko] has no CRC!
Message-ID: <202411300125.3BbspdP4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Noah,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7af08b57bcb9ebf78675c50069c54125c0a8b795
commit: 688eb8191b475db5acfd48634600b04fd3dda9ad x86/csum: Improve performance of `csum_partial`
date:   1 year, 6 months ago
config: um-randconfig-r133-20241119 (https://download.01.org/0day-ci/archive/20241130/202411300125.3BbspdP4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411300125.3BbspdP4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411300125.3BbspdP4-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
Is "cmpxchg8b_emu" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol will not be versioned.
Is "csum_partial" prototyped in <asm/asm-prototypes.h>?
>> WARNING: modpost: "csum_partial" [lib/checksum_kunit.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

