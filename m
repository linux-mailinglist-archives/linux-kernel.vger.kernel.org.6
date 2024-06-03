Return-Path: <linux-kernel+bounces-198872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D88D7E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DF328285E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2D83CB9;
	Mon,  3 Jun 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fQB2+Ibi"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C97E777
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406934; cv=none; b=ZDI4lQMcG1X3SA3upGbiPEp7IYzzewXe1VPbQ1EMa1Qq6IydizxQ+7mHgpRXv1emwmZKN+XB2NOYhNs9gTuQW4F0g2VdwTxVCD9kXqCxWY2iiTiKLL2CRHqOLeyClVGyHelQ4hxXDxVRB68zCCaVeeBIQQlAY1KA6PUTYVJkS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406934; c=relaxed/simple;
	bh=W8gUTFBPD+tA7+2ntE/n8EE7HfRzoEX/4t2fRFR4E9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioUuDX3Dn51ytRS1hN4qda0vXnRmvYjk5LxbQr0URWr+7oeZS9MgaGsEcJCvxV/usAoAsshbBKct2eyHI4QJ7wKUabNCBJ3z8DK27K2nYW2A66htnjEazSdJmDusOOIAzHaILCcmzFAHvcTPHfK80iJuIYAuHl9fTyTTpzhKAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fQB2+Ibi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=4+VZY6xjdqQ6MPEiVx+onjPOBE5C0+HNWuhGThWPvSk=; b=fQB2+I
	biy9mHMKRTPDStBkikrLnU0hfgMdvNhMT2rmlOYGYxMXc7N8l0yLOBYqZi00nOCF
	d1sLYdZL2KQxkzHaJF4gr6Dt94KuMWaXyY65PU/pDgVlHMu2ohgkQ4QHVjY3aaWc
	aPqLcI1PcUdLtzFY72c+KTYM5FOfkC1EcjsopY0u4C+w6JQmhy/9Cv7I9y0inDyY
	6+upC0BWM32QWgKLhRWQyP72RxMv1r7yPBac37aVZ1w/udPX8MYMnCYhmTHSj0M+
	y/ZXqwu6hjLpk7jEu9biTUq76Pnej8lFUptyt16nJwn1mb29q7DwMCztQloyMXOU
	HfY6NbPkwLbTEpdw==
Received: (qmail 1903205 invoked from network); 3 Jun 2024 11:28:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:28:49 +0200
X-UD-Smtp-Session: l3s3148p1@cWH69fgZMpEgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/8] media: fimc-is: use 'time_left' variable with wait_event_timeout()
Date: Mon,  3 Jun 2024 11:28:35 +0200
Message-ID: <20240603092841.9500-5-wsa+renesas@sang-engineering.com>
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
store the result of wait_event_timeout() causing patterns like:

	timeout = wait_event_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index aae74b501a42..adfc2d73d04b 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -822,7 +822,7 @@ static int fimc_clk_get(struct fimc_dev *fimc)
 static int fimc_m2m_suspend(struct fimc_dev *fimc)
 {
 	unsigned long flags;
-	int timeout;
+	long time_left;
 
 	spin_lock_irqsave(&fimc->slock, flags);
 	if (!fimc_m2m_pending(fimc)) {
@@ -833,12 +833,12 @@ static int fimc_m2m_suspend(struct fimc_dev *fimc)
 	set_bit(ST_M2M_SUSPENDING, &fimc->state);
 	spin_unlock_irqrestore(&fimc->slock, flags);
 
-	timeout = wait_event_timeout(fimc->irq_queue,
-			     test_bit(ST_M2M_SUSPENDED, &fimc->state),
-			     FIMC_SHUTDOWN_TIMEOUT);
+	time_left = wait_event_timeout(fimc->irq_queue,
+				       test_bit(ST_M2M_SUSPENDED, &fimc->state),
+				       FIMC_SHUTDOWN_TIMEOUT);
 
 	clear_bit(ST_M2M_SUSPENDING, &fimc->state);
-	return timeout == 0 ? -EAGAIN : 0;
+	return time_left == 0 ? -EAGAIN : 0;
 }
 
 static int fimc_m2m_resume(struct fimc_dev *fimc)
-- 
2.43.0


