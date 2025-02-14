Return-Path: <linux-kernel+bounces-514353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDBFA355E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775033AC9B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F54191F6D;
	Fri, 14 Feb 2025 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cr2jDV97"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF23192598
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508775; cv=none; b=X8W+ohAYUo6FQqwOYaFewvMRvOn3WZQgFdq/3Jwj5sE6ugXRghN4cvhJcZgk3sotus7jhGn1GO9FImp0B+/Af8/Il698pgJr/uve03ss2Bi8RPVPg6GNHEJ4benj6ge/eG4vMVmQqED5FRrbWaJ2iS18E/d48R08Fkrb+WnAnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508775; c=relaxed/simple;
	bh=RiX9bjZjw/Rrq5yHUz/wGgkrHcum1pzGpRmA11AODKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8eY+TvhjE7PULLhRAAqCv++XIJP1fpHDs5+bnSxIMeIOnjWpAbyqyrp9/4U16Twaa4l74mK+qSO5gzuTHED9Fi6pjH6GSDZxwV32rMuViNAf8Yy0xhy9jce1aRs4/1vEpEWYiIiJDn7NMMPDhmkw6CIoJZHpIkbukUd6+pRrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cr2jDV97; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f2339dcfdso25104755ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508772; x=1740113572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lbJ5wxYoLG970llEmrArbpgT7YZVPssHOdZszPf+hc=;
        b=Cr2jDV97E07HATgutJzxeObQ21LhAkEYMYzkUsqfjhT4eUD8H0YBwc1eJp/1DZeH1X
         Qf+axQjZD+du2/7N0yqgos7yxHXD7zJ8iDcBV6+qJeUbqskWGqDKgAD/XYmNRAc26KVJ
         OcmG56AdCKfpdQWzbu3O+iIKt9NHvXqQyIL+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508772; x=1740113572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lbJ5wxYoLG970llEmrArbpgT7YZVPssHOdZszPf+hc=;
        b=L+tUEFhTdAF3DFx/gezl/9fv+ial7Brz9K+rSdws5EtRliFX3Qvs2UW2HKftpSF5my
         8XUCWrAg/DR7KfYoMJh+cXKfiKBCPqNHDcvWFAcCF7eevaxupwfpJhoI0//Rk1CuscDA
         9ySGJD9IwYqbHLzniH0MARGMLAh4z6GGuNdQzUd5QNevcIqoY7MLEhBF5RAZAsYbEJIl
         8OF1gIiSuiwo/XtYpFO+A7I0UUGcmew/DHEJh5d5K4fjRcr7Xroz8uGpAxidrz233+SZ
         s5PxB+bFbG175iJVqaeB0dT69LbiIvML5CdNEi9nIqIuPeqP0WDUGC0xSNvr0plXZW1O
         Xzpg==
X-Forwarded-Encrypted: i=1; AJvYcCWhf7DuePmFJdGkKJz4pmcVDA2o/jD3mTGeJK60jzs6Fiv9ZtrUON1P0bnZBs5m2ZjbpjEBUVMkDpvfh68=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSef7g5rLm5Age2lm7jtJlBtc6lwmcIKqOw8a75RUXcthgUBH
	xEJQVM1py/9ysqOsTtpOxoPgruB4pth8INEt1kPNFQZ81kWBg9sXTxGXDLTG0Q==
X-Gm-Gg: ASbGncuC3717BLAlqasC47WUSwJcDSK3WHmiT44BAx2+Meho9ksIrGFeqbLfh5D6RZr
	iU02zqDXaQBCbUXLS5JXa1HI8M9QOEImPCAC1gAqfMPp4cMvN5kZppCSvo4WQ6WXxQ2r3NyYzim
	IRIcZ92v/Nk4Pler14mxOQZW2AFl6IyDmYaC25bdy3c1xrWKwHf95lmQfu6LRbLtcZAhL/bOtlz
	HIpupNa8YW4B+7aD3OxdenFZYobcMtNDgLVt8fidyBF//pWK/m/G6ek6QICX6wNS1RZGQ+j4k7g
	ve38A2HGzSfhG3LDOg==
X-Google-Smtp-Source: AGHT+IF8aIJx2X7OJz6+UwgJWzttQh3HN4r8qEKkoAECXCtprMdGPtLnD2KHE/zkfmDa28LIY15LzQ==
X-Received: by 2002:a17:902:ef4c:b0:215:8847:4377 with SMTP id d9443c01a7336-220d37151e7mr82187875ad.15.1739508772047;
        Thu, 13 Feb 2025 20:52:52 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5348f34sm21017955ad.10.2025.02.13.20.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:51 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 06/17] zram: remove writestall zram_stats member
Date: Fri, 14 Feb 2025 13:50:18 +0900
Message-ID: <20250214045208.1388854-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
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
index b6bb52c49990..c28e1b97bf92 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1480,9 +1480,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
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


