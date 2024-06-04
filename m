Return-Path: <linux-kernel+bounces-201392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C78FBDFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8B21F22817
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281B14C591;
	Tue,  4 Jun 2024 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HdUhTRCG"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB12142900
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536178; cv=none; b=PxX674eF2C8ucmQTuNa8TG2OwkZGuWZbC9287vWYMnFYADueDQEgpg7TMyjY5MiZJInKRxQEHlIE/ToFgBxtrFqxFSnVfFwIIxyWYnLPhBQLVjlyYj3Eq514BG/vHXZqVEOETKwDeIrlcW77Ga+wcE5z2/ffvHIgefBbNDkXbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536178; c=relaxed/simple;
	bh=RwnL/fVb3fxWF5xU1+hlDi7/ohtfBbLcJKY8CpcuiGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8voV/DW5IPuO6yh/G9OK0BxkJ1wZU6l1wI/i0ugxVvqBvoMdB6NQXXcxG9hMlAVd3+T/SG/yCwH8gEoYWkeZQ7cdmqWOKXYdeHswRJxq/SE0oB2HATZxK8UOyN4Uhv+n8yZPaEQdJZ8cG0TmS4Bn26R3FUkPze8t1zs8rhC9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HdUhTRCG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=hHM2yTb6jH238KQMlB0rLRIMwaywBfab4BIIdhDMmAI=; b=HdUhTR
	CGb3f+4iqMepYmiE+dJxLYb3q7Z0TSLKHHNSa1dsNPvtjP3vkQxGhUv04gXQ1z3X
	hENt2b2bBM6j7bSuWoIjHuOTlImtNro7Guy9UhaqpVzZMovl5F+v5nrPlEytEf/2
	XZAdfqM4N5r9dumQxHZfEeff7gf2Ox/pbTPYl+e3T9OxJ6v79WC4Azj2Pxojscr+
	lf452a6T5t4FZodZoJWCl8tQeeqbiy+rAy4fXrO5MuBKIMpNGEoWRvBjvgm4ZRaw
	TC5iWCx5LMZKJrOdVtVi4FGwV1tHVCxqdO36Hb6hklcdcFHtDP5ZvjVJwR4/rkv8
	H5/0NJvnpUjTwYtQ==
Received: (qmail 2449446 invoked from network); 4 Jun 2024 23:22:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:22:52 +0200
X-UD-Smtp-Session: l3s3148p1@73JoDRcauIFehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/4] misc: bh1770glc: use 'time_left' variable with wait_event_interruptible_timeout()
Date: Tue,  4 Jun 2024 23:22:37 +0200
Message-ID: <20240604212240.4529-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604212240.4529-1-wsa+renesas@sang-engineering.com>
References: <20240604212240.4529-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_event_interruptible_timeout() causing patterns like:

	timeout = wait_event_interruptible_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/misc/bh1770glc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 1629b62fd052..e1048d616306 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -680,15 +680,15 @@ static ssize_t bh1770_lux_result_show(struct device *dev,
 {
 	struct bh1770_chip *chip =  dev_get_drvdata(dev);
 	ssize_t ret;
-	long timeout;
+	long time_left;
 
 	if (pm_runtime_suspended(dev))
 		return -EIO; /* Chip is not enabled at all */
 
-	timeout = wait_event_interruptible_timeout(chip->wait,
-					!chip->lux_wait_result,
-					msecs_to_jiffies(BH1770_TIMEOUT));
-	if (!timeout)
+	time_left = wait_event_interruptible_timeout(chip->wait,
+						     !chip->lux_wait_result,
+						     msecs_to_jiffies(BH1770_TIMEOUT));
+	if (!time_left)
 		return -EIO;
 
 	mutex_lock(&chip->mutex);
-- 
2.43.0


