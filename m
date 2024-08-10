Return-Path: <linux-kernel+bounces-281788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204894DB54
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B031C212BC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047314B091;
	Sat, 10 Aug 2024 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KjWiWT44"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2067.outbound.protection.outlook.com [40.92.42.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72B34CE5;
	Sat, 10 Aug 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277078; cv=fail; b=RIVmOlBqcT0wNrxC6z7odcAkRaoZ4TMD5qPCbnf6RcOxwhHHYGlz9gZ+MXIjnERQI5prFx7xxbhxAbB6n+T9NuEfvLHDzs8aQxUK4HXR7TRfDEle4XniaQZD1reZ06eVt8CoANoJRv/m3t+HQEkvkdN0YmCL1N5+4NEZolVjeyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277078; c=relaxed/simple;
	bh=pUUlnEYQLKGFDYNNgM7qDiyyi9r4EzIJ9carsmiNCvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZ4xi2xAcHKHg6ND5Is6PrS/+ZFJX1r0pF+BCFdeEolDKOwH7S4fRi00cY3TrS0WXDHzXAtS6CBT19mAJZhd+UovibW4JzXuZ8LSqYoqPf4KYqmMPWCZo/2/y6XWZqgIPKzUtGSd9nxJGydR2+GLdzx82s7IpnSV4CPOKz3dYCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KjWiWT44; arc=fail smtp.client-ip=40.92.42.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu5Ac5qiQ2JzUcGy3T5PlKAGJavgmdOqdMbNc6LK4oQAarTui+g6hsqZqoSPHWJ/Q9/DxzlZ6Gu93pFa12oqmmjagtsWuDN44CqH/VmlKNAc6Xw5zTUzSPc1wUG2anr9VMwq4jGKhG7fIGdY6/r0/Z1j/v7w69NLSGKNUr4bjurIcIzdxjBacMo7IYM14imwW4vuhxDrrJMRjfoWW2cxMmzEuE+X/46degImZeJM7pq4/9Rtli7vXkyqSoWyrqticMGevxwNqWNMX4raAcpF61ZkWEze6VjseMUmbBO3updFIPbzagc/OZsuSzkbbOUelZYDBrR1UcRPfHOuxXlD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYrG99WMMaEn/7nhZeUcYwO99UpIRAGGmfiQygB+tpI=;
 b=dhvC3la2cO/qWkx6PXqZ2uMeMvI05/CVBV1OjqDMDdLQ38yyLtN7Fq8q768mn4zlksLvbQb+vWeyg/wMOeZnoxIWDF/Ci65w6CBXPrcHct5jk27woCdzQ9cUBwbsqYVXhU6FSENK+FOHs0Wpq3yjZ7DPI/B1uWR7Wd74/j4TQN17MtbGXI8cwoAHj9f4kJPwUeHriHrqXnDZZxUr+85ueVbGOkeQaUDwPH1jC+7GPdd8Pv2O4Wb16x9OqnZxefqhEZH7EqDbalLnUUi1dPk4GjvivrPfIKqDCno2sSbsV2+j0DQvGRDpHmckMjmlrNd5uiWKKXobvWPWVFgVQNSqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYrG99WMMaEn/7nhZeUcYwO99UpIRAGGmfiQygB+tpI=;
 b=KjWiWT44L1Hy2l8egfwdScKWvWFEyXhrAv0Q97sTIBAtgzc5vvA0Tdd3pta4fff4vmZhbGKpmCr4idvwfRUKo9ATrYP9HuzislLA8ZdFUlwpJ06915LFS85qMa9l6DkvnBioBUxOhtMhp/MX/Vb+g9Jz6T7jounhwW5fH5GbpRVxxn43pRI8tLxpjaDxCJ8iSaIj4EhEYOdTgdhAUc+1M8prD+OkY66PLHZbfX+P3/MpGeV4Fwrc2ot9y3ZiyaqAxqsCRCq+RndLQ1GIoY1oAWR8hv8o2F6CJH3VSvf5ujt/JTw90eHzZ91Zqsra9FnejZ8alnnzUkUKhAi+Amq8PA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5117.namprd20.prod.outlook.com (2603:10b6:510:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 10 Aug
 2024 08:04:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:04:32 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 1/4] dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
Date: Sat, 10 Aug 2024 16:03:50 +0800
Message-ID:
 <IA1PR20MB4953504C4B0DBE232F903D17BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zQSdtavhWEVe/rGB2h4nInpjdIXI/+pYw4fmVa5YY5k=]
X-ClientProxiedBy: TYAPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::33) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810080354.387820-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e660935-11a2-4260-2001-08dcb9131169
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799003|5072599009|461199028|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	1HWW7h6PoYcPsyKmz5iZ2cdY8jKQrZ7LRVyOMdKU0IQZsPC2N3dsPoJJ6mOrYMuevjFJ8M2IkMVb2GQP06UL0Lgx6UzBWWAHS7nBGeCpIcznAv0YhxN9YhjK3bFJ73UgaklCP4rX/Oop6wh1wVt7p0sbnjWtmVoFDkEMJnAxNWKd9Q62vzfFsdzfhCS5Ap3WkWjG6cAxA7M7yEPlPS2nlWlizuO5Tb6f9wK8+CuST88hjIU0AGB0nEPjG/yjdr4nsugbd6Bdvm4er6AAiJC7k9YqdGnRzJaYKTJrYnto6rfLXcxRwimJ7oUF5/DawMxGgW8CluJE/qEGhtS7jLjjmISB0uXgNc0J5VzCfyyyhn8p6uUmyKYuPO/V8EaUzSMoHJEjkoIJxMpEn0/lBPerpb+Hul5fifPctaHe/9z39/KsoB7OSLOEvVTE1kq2Jeo6DlUkJwTBMrlxxXJrjbAiwG7MPzipitvz0cAWqYEdkaQ5MQes2ncxK4eZnTq9qBmq+MtWa7YNha9XcWDdWtYU6l9mhT2lk1BkRUmWIEI/ph7xDNVvaqy5C9pyIA6rwUee2M8Ww7eNz/pwvlmfeN1VnMI0Ok35Nll9cONos8CWnJbO3TkbSm7I7B6GgjDVFo44bRgB23FJ35CihyJDW1PPjrAYF3oDoz++FGk8kECkTYo973ZMZgpIqvHRP0lKiVvrOKeEX9derTC0qCv0+0WHG9UWQhZFO9htRlMpnNBxP6iJh06gAxLcYgKI8xF7KBfQnSiIVr+BfVgW9EVrGnATplaIwSSInlDaYca9yf7icL5Apgktk0PC1Ja6hSCtDPw3tbX43ImjNdcVKnP/o84fXkd2uewTJpGmiGPCBajU1pk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xb7oryYwn2zZ+ie4dDJ6NH0v7AGTf6kX1acUPY9ACPDEtfDvo2JcRb4rC0JW?=
 =?us-ascii?Q?/50ASj43Z07UkadDxnxifIE3Syt2lxg76ajNVytaK5wJjkolQu3YRJ3VxnMV?=
 =?us-ascii?Q?RKOTlYXFbHOne49CIboRYwLJE1hfJXrpf52roukbrk1W6OPDZ0jR46FyBzZ4?=
 =?us-ascii?Q?nDXX0TbstJyu9Y2XJ/1TsgqxqZdDGZhWWRSRM776aG3HKVbBWAQNzv0DVgr4?=
 =?us-ascii?Q?00k/hSEO+ORQi7/5gjBx0IsIrx1bHzVurJIevOl6++M2GCsH7grLWT/XJ4nV?=
 =?us-ascii?Q?ouzyDcd5CdNWILbNuXdxoO5rf9c7SiMf6rFBFOP1uE6CbjBPy0Gh0o+EHzF0?=
 =?us-ascii?Q?wPKrp7258OSQ1leFTMO9O580m1gk9h1foHWwpMkT33KT+jXCS94mg1hrKtmW?=
 =?us-ascii?Q?xugUvAoqk5GE8TSILubHBXKOGoBGkYz/xRHzjLbftRkaeHot7N+kPEQRsM/F?=
 =?us-ascii?Q?MOzDg1a4KhpP84p0yS40CE9TasgXSvrmfOldhIDn2KzZPJwEIRCDARlluwg+?=
 =?us-ascii?Q?UOjQ7sHLUu+QdgxQBM9k+dXjgwNsQwSNjbI22JpnuR+PydGwFDRfCWxqyzC0?=
 =?us-ascii?Q?cPEMnii2pr3kEUpUhJREeJaw5pjWza1jkVGaed4aUgp1yNTEcHMJsa4pWuvY?=
 =?us-ascii?Q?WnB9NLKo/fcw2EtFyebyRNvK8kWCs+wGq0ziL4eJXpPtrLKAHAeFeDEQnDgz?=
 =?us-ascii?Q?4ap2Okr/b1CBsav4dnACUvbiEsMDyKPTi3zU6CQIDjJi1u+6Flrr0pZ6vh2T?=
 =?us-ascii?Q?93AOtFnnckMgJobV1mL9AdUx0OgpaP1t8DQZA9S1WlgL77fEaEWAWmRYCXC6?=
 =?us-ascii?Q?coRvf05xyouugHgPvhVfi93xGCwz2qDpmACbZlIEXJER/wwb3uZ5txM5DhtM?=
 =?us-ascii?Q?ueydWYKKGHV0UW5CefY4syO6HXZVO2hNxqpyubla4TKVJNa+q+4naFC70dVv?=
 =?us-ascii?Q?/qGuYTZGqyVZ2DP5/Gxhr//ocT2CB3wkUl8y2jUoJX8SPFQOh8ZTsOqR84HL?=
 =?us-ascii?Q?Zf6KukQKpFYHEAbv6mQoSammv8+bm2iA66C/mTSi0zI5LYtJW1YTTMKIMdIe?=
 =?us-ascii?Q?/yVE3oo7FvaHqPl050BafDI7rVvbd83R+drCQAw4np9dRCHtJO9mfUEfTZ/5?=
 =?us-ascii?Q?VxBmmpm/tp3+ES9zuXBzKCNI8LetYexcUPmZVsqipbbpKPKh9FbCXFUEw6BG?=
 =?us-ascii?Q?KsTEwSaridmb2Jpa311+ck5fVjbmGz+DH/jGA5iU2xwYorK4ROzT7LVjyTgf?=
 =?us-ascii?Q?7bePtcULNWEDpkc8XtJ8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e660935-11a2-4260-2001-08dcb9131169
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:04:32.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5117

Due to the design, Sophgo SG2042 use an external MCU to provide
hardware information, thermal information and reset control.

Add bindings for this monitor device.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
new file mode 100644
index 000000000000..f0667ac41d75
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 onboard MCU support
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-hwmon-mcu
+
+  reg:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#thermal-sensor-cells"
+
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@17 {
+            compatible = "sophgo,sg2042-hwmon-mcu";
+            reg = <0x17>;
+            #thermal-sensor-cells = <1>;
+        };
+    };
-- 
2.46.0


