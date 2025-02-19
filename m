Return-Path: <linux-kernel+bounces-521606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0907A3BFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE79A173CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218F1EEA54;
	Wed, 19 Feb 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q3HCftJf"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105331EB5CF;
	Wed, 19 Feb 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971517; cv=fail; b=eSH1BilN3KiTt4TeTw4Yr70NHijRUYcWPKNMEHB9kq9v6gUnen9UWXAagAbAHJREeG21VYPqCgv51crShF2sTQN7qbai5avS+9W7fzQ1j2IffaqKYN0MjqXhMAfEyd4uN0ifZfo8LBp8hpjgTuszhhIONo9MJgD5AzFt3fO+KiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971517; c=relaxed/simple;
	bh=xIgw2+eL8ODswzKm6W5fB/BXnzUktpNZoWPzfbe1qTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1lfHWUGwlfTxEhVVqp3s922bjib0V+CKIsvTw5P3icvAxgcEv8Rd/gr8PtgwJTLRrHVxAWwbs0dzyVK/PEM+kQfCxBW/69R+35p2UjQSsII0jV0l5sNvM1X6hal6eYk3gb/pRFBz5rOV4WYs1r1ybDRQ5SDDp+WDZbhLz8URro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q3HCftJf; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3fYUKxmlAmonPWIeAdMzw3sOOUvuSAOeJLR6foKyk85kApIPGRk9roFiOBdMhbpvd4T30c123nHOjyM0yAHHxuYg378pnPAddghBF/igt8WyBQ/Cem8Do5WEtDFpekSqhGbEMmOI2jdaXnkgEMdpSPN1rysmeflS1136iWZ4FulAxvDHYsXon7/4Bc+169OT9gGL+ZKjQBUgGLDS9E7PJuLQwgtuNbUiz+OTFW0wojs7TC71igC+KWdcMTdEqOZBPbdjO1lCRsGILRFyIo9FR9cOok2KJoeainR8YwBs9l4wj5Qr+SYwDxc/ghKeLG5XQN19fJcmR5pGQ+QcrPDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/XGQLfUCI0PztX2Lwl607VDPtxV3dWv1OLmp4kurYw=;
 b=y6AI11JpLXei+2bO9c6G1afCd7MBjRODS9mJGun7xpk86MyHZh0Y4iPd5uVuBYUSQEbZIW20fijS0lVaayBXljUTVnah9DzPj/iJoRpYt1HEIQmRIak7eJgqhubv4UpJ2W/uNg9Ia/Lo+aF9kZEg0RSqz89CPm5hFOFlR1MYmyTxaQwf9ivTvi29fFfn4VKnjSJDtz9zmeyoeShUNVqsMHOtnsxnX0eunx9ohxKXbT/zMxG0YUiMGXgIClG0+oZfzqlByGvxZvoN/s0ZKRuQMlie8lYwgOtcrSft081NBUD5CuaXaJj362yo7bHFH9T0+ZHSIVxlz3Xb7vtaRjrE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/XGQLfUCI0PztX2Lwl607VDPtxV3dWv1OLmp4kurYw=;
 b=Q3HCftJfGlo7EzWzHh39eJfXWto4vyzEQwxf658QnxRiFsVRSZNscOnDxa/0LxJ4VWaBllMCQXzOH7w3DMOP7Fc1fuaHyWF+BSMH0T6JxtmmfcIeG/tx4JHQjiedw4P47JJiJmmCUGMaEG4v3fOd2AHgdl3+k1FYlfmJealu45F0+35G+AD7t5b11ZTwclmzt0eOnwwQ5rXkpX7AqR+CjTTNF8eIm08JtMfO3Y65M6/VfHj9VcYZTgNrlsrflmK3+GNe1l7+VUllT4fDGPqrvCXHagkN0gXPaTogPpB6OGBkB2/es1nod1Ob2aSPghorRgHFTNObVPfaw9FEPnt5iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 19 Feb
 2025 13:25:12 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%2]) with mapi id 15.20.8398.021; Wed, 19 Feb 2025
 13:25:12 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v2 3/3] dt-bindings: hwmon: emc2305: Add YAML binding documentation for emc2305 driver
Date: Wed, 19 Feb 2025 15:32:21 +0200
Message-Id: <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
References: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:208:239::16) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fe2077-734c-4074-e1d9-08dd50e8d6b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5wLe5bmSU8WbWuJ/CpsulhpnZoajP8tqYrWCxPrzlMJGDf98cP1JLp23MH?=
 =?iso-8859-1?Q?UDj5pAZMNFOSsxIxReExpVmHe9nuMmeRn9Djy4bqx/if4qH2dyaPpmued5?=
 =?iso-8859-1?Q?xqNAd7PLmUxAyihrx97qvcvCIDFIg9XKIFDWKWDE/kPQ2AZVZY9WGR4Tki?=
 =?iso-8859-1?Q?6uOq5QRnvkk7t5Ey+Z74HA0qG5BDgYgwuYkAAecY40cj83a8quQS86kBZU?=
 =?iso-8859-1?Q?P8LsmDaJbL8Pj7VMTC/+5NCqBdUDFLvdM+cj2voc2AJnuhEGeSE5Vop0sD?=
 =?iso-8859-1?Q?Mv2u5HzrIO7Y5o4Bs7U1Ie7iSurFx8vak7dBurL7zHUoJxaBS2bFmJ0Ic4?=
 =?iso-8859-1?Q?gwS4u3U415ThyEgxr19jgg+lYHV2V598qkT//c1oYhAIAaM08M0DKfi1Xo?=
 =?iso-8859-1?Q?px+VtInAR7zvBJp6i2QvvBEFibUDJ1++bwD9pDhg2eIOQp9ZNZnh2n+PtE?=
 =?iso-8859-1?Q?9f5+usC/2Kavz7qkM9Z5G3rjq8fXNVECl6owFS0j/aSUVRusDcS6TFQugi?=
 =?iso-8859-1?Q?HoCeUrkBCrQRnbkBNIdYjlqSQaG/mYYZ+gWtGKH5WvxbpD4vXMP02T0ya2?=
 =?iso-8859-1?Q?KFDeDQn2sxKHoXGpMS2hix7dcd21LxZBeDVG0of39v0JNdbw8CKpeBdU5F?=
 =?iso-8859-1?Q?W1ufAGtJjQaA5YiP13wIozW2/HJ3mJV3XDePyy7g4Gw03MDeT4K6q3G6Q1?=
 =?iso-8859-1?Q?Lvtoj5N5kPjbWSzUZvYxG4z1ZqtokKJBotisKupk4YZf+Zqyb+iHEjkolh?=
 =?iso-8859-1?Q?9pBWm3X3bGubbQnmGsoMvmEdv0v+6048lxdXSb8VWCaIjZz5UF/RbusMGX?=
 =?iso-8859-1?Q?DiKuwfHbv/BvnKqY1RyXYtMeLCKxP4NYErikUg+jHdnhUN79g4nZ+GItCg?=
 =?iso-8859-1?Q?y3cBazkFnWgBklpmL+K75W6v9jBYCRgnpwVgwcZMbr2FmVTOz47IaAiGMC?=
 =?iso-8859-1?Q?GpMr7//R6rsuPY0wzDkrYVzrXcXl8LbRHK/jc7/ujF0SkMf5I2QTMhKPRY?=
 =?iso-8859-1?Q?klK9lT9eQ8aJKJuRhoDnc+PE4FZaPUeE8+Wyr6JtUqeSa1lfoXFxJjnpuB?=
 =?iso-8859-1?Q?Ct7imjRYC+RYd27aIg9CHIwbL+pVyC1ZzJp/evkB1bnY/hUmCpotH0MCPo?=
 =?iso-8859-1?Q?tDe3HnuamUZMxSRmdJzrbjHYdgT+iXqdYyLL5hgxWfrWKS4aTf3TKyoUeQ?=
 =?iso-8859-1?Q?6cPExXthiDa+r8PZig+OdiU/DTf9lSLufwxIRDwkwxsskjsbgF9yZGhRmx?=
 =?iso-8859-1?Q?nATyqnY3y96FvOm3g+/78+h/6CLJqDQbI4uTp1PckRmKHZJvCsPqLJe5qO?=
 =?iso-8859-1?Q?OAUUixVdhwqGMHWT1wFQgdl/fATRrKLpJv7vrAY9G1ha2ivb/BytOF9G5G?=
 =?iso-8859-1?Q?qtxgm2PBpQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1OAiZWYpyNZO4ZD3fCv6Afq2Yfg7MyJrhaAS1b+l2toSUAmjVHy4WKh/N5?=
 =?iso-8859-1?Q?kufY8Uv4xRNZIi+LjO1hq3l2X4fbfRp7ioYfZKielxoHXC4PgT8Kg2Ud0v?=
 =?iso-8859-1?Q?FYf/s5l1+uhMT/VpYj9rAiYvduAHSxaG1jYMSiNFLOUOf1SUPHIY278igB?=
 =?iso-8859-1?Q?VxeLs6oGhj1I60CE/s6s0rCj6jHRWxJLgj9sf0G7Hjeb3QZ5SSapQS5pQs?=
 =?iso-8859-1?Q?R/+54jZ7JMCUTHOng/SseYde3Un8KqrA9pYj6Y+ir5g9CCdHXYrtyc2Riv?=
 =?iso-8859-1?Q?3uQh7rUBa1ZCb9vIg5A1WKHzYIBj+BQUWtSmluGSAHgGqMdvIKFzIRi5RG?=
 =?iso-8859-1?Q?p/VYKEFco0B150+ApQoRKD7kOIu90w1ZtszN5ptLuyCJlaJZMYZae5DWUd?=
 =?iso-8859-1?Q?dTsKn891pvgBcXoeUWxGiUjDhUlQaSHESLn6MdJOIoFTlquqM+nOrEuoMX?=
 =?iso-8859-1?Q?7E3Y0hg/P9DhiOIQmj1tr6kT1l4M19TZWcq9hSu38Bc7605+/l+0W+kij+?=
 =?iso-8859-1?Q?y2j6OC80kcSjdLB/ifN6jK6og14HH0BZ+wEWydVcVC2HIA6PN56eyfzP1l?=
 =?iso-8859-1?Q?eNhXueNNzXz7lieowx70Um0gNVmpu0ZT5/pJRh/GpivWnaysVrJ4LUjeps?=
 =?iso-8859-1?Q?FPFVKTQFfE6QOrAZi3pdHhu5WPyKwipHldfO+Rb7jJWh17GcGJotWJmOvz?=
 =?iso-8859-1?Q?TOcR6e/GaSFS/PVnwuoourCHYljo5LrmQm4z7iiUlwquhhFVaEfu8yq/ig?=
 =?iso-8859-1?Q?qgJiSrSwhA+segBU+XN2wu6FbWZXgMqHb/etgiYbTy3h87E7Q1zQEI/D9w?=
 =?iso-8859-1?Q?gYtt+/1gzBuXGqMvHQVEYcLjNZaHSuPt7uoosFIvV56wqNLG2I+Rm7oXs3?=
 =?iso-8859-1?Q?+IUtRP0MDpjCygyju+xfCV7bphFq7TYbRkgrkp+eKTyu9t7MPyTvQc498k?=
 =?iso-8859-1?Q?kdNstqx6AYBC/js1l/tgHSbpom0lK4O05k4nzF+mhlZht3X4DdcWaTPvrd?=
 =?iso-8859-1?Q?HFH5PKR76nOeszqUI/1eztjB/D/NHMW7dUBYNz3Sk8akGakbirznP0awcG?=
 =?iso-8859-1?Q?7c2Pz+2JLGT5Eapt3GYQBMmt8OO9mjSx7z2rUYtCYyBW3Xp0CzMJHSP4XO?=
 =?iso-8859-1?Q?+QS+hDXUtmdeSO80vw1/fCwGOuMpHEg47L+Vj0+ziHPATLMB410Z/AqT54?=
 =?iso-8859-1?Q?aq8b9GZ/i2dl5FvzyX3phj7vJq6wQd0A95A0+Uvv1EoWsHrXGQq8Aofg9X?=
 =?iso-8859-1?Q?BD2lRkhSScuN57EUH9GHRiTQ9aoKAfLCXj6+Q75O08u5HeisTBqcWilmqT?=
 =?iso-8859-1?Q?wuz7YfdNV+6pobeOmF0KoSLU8M2sQlNWnzwIAf/aDQmmbXCEn8E7yqPzVw?=
 =?iso-8859-1?Q?thq2y5OOuk/cHlgc4yVA7pemEM6dW4om3krB0s+I1e5QU2ZMDK1FeheYNP?=
 =?iso-8859-1?Q?oRh0SzIOIGQ84o2Qj1tvI2FVTModrunilb59AqJ4SUZLK98UZt4knbVF7U?=
 =?iso-8859-1?Q?hVitziECbHHu1QcgRqIPQXORRiyDVzBiAIqpo4WGXcWxblW8CC+HpktWmv?=
 =?iso-8859-1?Q?X79FBHJgphCnp9cZqmmp4EmI0D1UchQTQ+KIQ9vbw8pZssU9XAwyZt0sRx?=
 =?iso-8859-1?Q?An4L0mDMrPh7S+CzEjinHp0eWCbZZGH2ZwDP91eaOVO8hsYwSZzCWZ5Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fe2077-734c-4074-e1d9-08dd50e8d6b4
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:25:12.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN3bLgK1m6JUy4WKaL4kKZxxnw1oa+jhKnNS8WkuZeRDqYI3b9sxOrVOAsWfEvwAiXXTX7q7IpdZT4VbyTJbrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841

From: Florin Leotescu <florin.leotescu@nxp.com>

Add yaml-based Device Tree bindings documentation for emc2305 driver
The file provides the necessary structure, configuration
and other parameters for Device Tree definition.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 .../devicetree/bindings/hwmon/emc2305.yaml    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/emc2305.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/emc2305.yaml b/Documentation/devicetree/bindings/hwmon/emc2305.yaml
new file mode 100644
index 000000000000..51e2a82d8f25
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/emc2305.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/emc2305.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EMC2305 i2c pwm fan controller
+
+maintainers:
+  - Michael Shych <michaelsh@nvidia.com>
+
+description: |
+  The driver implements support for Microchip EMC2301/2/3/5 PWM Fan Controller.
+  The EMC2301 Fan Controller supports only one controlled PWM fan channel.
+  The EMC2305 Fan Controller supports up to 5 independently
+  controlled PWM fan drives.
+
+properties:
+  compatible:
+    enum:
+      - hwmon,emc2301
+      - hwmon,emc2302
+      - hwmon,emc2303
+      - hwmon,emc2305
+
+  reg:
+    description: I2C address of the emc2305 device
+
+  pwm_output:
+    description: "PWM output type Push-Pull/ Open Drain"
+    maxItems: 1
+
+  pwm_polarity:
+    description: "PWM polarity"
+    maxItems: 1
+
+  '#cooling-cells':
+    description: "cooling state range"
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal_zones {
+        a55-thermal {
+                trips {
+                        atrip0: trip0 {
+                                temperature = <55000>;
+                                hysteresis = <2000>;
+                                type = "active";
+                        };
+
+                        atrip1: trip1 {
+                                temperature = <65000>;
+                                hysteresis = <2000>;
+                                type = "active";
+                        };
+
+                        atrip2: trip2 {
+                                temperature = <75000>;
+                                hysteresis = <2000>;
+                                type = "active";
+                        };
+                };
+
+                cooling-maps {
+                        map1 {
+                                trip = <&atrip0>;
+                                cooling-device = <&emc2301 4 6>;
+                        };
+
+                        map2 {
+                                trip = <&atrip1>;
+                                cooling-device = <&emc2301 6 8>;
+                        };
+
+                        map3 {
+                                trip = <&atrip2>;
+                                cooling-device = <&emc2301 8 10>;
+                        };
+                };
+        };
+
+    }
+    emc2301: pwm@2f {
+       compatible = "hwmon,emc2301";
+       reg = <0x2f>;
+       #cooling-cells = <2>;
+       pwm_output = <0x1>;
+       pwm_polarity = <0x1>;
+    };
-- 
2.34.1


