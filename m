Return-Path: <linux-kernel+bounces-206747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C117C900D44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B0C2875A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4751552ED;
	Fri,  7 Jun 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QW938rly"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6E14EC6A;
	Fri,  7 Jun 2024 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793790; cv=none; b=jwgVyWqdzMj56lth+mDWuPPImKPGOaRo7kfO4TdTYA8AFVOl22oX7KVH6idsxPrjP3RLcpUY/m8sftJS8tmK4uUX5qfhDGlQ+cgw028K2H2xTmxs4+yulEvX8rRKWcYfgNrBWnG5AybJ9k0a0RTnnsx0X4nq8jmkdU8NCUpdR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793790; c=relaxed/simple;
	bh=ktXUEmcUjD5Wh8D3vcewvXpTf3NnAgA2BZ2xp6uci8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Kav8Xy/tOXrVUW28ZsgX2i+ZTBZvBn/mEJSUy5d/ra0hZIkWGzp64teKA1V8O/LgkIDClojfdaBV/cOr1LKH18vDOa9a3W3DxHXDn8T+S50aVipipLeOTdDULbHPLiLZZVA92oLab5b7Sr7E0qEid9I6h0++y+x/mfYUqIPZ2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QW938rly; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZqJq021467;
	Fri, 7 Jun 2024 20:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TzXklyPvcPuufiSDi0a0B+
	j+GHYArHCSYu8uuGTWYa4=; b=QW938rlys4SK3n4S+A3nUXB94eQgYlT3uneiq9
	5LP1XxJ3H6nMU1Rwx7P9uXeuH33X15b8GhlBEAufo4xv5T1PPT12GCoiFUTP4C7U
	+NP7NkPcI7oxpdE88u+hyyBaZPyMBsPD29lokg/J2mRE6H5met2V35cU6t/GJay3
	VWjah5xSLEhW36mXpQw+qAQKMophF5EMpBH8/b6HNbSQ4Vex6KYhP5NBVOEFNlcs
	yXlKxVUHCaPAfghYNQyPuAZNajXj8ZoBpOL4G93e6q4sT7lbtt8Oe+N+nHyx5iAh
	3Fo8LpEwuNxAyrcJeoli/jjDU2GZG5mzTwRJ7wx16Qv+EJpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ym0sf1hxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 20:56:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457KuEVd015485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 20:56:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 13:56:15 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 13:56:14 -0700
Subject: [PATCH] staging: greybus: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-staging-greybus-v1-1-ff1a0dfa813e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAO1zY2YC/x3MwQqDMAwA0F+RnBeornSwXxk7pDargdmNRMUh/
 rt1x3d5GxirsMG92UB5EZNPqWgvDfQDlcwoqRo613kX3A3HhEllYTW0ibKUjFn5F2dDdj5QS5H
 9NUANvsovWf/541kdyRijUumHs3xLmVccySZW2PcDWJHzXYsAAAA=
To: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer
	<mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder
	<elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Viresh
 Kumar" <vireshk@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>, David Lin
	<dtwlin@gmail.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
CC: <greybus-dev@lists.linaro.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qjXHxTHQ5m-WwwwHjxRBpKpQWMs2EYmC
X-Proofpoint-ORIG-GUID: qjXHxTHQ5m-WwwwHjxRBpKpQWMs2EYmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_12,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070154

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-bootrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-spilib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-light.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-log.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-loopback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-power-supply.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-vibrator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-audio-manager.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gbphy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-pwm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-sdio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-usb.o

Add all missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/staging/greybus/audio_manager.c | 1 +
 drivers/staging/greybus/bootrom.c       | 1 +
 drivers/staging/greybus/camera.c        | 1 +
 drivers/staging/greybus/gbphy.c         | 1 +
 drivers/staging/greybus/gpio.c          | 1 +
 drivers/staging/greybus/hid.c           | 1 +
 drivers/staging/greybus/i2c.c           | 1 +
 drivers/staging/greybus/light.c         | 1 +
 drivers/staging/greybus/log.c           | 1 +
 drivers/staging/greybus/loopback.c      | 1 +
 drivers/staging/greybus/power_supply.c  | 1 +
 drivers/staging/greybus/pwm.c           | 1 +
 drivers/staging/greybus/raw.c           | 1 +
 drivers/staging/greybus/sdio.c          | 1 +
 drivers/staging/greybus/spi.c           | 1 +
 drivers/staging/greybus/spilib.c        | 1 +
 drivers/staging/greybus/uart.c          | 1 +
 drivers/staging/greybus/usb.c           | 1 +
 drivers/staging/greybus/vibrator.c      | 1 +
 19 files changed, 19 insertions(+)

diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
index fa43d35bbcec..27ca5f796c5f 100644
--- a/drivers/staging/greybus/audio_manager.c
+++ b/drivers/staging/greybus/audio_manager.c
@@ -182,5 +182,6 @@ static void __exit manager_exit(void)
 module_init(manager_init);
 module_exit(manager_exit);
 
+MODULE_DESCRIPTION("Greybus audio operations manager");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Svetlin Ankov <ankov_svetlin@projectara.com>");
diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index c0d338db6b52..d4d86b3898de 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -522,4 +522,5 @@ static struct greybus_driver gb_bootrom_driver = {
 
 module_greybus_driver(gb_bootrom_driver);
 
+MODULE_DESCRIPTION("BOOTROM Greybus driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index b8b2bdfa59e5..ca71023df447 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -1374,4 +1374,5 @@ static struct greybus_driver gb_camera_driver = {
 
 module_greybus_driver(gb_camera_driver);
 
+MODULE_DESCRIPTION("Greybus Camera protocol driver.");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index d827f03f5253..d992db8d45cb 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -354,4 +354,5 @@ static void __exit gbphy_exit(void)
 }
 module_exit(gbphy_exit);
 
+MODULE_DESCRIPTION("Greybus Bridged-Phy Bus driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index 2a115a8fc263..4f940b0595e8 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -631,4 +631,5 @@ static struct gbphy_driver gpio_driver = {
 };
 
 module_gbphy_driver(gpio_driver);
+MODULE_DESCRIPTION("GPIO Greybus driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index 15335c38cb26..63c77a3df591 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -516,4 +516,5 @@ static struct greybus_driver gb_hid_driver = {
 };
 module_greybus_driver(gb_hid_driver);
 
+MODULE_DESCRIPTION("HID class driver for the Greybus");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/i2c.c b/drivers/staging/greybus/i2c.c
index 22325ab9d652..14f1ff6d448c 100644
--- a/drivers/staging/greybus/i2c.c
+++ b/drivers/staging/greybus/i2c.c
@@ -318,4 +318,5 @@ static struct gbphy_driver i2c_driver = {
 };
 
 module_gbphy_driver(i2c_driver);
+MODULE_DESCRIPTION("I2C bridge driver for the Greybus 'generic' I2C module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 00360f4a0485..e509fdc715db 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -1339,4 +1339,5 @@ static struct greybus_driver gb_lights_driver = {
 };
 module_greybus_driver(gb_lights_driver);
 
+MODULE_DESCRIPTION("Greybus Lights protocol driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/log.c b/drivers/staging/greybus/log.c
index 971f36dccac6..57dcf9453bf1 100644
--- a/drivers/staging/greybus/log.c
+++ b/drivers/staging/greybus/log.c
@@ -129,4 +129,5 @@ static struct greybus_driver gb_log_driver = {
 };
 module_greybus_driver(gb_log_driver);
 
+MODULE_DESCRIPTION("Greybus driver for the log protocol");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 4313d3bbc23a..1f19323b0e1a 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -1175,4 +1175,5 @@ static void __exit loopback_exit(void)
 }
 module_exit(loopback_exit);
 
+MODULE_DESCRIPTION("Loopback bridge driver for the Greybus loopback module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/greybus/power_supply.c
index 75cb170e05fb..2ef46822f676 100644
--- a/drivers/staging/greybus/power_supply.c
+++ b/drivers/staging/greybus/power_supply.c
@@ -1136,4 +1136,5 @@ static struct greybus_driver gb_power_supply_driver = {
 };
 module_greybus_driver(gb_power_supply_driver);
 
+MODULE_DESCRIPTION("Power Supply driver for a Greybus module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 01883fbcd79b..1cb7b9089ead 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -327,4 +327,5 @@ static struct gbphy_driver pwm_driver = {
 };
 
 module_gbphy_driver(pwm_driver);
+MODULE_DESCRIPTION("PWM Greybus driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
index 836d35e5fa85..71de6776739c 100644
--- a/drivers/staging/greybus/raw.c
+++ b/drivers/staging/greybus/raw.c
@@ -377,4 +377,5 @@ static void __exit raw_exit(void)
 }
 module_exit(raw_exit);
 
+MODULE_DESCRIPTION("Greybus driver for the Raw protocol");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 25bee5335c70..5326ea372b24 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -880,4 +880,5 @@ static struct gbphy_driver sdio_driver = {
 };
 
 module_gbphy_driver(sdio_driver);
+MODULE_DESCRIPTION("SD/MMC Greybus driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/spi.c b/drivers/staging/greybus/spi.c
index 68e8d272db6d..45ea8d1bdd51 100644
--- a/drivers/staging/greybus/spi.c
+++ b/drivers/staging/greybus/spi.c
@@ -75,4 +75,5 @@ static struct gbphy_driver spi_driver = {
 };
 
 module_gbphy_driver(spi_driver);
+MODULE_DESCRIPTION("Greybus SPI bridge PHY driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index 34f10685139f..0e4ae01eb00f 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -567,4 +567,5 @@ void gb_spilib_master_exit(struct gb_connection *connection)
 }
 EXPORT_SYMBOL_GPL(gb_spilib_master_exit);
 
+MODULE_DESCRIPTION("Greybus SPI library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 999ce613dca8..cdf4ebb93b10 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -1024,4 +1024,5 @@ static void gb_uart_driver_exit(void)
 }
 
 module_exit(gb_uart_driver_exit);
+MODULE_DESCRIPTION("UART driver for the Greybus 'generic' UART module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
index b7badf87a3f0..475f24f20cd4 100644
--- a/drivers/staging/greybus/usb.c
+++ b/drivers/staging/greybus/usb.c
@@ -242,4 +242,5 @@ static struct gbphy_driver usb_driver = {
 };
 
 module_gbphy_driver(usb_driver);
+MODULE_DESCRIPTION("USB host driver for the Greybus 'generic' USB module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/greybus/vibrator.c b/drivers/staging/greybus/vibrator.c
index 89bef8045549..ee112aa13ff1 100644
--- a/drivers/staging/greybus/vibrator.c
+++ b/drivers/staging/greybus/vibrator.c
@@ -245,4 +245,5 @@ static __exit void gb_vibrator_exit(void)
 }
 module_exit(gb_vibrator_exit);
 
+MODULE_DESCRIPTION("Greybus Vibrator protocol driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-staging-greybus-e046a1abe436


