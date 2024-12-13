Return-Path: <linux-kernel+bounces-445307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4439F1476
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBEA280EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA101DFE29;
	Fri, 13 Dec 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IeA0Xdt2"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCE1422D4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112690; cv=fail; b=jzECnVy/33J6Crv/Kg6J/bg7kHpnbAbRxp6YCAQk54gqmgdXNjOYHtSYxGPW28jnHDhJ4vYkW7UorGCn8xBfPt4TZQGotWGnbs6v6cpkaRIBjGnFRVX096SYodf8vv8V9R5hzPH0Ynf9hkWiRZgxRIJbWlHu1lq6AaWKzhs9JF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112690; c=relaxed/simple;
	bh=V+ynM7xk3MAD+Go3f0gVyglTjVqEm/D9JnzfePfagFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L8Rl0a/m+w5T6WzBI4AZZkmce67G6W/motIkDV+0kEItEj9BGKCSmcxstSqf6EuZPhsBM5AecebC/RUe6diFwBTBOKglLA2AoVN9TneDu9nPcxMJ+85K4bW4aR0bm57F3AHhAE/sAUIChoQuCpPkt155NxyHUOOglD4FUCK6Lng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IeA0Xdt2; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evZH1i7HEN6jDg3HxHxsr9vnYfmpjK8aOH6cDWdFkUcf/anWZXDURfRLthLrzPPTDJIWQ3n9LAGqhtozgNjU85VsQS/DQMw6FjE38TWTY6o8m85Y1C/o2MBWS82+PTMAbDkbq6QntYWtEWloa9GybYp6GnSv6B/sv3SH5RWZLk/GsV/xFRfE/XVpWUN1dbp1tkYYcwxl2slVbURvZI6+p4yJ9vWonLEyoOwQn0eAvEjLJJxJkOouRaT6xx/Gmzq/VMJ+TedadelpL4GJh7v57SMZHlf/3BELYwUctvhcKxOpWTLadzEsMoFCT3wVHoagf2ZtWbJQevgIAPCDjYlA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LudLtp/xSZ1S3AMA4lvo4K5nvgtxdajwQOdUFuegWg=;
 b=ooQYXRnPNIa1yOfBfuRmt0xqeaV8KfDbknU9eQGwaeuBkxdKICgbiQmhyqrUd9uXkYsIRZ6MPtQrzCeHEkBPHhDH+g0AroWkEjhOkt+hSVMsqXwxWEHSF3IZHk9FxXNIpHcV6IrUW73CHY/UxHcR1yhaC9SGwGk2+zaLnwerEadnBEbJRi+KRR6bLSWPfnnkfaBnOYIYypW7ea/UNmydu1v2VKUFSGmRsMqAU0ZE0kLV3ahm+qWsGK7l25zFn1U/GugVcZ0sHN9Fj7NIw68xHy9gucacNAlv2lM5gyxmoEkzuLP8HMTQ5do0kVBfNmNGMR3tCg2/yhFbv2bHR+0nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LudLtp/xSZ1S3AMA4lvo4K5nvgtxdajwQOdUFuegWg=;
 b=IeA0Xdt28o3VO8AWXiF5ek0QQCWpDpO1Ni0h4bQ5d2dP50V/IrV8KS90aVUq+u46DI0lUUVIEqR3NFsxyEviJTV8nFpsiwbZrpZ1JlL0zD7l2F0cK1qa2n1oCKxWex8qL7HW0v0Vbf0iBimwNwFcphYONIRTxQE9uU69wPTuDFk=
Received: from SA1P222CA0193.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::10)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 17:58:06 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::ad) by SA1P222CA0193.outlook.office365.com
 (2603:10b6:806:3c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.18 via Frontend Transport; Fri,
 13 Dec 2024 17:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 17:58:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 11:58:05 -0600
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 11:58:04 -0600
Message-ID: <ba6e9400-56aa-446f-a93e-aff0ea81f357@amd.com>
Date: Fri, 13 Dec 2024 09:57:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] accel/amdxdna: use modern PM helpers
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, Arnd Bergmann <arnd@kernel.org>,
	Min Ma <min.ma@amd.com>, Oded Gabbay <ogabbay@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241213090259.68492-1-arnd@kernel.org>
 <828570ae-1ff6-4bef-4bb8-51da9237e63e@quicinc.com>
 <e3d9dcd1-70bf-5656-e1a9-749c5a08a20b@amd.com>
 <6d4267db-922d-8c01-f76a-6b796422c24d@quicinc.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <6d4267db-922d-8c01-f76a-6b796422c24d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd12e5c-4eec-4c4b-735b-08dd1b9fb21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXg5UjRhVE8wd3lVWnB4ejIzWUw2elFFdkNHQWFKbHFwRCtaVEpwZkJjVUtO?=
 =?utf-8?B?N2xNRnZ0cnVhU3hobXI1YTkweTQ0cFlvWVVFUXcwV0ZTZER1OHUxc1U2SjJo?=
 =?utf-8?B?NWFqQURBMlVzUVRGYjdheEhVMHhaZjMvZEU2VFZqbU5Wa0VtR2IwS0Q4YWpo?=
 =?utf-8?B?OGxMV1c5ZlpDLzBHV0d6Mk5lMEY0N2pJb2J5Yk5WVlpaMDJ0eXgxazEybTds?=
 =?utf-8?B?dzdQQ3dVOEx0b1pNR2lDMGxHU2FiNHBodEZlU1lnZ0REZmNzYis5RUtuMlk3?=
 =?utf-8?B?TDhUM3FlVlpsZ1lDSTZ5RzdxYWlwM0pTWnpKWXhyMDkrc2N5ZDc4VGtkQnRS?=
 =?utf-8?B?QnhiZ2loN09ja2d1NU9iamtqS01WcUVURWVoYThFVmFPM0tMT2VuSXplTkFW?=
 =?utf-8?B?eWZGd0VIaFF3MDlxNmMyRjgwU0Rub2hVcXRRK29JeGtsU1ZhcEI3Qzk1ZUZo?=
 =?utf-8?B?SzVHVWhVcllDVGxBUFFtdVN6SEJwZHpycWRwUlV5WW1rMC80dU1SQ0Qyc3VB?=
 =?utf-8?B?MzVzYjZ2czFBdFF5eXhvbEVGeHdnamkvR3RWN1l5Y3FlcDhoaXV0V1QxOWFW?=
 =?utf-8?B?ZUhZaG5IRUUrQ3dxQmRIT1Q2Zzl0L2RScG82NEJxSEpzeVluenl1K0pJRVU3?=
 =?utf-8?B?bUdyeUtiSXJsOWJJOVJmVHZaWTRXOVlXQm5CS21tV2Jsc3l5YmdnTEE4YmRS?=
 =?utf-8?B?bUpZZWtxbmxVZzlKMmdyYkNmV3hHOUREQUh1OEs0UE41TTEvaW1saDFndUwv?=
 =?utf-8?B?OVJPNytnb2RiWDVvbnRIbmZlU29rVmRkNytqR3czQlpUb2NDRWlBU05EeFFB?=
 =?utf-8?B?YkNDaG5vdi9sSHl2Wmx5d2ttNXV0WTUrV05TY2xFZStFaXg5aEdsWUR3VFBH?=
 =?utf-8?B?TkdsL3VHdlkrcVRoMEdBaGZSdnIzT21XSXd0Wm1qcjBKZjRPR1I4UDE0cDdZ?=
 =?utf-8?B?dXFhZ3F4eEVuVFBCU2FMQzJ5Z2t1ZmpzdVRWcHNzYzJpaXJ3QVRmTFVTeFZz?=
 =?utf-8?B?YWgxWEk5eWtSVkVpNDkvck5rQkhlUjR6VlQxWUNDT0V2OGpJeG0wRUlRUXFW?=
 =?utf-8?B?WktGYXN0UXV5OURiQWQyOC8zaTV0eUdGMkhqbGlzNFhpTmtHMHhQNlhxQmJF?=
 =?utf-8?B?bjBtVHM0WUtpVy95L3Zkcm55MXFZY1kzMmt4WWJKbCtOT2hEa0NWd1dmeUJY?=
 =?utf-8?B?NEcrUmhNSFVDcUV1NzhrV1FleGJMRTNMamhMZm5XTXlkRG8yakQ3VzFlcUFj?=
 =?utf-8?B?RGg2WFpyMG5WRzFkbGo0L1h1MDZtS0EyTnRzcUtLaWxxamlVTmVON3Y2cHFO?=
 =?utf-8?B?eVIvQU12b0hCSXg3QThXZ3NEYUkxMk0vZjhCakRDandtOGtyY1NQNjlnTDNi?=
 =?utf-8?B?N3JWZHBURk1KakVrS2JaYlF2Yjd3SXQvZSs0cTVqSUtLcFR3TWE0OUl2dXQx?=
 =?utf-8?B?Ny9waHp5Rjc5c3hxeXc4elZlejhQTjJqWFoyYmg2S0Ezd0IrUnU1eDRtYVZy?=
 =?utf-8?B?enk1VFRWeUF5dDdVemFHU2JpV1c3cjdSVUxHRzB0L1NiT0NCNXBIcXNzdGds?=
 =?utf-8?B?S2NhQTNQQWt6Mlc1empObFZ3dnRKTGo3VUUweXhrb3hoQVlCNlAwcDdBZ1VC?=
 =?utf-8?B?OU9ZaXRSRzZpNWFTN09sZFhLVnpmRWw3WEFENHZvdmZKRm9HQ3l1VGpyN3FW?=
 =?utf-8?B?RWZ5bHU1VW5yZHQwQTZjTGRxMFlzR05wOCtzTFpVVndjTVQyU3FMbkx4RVVh?=
 =?utf-8?B?TEtrM2QwNzZJVHN6RklUbG85cVhTY1YrZVhFZFJCamI0YkxTc1R3RklZUFNU?=
 =?utf-8?B?VE9NUDFEVGNFVnU1aVlscFZBVWpxY3ZWQVdEZ1ZWV3VsZGxVR012bHRNZzg2?=
 =?utf-8?B?TWpFcVg1VjlYRkdGbExHaE5TYWROcGtoWkRiMEhPZW91YXdVdElwVDY3cEpn?=
 =?utf-8?Q?UMVwty1xL7IzIdPHvbl0dhkIYZaUsPyM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:58:05.7656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd12e5c-4eec-4c4b-735b-08dd1b9fb21c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610


On 12/13/24 09:49, Jeffrey Hugo wrote:
> On 12/13/2024 10:41 AM, Lizhi Hou wrote:
>>
>> On 12/13/24 09:07, Jeffrey Hugo wrote:
>>> On 12/13/2024 2:02 AM, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> The old SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS macros cause 
>>>> a build
>>>> warning when CONFIG_PM is disabled:
>>>>
>>>> drivers/accel/amdxdna/amdxdna_pci_drv.c:343:12: error: 
>>>> 'amdxdna_pmops_resume' defined but not used [-Werror=unused-function]
>>>>    343 | static int amdxdna_pmops_resume(struct device *dev)
>>>>        |            ^~~~~~~~~~~~~~~~~~~~
>>>> drivers/accel/amdxdna/amdxdna_pci_drv.c:328:12: error: 
>>>> 'amdxdna_pmops_suspend' defined but not used [-Werror=unused-function]
>>>>    328 | static int amdxdna_pmops_suspend(struct device *dev)
>>>>        |            ^~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Change these to the modern replacements.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Looks sane to me.
>>>
>>> Lizhi, can you verify that this works as expected for you? I'd hate 
>>> to accidentally break something.
>>
>> Verified suspend/resume. It works fine.
>
> Excellent.  Would you like to give a reviewed-by and/or a tested-by?

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

Tested-by: Lizhi Hou <lizhi.hou@amd.com>

>
> -Jeff
>

