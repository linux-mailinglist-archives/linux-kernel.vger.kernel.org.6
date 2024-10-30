Return-Path: <linux-kernel+bounces-388433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848099B5FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D4B1F22C92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329BD1E47D9;
	Wed, 30 Oct 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrvRigsu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1CD1E3770
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282412; cv=none; b=rZJBTioYwxr4w1mj3rmPFKdRkwfg063HNlf/B3zvt43REMXTdMfeNOBEiJRB6ZNl6/s5VrHmZqiJrVtVB5eEBXY4ycqCoXGGhyZ9k3D6Cwjwt5Wk119nC7OKSz00T/ixUxi1Mx6usaqsqeXJlfwdulrTCX9rvWD/Co1W9cvwJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282412; c=relaxed/simple;
	bh=+2rUC+oZodItjVLMgJHFowQV9oxa5BnxOdrQw0PuJ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nv1zFgYlyPrmPF3Igqw/dPj128BcqVJxPycVpJCn2Udd0VBdakwiTJdIXOMqZfwC3gnsSYrEKrDUs+KSnZCi9hv8W3Ety2w1FRI0brLU+ebJkgREqB4jFcvHvoSBFsv/chH+/WSpj+cBcuuzyWTz4G3QK2Knhv+uI3ZfcNYaTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrvRigsu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730282408; x=1761818408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+2rUC+oZodItjVLMgJHFowQV9oxa5BnxOdrQw0PuJ9c=;
  b=QrvRigsu0I3wi8CbbSSyArpPSYaFM8eZNdX8Npxvl8pj+4eviWweJMMq
   BK9v9899YPJgNuo4MaUVwgOg8C6E6UeNGY7CfNRi93dxneSiWn6gO8qeQ
   uLc1t1hVROOhdYalxWUOZeunyzqAnYEgYhr4rtK6mh/dT39noKAB9wFbI
   Tp7S+qcVDIzJP6G6CcNb9ZtVCUdSmF+9UEcmXkTDhJpRPcHs74vvWxmxk
   3aWL/gSJmRsp/I7hztnYIb/S/3qr6BqCfO5Fizt6u3R+QsEoqULlI90Ej
   iS00cPwxsCtcZuWi1lwFgUrtj2zq33Omw8gPJLNBqPTDbN178xFgd4W2E
   Q==;
X-CSE-ConnectionGUID: 2fljfqlAQwSSZmh0oLyrng==
X-CSE-MsgGUID: TXK9EsTuSpq/CXaBEh5ULw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29739894"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29739894"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 03:00:07 -0700
X-CSE-ConnectionGUID: 9Kend+ssSSCoYdGXDqBClA==
X-CSE-MsgGUID: TqjM95h8T/i5Eig/AByidg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82675779"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Oct 2024 03:00:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t65Ug-000eiq-1h;
	Wed, 30 Oct 2024 10:00:02 +0000
Date: Wed, 30 Oct 2024 17:59:46 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Marco Elver <elver@google.com>
Subject: drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202410301756.eonkDCSy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1e939a21eb111a6d6067b38e8e04b8809b64c4e
commit: 2e577732e8d28b9183df701fb90cb7943aa4ed16 kasan, fortify: properly rename memintrinsics
date:   5 months ago
config: powerpc-randconfig-r122-20241029 (https://download.01.org/0day-ci/archive/20241030/202410301756.eonkDCSy-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241030/202410301756.eonkDCSy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410301756.eonkDCSy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:406:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:407:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:407:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:407:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:449:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be16 [noderef] [usertype] __iomem *reg @@     got unsigned short [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:449:23: sparse:     expected restricted __be16 [noderef] [usertype] __iomem *reg
   drivers/net/ethernet/freescale/ucc_geth.c:449:23: sparse:     got unsigned short [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1317:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1317:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1317:26: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1344:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1344:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1344:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1390:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:1391:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:1391:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1391:22: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:1402:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:1402:36: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1402:36: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:1571:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1571:38: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1571:38: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1636:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1636:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1636:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1824:41: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1824:41: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1824:41: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1839:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1839:50: sparse:     expected void const *objp
   drivers/net/ethernet/freescale/ucc_geth.c:1839:50: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1864:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1864:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1864:33: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1876:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1876:42: sparse:     expected void const *objp
   drivers/net/ethernet/freescale/ucc_geth.c:1876:42: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1965:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1967:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2013:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:2013:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2013:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:2016:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:2016:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2016:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:2160:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void *_res @@
   drivers/net/ethernet/freescale/ucc_geth.c:2160:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2160:40: sparse:     got void *_res
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse:     expected void const *
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse:     expected void const *
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse:     got unsigned char [noderef] [usertype] __iomem *
>> drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse:     expected void *
   drivers/net/ethernet/freescale/ucc_geth.c:2168:17: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2188:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2188:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2188:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2221:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void *_res @@
   drivers/net/ethernet/freescale/ucc_geth.c:2221:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2221:40: sparse:     got void *_res
   drivers/net/ethernet/freescale/ucc_geth.c:2248:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2248:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2248:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2310:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2310:32: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2310:32: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2316:57: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2316:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2316:57: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2328:35: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2328:35: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2328:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2376:37: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2376:37: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2376:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2457:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing @@
   drivers/net/ethernet/freescale/ucc_geth.c:2457:45: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2457:45: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing
   drivers/net/ethernet/freescale/ucc_geth.c:2677:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2677:64: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2677:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2944:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2944:21: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2944:21: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:3010:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:3010:46: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3010:46: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3138:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3159:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3160:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3160:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3160:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3162:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3162:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3162:22: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3168:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3168:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3168:38: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +2168 drivers/net/ethernet/freescale/ucc_geth.c

728de4c927a354 drivers/net/ucc_geth.c                    Kim Phillips     2007-04-13  2138  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2139  static int ucc_geth_alloc_tx(struct ucc_geth_private *ugeth)
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2140  {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2141  	struct ucc_geth_info *ug_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2142  	struct ucc_fast_info *uf_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2143  	int length;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2144  	u16 i, j;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2145  	u8 __iomem *bd;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2146  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2147  	ug_info = ugeth->ug_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2148  	uf_info = &ug_info->uf_info;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2149  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2150  	/* Allocate Tx bds */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2151  	for (j = 0; j < ucc_geth_tx_queues(ug_info); j++) {
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2152  		u32 align = max(UCC_GETH_TX_BD_RING_ALIGNMENT,
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2153  				UCC_GETH_TX_BD_RING_SIZE_MEMORY_ALIGNMENT);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2154  		u32 alloc;
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2155  
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2156  		length = ug_info->bdRingLenTx[j] * sizeof(struct qe_bd);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2157  		alloc = round_up(length, align);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2158  		alloc = roundup_pow_of_two(alloc);
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2159  
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2160  		ugeth->p_tx_bd_ring[j] = kmalloc(alloc, GFP_KERNEL);
64a99fe596f9cb drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2161  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2162  		if (!ugeth->p_tx_bd_ring[j]) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2163  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches      2013-04-13  2164  				pr_err("Can not allocate memory for Tx bd rings\n");
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2165  			return -ENOMEM;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2166  		}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2167  		/* Zero unused end of bd ring, according to spec */
9b0dfef4755301 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19 @2168  		memset(ugeth->p_tx_bd_ring[j] + length, 0, alloc - length);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2169  	}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2170  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2171  	/* Init Tx bds */
53f49d86ea2108 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2172  	for (j = 0; j < ucc_geth_tx_queues(ug_info); j++) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2173  		/* Setup the skbuff rings */
6da2ec56059c3c drivers/net/ethernet/freescale/ucc_geth.c Kees Cook        2018-06-12  2174  		ugeth->tx_skbuff[j] =
33deb13c87e561 drivers/net/ethernet/freescale/ucc_geth.c Rasmus Villemoes 2021-01-19  2175  			kcalloc(ugeth->ug_info->bdRingLenTx[j],
6da2ec56059c3c drivers/net/ethernet/freescale/ucc_geth.c Kees Cook        2018-06-12  2176  				sizeof(struct sk_buff *), GFP_KERNEL);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2177  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2178  		if (ugeth->tx_skbuff[j] == NULL) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2179  			if (netif_msg_ifup(ugeth))
c84d8055e0c997 drivers/net/ethernet/freescale/ucc_geth.c Joe Perches      2013-04-13  2180  				pr_err("Could not allocate tx_skbuff\n");
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2181  			return -ENOMEM;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2182  		}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2183  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2184  		ugeth->skb_curtx[j] = ugeth->skb_dirtytx[j] = 0;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2185  		bd = ugeth->confBd[j] = ugeth->txBd[j] = ugeth->p_tx_bd_ring[j];
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2186  		for (i = 0; i < ug_info->bdRingLenTx[j]; i++) {
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2187  			/* clear bd buffer */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2188  			out_be32(&((struct qe_bd __iomem *)bd)->buf, 0);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2189  			/* set bd status and length */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2190  			out_be32((u32 __iomem *)bd, 0);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2191  			bd += sizeof(struct qe_bd);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2192  		}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2193  		bd -= sizeof(struct qe_bd);
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2194  		/* set bd status and length */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2195  		out_be32((u32 __iomem *)bd, T_W); /* for last BD set Wrap bit */
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2196  	}
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2197  
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2198  	return 0;
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2199  }
e19a82c18f0e63 drivers/net/ethernet/freescale/ucc_geth.c Paul Gortmaker   2012-02-27  2200  

:::::: The code at line 2168 was first introduced by commit
:::::: 9b0dfef4755301d9f7fcef63e2f64d23649bebb4 ethernet: ucc_geth: simplify rx/tx allocations

:::::: TO: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

