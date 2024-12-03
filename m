Return-Path: <linux-kernel+bounces-429768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136049E2752
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A975B47F52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3C205AD0;
	Tue,  3 Dec 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NvPvt5h7"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A47208966
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239984; cv=none; b=oEWCf6n+w+b3GrGiVX1eTYnSQySW+2vlH4rv9EbdqonubX4jrbAtv/idZAX1DkQLf5iqKHQ6Ay2JdrJmwChg+MatWvD7FMnGzelPY47rblvjQmmpJoQHDSeirYZ18QPQQ5tQ/u7ZuLSjHCLhUIJ5qaM6TwUGndovQ5jYNvhSzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239984; c=relaxed/simple;
	bh=H+SJrhFgkMARuJzf6zQzkW6swewkOc9KT1deZMH8OhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJLu5bUZouaxqAzhweO2G8KQLbIP9xGY/gRVLUKuhFtQndyT9LiF942FEe2zrxBEY4vo+r/9n8Dmc2lQbDNCyozwwYqr/L6X7Gz1a969VuVQqtsNe6dlq0+fKkFon5Jwab0tNiEJj8/q/HZVJCW9sBc5z+rQf6gqMve4TGFDB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NvPvt5h7; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ea5a7a5e48so2650371b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239981; x=1733844781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNRkYctWaLbO70YbebeuOKFfbUg5iKQfEN1xFJYmHB8=;
        b=NvPvt5h7l8lngjBGNuxy1XfMurd28jtD71TE5JEBJN8m0imAbUo5S3bdcA1KRVni0K
         adBG9tVcZH3XkpLeOYkphqHUsl8KthkdbhxTVwzY/AYvhuXK8Y1+2DFvCv6V01nqbG2e
         3oUcfMTQszBNztI4erRKjKFbzvlrRZNoM57g/od4rXo89X13JlAbyf7VExy+ZafmwNUN
         TmnqZ40rMEAHhACUFoJrPsE14XGVVZYsZnLmmGH3lDZfNy7cR9Ctj/KxowZFTmsInge0
         Bvoc8xEaEU5E2ZG/+QlgV/0AKK+JojGNNqffpdz0vhhgRX0cutoayz9fj9wDcLTW1kct
         3org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239981; x=1733844781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNRkYctWaLbO70YbebeuOKFfbUg5iKQfEN1xFJYmHB8=;
        b=FOh8SqmNtiAPCgEqdV5TRLXrTET/6Yg3blsgN9yMXuD3vfAPLTy8673nFscnIByH6Q
         dn/rmGsMi32wffIlZGzE/+80E9vy2Iok5ndOchF/FoAW+sV+K4RIwcX2vLsCVOEy+HIt
         LImJgLUHo0IvxDONOBp4/KlvQerYM8uz57kRPkC8hOuwpsHV011faMdFtfn2utoYVA9i
         kcM2Sm0Eno81RhMAhHaR1vFZ4zs18Dt5iMmqIvRoIHmmKxRB7/nWWIQ+1B6O14mv+Ab/
         8+gA5sj6PSdTVimwmTQ1iILFjh5iKP53lXcE5T45q3RqQDSrTTbbTCLvVoR58/36JWzB
         xhEA==
X-Forwarded-Encrypted: i=1; AJvYcCWzvKUf3QGyJsMC+Rdk8RmJ1/tmb/ny+b4r5SX1HhkquD68sHv8GC+UDY3Lw2zUC65TUM68PHs9CkHueLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TGdG+5HJpLN1kk1bzGQM4lWnQODpmbtPNmwVRji9i3Hw5r6N
	7Ga/yqFkSIQcKgzcqeZ6QBd5mN1nHN4i5T7u38lTYJCPd45+BxP3e9hsBU73flM=
X-Gm-Gg: ASbGncuwcUqexw7o1bJONja0x/mfNQ/IT5bVrP0cXt/tA24CLAYxQ1rlar5GoeYHazU
	PUaGU3m44WxJZ6yhjnzPtrQNl+Pvh1vn6sXEr0+AhVF26JlqJq53hZVOhzXU3S9puzh2aIpB2nN
	asITXTyWWFpqSvL6zg0ltAYmfEbn5yl20VKNcUey2fcT+ZKFJnrnL3na91Ns1bGNNDndNzMPJMb
	T8L/XHZkIIHetJgnHQ29y17W3WPF0aUgQ07upTXuWkfjRMvTiY44BVlO9Q=
X-Google-Smtp-Source: AGHT+IGnmoFBWMRz09BuY3oNVVI/1OH4qyI0X8Y48goC/ICz9U7NJeNOcoRPtjmNOo7azkeA+JUnjQ==
X-Received: by 2002:a05:6808:200d:b0:3e6:6208:b737 with SMTP id 5614622812f47-3eae4f3bce5mr2757240b6e.17.1733239981545;
        Tue, 03 Dec 2024 07:33:01 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:33:00 -0800 (PST)
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
Subject: [PATCH 11/12] mm/filemap: make buffered writes work with RWF_UNCACHED
Date: Tue,  3 Dec 2024 08:31:47 -0700
Message-ID: <20241203153232.92224-13-axboe@kernel.dk>
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

If RWF_UNCACHED is set for a write, mark new folios being written with
uncached. This is done by passing in the fact that it's an uncached write
through the folio pointer. We can only get there when IOCB_UNCACHED was
allowed, which can only happen if the file system opts in. Opting in means
they need to check for the LSB in the folio pointer to know if it's an
uncached write or not. If it is, then FGP_UNCACHED should be used if
creating new folios is necessary.

Uncached writes will drop any folios they create upon writeback
completion, but leave folios that may exist in that range alone. Since
->write_begin() doesn't currently take any flags, and to avoid needing
to change the callback kernel wide, use the foliop being passed in to
->write_begin() to signal if this is an uncached write or not. File
systems can then use that to mark newly created folios as uncached.

This provides similar benefits to using RWF_UNCACHED with reads. Testing
buffered writes on 32 files:

writing bs 65536, uncached 0
  1s: 196035MB/sec
  2s: 132308MB/sec
  3s: 132438MB/sec
  4s: 116528MB/sec
  5s: 103898MB/sec
  6s: 108893MB/sec
  7s: 99678MB/sec
  8s: 106545MB/sec
  9s: 106826MB/sec
 10s: 101544MB/sec
 11s: 111044MB/sec
 12s: 124257MB/sec
 13s: 116031MB/sec
 14s: 114540MB/sec
 15s: 115011MB/sec
 16s: 115260MB/sec
 17s: 116068MB/sec
 18s: 116096MB/sec

where it's quite obvious where the page cache filled, and performance
dropped from to about half of where it started, settling in at around
115GB/sec. Meanwhile, 32 kswapds were running full steam trying to
reclaim pages.

Running the same test with uncached buffered writes:

writing bs 65536, uncached 1
  1s: 198974MB/sec
  2s: 189618MB/sec
  3s: 193601MB/sec
  4s: 188582MB/sec
  5s: 193487MB/sec
  6s: 188341MB/sec
  7s: 194325MB/sec
  8s: 188114MB/sec
  9s: 192740MB/sec
 10s: 189206MB/sec
 11s: 193442MB/sec
 12s: 189659MB/sec
 13s: 191732MB/sec
 14s: 190701MB/sec
 15s: 191789MB/sec
 16s: 191259MB/sec
 17s: 190613MB/sec
 18s: 191951MB/sec

and the behavior is fully predictable, performing the same throughout
even after the page cache would otherwise have fully filled with dirty
data. It's also about 65% faster, and using half the CPU of the system
compared to the normal buffered write.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      |  5 +++++
 include/linux/pagemap.h |  9 +++++++++
 mm/filemap.c            | 12 +++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 40383f5cc6a2..32255473f79d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2912,6 +2912,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
 		if (ret)
 			return ret;
+	} else if (iocb->ki_flags & IOCB_UNCACHED) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
+					      iocb->ki_pos + count);
 	}
 
 	return count;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f2d49dccb7c1..e49587c40157 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/bitops.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
+#include <linux/writeback.h>
 #include <linux/hugetlb_inline.h>
 
 struct folio_batch;
@@ -70,6 +71,14 @@ static inline int filemap_write_and_wait(struct address_space *mapping)
 	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
 }
 
+/*
+ * Value passed in to ->write_begin() if IOCB_UNCACHED is set for the write,
+ * and the ->write_begin() handler on a file system supporting FOP_UNCACHED
+ * must check for this and pass FGP_UNCACHED for folio creation.
+ */
+#define foliop_uncached			((struct folio *) 0xfee1c001)
+#define foliop_is_uncached(foliop)	(*(foliop) == foliop_uncached)
+
 /**
  * filemap_set_wb_err - set a writeback error on an address_space
  * @mapping: mapping in which to set writeback error
diff --git a/mm/filemap.c b/mm/filemap.c
index 826df99e294f..00f3c6c58629 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4095,7 +4095,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t written = 0;
 
 	do {
-		struct folio *folio;
+		struct folio *folio = NULL;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -4123,6 +4123,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
+		/*
+		 * If IOCB_UNCACHED is set here, we now the file system
+		 * supports it. And hence it'll know to check folip for being
+		 * set to this magic value. If so, it's an uncached write.
+		 * Whenever ->write_begin() changes prototypes again, this
+		 * can go away and just pass iocb or iocb flags.
+		 */
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			folio = foliop_uncached;
+
 		status = a_ops->write_begin(file, mapping, pos, bytes,
 						&folio, &fsdata);
 		if (unlikely(status < 0))
-- 
2.45.2


