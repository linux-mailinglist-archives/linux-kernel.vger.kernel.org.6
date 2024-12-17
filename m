Return-Path: <linux-kernel+bounces-448572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A369F41E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20431887FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623413DB9F;
	Tue, 17 Dec 2024 05:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1HN/MSe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D08F77
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411821; cv=none; b=g/WizE32sh4b9X3x/TLUofr19gfSKbvrk1WNSUPwX292J8ktz1Kpc3fnxJaRU21OJ+KYI1WVYisGiTAxoCh+XunWjJrBM6qRcXaUP1FwJq87XpTxUSC7CbH8jW+lNrrF814zwRJrWTYP8xmvb/ML9F4xtaayH7ZuVUxxEiK5R7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411821; c=relaxed/simple;
	bh=d31n8lpD8wwu08zisCASmDvUZJxi7gL1qD7GiOQmm+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YMPlRE3Ips/5/80MQhrI/VqhOIVAUOdGHQXlYhDDPnlu9veEV8XyUWUud3v8KMF4iWCs17zUQXu2uZLgAFSwobH3Ctw0z5Ud76j9mSE5IUNeXwElIdINnlGLqckFDZleAyGwiTuuCJBrZvAr0wBFWecTDRPeWEZ9HfET8ybsSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1HN/MSe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734411820; x=1765947820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d31n8lpD8wwu08zisCASmDvUZJxi7gL1qD7GiOQmm+s=;
  b=F1HN/MSeHu0Ion/OwPZ98HpUMmiFF+DijiRDOZxzQfkOXYB2x3JWTZdW
   ulBxDMhWNo1oXkPV+EU+Ofj0FwToU54EPKL8QpZqKvryLs3PHovkZQlAq
   lYhgVVpB5aPxg/WXCPmmnX7gJJmi/NUdoq2C17tjmpdC4GJcz2XcoZyqK
   /s2PUa0tr68ewJsXv1wUFrGdoQc+EQiefrZiskV8HyMn1pmPw7f1fxpe+
   Xyi4SxqnJXv8cesZZ3dlJko2oCBjwAMdSgAogum+rNjVgXC+0pTpI4Dvh
   ClBIwkVjbXCtzzKquarMfDQzFhuOGS2NWnuraIs+UdjjeO0p0uE3gvele
   g==;
X-CSE-ConnectionGUID: d3sEzVg0Q7eNzmHGh7tm9w==
X-CSE-MsgGUID: aZ+bohMTT1CadJBCFqFoVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22412052"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="22412052"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 21:03:37 -0800
X-CSE-ConnectionGUID: jPIASKzVRJaKe00K1Ciybw==
X-CSE-MsgGUID: ML70RT5BRT263yYolZBWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="102273184"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Dec 2024 21:03:36 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNPk6-000Ej2-0l;
	Tue, 17 Dec 2024 05:03:34 +0000
Date: Tue, 17 Dec 2024 13:02:37 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: kernel/reboot.c:226: warning: Function parameter or struct member
 'cmd' not described in 'do_kernel_restart'
Message-ID: <202412171248.ro76Gqt1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e
commit: 92ef432f027cffe0ff91ff2cbe9258d89ca53968 kbuild: support W=c and W=e shorthands for Kconfig
date:   1 year ago
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20241217/202412171248.ro76Gqt1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241217/202412171248.ro76Gqt1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412171248.ro76Gqt1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/reboot.c:226: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
>> kernel/reboot.c:952: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
--
   lib/vsprintf.c: In function 'va_format':
>> lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
>> lib/hweight.c:14: warning: Function parameter or struct member 'w' not described in '__sw_hweight32'
>> lib/hweight.c:14: warning: expecting prototype for hweightN(). Prototype was for __sw_hweight32() instead
--
   drivers/clk/clkdev.c: In function 'vclkdev_alloc':
>> drivers/clk/clkdev.c:173:17: warning: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     173 |                 vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
         |                 ^~~~~~~~~~


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

