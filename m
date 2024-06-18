Return-Path: <linux-kernel+bounces-220139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F0890DD1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FDE1F23942
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA1C171E7C;
	Tue, 18 Jun 2024 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZm/kMOi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1515E5DB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741712; cv=none; b=hSmZhw3Vt92+AIpVtRqxKZjmAcwoPqEFWQKwifyMba7tRvnXV4lOTCc82YuzryZ8uc1WZxgR8eZyNPMhNoy6qIrwb1BZR+Ki70XP66sbUxeo4P0rRtwwVpwTQgoBoL3lLA41I+91aZl+yfiN8kekL2aZpPOLoXAP2PYESJF/+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741712; c=relaxed/simple;
	bh=3u5ZYx2viIRdKn2+8IB6OfzsZkO78QpKE453qoVhfYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDvoxujH6XCTYLtbEpAaCltwhWYdb/jkkJJvdMo2551SGr78rO87yQof0z59fexzynh2eVXl/A+tznM4pMJDL1FfKgoOlNvlZoZ4nk6oMDx/tdH2JZCGmE9sIqgwUqkDqnwig5pNk2pB6cDR4OYYQNYXFDCsNuF7sSvnyj2flKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZm/kMOi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718741710; x=1750277710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3u5ZYx2viIRdKn2+8IB6OfzsZkO78QpKE453qoVhfYs=;
  b=QZm/kMOiDmg1+uywQ+zxBuTGRcLO1ZDMFBmF9ePfvQaZ2Q/jPD1MY57F
   lPYQBM8WbekSu5tiPGPqILQ8x2SwdMEtekjRMH2YesgresMNanTiYRv5H
   PqcTt9E2qMyvc+5dGzItHcnMGp6kWTx6NHjKZCT0SDR+OjWdynN1822WV
   8PKlhxz13PeTM1qrpRHl11lMQ1pSkYAhLWa54Sz4apc/yrenAikOUWoLc
   UIB8UIm2IfYJc7cQrS5xrW4E0rp/c2Gj7n6Kee1mA1k2ETR96c+zmwIts
   U8k3meYC34H4dANoK8LJp5ExD7aGqe6L37fBKFikJExuWAAYxnhCE879Q
   w==;
X-CSE-ConnectionGUID: cmOrs1J6SaGgFqyk6osUjg==
X-CSE-MsgGUID: zcySI07vSBi3+2GKZ5GzjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15413303"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15413303"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 13:15:10 -0700
X-CSE-ConnectionGUID: 9bQlaUKuQ8m8rMygSIvJ4A==
X-CSE-MsgGUID: 4BesqGuLSwuKt1MNktl9lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41769139"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa009.fm.intel.com with ESMTP; 18 Jun 2024 13:15:10 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/irq: Fix comment on IRQ vector layout
Date: Tue, 18 Jun 2024 20:13:20 +0000
Message-Id: <20240618201320.2066726-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f5a3562ec9dd ("x86/irq: Reserve a per CPU IDT vector for posted
MSIs") changed the first system vector from LOCAL_TIMER_VECTOR to
POSTED_MSI_NOTIFICATION_VECTOR. Reflect this change in the vector layout
comment as well.

However, instead of pointing to the specific vector, use the
FIRST_SYSTEM_VECTOR indirection which essentially refers to the same.
This would avoid unnecessary modifications to the same comment whenever
additional system vectors get added.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/irq_vectors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 13aea8fc3d45..970a89e7c6b7 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -18,8 +18,8 @@
  *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
  *  Vectors  32 ... 127 : device interrupts
  *  Vector  128         : legacy int80 syscall interface
- *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
- *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
+ *  Vectors 129 ... FIRST_SYSTEM_VECTOR-1
+ *  Vectors FIRST_SYSTEM_VECTOR ... 255 : special interrupts
  *
  * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
  *
-- 
2.34.1


