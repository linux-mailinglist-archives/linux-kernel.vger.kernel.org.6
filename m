Return-Path: <linux-kernel+bounces-175507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ED68C208A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEAA1F20FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5217106C;
	Fri, 10 May 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KkiBkxKw"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637716C684;
	Fri, 10 May 2024 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332354; cv=fail; b=XtE8u99WSB/KsiFDdVYlc6a3y840s82jBsB7t/RqOlOw8JedaOTdFs7JHHjmW5poj8GmP3tr+XqlfaFJSdIp1wq1AGBdALxKJkXwys3X/eefAu8Hbf9E493VcMw7lQakFtfcxHSd3gw1O/5Q1WTX1JhaI+6202xYHQgmWJ+V7qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332354; c=relaxed/simple;
	bh=8W0rPna3emTHoikPkLr5ePnGBoEpKuE0aOZ8ALmooP8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MsdplDLv+1b+KpL1m9kjuHyJvxDDt/F96US/mn9vJOPzY46RIIHjHWHuwcJQ1WJZ9YSpcj2theTLNT1celZRjznC/tqRkVaLJS/VIiOnEzSudOnmmaYqI7Isn0aFRiuCyM10Et57YHvLVUq+acbbSv/gdRdp8EaDB7dmlJTovY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KkiBkxKw; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej7gc2PMD44vrbKSFGHDv93cixHPTa4qLp33u3pbGncXM8+NySxUDkYgJIJaOfXrygaWo0U/Rbh7W0gxxfDgQAf7AdfVKKkwjqd/s5LjmwDCofSIQxE9+BObHidT/fZeLK525utee4H049hISFpGT1R8c3ZSDdAGsYvqEDtjlAtvhNfT7Yg6fmnV52cX5T/wU6sae56IIh2LQpbSX9YifgDbCBuFzP9nBs70eL7hKW20KGSMaP9dRHWE6LXafczm6ncviyHT0/jt3n/e1CLuTtRWJurQRdUngmAzH8fOveRy3JBq+9wqCRg3/ZbS+oS7VMM3x8TT+YwQSDg30WmobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY/GT1ELAKVfVDNbLWCrDVrGzIpKnzihRrdLfAvUxdE=;
 b=HnGh+qndCE1asJ3s1j11ENiMXn/lqrkFRJ3xMWK5LAzd7LCkYQLyLB89YN7hWujn4feaz/++e0clC627IFvV4zuwAFHrKbDwEo85x1SSzXKC9+w0u7SWKvsyXwAEbY8a6Ric2hwC/k2d60iVb1vfwm+2mt6hAdjQ1CAZcxC9aglzNjR4O7HfvDPmxas5QWogG1Ob+F9Ofd2ReIWqf8thWlkm6PLxYitfcOD5XpHN/9sLrLGtZa8vGmbcTpN5v+0lL6UHsUIqJanptgOHxZC1QsvCDuHVToTctkspqTsv0yYLAL8vBxL18dq6tyocgrBtXf+F8JDZ/YVeKH6jmM9Ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY/GT1ELAKVfVDNbLWCrDVrGzIpKnzihRrdLfAvUxdE=;
 b=KkiBkxKwanTo+vtXl6mDv/jtBNW6p3FhwcVgin2hsW2TvD4riqLuvZrviRy98vdj9t8eTpDumOLuDAypS9GRvbCy1uyYBc7UaODYa01bsJv0vGlvjG4S1c+c5sHKAn36jqRChSqN36A1Yz6zxtmA+3AKkIeVmDg1Aw/7saPeeCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:12:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:10 +0800
Subject: [PATCH v2 15/17] clk: imx: imx8qxp: Register dc0_bypass0_clk
 before disp clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-15-c998f315d29c@nxp.com>
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
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1742;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/aYZoW8KghW9QdRWN1taneDgZ0S6szdiimpOLxZFTlY=;
 b=TG5sK2y1TFPLysKYrlukXdzb1kYpaV3z4zljJImbEh5LLXJW0bua1Wp9GmSo6TE1hcuglyUN+
 7C7RJzrR8R8Dd8xmKnPJvzIEH+LC0vxSQ0HvkNecqwYN3m/NnADLNUe
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
X-MS-Office365-Filtering-Correlation-Id: a8bb070d-e19d-4a83-f108-08dc70d15138
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3F2S0Y0VzJIbFZBcHRPdUllVjMwMzIveldHSnNYeGJOZ21mSEpXeFZVbnBG?=
 =?utf-8?B?SXdUVWxnUFpNTzd2ZjMxZFpsS1NuRlhzWkdSOGVnQnZXMGZuMWFISGladVVC?=
 =?utf-8?B?aHJVbUszRnVoNThENjdqWVIwUW5HRTduWWlMVlg3SlBQWkhqakZuWTRHUytY?=
 =?utf-8?B?eTg0VUYrd3g2M1ZXSHoramxVWVhkNExmdzU3OTNpTkFiL1J4U08vNXF6dVBv?=
 =?utf-8?B?SWhweFRDR3hXMVkveEtKZ2poOFRLQkd6a0N6QnlHTVNNZG9zQW1FVjhnT1JP?=
 =?utf-8?B?Zjh2UmFYV0IrQ2ZhVzNaZzdBa01DTzlnamRaMmFyTmcyU0VsK3R3VjdJRExK?=
 =?utf-8?B?YVVaVG9uUklGSkpRd0JaSmFGMGhULzhxT0hSOE5udThWN1pDWkJzYjBYbjNO?=
 =?utf-8?B?Y3BtSkgyZ0t2eFNrc3lRNXBYMFMwdWxGM2JUcGdKVm9IL2doNnM1T2h4ZXU4?=
 =?utf-8?B?eldxZnZobHpIbDNtSWVaajJENmlDblpWWmV4cWlORzc4Qm5GZEZxTjduOXR1?=
 =?utf-8?B?UlF5d3FsTFRmYzFza0FkdFRCWWtRa0tTVVFLcGtRUGJsU3k1YUczUUVCSTls?=
 =?utf-8?B?a1hsNlpoOWhZMzdpdHVyU3BqTHFST0ZNZThpWTYzaFJORnBRMTByN3hxTVRK?=
 =?utf-8?B?N1haZW1oUFNPNjFPWHFyVVJ2b0JyWi82NXU1Qk1sYWFnc1BrZGtzbzVlOVpX?=
 =?utf-8?B?TzROQjNvZ2l0MUpzUDFHMVNZY3NMK1ZXamFiV2NFeVJNVkNvQm9zQ3VLRTN4?=
 =?utf-8?B?MlAySnhZS1BDR2MxbGVnK0ptTXg4eFYzd2RwQU16U01BTFZJUDl1RSs2MHNF?=
 =?utf-8?B?NzQvRHZob3pvV1NKMEpGMUlsVW9Ydzlodzd5NXZUY25kVXhFKzFKWXdaNWRn?=
 =?utf-8?B?ZXRLR09WS3FnZjI0K2tsVUxSNkRPQ25YUDkzcFBmUnh6NHJ6aHQ4cVRyc3pY?=
 =?utf-8?B?eTc1bklHaElwcFltVDdZcGtaK05WWVpCYm1EUXlxNVZ0YjhZOWxrbFJ2SUpY?=
 =?utf-8?B?Sm5LOTVNdk9NaUU0THJUQWtrNXdmMVdNREt1NVZzQVRxQlNtM0xOYTUzVy8w?=
 =?utf-8?B?bnlHZWhNWDgxUkplV2xQazVnOFAvazlPMTE4NHN3MytYTTNicC9EYks3bGUy?=
 =?utf-8?B?Z3hyN1lHR01IcXoya3IwOW5OaGd0alM1Q3dncDRWTmh0ZEMrYUNuSGVxYUxn?=
 =?utf-8?B?aTdnRUdackNSZkxVZnVpUmhPa1NIRU5IL0dsalZVNTJiem9TZmdwM1NjMEtT?=
 =?utf-8?B?MHBSUjJkamNlSDFndUdCeG5aT3gyeVQzU3Nmci8wMkoyU2hBVzkwRVZpWGRl?=
 =?utf-8?B?aVA2eis4R0hMdjFzcnJxRlRqaXVwZlRyMFR1M3BoMHkvNDdjdUJsQjZNRVlP?=
 =?utf-8?B?TEhxK2RINmptUmllL3dnNTJ2ZERSTlJyMG5BblhVNUU2UldNVzYzdVRkdWp4?=
 =?utf-8?B?c3JBM2pobm4vaG5vN2JRNVY3cnUvYURLVWYyZzJ6VWRNVEh2bUJOQ0RyeEQ2?=
 =?utf-8?B?VDNLNXRLWFE1VDlmR2VHbmhNVi9DWHVRU1l3VE1tWk8zc1E4Q3owd21RS01z?=
 =?utf-8?B?Z3RCQnkyWUxFNGZ5ZHRxdTBWcmpNZnNvOE4vNDE3dURxSXd1YjduM294YW5G?=
 =?utf-8?B?SEVOaVJYc1BnT1drd2J4S1VZS09GbWxhZ1lOQmRLNGFkalpXS2lEYk5rWFZP?=
 =?utf-8?B?TlB6UTBnZnZsMWx2NFlFWHZTeEdkR2pBVk50Mml6c2hwZTVmYk90bnd2L1FK?=
 =?utf-8?B?MElRVStxS1kyNEFOelhJMEpCTVVyS1RicklLU3VxcDNUeFBtVkpEekhPdk5O?=
 =?utf-8?Q?q3o0m1PUJJZJVhYqAgw4WUMGLhOnWZOis0BAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXhzd1hDQy8vR0Y3Z05mc2FHYUt0ZDRlbGRXS3YyYnFLa1RVTDdqMFJzdGJ1?=
 =?utf-8?B?Qi9meEMyWDY2SW1nMklDZG84ZDQ5ZGY4YVZrbDZ4cklXTmJqbXRGNmxJSjZS?=
 =?utf-8?B?R2QwVDVQWDIreVVMMVMyQ2dmTHBxNU53bzI0OEg3Rk5SYzB5K1drUTBjZERB?=
 =?utf-8?B?UEpuQmE2OFJRdk43ekFScytreng2N2MrYkJPZ1lyMHo4eHNXOHBFaE9tQXVR?=
 =?utf-8?B?MWVBRE9kdmdoeWpsQU1CZW1XSGd4cnpBMlg5U1RlYlJCV2ttSGtKVW5qVlRH?=
 =?utf-8?B?dnBRYTFnVVJHajJySk9aYmhqTk5GK25FQ0xXTE1pbTU4b0hRWmE0ejFQbDJQ?=
 =?utf-8?B?VU9NMm9qMy9pcVdvZWY5WTlCWlpoVEFWSzV6YXJJRmdyNjIyVTR4eElMc1FF?=
 =?utf-8?B?dkRobXFPTFRCRS9YcklHUzBKWjJOQ2tybmV0Y3l4aGxqQUJIMVhyMitvQ01n?=
 =?utf-8?B?NW5RN0JJbUlZSnBNcEZoNUt0RnVnU2piTmQ2TkRCZzFxQzdoYStDQ1RWc2Ix?=
 =?utf-8?B?T3dlRVcvRVJSUmRnQ200ekZ2NXNtRysvbEI4VTdDM1dIMEY0TU5YaTVsSGxz?=
 =?utf-8?B?UndibFl2ajZqNzczS1grSk4zZmRzWUxQcWg0amg0YW94RTAwbWJTcDl5TzVs?=
 =?utf-8?B?VCt2aUxneHhhR29IMkNualFHWXd2bmkrTXM4WWJhQ2xDL2kxTmp5TTE5Q2VE?=
 =?utf-8?B?eTB3Z2Erb2lIclBOWDNqdnY0WVE4dkl2MHYvM0xWb25tcXo2U3BaMC9LVWsw?=
 =?utf-8?B?Uk9qVWduTjNVR01ZZTV2QTRSNUtQSk1ycGNHc2hLL0Qzd2todkNVdDRNZ3Za?=
 =?utf-8?B?bGtRb0pDeC9kTnBEcE1jUlgycDNoZVBkbHRaYTFsODdiRitmRDBwckF4QXND?=
 =?utf-8?B?NTVSVXJwWHVQa0x4Qm9Od0s1YzVTM0ZaQ0w1aUk2U1dFMnV4c255SkRZY21G?=
 =?utf-8?B?cUdRYXJlamV3SlVMNm9jZHN4YjJRWkY2aFdsb3NHbzVCK29oS2VjR1FaWW1V?=
 =?utf-8?B?ZkljSHc1Tko4QlA5M1dBbEEzQWlBVnFIbE81bEtvK05sV285bFZkUW5CWlpD?=
 =?utf-8?B?WHU2ZmN4UVU3eEpNSXN6d1Jia29SZFFzNzc3a0NyUVNzY09UdC90ejBEZXVD?=
 =?utf-8?B?aUNtemhuenBHSjIrbCtXK3lsb0p2QWdqV3VFeHRoK2VNSGhjYy9QSXZkdVVz?=
 =?utf-8?B?UHdxRUJYQmxrWTI1UjkzSE1sTTFscm1MRy9La1A1ZnJnQU1PY0JqSFVLNy9M?=
 =?utf-8?B?V2JRUzBpazNTa014VkdXYmdRNlhEOHdTQ1B6ei91K1NFT05HUW0yTE9NcjA3?=
 =?utf-8?B?OG5pV3BvTWphWnJtdUpSY016aVBYbk9IdXczenRCVDAwVGRoSDVDMFBMOWtp?=
 =?utf-8?B?eWUrVlRMczBUcWtWME9ybHRBenpFZEh6TTBkMElaOXZhRWFZSWVybHNGbk1M?=
 =?utf-8?B?N2dxYXh1RUVyQThFSUxGS3AySHNZaFFHTVJrYm1KS3BYZ1Z0NmVOZjE4b29i?=
 =?utf-8?B?ajl2UEcxSTV6bEh4bTdiNzdCdVI3dEM2dzBKM3J6TGVrTWpqZEhnZzBQZkZI?=
 =?utf-8?B?VE9wUEx6U1pCNnVoa3ZKcUJVc2RuaVl2T2Q5WDkvbTEvN0x6UUxGa21BS05T?=
 =?utf-8?B?TTJJRldPTnZVM3hMZVk1Wll2c3J2Mm9RclJNcUNtUk5wQWlhWU1Da3NhSXhu?=
 =?utf-8?B?T3lYUlc0ejRCeG1zUFdEb1JoMWtPWVl0anlTeFlHcHg5bERvc2FhMEp4dlZs?=
 =?utf-8?B?Z2dwa1oxdU56eUw5SGowYWtzMkJtKzJ5Si9KYkxGRkQ2UXZjbllTTkxWNWY0?=
 =?utf-8?B?R3FoZERoaGR6TjRDMVdqMis4RzV4Q25kN0xGb1RPYlc2UmZ6WnQ5UXN6VDRK?=
 =?utf-8?B?bEpvczdsdTV3Z2ZRNUwzRUNYZTUzN1VqSkorTEc1b29xOFMzQkhJTjlyZ0Js?=
 =?utf-8?B?bC9hZ2NZQXlpWEFVbDQ1UW5CR1FWSGRLK0QxY1RTY0JtNlpHN2orZ2FBRHNm?=
 =?utf-8?B?bXc5NVlja2pyMkoycmxQcUcxUW5yc0VnTUxtZmdzeFQ2eXhhbC9TaTZqbjBP?=
 =?utf-8?B?RW53UUczRjB5R0hCUkFCMjNlYlZ4TVpvcFpFbWhUbW5ycTM2am5URDN3UjNX?=
 =?utf-8?Q?gTmYBK3U/dzx3Ye9jAytGNw9F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bb070d-e19d-4a83-f108-08dc70d15138
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:29.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWHmWLsaIhgWOB6Gm3FLTJE4ahifHowla2crfJwzIftwBTvYiID0HNnP1Qu5TGgXXTzE/O+YWdCt5poZSw+Jzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Peng Fan <peng.fan@nxp.com>

The initialization order of SCU clocks affects the sequence of SCU clock
resume. If there are no other effects, the earlier the initialization,
the earlier the resume. During SCU clock resume, the clock rate is
restored. As SCFW guidelines, configure the parent clock rate before
configuring the child rate.

Fixes: 91e916771de0 ("clk: imx: scu: remove legacy scu clock binding support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index fe6509be6ce9..47f4ceab1179 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -222,11 +222,11 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC);
 
 	/* Display controller SS */
-	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_pll0_clk", IMX_SC_R_DC_0_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_pll1_clk", IMX_SC_R_DC_0_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_bypass0_clk", IMX_SC_R_DC_0_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
 	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);

-- 
2.37.1


