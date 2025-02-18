Return-Path: <linux-kernel+bounces-518878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA3A395BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E8F170041
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D822B8C7;
	Tue, 18 Feb 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDq3weTp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7322D4EB;
	Tue, 18 Feb 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867843; cv=none; b=nHlsALRfhPgbM+iHY+eE7Cyx+6jbvgsyjZHNcDmkJzsIIeljFMU1nV+ENt0zMvOTBSHo5tN7t4K0bwcRk2fCJElNbsTBs6ddkB3rVhJjX1bBf63OruoP0ZXJDa4qs86cua5p1pq9g5GCUvqpSY8o9y+QoqQZHOusqZiewm/ao0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867843; c=relaxed/simple;
	bh=agT0ivrctI/KUajWkSiFEYIZGv7GNeGkv2rX360Jl/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJNzbhk93gn3zUlYEQBSCgZfzus+HRlJZOLBTNI/vFG4FsSStquTs0w0oo+Eeve4hsGh0J4JHcqT3Ds2vql3+c6AAGfms4joWEu9y6pj6s8DjV/RdnQkvVkrDJFZDWBJ3eEkEDAcirFoEpb7GabB5dRHIfLlMZeUwEocNd/BdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDq3weTp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2211cd4463cso38302655ad.2;
        Tue, 18 Feb 2025 00:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867841; x=1740472641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnic9JbG3sWu6H8Aay2HkTXWHQGbZEX99jtJ6cXeuiU=;
        b=mDq3weTpicTLnySxCnMJ1GX6i2VEG9oyLb45rAkxh7XT4bSn+Z2hU4wwRr8sJ3UlAO
         LMtQ9D+xlGsho61GIw2P1BvmEEtCrUzZYARIsSBYfrhLikyHkKSY3KFLAm+/lvCpLvQA
         nnbLauzX9zbdmHj9NaGZ0zzO7VYy1EdoISnNRGBw2N2zsAXkSpd7Ye9Qq8qFQUSqKYxf
         s3nbTpJei43NShefZut+fS+Asvkcz6qUM7PMPPJPtKNi1mOskncaNIKfySp2BBB57RPJ
         eSQKJozTnAHJnAXQMEcNFOcqOCWlXgdWH8Era2FscVw9ThJMuEhuif42Kjmd+Spr3LFw
         zSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867841; x=1740472641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnic9JbG3sWu6H8Aay2HkTXWHQGbZEX99jtJ6cXeuiU=;
        b=I3A5yQ5ovaw8UsHADT5MBLmTAtTHwP3QSFK3sW53pQXbaduUx4ZeBdKXMSz2u1yMPZ
         GRrzoigPZfsszT8n6aAbCbdN/qiotD7COmRpbFnarUaOV+FQxya2R1297dD4doPzH2Vt
         J+tFQ09GOPMn5nbY4dlTRsV3LVesZ7L8BQoxxddUdqMg03UDN64m9o8es2D7ZQjm9tXg
         P92hWBVf7TTu8FOoIcP1KRPjEKJqvcAVoAXFuZkG8uXj39BhiS/nacYvmXUyw50hRdcB
         Rx/8z0lgLs7n0R4T+xyh5PHlaUiHIin6NN4fRphqfle7V5IZHL3IkcotXUFWY3w4Ze5M
         mx3g==
X-Forwarded-Encrypted: i=1; AJvYcCVM6gAU5Dx3KC7pwJVqNzR5cmf3P3g+KJNgm9J6hGKck26Q9FG7TMMV+5kGem/Ri8xBEA6qNYTUiymujK0E@vger.kernel.org, AJvYcCW04IhoS2QNKnHTnCIbmQG0XsP3rfb8xsEk8r5d8Kb+RvCGW0C930e9EACc8po59wUBX2+Q2I+PEmnm@vger.kernel.org, AJvYcCWom21yxcQJ5IYQAYmoSbAOyW0BxgmSom8HscEC5tPN/M+M6GoWMjjXifCASRb88XcGKEakZVaNTGzkPL0=@vger.kernel.org, AJvYcCXVinG8mY8GfKN/wsDQm8SJJKtzXklfbqo3BvriZJJrT/wlGVfJOumHIlqeY/jfc20ftrHTJ1aP5wkvkx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjLSK0r8CJrV9V7lPh6a32pc0ugrRhoJj8syRaA9LbKqULsQC
	zlKI4ewHSWX+lCpH2sOt9Xv1v5kiB9MG5yfHENuX+xjWmILbO+b+AWQTaJ+u
X-Gm-Gg: ASbGncvD26jFCHvcdqYx5ZfCqEguotBnaeI/rTsVRdQR+stGw5eGLt+bqjo8MUDwQTp
	i+6SOU8rJc9rVCTuvskOq+bNSdd9yd7Z0yuXEkJ3hwOKNv0wxoX4gUwgKOtgC93nfoH7vwAruGB
	P+M1MeNJ71QT7VpKZGd/Qk1Q3zjxwvGQyNgdPagxHYloI2psTBuSlIUPee8eUp615FiFd3uoTqb
	JpzYiNas/iTKOJ2GVcyvKJ6Lpop/UtGe+NP6BW58a3Vglem5WTCPKsCHq5m4cGrsuCFP50eXfMH
	e2FF9DoikITMXaAQJfl6s2h4vldwXRfszIE5cbGpCEpDqkJgaUt2c7RWGkpXuibAbsJPWMIngSl
	VOjPeIhgXUw==
X-Google-Smtp-Source: AGHT+IG/Xuh35WlN+lgZ8IVJYVEsBTdwZXAhKEGZ6lCoVPM1Lx7f7i8b6ArOxPRK0N6oxyRbKyYn6Q==
X-Received: by 2002:a05:6a21:790b:b0:1ee:a914:1d5a with SMTP id adf61e73a8af0-1eea9141fe2mr12252238637.2.1739867840812;
        Tue, 18 Feb 2025 00:37:20 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:37:20 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:45 +1000
Subject: [PATCH v2 11/29] ASoC: tas2764: Apply Apple quirks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-11-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8993;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=hTdkxszMjHs4mDQJvXhHqvdDjXwAQywhuJAeI6qSArg=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BJClI4UOooXm3cxat2/mfM9yuJnYWN4fSRX8+615
 0rffZ/WUcrCIMbFICumyLKhSchjthHbzX6Ryr0wc1iZQIYwcHEKwEQ0EhgZvl8q9Lf5c65zR+m+
 qmWHW9OSZDtTgrmX/j/8I/G7h/WcpYwM/0IsGJpXLd97+cDL+pTCXWu4c1Sv3JooNnUpk0VJmO1
 tJgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Apple's SN012776 driver has some peculiar aspects to its behavior that
are suspected to work around issues in the codec part. Add a module
parameter for enabling individual quirks that should be imitated after
the Apple driver.

Setting some of these by default seems to be required. For example,
setting 0xf fixes an issue with transient overcurrent errors which
can crash the chip until the next system reboot. To be safe, let's
enable all of them by default.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Co-developed-by: James Calligeros <jcalligeros99@gmail.com>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764-quirks.h | 180 +++++++++++++++++++++++++
 sound/soc/codecs/tas2764.c        |  38 ++++++
 2 files changed, 218 insertions(+)

diff --git a/sound/soc/codecs/tas2764-quirks.h b/sound/soc/codecs/tas2764-quirks.h
new file mode 100644
index 0000000000000000000000000000000000000000..7a62b3ba5b40b3f06fc1ebeb590d9c32b1b2c7d3
--- /dev/null
+++ b/sound/soc/codecs/tas2764-quirks.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __TAS2764_QUIRKS__
+#define __TAS2764_QUIRKS__
+
+#include <linux/regmap.h>
+
+#include "tas2764.h"
+
+/* Bitmask of enabled Apple quirks */
+#define ENABLED_APPLE_QUIRKS	0x3f
+
+/*
+ * Disable noise gate and flip down reserved bit in NS_CFG0
+ */
+#define TAS2764_NOISE_GATE_DISABLE	BIT(0)
+
+static const struct reg_sequence tas2764_noise_gate_dis_seq[] = {
+	REG_SEQ0(TAS2764_REG(0x0, 0x35), 0xb0)
+};
+
+/*
+ * CONV_VBAT_PVDD_MODE=1
+ */
+#define TAS2764_CONV_VBAT_PVDD_MODE	BIT(1)
+
+static const struct reg_sequence tas2764_conv_vbat_pvdd_mode_seq[] = {
+	REG_SEQ0(TAS2764_REG(0x0, 0x6b), 0x41)
+};
+
+/*
+ * Reset of DAC modulator when DSP is OFF
+ */
+#define TAS2764_DMOD_RST		BIT(2)
+
+static const struct reg_sequence tas2764_dmod_rst_seq[] = {
+	REG_SEQ0(TAS2764_REG(0x0, 0x76), 0x0)
+};
+
+/*
+ * Unknown 0x133/0x137 writes (maybe TDM related)
+ */
+#define TAS2764_UNK_SEQ0		BIT(3)
+
+static const struct reg_sequence tas2764_unk_seq0[] = {
+	REG_SEQ0(TAS2764_REG(0x1, 0x33), 0x80),
+	REG_SEQ0(TAS2764_REG(0x1, 0x37), 0x3a),
+};
+
+/*
+ * Unknown 0x614 - 0x61f writes
+ */
+#define TAS2764_APPLE_UNK_SEQ1		BIT(4)
+
+static const struct reg_sequence tas2764_unk_seq1[] = {
+	REG_SEQ0(TAS2764_REG(0x6, 0x14), 0x0),
+	REG_SEQ0(TAS2764_REG(0x6, 0x15), 0x13),
+	REG_SEQ0(TAS2764_REG(0x6, 0x16), 0x52),
+	REG_SEQ0(TAS2764_REG(0x6, 0x17), 0x0),
+	REG_SEQ0(TAS2764_REG(0x6, 0x18), 0xe4),
+	REG_SEQ0(TAS2764_REG(0x6, 0x19), 0xc),
+	REG_SEQ0(TAS2764_REG(0x6, 0x16), 0xaa),
+	REG_SEQ0(TAS2764_REG(0x6, 0x1b), 0x0),
+	REG_SEQ0(TAS2764_REG(0x6, 0x1c), 0x12),
+	REG_SEQ0(TAS2764_REG(0x6, 0x1d), 0xa0),
+	REG_SEQ0(TAS2764_REG(0x6, 0x1e), 0xd8),
+	REG_SEQ0(TAS2764_REG(0x6, 0x1f), 0x0),
+};
+
+/*
+ * Unknown writes in the 0xfd page (with secondary paging inside)
+ */
+#define TAS2764_APPLE_UNK_SEQ2		BIT(5)
+
+static const struct reg_sequence tas2764_unk_seq2[] = {
+	REG_SEQ0(TAS2764_REG(0xfd, 0x0d), 0xd),
+	REG_SEQ0(TAS2764_REG(0xfd, 0x6c), 0x2),
+	REG_SEQ0(TAS2764_REG(0xfd, 0x6d), 0xf),
+	REG_SEQ0(TAS2764_REG(0xfd, 0x0d), 0x0),
+};
+
+/*
+ * Disable 'Thermal Threshold 1'
+ */
+#define TAS2764_THERMAL_TH1_DISABLE	BIT(6)
+
+static const struct reg_sequence tas2764_thermal_th1_dis_seq[] = {
+	REG_SEQ0(TAS2764_REG(0x1, 0x47), 0x2),
+};
+
+/*
+ * Imitate Apple's shutdown dance
+ */
+#define TAS2764_SHUTDOWN_DANCE		BIT(7)
+
+static const struct reg_sequence tas2764_shutdown_dance_init_seq[] = {
+	/*
+	 * SDZ_MODE=01 (immediate)
+	 *
+	 * We want the shutdown to happen under the influence of
+	 * the magic writes in the 0xfdXX region, so make sure
+	 * the shutdown is immediate and there's no grace period
+	 * followed by the codec part.
+	 */
+	REG_SEQ0(TAS2764_REG(0x0, 0x7), 0x60),
+};
+
+static const struct reg_sequence tas2764_pre_shutdown_seq[] = {
+	REG_SEQ0(TAS2764_REG(0xfd, 0x0d), 0xd), /* switch hidden page */
+	REG_SEQ0(TAS2764_REG(0xfd, 0x64), 0x4), /* do write (unknown semantics) */
+	REG_SEQ0(TAS2764_REG(0xfd, 0x0d), 0x0), /* switch hidden page back */
+};
+
+static const struct reg_sequence tas2764_post_shutdown_seq[] = {
+	REG_SEQ0(TAS2764_REG(0xfd, 0x0d), 0xd),
+	REG_SEQ0(TAS2764_REG(0xfd, 0x64), 0x0), /* revert write from pre sequence */
+	REG_SEQ0(TAS2764_REG(0xfd, 0x0d), 0x0),
+};
+
+static int tas2764_do_quirky_pwr_ctrl_change(struct tas2764_priv *tas2764,
+					     unsigned int target)
+{
+	unsigned int curr;
+	int ret;
+
+	curr = snd_soc_component_read_field(tas2764->component,
+					       TAS2764_PWR_CTRL,
+					       TAS2764_PWR_CTRL_MASK);
+
+	if (target == curr)
+		return 0;
+
+	/* Handle power state transition to shutdown */
+	if (target == TAS2764_PWR_CTRL_SHUTDOWN &&
+	   (curr == TAS2764_PWR_CTRL_MUTE || curr == TAS2764_PWR_CTRL_ACTIVE)) {
+		ret = regmap_multi_reg_write(tas2764->regmap, tas2764_pre_shutdown_seq,
+					ARRAY_SIZE(tas2764_pre_shutdown_seq));
+		if (!ret)
+			ret = snd_soc_component_update_bits(tas2764->component,
+							TAS2764_PWR_CTRL,
+							TAS2764_PWR_CTRL_MASK,
+							TAS2764_PWR_CTRL_SHUTDOWN);
+		if (!ret)
+			ret = regmap_multi_reg_write(tas2764->regmap,
+						tas2764_post_shutdown_seq,
+						ARRAY_SIZE(tas2764_post_shutdown_seq));
+	}
+
+	ret = snd_soc_component_update_bits(tas2764->component, TAS2764_PWR_CTRL,
+						    TAS2764_PWR_CTRL_MASK, target);
+
+	return ret;
+}
+
+/*
+ * Via devicetree (TODO):
+ *  - switch from spread spectrum to class-D switching
+ *  - disable edge control
+ *  - set BOP settings (the BOP config bits *and* BOP_SRC)
+ */
+
+/*
+ * Other setup TODOs:
+ *  - DVC ramp rate
+ */
+
+static const struct tas2764_quirk_init_sequence {
+	const struct reg_sequence *seq;
+	int len;
+} tas2764_quirk_init_sequences[] = {
+	{ tas2764_noise_gate_dis_seq, ARRAY_SIZE(tas2764_noise_gate_dis_seq) },
+	{ tas2764_dmod_rst_seq, ARRAY_SIZE(tas2764_dmod_rst_seq) },
+	{ tas2764_conv_vbat_pvdd_mode_seq, ARRAY_SIZE(tas2764_conv_vbat_pvdd_mode_seq) },
+	{ tas2764_unk_seq0, ARRAY_SIZE(tas2764_unk_seq0) },
+	{ tas2764_unk_seq1, ARRAY_SIZE(tas2764_unk_seq1) },
+	{ tas2764_unk_seq2, ARRAY_SIZE(tas2764_unk_seq2) },
+	{ tas2764_thermal_th1_dis_seq, ARRAY_SIZE(tas2764_thermal_th1_dis_seq) },
+	{ tas2764_shutdown_dance_init_seq, ARRAY_SIZE(tas2764_shutdown_dance_init_seq) },
+};
+
+#endif /* __TAS2764_QUIRKS__ */
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index a2b7d0352d4f636c2bf7185715c0f1143ba8150e..898a53f7e033c73b949cc2f6be188f4e32b4f19e 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -46,6 +46,8 @@ struct tas2764_priv {
 	bool unmuted;
 };
 
+#include "tas2764-quirks.h"
+
 static const char *tas2764_int_ltch0_msgs[8] = {
 	"fault: over temperature", /* INT_LTCH0 & BIT(0) */
 	"fault: over current",
@@ -123,6 +125,9 @@ static int tas2764_update_pwr_ctrl(struct tas2764_priv *tas2764)
 	else
 		val = TAS2764_PWR_CTRL_SHUTDOWN;
 
+	if (ENABLED_APPLE_QUIRKS & TAS2764_SHUTDOWN_DANCE)
+		return tas2764_do_quirky_pwr_ctrl_change(tas2764, val);
+
 	ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
 					    TAS2764_PWR_CTRL_MASK, val);
 	if (ret < 0)
@@ -542,6 +547,30 @@ static uint8_t sn012776_bop_presets[] = {
 
 static const struct regmap_config tas2764_i2c_regmap;
 
+static int tas2764_apply_init_quirks(struct tas2764_priv *tas2764)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(tas2764_quirk_init_sequences); i++) {
+		const struct tas2764_quirk_init_sequence *init_seq =
+						&tas2764_quirk_init_sequences[i];
+
+		if (!init_seq->seq)
+			continue;
+
+		if (!(BIT(i) & ENABLED_APPLE_QUIRKS))
+			continue;
+
+		ret = regmap_multi_reg_write(tas2764->regmap, init_seq->seq,
+					     init_seq->len);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
@@ -627,6 +656,12 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 			if (ret < 0)
 				return ret;
 		}
+
+		/* Apply all enabled Apple quirks */
+		ret = tas2764_apply_init_quirks(tas2764);
+
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
@@ -706,6 +741,9 @@ static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;
+	case TAS2764_REG(0xf0, 0x0) ... TAS2764_REG(0xff, 0x0):
+		/* TI's undocumented registers for the application of quirks */
+		return true;
 	default:
 		return false;
 	}

-- 
2.48.1


