Return-Path: <linux-kernel+bounces-384992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C519B3124
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCF5282317
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3D1DA10B;
	Mon, 28 Oct 2024 12:57:59 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ADB1DB362
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120278; cv=none; b=gZRf7paic0CV64FgcOoUsNp4IxuF1dd1uMfd9qsBF6WdUJtUy4Fm+lh0A4h4rVl5Y84uL8uczVp//J3AVE96v+kdDX114W9rRjIAQhveUOauThJS2aaft/EnPHuH5tUtZBxYN/7cDreWYc8Ny0kh7xtBekfilQB4ssr8ln/k/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120278; c=relaxed/simple;
	bh=1sfvlfJGLVeZd5g0xiyW5FDpPNKxTpn9ii8P00//Azw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N18eBHLGQHBkNl/qBOEQzxGBfx/b3G4VvB0nl7F/rvrcMO7NZrFbLBf9NlGnzWaiisNzVZ4DKDFwXIb29AYJQzJBtucmMMepH0d4FBWgl0dhXBMFlwkyteb2Y5h9kHvp7kyNruB63trsPQYPxBtGhSrI5syD/QCsBA489Uue2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5671f8a4d276-92286;
	Mon, 28 Oct 2024 20:57:53 +0800 (CST)
X-RM-TRANSID:2ee5671f8a4d276-92286
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6671f8a4fbaa-dfdf9;
	Mon, 28 Oct 2024 20:57:53 +0800 (CST)
X-RM-TRANSID:2ee6671f8a4fbaa-dfdf9
From: Liu Jing <liujing@cmss.chinamobile.com>
To: krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] w1: ds2408: Fix the wrong output format
Date: Mon, 28 Oct 2024 20:57:51 +0800
Message-Id: <20241028125751.3948-1-liujing@cmss.chinamobile.com>
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

diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index 56f822a1dfdb..1efe55e1dd8a 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -199,7 +199,7 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 out:
 	mutex_unlock(&sl->master->bus_mutex);
 
-	dev_dbg(&sl->dev, "%s, mutex unlocked retries:%d\n",
+	dev_dbg(&sl->dev, "%s, mutex unlocked retries:%u\n",
 		(bytes_written > 0) ? "succeeded" : "error", retries);
 
 	return bytes_written;
-- 
2.27.0




