Return-Path: <linux-kernel+bounces-264957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48F93EA96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81E4281471
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F88257B;
	Mon, 29 Jul 2024 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B8Rf5UDg"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B677115;
	Mon, 29 Jul 2024 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217285; cv=fail; b=MjKEPLy5HHA2DtcaBX/ptNV8Wo58LmcaeKcfDTeoPyLoNGLBlrNfQqb+pJ3/TL0MWYuVLp8uMigLXgZw8hLgUtQC9Cqw8NnK2WRsVGfAPf8Ltn7TmOEsBgZHUlXx9VHwT/22twjo9T1noDu8dugMY/d5kglyN9I6vqewUf4Iwtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217285; c=relaxed/simple;
	bh=KXbxUspcfX9SrmbcgUN1Yjuj1/JvoCE5jZLCQWYleBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tuJJj54qwHYtdbNZjWcqXl3hiGDOZZ6/04xUPJzDj0udLlQIqPqPHEwpUFpVVBMmVbG6H2u89CWrTQTvxb7eWaY//9+AxTYys7KLPi3HLoOC3w1BZyaoot4TJtJp2Emxuh5isP3+nr5oTCWhMo3URNXeq69i8477S4eZ1xHzaik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B8Rf5UDg; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNMFuUXeK1PORaTOtTpil10+8yRyY3X6f/rSgZ2ruF6f4wUYVSpZPUvu0owvoMzfiABuHA4dOoAyQOwVTtk10ZMGfAsKWToar/Up4L/YjeF/HDpGJLm98Emzr8OAjG2G67tWKwGKtOBupJ+exa959hK1Y5YsZcXb23sCizk6e4mPWWoK8ObpatpOnwY/sy5BFk8rEdkuS64m8XQznbBsECqbCfOifBsZcy8vOKbUCVpO/SQTNuFX1JS5X+e8xnPs8LdG5WubFucoihh58+lShPt9Pqx+IOMjtpZrwwpeLNtuPILKhiARzM2uL/9j1NE+b84FFJT1CS07K/CZNXqRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N9Z+oUcJf0oTQF4nZdVS0aEUsgLWw+Ij6ie9ehZiwg=;
 b=PllCS51FHCszqxA6ncNPFZM/S0rvwBbFeUpmOGB2yTqsaeXn+jClWCkzwOJ3t7UahoIe8Lcv3bwxHfW31JSqEPaK0+WGQ03+3NiKJ/c9jWTfcFSZhMksBxpCngC6nrLiauXMxlJI92ZDZeHdwx2bc0KkBHA7ztBLn0EPTzddRsscFlHlwO6/dgg5eUJMtKg5B5A+YrrVdiiDyCkLodz5L+zxr3zv74W6gsNK5iReunIJAzMhooYcSirzrk+LZC7LGZYbIcESPwfe3URBYWHWr21AOgVVh3xyd3kekG3kfSqLnxEkqg8JA9ogl7VcEfrj4fY7oa2WBPQyx+CJe17+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N9Z+oUcJf0oTQF4nZdVS0aEUsgLWw+Ij6ie9ehZiwg=;
 b=B8Rf5UDgTk8ne+6BlJHnDbkovtPCS8cPiaI9DHHpqU9h6AI04USxXYUfb6GRv1AdVQJCiVuOPig0z1Rdm7SEOXC25+ebDliKBTUGjBf8YT7/FlX4q6p9MHEpL5tnGoZ7zniOoqfAoeeNIO4URuAQsGaWo5yJv1UOZSrUNP2w/+i0Y2wUUOv0IhzOCIJZ7YXJEpf9gMYSF9Jt0ik1sv0Q2XytxYzSdNf1LIIEkQGT+KnaYkk91I+Jm8BYP88+3EdwWZcrgUhXp68TYiP3npayYgx6zNGxkz/HfoBtmCIGqZdks2VXW4PVoftA9dJENUPNCiZvjABc7nfnEJG7lFU9qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7610.eurprd04.prod.outlook.com (2603:10a6:10:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 01:41:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 01:41:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 1/4] dt-bindings: clock: add i.MX95 NETCMIX block control
Date: Mon, 29 Jul 2024 09:27:53 +0800
Message-Id: <20240729012756.3686758-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729012756.3686758-1-wei.fang@nxp.com>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: b56328ca-f3b5-4f5a-2791-08dcaf6f8c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YCn5E3PO61Xlhzk85wlP3jzbXfkM5a582xdOOQzyEYfcx6AS/Bz1/uQ2ESQC?=
 =?us-ascii?Q?QoL6DOZAIJrHDjMPmFaa7FHNEGlQZCt2VBA9pVjQIuLS2cm72xZz3wiSCMgV?=
 =?us-ascii?Q?l7OPVhY+ZYk9o7CuPzgg25/1WMeRmYqv9JB/vwVChuX74hGjOuYK61CJkI4R?=
 =?us-ascii?Q?lwL4ZtI+FC26DnGYjqksHcFyYACpFLNtXkf1upCLSri5r/7iMhKLGcnULtWg?=
 =?us-ascii?Q?nSGwcLewJccpJhCbn82gTN29EHY28L49UTarmzPh9IqMeZkENrPGkN2T2jyU?=
 =?us-ascii?Q?wMkdmJ6wWer4H/FxjqdZE+IehPATyoVX6BnoELN+Ucc9Kor6QrGqyQGuuokf?=
 =?us-ascii?Q?aHLfdM7+vdodES/jjvJcPz7lKg/MdWIkXlhuiSHFcbm1b7OnPjeNZ5ACeRUS?=
 =?us-ascii?Q?1ydPxS5W/uznnq2c+BANslS7kHVYQAHnDHcve5huGOJWTDoNrpQOp0HByDW7?=
 =?us-ascii?Q?fI16LPKaPUn6bC7zlrvCIBZz+hsR5EK7kytKNYIx+EDi5NAotmoCnFLLx2L8?=
 =?us-ascii?Q?O+ZfA+8KxRbnpr5HuQd2OjLdO9cKskCJ5wCx3RQh5LHv/m1wL57xx+zThddI?=
 =?us-ascii?Q?WeAmshKeeQE9Wrjr4P2ZX5MPCK10BXN5yqdJBQZB6EEECJm6LZUj+bfxLDEB?=
 =?us-ascii?Q?gVQyKVobhHkzn1JQbN9BDRFBcQAWMMYxDtKWtrDUPSFMna1gArrGvrju/ggR?=
 =?us-ascii?Q?BiACfsiwDEOLP8LDmbRDdz+5iSx/OA296mQCRjY4z+cRHD4Nk4MqyyvqqPqC?=
 =?us-ascii?Q?T1y2u4Gphl8EDdwBnfNbKyK0E0mhnqXoIgcU08E3jfrEVuyq1rxfZ++13xgY?=
 =?us-ascii?Q?EyGxNoDiOmlHbuV9FQIHCHlt/AP+ZWLMVBtCK73yiQmh1xuIPt2Fo+goAqJL?=
 =?us-ascii?Q?5Y89CAJ8UdaRuW7sZ1ezG2dU90i9RkCDwP6f3saSGEyN5YUqHVR3Q0zwFr2H?=
 =?us-ascii?Q?4cRAT7JykSjo3GuMfCzDtzwW6hJzd/LltZWTF7Eq+jO+FMKHjQUXWkDO6Qdk?=
 =?us-ascii?Q?o9bKZfDOuNz/Vvt18s7ETDfdr89KzKhTH0FYxBkqQjI05mO5lax56ySfvgkL?=
 =?us-ascii?Q?OuNIcCL0oS1TlP07sZEkzXBrDhgc97CLSmpZXyyhBUgn4GakVY9Unbcxbumt?=
 =?us-ascii?Q?zEBaI0hIXtQ/FjDuwkT3+/glPwTqjpDaFudYBTBobl/y3HzK0+AAq+HWIHhG?=
 =?us-ascii?Q?C8+Qb98DYtp/UrnjgQT6Zx3rSjnPIP0YD7CFwUBtmLE3jSYnl7brZ3CxcGq3?=
 =?us-ascii?Q?d6BEuyaYK7VOv5hD7tQCwgD8Nowc/YIJBBt38MXi/zKvO6ZxtprIxI1moXYU?=
 =?us-ascii?Q?FzCOFioNRC5mg/4u9HE/V2yW+AiDfqnNxM5PN2hIFRUUY5dVuzcNpNGkbIJu?=
 =?us-ascii?Q?0MxtDdqMXjx4LtaU0Hp4o2kLIUUugSsY0/ROKL1kP+u2ihhRKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0oM+mqyzfIyjD1lTTH7qjfWVapMCzSIaWQZxyCxdw1FHzRS/Jx5+wJH7YUTl?=
 =?us-ascii?Q?J3nfikJviysUu8vBdbE8G1isVMMZTwuc7vyV+pDdzFNcymDaC3nfFxunLwHL?=
 =?us-ascii?Q?9iA2AW/QTiKOnFiuaD/iLE5Yvk8DWs7H3pNZ818tEz2TmvZfa4XlgEVdQ5Ug?=
 =?us-ascii?Q?5GVx0z5knuQl59oAvlSEFU6RI9HXShPYwJMjecPxfQXqHXEbUxSA2k5tIsIB?=
 =?us-ascii?Q?inUrsLbaZVlvWU71WxiUs+rF0poJqTUkjCGi/E2PTYk0sMu+/FPQssZEKMot?=
 =?us-ascii?Q?QZfHZye5Y0ZQI+pTPqaUR2stuQu11BL8j0uReg1Ui8kUUBm6hBijJVkI6U6u?=
 =?us-ascii?Q?mopde6Z9hJ9MwuLk+o+6lLHyzN3IoAlkYvmXqrp1s8CJVHtoaWN0Yng4dsiW?=
 =?us-ascii?Q?E19UX6OayukjXtOX1v5ndRUJhyt5pUMa6JaY4miaIUtlzD9OVwwCoqrhQ2Q3?=
 =?us-ascii?Q?MZEOiSTsudQgYOlQVEphRD0bBQ74X/plP1lIFOZUee6oRvELdpb6zqpSA8p5?=
 =?us-ascii?Q?Ob9iZkQsNpJwRa7Twqh0CbT/7eIqGoxT/ljYpmLVcIvzUE+ZyM89TFD8LG6n?=
 =?us-ascii?Q?/rOI6C39FPSSN7q487+7inzoOSYeDyeJEX1FUQc+p30TSDaLMBeF3c9hVMsF?=
 =?us-ascii?Q?lvyR74ftfkxm3+0ZgIkDF3Tyto4tsuHi9N5Oss+0oYXHKZOwkWT2wAEwTEAv?=
 =?us-ascii?Q?83jGRnsGQY3We9ZYmS/emyXEx8CD2dBYi3yS7+CflJ77mDWDdXUp+TeAVYKc?=
 =?us-ascii?Q?DSBFk8i6OYZWljcX66LKMlerGtWTFWS4Ryl1GOnK4YdsCTJOPTGTKJYoWElH?=
 =?us-ascii?Q?z398TVIVtXnnCKLyzhgVK/Wghm78lRdtqYf9IZPRF4m7S8MfNj0yxCgoMf3P?=
 =?us-ascii?Q?bBPmRcZBx3z0YazM9JCnEbIELiEq0QwKxZI4O87qj/HOR1AG5UkZflMNTizM?=
 =?us-ascii?Q?nTog8g6yntp8OccRBahEMPdQPJDHBrn7qvNEVR3jr0w1ggVJgatWA1t6MfVR?=
 =?us-ascii?Q?k6VQkVA4Nv+KcX2+4QZyK1aL/FhLD9w/bxMCxiIIUSF4W15UCjZTmIb3gjxs?=
 =?us-ascii?Q?I5I6LKFVfoxsPtpTo6EV9HytwcVY+Ujkj3VxJD0etiTpfFxccayEd+rgpxbX?=
 =?us-ascii?Q?9oSUw3dLdTdi+IpT/5WRPZbaNJqC6V3VlY9SLfzz6WCsSb1jYHPgOx3B4JcV?=
 =?us-ascii?Q?9zbIVsdPRdgZuWlmVWg3rs+hCNjiZUYt0bSLLWYihpt9JTIzajiI/YPPFjPe?=
 =?us-ascii?Q?OGHfwTkFZIJ4l3U3jyHN1rk3ZM7TuULMiP1dzpJUuW1Lqhwm+1SUQ8BQzEHE?=
 =?us-ascii?Q?v51WPftwk05s+jCIK5l0BLSPpWEmpF7urGbResOYbNnivhFYn6CreiKo54jm?=
 =?us-ascii?Q?2inrPp+nlD8P0zuYTpdJeB8AAX4UTXMKRjUW/jDTQ7xvWgcnKoO5H6obPWI4?=
 =?us-ascii?Q?H7gzVYuQCLwf9jngYypozGagP77InLUDhPQRnNfJBaR7RzkG5L1amHHyIuAT?=
 =?us-ascii?Q?UzIv7dr1XezOtalMlKvlwG9yqWscyDQSltjbCSTdGusf2UlFHacxGhXt26zK?=
 =?us-ascii?Q?7stAgE86thlH2CzUlMiawfaY9P5vGu7618KtRDg6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56328ca-f3b5-4f5a-2791-08dcaf6f8c3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 01:41:21.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng3TIvtpFUnpdYKVULOuvoOBqxcRooF5Eafd+c4qGgOsnocgJh0ccqsyEP8VR4lL7EySMQbUJAx2JQWtYg3TQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7610

Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 2dffc02dcd8b..b0072bae12d9 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -17,6 +17,7 @@ properties:
           - nxp,imx95-display-csr
           - nxp,imx95-camera-csr
           - nxp,imx95-vpu-csr
+          - nxp,imx95-netcmix-blk-ctrl
       - const: syscon
 
   reg:
-- 
2.34.1


