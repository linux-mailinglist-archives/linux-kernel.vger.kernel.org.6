Return-Path: <linux-kernel+bounces-246481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7292C27F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B6DB21C83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74693182A5A;
	Tue,  9 Jul 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rmVxMc8n"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1AD17B045;
	Tue,  9 Jul 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546137; cv=none; b=EEZPqqa6/DvbLaGWDHAf046doA2In+qzdWmeAYJ5A0Z7+mdEER6K4NRnGaitLBbfmGbHqeUCfuJW2V/2AraJO5qVcf1K+9xsStaezYUV4EIjQX2p8JTDyrsQF2XAj8hW/XmW+18qgYs3XMAmn8XmyJjLyRes619xR1hUOsMzvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546137; c=relaxed/simple;
	bh=GqZmqBLONxKd8q6GzK3gmJtCbpC4wYdk7CfTKnHO7c0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmBKY9SuYbF7reGNNkrAcq8I1my/NkxVbpcAvWuWxtB1zto11f2oTk3bjP1z2WmwR1ZCg+DB0qZXkEEcminc9AX9PMzU2H4RN6JUeT+DAREDLfedsYuimMR6K+/qdJrxsDeeFjo2D/eGfslIEsSN78UJUeBZEz3a06oI5rz1O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=rmVxMc8n; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8CFA0100027;
	Tue,  9 Jul 2024 20:28:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8CFA0100027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720546131;
	bh=PyZxBMx6R0uymcM3TuF4TKEKQfa239EroB6vf32t1Nw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rmVxMc8nVF7uRhsiGLQDjsI0Wj8UcBdsUKhQumJmXziBNNjhyCdKubqb47Yhv6hLS
	 WZ7kpvA/zCNgjAxT+gOxeHAU0mnb7RX7DDWhme/hkO5ioqwebemwumodsL9BXuM47N
	 mjT3Xe4ujaHdFJzTi5h+i2dGS/vDlmdHyjjRn3do5j0Kp3JVjQO/1E/v4alyiHZB/1
	 7MSOLdT7Hbrt3QcdrTI3oedE56nvU6rDctfB01+lapVaZpx+lR5tPBYXYcQ2R1srfa
	 //PfkzuMHn3pgH836Pc5kbYN5ycAnw4kzh1hYiXIlB1pSPTtgvcJBMUKV9vh2iskSl
	 gWQGHfKyLGzxg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 20:28:51 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jul 2024 20:28:51 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Igor Prusov
	<ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] ASoC: codecs: Add NeoFidelity Firmware helpers
Date: Tue, 9 Jul 2024 20:28:30 +0300
Message-ID: <20240709172834.9785-3-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709172834.9785-1-ivprusov@salutedevices.com>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186397 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 15:25:00 #25923573
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for loading firmware for NeoFidelity amplifiers.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 sound/soc/codecs/Kconfig  |   3 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/ntpfw.c  | 137 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ntpfw.h  |  23 +++++++
 4 files changed, 165 insertions(+)
 create mode 100644 sound/soc/codecs/ntpfw.c
 create mode 100644 sound/soc/codecs/ntpfw.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4afc43d3f71f..9583243f1966 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2492,6 +2492,9 @@ config SND_SOC_NAU8825
 	tristate
 	depends on I2C
 
+config SND_SOC_NTPFW
+	tristate
+
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b4df22186e25..eae4ab047c72 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -183,6 +183,7 @@ snd-soc-nau8821-y := nau8821.o
 snd-soc-nau8822-y := nau8822.o
 snd-soc-nau8824-y := nau8824.o
 snd-soc-nau8825-y := nau8825.o
+snd-soc-ntpfw-y := ntpfw.o
 snd-soc-hdmi-codec-y := hdmi-codec.o
 snd-soc-pcm1681-y := pcm1681.o
 snd-soc-pcm1789-codec-y := pcm1789.o
@@ -575,6 +576,7 @@ obj-$(CONFIG_SND_SOC_NAU8821)   += snd-soc-nau8821.o
 obj-$(CONFIG_SND_SOC_NAU8822)   += snd-soc-nau8822.o
 obj-$(CONFIG_SND_SOC_NAU8824)   += snd-soc-nau8824.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
+obj-$(CONFIG_SND_SOC_NTPFW)	+= snd-soc-ntpfw.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
diff --git a/sound/soc/codecs/ntpfw.c b/sound/soc/codecs/ntpfw.c
new file mode 100644
index 000000000000..beaf300fe59c
--- /dev/null
+++ b/sound/soc/codecs/ntpfw.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * ntpfw.c - Firmware helper functions for Neofidelity codecs
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ */
+
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+
+#include "ntpfw.h"
+
+struct ntpfw_chunk {
+	__be16 length;
+	u8 step;
+	u8 data[];
+} __packed;
+
+struct ntpfw_header {
+	__be32 magic;
+} __packed;
+
+static bool ntpfw_verify(struct device *dev, const u8 *buf, size_t buf_size, u32 magic)
+{
+	const struct ntpfw_header *header = (struct ntpfw_header *)buf;
+	u32 buf_magic;
+
+	if (buf_size <= sizeof(*header)) {
+		dev_err(dev, "Failed to load firmware: image too small\n");
+		return false;
+	}
+
+	buf_magic = be32_to_cpu(header->magic);
+	if (buf_magic != magic) {
+		dev_err(dev, "Failed to load firmware: invalid magic 0x%x:\n", buf_magic);
+		return false;
+	}
+
+	return true;
+}
+
+static bool ntpfw_verify_chunk(struct device *dev, const struct ntpfw_chunk *chunk, size_t buf_size)
+{
+	size_t chunk_size;
+
+	if (buf_size <= sizeof(*chunk)) {
+		dev_err(dev, "Failed to load firmware: chunk size too big\n");
+		return false;
+	}
+
+	if (chunk->step != 2 && chunk->step != 5) {
+		dev_err(dev, "Failed to load firmware: invalid chunk step: %d\n", chunk->step);
+		return false;
+	}
+
+	chunk_size = be16_to_cpu(chunk->length);
+	if (chunk_size > buf_size) {
+		dev_err(dev, "Failed to load firmware: invalid chunk length\n");
+		return false;
+	}
+
+	if (chunk_size % chunk->step) {
+		dev_err(dev, "Failed to load firmware: chunk length and step mismatch\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int ntpfw_send_chunk(struct i2c_client *i2c, const struct ntpfw_chunk *chunk)
+{
+	int ret;
+	size_t i;
+	size_t length = be16_to_cpu(chunk->length);
+
+	for (i = 0; i < length; i += chunk->step) {
+		ret = i2c_master_send(i2c, &chunk->data[i], chunk->step);
+		if (ret != chunk->step) {
+			dev_err(&i2c->dev, "I2C send failed: %d\n", ret);
+			return ret < 0 ? ret : -EIO;
+		}
+	}
+
+	return 0;
+}
+
+int ntpfw_load(struct i2c_client *i2c, const char *name, u32 magic)
+{
+	struct device *dev = &i2c->dev;
+	const struct ntpfw_chunk *chunk;
+	const struct firmware *fw;
+	const u8 *data;
+	size_t leftover;
+	int ret;
+
+	ret = request_firmware(&fw, name, dev);
+	if (ret) {
+		dev_warn(dev, "request_firmware '%s' failed with %d\n",
+			 name, ret);
+		return ret;
+	}
+
+	if (!ntpfw_verify(dev, fw->data, fw->size, magic)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	data = fw->data + sizeof(struct ntpfw_header);
+	leftover = fw->size - sizeof(struct ntpfw_header);
+
+	while (leftover) {
+		chunk = (struct ntpfw_chunk *)data;
+
+		if (!ntpfw_verify_chunk(dev, chunk, leftover)) {
+			ret = -EINVAL;
+			goto done;
+		}
+
+		ret = ntpfw_send_chunk(i2c, chunk);
+		if (ret)
+			goto done;
+
+		data += be16_to_cpu(chunk->length) + sizeof(*chunk);
+		leftover -= be16_to_cpu(chunk->length) + sizeof(*chunk);
+	}
+
+done:
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ntpfw_load);
+
+MODULE_AUTHOR("Igor Prusov <ivprusov@salutedevices.com>");
+MODULE_DESCRIPTION("Helper for loading Neofidelity amplifiers firmware");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ntpfw.h b/sound/soc/codecs/ntpfw.h
new file mode 100644
index 000000000000..1cf10d5480ee
--- /dev/null
+++ b/sound/soc/codecs/ntpfw.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * ntpfw.h - Firmware helper functions for Neofidelity codecs
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ */
+
+#ifndef __NTPFW_H__
+#define __NTPFW_H__
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+
+/**
+ * ntpfw_load - load firmware to amplifier over i2c interface.
+ *
+ * @i2c		Pointer to amplifier's I2C client.
+ * @name	Firmware file name.
+ * @magic	Magic number to validate firmware.
+ * @return	0 or error code upon error.
+ */
+int ntpfw_load(struct i2c_client *i2c, const char *name, const u32 magic);
+
+#endif /* __NTPFW_H__ */
-- 
2.34.1


