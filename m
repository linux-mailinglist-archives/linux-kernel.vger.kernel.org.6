Return-Path: <linux-kernel+bounces-229936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60C917633
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1577AB20D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACF24B28;
	Wed, 26 Jun 2024 02:36:46 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086C208A7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369405; cv=none; b=Djb6nN/wbOiuJmQodGoTvD31WrX5/KXFlZeRuVMjVhGPpy+b429ZaZX6u4gKeszqtg+uMQ+c59ext/dXOEeypCOrX7FsUgpoWY9g7L2hx/0Vd0IqudYB6TFnCENQlOZhdzK0I2nv2Y7iDScOTW1aD6FN4bY91DwcJFSH7xuW0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369405; c=relaxed/simple;
	bh=ji6+uw3F9+npT16PlO1EBYwnVlQ+DH16fxTAQhGoyJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JAQFdmV5uGXiokhNpb14WdLXuKVxSAN+U3uYgCRhRy5aGEo3aitSvbIJbKRmGm10mppq5gGc2R6PqkTzeRNW9LOKxKNIsrtTtJkjcKXbC9VaQgal88EKzk38zEZQQUyEvtmJdk5hkDq769qOgq25nAvgqltzJ7KRJ7Thf72HhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp83t1719369218t0sm7mls
X-QQ-Originating-IP: PZ/+RbjVK5tkOQsFsab5chKDrIqjTGpfpsK7wjJrAt4=
Received: from ubuntu1.. ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jun 2024 10:33:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1355789864237892268
From: Song Shuai <songshuaishuai@tinylab.org>
To: takakura@valinux.co.jp,
	alex@ghiti.fr,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com
Cc: aou@eecs.berkeley.edu,
	bhe@redhat.com,
	songshuaishuai@tinylab.org,
	akpm@linux-foundation.org,
	guoren@kernel.org,
	xianting.tian@linux.alibaba.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 -fixes] riscv: kexec: Avoid deadlock in kexec crash path
Date: Wed, 26 Jun 2024 10:33:16 +0800
Message-Id: <20240626023316.539971-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0

If the kexec crash code is called in the interrupt context, the
machine_kexec_mask_interrupts() function will trigger a deadlock while
trying to acquire the irqdesc spinlock and then deactivate irqchip in
irq_set_irqchip_state() function.

Unlike arm64, riscv only requires irq_eoi handler to complete EOI and
keeping irq_set_irqchip_state() will only leave this possible deadlock
without any use. So we simply remove it.

Link: https://lore.kernel.org/linux-riscv/20231208111015.173237-1-songshuaishuai@tinylab.org/
Fixes: b17d19a5314a ("riscv: kexec: Fixup irq controller broken in kexec crash path")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
Changes since V1:
https://lore.kernel.org/linux-riscv/20231208111015.173237-1-songshuaishuai@tinylab.org/
- update the commit log as @Ryo elaborated 
- rebase on Linux 6.10-rc3

---
 arch/riscv/kernel/machine_kexec.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index ed9cad20c039..3c830a6f7ef4 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -121,20 +121,12 @@ static void machine_kexec_mask_interrupts(void)
 
 	for_each_irq_desc(i, desc) {
 		struct irq_chip *chip;
-		int ret;
 
 		chip = irq_desc_get_chip(desc);
 		if (!chip)
 			continue;
 
-		/*
-		 * First try to remove the active state. If this
-		 * fails, try to EOI the interrupt.
-		 */
-		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
-
-		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
-		    chip->irq_eoi)
+		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
 		if (chip->irq_mask)
-- 
2.39.2


