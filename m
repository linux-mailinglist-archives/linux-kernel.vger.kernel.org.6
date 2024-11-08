Return-Path: <linux-kernel+bounces-402136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085E49C2454
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B07E1C26B69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0802220D5B;
	Fri,  8 Nov 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K0Cxxqlk"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6C21FD9D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087931; cv=none; b=pnnZf8R3WfJ66TY0SxvD4IvNaFqneJ1OfTNOpZ431hcxUj3bPFgtZKdleIwxbe+85CIwI0gmxeHQoY5k3XETAWBFSA3hZn+UvGODrB3ybyQTEE4bhdlkxeZZaxcTR2q3ZanZrtP77Pn57Q6aJ/1hkEIE6UYQI2seY9Mi34M/8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087931; c=relaxed/simple;
	bh=9YW/2+OE7C3cVBnbovwG8Js+i3sqJ6a5WevlH1jOhvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJddOyjl401ZPVVgNgWY7ViAKxtJtb8GTOfihhBSK5Kry4/QCypQuw42/CpYVsCb6ehGEATfCN6u1n+BD7fxyIOSSDJd81lLic9Ax224nwuh7xXYuyGIRTuvPaP8BuXmM1mkmHxiZ7Rs230mxDf7J2d1vYdz/y6IKogSVzty8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K0Cxxqlk; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e607556c83so1581660b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087929; x=1731692729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fb9FZGyCFOFnaRiTxheAGhz9Js7yp85PwlVOXqpxuQ=;
        b=K0Cxxqlkqk+ExzN/m+CBwq2f7WR6hgN3h0jjnCXdk4QtblpXFkvnxFZU/lDZfx3z2S
         nxAshhOmbsLR7RK+VOHk6Nv8DP0y5JXxgmKaVT/wCnozFIgxSQurATQg7WxnM9AK+Fl4
         JVKbImvJmKpOM6zm65mlXIXSLxky8djd+RMKEYTEEtmUUU5+JHAbPwXoW3UiKcsccFxx
         Yjhcg27E77gnsp+ytbc1yDPivqatcWu5YE2qiQ9IVVWiKI9SbiTOnl3OuVEaETJsfTSm
         E8No3ckE74dUom4T/k0MQYJ7/p2iUTa2YPL9UblsYNAUoXaunRf+a+KfwuUjJ6a9kWNo
         A3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087929; x=1731692729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fb9FZGyCFOFnaRiTxheAGhz9Js7yp85PwlVOXqpxuQ=;
        b=M/AN8DCZCMQtN2UhgZYTJ350/k+jURM4ErwUT9QMa4MX5l/PwS7JknpU1z6yIg8u4D
         RwOg+ablE+HeVK5UYdOfrezQqwDlpCMa5wQ4D02fyRgRCvhTZ7KyaMPOtoxn8pJEfDVl
         8DHuafo8VQ0PPFFcqLw8k0J1pxCF8ZNxZv7LD/FF6PpbuGbKZeE2mEkjGkwUZ/BNqN2O
         btMwn21mL5FBn4/+18bn9jpO6DaRbzDy9oYZ9uyxZDIbXJbFLgNrad8dcsSZ4mM4Iw9L
         0OHTvrbyFfqmTuaxASDWzXape7jN9pMFW1Q4kYzbxmmB6UPaofRCnj510d7PEQ4Zuwvr
         YVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwOZUu8mx4krBstWfI7omQoAUKif85TY6ovbwdYb/pvMuNlQogPFOB/U0cwZv9UP4b2EXj1l/H76Xr1Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNRt9yT/c7u0yZ7SGGZT6hj6Omj/t+dHOxU+hW0oUOYvcGQdo
	IKIeFOzuuuwoON8VvdYBcDi0UhOfL/OxE1db0kelHvTcPW+jLFg5GsJfPuZzRbXEGUXrwPIMkjf
	mhw8=
X-Google-Smtp-Source: AGHT+IH8lOHs5F7JgjBYwdnat/pkPGU3i89izTiRydGTFEpVaYP+S65Vq9chKUX3hmqFUZHNf6tOPg==
X-Received: by 2002:a05:6808:1922:b0:3e6:61f0:4797 with SMTP id 5614622812f47-3e79477095cmr3867819b6e.40.1731087928735;
        Fri, 08 Nov 2024 09:45:28 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/13] iomap: make buffered writes work with RWF_UNCACHED
Date: Fri,  8 Nov 2024 10:43:34 -0700
Message-ID: <20241108174505.1214230-12-axboe@kernel.dk>
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

Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
set for a write, mark the folios being written with drop_writeback. Then
writeback completion will drop the pages. The write_iter handler simply
kicks off writeback for the pages, and writeback completion will take
care of the rest.

See the similar patch for the generic filemap handling for performance
results, those were in fact done on XFS using this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/buffered-io.c | 12 +++++++++++-
 include/linux/iomap.h  |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb6..609256885094 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -959,6 +959,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
+		if (iter->flags & IOMAP_UNCACHED)
+			folio_set_uncached(folio);
 
 		offset = offset_in_folio(folio, pos);
 		if (bytes > folio_size(folio) - offset)
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
@@ -1034,12 +1037,19 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		iter.flags |= IOMAP_UNCACHED;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_write_iter(&iter, i);
 
 	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
+	if (iocb->ki_flags & IOCB_UNCACHED) {
+		/* kick off uncached writeback, completion will drop it */
+		__filemap_fdatawrite_range(mapping, iocb->ki_pos, iter.pos,
+						WB_SYNC_NONE);
+	}
 	ret = iter.pos - iocb->ki_pos;
 	iocb->ki_pos = iter.pos;
 	return ret;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f61407e3b121..89b24fbb1399 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -173,8 +173,9 @@ struct iomap_folio_ops {
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


