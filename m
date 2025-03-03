Return-Path: <linux-kernel+bounces-540829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E810A4B593
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E3B7A65EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D9182B4;
	Mon,  3 Mar 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGOT6nDg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4823BE;
	Mon,  3 Mar 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740960536; cv=none; b=k7z6wBW1fBu6ZxGiXea0BdSR7dkTY8uijpKk8giQqo6mmRWHtaQUrHQVCUi6qNjGVDw3Dd84qSdDfoi6iZJOFYSXCqkVwZujxjYXJfYQzkONPsJk0JMvib+id4hNgNGht5LxO0w3/pXHOG8iKK3t40prFFC/FQO4QoA14pXUiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740960536; c=relaxed/simple;
	bh=iFhsPwDQntSzhdX0WmnxmE0NteARrQ2q8k6MdRciiCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfjJ/bOu+uzbmtcUgtbsYOenpVk0edFU91PL1htaGNuBKf9PK7pponUxVP14DJm0QW0sxQx5HadHJ1BXEQTk5fmEtvFbLlZ0KHujTUkyeui7FPl7MmZCor9oZ+JeTeU+TemndlZtAqez9NQa+rgEEi+OM468V6G30Sta5szljGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGOT6nDg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740960534; x=1772496534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iFhsPwDQntSzhdX0WmnxmE0NteARrQ2q8k6MdRciiCI=;
  b=DGOT6nDgaXXhsf/0oF0h+RRchXxXzaaeuHFmy6Iq93DZuhOl+DkNzgrI
   UGUsC0WmmLeNkn8ugEw4ac9pO8UdjKPcxI3gsfssTbahT7x/wBQlDZtbw
   wCMJx/p7UgSyiED0x0xqST7V6xx8wslbDqJgLxKw34nJmD3Vdsgz2NDN7
   MM7DMXuBEI/zLzloGr1lIYiZ6eTSPJ9AmThKsDOtlkUt5PI2YwFr2iqc8
   Y6vcnDtMgJ1f5jSxZZVfOVkj0M2X20eSA4eao4ZDtEeURPC+r28BT1B9m
   PayDbI5QuTciEA0zioxCIqOOdVrpnUK2EZ6e+7KixVm4EnV86rjvRuSnp
   w==;
X-CSE-ConnectionGUID: ri3BVJfeTUSNVcfH3pgHfA==
X-CSE-MsgGUID: b+jVGD25SHCLYl7YwUMU1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="52466970"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="52466970"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 16:08:53 -0800
X-CSE-ConnectionGUID: VdOYXJjmS8e5WCQAA6ES7g==
X-CSE-MsgGUID: E2N4braMTYe1lfyfc0IiNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148763664"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 02 Mar 2025 16:08:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1totMT-000Hk2-28;
	Mon, 03 Mar 2025 00:08:45 +0000
Date: Mon, 3 Mar 2025 08:08:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Cody T . -H . Chiu" <codyit@gmail.com>,
	John Martens <johnfanv2@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] platform/x86: Add Lenovo Other Mode WMI Driver
Message-ID: <202503030756.aT75o80n-lkp@intel.com>
References: <20250225220037.16073-5-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225220037.16073-5-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.14-rc5 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-Add-lenovo-wmi-drivers-Documentation/20250226-060548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250225220037.16073-5-derekjohn.clark%40gmail.com
patch subject: [PATCH v3 4/4] platform/x86: Add Lenovo Other Mode WMI Driver
config: x86_64-randconfig-003-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030756.aT75o80n-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030756.aT75o80n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503030756.aT75o80n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/platform/x86/lenovo-wmi.c:20:
>> drivers/platform/x86/lenovo-wmi.h:21: warning: "pr_fmt" redefined
      21 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         | 
   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/jump_label.h:258,
                    from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/paravirt_types.h:12,
                    from arch/x86/include/asm/ptrace.h:175,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/wmi.h:11,
                    from drivers/platform/x86/lenovo-wmi.c:19:
   include/linux/printk.h:391: note: this is the location of the previous definition
     391 | #define pr_fmt(fmt) fmt
         | 
--
   In file included from drivers/platform/x86/lenovo-wmi-other.c:28:
>> drivers/platform/x86/lenovo-wmi.h:21: warning: "pr_fmt" redefined
      21 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         | 
   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/jump_label.h:258,
                    from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/paravirt_types.h:12,
                    from arch/x86/include/asm/ptrace.h:175,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/x86/lenovo-wmi-other.c:23:
   include/linux/printk.h:391: note: this is the location of the previous definition
     391 | #define pr_fmt(fmt) fmt
         | 
   In file included from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:1475,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16:
   drivers/platform/x86/lenovo-wmi-other.c: In function 'lenovo_wmi_om_notifier':
>> include/linux/notifier.h:188:33: warning: statement with no effect [-Wunused-value]
     188 | #define NOTIFY_BAD              (NOTIFY_STOP_MASK|0x0002)
         |                                 ^
   drivers/platform/x86/lenovo-wmi-other.c:435:17: note: in expansion of macro 'NOTIFY_BAD'
     435 |                 NOTIFY_BAD;
         |                 ^~~~~~~~~~
   include/linux/notifier.h:186:33: warning: statement with no effect [-Wunused-value]
     186 | #define NOTIFY_OK               0x0001          /* Suits me */
         |                                 ^~~~~~
   drivers/platform/x86/lenovo-wmi-other.c:438:17: note: in expansion of macro 'NOTIFY_OK'
     438 |                 NOTIFY_OK;
         |                 ^~~~~~~~~


vim +/pr_fmt +21 drivers/platform/x86/lenovo-wmi.h

cff13e10214613 Derek J. Clark 2025-02-25  20  
cff13e10214613 Derek J. Clark 2025-02-25 @21  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
cff13e10214613 Derek J. Clark 2025-02-25  22  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

