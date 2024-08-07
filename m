Return-Path: <linux-kernel+bounces-278086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2594AAAD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1972828A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71E84A5C;
	Wed,  7 Aug 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b4yYdEmE"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136F81741;
	Wed,  7 Aug 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042351; cv=fail; b=MggpSvd8YUdGcm68oeOx5lN+rlnkZR9/2ZRpPSDSR1Dpro2weyvmhfb1TW0j8KvYVa3MytqQ0wRkB1geGzjN+upVw4269aldlJ1tNnbxSDYo9eu4RzCu2dUOABRpyGRS4v+YxUWTmwe79rafA5UUnJNnEhXyMWUEiOgQpWIj9Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042351; c=relaxed/simple;
	bh=t26D5FxNKUeLY2GiQWuD5vpCmsOI7BpKRPFrc/fHvJA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=toKuJBNU9SXSwWGOSPvm4+jYAGjURQ20/LXxk4w1nAcVJRoif7lrUgG95NQp7RUY5uqkRE25FB1y1r7PN5GUxfyiV9IKAwE3Ga2p0/DT/GG6yNmKLuBdL+oVPLbvx+M57+/VfxYyq+1aynvNQUDrA6UZvtwSlXx8gRYSgtWdSDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b4yYdEmE; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPaLXy8JsVuHfiRSP4Xjpt0rrQNXY6zQOFsmCyAYn4hf3YGKhWmDmisq7tSr8kHM2DXV3+iZe3CQgy+DMeWtR487uENK8Kbl/foctpb0F9TkxsDM3egDfjAstSrYFYsnY6iXcX3A4GlBqMWMNAQxURoQlNE0zB8U02cskgBOjT8rN5Z14bMdWVl/bb+9nst8SRcl7VoDUcgrDq3GwjQpkNDKGsHWoS0IQLV68lnaX3flobl9+W92LwB2x7IGSnt9AVpLMYe3pxzBmOIzLDK6yO3tANVKHuYQO8IKM+572x/DlZf2QpB89FN9iH5OugNb3lnto28CfLhyz0ERvwyBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+zGh/vm70Fk6PNdCaATgb9/6m3Ca15+tXVYWs0gZAM=;
 b=jhaKojiBpyv948XT0QzWkAQwWGQUmJCJPhbmog/W4d/ptAjJ+z5pOzF3caJRUrms4Kup0XLE41JOhSQxEEOQJbQBS/HXnQJz9e1v/JI1R/2vpijiCVMHMmLzneDbRHS7cOhh3XIJky/U2pBMpkLDFB4KEdUeioNWwzfm/sSh4+Fi5YNVJ9ri4/pudHvYnjpm2c1HVPf/S7A8elESDKbsS04/+RNdEt297tjqMsVEf2NOTxQlgZOy4p2WAL/Anqw86rcDjFmlZ+knmh8e9bCmbNsLv23M6nBx4LOe1XsrCR8FMBzGaS3LRHd1uD1CwV2wSeYU8YwsVl7Ist4JyE2m3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+zGh/vm70Fk6PNdCaATgb9/6m3Ca15+tXVYWs0gZAM=;
 b=b4yYdEmEOZkpLKnVnlpu7Eu8fkLEIL9n+3eYu+3utP1d5eHprNp2+TVIPFwfNhXiw3tZyHL7sOOG/4WQl1TuQ5T/pRcAbgviveo2I/ChhDaRWndMtPuj6LFGkpbSSPa3SVg2CYElUnjTGTMYRWcPBE1jj8fstRjYwSz+vJIAthA3/zKaaQRvyUJA4s5jV9GjBRiFa69TzFE78TtL9YtcVhpfKuXzYX/+WvfqZYqxGM2Q0Zrf1qHXT83aNGEt9K73J5isJX8jMyNbX+e01ayXutzR6l0LDDijJ7d/AkoOIRzSseLVOrJgkpNSwojR/h2TvANYnyL+4ox1e1fkLljBAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:52:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:52:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Aug 2024 10:52:06 -0400
Subject: [PATCH v2 3/6] arm64: dts: imx8mm-venice-gw7901: add
 #address(size)-cells for gsc@20
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-fsl_dts_warning-v2-3-89e08c38831a@nxp.com>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042332; l=860;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=t26D5FxNKUeLY2GiQWuD5vpCmsOI7BpKRPFrc/fHvJA=;
 b=BJG7BO1AXYXlC6I/SJz0LERCo54hSio6RIRnBmHlIknV5/rbrb/AaaOtIm3zVv7UUkge/dwbt
 8Mr0YNcPqIzADVrX9qu+TUXgEMGEphjCHHEmlcmAidHeaH4YDK0cJrS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2de146-6125-4b98-18e3-08dcb6f08c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG5TRXZDSDdHVTdicHV6V3VXL2NUTlhEbm5EVm8zTzNkVS9DNk1ZcGpMdENU?=
 =?utf-8?B?MFQ3VFI4OXZGOGQ3U0pyTWlwbU96OC9RYVpUV0Q0azZWQ0NOc2N2bHlrSk5U?=
 =?utf-8?B?Z3orWTcxSUk3VWM2V0Qxb2doVWRBQWo2bjZ6Y3hiSDZLNHRPckhmZGxTTGlT?=
 =?utf-8?B?aUhVLzVmbUQvVzUzQmlkQnBROE5ZYUJ4ZUtMcWFpazhEQ0dzL1lCSERzSGxK?=
 =?utf-8?B?NHdzQnBIc3JVeUhZTTNXU0o0Ny9xd2JISHNYZGo0bUtmT3R6d2NCTzJZd09l?=
 =?utf-8?B?SjJYWis3UnByVWs4Q21VMDZMSGYwUUUrRkdBU0tPQkw0OEZYY216RTFPT1Vz?=
 =?utf-8?B?UWpvZzkyYUxvQjl4QTI0VmZYQS9ZWjhuWTRvc2t5MlVUblY2RXpTdHJJcUZ1?=
 =?utf-8?B?R1o4UXMydHU1Qi9NZEI5NGIwYkhRcUlRY1JEaXJnaUdUSko4RUZCWHNPcnc5?=
 =?utf-8?B?M1lUZlJDSDJHQVZXcS9VakMvMVBvb2djck1ySTcvMnQ3Q2lJcWRWNkpsMG9y?=
 =?utf-8?B?UG92YlZldzhOZ3JnTFRuYTJocEpQYUIzVDBOTHloVzhvQzFjZWhxdktRbnk1?=
 =?utf-8?B?QTlYR1J3MUNFZjBhanVMMmJMNVd4cFFkaDNHK1B1OTI5dklWbW5QLzZCU1F5?=
 =?utf-8?B?OGVvUzZKWWxIa21VZUhVeEZKRXpRZHdjMEdReHdQZEdwZVNzWUVrdnoxSUFr?=
 =?utf-8?B?SUhtelNKL2JkQ1RpejhHa0VmdkxydDVoMW5lRm1kT2hIMHNOTTdkL0h2bXlj?=
 =?utf-8?B?aXZmYnNTdVlvWW16WkU1cnVrcGd4UEJVYTJmME1pOUk4MGprN05XQTVMTGgw?=
 =?utf-8?B?Y2tjN09zQmI5ejdtT3RjaDdXTW4yeTRRMTVyVmQzS1FpOVBaZHJoUkJyaWhq?=
 =?utf-8?B?MmxZaWZUaXhCek9LOXdxRkk0TkFZYmZEUi8vV0RybG5KWnlVV1QzNis2dWRV?=
 =?utf-8?B?L3lQaDFFazNlbnJ6SGkwOFZZTllFV0d3dFBncWdocDVUY0FyY1RxZHRIODla?=
 =?utf-8?B?RUh2UWxVSVNBMng5UURxMWRZa3hqbjgvMTIwU0UwZ0NPVldIWGNYaTMzTUNj?=
 =?utf-8?B?Y3BiMGNEZ3R6WVoycitJZm42YVcyQ2hVOEFYRTliVVlYcmlUNFBKVGJTc3lt?=
 =?utf-8?B?QituS3AveHhYdnZzVXNpdTVCQzJsd21Id2tEV2VEU2FzaTUyS29raVIzeGZL?=
 =?utf-8?B?UVRYd2tUZXRqSkNqdzVtNzYzSU14dHpVdFNQRzBKTkUwQVhhcjBzbmJWbUJS?=
 =?utf-8?B?eFNlcWNpZERYeGVHTHNwbUFUYmIyemFpK0NhYW9hRCtTTmZpT2x3MjRLamRn?=
 =?utf-8?B?VVpkODVvSVJCa0E0dVFvNWZXN243dE5uaFhsRFpIYXg4UlVCU0U5MnJWV0pV?=
 =?utf-8?B?MGZNS25EdnF0dHR3b3hpOHJmSDR1M05tQW1rVUNYT2NRWkxpS3BCY1E2RDJy?=
 =?utf-8?B?Y2ZqQ1dGTUZ5aGs2WlFhMFdlditNL1FrUlZXT3lKYThtTFJ6YVZlMWRLdDRs?=
 =?utf-8?B?M3RZM0pqaVBuQWlQbWJJS0ZvUERwODh0STlnNE02VG9xWUl4a2hWZ2swMkV3?=
 =?utf-8?B?VjEvN0JEbno5cDREem51VERONC94RlE2YmkrQm9RRTRBNFVKSEZ4QUhZK0Vt?=
 =?utf-8?B?RWtHWGxxUlFrb0RETHZjYWtYUWhDYllGb203VXNXcWVMQnJQOWFDQ1dQaXpX?=
 =?utf-8?B?TjBJd1RKWFhENE41OTRqSVdrY0ZkTm9qMWt0Z2p6MFFhK1l5MjA3TTlzWkps?=
 =?utf-8?B?bExnKzdyRER2VlRsZ1R4dFpKa2lGc1QrKzZ0MXZQSkRqb0hMTS95bXp2dXdJ?=
 =?utf-8?B?YzNpcHkwU0lBQW1mbFk3dzBtUUxsbyswcE1zbHNYQ0ljR0hadzYxbGJQVktI?=
 =?utf-8?B?TmNWamt0WmV3L3l3SnFDVThTUHhaNHRZRzBMUytpRkV0Z3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elJUejJMUm96Sk9xWVVudW94Z3hnMW9DNGNaaFVHRWNJUnMyTEQ3Ym9RRTZz?=
 =?utf-8?B?cFFxUkxWaWExZ2FRQ256NWlkRXRPWjBSMEdMWkpqUzRUdGdhMmJIb0p0a1Y3?=
 =?utf-8?B?ZUNycGYvMEZiWnBMdkVtaXJpaGV0MnBwT25meTM0bjkyc2t2bzByYWZMVmxZ?=
 =?utf-8?B?SGVycmdoc0ZyYko4amZvaG4weFJVZ3UyRy9FbStNSXVRdHJuV2wzNCtHck83?=
 =?utf-8?B?TUxsNGp0TCs4aElmR0RKbDJpTHBPTm5YQThBQ3ArRkxJV2s0ZDZ2dUVoaVVs?=
 =?utf-8?B?MXdwQWxRbUVxODE0ci9tK2p1WXFyaGxKSmZ4WVhVOU9oRldHTUtwQ1hEUEo2?=
 =?utf-8?B?SUZ3VnF4dG1kTkN5dTlLYlVWNkx5NzJYWkF5dG9jRkQ2N0FJdWpmZW03dDZW?=
 =?utf-8?B?L29OU0psY1N0eTU5SmphOXdXRHY2OUVHYlQ5WmVSbitweGZSR1YraEhIYXBo?=
 =?utf-8?B?eUZxUE92TGtoMTVPeitpWDBkaWJaNkFJRmZiSVpnck5IUldtM1l3dVZPWXp1?=
 =?utf-8?B?a1JHc1FGM1RzOGVydGZTcDBRSjZ2eTRYaFVneGxzYyt1eFFNS3U3TFE0TmMx?=
 =?utf-8?B?czVjelNEelhCaGJHMmtYcXJhYzVTSjA0a0p4OVlZQ2RxeWJSMUo2ZWVLOTZi?=
 =?utf-8?B?V2hWTnphNzk3UkhqRG5yZVN2Q043Vkh5czJQVkRxOEIzR1AveVc1UE1uaWJI?=
 =?utf-8?B?VzNmejhkd21maWoveHdkeFBrcElNQXJBSGZRZ0cxeHhDcGo4dDROek1MSXJx?=
 =?utf-8?B?RVlzK0xoL2lqMlp0dE52Nnk3S3cvdHptZTZkUzZMbnBGR0RLNWVuRTNtNzl0?=
 =?utf-8?B?YS9DVDRReGVWeXh6Qnh4QkhONnZ5ZGw4ZFpseVFHY0ZsanBxN1RXY3hqNjky?=
 =?utf-8?B?T0ZlOHk5TmdTMEJ3OStrZEF6SWMzbnlkblhzVXp3UFJMcitBQnk3SEVJbFBD?=
 =?utf-8?B?YVhtbE1BRE5jdHZ1RTlDVHhGMCtRNG8reHFDNUVUSG01TkEyL2NFRTREUXJM?=
 =?utf-8?B?K2lFWUI3UmxYL1R4QXV2YlpiWExuR0dsaVFSL0hKL3VsbENncVlqODRKNTdK?=
 =?utf-8?B?aWJFa3Rtc3ZnOGk1WEpObU5DY2ZtNTQ4cGw1eE92cmZSQVg1QlZ4bVlvRTh2?=
 =?utf-8?B?OFhENFJMRlJsaXlOODR3S2I1bHl5bjVXajdWNHdYenRkdGRxdStXeUloMTk5?=
 =?utf-8?B?OTdLZlN1V0FGeGxVMnFZc2dGSkxNSndhNnU2aU04aFVjZEdvTHI5bkUrNVk2?=
 =?utf-8?B?U0JVNzl1K0oxU3pqdGZ6TGNoNG5Cb0F1SXFTdTV2ZzM5WUp4NElGL3NWM2gr?=
 =?utf-8?B?bW83OGpacDFqMWtTZW9zdUJ1YldzTzJXYTNDU1RpdyttbUd1YlkyMHNTLy9R?=
 =?utf-8?B?RmR2eGF0NHUzWkkzYldleStheHRUMFpRUkFiSHN0aFpUZ2JLdVAwc2RxS1dJ?=
 =?utf-8?B?Q0tDNVR2MTJhMHRtVkhaR081NmlZZjRWZG5BWWpBbjM0Qmh3c3JMYUJMZXln?=
 =?utf-8?B?aE13T2RYNE90RVRYK2VFaXFkc05QeUwvam5zVHVoTHlJeUg4UzZqQlMzME9u?=
 =?utf-8?B?YjFrT2xWUExIc2FPcGt6bjc0NENnYjdEYmVKWGE0VzZ3aDBBOXhjT2FSS3RR?=
 =?utf-8?B?dmo2aFEwNlFaTTdkM0VQY2dpbEZaandLcHliM2NodTY4dFpyTFp6bktFbmZR?=
 =?utf-8?B?RGhISFNEaEY0TUpvNUdmNTk1VXB1UkRGVDVZZnJvbEtGcStCV3dGZy83M1BR?=
 =?utf-8?B?S2JxY1FHZzloNm1VRTAweTJYWmNNTHZNOERCZE9rSUwrd3JPemI3MVlGYWRx?=
 =?utf-8?B?eHZRSmRFSDN3WTVzZlZLR3kxTDhWdHluVnBpQXJMNGd0QXFlbFEzWlFPeWRT?=
 =?utf-8?B?SGhDR1FoR1pXYmNrcllDY2RpSTNXb2NtNDFrdjZ2RzhpYnJMZ29OYkJPUFNM?=
 =?utf-8?B?d0F4SHB2ejBQZmU2ckhTM3FKV1d5dHB6dUVyRFJNalFnR2gyMGc4Zy90VjMy?=
 =?utf-8?B?MXBNSi9xclpvV0lIMFozc2J1c0dEMThPbDlXZ2NySEc0bFQ2RnZLbUNsZDkr?=
 =?utf-8?B?ZVFRZjhUbUMwU052VzBkbEkzNFdmUHk2Tm5pUE40dmlyYlc5SGcwOWd6M2gw?=
 =?utf-8?Q?iakc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2de146-6125-4b98-18e3-08dcb6f08c4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:52:24.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZVXfa0dImnasBiAqwKF2FqIKTFy0bqwEwVU4/XOH6HPFN80WbHtKyymfRCRh+k+dfSSUryvZo+P6qRI1J1cVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113

Add #address-cells and #size-cells for gsc@20 to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb: gsc@20: '#address-cells' is a required propert

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 136cb30df03a6..35ae0faa815bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -364,6 +364,8 @@ gsc: gsc@20 {
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";

-- 
2.34.1


