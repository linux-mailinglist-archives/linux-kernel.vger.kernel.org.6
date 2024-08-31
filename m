Return-Path: <linux-kernel+bounces-309862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BBC967135
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1863281755
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB92E17E005;
	Sat, 31 Aug 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjXD/yaY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125117C9E4
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102844; cv=none; b=tv9vLT4nosMkPLxejpSoy6uOFUX4GrvnF0hdU/P6Zvga4ybJVOLD4Xpe9FGVY0uw0m3njYdgR59H3r0SffcN75PXY4E/4L0WJ8OA94I5GUAa8gI7QJ+DGhyGqUy2RNdLVFF1WDRCBSzn1r0W4RBGhHz/nVsHKyl/yc+HhPooV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102844; c=relaxed/simple;
	bh=LM3xGck7UAlqF7NmfikweUo6m0ubdToMj1V+5d9pvO0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HisV8atReSUKIiKEWCC2Mh+H2+nE4dm38UYMAfiRVg5j18STXyZKjohLGdLYHYyp8sGc+NgaqgSwc8LPNe/pt2uWvgGVOWJkOXYbH2J0eyRRduCkhehqN9r+JTdjOhgu820nD+tNBmGEKOZmQN5IM/XbMiPkBEjQ+ZY8LctS7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjXD/yaY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725102842; x=1756638842;
  h=date:from:to:cc:subject:message-id;
  bh=LM3xGck7UAlqF7NmfikweUo6m0ubdToMj1V+5d9pvO0=;
  b=ZjXD/yaYA5tQQdTrtercRd6xtmVPBa0etGwynYJi0D8VysrM83hw9pPM
   g8KRyb1IP9XmPtVcTiTe1gR88zRwW7jJ+c6p74AJb3r98jviGbvTXecVZ
   tKprALhli6ayh4EfsK1aHy2KCNuF4gj15Sidne18rgxKIRyUugR0kjMSf
   KiI4An92K+O+JPdV+2vQc3GbeF3BOrBrngAl1hP87mMOIaAPqJItrTZdh
   1m8Q16BxFA9/7H967BbqDszlMz4W9HaUYmpKVENJ/WD7aqpoXRoWSDm1L
   8onsQlYh/4QT/Ge+M1qFVpUnWfdgynOtBVUhkAN1S/UP4kHwudIh8rj0w
   Q==;
X-CSE-ConnectionGUID: XzXRS5xYQaW+yMhAtIex/w==
X-CSE-MsgGUID: sp5ISpEERwmpoZU4DlUJEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23609009"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23609009"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 04:14:02 -0700
X-CSE-ConnectionGUID: xvurR/qHRLWeU854WdSfOg==
X-CSE-MsgGUID: Eg9e6FpjQHaUZCYOAgIRvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="68977014"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2024 04:14:00 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skM3J-0002fE-39;
	Sat, 31 Aug 2024 11:13:57 +0000
Date: Sat, 31 Aug 2024 19:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.30a] BUILD REGRESSION
 05416eb79213ad6a9770faa795059fdd00adb6e0
Message-ID: <202408311953.fAZUyQRI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.08.30a
branch HEAD: 05416eb79213ad6a9770faa795059fdd00adb6e0  refscale: Add srcu_read_lock_lite() support using "srcu-lite"

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202408311318.wcMCNEWH-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202408311452.nS2HBgqc-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202408311559.fzAoy2aD-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202408311649.7FRBYdiC-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

include/linux/srcu.h:246:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
include/linux/srcu.h:246:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
include/linux/srcu.h:267:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NMI'
include/linux/srcu.h:267:37: error: 'SRCU_READ_FLAVOR_NMI' undeclared (first use in this function)
include/linux/srcu.h:274:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_LITE'
include/linux/srcu.h:274:37: error: 'SRCU_READ_FLAVOR_LITE' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- alpha-defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- alpha-randconfig-r121-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- arc-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- arc-nsimosci_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- arc-randconfig-r061-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- arm-allnoconfig
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- arm-randconfig-004-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- arm-randconfig-r111-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- arm-vf610m4_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- arm-vt8500_v6_v7_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- csky-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- csky-defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- csky-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- csky-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- hexagon-allnoconfig
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- hexagon-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- i386-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- i386-randconfig-011-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- i386-randconfig-013-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- i386-randconfig-014-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- i386-randconfig-015-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- i386-randconfig-016-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- i386-randconfig-051-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- i386-randconfig-062-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- loongarch-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- m68k-allmodconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- m68k-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- m68k-allyesconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- m68k-amiga_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- m68k-defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- m68k-randconfig-r072-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- microblaze-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- microblaze-defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- mips-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- nios2-alldefconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- nios2-allmodconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- nios2-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- nios2-allyesconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- nios2-defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- nios2-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- nios2-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- openrisc-defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- openrisc-or1klitex_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-r051-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- powerpc-adder875_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- powerpc-ebony_defconfig
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- powerpc-mvme5100_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- powerpc-storcenter_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- powerpc-tqm8540_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- riscv-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- riscv-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-allmodconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-allyesconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-randconfig-r054-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-se7780_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-secureedge5410_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-sh7763rdp_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sh-sh7785lcr_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sparc-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sparc-defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sparc-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sparc-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sparc64-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- sparc64-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- um-allyesconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- um-defconfig
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- um-i386_defconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- um-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- um-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- um-randconfig-r063-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- um-x86_64_defconfig
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-allnoconfig
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-buildonly-randconfig-004-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-buildonly-randconfig-005-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-randconfig-004-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-randconfig-005-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-011-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-013-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-015-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-randconfig-016-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-075-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- x86_64-randconfig-104-20240831
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_LITE
|   |-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NMI
|   `-- include-linux-srcu.h:error:use-of-undeclared-identifier-SRCU_READ_FLAVOR_NORMAL
|-- x86_64-randconfig-123-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- xtensa-allnoconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- xtensa-allyesconfig
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- xtensa-randconfig-001-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- xtensa-randconfig-002-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_LITE-undeclared-(first-use-in-this-function)
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
|-- xtensa-randconfig-r052-20240831
|   |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
|   `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)
`-- xtensa-randconfig-r064-20240831
    |-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NMI-undeclared-(first-use-in-this-function)
    `-- include-linux-srcu.h:error:SRCU_READ_FLAVOR_NORMAL-undeclared-(first-use-in-this-function)

elapsed time: 1100m

configs tested: 187
configs skipped: 5

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                        nsimosci_defconfig   clang-20
arc                   randconfig-001-20240831   gcc-14.1.0
arc                   randconfig-002-20240831   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          ep93xx_defconfig   clang-20
arm                          gemini_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240831   gcc-14.1.0
arm                   randconfig-002-20240831   gcc-14.1.0
arm                   randconfig-003-20240831   gcc-14.1.0
arm                   randconfig-004-20240831   gcc-14.1.0
arm                        realview_defconfig   clang-20
arm                         vf610m4_defconfig   clang-20
arm                    vt8500_v6_v7_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   clang-20
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240831   gcc-14.1.0
arm64                 randconfig-002-20240831   gcc-14.1.0
arm64                 randconfig-003-20240831   gcc-14.1.0
arm64                 randconfig-004-20240831   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240831   gcc-14.1.0
csky                  randconfig-002-20240831   gcc-14.1.0
hexagon                          alldefconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240831   gcc-14.1.0
hexagon               randconfig-002-20240831   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240831   clang-18
i386         buildonly-randconfig-002-20240831   clang-18
i386         buildonly-randconfig-003-20240831   clang-18
i386         buildonly-randconfig-004-20240831   clang-18
i386         buildonly-randconfig-005-20240831   clang-18
i386         buildonly-randconfig-006-20240831   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240831   clang-18
i386                  randconfig-002-20240831   clang-18
i386                  randconfig-003-20240831   clang-18
i386                  randconfig-004-20240831   clang-18
i386                  randconfig-005-20240831   clang-18
i386                  randconfig-006-20240831   clang-18
i386                  randconfig-011-20240831   clang-18
i386                  randconfig-012-20240831   clang-18
i386                  randconfig-013-20240831   clang-18
i386                  randconfig-014-20240831   clang-18
i386                  randconfig-015-20240831   clang-18
i386                  randconfig-016-20240831   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240831   gcc-14.1.0
loongarch             randconfig-002-20240831   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   clang-20
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                            gpr_defconfig   clang-20
mips                          malta_defconfig   clang-20
mips                      malta_kvm_defconfig   clang-20
mips                        omega2p_defconfig   clang-20
mips                         rt305x_defconfig   clang-20
nios2                            alldefconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240831   gcc-14.1.0
nios2                 randconfig-002-20240831   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                  or1klitex_defconfig   clang-20
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                generic-64bit_defconfig   clang-20
parisc                randconfig-001-20240831   gcc-14.1.0
parisc                randconfig-002-20240831   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   clang-20
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                       maple_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   clang-20
powerpc                    mvme5100_defconfig   clang-20
powerpc               randconfig-001-20240831   gcc-14.1.0
powerpc                  storcenter_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
powerpc64             randconfig-001-20240831   gcc-14.1.0
powerpc64             randconfig-002-20240831   gcc-14.1.0
powerpc64             randconfig-003-20240831   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240831   gcc-14.1.0
riscv                 randconfig-002-20240831   gcc-14.1.0
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240831   gcc-14.1.0
s390                  randconfig-002-20240831   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240831   gcc-14.1.0
sh                    randconfig-002-20240831   gcc-14.1.0
sh                           se7780_defconfig   clang-20
sh                   secureedge5410_defconfig   clang-20
sh                        sh7763rdp_defconfig   clang-20
sh                        sh7785lcr_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240831   gcc-14.1.0
sparc64               randconfig-002-20240831   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240831   gcc-14.1.0
um                    randconfig-002-20240831   gcc-14.1.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240831   clang-18
x86_64       buildonly-randconfig-002-20240831   clang-18
x86_64       buildonly-randconfig-003-20240831   clang-18
x86_64       buildonly-randconfig-004-20240831   clang-18
x86_64       buildonly-randconfig-005-20240831   clang-18
x86_64       buildonly-randconfig-006-20240831   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240831   clang-18
x86_64                randconfig-002-20240831   clang-18
x86_64                randconfig-003-20240831   clang-18
x86_64                randconfig-004-20240831   clang-18
x86_64                randconfig-005-20240831   clang-18
x86_64                randconfig-006-20240831   clang-18
x86_64                randconfig-011-20240831   clang-18
x86_64                randconfig-012-20240831   clang-18
x86_64                randconfig-013-20240831   clang-18
x86_64                randconfig-014-20240831   clang-18
x86_64                randconfig-015-20240831   clang-18
x86_64                randconfig-016-20240831   clang-18
x86_64                randconfig-071-20240831   clang-18
x86_64                randconfig-072-20240831   clang-18
x86_64                randconfig-073-20240831   clang-18
x86_64                randconfig-074-20240831   clang-18
x86_64                randconfig-075-20240831   clang-18
x86_64                randconfig-076-20240831   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240831   gcc-14.1.0
xtensa                randconfig-002-20240831   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

