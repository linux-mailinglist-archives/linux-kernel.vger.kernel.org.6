Return-Path: <linux-kernel+bounces-216649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0C90A29F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6321F218AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9935FBB7;
	Mon, 17 Jun 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Iv8+6CMQ"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD7433B3;
	Mon, 17 Jun 2024 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592476; cv=fail; b=H4fDOhjLCeVAFmlT7dRl2oZ1Z/owWmKSseLHN58jghUYd0rOM0AdeBfC6MOF24ux3aGeKpL+ta5i8bGyz56Gle+sHRYuWe4JtVp6qDCRLJmoEbpK1gog6nC7RQlD81OvsXtkZdcMwB0CddLPKiOhJIVplwIQDX7fFJMt4j1H6hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592476; c=relaxed/simple;
	bh=EBlpoAA8/FKsrZzDWbLCJzahJEBcMzexL4ntEm8kY1A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JYQlJnpo2TVHbvP2RnuLT5gX9q0N0YIqFte7DLLiDGIIVZOusiyAsdawyfgTdlAzFF3B5i6IOQZ9LSDTMip6SdfJlEB/gFT37l9V6LEM7/tGG67pPa2TX8AOAlFXS9wVbJJioaJMtwK+9vcQdQdlbkcx7SB5MjHXUUHSJ7b7rWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Iv8+6CMQ; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bThBsJyUAwERW3BsEpqfXLw/f94cdGr8fTxGT64as53BpaM6x1MWtzCzW0sjHg61OfVqeJoRr7hcu3TRFrJw3ZbmmbWFzHgWA89ihUXv86QSVcGa1MbSQz+s4IEnEE8xJd5B7rbgMeEl9nIeLoOHHxyM5/j4aZDra/hEhPO7GeG6h3/feIYByJsMsvn48ci7b/VmEPY0n6D8OTMJ1ybpvr3Lu/IfsYi9nPA0ChKwgYUc+9WvDtnxmehs+QWa9qVy+bmXlVUhoICyFU9U8WNxiGUKEtEB290yZ9voGH7Z0gYN6gBtlqZscyzl6pmfdnj5VaVmsA5Q2vMu9a8Uh3GnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQl/P06sRJo5lmCjywa991pdzgOC3rGBJCjWa6iwxrM=;
 b=nyYDcJOmvZoEqEKHlWIAa8tO+FnCrFrhrqbt+pcU/CwPwJ7rE+cfjeGRdarN6WevKfFdyBrT6pJjsiaZ4tSL2u+KiRQVPwYD17lTreBOKblBBitHrnj9UnA804rJq04tBPy4aXqEpXk11cjRRqfp6yorW60QWSYyT0q/LAhqgtbDMHf739Bj+5YTR++bEKCeyMTLC1pUiD7k2deKu13IfmcSpmZyMMFw3hv1vj2y0cwlFybEXob7Y/nnC14CFeevbPxnUYF87EUrAC/dNCImuwRy9nvAlM4BiYAsQHcaZ1JvQUwP51W5wm2GwGnI1nvLlQ++uffH6UvWPJ+yeVbbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQl/P06sRJo5lmCjywa991pdzgOC3rGBJCjWa6iwxrM=;
 b=Iv8+6CMQL2AQ4+QU7qXd05jOmc0jOGItkaSC7397i/F4TiomRZkA1+l0pCGc78NlbfV7+6jEGph8jsrJIP+WYYM5YGIBd9cyvJdjd4u3g55430dnKaStkCwImBPGhADVLUXEDgICZyqOgsc+xwgLGeNw0sjUUoXB/x1Zb/KPteY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS4PR04MB9482.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:47:46 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 02:47:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 17 Jun 2024 10:56:36 +0800
Subject: [PATCH v7 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-imx95-dts-v3-v7-2-488b52e10862@nxp.com>
References: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
In-Reply-To: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718593010; l=119625;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=u4IDT9AAxWOHb7Y6h2I7R8ihwK3mJKJ+apPCgksF/jY=;
 b=uKLl3Gm6+9UZCOBMVEfo6J96kUeK5zqv0Z4+5BBb9oSn/NG52gWzzwfJNMBNg0oB7ozEZyFKR
 ZA5INwXQ3PyBdCjs4cYR+WTPnVFt3gbEqss+8Oa41+Ipc6zwp10nvsW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|AS4PR04MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 6806a36d-32a9-4f4b-4058-08dc8e77de12
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEwvaytBS3l1c2lTd1JCTTlQaDFQbHRzZURTY2NYZWNldDJkaG90Wk5KLzFZ?=
 =?utf-8?B?QzBJRk0xdFJ4OG42ZUUxMWZEZEhaMEl3MzNLNnRNQmNDbTBQVnVhaTZmNFNN?=
 =?utf-8?B?ZzFKRnZOWlpiSjBIMDVmMU5wZ1dwWE50R1F6ZVhtYXhUMzBRYmdHOG9tcDBY?=
 =?utf-8?B?NEMvaVNWQzNldmxoSlhQUlZJYVM1Y3RZcXRpVXJ5TjgzOEdITU9ORCtGSEx2?=
 =?utf-8?B?MGlxY2J5M2xIc2lvbnIwc01pNWwrRnR5djg4MC9SOEJrSFdPdGNaendrLytz?=
 =?utf-8?B?d1BtenZZNGsxeTJrczdrVGhpMm5XWmlxZFpiSUhCYzJPbkw1YTg0cHZjckRP?=
 =?utf-8?B?Z1JualIwTHk2TEhaYUhMcFNUaU1uQ0laRHNreXhpcjdwdkR5cmx1UHBKQVJh?=
 =?utf-8?B?YVowZTZGL3J5eGRrVzQ0WlZ2aDdSRXpZLzd3OVgxYkRkVUNGZkVoaUdxZEpB?=
 =?utf-8?B?WHdjeE8vcVJNRWFKSEExdGdtenpNYk1Mbllkc3NDVkJ1L0JpTXV0VGRxNzRU?=
 =?utf-8?B?all0R3ZRT3V6ZHF0ZnNwYmJEREVtVVhrM3ZGTWpiNUVNcUJPd1dXUUN3eWhh?=
 =?utf-8?B?cmdRUUFQTkVac0hoY08rb1BQRjRWVytOTk9EelcrYnkwZnFuN1JwYjI4L3NG?=
 =?utf-8?B?aUFXYzNIWlhtcjkwenltZ0pOR1o5RERlWHd5aFZBRENxandkbTB6UGJuVGx2?=
 =?utf-8?B?Y3UxTnRjVTFTVzdBM1F1Q1BtcWFicklXR29HVGd6MnNvY3dFL2s4c0xFY2wr?=
 =?utf-8?B?QmUwSk5WRFFsdFA5ZFloUWdmMVVib0dET2thUnRHS3hyWVZraXlBdFkxMVpw?=
 =?utf-8?B?MUJKNzU3STFtTWRaUi8zdE1KcEFDWXF5N2w3OEJkT2M5Z24xbWNCbUVqWXdJ?=
 =?utf-8?B?ZjhtZ2xrSkxiZ05YWlN3WHNmeGRNeTFkTExrdHhaQVF2THlTUnZyUkZPU1M4?=
 =?utf-8?B?V1hJUVlBcVVLcWFYcjNMWmsyWjdPekZha01JWnhrMHlsSmtYWTlyZzVLM2tn?=
 =?utf-8?B?UUdIZm1LK2JTOExvcW0wRUFwdGNYNWY3M1kyNHZSZnBKZHNWbHRKQkJ1M2dv?=
 =?utf-8?B?cnp1YXVkSGxMMThLV24wZFdLa1NVeUFHOG0wZHk2YzlSTHZLUVB1LzFMUDZx?=
 =?utf-8?B?azFZMHdkVll5ZnVYTkJDNHEyL0dBRVFUdTBuS09LV21zT1JJZW91UGlicEYz?=
 =?utf-8?B?OW9rNVZaTkp0MllSSzE0TG1kaS8zV0hRK3FNWDFtUUI2emV2dXpIUWRhMDlw?=
 =?utf-8?B?M09RdGpxT2lRSklTay9NNFdIdENUR3k5YTlTeHdKcE8wOGxVQUxzZ0hWWU9k?=
 =?utf-8?B?V3RuZTJPYWE2T2hzNG9DZnRoN0dZcFRYdThJOXptYmZuSXNLY2FpQUZKL0ZK?=
 =?utf-8?B?VldZaFRpeWZia3ZncC9vdDVUeXM4YXkwSGlIMTMwSDU5WHh1NjE5Vko0b3lM?=
 =?utf-8?B?b1FrMzFPVVBwcE13eGViRHFzR2hzVXNNYUNhcVg1R3V5SEV0TTZ6aDlVRDN6?=
 =?utf-8?B?Y3RPUzJkMlltQ2NwUHhXYk9SWnZpeHhpcE53c2RlVU5lbW5hNjRmV0p5ZWdz?=
 =?utf-8?B?V2l2bWpZTE1id0c2TXRJZi8rcWRCSC9nbElLUERhTFRtcERBZkE0bHd0Nzlo?=
 =?utf-8?B?SXRDb1h4RUptNUVqb2huWk5mekVCMUg0em1vWW5IZG5nTUFPZXBCb0EwNXR3?=
 =?utf-8?B?WmlIN0VSNGZPTzVEOWtiTTNmUjB5MDJPd2JzWXJ1bU8rQTNFNTBIck9pTVQ3?=
 =?utf-8?B?a2tZdlVWeHFhTnlIcTk5dnhRaXFGSU9tTDcrVEJSRytxQmt5RlJ5dkRMTDRv?=
 =?utf-8?Q?qfW7UmANzlDEVho0MzLI3fCT0rSR//p5c9MGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3BqYU8wbERKMVhCV1JjTlZLOTAxbEJnZnUyR3VUbHIyQUJQS0lNMDhhYURW?=
 =?utf-8?B?a283K1VTV3ZJUWZPbWlES1V6eUpQU2NMcmZsZk9hT2w1VXNUejljQkVyMWp1?=
 =?utf-8?B?NkhOM1B2R0FpOHVhM1NYaFMvL29NZjZyYTM3QWZaSjBYSExSUmxKVVhYdVpv?=
 =?utf-8?B?TlBZWlBiMlV0L1M0UXE5MStudEVmZWt1c1VrbEpKWlJYanBQSSt3VTBZS2NS?=
 =?utf-8?B?dnU5M1M1WlV2UlExQzFLYTJyMmord3lMYkhCOE9xVitoczIzeXBwcU40Y09x?=
 =?utf-8?B?UHZVN1NKdElSUDlXSjRFak85ZWFPUk1CRDQ4NHlmNS93NGRZQzllNXAvUzFy?=
 =?utf-8?B?T3hicHI2bGZnczR2WmVBU2J5cExYQllJbThxRTF1c2RpWG1kNHVTbVp5MWhj?=
 =?utf-8?B?dWthMUE3Y0FWMm1qWDBSVVNWQlFsVkZGa1VJSHlZVDI4RHR5clhNRkhnbG50?=
 =?utf-8?B?WlNTSGpVTUNBV3R3ZVNFeE0zaTV3OENTL3ZMU045WENpWUs5VWIxa3ptUjZh?=
 =?utf-8?B?K1R2OVhPUU9mYmlhU1VOUUkvbWhKb0NZMmdXR0hOVEVtaTV2SDc0YjdPYjdy?=
 =?utf-8?B?YXFURFVEcytScXI2d0ZwMEtRWHk3M0ZubnBBSzNKd0NrMitQYnVVQWlBQ2py?=
 =?utf-8?B?NnBrWUhrZlpSMkgwa1hTeEh1RUMxTTVUSXY3T1FGUUhFaFpZNU1mN1pDUHZE?=
 =?utf-8?B?NG9JemFZNSs0elJYU1c1ZFNWVEpSZzhmT1FmSVBZWTQzWEM4WDJOOTg1UVJW?=
 =?utf-8?B?YzNHL3dtVnVhOUd5cTVZVzBheUVDTk9HbGRhRXZLK3hJZHFPUWt3eHNZTVNE?=
 =?utf-8?B?WTNDdzNyNWQ2UVRUNUMyT0JVM0JJSU96emxoU3pISHJOSUN2VjdXTUsydGhH?=
 =?utf-8?B?K0hydnpOclQ4RHhTbGZDRjl2T3g5MjJpTWVDa2EveXUxLzV0bUJ0SXh1QUpI?=
 =?utf-8?B?QWdJRFV3eGpxQXQ4WGNzYWNQU3lBcTZoRmFzTkQ4c3dXbWVGcmNZMlUxZlMv?=
 =?utf-8?B?c29maUZXM0E1Q1dhclpWMDE5bkZDRm56YnEwcW9hV1dhUXlCdUg1U3BVSG8y?=
 =?utf-8?B?WVI2bkIvVmROSXJBcHdaRklnaEwwUllPZ2VvZkxONWh6OW9ZdEJMbG1odXUr?=
 =?utf-8?B?dGpHeUZPUHc1bmxUUXkrOE05MHlFVVR2cEpJRnF3d01FcldocGtxZkpITU12?=
 =?utf-8?B?cWdzc3E3M3BqUlBIc0pMbDhyT2dWOWhVb2szUFNsR3Rja1hIMzJJckVkYW1m?=
 =?utf-8?B?aU5oVXY1VHBGcTVieGxjU1VGbVpUV0l2SFVhOGdzV1Z0WnlzdTJTc3U4NXd4?=
 =?utf-8?B?akVqZ1dqNzk4Ujc1NHVSY1UxbzVRVTFkdFRjNTdyeGlwMkplTEprQUxqem52?=
 =?utf-8?B?U1NpL1hnR1ZBQ1N6QStNR04xa0NtRTI4ZEl2TUgrNXMzWTlsSU45Yi9FYXlI?=
 =?utf-8?B?WnNrRXpjYkhuU2lUdjcyeks5djFHNzFvbVNMRWM4Wkd2a3dDdkZBS0hlRjFj?=
 =?utf-8?B?QlJYNWNGMkNIMitqYm51SkticHhqWExxRDRFYWN1MVpRZTNCQUkrRU9mWDU0?=
 =?utf-8?B?TVc0LzdwRFZ4UDU0MGJ3VG8wZnlQcmV1QlJKUGxDYUZKcGhZNHhnaFdSV2Fv?=
 =?utf-8?B?T1gvZWpzc3ZSOUgzTTdZT3F2Z2lDaWFxYkYyeUxuYVhBY3NoWnh1V2RhalN2?=
 =?utf-8?B?MDVEU21HVU1ybEkvbU92Tmp6alVxeUNsSGp3czRqWWRvUmtVR01RdG9vbURM?=
 =?utf-8?B?OXZZbmpTcnlieDZONFFPKzE1anR3SlhmdmNmUkpNalE2eXlZRS9TdGgxSVhy?=
 =?utf-8?B?Qm1IOEMzYm96MHhrc0wyOUUzZVh5SVlzOUwwRFFBSUJiQXA5OVlwZVdDTWlo?=
 =?utf-8?B?YWJTMWVpN0Z3cnF6emMxTUtCK1pvNFh2LzhtSlVjVHZFUkFTWEpSYjdmdGRm?=
 =?utf-8?B?d1RmZjloTzBUbzlocHpxUnFIaFdFMmdzUTgvZytyYnJEUzVqQUhlWkpyYzMz?=
 =?utf-8?B?SUxMWHVIQU1aR2NvSDR2eXcrb1lmays5eTQ1WDVSZTZpMjZRV2Z1RVN3eVRK?=
 =?utf-8?B?QjF0d1ZpSFoyeW5XNWV1UGQvS3p6cVRIOTNwclF0bTZDbUszTFpCZHZ1TkFo?=
 =?utf-8?Q?4qrPUu7rhtkoQQ6vhikECO010?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6806a36d-32a9-4f4b-4058-08dc8e77de12
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 02:47:46.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0929SVB/WPj7GNRZDhOaRevU26SSv9GcV4lJG8stzB287OO4ydELsWYdylDZDSLuH4TIiJNekgWBYGJ6ObbQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9482

From: Peng Fan <peng.fan@nxp.com>

i.MX95 features 6 A55 Cores, ARM Mali GPU, ISP, ML acceleration NPU,
and Edgelock secure enclave security. This patch is to add a minimal
dtsi, with cpu cores, scmi, gic, uart, mu, sdhc, lpi2c added.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-clock.h   |  187 +++++
 arch/arm64/boot/dts/freescale/imx95-pinfunc.h |  865 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95-power.h   |   47 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 1042 +++++++++++++++++++++++++
 4 files changed, 2141 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-clock.h b/arch/arm64/boot/dts/freescale/imx95-clock.h
new file mode 100644
index 000000000000..e1f91203e794
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-clock.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __CLOCK_IMX95_H
+#define __CLOCK_IMX95_H
+
+/* The index should match i.MX95 SCMI Firmware */
+#define IMX95_CLK_32K                       1
+#define IMX95_CLK_24M                       2
+#define IMX95_CLK_FRO                       3
+#define IMX95_CLK_SYSPLL1_VCO               4
+#define IMX95_CLK_SYSPLL1_PFD0_UNGATED      5
+#define IMX95_CLK_SYSPLL1_PFD0              6
+#define IMX95_CLK_SYSPLL1_PFD0_DIV2         7
+#define IMX95_CLK_SYSPLL1_PFD1_UNGATED      8
+#define IMX95_CLK_SYSPLL1_PFD1              9
+#define IMX95_CLK_SYSPLL1_PFD1_DIV2         10
+#define IMX95_CLK_SYSPLL1_PFD2_UNGATED      11
+#define IMX95_CLK_SYSPLL1_PFD2              12
+#define IMX95_CLK_SYSPLL1_PFD2_DIV2         13
+#define IMX95_CLK_AUDIOPLL1_VCO             14
+#define IMX95_CLK_AUDIOPLL1                 15
+#define IMX95_CLK_AUDIOPLL2_VCO             16
+#define IMX95_CLK_AUDIOPLL2                 17
+#define IMX95_CLK_VIDEOPLL1_VCO             18
+#define IMX95_CLK_VIDEOPLL1                 19
+#define IMX95_CLK_RESERVED20                20
+#define IMX95_CLK_RESERVED21                21
+#define IMX95_CLK_RESERVED22                22
+#define IMX95_CLK_RESERVED23                23
+#define IMX95_CLK_ARMPLL_VCO                24
+#define IMX95_CLK_ARMPLL_PFD0_UNGATED       25
+#define IMX95_CLK_ARMPLL_PFD0               26
+#define IMX95_CLK_ARMPLL_PFD1_UNGATED       27
+#define IMX95_CLK_ARMPLL_PFD1               28
+#define IMX95_CLK_ARMPLL_PFD2_UNGATED       29
+#define IMX95_CLK_ARMPLL_PFD2               30
+#define IMX95_CLK_ARMPLL_PFD3_UNGATED       31
+#define IMX95_CLK_ARMPLL_PFD3               32
+#define IMX95_CLK_DRAMPLL_VCO               33
+#define IMX95_CLK_DRAMPLL                   34
+#define IMX95_CLK_HSIOPLL_VCO               35
+#define IMX95_CLK_HSIOPLL                   36
+#define IMX95_CLK_LDBPLL_VCO                37
+#define IMX95_CLK_LDBPLL                    38
+#define IMX95_CLK_EXT1                      39
+#define IMX95_CLK_EXT2                      40
+
+#define IMX95_CCM_NUM_CLK_SRC               41
+
+#define IMX95_CLK_ADC                      (IMX95_CCM_NUM_CLK_SRC + 0)
+#define IMX95_CLK_TMU                      (IMX95_CCM_NUM_CLK_SRC + 1)
+#define IMX95_CLK_BUSAON                   (IMX95_CCM_NUM_CLK_SRC + 2)
+#define IMX95_CLK_CAN1                     (IMX95_CCM_NUM_CLK_SRC + 3)
+#define IMX95_CLK_I3C1                     (IMX95_CCM_NUM_CLK_SRC + 4)
+#define IMX95_CLK_I3C1SLOW                 (IMX95_CCM_NUM_CLK_SRC + 5)
+#define IMX95_CLK_LPI2C1                   (IMX95_CCM_NUM_CLK_SRC + 6)
+#define IMX95_CLK_LPI2C2                   (IMX95_CCM_NUM_CLK_SRC + 7)
+#define IMX95_CLK_LPSPI1                   (IMX95_CCM_NUM_CLK_SRC + 8)
+#define IMX95_CLK_LPSPI2                   (IMX95_CCM_NUM_CLK_SRC + 9)
+#define IMX95_CLK_LPTMR1                   (IMX95_CCM_NUM_CLK_SRC + 10)
+#define IMX95_CLK_LPUART1                  (IMX95_CCM_NUM_CLK_SRC + 11)
+#define IMX95_CLK_LPUART2                  (IMX95_CCM_NUM_CLK_SRC + 12)
+#define IMX95_CLK_M33                      (IMX95_CCM_NUM_CLK_SRC + 13)
+#define IMX95_CLK_M33SYSTICK               (IMX95_CCM_NUM_CLK_SRC + 14)
+#define IMX95_CLK_MQS1                     (IMX95_CCM_NUM_CLK_SRC + 15)
+#define IMX95_CLK_PDM                      (IMX95_CCM_NUM_CLK_SRC + 16)
+#define IMX95_CLK_SAI1                     (IMX95_CCM_NUM_CLK_SRC + 17)
+#define IMX95_CLK_SENTINEL                 (IMX95_CCM_NUM_CLK_SRC + 18)
+#define IMX95_CLK_TPM2                     (IMX95_CCM_NUM_CLK_SRC + 19)
+#define IMX95_CLK_TSTMR1                   (IMX95_CCM_NUM_CLK_SRC + 20)
+#define IMX95_CLK_CAMAPB                   (IMX95_CCM_NUM_CLK_SRC + 21)
+#define IMX95_CLK_CAMAXI                   (IMX95_CCM_NUM_CLK_SRC + 22)
+#define IMX95_CLK_CAMCM0                   (IMX95_CCM_NUM_CLK_SRC + 23)
+#define IMX95_CLK_CAMISI                   (IMX95_CCM_NUM_CLK_SRC + 24)
+#define IMX95_CLK_MIPIPHYCFG               (IMX95_CCM_NUM_CLK_SRC + 25)
+#define IMX95_CLK_MIPIPHYPLLBYPASS         (IMX95_CCM_NUM_CLK_SRC + 26)
+#define IMX95_CLK_MIPIPHYPLLREF            (IMX95_CCM_NUM_CLK_SRC + 27)
+#define IMX95_CLK_MIPITESTBYTE             (IMX95_CCM_NUM_CLK_SRC + 28)
+#define IMX95_CLK_A55                      (IMX95_CCM_NUM_CLK_SRC + 29)
+#define IMX95_CLK_A55MTRBUS                (IMX95_CCM_NUM_CLK_SRC + 30)
+#define IMX95_CLK_A55PERIPH                (IMX95_CCM_NUM_CLK_SRC + 31)
+#define IMX95_CLK_DRAMALT                  (IMX95_CCM_NUM_CLK_SRC + 32)
+#define IMX95_CLK_DRAMAPB                  (IMX95_CCM_NUM_CLK_SRC + 33)
+#define IMX95_CLK_DISPAPB                  (IMX95_CCM_NUM_CLK_SRC + 34)
+#define IMX95_CLK_DISPAXI                  (IMX95_CCM_NUM_CLK_SRC + 35)
+#define IMX95_CLK_DISPDP                   (IMX95_CCM_NUM_CLK_SRC + 36)
+#define IMX95_CLK_DISPOCRAM                (IMX95_CCM_NUM_CLK_SRC + 37)
+#define IMX95_CLK_DISPUSB31                (IMX95_CCM_NUM_CLK_SRC + 38)
+#define IMX95_CLK_DISP1PIX                 (IMX95_CCM_NUM_CLK_SRC + 39)
+#define IMX95_CLK_DISP2PIX                 (IMX95_CCM_NUM_CLK_SRC + 40)
+#define IMX95_CLK_DISP3PIX                 (IMX95_CCM_NUM_CLK_SRC + 41)
+#define IMX95_CLK_GPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 42)
+#define IMX95_CLK_GPU                      (IMX95_CCM_NUM_CLK_SRC + 43)
+#define IMX95_CLK_HSIOACSCAN480M           (IMX95_CCM_NUM_CLK_SRC + 44)
+#define IMX95_CLK_HSIOACSCAN80M            (IMX95_CCM_NUM_CLK_SRC + 45)
+#define IMX95_CLK_HSIO                     (IMX95_CCM_NUM_CLK_SRC + 46)
+#define IMX95_CLK_HSIOPCIEAUX              (IMX95_CCM_NUM_CLK_SRC + 47)
+#define IMX95_CLK_HSIOPCIETEST160M         (IMX95_CCM_NUM_CLK_SRC + 48)
+#define IMX95_CLK_HSIOPCIETEST400M         (IMX95_CCM_NUM_CLK_SRC + 49)
+#define IMX95_CLK_HSIOPCIETEST500M         (IMX95_CCM_NUM_CLK_SRC + 50)
+#define IMX95_CLK_HSIOUSBTEST50M           (IMX95_CCM_NUM_CLK_SRC + 51)
+#define IMX95_CLK_HSIOUSBTEST60M           (IMX95_CCM_NUM_CLK_SRC + 52)
+#define IMX95_CLK_BUSM7                    (IMX95_CCM_NUM_CLK_SRC + 53)
+#define IMX95_CLK_M7                       (IMX95_CCM_NUM_CLK_SRC + 54)
+#define IMX95_CLK_M7SYSTICK                (IMX95_CCM_NUM_CLK_SRC + 55)
+#define IMX95_CLK_BUSNETCMIX               (IMX95_CCM_NUM_CLK_SRC + 56)
+#define IMX95_CLK_ENET                     (IMX95_CCM_NUM_CLK_SRC + 57)
+#define IMX95_CLK_ENETPHYTEST200M          (IMX95_CCM_NUM_CLK_SRC + 58)
+#define IMX95_CLK_ENETPHYTEST500M          (IMX95_CCM_NUM_CLK_SRC + 59)
+#define IMX95_CLK_ENETPHYTEST667M          (IMX95_CCM_NUM_CLK_SRC + 60)
+#define IMX95_CLK_ENETREF                  (IMX95_CCM_NUM_CLK_SRC + 61)
+#define IMX95_CLK_ENETTIMER1               (IMX95_CCM_NUM_CLK_SRC + 62)
+#define IMX95_CLK_MQS2                     (IMX95_CCM_NUM_CLK_SRC + 63)
+#define IMX95_CLK_SAI2                     (IMX95_CCM_NUM_CLK_SRC + 64)
+#define IMX95_CLK_NOCAPB                   (IMX95_CCM_NUM_CLK_SRC + 65)
+#define IMX95_CLK_NOC                      (IMX95_CCM_NUM_CLK_SRC + 66)
+#define IMX95_CLK_NPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 67)
+#define IMX95_CLK_NPU                      (IMX95_CCM_NUM_CLK_SRC + 68)
+#define IMX95_CLK_CCMCKO1                  (IMX95_CCM_NUM_CLK_SRC + 69)
+#define IMX95_CLK_CCMCKO2                  (IMX95_CCM_NUM_CLK_SRC + 70)
+#define IMX95_CLK_CCMCKO3                  (IMX95_CCM_NUM_CLK_SRC + 71)
+#define IMX95_CLK_CCMCKO4                  (IMX95_CCM_NUM_CLK_SRC + 72)
+#define IMX95_CLK_VPUAPB                   (IMX95_CCM_NUM_CLK_SRC + 73)
+#define IMX95_CLK_VPU                      (IMX95_CCM_NUM_CLK_SRC + 74)
+#define IMX95_CLK_VPUDSP                   (IMX95_CCM_NUM_CLK_SRC + 75)
+#define IMX95_CLK_VPUJPEG                  (IMX95_CCM_NUM_CLK_SRC + 76)
+#define IMX95_CLK_AUDIOXCVR                (IMX95_CCM_NUM_CLK_SRC + 77)
+#define IMX95_CLK_BUSWAKEUP                (IMX95_CCM_NUM_CLK_SRC + 78)
+#define IMX95_CLK_CAN2                     (IMX95_CCM_NUM_CLK_SRC + 79)
+#define IMX95_CLK_CAN3                     (IMX95_CCM_NUM_CLK_SRC + 80)
+#define IMX95_CLK_CAN4                     (IMX95_CCM_NUM_CLK_SRC + 81)
+#define IMX95_CLK_CAN5                     (IMX95_CCM_NUM_CLK_SRC + 82)
+#define IMX95_CLK_FLEXIO1                  (IMX95_CCM_NUM_CLK_SRC + 83)
+#define IMX95_CLK_FLEXIO2                  (IMX95_CCM_NUM_CLK_SRC + 84)
+#define IMX95_CLK_FLEXSPI1                 (IMX95_CCM_NUM_CLK_SRC + 85)
+#define IMX95_CLK_I3C2                     (IMX95_CCM_NUM_CLK_SRC + 86)
+#define IMX95_CLK_I3C2SLOW                 (IMX95_CCM_NUM_CLK_SRC + 87)
+#define IMX95_CLK_LPI2C3                   (IMX95_CCM_NUM_CLK_SRC + 88)
+#define IMX95_CLK_LPI2C4                   (IMX95_CCM_NUM_CLK_SRC + 89)
+#define IMX95_CLK_LPI2C5                   (IMX95_CCM_NUM_CLK_SRC + 90)
+#define IMX95_CLK_LPI2C6                   (IMX95_CCM_NUM_CLK_SRC + 91)
+#define IMX95_CLK_LPI2C7                   (IMX95_CCM_NUM_CLK_SRC + 92)
+#define IMX95_CLK_LPI2C8                   (IMX95_CCM_NUM_CLK_SRC + 93)
+#define IMX95_CLK_LPSPI3                   (IMX95_CCM_NUM_CLK_SRC + 94)
+#define IMX95_CLK_LPSPI4                   (IMX95_CCM_NUM_CLK_SRC + 95)
+#define IMX95_CLK_LPSPI5                   (IMX95_CCM_NUM_CLK_SRC + 96)
+#define IMX95_CLK_LPSPI6                   (IMX95_CCM_NUM_CLK_SRC + 97)
+#define IMX95_CLK_LPSPI7                   (IMX95_CCM_NUM_CLK_SRC + 98)
+#define IMX95_CLK_LPSPI8                   (IMX95_CCM_NUM_CLK_SRC + 99)
+#define IMX95_CLK_LPTMR2                   (IMX95_CCM_NUM_CLK_SRC + 100)
+#define IMX95_CLK_LPUART3                  (IMX95_CCM_NUM_CLK_SRC + 101)
+#define IMX95_CLK_LPUART4                  (IMX95_CCM_NUM_CLK_SRC + 102)
+#define IMX95_CLK_LPUART5                  (IMX95_CCM_NUM_CLK_SRC + 103)
+#define IMX95_CLK_LPUART6                  (IMX95_CCM_NUM_CLK_SRC + 104)
+#define IMX95_CLK_LPUART7                  (IMX95_CCM_NUM_CLK_SRC + 105)
+#define IMX95_CLK_LPUART8                  (IMX95_CCM_NUM_CLK_SRC + 106)
+#define IMX95_CLK_SAI3                     (IMX95_CCM_NUM_CLK_SRC + 107)
+#define IMX95_CLK_SAI4                     (IMX95_CCM_NUM_CLK_SRC + 108)
+#define IMX95_CLK_SAI5                     (IMX95_CCM_NUM_CLK_SRC + 109)
+#define IMX95_CLK_SPDIF                    (IMX95_CCM_NUM_CLK_SRC + 110)
+#define IMX95_CLK_SWOTRACE                 (IMX95_CCM_NUM_CLK_SRC + 111)
+#define IMX95_CLK_TPM4                     (IMX95_CCM_NUM_CLK_SRC + 112)
+#define IMX95_CLK_TPM5                     (IMX95_CCM_NUM_CLK_SRC + 113)
+#define IMX95_CLK_TPM6                     (IMX95_CCM_NUM_CLK_SRC + 114)
+#define IMX95_CLK_TSTMR2                   (IMX95_CCM_NUM_CLK_SRC + 115)
+#define IMX95_CLK_USBPHYBURUNIN            (IMX95_CCM_NUM_CLK_SRC + 116)
+#define IMX95_CLK_USDHC1                   (IMX95_CCM_NUM_CLK_SRC + 117)
+#define IMX95_CLK_USDHC2                   (IMX95_CCM_NUM_CLK_SRC + 118)
+#define IMX95_CLK_USDHC3                   (IMX95_CCM_NUM_CLK_SRC + 119)
+#define IMX95_CLK_V2XPK                    (IMX95_CCM_NUM_CLK_SRC + 120)
+#define IMX95_CLK_WAKEUPAXI                (IMX95_CCM_NUM_CLK_SRC + 121)
+#define IMX95_CLK_XSPISLVROOT              (IMX95_CCM_NUM_CLK_SRC + 122)
+#define IMX95_CLK_SEL_EXT                  (IMX95_CCM_NUM_CLK_SRC + 123 + 0)
+#define IMX95_CLK_SEL_A55C0                (IMX95_CCM_NUM_CLK_SRC + 123 + 1)
+#define IMX95_CLK_SEL_A55C1                (IMX95_CCM_NUM_CLK_SRC + 123 + 2)
+#define IMX95_CLK_SEL_A55C2                (IMX95_CCM_NUM_CLK_SRC + 123 + 3)
+#define IMX95_CLK_SEL_A55C3                (IMX95_CCM_NUM_CLK_SRC + 123 + 4)
+#define IMX95_CLK_SEL_A55C4                (IMX95_CCM_NUM_CLK_SRC + 123 + 5)
+#define IMX95_CLK_SEL_A55C5                (IMX95_CCM_NUM_CLK_SRC + 123 + 6)
+#define IMX95_CLK_SEL_A55P                 (IMX95_CCM_NUM_CLK_SRC + 123 + 7)
+#define IMX95_CLK_SEL_DRAM                 (IMX95_CCM_NUM_CLK_SRC + 123 + 8)
+#define IMX95_CLK_SEL_TEMPSENSE            (IMX95_CCM_NUM_CLK_SRC + 123 + 9)
+
+#endif	/* __CLOCK_IMX95_H */
diff --git a/arch/arm64/boot/dts/freescale/imx95-pinfunc.h b/arch/arm64/boot/dts/freescale/imx95-pinfunc.h
new file mode 100644
index 000000000000..9f614eea7c86
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-pinfunc.h
@@ -0,0 +1,865 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DTS_IMX95_PINFUNC_H
+#define __DTS_IMX95_PINFUNC_H
+
+/*
+ * The pin function ID is a tuple of
+ * <mux_reg conf_reg input_reg mux_mode input_val>
+ */
+#define IMX95_PAD_DAP_TDI__JTAG_MUX_TDI                               0x0000 0x0204 0x0610 0x00 0x00
+#define IMX95_PAD_DAP_TDI__NETCMIX_TOP_MQS2_LEFT                      0x0000 0x0204 0x0000 0x01 0x00
+#define IMX95_PAD_DAP_TDI__NETCMIX_TOP_NETC_TMR_1588_ALARM1           0x0000 0x0204 0x0000 0x02 0x00
+#define IMX95_PAD_DAP_TDI__CAN2_TX                                    0x0000 0x0204 0x0000 0x03 0x00
+#define IMX95_PAD_DAP_TDI__FLEXIO2_FLEXIO_BIT30                       0x0000 0x0204 0x0000 0x04 0x00
+#define IMX95_PAD_DAP_TDI__GPIO3_IO_BIT28                             0x0000 0x0204 0x0000 0x05 0x00
+#define IMX95_PAD_DAP_TDI__LPUART5_RX                                 0x0000 0x0204 0x0570 0x06 0x00
+
+#define IMX95_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS                         0x0004 0x0208 0x0614 0x00 0x00
+#define IMX95_PAD_DAP_TMS_SWDIO__CAN4_TX                              0x0004 0x0208 0x0000 0x02 0x00
+#define IMX95_PAD_DAP_TMS_SWDIO__FLEXIO2_FLEXIO_BIT31                 0x0004 0x0208 0x0000 0x04 0x00
+#define IMX95_PAD_DAP_TMS_SWDIO__GPIO3_IO_BIT29                       0x0004 0x0208 0x0000 0x05 0x00
+#define IMX95_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                        0x0004 0x0208 0x0000 0x06 0x00
+
+#define IMX95_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK                        0x0008 0x020C 0x060C 0x00 0x00
+#define IMX95_PAD_DAP_TCLK_SWCLK__CAN4_RX                             0x0008 0x020C 0x044C 0x02 0x00
+#define IMX95_PAD_DAP_TCLK_SWCLK__FLEXIO1_FLEXIO_BIT30                0x0008 0x020C 0x0460 0x04 0x00
+#define IMX95_PAD_DAP_TCLK_SWCLK__GPIO3_IO_BIT30                      0x0008 0x020C 0x0000 0x05 0x00
+#define IMX95_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                       0x0008 0x020C 0x056C 0x06 0x00
+
+#define IMX95_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO                      0x000C 0x0210 0x0000 0x00 0x00
+#define IMX95_PAD_DAP_TDO_TRACESWO__NETCMIX_TOP_MQS2_RIGHT            0x000C 0x0210 0x0000 0x01 0x00
+#define IMX95_PAD_DAP_TDO_TRACESWO__NETCMIX_TOP_NETC_TMR_1588_ALARM   0x000C 0x0210 0x0000 0x02 0x00
+#define IMX95_PAD_DAP_TDO_TRACESWO__CAN2_RX                           0x000C 0x0210 0x0444 0x03 0x00
+#define IMX95_PAD_DAP_TDO_TRACESWO__FLEXIO1_FLEXIO_BIT31              0x000C 0x0210 0x0464 0x04 0x00
+#define IMX95_PAD_DAP_TDO_TRACESWO__GPIO3_IO_BIT31                    0x000C 0x0210 0x0000 0x05 0x00
+#define IMX95_PAD_DAP_TDO_TRACESWO__LPUART5_TX                        0x000C 0x0210 0x0574 0x06 0x00
+
+#define IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0                            0x0010 0x0214 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO00__LPI2C3_SDA                               0x0010 0x0214 0x0504 0x11 0x00
+#define IMX95_PAD_GPIO_IO00__LPSPI6_PCS0                              0x0010 0x0214 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO00__LPUART5_TX                               0x0010 0x0214 0x0574 0x05 0x01
+#define IMX95_PAD_GPIO_IO00__LPI2C5_SDA                               0x0010 0x0214 0x0514 0x16 0x00
+#define IMX95_PAD_GPIO_IO00__FLEXIO1_FLEXIO_BIT0                      0x0010 0x0214 0x0468 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO01__GPIO2_IO_BIT1                            0x0014 0x0218 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO01__LPI2C3_SCL                               0x0014 0x0218 0x0500 0x11 0x00
+#define IMX95_PAD_GPIO_IO01__LPSPI6_SIN                               0x0014 0x0218 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO01__LPUART5_RX                               0x0014 0x0218 0x0570 0x05 0x01
+#define IMX95_PAD_GPIO_IO01__LPI2C5_SCL                               0x0014 0x0218 0x0510 0x16 0x00
+#define IMX95_PAD_GPIO_IO01__FLEXIO1_FLEXIO_BIT1                      0x0014 0x0218 0x046C 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO02__GPIO2_IO_BIT2                            0x0018 0x021C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO02__LPI2C4_SDA                               0x0018 0x021C 0x050C 0x11 0x00
+#define IMX95_PAD_GPIO_IO02__LPSPI6_SOUT                              0x0018 0x021C 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO02__LPUART5_CTS_B                            0x0018 0x021C 0x056C 0x05 0x01
+#define IMX95_PAD_GPIO_IO02__LPI2C6_SDA                               0x0018 0x021C 0x051C 0x16 0x00
+#define IMX95_PAD_GPIO_IO02__FLEXIO1_FLEXIO_BIT2                      0x0018 0x021C 0x0470 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO03__GPIO2_IO_BIT3                            0x001C 0x0220 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO03__LPI2C4_SCL                               0x001C 0x0220 0x0508 0x11 0x00
+#define IMX95_PAD_GPIO_IO03__LPSPI6_SCK                               0x001C 0x0220 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO03__LPUART5_RTS_B                            0x001C 0x0220 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO03__LPI2C6_SCL                               0x001C 0x0220 0x0518 0x16 0x00
+#define IMX95_PAD_GPIO_IO03__FLEXIO1_FLEXIO_BIT3                      0x001C 0x0220 0x0474 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO04__GPIO2_IO_BIT4                            0x0020 0x0224 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO04__TPM3_CH0                                 0x0020 0x0224 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO04__AONMIX_TOP_PDM_CLK                       0x0020 0x0224 0x0000 0x02 0x00
+#define IMX95_PAD_GPIO_IO04__CAN4_TX                                  0x0020 0x0224 0x0000 0x03 0x00
+#define IMX95_PAD_GPIO_IO04__LPSPI7_PCS0                              0x0020 0x0224 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO04__LPUART6_TX                               0x0020 0x0224 0x0580 0x05 0x01
+#define IMX95_PAD_GPIO_IO04__LPI2C6_SDA                               0x0020 0x0224 0x051C 0x16 0x01
+#define IMX95_PAD_GPIO_IO04__FLEXIO1_FLEXIO_BIT4                      0x0020 0x0224 0x0478 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO05__GPIO2_IO_BIT5                            0x0024 0x0228 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO05__TPM4_CH0                                 0x0024 0x0228 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO05__AONMIX_TOP_PDM_BIT_STREAM_BIT0           0x0024 0x0228 0x040C 0x02 0x01
+#define IMX95_PAD_GPIO_IO05__CAN4_RX                                  0x0024 0x0228 0x044C 0x03 0x01
+#define IMX95_PAD_GPIO_IO05__LPSPI7_SIN                               0x0024 0x0228 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO05__LPUART6_RX                               0x0024 0x0228 0x057C 0x05 0x01
+#define IMX95_PAD_GPIO_IO05__LPI2C6_SCL                               0x0024 0x0228 0x0518 0x16 0x01
+#define IMX95_PAD_GPIO_IO05__FLEXIO1_FLEXIO_BIT5                      0x0024 0x0228 0x047C 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO06__GPIO2_IO_BIT6                            0x0028 0x022C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO06__TPM5_CH0                                 0x0028 0x022C 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO06__AONMIX_TOP_PDM_BIT_STREAM_BIT1           0x0028 0x022C 0x0410 0x02 0x01
+#define IMX95_PAD_GPIO_IO06__LPSPI7_SOUT                              0x0028 0x022C 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO06__LPUART6_CTS_B                            0x0028 0x022C 0x0578 0x05 0x01
+#define IMX95_PAD_GPIO_IO06__LPI2C7_SDA                               0x0028 0x022C 0x0524 0x16 0x00
+#define IMX95_PAD_GPIO_IO06__FLEXIO1_FLEXIO_BIT6                      0x0028 0x022C 0x0480 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO07__GPIO2_IO_BIT7                            0x002C 0x0230 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO07__LPSPI3_PCS1                              0x002C 0x0230 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO07__LPSPI7_SCK                               0x002C 0x0230 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO07__LPUART6_RTS_B                            0x002C 0x0230 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO07__LPI2C7_SCL                               0x002C 0x0230 0x0520 0x16 0x00
+#define IMX95_PAD_GPIO_IO07__FLEXIO1_FLEXIO_BIT7                      0x002C 0x0230 0x0484 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO08__GPIO2_IO_BIT8                            0x0030 0x0234 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO08__LPSPI3_PCS0                              0x0030 0x0234 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO08__TPM6_CH0                                 0x0030 0x0234 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO08__LPUART7_TX                               0x0030 0x0234 0x0588 0x05 0x01
+#define IMX95_PAD_GPIO_IO08__LPI2C7_SDA                               0x0030 0x0234 0x0524 0x16 0x01
+#define IMX95_PAD_GPIO_IO08__FLEXIO1_FLEXIO_BIT8                      0x0030 0x0234 0x0488 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO09__GPIO2_IO_BIT9                            0x0034 0x0238 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO09__LPSPI3_SIN                               0x0034 0x0238 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO09__TPM3_EXTCLK                              0x0034 0x0238 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO09__LPUART7_RX                               0x0034 0x0238 0x0584 0x05 0x01
+#define IMX95_PAD_GPIO_IO09__LPI2C7_SCL                               0x0034 0x0238 0x0520 0x16 0x01
+#define IMX95_PAD_GPIO_IO09__FLEXIO1_FLEXIO_BIT9                      0x0034 0x0238 0x048C 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO10__GPIO2_IO_BIT10                           0x0038 0x023C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO10__LPSPI3_SOUT                              0x0038 0x023C 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO10__TPM4_EXTCLK                              0x0038 0x023C 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO10__LPUART7_CTS_B                            0x0038 0x023C 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO10__LPI2C8_SDA                               0x0038 0x023C 0x052C 0x16 0x00
+#define IMX95_PAD_GPIO_IO10__FLEXIO1_FLEXIO_BIT10                     0x0038 0x023C 0x0490 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11                           0x003C 0x0240 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO11__LPSPI3_SCK                               0x003C 0x0240 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO11__TPM5_EXTCLK                              0x003C 0x0240 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO11__LPUART7_RTS_B                            0x003C 0x0240 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO11__LPI2C8_SCL                               0x003C 0x0240 0x0528 0x16 0x00
+#define IMX95_PAD_GPIO_IO11__FLEXIO1_FLEXIO_BIT11                     0x003C 0x0240 0x0494 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO12__GPIO2_IO_BIT12                           0x0040 0x0244 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO12__TPM3_CH2                                 0x0040 0x0244 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO12__AONMIX_TOP_PDM_BIT_STREAM_BIT2           0x0040 0x0244 0x0414 0x02 0x00
+#define IMX95_PAD_GPIO_IO12__FLEXIO1_FLEXIO_BIT12                     0x0040 0x0244 0x0498 0x03 0x00
+#define IMX95_PAD_GPIO_IO12__LPSPI8_PCS0                              0x0040 0x0244 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO12__LPUART8_TX                               0x0040 0x0244 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO12__LPI2C8_SDA                               0x0040 0x0244 0x052C 0x16 0x01
+#define IMX95_PAD_GPIO_IO12__SAI3_RX_SYNC                             0x0040 0x0244 0x0590 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO13__GPIO2_IO_BIT13                           0x0044 0x0248 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO13__TPM4_CH2                                 0x0044 0x0248 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO13__AONMIX_TOP_PDM_BIT_STREAM_BIT3           0x0044 0x0248 0x0418 0x02 0x00
+#define IMX95_PAD_GPIO_IO13__LPSPI8_SIN                               0x0044 0x0248 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO13__LPUART8_RX                               0x0044 0x0248 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO13__LPI2C8_SCL                               0x0044 0x0248 0x0528 0x16 0x01
+#define IMX95_PAD_GPIO_IO13__FLEXIO1_FLEXIO_BIT13                     0x0044 0x0248 0x049C 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO14__GPIO2_IO_BIT14                           0x0048 0x024C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO14__LPUART3_TX                               0x0048 0x024C 0x055C 0x01 0x01
+#define IMX95_PAD_GPIO_IO14__LPSPI8_SOUT                              0x0048 0x024C 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO14__LPUART8_CTS_B                            0x0048 0x024C 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO14__LPUART4_TX                               0x0048 0x024C 0x0568 0x06 0x01
+#define IMX95_PAD_GPIO_IO14__FLEXIO1_FLEXIO_BIT14                     0x0048 0x024C 0x04A0 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO15__GPIO2_IO_BIT15                           0x004C 0x0250 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO15__LPUART3_RX                               0x004C 0x0250 0x0558 0x01 0x01
+#define IMX95_PAD_GPIO_IO15__LPSPI8_SCK                               0x004C 0x0250 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO15__LPUART8_RTS_B                            0x004C 0x0250 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO15__LPUART4_RX                               0x004C 0x0250 0x0564 0x06 0x01
+#define IMX95_PAD_GPIO_IO15__FLEXIO1_FLEXIO_BIT15                     0x004C 0x0250 0x04A4 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO16__GPIO2_IO_BIT16                           0x0050 0x0254 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK                             0x0050 0x0254 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO16__AONMIX_TOP_PDM_BIT_STREAM_BIT2           0x0050 0x0254 0x0414 0x02 0x01
+#define IMX95_PAD_GPIO_IO16__LPUART3_CTS_B                            0x0050 0x0254 0x0554 0x04 0x01
+#define IMX95_PAD_GPIO_IO16__LPSPI4_PCS2                              0x0050 0x0254 0x0538 0x05 0x01
+#define IMX95_PAD_GPIO_IO16__LPUART4_CTS_B                            0x0050 0x0254 0x0560 0x06 0x01
+#define IMX95_PAD_GPIO_IO16__FLEXIO1_FLEXIO_BIT16                     0x0050 0x0254 0x04A8 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO17__GPIO2_IO_BIT17                           0x0054 0x0258 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO17__SAI3_MCLK                                0x0054 0x0258 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO17__LPUART3_RTS_B                            0x0054 0x0258 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO17__LPSPI4_PCS1                              0x0054 0x0258 0x0534 0x05 0x01
+#define IMX95_PAD_GPIO_IO17__LPUART4_RTS_B                            0x0054 0x0258 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO17__FLEXIO1_FLEXIO_BIT17                     0x0054 0x0258 0x04AC 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18                           0x0058 0x025C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO18__SAI3_RX_BCLK                             0x0058 0x025C 0x058C 0x01 0x00
+#define IMX95_PAD_GPIO_IO18__LPSPI5_PCS0                              0x0058 0x025C 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO18__LPSPI4_PCS0                              0x0058 0x025C 0x0530 0x05 0x01
+#define IMX95_PAD_GPIO_IO18__TPM5_CH2                                 0x0058 0x025C 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO18__FLEXIO1_FLEXIO_BIT18                     0x0058 0x025C 0x04B0 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO19__GPIO2_IO_BIT19                           0x005C 0x0260 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO19__SAI3_RX_SYNC                             0x005C 0x0260 0x0590 0x01 0x01
+#define IMX95_PAD_GPIO_IO19__AONMIX_TOP_PDM_BIT_STREAM_BIT3           0x005C 0x0260 0x0418 0x02 0x01
+#define IMX95_PAD_GPIO_IO19__FLEXIO1_FLEXIO_BIT19                     0x005C 0x0260 0x04B4 0x03 0x00
+#define IMX95_PAD_GPIO_IO19__LPSPI5_SIN                               0x005C 0x0260 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO19__LPSPI4_SIN                               0x005C 0x0260 0x0540 0x05 0x01
+#define IMX95_PAD_GPIO_IO19__TPM6_CH2                                 0x005C 0x0260 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO19__SAI3_TX_DATA_BIT0                        0x005C 0x0260 0x0000 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO20__GPIO2_IO_BIT20                           0x0060 0x0264 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0                        0x0060 0x0264 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO20__AONMIX_TOP_PDM_BIT_STREAM_BIT0           0x0060 0x0264 0x040C 0x02 0x02
+#define IMX95_PAD_GPIO_IO20__LPSPI5_SOUT                              0x0060 0x0264 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO20__LPSPI4_SOUT                              0x0060 0x0264 0x0544 0x05 0x01
+#define IMX95_PAD_GPIO_IO20__TPM3_CH1                                 0x0060 0x0264 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO20__FLEXIO1_FLEXIO_BIT20                     0x0060 0x0264 0x04B8 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO21__GPIO2_IO_BIT21                           0x0064 0x0268 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0                        0x0064 0x0268 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO21__AONMIX_TOP_PDM_CLK                       0x0064 0x0268 0x0000 0x02 0x00
+#define IMX95_PAD_GPIO_IO21__FLEXIO1_FLEXIO_BIT21                     0x0064 0x0268 0x04BC 0x03 0x00
+#define IMX95_PAD_GPIO_IO21__LPSPI5_SCK                               0x0064 0x0268 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO21__LPSPI4_SCK                               0x0064 0x0268 0x053C 0x05 0x01
+#define IMX95_PAD_GPIO_IO21__TPM4_CH1                                 0x0064 0x0268 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO21__SAI3_RX_BCLK                             0x0064 0x0268 0x058C 0x07 0x01
+
+#define IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22                           0x0068 0x026C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO22__USDHC3_CLK                               0x0068 0x026C 0x05C8 0x01 0x00
+#define IMX95_PAD_GPIO_IO22__SPDIF_IN                                 0x0068 0x026C 0x0454 0x02 0x02
+#define IMX95_PAD_GPIO_IO22__CAN5_TX                                  0x0068 0x026C 0x0000 0x03 0x00
+#define IMX95_PAD_GPIO_IO22__TPM5_CH1                                 0x0068 0x026C 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO22__TPM6_EXTCLK                              0x0068 0x026C 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO22__LPI2C5_SDA                               0x0068 0x026C 0x0514 0x16 0x01
+#define IMX95_PAD_GPIO_IO22__FLEXIO1_FLEXIO_BIT22                     0x0068 0x026C 0x04C0 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23                           0x006C 0x0270 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO23__USDHC3_CMD                               0x006C 0x0270 0x05CC 0x01 0x00
+#define IMX95_PAD_GPIO_IO23__SPDIF_OUT                                0x006C 0x0270 0x0000 0x02 0x00
+#define IMX95_PAD_GPIO_IO23__CAN5_RX                                  0x006C 0x0270 0x0450 0x03 0x00
+#define IMX95_PAD_GPIO_IO23__TPM6_CH1                                 0x006C 0x0270 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO23__LPI2C5_SCL                               0x006C 0x0270 0x0510 0x16 0x01
+#define IMX95_PAD_GPIO_IO23__FLEXIO1_FLEXIO_BIT23                     0x006C 0x0270 0x04C4 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO24__GPIO2_IO_BIT24                           0x0070 0x0274 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO24__USDHC3_DATA0                             0x0070 0x0274 0x05D0 0x01 0x00
+#define IMX95_PAD_GPIO_IO24__TPM3_CH3                                 0x0070 0x0274 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO24__JTAG_MUX_TDO                             0x0070 0x0274 0x0000 0x05 0x00
+#define IMX95_PAD_GPIO_IO24__LPSPI6_PCS1                              0x0070 0x0274 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO24__FLEXIO1_FLEXIO_BIT24                     0x0070 0x0274 0x04C8 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO25__GPIO2_IO_BIT25                           0x0074 0x0278 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO25__USDHC3_DATA1                             0x0074 0x0278 0x05D4 0x01 0x00
+#define IMX95_PAD_GPIO_IO25__CAN2_TX                                  0x0074 0x0278 0x0000 0x02 0x00
+#define IMX95_PAD_GPIO_IO25__TPM4_CH3                                 0x0074 0x0278 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO25__JTAG_MUX_TCK                             0x0074 0x0278 0x060C 0x05 0x01
+#define IMX95_PAD_GPIO_IO25__LPSPI7_PCS1                              0x0074 0x0278 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO25__FLEXIO1_FLEXIO_BIT25                     0x0074 0x0278 0x04CC 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO26__GPIO2_IO_BIT26                           0x0078 0x027C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO26__USDHC3_DATA2                             0x0078 0x027C 0x05D8 0x01 0x00
+#define IMX95_PAD_GPIO_IO26__AONMIX_TOP_PDM_BIT_STREAM_BIT1           0x0078 0x027C 0x0410 0x02 0x02
+#define IMX95_PAD_GPIO_IO26__FLEXIO1_FLEXIO_BIT26                     0x0078 0x027C 0x0458 0x03 0x01
+#define IMX95_PAD_GPIO_IO26__TPM5_CH3                                 0x0078 0x027C 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO26__JTAG_MUX_TDI                             0x0078 0x027C 0x0610 0x05 0x01
+#define IMX95_PAD_GPIO_IO26__LPSPI8_PCS1                              0x0078 0x027C 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC                             0x0078 0x027C 0x0000 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO27__GPIO2_IO_BIT27                           0x007C 0x0280 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO27__USDHC3_DATA3                             0x007C 0x0280 0x05DC 0x01 0x00
+#define IMX95_PAD_GPIO_IO27__CAN2_RX                                  0x007C 0x0280 0x0444 0x02 0x02
+#define IMX95_PAD_GPIO_IO27__TPM6_CH3                                 0x007C 0x0280 0x0000 0x04 0x00
+#define IMX95_PAD_GPIO_IO27__JTAG_MUX_TMS                             0x007C 0x0280 0x0614 0x05 0x01
+#define IMX95_PAD_GPIO_IO27__LPSPI5_PCS1                              0x007C 0x0280 0x0000 0x06 0x00
+#define IMX95_PAD_GPIO_IO27__FLEXIO1_FLEXIO_BIT27                     0x007C 0x0280 0x045C 0x07 0x01
+
+#define IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28                           0x0080 0x0284 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO28__LPI2C3_SDA                               0x0080 0x0284 0x0504 0x11 0x01
+#define IMX95_PAD_GPIO_IO28__CAN3_TX                                  0x0080 0x0284 0x0000 0x02 0x00
+#define IMX95_PAD_GPIO_IO28__FLEXIO1_FLEXIO_BIT28                     0x0080 0x0284 0x0000 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29                           0x0084 0x0288 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO29__LPI2C3_SCL                               0x0084 0x0288 0x0500 0x11 0x01
+#define IMX95_PAD_GPIO_IO29__CAN3_RX                                  0x0084 0x0288 0x0448 0x02 0x01
+#define IMX95_PAD_GPIO_IO29__FLEXIO1_FLEXIO_BIT29                     0x0084 0x0288 0x0000 0x07 0x00
+
+#define IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30                           0x0088 0x028C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO30__LPI2C4_SDA                               0x0088 0x028C 0x050C 0x11 0x01
+#define IMX95_PAD_GPIO_IO30__CAN5_TX                                  0x0088 0x028C 0x0000 0x02 0x00
+#define IMX95_PAD_GPIO_IO30__FLEXIO1_FLEXIO_BIT30                     0x0088 0x028C 0x0460 0x07 0x01
+
+#define IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31                           0x008C 0x0290 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO31__LPI2C4_SCL                               0x008C 0x0290 0x0508 0x11 0x01
+#define IMX95_PAD_GPIO_IO31__CAN5_RX                                  0x008C 0x0290 0x0450 0x02 0x01
+#define IMX95_PAD_GPIO_IO31__FLEXIO1_FLEXIO_BIT31                     0x008C 0x0290 0x0464 0x07 0x01
+
+#define IMX95_PAD_GPIO_IO32__GPIO5_IO_BIT12                           0x0090 0x0294 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B               0x0090 0x0294 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO32__LPUART6_TX                               0x0090 0x0294 0x0580 0x02 0x00
+#define IMX95_PAD_GPIO_IO32__LPSPI4_PCS2                              0x0090 0x0294 0x0538 0x04 0x00
+
+#define IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13                           0x0094 0x0298 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO33__LPUART6_RX                               0x0094 0x0298 0x057C 0x02 0x00
+#define IMX95_PAD_GPIO_IO33__LPSPI4_PCS1                              0x0094 0x0298 0x0534 0x04 0x00
+
+#define IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14                           0x0098 0x029C 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO34__LPUART6_CTS_B                            0x0098 0x029C 0x0578 0x02 0x00
+#define IMX95_PAD_GPIO_IO34__LPSPI4_PCS0                              0x0098 0x029C 0x0530 0x04 0x00
+
+#define IMX95_PAD_GPIO_IO35__GPIO5_IO_BIT15                           0x009C 0x02A0 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B               0x009C 0x02A0 0x0000 0x01 0x00
+#define IMX95_PAD_GPIO_IO35__LPUART6_RTS_B                            0x009C 0x02A0 0x0000 0x02 0x00
+#define IMX95_PAD_GPIO_IO35__LPSPI4_SIN                               0x009C 0x02A0 0x0540 0x04 0x00
+
+#define IMX95_PAD_GPIO_IO36__LPSPI4_SOUT                              0x00A0 0x02A4 0x0544 0x04 0x00
+#define IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16                           0x00A0 0x02A4 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO36__LPUART7_TX                               0x00A0 0x02A4 0x0588 0x02 0x00
+
+#define IMX95_PAD_GPIO_IO37__GPIO5_IO_BIT17                           0x00A4 0x02A8 0x0000 0x00 0x00
+#define IMX95_PAD_GPIO_IO37__LPUART7_RX                               0x00A4 0x02A8 0x0584 0x02 0x00
+#define IMX95_PAD_GPIO_IO37__LPSPI4_SCK                               0x00A4 0x02A8 0x053C 0x04 0x00
+
+#define IMX95_PAD_CCM_CLKO1__CCMSRCGPCMIX_TOP_CLKO_1                  0x00A8 0x02AC 0x0000 0x00 0x00
+#define IMX95_PAD_CCM_CLKO1__NETCMIX_TOP_NETC_TMR_1588_TRIG1          0x00A8 0x02AC 0x0434 0x01 0x00
+#define IMX95_PAD_CCM_CLKO1__FLEXIO1_FLEXIO_BIT26                     0x00A8 0x02AC 0x0458 0x04 0x00
+#define IMX95_PAD_CCM_CLKO1__GPIO3_IO_BIT26                           0x00A8 0x02AC 0x0000 0x05 0x00
+
+#define IMX95_PAD_CCM_CLKO2__GPIO3_IO_BIT27                           0x00AC 0x02B0 0x0000 0x05 0x00
+#define IMX95_PAD_CCM_CLKO2__CCMSRCGPCMIX_TOP_CLKO_2                  0x00AC 0x02B0 0x0000 0x00 0x00
+#define IMX95_PAD_CCM_CLKO2__NETCMIX_TOP_NETC_TMR_1588_PP1            0x00AC 0x02B0 0x0000 0x01 0x00
+#define IMX95_PAD_CCM_CLKO2__FLEXIO1_FLEXIO_BIT27                     0x00AC 0x02B0 0x045C 0x04 0x00
+
+#define IMX95_PAD_CCM_CLKO3__CCMSRCGPCMIX_TOP_CLKO_3                  0x00B0 0x02B4 0x0000 0x00 0x00
+#define IMX95_PAD_CCM_CLKO3__NETCMIX_TOP_NETC_TMR_1588_TRIG2          0x00B0 0x02B4 0x0438 0x01 0x00
+#define IMX95_PAD_CCM_CLKO3__CAN3_TX                                  0x00B0 0x02B4 0x0000 0x02 0x00
+#define IMX95_PAD_CCM_CLKO3__FLEXIO2_FLEXIO_BIT28                     0x00B0 0x02B4 0x0000 0x04 0x00
+#define IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28                           0x00B0 0x02B4 0x0000 0x05 0x00
+
+#define IMX95_PAD_CCM_CLKO4__CCMSRCGPCMIX_TOP_CLKO_4                  0x00B4 0x02B8 0x0000 0x00 0x00
+#define IMX95_PAD_CCM_CLKO4__NETCMIX_TOP_NETC_TMR_1588_PP2            0x00B4 0x02B8 0x0000 0x01 0x00
+#define IMX95_PAD_CCM_CLKO4__CAN3_RX                                  0x00B4 0x02B8 0x0448 0x02 0x00
+#define IMX95_PAD_CCM_CLKO4__FLEXIO2_FLEXIO_BIT29                     0x00B4 0x02B8 0x0000 0x04 0x00
+#define IMX95_PAD_CCM_CLKO4__GPIO4_IO_BIT29                           0x00B4 0x02B8 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC                     0x00B8 0x02BC 0x0424 0x00 0x00
+#define IMX95_PAD_ENET1_MDC__LPUART3_DCD_B                            0x00B8 0x02BC 0x0000 0x01 0x00
+#define IMX95_PAD_ENET1_MDC__I3C2_SCL                                 0x00B8 0x02BC 0x04F8 0x02 0x00
+#define IMX95_PAD_ENET1_MDC__HSIOMIX_TOP_USB1_OTG_ID                  0x00B8 0x02BC 0x0000 0x03 0x00
+#define IMX95_PAD_ENET1_MDC__FLEXIO2_FLEXIO_BIT0                      0x00B8 0x02BC 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_MDC__GPIO4_IO_BIT0                            0x00B8 0x02BC 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO                   0x00BC 0x02C0 0x0428 0x00 0x00
+#define IMX95_PAD_ENET1_MDIO__LPUART3_RIN_B                           0x00BC 0x02C0 0x0000 0x01 0x00
+#define IMX95_PAD_ENET1_MDIO__I3C2_SDA                                0x00BC 0x02C0 0x04FC 0x02 0x00
+#define IMX95_PAD_ENET1_MDIO__HSIOMIX_TOP_USB1_OTG_PWR                0x00BC 0x02C0 0x0000 0x03 0x00
+#define IMX95_PAD_ENET1_MDIO__FLEXIO2_FLEXIO_BIT1                     0x00BC 0x02C0 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_MDIO__GPIO4_IO_BIT1                           0x00BC 0x02C0 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3               0x00C0 0x02C4 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_TD3__CAN2_TX                                  0x00C0 0x02C4 0x0000 0x02 0x00
+#define IMX95_PAD_ENET1_TD3__HSIOMIX_TOP_USB2_OTG_ID                  0x00C0 0x02C4 0x0000 0x03 0x00
+#define IMX95_PAD_ENET1_TD3__FLEXIO2_FLEXIO_BIT2                      0x00C0 0x02C4 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_TD3__GPIO4_IO_BIT2                            0x00C0 0x02C4 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2               0x00C4 0x02C8 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RMII_REF50_CLK          0x00C4 0x02C8 0x0000 0x01 0x00
+#define IMX95_PAD_ENET1_TD2__CAN2_RX                                  0x00C4 0x02C8 0x0444 0x02 0x01
+#define IMX95_PAD_ENET1_TD2__HSIOMIX_TOP_USB2_OTG_OC                  0x00C4 0x02C8 0x0000 0x03 0x00
+#define IMX95_PAD_ENET1_TD2__FLEXIO2_FLEXIO_BIT3                      0x00C4 0x02C8 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_TD2__GPIO4_IO_BIT3                            0x00C4 0x02C8 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1               0x00C8 0x02CC 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_TD1__LPUART3_RTS_B                            0x00C8 0x02CC 0x0000 0x01 0x00
+#define IMX95_PAD_ENET1_TD1__I3C2_PUR                                 0x00C8 0x02CC 0x0000 0x02 0x00
+#define IMX95_PAD_ENET1_TD1__HSIOMIX_TOP_USB1_OTG_OC                  0x00C8 0x02CC 0x0000 0x03 0x00
+#define IMX95_PAD_ENET1_TD1__FLEXIO2_FLEXIO_BIT4                      0x00C8 0x02CC 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_TD1__GPIO4_IO_BIT4                            0x00C8 0x02CC 0x0000 0x05 0x00
+#define IMX95_PAD_ENET1_TD1__I3C2_PUR_B                               0x00C8 0x02CC 0x0000 0x06 0x00
+#define IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RMII_TXD1               0x00C8 0x02CC 0x0000 0x07 0x00
+
+#define IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0               0x00CC 0x02D0 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_TD0__LPUART3_TX                               0x00CC 0x02D0 0x055C 0x01 0x00
+#define IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RMII_TXD0               0x00CC 0x02D0 0x0000 0x02 0x00
+#define IMX95_PAD_ENET1_TD0__FLEXIO2_FLEXIO_BIT5                      0x00CC 0x02D0 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_TD0__GPIO4_IO_BIT5                            0x00CC 0x02D0 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL         0x00D0 0x02D4 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_TX_CTL__LPUART3_DTR_B                         0x00D0 0x02D4 0x0000 0x01 0x00
+#define IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RMII_TX_EN           0x00D0 0x02D4 0x0000 0x02 0x00
+#define IMX95_PAD_ENET1_TX_CTL__FLEXIO2_FLEXIO_BIT6                   0x00D0 0x02D4 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_TX_CTL__GPIO4_IO_BIT6                         0x00D0 0x02D4 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK            0x00D4 0x02D8 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_TXC__CCMSRCGPCMIX_TOP_ENET_CLK_ROOT           0x00D4 0x02D8 0x0000 0x01 0x00
+#define IMX95_PAD_ENET1_TXC__FLEXIO2_FLEXIO_BIT7                      0x00D4 0x02D8 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_TXC__GPIO4_IO_BIT7                            0x00D4 0x02D8 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL         0x00D8 0x02DC 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_RX_CTL__LPUART3_DSR_B                         0x00D8 0x02DC 0x0000 0x01 0x00
+#define IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RMII_CRS_DV          0x00D8 0x02DC 0x0000 0x02 0x00
+#define IMX95_PAD_ENET1_RX_CTL__HSIOMIX_TOP_USB2_OTG_PWR              0x00D8 0x02DC 0x0000 0x03 0x00
+#define IMX95_PAD_ENET1_RX_CTL__FLEXIO2_FLEXIO_BIT8                   0x00D8 0x02DC 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_RX_CTL__GPIO4_IO_BIT8                         0x00D8 0x02DC 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK            0x00DC 0x02E0 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RMII_RX_ER              0x00DC 0x02E0 0x042C 0x01 0x00
+#define IMX95_PAD_ENET1_RXC__FLEXIO2_FLEXIO_BIT9                      0x00DC 0x02E0 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_RXC__GPIO4_IO_BIT9                            0x00DC 0x02E0 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0               0x00E0 0x02E4 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_RD0__LPUART3_RX                               0x00E0 0x02E4 0x0558 0x01 0x00
+#define IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RMII_RXD0               0x00E0 0x02E4 0x0000 0x02 0x00
+#define IMX95_PAD_ENET1_RD0__FLEXIO2_FLEXIO_BIT10                     0x00E0 0x02E4 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_RD0__GPIO4_IO_BIT10                           0x00E0 0x02E4 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1               0x00E4 0x02E8 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_RD1__LPUART3_CTS_B                            0x00E4 0x02E8 0x0554 0x01 0x00
+#define IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RMII_RXD1               0x00E4 0x02E8 0x0000 0x02 0x00
+#define IMX95_PAD_ENET1_RD1__LPTMR2_ALT1                              0x00E4 0x02E8 0x0548 0x03 0x00
+#define IMX95_PAD_ENET1_RD1__FLEXIO2_FLEXIO_BIT11                     0x00E4 0x02E8 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_RD1__GPIO4_IO_BIT11                           0x00E4 0x02E8 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2               0x00E8 0x02EC 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RMII_RX_ER              0x00E8 0x02EC 0x042C 0x02 0x01
+#define IMX95_PAD_ENET1_RD2__LPTMR2_ALT2                              0x00E8 0x02EC 0x054C 0x03 0x00
+#define IMX95_PAD_ENET1_RD2__FLEXIO2_FLEXIO_BIT12                     0x00E8 0x02EC 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_RD2__GPIO4_IO_BIT12                           0x00E8 0x02EC 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3               0x00EC 0x02F0 0x0000 0x00 0x00
+#define IMX95_PAD_ENET1_RD3__LPTMR2_ALT3                              0x00EC 0x02F0 0x0550 0x03 0x00
+#define IMX95_PAD_ENET1_RD3__FLEXIO2_FLEXIO_BIT13                     0x00EC 0x02F0 0x0000 0x04 0x00
+#define IMX95_PAD_ENET1_RD3__GPIO4_IO_BIT13                           0x00EC 0x02F0 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC                     0x00F0 0x02F4 0x0424 0x00 0x01
+#define IMX95_PAD_ENET2_MDC__LPUART4_DCD_B                            0x00F0 0x02F4 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC                 0x00F0 0x02F4 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_MDC__FLEXIO2_FLEXIO_BIT14                     0x00F0 0x02F4 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_MDC__GPIO4_IO_BIT14                           0x00F0 0x02F4 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO                   0x00F4 0x02F8 0x0428 0x00 0x01
+#define IMX95_PAD_ENET2_MDIO__LPUART4_RIN_B                           0x00F4 0x02F8 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK                0x00F4 0x02F8 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_MDIO__FLEXIO2_FLEXIO_BIT15                    0x00F4 0x02F8 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_MDIO__GPIO4_IO_BIT15                          0x00F4 0x02F8 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0            0x00F8 0x02FC 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_TD3__FLEXIO2_FLEXIO_BIT16                     0x00F8 0x02FC 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_TD3__GPIO4_IO_BIT16                           0x00F8 0x02FC 0x0000 0x05 0x00
+#define IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3               0x00F8 0x02FC 0x0000 0x00 0x00
+
+#define IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2               0x00FC 0x0300 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RMII_REF50_CLK          0x00FC 0x0300 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_BIT1            0x00FC 0x0300 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_TD2__SAI4_TX_SYNC                             0x00FC 0x0300 0x05A4 0x03 0x00
+#define IMX95_PAD_ENET2_TD2__FLEXIO2_FLEXIO_BIT17                     0x00FC 0x0300 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_TD2__GPIO4_IO_BIT17                           0x00FC 0x0300 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1               0x0100 0x0304 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_TD1__LPUART4_RTS_B                            0x0100 0x0304 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_TD1__NETCMIX_TOP_SAI2_RX_DATA_BIT2            0x0100 0x0304 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_TD1__SAI4_TX_BCLK                             0x0100 0x0304 0x05A0 0x03 0x00
+#define IMX95_PAD_ENET2_TD1__FLEXIO2_FLEXIO_BIT18                     0x0100 0x0304 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_TD1__GPIO4_IO_BIT18                           0x0100 0x0304 0x0000 0x05 0x00
+#define IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RMII_TXD1               0x0100 0x0304 0x0000 0x06 0x00
+
+#define IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0               0x0104 0x0308 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_TD0__LPUART4_TX                               0x0104 0x0308 0x0568 0x01 0x00
+#define IMX95_PAD_ENET2_TD0__NETCMIX_TOP_SAI2_RX_DATA_BIT3            0x0104 0x0308 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_TD0__SAI4_TX_DATA_BIT0                        0x0104 0x0308 0x0000 0x03 0x00
+#define IMX95_PAD_ENET2_TD0__FLEXIO2_FLEXIO_BIT19                     0x0104 0x0308 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_TD0__GPIO4_IO_BIT19                           0x0104 0x0308 0x0000 0x05 0x00
+#define IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RMII_TXD0               0x0104 0x0308 0x0000 0x06 0x00
+
+#define IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL         0x0108 0x030C 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_TX_CTL__LPUART4_DTR_B                         0x0108 0x030C 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC              0x0108 0x030C 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RMII_TX_EN           0x0108 0x030C 0x0000 0x03 0x00
+#define IMX95_PAD_ENET2_TX_CTL__FLEXIO2_FLEXIO_BIT20                  0x0108 0x030C 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_TX_CTL__GPIO4_IO_BIT20                        0x0108 0x030C 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK            0x010C 0x0310 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_TXC__CCMSRCGPCMIX_TOP_ENET_CLK_ROOT           0x010C 0x0310 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK                 0x010C 0x0310 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_TXC__FLEXIO2_FLEXIO_BIT21                     0x010C 0x0310 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_TXC__GPIO4_IO_BIT21                           0x010C 0x0310 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL         0x0110 0x0314 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_RX_CTL__LPUART4_DSR_B                         0x0110 0x0314 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0         0x0110 0x0314 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_RX_CTL__FLEXIO2_FLEXIO_BIT22                  0x0110 0x0314 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_RX_CTL__GPIO4_IO_BIT22                        0x0110 0x0314 0x0000 0x05 0x00
+#define IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RMII_CRS_DV          0x0110 0x0314 0x0000 0x06 0x00
+
+#define IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK            0x0114 0x0318 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RMII_RX_ER              0x0114 0x0318 0x0430 0x01 0x00
+#define IMX95_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_BIT1            0x0114 0x0318 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_RXC__SAI4_RX_SYNC                             0x0114 0x0318 0x059C 0x03 0x00
+#define IMX95_PAD_ENET2_RXC__FLEXIO2_FLEXIO_BIT23                     0x0114 0x0318 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_RXC__GPIO4_IO_BIT23                           0x0114 0x0318 0x0000 0x05 0x00
+
+#define IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0               0x0118 0x031C 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_RD0__LPUART4_RX                               0x0118 0x031C 0x0564 0x01 0x00
+#define IMX95_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_BIT2            0x0118 0x031C 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_RD0__SAI4_RX_BCLK                             0x0118 0x031C 0x0594 0x03 0x00
+#define IMX95_PAD_ENET2_RD0__FLEXIO2_FLEXIO_BIT24                     0x0118 0x031C 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_RD0__GPIO4_IO_BIT24                           0x0118 0x031C 0x0000 0x05 0x00
+#define IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RMII_RXD0               0x0118 0x031C 0x0000 0x06 0x00
+
+#define IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1               0x011C 0x0320 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_RD1__SPDIF_IN                                 0x011C 0x0320 0x0454 0x01 0x00
+#define IMX95_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_BIT3            0x011C 0x0320 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_RD1__SAI4_RX_DATA_BIT0                        0x011C 0x0320 0x0598 0x03 0x00
+#define IMX95_PAD_ENET2_RD1__FLEXIO2_FLEXIO_BIT25                     0x011C 0x0320 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_RD1__GPIO4_IO_BIT25                           0x011C 0x0320 0x0000 0x05 0x00
+#define IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RMII_RXD1               0x011C 0x0320 0x0000 0x06 0x00
+
+#define IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2               0x0120 0x0324 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_RD2__LPUART4_CTS_B                            0x0120 0x0324 0x0560 0x01 0x00
+#define IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK                    0x0120 0x0324 0x0000 0x02 0x00
+#define IMX95_PAD_ENET2_RD2__NETCMIX_TOP_MQS2_RIGHT                   0x0120 0x0324 0x0000 0x03 0x00
+#define IMX95_PAD_ENET2_RD2__FLEXIO2_FLEXIO_BIT26                     0x0120 0x0324 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_RD2__GPIO4_IO_BIT26                           0x0120 0x0324 0x0000 0x05 0x00
+#define IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RMII_RX_ER              0x0120 0x0324 0x0430 0x06 0x01
+
+#define IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3               0x0124 0x0328 0x0000 0x00 0x00
+#define IMX95_PAD_ENET2_RD3__SPDIF_OUT                                0x0124 0x0328 0x0000 0x01 0x00
+#define IMX95_PAD_ENET2_RD3__SPDIF_IN                                 0x0124 0x0328 0x0454 0x02 0x01
+#define IMX95_PAD_ENET2_RD3__NETCMIX_TOP_MQS2_LEFT                    0x0124 0x0328 0x0000 0x03 0x00
+#define IMX95_PAD_ENET2_RD3__FLEXIO2_FLEXIO_BIT27                     0x0124 0x0328 0x0000 0x04 0x00
+#define IMX95_PAD_ENET2_RD3__GPIO4_IO_BIT27                           0x0124 0x0328 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD1_CLK__FLEXIO1_FLEXIO_BIT8                        0x0128 0x032C 0x0488 0x04 0x01
+#define IMX95_PAD_SD1_CLK__GPIO3_IO_BIT8                              0x0128 0x032C 0x0000 0x05 0x00
+#define IMX95_PAD_SD1_CLK__USDHC1_CLK                                 0x0128 0x032C 0x0000 0x00 0x00
+
+#define IMX95_PAD_SD1_CMD__USDHC1_CMD                                 0x012C 0x0330 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_CMD__FLEXIO1_FLEXIO_BIT9                        0x012C 0x0330 0x048C 0x04 0x01
+#define IMX95_PAD_SD1_CMD__GPIO3_IO_BIT9                              0x012C 0x0330 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD1_DATA0__USDHC1_DATA0                             0x0130 0x0334 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA0__FLEXIO1_FLEXIO_BIT10                     0x0130 0x0334 0x0490 0x04 0x01
+#define IMX95_PAD_SD1_DATA0__GPIO3_IO_BIT10                           0x0130 0x0334 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD1_DATA1__USDHC1_DATA1                             0x0134 0x0338 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA1__FLEXIO1_FLEXIO_BIT11                     0x0134 0x0338 0x0494 0x04 0x01
+#define IMX95_PAD_SD1_DATA1__GPIO3_IO_BIT11                           0x0134 0x0338 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD1_DATA2__USDHC1_DATA2                             0x0138 0x033C 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA2__FLEXIO1_FLEXIO_BIT12                     0x0138 0x033C 0x0498 0x04 0x01
+#define IMX95_PAD_SD1_DATA2__GPIO3_IO_BIT12                           0x0138 0x033C 0x0000 0x05 0x00
+#define IMX95_PAD_SD1_DATA2__CCMSRCGPCMIX_TOP_PMIC_READY              0x0138 0x033C 0x0000 0x06 0x00
+
+#define IMX95_PAD_SD1_DATA3__USDHC1_DATA3                             0x013C 0x0340 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA3__FLEXSPI1_A_SS1_B                         0x013C 0x0340 0x0000 0x01 0x00
+#define IMX95_PAD_SD1_DATA3__FLEXIO1_FLEXIO_BIT13                     0x013C 0x0340 0x049C 0x04 0x01
+#define IMX95_PAD_SD1_DATA3__GPIO3_IO_BIT13                           0x013C 0x0340 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD1_DATA4__USDHC1_DATA4                             0x0140 0x0344 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA4__FLEXSPI1_A_DATA_BIT4                     0x0140 0x0344 0x04E4 0x01 0x00
+#define IMX95_PAD_SD1_DATA4__FLEXIO1_FLEXIO_BIT14                     0x0140 0x0344 0x04A0 0x04 0x01
+#define IMX95_PAD_SD1_DATA4__GPIO3_IO_BIT14                           0x0140 0x0344 0x0000 0x05 0x00
+#define IMX95_PAD_SD1_DATA4__XSPI_DATA_BIT4                           0x0140 0x0344 0x05FC 0x06 0x00
+
+#define IMX95_PAD_SD1_DATA5__USDHC1_DATA5                             0x0144 0x0348 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA5__FLEXSPI1_A_DATA_BIT5                     0x0144 0x0348 0x04E8 0x01 0x00
+#define IMX95_PAD_SD1_DATA5__USDHC1_RESET_B                           0x0144 0x0348 0x0000 0x02 0x00
+#define IMX95_PAD_SD1_DATA5__FLEXIO1_FLEXIO_BIT15                     0x0144 0x0348 0x04A4 0x04 0x01
+#define IMX95_PAD_SD1_DATA5__GPIO3_IO_BIT15                           0x0144 0x0348 0x0000 0x05 0x00
+#define IMX95_PAD_SD1_DATA5__XSPI_DATA_BIT5                           0x0144 0x0348 0x0600 0x06 0x00
+
+#define IMX95_PAD_SD1_DATA6__USDHC1_DATA6                             0x0148 0x034C 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA6__FLEXSPI1_A_DATA_BIT6                     0x0148 0x034C 0x04EC 0x01 0x00
+#define IMX95_PAD_SD1_DATA6__USDHC1_CD_B                              0x0148 0x034C 0x0000 0x02 0x00
+#define IMX95_PAD_SD1_DATA6__FLEXIO1_FLEXIO_BIT16                     0x0148 0x034C 0x04A8 0x04 0x01
+#define IMX95_PAD_SD1_DATA6__GPIO3_IO_BIT16                           0x0148 0x034C 0x0000 0x05 0x00
+#define IMX95_PAD_SD1_DATA6__XSPI_DATA_BIT6                           0x0148 0x034C 0x0604 0x06 0x00
+
+#define IMX95_PAD_SD1_DATA7__USDHC1_DATA7                             0x014C 0x0350 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_DATA7__FLEXSPI1_A_DATA_BIT7                     0x014C 0x0350 0x04F0 0x01 0x00
+#define IMX95_PAD_SD1_DATA7__USDHC1_WP                                0x014C 0x0350 0x0000 0x02 0x00
+#define IMX95_PAD_SD1_DATA7__FLEXIO1_FLEXIO_BIT17                     0x014C 0x0350 0x04AC 0x04 0x01
+#define IMX95_PAD_SD1_DATA7__GPIO3_IO_BIT17                           0x014C 0x0350 0x0000 0x05 0x00
+#define IMX95_PAD_SD1_DATA7__XSPI_DATA_BIT7                           0x014C 0x0350 0x0608 0x06 0x00
+
+#define IMX95_PAD_SD1_STROBE__USDHC1_STROBE                           0x0150 0x0354 0x0000 0x00 0x00
+#define IMX95_PAD_SD1_STROBE__FLEXSPI1_A_DQS                          0x0150 0x0354 0x04D0 0x01 0x00
+#define IMX95_PAD_SD1_STROBE__FLEXIO1_FLEXIO_BIT18                    0x0150 0x0354 0x04B0 0x04 0x01
+#define IMX95_PAD_SD1_STROBE__GPIO3_IO_BIT18                          0x0150 0x0354 0x0000 0x05 0x00
+#define IMX95_PAD_SD1_STROBE__XSPI_DQS                                0x0150 0x0354 0x05E4 0x06 0x00
+
+#define IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT                         0x0154 0x0358 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_VSELECT__USDHC2_WP                              0x0154 0x0358 0x0000 0x01 0x00
+#define IMX95_PAD_SD2_VSELECT__LPTMR2_ALT3                            0x0154 0x0358 0x0550 0x02 0x01
+#define IMX95_PAD_SD2_VSELECT__FLEXIO1_FLEXIO_BIT19                   0x0154 0x0358 0x04B4 0x04 0x01
+#define IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19                         0x0154 0x0358 0x0000 0x05 0x00
+#define IMX95_PAD_SD2_VSELECT__CCMSRCGPCMIX_TOP_EXT_CLK1              0x0154 0x0358 0x0420 0x06 0x01
+
+#define IMX95_PAD_SD3_CLK__USDHC3_CLK                                 0x0158 0x035C 0x05C8 0x00 0x01
+#define IMX95_PAD_SD3_CLK__FLEXSPI1_A_SCLK                            0x0158 0x035C 0x04F4 0x01 0x00
+#define IMX95_PAD_SD3_CLK__SAI5_TX_DATA_BIT1                          0x0158 0x035C 0x0000 0x02 0x00
+#define IMX95_PAD_SD3_CLK__SAI5_RX_DATA_BIT0                          0x0158 0x035C 0x05AC 0x03 0x00
+#define IMX95_PAD_SD3_CLK__FLEXIO1_FLEXIO_BIT20                       0x0158 0x035C 0x04B8 0x04 0x01
+#define IMX95_PAD_SD3_CLK__GPIO3_IO_BIT20                             0x0158 0x035C 0x0000 0x05 0x00
+#define IMX95_PAD_SD3_CLK__XSPI_CLK                                   0x0158 0x035C 0x05E8 0x06 0x00
+
+#define IMX95_PAD_SD3_CMD__USDHC3_CMD                                 0x015C 0x0360 0x05CC 0x00 0x01
+#define IMX95_PAD_SD3_CMD__FLEXSPI1_A_SS0_B                           0x015C 0x0360 0x0000 0x01 0x00
+#define IMX95_PAD_SD3_CMD__SAI5_TX_DATA_BIT2                          0x015C 0x0360 0x0000 0x02 0x00
+#define IMX95_PAD_SD3_CMD__SAI5_RX_SYNC                               0x015C 0x0360 0x05BC 0x03 0x00
+#define IMX95_PAD_SD3_CMD__FLEXIO1_FLEXIO_BIT21                       0x015C 0x0360 0x04BC 0x04 0x01
+#define IMX95_PAD_SD3_CMD__GPIO3_IO_BIT21                             0x015C 0x0360 0x0000 0x05 0x00
+#define IMX95_PAD_SD3_CMD__XSPI_CS                                    0x015C 0x0360 0x05E0 0x06 0x00
+
+#define IMX95_PAD_SD3_DATA0__USDHC3_DATA0                             0x0160 0x0364 0x05D0 0x00 0x01
+#define IMX95_PAD_SD3_DATA0__FLEXSPI1_A_DATA_BIT0                     0x0160 0x0364 0x04D4 0x01 0x00
+#define IMX95_PAD_SD3_DATA0__SAI5_TX_DATA_BIT3                        0x0160 0x0364 0x0000 0x02 0x00
+#define IMX95_PAD_SD3_DATA0__SAI5_RX_BCLK                             0x0160 0x0364 0x05A8 0x03 0x00
+#define IMX95_PAD_SD3_DATA0__FLEXIO1_FLEXIO_BIT22                     0x0160 0x0364 0x04C0 0x04 0x01
+#define IMX95_PAD_SD3_DATA0__GPIO3_IO_BIT22                           0x0160 0x0364 0x0000 0x05 0x00
+#define IMX95_PAD_SD3_DATA0__XSPI_DATA_BIT0                           0x0160 0x0364 0x05EC 0x06 0x00
+
+#define IMX95_PAD_SD3_DATA1__USDHC3_DATA1                             0x0164 0x0368 0x05D4 0x00 0x01
+#define IMX95_PAD_SD3_DATA1__FLEXSPI1_A_DATA_BIT1                     0x0164 0x0368 0x04D8 0x01 0x00
+#define IMX95_PAD_SD3_DATA1__SAI5_RX_DATA_BIT1                        0x0164 0x0368 0x05B0 0x02 0x00
+#define IMX95_PAD_SD3_DATA1__SAI5_TX_DATA_BIT0                        0x0164 0x0368 0x0000 0x03 0x00
+#define IMX95_PAD_SD3_DATA1__FLEXIO1_FLEXIO_BIT23                     0x0164 0x0368 0x04C4 0x04 0x01
+#define IMX95_PAD_SD3_DATA1__GPIO3_IO_BIT23                           0x0164 0x0368 0x0000 0x05 0x00
+#define IMX95_PAD_SD3_DATA1__XSPI_DATA_BIT1                           0x0164 0x0368 0x05F0 0x06 0x00
+
+#define IMX95_PAD_SD3_DATA2__USDHC3_DATA2                             0x0168 0x036C 0x05D8 0x00 0x01
+#define IMX95_PAD_SD3_DATA2__FLEXSPI1_A_DATA_BIT2                     0x0168 0x036C 0x04DC 0x01 0x00
+#define IMX95_PAD_SD3_DATA2__SAI5_RX_DATA_BIT2                        0x0168 0x036C 0x05B4 0x02 0x00
+#define IMX95_PAD_SD3_DATA2__SAI5_TX_SYNC                             0x0168 0x036C 0x05C4 0x03 0x00
+#define IMX95_PAD_SD3_DATA2__FLEXIO1_FLEXIO_BIT24                     0x0168 0x036C 0x04C8 0x04 0x01
+#define IMX95_PAD_SD3_DATA2__GPIO3_IO_BIT24                           0x0168 0x036C 0x0000 0x05 0x00
+#define IMX95_PAD_SD3_DATA2__XSPI_DATA_BIT2                           0x0168 0x036C 0x05F4 0x06 0x00
+
+#define IMX95_PAD_SD3_DATA3__USDHC3_DATA3                             0x016C 0x0370 0x05DC 0x00 0x01
+#define IMX95_PAD_SD3_DATA3__FLEXSPI1_A_DATA_BIT3                     0x016C 0x0370 0x04E0 0x01 0x00
+#define IMX95_PAD_SD3_DATA3__SAI5_RX_DATA_BIT3                        0x016C 0x0370 0x05B8 0x02 0x00
+#define IMX95_PAD_SD3_DATA3__SAI5_TX_BCLK                             0x016C 0x0370 0x05C0 0x03 0x00
+#define IMX95_PAD_SD3_DATA3__FLEXIO1_FLEXIO_BIT25                     0x016C 0x0370 0x04CC 0x04 0x01
+#define IMX95_PAD_SD3_DATA3__GPIO3_IO_BIT25                           0x016C 0x0370 0x0000 0x05 0x00
+#define IMX95_PAD_SD3_DATA3__XSPI_DATA_BIT3                           0x016C 0x0370 0x05F8 0x06 0x00
+
+#define IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0                   0x0170 0x0374 0x04D4 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA0__NETCMIX_TOP_SAI2_TX_DATA_BIT4          0x0170 0x0374 0x0000 0x01 0x00
+#define IMX95_PAD_XSPI1_DATA0__SAI4_TX_BCLK                           0x0170 0x0374 0x05A0 0x02 0x01
+#define IMX95_PAD_XSPI1_DATA0__SAI4_RX_DATA_BIT1                      0x0170 0x0374 0x0000 0x03 0x00
+#define IMX95_PAD_XSPI1_DATA0__XSPI_DATA_BIT0                         0x0170 0x0374 0x05EC 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA0__GPIO5_IO_BIT0                          0x0170 0x0374 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1                   0x0174 0x0378 0x04D8 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA1__NETCMIX_TOP_SAI2_TX_DATA_BIT5          0x0174 0x0378 0x0000 0x01 0x00
+#define IMX95_PAD_XSPI1_DATA1__SAI4_TX_SYNC                           0x0174 0x0378 0x05A4 0x02 0x01
+#define IMX95_PAD_XSPI1_DATA1__SAI4_TX_DATA_BIT1                      0x0174 0x0378 0x0000 0x03 0x00
+#define IMX95_PAD_XSPI1_DATA1__XSPI_DATA_BIT1                         0x0174 0x0378 0x05F0 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA1__GPIO5_IO_BIT1                          0x0174 0x0378 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2                   0x0178 0x037C 0x04DC 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA2__NETCMIX_TOP_SAI2_TX_DATA_BIT6          0x0178 0x037C 0x0000 0x01 0x00
+#define IMX95_PAD_XSPI1_DATA2__SAI4_TX_DATA_BIT0                      0x0178 0x037C 0x0000 0x02 0x00
+#define IMX95_PAD_XSPI1_DATA2__XSPI_DATA_BIT2                         0x0178 0x037C 0x05F4 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA2__GPIO5_IO_BIT2                          0x0178 0x037C 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3                   0x017C 0x0380 0x04E0 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA3__NETCMIX_TOP_SAI2_TX_DATA_BIT7          0x017C 0x0380 0x0000 0x01 0x00
+#define IMX95_PAD_XSPI1_DATA3__SAI4_RX_DATA_BIT0                      0x017C 0x0380 0x0598 0x02 0x01
+#define IMX95_PAD_XSPI1_DATA3__XSPI_DATA_BIT3                         0x017C 0x0380 0x05F8 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA3__GPIO5_IO_BIT3                          0x017C 0x0380 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DATA4__FLEXSPI1_A_DATA_BIT4                   0x0180 0x0384 0x04E4 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA4__SAI5_TX_DATA_BIT0                      0x0180 0x0384 0x0000 0x01 0x00
+#define IMX95_PAD_XSPI1_DATA4__SAI5_RX_DATA_BIT1                      0x0180 0x0384 0x05B0 0x02 0x01
+#define IMX95_PAD_XSPI1_DATA4__XSPI_DATA_BIT4                         0x0180 0x0384 0x05FC 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA4__GPIO5_IO_BIT4                          0x0180 0x0384 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DATA5__FLEXSPI1_A_DATA_BIT5                   0x0184 0x0388 0x04E8 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA5__SAI5_TX_SYNC                           0x0184 0x0388 0x05C4 0x01 0x01
+#define IMX95_PAD_XSPI1_DATA5__SAI5_RX_DATA_BIT2                      0x0184 0x0388 0x05B4 0x02 0x01
+#define IMX95_PAD_XSPI1_DATA5__NETCMIX_TOP_SAI2_RX_DATA_BIT6          0x0184 0x0388 0x043C 0x03 0x00
+#define IMX95_PAD_XSPI1_DATA5__XSPI_DATA_BIT5                         0x0184 0x0388 0x0600 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA5__GPIO5_IO_BIT5                          0x0184 0x0388 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DATA6__FLEXSPI1_A_DATA_BIT6                   0x0188 0x038C 0x04EC 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA6__SAI5_TX_BCLK                           0x0188 0x038C 0x05C0 0x01 0x01
+#define IMX95_PAD_XSPI1_DATA6__SAI5_RX_DATA_BIT3                      0x0188 0x038C 0x05B8 0x02 0x01
+#define IMX95_PAD_XSPI1_DATA6__NETCMIX_TOP_SAI2_RX_DATA_BIT7          0x0188 0x038C 0x0440 0x03 0x00
+#define IMX95_PAD_XSPI1_DATA6__XSPI_DATA_BIT6                         0x0188 0x038C 0x0604 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA6__GPIO5_IO_BIT6                          0x0188 0x038C 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DATA7__FLEXSPI1_A_DATA_BIT7                   0x018C 0x0390 0x04F0 0x00 0x01
+#define IMX95_PAD_XSPI1_DATA7__SAI5_RX_DATA_BIT0                      0x018C 0x0390 0x05AC 0x01 0x01
+#define IMX95_PAD_XSPI1_DATA7__SAI5_TX_DATA_BIT1                      0x018C 0x0390 0x0000 0x02 0x00
+#define IMX95_PAD_XSPI1_DATA7__XSPI_DATA_BIT7                         0x018C 0x0390 0x0608 0x04 0x01
+#define IMX95_PAD_XSPI1_DATA7__GPIO5_IO_BIT7                          0x018C 0x0390 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS                           0x0190 0x0394 0x04D0 0x00 0x01
+#define IMX95_PAD_XSPI1_DQS__SAI5_RX_SYNC                             0x0190 0x0394 0x05BC 0x01 0x01
+#define IMX95_PAD_XSPI1_DQS__SAI5_TX_DATA_BIT2                        0x0190 0x0394 0x0000 0x02 0x00
+#define IMX95_PAD_XSPI1_DQS__NETCMIX_TOP_SAI2_RX_DATA_BIT6            0x0190 0x0394 0x043C 0x03 0x01
+#define IMX95_PAD_XSPI1_DQS__XSPI_DQS                                 0x0190 0x0394 0x05E4 0x04 0x01
+#define IMX95_PAD_XSPI1_DQS__GPIO5_IO_BIT8                            0x0190 0x0394 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK                         0x0194 0x0398 0x04F4 0x00 0x01
+#define IMX95_PAD_XSPI1_SCLK__NETCMIX_TOP_SAI2_RX_DATA_BIT4           0x0194 0x0398 0x0000 0x01 0x00
+#define IMX95_PAD_XSPI1_SCLK__SAI4_RX_SYNC                            0x0194 0x0398 0x059C 0x02 0x01
+#define IMX95_PAD_XSPI1_SCLK__EARC_DC_HPD_IN                          0x0194 0x0398 0x0000 0x03 0x00
+#define IMX95_PAD_XSPI1_SCLK__XSPI_CLK                                0x0194 0x0398 0x05E8 0x04 0x01
+#define IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9                           0x0194 0x0398 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B                       0x0198 0x039C 0x0000 0x00 0x00
+#define IMX95_PAD_XSPI1_SS0_B__NETCMIX_TOP_SAI2_RX_DATA_BIT5          0x0198 0x039C 0x0000 0x01 0x00
+#define IMX95_PAD_XSPI1_SS0_B__SAI4_RX_BCLK                           0x0198 0x039C 0x0594 0x02 0x01
+#define IMX95_PAD_XSPI1_SS0_B__EARC_CEC_OUT                           0x0198 0x039C 0x0000 0x03 0x00
+#define IMX95_PAD_XSPI1_SS0_B__XSPI_CS                                0x0198 0x039C 0x05E0 0x04 0x01
+#define IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10                         0x0198 0x039C 0x0000 0x05 0x00
+
+#define IMX95_PAD_XSPI1_SS1_B__FLEXSPI1_A_SS1_B                       0x019C 0x03A0 0x0000 0x00 0x00
+#define IMX95_PAD_XSPI1_SS1_B__SAI5_RX_BCLK                           0x019C 0x03A0 0x05A8 0x01 0x01
+#define IMX95_PAD_XSPI1_SS1_B__SAI5_TX_DATA_BIT3                      0x019C 0x03A0 0x0000 0x02 0x00
+#define IMX95_PAD_XSPI1_SS1_B__NETCMIX_TOP_SAI2_RX_DATA_BIT7          0x019C 0x03A0 0x0440 0x03 0x01
+#define IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11                         0x019C 0x03A0 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD2_CD_B__USDHC2_CD_B                               0x01A0 0x03A4 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_CD_B__NETCMIX_TOP_NETC_TMR_1588_TRIG1           0x01A0 0x03A4 0x0434 0x01 0x01
+#define IMX95_PAD_SD2_CD_B__I3C2_SCL                                  0x01A0 0x03A4 0x04F8 0x02 0x01
+#define IMX95_PAD_SD2_CD_B__FLEXIO1_FLEXIO_BIT0                       0x01A0 0x03A4 0x0468 0x04 0x01
+#define IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0                             0x01A0 0x03A4 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD2_CLK__USDHC2_CLK                                 0x01A4 0x03A8 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_CLK__NETCMIX_TOP_NETC_TMR_1588_PP1              0x01A4 0x03A8 0x0000 0x01 0x00
+#define IMX95_PAD_SD2_CLK__I3C2_SDA                                   0x01A4 0x03A8 0x04FC 0x02 0x01
+#define IMX95_PAD_SD2_CLK__FLEXIO1_FLEXIO_BIT1                        0x01A4 0x03A8 0x046C 0x04 0x01
+#define IMX95_PAD_SD2_CLK__GPIO3_IO_BIT1                              0x01A4 0x03A8 0x0000 0x05 0x00
+#define IMX95_PAD_SD2_CLK__CCMSRCGPCMIX_TOP_OBSERVE_0                 0x01A4 0x03A8 0x0000 0x06 0x00
+
+#define IMX95_PAD_SD2_CMD__USDHC2_CMD                                 0x01A8 0x03AC 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_CMD__NETCMIX_TOP_NETC_TMR_1588_TRIG2            0x01A8 0x03AC 0x0438 0x01 0x01
+#define IMX95_PAD_SD2_CMD__I3C2_PUR                                   0x01A8 0x03AC 0x0000 0x02 0x00
+#define IMX95_PAD_SD2_CMD__I3C2_PUR_B                                 0x01A8 0x03AC 0x0000 0x03 0x00
+#define IMX95_PAD_SD2_CMD__FLEXIO1_FLEXIO_BIT2                        0x01A8 0x03AC 0x0470 0x04 0x01
+#define IMX95_PAD_SD2_CMD__GPIO3_IO_BIT2                              0x01A8 0x03AC 0x0000 0x05 0x00
+#define IMX95_PAD_SD2_CMD__CCMSRCGPCMIX_TOP_OBSERVE_1                 0x01A8 0x03AC 0x0000 0x06 0x00
+
+#define IMX95_PAD_SD2_DATA0__USDHC2_DATA0                             0x01AC 0x03B0 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_DATA0__NETCMIX_TOP_NETC_TMR_1588_PP2            0x01AC 0x03B0 0x0000 0x01 0x00
+#define IMX95_PAD_SD2_DATA0__CAN2_TX                                  0x01AC 0x03B0 0x0000 0x02 0x00
+#define IMX95_PAD_SD2_DATA0__FLEXIO1_FLEXIO_BIT3                      0x01AC 0x03B0 0x0474 0x04 0x01
+#define IMX95_PAD_SD2_DATA0__GPIO3_IO_BIT3                            0x01AC 0x03B0 0x0000 0x05 0x00
+#define IMX95_PAD_SD2_DATA0__CCMSRCGPCMIX_TOP_OBSERVE_2               0x01AC 0x03B0 0x0000 0x06 0x00
+
+#define IMX95_PAD_SD2_DATA1__USDHC2_DATA1                             0x01B0 0x03B4 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_DATA1__NETCMIX_TOP_NETC_TMR_1588_CLK            0x01B0 0x03B4 0x0000 0x01 0x00
+#define IMX95_PAD_SD2_DATA1__CAN2_RX                                  0x01B0 0x03B4 0x0444 0x02 0x03
+#define IMX95_PAD_SD2_DATA1__FLEXIO1_FLEXIO_BIT4                      0x01B0 0x03B4 0x0478 0x04 0x01
+#define IMX95_PAD_SD2_DATA1__GPIO3_IO_BIT4                            0x01B0 0x03B4 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD2_DATA2__USDHC2_DATA2                             0x01B4 0x03B8 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_DATA2__NETCMIX_TOP_NETC_TMR_1588_PP3            0x01B4 0x03B8 0x0000 0x01 0x00
+#define IMX95_PAD_SD2_DATA2__NETCMIX_TOP_MQS2_RIGHT                   0x01B4 0x03B8 0x0000 0x02 0x00
+#define IMX95_PAD_SD2_DATA2__FLEXIO1_FLEXIO_BIT5                      0x01B4 0x03B8 0x047C 0x04 0x01
+#define IMX95_PAD_SD2_DATA2__GPIO3_IO_BIT5                            0x01B4 0x03B8 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD2_DATA3__USDHC2_DATA3                             0x01B8 0x03BC 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_DATA3__LPTMR2_ALT1                              0x01B8 0x03BC 0x0548 0x01 0x01
+#define IMX95_PAD_SD2_DATA3__NETCMIX_TOP_MQS2_LEFT                    0x01B8 0x03BC 0x0000 0x02 0x00
+#define IMX95_PAD_SD2_DATA3__NETCMIX_TOP_NETC_TMR_1588_ALARM1         0x01B8 0x03BC 0x0000 0x03 0x00
+#define IMX95_PAD_SD2_DATA3__FLEXIO1_FLEXIO_BIT6                      0x01B8 0x03BC 0x0480 0x04 0x01
+#define IMX95_PAD_SD2_DATA3__GPIO3_IO_BIT6                            0x01B8 0x03BC 0x0000 0x05 0x00
+
+#define IMX95_PAD_SD2_RESET_B__USDHC2_RESET_B                         0x01BC 0x03C0 0x0000 0x00 0x00
+#define IMX95_PAD_SD2_RESET_B__LPTMR2_ALT2                            0x01BC 0x03C0 0x054C 0x01 0x01
+#define IMX95_PAD_SD2_RESET_B__NETCMIX_TOP_NETC_TMR_1588_GCLK         0x01BC 0x03C0 0x0000 0x03 0x00
+#define IMX95_PAD_SD2_RESET_B__FLEXIO1_FLEXIO_BIT7                    0x01BC 0x03C0 0x0484 0x04 0x01
+#define IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7                          0x01BC 0x03C0 0x0000 0x05 0x00
+
+#define IMX95_PAD_I2C1_SCL__AONMIX_TOP_LPI2C1_SCL                     0x01C0 0x03C4 0x0000 0x00 0x00
+#define IMX95_PAD_I2C1_SCL__AONMIX_TOP_I3C1_SCL                       0x01C0 0x03C4 0x0000 0x01 0x00
+#define IMX95_PAD_I2C1_SCL__AONMIX_TOP_LPUART1_DCD_B                  0x01C0 0x03C4 0x0000 0x02 0x00
+#define IMX95_PAD_I2C1_SCL__AONMIX_TOP_TPM2_CH0                       0x01C0 0x03C4 0x0000 0x03 0x00
+#define IMX95_PAD_I2C1_SCL__VPUMIX_TOP_UART_RX                        0x01C0 0x03C4 0x0000 0x04 0x00
+#define IMX95_PAD_I2C1_SCL__AONMIX_TOP_GPIO1_IO_BIT0                  0x01C0 0x03C4 0x0000 0x05 0x00
+
+#define IMX95_PAD_I2C1_SDA__AONMIX_TOP_LPI2C1_SDA                     0x01C4 0x03C8 0x0000 0x00 0x00
+#define IMX95_PAD_I2C1_SDA__AONMIX_TOP_I3C1_SDA                       0x01C4 0x03C8 0x0000 0x01 0x00
+#define IMX95_PAD_I2C1_SDA__AONMIX_TOP_LPUART1_RIN_B                  0x01C4 0x03C8 0x0000 0x02 0x00
+#define IMX95_PAD_I2C1_SDA__AONMIX_TOP_TPM2_CH1                       0x01C4 0x03C8 0x0000 0x03 0x00
+#define IMX95_PAD_I2C1_SDA__VPUMIX_TOP_UART_TX                        0x01C4 0x03C8 0x0000 0x04 0x00
+#define IMX95_PAD_I2C1_SDA__AONMIX_TOP_GPIO1_IO_BIT1                  0x01C4 0x03C8 0x0000 0x05 0x00
+
+#define IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL                     0x01C8 0x03CC 0x0000 0x00 0x00
+#define IMX95_PAD_I2C2_SCL__AONMIX_TOP_I3C1_PUR                       0x01C8 0x03CC 0x0000 0x01 0x00
+#define IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPUART2_DCD_B                  0x01C8 0x03CC 0x0000 0x02 0x00
+#define IMX95_PAD_I2C2_SCL__AONMIX_TOP_TPM2_CH2                       0x01C8 0x03CC 0x0000 0x03 0x00
+#define IMX95_PAD_I2C2_SCL__AONMIX_TOP_SAI1_RX_SYNC                   0x01C8 0x03CC 0x0000 0x04 0x00
+#define IMX95_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_BIT2                  0x01C8 0x03CC 0x0000 0x05 0x00
+#define IMX95_PAD_I2C2_SCL__AONMIX_TOP_I3C1_PUR_B                     0x01C8 0x03CC 0x0000 0x06 0x00
+
+#define IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA                     0x01CC 0x03D0 0x0000 0x00 0x00
+#define IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPUART2_RIN_B                  0x01CC 0x03D0 0x0000 0x02 0x00
+#define IMX95_PAD_I2C2_SDA__AONMIX_TOP_TPM2_CH3                       0x01CC 0x03D0 0x0000 0x03 0x00
+#define IMX95_PAD_I2C2_SDA__AONMIX_TOP_SAI1_RX_BCLK                   0x01CC 0x03D0 0x0000 0x04 0x00
+#define IMX95_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_BIT3                  0x01CC 0x03D0 0x0000 0x05 0x00
+
+#define IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX                    0x01D0 0x03D4 0x0000 0x00 0x00
+#define IMX95_PAD_UART1_RXD__S400_UART_RX                             0x01D0 0x03D4 0x0000 0x01 0x00
+#define IMX95_PAD_UART1_RXD__AONMIX_TOP_LPSPI2_SIN                    0x01D0 0x03D4 0x0000 0x02 0x00
+#define IMX95_PAD_UART1_RXD__AONMIX_TOP_TPM1_CH0                      0x01D0 0x03D4 0x0000 0x03 0x00
+#define IMX95_PAD_UART1_RXD__AONMIX_TOP_GPIO1_IO_BIT4                 0x01D0 0x03D4 0x0000 0x05 0x00
+
+#define IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX                    0x01D4 0x03D8 0x0000 0x00 0x00
+#define IMX95_PAD_UART1_TXD__S400_UART_TX                             0x01D4 0x03D8 0x0000 0x01 0x00
+#define IMX95_PAD_UART1_TXD__AONMIX_TOP_LPSPI2_PCS0                   0x01D4 0x03D8 0x0000 0x02 0x00
+#define IMX95_PAD_UART1_TXD__AONMIX_TOP_TPM1_CH1                      0x01D4 0x03D8 0x0000 0x03 0x00
+#define IMX95_PAD_UART1_TXD__AONMIX_TOP_GPIO1_IO_BIT5                 0x01D4 0x03D8 0x0000 0x05 0x00
+
+#define IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX                    0x01D8 0x03DC 0x0000 0x00 0x00
+#define IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART1_CTS_B                 0x01D8 0x03DC 0x0000 0x01 0x00
+#define IMX95_PAD_UART2_RXD__AONMIX_TOP_LPSPI2_SOUT                   0x01D8 0x03DC 0x0000 0x02 0x00
+#define IMX95_PAD_UART2_RXD__AONMIX_TOP_TPM1_CH2                      0x01D8 0x03DC 0x0000 0x03 0x00
+#define IMX95_PAD_UART2_RXD__AONMIX_TOP_SAI1_MCLK                     0x01D8 0x03DC 0x041C 0x04 0x00
+#define IMX95_PAD_UART2_RXD__AONMIX_TOP_GPIO1_IO_BIT6                 0x01D8 0x03DC 0x0000 0x05 0x00
+
+#define IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX                    0x01DC 0x03E0 0x0000 0x00 0x00
+#define IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART1_RTS_B                 0x01DC 0x03E0 0x0000 0x01 0x00
+#define IMX95_PAD_UART2_TXD__AONMIX_TOP_LPSPI2_SCK                    0x01DC 0x03E0 0x0000 0x02 0x00
+#define IMX95_PAD_UART2_TXD__AONMIX_TOP_TPM1_CH3                      0x01DC 0x03E0 0x0000 0x03 0x00
+#define IMX95_PAD_UART2_TXD__AONMIX_TOP_GPIO1_IO_BIT7                 0x01DC 0x03E0 0x0000 0x05 0x00
+
+#define IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK                         0x01E0 0x03E4 0x0000 0x00 0x00
+#define IMX95_PAD_PDM_CLK__AONMIX_TOP_MQS1_LEFT                       0x01E0 0x03E4 0x0000 0x01 0x00
+#define IMX95_PAD_PDM_CLK__AONMIX_TOP_LPTMR1_ALT1                     0x01E0 0x03E4 0x0000 0x04 0x00
+#define IMX95_PAD_PDM_CLK__AONMIX_TOP_GPIO1_IO_BIT8                   0x01E0 0x03E4 0x0000 0x05 0x00
+#define IMX95_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX                         0x01E0 0x03E4 0x0000 0x06 0x00
+
+#define IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_STREAM_BIT0     0x01E4 0x03E8 0x040C 0x00 0x00
+#define IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_MQS1_RIGHT              0x01E4 0x03E8 0x0000 0x01 0x00
+#define IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_LPSPI1_PCS1             0x01E4 0x03E8 0x0000 0x02 0x00
+#define IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_TPM1_EXTCLK             0x01E4 0x03E8 0x0000 0x03 0x00
+#define IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_LPTMR1_ALT2             0x01E4 0x03E8 0x0000 0x04 0x00
+#define IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_GPIO1_IO_BIT9           0x01E4 0x03E8 0x0000 0x05 0x00
+#define IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX                 0x01E4 0x03E8 0x0408 0x06 0x00
+
+#define IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_PDM_BIT_STREAM_BIT1     0x01E8 0x03EC 0x0410 0x00 0x00
+#define IMX95_PAD_PDM_BIT_STREAM1__NMI_GLUE_NMI                       0x01E8 0x03EC 0x0000 0x01 0x00
+#define IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_LPSPI2_PCS1             0x01E8 0x03EC 0x0000 0x02 0x00
+#define IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_TPM2_EXTCLK             0x01E8 0x03EC 0x0000 0x03 0x00
+#define IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_LPTMR1_ALT3             0x01E8 0x03EC 0x0000 0x04 0x00
+#define IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_BIT10          0x01E8 0x03EC 0x0000 0x05 0x00
+#define IMX95_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_TOP_EXT_CLK1          0x01E8 0x03EC 0x0420 0x06 0x00
+
+#define IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC                  0x01EC 0x03F0 0x0000 0x00 0x00
+#define IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_DATA_BIT1             0x01EC 0x03F0 0x0000 0x01 0x00
+#define IMX95_PAD_SAI1_TXFS__AONMIX_TOP_LPSPI1_PCS0                   0x01EC 0x03F0 0x0000 0x02 0x00
+#define IMX95_PAD_SAI1_TXFS__AONMIX_TOP_LPUART2_DTR_B                 0x01EC 0x03F0 0x0000 0x03 0x00
+#define IMX95_PAD_SAI1_TXFS__AONMIX_TOP_MQS1_LEFT                     0x01EC 0x03F0 0x0000 0x04 0x00
+#define IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11                0x01EC 0x03F0 0x0000 0x05 0x00
+
+#define IMX95_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK                   0x01F0 0x03F4 0x0000 0x00 0x00
+#define IMX95_PAD_SAI1_TXC__AONMIX_TOP_LPUART2_CTS_B                  0x01F0 0x03F4 0x0000 0x01 0x00
+#define IMX95_PAD_SAI1_TXC__AONMIX_TOP_LPSPI1_SIN                     0x01F0 0x03F4 0x0000 0x02 0x00
+#define IMX95_PAD_SAI1_TXC__AONMIX_TOP_LPUART1_DSR_B                  0x01F0 0x03F4 0x0000 0x03 0x00
+#define IMX95_PAD_SAI1_TXC__AONMIX_TOP_CAN1_RX                        0x01F0 0x03F4 0x0408 0x04 0x01
+#define IMX95_PAD_SAI1_TXC__AONMIX_TOP_GPIO1_IO_BIT12                 0x01F0 0x03F4 0x0000 0x05 0x00
+
+#define IMX95_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_BIT0             0x01F4 0x03F8 0x0000 0x00 0x00
+#define IMX95_PAD_SAI1_TXD0__AONMIX_TOP_LPUART2_RTS_B                 0x01F4 0x03F8 0x0000 0x01 0x00
+#define IMX95_PAD_SAI1_TXD0__AONMIX_TOP_LPSPI1_SCK                    0x01F4 0x03F8 0x0000 0x02 0x00
+#define IMX95_PAD_SAI1_TXD0__AONMIX_TOP_LPUART1_DTR_B                 0x01F4 0x03F8 0x0000 0x03 0x00
+#define IMX95_PAD_SAI1_TXD0__AONMIX_TOP_CAN1_TX                       0x01F4 0x03F8 0x0000 0x04 0x00
+#define IMX95_PAD_SAI1_TXD0__AONMIX_TOP_GPIO1_IO_BIT13                0x01F4 0x03F8 0x0000 0x05 0x00
+
+#define IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_BIT0             0x01F8 0x03FC 0x0000 0x00 0x00
+#define IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_MCLK                     0x01F8 0x03FC 0x041C 0x01 0x01
+#define IMX95_PAD_SAI1_RXD0__AONMIX_TOP_LPSPI1_SOUT                   0x01F8 0x03FC 0x0000 0x02 0x00
+#define IMX95_PAD_SAI1_RXD0__AONMIX_TOP_LPUART2_DSR_B                 0x01F8 0x03FC 0x0000 0x03 0x00
+#define IMX95_PAD_SAI1_RXD0__AONMIX_TOP_MQS1_RIGHT                    0x01F8 0x03FC 0x0000 0x04 0x00
+#define IMX95_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_BIT14                0x01F8 0x03FC 0x0000 0x05 0x00
+
+#define IMX95_PAD_WDOG_ANY__AONMIX_TOP_WDOG_ANY                       0x01FC 0x0400 0x0000 0x00 0x00
+#define IMX95_PAD_WDOG_ANY__AONMIX_TOP_FCCU_EOUT1                     0x01FC 0x0400 0x0000 0x01 0x00
+#define IMX95_PAD_WDOG_ANY__AONMIX_TOP_GPIO1_IO_BIT15                 0x01FC 0x0400 0x0000 0x05 0x00
+#endif /* __DTS_IMX95_PINFUNC_H */
diff --git a/arch/arm64/boot/dts/freescale/imx95-power.h b/arch/arm64/boot/dts/freescale/imx95-power.h
new file mode 100644
index 000000000000..0b7f0bc30e19
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-power.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ *  Copyright 2024 NXP
+ */
+
+#ifndef __IMX95_POWER_H__
+#define __IMX95_POWER_H__
+
+#define IMX95_PD_ANA		0
+#define IMX95_PD_AON		1
+#define IMX95_PD_BBSM		2
+#define IMX95_PD_CAMERA		3
+#define IMX95_PD_CCMSRCGPC	4
+#define IMX95_PD_A55C0		5
+#define IMX95_PD_A55C1		6
+#define IMX95_PD_A55C2		7
+#define IMX95_PD_A55C3		8
+#define IMX95_PD_A55C4		9
+#define IMX95_PD_A55C5		10
+#define IMX95_PD_A55P		11
+#define IMX95_PD_DDR		12
+#define IMX95_PD_DISPLAY	13
+#define IMX95_PD_GPU		14
+#define IMX95_PD_HSIO_TOP	15
+#define IMX95_PD_HSIO_WAON	16
+#define IMX95_PD_M7		17
+#define IMX95_PD_NETC		18
+#define IMX95_PD_NOC		19
+#define IMX95_PD_NPU		20
+#define IMX95_PD_VPU		21
+#define IMX95_PD_WAKEUP		22
+
+#define IMX95_PERF_ELE		0
+#define IMX95_PERF_M33		1
+#define IMX95_PERF_WAKEUP	2
+#define IMX95_PERF_M7		3
+#define IMX95_PERF_DRAM		4
+#define IMX95_PERF_HSIO		5
+#define IMX95_PERF_NPU		6
+#define IMX95_PERF_NOC		7
+#define IMX95_PERF_A55		8
+#define IMX95_PERF_GPU		9
+#define IMX95_PERF_VPU		10
+#define IMX95_PERF_CAM		11
+#define IMX95_PERF_DISP		12
+
+#endif
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
new file mode 100644
index 000000000000..f98cec944eee
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -0,0 +1,1042 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
+
+#include "imx95-clock.h"
+#include "imx95-pinfunc.h"
+#include "imx95-power.h"
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		A55_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l0>;
+		};
+
+		A55_1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l1>;
+		};
+
+		A55_2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l2>;
+		};
+
+		A55_3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domain-names = "perf";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l3>;
+		};
+
+		A55_4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domain-names = "perf";
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l4>;
+		};
+
+		A55_5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			power-domains = <&scmi_devpd IMX95_PERF_A55>;
+			power-domain-names = "perf";
+			enable-method = "psci";
+			#cooling-cells = <2>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l5>;
+		};
+
+		l2_cache_l0: l2-cache-l0 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l1: l2-cache-l1 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l2: l2-cache-l2 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l3: l2-cache-l3 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l4: l2-cache-l4 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l5: l2-cache-l5 {
+			compatible = "cache";
+			cache-size = <65536>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l3_cache: l3-cache {
+			compatible = "cache";
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <3>;
+			cache-unified;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A55_0>;
+				};
+
+				core1 {
+					cpu = <&A55_1>;
+				};
+
+				core2 {
+					cpu = <&A55_2>;
+				};
+
+				core3 {
+					cpu = <&A55_3>;
+				};
+
+				core4 {
+					cpu = <&A55_4>;
+				};
+
+				core5 {
+					cpu = <&A55_5>;
+				};
+			};
+		};
+	};
+
+	clk_ext1: clock-ext1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <133000000>;
+		clock-output-names = "clk_ext1";
+	};
+
+	sai1_mclk: clock-sai-mclk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency= <0>;
+		clock-output-names = "sai1_mclk";
+	};
+
+	sai2_mclk: clock-sai-mclk2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency= <0>;
+		clock-output-names = "sai2_mclk";
+	};
+
+	sai3_mclk: clock-sai-mclk3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency= <0>;
+		clock-output-names = "sai3_mclk";
+	};
+
+	sai4_mclk: clock-sai-mclk4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency= <0>;
+		clock-output-names = "sai4_mclk";
+	};
+
+	sai5_mclk: clock-sai-mclk5 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency= <0>;
+		clock-output-names = "sai5_mclk";
+	};
+
+	osc_24m: clock-24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc_24m";
+	};
+
+	sram1: sram@204c0000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x204c0000 0x0 0x18000>;
+		ranges = <0x0 0x0 0x204c0000 0x18000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
+			shmem = <&scmi_buf0>, <&scmi_buf1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_perf: protocol@13 {
+				reg = <0x13>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_sensor: protocol@15 {
+				reg = <0x15>;
+				#thermal-sensor-cells = <1>;
+			};
+
+			scmi_iomuxc: protocol@19 {
+				reg = <0x19>;
+			};
+
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	thermal-zones {
+		a55-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&scmi_sensor 1>;
+
+			trips {
+				cpu_alert0: trip0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit0: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <24000000>;
+		arm,no-tick-in-suspend;
+		interrupt-parent = <&gic>;
+	};
+
+	gic: interrupt-controller@48000000 {
+		compatible = "arm,gic-v3";
+		reg = <0 0x48000000 0 0x10000>,
+		      <0 0x48060000 0 0xc0000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		dma-noncoherent;
+		ranges;
+
+		its: msi-controller@48040000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0 0x48040000 0 0x20000>;
+			msi-controller;
+			#msi-cells = <1>;
+			dma-noncoherent;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		aips2: bus@42000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x0 0x42000000 0x0 0x800000>;
+			ranges = <0x42000000 0x0 0x42000000 0x8000000>,
+				 <0x28000000 0x0 0x28000000 0x10000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mu7: mailbox@42430000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x42430000 0x10000>;
+				interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			wdog3: watchdog@42490000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x42490000 0x10000>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
+			tpm3: pwm@424e0000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x424e0000 0x1000>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm4: pwm@424f0000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x424f0000 0x1000>;
+				clocks = <&scmi_clk IMX95_CLK_TPM4>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm5: pwm@42500000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42500000 0x1000>;
+				clocks = <&scmi_clk IMX95_CLK_TPM5>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm6: pwm@42510000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42510000 0x1000>;
+				clocks = <&scmi_clk IMX95_CLK_TPM6>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			lpi2c3: i2c@42530000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42530000 0x10000>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C3>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c4: i2c@42540000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42540000 0x10000>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C4>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi3: spi@42550000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42550000 0x10000>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI3>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi4: spi@42560000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42560000 0x10000>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI4>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpuart3: serial@42570000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x42570000 0x1000>;
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART3>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart4: serial@42580000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x42580000 0x1000>;
+				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART4>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart5: serial@42590000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x42590000 0x1000>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART5>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart6: serial@425a0000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x425a0000 0x1000>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART6>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart7: serial@42690000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x42690000 0x1000>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart8: serial@426a0000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x426a0000 0x1000>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpi2c5: i2c@426b0000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426b0000 0x10000>;
+				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C5>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c6: i2c@426c0000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426c0000 0x10000>;
+				interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C6>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c7: i2c@426d0000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426d0000 0x10000>;
+				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C7>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c8: i2c@426e0000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426e0000 0x10000>;
+				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C8>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi5: spi@426f0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x426f0000 0x10000>;
+				interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI5>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi6: spi@42700000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42700000 0x10000>;
+				interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI6>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi7: spi@42710000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42710000 0x10000>;
+				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI7>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi8: spi@42720000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x42720000 0x10000>;
+				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI8>,
+					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			mu8: mailbox@42730000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x42730000 0x10000>;
+				interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		aips3: bus@42800000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0 0x42800000 0 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x42800000 0x0 0x42800000 0x800000>;
+
+			usdhc1: mmc@42850000 {
+				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x42850000 0x10000>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
+					 <&scmi_clk IMX95_CLK_USDHC1>;
+				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_USDHC1>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
+				assigned-clock-rates = <400000000>;
+				bus-width = <8>;
+				fsl,tuning-start-tap = <1>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+
+			usdhc2: mmc@42860000 {
+				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x42860000 0x10000>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
+					 <&scmi_clk IMX95_CLK_USDHC2>;
+				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_USDHC2>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
+				assigned-clock-rates = <400000000>;
+				bus-width = <4>;
+				fsl,tuning-start-tap = <1>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+
+			usdhc3: mmc@428b0000 {
+				compatible = "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
+				reg = <0x428b0000 0x10000>;
+				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
+					 <&scmi_clk IMX95_CLK_USDHC3>;
+				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&scmi_clk IMX95_CLK_USDHC3>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
+				assigned-clock-rates = <400000000>;
+				bus-width = <4>;
+				fsl,tuning-start-tap = <1>;
+				fsl,tuning-step= <2>;
+				status = "disabled";
+			};
+		};
+
+		gpio2: gpio@43810000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43810000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 4 32>;
+		};
+
+		gpio3: gpio@43820000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43820000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 104 8>, <&scmi_iomuxc 8 74 18>,
+				      <&scmi_iomuxc 26 42 2>, <&scmi_iomuxc 28 0 4>;
+		};
+
+		gpio4: gpio@43840000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43840000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 46 28>, <&scmi_iomuxc 28 44 2>;
+		};
+
+		gpio5: gpio@43850000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x43850000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 92 12>, <&scmi_iomuxc 12 36 6>;
+		};
+
+		aips1: bus@44000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x0 0x44000000 0x0 0x800000>;
+			ranges = <0x44000000 0x0 0x44000000 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mu1: mailbox@44220000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x44220000 0x10000>;
+				interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			tpm1: pwm@44310000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x44310000 0x1000>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm2: pwm@44320000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x44320000 0x1000>;
+				clocks = <&scmi_clk IMX95_CLK_TPM2>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			lpi2c1: i2c@44340000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44340000 0x10000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C1>,
+					 <&scmi_clk IMX95_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c2: i2c@44350000 {
+				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44350000 0x10000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPI2C2>,
+					 <&scmi_clk IMX95_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi1: spi@44360000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x44360000 0x10000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI1>,
+					 <&scmi_clk IMX95_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi2: spi@44370000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx95-spi", "fsl,imx7ulp-spi";
+				reg = <0x44370000 0x10000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPSPI2>,
+					 <&scmi_clk IMX95_CLK_BUSAON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpuart1: serial@44380000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x44380000 0x1000>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART1>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			lpuart2: serial@44390000 {
+				compatible = "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
+					     "fsl,imx7ulp-lpuart";
+				reg = <0x44390000 0x1000>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_LPUART2>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			adc1: adc@44530000 {
+				compatible = "nxp,imx93-adc";
+				reg = <0x44530000 0x10000>;
+				interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_ADC>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			mu2: mailbox@445b0000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x445b0000 0x1000>;
+				ranges;
+				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#mbox-cells = <2>;
+
+				sram0: sram@445b1000 {
+					compatible = "mmio-sram";
+					reg = <0x445b1000 0x400>;
+					ranges = <0x0 0x445b1000 0x400>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					scmi_buf0: scmi-sram-section@0 {
+						compatible = "arm,scmi-shmem";
+						reg = <0x0 0x80>;
+					};
+
+					scmi_buf1: scmi-sram-section@80 {
+						compatible = "arm,scmi-shmem";
+						reg = <0x80 0x80>;
+					};
+				};
+
+			};
+
+			mu3: mailbox@445d0000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x445d0000 0x10000>;
+				interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			mu4: mailbox@445f0000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x445f0000 0x10000>;
+				interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			mu6: mailbox@44630000 {
+				compatible = "fsl,imx95-mu";
+				reg = <0x44630000 0x10000>;
+				interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		mailbox@47320000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47320000 0x0 0x10000>;
+			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		mailbox@47350000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47350000 0x0 0x10000>;
+			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		/* GPIO1 is under exclusive control of System Manager */
+		gpio1: gpio@47400000 {
+			compatible = "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x0 0x47400000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&scmi_clk IMX95_CLK_M33>,
+				 <&scmi_clk IMX95_CLK_M33>;
+			clock-names = "gpio", "port";
+			gpio-ranges = <&scmi_iomuxc 0 112 16>;
+			status = "disabled";
+		};
+
+		elemu0: mailbox@47520000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47520000 0x0 0x10000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu1: mailbox@47530000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47530000 0x0 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu2: mailbox@47540000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47540000 0x0 0x10000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu3: mailbox@47550000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47550000 0x0 0x10000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		elemu4: mailbox@47560000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47560000 0x0 0x10000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		elemu5: mailbox@47570000 {
+			compatible = "fsl,imx95-mu-ele";
+			reg = <0x0 0x47570000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "disabled";
+		};
+
+		aips4: bus@49000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x0 0x49000000 0x0 0x800000>;
+			ranges = <0x49000000 0x0 0x49000000 0x800000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			smmu: iommu@490d0000 {
+				compatible = "arm,smmu-v3";
+				reg = <0x490d0000 0x100000>;
+				interrupts = <GIC_SPI 325 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 334 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 326 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+				#iommu-cells = <1>;
+				status = "disabled";
+			};
+		};
+	};
+};

-- 
2.37.1


