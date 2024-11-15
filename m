Return-Path: <linux-kernel+bounces-410695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF89CDFDF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD32B273F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555D1BF7FC;
	Fri, 15 Nov 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iDYt4TIz"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5251BC08B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677198; cv=none; b=IELdv5xEZdOhJBuX/a354tgRUW3Jt9em1SaMsNKF1KmBABciL8HQT3dbndf9Ek63DiNxTMoDJGJeGVOegnqDzlo9P2Ij5yKfPVhYPwB2fSUvNGajQIii5ENW2EAPMC5bCcXwwE26nFbwcKvX+ocVAocDBp4znkcrRGW2O4AyK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677198; c=relaxed/simple;
	bh=oY59SY6A6wqY/ptcdG2ON7Jn8L80m9u4SbJJfcOy3fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khG6kq1WSgPK9+cq1/kf7+w29aITBVI6UzSFTkze0W/9HCpmdaYJsmXW2nonvDNMysh2ydE6EERChWeHEN6OaUjgSByftb6GO5qyw6dUtP3SIFhaLEmaDzA0a+w7V7ARcahztm7kGHYu/N0IpJBCaaSmJ1KALIIBwW/l8j2q5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iDYt4TIz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C27AE2000A;
	Fri, 15 Nov 2024 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731677195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOO57gCrd7kA1kaHAYAJHP1GvAJRJefE1dAecm/19NU=;
	b=iDYt4TIzHr8+xIODoea7yrM2qFW2zm4jTncX33Zx04rUY7qPZeO9m4e6/edL58GDsvhp4n
	GjJA2z/K3UTok+8dqxyVopUp9QgWs4fw1BOOdAVJhbrUxJoi84O0qt8Ui+9uLNy/nTyLwz
	xiNgfED64pWf2ivKlfR/5EVKT52LxiyULJE5hXu1YOl+udl2LUKJbjzuM9wEWVxQJtY1bS
	JS8LBWETImXtwkbb5Zx1AtxI/Wu3RTRUwCNrfJ0nbfCW9jWmHwx/Li0qsWPjNtEF/+JoPf
	bLvu40SVZCQe+fBroW8ut68nGlCb46gjf69tBEu9+fehf1oosU8IQCGrt9eFpA==
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
Subject: [PATCH v4 02/10] memory: ti-aemif: Remove unnecessary local variables
Date: Fri, 15 Nov 2024 14:26:23 +0100
Message-ID: <20241115132631.264609-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
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
---
 drivers/memory/ti-aemif.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index bd0c49ba1939..6a751a23d41a 100644
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


