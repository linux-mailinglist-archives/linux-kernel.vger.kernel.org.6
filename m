Return-Path: <linux-kernel+bounces-232701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7185F91AD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF18EB21429
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99662199E95;
	Thu, 27 Jun 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o28PsgEL"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4C14EC40
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507220; cv=none; b=dy45tT14WZYxpBfvecP+3SZHpqZUvLI7/Nz3d5aFTKsTqWpUVw+iKT9f0R5CBxdkocBoz2aV6/nm5UHkKrL3eDwyU7klIPCp8gbBphb0SnDkb67y7fiQ203/2wCWs2VD/c9LQScLCTgO9pw0NpqCoI5foVLnns2Oo1YBv0Tu0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507220; c=relaxed/simple;
	bh=x1k48BHbgsGtky0kPYy3/3FG4+zHy/gj0cU+iT89aNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHXkoITTc6SAEa2hOkYeB+4g9laAbd0fYoHq6ppA1xpQasN654BQs6NAg0r5LlJ8yMgg0aMkQtGIfLp54SQjJk6sgN/NiqSCmHuUabUcULbnSfm2Bve04HS+av+MhdYld5s4Dj7/DuIoL5307qnr/iO8WgNNJu6zn3CFggBRxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o28PsgEL; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d55ed47cc6so1472897b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719507218; x=1720112018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgRMcFjdAXSfJmpNDWirZ3ZJOzi2fPO0oxRqfISjGUI=;
        b=o28PsgELTC8P9GKbOXxR5woaYL+FoP4wIK8vvg97kZl6CBUcSX2G7rsxmcdnnGHZTb
         blrD0Je2umDIk0/lbOd6YOryhzH1amKXR/NGvhJnN6bSP6ChDRXeFy/N0bSTrA7nxAol
         src16tBLFzlbjhYDEdt7dDO3vOkqpM9EU4llavjp0l83kB8mlwuzxo+6NHeyFhkuhHIs
         CI+5FHyFckFksLiLYH/+Fy+rMTAoZPqEHKtyVto8vQ6FypWZ7ExfFgwqnxGXLuoT3K64
         n01av+29uQb7JjrpCzyGLoW51zWUBGj61Uk9zG8QkjVhsGDB7TUu78Nl3oORQHe2oSpJ
         sdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507218; x=1720112018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgRMcFjdAXSfJmpNDWirZ3ZJOzi2fPO0oxRqfISjGUI=;
        b=F/tbWXIlnMfmLavXt3XiYtViqdTYrrLDukxkwqgLqqq+EbQNl1RpQGzlQddhVcBXxE
         0ZM6dRoIyYoy8PFXrbH6qy2rdONLxjVqaz03nbS49+BvMNvKWSDg9XPL/rnaWM/LuZAQ
         9VsS6Ur7kY3PAebxEUtVmLQB49nzrBLI19xfk7a9NsIeNm1hwGZ2z5SJjOQuVyE5cS/P
         nQgwSs4GLXYvL7wFtoQBSZN/v3qJpjEXNt2CRsobgcwJBAkqD3+9QIGPF6Jsj6cNF/Zy
         ivA8anZsewBcCbb37jdRwQVI/iPwgSAeGOQHCCb/4N99XhZmufnFqIlo6lkNh3SdIUUD
         Owdw==
X-Forwarded-Encrypted: i=1; AJvYcCVDVOUT4YVvKYY7wTHun28nVGphbQJH3O0tyZclDmetCUjJoMFcPu7xjBRvT3enwgSD1cBhyecLkR401lt34eycVW6NGC62XMVdvIKQ
X-Gm-Message-State: AOJu0YyVJrql9hfUqKbBakMWe4PkbP+EDu0QJ+QIps049xaDIUQcEfwZ
	uvXoUUwooaRxJgLZPn3DqNu5el6gE/3AbB837cQ2PzWu6s2hLytWhxt+cMY0+1xex7WrEsm8tb4
	s
X-Google-Smtp-Source: AGHT+IF2xW+HeDrE7uJXd3kjJz80Due0WXPJcpVN5Yx83rJHKpt+8lD+3Y2IF5Rs4BD2GqbvTkP0fw==
X-Received: by 2002:a05:6808:18a0:b0:3d2:1c91:86df with SMTP id 5614622812f47-3d545a6a3edmr16253593b6e.36.1719507218121;
        Thu, 27 Jun 2024 09:53:38 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([103.97.165.210])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3d56779fac1sm296678b6e.45.2024.06.27.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:53:37 -0700 (PDT)
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
Subject: [PATCH v7] riscv: mm: Add support for Svinval extension
Date: Thu, 27 Jun 2024 22:23:27 +0530
Message-Id: <20240627165327.7685-1-mchitale@ventanamicro.com>
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
---
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
index 9b6e86ce3867..d3396619d8c4 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -6,6 +6,28 @@
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
+		asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid) :
+			     "memory");
+	else
+		asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory");
+}
 
 /*
  * Flush entire TLB if number of entries to be flushed is greater
@@ -26,6 +48,16 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
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


