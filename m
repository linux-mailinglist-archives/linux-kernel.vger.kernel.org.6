Return-Path: <linux-kernel+bounces-354634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0912994077
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0E61C2635C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E21FBCB4;
	Tue,  8 Oct 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhO+x6Jq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9391D6DD4;
	Tue,  8 Oct 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371446; cv=none; b=Rpa8OjKms3lgQb4ZMwEiOwY84rnAveho6vEfk4SzD+kL7ADzXoitC0JxIFd4VgvxRv1udwpJ9zpPqSd6kQfzpzb91Zp49A0/bJz+kcoxZgjTbBg7bQ6+JbXPRd/OHdgqsUHofEXibLKWQI88znt+nlwdwS9ROvlZd2FDdc5sDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371446; c=relaxed/simple;
	bh=N5Ma5mFoM2e9QcVwT94+5B2d9Fv3qCQ9H2VljSoG55g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHX+Ol8m1LfvcvolDjXw9bI7iifW3rTu72ahpKqj0kvVTrs7apO61WW8MvJYJboUne1CGf6Iwi2R+Ywekth/SDgOa73hhDrIk02dPQJ7w3p/qYutpLgjKd60IpzYrojHmUU77R6yUzKL5MA+jUU08HDuONL/SJCHDmlQd6GxEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhO+x6Jq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728371444; x=1759907444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5Ma5mFoM2e9QcVwT94+5B2d9Fv3qCQ9H2VljSoG55g=;
  b=FhO+x6Jq/54/q0wrozT27ZkUQ7Sysq0uZVwLf2mAjaBb6cjphgYQyX6x
   HaYAUA9wYTikXi3a5vcORn9NV3UmkbdS3Mg4AIY+azyI8cxr1hFP554O2
   MGhzDzqW/3sNk82d5umOYgrfsCrz4R7slWA2PR0rQ1p1TGAOeKnLRXTga
   /A4VUyoyNnmOeqKcjpw9GY6a1M6AAorKueyR4zDUdXwlRujHzvvly7bBG
   s1HkChZ2s1CHo729jXC+sjmQrqG6lYZEdvWviSkCxSBdecvghQOFDkcIA
   1FL9Pnkq+Ath4iJJ1PAzlACQscUDje6Y0x+Ejt+5BfjJ18Gv0gdd7CQDe
   g==;
X-CSE-ConnectionGUID: x43tFkUHRcKo3pTY5d1KhA==
X-CSE-MsgGUID: hVzmUCsSRhCP9yM62k3NXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38202688"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="38202688"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 00:10:44 -0700
X-CSE-ConnectionGUID: b30XN+4gTou+oeMaKERnsg==
X-CSE-MsgGUID: vSbX6Ko7TDSG1AkTAjPIUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="75418054"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Oct 2024 00:10:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy4Mf-00061A-2h;
	Tue, 08 Oct 2024 07:10:37 +0000
Date: Tue, 8 Oct 2024 15:09:40 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com, neeraj.sanjaykale@nxp.com, sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com
Subject: Re: [PATCH v4 2/2] Bluetooth: btnxpuart: Add GPIO support to power
 save feature
Message-ID: <202410081424.BaGORAHw-lkp@intel.com>
References: <20241007131316.626690-3-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007131316.626690-3-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master robh/for-next linus/master v6.12-rc2 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/dt-bindings-net-bluetooth-nxp-Add-support-for-power-save-feature-using-GPIO/20241007-211315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20241007131316.626690-3-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v4 2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
config: x86_64-buildonly-randconfig-003-20241008 (https://download.01.org/0day-ci/archive/20241008/202410081424.BaGORAHw-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081424.BaGORAHw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081424.BaGORAHw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:445:7: error: expected ')'
     445 |                            PTR_ERR(psdata->h2c_ps_gpio));
         |                            ^
   drivers/bluetooth/btnxpuart.c:444:3: note: to match this '('
     444 |                 bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
         |                 ^
   include/net/bluetooth/bluetooth.h:278:2: note: expanded from macro 'bt_dev_err'
     278 |         BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |         ^
   include/net/bluetooth/bluetooth.h:263:32: note: expanded from macro 'BT_ERR'
     263 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                       ^
   1 error generated.


vim +445 drivers/bluetooth/btnxpuart.c

   434	
   435	static int ps_setup(struct hci_dev *hdev)
   436	{
   437		struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
   438		struct serdev_device *serdev = nxpdev->serdev;
   439		struct ps_data *psdata = &nxpdev->psdata;
   440	
   441		psdata->h2c_ps_gpio = devm_gpiod_get_optional(&serdev->dev, "device-wakeup",
   442							      GPIOD_OUT_LOW);
   443		if (IS_ERR(psdata->h2c_ps_gpio)) {
   444			bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
 > 445				   PTR_ERR(psdata->h2c_ps_gpio));
   446			return PTR_ERR(psdata->h2c_ps_gpio);
   447		}
   448	
   449		if (!psdata->h2c_ps_gpio)
   450			psdata->h2c_wakeup_gpio = 0xff;
   451	
   452		psdata->hdev = hdev;
   453		INIT_WORK(&psdata->work, ps_work_func);
   454		mutex_init(&psdata->ps_lock);
   455		timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
   456	
   457		return 0;
   458	}
   459	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

