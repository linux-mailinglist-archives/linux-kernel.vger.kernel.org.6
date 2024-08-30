Return-Path: <linux-kernel+bounces-308973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A7966477
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E8F1F21F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212B1ACDF5;
	Fri, 30 Aug 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4EHjN5N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBB1ACE00
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029356; cv=none; b=ccCp032dH6Gpivvf5WvXGUZNE9v1MmXYMV+bGwIRqlWHhvZhi0wyKP6LbNqcDN3TYoY4AX4dF+crcINzX38lLJ4vBv6azvT9iIQuOtzqfZNZBnRM6IKUfkxcG+4z1EWUbUokCCVpPpT2XnnbXeF6SBoMc6Pvh/mhUFMBVUcWibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029356; c=relaxed/simple;
	bh=apyKO4C9iH5n3YNCK86T70dEAAgE07aoPeR8imFNCVw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fa6a3FBSQRdkpplpnbGEdQdXNEwTsZLdEOMvILu7Wl5ixd7K9IzO8ge5fpUMWmKPmx3oazVTSIsm38Nsx5eRZj3Jz9C9kp0wwWL/tbZKA++GmPqFLpoqttl2oxI94CqdTl8M7h8Z1D/FysFmumwpqAnWh5xFHqhhJeJa4cQDhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4EHjN5N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725029355; x=1756565355;
  h=date:from:to:cc:subject:message-id;
  bh=apyKO4C9iH5n3YNCK86T70dEAAgE07aoPeR8imFNCVw=;
  b=g4EHjN5N/wqv7OjsIP0BlZI++GVctDPz9GFj4/Z/xh9MHsfQq3WcuPiT
   rzcuCvNKaEUeeZGkAZ4CvnX5RemG1HVIm3ei6sMVvUjG8XMHXkj/xxgHc
   ed6br7Bc4DYR6Fh2zmKP+eUVVD6y6I681m43zooMvniBk/PY1kvMQ2xsR
   TLH8mVvJey6WirWjwbI8/PF/8JXYPqM0kwGCn2Pb6rVI/47mHy8TlYLR1
   52GkhmlveBeE0I8N6tNOl2CZ+E1V94KSaiPruLUwSfKvs5Pz4N9ATi/BM
   CjgSzoIBBDt9btBfnk5Tm1oyTdEY+jeTgUidofoY+K7Ud4M8ekxPiEWNu
   Q==;
X-CSE-ConnectionGUID: 0cptqgGiQnqMk0mb9dDGdA==
X-CSE-MsgGUID: UUlx4DsuTRyn1DbNnvvQsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49058330"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49058330"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:49:15 -0700
X-CSE-ConnectionGUID: Beee6BoRSguPpu7FVcPLLQ==
X-CSE-MsgGUID: W5+l1Yr/SASeBExe2Sz9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64668291"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Aug 2024 07:49:13 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk2w2-0001YE-3B;
	Fri, 30 Aug 2024 14:49:10 +0000
Date: Fri, 30 Aug 2024 22:48:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 a678164aadbf68d80f7ab79b8bd5cfe3711e42fa
Message-ID: <202408302223.4KOG5MzL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: a678164aadbf68d80f7ab79b8bd5cfe3711e42fa  x86/EISA: Dereference memory directly instead of using readl()

elapsed time: 1472m

configs tested: 6
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
openrisc                          allnoconfig   clang-20
parisc                            allnoconfig   clang-20
powerpc                           allnoconfig   clang-20
riscv                             allnoconfig   clang-20
s390                              allnoconfig   clang-20
um                                allnoconfig   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

