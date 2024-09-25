Return-Path: <linux-kernel+bounces-338278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F569855D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704EE1F24F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA3D158A18;
	Wed, 25 Sep 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WR4o+FvX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954822AE6C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254035; cv=none; b=ko4P3XlEH3IDbSLLfqFomGZMC25wJqP6dHg2kirX8rwucAJC4t8GVodl1oivvJjBRG5L1Jr2x6RXIq+MhIoJ8ycZPVeALRA6z6ZCXFAyzjhwyBUbL6/9T2Tzb8YQZhVty3Fx5lPfSFXsPWKhsCl7+jR3meCcopZ6+J8miwe2LKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254035; c=relaxed/simple;
	bh=xH4QVy5AJPkB+FVCrwJ8QbZVsuCF8oiWdp6wBn7OtbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a9qK0hBKKLZ46LxZNQKIc7+7BewBK3bDScc32qQOZCzQpgu+8Ti+M458mGpfKhP6pHpisIW3AAnsvXeVPmRA6/Nh9TztjJ644qvMo3sNyj14K+tbTqM+H1j/A59q6vluzGPbuiGpwHd02Fo0QTgwTUPSqis59paIeNOAW6BwX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WR4o+FvX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727254033; x=1758790033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xH4QVy5AJPkB+FVCrwJ8QbZVsuCF8oiWdp6wBn7OtbU=;
  b=WR4o+FvXgz7are7gKxXL4gFTAFUYbdN/oNp8G9C6hOi4YPqTD7rP24zI
   oBLg1ndbqf/mmagxwNgW68cwRDXgMGheeZB9xQEo1puY/My8BW5JxGp+G
   Qq+XhF9pVIqwTtjI1ao6Ev/ZbhbvVoOfTTScYz5LWOJl4JJ+oFR7V0zVC
   6gDeCKx7FeouZWc2xc/Lyl6LNEBdvI19yk68ag7EmSr0/0Rpq55iOFnVT
   19vmnrKtZSD1Bku0wS/FE1ddSjLGvAGokY1okv2k23+v7tdEFBSsTz3IY
   SPON4kbkNLlHEk4pFELbiXZZbGr9j17whG+Gqqa6Ffo7HqPRYAWNxQAfy
   g==;
X-CSE-ConnectionGUID: arFA2XPkRUCnKddMJq8Vxg==
X-CSE-MsgGUID: Pk9xcoCTQfaVqJE1hyBmtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="13914063"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="13914063"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 01:47:13 -0700
X-CSE-ConnectionGUID: dlFn7rn5T1SEetn87SkgGw==
X-CSE-MsgGUID: oAoTrJlGSaKYyF9pq9FUdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="76093998"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2024 01:47:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stNfw-000JNj-1r;
	Wed, 25 Sep 2024 08:47:08 +0000
Date: Wed, 25 Sep 2024 16:46:15 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: ld.lld: error: call to __compiletime_assert_135 marked
 "dontcall-error": BUILD_BUG_ON failed: !__builtin_constant_p(res)
Message-ID: <202409251656.lmhUs1ya-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   684a64bf32b6e488004e0ad7f0d7e922798f65b6
commit: 7adaf37f7f104a7ee5f150af491674ccbbfc4114 lib/bitmap: add compile-time test for __assign_bit() optimization
date:   6 months ago
config: um-randconfig-001-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251656.lmhUs1ya-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251656.lmhUs1ya-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251656.lmhUs1ya-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: call to __compiletime_assert_135 marked "dontcall-error": BUILD_BUG_ON failed: !__builtin_constant_p(res)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

