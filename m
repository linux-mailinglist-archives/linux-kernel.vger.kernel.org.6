Return-Path: <linux-kernel+bounces-515818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B401BA3695E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2A63B1326
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4C2F4A;
	Sat, 15 Feb 2025 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhV1OXYL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB02EB02;
	Sat, 15 Feb 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577860; cv=none; b=cJ5WwzI6+sXNCttWAzy/jNLONZ2GlvRPYCMpkYu9CraKJUbyH/LLTTIXv4cqtvoP2I06bli70vT9I+B0PhhmC/nW3pmykLA9o1kIVuw2bCre5+23fbqypf9QZd3wo1cogTn9n0KngTVtYJKa5DKN08ekvknepj0yUrGAPbbCDPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577860; c=relaxed/simple;
	bh=LmTUnuF1BVyvYSlC7WbCUOq251HymFCUszPflNwhIvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzG5p+MnwMOv2t+Yx/uJcW4vP3eZmW7oSFcv8byAOCQe2z4cV9iPP8AxtNSnI5fJHOiCub8SOWPzHR8K2vyCh5DctcZi74fsQhCbqAHvBIEL6PZxRONxOgIMx+7mVXC2E/2zxbVpFCBK8dlOKXi4lNS/c9oa74ntdLE7xUmOWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhV1OXYL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220ca204d04so35674575ad.0;
        Fri, 14 Feb 2025 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577856; x=1740182656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLd4owwHtmjtkchcUHupv5g7LO644YkhE0gZDfJP39Y=;
        b=DhV1OXYLe8AeMnGXlvnBHjAUmLgSPHrRlw6bCxNGM48MtRsN6VbGzots/949GT6pRJ
         xH++JRH06JdEak5hJrAw2zcvgfXHtvmBWUrRoehvZ28SXGZmNY2Zy0OPhYTl6veP09CK
         xdNwjH+OzYEYQrs6640P+y/OiFh9ic14vr0n7WfU56mKmrZwWjJfoOhFFDuDHppMT8ev
         5efioSNyMaq2WXzZffJarbDpYBMm6H1CUeksn8aepOjsLCZmjoOQNwdgq96OP8k/7MTx
         4HbS2nhBrXRsmhjHQky0vK79AcHxz3tfkIApwiU2waRrx/zgDmXq2/o2vsB5jtBzBD3o
         +uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577856; x=1740182656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLd4owwHtmjtkchcUHupv5g7LO644YkhE0gZDfJP39Y=;
        b=k5bhLlm+8N023M1towoDpy3zHyMdbVXjPkB00QZhBfbWpjBPH4AFpibStki8cds36u
         jc+ASWWS3BDAMasHEP4TQBDZzaCxgQq2paRnqMOP+o0mivOdxr7BOLCkK2xFRQL+jS7K
         2qqXYxnXgOOS+qnE1Dypj1K7r8693FHJj/DtHg52mPOvZ2j/ppuNqJf2UkQVcTykB9yw
         ngqaNBSgb8p36IGjSc8qAzEulxtK7Xg75b9Rd6HJTmBXxEgjC747Ci204zdZQbhOoSnY
         DzgQBMOiY/yb/kXHrJSwZaZEdq86MkgbduhxBPmNWQhOgsPVSHCa4Rehuz42RcFD804B
         kTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5O9MPGP845wrPZYFFZjpYl9FnnfMujBePIqbuJ/L9Rl+rlHC16LgE2B+J0KjlLsESJz6sBCJkafMq@vger.kernel.org, AJvYcCUYg33Rqv2omDSUAJYaJ3vesd2lxD9B/YhYKysZvOdksRBUikIDV755OJX3dCqjonGVr89wmpGZY0alHvM=@vger.kernel.org, AJvYcCX3tKVQ64admYN9i7dd9u8FpdPJYwTqvrd9zAfBWcz4V5futZguid7QJueT1MRS80HFTaKj/4n74XneyScY@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDl+epEY8nGFKdd6e9rzi43QBG5ke2aamIhCLYoWlYMN5go60
	n3penr1SRrr4Pb+k6IQXeDpbf6cxJR4eQmSXk7xC5E2jin/ZM2Um
X-Gm-Gg: ASbGnctrYdOo4PDoZB9GLHQRQAD/2kNGdjNidcnPUYAN54PlkoRk9gG1h6lnromBGjO
	VK7vdS5u8aJ3ToYKOls6VxUU3CsVI08usuSKxMB8oYLgAnvJn2SUWhfs/BgGl7Pn8KROrKH7EAi
	zpQyAZuOgqdRvndx17y37yERo9OWEPMckCs0Ki3VOyMKqrtW7Ug9jL4bVi7OqS396lZ7E71Givc
	OMtCopVEqdH50aygA3iF5IZyGW+mUWgEqDqCHhEmxmFTmdKjAN3z/F/s6CCCnlb50//xskcQsl5
	2znZ6QZwPNY2w7uOExSEOxNJO7MpdZVAC/2SOwYtHh935H4z3FQkAmfDz/GJLQx9Ua4EjyteqpE
	rCFg38lRZtw==
X-Google-Smtp-Source: AGHT+IED/onOHft2rPHj7P/YvFsG8POQPnZu5xLN77kWhDsTJIu+v6bIMkaKWALZpKtFgQACyFVUfw==
X-Received: by 2002:a17:902:ef49:b0:220:c813:dfda with SMTP id d9443c01a7336-2210408f2cbmr20099825ad.41.1739577855604;
        Fri, 14 Feb 2025 16:04:15 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:15 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:42 +1000
Subject: [PATCH 09/27] ASoC: tas2764: Apply Apple quirks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-9-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9131;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=nm0Fos7Ax5eQhqWRF4wek/2VBG2oWla/EzD0tetdZ6k=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24N32LSrbHhcN0Wj6gbmxRLTI6kPjifyXmurWtLy
 i3tdMkNHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEyksJvhr7B/qdWEae9lXZJt
 3r37ubM4dPKz710H1366lOfH4np2RTHDP22l4MMLw/uPZKf4hGR2ZS2uVFLWL9YyavuV91ZB6VM
 pBwA=
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

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Co-developed-by: James Calligeros <jcalligeros99@gmail.com>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764-quirks.h | 188 +++++++++++++++++++++++++
 sound/soc/codecs/tas2764.c        |  38 +++++
 2 files changed, 226 insertions(+)

diff --git a/sound/soc/codecs/tas2764-quirks.h b/sound/soc/codecs/tas2764-quirks.h
new file mode 100644
index 0000000000000000000000000000000000000000..67cdae90b766a9180dac375478060223f6c4e6b4
--- /dev/null
+++ b/sound/soc/codecs/tas2764-quirks.h
@@ -0,0 +1,188 @@
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
+#define TRANSITION(new, old) ((new) << 8 | (old))
+	switch (TRANSITION(target, curr)) {
+	case TRANSITION(TAS2764_PWR_CTRL_SHUTDOWN, TAS2764_PWR_CTRL_MUTE):
+	case TRANSITION(TAS2764_PWR_CTRL_SHUTDOWN, TAS2764_PWR_CTRL_ACTIVE):
+		ret = regmap_multi_reg_write(tas2764->regmap, tas2764_pre_shutdown_seq,
+					     ARRAY_SIZE(tas2764_pre_shutdown_seq));
+		if (ret < 0)
+			break;
+
+		ret = snd_soc_component_update_bits(tas2764->component,
+						    TAS2764_PWR_CTRL,
+						    TAS2764_PWR_CTRL_MASK,
+						    TAS2764_PWR_CTRL_SHUTDOWN);
+		if (ret > 0)
+			break;
+
+		ret = regmap_multi_reg_write(tas2764->regmap, tas2764_post_shutdown_seq,
+					     ARRAY_SIZE(tas2764_post_shutdown_seq));
+		fallthrough;
+	default:
+		ret = snd_soc_component_update_bits(tas2764->component, TAS2764_PWR_CTRL,
+						    TAS2764_PWR_CTRL_MASK, target);
+	}
+#undef TRANSITION
+
+	if (ret < 0)
+		return ret;
+	return 0;
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
index 811f4f54cc26bee05d717552c360fa50e7d6c7fe..4923291e7a62bd33f0f8a934599c527033feb971 100644
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


