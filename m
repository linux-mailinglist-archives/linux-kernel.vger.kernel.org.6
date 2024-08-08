Return-Path: <linux-kernel+bounces-278969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B994B742
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D273B24708
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54E189BBA;
	Thu,  8 Aug 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z7tiPkSq"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB7188CAB;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101111; cv=none; b=A0bmFsfLskM3nrQTVQFEtGlC5kZFKgSGRv1jOA4L1U3N9ksz9c0Ot+K+6cC8VvP3SirY9G1lnBUhqw9K0ZROsQRdh8FuHsT+nVTpPUqbFHBy3OANcgz2YvPSnH+FnTTLhvbeC8elIVQGEdyjUoWlxrJyxuAB1jhb7A2q0+LLDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101111; c=relaxed/simple;
	bh=vcAl0x4gPpSg4JpYxWBikZj/5ttEGPEc0OMBcIm5EpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRMAAiZIfZ1zO4EJOjYBn/bauvuIpQk42G0/ytArKlXYEoG+f2txB9QoPD5oRwW9M/a2rZwk9R0qFgn1s1GMjNJvk0h1lbCkz+vT6yPK/ApuClAIn5FZfwbe3ETDAfT0NzSLCLBarUdrkTprTehse1jcamLD0kdgg7g91vmGwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z7tiPkSq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B3F2BC0011;
	Thu,  8 Aug 2024 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APwAy045+0bwsYWXWzWi8kg7IB9CU666Ib602lP5Ma0=;
	b=Z7tiPkSquBYuysxXVyvnS9cQv0S9JOZc0m99D1zPD4Kz0WEfFEdnXqPBXOzbQb85DXcOPq
	QsceVUyNMTiOwMSmy60NPYobMWjMU9ahw/WhinD5FG592Kw+HNmn14JU6hF4mPsCr64Zgn
	34kO83WM9/Q4VlzRmJ945YavC+rnB2vmJgnQ8gNpvjr+0m/GnVUXGkCXWqSgLOKhLT9bdS
	Lf7N1SbfDD1dAET1BVj/nSAarFB/HbVOO/KI6pYgXiKzoRnxe81dCw1gRTFEa5TZ/Ith9f
	chjTTe25XYzIl9ts9EXCxrG3K2JeqFyDwiwYoRC28jjXFwcOeMHV6o/z7o6f7w==
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
Subject: [PATCH v2 05/36] soc: fsl: cpm1: tsa: Fix blank line and spaces
Date: Thu,  8 Aug 2024 09:10:58 +0200
Message-ID: <20240808071132.149251-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
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


