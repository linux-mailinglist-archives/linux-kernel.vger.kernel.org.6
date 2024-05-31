Return-Path: <linux-kernel+bounces-196687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E48D5FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2004D1F22AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1115625D;
	Fri, 31 May 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzbVv1BX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A315099E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152526; cv=none; b=qWym2I4lLGfOW4Oi9ODvyREfZyKI8zyDhU+1AyRjzUdKLeRAjkZQjLTRl5aw0NwL1a9s6svjPVb77mEHmvhz+tJuh/f2QY8JwPVZJbokM02DSfR2kExjXaMBIS/+FJSpBSwzk7wK+fP0z7S4Iul4cqEGo5IkBPDoRi+T89zSVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152526; c=relaxed/simple;
	bh=iFzNoWfYENjUWERoqO9hFufYwvSOXLLhQioTSOC0yvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VG9ZKat6HItaH9b0bW/3ctz9Mh8hx2Fta2FzjZQbFJRLK/5Zd6wzgQNp5rrE3kfNnZ3+lsZxxT9q8zVrU9sKjO9duOWhkxszf2WTl/L5Cz73b67GppbazLRpCDoI+H4Ud6ygmyFW3+9Xe0skJuy7TbH3oA9DmT67GgaSv69ozYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzbVv1BX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f62fae8c1aso8189895ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717152525; x=1717757325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmIlqVaF+gTSDu6ZMeuIa1Q/iwiJtQnVlmLiKz7OyH0=;
        b=GzbVv1BXJVZvKfjDdAK63nW/I6h3TtgiZSYVspTGze553ekVbrKEem7JQOk+jDCHjA
         GrBOuwbft3W8h0iu+VI1jVD3SatMa8Gd1PHnlHFEnh/9IAur7B3daIwpXwAsd8+CF6EW
         7GR9TBHVFNNIKWhI/5UzlYCicq+J6JZ5x8QI3BZwyKVJJV/SkzHJDpZY+3Dg3bu2pl7L
         sTa4MpiDVLtnnp9sjQgfeKzMftF2HMk+NayF2zpYccxgzuxr6kfNm1wGgRQ8FKSgpX+9
         73G1wmkjnJL4qfq9EZR/Gc70d3Khhn4gQXJYRyBOI4gEOg52nei/g1ax/W04JxTgmuE5
         X6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152525; x=1717757325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmIlqVaF+gTSDu6ZMeuIa1Q/iwiJtQnVlmLiKz7OyH0=;
        b=iVf2IWeni0d4QwxcShUUv9eXnjJnZJ2Kk2WFm025AVrEsdc2f51TmR7Zs/wNYs81Xf
         m8u4dyqL9hvefdtoIm22NCOC3P4Sz7FqmpU/OpUGmHDUBMOCOXTvKlcSANbH6M+i6pRh
         wRaUdSTOeRjLS5UedbsZzPIwLqVxTAGs8jMo9HGh5ltMCeZ0nOJJOG7ZOsukxv3ymRi1
         RXbdJNzCyBN1lP5m1v990XXmg0Lav+WcSWfv5LeIz+sUYgPYZ3lOsIE0gHDnQfVyEgHd
         8vcAhq1Ptm+1NioRlNPiQnTZHKobGPWjsQHwxv3DuYHBO0PVVlYCTIvEEiAtCVqDeJMZ
         +FFA==
X-Forwarded-Encrypted: i=1; AJvYcCXJkHxUSvkMAScYzFI9N6wm67ieSgDp7SI3VIki6nSaO6cR9Ub44Tv49SzdX1byGGbTps6IQGzp//fqxAklNDDeBGh6AyIrfGwGJmTL
X-Gm-Message-State: AOJu0YzTbX4pTGXs+hFJNYKDbbgsHAYvbGKTyq5yMpOqeTOw5J3VSCcN
	Q/R5MLzGF6QM5Iv06cvOvG1QiBPN9COfJ21QgoMiNAgMYvlvdYNV
X-Google-Smtp-Source: AGHT+IHzA+YBy8vACfHvhDgW1gXqu48sXgE81Qo3VpWgAtv6/Ia4Lvv8nfSpPCCbe44D/soe649FvA==
X-Received: by 2002:a17:902:da85:b0:1f4:bb25:b8c8 with SMTP id d9443c01a7336-1f6370179f6mr15110175ad.27.1717152524557;
        Fri, 31 May 2024 03:48:44 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632355e0asm13533215ad.72.2024.05.31.03.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:48:44 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: david@redhat.com,
	chrisl@kernel.org,
	surenb@google.com,
	kasong@tencent.com,
	minchan@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [RFC PATCH] mm: swap: reuse exclusive folio directly instead of wp page faults
Date: Fri, 31 May 2024 22:48:19 +1200
Message-Id: <20240531104819.140218-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

After swapping out, we perform a swap-in operation. If we first read
and then write, we encounter a major fault in do_swap_page for reading,
along with additional minor faults in do_wp_page for writing. However,
the latter appears to be unnecessary and inefficient. Instead, we can
directly reuse in do_swap_page and completely eliminate the need for
do_wp_page.

This patch achieves that optimization specifically for exclusive folios.
The following microbenchmark demonstrates the significant reduction in
minor faults.

 #define DATA_SIZE (2UL * 1024 * 1024)
 #define PAGE_SIZE (4UL * 1024)

 static void *read_write_data(char *addr)
 {
         char tmp;

         for (int i = 0; i < DATA_SIZE; i += PAGE_SIZE) {
                 tmp = *(volatile char *)(addr + i);
                 *(volatile char *)(addr + i) = tmp;
         }
 }

 int main(int argc, char **argv)
 {
         struct rusage ru;

         char *addr = mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE,
                         MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
         memset(addr, 0x11, DATA_SIZE);

         do {
                 long old_ru_minflt, old_ru_majflt;
                 long new_ru_minflt, new_ru_majflt;

                 madvise(addr, DATA_SIZE, MADV_PAGEOUT);

                 getrusage(RUSAGE_SELF, &ru);
                 old_ru_minflt = ru.ru_minflt;
                 old_ru_majflt = ru.ru_majflt;

                 read_write_data(addr);
                 getrusage(RUSAGE_SELF, &ru);
                 new_ru_minflt = ru.ru_minflt;
                 new_ru_majflt = ru.ru_majflt;

                 printf("minor faults:%ld major faults:%ld\n",
                         new_ru_minflt - old_ru_minflt,
                         new_ru_majflt - old_ru_majflt);
         } while(0);

         return 0;
 }

w/o patch,
/ # ~/a.out
minor faults:512 major faults:512

w/ patch,
/ # ~/a.out
minor faults:0 major faults:512

Minor faults decrease to 0!

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index eef4e482c0c2..e1d2e339958e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4325,9 +4325,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	if (!folio_test_ksm(folio) &&
 	    (exclusive || folio_ref_count(folio) == 1)) {
-		if (vmf->flags & FAULT_FLAG_WRITE) {
-			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
-			vmf->flags &= ~FAULT_FLAG_WRITE;
+		if (vma->vm_flags & VM_WRITE) {
+			pte = pte_mkwrite(pte_mkdirty(pte), vma);
+			if (vmf->flags & FAULT_FLAG_WRITE)
+				vmf->flags &= ~FAULT_FLAG_WRITE;
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-- 
2.34.1


