Return-Path: <linux-kernel+bounces-342840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A4989380
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEB51C21982
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86513C9DE;
	Sun, 29 Sep 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6x0WIuk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397E13B286
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727595625; cv=none; b=hN4fB1FoDcBvRPtn/gRNfFOJ2m5iCAclHBcoxssY1o/3YT2u1bIXvrZTvQzr6F5gXgY1vsgW/iQzfGnsZ/pskrTpaX4IDbVIAy1YZwhHQaFrpwP9Asi6csdX7NerZMimYf3DQneG+cXGoddjwy6B+fpdI8IW7Moix5YobaUlNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727595625; c=relaxed/simple;
	bh=PXPm3ZEdxyC1/4kK1id7Oxz+32shoP17TZE59UaH2qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz/OuOj4uw4HdzEE1w8NYqLX0sd3P8fPLmg7fCn2LN1ROCxWse37F4cWdAb730v6Wzw/9kAMCkozCt+bWGLKFrOLEPMfveMiEW95Vi5wfUYFsmEpREtQ/XSq3JfP8QHns1ZMpAjOLJJ/KbXhna/8zqOmV51gkXFDy5psD9DgnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6x0WIuk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727595623; x=1759131623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PXPm3ZEdxyC1/4kK1id7Oxz+32shoP17TZE59UaH2qs=;
  b=E6x0WIukhFYlKCDMIg964poKA1iKmBXWYHmsbRzjYnpxB9D/Oe/gK9Se
   mrgCP0RG3/cb3dQPHG6CZqKGWf/otBg5Ds8CvUYEcMX+tvGe8GdLAVxSm
   y00sJtKhSfTmeYnW9mnl137qimALHTrQZnEndOXx0UxBHZ+g+Q90R6qMv
   R7ChE/YP0sqPGsN/8othNUymjNyAis1RQZVZedKT5OQf+5a/GOYxz0tPI
   GcHCysMWnsPooEvEH/c60fI9o58eARl0FRELmVEWdEXffju0ZID3A9XHW
   Mwyv13BIwmtEUx/2RRh7+3w72G5UC1ect8jDUffOmytGuJ8AOpZQG1Aua
   A==;
X-CSE-ConnectionGUID: D9Mc6S9EQ5KrrWdCY9NWAA==
X-CSE-MsgGUID: VFQY7/+TSpOyhP7WngOqCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="14316079"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="14316079"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 00:40:17 -0700
X-CSE-ConnectionGUID: T/AOcw+tRvutzdqtolQaeQ==
X-CSE-MsgGUID: K3XLFbCFROuePKEdHSVqEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="96297875"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Sep 2024 00:40:16 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suoXN-000O0F-27;
	Sun, 29 Sep 2024 07:40:13 +0000
Date: Sun, 29 Sep 2024 15:39:56 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] reset: Further simplify locking with guard()
Message-ID: <202409291457.lc5Xgv3u-lkp@intel.com>
References: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on 487b1b32e317b85c2948eb4013f3e089a0433d49]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Zabel/reset-Further-simplify-locking-with-guard/20240927-220355
base:   487b1b32e317b85c2948eb4013f3e089a0433d49
patch link:    https://lore.kernel.org/r/20240927-reset-guard-v1-1-293bf1302210%40pengutronix.de
patch subject: [PATCH] reset: Further simplify locking with guard()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240929/202409291457.lc5Xgv3u-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409291457.lc5Xgv3u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409291457.lc5Xgv3u-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/reset/core.c:1035:4: error: cannot jump from this goto statement to its label
    1035 |                         goto out_put;
         |                         ^
   drivers/reset/core.c:1039:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1039 |         guard(mutex)(&reset_list_mutex);
         |         ^
   include/linux/cleanup.h:167:15: note: expanded from macro 'guard'
     167 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:110:1: note: expanded from here
     110 | __UNIQUE_ID_guard501
         | ^
   1 error generated.


vim +1035 drivers/reset/core.c

c721f189e89c0d Krzysztof Kozlowski 2024-01-29   989  
1c5e05c23f4a64 Philipp Zabel       2021-03-04   990  struct reset_control *
1c5e05c23f4a64 Philipp Zabel       2021-03-04   991  __of_reset_control_get(struct device_node *node, const char *id, int index,
1c5e05c23f4a64 Philipp Zabel       2021-03-04   992  		       bool shared, bool optional, bool acquired)
61fc41317666be Philipp Zabel       2012-11-19   993  {
c721f189e89c0d Krzysztof Kozlowski 2024-01-29   994  	bool gpio_fallback = false;
d056c9b8191867 Philipp Zabel       2015-12-08   995  	struct reset_control *rstc;
c721f189e89c0d Krzysztof Kozlowski 2024-01-29   996  	struct reset_controller_dev *rcdev;
61fc41317666be Philipp Zabel       2012-11-19   997  	struct of_phandle_args args;
61fc41317666be Philipp Zabel       2012-11-19   998  	int rstc_id;
61fc41317666be Philipp Zabel       2012-11-19   999  	int ret;
61fc41317666be Philipp Zabel       2012-11-19  1000  
6c96f05c8bb8bc Hans de Goede       2016-02-23  1001  	if (!node)
6c96f05c8bb8bc Hans de Goede       2016-02-23  1002  		return ERR_PTR(-EINVAL);
6c96f05c8bb8bc Hans de Goede       2016-02-23  1003  
6c96f05c8bb8bc Hans de Goede       2016-02-23  1004  	if (id) {
6c96f05c8bb8bc Hans de Goede       2016-02-23  1005  		index = of_property_match_string(node,
6c96f05c8bb8bc Hans de Goede       2016-02-23  1006  						 "reset-names", id);
bb475230b8e59a Ramiro Oliveira     2017-01-13  1007  		if (index == -EILSEQ)
bb475230b8e59a Ramiro Oliveira     2017-01-13  1008  			return ERR_PTR(index);
6c96f05c8bb8bc Hans de Goede       2016-02-23  1009  		if (index < 0)
bb475230b8e59a Ramiro Oliveira     2017-01-13  1010  			return optional ? NULL : ERR_PTR(-ENOENT);
6c96f05c8bb8bc Hans de Goede       2016-02-23  1011  	}
6c96f05c8bb8bc Hans de Goede       2016-02-23  1012  
fc0a5921561c71 Maxime Ripard       2013-12-20  1013  	ret = of_parse_phandle_with_args(node, "resets", "#reset-cells",
61fc41317666be Philipp Zabel       2012-11-19  1014  					 index, &args);
bb475230b8e59a Ramiro Oliveira     2017-01-13  1015  	if (ret == -EINVAL)
61fc41317666be Philipp Zabel       2012-11-19  1016  		return ERR_PTR(ret);
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1017  	if (ret) {
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1018  		if (!IS_ENABLED(CONFIG_RESET_GPIO))
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1019  			return optional ? NULL : ERR_PTR(ret);
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1020  
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1021  		/*
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1022  		 * There can be only one reset-gpio for regular devices, so
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1023  		 * don't bother with the "reset-gpios" phandle index.
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1024  		 */
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1025  		ret = of_parse_phandle_with_args(node, "reset-gpios", "#gpio-cells",
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1026  						 0, &args);
bb475230b8e59a Ramiro Oliveira     2017-01-13  1027  		if (ret)
bb475230b8e59a Ramiro Oliveira     2017-01-13  1028  			return optional ? NULL : ERR_PTR(ret);
61fc41317666be Philipp Zabel       2012-11-19  1029  
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1030  		gpio_fallback = true;
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1031  
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1032  		ret = __reset_add_reset_gpio_device(&args);
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1033  		if (ret) {
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1034  			rstc = ERR_PTR(ret);
c721f189e89c0d Krzysztof Kozlowski 2024-01-29 @1035  			goto out_put;
61fc41317666be Philipp Zabel       2012-11-19  1036  		}
61fc41317666be Philipp Zabel       2012-11-19  1037  	}
61fc41317666be Philipp Zabel       2012-11-19  1038  
784c4fbce820c0 Philipp Zabel       2024-09-27  1039  	guard(mutex)(&reset_list_mutex);
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1040  	rcdev = __reset_find_rcdev(&args, gpio_fallback);
61fc41317666be Philipp Zabel       2012-11-19  1041  	if (!rcdev) {
b790c8ea5593d6 Geert Uytterhoeven  2018-10-08  1042  		rstc = ERR_PTR(-EPROBE_DEFER);
784c4fbce820c0 Philipp Zabel       2024-09-27  1043  		goto out_put;
61fc41317666be Philipp Zabel       2012-11-19  1044  	}
61fc41317666be Philipp Zabel       2012-11-19  1045  
e677774f502635 Maxime Ripard       2016-01-14  1046  	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
b790c8ea5593d6 Geert Uytterhoeven  2018-10-08  1047  		rstc = ERR_PTR(-EINVAL);
784c4fbce820c0 Philipp Zabel       2024-09-27  1048  		goto out_put;
e677774f502635 Maxime Ripard       2016-01-14  1049  	}
e677774f502635 Maxime Ripard       2016-01-14  1050  
61fc41317666be Philipp Zabel       2012-11-19  1051  	rstc_id = rcdev->of_xlate(rcdev, &args);
61fc41317666be Philipp Zabel       2012-11-19  1052  	if (rstc_id < 0) {
b790c8ea5593d6 Geert Uytterhoeven  2018-10-08  1053  		rstc = ERR_PTR(rstc_id);
784c4fbce820c0 Philipp Zabel       2024-09-27  1054  		goto out_put;
61fc41317666be Philipp Zabel       2012-11-19  1055  	}
61fc41317666be Philipp Zabel       2012-11-19  1056  
c15ddec2ca0607 Hans de Goede       2016-02-23  1057  	/* reset_list_mutex also protects the rcdev's reset_control list */
c84b0326d5e4fe Philipp Zabel       2019-02-21  1058  	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
61fc41317666be Philipp Zabel       2012-11-19  1059  
c721f189e89c0d Krzysztof Kozlowski 2024-01-29  1060  out_put:
b790c8ea5593d6 Geert Uytterhoeven  2018-10-08  1061  	of_node_put(args.np);
61fc41317666be Philipp Zabel       2012-11-19  1062  
61fc41317666be Philipp Zabel       2012-11-19  1063  	return rstc;
61fc41317666be Philipp Zabel       2012-11-19  1064  }
6c96f05c8bb8bc Hans de Goede       2016-02-23  1065  EXPORT_SYMBOL_GPL(__of_reset_control_get);
61fc41317666be Philipp Zabel       2012-11-19  1066  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

