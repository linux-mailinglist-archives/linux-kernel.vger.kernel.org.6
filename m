Return-Path: <linux-kernel+bounces-444091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14ED9F00A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51EB16A57A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF317D2;
	Fri, 13 Dec 2024 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XIN9E+dN"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1598623
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048586; cv=none; b=U2pzjlmEQz7Z3kVu8suSYmBYBV2kJv9Jcztali/r8I0DFQvnpJ6jlbBxVIUhIHES7DuIu+yvPNtdu5tfH3uSF28Hp+2nO/BmkfbMPjGJQY+K9PKWO/0UQKwjYXC1q3vR1JEy084BgDBL8cZ83+K20Uv8m/uRAJizSH9yQVcqs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048586; c=relaxed/simple;
	bh=yh1WhPVHnUXGeUqDrFmWYHG3GtqtO4RO4NHAH/4shqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efEBC3GqVLH08TSCULsd6uB/Sk8xjiuRQ5QRzEnHptVyyCEQNPAcubY0fmMaJqNV28rip3P8zNJltwV8ZAJLj3vqxzXmOx0GuK3a47JoFVIXQCgWZa1AfmQIed713pnleSkPaJgCEO1M5ROzXp/BqV9gZQ20xMcltohWACRkeBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XIN9E+dN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1043769b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734048583; x=1734653383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcoCLi142uVK6LZxiJuwIjRZD/c9pyPS+Cs4D2LMz+8=;
        b=XIN9E+dN9dgUF1Z3EOilsDemR0sPM5OEOd1GZL61C5eWMR+E9VAnr9QEG/VNdAWoe0
         d9uBxz0gqXMj7+4asr5hqYh6wKXyuN/XnHlhU7tooW0pEO6xdd0W3vRyss0ygklxjkdI
         1WNk3gN8DERqi45xi8lm9r9LC7KmFYACIstz802hbAiMaRKm3ZnaphVWAq6R0NK4vuOi
         HlxTIDn6lPynNRMQpXtacKWHInH/lk/NzacoSdPEYhhD07lJEfjU5ikdkcMH2gyO7tZc
         +Wldnh08jDa0UGHMlnp7jvaEmwWbwayafHEbCghxRnR0vpgqS0a4smN5rJ3XGHVdleSL
         bVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734048583; x=1734653383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcoCLi142uVK6LZxiJuwIjRZD/c9pyPS+Cs4D2LMz+8=;
        b=vrTMKkdAxPUZ+YOzUww7jeClYhAPMxxxBI3R2zCUQv/Pe59bUlCpFPqcJ9go65IJOM
         gwVR4jl8PZxT5V5pUHoCnvJStzOxmk8Lo/uw/crxTqJW6eLKrSOhyP2tUAoam8q8YFRQ
         RxF2avMvToE9DsZ1k119hp1y4k2IVxWaH9SyYoFc+svJviKxFGYc3P4J2/BkvclNh+3H
         sJSEVQoMzFsfSSoLDxDUETMzeY4e4P8LordZFJRVL7pI/tzOPsLK5gYVOOsGhvI8mNPL
         DGtkyHhezAhTnyTlYDJvPqv6t6pJzkexRMKiykXDmSGWtIRjjp+3/f5hX6oN1nQoMMZ7
         0Zqg==
X-Forwarded-Encrypted: i=1; AJvYcCX0XG7nJHWl71PKXkkyvkl0Wg+qmH5X84QADTZ5g6ReoJ7ZsnwaVwlsnhpbyXn3NcJLYE+lGQhf6KHRrPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTv7ee6+7o0xt4/ExXD8p+EWtHFeLyTgV3Ob64l9qZSvyWQxy
	o0MlVl0uRttG26i5FElzd5zbYbUcpesmvweBTTpTd++ZQz9c8BxHMQst4cSGIrQPe/ZzWU1kSso
	C
X-Gm-Gg: ASbGncudlhtEZAHEKxg3C8gczR/Bv47bKc/2BZkFOEH+QVv4nGxy9gQR4lYQi0XdfTr
	Itpevfl3rsrsSyChKow8tWxYaVFcFfVGHqHIVF5s7gMOXIy9MIAvMPwck2fjogmMvn+BwXJ4EKB
	O5/k5Ksiv2Di5wWTqEawGzoUeO0VwxpXCRSD573cDGiw8pNVPPxPJ8kSPPkFaVNY/AawHcILpi/
	HvVZFPZXHL5K3aVb1Z/tf8zCcxoaIw+31RkV0xBTZ6RDTFzIPOslWLfqySKydYb7ljNWA==
X-Google-Smtp-Source: AGHT+IHmDZNQeSUmz5Vdrblf9aWol9BUqZ9IhtQeZlQQdYeS+o+qCMgFykBzBG1diP7lnYaJXN5iGQ==
X-Received: by 2002:a05:6a20:2d14:b0:1e0:c89c:1e04 with SMTP id adf61e73a8af0-1e1dfeb9f33mr602266637.43.1734048583637;
        Thu, 12 Dec 2024 16:09:43 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f0a0779dsm7441455b3a.154.2024.12.12.16.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:09:43 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 12 Dec 2024 16:09:32 -0800
Subject: [PATCH v2 1/3] drivers/perf: riscv: Fix Platform firmware event
 data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pmu_event_fixes_v2-v2-1-813e8a4f5962@rivosinc.com>
References: <20241212-pmu_event_fixes_v2-v2-0-813e8a4f5962@rivosinc.com>
In-Reply-To: <20241212-pmu_event_fixes_v2-v2-0-813e8a4f5962@rivosinc.com>
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


