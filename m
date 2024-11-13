Return-Path: <linux-kernel+bounces-407921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD29C7772
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF51F2812C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9F71FCF78;
	Wed, 13 Nov 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jQ0WWj7C"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9F143744
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512187; cv=none; b=pDP40K2ZZ3usMsbNBi0QSdEqTUQtnyLxNSZnBO5pQ2k5Hn3Rcbrvzo/e0zdXPf7nSjUnFCUH6+Jg1e80/OW6p2q8oRvEWBNbFA+iBF4TI47DovKepaxTgFbJ5oz2gOYOLi2CuwjCog5z9uFSn8qXNRnv0ZIsyzY4kNO2JFbhcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512187; c=relaxed/simple;
	bh=dCYEEDDPkiMtBUMfjnloUQgcqeC8wQLctWDtAq8oLvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YgspnAluTgZ61Wn+VnxIw7uVUB7syt4JWS0IsA9pI6YrrDIz0FSAXpw+4PjvHUWVaMLx6WmepBV+Hprci0yhw8cnTZIFXB/dRNan0jflpcA80X7sj/rAceh9iP61VxgePC/KWcH3TRbkv7Hf/CzRT5s41J2KZooNtbrGUx+l5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jQ0WWj7C; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B911C1C0006;
	Wed, 13 Nov 2024 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731512177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z1sXmiDDA8YvWTtcm6MHGXPy4k0xRKH62f2iV/I/T0E=;
	b=jQ0WWj7CMnbIghylRqSzEupF9ObM6na4+KjNdVuMyQsvHSvAhwbSERS64Uw6BK7vqyKhum
	SZYdg4jsKwzvpWhNJhjzIuoQUqfUkAKXW+WIFppnbzoL+VWwDyup3HxPN6slIMles4okZm
	USW1OZxd17mYb2g0XRiQTbuGp73BVeWvSScW0Z2rwvXOHRqfGwxwMaAxyPWLuQd3NdE6/7
	8xVFUqdyMRfYfEz/F7YwG5rbjNFxZlVYN/qu45kISatxwsQMl5n7WpioTvHUIdjR8Xwfk6
	IsLnXuiaPsW5DFOZVA46rNPi5MZ1v5XfEgHoNfvjx0dUbMTIcrAnE7QqxPZ8RQ==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] regulator: core: Fix resolve supply
Date: Wed, 13 Nov 2024 16:36:14 +0100
Message-Id: <20241113153614.1755825-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

The regulator should not use the device parent to resolve the regulator
supply. It fails to resolve the correct supply when the of_node
variable in the regulator_config structure is not within the parent
node.

Fixes: 6261b06de565 ("regulator: Defer lookup of supply to regulator_get")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

It is weird that it wasn't seen before, maybe there was not any case
were it can't find the supply_name from the parent device.
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 76d3cd5ae6ea..ee5bc070b5bb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2023,7 +2023,7 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
-	struct device *dev = rdev->dev.parent;
+	struct device *dev = &rdev->dev;
 	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
-- 
2.34.1


