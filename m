Return-Path: <linux-kernel+bounces-425417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD3A9DC1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43170280C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FAB197558;
	Fri, 29 Nov 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHYO3BSD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C318A935;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874182; cv=none; b=iN2jlS1bpNAq2Kmozo4g/vjzqY8UrUZdSLCOBTn2oHlf+i04UNT6gzzNHV1QCHQ0PRo2vE/9dz3dXe/GEa9lnKYx3Jm3hcb8Q4qPmNDDjf9x2BVz0bs/ub+tXmdAs980V7odJ6VtT7imsnJvA5a94Mj8202aJhHRnWG8y9+9WxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874182; c=relaxed/simple;
	bh=MhPSEDh9nPbDTYwLillRJ4q9K/uZViNEMnUOCJ5My4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dafhNkK1qgvHcj0wmkVL78eqv2qQzqFZ3g8jcOAzHb4Wcm4m5OkwteYjbactiScaPBR1nfajeoPfn5nU7GkdssjfK4IU8nGtmtzZShnDhhc5a5rBLO7ZezdrIFMDKws7LDWbI96f1euUgJr4SO9M+PBlKgX55bPS0ZI2Z78RXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHYO3BSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F305C4CED9;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732874181;
	bh=MhPSEDh9nPbDTYwLillRJ4q9K/uZViNEMnUOCJ5My4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PHYO3BSDXhA739o2ru6nC6m/vNbFSU9kQBlAgrrSacPzeuHEG8i+reKtAsJZGLnaT
	 s6157IULOu2UiXUj1kB5RKIXKiFeGlywqUpSx0QLr6OIxGt0Xnf5vcnOpHfpbJ0VIL
	 +Lfym0iemNa5u0MiyUKGbmsbBJLwAtIopr4S2odaRh54oEpCtseirKVeoakRzPW3ML
	 uhW/ktx4EywRCcf/VD+7bJkrPnJ94rvwZ+WPgLpNyz1BbzxBE60rIl8Lu+5/Tmijw0
	 tkn0PlJNXC6zzd23z0NhRWzzNg/lroSxnU8Zl1Uw+kPtn3MlUvrTdZmGA/K49IMSzI
	 EZ/LCq5+FuwMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8344CD6EBF6;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 10:53:17 +0100
Subject: [PATCH v5 2/4] w1: ds2482: switch to devm_kzalloc() from kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v5-2-af8e83d41344@gmail.com>
References: <20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com>
In-Reply-To: <20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732874180; l=2540;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=85jsX+YFwJTBnGA69duIqiPwKPoBcjMjdnBr1eB0RA0=;
 b=W1Q+FumymcH5SQxo82c1E+HTh5Wsh5iywz+Op1fle7O7B9Xd4f4g+fEJ98G1yTac3HZXZ+Ld1
 8qGOjJ2MHzoCWO6ZOM+eOIJwCc+4uTN/qLZ/afnVZT8pkoQz2hhA5zu
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

Refactored the driver to devm_kzalloc() from kzalloc(), so the future
driver edits are easier and less error-prone.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 drivers/w1/masters/ds2482.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index a2ecbb863c57f38bffc8e3cd463db1940e603179..b2157869067d52f79d618e163b6cd96dbc7bee60 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -451,11 +451,9 @@ static int ds2482_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct ds2482_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct ds2482_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->client = client;
 	i2c_set_clientdata(client, data);
@@ -463,7 +461,7 @@ static int ds2482_probe(struct i2c_client *client)
 	/* Reset the device (sets the read_ptr to status) */
 	if (ds2482_send_cmd(data, DS2482_CMD_RESET) < 0) {
 		dev_warn(&client->dev, "DS2482 reset failed.\n");
-		goto exit_free;
+		return err;
 	}
 
 	/* Sleep at least 525ns to allow the reset to complete */
@@ -474,7 +472,7 @@ static int ds2482_probe(struct i2c_client *client)
 	if (temp1 != (DS2482_REG_STS_LL | DS2482_REG_STS_RST)) {
 		dev_warn(&client->dev, "DS2482 reset status "
 			 "0x%02X - not a DS2482\n", temp1);
-		goto exit_free;
+		return err;
 	}
 
 	/* Detect the 8-port version */
@@ -505,21 +503,15 @@ static int ds2482_probe(struct i2c_client *client)
 		err = w1_add_master_device(&data->w1_ch[idx].w1_bm);
 		if (err) {
 			data->w1_ch[idx].pdev = NULL;
-			goto exit_w1_remove;
+			for (idx = 0; idx < data->w1_count; idx++) {
+				if (data->w1_ch[idx].pdev != NULL)
+					w1_remove_master_device(&data->w1_ch[idx].w1_bm);
+			}
+			return err;
 		}
 	}
 
 	return 0;
-
-exit_w1_remove:
-	for (idx = 0; idx < data->w1_count; idx++) {
-		if (data->w1_ch[idx].pdev != NULL)
-			w1_remove_master_device(&data->w1_ch[idx].w1_bm);
-	}
-exit_free:
-	kfree(data);
-exit:
-	return err;
 }
 
 static void ds2482_remove(struct i2c_client *client)
@@ -532,9 +524,6 @@ static void ds2482_remove(struct i2c_client *client)
 		if (data->w1_ch[idx].pdev != NULL)
 			w1_remove_master_device(&data->w1_ch[idx].w1_bm);
 	}
-
-	/* Free the memory */
-	kfree(data);
 }
 
 /*

-- 
2.39.5



