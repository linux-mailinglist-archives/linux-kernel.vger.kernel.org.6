Return-Path: <linux-kernel+bounces-275666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0596194882E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA481F2362B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A83D1BA86F;
	Tue,  6 Aug 2024 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApeAfzvJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86723A59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916893; cv=none; b=FNFpoadJDo77nFYcqhJNa+fJZcOG/1j7ku7XerhxTdV9Nf52sEBi0OWju5UOMyxKdkaBV03uDJTOixamLbQA1hn1R+iVtWrLoD5H1o+Ko7kWDgj41ijbK429/HSNX3cG12983I8qPwCp8hYxyyGlN2gvjNHsCkbgFvF7YV5whzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916893; c=relaxed/simple;
	bh=bQljSxJ2RUAUbiQdmt6RLKydgzSPunXZEZNiHSFu/T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNddTyR5XXe3DqdAuM+KjDL+9tY8hTp0AHBfgBMUrTr6RnOU09ftAXoOk0nu2MFHTqzu0GKxrAjLhP10VRU3rSapWaq67VwAvEq+YSqREU4fY33HN43gMXYJ3VShSHnPNeeGD5N50B5SY6AMSz0jlxDiFliAOpsO0K0rgJw2oVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApeAfzvJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722916890; x=1754452890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bQljSxJ2RUAUbiQdmt6RLKydgzSPunXZEZNiHSFu/T4=;
  b=ApeAfzvJgqTdz+cDzgpCVxUlR+eJYB6GHCDOrAHI3Y+SNWt0RYiGfZ9c
   YgHHJv0UtdHyQqhVGjKcDuJu12E/6y7gox5Cu6+mSD818Ss3CIUlxwma3
   rEHrpdWrKeJNoBgAkcqgLz5wK3Fdthg81sUsD9Xa3FzpcAaqMkl3F7q6G
   +mrxvXee+vBw2JgZoTq3+lFZ6/Rb+fIbxeP8fgR3dBe4QgziDbQ/XlW/e
   lnF1G8LeCXnhjs/7g626eNftk5zX7YKCdc9Dr9qbPqPwErWlxtkyEuF3S
   EDjvRdRtl8Zj0gH9kNqf296LMtGhPNyXx8c62Vp+TvxoymyU1AZXEQHXw
   Q==;
X-CSE-ConnectionGUID: 1yZbf6d/R3K1fr/qmqmqFQ==
X-CSE-MsgGUID: rTPIGTIgRQWbab0y2vMzow==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21075929"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="21075929"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 21:01:30 -0700
X-CSE-ConnectionGUID: ntySP9SaS8mhpTsYtpkP3w==
X-CSE-MsgGUID: +u032/d9S7CQKk8VD0ZtNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="61004061"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Aug 2024 21:01:28 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbBO1-000480-2o;
	Tue, 06 Aug 2024 04:01:25 +0000
Date: Tue, 6 Aug 2024 12:01:02 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.king@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>, rppt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md/raid6 algorithms: scale test duration for speedier
 boots
Message-ID: <202408061134.O5o8RpVV-lkp@intel.com>
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
config: i386-buildonly-randconfig-002-20240806 (https://download.01.org/0day-ci/archive/20240806/202408061134.O5o8RpVV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408061134.O5o8RpVV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408061134.O5o8RpVV-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: lib/raid6/algos.o: in function `raid6_choose_gen.constprop.0':
>> algos.c:(.text+0xe6): undefined reference to `__udivdi3'
>> ld: algos.c:(.text+0x163): undefined reference to `__udivdi3'
   ld: algos.c:(.text+0x1fd): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

