Return-Path: <linux-kernel+bounces-287217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E669524E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62212287E74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C41C8235;
	Wed, 14 Aug 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b="iWS8QOmB"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917C7346D;
	Wed, 14 Aug 2024 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671734; cv=none; b=BdZNIm1vbyufZFe4R4/hMo4qg6k/xLsh7OqY2TD3qOjk9kH15CMby0a1tKGIf2d9Qs1xsCwABmo8+KYKmDz92DJclwDa7aBYNlQ48lQBlEZB1HWhhXX1b7gCmQxIpWM6ChCG/jDOtXOQeb+EUjRVmUznFW1Wq7aFeRyib94I/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671734; c=relaxed/simple;
	bh=M3P4qYfTBEGbPWET0J9WU05oJL3CJPfZe0qvH/ww46c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyb9S7UdGXk2oqtfG0Vo1Qcq3WyDq6GFhEXijPugx7rN4oYMT3rE5OoT7F/+zyUUjYIgTVhzNsSsMJPSB4lnc/gdSnbeo2okqIXwzweR/efC/SWOaJvUPCTB9bN8JhTXlcM6bxN2WXeoBIYv+buEaDyOuyzBcdp/QKU3JPAuZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de; spf=pass smtp.mailfrom=matthias-fetzer.de; dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b=iWS8QOmB; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-fetzer.de
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4WkhWf64hBz3xKD;
	Wed, 14 Aug 2024 23:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matthias-fetzer.de;
	s=key2; t=1723671646;
	bh=M3P4qYfTBEGbPWET0J9WU05oJL3CJPfZe0qvH/ww46c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWS8QOmBC+vs0w7G/TQg3oZZwmOPOIfSQcNNmD6P7pwctFDY4TR15tYnH3Q/ARAge
	 t1yUgyyoNMWQuKZM3y3lpp6D0+i/H+UsnLOzuKqvNcn1yoUijE1B6AZBr+rFN09f/z
	 SLjJVNc0Q1ZI2xCoGkrvTTo/Fs+sceSzZGCluImzlDHRWTDIu5FDygcG/QmVGNnruf
	 8mjweigw/NDQAQJqPJ6FRTslVkoZJnDU1URFPeR9r/8FwIWg86ycluAa6gimhaLYLz
	 OvBCBD0+reSlH5KluzZcbJ9gRuq9abGFzgbMYoRtSHPdA8kPaLhrz+h4NrPJLxFbyv
	 72F+ZGkox1VJg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4WkhWf5NSCz3xKC;
	Wed, 14 Aug 2024 23:40:46 +0200 (CEST)
Received: from mxf9a3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4WkhY010bpz8sZV;
	Wed, 14 Aug 2024 23:41:55 +0200 (CEST)
Received: from matthias-pc.lan (unknown [IPv6:2001:9e8:1a56:7800:f45a:ce65:c933:ba51])
	by mxf9a3.netcup.net (Postfix) with ESMTPSA id CE3B8402C2;
	Wed, 14 Aug 2024 23:41:50 +0200 (CEST)
Authentication-Results: mxf9a3;
	spf=pass (sender IP is 2001:9e8:1a56:7800:f45a:ce65:c933:ba51) smtp.mailfrom=kontakt@matthias-fetzer.de smtp.helo=matthias-pc.lan
Received-SPF: pass (mxf9a3: connection is authenticated)
From: Matthias Fetzer <kontakt@matthias-fetzer.de>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthias Fetzer <kontakt@matthias-fetzer.de>
Subject: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan
 support
Date: Wed, 14 Aug 2024 23:39:27 +0200
Message-ID: <20240814213927.49075-1-kontakt@matthias-fetzer.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <e4e32316-509c-28c6-fd18-38ed17e9e35a@linux.intel.com>
References: <e4e32316-509c-28c6-fd18-38ed17e9e35a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <172367171133.29725.15387891987436781293@mxf9a3.netcup.net>
X-Rspamd-Queue-Id: CE3B8402C2
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: Zmn7l9HjBydQp3pUdy6BupIzQ5qGImbQveu1dytT+RHjS5mGlkibN2xo

Fan control on the E531 is done using the ACPI methods FANG and
FANW. The correct parameters and register values were found by
analyzing EC firmware as well as DSDT. This has been tested on
my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).

Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
---

Changes in v3:
    - Add missing newline
    - Remove redundant code
Changes in v2:
    - Fix typo in EC memory description
    - Split plausibilty check for better readability

 drivers/platform/x86/thinkpad_acpi.c | 150 ++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 397b409064c9..64d1b49b7e48 100644
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
+ *	0xf506:
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
@@ -8157,6 +8213,8 @@ static int fan2_get_speed(unsigned int *speed)
 
 static int fan_set_level(int level)
 {
+	int rc;
+
 	if (!fan_control_allowed)
 		return -EPERM;
 
@@ -8206,6 +8264,37 @@ static int fan_set_level(int level)
 			tp_features.fan_ctrl_status_undef = 0;
 		break;
 
+	case TPACPI_FAN_WR_ACPI_FANW:
+		if (!(level & TP_EC_FAN_AUTO) && (level < 0 || level > 7))
+			return -EINVAL;
+		if (level & TP_EC_FAN_FULLSPEED)
+			return -EINVAL;
+
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
@@ -8284,6 +8373,19 @@ static int fan_set_enable(void)
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
@@ -8326,6 +8428,22 @@ static int fan_set_disable(void)
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
@@ -8359,6 +8477,23 @@ static int fan_set_speed(int speed)
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
@@ -8701,6 +8836,10 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		TPACPI_ACPIHANDLE_INIT(gfan);
 		TPACPI_ACPIHANDLE_INIT(sfan);
 	}
+	if (tpacpi_is_lenovo()) {
+		TPACPI_ACPIHANDLE_INIT(fang);
+		TPACPI_ACPIHANDLE_INIT(fanw);
+	}
 
 	quirks = tpacpi_check_quirks(fan_quirk_table,
 				     ARRAY_SIZE(fan_quirk_table));
@@ -8720,6 +8859,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
+	} else if (fang_handle) {
+		/* E531 */
+		fan_status_access_mode = TPACPI_FAN_RD_ACPI_FANG;
 	} else {
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
@@ -8766,6 +8908,11 @@ static int __init fan_init(struct ibm_init_struct *iibm)
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
@@ -8917,6 +9064,7 @@ static int fan_read(struct seq_file *m)
 
 	case TPACPI_FAN_RD_TPEC_NS:
 	case TPACPI_FAN_RD_TPEC:
+	case TPACPI_FAN_RD_ACPI_FANG:
 		/* all except 570, 600e/x, 770e, 770x */
 		rc = fan_get_status_safe(&status);
 		if (rc)
@@ -8937,7 +9085,7 @@ static int fan_read(struct seq_file *m)
 			 * No other levels settings available
 			 */
 			seq_printf(m, "level:\t\t%s\n", status & FAN_NS_CTRL ? "unknown" : "auto");
-		} else {
+		} else if (fan_status_access_mode == TPACPI_FAN_RD_TPEC) {
 			if (status & TP_EC_FAN_FULLSPEED)
 				/* Disengaged mode takes precedence */
 				seq_printf(m, "level:\t\tdisengaged\n");
-- 
2.46.0


