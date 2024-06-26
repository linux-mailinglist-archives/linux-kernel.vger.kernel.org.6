Return-Path: <linux-kernel+bounces-231108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572E918645
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A254286AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9018EFD7;
	Wed, 26 Jun 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="RDqCEx7Z"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2114.outbound.protection.outlook.com [40.107.212.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447718E767;
	Wed, 26 Jun 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417205; cv=fail; b=pYgoV/OpbSpt0AVT99BJ8Tz2fO/b3pKG8lmTcMz/I8KJ2ga7pO6xug2I4enE5GKkUdHB+Kvf6GUdcOM1bthrs0l4cLApcljhN1DN754/oGn+xfRRfVuEuVf2ULTIrh21ITpfXW2h51I0CgEQ9Dm55aWtsPNmp2APfCB8XBAg2Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417205; c=relaxed/simple;
	bh=j3jxeSYU4oHxNQfxt6Cx5KPFeIz/pKq/Xop72ejnH9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pjBrd0Dw9Bw+0wigcu8o6m7LjqugXINJBfRWfVBumfYdOijCOg0fbOHtbQRgGdC5+bmqpDtj1LUJ4b5ehmpvZEgrHwU3DFHQuc7MTBrn0nHMiCglsnHxqv1a48mDTT4gtsWI3KXVUXW6NSLqYI2aO8X0AYSZifAlnPDwmsNQfxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=RDqCEx7Z; arc=fail smtp.client-ip=40.107.212.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWw8LKI2mRZzEt5ccAj706xHGT1X8z5L35aM/azmgB7K0ErJ/uya6nStomeNc9Kq2a0kItCtJW/oHmYblu4qFJmAcpMNMoGWm5BDn1K6PnPcMRDNQ5mDKU7fsI3/GkUETeP1FA4F6EHFRMrUaq2YCX85TdhUwjJlYCUt8djO1PXUJCnSMxAmTK4zYQd7ziwIwgJNSipvvmW38HAzBGCvHLhPVkg2YRMz0I0KwHaBj8gIkbmK1Ym1moipEpQFIYZNBaHo0cduTZsNImm6Seg8jHZUdG/2/Fz0tWsi6reeW0y6JBCcEH5VtJkc+kM2IVQmSL4q4t1O0fihDwRPJkSCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GzxWTZAlaE9sSZPFpOubY3prboiJdxPooethzp3Aa0=;
 b=iA1+dOSQ5xZjzqVV/GvY4vkd2tpHbYjjdGG7yKxjSA1QJzlpppZoD3Lf5w5v4M9prvA20KeT9skjPybjcy0bPBkhG1jBIUFiLf0Dqx/7bsCxXsDbV8eVLWVoZ3ONt8mlLVxEjG3yxPZyTY/HGusOkGaYK+bdj7EYBE/EyI4sWs7zsAbUmWvQvzbP7IEsgnqkS6v0ZpTrijDotTaz94j9aAHKxDTngULeClFbqN3K+yroGUigolbGsM7DSc1L+INX/o3GnFdH80UwwppHyUSabJhvSOFgJc0dT3NjY9LeDJAtOHCPTzL3bcTLcfvxRFLZ16LJQALyDzpxTKpfbhS4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GzxWTZAlaE9sSZPFpOubY3prboiJdxPooethzp3Aa0=;
 b=RDqCEx7Za3lM+hYVv+Ka6G55KQ6LXDmLO3uCUTOkKnsSl1hIG6KSTH3ST3LcHTrvS/Peo3WZVRTmUGqYr5iZebjqwKecX0BLLOXfSlwU2gKyucJUzUvGVdpiyc3i3UCMwBrAlhQrICteN2PAuEspZdrUQ9S3NqK6xqTO/p2cs1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by IA0PR22MB4564.namprd22.prod.outlook.com (2603:10b6:208:48f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:53:13 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:53:13 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-am62a: Enable AUDIO_REFCLKx
Date: Wed, 26 Jun 2024 08:52:41 -0700
Message-Id: <20240626155244.3311436-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:33::35) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|IA0PR22MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fcb343-72f3-40ec-4f35-08dc95f815fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|1800799022|52116012|376012|7416012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g4n9QAYVzwY8lyE489KoTYQ+jDbTzCvQuoEdr/lp+tJDsNKpCT/dvEZv4dgd?=
 =?us-ascii?Q?eFjuFsEVFPmk0RobTvIMkpzKct+PK+/ysBBpdNToPRFOOhAwnSUnQxcGkWXQ?=
 =?us-ascii?Q?2sZfGnytJR65uIyP0f21pCqZrES4bX66muKTLBmUCOcQFWWsxXRRcyVprldK?=
 =?us-ascii?Q?KqaPg9HFAU6SYbDjgInCi1QUIC4Sn3MAXZqaDT/kK8lmMXF9H2C2LDT04lcd?=
 =?us-ascii?Q?uLn5PP0v0zwLH2pQlRiyTRw52n3fFr5xgsiAtkVlGhaxJ/z8rIxYA3qvDxqC?=
 =?us-ascii?Q?97E44keSySnswDUKW7aCm3QHXtS6FCM6Dp1dnU86RfqrmEINtnZIGLBaiZwT?=
 =?us-ascii?Q?04Uv7DCkGz1Dff4HbvKBKj31lNqsOLwzWdBsTCNLv0QtSLot4CMB1sqD8GhT?=
 =?us-ascii?Q?eA2loMPFexEanZozueen2GTzR6t1YysuiWELazljzwlp8wGol/5wt06TffJy?=
 =?us-ascii?Q?jBlNBWkWEEJej+xWhwVHCmwsqo2WtNJ7wP11TCBEj1W0V7U6jQ6aYZ8sReBZ?=
 =?us-ascii?Q?RKj8eWE4W/jgI+nl5udB/SVhUs6L84Y4LhXFyoYuq/oVpzxuhd75pAyTMyD8?=
 =?us-ascii?Q?7S4LoMMxnixhhqi6VJ0lgUn4MOqxU1an7iPqzHv+3+Pgfp7V393tG0dvhvv9?=
 =?us-ascii?Q?BBVOs5/yBm8iKJ+DUFe3I04d9v/KiTapC/S/Z/UKg8rFHoroBBqreaucFX1M?=
 =?us-ascii?Q?Ao95D66lnYTCFnOGahNIujhkj25eBVVlDeVum6cEXVVqothC6JqsECRNRocE?=
 =?us-ascii?Q?MJ4bLu9eY1x9zd6mM2rt7erO0jg3kFVLi4ibi94hzYF4S1OL/s52zJVgc3Ji?=
 =?us-ascii?Q?ZBAa205Ez+wLlvgXumf0lC0hvH5ObkdknAcixOhh69TGDwzhYRMVUxLAwGtI?=
 =?us-ascii?Q?PyUgc7ZLRzF2f7pafB0GLHgDfi6zaJAgqYXYC072D9lepSc9EOSff1Rmlh/G?=
 =?us-ascii?Q?srvhUha9yjpw4VpFIZRB2IDK7Xkv/jmrXifBiqWbEIu25Ky99WF8HV9v3QJo?=
 =?us-ascii?Q?bZOj36sZYYDpWVUPQeGhS5Yk6zOAF7DYtUv6RaQs2fxf4bKXhcOaqWA6ENSx?=
 =?us-ascii?Q?Ahj1c2M8273FOeu9LcAUE479F6XRWbZDLc8H6rGRVVir1jfw8drSMWCNaUal?=
 =?us-ascii?Q?un1xrSc4rZFrJXVlrfiN9WSyamKmvY2GpMQPNJsaFpHuxylKj/m4Cg4uLfFJ?=
 =?us-ascii?Q?koEZR2lWphpmCz8JWTpxxqxEljUkJAMJq2mKT7kFdWRDx1lUQrdD4arftDTx?=
 =?us-ascii?Q?iwKw3Ut5B5wH343A/3telzhxvgZq5BNZSe4CLjESvLfgGxavevViEOvjLnG5?=
 =?us-ascii?Q?sZNYfDAQeHb7vUoXQnhRkDrw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(52116012)(376012)(7416012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MbwmENupOtpbaNgdJIuDgJWhjJEhtw+b+WdHYyaXoo9SYz/X2IRG9Ee8D64m?=
 =?us-ascii?Q?vr/Rktf3Bj+I4B8jQP1eY97iYxMtJylD/zUnc4u/qYKkvR84P3YzWzGdrhaB?=
 =?us-ascii?Q?oT3X4IW3yu5CE27o9++Jm03MSvZlDtyy3Q/+jZxekawL4YNlxEeUxCcaI5Pe?=
 =?us-ascii?Q?waIUc5AQ2OtN9jYzj/M6/zpwtO/I0abpp+mmU3BFIi6lcIqKRbhMn2LZ5xWP?=
 =?us-ascii?Q?t2slkBy14yZcMOr81+y0yrWmTuXV/cqb2b51zg4OkqqeYn/jBbmG1q/6cHNP?=
 =?us-ascii?Q?J2WTXbo/6cXbyyN39wyTTDANIJ7Lzop7hxN1qolghvoFDhXvMpf9dZM231ml?=
 =?us-ascii?Q?CkkBbTLq3QblYITZFCynDLzouSh+wNU27sheqFB38vmJLUk3WXehHTN7jwdp?=
 =?us-ascii?Q?uVvadHEIudBUUAH7gL8jnsWLosmzmYAWIKl3taOzOwDMXiJ1dZ5Z+GjNGG7N?=
 =?us-ascii?Q?G+S5kxLcvXywzXBQMfY+j+jgZQRVDm8EXVIf0inqO55FfYqsTRdKNSsGr92Q?=
 =?us-ascii?Q?XjQOnEI1ekr4mc3xDIKr/7UCuWTPomCOhjk7V+/o0jYly8uPog+snO+d6/Bs?=
 =?us-ascii?Q?hGxoF+/Yeudppl0c5ZiQoFn55Dwlw0sn+nbGF0WVWsZ8p2kz8ztNOWLIThYS?=
 =?us-ascii?Q?L0JhcZVOQ/bZ1imPrpBQKC7oDI0hYWdlv1BLtBeajQJdGpujLbkZwZFV0DOL?=
 =?us-ascii?Q?vmFVWFfsgpdCcYYfE/XFnIDi3ZKoy2tBTRQFujl8tsiJfgtLBfWs4Pe9jB0f?=
 =?us-ascii?Q?ZEqGEm0nyt1z2ZxTFO5d5CF3PoLtonlP/75qU/+fnTtwdcNDQ/6qo/aQ2zLB?=
 =?us-ascii?Q?G8lBGosn5u9Wc76hcYkpJtY1xNhKIlO9Bs3XDb55xpski9rvJGqj61Z2Vn4C?=
 =?us-ascii?Q?w12GM8dnJoDUAm87hoxTpCNj2I7wpLtT42p2sZK9TX3fJnekN3AXr3IN9db0?=
 =?us-ascii?Q?aGEawugzvypfDJ4QDNiLCUMq2zDtZ6+um9nifB5QXpNfSaursBmlGTuBI5PV?=
 =?us-ascii?Q?8NLeU0WD8SxhGcFAy45dI1VDhVwyvZlQ9YxvTwq4DzdNS/qP3h1Hd5Rd5Jtm?=
 =?us-ascii?Q?50xXCNwKTkLEUe4vwItz3wCKNc/52Ev+a5Gfj2rjy4m0t8ceJqsKr+3fw2CC?=
 =?us-ascii?Q?onSwK5GKPTohcE9GQKc1BB7QfLq+9feZIlhlK0RxVXLg97hRgpZCBRKfCj07?=
 =?us-ascii?Q?+7/9vRxwf394lAg7RfnJ8ilkEC2cjrzS1KdLBGg++ULbHH/3a30mZvJG51iZ?=
 =?us-ascii?Q?RHUjQBwixWdh+vk/D6r3TSfXpB8yNVeExfbSYwyPi0qLqGo2eMmbkV5+Lick?=
 =?us-ascii?Q?f28F1CNgoqILubVTE6D3JCGWaS2flrY/CMw5m5OYTrWFD1eHazseM8k8hgmv?=
 =?us-ascii?Q?TlGNlq3ctWcZW3LjgS6pUWsbpnpxTEyrikr/UhIWNNU2OoNpxxokJAthR80K?=
 =?us-ascii?Q?4553RNaBurQVcAUNpmchV0LVvmBVDyXHPwnNw2QXbgYLxgHPjhY5B6vuoGB+?=
 =?us-ascii?Q?x3sp3/bzAsPWE05dsslU4b59hKOtxJyGr6mBms/TNM/vRfHpiG0XWzzP9DUk?=
 =?us-ascii?Q?sJ1AP3AENdAPkBa0168UEH1rsG4PLe6q5RRvOpND?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fcb343-72f3-40ec-4f35-08dc95f815fc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:53:13.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQhL+tImOEa5lxPg7pG+fcOrbfCmIYWMixraDkxXvjAj/ObcogYJ17qxgm/sL+3xu/8aYgA7XJEIR5OuE2qTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4564

On AM62a SoCs the AUDIO_REFCLKx clocks can be used as an input to
external peripherals when configured through CTRL_MMR, so add the
clock nodes.

Based on: Link: https://lore.kernel.org/lkml/20230807202159.13095-2-francesco@dolcini.it/
Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index bf9c2d9c6439..2a6e333f752c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -59,6 +59,24 @@ epwm_tbclk: clock-controller@4130 {
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
 		};
+
+		audio_refclk0: clock-controller@82e0 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e0 0x4>;
+			clocks = <&k3_clks 157 0>;
+			assigned-clocks = <&k3_clks 157 0>;
+			assigned-clock-parents = <&k3_clks 157 8>;
+			#clock-cells = <0>;
+		};
+
+		audio_refclk1: clock-controller@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 10>;
+			assigned-clocks = <&k3_clks 157 10>;
+			assigned-clock-parents = <&k3_clks 157 18>;
+			#clock-cells = <0>;
+		};
 	};
 
 	dmss: bus@48000000 {
-- 
2.25.1


