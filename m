Return-Path: <linux-kernel+bounces-278572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90AD94B1FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5584A1F22ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE91509A5;
	Wed,  7 Aug 2024 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="J3YTdUMJ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6697145333
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065577; cv=none; b=WMMHA9RA9SUNBDpD9DejIdU/41OcWTHqFlTap0wXxqYOiv7Fz7GPD26b+Ie3SLdSBQTFxQBEY0SqQpys1mhtm9j/F7LqcG819f52dTj4jx3IdeiE6yaxof2gsEJBMkWDmRGQi5mutVnixn8e5jCTvTQH2vCT7pwd3nxipgtHFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065577; c=relaxed/simple;
	bh=8rI7joosp8awa/gMykJMhXumICc/dwUYMwOKiBmRUD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJmqyKxU5WGhuUjnP1ZQfSo5q61+RRDT72ONYNFynztlxPkYny80ZBylPq3r+WAlG2Pn7OX27Dtu63oJl56ywMq+FG7FeKG5sv9SsKR2stUS5q6I9FBn6FB1Kz0QOa0xu9J9xHvFhe2j/rPrE/+/GkISqzfFLExlXA216yRAGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=J3YTdUMJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b78c980981so1922386d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723065575; x=1723670375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3neo5ZpPv5S0nCnjgNJX6IioRmVVyTly9egBg9Jmdk=;
        b=J3YTdUMJRTFmsjr7S5rbRpFaNInTzQMvBSht8An5a3wCk0pM2wU379g/sgeKjQXRpI
         gWa32+dYtcpZixOps1dkq4MBjWTqHojyoMTdN3zsWXRTkZJbZpSBbF83OzKkkNTsSXy/
         +vo602fdToY/yk2BKlsBVjYJTyNrDnWvvIqRuzauPE9jSNRPAT8wmWnpcGKrlPkodqH+
         BRllaH4j1cDwOkkWhYeyj5M0Gr50qDTb/g1PK2B40bPhbYqzZxbQyJ13Id+UJOQyfL9w
         /OyWVV/OCC8mOpeFFUqBaiviVUS39UVG5mipPfxfCoIzHA+2VUMdlhlBpAAqOCAbXf3E
         6v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065575; x=1723670375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3neo5ZpPv5S0nCnjgNJX6IioRmVVyTly9egBg9Jmdk=;
        b=kjKql/e101Qpxv1Hx07FTf3B4vRkhaxJb3AJq+DJxuctsuOWcI05n0lhwkv2ak9i17
         i33T/iFSnn8iqQCgeqk0oHxVqX272Ur6Dpk9OfSM0cuI9TmYKhqgWk+EEwtDvvDjrQma
         4k3o2Uk1mgVTYHTWvklF85trdB8wuO0H/FYTSJ5fetBCBEGZMYdBCOQ9vbNxlUFVNs4Z
         mi4Yffc2jRZt63d0sK8yhCR5HooPn4BkmjgZ30c63I+PkyHIWM9izCg8BYShF+KWaIII
         z/WJj9mA3ZNa1Afd1ZfALbcHn4NnjJetN7UXY9nWaV/BD9y8kYgOGWDmf8fScLpZ06t6
         pMLg==
X-Forwarded-Encrypted: i=1; AJvYcCVqyLQ/AcCr+AMMo9x6GIL+IN9c/sfhBuhX9jd2LbZ54ykQXZcXopQPeqlQPmv4+QfHIxVjroVQfD7ag34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLne8gFfoLp37ZWVP7AUOlOiypXyfN/mg1NywR64yvGxKQRQU
	UiR7s8rhJGWOCkL+bs/46LTkrhYC5Lue9bcxjovnqHUhmLx4MYdBHZpLj37XXrc=
X-Google-Smtp-Source: AGHT+IGDB+qjFAN0Pa9M7zx0IpSPlf2wphfmg2Ue+Ixo5QIdxXn96CHrQxZdzF26s9y/IaiPsW7CsQ==
X-Received: by 2002:a05:6214:5883:b0:6b5:49c9:ed4d with SMTP id 6a1803df08f44-6bb983d79a1mr247222576d6.32.1723065574748;
        Wed, 07 Aug 2024 14:19:34 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839ee1sm59976976d6.89.2024.08.07.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:19:33 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org
Subject: [PATCH v2 2/3] mm: don't account memmap on failure
Date: Wed,  7 Aug 2024 21:19:28 +0000
Message-ID: <20240807211929.3433304-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When in alloc_vmemmap_page_list() memmap is failed to allocate, do
not account, the memory is going to be release at the function exit.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/hugetlb_vmemmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fa83a7b38199..70027869d844 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 
 	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page) {
-			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
+		if (!page)
 			goto out;
-		}
 		list_add(&page->lru, list);
 	}
-
 	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
 
 	return 0;
-- 
2.46.0.76.ge559c4bf1a-goog


