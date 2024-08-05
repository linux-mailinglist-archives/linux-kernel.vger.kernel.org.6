Return-Path: <linux-kernel+bounces-274955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFC947EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D9C1C21C74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B18115EFCA;
	Mon,  5 Aug 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tk/k6xC0"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C615B554;
	Mon,  5 Aug 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873037; cv=fail; b=PfqaAvgBQ9e3GktaqMU0LDABSdwm7+b9+YVns7Tnkk9q9+PD3YLEkxOwZaOABG6zjK4iS+fSA9GNg+lG8bd6rAmOeda3FKZsbRg/EGRPoDjSJzpB9t0uiTJ2dIQoL6UJwNE1lvOOlinAhkyKvnOKeA01jZPLbrsJ7HjPhCCCSTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873037; c=relaxed/simple;
	bh=slDH/JtiIZe/TICQd81/+2iCYfwlrLewVS4W7VMhAd4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TIP9r1xBZr3RK5lDcSYepw7PG7pxXFJUpHTcgJ2YU3nA6AKi9BmZgEoTeXeKJZersXN/3j7j9LJo6EnUPHhZl+4e6w9M9ObYAlN01B2dwYpTqYdWNBZha0PMB0OKACWbz1cYdd+6lVtQXTzBGA4pJe10eTF8ZgEN3MuFFDXw1YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tk/k6xC0; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi9aQKBemE6Zrln/IW8fGypYDi+IFeDLKQmKTU508udOQDjT+uSJAgeceQCyiE7XhMbpOQwC4MMcyXjwq6qoGSZG5oDui4Z11RxctmKoGCkhJ/vvuvxRB0FrJP7R+NKCIMAWaapy4wfyr5UjwhaIy+OwT570lX54NEbjTx6wsSfbMGcdJ39b4IG5MFkzqpvldYKM/usoiZC7MLzLBip7wGbwPZwXAkd4VQWTeXsvqIW1C17+hynrvU/AQs3dSIsWaOhtgT2Pky/AqIpUbGwyMsZOpzXG+4Nu3E3ny2sLXIjuXjWscQjK/s8e+uqNqbc3slpI2vOjrEFkorIK6Y0+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUw4fhE6z21IQT73rE9jsRewYlWLEKBhx87Sg9xfFrU=;
 b=sXuMnkDYW0eT/1WZemW7HbYvWuelbEwcKgJ+8o4VvBPtBSVRF4AF89K8/HsqVkU76SQ8JIRKRv0g29mMadcZyHT/whpnYdTR5ijZHZ5o+NNTOJUpWHhbD6Bh3Pkraav9WIM/vVhcpJJ7kpnRKUQ/jHQsq438JffZtYmsWGdkaFQktQOKwvzNTfp0RDicSxFOk4fnRKjOmOHIL4IAGQYweo9MWwb+nO8HZ8YxAigNdZUd/7MRz0+Nye05URPQBVs1Hx8U0nCujM3dhkU7g5o20wkBXjT4CqfCzlsqdK1k4tmzZAh5IdiKM5F+OmddgVa5NcY92FZ1v8sPfUdponm3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUw4fhE6z21IQT73rE9jsRewYlWLEKBhx87Sg9xfFrU=;
 b=Tk/k6xC0XDoqwbL2b8iEnQP+qEsaS1hYaHPmeuT5R08DAyFp/8wkrE8AkRSF6c2rptAI0d9rI5yxeyAzqtw1V/Nqix3XQIH5rzCN7IVomp81q5KMfECrADmlQ/RkwTr6TD8aVicJT9E4qnw14W5horMfvQMosiCT/LFYuUoxvR/FEChDTJuNDPBUYf+WQcsTdJ2EMHc5/ZVXdAqULDN98kJKeoClVab2yDQ9xE2hhpFi8ca53ehrv4WvcUseYI00z21XAXcr2KH0bHVBGequHRjvq1cI5CLa4vY9a4t6YUE2i/i3/s6Dd2ouqn0/jZVc2HRLx0KI05DP12/Pjk2W/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:49 -0400
Subject: [PATCH 7/9] arm64: dts: imx8mp-venice-gw74xx-imx219: use
 gateworks,imx8mp-gw74xx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-7-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873011; l=911;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=slDH/JtiIZe/TICQd81/+2iCYfwlrLewVS4W7VMhAd4=;
 b=orwCTm5YHU5SmzLfeRjhtaIIE5vI6n+CzHaepfCgVbENqGcEIZ2eEnBSB5ccX39s6Se33sRKF
 nfLIBK2MK8EDp4Ia1AiExtsNQGBp8aZyVk4tQroDnzer7jmimzI/AQU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 37df5e18-e8b2-42aa-f38e-08dcb5665454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzZHQnh4alhzaEorN25DMWQxbzFQRGNsOWYwbGNEcVJqblBBckI3RVMrRzB1?=
 =?utf-8?B?Qy9kZVFvNlFkMjUwRjl1RldrcnhCd0hkTmtUUTNqZVlWYjhvZmZ1WGZnK29y?=
 =?utf-8?B?NlFtYXhHY1QwMktOUTF2RXNrM0Vad0lHM1JzQTFIak5NT0hlckU4dHg5em5F?=
 =?utf-8?B?TDFoZGcwWmZYaGVQUnoyVVBQUFZQVFJUNlJ6WmkwUUdGT2lkcW9mL1lmbkk1?=
 =?utf-8?B?a0tEVk9STlpxYkpreG9DekNhcTBMQ2lyRzBCaXZiTnZ1WFljS056NXQzREs3?=
 =?utf-8?B?T0I0cnhoblFiTW5lSEo1OEFxcUU4aFc0NW41RnB1VHNwYjZSTC9JVC9YUnNs?=
 =?utf-8?B?aGd1S0JLbEdqVXluSXlRVzFyaVZsYTFHb2M3bGk0RVU4TVc4eWZFOC9uUnhk?=
 =?utf-8?B?T2d2VlVNRG1MTjZwSUc1a0tURnpVN2hOVmRxS0tndERZR2toUWVXK09DbGEr?=
 =?utf-8?B?U05NWGIzeGZmZERUR3RsVEY2RzRKeDAvY3IxWUJHcWxzdjd1UHc1SmVma0wx?=
 =?utf-8?B?N1dseGdTTHRqWlJrZWppYmxjbVhWVXhOZE55dlJkaGt2QkE3ZW5WdVVaZXEw?=
 =?utf-8?B?LzJLR0Vob1FReDIwS1prVVJObm1iVGp1eUtkNzkrSVBlamMzcFdSU0FDWVhL?=
 =?utf-8?B?bjlLWGozK1hPVkVSNU0wQ3FKRmR5Y2V5MGIwQ3dRM2NTdWxERDBxanNvRWVC?=
 =?utf-8?B?aFVONUlqMFVsc0FzdnY3THVxVGxPdFpjeHBkU1FBRFpZOVdIbUpNdEQ5TzFO?=
 =?utf-8?B?cmZPWWlUY3lwaEVvcFlyWHdwV0NDV09SbDRTV25McFl3ak9VTys2TTNZVTNI?=
 =?utf-8?B?bUxlME0vdm1zSkpGY0g0VkJTbk5IY21GcWcyZVFNQjB4SUsvYmh6MjRkK000?=
 =?utf-8?B?SjlDcVp1S2lmeVpjMXFxUkk2WmxsblhnOVpSTUoyNEJuM2RTUDVjTWtLRXVz?=
 =?utf-8?B?V2JjNEZqNzB6WFkxWlBqcXQrVGZISSsrUytrNkRKandmaUlydDZqemcyQkZp?=
 =?utf-8?B?djZmeTJnd2IybnJYQWRteG5MUXZSRzExWVBhVDRuR0t4bWpnS0NtMkhXVFFR?=
 =?utf-8?B?d1BLaW8wZDlGSWdzNE1zbFZXRUpxengyVEx1SjJSZFdoS2wyVUdBSW9qSEVF?=
 =?utf-8?B?RjNLeFBSRU4vdnVHelVYZE5ObmhoeDhiZ254Zm9yUEh3UXBJVmhRY0RlZU9R?=
 =?utf-8?B?QTROWDhHVTF3R05yNG5ncmcrMTgvc0pFRzFyR3d0dHNYYTd2RG91MGsvQ1hB?=
 =?utf-8?B?YlVpQVdqampiZTFveEpDVk5ld1R6THlnTjVJK0c0aWxQTG5MeVloTm5OV2hx?=
 =?utf-8?B?RjE0QkdnZytOMHNJZlNBZHhCZFZsWVd4L3RoWFRYYTdOSnZKZ3NWcEtrQ08z?=
 =?utf-8?B?T01YbFVFNXN0WjhKSThLZWhZcGh4SWRnSU5NRUlYZ1VJVTZhRGVodElDT3RP?=
 =?utf-8?B?bllFRmVNVkpScmhzeWFaMWpuNnhmV3dEMDJMTjlTWlVubTZGREVBZnk1WnVl?=
 =?utf-8?B?N0hMSjlaamcrcDR5S0dqbGF5Tkllclc3Q1V1dDlqOFBUak1JOHpuc25XRHEv?=
 =?utf-8?B?cjZLTENQc0RCaVRaTnUyUG5kTVdzTHlJNUx4b2s2bU1xK1R0N0xTZk5qNDVE?=
 =?utf-8?B?S2syVERyNWU1UEtGOGFOZjB5Y0k5OVZDN2Z0ell1L1ExRzlJZEo1bXJ6M0Fn?=
 =?utf-8?B?V3g1dGhuUTl0Z2JwRWlDRkx4Vjd2WHBhd3g1NlQzc3lRak41cTNhMnZhZS9U?=
 =?utf-8?B?SW9hNi9hNnFERS9Pek1meXpSNzA0OE1pWVYrTW9uaGxNVEFMQ2VLN21tQ0RG?=
 =?utf-8?B?amJYM3UyQVBGam1BeUsxT1dVY0VpeTk1aDVyS21Jb1FQUlZ0eWVybkhOcUV5?=
 =?utf-8?B?NUJqeGFaeVovZi9raU5GNng1ZmU4eDhEQk4yQzk0cUx5UGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTlwYXRhQ3c4aUx5UU1VL0sydnlFVGVISEVJM0ViVGdVbDZMSkZoTzFnd1h6?=
 =?utf-8?B?cWh2Uk5kRXFRT25FaWt2YXdWWXo0ZmJLRUxnaFpFYWtBaDlDbG5peE05VFp0?=
 =?utf-8?B?OXhhMS96czkrRlRVZUFqYjhjREJDSzE5bCtaVmZEd1hNSTdIRnRHK1dLZmMv?=
 =?utf-8?B?eXBzdW5ub2c2WUFNNHgxdGNmOG1BNWJSNjVjVEFudFovSnhJODNsQVVmaE9U?=
 =?utf-8?B?dWpIWUpTUVJUK3V3ZlFZS3JXbmJjUkpvT1RveFZBcUlucEhjbjl2eVZMZmFB?=
 =?utf-8?B?SmtCNS83ZUpqNXRWQ1RmMm5DdDIycU80TW40MlhaM09JNVNHM3pMWmdSaG9E?=
 =?utf-8?B?dkwyQi96TzU1LzFESjYzMXEyRGZscGp0SnVmdWY0OGg0VTczU3h5OGVnckdK?=
 =?utf-8?B?a0hQdFlDUmV1eEdrbWQybmRVdmFEMjJTeE9VQVBHY2VoTjF2ZXhIL2J0MGpO?=
 =?utf-8?B?bFlYMDYraDN2QVA5NExZK05oQXJpaTFNMzlNVDdNZEJ3VlJrNHY3S3N5OUtj?=
 =?utf-8?B?OWM4WVFHdlprTHlpMWdzVGNtUFVVYW55Qm02bEpKZnRhMEhpWEN6Vm0vY01x?=
 =?utf-8?B?RklJZklYWWxRU01kdjhnT1dxZWRtQzQ4TlloQ0tEbE0xZUY1TUhIVm1qbEta?=
 =?utf-8?B?MlBrUU5SMUZhZ0pGQmh6dEthQ0RGTTZJU3h0NE5FeTlVOUFZUWVQZ3cyUEtz?=
 =?utf-8?B?c3RQWkNQa2ZQOGEzc3o0Qm9MTDd5NTU5NU45bXJKNWRablQzUis2NUgyWjVh?=
 =?utf-8?B?VmV3U0kxRmlQSlFicFp4R3YrcTZISHk2RmFrWCthcHJLcGJpT0JEaEp3ZFM4?=
 =?utf-8?B?b1YwQWRKNHlSSm5QbEY1cGtLSlh6cU04c3cyR3ZYU2wrdDVXSWloY3NlKzZG?=
 =?utf-8?B?QkhlSkVwVkRxK0ZUVkJ2NEVJQ3NkNHV6OEJCMXR4RGhMeXZ3YkQrTXV1Y29p?=
 =?utf-8?B?cm9RUVVBeitya2k1VXBKWVZWcVlhcWR6YlJEWDRLMFdZWWdzU3A1UWJrYmpO?=
 =?utf-8?B?Q3pTNDk0cGdNZlBiRHpEbEQ2VkhObjdRWnh0VHFEUEFBL3VMQ3NhRW5HVko4?=
 =?utf-8?B?anRJMGdpRXhMeVNlNWh2d0hOM1g0czJ3L0pPcWo3YnBKaU10M2pZMnh4eVph?=
 =?utf-8?B?YkhSSmIwUkNmOTc3QWtFTGJYOHkra0NLUWxOdmV0Z2NraytqTzdsUllLdDk2?=
 =?utf-8?B?S0ROcEhxNFJKVVdxZEpsenlOWDB1S3pLdjkxWVVyOHdlY0NjSDliVlpJSGx4?=
 =?utf-8?B?QU1FMjZBY1RTcVBXNWlSSk5ORzlGWkhHQlMwWno5SEN3N0pEak90a3lzYUZD?=
 =?utf-8?B?QUZqNE5BMDdKcjdkNWRZZ0hhSGRjR0tUTTNvODdKUmc2eVF4bC9xN1BFVlVB?=
 =?utf-8?B?UlJ6VGJ4eEVGWjBFbVNzMHY1UW5CT0FwU1lMR2JKT1EzTmZCcUVibnptcCtt?=
 =?utf-8?B?UG5kdzZYMHZ1UDM1eDN5THFwTFZNMjJ5WlZtNkduS1daNUF6d0krdWk2UEF2?=
 =?utf-8?B?Vk9aNGlhMG9tbklVeGRYYkZkUkYwU3l4dkllUWE3V0JCemc2SngxMzdPWTgw?=
 =?utf-8?B?KzNRMDRCWmUxRnlkS3lxSFBZaE1wR3BsdmNhMlJpcjh1UFI4YlZQdkVWNmow?=
 =?utf-8?B?dnNuMUE0SmRmRkVOSWE2N3RDRkorZVFFdEM4M3VLRjVvZWpiYThROE00S0dS?=
 =?utf-8?B?WWpzS1NzK21VUElvMGM0RE8wL1dWdWJINGhXU1Q3WkVGUzQ1alhLTlplQ3hR?=
 =?utf-8?B?b015ZTRvOW5LRWZHb0k0SnVTbEFyN0tyc1hLUEU4dkpzcU5LUlpnWlBBRUk1?=
 =?utf-8?B?MEhrdCs0b0dSWlRNbDhKcW5aRHZIQkNtVnhKMWFnaDhuT2o1UVVMVEZaQzBX?=
 =?utf-8?B?bWJBQUVXaFludTBReExaTjVaaVNPbHF1bHlDZDEyNzdJdThhcGdUQ1F5L1l3?=
 =?utf-8?B?Mm1JMFFMNHBWNGpKenhaS01hU3pFcG1hNk1OWGkyTzcyS0NJZ0loQ1VuTTY2?=
 =?utf-8?B?OUVGQWhsYldKano1dWFCMW9lSU5qdXVBcGVUY0VNOWk5VkZXSVgrN3dFb2I4?=
 =?utf-8?B?OFdjU1BqOHZtVEJaUFM2cUdZaGZSNDNTRnQ2RnBnZ2dlL1VWVGhWMUZnNUFC?=
 =?utf-8?Q?ObF1yMzbRm6DcwEcerllLUf1R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37df5e18-e8b2-42aa-f38e-08dcb5665454
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:28.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2XX0RNkeyWq2z6lKqqTwon+d1KqwRLv9ERfAudL4Bqtc/pjZYSjAnbHvrFoaAtxxvl8WHtKdphj1yyoQHmlmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Replace compatible string gw,imx8mp-gw74xx with documented string
gateworks,imx8mp-gw74xx to fix below warning:
gw,imx8mp-gw74xx' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
index edf22ff549a47..3d2841a1504eb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
@@ -11,7 +11,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "gw,imx8mp-gw74xx", "fsl,imx8mp";
+	compatible = "gateworks,imx8mp-gw74xx", "fsl,imx8mp";
 
 	reg_cam: regulator-cam {
 		pinctrl-names = "default";

-- 
2.34.1


