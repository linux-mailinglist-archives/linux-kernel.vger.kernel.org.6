Return-Path: <linux-kernel+bounces-339921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C711986C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EB6284049
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428D18786A;
	Thu, 26 Sep 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEE18ozi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A228187851
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330342; cv=none; b=F8S+nXUSUHRL3f4CdgoNR0YlXaRNROjhCHXOu7iMFsmyIrGGaqQ2U5w4Ol9bYpJsIdXEgOduEaPy8wux9RZTBpTNeO5aeTS6zcwjcE7mtBr97yMQXhn8Ga/QrttpMh9zwVwKewr1C3PCnANOJicMFZcIeqli6wlBl0XrHcKFMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330342; c=relaxed/simple;
	bh=ObSbGI/5whzvxubZhQoqWzsM991QYmAmmmDg3dhUsz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRVHaMawijVj6c/HxK4Eq1z2g0pGH7sDOtVXcot3xBxIDRO6Pp+L3TR98vc6a85hWjtVhWqol80QIUY7G+4yqqFKHvtlBWEyVY+iGJwRbUQxQ5cV3ueKoRMlPLLQ5cM+IWMAEiRO/mrbdydbgGA+NJ1nsyXJD4jj3VgwdUn7C/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEE18ozi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727330339; x=1758866339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObSbGI/5whzvxubZhQoqWzsM991QYmAmmmDg3dhUsz0=;
  b=UEE18oziN8CbO/kzEhAb8aNwIL317XPEDvTQWzMpdNOQybUoPMk6N+qB
   +cg1nIM8nHuW5l+mafIMVyNfytCnWRvtChGbrGpe+O72YqLJpcF5j44WV
   4GZfAgkvLyf2wrfM/WyivyGBC0bDLiUnbDpvHjtsbRRBdvrT29LCzDuFX
   z027UC1vWxF90/A2pXl3MxN6wm5aKmqlzjM0HA3ey8jrHYiNb/Fv8fDkR
   e+atRQwIeWXa9yiZTaa4GTk6hnT4g4RoxnJVFMznm43ozQzNZo7VOioRu
   RMuq7LoHi3LFCs9pHKyUmH/8xH3zo96/yfqp4VTqZHWcMrVA4y+wiUwsT
   A==;
X-CSE-ConnectionGUID: OdTjLHL3S6+zuux0xMU7Bg==
X-CSE-MsgGUID: kiWfUrANTLmO7iSFit7Wyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="48937727"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="48937727"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 22:58:59 -0700
X-CSE-ConnectionGUID: +LFQxGnFQtqE56+9kaUp8A==
X-CSE-MsgGUID: Xah0O/W4TiS3slHKVkG5UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="102842484"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2024 22:58:55 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sthWf-000KK3-2D;
	Thu, 26 Sep 2024 05:58:53 +0000
Date: Thu, 26 Sep 2024 13:58:39 +0800
From: kernel test robot <lkp@intel.com>
To: ran xiaokai <ranxiaokai627@163.com>, elver@google.com,
	tglx@linutronix.de, dvyukov@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH 2/4] kcsan, debugfs: refactor
 set_report_filterlist_whitelist() to return a value
Message-ID: <202409261331.9NyGRPt2-lkp@intel.com>
References: <20240925143154.2322926-3-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925143154.2322926-3-ranxiaokai627@163.com>

Hi ran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20240925]
[cannot apply to v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ran-xiaokai/kcsan-debugfs-Remove-redundant-call-of-kallsyms_lookup_name/20240925-231034
base:   linus/master
patch link:    https://lore.kernel.org/r/20240925143154.2322926-3-ranxiaokai627%40163.com
patch subject: [PATCH 2/4] kcsan, debugfs: refactor set_report_filterlist_whitelist() to return a value
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240926/202409261331.9NyGRPt2-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261331.9NyGRPt2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261331.9NyGRPt2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kcsan/debugfs.c:243:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     243 |                 if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kcsan/debugfs.c:256:6: note: uninitialized use occurs here
     256 |         if (ret < 0)
         |             ^~~
   kernel/kcsan/debugfs.c:243:3: note: remove the 'if' if its condition is always true
     243 |                 if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     244 |                         return -EINVAL;
>> kernel/kcsan/debugfs.c:238:13: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     238 |         } else if (!strcmp(arg, "off")) {
         |                    ^~~~~~~~~~~~~~~~~~~
   kernel/kcsan/debugfs.c:256:6: note: uninitialized use occurs here
     256 |         if (ret < 0)
         |             ^~~
   kernel/kcsan/debugfs.c:238:9: note: remove the 'if' if its condition is always false
     238 |         } else if (!strcmp(arg, "off")) {
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
     239 |                 WRITE_ONCE(kcsan_enabled, false);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     240 |         } else if (str_has_prefix(arg, "microbench=")) {
         |         ~~~~~~
   kernel/kcsan/debugfs.c:236:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     236 |         if (!strcmp(arg, "on")) {
         |             ^~~~~~~~~~~~~~~~~~
   kernel/kcsan/debugfs.c:256:6: note: uninitialized use occurs here
     256 |         if (ret < 0)
         |             ^~~
   kernel/kcsan/debugfs.c:236:2: note: remove the 'if' if its condition is always false
     236 |         if (!strcmp(arg, "on")) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
     237 |                 WRITE_ONCE(kcsan_enabled, true);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     238 |         } else if (!strcmp(arg, "off")) {
         |         ~~~~~~
   kernel/kcsan/debugfs.c:229:13: note: initialize the variable 'ret' to silence this warning
     229 |         ssize_t ret;
         |                    ^
         |                     = 0
   3 warnings generated.


vim +243 kernel/kcsan/debugfs.c

dfd402a4c4baae Marco Elver   2019-11-14  222  
5cbaefe9743bf1 Ingo Molnar   2019-11-20  223  static ssize_t
5cbaefe9743bf1 Ingo Molnar   2019-11-20  224  debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *off)
dfd402a4c4baae Marco Elver   2019-11-14  225  {
dfd402a4c4baae Marco Elver   2019-11-14  226  	char kbuf[KSYM_NAME_LEN];
dfd402a4c4baae Marco Elver   2019-11-14  227  	char *arg;
43d631bf06ec96 Thorsten Blum 2024-06-24  228  	const size_t read_len = min(count, sizeof(kbuf) - 1);
52313281c8b7ca Ran Xiaokai   2024-09-25  229  	ssize_t ret;
dfd402a4c4baae Marco Elver   2019-11-14  230  
dfd402a4c4baae Marco Elver   2019-11-14  231  	if (copy_from_user(kbuf, buf, read_len))
dfd402a4c4baae Marco Elver   2019-11-14  232  		return -EFAULT;
dfd402a4c4baae Marco Elver   2019-11-14  233  	kbuf[read_len] = '\0';
dfd402a4c4baae Marco Elver   2019-11-14  234  	arg = strstrip(kbuf);
dfd402a4c4baae Marco Elver   2019-11-14  235  
dfd402a4c4baae Marco Elver   2019-11-14  236  	if (!strcmp(arg, "on")) {
dfd402a4c4baae Marco Elver   2019-11-14  237  		WRITE_ONCE(kcsan_enabled, true);
dfd402a4c4baae Marco Elver   2019-11-14 @238  	} else if (!strcmp(arg, "off")) {
dfd402a4c4baae Marco Elver   2019-11-14  239  		WRITE_ONCE(kcsan_enabled, false);
a4e74fa5f0d3e2 Marco Elver   2020-07-31  240  	} else if (str_has_prefix(arg, "microbench=")) {
dfd402a4c4baae Marco Elver   2019-11-14  241  		unsigned long iters;
dfd402a4c4baae Marco Elver   2019-11-14  242  
a4e74fa5f0d3e2 Marco Elver   2020-07-31 @243  		if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
dfd402a4c4baae Marco Elver   2019-11-14  244  			return -EINVAL;
dfd402a4c4baae Marco Elver   2019-11-14  245  		microbenchmark(iters);
dfd402a4c4baae Marco Elver   2019-11-14  246  	} else if (!strcmp(arg, "whitelist")) {
52313281c8b7ca Ran Xiaokai   2024-09-25  247  		ret = set_report_filterlist_whitelist(true);
dfd402a4c4baae Marco Elver   2019-11-14  248  	} else if (!strcmp(arg, "blacklist")) {
52313281c8b7ca Ran Xiaokai   2024-09-25  249  		ret = set_report_filterlist_whitelist(false);
dfd402a4c4baae Marco Elver   2019-11-14  250  	} else if (arg[0] == '!') {
52313281c8b7ca Ran Xiaokai   2024-09-25  251  		ret = insert_report_filterlist(&arg[1]);
dfd402a4c4baae Marco Elver   2019-11-14  252  	} else {
dfd402a4c4baae Marco Elver   2019-11-14  253  		return -EINVAL;
dfd402a4c4baae Marco Elver   2019-11-14  254  	}
dfd402a4c4baae Marco Elver   2019-11-14  255  
52313281c8b7ca Ran Xiaokai   2024-09-25  256  	if (ret < 0)
52313281c8b7ca Ran Xiaokai   2024-09-25  257  		return ret;
52313281c8b7ca Ran Xiaokai   2024-09-25  258  	else
dfd402a4c4baae Marco Elver   2019-11-14  259  		return count;
dfd402a4c4baae Marco Elver   2019-11-14  260  }
dfd402a4c4baae Marco Elver   2019-11-14  261  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

