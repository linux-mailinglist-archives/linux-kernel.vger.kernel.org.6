Return-Path: <linux-kernel+bounces-403263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE09C333B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB931C204F7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E7170A2E;
	Sun, 10 Nov 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OI/Ky1or"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00515DBBA
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252574; cv=none; b=DRXH3ZVmYnWGgvU7kFGaEckf0yH59hSLWySraKVTHRNfxwK21ceUWtkex5Z7fg8y20x+aRAF5gxRG1ILNNyLeFCFJAdbVU5ansuz3nf4vqif77jMdK3cG1g6BXkGVUvmZJPnzQn7nRVOcsE8sbq5sBNEAOlmDdAJm082axty7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252574; c=relaxed/simple;
	bh=3H9STUASulXCHklYsN+md87lfFFsAKUuDScGACrWthk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCFnR60y2WEKAUUdrPqqHhb3jo0biFDZfZgQe70AqdFjs6KM4u29fcAIlavGCbN27gR1B4i6KsSIBvFg250mWGLgaMDCYYRPxQi12bbp+CRxkUZYRFJTT/6+da+hqrvVvJXZMTAmFl3pcFjio7N2UcGw6uL1OfNRx6WDnhiVqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OI/Ky1or; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c77459558so34302035ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252572; x=1731857372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHHnA1NsQjr1van9cnJ+PQRWRXhY+a6ETIPA3kXFfjk=;
        b=OI/Ky1orJg/GBr9s+FgVuIuEalVhEHGaXMQuHn25NW3gIZ/Ttc5S3RVPzHrSyU1a45
         8/H0FAdjTx8OKHd5zHDluKqXO/cxBAALgmb3ngFG1S8q0graYRHyAmyWEt3Lx54pNApI
         L+XinvPTxzVdMyVeTKk6LIjENaoxTWyyzkf8hIPn/zIM+UH83uvkWvkgZ0AXzGwy6DYf
         XTGRA1vNNwlqd9zamy/7e5Fmyl39evdcvNE817XPskBp+vQPfxQo7uI71i5KOhOWuTkp
         a8y6r8F3Y2HpuICeeC2zA9uWMN9Pr4vEMBvhy4KV/8mVrR5mvaPWkvQUcNKb2OvPwg8E
         QmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252572; x=1731857372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHHnA1NsQjr1van9cnJ+PQRWRXhY+a6ETIPA3kXFfjk=;
        b=KD+K3+WXybowbdboXCddSwr3OK3CySFAkceGWGnYW9GcVZcSEEoee5UFlLl/U4d7M+
         KvCcFaDmcaxuyW7KO9zLMGXE0W16nSHR2ppn540HD65CkXug8iswor5CoRFhplmNJkRD
         caxFy+2x1It+a31+jXoAutDXlngBJxIXbLHJwlS8ECylBsECMwOmv2UXj+uRu2xYSLNf
         uBRIwY/XLEDALyVW/lcneUmgQd99ixXCpmJZL0p572IjVYuh/Qah/tEiz0fii3SHZ84C
         DlgAIKHR1pYiHfWTML4td/1cBq6PW9f6EbtmTKcam+eXQ0UXtUupAz54cvh6zNqM9Muk
         QKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUBjrCJjx/z+TnUqy/zlI5LqwkKJxKqz0TDix88gRsVDy1L6pDhaIxa57SGX8WdJ8EJYRrU+gm1g0PcSr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsZ4zFN4RyPWtfWkWftcOw7KKaH375ALK5iUkzgw2uT3G0g8f
	ghZE8QUdrKpbwLm+8lljrfHMjE3J0e5YXABFoAsJzNNcq5YOwbnKR5SrtEPyhBLV0CVQUCE1yQ/
	wt8I=
X-Google-Smtp-Source: AGHT+IHV0wAiD3bQchKcabbTvXh2pU9AbMQUOshna304t+XB0bKs6GgV7ufQgRJwzKJwVoPNWeBA0A==
X-Received: by 2002:a17:90a:e7c1:b0:2da:9115:15ce with SMTP id 98e67ed59e1d1-2e9b1682714mr12810753a91.15.1731252572603;
        Sun, 10 Nov 2024 07:29:32 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/15] iomap: make buffered writes work with RWF_UNCACHED
Date: Sun, 10 Nov 2024 08:28:05 -0700
Message-ID: <20241110152906.1747545-14-axboe@kernel.dk>
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

Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
set for a write, mark the folios being written with drop_writeback. Then
writeback completion will drop the pages. The write_iter handler simply
kicks off writeback for the pages, and writeback completion will take
care of the rest.

This still needs the user of the iomap buffered write helpers to call
iocb_uncached_write() upon successful issue of the writes.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/buffered-io.c | 15 +++++++++++++--
 include/linux/iomap.h  |  4 +++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb6..2f2a5db04a68 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -603,6 +603,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
+	if (iter->flags & IOMAP_UNCACHED)
+		fgp |= FGP_UNCACHED;
 	fgp |= fgf_set_order(len);
 
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
@@ -1023,8 +1025,9 @@ ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		const struct iomap_ops *ops, void *private)
 {
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct iomap_iter iter = {
-		.inode		= iocb->ki_filp->f_mapping->host,
+		.inode		= mapping->host,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(i),
 		.flags		= IOMAP_WRITE,
@@ -1034,9 +1037,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		iter.flags |= IOMAP_UNCACHED;
 
-	while ((ret = iomap_iter(&iter, ops)) > 0)
+	while ((ret = iomap_iter(&iter, ops)) > 0) {
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			iter.iomap.flags |= IOMAP_F_UNCACHED;
 		iter.processed = iomap_write_iter(&iter, i);
+	}
 
 	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
@@ -1770,6 +1778,9 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	size_t poff = offset_in_folio(folio, pos);
 	int error;
 
+	if (folio_test_uncached(folio))
+		wpc->iomap.flags |= IOMAP_F_UNCACHED;
+
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
 new_ioend:
 		error = iomap_submit_ioend(wpc, 0);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f61407e3b121..2efc72df19a2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -64,6 +64,7 @@ struct vm_fault;
 #define IOMAP_F_BUFFER_HEAD	0
 #endif /* CONFIG_BUFFER_HEAD */
 #define IOMAP_F_XATTR		(1U << 5)
+#define IOMAP_F_UNCACHED	(1U << 6)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -173,8 +174,9 @@ struct iomap_folio_ops {
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
 #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
 #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
+#define IOMAP_UNCACHED		(1 << 8) /* uncached IO */
 #ifdef CONFIG_FS_DAX
-#define IOMAP_DAX		(1 << 8) /* DAX mapping */
+#define IOMAP_DAX		(1 << 9) /* DAX mapping */
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-- 
2.45.2


