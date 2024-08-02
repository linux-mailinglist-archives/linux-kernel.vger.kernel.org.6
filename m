Return-Path: <linux-kernel+bounces-273150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD69464FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6573EB222BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A86E5ED;
	Fri,  2 Aug 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kz/DDc3r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADD54657
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633751; cv=none; b=E4Sg2WUdnp5n46gS52MxrXR0KRiKIzn4T8nU//DHYIiHp2K5WxKF6g1PntuT0mvzGjHIqBUiY2Orm3aw2WQ3BbYTuW3b1kXMEdf2zs0z4VbiiiE/m/zwSG/PnQ7LH171fpwgJePJj3lWuW+Cux6SbtUB7xWut5BjLpCJDk5GU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633751; c=relaxed/simple;
	bh=68g9t3xwE/x8Utm3R0R2KDyytx3UwsMziaDerOfK+hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN5wnwQ0YF1R/NXybZXcdHdI7DQFGBJUprnf9aYoYxtImCMAQaSW6hINb8/bwHgdLI+pIMaTa8/T0v/XXD8QhyZJs9k77dbiVX+qUYZRZb08LInXqvU9QimKwe8r/P1ko++9VrP3kmt+oXOh7PzkbZ/eUWT+Yr2UGJP4enniNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kz/DDc3r; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722633749; x=1754169749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=68g9t3xwE/x8Utm3R0R2KDyytx3UwsMziaDerOfK+hE=;
  b=Kz/DDc3r/ZaYMp1v+BCzyFr6HUfu2SnLBmuRxI8VSZeKQ7FJsVqakxzy
   Y/ZBSmtYIZJuNUz2TjovsZBMRk0/QQQ8lqcYBC7zH/0X2JFd64yGYn9Ci
   WKXJ6K421q6U5lyv3fBMuBlnUEvuoTEso1zjbwcSFPBv0U7O6b1yE9Fi2
   IOuHbePFqcPZWgmi8PNx9EDDaeYA98WKZ39efcuzi4QSFKifFfKPYBLPa
   o6r42JEm872zCA6ew5tz9e6wES7h7DPfLtuBAXf2QFcXlpdAvmySSwd91
   ygxNwKvWQvuBxdQ3d1USsy6qRN7eMvFC9SC09wGGqH/u9yrioRKXnpxeX
   g==;
X-CSE-ConnectionGUID: olnECWKZSyuVnUCLHwfoew==
X-CSE-MsgGUID: CUcKAGEPQOKdSr3Y1mtCVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20787207"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20787207"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:22:28 -0700
X-CSE-ConnectionGUID: HtIKt9R6QRK4jLykuPHEbQ==
X-CSE-MsgGUID: Ei855qBCRBK+yYArkRHdsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55409890"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Aug 2024 14:22:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZzjC-000xRg-2H;
	Fri, 02 Aug 2024 21:22:22 +0000
Date: Sat, 3 Aug 2024 05:22:02 +0800
From: kernel test robot <lkp@intel.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V2 2/3] riscv: mm: Add soft-dirty page tracking support
Message-ID: <202408030546.nd9jmMe3-lkp@intel.com>
References: <20240731040444.3384790-3-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731040444.3384790-3-zhangchunyan@iscas.ac.cn>

Hi Chunyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunyan-Zhang/riscv-mm-Prepare-for-reuse-PTE-RSW-bit-9/20240801-231628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240731040444.3384790-3-zhangchunyan%40iscas.ac.cn
patch subject: [PATCH V2 2/3] riscv: mm: Add soft-dirty page tracking support
config: riscv-kismet-CONFIG_PROC_PAGE_MONITOR-CONFIG_MEM_SOFT_DIRTY-0-0 (https://download.01.org/0day-ci/archive/20240803/202408030546.nd9jmMe3-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240803/202408030546.nd9jmMe3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030546.nd9jmMe3-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PROC_PAGE_MONITOR when selected by MEM_SOFT_DIRTY
   WARNING: unmet direct dependencies detected for PROC_PAGE_MONITOR
     Depends on [n]: PROC_FS [=y] && MMU [=n]
     Selected by [y]:
     - MEM_SOFT_DIRTY [=y] && CHECKPOINT_RESTORE [=y] && HAVE_ARCH_SOFT_DIRTY [=y] && PROC_FS [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

