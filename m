Return-Path: <linux-kernel+bounces-414935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C218A9D2F73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC528380E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939A1D363F;
	Tue, 19 Nov 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yVB661SF"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C11D3648
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048254; cv=none; b=ff9J3w44/M1exUD+Z34dirxo/IV9RsSHQTwlKdceMkr4xproBDCzd6aiG0E/e0fbaDbSsOmRpej75vqgW+XBQMJGJ9EHH7SMLk00+YFD/ULLygAGweP4hRF/Pb1hY+PQSbI+GSd8e+marY8+yJJQU8/lFFsTDHs9vn8SGpLLp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048254; c=relaxed/simple;
	bh=SADvMhA7/Ukb2OMwQcY0BoWNEsNhkhKslaT1ZVi9WWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPwV7+ew5LIy6xwhhxhl//8aq+3wHi6B+BeS9o/f9NtBt+iZl+nxhzZnUYAiaHG/kGMxKy9uto7SrbckXPzwLDlyoB5AX/b4jtsDl66HOyuBGq3x315xapwGYIVYf1mkK5z4Qz8CdvTgKoict7tIWiN7LaBoQnV5SkCrPPhSpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yVB661SF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so3748683a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732048252; x=1732653052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRmKVkktJnfpekqs0vaEt2UdODXxii8BcnwHInLLVOw=;
        b=yVB661SF1mYVKlk0W8aEtptxaOukJtg5bcwEqgL/ka+MiQCvXkURjPs2PxEn0pCGrP
         scIOtROYNSzEQ3vEBqf2wFbXarl/ej/rr30JfN9mRYQcYL/oIFU5fzpjgeScypMbUtPI
         Mjfko/JwhcDKoXRDRTk//I0IcN9y/7WVTGeHemw8qEdx8OACeEdRaEle3191byr/EjL+
         ncBYwqMjX3g89S3sc3iqzxdnUoqUlXcse2VvesXMFFPn56UuujbBmr6sXCpxBjAcZ5Gz
         WPGqWP99okCARr+sH97y6Nr8YXQypqyAXtWZ+qd9XIsIalYs/1wXguTaI9Psfc1UIBDt
         i9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732048252; x=1732653052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRmKVkktJnfpekqs0vaEt2UdODXxii8BcnwHInLLVOw=;
        b=srttkNjCnDi7r7VzMpx7JfO+eaG+M1FxgYkdlcMCNJcSXTIrex9qmxgSXKlv5QVKdz
         dMBHPg7POHdklBZAQVDYcMlEBrHwwE5hTZir5YxRvtGNQ5haKAMtXfen5fSijrvMPQYn
         yoPY1KqeHGyeoSZ4l8lO54JwN7iY3aXybq8tNv1jnW/5IsD79fRfhq5ooJ5ijzvScWQg
         Iy5o/uLuTqlY25V3m1rw6WO5gsHZfJ75ZZcpyS4069B+1hXgp6J9xTMk7e2+rZshWvHp
         NBqZKLg3RGnYitTYpWf/8dJ6NSEM3d+uBHKVJZTUk96SYI0F7ah/SxvqztKp4/aG0ppf
         nG/w==
X-Forwarded-Encrypted: i=1; AJvYcCU+mN1cmd0iN0kilq01sEqLXyY6KCyYG+ydDpe8t4NXSz4FlU5UxkMvSj00EA0JRtkm3w9+KamzLTXxnNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOj14Xc/o70eZJdrPp0ShhTtzBzAI3ZdKB2u7omQb2/fm2Wru
	ASGoQ4hsAwpvs/jMvPqmQVQXyvQ2/okyYLyFpicy/BQHIAiihgQXlEX/Q1UEQi8=
X-Google-Smtp-Source: AGHT+IH6B0MvWBP/cFrV+iSzChrNQ92fntZ29A1EV2WF6+w0INOIuuldt7jmoJ2f0P0WCEdUpH78Ag==
X-Received: by 2002:a17:90b:3c8e:b0:2ea:61de:38ed with SMTP id 98e67ed59e1d1-2eaca7c9f36mr107313a91.26.1732048252407;
        Tue, 19 Nov 2024 12:30:52 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34f2fsm79001315ad.159.2024.11.19.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:30:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 19 Nov 2024 12:29:51 -0800
Subject: [PATCH 3/8] drivers/perf: riscv: Add raw event v2 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pmu_event_info-v1-3-a4f9691421f8@rivosinc.com>
References: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
In-Reply-To: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

SBI v3.0 introduced a new raw event type that allows wider
mhpmeventX width to be programmed via CFG_MATCH.

Use the raw event v2 if SBI v3.0 is available.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h |  4 ++++
 drivers/perf/riscv_pmu_sbi.c | 18 ++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 9be38b05f4ad..3ee9bfa5e77c 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -159,7 +159,10 @@ struct riscv_pmu_snapshot_data {
 
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
+/* SBI v3.0 allows extended hpmeventX width value */
+#define RISCV_PMU_RAW_EVENT_V2_MASK GENMASK_ULL(55, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
+#define RISCV_PMU_RAW_EVENT_V2_IDX 0x30000
 #define RISCV_PLAT_FW_EVENT	0xFFFF
 
 /** General pmu event codes specified in SBI PMU extension */
@@ -217,6 +220,7 @@ enum sbi_pmu_event_type {
 	SBI_PMU_EVENT_TYPE_HW = 0x0,
 	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
 	SBI_PMU_EVENT_TYPE_RAW = 0x2,
+	SBI_PMU_EVENT_TYPE_RAW_V2 = 0x3,
 	SBI_PMU_EVENT_TYPE_FW = 0xf,
 };
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 50cbdbf66bb7..f0e845ff6b79 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -59,7 +59,7 @@ asm volatile(ALTERNATIVE(						\
 #define PERF_EVENT_FLAG_USER_ACCESS	BIT(SYSCTL_USER_ACCESS)
 #define PERF_EVENT_FLAG_LEGACY		BIT(SYSCTL_LEGACY)
 
-PMU_FORMAT_ATTR(event, "config:0-47");
+PMU_FORMAT_ATTR(event, "config:0-55");
 PMU_FORMAT_ATTR(firmware, "config:62-63");
 
 static bool sbi_v2_available;
@@ -527,18 +527,24 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 		break;
 	case PERF_TYPE_RAW:
 		/*
-		 * As per SBI specification, the upper 16 bits must be unused
-		 * for a hardware raw event.
+		 * As per SBI v0.3 specification,
+		 *  -- the upper 16 bits must be unused for a hardware raw event.
+		 * As per SBI v3.0 specification,
+		 *  -- the upper 8 bits must be unused for a hardware raw event.
 		 * Bits 63:62 are used to distinguish between raw events
 		 * 00 - Hardware raw event
 		 * 10 - SBI firmware events
 		 * 11 - Risc-V platform specific firmware event
 		 */
-
 		switch (config >> 62) {
 		case 0:
-			ret = RISCV_PMU_RAW_EVENT_IDX;
-			*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
+			if (sbi_v3_available) {
+				*econfig = config & RISCV_PMU_RAW_EVENT_V2_MASK;
+				ret = RISCV_PMU_RAW_EVENT_V2_IDX;
+			} else {
+				*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
+				ret = RISCV_PMU_RAW_EVENT_IDX;
+			}
 			break;
 		case 2:
 			ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);

-- 
2.34.1


