Return-Path: <linux-kernel+bounces-265898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0793F779
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CD61C21CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBDA15531B;
	Mon, 29 Jul 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kVYrv20k"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30412D05D;
	Mon, 29 Jul 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262882; cv=none; b=fXZRh4dvELQngGlolEoMKzdlgwJW8BQ5d6wdfZNCaUHcrM511qiP1Rwb9RuVHg0ucjOT7p4rVkB0YCF7ueS47vA5wQ88pbz6wFttAwmmkf8HLIsxQVhUvH0oX9nA4cq2hjHMiaw97RfxTc2J5vdHJXoQ3IhphKvymmwesbbLP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262882; c=relaxed/simple;
	bh=vcAl0x4gPpSg4JpYxWBikZj/5ttEGPEc0OMBcIm5EpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au7JY3vyeQea7U4XiysuXq36ySZsvlf/wVmj1qKYf831ZZNmNy9s1lLUvX5J1cPOdfB6Y1fP+KrL39pMJLnMIX8wPnPvyIUjqd8CEEGgv9aP1E79/bk+7PdNo8ONLF2TkqMX1auoWHPKQYFatzrq6ExddO/IyaLfJ0HrjIqCy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kVYrv20k; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 80A11240013;
	Mon, 29 Jul 2024 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APwAy045+0bwsYWXWzWi8kg7IB9CU666Ib602lP5Ma0=;
	b=kVYrv20k9mDyvJa3yczKwdZwYx75K97npjDH5zsl2GPd2zsjhu2NlrlS2T2YOrEQbsgiDt
	V0rXu+s8ckXoYEdKSqB5UMYn2J2ZoHe2f4wamw65BKlI2sjCWuplDcENM1MPPIW4ZWkbl6
	AR5WSdky/9yQxQDjc4mYIygzUT4Rk1O9MurEv/k+9piH5h9bTUNVropze7ofL/vBwOrnvA
	AGbWV8JYqfbz1bily/WJqFoslXeF0mTwOQtklpjqxKC0bgdfaln6CziMZZ7AsYDRn2SZOI
	1iwJzL/htTGBoWZE1afdSRCZF7P9vaxD6xi/aU6Hy5zqAN3Amhu9EahczScnOQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1 05/36] soc: fsl: cpm1: tsa: Fix blank line and spaces
Date: Mon, 29 Jul 2024 16:20:34 +0200
Message-ID: <20240729142107.104574-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

checkpatch.pl raises the following issues
  CHECK: Please don't use multiple blank lines
  CHECK: spaces preferred around that '/' (ctx:VxV)
  CHECK: spaces preferred around that '+' (ctx:VxV)
  CHECK: spaces preferred around that '-' (ctx:VxV)

Fix them.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index dc4dda17dab8..7b1032fb1572 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-
 /* TSA SI RAM routing tables entry */
 #define TSA_SIRAM_ENTRY_LAST		BIT(16)
 #define TSA_SIRAM_ENTRY_BYTE		BIT(17)
@@ -244,8 +243,8 @@ static void tsa_init_entries_area(struct tsa *tsa, struct tsa_entries_area *area
 	resource_size_t quarter;
 	resource_size_t half;
 
-	quarter = tsa->si_ram_sz/4;
-	half = tsa->si_ram_sz/2;
+	quarter = tsa->si_ram_sz / 4;
+	half = tsa->si_ram_sz / 2;
 
 	if (tdms == BIT(TSA_TDMA)) {
 		/* Only TDMA */
@@ -408,7 +407,7 @@ static int tsa_of_parse_tdm_route(struct tsa *tsa, struct device_node *tdm_np,
 		}
 
 		dev_dbg(tsa->dev, "tdm_id=%u, %s ts %u..%u -> %s\n",
-			tdm_id, route_name, ts, ts+count-1, serial_name);
+			tdm_id, route_name, ts, ts + count - 1, serial_name);
 		ts += count;
 
 		ret = tsa_add_entry(tsa, &area, count, serial_id);
-- 
2.45.0


