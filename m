Return-Path: <linux-kernel+bounces-175497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960A8C2072
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0961C20399
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143416F0CF;
	Fri, 10 May 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Yb+SkZFH"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3D16EC01;
	Fri, 10 May 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332302; cv=fail; b=INXLzhmeh55Lpim6Gkl59cjBaNjqN4IubnH8BRisPYfiv7Tb1mRt2Y0dIsYOyB4tAlbeycPT2QnaMSUs5YhtI0mCH5+NdK9OnYg8kBkvKeawo5Lo8WNtV8LuZPgMzrvhFOk6PVbfXU567ZH1BbVhKukt5+RQo+GCegjDOxy76Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332302; c=relaxed/simple;
	bh=NAgjteHG4/XOhS80XUlWTWBcJsUzWYrufgmpN9Vk3nI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uzIhGuUGod9axjbQF+6iZ2yqDsfpg933nbOtHVkSFFkiTcQDZoqhj5+cZLwHFXutfqgp+843hvsj6jHzlddwWqD7DPf+vZmcceFLwm9uBhkhMRWY+rPCpkfuXwYVjxh/m/utYV1UZ9koNg/ZEpq6QBY4JnTprmPxMUwPvKYFTXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Yb+SkZFH; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvD23eFHEp1CpAlImtDBLEDDkEyWKb++FBKdvWUigVeuT8cY9zW0GAAtjXrkrC1pKxhUDzd9/76zHXpCOiRgNjoQg3NB9L9yIaiS4FUHsEvgkQ6CyqAO2zdd62oqGMGiMdo154tCfrb4P213B39xxQTLOOrjEiEkwkZqn55N7JutAI7O+4D4q75GVYCi1asTgCvY/sRjKPTUHHOR3MjekPNTqmG817pzSgqK2xzzhG4QBAOp/m86MrRTliTgHJ1UTiFFpdsSGxreF1zN22+qIL0RUupakGZKsdgKtY4jusLuOzRgeRkqIWSE1AM/Foq5ZUE75D08dZoZaXxPm8IMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3Dlal46WwJP6HqnyaAJPochMMZl48zjLeMC6YUUWjg=;
 b=OoRlfxiDQ8OR7DPE2a5jnLhbVf5qih2JQ14S8htwpAs93F7c/Qyovg26c37kfp7RoZyw/3VBNgUdZ4o9OaF305UQMRXuMKKPHCdoeuLCb2nwglWtBaolAQVSYiwgTNweD2VuPkYcvWvz1gD0y8LfqFDql6r8BnPcqhfLMxcKMKFp+DYSN9qaznBZwkYUPplqD60EZu9hiXSnji2hPQhMxWd/9eEJJEzujDreOpDsqfD9tR62rUYx4ztJHjSIs8p/NZ/m/UMd2PgmmVwIz4ZuWdJsWVTmm5YqvXifPbGbu4Nt7dPx28xieMGp8/jeGypbn/+5+yDcMCeMLBNiT+o3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Dlal46WwJP6HqnyaAJPochMMZl48zjLeMC6YUUWjg=;
 b=Yb+SkZFHdqKg58JY9UN7VsYLa84LqKCola3UDUPwknYvun/dogOUPy44PdG89xJoJpKZHp/ptyrhi6oYir0sCwERnsF8uOt1vVzNwnOLv8C4IZsWVJaQ1EEXvSQv/0DsRm4Euh6POsF+6HqMCBfjiTx6up+ENnzMHLGXyBM4Si4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 09:11:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:01 +0800
Subject: [PATCH v2 06/17] clk: imx: pll14xx: use rate_table for audio plls
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-6-c998f315d29c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1433;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VsebgP4ftghgfa/u4sGy9l2KDwyNnhs9lAuDW9Fh9Wk=;
 b=UN9WZcRDCVBEgeLr4ui+QDnFiJ45asLTj62i33qK8w59s2TKD1Pc+TWSA0wng6IIWGVTqfpMS
 kXR3duCCKrPDScWQFOdRCrXS/el2Ykof06qtfPEgLmQsmFbe12coYpc
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA1PR04MB10399:EE_
X-MS-Office365-Filtering-Correlation-Id: 017fc95d-fa6a-44a8-e748-08dc70d1326f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGNIMFRGODV1RGgrdm9veXRvaiszWi9MeUN4OGVvS2I2Q0FhZm03ekU2T2JG?=
 =?utf-8?B?NStQZ2xYdkFEaHdPcXMxS3JVWDlVZW9DeThBbzJWeFo1amdueDZUam5HV1lZ?=
 =?utf-8?B?dGFROG53TUhBdC9lMUJObHh6bmRlbzNyN0JoU2VKWWM1YllKaVZPNnpVUjFk?=
 =?utf-8?B?TGlsOHJNckNFYVRjazBINjN0cFdxV2JpeFRBK1FOaU9EZVlRUzZTMDdWM25m?=
 =?utf-8?B?QnR4dURlVDd3N0VKSzJXNVN0SUx4ZFhXdkl1R1hhLzlQZFNrZUdSTVdxTHNw?=
 =?utf-8?B?ZDFhd0ovNGxRM0drTjE1bzROVkdicGRDbHJwVHFpczhJaUVVSzFDcWdqK2tV?=
 =?utf-8?B?elB3YnNmSjNQN2ttc2pITVRsVDA3U0d5U0NyT0kxSjZ1bmQ1OGFmMERIZTJy?=
 =?utf-8?B?TUVuVXFTUlRqODI4Q3QxSTNQa3lhbEgwMDZkcXExRjN0bkp2R3JBZGpNZnd4?=
 =?utf-8?B?N0pld0xzSEtDdEs0ajBXWjdJeG94UEFsQnJWOWQramNFeHNOMG5MUjBJVjNT?=
 =?utf-8?B?UlVIa0tHOHBPOVhhV21SaTcwNk9wbDZJb09oSXZHL3AyZS8ra29tYld1eHpw?=
 =?utf-8?B?TGp0WnYyeVFoZmlkNWUwdWNyaEtyWmY5bW5VeTVRTGlaZjRQYWIycHlpcFRl?=
 =?utf-8?B?M0VTSnVSLzRvSGRuUlMyV1pmNVRyMTllT24xS2MwdFVNQy9sb3h4TTk2MWRN?=
 =?utf-8?B?UWRLSEpGeXVPQXlLYmpuVnMyU25VbVU1c1lCOHVza25mVGRDSWJoTmVwT0V1?=
 =?utf-8?B?cm5JdUhiS25RNjhsN1FJQ2RwaUpDRE9zeE1vSTB2Z04xWFR1cjl4NHFOeFE1?=
 =?utf-8?B?SDJvUC9JL0xERzRjQlY1WEp4eVk0MHladU1VUnI4Mmt3a2dBbEVPcEQvci8v?=
 =?utf-8?B?bEZLY0pROEc0bTRaM0M0S3NHVVZpdlk0azF3MjlETWgrM2M3NVk5UGQyVXMr?=
 =?utf-8?B?M3RDWGtabEl0OTlzWjlXN054UWhjTldkRVFTYXlJcW9sc25XQlFCbW9wRlRz?=
 =?utf-8?B?cHdNblpqQ3F5QU12N2JzenVsQmJjQnFvN0FzSmc1YVl6UVVRNldWMWM0Y1VL?=
 =?utf-8?B?M1FhanpGaS8wZEVkL2hVaEwvK1l2aGI3NkRNRmVGaVRnY2tuSkxQMnY1SjJR?=
 =?utf-8?B?a2NMRkk4dHZ4YldWRWhWalJ2OS9PaUpLSnFIZE0wRjhVcHNFcnAvUitPWFVz?=
 =?utf-8?B?bWFHdHMzdEd6VnpPQTNZS1dSbUl3N00vZC9sSE9qdzV4MFlZWXNiMDhTenVI?=
 =?utf-8?B?WGhKWUhxWHR2ZXh1SEdXRGwra0pLaXh4SmhFcEc2alpCekt0UzNVR0tqeE94?=
 =?utf-8?B?N21jbytTTzFsS3pZUXEva21sZjQ0emU1WmxFRTlhYzBvT05TaENUaWh3Qk5G?=
 =?utf-8?B?bzZSc1BMdTB6SUQ1RlJ0RmFUN21reGdINWlvS1RNR2duQitlTG1uK0xmN1c4?=
 =?utf-8?B?MzZvMXp4NFBPbWNKaS9zT213RnpGNFl4SU1HbVRSYWRpN0VkeDFUdG1Ra3ZY?=
 =?utf-8?B?a0RzNTlwL2dtTzJpY3AwY2JHb0xVSWJ2bndzSXcrQ0xWWUtubjRwKzA0SjJq?=
 =?utf-8?B?NW5YcVd5ZUMzSTIzVGIxNElFSmphTHdKYndWNFdoeGNTU2NKSUdNeit0V0dK?=
 =?utf-8?B?eDMxdVhRK1RHTkk4RnB4Tk5HZFVVSjJ3UTVadWRsTktlWUJRUFpHOFVjOGtC?=
 =?utf-8?B?NVFlTjdhSnNEM1YxV05xWS9wMmI0VXJ0N0RrWG5qTzZvSmZWYnRKcE9rSEdw?=
 =?utf-8?B?M05idFlIeVRsV1F0bmZId2E2SHEwK04yQkFnSGhrcGtFRE9GOUxPamprWGFy?=
 =?utf-8?Q?Qhr81NolUSiVmvkNLaLbSKPsG+ZagOOU4M6HM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWtOQThnakxCVXAxUWlYMi9YOFhxVWdyT2trQUpkYk12VUNUNUtBMnhpSjlm?=
 =?utf-8?B?ZDk4OUV2cW5vNkJPZHVMeTRzQlZkT3k4UGJSMjgvMmFVeklHZ28yUDdjMHBn?=
 =?utf-8?B?SVI3TXZDd0lIWVZXS29pODB2aUVwTk5aSVdLRkFUdUJZbUZJcDJBRzBuNmtq?=
 =?utf-8?B?TlNteGRHaERlK3dzVnJSc0JaRytrTFFtVVYwUWs1WnJncE1IVXdINWZiRFE2?=
 =?utf-8?B?bU02eTJ6VDNLb1lSUmlEVG9PWEhsaFVocWJRSHlPbWRvZWU4bzAxaU43N3ZM?=
 =?utf-8?B?Z1FkWWZ1eXkrMlVJeDd5VHZSUi9CUE5wNU9rSXBsUGFkRHFzLzQyUWQ5MXZP?=
 =?utf-8?B?MnloMW5LOTJ1Q3d2TTBwK2dQWStqOEZuQXZxcS9tRHlTRkhxVDFyenFqaEs2?=
 =?utf-8?B?d0NPTE1wbUVQdEJ0RW54SUJTNHJUMzNVQTZnV3dCT1B2U0w5bmtXcS9yQ3Vv?=
 =?utf-8?B?SmlBUE5rdEpnMTZlMndkcDE5VzZQcXRqM3FucXhQY2Flc3doblVJVHRPdEZl?=
 =?utf-8?B?WW9zKzlmeGdIdjR1Znd0bXdXWUMrSFMwVTNQME9tdDdHZ3MwSDdGaVFEQk0z?=
 =?utf-8?B?amJVSXV2eTFNUk83K3g3RDhPSjFIWWxEazJsWE9Ua3B1NW4yTXFQVGZ0T2M4?=
 =?utf-8?B?akRjeE42MVhCaGVmWDJ6eFY0VjFRenhHWFhnTE9yMTVVODY5ckVaRXFSbjRW?=
 =?utf-8?B?dXVKNFJUNGMrRlJsT1Q0Z1cvQ2JvRStxZU1vaWNGeGFmcUdDNHYrVEZlTUM5?=
 =?utf-8?B?bXdlYlZMM2I2ei9hSGlFUHZUY1lWSStNWld5SHpvb0MrVnpGOXFaM0xaSXlZ?=
 =?utf-8?B?MFA5Rk9YMnBsY0pJMmhxMW1Fakd6V2NMRUJhZTQwODJneC9TS09vRERtYTJ6?=
 =?utf-8?B?bzR3QkVRdVBFYzdWTmVBRGxscDlkZHlMK3pqNVlDb0VTdlJtQWQrdlVpMDZG?=
 =?utf-8?B?UmRUdWhlK1gxWVNHajBvSEkvOGVVMjNQdk9Ld0JnMXhPdXVTcjMwZWkySWxQ?=
 =?utf-8?B?Mk54TitDeGU0WUlEaWxDK25aQVFoS0dxR3Vrd09XeEtGWklNMnBGdkJsY1Bs?=
 =?utf-8?B?QUJNZnlhQWhpMTR6alF6ZGYxUkZxRytoK3VaRmtFaVgrMnVVM2ZwMXNFbmhx?=
 =?utf-8?B?bzlyOUdyS1AwSGI5Tjc4bUtWc1NkZEp4QTJvMkpDUkRGamIvQkc1WHZJS0Vv?=
 =?utf-8?B?dGVQb080c1Q2SGxBVnpuQ0RWUmdpV3IwSkR5Nms2SWppZ3pYZUU4VE1Hcm5H?=
 =?utf-8?B?cDNKYXcxdVlYck1SdXNveVZhNmNYdnpEMU1IZzlVeWVyUUlEQnNtTkM1QUVw?=
 =?utf-8?B?TFZ4K1IvV0NCOUJxWXVWMkJ6eW14MDkybm1UNTJMdDhOYVRiNWIycld5RVk2?=
 =?utf-8?B?SzIrbWhnUmpaR2RiQ3NQQ1JhRkkrU3hhY0MvZjVtVGkxTHkrWUdJNGV6dzRs?=
 =?utf-8?B?WXk5L2V1QjQ2ZkFHZHlyazZXL0VtY3hRb0tYVFlZRnoxemxETklVcUpnMWc4?=
 =?utf-8?B?dmVxbjFwL1hLYXlIaWdhMW1GMnVRdnNjZjhqc0R1dVA3MEl3clZVQkN3aGhQ?=
 =?utf-8?B?aFBBMy82MytWUFRxN1FRNDdsMStDUnJPTWp0dHhwOTNlQnlHN05kMXkxMC92?=
 =?utf-8?B?YThkRW1BUDJPZnlMOHRSMFltNUthOVF2RWtydjhzY3lKNzMvWUMxRHVROUFR?=
 =?utf-8?B?aXdxVWNhMFFFK3FZVG03aU9lU04wZERvRDN5Y2tCSmNCTjJtL2d5VTZnVFJo?=
 =?utf-8?B?NWFtaFdNemhIRVpteHNaMjBvc3FxMUVUY001T3RnMW9LODJCU21IQmZJa09s?=
 =?utf-8?B?eHlVZ1J4Y3FyTjVZRUhZUVQrR0RTNW9kOU45emdsRHhDWFNEenZmY0lvbGMy?=
 =?utf-8?B?Mjd2YkFLcmsxMVZHbmN6OVpjUTdpQWlrVXU0SFRvSG1sbWRQaTAxem9kWVZo?=
 =?utf-8?B?M1pmbTlYN0lZdUY0d3NVVkdXSFUxbWd1cDFkTXFPaTFQUks2UUdJd1NUWG4v?=
 =?utf-8?B?clpJQ1h4RlVrclpXZHZsbWR4V0l3OWMxekFtbDNnNUE0L2JIU0lDalJ3MW1G?=
 =?utf-8?B?Q2s4Q0k5dXVQdm9iRkxNWGtaZGJDY2Z3WXNkU3Rwa0tqWXZPSVJIWU1SU2ZY?=
 =?utf-8?Q?eFOGobyLZ3EcWa/s66jq0+I8W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017fc95d-fa6a-44a8-e748-08dc70d1326f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:37.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL1CQZWyHxdrPcFoqfen76uq5JLT74sdGFyaclGQXqudOor2pDGOjnU3NEWqwuY0OJUOVTChNAnIIGFCDVuC/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The generated clock frequency may not accurate, for example
the expected rate is 361267200U, but result is 361267199U.
Add rate_table for audio clocks to avoid such issue.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 55812bfb9ec2..6b2c849f8b71 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -64,6 +64,17 @@ static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
 	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
+	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
+	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
+	PLL_1443X_RATE(245760000U, 328, 4, 3, 0xae15),
+	PLL_1443X_RATE(225792000U, 226, 3, 3, 0xcac1),
+	PLL_1443X_RATE(122880000U, 328, 4, 4, 0xae15),
+	PLL_1443X_RATE(112896000U, 226, 3, 4, 0xcac1),
+	PLL_1443X_RATE(61440000U, 328, 4, 5, 0xae15),
+	PLL_1443X_RATE(56448000U, 226, 3, 5, 0xcac1),
+	PLL_1443X_RATE(49152000U, 393, 3, 6, 0x374c),
+	PLL_1443X_RATE(45158400U, 241, 2, 6, 0xd845),
+	PLL_1443X_RATE(40960000U, 109, 1, 6, 0x3a07),
 };
 
 struct imx_pll14xx_clk imx_1443x_pll = {

-- 
2.37.1


