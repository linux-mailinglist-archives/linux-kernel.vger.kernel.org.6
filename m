Return-Path: <linux-kernel+bounces-282575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9DB94E5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F11282230
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A387A14A0A0;
	Mon, 12 Aug 2024 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="io+kSdIi"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C4380
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723439504; cv=none; b=A43iy1mrCeVyZ/Wp1x0DxJA2xiMX5UVjcOgbdOfCvTd61emAiLm2w8kK0GbpvToHQsA9d8eKIjrf/Ps6ighgiWK2xIM+4GVAmofXGhkba575Q3RrF0U1B6UARECGHe1r74z/oSBIB7JdDNKinrD++o5trvTafrDXtEH8Lm9WPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723439504; c=relaxed/simple;
	bh=FXIodPZ7O1ZonWHC8AJuz1DVSwPRK66ICm1hwu3cA+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gh5MpR1o6BOx7HvPi7M9/vQhiW2cBDPY49QRiW/NMjDr8j+gAz6stV1wAxC7J2cZei1QstT8pJu9jEi4fp6YpbTLPzrUwfQXaxcT9bTMdMHFHgMZ9GO6+F8kLL9hytxJMRAOQjjVeH7ZalZHrBjms+06wySX/GkliKzMUS6ZaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=io+kSdIi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso3583443b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723439503; x=1724044303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgKeYygUgO+nfcoZ/vUsH9NRmjrQwo4JtOLQQ/9ThGo=;
        b=io+kSdIinfE7jZWg+JxgPGxPXmEmvKfBX4PAlHaEgLl35xLJs+R4AH2jTmYwZolCLs
         iQjE25rux2t7qpZCcLQOjfynTVaiTpWXcQLS5X4fASNuhkzCywdNq9bc2F0YmwbpMGwb
         iTaBAknf23MzPwD5aIlvcQ7ZRlIPcfA9W+VB5wdf7vGyOaD4eiW5NjC4ohc8s9csbaMj
         6I9RA9asc+nSlFt24HDuJIuqIvXHQAm2u7M9Fj54OLCzh3nEBgEnX3Gwbdme/wGiU5mh
         DeGqglXhXR8EZwRR5KJcYd5nS70K6ZhGiuG8gdQZf5faVZ/wpDw6f7LLqDoOH/AqYjxW
         O02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723439503; x=1724044303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgKeYygUgO+nfcoZ/vUsH9NRmjrQwo4JtOLQQ/9ThGo=;
        b=o+qa1v1wuZbVRVsyHS01nwDVfmhaCw/fjRg+X7ZyLTSuAkaWjRsZYjVkYWwCk1efch
         RIoUJsHmekNylL1a8jQP0CBbJuVv6UNeKNjWJU1izbXDEZmguur8qMjKwkcbsr58fctR
         P0KzKjfgxV/ilhPZGW4+JwyD4nC3GHm89BsiGm0nHRX9KXUs5CzNCRTE5oO9RNFdO/es
         ZWDe/6KAzN/V49LjojlhsJ0i7tljKz6bqEqclcHU/oULXaY3+PA2ARvmD5NBdbri8THm
         36JMg3s3zgo0Y0krptQjTHuM5cM1Hr87bYoEKuQ5FWvMI0m18IrqddrgAuoxId0MCXj8
         Wacw==
X-Forwarded-Encrypted: i=1; AJvYcCWkq56lRq6CIjoiu7XSzhSB23IEzC0yqcsSyJ+uKH7VfqAFrcm2mgGwidlEe6q5WQRZvq3DBI7Vhyji/FobCiurQClamzt0xujbP0w6
X-Gm-Message-State: AOJu0YxT94f2POLSjkd/PN+VuAB8kDrnvuYKsVShyOErrfTVRzQpxarz
	8rXeSp7cVneSSbfXnD6vG7BrdODfCf+KQ+mv3MRvbciNPafJUrRIe7emW/zukOg=
X-Google-Smtp-Source: AGHT+IESKPp/hTzr/MBXd/6K0wYQkvlLvgVXKjg1rKzcuauG6Dbx6ZUswDOJmP77PU+pD08aD6H1nw==
X-Received: by 2002:a05:6a00:855:b0:705:ac9e:1740 with SMTP id d2e1a72fcca58-710dc67fcfamr10279320b3a.10.1723439502489;
        Sun, 11 Aug 2024 22:11:42 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5873906sm3257555b3a.19.2024.08.11.22.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:11:42 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] perf/riscv-sbi: Add platform specific firmware event handling
Date: Mon, 12 Aug 2024 05:11:09 +0000
Message-Id: <20240812051109.6496-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v2.0 specification pointed to by the link below reserves the
event code 0xffff for platform specific firmware events. Update the driver
to be able to parse and program such events. The platform specific
firmware events must now be specified in the perf command as below:
perf stat -e rCxxx ...
where bits[63:62] = 0x3 of the event config indicate a platform specific
firmware event and xxx indicate the actual event code which is passed
as the event data.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v2.0/riscv-sbi.pdf
---
 arch/riscv/include/asm/sbi.h |  1 +
 drivers/perf/riscv_pmu_sbi.c | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 7cffd4ffecd0..4ef8c44b15bb 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -158,6 +158,7 @@ struct riscv_pmu_snapshot_data {
 
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
+#define RISCV_PLAT_FW_EVENT	0xFFFF
 
 /** General pmu event codes specified in SBI PMU extension */
 enum sbi_pmu_hw_generic_events_t {
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 31a17a56eb3b..e77cbe299ce7 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -60,7 +60,7 @@ asm volatile(ALTERNATIVE(						\
 #define PERF_EVENT_FLAG_LEGACY		BIT(SYSCTL_LEGACY)
 
 PMU_FORMAT_ATTR(event, "config:0-47");
-PMU_FORMAT_ATTR(firmware, "config:63");
+PMU_FORMAT_ATTR(firmware, "config:62-63");
 
 static bool sbi_v2_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
@@ -507,7 +507,6 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 {
 	u32 type = event->attr.type;
 	u64 config = event->attr.config;
-	int bSoftware;
 	u64 raw_config_val;
 	int ret;
 
@@ -528,18 +527,32 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 		break;
 	case PERF_TYPE_RAW:
 		/*
-		 * As per SBI specification, the upper 16 bits must be unused for
-		 * a raw event. Use the MSB (63b) to distinguish between hardware
-		 * raw event and firmware events.
+		 * As per SBI specification, the upper 16 bits must be unused
+		 * for a raw event.
+		 * Bits 63:62 are used to distinguish between raw events
+		 * 00 - Hardware raw event
+		 * 10 - SBI firmware events
+		 * 11 - Risc-V platform specific firmware event
 		 */
-		bSoftware = config >> 63;
 		raw_config_val = config & RISCV_PMU_RAW_EVENT_MASK;
-		if (bSoftware) {
+		switch (config >> 62) {
+		case 0:
+			ret = RISCV_PMU_RAW_EVENT_IDX;
+			*econfig = raw_config_val;
+			break;
+		case 2:
 			ret = (raw_config_val & 0xFFFF) |
 				(SBI_PMU_EVENT_TYPE_FW << 16);
-		} else {
-			ret = RISCV_PMU_RAW_EVENT_IDX;
+			break;
+		case 3:
+			/*
+			 * For Risc-V platform specific firmware events
+			 * Event code - 0xFFFF
+			 * Event data - raw event encoding
+			 */
+			ret = SBI_PMU_EVENT_TYPE_FW << 16 | RISCV_PLAT_FW_EVENT;
 			*econfig = raw_config_val;
+			break;
 		}
 		break;
 	default:
-- 
2.34.1


