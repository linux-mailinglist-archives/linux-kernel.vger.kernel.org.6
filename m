Return-Path: <linux-kernel+bounces-445114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF46A9F118D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B1E1884953
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8AA1E492D;
	Fri, 13 Dec 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gn/n6u5x"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D61E3791
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105370; cv=none; b=h6/FAafojJRZYerLslEUq0KEi7Gels1PrlhCTUH7nNieUVTFfF7/Yd+5GgCZ/8PVn8CmVw8RwwamKEABtVqF+MUCuuJzBEZZpF46G9pcquABCS40+8XZTF1CeMgbHQo5XCxFMHGPdEb0JBNhFbxYp4zJRx6pd10oAz9hmFg+MOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105370; c=relaxed/simple;
	bh=VkQhoZOrHyZykna0hJTs0oX+MEpAmUB5ySWSsyus/GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU6BI/OYE8Gf2K12zci94HMSqrwcx1KN0eCFAlzywynPe8sgx5P26TCHWKBHTMgHSdNLYKN4JQE9ngZITs1kYMc/Rr/wHOWnNQJ76+fyDxqlILnmm10S0cP3HjW4QdNVRFLM9BKg4C1j/CfuCHNN4J+LMsG3kqNY8iN1f+zN0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gn/n6u5x; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a8f1c97ef1so5750355ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105367; x=1734710167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpcNvbMq6OW5fN6dnGRgZf80nNArt3mFYuYvhVaSlK4=;
        b=gn/n6u5x+8hDMuHR9n/5QfPXMLgtc2zKUHy8C+LfAqaUiOzmGwTZOzXpER2DEDaeCp
         aCAv0YyN8aZKftlj6NdlPXwUmC1l+aa8oYNf+33hv3rMpHWk9kwA503Yt9fZc5iX3jXj
         dQLybLF63c9Dn8jA2HcluDYFbK6zH4FA/7484s0VSlYmd3YMq9pYKVyuYzFMK00haI+4
         y8QHfpiUia/RXDAakqyqO2974gWkFeBOMDHuObf5MJuKoa9/gXHUxOFeVAFCqeySQR8y
         u5rgZrAp3Y9cIkD0chUiE628vi1g/Kqo1BzRRoI3EBGmWvBPOOL6zOQfq4b4RdzMU44S
         6uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105367; x=1734710167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpcNvbMq6OW5fN6dnGRgZf80nNArt3mFYuYvhVaSlK4=;
        b=TCrFXpmwiTOIs5f9HulNOESB4KijAbx+svIXG3Jk1i+ZSJdC4i3F7QldKpKYfQgz7G
         5E5vDdP2c/OEagpHCvwn3kXY/4m29unN+31t1cxZ0UMRJxwGBg33YzAVa1jKGyBnsRfs
         sfT/abllLeGuAU95hMTQGSC5QVbV+Rk1iBjaq8zjAQ1ZchreDKuf8i+meOInLA6VzPwu
         TpJMkAHQTCHrMj0qYsH/5c9kIC50ejMIInvMV37TTmqRZtiDr3CpmU6oO/JoRD8/ZcF2
         ADNoPxth1QS2IBDQG10Uet7EHml0Bz2JaWqQgdq2yV3hscw68QVT3OQK4BULlQneVU9T
         YWSg==
X-Forwarded-Encrypted: i=1; AJvYcCWyQuI51NlxaUunXr/jmrVcU6eE+oTdT2UJCqrTQBJHHrsf/VXi5uFArsKYsyG39mOi5lzBH/aExTlME5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFeoynZovgUFo00Rc6NEPC1L0khl5lKUrCnqQj4ljyShh+toX
	RvW2/q9fmer/f/r1OjvPYTaNbKMHtUkZuGZKgBGsrH8o+o2TdSmBTo0waGU/Hw4=
X-Gm-Gg: ASbGnct0mGYJrS74oqYi1LGqg2sUcLRIWjBeuB7ssWSftQ5/lScJbUEADOqJ/T7Y1ik
	gmIWIGxB+2RLemYjr/aR3k7Tbup8Py2ueFwUUAXN/x10hcig74tj535vSf3s34UDxQXMsc/ykyV
	yIGamsWU2SQEzTJQSA8bkrRL8l6uCxB0byVk7EUbi3j3FvlhMdEbNmJrIaS1q74DfH9EIZB8NJE
	WYCtOBWuXnxLkpxOPMuB69Ojm5pWeVrV89FVqmCcnxd2iotAAjJVzUlQOVo
X-Google-Smtp-Source: AGHT+IFWkhf2olmYWP9+u8WH9KgVfslThGYwEFiU2/KIyOObE8orPa/AadsJR4yt5f2xYXvlvdRoMg==
X-Received: by 2002:a05:6e02:1a07:b0:3a7:e4c7:ad18 with SMTP id e9e14a558f8ab-3aff80107a2mr31899055ab.18.1734105367708;
        Fri, 13 Dec 2024 07:56:07 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] mm/readahead: add folio allocation helper
Date: Fri, 13 Dec 2024 08:55:17 -0700
Message-ID: <20241213155557.105419-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a wrapper around filemap_alloc_folio() for now, but add it in
preparation for modifying the folio based on the 'ractl' being passed
in.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/readahead.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index ea650b8b02fb..8a62ad4106ff 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -188,6 +188,12 @@ static void read_pages(struct readahead_control *rac)
 	BUG_ON(readahead_count(rac));
 }
 
+static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
+				       gfp_t gfp_mask, unsigned int order)
+{
+	return filemap_alloc_folio(gfp_mask, order);
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -265,8 +271,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask,
-					    mapping_min_folio_order(mapping));
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -436,7 +442,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
 	int err;
-	struct folio *folio = filemap_alloc_folio(gfp, order);
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
 
 	if (!folio)
 		return -ENOMEM;
@@ -750,7 +756,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -779,7 +785,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


