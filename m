Return-Path: <linux-kernel+bounces-283656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32394F774
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38B8B216A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86E21917C9;
	Mon, 12 Aug 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JurFBh+w"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872EC18F2F6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490675; cv=none; b=Tv8IazMHghpTA535G1wErNWNIjDXcbaJKUjqjSSP1URq7w+knRcWs+3VN8Q3vmX6QfG2KrtoJtSw80AFdk1OArvueQBLe2PVnRPuqkJ5iOCDpC7bXuMFMdfzHYjVksOwgDRhFQMhUZ5gA8q9yiIQMDg0a/gay2Ue7RhRvkVgE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490675; c=relaxed/simple;
	bh=NzKwuJoXzmUGF5iSUml9uWF6iwC3BNkDZKU4aU6MD3s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KsPTwQ8cNVPbWNPRVbuA2SriuKFKbMcrniJ1a1HzY6Ke6D7ZVLmT4OX9uYTsyVS4yjYBbYqgvIKNGcdWADmRuQieX8f7AoFKYU1SG+RafDyzPh8zZgT0FxN2f0bXSR/fF5mGaPbGgWwZE9NQ+U1AItUblBzdvW8oskOOMENLsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JurFBh+w; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0bcd04741fso8099752276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723490672; x=1724095472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWxCowPUnixbfZzlA8QQGBp8dYSP6RfE8f5Q6sz/520=;
        b=JurFBh+wbtn5uStA7F1sQpTuIri8L1hxWBkk2z30CbjwQOBaGRwbkZ6swnD0kX+YX0
         b3u81bz47UtvnQobhCeLQIEX/qrGpo0HH4wUCX23sOOq20pSsLuN3zwWsVluV2BLn8X4
         3b3Umh2ZMtbaES9GzyTirmO6blEw6utV7NlUrj2SFlZf3FJNPsyY54x1Pt4JEdrbZlYA
         WMQGQ6Z/yKraq0urcVxCQsU93fjnPqfHBR4GSBP2TlBY+A0ICOMHJYxgqq/Y4c1vZOXm
         PjZNvqibj0+zsSq5kzakTEy95V1IQEzWawJraFggvhjJCTJ/wt0h2vStzOAct+L9RMrj
         xzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723490672; x=1724095472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWxCowPUnixbfZzlA8QQGBp8dYSP6RfE8f5Q6sz/520=;
        b=YIvlbd/kvDBeWI4m4XR+GnG2QMOMyDf3c78JgR48+In1geFizIR/EGT14muQ3nZVAv
         cmedruT0tWyWPQPBc5VF0P3AhlQQX/b+FBzjWPAO5eFpgYStZt9rfSzIgpJ3B7eSEIz4
         ouYWjZeOIuc/W1cl46A+kvBvOW0JLoS4ZiwU/WLTffgOYUss6tUxbvqExKf6vua9Ko3k
         6s9mLvS6RjshnSudsQnsIRBqvKZr4OfsUAlyOo3NEiyGtnTrbl0zUcbCoJihoQ8fiXkE
         AdnaRDLlwwfsrXXZNYbTHyQLQLobMpgovfnyLCfjZBWDF7CnJ2D8VvSSVxPK9kP5y0qN
         dtTw==
X-Forwarded-Encrypted: i=1; AJvYcCUK6yhtOgK1dcIlVPu6AIoxrXqlugvXh4Ctzke0rZ/1eFJKuw+vhJ7DAy4S9CsTzVpO/IJPtXiCsn+bKWal9flDUqlg83YY261BqJB3
X-Gm-Message-State: AOJu0YwmzhNnkucu6JyypACPpl9SUmVE66Zz4V823QgsZevKLejoDqvr
	PXMBl3x9Yz2wwQV1w/Ojz8K7ctE7Cerkq5aS3veKWk0EVIZMLkTLyaS24Xox6MrwmkTfNKr78xw
	okw==
X-Google-Smtp-Source: AGHT+IHKisNvsfNZ3HwptFVUwpuAndJrP1cg0JwL0YzNRZLFI3LjSNR5DwFlUuA9GavrzBxidgbOnP1w9Ro=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3912:1e97:a514:421a])
 (user=surenb job=sendgmr) by 2002:a25:bc06:0:b0:dfb:1c1c:abf9 with SMTP id
 3f1490d57ef6-e113cd5ee6fmr74667276.2.1723490672597; Mon, 12 Aug 2024 12:24:32
 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:24:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812192428.151825-1-surenb@google.com>
Subject: [PATCH v2 1/1] alloc_tag: mark pages reserved during CMA activation
 as not tagged
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During CMA activation, pages in CMA area are prepared and then freed
without being allocated. This triggers warnings when memory allocation
debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
by marking these pages not tagged before freeing them.

Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages as empty")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10
---
changes since v1 [1]
- Added Fixes tag
- CC'ed stable

[1] https://lore.kernel.org/all/20240812184455.86580-1-surenb@google.com/

 mm/mm_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..ec9324653ad9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct page *page)
 
 	set_pageblock_migratetype(page, MIGRATE_CMA);
 	set_page_refcounted(page);
+
+	/* pages were reserved and not allocated */
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
 	__free_pages(page, pageblock_order);
 
 	adjust_managed_page_count(page, pageblock_nr_pages);

base-commit: d74da846046aeec9333e802f5918bd3261fb5509
-- 
2.46.0.76.ge559c4bf1a-goog


