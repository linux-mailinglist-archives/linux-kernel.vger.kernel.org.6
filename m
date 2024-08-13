Return-Path: <linux-kernel+bounces-284095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273694FCDA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272651C21B66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3E225D7;
	Tue, 13 Aug 2024 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LRx/uihZ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653A49658;
	Tue, 13 Aug 2024 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523743; cv=fail; b=b1SD145vaskziBKpmU5ePnM9iB1zyXtHdHHAnp7JOtboGPJ8XQXTIbQzCfhwAWTOrzKSWfxVAWWo4v0CLBSZ8KNqnBShTlVCbNydzuL+MgRlnj/pinjMCEURfGmSrOYtDP/VFU6URlKoA+Tus9zeqIpLfwuF9mtzrL3rvwcKK0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523743; c=relaxed/simple;
	bh=NW84aPKBP3fuVSGgi2WW5uErdydrT7fIP0HAU9pjv7Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V4AnpW5Uo7KxYrgd1Wdd7Tf7NuzT43HG/H+pYt74LhLSjS3ZM6gkZvouEVKMRzRUrWecIPcuc5XKf5rTIUokGtoiF/UL3l7SkKF2G5fwnN61Z7IBK+P2oNygmMs0tROQYEyVAygDk/3F4d64OCU3axLR3WH7ZxGPQft93+8PoSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LRx/uihZ; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBk17qmJ+iiAZ69shHwXNd3+6rcSa1uCWsiHiTCvw9fIZEdVZTJFcsyNpW8HKEzTpy1ZCATwxKvX7g8QLBkZOHG0i/SqiTG8Z2uVLroXofZX1DL6z46Vp3yDBzP7TijBKHKVzE+LX7E+NfJgdaubqLW27tbVYi145sX8I/OMgh4+yizEiT4dWKgUxP/kj4B8055eGOqczz3RWRi4Iru2tB6JMHWdlrCy31tYmxNb3uoh5oYy3MizeyOSGmHlH/mOXw9CGZzlvIGqUvBs/YMdjrUtD6/MFqjX/bCFYP+G5PfnxZiCkOsJg5A+zWTg3PAC8lNdvG/FWD5Izy8ZzK81tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM7BdPrNzKFZxaNfQJPLeXI1FHkE9KkyGpxkp+tI5v8=;
 b=VgX+bwhA5y2AfOAN5PXUqCn7XR00aNdr21RBR7GA8pDyTPZr2Qo01G4j5VEWT02qTExqXVjko9IsPkvZtbfK/zjh+lMK3Yc1fb2nyiydTZ2ezkfcScGXfLaKAIpcz//spNLlWNZ+L8dloy9q8MKZ0Ktl2m+rM4Y+956itk0ULxdjspGFS6v1eAluFWJvTd//36VVilm7DazcoBWXe9MCsJS9bwmaM/B4bA36qw24P5YgovnaspwcjBxNWwMmDPmb/5uN/EjjgPONGRP6MG/oeriaNh94rm4iqSReLmQRkGEzl1UcOssCsstTqeZyPjST04nVd3aLZmhH0Dd+TVM2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM7BdPrNzKFZxaNfQJPLeXI1FHkE9KkyGpxkp+tI5v8=;
 b=LRx/uihZuBXCGAHtt6dT8Jh9HjYUAu9D/klDv/cjT5KobrGlBCS85cGrqYxPQ++SpdKNKyV/17qKrxNUmjOirKxqjyfzOhdLbL79MBV31w6gYLFnIj8cK2sSLmyjkRlfgt3b+WURotmZvVoZirtbIR1CdVXVKE1As1QJVR3MVy5lvto8Voz7oJVwcM9D8CBsmL3UrbOZUIJnVxGYATOfz5fIedwDbnSXzUXb2O+GWjIScfrecfTxXrs8P5Qm2ETbyO9vQ32QtRhuIwdh2fw/+Oqg+dENIN26MnyfV6JADLJJRbsnqj8+lYxZ7XIMjKUt7e2QcVFAxj9EuI8cgJk/xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:03 -0400
Subject: [PATCH 08/17] arm64: dts: fsl-ls1046a-qds: rename mdio-mux-emi to
 mdio-mux-emi@54
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-8-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=738;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NW84aPKBP3fuVSGgi2WW5uErdydrT7fIP0HAU9pjv7Y=;
 b=fqdgYZQeb53m0o2oZy1iJxxtyXD6RQ9nmZhJXU49XqsmiM4kO9JjUlw2tTAm9OV9OIzCW0xIL
 0rrLFpLCKaFDQJRbIBvqE8MdO3y6NvA0QPWH771GNeg9byM2sDu0Gxc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d2d29f-5980-4475-3beb-08dcbb5161dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUVHbXdVcUpqSDFqMXNKbUV2bXdqdlpXT2FCSjlpWUo0dXJKZ2ZVVXd0dDU5?=
 =?utf-8?B?dzlDaitFTUtYWUJwOFp3d2NiZVcrKzY0a1hoamZta0hpMUhPc21hSEtBT0Nv?=
 =?utf-8?B?V2w0ejZ3T01aRjdhbjhNWnVjcmpwM2NzT0VtZWVpRjJSOTJnK2JXUEpQYjFB?=
 =?utf-8?B?em1lSTRjRVlNeW5GUXNOdW83YmQvRkNYeXZ5TUhLRXc2a1dVc3JJWGFvSUNQ?=
 =?utf-8?B?eFpqU1o3MHZwY1RZRnlrQUdOcmZCdjJjaTh2dWk0VjZXYWZGOWRRSzNFelIv?=
 =?utf-8?B?L20xVjc0YU9nQ1h0VDlIaGs4TXN6bkxnUUZ0UGhXQ3MrM1pTblJyc0I0eEIx?=
 =?utf-8?B?SEdKY1UwbzJPbm1XUjFuTWt0VlkrVTVFbmxyUG5vOFNaU2ZhNFQyNDVjZUpU?=
 =?utf-8?B?V0VIQjhZV2ZRdXJYV1YyaWVRcUZpTWYyOSt1bEZsWjlHZkNkaHY4eFc5cUlF?=
 =?utf-8?B?dE5WaHhxOFBTNWx5VkRTYXhmU1paT0dXazVkdmdQc1dGbzMybEtJcHZZRC9B?=
 =?utf-8?B?V0RqUGk1VDZyT1RTN0ZCOE9Jem1aWHVtd0hYWmhmSi8vS3VHZUxmRHBiMUMv?=
 =?utf-8?B?Zmh5aEVRWXVTWVl0NkNOdnRveWJ1aGdCTk1SQVQvZ1hpRmc5bFdUNzZLOURW?=
 =?utf-8?B?dGVmLzFGNnVRKzh0Um0rbHdYblVzUUlBMkFlTHYzMk5QeFVyRURxOFArNWx2?=
 =?utf-8?B?RmxQeWd5SE1ubkZSdkJHWEN5U0F6ejNwZFNwM2o4TFk4a214bWQ4R25UbFhi?=
 =?utf-8?B?ZHVqcmpaWTd6b28zRFVvNmdXNDloekFpcUw5MjNwVVFkSlRaZjJQOGxudUFK?=
 =?utf-8?B?TTJoQ1ZOOG5uYnBUNldNTHNhZkJrL0pPTW8rVVNIZThDS2NDRlZDcjcyMWxZ?=
 =?utf-8?B?djkwNysyZDhOQ2NCNytuSXg3YTlEdUVwSmhzVDdOQW5oQzlVVkVOQXBUczhn?=
 =?utf-8?B?WU1jT3NiZEtHRjIzUzZtY1BPOXZBQXhzb1djMXp1VmttWUhNREtqdDYySWN4?=
 =?utf-8?B?S2NIcUxUcEJWdnhacndpcTRTRkVGR2g1UTRKSWRhVzd3UEdzdVdaSVNFS2Vv?=
 =?utf-8?B?bHU4eVRHOEJJV0RMcmFNK2pEb3pIaXVoTlFUYjNvKzF0ZUN4WXVOYy9NU1Bj?=
 =?utf-8?B?Z0lFLzMvbVltTlNULzdtQUNobEdOYVArbUpvZmZXZVh2RzFQdW5HRVk5SWlw?=
 =?utf-8?B?aVZyNTYyWm5BOUNCMlN4Tnp6a2RoS0VnUC9RN0FnRjVhK0dsd29JODVzTzla?=
 =?utf-8?B?NXQ5bHZCUm5qKzh3UXZGUUNHZkw1endnc3AyMENCeGhYaFRKc1F4akV3M1Qr?=
 =?utf-8?B?Y2c4VnpYdU1VaHoyNnpwd0xUS0d0ZUxJVlpxcFpLTGJzMnpFdVMyV3lZaDJh?=
 =?utf-8?B?RFlXRXlWQjJ6Vzd1OWtoTmZCRFY3UURod1FiVHdLYTV5dWtad1FlMlREUllh?=
 =?utf-8?B?RWowdVRiOFc3azN4WDRmQlloQmxOK0RKTll0T1Ira2dtL1N6WUZsczVoM3VI?=
 =?utf-8?B?Wm40T0JQcFhpWCs0RXlNTDZweC9NejFZZU1SY3g4Qy9MQW9sbTNSSDQ4cXpa?=
 =?utf-8?B?QXNqVXRhYkxSUk9hMmlKc2Z5UnBDdUtkT0ZNQkNYWnprVG5nTFAzVDljSjYv?=
 =?utf-8?B?TzFjZmNaT2NsSkR6dCsyQTNVKzFxNURnTVVpcDNDUGpUY0QySCt1Y0ZMdmhJ?=
 =?utf-8?B?V2JzaDVpUTgyalc4eS83QTRGSHFjL0lYZkZTci80aVVjWnZQZXplT3BqMllI?=
 =?utf-8?B?MlJ2V1F4WEpGR1ZtUVZNcG0rVENKM1V6NG8vM3pHWHBHdjVJZnYzNWJXbCt5?=
 =?utf-8?B?UUhHMHBtRVhzcktBUllpUVVyNHU4YU8za1FCK0VwTFY4STE2MDcrM3Yzbm1i?=
 =?utf-8?B?NXNiRkkwYklQeTNBMjNqNWxuRGYvTGRWTHZtbC9rRCs4d1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0FFYXRhOFBvbkQyRkxBdlh2UmRPSldEcDMyZlVRZWRKZ0JVM2NLdE1TRjhX?=
 =?utf-8?B?VHpaOTBEaERmNTZManlsNC9zalhXRHZPQTQ4VDFyRStjV0dWNmVJTWJRQXZY?=
 =?utf-8?B?aDdPM25pSXRMTGhzei9zRUgyRVQ3dTU3V0F1QXNHWm1XNTVlR2dhU0V5VVdJ?=
 =?utf-8?B?WnNucGJFcGFYcysrWTliTThpeGJOT2JlbDVhcmoyaDZYRmhWWllLajJEajdm?=
 =?utf-8?B?TzVkWDN6WStPdTV1M3dMTkRxZ1ZialV5UXZFZ24yY2p2SkNTSHJrTU1sYlhw?=
 =?utf-8?B?VkJland3Zmd5TE5hN1JUMlR0M0FIMERiaEdua0I5b3dJbklKc2FXdW5sdXp2?=
 =?utf-8?B?Yjh3Q20xZHpXaVJSUkZjdUh0YzJlUlMwUlFFdjZQWWtzWUIxRGJnaElWTlBZ?=
 =?utf-8?B?alpVK3ZiKys5cm9JWmVlS1JMaTVieDN2VU1wMS9vbXJmYmRRQ3lTMFpqOHp4?=
 =?utf-8?B?ald3UWkzQVUwQU9xalZ1ZGJEanJxY3BDQ0U3NVdvYWluU1hRM3RLSjJuVE9P?=
 =?utf-8?B?T1ZQckpvaTl4bHJ6MnhTYmlZUUIwb0ovb1dFTXc5S2R5VVNTeUxhMzdZWlVm?=
 =?utf-8?B?U1gvQWo1ODBsZWFWenVnYUJHNGMzZ3RDZzQxVHpycW9lZnh2NmxPTzJqL1Fo?=
 =?utf-8?B?c3NnSGhwNkhEbUpHdXQwdmM4QWQ2OEtEb0dadktEVTd5QzJTMUVWYitCWGJt?=
 =?utf-8?B?OWllT1JYQktzTytwVE0vcVVqdEVPUFpzWjVYdmJ2czV6ZDk5SmVXWmtNMjlo?=
 =?utf-8?B?a01GcG9KQ2Y4UGJsR2R1NU4xWFQyTUQ4UGU4eWVyTzlqM2lrM0xpaDhHWkNt?=
 =?utf-8?B?S0FTUFlFcVNZMEVaRDYrMGZnaUxwcUFzcmFQUlRSZUx3MlpiVUFyM3dicWNx?=
 =?utf-8?B?Tm9oVy8wMVdjZjJMb1BhSFpjQ3IvcFBpQXlZN0hOdkZqZ0x6enFFNjJUS0c5?=
 =?utf-8?B?YWh0VnppWElLaHNqQlRQVWtkd0VEclJtT0JLOXZ1ODRYeTg0anZObnJYbWJq?=
 =?utf-8?B?c2hJVXdIS2ZUOU9MN0JRR2NKems4VVhiTjJpQ3dRV1NEY2RYbmJmMEFUY1Bw?=
 =?utf-8?B?aUJEcTl1WlZwai81d2o4dGNGVTAweXZnV0FyQTZqOWEyVlBrQ1VRUUdocTBZ?=
 =?utf-8?B?UXcrRndDYjUzMlBaQU9uSElCak5JUnBDakJid1VJVDh1TER2b1FPOTMrK3BC?=
 =?utf-8?B?UUN0K09XUzJOOGtjV2JhdW9iZjZucm9OeFZxQnpYdWQvREhVdTlrSHZ4MjZi?=
 =?utf-8?B?bGk1L25GOVBkU1pDUzNpRjlDUFFVSytZREF6T0JUWnV4anY5V0FmOWc4aWdv?=
 =?utf-8?B?QzdpUjNOelh4R1VkeEo5WGJCSzU0aWJONEt4ZjJFenV3bm9FcHA3QUZSL0JL?=
 =?utf-8?B?VVRibkhQQi8wcHVLQlhIUExPYU15ODBEQVpBV0IvTWZRRExvU0Rnck9Qb01Z?=
 =?utf-8?B?VXEzRk1GK245QmFxWTI4aUlDYmJualhoNUY3NndwL3JUZ05Ddm82cU01Z0g2?=
 =?utf-8?B?dmRwK0phSE1zN1crUlhXTUdVZEZQMkVYZFBGc3RlSzVsellHaFpXWmZhaCtN?=
 =?utf-8?B?bkNYSkZqbmVRNUdlSkgyd1pHYmxVeFVzcDd1RTFCdm9VZXBUV0I4Z3BVbkVR?=
 =?utf-8?B?TDE2aWhCbWp3cTJpOWNYbkNYOVd1Z1dVUStGL2l2YmZyUUxxV2hST3VucjRD?=
 =?utf-8?B?ZWJ1eU52c2V0MXJlMmwxVW5PVldyUVZYeUtDN3lkaTk3Y00zRUVVbC9VSFJM?=
 =?utf-8?B?STJ5L1JlZzdwd2NsbEN5WjRMbUtGSmNTcjJReXBaTGZrWGlxbElBMmN6YStJ?=
 =?utf-8?B?WVYzc1NVbVI2bHdUMll0V2tmblMreTFDUitxNDhwbUR3dlByc0pNTkNvNXBy?=
 =?utf-8?B?L1ZPV1ZtUWllQWdXTnNock1XbmNWclpVRzFJWTdxRmlRbUNYRjhmb0Fsck5q?=
 =?utf-8?B?UmpodzdiZjFLVS9OVjBlOWdKME9Eb0x1eFBoKzhHN3B6SW94b2FxSWdKTWo2?=
 =?utf-8?B?cTJmMHIvbWVtWTduSmprK0pCb3g4ZHBITi9GYVBHZjBsNUFVRWZJOTR6Q3Vu?=
 =?utf-8?B?VCtxYlh1R09kOXJSV2JnWnMzME43ZHZUZUQ4RzJ6REtBTkJaSjVaaFRDeWdm?=
 =?utf-8?Q?5AK0F4MYp1XifQtRkiE18aV32?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d2d29f-5980-4475-3beb-08dcbb5161dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:38.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0deXAXaqNsYIRokCmauGMFk66FyFUHCWD1BzyKtnup2bmgi4cfCs4uycGdBrJymnqSAi4caDXInZe+Wqp9e+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

mdio-mux-emi have reg property. Rename it as mdio-mux-emi@54.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 25eb1d5a69381..5c504ff47f2ca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -237,7 +237,7 @@ &fpga {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	mdio-mux-emi1 {
+	mdio-mux-emi1@54 {
 		compatible = "mdio-mux-mmioreg", "mdio-mux";
 		mdio-parent-bus = <&mdio0>;
 		#address-cells = <1>;

-- 
2.34.1


