Return-Path: <linux-kernel+bounces-407010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A2F9C676A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430D6B2630B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8C1494DD;
	Wed, 13 Nov 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1aCocgA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288001419A9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465630; cv=none; b=IKPGhTXgag5bRESqYif5WHBh5T/BVCk6ZziCeuwjGQUdejuJZbHQvnSWk+H/vkeXIerqNL/4s0WJSrORLGFHHld2+9t8NFP/xaSR+xPkla4mZDZWXxpyMkEwFuBefkDM03X8OG05k11oyhZxEJWGAAaFJg0C0pzvx20u11LdvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465630; c=relaxed/simple;
	bh=T13dYZj5wf2Zd3XF41N7aemiKFJr6ayRHpqcY9xRpR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJx4Tjl7HslzmThX536/eZHfvJ2kPSUb/gibuhnR0a5+17nXsa+wHCL8XjvjYDNGj/ZPtzP1EEcxN+eAxjUlBgv5hO/MlbsQYJQU+ggj/qwFo7AAR/puyrb2PH19qUFG3e8WlcNoD1iUcwqheVT63aMw9FTGsK5WsCFdBFbcp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L1aCocgA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca1b6a80aso69487695ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731465627; x=1732070427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUswgydF4ecDD8gA1hGl988rFxQMVbM/Q/QpWYHHIvg=;
        b=L1aCocgABbOP+l5rs4E+n5MoRU/dkQ19pizpfIMviXxj6JeXoVoybwwbKXG2t5DAMe
         mqByfrPGu3LZKftd/PmD+92SBWEyK6m8GoHwPN3u+T9jszMNQopopHfDoIQBH+MARRec
         T91Ye0rXtFMS/AoNf2wPAyRGLRxGbTES49cpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731465627; x=1732070427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUswgydF4ecDD8gA1hGl988rFxQMVbM/Q/QpWYHHIvg=;
        b=xKCuQuNoAsP/VtdcEFG5itUqgUEq/cLqgsfIw3/sF7eo1O0f1auNHCo3hgVkiER4it
         ROgNIitVq0BnveyAXOWtszhGtHaYu29gvdP0sXQddlH/W0XViQoQp1HUcX6SCshnqEIn
         3lvMhfEj54uBRS4I2yR8HNOT/nH9DetBN/aymZoABsfVJNzjQExWiA08+NMh9KoiJrMW
         iVfv7fVAoCqf3GxOfXw9AB9fZTpvup+arVdj/PrcHTtuaipgjEvZBNeCe+m9lM9KKgv5
         jKXvju42Awxje96RU+j4YnMWHhyV7WNsrlxn4gULJmrpcWDNzGwveSJoRUw4YiyJlexE
         qiQg==
X-Forwarded-Encrypted: i=1; AJvYcCWLIhZo5Y1hlDwjDjr1U4DsOwYlOEY8ZN/IsZp2kiTKUVNVxapi1FCQ2qT8zoTvHuHUnwqChIRAaYtWLYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHJrdG5LbFDcrowkVcrPTRlfI2dRUorIpGyTQA+h8o9Mjfmj6
	yfX7kWW5rOk3G9ovmRYT/jwH/YQD9ip4OB4ZmCXR5we2GDIn5gDWW7zzva1Vpw==
X-Google-Smtp-Source: AGHT+IGby99YKs2n1DW3eqEgTozJAq71CGujBYHsrQ+I43rpaTsytkJKH0YHFTNW8GkOp0t5qemLMg==
X-Received: by 2002:a17:902:d505:b0:20b:8e18:a396 with SMTP id d9443c01a7336-21183c7e137mr245463495ad.9.1731465627355;
        Tue, 12 Nov 2024 18:40:27 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:3dd4:86fa:9696:4236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e418d6sm101831325ad.142.2024.11.12.18.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:40:26 -0800 (PST)
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: 
Cc: "Sung-Chi, Li" <lschyi@chromium.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v3 1/2] hwmon: (cros_ec) register thermal sensors to thermal framework
Date: Wed, 13 Nov 2024 10:39:51 +0800
Message-ID: <20241113024000.3327161-1-lschyi@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241111074904.1059268-1-lschyi@chromium.org>
References: <20241111074904.1059268-1-lschyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cros_ec hwmon driver probes available thermal sensors when probing the
driver.  Register these thermal sensors to the thermal framework as well
via setting HWMON_C_REGISTER_TZ as a chip info, such that thermal
framework can adopt these sensors as well.

To make cros_ec registrable to thermal framework, the cros_ec dts need
the corresponding changes:

&cros_ec {
	#thermal-sensor-cells = <1>;
};

Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
---
 Changes in v2:
   - Rename `cros_ec_sensor_data` to `cros_ec_hwmon_thermal_zone_data`.
   - Rename `addr` in struct `cros_ec_hwmon_thermal_zone_data` to `idx`.
   - Use `cros_ec_hwmon_temp_to_millicelsius` to do value conversion in
     `cros_ec_thermal_get_temp` function.
   - Rename `cros_ec_thermal_get_temp` to `cros_ec_hwmon_thermal_get_temp` to
     make `cros_ec_hwmon` a prefix.
   - Use `%pe` in `cros_ec_hwmon_probe_temp_sensors` when printing out
     `data->tz_dev` if failed register thermal device.
   - Remove `cros_ec_hwmon_remove`, and the `.remove` value in
     `cros_ec_hwmon_driver` since there is no need to call
     `devm_thermal_of_zone_unregister` for clean up.
   - Revert function signature of `cros_ec_hwmon_probe_temp_sensors` since all
     needed parameters are presented.
   - Revert include of `linux/list.h` because no list data structure is used.
---
 Changes in v3:
   - Revert all changes and just as add HWMON_C_REGISTER_TZ as a chip info.
   - Remove unneeded Change-Id tag in commit message.
---
 drivers/hwmon/cros_ec_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 5514cf780b8b..9991c3fa020a 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -141,6 +141,7 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 }
 
 static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
-- 
2.47.0.338.g60cca15819-goog


