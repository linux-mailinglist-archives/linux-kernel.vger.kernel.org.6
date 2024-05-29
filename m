Return-Path: <linux-kernel+bounces-193400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5298D2B67
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA441F2507F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17615B543;
	Wed, 29 May 2024 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOqQQVO0"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08B15B142
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952901; cv=none; b=q4K1Zr6FDjLYRnsb/JB5gldIaN1xYxvGhbRh2I03ZCciYtbew7Wb15qlmpQD5blp+7n2VVZcybS4WITqVb991ZZDHRmCUA8fsG0BZ51Tk9WQk3VQAeA1OIrxTMcJxMwg39dR2MXSX22Y77FWTe59rp5qEhhA1oMvjQLuI5RhXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952901; c=relaxed/simple;
	bh=GcpaW2tSmyb8bUi81zgjajcNH/uy8Tlm01Nmn7doTr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cyp5JvFPHfE6vezA4DNLt1iQEZTcC3Z18AxQcb+qjiU1FMhDwj0DsQ0iNXbr4m88ormE7YG1ZrgUlHJYBZ5RjGdrBKK2HMUrsyv0cJYOvow8G8oLQG2icCpCY8sRRhX9w5svPVQOndGcmHW0ZFtm9/UZvpEw+jEK9lIeF5og+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOqQQVO0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tglx@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716952896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tBQ0SWuGto2+tnNBupBquurgxTeZl3CZ4DgxqTLQa4U=;
	b=EOqQQVO0en++l0nG6Iz4XpP8VZ16M8fXCNGmQoEMFn7j+/Wjwuu7Md9urtaT2o7TTiV9MP
	JnMTxmdgsk3PJ8M0jb9HvZLSC4kGKkMadm+oyIA6Y8LmqFaktPvz3FNm11rWAK2/CDurfp
	pZZDvSRUT2atmg8lLUCUJKAzGDOs0ko=
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: x86@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mjguzik@gmail.com
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/2] x86: Remove the prefetch() specific implementation on x86_64
Date: Wed, 29 May 2024 11:20:58 +0800
Message-Id: <20240529032059.899347-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

After commit ab483570a13b ("x86 & generic: change to __builtin_prefetch()"),
x86_64 directly uses __builtin_prefetch() without the specific implementation
of prefetch(). Also, x86_64 use a generic definition until commit ae2e15eb3b6c
("x86: unify prefetch operations"). So remove it.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/x86/include/asm/processor.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cb4f6c513c48..44371bdcc59d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -599,9 +599,6 @@ extern char			ignore_fpu_irq;
 #ifdef CONFIG_X86_32
 # define BASE_PREFETCH		""
 # define ARCH_HAS_PREFETCH
-#else
-# define BASE_PREFETCH		"prefetcht0 %1"
-#endif
 
 /*
  * Prefetch instructions for Pentium III (+) and AMD Athlon (+)
@@ -616,6 +613,10 @@ static inline void prefetch(const void *x)
 			  "m" (*(const char *)x));
 }
 
+#else
+# define BASE_PREFETCH		"prefetcht0 %1"
+#endif
+
 /*
  * 3dnow prefetch to get an exclusive cache line.
  * Useful for spinlocks to avoid one state transition in the
-- 
2.34.1


