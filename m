Return-Path: <linux-kernel+bounces-325661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503CF975CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B3DB21F88
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60414D702;
	Wed, 11 Sep 2024 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCGtBX7A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7413AA45
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092173; cv=none; b=nQwZPX9ggH5g4DBh/7Ie9zkuDVMN9FvFh7NClbuzDY9poSu4x9f/IvPtULtfT8k9s4kDj3tpVDQyu3zfWtyZlZZkfed57tWdZIperRuAOsaRVmUHWBrWRS6Cq8iJ+8eVAkj6JYHO6CbDWxbzbAv/DBniaqUaV0lhX0oSFkxxdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092173; c=relaxed/simple;
	bh=xMpuObgjXikWG7fNV0A/8aPWH354XHNMrK1owAgYlnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPGrYLw6wJ33buudLP2eN5DkWHwOvpy8yxcoooQb8+jMKhIuXnMxpNzjGG+c1GGpbosjWdLUCxBSCW3l5K4+pGrZCdazh3zeRI662cGhLjBjCtqOOGRdJpv5F/Rn3m0qX+fNQg+e4CzybGXI12gtIw1jXQIxOPHyUd+N+otkKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCGtBX7A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726092171; x=1757628171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xMpuObgjXikWG7fNV0A/8aPWH354XHNMrK1owAgYlnI=;
  b=YCGtBX7A6RuqKNy6xTsVWZ9slrmLcRxSa0sk6Z2n3bpTDij8ZaC9utSl
   48lho7TlcedxsvguwKjkvp19HKcy2KRn/x4dE24JBBMRtZ32DuCflPN2p
   JHZaRq2xaeeMSzinItTlVzftBLfCUpeQCAdk+84s5GGjsO35ZhTIbR2ox
   4rzFLP2M0infQ0s7icLFSA0B0qJSc6yPwd9nDNGi/UHyj1SBBvn9wc6eU
   Ff+EXwPHzceAGKu40CCGlryfzItWdWDy1M99nVltac80cMt9CRJo71oBQ
   sQ3mx7Mu7QHSoFsMkL6/z6FnJAus1a1yrcyz2lgjtylrUbAtiW37/FsQ5
   g==;
X-CSE-ConnectionGUID: gNjVbOC/SWireWwhirarJw==
X-CSE-MsgGUID: KEa5m+j9SQmpBMDr1LYdTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24459175"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24459175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 15:02:51 -0700
X-CSE-ConnectionGUID: CmljKjtCTfqmc9rpchJxmg==
X-CSE-MsgGUID: +WhkDPA3Q/KoPx0s+AiNpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67238252"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmviesa007.fm.intel.com with ESMTP; 11 Sep 2024 15:02:50 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/sgx for 6.12-rc1
Date: Wed, 11 Sep 2024 15:02:28 -0700
Message-Id: <20240911220228.4051834-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull some x86/sgx changes for 6.12-rc1. These fix a deadlock
in the SGX NUMA allocator. It's probably only triggerable today on
servers with buggy BIOSes, but it's theoretically possible it can
happen on less goofy systems.

--

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.12-rc1

for you to fetch changes up to c8ddc99eeba5f00b65efeae920eec3990bfc34ca:

  x86/sgx: Log information when a node lacks an EPC section (2024-09-05 15:20:47 -0700)

----------------------------------------------------------------
Fix deadlock in SGX NUMA node search

----------------------------------------------------------------
Aaron Lu (2):
      x86/sgx: Fix deadlock in SGX NUMA node search
      x86/sgx: Log information when a node lacks an EPC section

 arch/x86/kernel/cpu/sgx/main.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

