Return-Path: <linux-kernel+bounces-558758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B469A5EACB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31993189883B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645211F460A;
	Thu, 13 Mar 2025 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cQqifo8s"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9001F4195
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741841290; cv=none; b=egrrqeV9eBHq9VYj6ZhI1mPb86MEobRcuaA84p1Ij72u5S+i3PUwAewe7nHho9t1vaCN2hl21S6gijF3XRX+11rk4Bvf+Nd8EgCPdhDfStKnZX9b3mQ1nMUiuZVGES+XnbuZAIC/Gd/j/quFPmSfnRpzCE8QrFRizayIKON9yeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741841290; c=relaxed/simple;
	bh=dDVtZ1x2j0ImBV1/fGLenYXfzl2AU5H3a103lpK7oR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svMHg/QNQpDO1bc0H56oZLKJE1nA+SKSgkkV0mdWmShHyyszywECxEZ9ZSrVcMAmzbifbUUwJCN0n0BHGhFpz/6c4PO6sBRNSXIE+CQT+aXbFOZ5DCw5lXEwNTrsa2eCxxROZDFS9gH/yIZ7aoAkm9hcMEXRDu0aSbIzuHf/9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cQqifo8s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22403cbb47fso10506285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741841288; x=1742446088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBcgfIiObIi/3SSKsTLER8rj7ajdp492rQC6TZ4MQVE=;
        b=cQqifo8siVhGuhtCUGukM3WQaRwYAdjC01X4PFAMSNQMY0OSLylNc3UwgHFZ0hfn0o
         RLwG3Z7bH8sSQWbi68ULBivJcvowj3BzRWDSFK0MIZvTqkxRk0nm36QbCeLZWVT3aNYL
         6Sd0WzfOXv6vHKoZOMiuHNC3hTv0YzUTGSy7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741841288; x=1742446088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBcgfIiObIi/3SSKsTLER8rj7ajdp492rQC6TZ4MQVE=;
        b=vNwXSJ55AgvFfh/0DafIU3JqNSY3+kfh7aBkxGCFt9a3v7156L6pnUdBP31R4O5mwg
         Xx5x1xR+9LIRnlcDbRFedM+CRdQqe4SBA7+HSqdgcwPD2+fwrMpTbjZeAyCtXEhL6Urr
         EmgZlqAcS46xdWWLw/7AVIJd7F1/7+4S/QqG3ALVB8pNU+Z5H2p8N7p7UkLpfH/l0gGD
         //W1lkbyW8EPhP3cIBw/5J4WjKQD1oClXTS09iVvBTRtuToVqtEDtsj1yg4YPgL1dRur
         hxN+Zo6rdsEArLi280s3NqPkPkQ+/xZGeeeDFvr5AeBY2HCpbxeMtc5zLNpqqX+O6XY2
         HzQw==
X-Forwarded-Encrypted: i=1; AJvYcCUHLFDeRH6Vs9As7oI/Rz0SLDtS5Jf9ES9icCTM/apFuBtvMFXpWvGMtM6+acRKvb0+RRJqeC4XI+7RJGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH24C9w18yavWJXPVkCC9euFOhlZGDaNOoT5kvb54tXqokgCv0
	b21LBC44xS0vx4GPBWdQ1mMX82KIUyy6Prr2e6SfRUAlUENJFGis7Fi3d95ptw==
X-Gm-Gg: ASbGncv66jJAkffdirXf3GAQCrN4k2eZPMuXdRuu4LDIinVlysIucjp6eYL5R0H5dnF
	PHlEGyfJvSoW5NwCPCCdaeF0JNN81jAxeIS+oxZBhXtaX/TOAqeIOnk8pwA6kuTxM9DSBChrex1
	Lmyr3eduyVCpihKzkJ/GsETKdpILoWji7T0yn8nbQnacQpedGpzzU+eXYPu/5FzuF6RrDntFLzf
	pRqrdIyIY6BMdxP4l8ETnkUg7kWhIAs6swE3oEV94UfWMx+Q9iAXgm28conFmBk8ShDHDcrME0M
	6AJtqgAoVXss4w4tb482TyNB+dN0enpKnBnol7TFCCYzDdc+JLkXnw6Mma0TsQy7BwU=
X-Google-Smtp-Source: AGHT+IHjNI0QVNBBTnp6ns0zk5oW8aMW/Zec9BzzctcovsX2+GdTh5Zv6MRnDFtEeDkwVkOOEuAzEw==
X-Received: by 2002:a17:902:f68a:b0:216:7926:8d69 with SMTP id d9443c01a7336-22428bf1731mr279459745ad.47.1741841288493;
        Wed, 12 Mar 2025 21:48:08 -0700 (PDT)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:1872:6051:5c24:509e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5c03sm4188025ad.249.2025.03.12.21.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 21:48:08 -0700 (PDT)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Thu, 13 Mar 2025 12:47:43 +0800
Subject: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
In-Reply-To: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741841282; l=1858;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=dDVtZ1x2j0ImBV1/fGLenYXfzl2AU5H3a103lpK7oR4=;
 b=vI0vc/8QKwg48A1HNs3bjMn2lu1UuDOPqIwy47brYYT8UZZvUvyMYKy2fE4WmHPGyLitH8sYg
 nZ6T11fWnlHAxDo2E+ad70qQioiSOcDPfDayDlAvyq2sgniNxypPwEr
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

Implement the functionality of reading the target fan RPM setting from
ChromeOS embedded controller under framework.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 drivers/hwmon/cros_ec_hwmon.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index b2fec0768301f116f49c57b8dbfb042b98a573e1..73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -36,6 +36,19 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
 	return 0;
 }
 
+static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)
+{
+	int ret;
+	struct ec_response_pwm_get_fan_rpm r;
+
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0, &r, sizeof(r));
+	if (ret < 0)
+		return ret;
+
+	*speed = le32_to_cpu(r.rpm);
+	return 0;
+}
+
 static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
 {
 	unsigned int offset;
@@ -95,6 +108,7 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
 	int ret = -EOPNOTSUPP;
+	int32_t target_rpm;
 	u16 speed;
 	u8 temp;
 
@@ -111,6 +125,10 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
 			if (ret == 0)
 				*val = cros_ec_hwmon_is_error_fan(speed);
+		} else if (attr == hwmon_fan_target) {
+			ret = cros_ec_hwmon_read_fan_target(priv->cros_ec, channel, &target_rpm);
+			if (ret == 0)
+				*val = target_rpm;
 		}
 	} else if (type == hwmon_temp) {
 		if (attr == hwmon_temp_input) {

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


