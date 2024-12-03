Return-Path: <linux-kernel+bounces-430111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3D9E2C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CBB163736
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA84E20C023;
	Tue,  3 Dec 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MzeASMEa"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F820ADFA;
	Tue,  3 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256044; cv=none; b=K4JxRuBcKKd4o2BrKGunfmhZHD9kiNvMWEL99ndFFGcb+w1Yd9pfVJ5F8f81hCHDXN4DfOXvSHpKtKVhZwn5+clPYuqhAX+0kwtsvaZzCqsr0zjksGQYaZHAT2ZQdk45+5PujX91KeBRxc/NHM6vMjVTYpjMlIx4W4KD+cBT3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256044; c=relaxed/simple;
	bh=Tkf7V5WOo/iiw4i5uW/rWSa+5baKP0b+F5PmG5ktf0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvF95b8M2jkiXngvPMx278r6UkUhBwUvFeumYV1eIEFCgPQlZ23tNkEcFGlNi8oL7H+G1X2JyTna/LGm+VE2ascPH5FU5sJpGcZ62p9g+oG/aLWBm8H8JBJ3fs1mU9qVSiyAxxvRYm0JoKt8nq0xB2eHMIequ390uD+uGOpMoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MzeASMEa; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K0ANM1495199
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Dec 2024 14:00:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256010;
	bh=5YxbYInvpygXQwfQxNlrzTZjl32EW0o6s3aCRsNjvgg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MzeASMEafPFIA1nI4CaZgtN4y0An2M2R7s+aDKboG1/+Xh+2GWz/8gL9PZDruoiel
	 Es+u1e2UCE7g+M1C/rUfg7s9OBuNRXfuCT8l6xiB1kr9L2ZooUkXk3YdERxPsPuvZe
	 DKf5Rx9ug1/jkyaw/1EbQ3XeiVcRQJCWpnYLs2Fs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K0AiT029215;
	Tue, 3 Dec 2024 14:00:10 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:10 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jp122616;
	Tue, 3 Dec 2024 14:00:09 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 21/21] ASoC: wm8985: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 14:00:01 -0600
Message-ID: <20241203200001.197295-21-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203200001.197295-1-afd@ti.com>
References: <20241203200001.197295-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 sound/soc/codecs/wm8985.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 8606e0752a604..da00db5b01726 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1166,12 +1166,10 @@ static struct spi_driver wm8985_spi_driver = {
 #endif
 
 #if IS_ENABLED(CONFIG_I2C)
-static const struct i2c_device_id wm8985_i2c_id[];
 
 static int wm8985_i2c_probe(struct i2c_client *i2c)
 {
 	struct wm8985_priv *wm8985;
-	const struct i2c_device_id *id = i2c_match_id(wm8985_i2c_id, i2c);
 	int ret;
 
 	wm8985 = devm_kzalloc(&i2c->dev, sizeof *wm8985, GFP_KERNEL);
@@ -1180,7 +1178,7 @@ static int wm8985_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, wm8985);
 
-	wm8985->dev_type = id->driver_data;
+	wm8985->dev_type = (uintptr_t)i2c_get_match_data(i2c);
 
 	wm8985->regmap = devm_regmap_init_i2c(i2c, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
-- 
2.39.2


