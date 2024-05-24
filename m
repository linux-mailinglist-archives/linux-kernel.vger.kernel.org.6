Return-Path: <linux-kernel+bounces-188263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A273F8CDFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04241B22B57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADF39FCF;
	Fri, 24 May 2024 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9BAqkn5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97D381CC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521907; cv=none; b=bRWbb94Cm1q50iCXfUhXEp3lrX+Xu9K4C/sWRq0+5O5zq6sT8NaZ1R4HiK37WjzBaO0bL4VNj2GjNSNxgTyM18p8rjuM4S5LkL8OJxmLwZ12ZJbAtahqzI8nPqrhaYjZkEFTPRxzIgmtYE14SL24otMmwACwyna7n8x5n1Y8JBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521907; c=relaxed/simple;
	bh=GLHO6RNbu0GScfehY3tMB/FBcRZ0DPXV3eJrP/UTMO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b2AtALA+h/8pajyoSN4m5Mc3ps6zkAjANz4vHLBmbDaR4VbABZYfThinFyVmH05pO2DMwxo2RxvxIo24dmub6LgeA2fSYwekIs01VZtPKFKKkyLefRlk+U2aIg2LJTAuR/c2Tr0mRUzr9Sk39CQswPnupobgfvVguxwqEDQEpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9BAqkn5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a0825e365so8958577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716521905; x=1717126705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZUibxVL0p5mU+STizIl+rgA3qpvNVqFQOc0JP+qiMU=;
        b=b9BAqkn5o4yhTfBmHi99TOHY6ETZ5rELGghf7BO4hJ1nQU79O12tMkKqKQTJEKyNX0
         44YibSFxlNsa3wETeIozzwOf9lyA3pJiNVTdo4XOx59Kb1z0L1WuAhdEKlGKn79UlJEZ
         tMrRol/DRdH0T6TScKO/0WZH+ANZd13SYlrPQl6AMnVy+5M4Wxkdiuu0Jw3jJkZG/P7F
         lZUkDCV7FS8PydsuI/yAH3V7CAlbrSO25o9cLw5XrcTzzq25iWCwlOTha4lP5J5GvQQa
         XRc3Sed09dhsUnPOr6QNnP/q6duVoiVcpOdra6319nYz2v0hf2dJq+pMRIBw2tYLWEb9
         Bhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521905; x=1717126705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZUibxVL0p5mU+STizIl+rgA3qpvNVqFQOc0JP+qiMU=;
        b=tjEHHug3SAd6NLylySr5kmjDW+uGuKJNufBwFQEuV0b6SNq/2oYrDFEuHclkJdR4Yl
         +28XVMWUJ90deIOkEh+l8FkqM4s7IIfWgEIEVz5mQ9B86tZcbvAJ0jfFOnkUGQG5TzpP
         fnPVS3fVcD2hRsUTbLg/owWskc/TVbc30ihLD32ZYlYs30fNRC0+m1QvTC8Sqm5qSmhb
         cN/JGafSd04Uwz5I5MO7cUu6z99S8GxFZ51lzRqiMOoYhvp9ZPZ4+hAJ+lVeIdPaRotV
         WeLBjJw3L+CLEKVkatUr7sGO2jLk9ge7f66JWpBBmQkXvfdvs4Ev495St8lt5HrbN3Wn
         m/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9jE0ZQ/2Tgac9HcaiNMkK6duIE/D/VlO5Y9HUean3VPsWNhqtJWu7uSBUo3DYfP/7h850WV+x67FnMLwA45WWufRRrVyLuo0eTGTM
X-Gm-Message-State: AOJu0YxyEK9vePwhh5WUmiK0QmIBMNtihHhDV4OgcPgVjuB/ZR4MWfhz
	44qC79RccV493sgAQPG/JXWcZFWPhzatY31I2dWZVJgn8wbrNd36P8ZWDCzNmxqp+OPL4dk1v3E
	X5sUWfb0LBW6zpJ302w==
X-Google-Smtp-Source: AGHT+IGWEmQAlnhdEPzZ6uPO7aNv6DYve/yJL32x0ERZjFBY1Aa9d8TiVJtvgVdN3KsvGrSvISEQ8eqaozyd47PG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:368d:b0:61b:ebab:ce9b with
 SMTP id 00721157ae682-62a08e60886mr2541307b3.3.1716521905191; Thu, 23 May
 2024 20:38:25 -0700 (PDT)
Date: Fri, 24 May 2024 03:38:17 +0000
In-Reply-To: <20240524033819.1953587-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524033819.1953587-3-yosryahmed@google.com>
Subject: [PATCH 2/3] mm :zswap: use kmap_local_folio() in zswap_load()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Eliminate the last explicit 'struct page' reference in mm/zswap.c.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3693df96c81fe..bac66991fb14e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1551,7 +1551,6 @@ bool zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
-	struct page *page = &folio->page;
 	bool swapcache = folio_test_swapcache(folio);
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
@@ -1582,7 +1581,7 @@ bool zswap_load(struct folio *folio)
 	if (entry->length)
 		zswap_decompress(entry, folio);
 	else {
-		dst = kmap_local_page(page);
+		dst = kmap_local_folio(folio, 0);
 		zswap_fill_page(dst, entry->value);
 		kunmap_local(dst);
 	}
-- 
2.45.1.288.g0e0cd299f1-goog


