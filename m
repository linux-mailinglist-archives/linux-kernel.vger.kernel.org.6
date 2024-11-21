Return-Path: <linux-kernel+bounces-417277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB29D51DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202EE1F22516
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FB1A072C;
	Thu, 21 Nov 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="Z8T0udUM"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC766CDAF;
	Thu, 21 Nov 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210612; cv=none; b=lDRfMtkIpTC+J4l1h0fC4UCSFZHCGrRjZ3a8bCEaW4FWAJF9p8mh/TxbVY1OzfMw3W2LJ0c9JEABUssPgvUC1ojQQ6gRChDAXKHoiYKvvEsbTNVvw4bsDEfxPRn0426A8yLNUGIBB/DvhBVfdKLTO956YXbyGtj9i8q8I19a2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210612; c=relaxed/simple;
	bh=af2tou02puMTuV+fcFwK4dD1O+u4ik54RXC/A+mNkHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQZ9ho4poAi2W/mJozNGUr/KkL/Lcc9ddS1BZUZvYl1DM8BJ/sk9XQWcOrkNFIn6prpqdTzwA2rprT0/4ymeN7/pr4WG6Us34zqT/JPtkX7c0x4Ha+bSJ+69gf3IH/DeOHIEMdWR+m+SMN8n4EiS1Dzz7Y96gebXzNf3E66l2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=Z8T0udUM; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 6FF831E0003;
	Thu, 21 Nov 2024 20:36:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 6FF831E0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1732210603; bh=cyRSBvNj/tHOPzlYO5iCXriRQEiARlJhu5EWZ4PdOHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Z8T0udUMVmKRg9niSFVpFO6nUg78Y0cOweV4UBhsa2EEvhFELjJNyVs0bLSDNtTFb
	 R4H+rmcb80qE5g9niiEhTLUixu3ksfuAZNaOGLCQuW24QT/P0xbdci00jMgHEq/+CZ
	 0EK+5RHQWclLY17RCyLU23JvSK3MeoirQFBEPX6xpEVMH21AGQR6diHapqzZ8nOCw7
	 GexbynDzAqjdxjIZWA0DM/rDOudEdAi1xwqZ3doT7NlJRX/fYLOD1D3WURmShsT3R7
	 PaD/dNEyJUEPLg27/XAONMXT23G2CmloCi+o+cUVa3NqYcelbxYi/Jky/VsrWwxshU
	 Dk2RVUENSLN0Q==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Thu, 21 Nov 2024 20:36:43 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.253) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Thu, 21 Nov
 2024 20:36:41 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Robert Marko <robert.marko@sartura.hr>
CC: Murad Masimov <m.masimov@maxima.ru>, Luka Perkov <luka.perkov@sartura.hr>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] hwmon: (tps23861) Cast unsigned temperature register value to signed
Date: Thu, 21 Nov 2024 20:36:03 +0300
Message-ID: <20241121173604.2021-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189336 [Nov 21 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 42 0.3.42 bec10d90a7a48fa5da8c590feab6ebd7732fec6b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.62:7.1.2;maxima.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/21 15:20:00 #26879362
X-KSMG-AntiVirus-Status: Clean, skipped

Since the temperature is supposed to be a signed value in this case, cast
unsigned raw register value to signed before performing the calculations.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/hwmon/tps23861.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index dfcfb09d9f3c..80fb03f30c30 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -132,7 +132,7 @@ static int tps23861_read_temp(struct tps23861_data *data, long *val)
 	if (err < 0)
 		return err;

-	*val = (regval * TEMPERATURE_LSB) - 20000;
+	*val = ((long)regval * TEMPERATURE_LSB) - 20000;

 	return 0;
 }
--
2.39.2


