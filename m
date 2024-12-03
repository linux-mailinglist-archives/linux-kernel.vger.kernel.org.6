Return-Path: <linux-kernel+bounces-429769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164669E236B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC68C286D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9720A5D7;
	Tue,  3 Dec 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QOc0N/NU"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8647209692
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239985; cv=none; b=VBSPylIKUYN9P0XBMf+jZA667wvVxbtcLQ9NsoQ0jGzIUOc85N2rsTaTbHIjZnx3jkR0c+cTHv587/W+WHsQFc8LOUvqM0mMI2pkRs+3cz27N8tK2h+Yv7oRAHAyHptm5B931ujlz3ZMw1dv1wz8W6nwUgrLpxWTxfj74+edw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239985; c=relaxed/simple;
	bh=uuqM4dJdCE0QCImMtNfF8QapqPv5QHbWROfY8tXB1So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2jAM7LNZAJlDVC0/kLWgvTBT1DKFgWrf9BVED7Jr0z6Eqq57MfUm40a+QUPZPGfAt+6u4/e8qy8EJBOfOkTIIEtlVgr3AMx04j6sdxaxGLOsU7JZAVjcoCXDZKNxoy/sXvd6vNXsvsSXEnZnUCWGd9b8ojVhOYR3u5GUL1pJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QOc0N/NU; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ea55a2a38bso3014532b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239983; x=1733844783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45ZT5fvdDImmdgAdnvc6z/+AzY3WZJ2Fl5NYIbZiSAo=;
        b=QOc0N/NUqzgyQBFL3YcsFrekttyd/1YnrV1H2WXWVqq8rRuDr/fMbYTz0t0nSvjZsZ
         PM0IJhaPyr1XFGkB+CgN5rJGrQo594jDOQh7cePyS+sg/JBAs1GtxQqcsovONgFLy5Op
         1+ljoiONKHAsiMjXtSjgd+p1IUQBCGfFdjwWv68j6hNyma/YiG/+fSzPcVvx21A7TXKZ
         J8YTAo4MNYwj2TozO7JRy9v50QYghtb7lOuUhpepBkAbV48PxgCkaesFHij5OlaLIewn
         r6GeI3nXSYx2eMFHBv35VFSCGjE7XwwK8w5vv5wtuIXoUTRr94mCjgtrTWpg37lX2KUa
         Jc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239983; x=1733844783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45ZT5fvdDImmdgAdnvc6z/+AzY3WZJ2Fl5NYIbZiSAo=;
        b=lwV7JRiIjO+CNval9cFuhWjEb3gNnIr4nsAr4Pe982GwUTUNtZXWQpx7hYBarXOY+Q
         A4vooTEujwg+d6Fbl+J7VeHBfQdOzGmiXiRxb6d2JBTNu92otTWWiz9twnoclNCnGh/d
         7l0qsnfidxyRoYdWCCqxowTo8DYG9azBOByUgQAq7eXRQynQaM8+Rcu55Be8ljWcpo1W
         16i0Pi0Yg+VOKCmUV5KsnS7t8/CS3HqJCSnZN8H8lkO2cJQP5yuiz8KdS8roh27P114D
         zPjndMPwnwEqqSo4cCQ4Q/VE1bJxKJIu3f5x3M21PssSE9o4a4pUViGLxEiML+MmOMKL
         9hsA==
X-Forwarded-Encrypted: i=1; AJvYcCXUiq6Jdheg2KKd4hYH/Ta5pq46yD9rDpvO7i7NEdiM6dbc0E1D6fV/SAqBQIude15mUz0zcd3Lxd4nbMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPyODMWOpYpQpjIpeyYAknyEDUIrHc4xugRGqAEicQyjOva8k
	LY91T53UpqIqQO2LsVeRWb7zZNiLk939Vh/ch5ZG8iD9aeSrSmah6joUZEbHx/Q=
X-Gm-Gg: ASbGncvka8F1VOElDOkCmSxC8Tc1HfU7Yd/C9f9j5+or0zWe8JZUU//8uBwUIxdUe6M
	ugLOC/2yFqRkW/MMkDVknBzu+BYUi3jxYdIJZzGZY1AzWGvwavJ4WOr/aWXMowTiNmRrEc+qul8
	8yTiY37NCQzRfnDqNmtOLcK+0K/yqheNx9tkwYPuHpWrcBB4DJx/iaJ+IzAVKxz9ulu9x/Bweh/
	aNDyzE14yrQiQhM8hyF/AZl1/2zxwcMUEWYqGSdmYG4i80cLoi52C7t4MY=
X-Google-Smtp-Source: AGHT+IFgNffB59kRtGSa279D+oxFDG6GGmZlBVzfslJYY485yS6Rp8valFBlgcp9p+EP83czXVtQIg==
X-Received: by 2002:a05:6808:199e:b0:3ea:6533:f19d with SMTP id 5614622812f47-3eae505a0femr2960000b6e.30.1733239982974;
        Tue, 03 Dec 2024 07:33:02 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:33:02 -0800 (PST)
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
Subject: [PATCH 12/12] mm: add FGP_UNCACHED folio creation flag
Date: Tue,  3 Dec 2024 08:31:48 -0700
Message-ID: <20241203153232.92224-14-axboe@kernel.dk>
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

Callers can pass this in for uncached folio creation, in which case if
a folio is newly created it gets marked as uncached. If a folio exists
for this index and lookup succeeds, then it will not get marked as
uncached. If an !uncached lookup finds a cached folio, clear the flag.
For that case, there are competeting uncached and cached users of the
folio, and it should not get pruned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e49587c40157..374872acbe1d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -721,6 +721,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_UNCACHED - Uncached buffered IO
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -734,6 +735,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
+#define FGP_UNCACHED		((__force fgf_t)0x00000100)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 00f3c6c58629..a03a9b9127b8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2001,6 +2001,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
+			if (fgp_flags & FGP_UNCACHED)
+				__folio_set_uncached(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
@@ -2023,6 +2025,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 	if (!folio)
 		return ERR_PTR(-ENOENT);
+	/* not an uncached lookup, clear uncached if set */
+	if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
+		folio_clear_uncached(folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
-- 
2.45.2


