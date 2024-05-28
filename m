Return-Path: <linux-kernel+bounces-192885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3788D2383
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C281C23220
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC7174ECA;
	Tue, 28 May 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7C/Ho1U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C32E84A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922139; cv=none; b=CXXwCt+YQ+yn1vI7LRtvVNqr7G+7iW2THaF89orxp9QxNUj84EZXuwFUkstdhvCeAhX30nUz8ueyUpEwdBi4E4zZ+RsSjTzYoJ4lU3OC1rT6q9viCUBY3023G22n4kwErFVdg2RZsHyj4XWrr61IZCas8akeAmb8S/lBMWfA9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922139; c=relaxed/simple;
	bh=55VsRLtb8ErN2ls5GjyxauYkp/xcWUnZZ3ABknV+/Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=czuB47rYAAraZBLmCh4LzBgz409taNKCO5f0wWRx1ZHmcDy3s/kwKywUrqePjSL/qv7wRTroAM3f5nYxF/g7St/Wgsj1hJkad93OBbHyzfFDvj6y3qq5MFQcj3LWRFgGturuMEEkAokjpLaYsWWd408qy8g0nzJxCUS7dnT1WxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7C/Ho1U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716922138; x=1748458138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=55VsRLtb8ErN2ls5GjyxauYkp/xcWUnZZ3ABknV+/Vc=;
  b=b7C/Ho1UZ/RLrvLEoRGB6vNYHR7IfZC62xG8OY31DX2FAPoorMOQixKZ
   gEsIZaWl9yT7Yee6tN+7Rk5YFEOnrm04WYe596DdphpVOM2HJ6ESyg5fV
   9/eEv/Tswl7jr/UgESGJP/dIRKkYo0OQ1LFskZBcN7V/HUvJS3Pb8e7cW
   vcJ5LVAo366I8uHS9vgpKFYK/dPIb+O1PLdjDwR0QOxqUz3kmqVc7uHoh
   lnGxIkNfl0G1XG7/NfdGH0ktWUvq0mIvbZj0w2TpfenCx5AJsdTZycmtP
   3u5R294QzeVnVqvdT5ScKPRokru5uTeFBWLwyCj9uHaODgCBbJ+dm758s
   Q==;
X-CSE-ConnectionGUID: 0RiZSdMTQzCpWH7aDG1wKA==
X-CSE-MsgGUID: wpGPUcrzQ5C3p7xqAJKMYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="11734908"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="11734908"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:48:58 -0700
X-CSE-ConnectionGUID: hZ1427gsSWejoJrpdMRdfQ==
X-CSE-MsgGUID: 4BkGEWXUR8a6C4lWV+lgKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40035430"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 28 May 2024 11:48:57 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sC1sT-000CdN-0x;
	Tue, 28 May 2024 18:48:53 +0000
Date: Wed, 29 May 2024 02:48:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.21a 44/53] update.c:undefined reference to
 `__bad_cmpxchg'
Message-ID: <202405290221.CXfSkR3b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.21a
head:   17284125a3f17be817e917b23511c99aea8fee81
commit: 8b1964fedb0484ccda5a7e20f37ace2ebdcd1cf5 [44/53] rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240529/202405290221.CXfSkR3b-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405290221.CXfSkR3b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405290221.CXfSkR3b-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/rcu/update.o: in function `rcu_trc_cmpxchg_need_qs':
>> update.c:(.text+0x51e8): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: kernel/rcu/update.o: in function `trc_read_check_handler':
   update.c:(.text+0x5250): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: kernel/rcu/update.o: in function `rcu_read_unlock_trace_special':
   update.c:(.text+0x8170): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
   update.c:(.text+0x86c0): undefined reference to `__bad_cmpxchg'
>> arm-linux-gnueabi-ld: update.c:(.text+0x86ec): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: kernel/rcu/update.o:update.c:(.text+0x8a6c): more undefined references to `__bad_cmpxchg' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

