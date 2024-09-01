Return-Path: <linux-kernel+bounces-310101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55A9674F6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51424B218A3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 04:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA73611E;
	Sun,  1 Sep 2024 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AekV2P/V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A21C36
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164553; cv=none; b=dPkmcDOV9pa3U4gaF2GlYlqxge8QSvrPoT3jn18gLn9l9Pd3P5MyNMCAenwmwa+gPLOkUoGoHpk1RG0ZMndW2pzNrT5oB+oKKyXCuW5rTacJarqeLW+2bvlpjZ2xet92y3TOp/47RBKpO9kxTJ2LQfWbQowDMuQrovpEyZXbnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164553; c=relaxed/simple;
	bh=Qxqj+rv1d4zq51Gxn0cvjyHc8r4K1rFAuGjdoH27wx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwgbnPEv5BtTaqWz8DtMBN0L6LLR25y2qcZF/j7MPaTHz0RVxJDk1VVA0uV+09i9eFwSp/dRcTLYanvWQmn22ZSKw5iIbQdsJGOkQQds97f9MZyKpI3rXNEYiMRA0r1psNpcxK0DBuUkRBLzn3H1I+WYHd4ngd2Ar/j7vmsPne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AekV2P/V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164552; x=1756700552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qxqj+rv1d4zq51Gxn0cvjyHc8r4K1rFAuGjdoH27wx4=;
  b=AekV2P/VJBsiqukrw5kplkYCVDdRQGubirq8hklPnBEjpxWsuwcc3zxv
   n43vgydPGbD+eWUaW78eKQXwtbCRAy8754KsubcKNjTXxR+gworLcs8Js
   /zZ+ftAtAyvej41e46nLqI41vGTNWXjphOyi0iDi0PIFvaIn9VosF2+hS
   Uy18b4tWzcfQs2f7k4VPAB3mbZP0vSWjQDYbTMoFWnT/7HSttXgS5TuGe
   J1iHIjXhOIBXc78gob1e1xVyfLTl8+eL159Is/e/Q2OhRlq1W26u8hMth
   rLIAYGN0UTOngx65wtKP0HnUgCx/vnuE1VJk9eBt3kZzG9irjt9THV5u0
   Q==;
X-CSE-ConnectionGUID: A9A/wFO3RHuY5oOn4IOzEw==
X-CSE-MsgGUID: abAzaLB4Sn+WO7kB6oW6hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="13315007"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="13315007"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:22:31 -0700
X-CSE-ConnectionGUID: 2c6Bn+TWRHS33KspFmHVyA==
X-CSE-MsgGUID: yyrrrBJnTqSzOVVnLbJcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64450679"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 31 Aug 2024 21:22:30 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skc6e-0003Oo-02;
	Sun, 01 Sep 2024 04:22:28 +0000
Date: Sun, 1 Sep 2024 12:21:35 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Palmer <daniel@0x0f.com>, linux-m68k@lists.linux-m68k.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	geert@linux-m68k.org, gerg@linux-m68k.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH] m68k/mvme147: Fix console for mvme147
Message-ID: <202409011229.VWSluBzx-lkp@intel.com>
References: <20240831173802.2805586-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831173802.2805586-1-daniel@0x0f.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on geert-m68k/for-next]
[also build test WARNING on geert-m68k/for-linus gerg-m68knommu/for-next linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Palmer/m68k-mvme147-Fix-console-for-mvme147/20240901-014003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
patch link:    https://lore.kernel.org/r/20240831173802.2805586-1-daniel%400x0f.com
patch subject: [PATCH] m68k/mvme147: Fix console for mvme147
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240901/202409011229.VWSluBzx-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409011229.VWSluBzx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409011229.VWSluBzx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/m68k/mvme147/config.c: In function 'scc_delay':
>> arch/m68k/mvme147/config.c:193:22: warning: variable 'trash' set but not used [-Wunused-but-set-variable]
     193 |         volatile int trash;
         |                      ^~~~~


vim +/trash +193 arch/m68k/mvme147/config.c

   189	
   190	static void scc_delay(void)
   191	{
   192		int n;
 > 193		volatile int trash;
   194	
   195		for (n = 0; n < 20; n++)
   196			trash = n;
   197	}
   198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

