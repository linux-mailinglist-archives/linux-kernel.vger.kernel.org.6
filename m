Return-Path: <linux-kernel+bounces-265604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E993F39E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5E0B234AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5A145B0B;
	Mon, 29 Jul 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAddYVFF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A538BE7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251148; cv=none; b=GqFZ04BARedfla8i3gn6DtZJqDM5SrDrFlGEHjERT2aBCd0L6fe4GB22MwolZdwktbr7UK/5FjcADmJqWOM8ZYDla3q3PQI8+2mv10TqY7x/zTNHTaHosg6ul94N078OYyE+pn4jywRkU6attsZleE4qp0+GR9hS97EtwXuKzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251148; c=relaxed/simple;
	bh=WZfxjdzDxF4fUct42H8Yhj2OTGYK85mWDLxDklL4AZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sNZYvC9vJbSjTa3aMUasdqkUdF/vPbb4F2v+zxr2/WZYan0CfIt6Zhmhm01stQky0BUCxpLMMGnIyW1DZVM9Vbqn3eXKJgRHVNW5SY8yw/dXHMmh8O4D7cDfPhW9Sw8o2YVt6GNRffcl8uRXdbQJAAzVxptWlKtoKXdf6qoN4ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAddYVFF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722251146; x=1753787146;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WZfxjdzDxF4fUct42H8Yhj2OTGYK85mWDLxDklL4AZo=;
  b=nAddYVFFVd9ZU4jWHYoED9dRQ61Ng4K7qfSQAE6ymw/s1cVP33ByOCNj
   6688AP3vn0URVRHfqUpuDBN8s/vsJOxw5jrjcDD8qoKABQpURgu7iLdQh
   KN3XH/wSxpdQ441XsvpSslzaLrUk7ibdgR7TI8dbYk5IBjR5hxtQqi0Tx
   SLiK3X6V5PgIfka5Qu15Dtyr0i0XCa8soOw6rx0dyxYOXlkfRSpQ5WXql
   EDSsxs3bYyct1S/dguPhtiLdzdcPadpe6wazyXIGMJwlK82HFRjdEDdlE
   WPTpVYpfGwGnPVjBdmee9YCGVlDkFxafRpcrclMC93VU/xDvqfvpiZm0I
   A==;
X-CSE-ConnectionGUID: DbS4rOdTS/yezBGocr2uNQ==
X-CSE-MsgGUID: 1yusEcL9TkCaTAoGizpKlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19841648"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="19841648"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 04:05:46 -0700
X-CSE-ConnectionGUID: tuz0HiEtQB+M2GmPc6/IQQ==
X-CSE-MsgGUID: ZJguCmrTQeOKOOUWf+U9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="53604278"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Jul 2024 04:05:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYOCD-000reA-2I;
	Mon, 29 Jul 2024 11:05:41 +0000
Date: Mon, 29 Jul 2024 19:04:51 +0800
From: kernel test robot <lkp@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:x86/microcode 1/1] arch/x86/kernel/cpu/microcode/amd.c:714:6:
 warning: variable 'equiv_id' is used uninitialized whenever 'if' condition
 is false
Message-ID: <202407291815.gJBST0P3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
head:   94838d230a6c835ced1bad06b8759e0a5f19c1d3
commit: 94838d230a6c835ced1bad06b8759e0a5f19c1d3 [1/1] x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID
config: i386-buildonly-randconfig-001-20240729 (https://download.01.org/0day-ci/archive/20240729/202407291815.gJBST0P3-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407291815.gJBST0P3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407291815.gJBST0P3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/microcode/amd.c:720:31: note: uninitialized use occurs here
     720 |         return cache_find_patch(uci, equiv_id);
         |                                      ^~~~~~~~
   arch/x86/kernel/cpu/microcode/amd.c:714:2: note: remove the 'if' if its condition is always true
     714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/microcode/amd.c:706:14: note: initialize the variable 'equiv_id' to silence this warning
     706 |         u16 equiv_id;
         |                     ^
         |                      = 0
   1 warning generated.


vim +714 arch/x86/kernel/cpu/microcode/amd.c

   701	
   702	static struct ucode_patch *find_patch(unsigned int cpu)
   703	{
   704		struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
   705		u32 rev, dummy __always_unused;
   706		u16 equiv_id;
   707	
   708		/* fetch rev if not populated yet: */
   709		if (!uci->cpu_sig.rev) {
   710			rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
   711			uci->cpu_sig.rev = rev;
   712		}
   713	
 > 714		if (x86_family(bsp_cpuid_1_eax) < 0x17) {
   715			equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
   716			if (!equiv_id)
   717				return NULL;
   718		}
   719	
   720		return cache_find_patch(uci, equiv_id);
   721	}
   722	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

