Return-Path: <linux-kernel+bounces-445216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF19F12F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D5188D936
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215C1E8826;
	Fri, 13 Dec 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jL/u2r12"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929B1422D4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108638; cv=fail; b=Ehw55c3DLMe5PsclRDgg9qg1jVKx2asGLBiqUEuHMYB2s1FjresP2qCmW4f8cBQlgQsJcB4OSijNs/A36IgePyy5yb2c2Ye8RxNhsLV9lenadPDtGPxWekzzJgHF3DxW9avSaXobKzNMksSPcp3T7E6zPHUP5UDZPP9x/cre0hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108638; c=relaxed/simple;
	bh=WsBj8I9t9izdZu8PB+QzZf1RkfSdpHao9iq51F2tDhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ovbwDCdze+nTfsFChlN9gcpXR+suvOExtcgUYd1mGhs1KS7+V9CHcsk/8eg9wUlts0OEhHTYsYvtGhOADtLZ3qsrJVAT7xJy6lNkGQPrlAforjZPEcYTMB84rZBW0A9VhlY72b3n08Vg3QpGNFhJGh1tGyfBbniUrR+a86MGpR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jL/u2r12; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lfs3TJcvbSBewBSD3LgY9pLGeJilSuHGNccK0JEeOuCHPO3iEkHREMUYw10jnhapxazv13qosLH6M81TnddBconAS3Yyo//Sf7sQ+NiTwwnTwFkXUfAavKWM163GzGeYwIRn3tRJV8eT9uQkh7ZN2j4EElS1HjKBMDMxq6Z1rjeKV3lGGnjgvs8CIN+V2K9rq+ehX0t0FYQ5UQVvsf+273alkfgQYutIIRMiN5+mL4utQ3uvQt0VfZKy7UR+a3tohTxkDI/0tBsOWmxTSfblR6qSbD7iNQoFR0EdTUd44LARm/9qwcLb8osiPHeHckYmqGKdjd7swoQACOCaCNxakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj8S2X1Vs3dzs1P+hpE5aytSBWoIbgNLcP/DnaKXgvU=;
 b=NHu5vNTsajfk94FDd0TK5U3gdI4Bm//IxJDfup6AeI5/FbBXUKLGN6jy5Bn9riVEf9RlDTiAnfGfvS+25Dux/Ua6qeWHM3RUQqp6L7fQpRdgMBqogugu0NLAPzAZ8GQTUuPd0fCHSgYyAxwXsHWjipeV3ta0fWjZLeqf+Z4U8PB/hm0LfC1bcGhOX/1RnZGHErHH6bmf2Bvr4Btu5vwRf+G+l1nfs1LZVtlUsQ7+ySHr9QeREB15AgL9U0X1uV/FhbBMRapQSwC81CRDCsXp5IchkwHOVy7oSUqGK1SX8MbHqSzurDAzF1o/r0mLME67LUdJ2T0RB8gGUgYRmDWn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj8S2X1Vs3dzs1P+hpE5aytSBWoIbgNLcP/DnaKXgvU=;
 b=jL/u2r12C41QC3o+4FpVzWZeuxGdy9sRuBXUrKsVdcMjCi0PyRLp002FkxTWjNsjs4v0+I09eCGz0s4H2MiwbItBdhBSYC9uBlPbJLbHf7/lRfFZobEANkCDMmBMrbFmNhSNLcokPrrdOmK/rMBGTSyHU2CuUYn1OvV7XNl453s=
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 16:50:33 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::bd) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 16:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 16:50:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 10:50:33 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 10:50:32 -0600
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 10:50:32 -0600
Message-ID: <d1697598-4480-c7a8-84a6-f169f274dcb9@amd.com>
Date: Fri, 13 Dec 2024 08:50:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 4/8] accel/amdxdna: Replace idr api with xarray
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, <ogabbay@kernel.org>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
	<sonal.santan@amd.com>, <king.tam@amd.com>, <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-5-lizhi.hou@amd.com>
 <58c6106f-7d44-fb89-bca7-09e28dd51d6a@quicinc.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <58c6106f-7d44-fb89-bca7-09e28dd51d6a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8dcb41-530c-4a88-3951-08dd1b9642cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmJQbW9adXk5amxRMGZlQlZCbll0aUtiTzNZeE9CVmxwcVd6b01RaUhqM0Jk?=
 =?utf-8?B?M0Y2M2kzQUVRb1A5d1J4Ym5EdDlpajUwOHNWVHczVzlJaTdTbTJNTTBuZ1R6?=
 =?utf-8?B?WHVDS3lRMUtQYUZCRGg0T2MvUGQ3ZTl2MU92U2tuTXFBNzhEeExYK1ZoTnBQ?=
 =?utf-8?B?eUJDeC9IN0dPeFFZRzJBYVo0KzBJWTRnRHFwa2tRcEd6OWJEa2hMRWlhKzZT?=
 =?utf-8?B?L0l1elZKR2haQ1FNWXRUenhXQ1NnWWlFMk4rZThtNGhmcXFkWW1jM1FPOTlh?=
 =?utf-8?B?S2E5bU1oa1E1ZHo3TGVNSjJBU3A5Yks3ZW0wWkZLSjlSL3ZJcWZiaU95bURk?=
 =?utf-8?B?OU5rK2VLYUo4cWUzVHE5OTQybThyTFc0anVNeVNveVpFSXRjY0Nlc2tnWlp0?=
 =?utf-8?B?WERMSVlVVkNkUWtMekh2clNBZHpLNXI4bGdYczREdTd3U0c1d1ZqbjJDTU1z?=
 =?utf-8?B?REdwL1pjSWtjL0RGTGNjK3dqejFtK0V0dmp4b01Cc0JodVdQUEFYK3dhd0R2?=
 =?utf-8?B?U3pyWWsrTzZQWmN1REk0eTBCdHlRK2lNM2Z0ODRQU1FQcUVPTDhJQ0wzbTFK?=
 =?utf-8?B?MXpsdjJwRzlJSzhhdVE4S1FNNnQzYnZ3YlYvZ2w3ZzkwUGI3RTlGK2NHMHRE?=
 =?utf-8?B?c1ZtOXNwQ2hNaFE5cXhUV0RpYzF0TFNNdndUVXVFbzdYNm1ySmphcklHeHhV?=
 =?utf-8?B?dWhEV1hTeWVRUmZYNGI3REtNSUtmK1FiZlplSmxaZFBGNEVuNmNtazREVC9H?=
 =?utf-8?B?cmlnTExkeW41TUdpTGJhZEFoaXMyQmcwa2NhenFLNWpFeU1Tekw4ZUFJN3FT?=
 =?utf-8?B?ejZWNnVWRGx3ZDZLZUZzbDJ6NmFnZVFzSFhKTW1YaFErOENKVHJkeWNkcnlJ?=
 =?utf-8?B?ZERMRTU0aG5ONEdoRTRnRVAwaE9GUkxaT3RRaDlhdjB2SGlhNXNEdXNibzVz?=
 =?utf-8?B?cVBOaDcwbVdxTit5alNyc2pYcU42V0EyUURpRTgxREdkZTVHRjFwTDlFUmc0?=
 =?utf-8?B?UHFOS2lwRGxjalViOWlNdGVQNWxudEtsVTdCTFQ3SzZMU0tYRW9ObG5VamdM?=
 =?utf-8?B?bVREOUJzQzh4U2dwM2FZa3pZMXNsTUNFc3lLbVY4UDI3WkxFUWU4TUQrTEpu?=
 =?utf-8?B?eElMcUhqQjl3eWJnbEU5QmhNUDJYZXM5NmhCSjFDd3FQWHJoRmR4dG1obTBs?=
 =?utf-8?B?ZnY1YkV5YUY0eWhUT2pqUnZiS0kwYXZSNmhIamxkRjBsdVE5U0pEY1liNGxp?=
 =?utf-8?B?WUV0T3J5SEhOOStCSEZUWVZWYjY0bmpwazdSYnh3NGRlMDlaMHJ3UmNGNHl2?=
 =?utf-8?B?ODB4VUZ3VUFXWHlSRnJtY25SZDlINnQ5bE1FWnJLMWxvTEtSRU43NTRoNjVV?=
 =?utf-8?B?VEIvY09IemxCcjZ6MUJsek9mT2RvYjg1UXIwbVRsMUg1dGYyNGhOUGp5aXFJ?=
 =?utf-8?B?TkxXM3VOSzZLaWI5MlZLY0txR3VTdTJDdU5zYjVrYlJMcWcwdENHTzVLQVpB?=
 =?utf-8?B?dm0zQjVTdVB2bXJHRHhsMTNOald0VzZrTkV5VDlTWkVrUG9XMFdZTGJVdTZG?=
 =?utf-8?B?eElLSUliZmtrOS9QWHZKNlRPNU4wOU5oYkZERTNzZ2pidXA3cWVkS3hwbmx5?=
 =?utf-8?B?ZHpqaWlFaS9wcTIxS2JFMWlJYXdCTS9KVUE2RzE2L2VRVVgvbW9KSXpZcXp0?=
 =?utf-8?B?aDhCZXk3bU5RUERCanczdEFYeVZRbnAySzhYbUtNOUFqbWZKYWhKcTlRUmJY?=
 =?utf-8?B?Ri9sZnZ2OUtLRkhxOWY1REtOYlVKOTVMUk0rTkRGQTA4eWNTSVMrZGdRUTBS?=
 =?utf-8?B?UGZGbkZrL2U3SEtUNVp1S3JUM1EzSGRNanVVbFdRODdQaFlyQWJTT0tXOVpX?=
 =?utf-8?B?cTVyQ0ptNWorR1MvelBmRXZSZHpXUE9mWEhaNnpDK3FRNE1kWThLdHNtYm9O?=
 =?utf-8?Q?f7xUKjuWePoNJjy9EfIlufAPn6MWuRAI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:50:33.5618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8dcb41-530c-4a88-3951-08dd1b9642cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450


On 12/13/24 08:42, Jeffrey Hugo wrote:
> On 12/6/2024 2:59 PM, Lizhi Hou wrote:
>> Switch mailbox message id and hardware context id management over from
>> the idr api to the xarray api.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>
> Implementation looks sane, however you appear to be missing several 
> instances of #include <linux/xarray.h>

Sure. I will add them.


Thanks,

Lizhi

>
> -Jeff

