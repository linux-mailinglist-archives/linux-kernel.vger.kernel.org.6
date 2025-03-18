Return-Path: <linux-kernel+bounces-566634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7531A67AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3FC3A80F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C34212D7A;
	Tue, 18 Mar 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTInjMhe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29C2116E5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318245; cv=none; b=RQHjqr22YYqtQ7qDYOJfF4uOgQEyXqeQqvbIidOFB1Ems4Dp8ZF42sOH16VpkNI5p+DwavIJQQZUPuCQBrk1Cl2UoAkgCJqcDJDc0/TzmSPo4YF6A/spQwct42Llo2Ktweip7hBvSHnsbyIR7x0Zx4x6y55J+uoTS68YljTfHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318245; c=relaxed/simple;
	bh=OYUPEq5xztxlZCOr5SdGxKPaZgbIe7IbiCOPPwMwfZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kBnHh+oIFZFEdArQNN/2ErxqCE0HuOqHV3mJicAcElT4tcLwKjrnuZ3ucHybSCObtX/kCRCxDqx1MDbbGsJx0JyWPz0L2+Xbd/fVatKGgAkFt8+0ZFt8gR3tlsIrWW/4/f8lLFEyPq/W0wrAWxLTScMvSzDbTSr2CCnBfGfZUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTInjMhe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742318244; x=1773854244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OYUPEq5xztxlZCOr5SdGxKPaZgbIe7IbiCOPPwMwfZ0=;
  b=kTInjMhefpgP1elUeyDN8r90LO9BhKZ6mX7cAvgW89uJXPJe28rhttwI
   eXLx0Za/3y3aTJIJyUEZcXyJQGzpV4cqBp3p7varZihW/qLC3230kig/4
   mhbmwqMhGDaE604d8Gdpc0V59yu7MqB+4/cY3TR7Bq/8xaz5kBF2TZqCr
   1JNC1bQNpkyBRmp0PB5xACcRYHJCfjzfwe00pmyjEIYR51G6MiO6lIpFQ
   i5AE6Qc/lFkFllLYazzfceQPOHGL5j6Ma6GnrPpC2GWw7rXkiHsTBHQaE
   9ULPoe1bnr0DOFdtaVmn7i8/iwuosUwDyo+WYufSo6JWLaTL1F30/k96h
   A==;
X-CSE-ConnectionGUID: V1UauPQ8SpiMk+0mDj34kw==
X-CSE-MsgGUID: sc5Pd49XRzCgcTn1av5E9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43664097"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43664097"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 10:17:23 -0700
X-CSE-ConnectionGUID: 15AVfgs2TGqeTNpqkmeqIA==
X-CSE-MsgGUID: CnMMdmbeSHiCnkReVYGpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122806081"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Mar 2025 10:17:21 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuaZ5-000E0x-1S;
	Tue, 18 Mar 2025 17:17:19 +0000
Date: Wed, 19 Mar 2025 01:16:22 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [tip:x86/cpu 3/14] arch/x86/xen/enlighten_pv.c:118:24: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202503190109.ewohfLu6-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
head:   ba501f14e1e6dcc94ff0276301e997ae28e3f4b3
commit: 82d829091f62721166d3f1af93c4c94fc9afa13e [3/14] x86/xen: Move Xen upcall handler
config: x86_64-randconfig-121-20250318 (https://download.01.org/0day-ci/archive/20250319/202503190109.ewohfLu6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503190109.ewohfLu6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503190109.ewohfLu6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/xen/enlighten_pv.c:1490:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/xen/enlighten_pv.c:1490:28: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/xen/enlighten_pv.c:1490:28: sparse:     got struct gdt_page *
   arch/x86/xen/enlighten_pv.c: note: in included file (through arch/x86/include/asm/stackprotector.h, include/linux/stackprotector.h):
   arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *
>> arch/x86/xen/enlighten_pv.c:118:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
   arch/x86/xen/enlighten_pv.c:118:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/xen/enlighten_pv.c:118:24: sparse:     got bool *
   arch/x86/xen/enlighten_pv.c:120:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
   arch/x86/xen/enlighten_pv.c:120:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/xen/enlighten_pv.c:120:9: sparse:     got bool *
   arch/x86/xen/enlighten_pv.c:126:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
   arch/x86/xen/enlighten_pv.c:126:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/xen/enlighten_pv.c:126:9: sparse:     got bool *

vim +118 arch/x86/xen/enlighten_pv.c

   111	
   112	/*
   113	 * In case of scheduling the flag must be cleared and restored after
   114	 * returning from schedule as the task might move to a different CPU.
   115	 */
   116	static __always_inline bool get_and_clear_inhcall(void)
   117	{
 > 118		bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
   119	
   120		__this_cpu_write(xen_in_preemptible_hcall, false);
   121		return inhcall;
   122	}
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

