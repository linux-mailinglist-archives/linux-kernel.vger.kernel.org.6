Return-Path: <linux-kernel+bounces-420156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E454E9D75D0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093C5285682
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7818B48B;
	Sun, 24 Nov 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmvEyGmv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0B18859F;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732465299; cv=none; b=Tu0utpsuyK6a1pJjQLDjGn7XKvQU92ZNH/vzufqEExxhW4P67+vtJ5d6Wt70zbKbybXzEmHQvzUI5xwzQi2mhQ0PzQMEfpubALMCqysHxXkhcXVFECpFbLqHdlX2t1edLq/sKnHpYdcj/uGJxJdlPoXsZoOmOklfE8yx1N1n/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732465299; c=relaxed/simple;
	bh=jFHxl/CcdpT+1ad+wMyfaXUaG1jSfWsHaRs+VDYDqrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srE1xBmIGO9//oEhnkmlTK/xkjcH8rCaVjQoiF229wexedRuIo231rsKtBRrghl79LcHWWHdqKX9YzYza00Uw/jXgoVYscqOaQM1mqrPifJACGo/MvMI5016n4qSNThXTa1Aw7BHg48ptywAwGwr2o1TFYehDypgoHyLqoFj1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmvEyGmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BD8FC4CED3;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732465298;
	bh=jFHxl/CcdpT+1ad+wMyfaXUaG1jSfWsHaRs+VDYDqrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SmvEyGmvwaegMD0AtDV+SJOY3VXHVPBpksRwfc7gjnoZ3alPnZzA+Ae9PR4+bL2gV
	 DVv6jaQm1vbzVKgRITKCo9K8ol2Z+NrgjGxcUTjQBa6G5P6vyLSYpEMK1Ch97+WE9A
	 INIEnrOZSjWjEZVD6lE1jXBVMe2rDTHHX1b7kgCD7s9Qhre/JkijXFWoWREty0PxY+
	 nY7+67QdbANB1DmP8gtRfH4bIBO4h/IAJoN3i+Or5wRjmk36tpsekq0po4UNk4VOXw
	 x8z3Y71HoWQyZbI4XKQCqh0Ua9SHdkInbxXJ9N8wrL5x6czuvm7rPnJuR7JUOr85Pi
	 RMDOlCl/dyngw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B2E668BC;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Sun, 24 Nov 2024 17:21:35 +0100
Subject: [PATCH v3 1/3] w1: ds2482: Add regulator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241124-ds2482-add-reg-v3-1-806df39c9454@gmail.com>
References: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
In-Reply-To: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732465298; l=1158;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=H8N8tauiBMgbKBmqSSTyyRx/4y+QoyyhsjWOzpjAqZ0=;
 b=edK6aOOPZL4NDaAJIKVytq8Qt2/TbTj4o8lvGOE6bIG/3BrM1zzFc2py3zp/wuHSWnDKVNetQ
 9U69XAbyQf4BJFzcLr5RyZHDcRyeGIIiTOvYHc0D8zBKFamPrZFpg2h
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
 drivers/w1/masters/ds2482.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index a2ecbb863c57f38bffc8e3cd463db1940e603179..4cb05d00cb6743abc5699583f591ef9b5339b44e 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/w1.h>
 
@@ -445,6 +446,7 @@ static int ds2482_probe(struct i2c_client *client)
 	int err = -ENODEV;
 	int temp1;
 	int idx;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
@@ -457,6 +459,12 @@ static int ds2482_probe(struct i2c_client *client)
 		goto exit;
 	}
 
+	ret = devm_regulator_get_enable(&client->dev, "vcc");
+	if (ret) {
+		dev_err(&client->dev, "Fail to enable regulator\n");
+		return ret;
+	}
+
 	data->client = client;
 	i2c_set_clientdata(client, data);
 

-- 
2.39.5



