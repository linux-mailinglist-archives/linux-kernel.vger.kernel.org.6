Return-Path: <linux-kernel+bounces-539587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB3A4A61E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0817D3B72DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA51DEFF3;
	Fri, 28 Feb 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/+6nQxb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9AA1DED5E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782583; cv=none; b=Iuk2Z4Ge1v1b1H2b/L8ZsbQBl3pg7GrBNBUlkuKzDIvfxr+ers6ZoQJdpNZ0ozNmpSL8JwLSUZPlmuaPaaA9TfbMB/5rNAyyplISoVTomwIQ5IbMZz1z+yrhxFcQmg7r0hhmr1yQ/gDYfTySXPEuM523mclRvuErQQW5V5ffRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782583; c=relaxed/simple;
	bh=TWH3+Leu1GjgT4LOkCTdBR6h2THqbgicKh+r1ne1TDk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rfuz2AMNXvinpcSbjjFB8MB++rtX2lLbPnZ7PhdZdSmPrectell/7ODj96wyTDu9PSh5X+K1hTPMLy/mPdVujsbxo8PP6IkDwHIX5Su/CnbLP525MfwmqzeJGYzDrgg1UzZBLcVGbb83KpP7LyMLMM6+gV24aKVCI5MgSDC/5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/+6nQxb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740782582; x=1772318582;
  h=date:from:to:cc:subject:message-id;
  bh=TWH3+Leu1GjgT4LOkCTdBR6h2THqbgicKh+r1ne1TDk=;
  b=G/+6nQxbSCLGu7fQktVb1gOV4iGpDePE3lK509qLRmU7g8I0DetiX2Eq
   t5OlC+iAHkxrA60R6OOXCGX6DbJEohQ8SLygx3T+xPt9Q3aYGebgAIDAF
   8sj3XObC0sIN11sC0I4t6tOy0vxNz9yhsCLw5dRMAqQrc19zac/hA3Xqm
   5f7lQ851KasCzSNCEp8KOORGnOLmcgSkQ1lm4IItVaBVwOanhZHAPyaru
   DLIbcCKDTAFDlxsQ2u1miq3dDarG7WJN++cr5V+G097T49OWAWJ2V4yne
   mJfiOl4Jl8H6pin8ubvvg1R/EKn84lXKH4MiHshrJ5FrFtv95CzoykPFk
   A==;
X-CSE-ConnectionGUID: Z8tr2zNuQGyRuXxvTkOmDg==
X-CSE-MsgGUID: yQmGyGlFTnm+ZvdU8cNC5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41844303"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41844303"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 14:42:59 -0800
X-CSE-ConnectionGUID: Ysz2wdPWQbeXyqsXMSIB1w==
X-CSE-MsgGUID: 6Gz3zddXTomXc1frtLqO9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117651796"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 28 Feb 2025 14:42:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to94K-000Fb1-2k;
	Fri, 28 Feb 2025 22:42:56 +0000
Date: Sat, 01 Mar 2025 06:42:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 e008eeec7868a9ca6e159726aeb9bdbf2ab86647
Message-ID: <202503010634.BbDx8dBT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: e008eeec7868a9ca6e159726aeb9bdbf2ab86647  x86/platform: Fix missing declaration of 'x86_apple_machine'

elapsed time: 1457m

configs tested: 12
configs skipped: 126

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250228    clang-19
i386    buildonly-randconfig-002-20250228    clang-19
i386    buildonly-randconfig-003-20250228    gcc-12
i386    buildonly-randconfig-004-20250228    clang-19
i386    buildonly-randconfig-005-20250228    clang-19
i386    buildonly-randconfig-006-20250228    clang-19
x86_64  buildonly-randconfig-001-20250228    clang-19
x86_64  buildonly-randconfig-002-20250228    clang-19
x86_64  buildonly-randconfig-003-20250228    gcc-12
x86_64  buildonly-randconfig-004-20250228    clang-19
x86_64  buildonly-randconfig-005-20250228    gcc-12
x86_64  buildonly-randconfig-006-20250228    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

