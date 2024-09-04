Return-Path: <linux-kernel+bounces-315749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5549F96C682
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2511F26AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F681E1A17;
	Wed,  4 Sep 2024 18:36:56 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678A7F9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475016; cv=none; b=mlBDcilm1SS7rjGaKGfHBWiJyLXOEqvRe1aUYpKVXipM9mEXKQZkiYqEnH+3Sg70dxj4Rtp0T7/CmV1MremGPJgZDMO0dsvnqMuTbxSM45rznmfP34v/1mo8mVsMUn6IkLwBgF+ELamjPW5CRZgV3tebRmYJFskfKHjWGD0pQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475016; c=relaxed/simple;
	bh=lzgftk261xH3rTWCohglAzl1zYA0EhxMErAwnaHLiWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ushyNuUqrSLx0xiFEJytkW+0xgIxNtozCyacuTJ6nHHpcnB0JzEfZxaRHPmHoZkphdMXdAeCJ38bya7VvRSIf+3cAmkNJxDkStsWbZ/nTB4pvZULT+tZFON9BQFVWaR8+f5D+sty56wQGksAerpMcdiq8jxCyKU8g4Wp/W3x2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id a46bec10-6aec-11ef-8ed1-005056bdf889;
	Wed, 04 Sep 2024 21:36:47 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: light: cm32181: Remove duplicate ACPI handle check
Date: Wed,  4 Sep 2024 21:36:46 +0300
Message-ID: <20240904183646.1219485-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cm32181_acpi_parse_cpm_tables() is a no-op if ACPI handle
is not available. Remove duplicate ACPI handle check at
the caller side.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/light/cm32181.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 9df85b3999fa..aeae0566ec12 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -217,8 +217,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 	cm32181->lux_per_bit = CM32181_LUX_PER_BIT;
 	cm32181->lux_per_bit_base_it = CM32181_LUX_PER_BIT_BASE_IT;
 
-	if (ACPI_HANDLE(cm32181->dev))
-		cm32181_acpi_parse_cpm_tables(cm32181);
+	cm32181_acpi_parse_cpm_tables(cm32181);
 
 	/* Initialize registers*/
 	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
-- 
2.46.0


