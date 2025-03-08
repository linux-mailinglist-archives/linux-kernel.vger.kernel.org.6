Return-Path: <linux-kernel+bounces-552290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C6A577FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C66177938
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D615687D;
	Sat,  8 Mar 2025 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlpOoTXF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBD16C850
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405226; cv=none; b=OVyDymNWUNH85TY1Sv3Tr+Xep3lSC8xmxMtb5Th3VSxGSk+8h0wrY2zHXTmtcZl9QA3578C3f+/UoO5TfMQIM7yCL6VZM6SuLqARVNKgjNwj3DQFA5mg59m157P/3nk0JB7bxd/Kyz47QiPpHfDGRCMh9qftcfNA1Rrhg9jXq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405226; c=relaxed/simple;
	bh=2r59/F6+F07rrRCTZ0yrIvXAg7Bv2XTMySH4ZPwc8Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ja/SeITxAo0tXwr+bOGPQ4nf1SRSyDhEy6DChgHjsjh7CXVQIFzDx7fGcc7BaQ5gHzdgDsBLUm1OJiBENLukkUBoMxA+LgcBfegtHgyEgRk1P6LU9/DUGtplKf7o6Hocjdditck7KGJPxPmQ7zBe2FeEht3lgEX+QnuLmpEkm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlpOoTXF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741405226; x=1772941226;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2r59/F6+F07rrRCTZ0yrIvXAg7Bv2XTMySH4ZPwc8Yg=;
  b=mlpOoTXF9F6x63CILvLCoCpddF39rXlINnzcb4WWIWs3Cqn71DFiihlI
   bavKi3/Zq5jxuLBZ9LLT9+J19zbvSpnYIkCeO1VKHduu92z9aRfCiQBnY
   zxQAtR5dvmT+6TqYfEoV1qSkeHpvi/DiD3p7jeMRmnP/JVBs4uzbYZ3ME
   g6PY5fG05GCfdoCTL2ZjZV+Wrih8+4so4C5mPwTylDWRr2/axeGZNTtYx
   hhJOYVF7uWD6IVgMj1Dau+mx016IlxbriB2uJnv2/mzpQV57dX4af+CmO
   a/3QwcZgTshkWulxIIiLX/L8R3U3MRL8F1hGaQNPponVl8QktEnDDLHux
   g==;
X-CSE-ConnectionGUID: 1fYETQdtQKmVwVTjYoJkIA==
X-CSE-MsgGUID: blmKbCe0Q6S2ry/Wql/g9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="53850587"
X-IronPort-AV: E=Sophos;i="6.14,231,1736841600"; 
   d="scan'208";a="53850587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 19:40:25 -0800
X-CSE-ConnectionGUID: P8EMT3ffSdK8lVrPTqL7WQ==
X-CSE-MsgGUID: G4Sfd5XER6yFmLvHrLPM7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120012759"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 07 Mar 2025 19:40:24 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tql2w-0001Qz-2K;
	Sat, 08 Mar 2025 03:40:19 +0000
Date: Sat, 8 Mar 2025 11:39:34 +0800
From: kernel test robot <lkp@intel.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x2e: relocation to
 !ENDBR: machine_kexec_prepare+0x79e
Message-ID: <202503081112.DOWVLRrj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e4543a2e2f8538373d1d19264c4bae6f13e798
commit: b3adabae8a96fee62184f4236bf60313b35244e9 x86/kexec: Drop page_list argument from relocate_kernel()
date:   3 months ago
config: x86_64-buildonly-randconfig-006-20250308 (https://download.01.org/0day-ci/archive/20250308/202503081112.DOWVLRrj-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503081112.DOWVLRrj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503081112.DOWVLRrj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ___bpf_prog_run+0x40: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x2e: relocation to !ENDBR: machine_kexec_prepare+0x79e

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

