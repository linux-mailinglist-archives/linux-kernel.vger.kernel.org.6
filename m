Return-Path: <linux-kernel+bounces-168862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C68BBEFF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FFDB2128B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008AB17C2;
	Sun,  5 May 2024 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hgk1eKB/"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2033.outbound.protection.outlook.com [40.92.41.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE1EA4;
	Sun,  5 May 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714871906; cv=fail; b=rWTGJEjY/LL8kATYRXwaUqAXZpOvX1mGnIjLreSjOPR8x1t5NT8zHgPxN7UQEuS7Xe8ZQfiVZLyaks/GvV5o5hfiUxtb8mKmyo3a9BMe7BOlkStt77koV56PZnQCIaeINCsoyCb32BAbETc5AQf3cLUBqXvewvQP6Seew6XLVpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714871906; c=relaxed/simple;
	bh=Fp925baCG57licXvlN+5u5xGGxV/1gcQRPyOh5xgNZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOkUoSweeTVbXn215rsDD1gDPmJZJyKk/wd6X3J6gFdf2N/JQwbPhqB12wbFKOBGpDyZpl2vsikpwUdy0UFqzII4TDsc6DrRo1esKUYCD1MLEhYXWtyitHZQ1BpGsjJIDqjD3piPw4L5Z8SpXnAVsLOH/mZD4rryC+pBSgpNvus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hgk1eKB/; arc=fail smtp.client-ip=40.92.41.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFa6q2028vsf46WiIpbFHTZ02RLtFkVCNcRBTxKeA3rdIzpgCZ7PYovFL+FWkvTqtwb9eHxe5ny/lMft9w6RSWmqbcGhyMOFLUB8MkhhAFSm0zPUrMnS2QWfz2zMt3lfSuBPcljrFBcl99Q8XFinQ/71rM11czRGutrJi/jHW4OAt4u/9yobOp2UuDmxdPo+pfxEWU5/SWc5ltOO4a5/pYaIFRvoQPxWERyKX99+5nwkywTxpBJRixGg9pWXflZFsbTTmtCFzTzTWtZEGf5HzYoFUPdmCwcJ1f23sBp4TInxKI/RoTB9ctZWdlancOkN+V76TBdz+e5oKqCTXTBvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTz6uhpQObxrwbTsf9dgHGENXwjrPCeeH1FXBvWsvZE=;
 b=W67IEZgy0ZKH/isfcXMCr5pz+EiF0SWjmDURA1Hz3TfouFJ7z/Ekm+WY9T+ByJu+P0yUul17C8fggqpi5ADUX8jGv5yImUxyrQPG/irH7XM1FbypeBgIrdGtlz3Wd4OZ7krZjd3BBxD0BSFvKiPzEE6CAUTZyfxglMlCpMdGn/MvxzKCn0RGllF2Gf3gWRNaiv/LMRlHOPt/123N3ERuPKEkQGBXsuL7cO5n0cqj6smEl+q2qkULRzlj67c8thFL5DfK/o/X8d3Ii1Jgd80tmo9QPneVR0IKlgREnppN7/DdsP3jW/zdj2Lf6hlcQZY4+2p7rSWktcp0nSb4K7D+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTz6uhpQObxrwbTsf9dgHGENXwjrPCeeH1FXBvWsvZE=;
 b=hgk1eKB/41ZY03sEeVkwF4HnWz1WqITk9vmgcLOmu9o5OQHzJmYJJeNZxn9bHg3DMVeA20EAy0QVjMhRxrrGJ3lwYnUq1Fn1KvOqJGLUCuPLth3EkjHi50pzTdmZ6Lh+GYrRqxaoXFWiHwewi3VCx7TmkcIoLFxV4aXhWl0kUtpITj4P6UzkjV0ZtMD/IBBKyjxCau9pxdb4Aet0kyu+xATXGd61SMKWm2sMaOms2QnYYtpzRLLJQV0S0ffcNmrdfD6p6vjoPPekj+UR5WiZLji+xH7PvM3NYf55dA090XdQyFhnNY+AvCQx4VO0z7FIxV/4ROTqmB7BTGAWXXJe7Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6964.namprd20.prod.outlook.com (2603:10b6:806:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 01:18:22 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 01:18:22 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external hardware monitor support
Date: Sun,  5 May 2024 09:18:52 +0800
Message-ID:
 <IA1PR20MB4953F852CB7A9C5FE45E18EBBB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [iA/1wH9Eb6cl7G/uZBJjrUADM/mwcQvh23Vxrs3SMgc=]
X-ClientProxiedBy: TY2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:404:56::30) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240505011856.359216-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 5918865c-4fc1-4389-33c3-08dc6ca14165
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	FuWE1if70hHloHpVZXwgkDVCqA2IAy9r/UeYpGt6Ny90P+wYsrfcjQjQ6oQ2cI9t+qS9lhHFJHAJwEobgvQSFC7OfbrxVKQNABZSqPIcw9BuY/NZUlc7eLgkR0IMBrIjaSQ/2FuKldNYfR8Xk77Iuy3VBc8ki/7V3pP/BC56Y3ngWITBqt1IZ4oOzDCprb8BSfs/sEb45DavqHlMzMiN1t9+GWEL5hIrl0RiX4nk6TWSHIbWsYKx7WJfM4c2L7cI9FtgypE9M3geB/DM6nmIKqh6n0aRuF5p3/XL2dLBXjSSVeXAQhj7V5W9NFylzfv4lvWPAn9v0M2DcHY+lZ64WDj5QW/vEAqW9p9HC4OiNRSVBEYGglqDpUDdjkJKVN/OGsLrzH4/il0CRoEz578GqS1bDtpiNEnnrg3w93r4E8wPwipVva6FAfqu/gYicaRdDJlXdwMycjWyq+P30MMxG4q6dl3iFcmGNCusOjRMtJxSBOfnZ3kZ+0JGprFquchPLkYiRKtWUwlMHeHkwzUXKk+YaeENZwTb4QytRF7nYDEWS2WV7HdgveUh5fbzD2VOMGG00txYqncuL1O1KF0uSjj39jGn9Ek39azfrjCi383yOng/ol+jAiPkM5hCWNTMl9e9SxavQwC7o0BSuzUPId/kibI7nEpuQ/CSOZVDEOzdtRS1+KNOgSXRip6MMxM4DCheb0HBzUnWxxQdJ9M7Bg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PFffJk7S0LeJDx6rr6n4Lpu+HGUQ3yAfxF96HSWnqjzpvKt+QqaXlKOFVseY?=
 =?us-ascii?Q?KhXk8xen6L3FBTSBYCjVTkI7hKfgzGcUiTQlJQMN/Hy3sydN0xxUPNpZZROI?=
 =?us-ascii?Q?OUKkPyfWxB/IGcj4O5jGrMGfWy1q+T2Z6Q3WNGYSAxdw68QbZw0BSNSvIMYZ?=
 =?us-ascii?Q?cjnAtB7evjaR5qWr4z6snSmH0rolsd/xxU1S88vDYzgB58O7HjlnLGiSLN8j?=
 =?us-ascii?Q?EqVaCkfSxcZqho5w2+r+2V/1RDz/KULmj1HXHxmyKfy75IrYnWYWFS8cNQuh?=
 =?us-ascii?Q?A23N8wt777iNU8PM6ZO9WWj5g57SkYFH8QdFYTnFTlSLHUegBwAI47tmpqls?=
 =?us-ascii?Q?m5NHpsfLwFXRwqwSP0RYHNpn9ts/QrZSy0uXFhO4zgtOBRoy34h8p8Kd1RKS?=
 =?us-ascii?Q?FGjhk26ei1sWlr7/I0ETjOYiuUYw4RdT/doM3rFeRQjL7fpt50MhEwWMOVnm?=
 =?us-ascii?Q?gGUlk6wtxl6s2RCnRDAt2Bc+0/jQyqANGtCAf3jeTsulgEYWQxECQig5CKCT?=
 =?us-ascii?Q?CEfCQd1/8naS66jvKizVVd+GQFTABBm6ZImuJv2NQ7HVs/NRjRGLJ09nFmxh?=
 =?us-ascii?Q?5it48X45e5qkoYBk6m2Pyn00j+W74e+n0gneCEHRy/dKAOEBTHWX2plQMxh+?=
 =?us-ascii?Q?o2OJAGi/Dim0enA1jHfEbxo2/B+2NAAnme4+lT2Bsm66gu8nSG4F+6hZzVQw?=
 =?us-ascii?Q?9IKA9jGJyd6QnAJb1JzHkgprB1pKWY0gVSOgXm8zubf7/iiSesX+u9J7vci4?=
 =?us-ascii?Q?bbZZSqgkWnJDK5pW2B9m0k/AfsDq9rsg3TYrQil89/YJ6Xv/BxEEejH5hRZR?=
 =?us-ascii?Q?fES6mHq5mbYkZ0kpVzbXtS3OClpG2Fst7J4QFrdCnaJ1FMS48rEjVM8aG+me?=
 =?us-ascii?Q?rDWqkEhIX8949ITClhSQfL6wIldfatJ6VRMTb94iwmCPYpKs5KoO+WbLL4pg?=
 =?us-ascii?Q?NTD2625jtlVK9c8KHcPplJTqtrdf4l/7OZrE8xW4hIOtgXi74vFSzWsLvdi1?=
 =?us-ascii?Q?6Z6EaAqpJhu40jeqZd2RWSzgCW7lx1lXjdL7bnrXFgsmNftsrzl6hhxD+YRN?=
 =?us-ascii?Q?xEqEwZ95rBeAigbNSsT/yAaroc54uCzXGsrxaXMr1DTf7LWo4ISUzp0g2Nf9?=
 =?us-ascii?Q?k1YXF8AprRKtiQlA6D2K9A74YDh90Qt79YCSOEFIVhunDY7bLSYyujJnRnB+?=
 =?us-ascii?Q?k6zR2lNQYi33mU1nIFfIh70PIJ6geWAQkOBgtbGmTJMSSBr8qVsMxWQJHfMx?=
 =?us-ascii?Q?cFRalLeimXiDVIlFinC4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5918865c-4fc1-4389-33c3-08dc6ca14165
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 01:18:22.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6964

Due to the design, Sophgo SG2042 use an external MCU to provide
hardware information, thermal information and reset control.

Add bindings for this monitor device.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
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
2.45.0


