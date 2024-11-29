Return-Path: <linux-kernel+bounces-425599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3BB9DE786
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029582812A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BBE19FA9D;
	Fri, 29 Nov 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3I/re43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621619E7D0;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886923; cv=none; b=tPVg8D9sa4VVDd0dg0O8M5lDMz01TLu/KxIgd3XSqCdxX3/puVbuOl6piTO4zETDpLI1aqIYPwj7yHHqCfuzyA7EUSpXgHYhaBn1IFXzqpHpTsr5+ZIFoxUrBLlcir2Ey3vWxkA1Ugrr4a3UatQvUzlrVhv9dBUOCUUI0JXeQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886923; c=relaxed/simple;
	bh=A/M/oPTuQfgHJqwfE3HriTeOkqF8GxGkZFtP6/h3n3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAxyswUyDO8hdkJ0Z4J8C9BVA0GrpVXstZN5Ri30btXvUc1s71AuRrIWI3osM+GdnPOXeFMHI2NSQDZah6a9Mv+xiysyNyhrfPu9DLVu0VhS+OKzPjlBT+EfDfG3GzIbFkGw1QjzpulRXaye7Ek3CU+IzKLp2FMaQJTyRUNLjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3I/re43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19EC6C4CED4;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732886923;
	bh=A/M/oPTuQfgHJqwfE3HriTeOkqF8GxGkZFtP6/h3n3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r3I/re43rz74/A6njfCOX+OaRoTh+XU/ce90/agPS62Yc7DuP30/bxmWxDoxofD8H
	 Xa0UxqqFo4w1mOgQL/vGMth3XG5ckt2G+uEVcOPboEQmx4Yy3GAqEloe67k3Mir4QJ
	 UEHPj0jCuqMttB97WRDPEftuYO/z6wuFe92r4rQ+bfu0viANKL4J3xJxj5KlDMPN9/
	 GQCmkici+5iN4FDbWfuKdvyJesmEOI8W6wS5tWRwSTclndTKM4+opMulqh5OI2rlN+
	 JyeFT+SdQBGLsFBzPEiRzoBIOrTjJBNDC/Q1vX6O9caUoKmKIO57lhFoHxaS4yDfz1
	 TjJj1hPGMRfhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D4CD6EC0B;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 14:25:54 +0100
Subject: [PATCH v6 2/4] w1: ds2482: switch to devm_kzalloc() from kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v6-2-bd95ad171e19@gmail.com>
References: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
In-Reply-To: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732886921; l=2068;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=r4HVfq3WAwi6F3AX46+WcwKM8Ii59ByUGgCfyK+yu30=;
 b=BO1ISe0hqX21/wwhWEHRks4IMQalS2BfDfDT/m1Zlt9LHImsYLiXjP9vyEmEaC07XSGyEJ4Tl
 SJYLxUx7CLDDP1obJX0ROf9SjF96MfxWiSImfoFvqHCmh5lvBcUak+Y
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
 drivers/w1/masters/ds2482.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index a2ecbb863c57f38bffc8e3cd463db1940e603179..ea09d2ee21ccac27783a19547e988694ca171b91 100644
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
@@ -516,9 +514,6 @@ static int ds2482_probe(struct i2c_client *client)
 		if (data->w1_ch[idx].pdev != NULL)
 			w1_remove_master_device(&data->w1_ch[idx].w1_bm);
 	}
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -532,9 +527,6 @@ static void ds2482_remove(struct i2c_client *client)
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



