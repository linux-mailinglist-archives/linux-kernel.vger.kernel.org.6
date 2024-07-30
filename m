Return-Path: <linux-kernel+bounces-266949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF54940A40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB09AB21F20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4056191F6C;
	Tue, 30 Jul 2024 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sCcQOpnh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2047.outbound.protection.outlook.com [40.92.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92A190666;
	Tue, 30 Jul 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325876; cv=fail; b=hemaJtg4TcKRTvZu+SZkLIoZmNqZxYV+o0M9uYwWxQeVjytQVOAajLz1vUaQHgh2BzAC30bU3hr8ApBA1FFfBoVkxIW92x8T4vBN2iFRNU0i1h/lc2YPQYfJ9qRTbLILLX2fP8ESH6i+6y6Bk9B4yqCtMpn/Nj1DP6Gtg/3cxZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325876; c=relaxed/simple;
	bh=CXePE26trm9gn0A0SDFpazLwJBufR4fFHb1hJgCoriU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qj4Cu8adc0qHcWKcMj/+7LdWEKV7z40+lkwch8i2KW1qRGWv3XBBxvwui1/JEDFY3ZLu1oORzBB1FF1KEQ3G1yGlfCrP4+f2CVQks0g7uKEdtimTBB89bHCwPlNKAZwkyKmMcPm7KbXunhZ0G9mQEDKLemKYz38/mFQuHkh9lbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sCcQOpnh; arc=fail smtp.client-ip=40.92.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9XQGcTuuOO6bJvUpnuscIwXmZOiP5yH9pHlanRxtGetR0Wst6FNo+dTMin+9YdCD3jUbjYm9nRWmvlnprIWY/Fuln3buw29quTmifc9qPnHcErCBOLMvQo2JjtZQDRUtN1Wd7E5xxNviqg/t+FjqM/GOH/vGLgVOF3XKK69N3DZBJ9N0XLUxNb5Pzik2eVzRBJgffSWc+ToMVbAJvHklslxzMU8e2Vh204q0/3G8hJqqHsWHjgV8U4hRt0jQrxOseA5XY+C/K5L7aeyP7wclLv4+NDENLUV2s1l7xdKAUKLzQZsk0fDFC9uFJPzyEZZcQlIxRJfAdENUmB5EPo4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NApx2ofCL/ZyIpaLFfQKUZ2T1qNdwWJgOd9Xy49aDag=;
 b=nkhqEmkFqThi8qNiEkwyeouFbFgoRZZvPQpwl/1O3WuTTr9NpwwZ9NQxuOSwy/FzoLfx2ft8e70rrQFNVRHCy74JKcPbjeHcs1ArOHLdQ9fHK5L58YL93/BVKKyF2igbJhqhhXpnKzlM0l71URnP2V/NEF4JmNZZzu+PX1LZ7E8Vj4/sjIrP+SYpFBGvALuZbNc65v02RmgPkBmWtri888cn4gr+b3UTm7SPMaXtQ7H9uygTqwG6Dq0VpjNjfQhAW9Xn50ai0s5vdKkh6+jLF+/gUpGJUDU1ELRGd5z7C2V937P5fB/F3/1vDOWC3WKnsrPIzHeT2Wc/xPNsvrXF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NApx2ofCL/ZyIpaLFfQKUZ2T1qNdwWJgOd9Xy49aDag=;
 b=sCcQOpnhVvynZChvES6C3ovoB5zXhBjIeAzoMQYNDU7fKpLwR+8Z7Qx4TLs+85Mu36Js3rRvgMfYnXBQ5GW2DT5VglE/l1dZuPBl+GjZM7qhQixkwnhQnEbmf2Tr5NMxh3erOCklC/nNECawt3q3M7o6s4KD5HZOG1aW/2zPRvFZ3BpBle98REJOBshWN9qu4JEWMJTkm02BKfgqCyUIMXJW2wAuO89XdCUkqNz1UK7x/+mRjNWjcCdOivG/JXB1XxAak/d/XADJl17M0oeyi/c3yrqvyi7fA4hZN+NE4xqyGbe047DTozFnyCsTSfkXdmVRjRjhpb7nr30ZSsOPHQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7552.namprd20.prod.outlook.com (2603:10b6:208:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 30 Jul
 2024 07:51:12 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:51:12 +0000
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
	Hal Feng <hal.feng@starfivetech.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/4] dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
Date: Tue, 30 Jul 2024 15:50:37 +0800
Message-ID:
 <IA1PR20MB4953634F74A59A9C080BBBE5BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Bhx0MQe1VKtdPGoV8p3rZRtnFgW9QxCOrOj+W5b9eEs=]
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240730075041.489815-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 141fe9e4-f380-4745-3166-08dcb06c61de
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	XiDmWtVVfe3RMudIGP8s3jgAI1zTgJlOaLrbNsrOkPyZLxh0f4r6MgN4lpugh/XSXkK+z7No/PXFXSk4NPADI6AXVLCbNBD0BLM02TMF5Ofdm89yYodSSemLxORM4fyY6nPXFm/qsN+sSRpCmKgfomH7P4rn8HSzkPK+F508/ZZt2OrtuvjNyPUAS+Q7EP28IQPd/jn+0cKInsLzanWoZYMgsEzOHlGavljv04YcxDd96ITqc4YtVfC6DWIHj6RDjJAr6jojSEgdQCF7a1S7lBbO4sfOMSenvyH6eKwX9FgnrR/iJOozXeYRQk4UjQRAWE5zXmDCiDjZiHlxX2N5CCQXdVpS5W6x5g7Arr0yVbYPS3+Z9JkVMFn1DPTbqfjzcxr/BSgwuz6igKHVCPZ/fV08OP5aIVE0DhKrmi7QFT6ZadWRC8kbdEAY7aGAIChumhgI/UkivbY8rCl3miZh2dUffRz99vtkZzPFptbUd4vl5MdK2XSBWN4zgARbO+wFtCCNY0G4Vq8peb/NeS6m19UbaL5akTf4ok29VK6rbpqO1fLPIiL83nVDIqnDHZaY6RXLEMKLX2jGgXNaQ7xUDRlhyUPP3fG622XeHYs28bQvcjHrlqiUl6OJEzdD++zW8ZTlLp7o+ZLD636w6iZe5U9ceDJUdg/nAzoak+Y9PJSFV7um1NqQiDZA+nqYfM+hkl33bJY8fGT93RUGduoo/nXsG3TkPsFOwPcfNcAEjSo80ge3W/VK+3zSYyTUbblud8XyYv3Wyt0IbZ2e7B+dliccHBw4rbin8r/qb6dFpnEbDrXGeFRwC4Fl7p8rmyRM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwDopMEzNG2CnXmkU43TPv9QcP3cCByh4DE4H2REuSVn0sWb4aohEpihTRZb?=
 =?us-ascii?Q?0LYqg1ba+A2uTBRXIEnrSmm7k/Vuc6BCokit3f3RmKKE8nd0DUyrXTof9KR3?=
 =?us-ascii?Q?oLyG/Jy0jBZYYFlDUB80fmtDCPhqpfEdS5Lz4iVjzx8gidk4jt9xW3mXDw4t?=
 =?us-ascii?Q?aDCxX6TSNYUPgr5YhBq97dVYk1IIycUXVQs6Hr8SwtKjLk9LK64V9xMVFcVq?=
 =?us-ascii?Q?QpLbszJX9GmMuW/lloMRS3i7rSPedDNyIc5GxbH4qWUTkS1tzmwyA32Nc36K?=
 =?us-ascii?Q?GdgsMTbY2n/UM2+5yHDD79acSULvIWfOSchQNK0/gMVIxFbdUcQOWBjKed6Q?=
 =?us-ascii?Q?3wlk7UySkPqn69NeQjuUuo5QzkVPdWXOFrIoivJvFjqzv+7bqNrBMoFR4hRl?=
 =?us-ascii?Q?/umU0a64PWqIi49fdpZsXhGFcycTwzYc2+1sKqopWvei2CR8Ny8jJls1CvSp?=
 =?us-ascii?Q?1fme3Jn9MsS85vMiB6ZVd9PvAaCxcPHSD8k8Jk7ie+wAs58M+tcPdRhk3TBp?=
 =?us-ascii?Q?MqVw5mtEDLbv06F3M8eKh77o9edFa25mOsHwY3uR7MKTy7q62J+1k7WJb+8a?=
 =?us-ascii?Q?HtuzzoDUVCTJTrAtSEPOuBQ7c4ebpHJnsOwH4UKA4zydtwK9IlLL90biTvnw?=
 =?us-ascii?Q?vs6I+xW8evZkQTc5ggaY7uBcX4tQsAYsd0uXHqWe7/V2DBnwat+GALUV84VU?=
 =?us-ascii?Q?i4yEETF9xfkXTLzKXZB1U1yiSLtz0TANY/zeRxC9sP4A81JVxIrJuyIS4z0O?=
 =?us-ascii?Q?YvmYYppsIDvqkD7LHWLE3fxDpayuvDWOj3o+TuXRhL5VsFSDTkNsvJVOAMj7?=
 =?us-ascii?Q?UXfwTnT6rn2xcjNI8jbkrTXQd1C7SepooHFdYVS4CLE547cbphJ7/6buKvH0?=
 =?us-ascii?Q?Ni8wOXV17oIVKlLy4kHfr3oS8kLlQ3KdoYcQl7+L/YVmwzVNPz0TZ08Q+Bfc?=
 =?us-ascii?Q?gB6trToIZK4qeeLQZI+APVocBsC6BlgCRjPHF6O9Wq0na0d1vA4VzpkCCWG0?=
 =?us-ascii?Q?4Mg2XOEE3dTBN8Ubj8BNV+2U54ZAPfXGgzrpeaEuW7h83rEcmeMGdKKL4v6f?=
 =?us-ascii?Q?YIPamPfCaQKC5ATi+j4vn/1NZkvJoWK3cT5JAQ86Olt6FXPxMA2MRkX7d8Bx?=
 =?us-ascii?Q?weUySD+OZzx+G5M6G/orrSL3fFsEsFR0nVYOdCTAjmxsBHGFzWlP92bEQmFj?=
 =?us-ascii?Q?Jx5y1Ib1Y/kb0pNbw7HsQ052QuOR/IXI4Mubmb91EZwjFYX77lMZMtfcYSVv?=
 =?us-ascii?Q?Ma8QFwkZ877D91mD2VK1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141fe9e4-f380-4745-3166-08dcb06c61de
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:51:12.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7552

Due to the design, Sophgo SG2042 use an external MCU to provide
hardware information, thermal information and reset control.

Add bindings for this monitor device.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
2.45.2


