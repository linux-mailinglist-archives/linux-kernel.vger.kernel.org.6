Return-Path: <linux-kernel+bounces-334949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F497DEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CCA1C20D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E7126C15;
	Sat, 21 Sep 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nECiQ2fJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D73D556;
	Sat, 21 Sep 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726949590; cv=none; b=u9xWKQ2f9TjQgRpBbxDOJL02lIeitYP477lJqrtU9VqawpKp88dPrHcqZ4b9lm00CiXEh9HdUqluwdo9W4xt5Oq6PMKPJdBpVI5Pod60jGIcGxX9HxTh+TYjhS/iomUa2tT4p364QhnDoLA6YsWFLk1u7dVWhSh+Dh7JCccyOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726949590; c=relaxed/simple;
	bh=2LaE7s9et2N14HjYXhT51Fsax+ENK9fdMBCkMpnqIMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw7tL5Dhv7mY2fuGbpZWSzrOqsF3mvs4NVp7tZ73gje0HIejtA/9rYJ2CnvqOierMMceqiWzQdCzGAU8D6qY1Piw1oH+7fXGwW0WpR4W2v4PqRBW/KPc5QPw5QYzBHnjQwPfge4GWHSkX8mnAg5EXTrgn4hG259jKh7cPkfSmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nECiQ2fJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726949588; x=1758485588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2LaE7s9et2N14HjYXhT51Fsax+ENK9fdMBCkMpnqIMk=;
  b=nECiQ2fJNEt8skXAK/phZUiANtQwO7+9numE9IltHSp+LGmaElNY3MLq
   buUGm3nJO7ftLUYbQc0eHUnjiwgNTEzqAaurYBSYgqfidvZZoulNOOE2a
   lKGVQVGE1WaVg1Ga8ZmvxU5m+2o1zFjJ9zVNuFSGY/vuyz2rCDur7ysBy
   /NvudSgajD1QayhJJMY4134ZFYJzK6LexIw8YZMoi6Q9gUh8ojVqSdALV
   QD+130Jpy4INDr5ckVuyOKv7UGLebOPUu6BQNp50A2eMgWzvWA/UOhUI7
   zGgXtX8Rciv985fZN09gIkEvjreTJH+52is7wAFBUln6V44mN9PVwGdqI
   Q==;
X-CSE-ConnectionGUID: apVP/CpeTQ+oiy9ARy+kXg==
X-CSE-MsgGUID: p3ZIkQhpRtSxKvDZaaTTNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25811087"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="25811087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 13:13:08 -0700
X-CSE-ConnectionGUID: pzAoklU8TtWXVWo/gxTbvw==
X-CSE-MsgGUID: O6pFFoutQwibYy9FjG/9TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="93985081"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Sep 2024 13:13:06 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss6TX-000FmQ-1j;
	Sat, 21 Sep 2024 20:13:03 +0000
Date: Sun, 22 Sep 2024 04:12:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com, "Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
Message-ID: <202409220341.XurF2eMb-lkp@intel.com>
References: <20240918094250.82430-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918094250.82430-2-luke@ljones.dev>

Hi Luke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240918]
[also build test WARNING on v6.11]
[cannot apply to linus/master v6.11 v6.11-rc7 v6.11-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/platform-x86-asus-armoury-move-existing-tunings-to-asus-armoury-module/20240918-174540
base:   next-20240918
patch link:    https://lore.kernel.org/r/20240918094250.82430-2-luke%40ljones.dev
patch subject: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings to asus-armoury module
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240922/202409220341.XurF2eMb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220341.XurF2eMb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220341.XurF2eMb-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: module hid-asus uses symbol asus_wmi_evaluate_method from namespace ASUS_WMI, but does not import it.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [m]:
   - TI_K3_M4_REMOTEPROC [=m] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

