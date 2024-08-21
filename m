Return-Path: <linux-kernel+bounces-295373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3740959A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C35A1F2179B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E361BAEE6;
	Wed, 21 Aug 2024 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="YmOGDdOg"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57E1B81B2;
	Wed, 21 Aug 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238001; cv=none; b=eWj2I3TsIYbZN0qUkfROI+iQZZChG881d27clGMeg6JClU41Hnb4zZ+c76hjhx7b2ZRnJ0zkUd9FZNNamISdBnZnWjY5CPzWtxiB1UNcBXhSi5FBZpwxILoBPQmvtyB3gQIRLaBQBi5Eanx+kpjl4NPGfbg4W2yEUNohCmLseb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238001; c=relaxed/simple;
	bh=+tqmoTa1quo78lh0ER4UFgZxylnStwrnOjZvqTlhY5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSlQOfNSLrtHh3xjKoXrnCofSlN15SiB0ejXuzoOPHQ0Ig5H5t9B7MnjN4ICdeSD3sCERK3TEeXy6zqv1cUAcFd3MJgyWTG/1ZVlP4FyhrKkhVs8dXpfPuNC4HS7IHj57NsrJEis0raY6qCjAqeY1y/252ZpCAUqpIFdjoc+AlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=YmOGDdOg; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8D5B1483DED;
	Wed, 21 Aug 2024 12:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237997; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=f3c3Rb0MaGLfvzOor2+zbB5i0hEP30uww3c4MW+lsbw=;
	b=YmOGDdOgxWvh/GWC/OCxBEmVYsKO3lJkNsRx3guhWR1wIDL1qcFGNbGznSRMKndM1od4RH
	SYnWCBbfaXD2k3JeMbj7dDMWL+4w48QEdz1GyFdd4A5j5w8qj2PU0sqwDZFZkl+7W4R3R6
	dn0SDIUkNJ1RbW2wmTQ9JCNQZHKHrj5IzvExaqyT++6suwhJX3rsvRq+DAAxQhKehlS1Un
	2dcVNNj9a5/5SfJQvOGzNZCwu5AX7L+sfxGPHJJnIzxTp8xnV68f7pw83ATU4ibQPqQATT
	eX55ep9Gll/Mk++jVEPZcoyM5RrV+Y6Zn1I7dZFfNx7zxVlrzPLQMU554RMn6Q==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v1 09/12] clk: at91: sam9x60: Allow enabling main_rc_osc through DT
Date: Wed, 21 Aug 2024 12:59:40 +0200
Message-Id: <20240821105943.230281-10-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

SAM9X60 Datasheet (DS60001579G) Section "23.4 Product Dependencies"
says:

    "The OTPC is clocked through the Power Management Controller (PMC).
    The user must power on the main RC oscillator and enable the
    peripheral clock of the OTPC prior to reading or writing the OTP
    memory."

The code for enabling/disabling that clock is already present, it was
just not possible to hook into DT anymore, after at91 clk devicetree
binding rework back in 2018 for kernel v4.19.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/clk/at91/sam9x60.c       | 3 ++-
 include/dt-bindings/clock/at91.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index e309cbf3cb9a..4d5ee20b8fc4 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -207,7 +207,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sam9x60_pmc = pmc_data_allocate(PMC_PLLACK + 1,
+	sam9x60_pmc = pmc_data_allocate(PMC_MAIN_RC + 1,
 					nck(sam9x60_systemck),
 					nck(sam9x60_periphck),
 					nck(sam9x60_gck), 8);
@@ -218,6 +218,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 					   50000000);
 	if (IS_ERR(hw))
 		goto err_free;
+	sam9x60_pmc->chws[PMC_MAIN_RC] = hw;
 
 	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
 	if (IS_ERR(hw))
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 3e3972a814c1..f957625cb3ac 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -25,6 +25,7 @@
 #define PMC_PLLBCK		8
 #define PMC_AUDIOPLLCK		9
 #define PMC_AUDIOPINCK		10
+#define PMC_MAIN_RC		11
 
 /* SAMA7G5 */
 #define PMC_CPUPLL		(PMC_MAIN + 1)
-- 
2.39.2


