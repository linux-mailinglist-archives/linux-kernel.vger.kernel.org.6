Return-Path: <linux-kernel+bounces-415768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C539D3B20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88151F26596
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B31A2C0E;
	Wed, 20 Nov 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="DcRUwoWC"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2094.outbound.protection.outlook.com [40.107.21.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530B1DFEF;
	Wed, 20 Nov 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107190; cv=fail; b=FKb59KdFHFJJQkMpbQHvWfsoTJDrQl6a9mukOfrbfYcdZKD97tMcLqur6FsoQq4tFWLLlempk/C5ksFygWG3Rt9MfOEKdy8GB893RTnfW5tndldhLaODjGACqzqzX3KyDps0uWIpeKAJ9L231IIO452KNtdy3lzMDnox4L5YDKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107190; c=relaxed/simple;
	bh=Sj0IVLlNFQ0Y7JBO9kkRDNkZbFY4o0852UIJwpIiUjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L2P0YvRr2sdrX8ZTS8EhMvPp7zOqACcy86K/pwT/D4NiwR5RhRSay71UK4L+t8m+7XDPRp3u5rcszoKfa4qLk9De+2spKaj3uLSLMyhcXtTKPE/8xyZxXNKcvoxF+JXWsdjvuMWjJfpXo9TzK3BfOg3SCvrdGdhoQ9KdejjD6K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=DcRUwoWC; arc=fail smtp.client-ip=40.107.21.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLbV5xkI0BGqCG8hwMp3OVeXWmID2dg45FLcmJ6X+Bwyez4hL2tVwON9auzzLPIRDD4qd5IyltfRrCqncRinsqM8Oa2pTUBsQACmoYYPTTRLEZfYASbxRLQVwdHeya5P/SVnvr/gNSkoovU/f8rCYu0Zo6uXqc8l84rV+wAnjQiXccoVjAQIODx6bx+8k8BGfoOoNj5aRk61UeXAVTp7ZVD3jNoUz+cA79N6hhryu+EcBgvWhi1oiKw33jbbwGiXOeKFR3rfpGNyd+g0pH8hQYG8mXp3+07wv6BdNR1bjzXHPup9a56bEsQNPQu4i/undEWsPsAA3EqyMU1xwIFlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xtb1L/BECqqh2TzqQO7ieq8R/yPpFJsieu3zLom10vI=;
 b=runiQ+HgBIeN1vY4mvIpjNMtxqYuh1SGmGttc30sEkYKZv+/GW4NGPuSM5A8hOadMGyA687X/5wDiBTwHvBprvdhEczRe/rkK5PcLU6njaFAQsDrDy5c+Wbsw9ICbZI33sBzCTUC/Onu6s9c0sLCRGkzg0DBrjKCZi9EZsdJDyL9UdwO77Ga8CYGddZ8iTqbQ3eepsAGNWVMuVyf/c/6x+zZOh7fzTRftcFUhOYxq6l6lUua6UmfvdnYUo7BJpQTA2/IIIOLLE8w8SzX2Uggf0hOQU2isLh+bDa6YD6a0PNPv1S17vwTal3DL0M90Ois6IRL9+2DxzyLDywsZ5epjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=none
 action=none header.from=phytec.de; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtb1L/BECqqh2TzqQO7ieq8R/yPpFJsieu3zLom10vI=;
 b=DcRUwoWCAuXBdRTdzc6cXCxFVgICq3jUpeuyWtJSIoKzANdA0Y8iNbhfKV0DO0erc8fZpl7qsHrazax1V375iDE3EV4OxcGAYU0eM9KMqCbSMrmDAC1+RhSRdhRyk9kO73NS4lBObpj5bQaNiK/arBj88UjtL/n0noX/GIuAQxM=
Received: from DUZPR01CA0229.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::26) by AS8P195MB1846.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:52b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 12:53:01 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::f4) by DUZPR01CA0229.outlook.office365.com
 (2603:10a6:10:4b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 12:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 12:53:00 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 13:53:00 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 13:52:59 +0100
Message-ID: <9efdda6e-a401-4321-9680-905a1e70f392@phytec.de>
Date: Wed, 20 Nov 2024 13:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-am64-main: Switch ICSSG clock
 to core clock
To: MD Danish Anwar <danishanwar@ti.com>, <conor+dt@kernel.org>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <ssantosh@kernel.org>, <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
CC: <srk@ti.com>, <devicetree@vger.kernel.org>, <kristo@kernel.org>,
	<linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-3-danishanwar@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241113110955.3876045-3-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|AS8P195MB1846:EE_
X-MS-Office365-Filtering-Correlation-Id: af870ffc-6b7b-49ed-2257-08dd09624412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTV5c1E4MTRXSkdWKytHVG1xS3prVE00UW44V3g3bWxjT2s1YjVsd2ZDNjAv?=
 =?utf-8?B?VXQrQzV6a0c0ZVBUUUdSV3ZVNG9ncTJqSnpuZmkvUU1tWXBBaS9sY2gwQzRQ?=
 =?utf-8?B?dXFwYndUeGRXTTBlL2ljVGpxR0tKSktiRkQwbmp1R1FqanJid2hPekZWTzcw?=
 =?utf-8?B?UjBwcmNLUllVUElSYzZMc0doM0RHcUlSM3h6S0p1RS91YUozMUk0OU13ODZY?=
 =?utf-8?B?Z0tEdC8xUHF2N1ROTFNWSVN2bmRjZk5jUHNVbEpEZHoxTFVxck5sODFqdjZx?=
 =?utf-8?B?dWlxejNKaEp6RkNPUWZiSW5xeTZOV1NjVmhNWjFXbXI3ZVhuaXFpWklSQkwz?=
 =?utf-8?B?K3hpRS8wbkJOMGJBaWFyMUg3RFExenlLaHpWL0NpS00rU1BuWXQ0NFM2Qkta?=
 =?utf-8?B?ZlhSaHU4eVV4LzNHY2J4b1p2ZUhuWm9YMnFLcndVcGpmTzhBS01lR25jQ05P?=
 =?utf-8?B?MWRLY0NDeEM5NUFMVWE1d1J3NllnTGZqalBocXVMZ2R0TFJoOE1PNkhuRVN4?=
 =?utf-8?B?UVRWNVllU01wa0VwRWYzQndWV294bE0rU0s2QXVUbjVGdEtkVURldUNST2RB?=
 =?utf-8?B?cDJtSGg1d1djR0hsTE10bEx5NHlXRmVKN3YwM0R4Q0dFUkRpUzQwTGNpZ3Qr?=
 =?utf-8?B?VGtsNW5KcEhoUUVSa3FlTFZFNEt5R3VpZWxERVVmN0s3TWRVa0dXSlVRQVd2?=
 =?utf-8?B?L2k2VFY3MUptQkp1eXBkZlZuYmJkaGR3UWFWYzBGUW1LOHJnTytYT0lyYXZG?=
 =?utf-8?B?SHJIUXlKUVMyUWFUemVVZDlZMGZvVk44aVM0VStPd1ZzekN2aDlqZWtMVTRs?=
 =?utf-8?B?aGNhaHA1aHNGOHlCQk4rbndFeEhmemJQODhJM3F0SDJYRjFUbFJ3N3loQi9i?=
 =?utf-8?B?RTdhUEtOSGw1ajk2aEw1NVpKMDN6alltV2JaaG1nNVhXQ09jOGNIalNCNGhE?=
 =?utf-8?B?R3FCMEhDeVZhbEdSeS8wYkIwNUc2S1ZHZHdBYVZ0YTZVQVJVaDduS0luTC9s?=
 =?utf-8?B?dm4zdVlyMHJzSWIyK3RaSFI4RWJzMEdjSzhXL2xqcS8xb3ZOM2IzUjBWd21I?=
 =?utf-8?B?YWptQ3EySEFOVkNFM3FrWUVUUWk0ci9PZ2dmTkxDTnhQb2tMeFgxVHBLZXhh?=
 =?utf-8?B?eDZlRlY1QmlqcGpXbHdoUGtDRFIwdlNMQzN6eHlveVIzOVRCb2d6d0FQcWJj?=
 =?utf-8?B?TlQwRmZlMGFjVGcxTENvSXRQaUFGTkl0SlJjdWtCTzJsSkRhc2lTTUphZjM5?=
 =?utf-8?B?V0YrRVYvYThxTUlma0VvV0hyMWp0TWRScW9DVmpUa0dDQS9HSlg5ejNHRTZ0?=
 =?utf-8?B?UDJSdE1VS1AwYmJZRU1OVFBOR1FSbDBmQjB5NTBKakl2MVhBZzNMTWgwSndj?=
 =?utf-8?B?V0FzRXJ2azllVmZrZm1HSkNqdGhCb2tKblVYK1J6QWlXR0VkY1lLK01vNFhv?=
 =?utf-8?B?S2RpTVBZcjQxeU1aSE5jWVJnRDlFNFdlSlArczQ0T1JpRWlMUnFuaHpaZFBC?=
 =?utf-8?B?cVNvVnZiMFhXbDNtcEozK3ROSFZicmo0bjdhUWZpTmZ4eHp2L0FRWXNtWlZU?=
 =?utf-8?B?ZUxDdXBkRHlTcVR4WmZicHJTT3hUeGdBWmpOQ0FSaXQreW1NYzBCSjgrYXlo?=
 =?utf-8?B?dXAyek1rM2FhZU5xTDFPaERPVjZjeXpmR2tWT042L2ttbXEwbFh5bk55cGk1?=
 =?utf-8?B?WTAxLzBuQmZpVFlsclZQUlBWazA5Mkw0K2lwTmh4eXJQT2pUaUVjTW1lMWNx?=
 =?utf-8?B?cVlIbHlqSXJjRW9KN2dHYnZ5ZzU1TVFSb0NmemNHNWJmM3VUQTdaS1hnQTNR?=
 =?utf-8?B?NG9RSm1XZGR6N0JIZ1N2RDRzZE5YQlZVelkvUW1FNWkyNWN0cXJuOTFqQ3li?=
 =?utf-8?B?ZitTYWUxaFNYQjJRandwQUQvalhZeFREQWVZa21DVHpzRWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:53:00.9337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af870ffc-6b7b-49ed-2257-08dd09624412
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1846



Am 13.11.24 um 12:09 schrieb MD Danish Anwar:
> ICSSG has 7 available clocks per instance. Add all the cloks to ICSSG
> nodes. ICSSG currently uses ICSSG_ICLK (clk id 20) which operates at
> 250MHz. Switch ICSSG clock to ICSSG_CORE clock (clk id 0) which operates at
> 333MHz.
> 
> ICSSG_CORE clock will help get the most out of ICSSG as more cycles are
> needed to fully support all ICSSG features.
> 
> This commit also changes assigned-clock-parents of coreclk-mux to
> ICSSG_CORE clock from ICSSG_ICLK.
> 
> Performance update in dual mac mode
>    With ICSSG_CORE Clk @ 333MHz
>      Tx throughput - 934 Mbps
>      Rx throughput - 914 Mbps,
> 
>    With ICSSG_ICLK clk @ 250MHz,
>      Tx throughput - 920 Mbps
>      Rx throughput - 706 Mbps

I can see similar improvements. Thank you.

> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Tested on a phyBOARD-Electra-AM64x board,

Tested-by: Wadim Egorov <w.egorov@phytec.de>

