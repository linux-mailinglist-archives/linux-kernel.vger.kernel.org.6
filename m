Return-Path: <linux-kernel+bounces-430113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8599E2CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE67B47627
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542B920C03E;
	Tue,  3 Dec 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y1pxWqyJ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAF20ADFB;
	Tue,  3 Dec 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256045; cv=none; b=owlqZyxXG0hem+nQfJgISsMO83nDE7CLivObriAbYakdi1c8eeYeAlxbPqRnftlJNy1qOqzAnxwDCy2m8Ps1Lyv6Bc+TqSf2zQNThSTKsDPO9hI1P75jFcpW/27W01Piy2CC2uJI7H1eY7dLMS1SHGQMTcltYNzLxc63iq1oZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256045; c=relaxed/simple;
	bh=IpDg4iMxUMI6fXTVWAmbwLBptkg/cDu4o8J4jGnSiOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+Oi1Udn0nzi2dcr+MXp0pgPYgQqZQaJIHkXV+0FKR/GGPRyyHuX3lgJWN/LqYstoNNlcQ/ps7RAyYqCGniFQLv1Y1kCS0CMriZl0l2nPy+qnoiwq+uxpE/bmyHq01z1TQmbFH5vukRlPlGKDrT61VyD3zshgOlbhwOR99yK/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y1pxWqyJ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K05up1495059
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733256005;
	bh=HMDfoAwPxKTDp7kqw4JSvzS4iFwzDfpqnLehTfN3U2w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Y1pxWqyJOTfAL43WoYcXjY+Yj2KiF0ykBIX3gOOV7wfpcJJf5zbLfqQn8VIMV5u7d
	 wkA4AZUzFUSM6E0rPFVLAjdaPYAKcTy60n/b5RMK/+YRrsRE2ZWtbUqGQE5O1yDxcD
	 2BMGvEPxTzDRwqkLov4NwJs7GqRIe8uoVFw08wK8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3K04We045390
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 14:00:05 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 14:00:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 14:00:04 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3K02Ja122616;
	Tue, 3 Dec 2024 14:00:04 -0600
From: Andrew Davis <afd@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 06/21] ASoC: alc5632: Remove use of i2c_match_id()
Date: Tue, 3 Dec 2024 13:59:46 -0600
Message-ID: <20241203200001.197295-6-afd@ti.com>
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
 sound/soc/codecs/alc5632.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index d5021f2669301..72f4622204fff 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1108,7 +1108,7 @@ static int alc5632_i2c_probe(struct i2c_client *client)
 	struct alc5632_priv *alc5632;
 	int ret, ret1, ret2;
 	unsigned int vid1, vid2;
-	const struct i2c_device_id *id;
+	unsigned int matched_id;
 
 	alc5632 = devm_kzalloc(&client->dev,
 			 sizeof(struct alc5632_priv), GFP_KERNEL);
@@ -1134,9 +1134,9 @@ static int alc5632_i2c_probe(struct i2c_client *client)
 
 	vid2 >>= 8;
 
-	id = i2c_match_id(alc5632_i2c_table, client);
+	matched_id = (uintptr_t)i2c_get_match_data(client);
 
-	if ((vid1 != 0x10EC) || (vid2 != id->driver_data)) {
+	if ((vid1 != 0x10EC) || (vid2 != matched_id)) {
 		dev_err(&client->dev,
 		"Device is not a ALC5632: VID1=0x%x, VID2=0x%x\n", vid1, vid2);
 		return -EINVAL;
-- 
2.39.2


