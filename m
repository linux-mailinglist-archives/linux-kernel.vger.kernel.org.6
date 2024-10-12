Return-Path: <linux-kernel+bounces-362301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2D99B34D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFCE0B21A19
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC521714A1;
	Sat, 12 Oct 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xb2b5Dah"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236F16C6A7;
	Sat, 12 Oct 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731446; cv=fail; b=FZP8NX1o9DNl9ZjDYaTxznbljdVQYJ0iju7PRyCqXy6h2M7w8K1G+oBBnm2LMexficTEy4GsnGJyyjZ8PQZzS9BY6L0ObPOg25ItIOkfRXRL+r+gIcinr5f4MiaYELSIWHo3ILOuGh/kIHYdu2p5bMX3wBgnTqVlh+nSd683BDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731446; c=relaxed/simple;
	bh=mauEtqs1n7HZklBhkQ9tT+fY9iRxMk+Dv4io/A4lcNY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pPd1eeZ2mL5YiXq6D9CminqeQmLM/VHNY4Kt/E6acnLJH5k3N3O5IjB5cucv145ws5l6JBuLOp30CJ0HEifaj1fBB7kUBthvd/yB4WBJK2jYPFednDbDtmtEE/Ub6qQDHdJudMHlMTSCbijUQhhllSK+JjJihcWWmtey2bQUqf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xb2b5Dah; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSRL+2gUIWgs34Z3xO8hqMMSocX5/Z+8XFzYwq9rghiisgkyMi5B3Uyv6dM6jGtiVno7V1evu1k60xeWl95gcL17i87Whg364tCsks27Jf45Q/hH4SKT3Cn9FdhZvkwHIta/bXTkO8ERPgx0fi6eHXjYcUDGaWuL3BCQjzdwF+ITSY0KMIg4TW6upFuYM6KOzI275cx+MlEgqSGNeqllEm8eTw/4eRxjeNV6ucIaVrKKZjMxb1ocnlMfR+sP45uFettn6AYuDAnYSRCapkZbqRvnKN6LybK87bCqOoSUNHigYn7zqGWVZmTv6QfjOyTp6TGtAQG83muNcVbEiEGHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgerJK8kpH0xyEqHbSiwh5x5tvgpGYMaX4QrWh+hMOE=;
 b=AhhNpge0bor2Q962J0dFy72NP2SIgZRnQOJTZA732HjHNSV1jom6/3aYo4vdvfK21gJV7N1qtrpc2anOsOFppxlz7KhjMwv9GHrTQ/GzXd+MX75amkiVhT+K+rVt7Fc9+XtxRqNHxxmzgifT5S1QWyjoPXfg1xmgKQA1FnncvsHCys+QQr7KfY2gf9UbA9LpNoxEKwgFUvJw0Uw9UUzba+KJOPlPWeTEsY6Eccx12kifZH+X8h4LxhxY8cv2yU+ZiNUSy0rLvmmxJ9OFDUrCXRH+8x3k9cKMsJye7Qp5PtNxPh72SNFSXvPMdbxn7aC1VuBM8XMiVQX/p5OOKXbCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgerJK8kpH0xyEqHbSiwh5x5tvgpGYMaX4QrWh+hMOE=;
 b=xb2b5Dahz7yCmcvMy7aqYVh9CthL4+Ccm8IjS0qcy/oDmI4zblerzxmktcpddaCyMHqbKcMHi9BkHvDZMQI7G5/VJd9MU6GeY8ZOLstgH7I5iox8D4SzF57WG6FoaE9sc0bwoCb5zwfyOpqj1T1V7cGOCRYk0oOvflj1DTEqXa0DzGqNKXSP4qypoGInToMr54Geg6oDzMofB8pKdRQ9YevCHHwPPPg8YWF18Cn1ShoBxDNYrUCNidr/WVeEBIvvKpK3ZWt0GnPdGJswPbSlkZLNdnCWbWJc+b6OkGGMWswg6LlTNXUYfVoRSRfRrOlM23RnKmqoyrJZ7tfVeQcAXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 12 Oct 2024 19:19:09 +0800
Subject: [PATCH v3 2/7] arm64: dts: imx95: add bbm/misc/syspower scmi nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-imx95-dts-new-v3-2-edfab0054c71@nxp.com>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=1034;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7SaZFASU6xZDGf1b8So+mf7keRr/hphZHQOC2kFeXAQ=;
 b=aPp1HpFYe6iBqrolo7Nz2qNmSUtJZ2vpoMeIBRk+rbEk1rAlhqZRq1/53ifpdtitemt60Wx5P
 6yimzXHszsQBjnIkWbjx+HRwvNfXRpXu77kQ4xn7GnphY2FQMYfRmC2
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
X-MS-Office365-Filtering-Correlation-Id: 16610dab-a6dd-4ba2-ccbe-08dceaae8273
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXYwcmdnY1NSTm1nWUwvcE9pNGNMV002Z2JGelFRUnp6RmpaakM1Y1VRcGhn?=
 =?utf-8?B?d0x6TDFXRk1QcWwzUVJVWjFuZFI2YnV5SFNjSGV1Q0dOSWllc203MjZCUjhG?=
 =?utf-8?B?TmJnZXdGcWhCWnN1aCtuRlB0YUZGU1JUTytiNlB2SllkYjNXOXhYN1dzNTZX?=
 =?utf-8?B?N1MwNUFnMzlRV2hic3hsS2FxVUVCU2p4a3dEUWxPOFJBQkRESGFUNHh5Qndz?=
 =?utf-8?B?bHZvbmo1aktUMm5OckY3V1dydWxRM2VHLzZ3TFJHRE1nQkpUQUFNejNqWE9p?=
 =?utf-8?B?V2R6UFQ3aXBNMmFtc3JLbXFnbGIrbW1oekloanJCM2pETS9kQjYxeDM1d1hr?=
 =?utf-8?B?cDdkcUZ4dkVEblI0Nnk1Um9HTFY4ZHc3Ym05NGxtWXNvR1Q4RGlWbEEvdUU0?=
 =?utf-8?B?Q3BuT0ZrUEhaUkJKWlU2MVNYSHF1WjI2ZXRjZFVoZmhhcHpGR214S3ZHSDBz?=
 =?utf-8?B?WjBpMnlWUTdTYWNCNC85N28ydmIzc01nTzRjNm00WktIcUlrWGd6MWplZWJE?=
 =?utf-8?B?QWlYNmNrNGg2KzhBR3FtWGwvSTAzdXF5dVhNcVFTTDBPUXVUOUdwYUNuYyto?=
 =?utf-8?B?VFBiV3dOaUtmVlNBMVdSa2YrNWlxK21pYXhJV1Y2eEpReWp4MUd3SVJtUTRu?=
 =?utf-8?B?bTMxdHZFMFhReTdBbnNuOE5XWGgwRU1tVnJxMlhjdVFHa0tIK21wa3FYSXE4?=
 =?utf-8?B?S2JtS2R3L3dWbEIvellIN2laQ3ZkME43MGVrVk9WTmF2ZTFWbVpQUjFrNGpm?=
 =?utf-8?B?d3I2N3VQV2hxREhKUWw2QnJCOHhzdVNzM3dMbFUzWHFPVTl2bURYaUN0bC9j?=
 =?utf-8?B?OUl6MlNpZ0llczREK1NtN2cxNEpmTUxpekF6Zy9RWkUyTU9peEVMZWl3ZGpN?=
 =?utf-8?B?cmpPY0FhNU9iTndpaXBDOXVuSHFrK1dzbUFkMitqN2J4M0xwQ1F1Y0l1aStG?=
 =?utf-8?B?U2FPVGY5YmtFNEtTSVRjaFViYUdad0ZTalN1SHNDTU5IRkRNdmNZN1ZlUlEv?=
 =?utf-8?B?THVHRElBdW00ZUVRS0RyNzhQVVJiZWlzbG83U1haSE5aaStWSTltdW9LMVZ3?=
 =?utf-8?B?NTlKZVRvbmhDYk1GRzArMmFSNVc5Nkd3SnVINDBhd2F6Q2RVWXNvbitqajRQ?=
 =?utf-8?B?VVA3Vkg3RDBNRE1RbDQzRGQ1T0Nsc1Rid0RyT0liTGNOQVJQMTJZaUdISE5j?=
 =?utf-8?B?RVk0UGg0VjU5UlBOVGczWTFMQnhRVTcrNEtENDF1cCtYMDJwaWczdXRDZ2ZF?=
 =?utf-8?B?bHY2NkNHMUFCYjI5Q3dBT3UrM1V6N010bDRDb0tLak5BWkZmcXlXUlNpSElH?=
 =?utf-8?B?NExlaVEycVp6TlMyU1R6OU5xVWJWd1Y2Z2sxS2NiYnQ3MTBISXVBMG5SaVl4?=
 =?utf-8?B?cktHUGt5Njc5OVNyTGg4TGVSR2Yvb2pTSFRGeHRocnlsMkpQR0l6QVE1a1Jw?=
 =?utf-8?B?VDY5TGc0N3RCK3YwQVo4Q1I3NzhYSGJ3NzlEbHhzYkRicm1KeDVEOE4vREZX?=
 =?utf-8?B?YWNhUXE0dGltZVl4U2hVT2l5dEpGOGJEbFFNY2FwS2ZLNkRubVo1aDNibHR6?=
 =?utf-8?B?cVQyM0dKU2pqd0RaRjVZZXpCYnNLZllxeEpuTThJbUdjcllHWG9HVjJycklw?=
 =?utf-8?B?TENHMjRtTjNYMG9LUW1rbHpqaUV1TTc0NmdhemltVHU0OGJBcFFiZEJUeURT?=
 =?utf-8?B?OEpac0U1RlJYY1MxeWJ2cVRVNUxNM1NNbzRRdnA4RVFzRGZ5NHRaczBoYmRV?=
 =?utf-8?B?b0xFUVNwOEVncUpVKzlRMVRWWmxuM3ZBVi9GVGRnTTZzcFFiRUdxbnJLd1ZV?=
 =?utf-8?B?Y3piRGhJRFU5eXdLbExRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDFlY1BRc01hazBGUzcyWmdnUHVvR0s2dkI4V0s3T0IwTDMzczFDUFFVRElj?=
 =?utf-8?B?ckJYRWNwQnlUSUNZSTdjRFEvdVlBVjdEWVhSZzNEY3JnbnVjenNxZklFNmsz?=
 =?utf-8?B?WjVkbDdpWklWVk5iSXdjSHd5bUNDSlh3SHhZeUErc3Rpc1VoRmoxUnJKVGNy?=
 =?utf-8?B?clFVbDNiQjV3bG5LcHZabDJFN3Vsek5DYW5LR0NyZEZYd0hMZ3BlUXpLNktT?=
 =?utf-8?B?UlRYY1dVTlQySEhDNDI2RDF0TS9DcnMvZ3hYZVEwQ2xCVVdJRThaK1FqTE1x?=
 =?utf-8?B?Vm4yRW5NbzhmVkFQTlk1M2hYU3ppUUZ4VE9aeENaOXErOW9PT1dDeXpnSU0r?=
 =?utf-8?B?RHEvdzN4VEo4ZEhJVGN2dXN4a1hlTGFSVEhNblRPZ3dJV3JZNFdJM3pJQ2dW?=
 =?utf-8?B?K0dHZ2hFNHppRjZFUGNWT1JIZEhSeTlRdU5zd2xiOENkQWRLZVI0d1AzbGlG?=
 =?utf-8?B?ZEoweHREYzNwdGZCR2tvRzE2STBwbDlvNTQ0M2QwNTVMVUozZHRzU1lESWxt?=
 =?utf-8?B?a044TjA5TUpWRjJKK3R6ZVRBVjU4UUo4YlBCMnhGeDNMMnZ6WkNURDR6MGd6?=
 =?utf-8?B?eCtZU1dNYW5LSlhLR3d3VmFxN0EyS2tCRWw0Umg3dW5seGFGWDc4Q2ZOdTZs?=
 =?utf-8?B?YXFTUUN6RTNqWkU0WUpUaFR2TGVKZFBQNmhNMUZtam9KUWZwdXJTNHBiQ1cv?=
 =?utf-8?B?bTNJVVdtT1pRR1d1R2wwMFFLbVk3QytpRkhONHg2Y3V1Wk1QY3I4dnQraGJS?=
 =?utf-8?B?S0VJZkFJaktSL0pvUmg4YmZ5OHA3SExJVmlqVGphNHdvc1VMdFdPRnpGWDE5?=
 =?utf-8?B?Q0J0dlh1TkdjRU54NUZNQ3NSYlJwOE1WanBNbVoyMFJSc09BSExLTzhQdVhB?=
 =?utf-8?B?dzBBSlVtSTgxdVVNOFo1bHBXK3o5MjdsOUwxeXhUcTRXVXVHWmVYczRQMUtN?=
 =?utf-8?B?bDJ0VW5TbHlVbDBHMkovVGVva3R1dzBTbSszUW15dHhIWUtmYkd4elZLdlVU?=
 =?utf-8?B?dmEzYzlzZ3VFeWZEcFIxaExrYnppZ2VndWpxZTA2enNySHMxa2hpNkExTCtH?=
 =?utf-8?B?cGI4Y3BEd1JrY0s3cE9lNU1HZ1cyV2Y1UFZIYlZ0a0xvWTRPd2F6U0NFdHU5?=
 =?utf-8?B?UUY2anhNclRVek5nRHpFNFM0R0JPakphMWttRWFJY3YrQ1U4VjY5NEFPSTdx?=
 =?utf-8?B?OUpDd3BCWVkxdmFOUk9lMFhOZUtoOXIzTk5tZi9WWDJoSVhCYWtoeG9QQWlX?=
 =?utf-8?B?TWxtOENJaWJXYnFzL25HS2tXbkFnckhzc0NkTnJDckZsSDVySnp2Vmx6OVVn?=
 =?utf-8?B?YXhSSHc3RmtxcjNlQVhWbnJvSFpRenlNMnhEUUNPdWZ5dkpPcU14ZGJWRXhV?=
 =?utf-8?B?aDRYd2JRejBkK3BpWERzQzlpdi9KeGNhNGwyb0NYM2VNNDVtSXA4azRUZzBj?=
 =?utf-8?B?UE5CaDB0ejlDREU2Nzh4a3lqODd0WmlJZ09LaFhqSkE2bk1STDNuYzBPRmV4?=
 =?utf-8?B?Y3JlUG9XNDN5ZDdreTdPNmJNK2FOZjZOSmFVNnVNSUViVDc0c3VDcStWVTVW?=
 =?utf-8?B?ckZtTm9oMS94aFFKbzh0T0cwQ0phdHA5QTJWQ0E1SmUwVUNtVmJ4L0pyZ1Ba?=
 =?utf-8?B?L1ZJRmZmTHNmSTljWW5kd2NYajZrTEtjUnRhSUpsNjdXQmhYS0gxWEM3cjcy?=
 =?utf-8?B?UVVlNHYra0FBVFh2dUZoNEhZMXNHUTJOSHZ4TllHUFplYXVlOHRvZitPQ3ZB?=
 =?utf-8?B?bTI4aUhYc2FOYkxXK1hCUnh6bjZoR2thMVYrUG5pSHA4OHZtNlBrMlBGNmJT?=
 =?utf-8?B?MEFlc1pzTndFdXBOb1pTNVJZcG1wcUxCUmpHbXZtVERtUVVtYm5aczREUGRa?=
 =?utf-8?B?NHBJd2xHME9VdUJPbmRrNWsxb1B3ajZQWWRIakVLNmVhMXlZNTFNbXZSVnp0?=
 =?utf-8?B?VktRS0pBcUQvNGRFTXZjdW1CdGYzWUcvMmpBVytMQitGdlFYNE5pc2NKYk1B?=
 =?utf-8?B?T09pZXBoVXY5WldhdEZneU5NbGdUSmtOZHVtMnZaTm1XYVlUdFRORUxEZVJi?=
 =?utf-8?B?U1VnaFpsSXh3Yko3dG1teC9TNkFyU0tMVTFnRDlod1RqSlZnaHAzUWoxd1Z0?=
 =?utf-8?Q?NAr8XplS6R8G49mmiL84OyvU3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16610dab-a6dd-4ba2-ccbe-08dceaae8273
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:41.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm7ci6qV0ktMTDsQyWBavLi20UAkcm9HY907JqHm5PB4kczf/DrjY5V9p4H/6SmPwcq1U47dYtqsGIPVr5THdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

From: Peng Fan <peng.fan@nxp.com>

Add SYS Power, BBM and MISC nodes under SCMI firmware node.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 9c802c2344fcfb2802e5d52c762b0178a2a88ba8..7f4e7579cdb395177c28f41159df36b871a6384e 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -300,6 +300,10 @@ scmi_devpd: protocol@11 {
 				#power-domain-cells = <1>;
 			};
 
+			scmi_sys_power: protocol@12 {
+				reg = <0x12>;
+			};
+
 			scmi_perf: protocol@13 {
 				reg = <0x13>;
 				#power-domain-cells = <1>;
@@ -319,6 +323,13 @@ scmi_iomuxc: protocol@19 {
 				reg = <0x19>;
 			};
 
+			scmi_bbm: protocol@81 {
+				reg = <0x81>;
+			};
+
+			scmi_misc: protocol@84 {
+				reg = <0x84>;
+			};
 		};
 	};
 

-- 
2.37.1


