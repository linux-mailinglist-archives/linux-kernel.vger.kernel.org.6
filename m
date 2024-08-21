Return-Path: <linux-kernel+bounces-296146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708BF95A641
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F5A1F2287D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C37179972;
	Wed, 21 Aug 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YsP2KHKU"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FA178389;
	Wed, 21 Aug 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273995; cv=fail; b=cNgRxKUrWIYCCG7wEodS+uz0nivK2edc7sYSUbuONt5XLUzbmt1agcrgsH8w9ngsskGaUhoEb3w1BNxWPpBuVULR33P7NXxJMNkOVpcSTTtF18GdIwl0hxCDQh9O4+DAnZwCuN3QkMgFEWQ7cQJ8aRqOVXKEJLZLIP3w5L2W5BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273995; c=relaxed/simple;
	bh=6H1XrNufp8NuyOkHVb/8mX758cMoXQQ5yMN9rhW7GLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IUWHZeg/9/IhnXF//pkfiUBOn6ZZ2N1IiosEajnlmYqBi28Kgp2xuhKYMlHvDscNsTUkhFnSg1rvjPJ1GfFiLveGAen+OuvbsQzxtiDAKOfgEttGSrM1Oj4JIGe5+4NCOOFVqZZT6Zu5jgCy+dY0bd6ezgtT4diY8sLUGsuT35I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YsP2KHKU; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0pOEMmvPOM1T1JIkOs6uoCX5C6zsy8iFalbg6PObsRu/xL8pPKZq9uOKwelzHDssy1Q7cueQdLzS9WkAbZoWxQ3To8O3kJxYj9mYrBkk4+ojDKeTHJa2EfilsBU45sCwbu5btx+9lpjqISZt3kpJ+zhNnG/akfcnzVOFxV7H4mBoXhAjPMLLMqZicSf086dfwIPC73Ka5MyeBrQZcXYeUX9LJ9Er+uBGsJKw4B3WnF3x1rhUtBmfjDQexqVPW0yW0mX7WxAV17/5YMX+Tx0LbHC2SNZhKs8X5xJ1pzAjWlNSGD9pE+NHELPTWKmb8rdrzpcZbcbwu7Lmk8SJIjwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+YC0bFLTqHSaoqlWVNCGEXb44jxEyok8XqBRxdx0Os=;
 b=WVt5EWhyFKFUc4tXY1iVQE2iAFPNlW/1RStjM1NUbfLYJKcc2Vq/Q2aTv1g59kzPsokRBvlmuU0JJffVG5ETKyASgEMeoBAjiW46yu2YPeHgWPL9mT7BnhiifxfZSTushvHhi6JIkN5CsgS2IcvjHA3EDZzL6cvEtJx0glC2a6Ljd7tGAdeJ+OKJeWXPIYHyIux3ov+UMPA2E7aleblzycdpTPFUMPEi9ng2CYYvw41JSwOS7ev1DEMEScI/rgoZCtkzSicIYwmMJI8Id680fSqUJ8WGGnqX0Is32QV7mO1P4jfELtM2I4nD3HnfJdJPcSTFh9ptqSJi7spKxdAcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+YC0bFLTqHSaoqlWVNCGEXb44jxEyok8XqBRxdx0Os=;
 b=YsP2KHKU9FG9ga8QNcArjX1+6OfOlDqZ5Jwr97FBKYYcMtLQNA2nIRELNFCrNI3ktoEmWreG1TsAuHpj5r4r+UkNLvR/xusiNk9J5ka2z1Jh0r9p/xvpNwc8yKidoGw7eFaaV5lCuHTW8xAodnWHHYm6kWN9U0oIWCgqvNakRv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 20:59:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Wed, 21 Aug 2024
 20:59:50 +0000
Message-ID: <3b9dfb8d-af1d-4f5d-9554-d256008ed9bc@amd.com>
Date: Wed, 21 Aug 2024 15:59:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xhci: pci: If no ports have wakeup enabled then
 disable PCI device at S4
To: Mathias Nyman <mathias.nyman@linux.intel.com>, superm1@kernel.org,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, mika.westerberg@linux.intel.com
References: <20240712185418.937087-1-superm1@kernel.org>
 <20240712185418.937087-2-superm1@kernel.org>
 <76daeba0-ac1a-4e05-8d25-3966526b464e@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <76daeba0-ac1a-4e05-8d25-3966526b464e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0036.namprd11.prod.outlook.com
 (2603:10b6:806:d0::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: e9983ce1-6a39-4766-19d6-08dcc2243253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0FNb1VxVG03Z1BWNEROc0lLY2hGMlJ2b3dmRklpM2RUOFhhdzY3Y1FmK3FV?=
 =?utf-8?B?Q2N0U1NUMXpYQklneWkrNjBvWUY5ckd4cFV2NVFGU3BuNUJtWEtxbHIyTzYv?=
 =?utf-8?B?V3pGRHRBdXV0a3BaRkVJa1lqT0VsMkxPRG9yU3d0TUVyKy8wdU9kOE55NGpt?=
 =?utf-8?B?Q0dlVXFIVkVwQ0J5UHRWdnlzZTRKVkhNWC8zOW9QZVUzVkJVZ3h0aVVKclFK?=
 =?utf-8?B?YTBTVVFxN2ZGOExHTjhRcEd4cVlBS2NTbGhqaUpNYkFUVFNKcXlGeS9qQTRM?=
 =?utf-8?B?ZG9YRjJFMkRMdjNiYmxveHJIajZ1dzZ3UmZPTlEvT3gvcU5mV1V3YnF0aE9m?=
 =?utf-8?B?MHpwNm8vb0dvUjhiZlJ5dzh0T0tObW1CcUl2OU1KL0FvMlh2dGRnTHVtNytk?=
 =?utf-8?B?S3dacE9SeGh4K0N1TGJPTGRrK1daeWt1RG9zc0Zpc1B5MGxidFdJUHVISS9L?=
 =?utf-8?B?ZHdrcVhRMUg2cGF5Z3h1K0g0SFp5NGRKdGdDM09tajB0Y05OajQ4RTF0cU9F?=
 =?utf-8?B?cXN1MVBmVFJaWkpOeDliN2tmaE1BY2N6d3VKYUpLOWRNd0o1R0ZYZlJHOGY4?=
 =?utf-8?B?SDU1QmpMbXg2RXU0VVVMV3F6VjlraXEzVWhBVmZzQ1luVit1a09zN0Jyc2lo?=
 =?utf-8?B?MUMzb1FzaHFIamdIaVJBT2FFcnNFTXpDcHZVNEJpSVRJZ1ZyeWRjRFM0V0F1?=
 =?utf-8?B?cnVDcHR3RVBvd2JhcDM3YTdiUjhVdEpZNTVqK1RQZGs0QUxQQVpVN21DVmtj?=
 =?utf-8?B?VmJzNFVRUyt3K3ZCdEw4b01OdCtManZyU2NzWHAzUzVzaVoyUTl4MXRTdkpp?=
 =?utf-8?B?YjJpWHl3ZnVnNTR5L25TekY1RmpjUlRRMHFRanNVTlZ5NFJ5R3JsbWZzR2FR?=
 =?utf-8?B?Y0gyZkt1M2VoRTNFN3d5eGYrK0tvSm9JbUw1TjdhVVdpZGNDVjJmbjRxUm5U?=
 =?utf-8?B?cCs1eWlpSHRZb2lIRVB2cDNmU0xSUWd2VEtpeC9kVmc3cExwQXVYOGl6UkZW?=
 =?utf-8?B?RkcvSjVzamdDRUVFcmNGZ2V6RTA2QnBZbldOZExYOEdpSDBQbE5qaXN6MWR5?=
 =?utf-8?B?MTlKVkdnNXU5RnFLSWYzREgrVEdEQ1kwcDN6aTZWbzEzSExCWTVOYVAvblA0?=
 =?utf-8?B?VUpzN2VyMGh5MU5qQnFCTG9DeTcvMG42Z2xKUllsRVRoV0lWUFRKK2x3VkxP?=
 =?utf-8?B?MFNhNkRuS1F3eU90RXg0eTBhTDRJNG00aVZBVEwrSHltNXJRdHpLenVMYVp3?=
 =?utf-8?B?RzRsbStCdnZTM010OHNrOCtNUEVjeWhlSk00ZEh5MHFvTkZzcXQvbjA1eDVT?=
 =?utf-8?B?dFlJTDVxNjh3VnpZdzVGWnM4Mk9BZzJReFhsaUdZbVcwK0xlbDBQMFA4RFN2?=
 =?utf-8?B?dVpMODRpcXV5M1hSOFEvUjMxVHdhYlJGQm9CeThGVkxJWmhTSlErU0haSmw2?=
 =?utf-8?B?b1p4ZXVmMUhtRU5xUG1jejA0b2tGVjV6NHdKa3BuWjRDMERtM2VSS3JYYlBv?=
 =?utf-8?B?OWxnTlZ6dGN6TzVnY2daTEZhVXJ4WkhRSFk0eTRheFpaZStIZkxXOE5YaDZV?=
 =?utf-8?B?ZkUyTWZSSHU0Z2ZtMHBLeUJ5Ujd2c0x1Sjd1S2haUzJEeVlJUjhEL2RZOXhl?=
 =?utf-8?B?RFhnY0lSM2VxTW4xMWovSkhXRWx6b004RmRIRE02bm85aVlTVUwvQ0dFRHVv?=
 =?utf-8?B?ZmtweDRlUTRKS1pzU1NLV2phMEtDWEVVOTExaXczZldtV3IrWkdYK2lZa1V5?=
 =?utf-8?B?dnFlc25hanN3RDByeFNKWFpFVWZlNzR5bm9EdjQwSUw3Nm5yUEJ1S3doS2Zh?=
 =?utf-8?B?M2JHelRCZWt1VFVYTDlDZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU13UDRXOTRyMWltSk1wMElMRm1kSEVNOTVHaStJOVNnVlhXYmZSZTl1aW1C?=
 =?utf-8?B?Y2hsN1FsVlhKYVZGcDhQbEZJQndRQk5aYnM1UUVUNnpMd1ZYSFRRM2NYSHFH?=
 =?utf-8?B?NFFJci9JUkZ1NUlOMW94U0xKYzNNMkZkOFA5SFplMWJVam5sd0J6SGI5WDYz?=
 =?utf-8?B?NGxCV1ZaVmpaWGtmeTF3QmhnTnVhVjhubUtsa3JaS3poZGx2Um1TajdNdWdt?=
 =?utf-8?B?cmR0T3hMNTFjTVNKU0I2dC9ib1JwRFZiNStmUmFYTnpkeVMvck84eTVxcFI0?=
 =?utf-8?B?REllNjU0Z1FsWE9qMXB2aVJEYU41TUVjUVNZODlSOW1HRVJvaW9TK1NTNEZ6?=
 =?utf-8?B?Wm9zcG41dm04VzBvNloveFVWMVVTZUlqUVhXN1UvME9mK2FVQytXek9weUVx?=
 =?utf-8?B?TW5FVk1rZWJGYy9VZW44VkM1SEVLOXlWd0FxbWM3WDVkYzJCQ1RTR21wWWFZ?=
 =?utf-8?B?RmtTRnNMTWRyVS9PRFlkYjJxSVlRYXp2alExZWlYaXlRWTFrNDBveFdTWldI?=
 =?utf-8?B?WlN6WVdGTWQzVUQ5WG1WdGYyc2lkL1JnN1BEWURaRU5aSldldHg1RVdSdDlp?=
 =?utf-8?B?MEZQZUpKU1VMaHFVdnBPQk1YMjE0TmF0NnVDOEUwN3YzTnF5N0FxakJRdWZT?=
 =?utf-8?B?czAwTml3MlpHRm1URlZPYTQ3M1pHVjRJYjhCbjhUbXVTRlVLS3hBRVZ0RUYx?=
 =?utf-8?B?cVJ6ZGYvRlFWaXJOTndqR1gyeGovbEUzb0g5d2ZvVzRweG1BTzVDbmcwNjB3?=
 =?utf-8?B?bGMyMXdsblJreHZ6ZkNhd2R2bjFLMVdiWER2MU5GZjZzbkp3a09uOTNlU0VL?=
 =?utf-8?B?K05sdXUyY0FQN3BWK0VJMy8xU0h5bm5nRWpOQmtSRGNCMFlrL2NzTElSS0Zn?=
 =?utf-8?B?dXQ0YzZpbjEvbnRsT2UzdjhrY2xDZ25qSnY3cEJ4ZFA2YTYrbHlYZ3h1Zlp1?=
 =?utf-8?B?WG5mU0w1K2VYN1pHWmNub0xhSFFNRzM3dk10aFplT2k1T0JlVDdlcG1DWFMy?=
 =?utf-8?B?emY2eDRiZnV4UXRkUXJ5cXNWMHlJcTJKU25OS0hZaFpLemdMQkJHc2x4TVQv?=
 =?utf-8?B?QTF4TW54OHorMzYvRXFQWjk4Q2RXL0xTTXh0aVJobllGd1d3NkkzS2paU2Fm?=
 =?utf-8?B?a1V0VDM4c3JpZmkwQ3cxZ0FyTlJMRFJwbWtoRmtUSVFlMWRhd2RJdWlNYUJy?=
 =?utf-8?B?V2t2SFV0b0UzUEhpVk51WVgrZC9BeTYrZHRGRFJrT1A0VjhTNFRBVFJ3OGZk?=
 =?utf-8?B?N3JuRVg4cUZzSitXb0h5SkY1eHk0TDZNUFFXRDVBQmR1c3pTdjA3Wm9reHow?=
 =?utf-8?B?ZGkrS2d3VHFRbE9ML2phSzlWKzVQVXAyVmRLRTF4YUlQWWZiU1RZWGVmYVl4?=
 =?utf-8?B?S25YUlRzMTdhOUFMYnhaZnZmZS91ZkJhZjg2QWVnYlZFQi83K2VqTnNDbWVY?=
 =?utf-8?B?bWJCQWcrM0dZSGhoVWFINm1MNEJHZVZnbWI1eU0wT3k0a3JzeXU2ODczZHlY?=
 =?utf-8?B?UFBaQ1dCTXRXcU5BTFBnQlp2S28xK0ZxbXRiZWdmR2lkYzI0V1lsM3dZdUYy?=
 =?utf-8?B?SjFIekNKYlFsTDdTYjJYT3BBQm4vckIvUHVSSE1KSTlFUjExT3JTZWM0Q1NM?=
 =?utf-8?B?dmc1ZVRBeXJYSTNqc2YxRjJjY0IxejM0OHR4QVRTUEtqMzFHR3Y4T3gveFVx?=
 =?utf-8?B?S2FKazdLTGdGdWZhcUh5WlMwTUUwNTcrb3pWMDBTOWxQQm5IbCt3NW1OT1dO?=
 =?utf-8?B?Ukd1L3BuR0lCdnRHQU41empqY25xSGtGVkcxSGxpNytZamlEMlFraUdmMmtJ?=
 =?utf-8?B?NnJXWGhMbkJKeVpGZ01CUjFZTVp4Y3g0bVR4OURDY2dqYm1vSlV1cmplVllr?=
 =?utf-8?B?Q2cvSmRrM2NjYnoyVEUwcDAzZStOYkFBZnBIb01nU2hTRlBVbnByVWM3VmJs?=
 =?utf-8?B?ZEd2TGo0QjJWV0F0cWR0eHRIVWpNWUt6K3p1OFlBZWdGekJObEhhTVBZN2Fa?=
 =?utf-8?B?bzZ3OVhBalBYQzdhTE4xT2VMbk4vWk0ya1Z5UmFVNERDL0hjdHNrL2toZXJF?=
 =?utf-8?B?KzRLTU1KVEZ2QllJZlF2WXRIR1RCQnNxSEQ4MVZmZXlOOGFVQ2Rpbk1UT1Q0?=
 =?utf-8?Q?kmChw9De4mGv3X7mo0iE4f38x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9983ce1-6a39-4766-19d6-08dcc2243253
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:59:49.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7p/6IjDpPCbODiY1NkBicYM26rEv8pLC8irArQvCVdd0E5xeAZQG6ktNrkCPDf2kHGyPZ6bUHjXQQpGrCvU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

On 8/21/2024 04:25, Mathias Nyman wrote:
> On 12.7.2024 21.54, superm1@kernel.org wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If a port on an XHCI controller hasn't been marked for wakeup at S4, then
>> leaving it at D0 will needlessly consume power than necessary.
>>
>> Explicitly check ports configured for wakeup and if none are found then
>> put the controller into D3hot before hibernate.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/usb/host/xhci-pci.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 05881153883ec..4408d4caf66d2 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -823,6 +823,7 @@ static int xhci_pci_poweroff_late(struct usb_hcd 
>> *hcd, bool do_wakeup)
>>       struct usb_device    *udev;
>>       u32            portsc;
>>       int            i;
>> +    bool            wakeup = false;
>>       /*
>>        * Systems with XHCI_RESET_TO_DEFAULT quirk have boot firmware that
>> @@ -860,6 +861,14 @@ static int xhci_pci_poweroff_late(struct usb_hcd 
>> *hcd, bool do_wakeup)
>>                port->rhub->hcd->self.busnum, port->hcd_portnum + 1);
>>           portsc = xhci_port_state_to_neutral(portsc);
>>           writel(portsc | PORT_PE, port->addr);
>> +        wakeup = true;
>> +    }
>> +
>> +    if (!wakeup) {
>> +        struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
>> +
>> +        xhci_shutdown(hcd);
>> +        pci_set_power_state(pdev, PCI_D3hot);
> 
> Not sure we should force D3 here.
> I think usb core will set the PCI D state in the next .poweroff_noirq 
> stage,
> 
> for s4:
> .poweroff    = hcd_pci_suspend,
> .poweroff_late    = hcd_pci_poweroff_late,
> .poweroff_noirq    = hcd_pci_suspend_noirq,
> 
> hcd_pci_suspend_noirq()
>    pci_prepare_to_sleep();
>      target_state = pci_target_state(dev, wakeup)
>      pci_set_power_state(dev, target_state)
> 
> Maybe the target_state isn't D3 for some reason? (missing ACPI entries?)
> 

Thanks for looking.

Even a lack of ACPI entries *should* still lead to D3hot if wakeup is 
turned off with that flow.

I'll add some more debugging for the various callbacks and see what I 
can come up with to explain it.

Can you please also review the other patch in the series?

Thanks!

