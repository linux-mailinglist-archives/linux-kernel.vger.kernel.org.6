Return-Path: <linux-kernel+bounces-403250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28889C3321
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32617B20E4D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3060DCF;
	Sun, 10 Nov 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KTl4ld6s"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC934595B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252556; cv=none; b=RACJpveFnl77UQ5n/j1/c7OMCWiDYqf0ta3jxghR548c+F2hhMZsL4mtKBnG6mMjQD9X93QZRDYtUoBKPBlZD9mb+VaS+Sl5znzu4NSxct1UvRAwSgYNPJQTFYZgEB67eHm7VvyGu9/rUrIcojIL0u/Z5MvMuAEVnOht+ZkWWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252556; c=relaxed/simple;
	bh=ZCGFBh3RRNjXY6L8R9jv8JwBpMjmEe8zEwEeTVk4ewI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac407em3ElmMCZeyqjaaYtyIrBkmUfYKhU69N7nCTCnvlE1VCIQKp5M2zkksE7wo6jd1j+6VLwLPqjCuTL5GdoywqxK+gDwtLfbt7aUeSWkW698n6zMxZjp01On9mBhS49C94o37UDawA2ibkycGVinuwIDPw1qP+RrpYMI2B20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KTl4ld6s; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so2713793a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252554; x=1731857354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATQlrsiKbF4ovWTP3SQYfEdawQE8siSIL4Gn+HYptZ0=;
        b=KTl4ld6skRxSUjxGhT1V8ehwnsGKMPL+zhhjRER3/6dCrjKJ/md8tyGXKDg0irkY5Y
         XHzCen6Vqy7NTNVGL3M0RnPhdxZ9sGlA8kB3KXX8Pz+pRXdTpkfZv10ALipRUNipGHo3
         rBX5fqdQLoZz6Q9KEuT9ZtOp3bY+oWqfZrKZeg1x3VGfOm+orvUFnKWuqgkft6XoNS0H
         R3j0lfKERtziifFyeRBvNlzL28fX6o/PwpvzJaQUCwlYsYdxtjohDLWQ7mOPxJRhVplC
         /BZn/wGFrBxnLh3JwzGV+87H5QVpCPphfebHRsoH16ArCTAhcWZtdGE5yfU2PDUEyiHb
         YH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252554; x=1731857354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATQlrsiKbF4ovWTP3SQYfEdawQE8siSIL4Gn+HYptZ0=;
        b=uQhZIv0fDtUWOmZ6NQYmQJRNtAcpqMfkEJc5QJLB2LyOGmKUNWHQSzd+odxlr+a5Fh
         R6CiHxnZEn43XO1wmdtdiOp2fCKMhGGvnDWJtpIXK5jj9co8SN1yzTmxQHNKHIQNgBxr
         PfR3tx++rEOqw3E0vUH6B+UCfHR69D14rSrO/5cshggYjJumxP/JSLLPZWvn58HGqdCn
         nuXVWGiJMPjPtQzUb1QpyuNUHxvkLq6WYsIZbtz4aQnF5Zug1CSWKK6CQtRsVY5sLndK
         6NR2bSstif8fGcyWXrsUTCrInGGyCCPHjTeyG1djjhD6W0zrIE8S3NdXWt83Chcx/4U+
         xMbw==
X-Forwarded-Encrypted: i=1; AJvYcCUiXl+0j9vntyE7YbCBO3oAVvUlFibipfuUU/VX0tXZwj88mOtmYUQDnYO0jwwTVmuIXlxP495xTlWlMh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1h39QNDh/Enoam3Bp+vmPAoqIUnAX4GVZZSu7fqaAN3Ypdk7E
	0o6D8ZxXSjeoF8fYajjduOZmnoR7w764syx5PTKY1RGSG5jK7zZaV8hHmVerYWY=
X-Google-Smtp-Source: AGHT+IHudq5kHes2nSMTtH3m+uxQGkBDk1+1Ad9rVBdouFER/SNEbqW3PARIVnuSTIfSKRPsHGRgYA==
X-Received: by 2002:a17:90b:388d:b0:2e2:b94c:d6a2 with SMTP id 98e67ed59e1d1-2e9b1e13166mr14624611a91.0.1731252554158;
        Sun, 10 Nov 2024 07:29:14 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/15] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Sun, 10 Nov 2024 08:27:53 -0700
Message-ID: <20241110152906.1747545-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than pass in both the file and position directly from the kiocb,
just take a struct kiocb instead. While doing so, move the ki_flags
checking into filemap_create_folio() as well. In preparation for actually
needing the kiocb in the function.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 36d22968be9a..0b187938b999 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2460,15 +2460,17 @@ static int filemap_update_page(struct kiocb *iocb,
 	return error;
 }
 
-static int filemap_create_folio(struct file *file,
-		struct address_space *mapping, loff_t pos,
-		struct folio_batch *fbatch)
+static int filemap_create_folio(struct kiocb *iocb,
+		struct address_space *mapping, struct folio_batch *fbatch)
 {
 	struct folio *folio;
 	int error;
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t index;
 
+	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+		return -EAGAIN;
+
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
@@ -2487,7 +2489,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
+	index = (iocb->ki_pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2495,7 +2497,8 @@ static int filemap_create_folio(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
+	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
+					folio);
 	if (error)
 		goto error;
 
@@ -2551,9 +2554,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
-		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
-			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
+		err = filemap_create_folio(iocb, mapping, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
-- 
2.45.2


