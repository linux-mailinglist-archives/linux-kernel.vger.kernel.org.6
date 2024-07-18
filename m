Return-Path: <linux-kernel+bounces-256434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49787934E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D1628117D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2704143749;
	Thu, 18 Jul 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q2NJB9ej";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNm6GMU8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E799142E8D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310501; cv=none; b=R2emWMpUTlPGiU1VVRwwoBndsQ51/whdq8xRldnrFopkjLxBUhhARcWUubMpPkXUqJNWRZw1FPsKVWU0ZhQ78zmoS1j+AzgH30z13cZag2hB4aFnVwN94XPxqhx9XmjehekBEP8/WJyIP8/g6vbn4DZySzbxGUCQ/Ypee6pI+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310501; c=relaxed/simple;
	bh=YQguu2KHDGLSQtluTqZhX9pzhXNXS2HlFcfYCnZAL4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFPoO9cqrqUSlNmW0cFTRaxbKBCcUK/vIwD+YA+wF7JwH5wfN9jJ+H3Nb1Kbu6dwFRyLvMjMg9hEv9H+PpbNgXmwQUjxca4lxE8PrslDMueasNuMuiako94qvvCk+IW5jzV2ur2IOuuh6VDoFGLk86X7c1gk0sV9UHGRLhCuEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q2NJB9ej; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNm6GMU8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBX60tEUojcaueoLY683EuE1AdH6RbQ/WsO6+FqW4Yw=;
	b=Q2NJB9ejiD85toYHlbZryyW0wCDyPIww5b53tx6wEQJ0Hn66MC+EjzUUVpoAn7nisJlXFN
	6rOqeGOWDb8AzqBTPmSqsOHt3NnDbvsmKGsQiofEgnkaI+b9yehF5l0nd+ACCZ23NincF7
	icpii5kUuC4d9PYoEkKS/efTSRPtB43UrvH9bIdlkhwtnqXmpLFPWN2MN16NHcXov7hbvM
	Vj+4bZ9VJCLX4IoQyriFnyzADauazKtaQx8iSrV0rbu+79jGL425QMuCMClUAk+td8bBiv
	0XLSAqiIpjAAROC8TrNtDR1fXOlBhq8fh+x1s2iUi5fl7p+XR5X/qIZ0e6QHpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBX60tEUojcaueoLY683EuE1AdH6RbQ/WsO6+FqW4Yw=;
	b=FNm6GMU8EJUJj9kUCgrv/mQlyVpncV/QhSwBcu/XMYBQsbNKgCWMWqOA9n9q6KF8dnhTXe
	KsruR9C7VMaTXiAw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 4/9] tools/x86/kcpuid: Protect against faulty "max subleaf" values
Date: Thu, 18 Jul 2024 15:47:44 +0200
Message-ID: <20240718134755.378115-5-darwi@linutronix.de>
In-Reply-To: <20240718134755.378115-1-darwi@linutronix.de>
References: <ZpkckA2SHa1r3Bor@lx-t490>
 <20240718134755.378115-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Protect against the kcpuid code parsing faulty max subleaf numbers
through a min() expression.  Thus, ensuring that max_subleaf will always
be ≤ MAX_SUBLEAF_NUM.

Use "u32" for the subleaf numbers since kcpuid is compiled with -Wextra,
which includes signed/unsigned comparisons warnings.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index a87cddc19554..c93015ee02e0 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -7,7 +7,8 @@
 #include <string.h>
 #include <getopt.h>
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#define min(a, b)	(((a) < (b)) ? (a) : (b))
 
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -207,11 +208,10 @@ static void raw_dump_range(struct cpuid_range *range)
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
 	u32 max_func, idx_func;
-	int subleaf;
 	struct cpuid_range *range;
+	u32 subleaf, max_subleaf;
 	u32 eax, ebx, ecx, edx;
 	u32 f = input_eax;
-	int max_subleaf;
 	bool allzero;
 
 	eax = input_eax;
@@ -256,7 +256,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		 * others have to be tried (0xf)
 		 */
 		if (f == 0x7 || f == 0x14 || f == 0x17 || f == 0x18)
-			max_subleaf = (eax & 0xff) + 1;
+			max_subleaf = min((eax & 0xff) + 1, max_subleaf);
 
 		if (f == 0xb)
 			max_subleaf = 2;
-- 
2.45.2


