Return-Path: <linux-kernel+bounces-556896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940CA5D00A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DFA3B9A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2438263F2B;
	Tue, 11 Mar 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tg9TNLCW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E723774
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722952; cv=none; b=ZsOImMjIbeESGdnFsV5dPS7lWxJOXmNXaFYvB7p8Jlywzb5gAjtbKt8WDEYeZDLNqGbzcOUmAUOKq46jibA8A+9gfh0Kj81ViwdH04Gu/9q1N3X14H32mu7oRTJFB3IkJA+XKWevjKxU6pr6jFJtwTnlH1UMyspk7jlST3xWdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722952; c=relaxed/simple;
	bh=INytju306TKoMDxav0i3/nsAMzfqfz/DLUCftzTMpgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia0Q1gnZEiz5xDV3MuCHFMv7oUSJY27LiQsGtlbvEuZO6bBHEWpo45hqHVMFgxt7zMsjJiMJ5TR0vAHHqY6YgCnNThwchfvSiuaNywbT97XcaTw4bMIxTBqOtaeCfYcOcQ6qH5o6LRNP31m2z/RRnGZpVHha6B+9Ogfwfn1xvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tg9TNLCW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741722951; x=1773258951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=INytju306TKoMDxav0i3/nsAMzfqfz/DLUCftzTMpgo=;
  b=Tg9TNLCW0yYqD742w/5dqdC3WsAzeqdmVT9EDqksLblYpsoEBDo/5dvA
   t+wT79AIkT1wW9eX8omFW9chjGqa/n2wewHSWLhdeAoeK/t543ercmk6o
   QxUxgnjHR4EvsK+zTPAbdVg4liJrc2BmV05YmGSDWoZ97mSBbjBVwES3i
   6lY6IFME6mGS9EiQSq6nKYyjJxZkZ/dnUxnpIYXXErGGRspOe3l6Vlfq4
   CfFwdW/BTPAlWKGJPARifAjf7iotjE4Zdbq0+ycDf3qDIqotIS0bRk96u
   sLdylr2V2J05v10Fl6N2bFCJ8UOSPdB5eaV63+LmzGdtPJDerKYPyS2SS
   Q==;
X-CSE-ConnectionGUID: 5yGq4aOPQa+rrQ0K+tmDMg==
X-CSE-MsgGUID: 3Af+/iF6SDiB8tH2q2E/jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="52987799"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="52987799"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:55:50 -0700
X-CSE-ConnectionGUID: JiU70WQ8Tr+nG0dPRP15Lw==
X-CSE-MsgGUID: sIx+uDVtQpCZ239W5Uryag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125040126"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 11 Mar 2025 12:55:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts5ha-0007nQ-2N;
	Tue, 11 Mar 2025 19:55:46 +0000
Date: Wed, 12 Mar 2025 03:55:35 +0800
From: kernel test robot <lkp@intel.com>
To: Yajun Deng <yajun.deng@linux.dev>, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
Message-ID: <202503120334.Dk9gw6LX-lkp@intel.com>
References: <20250311013352.2727490-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311013352.2727490-1-yajun.deng@linux.dev>

Hi Yajun,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/genirq-Keep-affinity_hint-unchanged-if-it-has-a-value/20250311-093633
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250311013352.2727490-1-yajun.deng%40linux.dev
patch subject: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
config: s390-randconfig-002-20250312 (https://download.01.org/0day-ci/archive/20250312/202503120334.Dk9gw6LX-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120334.Dk9gw6LX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120334.Dk9gw6LX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/irq/irqdesc.c:61:31: error: incompatible pointer types passing 'struct cpumask **' to parameter of type 'cpumask_var_t *' (aka 'struct cpumask (*)[1]') [-Werror,-Wincompatible-pointer-types]
           if (!zalloc_cpumask_var_node(&desc->affinity_hint,
                                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:996:68: note: passing argument to parameter 'mask' here
   static __always_inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
                                                                      ^
   1 error generated.


vim +61 kernel/irq/irqdesc.c

    53	
    54	#ifdef CONFIG_SMP
    55	static int alloc_masks(struct irq_desc *desc, int node)
    56	{
    57		if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
    58					     GFP_KERNEL, node))
    59			return -ENOMEM;
    60	
  > 61		if (!zalloc_cpumask_var_node(&desc->affinity_hint,
    62					     GFP_KERNEL, node)) {
    63			free_cpumask_var(desc->irq_common_data.affinity);
    64			return -ENOMEM;
    65		}
    66	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

