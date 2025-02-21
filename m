Return-Path: <linux-kernel+bounces-525494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D758A3F09D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884A87AC178
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55182205AAA;
	Fri, 21 Feb 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ax9S6Egt"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A907205AB7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130758; cv=none; b=RKeWutf9el4spqEB18r2+KkhXpqRHpF/xGk2iJ68VR0+UhKM94btMFMZ/lRK8viGIsKDRhOFzrI8Zoi0bbL8puUVMYMIYBotUzUq1I/sxMWNsLq1lVejbsPcG6CZtEf4AeGP0YS+pyhAHX0eBtP2XXbCI2AbkDoeMi92fv1rHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130758; c=relaxed/simple;
	bh=D2RXmiMQ7nvS8i/c65PWOhhdODZX0+hRDUtMrs8HH3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOhGCl29/jVEDsaludWDkAoCqum4HTJHv19CY3vrnSnbtYqNI2otp6gwcafS7UTeGPx8kgO/QsB8wQ9mg9RXxgm1yH8yNWbNu0bzlOwDAPh7rYbKB2Rf7s6Gmt03S8zL68ajsuChGmCerKNnhp2Puqoet+nhRfJOP/VQiNsArhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ax9S6Egt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22104c4de96so31185515ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130756; x=1740735556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWUXn5zzM3sEuYVHsX5O+HQ9Km/ronw7RO7r8BNsmmQ=;
        b=ax9S6EgtqWCoysktg9LvTcDqZMBwfx1tVn4CooAZ9h8zJ8IqGJ+vlwedHPXENGgCuL
         dtwQ1bUb13CEG4BVVNmEsqUPRwLHoQrvYAHMHsZ+W+Z8YkrnxCh1kjrOIwVn7kBVper6
         SFS681Fn4eJw3qPYQWWLqH+gE2mzkBAFSRpA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130756; x=1740735556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWUXn5zzM3sEuYVHsX5O+HQ9Km/ronw7RO7r8BNsmmQ=;
        b=nHr0DYwPIaI25dyks/Q8UIRCOOZNMnyqVurkKretxT9MZhrdqu9rqyknY4UCc75oUE
         fR8L3Y4fcdMygYJMm9AevFhWiRLbnCP4L4Vw3gz9COEF73hI43S4gfZbbw7K8+tCzQ4c
         z5scTRRVJhzaQBHrDrTzRDFZOLe9PK5ceCkxk+yph0jY6hCC/BdoDaFZg22YK/StXZy+
         Ev2Aj4yIg0H1w/oBC2MrU8fJpu6ly/U86wnaG6cjIIjLGJlZBHiJhBxDfOJXKeRGUyLW
         FsdI58iRQa4h+Qmx85cibl3O3+EbdKEFvPbQjrEcr2OLIGJfqVoqw2QjHLGIs9FFwvfD
         lfxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3TrK7wW678Cf3ZvdvhnCycoqh4ze9SnkmqT+wOY/KyaBTd1IsFGLEZbWh3Zgj6x7YVBTd+z0Mq620ze8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2KqV1d0mzsOiORufcRoVuUuuKQc+rC0MvLsvFhlPy4N37Wfqh
	1AfRQl5gzqLgIvjf2YJnU7PMRWJjyextskQLuMutNZosV9m+OCkX0DKjM+gTfw==
X-Gm-Gg: ASbGncumToJ6lOdHiCQS8/yj+fxdKFIG4cnI64bWsOCEhlmsv2miEp4I2ZKkEtWsoaJ
	VZarrXRqC+IBrZRbzS2NFjwXmHPAUPVlPXUDXgLBxWwaIKTZJpG5WujkL4pRjmYgggzMz+6P65T
	mOrvK3bs987rZ0jYBjyPaKrEg4RfXNRs2H8kfQZBzwW7Nsvjg2FMnpB8TLyYAM4eShpZG5dWzpn
	eeQHlkxg/WbbZvjf1VPDRIm/jA29tMwn7h0SFpswZ+hZEaiCXDpWDbOz5Pji9Sf0k6H1BZqe2ZU
	u2u19Hftb5WQuOln9DuFW/5y7Wk=
X-Google-Smtp-Source: AGHT+IHVbAaNiCZXUdV+FymTI/dwqaElFp7dSQG1wMJdlZh6amw8nQFYdiY2vLz0zNb+VFzK/PfYdg==
X-Received: by 2002:a05:6a20:9144:b0:1ee:db10:a4cd with SMTP id adf61e73a8af0-1eef3c889b0mr4622607637.13.1740130756632;
        Fri, 21 Feb 2025 01:39:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73287ac0ea9sm7967823b3a.152.2025.02.21.01.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:16 -0800 (PST)
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
Subject: [PATCH v7 06/17] zram: remove writestall zram_stats member
Date: Fri, 21 Feb 2025 18:37:59 +0900
Message-ID: <20250221093832.1949691-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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
index b805a3661101..f59fea0f04ec 100644
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


