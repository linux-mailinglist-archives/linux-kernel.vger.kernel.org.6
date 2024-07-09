Return-Path: <linux-kernel+bounces-246480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFED92C27A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C921F2307D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD41180048;
	Tue,  9 Jul 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="nfMUdeSE"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490417B046;
	Tue,  9 Jul 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546136; cv=none; b=jUJgQp975QDj4E9PwQTF3Vp0Zn/bXmF3KW+4ZUIvw+z9Yd57nomiDBnmYyos+kykOymLFe22S2m+GKfgy5k5RpiO0NFnGwQ9XGyGLktNaN2uuPkfRjLRVHzl/wmU+7u7a8uGqB/GqqyAAPNIA1UMK7cnHD1BmcvTb8ZhpQOPPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546136; c=relaxed/simple;
	bh=SL779c8PzO1XpiSwAJa/S6PIZlL48M7/q6ezwLPb2iQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KihpV9CckEwTN6NLd9CPtuFYe9v+Yi9ade/gyew1H/4BgeDxFVekNzUzOx9nloje7MvKCpzL0Z5AxFuEUGhDh7iheX+puv6ErHKXeRA9r+25Ypl7HvDJwj0j63Tar7pEs6bygOx/X8RcnItrYPv38i/j1YflZUqBzRO6ItvMujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=nfMUdeSE; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 64062120007;
	Tue,  9 Jul 2024 20:28:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 64062120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720546132;
	bh=jUNy/Bww76heoCaiENmwMtdeLjP/qEn63OZ50dOXjDQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=nfMUdeSEcxPBXsuCCRnogSgYOI47QIcxXtzNW3jJPmMNc91ZemXUsQALL755yeJYd
	 28p1ucCYCO1QnZBmYvuljY9/x079nGz0+VR8H7b/P++boWFa2e2ladoUtT9//pF7u2
	 NvpwQvKWdma8EQKqBCO3WivIHu/K+6h5Ny1aGDNQY1LRPTBd0gwqv3wLbx5oW8FThr
	 DEPOB8RZfAwH29aZy2VcJfiIzz/q3whzsKwICis9b3oUMlfDEwg3mxz71ZpvopHHKq
	 2BSWOPT+LbCbbqScCL6T9rp7vksu05L/DO6r/E790DUUCurdg/3OGmAf7K2zr9KYX2
	 J3MwXUn1d71kw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 20:28:52 +0300 (MSK)
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
Subject: [PATCH 3/6] ASoC: dt-bindings: Add bindings for NeoFidelity NTP8918
Date: Tue, 9 Jul 2024 20:28:31 +0300
Message-ID: <20240709172834.9785-4-ivprusov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 186398 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;devicetree.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 14:24:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 15:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 15:25:00 #25923573
X-KSMG-AntiVirus-Status: Clean, skipped

Add dt-bindings for NeoFidelity NTP8918 Amplifier

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 .../bindings/sound/neofidelity,ntp8918.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml

diff --git a/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml b/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
new file mode 100644
index 000000000000..4ca8957309d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/neofidelity,ntp8918.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NeoFidelity NTP8918 Amplifier
+
+maintainers:
+  - Igor Prusov <ivprusov@salutedevices.com>
+
+description: |
+  The NTP8918 is a single chip full digital audio amplifier
+  including power stage for stereo amplifier system.
+  The NTP8918 is integrated with versatile digital audio signal
+  processing functions, high-performance, high-fidelity fully
+  digital PWM modulator and two high-power full-bridge MOSFET
+  power stages.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - neofidelity,ntp8918
+
+  reg:
+    maxItems: 1
+    enum:
+      - 0x2a
+      - 0x2b
+      - 0x2c
+      - 0x2d
+    description: |
+      I2C address of the device.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO used to control the state of the device.
+
+  '#sound-dai-cells':
+    enum: [0]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     ntp8918@54 {
+       compatible = "neofidelity,ntp8918";
+       #sound-dai-cells = <0>;
+       reg = <0x54>;
+       reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+    };
+   };
-- 
2.34.1


