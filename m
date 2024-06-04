Return-Path: <linux-kernel+bounces-201391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967698FBDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7841F2288B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E814B976;
	Tue,  4 Jun 2024 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SGJeqYyT"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26114291B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536177; cv=none; b=eo/QsdwRg9Yn7elyG6XBvWDf/lobGIjOqm4GNC2VL/BMfAC/4CVFU4dcJdEkP0ATGREG3tRO3oHI3pn3JmS21neEqr0w/ttrZNFHBu02eC0GmXsw3axrg2jPPMW8t+Y1YGnUrEEmrNQmIlwBGJLuH/E4oPJ9oCxJIE9MBOwAJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536177; c=relaxed/simple;
	bh=yi1+PN0Q2KuKxDPrpZS3RSPuvsy4y8L2mEsSu0fR8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCPDZd5VbhBtsh73cy9V0CF+ToWD1G4nfoawrNrWuWICFO18eYxs+d1FduVN9Uoe51n18N4ote4Wfp5b5CT00y6FyWnLYw4Y9fgROiBJSXCAPvt8bHbeA1qdG+JYPf2YtK55LDi6iSPR6fNDY8y3RAABft8PZHnwqozMN/qfxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SGJeqYyT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=zu7xx2eHQSEtaJ5y0DAt4wwj31+TtPnP8i/Xy8v+7Ig=; b=SGJeqY
	yThEn9NkcXEnONbyRjyQ1Mm/zLakWb75IfNgpqnVOd6OgBkAQs0pGFawtjP/cYj9
	OPt3z5vvW0vVLUOJvfwurCLtwWWcdSGf8CzIgJ4p6nm0XDVSyN0t5vPb4bzHNt4A
	KMq4PLmMRRXwQpuRSBnTPc86Wqh90TJOyf/tlS8K8vJN8XgKScwayiZ1nsxBA9DE
	SbPLK976XN/cddVo6iUH5X3is1LH1MZqon939mRpwA6feavo3WCiGCoadTb53lx3
	PZc8MSrVv08PGKdwjeW2MQxlHkyRLfL+YN9NuU3+rsnPjtZr7jsA1tcBaBntTGIc
	WlU97MmOAH62hHqQ==
Received: (qmail 2449422 invoked from network); 4 Jun 2024 23:22:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:22:51 +0200
X-UD-Smtp-Session: l3s3148p1@QHpcDRcaqoFehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/4] misc: apds990x: use 'time_left' variable with wait_event_interruptible_timeout()
Date: Tue,  4 Jun 2024 23:22:36 +0200
Message-ID: <20240604212240.4529-2-wsa+renesas@sang-engineering.com>
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
 drivers/misc/apds990x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 92b92be91d60..5fb29ebbb422 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -625,15 +625,15 @@ static ssize_t apds990x_lux_show(struct device *dev,
 	struct apds990x_chip *chip = dev_get_drvdata(dev);
 	ssize_t ret;
 	u32 result;
-	long timeout;
+	long time_left;
 
 	if (pm_runtime_suspended(dev))
 		return -EIO;
 
-	timeout = wait_event_interruptible_timeout(chip->wait,
-						!chip->lux_wait_fresh_res,
-						msecs_to_jiffies(APDS_TIMEOUT));
-	if (!timeout)
+	time_left = wait_event_interruptible_timeout(chip->wait,
+						     !chip->lux_wait_fresh_res,
+						     msecs_to_jiffies(APDS_TIMEOUT));
+	if (!time_left)
 		return -EIO;
 
 	mutex_lock(&chip->mutex);
-- 
2.43.0


