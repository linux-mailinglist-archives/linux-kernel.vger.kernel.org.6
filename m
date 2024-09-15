Return-Path: <linux-kernel+bounces-329680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4F9794A9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA3A283E47
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 05:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0430415E96;
	Sun, 15 Sep 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULzHZoV2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44917991
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726377037; cv=none; b=VN3tYOaRUGvVyGF3H/DX4MWXqzSRlX5vi3bujSn4K6IrVjhGkFqFj00KG7S2c4UIQU/ppz2bjuyLypaWnxbeCrHfS7e5qs1VMImGLnHn9Iidp8K6rEtrcffl80kOjj5piuRy8ap90sZZtw/N9TNUxj6SQALdkF/QUO7oxLSH5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726377037; c=relaxed/simple;
	bh=RxTGjSoI79wApBYWetHwYwhgLsl7qmp5bhB6TsW2XTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a+wChrwvZ+XS9hzTgmmZGIGgQ1wtrKk+nWjbPijcEhfsu8keMkbwoj/IBSSakHPyzpUndOnQU1VR5ZXRYqn2fzkRlLZw3rChwKQNGfc8iX9g90LCylLtvWF9BVXvW1+WD6LmthubUg7WLlEBE7pVO5VK5wClioFozbSKQnZcDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULzHZoV2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726377034; x=1757913034;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RxTGjSoI79wApBYWetHwYwhgLsl7qmp5bhB6TsW2XTA=;
  b=ULzHZoV2F8WjYCzYNL7VLsZGJie/Sbsdkou30OA2vcCltUpBt7z6ZOwJ
   ORD3w76/FqpNMOqOoiIFxVI6NIx8AdoJLeCpuJ0pVxZDNvUlEFAmSF6pf
   no8cki1WoHt5CpTwEeB16UnwcRveyegaaxavLb+3i8uKWAzS4IuaRx+2N
   SL5JQK9TjloQqbPZi4WDjE70pcCFjF+lkdSdPSIOrZU9ub44yroyUxNnj
   6wPckW6Rxu91F2Q8QZTzTeTEmT7hYv3FOqSiI0XkoEmsSzM3nkKFlXHPe
   p71OXW8oUkFUNEF4hjoBgpNg9TlgNXgY/stMJSwdITC54sIPyfbwSnLt5
   A==;
X-CSE-ConnectionGUID: PKwPNToMRyugp/tl6DdCaA==
X-CSE-MsgGUID: Wy+iVRdkQ22fGVNjqeSASg==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="24723336"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="24723336"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 22:10:34 -0700
X-CSE-ConnectionGUID: 3+zxR6tIQ7aK6vjPE+AvTA==
X-CSE-MsgGUID: s/iZ3OEoSKm0ua+k6wOP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="91815794"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 Sep 2024 22:10:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sphWo-0008QQ-2G;
	Sun, 15 Sep 2024 05:10:30 +0000
Date: Sun, 15 Sep 2024 13:10:20 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 run_tracer_selftest+0x2c0 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202409151344.pZ2wYwG1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0babf683783ddca06551537c6781e413cfe8d27b
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   1 year, 2 months ago
config: xtensa-randconfig-r024-20220805 (https://download.01.org/0day-ci/archive/20240915/202409151344.pZ2wYwG1-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409151344.pZ2wYwG1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409151344.pZ2wYwG1-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: run_tracer_selftest+0x2c0 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

