Return-Path: <linux-kernel+bounces-343653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE65989DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91CCB22E03
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1D188CC9;
	Mon, 30 Sep 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AoByEE1y"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F0186616;
	Mon, 30 Sep 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687636; cv=fail; b=AaElqy/n95IEwgYt8REjpj0w2an7MSNF6suRFWHvhvHGelaiHtaYpoE8u9Nte9ttaQDUz83Cun1+Ji2EhVTls17LsN3m6WVr+RK3cQbxpWQfQrY2iWBaqPkYBElNFPJKG8DYQahgOUfYxJQkxra59eewRCU5wapp0+ijl6KHghY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687636; c=relaxed/simple;
	bh=NsJUH5NojxRAdNC9lEvCs208z3vzPlnqkIkCTD/HC5U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BIAVV9bLq+tT1b1DYpcoUbyPq8K33OnvjFlMHBY+LkSI8DGLoQ71m21hWl8rQnSbOkowgC4nCoxzLitA+zqS8V+5qB2YhhChj4cJqX5fx4C6NKTqMg5Oq6+koYgyE4ZySQjn+vsKGDcc0BJlvS1bgNoFH7BsFcsqM9BGavuoTH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AoByEE1y; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nri9Pu1QZ0xKkVs0KtKqbp3qgyVt96ejWeUNQMUBu5eRCk4LMjjLorxlbiYSbGbgZ3KgY6747gN+/PCDwMSk2ENccl+J0Yb/BZYVc5G5fZrFWeNou06Syx7TJB62NYqBU22hQcxVXS+Jc4WFc+EXePfFLb4C9IiDegIcYKnRfYDVoYh6plCHjqXEQluqFlS5atom7nt2oJ91uPj7x/tOmCKNOoAVjiZ3wYrcAZdDV3Yf+g7LnqBV1HsZNc5Jg17IzV8LcVWqXwKOFw+pR81IgKuieueGOLjAcXawjQdslM8M/SoBCGPTO47F84kE3qWm1/OF3elnYsUUEaquGCGCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClwKpgBOVfl87Lhi+w5cm4Qn7yAezK3XX/iyO5BkGTg=;
 b=LSmHq4yFMxA7LHNikAXQ5CluR2bNV4iPLi7NmD/TVk5yLFM7iBD0NbiIqtkhXpWnaliUlQ06ZoV9C+QSCsMnYktqIsfPGCr/0nfOpZHXLZH3raG0vxn0UJBOwsrnOQy95sLn82i0qrBRi8fhsZCD3WHp8gE3ixtH2Bxw5v64AYGwEFG9a0Y93kBqo03iUBbV83CXtnRaqBfG/7Wr8C5fcgIThAW8z/ytGNwEwHulwgXNnzIZxaHpPVyMoQQXtINGYl49620xh1mjD54YknBxRtgm/ziizAjNZOq+a+brS35gVP7Eouff0i7IXNGIdbi5yCLfPAqNx7Y8UgVm3VOrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClwKpgBOVfl87Lhi+w5cm4Qn7yAezK3XX/iyO5BkGTg=;
 b=AoByEE1yw3Ti5Gqb1azjG0bu68vfBBXGMWH3zQWZhPUFpW4uCz05aFpI8z4V9WM1aUjHnuqbedkIb6DTs+sdEIf8rc4jZIg10xBMqaH9boY2vvLwGiUKI2QvcRwkWrfLwVpsRzX+7a8XiLxCNxxhzHAl/FULZ8WXpSfQyqsXAy14ebmkw8ZfZZ1W6CJcnmZ87iHsGbuvxBgv1TXuaoje2QYV+lL7+4HPSkke3rxggEk0J86xvQah1+0o/51PEjqyV1EqIBKrCXBgTJXhgh2ueZseBr+5Qa8+F5IiBrO+dKsvym77q30F1DB6/fTHH6Fr7naHdQ2SKDSvdU/WM2biwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 09:13:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 09:13:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 30 Sep 2024 17:22:24 +0800
Subject: [PATCH v2 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-spi-v2-1-ed7f6bcbe0df@nxp.com>
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
In-Reply-To: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727688153; l=933;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KCwcdIzFjSB6OYMltfMvwaZ7bZQHSPTg+5JWl0oJQoA=;
 b=dy3pION3h1kxIVo/g6mzdp9VXckxpbdN0L42pwwN8+Gb1v5yUPLA3yQWtbAKKRL9QnkDhukwa
 Intim+KGbOQAUUdZgQ+7qwy4zvQKSFn7UsMGv+FdeU6xFPLb0uCxR7F
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 96039ac3-07ed-42d3-c7c3-08dce13031ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1I4Z2x2OUZQR3R0L0hVbGZESnNPOERMNVFpRURGWmpHSnBKSlJHMUNYOEV1?=
 =?utf-8?B?cDBQSjU1bVAwOGI5QS9aaFJ5WnVYYTY0OW93RFNRNlpaSEd0QnVselorNnNv?=
 =?utf-8?B?QlRKY0JoNmIzK3NZamFCbnNTbXVjNGprVmtScTYxL1E5QmZCMjQ1eGZjaDZB?=
 =?utf-8?B?YmVxNCtxSUl3Wjd5RkVYVDNhQm13MDhuQjZ2dHdwSHZ3NGhZL0Z5RVozeXN3?=
 =?utf-8?B?d3ovVERoZFErWGJmc3dQdlA5cGtvSlVDK1B6UUxmdjFCUW5yTFdqQ1djVWYw?=
 =?utf-8?B?ZnFDRUhxRDhBSkcyRlFneGZmbnAyb29CVmhWVzgvaDJNUWF5YTdlSXN0aSta?=
 =?utf-8?B?Q0RKeUl4bGE5eDZzRzh3Uy9BN1Vzdmx6TlpZLys1Y3MycnBYUmtvR3cyRCtt?=
 =?utf-8?B?WENlM1VwQU81ZUhvT1VscjgzSndTUE9WT0NYUUU4TmVQYmZOYTFLRnBqS0pF?=
 =?utf-8?B?M2duZ1BJa2xBbG9EOUZFTEVDUCsyVDFKd2Nyczh0Qy85bzBXWEdyRmg0V2tM?=
 =?utf-8?B?MmtCL0JVb2xLMHlUTVc3TG1PMk15ZmxLSG5HUGo3blBBSGFDblo5eWcvODJt?=
 =?utf-8?B?bHpmekliZWxtMVhiZWkybFhRcE1OWXZBUlJVeXdCL0ptQ2dFOWZVOGNmQjI1?=
 =?utf-8?B?aE1NamdTV2V4cEpHaE5JMXVzVnpCNDgrd2owSVU3TGZpRFBVT2FiK1dWV0lW?=
 =?utf-8?B?bkFsOVRKNXlWMVFKYjhPMlVBQk0ydllZZFNtVWJNQ0VoTG5tc0dWeERMT0dM?=
 =?utf-8?B?V3BNeUV6dU0zcWZDRnZUTnFEM2VDT2JtM3JaK2RjZ1N5ZkVPMCsrZTIvREds?=
 =?utf-8?B?L1hWV1NKdmFRcHVYaHdKYXBRT2t1Y3p4YjVJZFZXeXJBZHB1Rm1mS2dIcXRw?=
 =?utf-8?B?SHVxQ0Q3OGdabnpXeHFtREZYTHNDbjBlWVJnZ2krOUxycUlyVFUwNEdTbTA4?=
 =?utf-8?B?c01EOEdiaVI3WllyVzlpVjBrOGNVaWNsYWNIUjhwcXI3d1dNNDBZSldPT0RW?=
 =?utf-8?B?MVhsbjhHS1Z5Z0ZpMWV5SFVZTXl0ME1VOHF1RFpDd3Nia3BwTXQzK0twMWwz?=
 =?utf-8?B?c3VHb1B2T3BjSjFZWHFKd1l2N3RGOTZjenZCQkVBV2pGaE5iTW5LUWJUQ1dF?=
 =?utf-8?B?bEVYcHJtZ1k4dkl6MU1wTElOdGRMRERXeithSURZbGh6ajNxSzUzOTI4TGhL?=
 =?utf-8?B?YVozUmZOZ1ZVbFdlSVNqa0dTZnc4aE9pd0ZmTjJzaFM1WFhXR0tmeVUzOFlX?=
 =?utf-8?B?OGNNQWtlemZvSmhBN2VxNG15MUMrS2QxVlR4VHVUNzZpZTE1MS9ESWF2UnNr?=
 =?utf-8?B?dTFjbHF6QXNqdWIxUWpTZm13RHJZWnpjOFp1Ti9MZHNUenZmUUgrY2JUQ0hN?=
 =?utf-8?B?cHZtdWtGNFluaTdMVGZlL3NaeTJLcHJ4MGdEUmFjTFZRWGIyd29YdlE0TzdD?=
 =?utf-8?B?eEh1SzRxOCtPWWovSE5oWmpETVpseE5ua2dqQm5EUXRPMVlTbEQ1MFNoaXd5?=
 =?utf-8?B?SmZMUHRVTjRyTWQwb1A1MkZZRGxXUjJDQTBabURrOFZqUWxvaG9rRVB3SDNU?=
 =?utf-8?B?am1XWnVaallBQ0IwR0lweTJOODREUXUvN210NmJCU0w3eWhISmFOYjBHMGpC?=
 =?utf-8?B?emMzVUcvU2Uva1ozekhTK0R4V3ZMWlhUUVI1ZEhjamtrVmQzUjhPdSs4L1FU?=
 =?utf-8?B?SXhZOFdZaEw2RGpOdVZuYWlBd1UxZDJkS3RiNjhJWTJxdUZDcUVBUEZvL3JH?=
 =?utf-8?B?bzFDNExvdzFJV21KWmJ0MmVOMTFrTG5zTUE3ODBxM2YzeHNMalR0cE03TTh6?=
 =?utf-8?B?TzE5NUU4dUxMcDl5d0p5a01LWTdCd05ZdnlkdUREREhtYkRQWGwwcDBNdEgw?=
 =?utf-8?B?b2gxSVdqd2h3UW5PS3JnbzMxNHk0TDgvaytMQ3JtU3lkWEJDREptUlhuNlQy?=
 =?utf-8?Q?aoXPo1EQDXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGxIRkp0T3k2QWlQc2x1WktHRHBVakpIUW9MMmZOQzFIblNpSDJPYTZGNy95?=
 =?utf-8?B?UVZnTDI3TENNd3Q3U1BtbW9aRjM3dHhaMUsvalBuY0ljYWxJNjFwb2NzTFlI?=
 =?utf-8?B?Z2pZVGVZUkZWMUFjY0xMMDN5MEhiekVGaVZocGZUV0FNOGpma3ZzSkErSW5B?=
 =?utf-8?B?d044Z3VwVWpZanZVcXczYmdRSXZGVytGeFFoOWFvcXE1UlRhcS9obDBFcXFS?=
 =?utf-8?B?ZWpuMGNXSVNRbVcrTk52bEJXcnpwSlA4NlZpVGZxZGFHNGFMYm9MdXFJZVZZ?=
 =?utf-8?B?S2c2RnYxeG9SNjZobHFqb0FiL1BjbXprMXcvWGZOMFVuckZXSHlQZyt5L0Z1?=
 =?utf-8?B?dXcvMlA3L2d0MkxvUG56V205MkRheW4xWnQ3Nndncm5JUkNsVjd6b0FDKzAv?=
 =?utf-8?B?dFI5NXJVSWdvNng0VFJnaEhkQUY3WFYwMmRUQXpxeE83K1M3Y3R4NCtSL3J0?=
 =?utf-8?B?a2NGa1FTS1NPT05vNUZCa1RNN1FpRFVNUHhyZFFkcXBXOG80MTN4RHd0RE11?=
 =?utf-8?B?VTJpVTY1ZzhqTFpJVmM2d3JvamRvT3NOK284SVhNNHJmR0x6ZldwQkUyYWt4?=
 =?utf-8?B?RGp3Zm5SWW5MWEFPVkNWQ2p1WXVhV3BGOG9UMGI4dGZ2MFBLWkRSa1pIQk8y?=
 =?utf-8?B?Y3ltQkxqRDRvQlhrT291Uk9PTlJZV0oyQlNqTklJcy9NaHQ5a1hPRGhkUGdM?=
 =?utf-8?B?cm5FS09RVFp5eFYzRWhMRFJWSEFPdnlmSHpHcWFLSkZCM2RFUitaR3MwS0NC?=
 =?utf-8?B?QXZNMmhVN0VzN3F2T0o2UjRQRFVpSWlISGJRTENqUjZ2aHBlditnQWppNWp6?=
 =?utf-8?B?UWtSMG9kS1A0eG4yZFlTZlFrdG5WZzZDWUVqVWtRR2lZRzhRQ3dlT2ZtdTlQ?=
 =?utf-8?B?WGkyY0g4MGFFQzlhQXkzMFk2WE5DdlBReEp0eXZYZ2YxcVJQRjgxaVRkbHQr?=
 =?utf-8?B?SXVzQkFBNW8wUDFaUDhtRjhoM1hrc1lGMWFHUXg1a0h5MmR3S1RKaW1HYzVh?=
 =?utf-8?B?bFhkVjNwZVBkdnByWFFTeUMxVVhkU2c3dzJxVklaTzZvZm5nY1l3akJiTmpX?=
 =?utf-8?B?dTJXRHYrbTVRWWhxZWhPdnNOc1QwRndkeGNlOWdxNDR6NWJPYk5RUWx0WVBj?=
 =?utf-8?B?TWtsQTFEcnFPUWdsbnl3dEtrUXBkSkVRaSsybHNHSnFxQjB1L2w4ZnRic09q?=
 =?utf-8?B?UFI2Rmp6SlBza1ByNThkaGppMXdEZEJ2OUdPL3pad3p5STZTR1JLSUdOSFh4?=
 =?utf-8?B?MW4rYlJnOHFvd1FSQUYyS2JydGV0UkZ0ZGlLN2ZTNUdsWWY3R2hjMElSRVNR?=
 =?utf-8?B?OGpIZnoyS2k2cjQrZ3lhRTBEWkFySmZvam1icy9ZUnZxdnhmSjA4MG9mTWFm?=
 =?utf-8?B?WXlhRXcwbW1Oc1A2dlN0czl5V3RWQUNmMGxnZEQ3QmhIUUJ3K1dRTmRZVi81?=
 =?utf-8?B?aUhua2llckN4QTRjbFRJSmlFeGFEUzFtTE5RMVkxVXFmbHBUMy9hWmRmNFBy?=
 =?utf-8?B?YVhOc1RyUHQvaURGUjVNT1NrSzN5bzE3V0JPdDJ6MGRZTlowZVp0Z0NnY044?=
 =?utf-8?B?Y1Y5UDNaYllXUEQ1aXc1bDRCVDdRUUlTeXhXSTFrK3RBWjZCMlJkdmpZK3Br?=
 =?utf-8?B?b1pHYWpWTktxV2t0MW1jTVJ3Tm1DNEEzZG1GV0JCV2NiOUJVLzVnT3RvS2F3?=
 =?utf-8?B?d1gxMnF2Ri9ZVGVlTTNBbnFzeTRVeVdpZGpNYlREUGlUM2JhREY2KzFTNDFJ?=
 =?utf-8?B?a3RmWDdhMUdBLzVNRFRDaFozcG14UDl4dFlXODhQc3pXaXg5SHFjdHpSRElt?=
 =?utf-8?B?dmhWTHU5ajNhTDBqcGlqNGFuU0NhZjlmWHBHNk12bnNjWTQ4U1ZSZ1BhUWpL?=
 =?utf-8?B?d3Ird3kzZmNFczdaaFdRSUxHZDJ2UmwwSDdiS0lSeFNXTVNyZEtCVUk1WUJK?=
 =?utf-8?B?cU1oNFpGZC9ZWkJZeU5IWGlmdEd0Qyt5WlJqbjFuM1BZRnJWMlhtbWt3NHBx?=
 =?utf-8?B?TGUxcnBQYkc2OVExcWhyN0ZwOTVVWjZnTDhGOVBXbVdEdys1M3BTdmFQeEpB?=
 =?utf-8?B?Q21kUXBYWHhaTkRLZVFzTDVmeWRNU3MyL0l4Vm0wNnVVNXluVkJMeEovaXlv?=
 =?utf-8?Q?S7hrN5YG2PajNCsFTWZH1JfD4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96039ac3-07ed-42d3-c7c3-08dce13031ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:13:49.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOUeTxTDOMCJBvY8eSY7v8WPBNUrf9FLovu6DvKzlBdmNf5pjlVOt7aUyXgQdLgZbL9p1xdhtd9tVGRHWr6DIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

From: Peng Fan <peng.fan@nxp.com>

Introduce optional vcc-supply property, SPI NOR flashes needs power supply
to work properly. The power supply maybe software controlable per board
design.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..bab0617a51d5 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -96,6 +96,10 @@ properties:
       If "broken-flash-reset" is present then having this property does not
       make any difference.
 
+  vcc-supply:
+    description:
+      Supply for the spi nor power.
+
   spi-cpol: true
   spi-cpha: true
 

-- 
2.37.1


