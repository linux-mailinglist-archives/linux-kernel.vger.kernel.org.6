Return-Path: <linux-kernel+bounces-527734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2749A40EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 13:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4164172111
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A9205512;
	Sun, 23 Feb 2025 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6gE0boZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453AA6FC3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740313028; cv=none; b=FRXijrrWd2vkzPhWWkUBFV7wGZe6v7/25T8VWULCTvQ1r2IeEtQRCfIsKEtRpaiv8jcgEYA451vk2rK0PeoVpRfkyHgPU7xsDqI71SJ17SmFtpBVJHZVF+mMWK22JPl/JfDk0Kff3BSczTW9eTTPmyfOlka49H8Q9k6qtySFsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740313028; c=relaxed/simple;
	bh=gC7XrPMBDvfitCtTHQxFmOmejPH8/Yzytwu16s/zOTg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kVpV0DKz8W8XSKnY56i0IcvfnAH/Cy4s//XQHsy1SRn0tktRhpfXOi919SHMfM8HFMyKiAHmNbLVYNveZbYE+JdfTeDxIZys3FMiNgnAbvJveKZpsYfyfScYGLBqMBhR6v+rOiIQIDVS7B0NTsyhDLVyTrRv4zuXSbzpaV29i80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6gE0boZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740313026; x=1771849026;
  h=date:from:to:cc:subject:message-id;
  bh=gC7XrPMBDvfitCtTHQxFmOmejPH8/Yzytwu16s/zOTg=;
  b=b6gE0boZUvkKlfYM67dcs1/oCif2LvFYCE3E6QaYWYXbazWL5rILVrBo
   1EIheQdeiG6tcyKTpOJUElRhBVHrEqCPjtGxqJCsvXpWXWlV0QaHftvc1
   QN5f0ZXt4Fn9N9npCHsEhoOiV28K/L+OGGq6cztWKeKaT1KNogzqzLn52
   Us3UGD0VgSWk/UuleYx1Xu/K7OvDm/J6si2B09OzV2YpGNDkoNnbSfZwY
   4IWJrnxFi9jjSWEHyqZLfsfyF9nhuOKQyw+hLGIakJLXOXsadsTUkcIOv
   2UxcY3TrFT/mdZIamvfYeMq4Z74RuzhM+CrouRpujq8yxhTTL+hNyFZ+K
   w==;
X-CSE-ConnectionGUID: 2QtU05MKTdu04cpBJceqnQ==
X-CSE-MsgGUID: B0FpXByiRACoGHJcHGw+0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58627900"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58627900"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 04:17:05 -0800
X-CSE-ConnectionGUID: dxBcQxzcRxKGcm/uhEn2uQ==
X-CSE-MsgGUID: FPfTeChiS4uPAV7GUFdg6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116297879"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Feb 2025 04:17:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmAus-0007Jf-0m;
	Sun, 23 Feb 2025 12:17:02 +0000
Date: Sun, 23 Feb 2025 20:16:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 a2498e5c453b3d8d054d77751487cd593332f8c2
Message-ID: <202502232008.0CmOMMhv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: a2498e5c453b3d8d054d77751487cd593332f8c2  x86/kexec: Export e820_table_kexec[] to sysfs

elapsed time: 1393m

configs tested: 19
configs skipped: 125

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250222    clang-19
i386    buildonly-randconfig-002-20250222    gcc-12
i386    buildonly-randconfig-003-20250222    gcc-12
i386    buildonly-randconfig-004-20250222    clang-19
i386    buildonly-randconfig-005-20250222    gcc-12
i386    buildonly-randconfig-006-20250222    clang-19
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250222    clang-19
x86_64  buildonly-randconfig-002-20250222    gcc-12
x86_64  buildonly-randconfig-003-20250222    gcc-12
x86_64  buildonly-randconfig-004-20250222    clang-19
x86_64  buildonly-randconfig-005-20250222    clang-19
x86_64  buildonly-randconfig-006-20250222    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

