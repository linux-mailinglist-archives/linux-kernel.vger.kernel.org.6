Return-Path: <linux-kernel+bounces-265013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7930C93EB3B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CCD1F21E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042979B99;
	Mon, 29 Jul 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g8TbalLo"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2049.outbound.protection.outlook.com [40.92.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E71B86D6;
	Mon, 29 Jul 2024 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219967; cv=fail; b=k9S/2cdTnJ/6FSU9QzCNzh/PHnBae1r/nsVI4z8LVNRW/2Y2ysjMTuDzB6fYYC6Yq8bY23qYPK2NnZle5IRIP1obwl7xmyf/j/NESfsyRMvd2NfNm6E2i8DSVkv1RfcxCS87g5kPDdWpJgU6LIeUhSLqBvJwDu1LWUqGPRn1xso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219967; c=relaxed/simple;
	bh=CXePE26trm9gn0A0SDFpazLwJBufR4fFHb1hJgCoriU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMwsFpCGr4+sEHHV6OUM1QXlgrTszic5G72A7TfD6Cjg8ZSS1/Z6Lm0FxnpdeV8m7kaqx/h3Z1uGPlAhcEM1YdO2nI4StBRfr74h/2KAGhQaUsRF2xUssY070aW5GRqGuKNVQIuhRomtnOM6S0N5eRa+tse4snavC4YXZicXGrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g8TbalLo; arc=fail smtp.client-ip=40.92.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6PQ7DEKpoOd8kP9cXfBPhs9he+XWQUwVJxG8G1mU4HeQ48Ejk/Bo5F45SaazALmRfXIEhNP37s2xwM+z4DlHkIEOf3ySqMK9N7pgHHLO24bK+SyPrP/v7KTZBmwGfb7h9/dwBuL+SG+Dh4Ix8MWoLM8Xva97Xx1DwstL4iButA8pLcUtb08AEASYF6OJxXwjsrzFv1OhKdDroHvC1OLdS9IAiCz2a1CZm4Lr09Yhen5J2sFPlubCYRqyt0DvQhp2fnE29Moh1ND5v2dM5oHS9m7lG26zMouiM2Mvcif3OzWEz2ScgHcxNZCPAHf4fVeXQgiabeOPS5UPJewhpKCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NApx2ofCL/ZyIpaLFfQKUZ2T1qNdwWJgOd9Xy49aDag=;
 b=c22Q0APBTd59Z4uA255E4O0EEILMgpGdp+OrdIRW8g5cqWQ7+NR21pNJZPsFa6uaEtw9mTrqf6NkIIYIPVZnY81aN2cggVQwUANww4qhluc2MfNY1H5vh402Pby0cJ/a5kqPZFgWuEHB+j2z3Y7j5s0971e/zGKq7lARn2sZl8HsR8Xh4L7ytqd9f3Komd/nVV7zGunfOBWcPR6yTRkXldwtpcH1IrEJ/8SxInvk7L0BDbEoNZa6Q3BFXxZ7Mw3lEgwSMEdzZtQ9CgrmPOxoK8Bh3TxmdgVcl+iU9uLNtBbZP514K6tabNt8VOLiqa7MXfQYMck0+SBz5lsQyEUGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NApx2ofCL/ZyIpaLFfQKUZ2T1qNdwWJgOd9Xy49aDag=;
 b=g8TbalLowpiEzIjRsSr0MdizMogyM11HUudD/NQ1C/U7Vm3QiHel/oaUnxvlvoQplc7cFaPCItT3mx6IdqzO+GduS/SDwdmMvlddG+BlylGmZKYg9lCi6prKLjsPrczHQHqudFsdNbyhLqa+foqhGPGdvGCDy8sjg9DIYLmevohXO33ANzKBzeNtuT+rdpoGtS4/cKBKBF7SWA3v1T5Hw9Tnq90akqXWLxWQwvw+lcD3oobP1KBgAOKYgj7AY+eL+UrdweBwlr53ntotnGtiMnpIsi1Ii2pndSts4cwdY2GK6Wqz6dVFM2zp4RArvyYUrV1MbsFHCUJX8tPDJQ4tPg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5413.namprd20.prod.outlook.com (2603:10b6:510:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:26:00 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:26:00 +0000
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
	Jinyu Tang <tangjinyu@tinylab.org>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/4] dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
Date: Mon, 29 Jul 2024 10:25:30 +0800
Message-ID:
 <IA1PR20MB4953D89428ACC542DCA5988BBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9Qp+zEbo4X3zSUQuRL4ng276c2qnJdFkuP6fyVPhJJ4=]
X-ClientProxiedBy: TY2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:404:56::30) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729022534.842326-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 3617874a-29bc-4508-de44-08dcaf75c90f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599006|8060799006|3412199025|440099028|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	FjLaJ6Yt0N6u7HP5Bs04LYnn3mkMC9SpgZPiuKXMXH1erYzJuNc5Wm+ta+MZ0lzqf7XFa42A6BTzg01iTX3eL33ni9aZAWDJq3xXRnGWhwEJLWmXwe27FyYv34FYh4451HpHYf7D+D5F1z5XnE1wtKru6ZH8tOcgGzC6AptFYuNb+pw7RKJkD72s+UEDQuVTYBn69hazR3aG7HOgygH7DRez1xiL43W4jRh3/objHdu2yS3rvMjWDJZvG9XkLZnAB9rZZeK6jypcANpsjTzTqlOCYJrm7Dt5kurhbdM0WVgpJPANFh1DwmAtTHIK51g73vSvy0RShZ5xzvGbHYwGlGtllW4XG/4FjZ9I1KtpKzWLLD8Tt6N5O4m7wrsGjuUFZkzbPBpCO4iRtiqiNl/VHia89WZ6BFNLUK2q9C1C2IyCEhqIeJ1COLPclpW5U7Ib01Ld2/J72JvWAgSwh1b6Go0dAekPUnhALTMU/Js5l4/qLWUhdmkuaUbupamjy+zvdNwNR8XF8ZBDToltGiQqKZrZJ2TcpjI3hRjKCfivVJMwusOd0c2kmpv00XqabDXhUpVMZAOt9JjZkxyOJVZiA6oABuYKsILqjSU6ca43HCs4g732JnQcOqabaiVjwyFvLYfg4MoaCuz27GhWJssCmmyiZ+2ji2YyPkIZlf4aGK91/I6DcKoB+JEpyiRI/zbd8cpKVRIs8oojAcvgovj3duuZUuCpjQ8ghbbfWR0bjiIIabS9aJlRX6FPBApMXV3EV7QiFzEW5Zu/D64CR3WKrUCKgHAThbsY5jzJmaKwqS2jUu75yrWD9KicngcLC2T2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H72KvdpXZEdu1ImRpbEAv+t22kLNr5TN7kaxz643GgopYVPqAg7JDN20hMq9?=
 =?us-ascii?Q?Fl0ZaKNFx1Y2pOKW8/FFLrxghHVMC92M5go1bRF7YXeKveZ19kOtj+mf1Tj1?=
 =?us-ascii?Q?xmlsTkGagHWa7OE5DkmRP8bnsjLYLrSmD4V4pzgiNb5nWAjrT4SinFBiuFiw?=
 =?us-ascii?Q?5NNunClgfuheLAIf7YJ7M+zx1Ekxe9W2kN/bkpvgT7XTZq2/AANXkQi1JaRV?=
 =?us-ascii?Q?il9g+or4jeBpEj+WGqr9m7EyAlKvj4TPGukiaWS6xSr2p6lkyX3jQGw4ts8l?=
 =?us-ascii?Q?NQIuK3x/ESUpI2NdEJKKFKOFVSIHNVx9QcCBcOVTc1Temd0WcvqceALYDi7y?=
 =?us-ascii?Q?qJQo48Q1hsJfjNKi4/0a6CP5EK+hurUJr/C8UBFyo4IOstuDCcKKYZ7pXzr7?=
 =?us-ascii?Q?7yfWdhWT2UyendssvyPrUKNlfcto7hrqeTWM8UjYHx7/tMfZCCR1sLQydaXh?=
 =?us-ascii?Q?OGFluHMjG2nod/s0PdjKS3r0+dg3OvB4ZgG67KRX3G7ujhaOSUDldoeklClH?=
 =?us-ascii?Q?QAHrdrPdsHT145QGkYlTOLq5AMxGLpJe57iuxZf5GVpLqiY8CZyyNuhF4N4z?=
 =?us-ascii?Q?31j5BFzP94qimxsOT5tx5M1DVjBx2VdtdSLQz4v6IeHrpV0Zv/+rgsVq4aet?=
 =?us-ascii?Q?7tHgywjh5FOe3/06QVNkAAPQ32wxXLAmfRq/Ny0EMx0MbfG2DdBDdDtfBVk9?=
 =?us-ascii?Q?Fxvj/tSCWVqaDwgn5CG9Ky0FEI12y9NZEBO5V2p1U/go2A3iIOikmxeEYF4J?=
 =?us-ascii?Q?5Yu605fT9Eitl578gAIkzwrJv+I8iU21fgWI/x58QXOj67NpmgLpX7P3zahM?=
 =?us-ascii?Q?ox8ZmlA55qrOjEt+6UrpgT3dmrfX5G9gJmDnYBgVXMJg/QOMcurFZRJJyu30?=
 =?us-ascii?Q?sJt3UB598J7xgraDpIOwxEImk0HynVqadUTzPe7v6rMZSRaTg70nxPE5Mrv0?=
 =?us-ascii?Q?2mmTbPZ5sztKrLNmz7N1R7EB7DZLjC8ypBkfJ93biGF5bzaLj3XweeQ0CTq2?=
 =?us-ascii?Q?lMNy6Uf4nIPC+TpK4bF36YXpE8gCTf5ZS9U8tgxYJHCvWyB+ne7lcq9iigx0?=
 =?us-ascii?Q?DkJ4VXtvMFl6AAQzcMOLi8gZcNshq+OT65WyKNuSWsm2tk0qJrEo5J5zopQm?=
 =?us-ascii?Q?2IQc6NJU7oeDrQzaCdd1ugcfofMYF0j0w2iRRb7dbyisRQQHzHKnlThh2DHv?=
 =?us-ascii?Q?jsDTAtWzp4NJKXOx1druLK3DuiVuAAot4292XaI2rS0KxjSMdrX0qM/bk506?=
 =?us-ascii?Q?zgpEqLrgU85qH29MsT5w?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3617874a-29bc-4508-de44-08dcaf75c90f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:26:00.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5413

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


