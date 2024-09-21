Return-Path: <linux-kernel+bounces-334901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C21497DE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4A4282765
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E686282F1;
	Sat, 21 Sep 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsVZvZqY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17131367;
	Sat, 21 Sep 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726940943; cv=none; b=EVurtuPeiT+xaNTcLe3/xPhQWD8bg4ot+l1ca73lUf8Z/LNr3TIs8kVRqcCkDLaihWyr4yBSA5ClCeTtx9j7NR4dueY8Vn17U7LHRld9y4mWZ5BfACWrt046SZSsBCZcObJnAntaUh0K1bm0CafzDKWLS1XAoN//KW7w5j17wvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726940943; c=relaxed/simple;
	bh=iD9bEdfUpajZR4FI7A07bRdvcrxIsFc3nwiOruFGQyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3PJve72vphE/r902uOnDX6k73yDBgOGnKne4rpovSM7oNKu9RbCnlm05PyUYi2CeXSnW+6i94j9HHCdAya/XZLwGL7Q9JWtvdjipaL87BpwDkKm3NJukr7BfVEM8b+UurMgPos8aV/R95IgDOgUL38lR8zYnK5iYdwWgeW/Urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsVZvZqY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726940942; x=1758476942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iD9bEdfUpajZR4FI7A07bRdvcrxIsFc3nwiOruFGQyM=;
  b=dsVZvZqYPz3DAV124XzwD13deAwuPkA8qRVIHTMvl//Q9clzSttvq6/i
   MleyXVjff6NDEZRnERI0K+YO/hs1PuC40J3yLZrX151r8X2/NaMbUyTa5
   7IrJ32cfHExmH6rWSjJ/SEbfjbg02XK6NWePIdsxdGEJWr+vtOyUYmVIn
   cE2QbspUV3plirojRWIKhwVpd04KZaCd26nxyPvsYQJSJ/iNVnFCMmayq
   uDSasuUBMa/9QOjzvXuBvvrqljRPCQwmFi+5ltQwhnqeZ0jwl3uB74vbw
   poNTklF/T+bOT91lhj0pzzlM6kC+GPi4rJz3Am4lOM+Cii4dUJjtkzc/e
   g==;
X-CSE-ConnectionGUID: PpxnyZXMSKO5RryIvaxoTw==
X-CSE-MsgGUID: oZEP3bMmS2232E4m5NoG9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29656844"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="29656844"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 10:49:01 -0700
X-CSE-ConnectionGUID: uoKcFNkPQm2g9f4YoKepsQ==
X-CSE-MsgGUID: l+qQnOaIQcixZAtO72XkeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="75184520"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2024 10:48:59 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss4E4-000Fed-2h;
	Sat, 21 Sep 2024 17:48:56 +0000
Date: Sun, 22 Sep 2024 01:48:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: Re: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
Message-ID: <202409220126.kUWmewio-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240918]
[also build test ERROR on v6.11]
[cannot apply to linus/master v6.11 v6.11-rc7 v6.11-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luke-D-Jones/platform-x86-asus-armoury-move-existing-tunings-to-asus-armoury-module/20240918-174540
base:   next-20240918
patch link:    https://lore.kernel.org/r/20240918094250.82430-2-luke%40ljones.dev
patch subject: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings to asus-armoury module
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240922/202409220126.kUWmewio-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220126.kUWmewio-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220126.kUWmewio-lkp@intel.com/

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/platform/x86/asus-armoury.c:161: warning: Function parameter or struct member 'attr' not described in 'attr_int_store'
>> drivers/platform/x86/asus-armoury.c:161: warning: Excess function parameter 'kobj_attribute' description in 'attr_int_store'
--
>> ERROR: modpost: module hid-asus uses symbol asus_wmi_evaluate_method from namespace ASUS_WMI, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

