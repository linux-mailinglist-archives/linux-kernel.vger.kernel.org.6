Return-Path: <linux-kernel+bounces-175493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043538C206A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DE1F211E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40416C693;
	Fri, 10 May 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IdM/4N08"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7801165FD3;
	Fri, 10 May 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332280; cv=fail; b=qfIrlelrqcvk1yRpGixLxQfH9IfHi4wvaI1kg/yj4VjFQbuJ7ip1xCZ93VeYTiRk4RC+0sNy6Qu0mNyXKvq03F1eQFHjkrK9S5cWGOJ+fzggq7cTMctofVLSLpEZObRuflh4UCKoDYiVvxpr0F6YuT8tJpSl947RdHby+PmjXs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332280; c=relaxed/simple;
	bh=6bfV1dS4W03vysGWKUi5DvTJJb/JmkVcqlEWc5z/JWg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IE/MzlRc64VQFDwUSfTSCXBxaiEHuyX1ApBq1ZKa7nEHNbQB0ZaUkVlQRGQJ5OU8bzhcttZhYfeGbJ8f2+r11tNRPLU/ghZGZwGTiqfStgLuzx97q5eoC8Ydznv5SfJD5EQDUBvTPnbw4cqNrvMvBW8KCPT/MQOF7Kxe9PjK8P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IdM/4N08; arc=fail smtp.client-ip=40.107.241.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ege1F1GMqjj2FYkGn8U8H7uegsYTOKmbHJmZdRyc3SfgLPAsYiWyOez5s35GCmVuy+IDyTvZEHOLhx8ai9Y2U/nXB8r6h8d7yZlVCo/zMXrZo4WGKUFvU77TKnQYUZWo08o1B4orrcAjl4TxulD7yJSzi/dhKDCgTepyKYxq8dfqHXFyJVBuoPPC146cPB+8mA1/VRyW7bT0I5HNpqe7WT/nutU7hKJ6vGwniKZsNNvw6Q/9rOiWL9h0pAGq/eNMlCJTkPoK2p9YBWJ8bw+6p1NPMulr6dqjThEac3k4pZDe2sg5lU4eAYDsfOxFIIAqdMx5T96e8oICCSIPQxY9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGMI2AiGxzw3PtYdGfhqBPcJZuR1jYmB5HiZD5n8n9U=;
 b=XgJnX1vk2y0sP8J6WwtVxi2F6j6Uhi5RksvCUS9IyH+uyeo7e4axYAzFUv0Ld/qjZaK9zG1OS52AngGx6I2J8FD6U54Ofo+VcN8WIiPVggLImJNCIoqqbAbbauFUwv/IEYBCnGIkj6CNMzgQuwT9ufDgYpI4Uk4NTBKXT1BmJ28J4dgv28/xvtvhOAlKGJXZ5o2vpQlfQ9aB/CzAs/7UiY7KTJNpvwYp58j2VTvEwmuAUEcrYn/6eCfaNoQbr0AsA6vKjp7gORKcnumkXJAPpB1sc1WB0TqeL8umTTVmvmucWl8AO4WRV6p4MP4a4h3XCOQOZd2CgA02EPYLeBuy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGMI2AiGxzw3PtYdGfhqBPcJZuR1jYmB5HiZD5n8n9U=;
 b=IdM/4N085Pc1u5GldSZyXZSTKQ74u1SJVZHPNiW1UGHPnTbXbTooYjfXQUbVOB48S3vuEg50m2M2tWN6i+dgWDgVkI+EyznNp+3g+EbnkwC1+dOKvS5Y2Bgkfd3AMhYJYs37p3C6GXYy3QA2cmzGnDUljkFmvScX8hxK/fFntrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:11:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:18:57 +0800
Subject: [PATCH v2 02/17] clk: imx: composite-93: keep root clock on when
 mcore enabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-2-c998f315d29c@nxp.com>
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
 Chancel Liu <chancel.liu@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=2275;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nzd37ej6sCrJO2CX0AUOVMMELufbZrxk0WgiSw0tXHw=;
 b=X2S7w85e3ziWo+xQ8t4S/Q7vrJDhr/Ghj23yRzEWL0yEiQRsWlnDljoG2Z3HQ8j64Od8EMBZN
 ivx/JZ+AvoEA2BEI0RMuugdZG9E2oDry+hjM9aabLQ2l1b3JufxuzRI
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
X-MS-Office365-Filtering-Correlation-Id: eb0bffad-73dc-497b-7306-08dc70d1250e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTBHaVBYc1dYdkZUZldOZHJ0SWVWLzIwNzNmbWJHaFQxQzQ2a0VJZ1hWWk83?=
 =?utf-8?B?aXQycVM0clZ0UW1BR2dsWmRUQVdNSEkzMmlLWDVKNk85K2F0YXhoL1VMT09B?=
 =?utf-8?B?YjJra2o3SVFiQmRQeWJpOXN0RCtlVnQrbW51WCtrcEZSTkdYTUdqSVhISlZy?=
 =?utf-8?B?QkY0blR5elRLbDBhTXF2cHpaSTBXaEFXYU5DekJLZzVaL050SFNHSW9uekZ5?=
 =?utf-8?B?LzVaN1FJQlU3QmRTd0hhblZFdExIUjRKSGRWUC9BQjh4MUtMVkE3VmxEcmRu?=
 =?utf-8?B?dU5rSUJLb2xRZ2thL0pPdEw3MUc5bUdjU0JiMzZ0SHEvbGNwMU9HM2g3VWxD?=
 =?utf-8?B?Ti9LSEFLamtSdWlrZk9HRlNkdWJEOGMvS2ZRZENBcUNmcjFaa3Q3b0FFaHZ1?=
 =?utf-8?B?QVNFUjBIaVlUQUYxd1BoVmt5dkR5eHVDSGNWUkFvcDNIdWJXdHhzM3VsWVNr?=
 =?utf-8?B?ejhaNjF3YjJEdU1CZkZzakZvUEMwemtSVDE3NWY0NDV0cVlKSFA3SVY4SmtV?=
 =?utf-8?B?QXczSTdEL25VNUt6aU84REtFdnBZZTBKc1c2WEQvelF5WUZmQ25HN1F6R1RT?=
 =?utf-8?B?QXJmekQ3eUJFekRvd2NmYnpncnVIUDJjTTVqbENJU2FqK1NFNGIySjh1MEIy?=
 =?utf-8?B?aWZIVWxoT2w2Skdib3NuRkNac0kvWXpCZzFFdGhuK09rVktNVUREQnZrcjNW?=
 =?utf-8?B?b3dKUDM2WS9VNzIzWDQ4K1F3N1VsZld6eDZjbnR4NzJ6VFVkTWRXQ05oanE0?=
 =?utf-8?B?S1cwR2JoRlVtVGdqZk5jUzIxTzkzSXd5N3FqeGM2b2c2NUpUYmlPbUFZMUF5?=
 =?utf-8?B?MUVHU3JUd2JqSEYrdzBDZ0o4WHZBTWhtVFMvRU1wcFk0OS9LSXg3dk15Z3BP?=
 =?utf-8?B?b2RTOUlmWkd4SWNtcUhZRlpnOHJ1QUVlMjZXNEZnTnYvR2RDZ2ZjY2VYUUs1?=
 =?utf-8?B?MUNnUXRjZkI3ekxCb0U4UEFvUGsxVHNFMXFvS3hmZTNxVERaem1TU2hlbHI2?=
 =?utf-8?B?TEY0eTB1MHp0TjFGQVAxazFEN1JpODQ3cnlCZXE4RndYUmRTZ0NhbE5RN2tK?=
 =?utf-8?B?aFd2L3ZLbm92RTFDM1hhbUZFaHhmTm9xbEVSVmRzMWlKa0dZOElLN3BwTkx4?=
 =?utf-8?B?MmdEQU9leHlLZzAxYnVOTk12ZVNqVklHTTkxWVJXVG9MNkt2YXJHMVM5cm1N?=
 =?utf-8?B?R0kxc3Vhb1BLVEJacmlTOE9xZ3NCR3AwYWFDbmRqb0ZuN0F2bGNuRWl0bnR3?=
 =?utf-8?B?by9DV0oraU91KzJRYzM0d2p1RUxBTTlxMlBXSzR5QjQ5QnhsaGYyTUt4Tkhv?=
 =?utf-8?B?c1MydzZGN3JBcXk0anJBTTVrZWJja0cxMDZQdDhid2ZoWFowa1lkc2QrNitw?=
 =?utf-8?B?UzhNNFFCTFQvMGJpNkxjZ3ErR0s0cnBSVklWbHVscUhFU2hGZkpUVEg1ejdp?=
 =?utf-8?B?b2xwODJNV1JTSzBINVFoZGZVSmFnY0pCTFd1anZzV2s1Tk9Ed1FhaWRNazNn?=
 =?utf-8?B?UXhBMmFoL1AzUXI3N0d2UE0vVXNvU1YwVDJ4RkdKQUgwOGpyeVBjSkhhSndK?=
 =?utf-8?B?QWkvTDgzQUpsaXgwVW1Vc2ptR1RLRDRob01WWE5FZTZhdGZsTzVVVjdxSEUv?=
 =?utf-8?B?a1EvZm15RFdDalJSckxsOXdhZnZET3NSeWhFdTZWZVF4VFBIWFo3cDhHOVpD?=
 =?utf-8?B?UzRwbXJCcGRLdXN6ZmxodGloYjBpMHM4aG1abVdVMmpqQ1c1U28vYXpDN0g3?=
 =?utf-8?B?OFRLNTYwY3JxZVhicTRvRE16NzFLRjJvUmxOZnRYRHdjR0dYa3lZeGJaWldO?=
 =?utf-8?Q?O6PZTX8swKPV9AI4taHLgZs21pN1+4tVp/xls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTJNS3gvaWljVHAzNUFnWmZRaXkyZjhWMnhKeUZMRzJWOFF1Y0hXdG1tSFhi?=
 =?utf-8?B?VUVGSzNWQUdvZkZDb09RNDJZMkdHZHN5THBzYkZlL1V0SVozWEduc1Q3ZHdz?=
 =?utf-8?B?ZzVHK2NPQ1RpKy9XUytBc3VPUUlOTUFFNno0czlJUWg0N3laYWZvUm0zR3pn?=
 =?utf-8?B?bmxONGFzYmpWZCtFSU10dEZqcGxiZ1VlYUYrSXBweW05U0JEWGFLWWpYL1N0?=
 =?utf-8?B?aEpET05VSFNlZDFpTmJOajA2WW5NcHZuY2pxckNWVkg4QTV4WTY0ZmdwNWlq?=
 =?utf-8?B?MlBmdGowQVpNTXBWWTBuNWdKOUZ5aFZwQ0VBdmh6YkJiYWxCcTAyN0R1cnZ4?=
 =?utf-8?B?a21CWndsL0NLQitSbGo5UkhUS3I4MmRrTElUV3h0ZkxuTDdhaXR4dHNnWGtC?=
 =?utf-8?B?VG94OXN1S1BZeGdHc21POVh1K1Q5c0trZUx3Ymdidkloc05IeUE5MTYyRm4r?=
 =?utf-8?B?UXRPNWdaMjI4RGhlYmI0Slc4S0Vyc1R1Ykx2b3Npd0JoYzdyc3hYdXRDY0VC?=
 =?utf-8?B?U09ndWhpbnNyVkVTZ3dDQkwvTVVYV0xOWWNSVGlKeTM0S0F0MGRVL3IzYTRh?=
 =?utf-8?B?cVp0MGcvNDhlMCtmWEM2bjhwNkVPWEg3K0dVN2tBbEJkQW1LOTQ3WEt4V25Z?=
 =?utf-8?B?KzN4Z1VtOUwzeVh3WW4yMjZmY1BKcHpIQzRxSGNZQit0cHlTaGU2OS9wSVRa?=
 =?utf-8?B?bkhsRFRPcGlBSDJZZW5nWk14SWlIaHFyY295bEhPVjJxWEpEL290NFB1elR0?=
 =?utf-8?B?RllOM1ZnWk1MbUI2dUw2cmQyTjBTcE9CNm56dStkWVBxRDdMV3VmcmxXbkZw?=
 =?utf-8?B?QnRKVGFEV3BkWGZuQmZCUE93bFd5OHJlYTlIZlJVekhldFI3T200aTJBOWl5?=
 =?utf-8?B?czdCYklSR21xaWc0T25sL29LMlFLVTdPUTVsbUpWdFZTWDFQcmZGS29oZXZt?=
 =?utf-8?B?K2ZuU045MXN2dmhSUGdPcFpuckU2cXBOSjl3MXlxNjBoMmtZY1Y5QWlBZXpN?=
 =?utf-8?B?L2tIdThFYnBoOWZHS0lzb0FNYm93QlEzS3pkemFoOVZzSm5jMzhYaUdXNUgx?=
 =?utf-8?B?VUpxWndJS1NUS0h0UnJ5MjBmaENwVDg0dHR0WTJyNHFjczVyNGVENUkwa1hS?=
 =?utf-8?B?dVRRMGNLa21hZ01YZWxFYkJtbEhzZ0t0RkJHdGlPdmluMHNBM3R6QTJRTjhv?=
 =?utf-8?B?L2VuN1kwLzc1dzhlNFN0SmdpUzFSYlRPaFBmYVpremw0SW96TVhTejNFNVVo?=
 =?utf-8?B?NG5aSCtsVFpRcE9BcGNxY3BjMFlzZlM0SWh2cmZKeW44SVJnOWd4aUNXOTRt?=
 =?utf-8?B?WkZMWHFEOTMzQ1kwSXNNU1JRYmZuVzZlM3V2MmR6QzY4K2Jpd0t4YnhJUTdF?=
 =?utf-8?B?SUJqODM1eVdGZWI2TEt4QVlYeHV3eFZsY243bkNVVS83cFBvZWxjY0ZYVTJJ?=
 =?utf-8?B?UERrcGQ0TDlFa0M3VVo0MjVVVEV4Rnd1MDdFbjEzV3N0cmx4U2dzRERnVlNy?=
 =?utf-8?B?L3VzSjFTN1pzZGc5Rm9zaDBFaHJiWU1qMUhxd1dDdVpFOEJwQ1VzOFF3OXVQ?=
 =?utf-8?B?MW5adDhaemZpU0d3OUdHV1RwZFRsYzU3bCt1NkRhaVV5SVRBLy9Jdkdyekdt?=
 =?utf-8?B?RjJ0WFp2cXBZb24rMmFxanNmTXRSRlR2VVEzYk42TGpKNGYzU0EyblBJK2VS?=
 =?utf-8?B?cGtpTVpzbkRCTC9BWEFpUW8zQ1hobHc5eVVlK1pmNzNyamp2SEQ3ZjV2RG8z?=
 =?utf-8?B?N05wME93d3d1bk9vY09uakJjU0ZCR3luZlBYZU00MWZhU2sxbENDWFlxbFU3?=
 =?utf-8?B?Vy9OSmpGT2pyeFdZMmVuRUhSeHFvajdDQmZ4bitqdnpQeUpnbmlCQUJaQnF6?=
 =?utf-8?B?Ryt0M0lLaGlGS0tPcTRqbFpjL2lvb1dpREtEZ0Q1dGsrS2k0T2lxZG5JUGNV?=
 =?utf-8?B?ZUFRdUxFUFhibGV0MWJ1cmpTRFBvV3ZTS0o3eXJvU2tORWI2ZUxrSk9XUG80?=
 =?utf-8?B?OHpYQS9jR0p4WUE3b1Z2SU9hTEZCZU1rdjNnMW0rN1prb0k3M2loTXFaZUxM?=
 =?utf-8?B?TytvVGwrbGF0emtIdzFDR3BoRGM5eHpCV2k1NmhQa3pOTmRWeW1MRTNkdnQv?=
 =?utf-8?Q?b6B9Yb8ymis7K8u/SKMpi5K0V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0bffad-73dc-497b-7306-08dc70d1250e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:15.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2LJuTvh1UWnomLmQwfnbHvI9U7on6GPAJdzG2TijAjliZ0hymRa6Xx49uI52WqjOcZL+goku4JfLpc/QEpLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Jacky Bai <ping.bai@nxp.com>

Previously we assumed that the root clock slice is enabled
by default when kernel boot up. But the bootloader may disable
the clocks before jump into kernel. The gate ops should be registered
rather than NULL to make sure the disabled clock can be enabled
when kernel boot up.  Refine the code to skip disable the clock
if mcore booted.

Fixes: a740d7350ff7 ("clk: imx: imx93: add mcore_booted module paratemter")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-93.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 81164bdcd6cc..6c6c5a30f328 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -76,6 +76,13 @@ static int imx93_clk_composite_gate_enable(struct clk_hw *hw)
 
 static void imx93_clk_composite_gate_disable(struct clk_hw *hw)
 {
+	/*
+	 * Skip disable the root clock gate if mcore enabled.
+	 * The root clock may be used by the mcore.
+	 */
+	if (mcore_booted)
+		return;
+
 	imx93_clk_composite_gate_endisable(hw, 0);
 }
 
@@ -222,7 +229,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 					       mux_hw, &clk_mux_ro_ops, div_hw,
 					       &clk_divider_ro_ops, NULL, NULL, flags);
-	} else if (!mcore_booted) {
+	} else {
 		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
 			goto fail;
@@ -238,12 +245,6 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 					       &imx93_clk_composite_divider_ops, gate_hw,
 					       &imx93_clk_composite_gate_ops,
 					       flags | CLK_SET_RATE_NO_REPARENT);
-	} else {
-		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
-					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
-					       &imx93_clk_composite_divider_ops, NULL,
-					       &imx93_clk_composite_gate_ops,
-					       flags | CLK_SET_RATE_NO_REPARENT);
 	}
 
 	if (IS_ERR(hw))

-- 
2.37.1


