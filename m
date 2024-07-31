Return-Path: <linux-kernel+bounces-269736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BBF943642
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6296E1F23B01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640021607B0;
	Wed, 31 Jul 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY71z7fX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9748171092
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453261; cv=none; b=bCA2TUJ9xhKNH2TRG/4VWzCCV1Hx4/VI5g8Tr10WzqXqOsIDEKFiUkK0RdqWJGM4O7AueQh73PxH1Tpjrds/1P6ixVrpenW0jh4LVwwo2PCoF1tZ91/QgKnvAI2MHqxBtiZQJ06R+uE0qzyOVxGaiMuo5QaxWzw27A/lqHdUk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453261; c=relaxed/simple;
	bh=KQT8fK3Rr8Xw1l1AgpQStJCxN7+Te6zvQOz7w33vm14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSMUu6FagQY6uwJXtcDT6SH8gDap2sgeRCG2a9GS5eI2qWqrzaH9hu+MvBX7p4Jy3OoWtPxkT76KaskxSXzTX4rKT265fWqTz6opxw0AJud0ogMyHd8/o8P8BpN8TbrHwmQ49Iiheum8UYuWs3dhgOtwYRyB14XMAc2yS+9B6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY71z7fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63DBC4AF09;
	Wed, 31 Jul 2024 19:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453261;
	bh=KQT8fK3Rr8Xw1l1AgpQStJCxN7+Te6zvQOz7w33vm14=;
	h=From:To:Cc:Subject:Date:From;
	b=nY71z7fXXT/8X8it23Pc2xfferE47o7zrL8w2q1uW9DI0fX9fkFLXoE/LuRX3G+ub
	 5yIcGWHAfyqaVuHHq6S3Ia8I0iy3hogHvP7phBCUClhelNSfohCJkx/D3ur71l9luj
	 VcMVlkUQALZ3It8I902o6c01u9kcxdQ64ykYY52M27mst9UT9iXzxUVuIUnONbMZ7P
	 +gplURw/Anyk2LHRf0EA2d2X+vxHXRPk74t37sHHWaB7Yl6WivMTacJfJliCEyQ23V
	 vd0G2jGfjwpeKaKE1v9Lcrekky4aQwGEB0//uFRopzvN5IvQ0HQOxSI27lmRV5+L3g
	 YiSN3WxiBxXlw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: Use of_property_read_bool()
Date: Wed, 31 Jul 2024 13:13:02 -0600
Message-ID: <20240731191312.1710417-24-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_read_bool() to read boolean properties rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 4 +---
 drivers/regulator/max8997-regulator.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index a504b01dd99c..0457af23c55a 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -673,9 +673,7 @@ static int act8865_pmic_probe(struct i2c_client *client)
 
 		type = (unsigned long) id->data;
 
-		voltage_select = !!of_get_property(dev->of_node,
-						   "active-semi,vsel-high",
-						   NULL);
+		voltage_select = of_property_read_bool(dev->of_node, "active-semi,vsel-high");
 	} else {
 		type = i2c_id->driver_data;
 		pdata = dev_get_platdata(dev);
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 5f201ee9a5b8..cdbfb4561dd8 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -941,9 +941,8 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 			}
 		}
 
-		if (of_get_property(pmic_np,
-			"max8997,pmic-ignore-gpiodvs-side-effect", NULL))
-			pdata->ignore_gpiodvs_side_effect = true;
+		pdata->ignore_gpiodvs_side_effect = of_property_read_bool(pmic_np,
+			"max8997,pmic-ignore-gpiodvs-side-effect");
 
 		dvs_voltage_nr = 8;
 	}
-- 
2.43.0


