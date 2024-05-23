Return-Path: <linux-kernel+bounces-187275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180F8CCF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548C71C21492
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200DA13D27A;
	Thu, 23 May 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HEN5GX8r"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2033.outbound.protection.outlook.com [40.92.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD6A929;
	Thu, 23 May 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456855; cv=fail; b=jpUiZS1bF/Kq9sxzTss4Gk5Nt3MjG8M3Hx/JvJIo/g5zeYI4dF7+LHmqMA/hQAbARrDaNaaLgQ3MDdMLUjoXTHNJ2iWZT7oAzbrhK8GlILBoatDRkoirpTNF+UBxlpVUYITEBYhe2rczPCcT/ZowU+md6OuAYyDg6CdCBnJMBuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456855; c=relaxed/simple;
	bh=iG0ta5sh7wIo4znPddGI5o29io9SQAZOL4WVZqmYQ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tOvhmDpY83cEUH96zdcJWRMVfZ2Nc0nuz+dWtI0rVoeE23HMSnRqqXEGNEi2/qTF4E2N24bmG48Nk9MqSHNw4vLJtPGBItjwruBnZaQ+TD0EajPDl7WMPxofPlzmRF6GkqNBEYhbkpTJCutpX9DU7sWCIGvtkgSNe8Ej5I6jKYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HEN5GX8r; arc=fail smtp.client-ip=40.92.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB27CmyFRmwZLL61kbFGxZPU1Y8t5dSM81pvjz2vWTXyX9g8moRAtT/8zeRtqJdp3QTidtJsVf6nWgpe3aHrHQRCeMIvGRTCaRGKqV5gLflzIebSap/nkA4fBVYtkRQGbZQJYxWybm2ZP9m4xuoOh26rvWArmilcK9nyGpo9tkCZWqQhaOjZ1mp/4B3etBRlsQantrgfTSlHF8s686tsYiUiEtzA+9a7EsamBoJ7SwxpIbzV4dYIpDWsSbUnhhjXOzY9EccNk4W6f5WDRJ87nm2jvZBDhFKUiCv2ji+Uf4TDOVFFTNPRgxUdG5lyYPAr6dgUJVQY/5XQjItN+WQ2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8bFK1Di/yzueXtA2YUYPzUw7zPXiC4ql+u5gFGqi1k=;
 b=T9cyc1TgDYaCSMHiG/bKEEmidepEZH6MOzBzzhdzvKO68L6TJci566sTWbI7V9+BMbg8Pt+DLjrecoM4wTRr2IdD2hRWoLALy0SwGMWPKV3Aygw+2lzz7J8VA4XX+1iqoCI0Yw3YyATbr6jSbf66ZA2wk96ry6lPGNnp1iRYiamu98El48mcD14E7fYJ3dV0wy6opxlhIeJwboE9ZLUeWrOcz6JPq7cVX0JUEPcSjpZzIAsaLlaWbqUqFAvY/SNtpzt+rDWvgQ+RkrOY/CguFPYm7nrpINmxtpv0KpJUNJ/N+qfoROlQsk4j/3YbAqM4oZ7SKjqGvX8If3xmM/+OZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8bFK1Di/yzueXtA2YUYPzUw7zPXiC4ql+u5gFGqi1k=;
 b=HEN5GX8raEo+UkwrRZlTuyl+hxurP96zKl7CUcXRv5nC7Ve0cwWJlSHpiFPMLHKtptxUpuYT00K5zTYCKs6rOjkwpItw2MmTWaBYtZ2Y6yI66TWAXtmoL6YghuxiAgYV85yC7DxNljHtwrtVRC77Y+MmtgLdVDUDzf0I+A+N3BRgsYUf5UOBl9S4RvOSNcXgTWjf53VMVgKYitYi3wYT8yQjzHFrfHEhKh+igMBFqX4UTZPbVlk6+VWQ1gXBQyqa3NnCKX8gbyMyYZ6+n+rxkum2ZY4wPhdOjKH2vb2pE87lLA8ajnvrueUPMc+1DSblwzfqRbYO2pAlBGkXdyyFCA==
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com (2603:1096:101:be::7)
 by JH0PR04MB8131.apcprd04.prod.outlook.com (2603:1096:990:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:34:09 +0000
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5]) by SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5%5]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 09:34:09 +0000
From: Noah Wang <noahwang.wang@outlook.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Noah Wang <noahwang.wang@outlook.com>
Subject: [v2 1/2] dt-bindings: hwmon: Add mps mp2891 driver bindings
Date: Thu, 23 May 2024 17:33:47 +0800
Message-ID:
 <SEYPR04MB64828B9C1FEC5C21C60F5CE7FAF42@SEYPR04MB6482.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [gGSDHwff+SZe19x0LqaTwGblviO20Nep]
X-ClientProxiedBy: TYWP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::13) To SEYPR04MB6482.apcprd04.prod.outlook.com
 (2603:1096:101:be::7)
X-Microsoft-Original-Message-ID:
 <20240523093348.171024-1-noahwang.wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR04MB6482:EE_|JH0PR04MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: ad42310e-e627-40e1-f42a-08dc7b0b7f17
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	qCqjIn+gKzzKzLF88ItGOhNCzUjRytR0up7NclBtcvr/OC9Dsc5+dHLNQ23aeVa1x+MdVELaLIAoTZXZeCiUJ4AJaB2z16/RcO4DCszF1TWrbcwd87+gIpp6mcBCfMyW63ER+QY+dkXecZeyGxtfgPxw4nfd6JWzMQoexbfRNw1qGNXqlPgBEIDN2WCx/hLhfKWbgD7Iv7cD6SNsf3paNtqwdPuFXmaaCeraweNSdl31dUNjnplrrUgR24hHRCGaU5+lL7yGtKc2jmd/OMkFc6RSNSa/3Y3DoXyO2ZuwCXvl1BZwWhorqNicM377f7pm4tXN5z65c8pqICZ55F04EhsKLv+u10FCM6GP7zH8j+alnWWQ13+ZMPLXxYzsHzT9mWSAqeoHh75o90EBvpQn0axVRmwJH139JAPOmJu8jUpcaffLCi9FkBJQXV2Ek3uhAoIydvrWKRTPtJAPkIbal1s86JyGDlB2/0tx4xZWbLRYLHqkpfVtxNBdHf8s8hA+Xix2qEWa8NjrhkobdjBKPNbVfYR7FuvxlWYV3wxEEC9KaHCBkvdLDih7p0OjolQXNbwgluj8isBz0Bfnu41FOB547X7fJ+KIxFWWExrepyy48CiDsyAF92l6EDVK/9PS2MKHO6HLNOzNmmpjQzO6Nj+PpZe1wEVKOP+3/f/aeX/I168crwktwDEMETaNdQ+PFujxzDP55Aulp/CGlj1o1w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7bNurVcn7Y9clqOCXPso+NDqlHIZRY6v4wzD0Z7Rpl/BjnHypIiKoPSdQAV?=
 =?us-ascii?Q?vHvyWlzfIhq/6FjH+JbvWH7XddifKTNebrEHlnr/COzULZX0RNYh8SzBrnXL?=
 =?us-ascii?Q?AgqU/oXVMvfcc4RXcbrOetujCUc4fXn+p4i7sMGlHKS6492japzsaFeoWGv7?=
 =?us-ascii?Q?+UWwdySXTfwJNAVNf775TcEA1DrkmMONJLJ2pr2ZPDr7kwHdxF7O0InCZM1g?=
 =?us-ascii?Q?lP+GRGrW5PKdzos/sADba2lnrlIEaaapMHvRfndXQqlWZ2+xmnIJ9dzVy5dX?=
 =?us-ascii?Q?w5hOaPkCZ0Zh/cOwuJpgFA1kX/ergAHlBFaRrEzzIvW4O3YHVOlxGuQ1Rmmy?=
 =?us-ascii?Q?WIHFI36WtwS8dOEwMvGjjxLifI5C/TacNOCGoW6Kg2WUQ8mZ1UCFKM6hrwDv?=
 =?us-ascii?Q?kavVGX9Ml1HCfpuSQRZ9eufiqImJv+eVuw/9atxRsl+ALpRiMy0QSZoMP+Zj?=
 =?us-ascii?Q?2WnU2Me74erw+7dWTg9M0bEhqkt5cSNTTlVzMXpHWrp6PLI8QzM0f8TGqUJ3?=
 =?us-ascii?Q?YI7X9KEQpZhvC9mjOGjJ/FTvckLTe1Mq5sKKOqsPDOMeQFs1RR0Vwcv+2yrp?=
 =?us-ascii?Q?bdxda2q+o84f9g648sdb7iKAZIOB8OLKj0KCxrD7KY9mU6xfccvEGuA/jgym?=
 =?us-ascii?Q?Cujnd50ZlcdXDP9gMlJPq1gOzgkx7R8fcfMlxI0AUcbsGvXkdG57ZjSkU9dR?=
 =?us-ascii?Q?vJIRovIgsRy5K1C61JgbSbT1N7/kuuQ3lE39ew72Ta8iAQXDUWqRLAxxFSZb?=
 =?us-ascii?Q?t++zQL6WD62t5S8dVk8VwlWctdVL8+Zod4IujFT0QWB4j2QPizaaHjFgxhu5?=
 =?us-ascii?Q?wEB+tgo9hr7YmQ7ieATioIJC0uuHYzkSuOMgWh+Bqff02suHkZ4Khu2vWsOA?=
 =?us-ascii?Q?OIVzlws04yvQfgBnNkIJnI95xj0XPBPP7dzYTeFMSRgLLZctomYICKbP7BWX?=
 =?us-ascii?Q?EhUY/EHGpWI5HW9mhYHg8Fs2C8mkHJJhm9ur70Obb32zTOGuQqwEfLwcHdbg?=
 =?us-ascii?Q?JsxBALffNQbSxyukK0w+xxKu0SI65Flzur1DNzqGcItJy5+vvyxx0p1EhkCA?=
 =?us-ascii?Q?z4V2fYRE7kpqAp3Dih/iBxT4pB94cFLXkk7ZFqPDa0WYMSlybpGYCUMoKGv8?=
 =?us-ascii?Q?noPXJq/kfmEFDR9apRcC3fN/cZCyQB3EWp37dCVGD88/692yIGN8BZ/3wiB3?=
 =?us-ascii?Q?xXbjfUUo5VZCqxB7S9ZPIFOtWq6fApMTrzkHZYtpeOIZF7Naf/BlxKIlgGTi?=
 =?us-ascii?Q?262QcST93KQGOJEv6La5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad42310e-e627-40e1-f42a-08dc7b0b7f17
X-MS-Exchange-CrossTenant-AuthSource: SEYPR04MB6482.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:34:09.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8131

Add a device tree bindings for mp2891 device.

Signed-off-by: Noah Wang <noahwang.wang@outlook.com>
---
 .../bindings/hwmon/pmbus/mps,mp2891.yaml      | 43 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2891.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2891.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2891.yaml
new file mode 100644
index 000000000..9afa7fd3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2891.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
++$id: http://devicetree.org/schemas/hwmon/mps,mp2891.yaml#
++$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The MPS MP2891 Multi-phase Digital VR Controller
+
+maintainers:
+  - Noah Wang <noahwang.wang@outlook.com>
+
+description:
+  The MP2891 is a dual-rail, digital, multi-phase voltage regulator with
+  PWM-VID and I2C interface for Industrial use.
+
+  Datasheets:
+    https://www.monolithicpower.com/en/mp2891.html
+
+properties:
+  compatible:
+    const: mps,mp2891
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mp2891@1f {
+        compatible = "mps,mp2891";
+        reg = <0x1f>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e5dbbf1ed..bbe9a3ca8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22683,6 +22683,14 @@ S:	Maintained
 F:	Documentation/hwmon/tps546d24.rst
 F:	drivers/hwmon/pmbus/tps546d24.c
 
+MPS MP2891 DRIVER
+M:	Noah Wang <noahwang.wang@outlook.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/mps,mp2891.yaml
+F:	Documentation/hwmon/mp2891.rst
+F:	drivers/hwmon/pmbus/mp2891.c
+
 TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
-- 
2.25.1


