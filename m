Return-Path: <linux-kernel+bounces-429758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1519E2394
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF80516D62C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369A1F9EAC;
	Tue,  3 Dec 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ssdLS1LP"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7681F759C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239971; cv=none; b=OJQqFFCUaUw0W1xN1sVmXprMTP8tJa88uJBoGLUa3AEuOSHOvxx1lXo8MYVyjgnsc2n0y6NJa+dbyO2KwQo/r3iQ6wHLVTF2aglGgz2XSBfinndb5P9sEhnsPrLAo9Nxv2fZGaLzCHl9VjBmQVYlMu7vRl/EA5N2ZtFLpdEUH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239971; c=relaxed/simple;
	bh=89Ccy3GI5ZUKxFiNR9lyKoxkgOUx6zEEiBrhRigykbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlxJFQM7kLhAZxhYrzLxpjP+a8PBNmYE8ROvVEDkfVMOvzjWXdev8ljl+H7dITkHW9hfw4FaiCEcXHi2xXbJDa6czUwOKDsjgjWB5dOs6RlqwX27TtK0oEnqHzdx+IujJXyjzfeakhw/dtCRDgLJBf9sSLYaRB1GxzAWtFsf/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ssdLS1LP; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ea5e405870so2463532b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239967; x=1733844767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReI+Zr1x7wQ/SlfmJGhzAq3WrMPRqrYdy9B8AN1mepA=;
        b=ssdLS1LPBUHL1S31Q32Y/smkGXM0559dx9pYbkyDBWJ7eY6YZD+xY2uqJAfV12RuVW
         xwtblMjAy2gaeg7xJ3mkFST5v0G+JzIFu+gF7FWes+8Q7MPyarpDkxEWlN68cx39P79p
         qjZbtmWeQiUaON9nakCBeBVepmGECBc+cSpKmS1pPqYlRb+My0DohaccrNIzgMocBMs0
         BERVtEJ35+2veCbgFwsQISDue53j3fIhlrIk9B843TKalWJPW9LaX+5PkTmNnFHdFkKf
         BSbv+W/kFJrSiXxrJY/NJvfPwSfbmL+9mK/81i1/r5v5p7J86z08tUOY9ObHCH7ng6e9
         sroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239967; x=1733844767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReI+Zr1x7wQ/SlfmJGhzAq3WrMPRqrYdy9B8AN1mepA=;
        b=LjjBc2HYgTmS4DxlDgPILGdtwwaKIEXsziXFnGu10yT+fYZwJCeuRMJsFj7/5+cFSc
         NJxxpccFlAC3j1t+V8X93JEgRT5+PUhFrBOLQ0xn78kurGqwHE8aexfCElZ9ZyrHKgE/
         Rz7/E248BXnOByOPB7mHM9PcAod7ocDnZMzYjM8cJeUqbypTVEJIQrdIk4oS72HwDOND
         QOq07TCS0COOHc6WOY6CFOhlXRUB6nZfq5YejUnwYpFbOYsq7H8/+t9PdeZOKr4z0cue
         w9lFaf4THgL4ZzlNVou12frWdWNU7SPljQgolAXJoNoHpwB06VrR3ocBsRMZjntFbeWM
         kj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXGj4Orv6UEazHXok2SJObPJyufGNV3M5NsYhGqHIi/e5inYpWzjUZSY7UEjTxnDMcgu21hXIbb40rBjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9vNHW6XqDZRwlDIDba29H7P8kfIwoT/K5ulmS3A4x3RPgZMN
	HTk/VZEZFpV/d6u0eAGQ2e3a8AZW75oS8tMNs6CMh1lrZHQqvlJ3JxOCOC7LDBNf2qHEqszBe6c
	e
X-Gm-Gg: ASbGncsT2M5dFvsJe3OF6ldqFfBQ7rEN7U2SuyVbrfJjD64pUJbcGij0WuTF1t7yA0C
	fE9zHlpXEOGXhSsyBprCj5gtbRF5LaulckcZe/+1WhnEL2UaV+BiXwdhJ/aY2ott7WVkqVFbtnS
	NxbPzP9kuiYlLPSCWggGShfGBoOGq7rX0agPCO4QGG43xHUiVdKweFUKXP6ljCUHWOOo1Xemi0Z
	QO8JUv/pFPnfH8UbjEjiCOQYe4Yp3OA1UdtU3hq4cWam/6JVO0rVtXDIdE=
X-Google-Smtp-Source: AGHT+IEjGwc7GFJjqyvYWDgJBqgGGBcMfQCEEJJRf9YUZZ1W6BgQFHNlpJWElLeXDmEpw+9XPHnUvQ==
X-Received: by 2002:a05:6808:1406:b0:3e6:1ea5:6b30 with SMTP id 5614622812f47-3eae4f9162amr3792647b6e.24.1733239966815;
        Tue, 03 Dec 2024 07:32:46 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:46 -0800 (PST)
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
Subject: [PATCH 01/12] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Tue,  3 Dec 2024 08:31:37 -0700
Message-ID: <20241203153232.92224-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
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
index 7c76a123ba18..898e992039e8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2459,15 +2459,17 @@ static int filemap_update_page(struct kiocb *iocb,
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
@@ -2486,7 +2488,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
+	index = (iocb->ki_pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2494,7 +2496,8 @@ static int filemap_create_folio(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
+	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
+					folio);
 	if (error)
 		goto error;
 
@@ -2550,9 +2553,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
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


