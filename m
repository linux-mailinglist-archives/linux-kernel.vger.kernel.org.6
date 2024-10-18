Return-Path: <linux-kernel+bounces-371395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F49A3A83
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD561F2971C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0A2010E5;
	Fri, 18 Oct 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I5zGDf0S"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34394201032;
	Fri, 18 Oct 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245162; cv=fail; b=J28sT5O1FcU5pTC41uqgXz7VHtb5qAuyUDQxtypOLKWhnqAusEeb8JS52iLJuNEU+sTX02J5tW+QEx+I8qzDYXgMGchvTDwTX3yX6MCCOZZJvVcCWrAMXGjI8El1L3T5jL6kEaM98LGAzmoZbTG0T9GCs4oa6dZR9sQ29Kfx0pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245162; c=relaxed/simple;
	bh=N/iy+g4d4ZrluabxI3N13/2R+2wZz+/hS82POc1WCr0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T1qVJJ7NW82vlrwJ7RZGQ+gMBJf91dTg2KVGiRX9mgctPACpSJ8mCzq2FCeAxHrMkMwHugJ5OBzZo/jEXdABcgRmqt/knxMEROzAbZscGNUTHETPoK3GLBTptZNW2T4xQrHkYppCEcG41/LW5LSiAxkcoWwhiSULAlifCBBzjWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I5zGDf0S; arc=fail smtp.client-ip=40.107.247.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aji57qC18OPKTDm/i+gGteyLpB0eoYNqi0YPKeM/7kl3rVzheCW5SLbX8FnhfpLhfwukYfZ2AABTRyL5OJcpqmitwzI0+8n7VPUL9cBW+qh1K+XxnOY9oApXfaTEurQBJ4hG523aShclXKdBLU/VNU7s28BtilcGMaPU7iUgeQaTQDg1nIyRPnzdD719Zt0Shp3yyrQ9kCTHHAFkYOxUvdfVWmqEE5EsGCgHM6uEh54E424b4BycXly3pAUOS3c8RaZyj4Lfg6qE7TzU3GQ1uBfXXvklYogDUBFiCDMKa509Ro4plA0ZF53DXPgjv0aPrJ0K+umfUQxmi8WZA3V0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm/mFQG2wVSjBXkYDMorim2bPCGjUUwGsFt9Oh0GLds=;
 b=CWqvGoLuqCXRK7wpS7HXGPDk3uiIUg1X6M0TkxpQP5VkNjgbnTjLO4eeMWQduk3xE5LToRqIZohGpzC0GnjXSxgbjRdtX3V9QAZkOgjQmCtMPE4UQd2PU45SqDTnlvfA7NuvAQ40nLq9MRNSOR8hm2YXI8z2jWUQeu0Thm6PCe36hFyKKfsYDX1To9Du4MHLOxkGAGsLSK0DpMac95EjU3pIMQLuLRjQXXNvOqESDjMquGw//GCpqbK2RgnVZQw7tq27NNppnt6Q6GRvSKsqRxIW6Ji8GU7gC28BKHpXK9kHGQ28aJkjkeeZuT8TxqbTw69FV9d+Yvi0UbhBPKhcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm/mFQG2wVSjBXkYDMorim2bPCGjUUwGsFt9Oh0GLds=;
 b=I5zGDf0SoGmGTikOJxuBzyPkBQdITmR857k6IhFiRcWWZaqs1LAya1CIPDg/EQbjJVy7JLsuakuZp7HaaTwH6nXg06HIbKwz3OcgFRkk1UBM58qbXNUVGx/FwACo5ZzhfSnWt+Y13NOVZDzruQfz84DRMvAZ+lZKtrVlbZ+mDI1AH/xla6Nrc3k9pWUy5q8qyH4nCbLuVt9AhxvGbhXRKKJYa0yH6KwvVRz5Z3r1mwkWLL95rHu7Y0hLrstUJjBOgrMKssqsyM8uIZwWvYw7JsbwGs2SCW5n5PtxQPGzi8YEE1DkEiRfC6IvBvH1o9CpFhGrYKZzacXRq9qzt2fNVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 09:52:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 09:52:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 18 Oct 2024 18:00:56 +0800
Subject: [PATCH v2 2/4] clk: imx: lpcg-scu: Skip HDMI LPCG clock
 save/restore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-imx-clk-v1-v2-2-92c0b66ca970@nxp.com>
References: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
In-Reply-To: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729245675; l=1501;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Bc91I2eEi8/lINfvZA+03pByFBF/wxNxtYOf5hDZEIg=;
 b=Y+dGz3t9xvJH8MXD9XRzQd4Hx7F8NpX8IvWvzxTdUJyMc6JHXo8QTNMMvkbMDsDPJgmBcw3Hh
 4k4MKmfRuY+CqepJ4Gw+F+q4pGBmA5xbw4ZUuH7XEO7+9otjY7tVNGG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3913e856-4958-4af3-61db-08dcef5a9866
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amlVV2M1OGM3WUF5dHBUS054dzVZWDY5Z3B5UFhVbCs2Y3g3bTdxZ2dPTU1h?=
 =?utf-8?B?cnlkM0RwWUpJZlp6TnkxMWt0Q0pyOUhudEFyS3RscTY5bGFHRTJiSnVna0Nl?=
 =?utf-8?B?WU9zR3ZoYlhlRk9ORGtrTkVMV1BpcXRsZUtQZDJrdXNzQ1F3Ny9pZ0tKaG9k?=
 =?utf-8?B?ekRPU05oZVF3azNwejFuSFdxNS85WlpHU1R5K053SC95WFNqRlNxQloyNmZC?=
 =?utf-8?B?cHdyQ21xbTRzS3RrSjJud2t6dVJiRVFVdWE3VU84aldSaDhSQVlrQmtxcHBh?=
 =?utf-8?B?SFlXRkZFcGVsVCthZGVVMENnOTZ4cWh2SnEyVEIvMHoyRUZoaXpMek56aUxY?=
 =?utf-8?B?T09sR1ZlNWkxYktOQ2hSNnhHcGtaRkhrR0dseEZKaWZSMVl4QnF2MTBqc2NC?=
 =?utf-8?B?UkY0a3QxTnMySEVVaFNIdTN1VUttaENmRU9OdURiM25PVGR3NUxyL1NDSFZY?=
 =?utf-8?B?bERWYWFSeTlhcllkOExKTGNLU2Mxb3VhWlBOZzZtekdPRFhoaVhuNzcydUxL?=
 =?utf-8?B?cUVhc2ZidlI1QWFmQUc2NC9LM01zNXA2Tm83UDd1cy9KckpzTUE1eG1JN2hm?=
 =?utf-8?B?L2ViZWVMUXFKTnE2V25IMlF6MndxQzN1TTdIVnhpR25kK2RVU2F3TmRBUE5Y?=
 =?utf-8?B?TWZVSjR2VXVrYmRKaE9lK3FrZTB0ejl3YnFwMUp4cG9GeVl0d2JucG93ejhk?=
 =?utf-8?B?cTgrUzAvOFhhZFpJV0RHTHB1NFlLSjRlQXdlSE5aRFV0MUg1NmlmaU5DYWMz?=
 =?utf-8?B?L2NPaGRxQmc3L1Q4bXducjZFd1VVU0g5RmxsSEhlNk5acys1Tkt4R2tPeVBI?=
 =?utf-8?B?WTdXV2gya2RpNHhUQjBEeHU1Y2lzcHViTXBWcHY0bDdWWUhsQkNXVTFzNHBC?=
 =?utf-8?B?c1ExYnB6UFdKMjBEcXdqdWxCdmkzQ2xBbVplSUZ4WWhNdmxBL3lPdUExZTJp?=
 =?utf-8?B?SUtGZWFoeDBva0VhMVlCb3VJZHRKWmRkUWVqWHViU1BwZ1JpNlhEMjZrSnBW?=
 =?utf-8?B?R3h4MmtDc3VySFpmdXFVL0ZDZWpJQ0NERDZUaDRtTmkwK0RVY21WVnZQZC9Y?=
 =?utf-8?B?VlMrVHdacFVHdStoUFl0MjdzeENhSlpvMzZnNHU2ZDBHV2RRTGYyWHhEY0Rn?=
 =?utf-8?B?V1RobjFUL1Y0WUQ3bE04RVNnWjhBOSswSXpNSWRrZG1XeVdTUDhYcEgzNTNr?=
 =?utf-8?B?Y2R1SkJJTEpWMDRsUkJyZ3h2VDhqVFZ3aXYyOXcwMEVZaFJmNjlJRTdHK2N4?=
 =?utf-8?B?MGxyajBlWnRhaW8wVmp5U21iQk5PbEV5TjlzbTZaMjVzU0dzYWtOK1lCMUp6?=
 =?utf-8?B?bTNzdTd1bDV0Zk5oS2RiVmFXQmxRVUN0WkZOTkNlMWcvVWlxMzVzc2RGSzAy?=
 =?utf-8?B?a204MCtqZFFyVnR4SURxaUxtZGVzazB5Qy9veWJpS05YUTFTVU01M2NqcjJX?=
 =?utf-8?B?Uk1XQUIyajF2a0dVbENDRGRJWFVRTlVDZnN6WDdBZFhldWpEQngwalZhVTM3?=
 =?utf-8?B?dHdrVjdUUk5xV1dYb09GV1pmRW9XNTkxNjNxU3RaSUV0dklzcHBnSXU5Z1dh?=
 =?utf-8?B?YUhXQlB0NDJHelZWRVFEcXBSODNwRE9zTjI2MWloaGxSejRBYkVCWldmeUpB?=
 =?utf-8?B?d1FtSGx5WVFoRWc1eEk5TWNjQmtaOEpVTk1MOEE1aWdWamQ2dGdCSVlZcVp3?=
 =?utf-8?B?ZDVOR1JkSkptWXpWNllXZkRLTjArRmJyaU1hVUUxVjlpVENPS1doVk9XRGJl?=
 =?utf-8?B?TEEreGF0bzlPTXNzWlNyTDB0TXYyVGRBZUp5OWJZcXpDTVlOZHUyejVlV3Fs?=
 =?utf-8?Q?QMuXoZQjZvY1qkOigMEQ55IDNVxYm/r4YrUts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJqVmtzRUNOakVweGJIM1pHbExCNThIY1N1aGxTMzNRdUltNzVsR2NWNnVo?=
 =?utf-8?B?N3FSdXkwQWVUZG9XWjlZWFdDR1BnUTJsL2FMQ0NXVXZiaFVBWStycVVNNGhS?=
 =?utf-8?B?N1NjTXpjc0EzR2VXZ3IvdTRNY2YvVTE2RDQ0Unc2TW1NdmhGMS9lU0c4T250?=
 =?utf-8?B?bjl3YmNUK0dsN0UwNE9YUlBpYUdXQ2YyRFVVSHJSZnNJZ256UFhtZ2dYanpl?=
 =?utf-8?B?SDR4OHVrd1VCakxMYVVHL3FtQUFNRmUrb2NZakpIQ2lpRGgyUmloektJUU1F?=
 =?utf-8?B?VzhvOWYyMGpqVitmU3ZCaHdnc1ZmdlVCK09jVEZlU2RhSkM5YzdraWNsL1FN?=
 =?utf-8?B?MWpWSncvditnQjZoa3JBWXZEcndmTVpWRlJHWnVrOTlGODQ4blV0YUFCM0NZ?=
 =?utf-8?B?QS9TSUx4SGR6K1JmVEZDSG1UOVRMZExwUFdUdzZYK01CL3Nzd2k4SlU4SHV1?=
 =?utf-8?B?MHhhaXhEQWhva1V4U0xvS1QweWg4eWpVdDk3NTNjUHZpQlN5bnFmWmVGUE9W?=
 =?utf-8?B?TG05bmpzUHV1M0xJWGlSSkgwNnhqWlFuU2pGYjFjSnNsMjN0ZHdhVW16QkpP?=
 =?utf-8?B?em5KZTVEaEwyUThEbzBnTzhCNHdxTXVaRmU5VmZZTldSSzB0bVgxZ0VrTGVo?=
 =?utf-8?B?SEIyNDg3TU16NVVLYjcyK2dmU2c1emtNenhHZDgwQmlKSnJjRlRxWGNFcStm?=
 =?utf-8?B?QlBqU1hPWFhYVkNsd3p3UGxUV05CMWtsdFZJSHBUNkd4Wi9iUkp5N0xTWkVY?=
 =?utf-8?B?VHJXT1YvbFE0bHBUbENhU3FvUDFNaE9scjNtSE1qRzdZald2ZEErVkI3V3Rm?=
 =?utf-8?B?eCtzbzlxeVhGUCt5bXJINjBJVDkrbStvUE1DMytaTkM5eFpxYXFSOHRDV0U4?=
 =?utf-8?B?ckJOTzJvLy9od0xydnFFbTFDbUtHTGxnQUR5YWI1U1AxaTc2S3dGZzRmTFc5?=
 =?utf-8?B?cTd6ZENLSEduWHZ2U3NkR09COHd3MlBlajRHVm9paDR5bEdjMXNmYjdoSzJu?=
 =?utf-8?B?STdldDAycnFCRlVXZEErQUUyS0N5VGhQcElUSklsWWYzSElvakZwM2pHdDR2?=
 =?utf-8?B?RTJrQy9jR3VSRUZMWkxGcGJZQ2E5V2NzRTREWEJnUTRHK3QycVJlNThyUE1K?=
 =?utf-8?B?MmVnOXdncnFaRUlKejdacjdKdktkWGdwRzlLRWJSWkhZaURSRGNCY3I4ZW5n?=
 =?utf-8?B?cTQxZzI2NkRVWVJaTC9xck1DR0pYOTJXRmZsdmNDTXVxYkFodU9VeGNsb2k2?=
 =?utf-8?B?SHpibmZyUlJLZ1ZVSm5CTFl2WFRYazA2eEZMQ3ROUXk4S1FBd3BFTzA0WlhS?=
 =?utf-8?B?ZGgzYmM5em92UUhRWXpQdHg3bUNYcjEyL0NhaDc5RmpzWW85cFBEVDNrK1h3?=
 =?utf-8?B?Y0ZJc3JTMHQvZFhBU3RRL0FPMWFXcjBpUTd2VDV4WThRdE9UOGJ2L0paVXZV?=
 =?utf-8?B?ZWNIV2sySUZHOWxCazdqL1dIeUx4eTRudHZlVys0Wk00Vi8zU0Rnb3Q4M1lx?=
 =?utf-8?B?TC91RnNveWw3cmlWUnRaaUVPRWV4ek0yb3J0am92MmFuMUdPV0NuV0FMbE1v?=
 =?utf-8?B?Mko5ZUlkRk9yT3VFSmk1NVYraGttUVVJTXB6NGFveE1XTzRuWXRTcEJmdWNO?=
 =?utf-8?B?akVMTGdhOEE4bXgxSzgyMFBTc280Tjk4T2JiaGJaZmpZbWVLMFYrYWp5dmRW?=
 =?utf-8?B?MnpITXk3K2x4UEJUWmhEMlhTclZDWHM3UEo0QnFGaW9BTytBZHp1MVI5RENI?=
 =?utf-8?B?RVliRkF1L2liMTVCZUxyc01Wa2d5WU1zTkRZNGF3bVE5SFd0bkhyeUJhRExR?=
 =?utf-8?B?TEhGNEdjVDZnTXk1dDR3dXRNOXo2eVNLdG4xcy9EcXd3SzYwNitzQWU4NmVi?=
 =?utf-8?B?UjdJS3J1bHJNSlJjekZHT093Ukxrdmg4NCt4NEFoZzJWaVczaHlUbGYzdHA4?=
 =?utf-8?B?YzdkcXU0U1NMbmM1ZWtISUxvbkU0TE54L3VrWk9sU2pnLzRrc3YxQmtIdWJ4?=
 =?utf-8?B?V3lJMHhRaHJHb3hzTDkrNWpXY3ZlVmhZOS9CNGl1WnRIMk9GaVlqNTFPbkpo?=
 =?utf-8?B?U1JLWVRITUp4eW11b21LU2Z2RGF6NUQxNHlLc3BOSDROaHAwbUt2WWR4UHN1?=
 =?utf-8?Q?6PSjv35VrMBCdtjwMZu6saspn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3913e856-4958-4af3-61db-08dcef5a9866
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:52:36.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phywFUaCWgFJsgy6we+Rk2u5oIZm5nkU6C68bbHUV7N4xykKF/PUujgn10rUtAB+Di+2FMuAc6CQoX2tyux3eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

From: Peng Fan <peng.fan@nxp.com>

On i.MX8QM, HDMI LPCG clocks operation needs SCU clock "hdmi_ipg_clk"
to be ON. While during noirq suspend phase, "hdmi_ipg_clk" is disabled
by HDMI IRQ STEER driver, so SError will be triggered when accessing
the HDMI LPCG registers.

Skip all HDMI LPCG clocks save/restore to avoid SError during
system suspend/resume, it will NOT introduce additional power consumption
as their parent clock is disabled when suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index cd42190233662c66f2c354f0a2eee3a2531eeb3a..07deadcf73e929841fe113c7febfb6c9b6c5e719 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -163,6 +163,9 @@ static int __maybe_unused imx_clk_lpcg_scu_suspend(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
+	if (!strncmp("hdmi_lpcg", clk_hw_get_name(&clk->hw), strlen("hdmi_lpcg")))
+		return 0;
+
 	clk->state = readl_relaxed(clk->reg);
 	dev_dbg(dev, "save lpcg state 0x%x\n", clk->state);
 
@@ -173,6 +176,9 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
+	if (!strncmp("hdmi_lpcg", clk_hw_get_name(&clk->hw), strlen("hdmi_lpcg")))
+		return 0;
+
 	/*
 	 * FIXME: Sometimes writes don't work unless the CPU issues
 	 * them twice

-- 
2.37.1


