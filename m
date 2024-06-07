Return-Path: <linux-kernel+bounces-205403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDECA8FFB10
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79412288765
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17013DDAE;
	Fri,  7 Jun 2024 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVj1fJka"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8801384A9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736121; cv=none; b=rioR+CRxZTQxI/tVSl8Gczysa3lIzEm8RO/1/7V+DRAxkouMLpV+39zP+q+jgXTDOdU1soTmYtO318TtpuOuc7GeplKpYA7vlm54aJsA33DUmlc+5IRgMdxZiEGh69+5BRonrFhE5+SwjbEWJ2ncTpvEl+H36Jsa0ezJxvyoHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736121; c=relaxed/simple;
	bh=h1xhaqicS+1i/trqq3F/Yq3IRsq2JOZCrP9Tsi4+Ef4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hail6+yRSO5qLkhprIiCFwpNeqLFR55j6b/QgjPiaTgR76uJ0fxNP1epgwoqvv4C2P2IXItUU1tI02KP3Kd6bwXFo/jcQohSh9OD9SaS5n6Z7Q5/O9wNK+IIrdvEVb1+/p38hrG/y/NmCvGM6CWsOITOn/8mRbWI5PUslgSG/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVj1fJka; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa77d54cd2so2713806276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 21:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717736118; x=1718340918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OYdwPhyhNa9Izr7t6fCsRMDARDJ3D6wcaG4TenaGYA8=;
        b=DVj1fJkaqr8D5873/DbCUjlDHO2ziubXr5cC15McoE7Go3a7gMAe2Q9DElNfxbprCQ
         MOQFFu6vOdWhQYekwEJo5BzsZUKbVlYDq6ihUC6sCxAcTr74Yq6Qbeve8Nr3Cv6REkYu
         cyrUcpHJSb+XukukWANIUSEUFgJg3VmU33aE37YWEd7NY6Wth0QO+yEWvKziq5/jskKZ
         v18qfS7rPc1Up2xnbqeMMOgQDTUZ2PJTeiLQskXBguFy3e9cmxverrn22OUcRYlbVieM
         +qSYrzB6ipifxxJZ9JJDxQ282lsSTDIlGCMo7Mqh1WT9Mygc84HnpDCMmJmAWLe7/oEF
         imfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717736118; x=1718340918;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYdwPhyhNa9Izr7t6fCsRMDARDJ3D6wcaG4TenaGYA8=;
        b=FYR9EHC0fzTcQk4oUqwvMYsVOStQG+zsHg4hCQuH/M/ta1/FxWxd974f2hkvjLWYBw
         64j+g7/HsCN7AUNbUhgV5zsuk3zLV8SjBORmZLUHzFl3aKiULFA6/uBgmgZ0ngAaHrZ/
         sLhjyWmy1UviFBhokBOBcF9HsOuEdS36hTfZlm4oi33ZwKz4UDo1B1exfeDiFn+A9xEo
         4x4tdnlEpEiF4kFhxutCjDJ7qC82PuJcoVfbcqqkY8rUj37ktOG1FVP4UvJz9xs6Sy3m
         dvmDIIKhms/XyEIiLSXNofWNJ8dyl5KIUvPttZ5eauPxOXfFdGI/vkc/VcO3XeewPWGg
         CJmw==
X-Forwarded-Encrypted: i=1; AJvYcCXbHN/BKJiBsJRaWCkWPZhRZnxE/ErOC5G2cpl8xy5OCe96LRVVEVKLUgApEmLFI4YhbIFrKC4MJrO8zhXWuEga14I5QqivK21fdV/A
X-Gm-Message-State: AOJu0YznDvQCtztVC44Vi28+YrFyyEJXlflRSRd/mqNvbh/D2ozoFthf
	YmBWfG7bGu5K/ez4yQtt9MU25Y580y/w/fEvIF2azB5n/fgt88/2uz8TwVADM/QHPAsDVk/SZ4l
	uma6Ev9Et1QsjzO9/Ow==
X-Google-Smtp-Source: AGHT+IEv8nz+gxYGrnMhEiKFDXTsWv1jFxyEGs9paC12YqiVNJpvm1ANOW3vTT96ligvd/cwGEcbnl6Mw4T8vX+O
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:f607:0:b0:df1:d00c:130c with SMTP
 id 3f1490d57ef6-dfaf64eee07mr70778276.5.1717736118238; Thu, 06 Jun 2024
 21:55:18 -0700 (PDT)
Date: Fri,  7 Jun 2024 04:55:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607045515.1836558-1-yosryahmed@google.com>
Subject: [PATCH v2] mm: swap: remove 'synchronous' argument to swap_read_folio()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit [1] introduced IO polling support duding swapin to reduce swap read
latency for block devices that can be polled.  However later commit [2]
removed polling support. Commit [3] removed the remnants of polling
support from read_swap_cache_async() and __read_swap_cache_async().
However, it left behind some remnants in swap_read_folio(), the
'synchronous' argument.

swap_read_folio() reads the folio synchronously if synchronous=true or
if SWP_SYNCHRONOUS_IO is set in swap_info_struct. The only caller that
passes synchronous=true is in do_swap_page() in the SWP_SYNCHRONOUS_IO
case.

Hence, the argument is redundant, it is only set to true when the swap
read would have been synchronous anyway. Remove it.

[1] Commit 23955622ff8d ("swap: add block io poll in swapin path")
[2] Commit 9650b453a3d4 ("block: ignore RWF_HIPRI hint for sync dio")
[3] Commit b243dcbf2f13 ("swap: remove remnants of polling from read_swap_cache_async")

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1 -> v2:
- Collected Reviewed-by (Thanks Ying!).
- Added some historical context in the commit log (Ying).

---
 mm/memory.c     |  2 +-
 mm/page_io.c    |  6 +++---
 mm/swap.h       |  6 ++----
 mm/swap_state.c | 10 +++++-----
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index db91304882312..2b3ef08e8bb7d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4113,7 +4113,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				/* To provide entry to swap_read_folio() */
 				folio->swap = entry;
-				swap_read_folio(folio, true, NULL);
+				swap_read_folio(folio, NULL);
 				folio->private = NULL;
 			}
 		} else {
diff --git a/mm/page_io.c b/mm/page_io.c
index 41e8d738c6d28..f1a9cfab6e748 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -493,10 +493,10 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
-void swap_read_folio(struct folio *folio, bool synchronous,
-		struct swap_iocb **plug)
+void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
@@ -521,7 +521,7 @@ void swap_read_folio(struct folio *folio, bool synchronous,
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
-	} else if (synchronous || (sis->flags & SWP_SYNCHRONOUS_IO)) {
+	} else if (synchronous) {
 		swap_read_folio_bdev_sync(folio, sis);
 	} else {
 		swap_read_folio_bdev_async(folio, sis);
diff --git a/mm/swap.h b/mm/swap.h
index 2c0e96272d498..baa1fa946b347 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -11,8 +11,7 @@ struct mempolicy;
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
-void swap_read_folio(struct folio *folio, bool do_poll,
-		struct swap_iocb **plug);
+void swap_read_folio(struct folio *folio, struct swap_iocb **plug);
 void __swap_read_unplug(struct swap_iocb *plug);
 static inline void swap_read_unplug(struct swap_iocb *plug)
 {
@@ -83,8 +82,7 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 }
 #else /* CONFIG_SWAP */
 struct swap_iocb;
-static inline void swap_read_folio(struct folio *folio, bool do_poll,
-		struct swap_iocb **plug)
+static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 }
 static inline void swap_write_unplug(struct swap_iocb *sio)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0803eedeabe3d..994723cef8217 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -567,7 +567,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	mpol_cond_put(mpol);
 
 	if (page_allocated)
-		swap_read_folio(folio, false, plug);
+		swap_read_folio(folio, plug);
 	return folio;
 }
 
@@ -684,7 +684,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, false, &splug);
+			swap_read_folio(folio, &splug);
 			if (offset != entry_offset) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
@@ -701,7 +701,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
-		swap_read_folio(folio, false, NULL);
+		swap_read_folio(folio, NULL);
 	}
 	return folio;
 }
@@ -834,7 +834,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		if (!folio)
 			continue;
 		if (page_allocated) {
-			swap_read_folio(folio, false, &splug);
+			swap_read_folio(folio, &splug);
 			if (addr != vmf->address) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
@@ -853,7 +853,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 					&page_allocated, false);
 	if (unlikely(page_allocated)) {
 		zswap_folio_swapin(folio);
-		swap_read_folio(folio, false, NULL);
+		swap_read_folio(folio, NULL);
 	}
 	return folio;
 }
-- 
2.45.2.505.gda0bf45e8d-goog


