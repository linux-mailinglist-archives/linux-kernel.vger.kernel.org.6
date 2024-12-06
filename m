Return-Path: <linux-kernel+bounces-434242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E509E63D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27341668B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72413D8B5;
	Fri,  6 Dec 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oSy91qau"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756298BE8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450434; cv=fail; b=A3YxHSXN75efyYIOwcU+RdPa8a1rQeJ9fXqagi8ye7Lph2LOMnVcAytd/PB4/PDgbmdrEqHyW8QNEkEnpfzAfOU05jt6pjH+VrVMUIRGcz9vDcSB5tAGzOLAp2mDf/Dz8ZnSBhVamO9X83QN6Pr8IJzJcO/Q6UmovKhHAc9wZdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450434; c=relaxed/simple;
	bh=xMjUOk51Gk3ivh/PfXiUE/530A5HnmcyPJLod6lJ460=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flFsuX7pSfZTLpgj7g8PYYGqTPoVhs+3lnBpMj2v9I13yMA6Umli+sjvxB1jHGuBSW6Rqe4WRgqYWYOelM2PJOlowcR8MK/PFQls/+ejOPWaluUViyLXSFjUg49g16Fybp5Au2gXmLga3GbdzifizWtpA9Nva+B2ivjdW4NH+rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oSy91qau; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez75l5NHx8sc4DEX760uoQP90x24H6WdVHiLi+4l0GRhYFungLzh7tOTkzsrQUeH9tmrwET8y90GVQNujf+0fKWTVbxI3jzlH4xxF3evx8nnPk8EQB6uM6cBDJGCBvLEp0ddGbMbLjoV7l24T4OupO/xwkD5rDw451AeRBgfvkHkTILLHqYQqxbjxG7Uazc4VucavW/HcLgPn2h+33o/i3Q1njlsogiCBGDAjQS5ZrP3ndvw5a6TlnoA5fx9RXMa1vmqm7R6rKOZgDOKKMMUZHmQTrI4B4cSs7MTD0nxitKkxqFU/ibJo94385TkklZ1yFWYkrQNzsRxsiCFBo0Njg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGmpe1JfegYhnTyngqQstDAcwclKiVUAhHp1O0js9S8=;
 b=qrcgI/V5hSklkjCx22Nt/gIg68Nxx81Effcay4N828SgQw4joFqKpQrGgL79QtGxM/uW/LxkaKYpT/CxFzFPxtmhl5JiwGnyqIkFf+EGp3K4wyFu2wem87Vjv7z/UfSh+cG8eMf8cxWkhD8gAEBRu5wAtF0351jAn0jpqo06TC6kf3nS+94dSuyioCmrIa5fftnayG46KkyIwEKeaLSY7ntoERVib1BkX5rReq8tYv3euTOncSbbnOfAC1gmXOdL+Bm5c2hzeRoiZ5RzPwUy/I7zCsmvveCUq8aeGEeh8JJlxYZ6EypMxnpp+npmViEqWgHZY6gWl1x0JbzUZaxGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGmpe1JfegYhnTyngqQstDAcwclKiVUAhHp1O0js9S8=;
 b=oSy91qau43lWSUyMDk0NGTR/ffV+mME/JzPCAhJRtGrezYDmZ7iUrBnf438i8wSiYWppHUQ7WK2gJSXp5Evg4LEtBJSe6/URwUTeg0tvFlomdjw3DlkH6ILIOxxnr4PX3Gr5xt8jyyna7XhLIXkOOX8KaNSVqiH3gRkFFSpqbDeGsQpdi9FQTVphUjlqFriq1zezqeC0wqLNCOwCy0zeFb046gUxrnvl1ysHVD8X4/0/euvjfVyFWzCn9e52nMV33vjiSeIJobq58/gEX4nNzsmBcwwrfYYtDJfwwZy+K5HPAiJwmwTpoxXkJaBO6aBMY9UJJF6nagYQAIo7r2vRBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Fri, 6 Dec 2024 02:00:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 02:00:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ardb@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
 xieyongji@bytedance.com, lihangjing@bytedance.com,
 punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
Date: Thu, 05 Dec 2024 21:00:23 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com>
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3397f996-8082-432c-e1bf-08dd1599c045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXhPUitEUCtqS0ovSWN5RklxdGNrM04rRTdJMmJYV0RTUEdLalJVRG5xN0dU?=
 =?utf-8?B?Slh1K2VEc1pjMzViR1lFV3FFdGRLWWhPaUV5ZEFXc1VVWGxaUVdZZlRrWnRt?=
 =?utf-8?B?MDFlZ1NQMXorR3NOemlJaG5QV0Q2SVI4WEh6ekN5b3VoRmxKcXFXWDlHS3JS?=
 =?utf-8?B?Znp6ak1NcXM1U3U1V3l2bUhVR3JGeFgyc0x3KzVDWk5JRUNwU2Q5a0dWbmEr?=
 =?utf-8?B?QTluZ3FUNmhMczNBTXBwSTZtZEZjN3k3REtlcGtsMWFLUU5Kb3RNUE5NdGdq?=
 =?utf-8?B?U1JSNjBLd01jbDc2TENoSWVrSGNXdWVmb1ZDL1JUMkFYQ1NweGhVSE5IMzV0?=
 =?utf-8?B?T0lRQWR6MVF3K1VCWU5GUUl0OWliemhlN2VJakhWWFV5OGp6WGk0d09JODVo?=
 =?utf-8?B?eG9lcHEyVExUeE01N1M0NGdmY1NyRXpMV1hJaTViaDljR3ZPVjN6UVMrMFow?=
 =?utf-8?B?bFZGZG1TTlR0YlNKSkpUbWk0S1IxZmptbjROaGVmWjhqNndRSWlzcVJ5Zk90?=
 =?utf-8?B?Y2FMUjlEdm5rVExYdEpOZTZ3eEhIcHRnSkpvNlBtSXUxL3RWaDFoZ1lsRmMz?=
 =?utf-8?B?VkF4UnM3V2tvMDlvbXZqRTcxUkN1MmtPQWZ0bndYWDI2bFVtOUx5UURzQkRh?=
 =?utf-8?B?YThoclFLT01KSHJJNFQzS1gzWGxDTklyVUJrUTFVUzc5WUk1T1EwcjFVSzRP?=
 =?utf-8?B?WUJKdW9kTGFhTmtFbGJLVHVtalllOExXaVYvcDZxNGs1aHZRU2hxUlc1MHJE?=
 =?utf-8?B?d3E3cmZKUFNpUWpyZGNsQzhSeDFjVVBrdmZLNjFJRUxYdThIeUhsRnp4NFM1?=
 =?utf-8?B?RUpXeEZraGY2Ym5CU2F4cURBR1lZSENXZEx6clZvSWxnZ1A3ZUxiQy9oU0xW?=
 =?utf-8?B?VVFQLytITFVpcHI2RTRKM1hGQ0VsVDZ6LzNnSjQ5R1RScmlZSDNKa2FveW1w?=
 =?utf-8?B?cGJ6UC92SW1JZ2NBRzYrS3huVS8rd25TaEFBWm9JbUNEemdMR1pDWWRYTXBX?=
 =?utf-8?B?NVVacXdjSG9yNkRLSHo4MllvY0VVQTltaFRZMEUzcDRqa0hpTDJlVm9TY3NT?=
 =?utf-8?B?SVBPanNEc3EwT3loTi9hTi84QmFRcFZVTFhseFRsVm1VdUlXeStkMUkrV3VZ?=
 =?utf-8?B?akF6MHhjV2pzQVcrTkRINldJU3BaeFM0Wk05c1UxRHA0OUYvdU5sU003RkNG?=
 =?utf-8?B?NjZkR0RMMGMrYUxObmF2QUg0SUVyMzN4K29LME1JdlIwK1h4aHJzdVpkbTNZ?=
 =?utf-8?B?RnNpNDY1UnNrMHRURnZuR0F0RjlZT3lPVjA4VWtUb1VNb2R6Rko0eWZLMHdw?=
 =?utf-8?B?a0h4Vnp6ZWxOaTdyZEF3SWdPOVl2OXRnaEpPdXJaUzEzdXZPOGVrQjFPQ3A0?=
 =?utf-8?B?MktpY2MzMGZ0cFNBUXZqaFlPZ1QvZm5UVFRJVWN5dWdFK3FwNmFORjh0cU9o?=
 =?utf-8?B?eWdtU2ZSN1FpUlA4VFZEcHpxWU96YlhLTGVvZm9TQTFuQWI3dTVYTHBxVXQy?=
 =?utf-8?B?NUlqckg2Z1J5cmdleU81aHYxNGR3UnB2b0oyZ21SVEZrY0pvUVBaSUhsWkdo?=
 =?utf-8?B?d0NiL3JWbnUrVXFzdUJOS3hJSDZBL2FrcWlQYkt4U0p5UmZGQUxaWmkwSHZi?=
 =?utf-8?B?aklWRE1LemNuNlE1T2dmeTZmWXlXYVE4UmR6WHMyUGV1UXN2VW51Vm8zdFYv?=
 =?utf-8?B?VlovZkVjeWZvZWlHTTRKYSt4MUdVdktEL2x3TXFrajM0ekxwbGhUU2pCQnI0?=
 =?utf-8?B?QzVmS2xBR2JxbVVLRzhGMHhwbjF5YXg0M0hDVXhOZnlTeXJzNUNMaFcwaXFp?=
 =?utf-8?Q?d4txTnKHhizqeCiPDwy3CcIyj/YNQpp6/T6qs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q000VDBxeDZFLzlsbGsvQnRTeDRuMkkwT0V4OUI2ZmxJRS9TWGFkZUJVc3l1?=
 =?utf-8?B?dVVaS0tBRTRmMDZibGFrUHhjLzhiQnU0REN6VVRZOHFFMjBhS3hnRU4wV3o4?=
 =?utf-8?B?RjUzOTBadS9BSHQ0cEdxamxWQkcrYWZvWHVHMGRIR29udUZhTExISmlCaExF?=
 =?utf-8?B?RXBiT0tiWm44UDVzUjF1TmNMaW5heDRQUHFndkZrRUdzM3ZNQzJrSDhEYjVG?=
 =?utf-8?B?MU5IRUJ4UFZmcjNlYnFhS1h5TDNROUJ6ZHlwVm9SbVhBcWtWc3M0L05EaStO?=
 =?utf-8?B?T3hhZ1Z0N0Zkd3l6ZkJNTTNtQUFiaGN2MUdDaGI4MWFIV29nME5WUHBjNXQr?=
 =?utf-8?B?Zi92MXhuTTVFTEZWNXZ0WVp0Y3lqVGV5anRwY0ZXc3VNOE9uSHBNRkxZb2ZX?=
 =?utf-8?B?K1BPQWh0elVPeHRSMjlWaDRnSzEyL1Zka2dGRldSZ0NnTEVMSzBzeVdTRSt5?=
 =?utf-8?B?NjdCWlJ6ZXRiek01WXRRckFLOUtMTmxPQ2tCRDRYUmQzT2doczhvTDk1cXBi?=
 =?utf-8?B?TVEzNlBnaFFwOEQ1R1ZmeldNc3hJQm5CMU5veU8zYTJVNkJqR0pMSHRRRVNQ?=
 =?utf-8?B?bEd0OUlMM01sZ2cvb0hzV2Nha1AzOHZHNDBuMjluQU1PZUJOZjNJdTVFVGZj?=
 =?utf-8?B?R1ZSb1pIa0JxZFNEYXoybUh0RnhxOEdnN0o2ajUwU0JwUkdsOUJabE44RWhx?=
 =?utf-8?B?TWEwYjhGMzN2UWRaUGkzd1RCejk5V0pNTFZJMm5YMDlTQStSMnl0aXhvUWUr?=
 =?utf-8?B?M21Eai9EOGlLRjgrcUFpTFMxbFBpVnNPRHVvRkw1Vk5rR0hzRHdvWFFxUE1H?=
 =?utf-8?B?ZnRuZDFmMUdsa2NQa0NpTVRvbWhDajdIcUtsZkduUmlPZWlJN3FvQXRHNVJT?=
 =?utf-8?B?bW8xYS91aTNCZU83dVl3c2FvMkp4SG5WbmM2ZEIxQTRVZzdoNTNjUXc3WTZk?=
 =?utf-8?B?MnFxRGVoR0dnM1ErVXl4dTVaaTZtdDk1S0JCKzljeFFVM0R5VWtNbXpWbExI?=
 =?utf-8?B?SzNPQUtyd2pFYnVHNDNrWXBCVWs0d2tNQ0UyaFBVTmZaZVVKa1JocHFyWmoy?=
 =?utf-8?B?MzVIUnJ6aFBTOGlZL1NrRTdPTHFtdXZQYjRFb2FOdlRzaWF4d3ZxYnpOcTZh?=
 =?utf-8?B?OFJDRStxeDRwRkpORjJoTHkzM3lxUDhNYWFFK3gxbTNGYkJXNVhLNWhvN1pm?=
 =?utf-8?B?SEFZaWRVdGdEZ014aklrblJZVlVnRDBZUVdwMU56emE3aGo4ZFhnTDJOSHZF?=
 =?utf-8?B?b3BxaHg1YThKV3NsTTBQT1RaTUZHU2NvUnF4cFB6cEd6VDlLbzl4T3ZxVVp3?=
 =?utf-8?B?Q2ZMa2dLT3BKVmdQelFiN3FRWVVwektzckdyS0E4aHI0UTVtVTVpMTRCUVlR?=
 =?utf-8?B?YlZLbzlCOGsxRTZWUzV1YXRUVlhOaFdWcW12SmlrckVxa2dsRlZKMHdBUlhs?=
 =?utf-8?B?cEMxWVFzdS9STEZvQnl4djQwVFRzeThIR3ZITXVrZEpUNWwrbTRCT1pTeHpO?=
 =?utf-8?B?TThTa3RZNmo2VzZtWXRyMHlUbllnaFlaekFpL2t1eXNicXMxdmdiMStnUnpY?=
 =?utf-8?B?VVZWam1pNDhtM29Na0lnbm5LWUVZYmx4OVRHcmsraEE3ZS9zbDhyOEEvcVNz?=
 =?utf-8?B?Zy9zNXA3eXdxcDgrdEZETVV0TGhFQ28rTlZTOGFmY3RPaStsenRxRG5wQmVL?=
 =?utf-8?B?dUNhMW1GbXRRVlVaMUhKYm16alNOT05ORW5jMEpBMXlnU3l4ZnF3aThQOUg2?=
 =?utf-8?B?WUxRNm9LbVdTKzNhQmo0ZzdoQkVjQ0tYWnBHK3gyUHBJWUlXRUpaQm5vUGl5?=
 =?utf-8?B?NVl3elQ4QU53SEJOVG0zZmpGU0JORmZLZEJkdWlPQ0k4S2s1NXR2WnNmR0dl?=
 =?utf-8?B?WmhiejA2ZmdpZzFJRG1mY3Z6OEVYUlV0cTBjYVlCSHFDS0M4eHJTeTNDTjYx?=
 =?utf-8?B?dW11TUk4OU1mSXhyd2FBcWpjcGRka2FFZTNySG1FYzBBMTd0V1grcWEzTXZx?=
 =?utf-8?B?NlF6NWF2akF5eWkzbjMwNkhJL041eXpNT0MrRTIzblEvY2ZaYzNxbi8zdFJS?=
 =?utf-8?B?OHVqZHZ4T3lNOERwaUYzbjdiZFBVZEVuQ09XSnFwanRKWUxYcDNDcHhzOEZ2?=
 =?utf-8?Q?mNmk6xqL2Tngovpg1HuNOxhcP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3397f996-8082-432c-e1bf-08dd1599c045
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 02:00:25.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhB0qFliwFOofWT/hw3Ta+GgFuTyBP90v+AhXaWpwNDpwp9/m+TuMimiUvaM4P4+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092

On 5 Dec 2024, at 5:37, Xu Lu wrote:

> This patch series attempts to break through the limitation of MMU and
> supports larger base page on RISC-V, which only supports 4K page size
> now. The key idea is to always manage and allocate memory at a
> granularity of 64K and use SVNAPOT to accelerate address translation.
> This is the second version and the detailed introduction can be found
> in [1].
>
> Changes from v1:
> - Rebase on v6.12.
>
> - Adjust the page table entry shift to reduce page table memory usage.
>     For example, in SV39, the traditional va behaves as:
>
>     ----------------------------------------------
>     | pgd index | pmd index | pte index | offset |
>     ----------------------------------------------
>     | 38     30 | 29     21 | 20     12 | 11   0 |
>     ----------------------------------------------
>
>     When we choose 64K as basic software page, va now behaves as:
>
>     ----------------------------------------------
>     | pgd index | pmd index | pte index | offset |
>     ----------------------------------------------
>     | 38     34 | 33     25 | 24     16 | 15   0 |
>     ----------------------------------------------
>
> - Fix some bugs in v1.
>
> Thanks in advance for comments.
>
> [1] https://lwn.net/Articles/952722/

This looks very interesting. Can you cc me and linux-mm@kvack.org
in the future? Thanks.

Have you thought about doing it for ARM64 4KB as well? ARM64’s contig PTE
should have similar effect of RISC-V’s SVNAPOT, right?

>
> Xu Lu (21):
>   riscv: mm: Distinguish hardware base page and software base page
>   riscv: mm: Configure satp with hw page pfn
>   riscv: mm: Reimplement page table entry structures
>   riscv: mm: Reimplement page table entry constructor function
>   riscv: mm: Reimplement conversion functions between page table entry
>   riscv: mm: Avoid pte constructor during pte conversion
>   riscv: mm: Reimplement page table entry get function
>   riscv: mm: Reimplement page table entry atomic get function
>   riscv: mm: Replace READ_ONCE with atomic pte get function
>   riscv: mm: Reimplement PTE A/D bit check function
>   riscv: mm: Reimplement mk_huge_pte function
>   riscv: mm: Reimplement tlb flush function
>   riscv: mm: Adjust PGDIR/P4D/PUD/PMD_SHIFT
>   riscv: mm: Only apply svnapot region bigger than software page
>   riscv: mm: Adjust FIX_BTMAPS_SLOTS for variable PAGE_SIZE
>   riscv: mm: Adjust FIX_FDT_SIZE for variable PMD_SIZE
>   riscv: mm: Apply Svnapot for base page mapping if possible
>   riscv: Kconfig: Introduce 64K page size
>   riscv: Kconfig: Adjust mmap rnd bits for 64K Page
>   riscv: mm: Adjust address space layout and init page table for 64K
>     Page
>   riscv: mm: Update EXEC_PAGESIZE for 64K Page
>
>  arch/riscv/Kconfig                    |  34 +-
>  arch/riscv/include/asm/fixmap.h       |   3 +-
>  arch/riscv/include/asm/hugetlb.h      |   5 +
>  arch/riscv/include/asm/page.h         |  56 ++-
>  arch/riscv/include/asm/pgtable-32.h   |  12 +-
>  arch/riscv/include/asm/pgtable-64.h   | 128 ++++--
>  arch/riscv/include/asm/pgtable-bits.h |   3 +-
>  arch/riscv/include/asm/pgtable.h      | 564 +++++++++++++++++++++++---
>  arch/riscv/include/asm/tlbflush.h     |  26 +-
>  arch/riscv/include/uapi/asm/param.h   |  24 ++
>  arch/riscv/kernel/head.S              |   4 +-
>  arch/riscv/kernel/hibernate.c         |  21 +-
>  arch/riscv/mm/context.c               |   7 +-
>  arch/riscv/mm/fault.c                 |  15 +-
>  arch/riscv/mm/hugetlbpage.c           |  30 +-
>  arch/riscv/mm/init.c                  |  45 +-
>  arch/riscv/mm/kasan_init.c            |   7 +-
>  arch/riscv/mm/pgtable.c               | 111 ++++-
>  arch/riscv/mm/tlbflush.c              |  31 +-
>  arch/s390/include/asm/hugetlb.h       |   2 +-
>  include/asm-generic/hugetlb.h         |   5 +-
>  include/linux/pgtable.h               |  21 +
>  kernel/events/core.c                  |   6 +-
>  mm/debug_vm_pgtable.c                 |   6 +-
>  mm/gup.c                              |  10 +-
>  mm/hmm.c                              |   2 +-
>  mm/hugetlb.c                          |   4 +-
>  mm/mapping_dirty_helpers.c            |   2 +-
>  mm/memory.c                           |   4 +-
>  mm/mprotect.c                         |   2 +-
>  mm/ptdump.c                           |   8 +-
>  mm/sparse-vmemmap.c                   |   2 +-
>  mm/vmscan.c                           |   2 +-
>  33 files changed, 1029 insertions(+), 173 deletions(-)
>  create mode 100644 arch/riscv/include/uapi/asm/param.h
>
> -- 
> 2.20.1


Best Regards,
Yan, Zi

