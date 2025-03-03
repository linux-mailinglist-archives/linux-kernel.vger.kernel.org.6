Return-Path: <linux-kernel+bounces-540879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDDAA4B60E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11380188EDAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2A1D7998;
	Mon,  3 Mar 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0knPVUK"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F401D54E2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968710; cv=none; b=GQuFFnEfbcv2DnoX3adKs4sGEw5Geji5FsDV5/l/Wru4ufmzaVdI5MuYbyujTOIIZWfp/59B57aIWwso23DZgo9xUECrvT3705oagQKTo5kwvAoAnYNyitd7QNuCuaTHiPhNvd5qCYmeNU6c7c8EfNWLv5kxbfCZ09qZOU+HvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968710; c=relaxed/simple;
	bh=CoKXRzXgooycgC4/aLBIRCF3+UwIHim9p6IKRBVdXSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVxA1FVHE3V7ilgnbChwQBR1yulNx85N02YhXWR1gtP3i1FnYDN0G/zSpMzGJ9kjn5dp/G2baXdr4i0SJYv+FpKeJfRPT0lXNgQbiR64Y/z3WV4BfApxVhL/3TPDRoJ76Dmhkkm13Cezh3egTmdnxxJuhJqbwjziBfyjEhVGkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R0knPVUK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso250333a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968708; x=1741573508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9mhj8QPNzHEXvTH0OVXBitiCwr2gmDik1RNTqYshT0=;
        b=R0knPVUKRGYgYMElTm8D9PYsBZyTqUjxbImOdJREqYmTIkK5FvHVzxIlhhPrqthIGU
         +ZoMwILptYuMKbCL2BFFm0R/J35CyeVhwxzJCLb56Agm7fIFxG0v/WubiS5+ncBLnF8S
         iIx8wblR57C/u5HfnVh5ycFgwmj5dJ8Z/LpaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968708; x=1741573508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9mhj8QPNzHEXvTH0OVXBitiCwr2gmDik1RNTqYshT0=;
        b=ftGUngcN2nlW1XjPqnvqEXNPjCpNVGVOPFRGO1VUg0Q4Smy2m0d6TeZdDcbPlL9lD7
         cTfuVJO2fH2DzP7/Lxncn+s4K/tif2Jd0LIQzdkNW6jCiTsSeWcnLHh7Uq3fefG0K43C
         eFWNvImHvIj+SJtfkDfbn+jy0DZKU0p63GTKBRIs8HelT8Lq3blilh9K2VM8TF7nDu1p
         H9tvSPanZZm8wHudkYSzWUD5e2Wt5bE4hSZTnmKfj501MSlf4KAz1whpvRRvcWbgpnBp
         bFBR23s1zfcEmL22y2ub11ZTilaoreypQSFTjHJ29pTSJxFeAY6cIG9VkL1H5p8M4Vur
         LHDg==
X-Forwarded-Encrypted: i=1; AJvYcCURHWHZ26w2ceC4vT7QK45HdGRxtos4/1xd06j3gVGIiogcDq2LokOWzxkT/t/62kcKowzGwt2znwcRJlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaOmABSWK+EyfWrOzZnGiKZWNUku+zGfHcJPntrnftSj5cZFO
	xx8r8AcBDrFwtMLu9ECtwYCU+mrfSSuvi27Mj6ZuIbmalw6RDPRnD72lD407hA==
X-Gm-Gg: ASbGncsyCWK/RDQiTrENOdm/wiPU48gQGCpepL6Poh+fOIbqi+5VlKsXMI0nGJefbFG
	dFXtafi3yL4+zNF5xxFZOdHvlRhLrSIMA4fftuIsF22ZvQfz2wXhltA5ExFlD3blOR7qIhwVuvR
	ziZdKdqEgqpijR0+xsFbgP2P/lkinl7VRxKxxqU2PpOCmUBBNEIHQi1i6QsW69S6e+WO4eYIjXu
	3pjHSD/AoZsRrpoCQZCkDDaaAqIIScgJYTaheg1g9Ry9QsZNUlCJgkkVBdxs5wMizaIcDmzaeJW
	QL8L30JKyzWcmKJ8fXPR8FCLnk0hvWq21Yjmp7qpInHF4UA=
X-Google-Smtp-Source: AGHT+IF66VEKY5wPrt/KNtaj7+PAWT785N+ktrJ+PZh+m4XyOgJ988yBEbAqjba5GwAAOb7NWMraHg==
X-Received: by 2002:a17:90b:2513:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-2feba95b413mr17873240a91.16.1740968708303;
        Sun, 02 Mar 2025 18:25:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501fae03sm66894545ad.84.2025.03.02.18.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:07 -0800 (PST)
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
Subject: [PATCH v10 07/19] zram: remove writestall zram_stats member
Date: Mon,  3 Mar 2025 11:03:16 +0900
Message-ID: <20250303022425.285971-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
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
index 249a936b6aac..fc9321af3ef4 100644
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
index 7c11f9dab335..6cee93f9c0d0 100644
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
2.48.1.711.g2feabab25a-goog


