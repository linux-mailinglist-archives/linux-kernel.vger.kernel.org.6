Return-Path: <linux-kernel+bounces-194902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098508D43EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C531C23280
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA802F5E;
	Thu, 30 May 2024 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfKDCeF/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4433C5
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038242; cv=none; b=qblMUYYu/EEa33dtpIxU3id/sBEWnDUsrC2P8p6fcuocvpTx+Fsb7rfHmGnqfwMsKLVma2J6vOjtZ+SLqCbkQQ1981yfOk8vTujBo59SviR4jPj7m/iNXnWKyp9vYVFTXvNTCbameTg7HZ3DriGzrOKQDYZ1No/NIf3KsW1fbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038242; c=relaxed/simple;
	bh=itx6CiZO8biKO4iFc4LP5b+aa7TUF3QXMCYQGZjP+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feTB8sP49VvJSigBHQFwov4lwocVpdBPXC8W65fg9fom8/+hwQGocgwne1HO7cFbEYgNmN5KT+TTNRuEM7yBmjwESwD2AfvpOM75MZYq9QabymVsBoJLjAptW4sVgt4ZPbMhCS0uKxcbc5PTUOeZ8RbtcJABACew++7Bv2LKFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfKDCeF/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717038241; x=1748574241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=itx6CiZO8biKO4iFc4LP5b+aa7TUF3QXMCYQGZjP+yA=;
  b=YfKDCeF/W1SdIcjPvag2hTr0fG5uHiCFeKSBLBEh4t74FSc2ibE957iP
   KlBo/s4V/vWVC/7EesfB7aV/EaQj1gmg9n2rLNUsYoD3QShcl2Z1YveB+
   A/VXvYowaCOqdC6lG8cYbiO6/VlNLDNNcrrEJDqbt9tHonrkop72YGAV8
   9V0Sbm2daT7pX9wT66F+UOLd2ZAjwlnw/xo9aAAdAQJreXDpk4Nz6MNuM
   KYexRvVtpwSWcR1fK16A17t/o2wP1+REq4UnU/B1YNNsgyO9S4z6kUgwq
   ihAqdIaQ3n2WKJI+CQyn3mzVoPDEiwQp++2MwdfjSdr6taH0a58YJaZSk
   w==;
X-CSE-ConnectionGUID: V963h3G0QimW9zPNjv+hnA==
X-CSE-MsgGUID: rXjMFWb+Qb6TLVxgPRkeYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24038831"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24038831"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:04:00 -0700
X-CSE-ConnectionGUID: XGAxX0oQT2Wx+gnu7+bJww==
X-CSE-MsgGUID: zF9+NgRBTg6E0Z8op+LDww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35589971"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 20:03:57 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCW54-000EUz-1z;
	Thu, 30 May 2024 03:03:54 +0000
Date: Thu, 30 May 2024 11:02:59 +0800
From: kernel test robot <lkp@intel.com>
To: Soumya Khasnis <soumya.khasnis@sony.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com
Cc: oe-kbuild-all@lists.linux.dev, Madhusudan.Bobbili@sony.com,
	shingo.takeuchi@sony.com, keita.aihara@sony.com,
	masaya.takahashi@sony.com
Subject: Re: [PATCH v2] reboot: Add timeout for device shutdown
Message-ID: <202405301059.Zo7XvEFp-lkp@intel.com>
References: <20240529110049.GA73111@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529110049.GA73111@sony.com>

Hi Soumya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Soumya-Khasnis/reboot-Add-timeout-for-device-shutdown/20240529-190203
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20240529110049.GA73111%40sony.com
patch subject: [PATCH v2] reboot: Add timeout for device shutdown
config: x86_64-randconfig-r132-20240530 (https://download.01.org/0day-ci/archive/20240530/202405301059.Zo7XvEFp-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405301059.Zo7XvEFp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405301059.Zo7XvEFp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/reboot.c:55:3: sparse: sparse: symbol 'devs_shutdown' was not declared. Should it be static?
   kernel/reboot.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +/devs_shutdown +55 kernel/reboot.c

    50	
    51	#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
    52	struct device_shutdown_timeout {
    53		struct timer_list timer;
    54		struct task_struct *task;
  > 55	} devs_shutdown;
    56	#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
    57	#endif
    58	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

