Return-Path: <linux-kernel+bounces-410927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104DE9CF086
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA44828F892
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F321D5CF2;
	Fri, 15 Nov 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mbBTNsRo"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD21D5CC4;
	Fri, 15 Nov 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685157; cv=none; b=I1tpTnQk2EmbODzbQsfPrsJBJUtcQJyypmYXdY0Hf8VGh0aPx8BltBcV5E4c6yKy3zSgNPleeP878YJa9BvETB80cUVHyQM17c9vNBkvSHH6uSUMskvlXY905cMX8Vnr2+XUNUrk7QwbIKOtO76Dtu1h8RXixyvZZ1G9tHY0840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685157; c=relaxed/simple;
	bh=bggjSsff92I5nfqkHZKLXAtnYfyMCNcWpoDAFa1s/UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r89/1TIjJLsWvMfVfQSwDKJE72BbaiCaUiBSF/yrzwWnIU+jnzIc/jPmH8zRF6ygTFsSfZh7B9KLp6c9Cgb/8pGWtn8h6CX9Ol28E9Nid3byMcCYOA9ufETYVrbydb4RhWE278V5J03/7PkZiXyYllK6BvhLiFqdmisNXF5g0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mbBTNsRo; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCCE16000C;
	Fri, 15 Nov 2024 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731685154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWKzQLDi1P0e2NgDvgc4yHfOyzr35Ho5+wgbJLaL+w0=;
	b=mbBTNsRo4uOpviUof5tlg8N5vrn3z8WqBteUnTJn9tFWx7hvVM8Q/vJYSlnQX6R+qhOLXb
	KrSilBohe6lMJ2CUXbP1udDcxoAqOWVEgTXmGVBW386pGQcMc7xI36dDtu7QaVVUtLIWor
	SOPj8z4tOvekXkQe827+v2knHX8AXyOiHZwhCg7KAOhXa199lekJ7XIp5KLTlXW001ijFC
	WhMt0TOxnpDO+naemMJLkoN89rXGxFw3366hxRfXN0dIL4hSPiH4LP9Yp0mRe8VeKiZvH5
	IWiv1z2aScTeg92PQUBpzk30GYNnm9l1i5MNHrQk+5mFMFbDp4357O2BoJNvVw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 15 Nov 2024 16:39:09 +0100
Subject: [PATCH v3 2/2] mfd: cgbc: add a hwmon cell
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-congatec-board-controller-hwmon-v3-2-1c45637c8266@bootlin.com>
References: <20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com>
In-Reply-To: <20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

The Board Controller has some internal sensors.
Add a hwmon cell for the cgbc-hwmon driver which adds support for
temperature, voltage, current and fan sensors.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 93004a6b29c1..7cc2872235ac 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -236,6 +236,7 @@ static struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-gpio"	},
 	{ .name = "cgbc-i2c", .id = 1 },
 	{ .name = "cgbc-i2c", .id = 2 },
+	{ .name = "cgbc-hwmon"	},
 };
 
 static int cgbc_map(struct cgbc_device_data *cgbc)

-- 
2.39.5


