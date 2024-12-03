Return-Path: <linux-kernel+bounces-429840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7659E2943
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26A3B65675
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E091F9F5B;
	Tue,  3 Dec 2024 16:27:46 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC691F8AC9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243266; cv=none; b=VjuOgxuFIQ1oomiqY406+Isawe/rqt9wSTeW8IjvMK9fbLYppoGhsCyyulhCq6dfCJ+x/c/iYkUOr/oYwx+dtjacGxx/pJ8wPOcS9eCmkDcJcLz1sliuN7sj6cUhfVg4tLigIa6lpDfw/C4pl5itDUH4TW97x8fprLxsNqaYNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243266; c=relaxed/simple;
	bh=G8mBbcOXjBJXiDnv2W25jOyCbHtJ6+YVRlsjMpNEpLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRkpcm/929mg9+9Fw34SHtWv3GzCkjnbG/tA0MmY5FOanvB8zhNnqmV1PDr6NsyXwDkQDuZ0/ZaKu7euVqJ9HvXs2xoL0ouOdbDApS9SZjSD9RbPI0/bauzUKgERAAk4TZtQMlGe1qc+HzzCr4glI/UqNTZ6c5YT1XUiREkXAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:829d:a1e7:5b32:5d8e])
	by baptiste.telenet-ops.be with cmsmtp
	id kGTi2D0053sLyzB01GTiRK; Tue, 03 Dec 2024 17:27:42 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tIVkT-000DUh-Vp;
	Tue, 03 Dec 2024 17:27:41 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tIVkT-00AUu5-Sm;
	Tue, 03 Dec 2024 17:27:41 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: STM32MP_EXTI should not default to y when compile-testing
Date: Tue,  3 Dec 2024 17:27:40 +0100
Message-Id: <ef5ec063b23522058f92087e072419ea233acfe9.1733243115.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merely enabling compile-testing should not enable additional
functionality.

Fixes: 0be58e0553812fcb ("irqchip/stm32mp-exti: Allow building as module")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5784556adb36af73..c94aaadc0ed2be70 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -416,7 +416,7 @@ config PARTITION_PERCPU
 config STM32MP_EXTI
 	tristate "STM32MP extended interrupts and event controller"
 	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
-	default y
+	default ARCH_STM32 && !ARM_SINGLE_ARMV7M
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_CHIP
 	help
-- 
2.34.1


