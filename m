Return-Path: <linux-kernel+bounces-361798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A699AD27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FE9B293AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2961D0E1A;
	Fri, 11 Oct 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="mrxrQaaa"
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F981CFEB8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676584; cv=none; b=f2el849e37o+me4OkNktmPBhzJH73YYwsKbmCuZkm3SRrTjTBuioM37a01qMlhN/i8z/d9pHOqIMKVDo0UpqcH17t0+z9/u8oCcufYC3idmJoGN5WMhxYLrS4Hc4/439RyjO0l3kfeoUQJ7IhRKIrBhwy5ocSCab7m83/aZ3nL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676584; c=relaxed/simple;
	bh=8LR9Z6ghOivEgPhmQWPce/uICa+nKNlOMnEnUP5xGr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFXV9SJ1lldzs3yv/KblvLXLcoxa1SL/q5vl5ObgXONHE82Y9PU+ipBQu96plcBqtj6nC6mT8Ayw9eFixthWDFNPaKKST51gqs86r5spSoDSCh9gXxRBEWSGAAQ+5v57GPQnYV96QPLMoEdHK36aJsYQxYy/9hlhgYeKX1KTnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=mrxrQaaa; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2rFZZQFRA+c4ZCPN/oeaVsnorbBt7/wbciGPcpiKU14=; b=mrxrQaaaRCG1VCrMmkUQJQa567
	3Zak1jAOtk9otya2/6KZsHeiJwe09wyg2GireWoDsRviZLLgGpNhg4xCxdhiu4EfNWvV4zL2x8uM2
	g4rcGCeOo3lwyzJyoBpGgvb2s9eU3bcGhfCcIwCrXnS7m2ascJukWBhrFEuymR/Mn85U=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szL4P-0000000039T-345i;
	Fri, 11 Oct 2024 21:13:01 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v2 1/8] misc: keba: Use variable ret for return values
Date: Fri, 11 Oct 2024 21:12:50 +0200
Message-Id: <20241011191257.19702-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241011191257.19702-1-gerhard@engleder-embedded.com>
References: <20241011191257.19702-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

One function of the cp500 driver uses the variable name retval for
return values but all others use the variable name ret. Use ret for
return values in all functions.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index ae0922817881..b5327feb2847 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -229,7 +229,7 @@ static void cp500_i2c_release(struct device *dev)
 
 static int cp500_register_i2c(struct cp500 *cp500)
 {
-	int retval;
+	int ret;
 
 	cp500->i2c = kzalloc(sizeof(*cp500->i2c), GFP_KERNEL);
 	if (!cp500->i2c)
@@ -251,19 +251,19 @@ static int cp500_register_i2c(struct cp500 *cp500)
 	cp500->i2c->info_size = ARRAY_SIZE(cp500_i2c_info);
 	cp500->i2c->info = cp500_i2c_info;
 
-	retval = auxiliary_device_init(&cp500->i2c->auxdev);
-	if (retval) {
+	ret = auxiliary_device_init(&cp500->i2c->auxdev);
+	if (ret) {
 		kfree(cp500->i2c);
 		cp500->i2c = NULL;
 
-		return retval;
+		return ret;
 	}
-	retval = __auxiliary_device_add(&cp500->i2c->auxdev, "keba");
-	if (retval) {
+	ret = __auxiliary_device_add(&cp500->i2c->auxdev, "keba");
+	if (ret) {
 		auxiliary_device_uninit(&cp500->i2c->auxdev);
 		cp500->i2c = NULL;
 
-		return retval;
+		return ret;
 	}
 
 	return 0;
-- 
2.39.2


