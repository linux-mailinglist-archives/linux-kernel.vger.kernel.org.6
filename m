Return-Path: <linux-kernel+bounces-232644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C274B91AC42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E991F224FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746861993A2;
	Thu, 27 Jun 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="ZVO1kRfE"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBD199384
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504344; cv=none; b=o6mxjSQaLbGQEeHxcumrkrsOWdzW9OIsPPABGzEbWKdCGZAZt1ZYscYyFBNceuaxU2Jqv0JMcV0yEiw3JqVK/1wd+Vq1qsKzX8eI/9+/TpA/wGSViRDZS56Pw4eEWnFGvaRFHbK5I03sd/hrqcJgtuuESYMBG8jsNLyKcfAFKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504344; c=relaxed/simple;
	bh=7MQUtBtmxwtqSjwHgGQHzsi6UX1cWt9yIlLizuWjabU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VzWndz2IHppk/oNauR1R/y6eA9jPmqkldL8GqX+ChqDc6RVEmnX79BdohuDrv5+N6lkIWhfKYAym1pQiYFmpSSAESEGzMK8l/Zt4wCeMnwPPJld4hZsA69Px9Jmfb9hBAUeuiNoagHLauoye7uwC6Daaz26vcGazhcuK/cmhOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=ZVO1kRfE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16C8F1C000B;
	Thu, 27 Jun 2024 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1719504337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtm6RuQJK7HKXMqLOw3rQerxE/QDxsxWMgh9vmm6n3k=;
	b=ZVO1kRfEaJlPja4FjGy+YaxVv2IN7F8Z6Yo36vhnWUVJEcpQW89uhnRI2AiEd4zu6Dzkrt
	4AOF/EonhspOx/8+7FDoPuX0AhK6z2jfAQV3vkFbHp5ZKuGYfsGcDGOtL41FV3L1Fula25
	iQ6VE6z+ovdSuEcKmx8jkQJR8wlN9GxgVYRWZ62TLiXztV2DIpFsu85NzrnTIKq2iJFNSi
	JydmPPqNjM6ptGPKi2eY+YZVmdareA92mFavAF5YIZwsu/DJqRhHGoXdR2cK2xjn67k2Q6
	S8fZiaf1tJdbb9f7QYlqD5d1pQ22a+qsIIhemVKHj3B6mNbTs6dKxy/YZRGARw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Thu, 27 Jun 2024 18:05:28 +0200
Subject: [PATCH v2 1/2] arch: m68k: Add definitions for flash NFC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-upstream-nfc-mcf5441x-v2-1-312929d09ee5@yoseli.org>
References: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
In-Reply-To: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Stefan Agner <stefan@agner.ch>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719504334; l=968;
 i=jeanmichel.hautbois@yoseli.org; s=20240608; h=from:subject:message-id;
 bh=7MQUtBtmxwtqSjwHgGQHzsi6UX1cWt9yIlLizuWjabU=;
 b=r2PAnoXwjNQlDMjnfDZiZz4dyFqRDwOrUTG3Glt35IMJoP78EndtTyrT7IvPZX8LH2hPKhM0L
 9jolZSxpmurBQeDAEmH7t6FHruD54qiX1tgjkzAD70B1BvdQpnwzjdU
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=oMZuYhJzT0j5MI73RlNUVYaA8VdWpFR/Sao0JKz1D2I=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Add a few definitions, as the base address for the NFC for the M5441x.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/include/asm/m5441xsim.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f48cf63bd782..d4ee1eab7c4a 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -99,6 +99,7 @@
 #define MCFINT2_PIT1		14
 #define MCFINT2_PIT2		15
 #define MCFINT2_PIT3		16
+#define MCFINT2_NFC		25
 #define MCFINT2_RTC		26
 
 /*
@@ -333,4 +334,10 @@
 #define MCF_IRQ_BOFF1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_BOFF)
 #define MCF_IRQ_ERR1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_ERR)
 
+/*
+ * Flash module
+ */
+#define MCF_NFC_BASE		0xfc0fc000
+#define MCF_NFC_SIZE		(0xfc0fff3b - 0xfc0fc000)
+#define MCF_NFC_ISR		(MCFINT2_VECBASE + MCFINT2_NFC)
 #endif /* m5441xsim_h */

-- 
2.43.0


