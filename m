Return-Path: <linux-kernel+bounces-563052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9AFA63657
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EE97A6CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD431C5D56;
	Sun, 16 Mar 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KM7Jw9j+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826072E3373
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742140602; cv=none; b=p6V+v+kLiCr56AaWIGiTm8puewMn7T5Ll2M489hHtKL66IyKp2qIWEEEtzOe777LE8qrnOplPsuSmEHOWgCJy5SUUd70olPLzqRSod+Kd5ps8OX4rabSEYUmC5CzUWYyBY//falSm711jc/5pniMqya0oeeS3SUnZgdlTLyo3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742140602; c=relaxed/simple;
	bh=aS4aFoN8HwweoUFCgBFGAC6wY7cDxKXBsmEzkmxJ1Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H2rFSt7ZB+cgAJ6o1PSP6kIcy0jH/uhCsIDHfsl9vynVLV3tBS0NSdhk7MjxjEVm1KmOzvu49WjGMjIUqmZmc01SO0G4d+/9LwsnePp+wbsSD2TFryzPMrCXWa+Ls2GYb9XT7kXTvp7Xrp0Fqji2dcdzcDtwiHH4si2yA5rqn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KM7Jw9j+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742140599; x=1773676599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aS4aFoN8HwweoUFCgBFGAC6wY7cDxKXBsmEzkmxJ1Cw=;
  b=KM7Jw9j+ooDXLnEPY1UJ29DaF/GM+tlmLPNWr3TNLnxz4MCOBYDEw0yz
   8DZtb5hlYz5YnaE1sB6fPMMB7yN6HYG15zWm6FsEmyMNa7ZMg/jhlbxaN
   sOopbjpWcGgrXn7JW57s+srsBqPkfiMPRTbWQKuU16SOHut5x7DTZ06XU
   DckeiGBkePtt+hnN4L6cUFS/qiPP6cc5EYO3bta1v+7hXnnRHewXQ8yl3
   X55NBcfyA/RUJM5W/0KiaERJhtl4YWodjM765pv4MOShe9h9cngoiUbzZ
   Xu3UzTSrKajTB3bqTg5qErHDFm/Z60HLiaB1hmTwXLezzm9Zu8uCLe8PO
   w==;
X-CSE-ConnectionGUID: zV4nprdQSES+Tk36Th5/qA==
X-CSE-MsgGUID: Nkq17ZhBTkiv1j2j3so2VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="42415961"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="42415961"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 08:56:38 -0700
X-CSE-ConnectionGUID: dJK4oq/nTkyYLIIP8dwotQ==
X-CSE-MsgGUID: iGFj0y+kTkW8tXq4L3j4Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="122680093"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2025 08:56:36 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttqLq-000C4T-0r;
	Sun, 16 Mar 2025 15:56:34 +0000
Date: Sun, 16 Mar 2025 23:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Rong Xu <xur@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Kees Cook <kees@kernel.org>
Subject: vmlinux.o: warning: objtool: .text.dib8000_tune: unexpected end of
 section
Message-ID: <202503162331.necMbaVm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb82ca153949c6204af793de24b18a04236e79fd
commit: 315ad8780a129e82e2c5c65ee6e970d91a577acb kbuild: Add AutoFDO support for Clang build
date:   4 months ago
config: x86_64-randconfig-001-20250316 (https://download.01.org/0day-ci/archive/20250316/202503162331.necMbaVm-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250316/202503162331.necMbaVm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503162331.necMbaVm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ___bpf_prog_run+0x1f: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: .text.dib8000_tune: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

