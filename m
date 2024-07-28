Return-Path: <linux-kernel+bounces-264553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E0F93E507
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBFF1C20B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AD3EA66;
	Sun, 28 Jul 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVch8LFk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071852C697
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722168908; cv=none; b=TYfSmgZY7p737fkD3ZOC2pJyNQp+RSwv/413HAAdR4GH6uvlogvnEsSfc+p4Y8zBRwdRD0af3nKLAmBrys1D4QIip/r3BTb9I3bvFIBJqKOm7gtn2P2UWDT6bNxqpvwkyiwJDeroSOQzkJUgv7JXOjGD7O5EYdom/CZpP4njbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722168908; c=relaxed/simple;
	bh=HBzHjvY4/VRudC40Tg50oXwv9sOM2VV0cn9BnLSTdU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C9ZkIJ5IvC9NqwOMox589jzrSR7TurGfzeOaPnV6pvjxOOckYvxJKW+GRdBnbkEIfq+qTPCNOeCTCjYVUcJGovTvzhoCFfAebNetN2aPwsFGTKzjH7MQbefI1tZZdU+UkXsQPCLsNRQZoU/MbDORqQwGAqk8+y04eOxWdT2u6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVch8LFk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722168908; x=1753704908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HBzHjvY4/VRudC40Tg50oXwv9sOM2VV0cn9BnLSTdU4=;
  b=cVch8LFksOjmSmKVrmpn99VZ535tRwkRHDnukR1dNai8oeIPvIDsMsvH
   NMkY0kib1exh4ypVOBp3djzS//ruavtNJS94ppGFDoGQC9zyF3oqfR9rM
   BpcH8Od3/02RVvDp7m5UeDdkB5m0zJB/svdiR/WRmJh0JWJ2DETAR8Sih
   Qxt9DILNpIHi1GuDtgVfuMU15wpjWM6l9eaKZBqsG/GFuOVI5O5xK64Or
   eB88Xi2O1SqHurQsv8euR7514YpW8Zh8n95tgsB2Ob0BtW+/9zqorCGrX
   jvmNq65D5jCTv1CVpQ1mu/SuAmqzuAMdnPg0/qSl2+MiNqaGYCFTjluZc
   w==;
X-CSE-ConnectionGUID: UX5Yog+2QlCWNDGaLMl2vQ==
X-CSE-MsgGUID: QXVjSejlSjKfgZonxUHu1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19710825"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="19710825"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 05:15:07 -0700
X-CSE-ConnectionGUID: +hz3KL74SJa4QuDBde+6Ig==
X-CSE-MsgGUID: dvW2YUXZQ8WbFXJaWUecXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="91169513"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Jul 2024 05:15:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sY2nl-000qms-0r;
	Sun, 28 Jul 2024 12:15:01 +0000
Date: Sun, 28 Jul 2024 20:14:54 +0800
From: kernel test robot <lkp@intel.com>
To: Patricia Alfonso <trishalfonso@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	David Gow <davidgow@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works
 in KASAN generic outline mode!
Message-ID: <202407282018.8DTWnGmy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Patricia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5437f30d3458ad36e83ab96088d490ebfee844d8
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 UML: add support for KASAN under x86_64
date:   2 years ago
config: um-randconfig-001-20240728 (https://download.01.org/0day-ci/archive/20240728/202407282018.8DTWnGmy-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407282018.8DTWnGmy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407282018.8DTWnGmy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/kasan/report_generic.c:30:
>> mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
     485 | #error kasan_arch_is_ready only works in KASAN generic outline mode!
         |  ^~~~~


vim +485 mm/kasan/kasan.h

e2db1a9aa38149 Andrey Konovalov 2021-02-25  481  
af3751f3c2b628 Daniel Axtens    2021-06-28  482  #ifndef kasan_arch_is_ready
af3751f3c2b628 Daniel Axtens    2021-06-28  483  static inline bool kasan_arch_is_ready(void)	{ return true; }
af3751f3c2b628 Daniel Axtens    2021-06-28  484  #elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
af3751f3c2b628 Daniel Axtens    2021-06-28 @485  #error kasan_arch_is_ready only works in KASAN generic outline mode!
af3751f3c2b628 Daniel Axtens    2021-06-28  486  #endif
af3751f3c2b628 Daniel Axtens    2021-06-28  487  

:::::: The code at line 485 was first introduced by commit
:::::: af3751f3c2b6282bebcb56c35bbe4c8b671f80aa kasan: allow architectures to provide an outline readiness check

:::::: TO: Daniel Axtens <dja@axtens.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

