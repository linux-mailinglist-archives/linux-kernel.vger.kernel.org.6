Return-Path: <linux-kernel+bounces-363089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155C99BDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29717282178
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A1130E4A;
	Mon, 14 Oct 2024 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CkK1bDkl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A212E1CD;
	Mon, 14 Oct 2024 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872641; cv=fail; b=YYi8KO5CBlmCGRZGB+L73FE9rxnNieh/0R503ptlyuKWqN3NMwZQiW7JGzMy6PfTd87bC/RUxnydKU14BkYGsVRt0XAdztToS9EXM1xWrBxg4f/0BeVqYMyFeleTNjHppIa/9SQUqttsCUO7j05Tf1LXrBOTcHOZxkIbP2Fi304=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872641; c=relaxed/simple;
	bh=T9f3TE0nu3y1EO7KYr+2Q76ZEngXgxM2dH7CMpDhRRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvdriDIKu4IhMDvx3XlQb2dGoxG0AyUwLBLAuNjZcybRLAHKrvWoUjQVt2IPKB+BpWPprP0xiknw4a/Dc6bn6TJMvsJrf7M9OMK/CCJTILYFkDPp6ez+HLIZILXetWahWvlCIVFZiiDOtk3RclReCSu+6qtzYLqFqJqhsMUxA54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CkK1bDkl; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX5TiKszfGI9A8QmGCsfKh6AfDFifQDpd1O0jgjGe9zGGrK3e76+ZviqdHWFrvaUjH2PocnwMsH1GZ+b3TTNGPC93ErdkifFzGdUirYzFFpAC4funRTnBpcIf9A7eEKXGULYp5uyBF7eLVoqBsnpBXyTT6FMCEK+USYSQim8NuH9ltPpkVAmpmFx0Sjw+supK5dUprJkMFkLMoecmBrWBYo7VXRMpZOxqbSNQQfU7ORjIJ8UIogsPoZPsGGWZtPVRtM3k/uJbbvlp5gr5knz2iNj4XUfhuVhFxeYH4DT+AmIIPfPCaQojLPvouhA/83VmR/i7uzaEEN0i5ZwiFf7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdRy/cGz1rlLd/QngPadPKRazaOghqcsrt6SN34Joro=;
 b=O4QbWBmEpUhgw0K8DiaEJaZNLPp+PWnUZh3L7G8rEpYmHLgwH0d1mMBO4mmO4RB2LTbpO/RhPQ4Xs4Tv/QkOELARosr1sO0n4c5Ltc+wceqkW31ngXARjANHq4GCxhBNpvTyp62dKMQM2DtH1Ow8rE+e5EKJhZE58uvBDiZLOu962t6PzRcCeIn/pnuJvOR2U2zFK8QK//i/D6LFD1IkpWGBdmb3g89t9jYJGKp016jn9qB11TAeZgFtyi0haWkGmVnS29f3hPXUTaEYJG175HV8tRpa/oxBPMoXHy+Ww4bs/F2kw3oq752OEZwkOlim5XUYaPkQImUMd+kV+KQF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdRy/cGz1rlLd/QngPadPKRazaOghqcsrt6SN34Joro=;
 b=CkK1bDklPbErPxM+YCfIJT+7pooLySo2MERuQVHGLxiBZVUnzPtolbME1XXWKeWYMe5n0S+ASdbUkGzPfyu8f4HxIDvugmz7eMTePU9EvdTQsJJ1LPs0013KYn8eV7mrQeFwTeyrxZ0Uq8idV2YTvQLemfiV+cNkwWeOJz5PWVQ6mInaKdGaPCMPUGKSmwuN+mOne7KzHDkT6ZPVDVQZVMGTPlBujmvHn/gFVPFZrRQ5cFJyQ+iDKgeqtOIKX3u9K0fxQN/wYDSf8pc3tNqUKWIlTf2wk0RHV46pbztD50Zi+y5Kj2LCVB0ctQNWVtFkCz2C+aQaUh6gOFSdBtDAiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 02:23:56 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:23:56 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] dt-bindings: clock: Add i.MX91 clock support
Date: Mon, 14 Oct 2024 11:24:37 -0700
Message-Id: <20241014182438.732444-4-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014182438.732444-1-pengfei.li_1@nxp.com>
References: <20241014182438.732444-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB9378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3860c62b-1c32-41ea-8628-08dcebf7413a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lijnfHFkaxKaUDhpeZlPrH/QSjI6YXnVJE45bKDCyEAfl24Gi4znvChVdiA?=
 =?us-ascii?Q?5hI4N93V42ZQTTdlxgBhvsHwEwQ1xhuyatXx19JFo9S6tESS/mJt/tIzTZW1?=
 =?us-ascii?Q?cCRYeA8UaoXXgU3bdLd90mgaDIGqymzGPPzjzKw1vJv539VVYJyBYnEvULUP?=
 =?us-ascii?Q?QEftSjnZx2vRM2a6vo9mvuV/2lOiCZ+qQu6pY8DunZ7+0SfAeuKZqvBcn84H?=
 =?us-ascii?Q?XLoH01EkqyRA6fgccJtoIm3azfOsZNhvwyyvr5skWQYHO7UhVpufmhziZJjw?=
 =?us-ascii?Q?iwIc6CHI4munua6JLlFZerBI00ErkjRIONfTZEv1EZE9pbUMV9GW8Z7w6nk+?=
 =?us-ascii?Q?lVaJRNKa5cntIu4Py0caRnNhaFgHG24RrRqtG7vICM36DGT+2G3mwgiZiUDU?=
 =?us-ascii?Q?5a9grNc+BNzwWqR9fnVIHo1ogLz4qcuy+n5M1neCYo0DUTTtfMMBmDTZRfaC?=
 =?us-ascii?Q?F/W/e9UI89IoBBwn+Qg76i45M6pcJEN43GAsJsdRHGvbyxn/8kuzYeZIZWvg?=
 =?us-ascii?Q?2Osv1QWriDI02Blp4tr9gTEOww3IvrCiiMVeOhTvTdN6Q+aPcq+THCQPgv4A?=
 =?us-ascii?Q?Q++bmZ124T7d2PwZnOnsisB2I/VJHb8itjhMDU2aJQKDFCccN7ZJJW3ehqrq?=
 =?us-ascii?Q?C9/w607cGASitSqHUH116h/L6/cMuCqMgmHZSlHIk5mN22BJuzoaY0XtS26T?=
 =?us-ascii?Q?PQj2CC/HpPqw9sS3BW5ktZs59eak9yFpNgWX5moobPpsoAGBV788fMqa0ihe?=
 =?us-ascii?Q?30ur8dYYMXPElzNkEC+PJtkawk6RZmEoYkRBp0oLmJQTrg+E+f9dvWljU330?=
 =?us-ascii?Q?Bxn/8CsYv5iuUjL26zodl332FIQ3QjnxYnwjAL3A2hGfj/lBI0Onp2SCzC8n?=
 =?us-ascii?Q?lJe1DIAnzf0NckQM3t50v+N8OAa/ELiSTu6GZd+1Rtr4/ZLrOWU8a9uJHaOi?=
 =?us-ascii?Q?zzzGgKC4TVkej5OWU59A4t1HS+ODpJEQETrvuEelbEoWl+5FXnE1D+XuEfhk?=
 =?us-ascii?Q?sA7yay2a0sw7AHDJyZAwi49BW02iV1UyUmjELF9TuALLnH0pjHcD39PdK6eG?=
 =?us-ascii?Q?2RFtAdIPjytd4dhXrPwPz+i2qfRhZrDMQHDnlEu8qyyAfJCbhtBrf1sfocMo?=
 =?us-ascii?Q?Lc2Rd31Y2NTahnd+0Cc7CHdqoesl87GY80zUS6V83HL7mvWPamCEzF/QrNRd?=
 =?us-ascii?Q?NLtqeHqaapzdJqWgE7gF8qdpce4e4/USrptwHsUYVBHpUYP6IhjWKS3LsQY6?=
 =?us-ascii?Q?/0XTTPuHgpMtO/kwr80wusfR1mAFQfWkVxCfpbUwBhZb0hMT60jai4y90yO0?=
 =?us-ascii?Q?FjDCyIM+HZ5s5q0Lfh8PnCTjKFrBSk6MoE7Fe4G1nYffYbd5DPLrlt5DMET0?=
 =?us-ascii?Q?wm9pPNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5VbHmKEPLTyovzgYrW5AuFxYK/m+4c2BnZ32whW8TLmzZzNyEHYDlFGStSpr?=
 =?us-ascii?Q?+/Cc7yNE2xl7vQMuZAZeDxAqN5S9wUlN2xuQAptMDMdexhzzcI93qjHPtaLc?=
 =?us-ascii?Q?M2bpaibxDNFKADl0OT7Zw25NLeOG7UY4/ycsPiqU8wRIHsSEGPQ7o7NcJZkb?=
 =?us-ascii?Q?Jr5OquDYfKm4L/ygtXF+DiUNjyEnBJKL2s/gg/WHMnMrq43AoVIbCP5XWu7l?=
 =?us-ascii?Q?jdv9iQw1lXr6AwG//C3CVhQhLKLdkWlYx5ff+Zj/lVPXNwfc+oWAR9DUwxvi?=
 =?us-ascii?Q?bqTJsP0ZKcIf62YqCsOZKrJoT9x6Zi1l5MveOEoW/OyQPPJk8ag/0tXlbrN3?=
 =?us-ascii?Q?YIAbJZc31Xyy7LzNn3vYprDAcDVwkMxP6sB0uk2zj/msdYmks/A29Oau5Q4/?=
 =?us-ascii?Q?5/7VhYQr9+MqdMlD8jpI0/eXNu02XlYHkBw3G4abIqXrM6eOfNFceprfJWXs?=
 =?us-ascii?Q?nU8Hk17jkFMPFDxXIEEYokCP6+vEjNDv85jRGVmXfIwOznhY0Nh71sFFcHGJ?=
 =?us-ascii?Q?Ci+0jOmKJxSHS3vpeInUjRyhRQ2gFaPhj5CmMvl2m1rhmH5/EtqdQOfPsU7z?=
 =?us-ascii?Q?/XGaTTxCNuMWaWp9NOgA753CtdS7XAYDtwFBgjX+pe8YLI2qeqXVqPXxqCdq?=
 =?us-ascii?Q?azmv1XB1/E/bsgkUWQQ/KTFZvUg1DnkcdMOt42hvn21x5iur6UvjvHsECBJz?=
 =?us-ascii?Q?Sr7Nmyvx1I8iqnVR8tC7GY5lz27nt3Qp+rGFs++6o5MOM6szVJKXA8rPxiht?=
 =?us-ascii?Q?Iy2du255hJmgk5upNlglbkab35o6dMa+yfBmkW/uSdCXRZ6bMPgWY8ueYWMA?=
 =?us-ascii?Q?UXIR4OBbafmZJ3D9Kk1DilhdVYXsolCouaIayf6Qw3QpU+17A9sbfLSvAX8i?=
 =?us-ascii?Q?lP/xIQvt+Bbxwr9TKwwmHUXE/r6uuaAqMk57iLYeW62Gk8AsGupZ8mB2HeyS?=
 =?us-ascii?Q?NfFj42kH2UzRVf+gkKtUJRihT06GtQ0sWOlCQBfdLz0kvoXJ5BiXer2cx50H?=
 =?us-ascii?Q?N8KbHxks0jPjF1Jr5UX3RSwysZV5XUHtvEZHTCrDbDsjXqj6+3yrOkHKbd2U?=
 =?us-ascii?Q?kZ81yAxNhe9SiCbk0FyrvRkYgiehcbXnTTCnHf3XRU3OoD0IbLnNRHC3JvWN?=
 =?us-ascii?Q?1k1YxVY3QF8FJeXj4Qon4UoighZQC4EOR2V7pNTi2DtVHHHsAzO4tM9cMwNl?=
 =?us-ascii?Q?GLGLIVs1/m4DQdxUJEOc1JiNQHYReHdXW1T87WEu5o0cU5tsnDMPuSydWPXZ?=
 =?us-ascii?Q?tF6TF/1xaPBn0K+s5V4vIs/vqBcoKByqmhj7Z6XnHvfRE8QitLf9V5YqNY9r?=
 =?us-ascii?Q?HZ63QqATKUv9qRwVECVKQ22Y8/sMVr1cU55al1+7pH9gm5qUY5Uf7Rzvn51J?=
 =?us-ascii?Q?KB4L4c2o+0Zes7SffcKxcXqEzDIozyFlSFrAjatXj1brdKOtgZmr5197d0E3?=
 =?us-ascii?Q?g9LYkVAAp7l9mziEcIxaiZog0yVHvKNqUCPxlBxH0LboVyZ3LpKJ/8Ow1ZGz?=
 =?us-ascii?Q?gwQ96MEdLdaxRXye61zE0p+NolJ00xD5glgBwAhfVBPtHAq2srY7sw2jNx6B?=
 =?us-ascii?Q?kgvPu0+fJOBq+dDiTz8XcwuHKy/7L+syKKm1naHs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3860c62b-1c32-41ea-8628-08dcebf7413a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:23:56.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NrZjCPv3nS4jcx9PPPwaR3fpSNLnS+HMMFND1BiV17yuURAtrSxdwRdsQ61RSQGkcUVNk2TebHuhMqtox2BdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378

i.MX91 has similar Clock Control Module(CCM) design as i.MX93, only add
few new clock compared to i.MX93.
Add a new compatible string and some new clocks for i.MX91.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
 include/dt-bindings/clock/imx93-clock.h                  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
index ccb53c6b96c1..98c0800732ef 100644
--- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - fsl,imx91-ccm
       - fsl,imx93-ccm
 
   reg:
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index a1d0b326bb6b..6c685067288b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,5 +204,10 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
 
 #endif
-- 
2.34.1


