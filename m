Return-Path: <linux-kernel+bounces-201433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710B8FBE79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D694D1F24709
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798B13791C;
	Tue,  4 Jun 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L35xg0zI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9A320C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538605; cv=none; b=KUCreo8R5kn/mcBKXk0SOSyPh3R1PVl7XS/z4p+JKMNHIFFQ0wdcT76ytO16h0/2VbjuHW9oXEqtZbNPLyAwY1nXdu/mIOQ6JXe5XUM4s+AoFRMeoSXVq2xi+jRBX0+LSqwAO19sK98/1/T24xiLrsYlz60HfZlKgTkZCv0MdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538605; c=relaxed/simple;
	bh=CdweWsBT2h3TnPIPbtdmDLzScqzZs1E5mhA5mOqMskA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgk7NaYA14CfGbnR5TDc9LP85m+uDPWSWwnsvEJbFtrYBypIDUjHV28tOfb5rBDUk+AWgGeshSMQxgK5C9bANPf/ZWyqE2pM1jYJiT3iZfZGpJIYMafi3zuSNV0MlurmQXRr/Pa9AR0GKPPWPIwh9mpyc0bgiROYij0IvXBqTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L35xg0zI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717538603; x=1749074603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CdweWsBT2h3TnPIPbtdmDLzScqzZs1E5mhA5mOqMskA=;
  b=L35xg0zIjw7O/7qrab+Jwcmpa5FonxJ1P716NppPmnkrpG4OOHObVdT+
   OEmq6llk8hyemgdAMqNA7G+KYgGRVqhjTWnwKf5ySn4cXqXhwxLFi+GMn
   r4WVsuqtMOfhBrv3wmM+gBwKb/Q4fbbSh+ZE7TdtOa9NQYLeMv02Szhwx
   3cwut2OJG5G0IBERkA60MSa6S36SA/SRbi7XAfc4oemFEcKpC24Vbnk0T
   NcKL1c+RlnUeYb05k1X/APREVyxdAb/BrnUG73dHsx6E1upIoszGuKjYW
   frXe/ic9rVvHhDu1V80RquGE/pAv5rYPRoCpsTSRvaykw7CWnsvNqgBmP
   g==;
X-CSE-ConnectionGUID: e2eWYbSKSDqkNWHfCRwL2A==
X-CSE-MsgGUID: p8oQHifiSKeSxqbkZ+iOow==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11907375"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="11907375"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:03:23 -0700
X-CSE-ConnectionGUID: tCXYFfx6QmiRxhYBhHZCkA==
X-CSE-MsgGUID: kROVTUFBQT2qeMExz84iYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41801343"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Jun 2024 15:03:20 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEcFR-0000al-30;
	Tue, 04 Jun 2024 22:03:17 +0000
Date: Wed, 5 Jun 2024 06:02:33 +0800
From: kernel test robot <lkp@intel.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	akpm@linux-foundation.org, liam.howlett@oracle.com,
	zhangpeng.00@bytedance.com, willy@infradead.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH 11/18] maple_tree: use store type in mas_wr_store_entry()
Message-ID: <202406050515.BP3o0Meg-lkp@intel.com>
References: <20240604174145.563900-12-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604174145.563900-12-sidhartha.kumar@oracle.com>

Hi Sidhartha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-store_type-enum/20240605-014633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240604174145.563900-12-sidhartha.kumar%40oracle.com
patch subject: [PATCH 11/18] maple_tree: use store type in mas_wr_store_entry()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240605/202406050515.BP3o0Meg-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050515.BP3o0Meg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050515.BP3o0Meg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:351:21: warning: unused function 'mte_set_full' [-Wunused-function]
     351 | static inline void *mte_set_full(const struct maple_enode *node)
         |                     ^~~~~~~~~~~~
   lib/maple_tree.c:356:21: warning: unused function 'mte_clear_full' [-Wunused-function]
     356 | static inline void *mte_clear_full(const struct maple_enode *node)
         |                     ^~~~~~~~~~~~~~
   lib/maple_tree.c:361:20: warning: unused function 'mte_has_null' [-Wunused-function]
     361 | static inline bool mte_has_null(const struct maple_enode *node)
         |                    ^~~~~~~~~~~~
>> lib/maple_tree.c:4206:21: warning: stack frame size (1032) exceeds limit (1024) in 'mas_wr_store_entry' [-Wframe-larger-than]
    4206 | static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
         |                     ^
   lib/maple_tree.c:4151:13: warning: stack frame size (1048) exceeds limit (1024) in 'mas_wr_bnode' [-Wframe-larger-than]
    4151 | static void mas_wr_bnode(struct ma_wr_state *wr_mas)
         |             ^
   5 warnings generated.


vim +/mas_wr_store_entry +4206 lib/maple_tree.c

54a611b605901c Liam R. Howlett 2022-09-06  4198  
54a611b605901c Liam R. Howlett 2022-09-06  4199  /*
54a611b605901c Liam R. Howlett 2022-09-06  4200   * mas_wr_store_entry() - Internal call to store a value
54a611b605901c Liam R. Howlett 2022-09-06  4201   * @mas: The maple state
54a611b605901c Liam R. Howlett 2022-09-06  4202   * @entry: The entry to store.
54a611b605901c Liam R. Howlett 2022-09-06  4203   *
54a611b605901c Liam R. Howlett 2022-09-06  4204   * Return: The contents that was stored at the index.
54a611b605901c Liam R. Howlett 2022-09-06  4205   */
54a611b605901c Liam R. Howlett 2022-09-06 @4206  static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
54a611b605901c Liam R. Howlett 2022-09-06  4207  {
54a611b605901c Liam R. Howlett 2022-09-06  4208  	struct ma_state *mas = wr_mas->mas;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4209  	unsigned char new_end = mas_wr_new_end(wr_mas);
54a611b605901c Liam R. Howlett 2022-09-06  4210  
7ad45cca258711 Sidhartha Kumar 2024-06-04  4211  	switch (mas->store_type) {
7ad45cca258711 Sidhartha Kumar 2024-06-04  4212  	case wr_invalid:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4213  		MT_BUG_ON(mas->tree, 1);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4214  		return NULL;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4215  	case wr_new_root:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4216  		mas_new_root(mas, wr_mas->entry);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4217  		break;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4218  	case wr_store_root:
54a611b605901c Liam R. Howlett 2022-09-06  4219  		mas_store_root(mas, wr_mas->entry);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4220  		break;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4221  	case wr_exact_fit:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4222  		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4223  		if (!!wr_mas->entry ^ !!wr_mas->content)
7ad45cca258711 Sidhartha Kumar 2024-06-04  4224  			mas_update_gap(mas);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4225  		break;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4226  	case wr_append:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4227  		mas_wr_append(wr_mas, new_end);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4228  		break;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4229  	case wr_slot_store:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4230  		mas_wr_slot_store(wr_mas);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4231  		break;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4232  	case wr_node_store:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4233  		mas_wr_node_store(wr_mas, new_end);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4234  		break;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4235  	case wr_spanning_store:
54a611b605901c Liam R. Howlett 2022-09-06  4236  		mas_wr_spanning_store(wr_mas);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4237  		break;
7ad45cca258711 Sidhartha Kumar 2024-06-04  4238  	case wr_split_store:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4239  	case wr_rebalance:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4240  	case wr_bnode:
7ad45cca258711 Sidhartha Kumar 2024-06-04  4241  		mas_wr_bnode(wr_mas);
7ad45cca258711 Sidhartha Kumar 2024-06-04  4242  		break;
54a611b605901c Liam R. Howlett 2022-09-06  4243  	}
54a611b605901c Liam R. Howlett 2022-09-06  4244  
54a611b605901c Liam R. Howlett 2022-09-06  4245  	return wr_mas->content;
54a611b605901c Liam R. Howlett 2022-09-06  4246  }
54a611b605901c Liam R. Howlett 2022-09-06  4247  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

