Return-Path: <linux-kernel+bounces-571419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36817A6BCE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1889D3AE629
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF61D5174;
	Fri, 21 Mar 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KhiBwaLy"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013058.outbound.protection.outlook.com [52.101.67.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B91A256B;
	Fri, 21 Mar 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567182; cv=fail; b=BfqMejTPw9zTADsfe5DJy0qU8amoMEG+KmPC2k994y1eHuLI/GnA4Md4bcWI++cqanGEy6lzGkW61q/L/o/WAXUK+BABUoiQlEW3bp3qhOhqE+P2IaFUNBldrGY9MC/QWhts+rcl3Ms4jlCtpw7J9W7Rp+I4ROiUIxE7sZVDyQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567182; c=relaxed/simple;
	bh=RM4MBW2zbYc1jov+hs9zc4VY32cBk2LU8gevGXTtNk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIcnnJcHnXwH41ISNnkMjk3rqzyrDHNCAxxyCVj3twFBLumiEjNrlHWQDA5jtbxiC9mnTsIaZL6OEb4HI+vs8f90P0SEeXJsjrdUgql0tCA1pQxN+Cye0kQ4f86gnF2sz5FdARRUANxWsHqIHyygQFfsS8qh6Uh60gJKS53t7KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KhiBwaLy; arc=fail smtp.client-ip=52.101.67.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vweuSy19zhXB7moN8bEO6fLrJn4txHEitrC+PdTuhFdtlDjzUZe8xNRDs6uqhvhbqp/NFSK3Fqk4PJTSmkZD9Gzg3UOiKiBxop9I08vARxOJp2bqGha18juT1eUv4lAmuXCrBOCaXJ39Ddt1j9/QksKGCnoxpf2CndR5sqW2EM5vpsaryt7h58kyxXFodQJqdtlbC+c7ZMzdqCCrBtYruTrTV+StJizpayy30l0eaFmm2l44i2fVx9bXrpcrq0J4rbSVSLnc6xjUkKtt8U+VypMqh8C2ciGPVaZcPzYNNzTQGQKjWhVTgMtAB4jgqmUKxVMPCgmFwtdh/dWWKn3jHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euIsLHK50RFyuBcXK/hsQhEU1GycWj5kdisBEF9DbGk=;
 b=AGgVVeJ2g8Qk+khYzz4a8OkS1ODTkRpJSnTQkFioS7NI5tum8OABIVoStT3RyTN0HfkfdEpWm1ZdaRISDxybwUg1o9NjcW+3S16KFcSAQh0XmNbJZrOaSfTjMTNr/oYE48eaPsLUr6bBKBa1SI0fYptZnlVl9HfQxJ3kHEPbUsVDLbBtfLmbRyb9zS2g945G4dZwD7PW1CAMY7ESaVtnjDJPNH4ri9ScngJn9doQU5cA3sIe2yLWzULq8UXKJ3ZQSh3EelmPCfwHh3cHc+0AFUQLCCw5gYjcclPK9cbNmKkL+76b9kwqhgDr/PWMGTjio1/JL79aVW/+h0+6DnTcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euIsLHK50RFyuBcXK/hsQhEU1GycWj5kdisBEF9DbGk=;
 b=KhiBwaLyVB4JSFQsoYdKIdE1qzMzLdcTy71zbM+IV7Y0cIxz38HcRZWJmtOa1YNeCdLA/I2/tCdoeE3JkbWqix/aq/mCuSKB6jQv5mV3SeB65FX2fwJYqQndkF9OJBLPdHGF0GuSW3mmoZ5oaWVC2RQkz9nkLqRGAnukPxw76Ckw+Xwx2UtzTUV1Q3e8DH+5OeuXIDdlie0ZuMwqKJSlFHGAUzu7s607dxg7AjexcGYueIOqlDpvIkHJ82mEXuhn1YjO9O/CtzTp1bhT7z3WcG/7HAsFP/O/IiMlHXZfqlW7zPqUTrvu/MCVvlI1VPC+boGVv2XvBCyCY1RbyZzElA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 14:26:16 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 14:26:16 +0000
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
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Date: Fri, 21 Mar 2025 16:33:06 +0200
Message-Id: <20250321143308.4008623-2-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
References: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::8) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bb48c6-47aa-458f-d7db-08dd688456de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?M3KxAy0RbF8kriUVD2QV5k/LqGBMYcn1LWitbRgXrCPsui8+LzyGZ1yDcg?=
 =?iso-8859-1?Q?6CIrc9BLeEUXUfOBCi8TOiOw/1oC7thjShCGzFdRQXmRWBFAIg4B2semar?=
 =?iso-8859-1?Q?6/KWu3AZlsJuoVnSxJwpGGRtAnUB3Uq1bYap3HkQdtY73GvMoYoZMgvKt3?=
 =?iso-8859-1?Q?9oma1uyN3ijiIM+C/aTFhe4htawFp9klSHESEybwL1spVw5mRPjoDe2C/k?=
 =?iso-8859-1?Q?EEAlEjkFssrHLfBd9SUsPJPf82TW5Ws4HvZGkaRgtVaVJi8qpriftuT6rs?=
 =?iso-8859-1?Q?y/XcOMcM4/dWkw0IwEoi26iPfkAbwi6COXvmp20lp8BU2IsWWM3rGOtRLU?=
 =?iso-8859-1?Q?80WQI/cbG4LFOECKUYXiigQ/5+7I8qzmONkAk9MxeLGqPQUnBFBTpK2lEZ?=
 =?iso-8859-1?Q?KJXt3h9zOnqvFAKeoPcLSTtj4HAw2WKU/KrRzdTiQuN+elUBmPUazprDt/?=
 =?iso-8859-1?Q?i6gzcNOltrlHgbmRZJUbkpC0hbFOC6hVeEBDkm9NiUYIp0DksarzBUrJ7T?=
 =?iso-8859-1?Q?fxhC+JhIHlyB7X7/CsztHIKyhD9yzcGrvcmVe0JMDxXkNBFAETsbmgAyIb?=
 =?iso-8859-1?Q?n6tdn1jdi3XWLZti+kQ3yhjaj+hUGp1nxzfP1sYTeXsem6O+C9rL0aS2Cg?=
 =?iso-8859-1?Q?G2LAki17xii2PqW0mLZoeAquRDTRe6H1xF6Y+8DnXhaRPuwqbPtj8ao2iy?=
 =?iso-8859-1?Q?n/gFvzHEhtL2tZc471GF6caWeO/KItoLuf4kUhRXkOCGhe33gWTvmnn+93?=
 =?iso-8859-1?Q?aYIQoE+gFVZ8NzxX8JmyGE8Xr3zuKsDT0G5RxVVs9IiPZDWPDj5aUBAB0Z?=
 =?iso-8859-1?Q?/XZKwLnytu2a4F09pSf4wuLpVASwqwsDyvZ4cvXfrOHTczW9CIt5Z+Qun7?=
 =?iso-8859-1?Q?fY37pw/1gLPOBwn3ZXgHvSYpD+nQEX/WHBIDgxwolLBnq9QlVtIjBKlKLb?=
 =?iso-8859-1?Q?pJZ8g4TZcv0IgNqZRiPsIC+KV6CVv7TjLaWAPedKwCG+x/Xa0bdYRl2J4/?=
 =?iso-8859-1?Q?wcCqYY96Q53Rf+/NU8vYcK/Os5NDm5KeQxyMqJOxa+GTQuLQgNjXyk5FSF?=
 =?iso-8859-1?Q?Weuvs3ILCDTCIAyUhPVlQ8A4NYq2ESnU1QbaBaO+ymbQYzoOn+v+B2FtfD?=
 =?iso-8859-1?Q?febHIRCj+lg9z9uW38c1PdVwlnYZy2TRWixvqbMbin0oIqjIQ3ClLYBB8s?=
 =?iso-8859-1?Q?9cbdTqjj0BHBJYKpcFleKbwzMKh1QrGTUBsHs2M88+EGiWBwb7mimYR1Xd?=
 =?iso-8859-1?Q?y9IZLfEypkpDKDTFIxFSDKxhxRMJnNUrqgK+M2GXbzU0x4w5Tcj7Avl7Hf?=
 =?iso-8859-1?Q?KKaovO2jQOm+Lt290UmMzfh370D3bpN5KuUpbN4JPaseoY12jFvzttGW1l?=
 =?iso-8859-1?Q?AVJZH7upWehdWPr7XNpk2Q0AZCAnutNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?5o5LIKMYwTUjVDfVRB5VYin4qiKDqkcL2dezHJdV2kT1DrHPTHgzn120T3?=
 =?iso-8859-1?Q?I5YELPz+Q3uCmCNjiaVhR4X6s4d1clb8n+liYt0ScSGu2l0jJ2OZTyOAld?=
 =?iso-8859-1?Q?JiDFSdgEQDfjeGL9WUTA3h0J8/p+SxURTASaISQaG2Rq1TJplisU8R+x4H?=
 =?iso-8859-1?Q?+Rg5zfK/QD5qjP6R+NVLunemaSbfEH7Ktx/ilhBwX0jqetIe0QU0vhAFJd?=
 =?iso-8859-1?Q?nfv7SFtwwzXG/AP4q7FQAcWAikf6xPt2LzpxLYn1kUkrKQAQrHRElhFID7?=
 =?iso-8859-1?Q?i403fPelr4iW5RG7Gfzo/7bU3oUYQRRmcY6DpaMhj55MFCen7P8+7grE0K?=
 =?iso-8859-1?Q?EI74x544DiDfRa6kjTMLfLPeu4UsNKQCh3d+zn0HRlEkXZnCZl3XcBHSNo?=
 =?iso-8859-1?Q?pqnxx+jfALPrN2dDeXTTB0bW47BCR374g9ehDSwkvPnGH0vfXU2f1AV2k4?=
 =?iso-8859-1?Q?2bq64UIZVng6WjHrnRiwdAQcHqCN9kB2iJamoCWitUjSjwjswAvwZoQGgC?=
 =?iso-8859-1?Q?HWQxADo/E7xF1z5cYuHKfIxrK744JqpsQGwimDn35aAT2lFAkPHSHQTpUq?=
 =?iso-8859-1?Q?Rly/2FS4+lKgUW9o3cex0Q8EROgEEERKt8fROkjw+vBjebUI/XhzaH8eXL?=
 =?iso-8859-1?Q?0u6L8tOv91hdUbPh4PkVNNfygf5c3U8fryDR8iYWfsqJdrJcsh83Q0V8Jx?=
 =?iso-8859-1?Q?kF9BULJ70NxGsZSWBcAhzaH9HrtVn4+pmWVVmcHk+10d4Y7YMojAYuFhYl?=
 =?iso-8859-1?Q?ps+P6qaBs7aA3QSYWh5xnstAaJG1bvGTxX6sx86fnOctMyUVLWltDv36gB?=
 =?iso-8859-1?Q?hGlTreD8pC/qKDNjJDP7bmHI0adHmyIZvWEtS3wGrl0/RY8sPUaCYyow+U?=
 =?iso-8859-1?Q?2+AxJ6YUMoETdXStmXuFNYS4OFX12i/dgLSqQwjEJweiCqUzXFXGH20ZTU?=
 =?iso-8859-1?Q?ucnQQn6MBnI9z+rb4uiSGiCTd9R5m3gtwLXX/KeOv8YPq8rVaICiSO0tCJ?=
 =?iso-8859-1?Q?wSBT+CXetrSjpZkzOVPbEhLqrC+WOCsZ9/ppKik2lfzHVhnQhf65YKRbCD?=
 =?iso-8859-1?Q?FfyIsC/j+h7Km+Vvk5puFX/jZwtLDixeOlnpM0ohfBUMYQ2tLwrKSv18q0?=
 =?iso-8859-1?Q?oELxxe7357gCaqZs4wOYwqMB8YotNsn2cmtUe/Kb4Eqi5wlpYdprbshfiJ?=
 =?iso-8859-1?Q?/4UFWypXWosIuFrM7kPf5wRjGy0e3P/btAP+8dsp5svdMyVv6Cl30vCbkd?=
 =?iso-8859-1?Q?wZ5cOVKUdd5Vbd5Eje+3is5mODBS2WQVD9TSl0kP2bSCntJzuvclaRbyn1?=
 =?iso-8859-1?Q?hKgBgIMzdoGI8wIRLNHfGnl6UjmH7dBFDJOAApSIB/0GzrT27++XEC7O0F?=
 =?iso-8859-1?Q?Ex6D1DNTJIqyMEvmnCwgZuYRsQ0AjHxyOd3GiHcPFbneWs5QtKl8PU4jsJ?=
 =?iso-8859-1?Q?STllccPn75Jr+7ULnT6Os1FWKxEXG1ptY4Xy0JV5JwfFB98kF2m/7lSteJ?=
 =?iso-8859-1?Q?+8n5iEbl4K1I9z+4RZF8nYyh5g+zFQiT4XmF7N2QD8DpeOwyV1weLpfA3Q?=
 =?iso-8859-1?Q?tEu+ngrDh7Ln/C94ri4PnRoHV//9wDbLqPgb4cy9nWRNkhzFrfVbYIz5kM?=
 =?iso-8859-1?Q?txuY565n6OaIVJ90qr73ttCN16VQIzlaEqPiZ5Cth0uFABTjZ13Eg7TA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bb48c6-47aa-458f-d7db-08dd688456de
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 14:26:16.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ839tTK9frpwtdmPkFQ8l5u/UtIuGwNz9oAvsnRLK65YnKhJmbpTci5/VW3ZAq9wped4QAsQyiN3cXsPj7DHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061

From: Florin Leotescu <florin.leotescu@nxp.com>

Introduce yaml schema for Microchip emc2305 pwm fan controller.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/hwmon/microchip,emc2305.yaml     | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
new file mode 100644
index 000000000000..79081c116274
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip EMC2305 SMBus compliant PWM fan controller
+
+maintainers:
+  - Michael Shych <michaelsh@nvidia.com>
+
+description:
+  Microchip EMC2301/2/3/5 pwm controller which supports
+  up to five programmable fan control circuits.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - microchip,emc2305
+      - items:
+          - enum:
+              - microchip,emc2303
+              - microchip,emc2302
+              - microchip,emc2301
+          - const: microchip,emc2305
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#pwm-cells':
+    const: 3
+    description: |
+      Number of cells in a PWM specifier.
+      - cell 0: The PWM frequency
+      - cell 1: The PWM polarity: 0 or PWM_POLARITY_INVERTED
+      - cell 2: The PWM output config:
+           - 0 (Open-Drain)
+           - 1 (Push-Pull)
+
+patternProperties:
+  '^fan@[0-4]$':
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    properties:
+      reg:
+        description:
+          The fan number used to determine the associated PWM channel.
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pwm/pwm.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fan_controller: fan-controller@2f {
+            compatible = "microchip,emc2305";
+            reg = <0x2f>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #pwm-cells = <3>;
+
+            fan@0 {
+                reg = <0x0>;
+                pwms = <&fan_controller 26000 PWM_POLARITY_INVERTED 1>;
+                #cooling-cells = <2>;
+            };
+
+            fan@1 {
+                reg = <0x1>;
+                pwms = <&fan_controller 26000 0 1>;
+                #cooling-cells = <2>;
+            };
+
+            fan@2 {
+                reg = <0x2>;
+                pwms = <&fan_controller 26000 0 1>;
+                #cooling-cells = <2>;
+            };
+
+            fan@3 {
+                reg = <0x3>;
+                pwms = <&fan_controller 26000 0 1>;
+                #cooling-cells = <2>;
+            };
+
+            fan@4 {
+                reg = <0x4>;
+                pwms = <&fan_controller 26000 0 1>;
+                #cooling-cells = <2>;
+            };
+        };
+    };
+...
-- 
2.34.1


