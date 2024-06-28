Return-Path: <linux-kernel+bounces-234432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11D91C692
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9721C21F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217774055;
	Fri, 28 Jun 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="DXWpEGv2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301591B94F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602962; cv=none; b=syb7gvY/QniQutXKeNuKQA+aPxPCBja/KwQDjlS8YGMYPW1q8yDimR1a/aY2EDfWemerpVO1FdJ/lN9Gb2ictgN7RdEncPQ9Y/GkVaG9g8jYtJBq6bFtcxpL1zxPUIrJcVEBZy/c9UBkkXoIao7grAP+MaRgayRtCUVZGrNH8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602962; c=relaxed/simple;
	bh=2COqgV8Z6yYne9fkPjb0q11LPjnQF04bfLYp3PbwNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=As+5w1Nak1LPyTMdagCrw9uDZvfPLPd4eu2hpcuO9o3AUEtvLmi5ZleawBQJV+kvosUr1EqxGgexJmK3HmNC/jmtZVbVP/o7u2J84yBZ0BLtHu0YNgzp3VKdFVu5d2vcQxSpHiguLy4aoqd66rAN4QE1aWoshR/PrDoenxzovlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=DXWpEGv2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9cd92b146so6115415ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719602960; x=1720207760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xPRpsgl/H+8pkY47exDM4qJKohWo7yc1tfpOseq8z8=;
        b=DXWpEGv29Cb4R+6l2MfqIDK9dHKOuPrbQAzI485L2Ev4ko6o9zynFerVo4nuWQvb3M
         MPxiQMctZyzR3G0v1f3o2Lr7YdLSvEwL7Br+VJnAqFwPgQeBUh3T9R3acLU9rgsJ/Z5a
         +lsiofwvi2doFifwjaiMQ/roRmUziaNvBAWPzVIME8klQ+s3kpTfAGZbAuEgqe/IlAZ2
         nCmqLTasENbh48U216fbAApSp0mz06Z4EqkkKgPoMlKLFR5q+mFSTgS8grLp+CEi3rf2
         Ln2SEsuB9vEZ72hFwTMg4zWajZiZ9oy9xEsFHD8r9UcHOk2DWGpFT0iMfSffUky29JLD
         sLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719602960; x=1720207760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xPRpsgl/H+8pkY47exDM4qJKohWo7yc1tfpOseq8z8=;
        b=ou50KOI/iAAiLadpbvG1ln59Sy4oN3eMtceF7puK6E3YiMPtjQGCFzpzdiwzx444kt
         3ovL0Hk5RSzxMYSPohDe2omJEyAGC8xI2vXqLAMdPNvLGZ3H9KLXegdw/J1hH57PaToC
         0vFKvhQaVngMmX4eTzd7/jhes5K/WkT0pErOWV3+RxOyFDl1JY3FUOBKsGR30E8aLdFp
         afLzp2jGBE6QaDqoGct8NYHkLyP4kRopoPcwtjoHSGGAZcOaMNL+JOE8a7bJK71cLg1E
         VhQak6oADZu2M/uOXBYDU9wU0jHY+Dl4qBpUFnaZ9yH1GIHjo03uVhVj9kZja4oXKevU
         DLxg==
X-Gm-Message-State: AOJu0YyWDeyckSPMy3TwcU9zOnsKEIzgmFfGibkLUqClvOXgMiyT0nlb
	9JTkkcdTQ+ZUXv36PGDjrLUZDZE3axVXW7l2DXjqTsdMKf0i2o3WMArDZMwXw5g=
X-Google-Smtp-Source: AGHT+IGN4V3WQ+bZg/hIDvfL1eE+CSZDNCRpj2FF5oibFSD0nwx2qai+UXKuqCwfy67ORNtNAQbdyg==
X-Received: by 2002:a17:902:f685:b0:1f7:2050:9a76 with SMTP id d9443c01a7336-1fa1d3de5bcmr216527205ad.8.1719602960477;
        Fri, 28 Jun 2024 12:29:20 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f1asm19095985ad.48.2024.06.28.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 12:29:20 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] locking/ww_mutex/test: Use swap() macro
Date: Fri, 28 Jun 2024 21:29:00 +0200
Message-ID: <20240628192900.542196-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/locking/test-ww_mutex.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 78719e1ef1b1..252bef786aef 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -402,7 +402,7 @@ static inline u32 prandom_u32_below(u32 ceil)
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -413,11 +413,8 @@ static int *get_random_order(int count)
 
 	for (n = count - 1; n > 1; n--) {
 		r = prandom_u32_below(n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+		if (r != n)
+			swap(order[n], order[r]);
 	}
 
 	return order;
-- 
2.45.2


