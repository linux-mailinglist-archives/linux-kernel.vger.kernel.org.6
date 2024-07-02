Return-Path: <linux-kernel+bounces-237602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7A9923B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD261C2166E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A92158849;
	Tue,  2 Jul 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jGifolcC"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9D15689B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916017; cv=none; b=G9jW9JgwNHNz9JRKVG4Awgf/om6wqTfaM07SUEqe9xEWYNwmV+5UFu8hto4uY+SGTTDIKLkpS1SohVgmWIsHp8tAsa635v1A2cSFtePtIZIbGUn9bvGzW7pqswzgI0qiY5PEjhJicAXiSnmz6QwlwymaZ6HRq9+GEwhzPz6JIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916017; c=relaxed/simple;
	bh=ky/XLIlCx2hCGbJCf+MdSt2I2G8jhRDOvMafvk4tQfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KmXnCUX6bXMNZ5u4aLGSKYQ7vPBLI1gF9VGYE7J2PJhfarakNU78taQXmV/LxX8Yrso4K95G0Z7vK3L+TBCwwV/UCVIDzo6UlLKQ7IBrXz/PH01HqNqfnZoyarzLniRTJM/pM/F7VZL+NM80CYvhSGP86ABtPH87Kl9Q3GO2g+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jGifolcC; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b9778bb7c8so2172879eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719916014; x=1720520814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6YVXnCoQ7qEw7sNekNtkJPPQroyl9lTFP46uKAB1k0=;
        b=jGifolcCc/ol2tEc8SerutCskIxNRehEQcn6HTrAklsJ+iZSQIrU4AQNppmRkTTcLq
         HYpBqxt7ySP2byrgIGVrwsubn6QANhoYJ3lpgBG2EgM+Dq5e5LDLlNOdIPcDr65VllF7
         CXFeDTXxU4fh5QD1HXq2fapyeXqmTxtEl8xiFtmJNJG0wHXH2BLaQ1rrnY9GknXT8rX/
         gSsKLWZ2kuKERv696nfB3C+pqGi/f/a/wa7BmI1b+zVbePqON9EBF8ZltftG9tXXpYwj
         KYyHvd08lWcy27/YKsRxeqRTLLx1VERkTUbkouSsc+44nm8nVJ8gvXASS4GR0L/cozep
         Xn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916014; x=1720520814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6YVXnCoQ7qEw7sNekNtkJPPQroyl9lTFP46uKAB1k0=;
        b=HYrXJXVxI21ZF/zq0BAZK47OjaxICjghJR36jZYohLxfEqcKCFElwNfO+ZeAGbn0Wy
         5fFPE2f0WAYDiRbSoSdR86tlAM7iY4J9DwhAjjpLI4b5v7iOFTXk+Y4ue4/P2jApBIfE
         Pi1O2Bsjbw8auNdh1973wDjdsmF7FVFdUxOSFgWb6EvJyrChkl/w9MQAoFfGEtPN5gwU
         tQmzgKnLcxTDtiKJhyt4WZ6dqJHTj+8fYyIL8hpXpkWpQRzlsqdFRjB1Hn+JomICzs32
         3LHdv8FQWVQlHzQDJ47/7whfNFADPb/HgU+4ZgK1yfFHdjnpC24izObCIjvpgOPqkT4z
         znFA==
X-Forwarded-Encrypted: i=1; AJvYcCWLiKoKHfjR/mTMzwjlBPkxKwF7o4NByMLYK3Nu9Izf/yJAAEIakz8sp8CwQi24jlA7tDFJEyu+/8SPaeYzcEZH/OtPfthOQ0pVtvPV
X-Gm-Message-State: AOJu0Yw7ANX9s6Z8l41D8Oh7fRrCJcjplaHIxQTolYKyNFu99vMJNjiw
	4uxgHsp6f6t8jrEjLiheiA5/vAwYBXplT/bvHRbqEM9QRQpHIT8vSoWx71agDos=
X-Google-Smtp-Source: AGHT+IE7N5uVnEVvb3xPK8QgJDLCvw56PgeF1K1Z2Y9HlVJpsAXkadeed7hFYdYJLiP6XqLxa1Q6hA==
X-Received: by 2002:a4a:1a42:0:b0:5c4:c72:b257 with SMTP id 006d021491bc7-5c438e095c4mr7689214eaf.2.1719916014592;
        Tue, 02 Jul 2024 03:26:54 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([2401:4900:531b:f9d9:fde0:f256:2f01:22f4])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5c41493a0d7sm1367803eaf.28.2024.07.02.03.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:26:54 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v8] riscv: mm: Add support for Svinval extension
Date: Tue,  2 Jul 2024 15:56:37 +0530
Message-Id: <20240702102637.9074-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Svinval extension splits SFENCE.VMA instruction into finer-grained
invalidation and ordering operations and is mandatory for RVA23S64 profile.
When Svinval is enabled the local_flush_tlb_range_threshold_asid function
should use the following sequence to optimize the tlb flushes instead of
a simple sfence.vma:

sfence.w.inval
svinval.vma
  .
  .
svinval.vma
sfence.inval.ir

The maximum number of consecutive svinval.vma instructions that
can be executed in local_flush_tlb_range_threshold_asid function
is limited to 64. This is required to avoid soft lockups and the
approach is similar to that used in arm64.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
Changes in v8:
- Fix line wrap
- Add RB tag

Changes in v7:
- Use existing svinval macros in the insn-def.h
- Rename local_sinval_vma_asid to local_sinval_vma

Changes in v6:
- Rebase on latest torvalds/master

Changes in v5:
- Reduce tlb flush threshold to 64
- Improve implementation of local_flush_tlb* functions

Changes in v4:
- Rebase and refactor as per latest changes on torvalds/master
- Drop patch 1 in the series

Changes in v3:
- Fix incorrect vma used for sinval instructions
- Use unified static key mechanism for svinval
- Rebased on torvalds/master

Changes in v2:
- Rebased on 5.18-rc3
- update riscv_fill_hwcap to probe Svinval extension

 arch/riscv/mm/tlbflush.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce3867..782147a63f3b 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -6,6 +6,27 @@
 #include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
+#include <asm/cpufeature.h>
+
+#define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
+
+static inline void local_sfence_inval_ir(void)
+{
+	asm volatile(SFENCE_INVAL_IR() ::: "memory");
+}
+
+static inline void local_sfence_w_inval(void)
+{
+	asm volatile(SFENCE_W_INVAL() ::: "memory");
+}
+
+static inline void local_sinval_vma(unsigned long vma, unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid) : "memory");
+	else
+		asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory");
+}
 
 /*
  * Flush entire TLB if number of entries to be flushed is greater
@@ -26,6 +47,16 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
 		return;
 	}
 
+	if (has_svinval()) {
+		local_sfence_w_inval();
+		for (i = 0; i < nr_ptes_in_range; ++i) {
+			local_sinval_vma(start, asid);
+			start += stride;
+		}
+		local_sfence_inval_ir();
+		return;
+	}
+
 	for (i = 0; i < nr_ptes_in_range; ++i) {
 		local_flush_tlb_page_asid(start, asid);
 		start += stride;
-- 
2.34.1


