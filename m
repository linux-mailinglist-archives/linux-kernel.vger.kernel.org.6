Return-Path: <linux-kernel+bounces-311040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F77B968439
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9AA281D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CF183CDC;
	Mon,  2 Sep 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nCfSuJje"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00E13CF8E;
	Mon,  2 Sep 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271851; cv=fail; b=Gfl/k9ywkuZrXMISalVolN/VTJWNhlVEdDiYBK79lX5TiTfloYBeQJZHFoP2Rh6uVwgXpQXFZ5MyGIrtcTp3sIRJSbCONm9p+z6gNX4aYNO4TnIs6jIko4wAX8tAJ6ySIR+ZHzFXczlm2bhYsZ1VpiBRaZgHPn1etYwuwQcZWUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271851; c=relaxed/simple;
	bh=T3ouo6JqrBl6gRPM1+ATPUjFrSg3pBlFk42i6jRn360=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FbQMaSVyMdktymaWRG6S9soa1cr/vxrohB5bILlGIp7iLSDtLARMr4+t2r+Phmn1b2Qw8JV6jrFh9Pehe99sycVQ1S5aiW/vdwGcjIPaD3Mz+3OZrkJ8dPIfdOCf8SSf3rWd1JSEgMGucELAObqz0ztyOCiRgKHj0EqvAWMRO7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nCfSuJje; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNL0QJKwL6twEokK76KNw0R6K7cw5lAnrEai2bmx5mvAZ/9VogPqG2OM8D/yuXZ5w/Oa+jbntk2/ZEwItm4Pj3ICtkBEK1Uy9LMSdvnzOjz8z6oB6KzXoY+YF6oiiak27k1QH0S+DcRyk8Iw/W5Sa4fINmy01uNKrhSlIzkc1rBXrT/PTU+tFE+WgTWM8juDQWhxo+42kb/l/bRMm/CIkceGtLwuS9rxvLc/ILJ7nQSDuyFigoUQrZjEh3ZYJRR5uW6qdo7nGdiaXbRU/kNRQ4NWFqcEOi+whmy/pzA/P6P0e+jgVBP5e2rln/pKxurkPgXM91WuK5CIQ5ZYnJlDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgRyZ4DuHtL7XpIdQEzc+Mi21S2zKMHIAFVlVqEyWfg=;
 b=FWvo7szSQlj201dpxWIIx9NU0QmT7UKKBvDeV389oNfz5ZgigXnBPvcbgNzoXJHRahEUyJ7BfvSKgo3I2A8QSezGl8BbsEAaiNAONOIcafb12u0vAD3UNKI2vEumMFve2FhD6Y72S/oqeEZV0D79RSaBs8ARdPJvqV5b+mJNYm9TI61xGuRc4g+eFWMOYLprGMDwWb1v4m2nv9czhqJT3hadjI85Rz7cAk3sC1z6TijRFmWnRF1ZtGaKEY+H/dntR8Q5Do3Dl8TzALqgiXmqj7VZL2pLGL4nd+Rck+7mZEN7cqcefylJtC9+rsGHmi7xAPgc7k/+C1/34Ne9jiZ7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgRyZ4DuHtL7XpIdQEzc+Mi21S2zKMHIAFVlVqEyWfg=;
 b=nCfSuJjek4sWvQ1bG3WqzuSByrfd5IUkHABPgFQ7TxKs4gMKFWTIeluC2ci1JVj4QSlaXxBkHTAqUutFjTpNmSZo7wQ0U2EVpeK5x5SlNtqJeKoY6FrRsNdMSB8kK4H6e4EeFaLOvJLIaLtxfu8E9b35ZDk0ScqguueHQqBoIi4WJ9J10TZF1rKGZhqAwPcJL39YDgtTVvmRqkKArMGCAc8fZcfxRdOzCa3H2zCUDFaYQGodA241+4I1wVBe51G5QI96WlzP9jZdYUqviY3hK/DiMZF2bx47beUQ7JRgp+yZWNje0oqw4eDC1dPrj5KCaAqyFqnqMeimynfCMeOYeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:10:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:10:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Sep 2024 18:19:25 +0800
Subject: [PATCH 3/7] arm64: dts: freescale: imx95: update a55 thermal trip
 points
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-imx95-dts-new-v1-3-a1f798f4f746@nxp.com>
References: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
In-Reply-To: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272373; l=869;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vnDFkfL6Fc7H3M7/D9xgaTW6JKdWqVWqPpFMwXxRAQQ=;
 b=FkfY9aX3iEos8cXtPTXCShm1cwu/owd7rQ+xMPUF4xBB3gkDTpAvJzD8lmlSBtEH0sQoFq/er
 8tSxjNduTqpBo77Gt2SbqWalz81UysbsmpalxLTYZDJ/KMfnpga5gIB
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cf6562-559d-46b1-7358-08dccb378331
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nko2NUthVGw4MEVnVUwyazk0VG1qaVpWdHBhUjFYR0xha2tpUENzcE9GelV6?=
 =?utf-8?B?VDJycWExb2lMdFZvNWs1amQ5L1B2eUxpemIzWWcxWUJ1RU9wZFA1elRkMFA0?=
 =?utf-8?B?UTFXQ0Qrb2czODlIT0hGZ2NoRHJpTGo3RFZ1YzdTdnVNUU82RlJqVTY1dmFE?=
 =?utf-8?B?Mkxzc2dxWW1MUjFrU1R6b2xySkkrYWN6NE1XUGhvR3pPYkl3emFFZE5kK2Fy?=
 =?utf-8?B?VjdzdXV0WTNwTHU3ZVRTakpnWGh3ZXFqYjlrbXR6dHNmdTBWSEFpOXY1MmVK?=
 =?utf-8?B?TUh4TG1OTEw4NlV4UlUzdmNJMFFreFcrZjd4R3djV09IMjlySml5SWJvU1Nw?=
 =?utf-8?B?Zm93aklpVXM2RXRWampJTDZKdDJwUmRsME10TXhXR1NudE1uMWdWbEIrUlJF?=
 =?utf-8?B?TFBtSDhwQTdOdDJITU5mdmZaSUpqUjhFTC92Z0pqWlpWNlg1UUxxNmk0QXc1?=
 =?utf-8?B?R1doVjVPQStxYWd2c2pvNjgxRW9aaWg0SHpXOU42UnkxcmlETXNiY3FzWTNN?=
 =?utf-8?B?NmNzYU5MeDBKaWdXakU2TW5FRWtRaVk0bjFKTm1SeCtzbUtCYmFZOEVXdmoy?=
 =?utf-8?B?bkpEaWtnTWFMYU9MTDFOY3FySHN5cDVYZnl3RlRxemZ2YUNSc0NpN0Jya1Vx?=
 =?utf-8?B?MTlqazRrR1d6L0luTkFiVm5aUmFnMHlFUnUwT2tPRXV2SkVYazZvSGZQQmpH?=
 =?utf-8?B?ZkhpVENmNmNCYy93MHRTQ3ZYVW9kd2hUcmgzWWlrUHBRUzRBRGp6NFZBZFA0?=
 =?utf-8?B?eWNjcTM1UFdhMFRUQmgvRHVHT1libVc5SWg1bStkcWNVcmkvRHhtQ0xLWkJ5?=
 =?utf-8?B?QytobHJXTmp6M1NLU2N4UjBuWTc2S3dTc255SlF3OWRnc3JNWjVWbmV4amJP?=
 =?utf-8?B?ek9ZWEJBVVJPTTB5WGd3OEdJbTBOWEtDMkVLRFk1UFVVNnNNVFBuZVBzS2JO?=
 =?utf-8?B?Z1Y3ekFtbFAyRTFXS0prYVpoVkZESmcyWUNpNHdMb2JzblJHbVFCQWZLT2FQ?=
 =?utf-8?B?NGlQSlMxMHFyNG1hTUt0TXF1RThDUWxIMEU5a0pPMmo2dlIxTWVUSkxaWGV6?=
 =?utf-8?B?M3BPZjg4TU15bzhpTlpMQ1ZXMVJ3NHc3VWZNSmo4aEZEcTlwRXlkWlo0WHZD?=
 =?utf-8?B?YXUxRmdiMXZEYzZ1TndKUWJQd1lWU1lTVmxXaGo2VDAxRW5ZVXI5ZmJxaUQ4?=
 =?utf-8?B?dVNKVjBRWVhMSG93a0NsaVdLMWUzM21tcGxPK2ZKQjVaNFVqT0xnU0xKOXMr?=
 =?utf-8?B?YjNzYVAxallyQ1dYT25NZ1hLTzZzU3grOHlSNUVIVlJJY0ZwNFFGN041NHRD?=
 =?utf-8?B?VDY0aENqRW4wOFBUUjBOZjZRa2ZLL28wMW1QT0g1eGRPUS9kUDNKajNLdHN6?=
 =?utf-8?B?VjRoV2hjclZoZzQvK2J3Q3BDNGk3cDRvM1NETUZBVFBuNUJvMkt1NXdyWkVy?=
 =?utf-8?B?QjlreXcyaVVGVElmUDN6NmkyQ3d5OGYrNGtSN2pLR2kxSFROWGpPenJUeHNT?=
 =?utf-8?B?SGdpUXNBNTNrb0dNREtyQVlKM2k2WmNycUw2L2kwQmtpNzBnM0Y2MWR4b1d6?=
 =?utf-8?B?OXJGMEZXQWJkNHdsY1BQSG0rTjkySWd1OVBzZ3N5U285RFNMRndjVStkSFZN?=
 =?utf-8?B?elZmN09MNTFSUHRhUlB3Sk80SHFhRW9WQi9NbHBmZUFDRWpXSmNWUTNSd0NI?=
 =?utf-8?B?S3ZPSDNTcThjb29RZFlmRGIvTnpjTWdidW1zY2tKOW04TytWRlVUd0FGSTR2?=
 =?utf-8?B?UkpzejhsUEpRZ05PcSt0TEwxZHRNaDZJTlVEazZaRUpsblJ6ZEphSTRKWmVC?=
 =?utf-8?B?QmVhMmZjZmI3dC9QTVdJMGJMVkJObUZJZElmb3hvN3BmY3MzWThXSTJWTVha?=
 =?utf-8?B?c3l6QmNQYW40eFE4c2pXNkwyWU16ZUg2T01nRU1KZlJEQ0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEo3dFEyME93QjFPUS9LdExsUDFlQXA0WURKTEI2TnkvaDR6a09OTnIzdWU4?=
 =?utf-8?B?dGk2Z0NPSWo3SFZrejg0a1JtdVFRSGprek9kU25jLzFHTU5FbmtyaXB6ZHB3?=
 =?utf-8?B?ek5yNmJ2ek0zazZlRUxsQkg2ckFZMUQyQm00cmZYOVJ4ZmQveXZTWm13Z0ZF?=
 =?utf-8?B?bjMxQ0k4dmM0RzZ4Z3hiZ1FWVlNUK3c5Q2s2a2UyTnNKRWovR0hMZVZDd0Zm?=
 =?utf-8?B?b2MwTGN0djJoUmkvdFJ1NzNEbEJTYytobDBlSTlyMUVadGZLWnEvWkhCV01a?=
 =?utf-8?B?aHBEQWVsU0JWdWw2ZGxTQ04zL2tldCthM3daWGxJMjA1N2J1YlNTVUJ3RVFX?=
 =?utf-8?B?T3dBNkllSmkzNlZOdEhoYUpWZXBRZlllQ3hia29Qa0xHdVVzQVRKQnlKRURw?=
 =?utf-8?B?Y2lQV2g5R0tsL0c2OGVIOHprMEZpWENYUHhFTnVVb3J2NWhQZ2IzdTRFUU1q?=
 =?utf-8?B?MnFmSjd5amFjckdWTUdCRHk1QkRLOTg2Q0h4UDNFbzhLS01ncS9WQ0Y4RFVw?=
 =?utf-8?B?Q1ZXVEpuWmcrNEJOL0p5MWR3NmlySlhXRWVlYjZySWhhT1lUVW15T0xSVEh6?=
 =?utf-8?B?RjNkVnhiMzBDNEIwckI1aXpNc0dlZCtkT3hYM2dPRnJYNG5Rc00yQlM3U3Zj?=
 =?utf-8?B?OGlLaFIvTWlVTXRkWTI5UThEM0dFdjlLdmtVa2kvMllWMlI2cDlvdkpBT1BC?=
 =?utf-8?B?Zlk1N2ZIckhWeVYvVk5za3AvZDJZejR1YVpxckxsUUIrRFk3M1p0OUMra21X?=
 =?utf-8?B?VU5UQm5tWVpJZDZhOFkwUkQzcEFLc21IWG9TYmZ0WHZ5MnJybXNleGVKVURO?=
 =?utf-8?B?bHFuRzFlODFWRWRnQ2RKM0VtUEQ2YmxJUkdCd1lCYWsyY05MNDNneWJhWU9L?=
 =?utf-8?B?QU1YOFMvbFIzeHJ6ckoveHRoK0Q5amxwOHk4TWpyRkUzVzZTQU9CVTZVRmtB?=
 =?utf-8?B?RkhNUzdxSHloaDJmWlMyTEFrdFdDdW4wV0Zld2g1M0JWVzJ4KzExb09tc1pE?=
 =?utf-8?B?UFc1dUZVYlZpVFhGVTBZMmNEcTUrRXE5N3A0bE9mdllmOUZCeEdOci8xb2FP?=
 =?utf-8?B?U3F6N1hMS0kxalRSMnVpcTZJVTVOS0t3Zyt0blJXNWZjWGJpZGxFbXBKUTJN?=
 =?utf-8?B?Mk10c2VvbjlOT3M0d1o4Q3l4b0tGOEJMN0I4QUZRcG5BckdEV1YveUNQb1Fq?=
 =?utf-8?B?Z2Vick8wT0JqNDdGcU9PNnJpSk9CTzN5N2J5aWlxSGM5UEROejl5TGtLbGc1?=
 =?utf-8?B?enVwL3R0Q3hLaENTSXVRZUU5eTkwNnNpdE8rR3MxdzNPdjk4TG41cU1xWDNJ?=
 =?utf-8?B?OWlONjFjajJKUTAvWW9uYU1ZaGp1ZDZybEo3cXdBODRmSzFqQW5RNmh1RFlP?=
 =?utf-8?B?N3V3b1FMdWs4WVZQRDgySUUyTXF6bUZhZVFSTUphZHF4TkZUOUpQS1haWnFl?=
 =?utf-8?B?SXBvWkpvdHRQekJxcDBhOEVzUXVnM294aWpGV3kvcXZsNDlzMmRCVzB5WEd4?=
 =?utf-8?B?N0xFNGlkaFYrQnhrYVFhN2JjMGtvdW5lRTFFWC8zMHBjRWhnS1NQc29WeXht?=
 =?utf-8?B?V3hHekZNY3pxTmlNaGVVZVJ3cDZsQmNOeWI4YWVyVXh5UW4va0hkUVhwUm9E?=
 =?utf-8?B?d3NNSnVKVVlCTWhsYnFsb0dKditNa25WOW1KL2xuNHZ2NVBLcTFZdi9iUzgr?=
 =?utf-8?B?UUc4eHYwMm1hcitJbjRFYmFnUjBuaFMreklNRlErWlZucHhJZHZjZFhnWG1v?=
 =?utf-8?B?cGVQUVlaWWhMRTFUT2lVNWRtTmRCRUJYU1lSUThFdzhzMWNJYkxnSzQwSHJv?=
 =?utf-8?B?cFJZUkhWWHlaZy82WXhjYzVDZVFPMGlwS0tJdVNHM000OW5IditaNk5VNEI4?=
 =?utf-8?B?YmdPMWE5My9wUWoxTW1pN1ZXeTRPbXhicGdUS1d2cUo2Zm1hdnFxYk55QU5o?=
 =?utf-8?B?dk1JTS9xV2k4WVBwbjRDU3NrR3pKTjRnWkhsQ2J6OHJqWjN4VVhYTDB6blVZ?=
 =?utf-8?B?QU9FV2x3VCtqSUk1VTR3MllMTDA3RkhHNFkrZ3QxTVZzQmtENlo3emdxTEkx?=
 =?utf-8?B?TlNaY1U4ZDFOTEViSG1XNTNLNHdOUTg3NFJydEFJTk4yRWlrbkpWaVB3RXFT?=
 =?utf-8?Q?csRqJC4jRh9l0bmxa6VejtHQn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cf6562-559d-46b1-7358-08dccb378331
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:10:46.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ur6HJsNOL2AY8b/CUAYHdI2MJyLEPfJ2gp8sDdao5CFHMEXgRvKdsm8xu2hz70kpRn8JBafRkVyRzv/zS1B/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099

From: Peng Fan <peng.fan@nxp.com>

Update the thermal trip points for automotive and extended industrial
temperature qualification processors.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 314a45e82c38..2cba7a889030 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -347,13 +347,13 @@ a55-thermal {
 
 			trips {
 				cpu_alert0: trip0 {
-					temperature = <85000>;
+					temperature = <105000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu_crit0: trip1 {
-					temperature = <95000>;
+					temperature = <125000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};

-- 
2.37.1


