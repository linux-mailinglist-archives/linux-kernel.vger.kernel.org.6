Return-Path: <linux-kernel+bounces-543484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E66A4D638
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587343AA985
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275A1FAC33;
	Tue,  4 Mar 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOWgvRAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9751F583F;
	Tue,  4 Mar 2025 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076685; cv=none; b=tPkYseMmXSlW5UlL+XZZ88OwBdOCM24h+vGiUhkmnXXRtVhKGJwOpYCRircHuuDn5BWFq7fWGte2RuflxVLbc5xoTlDnKqBwZCDibUG2NOOH/EA1KVU3FUElsNyjLb/j4FFq/MQbnCWJuxNHcR4b10bxOx8l+50rHsRJ/36t/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076685; c=relaxed/simple;
	bh=+LfuEtS3hu1y9dTM9mxPPM+YBFahStoGBJrYDCOEvOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lh7lECFoGTq1A8mCOo72KJHsG2CxF85ZqhjM+0LOyZgMvO40pVeGxRRT7MG1GGY1J7sKigkYxKFEpXnA+Y36kWjBRqeWRx86oMUaVc2RN8OZCec0gOTMKWXrlX5tWiWxm/KhfNsClQsoXmmVnLwrvyDn1VBIF8Ilq3KTPuBlVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOWgvRAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4EF4C4CEE8;
	Tue,  4 Mar 2025 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741076684;
	bh=+LfuEtS3hu1y9dTM9mxPPM+YBFahStoGBJrYDCOEvOQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=EOWgvRAQC/+Kl/2yWBvrpLxw/J951iYOTxXrq/o0OVSU2XzLKONteM9WvSwBtR6xy
	 jt2hCKmIDv7YGoF6El4rmnnuishxFyVwU4vH98wEMuMz2/wmV6FkT/wG7jqm5ll5Oq
	 EbvxfuxkoHn6o6OwFnDpuDGexCKdC6/Ii2w2f7W5fCbbf4tTPsiNmikxDNQ9lsIjIc
	 x3KfRrYAopYwE6LQy8U2DO8gHZWh3ScWHBZbOnppYQezcUWDiVGu8G7Nlfv5pgQ84L
	 2wuOlS6viNAh2559hVjUGXo7nYvDURvYwqSBR0qvrygcIOz/M0u79y2qEqXHL30gvr
	 4m11sP661tKsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2982C021B8;
	Tue,  4 Mar 2025 08:24:44 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 04 Mar 2025 09:24:43 +0100
Subject: [PATCH] hwmon: (ntc_thermistor) Add min and max temperature
 attributes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com>
X-B4-Tracking: v=1; b=H4sIAMq4xmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMT3byS5PjczLz43MQK3URLI9NUC/MUg5REcyWgjoKi1LTMCrBp0bG
 1tQB0iY2eXQAAAA==
X-Change-ID: 20250304-ntc_min_max-a925e87d0da7
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741076683; l=2025;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=CtUQPwJHavioCaVE/ITL8uSD7Pf7f336ipLgnIe6DqQ=;
 b=VFtcbljprV8WoPiWguyklrq7/qaLVB3HmKS463g82n6G8aqwOurAdFbPbzZhWxI6zEoLahSgm
 h8SEs5l/xFuBQ2FXtWz2q45eksoMtFL2AGfke/QRtIW/sQrO+8omJyx
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add the min and max temperature attributes as it is trivial for this
driver.

This can help with detecting implausible readings and indicates to users
which range they can actually measure, so they will not set a trip point
at a temperature higher than max or lower than min.

This implementation only works for ntcs, if a ptc gets added this will
have to be changed, but I'm not sure if that is ever the intention.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 drivers/hwmon/ntc_thermistor.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 0d29c8f97ba7c2f264588b6309b91ca494012ad6..fecee177be5daf304c0521a74f2733f6e42567e0 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -522,6 +522,12 @@ static int ntc_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_temp_type:
 			*val = 4;
 			return 0;
+		case hwmon_temp_min:
+			*val = data->comp[0].temp_c*1000;
+			return 0;
+		case hwmon_temp_max:
+			*val = data->comp[data->n_comp-1].temp_c*1000;
+			return 0;
 		default:
 			break;
 		}
@@ -539,6 +545,8 @@ static umode_t ntc_is_visible(const void *data, enum hwmon_sensor_types type,
 		switch (attr) {
 		case hwmon_temp_input:
 		case hwmon_temp_type:
+		case hwmon_temp_min:
+		case hwmon_temp_max:
 			return 0444;
 		default:
 			break;
@@ -549,7 +557,8 @@ static umode_t ntc_is_visible(const void *data, enum hwmon_sensor_types type,
 
 static const struct hwmon_channel_info * const ntc_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_TYPE),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_TYPE | HWMON_T_MIN |
+					 HWMON_T_MAX),
 	NULL
 };
 

---
base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
change-id: 20250304-ntc_min_max-a925e87d0da7

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



