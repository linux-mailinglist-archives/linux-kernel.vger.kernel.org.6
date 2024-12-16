Return-Path: <linux-kernel+bounces-447845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183379F37C7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D81677CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF5F206F17;
	Mon, 16 Dec 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="HeC51pYD"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB72063C4;
	Mon, 16 Dec 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371207; cv=none; b=HTbRHGq4Ya3GME2F7sHANkHnjCpfMrFrIZSJLVBywCa6uzHoEBF4lS7ROUSRmqWapbdgZQnMws/Y8rPLHZwfPK8DjFvMn0/3JND6EREPmoqIn88Z/5UZ3F03SkdmEo7PwlW5v/nnspnQ34m5ySLQrRUkr7ZhKw6g6YNXJVVYN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371207; c=relaxed/simple;
	bh=MydU2KqMYpf1BW+e7itGzRs+GnVYfBL2Dos1RUw/mLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9YMvMzoqu7T3bhhS8uquwTeyPC6L9GDe4f2B4SUS67lEvZdADbFGQc86kplif17PBU1FgMmZoVhH4MpEEv6Ym01lPV+PgCA/HrjA7Ht0b1doA+LK1yOgi1xKd0XjyAkHn3haLNJmrNZCJeARpyOiQYOC04xdNhPJqF6zLMTrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=HeC51pYD; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 614401E000A;
	Mon, 16 Dec 2024 20:37:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 614401E000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1734370638; bh=tfzUMR0b8Q0N+tj1r/eItUrJWHAQqMfSF+SLtaDABOU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HeC51pYDsqb6Y74aFbzZjXXI+fFU77UTLHe0C50XlcsYe0KGC5X4RovPnHJfHc8OW
	 ia+hq065GGojI8UxId5q9LCRRHzO7qe5w4YByx35mkx980ZHZmcHGgJ5RvSBzvfdsd
	 UlHy0dObRL4KfbZDd9DfErzVO8A+BrOmhvmkIOatAeHWLrk7+6xV75tKAtLbyUkmW8
	 riVqqi7KFSqSltNJxN5DysM9wZqmC6HTzl7mCHPWQcLPTUYnNGO1u2uQRrd54acmve
	 3wga62sxGdCDKhs3rXeLTteApIrxhDkZ7l9pu9qzVJBqcgCWyidb+dNBOzDfqCDOfy
	 2n7CY0/PeHaXQ==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 20:37:18 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.113) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Mon, 16 Dec
 2024 20:37:15 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Eric Tremblay <etremblay@distech-controls.com>
CC: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@maxima.ru>
Subject: [PATCH 2/3] hwmon: (tmp513) Fix Current Register value interpretation
Date: Mon, 16 Dec 2024 20:36:47 +0300
Message-ID: <20241216173648.526-3-m.masimov@maxima.ru>
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

The value returned by the driver after processing the contents of the Current
Register does not correspond to the TMP512/TMP513 specifications. A raw
register value is converted to a signed integer value by a sign extension in
accordance with the algorithm provided in the specification, but due to the
off-by-one error in the sign bit index, the result is incorrect. Moreover,
negative values will be reported as large positive due to missing sign
extension from u32 to long.

According to the TMP512 and TMP513 datasheets, the Current Register (07h) is a
16-bit two's complement integer value. E.g., if regval = 1000 0011 0000 0000,
then the value must be (-32000 * lsb), but the driver will return (33536 * lsb).

Fix off-by-one bug, and also cast data->curr_lsb_ua (which is of type u32) to
long to prevent incorrect cast for negative values.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 59dfa75e5d82 ("hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 drivers/hwmon/tmp513.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index d401cb55de14..dacce7417bfd 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -222,7 +222,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 		break;
 	case TMP51X_BUS_CURRENT_RESULT:
 		// Current = (ShuntVoltage * CalibrationRegister) / 4096
-		*val = sign_extend32(regval, 16) * data->curr_lsb_ua;
+		*val = sign_extend32(regval, 15) * (long)data->curr_lsb_ua;
 		*val = DIV_ROUND_CLOSEST(*val, MILLI);
 		break;
 	case TMP51X_LOCAL_TEMP_RESULT:
--
2.39.2


