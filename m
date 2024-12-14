Return-Path: <linux-kernel+bounces-445947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601889F1DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9177188BEFF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB1189902;
	Sat, 14 Dec 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gyELVjOM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042E85931
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167129; cv=none; b=SJmDINgUbNU7fnlBhcoHkL1ZmV82SZ9AkGas/nTyWfdlaeJWMfMdDIzVSP5pGUPe3Ckuxb1wdINaJ4mkv1fcBn8E6SfnapbSZSIL1GrV+Qx0kYwU84Z7H7/bgIg9wL+RfFKdvNotkxzl8JC/pLkqTtqwwawJ54RTuPvC3UTIQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167129; c=relaxed/simple;
	bh=AOHzYz3e0W68bypaywk5PqwWiTbsh7X+wa84FHfFzTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOeM5ln9VOpViWT8qMQJEvQOfzLNWDXp9AbmRaZ6TBISL7+sIIgp4l9QN67T/zSjGu8YgBBUB2kvWvPobUMcfTKwONW5AB0j4bSBu5ybjpUoLpyiT9TZyV2on4cFvebvT1IkOc5kBMRzCIluOgXM7KiYxIOO1fo1uFwnXYvzdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gyELVjOM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728f1e66418so2185630b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167128; x=1734771928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAJKsDdGNb+ALwQvMYs9Oz9Vq8VGrLJsA8GxB+kZmZc=;
        b=gyELVjOMzOIe6ph/l41hPbeC2fX3S/ImoO4KpcUfbLSsIUgGwpHMolKP6qnQCvFiaa
         NFVlNjKqy3WA1ibWyq/hacbnUjeJRFKwxn6yuVwiT99Fldm2p3e4Lbr/uRb0QzhpxV4M
         UzCOKiworw+LsfLlDkZXRGn/LfxovlJChAgbDjnM6Xtw+qX3jJ0GlQhTvHvaQEKFtZPp
         nya9l/fQJMm1lLAe1t4ZHGyxuQnPNv6PQBG4M24TPG5OubOC5Tg0jUgaHUC7lddaHQTi
         UjNz5sjpMt5NvOuUaptEwtfWqm6D0UZlvmd/qTlTh6rOz8ZMTcHGXXaKBH9C0MWy7Kpf
         GTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167128; x=1734771928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAJKsDdGNb+ALwQvMYs9Oz9Vq8VGrLJsA8GxB+kZmZc=;
        b=M51zLxY4ogOHAhbOf6LJ2jluJFN2DQN5GF07es009ByNdqHQUq4q0miWXRvkc9wI/w
         CnOArAckFcMfWOgGaN7ViE0RRgn6jNitiCmv7EooPZtRrReweyUobk8rBVL/9rrW1B+5
         Le50sHU6t5vexXU/trLedDLwo5AhYwf19jIlJ4r4HXatoJXl0GbCsivVOp1M0j8j15oq
         WrnCPIM/a+xcv6YoIY30uR3biYBpADEpilqjMELyBSvrjpXU1A90xfH0UP307Spug2hw
         ZFoMRRl7RDSQpCrLbZvYSdJgY/n3wo3r6kM2vyjxjKiKirhZNtO4173QBB+zlWvf0lsQ
         A7vA==
X-Forwarded-Encrypted: i=1; AJvYcCVl1vjsBA5AJgxsGNvLhSeEyCxzh3eTUOZnjD2o0jw72GWKpoE+KrCV19tXGkmYxumkPXkMXr3X931hg4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWw8fXhxtDjckWxVDK4gCEmt+62UYNx5arJg8HpTcGdlT1A7E+
	NHRLEscW21CSGmcrBWwltIU0xzlvDELphIYOyAhidRR0NtYJ2k7KlgpX5lFl9Unx0XLRT3wGY1q
	F
X-Gm-Gg: ASbGncsHFVpx5EnQxSelkHa7khK6VXuPi6R4Hs7kzdX22ykr7sYNBSELDVtLccCHIiH
	BPgK1i90kBw9cuSVGoW85oEsmB+fllBhGCOQZrgnCeSvC43v/KNEtnxJu6wXpyz00PB7p8NKS3u
	cqbOdpxwMAwuNPVghIRzgBZg5nlEHh50k+se1OCt7jnwmqGtyD0fXwxmzpM4HyupjhAO5B8lA7J
	ATyhDhrf4QAwcpYM75LBxx8CivBnfKyvaY83SFiWtUGbuQ6jzwO1lPYpqXjyRgEJSJxdiv2yvMk
	EA18JkUvS9zcHG8XPuWhX0tBj8V1Bg==
X-Google-Smtp-Source: AGHT+IFivM0byq9BUMDoda6VIidtD6lpjalZ4ywP7t2KopoDAAS1RcnNTtREGYaK+hQvD7u6okSdbQ==
X-Received: by 2002:a05:6a20:1588:b0:1db:e536:158e with SMTP id adf61e73a8af0-1e1dfd91a2emr6805131637.22.1734167127753;
        Sat, 14 Dec 2024 01:05:27 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:05:26 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 12/12] mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
Date: Sat, 14 Dec 2024 17:02:58 +0800
Message-Id: <b531c2b4a056a3ca473b39cbea27138fdebeaa75.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __tlb_remove_table_one() in x86 does not contain architecture-specific
content, so move it to the generic file.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/include/asm/tlb.h | 19 -------------------
 mm/mmu_gather.c            | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 3858dbf75880e..77f52bc1578a7 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,25 +20,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
-#ifdef CONFIG_PT_RECLAIM
-static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	__tlb_remove_table(ptdesc);
-}
-
-static inline void __tlb_remove_table_one(void *table)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = table;
-	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
-}
-#define __tlb_remove_table_one __tlb_remove_table_one
-#endif /* CONFIG_PT_RECLAIM */
-
 static inline void invlpg(unsigned long addr)
 {
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1e21022bcf339..7aa6f18c500b2 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -311,13 +311,29 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-#ifndef __tlb_remove_table_one
+#ifdef CONFIG_PT_RECLAIM
+static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
+}
+
+static inline void __tlb_remove_table_one(void *table)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
+}
+#else
 static inline void __tlb_remove_table_one(void *table)
 {
 	tlb_remove_table_sync_one();
 	__tlb_remove_table(table);
 }
-#endif
+#endif /* CONFIG_PT_RECLAIM */
 
 static void tlb_remove_table_one(void *table)
 {
-- 
2.20.1


