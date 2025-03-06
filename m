Return-Path: <linux-kernel+bounces-548277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427FA542BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75423ACEAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C7D1A238F;
	Thu,  6 Mar 2025 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5s1hQHr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6C1A00FE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242264; cv=none; b=UWdlbLULvs4HHc91ob7JrQrgz70EEP+YLtweD8HyCRqk7vmuYGbsumE7H+mTkzeutlzr/nUe9fDkJ8CRlhZEkM1llOENh1tDVFqFo5qyelQNegbAu54JsXGMGLoMNI5BZ+cco5d2GrGLjnyCgLv6QYc5bmueANd8J8xizo/t9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242264; c=relaxed/simple;
	bh=8fYshAOT8M0SlNL6azI3FGyxmVaI08HBg2hvANYjPaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nK4e6aadQKiq72ZomEmLPKpcaXisIE+XDw7U2x7AtAKCc4OM1Z3WPqNVcvW7+MrR6oXkTJsVRSbLv1F+Y24zlzg/CpdZW1JiVYKDA3R3750fxlHqT8p2M0RXADNPS8p+ENRP3n+bXbsJ2N66mLyTodnH5O2ogduhUtRDXSAZuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5s1hQHr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741242263; x=1772778263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8fYshAOT8M0SlNL6azI3FGyxmVaI08HBg2hvANYjPaM=;
  b=e5s1hQHrXUOnILTovcXNV8WfkkTpsLQRnYQGSVCADmzSMF0fX7ye2MqH
   Hnevoy5HofTB4Ha1/+yz7Kc2gRbaScgShvD6q3sAdUsiJHSI0Bqtgjznb
   4NtJFK8NgwK+N0bvtfCdKHY95RB1CAFct8vjA4vst4va8ojAvnPVrDIf/
   vteYRGT6W7pBinRQt9pXfcono/vzbR7JQt2HejEJW751dTGuZROme6OPy
   CTJTGSN9pv4L5vBNyI7c5hdLXMgz/h8RwnwnBH3yk3+dA89wNHDMC2OVz
   yeQ17WAecFXOaI5C3hI9j+COUNSZX4cyZi2etDiAPpidAtfaGDWj+p7Pr
   A==;
X-CSE-ConnectionGUID: G/vgeyLKSS+7SO9v0s+AKg==
X-CSE-MsgGUID: yLejbeTORxGTFYchV0Zhyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42435979"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42435979"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:24:22 -0800
X-CSE-ConnectionGUID: kYUdavJgSeCE171dx4oWjA==
X-CSE-MsgGUID: jwCUfqhKR2G9v1zwnMsrLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123849828"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 05 Mar 2025 22:24:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq4eY-000Mcs-27;
	Thu, 06 Mar 2025 06:24:18 +0000
Date: Thu, 6 Mar 2025 14:23:26 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/core 44/50] arch/x86/kernel/cpu/common.c:2083:1: sparse:
 sparse: symbol '__pcpu_scope___x86_call_depth' was not declared. Should it
 be static?
Message-ID: <202503061407.cBrEr1Va-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
head:   6d536cad0d55e71442b6d65500f74eb85544269e
commit: bacde25dbbad6180b434332ad829b9e2f8064a56 [44/50] x86/retbleed: Move call depth to percpu hot section
config: x86_64-randconfig-123-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061407.cBrEr1Va-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061407.cBrEr1Va-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061407.cBrEr1Va-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/common.c:2083:1: sparse: sparse: symbol '__pcpu_scope___x86_call_depth' was not declared. Should it be static?

vim +/__pcpu_scope___x86_call_depth +2083 arch/x86/kernel/cpu/common.c

  2076	
  2077	#ifdef CONFIG_X86_64
  2078	/*
  2079	 * Note: Do not make this dependant on CONFIG_MITIGATION_CALL_DEPTH_TRACKING
  2080	 * so that this space is reserved in the hot cache section even when the
  2081	 * mitigation is disabled.
  2082	 */
> 2083	DEFINE_PER_CPU_CACHE_HOT(u64, __x86_call_depth);
  2084	EXPORT_PER_CPU_SYMBOL(__x86_call_depth);
  2085	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

