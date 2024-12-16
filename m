Return-Path: <linux-kernel+bounces-447846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB49F37C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE38167485
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B32206F2A;
	Mon, 16 Dec 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="GfLJ7qTG"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0E2063D1;
	Mon, 16 Dec 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371207; cv=none; b=TWinzQJ+Q6PQs5EcUbh7dtEuEOv2yxGOun6PuSz8Usj3QutHNF6VOt81QA3gYYQyeQVGjkZPQhLWAZRYG855Olrq7lJhpBNnQlnN028DfeH2WWMLDzACVAnsAh6F83c+YfsZOakpTBhV+5ZD5yqqEu1jhwmcsMugmUNnAn2x4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371207; c=relaxed/simple;
	bh=fY6y0lXzXOqF3TKLW5TwyP1WKuAZswB9Lwop6yYCl4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ope3rCIvvi0TgKVCbBJdHCjbO17S3cdthXWPaQ2CCfyk3d3fKYVjps63ufqYdOZkcanzwKurGnSokkD00nIHtbC7ePprm0xXcTCpXj1Wh2jH4tgL1Rw22hK+1EdI7RcU9FCUZk76E8vdb4UiFWSzIDg5lWDfD3lpeKySg+NLLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=GfLJ7qTG; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id CA4A71E000C;
	Mon, 16 Dec 2024 20:37:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru CA4A71E000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1734370639; bh=2NtiqvLaYzpruvxpMSHj0sXsF8gaZ7HqQVWmKbuJ5gI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=GfLJ7qTGMOUCZmr0eSQcoJn3WLtloUANwvEqZNHZ+C8S0PGLxhk7lI829FydQP7qh
	 sYeHII+Nlf0HreASjRtwDgukxK5BEfe8It2KW7RWBfRRmYW6R0TtJ5e3mxhskSG8O3
	 paY2ZFC+jmD877CRiqQKBTGsOxGC6zQXBitKSsMZ0orMRvHnfPwmeeHKdif4/5Z5Bq
	 AGViGycpsQCqgEWJvJN3W9fS8HWhYMXyqeGfsjy90DA0P5MAxNN9t199UbdfYilTwD
	 Uy5jNKOzGaJZvHN5Ly3KioD7G8lGWAcN/9QcI310EnBlAak+0ygXQq4LcCMeMyjsLl
	 5qTfayvS4aYqg==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 20:37:19 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.113) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 16 Dec
 2024 20:37:16 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Eric Tremblay <etremblay@distech-controls.com>
CC: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@maxima.ru>
Subject: [PATCH 3/3] hwmon: (tmp513) Fix interpretation of values of Temperature Result and Limit Registers
Date: Mon, 16 Dec 2024 20:36:48 +0300
Message-ID: <20241216173648.526-4-m.masimov@maxima.ru>
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
Temperature Result and the Temperature Limit Registers do not correspond to the
TMP512/TMP513 specifications. A raw register value is converted to a signed
integer value by a sign extension in accordance with the algorithm provided
in the specification, but due to the off-by-one error in the sign bit index,
the result is incorrect.

According to the TMP512 and TMP513 datasheets, the Temperature Result (08h to 0Bh)
and Limit (11h to 14h) Registers are 13-bit two's complement integer values,
shifted left by 3 bits. The value is scaled by 0.0625 degrees Celsius per bit.
E.g., if regval = 1 1110 0111 0000 000, the output should be -25 degrees,
but the driver will return +487 degrees.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 59dfa75e5d82 ("hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/hwmon/tmp513.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index dacce7417bfd..be63a049923a 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -234,7 +234,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 	case TMP51X_REMOTE_TEMP_LIMIT_2:
 	case TMP513_REMOTE_TEMP_LIMIT_3:
 		// 1lsb = 0.0625 degrees centigrade
-		*val = sign_extend32(regval, 16) >> TMP51X_TEMP_SHIFT;
+		*val = sign_extend32(regval, 15) >> TMP51X_TEMP_SHIFT;
 		*val = DIV_ROUND_CLOSEST(*val * 625, 10);
 		break;
 	case TMP51X_N_FACTOR_AND_HYST_1:
--
2.39.2


