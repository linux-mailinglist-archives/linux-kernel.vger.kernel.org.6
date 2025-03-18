Return-Path: <linux-kernel+bounces-566623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82724A67A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120893A8B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F286214221;
	Tue, 18 Mar 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AFWxeh8n"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12265212B2E;
	Tue, 18 Mar 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318114; cv=none; b=FxPSPFhI7dXEPcbCxH08Vd1eH/iE4kIFMM39POiekhKXSDCU6AwtZDVAHlHONMSbk9eSI0wkto2nW70anMxjp3NHUQcs9i7i2/dJQEnXds+wLgyVM8XEO67QDoDvBLejGfMsVqDwC+uqGJg6kdMAay3sx4oxJmUSp9MCyOVFMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318114; c=relaxed/simple;
	bh=vLTG2QvX3NsvJEj2wCKBxk1IBzdUqvytIT7U7YDwiqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs5hI2ts00AtL23pwrc5UxaGizoeADwQ7mM4zSAv+M8yywnkUrPYOXpHdl6w6ZshCULOXg67FSE8Bs8ykpbXGZWPeNYweZTOOF66FEPKSp98rh/bioJV5IDBG2/9TEHWk/B2WN4ncH5kyHhYomevTN0d8EyebXdjxe6/ueSjNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AFWxeh8n; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1uEKF028771;
	Tue, 18 Mar 2025 12:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=M97kqTEQREFXM6bMMLbcLteFBzjCQ8yV+J9ftT6QK2A=; b=
	AFWxeh8nAK4cYVuplQ6HxHJaWQMOV9LiO5VKr3yN1d2TPOBAr3H2fVxP48UWw28y
	ekksOpcSgZOX6rFCQgrqWu6V6r52Gg8iFLyAdiX+UWdb5NmqQ4LPXGVsh3WSg4eA
	pXx/xbI+XKWGjuBXdkou3bOdiuvZqm1cKKP0TT/mjtPq3DTgzg7nDhtMeqO1EAAP
	5qGkZ+AMTTMSUREG3iakDUAwVDlsaEFLHS5IoNhQrlt9GBjyV0UCYN48UUA7X89/
	sUU5GjqcwEHMEHNhPBf0CgAtIvVHsVUccdyLd+w+HNU3k1gYn96mVBsTbkVAvLzp
	e9rfAxPd8Go0F3AtZAQf0w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:01 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7D01582255C;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 01/15] ASoC: ops-test: Add some basic kunit tests for soc-ops
Date: Tue, 18 Mar 2025 17:14:45 +0000
Message-ID: <20250318171459.3203730-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa15 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=kVcb_dQ4S0lf-uqeuHUA:9
X-Proofpoint-GUID: sjfrOqWIJTa_Bu_0a2DRvrzRr1v5tMHR
X-Proofpoint-ORIG-GUID: sjfrOqWIJTa_Bu_0a2DRvrzRr1v5tMHR
X-Proofpoint-Spam-Reason: safe

Add some basic kunit tests for some of the ASoC control put and get
helpers. This will assist in doing some refactoring. Note that presently
some tests fail, but the rest of the series will fix these up.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/Kconfig        |   7 +
 sound/soc/Makefile       |   4 +
 sound/soc/soc-ops-test.c | 541 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 552 insertions(+)
 create mode 100644 sound/soc/soc-ops-test.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 5efba76abb31a..8b7d51266f814 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -81,6 +81,13 @@ config SND_SOC_UTILS_KUNIT_TEST
 	help
 	  If you want to perform tests on ALSA SoC utils library say Y here.
 
+config SND_SOC_OPS_KUNIT_TEST
+	tristate "KUnit tests for SoC ops"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  If you want to perform tests on ALSA SoC ops library say Y here.
+
 config SND_SOC_ACPI
 	tristate
 
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 08baaa11d8139..358e227c5ab61 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -21,6 +21,10 @@ ifneq ($(CONFIG_SND_SOC_UTILS_KUNIT_TEST),)
 obj-$(CONFIG_SND_SOC_UTILS_KUNIT_TEST) += soc-utils-test.o
 endif
 
+ifneq ($(CONFIG_SND_SOC_OPS_KUNIT_TEST),)
+obj-$(CONFIG_SND_SOC_OPS_KUNIT_TEST) += soc-ops-test.o
+endif
+
 ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
 snd-soc-core-y += soc-generic-dmaengine-pcm.o
 endif
diff --git a/sound/soc/soc-ops-test.c b/sound/soc/soc-ops-test.c
new file mode 100644
index 0000000000000..dc1e482bba6a9
--- /dev/null
+++ b/sound/soc/soc-ops-test.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <sound/asound.h>
+#include <sound/control.h>
+#include <sound/soc.h>
+#include <sound/soc-component.h>
+
+enum soc_ops_test_control_layout {
+	SOC_OPS_TEST_SINGLE,
+	SOC_OPS_TEST_DOUBLE,
+	SOC_OPS_TEST_DOUBLE_R,
+};
+
+#define TEST_MC(clayout, xmin, xmax, xpmax, xsign, xinvert) \
+	.mc = { \
+		.min = xmin, .max = xmax, .platform_max = xpmax, \
+		.reg = 0, .shift = 0, .sign_bit = xsign, .invert = xinvert, \
+		.rreg = SOC_OPS_TEST_##clayout == SOC_OPS_TEST_DOUBLE_R ? 1 : 0, \
+		.rshift = SOC_OPS_TEST_##clayout == SOC_OPS_TEST_DOUBLE ? 16 : 0, \
+	}
+
+#define TEST_UINFO(clayout, ctype, cmin, cmax) \
+	.uinfo = { \
+		.type = SNDRV_CTL_ELEM_TYPE_##ctype, \
+		.count = SOC_OPS_TEST_##clayout == SOC_OPS_TEST_SINGLE ? 1 : 2, \
+		.value.integer.min = cmin, \
+		.value.integer.max = cmax, \
+	}
+
+#define ITEST(cname, clayout, ctype, cfunc, cmin, cmax, \
+	      xmin, xmax, xpmax, xsign, xinvert) \
+	{ \
+		.name = cname, \
+		.func_name = #cfunc, \
+		.layout = SOC_OPS_TEST_##clayout, \
+		.info = snd_soc_info_##cfunc, \
+		TEST_MC(clayout, xmin, xmax, xpmax, xsign, xinvert), \
+		TEST_UINFO(clayout, ctype, cmin, cmax), \
+	}
+
+#define ATEST(clayout, cfunc, cctl, cret, cinit, \
+	      xmask, xreg, xmin, xmax, xpmax, xsign, xinvert) \
+	{ \
+		.func_name = #cfunc, \
+		.layout = SOC_OPS_TEST_##clayout, \
+		.put = snd_soc_put_##cfunc, \
+		.get = snd_soc_get_##cfunc, \
+		TEST_MC(clayout, xmin, xmax, xpmax, xsign, xinvert), \
+		.lctl = cctl, .rctl = cctl, \
+		.lmask = SOC_OPS_TEST_##clayout == SOC_OPS_TEST_DOUBLE ? \
+				(xmask) | (xmask) << 16 : (xmask), \
+		.rmask = SOC_OPS_TEST_##clayout == SOC_OPS_TEST_DOUBLE_R ? (xmask) : 0, \
+		.init = cinit ? 0xFFFFFFFF : 0x00000000, \
+		.lreg = SOC_OPS_TEST_##clayout == SOC_OPS_TEST_DOUBLE ? \
+				(xreg) | (xreg) << 16 : (xreg), \
+		.rreg = SOC_OPS_TEST_##clayout == SOC_OPS_TEST_DOUBLE_R ? (xreg) : 0, \
+		.ret = cret, \
+	}
+
+struct soc_ops_test_priv {
+	struct kunit *test;
+
+	struct snd_soc_component component;
+};
+
+struct info_test_param {
+	const char * const name;
+	const char * const func_name;
+	enum soc_ops_test_control_layout layout;
+	struct soc_mixer_control mc;
+	int (*info)(struct snd_kcontrol *kctl, struct snd_ctl_elem_info *info);
+
+	struct snd_ctl_elem_info uinfo;
+};
+
+struct access_test_param {
+	const char * const func_name;
+	enum soc_ops_test_control_layout layout;
+	struct soc_mixer_control mc;
+	int (*put)(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *value);
+	int (*get)(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *value);
+
+	unsigned int init;
+	unsigned int lmask;
+	unsigned int rmask;
+	unsigned int lreg;
+	unsigned int rreg;
+	long lctl;
+	long rctl;
+	int ret;
+};
+
+static const struct info_test_param all_info_test_params[] = {
+	// Handling of volume control name for types
+	ITEST("Test Control",        SINGLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Volume",         SINGLE,   INTEGER, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Volume Control", SINGLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Control",        DOUBLE_R, BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Volume",         DOUBLE_R, INTEGER, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Volume Control", DOUBLE_R, BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Control",        DOUBLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Volume",         DOUBLE,   INTEGER, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Volume Control", DOUBLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 0),
+	ITEST("Test Control",        SINGLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 1),
+	ITEST("Test Volume",         SINGLE,   INTEGER, volsw,    0,  1,   0,  1,  0, 0, 1),
+	ITEST("Test Volume Control", SINGLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 1),
+	ITEST("Test Control",        DOUBLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 1),
+	ITEST("Test Volume",         DOUBLE,   INTEGER, volsw,    0,  1,   0,  1,  0, 0, 1),
+	ITEST("Test Volume Control", DOUBLE,   BOOLEAN, volsw,    0,  1,   0,  1,  0, 0, 1),
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw,    0,  2,   0,  2,  0, 0, 0),
+	ITEST("Test Volume",         SINGLE,   INTEGER, volsw,    0,  2,   0,  2,  0, 0, 0),
+	ITEST("Test Volume Control", SINGLE,   INTEGER, volsw,    0,  2,   0,  2,  0, 0, 0),
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw,    0,  1,   0,  2,  1, 0, 0),
+	ITEST("Test Volume",         SINGLE,   INTEGER, volsw,    0,  1,   0,  2,  1, 0, 0),
+	ITEST("Test Volume Control", SINGLE,   INTEGER, volsw,    0,  1,   0,  2,  1, 0, 0),
+	// Negative minimums
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw,    0, 20, -10, 10,  0, 4, 0),
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw,    0, 15, -10, 10, 15, 4, 0),
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw,    0, 20, -10, 10,  0, 4, 1),
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw,    0, 15, -10, 10, 15, 4, 1),
+	// SX control volume control naming
+	ITEST("Test Control",        SINGLE,   BOOLEAN, volsw_sx, 0,  1, 0xF,  1,  0, 0, 0),
+	ITEST("Test Volume",         SINGLE,   INTEGER, volsw_sx, 0,  1, 0xF,  1,  0, 0, 0),
+	ITEST("Test Volume Control", SINGLE,   BOOLEAN, volsw_sx, 0,  1, 0xF,  1,  0, 0, 0),
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw_sx, 0,  4, 0xE,  4,  0, 0, 0),
+	ITEST("Test Volume",         SINGLE,   INTEGER, volsw_sx, 0,  4, 0xE,  4,  0, 0, 0),
+	ITEST("Test Volume Control", SINGLE,   INTEGER, volsw_sx, 0,  4, 0xE,  4,  0, 0, 0),
+	ITEST("Test Control",        SINGLE,   INTEGER, volsw_sx, 0,  3, 0xE,  4,  3, 0, 0),
+	ITEST("Test Volume",         SINGLE,   INTEGER, volsw_sx, 0,  3, 0xE,  4,  3, 0, 0),
+	ITEST("Test Volume Control", SINGLE,   INTEGER, volsw_sx, 0,  3, 0xE,  4,  3, 0, 0),
+};
+
+static const struct access_test_param all_access_test_params[] = {
+	// Single positive value controls
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x0A,    0,  20,  0, 0, 0),
+	ATEST(SINGLE,   volsw,      0,   0, false, 0x1F, 0x00,    0,  20,  0, 0, 0),
+	ATEST(SINGLE,   volsw,     20,   1, false, 0x1F, 0x14,    0,  20,  0, 0, 0),
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x0A,    0,  20, 15, 0, 0),
+	ATEST(SINGLE,   volsw,     25, -22, false, 0x1F, 0x00,    0,  20, 15, 0, 0),
+	ATEST(SINGLE,   volsw,     15,   1, false, 0x1F, 0x0F,    0,  20, 15, 0, 0),
+	// Inverted single positive value controls
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x0A,    0,  20,  0, 0, 1),
+	ATEST(SINGLE,   volsw,      0,   1, false, 0x1F, 0x14,    0,  20,  0, 0, 1),
+	ATEST(SINGLE,   volsw,     20,   0, false, 0x1F, 0x00,    0,  20,  0, 0, 1),
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x0A,    0,  20, 15, 0, 1),
+	ATEST(SINGLE,   volsw,     25, -22, false, 0x1F, 0x00,    0,  20, 15, 0, 1),
+	ATEST(SINGLE,   volsw,     15,   1, false, 0x1F, 0x05,    0,  20, 15, 0, 1),
+	ATEST(SINGLE,   volsw,     10,   1, true,  0x1F, 0x0A,    0,  20,  0, 0, 0),
+	ATEST(SINGLE,   volsw,      0,   1, true,  0x1F, 0x00,    0,  20,  0, 0, 0),
+	ATEST(SINGLE,   volsw,     20,   1, true,  0x1F, 0x14,    0,  20,  0, 0, 0),
+	ATEST(SINGLE,   volsw,     10,   1, true,  0x1F, 0x0A,    0,  20, 15, 0, 0),
+	ATEST(SINGLE,   volsw,     25, -22, true,  0x1F, 0x00,    0,  20, 15, 0, 0),
+	ATEST(SINGLE,   volsw,     15,   1, true,  0x1F, 0x0F,    0,  20, 15, 0, 0),
+	// Single negative value controls
+	ATEST(SINGLE,   volsw,     10,   0, false, 0x1F, 0x00,  -10,  10,  0, 4, 0),
+	ATEST(SINGLE,   volsw,      0,   1, false, 0x1F, 0x16,  -10,  10,  0, 4, 0),
+	ATEST(SINGLE,   volsw,     20,   1, false, 0x1F, 0x0A,  -10,  10,  0, 4, 0),
+	ATEST(SINGLE,   volsw,     10,   0, false, 0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(SINGLE,   volsw,     25, -22, false, 0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(SINGLE,   volsw,     15,   1, false, 0x1F, 0x05,  -10,  10, 15, 4, 0),
+	// Single non-zero minimum positive value controls
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x14,   10,  30,  0, 0, 0),
+	ATEST(SINGLE,   volsw,      0,   1, false, 0x1F, 0x0A,   10,  30,  0, 0, 0),
+	ATEST(SINGLE,   volsw,     20,   1, false, 0x1F, 0x1E,   10,  30,  0, 0, 0),
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x14,   10,  30, 15, 0, 0),
+	ATEST(SINGLE,   volsw,     25, -22, false, 0x1F, 0x00,   10,  30, 15, 0, 0),
+	ATEST(SINGLE,   volsw,     15,   1, false, 0x1F, 0x19,   10,  30, 15, 0, 0),
+	// Inverted single non-zero minimum positive value controls
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x14,   10,  30,  0, 0, 1),
+	ATEST(SINGLE,   volsw,      0,   1, false, 0x1F, 0x1E,   10,  30,  0, 0, 1),
+	ATEST(SINGLE,   volsw,     20,   1, false, 0x1F, 0x0A,   10,  30,  0, 0, 1),
+	ATEST(SINGLE,   volsw,     10,   1, false, 0x1F, 0x14,   10,  30, 15, 0, 1),
+	ATEST(SINGLE,   volsw,     25, -22, false, 0x1F, 0x00,   10,  30, 15, 0, 1),
+	ATEST(SINGLE,   volsw,     15,   1, false, 0x1F, 0x0F,   10,  30, 15, 0, 1),
+	// Double register positive value controls
+	ATEST(DOUBLE_R, volsw,     10,   1, false, 0x1F, 0x0A,    0,  20,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw,      0,   0, false, 0x1F, 0x00,    0,  20,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw,     20,   1, false, 0x1F, 0x14,    0,  20,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw,     10,   1, false, 0x1F, 0x0A,    0,  20, 15, 0, 0),
+	ATEST(DOUBLE_R, volsw,     25, -22, false, 0x1F, 0x00,    0,  20, 15, 0, 0),
+	ATEST(DOUBLE_R, volsw,     15,   1, false, 0x1F, 0x0F,    0,  20, 15, 0, 0),
+	// Double register negative value controls
+	ATEST(DOUBLE_R, volsw,     10,   0, false, 0x1F, 0x00,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE_R, volsw,      0,   1, false, 0x1F, 0x16,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE_R, volsw,     20,   1, false, 0x1F, 0x0A,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE_R, volsw,     10,   0, false, 0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(DOUBLE_R, volsw,     25, -22, false, 0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(DOUBLE_R, volsw,     15,   1, false, 0x1F, 0x05,  -10,  10, 15, 4, 0),
+	ATEST(DOUBLE_R, volsw,     10,   1, true,  0x1F, 0x00,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE_R, volsw,      0,   1, true,  0x1F, 0x16,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE_R, volsw,     20,   1, true,  0x1F, 0x0A,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE_R, volsw,     10,   1, true,  0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(DOUBLE_R, volsw,     25, -22, true,  0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(DOUBLE_R, volsw,     15,   1, true,  0x1F, 0x05,  -10,  10, 15, 4, 0),
+	// Inverted double register negative value controls
+	ATEST(DOUBLE_R, volsw,     10,   1, true,  0x1F, 0x00,  -10,  10,  0, 4, 1),
+	ATEST(DOUBLE_R, volsw,      0,   1, true,  0x1F, 0x0A,  -10,  10,  0, 4, 1),
+	ATEST(DOUBLE_R, volsw,     20,   1, true,  0x1F, 0x16,  -10,  10,  0, 4, 1),
+	ATEST(DOUBLE_R, volsw,     10,   1, true,  0x1F, 0x00,  -10,  10, 15, 4, 1),
+	ATEST(DOUBLE_R, volsw,     25, -22, true,  0x1F, 0x00,  -10,  10, 15, 4, 1),
+	ATEST(DOUBLE_R, volsw,     15,   1, true,  0x1F, 0x1B,  -10,  10, 15, 4, 1),
+	// Double register non-zero minimum positive value controls
+	ATEST(DOUBLE_R, volsw,     10,   1, false, 0x1F, 0x14,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw,      0,   1, false, 0x1F, 0x0A,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw,     20,   1, false, 0x1F, 0x1E,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw,     10,   1, false, 0x1F, 0x14,   10,  30, 15, 0, 0),
+	ATEST(DOUBLE_R, volsw,     25, -22, false, 0x1F, 0x00,   10,  30, 15, 0, 0),
+	ATEST(DOUBLE_R, volsw,     15,   1, false, 0x1F, 0x19,   10,  30, 15, 0, 0),
+	// Double shift positive value controls
+	ATEST(DOUBLE,   volsw,     10,   1, false, 0x1F, 0x0A,    0,  20,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,      0,   0, false, 0x1F, 0x00,    0,  20,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,     20,   1, false, 0x1F, 0x14,    0,  20,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,     10,   1, false, 0x1F, 0x0A,    0,  20, 15, 0, 0),
+	ATEST(DOUBLE,   volsw,     25, -22, false, 0x1F, 0x00,    0,  20, 15, 0, 0),
+	ATEST(DOUBLE,   volsw,     15,   1, false, 0x1F, 0x0F,    0,  20, 15, 0, 0),
+	// Double shift negative value controls
+	ATEST(DOUBLE,   volsw,     10,   0, false, 0x1F, 0x00,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE,   volsw,      0,   1, false, 0x1F, 0x16,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE,   volsw,     20,   1, false, 0x1F, 0x0A,  -10,  10,  0, 4, 0),
+	ATEST(DOUBLE,   volsw,     10,   0, false, 0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(DOUBLE,   volsw,     25, -22, false, 0x1F, 0x00,  -10,  10, 15, 4, 0),
+	ATEST(DOUBLE,   volsw,     15,   1, false, 0x1F, 0x05,  -10,  10, 15, 4, 0),
+	// Inverted double shift negative value controls
+	ATEST(DOUBLE,   volsw,     10,   0, false, 0x1F, 0x00,  -10,  10,  0, 4, 1),
+	ATEST(DOUBLE,   volsw,      0,   1, false, 0x1F, 0x0A,  -10,  10,  0, 4, 1),
+	ATEST(DOUBLE,   volsw,     20,   1, false, 0x1F, 0x16,  -10,  10,  0, 4, 1),
+	ATEST(DOUBLE,   volsw,     10,   0, false, 0x1F, 0x00,  -10,  10, 15, 4, 1),
+	ATEST(DOUBLE,   volsw,     25, -22, false, 0x1F, 0x00,  -10,  10, 15, 4, 1),
+	ATEST(DOUBLE,   volsw,     15,   1, false, 0x1F, 0x1B,  -10,  10, 15, 4, 1),
+	// Double shift non-zero minimum positive value controls
+	ATEST(DOUBLE,   volsw,     10,   1, false, 0x1F, 0x14,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,      0,   1, false, 0x1F, 0x0A,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,     20,   1, false, 0x1F, 0x1E,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,     10,   1, false, 0x1F, 0x14,   10,  30, 15, 0, 0),
+	ATEST(DOUBLE,   volsw,     25, -22, false, 0x1F, 0x00,   10,  30, 15, 0, 0),
+	ATEST(DOUBLE,   volsw,     15,   1, false, 0x1F, 0x19,   10,  30, 15, 0, 0),
+	ATEST(DOUBLE,   volsw,     10,   1, true,  0x1F, 0x14,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,      0,   1, true,  0x1F, 0x0A,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,     20,   1, true,  0x1F, 0x1E,   10,  30,  0, 0, 0),
+	ATEST(DOUBLE,   volsw,     10,   1, true,  0x1F, 0x14,   10,  30, 15, 0, 0),
+	ATEST(DOUBLE,   volsw,     25, -22, true,  0x1F, 0x00,   10,  30, 15, 0, 0),
+	ATEST(DOUBLE,   volsw,     15,   1, true,  0x1F, 0x19,   10,  30, 15, 0, 0),
+	// Single SX all values
+	ATEST(SINGLE,   volsw_sx,   0,   1, false,  0xF, 0x0F, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   1,   0, false,  0xF, 0x00, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   2,   1, false,  0xF, 0x01, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   3,   1, false,  0xF, 0x02, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   4,   1, false,  0xF, 0x03, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   5, -22, false,  0xF, 0x00, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   0,   0, true,   0xF, 0x0F, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   1,   1, true,   0xF, 0x00, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   2,   1, true,   0xF, 0x01, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   3,   1, true,   0xF, 0x02, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   4,   1, true,   0xF, 0x03, 0x0F,   4,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   5, -22, true,   0xF, 0x00, 0x0F,   4,  0, 0, 0),
+	// Inverted single SX all values
+	ATEST(SINGLE,   volsw_sx,   0,   1, false, 0x1F, 0x03, 0x0F,   4,  0, 0, 1),
+	ATEST(SINGLE,   volsw_sx,   1,   1, false, 0x1F, 0x02, 0x0F,   4,  0, 0, 1),
+	ATEST(SINGLE,   volsw_sx,   2,   1, false, 0x1F, 0x01, 0x0F,   4,  0, 0, 1),
+	ATEST(SINGLE,   volsw_sx,   3,   0, false, 0x1F, 0x00, 0x0F,   4,  0, 0, 1),
+	ATEST(SINGLE,   volsw_sx,   4,   1, false, 0x1F, 0x0F, 0x0F,   4,  0, 0, 1),
+	ATEST(SINGLE,   volsw_sx,   5, -22, false, 0x1F, 0x00, 0x0F,   4,  0, 0, 1),
+	// Single SX select values
+	ATEST(SINGLE,   volsw_sx,   0,   1, false, 0xFF, 0x88, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   1,   1, false, 0xFF, 0x89, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 119,   1, false, 0xFF, 0xFF, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 120,   0, false, 0xFF, 0x00, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 121,   1, false, 0xFF, 0x01, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 143,   1, false, 0xFF, 0x17, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 144,   1, false, 0xFF, 0x18, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 145, -22, false, 0xFF, 0x00, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   0,   1, true,  0xFF, 0x88, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx,   1,   1, true,  0xFF, 0x89, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 119,   0, true,  0xFF, 0xFF, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 120,   1, true,  0xFF, 0x00, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 121,   1, true,  0xFF, 0x01, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 143,   1, true,  0xFF, 0x17, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 144,   1, true,  0xFF, 0x18, 0x88, 144,  0, 0, 0),
+	ATEST(SINGLE,   volsw_sx, 145, -22, true,  0xFF, 0x00, 0x88, 144,  0, 0, 0),
+	// Double shift SX select values
+	ATEST(DOUBLE,   volsw_sx,   0,   1, true,  0xFF, 0x88, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE,   volsw_sx,   1,   1, true,  0xFF, 0x89, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE,   volsw_sx, 119,   0, true,  0xFF, 0xFF, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE,   volsw_sx, 120,   1, true,  0xFF, 0x00, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE,   volsw_sx, 121,   1, true,  0xFF, 0x01, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE,   volsw_sx, 143,   1, true,  0xFF, 0x17, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE,   volsw_sx, 144,   1, true,  0xFF, 0x18, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE,   volsw_sx, 145, -22, true,  0xFF, 0x00, 0x88, 144,  0, 0, 0),
+	// Double register SX select values
+	ATEST(DOUBLE_R, volsw_sx,   0,   1, true,  0xFF, 0x88, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw_sx,   1,   1, true,  0xFF, 0x89, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw_sx, 119,   0, true,  0xFF, 0xFF, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw_sx, 120,   1, true,  0xFF, 0x00, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw_sx, 121,   1, true,  0xFF, 0x01, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw_sx, 143,   1, true,  0xFF, 0x17, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw_sx, 144,   1, true,  0xFF, 0x18, 0x88, 144,  0, 0, 0),
+	ATEST(DOUBLE_R, volsw_sx, 145, -22, true,  0xFF, 0x00, 0x88, 144,  0, 0, 0),
+};
+
+static const char *control_type_str(const snd_ctl_elem_type_t type)
+{
+	switch (type) {
+	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
+		return "bool";
+	case SNDRV_CTL_ELEM_TYPE_INTEGER:
+		return "int";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *control_layout_str(const enum soc_ops_test_control_layout layout)
+{
+	switch (layout) {
+	case SOC_OPS_TEST_SINGLE:
+		return "single";
+	case SOC_OPS_TEST_DOUBLE:
+		return "double";
+	case SOC_OPS_TEST_DOUBLE_R:
+		return "double_r";
+	default:
+		return "unknown";
+	}
+};
+
+static int mock_regmap_read(void *context, const void *reg_buf,
+			    const size_t reg_size, void *val_buf,
+			    size_t val_size)
+{
+	struct soc_ops_test_priv *priv = context;
+
+	KUNIT_FAIL(priv->test, "Unexpected bus read");
+
+	return -EIO;
+}
+
+static int mock_regmap_gather_write(void *context,
+				    const void *reg_buf, size_t reg_size,
+				    const void *val_buf, size_t val_size)
+{
+	struct soc_ops_test_priv *priv = context;
+
+	KUNIT_FAIL(priv->test, "Unexpected bus gather_write");
+
+	return -EIO;
+}
+
+static int mock_regmap_write(void *context, const void *val_buf,
+			     size_t val_size)
+{
+	struct soc_ops_test_priv *priv = context;
+
+	KUNIT_FAIL(priv->test, "Unexpected bus write");
+
+	return -EIO;
+}
+
+static const struct regmap_bus mock_regmap_bus = {
+	.read = mock_regmap_read,
+	.write = mock_regmap_write,
+	.gather_write = mock_regmap_gather_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+static const struct regmap_config mock_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.max_register = 0x1,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int soc_ops_test_init(struct kunit *test)
+{
+	struct soc_ops_test_priv *priv;
+	struct regmap *regmap;
+	struct device *dev;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->test = test;
+
+	dev = kunit_device_register(test, "soc_ops_test_drv");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	regmap = devm_regmap_init(dev, &mock_regmap_bus, priv, &mock_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* No actual hardware, we just use the cache */
+	regcache_cache_only(regmap, true);
+
+	priv->component.dev = dev;
+	priv->component.regmap = regmap;
+	mutex_init(&priv->component.io_mutex);
+
+	test->priv = priv;
+
+	return 0;
+}
+
+static void soc_ops_test_exit(struct kunit *test)
+{
+	struct soc_ops_test_priv *priv = test->priv;
+
+	kunit_device_unregister(test, priv->component.dev);
+}
+
+static void info_test_desc(const struct info_test_param *param, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "%s %s %s: ctl range: %ld->%ld, reg range: %d->%d(%d), sign: %d, inv: %d",
+		 control_layout_str(param->layout), param->func_name,
+		 control_type_str(param->uinfo.type),
+		 param->uinfo.value.integer.min, param->uinfo.value.integer.max,
+		 param->mc.min, param->mc.max, param->mc.platform_max,
+		 param->mc.sign_bit, param->mc.invert);
+}
+
+static void soc_ops_test_info(struct kunit *test)
+{
+	struct soc_ops_test_priv *priv = test->priv;
+	const struct info_test_param *param = test->param_value;
+	const struct snd_ctl_elem_info *target = &param->uinfo;
+	struct snd_ctl_elem_info result;
+	struct snd_kcontrol kctl = {
+		.private_data = &priv->component,
+		.private_value = (unsigned long)&param->mc,
+	};
+	int ret;
+
+	strscpy(kctl.id.name, param->name, sizeof(kctl.id.name));
+
+	ret = param->info(&kctl, &result);
+	KUNIT_ASSERT_FALSE(test, ret);
+
+	KUNIT_EXPECT_EQ(test, result.count, target->count);
+	KUNIT_EXPECT_EQ(test, result.type, target->type);
+	KUNIT_EXPECT_EQ(test, result.value.integer.min, target->value.integer.min);
+	KUNIT_EXPECT_EQ(test, result.value.integer.max, target->value.integer.max);
+}
+
+static void access_test_desc(const struct access_test_param *param, char *desc)
+{
+	if (param->ret < 0) {
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+			 "%s %s: %ld,%ld -> range: %d->%d(%d), sign: %d, inv: %d -> err: %d",
+			 control_layout_str(param->layout), param->func_name,
+			 param->lctl, param->rctl,
+			 param->mc.min, param->mc.max, param->mc.platform_max,
+			 param->mc.sign_bit, param->mc.invert,
+			 param->ret);
+	} else {
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+			 "%s %s: %ld,%ld -> range: %d->%d(%d), sign: %d, inv: %d -> %#x,%#x",
+			 control_layout_str(param->layout), param->func_name,
+			 param->lctl, param->rctl,
+			 param->mc.min, param->mc.max, param->mc.platform_max,
+			 param->mc.sign_bit, param->mc.invert,
+			 param->lreg, param->rreg);
+	}
+}
+
+static void soc_ops_test_access(struct kunit *test)
+{
+	struct soc_ops_test_priv *priv = test->priv;
+	const struct access_test_param *param = test->param_value;
+	struct snd_kcontrol kctl = {
+		.private_data = &priv->component,
+		.private_value = (unsigned long)&param->mc,
+	};
+	struct snd_ctl_elem_value result;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_write(priv->component.regmap, 0x0, param->init);
+	KUNIT_ASSERT_FALSE(test, ret);
+	ret = regmap_write(priv->component.regmap, 0x1, param->init);
+	KUNIT_ASSERT_FALSE(test, ret);
+
+	result.value.integer.value[0] = param->lctl;
+	result.value.integer.value[1] = param->rctl;
+
+	ret = param->put(&kctl, &result);
+	KUNIT_ASSERT_EQ(test, ret, param->ret);
+	if (ret < 0)
+		return;
+
+	ret = regmap_read(priv->component.regmap, 0x0, &val);
+	KUNIT_ASSERT_FALSE(test, ret);
+	KUNIT_EXPECT_EQ(test, val, (param->init & ~param->lmask) | param->lreg);
+
+	ret = regmap_read(priv->component.regmap, 0x1, &val);
+	KUNIT_ASSERT_FALSE(test, ret);
+	KUNIT_EXPECT_EQ(test, val, (param->init & ~param->rmask) | param->rreg);
+
+	result.value.integer.value[0] = 0;
+	result.value.integer.value[1] = 0;
+
+	ret = param->get(&kctl, &result);
+	KUNIT_ASSERT_GE(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, result.value.integer.value[0], param->lctl);
+	if (param->layout != SOC_OPS_TEST_SINGLE)
+		KUNIT_EXPECT_EQ(test, result.value.integer.value[1], param->rctl);
+	else
+		KUNIT_EXPECT_EQ(test, result.value.integer.value[1], 0);
+}
+
+KUNIT_ARRAY_PARAM(all_info_tests, all_info_test_params, info_test_desc);
+KUNIT_ARRAY_PARAM(all_access_tests, all_access_test_params, access_test_desc);
+
+static struct kunit_case soc_ops_test_cases[] = {
+	KUNIT_CASE_PARAM(soc_ops_test_info, all_info_tests_gen_params),
+	KUNIT_CASE_PARAM(soc_ops_test_access, all_access_tests_gen_params),
+	{}
+};
+
+static struct kunit_suite soc_ops_test_suite = {
+	.name = "soc-ops",
+	.init = soc_ops_test_init,
+	.exit = soc_ops_test_exit,
+	.test_cases = soc_ops_test_cases,
+};
+
+kunit_test_suites(&soc_ops_test_suite);
+
+MODULE_DESCRIPTION("ASoC soc-ops kunit test");
+MODULE_LICENSE("GPL");
-- 
2.39.5


