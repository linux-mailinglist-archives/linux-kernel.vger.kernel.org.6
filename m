Return-Path: <linux-kernel+bounces-207344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27AA9015EF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871B4281CDF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E7D2E63B;
	Sun,  9 Jun 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cn6nTMt3"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719A3A29A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717932086; cv=none; b=BbIzXYe7rB4J7MpjqWSOZ9j6h2qs+y1Gf+4GMEt/0dJh38yXlFMFEygsLc8Ym+lu3P+tu8titQ5XwHXEl9/RFXamC6hcc+fY51PKhg64CT6KwLeGeT12kDdrwjWnBjrr3tdvlGTuBoQOvc6N/Rvy8nGDx/OBmtlvbnnVPg5bcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717932086; c=relaxed/simple;
	bh=xkJY+BLnez6gjRG4gOOnnI8LG/ufQvw+2cQN3oeukEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiEnyuph/0RrrVH+bq9DDeis18XWhCQBlG01Oi2xdHiFsyEEURynkU98F+mMXq+qtxs9qocZqHJ+uP4Iq3FWKDGB+T7dGUdnc5zNmmDF+sqEy+gElnvn3m/OqxEYqmlQy/+uImcUW/Rs2PmVuWbr+NfAeOfKM9hlGcI3kxFPkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cn6nTMt3; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5baf982f56dso116081eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717932083; x=1718536883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6LeVbVhP8fW9dLLQgkcFQHgf3T0RCtlXo8wcgs1rnU=;
        b=cn6nTMt3N5DWO8VixLf2+XOvAZfE6XlfGC8IGaSU4KwdDitVQjblOhGyndpKlM15YZ
         ufjc6jpEYUK/lH7c1dKATrnUZMMtn8SWU5C1VVZG8h70ufx4J5tL5C2dbf1qnLsysVrS
         jS13tUxbRmBlyeiJmIMRIlr8EKaUZsIBbSaKSOel8D/TgmDHKoEnjMdPo61IHpbiVHHX
         HKcP1YRaI+ftDOkaTvEhraXWB9S6cwp+N+nnLVJYKiq9eOXxqvZsvqWLrGjpfk/Xj9nY
         ghLJPNp8sonuseEas5m+8KyV767CyznAE6r0bmmKZvltiQuVmzPQr7J3FDRbT/6M5qBR
         0/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717932083; x=1718536883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6LeVbVhP8fW9dLLQgkcFQHgf3T0RCtlXo8wcgs1rnU=;
        b=AXKI7a5rKHb0mrmwia5Kt8oyNYq0Jwe05um6pcgSuv+EbZR//C16pX/PcPjCe4OLQo
         lCATuOB6d+o/lrOTjBCGnD2nNIQjrfjb3uBj7drmDerJxFWcU5Uu+7b02gMuh9pTGv9q
         pliQFb0kDdbvZgMHJJxbAkM8m2AJkUYwKfMo2pM+kfrXNT8b0z4XBv+s9jZmYS1WlAu5
         1Alb4lVS1BZFTLexYvCsNDRhecAyM6P/sLX7gBG56tmTPVLqfKBONs1c+eZsT2MOXf8V
         wruMWsvsE53JJe/cW/rjwTtTDjtlaboyP8J9i6925XwIpMSjQPXB99XHrmCYy6d5gQLT
         +uWw==
X-Forwarded-Encrypted: i=1; AJvYcCXo+LmNVDzRnS7WURhUHXt3TBo1iiSfUhQC3tfe7yI54gE6FsTY63J6kJN0aPsgltmRpFkQQYFTBQovF04snjnMTgA/4ruGswOJruNu
X-Gm-Message-State: AOJu0Yze2JFhuYyXfZ20WXxZTj3yGyuv3csB/xZYUbjAedHLXgnZXukW
	CP5r9IF9XRZ89t5tZ9nxXvf3vBh6+66OJlmSgHoYd20lL+A69yHHzc7MYgXyeo4=
X-Google-Smtp-Source: AGHT+IHwBScq1ebphyGH+iK2HIk04UnLf8UGXAlgSrlVCk/JKXyljLxMeVrhBQqlS4Czk84vs5zKig==
X-Received: by 2002:a05:6358:9103:b0:19f:1959:3c3d with SMTP id e5c5f4694b2df-19f1ff8ee68mr712652655d.26.1717932082658;
        Sun, 09 Jun 2024 04:21:22 -0700 (PDT)
Received: from ThinkPad-T490.. ([223.233.86.175])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f7092a525esm8168355ad.241.2024.06.09.04.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 04:21:22 -0700 (PDT)
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
Subject: [PATCH v6 1/1] riscv: mm: Add support for Svinval extension
Date: Sun,  9 Jun 2024 16:51:03 +0530
Message-Id: <20240609112103.285190-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240609112103.285190-1-mchitale@ventanamicro.com>
References: <20240609112103.285190-1-mchitale@ventanamicro.com>
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
 arch/riscv/mm/tlbflush.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce3867..49d7978ac8d3 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -6,6 +6,54 @@
 #include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
+#include <asm/cpufeature.h>
+
+#define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
+
+static inline void local_sfence_inval_ir(void)
+{
+	/*
+	 * SFENCE.INVAL.IR
+	 * 0001100 00001 00000 000 00000 1110011
+	 */
+	__asm__ __volatile__ (".word 0x18100073" ::: "memory");
+}
+
+static inline void local_sfence_w_inval(void)
+{
+	/*
+	 * SFENCE.W.INVAL
+	 * 0001100 00000 00000 000 00000 1110011
+	 */
+	__asm__ __volatile__ (".word 0x18000073" ::: "memory");
+}
+
+static inline void local_sinval_vma_asid(unsigned long vma, unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID) {
+		/*
+		 * rs1 = a0 (VMA)
+		 * rs2 = a1 (asid)
+		 * SINVAL.VMA a0, a1
+		 * 0001011 01011 01010 000 00000 1110011
+		 */
+		__asm__ __volatile__ ("add a0, %0, zero\n"
+					"add a1, %1, zero\n"
+					".word 0x16B50073\n"
+					:: "r" (vma), "r" (asid)
+					: "a0", "a1", "memory");
+	} else {
+		/*
+		 * rs1 = a0 (VMA)
+		 * rs2 = 0
+		 * SINVAL.VMA a0
+		 * 0001011 00000 01010 000 00000 1110011
+		 */
+		__asm__ __volatile__ ("add a0, %0, zero\n"
+					".word 0x16050073\n"
+					:: "r" (vma) : "a0", "memory");
+	}
+}
 
 /*
  * Flush entire TLB if number of entries to be flushed is greater
@@ -26,6 +74,16 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
 		return;
 	}
 
+	if (has_svinval()) {
+		local_sfence_w_inval();
+		for (i = 0; i < nr_ptes_in_range; ++i) {
+			local_sinval_vma_asid(start, asid);
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


