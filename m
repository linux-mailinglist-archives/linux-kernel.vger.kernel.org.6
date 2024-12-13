Return-Path: <linux-kernel+bounces-445207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13E9F12B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BB0163BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11F1E7678;
	Fri, 13 Dec 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n0mSgYR/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDF1E32CA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108446; cv=fail; b=ZvJtWamQV4WS3D3GENK70Xo1R2B4VVPyvjpASUx+49QQ9XnXmYu++cqYVenJI06noic8diNxL9/rkU3yQD8IXADAqSZXucJpFcd5TLLYXbxK2jBVni/BdasKE3IOW1uGE1J99/rqi45PBVAAjVh19TffeRCB4VTmQvuxrb6Idvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108446; c=relaxed/simple;
	bh=xsOirGCeqvhBm4Sdy7qCIyO4xI+QZ0co99aH+XekSPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ah0OUd8f5zDG64ChfKcMuydYK/8O8scSKVfDMZy6SOKjsx/5RJwvVrmbbdD4wv8EtN1dSK4MYzArD4WzwrfM1Kbt0EOIeHTyGO43666y8227oeN1kmdYaQufA17CohQpehuVj96jj2HmTXzAC7+vdeBcKPumlqqnnX8EwxsFvFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n0mSgYR/; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLkpWmJPk2voXd+eH1vI9SEnQmD5rS87bqdoVD+0jfBQSp8bECmrPsVt61fLOClGQ+omsa1Tsi0bS0gGU2B+Musl8FhgjZQp9w6kp5gbNUW7ulagv2UkpRFSZVd35CoRTIV0o/ECuzOUAuaI/NBz8jW9zI7lGX87ZG/2NP68TZzpebxBJ3LqHGuTu9ZAIUgoGR/kvlsg53G7B7kq7T3U3Epqm+hi98JJpcuZk9PEpzTq2jTCajx+jUqB6kBEMhN091Mb38LsEFentmMDuTKhGXFtE0uhdt/6K7dhp7GuT3A09e2dFi+YvbsSwSKa4U9PFSqzpw/fyezTuWALT7zGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1x7yqp/cE44PdLVSCLH8rjwbqoLSiVNvz/2NvdF4/Y=;
 b=ZmSGP/RDjW1TjVatmXpCepGXd7pI9vQ7lZROqMr6G8ei3oF68KR/G+8/9dzhcCzFXQcLPH/AQ2Txki4PS/QU5L0xsdA5ihZlS7NOvHrl8KBbLG6C/7v3bjmt6jL4/pg8BgkafRrpqRM+zqjDZDw2JpgNcM7UJTj/9VYGNTObXTkd5fWCi46IEk5ZGpR/9Mt85uxOiUAWehUeL8P2GldmWeFRRpLZG3cg/ktZTczNaJqmcvOd8o8fHbwJUjHdOwCG59kXS3TG5mb0c/3kn6w4kUSjlU5dwPn2wP1UPgF2lW9+TQXHQPrjYhwwAH9IIeNmzF4QgxBHvkbBAIPpRTnkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1x7yqp/cE44PdLVSCLH8rjwbqoLSiVNvz/2NvdF4/Y=;
 b=n0mSgYR/nYu70F5X3DAFBoRptVBsxY/wGZoTYBcdOBneoC5OTF+iKmLCsNA9dzak5ZAGVFePJ7GigmJKJai+8rtpgXUU/6qnU2zV11JWmDJqi5v987yngL0xGRF3j9zcd23g0RPNvni4L2WGvVx8zNYNm5IVQz1CgsoaOufY+QI=
Received: from BN7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:20::19)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 16:47:22 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:20:cafe::1b) by BN7PR02CA0006.outlook.office365.com
 (2603:10b6:408:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 16:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 16:47:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 10:47:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 10:47:20 -0600
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 10:47:19 -0600
Message-ID: <691cccca-eaf3-6384-5ca4-54c2d3548bf7@amd.com>
Date: Fri, 13 Dec 2024 08:47:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 3/8] accel/amdxdna: Add RyzenAI-npu6 support
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, <ogabbay@kernel.org>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
	<sonal.santan@amd.com>, <king.tam@amd.com>, <mario.limonciello@amd.com>,
	Xiaoming Ren <xiaoming.ren@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-4-lizhi.hou@amd.com>
 <96368cf8-792b-598c-0c82-e6d2f46cfb74@quicinc.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <96368cf8-792b-598c-0c82-e6d2f46cfb74@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d8718e-8929-4f8c-fddd-08dd1b95d029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2lMTDh1MDFmbWRnZmlTOFI4eXprNkZzdHluUnhYQUxTSFRpdElYRzJ6dDU2?=
 =?utf-8?B?MWlhVWsxb2pDTWhDTktjYWxJRkc1bkFsUlNjNkNtOTA4Y2pwRGhRdkpXSlhK?=
 =?utf-8?B?em1NVzBrc2VkOVJna01kTzd6ZjFQRlJCb3hoY2tzMThYbWh2TzVBSHVWRjZq?=
 =?utf-8?B?dUVxSEhDSWI0TVROMFhqS2o5V0w1ZE00V2VrV1oyTHIwbW43SzhDWEZQWlhD?=
 =?utf-8?B?RytWVFpJVHNRakU1YkJzcjF5dGJpTGFtWXZiYndwRHE3Zmw2SjdRUGY1b1kx?=
 =?utf-8?B?d3hGZCt3L2NUNFFMQ0dUUVF4cWRHMmxTOUoxREM3NjhJNnZ6eS85WC90dlh4?=
 =?utf-8?B?T3cvdkxlU3RVR291NU5jTS9rcFBrTlVrWWNpUGtJSXRraUEzQnF6cVdRYTY2?=
 =?utf-8?B?d3U2aEtDV1dGL2Q1bFV4NEEzZzRIbWhVV2YwdHhObEorVWljWEFzUy84R3du?=
 =?utf-8?B?V29NUXlvNTluUTBHaGloSXJBcXFBcDdmZnE1d1pibWRuL0ZWZDNoWEtCdHQ1?=
 =?utf-8?B?c3IrdkNnakZxeEVOOHBuUFQ0NDc5dHcwWlpHSkk1Nm9hcWNTNnhCZ05jZHFz?=
 =?utf-8?B?YUY2U3I0T0JSalRFaGRmYzhDS29ZNjg1U2dZbHc2a2R2SUJmNVA2VG5TOHFl?=
 =?utf-8?B?THI1SlFpMHQyUEhYVXEzWkdMZGtLNnNIWEZsRUIwVkRKVWdzU0tCY1JzalY5?=
 =?utf-8?B?SmUvOUxMNXAwQnNqM29PdHQ5ZzhmR1dJTzRidUxWaGV3OW12ekkzalI0KzVt?=
 =?utf-8?B?QmI1UFkzSjRONVhCSkdqOEM3N2hCNXQ4UmdvK002TzYvSFBIeG1KazdUcmNG?=
 =?utf-8?B?a3JPUFRzZTZiTDZrSWx0NGlxNVBUZWJDem9rcnQxZ3VqMGM1QkZPWnFyWE9t?=
 =?utf-8?B?UVBYbHFrb3BPQnYzN1k1aHlqOGhLNmhkODlhZ1ZXaG40cm5VcjNVRTdXTEZy?=
 =?utf-8?B?VXViLzdWOTN0YmowblE1NUtwZG14R1FSN1pRNnVUckRhWElZS3ZteEV0M3J6?=
 =?utf-8?B?ekhYdGFyQlRXVW1NZXNSdEZNOUFUL0UzTVlPWm1aZnowcHV2Um0xL0gwRW52?=
 =?utf-8?B?STIwbmtBYjNwK0pTa2Z1MWhCclFyTU9lc2JkYkNhWEx0dllybmtLalpqaGc3?=
 =?utf-8?B?ZWhORi9JODUrRWJaUnhNajhrVkFFaU44ZUxManRpVzN4S1ZnRUVKUVFSMFFu?=
 =?utf-8?B?NlZiMHNTNkFuTkdsWVJud2lMTG9hVkovL1hiOGs2b3NtOVFMSTcxZWhnQ3Y5?=
 =?utf-8?B?R28vck9ma0xWYkZmYk15aE1lTUk1Skw2K1ZqbXdHWFBHVGx5Q1p2NzFublJh?=
 =?utf-8?B?RSsxVWpsQmx0L2RraHZQVFY4RzVyK1AxeW0vQ0hIYndmR1Z5S0dsbHNHMnBu?=
 =?utf-8?B?RkVhUXJGN2ZpN1NZTy9vS2tmWk5lSUQ0djJXL2ZIdDF4a2wzbjJGNE9IeHZX?=
 =?utf-8?B?Y2ZXS2oxMGU5anBSaFlBM0duQklsS1hpVlhOenVkUm9Mb2YrQ25vWUNDbnVs?=
 =?utf-8?B?VEVDTzhtcStyZkRqYmREMFJHbmpKNnRiWW43T0NtQ2UxNFhEVFFLSzQ4NVFI?=
 =?utf-8?B?UWJJM2FpK3J6Q0dIUlhER21Eck9BQkwrWlRuNWxNZndHV1V2WlBDUUxPYUpT?=
 =?utf-8?B?N0lERE0xcDBpVkJkQ0xIa3VFcXlEaHJEUkxuaDNITDNOeFBwUmowelZNT2FK?=
 =?utf-8?B?SzJBR0p4bWp6ZEUra3RIeENjQVA3Q216QUpnM3IvYlFxUm1Wd1g4RTJodkpT?=
 =?utf-8?B?Zi9hMlJTSVhQd2hYcnF6bHV2dEJUSFV4WTJWOWhjQm5menVKM2hyT29aWGFI?=
 =?utf-8?B?ZVovZW5tK1dPdXRhUVNQc1B5Z21PcWY5WTRWazBSNXg0WWtBTVdkS3NFY0VS?=
 =?utf-8?B?cW9KRjBib29JaUM0L25ZVElxQ29ublpZd3RIcmFsRDFRUk9mWWR0RW9mbVM3?=
 =?utf-8?Q?yX3Ys/14uQwg5ejMlNxEM7wv6U4IkfK9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:47:21.2188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d8718e-8929-4f8c-fddd-08dd1b95d029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379


On 12/13/24 08:37, Jeffrey Hugo wrote:
> On 12/6/2024 2:59 PM, Lizhi Hou wrote:
>> Add NPU6 registers and other private configurations.
>>
>> Co-developed-by: Xiaoming Ren <xiaoming.ren@amd.com>
>> Signed-off-by: Xiaoming Ren <xiaoming.ren@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/Makefile    |   3 +-
>>   drivers/accel/amdxdna/npu6_regs.c | 121 ++++++++++++++++++++++++++++++
>
> This looks like dead code to me. I would expect somewhere else in the 
> driver, dev_npu6_info would be used, but that is not the case.  What 
> am I missing?

You are correct. I miss merged one line to the patch in amdxdna_idx[]..  
Thanks a lot.


Lizhi

>
> -Jeff

