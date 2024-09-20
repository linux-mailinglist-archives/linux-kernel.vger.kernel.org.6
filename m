Return-Path: <linux-kernel+bounces-334134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE897D2F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68E4282E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4412EBEA;
	Fri, 20 Sep 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oHjbftqh"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F6139D13;
	Fri, 20 Sep 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821937; cv=fail; b=KEl+6uCMfR2MUoweII7nQGhoNjIue2oQYZUtXfZ8fEpp2jUHlYZeKJhclMQXzN3TOxLdnRtD5FnqgT9q3KCmBfieEKaDPbQfJQZGwukKIOOk7JNdK9817TXsjbJtFCpt3k3ohgYm4tqA7BfIVYnvJoTOeaW+nQyxwIejG0ZmV90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821937; c=relaxed/simple;
	bh=s2ZiYErCl3IlcDlwNOVXaL3859izhhwXElqPKZuKEIg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UpAvNDkPfmP0DKqs4CzuIOE7Xu0SSKbdVx1IQRs+rU8UISpVdNMtzdQL9jL7vxgTGnn9ktBbhVzcM15q2Vc7As6o7SZOPRcHNu2SX+llIIRHopR9sWyga2CFGVpcTwZ4j0KzGwlbAyr170iKDrAjPvXQjBtdW6O8af/B/4AS0yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oHjbftqh; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWNIblSmNE2SCTlPNIpOvySE/j71dFl8M967VZuOXYiZyEmwi1hU6r4eTlq+NXkLHyztO4+6Exerw8bziXRUdzjnRTTWIEsjtns2my4iAp4/ROemztKRh+d1tqNd16MdANbh4B2TIzsN6YsjV/+cHUlkrb8NK1/cdwoPgn3fVujmQGRtjoZ8w8HjdZp8+Zlq0M8X5Y3dqwomp0D2BCdc/++80EUN+A7Y+tsukNKi4j3biYLmHAs87PPQjRdP/L8ZV+MlYk0STOwTkq9KKmL+YiQXX/A3HYnk3t8pFhAzb8DS3FupEejp2HmqrKTJ6BDoFPasVvhf9UtnQD9fS6ThVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKT+WjcRy2Jdf9Ju7fmeJI7MqkqP2sH/kdhJMlZ4Jsw=;
 b=L1frqQzXdwIkzO4tbpImzc7Ws8urNmAY0jJZ+z2jWXj1eWUTWjOk7jKqxjs3WplPT+VtKRYG6K+8M0Wq8Zl/o+tvEIPlEJPzL5YuAY7txpAViuATYc/zFW0QrtkKJ57DirWRrXnGaSSx+Q59tyygybs6rnDSUuO6o7rr2Jp0AxmLSUPkpXYw9+KyjxiPGrBBvzg8ZnNVAdI3VzuVZmF3EFNykIyINAT6D41P9KanRgtBfQ/3J4bJQW5ah+PukrY3idCHC5K7kv4CwJx+9w+r8PEDpWaJS2RQLpYwP2ZWsMdq9qEEUTvOy2j+3cIlDEJ8m0ckQ47J11dllHevHUMUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKT+WjcRy2Jdf9Ju7fmeJI7MqkqP2sH/kdhJMlZ4Jsw=;
 b=oHjbftqhRlrwPD6tRJUqdJClA9aSX+F5C96flMvQheSWmI7xl6XyaLSLf6xGclM2gWfmr+HsTmv4U/Dn7PcwlW69f0nNZqyxjrh7yZES6re2M4TaiEwvKdHIgEwxwtK1du3AwfjJrIOM/zYg/4W3+RhjannMGDr7IBgNexUaeAOvi9dz/0deARHosB2XZlwdTJm9mu2aW6pRThKFPYRoAPQ70zOtUft94IeoVbkcWVUppmFBnTacPFQ035p/5vzWaMUza38WabzKbwJKbvU3a7e+6ua4BbKngYxOKgVP6bnNZTXMG7dMCcuoq9Z4W+XNw1F8JY19aWFAN6L1nvFjdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 08:45:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 08:45:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 20 Sep 2024 16:54:07 +0800
Subject: [PATCH 2/3] mtd: spi-nor: support vcc-supply regulator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-spi-v1-2-97f220c2e10c@nxp.com>
References: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
In-Reply-To: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726822454; l=1012;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=3PKCZ8dMAK7a/VbQbbFq/RL7XYZ1/SiYfBLf6uYUjBc=;
 b=e/bcw0WOzkxxJnJofth9F7KBbBqUL2V3ptQz/kmqt4yClw2HvJB7vXAhmYZZ5AxNnIsXAAZcL
 oTehqf1YfmXCncQIg8zZEkUu44KYg8GvfpKmNon3JOOcrgwL9Bx7O+i
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f76eaa-cb89-4484-fa66-08dcd9509671
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TExLOE5zMEEyNHpxbDVSamt4alptRHR3L2hLeXNEeUlQYmFXVnZYa3MzWkNR?=
 =?utf-8?B?czRFL1hWYVdZdW1ua2NERmswSkxsWXF3MU8vdWFDUTVQd0NHb1hJVGViNS92?=
 =?utf-8?B?d3hQZ2VUS3kyaElYRlVlZk52QytyQ0ZKQ3drN0xuaUtOWHFoV1ZGd2pFbVlR?=
 =?utf-8?B?UHdNOTZDR1k3aW85bjcxellZQll5enZ4YjI5SGJBeVNhTU9GK2JFTkhLdTZF?=
 =?utf-8?B?Q2pMUHpVQzBtdVNzcmU3elNNWUxMRk9HMHBVOGErUUpZNTNTK2Z6eHJkaEFI?=
 =?utf-8?B?SUs2ZW1zaTBFc2NreEloTU5RSHB4Uy9yRFVNQjl6YjR2Vm82Qkp0d2NZcFVs?=
 =?utf-8?B?ZkNlRlgwRnFuaHBmTS9DZ3A0SWdGdyt3RFBHYkJpSFc0eW1Xem9ydnF4N09V?=
 =?utf-8?B?dTV3aHlRSVlXbjBXNUlXV0RsYm0ydnBNdXNHSkpiUjFMUXZqRlU5SlFydkVT?=
 =?utf-8?B?akNZZnphSUg0VG5ORFJyc1pSYWJBd1NLVEZ3eFc2Q2MyY3F4T3ZqZVR6a2pL?=
 =?utf-8?B?YnVmeHVmRTBROGJuT21aUXN1bGlUUGIvaHorVjhxUEJUNkhJWERiSDh2TmtJ?=
 =?utf-8?B?QlhFZFZUcUdqaFRhbXZvSVdCS0FXLzkxUjBmRjYyRUdPSXJtYkNzK3FvcGVG?=
 =?utf-8?B?WTNiR3VHeTR0eVphVW9YNHVzMk5VTHZZVzBsUVNQL0Q4UkNmUXhTOUtKd2s0?=
 =?utf-8?B?dEZEa2s3ZE1NNURXTnZUTTJURFFhN2RmcUNLanFZdE9la1ZKR21VT3pQWXpL?=
 =?utf-8?B?MmI3aGp2VWVCamprUXd3Nk14S2FPcDdtdnB6R0ZhNU93MTVDOWVLZC9Uc05q?=
 =?utf-8?B?ZlhPbnhsN2tCWkc5cmQ1d3ZhZy9aY0Y2NWx6TEFpL2RVb2ZKdGFrZURrTy9O?=
 =?utf-8?B?NzM4dm8yUW42NjlWODRoWDA4RDJhOXNxSE16Q29HZmJtaHYxTkxuaGZzMzQ4?=
 =?utf-8?B?MElBN1JyT1R6YStrS3NsMk9nZjBLNGVmQWhQaEdDY2hWWStwRUl5V1ZkWXZ6?=
 =?utf-8?B?MzNvQXRpaXhyNkpBSms4aENPWmFBUW1ZSGlQdXZGenZCdVNYTjQ2d2o3Z0xR?=
 =?utf-8?B?SzlOMHg4WXg1ZW9zTkJadSt4TVFYcFV5QnVZSUZBUlVSUXNDMGU2OXIrU21B?=
 =?utf-8?B?R3M5RzUycDdZOUM0eDF4dU0yOHBNTHplZ3A0K1AwZGM0bGN6VjAvVHV2emls?=
 =?utf-8?B?Zy9YaDNnM1VLT1ZNMnlRVTZHMi9KZkV0djM2VzB2ZlQ1N0RPTEpLbG9nNHNY?=
 =?utf-8?B?aFhiSGdEbjFkWC9LR0FKNllzc0ZQQWV2RGt4YjhUcjdoN2ZPd0oyZ2UrdWlW?=
 =?utf-8?B?aXFiUS9JOWZYODhFSmY2UXBacERTSXV0czVVRjZHZ2w4S3RkNVhONkU2OU5p?=
 =?utf-8?B?UUZ0cENZeFlOckFEeCsrQ0tINmJCWVdWMkdjTWhBQVVqL2U0cWRpenlzQWVH?=
 =?utf-8?B?b3JKV3dqRFBuY1UvanN4RCs4SjQvcHFaVmk4cUlSeTl4ZmtCYTBuMXhEQWpW?=
 =?utf-8?B?bmdUcVJmMVFHaDVQMDBIVTR0NmRlMHRYQ2djMXAwWjB4UHRTaUxyN2hqazV5?=
 =?utf-8?B?NUR5T3FCaFhnWEpBSXREVk5NRlF2UkNLOXQ3NW9BSGUra1hmWWx0M3RFTE5s?=
 =?utf-8?B?N3oxb1hwZmM0VlovZTFCLzJja2ZGWENkaWhaaWpUT3krWUduN0dMaVBVQjVD?=
 =?utf-8?B?UXFRSmMwcnRpazYrSzRLTlQ5M1Zxank2T2xSRzRMUG9relBpby9sMWJWT2p2?=
 =?utf-8?B?Y0xFckZCTllLS1RjcWE0RmNSL0RmRzh5cmtVSkQ2R1ozWmMvUkNLTkgyb3Jn?=
 =?utf-8?B?ZUkxeTNKbWhQUVNGRVR5cFVENW9POVJEQUR0TUlaaUZ1YmFXMDRVQXVoMm9r?=
 =?utf-8?B?Mk56VEZueUxmTkhQUkVReU5zZzRjV2lBY2crLzVSWjAvQWl5UkxSRGNRZTBU?=
 =?utf-8?Q?cObapsiA8Io=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2c0Wjd5YlIwUlByUE9mLzBnelJ4dlgreEM0QUhlejJxQWorL2tkYzlqV2t1?=
 =?utf-8?B?L0RnQkR6UDVjbTRWSUoxRUhpbWZwOUpPYlg2Vm4yUm45SDVuNmRodFlHU2VM?=
 =?utf-8?B?aDE4aXZLaG5qTk9XNmdwNzhiWVVLOGNoZ2hyZVIwSFhZTDFsSFN0SDJJUmVU?=
 =?utf-8?B?WE54UWEvV2V6L29aWElGcGoyRmRNK3ZCOC82UHJNb0lVdXNCYkhXODdQenQ5?=
 =?utf-8?B?Slp0L2JWUTYxZEt4aWh3U2ZiVGRFOUdPKy9RVkIycWNOWHJCRmdHdEJoakht?=
 =?utf-8?B?Q29jNmVXcmRBb0RYM3pPU3QxS2hqYXJMNVIwc2oxOGd4eEdBR1BRem00ODJF?=
 =?utf-8?B?V2Fka0FLTVlrOGZzL1pIeWtRYnpJcm9wYWdPWDRib3FNUXB2SzVwR0ZXU2M2?=
 =?utf-8?B?T0x0ZDZrNDE5MjIxby9vSWovMUlRRDZvVU1Qb0VObVRqSmF5cloySnJjaWhy?=
 =?utf-8?B?Vkhna1lreitydEZiV1pZamk5Zm9MSVdoWHVOQ0Y4Z2IyMExqVmF5UmZRSXlD?=
 =?utf-8?B?NjVSYlExdXhpWFFXSWRtMDlndmFwaktRNkJzQVEvR2xrU2NPS3RTcW1VSzl5?=
 =?utf-8?B?elAyMlFsT1Z6T0FOVUtjYUZ5NDB6OXB6NkFVb2N3Q3VHM001YldoLzk0Z1l6?=
 =?utf-8?B?czNaTTJxS05tSkFOWWMvYlRKZEY0RFRib3V0YVlqUWhpMFRIempiWXJMcG9z?=
 =?utf-8?B?ekVYMFlwUU9lMTI0Ry9QQ1ZmWUR4TGRyd1htaTc3cnBFSjl6KzErakQycWRo?=
 =?utf-8?B?NE9qeEROdTdSSW1sNFBHS3pYZktTeUl3M3V6NG15VHBBRmlDVGV5QTY5Q3Q4?=
 =?utf-8?B?eGpmRDFIWmI1T1lUbFlseE9mN2JTY3Q4eERwRXZwWjhnclJWWTBUNi9jOVpX?=
 =?utf-8?B?WEI0bUMyd2YyRWs5SlN5K3pSY1p2THpRRG9SemFxN1FuWndmZjdDaWtwTk9n?=
 =?utf-8?B?U2FiSExuczBRWDVVQ3BwZEdZOEl4UitKRlMrR09ycGFEdTFLQ2h2OUNSam40?=
 =?utf-8?B?NXJwMUFGbmpWK1NGd1JKQnUyYjE3a1p6cEVjZHNvelNMWUJqbUFrZm1DSktn?=
 =?utf-8?B?S3lwcDRYcVRNa0RWS1lRVk1HY29EbCsvSktObVNlM3F3U0lMb2hTYk8wckUv?=
 =?utf-8?B?NWIwUFlWNGxUZ29MbnIyVEhCMU5TWWZjS1hRTWtoeEVDZ09hY1RoMVUxSXVs?=
 =?utf-8?B?b2MxbnJReFhlY2hDVUNxZmhNUzk2YktVTzk2RE4wbEkybWJHVWFOMTVqcXR4?=
 =?utf-8?B?akVTeTd3bFdCdmwvMmM4Z3BTWHdBakx6L21XZlRZSjFRajI3a2tVUE9rZUhs?=
 =?utf-8?B?aXJ2Mm1wNXBCQW5ocTZFeFMzdnFwdVNvaUFjRXA0d0RtM0daRVdVZm9OVXVa?=
 =?utf-8?B?cjE1a2dHaWhvQXZLVEM2cDc1dW1OM2tFRkt3eW13SU1qZWxaeHJpTmc1SlVi?=
 =?utf-8?B?VS9KTmw2a2E3dGk0WFRYdEZKZWhpWlR4ZEZQYlZpTmxwb1FLMXlZQnJDaEZQ?=
 =?utf-8?B?MGN5T0EvRW82ZWFJcjRpTDlOaTJCRDJacTRGMHBWVm96VEwvL1g0bEM3MnZn?=
 =?utf-8?B?RUk3UktLNlpoblgrNG5UckFUeFhCeVppRWgrbHk3VEI4VHl2eVhMTUZhdXlH?=
 =?utf-8?B?M24wR1JaVFVWQ2VpS1ZjQVJlbFdURHE3Zk1UZldRL1J1RThHQ1d1c0N2TnRa?=
 =?utf-8?B?ZlhQeGxYcHAyWmhveklQK2lXWC9DdWxQZ2RqS1psbS84Z0ZEdDZFM3hwc25m?=
 =?utf-8?B?eCtjSmJtbmFaKzhOd1JWcjVENk4rWTV0ZG9SM1hNOFdTUFZPQk9GZXFmZ2s4?=
 =?utf-8?B?WlVsa0QwWXd0YXFtN0FzeWIwWFRVRDFiczFQcS94TGJvYXZ0ViszZERFNzQw?=
 =?utf-8?B?SWlLazRhZ0phZzdaY1pIN2xLckRPVkh0MDRYY25QVXIyM2EzSFIzRkZIMmcz?=
 =?utf-8?B?cTIzR1QyR0tCRGNBN1NoRFVQVEdYa2g5VTFKQjlxWTBQSFprKzV4L0FSb0s4?=
 =?utf-8?B?dzRob3RlaVA1SS83aERCa2FVYy9aWmc1WlpHQXVGeGJneithakVWVXM2VTNw?=
 =?utf-8?B?S2JLb1ovTnJSaTNqczFJcVRlRUJDdUNnTG4rRnlRb0dzaTJ3eUpONU4vRE1w?=
 =?utf-8?Q?5yKMH6+EmlVeJXCw9At7BX5kV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f76eaa-cb89-4484-fa66-08dcd9509671
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:45:32.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovfh/QOdorPtvcQrDEyBLbnQ59U3PSAHNQcxeyrf4vgirdHRuEgYsk74uT37srSrO+876l+bwvVAxO6sGooTbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

From: Peng Fan <peng.fan@nxp.com>

spi nor flash needs power supply to work properly. The power supply
maybe software controllable per board design. So add the support
for an optional vcc-supply regulator.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mtd/spi-nor/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9d6e85bf227b..0449afe6bb20 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -3462,6 +3463,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (!nor->bouncebuf)
 		return -ENOMEM;
 
+	ret = devm_regulator_get_enable_optional(dev, "vcc");
+	if (ret)
+		return ret;
+
 	ret = spi_nor_hw_reset(nor);
 	if (ret)
 		return ret;

-- 
2.37.1


