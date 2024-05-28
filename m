Return-Path: <linux-kernel+bounces-192243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D68D1A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B23F1C2141A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592A16D315;
	Tue, 28 May 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa6Gdsms"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1713A242
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897772; cv=none; b=nB+pCNe1PfptCoNfiUVOOCRw5BDXJAO1vWRwKHKS3AcrfEVILFsAXB8Si0CbV+uepmQ4MN4fx+hQUa3BFpfGPxROCZBmmyt9k0WACgGgQhI2wYE/5DE54jacBP223e/+yUvV+9eF8a7OlkVmDTf35ecp/VMljU97Dem/lQ5NKlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897772; c=relaxed/simple;
	bh=8Sj9m5H66IoU8ACiyDTo30Tfi2x2L8Km6KRH00ITSdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gl65KojvZtBYKXVjEZEan0S4xx5QtAaItS66S2jpj9PIwy4/1HKVXiMNCTRoJGY1I/4pVFgihlycBRbAoeB5MVh0dnsSILQp4/KeBNcda3gsV1h0PAd8MhZIwI7ZtlJ99qFow5E0sYBGTU0aB2zCKX3g9RYaEahJ8mmHMyMJiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa6Gdsms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E3BC3277B;
	Tue, 28 May 2024 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897772;
	bh=8Sj9m5H66IoU8ACiyDTo30Tfi2x2L8Km6KRH00ITSdY=;
	h=From:To:Cc:Subject:Date:From;
	b=Pa6Gdsmsd3gU/YG7bvsnP0IOUy9r6KCeSrp1EIQ8uNde0Mk8fqXE2/wR2FE23xJF+
	 h9iV7r8pgRLViN5RF0+fYynanOkWrleRQZd6sr4ReTx3kv7t6q+Y/77rAuZ2XZl+xZ
	 lkUNyrzWZbJtH9RV15AI/0mab3moNfHP/e9XCDptDzIZDJ720XaYqPbnbGYU9n3knQ
	 UZzpBxLtnu9pPCdUJ8QssZoWD+ifm672wPRi8bzvxjeFDdGb8b/GGQIQ1xnMyDjwKJ
	 IZrgGMpb5bylM4OawPncoAny19/Cxnx5keeKF/2BcoNvGEvk3u3nHpAHURlLFQ14ju
	 EHHqKEVkdgO9g==
From: Arnd Bergmann <arnd@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Saeed Nowshadi <saeed.nowshadi@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ben Levinsky <ben.levinsky@amd.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mailbox: zynqmp-ipi: drop irq_to_desc() call
Date: Tue, 28 May 2024 14:02:35 +0200
Message-Id: <20240528120246.3313723-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

irq_to_desc() is not exported to loadable modules, so this driver now
fails to link in some configurations:

ERROR: modpost: "irq_to_desc" [drivers/mailbox/zynqmp-ipi-mailbox.ko] undefined!

I can't see a purpose for this call, since the return value is unused
and probably left over from some code refactoring.

Address the link failure by just removing the line.

Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 7c90bac3de21..4acf5612487c 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -850,7 +850,6 @@ static int xlnx_mbox_init_sgi(struct platform_device *pdev,
 		return ret;
 	}
 
-	irq_to_desc(pdata->virq_sgi);
 	irq_set_status_flags(pdata->virq_sgi, IRQ_PER_CPU);
 
 	/* Setup function for the CPU hot-plug cases */
-- 
2.39.2


