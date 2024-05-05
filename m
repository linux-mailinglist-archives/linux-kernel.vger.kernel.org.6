Return-Path: <linux-kernel+bounces-168867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB58BBF0E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443F01C20C7A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBCB17C2;
	Sun,  5 May 2024 01:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pEL+GsN5"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2102.outbound.protection.outlook.com [40.92.23.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD84EA4;
	Sun,  5 May 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714873906; cv=fail; b=QR7En1iGco+10wS//Iq7yDNDRM4rY66NTCI6jk1jO/mlJeKGDg4W1EjjoNZxTHxcDSxZaM7KhMmNZ9QrlcxHu88QV/qdt2wCkfbi/i+lb5l4OC9NgYJL2lfLjS8EM8KJW9zO6rsmQflqXAKiv9pw3eAQj5GZxrr3q8tDmupB2kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714873906; c=relaxed/simple;
	bh=WBP//gZrJJpG2uY1hPanQvdySRJgnZXwmNZr/AUn9tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+6Sf96XZ0o3jXtgI8i73o3KKhTAIqJuxc9rgWTc9jnzQfYLyYD8QXn/o1q4g7HSC46huAHKfXCCfhIMTszKchhEi5EACwXnTut6OKeEoI3/qg102m8Xi2qCcCNvPnnJETa5HSAsjzqonmvI2KRN0uIzEsBsdt7wENdo3xHMZNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pEL+GsN5; arc=fail smtp.client-ip=40.92.23.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjFIyetkjje9fu2d0LMWTSxlk5NrYinf+RsQyHgiJvwuvK1LWCB3lXxeus0o4PpWw7LRilCQtkLi96zj62g5hZqySmwAV8WFNTWculV2vZox2lE2hwUGlXl8yxHZy20Hn0JPnEC5v7EhvXsl7KDRp6hkhklhXXXM4/kgVuC99pHIH8VQ48r4sZlQnycSMoFCAyb5jGfA/Jagqdy2MSnhlvNQKLoSD6qLjYHdrdP5wmZwLVCnstQ978IbLHbgpII1Re9KjQZAxhARS2wtlHU2bAwuCGsE/WOevAxTm0xx9NnBlXmk3Qwe7OF7EtzYcGZhAMhv7uj/1X/qLSS6ho9rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjJj7wnstyWl0jKitojxpS6UEVwrqnBW0lisIDbbjkw=;
 b=YGtkNo9OVWzYu8+SWnottlZKSws8Xzz6q/5nedr7Y7tzpaNFKy2JLx/JblQP2802WP4ZPsyJWSCabRPYpSaNMoOCBSMyoAPnNvTN6wlcyaRoG7CIHxGlpbMYLdG1U5kZ3KQPLaJfIgI5HbM/7HxEvvEMJcru8bZBSgoLKPcKin5AVOzEjk+4KKoob45qJsEA0ILd3kOSvY+3Adx8DQvcUHVYT5W1AGiM/2LZBGwqPIt8rJ7g0Zh+sZ1tHpc5mvNkBmjtWoH6yIT5XbGDy+lpN35u8prFUcgxGv6XboxOFxNTLa1kfKHHn0Z2yPsMH8ChMV1RAjNJg8kXRj1MrNkmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjJj7wnstyWl0jKitojxpS6UEVwrqnBW0lisIDbbjkw=;
 b=pEL+GsN5/kLyuOgdv1IhqyuFCAETDNdVGM4euKmd8JbSfXOM13AUbkhGDhyUndLGQMVOCGl1bw5E3guJMELBpJQoZ5MiL9H06PYj1GFVPdx49vXqSEJyxdrKYV/O0KcYa3IQGobWZCFZyao8a/G/8dKAit3whUAojciUSg5w1dIHwr7g/fU4PpnXthPXQZpJvK5jES89vWrUBIBQZCDhkTuvuFGhQrQjdu0Iq5MZqp/2Kopc3Ag0LkKrSWvw49hypmgFgGcbH5y7WwXR2hR4jVXELbIqseA4xjFRriA6U77W4F1BptZymdc7A6DIG8EIpsbgoQ35+pISb0+p2103bA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB4304.namprd20.prod.outlook.com (2603:10b6:510:12a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 01:51:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 01:51:42 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Date: Sun,  5 May 2024 09:52:15 +0800
Message-ID:
 <IA1PR20MB4953612130BFC78A8E92F6C5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [N6p9zEd0ZXS/ukM9TuE+HxzNs0t859hLcxFsyrogz5c=]
X-ClientProxiedBy: TYCPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240505015219.754500-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5f8e53-aed5-464a-4d4a-08dc6ca5e96b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	XKzA/+thobYFJxO9DfetPfcW3v6NnSY4O7TrHoGGRKTeFNfAh9BOL3fQwAqjlk2wmxtngvxyQYrsTg5G1X76jiuCElbARbl6kPHOkeE21pvfpEVOkZ5MK2uL75ZVZJYOCA+Q7OLA2P8L58aBYPFXb4NFhePHsHC+uFowH+HgjE6kTmADoI4K5Spg5sFoEdbTIYjr3Ni1L17kd27O1A98IFAhOSBNsoCnMFaEBQaPhBfEmCFTizebm039O29zzraqjT+6QBgfi5xGonlNk3seh6wo56WsxhXDpGbp2JzsPHYsgnjO6wKd5f1tkEr/2tCHfbHa3RjfkTcrtbuBbOoH1juH+Lg3OMg7TSNaNbZ0BAl72Aon9CAS+nsFK2lXm/TCLZhFyZ2kM29kWUJnR4YZ8LBeTBN4bun3EaTW5oO8ArJgQILBRyOIeIcwmqTvbo5Z6Uqm9F0/WuKtib2+O7gf01qDXb30a+gehe4CcT2Zxo252KI4Yb8MMlM5QGvTCu/11o3OkXP1os2BpOvzYjRY/EoJkvkJITj8lmImpyo0I6CLVfRXdiO3WXMwAD9Fw/TVUgkDMU2pip4cWyz/R2LJJGlkv5TsgmnfGOL+QwPB621ElD4xQENnEr5rNNmUaHQGOdKowqI92kxzc88ZNJntZqv7KFgN7D/W8ZEdEdUWv8CsWJWn8iBDLC57JBi0o5LihzR9ZRsTT/o/FhYBy4BkMQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qucRKQbTzBG83vpnbutQh4n2jMQHesnMIIoKoOq0LSCmFJChzqEV1LxYWU8V?=
 =?us-ascii?Q?ofhc/EPirhNEZPxtDh2jKYKeriVIwVnauqK4mFGD/rGKmMIN/2reVLxtUx2p?=
 =?us-ascii?Q?egWDVNR1Zm4dl+WHwvZNbJoGli3CxhHrr5TGPZnWGyOLa7Q8CQlOl7pxl8rD?=
 =?us-ascii?Q?JmMRptvaWNpAqtZkVT2fQDucULQuFBUkH2Sfp+vXUJ2YrWdXM0YXQAw0F0ab?=
 =?us-ascii?Q?hsFKT1v+boYic9shkb61KFEe/4cOGTeJdO6/2Lh7QXz15ieOUV/BMGFCzO4i?=
 =?us-ascii?Q?WkIr62DIEuX8hnaRwTMIpreLczm215PYZO0h6QWKyJF2uyc/ovZRL2HPM6wg?=
 =?us-ascii?Q?GSFUX7jMbzbrPAr+Or+6mlPzNwgiO72juc1p8+Fpo9UjzE0LzN6mI9no6R7A?=
 =?us-ascii?Q?qb4uDdrNocCPnNUOzXjgHfka/4zEU/aIjZDUneTzXd+7MYoThCK1sfzTrHIz?=
 =?us-ascii?Q?A8KBhid5s/nU50le9usm0TyLeA+2CryQ8LRqgd1kcLCu3rbZYKATC6L0J6dt?=
 =?us-ascii?Q?Z86/Y2hKPT1ag9sgmgIbd0KdfSy/2LYwWw61LYKthO9lgE2Dn4BDziCBla4p?=
 =?us-ascii?Q?959yOUZ+xi2PlmL6E6qPjQBm8rEgDy/3gwV7OQUEw/uKZm2p+8/7zqZTEOgb?=
 =?us-ascii?Q?lUbHlu6i4y0u4iR+YyKZejkdSieNY5MnEfUpT81ORJMdeedY8gbyoQlKn7tV?=
 =?us-ascii?Q?INcguaUHsCQzWLyCG8x+mvzJlQNJxefzXfbzsWYF5CCvc01TfEGSo8yJJy+L?=
 =?us-ascii?Q?ZSQ+eiyQPrDph4e1hqi2Pe91jqIu+D7VEOBEaBOCK9EC/Rb7Df3FV86DWy76?=
 =?us-ascii?Q?ejcGBODvYsliB3UUn8I0cF1jU+tWegOu8QSi9JIDsFlqyQXAu1rYbVPZLtch?=
 =?us-ascii?Q?kUvkxRX70ZkyaJOoLmAS76/kuvUh7qfTeQ7Q31H+bIKwrdzZ7QdTfX4srpHo?=
 =?us-ascii?Q?RHNzaZsaDMwvbpWA9BuYl5SsyrtVph/Pd2ELqkpqGdsN5lbS1qa/bTidDaba?=
 =?us-ascii?Q?yWTfnYtkj01qlqGtkU8WeDZVwZnvNLGScMI5j4Cni/BbOwfiMIcHAweWoqwf?=
 =?us-ascii?Q?TLSqfyFrAnCg4YLrc9YtLgFDFrqnyy4RwrZ0h7GUMa714zn/KgM0/tGkgYBN?=
 =?us-ascii?Q?61TCReOaV2D/Op/S+Fu0E/JwjonwisOvYy2BFOhvjFZbSxstDSVcgVz9ZrDB?=
 =?us-ascii?Q?cOcnBaB/AOsrEVqxDLCBpxwh4PZmZe/qdOYk8Os3SweoL9YGS8N0gQmhV4w4?=
 =?us-ascii?Q?yPIAsomquIVP/PrvdkW1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5f8e53-aed5-464a-4d4a-08dc6ca5e96b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 01:51:42.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4304

The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
"VBUS_DET" to get the right operation mode. If this pin is not
connected, it only supports setting the mode manually.

Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
new file mode 100644
index 000000000000..ae17a8f91b0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV18XX/SG200X USB 2.0 PHY
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,cv1800-usb-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: PHY clock
+      - description: PHY app clock
+      - description: PHY stb clock
+      - description: PHY lpm clock
+
+  clock-names:
+    items:
+      - const: phy
+      - const: app
+      - const: stb
+      - const: lpm
+
+  vbus_det-gpios:
+    description: GPIO to the USB OTG VBUS detect pin. This should not be
+      defined if vbus_det pin and switch pin are connected, which may
+      break the VBUS detection.
+    maxItems: 1
+
+  sophgo,switch-gpios:
+    description: GPIO array for the phy to control connected switch. For
+      host mode, the driver will set these GPIOs to low one by one. For
+      device mode, the driver will set these GPIOs to high in reverse
+      order. For a reference design, see item description.
+    minItems: 1
+    items:
+      - description: USB switch operation mode
+      - description: USB switch host power control
+
+required:
+  - compatible
+  - "#phy-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@48 {
+      compatible = "sophgo,cv1800-usb-phy";
+      reg = <0x48 0x4>;
+      #phy-cells = <0>;
+      clocks = <&clk 92>, <&clk 93>,
+               <&clk 94>, <&clk 95>;
+      clock-names = "phy", "app", "stb", "lpm";
+    };
+
+...
--
2.45.0


