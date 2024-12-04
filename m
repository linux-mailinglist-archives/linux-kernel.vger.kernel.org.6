Return-Path: <linux-kernel+bounces-431050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1149E3879
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD7C286087
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571661B3953;
	Wed,  4 Dec 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fd8dYFhF"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B81B21B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310666; cv=none; b=tiEMxWJaqwm1d3HmMOVCBTWo3E3XUAzAxN2CcQjWx9dxyotjUelKaXMTaMHQ1ANZvnSR5sYM+tDvD0qhhY6rxOxx6WSTaCWksmF7Ro7znF7fuxCaqTPhH48BUW4uX3mK1seOKvQFsW8NuHjRo1lO5S8PkLCjnFN7DjTscv2KQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310666; c=relaxed/simple;
	bh=++EmkIKLFQMSIfBYBqEt6AEoPkuK3CGOfEOambsCph0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LinA4A5EhCZcTGWV6dhqRFKO5gn/+v766jxC6qsXKKk2CyM+B9qEo6z9SGY72WddFPYpPY45lMdD0Evr56WJC3iUeII1iSB4mCcUlOgT+m2PU60BGAAVY9nU0Ndk4kpVAVG06r4D/k93cVaARlnTBqER8hwWMr2fLis4iZOag/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fd8dYFhF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215d92702feso5004155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310664; x=1733915464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBcCGE4XlG5U77pGfU9yv3mqGKsFB2BwbFt8OgUUtNY=;
        b=fd8dYFhFsOmqXAdGANS92uMrZuoKPDJXJvPu36DOteo9/vL4Ypald5b2sUc3qvjZ/i
         B+9cSmZ1uUudfGxfFFIrdiTb3F+7n2pqt6vszYqgSIocmC6lu88eSUyBUy8Glm35HTaa
         pMYgSqEzU+p1Pz3cooFKiRl8gulOO0os7/QQeHx/GJh/WmLi1W/FLBWE9/7Wsp5Q1D7/
         X8gixtrzREI7zUk2yXN2fZ3so3EcYFXn/7Q3PlusbpbeMW7wdUC6Y78IQv7s+XPnaPJi
         M3l/tuM4xBq9xp+MGDrt/crXEZxYS+RZkpkoGYBJaCTb0VpRjsncleFLeeQvbXqH8b3f
         EeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310664; x=1733915464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBcCGE4XlG5U77pGfU9yv3mqGKsFB2BwbFt8OgUUtNY=;
        b=K6t/M8UwkLVO6AuuHb8PpnLzO/r8P8PMN/2w5U4Rf8OP9jEjG5V2FlWrGIooIKocqw
         FR7z4mqXweEkrScj7D4EpFAHQX7PyIf+bbZ/jBnmhn8Yz86Ha1BS/Fbc4UTDhycGP60q
         +2qn9tUZs+Z90T9j5bO3UOLmxGoGCWhZNWf66zUwlPhR5pr2FbO+q18TTJKMVG4Rk4O8
         w12LbCGzcwXceXfAhG5d3lzS5qnbtxKtSwVRvKArNccSmZ4lDoYLstN1LVv0oWl1uL9a
         h0wBuZQJitDMntzhXxdCsNWkZTbcQ3gjXvsGiRIyBiK41luZW/810yhH4r8XIWVjsRTo
         OAZg==
X-Forwarded-Encrypted: i=1; AJvYcCUUwSXnMzjSMgF3K5qQshNT1YydSOUZHJ3SfxyQz/7SntYUKPaxD1dOsMEyaOZhn+UigB4WYVelCbDuR6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyur2GyQIbsBjatHCynS6XetNL0S05WpqckQtMQHlmrFit6JeOx
	jekO0Ax552y+6+tymPFY7KvtSw+3CZi0gUk4vjOti/3kDHxmvltUKd2CNP69x74=
X-Gm-Gg: ASbGncvmUUde70s/xrktowhx2fme4aJEruohjutYGC9wZXQasH0nJ8bQT6c8U2vWbve
	r0vVFTH8mdk/mO83IP3p95QehoMWgQf7BnzD8WqByOAhT7vSeULP7uRkCHT49MFMAMnjR7jPCer
	cBHW3EHvyfjodF+Q/J6kY2u8Xmrx+XwRSZJnhaz+J5DOJxhRZiLLAg2ak0zYrDYhAnR8lGenIpF
	R2SjmhKcjWuIi+wxRYtNtzo2nL7ek4zokAYKs9AuH/V86g5zBrGsAqeyU8GGPC9cOE53Re+FqrY
	hnjUq+ZZDjoQCZo=
X-Google-Smtp-Source: AGHT+IEq78EZW9DPKE8ZtBXaTwCJuq93zz+P96KIjyqh8unYy/RsaRnFkAa1Daiqvh42R9qprpb8TQ==
X-Received: by 2002:a17:902:f687:b0:215:5a53:edee with SMTP id d9443c01a7336-215bcfc52f9mr64931185ad.9.1733310664497;
        Wed, 04 Dec 2024 03:11:04 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:11:03 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 06/11] mm: zap_install_uffd_wp_if_needed: return whether uffd-wp pte has been re-installed
Date: Wed,  4 Dec 2024 19:09:46 +0800
Message-Id: <9d4516554724eda87d6576468042a1741c475413.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
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
 include/linux/mm_inline.h | 11 +++++++----
 mm/memory.c               | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 1b6a917fffa4b..34e5097182a02 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -564,9 +564,9 @@ static inline pte_marker copy_pte_marker(
  * Must be called with pgtable lock held so that no thread will see the none
  * pte, and if they see it, they'll fault and serialize at the pgtable lock.
  *
- * This function is a no-op if PTE_MARKER_UFFD_WP is not enabled.
+ * Returns true if an uffd-wp pte was installed, false otherwise.
  */
-static inline void
+static inline bool
 pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 			      pte_t *pte, pte_t pteval)
 {
@@ -583,7 +583,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	 * with a swap pte.  There's no way of leaking the bit.
 	 */
 	if (vma_is_anonymous(vma) || !userfaultfd_wp(vma))
-		return;
+		return false;
 
 	/* A uffd-wp wr-protected normal pte */
 	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
@@ -596,10 +596,13 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
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
index 7f8869a22b57c..1f149bc2c0586 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1466,27 +1466,35 @@ static inline bool zap_drop_markers(struct zap_details *details)
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
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 	/* Zap on anonymous always means dropping everything */
 	if (vma_is_anonymous(vma))
-		return;
+		return false;
 
 	if (zap_drop_markers(details))
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
+#endif
+	return was_installed;
 }
 
 static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
-- 
2.20.1


