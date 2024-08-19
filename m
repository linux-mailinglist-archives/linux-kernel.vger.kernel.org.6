Return-Path: <linux-kernel+bounces-291855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4687956810
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C768283B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A11165F00;
	Mon, 19 Aug 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fo9geXix"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE4160883;
	Mon, 19 Aug 2024 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062564; cv=fail; b=OuDfhxhsPKronxF6Ae0/ZHM2kxgzZC0pacuXQBdqpEi5EORdbtVnkTpjKnHJ4JqPi0HRSrNmPvEztswZX7Nod0pnjIafVPpijWlEI0B2F/Qa2C8zwai+soC0zN5waESP8yN/nsGEH+SETMhwGyNKvLzP7+UxhqG//EqFFEbm6Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062564; c=relaxed/simple;
	bh=iNnMammrumA8EjpIq0pPi2UuEIVw4d5FqM9qpXFQcd0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHOh/Ra+UPUAaXrY74p6l/UZGoFhU8FNUJnaAv42er/dmKMUqLgoUhlSgQ4u4ABM+mXaEgh5KFjRzgKHmBhZ1aPdjB79UfyjX7nB4PRD8ytAUWPFBMkwPJcsXh4jqv0J0TgeDHyblyNy/agjSp8rUHFzhbcMkoPLh2ASEXj4bcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fo9geXix; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtutwoD44LdPxFdz6MfTM4g4AzZ4iHHrTvZFiH37oBfQODSLB878j7AlSJN/AxpqzwivszZJ4Liz3qWaWPEm86AfyoRUfYV30Ty8AufoFXJqohsFx9UOOXYyjcwLMgtYy28Ix05y+Gl1k6oiuZdbiJm968AJGStq3JIUKqOs5dUyKTg/aYCmve7k8Yq2eHaw7gCTrZJRDTv3AQPvaSF0dw5NsGRPRv8KL2YRf2vsvtg66Hxy3G4FBW9lz2wA/MMlgXQhsnVX8/0jVuv4nEbAOgBi+DEoICYA+X6dXuXGPh3+GNMurtME7BrKpR+b52NQI+wSXKHOCzrMtYGt0PbtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK4le3HKneg8n8biAOwz4dyUTyEf7yIeEkNZj3BjCss=;
 b=y3PjC0WtVFeP/paQG5Qm/xihnq7NUAQXmuAxlqzBarK6OToMvCcEkhteiJgjzGichElmLGPJ2NLhtKbDY7cVcc75Q8fC7ZbccoL9QfB/jlVcu6w+HWo4nzG47Ouqry4qdb41A7c2gJMs8VgsX2YvxX3Z4RJ2lEyXl21KdqRphc7mEqUT1dHYhFylHP8Zc79JC0TC3sriHrMTdV6xBryCZOGx26+zCyjmqsirIjkrLD5MSeEuSLgIGdCoD33Fv4Hnjc37PQOTHWfJTPBbv3O+LVvdbD044EtUBeWh2iulwbroWBUVOmHuB1JBKOC/zsqGCGyT0sDBXoiN6c9H5ugP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK4le3HKneg8n8biAOwz4dyUTyEf7yIeEkNZj3BjCss=;
 b=fo9geXixl0NlP6u+O2qO+iUmID+2IBZDGZBYoqZns5oFKEKmP/k5yVf3y18YcTGCPuPy0VYV7DfcprmW2slFoPmMRXCHw+WV3+enf31Dgag1H9Z/vfLNyxiraRemnlzoD6SawVJUDiNMRozQi8h2mdlJhFH7tdePovBTpSrPEzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:15:59 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%2]) with mapi id 15.20.7875.018; Mon, 19 Aug 2024
 10:15:59 +0000
Message-ID: <a7a6c2ff-a1d2-0bfc-d8ac-ae50254020ae@amd.com>
Date: Mon, 19 Aug 2024 15:45:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Subject: Re: [PATCH v3 8/8] misc: amd-sbi: Add document for AMD SB IOCTL
 description
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
 <20240814095954.2359863-9-akshay.gupta@amd.com>
 <2024081412-snowless-judgingly-ce90@gregkh>
Content-Language: en-US
In-Reply-To: <2024081412-snowless-judgingly-ce90@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::8) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: de1527f3-fced-4184-5ec4-08dcc037ebce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnNObk5UbG5xeVhTU1NFNlBsN0RVSk1WcnZPd2xmN2xTajBzeGFNWHk3Z0cr?=
 =?utf-8?B?T0twbEFpUVAzMTREUERad0dDaG9CMVBBdXRiS05HeCtGR3o0VlJRdU0zaVZr?=
 =?utf-8?B?MnE2N3kwOTZYdVJlTmdRZ2t6T21ac1JCekhqSlZxcG1HdVBUTzBKakptcE5I?=
 =?utf-8?B?aTdUU1ZCdkRxWmxvR01FV2g3dFdQUXlWZTVFdmkzTkVQdERDZjcvSnhkWjlW?=
 =?utf-8?B?MVhNVFpvNU9jK3NyN0JyZUFOZzUvekhKYUtBdUNVRzRsSzZmMkRWTW15emkw?=
 =?utf-8?B?TDBkcmJUOVlTQTE1TUlSTVgweWEwSmNFYUN0djJXK0k3M3BzVlhFSWFPUHp6?=
 =?utf-8?B?TEJQUGdESWQ5QndNNUFmR1JDODM3RDhibkRrRy9LY1E2NXB2VlM5aGxFcjli?=
 =?utf-8?B?Wit2V1QwclR6WklmcTIva1FQMHRJZFAwUWJSOExGOTBnTXgyNzhKK0svNEFi?=
 =?utf-8?B?U0V2L1RuWlZIR0ttTlk2ZHd0c3dZL2U5ZTZPZUoxZm95QlRMNXlkN2dQM0Vl?=
 =?utf-8?B?Rm1OZ0NqNVpvN1dzYUxDckMxc2Y2b0xXWFJwa21OcExMTGJaT0tuaStzYkhk?=
 =?utf-8?B?OWROcVArTVUwSHlpWmQyME5KNFBxMzJQNS9lWncxNmNGbU5MNjIvczI1TndO?=
 =?utf-8?B?M1BFYXNkWngyZ2VpWkhjRStHQmd2R1YxU2c4dldLVWIwSTJWZHpTSnMya1pG?=
 =?utf-8?B?dlVDSkI5ZEV5Wk1NOFdmL3ltUWJBYlZTYTNlMXg1RU5BRWFUQlBEa1FlQmNv?=
 =?utf-8?B?Y1I3U2dTS2JpdkNJQ0d3cVJSNXYwc0NsMCt6UmlDa25UbVJQM09IYU1ZU3FO?=
 =?utf-8?B?RHJ0OHJFa25nR3JLRjFDUDQvTlBUYlREREFPeTQyOFN6TDJYK0xpdmVBUWF5?=
 =?utf-8?B?MWM4WVBVcjhKYkFibkllRkQ2NlNWZEo5MjlsOVhpRlJEcWRjKzVDNDJFcDdp?=
 =?utf-8?B?UnNqWnI2ZTdVMzVaQm1EeTFNVFhEOC9yTWgvbCtFblNtU1hueWdCbmkzVHFM?=
 =?utf-8?B?TTZ1MXlHSTBzWi9lMnR4VGpTc3U2Y0ZLK3dHT0FjbytRNlRKUWdsR3FRUTYw?=
 =?utf-8?B?NnBCNmF0SzBvNFEwN3lvU2NrVmRmd05hdWdNdFFVbXJTcTNpanZtLzlUcmlK?=
 =?utf-8?B?WWxiSThFQW81a3hyV3JpNEdsWlVrUUdod2hZRTFOcjQzcDloU0RlWGxDaDdX?=
 =?utf-8?B?WnpkN2kyS2dxeU1UU043UTVOam1EVHpqSjRKRHBTbXZ2T3E0V09pTGJrUEZC?=
 =?utf-8?B?SlExR2VRamZybWxrUFhsWGU5THB4N2JKU2dTV2lzNG5pYVAxVEdISUw0TExS?=
 =?utf-8?B?Z2xwOEc1N0lJS2JBd3FRVDJvVy80NlNpTWcvYXp5NWFQL1p6NmVFcXEvc3Na?=
 =?utf-8?B?QlVMMkN3UTRqNW8xM05TQkFDV3ZqZm5CV0hUUGI4VjlkR1pTZEsxNitCbUY3?=
 =?utf-8?B?aVZnWkp1WllDUlQ0Smh6d1F1N0F4Y0J3clpUT3ZpcitCUnh6YTIzM3kxbjNV?=
 =?utf-8?B?dEF0UlBRWEFLYUh0aXZCalZ3aVl2ZEp2OWp4dUNaM0ZHbjR6cmk3WEMyWVZZ?=
 =?utf-8?B?ZGtpZnhtbjEwNHJuYjluN1FIWGRIbitjdWh4cWJSekZSajBFZUNMTnE2eU1o?=
 =?utf-8?B?TW43bEZLYTQxajNvK0pEaDFPODJQK08rcTRCVU4yM0xFZTFPWWV4V2tPb1Vx?=
 =?utf-8?B?RGM5Qm5ReE5GVG5ndERaYzFyRURYUVl2WTlpNEZTOXpscWxXYUNOZ3NrNita?=
 =?utf-8?Q?hPKdR6XRD0IM2aOUdDZscIgJ+b2/9uLEpAznu4h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djJZellxanJoWkFOSHN2Wm1JSWozb0M4SWkvNkpoVnZyYVFET01IYTI5WUk0?=
 =?utf-8?B?VHI1bTBBT1Z5RDUxZVFuK1poWWxQQ0R1bVZoUmlsSjN2OEpkYkF2TUYxN1I5?=
 =?utf-8?B?TTk2RkN3bW9wdU9EWVU2SGhtWTlteUpIckd0NjNLd2FuUWJ5NnFGNE1OSkpo?=
 =?utf-8?B?MWhyaXNobXgvTW9xNEZENVZhdU0rbXUzVXhZa2FiZW9ROWpkQjA3dnI2a0xp?=
 =?utf-8?B?ZGhNVnI0R0hLclhiTVRkek1BRjl3b0hVUWcxQzNnYWgyNSswL29NWmtjSHNx?=
 =?utf-8?B?UnlyMlhmbUE3MXdFc3V1OUt1eFhrdTgzSHF5T2hyaWJqbFByaXgxbTlsWDRa?=
 =?utf-8?B?b0VjclA5TDRYTWRHd1NHWjFqSkdRb3hYSWIyTjFsOTFFbDZaeS9pek4xME5H?=
 =?utf-8?B?NnRzMXM1NDY0aWRYM2Rqb3VvVUhWY1QrVmZObmQrbUI5THZSODhPY3FCemo5?=
 =?utf-8?B?b0M5OGFzb1VFS1ZBOG5IZXExVEpMMS9xSlh0YStyaEpYUjJYYjZmNmVZMkNv?=
 =?utf-8?B?ejVYblluWE4wckp5QVQyblQrODJkVHkwWHhJRStOcTVhK3ZNK2c2N1VlN010?=
 =?utf-8?B?YnJPMmYxenhjZE1CbXJBdFU3akFBTjk0MEhFeDRiRHlld2R2Y2tYTXZPMFZi?=
 =?utf-8?B?QUcwdDZFakVQMHJ3dHRoWnlsMjFQeWpVRHRWUFY5WlZOY0ltN1ZLZjJ1Tm5u?=
 =?utf-8?B?YjJ4Y0hBbkFBbGdKNnJHTW9ScHVyVnFyK1l3UVdHdXBCKzZkUy9jOGIwdCtj?=
 =?utf-8?B?MTVCc1YzZnI5ZnVxWFJvWTRzMVozTDFSOUVPdnlvY0tLUmhtTTB0cGgyR2N3?=
 =?utf-8?B?Z1EvdWRscy9CQWFUTXBsQjF5cFBxRzZ6YU5EMGY2ZzZZcVlmamNjMHhiOUFJ?=
 =?utf-8?B?UGhTOHBwd2pOVWkrNWhodTY5dzA4RS9DK3VLaFVOZStGTE9CUCtyVjdyck9L?=
 =?utf-8?B?TUpBbDdvY09SM1pzRThJbFZCMUdwMzl5dUVQSC9qL0hYK3A5SG5yOURDZXYz?=
 =?utf-8?B?cEVNWFUweTVwRDdyMGFHUDFDSm85ZVlKajdxNVdQOXlqNG1iSXRqdWcyTlow?=
 =?utf-8?B?NEY5SVRQekJqVVZ4R09VU1V6ZzhLS1MyaC9WYlJXbXJZcG14SzNGWmpES0k5?=
 =?utf-8?B?WXVDZlZ0WlBOZlUxZzZMSmlQQkF3eXhXVDZwenRYdTl2Vk16MnI0VjlyVjAy?=
 =?utf-8?B?Y1NpdFVPVWdNc1EyeGMvNnE2TFJhTFZYNVV1SGRRSEcxQXlsUC9oUGgxZ2Vx?=
 =?utf-8?B?VVA0dDhhWU9tUWVtc05QWi95WjE3MFdrSE9hNEdxRmFrTzI2WERUNjFMSVFI?=
 =?utf-8?B?T1Q4Y01UQUVrWGdqSGpLaThjWEFKU3ZlZm5jZXc1N01LcGI0QVFWdWlXUHZT?=
 =?utf-8?B?dXBXZENrMzhjTERLVXVPcFlxem9NTWlBazNtMzkrdWx2L2I2ZjB4WXY3VG5z?=
 =?utf-8?B?ZnVDMXBXZHZ0czF2U1BLZEJWSk9aTStTSHlKV3FJcDRaa2tRK29wd3c5Z1pH?=
 =?utf-8?B?Ri9nSGNNNnFlZE00bHlKS0VTZ0xvcHR2bTNiUlY0N2d2VmJxRXFzY2VwM3M4?=
 =?utf-8?B?ZExTaDltYVBab2hjS29PenlHcFBjeTIxUHFRQ2Iyb003SHp4MmljVXdwOXZV?=
 =?utf-8?B?U0Z4bGN0c1V4YmxaQjNwSmQwWjVaVGw4QkNCUFIySW95eG5DT3pYUVlCV1hZ?=
 =?utf-8?B?Rktaa0plKy9wWUhoMkl6ckZ3ZFBWOXVBN3h5bFBIb3Bscll6UWtBcGk5ZHZ6?=
 =?utf-8?B?Z0NVZ3cxSXBSWXRGT2dKeFJTNFV2eUNYd1paQ3VJL3hZUDBWY08zOHR0dmxz?=
 =?utf-8?B?Rlg0Y0hwUzVjTCt3YXpwdzJQZXNwV2YyK2RzR2dsVG9SU0lybTlQTDBFcHl0?=
 =?utf-8?B?UlBncUFhQ2N3MkhOUS9aZVd5cXg0OEZUYkpUNUFaaVI0V2tuTDgvblIyU0kv?=
 =?utf-8?B?SDgxNWhkNzZlRC8rUm5pLzZvYU91UDQyWUFva1VsRHliQXQxOUwvR1VDc09p?=
 =?utf-8?B?QUpqb09haHdSb3ZKR2ZsUnFwQ3FWQkltS1k5S1gwVzVaR1ordW5TUnJOQ09R?=
 =?utf-8?B?dmlVaXRvYzd2SDQ1VWNWMnNuNzhCa2YxSFZrOHZ3TFc1bUNUM1QxQW41UE1o?=
 =?utf-8?Q?8XggFFbaSzFlaIRvFhSYsDXd+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1527f3-fced-4184-5ec4-08dcc037ebce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:15:59.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVu1F4Oq8EaASo1ejcl2Ifx6DcOjHQ/xXBvpDkpifOOXok/vRswzjPh0SxY9qvR90o7QARJtkH7WiOSDpJALzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895


On 8/14/2024 4:03 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Wed, Aug 14, 2024 at 09:59:53AM +0000, Akshay Gupta wrote:
>> +The following IOCTL is defined:
>> +
>> +``#define SB_BASE_IOCTL_NR      0xF9``
>> +``#define SBRMI_IOCTL_CMD          _IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)``
> You only have 1 ioctl, so why are you saying that you are reserving
> 0-1F?
>
Currently we have only 1 IOCTL, but will add IOCTL for SBTSI.

I have reserved considering the future use cases.

However, we may not need up to 1F will restrict it to 0-Fh

>> +Data structure::
>> +     struct apml_message {
>> +             /* message ids:
>> +              * Mailbox Messages:    0x0 ... 0x999
>> +              * APML_CPUID:          0x1000
>> +              * APML_MCA_MSR:        0x1001
>> +              * APML_REG:            0x1002
>> +              */
>> +             __u32 cmd;
>> +             /*
>> +              * 8 bit data for reg read,
>> +              * 32 bit data in case of mailbox,
>> +              * up to 64 bit in case of cpuid and mca msr
>> +              */
>> +             union {
>> +                     __u64 cpu_msr_out;
>> +                     __u32 mb_out[2];
>> +                     __u8 reg_out[8];
>> +             } data_out;
>> +             /*
>> +              * [0]...[3] mailbox 32bit input
>> +              *           cpuid & mca msr,
>> +              *           rmi rd/wr: reg_offset
>> +              * [4][5] cpuid & mca msr: thread
>> +              * [4] rmi reg wr: value
>> +              * [6] cpuid: ext function & read eax/ebx or ecx/edx
>> +              *      [7:0] -> bits [7:4] -> ext function &
>> +              *      bit [0] read eax/ebx or ecx/edx
>> +              * [7] read/write functionality
>> +              */
>> +             union {
>> +                     __u64 cpu_msr_in;
>> +                     __u32 mb_in[2];
>> +                     __u8 reg_in[8];
>> +             } data_in;
>> +             /*
>> +              * Status code is returned in case of CPUID/MCA access
>> +              * Error code is returned in case of soft mailbox
>> +              */
>> +             __u32 fw_ret_code;
>> +     } __attribute__((packed));
> This does not need to be here, pull it directly from the .h file using
> kernel doc formatting please.
I will update this.
>> +The ioctl would return a non-zero on failure; user can read errno to see
>> +what happened.
> That's not how the ioctl syscall works :(
I will document the errors returned in the header file.
>> The transaction returns 0 on success.
>> +
>> +User space C-APIs are made available by linking against the esmi_oob_library,
>> +which is provided by the E-SMS projecthttps://www.amd.com/en/developer/e-sms.html.
>> +Link:https://github.com/amd/esmi_oob_library
> What is this last line for?
I will rewrite the statement as follows:

User space C-APIs are made available by esmi_oob_library hosted athttps://github.com/amd/esmi_oob_library
which is provided as part of E-SMS projecthttps://www.amd.com/en/developer/e-sms.html.

I will wait for feedback on other patches before submitting next version.
> thanks,
>
> greg k-h
>

