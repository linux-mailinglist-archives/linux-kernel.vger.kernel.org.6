Return-Path: <linux-kernel+bounces-576932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F1A71629
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F47A3B5A25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F201DDA0F;
	Wed, 26 Mar 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcRLzW9b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1621ADFFB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990531; cv=none; b=nTijRhDIGSt+RZ34F7NhN7P2lPbjayPxCQ11B2AgMSMHgIquqwhL4/YutWjVskY0LEXNd+TCd810e+QQ1eHleuEr/ZpFNiQtgf8flRbD0xmj5IDkLbJaYmQlnxuvjLD5TKgDP2bWDB87/ZIlW9a2Q0w9Y7MXJKeoCvPUqEsD4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990531; c=relaxed/simple;
	bh=34SAO7oukLfObJHuNcCFpOMHV3EiLEQAjmJDV++fpgs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XJp1bnvDflFLd6zopLLg4XtlG9L93a/Kw/XoDTLis8vynWsps7Il9X0MVtiIjKe+nCdoJdfIDAvO2uymLc1EdI3+ULfXo39//otvt4DMscH7EfoJ9N989QSFt2PMDe95wOnuZ/HGL83pt0LLLezliafF51OdH4jcLawOFQnOFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcRLzW9b; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742990530; x=1774526530;
  h=date:from:to:cc:subject:message-id;
  bh=34SAO7oukLfObJHuNcCFpOMHV3EiLEQAjmJDV++fpgs=;
  b=ZcRLzW9b7Z21q/KRlOtd/T4aryu3cM634I229kQjUFRTSWCmmPCPrCi+
   ONE1MF6rbWZFXvQYPzdsxlhAKuTaRWrYvvbRdeGpf7Xya3NZtOlLSbUP0
   9sPg7mJn64U6bLcx4krRBY8QLC0m64E1TgqDeqvuCuhYf4K4vAv36VbVH
   3pfEVIbYG2gfhdm3GPLRKaN3Iq3dTrihEWnG773XrP3l7KmFMVMuHFuTc
   2qHpNzEhAwoWs5ihoKF4+4qQXLiHpNsf9p2zeWXokJ3Kr0n/nxKQ+D/6d
   ueRijP9eCKkrJmYfKA1yyLkd0ZT1rkoHknnbLhzbQE9spiOK4gnB2ttaz
   Q==;
X-CSE-ConnectionGUID: IvJ7rPBCRGmpvW6xPimceA==
X-CSE-MsgGUID: +egcNLBKS8uq13CLXPhBSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43999325"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="43999325"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 05:02:10 -0700
X-CSE-ConnectionGUID: itQUatE1S26owyHZoW1VjA==
X-CSE-MsgGUID: UJYZN2q+TUuuVsTeAXj7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="129767460"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Mar 2025 05:02:09 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txPSQ-0005iF-29;
	Wed, 26 Mar 2025 12:02:06 +0000
Date: Wed, 26 Mar 2025 20:01:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 451283cd40bceccc02397d0e5b2b6eda6047b1ed
Message-ID: <202503262016.FAeAa1bz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 451283cd40bceccc02397d0e5b2b6eda6047b1ed  x86/alternatives: Document the text_poke_bp_batch() synchronization rules a bit more

elapsed time: 1449m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250325    gcc-12
i386    buildonly-randconfig-002-20250325    clang-20
i386    buildonly-randconfig-003-20250325    gcc-12
i386    buildonly-randconfig-004-20250325    clang-20
i386    buildonly-randconfig-005-20250325    gcc-12
i386    buildonly-randconfig-006-20250325    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250325    gcc-12
x86_64  buildonly-randconfig-002-20250325    clang-20
x86_64  buildonly-randconfig-003-20250325    gcc-12
x86_64  buildonly-randconfig-004-20250325    gcc-12
x86_64  buildonly-randconfig-005-20250325    clang-20
x86_64  buildonly-randconfig-006-20250325    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

