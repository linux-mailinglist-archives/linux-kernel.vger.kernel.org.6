Return-Path: <linux-kernel+bounces-218777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D00D90C5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E205328333F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F315E5A6;
	Tue, 18 Jun 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KBPxzj8N"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB588121B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695944; cv=none; b=HJJuCXWpzepu7lrRfzBTsJeDa+NtizdaOgsWRQN3Ke7TOprWw7JXt3sRsv6MAmQsCmZQSA2y/27ahrzS0Quri1mnbDorG9A9PcpYXkLKmGqAnjomE9Xq2Udh49wvZixQY/8mzvY2O0GQw3ujKBkKBOdITdr8Rlnxl2UHcn9gty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695944; c=relaxed/simple;
	bh=ZktBFOwRuY4aazY7UdEZiHGUio1mtMqQO3qrKch905U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGxjGTYI6RfouhGVAAyn2fbicoAAQJHT7QYoYA8Ub8N7D/tjEh3bcIb1m1uQhlDjoax/sVXYp3IHUaVmv1XWQwfh7VARmQzrXiz2z2JdC4qNm7FrZHczUOsiEePPdwWIRZSf9A2eWwe7fc2fqXBmI8sv9Wjm9iYf/vgUXGh8QEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KBPxzj8N; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718695932; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2Bh1cp4ZF0UufDuRsrdOwB5rxLCrk3UpNkP4y2knrHg=;
	b=KBPxzj8N+3v+P970ICFyt2O0yfYBKBGmiTEWACxhx7pWkvrwXa92paJZa4npWEFlLY6h6pqgZbnoAhRA0iOBVlth+yxPzWdxvw3G+Qtbkyc3gluI7lrlola+mQGcrp6TKiVS2OjRgV/t3F2Os4xVb7WLr4jd2X09uMZpp87/oF8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W8jQc3J_1718695926;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W8jQc3J_1718695926)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:32:12 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] zorro: Use str_plural() in amiga_zorro_probe()
Date: Tue, 18 Jun 2024 15:32:05 +0800
Message-Id: <20240618073205.65303-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing str_plural() function rather than duplicating its
implementation.

./drivers/zorro/zorro.c:155:22-39: opportunity for str_plural(zorro_num_autocon).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9350
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/zorro/zorro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/zorro/zorro.c b/drivers/zorro/zorro.c
index 2196474ce6ef..2fca9115fc73 100644
--- a/drivers/zorro/zorro.c
+++ b/drivers/zorro/zorro.c
@@ -152,7 +152,7 @@ static int __init amiga_zorro_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, bus);
 
 	pr_info("Zorro: Probing AutoConfig expansion devices: %u device%s\n",
-		 zorro_num_autocon, zorro_num_autocon == 1 ? "" : "s");
+		 zorro_num_autocon, str_plural(zorro_num_autocon));
 
 	/* First identify all devices ... */
 	for (i = 0; i < zorro_num_autocon; i++) {
-- 
2.20.1.7.g153144c


