Return-Path: <linux-kernel+bounces-341006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34614987A18
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BD71C2225E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54F183CAD;
	Thu, 26 Sep 2024 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l3xAagw6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121E13CABC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382765; cv=fail; b=IrE8tcqs8bMbWe0F6XCx+pHzzQHTx050t5AJg/WQYjRBu7austEiykrDFU31KNPMzDUAOPaokyl9o7LNBvmrS6O8zLvcWlXj2UGSbXLAgAkPaehXjNRBWRj+XEt3r04z8+G+mhrNYZK6RSwCygoe9AqkNIjgPOmqt4k6WN3pmA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382765; c=relaxed/simple;
	bh=cClC8jF8FaJWGrm/PwM24G7L9Zjt4MXH4zUFUSwPrQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l0Hhc7BynU9M9Bec02OkIDxYDaEF9RN57cAYe8Fciq4jMHpajdJmskXnO1oEb6MZtKaqKn39ifKNs7SiRK6vErGlbRuAH66R6bJcKcl5Hjbue0rq/cwcIh65fxn5unrI/La5vQ5VwhmqMSFkD0b159vMuMwd40y/5vKEpjMpcBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l3xAagw6; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyyfybYYh8hNeDkQi6s9PC3wNRwR6sQcXCc3NwinEHNyIabgv012ZDpTIcycOBhYgdphFaEujVPIESIgoKEWa7moVgu7OIPmSUrX/pqYn/eewUIta1tRjp/tfREMQun7ID5TFau+y67EVW0QoqNdbFb+7zq1ugbRZAbHVbpRzVLB6ytSEO58ppWdwc5uxUfGz2rL+JIrYL5Pf/PXZdt85BswE8JYuT/9Tod2pClNQwVLiQb1E5VnqhwZ/jaZkNyoDJHLtq/qVx2tO7j4i7UOa6kV0dkG54BWF+WV3NJE4RmBXbcMAXfCrsAUYsmL7tJCmKmuWRTLkvhms4eOx6o7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTZZx5uMewNrXXhZ+45ESL4qqdZtuN2DWJ2yhQpeT+4=;
 b=bvUMrbdDTlvMzgXYXU021WWQ71FGFdbKYhEDMXYFS2zw6ZHTnAKyIYqYCrVm6LjVPKeXAiSxwqJOPdLPC/QjJm1WRo802gFePG7Rw9K0SXdCerbVgx9B6F/m0jAMbeo05e5KI4GejxyCAIu+SYFRHPcpr5Jfk5WJhy4Qfvk8xQheUose0CNnaj7woOyG9eZpk8v5YUS00mm1jAA8Z/0PkW74+psm3tiLwdim4YEdYrUZP4sQbECXw9Xkh/k3B5DlB5GdUpmO0BmWP8Wxo+V8eFd/9B/W6upbHpg+dXr2/7CXCBG+NVcbOaF+wISWVAQGWdeFwv22n/vI0BGgNKtxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTZZx5uMewNrXXhZ+45ESL4qqdZtuN2DWJ2yhQpeT+4=;
 b=l3xAagw6fGAhzRs6ZOFOTlSO0M5hFNphUVKHMp0xwgb7hi24D+smtGqrctK0Z3N2DRCMv4cuDT1oIz4LLNvG1m1FiuMMqVm6xGFDFsC671s7M3/azUgXdVDMUN4sjLOc643wlTggZeXVb3mWpBkwtfx8WEKCnCk8BjkXACx0y2k=
Received: from BYAPR08CA0046.namprd08.prod.outlook.com (2603:10b6:a03:117::23)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 20:32:40 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::b1) by BYAPR08CA0046.outlook.office365.com
 (2603:10b6:a03:117::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Thu, 26 Sep 2024 20:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 20:32:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 15:32:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 15:32:28 -0500
Received: from [172.18.112.153] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Sep 2024 15:32:27 -0500
Message-ID: <e122e077-ac13-4c2a-b911-28d0c7cf50b8@amd.com>
Date: Thu, 26 Sep 2024 16:32:29 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] x86/pvh: Use correct size value in GDT descriptor
To: Ard Biesheuvel <ardb+git@google.com>, <linux-kernel@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>, "Boris
 Ostrovsky" <boris.ostrovsky@oracle.com>, <x86@kernel.org>,
	<xen-devel@lists.xenproject.org>
References: <20240926104113.80146-7-ardb+git@google.com>
 <20240926104113.80146-9-ardb+git@google.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20240926104113.80146-9-ardb+git@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfd573a-c9ad-4c90-a9c8-08dcde6a5e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0l0TmpTY2VGSVo2eFBncGNTL1lBOEZCRWdWWldyUXVHVmVjOHBoVzdFYmZK?=
 =?utf-8?B?aWtzWkY4UTFvYkNsd29GazdpZTZ4bUJtWnJPSWR5Vjl3T0V2RXhXMS9SSjBz?=
 =?utf-8?B?RnBxU1NYMHBEeUVob2VtbFdJWmxFY3pSNks5OGo2NENXQUFZOHh2b2xRUzFh?=
 =?utf-8?B?OGlwQXJyVUJ1dGt5aWRKM3V6SDE0U01lN2doTTVWUXpXRWFSZ2hiL2xuNmhU?=
 =?utf-8?B?S1NnWDZDRnJOeFN3WHdCbWpsNHdDZnRpdXh2UVZmL1RGSVJjcUxpREprV0w0?=
 =?utf-8?B?cGZiNmx5N0pMengvUzNKVFlmb0taZVFhQVJSaWc1OTNFRVFKTlFRaWhVejdT?=
 =?utf-8?B?a0k2V3R5dUo2d3VZdEt5N2Vhamw3a2V0d3JVbytsZ0FGZlFZWjZ5SDdTT1ll?=
 =?utf-8?B?am9SdU5Za2t5dGZDSFFwWDcrb2NSSGxmNUQyRlZCZ29JN25CQ2RHK3RiVko1?=
 =?utf-8?B?L1I2SnJJQzh5VlA2eE5WdW04a3htcWVPekdqSTRaNkk4SjJlTU5SMGxxazJH?=
 =?utf-8?B?R3VEaHNiNGhLRnB3MllLbXVORnJURkZDZlQxVlRKeXJlUEJER3J4Zk5yd3JG?=
 =?utf-8?B?dkY2R2RQdlVQdW5jVldKd0phKzBtcitiUkFmUkVZay9QZTNMSUtoTlR5a0s3?=
 =?utf-8?B?RDBzYUJTaDczK0NveTdpSVVyS2c2NlhrL1BPN0JIRFl6TmhFOEFMMDdNaGt2?=
 =?utf-8?B?Z0xWcm02cS9ybkdkeFUreEJEaDZ1N2I4VFdVOVBoeVhlSXlSYjFMSFVxWHk0?=
 =?utf-8?B?Rmc1ay9seG9nWmRSd1NPYmJ0UEIwZXduMVNFcUZGTlV4KytTOTJLa2VHdVND?=
 =?utf-8?B?WFlBR3dVbFhuMVBVaDRxSzNsNjRMUGtrajFtVmNjcUgvZWc3ZVB6RTh6SFlv?=
 =?utf-8?B?ZjhuSlpod2granV2V1FMZ25pYmJiWVB5Z1c0R3p6UlYxekVvNGV3KzMzWWNR?=
 =?utf-8?B?NE9lZVo1cjY2ZEJjQ2ZVTEFRMXQwZUFMemgwS01ITklENHR1aDhLam1aeXNP?=
 =?utf-8?B?V1RTdFhNRDdUa2hqeHppS216d04xUEdqOFBSTW82MHNsQWJuUHlVQ0ErZ2k2?=
 =?utf-8?B?YWRwK3BTRUYrS2JLYkRWTDBxMENUV1NSc2c3NHBzaXFjc2NpRVZWM25lQ1li?=
 =?utf-8?B?NWlSTVJIWVNPNFhrVTFuK05KanBaN0ZOZkV5OFFKL1hvdEhFY01LT1E2UURC?=
 =?utf-8?B?K2toNEpHdFMxMy9zbDhrSHA4RG9qQ1VYY0lOQ2EwaVlBWDcyTHFONzM0QmJo?=
 =?utf-8?B?WWV5MjNFV3k4QUphVjFhLy9JbmdlS1Fjb2JTZzRTbnRlTmNyajh6YnVsUEoz?=
 =?utf-8?B?Rmc0THRRb05Pdnp5djdGMjlNR1lwOFRzc1lNUWJrd2EraE9zbGszUzk4YXQ5?=
 =?utf-8?B?NllYODh6ekVDY2ZqTmgzZnRmaWdJeHFlNlJJWFF1U2pCK2s2L3ZCNDl1L3BH?=
 =?utf-8?B?TFMwNGsvTitzeDZFU2VVNWhGUitVQXJodjh4R2daQUY2ZnE3c0RxQkdOYVVG?=
 =?utf-8?B?dzAreisrSUJtWWJjVGh6T0l0VzN5eWRNaEVMSW5GWmNaTTBra3hUU1JPVVB1?=
 =?utf-8?B?SUU5REZWNHczRlVjUWpGSmR1ejBVYUFITzROQVlYM0k4M3p2elR2Q2w0L2ZN?=
 =?utf-8?B?TWtQM0RzZThKVm9lN2thY1RFVHAxZEE1VnpyS1dXcURsaDdBT0M3Wm1OcW8z?=
 =?utf-8?B?OEtyZ05LYlU3ZUQvelhoVExmcStYbkhmMGRHcnZ6UHRjQVZ2MGtpZUVhL00w?=
 =?utf-8?B?cGl4dXBMdjkvS3Y2TUE1cVQwZG5hditXNnk4cnVVMHlhbWtkZUhURGFNZHpU?=
 =?utf-8?Q?D9m7/iKBMv4stpf0HTWMx3i4wIAMNFFr0iOWg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 20:32:40.5868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfd573a-c9ad-4c90-a9c8-08dcde6a5e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666

On 2024-09-26 06:41, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The size field in a GDT descriptor is offset by 1, so subtract 1 from
> the calculated range.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I guess with s/size/limit/ per Andrew.

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Tested-by: Jason Andryuk <jason.andryuk@amd.com>

Thanks,
Jason

