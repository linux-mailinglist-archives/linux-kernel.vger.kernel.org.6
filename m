Return-Path: <linux-kernel+bounces-348908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7268698ED7E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194921F20F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328E1531C0;
	Thu,  3 Oct 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhIciC8K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE821422C7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953228; cv=none; b=Z0qrjdIo7uPT6t6wdpdl9A3GXeMks/m6rVKg7iShgP3BNxS6W5xtaDai34qxZKhJpo9YlMNBkcRJsLLB/pTPbN0Oh6HrAOKX9WJN28vHUy8i/oU3nF8fcicU+4drLPY6U81AGReK45SgXdlW/kuixlR8CBd4A2JZ9rQWPgytqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953228; c=relaxed/simple;
	bh=7S9RPwBtIne7c69ZHQ/fRmgc8WabIOjO9LIicA2gK9A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Xdqp8bo7sViF2sgaFaabB7beyk73h3uwLZcOdVL5Sx28MN7klbSY4ZoDuczzQpHb2FWzCxDGPEnQOvCPT9yoEaQYZ+llAizBfDEh7WAtWJInZJ40y7V+zhsTYZf/lZo8JUPFi1n3oy6aKjlloRthNe5hQEc60fWgbLpa3A4w1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhIciC8K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727953227; x=1759489227;
  h=date:from:to:cc:subject:message-id;
  bh=7S9RPwBtIne7c69ZHQ/fRmgc8WabIOjO9LIicA2gK9A=;
  b=WhIciC8KHeHER+WkqosxRbnf3TmN/FpMjsCEJ+n/oPKVLBaaLInvPMmq
   9JsGjWnu5hYaaR3+gGv7I71AiRjeiqQA2ORSWpNMv3pRi5EK5GuR1lqK+
   6b3ajgZd/c2BV6EpbXYvWS2P3hxnTkOUxZhMvEa7GDqrNYGaEfBgRb3EQ
   vvABiPozvD+JpbuG5VgxbuFkanta+n7/CiAHpnER2MF5cyOcqefctKGhA
   WLX+9dJjP6Cf+pul2upNDO+cqjMvOpkju9vLaSRrqUREsGM/HyVfnwM1M
   Z7ZosAQ7b5+RyrJ6aB3fS6HXeG3zdfSdrqfNNGcaCYLsGMq68wyT7CRsP
   w==;
X-CSE-ConnectionGUID: qcHGkkkKQ9K7bc3Jcf0UJA==
X-CSE-MsgGUID: lkhipvQgQ0qghqyjcNKkBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="49664737"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="49664737"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:00:26 -0700
X-CSE-ConnectionGUID: 87hDI0BtRzGCUC7Vy8ARlQ==
X-CSE-MsgGUID: tAcuEB49QDaS6oaA1YNA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="78729811"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 03 Oct 2024 04:00:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swJZG-0000Jl-35;
	Thu, 03 Oct 2024 11:00:22 +0000
Date: Thu, 03 Oct 2024 19:00:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 f24f669d03f884a6ef95cca84317d0f329e93961
Message-ID: <202410031904.pcF8RmZP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: f24f669d03f884a6ef95cca84317d0f329e93961  x86/mm: Don't disable PCID when INVLPG has been fixed by microcode

elapsed time: 1007m

configs tested: 25
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc          allmodconfig    clang-20
arc          allyesconfig    clang-20
arm          allmodconfig    clang-20
arm          allyesconfig    clang-20
arm64        allmodconfig    clang-20
i386         allmodconfig    clang-18
i386          allnoconfig    clang-18
i386         allyesconfig    clang-18
i386            defconfig    clang-18
loongarch    allmodconfig    gcc-14.1.0
m68k         allmodconfig    gcc-14.1.0
m68k         allyesconfig    gcc-14.1.0
microblaze   allmodconfig    gcc-14.1.0
microblaze   allyesconfig    gcc-14.1.0
s390         allmodconfig    gcc-14.1.0
s390         allyesconfig    gcc-14.1.0
sh           allmodconfig    gcc-14.1.0
sh           allyesconfig    gcc-14.1.0
sparc        allmodconfig    gcc-14.1.0
x86_64        allnoconfig    clang-18
x86_64       allyesconfig    clang-18
x86_64          defconfig    clang-18
x86_64              kexec    gcc-12
x86_64           rhel-8.3    gcc-12
x86_64      rhel-8.3-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

