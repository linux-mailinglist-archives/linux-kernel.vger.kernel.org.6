Return-Path: <linux-kernel+bounces-269325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E7943191
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A95CB23023
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBEF1B3722;
	Wed, 31 Jul 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="qVTpSZLB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772981AED53
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434355; cv=none; b=BzfL0euc0EiB0BnZTyJBnAB5acCR8XVwLZNoRthTEiu/PiqufEhovVuNRUE9Ye1AnI2c2cy0zuDDEGTWn4GdjknJ8IWxrKjUzW1MEn5amWIWSnCUtDRJXipAfP1pSiPC9ob5YJAP+bcW2PF3TqgQQia36TqqslbytknPwRVQbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434355; c=relaxed/simple;
	bh=6etOxoOt+Uv0mlCOS1EtH++jzIHf2RtrsgN5gME3owI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYZSIPme7NidY7Y+t0ncgszZmZjzHmQNcrBqkrpZQXID/ZSnFlJcKfrresvbPPw2+jc+MTRQqR6Ct6aOiccm2EVCFN3JD1Lc9wJzGwnStV60xhJ/kPYpZ5VB3PN0PM7dSbak6Zo8eNCKBQbdBtxniay41BhqhXH9SmUwCunzg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=qVTpSZLB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so29023255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722434352; x=1723039152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lprbpLX5iCNs3yfE0hQ92bHfdVj+BJgLJ/8w5c0+04=;
        b=qVTpSZLBpBUDffkt197Bed8M3geoWHfz6rTIW5fx/RVZ6851/3W8otCy2SQyUZXxfq
         88LgpWzb6wIsx1aomITtf20YUkND5nagJCCo3qFMUyU58sP94NIPTkWQ3Wni7ne4WhEp
         nx5M8PpHnMjoIxhypZs4Gy8aanRBaDM5MXO5SwsehywQyvQlCFzMvMiFPwTmPmy7+JDO
         2Ql4gxhpEzJo8chWwdVwo81AdBfK27cgT+tWI3kV0aaOvjXn/aKvL6Fv8XNiV70IhvFC
         8YNPsZTDGtUfLfwGByrWsLT1lEfDlc6wpl36iOyvdqRiWGFV9tVUrg5jK8bq1Jgk2okQ
         qs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434352; x=1723039152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lprbpLX5iCNs3yfE0hQ92bHfdVj+BJgLJ/8w5c0+04=;
        b=hr/k7H8i9tA4AD53WOTdv3swsni427I3Nw0XOfE6zfZW9vxU9QNfb0RCZdApIcllTO
         P1tY5aOTZTxD71LxZ+b8/pSimXbDxkOzyMRg0dWYnCCSQhxbj99u+2akPzmg2iqXwHpZ
         S3MIASxNrH41ZDw2+i3DpO3jJb5NSR6vPb2ta2jE63nppfjUj/dDK6YRh2emIX4DZuGi
         o/OIfTveeVDn4iGOIDxWDrdq4re9hcA9w1GZGonFFFudFKHadv7nCbLMQkIBBPFODZga
         0E5S7geS41c5kO1yXwoHFTBOp4xXAeVNl5sjz8baDZrK8rhgC2xRByzfNr2Hjv31H2ZO
         PmAw==
X-Gm-Message-State: AOJu0YwPLnyhDB8sPU+SudAIYD12oFwvG4+8XTQxlyL7opt9GZVZyFjx
	4UflQSWqSlR3dqy9vfjvCEYAkxMvXvdckakF5frwyVz2e8xYwNe/oB8ADn6/DMA=
X-Google-Smtp-Source: AGHT+IHwbNQ7kDa9E7p1dwhtAUL7lTtuLM/rc0FDjS7lRtc9Kd7SyT6zeX/UvQGb+jTugOi5IxrwbQ==
X-Received: by 2002:a05:600c:35d5:b0:426:5269:9824 with SMTP id 5b1f17b1804b1-42811ab2a89mr118059145e9.0.1722434351584;
        Wed, 31 Jul 2024 06:59:11 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b5fec25sm22714445e9.0.2024.07.31.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:59:11 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] locking/ww_mutex/test: Use swap() macro
Date: Wed, 31 Jul 2024 15:58:51 +0200
Message-ID: <20240731135850.81018-2-thorsten.blum@toblux.com>
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

Acked-by: Waiman Long <longman@redhat.com>
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


