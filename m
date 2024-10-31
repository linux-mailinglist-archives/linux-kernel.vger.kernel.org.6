Return-Path: <linux-kernel+bounces-390381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 366009B7920
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF09E281D47
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB1199E9C;
	Thu, 31 Oct 2024 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpsh03mg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC513199EB0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372113; cv=none; b=nkowcS2nbg5/T2cCXPBi+/bP+h9DOLm0qLLMkZ5CCFRZIJd2PAeNpd8vnOc0gXC7pD8rWFl6gOZ6hh5ETFwt4fd2E3x/oLSE1EaV6t2OPMKzoL4kzJvLFoGXiJFWQ2WkcNBcl0l/BxB4wRJq+qMlQ3NBPPpeQbyZ/rb1hb387jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372113; c=relaxed/simple;
	bh=ecYjbnODmCzrBa7RlMNJgPSwNS9hjFXL+H+kwpDNdrI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BJ5cJbAB9NqAjk/9oXP9XVYVufwRJZ1AwlgzER0kVDn10ft71RqGCf2y0TXANl2Hgkv5rIKtbUnlucq/LSetGN3gVwRwLNqgwXSoLA62w7z9A0MuSGW+KYiMxUr88Y6O0ju3xjmlKFyRad+SSceFjRO0FPYT/AyoaKtSTIx+b58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpsh03mg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730372111; x=1761908111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ecYjbnODmCzrBa7RlMNJgPSwNS9hjFXL+H+kwpDNdrI=;
  b=mpsh03mgzm+bKDIh+aAOCrQeKC22dQXlQdriEkKv5a+m9lCioFzVjkhQ
   jdm7jIdOXniwgBe1e/hRmKZBykNeIM7/roNcXmEfTnM6dosC6ulYNkyms
   I06yhEKjyKCBQGkprP9ln7dFGU2H6dHlFMU+ESv0cGWgf1SNSifuZkAu9
   1Lt6mNQWTs4KeaE0L3jG+aU3LY6pHT4g+JT7CySVs5bj18yXrz+uBXSkf
   0gfv3/q2x9KqFfXHHREY2U5x7L0IrUSXApGJmc6anZQf+efqRLPgQNHuh
   JyWfDyPOZ1r0aOE7uYvzneWkSt2gi/ZVs4e8GtOWoyr8r5lL02IQt5oZg
   g==;
X-CSE-ConnectionGUID: dlC4o7VpSU2xRQAfoUfPTA==
X-CSE-MsgGUID: 5xEfqxV8ReCqk83ZtlKDmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="47578512"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="47578512"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:55:11 -0700
X-CSE-ConnectionGUID: 6W5owVfaQGWRl3fGJSBNGA==
X-CSE-MsgGUID: ayhbZiP6Sp+/EtFSbZMMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87380423"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 31 Oct 2024 03:55:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6SpX-000g0e-1N;
	Thu, 31 Oct 2024 10:55:07 +0000
Date: Thu, 31 Oct 2024 18:55:06 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: include/linux/ioremap.h:21 is_ioremap_addr() warn: always true
 condition '(addr >= (0)) => (0-u32max >= 0)'
Message-ID: <202410311824.fJAhvOUy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0fc810ae3ae110f9e2fcccce80fc8c8d62f97907
commit: ac88ff6b9d7dea9f0907c86bdae204dde7d5c0e6 riscv: fix VMALLOC_START definition
date:   11 months ago
config: riscv-randconfig-r071-20241030 (https://download.01.org/0day-ci/archive/20241031/202410311824.fJAhvOUy-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311824.fJAhvOUy-lkp@intel.com/

smatch warnings:
include/linux/ioremap.h:21 is_ioremap_addr() warn: always true condition '(addr >= (0)) => (0-u32max >= 0)'

vim +21 include/linux/ioremap.h

016fec91013cfb Baoquan He 2023-07-06   7  
016fec91013cfb Baoquan He 2023-07-06   8  #if defined(CONFIG_HAS_IOMEM) || defined(CONFIG_GENERIC_IOREMAP)
016fec91013cfb Baoquan He 2023-07-06   9  /*
016fec91013cfb Baoquan He 2023-07-06  10   * Ioremap often, but not always uses the generic vmalloc area. E.g on
016fec91013cfb Baoquan He 2023-07-06  11   * Power ARCH, it could have different ioremap space.
016fec91013cfb Baoquan He 2023-07-06  12   */
016fec91013cfb Baoquan He 2023-07-06  13  #ifndef IOREMAP_START
016fec91013cfb Baoquan He 2023-07-06  14  #define IOREMAP_START   VMALLOC_START
016fec91013cfb Baoquan He 2023-07-06  15  #define IOREMAP_END     VMALLOC_END
016fec91013cfb Baoquan He 2023-07-06  16  #endif
016fec91013cfb Baoquan He 2023-07-06  17  static inline bool is_ioremap_addr(const void *x)
016fec91013cfb Baoquan He 2023-07-06  18  {
016fec91013cfb Baoquan He 2023-07-06  19  	unsigned long addr = (unsigned long)kasan_reset_tag(x);
016fec91013cfb Baoquan He 2023-07-06  20  
016fec91013cfb Baoquan He 2023-07-06 @21  	return addr >= IOREMAP_START && addr < IOREMAP_END;
016fec91013cfb Baoquan He 2023-07-06  22  }
016fec91013cfb Baoquan He 2023-07-06  23  #else
016fec91013cfb Baoquan He 2023-07-06  24  static inline bool is_ioremap_addr(const void *x)
016fec91013cfb Baoquan He 2023-07-06  25  {
016fec91013cfb Baoquan He 2023-07-06  26  	return false;
016fec91013cfb Baoquan He 2023-07-06  27  }
016fec91013cfb Baoquan He 2023-07-06  28  #endif
016fec91013cfb Baoquan He 2023-07-06  29  

:::::: The code at line 21 was first introduced by commit
:::::: 016fec91013cfb27c9f5a101a87ae8266537fed1 mm: move is_ioremap_addr() into new header file

:::::: TO: Baoquan He <bhe@redhat.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

