Return-Path: <linux-kernel+bounces-362306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2299B357
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A871C23107
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9619884A;
	Sat, 12 Oct 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RSSS7t6o"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D33194124;
	Sat, 12 Oct 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731462; cv=fail; b=DeeHm6ZPL6RYdrJnRsWG2wHDWMB9cGz/N7R6PvMalQpApiUWTVgfBii4xmTlp7PiQdACXwQwjIDNiftshCf4IHL3hhmXCNmQ4yZxNYpuQQJeHxI39c3grJB6MO8v9bBarzc8Qcu+NjpxRFP80sm/xvzXUSecCmnB9BvEbwkHSZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731462; c=relaxed/simple;
	bh=adiFVz1pnYNTnHF0eEEBEKw1U7qW2yntRsUDjiTWQZ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eF6T5UcKXs8Ov8J01K1CLMVF1xUw+iSh3oLLchPX9Y8P+nVVCOyvVk/wrxNHw1Qzl12eYR4uzwu5X+dZ0+duy45ihMoFANs0telKVq7aMsoxk486gu0KaeyP2QVbcOqvyQg2hSo/spMQUc6cjMpDphHfiRj7qzAyGg4HC6cTILA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RSSS7t6o; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGpqRyKW/yOlZUmxFi+/ZAV1iB3qI0AS3ueGU4rR2Ro1iPKR0AZ/GtYP2q+Sk9chvMc9rNYObKVmBqwWR+jDL37SIlbaBJh0BXKWtwWqv3Z+BheAZc+ZzISGYSx5LGsHeVsM+g8lS0gkvAW+ezEtmwG+IqIvCMLb9cZTxGdmWjSYzMaA8WS4UeUNNMbU66O3KMIDmGRU3WATyuhv5zwvUYvxdD5RFc0C6xY0vDy21E7rtz5CroQFJOLowRvYpgDEg1NSbpPsgN7ssy1gW8LtxLL/9NzYY+LOXvSj4eIzcd7eeR2RgbGrmjxw4+mqCe93662kolF3kkZjyqs2CMfd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGOdf8unAq3AOxut7wf/53KD0eDvI/A7/VjhpPxRdoY=;
 b=o+9dgzNe1OvAxEdqnR06zYsYVUgj4YPv8lsXZmv4PjewfQTHau5GOVwGphTjjw7qvVVEPLda+BboF7wVxh/KYHeFXdQzVSGFCHVfzN+s9QxV0zfgE62I/ZhKGoukD+Zld/S3ufVqHv4aKUmAxzqSr4QiLuWbOEPyypCo7fbguItwYdEt47JmtLv3bbjfyDlwPnUkwuVisHL0WhYYIsi4Itt2jsdEuq5fKm/e5e1wXZNBXng3amhb4jjzJklmsQXt8vn+kX1bPwjsEZPiutZ37AnS/fQ/UQ34QM1LXzaeG8STLNLwmm2MjV1DrhStsDRMAg3F1D0yXqvgriv6NnBWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGOdf8unAq3AOxut7wf/53KD0eDvI/A7/VjhpPxRdoY=;
 b=RSSS7t6oTbANqBsvQ/8e7b60wmcVbs1IhADsA5TXU4Xd9T8y9KuQx+AitL8gS2p8JLonmfkQ9vs0w/iz+UHvs7RMMScRCvZZGoj4JwlYVUljvtkkzkKNOUZrifYNrJuUTDX18b9UQtbnZEjk0zDbOp8VK4jEirB5mHPRAlgpBpxm2p1TpLmKheiFBOSwnGXJWKtrWS1P7cfV1cVOEdRDcCk6GFJKoNc8Gv7/WRtL3X8s/M9jfGH5fABknnTzyeEDBdMAuhoX1p0XdFyq3t3wb9DBF41RHvyp/NOshthKqgYWkCZtK3hzGA7VR1Ef7ULlANe59LaHtADJ81k7gppz9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 12 Oct 2024 19:19:14 +0800
Subject: [PATCH v3 7/7] arm64: dts: imx95-19x19-evk: add lpi2c[5,6] and
 sub-nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-imx95-dts-new-v3-7-edfab0054c71@nxp.com>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=2799;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yAG3mCRVs4xnMV0dnxeY7gpeK6jc/MWYjYb3za+wqB8=;
 b=9ruvEqBfr6qynL25X23mVN8ZObEhaQG5N4S+Y/wbzaPq/bmMv3UiOERaxCkLBYia3Ly6wCDo8
 5oCrWTbeLy/DMHaLe4TGaaDKZwxWY9ALZrWCWQBzgnajU2igcrNJ8bZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 17129326-7cba-4c76-d48f-08dceaae8cd0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDAzcnFIVkJ6ZTFPVElsQU1GOC8rUmFaNFY3UVJxL2NRcExIQWtxWG51YUdT?=
 =?utf-8?B?ZEVzQmtzaUREZ0VpUHpKNWxCVnEyVnU0QkcrNlJHS1dyTU9TeGx3OTB0TDhE?=
 =?utf-8?B?a1luaEZXVTduSVRLZzl2TmtKZWlqY2RIS0NSQ2ZFZll6ZXdQazZPVVQ2Z21D?=
 =?utf-8?B?SXZzM1YwYjBpenZQZjBpKzRjcDlLa1Q5L09XemhFVmRvZWZYRy84TkJpVkNE?=
 =?utf-8?B?dHZ6eXZMeVZkaGhTSlN4UmJUK1k1YkhjeHN0THVqbFFnUjFjNDc3SUpJUVVk?=
 =?utf-8?B?T2RRWVFYbUlVTkRYTU5rTWdHWXd2Y245VFpVS3pwb1FMWS84VjVWSDFNMFRm?=
 =?utf-8?B?b1FyaGxtVFJBaitkdUd1N2MzRloyNVdmSVp3ejFyM3haaU1DbGl1WWpVR3d6?=
 =?utf-8?B?allvVGdONEkvWW9SdVNvSnIydmlidEl1L2FzZFVMWEV3azUwMDdzK2lTc3hp?=
 =?utf-8?B?Q3BSdE5UZHc0alJZUC93RjBjdVRBd24vM1NrSTdJR2dubHc2eDVxL1FoVytS?=
 =?utf-8?B?MFAySldnWWppQ0hEUzMwR0h0TWNDc1RHbmZMQlJIdUFaeUVHWCt6RXZ5R3dv?=
 =?utf-8?B?SXpXQ2dYVjhPeU1yZlppQkJHeDJLY0ZaQzZjRjVNeW5BdS9OYWZzc0tMUnl1?=
 =?utf-8?B?S01SWUxUUjdDQWxVSnFCemIwQnFFc2c4cnBJMFlKUGtZYmVVa21kVjI2aTdQ?=
 =?utf-8?B?SXZsNEU4V2xuT0I1cUZsWWdqNHFXbHY5M2xSQlNmSkNodnhNVElpTWtyWTFq?=
 =?utf-8?B?RUFZeWZyWW1aS3ZyMHk4aFdpNFM2TVJrZitUc1FpdmpVSkx1WjgzaHpjd2V5?=
 =?utf-8?B?aHFJRVZwaXZnb0JMOTYzb3p0YnVtTXM2aWRjdXNjOTFHQ3oyMHNZcEphS0Rq?=
 =?utf-8?B?a0tvRkVXbzRUd0dqaFl6NlQ4OUt4QjQ0QWs3YXVGWnBnZlVqd3hlMUtTOHRQ?=
 =?utf-8?B?U2ZpNFJHeVlGd0NTN1cxM1pTeTZBNWtjQkFIVXFKM0pIQjJNVHZ0MzJWVUNK?=
 =?utf-8?B?UVVzUmJvUGp5ZkpteGltTElZZW1TZXlObG9TeU5hRjV1dnR1K1c1eWoyS3A3?=
 =?utf-8?B?SUgrZmxBNzBLekpxaWkyR2RiaVBKbmQrTTAraFNOTndzNTZtMzBPdGtpclRH?=
 =?utf-8?B?dzBRdFovVUt5aENwaGd2Umt0TS9WWjEyZGU5VnR6bUI3VFZobkhIQlRwNDEw?=
 =?utf-8?B?LzJlR0RNdUl2UVQySGdzSXFzQk9PU1puUW5yT2E3OVJwaHVIMHlxbFZ5VlM0?=
 =?utf-8?B?RjJwVHpUSTlPMEVxUzVQZFZQMUc3K1JtbHhSUUxRNEtRMlQ5VWl0OUVDT1BB?=
 =?utf-8?B?cWtnREZjZU9mVzd4bk1mSWxRc0IzQkJpTEdDWk1IM3JtQWxkWi9senNJWk1k?=
 =?utf-8?B?VzFqenhWenpEZEE4ci82M2RiZ2RET2t6eVpXYlVscEQ2K0c1UVRCSkNHOVJu?=
 =?utf-8?B?TEpacCtjU2l2cUJwZ2NwblozVm1OSmRycEc4dUxFR3hiVldVMUMvSDVoc1Vh?=
 =?utf-8?B?Uktxb2psQjlYNDZHMzN6dk93Ky9Ob0FBTHRNVVhJN2NNbkhiczArSVNVbzVi?=
 =?utf-8?B?cnJreVZrMXI1SVVCK2RYblhXSXVaL2VFdVRCV1BBc1hLNE5SRXhRcWI1RjFy?=
 =?utf-8?B?OWdrWDhnd0hCOEVLRFBFY1p2NVRjb1VUMkpzU0ZqallMSjBhWktOcTVjVjJW?=
 =?utf-8?B?VDhVU2N2NWpOS1o5S2dlSHdCeHU3VnIzbHZNZkIzSlVPUWdaWWtmdW8yMFln?=
 =?utf-8?B?bzY2Sk5sdUl0RmlwZlhoTnZMbE96NWVPdTEyTzlwakpBbjlGVDZVV2hJUFdS?=
 =?utf-8?B?a1FwZE5ycGk0OXNjR1FYQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJ2amtYeWVld0M0NktwdzRORmRVWnMveFNlaUVrL0thYTFvWDllcE5hOUlJ?=
 =?utf-8?B?eDkvTERZMXFQUnhPRzg0a0dUWHVtc0dVWWdVYldac1AxMUUzVUlhK2t0Qlpo?=
 =?utf-8?B?NzNhczFpMkVubTVOMHp4K1pYRExnSXlUNWVMaUcxQm12V2xsdjcvb1k4QTlP?=
 =?utf-8?B?NUoyNm42ZDV6cWlCZEd0Y3k1NXhHVXNtZlArRytEaDFxMmJSczJpMFpHRS95?=
 =?utf-8?B?eEdpWVNJZXRoa3ZGaUUzZGNMY1Mvb2dkRExncmJWVVM1VTdQdEd1THNsT0dG?=
 =?utf-8?B?T080c29aOXluREFMM1FzYWc1WStTSExCYXgrdGNoOUxRdU5sWVRIRzQ2Y0F3?=
 =?utf-8?B?N3h1VWNONFcrancxd1dhNSs4NmJ5Wm1mL3FJeFViVmUyc2w5N0VXYU1UTEo4?=
 =?utf-8?B?a21BYk9xWjg4aTBLMHhNQ1pucDB5Q1lycUROSlVWVmRuR3VDbUlKcWhiQUhZ?=
 =?utf-8?B?TldnUG5MTU5ENkVDYTRRYVBoK2J3Uk1hc2xvbmtMR3Z2Ymw4M0xhYjlVYnNh?=
 =?utf-8?B?K3NlVEk1emJlejN5ZTRVTHAyeWRVVXBoaW91TEJEOVhweW1VeWR1VzY2aTd4?=
 =?utf-8?B?SXdpeWcybG04QXpNNlNzT2NsdWN2ZUxLTWpmdFpJdnpPSWpKZnRZUU1Oc1hC?=
 =?utf-8?B?NFNDMnY4MEV2aEVsRytvYmFENjB1RkQxUjdGLzFPbzRKSkZnTFZJcm9aaWxM?=
 =?utf-8?B?U2FiajNmV1Q3d2xGdlpLdDRjdGhYUERNcmdIdmFsdFR3NkFjQnFTZ1ovQVo4?=
 =?utf-8?B?Yno5eE5wQVFhdmc2aFB1aHg3QWtQb2VEd25yT0pJekRVNnNSRk9ZRkFxMTVI?=
 =?utf-8?B?enpBVi8vMFVCYXNSQUY5NVhUZzNaR1lmOFBrbmJwRVl1ODhJbFNFRzFVUVdO?=
 =?utf-8?B?QmxwOU41em9DWWtLQVMrTGpxUHRPdWVHV3BtV3BMSTVOdGNaeit1bUtvUHJP?=
 =?utf-8?B?ZnVNM2tWemwwYUJ3dUJpVDJjZXRyWkFuclJaTGV3REg2QThBMEhKakozQ1kz?=
 =?utf-8?B?NytkQmYxRjdJR0p4SUQ3SGV0OENjM3Y4a2lZYmpRckNEYXdHOG90MDJMT2pR?=
 =?utf-8?B?bXpiMEV4QkNzRmhIbWZ5b3JNNGxLWkV6MFRQOHdPQTh4TFlINi9YT2Z3VU5o?=
 =?utf-8?B?QjNqTjhRWFg1dUFhNUZucFpKSGNOMWpFalU1cHErT2U1dFNpMTFldEduQmZo?=
 =?utf-8?B?ZXYxS1JWZDBmNjlQWTNoQmFsT0JUUytFRkw1NlFQT0xKSHJYWElnRmRzQUJF?=
 =?utf-8?B?SG5IbmZwdVVPMU9kVWNDa0NGQ2xBRnpXZGtGQko5eloxOEROTzkxdkF1a0g3?=
 =?utf-8?B?SlB2WmhXL0thSm1IM28reDNjaWJFekE1MktjUFpFNi9ha2xia2FNT0VCY3Ev?=
 =?utf-8?B?bVVZNTk1cnMxay92VFMvRUdqaWx5NXc1a1U4WSs3RmhYUEFWd01uSHVTQ0JU?=
 =?utf-8?B?djJIQkp4ZXkrSE9XYjcweUtwYVI3Y1hLZW5NN003LzJNMmlzWG9vMmh6ZGNw?=
 =?utf-8?B?ME9wR0JrNjdDSElHeUp2TGp3ZjM4aThibGpXUEtVazZFajhPZTMvWno0TGFR?=
 =?utf-8?B?SHMzK0lEZ2FZVnZYQ3laYUFHTThOcUtrOGpwVTFjOVh3MDB3R1VuS0xTZDNn?=
 =?utf-8?B?OXl4SldkMDVqQ3hnL2lCMzlZREV1UHZVeVArdzFPajkvaXN4VVY2L3I2TFlm?=
 =?utf-8?B?MTFETzFOSmNQOUVQTzFDdCtDWUQ3M3QydUw1UEVaU1hWUXR3aFFPUkwvZWZ1?=
 =?utf-8?B?bGNjMUFSd3VjK2FOUFdIV3FUeUIwZU1WY2tDWEVsYk5PdC9naFhMVnNXOTk0?=
 =?utf-8?B?TnFVM3B1NWJyR2Y5YjU2M240akQ1YU1jL20wS1dhY3ROZDFiN2pjNEsxaGIz?=
 =?utf-8?B?dCtMeHd5N0pIdTMvdGdMMWVyVkxzQmVrY2d5OWJUblFTLzJtbTNhUUVURjlH?=
 =?utf-8?B?Q1hLN2xTVDE2c01QZmdXVkllY0dNZEpFVFFQeFhpMGI1eHFWTUt4Yk5ubzJs?=
 =?utf-8?B?VkI2Z21FcnVBVXNSZytnOFVvQ2NjN05lZy9wRUUrRnA1Ry9tQURTWW9kbzFD?=
 =?utf-8?B?ZFFVdmpoZ2tmYS9ndFhsNnkzYk42NndIbWU3UkszbWd2R2ZVaWZtYW11UGxQ?=
 =?utf-8?Q?WJZCbhKyt5Sd7n0+gtPwvu+t/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17129326-7cba-4c76-d48f-08dceaae8cd0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:58.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwmLu8W2WtKssP9XlIpQ3qitEQ7wHeBWVmcp4CkHqk1bd4sVueca4GBQZq4HoIWRCa6wVqF8SI00kNi0PLcS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

From: Peng Fan <peng.fan@nxp.com>

Add LPI2C[5,6] and the gpio expander subnodes.
Since we are at here, also add the alias for all lpi2c and gpio nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 69 +++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 5101cd171e095fb5209464055a52ebdfa7dc5a61..6086cb7fa5a0e14882be3a8c609725e15c179392 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -22,6 +22,19 @@ / {
 	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
 
 	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		serial0 = &lpuart1;
@@ -241,6 +254,42 @@ i2c4_gpio_expander_21: gpio@21 {
 	};
 };
 
+&lpi2c5 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	status = "okay";
+
+	i2c5_pcal6408: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
+&lpi2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c6>;
+	status = "okay";
+
+	i2c6_pcal6416: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6416>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
 &lpi2c7 {
 	clock-frequency = <1000000>;
 	pinctrl-names = "default";
@@ -427,6 +476,20 @@ IMX95_PAD_GPIO_IO31__LPI2C4_SCL			0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c6: lpi2c6grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO02__LPI2C6_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO03__LPI2C6_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_lpi2c7: lpi2c7grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e
@@ -446,6 +509,12 @@ IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
 		>;
 	};
 
+	pinctrl_pcal6416: pcal6416grp {
+		fsl,pins = <
+			IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28			0x31e
+		>;
+	};
+
 	pinctrl_pdm: pdmgrp {
 		fsl,pins = <
 			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e

-- 
2.37.1


