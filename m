Return-Path: <linux-kernel+bounces-409538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8569C8E64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262D6B2FFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726F1ADFFD;
	Thu, 14 Nov 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FD0BMbPu"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791B1AAE2E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598100; cv=none; b=SwQW2ZMQBUHqlDPtNl2Ha6ZuQCpHCCi9rcRR74J4am8zL44/3FM/+NT7h/CLwZAaa0rtICnMpC3mrx4LzPZoqfWiar9n5E7p5YyCIo47yFhAb7t8/ogL0GekEUb4zs3QdOWd0IVCT415+RjLEaMxlf580nifMhk6LlEUvGWuxIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598100; c=relaxed/simple;
	bh=Cprr5Wztuokl5alQc44L4Bz+weZZLTHr6zOlAD5+Dc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuiGeeyOIdKuTJY5+nYwZZLepuc48/EQec/j5kPZvQE0erMTLlApz7d18uERh+gmdg2dnN6UZwSi4etLWJlU3TQBl+X6w2J+UPZPA0/km7Db1Yv6EDrlwJ8rBjW7IlFndO+w6FMvP3M8YxwFGe8WRKxntoj1bShD8B2jAmh6XDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FD0BMbPu; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5eb67d926c4so322166eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598097; x=1732202897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvrv44z8Apd8qqgxqZBS6Do0FSmkBjZMAMWmq/c36cU=;
        b=FD0BMbPuTuxr0syAkrOqgbeVJ3V1KdUfTA6rPfo3c4tK6Xus72+a2OHKSE1lgXyCmX
         2DDppcK7C5D7w39z8m4Lvoy77ByuELQBlYoBLDtmlzEOZy1nLCR6zrg6gnm49AaEQdnL
         6OAJRAJCDHhGXePHms7IiKttN36ZhLmru1Mbc4AAZUFBrn7OaFD+ePREa+gIMhk5zd/l
         tq5C96H4cl8sJml5vZNE/34IhvhzaEAFObLQCL+QNThkViFGRXDGQ3Df3Gam6FU7T3B2
         mw3J1ORn9FkMY1S9nHVRb6nsd14/Egb5HPjsu3AYAkDO/ldpeio+5hgXjlU0R3dyBqhT
         eltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598097; x=1732202897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvrv44z8Apd8qqgxqZBS6Do0FSmkBjZMAMWmq/c36cU=;
        b=QySFHPt4UUUZWG5s5ULCupgmAf5vzCsa8FipRbjrRzXrNG0N56QXo1ozNOG0x7v+o5
         NOWvBoJHzT98LULqyhtI6m+aZwffwp6nVWLtpCZ6jXRF0o0JdwDSwBjNlBuwZoMfc0f/
         Y3kIbYFr9Xxjy1FXgh1Asn35BJxtt+pQ4MI3Tk2Emy3mgumItl30WkIWxDx0nWJ4+N0g
         1LzPHRYIEmmkLoBaC+rqPUMUw6/+ixwH69V9XG9jTKEZiGqFMTkLyHzwsG6wM3oViNtv
         jZ+X2ZIhXOS7KYxHVhzaJ1GjbtxqQgFPCyUOOPcrCHPcOnNP5aw7T8MYhkA1nhDkIsFL
         78zA==
X-Forwarded-Encrypted: i=1; AJvYcCWaJBM9/JbzITgsv8vKAB3WLzwPbnbCou5dD5K2tlI3Yo2kNphfoorsBdj5OZWAOi0Tdb/1Yj0RxUnKmdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVRBlSGvUUXxLXXso/mjNbUD2dj26zamCUUWqWezOFYevuQKk
	7kCNwy4SOfGAKmWmBBq385LbjHJkkDvfDBWEbFBajTA3Pa4YsR9J45+a9SRnN6o=
X-Google-Smtp-Source: AGHT+IEaTjdnOMAkEmoEcJnRXLnfxDNshZw+Ax439RAi/pKdYn0q0me9qe1oslEKsbvc7WBkYDa4cA==
X-Received: by 2002:a4a:e906:0:b0:5eb:6b3e:ce7f with SMTP id 006d021491bc7-5ee9c6c80d1mr2431138eaf.0.1731598097161;
        Thu, 14 Nov 2024 07:28:17 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/17] mm/filemap: add filemap_fdatawrite_range_kick() helper
Date: Thu, 14 Nov 2024 08:25:15 -0700
Message-ID: <20241114152743.2381672-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Works like filemap_fdatawrite_range(), except it's a non-integrity data
writeback and hence only starts writeback on the specified range. Will
help facilitate generically starting uncached writeback from
generic_write_sync(), as header dependencies preclude doing this inline
from fs.h.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 122ae821989f..560d3ee1bb8a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2845,6 +2845,8 @@ extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
 extern int __must_check file_check_and_advance_wb_err(struct file *file);
 extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+		loff_t end);
 
 static inline int file_write_and_wait(struct file *file)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 297cb53332ff..a8a9fb986d2d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -450,6 +450,24 @@ int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 }
 EXPORT_SYMBOL(filemap_fdatawrite_range);
 
+/**
+ * filemap_fdatawrite_range_kick - start writeback on a range
+ * @mapping:	target address_space
+ * @start:	index to start writeback on
+ * @end:	last (non-inclusive) index for writeback
+ *
+ * This is a non-integrity writeback helper, to start writing back folios
+ * for the indicated range.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+				  loff_t end)
+{
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
+}
+EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
+
 /**
  * filemap_flush - mostly a non-blocking flush
  * @mapping:	target address_space
-- 
2.45.2


