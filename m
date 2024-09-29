Return-Path: <linux-kernel+bounces-342736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1049989268
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC881C21C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA7B65C;
	Sun, 29 Sep 2024 01:27:04 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC68AD5A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727573224; cv=none; b=Ne9/qXM/xOOH3+80AadaXpulMysIpEjSxFrigeBFQJ+Gpboap/psEvnWumwyOUCS/2y+r52TvcQ5AxKSzp8tzkQtsi5zbG5GhM0EPWUp+qiUwYbon7xG+aJkb1eoiASZCr599LOOdZ2YCs9+0NxM2qfWePQVKq/167G6S0u1s6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727573224; c=relaxed/simple;
	bh=Caof0X416H4CTUZf3tGBv5D+uHh+u+Ryv32FAk9zST8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n9nm+U9sOd+L/oFqbSv1/YjDGauuDEea2OghUDwT72PR0l6T0516xNX8aOHsloZ1+d/T+l43h4flIipxOhb6r5XV4FpfTFvFqxkTTHuaBxS1HVMr+A3BVgsuFb+ahHb7m4t206ZO6V7Yt1iQZ1reU8M3z7th5eLLSHTJR5nu9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id ZAC00145;
        Sun, 29 Sep 2024 09:25:45 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201624.home.langchao.com (10.100.2.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 09:25:44 +0800
Received: from localhost.localdomain (10.94.12.73) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 09:25:44 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <rlippert@google.com>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>
CC: <u.kleine-koenig@pengutronix.de>, <gregkh@linuxfoundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] soc: aspeed: Add check devm_kasprintf() returned value
Date: Sun, 29 Sep 2024 09:25:03 +0800
Message-ID: <20240929012503.18636-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2024929092545f7c10c333fcb45562c92aa29f2280cd7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure in
aspeed_lpc_enable_snoop()  but this returned value is not checked.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 888b5840c015..68317b2e44b5 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,6 +200,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name)
+		return -ENOMEM;
+
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
-- 
2.31.1


