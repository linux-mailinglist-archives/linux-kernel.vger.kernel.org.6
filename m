Return-Path: <linux-kernel+bounces-201380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666768FBDCF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BFCB21943
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63814B97F;
	Tue,  4 Jun 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLkCkvHC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C99140375
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535418; cv=none; b=D/HyrwVXu2i/vcJAIdK3GGLE0bwu3WNYtX57L1IPJXXH9AYiP+sZmIk3IGsl67X4XmMXfR0pQXx3sksIcX29D7S5ZNXupUtn/80M7XRCRQNXPAostSRcrTq5lidLfLAksrY/bOquwVZA3AcKxMlu3LRp8lok8uEaVJ0CtJ/zVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535418; c=relaxed/simple;
	bh=wMcjoHRFalaPepGrkEF80MaAt0Fbocc34Crnd/5hGY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRbm5+A3xrvWUSgRYsE7K181LFCGsQN/Zft2v1dpOpzfU2sY8VhiLBsvIxce3o8Uddz3TB5eoeKo3JXYnA9xD0MkZwbyQHl2ODoy2db5eRMcnAgejZdzKqiMxbG5NgLpjqTLvvg2VG2PuUMJrb0+wptwn7LHYXz/YVQ3VCXnImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLkCkvHC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717535416; x=1749071416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wMcjoHRFalaPepGrkEF80MaAt0Fbocc34Crnd/5hGY0=;
  b=YLkCkvHCaJCnrJW3HCQBBlOo6O3bo/rkoM4SCkI9G5H85jrdC9h4iO/X
   QuED8x17jpaH2auuoGZ48PHcoPWxyZPBGBtwy+ymOKEvj9SOKzAzUfK7n
   JPAuJ/6SSCBmjj+HCkb4HfwXQae8fKZZnUgSaxvX6h5eZ6DZ7YmUC5wKF
   +ccoTVvnKGGSBrYDIRyt3B7cWXzIBWbSHBaf9BHUHfJ7t/zaGfxPDSIQc
   g9G1lqlcKnK4bneVfgQwfGRqCTvXDQwPnlf6OZKG7uIbS87WMFZKlVt29
   PpYCRi7DXavtNCozGuZyUTHLvMFgY93KNUS8ysRdz02hEbqG/WPg9Ch3t
   A==;
X-CSE-ConnectionGUID: NLIdkrq4R6uHd8KBDIPudQ==
X-CSE-MsgGUID: 33FkBCDKT6OPGlUymvvGzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13995108"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13995108"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:10:15 -0700
X-CSE-ConnectionGUID: 4koSPkksQYC4AwyFvAAHHw==
X-CSE-MsgGUID: /NonjfLjTLmED9PsnAhs5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41796047"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Jun 2024 14:10:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEbQ2-0000XL-36;
	Tue, 04 Jun 2024 21:10:10 +0000
Date: Wed, 5 Jun 2024 05:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com,
	zhangpeng.00@bytedance.com, willy@infradead.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH 04/18] maple_tree: introduce mas_wr_store_type()
Message-ID: <202406050440.xjLxhyu5-lkp@intel.com>
References: <20240604174145.563900-5-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604174145.563900-5-sidhartha.kumar@oracle.com>

Hi Sidhartha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-store_type-enum/20240605-014633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240604174145.563900-5-sidhartha.kumar%40oracle.com
patch subject: [PATCH 04/18] maple_tree: introduce mas_wr_store_type()
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240605/202406050440.xjLxhyu5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050440.xjLxhyu5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050440.xjLxhyu5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/maple_tree.c:4289: warning: Function parameter or struct member 'entry' not described in 'mas_prealloc_calc'


vim +4289 lib/maple_tree.c

  4280	
  4281	/**
  4282	 * mas_prealloc_calc() - Calculate number of nodes needed for a
  4283	 * given store oepration
  4284	 * @mas: The maple state.
  4285	 *
  4286	 * Return: Number of nodes required for preallocation.
  4287	 */
  4288	static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
> 4289	{
  4290		int ret = mas_mt_height(mas) * 3 + 1;
  4291	
  4292		switch (mas->store_type) {
  4293		case wr_invalid:
  4294			WARN_ON_ONCE(1);
  4295			break;
  4296		case wr_new_root:
  4297			ret = 1;
  4298			break;
  4299		case wr_store_root:
  4300			if (likely((mas->last != 0) || (mas->index != 0)))
  4301				ret = 1;
  4302			else if (((unsigned long) (entry) & 3) == 2)
  4303				ret = 1;
  4304			else
  4305				ret = 0;
  4306			break;
  4307		case wr_spanning_store:
  4308			ret =  mas_mt_height(mas) * 3 + 1;
  4309			break;
  4310		case wr_split_store:
  4311			ret =  mas_mt_height(mas) * 2 + 1;
  4312			break;
  4313		case wr_rebalance:
  4314			ret =  mas_mt_height(mas) * 2 - 1;
  4315			break;
  4316		case wr_node_store:
  4317		case wr_bnode:
  4318			ret = mt_in_rcu(mas->tree) ? 1 : 0;
  4319			break;
  4320		case wr_append:
  4321		case wr_exact_fit:
  4322		case wr_slot_store:
  4323			ret = 0;
  4324		}
  4325	
  4326		return ret;
  4327	}
  4328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

