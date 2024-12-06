Return-Path: <linux-kernel+bounces-435746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E289E7BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A083B16B00A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA327206288;
	Fri,  6 Dec 2024 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dHbdQEtn"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A91F9F4C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523964; cv=none; b=Eg7ash+bZm+bGojNbnGgrfFfW6uL6fk/kReJidPo0G+nL9YSSjjKneBP9FHMFVid+U38NgPjQU3A+DA/qIZEHmxdcLZeFQar1afBW2EMKVgof5H7mCjtc/RgDaSziUP6bHmAygAQuSLEYnaQK94oteK5rscxyncz4SpFTREK3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523964; c=relaxed/simple;
	bh=Gj8qfJWC3S8S7/kNhOtCoDZ6nA2QRSN8OsU0VXDUZPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDEhM3/7abIf6li35H3cMzXQw6CraE5QvMf47Hsj1Rs51X9FcEMvbqvbb9sQET2CRXxbfalJMc1jugez6dSmnE4Vjxj6ElBA3Tf2MF8BDtIEOyyMMuF9CAyPJZhNZeIg1YI9Hq2JnwEt+89gz/KseCdsrtQTlne9vPiKOgzOihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dHbdQEtn; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id JglqtTW6qgyqpJglqtoJN5; Fri, 06 Dec 2024 23:25:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733523959;
	bh=5ZO9jSvUWcczovjcsOHSrSDS+9eidGvAZd9lWWiZAvw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dHbdQEtnA6FjVRprh/dyZ1PURHZcC7EJOXdiYfWsUUEin2YWR3Lqrn2LPHCNiuhC/
	 Q3jqtvjGz40fUu5UjVJThlsR7tO+rZRK8HWxKagmqgxGKpzxsL4OgN/skW5sx2zn/g
	 2uZmvNT3jaRGRTUVLTFQRISAmKn9ujwphN7MxFB3IX8Oye9uKVg49MoFlCtgePCl9C
	 zLqo6Mv0y7VIy2/5qKink5no2/UOM/uoqSinn+bJnqERtH6KUthcCh4xsjXLppOJps
	 i/aDPSPwChOb9uj4GbWY9VAeaxgROO+9RtSTw4TaxS12EJ0fLOu9TWtdMuzkncV4iV
	 4q6LQLm6r9nWA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 23:25:59 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Paul Burton <paulburton@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] auxdisplay: img-ascii-lcd: Remove an unused field in struct img_ascii_lcd_ctx
Date: Fri,  6 Dec 2024 23:25:41 +0100
Message-ID: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove 'cfg' from struct img_ascii_lcd_ctx. It is unused since commit
7e76aece6f03 ("auxdisplay: Extract character line display core support")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/auxdisplay/img-ascii-lcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index a802678a6f74..693339ba89d0 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -36,7 +36,6 @@ struct img_ascii_lcd_config {
  * @base: the base address of the LCD registers
  * @regmap: the regmap through which LCD registers are accessed
  * @offset: the offset within regmap to the start of the LCD registers
- * @cfg: pointer to the LCD model configuration
  */
 struct img_ascii_lcd_ctx {
 	struct linedisp linedisp;
@@ -45,7 +44,6 @@ struct img_ascii_lcd_ctx {
 		struct regmap *regmap;
 	};
 	u32 offset;
-	const struct img_ascii_lcd_config *cfg;
 };
 
 /*
-- 
2.47.1


