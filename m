Return-Path: <linux-kernel+bounces-550633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9EA5623E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC2F7A8B29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283AE1AF0B6;
	Fri,  7 Mar 2025 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5CeVRMx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAF1A3162;
	Fri,  7 Mar 2025 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335045; cv=none; b=F4gr78vx2omwcqI1YJCXF5mgUwhMPSPZ8YyOe0CEwdqRPTJcqEXHkaUHXnA+f4Q51+6yjUz0JXxzkf/vsY0SLc6AdionzIM++tKQsR02pdyBt56DkodQJghd0D2oWEljUPGXOjep7ozzm3Kw36zXkrTOnM66wFjwq5CSnaWYNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335045; c=relaxed/simple;
	bh=URLvfZPIO/9wF/AIwa4diqOpjxozMES4CwNf3nm8kuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uAsm24FguOasox6RXmMz99HHBS6Fpxsm/X5eigYF52yCet2KybiWIrYCu0G5U6c3IlG2hcQjXV6J1Gft2Al9zjqa3RlPP2nS7/Bj/UbDJIaNpZAHbT6zHoTCELCuv5zbvszeMuIUqPak5Y2SjkYT0cKHkm8+bZmm5av9h7sXC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5CeVRMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E51BCC4CED1;
	Fri,  7 Mar 2025 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741335044;
	bh=URLvfZPIO/9wF/AIwa4diqOpjxozMES4CwNf3nm8kuM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=X5CeVRMxtL3Zh2pS2Z69+ZuMwboz7Y+JH9GZE9uLGQ34RXXif3v7uZ4FUpz6c5SDq
	 cbLgP2UFJXQd2hHxO1fRKon6YNzztZNhBNwMZf8UgfWnKtRY+c4XqaTYqKeoX+aGtV
	 Pn5BywL0hrEw0aYjCHcPB4WHtb1rFxUPjfxBl+q//CMPlGJ8z4Dtnp0zenlfqAUwdq
	 bIRcgVz91kmaJ2Brb4o3M6AC46mvgWmwx66ywfAsS5ekcOQqkxESJegL9z7uyvWCR5
	 qsBxaUT09IPz0K6eax+fLd5iXYOEkieRpVuF1QJ07RyWiUd1bA8jn0Trkrs1N+zLMI
	 mem6oar5EztPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B3C19F32;
	Fri,  7 Mar 2025 08:10:44 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Fri, 07 Mar 2025 09:10:43 +0100
Subject: [PATCH v2] hwmon: (ntc_thermistor) return error instead of
 clipping on OOB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-ntc_oob-v2-1-bba2d32b1a8e@gocontroll.com>
X-B4-Tracking: v=1; b=H4sIAAKqymcC/2XMQQrCMBCF4auUWRtJxsamrryHFDFp2g7UjCShK
 KV3N3br8n88vhWSj+QTXKoVol8oEYcSeKjATY8wekF9aUCJWp5kLUJ2d2YrDGJttUXdmAHK+xX
 9QO9dunWlJ0qZ42eHF/Vb/41FCSXOUvambbFuTH8d2XHIkef56PgJ3bZtX5VBvkGjAAAA
X-Change-ID: 20250304-ntc_oob-8224b5b2578f
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741335044; l=3813;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=o+bGurIEIvfpijwa571BSTS14S66EL4hGI9UjZk9MNc=;
 b=zuQaTIXFRK7dEK3cYl2uaLR9Bby1DgSdcLktCsuTSSKiIoIKmPZpQuCMpjtdy9u7slpDFtBhS
 Au0vt17FoXLCR+SW+DDPzO0wrI+iU9pImstc4Gf9u4X6SuK7SJIJ08P
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
I feel like it would be nice to eventually have at least some notice in
dmesg where you can see that a sensor is misbehaving, perhaps this
should be done in the thermal-zone or something higher up.

[1]: https://lore.kernel.org/all/20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com/
---
Changes in v2:
- Drop the check and comment at the end of get_ohm_of_thermistor()
- Link to v1: https://lore.kernel.org/r/20250304-ntc_oob-v1-1-600d8992478d@gocontroll.com
---
 drivers/hwmon/ntc_thermistor.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 0d29c8f97ba7c2f264588b6309b91ca494012ad6..d34db0e595e9cb4249d23244ea68a01949892469 100644
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
@@ -404,8 +401,10 @@ static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uv)
 	else
 		n = div64_u64_safe(pdo * puo * uv, pdo * (puv - uv) - puo * uv);
 
-	if (n > INT_MAX)
-		n = INT_MAX;
+	/* sensor out of bounds */
+	if (n > data->comp[0].ohm || n < data->comp[data->n_comp-1].ohm)
+		return -ENODATA;
+
 	return n;
 }
 

---
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250304-ntc_oob-8224b5b2578f

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



