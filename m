Return-Path: <linux-kernel+bounces-338199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE899854A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AA5281A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A6157A67;
	Wed, 25 Sep 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQm9owQs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09615575D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250914; cv=none; b=D4UM96Rfw2O2G0/HAighVV+FV6lXTWKYQIw+6rSUhl7tEDTLpG+rDpIqwWKHB2Xak6Dk5BC5iirvmF1IP+q6x/Pe1rBtet2dxpY4YIq/XzyxBE7rsMLxxBP5m9V2BlbPxpZDlkNooD0L06lue2PZxgJgU6ozF4/3kXGRxjti8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250914; c=relaxed/simple;
	bh=b0VS4/jEEGlzTy44pY3j4sBQZIIBNVFoJ7AlR5R3STI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nnoOPGzMfvJGwxfXWxq6pBWqQwL+r+axQGVS6KAaqlhr7JQoWG0znu/hpOXyMbMPcwoEEeDsWmOqVJ5XjTMVgPv91A02CMHdSi3yUfREdx64goFkMC0KfKPGvD3MBg2/SOKWBWpgstz/aqPuQK0IoR4jYtGfWa4EjoKPtuOGaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQm9owQs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727250912; x=1758786912;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b0VS4/jEEGlzTy44pY3j4sBQZIIBNVFoJ7AlR5R3STI=;
  b=cQm9owQsIe4DkUNZP9+HNnxpHF7byG2Y8+03jre5Gh25jUosZXiwjlYg
   h98oVO1GLbmDF+IZcAC4V4XoPxlD5FG1Ci0wSDzkTmv+C1OGxiAa2U5Eo
   t1xD/5/f6aEan4prJzVNTz6zKC3LUSeOAy4tiVSjF9kK5q5xpOlQ8rRrl
   u1aIMHh/0MN5YXEoAc0VhXzC17CwaFU6Gdal8iv7tfDJDEX/tktX0anDV
   XTTinyiTXpD3TN883WfWxU83R4GLM25VPW5WwgHLcRgDMTtLI2W+EQi4i
   6/CG6ZUiPVW8k5bKLK812P3R6I4jiHfaNRmOHHm6tQTUHWBkW5LxVjQ3d
   A==;
X-CSE-ConnectionGUID: foe7lJngTuWxnyAXUmcyng==
X-CSE-MsgGUID: pnZR7KYCT4mX5rBxlcKAwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26423925"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26423925"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:55:11 -0700
X-CSE-ConnectionGUID: RS87beaJQZW0poBFtZdJGQ==
X-CSE-MsgGUID: /VgGPflETXypTeTFvr+wWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="76451445"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Sep 2024 00:55:09 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stMra-000JKj-0z;
	Wed, 25 Sep 2024 07:55:06 +0000
Date: Wed, 25 Sep 2024 15:54:20 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>
Subject: ld.lld: error: unknown argument '--ppc476-workaround'
Message-ID: <202409251512.QHl7WqZN-lkp@intel.com>
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
commit: e3a9ee963ad8ba677ca925149812c5932b49af69 kbuild: Fix changing ELF file type for output of gen_btf for big endian
date:   7 months ago
config: powerpc-randconfig-002-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251512.QHl7WqZN-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251512.QHl7WqZN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251512.QHl7WqZN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: unknown argument '--ppc476-workaround'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

