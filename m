Return-Path: <linux-kernel+bounces-544359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC119A4E072
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582003A24FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8D204F6A;
	Tue,  4 Mar 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr64fsRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577D1FC7C9;
	Tue,  4 Mar 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097434; cv=none; b=FKqQrnt0nyXW1SDpWBm+mxEv+N81GKm1LBFwdRPzYQoxWUDAD1Fntqwt7brWbRd9WC8+/99+jJhizzFCEGrwTA9sqr5nUhwsPl9IM+atl2bh0F7PicIo886j3Q8lWduPoK7wXApb9ZwnaxIB+/gGWDTkJkRiVMeAUG4YRNnwJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097434; c=relaxed/simple;
	bh=rizGSgK5xHo58KsRXuy97biYsv6kMmnPbMmM4wJ9HCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aUVpbHIZQ0jUbUnsKhItEX2x/nNE/eibnR18UGKlA8KA2To3ejDzo9qS/VnZx2yY2aStVQYHsJVpsAKC4kZp/2qWBnowxLVDU/PSwfAfnQr1IvQ2u+e3uzt2k6YEgRI1/p+8oJf7zTfdLchfXReSOjhYBZbpJZqNpy69bK4ShPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr64fsRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA6C7C4CEE5;
	Tue,  4 Mar 2025 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097434;
	bh=rizGSgK5xHo58KsRXuy97biYsv6kMmnPbMmM4wJ9HCE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nr64fsRuGgnVEGx5/zGpV14nu1iJkDxt8MLykV0n8qW+WlaHdY0fpBCABovY28ZPn
	 zoSLExMOjWpcNOB3dCkpZP3dkwm5xDnxNKaHpL1Zp+FKd/LlShzeHBA/Ze2xFev3XA
	 vf2W1+SVUEWXHY6CDxK+qagFg3sH/pr7uYuk42kz0q/yK9BnQd13C9W6hkFlGRZRyy
	 KMWuRKNTa21IkpwDDdwiZ/fCSQoDxXqnbPD+NMgVk/Ow95PtRdQWyciuH4nmhpEdrk
	 I0+7sa2J5llPdlhI/xEgCNNrNQQBdCVhPX3Ye71vhTkbiuIwnowEUkmDvpG3wzhc5G
	 DzL7uv6zpvceg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56CEC021B8;
	Tue,  4 Mar 2025 14:10:33 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 04 Mar 2025 15:10:31 +0100
Subject: [PATCH] hwmon: (ntc_thermistor) return error instead of clipping
 on OOB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-ntc_oob-v1-1-600d8992478d@gocontroll.com>
X-B4-Tracking: v=1; b=H4sIANYJx2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMT3byS5Pj8/CRdCyMjkyTTJCNTc4s0JaDqgqLUtMwKsEnRsbW1ADs
 ERUxZAAAA
X-Change-ID: 20250304-ntc_oob-8224b5b2578f
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741097433; l=4222;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=RmytwYHysabk9h8JtKUKdTZTREYQi1OmvlBNEp98ZGQ=;
 b=My3ewUjA2boel3PNERKlLCk4c31l8WSk+MPw21rkUcGwvZ9oUwYzyyK0E5/OGB2Exd+t6SDGx
 jhTsGLnVMTYCZlWm8iFjPL6YiqqEGxmKSL0BgcOCogm4/g7UHjz0Yzj
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

When the ntc is reading Out Of Bounds instead of clipping to the nearest
limit (min/max) return -ENODATA. This prevents malfunctioning sensors
from sending a device into a shutdown loop due to a critical trip.

This implementation will only work for ntc type thermistors if a ptc
type is to be implemented the min/max ohm calculation must be adjusted
to take that into account.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
This patch is a continuation of another discussion [1]. I felt like it
should be a new patch, not a v2 as this is a very different change.

I have left the clamping of n to INT_MAX in the code with a comment, but
it may be possible to find a better solution to it. One I thought of is
to make the ohm field of the ntc_compensation struct a signed int as
well. It would get rid of this weird edge case, but it doesn't make
sense to allow for negative resistances to be entered into the sensor
table.

Currently the only feedback this provides to the user is when they
manually try to read the temperature and it returns the error. I have
added a simple printk to these error points to see how spammy it gets
and this is the result:

dmesg | grep hwmon
[    4.982682] hwmon: sensor out of bounds
[    5.249758] hwmon: sensor out of bounds
[    5.633729] hwmon: sensor out of bounds
[    6.215285] hwmon: sensor out of bounds
[    7.073882] hwmon: sensor out of bounds
[    7.486620] hwmon: sensor out of bounds
[    8.833765] hwmon: sensor out of bounds
[   10.785969] hwmon: sensor out of bounds
[   13.793722] hwmon: sensor out of bounds
[   16.761124] hwmon: sensor out of bounds
[   17.889706] hwmon: sensor out of bounds
[   25.057715] hwmon: sensor out of bounds
[   35.041725] hwmon: sensor out of bounds
[   50.110346] hwmon: sensor out of bounds
[   72.945283] hwmon: sensor out of bounds
[  105.712619] hwmon: sensor out of bounds
[  154.863976] hwmon: sensor out of bounds
[  164.937104] hwmon: sensor out of bounds
[  228.590909] hwmon: sensor out of bounds
[  315.365777] hwmon: sensor out of bounds
[  464.718403] hwmon: sensor out of bounds
[  615.079123] hwmon: sensor out of bounds
[  764.496780] hwmon: sensor out of bounds

This is with polling-delay set to 1000, it seems to rate-limit itself?
But I feel there should be a better way to communicate the potential
sensor failure to the user, but I can't think of anything.

[1]: https://lore.kernel.org/all/20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com/
---
 drivers/hwmon/ntc_thermistor.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 0d29c8f97ba7c2f264588b6309b91ca494012ad6..311a60498d409ea068a18590415b2d5b43e73eb1 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -387,12 +387,9 @@ static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uv)
 	puo = data->pullup_ohm;
 	pdo = data->pulldown_ohm;
 
-	if (uv == 0)
-		return (data->connect == NTC_CONNECTED_POSITIVE) ?
-			INT_MAX : 0;
-	if (uv >= puv)
-		return (data->connect == NTC_CONNECTED_POSITIVE) ?
-			0 : INT_MAX;
+	/* faulty adc value */
+	if (uv == 0 || uv >= puv)
+		return -ENODATA;
 
 	if (data->connect == NTC_CONNECTED_POSITIVE && puo == 0)
 		n = div_u64(pdo * (puv - uv), uv);
@@ -404,6 +401,16 @@ static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uv)
 	else
 		n = div64_u64_safe(pdo * puo * uv, pdo * (puv - uv) - puo * uv);
 
+	/* sensor out of bounds */
+	if (n > data->comp[0].ohm || n < data->comp[data->n_comp-1].ohm)
+		return -ENODATA;
+
+	/*
+	 * theoretically data->comp[0].ohm can be greater than INT_MAX as it is an
+	 * unsigned integer, but it doesn't make any sense for it to be so as the
+	 * maximum return value of this function is INT_MAX, so it will never be
+	 * able to properly calculate that temperature.
+	 */
 	if (n > INT_MAX)
 		n = INT_MAX;
 	return n;

---
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250304-ntc_oob-8224b5b2578f

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



