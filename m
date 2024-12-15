Return-Path: <linux-kernel+bounces-446519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD09F2561
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF2C163160
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52F81B6D1A;
	Sun, 15 Dec 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vg8kuNPY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D73149C41
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287590; cv=none; b=lWofhF3+XknQBc9VYKdCAiA6wYzxIPBLF6F1zEXm6pR+BvqfhsnC3hRausFfKe1IVOXJl+68Qwp9LcfzcwdUhR4ttbH8XxzfuDuJwiXiy5v6mTSy8UOtKKOw1nm6HUL1ozJZaNjoBaxTHdzdoGk8WPWw6oQty9nDEhExATBUJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287590; c=relaxed/simple;
	bh=1Hhy0/7UNLtorFJ9rRGiZm6kK2W5J/5XCMh5yUBA1Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d4EfD7E+NN3+CM1thwlEJFO9L1je/dvZhH/GRdmDfJIp/V+H4Hk9rv0wo5wv59CqIu/z0MNkjEdCX7ZamrPFZ62geuTso4Ql74Wjs2ThQ8ex3LHf114PptrHfqPbZj8gUejnLvj9Fj7E/WlTHB9WKVUjqaFcc6xkfxqKgd/M1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vg8kuNPY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734287589; x=1765823589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Hhy0/7UNLtorFJ9rRGiZm6kK2W5J/5XCMh5yUBA1Yk=;
  b=Vg8kuNPYxRkzxVTqSxYHCBSc2aHjgQlcXg1LlnyIp2Qb+eDY43Tgh/FA
   4S3RetG4/VU1/QslsDegNf6XzsGrE0YlFl5GYE+bTu2VfXM7rm9orlLsb
   bAWcxt77zT/DrXuk9MBGZWS6n1LE0OlqM0BI/pkLC+973suCbILlrKE37
   WWnIEckqn7AKqcbjSgpeBen69uXTvc27kwnSIWYEifzTvhiK2vJoANzQl
   wx/s8GDZvSCjIitYC2iUt/ieEHMWztumgmQzAsQyFPSUf2Auvhe7MDaIP
   PU7n5mW2BLQKZ1AEdszT2XzLeMtLhdIwshUMIGk3E0lXmT6ofQuCjLF0F
   w==;
X-CSE-ConnectionGUID: Hw/Pv2uzRKaRqKTuTUvFXg==
X-CSE-MsgGUID: PjBF/yewSqKxmBvhewFXfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="52194848"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="52194848"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 10:33:08 -0800
X-CSE-ConnectionGUID: DYDVhTQOT/iwtrnxU/kSjg==
X-CSE-MsgGUID: MUUzkugbS1KRwXR4jOKEyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97430076"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Dec 2024 10:33:07 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMtQO-000Dn3-11;
	Sun, 15 Dec 2024 18:33:04 +0000
Date: Mon, 16 Dec 2024 02:32:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: make[2]: *** No rule to make target 'install'.
Message-ID: <202412160224.YwRnvCXq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d8308bf5b67dff50262d8a9260a50113b3628c6
commit: e719b4d156749f02eafed31a3c515f2aa9dcc72a block: Provide bdev_open_* functions
date:   1 year, 2 months ago
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20241216/202412160224.YwRnvCXq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412160224.YwRnvCXq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412160224.YwRnvCXq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[2]: *** No rule to make target 'install'.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'install' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'install' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

