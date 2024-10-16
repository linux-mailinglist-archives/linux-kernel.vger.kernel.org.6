Return-Path: <linux-kernel+bounces-367393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B99A01AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 102A7B248D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4218E37D;
	Wed, 16 Oct 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="DPi8Upt4"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65915D5CF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061116; cv=none; b=Tuih5m/Fr/V+3H2fCbaMAWgKZHP3mOIbXhedvwXqqp5l2J4sGLL4jIUyzzSONs9rYQb1S4MTM5hHMi50IGqM3QgMYkjD71PTF/3k6Bl+jLmLzpWYsPcsW9NgMLj5a9ChCCTlzgZ+0XPRSrRt/vD1KNCJe0c11dmtwPivUseKQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061116; c=relaxed/simple;
	bh=pI2cwbTmRfpP/2kuGFcWYOozmbN2/ZbeZzfUKQP7Pw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Omzu24Mezciur0HZobzBCBD4cN0YH+RNTWUZgt0DZ+FfJ+W/Wv1ogbj8DFGSEsP6TewmkXpJn5doQ7cAsMtUE+2jsto2ptvRsjKaTUKxz8a3fHfpK/0owIXjc4+qLsvvEVzHM7o7WbjugmqwAlBFTB0GplL9yXlCJFBy8XAIYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=DPi8Upt4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9B2DE0008;
	Wed, 16 Oct 2024 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729061106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OhuifQIKCMDz8+AMVYlt8A9jGfC1V2l3F57S4G62J2c=;
	b=DPi8Upt4elbNkNRQ7zOLVNTop+1iZKTQd8kjyQGoEmu4oGUlhYcdrQ0iok7FfglZQXOp3w
	o4mfpayJhM5VnwS9YBt4FB0rHkw+krpgKqi0b66MfWuQW4KSMczievD/Wu2/DddiGb3ilj
	fX3ElO1ORtx75bhWbVs1THHPl2nTFaXT9c4aIFugF6GlJFBTNCtsmxPvRXP7DqqfqAFQna
	wzpFjYdqnphVugvfi9uV4FdkRm7siZKQIXddIW/qGJ5kQrprzMjkZDWcs7352dAMPkAYyo
	TiQ76zjtI4w1iu6J/JeI/5u1hmFAiIIz9kfrLOc0SBPmippdXtT59bADnNv6VA==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Wed, 16 Oct 2024 08:45:00 +0200
Subject: [PATCH] m68k: mcfgpio: Fix incorrect register offset for
 CONFIG_M5441x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fix-m5441x-gpio-v1-1-0a29befd4b8d@yoseli.org>
X-B4-Tracking: v=1; b=H4sIAOtgD2cC/x3NQQqDQAyF4atI1gaMjmPrVUoXMzZqFo6SSBHEu
 3fs8ufx8U4wVmGDvjhB+Ssma8pBZQHDHNLEKJ/cUFe1o4o8jnLg0jpHB06brMi+o0fTtP4ZHWQ
 VgzFGDWmYb7cE21nvYVPO9n/1el/XD0/MBAp6AAAA
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Greg Ungerer <gerg@uclinux.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729061105; l=1170;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=pI2cwbTmRfpP/2kuGFcWYOozmbN2/ZbeZzfUKQP7Pw8=;
 b=BiKSfKRLZ5/zMqw5X49f1imNfIOkYDX1NWSlAV6eC2i5d1qW/gmA50+oPjCBGoU9mJWeiXaU+
 yVYv55sbVY/ArFI1Gs173THou+CBsZbFeLMWuyWsbETjmQTYYMkH2XF
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Fix a typo in the CONFIG_M5441x preprocessor condition, where the GPIO
register offset was incorrectly set to 8 instead of 0. This prevented
proper GPIO configuration for m5441x targets.

Fixes: 83c6bdb827c9 ("m68knommu: Implement gpio support for m54xx.")
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/include/asm/mcfgpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
index 019f24439546..9c91ecdafc45 100644
--- a/arch/m68k/include/asm/mcfgpio.h
+++ b/arch/m68k/include/asm/mcfgpio.h
@@ -136,7 +136,7 @@ static inline void gpio_free(unsigned gpio)
  * read-modify-write as well as those controlled by the EPORT and GPIO modules.
  */
 #define MCFGPIO_SCR_START		40
-#elif defined(CONFIGM5441x)
+#elif defined(CONFIG_M5441x)
 /* The m5441x EPORT doesn't have its own GPIO port, uses PORT C */
 #define MCFGPIO_SCR_START		0
 #else

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241016-fix-m5441x-gpio-e671833569b4

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


