Return-Path: <linux-kernel+bounces-289094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4732F95420A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC141C245DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123712D744;
	Fri, 16 Aug 2024 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIL/BL1U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753812DD90
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790873; cv=none; b=OFmkvJLhVLfYVVghlQu4w5MczVV/p9BOKw3n/cLFZebBJfDNdIFpSNKQkXeu35k+r0VjRq6ElfbGCnb77m1IsotA1aMshk65NZIjphHjoZHkixZanSAzcWqkLMdXZzheHEb9uvIv7ElVbg+jDQALpsmicfZHvLYx6N5Cb8nLJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790873; c=relaxed/simple;
	bh=hSxmOP0ybrbjuaLqUnecScg7nLy0PWDySBWg/BmX878=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RmVA8WcYUrqPiXqJyUvwW2hqjyQsLw9/A/B4bv93mwmT+5PItaNHzCPmIYN9bfifwp/sVS4m1KZzA4kRgkaCQfvnrfh02j3tHuPgLnYk6dcunoCbE9kPghSv00WFve08tzKVPKnYAUCzcgHWhmG03jNqQh0tNmSXK6d1PWvNzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIL/BL1U; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790872; x=1755326872;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hSxmOP0ybrbjuaLqUnecScg7nLy0PWDySBWg/BmX878=;
  b=YIL/BL1UneOHuQO3yNDd4OBM0/h4SRX5RDZ25f/6+7UIRn4LNcCJTgu0
   Iz8vmKZbYqPP6eg3kruMlqMnoZZBHjZ1jdXqRrNPBsaZw/3XngvbzpRqA
   wwaO3mJj9rE++CXESQxvFUjLpjDpci4L458tll7q9+7yw5KTpsES9KMF0
   hJhE/+cSv8eT3hdvaPrBDh0uBoDHQp980sqo8na3cRI3rmZLdgG2O87vC
   9qLNpymAwvOSu6DzO7C6mtm+SFcKo6TW5qblPKqvlYR6DT5px8T8owinI
   FtKSee+3RiRRq/uea9+yC/8a/TBSaz+zNCHoCYzQInaueGf0gXJ3eR8kq
   w==;
X-CSE-ConnectionGUID: N/ZkKPzuRjKkuY5Va0nXTg==
X-CSE-MsgGUID: /OH8E4CkSyGi75DXmPUVuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32752319"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32752319"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:47:49 -0700
X-CSE-ConnectionGUID: PFEwBKYURh2WMGZGH/9iNA==
X-CSE-MsgGUID: xrKMzg3mRFOC8hw6msqNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="82790721"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Aug 2024 23:47:48 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seqkU-000658-0R;
	Fri, 16 Aug 2024 06:47:46 +0000
Date: Fri, 16 Aug 2024 14:47:08 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: intel_panel.c:undefined reference to `backlight_device_register'
Message-ID: <202408161408.9pyW8nFp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d7a5aa4b3c007fae50405ca75c40258d90300e96
commit: 8c5dc8d9f19c7992b5ed557b865127a80149041b video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
date:   5 years ago
config: x86_64-buildonly-randconfig-002-20240816 (https://download.01.org/0day-ci/archive/20240816/202408161408.9pyW8nFp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408161408.9pyW8nFp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408161408.9pyW8nFp-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: warning: arch/x86/lib/csum-copy_64.o: missing .note.GNU-stack section implies executable stack
   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   ld: warning: arch/x86/lib/csum-copy_64.o: missing .note.GNU-stack section implies executable stack
   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   ld: drivers/gpu/drm/i915/intel_panel.o: in function `intel_backlight_device_register':
>> intel_panel.c:(.text+0x4e08): undefined reference to `backlight_device_register'
   ld: drivers/gpu/drm/i915/intel_panel.o: in function `intel_backlight_device_unregister':
>> intel_panel.c:(.text+0x4ea6): undefined reference to `backlight_device_unregister'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

