Return-Path: <linux-kernel+bounces-283826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A594F912
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7015C1F229C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78506194A6C;
	Mon, 12 Aug 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TituLxiy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5624D112
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499150; cv=none; b=CYl+3TaojwxNt3PBegAn18K0F+4WQ0NXwiiZrbW0xsQen2oHcnomgRTFHtFgqTUrkHQYpw5+sxaiAAM2o/jct4+VnE9N8Gx46zULHZuOMoheepNjco3oakuAcQIVUZElsRhkNukbEC6alzZnFv3jA/tboz55LmSt4G4up43fB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499150; c=relaxed/simple;
	bh=c9/nZZC49SGYoGnpOubzdQR2Rp9YymVDcurivgmT7OI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eK0dhLG8VEaz0MM8q/eeNV1YDlMSZ+FQnFDZILUji+DxNj/PfcLlS23o61+E025vmMQ+l7qugOIKQkA6shUmF9gIV8Hz61N68v9wnevgnCMONpfvwj9nCu8jOlBlVOcEas85QZAYKmv4+PEe5qVCUh4HZTfLYmlBMj/sLcfPc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TituLxiy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723499149; x=1755035149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c9/nZZC49SGYoGnpOubzdQR2Rp9YymVDcurivgmT7OI=;
  b=TituLxiyyddLt33qSBHrGfbhzB9X/Gx06dZHLz6R/Zml4HpFFAESaclT
   L66OefyUVgZ0fJfUZ4S0ZoV0PCfDH1b2OgUr/Jjd1oru0aBM0dKRjCqEf
   BZKhTdHr0WTA72p7M4PbSJZ5bP66LWDYEfnD3axynSloxpVOTx3QmR/8o
   iAhQ4jgjEtGpNfjzk6SgSinSwcfIm2hk+OZ+OIVLwV63tXGVjJj4Cwmh/
   dSwMQDbuAsofQiuOB2HMFS9vAs3ev2fto+fG8/wOpuaKI5PyVBYL+ecEl
   ToRhrsly7Lq0VHpB/vR6W8QHd0v2ejH2ztgkmxkFTBXeVFkmfs1qXW1vM
   Q==;
X-CSE-ConnectionGUID: 4gJ/gQuFQFazeyNUrYxfOg==
X-CSE-MsgGUID: GKbK+iKZSDe0q6ImElAy3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21194417"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21194417"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 14:45:48 -0700
X-CSE-ConnectionGUID: 0HcQ2W73TxmdfhsViIGO2Q==
X-CSE-MsgGUID: 1ggG1Wz/RkCr1wJhNIImzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="58502109"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 12 Aug 2024 14:45:48 -0700
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
Subject: [PATCH v3] x86/irq: Fix comment on IRQ vector layout
Date: Mon, 12 Aug 2024 21:43:18 +0000
Message-Id: <20240812214318.2715360-1-sohil.mehta@intel.com>
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
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
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


