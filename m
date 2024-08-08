Return-Path: <linux-kernel+bounces-278967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB494B73C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85341C234F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB818990E;
	Thu,  8 Aug 2024 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b/7FZ3bx"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D77187FE7;
	Thu,  8 Aug 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101110; cv=none; b=teVWzaM5bv2WlAavO6EjWKtwMQ8CEdeQkKTgU8My5t6+hZcmj0hmse8q242SKsiR6LwcPkqMw/nh6MTrF2Ylxuo9mSWkoM7McCetI2n5fifTP5HB6M9cyOhFxgB5JQlUa1ZLM6ozJSQiVuY9zs6xq/hBhmePUcRQ78HYjPlVbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101110; c=relaxed/simple;
	bh=iVNWSi0k1VEfK2L/iLOqSKxyF8ArKtoRwoj+w+5eHEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7Rg7VZMhZtMALELMiG+tcYv9OqQCRyy9zQChV+7/Zwaa1h5x0wsh71AhrDvLnkprEoi3W6gsWBwf800y3Vq8DVZ4ESq5FQid5x7v9eZ+v5WuhEZ0qTlQW6tUdhghXUppydJzFV44Inv0MWvZ45Yb/+BipDpqZv6yFDFtqTEzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b/7FZ3bx; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D49C4C000F;
	Thu,  8 Aug 2024 07:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CMTNP6nIDlPN6mndO+22CDidWRq33DXdG24hHtwqOs=;
	b=b/7FZ3bxk2VwTGeRteJCLCnnOHnlEyFnzH6XfwV3duaSwJmncP8myLRxUpnnXJtUXW/qsv
	5Em9q4/rVkujsA2imLjiG9YLBxHW01CB7s+xgOUO0J7wpvHeSOEJCo9GY2+mYR8vyC+Ukq
	lb1v9pOd4AoYoaD3WXKTSNehBay38/8xkSH95xkUu0wyVl8usmT9D0zgUtNyqJDWiJ2ixD
	YPyHSjIIRR9A/jvMyMobA611eqgaU72jusrBxKhzvBHd9mVTY6IwM0Htr9x1eg0NP6fKgp
	xDsxHrUH2ilQwccyEMeBwFtlGTj70iNGNoLqFlKc//FBtNT587tFzGP4AgSaXA==
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
Subject: [PATCH v2 09/36] soc: fsl: cpm1: tsa: Use ARRAY_SIZE() instead of hardcoded integer values
Date: Thu,  8 Aug 2024 09:11:02 +0200
Message-ID: <20240808071132.149251-10-herve.codina@bootlin.com>
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


