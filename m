Return-Path: <linux-kernel+bounces-182990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5058C929E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF821F215CC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53FB6D1BC;
	Sat, 18 May 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aok6NXG6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D66CDC1
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069189; cv=none; b=fXf6OlTUIpGc33ozJlQDwq6GJWs7vsAftPS1o5pgiNCCXaCGpvA6c+ggoVxEVPmHhdvqN/R26Gg26TvH6OHsdfjUgNGdLElc9VEQ4uEqhR0ahpnBz7R0Rinuq2pjl4QGX2Wp1tvXNTlLCR+UmAQ8c6in8wDELQ1Fi850nrU6wWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069189; c=relaxed/simple;
	bh=/h63idD/VwIcK3pkl9ryzPUBD80KcxZ0Da4INy7C26s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RJh62ThZOccTNhRrFIMAXMOjkcEJE/4ABPcwbkoBstPU/c3zZZ6Dk289VBuoqHsLW0zQu7FtD48IXIuTQTYqLhtKAb81X2EWFEyX8lhKhv6DFfh9bXWLOrTu9hd6GbIg9ZlxTqocsvMDcpePYgLzwdX+QMV4EqObRPO+VsipQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aok6NXG6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716069188; x=1747605188;
  h=date:from:to:cc:subject:message-id;
  bh=/h63idD/VwIcK3pkl9ryzPUBD80KcxZ0Da4INy7C26s=;
  b=Aok6NXG6uucHjxxq3ztt+XY7gPdtIFnY6hMKQ2ecqBM3QtgRCzxnY0LI
   /HWOS9cGn3Oyn11yvqWIgwoZm274KVn1gdASZA2ri90dz6wrcX00Ta+Gl
   oWaIBlLstCOElAgw9wpGQoCvZxu8VNlU5mnh5aL+pWgtLjsNJZDLifaqE
   Qzw5QkVOV4gJ+ecfHBoF87Y0gJqKmBZHyL26t8T5Wua1gsVInWuI6o6/F
   r0lobH6ayKy3P3pwAehG6b+y73Cy2TlQAPdkub2BnIpVzcupXxkka1CMo
   nkG6n/bPr8Owut8saUqy5asfr3QGTZW8mA2M3vffqcjgy6W3UxmzMrCsX
   Q==;
X-CSE-ConnectionGUID: nvD3Ak+BThyBVcv+jQM7zg==
X-CSE-MsgGUID: gKZBZgPiT/mVUGL3BNTeQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="29742630"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="29742630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 14:53:05 -0700
X-CSE-ConnectionGUID: BTWccbxIT/ex68AA9Dh4/w==
X-CSE-MsgGUID: MEdtoga8SV2SzALW3B9YaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="32157399"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 18 May 2024 14:53:03 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8RzB-0002fA-1Q;
	Sat, 18 May 2024 21:53:01 +0000
Date: Sun, 19 May 2024 05:52:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 1fe67aee8ab3fdab4357afc983a9e9ff3892d694
Message-ID: <202405190512.TtnsVDYS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: 1fe67aee8ab3fdab4357afc983a9e9ff3892d694  x86/percpu: Fix operand constraint modifier in __raw_cpu_write()

elapsed time: 724m

configs tested: 50
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240518   gcc  
i386         buildonly-randconfig-002-20240518   gcc  
i386         buildonly-randconfig-003-20240518   gcc  
i386         buildonly-randconfig-004-20240518   clang
i386         buildonly-randconfig-005-20240518   clang
i386         buildonly-randconfig-006-20240518   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240518   clang
i386                  randconfig-002-20240518   clang
i386                  randconfig-003-20240518   gcc  
i386                  randconfig-004-20240518   gcc  
i386                  randconfig-005-20240518   clang
i386                  randconfig-006-20240518   gcc  
i386                  randconfig-011-20240518   gcc  
i386                  randconfig-012-20240518   clang
i386                  randconfig-013-20240518   clang
i386                  randconfig-014-20240518   gcc  
i386                  randconfig-015-20240518   clang
i386                  randconfig-016-20240518   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240518   gcc  
x86_64       buildonly-randconfig-002-20240518   clang
x86_64       buildonly-randconfig-003-20240518   clang
x86_64       buildonly-randconfig-004-20240518   clang
x86_64       buildonly-randconfig-005-20240518   clang
x86_64       buildonly-randconfig-006-20240518   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240518   clang
x86_64                randconfig-002-20240518   clang
x86_64                randconfig-003-20240518   gcc  
x86_64                randconfig-004-20240518   gcc  
x86_64                randconfig-005-20240518   gcc  
x86_64                randconfig-006-20240518   clang
x86_64                randconfig-011-20240518   gcc  
x86_64                randconfig-012-20240518   gcc  
x86_64                randconfig-013-20240518   clang
x86_64                randconfig-014-20240518   gcc  
x86_64                randconfig-015-20240518   clang
x86_64                randconfig-016-20240518   clang
x86_64                randconfig-071-20240518   clang
x86_64                randconfig-072-20240518   clang
x86_64                randconfig-073-20240518   gcc  
x86_64                randconfig-074-20240518   clang
x86_64                randconfig-075-20240518   gcc  
x86_64                randconfig-076-20240518   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

