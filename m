Return-Path: <linux-kernel+bounces-216842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDD390A77B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F71B27817
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6C18FC8F;
	Mon, 17 Jun 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IoAVlu7x"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484DE18FC88;
	Mon, 17 Jun 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609588; cv=fail; b=ALisfN1JULn3gPkhh/xOc8cTUg6Iv2RhgF9QM5JTnP5MWgBroz421GxaKKEgLcetFy3Dl3XupFrfnGe6KbgRuqM3zSf0IQZxFzE6wfA0xEk+Z+/ygbioIyd4ELbDnfHSSyQf/RkkFSFGGR2BcPNw7xicVewHtJyxyXtELO8nvMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609588; c=relaxed/simple;
	bh=tPlMHsyGsirGELOluQidOr10orPzhBbS21AqUGHlWS8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IfJR/bGwh0wYOTx7887wYXCaIseSNYouc+ftfWYArnAoG0o7nQu/y8Hlh34iTAixZta/6F8tVyE1uMSLtRTYC4yMTWirKP3Mws1RLj9Q17pg4idgpGFyAoBaAcg2aMIwoChPQ5lbiRqP7M1/A3/AaKNFOjarKVykfOdKXouQvW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IoAVlu7x; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDNxrtFuea9TTkMlmVbWg/Ou7ILkNxJdA7hhwQ0j/DoXZ52d8jjO0X7XCGtvMLWlMJ122ie0FXLIHLwJL36vSGv36+opzWuOjuLW2OscXXzfF8wcO7rA6rKqKZOvv71wksMy+MkiZGb6/KbT6VPQpoK+T5nJmFg7pS6tbrZ5Yr5ph70V1mdegvlhP4lID6xXtRm/ZAUfOt3tpK7pnNwV+D1DArD+y1qdoKPY0Oa7nuCwHdxcd2Nl4xE2i8dfnY9jz9RE+P0dTqghhBRT38sYN2VoUy5W3c9oAbp5859nHsLqx788bl6ifr0xioFc1Bevv6wcMQtLbk1LBUNMIYCnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5caOLr1i6riPrx5E9Lig+7aN7+MC3exitCHLxv2dhjA=;
 b=ijWeJgrg49IIn6/cN9Y5O8P8mno+hUfVtxnZtjbPf1wNJwwGZfxVPE7ffl6Hcgy7d6ShAfZ1c0sqt8O6nNn3zkuI8tJpStOxMc2m3lW2kchXywY3whR9PMF25/9lLKK7ELtoLyGBPOUoSdKuAvsKVrIH5Qn5l9G3evd8p5j/trRyy2pPjbT4AIs5/2896eU+P6phiKeNF/9VLVHH1cbAsbn7rMidgZwUlP9QzZ1zfAxf5zVX90fY+6qvlDL8Hd3J7NM5sL1WqrVHeR19M978sFb7wCV/PbjQYZmEEwi2mihIGKOgf5El4Pm5de4XQQ7Z+9AphV2bm+pR7KtUb+OPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5caOLr1i6riPrx5E9Lig+7aN7+MC3exitCHLxv2dhjA=;
 b=IoAVlu7xZWNr01Ot4D02afGbxA/WxlQlx9Yj3LzHSfw15HJscAd8KwbJag6duKrVomyYxvhLaja3LzGvxIKwC6csGNk4LYIWwjfWGjL6zqzghJ9NMTznZNXJLDmtzOno5mIg0o6iMlzNSQaY/Mo+BGHsE3kvg9TuE52wAy3irAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:33:03 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:33:03 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 17 Jun 2024 12:59:41 +0530
Subject: [PATCH v3 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-imx-se-if-v3-3-a7d28dea5c4a@nxp.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
In-Reply-To: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718609402; l=2654;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=tPlMHsyGsirGELOluQidOr10orPzhBbS21AqUGHlWS8=;
 b=0HU2jB/PU3XFNa6ajgueJBvk5tkEktfT64GhQ4EamfK6KofyUnj9GSISHzf0b3Tdr1QbBvltc
 UJna6dk+Md6DxOPw8t73SoC5jPrX89q9dYWis+6eKRaOJZVadf2p6Bl
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3305f0-bf15-49ce-7541-08dc8e9fb8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlVIaWQ1R3pGVFl1a3RCZm1JM2pndVpQTkZJZ2d4ZGFvVDQ0RzJzQWtUU3cw?=
 =?utf-8?B?blJnMERXSTFGOE1OMi9yWlBmeG1Jc1hkakI3YTRmT2hQZUJWQmxqVFVrYkJU?=
 =?utf-8?B?TmZKajlqcGVQQnlYNmt1V21VVlJUNGhDdU1FRlFySmZLazhWdGFOUk5aVTNZ?=
 =?utf-8?B?azBrbTdiNldhNGR3T01LUmpvT0dvVjdwUmcwN0VEMGthdVpyem9DR1YxOGhO?=
 =?utf-8?B?UllSMm9wU0xHWGdpdHF0QmljK3RxY0c5VW1Ib08rdWpPWWVyUXBIL1V5L1FI?=
 =?utf-8?B?aUlsbDN2S3JKbHJ5VGl1eVdlSktvUE9IS1IvcE5QenNSRDFKaS8vRlUxNjRN?=
 =?utf-8?B?S2dkVXFmV0tBZDlzWG00dmxnZ3N2OG12NC9rOW1LVW5ncnZlSURsYzMvUTR6?=
 =?utf-8?B?Q2tKVXVQZUc5T05kb2dObE9ndkh5eXRwUnlvVEU5Tkg5d2trak1HdFBjT1R3?=
 =?utf-8?B?bTBoNzVBR1pYZExHRzNvNVhpYXpjeXlQV0RqdkwzeXI0K2xFWWpTN0QyQitz?=
 =?utf-8?B?czFjZzdGTUNiNGhnQWNSbGNndU5Oa3hHRE94N3VlZmlzZXNUQW9qVzNyYjZj?=
 =?utf-8?B?UWlhL0tNM3VDK3AzWEE4U2prYmFsODVpZFJiTFd0ZjBYbElBUWM2ZVVVQ0ky?=
 =?utf-8?B?NE9PblJ6L0x1bEIrZXBwOXQ5elRIUGJZOWoyTjY3MWtxOEdMa0RLL2VhSi9E?=
 =?utf-8?B?dTNoMG8vWTZMKzl5QS8xd1U4SlljMjJ2Q0xNQ01pY0ViU2tXQWoraHRiM1Ew?=
 =?utf-8?B?SXZTdVpLU1FpMFJRMENOYlZsb0Y3NDVtNmZUN2ZELzRlZVlQQlhvZjBIR1Vs?=
 =?utf-8?B?VFh0cDN3ckpPRWpLUnl2TW5DT0docWxtMXR6b0J0eGg1TXlXSi9OZkN4WVg2?=
 =?utf-8?B?cXFQK09GL0hZMFV4Tjh2dnFaeGFHb0xuUXpoL2l0UXZZUFhCYXQvaXU5M1lj?=
 =?utf-8?B?b0orZkNPbUNMMFYrVFBlZERXc05RWjNRdytKV09KUUVFM1lEc2lPYU90WVJz?=
 =?utf-8?B?c2tqMERsbURNUnJ3RnRVSlYrelExUEQ1bHhVOC8zS1FuZTdvb01SbXdJM0Js?=
 =?utf-8?B?WHdzbmkvdE9WbkcvS3BVVXdVYWRMV29kUFNEMVk1QU5KbFRRY2x1QzRZWGdp?=
 =?utf-8?B?TXhLdjlhdEVJTHNxemNOTnYwR2QxZlRIVnYycGY3UHNUZEN0cHNqT3ZBVFN0?=
 =?utf-8?B?SmxDNmpQZStvdU5iVHZMRlFHcW1Ud3FXYnBRSTBQcUJodGx4SU9EUlIvOTlJ?=
 =?utf-8?B?bWZ6ZjFjbm1GdkgvN2RCU1M2T3QxSy92N0Y1NmtGNEZoNU16QWh1Q1VncGtH?=
 =?utf-8?B?VGc5S0IwOExwSGN1WDdHQ2FiMUtGOXhVd245VCs0VkxiZWozdW5TekJmMVI3?=
 =?utf-8?B?VzFuZzJ0NExnYmwzOHBseGtUQ3R0eVR2V1VoZXI3M2U0TlJqZWl2OXJOK1RH?=
 =?utf-8?B?RElqWEl3U1BKWTl4OGJqdC85anhORnUzdjM3R3A3bGlPT2pSeFhnTDZRQmRi?=
 =?utf-8?B?V2V3MzZ5QmtzZDN0Q3hkTlBicFRCN29xVUI3MnRxdERQOXdoT1FBdkhhNFQ2?=
 =?utf-8?B?bU53R09sd0kvQ20wZ25EQUZXZzk4QjlBNzZXOG90REFUanBkUktBblE4alVO?=
 =?utf-8?B?TTFreGNrU1FmN2pTR1BoNTZEdjFvUnhhTnFCelBhbGpEZGp6OEtGR1JpQ0Ew?=
 =?utf-8?B?dnV6ZHRhZUZhS0VmUVVXWG1pcDVuL3BRVnZkQXdNVTNRL2VQLzNXUXlCVEU4?=
 =?utf-8?B?bUN5LzJTWEN2WE5OODd6bFpGOE1OMlF3dnYxRExwKzlVc0ZUUGRDZThkK2dX?=
 =?utf-8?B?TkFydXZMakVQZ3JNbFI4bUZ3WC9INXJKV1hrcEgwWGl1SXhhdjhXVnpSNU8x?=
 =?utf-8?Q?G28b5ijCwu3UO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T01JRlRiT29XaGJaUXR3VG5XeVhHTWJRWWs0d1gyS3dXdU9MLzRMdkNzRnpY?=
 =?utf-8?B?NVlNQUxIZDlDVmRZM1RiZ29FaHF6Um5xSUdkRlJjWkdTZHpJcFgrVmJHZng4?=
 =?utf-8?B?YnF5Qyt3dDc3T053VDY1ZlZmaGZLUHNDZStFOTF3aVl2MlNiVGRyeHBUNzVj?=
 =?utf-8?B?Z25vdm51N1ZDUUFYTnU0WEJFQVUyazY2djRFcEZHWU5rdXU3QUYyWEFGSC90?=
 =?utf-8?B?QUxDR1lWUDkwQjgwNnVxWERJTk95eWE4eWZ1ZC9CWnBaaEhINWtvT2drMVdo?=
 =?utf-8?B?TUhzZ1paNUZ1QmdSQ0VSbDZjTWJsL25tRzJpRW9xUGs1d2s3NE16cFJsa3lR?=
 =?utf-8?B?dG1oVktIU0dSN25mOEV5bmRqdEg2eldvR3JXQ0MwVUtCNkFLUzZ6LzVnM2to?=
 =?utf-8?B?enkzcHd5RWtrNWtJSVIyMjJ4WTRjWWNLQ2dhQ0hlNS8vbE5VNGY2VkVqM2h3?=
 =?utf-8?B?Ui9tU0s0UTRVdVluTjJ0Vy9SMjRTZ2E4Z2czT2RrN3FtaVFkSlJTL0F3dko4?=
 =?utf-8?B?d3Y5S3VCV3NPMC9IQktHdHBGSGIrTWN4NkpmUkYwS0M4RU9nSHptZnZvMVpC?=
 =?utf-8?B?VGxtMmxaekZmamI4VHhZUTFBbEJjL3Q4NWF4djdsR21MM20yZHRVT0lzcXVZ?=
 =?utf-8?B?Nmt6OFBDSDQ1SytQNjYzYy9laHhoOWFxSkd5bDFMMjkvTnRHVGdZTlpxMHNY?=
 =?utf-8?B?cyt6SVFtZ0VNOXdCVnV5OG1QckxXL1lzUytyNFpBWmp1S2NybEUyTDRubWE5?=
 =?utf-8?B?V0xXeVhObzd3aEo5aW85L0lLd1lVVDBJVnFHc2hLNW5sa3J6YW92cnJKNVU5?=
 =?utf-8?B?RFNxVm5MNU9iQ2llVmNrQjZHeEF1NG5od09OcG9EcTlSSStESjhwQ1NyTThn?=
 =?utf-8?B?N2x3S1JOQmd3NVFYdThKMmJJdXhpZmhzWi9rLzdUWGVMak5OSUV3UHV4cTlj?=
 =?utf-8?B?K3VGRjUwcElMV1QyWmdLdkljMVBqODRuMDJlNmVZUWpRTXh2d3RvZVVHNnpu?=
 =?utf-8?B?RnNQdGw3TmlPOEFBZlV1aXBMK0JzaWZCRFdDNU44blJxMVFYMTMvWk51dVNo?=
 =?utf-8?B?SXRPUnBDaXRmMUtPOGZibm9WL2c2OGlHWEkxL2ZIRXdMcnFjSU9oRnpwajlZ?=
 =?utf-8?B?cHdlelNxdU1Xemx0bWJRbUlTcVowM1Z5QmptYkVZaEJtTm9STkJqYWdKTFJ1?=
 =?utf-8?B?RHhJazZYMjdqNDV4SHlJYzJoSWxkSzdHcndnWEhhMnN2djBjU3JQNkdqa3pG?=
 =?utf-8?B?dWJ1M3F5Q0ZWa3RNVWx3U0ZtelhUSTRTRW1tTTlKSTlZcGFaK2ZNMFpkcFFX?=
 =?utf-8?B?QjlaNzk0Rld3SHEyT0xhdTZjNGo1MWF5cWVRMXpmOVJsem51ZTRJZlF4RHVj?=
 =?utf-8?B?RGF4Zi9oTFNScTdvSkpJeCtKT1VGdDlROTkzVWIrWG13Wm8wdlZ1L2FSYTBV?=
 =?utf-8?B?akQxdmFpaGFiZzNmek1GTzZsaVRzemhHQUFmQmxFRHkrK3hiQi9meUhHUGtI?=
 =?utf-8?B?QnBQT1JNTUJKQXNWL0dPWitNU0hheHBXTExOSHJKNldvZU83NnBVYUNYS2dM?=
 =?utf-8?B?dGtIODBtRE9XYVl4OUZSWUxoNzZSNUNmNGZURSthU2NrdUlVOW9jQnNYbDIz?=
 =?utf-8?B?ZUNpalRPcHMra2hrUkYzNWR0ZnhxS2JHMzR0aEZwZUdVREI1L2xlNUJtRlov?=
 =?utf-8?B?MVRpZGQ2NUphUjN4amJhTDJObjk3MHdERVdWWFVQS2VJVjdIVEpubzlZam5C?=
 =?utf-8?B?dkx6MmRXTlZLTUhDTEd2a3cxbC9QRTFrSXlDRDZQczNpcUxxcmp1SnJyL2pB?=
 =?utf-8?B?OFlsK0pKNGErYk1YTDJmZXM2MzcvR3JPYjJPK0x1RUx4ckJYaVRzL1p6OFI1?=
 =?utf-8?B?dFVoOFUycHVhSzgyZkdpQmFFbUNjeHdjajBTZWhHRFNvalpwUHJOUFgyTDdY?=
 =?utf-8?B?Q29zMm1PUVpEWVZZL3BtRnZHU0tNdlk2QmdHWTB0UFpGVU9aYmZEeHJaSHdQ?=
 =?utf-8?B?TDZKalhvU0pDeStabWhQaUpMOStyYk1mTE8zcTloUHFzYklKMDFqRHNqNTgx?=
 =?utf-8?B?KzRkWjRtYTZLUGFQc2ZqNnRVdzJ4WmRpTDlZSUovTi84SHlqbmIvU21tcm41?=
 =?utf-8?Q?S9kkYEsrg9CxmO3JDqliHHQOH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3305f0-bf15-49ce-7541-08dc8e9fb8d1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:33:03.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYO6PV6dE4JGc1J2IEPs1hgWaFzmiNs1Dja5amgzzX4jO8vFDplfH5EHpm5EfuGMYJf3bge91rZZ2Fhrz2Lh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 14 ++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..ca8958f28a83 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -146,6 +157,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c460afaa76f5..1725a243521d 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,14 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: ele-if@0 {
+			 compatible = "fsl,imx8ulp-se";
+			 reg = <0x0>;
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


