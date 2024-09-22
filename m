Return-Path: <linux-kernel+bounces-335292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A264497E3AA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EB01F2121F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4137768EF;
	Sun, 22 Sep 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aKO0AwaO"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E06CDCC;
	Sun, 22 Sep 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727039379; cv=fail; b=O6pLwZmpnITM9JpbrIHkXt027gNfQocARsjC8JnrP0Xcjk0rAg+cSd8Wg6p0ukXZWcIcTgGSCUaUIlNUuKOKqDGWGPOdrPqEXhz0TRQiVICPcNaJR/hzYxDhXXbJ9hqOQ7T6zVvbN7qc54j504nO++E+K5zFgik5UAFpPbvBgkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727039379; c=relaxed/simple;
	bh=B4i2pbBje5/zUa6MB6bpj/TaxGxdc5OTQkcQ0jg9mpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5Ax8vQx0pNBL3/Fx9MIdbTMRL6fffdENDBo+yUkWCTnXrypWS1TRGfCcF/rk7aweHyqWCc2qf9xnif2DYONPCWfKP7ZqVjdn+L62AVIcT7Q4XOEYk9Q++ZrSZ5LEOrpJHZEtGc07mEN6Cx6NQGQOGRNUewclmEJp3thvubKCR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aKO0AwaO; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MKvbb6012596;
	Sun, 22 Sep 2024 14:09:20 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41sugnvv6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 14:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNxT/0exOedfuggeDqQ7SbAQ9/r/YwHl0ikA1R7CgKVRV2i6ou6azyHXi1NyCRQza1aaqzX034BL+70T1quiRzI3vsc/O7f8Al6UTlXKN8cFglOIDKRme65YDJg3tthyzvXQrHh+m2qtm76s3xM0wq+zseIKiQdyG95s0G1Djgnw6QbaJEhi6C8ndxbYE7JjRRsVYr/OMEMdEmpUeKsnsVZT0craqK8EGa8MLbNJuWisgu4RdS0AINI0Q+pCTQhg5S98B4DaDO2hZNudU2vk09hAbeAG/8aDV85GFjb8vIdCzf2Ei4EnjTxtNjeuwI66IUpyci1CITviph1BkMdZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOscVQJWg+KAb68dqp0Xz5EqHW4yhtvF6sQKb1uPw24=;
 b=AvH3gcHH7kVBWaO8SP103ZKbppYYy4S9oVex56CxFXQcpTF+IDaA6Yy8YG7zRwypzPTkulPtBZTMivqXwLprSOPXMx7Qjkrlh/Ym+tdYTtbpd6yOgA4RgsYZyt6koNrzuwHvltYN4Y1Dj2+A/mCvME6WjQoylYH0atwtFQ0RD6E7jVSwe2yXoBP5yWFcQodsILMK4cAiH93A/mnyqgpJAaDYzZhyb0PJXiFrefe4K48dGQoG1g30SgHcPseGKlpLszDlVQUzL7Z01JVN6qw60S7/ACeovhKN7zlCOxGkPQFOzqGIZojeZ/BnBnD4rtPXkuOqAO/Op5Gb6tCW14BXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOscVQJWg+KAb68dqp0Xz5EqHW4yhtvF6sQKb1uPw24=;
 b=aKO0AwaOfnaQ4x6KkR+zwpzginnoqe0yF11M/li+gc+7ijt9v8DP6IzscDNg9Nu/eLA51kXKwhPyaEByxJ4wXZoEH1zWf5ldhs8fofqVfK9gBxYqYVhpa5q2Cv1wjuaf/IhTTCSwj+w01HX0TUFlXfR+ml0hTRPDRDW0Qx1hV48=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by LV8PR18MB6232.namprd18.prod.outlook.com (2603:10b6:408:265::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Sun, 22 Sep
 2024 21:09:11 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 21:09:10 +0000
Message-ID: <9f8d4e5e-963e-4717-9a28-9181ea662024@marvell.com>
Date: Mon, 23 Sep 2024 02:39:15 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/5] clk: mediatek: clk-mt8188-topckgen: Remove univpll from
 parents of mfg_core_tmp
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
 <20240920134111.19744-3-pablo.sun@mediatek.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240920134111.19744-3-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|LV8PR18MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: a997c032-4687-4a05-c6d3-08dcdb4acdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW5Kd2Q4cHdDYk4zbUlCd3Q3NDFkeTNnSks2ZVRLMXZLZDQ4VEI1NDNJZko4?=
 =?utf-8?B?MEc5N01TNndHMzVabmE0N3h2WkNkWEc3MFJuaW1XVlA0KzFWbS9pOUd4WFRl?=
 =?utf-8?B?V043Q3pNWHlUNE96ZVRRNDNGRUtEa3FpeStQTHdWM1A1aDlldUR3TWJ3S2lV?=
 =?utf-8?B?RXdFc2NISmhGUzAzRDVzdDJFT0JVVzg3aFRub2kvcmlnRUxWM3Jlckg3Q2pk?=
 =?utf-8?B?NGF6Smo5RTh4UUJxYkNsVkFmMUpsOEJyVFd6dnJUd3ltNHlIUlgvZE1xSVBG?=
 =?utf-8?B?bERmMTdkN1JkcUNnRFFPQUVBUjhyTm91YlNTRXhxZDY4bTR2VGVTazNDMGlB?=
 =?utf-8?B?eFZaZEFvdHIvZnd6Ym9vWmhiZjlscEMreExCOGVGYS9vRmNnZTFsUFlzaWEx?=
 =?utf-8?B?dkRxc00wM0FrcG1vYTlNOHl3RUlVNVcxK3llWW56d3NJOFIwTGNuMkhjNVI5?=
 =?utf-8?B?cFhZQTV0R0hEUWRWV1MxbXBPZDZLU2ZPUXQxdnJVRDJDYldVeU00R1NxQzVY?=
 =?utf-8?B?VFMwOVFVdkVnS1NIY2pxNWZYSnBRaHZVVENsZGw2ZGhsbHJXRmNVRGYyOHEv?=
 =?utf-8?B?elgzV3FuWlozUnZ3RlBGQkNNb0JmRHZWVFhsNGE4aXhiWFAzV0VxNDJLRk8y?=
 =?utf-8?B?c1RlSGlIWnhBVWRBM2NCampQUzFXL1lVL3hCcGZNK0U3YVRDSWpmeHp6R2lW?=
 =?utf-8?B?SFZCaUg1Z00rRFZ0WlhNOHlyVTlybFgxaTQwVytoRnJZWG4yU2ZlQ3hCekFa?=
 =?utf-8?B?OWZkWkFjVHk5T0JlYkgyQmE0ME5yWVRhQXFvTnNUbEIzQlVNZGhLaC9hRHNx?=
 =?utf-8?B?Q0FQTWt2L051WHoxSTlhc2VIWldzb21oajcwSzVNelRmOWZCa09BK2l0TDNI?=
 =?utf-8?B?SnNWbmVnS3NHTFZxN1dpSVBySVpBc3pEcEVpdGJpWGd4SXRJZDlTMnZyMzJo?=
 =?utf-8?B?NVdFREtvR1R2Yi9wdnhhdUQzSXdwTmtJNjZmUDNsanVSSVRSTUw1VUhuN2po?=
 =?utf-8?B?ek96NDl3U2Jud2lwTTdYVlVoZzRWQks5SjlLejg1Z3lna2daNzJWUk9xVUtt?=
 =?utf-8?B?SVh5Vml6eERHdFh0bENaWGxLVU5tYTNyb1A1Z29MUlE2YWNvUXNROElFd0hm?=
 =?utf-8?B?UTFaYXFhQXhlVTFyKzMwVjY0Wm5rUTF6Zlc1UTBMRmFHWHk1NEgxTVArRURZ?=
 =?utf-8?B?MmdwTjlYMVMrNG5iOVZlaExhL2hJVnlPMlpnVWNteGtCNUxFYjlKZ0Y0RWJw?=
 =?utf-8?B?aE5nTFp2aWhid3k4RFFXU3BRYzl0UzJGbzdDWUFxaE9NSE1GQ0NDdW1vZENn?=
 =?utf-8?B?eXowWW9wN2sxVjhlcGNMRjRxYlVIVXJKcFMxandneTZvQUhkcGRPV0tDN09K?=
 =?utf-8?B?RlBmOGtiWXNPSW1zTk12WjJjMjJVdDBqN056SkxiM2Y5cHoxNHBQMDNCZkds?=
 =?utf-8?B?UVV1K0JpVUhDL2hZZFNIUHNvK09PVS9wQkw0V0dYNWF2RW54Qkc4MURiblp4?=
 =?utf-8?B?aW5xOW0wYm5WMFE3bG0zV1dYYUxNOTFYT1RIVmgzaFd2QlJtVWdUdHBmZVB0?=
 =?utf-8?B?bG03WEE5YmNuQXZEWW9mdzdmbkhYd1BzUlNsYmVwNS8wMEtqcUJ3WjhOUlI0?=
 =?utf-8?B?UzRrdEZGc3o4UzVxU3hvdTJieTRhVlZ0a0xXdldua2hxTVRYWlVlaDRFbmp1?=
 =?utf-8?B?aGhtdi9BcnFpUkdFMlFxbWV5cVZhQUpnMnI3Y2pjK1IzMCs4VzBSMEl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wkh6VFlkNkVvV3VEUkxZOGlZeU5tUlpwYzZOd0FTNEloa3BubVBvOUx3MXJy?=
 =?utf-8?B?M21aYzBya1NwQWlWSWtjYkl6OVhjb1hCUVl1Q3ZwYngvM1liMnY0NHhYVnIr?=
 =?utf-8?B?enhUUVJDaWRacVpmVjMxOUtmdU03WE83RDNac0FaeVVYUlFBMDJJcnZsOG5n?=
 =?utf-8?B?NEFROGNTU0haVDZkWndTMnR1NzhrY010bFJVNnJ4VG50Q1NkcURnRytibUkx?=
 =?utf-8?B?ZlZyL2VlV1lOcXRsWm5lN0ZpVU0zMjFObDFQa2pwazREWC9rdURHeFB4VHFn?=
 =?utf-8?B?R1YrbERNUGI2SEFUR0xwd3RnTndnb1gzQ2p4U1NVR1MrTm0wOU1hSEl4dUFu?=
 =?utf-8?B?V0F4ZjBGVHJOSklpRFd2V3BnMFR6eFkxVXVvMDNwcmdjMHIzVllLYmZOeVJH?=
 =?utf-8?B?eUZkeFVRR2hyME91Mk9zQkdOSkhNak9DaStqQzkzMGZySk9kVzhMaS8wOFF3?=
 =?utf-8?B?QnliMy9kTFJCZlVnSEFwV3dEZy95RE9MaHVUNm81dUtacU5ieEZMNVRQbkUv?=
 =?utf-8?B?OCtlZEdweXR6M2p1UG9RYVk4NDJzVWUrbndZK3l0eW54TTRqVWlHdXNtbFpt?=
 =?utf-8?B?RUs0SGRCV01HdXBEeWxkbzJrN21xaUN6RTVPdHNCSitMd3pCSFA4eTFhdDhk?=
 =?utf-8?B?ckpseHNsNDBDbmdaYU1Gbng0V1VKTHhsUXBLQyt6aUdaMnMvVElUVmNyK3pS?=
 =?utf-8?B?RzRDYnJqVGRPLzYxRlpDNG1HdkNsREF4dUNlcW5GekdBcEg4UC94OUJrWWZI?=
 =?utf-8?B?QWlyQjdXNnA0cVNpU0luZ2gzSHlZZGhvVCtlMkF1ZFJ2NlVLSVdWQ21ETGRN?=
 =?utf-8?B?ZXF0U3pFc0xtT3dENnFRdVRQUDlIRFB5ZGYzTHRaTzhsQ0JqM2g3Z1B1akN0?=
 =?utf-8?B?VnBQa0lPMkYxZ2FrOEZIZTNiYThLTVJvTGMrOFgzaXFHV1RtQ3VabkV4THUw?=
 =?utf-8?B?aExZWm5OUmNyS2RHOVJJUkVZRFJGSkxJM0xrM01lcFF4aU1sbmRQVGszbldC?=
 =?utf-8?B?NDhxNFI1OVZGKzdQNnRROUNkL1Y2bmcrQk1JdEJ6YnpXbVpteTc4MUFjNUJU?=
 =?utf-8?B?VzVRdlNCYmw2WUJER1dpTVo1UEtYSVZlNUZkZkFSQWx1V0FETURMMUVpZ1Ju?=
 =?utf-8?B?K2RXUlNwNU05Yk5hZVhVbDkxSTYydGxWVGNFYnhiTUQxbXRydEkxTmRMclI5?=
 =?utf-8?B?T0ZRbGpuZnFlVlppVjNCeURpOXdjS3ZYUnZIU29jNnM2MlF3VDBzSTlteUg1?=
 =?utf-8?B?Uy83czNibWRJUHJzbjQwR3pUUStmbW1xT1hzMEdvZWRWQkdodHhQQ24vSkps?=
 =?utf-8?B?VHIzTzZSOHdoWXUrbTN5ME81aFlkZm1EKzZpMUM0MDBGaTBka0piaC9OQkZV?=
 =?utf-8?B?NXJUVWErZHFuVTI2SktzQ25ybk8vYTE4MTZybk95MldBY3YzMkZPVjcwTTlY?=
 =?utf-8?B?akc2Q25TNUx2V3YwdWNJUkJhMkUxOS9vMlhkYjB0bURJUXBKWEVtY09IV3Ji?=
 =?utf-8?B?STJXWE9aSVFHNStoVFFwZDlwUkNzc1pZM3RWNHVCeG9GOHhvQkIzUmpsT2p0?=
 =?utf-8?B?Wks0YmU3Z05uaUFDaUhJN244UkdVcHVVNFhkRXJpb1d0TTIyU3c2NGlTa3Ev?=
 =?utf-8?B?Y2wwSjJnWUZ2U3l3Q1h6MDBiTFVVazBmWDMwTnErblZuZ3kyc3VRWFQ5T0xV?=
 =?utf-8?B?bmpvV0NPM3lYM0NZSmdSZzJlcmdneGpFdlF5VFVHd0hGSDNwOC9GWmJNbnF4?=
 =?utf-8?B?djVTY3FXc3FEa0E4ZnNnUi9VK0dJOEtReHlPWVpUYzQ4ZHI1SjVabUhwZTZ0?=
 =?utf-8?B?THZBRFZnazVxNjB1WEVrdHVOZTllSW1YLzlXTUtVS3FVdm4xRkJveUhEUTk0?=
 =?utf-8?B?MjZrZDRhd3pUVjdzZFRjNUVBL2RONEtzSWpETzBUQUpzRDBDdEZNUUZwV3NS?=
 =?utf-8?B?NmtzcjNNd1kwOW03M1FmOFRNYlZYYURocHlrRmlzbDN2U1FLNG9aM0N1RmNh?=
 =?utf-8?B?MVlzdVN2djhKOU4zZmdnV1hPRUxpS2FEZzV0MTVrQkFLMUdoK0s0NiswSXJE?=
 =?utf-8?B?SWkzeVJDN3k1SC9HK2c5K3FnOWkrdk5jRCt4SHFOeHlLTEJWV3RpanJGNGpo?=
 =?utf-8?Q?GR2HLPHqJn3AhtdYd+b1X9ctu?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a997c032-4687-4a05-c6d3-08dcdb4acdac
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 21:09:10.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDlnRMJGpcXvqdKckulInFNy6IdCpiJIgVvAhrLU42O1ZnrxalT0fYEY2XDw9DHd5awl+sCQxR7Cmo40dkAzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6232
X-Proofpoint-ORIG-GUID: Wg_kyZsDjQe6TGVsDR3gZ-jlK4ivAapD
X-Proofpoint-GUID: Wg_kyZsDjQe6TGVsDR3gZ-jlK4ivAapD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

> Same as MT8195, MT8188 GPU clock is primarly supplied by the dedicated
> mfgpll. The clock "mfg_core_tmp" is only used as an alt clock when
> setting mfgpll clock rate.
> 
> If we keep the univpll parents from mfg_core_tmp, when setting
> GPU frequency to 390000000, the common clock framework would switch
> the parent to univpll, instead of setting mfgpll to 390000000:
> 
>       mfgpll                            0        0        0   949999756
>       univpll                           2        2        0  2340000000
>          univpll_d6                     1        1        0   390000000
>             top_mfg_core_tmp            1        1        0   390000000
>                mfg_ck_fast_ref          1        1        0   390000000
>                   mfgcfg_bg3d           1        1        0   390000000
> 
> This results in failures when subsequent devfreq operations need to
> switch to other frequencies. So remove univpll from the parent list.
> 
> This solution is taken from commit 72d38ed720e9 ("clk: mediatek:
> clk-mt8195-topckgen: Drop univplls from mfg mux parents")
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> ---
>    drivers/clk/mediatek/clk-mt8188-topckgen.c | 7 +++++--
>    1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> index 2ccc8a1c98f9..74ee692ac613 100644
> --- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> @@ -342,11 +342,14 @@ static const char * const dsp7_parents[] = {
>    	"univpll_d3"
>    };
>    
> +/*
> + * MFG can be also parented to "univpll_d6" and "univpll_d7":
> + * these have been removed from the parents list to let us
> + * achieve GPU DVFS without any special clock handlers.
> + */
>    static const char * const mfg_core_tmp_parents[] = {
>    	"clk26m",
>    	"mainpll_d5_d2",
nit: Comma at the end of mainpll_d5_d2 is unnecessary.
> -	"univpll_d6",
> -	"univpll_d7"
>    };
>    
>    static const char * const camtg_parents[] = {
> -- 
> 2.45.2
> 
> 


