Return-Path: <linux-kernel+bounces-285536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F4950F29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA86B21DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E911A76D5;
	Tue, 13 Aug 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b="SQARCeMT"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62017CC;
	Tue, 13 Aug 2024 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584760; cv=none; b=Wri0MCG6vtjnDHGZThkqYIKCPocRtr0wvLAAyUp+XNeqjedJQA9u5VwMUCKV0e6XNKYQkV0QIRuQqv2o1mycrzwCxUHQXImrzTAw/Pr4cTKSERN5nvWrS6wYqUu90ZLHOaljzY0Y1eOSA3zNKhK4HjxWAE+1E9agvmq16QbtgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584760; c=relaxed/simple;
	bh=tBVG9tO/xohpQvDd8LfQYUqDs5X6SxzCoJQdBRgyU/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmH9gaK5kXCYEDYZMFpGeDqVPF17vWuwvqlsOdpl3Ouj+JtNgNLFLHyb3/nMuVl0RT1VwEQr9yUjH5wPeyis0UrlAC7DzZ6cHpqKfeDlWidB+SbvC1vNF8AFZ79PCLtbfz+eNAVimAUujGoqym5QmQwpaPUEKv4opEkE/OCX+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de; spf=pass smtp.mailfrom=matthias-fetzer.de; dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b=SQARCeMT; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-fetzer.de
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4Wk4Cm4l5Dz3xCC;
	Tue, 13 Aug 2024 23:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matthias-fetzer.de;
	s=key2; t=1723584292;
	bh=tBVG9tO/xohpQvDd8LfQYUqDs5X6SxzCoJQdBRgyU/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQARCeMTFFCeCZZ8EJ8vLFIATMYfpWSp8mhb4fc/aoEC5/puL8HplBoiMt3tSGvHX
	 XH4ssPLQfYwremZvcSiDSqXSe3churFM+5fDa+XF8eFww7LUcy5bZHEnvp8ZeFDV3G
	 WHYtYIp5AEuAPg6iNbDB0LjxByeHmGYTiG4dSqvBDEnQ87LLTjF7CSh2ird4J9YeN2
	 oy270AVKc9X4oI4823R7mioXkTChIfkpU9JWjlobIH5qD5QigvPSfxwkT7cnTMPIer
	 BPelT2JstTM+rQxEaVLiC6CDSc9ECXwb++KW7CPjBC/pXs34Mo8BsE8Kw9MvDmYGQN
	 QvqX+UNk1wZLA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4Wk4Cm42Q5z3xCB;
	Tue, 13 Aug 2024 23:24:52 +0200 (CEST)
Received: from mxf9a3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Wk4Dv0jzbz8sZf;
	Tue, 13 Aug 2024 23:25:50 +0200 (CEST)
Received: from matthias-pc.lan (unknown [IPv6:2001:9e8:1a44:c800:511b:4e8:1410:d93])
	by mxf9a3.netcup.net (Postfix) with ESMTPSA id 048AB40277;
	Tue, 13 Aug 2024 23:25:45 +0200 (CEST)
Authentication-Results: mxf9a3;
	spf=pass (sender IP is 2001:9e8:1a44:c800:511b:4e8:1410:d93) smtp.mailfrom=kontakt@matthias-fetzer.de smtp.helo=matthias-pc.lan
Received-SPF: pass (mxf9a3: connection is authenticated)
From: Matthias Fetzer <kontakt@matthias-fetzer.de>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthias Fetzer <kontakt@matthias-fetzer.de>
Subject: [PATCH v2] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan
 support
Date: Tue, 13 Aug 2024 23:24:03 +0200
Message-ID: <20240813212403.92245-1-kontakt@matthias-fetzer.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <187b6058-c41a-4767-af47-ba35451f2049@redhat.com>
References: <187b6058-c41a-4767-af47-ba35451f2049@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <172358434650.5532.16188136969825434785@mxf9a3.netcup.net>
X-Rspamd-Queue-Id: 048AB40277
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: nr2rDQp6rT5Obb/8dHQ73F5r+5/mlI/UhsFWA0KNl2K5QpYpshGKiRRp

Fan control on the E531 is done using the ACPI methods FANG and
FANW. The correct parameters and register values were found by
analyzing EC firmware as well as DSDT. This has been tested on
my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).

Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
---
 drivers/platform/x86/thinkpad_acpi.c | 160 +++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 397b409064c9..31e5de21753f 100644
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
@@ -8157,6 +8213,7 @@ static int fan2_get_speed(unsigned int *speed)
 
 static int fan_set_level(int level)
 {
+	int rc;
 	if (!fan_control_allowed)
 		return -EPERM;
 
@@ -8206,6 +8263,37 @@ static int fan_set_level(int level)
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
@@ -8284,6 +8372,19 @@ static int fan_set_enable(void)
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
@@ -8326,6 +8427,22 @@ static int fan_set_disable(void)
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
@@ -8359,6 +8476,23 @@ static int fan_set_speed(int speed)
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
@@ -8701,6 +8835,10 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		TPACPI_ACPIHANDLE_INIT(gfan);
 		TPACPI_ACPIHANDLE_INIT(sfan);
 	}
+	if (tpacpi_is_lenovo()) {
+		TPACPI_ACPIHANDLE_INIT(fang);
+		TPACPI_ACPIHANDLE_INIT(fanw);
+	}
 
 	quirks = tpacpi_check_quirks(fan_quirk_table,
 				     ARRAY_SIZE(fan_quirk_table));
@@ -8720,6 +8858,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
+	} else if (fang_handle) {
+		/* E531 */
+		fan_status_access_mode = TPACPI_FAN_RD_ACPI_FANG;
 	} else {
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
@@ -8766,6 +8907,11 @@ static int __init fan_init(struct ibm_init_struct *iibm)
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
@@ -8915,6 +9061,20 @@ static int fan_read(struct seq_file *m)
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
2.46.0


