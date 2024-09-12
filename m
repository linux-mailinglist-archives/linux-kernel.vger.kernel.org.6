Return-Path: <linux-kernel+bounces-326732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDC976C52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7982285B41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694391B374D;
	Thu, 12 Sep 2024 14:41:26 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509101AD25D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152086; cv=none; b=FLyh/TkbKp0EE38+15kiaby477iyxLDya4Nx6UYbXGBkh4bgJDft1rzOdCUs+hJNPVwFyd2895J+ESizPlfaUBlDodLqPPqsEoQfoH6+WkZovh6H2Nn0Gkz0ZH7OD2zetZlk5U986TN0r9um0qhiT3bz+8yUJM0m3gZEXLHGeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152086; c=relaxed/simple;
	bh=eFo8M1L8R7wjkPEig4kgYKYx7zNgDhbmpnAZ+9y3Vmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpsfoW8KcldE2WMnN/ReJIg6OZVJ5IG+xR6joAVGn1E0rKNi/wZEZ+mtaEFDc4e1p5jxU97e6ygcs+rGvqPEqPGGZ+bAYB7yhdW8sPe6qfP0JcI05+6RO/VMn/k4rg1Y4Eog3vWmrQf6m82YEMdwD5KTy+3PI4Hsisc1tFbeVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 0b7c55c8-7115-11ef-812b-005056bdd08f;
	Thu, 12 Sep 2024 17:41:07 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] i2c: synquacer: Fix clock rate retrieval code
Date: Thu, 12 Sep 2024 17:41:05 +0300
Message-ID: <20240912144105.1555624-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the devm_clk_get_enabled() the probe will fail on the systems
that have no clock provided, such as ACPI-based ones.

    synquacer_i2c SCX0003:00: error -ENOENT: failed to get and enable clock
    synquacer_i2c SCX0003:00: probe with driver synquacer_i2c failed with error -2

Fix this by switching to devm_clk_get_optional_enabled() in conjunction with NULL
check, so we won't overwrite the clock rate from the property.

Fixes: 55750148e559 ("i2c: synquacer: Fix an error handling path in synquacer_i2c_probe()")
Reported-by: Ard Biesheuvel <ardb@kernel.org>
Closes: https://lore.kernel.org/r/CAMj1kXFH+zB_YuUS+vaEpguhuVGLYbQw55VNDCxnBfSPe6b-nw@mail.gmail.com
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/i2c/busses/i2c-synquacer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index 4eccbcd0fbfc..49d01fa8fb4e 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -550,12 +550,12 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "socionext,pclk-rate",
 				 &i2c->pclkrate);
 
-	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(pclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
 				     "failed to get and enable clock\n");
-
-	i2c->pclkrate = clk_get_rate(pclk);
+	if (pclk)
+		i2c->pclkrate = clk_get_rate(pclk);
 
 	if (i2c->pclkrate < SYNQUACER_I2C_MIN_CLK_RATE ||
 	    i2c->pclkrate > SYNQUACER_I2C_MAX_CLK_RATE)
-- 
2.46.0


