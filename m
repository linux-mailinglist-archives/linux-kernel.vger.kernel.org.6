Return-Path: <linux-kernel+bounces-564834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D110BA65B94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0061288095F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FA1B043C;
	Mon, 17 Mar 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qc8jI6hU"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020110.outbound.protection.outlook.com [52.101.193.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202F1A3171
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233997; cv=fail; b=rG8qnu0spxgJP5ihaVbJFS5AplpRsYRIEVl2dUGxDqXSQDgAPC1SxVPoqvQcN4+2/uBXvIpcyIkfAB+PKXzCiQyq2vPpjOXR40y/nYX2ELNZFIaY9W/K3qTlbBYIFx92kvUcyKBMudK6sWwf1hgRtpBiJh56ayw2qqu6CY2WVis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233997; c=relaxed/simple;
	bh=WfYQx+eKoGbjM7GJaFsiwWurA03TUa2XV1yII6Vpg+A=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JVOfWe2EddHUtk0icdlQQRH/cbQvBuXRoX8tvPCg3sjCbUCqW4ZwlUH/7zi2F8izvKN7tAe/8xDjUtcE2BjWT6hfvLn0W9BGEWa8Lv9UP+QyLNssTUpvX3i6wwjbNWUfRU/2sEFmgWZPAnyri9o1wdb9ffOozXp7Xg4t8n5IA2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qc8jI6hU; arc=fail smtp.client-ip=52.101.193.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6vpxlPWdfecBhuYB9dS9LBl8xSCzYk94fvxUQBLa5EE/yRaSzHCvB73fat4lrQqwy1aL8l1cTo8imMr4aLpciXQg35Ll8Zei12q+hMxJ+4+sVRqN19cjFNNGELTHGqFzdNL/WsKaG/QE6hr3Sb9ytZLbnwPVo3FQqhnW3wwUDURb1/f4SrkV7hd+us9CqCEmFDuzjDhu/jaPUAq7pwyaKc8fvnMA2t6op4TIfMXq414B3xDzA6WgV5iUNRt3dAKnoB2zH6+ZVikdpgCV3Q15M1ZwhPndlu3J9TbwXTXqIhT9J0+plqymlg6QbtJJ/X/yjvvhC8TxbDa9e3HzAeMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abTzTtad/WUB/Wb5tYVII+D0JZkbFdwAwBX2gznvChE=;
 b=EJM5HboOWV1Y0AFdw6R2aecXSzH8KM4mdIzUyiE+9dhcEMhuOSnamMpUxxv8RPhj9mJXAoT6Pz5rv4GR3+wGYi+kIGOAu3SMlfwRP0+rLRH6PpgUtVU9FHDfLTLb4/Ka+ChmqjSNZxsadVJ10wMnZ6a2akdjNENsjeYTvQLCJmgJY8H813ZNxARg0KHjOzBrjzau1QyT0/Tm7aNxbyiwJg2/XejULOoGj4iJm9gkgl9CQlysG2VyYxKCoNP2ab8VWKXbE71PL+IwPxkMzSTRvoufp3r3+kwY+Md488ZqnWgBfcMOqodt9oj9fb5x1rd+jQlLxqNs/9wwvgAPzPYPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abTzTtad/WUB/Wb5tYVII+D0JZkbFdwAwBX2gznvChE=;
 b=qc8jI6hUJjt8jiNILCy4V80zgIu+Ug3ssUdnfw1qpVtOP/OnWfwb12Z2LVsizr7s+I4Sa1mxPogVhAGV7QTxxBQ2j8L9c+gAFIZg0OGlmOQjUF0d7oPndXZqV7g6YHatCT0vWfRVNIF9EV8v5jwjT41jWJbB4gudbjxnagABQdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 IA3PR01MB8721.prod.exchangelabs.com (2603:10b6:208:53a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 17:53:13 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:53:13 +0000
Message-ID: <2b715836-b566-4a9e-b344-9401fa4c0feb@os.amperecomputing.com>
Date: Mon, 17 Mar 2025 10:53:09 -0700
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [v3 PATCH 3/6] arm64: mm: make __create_pgd_mapping() and helpers
 non-void
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
 <20250304222018.615808-4-yang@os.amperecomputing.com>
 <172bf7a8-4533-4627-83d2-552e4681c360@arm.com>
Content-Language: en-US
In-Reply-To: <172bf7a8-4533-4627-83d2-552e4681c360@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5P221CA0087.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:9::30) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|IA3PR01MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: f0185da1-d7be-4f3c-7aed-08dd657c965d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWRseUhuUjIwUmtEME5PeVVmVVE4c0xXdm1ad1FJZlhHWWUzaGhtVHpFeGdr?=
 =?utf-8?B?aTVvMDdJL0pNUzVzaHVYb1dtYnNTcEFWOUlQb0lhdXFPMXpEZk1MVGdIWWFZ?=
 =?utf-8?B?eVJCejlyMUdaYVY4Yk1zNjRrTG8vOENSQWJZcFNJbjZXSkhOY255cUlnZS8v?=
 =?utf-8?B?YUU3aURSSHdPMGw5WFRWL1BGZFNlVmNHVlhDK2V4T0d6YnpPNXB3ZmJQNmYx?=
 =?utf-8?B?T3RPb05VVHpDdWtpRG9OU1pPRFZtQURUSnFzV2NxbGJCTFYxb3F0QVd6YnNw?=
 =?utf-8?B?UHFlTjRlUUtydml5SGdhdno5Y25JcmordFpSU3VpeXJyMm8wNmt6dzZ4WmNB?=
 =?utf-8?B?SVo3elFlQlVvVHpEK1Z3aUZlcDk5L25renJrWmU1cnN5VVNlVGpvZWxYaWgy?=
 =?utf-8?B?Q3FlekZTdFBFeEphUGRRUVc2Yk52MVppaVgzaElyVFNHMXBZTHJ2T0tVb0Er?=
 =?utf-8?B?eXE4R1hMYWF2dThmLy9VbnZ2aE1EZzczOWhHSFJoOWo5Z3d3MDh2a0c2aDJ6?=
 =?utf-8?B?UXNoYkdOSVhpOS93RkI3RzVzUEVGMHlZMDRCbFlXbUM4MU15N1hPa3Y3Z0Y1?=
 =?utf-8?B?Q0FvUGQ2S2FCT1M5RzdoMU5lRnFOdFlaMWx4NDdqUVppcDZhQ0xxTDVpOUdp?=
 =?utf-8?B?WUtBaENaMXdkOFZjb1hXZUVWQlJCejJtTjRVM053RlVZZ3pEaVoxZU05ckVx?=
 =?utf-8?B?WVhTNmI5QXA3R1ZrRkxnc1ltZWR1eG1NWERiaWlqRlpuVXlUU0IweGNOTFpi?=
 =?utf-8?B?YTFJY3p3UWo5WTJ1aTREYTlnQkkybEJSOXMzSHpKL2d3Vi9nbHoyVlU1MVgw?=
 =?utf-8?B?TkZLZnpHQ0c2UU1FbTVWMXNiT3NNMHgxVFBFWDdwcVFTaG45R01xSHVXQ04v?=
 =?utf-8?B?UlRkcFVpajBmUU82eXhLQi9aQ2pjRzBIbEtKcnRDdll3anRNZ1BzMVFyclN4?=
 =?utf-8?B?VHI1VHhsUFMzOHlOUHpBNjVDS0srb1FHaXZNRzU3bmpnTkFhamRXTGFGV2U3?=
 =?utf-8?B?MUd6ZmQzT2VCcXlEV1p0Vkg4VFlmSTVEWWlBZVFhV0RuNTdUR1hHTXVJK2FV?=
 =?utf-8?B?SytxY3BFa0dKNDlSWHZFSHorTnZDYTZ0SXJuRnJSTHZMMWFxSjdadlF0QVk0?=
 =?utf-8?B?WTlHZGN0WnpuenlqT2ZBNHYwTDZOaHZBOUdJdldPS0t6b0Z1SlYzNXBkcXhy?=
 =?utf-8?B?OEpiRWtReUlZWFBaNkU0c1Vjd1YzL0NSWUNVRGl2Vkk0MWFYaU1yNGhOMUxw?=
 =?utf-8?B?Zkl4MTJnNVplci9OSzU0NnRQdElHQm94QTUyaTdpU3hsN25ETTFCWVB3SlN2?=
 =?utf-8?B?UFZmbTdWVzhiMjh0dXBXZ2ZzSzhXYXpXem1mQlArU2RWQWNoaFJNdFVaVExr?=
 =?utf-8?B?MXd0cUZ6aUtCL2ZtdkJlaTg1SVNXNWRlY0RPaUZ5Ly82d2NhWVpqMVZQaWIz?=
 =?utf-8?B?d2VFWThuV1VpLytrdHVLcjQrdVFucTFXS1R5RE5tU1ppTWlNNHdlbWRmbC9Y?=
 =?utf-8?B?QmI3VDFRSURMMmhSazFSZXNyQ0F6NUtEWHd3a2Y4V1B1Vk5pSGZRTG1EcS9Q?=
 =?utf-8?B?NGhCYXBTRDVra2FITllGa0xkMkIyZ0FKbDBDcFlULzZSeDV6VjIya0Y3L0dP?=
 =?utf-8?B?ODFnbld3SkFaLzI3Zm15bDJaZTg5WkRJZEIwN2VobTBSWVY4UTBSR0Z4Wk9P?=
 =?utf-8?B?YWxBVmhkQTNndGFrcExnc0REMXFLT2dyampHV1VmYkEvTHZxTDdIVzJsSFRC?=
 =?utf-8?B?THNqZUl4YXBWcmQ4UmZWOERHMGc2UnBCV2duYzRleDJ6TGxxdm9pMFY5NEdw?=
 =?utf-8?B?MkRDTjA2MG1Bb0xCL25ZT3NDY0FFTWNra0toZW1sMWwxVE9EMUh2blhvbXZ0?=
 =?utf-8?Q?pk8lMQuRSjNLq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJDWTdoL1JQVkN4aFJZc2FEb2J3RldJajRmbkVyaXVVVlBGL1NMZ29JSFE4?=
 =?utf-8?B?bXVBS0RJRG56QnZsN0ErM2NPTHlaQTBZdk1XeWFBVkZIYThMYzZFUVNndlBT?=
 =?utf-8?B?eC95ckhRaE85dTdXRThSZk9EcHljZlFqU21kZGZlbDF4Nk9KemRDK3FvdzdD?=
 =?utf-8?B?cXU3SXRmc0FFL21nVFBkVFY2OUlSbmlGaW9yQy9VVWZ4M0ZiNlFkejRTeHJ1?=
 =?utf-8?B?elVSejNFKzhMSUZZNkhyK1RxTVhOeUVuMmM5ZWg3SXFoS3R0SzZZNlN0a1Vw?=
 =?utf-8?B?NlBwajlPMEVqNTEyWDBGVW5JM1dPUkFrQWpkajZvMmVYdFl2dWxCT3RzZHVr?=
 =?utf-8?B?N1M0Y2lLWWZxUTJ2eTBIZ3cxdGJhWWdNaTUvNUoyN0svTkxVdWRYY0xkbFVh?=
 =?utf-8?B?QXdQaVNuK2tBSXBVZUVLU2xVYk8vK1FHUEFXUmZvOUY1NXlqQmZuUkR5Ny9n?=
 =?utf-8?B?VlhpVjUrVFlmemlQUlFyNWpZenpOQ2c5RWJEc2xScFIycXFuMEdaYU5veExT?=
 =?utf-8?B?dko2RnZwS0JJaDY5YWFLUjhXWldRbHNxUXROalliR0IwMGJPWmRTcThQRGlI?=
 =?utf-8?B?ai9KMkc5c0lWOHFnc2IvRzdUb2dpa0dhRjZpb21PTlptZm53TUhnZ3pobnoz?=
 =?utf-8?B?QUJPd3Y5WGhaU1A4NU4rajB0SU96ajhTSlpMckU2TEV4YlVKRU13MVZSWE44?=
 =?utf-8?B?T1NOZGo0OTJmQVFQNnRjRmVqeHNGMWd5YkZta1gzcFlGS1VyK1RWUlhaeEhx?=
 =?utf-8?B?d3AzQitOMmQ3R2FTaXZSVGc2V3htR0NYem5TVGpsQzg5NU00RGkxM2owbmpX?=
 =?utf-8?B?NzVlb1A1cVZFa3VHMFpBcnpMbjkzT1BSeWJBelR0cHBrTVd0NFhvUUFLM2hu?=
 =?utf-8?B?VkVCRlRycXArVHFyek5waVk2WEl3K3lWazdteUNKaHc1SnBZa1Y5K3hpMWpE?=
 =?utf-8?B?V3NLWjNJVDVxMmt3d2xmV3JDTW95TUVuc1N6aXJXREE4L0srd1lxVjMvZVVI?=
 =?utf-8?B?eVpCNks5K0FabURSdk0xb2NYaDc5LzFYUWRXK0dhaWJicStMV1dvdXVPNHd6?=
 =?utf-8?B?Z2QyaHZETk9EMjM4a2dyRXpiRkRZQjJrK1lSMElFY1lNSFdOdUVBTVBCZmV3?=
 =?utf-8?B?SkxQa3l6YU40YTRVK1ZyRkNsS25nVk4rUlU0VTlPS1czQ0loMEhhT2pIRFho?=
 =?utf-8?B?NjB1SFZlcjB6dkV3YkQ5K2s5SXUvTWNhaWVsVWM1MzhCYVN0S3hoQVUwcHlF?=
 =?utf-8?B?VHlmb1ZFcFVPZlpyUEJobFovQlpqM05UWHZ4aWtlMFdwTW5oZTBPYXlZcXY4?=
 =?utf-8?B?eVBjT2JGL1ZBUVA0YmlKNzVkbXRORUwzNmpkSXk4MFN5UzErMnlid1dqUWN5?=
 =?utf-8?B?bXhQdnBBcHorRGtsQmlwZDdteTZSalNsS0J1NzB4bkF6aU9pYXZyWk1XQndM?=
 =?utf-8?B?SGxvSFlieC9IWjBIN2kwWnpuazZlK250ODk3RlJyYzR1dEpncTArbFNGR0Rt?=
 =?utf-8?B?Y0Y0aTdKVWRJM3lSTXlKMUZGZDlzNWNJK0JOWjJSNEhoaWQ4RElGT0IvVCtG?=
 =?utf-8?B?VFdhd2tYKzc4VkI4cUFiVUhsZE5QcmRoS3BrWmZVemhnZEFLbWE3bEpYS1lW?=
 =?utf-8?B?ZEhlUUJOMzIzemhyNExacGRHM016ajlrWUxHOGJOdGFTUnFNSlNOdGhhTnd5?=
 =?utf-8?B?Vi9oY3F6MzJkQWZ3R0d3ODMvOHdLYnVEdDFpMDJRWmlTU2puY2NMWk5nSU1Y?=
 =?utf-8?B?L0JjOWJReXRjZmVLL3F6cU1WbmFmYzVFc05qTFZwNUpEd0RMbXhpOU1meWNt?=
 =?utf-8?B?d0tYakt1bi9lM3d3NnZqSkZ0UjlrcVdLMUt1SjBjaWVGa0pYeVRaTkJ5K1pZ?=
 =?utf-8?B?QVdSMTVDek55VmVXc0hTN1V2bkUyNzFQazBXZEJjWTVTQTlqT25ieVhhR0dq?=
 =?utf-8?B?QjdLWFVjTTFqK0hFZW1lekhibCtjckh0TVE0SG9OWGVJUFFpT3ptQi80akQ5?=
 =?utf-8?B?b0hEUzhvT3pWcVdiWG5hSWJPNTF0SXQ2L1AxKzJqd2dyRWJoY1V2Smo3Vnlm?=
 =?utf-8?B?SDV6MG9yQ0FNK0NWSWYyVllrUnlKZUtRWThxb0hoRnFONzU2NUhMbnBqU0lv?=
 =?utf-8?B?T3pjUkQ1NUJ0RG9GcjM3aTI0ME1GdFNWVEdEdkZ4bXN1ZDJXVDJubXp2ZEdv?=
 =?utf-8?Q?l+41JeVcFfzXd4VTEro8elo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0185da1-d7be-4f3c-7aed-08dd657c965d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:53:13.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzmi+uAY/86xDkwn/U/eVDDR6dXes1M8+Pkxi7BY9wm5guLCXNg1guw9NhJhhvqnPUBK09ltpcNBR5djTBQEmNYzQDgMYjAhSl5imSKhv1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB8721



On 3/14/25 4:51 AM, Ryan Roberts wrote:
> On 04/03/2025 22:19, Yang Shi wrote:
>> The later patch will enhance __create_pgd_mapping() and related helpers
>> to split kernel linear mapping, it requires have return value.  So make
>> __create_pgd_mapping() and helpers non-void functions.
>>
>> And move the BUG_ON() out of page table alloc helper since failing
>> splitting kernel linear mapping is not fatal and can be handled by the
>> callers in the later patch.  Have BUG_ON() after
>> __create_pgd_mapping_locked() returns to keep the current callers behavior
>> intact.
>>
>> Suggested-by: Ryan Roberts<ryan.roberts@arm.com>
>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/mm/mmu.c | 127 ++++++++++++++++++++++++++++++--------------
>>   1 file changed, 86 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b4df5bc5b1b8..dccf0877285b 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -189,11 +189,11 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>   	} while (ptep++, addr += PAGE_SIZE, addr != end);
>>   }
>>   
>> -static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>> -				unsigned long end, phys_addr_t phys,
>> -				pgprot_t prot,
>> -				phys_addr_t (*pgtable_alloc)(int),
>> -				int flags)
>> +static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>> +			       unsigned long end, phys_addr_t phys,
>> +			       pgprot_t prot,
>> +			       phys_addr_t (*pgtable_alloc)(int),
>> +			       int flags)
>>   {
>>   	unsigned long next;
>>   	pmd_t pmd = READ_ONCE(*pmdp);
>> @@ -208,6 +208,8 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>   			pmdval |= PMD_TABLE_PXN;
>>   		BUG_ON(!pgtable_alloc);
>>   		pte_phys = pgtable_alloc(PAGE_SHIFT);
>> +		if (!pte_phys)
>> +			return -ENOMEM;
> nit: personally I'd prefer to see a "goto out" and funnel all to a single return
> statement. You do that in some functions (via loop break), but would be cleaner
> if consistent.
>
> If pgtable_alloc() is modified to return int (see my comment at the bottom),
> this becomes:
>
> ret = pgtable_alloc(PAGE_SHIFT, &pte_phys);
> if (ret)
> 	goto out;

OK

>>   		ptep = pte_set_fixmap(pte_phys);
>>   		init_clear_pgtable(ptep);
>>   		ptep += pte_index(addr);
>> @@ -239,13 +241,16 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>   	 * walker.
>>   	 */
>>   	pte_clear_fixmap();
>> +
>> +	return 0;
>>   }
>>   
>> -static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> -		     phys_addr_t phys, pgprot_t prot,
>> -		     phys_addr_t (*pgtable_alloc)(int), int flags)
>> +static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> +		    phys_addr_t phys, pgprot_t prot,
>> +		    phys_addr_t (*pgtable_alloc)(int), int flags)
>>   {
>>   	unsigned long next;
>> +	int ret = 0;
>>   
>>   	do {
>>   		pmd_t old_pmd = READ_ONCE(*pmdp);
>> @@ -264,22 +269,27 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>   			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
>>   						      READ_ONCE(pmd_val(*pmdp))));
>>   		} else {
>> -			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
>> +			ret = alloc_init_cont_pte(pmdp, addr, next, phys, prot,
>>   					    pgtable_alloc, flags);
>> +			if (ret)
>> +				break;
>>   
>>   			BUG_ON(pmd_val(old_pmd) != 0 &&
>>   			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
>>   		}
>>   		phys += next - addr;
>>   	} while (pmdp++, addr = next, addr != end);
>> +
>> +	return ret;
>>   }
>>   
>> -static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>> -				unsigned long end, phys_addr_t phys,
>> -				pgprot_t prot,
>> -				phys_addr_t (*pgtable_alloc)(int), int flags)
>> +static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>> +			       unsigned long end, phys_addr_t phys,
>> +			       pgprot_t prot,
>> +			       phys_addr_t (*pgtable_alloc)(int), int flags)
>>   {
>>   	unsigned long next;
>> +	int ret = 0;
>>   	pud_t pud = READ_ONCE(*pudp);
>>   	pmd_t *pmdp;
>>   
>> @@ -295,6 +305,8 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>>   			pudval |= PUD_TABLE_PXN;
>>   		BUG_ON(!pgtable_alloc);
>>   		pmd_phys = pgtable_alloc(PMD_SHIFT);
>> +		if (!pmd_phys)
>> +			return -ENOMEM;
>>   		pmdp = pmd_set_fixmap(pmd_phys);
>>   		init_clear_pgtable(pmdp);
>>   		pmdp += pmd_index(addr);
>> @@ -314,21 +326,26 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>>   		    (flags & NO_CONT_MAPPINGS) == 0)
>>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>   
>> -		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
>> +		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
>> +		if (ret)
>> +			break;
>>   
>>   		pmdp += pmd_index(next) - pmd_index(addr);
>>   		phys += next - addr;
>>   	} while (addr = next, addr != end);
>>   
>>   	pmd_clear_fixmap();
>> +
>> +	return ret;
>>   }
>>   
>> -static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>> -			   phys_addr_t phys, pgprot_t prot,
>> -			   phys_addr_t (*pgtable_alloc)(int),
>> -			   int flags)
>> +static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>> +			  phys_addr_t phys, pgprot_t prot,
>> +			  phys_addr_t (*pgtable_alloc)(int),
>> +			  int flags)
>>   {
>>   	unsigned long next;
>> +	int ret = 0;
>>   	p4d_t p4d = READ_ONCE(*p4dp);
>>   	pud_t *pudp;
>>   
>> @@ -340,6 +357,8 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   			p4dval |= P4D_TABLE_PXN;
>>   		BUG_ON(!pgtable_alloc);
>>   		pud_phys = pgtable_alloc(PUD_SHIFT);
>> +		if (!pud_phys)
>> +			return -ENOMEM;
>>   		pudp = pud_set_fixmap(pud_phys);
>>   		init_clear_pgtable(pudp);
>>   		pudp += pud_index(addr);
>> @@ -369,8 +388,10 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
>>   						      READ_ONCE(pud_val(*pudp))));
>>   		} else {
>> -			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
>> +			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
>>   					    pgtable_alloc, flags);
>> +			if (ret)
>> +				break;
>>   
>>   			BUG_ON(pud_val(old_pud) != 0 &&
>>   			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
>> @@ -379,14 +400,17 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   	} while (pudp++, addr = next, addr != end);
>>   
>>   	pud_clear_fixmap();
>> +
>> +	return ret;
>>   }
>>   
>> -static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>> -			   phys_addr_t phys, pgprot_t prot,
>> -			   phys_addr_t (*pgtable_alloc)(int),
>> -			   int flags)
>> +static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>> +			  phys_addr_t phys, pgprot_t prot,
>> +			  phys_addr_t (*pgtable_alloc)(int),
>> +			  int flags)
>>   {
>>   	unsigned long next;
>> +	int ret = 0;
>>   	pgd_t pgd = READ_ONCE(*pgdp);
>>   	p4d_t *p4dp;
>>   
>> @@ -398,6 +422,8 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>   			pgdval |= PGD_TABLE_PXN;
>>   		BUG_ON(!pgtable_alloc);
>>   		p4d_phys = pgtable_alloc(P4D_SHIFT);
>> +		if (!p4d_phys)
>> +			return -ENOMEM;
>>   		p4dp = p4d_set_fixmap(p4d_phys);
>>   		init_clear_pgtable(p4dp);
>>   		p4dp += p4d_index(addr);
>> @@ -412,8 +438,10 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>   
>>   		next = p4d_addr_end(addr, end);
>>   
>> -		alloc_init_pud(p4dp, addr, next, phys, prot,
>> +		ret = alloc_init_pud(p4dp, addr, next, phys, prot,
>>   			       pgtable_alloc, flags);
>> +		if (ret)
>> +			break;
>>   
>>   		BUG_ON(p4d_val(old_p4d) != 0 &&
>>   		       p4d_val(old_p4d) != READ_ONCE(p4d_val(*p4dp)));
>> @@ -422,23 +450,26 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>   	} while (p4dp++, addr = next, addr != end);
>>   
>>   	p4d_clear_fixmap();
>> +
>> +	return ret;
>>   }
>>   
>> -static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>> -					unsigned long virt, phys_addr_t size,
>> -					pgprot_t prot,
>> -					phys_addr_t (*pgtable_alloc)(int),
>> -					int flags)
>> +static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>> +				       unsigned long virt, phys_addr_t size,
>> +				       pgprot_t prot,
>> +				       phys_addr_t (*pgtable_alloc)(int),
>> +				       int flags)
>>   {
>>   	unsigned long addr, end, next;
>>   	pgd_t *pgdp = pgd_offset_pgd(pgdir, virt);
>> +	int ret = 0;
>>   
>>   	/*
>>   	 * If the virtual and physical address don't have the same offset
>>   	 * within a page, we cannot map the region as the caller expects.
>>   	 */
>>   	if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
>> -		return;
>> +		return -EINVAL;
>>   
>>   	phys &= PAGE_MASK;
>>   	addr = virt & PAGE_MASK;
>> @@ -446,29 +477,38 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>>   
>>   	do {
>>   		next = pgd_addr_end(addr, end);
>> -		alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
>> +		ret = alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
>>   			       flags);
>> +		if (ret)
>> +			break;
>>   		phys += next - addr;
>>   	} while (pgdp++, addr = next, addr != end);
>> +
>> +	return ret;
>>   }
>>   
>> -static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>> -				 unsigned long virt, phys_addr_t size,
>> -				 pgprot_t prot,
>> -				 phys_addr_t (*pgtable_alloc)(int),
>> -				 int flags)
>> +static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>> +				unsigned long virt, phys_addr_t size,
>> +				pgprot_t prot,
>> +				phys_addr_t (*pgtable_alloc)(int),
>> +				int flags)
>>   {
>> +	int ret;
>> +
>>   	mutex_lock(&fixmap_lock);
>> -	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
>> +	ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
>>   				    pgtable_alloc, flags);
>> +	BUG_ON(ret);
> This function now returns an error, but also BUGs on ret!=0. For this patch, I'd
> suggest keeping this function as void.

You mean __create_pgd_mapping(), right?

> But I believe there is a pre-existing bug in arch_add_memory(). That's called at
> runtime so if __create_pgd_mapping() fails and BUGs, it will take down a running
> system.

Yes, it is the current behavior.

> With this foundational patch, we can fix that with an additional patch to pass
> along the error code instead of BUGing in that case. arch_add_memory() would
> need to unwind whatever __create_pgd_mapping() managed to do before the memory
> allocation failure (presumably unmapping and freeing any allocated tables). I'm
> happy to do this as a follow up patch.

Yes, the allocated page tables need to be freed. Thank you for taking it.

>>   	mutex_unlock(&fixmap_lock);
>> +
>> +	return ret;
>>   }
>>   
>>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>   extern __alias(__create_pgd_mapping_locked)
>> -void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>> -			     phys_addr_t size, pgprot_t prot,
>> -			     phys_addr_t (*pgtable_alloc)(int), int flags);
>> +int create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>> +			    phys_addr_t size, pgprot_t prot,
>> +			    phys_addr_t (*pgtable_alloc)(int), int flags);
> create_kpti_ng_temp_pgd() now returns error instead of BUGing on allocation
> failure, but I don't see a change to handle that error. You'll want to update
> __kpti_install_ng_mappings() to BUG on error.

Yes, I missed that. It should BUG on error.

>>   #endif
>>   
>>   static phys_addr_t __pgd_pgtable_alloc(int shift)
>> @@ -476,13 +516,17 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
>>   	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
>>   	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);
>>   
>> -	BUG_ON(!ptr);
>> +	if (!ptr)
>> +		return 0;
> 0 is a valid (though unlikely) physical address. I guess you could technically
> encode like ERR_PTR(), but since you are returning phys_addr_t and not a
> pointer, then perhaps it will be clearer to make this return int and accept a
> pointer to a phys_addr_t, which it will populate on success?

Actually I did something similar in the first place, but just returned 
the virt address. Then did something if it returns NULL. That made the 
code a little more messy since we need convert the virt address to phys 
address because __create_pgd_mapping() and the helpers require phys 
address, and changed the functions definition.

But I noticed 0 should be not a valid phys address if I remember 
correctly. I also noticed early_pgtable_alloc() calls 
memblock_phys_alloc_range(), it returns 0 on failure. If 0 is valid phys 
address, then it should not do that, right? And I also noticed the 
memblock range 0 - memstart_addr is actually removed from memblock (see 
arm64_memblock_init()), so IIUC 0 should be not valid phys address. So 
the patch ended up being as is.

If this assumption doesn't stand, I think your suggestion makes sense.

>> +
>>   	return __pa(ptr);
>>   }
>>   
>>   static phys_addr_t pgd_pgtable_alloc(int shift)
>>   {
>>   	phys_addr_t pa = __pgd_pgtable_alloc(shift);
>> +	if (!pa)
>> +		goto out;
> This would obviously need to be fixed up as per above.
>
>>   	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
>>   
>>   	/*
>> @@ -498,6 +542,7 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
>>   	else if (shift == PMD_SHIFT)
>>   		BUG_ON(!pagetable_pmd_ctor(ptdesc));
>>   
>> +out:
>>   	return pa;
>>   }
>>   
> You have left early_pgtable_alloc() to panic() on allocation failure. Given we
> can now unwind the stack with error code, I think it would be more consistent to
> also allow early_pgtable_alloc() to return error.

The early_pgtable_alloc() is just used for painting linear mapping at 
early boot stage, if it fails I don't think unwinding the stack is 
feasible and worth it. Did I miss something?

Thanks,
Yang

> Thanks,
> Ryan
>


