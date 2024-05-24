Return-Path: <linux-kernel+bounces-188264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5368CDFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B293B1C2218F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3B3A8E4;
	Fri, 24 May 2024 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhOuXtqI"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00427BA42
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521909; cv=none; b=lbzBKEeHfYqXr+ax3iFz6uOwYSvZMFfC+FM/cjNf+/tuDEDO3KdmA7pePcxgdhRrxC+dQdnIcQFfXHFyUAjfj4DLk96ZXqHmpW/USTEKe9kDnW+1RnCou/i7Hvr6IB1qOBV4kVAcsglY5vsg1t100jzRX+GP/LGT1x7OijcwQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521909; c=relaxed/simple;
	bh=cAL6u5NSV/FtIQTkgLiXildPvmom+465OK2uCEULmo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aMsJxb6N0imvSho0/QFJnECp1tdzPmEp5BEyFI+GavVIvygBts+9ERmEIe/SaziQEv7hq8bfdus/vP3pNiZJ3lCocg7shRD2tHQdD5mUCq/sviNVFH3Si2cFKRkmGUTAoVrym8XsFInRRjz0ldu9KGwXxeD4SYleDZltIpvc0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhOuXtqI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df777ba71e2so157356276.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716521907; x=1717126707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rjLaqux6n3a7+R/7FlUB+W5AeNaAqDsKuPO95aKmjo=;
        b=qhOuXtqIkXv1Ey0OCLcje7kk97gRZn/yRyrI3GmUoq7mbOYhF6m3UjFPNwaL2Ipl0P
         7OUJ1bNuWpMzwsV0MG6fLgcSmBeuTNM+BFtaKiqAkxK+48up+XOquQPyZFK0VJTbWn1Y
         xFTU7Z6yeMdIvx8iLMbLvnO3zJEJJmw2wV5rDh5DIlvVByNqCW00mDna2seYCFzzNyhH
         frmPMHqPrL0zjjOP99x9Fpy9qHE5nKqQ21fUhdtzhrTA1+IESpOdNQY24Y72CWNkJ0sr
         JEKL48E9OGdp84fNDJk5CCh/46jS8kJVa0g7Cy2TFflOMOZxl0F4Ts+tpETfi1KY5za/
         WDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521907; x=1717126707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rjLaqux6n3a7+R/7FlUB+W5AeNaAqDsKuPO95aKmjo=;
        b=s7uEo81pHqLakpSDnHj7LG5VYrTbF5hPt3St2ZHdnK4jM+Stco39matzBAKo5+h4og
         eOY5Lug6LNbpkd+W6I9wOOkYCZ3/T/sBnQi5R8bpj4rhjiUhvVAvAuEHtc0qbqolPkWv
         J4ULdl79znbeQiUY/B9rdPRbtGWf2a9tVCxC+VfCWNxNcE5EvsdiOIz30+X+X1W/47WN
         BH9r/k7cTWOqvbd9hYCdjheGRoYzCbWOw4usjqBk0ACDbqNMsZOkm+W3BtnAtHqwb1/V
         jBgbdqAYoujhw6K20JtQ2rp8uDhPGRj+tkLWnqCmQrckUkUBfRQYxoxT7lZlpILHdp4D
         lPGg==
X-Forwarded-Encrypted: i=1; AJvYcCWcxIwdLoeHhfSb4Ob+rDhuWAgG+Ck9mqGYG3jDdrChkt6Q6phKQUj0/pzLLBUews3B5C//ixxchZQ+5ztm9NVvwL7ka6Rl/lI/c9XK
X-Gm-Message-State: AOJu0YxXo2F92GA2ImsvQ0TsPv1m9PaP0dWNrfl4E2a2hT6p96AfUJyZ
	tKRSI0sQstUgUXVjqjB8fNBTcYee0vA8G9ozVEXNofj6GJIGPa0I+PHLk/uA+t4H5wFl8F7Heh8
	tFo2rnpPiAgx1ntqpuQ==
X-Google-Smtp-Source: AGHT+IFjyBiedP4yQeSnv9T+OmD26CtUHgQCt5FkCWaEvXFDvir0hBHjpfuYbfRsKpcdcsuSG+tax+f1009tpb2V
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2b03:b0:de4:5ce2:7d2 with SMTP
 id 3f1490d57ef6-df7721dc43cmr300341276.4.1716521907001; Thu, 23 May 2024
 20:38:27 -0700 (PDT)
Date: Fri, 24 May 2024 03:38:18 +0000
In-Reply-To: <20240524033819.1953587-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524033819.1953587-4-yosryahmed@google.com>
Subject: [PATCH 3/3] mm: zswap: make same_filled functions folio-friendly
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

A variable name 'page' is used in zswap_is_folio_same_filled() and
zswap_fill_page() to point at the kmapped data in a folio. Use 'data'
instead to avoid confusion and stop it from showing up when searching
for 'page' references in mm/zswap.c.

While we are at it, move the kmap/kunmap calls into zswap_fill_page(),
make it take in a folio, and rename it to zswap_fill_folio().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index bac66991fb14e..b9b35ef86d9be 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1375,35 +1375,35 @@ static void shrink_worker(struct work_struct *w)
 **********************************/
 static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
 {
-	unsigned long *page;
+	unsigned long *data;
 	unsigned long val;
-	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
+	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
 	bool ret = false;
 
-	page = kmap_local_folio(folio, 0);
-	val = page[0];
+	data = kmap_local_folio(folio, 0);
+	val = data[0];
 
-	if (val != page[last_pos])
+	if (val != data[last_pos])
 		goto out;
 
 	for (pos = 1; pos < last_pos; pos++) {
-		if (val != page[pos])
+		if (val != data[pos])
 			goto out;
 	}
 
 	*value = val;
 	ret = true;
 out:
-	kunmap_local(page);
+	kunmap_local(data);
 	return ret;
 }
 
-static void zswap_fill_page(void *ptr, unsigned long value)
+static void zswap_fill_folio(struct folio *folio, unsigned long value)
 {
-	unsigned long *page;
+	unsigned long *data = kmap_local_folio(folio, 0);
 
-	page = (unsigned long *)ptr;
-	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
+	memset_l(data, value, PAGE_SIZE / sizeof(unsigned long));
+	kunmap_local(data);
 }
 
 /*********************************
@@ -1554,7 +1554,6 @@ bool zswap_load(struct folio *folio)
 	bool swapcache = folio_test_swapcache(folio);
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
-	u8 *dst;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
@@ -1580,11 +1579,8 @@ bool zswap_load(struct folio *folio)
 
 	if (entry->length)
 		zswap_decompress(entry, folio);
-	else {
-		dst = kmap_local_folio(folio, 0);
-		zswap_fill_page(dst, entry->value);
-		kunmap_local(dst);
-	}
+	else
+		zswap_fill_folio(folio, entry->value);
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
-- 
2.45.1.288.g0e0cd299f1-goog


