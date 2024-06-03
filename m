Return-Path: <linux-kernel+bounces-198870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB38D7E86
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7217328331F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EE2823BF;
	Mon,  3 Jun 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bxG7t3kp"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690147E765
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406932; cv=none; b=q3l/qG5/cbzm5OsbTjUxKehWMcx4ZSICUzmU4fwzD8329+/p6WkC62/w1IhE+gDzD4DbzjJ8deBkMZqdbJ4jSSz5OlhLEaRqERk2/B664a4VDsz+UzKHdRDziRuJnw0rRNNrq9GDaI1gJLK1VmxoGBxxH3UsklBz10+4c3hLAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406932; c=relaxed/simple;
	bh=cPm8nay+S+hqLs3f8cNpHCw2GMY1g39P/OB0hXA/nCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6TllATAqZzJKcaSZNhiS4gspBWFVYX8Ya6HaA8bS669P3vIeeYwqFbA1D0OUCOERU531pXCwRvqj2Jt7kKHp/ObSMxnVCQCWCXUz2qrk9unEytGN4CrogFWdIbJGyTNPm67Na8KbBuoTfpV+eLK4mr1g0eLOPWcdk6Eu99vA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bxG7t3kp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=02MpfbTZVRydFuk89P1aOhV4C4DMB1o7ZOvFwGaqMGs=; b=bxG7t3
	kpQIQVQE3TWsriU15meiNvVk4iG7R15bW1JuP+JQ+n2TA97JXbcLpYzPrtEJ6ASK
	x27KQPobYtdMijUH6vr/ngZVV5fsZpJGiqyE0oWL/Sh7oWhOmNjI4IzsDauwY3pW
	J9yDTnW6nYeok7rzjcvRaGq3yWt3kWe2TWSOsEFFvfNSUprYU2HsObj7tfFpIACu
	e0zEntDSNvMTCfDx7W4qX3Lh7Vvgs1XgG7yGY/nG7me7Uz589p/OxbaNu9wloDsD
	wyWozHSOHXirX+cAfcKHJAW/vyiO6qbNI1bBU76iTxCbfLQJdjWx6KSujSQ5JEaS
	W2HnHXb8ZAJopRHg==
Received: (qmail 1903150 invoked from network); 3 Jun 2024 11:28:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:28:48 +0200
X-UD-Smtp-Session: l3s3148p1@8ZXi9fgZLpEgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/8] media: atmel-isi: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  3 Jun 2024 11:28:33 +0200
Message-ID: <20240603092841.9500-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603092841.9500-1-wsa+renesas@sang-engineering.com>
References: <20240603092841.9500-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/platform/atmel/atmel-isi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index c1108df72dd5..5c823d3f9cc0 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -242,7 +242,7 @@ static irqreturn_t isi_interrupt(int irq, void *dev_id)
 #define	WAIT_ISI_DISABLE	0
 static int atmel_isi_wait_status(struct atmel_isi *isi, int wait_reset)
 {
-	unsigned long timeout;
+	unsigned long time_left;
 	/*
 	 * The reset or disable will only succeed if we have a
 	 * pixel clock from the camera.
@@ -257,9 +257,9 @@ static int atmel_isi_wait_status(struct atmel_isi *isi, int wait_reset)
 		isi_writel(isi, ISI_CTRL, ISI_CTRL_DIS);
 	}
 
-	timeout = wait_for_completion_timeout(&isi->complete,
-			msecs_to_jiffies(500));
-	if (timeout == 0)
+	time_left = wait_for_completion_timeout(&isi->complete,
+						msecs_to_jiffies(500));
+	if (time_left == 0)
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.43.0


