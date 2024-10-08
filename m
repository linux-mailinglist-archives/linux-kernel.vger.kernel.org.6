Return-Path: <linux-kernel+bounces-354695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA6899412B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B24B275A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D51DFE18;
	Tue,  8 Oct 2024 07:48:26 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DC1DFE13
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373706; cv=none; b=fnOojzkAJukal8rkMZd86zY7APhFjnaFCL/fRrk5vZ6+HkfG6Buvq5jnayX6FCfUCC+3BifdjSKJJaWyFQwo5Gb4ceiXlx41ZIY5DYPMsllUs+LmQ+SJgIpPyn2OQ7e9f4k4lXPt61FwWkBOXozcy0wcOJShre2j3NGXwR3RIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373706; c=relaxed/simple;
	bh=U4RNqZMO+XDnA5iEgUA3kGJsOHY8X6hnN3awHGhxuFA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gyJaLfdHCB9KHaeM387M+QnyOn3LTlUSUnQe+SHhPnl0neIi7OAYg9yL0seFRq+E+LvTVvV97T8rC1YYQWXUDwiVoKnV9e6yalHWeB/W2RUa1eX0Nl1Z/axn4gXEQB/KwuJcUtc9+rcl/e33Ok//ZjAC6yDZL+pMK331SgHR1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26704e3c1068-18075;
	Tue, 08 Oct 2024 15:48:20 +0800 (CST)
X-RM-TRANSID:2ee26704e3c1068-18075
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36704e3c3800-9739f;
	Tue, 08 Oct 2024 15:48:20 +0800 (CST)
X-RM-TRANSID:2ee36704e3c3800-9739f
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/applicom:Remove redundant ret variable in ac_read function
Date: Tue,  8 Oct 2024 00:48:18 -0700
Message-Id: <20241008074818.13335-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Removed the unused variable 'ret' from the ac_read function

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/char/applicom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index ea25caf35346..ba512d8dffba 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -536,7 +536,6 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
 	unsigned long flags;
 	unsigned int i;
 	unsigned char tmp;
-	int ret = 0;
 	DECLARE_WAITQUEUE(wait, current);
 #ifdef DEBUG
 	int loopcount=0;
@@ -567,7 +566,7 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
 
 				/* Got a packet for us */
 				memset(&st_loc, 0, sizeof(st_loc));
-				ret = do_ac_read(i, buf, &st_loc, &mailbox);
+				do_ac_read(i, buf, &st_loc, &mailbox);
 				spin_unlock_irqrestore(&apbs[i].mutex, flags);
 				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&FlagSleepRec, &wait);
-- 
2.17.1




