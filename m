Return-Path: <linux-kernel+bounces-313439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDE96A57A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4843628689F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D017BA1;
	Tue,  3 Sep 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F790yIkV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F718DF8B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384896; cv=none; b=eEnCD6b2nN3nrPINkqy8yX1+8+IRPYc1ETlgddQO4ca933bW11E6F8cWDPFmTTwQWy7F3oTR8trPRKhli4Nd8oUpUfUtLrThfgZUkqdWwG4UejM81XlyXXu1rK1Yc9RCK1RuPOtq0behkXw0lDGUf2epAImmi4z95sixKLdEWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384896; c=relaxed/simple;
	bh=7zFa9+GlWtDjIZ/Wl3c7es83abZ/27P7Fsgc41gqdLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaJHYIaqWcBDgoB3b0ov1ARUyKBbns2Glv7nBasBTnYanSiALV9dNWpJ2Vdm9NcJBeuJRvJgaWuDij1PR2HujEjfWpc+08E+UrB9Ep2P7rPJVJsDM0c01dknzzYxU6qoMj+c+wgBpChsTFHMju4to1lw61IT3LBpUtvuIqGbpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F790yIkV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725384896; x=1756920896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7zFa9+GlWtDjIZ/Wl3c7es83abZ/27P7Fsgc41gqdLM=;
  b=F790yIkVH5fc7loewJJpqsaEU6eSbylMbz4TRCj0T/ruQWVOHimB4fQC
   Qdj0LPjYp7n6lOW3e/W28G0rgfvNBvlRjfMLGz4X2FbPx5mG8PXmoI4Up
   bmcwRXqZW5fU2Mx1ipj6kgdgZy7vPjPNBx6s8eOTT9rC+5UX8IosTXW3e
   hwx9jHaLU0SSDShQFHPrYeead/TdfhGGHcIjf7wFeENUWs9WOpXGmU/2o
   9DBspstPI9YEIVzTWEMsnUejNFuCFrSxLc/T4ImOfyx4Dh+fpQ8cCQcel
   V2K/SFXbPIgtoLbnq1eRo8FSZO/zHy9DP+0FnbjaHmt7DQXNcdiAf9moZ
   g==;
X-CSE-ConnectionGUID: YlJZgmPYQKqeBXBLoGjQzg==
X-CSE-MsgGUID: ymDbTRmoQkWNJ5jWYx/zPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46528522"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="46528522"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:34:55 -0700
X-CSE-ConnectionGUID: UgDc9cXVRt+HJKHbZZipQg==
X-CSE-MsgGUID: lE1O4ow9Sui0KKWHtgHugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65715870"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:34:54 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 0/3] Final pieces of Intel new families support
Date: Tue,  3 Sep 2024 10:34:40 -0700
Message-ID: <20240903173443.7962-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All except one of the precursor patches were merged to Linus' tree
in the v6.11 merge window. The exception is a one-liner that is in
the maintainer tree and linux-next, but didn't get pulled this time.

Here's that patch (cherry-picked from intel-next so it has Chanwoo
Choi's sign-off). Also the two cleanup patches that remove all the
old FAM6 specific infrastructure.

All on top of TIP x86/cpu branch.

Signed-off-by: Tony Luck <tony.luck@intel.com>

Tony Luck (3):
  extcon: axp288: Switch to new Intel CPU model defines
  x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
  x86/cpu/vfm: Delete all the *_FAM6_ CPU #defines

 arch/x86/include/asm/cpu_device_id.h | 20 -------
 arch/x86/include/asm/intel-family.h  | 85 +---------------------------
 drivers/extcon/extcon-axp288.c       |  2 +-
 3 files changed, 3 insertions(+), 104 deletions(-)


base-commit: fd82221a59fa5ce9dc7523e11c5e995104a28cb0
-- 
2.46.0


