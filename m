Return-Path: <linux-kernel+bounces-384987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD549B3115
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F711F2234A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00A1D9A52;
	Mon, 28 Oct 2024 12:54:03 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23501E48A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120043; cv=none; b=YnS6I3weWLiXDoHqQRC7iq+g6YHwnEA2iS8gzWptD6iHGGTIXcXomiXSYBo6ABsrusZC0CHmZhSe9NwUIOOi0FGASIB2RWPj4mpdVwnLq+tqbwULd4Uco+PWF162ivuN9+WhccP5ZnEfE0oRvXSKUH0IKkScSokUwcvHG9K4H7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120043; c=relaxed/simple;
	bh=V3O64SwxXDnxNO4kw27eNVFasFBdRrQgpiVmx7vioa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euv9aNUa8VAU/LUl70cSn5/Inyd9pHGVr43s1DK7v+8HkcJe2Y6+ofodEEqx58SQyX4Z5/QjHByMTJIT0HouT/R+xBEI3W/+ap6ZyoiiRLM1qlnOBJgJcM8gdHr7pIFh95Gizg9XX+5DySgykR85o4MLqANr3S3UZ53DIVL3LPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1671f895a463-62d74;
	Mon, 28 Oct 2024 20:53:50 +0800 (CST)
X-RM-TRANSID:2ee1671f895a463-62d74
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2671f895d816-d9a0c;
	Mon, 28 Oct 2024 20:53:50 +0800 (CST)
X-RM-TRANSID:2ee2671f895d816-d9a0c
From: Liu Jing <liujing@cmss.chinamobile.com>
To: krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] w1: ds2413: Fix the wrong output format
Date: Mon, 28 Oct 2024 20:53:48 +0800
Message-Id: <20241028125348.3814-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The output format of the retries variable should be %u instead of %d

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index 739009806467..75c15a6a4fb4 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -61,19 +61,19 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 		} else if (state == W1_F3A_INVALID_PIO_STATE) {
 			/* slave didn't respond, try to select it again */
 			dev_warn(&sl->dev, "slave device did not respond to PIO_ACCESS_READ, " \
-					    "reselecting, retries left: %d\n", retries);
+					    "reselecting, retries left: %u\n", retries);
 			goto next;
 		}
 
 		if (w1_reset_resume_command(sl->master))
 			goto out; /* unrecoverable error */
 
-		dev_warn(&sl->dev, "PIO_ACCESS_READ error, retries left: %d\n", retries);
+		dev_warn(&sl->dev, "PIO_ACCESS_READ error, retries left: %u\n", retries);
 	}
 
 out:
 	mutex_unlock(&sl->master->bus_mutex);
-	dev_dbg(&sl->dev, "%s, mutex unlocked, retries: %d\n",
+	dev_dbg(&sl->dev, "%s, mutex unlocked, retries: %u\n",
 		(bytes_read > 0) ? "succeeded" : "error", retries);
 	return bytes_read;
 }
@@ -118,12 +118,12 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 		if (w1_reset_resume_command(sl->master))
 			goto out; /* unrecoverable error */
 
-		dev_warn(&sl->dev, "PIO_ACCESS_WRITE error, retries left: %d\n", retries);
+		dev_warn(&sl->dev, "PIO_ACCESS_WRITE error, retries left: %u\n", retries);
 	}
 
 out:
 	mutex_unlock(&sl->master->bus_mutex);
-	dev_dbg(&sl->dev, "%s, mutex unlocked, retries: %d\n",
+	dev_dbg(&sl->dev, "%s, mutex unlocked, retries: %u\n",
 		(bytes_written > 0) ? "succeeded" : "error", retries);
 	return bytes_written;
 }
-- 
2.27.0




