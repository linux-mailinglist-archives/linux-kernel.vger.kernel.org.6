Return-Path: <linux-kernel+bounces-374764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47E9A6F97
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C771F2659D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B981D0174;
	Mon, 21 Oct 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oqv6kKrk"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7743173;
	Mon, 21 Oct 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528500; cv=fail; b=u1sBB7kB1Y5oC8K8zcZdsMVBdkcgoGnSx0CyKoApsCnK3tJPwhy7RU3I7YCKstH/jrPN7eAo2+FoxbtJujclaQgq4s3hTKTqKqoczr58Tr8sbFyg1tdh51cov6jPWOpYkqAdXYqqIH77FzLv9wB2QU/m71NkZkmPYOPKvB837ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528500; c=relaxed/simple;
	bh=4s9o70erAfz174yHpp6HWKiDNkjuMzUKepKXz2HneSg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=idXOUNEnwDNCb7l7MqZLRkiFiO9j3Ij2hRm5D1QCwhb5eoy5CssfZpq5Uxnho7rE01YjSCQ8TyI7YYJalQwebNcj9JJaPa+uUhNaHfhNyJl3MdQQNaCfeVBHK2V8gw9Kt1cWDK79XY13X0wNLdyKaQApyb7Y2rHW661C9v6sqJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oqv6kKrk; arc=fail smtp.client-ip=40.107.241.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxPZxveLhkwOgwAHKLpUT8YdLZOOWCCbhUSQzZGAJiUzmW1GYGfNsqSvY2AErvC36SACtErEBx54+O3mpi4j8L4grefMmbsKMylFTFElSjJPy98COx3l5oPkmnR58BTa6GdATUziqROXf6+Kg+W3egdxy7xT2R/owj8SLbbej3ZVALP1yvUmZTk14BO69d5ZKLS+9CFU/7ITY1pzoan96YEoDIf66JvxX8n85I3iyLyHF9Si5tyCv/RAdGPogpO4oRJWubekJBa/kh9Xyu4oc6S7zNAstuiNTZWeO8rUmiaiIYxJ1fc+CTru+bwIwN0SkpPGj3nwT6RKRVM+y9JzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcHGoM3FqiCfCWcqQZpVMOJR59KqkDnEKJCHq5TTO8s=;
 b=vnJndKmMDkQMY7b8WHS3BGeCGDAM8pMH47f3zKztKzWYZcQJib2Q3m98lPjYmKlZArhhPbSJLS2896rFVvxhRv3Vzs0W0bXJ2tXPr7GQxxDUlfvTiXhNowGC1oYTaq0Cls01WVoZwxQKS86cGFDOvuoV/iV5l3/PaoV686qroQExxP8R2WJ9QbqOKTSjvX2P/tiZ7xfiBCe9qndJDf70exFKiLBXJOVorpQ+b46dUug4P35ZAAOnn+brRQL7bVDZy+w48N/mO4JTI+K+coiyVuTUsGVF0F8XRIvT/0GpGPRKlXrv4bLeodkAr+Jr/VxOKkEdKTo9BOFCMqdhDLmtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcHGoM3FqiCfCWcqQZpVMOJR59KqkDnEKJCHq5TTO8s=;
 b=Oqv6kKrkOl2NqPcvjk85mJYjFyEA/MgUmPknQha56mzPM+Tp0b09V7pYaBXs/b8UGUO7MpZWbsxz2TwSdSySe6fhDglRvZx+8lddjRynIbOBan0Om0kfcCyZiBxLtJqrUo4dxYS+lYFGXlXV2NRIET82aSB0gw5Q1w7KitNq8z37cq/gSeZfUT1cQpeiA123vJ4AL0dFhvSzzkj86/L7BuaTHt2k5CVPs/uXWC/RwOOW9ERAOPjfXadwIRyrS6oBgvK361n/ukuloTBpvkPdgwymw7A6rfLgXvORtkmfKIr9QP672YgYTkhxbNk1tnS3Uky0nmgoUZKRo9xv3EDkng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:34:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:34:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 1/6] arm64: dts: imx8qxp-mek: add bluetooth audio codec
Date: Mon, 21 Oct 2024 12:34:32 -0400
Message-Id: <20241021163437.1007507-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 761c520e-ffc8-4338-f69f-08dcf1ee4a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KL8vw8V51p7AukcbfOQ9t5xxmAS+rleh5csG2fx0NnEFoM1shD+xZk6qLY5L?=
 =?us-ascii?Q?MLQT9mICy2RKab/HlZmktfioZ0txLDc4Kq+N6Qov4CDy2sHj5p95RCId7KR6?=
 =?us-ascii?Q?dvb6OzCC/VpwnuJU/YT31k37ZQy7MCYXhS6M0zQmcApNn6DaEZfyggElp/gB?=
 =?us-ascii?Q?XX02iOfYGWy4tQODOrtm8DkC4OYis+6u13Xkr4Ri0t3VyaVTfWe10YAukTBg?=
 =?us-ascii?Q?zC/jEe5RukzNUprCFCCAFp8a0uM7BGqCa6rxoD3d1cNnVv8S5lXOO2z1gaU1?=
 =?us-ascii?Q?ca477lu3B7Jx24+R+MQ727pSZOEYE0K81Cy7t3cSfhZV2DLDeNvrzWj7hqFv?=
 =?us-ascii?Q?i7JRZbWUqzJ0X+JwfegNouFpZkBIkuaTE0tuWINMR/l1lAGJSdT/3hqVkmcw?=
 =?us-ascii?Q?l4+NFcIg2wJ/HJLEPJJ5Vh3mX9BUnQTknBWtLjREsmRJupDah9b5gdvLjzLP?=
 =?us-ascii?Q?CdfgcKAx3jK7Js+CRI+OfmaQOZc3KVVVYpDEb/KPDOofSMUhDI4MJQeqNmwS?=
 =?us-ascii?Q?OKj0RQ8Q1ZPnfXb1H/epFac6Ffi6uFvbRuL9zWCmzrRTCXD/SM7vCU9N698B?=
 =?us-ascii?Q?uuTAX2ttn7Oy6qnjC0SgNHCmqxuqRsPYhpMwvMYNd95rYjmiLtGQxgS11uxr?=
 =?us-ascii?Q?W2d8YOrKWJiWWAb2kjc4nP5isK/z3pPWkodGQ8i2R/RKWODnWj+Hk4h3oXYd?=
 =?us-ascii?Q?q6alzg7iHW3UJFhv77u3EfGvFeti/MTQX59zbBlWqd4B3gN2Il5WYJXnXqg6?=
 =?us-ascii?Q?wF1hvqB+iP9pcOdzfIP09Qc7UnBegiXnPwJqIBLuynIVKLjrH/WoqTqM/d3P?=
 =?us-ascii?Q?IGtP2tyObqymwryCGdF+EPsiJmgOguNe59WhqTyCHGM57lO2CzJ2jtG8DhpM?=
 =?us-ascii?Q?l2GEd4Ttlf7wJT89xNSr4bzUMWT0JaWL0BC6824bODEjTemku1Ki1s2ME2Kt?=
 =?us-ascii?Q?i9cGYZnzwPyJ+xbMur7QKsBTw1rZXhim3f+TkulgUpc9OZmVK8WOTX+fujFs?=
 =?us-ascii?Q?UlOuTjuClZO90nLzHCZ3EYFIZv7bVGA3/2uEmsNkHB/YMS8MvKuCI7SycnE5?=
 =?us-ascii?Q?PDdTr7rJK0ybaMj3+hsP3Im/HGtmPHGsGN8uV8SMWd2toNoQ2Q9tfR3IJ7s4?=
 =?us-ascii?Q?jD9cDRXopLP1G0pw4GWZw70AyW78WJyZ7V9K6PXqyYREaAMOZnJd/I5FyaLD?=
 =?us-ascii?Q?KRLsX4JDiMeMYB1WulC5TClAeZtmP2m+BgnlmyGvMp/IyZT13SSIdLbdZuoy?=
 =?us-ascii?Q?gLj3zwiuU5lTOTjX/J6eaUAVxkDXaHZanZjIABVyJMbX0B5GZLWknwz16UXh?=
 =?us-ascii?Q?a6rwP9wdyfcQaSZMTND3HaFbhqyfplZg+IJNaAegXq440aVGPN2HVvo+6O/y?=
 =?us-ascii?Q?KdHR3hk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZsIYC2vZ2/9VW/39Ccelo9gM45Y3LXfDF8Rk4D7o/RbZvhDvbkeB3cNXGPK?=
 =?us-ascii?Q?B2W1aD/xjTrLZyRdDp6yI58T3P7YOZ6Z6jBRaqbS9RAzgRO5sZABvvSqd84D?=
 =?us-ascii?Q?1GwcI0ibJ7JaJv7h4YW0dLCx7P0rF/CtHNTpDtPs6u3Na047TsodSKoywaxc?=
 =?us-ascii?Q?tQsXkUdHZyYEY36ovyGeetSZl6lilBPOH5WccN70XDeVhBC3ZxpmPRBRNFx2?=
 =?us-ascii?Q?/PDFkCyRFeRd/iE0SlDNo+bWQOHRJSKhQzTrgsF9VL3EZg/SM5DHEj63jVOy?=
 =?us-ascii?Q?j+EJH16YA8m++Ya4OqV2c3ua3VeB6Z+rcDbbTCMQZnasqnGivaJmcfS6qIbx?=
 =?us-ascii?Q?vRtYjy6PNZW5CIlWB+uaYE/gQcFnA6Hf4Bt7L8JOAon2ZCL0ZOeDiRn1YjPZ?=
 =?us-ascii?Q?+4iExsYrncm4xuO54gXfV3+1UIGhGUSkznimttT/OJi1j3tCPu58JaQLxoT2?=
 =?us-ascii?Q?NCcziM48+Uq8CGKPkWvcggek0m+L71+9+ZuDrBkq8ttZO+a+yto643l95fKo?=
 =?us-ascii?Q?jDV27J/Av2EC1FV/iLFcHOp8wApZxEf6DcNVrrUwy7vj5T7ZvpCDgE4UpDGs?=
 =?us-ascii?Q?HzFRkecyUkZhP8H/XXmKG2JkcUyu71NAYfdvskWM4bHC0YPq1dd/pWMG+WeP?=
 =?us-ascii?Q?iC7Dj5wVk4BqxKlofsVQ/7Kz4Wb6qRjsc4gp7S9iK2neazHcvYb4G2El3P03?=
 =?us-ascii?Q?+xt9LWO7va4QXuYbk5eQmteSP31GcBZ1eK7HXv4lATzyKGx0PhbBUHLiIWm7?=
 =?us-ascii?Q?5Jb5AuUf6nwtRluAU3/LFNhVeAWbUbu+rFFZ+hZ3yLDyZupXuysDDr+3R+VA?=
 =?us-ascii?Q?V5/0qx0aWTarW/Snf7UAxpGjuswPCbqBbi2KzDQHmdHh9n6wHWRGiTAoTqUj?=
 =?us-ascii?Q?S6KnOaOKGCMqOYRpDX5SP29oYhcOMAIzr6/8HZhc2WTjplTsN9SnhMkd5I5t?=
 =?us-ascii?Q?rqHj6/1R9D/8ncswyka8irFP0HsG3txm4pd7ATeUrjO7f2O4aWQSVqj/vPBk?=
 =?us-ascii?Q?WjQnvi3rmCLGZgRpoUKekHrn6cmwM1ECKDejIAJcvV/udVAtu4xs17jiwSzA?=
 =?us-ascii?Q?VM3GDo1NJ0tPWOdyG+qv6YlZP2OSa9FsrMnZO8RIIceeG6vlOIzLv10RLPwZ?=
 =?us-ascii?Q?dnfj89u/KmKHnBQvo01TutnFShptVgyj6UiIuooRhFlkphN/w9keoDO1q3qW?=
 =?us-ascii?Q?hEOjvRIZVsRrrY6ti9Xgkjqof+NvptzCJOVt71FtLDzWIWZCcsFDllvLMny4?=
 =?us-ascii?Q?b9KEQkYgJ6eesBlvHy8lAvZr/CalOlsx8axaeBNo8uFeXvPAES3qq9j0SFSK?=
 =?us-ascii?Q?7kkyA0SL8CgFWLawgzo96Mf3jNdxCyORuwgRRC7z/+426MWp4aGRZEQVd0j7?=
 =?us-ascii?Q?JIyRj2ijI5+xU2NWCDmUE7d5DCzE9JVrXNULht/kQvWX3wNu0Dp1nc8tjlZC?=
 =?us-ascii?Q?/Hp5dIYG4wZdPmOeYnjMr9P+OVU035b7hlugbWyxJjW/0qJ+zt4hx0MFkaoh?=
 =?us-ascii?Q?ejsMGO3tBdGsT9eWiRLu0LMh8L8ajA6Y4llbds3d6rwpphRQ5Ofn/QgepVBn?=
 =?us-ascii?Q?8a4WvPc0ePn8XhNPRWI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761c520e-ffc8-4338-f69f-08dcf1ee4a35
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:34:53.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnJqJFpKVrVrjpDSLrUYHZR8fgnTKjRXJ1CxEhiSsL8GTbaGevjhFhj3zszlJNapwOKrpDLtkQX3Lb8BnKCFHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

Add bluetooth audio codec.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
-none
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac7..d8d9e2883caf7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -12,6 +12,11 @@ / {
 	model = "Freescale i.MX8QXP MEK";
 	compatible = "fsl,imx8qxp-mek", "fsl,imx8qxp";
 
+	bt_sco_codec: audio-codec-bt {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
 	chosen {
 		stdout-path = &lpuart0;
 	};
@@ -45,6 +50,25 @@ usb3_data_ss: endpoint {
 		};
 	};
 
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,bitclock-master = <&btcpu>;
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,name = "bt-sco-audio";
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+
+		btcpu: simple-audio-card,cpu {
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+			sound-dai = <&sai0>;
+		};
+	};
+
 	sound-wm8960 {
 		compatible = "fsl,imx-audio-wm8960";
 		model = "wm8960-audio";
-- 
2.34.1


