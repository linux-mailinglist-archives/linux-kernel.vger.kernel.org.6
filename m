Return-Path: <linux-kernel+bounces-433958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E59E5F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23645280F45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC21A76A4;
	Thu,  5 Dec 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cFytW+dI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB7193
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429995; cv=fail; b=q4QT3KxCoAtW0V5bukSGWNlPqF1MMGOkFBsghI+8bu97cEB7A/QUU7CP/W8MzEXIrWezlrcXPBG32+ZjXqJMgh1/bVzR9CSn6yYdGQCat+R2FJWvOdQpt3DNxZE5HgPECtyGrVhzU+cv45LcqgcDJJotIc8UxfgbhxVhRa3nh10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429995; c=relaxed/simple;
	bh=s92x3F54zJQurxpN25MRyEXXITAYETD1bjO7vmP+jrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S7vCNVcaGlw/k2b/T+c5D0g1G+TgBKI2KKPLDKduqEXSFF855Mt2/+9+hbum2t6LY8tjlOAKvvExPTX0CTKtvrr1FT3Id9VGI44fq7CCJoLtwYCwCeLQf35aNiPPo3jV5n1Vm9ogKwgKUQVj8YwYWKEWmSvIY+kLBU/I8faPqQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cFytW+dI; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQdrE2WdP7OIkjtiwNQVpb/OJvb3jnFpxZPruFVM5V9V59sKyS7vCWnxXzgB195yE9Hom44UT2BtYloOy+Saje7tI9ggs/SEEnlIJvu+NwpWy4e2cwc+Vi07K21hg3f8xVifwRoUn5FcSM2vk02RVg1r/yJRguA49QiNE3E/zh8rjyCiWf4/uBvMEhfDRahrB4/4T50LL0dGvzNzGiOdX2MTxjR7q67NpBLLlDHkloHrz/i8n9fBaZTzlv8XLNb3rA1Rx0S2UCqR0ePLc3eml/tMCsfd3cboABs0/XlyRZvqbtmIoEhzuLAgmVMdch1AoIYwHUq7YiDQiJDQ6o+q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6zUfCDw41NNpbHPmzbUDyvlwiQRB4ukS9/Z6rcq9Qc=;
 b=sX7NA1xmnlqpkW8ZAItAHhnF16LofQu6pZbMy4qhqu76wy3nQtF9FVpoUMvb7H41fesTfDDiABC/D/pWU5Ew+lGVDQ116pxsfqBiXf6YOAr6kJvjEX3uF11Rzv2dVXgGNvLXBXh7ui3woVd2dN8TH/mWjJ9OKJmlNl9XO4PLcuLahc8U++0aPWVzuEFssS0Ti5o4uw+pDnXR6L5DNwwgkfZYM9XW5Fu7ov1WvU95QRkAvqZsE7yZm2/E9qcP6vzZuvs5QJFwFJug7irtt7X6cGCiHsgL+Aa1IzNl2FXqwgCmtrX0EwD5W4BSg2Un6shtqzHigeNgw9P4Hc/YeWU8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6zUfCDw41NNpbHPmzbUDyvlwiQRB4ukS9/Z6rcq9Qc=;
 b=cFytW+dI/OdBw35ICDZxSOWutkdOm3DtT3PJ2+CxxClvlngiKMyJa8GDzmH96xioHV8ewmX3+mCfpNteEGWI19rNRKZLaV8Za+jc7NCfEqyje7YvLQicz0RhWGhmiwa4Hj0IA/uWnS0nWDJ7ZPU8N/wBZbw3zvkJUPJpojAPRM0=
Received: from PH7P220CA0088.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::32)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 20:19:50 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::4) by PH7P220CA0088.outlook.office365.com
 (2603:10b6:510:32c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Thu,
 5 Dec 2024 20:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 20:19:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 14:19:48 -0600
Received: from [172.25.146.163] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Dec 2024 14:19:48 -0600
Message-ID: <dae94ec2-79fd-43bd-a862-d06824fdf9ed@amd.com>
Date: Thu, 5 Dec 2024 15:19:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] xen/acpi: upload power and performance related
 data from a PVH dom0
To: Penny Zheng <Penny.Zheng@amd.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: Ray Huang <Ray.Huang@amd.com>, Xenia Ragiadakou
	<Xenia.Ragiadakou@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
References: <20241205054252.471761-1-Penny.Zheng@amd.com>
 <20241205054252.471761-2-Penny.Zheng@amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20241205054252.471761-2-Penny.Zheng@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3cfb9d-b9ba-4bc9-be8c-08dd156a2bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXBldGdPMVhWTFVjUFNJeGtCc25vaTE4dmxmNU1Gbkx4N09OK0pTdnRCTmZ2?=
 =?utf-8?B?OEk4cHh6cEJjUjNrQ0xaRDQ0OE5aeGZlQTEwNjd1Z1RqMmpna3l1MnlCZEVG?=
 =?utf-8?B?RmZJVkpoZ1ZoMDR2ZjFkNGVoa3VXWmEvcGlmTmpiMFhrYXM4ZG9QbU1Gc2I5?=
 =?utf-8?B?dEV0UmpNQlo1eWJKRHFJK1NHV0JvaVFycytjdWQ2NFlzZkFpVEJ6OUJja3V4?=
 =?utf-8?B?dEk0dXlDNTRuaHZSTldWOWtVZmtYK3M0K1Uwb0twK3lkUUp2RWo2TVdxTXRS?=
 =?utf-8?B?WjJLcUhrYnVqNy8rU0NKMEVwMEpXNUxLMkM5cGdEOGwrTXlCeWUvci80c0c4?=
 =?utf-8?B?RnppTlJzSjFTaE42OHlONmFlSzN4UWU4b2xWcmNEZUJRT01uRndxWnNOUlJK?=
 =?utf-8?B?K3U0THdLVFFqSlA2Z0k2UzRQYVY5WngrcDAydjg4K01pU0lEbFZLakUwd1Zq?=
 =?utf-8?B?RTNVU1l6TlcvalZPcndmWWl4ODBwS2JRMUlzN1I2Wmhac21kd05tcGVGQkNv?=
 =?utf-8?B?a09OY2cxQlJrb3IrelYwNVplOHBGT1ltZDhJTVBOVkh4QytNRUl3S1NpVUN1?=
 =?utf-8?B?dzEzb1NTcXJzNkhVVGEydm5mM0J2ZmcxSW9ITTgvQ3NMNW5LTEFGNTVkK3U1?=
 =?utf-8?B?QVFBdTA4cThzUDE0c3liajY2cDVuMVNnQVl2MmlGNmNFYTgyeUU3RVJJYzJM?=
 =?utf-8?B?NkpGV2swRkxSK0hlTFdEajdhOXY0Q1ZubGtXU3ZYN3VmVGpJTVV2a2pKT0tk?=
 =?utf-8?B?NzJmRUJrKzdKbm1iS0h5K1JlVWJ4a2Q3aFlaVEFUbXZYeldBK3d6aXVYKzVj?=
 =?utf-8?B?ZWNFVWJlOXhQNERHNWZPYVFWU2FwQTVwYVJwM2VHaDNxNmpseVVHbjZZcVY4?=
 =?utf-8?B?UjVYK25SRFk0ZmduQ0E3RlpscmowdjJJVHpDaXRGaXpMVFRwUHc4SDR1aXVK?=
 =?utf-8?B?Y3JPT1lNSjJOa1FxbWhXc01qRkxHbUxNUjBQdWEvVjdmZENqQjRacXFUc2Vy?=
 =?utf-8?B?YUsyejVkdDdMVTUyOWNaTSsrNDNYVCt0ekJaN2Ewc24wK3psUTVxZVdHemo1?=
 =?utf-8?B?S0dISWxBNUpJNG9Md3NUdW16WTdvNjlTZVY3eDJJdVlBRDhLV09tcWp2VzVo?=
 =?utf-8?B?YVlUNmJpZFZacWdVTTZLRWNhSEZnb3VwTmp6MkQ3TDZkQXJoRnhoMmJYNzN6?=
 =?utf-8?B?aUNWWmI3MHdtdUJkbStsWG1Fdm4zc0hYaWVFcTJDU0k3cWt5RUJQeFYweXFB?=
 =?utf-8?B?alA1UXZVbS84VGZEZDZILzlCb0dFN3luUWtQN05UTHoxeXlKMkJUVHZLTmh2?=
 =?utf-8?B?MmhJN1U3eUN4VzBobFdUR1Z3UFVabTNzSm8xU01BRjhFbGNzaEF4Uy9HOWdI?=
 =?utf-8?B?TTlES1djN0RORlJDNjJJT1drRU9kNW9WV2VQaHdnTTJOa2owNDBtRVhjdUZk?=
 =?utf-8?B?UUpOSEdvNGpRUS90ZVFPSmRCaFFmOU9Ickpyd1hDdE1jOWtBMzl1WDhQcXBU?=
 =?utf-8?B?RnZYYitzR3F4WkEzZ3VIaVBwQkxtZitocnJWUW5JYnZvNUlVUHBrcC9BYlkv?=
 =?utf-8?B?b3Zobm42Mm5vR0NSZm91QXF6Ti9OZG9NTHJ3OXlHR3ZDZ1Q5cnhEY0d5V0k1?=
 =?utf-8?B?ZGtjTTYxdUxEZmVwOWxBNU1JMUprbEdqcTRSaENEK2VGZE45TWV2VDNram9o?=
 =?utf-8?B?VFIvRm4rY096SFQvS0d4cmlNZlF1MVgwRVAvOHhHUk5aVDc2STN2ZzQvWHdD?=
 =?utf-8?B?a281VDJzanBKRzEwaVVYU2FWcFpzd25MYXNIRnFKaWNHK2crOWxtUi8xTlRZ?=
 =?utf-8?B?Wkh5MGpCWno0d0w5eGdGb2pLeWMvblZRazduZko0bUp1YWQ3ZXNMd2dzREVQ?=
 =?utf-8?B?cHVmMWQ1M1JjeGJWMXdqZk1GVWlQQkQwQkxRelZ1R2J2ZEliWG44MjJUZGNX?=
 =?utf-8?Q?VOR3QbMsd6jKHSDcibzrisMOiB5L/MIY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 20:19:49.8479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3cfb9d-b9ba-4bc9-be8c-08dd156a2bb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901

On 2024-12-05 00:42, Penny Zheng wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
> 
> When running as a PVH dom0 the ACPI MADT is crafted by Xen in order to
> report the correct numbers of vCPUs that dom0 has, so the host MADT is
> not provided to dom0.  This creates issues when parsing the power and
> performance related data from ACPI dynamic tables, as the ACPI
> Processor UIDs found on the dynamic code are likely to not match the
> ones crafted by Xen in the dom0 MADT.
> 
> Xen would rely on Linux having filled at least the power and
> performance related data of the vCPUs on the system, and would clone
> that information in order to setup the remaining pCPUs on the system
> if dom0 vCPUs < pCPUs.  However when running as PVH dom0 it's likely
> that none of dom0 CPUs will have the power and performance data
> filled, and hence the Xen ACPI Processor driver needs to fetch that
> information by itself.
> 
> In order to do so correctly, introduce a new helper to fetch the _CST
> data without taking into account the system capabilities from the
> CPUID output, as the capabilities reported to dom0 in CPUID might be
> different from the ones on the host.
> 
> Note that the newly introduced code will only fetch the _CST, _PSS,
> _PPC and _PCT from a single CPU, and clone that information for all the
> other Processors.  This won't work on an heterogeneous system with
> Processors having different power and performance related data between
> them.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Hi Penny,

I think you should add your SoB since you are submitting on behalf of 
Roger and me.

Thanks,
Jason

