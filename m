Return-Path: <linux-kernel+bounces-412036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F179D02A4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C9D284F8B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AAC1885A5;
	Sun, 17 Nov 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I/tKalom"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233D170A14
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837013; cv=none; b=HQMSnhophpUbu47sMoUtpaV//P6QuopgB6NAA9hmF+86BZwLhZ2zq3MoEMTexPIoxK9duxsulgO4BYFaYWqY+w+FzNq+M2lqZx4wyrnjSBHay9SaqgF1SPNJQHh5W/wJGZpFTbsIzSOgTlRAUIipcHKRKsACpiOPbaqVEZipMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837013; c=relaxed/simple;
	bh=9Kst35gF+Fkh4yvQc1AWO/RI2mr37uedH3L5pEKEDMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRFyShY6GIxOwbq7Xv18/4PkKSQxVxGfvwJRS94qUDD+Pz6FK8uynG2bjALsBBpYd+R5J1fbwqKoi3DECT0k5VtlPhooPvDoah3w0j+IAujz0+odDCfFOo0n5E4/joKvf/KjC1Qr2Fr6RsZ4AmiD6wOf4tnLWoFYLp+Ub8lzmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I/tKalom; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Cbuot94NAgiuVCbv0txsgW; Sun, 17 Nov 2024 10:50:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731837011;
	bh=hTR37BrRxIlVJQOJ1ST4RPppeQ5fbJDKWyDmhu0C03k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=I/tKalomk4oNHFGaLKEbT/U1CZ+SpPZI0rJiuRQaQ4ElU2g2iyc8lnI8e9gs8mhvv
	 lcI63JsgyktTFLLMRwHD5DTSgZ3Vb24g4XKjf470+bQx+6p/S3ZcIM64KrryDGAAXm
	 mY45aNiT/OGkKR6nHtBOHHph24Y350WeJ5F2cGzDryKckMsRshf2PmE4scoekxgGKv
	 jfvj2og77OIuzo9xSCIOwjYRS7p1GdMLm/VSkvLEIbssX54Aw1ODLaxku3qd8twQKD
	 sQ45Ve9a7srVjm4dFE81UmRyo4BAO7CflSAgHoSbm/+Nd82PZCCMXBJrtrjNzgU+Vd
	 jZVuPRvOnTT2w==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Nov 2024 10:50:11 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/5] irqchip: Constify some direct access to irq_data->chip
Date: Sun, 17 Nov 2024 10:49:45 +0100
Message-ID: <99871d898c2ff0023895d15169ca4c78c90d225a.1731835733.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731835733.git.christophe.jaillet@wanadoo.fr>
References: <cover.1731835733.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the 'chip' member of struct irq_data will be turned into a const
struct irq_chip, the const qualifier will be needed for local variables
that keep a reference to this field.

So start to add some of these const qualifiers.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 kernel/irq/chip.c      |  8 ++++----
 kernel/irq/debugfs.c   |  2 +-
 kernel/irq/manage.c    | 10 +++++-----
 kernel/irq/migration.c |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 502133dc3b9c..eca39c4dd094 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -442,7 +442,7 @@ void unmask_irq(struct irq_desc *desc)
 
 void unmask_threaded_irq(struct irq_desc *desc)
 {
-	struct irq_chip *chip = desc->irq_data.chip;
+	const struct irq_chip *chip = desc->irq_data.chip;
 
 	if (chip->flags & IRQCHIP_EOI_THREADED)
 		chip->irq_eoi(&desc->irq_data);
@@ -687,7 +687,7 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc,
  */
 void handle_fasteoi_irq(struct irq_desc *desc)
 {
-	struct irq_chip *chip = desc->irq_data.chip;
+	const struct irq_chip *chip = desc->irq_data.chip;
 
 	raw_spin_lock(&desc->lock);
 
@@ -1212,7 +1212,7 @@ void irq_cpu_offline(void)
  */
 void handle_fasteoi_ack_irq(struct irq_desc *desc)
 {
-	struct irq_chip *chip = desc->irq_data.chip;
+	const struct irq_chip *chip = desc->irq_data.chip;
 
 	raw_spin_lock(&desc->lock);
 
@@ -1263,7 +1263,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_ack_irq);
  */
 void handle_fasteoi_mask_irq(struct irq_desc *desc)
 {
-	struct irq_chip *chip = desc->irq_data.chip;
+	const struct irq_chip *chip = desc->irq_data.chip;
 
 	raw_spin_lock(&desc->lock);
 	mask_ack_irq(desc);
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index c6ffb97966be..c9c1c28be1a9 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -58,7 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 static void
 irq_debug_show_chip(struct seq_file *m, struct irq_data *data, int ind)
 {
-	struct irq_chip *chip = data->chip;
+	const struct irq_chip *chip = data->chip;
 
 	if (!chip) {
 		seq_printf(m, "chip: None\n");
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f0803d6bd296..e7f548bc976b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -958,7 +958,7 @@ int can_request_irq(unsigned int irq, unsigned long irqflags)
 
 int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 {
-	struct irq_chip *chip = desc->irq_data.chip;
+	const struct irq_chip *chip = desc->irq_data.chip;
 	int ret, unmask = 0;
 
 	if (!chip || !chip->irq_set_type) {
@@ -1407,7 +1407,7 @@ static int irq_setup_forced_threading(struct irqaction *new)
 static int irq_request_resources(struct irq_desc *desc)
 {
 	struct irq_data *d = &desc->irq_data;
-	struct irq_chip *c = d->chip;
+	const struct irq_chip *c = d->chip;
 
 	return c->irq_request_resources ? c->irq_request_resources(d) : 0;
 }
@@ -1415,7 +1415,7 @@ static int irq_request_resources(struct irq_desc *desc)
 static void irq_release_resources(struct irq_desc *desc)
 {
 	struct irq_data *d = &desc->irq_data;
-	struct irq_chip *c = d->chip;
+	const struct irq_chip *c = d->chip;
 
 	if (c->irq_release_resources)
 		c->irq_release_resources(d);
@@ -1440,7 +1440,7 @@ static bool irq_supports_nmi(struct irq_desc *desc)
 static int irq_nmi_setup(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
-	struct irq_chip *c = d->chip;
+	const struct irq_chip *c = d->chip;
 
 	return c->irq_nmi_setup ? c->irq_nmi_setup(d) : -EINVAL;
 }
@@ -1448,7 +1448,7 @@ static int irq_nmi_setup(struct irq_desc *desc)
 static void irq_nmi_teardown(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
-	struct irq_chip *c = d->chip;
+	const struct irq_chip *c = d->chip;
 
 	if (c->irq_nmi_teardown)
 		c->irq_nmi_teardown(d);
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index eb150afd671f..fff2d9cd0239 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -39,7 +39,7 @@ void irq_move_masked_irq(struct irq_data *idata)
 {
 	struct irq_desc *desc = irq_data_to_desc(idata);
 	struct irq_data *data = &desc->irq_data;
-	struct irq_chip *chip = data->chip;
+	const struct irq_chip *chip = data->chip;
 
 	if (likely(!irqd_is_setaffinity_pending(data)))
 		return;
-- 
2.47.0


