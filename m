Return-Path: <linux-kernel+bounces-539910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A0A4AAB3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7221D1899134
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CAD1DE8AB;
	Sat,  1 Mar 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgn2hhu1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311A1DE3AA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829369; cv=none; b=IX4PXpR1mcmihPKfdzsVMuYfy7RJY6pLBCIklCZqfOdHlk7fxJ2X8VwalcYy2DuPOFHiB+9cacgBCc5xpKK2vypJDsDIWoD64R3COG2AA8TQ7/XQjZ1gztJ+bdyTlamUulCJPmzkHc0WHMWJvm9sJcsP1kAUUM+9Cu2qkx5XUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829369; c=relaxed/simple;
	bh=pdl/RZTv2T1vX9tzslQwxxDs8Xn0N+aU6EcFHnJHdO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geprmDzsp1O4scmdm56XIKrpbbtFOh+UEIQuEe2CFKPSQvLLSOSm+hRbLc9kEE5R6MfCt6ArZp02Dqmp0bBTRjI2M2wh2ifc4pnA/EERzACEvFvcrDjtvVFNuLwZxNikCTmftGPaEq3IQ2cBU5/Mgg1Fg8gwb0hWb6vt3ueciXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgn2hhu1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740829368; x=1772365368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pdl/RZTv2T1vX9tzslQwxxDs8Xn0N+aU6EcFHnJHdO4=;
  b=cgn2hhu1Dp9JRzC4rlmVARIQTwYjM3ffrco0S2o/9DuSWWlHcJh7cdk5
   kUikrW7+RezS+5P6QQPwWiKkxhKcJoy9WleAqfplW8UO4QuC5pURrCyqS
   GEjyiNFOGWv4WC0H5lIZFHGTdVPHhcvsE+rwd07eettq0AG10YLa7o9N5
   ndI5REyIJMCLQblM2UMyedC73EArPjcfz/sPD5un0e9fryxOZBM9SBJF0
   2YrX2v5mC03640RWjsHxVP8/yFmMPZjomDu0BrRPSxJ8WUyBfDqz6P7rH
   IyvLptGMZr4AI7W31ijt9vGviADPO9vGY8I0bAiN38l/Blq7Lb7ZvFzHm
   A==;
X-CSE-ConnectionGUID: uP5bVq4PTpi2zL6DcO1c3Q==
X-CSE-MsgGUID: HJwZmGo9SzO49BgVOS2TAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45403481"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45403481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 03:42:48 -0800
X-CSE-ConnectionGUID: o8kHYd3nTyiE6XcvOUQ8/A==
X-CSE-MsgGUID: FS7Yx1TGS72LbeL6GhHfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154739828"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Mar 2025 03:42:45 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toLEw-000GCY-2J;
	Sat, 01 Mar 2025 11:42:42 +0000
Date: Sat, 1 Mar 2025 19:42:31 +0800
From: kernel test robot <lkp@intel.com>
To: xiaopeitux@foxmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] driver core: Split devres APIs to device/devres.h
Message-ID: <202503011920.E8wPk3yy-lkp@intel.com>
References: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250227]
[cannot apply to linus/master v6.14-rc4 v6.14-rc3 v6.14-rc2 v6.14-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xiaopeitux-foxmail-com/driver-core-Split-devres-APIs-to-device-devres-h/20250228-172012
base:   next-20250227
patch link:    https://lore.kernel.org/r/tencent_66CF9C91EB4A4417F70E9511649A57DEC906%40qq.com
patch subject: [PATCH] driver core: Split devres APIs to device/devres.h
config: arm64-randconfig-004-20250301 (https://download.01.org/0day-ci/archive/20250301/202503011920.E8wPk3yy-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503011920.E8wPk3yy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503011920.E8wPk3yy-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:10:
>> include/linux/device/devres.h:182:6: error: variable has incomplete type 'void'
     182 | void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
         |      ^
   include/linux/compiler_types.h:60:19: note: expanded from macro '__percpu'
      60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
         |                         ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:10:
>> include/linux/device/devres.h:182:15: error: expected ';' after top level declarator
     182 | void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
         |               ^
>> include/linux/device/devres.h:184:57: error: expected ')'
     184 | void devm_free_percpu(struct device *dev, void __percpu *pdata);
         |                                                         ^
   include/linux/device/devres.h:184:22: note: to match this '('
     184 | void devm_free_percpu(struct device *dev, void __percpu *pdata);
         |                      ^
>> include/linux/device/devres.h:184:48: error: 'void' must be the first and only parameter if specified
     184 | void devm_free_percpu(struct device *dev, void __percpu *pdata);
         |                                                ^
   include/linux/compiler_types.h:60:19: note: expanded from macro '__percpu'
      60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
         |                         ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:10:
>> include/linux/device/devres.h:186:25: warning: declaration of 'struct attribute_group' will not be visible outside of this function [-Wvisibility]
     186 |                                        const struct attribute_group *grp);
         |                                                     ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:13:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:13:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:13:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:13:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:13:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c:13:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/arm64/include/asm/elf.h:141:


vim +/void +182 include/linux/device/devres.h

   148	
   149	int __devm_add_action(struct device *dev, void (*action)(void *), void *data, const char *name);
   150	#define devm_add_action(dev, action, data) \
   151		__devm_add_action(dev, action, data, #action)
   152	
   153	static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
   154						     void *data, const char *name)
   155	{
   156		int ret;
   157	
   158		ret = __devm_add_action(dev, action, data, name);
   159		if (ret)
   160			action(data);
   161	
   162		return ret;
   163	}
   164	#define devm_add_action_or_reset(dev, action, data) \
   165		__devm_add_action_or_reset(dev, action, data, #action)
   166	
   167	/**
   168	 * devm_alloc_percpu - Resource-managed alloc_percpu
   169	 * @dev: Device to allocate per-cpu memory for
   170	 * @type: Type to allocate per-cpu memory for
   171	 *
   172	 * Managed alloc_percpu. Per-cpu memory allocated with this function is
   173	 * automatically freed on driver detach.
   174	 *
   175	 * RETURNS:
   176	 * Pointer to allocated memory on success, NULL on failure.
   177	 */
   178	#define devm_alloc_percpu(dev, type)      \
   179		((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), \
   180							      __alignof__(type)))
   181	
 > 182	void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
   183					   size_t align);
 > 184	void devm_free_percpu(struct device *dev, void __percpu *pdata);
   185	int __must_check devm_device_add_group(struct device *dev,
 > 186					       const struct attribute_group *grp);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

