Return-Path: <linux-kernel+bounces-259652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3B939AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9153B22671
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5614D283;
	Tue, 23 Jul 2024 06:45:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8637814B95A;
	Tue, 23 Jul 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717129; cv=none; b=iwA7o0rXBa0PHWoliqAwDz0K3MTN2suxAA9QOp6hINuhAtE4UGs6yZWEtDHffrU/uNsvJl9VI5V7Wve39k82rnPYtnfbxSpwY30dRvwmWn7VjjHAkTdKzaDTvSxC21ZQHZZ8Rb1NkU0u7yEhdZ1smBESZ6yaOYDF5T/PExYjk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717129; c=relaxed/simple;
	bh=Fj6YuJtpDRV7/HgBxaDu7WWgqZe2oCXxvm0Qsi/we6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KI/V7+DEfZYfQTX0dcJPLhEd9MFi22PJebsXE4ydLK72Tz2bN2kmQ1OgA7D1NE8lpnYOx9VaHP/7F5jVYpeXa+rrpON47RTZf18dwFxNnzdIgAdl7ip2I6VZufDxgKSOdvBNJ8xEDVhEknHN3oEQuIZsk3jrHW9IHbGJ9lKa9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77395C4AF0C;
	Tue, 23 Jul 2024 06:45:27 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Miao Wang <shankerwangmiao@gmail.com>
Subject: [PATCH] irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()
Date: Tue, 23 Jul 2024 14:45:08 +0800
Message-ID: <20240723064508.35560-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lpic_gsi_to_irq() should return a valid irq if acpi_register_gsi()
succeed, and return 0 otherwise. But now lpic_gsi_to_irq() converts
a negative return value of acpi_register_gsi() to a positive value
silently, so fix it.

Reported-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongarch-cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 9d8f2c406043..b35903a06902 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -18,11 +18,13 @@ struct fwnode_handle *cpuintc_handle;
 
 static u32 lpic_gsi_to_irq(u32 gsi)
 {
+	int irq = 0;
+
 	/* Only pch irqdomain transferring is required for LoongArch. */
 	if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
-		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+		irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
 
-	return 0;
+	return (irq > 0) ? irq : 0;
 }
 
 static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
-- 
2.43.5


