Return-Path: <linux-kernel+bounces-316636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B5A96D238
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1352C1F2A22B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97024195FCE;
	Thu,  5 Sep 2024 08:33:33 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570F19342A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525213; cv=none; b=R8rghAJ10/JV31eV9yd8UoNYYGoASqcNcJQ6CNuci9BzVMKNW8bHVDXB4HH8wdUFaCMwu4EdAqzOl6LuIV6C5Ezw06mGU2x37DhQabjhh8oNVFhR41QtkL8Hc3WyyjzBlGy0ADZ4lMtITqTOZolIzXmJIIO4Uym6u/FPrgUw+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525213; c=relaxed/simple;
	bh=xnLXHMrWQ10KcdsRtBZ6lIkI233B2X1/41EgzqSAEOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hh09Y7uUpisBXiTjJufYb3SF64sBn8J+ODBagZf5hvmSRlqIo7wxe3CEVbya6+rJFSABH90cqV3LEg9jq05pJOG5r0qDiVAgc8/OzRt6aQbQ3aFz8vQ76VyBOzCMtit30BdbRjeADJgyRKQrzgMRLsSMpLanKLlTaIvSA0Rh7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466d96ccf636-bdf2b;
	Thu, 05 Sep 2024 16:33:19 +0800 (CST)
X-RM-TRANSID:2ee466d96ccf636-bdf2b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266d96ccea1e-6957b;
	Thu, 05 Sep 2024 16:33:19 +0800 (CST)
X-RM-TRANSID:2ee266d96ccea1e-6957b
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: clemens@ladisch.de
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] hpet: Fix the wrong format specifier
Date: Thu,  5 Sep 2024 14:51:59 +0800
Message-Id: <20240905065159.45774-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The unsigned int should use "%u" instead of "%d".

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/char/hpet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index f6c92106eb98..3dadc4accee3 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -865,11 +865,11 @@ int hpet_alloc(struct hpet_data *hdp)
 	do_div(temp, period);
 	hpetp->hp_tick_freq = temp; /* ticks per second */
 
-	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
+	printk(KERN_INFO "hpet%u: at MMIO 0x%lx, IRQ%s",
 		hpetp->hp_which, hdp->hd_phys_address,
 		hpetp->hp_ntimer > 1 ? "s" : "");
 	for (i = 0; i < hpetp->hp_ntimer; i++)
-		printk(KERN_CONT "%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
+		printk(KERN_CONT "%s %u", i > 0 ? "," : "", hdp->hd_irq[i]);
 	printk(KERN_CONT "\n");
 
 	temp = hpetp->hp_tick_freq;
-- 
2.33.0




