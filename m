Return-Path: <linux-kernel+bounces-370730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29199A315B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F871F22AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5E200B87;
	Thu, 17 Oct 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mceWJUx5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E916200B86
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207678; cv=none; b=oobkENbmCuCCnlSK/Om+NBUmU4FQpziWSVjQC3wb6yJeN8yBWSFzTDYxXFOU0PpdSeIWbJ+Zb38QFLxJupZ5w7QDW3wcsw9Sucjscrd1a+DiMkuHZKlMNe+SOermLkgJdcR5+eCacS7wAltaPHt/k3PCECRH/xi4ZOorLFWMcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207678; c=relaxed/simple;
	bh=8wybGY0ydF9v2ZwakRGZBI+jXb6WuS4RpdWx3qtCY9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iRJCGLx6/etRgwOA98xvbad0HjtC4SrhDn3sszhxG6MSBg0Fqd42HeucScyDeHLfK7/mLoZQAj0ygBl/RhZShS3/J8Ng0otZKfXf3lPt5AnWqZSdiMuwj91EyTyLIiafhe1Hs/J0e+yjmxlw7h9CDeb2wKk9Fs2sXPcUk7MAj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mceWJUx5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729207676; x=1760743676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8wybGY0ydF9v2ZwakRGZBI+jXb6WuS4RpdWx3qtCY9A=;
  b=mceWJUx5RkS/Y2/5MLdSZw1oVcPQn2d5yQFjam1volC7OpB6qs/Kb2yL
   62iTCT9xm6h+3HAS8RzYWJ8j/YL3BHFQgMYd+jVhFm0v2UUGXJjfJlycI
   2Qt1VAWWgmnKfZNN4omI5Co7dnNQFe65dbMoWyc8gPh1hM1iDGSKN34MS
   fGfGOjapn8J2KifFllv+kY7qhrxIDrC4+L5kaKQDndVmvroKkdMJScDPA
   Vy0NWQrNqaFS0Ma2+q0ZygZzdNi2MG2ix0pYB4kDmA48rYyGDOTKV8qmp
   ffc0l2UgV3+IqNR7Q1+FW+9uZko4elAXua+TNyVBSn7yk1DuJarzrFak7
   w==;
X-CSE-ConnectionGUID: RlfofI2iS72ENM2zX4vtXg==
X-CSE-MsgGUID: 6rpBU/2FRk+MEl7XaCXW1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28606581"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28606581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 16:27:55 -0700
X-CSE-ConnectionGUID: 2zFf06XPTqiI3W485Yfefw==
X-CSE-MsgGUID: xsBMhgbMRDWtQ9GUo8Lydw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="102007434"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Oct 2024 16:27:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1ZuJ-000N2B-1G;
	Thu, 17 Oct 2024 23:27:51 +0000
Date: Fri, 18 Oct 2024 07:27:23 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/btree_cache.o: warning: objtool:
 btree_node_lock.isra.0+0x90: stack state mismatch: reg1[22]=-1+0
 reg2[22]=-2-16
Message-ID: <202410180702.84IG5drg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6efbea77b390604a7be7364583e19cd2d6a1291b
commit: f1625637b85191a0ac6f9ebf2b30d8b335f08547 bcachefs: Assert that we don't lock nodes when !trans->locked
date:   5 weeks ago
config: loongarch-randconfig-001-20241018 (https://download.01.org/0day-ci/archive/20241018/202410180702.84IG5drg-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410180702.84IG5drg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410180702.84IG5drg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/bcachefs/btree_cache.o: warning: objtool: btree_node_lock.isra.0+0x90: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

