Return-Path: <linux-kernel+bounces-430886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A79E36DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A820285BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A31ABEA0;
	Wed,  4 Dec 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YfC0a/iq"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6F19D886
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305407; cv=none; b=CfwOGUB8CvfNc6PIAsAGlTK1ntc/BpyywZT6KUusSpD22mKjB1pe3mdQjQT3gDOLvVYLCdaD2YIv+i8xbusskqiymHLSwISxZHs8RXw/wNH45ohv3zpMuzCRFhMtiRelm4MwlaVrSnwle5ygw/kIXx/w063wDW258h0qabQFWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305407; c=relaxed/simple;
	bh=Jx0cZcAd/Y4z/J4hjp0CxR93YUQWm4nasJ9hkxM6Qpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcxSvEw+co1TK6l1drqkBc9kOzR6EvukR1GwTxADLnX8Dxp7yaoma0hgsshYoi1zTQO69Qwe40nv9xo3d7FbhkxPngnptgtaiV1BNv3OLztzdCf+1b+zX6mrmhkDpbVicuXMjLyGBITpGAQv4xBWXTsIyMZZa6rUA6GwJ2Yn+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YfC0a/iq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAFF36000B;
	Wed,  4 Dec 2024 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733305404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVdYJysLi5n1RUC9YCAebU4m2JnvzkI3+7eLaZOZoto=;
	b=YfC0a/iqtP4VitNKQCBacFOdIXuFnZvGCOcyKRHCZ8PBNoPmiQuSpaqchX3zQ6QFc0L1sj
	mmx4fN1QTv3INfgHsjtikiE5eplc9NOfV6BLLKLyITrDlB08LuGCouHMb+LTlxnDN7xMkE
	D3rb3S6Mb4cqIRMIoZV3yHEkktoDfVajTtUgo7+ub25uLBFuxo4ExutgyQfZJmCIOvpNnb
	4siKZwd1gNOmeJq1Z5niaDN0VB47KDRx9aIa5QdFjfRn9S+BZGOuoy4h92nRb4sDS6ePL9
	Za7oglhBuQyUr1E9BrhjxG04qyJ1K1FLtrPe2bVKoerkpSVVsZVI8R5pawVrtQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v5 2/9] memory: ti-aemif: Remove unnecessary local variables
Date: Wed,  4 Dec 2024 10:43:12 +0100
Message-ID: <20241204094319.1050826-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
References: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

CS timings are copied to local variables that are then used as is,
without any modifications.

Remove these unneeded local variables and deal directly with the timings
stored in the struct aemif_cs_data.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/ti-aemif.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index f23a549b219b..a0e1a6b53256 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -174,22 +174,14 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 {
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
 	struct aemif_cs_data *data = &aemif->cs_data[csnum];
-	int ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
 	unsigned offset;
 	u32 set, val;
 
 	offset = A1CR_OFFSET + (data->cs - aemif->cs_offset) * 4;
 
-	ta	=  data->ta;
-	rhold	=  data->rhold;
-	rstrobe	=  data->rstrobe;
-	rsetup	=  data->rsetup;
-	whold	=  data->whold;
-	wstrobe	=  data->wstrobe;
-	wsetup	=  data->wsetup;
-
-	set = TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) | RSETUP(rsetup) |
-		WHOLD(whold) | WSTROBE(wstrobe) | WSETUP(wsetup);
+	set = TA(data->ta) |
+		RHOLD(data->rhold) | RSTROBE(data->rstrobe) | RSETUP(data->rsetup) |
+		WHOLD(data->whold) | WSTROBE(data->wstrobe) | WSETUP(data->wsetup);
 
 	set |= (data->asize & ACR_ASIZE_MASK);
 	if (data->enable_ew)
-- 
2.47.0


