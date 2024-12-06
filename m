Return-Path: <linux-kernel+bounces-434150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D979E6243
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E394F283369
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0CD1DFFC;
	Fri,  6 Dec 2024 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iuxx1ITB"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2438384
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445099; cv=none; b=Ap9dqP06/ekVpyz8gQupDPx13s5MDfzttUjo1MXXjWg70NGiuhCpCvP3qkm/Tj7vAEVr2Zc+N0WGCeMNTJrqAkpGS1aGQdKrIn4whY7tKL6vLwaEPdYOfJb8Tf9zaax01f6cgGhPF/zpQXj7BenPeaQitnd/sN2Txjv3T6Df7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445099; c=relaxed/simple;
	bh=1hD1lletugdyH+qz+YPYmDUibRXlcEodpBsnm0JbD9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rwdIv7wiMVonbEA9OQBVMVYvypJVG6UJZYMiwHfMxOnOLrO4764+ubX16kBcr73+yHErS3R9+GmWlvpiccn2+XErxsBsxlabaY4X6mZCB2CIvcF5DOcG1hFhBG2eT8deUWttI+CVxE1N4nh9MvKxIqxyJs22awmJIcnXluYoib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iuxx1ITB; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-29e4a2e4d82so2029448fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733445097; x=1734049897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MW8P2vBtR0tiHVuNXF698UnUQTzNbjkVYUdDrWgvFuo=;
        b=Iuxx1ITB+fDgH+vJFMe7sT2Iv1lDYccP+du2DgRXZ3u4aA75i6OH80vHK4wrupHE9G
         Kb2O+D72X9sddTFeweJwtY3qPbmoz2sK0P8egLwDf/2QGpqbINEoUDwca9S482dQ+Vv2
         1c0Yd7WchhB8La2S0YCRWzq480NfSUbVGE+ZTLspn7MvsAc7Kjtz6nwHyplwWcDjGIsc
         /h/W3k3o6P2+2Ag6gj9q3f4AZrNNFc7/7Tw8EJp07f2m7NANO9XXToN04kYB81OXVpQ6
         Rr13arydU5U1NJc0+1wX/fT5hO8J8pyHpBJ9UbRudnB6ELbtqwVL472OEbjBS+MDE408
         MWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445097; x=1734049897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW8P2vBtR0tiHVuNXF698UnUQTzNbjkVYUdDrWgvFuo=;
        b=MzMax/czVG84ub7kiU/oj4DPy2GyrTcHqtUkzIlfqFZZ43ats1fObRwUxuaGo1mJ80
         RGDb5mq1DLNR0UndsBcUZtyzwvPj2uM02KQHL1AQBr1GFFYV2vIoDiPiWLYZWQIDR2Xf
         SJ5eJFtgVPIMkLa5jBpvELikuJA9ZuMXPHw+DsrYPHihRC26AudmBnqqwksiEksN3m7l
         X69bEWOlDxhtAxLIMJrmqQyJqUWqP57k9GkRJ57ooA79bXhaYxck1/i8mvX+DN86H3iu
         z3MBDBeGC6N5YwdMm+ywQHKtcehcImDzo8inzBS3WXrxNwc+3Ux9ZxAu0LR7cKhakdmz
         ALUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP2NW7HYb9XNhHHF+efBYWGEy3tpkigcZvka3TK6dK//OK7G+fzvOh22UamybQQrisj0LT1wAw+jv/s6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0oeNHOQzXztdp65pEK8qBZSvu1J6LIvJjOPszwyw5yhOrcru
	87itU8dxl42/8NYVEPQ0rFKkAS093LElkaPdZVjRhAdDxZrovft2XZ4FxV7/4QYVKSwdyCuC3Zv
	zaA==
X-Google-Smtp-Source: AGHT+IHG56U6ff/2ISJCA5gXcXDrcTLQkj6CAfollUPpPgK2o7iXSrjbLgXvQK+fFy4kFbchimZeACpqNOE=
X-Received: from oabra18.prod.google.com ([2002:a05:6871:6112:b0:29e:9a9e:5041])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d90c:b0:29e:4b63:d7
 with SMTP id 586e51a60fabf-29f731a2894mr1012088fac.1.1733445096951; Thu, 05
 Dec 2024 16:31:36 -0800 (PST)
Date: Thu,  5 Dec 2024 17:31:22 -0700
In-Reply-To: <20241206003126.1338283-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206003126.1338283-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206003126.1338283-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 2/6] mm/mglru: optimize deactivation
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Bharata B Rao <bharata@amd.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Do not shuffle a folio in the deactivation paths if it is already in
the oldest generation. This reduces the LRU lock contention.

Before this patch, the contention is reproducible by FIO, e.g.,

  fio -filename=/dev/nvme1n1p2 -direct=0 -thread -size=1024G \
      -rwmixwrite=30  --norandommap --randrepeat=0 -ioengine=sync \
      -bs=4k -numjobs=400 -runtime=25000 --time_based \
      -group_reporting -name=mglru

  98.96%--_raw_spin_lock_irqsave
          folio_lruvec_lock_irqsave
          |
           --98.78%--folio_batch_move_lru
               |
                --98.63%--deactivate_file_folio
                          mapping_try_invalidate
                          invalidate_mapping_pages
                          invalidate_bdev
                          blkdev_common_ioctl
                          blkdev_ioctl

After this patch, deactivate_file_folio() bails out early without
taking the LRU lock.

A side effect is that a folio can be left at the head of the oldest
generation, rather than the tail. If reclaim happens at the same time,
it cannot reclaim this folio immediately. Since there is no known
correlation between truncation and reclaim, this side effect is
considered insignificant.

Reported-by: Bharata B Rao <bharata@amd.com>
Closes: https://lore.kernel.org/CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/swap.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 3a01acfd5a89..15a94be8b0af 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -379,7 +379,8 @@ static void __lru_cache_activate_folio(struct folio *folio)
 }
 
 #ifdef CONFIG_LRU_GEN
-static void folio_inc_refs(struct folio *folio)
+
+static void lru_gen_inc_refs(struct folio *folio)
 {
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
@@ -406,10 +407,30 @@ static void folio_inc_refs(struct folio *folio)
 		new_flags |= old_flags & ~LRU_REFS_MASK;
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 }
-#else
-static void folio_inc_refs(struct folio *folio)
+
+static bool lru_gen_clear_refs(struct folio *folio)
 {
+	int gen = folio_lru_gen(folio);
+	int type = folio_is_file_lru(folio);
+	struct lru_gen_folio *lrugen = &folio_lruvec(folio)->lrugen;
+
+	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+
+	/* whether can do without shuffling under the LRU lock */
+	return gen == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
 }
+
+#else /* !CONFIG_LRU_GEN */
+
+static void lru_gen_inc_refs(struct folio *folio)
+{
+}
+
+static bool lru_gen_clear_refs(struct folio *folio)
+{
+	return false;
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 /**
@@ -428,7 +449,7 @@ static void folio_inc_refs(struct folio *folio)
 void folio_mark_accessed(struct folio *folio)
 {
 	if (lru_gen_enabled()) {
-		folio_inc_refs(folio);
+		lru_gen_inc_refs(folio);
 		return;
 	}
 
@@ -524,7 +545,7 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
  */
 static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
 {
-	bool active = folio_test_active(folio);
+	bool active = folio_test_active(folio) || lru_gen_enabled();
 	long nr_pages = folio_nr_pages(folio);
 
 	if (folio_test_unevictable(folio))
@@ -589,7 +610,10 @@ static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
 
 	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
-	folio_clear_referenced(folio);
+	if (lru_gen_enabled())
+		lru_gen_clear_refs(folio);
+	else
+		folio_clear_referenced(folio);
 	/*
 	 * Lazyfree folios are clean anonymous folios.  They have
 	 * the swapbacked flag cleared, to distinguish them from normal
@@ -657,6 +681,9 @@ void deactivate_file_folio(struct folio *folio)
 	if (folio_test_unevictable(folio))
 		return;
 
+	if (lru_gen_enabled() && lru_gen_clear_refs(folio))
+		return;
+
 	folio_batch_add_and_move(folio, lru_deactivate_file, true);
 }
 
@@ -670,7 +697,10 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	if (folio_test_unevictable(folio) || !(folio_test_active(folio) || lru_gen_enabled()))
+	if (folio_test_unevictable(folio))
+		return;
+
+	if (lru_gen_enabled() ? lru_gen_clear_refs(folio) : !folio_test_active(folio))
 		return;
 
 	folio_batch_add_and_move(folio, lru_deactivate, true);
-- 
2.47.0.338.g60cca15819-goog


