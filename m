Return-Path: <linux-kernel+bounces-526748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D7AA402AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DC042273D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC83255E33;
	Fri, 21 Feb 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c8GOuSBZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA386253F37
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177042; cv=none; b=t5FrzyFZ2dwTA86DBrowmiIRkQzItEQP18l+MTRT6B1So6McuzH9D/reC68978UxzEKbnaEqbM2kol/RpqlrRerBkBdIuhv082XXjs1z7LMAgGZUJmkZyarTCrrGest6677UzhQVnJ3XOsqgBYAfGKLqle34y9fH6spZKR6hqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177042; c=relaxed/simple;
	bh=EfPPWox0A0qN57Hni7FX7WiTN4G3wYb9fZfqtp9j0iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn7ocIQSoJiiK3HRc/2qILpaiJrjHcyNsBViRSVDsYxfFZQ9YebXaAcgVWzFYQXoaOYmkhsriAslsnmA4vZ9tfhQVZVyxhxRqQjGodJ+N2QCj+Fl3MN2FW1Jbi5bimILoCjrSX0aFBO0y85O48FeTJ6NcFTDy770xx/+nVqxz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c8GOuSBZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2211acda7f6so58832715ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177040; x=1740781840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ipa2djuhtNWtVeFchIK72Sxo8mMAH/HdQlr5E6ZYMQ=;
        b=c8GOuSBZnphWJggKMBcRsuieTUEuYOqyUSsgD2h34yri6TpWV3lOErFawMQs7dG0n9
         Z498A+u/1Cjt7U1uzL0rWy63dmDvXykPD7SqTh9FwM3YEA8jlctkodYDV1Yi1sCh5R8N
         5z++WUvVBS7ppy6Sc4enTNDmcmgGDSj6ZSWXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177040; x=1740781840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ipa2djuhtNWtVeFchIK72Sxo8mMAH/HdQlr5E6ZYMQ=;
        b=gxBTO7ga9tFvfyA+x5oCWMeKTMi0Qa5vrLav0WKf9aXoXxf5IXCfN+Q4wwssFbVEN1
         J8DV4vUPQFUZPtgJXa4Mp0edxLYke2RZZd8PHniMbfUT8NNvvmgZL0ejevb/4cGreTfU
         Rnymemf9xAs6e0OyEXYxKzh7jKgDXeAVsJx9MLUCy5tx3oAukikEfjDsvIyJQMLdBm7v
         zkVyjYu+0B2G3roRT3gpnmtJJDwjZBqqa6zjcF02R9oqxGeq91P8zvl6eRN2PyxxxQMO
         Bh1YkDQ4Atxs87yGAQ/os3gdTSJEzG/r//lSwO6KPhovflZr3SS3sa+AEtzmoWsMnXRt
         G9mw==
X-Forwarded-Encrypted: i=1; AJvYcCXJNL5i6jP30ZoQaRl/U0L//j9bWobAWikvNzIbsbPeFDiE4Wu1MAfnPakGnZ4YQhJZLnl7OmOfL/R2VKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoJ8C9XkhJ61j/zXqXzdnjBAvciHiHpmEk6H5CHJpgZJamCcu
	aeHMwXMQ/Cz7XINK63V+wDHiJq1TjkrJFo1UNHSWy8rC2HY4gnqP1fBYQQnWjg==
X-Gm-Gg: ASbGncufIKVpOPp1YsmOER8WX5RPGMjetTCIt7NpKA46SDVf0cFPk/dNFZFH5cl8Pqn
	hKkfLar7fRniQ64lfhQrEI1vkCkeMCBrSRcPQToJbciEo2MbLqpn8rYvOyy3gJf85djlvwg9Aw5
	bpi3L/FbMtBs8r6DayVuohjo3J24QfopaupHCoeU1ydUIMZGwUdWibDFtESXPqnYA+1180MlXBK
	fC1ZX+1JYIAwcHZho7QRP0TRj61i5cm9oC2KPFWxBt9bUfT9/vVAAcPa3q9bivJBwipLTPqpn3Z
	sx5WaBsVbnhfkFuakaupT5XdXt8=
X-Google-Smtp-Source: AGHT+IHnpU8YQA5PKzQqh5jRMk7SblIEQDtKyygZfmyprCwBS4IqLIgpeynjiVrVJz+BOzuLSs556Q==
X-Received: by 2002:a17:902:ce82:b0:220:ee0a:73e7 with SMTP id d9443c01a7336-2219ff5ef09mr79718385ad.27.1740177040064;
        Fri, 21 Feb 2025 14:30:40 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5364676sm142838985ad.82.2025.02.21.14.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:39 -0800 (PST)
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
Subject: [PATCH v8 06/17] zram: remove writestall zram_stats member
Date: Sat, 22 Feb 2025 07:25:37 +0900
Message-ID: <20250221222958.2225035-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
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
index 4ccc1a1a8f20..710b10c6e336 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1443,9 +1443,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu %8llu\n",
+			"version: %d\n0 %8llu\n",
 			version,
-			(u64)atomic64_read(&zram->stats.writestall),
 			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 2c380ea9a816..59c75154524f 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -84,7 +84,6 @@ struct zram_stats {
 	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
-	atomic64_t writestall;		/* no. of write slow paths */
 	atomic64_t miss_free;		/* no. of missed free */
 #ifdef	CONFIG_ZRAM_WRITEBACK
 	atomic64_t bd_count;		/* no. of pages in backing device */
-- 
2.48.1.601.g30ceb7b040-goog


