Return-Path: <linux-kernel+bounces-417834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363E9D598F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAA5282E38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1B169AC5;
	Fri, 22 Nov 2024 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoB8/D+X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647215C15B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258139; cv=none; b=UWBs3SZ3q9+HU+1tJsWgq9eqdvz8Q1Q4k+itymwuAAAC9O4Y7CF3jxEI0Pt2ckaKt6a/Sw4Cym7FWuncnPSMhxMP8zfBCc4LUscG8NlC1TtsEWCHxqm1oGiCVwvsBuTaaE0nF4xSb+rqJ/GnxwjZNpdXAfpdL593946iCW1UrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258139; c=relaxed/simple;
	bh=89Di9Sey2SHirHpJ+GaQdHp4fXEtd7WedDuiTYA3D0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H7G3uNdocLAsn91xsonV3fuRXV9HR/aVNYgvAr8bPS/JH2hRpymSQs6qnJGL+eEkmcs77CUk0POqDlUtGoDyxG29ou8gmTWG+28weAZz7HI4VViOENbPOBFxHzM8uO2uYPyYEi5QDg3UpZDJj5bdGQcl1tARD2YHyB9ULxcaqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoB8/D+X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732258137; x=1763794137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=89Di9Sey2SHirHpJ+GaQdHp4fXEtd7WedDuiTYA3D0Y=;
  b=IoB8/D+XpxwH3FOe+DZEYmphSyL3cVksFHvyV04AvWY/yhCwLTY4O908
   Gmcm+5Zu/vJIcwtKz+oYFYsr1XvAOtfoUSBjP5dxXWDAcW4jp5rwdI/3C
   AgMzni40gkDgbJizVgFhIMh6V+yVy8T01wgn0guBFrQCz1ArXz66vURSS
   ApErDaGm6TCApzlx/du5B9kL02qad6uDGAQgn7/a6fgMUChcpA2RZvEDf
   X/cPuKPbmhmx92GrLA5JS6TJYT1qLCdB9+Toy4iq1cJvYA+mJPBU7vBl+
   TEDxNexsfvLqL/lMoDwr4xc2dVWRnAGzaXEbhlx2pCBYSNmEvU9wY40MV
   w==;
X-CSE-ConnectionGUID: fvUDZN0wRTqnNGg36J472g==
X-CSE-MsgGUID: MUXcydCpSOeAuexOQSnSiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32553938"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32553938"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 22:48:56 -0800
X-CSE-ConnectionGUID: VNyO1RxLRyGe+d9Y9kZSsw==
X-CSE-MsgGUID: YERNkshaSJaUbvmaLJ5f+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90904838"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2024 22:48:55 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tENTI-0003jr-1j;
	Fri, 22 Nov 2024 06:48:52 +0000
Date: Fri, 22 Nov 2024 14:48:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/register.c:553:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202411221430.WcrSO1Mv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   28eb75e178d389d325f1666e422bc13bbbb9804c
commit: c43203154d8ac579537aa0c7802b77d463b1f53a io_uring/register: move io_uring_register(2) related code to register.c
date:   11 months ago
config: s390-randconfig-r133-20241121 (https://download.01.org/0day-ci/archive/20241122/202411221430.WcrSO1Mv-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241122/202411221430.WcrSO1Mv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411221430.WcrSO1Mv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   io_uring/register.c: note: in included file:
   include/linux/io_uring_types.h:341:48: sparse: sparse: array of flexible structures
   io_uring/register.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
>> io_uring/register.c:553:1: sparse: sparse: Using plain integer as NULL pointer
>> io_uring/register.c:553:1: sparse: sparse: Using plain integer as NULL pointer

vim +553 io_uring/register.c

   552	
 > 553	SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

