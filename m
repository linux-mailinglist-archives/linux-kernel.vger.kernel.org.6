Return-Path: <linux-kernel+bounces-224832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6791275F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C2CB26A97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243331CABD;
	Fri, 21 Jun 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RKbaNNWX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE68DF62
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979461; cv=fail; b=nc/VCBXSoJtn8bkIpGhPJ2I39bGpetlwLWxZbDOG2scCpubfiBRU3QH9HjUiEbzCSwxHkY0Rb0qly19SVCDuGX3xRXTEVA0Okwh8KF8PfP3X9Smb/Zre/0knAqX4t4H5XDtd9fY3GaEfBZuhkPwII2KsXXbl/gi4TLGghlABqIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979461; c=relaxed/simple;
	bh=/j0TD0FOv2y0MfmFtMwGuqlz8ad+RKmX5hm6qNgk+/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RkYNlgKt4Bdm+rlp5aqfM99hYyAjfeRRCNeZMk5LE5RcC+V10YCvRGX8RArHnU9C/iJ2PBTsU6yynUsLkMRX4zBx0CJEoHx0ALTrr7MHjl/+OG6j/Lbi7RTsI3PS0G0vltulkF3XqrJ7do6WGR8oPdPdnVdA5/pu/0hLRZqS77Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RKbaNNWX; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLS+RXIp3CXjHvyG0HBwZ4WS3K0C2LUBh0ebwqy6dBBA1ZZ66LFrlKLa5sJkBMvgEfWQpHvsfbShGjexWVWRF/cSbWr4LXzr4clrB7C9J75VlgQIG4T8WWfmohGbaac5om7OwNrgU/xaprDHRR/bECSxRXMdvMpZ9SuTJZHYx9+Kfsvu1ybzF3wy1eI3tvNTWXaksIoMqbZ+YtZOvDP6KUTk5KLxQH3l2vC8aHaNe6ePMEQCUuSa3V5sCl5XsIy/uYNRrVYuO7zBBt5ljCH9JA2zVE4JgWhJX9hDqUnqyGL4q2F76U7bl8GUjH+QcKHQkImy/2bhUKUAQu3fsJ32Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2URrmrxo47UU4eaVP1tgohQR/nJe8ROJzxM6Hnpd0o=;
 b=BfkneLldXPu6BM3gjxesZncW5yJILJFDnWxnZANlFFXWFO0t88FKEGVGzitF3mUHTMc9IinoKnWPeaDO8TAxeh6RzXHiKKSMqyJ6UmM0DA/JFv53cQ+yp+3OJs1ZbCjpgSRL9tqnSWe2BEwGZG3DQGEVD9iz9Il+u9brLyMUawvZsXE7JU5TBZ6Sv2cAOotv+QE123L56jr1bcelsVzmv1u7UauAUHuQjxu+NfpiHscP//jbJkl4YTpRtiH29C9mHufPhii4lLmEuyRRY28oW3hOz7E/73qS/9Xv4T7ZyrJLYro7ujFQv/WtzWC/7T4ADH0I1s67Q7gZciV4Bt7HnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2URrmrxo47UU4eaVP1tgohQR/nJe8ROJzxM6Hnpd0o=;
 b=RKbaNNWXSyZbztk435GlZxwlo01a3HQkkyeZjGsyYBmqn4IfUWR1ONs/947M6CaQiBZ7feuSYEijKOcRa3Lll8je6DDV4bAKQGVnWqwHEke2PVob3J3Zk3jEojVsDeFAMEbiNwBImD3T3q+M4yFppnx1Lcug1e48PtJrGXd7jUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 14:17:35 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:17:35 +0000
Message-ID: <4c4c8208-7194-79d0-a9cf-e625e5feff23@amd.com>
Date: Fri, 21 Jun 2024 09:17:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has
 been set
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
 <20240621135935.GGZnWHRxn08g8CkLNu@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240621135935.GGZnWHRxn08g8CkLNu@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:6e::14) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddd3548-e5e7-4bce-876f-08dc91fce58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzA0QmhldG9oRnBXS2hDRG15WkdZYlBBVUJ0YmhrOVZERnpncWRBM3pLZWMw?=
 =?utf-8?B?WGtpYjFrdUlyUmNRK05pYkR6TW1sQy9GS0tYeTVaOXpRV0Z0QXRCWWpKYnZv?=
 =?utf-8?B?eC9VWHlRbG9UdWhWZExHREZINzMrWG9kVktaVDd1eVNuRU5wVG5BQUwrbjlr?=
 =?utf-8?B?SkxSNkVzVURzZTBIQXcwRlZjNFpYSG5TZ2h4Mmd2UEkrWVBmUTdjdzJiZXFZ?=
 =?utf-8?B?ZjRpcTZYM1NzM2gyeWFSaXZDMm9wdFpJOUtjdjBIQjdLTkQrbnZ3dnh1OEJ1?=
 =?utf-8?B?RUswMWJJaFhXOG56ZHc1eklzdE54MGlSWTZ4NjRISTBmbEppYkRxNzUyZW5I?=
 =?utf-8?B?REgzbmo1VmlvaVZBRUMzZThzSzFZaTNXMURyRVNybi9hbTBwa0JLR3M1a09X?=
 =?utf-8?B?aExuS2lSeVVyL1kyTkxqYmR5NlV1MC8yN3M2dUN6aW9ROG5Lamx4Y01QU3Zu?=
 =?utf-8?B?NWRqSjJmQ1ZrS0tnVG9qNkJ6cTVJNTJNTTFRcVhOdHJzb1JBazRTbWFlYm40?=
 =?utf-8?B?NnhqUXc5MktobWpqVGtVVWV4UUNDaFprQWIxcFJFY3A1ZE1tNEdLTHE2aTV6?=
 =?utf-8?B?UExJclZsbzQrM0d4STVnZmtHNGs5SXIvRmdJTHlUdUVwR0gzUUJiZkF5WWEy?=
 =?utf-8?B?WTJDL21QNmYvc0pPSkVyUjJWTHFaT2lZV1RJNlEwcVRZRGZhNXAvYnFSL3dE?=
 =?utf-8?B?b3FBdVlITnQyb1Q0ekFSeXU4VWlSTnJqQXRVbFNwcjZMZ2hUUDU5WmpDSHpX?=
 =?utf-8?B?K3JxbnFuODVucEJTbGJFaUFxWGI2d2UvK1d0bHJ4a29reStHby9objNSVklC?=
 =?utf-8?B?TERtekFFZmJlYnhiWjZxaTBXU3J3TmVrZXJNNnVFY210UTFOSnNFem9oOU16?=
 =?utf-8?B?ZjUreTZpenl6ZkFoWFBRRmpHaUFoVTNqK3Yra3JJVmxEd21yV2JiK3J5Mjlu?=
 =?utf-8?B?dVVYaEZmL0VLMFdkQ3NQL2VaOTN6aVBpS0hWM3d4MyttWERibjZxbkliUEFr?=
 =?utf-8?B?bm0yd0hGWXFqU21oTkhRejdEd0RqR0lxcUVJWFRJWEJ1blpHN0d4aXJabERp?=
 =?utf-8?B?K2FvR0EvZFlacHltNmg5WGkrOFlMei9XK3BkcWRUUHY2YnZ2eVowd29JRXJx?=
 =?utf-8?B?ZlFuM21QNUJ4dTZaQjBnZ0pVUkR6akV4U3hiT1ZsYlNYZ1Q5MXc2c284QnZl?=
 =?utf-8?B?YitGUUxiOXpidDJkbXBnenI5cmJwWS9XQ2hFRThBM1ExWHFXUUE0bHNteG40?=
 =?utf-8?B?dllFbHZhaUdpWUR3WTM1bkxjR1R6dXVkblFQc2JVaG9lUlB1d2lrRnlGbG9r?=
 =?utf-8?B?Z2t4U0ZJVU80ZmtxVWNxam1QOFBBNzJMcTJGOTRURElUQWFDcSt6aHJTNk5L?=
 =?utf-8?B?ZGhaQm9YZEpDQWh3MXBjSkdGcmN1WHhLNjJmd3Jrck9uMitkQlpRa3J0RE15?=
 =?utf-8?B?RFFaRUtVczduMS8yWXZHaEVpbnNtdWozaEpiNjhxNmp6LzdPb3pXZFJLVWJa?=
 =?utf-8?B?YXpVVXdtem5peHhybFhQY3VxQitJODBlOWp5R2VxY3hCWVZpdUhSaGJYWnYx?=
 =?utf-8?B?aGtPRisxR2hHRVJqT1J6TjBHSlM0M0RwRlZYRzFibEM3NXdSeEdxU09NcENH?=
 =?utf-8?B?bHNBenJWTnJoYnRLT2ltT3g1dDU2TEpWNHNPN0xEZHlCZDNGekdUelFUK2J0?=
 =?utf-8?B?eU1nMWpRZjE5aFpiQjkyWnowWmdBYnQ3cm9zdnNneEl5Z0Q0UExLS2NYMGs0?=
 =?utf-8?Q?JUeb94PCW5FkXdT3jpTvwK+jXOcaZeiPswmqMKN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3hPWmUxTEY0Unl0RWxLNk9EaFdxNjFzWjB5MlMyZ25iTHpyalZnMmo5UUFp?=
 =?utf-8?B?cjR1NDZLejNYdFp1Tzc3bVhsd3hMREc2OGtOMzFBazRhM1lFWThIaEw3V3Rj?=
 =?utf-8?B?ZHkzWXBzOStwMTQ4MG13MGtNQUpkZ1MwZjhhS05LckFWbU5KL2VuRUszR2dM?=
 =?utf-8?B?Y25jVlJxczNXQjlDOFk3aDRXaTRwM1dIWHpqRGk0eTFpeGVSVlVtQWZ2VzVk?=
 =?utf-8?B?eXVQNTVmelY5bmpIMzA1QTdzcUR5T1oyNk15MTVUZEprVGxESzNMM3BHRVpz?=
 =?utf-8?B?TStDT1phZldLTDhzU3hBM1NuemdCVUR1OThQTDlrUGluOFo5ckJFVlBYQnpk?=
 =?utf-8?B?b2lVSmk4UEZNZlJoTEFoL3MybHFTdkFIOTlnSnZOMjFIb2hzVzRBTG1nMk9I?=
 =?utf-8?B?WW8wN0k4dmNzYlRraTNtUmhrcTI1QUtqUE55RENQZzdsQllQZkVQZjN2TDNY?=
 =?utf-8?B?amwxS3Q3VUcvSTd3N0VrMkZZaEFRZDQwc1dHY2p6VDVtVUwyMnI3TVVGU0du?=
 =?utf-8?B?dVhOQUFYTStWdkZsT1ErL0M4L2NYdy9FY25XQUljV1JiQkt0eFo1anY5aklO?=
 =?utf-8?B?YXd2UmRNSkRVR1pyV3ZqTGV4Q1ZKMU1LV2plY0NvOFlPWktsRFBwRU41TTNk?=
 =?utf-8?B?YW1PVUVWQkFRYzJZY0JzOW5HQTdTcmkySHYzZ0FQeHlMV1pubTJFeTIyVThq?=
 =?utf-8?B?MFlXQXRRaWFrdHh3ZXFHRHUySEpGb29ORStUd0xLU2hocnQ0aTNJTTh2QUQy?=
 =?utf-8?B?dE96TjBGRHRTVDRnOUUvZjFBYkdoOGE3S0k3QlhjR1dXY3dUZFRjTkpNYWlE?=
 =?utf-8?B?Z041SUgyV2UxYkttVjV4U2xKQlNEVWlOR29tc0ZTU2VVdWx1S1BvK1VmbkN3?=
 =?utf-8?B?K1ROZmJTTnNwM0YvemVZdWM3NjJWUnVzbnkyOEE1cFlLbzh3azNBWXc4NHlZ?=
 =?utf-8?B?YnAzZU95cHl3UW4xUTcySXFjWXRoaVQ1ZVlRSlJGL01qUHZ6Unc3ZFVkMXhW?=
 =?utf-8?B?OTlzb0srQjMwdjlJYXRWQTR3SWRXSEdRSUVWb2xaT0tYUUQ0MWNHaHlNaC81?=
 =?utf-8?B?UzdZelVBY3BDNkNSYnB0L250bUVLL05wS2tQTGpUZXFWY241Sng1YlZCWjdq?=
 =?utf-8?B?Q3dKOTVGazhDcUtoS3Q2SEJZVEs4UmczY3hSN2ZmcmRjVVcremI2STBhc01F?=
 =?utf-8?B?SkVrTGpLTkwxSDFTTVd3eEJWdm9neEtCZXJsNTVlLzVtL0pLVHd1MkZzbjRM?=
 =?utf-8?B?bFEweWd1amN2OHJBMllYUlpweU05Sis1WEtRb1FiWHJsRWt2bVI4MzRPT0cy?=
 =?utf-8?B?LzQzY2ZsMmZWQWVaMnBiU0JCaldTMzhQREQvTVVSZW8walR6RWRYZVRMaUJS?=
 =?utf-8?B?L0w4SHdpWlprWXc3TWhuN3QrN1dXaDJyOEs1TllkTVVZeUdjbjlGYUZldHV5?=
 =?utf-8?B?Rnc3YWFFcEVNZ1VKY2o4K24rVG1QbGNrY0NydXFaUlU0Z0d6U3BlV0hoWDFJ?=
 =?utf-8?B?K3VNYnlTWWlWRXExMEFxdXJlNWUra3I4dkZlYjNieHh0aHB1dVlmcEQ5a3Rj?=
 =?utf-8?B?N3E4NWJHNFhCRUltdy8rRVFRUVRwV1VrN2NnY3ZVcGNYTGhmUmNkUUU3Ymx6?=
 =?utf-8?B?ekJHWk1rTkx4WUNiZlZVdXNZcTgrV2JKS1hDK3dPbHF2bkpubXRPOEo3QlBF?=
 =?utf-8?B?NnROWER3V1kwUW9oY2NlcWhHMGllQmdBVmNFQnI0RUlWNkI5eGhKekhHQU1J?=
 =?utf-8?B?YWJuRTUzdm9INXY3cTRqaWRvOWdGKzRTVmtSWWFiWjNac1I3SlNYWS9Uam8w?=
 =?utf-8?B?bml1b1c3a0FtZ0c4YzhhSytBbSt5MzhteUpzVHZHZ3lUSm82NUpVWHoycWdI?=
 =?utf-8?B?T2pBZEdwdkwxR2syK3VQK3kvMjNWV0JDYVpLZS9PTTlLR3psSTdkeW9HV1g1?=
 =?utf-8?B?RUZYZ294VEZQVS9ZVmo0azF6cWRVQWNhUGpKSzlCTnhnRGRxNzVFN2ZwZ2pp?=
 =?utf-8?B?UzArVVRva1RIbExRd0sySXFrRHZGckpaWjd3d21BV3VzeUxkUGltdkpUa0xt?=
 =?utf-8?B?dHZ5M1h2UlZURkl1MUdJUW90a1ZWZDdxaTZWRHFlemVscWVlL0dOL3EzM1JQ?=
 =?utf-8?Q?y9huTdTB27PU5PzyTU54t7giW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddd3548-e5e7-4bce-876f-08dc91fce58b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:17:34.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbfZ7sg7O2sMEfnV9M/emujfbTYw1HzbikCmqqEjk0cGhBr3oNNN4hgPhV3ayc83jWfEBAMzXsNIn9ZXrbgOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

On 6/21/24 08:59, Borislav Petkov wrote:
> On Wed, Jun 05, 2024 at 10:38:37AM -0500, Tom Lendacky wrote:
>> -static u64 probed_rmp_base, probed_rmp_size;
>> +static u64 probed_rmp_base, probed_rmp_end, probed_rmp_size;
> 
> Why do you need _end if you have _size already?
> 
> IOW, please compute _end where you need it instead of adding yet another
> static.

I think it makes the code easier to follow and less of a chance to compute
the value wrong given you have to substract 1 (end = base + size - 1). I
guess I can create a #define or a helper function so that the calculation
is always the same if that is preferred.

Thanks,
Tom

> 
> Thx.
> 

