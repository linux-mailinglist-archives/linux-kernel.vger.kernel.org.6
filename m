Return-Path: <linux-kernel+bounces-364808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEC699D9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BDEB22275
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CE1D3562;
	Mon, 14 Oct 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3FaFNq6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD21D220A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943959; cv=none; b=e4QgoNW5lh6lixhagH64UpTQQp+ctIshJX9SGGBbgdpfvH5hU7uoczGXUi84uEeIlPsmgdFA8IQ1Zk37oXPgftgOeK6os9Z0x7mM5JbNFtPrTzI+a8GdX6au7OszGKY7da0nwDWOIiDAOMR/sw8IlXzhOyq/hsv0bw4FKfgEUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943959; c=relaxed/simple;
	bh=0z/yw8XBxQZ9FLV4oW3yo1/jmY/2fV4YQW5EdD8Ygb8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k32fBPxZ81UY45CFJaTmf9NlnUp5yDdWZ4F/vNn8xXNAhhC6pFvGXhcebtiGJPAIZxjsDDk2IjHzK81GQh9TVjSy+CiI+oa/YULV8KUa9EnBmKhs7lxu2McIz9f4sx6h4F2IY5Pdag1PnZ5rm0MBUfh+EQMu4WVhye8/TZR7Jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--weixugc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3FaFNq6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weixugc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20c7ba2722fso45125625ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728943957; x=1729548757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLFlB8ArhD8sBmaD8/9E7s8jR7UTSwheYDE3N7Ewx8Q=;
        b=H3FaFNq6wcwAW+Ebc+uZyokD31vGQiOHErACldR8Cv7mj8injaYkYKsg2efVkzzyrW
         d9uyQj/i5yXv8hxij5Ul+VVEHihFsYMW/7C+rR1U+mCnCkmSbz4bjp9wWUFOJIfS+OCy
         IaKS1twXZBJ37hH8FdF2o1YEDp/tcjOjAuk9khvCRBvTHzEAjPcIyos5DW/tfBaPoQ6b
         OBjG63MYoSymiDMzjxeq/ph0lGQ29+nnklcWTr1oTpJfCavq+ewR4HIQQ2gFvzu3W+bU
         j3iLZ4DByRZ/Q3TLHTy5nz8vGGnqeFEft6MoocCO3AL6xkJIUifC/t+gd9FOZa5tnhpu
         1P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943957; x=1729548757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLFlB8ArhD8sBmaD8/9E7s8jR7UTSwheYDE3N7Ewx8Q=;
        b=jPkK+57L3XaK5zPEMOlEjUSySMFaiojVmoIDn1jNLzUFR/LXfdzKnsFh/O+WcOsfRW
         hG1Qf6xq7AX7jYLOAMv2W8UvhfgSAo5gpQXQ5toHppFny+8GMwkIQJ6c24eodKomVrv3
         9Y0l2SRsNwKJetkfziGa44PDXMSPZQuKDFx49kGlYaMVRimNsJ2U/E4hFuAc2oEkP1Zn
         sMKPRqoBckVSzQTKLhShTEx4XtWGNLQyAR/+CsOMRH614pxoYfJbPUQ1myI6Qt0KN+j9
         4HrqmFHCLqk3cKAIieZUVmGDtIytAb/XpfWnferiI9ctcECbqs0A1856N7Jb05yRFpyA
         ngKA==
X-Forwarded-Encrypted: i=1; AJvYcCVbFyfaIw8tmVh0JxhSrTmbFFJyaeE6THyfrhod4LatwN7obe/yUoOUmaZT1P4Ggcm8Je4ZWlUmuU85+Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7lELFcMDglb6yW/owwPAIC8OlNB5SdohCtXtoPDAiksRgkXo
	MveZdeUekrrS2sd1Wcv7cLCzPLjgevHb/ozymflgRG3MdyZuAelGN1Si27pFEZpmYzttixqY0OP
	2C7ARGQ==
X-Google-Smtp-Source: AGHT+IEZbp7h/ndmghwF1NV+bCjPhzb/M48R/4ukJlrDWG9j0yNm9iKhDQ51QtS4buCnNidxEv+y6NGvapg5
X-Received: from monterey.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:641d])
 (user=weixugc job=sendgmr) by 2002:a17:903:181:b0:20c:d303:cae6 with SMTP id
 d9443c01a7336-20cd303cdffmr228005ad.5.1728943956134; Mon, 14 Oct 2024
 15:12:36 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:12:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014221231.832959-1-weixugc@google.com>
Subject: [PATCH 2/2] mm/mglru: reset page lru tier bits when activating
From: Wei Xu <weixugc@google.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Brian Geffon <bgeffon@google.com>, Jan Alexander Steffens <heftig@archlinux.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suleiman Souhlal <suleiman@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"

folio_activate() calls lru_gen_add_folio() to move the folio to the
youngest generation.  But unlike folio_update_gen()/folio_inc_gen(),
lru_gen_add_folio() doesn't reset the folio lru tier bits
(LRU_REFS_MASK | LRU_REFS_FLAGS).  Fix this inconsistency in
lru_gen_add_folio() when activating a folio.

Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
Signed-off-by: Wei Xu <weixugc@google.com>
---
 include/linux/mm_inline.h | 5 ++++-
 include/linux/mmzone.h    | 2 ++
 mm/vmscan.c               | 2 --
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f801c7b36e2..87580e8363ef 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -222,6 +222,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 {
 	unsigned long seq;
 	unsigned long flags;
+	unsigned long mask;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -257,7 +258,9 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	gen = lru_gen_from_seq(seq);
 	flags = (gen + 1UL) << LRU_GEN_PGOFF;
 	/* see the comment on MIN_NR_GENS about PG_active */
-	set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags);
+	mask = LRU_GEN_MASK | BIT(PG_active);
+	mask |= folio_test_active(folio) ? (LRU_REFS_MASK | LRU_REFS_FLAGS) : 0;
+	set_mask_bits(&folio->flags, mask, flags);
 
 	lru_gen_update_size(lruvec, folio, -1, gen);
 	/* for folio_rotate_reclaimable() */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..96dea31fb211 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -403,6 +403,8 @@ enum {
 	NR_LRU_GEN_CAPS
 };
 
+#define LRU_REFS_FLAGS		(BIT(PG_referenced) | BIT(PG_workingset))
+
 #define MIN_LRU_BATCH		BITS_PER_LONG
 #define MAX_LRU_BATCH		(MIN_LRU_BATCH * 64)
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9d1e1c4e383d..907262ebaef8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2601,8 +2601,6 @@ static bool should_clear_pmd_young(void)
  *                          shorthand helpers
  ******************************************************************************/
 
-#define LRU_REFS_FLAGS	(BIT(PG_referenced) | BIT(PG_workingset))
-
 #define DEFINE_MAX_SEQ(lruvec)						\
 	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq)
 
-- 
2.47.0.rc1.288.g06298d1525-goog


