Return-Path: <linux-kernel+bounces-274958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07C947EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE021C21D40
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201C15B0FA;
	Mon,  5 Aug 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxjy06t/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E53CF5E;
	Mon,  5 Aug 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873184; cv=none; b=cQbGrUiXxKCJrlrt0s8lhC97wpCvEvgWnigvSpG9xHSciQ4WikeSaLGHmCnwRbWUvnA2tCYsN6RMFO4gtH96CERo8TbbE9SqsY0OCWL/K7UFbHlAM6mMi3xPGUT5QyAqBcpbGc0Vtr13frIRx89/E3ys0qObzbSdnVPDwN1htM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873184; c=relaxed/simple;
	bh=OeL22E/KXmQ82MAYYQh1u09OhI8MXN/L0x8aTvEVZHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MfRxylsN3VJn8Gg2T3rGLd4m+b21f/t+2AViKyY/11pN/neg625lb1UYmzP5jFNczs7czXcq1LCvHIndNSTK648sycBexJN5XOzasorFIwNpNT5WJ/WWuLVFXUFB/dTtBydh24kusIY5qfHD8XJw+bDCsXk9JZ/xV1CWAXfEAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxjy06t/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd9e6189d5so84375335ad.3;
        Mon, 05 Aug 2024 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722873182; x=1723477982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Exxr9ZKCMR26O37xzhkua2Zgj/OpQR6qjUogB6VNG44=;
        b=bxjy06t/CmC3c4zosIK65wCyz+euOsJk5wOtAmcN4oOU9t53NRV+u2E9JUajfNYmxa
         2UXHXk4tlJFXv68JUNO+zw3Xeykxy/b44R/HNRWOEKTwPMESsHuWKLh5LaSdfoE0B+ia
         /Glko0PKJTzbOTL28Ewt/xbU31gUYS+O3RUTW6gWvCXl4O0iSsNCUfREiO9HFWZ+eArR
         CdLXcYXvAorUAUSjsz2wXNfM4B3TN1XLqehOli2RZ+v0Ahu7lhyP6lgRKOYjeW+WI3UY
         VOzUOKh86f4VRgWCY0mRpPFc4jXMc40+UdBaG2QnJurfAsGcKheRiyeanHRkpyybtfwy
         eHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722873182; x=1723477982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Exxr9ZKCMR26O37xzhkua2Zgj/OpQR6qjUogB6VNG44=;
        b=vXvu0OZvwcQNhfZb7RTKC2rmvqL0Gp3YQ5xpVFEP8tDnXKUpP7198zNtwNPNGqlAAI
         Qh+r3wY7sk9nmilN6AulcjnxCUVpYeuI5N0ipiQv37x2lXf0WSu1i0KEVS5v9u6lA+Qk
         nosmic1oK6SYCDH/hJLBz53EBZt1X21m8Pi/RL4Kp6O1d1FobV3oC8gXIp866NJ09KtV
         2YmftaqTSli6Ji0HzWbDy0a1a3zH50kjZGMwzZxYhvKR/BF+vII7xHNjM1dxsCxvFHnu
         1ywcvrB8GGdXeE6sliUZMIBAJ2s81vfb3fr/pA9dbY/LKrpL0igWHYN5aXUp5hh/V9dq
         wMNw==
X-Forwarded-Encrypted: i=1; AJvYcCX9oowgd7o8Jdf4YdBNJ0I55lKjPCijgESEz4AmzFcyht/lyxfDT1jRQfkB/Mn7wqo7fZ/26hQ2LUiyuMNamJmPKl08cD2jMBIQ9KkKo9dcNnF1eivWSlyBfzTNbfiiJKGo94XlUrcfZjE=
X-Gm-Message-State: AOJu0Yz7Kxo3WpU4orF9LBVnLHCMRJQpJYbg8gWWlsm8r5yxQoVPJTYC
	ZI1MIkEREHVgCGmU/R9cj7eoq0yfmvvrz51ij9jqKS9u0TbShcDe
X-Google-Smtp-Source: AGHT+IEdJ+tzVMwuAuEgGleilvj4BLgv+tkS7bWC+VW5HR4lKxwc3SudV36tsF8Xd6dXqa2WuNgpAQ==
X-Received: by 2002:a17:902:e5c3:b0:1fc:5319:8c7d with SMTP id d9443c01a7336-1ff574dfd29mr139067605ad.61.1722873181430;
        Mon, 05 Aug 2024 08:53:01 -0700 (PDT)
Received: from embed-PC.. ([122.169.160.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f272f0sm69802055ad.4.2024.08.05.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:53:01 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: oswald.buddenhagen@gmx.de,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: emu10k1: Fix coding style issues and warnings
Date: Mon,  5 Aug 2024 21:22:06 +0530
Message-Id: <20240805155206.463035-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix coding style errors and warnings in sound/pci/emu10k1/memory.c
reported by checkpatch.pl. Changes includes:

- Add spaces after commas in macro definitions.
- Insert blank lines after variable declarations.
- Consistent spacing around operators.
- Remove trailing whitespace.
- Move EXPORT_SYMBOL declarations to immediately follow their
  respective functions.
- Correct spacing in conditional statements and type casts.

Fix the following errors and warnings:

ERROR: space required after that ',' (ctx:VxV)
+#define __set_ptb_entry(emu,page,addr) \

ERROR: space required after that ',' (ctx:VxV)
+#define __set_ptb_entry(emu,page,addr) \

ERROR: space required after that ',' (ctx:VxV)
+#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)

ERROR: space required after that ',' (ctx:VxV)
+#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)

ERROR: space required after that ',' (ctx:VxV)
+#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)

ERROR: space required after that ',' (ctx:VxV)
+#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)

ERROR: space required after that ',' (ctx:VxV)
+#define set_silent_ptb(emu,page)
	__set_ptb_entry(emu,page,emu->silent_page.addr)

ERROR: space required after that ',' (ctx:VxV)
+#define set_silent_ptb(emu,page)
	__set_ptb_entry(emu,page,emu->silent_page.addr)

ERROR: space required after that ',' (ctx:VxV)
+#define set_silent_ptb(emu,page)
	__set_ptb_entry(emu,page,emu->silent_page.addr)

WARNING: Missing a blank line after declarations
+	int i;
+	page *= UNIT_PAGES;

WARNING: Missing a blank line after declarations
+	int i;
+	page *= UNIT_PAGES;

ERROR: space required after that ',' (ctx:VxV)
+#define get_emu10k1_memblk(l,member)
	list_entry(l, struct snd_emu10k1_memblk, member)

WARNING: space prohibited between function name and open parenthesis '('
+	list_for_each (pos, &emu->mapped_link_head) {

WARNING: Missing a blank line after declarations
+	struct snd_emu10k1_memblk *blk =
		get_emu10k1_memblk(pos, mapped_link);
+	if (blk->mapped_page < 0)

ERROR: else should follow close brace '}'
+		}
+		else if (size > max_size) {

ERROR: need consistent spacing around '-' (ctx:WxV)
+	psize = get_aligned_page(size + PAGE_SIZE -1);
 	                                          ^

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL(snd_emu10k1_memblk_map);

WARNING: Missing a blank line after declarations
+		dma_addr_t addr;
+		if (ofs >= runtime->dma_bytes)

ERROR: space prohibited after that '!' (ctx:BxW)
+		if (! is_valid_page(emu, addr)) {
 		    ^

ERROR: trailing whitespace
+^Istruct snd_util_memhdr *hdr = hw->memhdr; $

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL(snd_emu10k1_synth_alloc);

ERROR: trailing whitespace
+^Istruct snd_util_memhdr *hdr = emu->memhdr; $

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL(snd_emu10k1_synth_free);

WARNING: Missing a blank line after declarations
+	int first_page, last_page;
+	first_page = blk->first_page;

WARNING: Missing a blank line after declarations
+	char *ptr;
+	if (snd_BUG_ON(page < 0 || page >= emu->max_cache_pages))

ERROR: space prohibited after that '!' (ctx:BxW)
+	if (! ptr) {
 	    ^

ERROR: "(foo*)" should be "(foo *)"
+	return (void*)ptr;

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL(snd_emu10k1_synth_memset);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 sound/pci/emu10k1/memory.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index d29711777161..124497c14fb0 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -18,7 +18,7 @@
 /* page arguments of these two macros are Emu page (4096 bytes), not like
  * aligned pages in others
  */
-#define __set_ptb_entry(emu,page,addr) \
+#define __set_ptb_entry(emu, page, addr) \
 	(((__le32 *)(emu)->ptb_pages.area)[page] = \
 	 cpu_to_le32(((addr) << (emu->address_mode)) | (page)))
 #define __get_ptb_entry(emu, page) \
@@ -34,14 +34,15 @@

 #if PAGE_SIZE == EMUPAGESIZE && !IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
 /* fill PTB entrie(s) corresponding to page with addr */
-#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
+#define set_ptb_entry(emu, page, addr)	__set_ptb_entry(emu, page, addr)
 /* fill PTB entrie(s) corresponding to page with silence pointer */
-#define set_silent_ptb(emu,page)	__set_ptb_entry(emu,page,emu->silent_page.addr)
+#define set_silent_ptb(emu, page)	__set_ptb_entry(emu, page, emu->silent_page.addr)
 #else
 /* fill PTB entries -- we need to fill UNIT_PAGES entries */
 static inline void set_ptb_entry(struct snd_emu10k1 *emu, int page, dma_addr_t addr)
 {
 	int i;
+
 	page *= UNIT_PAGES;
 	for (i = 0; i < UNIT_PAGES; i++, page++) {
 		__set_ptb_entry(emu, page, addr);
@@ -53,6 +54,7 @@ static inline void set_ptb_entry(struct snd_emu10k1 *emu, int page, dma_addr_t a
 static inline void set_silent_ptb(struct snd_emu10k1 *emu, int page)
 {
 	int i;
+
 	page *= UNIT_PAGES;
 	for (i = 0; i < UNIT_PAGES; i++, page++) {
 		/* do not increment ptr */
@@ -69,7 +71,7 @@ static inline void set_silent_ptb(struct snd_emu10k1 *emu, int page)
 static int synth_alloc_pages(struct snd_emu10k1 *hw, struct snd_emu10k1_memblk *blk);
 static int synth_free_pages(struct snd_emu10k1 *hw, struct snd_emu10k1_memblk *blk);

-#define get_emu10k1_memblk(l,member)	list_entry(l, struct snd_emu10k1_memblk, member)
+#define get_emu10k1_memblk(l, member)	list_entry(l, struct snd_emu10k1_memblk, member)


 /* initialize emu10k1 part */
@@ -100,16 +102,16 @@ static int search_empty_map_area(struct snd_emu10k1 *emu, int npages, struct lis
 	struct list_head *candidate = &emu->mapped_link_head;
 	struct list_head *pos;

-	list_for_each (pos, &emu->mapped_link_head) {
+	list_for_each(pos, &emu->mapped_link_head) {
 		struct snd_emu10k1_memblk *blk = get_emu10k1_memblk(pos, mapped_link);
+
 		if (blk->mapped_page < 0)
 			continue;
 		size = blk->mapped_page - page;
 		if (size == npages) {
 			*nextp = pos;
 			return page;
-		}
-		else if (size > max_size) {
+		} else if (size > max_size) {
 			/* we look for the maximum empty hole */
 			max_size = size;
 			candidate = pos;
@@ -209,7 +211,7 @@ search_empty(struct snd_emu10k1 *emu, int size)
 	struct snd_emu10k1_memblk *blk;
 	int page, psize;

-	psize = get_aligned_page(size + PAGE_SIZE -1);
+	psize = get_aligned_page(size + PAGE_SIZE - 1);
 	page = 0;
 	list_for_each(p, &emu->memhdr->block) {
 		blk = get_emu10k1_memblk(p, mem.list);
@@ -292,7 +294,6 @@ int snd_emu10k1_memblk_map(struct snd_emu10k1 *emu, struct snd_emu10k1_memblk *b
 	spin_unlock_irqrestore(&emu->memblk_lock, flags);
 	return err;
 }
-
 EXPORT_SYMBOL(snd_emu10k1_memblk_map);

 /*
@@ -328,11 +329,12 @@ snd_emu10k1_alloc_pages(struct snd_emu10k1 *emu, struct snd_pcm_substream *subst
 	for (page = blk->first_page; page <= blk->last_page; page++, idx++) {
 		unsigned long ofs = idx << PAGE_SHIFT;
 		dma_addr_t addr;
+
 		if (ofs >= runtime->dma_bytes)
 			addr = emu->silent_page.addr;
 		else
 			addr = snd_pcm_sgbuf_get_addr(substream, ofs);
-		if (! is_valid_page(emu, addr)) {
+		if (!is_valid_page(emu, addr)) {
 			dev_err_ratelimited(emu->card->dev,
 				"emu: failure page = %d\n", idx);
 			mutex_unlock(&hdr->block_mutex);
@@ -405,7 +407,7 @@ struct snd_util_memblk *
 snd_emu10k1_synth_alloc(struct snd_emu10k1 *hw, unsigned int size)
 {
 	struct snd_emu10k1_memblk *blk;
-	struct snd_util_memhdr *hdr = hw->memhdr;
+	struct snd_util_memhdr *hdr = hw->memhdr;

 	mutex_lock(&hdr->block_mutex);
 	blk = (struct snd_emu10k1_memblk *)__snd_util_mem_alloc(hdr, size);
@@ -422,7 +424,6 @@ snd_emu10k1_synth_alloc(struct snd_emu10k1 *hw, unsigned int size)
 	mutex_unlock(&hdr->block_mutex);
 	return (struct snd_util_memblk *)blk;
 }
-
 EXPORT_SYMBOL(snd_emu10k1_synth_alloc);

 /*
@@ -431,7 +432,7 @@ EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
 int
 snd_emu10k1_synth_free(struct snd_emu10k1 *emu, struct snd_util_memblk *memblk)
 {
-	struct snd_util_memhdr *hdr = emu->memhdr;
+	struct snd_util_memhdr *hdr = emu->memhdr;
 	struct snd_emu10k1_memblk *blk = (struct snd_emu10k1_memblk *)memblk;
 	unsigned long flags;

@@ -445,7 +446,6 @@ snd_emu10k1_synth_free(struct snd_emu10k1 *emu, struct snd_util_memblk *memblk)
 	mutex_unlock(&hdr->block_mutex);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_emu10k1_synth_free);

 /* check new allocation range */
@@ -456,6 +456,7 @@ static void get_single_page_range(struct snd_util_memhdr *hdr,
 	struct list_head *p;
 	struct snd_emu10k1_memblk *q;
 	int first_page, last_page;
+
 	first_page = blk->first_page;
 	p = blk->mem.list.prev;
 	if (p != &hdr->block) {
@@ -552,16 +553,17 @@ static int synth_free_pages(struct snd_emu10k1 *emu, struct snd_emu10k1_memblk *
 static inline void *offset_ptr(struct snd_emu10k1 *emu, int page, int offset)
 {
 	char *ptr;
+
 	if (snd_BUG_ON(page < 0 || page >= emu->max_cache_pages))
 		return NULL;
 	ptr = emu->page_ptr_table[page];
-	if (! ptr) {
+	if (!ptr) {
 		dev_err(emu->card->dev,
 			"access to NULL ptr: page = %d\n", page);
 		return NULL;
 	}
 	ptr += offset & (PAGE_SIZE - 1);
-	return (void*)ptr;
+	return (void *)ptr;
 }

 /*
@@ -594,7 +596,6 @@ int snd_emu10k1_synth_memset(struct snd_emu10k1 *emu, struct snd_util_memblk *bl
 	} while (offset < end_offset);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_emu10k1_synth_memset);

 // Note that the value is assumed to be suitably repetitive.
@@ -659,5 +660,4 @@ int snd_emu10k1_synth_copy_from_user(struct snd_emu10k1 *emu, struct snd_util_me
 	} while (offset < end_offset);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
--
2.34.1


