Return-Path: <linux-kernel+bounces-565796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0207A66F46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139E919A31F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D517205AA5;
	Tue, 18 Mar 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip7+hU2M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3302054F1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288807; cv=none; b=m+PQp9aUllMmyU3QEGGCJSXl9kaAwGwh2omQ1fHEAd4yqrXcKUgTyqfoBJyrY84dDi5lh3s8InBQEWcDCYTAbRakvRPpsHJwP9HtzOMFMWmNUqTVNAcHzmDDJ9Z0EEUgmxk2L5eOuS+1oe1tA/qr9530iGuq8GUhlOKaG5XW2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288807; c=relaxed/simple;
	bh=cU3Td84ng2ltMV6Bi/2n05AaRKr+vVbreJwcsziIcHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gT6qG6gEXPKHVJfXM2HWEWfAj5j5Fvd3KOmU+aiXsmP37zGFA5cQgGsGihUnWkP6CE6C86m8SjVeAzeGwo14YKGYb0PXNJdxNL/kmdjD3OaNrJ484u40ODQBnQlXxgTtjBPNfD0Cr+RzzTrxfVrbK2WoWnsifSwzmW+w/jkqS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip7+hU2M; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742288806; x=1773824806;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cU3Td84ng2ltMV6Bi/2n05AaRKr+vVbreJwcsziIcHI=;
  b=ip7+hU2M0zYNE245hTTb3zoWULXw7XMtX/yLZ1V4yrOw5JKnTCsge6FI
   aotqwMO9SQq01Fzb/540YL/cWET1P4z0tW5YyEVvUls584We2zVPiV9Pp
   FzEa1ibv8ARetwj6J0nygLZOR2B5wpvBHcx7CQAXr1c45MWm4eyPNO9xa
   M97I4eSbUNiXGo/geCwommyr6MvkaKW6zp1YwPW5lhzG3rJ2kEan1yjck
   6Ad2UA+3SGf1bnIbnn3gkYYicmsELJMSNp+i4oL6+qwIwz55hWFqOmKXQ
   HFbK9k+qa+g6ETgEKgBIhRsIdgU8Zjjx4xlWxkOqQxJwCmUVVgkQ8z8IT
   Q==;
X-CSE-ConnectionGUID: zJJ0u2u9Q3uWFFpxBxVhRQ==
X-CSE-MsgGUID: cl2je/liSYyYtU/fBXgZDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43549777"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43549777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 02:06:45 -0700
X-CSE-ConnectionGUID: iEgy3JpRRjKdAif4jMpDow==
X-CSE-MsgGUID: ciQ5lmotRDqGWl3lxv8NOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="123142318"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Mar 2025 02:06:43 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuSuH-000Dc9-01;
	Tue, 18 Mar 2025 09:06:41 +0000
Date: Tue, 18 Mar 2025 17:06:25 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [tip:objtool/core 5/13] arch/x86/mm/fault.o: warning: objtool:
 do_user_addr_fault+0x1e1: skipping duplicate warning(s)
Message-ID: <202503181736.zkZUBv4N-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
head:   73070466ed3b5e4620e03c159ee12a570b171d08
commit: 0a7fb6f07e3ad497d31ae9a2082d2cacab43d54a [5/13] objtool: Increase per-function WARN_FUNC() rate limit
config: x86_64-randconfig-074-20250318 (https://download.01.org/0day-ci/archive/20250318/202503181736.zkZUBv4N-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503181736.zkZUBv4N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503181736.zkZUBv4N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x1d8: unreachable instruction
   arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x1dd: unreachable instruction
>> arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x1e1: skipping duplicate warning(s)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

