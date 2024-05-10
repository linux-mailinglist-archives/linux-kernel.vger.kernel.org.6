Return-Path: <linux-kernel+bounces-175498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036A8C2075
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71B6B2155C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705116F0FD;
	Fri, 10 May 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bpxQL7Vj"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B516F26E;
	Fri, 10 May 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332308; cv=fail; b=Nx9W31xAeY57buF47/Att7or+gLzuZoSpaV7OKNPCYV3C7Z0FjgjbooM43M80s+u7tOOIQCWYJga2Ibg8k/JaVkM8P9lwc8KXcGLhL09ue9nkDoiuExIyoP2D3HlGa7N4qn0XCJgBcLswkXhsrOdDb3YdEvGJBYmV1EruceQEUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332308; c=relaxed/simple;
	bh=NpLKDj2bR2AYu5BarkAuZ1JZZyhQ1dCIKBxwjN0NJpk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CnVh4nYpF+uB4DoW9F8nPm0x9aAsEtYOyD1hFPvspSr50QcafC0+H6W/kosiuFCjcPOYg1X8IDnsM8YC56FuyYgwY7lLoo2PJ0WLmQmPVtCBJE188h2U5og8uPeGlcutlj0cVTsZVpqaLVCMhvpL6v4EMIbLYGsCsYzGnTafHUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bpxQL7Vj; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU5RCdt/PmRcZNi02Nsm6dIXMXMHVnK9DMwvNyuUFgfFNpHqYlf7LlG3TQ/5F94u5td/jSGioSJatDwtxtbWTc1FQqdROpxuxpdLiwS7d1jW+Sd6Dum7oXYrVyKZ08JOXH96MgRuyh+/fkZEwd7l7Url2Gk8ZkPW6xDuO0BcTTwbvZJnFgpnXyYO2TzQ0AW3YAD263fZgETZPekEIhzYoq98+dNE+3E7PZ+PtWe64joIyvD1e/XFDOOBmIZzfC7C0vh3TyLXSe0eUUFVbEKAlOFR3PPUf9QIukPwRK92Vv6P0YRGzJUkqrRp+HNmLD02N3CdSzLJ6NYL9F+tscJr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORxscEgfrhyqeXLzsP1iuOAfxLe854CzM9Ki1bmQqRU=;
 b=esIRMwBA3qY3V22QTHvuJrbocik9Dz875s5Q49pvl8PRcxeRZICOEEy9vXs8sWBY3NfZglBk3PjTf95mLBXAu2MReufBniC2yuoPpWDLcXoK+8hi4l0xpBQEoVHLfVkYH7rqYETJESkHL08mNNVZ7wpXpY/aUNV1kcgHnwujEZSQgrBpWgmM33F/fXupmu834HWJtBWoHJXj7Fa1UgpXP86my0fJq8awQWxJi7KJybxawxWsfPMndMpjTPoTGohTUDm3X50/sGq4zgQ1YeLpreox3UMUt7aBmllu8xzpLYdzTu+mmypTbdiN1scKOmT0ST7Cwpw5S9V9q7dPCkRyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORxscEgfrhyqeXLzsP1iuOAfxLe854CzM9Ki1bmQqRU=;
 b=bpxQL7VjNuBKth3JruMHmiGTw9SeJYSREQT/HYDoRWa9lJbadD0noh62CTYrMu7S+KKajJngdTwu0nAzYPWDhCJevPUJezYCO0WiK3t2WIvWq5HGlxtJeIA8Pluby7ObCeI1mJlEduRlxKjXNGEGdQP9lbAVL9XTS51JzVoRgQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:11:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:02 +0800
Subject: [PATCH v2 07/17] clk: imx: imx8mp-audiomix: remove sdma root clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-7-c998f315d29c@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1166;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+hwTF+iFARn94W02HIxtvHHvb+ZjOrMdn+Wc7BgL+nE=;
 b=jTK86ch0OMtTE0L8NZP3bq8CC6/5R0BW2kyGjqFIWTkGovJZ4BOz9BfpL6vHpsq1kA586G8iX
 F+zd2BDHWI7BN28I9sC3wbeL2rwie0okB2Q6/3gxdnPdg3saoGCpWAy
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be1638c-5f27-4766-d350-08dc70d13640
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFcwemxuRkR4SWg1OHE5dkduaXJYRHdMUVI4VGpyNVlhYWd1ZDAwLzhtZnl3?=
 =?utf-8?B?czFQcnVPN1g5TkpWNXNpNUxqdTR1ZnJ2eWgwUmhwRkdxbWUrL3FPV2JwMXZC?=
 =?utf-8?B?UVN1SDI5Ni9RSnZTVnBlVnYxc3RPRTE5T1JSOFB3RkFTYitrSlZVV3p0a2hj?=
 =?utf-8?B?T3ZXNHE4TU11d09yNTlCZ20yVVpITlJTa3R1eHRwNWo1TjFDUW5sVGlBNU5S?=
 =?utf-8?B?cURBYmx4SEM2NUlUaGNZVmt6WXBLR0laMzN5cTU2NGl0Q0pwUXhrNTljSzlN?=
 =?utf-8?B?ZUphNWNla2UydHFycnFhaWJBOHh4TEJCQkppTksyTkw2a1pyaW5SSXFMK05p?=
 =?utf-8?B?Nk9JQU1BVkM4dTdza1hDVnNuMFozcFhoMm5tOVNCMDY1SU9GYXJqVHlneDhx?=
 =?utf-8?B?MnlOaEZHRFNXazVXdmMrNDcxU3RySnhYWDF2Tk05dVd1dTF1cHRDNms1dXFP?=
 =?utf-8?B?MW9TeGZGUXA1blJhYkRQOVR6OGxXSlJmVHpvOTE4a2xLa0NSRTUrRUJmYlpL?=
 =?utf-8?B?UTlpbGRvc2xleGtpMHJtY3duTGZNNU9BMWI4Nk1XbE9tdnZjMG9pYUFhZWZV?=
 =?utf-8?B?SUwzelpXZHZOYnVKUnpveWlvM1pEbmc1a2piREg5RlN5NmNBSFdEWmVLd1Fv?=
 =?utf-8?B?eUtLYjd6VUovUm9wUDJZRXdZYVl3b3R4OWtsMXdxbkNUMnkyelFRT3JWRDda?=
 =?utf-8?B?aDlvMEgzZ2t1T0VUbjg0RXk3b1E3T053V3YvbUI2d01yL2NrUEFlT3c2STY3?=
 =?utf-8?B?dDFIV1ZBMkRrbmlrQmY3dkxiVVFmWXZjaWFVVFg4UWF2NVppNTh6dUwxZStu?=
 =?utf-8?B?NHYzR3hxVGU5Vm9MbWpDTTdSNkhZMkFCNXVDam1LZGhpL0ZwcEwwNUJkekhV?=
 =?utf-8?B?dEdGL2x4bmt1cWhEOVN5WTRxVkUrb3FYaHQzZHpGaGQ2c2FMRkRnL3Nlc1pW?=
 =?utf-8?B?TDBBQjA0eDREazl4WmNCMHZEMjVtU0JvbWJsK2dYenNnKzkwRFN6UDUyMnBU?=
 =?utf-8?B?OWNCcW5ja3BqcndVNFBjVlNDdjdjek1DM0lIM0FRWEZ4b1gyUXlDSWRYazk2?=
 =?utf-8?B?Q3E4S0tGQjI5SE8wRVNvenV2SHNVd1FCTjIxQVpPTUJPWkVTVzlaYi9uMVF1?=
 =?utf-8?B?UHFJd1p4NE5NYjVCakZSOGtKYWJqOU8rVDhpMEppd0xtZGhyclNCUmJHckc0?=
 =?utf-8?B?VGltdjVKaWVlMkY3WW1XNElqYkpaRGRRTHV0cW4yRmpWZzFMNkp4cFRCd0Z0?=
 =?utf-8?B?dUtpSEhyU0xlR05OaU9xdUluYldhaE9uRXh3V2tOWjViZFh1SzNicVYwcnZL?=
 =?utf-8?B?dlo5aFdrWVEySmk4VHg4WDdEOXRjam1RRzdmRnk3RmdNdTd6QnN1THU0d2I2?=
 =?utf-8?B?YkdSWUt2K0hGRVV0U3hUUktiUVFNOCtmeFU5bFNONnM1bFh1UDBkajdNTjdk?=
 =?utf-8?B?cmN6UXRGUXlHd29QNkhWL1hVWVB3bzU1eFVaREtneWNyalpJSFRvL0tjeks2?=
 =?utf-8?B?c0F5SUZ5OUpPV3hUSWFyRFFnWHJzeGhIOGRaS21tenhFSENkN2hDazNOZ1Br?=
 =?utf-8?B?TzBrQWNlRTJoZld2bzBVR0p4S2E3cFJvMzRuZXpDMHptYVhORk95blAyeFdM?=
 =?utf-8?B?MXlCSVFxKzdBdUpFQ1lIR1FhWEFKaHNycnAyeWYwRGQ5U0ZFdE00UFBzZ05Q?=
 =?utf-8?B?S1JQSWptbGxzckgvcTJKZEtQMjVDakxxMC9udDQxaFZLci9OenBrM1VkbXF6?=
 =?utf-8?B?QXM4SVRjL0JWVmI5RFVpanF5NEtnd3haS2twelRXeGpjMzNVSXlFNHAvTmZE?=
 =?utf-8?Q?EjjxbrCG4NKWsiUGbr4dgudbwFMUQTkjRhyOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUhuREZIeUcvTS92MWJLcVJ0RDRMUHdVazg0eEt0dW96ZmNlMWZ5UCtuOEVB?=
 =?utf-8?B?cFo2aVRTQlViZUVxc3ZIWWxhWEhxdmlqV1RWV05rK25QMFdUWGJJSG5MR0pU?=
 =?utf-8?B?VW1jamV0YktHRnFKbzJHNFRBZUpHQTZad0g3Y1o1WGVSR3ovSkVEWDZyL0wz?=
 =?utf-8?B?RlBPT1o3YzdWSnhnL3JHQzgzMngvNWlwYURCdDVucmJDM1BSOEhtS2p1azFm?=
 =?utf-8?B?N1Z5Y2hMM2xZL0VNNVhERFRyb1gwUWNoYWtwSjRXdmx3Nnd6d1Q4SzRTNmZj?=
 =?utf-8?B?Y1NTelZPSmR4MDc1UGdHaDJGS3lrN2FtQjArVUl6S3FXYkxtNDhkZWdnb01O?=
 =?utf-8?B?MVpFd0tiZU5TbHE3YjZ3Y0d3UllpYXF5d2FIM0pteGFjVWkvZXpQb1phT1RQ?=
 =?utf-8?B?ZVlrbkxOT0JvbXRMWEFXRmJ5b1B3OU1sWEkrdlJiZFBoTGhWUUxacjhjeWs1?=
 =?utf-8?B?d2RJN2J4OVQ1bnprM2tHYWVrQ0NoS0xDRGpNYmxlQm9HNmo1bHlkRFUyY0VC?=
 =?utf-8?B?dzNwWVlMWVRObVZsV2ZCMDV0WG5VcUtKYkE5OEJWM2RjUFhvc1p5aU5kQUVI?=
 =?utf-8?B?aHorZm8wWmZHL2pYVHFmcEFad25henRIc3BFTEsxc21FT2VOZVpua3VuemJm?=
 =?utf-8?B?bFVORWVIaGdYUUdYZXFpVVltNDZuQUFpZE9jTDlMZUtWdUg0NFljQWh0aFYw?=
 =?utf-8?B?MkxqZ21zN21JTm4yeVk2UW1jaXNML2p2R0R2NDlQOGVJUVduSU55THp1dVc0?=
 =?utf-8?B?ZkNna1NRS3BlcVY0blExcDhROXVQYUNNWXlhb2dMWDNSRjJTK2xJeXpmS1lL?=
 =?utf-8?B?SzUxVzQvVS83NDhiaGFiZjFtU0RhRFVYa1Fab1B2WGJTQVNxOFVLUDRYT0Q0?=
 =?utf-8?B?VGZwbnU1d3NDYWRIcTdMZkI1VnBDdzVROG1mR3ZIeVY1Z2k2UDRoTmJsUXl1?=
 =?utf-8?B?eUVxRTJxY0F0TXVGSXlDNG9SM3VpYjlMeUN4ZGU5OVlhblpGa3J2UjNUdEYx?=
 =?utf-8?B?aTR2eXBDNVpTWHlLMTN3RWMrYnMyZjNKSEVXSVl6MmxQMXNzRkZ2elh3SVZt?=
 =?utf-8?B?cmZvTHRqOEZGNGpoWnlKUElRT3Z5Smh4UVhrdXd6YS9ZR1VaemFheXN0UDI0?=
 =?utf-8?B?RGJoOFpXUURnV3dkYlQvdVhiVlA3K2RmRnJlQ2UzQVRkRG1kNmw2dStEWXNQ?=
 =?utf-8?B?WGpPRnk0UzZnNktyU3Z6U2RaUkN0WVIzN3Q5b1NVbFZ1T1dWY2tlb0RKQ00x?=
 =?utf-8?B?dW5UYllYaVdNcFFpaWxjakZIeVFLYzIwYkJIWWtsNjJxdFN0enNoMzNvT1ZC?=
 =?utf-8?B?LzlXc1QrNklSWHlqR2V2K1UvMUlhZm5pWWs0NXFOcEhQOSsyRnNDZjY0Tkl6?=
 =?utf-8?B?ZVg2eHJoRWp5N0xPSThpQk03NVQ2a1lvclQwaGs4a0ZMY2NHYUJBd0grc1Zh?=
 =?utf-8?B?MlpucFNFZU5LbnE5eGpLNWJOM2Q5YXFvbFhUdHhlaUNOUmZVUXhPS1VFaURB?=
 =?utf-8?B?L1d6Ym1ycktpL1kzMGFNanF0aFoxVkVJKzB2M2RhOXJEcS9rL3NYTkQ3ZDY5?=
 =?utf-8?B?Y05qZzZGVmNUZitTdmhjbXdCd2IxbkxQbkpzMWd2RjlhVG1sUDhlbWo5ejdQ?=
 =?utf-8?B?S3M3T2sweFlOT09NQlZOaCtvaTNPVDFuS0lVam5STnRKM3ZBTk5pazdiLzhx?=
 =?utf-8?B?dHF0UDh5NHE3cEtJcTdXS0poakMyODVWNFI1ODlUUUlkN1hnYXRCWjBNYmJZ?=
 =?utf-8?B?UFpsMmdQQnAzbCsrbHlnUTI3SGovRXZGY3FsSEo3d0JzUE9WNjZ0c3lBazlB?=
 =?utf-8?B?Wjcxb0pnL0REZWlMRi9JYVhJVE5kTi81aDZXS214TFo5Z1hUSklsMzcxNHFy?=
 =?utf-8?B?YjlNS1BuOVlZR2lpTzdILzhCUU52eTI0c2haOXg4MWlpcXVnSzlBaXlEaEd5?=
 =?utf-8?B?VlJycnBFWHN3OUxwTFBtN054VHU0cTVZUHcybDQ3L1JPTi9BcFZzUVdNQk5Q?=
 =?utf-8?B?OGRhOVpseExzUDM2aGhHalJVM3FUd2RtcENEeUhlVUlpYXZiWGV4eUNPZjY4?=
 =?utf-8?B?dHA2b0hPTlY4a1Z2SlpYaHU5K0pVNG92Znc4azRLb2c1OU9Pb1VZU3F0WTMx?=
 =?utf-8?Q?7u7NMOUVPM42vsJ4GisrBWat7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be1638c-5f27-4766-d350-08dc70d13640
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:44.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31RrC/fWOgHF1k3x+aYVEXXWiNWdAW8asmUk1i1JyovQzWvXWL2r8YrTCGe3MZtuWDiDvo2FX6UObfGCaALsTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Peng Fan <peng.fan@nxp.com>

There is an issue:
SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2] (bit-26) to 1

The workaround is:
As the reset state of AUDIOMIX_CLKEN0[SDMA2] is enabled,
we just need to keep it on as reset state, don't touch it
in kernel, then every thing is same as before, if we register
the clock in clk-audiomix, then kernel will try to disable
it in idle.

Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..88d8ba975b5a 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -172,7 +172,6 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("ocrama", OCRAMA_IPG),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
 	CLK_GATE("earc_phy", EARC_PHY),
-	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
 	CLK_GATE("dsp", DSP_ROOT),

-- 
2.37.1


