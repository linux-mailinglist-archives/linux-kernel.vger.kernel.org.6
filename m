Return-Path: <linux-kernel+bounces-430114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733C9E2C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092F21604A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9A20C482;
	Tue,  3 Dec 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yrtoz/a7"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926720B7EE;
	Tue,  3 Dec 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256046; cv=none; b=LxE+hVE15EktbILoRoOjIBQ5FBb6CHPT2l1ZtsgnUoxTKKwNCx7gnbWwYPY5wgHUZa18SWeKyi2EF2rQv1j7qIhsBVncZ/pkFOh9vCVZIhenM9xMTCB2iNKPVku14+8TgN40OWzWa5ZtZ5rnMQExjthHKFRk1nUTaM8vxcjykmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256046; c=relaxed/simple;
	bh=mTOynzHHhe/y7JUlLpyg/Vfz7bniIidO6Ks6iFrGZ+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+TL+DONrGgk24Pypgi47LJAsP+B5CtAqgqnjETvEtjop+/qQeAS6CUx1TJZ1CffnOdPsFVC55L7nXs3mUnoqlG9Y/11kJj5lqITFO7zrrmHrF0DMlbE6Y9JxDE2ltaAz5WXh/bJha0RhE0TX532tKiQOv20Ax2rvWBy/bd246A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yrtoz/a7; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K0A6U1933814
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256010;
	bh=FMmtkox87D17Ghps0QE9x/hvg02/t8YQjhqbbf01q1o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yrtoz/a7uaiXWkjwlGl8KkgyrTWp5KZtd/MYcZuKzlxNWaKx9im0K/Vga8R2b6WnZ
	 6EMUKZLkN3Hh0QlaEFYmIHTE2R3r7uVkj7tlM+EEuyoQBABSfWZh6g8ZsBAhMtQj8B
	 3sMAbPq30ZgFd2k9Wj1y3iQS7vv+hEFMfrmh11fg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K0A22031628
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:10 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:09 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Jo122616;
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
Subject: [PATCH 20/21] ASoC: wm8904: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 14:00:00 -0600
Message-ID: <20241203200001.197295-20-afd@ti.com>
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
 sound/soc/codecs/wm8904.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 829bf055622a7..aef82532f8cfe 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2196,18 +2196,7 @@ static int wm8904_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	if (i2c->dev.of_node) {
-		const struct of_device_id *match;
-
-		match = of_match_node(wm8904_of_match, i2c->dev.of_node);
-		if (match == NULL)
-			return -EINVAL;
-		wm8904->devtype = (uintptr_t)match->data;
-	} else {
-		const struct i2c_device_id *id =
-			i2c_match_id(wm8904_i2c_id, i2c);
-		wm8904->devtype = id->driver_data;
-	}
+	wm8904->devtype = (uintptr_t)i2c_get_match_data(i2c);
 
 	i2c_set_clientdata(i2c, wm8904);
 	wm8904->pdata = i2c->dev.platform_data;
-- 
2.39.2


