Return-Path: <linux-kernel+bounces-430112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F09E2E29
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71172B4758F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C420C03C;
	Tue,  3 Dec 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xk86ANu+"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925420B1FA;
	Tue,  3 Dec 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256045; cv=none; b=ZsZ1LbKcqiDrQ7NOpsX8Osmp+O7svUyRnoMZiTZGwhv9l0ECp5IMyLNqhFRmpc+a1RDjhdUTlGAnFoN5Ubl9/wHyA9W/QlZM+l7nYob1j7XuyQnah/Yesb3JymEFkHAYRxV5/jwOst5XtoveTEwssfqTjSRmxqnIsJd/vhWjU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256045; c=relaxed/simple;
	bh=CEH6T/E9t4YOzC16PNj0/9kV70S0rGjZJkPML657m54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdVEaCvghSCbN+tXYM7cFoF/83fhT17Y5mfDCGGM1EdbtQMnva5R8lICUWv238EFsGLFASuc6/vMIkX2XrKkAMX4MeiaKbUwaJpd4oXoc6mruspbLCppaMVEaqP3DEEFozHc48DkFCcN3yUyPVDKvB5hAcbbolqSxyLizcHucZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xk86ANu+; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K06O81680012
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Dec 2024 14:00:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256006;
	bh=Dr8vIVATtW+LphNftY57ejkp+fTJOFI2GGU79VoKIpA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xk86ANu++IJTOZsoMTuXCPZLyQvnGpRxLW5ADJBrambB70wtYwvgkNa0bLxC6Z8Ld
	 l1qsPnSHuJDVqJLhVYu1j8Qrp7EcmW7m9iVva5LzY8URs8vx8LzoSDiapoK1NetSLb
	 9Jh/Hbjhf/X2rDfE2HSjW/I87zSlCch+sx7+TGW0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K06sw029107;
	Tue, 3 Dec 2024 14:00:06 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:06 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Je122616;
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
Subject: [PATCH 10/21] ASoC: pcm186x: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:50 -0600
Message-ID: <20241203200001.197295-10-afd@ti.com>
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
 sound/soc/codecs/pcm186x-i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm186x-i2c.c b/sound/soc/codecs/pcm186x-i2c.c
index a514ebd1b68ac..a50f9f6e39c18 100644
--- a/sound/soc/codecs/pcm186x-i2c.c
+++ b/sound/soc/codecs/pcm186x-i2c.c
@@ -33,8 +33,7 @@ MODULE_DEVICE_TABLE(i2c, pcm186x_i2c_id);
 
 static int pcm186x_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_match_id(pcm186x_i2c_id, i2c);
-	const enum pcm186x_type type = (enum pcm186x_type)id->driver_data;
+	const enum pcm186x_type type = (uintptr_t)i2c_get_match_data(i2c);
 	int irq = i2c->irq;
 	struct regmap *regmap;
 
-- 
2.39.2


