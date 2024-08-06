Return-Path: <linux-kernel+bounces-276983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493B8949AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E909B24B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30321176AA6;
	Tue,  6 Aug 2024 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RT7TP1dY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7665171E5F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981695; cv=none; b=qwfDrbjJvG7m5qrjTZwGi6bQ7AdP30CsB2gNW0Mk2G6DuyT5A/GotTHiKi7jqCS0ZVzlBrZo4lP46cdQK7SAPq9dIAWdVAOV4N1NdjCp5agXlGxDmZUDjTIpnqxAZq88452dFBtZu2urvNVkJcJ/dL/XGNKgX6QreHflXqiwXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981695; c=relaxed/simple;
	bh=URNOWa0wGNT/osRHjiDRfU3UakHqE6IDtJDz1Q6bAqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFuAm2TlROUOtYBLUtPKuDhHyQq7yy1Z3f1tXvDlMC8Eqgwp/lkmUs8/Zif9aNJGoqVcP+BsxEAqUi3Ugri8F6fUB0q/RsgNHB6UWBxpPWc/zyTD58hg+YWM0U2uECTYXdc4kG3d0GXvYeJoZbO8fxFqucPkILSGRNe4dnbxOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RT7TP1dY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc4fcbb131so9474665ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722981692; x=1723586492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mDFCS+qNW1uU6SrPB2NVd/Hs7xE2LjNwlpXcQuHr5E=;
        b=RT7TP1dY9V4aI0y65tz6ylyxw3zNhJ6hWj3WS2GXpW68gKRtQCCCLdZHTa3KAijPnt
         8BEozqBlC789U9H2/2f1/LyTif+RUJ5p+AgH6ve5tYQwhjRIsJPz25aEj0TCLppdeqc1
         Y9YgyKvwXKEe5hzXcAzyFAxDGbsbbhP0h7UEkK6VLC6sbDPIEUNTwHtf2J64W81WUhAf
         HjmtCUQb4W4YeNbxDcsIkyR1IzwX7ayqBpZ4RvieCSdohDAtqxgYztRVQeb10GWFTu0h
         1zj258eBI7M5jNDFXimWoD29p1pNdV5l7+a70q1ePkvEMgEvbhaOWVsFNaoS2SemwLSL
         LwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981692; x=1723586492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mDFCS+qNW1uU6SrPB2NVd/Hs7xE2LjNwlpXcQuHr5E=;
        b=B5AdcBqIENTD6xw7KKOJTQrhlLoNAtIiiY2ZufFZ4S8w5L+U/9V3T+xCz/s4w4Hwdq
         0N1icVbSFEbwioxIi2ya3+dM15D6bFn8wuMoqlMCBV4myxfIbMNCal/xuCOY/KoL8paf
         dUOWpQDKIhUVxTBlimOHQ6raOH5Bi1rqM2DxjQBu4nvoSYB0WK4CD7/SVtSYB4fjwCVm
         B4jHpQY3xZBvnobbBGdWohIAh/MmWkW2Efez3WCkeWffzDwQENT3RadZGSEqZ+pPwqJp
         2fPon5KJHve4vk6sKPa1aHVhr0BrsKtLCmnCZsbZ72ViQiUZ3QY1/pCXDe75upBwME1Y
         WxSg==
X-Gm-Message-State: AOJu0Yym65in/vdxCODGV9lmhjqVwLD78C9U1m7xNzL38BCWIxwacUHA
	E2SZy231eODlgJ9Fqhi90xzfCXadYrcH4oTGa7eolmpTeb5LwmbwfXKicFAWBFRaa8vmCi1Yyn1
	f
X-Google-Smtp-Source: AGHT+IHMDVM8yOtme1xU83E6UMVWq7phAYmH7RVRK4k7pmLlbIHTJUgxcAviBQUeH1SmZurbZu5n9g==
X-Received: by 2002:a17:902:e547:b0:1fd:684f:ca72 with SMTP id d9443c01a7336-1ff57281a68mr187939795ad.25.1722981691868;
        Tue, 06 Aug 2024 15:01:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f27340sm92578425ad.17.2024.08.06.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:01:31 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 06 Aug 2024 15:01:23 -0700
Subject: [PATCH v2 1/2] tools: Add riscv barrier implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-optimize_ring_buffer_read_riscv-v2-1-ca7e193ae198@rivosinc.com>
References: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
In-Reply-To: <20240806-optimize_ring_buffer_read_riscv-v2-0-ca7e193ae198@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722981688; l=2969;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=URNOWa0wGNT/osRHjiDRfU3UakHqE6IDtJDz1Q6bAqA=;
 b=Ox3MskkYW1G2EGWoBhbYzqpgqaJJhHmZFbKUWYHIa6zsjdc17EQvwOkVJEfD6unJtpK9tGoBr
 8i8Va7rmqxKDeNNd9lt+EZTE/qABfyeWCK4qH7r14Mit3lFzk8B3VWB
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Many of the other architectures use their custom barrier implementations.
Use the barrier code from the kernel sources to optimize barriers in
tools.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 tools/arch/riscv/include/asm/barrier.h | 39 ++++++++++++++++++++++++++++++++++
 tools/arch/riscv/include/asm/fence.h   | 13 ++++++++++++
 tools/include/asm/barrier.h            |  2 ++
 3 files changed, 54 insertions(+)

diff --git a/tools/arch/riscv/include/asm/barrier.h b/tools/arch/riscv/include/asm/barrier.h
new file mode 100644
index 000000000000..6997f197086d
--- /dev/null
+++ b/tools/arch/riscv/include/asm/barrier.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copied from the kernel sources to tools/arch/riscv:
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2013 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ */
+
+#ifndef _TOOLS_LINUX_ASM_RISCV_BARRIER_H
+#define _TOOLS_LINUX_ASM_RISCV_BARRIER_H
+
+#include <asm/fence.h>
+#include <linux/compiler.h>
+
+/* These barriers need to enforce ordering on both devices and memory. */
+#define mb()		RISCV_FENCE(iorw, iorw)
+#define rmb()		RISCV_FENCE(ir, ir)
+#define wmb()		RISCV_FENCE(ow, ow)
+
+/* These barriers do not need to enforce ordering on devices, just memory. */
+#define smp_mb()	RISCV_FENCE(rw, rw)
+#define smp_rmb()	RISCV_FENCE(r, r)
+#define smp_wmb()	RISCV_FENCE(w, w)
+
+#define smp_store_release(p, v)						\
+do {									\
+	RISCV_FENCE(rw, w);						\
+	WRITE_ONCE(*p, v);						\
+} while (0)
+
+#define smp_load_acquire(p)						\
+({									\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	RISCV_FENCE(r, rw);						\
+	___p1;								\
+})
+
+#endif /* _TOOLS_LINUX_ASM_RISCV_BARRIER_H */
diff --git a/tools/arch/riscv/include/asm/fence.h b/tools/arch/riscv/include/asm/fence.h
new file mode 100644
index 000000000000..37860e86771d
--- /dev/null
+++ b/tools/arch/riscv/include/asm/fence.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copied from the kernel sources to tools/arch/riscv:
+ */
+
+#ifndef _ASM_RISCV_FENCE_H
+#define _ASM_RISCV_FENCE_H
+
+#define RISCV_FENCE_ASM(p, s)		"\tfence " #p "," #s "\n"
+#define RISCV_FENCE(p, s) \
+	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
+
+#endif	/* _ASM_RISCV_FENCE_H */
diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 8d378c57cb01..0c21678ac5e6 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -8,6 +8,8 @@
 #include "../../arch/arm64/include/asm/barrier.h"
 #elif defined(__powerpc__)
 #include "../../arch/powerpc/include/asm/barrier.h"
+#elif defined(__riscv)
+#include "../../arch/riscv/include/asm/barrier.h"
 #elif defined(__s390__)
 #include "../../arch/s390/include/asm/barrier.h"
 #elif defined(__sh__)

-- 
2.34.1


