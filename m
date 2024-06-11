Return-Path: <linux-kernel+bounces-210305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64E90421E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116641C20862
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC92142067;
	Tue, 11 Jun 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e37o/8pj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0940C03
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125502; cv=none; b=tzvmNEyzCJB9Mm4r8Q9ipQtGZUa5FOpjM0by+hasNXrbhbMNN0WoRQJkN1GYgT6IRTxxprPPvquwgwoky3RPBsyPUPEeH/5Y7CQJhGW8qW2RvBO55+DN8h1WajBQ3lKoszneoG34GYb2fY4wL1xQdj5+3y0UtQwj6rkL55yEOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125502; c=relaxed/simple;
	bh=v1ZNq4JwoYhwZQR6SFYW6CMOzV82UJ7h9T7rF03L/88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R3VSICzjGyqoqwSdhcLw7qMyZO3MM32ez6tRxn7i2ckOjmXBjo7ChfqfzGT0npn0x2RI9Xw1j/vo4VDCoxtah8ZnFyCjRMIot2YzNO+7vSQ+SZd5vntbRo0Gq8GhT0CPUV8LyNz5yzwAdD8jcRKj0ZLRbd1OMKHOl73bj0uBEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e37o/8pj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45BH4wJN077943;
	Tue, 11 Jun 2024 12:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718125498;
	bh=mIGARfpX1NigkPik0naU8QyBW3hIwD+N3yK6u39Mhv4=;
	h=From:To:CC:Subject:Date;
	b=e37o/8pjIBMauMLJgK/QsYUHX8L0Wg6f72XYd1w0lAMkwUzJvFG3lTjQlS17hcuLi
	 I9+95WtUQxxtnsHCXIqjBrchpg+QDk/bBRl2c+Y0b/RkSX+INuCcZlorLhKPWiR7O5
	 AW4xcOkAXDUa97IR6zWuns0Pe6O86ZhO6C0D6wkk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45BH4wgU023609
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 12:04:58 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 12:04:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 12:04:57 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45BH4v7a039108;
	Tue, 11 Jun 2024 12:04:57 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
        Hari Nagalla <hnagalla@ti.com>
CC: <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] mailbox: omap: Fix mailbox interrupt sharing
Date: Tue, 11 Jun 2024 12:04:56 -0500
Message-ID: <20240611170456.136795-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Multiple mailbox users can share one interrupt line. This flag was
mistakenly dropped as part of the FIFO removal. Mark the IRQ as shared.

Reported-by: Beleswar Padhi <b-padhi@ti.com>
Fixes: 3f58c1f4206f ("mailbox: omap: Remove kernel FIFO message queuing")
Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 46747559b438f..7a87424657a15 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -230,7 +230,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	int ret = 0;
 
 	ret = request_threaded_irq(mbox->irq, NULL, mbox_interrupt,
-				   IRQF_ONESHOT, mbox->name, mbox);
+				   IRQF_SHARED | IRQF_ONESHOT, mbox->name,
+				   mbox);
 	if (unlikely(ret)) {
 		pr_err("failed to register mailbox interrupt:%d\n", ret);
 		return ret;
-- 
2.39.2


