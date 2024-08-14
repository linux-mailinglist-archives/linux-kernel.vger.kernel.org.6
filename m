Return-Path: <linux-kernel+bounces-285846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74995135F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E064128268C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F284D8A9;
	Wed, 14 Aug 2024 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J6t2/Ofr"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64369219EA;
	Wed, 14 Aug 2024 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608305; cv=fail; b=lWLQWKhG6FCNrkiZHjrJCmMGjRSqAk8zfIi8mEcu3b/1y8KD7+aORMCOgSahwL1whdA+cmzo7H1WHipemS+XliBHEt/mDiTHWbCEvGUdTAFeOT1W+jU6cxGox5pSRrdFObC3f7AfwoPHQtXIi9GnewmJExKweWDZ6Ei3zAvI44s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608305; c=relaxed/simple;
	bh=uUh+irIVw8IdKnfkROpAJdowHP9oGZflYwtEUBYDCg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hEn5CJxuwcvVDbFcWyJzWtpykDBeBb3kpYzeeYd0bghHA2Z5IC1J0kU9MdeXq1LllUlKlH/ELtKlSG9LYfWGgRDst/Qx1bEnHTr1hdOYyDaBqnAuwr/RWwGt8FzchLY5diL8FhIH1uoM8E5+11YNGRkUwfxMbbq6n47pnan3v0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=J6t2/Ofr; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8AfphpJjXT7qHmhaxfY8YZKcYZullcX+tBYWNkLeDVbbRUVH0elR9ZF7ch8eApHmvDMlkCuRISWT2qy+stItY8pDF15eMol2ue5Fzea0vJxw+fqw6gLID1pPgTJmsPG7GDMMGrXslD74rAaHacbgKfbaeOc3ShK2y6eMCCO6sPc5YVLDsDRtWX+vHZ5kHIbkgNoZd+zhzhR4rPc8Q+rEeCdODbxjjmyr+gtURUuKYTnJ3ndIEhk5Gs5ZGxEID9cX5JRsSmQ45U0xYJU4G87JR07VtfAYcXtGVox1nvTlOQi17pfSJamrNQLtXGRI8+KrNi9KniwTVwGowQPF2IX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3WToWp2ur6fJjneOLOnR/ufxmJFkpIQoKSMuhif9GE=;
 b=xPQunIqQyP0J+8mIXbXnwX5GTwGvYeF3BkronOotQXGXek+wIx88mjZc7LU/tFhYXUckIYMYeTqI1UXyvBz08lPyJPTM+fWMFuKxLwob79/2btGQx5BrTd0G/CmwwjyEepZkld2WJEGEbzBqC83L9hWHw+i2/z3fs2GquZUHVtRrVoq3iz0SNiG5I7uhYiqh+jXU8SlSJtn/Q2TrbXPYqZT7X9Ku+5mT0t/uBNHr7o9ZxnKey+0W4O3bm8w+2F5tmmbaBjtfyACnZffI8L+8ZVq1LJpSPrjU6aWwaEIbbwqOQSBjvAoaez28VznJJ0BBS3ss09u0y3csFrmZ38/6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3WToWp2ur6fJjneOLOnR/ufxmJFkpIQoKSMuhif9GE=;
 b=J6t2/OfrIr5/ddVuc0ZjfoZOAl7nHadGxGhkHCFhILSUlcNDuXYh47pcvMh7qFBe9zsf5zAM6J3vLtqE29Or4GvkXrvZtBS2rMegOQ27VL4BHNaltFVwIARUutJulBT2EFXyYYOE9yhXsppEX12Qjt769PoER/vkGOWvbiQmqIMuZINCZt2eoFUXaDKVSM6p8dLrLa9wUWtLLOzfbuYyOUA1CmG5TGgZ23KWQ7hIIl5Q6qgY8mZfgxax2+OKgv1nhtxEWl0oyLxj8xfWXAv7sek8cy63CTC8p2wMGnXJ+XUVK+D5O+BiOdVapqDVdzL+p89Qo60d+Uz+p6JL6SalGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3534.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 04:04:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 04:04:58 +0000
Message-ID: <4295a15a-6285-4005-bc40-328e52addc2b@siemens.com>
Date: Wed, 14 Aug 2024 06:04:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add and fix ESM nodes
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240813230312.3289428-1-jm@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240813230312.3289428-1-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3534:EE_
X-MS-Office365-Filtering-Correlation-Id: fa744b9d-a6f8-4334-c764-08dcbc164371
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	StCD1N7EdDdAYuvq5q+ILlTiiyCyMe66nzKkBoxTzVWZJanVZwllCmJbggrtr4UgSunTIE/Wmq6bGAShJr5p00qvmhsrYhkVgQY+DAdbUIGob4G/MW93X+lB4JDlZXhp7N8FQwZo4SN6WQYlpRkg3+u4D3M80dlce9PWG38KBxYx8uTt3ups8EwII2QY1SKUg/jPlbdxoAHyTzzbDYHNwOQDK1YF3ksIAu7eFUUnegPEVwwOKdY+fOdKWCLH2QNE3j1x3YVlHuQ3qIEYRm4D7k6j+9L6y+12Ej58a3puW6VlEI3EFRTUpW60UOCxQZevg273j19RvxyoQGTn43bTbE4ttGEBj1YDdm6GkwUaQow7fTMx0Zac1YxcX7pagYzeAdxwoOlULdBng7Jj4b3ZZejeo3avu1nr84pUubKY8ybW0Oi/sRvG6a8e75xiCD8gpuc0AVHdLjt6jBj0oobzVQOOdlhSvD7Bw8dq7sccPzgp+185CSbqHLcrviLxIph5Kpph3X7ycxaCtrt54UD+Ie/XahqwfGC2djIwVPJ/TNNvpyWk0QRpej8u3RV6VUIMESgVr6gMOz/6hUaBft3wwfUCwrGUQQ+mbahPdmodtSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW55MjVLWXJuUmQzRnhBaWMvY1lRK2tkY2tNbXhJeVN0ckcralFJRUkzYW9k?=
 =?utf-8?B?V0pVdHZ4MHpHSjcweE5QMi9jNDBpanBVWkE3cXRNb2x3VENZUWpONXVqMTRU?=
 =?utf-8?B?TmpwMS8xUkpzYkhlNEJFaVBzRnl5dVhVR291ZTQvVVZ5R1ljL0tDejQrM2tD?=
 =?utf-8?B?V05pYktBWm5SK252ZXdWd3ViSG82WnlHaUJsaGZvaVRqck1uUk0zUW4zaTJR?=
 =?utf-8?B?bWs0S1BLU2MwRkxTSHg0UzE3TUVOeDgwKy9iVEdIVk0vb0c2dVVLV3lmZi9m?=
 =?utf-8?B?K1MvOXZKZVlGd2VoMnlyakVjOW5rejZ6ekhKUzhLb0dOMmM3b3U4NE5ZdFdi?=
 =?utf-8?B?blJxcVBUOWpFUUExaGV2YnBrdmFXWXhiWnRuUTVlaGd4NWNXdTkvSG1yWE9N?=
 =?utf-8?B?WWdZZTV2RTRSVlNyRWdYNFphdGdVWlRrc2djbnV2R0FSbkJjZGxnaG9JOENI?=
 =?utf-8?B?YWYxN3dINVRZSmpyNTVVNXkvc0ZnZlBFV0VLZEpIVG9xeU9hTHZaczRBdXFk?=
 =?utf-8?B?MXhMS2FwMjRUUjY3NlY3VHRKV1NnMnZXbkFTTVJlZ3NZOFBxRmhHdnpmYy9M?=
 =?utf-8?B?c2hDQVlWc0lCaktXZUo5NSs4b1ZUSjhzWnFkV0pvSDY0c04zcjlPUGNuelBn?=
 =?utf-8?B?anRUd240WDQvMHl1OXVLckpQQXhBbHBTVjNZSjlhQXJZNGdMbDUrZ1lQM21M?=
 =?utf-8?B?QmtrRlhYMnFyTVZISzIzWUJVN3Z5cXFoWUZJNktSTm5la3l4N20zekhOR1Rz?=
 =?utf-8?B?TjJLeHZHRTNveDJ1djhkVm9TNGpXaTRlb2JtU3oyL2ZzQ24yVExmY2Z4Vllu?=
 =?utf-8?B?alZBOEVOZzJDcUFHOVZiVnJrQUE4MS96aVlpaGRWQlF1dXcrRFFMRzF3ZFBt?=
 =?utf-8?B?UWdtaDdYK25KQmxIU3dpcURNSlhiZkhORFloczZiVzdqa3hXeHhaTS9RZEJS?=
 =?utf-8?B?ZVVJQTRYVkY3dzA0Y0hNMXBBQmNrTFYreEhacjM4anh3cndKSmZ6VCtPM0VS?=
 =?utf-8?B?OXppcW0vVm5pdW5hdytUdXB6THE5ZnlDQXk0YzhTS0RvNkV3T2Jmd0ZtbUFi?=
 =?utf-8?B?blVabUNrR2NPYWs5SmVuaEp0eE5RZ3lWeTdSLzJPdytra3ZOcU5uZVZnTmpE?=
 =?utf-8?B?NGhpRnVIak9oZC9rOVA5NDdPT3pzTlp4ODdtQS9hdHhPY0JBdWFhQkR2OElw?=
 =?utf-8?B?ODJicmFPajlueXB1QkNMWWhBSW4zMkZic0pVM2Q3OG9SYjBTQ2JuWXZIRkk3?=
 =?utf-8?B?NTNZbTFscnVqM0lUZGIvRWw4ZzlHU0dGQlV1U1dYR2lRb0k3RERlVTNyNCs5?=
 =?utf-8?B?WWpKbzE0TDk1RHFoZEpqVERENXVSTG5sN1N4WkNOQnIzZUMzYVNBdlU0dWlr?=
 =?utf-8?B?ajJ3OGpZZ0tzT00xaXVyUEZ0d2RJRjZqdFdUS2pnb1hoc1V6OUlDeFJtWGlh?=
 =?utf-8?B?N0RqZGlKajVVeWlyWmpWQUlJMWxhdEVUYTRzWTMycEdPUGpFOTdBZ1ZZQWxZ?=
 =?utf-8?B?a0ZaL0Z5bW9ubEhEMEtBc2V3SGlFOGh3OC91cEFMTmZyYmdwaytkRnk1WktQ?=
 =?utf-8?B?bkxOVmFCeGZINzlaLzZtVnJDVDlZb1dBWGlJdkdqemFNSlNUMW1Mc1ZoZlkx?=
 =?utf-8?B?YWJkcUVENXF1QlNCTnZBVHpmK2FOdW9zdUVFR2l1dGRWQlVyREJJbk1LaUMv?=
 =?utf-8?B?QzRDbUFlN09EamdYYjkxWGFvSGkyNlQvZnRQaDRuRmpoRURmV2hjaytCZWpQ?=
 =?utf-8?B?UXIrMzhLVGcxY1lOSnR3aDByNXVsQms0VjJoQWp0Z0tOUjZyUDROS2JhQzlH?=
 =?utf-8?B?RjNxTHFDU2dSa3JpUzRoMVYrOEpCWXUyM0VpS3JaSWFkd2c4UFJTYmtNRHpq?=
 =?utf-8?B?aGt6dU90Rk4xMWFxcTd5cXliSnFENHZ6UmFCNlVMT0hTR3JwRTl4U3hUamlT?=
 =?utf-8?B?dE9sZEx2bExvd0RIZjIwVWIySGQ5MWtJZlY3OVFVVEtMRjY1dDRSdTdzNmlI?=
 =?utf-8?B?QzNVNWd6dUEyN3pxZk5FalhsOU82aGNyeE5zTVl3OUtuMXdTS1IyOE90QlNC?=
 =?utf-8?B?NjhKQmtEMFRPUGVYQ1FGUXNPbzZJK3JGYis2M24vclAwanFJSUIwVTVGT1Jx?=
 =?utf-8?Q?pKlcqLnXgHGDPv1dxstH/DoSm?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa744b9d-a6f8-4334-c764-08dcbc164371
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:04:58.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP6mKHf1HPMZhDp4gBqbbmA2CORN3ClCQCAGy5F1nni00PJmEI2AK+p2X4XGIFRuoexgWIR9zgZvJ4RPYvQapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3534

On 14.08.24 01:03, Judith Mendez wrote:
> The following patch adds ESM nodes and fixes ESM source
> interrupts for Sitara K3 platforms. Currently watchdog cannot
> reset the CPU because of misconfiguration or missing ESM node
> in DT.
> 
> ESM node was added for am62ax and am65x. For am62px ESM source
> interrupts are fixed. Comments were also added for clarity on what
> source interrupts are routed to ESM based on device TRM.
> 
> ESM nodes like MCU ESM for am65x are added for device completion,
> currently, some ESM0 events are not routed to MCU ESM, so watchdog
> cannot reset the CPU using the current implementation.

Yes, that's why there is https://github.com/siemens/k3-rti-wdt and
probably similar bits in other R5 firmware. I was always told that is
the only way to reset the /system/ (CPU alone would not help). That
information is still correct?

Jan

> 
> Changes since v1:
> - Remove watchdog patch
> - Add am64x patch 5/6
> - Add am65x patch 6/6
> - Add missing bootph flag
> 
> Judith Mendez (5):
>   arm64: dts: ti: k3-am62a: Add ESM nodes
>   arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
>   arm64: dts: ti: k3-am62: Add comments to ESM nodes
>   arm64: dts: ti: k3-am64: Add more ESM interrupt sources
>   arm64: dts: ti: k3-am65: Add ESM nodes
> 
> Santhosh Kumar K (1):
>   arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                | 1 +
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 8 ++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi               | 8 ++++++++
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ++-
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi  | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 ++-
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                | 3 ++-
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi               | 8 ++++++++
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                | 8 ++++++++
>  10 files changed, 42 insertions(+), 5 deletions(-)
> 
> 
> base-commit: e3cce1229c34b5c28f103361c4d6b3ef17302d5d

-- 
Siemens AG, Technology
Linux Expert Center


