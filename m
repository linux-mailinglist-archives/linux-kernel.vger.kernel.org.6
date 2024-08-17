Return-Path: <linux-kernel+bounces-290510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F09554D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861661F21F92
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191ADDBC;
	Sat, 17 Aug 2024 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="avymZNI7"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2011.outbound.protection.outlook.com [40.92.40.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BCD502;
	Sat, 17 Aug 2024 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861429; cv=fail; b=Qaa67JvP3M/MeiTnvzxnO9w26ZZMOqcF3o5UScbQxUeJn43dzZMTl4SXzGi/Hq2qywSaqh0vTzbGIb5jE+2JACxn8GF4Z2kypZdloxI2O+wPA5J5WM7SAuY3lBiSgwfVi5iL6zx4Z4y6LY5R+TRPULcnD0Y7l23PRHL4kibft5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861429; c=relaxed/simple;
	bh=pUUlnEYQLKGFDYNNgM7qDiyyi9r4EzIJ9carsmiNCvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaFnEOlfV4sQZyoSVo1wcpl4q3MF2juYZp+g04xJsiH8TMpu16p67sB19fB+2+WXYxGDDCjpIFP3RfIPvcwQPeRK2Rw3UumD8eH2OTHkkACiA0o6L5foQAawd965GQLpmmXvS4p2bE2EJANbND9p9jexUU8yhN+JbaQVwwIW3WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=avymZNI7; arc=fail smtp.client-ip=40.92.40.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGtxLzJ+n6RWa+rhkwyFTc/Nh4pYeU/JR350NzU0APEB1wKZfcaSyUm7v2zqnoAE9+vR1EDqoFIQy3p4LFryd63gKKVdBAKlt0SOAjAv9GO/O5nX14lElFjse+dpOtlv6NEw5OmB3M8nxYjnfBPSVbAb/EvnqA6kCdysabQQlxjUqv+XxXbwC2CSk7Lmn8kfGGK3Iz8RUhsgKblz4EzyYxDWwcqvVMhNQJkNTb6uAOWXMsPqJ9mE7IGU16/AZ5JVKA+4+1COyBxtXmG8zOmH1zJgPgHqxYpyQ8DholI9L4WP9VC3PTlLWpTTCe8PZcoKzHXdAvhBJbce+7CkO6f10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYrG99WMMaEn/7nhZeUcYwO99UpIRAGGmfiQygB+tpI=;
 b=KvRLuX/aLzBkOrX7N5wEXqliBRvu8gw7m1g/P6Pl9d+YI4XSTGaWz6P+gnpuENOF6DNphCePEyCXdgtwsnyJIehL2S+RCGMrhHyZGmrv8/3XKkagyCNLh74OQP7DOqtptPF7H6+VbitvcHV9nZJbIMvwuIyYSmPkr37fQgxAQjonZTkG0/t5enEoOxKyhkSDdhFr+Pt4SLDLET3QeNLImgqzEv/xO9FsQXOai4J7hh2QDAEHzA1aOoecviQKO+SKOmefYgdI9g2SUadfzXC0R5YErnBXKaS7SQG7ZQBY/Fb9iWebBgTfs9RLgOqq7FMIX/DH4z8cGz2EqMYX5HNgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYrG99WMMaEn/7nhZeUcYwO99UpIRAGGmfiQygB+tpI=;
 b=avymZNI7D5drUYSrkuQ0eyN9/TPg5jlD1fU2ogB2hkE2Wj3ePebqhQ1+EuMmOjjq3YGLgMU1WO8rvD8kLC6dY2HM1fYlhaoyhE5XVDEWty/2KJssDPvofp2my1ydLIUls78uNVoWla2LGOG8xsxdWwv5udp93ZWX3gk6CNiEua5FpPppmSXB89EO/QvDEh0u9rku9fQxBRz2opmn1jV8QgZ6Ro9l8lYioPeSmXfEMkwsrjbW57uuRQBdOQLGteRK8zo6gMabh+77DFk/ULLHEG92T9remI0buMZ+FpklViU/HHTB/EQSuD2eKwE5sSFYipd1uBxBH71rfN1F4VKOIQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5337.namprd20.prod.outlook.com (2603:10b6:510:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Sat, 17 Aug
 2024 02:23:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 02:23:44 +0000
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
	Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v11 1/4] dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
Date: Sat, 17 Aug 2024 10:22:56 +0800
Message-ID:
 <IA1PR20MB49538276F283C4D01364AEB6BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sZgOx4LY90fm1NeoKmv5GcfHXPm0LFlHq0x1cZhTlbA=]
X-ClientProxiedBy: TYCP286CA0212.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240817022300.360949-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd3e26a-db5e-4f6a-dbe1-08dcbe639de3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|15080799003|8060799006|5072599009|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	xa1vZG1VvzLvT3ubBmiUpDC7ed3lRpLgTeUeY53uPcdGOEYVb0NouWNDoioNuYkJOyEOY4z5QXjSkLbWKwMpd2uyLbzWnR0oqmiZqkbzAZgKLKfLvgO2Col2h8iu8r5+R6pxXh53JwGAUrDhYnzr3BR6weDmsIUl0icVaWGIyS2ZxnP0QPZKNZ4G0R2J9p2VjRQxoqKKWFJIiR3XUwLRKjEDOlR4XjVZV0BVWP8pN1zR9pRN5k0CZaZwrNepwVep7+5A1GIRExkSmG5duKyhgHgK8xGha553utseuCYSCONovd2rSm7Eo6oMVCsQZh7bED7WUu4wbT9ofw239swz/VvllvLTiL5GAqeGuEjpqKHfMcjdt+KA6pTU0Y2VPtqianJIMK1/R89+a41HbOay3HKOqswqc7keqMVw85DYBRWoS2CmZ4mEDV3ljA5oYlC5mpI1I2DYCizGBaiJms9QCre+jmxw7jh8FBbOiU3u3GfCXyHqllMOOhy3BLcKH2eziyVr1CEpTsJJofEnG7AqKxQoI8vECTABfRXpv+zJdTHB8I7Y5Ufcbdptd5O3kqI1tWCSXcOkaOSbI4oZ+J90YBUMGYKmB721XZKpsot9ZOH53rSRr9NE7T7AkrvUSw2nwnFVJrfyFB5kJsmGIvEa9eL0fwslkGqXRdxzJR4+iK7FY7U1Av0m47wfRvRcdbXIhG/bqCWScLYB72rINMSVpcYgekuzJ3jSRVVRosQASYmBl2vDSfEdUHbl4Sdh2XyW0/Iv92XAgiif905+mCpF0xJIj5PEiA7fUcP3S/7aGynHgedo3Xb/wl3jR/3gGp8Xh2nQe5EVJpWXW8bKeLjyli24J/syPR94G9ECFLxE2zs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u2pOqz1/MwVKLyIOtf7Gm60fMqjltdZ/9DvoAs7hbHvU0tVTLluskKe3PDF/?=
 =?us-ascii?Q?gZIpqL9OSquEtNf/CI628P1ZlFtRoXTMvgHgUGLmBd1bLLIFOZN+tpLbkSXZ?=
 =?us-ascii?Q?arNj3VjpeSgAz2jwIspw2at+1FcKCDRlZH+NZEb92qj/f94aovBdT1sx+fiz?=
 =?us-ascii?Q?pFZKg97voHWCLX6sUJdGWY+6PPdzCp+cHWWvptEPtbme7/RobleUkfh6e+e2?=
 =?us-ascii?Q?MRMVSBeOvCV/v+0v8FSvnyfkV2BhTVtMmOzS3XOIBNLlSTp1iuQTRyhWUIXV?=
 =?us-ascii?Q?K/SfpmgTlUlm/VxaaLqyiKQLMJ4KkrlGu3UL8w+YGn/7MT7uI55ujtsGeDiO?=
 =?us-ascii?Q?gdf0NSAuv971DsmUteeUn9sV23o6o/Vw+YPnJLz+GupLprrhApPXSrKLbq8F?=
 =?us-ascii?Q?Nx9uGrmWseamUTeq/6kRM90PKyW/xvQd/+OauM3hXacNuiqRqtP1ejX1TUpf?=
 =?us-ascii?Q?iXGCB8eEBO3hftLfmhXoCVtxbD3y0iwsHMXSPfhvCIXb8THrkdfU8Ji2+PjM?=
 =?us-ascii?Q?JwoaUlMR1IlAJeqljOVAf+iScO2SxnzjuyHoc9h+EBT3S+Y97jPmAtP7jhdT?=
 =?us-ascii?Q?21HMeaNYrZQ6B1CjNpPFoMOtfdXhwombNoBt5+ETqp/mgO3iWNW27Dq0RzA+?=
 =?us-ascii?Q?tqrcGPKlQLub9FsTeLF4UHp6t3ZkaxTykj/8MWUqFAJ0gjHR7P07uwYNDfKg?=
 =?us-ascii?Q?gldl2XWo1fRs4IYlZ1LbjOxZLDOk7mvyUD/N3YXvEozAEsynxyrTPzx5B97w?=
 =?us-ascii?Q?3xuUWyr6pbHRNNfr/17T/3/jpuJsMguyrJnXyKK04aByI+184GjNMgGDzkts?=
 =?us-ascii?Q?Qufu9Xlpg2z2DKXTUaAUIM1OuxCYuLL9Ji061igjlhI3TTHukfHjehDhhJQ3?=
 =?us-ascii?Q?DeDyATnjAXzEmM9Lb8Wk+fYGfYMyUSCLUVIxuvG/Jzdf8UOGMBHsdE0AAM/n?=
 =?us-ascii?Q?O3SWx5QZeN9YD7R4h2P70Evq65g0NvI4Efa6PLPyU6KynHSX0paEOmhOZPop?=
 =?us-ascii?Q?VpCT0K2AT+o3fJizRsinA8WBYSU3O/AAeF2ucVAqmH9jNMGohRMYrM74msJJ?=
 =?us-ascii?Q?QxiHjn4RAceyDabX4njPpQWG+HCDvS+TkHYSrCiPiBS+HxTbPOoJVoVKpIkG?=
 =?us-ascii?Q?Gp9Sn518ChPHN1kCsbwbUhwKD/e/+ayy7NBlgXJd3MYM4e31HFpbXBFU5D5T?=
 =?us-ascii?Q?4rdnj+5pUxOqO3x+dx++nx+EbpK//XcHFA6Md8/adRqkRhPFR210vEXVxvrY?=
 =?us-ascii?Q?h1AmAEgW5o+17k1dHgZ7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd3e26a-db5e-4f6a-dbe1-08dcbe639de3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 02:23:44.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5337

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


