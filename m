Return-Path: <linux-kernel+bounces-425415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE79DC1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C38B236BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691619753F;
	Fri, 29 Nov 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEK6kWFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642718A6CF;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874182; cv=none; b=cOtX0dM4/rvX+wVLhvCMi+kU9NngR6eJWLPliApIQt56jdpXRYx7fsY8sLnZTj27be8+JXFzYCOj5UYCcE8oYMr+4mBqPpfj0JhKTUVLTylIECUejQ4Q0tg41sjAKMTEgdJw6NLvX7zybwPSJWVnURSumCyjJWnku0JrBkpfJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874182; c=relaxed/simple;
	bh=YVf818Wsim2mbu4lIsiFHOXltJLDqcRj2TBPT3CKcVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxiN3qbN4K2rm1phlo8J/PKm3F7TPknUaPvIP9+p2DJODNOrNBaNKuUOFjDyoxf8vRkNheYtpodhI+W3LwzothiPF+ndNah5sgErCIllkZUvblSFs/j+wZxaN873nLbSBkc077zsm9raBRJoBlrxmtOR25unWf/bgZwrcUrpvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEK6kWFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5EEAC4CEDF;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732874181;
	bh=YVf818Wsim2mbu4lIsiFHOXltJLDqcRj2TBPT3CKcVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nEK6kWFcUOThJLGi5BX2h9Z0Vg+mj/aOLhK0f3HG7PlQcvmUQc4SKSbZOs0EXIRjZ
	 4OCOW1Iu9B0+mCi4jue0EhxCG+BNsCWDS14I7wQavpe9k6Oz6tkvj/FYeU6dkwzwOh
	 qR5nBTNujB2M5tPdThPqPDSkTrR+ZdOZe4hAQmk34xAU+ZdKYqy6EjGYVhAhFIgj1x
	 hiBDRLqcGC9oeokEQ9cMoK97vulq7TIqobQyfcNYyDExaWmuLJ2/pM6YE5X0wg/Cto
	 uayAeakW25MK0Bqi1K/C9+G4/8NL2b+tBi+71fR8POtiveUx6VetRhpQVr6sQ0buTn
	 WDDxXARg1dIcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005DD6EBF2;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 10:53:18 +0100
Subject: [PATCH v5 3/4] w1: ds2482: Add regulator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v5-3-af8e83d41344@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732874180; l=1167;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=ORSul3n77E1q/jzP7L31MvdWj04FGrfU0fUd1F/Lh1A=;
 b=P7BE0+oekr36olNRl8rfrkOB65P0U7yDGcSWbW31D2RkfhGHOH+f+OR0K/9MsYace0CDchLFt
 9N1t3cf1kx4D7gHncQ/G5vdKaDM9GHPaO3VnlL5fSCzVP5YLI92wl59
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
index b2157869067d52f79d618e163b6cd96dbc7bee60..8c34c2e9a5a34e38ed097d7fbd965ec5b75e71d8 100644
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
@@ -455,6 +457,10 @@ static int ds2482_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
+	ret = devm_regulator_get_enable(&client->dev, "vcc");
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to enable regulator\n");
+
 	data->client = client;
 	i2c_set_clientdata(client, data);
 

-- 
2.39.5



