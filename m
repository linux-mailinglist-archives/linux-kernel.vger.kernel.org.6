Return-Path: <linux-kernel+bounces-277449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AB994A19D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980631F21A9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B31C7B8C;
	Wed,  7 Aug 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="J8/TllkB"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4072868D;
	Wed,  7 Aug 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015520; cv=fail; b=QIQFTaeaEI6tcZNhNIWBAFuNIuSm3hdD1GfL5J330sWuB2qMGGLKSZ0RJYKg3vx++7jNQSGhOjt4VJ2pCb+wICI5EL5OLt34jJFeezLocHlCtQ72Q0dxPqefrbKab0Tc+Kt+WuCio6BBauzlSOQRogMmWXD4S/Lx8lAEGncBrRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015520; c=relaxed/simple;
	bh=Ub3UfLGhxyOhTZP2qOQn5/TPFlC4Mapqgx2avbJy8rU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oD2LKvLgY3AH9SmXEpltrToXST/4rKV5WzTYau25yoEafmPv8Mdo0lsi+SNNZ2rhbfbCkxr5LAjrYNs9FExA/iHnKtelTSglfYA6wwOmswzATYlx3d6ez6a6wd5C/QNEYrr/Jd2NbGSL6lE9fDTxSW/txwUfaTXuZI2bH0RiTf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=J8/TllkB; arc=fail smtp.client-ip=40.107.255.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQLVcxCR4I2Woo+U2FPanhQGFpl97yjRLzUT2nsKnCmT/O7fIBEUetL9/4zWOiYcq6L+B2wUuu5AboID5jUmX9Ei24qVlDmqAE5LtigoZmsoDDTC5ORodFaiPpc80yNtT95yzgKlW6WinzgD2lYLM7/EciYN0i0qASURBOAov8VreJT0/NCT5xfb30lFMHRlG3fhxjDmMLUckAhKhzAYTFGV0LAjCebG+mQS7SroUtLrv3MVyfsHfVtnakMnr4YulFYEYvoANdDZW8JoFLDzIWV1JQ0SXOYNttE5eZCFujz3etHrijWEavOuzQn1kfDtAz0G/BXX4mNlPcOjMcpLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EnX5GOqYiP55F+l7yXqIqCnc74zOz4P6YMaaP1531E=;
 b=rMwxhZdBb87zGzcgWpooLS2VKKseg079yvL99vXyX72NPLAHbiqfeycrcetS0SrgKZDHJ63/RG4bQz/WGX9Nv4Fhj0gfgeKDpXkAcLG7ReVBGb+XnchizUSEmLGVxbOCo4FArsqwLWPbsY2D220sGlVzGBVuvtAu3UHunE1B5LKr7NLecutu879hDPIpKZwQScp95rSanw1MaDD3hOjFoq7bwH2eVWEolUaaoRuExuTtUS9xRkopO/ZI1ni8CD9HRhVM08ABOKjRZ8YEXjKv0L42jk7TRMcFnar9Rj7Fx/Dd+BhakZ0YMHYfQ/XbdzTwgb7r/GyuPcBV0+0spGruIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EnX5GOqYiP55F+l7yXqIqCnc74zOz4P6YMaaP1531E=;
 b=J8/TllkBrry9T9vGNaPllpC7OIyyrs9IjHj21Og8CzKe2I+aPQq3ZQkfuA9JbeyXWfKjunXIXvEKev9l4SXzfpi+3nZEuKd6jEr7ub0GOQXtzSkOTMZFbBBydvT9HEM3ymGoJ9AjxvvvYyjBBpQaD/BvKKJupKUaZ9bZBls5drqk/0teEp9dVE5jXsoeGqwhw5o/+XzV0o9RtZT/DbEbOb5nVDmaG9nbDM5YyznmhbnPCMrp+C+BTHCL6u4vDLje13vhAzmP02NooJkx0vVkaSirVs3gwJbILkgP+rP8A4D/0b4Ekp6G2k5W6PxcxkSFTAnIJJGpmnV2bUBVr8rb4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7414.apcprd03.prod.outlook.com (2603:1096:101:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 07:25:15 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 07:25:14 +0000
Message-ID: <553f6971-c253-4382-826b-c9bcd97ce66d@amlogic.com>
Date: Wed, 7 Aug 2024 15:25:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: add C3 AW419 board
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
 <20240806-c3_add_node-v1-3-c0de41341632@amlogic.com>
 <c82b6e70-8f2f-4b37-9186-7c49aea019bd@kernel.org>
 <59f37c77-d57b-4568-ad9e-6d50791ae5f7@amlogic.com>
 <6ff63eb7-81f4-4d3e-b96f-890432ec184a@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <6ff63eb7-81f4-4d3e-b96f-890432ec184a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: eb671e95-2594-46cd-518c-08dcb6b214aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXFtK0NZeGlRdE9SMXFURXZmUVpDS2JqRHk5cklxaDJRSlg1Ny9BcFEwMjN6?=
 =?utf-8?B?UjFXRktpL1JxMmdlRlZmMWZrQlBHejdLdHRFVUJZbDE3MWliRjRuTmlyUGhX?=
 =?utf-8?B?eWpEVXM3Q0FSYnhOVGVqRWduUmpGRnFhdG9MdmxudlJ3eWFiT2pkeC9VT0NW?=
 =?utf-8?B?UmVER0dVakJ2Vyt6dUFIcWs2Q25UOXB1eTlqK2V5VjU5b0xyOGdkSzZTaERn?=
 =?utf-8?B?ZWUrbTNEV24yWGhlQmYwNjVqQ3FlK3dtZ21BSlBJa0dueHpROElLaldKR1ZS?=
 =?utf-8?B?aWtNaVFtRzIzZEtiWXovd3pjaHNNTjYwNFpMeDgrUE1yVHh6aDNUbHptZGRB?=
 =?utf-8?B?bUorOEYycHppYTh6bVVHOXUxb3E5cWxHbXdYQXU5NjF4YmFlKzB2K1NrelF1?=
 =?utf-8?B?ekxuVzBmUHhBekl0cWxHUytqTGU4djN5REZMM1kzNkFUa2k3WEhQeHdvdHg1?=
 =?utf-8?B?VTBvM3dYWWFvWHZINkNXcjVrZjlGL0xvTERSaHFqekFZTTNDL25BenBhb3RI?=
 =?utf-8?B?YkVyQTZYdTJTajRLMWVmOTE0TVUwWHBTWUxwdmhLTFFMdzdpaVQwVldqTkR0?=
 =?utf-8?B?SVhpTnlwcmZEVmNObVBFcGxYekRLYXNjcklMajg1WTlVMzNCQ0xmQjViL1g2?=
 =?utf-8?B?OVdBWHNtMVJuaXp1Ym1Mb1FLNFVpR1piRUVRWW1pd3hOY29wc3hmVUQrZ2ho?=
 =?utf-8?B?QnZ4dmJXZWdZOWJPSzI2eUwwVzR3aGczV2ZTSGh1bTdxUzBwaWRFc3UyOGRL?=
 =?utf-8?B?SitIWFhZcFdXUmY2MEZ0ZDhZWXVmMGtoazhwaHhJL0I1dStNUUhOc05pM2pB?=
 =?utf-8?B?cU4vMnhRbTZhK2hnc1hSWEE3NTRTMWF1WUdOak1Gc1l2VlZvMjlMSi9aejZ6?=
 =?utf-8?B?Sng3Q1g4NnI3eGd1R0x3SEtyYm1RcEYreG0zcWx4YndDMDZYM3lnK05PMXlr?=
 =?utf-8?B?ZlBLcEZQZTVidHBBVFRBRWhkRnZwMmEvZGhZOTVLZm1yWFR6OWxUZUZZaExi?=
 =?utf-8?B?MlVPVE9PMG8wakt1TWJNamRINW1SVjdBbk55dDFueFdiUVE0T1NvR0xZM3ZJ?=
 =?utf-8?B?ZnVtOFpHQUZLdEtxTXlyR0tLUFIwWkpjWTNJQ3pXUTUrTEZTVmpYVzd4c3My?=
 =?utf-8?B?RnJlWHJvUG9wR05TSkhhQmlDYWpmMERkcXU3aldNWDFRWXFaNy81elJOeDJT?=
 =?utf-8?B?Wll2dnUxa2hvNjhtZnB5dkxSZHpHenZwbHVsY3d0cHFCRHNmZkdNNVM2aVRY?=
 =?utf-8?B?QkJLaEtlRy9ySy9YaE40K3VONkgrKzJrQWxhelQvelZiU1Rma3FsM2ZJNURw?=
 =?utf-8?B?dVdESGxjSXR2QWMwSzcvOGExMXI3NU1LR1FEcWVHa25aU1pjNzRScjA5K0I2?=
 =?utf-8?B?ZVVPbkZtMTRhdFJFSWVlR2s4R1dTOFdXUTNOajk2WkJGaVhVSjFTbm44d2pm?=
 =?utf-8?B?NzFnL2h3NFoxdkxJdVpEZXRNd3dmRmQ4UWoxNkY1NDJpaXc4ZW9UdEtKOU1s?=
 =?utf-8?B?QXdTYWRSYUEvZ0F5SUF5ZmRZb3lzUS82WXRrMDdBL1hoRjBlMWlTeGsreHdp?=
 =?utf-8?B?dmVmUHorSEVrQkg1M2Y5RWpzSlF6R2hTS3RvbCs4MDJCYW9JM1JabnVwZHBw?=
 =?utf-8?B?U0RjQklUcWRSLytBcVF1M0RPR3dyREU5L1drUHBGeVVFakNveXAwcFA2TVp6?=
 =?utf-8?B?RHJPdVRrcmJWemR3RjV3M0hZNndtVENYOHE0S1FyUGY0YVg5YUNNSVNzejcx?=
 =?utf-8?B?c3lyWmVneUdYMmdnOUxESzg1ZGFzZHVnWW1UR1VnOUZiS3FJZGFEME12Z1B2?=
 =?utf-8?B?VlA0a0VTaWhSa29XdWwwdi81Wmt4QXJJK1ZMcTlKc3pVRzBtWVZCYmcrdExq?=
 =?utf-8?Q?U6kO6NtEULJi4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFwTWV6QVNISzdtVGxpZXh3elYrRmZSS3JQVDNmY1lIY2U5cWlaUGVSdTBu?=
 =?utf-8?B?QlprMDNodG9ORjJlanpPaWV3VWZtZEhPTkE5RXRtY1Y0Vk9MTGJLeUFRd0F3?=
 =?utf-8?B?SUFOK0xYSGFTejVncEgvQTJPU1JXY05nU1QreGdaRkFVZUh1d1RBMlFsTVN2?=
 =?utf-8?B?Rjk2MG5yeXJqVUJSZmdZV2hRSm9JdlAzTFJaQklOQzFLbEFBNG9kbmtmZFhN?=
 =?utf-8?B?VDc3RjgvaWlKTnBvbkdRa2RBblozc3FhbW5JbDFlMmNad3U3ci95aW9vV0h6?=
 =?utf-8?B?eTdUSVJCVWEyaGhaUkJuaVA0bzFqRVVFdCtBdGYxTTFLL3pXRmd2YW9tMEg4?=
 =?utf-8?B?amJKM3dwR2JiL2l0Slh3RkFxT29VMUMrOTV1bjEvWDlidFAvTm1xTjRVTkFn?=
 =?utf-8?B?a2xWcWZER2pxYlJzWlRTVHp2eHMwa1IxeUZ5aWFQZkVZdWRhUCs0OXNxR2Q2?=
 =?utf-8?B?QVREbUQvK2pvaGJINlBJbEpJc1BocEMxSGVqSnVQbGcwYlFsYmlkbmdWbi9E?=
 =?utf-8?B?dVRLeUpTVGxaaWtWZlIzOGI1VVJTN1pmZXhOUVNlcDdVbkl1NnB2TjJkd3BN?=
 =?utf-8?B?a0p5dk9FU0VkcnMwSzcrbmtFQXdZS3FzdGYxb2NZZ0RFaTNVUVFqaTd0cStP?=
 =?utf-8?B?QXF4bmhzdTVoMlU4ZTlTWkJOMlBSd0hUYTRrWXRTRDhqUUg2bGNuMzBXZFJP?=
 =?utf-8?B?UFd5ZUtDUWpkQVFCMnVTQmVJVmZIcmx4eXBoQVZlZyt6WUllOHppbzlFT014?=
 =?utf-8?B?cWNQOEdwUkdKcEdmUjlSa2xBcUo0amw5S1FNUWJxVHJpSHpHVEJDdVdZZVZY?=
 =?utf-8?B?MVBIUWk2WkEzeTVkYm1Hd3h4dFN2VkNYc0FIak5JWmJCVXpZb1NVaHg4Wm95?=
 =?utf-8?B?UlhNWUxzNXliV0hIdUJLdEtKQ1VnTTBMR09qalFTcDlzOFJKOGN5eFdKL0xk?=
 =?utf-8?B?eFBKM2t6aWdUQnY5alZBU09VU2h0d1p6cUFwMHR1T05JMEJhWm81WGtMdXFV?=
 =?utf-8?B?eFlXU1kyMDl6SnlqZGt4QW02ZjUxbWF4emFaa1JYejIyWElZTkdsdXdZV0sy?=
 =?utf-8?B?VUVWRVF0M2s1SDNIN2ttSWNQdzV2QzRLb1FnZld1NEFVMUVSS2pzbjI5TThY?=
 =?utf-8?B?UnFoRGg1WHFkekZJUTVyMS9pNmYxU2dZM1l2UVhHQis0Y1pBWjNsNTZRVVlC?=
 =?utf-8?B?T1lXa3ZMT0tvVVVJT0tDbmhaM3dTYU5PUlBCbFpMeE5teEFCYURkMkRqMEJF?=
 =?utf-8?B?Y050d2NKdCtNUlBJTGE5bU03U1o4Y2IrZjJNVXdkQ0FBU0xkNzdZTUl2V3Jj?=
 =?utf-8?B?MVBwNG80Ym9JWjF0bTd1c2FVaUl5QThFNkR4UU8wOGd1UEZuM2EvR2xVYmhC?=
 =?utf-8?B?YW1pWXh1YTRQTk81eWFGUXIyMHd6SVNiZnlGRVBOdG0ya0FmMGtXeUxmM29q?=
 =?utf-8?B?c0Urb1VJVzhZdGZNV3N5bE43QVBHbjZuU0RnNzg0ejdiTFZNdzY0ZU5lZWVG?=
 =?utf-8?B?Z24xRWFyWjJKcnQ4cUh0eU1ib2M5OFRITFY0Z25YL0UvM09sMDVYSnB1b3l1?=
 =?utf-8?B?T0lRV29MZlJRS3AvRmRHRWh1KzNDeXFsR1pxSVJzTjRjc1gyTy9UcnF2RmtD?=
 =?utf-8?B?WmIvcGpueXNUajl6Z2hic0piQUM1L1g1T1BxanhOazU2YzdaVXZhK1NSdkNw?=
 =?utf-8?B?Zjl3OHRBeWUxWVZtVzRYVzZlMEFLWmlIOFQwZUlOUmpTdk40WDNwQ2Q1MUJ6?=
 =?utf-8?B?clFtV1lSMGdBcDRZNnJXQzF1MEEzZkxPUmdsMzFUZ0N2TS9YanEvWDJpK3F5?=
 =?utf-8?B?cW15U2NNdWpQUmliUzVsNUlyOWR0RlNrN3VXMy9NbWIzNklsSVZOOXlON0w4?=
 =?utf-8?B?K2Q4WElXU0JKeFJGTS9GN1o5VnhCMW1ZRmhJa3dPOTBoaGlqdjJiWUM1c2dn?=
 =?utf-8?B?N1dGaTVSNGlBWTNLYzNOVWluVXZ6SmZTbTQ3OHBJZ1BRRVNNbTc2blhxaTB4?=
 =?utf-8?B?ajJsSHpFcVI4M0FVVFpPZ0NpS1NlZ1ZUajJxZjlDdlRkQ1NrNTAzOW1kZTA0?=
 =?utf-8?B?WTlFQ085SU5LcUVITDhRSCtuQm0rQ1V2N2Q3NXpaOE1qSUNQY0M1d0dkcmxk?=
 =?utf-8?B?cHkydzJjSWpUdHl1bktYTGZ5WVAvRld0Ymd5Y2xvVWx2WTAzZ2NkcTRFdzA0?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb671e95-2594-46cd-518c-08dcb6b214aa
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:25:14.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Kv77LnRSkIKaXkQztH9h+JBs6g3+4Mm948smMcU7dqfW8IRBZmGK8SIH+ZIMiC24pTVxk2sofPagwu8YVthh+FkIkcxNAewmbcDzCsL1Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7414

Hi Krzysztof,
     Thank you for your quick reply.

On 2024/8/7 13:44, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 07/08/2024 04:37, Xianwei Zhao wrote:
>>>> +#include "amlogic-c3.dtsi"
>>>> +
>>>> +/ {
>>>> +     model = "Amlogic C308l aw419 Development Board";
>>>> +     compatible = "amlogic,aw419", "amlogic,c3";
>>>
>>> Where are the bindings? Why do you add bindings without boards? Or
>>> boards without bindings?
>>>
>> The bindings of board aw419 was submitted with board aw409.
>> The commit number is cb3f4e8cacfa7b32ed8b9dff1282c0d4aaf42e88.
> 
> Why are you adding bindings separate from DTS?
> 

This binding was applied in April last year. I will make sure to submit 
both the binding and DTS together next time.

> Best regards,
> Krzysztof
> 

