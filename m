Return-Path: <linux-kernel+bounces-380000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539C9AE6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414112846CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCD1DD88B;
	Thu, 24 Oct 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="jj5pbuRN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78A1D5AD7;
	Thu, 24 Oct 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777624; cv=fail; b=XIn5dP0I3fX2vxlnpCaCtyAZG1ij0E/mKUAQloGG5FwVw5SYaudRmA1hxqNV91KgL+Ld9K8ydek/vUHZsemZbtG53EnmK6lbd387y/zAqvRrl3d2/NvoF5q7iJWsVItfIiNJBkUsV4oeUZRaeuiLCuvPST+Tp7FvRJXuNfTrnF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777624; c=relaxed/simple;
	bh=ALgaydQ8Zst7nfhFOOatRVt6D6rV8rHlZe6CFtmWz7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uczo9TSZnfjRRAB0MXgHGTKtPgKqGAi6rQu+3RGOJ68WBnvHS8wTrSaA3gELzo2eeRrH4EUdlGvstJaBO7pXfBNMtECZuYXUezOay57VYQPDYzOKwt9jIBLyNOdQDNaWRHfkVoOGThwXGvCik1PZX9jmk3zqZ7o+37YhszlNspI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=jj5pbuRN; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baz9Mn1gko8fSOhueD83OU1QS22xoe+fodjBawdw2yc71UbfdvMuLdQ7tNp8ipvyUIr09nQiV7BN5bptpmxxda9xEUIcA45q5scxsOYBFtL5zQcs2zjVbQ8z656+y55tpNAc+5Hf1IMjd9rRxLefdTi66VnjTHOu6Q4P3u9j4Cn/jSAkmw5H3XAy1ZOm7R+2O+hVU94Q3Jw9jP4sL6ReUfPpXr6Uw6kyKK6e6uIGKQDETq18s0iffsAGOpPajrxm3Z5cgY8JKf9V6bNxVbV2Ss6zsPWQc8HlTMn8x+Pv2/f/is7DbzKdWN92wVMB4W4z8wOsCsuY5R+4usXnyZu9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+wFXcm3qpcQHTke9VmyF7JoSX7nlt6J4smq1LGh+qU=;
 b=oeS7oP8Vn2kJCqPuXj45WGeX1E68FuJYCmI2UhZlMK3dlNIOVy4wGDqx78W1zjrzN8CCihzeEH+wqCWAlgjd2W7ZuMDDSyOKR7TbJEZiVg/uxXytIasgzjsPzdKjk1dFm6tyHrOR+PDaivclKtP5zBVr0o0J9euT9oNYGZT3s0Y6hH2qh4aODt7F7EhG1UxKa6xaY9av+RFmlraHBwtXWLsG5p5u0hcnPBNeV6O4woBOHRrFHxC5jB5hhlS2cjCEUC89rDQ0SVYbYqstq4ADYVe973QTL3KMWmjyhYvO/EMzsr9cwVlIqmQ2zjSsMjp7oOt2SosSCdFUvBDzf8mnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+wFXcm3qpcQHTke9VmyF7JoSX7nlt6J4smq1LGh+qU=;
 b=jj5pbuRNrVXW3yXAoY8q12lz4klgKSfO3w84MVN51pL7TWamHb8JjrpmOlzUE0StmxA/N+engMOaL2LpinIAyRorZdhSHwh1fU6m19FHMWUOjiG2ZshgeP9gWk1AUPwG+IjPL0jew40zncuzhTEddj1tuAQKeVc7ZOMHZlBZIUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 13:46:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 13:46:55 +0000
Message-ID: <1f98c2e8-79e6-4b11-9007-ef2ae1499b5a@cherry.de>
Date: Thu, 24 Oct 2024 15:46:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add HDMI support to
 rk3588-tiger-haikou
To: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20241024133240.1737647-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241024133240.1737647-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2ffc9b-8ecb-4ee8-cea3-08dcf43252b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2RMS3ZuRkcvc1ZTdmRvUTNKY0kzR0ZGbU1HMnRENUN4L0ZYRDR2UmlPKzBv?=
 =?utf-8?B?eE9EZVpHOXZyS0h4RWtlWm40T252SVM0bGp5Wlo5UE1nQ29jQTI0TGdaMnJZ?=
 =?utf-8?B?OWV5eCt6dHEwZjZ1WkVXc1piVEVFKzVLUFowU2F5NFNYbmE3N3ZBdlc5ejV0?=
 =?utf-8?B?OExkcjhOYldVdGVUVTVRYmJDUW1RSGRzQk9vb1doL2JJUzFGY1psL0NsVDE0?=
 =?utf-8?B?OE53a09JSGtGdGsrdUZOUG43M2NManBCUk5aeG1ubE5FbDNPTUluaFVMaVNr?=
 =?utf-8?B?M0FGZFYva3dGL1BpUDVBVjRDTFpJeUZ2a3ZIK21PTmI2Qkk3cG5JSU5SQXR1?=
 =?utf-8?B?dU90RkpnV2JqcytTclBCakhZM2orQzFPWmRTMGVSRzF3dGZvWVJHYlRNM3RQ?=
 =?utf-8?B?SHh2R1NNVUxXaWs3RktYc3R4dXVFcUpmMVpsYUZidDZYOUZLa1lDQ1hCeWk5?=
 =?utf-8?B?ZUNFTmhQRk1rdXpHUEptUlZZV0lRdytNenYyNU9iRkdYbUtUWFBQOTU0VHB2?=
 =?utf-8?B?RFRWTTBVd05DM2NKMTRTajEvR0FKYmhVdmxhaml2Wm5wMXlzc3c2WTVNaEhl?=
 =?utf-8?B?VVpIdlY4T1RkamFrYnloV1BMT2ZpYTdCaVBMNVdHY3U2UWUydHJNUllsNEtQ?=
 =?utf-8?B?SzBFWWxyREc4MFloMmY4dW1DemhuRGkxbk5oUFpwbkx3cEp1WGJDRW9qWmhI?=
 =?utf-8?B?aE9Zbk9LL2tNcWlJMzNFMFc1c1kyTlRXck9ZK3NKblRrK2pLVkhxSW5JN2Zo?=
 =?utf-8?B?WFBSazJmdEticWl6L0ZLQTFsUUdhbWhaK3VTbnpHSjUycmIwTVduci9iV0t6?=
 =?utf-8?B?ZDlHaTlWcUIxbTBjclI4b2NOek9peHI0RDNHYy95SWtGd0NEaDdDT25uRjZN?=
 =?utf-8?B?Z0M0MUVIV3VCVVVWTU5WRVAzWWozVStKeWFmd1U0aFE2dlFrMXNZN1BBdlVp?=
 =?utf-8?B?MTMvRkh2RGtzSGhUbnFBRGpYbzFSRmwwNG1TenFZUzhOM2pxMlRLZ2RJSlBa?=
 =?utf-8?B?bDl3SThXU3NrcHFwVzlWT2xSZ3hkMFcyenpwaTNJZ0VITVV0WlZ1aDhLaWor?=
 =?utf-8?B?WFVRZXBtS05wVjY1R0lobnBFSTBqZXFkdEZxV29VSVZNNm01S3RDWkJTZ2tE?=
 =?utf-8?B?VUtvN2JyYTZ1R3JYaURqVVFjdXhydGFXUnFrakZSbUQrNEhvdFFCZnBjYTlZ?=
 =?utf-8?B?bTU3bWQ0bE9wK3pJK09HUzNaVWhBL0JnTy9yTWJmR0lCSHR1OXpoaW9NWm4z?=
 =?utf-8?B?VVJ6eHcwNGRGeGVQLytDUnlKNnB5YjZmWDVVQTVoSU9XS1lzWFNPWDlUYko0?=
 =?utf-8?B?QVdHWG82ZU80Vm50clZZNmZreFRuUzBnUGFveFA4bVdydlppWERYdDNDejAr?=
 =?utf-8?B?NnVuN1p0MWRxak1EbDZrNkFjTnVxbDVDeWE1QnZPR0doRTdXVzlYc3lFQVli?=
 =?utf-8?B?NFFUZjRQM0FFWW16KzQvK2h3WXlmdVJzVVBxYXlHZ3grTUpNTUYrWlJPdThj?=
 =?utf-8?B?Y2NTamQ5ajNrbERENVRRUzhRd1BrbkQzVFN2ckpTQncra1hOTkxHaEdoVkpl?=
 =?utf-8?B?eHMrRy9qcFVMb09QeDBMUWUxbGhaU1VTOHVKUmpXYzB6L1A5UENvMm5Id3VD?=
 =?utf-8?B?R0NzNlVLNW1hbjI4RkdGYjF4dFpiQlpsN0FTbjh1M0JUamFxZ3Z3R0J5Y0lB?=
 =?utf-8?B?dWlhaWJud2t2dkZNUHBlaGFxOHovbloyR0pvOVhWcCthTk03MU5GNFJsVjdz?=
 =?utf-8?Q?TmmpDgo5T87DbAvlQrmnKy4B4UpZapU40qyHAmR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkhhZ2E3RU5MclIzRnU3ZjJxeEJoVnl1ZkFDOUZ2ZzNSSFRlNlpCdE84UVp3?=
 =?utf-8?B?SGdVUENLd2tlR2JIV2IxaDZXd05vMnU2NFVXb28wVFhTNnk0ckNoR3FIMEFB?=
 =?utf-8?B?VXpPZ210M2xGWkZMc2dNNUpZZkh6aW9KclBlOEhXQzllMXNRRUUwelZ5d3d1?=
 =?utf-8?B?S1pKVGdzS0JlRi80UDhhKzhBYk11UlZ1Z28zZHVIVmdxamF3N3ZuYjRNN2w3?=
 =?utf-8?B?NXlzZWVoYm1NZlorNndjeHE5L2s5dEl3UFJQQURhaFFCVTgrMi91SEJ6Ly9a?=
 =?utf-8?B?RE1rL3Y4MXQ4MGczVmFiMzZnMHYrZUxBQi95dVdzemVpVDAxcWhHNHUyVXhT?=
 =?utf-8?B?MEZhamQ5ZUtTbGZEUlNEQ25vWEV5R2tYaGc4SlVoamc2Zk9qRDc0d21RLzhN?=
 =?utf-8?B?djZFMzRjclNwSVcyOXJXbGx0VHBVbi9OcUZ6UDlXWldDZlBhNWJxZUFhWXd0?=
 =?utf-8?B?SVdqdEQ5Y0tjT2dTK3ZVbU9FNEFoYnNIM3J1U3g2YTdjZ0lTNlFXU0FXVlV2?=
 =?utf-8?B?cTZFY0tocnFtVFlkK29TMnFHVHpoK3VROFZoTnRkekRGRFBaaGJ2bk5UOTlV?=
 =?utf-8?B?a0Y5K0JLbGRneHNEekgyYUtvSm8wMy9XOHV6aENXTTkrTUtkZUxUQkQ2SDFq?=
 =?utf-8?B?cHNaSjlqUWpzTmtERFk1NXI0bE14amhvaWxWV015OFZ4WVJZTHJNMlUydWVr?=
 =?utf-8?B?Wk51YUE5QTE3Uk1JSDVkc1hNMWsvS05Zb2lKbHJia25ML0VPTmFwTXNQMFBI?=
 =?utf-8?B?QXNlalBGUDdwK1JRWVQ5aW1mN3RReUNyVXFFNXIrc3Z5K2k0Ulp3Mi92a2tF?=
 =?utf-8?B?ZnU0VzhveGFMSWxRMlgveDJpTUR3WnEwMWlLb3VNZUxiK0QybmlENTB2ak1B?=
 =?utf-8?B?RHdLL2RIUnU0SGd6OU9jNWZON3B6VkJITitvQlRZS3pydTU1U2dOUkFYOEpQ?=
 =?utf-8?B?UU5JN21iQ2xzN0tJQ1JGV3M0Qy80WFVYY3NnZmowQ2FyS3llaWI3aENZcHhn?=
 =?utf-8?B?MWlXcytvVmV5QlVhdjB6YjJTbi83OFNLYm9yaCtPVWJMUUVXVDFsMVBLeDcv?=
 =?utf-8?B?aW5xR3ZMVm14ZnMrVXU4RWwySlZBOWJUaDZob3JKNEVESmVtSkpSNms4ZGdk?=
 =?utf-8?B?RDdaWWdNKzdzN1NENU8zV1QySUNxSDg5TFJSODgzeFA3TVJBOU1oREFEOGRy?=
 =?utf-8?B?QnJBZnJoMG5iYWYxeEh2Y0N3ZnhHRzFsU3BTY1B6TWhJbTBUSFcvblM2MlBF?=
 =?utf-8?B?QmcxOEJ2UDY1Nk1VeGhVcGcyUytHbktLbUFtKzlZM2NiUXZPMUhjZU1XbW1E?=
 =?utf-8?B?SnBXbUhPMGhxZnpZK0tuOVQzSjF3MFM2QmlQNFdNZWtYSlhncjE0MVJNbW1y?=
 =?utf-8?B?QXgyQXEzK1czVlZGOGxOZnA0aG5kbTdJRGFHbk1NNGt4Y3VEREZxNE9lRFlF?=
 =?utf-8?B?R3VLdVBaVk93cE5OQUdHcVZHZm9Ja0J0R1Q0ZkUrV3MrVS9sWGVHSXVLWVN6?=
 =?utf-8?B?NDhHWHFOdW9kcHI4Z3N5bVVGaXl1OUF6Zjg0RWE4bkZZeHNsL0dyTW9jeWt4?=
 =?utf-8?B?OGJoU2RkS3ZreEczeTdmY1lPdjN1aStQK0hualV0MlVhWlRnaWQyTTZQTUVD?=
 =?utf-8?B?Vm1TeGRkamVNSzUwMFdtUFg4anVpOGtVYUlOK05HYWNHbDk2ZnErWDIzOWpT?=
 =?utf-8?B?VGtTZHFmL1huRVl5QnZNSFExVkkxdkJacmFWZENRMXZKdTkwbmF6dGNSTjdh?=
 =?utf-8?B?QS9wZitkWFFJcVFtVW5HL1A4K0I5K3ZZRldZQ09uWEtOeElNL0NlZXlVQzM2?=
 =?utf-8?B?LzRzenQ1NDlicHo5ZzRqcWRRQlR3bkZUVkQ4MUs3bEllcGxpYmZzenJBVnAw?=
 =?utf-8?B?UFVrVHdUcjNTTnNhckszZGNjTStCeC8raFNVWitnbXhvRE9hTTFwb3JqbXJV?=
 =?utf-8?B?ZjUxV202WG9lVTYwam5qVjNlOHVMWGdzRjFaT2tGZWlTc2owR2VUWHRZeDB2?=
 =?utf-8?B?WXNTMXVNRWJCdTFHMG9NQkEvdFZtY1dzRW52dVFrT1ZZZEQ1OXNPWXlWTitY?=
 =?utf-8?B?Qi9lbEtSRTFzWjNsaFlwdHEwSUhkNmNqYk5yeHNCU0hCODhjUjVnR0JTNWJH?=
 =?utf-8?B?a3haT1dYcGZOVHBKYStDRkpRNHBjZGliSitvaStHK2xoWFlMOThnVHBhaDNr?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2ffc9b-8ecb-4ee8-cea3-08dcf43252b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 13:46:55.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzImAdONR8fGTByuuiK91pODZJP7aykn3+JJlA6RPOqajJdHkdl9mRbCVyEVgehZLRTy12duXaip3bxl7WxQPQDdVucKhw/Q5+hacO8Db1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848

Hi Heiko,

On 10/24/24 3:32 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Haikou baseboard has an hdmi output port, which is connected
> via the Q7 connector to the hdmi0 controller of the rk3588.
> 
> Add the necessary plumbing to enable it using the recently merged
> hdmi-qp controller.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 50 +++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> index e4b7a0a4444b..e3596341b816 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> @@ -5,6 +5,7 @@
>   
>   /dts-v1/;
>   #include <dt-bindings/input/input.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>   #include "rk3588-tiger.dtsi"
>   
>   / {
> @@ -61,6 +62,17 @@ switch-lid-btn-n {
>   		};
>   	};
>   
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi0_out_con>;
> +			};
> +		};
> +	};
> +
>   	i2s3-sound {
>   		compatible = "simple-audio-card";
>   		simple-audio-card,format = "i2s";
> @@ -155,6 +167,29 @@ &gmac0 {
>   	status = "okay";
>   };
>   
> +&hdmi0 {
> +	/* No CEC on Haikou */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmim0_tx0_hpd &hdmim1_tx0_scl &hdmim1_tx0_sda>;

The pinctrl for HDMI is fixed on Tiger so we should rather have this in 
Tiger DTSI.

Why we have those defined in Haikou as well downstream is because we do 
not have CEC routed on Haikou, but it is exposed by Tiger on Q7 
connector, so basically, the point is the pinctrl-0 in Haikou is a 
subset of the one in Tiger.

So please have the following in rk3588-tiger.dtsi as well:

pinctrl-0 = <&hdmim1_tx0_cec &hdmim0_tx0_hpd &hdmim1_tx0_scl 
&hdmim1_tx0_sda>;

It'd be nice to have HDMI audio as well, but one thing after the other I 
guess :)

> +	status = "okay";
> +};
> +
> +&hdmi0_in {

BTW, I'm not very happy with this naming.

There is an HDMI-RX controller on RK3588 as well, which is routed on 
Tiger, so this will be unnecessarily confusing: "which one REALLY is the 
HDMI input".

Maybe hdmitx0_in would have made more sense. Anyway, I'm too late to the 
party :)

Cheers,
Quentin

