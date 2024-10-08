Return-Path: <linux-kernel+bounces-354513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FC993E7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA3A1F21794
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6313B2B8;
	Tue,  8 Oct 2024 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PPkLGAEO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D323A0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366767; cv=fail; b=XknqjzxfdbGcfLOUGqFM9D0INRzBPvvS7V+SXCARSYR6dPiuAQemahJxQczs/uDGyaQ5DD1rm2iGOSY6vlxDX6rO9vzMlOuT2wAvKjnBchM6wZgdP0++1LShsxDOo6sXeovf+m/CHZDmmh6fWYMVDpeGzyMN4gDPZlE49lyOMmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366767; c=relaxed/simple;
	bh=2kuqNkXtNE72GNK8yh0d0TJohtrYSQIBoqFqu1zD4Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o6IsUGXNSkz8r/9PJJ6X16IQ5kV7czjV6mntMLo9JxQbhGvAo+rP8vp7IkHdt+LJ+fCrCOb3a7pOft79M2ssQOVFyNVZ6s6s947GqyI+Amap7nLIkf+MuLVQFId2HVJEcv83SW8qPFvyWDmTayn9M9bXQ/BSWPIp/xEYdFeW8qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PPkLGAEO; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paJ6YTnojdlATER4dZBHDAlOxPjj6OT4Lml6K2jCtDFGPmZAT0svZjusBM8A6LXlhsOimAU/QBr5IXggxU4It15iKW67oEKwZF6aupz3TL2fmSM3+kHOsX0y/mTZPqPdyxfPFMxSGE6HXS/l8Q7qU6foZUhN/S8zuL6N1uX/bXnTszPXjeF6SOuUEaTHmNARNpz4ja3TDDLoSHAhjTpY3cYyCGSvCmS7LqOGz9gv58GpuFPRC4u+TUtl+ojJKCS3XJp2OMvIHNf58+hz2R0n/aO6kD1Gm4ElPQ4dcAO9GkFa77/b5lJhHg6agnPH+xUnz/hTEFK8TXz2fqJ1e7afHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HtaP2k51IMbkZJuz8VRPbm4Ki6sGuYejJ7hp6ia59Q=;
 b=UMkA+zbv7QlG+7T4CYwkFBZUI+pHs94TQxTcYJApYL+5hdD9HpAGoTVkJ3APsexC3lH7vUTqQVDuLqceo7rJAVtBNCGU38s5Iy6t7ACSedzYtZUO/TzzdTCU3wgO48YI8+4bHnC2bRHffonPq/jVdEA//zw+McH+KitZieO2ZYBKWr2/w5sYTPjgOdECba9KywYyR0eXmLjPgZ/H+h1k/cNyY8oLspmWP5iX5UKiTKnfatN3tipNubD6Qz6SzVeFUhGfKb5eDy5GjUOgnvcHcuFJ+2SG2k1QwAsOLpL5F9QlNqwQUl5KyOol0VIOb42fcAYSh+7gwRMoJtSuCmElvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HtaP2k51IMbkZJuz8VRPbm4Ki6sGuYejJ7hp6ia59Q=;
 b=PPkLGAEO5eG/t34VLr8usO4UJoK357mowWLxzdlFTkLD6MveL6h999Fw9wSk/Ujk6QhiOhlJoZNRxaxmv/JjLxomJjdYZEWRLlH1bx959cHCO+xWHhbI36XtIIc8nTCm/4AlWuhoQ2iHMVNq6hoenUE50VcWOOmaXNl80iotEyw=
Received: from BL1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:208:256::20)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:52:43 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::70) by BL1PR13CA0015.outlook.office365.com
 (2603:10b6:208:256::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 05:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 05:52:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 00:52:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 00:52:42 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 00:52:41 -0500
Message-ID: <c6db82a0-7658-e840-0d1c-c748ed298e77@amd.com>
Date: Mon, 7 Oct 2024 22:52:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 08/11] accel/amdxdna: Add suspend and resume
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, <ogabbay@kernel.org>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
	<sonal.santan@amd.com>, <king.tam@amd.com>, Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>, Xiaoming Ren <xiaoming.ren@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-9-lizhi.hou@amd.com>
 <fd84e624-a534-26a1-a434-3c8390bbb311@quicinc.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <fd84e624-a534-26a1-a434-3c8390bbb311@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 53973d87-56f2-4c02-6d62-08dce75d6d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW8yenM2T1lCTGltK1h6ZS9zY0NzdlVjQU5BUjhQOWdqVE1vODZJN1FSVnNT?=
 =?utf-8?B?cjJFZllJbWJlWmFsbGphQ3ppc3l5amFNMHgxOWNBaTMxT25UUVNUTjhhS0tj?=
 =?utf-8?B?TEdvYklFQ2ZqektVMzBvaGlSeHQ3Qk5ueWsrbFZqYVZ2NTBYN2crMWJqR0w3?=
 =?utf-8?B?bjRxdlFtNVQ0OTkrR2FjSlBYalZEM2dnZVluSWlsV0ExajR2Rm8zMHBxQW40?=
 =?utf-8?B?SjZSdFc0ak1FTExoY1VkNXl2U3BIMDUzNFFxbkZZbHNWR0EyM1d0ZjlBa1ds?=
 =?utf-8?B?YktDTEhDclowc09HeEM1dG9vVkVSbXhjUHVNS2xqbzJIek9hTGFSb0RVSVJt?=
 =?utf-8?B?N2FYeFNPaXAwTDhGV1g0VXVHOGhTeTFoUmRZZVhYZ3ViU01mV3NvUXI0RmQw?=
 =?utf-8?B?SEtCY01LNEZFcGtwejd2UEEwL3BXQmZIM1ZUMzFrWE14T3VUc2diY214V0wr?=
 =?utf-8?B?NnVSOURnbGpoSjFidmRyeFd0VkVSdGpMRm05RHprUEVjY3RHZXZvS3Q0VERu?=
 =?utf-8?B?L2lVNHZxWHZML0UxbDI4d0J5cTErZW5LbFA0U0tlbEtZd1NSWWM3SlNnZHdi?=
 =?utf-8?B?cWFKNW14dGYwR3cxeU1SSTVsa3FRbEZaVktrY2xUdGEvWjRlclJ3NytWSVN5?=
 =?utf-8?B?VzNQYjI2VUw1d2I0ZzlpQ3BJSGxFZWdmR0NQUW5tcU9JbVhnMHl2M0FMZ096?=
 =?utf-8?B?TkxpRGdxTWxCOWRxTkNHSHlCeTc2alVUSzFLTDkvbmNaMXRtcVpCN0RIUDN5?=
 =?utf-8?B?b0lBeS85WUJHSjBkWEhGUng0VzdYcVcxRkhGY0Uxa2RseTVHYmNrcTQzamVm?=
 =?utf-8?B?ZXZ5dW1QYzBBaW5OdFV0ZjVKOGQrU0VPWlluYnJYbDZqa3o4SVpoelIzTXZP?=
 =?utf-8?B?ZHdxMVVCUklaMHB3SmNuOTlvRjNhTEZZenJUU1ZBeFMxOXd4RCs4STJHRGl0?=
 =?utf-8?B?ckpTY1JCNEpld3JQdGpkYzFFVUNHcDJGMGM0QUNSVDdWVytjQ1MxOHkxMUta?=
 =?utf-8?B?a3F0OXlnRUlNeFlNNkR5TVUxdFczNHNJeXVycXN5dk9lWkgxbW9qZWMzbEVz?=
 =?utf-8?B?aDNTT3VnR25LaC9rUkRwQTY1Y3RjTGVjNmY1UDNNdGlOODgzZlBhVEpBTlJw?=
 =?utf-8?B?VUhNUTRXSmRQUE1FT3dBV3hic0RtNDB5WTY5TjRlQzN5VDY3QkZlV0VhZFd5?=
 =?utf-8?B?cUNPd3REUFQ3dkZlMHlTL0VxaGg4NFA2MzZXSWNjK241cWNwdHFKckFUOVQw?=
 =?utf-8?B?RFlZZXpQSGlMVGZlRGRXTExMRFFnRVROTmJSQldzTWpCZVZ6emRBbm4yaFcv?=
 =?utf-8?B?ajk4TCt3MmpGZXArdkw5UUN4VG85U3lJK1AwLzdvN0lvc1hqSDJiQy9aNCtv?=
 =?utf-8?B?QUxtVzlXTE9GTER1aXc1dGNqbXB1NTFzK2lNVkZKandabm5mU2JudThjVDhM?=
 =?utf-8?B?dFM5VHE2NUFNZndHM3h3ajNZMTdUdjZ0alVHZ3RRK0J0QnpUS25ITWhYaUNT?=
 =?utf-8?B?K1FsdWo5R1dKZkg3UE5XNm56c3dTS2t3TWwxSTNFVWMxSjUrQjhQT1BpNU9v?=
 =?utf-8?B?UjBaZi9TaDcrY0U3M2RPY2pMU1pEdjZ1ZFdWOXkwS0Z2ZnRuUllUSDVNbXBB?=
 =?utf-8?B?WG5JNWM4U2w4a3NORWY3ZkF2cVlsMExwNGt4Q0FsQVZyWk16U0hVWkdIczBF?=
 =?utf-8?B?andneFZDT09Dc3JBZytaTUk4RytPTXNFZzNRRVBGZTVvNDBMalYwVlEzSEw1?=
 =?utf-8?B?T3JKTW80ZWRwbjRJMFRDbS81N3hsZEw1MEZlanVsNUQxdStHM3NRODYwWVNn?=
 =?utf-8?Q?iVUWf+5nAWdd9+/kFb0M7CMNTWmEayJFKWmRo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:52:42.7409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53973d87-56f2-4c02-6d62-08dce75d6d1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059


On 10/4/24 11:08, Jeffrey Hugo wrote:
> On 9/11/2024 12:06 PM, Lizhi Hou wrote:
>> +static int amdxdna_rpmops_suspend(struct device *dev)
>> +{
>> +    struct amdxdna_dev *xdna = pci_get_drvdata(to_pci_dev(dev));
>> +    int ret;
>> +
>> +    mutex_lock(&xdna->dev_lock);
>> +    WARN_ON(!list_empty(&xdna->client_list));
>
> This feels weird. Can you explain?

The driver uses auto suspend. When there is opened client, auto suspend 
is held. So the client list should not be empty here.  The WARN_ON is 
kind of assert and  can be removed.


Thanks,

Lizhi

>
>> +    ret = amdxdna_dev_suspend_nolock(xdna);
>> +    mutex_unlock(&xdna->dev_lock);
>> +
>> +    XDNA_DBG(xdna, "Runtime suspend done ret: %d", ret);
>> +    return ret;
>> +}
>> +

