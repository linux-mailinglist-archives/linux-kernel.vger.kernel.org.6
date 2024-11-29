Return-Path: <linux-kernel+bounces-421704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E434E9D8EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90628164781
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAAA1CEE8D;
	Mon, 25 Nov 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp5DTPDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7121BE854;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574913; cv=none; b=K4GpCmeaI1sdCCqOtjaQBLwUSp17abFTqD1RDWT6DlXK+F2wv40xmqI57HnUSnFRCUkCsALcEFQJU6vnqF0TS2RoTOd6wixvmX6kuDFDoHEv8q4iv/RruTvRcurxnjagkZOBQK+PF/UMzAdP6lPfhI0PUqDY7Oz5woFqR5bMgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574913; c=relaxed/simple;
	bh=2fhklNkKobwrfGGMkjvlMLbM6UUj9Uy8iut3evLfmPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQ+j40cMy52hId1Tn+Mn3bGVekNO0hQAfnMlfDBRokGqLYDhVF1BF3uiFZkYs9LxMWyyY3+uvtQ80XyqAkQykRylnoUHgY5aI66fmZ81YsyhT5UhMTfO2kJjknqeeoPoYRKeO3/aKx++zk20v0iqjJBntFKmgTNklWuwJemU1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp5DTPDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80886C4CECF;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732574913;
	bh=2fhklNkKobwrfGGMkjvlMLbM6UUj9Uy8iut3evLfmPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bp5DTPDe3tgWcibCMoTuXi2tP940D8AbiRFEiLBMqGftV3EEXmd8rggiN32X6Zpyk
	 t2t5B9gVGPdgQqjpABYpJYjcSczxizjehmOBo+Hu3EEoj9sYYHVrnokmg49q03v5TW
	 dlKRm4ZiP0PesPXhaxvAXh4Uu/ul6Jypc1tFrQ4q+9iQU6HiP0D53u25UkfYZG9ob1
	 ++VaBNm53LDPhxxtzOMA5mqHeSHkXqG/jswAMgKXz7YbMe/dWq20/vmnut8ZpY4NF9
	 eIrxZEGNWwDXbY0HY7KdveTTx4IyZESU/nIVeOBaqG3LyeGCjw1Tbh4DR7neWxbVqm
	 Q8gSsTFw5syOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72679D59D7F;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Mon, 25 Nov 2024 23:47:19 +0100
Subject: [PATCH v4 2/3] w1: ds2482: Add regulator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-ds2482-add-reg-v4-2-475a7a08df96@gmail.com>
References: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
In-Reply-To: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732574911; l=1153;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=ZVLH9FCOXjNMCzUhrLMcjGrb/+QHtd7lqHIOEQnbQ0A=;
 b=NGjcReCZm694x2vbivM2YHW7Pxb0cSlRh98mzsM6xWcMWK+YhwEtRGg7u78/K2fImYvl5cIkT
 1AP025PTO7dC35XJ2fcIu7/SrdTy7z49S/TYgPRVPNUd37pV3HxzkW8
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
 drivers/w1/masters/ds2482.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index a2ecbb863c57f38bffc8e3cd463db1940e603179..2e5bbe11d8a0cdabd12e89e22537423749e7f9ff 100644
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
@@ -457,6 +459,10 @@ static int ds2482_probe(struct i2c_client *client)
 		goto exit;
 	}
 
+	ret = devm_regulator_get_enable(&client->dev, "vcc");
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to enable regulator\n");
+
 	data->client = client;
 	i2c_set_clientdata(client, data);
 

-- 
2.39.5



