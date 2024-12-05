Return-Path: <linux-kernel+bounces-433307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78049E5641
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654CF1882EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F92218840;
	Thu,  5 Dec 2024 13:12:29 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB9E56C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404349; cv=none; b=SatyLdq60mTZ4eqR94EHvcPifEm/FXqmqkkZSDKGjuqHP09XTrlMCT5ViSax74UK8jsq3esV0F/7sIQwVETxYLgfXGmjtaAlApuMoPqOfK+pPZsZG9r9PvFKwQr2rbauYiLtu8PlXnsbnUkLzad5aHYuVS+8UbQLeabK3XpidxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404349; c=relaxed/simple;
	bh=nOcg4iRaymGOlbDC9XoflRZruyos6h6RydTL57ZXlzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BzAtFirMdgHWuM1uPUJlJ2DZPeQUWPzTG8k3wIs2OdOzToQ1TTvSHPle/iOOvGgXTohSaNc2iY+csu99rL/YRWcd1LD2wuJDP4xrVDdrqOjVSnRTEbdbFhPDSkrbsq1ZlmhaAqg2AefKhUu1j2zH8st1PSNCVgXLfA9G82yDEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b16a:6561:fa1:2b32])
	by andre.telenet-ops.be with cmsmtp
	id l1CR2D0053EEtj2011CRSz; Thu, 05 Dec 2024 14:12:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBea-000LQB-4j;
	Thu, 05 Dec 2024 14:12:24 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBea-00EQVx-Qi;
	Thu, 05 Dec 2024 14:12:24 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Savoir-faire Linux Inc ." <kernel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip/ts4800: Replace seq_printf() by seq_puts()
Date: Thu,  5 Dec 2024 14:12:23 +0100
Message-Id: <1ba5692126804f9e1ff062ac24939b24030b4f72.1733403985.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify "seq_printf(p, "%s", ...)" to "seq_puts(p, ...)".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/irqchip/irq-ts4800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index cc219f28d317fed1..960c343d5781130b 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -52,7 +52,7 @@ static void ts4800_irq_print_chip(struct irq_data *d, struct seq_file *p)
 {
 	struct ts4800_irq_data *data = irq_data_get_irq_chip_data(d);
 
-	seq_printf(p, "%s", dev_name(&data->pdev->dev));
+	seq_puts(p, dev_name(&data->pdev->dev));
 }
 
 static const struct irq_chip ts4800_chip = {
-- 
2.34.1


