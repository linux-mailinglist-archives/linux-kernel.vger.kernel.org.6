Return-Path: <linux-kernel+bounces-295636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D161959F63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCF2B23351
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C4D1B1D52;
	Wed, 21 Aug 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="okLtrEcb"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE818C348;
	Wed, 21 Aug 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249497; cv=fail; b=OYXERIcyo56B8e4E0tVvDPsXAv/3H8lZM56+LbiiTbMaD7dNgJ56BQX4ItGu5ik2ercQtq8dtYvov3mZ+Gn6QDTp3dql4DymTbixDw+FBih/Z4JoKrmBm8DB2JZeZUXE+ojOOyij0rYWjYm7iZNsTN3eN6uAD0V2zaJJ5IwdKbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249497; c=relaxed/simple;
	bh=8dzso4ZgMqY2l83r3IwvNM78QW/7mNIYc/hzWNpjHY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lxZVe0ACWCT4nwuKuuMy7yJqhtYr+7fUEjMJXsC3zQeubZZMg+Rtnm/wkSI1DG/fLrAe7wN/Ctq3W5KoxFRKpg//wAS20CTKOhK6XyrhY0meEtKFJOdvY/SWfagNN6Xf5zJfSxMNb11wGzlV3Swphrcv7zJQrlUoWjvqUzPw1I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=okLtrEcb; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axTCGMLvIHTceMS0Vh3x/0cLB8aALtFKV6ejITzdh222zQyyFPBqpN19jsTWJ3sJFmVf/0C7/kRrYvbD1v252xYchKlarAdC/1ITbZyJkbEKLuN25wEIpmKe+Ex54GsEWfTAaeG5BdLltDd2YPR2fuu6XEivaEF8l4eiTrsGu5CCIlrrtsShEjtl3TsGh/RlkjfG4vkArphogiKG8lOYcPHxJUAfvcosO/HED+lIwyhPp4sIjlFLYzzLfjKw+mC39xhpBGS6bvpWnLJhvhGrF3HymxNv4GCtqLhNIzP6A9JELM0axOu5vzXUX4zemr9O1fPkDW9aNupG5I8EwaerAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WM7nbe+V2js42896Zk6ql/LrmWma/VZWy1lZUr5baUU=;
 b=lrnl3Wx62ZZ1ySHH5SqUxwojS7ug2PFmR5Tm+CZsTpYkf9PLmOvvqwwsl4H33qF69eRkNE8bAvOGZF/jEfSxb91XUpMm5QnZCeyZtQe6NUGPkzT+7J5/7UrWMWrCzHYxT2+l6NGF4MB/gjhZyKAy6VPiMq1eNg4eh8hFR7K6wCnWldZ27sEz+sk6f6imvXyh43lQ/970iGftfFSdhdchYyxTVgH26kHC8CY2AcJwXDuysDUtM2Z0IeZbLAbEvWyuirjvINHkAOZalj2QP1WjxrH/kPUdqViT3PqMQXqZ40yPY2w5nUtLdP5TQ7bs02ltlqYWHe48gYJg44fDrDBDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM7nbe+V2js42896Zk6ql/LrmWma/VZWy1lZUr5baUU=;
 b=okLtrEcbKgNr/xQ8bsGQs0CZUgpBrVV8LM8uSZp2jKNg+aYzgJqVcMFnVwxrHWPygDHzqqH8W79WQ0KmkSr2Ns4Y8kbVcHHutKnW0ixTDytrUJVRLk8PRh0vZHDA/7rr43F27zXjxNIoFj4shNnSCDBftk1hjB2sj45aADx83HI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Wed, 21 Aug
 2024 14:11:32 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%2]) with mapi id 15.20.7875.018; Wed, 21 Aug 2024
 14:11:32 +0000
Message-ID: <5fcb5448-b05a-5947-01d4-948f3d9e825c@amd.com>
Date: Wed, 21 Aug 2024 19:41:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 5/8] misc: amd-sbi: Add support for CPUID protocol
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 naveenkrishna.chatradhi@amd.com
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
 <20240814095954.2359863-6-akshay.gupta@amd.com>
 <60a9e4a7-6a72-4aec-88f3-e705f0ae156a@app.fastmail.com>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <60a9e4a7-6a72-4aec-88f3-e705f0ae156a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0cff70-c376-4c47-85fc-08dcc1eb28a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjUwSFRuMERPZCs1NUxqenFJeTB1dWhyR2R5c056NFBVazRmLzJKbE4wdkdv?=
 =?utf-8?B?SGJGUzZmZTZNSmZpQlBjeXZ5dkVITW9OZ1loWENvR3RtREtQVUVkZVhQUGFP?=
 =?utf-8?B?dUZZaGpSMW5pRDl3N1A4eGN6MTVXSE1GUEpOdC9tQ08rd1RkcDdaam9Ja0dn?=
 =?utf-8?B?MVVuNFZWQ2xINzRCTlZNL1FmSGdhaFRpY3dDSXNOYWFHdVJOdUVDOElEeWdz?=
 =?utf-8?B?eGZmMTRkM0d0Y01hTFRkUGFhMmtIZ0l1WEo4QmRRd0RmUlQvWVluT3cwWEly?=
 =?utf-8?B?c2RpVW00OEpyY3MvYk10MmxyNnFIVDlwNU9QZDVuSHByYVkrSzhvSGxZNXEz?=
 =?utf-8?B?VXNINGtJRXAwNjFyWktDTURqMWlJZ2c0SjV5MXd3bVNsZkpLS1I0UzA1alJu?=
 =?utf-8?B?SklhVFZRU09JbCsvVmgvNmRYbXhabFQ1V1Y1bkhVNVdMeFdnMDd5L05leEM3?=
 =?utf-8?B?YkxGUTVRc2VPdmhybmpzYUkvc1lSdlp5Z084ZkQwVm10SjI2U1ptNkZiSVkx?=
 =?utf-8?B?RE80YUdJWWlMOEdNRDhCUDJCSTZZYWZ2TjBqNzB6NWk1TEZ0ZEIzcGM4T1pW?=
 =?utf-8?B?K2xWN2F4NXhNaG42UGlySTVmdkEwQkZkVWgwL2E0R3RpcXR1SzZhb3pKc3Jw?=
 =?utf-8?B?ZjcxMUVkQnlUdHV4M3plTnJLbkptcVpVMjE2aFo0SnpnR1RmTTIwUjZuOEFB?=
 =?utf-8?B?ZTZCNENRWWhLTFdYelpCT3p1eDVsU1kvRWsvQ2grL2FqNlMzTlUwMytWemY0?=
 =?utf-8?B?Ymh0dkdReXlZMm9IeE9DRnVSWTVPSWJPZ1JCb2lYL1pEY2VmRUw0bEhrNWFy?=
 =?utf-8?B?eTBad3JZWXo1eXVZdU1ySGZpRC9tVTNKV0tHa3YweGFaUXhMckdQemk1T3RF?=
 =?utf-8?B?Y1F1dVllTldVaGZmWHNTUWZORk5mL2pKcXp2ZGtESGt6RlVuZjdVaWFpMHZi?=
 =?utf-8?B?ZjFLZFJQNmNrNUtUZEtGM0kxWWhaR3ViMkZnMVdmcFhIVmxreWZCVk5wV29o?=
 =?utf-8?B?YXpXMWNCT3BHUzJXWmFyQlg2UTl2V2RiQi8zdzYzOTVZWk1IRklqTmJSV05P?=
 =?utf-8?B?R2lSemVKYitReXlMNmFYYUpTM3dvYURKUFNDKzBxcVVmQlJVaGE2b09pdUg3?=
 =?utf-8?B?YzByRU9oNWRXQTVoOUNWVEd2UWhCWTNHSk43U1Zla2Q5Ty9IbWlBbkVleWpE?=
 =?utf-8?B?by9JRVZPMkVUTit6S1Y2QzRKWCtqNzJOS0FGd3FxekhyeHdoeGQ0eStoMzFm?=
 =?utf-8?B?ZVF0a3Y1Z2tRYTBXOUFoMDBxazluczZGMmx2dUVNNnFPQkgzTEtMMDdzdllv?=
 =?utf-8?B?YW44THl0b1BvdGhWeXF4RTVlU2ljbFRLYXlKUG1meDBkU0lVQmpzUmQ5bndI?=
 =?utf-8?B?a3FlZHZoMUdpZStBNThwdVUwL2JpNkFLT3NIWU1HSnhJMkJtVnM3MmpxeEJF?=
 =?utf-8?B?UWM1M2pyYjZMOVlYa2tQdXdFUEo4OERIOG5vOVRGNmtsRmZFSkZjL1RQUWtr?=
 =?utf-8?B?SFMyb1REWkhWTFF6bjhhb041M0FmcTkxUWJzbTlSTDlyVDR6Z2c2NkxZUDNE?=
 =?utf-8?B?eXVwWll3ZUdWcWExZ3Z6SVdjZkNVY3NxVVc0U2NodFZkN1pZQlVXNmlsRVhL?=
 =?utf-8?B?RGRObk1aSUp1N1BlQWU0M2l2akt2WFV2dEg4b3kzUTNYS25Zd2Y4Vk5BRzNk?=
 =?utf-8?B?Mm16aEVvNStOcldxeER5bURJMm1Mb0E4SUFtdTROVmprYTZUbFlsaElvSlFY?=
 =?utf-8?Q?PRu3cvgw5Fptqcreak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFpGbXJWQmNFNlZXN2FDZkdJMER3ancwd01nbGdGL3BVTmVYalQwaGVPL0Ft?=
 =?utf-8?B?czAzMFJzd1VvRGRJWHlSdUUzSlVZSmU3aGY2U3JzQldBV2kwQkh5dGs5UEM2?=
 =?utf-8?B?M1NnUG1tV1dMVlo0SjRGYTErREhLcjhZS2YxVmQrNnNXTWlpQUpkYmVCMUdP?=
 =?utf-8?B?eHFJc3hyNW8wU1U5aW9OaTQ5cDJWWTJuckxoT093T0pINkpVRGNIbTlJM0lH?=
 =?utf-8?B?TDgwb1BiQ0ZnQXlTL3pYMEV0K05IMU1yL2FFcjB4YjBGbUtJbnB6S3Z2K20z?=
 =?utf-8?B?TStzTlV4ek1oQks5cnEzbkxoMHd4bzQrd0N1Y0puYUs5aFk2QzRKd3A2MVZ1?=
 =?utf-8?B?MTI4bk1teWlrSzlSdnd0WEcxN3FVUDhwU0JJK1lJT0t1NVVwbm9aOVBmdXNF?=
 =?utf-8?B?WG9ZTXQ5MUV5RUpTYzM1OHRyT3JiY3QxN01GeW5ITDVtY2pLdGZ0L1k3RHF6?=
 =?utf-8?B?VmtMU3ZYOXA1eVkzY21XS3B0dDR5dGdqT2gzRVdpeHZCSzNqSUt6MHQyTEY3?=
 =?utf-8?B?ZDNuMzFqL1VhK2huRWVQNkNWcU1kNjNLZGFDOTN5bGxoamV3L2FSajBmRjhK?=
 =?utf-8?B?T3BIaEJQaHIrL0dqdlBLZ1JEMm5QTTRYd1N0NjBIUllORGJqK1p5L1ZGdmVZ?=
 =?utf-8?B?cDR5UEs0dVlGbE9oY1ZNVHVOdTVJYTJlZnpRRzhiQTRtdUFDY0MybzlWUHFj?=
 =?utf-8?B?R3dhQ0s1UVhKWW9OLzVSazhLZGV0bjh2SlIrczNReDE4UnJYeWNrMEt1dG9x?=
 =?utf-8?B?T1FkYWVTRzVBMmVZdDB0Tm8xdG1lTzJCNWdGaWlrMzVYTFZMV0I2UEZZblBh?=
 =?utf-8?B?RmY3ZEZ4NlMyc3A5aFcvN2dEZHdRTzV1cEtpRHc5QVNBMXV0YW5RYlUyZnpK?=
 =?utf-8?B?Z3ptTk1NTWd6Zm43MkVHcUtzai9HanQ5K1hFbnZ4TEpmWVE0QmxQcTlmTk5y?=
 =?utf-8?B?RnBOSitCcDkrL0YvdElpcCs4TnRDQzRyMXFlSDU2MHBoaG8ySVBsTHFUVHpl?=
 =?utf-8?B?Y21GbWFsOEJOZVQ1cFBVclBZSnZHcjE0NkdTQllvZXROS3A3TE11MG5FTThW?=
 =?utf-8?B?V2ZsZzc1L3d6Rkx0eDdacHkwb2t3TEk5eEdpU1JQbWs2dUVnUGZyYURQREtI?=
 =?utf-8?B?cm5PcU8yclNVWm5kRGdnbGhUbHlhN3BMeU9yMmtaTFA0WjdEMWc3WEZBNHY4?=
 =?utf-8?B?VndNaGZ2U01TNHhodHZjRWJyY0pZT3cwcVdwOFlYYVdpMUgwN2c2T0xJc010?=
 =?utf-8?B?dWlGTjlvWHBMSlN1U2x4TElqODVuQXFRK2hCMUpuNDlMZVZWbzR3bUNObHdG?=
 =?utf-8?B?ZWhOcEVLbkNLNzF5VVJub21aLzJDVVFSMzNEYms1RHQwUEJmbkdUNVFBNkgr?=
 =?utf-8?B?bDV5VHI5WEFxMzlaczNvTHdKaTBVUEtQY2JWT0xYMGJHaWFqVFFiR0xLdmNO?=
 =?utf-8?B?Mk9QZzlJdkFVNzREZlMyRHNpdWtyMmpHTzRHUFptSURJSW1HWUlRLzg5cGRW?=
 =?utf-8?B?eTJRMVBVNnkzZUR5c3FrK09DSndISnY1WlJlOGlPNEhFMEthaXY5MW9VVU5B?=
 =?utf-8?B?cVdhb0ViRDErNHZPMlU3RTd4MDMyOGtnYXAzUTBhcjYvUit2WmdvMFRVUmVN?=
 =?utf-8?B?SFA2L2hPdTIyT21PVHZ0NXI3RFQvN1BoOWlYR0EwVnFuTWxoOER1VktvTXFq?=
 =?utf-8?B?QjBzWU56TlZwS2JxUW9XMmVBV2FSM1FqaE9FdWtlNXQ2T091bVhhRFJNRlJG?=
 =?utf-8?B?S3pSclU2Mm5OYzF6SFpWbklySFIyZ2tGVjV4QzhWMzVNMS9oUTdYZ2Yzdmla?=
 =?utf-8?B?clFrMmZrQjM2S3MxUTNpVE8vR2tYN2U4VHhSOGdIS2dEalR5UDVsK3hXQ00r?=
 =?utf-8?B?eW8rS1NKOFRQekxxejVlVnQraFpBWmhVSXNmOTdhYTdVWnR0R3NFWHFlVFNh?=
 =?utf-8?B?WGxDUE5CaDkzazBoT29wQjZPLzQ2eGR3TTdTWFFjZ3pCZjhKSXBvMGNTMVdo?=
 =?utf-8?B?Zi9yWjFDN0dwQ2dVSFpFUm5Ta2xRNGF6S050UlZkS2NUbGFlM0RobUljN0Ju?=
 =?utf-8?B?bTdSUmJVbkhzT3JrRE56b3hpRGZoK3NYZGx4S04zaE95VndBa3BtbXdFZzVv?=
 =?utf-8?Q?33ctRVQTBGSqIxmAFBQIfp8S3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0cff70-c376-4c47-85fc-08dcc1eb28a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:11:32.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/X5YWTy00Q7QvLTvzQ6aF3fOMlQwYPTpvCmPPpxlxHZ/dB1SO5nZD8fgUT8PAipvXJyGKeuJuex6iyTnlAm2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367


On 8/19/2024 3:57 PM, Arnd Bergmann wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Wed, Aug 14, 2024, at 11:59, Akshay Gupta wrote:
>
>> +/* input for bulk write to CPUID protocol */
>> +struct cpu_msr_indata {
>> +     u8 wr_len;      /* const value */
>> +     u8 rd_len;      /* const value */
>> +     u8 proto_cmd;   /* const value */
>> +     u8 thread;      /* thread number */
>> +     union {
>> +             u8 reg_offset[4];       /* input value */
>> +             u32 value;
>> +     };
>> +     u8 ext; /* extended function */
>> +} __packed;
> You cannot have a fully aligned union inside of a misaligned
> struct. Since the only member is the inner 'u32 value',
> I think it would make more sense to make that one
> __packed instead of the structure.
Thank you for suggestion, will update this.
>> +/* output for bulk read from CPUID protocol */
>> +struct cpu_msr_outdata {
>> +     u8 num_bytes;   /* number of bytes return */
>> +     u8 status;      /* Protocol status code */
>> +     union {
>> +             u64 value;
>> +             u8 reg_data[8];
>> +     };
>> +} __packed;
> Same here.
Thank you for suggestion, will update this.
>
>> +#define prepare_cpuid_input_message(input, thread_id, func, ext_func)        \
>> +     input.rd_len = CPUID_RD_DATA_LEN,                               \
>> +     input.wr_len = CPUID_WR_DATA_LEN,                               \
>> +     input.proto_cmd = RD_CPUID_CMD,                                 \
>> +     input.thread = thread_id << 1,                                  \
>> +     input.value =  func,                                            \
>> +     input.ext =  ext_func
> This can be an inline function.
Will change to inline function.
>
>> +/*
>> + * For Mailbox command software alert status bit is set by firmware
>> + * to indicate command completion
>> + * For RMI Rev 0x20, new h/w status bit is introduced. which is used
>> + * by firmware to indicate completion of commands (0x71, 0x72, 0x73).
>> + * wait for the status bit to be set by the firmware before
>> + * reading the data out.
>> + */
>> +static int sbrmi_wait_status(struct sbrmi_data *data,
>> +                          int *status, int mask)
>> +{
>> +     int ret, retry = 100;
>> +
>> +     do {
>> +             ret = regmap_read(data->regmap, SBRMI_STATUS, status);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             if (*status & mask)
>> +                     break;
>> +
>> +             /* Wait 1~2 second for firmware to return data out */
>> +             if (retry > 95)
>> +                     usleep_range(50, 100);
>> +             else
>> +                     usleep_range(10000, 20000);
>> +     } while (retry--);
> This loop is likely to take much longer than 2 seconds if it
> times out because of all the rounding etc.
>
> You can probably change this to regmap_read_poll_timeout(),
> which handles timeouts correctly.
Thank you for suggestion, will use the regmap_read_poll_timeout()
>
>> +/* command ID to identify CPUID protocol */
>> +#define APML_CPUID   0x1000
>>   /* These are byte indexes into data_in and data_out arrays */
>>   #define AMD_SBI_RD_WR_DATA_INDEX     0
>>   #define AMD_SBI_REG_OFF_INDEX                0
>>   #define AMD_SBI_REG_VAL_INDEX                4
>>   #define AMD_SBI_RD_FLAG_INDEX                7
>> +#define AMD_SBI_THREAD_LOW_INDEX     4
>> +#define AMD_SBI_THREAD_HI_INDEX              5
>> +#define AMD_SBI_EXT_FUNC_INDEX               6
>>
>>   #define AMD_SBI_MB_DATA_SIZE         4
>>
>>   struct apml_message {
>>        /* message ids:
>>         * Mailbox Messages:    0x0 ... 0x999
>> +      * APML_CPUID:          0x1000
>>         */
>>        __u32 cmd;
>>
>>        /*
>>         * 8 bit data for reg read,
>>         * 32 bit data in case of mailbox,
>> +      * up to 64 bit in case of cpuid
>>         */
>>        union {
>> +             __u64 cpu_msr_out;
>>                __u32 mb_out[2];
>>                __u8 reg_out[8];
>>        } data_out;
>>
>>        /*
>>         * [0]...[3] mailbox 32bit input
>> +      *           cpuid,
>> +      * [4][5] cpuid: thread
>> +      * [6] cpuid: ext function & read eax/ebx or ecx/edx
>> +      *      [7:0] -> bits [7:4] -> ext function &
>> +      *      bit [0] read eax/ebx or ecx/edx
>>         * [7] read/write functionality
>>         */
>>        union {
>> +             __u64 cpu_msr_in;
>>                __u32 mb_in[2];
>>                __u8 reg_in[8];
>>        } data_in;
>>        /*
>> +      * Status code is returned in case of CPUID access
>>         * Error code is returned in case of soft mailbox
>>         */
>>        __u32 fw_ret_code;
> Low-level protocols like this are rarely a good idea to be
> exported to userspace. I can't see what the exact data is
> that you can get in and out, but you probably want higher-level
> interfaces for the individual things the platform interface
> can do, either hooking up to existing kernel subsystems or
> as separate user space interfaces.
>
>       Arnd

we have opensource C library and user space tool.
All the platform level support is handled by the library. IOCTL is the 
single entry point to the Linux kernel which
communicates with the SMU, using the protocols and handles the 
synchronization.
Library is hosted at: https://github.com/amd/esmi_oob_library


