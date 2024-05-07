Return-Path: <linux-kernel+bounces-170532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C89B8BD8C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7464F1C229C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D015D1;
	Tue,  7 May 2024 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7kTnP5Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB819E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043495; cv=none; b=fNENJegOMDbtUpvvOcMDCU7fiCBy65KhX0Lt2qyAZaLPQz/znpJUh937OjAznFuo7tFBlJOTzGNm4X/Cxqc4k7cBESlexgbXDuhvav1Mj+ZUkAdKgTMJD2GfiR2I+anxPvMPXxraO9LnN16EpSYe55Zegv8U/wEoc7T6Fyd7FcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043495; c=relaxed/simple;
	bh=QTFtQNbhtacToL6snMVw7wu2mOBQygAGbhUKWUY4/1E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ApmBv4zj687MKQ03/QlioMz6u3i5IhFmMLzjXiBHlNq+7tckkCWIBwYmYbblH/fupYUKK4h5Fe2b/G7CtBRWVij7G9cTZ1wbFVQXZYdPJatqHY9TjcY6ZgyRhuZtDQ23cIjcV2mhLytW0/v79Iy/1PvE2MED+NZZCVk8OmO7ajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7kTnP5Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715043493; x=1746579493;
  h=date:from:to:cc:subject:message-id;
  bh=QTFtQNbhtacToL6snMVw7wu2mOBQygAGbhUKWUY4/1E=;
  b=n7kTnP5Q/SsYMhb80hu8cmApvHvq/MhQDtJ7mzdxHAnmtE2ouwkdclkC
   KwCD3MEZzqn3Lf0ldIojpViuvrNIsk3KWNWeQflVs6Vis9sG2luQLWA3A
   rCQCoP7yCBOF7NtxSH6rGS8FeTeqfY1Fpb5zK9k5qOn4bioFqzQ3ZY5mA
   MCiEjOpRYtGh9kCvO6L7beryEb7RLbT8cd5evyVt+7mymE+HisflSh40t
   kTKL90wnMAOqhpq7tLSooPXLivTbCu60xm6QJWJUDQTt6kHouxSqY+y3a
   wy2fkl1H4AosZ7leaSYFuxIqOn+7yvew/LUGcnLS1f3opzVS5u93x7pUS
   w==;
X-CSE-ConnectionGUID: Pl3+ATKCReKgk9pIncwqWA==
X-CSE-MsgGUID: EdwlxhNkTja9QRoTUMrMog==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13766583"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="13766583"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 17:58:12 -0700
X-CSE-ConnectionGUID: kzyl2TwdQRmAwW2ZPxalRg==
X-CSE-MsgGUID: ZIQYHek9RtW1ioZyIwlgqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28735815"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 06 May 2024 17:58:11 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s499k-0001B9-38;
	Tue, 07 May 2024 00:58:08 +0000
Date: Tue, 07 May 2024 08:57:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 8dc8b02d707ee4167fffaf3a97003bcdac282876
Message-ID: <202405070821.YQpO24dg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 8dc8b02d707ee4167fffaf3a97003bcdac282876  x86/alternatives: Remove alternative_input_2()

elapsed time: 728m

configs tested: 50
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240507   clang
i386         buildonly-randconfig-002-20240507   clang
i386         buildonly-randconfig-003-20240507   clang
i386         buildonly-randconfig-004-20240507   gcc  
i386         buildonly-randconfig-005-20240507   gcc  
i386         buildonly-randconfig-006-20240507   clang
i386                                defconfig   clang
i386                  randconfig-001-20240507   clang
i386                  randconfig-002-20240507   gcc  
i386                  randconfig-003-20240507   clang
i386                  randconfig-004-20240507   clang
i386                  randconfig-005-20240507   clang
i386                  randconfig-006-20240507   clang
i386                  randconfig-011-20240507   gcc  
i386                  randconfig-012-20240507   clang
i386                  randconfig-013-20240507   clang
i386                  randconfig-014-20240507   gcc  
i386                  randconfig-015-20240507   gcc  
i386                  randconfig-016-20240507   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240507   clang
x86_64       buildonly-randconfig-002-20240507   clang
x86_64       buildonly-randconfig-003-20240507   clang
x86_64       buildonly-randconfig-004-20240507   clang
x86_64       buildonly-randconfig-005-20240507   clang
x86_64       buildonly-randconfig-006-20240507   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240507   gcc  
x86_64                randconfig-002-20240507   clang
x86_64                randconfig-003-20240507   clang
x86_64                randconfig-004-20240507   gcc  
x86_64                randconfig-005-20240507   gcc  
x86_64                randconfig-006-20240507   gcc  
x86_64                randconfig-011-20240507   gcc  
x86_64                randconfig-012-20240507   clang
x86_64                randconfig-013-20240507   clang
x86_64                randconfig-014-20240507   clang
x86_64                randconfig-015-20240507   clang
x86_64                randconfig-016-20240507   clang
x86_64                randconfig-071-20240507   gcc  
x86_64                randconfig-072-20240507   gcc  
x86_64                randconfig-073-20240507   clang
x86_64                randconfig-074-20240507   clang
x86_64                randconfig-075-20240507   clang
x86_64                randconfig-076-20240507   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

