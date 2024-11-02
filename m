Return-Path: <linux-kernel+bounces-393398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13B9BA008
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7DC281F72
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2D15F40B;
	Sat,  2 Nov 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbFmeXq6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EC23CB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730550698; cv=none; b=kHtJLeGCMwsvnYy/COaBCDdnoP8+GNJewDBBQLY1UTRcXHpCGl90QNon1q881O/Tzf5jvS+8Ct5f678nXWN1XfapnX177HNMIfTpE0wMmYan8CbEPw6e7s+s1m3nBXO8kfw+R9D6pB1eToAXrP3wwPFo9A5OUDvZSYKLxp//uNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730550698; c=relaxed/simple;
	bh=dVpcPBKNGX0yV94AtQWidWWeiChoMQCS1m5u39kkE0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=abzmxaCgHju0U8yfScK7nEgnamAEaQu5lzA9qRx8M2NUAUNACGH5e0m7oZl30KxCk9b6Qa7QxDeZNbdFRKbVahZcEcMLNFA4QvrTNS9r1DWHiGKYu7QdrvH/mlOrTpd4CT8xPk2EbpSoW9rlb27GUH4WllSKpI9zwpYPMZFh5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbFmeXq6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730550697; x=1762086697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dVpcPBKNGX0yV94AtQWidWWeiChoMQCS1m5u39kkE0c=;
  b=ZbFmeXq6QmEDgESzwCWi5z2GSoY7RItZzmc48mZE5HUMkcWqS2wv1HRO
   D5wtqv6Z1FdAyjD6SU7h/lSCHZoYuMRgrf9PYWy3C4wmjwZY8+CwQzOp3
   n3t/TntUwGu6vpXYPar4ukl6s3liU2TXbq2pBbHX0xM/DnTuI2G3ymiqt
   62VqXe1/6ON9w2Z5k409rIUNJ5Yi7NXTBLfDjlpRoFl4GexcmS29YEECD
   BT3miBJj2rcLKi5tI8DRdGgFCiTvD+UivDU6BmK/AEJ/yXRlWDLITIlmq
   qrIi35xqfq2vPLwUjMqbrdcgzWZ+zUdnA67prEizFHs1ns4AFZZD1dkal
   Q==;
X-CSE-ConnectionGUID: KX/uNhPSQL6Z6c2dcBoajA==
X-CSE-MsgGUID: QGnBiqdqS5KvNzoKrDlkKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="33147328"
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="33147328"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 05:31:36 -0700
X-CSE-ConnectionGUID: IjcibsqVRi+hYvFJYhHMgA==
X-CSE-MsgGUID: 4XVHCJ3yRQWkGg1DYGcQBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="87727302"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 02 Nov 2024 05:31:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7DHx-000iv3-06;
	Sat, 02 Nov 2024 12:31:33 +0000
Date: Sat, 2 Nov 2024 20:30:42 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/vdso 33/41] arch/x86/include/asm/vdso/vsyscall.h:16:10:
 fatal error: asm/vvar.h: No such file or directory
Message-ID: <202411022036.pBj9Jefz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
head:   3bf96deae5ad9664bdf2db95599e52221f9ddc33
commit: 915c1d9df1f757b0979283b6e50da9b3ccc4d826 [33/41] x86/vdso: Split virtual clock pages into dedicated mapping
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241102/202411022036.pBj9Jefz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411022036.pBj9Jefz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411022036.pBj9Jefz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vma.c:27:
>> arch/x86/include/asm/vdso/vsyscall.h:16:10: fatal error: asm/vvar.h: No such file or directory
      16 | #include <asm/vvar.h>
         |          ^~~~~~~~~~~~
   compilation terminated.


vim +16 arch/x86/include/asm/vdso/vsyscall.h

7ac8707479886c Vincenzo Frascino 2019-06-21  13  
7ac8707479886c Vincenzo Frascino 2019-06-21  14  #include <vdso/datapage.h>
7ac8707479886c Vincenzo Frascino 2019-06-21  15  #include <asm/vgtod.h>
7ac8707479886c Vincenzo Frascino 2019-06-21 @16  #include <asm/vvar.h>
7ac8707479886c Vincenzo Frascino 2019-06-21  17  

:::::: The code at line 16 was first introduced by commit
:::::: 7ac8707479886c75f353bfb6a8273f423cfccb23 x86/vdso: Switch to generic vDSO implementation

:::::: TO: Vincenzo Frascino <vincenzo.frascino@arm.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

