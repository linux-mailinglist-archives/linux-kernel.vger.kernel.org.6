Return-Path: <linux-kernel+bounces-415479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845D19D36DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B32842C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144AA19CC20;
	Wed, 20 Nov 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FelG8r3b"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F423919AD48
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094252; cv=none; b=p80UXudnc+H6RSJRKjE6n/kixqUdcpaTooYRxFJisCfuTVwr0odAO9/jWu9ej10yrNnjiMnouvoh2N6KfUdexlWe/JbeixBt/RZ33zO6iBGFaEGOJZvgLtIqLssmOcrtIgAywkOtaxa8sCj7AyeeKfcHKDUtVFP0lF6uigGQ5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094252; c=relaxed/simple;
	bh=pamlAT7YrMUBTKbqo+eOUtuarnXN54r8/hz9pNEgvVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtBu3IS+ivUqx9sG+bgXkbqmnPYT+2zmt9vVChLuxXLfTUSKDLSMTGOz2UvQhMOH/IULa+YtPljyG0hZ9jsqplB5ZVOPkywJt9i256TSTF01fQnwQ8UAR+fCFCigobeVIdME7/d2Fubf8H3dZspjpT0dTgHfyAN56RAZVrSIki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FelG8r3b; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pASy3
	Hri0XiR5e82slCk+94XiuRqLmmyYyxOiSXMmaY=; b=FelG8r3b6+TLxImX27860
	YA1IPhNQ0ZNn9WTrLK5hfJgVqewLwtYj+wS92p4Ic2yUFBkjtbTJScwC0f9vyY2O
	Fx0u5W0Rev/t5D2oClAolfJJArapj5WzaSCDEd8B/JH9hxSaQoCs7omBjzxRyIvq
	IPD3uwVbGhzJMYH7Xt0hek=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDn71UUqT1nUk5JGQ--.8558S4;
	Wed, 20 Nov 2024 17:17:15 +0800 (CST)
From: David Wang <00107082@163.com>
To: tglx@linutronix.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	David Wang <00107082@163.com>
Subject: [PATCH 2/3] irqchip: Fix a potential abuse of seq_printf() format string
Date: Wed, 20 Nov 2024 17:17:06 +0800
Message-Id: <762e88c3e940bd6087c35b599f2c88baff775c6b.1732093745.git.00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <505e5950dd2d76e6c3a8af57bc0cd1e0fbf2b637.1732093745.git.00107082@163.com>
References: <505e5950dd2d76e6c3a8af57bc0cd1e0fbf2b637.1732093745.git.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn71UUqT1nUk5JGQ--.8558S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWDKw4rZFWruF45ZF4UXFb_yoW8ur4kpa
	y5Jas2vws3C3WUWF1UCanrZFy5J3Z0krW7KayfJwnIvF98G39FkF12yry7ZFsYqrW7G3WY
	kF40qFyUWFy7CFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_KZXUUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRGdqmc9oqUyfQAEsZ

Using device name as format string of seq_printf() is prone to
"Format string attack", opens possibility for exploitation.
Seq_puts() is safer and more efficient.

Signed-off-by: David Wang <00107082@163.com>
---
 drivers/irqchip/irq-gic.c            | 2 +-
 drivers/irqchip/irq-mvebu-pic.c      | 2 +-
 drivers/irqchip/irq-versatile-fpga.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 3be7bd8cd8cd..8fae6dc01024 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -400,7 +400,7 @@ static void gic_irq_print_chip(struct irq_data *d, struct seq_file *p)
 	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
 
 	if (gic->domain->pm_dev)
-		seq_printf(p, gic->domain->pm_dev->of_node->name);
+		seq_puts(p, gic->domain->pm_dev->of_node->name);
 	else
 		seq_printf(p, "GIC-%d", (int)(gic - &gic_data[0]));
 }
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 08b0cc862adf..b815a60f930c 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -71,7 +71,7 @@ static void mvebu_pic_print_chip(struct irq_data *d, struct seq_file *p)
 {
 	struct mvebu_pic *pic = irq_data_get_irq_chip_data(d);
 
-	seq_printf(p, dev_name(&pic->pdev->dev));
+	seq_puts(p, dev_name(&pic->pdev->dev));
 }
 
 static const struct irq_chip mvebu_pic_chip = {
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index ca471c6fee99..0abc8934c2ee 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -69,7 +69,7 @@ static void fpga_irq_print_chip(struct irq_data *d, struct seq_file *p)
 {
 	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
 
-	seq_printf(p, irq_domain_get_of_node(f->domain)->name);
+	seq_puts(p, irq_domain_get_of_node(f->domain)->name);
 }
 
 static const struct irq_chip fpga_chip = {
-- 
2.39.2


