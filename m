Return-Path: <linux-kernel+bounces-535569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943FA474AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03083A3E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA41F5855;
	Thu, 27 Feb 2025 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NqJ2hjIL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D211EB5D6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631032; cv=none; b=gkFlROTCdhzPXiV192ulVLBrx1XQJNzNwnwuPw4FiO2zjNaVOveS3/ecfpdkyTYT8M4UzXWEzFIJVPg5QJe/WfJMOoPn0Nel6YST+gQiZmVkpiSs2hdnqNxVVxsvT5KTxb/qGcAcnGUvmul8MKzjT6RI8Ysxrimo4b4+xb8VfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631032; c=relaxed/simple;
	bh=N8lEzdFy6KjeZwz98GaDqkIP6EJ2Tdkarqv83T9/CFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1R3Hoh+fNedfJLBYO5UE7qOM0aCmh+nGl5+f1XJ2kXWa0pLWfyKParU6LqTSL2hsaMMLP1DXaAB/b5xNU+jDHH2pDCpLG63kmIKVslzSfxYLIqnIMdfLUTMpd0GykTu0dOfFWcR8Ofiv45k0aPgYk/7+StuVjHvMulksi5rOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NqJ2hjIL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fe82414cf7so1075332a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631030; x=1741235830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjK5z/f2m0DncP7Ixpif51js64ejx6xQxz7bzy27nuY=;
        b=NqJ2hjILarTocOO14//oyigeev8pX85zpiZKxVoFxJ2TIwiHKO8CWD9Oi3TVIuDxMV
         xbo3P2W8QRCYx/0fDk1hGZ53jj+IGiXlK/+AuawwQAqb21o1/m3WpjA8H27N+u6rQpch
         5KS7+7ItqCbVgj4Qv4fD1vfpecwYqkOy7crZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631030; x=1741235830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjK5z/f2m0DncP7Ixpif51js64ejx6xQxz7bzy27nuY=;
        b=WXOPT4eYzjrQqWJnkCuVaU9FHrCQnALJYW/X8kkD8G8Bxjg2IStzPg00JIvcxXtfAn
         FF5gZHK2fLW6rJwsyLhU3eig4tH7XkKiZDU6Xo1x6lwLbVmywuEbHgAD8myHWuImtNM4
         eH3yxE+5L8h5P+lyTSlLN7m3ula14juGJ978SMBaGfuNhVSeZOFP6It/hvf8jN4u20yq
         aNSKcQSirbqTGWyVtWt7CkNWluKTTWBTcA7Vb7BO7vqd9tjbvvVCHfZYjLk+rq3W+VYg
         FkAn6rQu3HGfp/GEdMgQ+qz2b+4NLSWf+Rkx2Z8qgXNFydQ6ckMhe2cDvkL2ITdNk5J3
         WCMA==
X-Forwarded-Encrypted: i=1; AJvYcCXl3AxsN0W8JqZDelrtUJX5iFCOkxVkSj8CJhjOyVngkUTFdDGosjcqqeVBWEIci+UMXV7xg2TWOxMOh5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0IU5YDiltHgyOE+2pA9GC1GorQ1zjNihvM9aDHILiCDvAr+Y
	mNBNrRy5KW4jq8wiT6q/FFqN6jpo37N19v880F+ZXvgFUUTBDjm84akLPVNk9g==
X-Gm-Gg: ASbGncsQvzfO46XIeCXBZtCk4U+/y45hiITdp3zW3RfqP9bhBC5vSl0JOAjdm6Zz8Op
	crwXiF2Ia91fI+dafjVn+xu0hfNye8q8So+Zx/Imb8ajCRoeIRzr9yBwMM05plUW0A5a/URTpyQ
	00laBKOSHryTkDS3D2DDJ3c0jhHJTCYc37gj1I1gDVd0Um9a90QBfTPksqe+W61Ka/DB72LNFFX
	5MbIyJIfIEsD09+TXvzOzdSjKumRA9Qxsok9Xw9N5R8amtgU7vmWczBNnW7qDXuyZiYChoUQYQ4
	upcR49wv6itE9KTXZz8Jpvaw6k2Z
X-Google-Smtp-Source: AGHT+IFGQH7QQ3h8Q2RsubEbMnBDcSEsStmitP3pSesQC9VI8bjIeDpBSGzc6iv7/4S9G/lG5bzkYw==
X-Received: by 2002:a17:90a:c2c7:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2fe68acd797mr14877858a91.5.1740631029968;
        Wed, 26 Feb 2025 20:37:09 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea676b133sm474944a91.13.2025.02.26.20.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:09 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 07/19] zram: remove writestall zram_stats member
Date: Thu, 27 Feb 2025 13:35:25 +0900
Message-ID: <20250227043618.88380-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no zsmalloc handle allocation slow path now and
writestall is not possible any longer.  Remove it from
zram_stats.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 +--
 drivers/block/zram/zram_drv.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 08fc9821d71c..6266884de1d0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1437,9 +1437,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu %8llu\n",
+			"version: %d\n0 %8llu\n",
 			version,
-			(u64)atomic64_read(&zram->stats.writestall),
 			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 8b66af0d162d..5ca87554aa26 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -82,7 +82,6 @@ struct zram_stats {
 	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
-	atomic64_t writestall;		/* no. of write slow paths */
 	atomic64_t miss_free;		/* no. of missed free */
 #ifdef	CONFIG_ZRAM_WRITEBACK
 	atomic64_t bd_count;		/* no. of pages in backing device */
-- 
2.48.1.658.g4767266eb4-goog


