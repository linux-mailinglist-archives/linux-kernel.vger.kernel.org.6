Return-Path: <linux-kernel+bounces-417512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEBD9D54FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8318B1F20614
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A58C1DC1B7;
	Thu, 21 Nov 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiNv2vpk"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928641DDA2F;
	Thu, 21 Nov 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225509; cv=none; b=hac2YJaUqrpjo86RrWVgylsmA3IOEt5R7zGiQ+beAtAKKN7Bi9u9OvovRAGbFdkxlAKlcdVNiAVpvyTA9tFZjWqrEqkmsGVtAbo5UNgcK8PHOa/VqEkRb880WoaBm4f0vVP04k3Ow2HxF/CYrpdMkwTkYU23B0hgwoDSkrJI1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225509; c=relaxed/simple;
	bh=cAPRlqfmem4ZUOZNsb73Kqr8EsdpJovMlH2T1kFWOXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5tWCMM596I7dyukX38WLjaesFXZ0IN910+3/wzzhS+d/UMAkzpO8gPsTdryc7EhnBR3JJnY22YP4WFbQCRaVnbTNzhVxXDe6zWcS3xR5ExmankdK7moKbYTIh/C48N4M1ydJJZDXxNplXrEvoBWH6Kmi25bc+WweK3TN1hSV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiNv2vpk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so922004f8f.3;
        Thu, 21 Nov 2024 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732225506; x=1732830306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsO5TXWUmIJB0UF9EZfURqtCuTGKyAOmc2IK79hH25k=;
        b=QiNv2vpkZiTsbLJFeRFMavl2c19DJs1VuyqhYsyWyZIx0pFEmz/qdAaUv8014WMAc8
         Gj1xryKtgvlylc3JG6wJYnuNAY2AGb3kjJphJhfhS24oLu+9q/oLHnsSCx8LDh29Shrp
         gI+HTGM5JqQTbpjl69iM/LBQJySoUia9iUwMABTpwtGCcj7w0Kxq4CF/1V1s0aQOKKJI
         owdVizS+6lLfmF47UvvDIUVC4GyM2fxelycpqYzTE3zlPcIzxnikZNR2h31d/ZhImFey
         k18R1q0iX+6Q7b5ztLfaWpNGYjOfbymRodLRPLaViOehVgvbZO884p5Ja8togRO+wWqF
         DzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225506; x=1732830306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsO5TXWUmIJB0UF9EZfURqtCuTGKyAOmc2IK79hH25k=;
        b=YbwKnsbzpStvvEYLglVDhWLA+f1mSek8aOUgGBaFdRehYgBEF7MOJPk49ZjfgJpW2U
         1d+VUCCOnIvdugInKSSouTk95hTDSgcUorkplyWEi2AGl+IpNzkgn79F4voZ4FaUF8L6
         qP9pDdxw6/dMZhVhqocDqFE1/58hE//i6OrOPqtOzNB1NJYMTR22cB2Dd2vho4zByjAZ
         9wBRMb30Hat0KBpoGB6Ocrb20YkR2mJYfska2b6WFh0bwDiW7ItPYDqN50Lm92zyu3fa
         3Awh1yuQAyinWDb9F7lmXcccSkgf7XoXFErr+9jb6GC5XTGkrMRpQqCmMaAwFYN1Ia1q
         kRTg==
X-Forwarded-Encrypted: i=1; AJvYcCWrEh5j6x9cTJXoUqw+5GiaibDfteDy9SpsaxKeQRNYBY0qwZnf45A6QGezvQc3DiZZ+dV5esn9JBK5Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrjNV9dk8/8Y4FilmNkeKF1qm9e7Bfk2FKT9hzMK4gWbahid7
	tqkvPXL01H1GWjaUPsrNLxqBjc447w5l74dmglh9YUNX8ReJ2DS7
X-Gm-Gg: ASbGncsvmwbDPkhDh5GaK15RSp6JrF+L5YPg7pyccHDPtfC8nqljHXvHXdE8Z5lZdJ1
	PdRN5Jpao2J9E/cqUXVYx0ys4fiV6KTGzl9Ca8cpV+I4DTEffxCdQ03zOqrjkx9qrPMq5eIKYgc
	ROioDuhqi3xzzEhqEA+WJ2CdOufp+TbuoKFL/txOJMEKYe3GYbPc3rQV874cLUyUP+VCySyP0JT
	T4lpO9XfzFah8bzy4fs8b/WPAaDBm21MpPWv+CvbKyMMZ8KhQuPLZmGqkvw8PwLLbU16ls+BfO+
	YzwzLREdEQdHLwUXNXh0RCl8AzX+Jy/fX/vMA75Uh4gbyiGv0S0+80q9zDcX7hZNxL/SbZPE
X-Google-Smtp-Source: AGHT+IECyXWoa3vNC6aG+mGBIil4TrFWvVZHen3azU0MomrvCyNE6ChZKRoohVA5IsGJ/8moQEvjew==
X-Received: by 2002:a5d:588f:0:b0:382:4851:46d2 with SMTP id ffacd0b85a97d-38260b45c95mr572678f8f.1.1732225505587;
        Thu, 21 Nov 2024 13:45:05 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7b6a-90cc-9bcd-a2c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7b6a:90cc:9bcd:a2c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb53858sm636694f8f.62.2024.11.21.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:45:05 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Nov 2024 22:44:56 +0100
Subject: [PATCH 2/2] hwmon: (chipcap2) Switch to guard() for mutext
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-chipcap_no_iio-v1-2-6c157848a36f@gmail.com>
References: <20241121-chipcap_no_iio-v1-0-6c157848a36f@gmail.com>
In-Reply-To: <20241121-chipcap_no_iio-v1-0-6c157848a36f@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732225501; l=3960;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cAPRlqfmem4ZUOZNsb73Kqr8EsdpJovMlH2T1kFWOXM=;
 b=jk/nhwFA9U5gAWsQlRrkxtnSLmtgSRavfXDCD7rTFNPFtnNfJbGbEbqg7O9x3906nlVIxjAgo
 mLeq7kDrZ4pDEaAGeRAdxrbqWp6snw3H7zeuEOGhcPy45T/MgVluUW8
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to guard() for mutex handling to simplify the code, getting rid
of the 'ret = x, break; return ret;' construct and returning the result
of the operation instead.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 63 ++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index edf454474f11..9d071f7ca9d2 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/hwmon.h>
@@ -556,55 +557,40 @@ static int cc2_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		    int channel, long *val)
 {
 	struct cc2_data *data = dev_get_drvdata(dev);
-	int ret = 0;
 
-	mutex_lock(&data->dev_access_lock);
+	guard(mutex)(&data->dev_access_lock);
 
 	switch (type) {
 	case hwmon_temp:
-		ret = cc2_measurement(data, type, val);
-		break;
+		return cc2_measurement(data, type, val);
 	case hwmon_humidity:
 		switch (attr) {
 		case hwmon_humidity_input:
-			ret = cc2_measurement(data, type, val);
-			break;
+			return cc2_measurement(data, type, val);
 		case hwmon_humidity_min:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_L_ON, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_L_ON, val);
 		case hwmon_humidity_min_hyst:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_L_OFF, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_L_OFF, val);
 		case hwmon_humidity_max:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_H_ON, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_H_ON, val);
 		case hwmon_humidity_max_hyst:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_H_OFF, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_H_OFF, val);
 		case hwmon_humidity_min_alarm:
-			ret = cc2_humidity_min_alarm_status(data, val);
-			break;
+			return cc2_humidity_min_alarm_status(data, val);
 		case hwmon_humidity_max_alarm:
-			ret = cc2_humidity_max_alarm_status(data, val);
-			break;
+			return cc2_humidity_max_alarm_status(data, val);
 		default:
-			ret = -EOPNOTSUPP;
+			return -EOPNOTSUPP;
 		}
-		break;
 	default:
-		ret = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
-
-	mutex_unlock(&data->dev_access_lock);
-
-	return ret;
 }
 
 static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		     int channel, long val)
 {
 	struct cc2_data *data = dev_get_drvdata(dev);
-	int ret;
 	u16 arg;
 	u8 cmd;
 
@@ -614,41 +600,28 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	if (val < 0 || val > CC2_RH_MAX)
 		return -EINVAL;
 
-	mutex_lock(&data->dev_access_lock);
+	guard(mutex)(&data->dev_access_lock);
 
 	switch (attr) {
 	case hwmon_humidity_min:
 		cmd = CC2_W_ALARM_L_ON;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	case hwmon_humidity_min_hyst:
 		cmd = CC2_W_ALARM_L_OFF;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	case hwmon_humidity_max:
 		cmd = CC2_W_ALARM_H_ON;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	case hwmon_humidity_max_hyst:
 		cmd = CC2_W_ALARM_H_OFF;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-
-	mutex_unlock(&data->dev_access_lock);
-
-	return ret;
 }
 
 static int cc2_request_ready_irq(struct cc2_data *data, struct device *dev)

-- 
2.43.0


