Return-Path: <linux-kernel+bounces-526680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E1A401F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F163ABD53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138E20125F;
	Fri, 21 Feb 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xk9p1vWu"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38670253F11;
	Fri, 21 Feb 2025 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172591; cv=fail; b=EtAZq3yVh9xlERmMGv5IXkehwZsDllNxz5RWqbz0O+3egVd+8f9mK6VqugPrOxOuTh1JUfCQZRD/Ii2X4SP+Bmmf2Xg5hgAtDVuShScVhWAmFhKUfOycD1Ix/nwcm9J1kjyCyUR5CkIjDKUFoHPzvOQBDzbuZgDkNclbKQYKqFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172591; c=relaxed/simple;
	bh=gv9LRA/tkyiG97rIW6rStvqxfOn31iaYPYWkS2z5LZQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WWn0uqgXAiLK60Y5k/xWmyePkn5yk8RoYDaXD6GPBOsAa7ivYhTN3HrNV2R49ZHZPMrTvjdEHrUK2tOa2ETYrU123P9tUAhrBN/6RLR8GSL4PWa61EgIrBnOYurtVum6pa9Fke81Rvsa1SYOwzooaP2KXRKu/8fU91UR6eq3a0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xk9p1vWu; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nED7vE5GBVKv995lWkNdJxcmW1fI6b+S54ldKeO4D90IwZl/g09YkWZPba+QVBJ10MNE/syZW7N7NdMsUhVkW5Sk1mRJ6nWco6pShHp53rtGHpQvyz9c2zu4X2pceKwM8MXtZb8zTv0LtO22GMAg+pDwG2YsSV3JfpTcB3hL1jDIucJFcyii1RsHWPXahTD71JHMs0gbDBiaZqIHePEmc5evBUEV8K1UhwRhR7kIRuuxVgQAp5W43S6qbgFvi59HTwlDV5oYzaVFx0AYS4FiYDsGMp9M54CHrBXX3Ggo4UnBmCyz6eWYrWVciEoYkHaSrvojfcomEq3o/2kIYO/KVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG8vI/27zLSEGY3Ns5WepYAXZFhR7QqOgi2wJbNFxsE=;
 b=nPMHjYhXwUQyXWn6yEQASLOkSF5EgSaCrK2G6EQxyBlyIt95L/EiI9usYraDZ3HVPB2qsTau8v3RQbKANLlDuoodIMs6jWJNrxyTdmMNB5+cHUkdntWracJo4wWd0S/P+FBPYKdwmxh/HmHntNnoIIMEVcy2mv7lkTviX/ereyIFHml3spDLe/bAnq4ltwZwnkosw8c3fBrB5Wu6c5DfH/alGuUp6JM2KXjcG4MyP4BHUjIJnb9tN6L8RZI1Xxj/bAIoBttMhvAqUWfcJNZ7XZ9pCCkBhtqSh6PiM3pyrN/7F+Ult85wwo3FJeK/u3OFHqE59nIskMfBvfgyuaSS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG8vI/27zLSEGY3Ns5WepYAXZFhR7QqOgi2wJbNFxsE=;
 b=Xk9p1vWuOIczujf69vbpa8Gch3M5QC2aEeyq/agAT2xw1VhZplz0hJ0rsunKMTX0gEPW0yR7X8Xs8qNzmkEtMy/PDFUMqLgGlZX0Tmkx8s0wyv/3s2bu3VidDZKkHzqaJGFEg5A8AQ9XiBitn6D3liaPL5nRv220bMpqkJoFY5VpdoJZkvz05Dbd0MVd7sYS2DpFspA1VcDoj0ymdLhG4BzUaYroEs5aegtdQ8KWHxvApYsslFttAWcDzFsgMokzfQXQZ1F2LPjaQ4f8w2Ec/jBZlll2vT34Fym+gkP5bIGGswDqPQ26duoevm6v0lX+xE2usZOcECjGkPKWmMpn3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8925.eurprd04.prod.outlook.com (2603:10a6:102:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 21 Feb
 2025 21:16:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:16:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 21 Feb 2025 16:15:58 -0500
Subject: [PATCH v4 2/4] arm64: dts: imx95: Add #io-channel-cells = <1> for
 adc node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-imx95_15x15-v4-2-385ee8e03dfd@nxp.com>
References: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
In-Reply-To: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740172577; l=659;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gv9LRA/tkyiG97rIW6rStvqxfOn31iaYPYWkS2z5LZQ=;
 b=l8bQEclwIHrThGYA4NJwRN/QWHeYtNIiOd2sdhmVPD4J3FUyqbK8ZjEurDf9oVWkI5ogs9cF6
 fwNxdIkXjsWBwKJ6WZ5JvgC2Guyy2ybo+arfP9ZvbSbeAXJdNrcFlRl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: d98481e9-c361-4347-06bf-08dd52bd00ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUphSUo1MW4veE42Tk5VcU15eWo1ZG9HZ2d0NmFzUCtWVHo5eDM3UXZNOXAr?=
 =?utf-8?B?MVhFZXRCeSsycitKeWc1K1QvWHRNWTg4Z05WNnJUSXpqcnEvTWxXaVVrMEpz?=
 =?utf-8?B?U1hWaERMK05CYVBnb2VPQ29YMFlpSXZ6MEswMU9HY3FESHBjMmJhR0ZVM3g2?=
 =?utf-8?B?RUQ0Z3VheTFuTkFDWWJ0ZXE2ZEtMTWNxVGdjWjVBWFR3dTNTS2ZQODlnSnhM?=
 =?utf-8?B?ZWNoRkxMYm9XNkRqcm9GeG9tRnFQWWltZ1JQcndPYXVaV3VZWXNNZXpsWmNI?=
 =?utf-8?B?MjV6bmlkM2c5ZFM0MGh5SmVEWUd3L2gra0ZKK2hRNzcyelV0SUtkY2pveUNM?=
 =?utf-8?B?VS9Vd3JodHkveXlQLzN0em1STmlrdUZHUmhnSG9JL2w5aXdTMEVNVjU4NzM5?=
 =?utf-8?B?SHUyVUs1K0JDc2ZLSlNFakJqZWZob3JvK0FOak5wOExGY0JaZTd6K21zL1FZ?=
 =?utf-8?B?dVVCUXJRcUVqaUFZSnpITVJBZ1dFS0VEai9pSFlpUHNENVZMWEc1dkdvMXk3?=
 =?utf-8?B?SldYZTFjTWtoZWtaNVBjVFVQbXZ0SGtCOXZHOElpYUNqYW1nZlNUb0RFcUFt?=
 =?utf-8?B?NHI0cGdjOElkWitWa2lSWTZBVEFqdW5wUVliMUJEYUJmb1NTYXp6cHNIcm5m?=
 =?utf-8?B?VnFkT056NWlQUTk2OUNUbDc5ejYzSHhXQk8xNmZXTzdoZTM2RExHWkNUdmVw?=
 =?utf-8?B?dHk1M1UraDg1dlVJblJBWkpLNm5tdlFOMytad2dEUWh6aVphbHBYNFBOa2lz?=
 =?utf-8?B?ZmIvRmpsZDhlQUsvRlRGalBsdm9vTnFmMDV6VXgwbjRUdWtyMmFpUEdzcitk?=
 =?utf-8?B?MTlVd1R0NVovR25hempKKzlyNmRWNDZKbU5YMjdyWk5WUmp2T0U0WEV1aDRY?=
 =?utf-8?B?WnIySlJQaVdseXN4M3huaFRlV096SUJRbGVpR0hpT1FUZjRzQ0kwN2hqcHZ0?=
 =?utf-8?B?S0FmMURWWFdtQVNMMVdQa3dicEdSNXl5U1cwaGpvSXB0YUpxdmJsWGFtU1lN?=
 =?utf-8?B?QXlIWGlhRk9qcGV5TExsTU90MXVWU255QlN1SHlBOERXVnEwVWx0Y0FJd0JK?=
 =?utf-8?B?Y2ZmNGFkaXZJT3BLYW1Sbk1DNzQzY1BDUERsY0lTRFkvdTV4eFNNd0Rhd3Vt?=
 =?utf-8?B?UCtxUjdmcmpBc1JEQXFEclZ5Z1pHZUJUZFRHdVc4K25RNE1NTGNtRjlEaUJj?=
 =?utf-8?B?Y2lta2Q3c2xvOG0wK2hHOXFaL3pyTjFUbjJ4UU1wdGExVVNWdjJlWXk3NkQ5?=
 =?utf-8?B?c2UzNjk3d09aNngwYW1OZmJES3NXV01ORThNQ0JxWGI2ZmFSQzFia3pZT0NZ?=
 =?utf-8?B?QU80dGw1SXl0WDVHMVZGZ3N5NXFJdTRhWENrVDFVUGhQdkVlK3dIRDJmNUVo?=
 =?utf-8?B?dmdRdjI3eFUyWGpvVmRVWHJkeGpBRFBuV3NmeXhsS2dMRkRSSzVaVnVMdnZv?=
 =?utf-8?B?cnV2dEpzNFdqanMyclUxdk5zSlB5aGR3YWU3SG1TWUNkRFNGMU9XdFlnem5n?=
 =?utf-8?B?eEZvbWhSc2JYVnlPaTFVUDBSbzdLWDQyVDk3RzVOWTdIKys2SkdTVkl2T296?=
 =?utf-8?B?UFJEdXdyQ1pkQXlYUnpLSktYOTNPR1ZTK05vSnZHMmk4ZmZ1VWtFN2ZFVlpK?=
 =?utf-8?B?TGVEY1o5QnNqVXI5ZU4ySVZ6NHY2SUFnd2JYV3BzQ2t6TlZscU82eTM3aldq?=
 =?utf-8?B?c3N0U0tlRlV0RXNKdDFPMkNYWGpRTGhhUUhkK2cwc2JQSFZsV3kxcFhqeTdV?=
 =?utf-8?B?SE1CMk9QbUNXSjNDUEF5Y3RpdXdBdGY1bHhHaHA5am8wNUNmOU15c1hZSW90?=
 =?utf-8?B?SG9pUWZzQ0dGRmI3VER2S0xKVmpNdjU3aGZ6TlBqMndTUWJ3ZWY3U09pQ2tl?=
 =?utf-8?B?K0NpQ1hObEpzS3p6Ty94VUFiYXFPc3ljRFNkeUZ5ZnFuK1gyeUR0VGltRTZR?=
 =?utf-8?Q?x9mUESNSjwS9rM/DowJggqxu6e+vGPw9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDVWNkQwVFlBeTBOWE1NU05MRERvS3JEQTl0TWJ2clhYaWJhMytNMHEwRzNP?=
 =?utf-8?B?WEdMT3lhZ3pIRkpPZHcrQksxOTQrYjY3MDZxKzFJTGh6Z2tqL2VRQVA2M28v?=
 =?utf-8?B?Q3VSTU5tWk96T1JNSmVwRGdMR0NpSVpFd2FEQXZhSkd1RE1tWnFoL1licDNv?=
 =?utf-8?B?ZXRiaTBUVHVyamg4cjU1aDlwcDF0NEVXbXY3cm9OU2Z4QjZSU0Z2dlVXNVJM?=
 =?utf-8?B?WHNkN1I0VS9UcVNHOHhBM01oeFpuTkpNYUhiWTFuSFZBcW5YV0RTL0FkNFZY?=
 =?utf-8?B?UnRnYTNIVFQrTWIxaDRWRjhYZlFEZlQzVUdvUkROU2dYWVZBYUdOdWw3NlpP?=
 =?utf-8?B?dzlpSWd4NzIyMks4YW5QRXgxMnlFbk1rbjJRQ0JuN2ZENzNUYzgyUXVKSXlT?=
 =?utf-8?B?WkV0VDh5eHQvdjBLWkJCU3FOTnFtYnR0aGRoRUQ0c25iWFpZUC9wK0NMbU9E?=
 =?utf-8?B?UkRoZndMNnR0OWF0YWU0cHhWRVBqUjNuQU4yV09wK0dpMEUrbGJsRUZXU3hn?=
 =?utf-8?B?bXY1K1ZkNFlBSFNWODJyeFdxenMwZTREMmk4YjA4Rlp4K2xNNXlQN3dWaUJo?=
 =?utf-8?B?cmlTanpZRHVFcXZ6TlVrREZvRW5LY0JCNTNqaDhza09yVkdJQVdQaTBjZnJF?=
 =?utf-8?B?SEs1Z2xJVXRtNDBDUVhMWVhuSUtld3pNZ1dadDN5cDVXTXRKQk04UUVHUnhC?=
 =?utf-8?B?Z3EvQ0JIYTdSeFdvdTB3RVZDbE1TTTUwV0hDSjM0UFJISVlBaDM4RkdBaDdm?=
 =?utf-8?B?bjF2SlFWRWdSQ3ZRZk0yVStXQklxd3pEYkF2TVdIcndXRHRrWFk4Mi9RRCtu?=
 =?utf-8?B?V0VnblpucXFYT1lkNm9RaXlJcWNkanNObWJqOXFkUkRmVmhLSXlPZUw2UlFL?=
 =?utf-8?B?dll4c3pMYjVOQUxmS0VEbHgrYWMxcTFBQjFHdUROMFRvZkNtcGgydHF0bWcy?=
 =?utf-8?B?ekpBM2Y2QnZSdUZLVHYrK3FEdlh5azExT0piTnhReENyYjZDZmlEMCtaQUlx?=
 =?utf-8?B?SCtJeUFFZWdBcytuc0prS2tNV0NDYVVSS1lUbGZOL1N1YjZkMWtCdTJlOHNC?=
 =?utf-8?B?Z2pyMTkzQjRyeExESXZXRXdoU1g4VWlKdGkxeHgzZ0pxV1R0b2VyVjNuK01m?=
 =?utf-8?B?R3JGQnBVaDRaMXJxV3NLQmFrR2lGQVNpWVp0RHFyY1czYWxPcFcxLzk3dFdU?=
 =?utf-8?B?VTkxdmVmWEk3OUR0WmhqdDBhL3p1Ukdma3ZNdGJjUFhLRnlsTWR0UzJDNVlT?=
 =?utf-8?B?U3pPTUZKUWFVTHZFWmlHL09BTnJpVnZrL21vRU1NaHNVVGxRSkgyTkpMVVdW?=
 =?utf-8?B?M0NueHlPaUZTWFd4VXRmMWoyQ0ZpWXlNY2djNEhBcmhvRE5aSFhFcldZeXJC?=
 =?utf-8?B?YXZvQ0orNDhNNlJNYUJ2WFA4MVZtNUtuMEpnZzluazFBWGlHcU1QUEpHQys1?=
 =?utf-8?B?VFRXN2dSNDhDejB3RmZQNEJaWCs5MHV5RmI5TFp1MXNlOU1jZkhuQkJQSFQ3?=
 =?utf-8?B?L3Z1SHZQR3BOa0VnT2l2M1hmdGpYR3p4aEVKaXNkYTJhYjhsb0h3OWN1OG5L?=
 =?utf-8?B?RW1ZQzMrQnVXL3VKbE9sUHJJMFNVaHk0c2UzVXRXK0VDQklaV0QwcWlrOUF5?=
 =?utf-8?B?TWpuTzhLbDg2RWFmcXhuL1dzazdsL0dlTmliQVFGRlQ0SFMwaGVNMTRYVGox?=
 =?utf-8?B?d1ZlK1lIWENtdGg0WlRmUkhMMGdZTWNxZTNiNXVjUHA2d2lIV3lYckRETzhG?=
 =?utf-8?B?NFFESXlmU1Z3YkRKU3M3dGNqKzUxeHBoQmJ4Z2F5VVVnYlFvMXJTQ1QwTDFW?=
 =?utf-8?B?TFNlcnJ5WG1FcVloVWx1N3I0dGVwLzhiR0s1MjJPYy9rcVVIMDJBOG1PdW5S?=
 =?utf-8?B?aVlDMWJpeVpCYjFTa21Bdzd2UURDSWdKVEdDWk9xd05jQUFCdmhWYzdQRlcz?=
 =?utf-8?B?ZUovUTVqek4wSEE0NTY1cUE1WWJ5M1lsRzZ4bmM2ZEhFL1cwMnRxTDRObCsv?=
 =?utf-8?B?Z1RXRmh2d2tWWjNFbjdqWjgybktzRlJZSDFTQm9tTnp5SkZHSjVZMVB5UWd2?=
 =?utf-8?B?bDQ3eWZMY29HNHF5aUxLK1pFTEJkZXFEcjI3bGgxb0JSdFltREtGOEhrc3Y1?=
 =?utf-8?Q?rCtDSTlB5DVME2UM0HcGYu053?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98481e9-c361-4347-06bf-08dd52bd00ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:16:27.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPdyXkMDHS/76aQbm1kATUJSfKgoUn7vpRzIeT5R2qhknTfSzkYJ9e8MefXBVX1xUhJbrirVtPEmhlyrgWV0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8925

Add #io-channel-cells = <1> for adc node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 0b64a1df3c7a6..ce4c0aa70a07f 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1379,6 +1379,7 @@ adc1: adc@44530000 {
 					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_ADC>;
 				clock-names = "ipg";
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 

-- 
2.34.1


