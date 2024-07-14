Return-Path: <linux-kernel+bounces-251873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E88930ADD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FD51C21072
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9136B13B7BC;
	Sun, 14 Jul 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b="kWyq0aYD"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1729428;
	Sun, 14 Jul 2024 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976233; cv=none; b=eGYvlUfGA5U483KDu/VD5EKuCtgfACZOVKDwcTP9z5EfnH1uYGlgdCFlK17ck0Kk9BAYJS5wTrmdLaCcJNUCkGbdZEe+5moL44OZhTEMKeIy8CU1J5V2atP6WAFcvIGNVgMVZ5bMI4LNRpLCVgX0ivDmiqd3uqmAfwqDeI+wO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976233; c=relaxed/simple;
	bh=hYhzJm6uKRvSnZH2YkGhndUBS4BMFTIQ3k0QpkwMutM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/x7n+nWSE5Q50J/zHw5/T3+0ZKgERiUJzoyxd1ySQuBEh8/TysIvcYbazRcPipXzmTFuzAJ0zhDEzYXE3mkLTwN8Ux00tJPcwCy+cscMkRZWtZ++aLPeljqP1j2W2R4IlySgGF2EWQJ/u/xSw4WCYTZYRIgdij8Y1uKeRLrSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de; spf=pass smtp.mailfrom=matthias-fetzer.de; dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b=kWyq0aYD; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-fetzer.de
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4WMWZ30YMzz8yCq;
	Sun, 14 Jul 2024 18:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matthias-fetzer.de;
	s=key2; t=1720975883;
	bh=hYhzJm6uKRvSnZH2YkGhndUBS4BMFTIQ3k0QpkwMutM=;
	h=From:To:Cc:Subject:Date:From;
	b=kWyq0aYDdN5lkRAGakjerqF443j73NPk1ZEGsPuL/bBLWcrSAWq0zbPx+aRULVCFd
	 n5xKdMJ80uHninJZMk5fTEao6JapCwbC5W6nHUii91wsOpe+GalXNALa3bxqid1xah
	 jxXbaQs4yseRRNApqy+rfGQBvWVleHwT+Lr1Dm79RVfS6euR32dUcxTKN6pJ4K9YVd
	 YIgAL4JJksNWpMZNhKUpOqkzs+K8F+Q9N5QKEUI8hnoRVetJrGXGzrlZloM5x4o0Ua
	 WMwGYDNxkJvd1tbujnFJxqO1jm27AdTSQFPh22yjdSCukQNvAqZfegt9fID+oYp7sw
	 3Hw+uU8nGwAVg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4WMWZ26zY9z7vQ8;
	Sun, 14 Jul 2024 18:51:22 +0200 (CEST)
Received: from mxf9a3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4WMWZ23MxVz8sbD;
	Sun, 14 Jul 2024 18:51:22 +0200 (CEST)
Received: from matthias-pc.lan (unknown [IPv6:2001:9e8:1a40:d900:e75f:cd15:1b62:dac9])
	by mxf9a3.netcup.net (Postfix) with ESMTPSA id 4E98540463;
	Sun, 14 Jul 2024 18:51:17 +0200 (CEST)
Authentication-Results: mxf9a3;
	spf=pass (sender IP is 2001:9e8:1a40:d900:e75f:cd15:1b62:dac9) smtp.mailfrom=kontakt@matthias-fetzer.de smtp.helo=matthias-pc.lan
Received-SPF: pass (mxf9a3: connection is authenticated)
From: Matthias Fetzer <kontakt@matthias-fetzer.de>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthias Fetzer <kontakt@matthias-fetzer.de>
Subject: [PATCH] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan
 support
Date: Sun, 14 Jul 2024 18:50:54 +0200
Message-ID: <20240714165054.2261305-1-kontakt@matthias-fetzer.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <172097587786.20568.11031236886820506886@mxf9a3.netcup.net>
X-Rspamd-Queue-Id: 4E98540463
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: DXC8zojYHA9jZn0f82rxTPh4/onN4rrhob49trG4RPCU4PdK+Pa6T5k4

Fan control on the E531 is done using the ACPI methods FANG and
FANW. The correct parameters and register values were found by
analyzing EC firmware as well as DSDT. This has been tested on
my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).

Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
---
 drivers/platform/x86/thinkpad_acpi.c | 159 +++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 397b409064c9..a171a2b39ac9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7751,6 +7751,28 @@ static struct ibm_struct volume_driver_data = {
  * 	EC 0x2f (HFSP) might be available *for reading*, but do not use
  * 	it for writing.
  *
+ * TPACPI_FAN_RD_ACPI_FANG:
+ * 	ACPI FANG method: returns fan control register
+ *
+ *	Takes one parameter which is 0x8100 plus the offset to EC memory
+ *	address 0xf500 and returns the byte at this address.
+ *
+ *	0xf500:
+ *		When the value is less than 9 automatic mode is enabled
+ *	0xf502:
+ *		Contains the current fan speed from 0-100%
+ *	0xf504:
+ *		Bit 7 has to be set in order to enable manual control by
+ *		writing a value >= 9 to 0xf500
+ *
+ * TPACPI_FAN_WR_ACPI_FANW:
+ * 	ACPI FANG method: sets fan control registers
+ *
+ * 	Takes 0x8100 plus the offset to EC memory address 0xf500 and the
+ * 	value to be written there as parameters.
+ *
+ *	see TPACPI_FAN_RD_ACPI_FANG
+ *
  * TPACPI_FAN_WR_TPEC:
  * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode
  * 	Supported on almost all ThinkPads
@@ -7884,6 +7906,7 @@ enum {					/* Fan control constants */
 enum fan_status_access_mode {
 	TPACPI_FAN_NONE = 0,		/* No fan status or control */
 	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
+	TPACPI_FAN_RD_ACPI_FANG,	/* Use ACPI FANG */
 	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
 	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga gen2 etc.) */
 };
@@ -7891,6 +7914,7 @@ enum fan_status_access_mode {
 enum fan_control_access_mode {
 	TPACPI_FAN_WR_NONE = 0,		/* No fan control */
 	TPACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
+	TPACPI_FAN_WR_ACPI_FANW,	/* Use ACPI FANW */
 	TPACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
 	TPACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
 };
@@ -7924,9 +7948,13 @@ TPACPI_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
 TPACPI_HANDLE(gfan, ec, "GFAN",	/* 570 */
 	   "\\FSPD",		/* 600e/x, 770e, 770x */
 	   );			/* all others */
+TPACPI_HANDLE(fang, ec, "FANG",	/* E531 */
+	   );			/* all others */
 TPACPI_HANDLE(sfan, ec, "SFAN",	/* 570 */
 	   "JFNS",		/* 770x-JL */
 	   );			/* all others */
+TPACPI_HANDLE(fanw, ec, "FANW",	/* E531 */
+	   );			/* all others */
 
 /*
  * Unitialized HFSP quirk: ACPI DSDT and EC fail to initialize the
@@ -8033,6 +8061,23 @@ static int fan_get_status(u8 *status)
 
 		break;
 	}
+	case TPACPI_FAN_RD_ACPI_FANG: {
+		/* E531 */
+		int mode, speed;
+
+		if (unlikely(!acpi_evalf(fang_handle, &mode, NULL, "dd", 0x8100)))
+			return -EIO;
+		if (unlikely(!acpi_evalf(fang_handle, &speed, NULL, "dd", 0x8102)))
+			return -EIO;
+
+		if (likely(status)) {
+			*status = speed * 7 / 100;
+			if (mode < 9)
+				*status |= TP_EC_FAN_AUTO;
+		}
+
+		break;
+	}
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
@@ -8147,6 +8192,17 @@ static int fan2_get_speed(unsigned int *speed)
 		if (speed)
 			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
 		break;
+	case TPACPI_FAN_RD_ACPI_FANG: {
+		/* E531 */
+		int speed_tmp;
+
+		if (unlikely(!acpi_evalf(fang_handle, &speed_tmp, NULL, "dd", 0x8102)))
+			return -EIO;
+
+		if (likely(speed))
+			*speed =  speed_tmp * 65535 / 100;
+		break;
+	}
 
 	default:
 		return -ENXIO;
@@ -8157,6 +8213,7 @@ static int fan2_get_speed(unsigned int *speed)
 
 static int fan_set_level(int level)
 {
+	int rc;
 	if (!fan_control_allowed)
 		return -EPERM;
 
@@ -8206,6 +8263,36 @@ static int fan_set_level(int level)
 			tp_features.fan_ctrl_status_undef = 0;
 		break;
 
+	case TPACPI_FAN_WR_ACPI_FANW:
+		if ((!(level & TP_EC_FAN_AUTO) &&
+		    ((level < 0) || (level > 7))) ||
+		    (level & TP_EC_FAN_FULLSPEED))
+			return -EINVAL;
+		if (level & TP_EC_FAN_AUTO) {
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {
+				rc = -EIO;
+				break;
+			}
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) {
+				rc = -EIO;
+				break;
+			}
+		} else {
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
+				rc = -EIO;
+				break;
+			}
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
+				rc = -EIO;
+				break;
+			}
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, level * 100 / 7)) {
+				rc = -EIO;
+				break;
+			}
+		}
+		break;
+
 	default:
 		return -ENXIO;
 	}
@@ -8284,6 +8371,19 @@ static int fan_set_enable(void)
 			rc = 0;
 		break;
 
+	case TPACPI_FAN_WR_ACPI_FANW:
+		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {
+			rc = -EIO;
+			break;
+		}
+		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) {
+			rc = -EIO;
+			break;
+		}
+
+		rc = 0;
+		break;
+
 	default:
 		rc = -ENXIO;
 	}
@@ -8326,6 +8426,22 @@ static int fan_set_disable(void)
 			fan_control_desired_level = 0;
 		break;
 
+	case TPACPI_FAN_WR_ACPI_FANW:
+		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
+			rc = -EIO;
+			break;
+		}
+		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
+			rc = -EIO;
+			break;
+		}
+		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, 0x00)) {
+			rc = -EIO;
+			break;
+		}
+		rc = 0;
+		break;
+
 	default:
 		rc = -ENXIO;
 	}
@@ -8359,6 +8475,23 @@ static int fan_set_speed(int speed)
 			rc = -EINVAL;
 		break;
 
+	case TPACPI_FAN_WR_ACPI_FANW:
+		if (speed >= 0 && speed <= 65535) {
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
+				rc = -EIO;
+				break;
+			}
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
+				rc = -EIO;
+				break;
+			}
+			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd",
+					0x8102, speed * 100 / 65535))
+				rc = -EIO;
+		} else
+			rc = -EINVAL;
+		break;
+
 	default:
 		rc = -ENXIO;
 	}
@@ -8701,6 +8834,10 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		TPACPI_ACPIHANDLE_INIT(gfan);
 		TPACPI_ACPIHANDLE_INIT(sfan);
 	}
+	if (tpacpi_is_lenovo()) {
+		TPACPI_ACPIHANDLE_INIT(fang);
+		TPACPI_ACPIHANDLE_INIT(fanw);
+	}
 
 	quirks = tpacpi_check_quirks(fan_quirk_table,
 				     ARRAY_SIZE(fan_quirk_table));
@@ -8720,6 +8857,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
+	} else if (fang_handle) {
+		/* E531 */
+		fan_status_access_mode = TPACPI_FAN_RD_ACPI_FANG;
 	} else {
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
@@ -8766,6 +8906,11 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		fan_control_access_mode = TPACPI_FAN_WR_ACPI_SFAN;
 		fan_control_commands |=
 		    TPACPI_FAN_CMD_LEVEL | TPACPI_FAN_CMD_ENABLE;
+	} else if (fanw_handle) {
+		/* E531 */
+		fan_control_access_mode = TPACPI_FAN_WR_ACPI_FANW;
+		fan_control_commands |=
+		    TPACPI_FAN_CMD_LEVEL | TPACPI_FAN_CMD_SPEED | TPACPI_FAN_CMD_ENABLE;
 	} else {
 		if (!gfan_handle) {
 			/* gfan without sfan means no fan control */
@@ -8915,6 +9060,20 @@ static int fan_read(struct seq_file *m)
 			       str_enabled_disabled(status), status);
 		break;
 
+	case TPACPI_FAN_RD_ACPI_FANG:
+		/* E531 */
+		rc = fan_get_status_safe(&status);
+		if (rc)
+			return rc;
+
+		seq_printf(m, "status:\t\t%s\n", str_enabled_disabled(status));
+
+		rc = fan_get_speed(&speed);
+		if (rc < 0)
+			return rc;
+		seq_printf(m, "speed:\t\t%d\n", speed);
+		break;
+
 	case TPACPI_FAN_RD_TPEC_NS:
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
-- 
2.45.2


