Return-Path: <linux-kernel+bounces-324514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13200974D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3822B1C211FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E8183CD2;
	Wed, 11 Sep 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KhLxu08J"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C742AAD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044800; cv=none; b=dWmE4q3eek8AinkMtoT0RftfLd1fvCq7xg740Jad08SYjzBsFpbruzbwPx0vTm8cYFsOHeblyNliJg6V7e4e6u7jAyvlrbrBBnC9bwrQu0H3xbkWf0BM46nWFAtfjcZO8grzsBCuHIQPkIHyDeFbtB1yUZgxCxrocCdD/ex82U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044800; c=relaxed/simple;
	bh=f4lmX0B4PuhD4wQo5tusCa+zQKAHTvZ5K163n1GznHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YNmHNEokdhKWeOcy7GBbrcDSXa+DFhyubaUUqNeAAngdX/orKKzLVzxvGm4JrkYZevQPEfnP/lHg/2KG7Z/hwv8vcJTYz8/k0owmQJgBT2/ey9xV+5SoxjEG4fqCqBijO4EUqwFsWT2zUqqV+fsbzengr2rsqxkrSYzpLOZUQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KhLxu08J; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 697EA4000D;
	Wed, 11 Sep 2024 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726044795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IkZ/eUX+bVFf4ZddW9D89l8d/Vlvm0RSLbZpL6Tjyy0=;
	b=KhLxu08Jlw9EKKJdScN1LasYVYqZk6HUWHLqbCmsYAaleaDzL+WmWK3AYWBzg8rxJkc2Ho
	tRMc7KAvJI8IBJo0KZtRrfRAeowGy79cGjKODo9sw/1uWveK7ot8FI+T48hN74x7qAz8pK
	ZVzziYm6t4BA2jRH0ZT+tfH21U8wJdv4lEoWrLLIsRXQXYt6fuFhIzFM9nfGz936R+4r8R
	4wGUcj8UuwpnAb2U/8pz8AHy05VOuM24SmlptixVQz7GC8Pj6Wp64M1UvDuaDWMApwX+6W
	jdova8DFr6L22Hl8Rn0BCNLs/d5Vz/zFA4YH/rmDnISypxy8Y1TQMBJD4VtSYw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 11 Sep 2024 10:53:05 +0200
Subject: [PATCH v2] mux: mmio: Add suspend and resume support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHBa4WYC/4WOTQ6CMBCFr2K6dgy0hYUr72FYtDjIJLYlM0Awh
 LvbcgGX3/vJe7sSZEJR98uuGFcSSjGDvl5UP7r4RqBXZqUrbau2NhCWDUKgBIyyBARZpinxDHY
 wXjtjndFO5bZ3guDZxX4sfdEMRSrWxDjQdo4+u8wjyZz4e35Y66L+n1trqMA2uvFD0+awe/iU5
 g/FW5+C6o7j+AEAU37Y2wAAAA==
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, 
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

The status of each mux is read during suspend and stored in the private
memory of the mux_chip.
Then the state is restored during the resume.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
In this second version, as discussed with Peter, everything is done in the
mmio-mux driver.
A mux_mmio_set() function was added, and used during suspend stage to get
the status of the of the muxes.
This status is stored in the private memory of the mux_chip.
---
Changes in v2:
- Remove all modifications done in the mux subsystem
- Add a mux_mmio_set()
- Read the status of muxes during suspend and store in the private memory
  of the mux_chip.
- Use this status to restore muxes during resume.
- Link to v1: https://lore.kernel.org/r/20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com
---
 drivers/mux/mmio.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 30a952c34365..30b84382637f 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -15,11 +15,25 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 
+struct mux_mmio {
+	struct regmap_field **fields;
+	unsigned int *hardware_states;
+};
+
+static int mux_mmio_get(struct mux_control *mux, int *state)
+{
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux->chip);
+	unsigned int index = mux_control_get_index(mux);
+
+	return regmap_field_read(mux_mmio->fields[index], state);
+}
+
 static int mux_mmio_set(struct mux_control *mux, int state)
 {
-	struct regmap_field **fields = mux_chip_priv(mux->chip);
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux->chip);
+	unsigned int index = mux_control_get_index(mux);
 
-	return regmap_field_write(fields[mux_control_get_index(mux)], state);
+	return regmap_field_write(mux_mmio->fields[index], state);
 }
 
 static const struct mux_control_ops mux_mmio_ops = {
@@ -37,8 +51,8 @@ static int mux_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct regmap_field **fields;
 	struct mux_chip *mux_chip;
+	struct mux_mmio *mux_mmio;
 	struct regmap *regmap;
 	int num_fields;
 	int ret;
@@ -69,12 +83,20 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	}
 	num_fields = ret / 2;
 
-	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
-				       sizeof(*fields));
+	mux_chip = devm_mux_chip_alloc(dev, num_fields, sizeof(struct mux_mmio));
 	if (IS_ERR(mux_chip))
 		return PTR_ERR(mux_chip);
 
-	fields = mux_chip_priv(mux_chip);
+	mux_mmio = mux_chip_priv(mux_chip);
+
+	mux_mmio->fields = devm_kmalloc(dev, num_fields * sizeof(*mux_mmio->fields), GFP_KERNEL);
+	if (IS_ERR(mux_mmio->fields))
+		return PTR_ERR(mux_mmio->fields);
+
+	mux_mmio->hardware_states = devm_kmalloc(dev, num_fields *
+						 sizeof(*mux_mmio->hardware_states), GFP_KERNEL);
+	if (IS_ERR(mux_mmio->hardware_states))
+		return PTR_ERR(mux_mmio->hardware_states);
 
 	for (i = 0; i < num_fields; i++) {
 		struct mux_control *mux = &mux_chip->mux[i];
@@ -104,9 +126,9 @@ static int mux_mmio_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
-		if (IS_ERR(fields[i])) {
-			ret = PTR_ERR(fields[i]);
+		mux_mmio->fields[i] = devm_regmap_field_alloc(dev, regmap, field);
+		if (IS_ERR(mux_mmio->fields[i])) {
+			ret = PTR_ERR(mux_mmio->fields[i]);
 			dev_err(dev, "bitfield %d: failed allocate: %d\n",
 				i, ret);
 			return ret;
@@ -130,13 +152,55 @@ static int mux_mmio_probe(struct platform_device *pdev)
 
 	mux_chip->ops = &mux_mmio_ops;
 
+	dev_set_drvdata(dev, mux_chip);
+
 	return devm_mux_chip_register(dev, mux_chip);
 }
 
+static int mux_mmio_suspend_noirq(struct device *dev)
+{
+	struct mux_chip *mux_chip = dev_get_drvdata(dev);
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux_chip);
+	unsigned int state;
+	int ret, i;
+
+	for (i = 0; i < mux_chip->controllers; i++) {
+		ret = mux_mmio_get(&mux_chip->mux[i], &state);
+		if (ret) {
+			dev_err(dev, "control %u: error saving mux: %d\n", i, ret);
+			return ret;
+		}
+
+		mux_mmio->hardware_states[i] = state;
+	}
+
+	return 0;
+}
+
+static int mux_mmio_resume_noirq(struct device *dev)
+{
+	struct mux_chip *mux_chip = dev_get_drvdata(dev);
+	struct mux_mmio *mux_mmio = mux_chip_priv(mux_chip);
+	int ret, i;
+
+	for (i = 0; i < mux_chip->controllers; i++) {
+		ret = mux_mmio_set(&mux_chip->mux[i], mux_mmio->hardware_states[i]);
+		if (ret) {
+			dev_err(dev, "control %u: error restoring mux: %d\n", i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(mux_mmio_pm_ops, mux_mmio_suspend_noirq, mux_mmio_resume_noirq);
+
 static struct platform_driver mux_mmio_driver = {
 	.driver = {
 		.name = "mmio-mux",
 		.of_match_table	= mux_mmio_dt_ids,
+		.pm = pm_sleep_ptr(&mux_mmio_pm_ops),
 	},
 	.probe = mux_mmio_probe,
 };

---
base-commit: caf614bf68351c7e9e38dd37e07539417c757813
change-id: 20240613-mux-mmio-resume-support-4f3b2a34a32a

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


