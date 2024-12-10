Return-Path: <linux-kernel+bounces-438599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A829EA348
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEFF1887C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31F5223;
	Tue, 10 Dec 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Bn4bMMUY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41810380
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789095; cv=none; b=DEbJXiwWYcI76hD3V7f9mYoMw+fbklwc2HMHCTHH1eVn4bF0tb2xhGSnG++ZftYsQJbI0J3rzdw9Zt0gKf0ojlPVQyk9a+9EnqVGPsn96WQ4SZ0sOXB/QwjBs194vP0X1GswEbGt0F9Kavy0IUERMzMeDW7aU6/uP6/Lkwtv55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789095; c=relaxed/simple;
	bh=yh1WhPVHnUXGeUqDrFmWYHG3GtqtO4RO4NHAH/4shqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abBb3tt5CEJ8LRK3wE7R1lGW7/qZD0J36xSJ1snKeKgiEkUZ8/SWbDD5bbl51MA3EClRxY2/c0i4z1zLcqrYpC6sOQYb+4TVV8M0hCWCxPnLIsMfXg7xaXiayzZ96TJSZeFcdnDty6gF6G1+m+rUqs5/8z4RtZvR2up/+63zgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Bn4bMMUY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725e71a11f7so1299005b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733789092; x=1734393892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcoCLi142uVK6LZxiJuwIjRZD/c9pyPS+Cs4D2LMz+8=;
        b=Bn4bMMUYVaBMr3V5c7AcrBw0PQ5w9OEJWeOC2PLPiMD5pvVZNw141vlQDE9YxEBsA1
         dV5ZujCeDMFlMr2p+LOGhtD2MYeTgZE3Nmwz5AcvLZbRgqBkj5GuidPF+utVWvRiHfpA
         ltDsQgejC3d0Qm7QWwhRyEzD8kjJQ4J6YF1hDJy+r6uZqW53uTAWtIvn3Bdm+z5GmA5+
         2kw6AJuHRLaOFrckEPDrQUgZGhh/c9dlCRd0/tqkLYD0KRQ9N9GuxrKJcnlhV91d/rEJ
         uETe4VosnoMEjoeBwyn8+zcRTrOaPoMRGFcsUxztRPrLuFEZC1ZyeGNf6GjTguPZbbMb
         y9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789092; x=1734393892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcoCLi142uVK6LZxiJuwIjRZD/c9pyPS+Cs4D2LMz+8=;
        b=LJ8KjhBbhPk229w1a55cll/ZFKwh0ga3PvKb4V42Jr8x89UFcogzihHYjQqEADupWb
         fXo6ROKpVMYTaINy/qfIYYuu7RIG4955NKTjkNS/pyA9tXKK5SZGTT+l4R4ZjV5n7GPS
         4krdPB/2hpYIEdpv5jzvF5ERql+gOmFSA3K5mlyMIXEst0r/TOBHOxIJBnTvvzPYSln2
         HCDnWDOELC6v4kl/PK3pf8z1uIIrFH6AIo7CRTXdpxmMEZfKwfMi6QRMCyO0CvHD09qq
         xSfyshBHQXve87M+n4Rt1/jDfMd9FZXoB2YH4WIipbqfbqHUBWCPrwNdrefQBn0upoaA
         INFg==
X-Forwarded-Encrypted: i=1; AJvYcCW7CTW5FF1FiZsLlqY5zCMUbF2TQvK2g0Ah1tCtStBd+QBOIQcuECgF5xDyVsTMhE5JqThFyvH2IJcGm+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4wa3Pt89glE5ETMfetL8zLN/eL0bG/6YVn2/ja3IiJAiuFG3
	U/fm4xeOFqZKNwjEdIjmn6QTaAjMBYeqSASQnjnlZoslApAG0AJEqsO9AKul19vE/OoyzSQxK02
	8
X-Gm-Gg: ASbGnctam/N7q/LqEJEvWBSX/2ne6Fc7F+JlZqlQO2M9I9HdBaJeO3I1fGWP4x3VieX
	KiREpVTCnlsqauREcyCQEBpJ+v39WfU3l0jpiZkYU3ZBn2W4M5/f00LcxeFoDAc3fC+LgSaDfeI
	7UMatDsIhbCSJ8JSCNSR1fCiI785XnCOiwEqSu1yxrbE742fnYBS3wfoEQEkuweTAO+wCF2h61a
	fbLdhUKLxRSqnkmfDi9/E18ZitJYUUIvN0/kTARK12AHmWFxRwoy2OeyxRRNAVO4qU=
X-Google-Smtp-Source: AGHT+IHtQv72nuw+PgMFj/lyteqN8ZPPPaSuF1PYTBDxNzcw7rsi++0gLI3vMd4O/SEk4kaL5+EgJA==
X-Received: by 2002:aa7:91d8:0:b0:725:ce39:4516 with SMTP id d2e1a72fcca58-72888ca9b12mr1728764b3a.7.1733789092221;
        Mon, 09 Dec 2024 16:04:52 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e3ca46f0sm3477249b3a.15.2024.12.09.16.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:04:51 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 09 Dec 2024 16:04:45 -0800
Subject: [PATCH 1/2] drivers/perf: riscv: Fix Platform firmware event data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-pmu_event_fixes-v1-1-d9525e90072c@rivosinc.com>
References: <20241209-pmu_event_fixes-v1-0-d9525e90072c@rivosinc.com>
In-Reply-To: <20241209-pmu_event_fixes-v1-0-d9525e90072c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Atish Patra <atishp@atishpatra.org>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Platform firmware event data field is allowed to be 62 bits for
Linux as uppper most two bits are reserved to indicate SBI fw or
platform specific firmware events.
However, the event data field is masked as per the hardware raw
event mask which is not correct.

Fix the platform firmware event data field with proper mask.

Fixes: f0c9363db2dd ("perf/riscv-sbi: Add platform specific firmware event handling")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h |  1 +
 drivers/perf/riscv_pmu_sbi.c | 12 +++++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6c82318065cf..3d250824178b 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -159,6 +159,7 @@ struct riscv_pmu_snapshot_data {
 };
 
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
+#define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 #define RISCV_PLAT_FW_EVENT	0xFFFF
 
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 1aa303f76cc7..3473ba02abf3 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -507,7 +507,6 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 {
 	u32 type = event->attr.type;
 	u64 config = event->attr.config;
-	u64 raw_config_val;
 	int ret;
 
 	/*
@@ -528,21 +527,20 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 	case PERF_TYPE_RAW:
 		/*
 		 * As per SBI specification, the upper 16 bits must be unused
-		 * for a raw event.
+		 * for a hardware raw event.
 		 * Bits 63:62 are used to distinguish between raw events
 		 * 00 - Hardware raw event
 		 * 10 - SBI firmware events
 		 * 11 - Risc-V platform specific firmware event
 		 */
-		raw_config_val = config & RISCV_PMU_RAW_EVENT_MASK;
+
 		switch (config >> 62) {
 		case 0:
 			ret = RISCV_PMU_RAW_EVENT_IDX;
-			*econfig = raw_config_val;
+			*econfig = config & RISCV_PMU_RAW_EVENT_MASK;
 			break;
 		case 2:
-			ret = (raw_config_val & 0xFFFF) |
-				(SBI_PMU_EVENT_TYPE_FW << 16);
+			ret = (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_FW << 16);
 			break;
 		case 3:
 			/*
@@ -551,7 +549,7 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 			 * Event data - raw event encoding
 			 */
 			ret = SBI_PMU_EVENT_TYPE_FW << 16 | RISCV_PLAT_FW_EVENT;
-			*econfig = raw_config_val;
+			*econfig = config & RISCV_PMU_PLAT_FW_EVENT_MASK;
 			break;
 		}
 		break;

-- 
2.34.1


