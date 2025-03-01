Return-Path: <linux-kernel+bounces-539870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D2A4AA16
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58C9169C3E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08611D5CDE;
	Sat,  1 Mar 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mroEZDk/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628401BD9C9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740823088; cv=none; b=pfh67JXUusX6kSTUu9pXqp5HoIA3Ct4wIb4C90NIxpqn0C5xjYwMuQjGJNkKIh8wyAQJfUkAzZVphxjXZiMylg9QtMyY4qqwrhr4i91CtNdUN8pWvoj14cj0sxqmTgN/m6Mq8Geg7LfBwmk2ENPJY74oWNdifRy6d4xav68h9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740823088; c=relaxed/simple;
	bh=9FdQkHzEiT2G9jOFLpBoWsJW290WwV2UL0T/HyNRzrE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ya5L7eho1DfrTZ90o742Vipri/YUMXlNNNFkIoVqPTdF1GEVjiJk8feS9tEFcZIRUsKRJaaKKzSLQoFGfQzbOehRwiwFJzmDR0b/Z11yfrHcRapTGKtB/XP4GuzG5z/QSxLV6+M1NRCBzEclpoESiYncSswLLhClwm4nxGHtn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mroEZDk/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740823087; x=1772359087;
  h=date:from:to:cc:subject:message-id;
  bh=9FdQkHzEiT2G9jOFLpBoWsJW290WwV2UL0T/HyNRzrE=;
  b=mroEZDk/1hp55ybrbBgcf/6SWky+jYVO4AcgAN5X01TW+omZP7YDKlyb
   1vMBE/W0Hr7f1f0L4KlfD6eBYg+2UJOaE3FOh23u+5fSFgdQ4+1biyJZZ
   N15GL6gHiLfbvwytxCU4pYonLvr2kbqXfBrylXns48PhHXz11bxI7ObRd
   QHPwm4ZK9Rsab7M6j6hYcktCsIBtfAcph78efjsh5lQ1F+UycETZGRSv7
   //0oHV66OiuiuiJpjG6n2oVrJLWiEDpt760pV3NZ0s98k7JrIEzzvMj6o
   U6tvwCKYIREm89dIK5lP11O3Fwj/zWLjkwTnsd127pcE8GAmN/bTyfKT/
   w==;
X-CSE-ConnectionGUID: dh8JQzKQRPCfvo2pRSYMSw==
X-CSE-MsgGUID: /9X2ErPxTRuJaSkdBWxj6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45400841"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45400841"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 01:58:06 -0800
X-CSE-ConnectionGUID: zyFHISPSQ0KdVAxjXemyCA==
X-CSE-MsgGUID: cCy/ZwHqSMG3ZFYTGiPz5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122554187"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Mar 2025 01:58:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toJbe-000G6q-28;
	Sat, 01 Mar 2025 09:58:02 +0000
Date: Sat, 01 Mar 2025 17:55:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 023f3290b02552ea006c1a2013e373750d2cbff6
Message-ID: <202503011735.c6ByJqcS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 023f3290b02552ea006c1a2013e373750d2cbff6  x86/locking: Remove semicolon from "lock" prefix

elapsed time: 1467m

configs tested: 16
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386    buildonly-randconfig-001-20250228    clang-19
i386    buildonly-randconfig-002-20250228    clang-19
i386    buildonly-randconfig-003-20250228    gcc-12
i386    buildonly-randconfig-004-20250228    clang-19
i386    buildonly-randconfig-005-20250228    clang-19
i386    buildonly-randconfig-006-20250228    clang-19
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250228    clang-19
x86_64  buildonly-randconfig-002-20250228    clang-19
x86_64  buildonly-randconfig-003-20250228    gcc-12
x86_64  buildonly-randconfig-004-20250228    clang-19
x86_64  buildonly-randconfig-005-20250228    gcc-12
x86_64  buildonly-randconfig-006-20250228    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

