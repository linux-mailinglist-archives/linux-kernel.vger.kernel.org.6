Return-Path: <linux-kernel+bounces-447843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D679F37C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07836188ED40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E462066CF;
	Mon, 16 Dec 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="iOqArOrq"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6D2063E1;
	Mon, 16 Dec 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371206; cv=none; b=Jf6OJwsINGTCid0LZmRUBfevuDi4vhUr4FWrpQxa9yYIdVLHENYkVgw6ZSaTJ3TP0m1Vdzy0JjMzBMnt7JqWD94Y9WVrwPTKsYvfSAHqtnRD2e2sm6KQiL5EtmK08O5idGaSswDLOrykmQJPf6zuRz68I4f86OIgVD6NiQEgY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371206; c=relaxed/simple;
	bh=kgjZ9N04xiSDen3VDth9hU0fR1xIl4ZNrPT3xcW5/Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ND2Q+JusiB859ItZbhXSTdcg6yGiZQuhU3JDycfMCK9a/OpVZGP8D0pRu6or9lyXcg4nGktSqGZ6D/N0HHVaMQRqwGPUx+5VqdcbIBykj5kkKKxwo0KoBEmpD6eEiO/AquY53FgVJxH2ENpNGH9FSAP1DnDTQ8lrWPJEPVBUoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=iOqArOrq; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 4D7401E0009;
	Mon, 16 Dec 2024 20:37:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 4D7401E0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1734370636; bh=CwK4KhpKnJSs+YBGBnA/xMZBVQPjbAnMGiJT9OWoyPI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iOqArOrqoBelqjmXWuRtychEwoPJR+NkHrnNR4+0QbMd0TCnAT7CHLVLi/ZARfDsW
	 mJLhc1g9RWtZXtfJXBUfJCWseLJ2mjU9jSgZnsDHnRjRz9HLMEhdSWld5CMrHnYolK
	 0+xpDq3kEkEYBlCn6+RitNNiF46vvIK//6tHTdTnDcCKH6YTJP97LHCIz8qctgbAPd
	 uoeWQcS0HVPj+Vw2m07L7RCWYmgf1iNWU1SdMNJY7MOl8wgl4uhbQELxzVLqgJcIzF
	 yXQlcEh87vEjrIIKvXqbg74KcecNibzXyoppzr+0igtB1ngd/3zhLd4tVj4UuwKwGH
	 P+BOFUMZCExaw==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 20:37:16 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.113) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 16 Dec
 2024 20:37:13 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Eric Tremblay <etremblay@distech-controls.com>
CC: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@maxima.ru>
Subject: [PATCH 1/3] hwmon: (tmp513) Fix interpretation of values of Shunt Voltage and Limit Registers
Date: Mon, 16 Dec 2024 20:36:46 +0300
Message-ID: <20241216173648.526-2-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20241216173648.526-1-m.masimov@maxima.ru>
References: <20241216173648.526-1-m.masimov@maxima.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 189867 [Dec 16 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 47 0.3.47 57010b355d009055a5b6c34e0385c69b21a4e07f, {rep_avail}, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.62:7.1.2;mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg02.maxima.ru:7.1.1;maxima.ru:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, FromAlignment: n, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/16 14:34:00 #26899616
X-KSMG-AntiVirus-Status: Clean, skipped

The values returned by the driver after processing the contents of the
Shunt Voltage Register and the Shunt Limit Registers do not correspond to the
TMP512/TMP513 specifications. A raw register value is converted to a signed
integer value by a sign extension in accordance with the algorithm provided in
the specification, but due to the off-by-one error in the sign bit index, the
result is incorrect. Moreover, the PGA shift calculated with the
tmp51x_get_pga_shift function is relevant only to the Shunt Voltage Register,
but is also applied to the Shunt Limit Registers.

According to the TMP512 and TMP513 datasheets, the Shunt Voltage Register (04h)
is 13 to 16 bit two's complement integer value, depending on the PGA setting.
The Shunt Positive (0Ch) and Negative (0Dh) Limit Registers are 16-bit two's
complement integer values. Below are some examples:

* Shunt Voltage Register
If PGA = 8, and regval = 1000 0011 0000 0000, then the decimal value must
be -32000, but the value calculated by the driver will be 33536.

* Shunt Limit Register
If regval = 1000 0011 0000 0000, then the decimal value must be -32000, but
the value calculated by the driver will be 768, if PGA = 1.

Fix sign bit index, and also correct misleading comment describing the
tmp51x_get_pga_shift function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 59dfa75e5d82 ("hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/hwmon/tmp513.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 926d28cd3fab..d401cb55de14 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -182,7 +182,7 @@ struct tmp51x_data {
 	struct regmap *regmap;
 };

-// Set the shift based on the gain 8=4, 4=3, 2=2, 1=1
+// Set the shift based on the gain: 8 -> 1, 4 -> 2, 2 -> 3, 1 -> 4
 static inline u8 tmp51x_get_pga_shift(struct tmp51x_data *data)
 {
 	return 5 - ffs(data->pga_gain);
@@ -204,7 +204,9 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 		 * 2's complement number shifted by one to four depending
 		 * on the pga gain setting. 1lsb = 10uV
 		 */
-		*val = sign_extend32(regval, 17 - tmp51x_get_pga_shift(data));
+		*val = sign_extend32(regval,
+			reg == TMP51X_SHUNT_CURRENT_RESULT ?
+			16 - tmp51x_get_pga_shift(data) : 15);
 		*val = DIV_ROUND_CLOSEST(*val * 10 * MILLI, data->shunt_uohms);
 		break;
 	case TMP51X_BUS_VOLTAGE_RESULT:
--
2.39.2


