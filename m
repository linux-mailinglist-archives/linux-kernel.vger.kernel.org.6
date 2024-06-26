Return-Path: <linux-kernel+bounces-231412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128B919876
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9481C21600
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1871922FF;
	Wed, 26 Jun 2024 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWRZHeVu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103613C833
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431124; cv=none; b=dKun2FU+Lmqx3G5wHJegaFbu43pnTermPcq8twVVWiHxmRpHnf0KDPR4nBG8LQJxemXjTjvh1OatI3kgRuaAO1yMgbTZNm2nSQi8TxQ1aEo0eUwNfw6JOfXIRE6qab1tXQwl4nrCyA/QxePSOacbm7/BdYlMtP6NmASKn2oehX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431124; c=relaxed/simple;
	bh=cMovmJDB3AwhykMNcOCKtCQphhN+hrr5VnQpSSU7yNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BGYBjYn149KWLTDr233Z6Oqxy5OyRaBAjt0pnIpMmPrc1lUwlB/ZToC1YN93TPKXU7N0kbqXJ1I9uwNxQNLHdHn4IkB2UjYmPiQKSSGla5sYaqcRqfhgtHhYIfrqj6Zyh4o0G61Nz8lX98n6qT5huFWEoO2nD+LsWW8GYd9hwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWRZHeVu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719431123; x=1750967123;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cMovmJDB3AwhykMNcOCKtCQphhN+hrr5VnQpSSU7yNo=;
  b=TWRZHeVuuDYOn+Gf3PYJuFq7N6sszImNfY5axcLOovx6bOox/4IWOJ3A
   URH2PPvtPTPLSqOSg8XNzY2QMDwq0+Z+dk/mEYmoFp1WOI1lkQXPjNX8f
   SrQYrnvzqIIUynBs3mi086l4ujbjASRHryzxmqQTCFe1hT9/QCP9OXCX8
   PDfe2vwPvhRPAG/qlKMwl+7QdYsiNZeqfiwVt+xr1KJv6dxg1haWOg+i/
   UTHRXspFznXq51JnMsieX9a4KOvXMW4a70K0lJpBxFocSWg/K2kJIeYSr
   cUaotwVh6Ulc12fiAKQikVkDG6KmubpX/2tNKuJhxS3CXFJD+y2iSVQ8R
   A==;
X-CSE-ConnectionGUID: lYdYU2USSG6mZ51JHmglaQ==
X-CSE-MsgGUID: qQpgoOntSWKRMC68V66Ouw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="20410916"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="20410916"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 12:45:22 -0700
X-CSE-ConnectionGUID: jDGqLSt1ReObEGbVXqQoag==
X-CSE-MsgGUID: vOR8z+L2Q3uNxqvQt8FUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="48479396"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 26 Jun 2024 12:45:22 -0700
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
Subject: [PATCH v2] x86/irq: Fix comment on IRQ vector layout
Date: Wed, 26 Jun 2024 19:43:24 +0000
Message-Id: <20240626194324.110388-1-sohil.mehta@intel.com>
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
v2: Update the table to denote the other device interrupts range. [Jacob Pan]

v1: https://lore.kernel.org/lkml/20240618201320.2066726-1-sohil.mehta@intel.com/

 arch/x86/include/asm/irq_vectors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 13aea8fc3d45..47051871b436 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -18,8 +18,8 @@
  *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
  *  Vectors  32 ... 127 : device interrupts
  *  Vector  128         : legacy int80 syscall interface
- *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
- *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
+ *  Vectors 129 ... FIRST_SYSTEM_VECTOR-1 : device interrupts
+ *  Vectors FIRST_SYSTEM_VECTOR ... 255   : special interrupts
  *
  * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
  *
-- 
2.34.1


