Return-Path: <linux-kernel+bounces-415105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B189D319B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5FEB228EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A2EAF9;
	Wed, 20 Nov 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0rTXnH9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7D9461
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064860; cv=none; b=GeBRk1VHI6FOLTriYY79dO8vXeX0IVup2FPpBJotqf+wZ0dZMxMYwejYQdK458SDyIXujmzdOQrw+CLb5UPLX0CeQBcZTiIXcqovrWAuYMt+fQIU3bm03LsJXtTyS5w12cWRlDM5buIYvJhRMMP51BV9j6TtmAvbez1g5TKmYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064860; c=relaxed/simple;
	bh=RINpclmbXs5TCKXPq4s+R2Bq6Mry8qynw3t03zPmvDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n0JTuhPLNnm2wnO3UKgIGveztMnMIV2hjSVQipZqqy5Hobtw/cdxol5kJs5eXIBhbP14X18WSfHmB+C+VZSBJ10TW8ISp/9YSvT+tdMECIH3Y6IqDrjTKqn0vgEWJ0lTyxT9gaAnT503QNTUaN37CfuClTEHUBt97buFp2lf/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0rTXnH9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732064859; x=1763600859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RINpclmbXs5TCKXPq4s+R2Bq6Mry8qynw3t03zPmvDY=;
  b=T0rTXnH943lwF2FYxrRIUzsyeKjPLQ22Yy5DxMINWbKhSA4C+r6SUGSv
   /3MNDhe2i7F7lPUIjrs2dpR+R9HeCRC5TGEEOX2NWl+Bkp1as2nCmRSq6
   X8aG7bHP3SRhFwGJcEK8rwugMAqXgbqBJb3xeiN3Lf8ivPjlnPGKDdLF2
   O9rXS8meLlcYAtYzi6CMAhXEMdr0EtNCIAAIuLc2gQLDUAKgDZyp/Ja7U
   0JANyXG7aXwKueQiAGz9L4wZT5WuTSzCbqIwRh8Wd1qAvGxcZbW6Wki/j
   xv/EtxRleWQMBH++xCD+wvcH9vrUrFuSHg8YAMEQ8527UVY11XO/ugzSX
   Q==;
X-CSE-ConnectionGUID: DuFO0wGFRUqeGbdB89pEBA==
X-CSE-MsgGUID: SbLqwBwrTvCH9x9sJZHG0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31960632"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="31960632"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:07:38 -0800
X-CSE-ConnectionGUID: rRVela5eShO/qwBVQQtjpA==
X-CSE-MsgGUID: KSjrP1qiRaqpRoepy8kq5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="113031415"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2024 17:07:38 -0800
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/sgx for 6.13-rc1
Date: Tue, 19 Nov 2024 17:07:33 -0800
Message-Id: <20241120010733.807113-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull a single x86/sgx change for 6.13-rc1. It's a very small
one this round.

--

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.13-rc1

for you to fetch changes up to f060c89dc1a3cfb6db3894e1d96980a568aa355c:

  x86/sgx: Use vmalloc_array() instead of vmalloc() (2024-11-12 11:11:42 -0800)

----------------------------------------------------------------
 - Use vmalloc_array() instead of vmalloc()

----------------------------------------------------------------
Thorsten Blum (1):
      x86/sgx: Use vmalloc_array() instead of vmalloc()

 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

