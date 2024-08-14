Return-Path: <linux-kernel+bounces-286459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F2951B23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC141C2296D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFA1AED5C;
	Wed, 14 Aug 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xh23E6Ox"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645225762
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639681; cv=none; b=lnmOJ7+Q8lX814St/lVLVLlYNFZTIunHqJxl3l9siCuY50c8CgsnRTpV8NivuV1UcU/qlna1M3bBZFSGghKCPBPX3AB7TGV6DjKrWeVApKHoMiu1r3dSL1LOmxlrTK7/ny/+mGp6hpOP+VNXqUKJ3opvui80M8Q6YMLfwVKU37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639681; c=relaxed/simple;
	bh=1xPynpjNbCKWm9E5vepoZGouMezTTbo/NShSGVQ5lPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q36bprQ9BO6M02iJTpP0IBYEhFyo9GgGzx2zVwrKWA3D2su643ZDQYD+TDo8hJr5KDBxBf+JEFMQz47NbxxKwnNoATdUFa++kYDLrlyNNNbb3aRZkhEnxQ7rIQwb1Zt87gOAHNcTcLlLk/nFZpewjqnAS8Z3PGXZ+ddlsx9DtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xh23E6Ox; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723639676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OXk9KF6StaqEG5iu1ePo6KF1o4K/TokO3WbvUgn7zt4=;
	b=Xh23E6OxfokbaqH93fMIx2WGu6qwqaWKtSYCguhpxuhLQCCpUkWp2UOxANk64Nogg0UW47
	YDZIVBZsMKvgCPF5rL/h6FT5FSOdza9PpiRLrZM+miVNC2X/afIEOS5Ra182cF9W7H5Gxn
	5KDFGpqlb54DKI9GZZeLNlz1R6fHMpM=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] x86/mm: Remove duplicate check from build_cr3()
Date: Wed, 14 Aug 2024 20:46:45 +0800
Message-ID: <20240814124645.51019-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is already a check for 'asid > MAX_ASID_AVAILABLE' in kern_pcid(),
so it is unnecessary to perform this check again in build_cr3(). Remove it.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 arch/x86/mm/tlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..5bc87519e13e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -160,7 +160,6 @@ static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
 	unsigned long cr3 = __sme_pa(pgd) | lam;
 
 	if (static_cpu_has(X86_FEATURE_PCID)) {
-		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 		cr3 |= kern_pcid(asid);
 	} else {
 		VM_WARN_ON_ONCE(asid != 0);
-- 
2.46.0


