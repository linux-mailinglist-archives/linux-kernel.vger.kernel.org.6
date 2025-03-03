Return-Path: <linux-kernel+bounces-540971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80A4A4B712
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79FF16CA2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E251D86DC;
	Mon,  3 Mar 2025 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaD08hZJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24014D29B;
	Mon,  3 Mar 2025 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974659; cv=none; b=sOa0QuKA/GV4Jsxga0Q5TfWQ6WkRbNE0BJKxeMwky9YdHyltqdaSZda7gs5x6gOp9Qo7fRbmXXfnhUg5x2q86DYDjdn2j5jW51dwqqPFVebx33JO81yHbY4ZsLNEBG0jvcxbPTKwuslb/GwtLB1VUZh6QKM61+Glp6IrUyUCGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974659; c=relaxed/simple;
	bh=xTmsFFTPMW7yzBZ6opQWKAOUqr75ygkyYcYdzns8jNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax8qypq/z/kgjyaUYQkz8Wis4haD+4ulSp7LRdCME0gnEQlyzgkVnlcsR4JikSzFGMfJ58EmrNQ4b+rz9s9FgjQE7ds8ya1kVg5DuSzxgycu2M6SZElGzeS0RDGjei6OY7OQwPjsdb0lmvophTJqHJ+AYmai+LQnONRA3ooDTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaD08hZJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740974658; x=1772510658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xTmsFFTPMW7yzBZ6opQWKAOUqr75ygkyYcYdzns8jNc=;
  b=eaD08hZJJv7CzvjouPfDJfyolXEb4yLzAp/NoMrZ8T4SSnjYDBovpNe5
   ocUtqI6lwPq6RGq5xOxBfRheQ8qjRA89uabwrFXQiRw4el8hKrqd+8F0N
   ebpEXHwRkx346TZul+aVTogT/xELmso1wfwwjptkBQpolYnnUe9G5IXv/
   nOxp3Dhi3RcT/PWgGO3in7XqZVImYcHCjDhwJf1uew/1xyVLwGV6lOJg4
   9hmSkXfa7Zp1Gz2zBTYDx+KPWZo5MRXu166jo1ajHLoi3RPBn/wOy8w5M
   XRPf/wmEY+z0GjX9Wb4b3RMVAIUXZZ/FlJeKaSVhpfAGtYSsCenaPsqpQ
   A==;
X-CSE-ConnectionGUID: c+r2fDmuSAGnJibMQ8mfCA==
X-CSE-MsgGUID: dm0RmKgnQqSZEOjiv/OD9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41685669"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="41685669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 20:04:17 -0800
X-CSE-ConnectionGUID: xzikrXRvS8urZUNFUpH6Og==
X-CSE-MsgGUID: tAMCDCDwQs6CqFpdO85Eow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148796755"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 02 Mar 2025 20:04:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tox1f-000Hv1-2t;
	Mon, 03 Mar 2025 04:03:46 +0000
Date: Mon, 3 Mar 2025 12:03:10 +0800
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
Subject: Re: [PATCH v3 2/4] platform/x86: Add Lenovo Gamezone WMI Driver
Message-ID: <202503031157.JXItpvLX-lkp@intel.com>
References: <20250225220037.16073-3-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225220037.16073-3-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.14-rc5 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-Add-lenovo-wmi-drivers-Documentation/20250226-060548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250225220037.16073-3-derekjohn.clark%40gmail.com
patch subject: [PATCH v3 2/4] platform/x86: Add Lenovo Gamezone WMI Driver
config: x86_64-randconfig-101-20250303 (https://download.01.org/0day-ci/archive/20250303/202503031157.JXItpvLX-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503031157.JXItpvLX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503031157.JXItpvLX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/platform/x86/lenovo-wmi.c:20:
>> drivers/platform/x86/lenovo-wmi.h:21:9: warning: 'pr_fmt' macro redefined [-Wmacro-redefined]
      21 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         |         ^
   include/linux/printk.h:391:9: note: previous definition is here
     391 | #define pr_fmt(fmt) fmt
         |         ^
   1 warning generated.
--
   In file included from drivers/platform/x86/lenovo-wmi-gamezone.c:20:
>> drivers/platform/x86/lenovo-wmi.h:21:9: warning: 'pr_fmt' macro redefined [-Wmacro-redefined]
      21 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
         |         ^
   include/linux/printk.h:391:9: note: previous definition is here
     391 | #define pr_fmt(fmt) fmt
         |         ^
>> drivers/platform/x86/lenovo-wmi-gamezone.c:205:31: warning: unused variable 'profile' [-Wunused-variable]
     205 |         enum platform_profile_option profile;
         |                                      ^~~~~~~
   2 warnings generated.


vim +/pr_fmt +21 drivers/platform/x86/lenovo-wmi.h

    20	
  > 21	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

