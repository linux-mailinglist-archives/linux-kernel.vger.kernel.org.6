Return-Path: <linux-kernel+bounces-445238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79779F1325
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A04D282D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA41E32DD;
	Fri, 13 Dec 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MEuMTG8Y"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE673175AB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109363; cv=fail; b=eiA87XHVD/dkE2iQ63PWs2MzboOGwL9JMrHG4qTjHEFlFUY9ecUnXbys4mX+HEDhigSMUHnnygFu7ZTlNNVU8skO85suFy90u4448bfc4VGZITyiQj7XvKA9+wkfBTtLTHBDMiruuPJM9Y6ZUVmI4V0f3FW3ypkm7t0dcwieUZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109363; c=relaxed/simple;
	bh=JhOh/uN99pFQ8NO1UcJPFLaT7Dnuy/uodERNvkSGCK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VE0+CRDXZRN42IYbEehuRK6I18I0cI7b8e37uQEv1WAHGHs7P7GH2gMfxxyqkk8p1K8gw/ZiNWesMaaMeN7ub2eII4VclI1C+8udw/hFWrLbXRx90P8DcrtoZsNyA30x7n4P8DOaN+BLRApXEFELorNCiuvc/3uRg1Ec0lsQYH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MEuMTG8Y; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc3/TYaryqUyK5b5VMTgLhawyZT8P2nXqE5gJQzA4uXHleoZE2ua84RyOrO/yZje8rzgf56Ug3nf9lPzk/Vhq4mECzO5t5e2mSqOHspd2z6Xg40/ti8PTp+WSt9p4WxRMh+KBf9eaM2irWrMrXLiyCjMhUkS7Gn4m0rCFVsnZXDNru16CpHhOnA7AhuM49U++8twuuJMbKkaW5EJSICDqIvlfdCST1vO69hzXGBHOK23SrxSx5y53yPnWq3BjLSY9rviWcyyA34lSW0vtpS1gkryneUDideR96aZfAIrakcdsuhiaYtPwsNVMm5LdQ3+oznVQaOMyOwCTwQlfkilFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UU2nA75GFnjPiEj8kPg4IVK+z/lnM7XIF8DMy9RgIM=;
 b=O2fCovdF+8Q/5878LM4gnhSm5dtmiWmqTQFLow49rzXPIdkenRpkcr8wHIYMoay6iGMGGiNZgcAOgROY9hnZqx2ZcBxtme7Q0yiGPI2CT5AyvUVhunNSYrgqvMCMNVobKLErIgjuPsm6ecoRolLpcpP+TuaEz4vdVQ0/iRuIX1bGDDLjEv8Bfn51mY//X9RnvlZrBy/G9qEEkhd5/7tvosFq86O7y7Q31jM+TK8FFELrR2jz0QOLc6fAasZhAA7PZRB1qar24tvOrAHFtB4wf+RaQvPo1hRPpHXHzQK91hlIzJgk92VD9jmBxRoMqgMFfC4EEWZ8MwMEOboQY01jPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UU2nA75GFnjPiEj8kPg4IVK+z/lnM7XIF8DMy9RgIM=;
 b=MEuMTG8YqVA/OdUHTP3luRS4v8AouGDbtNEPGn0WGwr1YQH/rCkN3Z86VmQWlwAKXxV0EBRJj1HFKtX+aMnQw9CnRe4ST2zfl2X6YZZ2xHN6cUknxUoB1O+rz9lfDQwE7bEQ4nNDbUtREzDGKDkVEOb88nfr7kjYAumaVluV6hY=
Received: from BN9PR03CA0920.namprd03.prod.outlook.com (2603:10b6:408:107::25)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 17:02:36 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::85) by BN9PR03CA0920.outlook.office365.com
 (2603:10b6:408:107::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 17:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 17:02:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 11:02:35 -0600
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 11:02:34 -0600
Message-ID: <ab646462-07f2-e09c-cd4d-6bc697d8cd43@amd.com>
Date: Fri, 13 Dec 2024 09:02:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 7/8] accel/amdxdna: Read firmware interface version
 from registers
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, <ogabbay@kernel.org>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
	<sonal.santan@amd.com>, <king.tam@amd.com>, <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-8-lizhi.hou@amd.com>
 <d4db5e3c-56b5-ed77-95af-15e9271339ce@quicinc.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <d4db5e3c-56b5-ed77-95af-15e9271339ce@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e0de11-5e0a-4ae5-8e7d-08dd1b97f146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm9ZaHJ3OTJkR2hnUXpOaFovRmFIQlM4TGo1czc0YW1BQzdBQlVXNmZ6NEx4?=
 =?utf-8?B?Rm9TS0JxRjhjcUhVbGtHZ1lRNm1JYUpvdy9hRmFKdTlCbGIvOUpyUDM5NFN4?=
 =?utf-8?B?a2VGUjIyS2dlL3FHNEVaTVVrMUhBZjZPM2R5aEJXOWxVRVVxRVU1R0k2L05l?=
 =?utf-8?B?UWZLb2tjR291VVVoTDhXbCs2OXFZeEtuVWxTK3BXY2pYRjY4aUpvQmlJU3ht?=
 =?utf-8?B?VDV4bVhjeFljOG0vekhWNnlsc1pnSGNSTU5wcXMzNVRwWENtTnlIRHhzMW02?=
 =?utf-8?B?aTg2T2JFRUU5djdRSHJ5ZHZycmJ4ZnZJUTdUcDJiSDBSdW1XbENEb3ByQ2VC?=
 =?utf-8?B?Y2MrYVFzNEhPb3l3dlVDaWR5VE9TRVZaNklBeHpaRVNtRlhtUytTaXV4Rjl3?=
 =?utf-8?B?aUNjRFZZOGczUDkxRDFTa1k1blR3clVyMTFWM2hmb0pUdnp5QWJkZ2NJOHZs?=
 =?utf-8?B?ZDRTVGJrWXN0aHQ0RWM1cHVyM1NIVDd6c3p6YXYzL3FZa2RLQzl4dDlLMTZK?=
 =?utf-8?B?dW1KU1RDQjF3ckYxWUNPd3FNYVJ0V0FPemhVVkk0d2ZoMlNMUytYejFVMzdS?=
 =?utf-8?B?M1oxcER5OExUazVDZ2t0d1drOU40ZnF0ODhTMU9CZzhSVzlKdVA3QVlEcm5i?=
 =?utf-8?B?Si9PWDNidzVzbEhiZVdxTTNJV1FDUVUwcWY1YTZXd0FMcHNJQU5EbHlwMjJx?=
 =?utf-8?B?WHNEUG9FMTBISHBpdGhudHFpb0tRVGhaTnk0bVlESlhpNGdTYnZnRVltRG90?=
 =?utf-8?B?WW9SaEUxMmJTL21Xb2trUmh4SnhLZ1EwcDhrRlZKcWZXcDdFQXZud1BYUVBQ?=
 =?utf-8?B?bVlhOGJsaDZpS2FibGdpcEpNWkMrc2Zja0tJaExGL2w0UTVYMEg1cGlZMy9y?=
 =?utf-8?B?REQ5d3ViTmRMMFFKZ2NnV29FK1ptVmh4TjVFQ2JuYVNmUkw1QmJoWE1KODZu?=
 =?utf-8?B?SGw0NGYyUUZRY0QvWnhBV0NiNzZKcThDa3dQeWRVWXRYekxKNFRLVEx0YjJt?=
 =?utf-8?B?ZW9WZ1I0MXZveTdwamFrUUlxSVBDMllsNVVFbU5SWmxXR0xXM0JtSlNnNjk4?=
 =?utf-8?B?TW13SHU3WWNCZWE2N2FzWExGOGdmb0xKQXZjUlJwMkhFME9taHFpcDNhV1lw?=
 =?utf-8?B?OHlyajhTL01xd3d2cCtjRWxOcERtSzl4Vzc2cE04V0JuQVdlMEFYN0hVTENp?=
 =?utf-8?B?VCs1alFES2tZRFp1VC9sOTdMZHRQekdtMEUwbUZDeFNkOHcyT01GZVJpV0RO?=
 =?utf-8?B?RCtkR2pwTnVQcHpMeEJkMkVyamJtRE1NOXRVQTMyZXB2MjVjbGdNYWRUWno2?=
 =?utf-8?B?VWFUdFFtOTBtYmZPVHNKcE10NmdqRUZ4cVd4M3E1NndQelRCRERXdlVOUjdV?=
 =?utf-8?B?UVlhR0IvTkFIcHhDL0FRVEM2VG85akFCSlhCQVQyWjZFNDM0U24xRGhXYWNJ?=
 =?utf-8?B?VTAyYmUrbEpRT2cwcG5nWUY0RWQzb0g5ODIwZFpWRWdTVEFLV0hWOHYyRXY2?=
 =?utf-8?B?aHZnSGsyS3AydCsvbHhpNFBzNEw4Z1k0ZjErN1dWSkFiNjRBSjB6aFdrLzR6?=
 =?utf-8?B?NDVabUdwdjRSZWVxaGJuUzU2SlVyTTIzMW1lTHVaM3FHRERCRVBrS1lveHR4?=
 =?utf-8?B?OVNVU1dWRkVkZ1B3WnVOblZXQ1RYRGZHOEhHY1RidW0yVHJqMS9pakw1RmZm?=
 =?utf-8?B?NVR0bWNDVFYyc3VlWjMvaDQxU00vU0hBMFp1SzdBem56Vi84aTRMZ3BJSFFh?=
 =?utf-8?B?VE16Q1cxV084UGF1SXArVXdpQWJvRTBDd3dHSjEwVE11cWNnQ2kyMEFYTndo?=
 =?utf-8?B?dmE2NExwNDNpWlBKcm9hek5sMTVKOE5tUkZZZEtzMk1KRit5azBtSUJHTXl3?=
 =?utf-8?B?amdUWVlsTlY2cjQ4ZExVaHFGV0pEdkh3clo2ZGw0MmIvT2k4TjJvZXNFS0pq?=
 =?utf-8?Q?gbhjOy5D8QqnmTJ14CMz3Bw3lDgOedyt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:02:35.7798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0de11-5e0a-4ae5-8e7d-08dd1b97f146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908


On 12/13/24 08:58, Jeffrey Hugo wrote:
> On 12/6/2024 3:00 PM, Lizhi Hou wrote:
>> The latest released firmware supports reading firmware interface version
>> from registers directly. The driver's probe routine reads the major and
>> minor version numbers. If the firmware interface does not compatible 
>> with
>> the driver, the driver's probe routine returns failure.
>>
>> Co-developed-by: Min Ma <min.ma@amd.com>
>> Signed-off-by: Min Ma <min.ma@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_message.c | 26 ----------
>>   drivers/accel/amdxdna/aie2_pci.c     | 74 ++++++++++++++++++++++------
>>   drivers/accel/amdxdna/aie2_pci.h     |  6 +--
>>   drivers/accel/amdxdna/npu1_regs.c    |  2 +-
>>   drivers/accel/amdxdna/npu2_regs.c    |  2 +-
>>   drivers/accel/amdxdna/npu4_regs.c    |  2 +-
>>   drivers/accel/amdxdna/npu5_regs.c    |  2 +-
>
> Do you need an update to npu6_regs?

npu6_regs is added with upstream fw minor already. Thus, it does not 
need an update.


Lizhi

>
> -Jeff

