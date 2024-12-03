Return-Path: <linux-kernel+bounces-430105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5FA9E2C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F24C168458
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C920ADD1;
	Tue,  3 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yxrmrzcj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B420A5D4;
	Tue,  3 Dec 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256041; cv=none; b=ejUB22uP3HWBcj9/KyAyKmvkH8Gdvd90ZKQX0pCU1NVtH/o9i+gTQ+xst5iLuw76mYPoL51YJoRuZsUOx61PjLRb+INBUGJ4lRFXBxljnjGX9AafV+fg0d4AcuP1SgaIi50igYnNPwrSj1Fdt14524wxTVk6gl+SzxZWWuZndKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256041; c=relaxed/simple;
	bh=ITRA2sHdp8QzHnoudivGjLxKDGsiola6VT8qguhKSTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZZqW+GKWP/B4eh/S4OWnvkdLlNrE2VPoCLj+CEj0X5ChM0eNfrTQu83IeC9zv7PaywW9shHhvsfWkjh9RhPN3+X/huavkxnEGLdGz8jEwj+ojapVH1klDA2ZPkm0xXsQ3WdYgZMZp+q3RSYx9i5JM4nZDzbNyqZ0jRCmi7Qt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yxrmrzcj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K07Lr114300;
	Tue, 3 Dec 2024 14:00:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256007;
	bh=lm0ptDcYCXSO6oW3mJcieCpEXMIUB8pW4flS9JFNVeI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yxrmrzcjHXjROwXm3Bh2j/yOmzpbZhkb99tydCtQfzkqI9U5B+en9VPIfuPTShdpI
	 +xs5gXU5xMRnnMg3loBkZTwiz7IH8alaO7sC4fzlC2+sFjkXScaX/K8tjxH6Oe9qK5
	 SgXTr6bshr+kZiExxKBKwofSO9y7ARg9z83L632c=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06ZZ031472
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:06 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jf122616;
	Tue, 3 Dec 2024 14:00:06 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 11/21] ASoc: pcm6240: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:51 -0600
Message-ID: <20241203200001.197295-11-afd@ti.com>
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
 sound/soc/codecs/pcm6240.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 5d99877f88397..4ff39e0b95b27 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -2059,7 +2059,6 @@ static char *str_to_upper(char *str)
 
 static int pcmdevice_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_match_id(pcmdevice_i2c_id, i2c);
 	struct pcmdevice_priv *pcm_dev;
 	struct device_node *np;
 	unsigned int dev_addrs[PCMDEVICE_MAX_I2C_DEVICES];
@@ -2069,7 +2068,7 @@ static int pcmdevice_i2c_probe(struct i2c_client *i2c)
 	if (!pcm_dev)
 		return -ENOMEM;
 
-	pcm_dev->chip_id = (id != NULL) ? id->driver_data : 0;
+	pcm_dev->chip_id = (uintptr_t)i2c_get_match_data(i2c);
 
 	pcm_dev->dev = &i2c->dev;
 	pcm_dev->client = i2c;
-- 
2.39.2


