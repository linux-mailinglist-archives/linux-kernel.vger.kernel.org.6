Return-Path: <linux-kernel+bounces-369559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE09A1EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0811F26A65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482CB1DA605;
	Thu, 17 Oct 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OVjItaAx"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932D1DB953
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158490; cv=none; b=gD+svAtAh/xl0dVe4kvR9a7Ce0+MjYQkHJolqm9JvdQbiqi7kpTahCnWeb1AyS8+eGeESCmMF+W48Z+dgfezSRukAdRZtI0tp3q5cNXJQh2ZSvGLAnXzy8FduWeTk2DPmWCMczFGfqMFH6qC5MJyPb1T5hThitBIHHD5Y/BWV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158490; c=relaxed/simple;
	bh=XMqo9JC0uvRaenR0CNJgp9Ct19xGAvPL0Vj/MIAQrlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rv/fG3BN1G/ujcAVNR4dKA7uEZWjX4DBkOU27smAwixqQnbXsRZSHkWYbhVJMiQnPaIPzgFWgXEtrweKSL9YyRc1HenkdjdM4Bk8blM7HVt7En+NG0/XWpR8yPMNtXdgEuCjZ4dS4lVYh0KPE8nL5z3FjN0l7sDoCzfO9r1IbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OVjItaAx; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-28847f4207dso339781fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158487; x=1729763287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns8LrZyEwJOJHznjnD7PlHQ9MHEMoW624Fd3QWpp04I=;
        b=OVjItaAxwftIJm0xQkZV3VPxaUEZliINdH8RZchGKyGTaGRE/eJ4ZgFiPBAPKXRpdW
         6DSARKSykJNRZQ3MlpQ/5edBYzHWYxbQAO53bjvXBcCRvtNSYiPTViAF0p5fZx8mpKDj
         V4b9WHMzhoju5dNb1s0ApTVYJC1evTeKcoT7iH4Sa4WWZvDJVXFX1pgQj1Fe9CovVfEX
         vIwzCHQqpqNf9UjwpQ38XMJb+T0ILU1r7VJw4aCNMtsGGW1AXyZW8RVNHP+fLN5ceDoj
         3u3gwoDFsPdXMeTqPLIsHLjOLL3LgZSvNkx5mKZyIowC71enG1ngV1SY9nb4efbNdsJ2
         o/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158487; x=1729763287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns8LrZyEwJOJHznjnD7PlHQ9MHEMoW624Fd3QWpp04I=;
        b=d7RG13VT30+xX6/m1COlllImPX+vLqKKt1TGeavXMPpxx/+P2EKm5BSKMlH9bHhz4S
         SQVfqcy8YiZFqU3fiIm5aFShXZ6OPoHOIcWKjPoPMQJjEZlKTJwOF8XJhOWWRC2Rj52W
         VACvjIz01ZxNTIrh5TeplBnXL4aaz4YaiDc0sP8v3J17iWiNTy/SeuogYVU7Gar9ElMk
         AOp1eWgLHaNXGwNIOmQnqpA+0CzW0OKke1UJMz2cpS4Afl8xi+TGapmkbHlLqh4lbULS
         ob+wcO1Z0+cfHZOund+0LJ8Ec3mISbcUJdHSNRNCFxl0FLKU2P7OHAms9inD8AANcXSg
         4wYA==
X-Forwarded-Encrypted: i=1; AJvYcCWw01b5jPlOdvL3z+I6GIiyz+U4z2EC5wXPGRQjpOO+pWeZufsHYtFeyc8CRjmPwXBn4hDJZlOxQwaCOsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtF7uSnc5Prm8ciHqiVxW0koUqkGczCaLmcmhHUFzNvcYatC0B
	IfF2Ij+LH2vo+c4Dg5EIfYfXAqWa0Seu14/fx1FTLpgSQOSKcAXKi0M7v+O78A0=
X-Google-Smtp-Source: AGHT+IHvYEBhNwHNitO8wA559PhHl4cuzZKZHlF0Sd6OJ2vGi8dRLztGVbwRe2pbe9tQOZtPvKzwMw==
X-Received: by 2002:a05:6870:798:b0:287:ce7:7c4a with SMTP id 586e51a60fabf-2886e00f920mr16405829fac.38.1729158486665;
        Thu, 17 Oct 2024 02:48:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:48:06 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 3/7] mm: zap_install_uffd_wp_if_needed: return whether uffd-wp pte has been re-installed
Date: Thu, 17 Oct 2024 17:47:22 +0800
Message-Id: <37983544cb4fbd27c244b68d3e37d170ea51f444.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1729157502.git.zhengqi.arch@bytedance.com>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, we'll replace the none pte with an uffd-wp swap special pte
marker when necessary. Let's expose this information to the caller through
the return value, so that subsequent commits can use this information to
detect whether the PTE page is empty.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm_inline.h | 11 ++++++++---
 mm/memory.c               | 15 +++++++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f801c7b36e2f..c3ba1da418caf 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -552,8 +552,10 @@ static inline pte_marker copy_pte_marker(
  * pte, and if they see it, they'll fault and serialize at the pgtable lock.
  *
  * This function is a no-op if PTE_MARKER_UFFD_WP is not enabled.
+ *
+ * Returns true if an uffd-wp pte was installed, false otherwise.
  */
-static inline void
+static inline bool
 pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 			      pte_t *pte, pte_t pteval)
 {
@@ -570,7 +572,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	 * with a swap pte.  There's no way of leaking the bit.
 	 */
 	if (vma_is_anonymous(vma) || !userfaultfd_wp(vma))
-		return;
+		return false;
 
 	/* A uffd-wp wr-protected normal pte */
 	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
@@ -583,10 +585,13 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	if (unlikely(pte_swp_uffd_wp_any(pteval)))
 		arm_uffd_pte = true;
 
-	if (unlikely(arm_uffd_pte))
+	if (unlikely(arm_uffd_pte)) {
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
+		return true;
+	}
 #endif
+	return false;
 }
 
 static inline bool vma_has_recency(struct vm_area_struct *vma)
diff --git a/mm/memory.c b/mm/memory.c
index fd57c0f49fce2..534d9d52b5ebe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1467,27 +1467,34 @@ static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
 /*
  * This function makes sure that we'll replace the none pte with an uffd-wp
  * swap special pte marker when necessary. Must be with the pgtable lock held.
+ *
+ * Returns true if uffd-wp ptes was installed, false otherwise.
  */
-static inline void
+static inline bool
 zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 			      unsigned long addr, pte_t *pte, int nr,
 			      struct zap_details *details, pte_t pteval)
 {
+	bool was_installed = false;
+
 	/* Zap on anonymous always means dropping everything */
 	if (vma_is_anonymous(vma))
-		return;
+		return false;
 
 	if (zap_drop_file_uffd_wp(details))
-		return;
+		return false;
 
 	for (;;) {
 		/* the PFN in the PTE is irrelevant. */
-		pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
+		if (pte_install_uffd_wp_if_needed(vma, addr, pte, pteval))
+			was_installed = true;
 		if (--nr == 0)
 			break;
 		pte++;
 		addr += PAGE_SIZE;
 	}
+
+	return was_installed;
 }
 
 static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
-- 
2.20.1


