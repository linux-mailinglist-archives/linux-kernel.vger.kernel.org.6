Return-Path: <linux-kernel+bounces-412130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365B69D0434
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72171F2172A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15F71D8DF8;
	Sun, 17 Nov 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJMOO46J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BA1CB53C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853064; cv=none; b=gYIWZqG45gYLfTLj+RzMomJtmHMP+e/fUeSWoOXmTwrNO/Bd8relrusA9bg4HI44O8yPXGCSEutqG69LDNftV+1/7LuIot4VzvxTiHSQO0MdIqU4FGqgnx438FL7Uij8ORusSa/ta0hMYd5FyNvUxnVugPWlWIx7w1QyAPuDGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853064; c=relaxed/simple;
	bh=T9kksBI6Q+I4HOwU+obXpprZ7wSB7PSyedX+TRnY+6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/ABJkzkR9LzAvin4m5r35h8gg51mxYuV+2sqL2A2ozMZfMD8JFoYw/CtB592we1g6zBkU3wOhpB3xK8mX2PW3d0ChckjCo4m/IKOedLZONkwMe8trlou16w9S8ZIyIxGQ7ffB9pD5+Ej7SJOjbdxtUNU0Z4f3HL+qECNWv/aeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJMOO46J; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731853062; x=1763389062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T9kksBI6Q+I4HOwU+obXpprZ7wSB7PSyedX+TRnY+6w=;
  b=NJMOO46Jxm9+xk3srjodBrms/3cYaf0K5qnko/IEhxGoi+Uy72xpWwbR
   jO5hnmnEzIrpkaaZwbGU6CoXF9sXxzcGcGudXQ0cvE6I1wpDcQJf6HCaM
   UAbZUwq8/1+YnWw77CJqrO9Ag9xglymyPRd2WKk4wo8wyZ+svERiDBV3G
   mxl7iTvjK/A0LLt/NLNih+sf25Zy/1NO1QquBKko7c0q40WjOanjN1TJG
   OLZ2ABuuX6eLg+l0Ve9YLsiQ2qL2OslYnPhhN+iYiDvv4ENSfjHdz7VEm
   6i+UDgG2d4e8KsxKHkk1IAAjzOVfrRfVnY7t289FQkwTBooNnSLmmt8Dg
   A==;
X-CSE-ConnectionGUID: r64V/qTpQX6LKOmej0boDg==
X-CSE-MsgGUID: I50Jgc6VSGOFEmZlu+ZKVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="35486227"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="35486227"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 06:17:42 -0800
X-CSE-ConnectionGUID: j2yx9xhrSJSApK/3QKDskw==
X-CSE-MsgGUID: 6hrmAIGUT1efpZkRifzfRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="88995423"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Nov 2024 06:17:40 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCg5p-0001nH-1N;
	Sun, 17 Nov 2024 14:17:37 +0000
Date: Sun, 17 Nov 2024 22:16:37 +0800
From: kernel test robot <lkp@intel.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	kernel-team@android.com
Subject: Re: [PATCH v2 1/2] lib: stacklog_debug: Introduce helper tool for
 collecting and displaying stacktraces
Message-ID: <202411172216.8mrRZn7X-lkp@intel.com>
References: <20241116002322.1035417-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116002322.1035417-1-jstultz@google.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/lib-stackdepot-Avoid-null-pointer-if-stack_depot_save-is-called-too-early/20241116-230825
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20241116002322.1035417-1-jstultz%40google.com
patch subject: [PATCH v2 1/2] lib: stacklog_debug: Introduce helper tool for collecting and displaying stacktraces
config: arm-randconfig-r132-20241117 (https://download.01.org/0day-ci/archive/20241117/202411172216.8mrRZn7X-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20241117/202411172216.8mrRZn7X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411172216.8mrRZn7X-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/stacklog_debug.c:19:1: sparse: sparse: symbol 'stack_lock' was not declared. Should it be static?
   lib/stacklog_debug.c:21:5: sparse: sparse: symbol 'head' was not declared. Should it be static?

vim +/stack_lock +19 lib/stacklog_debug.c

    17	
    18	#define LIST_ENTRIES 512
  > 19	DEFINE_SPINLOCK(stack_lock);
    20	depot_stack_handle_t stack_list[LIST_ENTRIES];
    21	int head, tail;
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

