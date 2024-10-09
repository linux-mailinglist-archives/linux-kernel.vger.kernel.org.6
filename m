Return-Path: <linux-kernel+bounces-356349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769C995FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891671C21D97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B28154BE3;
	Wed,  9 Oct 2024 06:32:27 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C255E53
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455547; cv=none; b=ABkBBEMFUDJjQDs1eDdx2FYTy5wNTWp/93OicFDOdbX9mBtRYa3o8bDYnMi7z//JZFWAM84eCg9pvZfFOxgewUm+qgZeYTxHZgEFTwSVivfso80mouZwuL8quEcbAswkg6JQnxN8VKLMPwWiqhNL37PV/a+sSG8ChxcLhyrR7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455547; c=relaxed/simple;
	bh=6wC3zVEV3ldeLog1VKYhEsAa3M0fukauiH2/kcXB0K0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=imLGlPj+nLfjvk3Diss9c3aQa7b24Buk12yK16+XN8jhOVnMgnRk+imnyN4w9Ny4T2I/wY2gXYyoIozke/kpOOXBCXSzdMoWAbEEiGRL0M6/R2S3Gk/nr0UWtmfFlD1ChXUR68t9yGN/JsmHQ23Bd/gxBD+f55LQoW19Nw+5zaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2670623746da-206ef;
	Wed, 09 Oct 2024 14:32:21 +0800 (CST)
X-RM-TRANSID:2ee2670623746da-206ef
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee267062374d3b-e1efe;
	Wed, 09 Oct 2024 14:32:21 +0800 (CST)
X-RM-TRANSID:2ee267062374d3b-e1efe
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] char: applicom: Remove redundant ret variable in ac_read function
Date: Tue,  8 Oct 2024 23:32:19 -0700
Message-Id: <20241009063219.6212-1-zhujun2@cmss.chinamobile.com>
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
index 9fed9706d9cd..17ff89b15f56 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -539,7 +539,6 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
 	unsigned long flags;
 	unsigned int i;
 	unsigned char tmp;
-	int ret = 0;
 	DECLARE_WAITQUEUE(wait, current);
 #ifdef DEBUG
 	int loopcount=0;
@@ -570,7 +569,7 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
 
 				/* Got a packet for us */
 				memset(&st_loc, 0, sizeof(st_loc));
-				ret = do_ac_read(i, buf, &st_loc, &mailbox);
+				do_ac_read(i, buf, &st_loc, &mailbox);
 				spin_unlock_irqrestore(&apbs[i].mutex, flags);
 				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&FlagSleepRec, &wait);
-- 
2.17.1




