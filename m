Return-Path: <linux-kernel+bounces-175762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815B8C248B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2DA1C2468B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B6171086;
	Fri, 10 May 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="rSp4xsks"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D116F82A;
	Fri, 10 May 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342817; cv=none; b=WNbQjN/Pc3pFUdROP6/jNRIMb8+Vl0BvDjqpz1djcbXgrICaojtPc81JNHmIalupBDez039zQhEWSJryqOv3fSaXs8WF5XLl2rvlT7BilJ5L/oNYrk/jV4X0orKp95JeoIzklRHw+2dniQOc4Y544nrlRAlKmkSi5e4smZW+zOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342817; c=relaxed/simple;
	bh=alAAcYWNGVr0LO9THbHu1S/9Bb/OIKBbEuXmlziafj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWCVELJdEwvTA02xYpdqU9rYZjRDkc6vnlGWLbWKEW6wyCvkutH+uQb0pJ/ifSr9GKZKZlfvKfQslOlZM5ZISwg4NtqYv44lEaVsNUVwTz2pfOCfF5vNe7O/eu7D/MeNPZ8uaGDupPWJVmu2aCdkYJXC7EMmZgVVWRSF3e8Sy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=rSp4xsks; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715342805;
	bh=CyjaSK4ROBhTrLFjC+OEFF7KNjcR72P0QQWCODQsyf8=; l=1305;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=rSp4xskspn2afF4ottBCrarrQXdhxnmclugK41/q/gjJgBdQCorKnXU+BuHguOTKz
	 V7UtFt/ejnBpoBsrMRgFA/18tI711qXDKgqpb8cWZGevo/8Fa80ogU3ZyWW+aMsWFk
	 jEakmFi2bl9LUm7jaEE9iT3CikLpq7GyNWJY9KpWjI6JTCOPh0zE40rCatk4KXlNT/
	 47un43UgvPhFkIhjPEHFaI6YD10+Opmtdkut6FkYq6qnGVqvVRTuJmqvRX8GEHF6pY
	 U/tbxeuqFElEZxDq4Bo4jo5X+XSd73FsdDHXf7c6WIEFePW9w3/I73DhD8L2Y6FKHx
	 tsWncPCDKGzqg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213196:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:06:32 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:06:32 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:06:32 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v3 4/6] regulator: rtq2208: Fix the BUCK ramp_delay range to maximum of 16mVstep/us
Date: Fri, 10 May 2024 20:06:23 +0800
Message-ID: <77fc604a10f4a3055c2c29ff6aa7a253a8b9bc7f.1715340537.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1715340537.git.alina_yu@richtek.com>
References: <cover.1715340537.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The maximum ramp up and down range of BUCK are shorten
 from 64mVstep/us to 16mVstep/us.
Therefore, the RTQ2208_RAMP_VALUE_MAX_uV is modified
 to 16000uV in this version.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index cea8e77..2e9387f 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -53,7 +53,7 @@
 
 /* Value */
 #define RTQ2208_RAMP_VALUE_MIN_uV		500
-#define RTQ2208_RAMP_VALUE_MAX_uV		64000
+#define RTQ2208_RAMP_VALUE_MAX_uV		16000
 
 #define RTQ2208_BUCK_MASK(uv_irq, ov_irq)	(1 << ((uv_irq) % 8) | 1 << ((ov_irq) % 8))
 
@@ -147,12 +147,11 @@ static int rtq2208_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 	 * Because the relation of seleltion and value is like that
 	 *
 	 * seletion: value
-	 * 000: 64mv
-	 * 001: 32mv
+	 * 010: 16mv
 	 * ...
 	 * 111: 0.5mv
 	 *
-	 * For example, if I would like to select 64mv, the fls(ramp_delay) - 1 will be 0b111,
+	 * For example, if I would like to select 16mv, the fls(ramp_delay) - 1 will be 0b010,
 	 * and I need to use 0b111 - sel to do the shifting
 	 */
 
-- 
2.7.4


