Return-Path: <linux-kernel+bounces-425597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F09DE789
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFB3B22C37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A8E19F49F;
	Fri, 29 Nov 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvXY2jey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E8819C566;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886923; cv=none; b=QawwJnG2J6FNDTFNbm5ZpHA3i5EWhO7lhWc5diXMPGa5zVGqYzq2/G9KKjUbrqxPCciRzH0FaZwTFELLbSKxC2Q9bBjlEWf24XN05mkvD+HZUqe4Hx1yeeBwhbt2DNn+Mj3lhmFS3T5ZX0do/KZ4ludQFqDzBRuURR1peEmiRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886923; c=relaxed/simple;
	bh=lBnKRMCcH3PxJSiw8dE7f+tj7U7HWHF/jUITOG7bYl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLZux/9NrlKUYjb3ndENjh96yIFcqfLq39+CBWqaWSGYgf/r59oQbEioGuDw3JEePvaV5Bv3GVF2xjYRjow/u7FnXAdN8YMOVxvCA4Pevw2Yh39QVcYdRc7Efr2/lsuTnw6Pzqg+DyJgxwtrFxYLTpCW1+0y6DprBAy7RElEAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvXY2jey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 275ACC4CED7;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732886923;
	bh=lBnKRMCcH3PxJSiw8dE7f+tj7U7HWHF/jUITOG7bYl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pvXY2jeyD3w0TffYYXn00713qshC7IjyPR36WsawiEQ7QnVhzvI7OiN9TLnlnkVPr
	 6KCcRMz9x3lJSB/gvObO4EPGHDGovizacNwqPRBno576xY1tdU8WTBgnhJs1q3Zz28
	 QSEBCNykGHqSCg2Qcv63wrG2Lz6jGDbjrkUbTe7vugI60tIcZo+GxIcxb8Vdtg09Si
	 OQTbPFdSBJgpFxaXRQFKIvlv0FAbsUHE4dLH9a1gW51qEN3zngG0/RPXcvPHE9zVrx
	 TaLyvHocyPurbt5t7UW5hnokj05Z2P3DlX9/qBO4iqY9pVES83K7YTBoL/Tz6rQXki
	 79xwpuc1ZwLMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18106D6EC0D;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 14:25:55 +0100
Subject: [PATCH v6 3/4] w1: ds2482: Add regulator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v6-3-bd95ad171e19@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732886921; l=1167;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=ZNdNnRwO64lpwOVc2mLzGiHi0iiUtX2t971DmgjvJRM=;
 b=QtI1fYsd0HQcfegVRNzgWKFIH/6GVtdnErLdTiqOytFf6QWo86DwmMMwqkL1/7syzCM3E4Cru
 LMqydw+d7+SBI4KF4R5RXDjWEHhGYWFr8th4Ux2Ev6k/l+clsPuywgT
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
index ea09d2ee21ccac27783a19547e988694ca171b91..f8095264d82f0e0135492ed65e71df74c71bcd65 100644
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



