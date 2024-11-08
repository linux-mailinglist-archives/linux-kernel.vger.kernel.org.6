Return-Path: <linux-kernel+bounces-402130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40859C2449
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E041F27563
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928321E137;
	Fri,  8 Nov 2024 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2d6wZF+g"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86421C185
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087923; cv=none; b=Kt8kS8KaZV1JUdkN9hml2HSbgEbPk/zWWXsluVq98DOZk0Z+Y5mvcPURP0FIjtM8to1KEUnIBfsE+W+BakIF+3fSLymh6SGVkZOcEpq3lxplpW4d5MwYyPI+TS4wvZ34V7Y55xTTcL7K1c5xfHk9pS8i5dPigIaYfo7bndxk8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087923; c=relaxed/simple;
	bh=xOX9JdqoIpgVbWfGU7LRI5hAxDmBYLlvRERjrD8i98I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHiul4bfZbc1WaZx7kQ75HFoMCjnQRsZ1TppVf75guZEtlb9JUGnbZrlEFGqkeOM6YbZQgJ9pn672AH3pdrSxGasBJmoyUeKCvMS+uZPzSP4GwMg3tqyplaR7xHFHUYmFNvIHvdlCQDUQQFs3BTflOw6CL5jHsblgnjY2HOt/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2d6wZF+g; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e6105886dfso1775844b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087921; x=1731692721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9RgbH65zDtdD1C8SyJhiChYXVIUYPb7qWGKr+fnitI=;
        b=2d6wZF+gDH2+unDxPCQtkbtrhYq7FFY3TsMTQYHah6hwQUTgbnKNlzIo7vccH5NLG8
         ZkjTFyIWdk3mmKa7jrk7zTomxqdVqby2wQqT8jlDjIpE/Sk7XEkrgPfJrxlxLLctj0Kp
         mdIkFtbC8noeUYLYvzTyyLl1NDk2JPE+q1/oo9VVOqRGIh6rc/yq9E4lpCcqtradNhFe
         z4S87HXy+OQLgU7nu4Wf3XBZkVWWTuII7t8MfEiF+BpPb0S3zLqsF3AH+9m8RWm3Ip14
         ZL34TRNDjiVOY1VuRJZa4OEvrbUPmpO5Od3mLd1OlX7+tD51eOaCaqjfCvcgPiMxi82I
         jg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087921; x=1731692721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9RgbH65zDtdD1C8SyJhiChYXVIUYPb7qWGKr+fnitI=;
        b=kuI6gbaY/iz+F1er69ceG+lxDpuzedJml9iUWV4EjojGjNqjpGaZLnwFIiI3RQqMi+
         OpW7DtpR8c6EMQi4b1qmSzW16Lq3JxXSnkdDttNdZSXpIxwW5W/5S1Nma0wB343x6CsK
         t8TgzGmQuGHociGjiBBSQEgNMGK6dbPvCPJ86o/tyOwE6oVd9qzU59L+PDRpgaHoqb+s
         lnypI4pEhTjHO6fUfw8P2DuS/4hvNrmBfX131idtt0VB7ME4C13VvDZddt2nRDduHtni
         zh9b9jrQ96tmAd8EckWpZSf6W2xwYN8i9f7zwo1Im+SFf3gkgiUdviriYDXN2Tho2aKp
         iXdw==
X-Forwarded-Encrypted: i=1; AJvYcCUC45wwypcSi4/bCSa1kkI9+4NCWe2FCyphI5T7nUN9kGgDI6ZK1kaBwygk4kVYB/59O2AROWlC7MIvDjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzDHw/mANoEz9lbHSUC2o+oQCD1mrICg6Bx7pqjTe0GmnwpJk
	ToM7wMxVGlnB+tKahFase+q8h13bPDwpTqlm9JlLmhxUjLLQMh3QUTwqaEJ+y1I=
X-Google-Smtp-Source: AGHT+IEdm8GyqJXGR6xkfsMSAWw5HHFtOAoa8M2cW5v0Mo0ooZH016xwV9QTHy9Q50Vx5kixVOJjvw==
X-Received: by 2002:a05:6808:1391:b0:3dc:1afd:6688 with SMTP id 5614622812f47-3e793f74377mr2161727b6e.20.1731087920676;
        Fri, 08 Nov 2024 09:45:20 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/13] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Fri,  8 Nov 2024 10:43:28 -0700
Message-ID: <20241108174505.1214230-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2ae26a0f961b..7f8d13f06c04 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2525,7 +2525,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2540,12 +2539,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


