Return-Path: <linux-kernel+bounces-429764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56B39E2B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093ABBC3829
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E7205AAF;
	Tue,  3 Dec 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fe79W8Nh"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E5203718
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239978; cv=none; b=W2dJKZ9iNltIuhJOKX6YMd2cWDBbkZI7+86DySIX5zR3JJrseCHXBueKsGXOLH8hyCLNJl+yY5C/WWC8BCTAE3LExtsbG1EXuAuNNADQis2maT773wWggLs80UF4C6CgPv1n1A/dxzsxSFqZepAJ5ur8rWdvzKqsgFEBsVjsIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239978; c=relaxed/simple;
	bh=mhIaz7b2lyC1oOrpy7fcg+5AljdReMhMByTLtm2p4EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qP/CODif2lgBncwAKDF7IaDiTILzlu5ZUA5sHYxrUmq1rZvSUdMA2JDhSX1Hy/KPHunXWd3JjSWooLpTQ87gd6IHGot8d7v16XROuB9cFwozgUIKlQnqY8ECN6QgDSYZnqLz7HpVqgdUjPQqHsx81SyYSrJtjWX3++FW0WX0t2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fe79W8Nh; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea55a2a38bso3014473b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239976; x=1733844776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99ZtQ6Npm+o/kkpmwDDPCgpJncZgiN/IMlRLftnmHuc=;
        b=fe79W8Nht1SNccoLINB3gun47a42Nyg7qCWlAyUHn7wod5WZJVvfj5epG7rdRBk3EL
         IHI6Fy0gmAc/hoo/Rbj2tnqec0JQnK3TI8eslyBHs0GimM6Ve/bXBH8t1EsM0F/r4nfY
         H4Z6eo24b7YiLr6tn1N0IfuVI7ti0ebkN27qDrvk17HP0T/yfIErOWX8/joQS+PO8D1K
         XKVccScUJYUVpHgO01Ep1qUIMQLv5tSbIZAIOTweoUPn82mbpQd8wMNBlhJx/ax0jvx7
         +36yZ/NEp7WyKD9QrNsMJu9mb7b1Ypg4OQD0Xftl71coTjK/xpubRFXvsgbVSogeKAJY
         L2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239976; x=1733844776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99ZtQ6Npm+o/kkpmwDDPCgpJncZgiN/IMlRLftnmHuc=;
        b=s+mM3D5aT+7g10EKCDUU2u+CD9sYb9Y8ju4fxwDQTyfygDc5X9F5WXnytuKSNfERP0
         ahyPhDO1udoBibyJWfNtCI4A5tHoEHKgzK9nbat5Ee4tyAyD2tdyYbaSQIehp6WBkWT+
         /03LyPAaOftbxeYMRFgZ3jPlHRFRC3vnQGcrb1s8972JnVRVxqVvn4tTwQLSXFz3mV5q
         UHLpk/qzIaEFOsbbMu9n8u1nZxlELi7luaxpdj2xjL8JpzGE3qma5oZ5bBR3zZwrjjdW
         xyRWensdbRJVcZ1U1ltqM4+tyalHt7yJds5ZYT0hUBLs1JDLXrLqemG9evv7yjhZftSX
         QiGg==
X-Forwarded-Encrypted: i=1; AJvYcCXMkXW7H7nvRSNBuUorZ72CgBvqQ5OE27QKCXGARfSjI4n6gB4bujxOTwkmoom+ichLI0jAl6esLuejBvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkX2zVfbDXHjr9MjcheUu/rljhYkdhdhi2oy8nCj4MZpLRzVOb
	3e1zHc5KYEEgelDxf6EwD1PAxb0+9sj1aaDgy+70VrmcCrRRS8VQfl4H5ooqwJs=
X-Gm-Gg: ASbGncsW4+5EThuPcir51xgQHHGgNUw7hB8YY61ywxLAsbXV3TtT9h6GNL+GRhio01v
	pKepS3Qe7FueanGWR96n7KWL6p+yl9KjLkCq2QDUgfFG2XlEeV3lMXOWIkEDOmv+B/skavSrAwR
	hVJWS8XHCSK2zz34nPkd8Mk7pCU3vYnC18uNKeyQ8LH8E6CZbGp8B8CIg4VHQLcFrdaZ7UrEWDU
	66+PUC5EBwGnvYmFEXnGFY7g0BYD/3QAVtZLu6m8Zg2kF3Gg9q/lHI4UAw=
X-Google-Smtp-Source: AGHT+IHMJnWLWXZesvRG8H115i2+SnEyGT/XbMmAgLxKcYoNaa8g7OGxqlE3KOV7Yd59LM9TrdKc0w==
X-Received: by 2002:a05:6808:152c:b0:3e6:14a6:4288 with SMTP id 5614622812f47-3eae4f366f8mr2926476b6e.11.1733239975822;
        Tue, 03 Dec 2024 07:32:55 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:55 -0800 (PST)
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
Subject: [PATCH 07/12] fs: add RWF_UNCACHED iocb and FOP_UNCACHED file_operations flag
Date: Tue,  3 Dec 2024 08:31:43 -0700
Message-ID: <20241203153232.92224-9-axboe@kernel.dk>
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

If a file system supports uncached buffered IO, it may set FOP_UNCACHED
and enable RWF_UNCACHED. If RWF_UNCACHED is attempted without the file
system supporting it, it'll get errored with -EOPNOTSUPP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      | 14 +++++++++++++-
 include/uapi/linux/fs.h |  6 +++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..b64a78582f06 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -322,6 +322,7 @@ struct readahead_control;
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
+#define IOCB_UNCACHED		(__force int) RWF_UNCACHED
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -356,7 +357,8 @@ struct readahead_control;
 	{ IOCB_SYNC,		"SYNC" }, \
 	{ IOCB_NOWAIT,		"NOWAIT" }, \
 	{ IOCB_APPEND,		"APPEND" }, \
-	{ IOCB_ATOMIC,		"ATOMIC"}, \
+	{ IOCB_ATOMIC,		"ATOMIC" }, \
+	{ IOCB_UNCACHED,	"UNCACHED" }, \
 	{ IOCB_EVENTFD,		"EVENTFD"}, \
 	{ IOCB_DIRECT,		"DIRECT" }, \
 	{ IOCB_WRITE,		"WRITE" }, \
@@ -2127,6 +2129,8 @@ struct file_operations {
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
 /* Supports asynchronous lock callbacks */
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
+/* File system supports uncached read/write buffered IO */
+#define FOP_UNCACHED		((__force fop_flags_t)(1 << 7))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3614,6 +3618,14 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_UNCACHED) {
+		/* file system must support it */
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
+			return -EOPNOTSUPP;
+		/* DAX mappings not supported */
+		if (IS_DAX(ki->ki_filp->f_mapping->host))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..dc77cd8ae1a3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -332,9 +332,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_UNCACHED)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.45.2


