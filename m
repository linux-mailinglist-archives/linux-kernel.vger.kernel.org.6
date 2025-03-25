Return-Path: <linux-kernel+bounces-574731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF027A6E939
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F6A3A847D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089A1A3150;
	Tue, 25 Mar 2025 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOCRFbnc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2F1799F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742879441; cv=none; b=d+RZ1z8v/bV+p54To8E2JjbSBgxjrg5H957xKU4IZAzvXpXyiGKfwwC3G2xZDiv9sNuZ6DlAA5+RKkfqGkx0DW4B7quWhi3mv2TFTEIA/dBZah68r3oGgKM7GjEbHYr9XS2tUT8NweMtb+1pTwvHHQ2xUOSDfVQG2U6VkoaFqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742879441; c=relaxed/simple;
	bh=VnUA6qIlV4kct3J+c72cj1s/FHG99gtx+RYfaqOo84U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cf6mWgpiVxyXRCnbT1C2yrdmHb4JE/abu2cznzE45NhMwcPzNkmBvnLoyq0TH47d/4FzwC3PJAofJMMrlQdM8Anb4AkAz2Vx6BtqWymLllOkiripefX1/n0kRyTZfdL+aspGEAnYuAm8/IVrhnF0wZhbqKW+lZDecV2SO9YBlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOCRFbnc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742879438; x=1774415438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VnUA6qIlV4kct3J+c72cj1s/FHG99gtx+RYfaqOo84U=;
  b=lOCRFbncFvdcPOOkle9I8nfgY26LP4cdO3wYOVzrfJp5x1EOfAE7vtwx
   JJsR3VTzl/JZsfotKS5bO/+CodZi0py1pPC9wjquzVijS38eQEs5mgqYW
   PIEHAeO5c1P+1pCJuV8YqD2ln/9ucByFpzp8LIJs/lxwp4UCowk5ykaTP
   HGGTz+VyGasdgNJREUuZ2cEAJSGv3YjGHS5zh/zUvuzxJ2f84kskzELmQ
   eCs/hp99x2VX18V3pJ7N2lJeILwnWf+YkTDq22vDt2hPXIHeXEwPPe5qD
   5Tzj6PgKW4VEO7FZa8dKpsAXTCO4HS5SrnBgUWqizI62outdYXzH16vOI
   A==;
X-CSE-ConnectionGUID: c7V0K2NHTICxvz2+KcJJKw==
X-CSE-MsgGUID: nfR6JeCtSXGs8m9PIDleRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43998742"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="43998742"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 22:10:38 -0700
X-CSE-ConnectionGUID: fzy5ybNoTC+n+S5BolDjpA==
X-CSE-MsgGUID: j1CQXVlFSXSuzYTDJ41ONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="155276519"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 Mar 2025 22:10:36 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twwYT-00049j-1s;
	Tue, 25 Mar 2025 05:10:27 +0000
Date: Tue, 25 Mar 2025 13:09:42 +0800
From: kernel test robot <lkp@intel.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: <stdin>:4:15: error: 'cmpxchg8b_emu' undeclared here (not in a
 function)
Message-ID: <202503251216.lE4t9Ikj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f2d529458523f6d889a926623f4ddc7de4df063
commit: 9c3681f9b9fd12cdbc4a542df599f1837512f3d5 kbuild: Add gendwarfksyms as an alternative to genksyms
date:   2 months ago
config: um-randconfig-r123-20250325 (https://download.01.org/0day-ci/archive/20250325/202503251216.lE4t9Ikj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250325/202503251216.lE4t9Ikj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503251216.lE4t9Ikj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from <stdin>:1:
>> <stdin>:4:15: error: 'cmpxchg8b_emu' undeclared here (not in a function)
   include/linux/export.h:70:23: note: in definition of macro '__EXPORT_SYMBOL'
      70 |         extern typeof(sym) sym;                                 \
         |                       ^~~
   include/linux/export.h:83:41: note: in expansion of macro '_EXPORT_SYMBOL'
      83 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   <stdin>:4:1: note: in expansion of macro 'EXPORT_SYMBOL'
--
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from <stdin>:1:
>> <stdin>:4:15: error: 'csum_partial' undeclared here (not in a function)
   include/linux/export.h:70:23: note: in definition of macro '__EXPORT_SYMBOL'
      70 |         extern typeof(sym) sym;                                 \
         |                       ^~~
   include/linux/export.h:83:41: note: in expansion of macro '_EXPORT_SYMBOL'
      83 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   <stdin>:4:1: note: in expansion of macro 'EXPORT_SYMBOL'
>> <stdin>:5:15: error: 'csum_partial_copy_generic' undeclared here (not in a function)
   include/linux/export.h:70:23: note: in definition of macro '__EXPORT_SYMBOL'
      70 |         extern typeof(sym) sym;                                 \
         |                       ^~~
   include/linux/export.h:83:41: note: in expansion of macro '_EXPORT_SYMBOL'
      83 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   <stdin>:5:1: note: in expansion of macro 'EXPORT_SYMBOL'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

