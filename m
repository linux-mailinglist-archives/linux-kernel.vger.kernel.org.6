Return-Path: <linux-kernel+bounces-510572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD41A31F00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A951659E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87884200115;
	Wed, 12 Feb 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdmWqewW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4191FFC56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341954; cv=none; b=L1VHRwzYN/3ThZjEzP8uycGGjmYVypafr5lQDi9yIOTZz0QaHOVs+GkdNbr9oUW11hhsIkjL0uY0BfvMfeO2Rv+kgMPe4Hsp3bEGk5fYg/7d8/EosMkBBNLfZppURs6nFFIJyulinT0myAKUNmFtN86NaGE8LPhGpd11NH43de0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341954; c=relaxed/simple;
	bh=flolTbXXi8MQLaDPN1IzgsuIaefgJ6R0mz4aEpsIhfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tknjJtNoypuncQ/FIjst3kyGmhQqyR21UAOo1OBOJitQkrhSknLN4sKmatixyxeonZME+ceC5acxVEDhHjv4bI0Z/zpglSBLmKQ+Y3IGBuGBRb0jakr0GsKB9FLMCgcKbLjlxu69rFEwcpfTkv2kf93UWL1XHFpE6fyGh7K7wuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdmWqewW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f44e7eae4so108456955ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341953; x=1739946753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP/iUhuHVLA6wFxJBrfyM09o41KGkhO8ufnVXdUQ+KM=;
        b=WdmWqewWQFD8WzD3YrNhqwM1iuPxwPgB4zInTLZhqrQxplacX/sETaJRQW++hUmz3G
         QOyfDWDi62bojWeR9hrV6/5nOlNEoYveDGpPVzy3vyTSfVPclusVXKJMVQQl7P2cQDKi
         Pf3Y+oABG85TR8/F4SbjUflsA7e5ZUoiMMfB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341953; x=1739946753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP/iUhuHVLA6wFxJBrfyM09o41KGkhO8ufnVXdUQ+KM=;
        b=Onz+LqWNzdszf61Q3Ux2/8qFrzbdUgtwkP+EutS6wXV67SmADzqAOXUfig2tbOmYax
         71q7kXCedf5zJefu0Ytm8Yxahv59wnF7wjIS5jmf1HnsacuY+E8U5xqZEHWNH9aUuBCh
         cI/9KsERo0JfB5wGka4PpSBDSHqa3xBhpnEP8oXOa+PlZcD0aAmNRX/6uiL18N+r8awE
         FixTuEJTJSbsauTeRLHOyVswjLZ9ZjUNH2oiJ5ozo55v19Z+jn+QuSZaidJRUawXXa0j
         jzBsxZcGVfoUI4L5UATkJQ7cTuYx9tgmDXeTDQtBDalYmo0oh6ofSof6tCrib6kacV78
         Y4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVZmbC5Q1MoGwKxNMW/Txj1aetPMT1IPurtcDkwhSWs10mUdMgdiSLgVAsLAWLeWLgkXJr10GCeaFavv9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsU4N/fh4oeMBLIr2R25YNaGZM+fstPz2vrh4lIRODqjyqqlld
	LVcgPRiiR9tmEy9AZ0ODQmaHxJGJxttf1yVdmQ36MowyrMKvFwthjFV8nuBzdg==
X-Gm-Gg: ASbGnctyZGzfHRd4myjzSX82JSMsxmB5/sqeWXYgSLmeqLfy7b6epCS1JwHFTGZ2EG2
	CWjpZUOwk5W/D+q7XMZ7nOOnDCC8fsUTTnS68OcX6uBxx7nUhlEHU8VVUmS2a6D3pOjgDejM4f1
	WTXoYTRK5asU5XQ/bGTLVsXzV0EWVrJdvlXeza4v94jPNz3PvB0Wj8TDe6TTSmc78UPZt3Fwa69
	VePOrKC+0zbgwxaI2tReiqZ6I22Rhkdg4sbRZMEf1GhP197MKJHpHsgPPdVroDJf/7ImLcbTsLb
	dM+AONwbSc8jYJ3Ibw==
X-Google-Smtp-Source: AGHT+IE7SyVtE81IRMZ7QuZhJlVL0CH3JofgG8lKolY4V/dbLjW0GVG8rwvz0sFKRCNuv1wj7rDucg==
X-Received: by 2002:a05:6a21:6b17:b0:1cf:27bf:8e03 with SMTP id adf61e73a8af0-1ee5c840a69mr4005891637.26.1739341952903;
        Tue, 11 Feb 2025 22:32:32 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048ae7f6esm10423017b3a.74.2025.02.11.22.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:32 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 06/18] zram: remove writestall zram_stats member
Date: Wed, 12 Feb 2025 15:27:04 +0900
Message-ID: <20250212063153.179231-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
index 6384c61c03bf..7e2694079760 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1438,9 +1438,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu %8llu\n",
+			"version: %d\n0 %8llu\n",
 			version,
-			(u64)atomic64_read(&zram->stats.writestall),
 			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 97c98fa07954..b9528a62521e 100644
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
2.48.1.502.g6dc24dfdaf-goog


