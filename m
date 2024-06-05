Return-Path: <linux-kernel+bounces-203213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3708FD7F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D83D1C24D95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC3815F3FA;
	Wed,  5 Jun 2024 20:53:21 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794D158862
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620801; cv=none; b=Gkbf+BnAEY5ufK8oym16+GhUvouPpDvJk6cscdXTNwV3pGaImxF9g9iAVBIHEvmmnaoR0g8G2HcBbtPA9ydUxFn+IhontfCgy3R1/jkRvbshpFVN8OBuKBQw8f5kIE15jFPb9f4U+BCEjgkBtNl9BP0KguZqGIZ/lyqg+DpDJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620801; c=relaxed/simple;
	bh=8eVwxBuuPV0HMr0wLVyfEieEVTEwhmYmsEtJES1P7l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Joc2JV6YiPXiJsXD5EOvzVFp8UY0gK7rXTqZk5w0bHQwsetwrrUudqdLDNXrzYtD0JS2niuNIWm1myPDowkgQOZWH0YfOpz+dT8NLn/KCV8GO8SjOnSiEXFeQrtrSvNW2imMzgy9Hy7EBg5/HpUvUXbCdbFZhdFVr9EZ33vDMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id a22c60ea-237d-11ef-80de-005056bdfda7;
	Wed, 05 Jun 2024 23:53:17 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] regmap: spi: Fix potential off-by-one when calculating reserved size
Date: Wed,  5 Jun 2024 23:53:15 +0300
Message-ID: <20240605205315.19132-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we ever meet a hardware that uses weird register bits and padding,
we may end up in off-by-one error since x/8 + y/8 might not be equal
to (x + y)/8 in some cases.

bits    pad   x/8+y/8 (x+y)/8
4..7    0..3    0       0 // x + y from 4 up to 7
4..7    4..7    0       1 // x + y from 8 up to 11
4..7    8..11   1       1 // x + y from 12 up to 15
8..15   0..7    1       1 // x + y from 8 up to 15
8..15   8..15   2       2 // x + y from 16 up to 23

Fix this by using (x+y)/8.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/base/regmap/regmap-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 094cf2a2ca3c..14b1d88997cb 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -122,8 +122,7 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 			return ERR_PTR(-ENOMEM);
 
 		max_msg_size = spi_max_message_size(spi);
-		reg_reserve_size = config->reg_bits / BITS_PER_BYTE
-				 + config->pad_bits / BITS_PER_BYTE;
+		reg_reserve_size = (config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
 		if (max_size + reg_reserve_size > max_msg_size)
 			max_size -= reg_reserve_size;
 
-- 
2.45.2


