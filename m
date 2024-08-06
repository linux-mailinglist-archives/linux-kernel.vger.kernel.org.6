Return-Path: <linux-kernel+bounces-275639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C209487E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FB21F2372E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48158AD0;
	Tue,  6 Aug 2024 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7esAOrm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDD43144
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722914472; cv=none; b=GXb8JYEkpehoo9KFulNkmbv/XghgVxWTg53GUv35lmuwpBNcArX6zS/yFdk4WMgoQ3fnxGcUAeK02vplqTpN8bsPfim1TwGkMP75r95IV/ZVmiGPJtOX7vnvLMFNIO8g+tbAPR633hHXDFQE2zfVe6SUwqtFr7LbfVRjVSrLd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722914472; c=relaxed/simple;
	bh=/PjDIgC1AdM+VFrKt5b8qgbE6p4BW8mIM3/GvNc2jLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyP6HoeO5rYd7d4yiWIwxHqf83CcrPFolA6j8/Z+GkWvwCCysTefhUgh/ziSyXBOmS8VNwFVOaCZSAaJHAd//V00Jx7wojyrJucvMYX/g8yfS1xnrzU6qHAFiTuI71bzy29UFR+3afuEpowMG/J+UlVFrecI3xwywMGncfh6jTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7esAOrm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722914470; x=1754450470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/PjDIgC1AdM+VFrKt5b8qgbE6p4BW8mIM3/GvNc2jLA=;
  b=X7esAOrm1sT7co3L6TCyGl24D4WIoOso0KU+x7qjpbqRL8DhCmPdZapy
   8Kl609lwK7keca+c0AMXnka6dEhQ24b/n8YrO+w2gzS8yre7SVwA7gVTW
   dIZNyx3rdPB9eoDGCWzDIdS8jwRhbLwWv7XtuRa6C4Cu7zmNamBlNfRre
   Ns5SVPz4C7Q366sOF2vdJfE1ky6UpjhwXSu/Hj02OcVY8S4k7trqX0WLE
   XkfURmeejiUUOSJQD9t2glFYMK8+7GAq2TrnGCLT+qHIMm4KnEFnylkRx
   qxHCGNRWkJ+dzjwjZRw2Gip79H3E9SPGwP7CbAToc2Ul0jJxkr3mitdm+
   Q==;
X-CSE-ConnectionGUID: 4qWwFwlPS8GLvJiY0H7o2w==
X-CSE-MsgGUID: b+TuEldGTUe+fpm4QHYt2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31482603"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="31482603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 20:21:10 -0700
X-CSE-ConnectionGUID: diVFB3BeS967P4LQ2q3yow==
X-CSE-MsgGUID: ewlVtK50QGOVPHfaFCRDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="87292940"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2024 20:21:07 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbAky-00046S-3A;
	Tue, 06 Aug 2024 03:21:04 +0000
Date: Tue, 6 Aug 2024 11:20:23 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.king@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>, rppt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md/raid6 algorithms: scale test duration for speedier
 boots
Message-ID: <202408061040.0kdEdUBV-lkp@intel.com>
References: <20240805170816.6025-1-colin.king@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805170816.6025-1-colin.king@intel.com>

Hi Colin,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.11-rc2 next-20240805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/md-raid6-algorithms-scale-test-duration-for-speedier-boots/20240806-012444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240805170816.6025-1-colin.king%40intel.com
patch subject: [PATCH] md/raid6 algorithms: scale test duration for speedier boots
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240806/202408061040.0kdEdUBV-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408061040.0kdEdUBV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408061040.0kdEdUBV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/asn1_decoder.o
>> ERROR: modpost: "__udivdi3" [lib/raid6/raid6_pq.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

