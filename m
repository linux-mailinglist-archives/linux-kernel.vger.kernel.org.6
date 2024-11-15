Return-Path: <linux-kernel+bounces-410847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80AE9CE642
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC3028103F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E671D5146;
	Fri, 15 Nov 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma2OP7ox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E501CEACD;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682737; cv=none; b=IHQJqHl6C243/E2w8LmIbMEjrnA0xdgsyVuClcHzY/T/KrhdbNgbJm4IaYYlI/jZ2F99khOWPmZ+VlUws0N4LILxos57697vIP6YVUJ0BHIYh/D+vVbedGpUHdK1w7wLh4wmUQmeG4iyuqoPKWwyFHB5YW0dFGzbdv3EKmUnE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682737; c=relaxed/simple;
	bh=Sj0biJtPCEO33Em1tTuS6bWdcbj9/N0ABNsn0QBrn54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F330vMMA/Z9WefORHfEmc42pF4f8+gkzsEmd3ofHRsiecnrOmmQo0KCQMgtFxScDGzVWKMTFbTwlssQfQ3e2z3Nwv/YapZmIMtrM1xCtKwwiMhDkKy7YI5uKvym2IjzTzvSVVKoA7E2gSI1saWOkihAreucZJykt1FuarB7sABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma2OP7ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 860F3C4CECF;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731682736;
	bh=Sj0biJtPCEO33Em1tTuS6bWdcbj9/N0ABNsn0QBrn54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ma2OP7oxNWtriCoB/ONEM0PTNcAZg8628XtDceTTp9SYpjNEZ2hmrv/7z9/tbQ/lW
	 Ev6RxYRvpVqz1HimKfyoEJoTDtrAH5zBm5JZshwzKrdEPD2m1aCiy/kA9usL0rrzgZ
	 Fgr1mISsfeR9hh9Z7oGXTG677Etm/oNckmz7Cy5q4pFEaE2NeqpttTklOSP+NOcCM5
	 8z2iqGiKpFuUUCCieAK6JLOCnBcRktgv30YzNDVprJ7QJDojP27ElOiFuMIqSGv6Z/
	 lD2gLSuG5XWgr0KDolcYuDSMr6485b44hI44kb7x+0eUSk3XT8t9x1mRzPFQ0mNKg6
	 BpktGV2kHWc7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C8D68BC5;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 15 Nov 2024 15:58:04 +0100
Subject: [PATCH 1/3] w1: ds2482: Add regulator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241115-ds2482-add-reg-v1-1-cc84b9aba126@gmail.com>
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
In-Reply-To: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731682735; l=2045;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=/MV/A5HBPIZ49zvbrwPtUxocg+GMGOHnltCMlTjv4CY=;
 b=4ujHrq56di8Z9ZW59yDJ2UvrZ4lzPNxqnEbXmS895tkdASU9WCcP1n0n3U/QdKMRGhqqUTcsz
 Gg/XxT94p41Bf82rGnCO70ssTogKAsM3Puf0QnfLB3mznqItpO7t8VS
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

Adds a support for attaching a supply regulator.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 drivers/w1/masters/ds2482.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index a2ecbb863c57f38bffc8e3cd463db1940e603179..3fb35e92fc1587dc4e609c0061fa5057e0027a80 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/w1.h>
 
@@ -117,6 +118,9 @@ struct ds2482_data {
 	u8			channel;
 	u8			read_prt;	/* see DS2482_PTR_CODE_xxx */
 	u8			reg_config;
+
+	/* reference to the optional regulator */
+	struct regulator *vcc_reg;
 };
 
 
@@ -445,6 +449,7 @@ static int ds2482_probe(struct i2c_client *client)
 	int err = -ENODEV;
 	int temp1;
 	int idx;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
@@ -457,6 +462,18 @@ static int ds2482_probe(struct i2c_client *client)
 		goto exit;
 	}
 
+	/* Get the vcc regulator */
+	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
+	if (IS_ERR(data->vcc_reg))
+		return PTR_ERR(data->vcc_reg);
+
+	/* Enable the vcc regulator */
+	ret = regulator_enable(data->vcc_reg);
+	if (ret) {
+		dev_err(&client->dev, "Fail to enable regulator\n");
+		return ret;
+	}
+
 	data->client = client;
 	i2c_set_clientdata(client, data);
 
@@ -517,6 +534,7 @@ static int ds2482_probe(struct i2c_client *client)
 			w1_remove_master_device(&data->w1_ch[idx].w1_bm);
 	}
 exit_free:
+	regulator_disable(data->vcc_reg);
 	kfree(data);
 exit:
 	return err;
@@ -533,6 +551,9 @@ static void ds2482_remove(struct i2c_client *client)
 			w1_remove_master_device(&data->w1_ch[idx].w1_bm);
 	}
 
+	/* Disable the vcc regulator */
+	regulator_disable(data->vcc_reg);
+
 	/* Free the memory */
 	kfree(data);
 }

-- 
2.39.5



