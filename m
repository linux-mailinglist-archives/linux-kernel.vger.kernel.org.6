Return-Path: <linux-kernel+bounces-445119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4856B9F1195
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B43C281E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AEA1EE00C;
	Fri, 13 Dec 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="01Hs9enO"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C61EBA02
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105375; cv=none; b=VWF7jierJ2ZEtP75huMiQjGSSSxrXkMtElmbFxxHM6eZYlbtY54eAmOPUtQm7ngLzhXF8VhfIVQPqLsRNN65Y/tIm1OJfVq7S2ZeR/jwBArtbjsP4SjcnqrlcJb1nfDGk1V7dYiSfWjniuFPeE9NH6rvdQ/6rAMKt6XflBXK+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105375; c=relaxed/simple;
	bh=2SEcDojzAqUnPgfjf8E9nRmr9dou/inG3/DhaNUqq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKzkPgh8RuAdr6slTzsLI7V0lx1sB0HbIa9ymBcyU/2oMJSXtIR9ekEjAa+4GF5ZW13XkQ0TkoPLG+xE8F1SBEuXlsS9hJqP2EK7TDeSrkzUZRz4qNDl6mKtMEtuSOMmQTe3mVx09kjPdHQipCrLnjcopDBqim1/EWwR6KKHnYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=01Hs9enO; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso15576755ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105373; x=1734710173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w74VD3kuQguRINknUSjUP4VNHVLoGClDPYL5LdL0oM=;
        b=01Hs9enOnkwKRmuqv8OPi5cm5KXxcKFhJlkctvjFgT6DFRRQIS/rAYbdV/lvyTW3Lw
         sbiSSuGpUO1nmFNR1hLh0BtKs7xfKfvEiwQpiVm7nVqSGJ/hT/5+Plb7PGC/Bt2vI4WY
         QAJWdCaYyEo26sZrPOlYErQq+dlX5WObrlqnCgBy06zFkj/9Bc+Df/BCuPbFkMe2/Yj/
         tF5zSPUbf59oWTKv+YkkQaZ4RSoBu4MFQv2/IPc8VTUa46726BfPG2gwdtYP+YDDWYi4
         DPcJQlGxRyu15Gt2gSwceQ80X6hY6iH355vg8dJhHAmEwxsA7CAsVybF5RLXrMEzEiAj
         DV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105373; x=1734710173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w74VD3kuQguRINknUSjUP4VNHVLoGClDPYL5LdL0oM=;
        b=i7ILgZ44sWBtkuCA1WzVyGermIfvJEEDvqe+G2+HSWfsK0PdWwafdy6B0k63ycptZ4
         I8p12uXnymnYC6VC2zEgmKD/zz6iEe4zFMCl2xceyIWheQM5f0Qw0aNjmq36bE7e222G
         desLSB0h7aEEu11hgQr0AEyyOh02NXxp2wk4uKVFqEYH+AnaJtfmC2iFo+coL4wczO0r
         hj12zhVbdt2x+jtq9JtqvAnEIyi9ZIGConp6yFZYw5WGCVuxULPidMkG88xgFBbIBZZD
         gpwuE16h0ZhiIkLMNcC5QLMpz+8zhnSGRFh/c5InO4b/nTFHdjJ1AiWmMMyNKnYrHjpR
         FN8A==
X-Forwarded-Encrypted: i=1; AJvYcCUR+3gbGZgYwFxjHKGIEnaillNPzyfLU1rG2s2tldhpPXI8pJLPpYGAkdBte44thQL9lVvHUjg0zF/NbDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFrto4z8JrfPB/Jsd/tw43+nm42Nr/u4FIRuK9JyQzzGX0oIco
	PkPB5DJAx+0qlSmctjgWZra2Xi6+Slg/EFX3I90Q3sjmZtQpXDG+qS0HqHJoWGs=
X-Gm-Gg: ASbGncuuIU2Hx8RSysy8oXD7AmBxabpqg6J7Szu6XqsF1p4BTcoYPkag+4qdrEnQbeG
	fnjBGSORT+0Fc4sixyXKbSvNnvMujPsX9whuhXYgcSUiH4TLvP/JZbQALQfBLSuAK+Rtt7xekoo
	9Kpb5pQQKwcZ7k4gxEyZN54YrCaLzIDS1d74AQxVlDvcFCk+URACO9uLmlmlgPkYs82bdODdb3W
	0wj+wo3IirAKQGB5/JVNalpB+kENLNxZIjJXMegztNYTHVNVTdr8si9otAo
X-Google-Smtp-Source: AGHT+IHLruDe6Zg9uYRMCFFj0re5LQoOZLn3MM3DvSbmN1NLcJuI0/2En87svfvn51ITwB5/NqHQ+A==
X-Received: by 2002:a05:6e02:3042:b0:3a7:8720:9e9f with SMTP id e9e14a558f8ab-3aff4619d10mr35119105ab.2.1734105373195;
        Fri, 13 Dec 2024 07:56:13 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:12 -0800 (PST)
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
Subject: [PATCH 07/11] fs: add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag
Date: Fri, 13 Dec 2024 08:55:21 -0700
Message-ID: <20241213155557.105419-8-axboe@kernel.dk>
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

If a file system supports uncached buffered IO, it may set FOP_DONTCACHE
and enable support for RWF_DONTCACHE. If RWF_DONTCACHE is attempted
without the file system supporting it, it'll get errored with -EOPNOTSUPP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      | 14 +++++++++++++-
 include/uapi/linux/fs.h |  6 +++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..6a838b5479a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -322,6 +322,7 @@ struct readahead_control;
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
+#define IOCB_DONTCACHE		(__force int) RWF_DONTCACHE
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -356,7 +357,8 @@ struct readahead_control;
 	{ IOCB_SYNC,		"SYNC" }, \
 	{ IOCB_NOWAIT,		"NOWAIT" }, \
 	{ IOCB_APPEND,		"APPEND" }, \
-	{ IOCB_ATOMIC,		"ATOMIC"}, \
+	{ IOCB_ATOMIC,		"ATOMIC" }, \
+	{ IOCB_DONTCACHE,	"DONTCACHE" }, \
 	{ IOCB_EVENTFD,		"EVENTFD"}, \
 	{ IOCB_DIRECT,		"DIRECT" }, \
 	{ IOCB_WRITE,		"WRITE" }, \
@@ -2127,6 +2129,8 @@ struct file_operations {
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
 /* Supports asynchronous lock callbacks */
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
+/* File system supports uncached read/write buffered IO */
+#define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3614,6 +3618,14 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_DONTCACHE) {
+		/* file system must support it */
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
+			return -EOPNOTSUPP;
+		/* DAX mappings not supported */
+		if (IS_DAX(ki->ki_filp->f_mapping->host))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..56a4f93a08f4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -332,9 +332,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_DONTCACHE)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.45.2


