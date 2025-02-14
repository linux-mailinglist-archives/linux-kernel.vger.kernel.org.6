Return-Path: <linux-kernel+bounces-514355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F29A355E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B463AD95F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F21953A2;
	Fri, 14 Feb 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g9au7z8L"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE144188704
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508784; cv=none; b=T1nxGRfikoNLKD1CAYLqwLxPS5WHT8RmjwDeE2E2uUVuI9A0J5vFb8IuKsf6+mgXXoeA1Ftp+fFzdf0VSz2uC4XM2Esqe8VQc6JB8DVb9VphdX1VeEHu8tJz67TuLdQsRgFWrC99q03//W78WtJeJeblGFM05ih47OxsvrUYzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508784; c=relaxed/simple;
	bh=apKzz45NLBZ9ql4LjJ2iuBWBMPcIN0crE8B9KnkiBDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGa2/7ia+UhaqcrclAtnTmWzGDyKL/zY4+7idcd+6ooLdZu+cYmOGvDoguR2z9EjIeo1EKfBgauk/kMtRlntvwTrEbsI7xYbKaNBqDZGw82NmSlfVtnsKo452LDbqHDy/IKoH0nZnqyvC8/LSmdhUWxr8OK6Q2aIaJ1fdFdxciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g9au7z8L; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e6028214so18853545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508782; x=1740113582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8qIWvBqgXd04+Bt3tanZdpv0pd6FYzP6TsmdRGZtIY=;
        b=g9au7z8LcDi2GDTzvW/TEAVJ+GkvJFloBERZfmuxf+3n6vLWZ9fMpN6ZM/haehTaE4
         Lp8fjkkRIiYe274IVrs66Jg9ujChDU7F/OiVAZAhqJw+w+YLbwWjwyEYF/qjZtaoSoA5
         T3tzXqcZedt/g/UuNVkAcS17W2Q9bwXf6/Zjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508782; x=1740113582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8qIWvBqgXd04+Bt3tanZdpv0pd6FYzP6TsmdRGZtIY=;
        b=ehNo3wLNycgwcW5E7rEzcOoX2Lhl1wbBORw/elJlP4R6WLMzZiLSHV4EH1eh9eDYDd
         y7JQnXYfIMselR5k7E6Ai1Pz/22NQdttxwyrztefm4ShM9Wz3Xsnb7SjKfdDXN7JM6vb
         W+v1r/zeN/40mU/g3uS9taV5LWvfzQr0XtC6DZrbqDdHlbZYHx8Ov6Kpg9tmW1nqgTR8
         6eJ1J4n6Av3/4L65K2tELQfB+r+x1jpVh0vX6/dEY8Yl8wmHLxYnw5pyz7ZkXuxZAKBp
         lNn8ZbSJqpw/FusvTtbsnSQ1IYNChbZMdpUcqW4lTabaOyqc7hoXUC+ykSYG1wTtIvnB
         TGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT+WBHe74RMtuH+l9TAje27lrtn6Opvn82iROaGcUpTXHN04ya6CuAjoEZYv4NU+P7agbaetbzzoJ1qec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WZ2PI4MmHMfeegV3iY/ezTmozAwclKNYyioGcGz8rJM7ZPsC
	PiYeRPBqDoZ6pzsLAa1Z6Hqayt6XMEsD9VUz2LWCWEDi/CV87oxsbg+C1tjtlw==
X-Gm-Gg: ASbGncvMOUMJOroYi5XtvePob4FqbA/CIdhNq88qEMleUkeXkrGjho/G2NbnmZG+8GY
	ueTx8J/KjNp5DYzO8lviHuNdoD24PGejWyTu2pcRNs5yPl1yiyN4/I5UNAwc43YUJIvm7RgH8YS
	wOgBiZRTTHlB4UhrhlXZcFquxoRFqAwzs+5C4IWJRJqSXUvm4lQUhrDFwhZjZiqNqMa6eE8UcGU
	zKSZsAMQ9RC3QsshQA1EE168DALOlp8n99FBqdfQy6UyCxZohBFv2cS3v/V0mqUrWCoNKgs3FVk
	qzNPftlJqadKySr6fg==
X-Google-Smtp-Source: AGHT+IHUcQM2DJmewLKGuE+CMu76WyyV+1GS8gtwww+ICNVj3SW61vpHXjXYA/HCtx5vMpfKv1a5mQ==
X-Received: by 2002:a17:902:f707:b0:216:725c:a137 with SMTP id d9443c01a7336-220bdf56c72mr172323375ad.28.1739508782199;
        Thu, 13 Feb 2025 20:53:02 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349203sm21043715ad.29.2025.02.13.20.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:01 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 08/17] zram: filter out recomp targets based on priority
Date: Fri, 14 Feb 2025 13:50:20 +0900
Message-ID: <20250214045208.1388854-9-senozhatsky@chromium.org>
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

Do no select for post processing slots that are already
compressed with same or higher priority compression
algorithm.

This should save some memory, as previously we would still
put those entries into corresponding post-processing buckets
and filter them out later in recompress_slot().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c11ed2dc23aa..5f8e963bd513 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1864,7 +1864,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -1896,6 +1896,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode,
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
+		/* Already compressed with same of higher priority */
+		if (zram_get_priority(zram, index) + 1 >= prio_max)
+			goto next;
+
 		pps->index = index;
 		place_pp_slot(zram, ctl, pps);
 		pps = NULL;
@@ -1952,6 +1956,16 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	zram_clear_flag(zram, index, ZRAM_IDLE);
 
 	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
+
+	prio = max(prio, zram_get_priority(zram, index) + 1);
+	/*
+	 * Recompression slots scan should not select slots that are
+	 * already compressed with a higher priority algorithm, but
+	 * just in case
+	 */
+	if (prio >= prio_max)
+		return 0;
+
 	/*
 	 * Iterate the secondary comp algorithms list (in order of priority)
 	 * and try to recompress the page.
@@ -1960,13 +1974,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		/*
-		 * Skip if the object is already re-compressed with a higher
-		 * priority algorithm (or same algorithm).
-		 */
-		if (prio <= zram_get_priority(zram, index))
-			continue;
-
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
@@ -2191,7 +2198,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	scan_slots_for_recompress(zram, mode, ctl);
+	scan_slots_for_recompress(zram, mode, prio_max, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
-- 
2.48.1.601.g30ceb7b040-goog


