Return-Path: <linux-kernel+bounces-265903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ACD93F788
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155A6282CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0218158D6A;
	Mon, 29 Jul 2024 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WGI9iWGX"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8315534D;
	Mon, 29 Jul 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262885; cv=none; b=LnLa1Y13kU7DKuBGxtfJ6WSOdwCIoQvXjbcX+kKIKKqFJ6MfiaArnIHPLveilOdvyXEePu3IOdsWk2fiRe7qWjXOwbFTSrXfd93ERoRdX5HcOTfJtZsK/qKsyid9/iVasg5XxzXFj1owWFIhBw8UpzYiUwHFqjAlc1jEUfr+BoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262885; c=relaxed/simple;
	bh=iVNWSi0k1VEfK2L/iLOqSKxyF8ArKtoRwoj+w+5eHEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7xd+ksvH+bUsABHGBANH2DZEDdlkiodoqTwoDxphcGeUR4pVS5rNsbeo33xUTc/8cnayKnEkpg/RmxnEW678Zohb4ll0locYWkg2ub3fM8nkUtjrZJsQv26VmWKQxpvPerE5Q+y3T1apjlvAr6PGH5r/Z4RFm/Vp4AUtOS3rHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WGI9iWGX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4A950240002;
	Mon, 29 Jul 2024 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CMTNP6nIDlPN6mndO+22CDidWRq33DXdG24hHtwqOs=;
	b=WGI9iWGXuYuJgKNp12X9G1lvRUkSv8XXk9oR7Og9j5CpEERltmgiYlAXBz0U9pN7uKmvbT
	0hc7ZbzQLChp7hw027Rx2BEW0pqNLhckpGXneA6L6dP34kOESGAqyaCBzgrIx3IeFWBBYS
	vUxUTurkrW2pOW0DMBx6o/gNIbcP2wpXU4JiIDVZdmCM509s+xBOGhxHHvOMFKAzkCpVF4
	eEs4oybJ7eFsUpvQ1olAT++s+/sxFrIyU02f28Hoa1XMUtIUb9bLnEG60LL2uNe95FIXOb
	E68kh5UV+RH16Z66flSkr3ot6u2ATvvDSSmCxWmgLiCS3wf56lxABEnPxeriwQ==
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
Subject: [PATCH v1 09/36] soc: fsl: cpm1: tsa: Use ARRAY_SIZE() instead of hardcoded integer values
Date: Mon, 29 Jul 2024 16:20:38 +0200
Message-ID: <20240729142107.104574-10-herve.codina@bootlin.com>
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

Loops handling the tdm array use hardcoded size and the initialization
part uses hardcoded indexes to initialize the array.

Use ARRAY_SIZE() to avoid the hardcoded size and initialize the array
using a loop.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 244d521d8780..3d0c31a62dbb 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -448,8 +448,8 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 	int i;
 
 	tsa->tdms = 0;
-	tsa->tdm[0].is_enable = false;
-	tsa->tdm[1].is_enable = false;
+	for (i = 0; i < ARRAY_SIZE(tsa->tdm); i++)
+		tsa->tdm[i].is_enable = false;
 
 	for_each_available_child_of_node(np, tdm_np) {
 		ret = of_property_read_u32(tdm_np, "reg", &tdm_id);
@@ -609,7 +609,7 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 	return 0;
 
 err:
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < ARRAY_SIZE(tsa->tdm); i++) {
 		if (tsa->tdm[i].l1rsync_clk) {
 			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
 			clk_put(tsa->tdm[i].l1rsync_clk);
@@ -710,7 +710,7 @@ static void tsa_remove(struct platform_device *pdev)
 	struct tsa *tsa = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < ARRAY_SIZE(tsa->tdm); i++) {
 		if (tsa->tdm[i].l1rsync_clk) {
 			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
 			clk_put(tsa->tdm[i].l1rsync_clk);
-- 
2.45.0


