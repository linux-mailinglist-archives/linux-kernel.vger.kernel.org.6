Return-Path: <linux-kernel+bounces-446408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABE9F23FE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126C31886605
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE4188904;
	Sun, 15 Dec 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpAgK0hx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77567187876
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734267522; cv=none; b=B9Hi9M4aj2oCa8ktRo9Zg27T4RoP8H8rpbM/aNMg6V9pbupALYTfwz/IAYXGKaBUU3tnCmjhjYH586gMr8A+csgs6r23/1w0Ka2XrsUASrye4x1+Mz6O00b8zEegt2FeACxD1+9gWuTmwVX99ryCzJ4sAURDuNy/z6yeYjA3uC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734267522; c=relaxed/simple;
	bh=3QZlqGTTnldowiyG5mUgxJY2mrHvR8JiPxhMeE8Z4tA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Svo5g6TGIKZ04dLL7tRVi/oUMFNg3NmQiIOfhD3LOGb1Sx3ZqtMPXR/+MN705YqplEl2Av5UdZrL8CzIywUUgEsa0Ma/dng4fZu8yiYO45huuojEz+L3ogVpSUQw3k3bCedrQ9ki87zPIXH+oifzAp00fOTalWpwlVXcj/EBas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpAgK0hx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734267520; x=1765803520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3QZlqGTTnldowiyG5mUgxJY2mrHvR8JiPxhMeE8Z4tA=;
  b=jpAgK0hxZI4lWc9L0+HFNQp0GYOBJLMhb3k2cFJZSgzFXFMMzI0CN7Lg
   kzyMWJ78Xf855x/ihAkZJgv0QqDk3soOsFQW4/qPlUIwbAGJVuZlJdGgF
   05hCyz3fKiWsrLgmWSxxiWuhaZI2nbeWEcn4sb+4qMt27yndlQVmPEmbA
   UMFEk+4fKUZnkZ393hclV32mR0pa5FQ7aJwJHkXrN+ImNVu2ATwjaTxN5
   CHbcDWTTND6EpIw5AQRBb5TFPVLDc0i2IHZderVe4QXgksNK8qvJwkPie
   fxLDf3BLeiOPsPkH2vLg5iNYQka0fxWXWWh3y3SSotBqvoNLpY5dW109E
   A==;
X-CSE-ConnectionGUID: 3IpEYbdHTRaaR4G0Bxut+Q==
X-CSE-MsgGUID: 5QzzJaQSQQ+A6E/SufFkQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="45354613"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="45354613"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 04:58:39 -0800
X-CSE-ConnectionGUID: xHBH1Qc3TNqnB7J/iHgaqw==
X-CSE-MsgGUID: 70ij6usqQpmSTPrvRXdCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102049160"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Dec 2024 04:58:39 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMoCh-000Dcs-30;
	Sun, 15 Dec 2024 12:58:35 +0000
Date: Sun, 15 Dec 2024 20:57:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: kernel/reboot.c:226: warning: Function parameter or struct member
 'cmd' not described in 'do_kernel_restart'
Message-ID: <202412152053.KeJr8B5f-lkp@intel.com>
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
commit: 0c3ebff535956d2718594dc90aa9cc87521ec9fd scripts: kernel-doc: Clarify missing struct member description
date:   1 year ago
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20241215/202412152053.KeJr8B5f-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412152053.KeJr8B5f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412152053.KeJr8B5f-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/reboot.c:226: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
>> kernel/reboot.c:952: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
--
>> lib/hweight.c:14: warning: Function parameter or struct member 'w' not described in '__sw_hweight32'
   lib/hweight.c:14: warning: expecting prototype for hweightN(). Prototype was for __sw_hweight32() instead


vim +226 kernel/reboot.c

b63adb979583ef Guenter Roeck 2014-09-26  213  
b63adb979583ef Guenter Roeck 2014-09-26  214  /**
b63adb979583ef Guenter Roeck 2014-09-26  215   *	do_kernel_restart - Execute kernel restart handler call chain
b63adb979583ef Guenter Roeck 2014-09-26  216   *
b63adb979583ef Guenter Roeck 2014-09-26  217   *	Calls functions registered with register_restart_handler.
b63adb979583ef Guenter Roeck 2014-09-26  218   *
b63adb979583ef Guenter Roeck 2014-09-26  219   *	Expected to be called from machine_restart as last step of the restart
b63adb979583ef Guenter Roeck 2014-09-26  220   *	sequence.
b63adb979583ef Guenter Roeck 2014-09-26  221   *
b63adb979583ef Guenter Roeck 2014-09-26  222   *	Restarts the system immediately if a restart handler function has been
b63adb979583ef Guenter Roeck 2014-09-26  223   *	registered. Otherwise does nothing.
b63adb979583ef Guenter Roeck 2014-09-26  224   */
b63adb979583ef Guenter Roeck 2014-09-26  225  void do_kernel_restart(char *cmd)
b63adb979583ef Guenter Roeck 2014-09-26 @226  {
b63adb979583ef Guenter Roeck 2014-09-26  227  	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
b63adb979583ef Guenter Roeck 2014-09-26  228  }
b63adb979583ef Guenter Roeck 2014-09-26  229  

:::::: The code at line 226 was first introduced by commit
:::::: b63adb979583ef185718d774d8162387db5589c0 kernel: add support for kernel restart handler call chain

:::::: TO: Guenter Roeck <linux@roeck-us.net>
:::::: CC: Guenter Roeck <linux@roeck-us.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

