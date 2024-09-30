Return-Path: <linux-kernel+bounces-343651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BE3989DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EA81F21F20
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22618872C;
	Mon, 30 Sep 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n62MaAWm"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19CC18870E;
	Mon, 30 Sep 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687628; cv=fail; b=J7NCzAnyZsgg9lQAdMpjhZlpdip6TrrKiqpxeRl+zKIzzp4GySCVQQArdD2hISAjwTbs2NNTGF1JoW50SZwwoYRSF1X+YdT1amoh130Bh5CiFIxbqKJhKcxntR2/TlDznevQuyPSye+gw6GGq3qRRh1vYtFdF7F+pNHJ114zDPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687628; c=relaxed/simple;
	bh=PtI8014DMZnYOudcm7pF9CrJZXj1JvHbY7LS+zXVRLE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=R7aAsmJZLJMNfYZXUH55FT1s67e+cRM60uCvESocXJ1vg8L4wgLY3T0HcvQf8TYZjeQY2KYr6zJnXApMN+xGY6oTIE+UUsr5tCxyz4LRg3YO0jesCac5x/UImqqkDXkJkZKahFb9WkbhHYBe0HjUvTSJCAgBisoeLrxZ7ZT8GDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=n62MaAWm; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScPEb2RAPlFAAuOR5iOuYH7qXzKUVD8Y90D5jqXiX79qaZRae18ALkofKAQyr2Pol+D41cBGJ8W+sucCbC/1c9y2smCSAYkU5sT0VH5WuZ65KJ3xTAAuagg9DNMkdWrBic96rOIOC3HjLl7QDeljD6xlAZf4ODzHPUWMKAuoKiffZh6KRiQ9FI2c3GqsM3gKyP8p/4/1Vc5CcIqGUeBAI3W5zY8qKvsqWVNoQtJtHMcG3G7PyMCu9/VXyOfrgWh+iZoGWh7Z4U9u9LuEM6KpATa+yxhjbayMTy7HO+Gy4R+stTc3TlXAw4mJTLtB0z9uxy0HvemSf/70QSywsdJs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3tBpcwTarJeabAbIf+aX3vaNBLJPXySUxiUY2Yl5m0=;
 b=FLCMCZwNaMlZ4PrLx4f93+iIZv3OUNCXdLL8W3BR9cx28fPbvf2V5erF08J3WFAeAkDgsMsOMDxYN+v4AggFtJrLt1YSTb+HJzXUnKGSOadnU5hi1LG0DJBfhobPv588RNw6aLgK2pcROdcNiCZ++eKRoD2CfeWTLh8zBqTrcFUt3bQ9HLfdX1oHpxQ438tHyksBLxyekCrak9Ij0EeZqZ51TYbHSo6Ci/JTZj+xuOimSJm3WxjPYX5f0JEFR1ZfkuzAz09l2+6yIFd4DogdtmVXyFhdq+9NMx4o0o0lRoDYM0N+nlMt3t+YchCjpmMgcXHn5CSjSZzUCw/xguQnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3tBpcwTarJeabAbIf+aX3vaNBLJPXySUxiUY2Yl5m0=;
 b=n62MaAWmzL73qytB+w9JrIb6o5ILyraAl0h2sd6sSxbcW+c/meN1pi4SpeT9syt3jenmQY2F8sDFtl5TAoFEFnULxGZ7wj4fRJ39hvKZ+PjtcDPrBY2pxu/PlkXMQMCQOfVWtIVcn9/BwPCwmEbJikmqbGHw1dMdls0cqnYyBZlaZBhY2516MgGWBPba1KuEZRqH8TukyqFxz9+RLyo/rTRi7ozB9Y9Te2jT5jXhPFqjZWMT3LyzRnMmahwr4nwZ3wVdnRZxZtUkMr+X0jQFmygxG5iCX7RDXL9Nmh/bhr3HnHVTyZICBBHhQiliPGkio6KAUD5VvzqTZpFWFRE73g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9893.eurprd04.prod.outlook.com (2603:10a6:20b:653::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 09:13:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 09:13:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/3] spi-nor: add optional vcc-supply and enable it for
 i.MX93
Date: Mon, 30 Sep 2024 17:22:23 +0800
Message-Id: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9t+mYC/1WMQQ7CIBBFr9LMWswwJZK68h6mi4ZO7SwEAobUN
 Nxd7K7L9/Pf2yFzEs5w73ZIXCRL8A3o0oFbJ/9iJXNjICSDA6HKUVRvqNc8WWNvGtozJl5kOyr
 PsfEq+RPS94gW/V/PftEK1WAXInTEGt3Db/HqwhvGWusPDbN5spQAAAA=
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727688153; l=1258;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=PtI8014DMZnYOudcm7pF9CrJZXj1JvHbY7LS+zXVRLE=;
 b=LVU3VcwsL/KbzN6WbG3qBy4BHZ+6dQbMNLCoECd6puaKU552ZGVBeghTx6qqiQUalHxA/ImFf
 437v6rBa44wDAp0prVSMRP6HOHA0aw+lxFsIYOJ2quLmoy5EGg4Ld88
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB9893:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdc1d84-75ba-44bf-7f99-08dce1302e54
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU5CR2dMNHUzTHh4LzlKYmQrb2NQZTRmQ0JyT2YyeG05RmtQN3FPNDZIZmZr?=
 =?utf-8?B?WlQ1STMxNm5XcVFCRndhVVNWcVAwcEVsb0NtRU8rN2lWVHo4aHowUEp3V09R?=
 =?utf-8?B?clhlNmNSYncrZTBtMkdNbDVXZTBoRWNMdlR6YVFGUmprSWd6RjR0Z3hYZFlv?=
 =?utf-8?B?VGI3NEVLdkgvYUNwVHlhL1RwTWlIMXhTNWFTZHo1aUg1QXZGUjVFbnA5c2tx?=
 =?utf-8?B?ZHdZMTJSc2tHRStnRzgyQW9Jb2NvZGRDZmw0bnB2NUU5YjZIdkFHRWI5ZVoz?=
 =?utf-8?B?MU8wRzJQcGpDcXh5bnNBL1V6VHA1SkY1OEo4Y0o0MVhDT2l5WUZqUi8xZ3lW?=
 =?utf-8?B?b3hYOHgzazg4OUNxN2k1OHRydkdjdmNkVGtsRlNBdlRqM3cwL0VGc1VtVkNP?=
 =?utf-8?B?eVdDSFY4TjFURU1IeTQrRlNCREVwalkycjV6Y1RLeFVkTjVCNXkvcjZzbnFw?=
 =?utf-8?B?N0FNbEZXT2o4WWlIL3YrREU1dkJCeENreUhVSVBwNjdJNmxxMkJ2THRjaUI5?=
 =?utf-8?B?R0xvOEI0ekJQbFVrbzczbkQwL2RlcjYyb2J3bm5xaXYyNm9odEtQRVAzQ2tL?=
 =?utf-8?B?MDNIdTFFU1I5VXhGUUhRYnF4Ynl5RkpjejcwRE1scW9mTExyaTBPcC9hUG9S?=
 =?utf-8?B?UHpIT053QlhwdE9ZcTRPZzlxV3NJa0NHS25ZRERyVFhiUkxjd2J3QjMzMjgx?=
 =?utf-8?B?YnJlY3IwWElJb2F1V1ZuazhGaW5UWTFzRnNGcWdpQjJrR3dQOFFBZGhwaHNw?=
 =?utf-8?B?TjFRUEtOSGRlaDlHNWE4LzB0ekpKR3F0azFWcjhzRGQ3YWQrbDdpT3ZlNGNG?=
 =?utf-8?B?ZDR6UlJkdmw2dmdDQnRtZW9leURRR1dGcUdHdmZCcjBCbFBscURvTUJKcG9k?=
 =?utf-8?B?RTh3eFRpcjJ1MzE2UjBDazRvbWJ6WHdtQkNPQndXT0hHNXEwYWx5c1BMUlI2?=
 =?utf-8?B?ODVSSjJDdzA5U1pTMXJHZHcrV3BPMS9yUWVRUW83N3l4bXJ5YU52NWNNTTBi?=
 =?utf-8?B?UkdUeTd4OXFjVkxHWXNDODMxN2JRN1ZaKzJja2xHcWpkVmJSR1l2OXYycjhs?=
 =?utf-8?B?cFZLd3dIa0RRTHlSK2pucWV5Qk50Q0pnZVdIL1Bhd0ZzZ0NCTzdXdjBBOTEv?=
 =?utf-8?B?a0VublYySWdSdVdBVlFjODY4b0lmblZWQlpQdzkyUDRzWE1MUnIyNkREYk01?=
 =?utf-8?B?enhjeVFPcVR5bG1DUVFrN2YxbzVTdSttc2w0Y21MOFl0d3dGbm56NjlNaXBi?=
 =?utf-8?B?SHZPQmFtVUpmMmJMdUUxL25tUVgwc0E0SlpPRWhrd2pMVEd2bm9ZeEdmS3dH?=
 =?utf-8?B?MEhVZHFsRWtKazdsa3VHWWlPb0FOU2ZJRkxoS0FDSG5aOXRKWk9kdUxHSkM1?=
 =?utf-8?B?ZUZjVVhHY0IzTWN2QWIrU2RnaEpjYmFzWitTTTZ5ZXlsUStnbGdlUlZmVDh6?=
 =?utf-8?B?MU9JL2hDNi9GNkE0QmtBeFRtUXIzVXZyck9KOWM1a3I3VWYxZjNrTnVzMENq?=
 =?utf-8?B?NE9NOGJqUUJvM0xoUHlBLzlQbTNJY3I5Q0xMUmFmQVNKK05XYXQ5bkRJR1Fn?=
 =?utf-8?B?ZmZoVUE0dVhNYU5xRlcrMjl0dm0zZ0lvQ2N3OGVGRGx0OEQwRVpsUXZCRGE2?=
 =?utf-8?B?QnNDSVQ1empkRXBCQmRNZ2Iyc2JDdTFBeTNESWJpcGprMkYwNDhYYWNCZWhv?=
 =?utf-8?B?eHk4SmlqenF1czBsajZpR01HdHhSUUd4MTJnRVpvZkRnMlNta2Z1VitwLy9s?=
 =?utf-8?B?QU55b3Z3T2xmam00d3BpdWNjdVluMXlTY0x3S3NPZUhGbVRIZEZOaDNmNE11?=
 =?utf-8?Q?OKSNue978cMvXwsJyJfBV+MSKMtqQ5n1iS3Xw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFNGYTVFM2tLNkhTZWJTRStKOVBVWWVTaUdVbmc1cGhaaDJCalpRS2dpS1RX?=
 =?utf-8?B?WCt0NC9rRHk0aEtJR0Rldmg0em1nTGRsT0tyb1U2bFRrd3Y2czA3eVJoU3Ro?=
 =?utf-8?B?U053UFZUVFRwZnZmcm0zOWhVcEYxcWhlQytiTGQ1UEdGVDZhVmpEVS9pa1FB?=
 =?utf-8?B?Z2hEemVUZjNwekhrYUU4REt6TzlEL0tZU1dhc3V2cTNYanhkRHpOVjR2TEFX?=
 =?utf-8?B?Q2JHNlcwRVBueXBMSWlMam1KQ3lGVDFKRmlZSVFLYi9wclFINEVUcXAxa0o4?=
 =?utf-8?B?RDIwTGtwbEpzTXo5cndsTnZVNzBlWU42NTdjRHl4UVVaNU0vNnRnVXJqQnBw?=
 =?utf-8?B?RndsQ2p5aWd5ZmcxMlZwSTZZYU9QdlRmZGdBYUZsYXZxNGlVZytTT3o3eDg2?=
 =?utf-8?B?STVNRGVpRkp3TWpob3hFZ3Y4WktIL1I3WGFyeFAwbWtQTXJkQW41ZzBKUnVn?=
 =?utf-8?B?RzhPOUhRR2ptVG5nc09zdVI5QTZnYm1PQ0s4U3VEZmRzL1JjOGlTcEhaam82?=
 =?utf-8?B?ak05WjlCQ1ZYNFp0ZHh4YWVRcjMwa2I4WmI2V2Z1cDgyWDFka1FybDAwenA1?=
 =?utf-8?B?Z0FXSTZwdnVvMnVpd2wzenYyZDBESS9ROFpqVjcxK0tXMWIrRmYxUEswaHJp?=
 =?utf-8?B?ckFCMW5ZQVpOUzB3L0gwcnkySTVseVNFcGlqRS9jRk9XeVU0eFAzN004NzJ5?=
 =?utf-8?B?NkNQWWhsKzlZYStRMlF1M1UvTUtwZUVKcmhoSnZadVJUd2dTN3lKUFVnS3Vt?=
 =?utf-8?B?d2pJOEdvbHl4OUxMZUgxcHN5elowS0tDOWFKOFBvdGdweXc5QkNrbmJGOHBj?=
 =?utf-8?B?VVhsc01jRmQ2bFdNWElOOUhjVWREekIycVdmMWxGbDFjdkVidktQZlpydGR1?=
 =?utf-8?B?ajQrTnZMRWkvdG5Ua0ZJQUdYcDV5dU5xbjNEVzlxOGlub1ZKUjd2KzBIcTN6?=
 =?utf-8?B?Uzd2NXloTWdlMVBIeHdGK3huSE52YVR3OERGa0pGMW12R2J2Qi9VUW44ZjNB?=
 =?utf-8?B?aFg4RDBqT21TMDBLdlYyRG8yaDFxRlk2eWFXOUVCL3VUWVRNbkRLWDUxdy9n?=
 =?utf-8?B?SzVtTjA3NjFKYm9wTEF4bDhmR3RMUE1oUG84bk9MdmNpWkZkT0Y5WEh3UUVz?=
 =?utf-8?B?K0RFcjQyK0JVZHh3RnF1RXJpS2xvd0ZOZ2xHSloxTTM5MUJuSTA0MklsaWhw?=
 =?utf-8?B?UGxOT0NHZFF2QmRpdG9QNE5KdHM0RkloSVU0dFBiWXNadVZvZTNpVUpwZ2Iy?=
 =?utf-8?B?L3J6THE0Z2hHY1RzbVMydUM1LzIrNUhmcW9vTFlUeU92dFk2NHFRUW4yRi9v?=
 =?utf-8?B?c2szRXl2bHp1RHFCUGdtNk1JZlN6K3ZHRk1XY2MxUElJcnR4MU1BdmRHc0tJ?=
 =?utf-8?B?cGppRUtxTWJ4cmo4Nk1FNjVCUWJYODdYQlFPUDVQVFo2VGR6SmJNaXVydzJU?=
 =?utf-8?B?dEFrS3lMbWM5c1JydlJDSG5PNnFLOVU4ZWpENGVhYWNXdVZVQUVMM0Q3OUZ2?=
 =?utf-8?B?ekNDZEJPOTJxd1lZdklwS1E2WCtWbGwvZHFxZWZ0ZklnWU9aT1UyaFdVMzVB?=
 =?utf-8?B?eFE4SFd6bVVLR0s1a24rQitldm40QXR3aXJ6YWszWUpkbE5peEtoZ1pvRkNz?=
 =?utf-8?B?dU9qWEF1dUwwSUtuV3ZnTUF4bFhRRUhwMUQrV2xmeUdoRHRwSkU2ZnhxWENm?=
 =?utf-8?B?c3I4eVhOMTVrVnV3N0JXL3R1cDJJUmJ2cWQ3TDQ0RElIQS9VMlJHVHEyMFJN?=
 =?utf-8?B?VWtVMGdnN1dyWTY0SnhsWHJzQzNkYTN6U1JtekkzdDIzNTFoa2src2NEY214?=
 =?utf-8?B?aGRoYmhRRnlDUlNwS1VpUGs0bThqNk92TGZ0czYzK0ZzQzFsOGEzTXBGRXZo?=
 =?utf-8?B?Wk5jWSt2M0t0dWJNS1hzOG8rdFcySVd3RkNUMHBHUmxFNGtyanhVdHByMEJG?=
 =?utf-8?B?Tm9SWWFIaXZBeHpZdlRoSUZZL0ZkdTlDV3FEUjdwaDUzOWQzWUphQmZQV0FC?=
 =?utf-8?B?aW44bERkQ0FIcDMyS09nbnB4S0h6eUkrbmtLM0hxbjJJM1FqZFBoWVVWYktS?=
 =?utf-8?B?WVE3MEJIVlNPc2JIRGNKYzhNVjZIU0N2dnhXbWtEcG11bUhTVHJra3hmcEQw?=
 =?utf-8?Q?c5tcDr0e0oXKmf0TYo0EpuQ5+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdc1d84-75ba-44bf-7f99-08dce1302e54
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:13:43.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKRJ7+69z5lnDoAsSlX5dF5PbgutHXyk/y91pPcBgOnfgR3eBjZmmCgOcLdV45P6eIxhdb6JJL6l96pH3R9GIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9893

spi-nor flash needs power supply to work properly, the power supply
could be software controlled. So need enable the power before using the
flash.

Patch 1,2 is to add vcc-supply for spi-nor
Patch 3 is to add overlays for i.MX93-11x11-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add A-b for patch 1, typo in patch 1
- Use devm_regulator_get_enable in patch 2
  I still keep it in spi_nor_scan because it is in probe stage.
- Link to v1: https://lore.kernel.org/r/20240920-spi-v1-0-97f220c2e10c@nxp.com

---
Peng Fan (3):
      dt-bindings: mtd: jedec,spi-nor: add optional vcc-supply
      mtd: spi-nor: support vcc-supply regulator
      arm64: dts: imx93-11x11-evk: add overlays for flexspi flash

 .../devicetree/bindings/mtd/jedec,spi-nor.yaml     |  4 ++
 arch/arm64/boot/dts/freescale/Makefile             |  3 ++
 .../dts/freescale/imx93-11x11-evk-flexspi-m2.dtso  | 59 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  | 10 ++++
 drivers/mtd/spi-nor/core.c                         |  5 ++
 5 files changed, 81 insertions(+)
---
base-commit: 1dfc4eba4ed353d2c6b26acc0f3518d3eecf28c3
change-id: 20240920-spi-34231ea74761

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


