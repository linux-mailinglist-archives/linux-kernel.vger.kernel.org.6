Return-Path: <linux-kernel+bounces-313011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9E4969F00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EEF1C23CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE41A7275;
	Tue,  3 Sep 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xpw9/rN7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D641CA6AF;
	Tue,  3 Sep 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370065; cv=fail; b=XDMMVgbQyEeBIcUxyQZaxQChTSKxdIIyCJvzX3MF77MFK5XZOeKlLOYTzadspBeMTSg4vmPeEH8VEHnxGSczbDdlKAqn/eFxVtt57tt/gOhDoQmuDtgGuQVcedoSEo8MNhdcrBx2Ry2eCndKCf8XK8p7+OgZhOniX3x68GtaxrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370065; c=relaxed/simple;
	bh=1f6wGFExRAo1rCg7AsiuI8PqJV2NRKsdrK9edkaKtpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J9h4gYnSRX9bbIFHy16EcohXFsQR+RKql52j0zgDvCdfOAROecT3o/sab88oRBzDL8E6G5c+/ZcEv9hui3Lg+ZczCvCFq363lHgBFrPqmvwSlu3GnpXVQLEg9y/Q3O6D3h8opuBfZUigtlvXSf1O9lXoSVaUCmhNBV1x6yobr+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xpw9/rN7; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRXKJn0v+ST3IsP8LIgbNBBCWpROQ0pH0VU1dZ4QDdKPuz10NoKOvAoCP2NHsCsz2/SXDWtI+RtMIAu3tamWkGzlnbhxF5R5p2DPXT0HFE9iP580CI/yChTOz15YXUXrgOjEEBMruGSL8MrCZkchK/ZNYmLsx7r0MsTymeZg5CkmfWVetRbQzbQpgLdr3FAwAAXjeLGlIZjuBaG2ELvsjYn2H41wQG4i6nq9BGMRBgwNQJItqMCbhggfsK6FHHKPO6AODMrX1AtF+hHly2t6h6zFm+EL2RcvGIzdCXHj9Y/0vojL3Fhpct3KHQ6sthB090i3YJmLvOjYpDkdyjMzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExZ8xv3zOCk6c0YdOd/MS6kYh1OQL+YYnHrgw/MvU+Q=;
 b=mlEV55pz0A+BFPMV7NlRCS7Hww1qqTGIY2WjH76a7QqYCnr5EUuDebDAJEUtHSX8mAEwhU9QuDxTWZGKoBRubmVEbvrAh+09g2xe3ikrP1ZhyqL6NHmYFYd2tZvjzsCJ3sZfwqZyc1VyCJrK2WD5poq6VqkcmAHmM6NwUUdidW+0ReC5dR1LYIgn5qwEubZjk4OYH1mHqOu+BjeXMd0xeRZc8UmIqunAlF4Pgpcf31OWc5GuSiIqHdvE/PXgevWgYfn+0fR/6W7Py7i636P39tDFVFs1TIYIWXfYVqgT0OUIKDvtqv/UkqrFoyTZ5NjbhYtD39puBGOWabVG7b51+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExZ8xv3zOCk6c0YdOd/MS6kYh1OQL+YYnHrgw/MvU+Q=;
 b=Xpw9/rN7ltzUznpgQjfvuYg78NfV/H3ZrhcAVxuL9DqzWTGg/j6tCcTzW1nxiYYT/jrFDwgqyby5GKNpS8b1vJBVvu2hbmi2PpcFsZ9O8IbIEwvxI9sCDCd4/XDJQEionZd+6u5UMLRoyM8ox4S4H+5P+Dgh3fxuJ03fqXszYgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 13:27:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:27:40 +0000
Message-ID: <29f935fc-5607-46a0-8733-3754aed94471@amd.com>
Date: Tue, 3 Sep 2024 08:27:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd: pmf: Make ASUS GA403 quirk generic
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, Shyam-sundar.S-k@amd.com
References: <20240831003905.1060977-1-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240831003905.1060977-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0088.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: ade649d2-9415-4eab-01d5-08dccc1c2f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGVYcFBoaFA1L0dTcWtzR2hid2xMb2ZNbm1LY09TVDRCSzNVTVk4TFkvNm9W?=
 =?utf-8?B?WCtXb3VaY2t0dC9YbmpFWmcvWDV2dzd1YUhsVm1KSysxWGljYUc2N1dKNmJo?=
 =?utf-8?B?dkFVMjhDZDFZVytlZGxDaGk3cDJmb2hUdFQ3TzNIZ0x4NTR3UmtYNTg3anpl?=
 =?utf-8?B?Vi9pN29iWUVlRk5GaHJFLy95c2JMOXRKNVdhNSsvWXpiTGs2OEdVRWJzdGRK?=
 =?utf-8?B?UkdwYWQzaVQ2ZVcvZk1uN1V2Z0pqcFFHMkhvdzI5cFV5dDNiaXF1VmNFaEdV?=
 =?utf-8?B?clJlMUpZZVJrR0dzMzRJRGdmUy9lL0tDS3JnZXZ6ZWFxa3A4UFNVWHZzL0Vo?=
 =?utf-8?B?YkljRmMrYTYrUjBBaEVEQTNnVVRZSGhIMVBwV2RQMTl3TFVqc0owT004SnVh?=
 =?utf-8?B?Nksvak5ETlNycVBLQXBReEJxN1gvNk5EbGs0SE16MS9kVDE2SVE0S2JyNU9P?=
 =?utf-8?B?UmFjR2lYNmF0R3pGSE1teW56eFRwZHBYeFB6MmZxclhkcUd0YVpTc2VzV1Ju?=
 =?utf-8?B?WDFUWU1EcExadXhSeDY0dHI5eDZDWWpUNmZTcFA2QWtNcHpMR21ITWdKWU9N?=
 =?utf-8?B?cTkwWFl6aXdqNXlMNDJzaU1TdmJrR0lEcTgvZ1FUWXM2Wlpka3lxcm5KamYr?=
 =?utf-8?B?WUhwRnljWlhnZUFmRm1LR1R0TkNDMTRUTlFxT1FnZm5ESHFXcmpzV0JibWhu?=
 =?utf-8?B?WElGUEZYbXFYOU45RTB2T0JOT08xSnhWK0d0MzZENjR1NVF1N0NLOFY5UE45?=
 =?utf-8?B?aCtQR21hR0lwcWNNK3FRVzdqaWRTcTI3Q24yWXlFd2FYM1dUTHpwMHJlblZH?=
 =?utf-8?B?NGNaT2NqVlU0VkF4UklGWnlYdklpRXRGUWJrQURBVXIvSEZBZHp0ZXNtU2dk?=
 =?utf-8?B?Z1pwSW1zcUkwajBZaFRlS244S1MydS9NaFUza21iSDdCL0UvMDFCeEhuQm4z?=
 =?utf-8?B?UHpsTTdTMjNSZ2tyY2JWSmkyRCtlUFM1cHBNWVl0eVVyK0lYNkJvRVVqdWlZ?=
 =?utf-8?B?d2JuQzFtZWZFLzBwektBN1VIekIwUmxGVDJ4d093U0M3VngrL3UwM3dLcHN2?=
 =?utf-8?B?S1BwQWVWd1RtMWtyRGdaRHFIdzBJK0xuUzFsMzNPT3pOZTlVVE1mdGozQUxH?=
 =?utf-8?B?aWxYcDUzS1Y2Yi9nRVpYMmprdjFWOTFSZEdQOFhCN3F3aitPMmFUR0EzSHhX?=
 =?utf-8?B?bUFDU2ZTN211OFN5Rm1CcGl4Tmt0Vk1LbGRwR2xuU1ZnMFk1M01kTUVMdnVJ?=
 =?utf-8?B?NTBNOHlLdnRCcjRUVUoyQTdMWHAyOTBTSTU3dklaSFl3cHZTTDJMZ1BGaDhC?=
 =?utf-8?B?UXd6TUs2OTRlQjJjdFJualBWcnBoelROZm02b0J3OWFpSGJ0RUxmUTZQd00z?=
 =?utf-8?B?cERxYm4yWExFQlFUTElZQjE4MFU3OS9sZEZLSzlJb1lkSk1jY1pYNUE3eWxq?=
 =?utf-8?B?RWNhMlc0Q1dkY2QvRnc5aGtMWWZoS3FkSTlhNkxaRGVSUnByeFQyUFpTbHhH?=
 =?utf-8?B?cWczK1lLT3k3S25aRHJrUk82ZCtOR2J3Y3VPbHM2TmtKVVhYbnlqQWpHRUd6?=
 =?utf-8?B?ODE3T3NDV3AweHJsYnJGcktLMkE0ejhmSk1KYzY1MEFpbXB5RmNFVkNTVE53?=
 =?utf-8?B?cmltZmJ4VktvbDFTYlMrMzhxTTVLS1lLbHpoSjYxN0hQN3lZazVlMzg2Y1l2?=
 =?utf-8?B?b1lVSEJvUVFOb2xzY0ZjcE5oejB4c0Vvb09rdnVFdllSSzRmbEhFZHpjVVBN?=
 =?utf-8?B?bEJyS0JBSXB0OXdZNm9PbzFJUm00TUhqYVI1QjY3OXRtVk5wN1BHOXRZSWw3?=
 =?utf-8?B?QUkxRHl3Y3o2dHByQndlZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDlMbGlndm9NRVNseDIyWmdhaGZ1dWlyUDEweE45di9Ndy9jQzZrcjdmMk4y?=
 =?utf-8?B?UUZkNHRpN2RQTFpYcE92Wm1Wd0V6Nmx1WTFjOFpJelpHMEJZdlZ5SzhJK3Az?=
 =?utf-8?B?TTZkZnpabnBhdjJTQngxQ04vOThkelJpSnBKN05GVk5wZFhVamZHRnViOU15?=
 =?utf-8?B?d0I1bXM0MEF3R0dUb2J0alpqU0ZVS1VZaW1NQjdSR0xSdjdscGJuMTU1L0Ro?=
 =?utf-8?B?WExPWGtGWExoWC8zZXNveEs5YnNIcW1hL21ZNWZZRTlYQmJldmlMZnBZdUxW?=
 =?utf-8?B?SEEvdmZzQVRMRzhHUVcrSHZ5bG1qRVZKZEV2MFVPMERiUWhvSThOY3lMeFI4?=
 =?utf-8?B?NjBtWFk1NXNRUEdnTHVPNy9xTlNsejFNc1AwUGdQWmEzdnNWU3dJUHdOa2VQ?=
 =?utf-8?B?ay93S2JPZ0dOOXgxYkwyZHZsTStGZnZpdFYzejRLdjl5WExJUDVzdkIzemd1?=
 =?utf-8?B?NWVZZGhiS0gvOFR5b1c0MUtBOXo4eGNwdHpiQjlwNlBrK3JYaThNeWNVMlZs?=
 =?utf-8?B?dTB1cDB6UHN4ZmRnRjArQzFXZVFRWGR2djJKV0xnd255cEF0SkxFa0FKVG90?=
 =?utf-8?B?dFdwMUVsYlVmbjJ3dTZ2eTRLaTNSVnZYZ3dvSDBVL1M0NzJ0Y2RLOGF2Szdk?=
 =?utf-8?B?VWVSQ3QvT3MyS2ZybEZxeWg5RFByQ0JCdHBzVkt0d2Fqd3VFaUx6d01lbnFp?=
 =?utf-8?B?Uy9ac3lkMjVIZzdueXNNZlBpMjlSNjArZlp1VW9FNFFwRDdxdzZnMkU5cGZN?=
 =?utf-8?B?ZG5pQnNiRFBxQTZIN2FvMnFicmlVaEFPZ05xaHM3RmlxLzdoREoxY1JmOGwy?=
 =?utf-8?B?RVA3b0dmYnhIVHZwM0h5dy9qOG1oU3NlaWwvNnI3WlBxTmQ4ZEk1cVdsRmp1?=
 =?utf-8?B?QXdWNmEvc3B2ZDVhZWdYaG1vUXZFK05xeEI5Ry9yd2dXS2k3aHdPQWdJMWVx?=
 =?utf-8?B?V1F3QkQzVld4dGl1Z1dBT1pTOFc2K05jNDVyVmNmM0tGWmQ2MURxenNiVUxH?=
 =?utf-8?B?d29xMWVXamJqQXM0Wlk5cEtHUlZDQkR1K3ZhcExNL05SazdZWmczZVBIVUFu?=
 =?utf-8?B?ZHZUZW5XOVc3dXZydmdnZ2g2ZHBnNkxxaXB2ZGRqZVRqdStvTXN5Z2hBS1o1?=
 =?utf-8?B?ak5jTGMvckZjNW5tMC9OTFNXNEJRMW40andMU1hINDIxcmllS250SStSWlZG?=
 =?utf-8?B?eVUwTnBSdGRDZmY4SGtsQ05UdjhiOXlXbU5RL0RTMk4vbmhXZVpDMloxSmJL?=
 =?utf-8?B?a2MrRVVFanhocVRBN3BPR042RXVNV1U2Q1d3ZTBpWU9VeENpWjlINi9LTlhu?=
 =?utf-8?B?bDBVV0s3N2c4R2pVVTB2cDJZajNSY3RiZ0xOdG5WQkdWb1pNSFhxSWpyakdn?=
 =?utf-8?B?RktHcWVaNVM4MW1JZUxsdHhGbDhrbERNODdWTGRPY0dXaE5pdkJhbVkyN1hq?=
 =?utf-8?B?YWhNYXRzRFFveDZuZVNuOTZWL3BlblRvaERrVGptZk1iQWZIVHRZMmhQcEEy?=
 =?utf-8?B?YU1TT3dRdmNmNzR3ZlRyZGZIblMyOFdSa1U1Y0JtaEl3TFBDemhMVVpBRytz?=
 =?utf-8?B?RU9EUGlRK3F4clBhNUVUbUpmdzhRTW1rb0xGNFM4YkhVK0pjR0xURGZOdGFa?=
 =?utf-8?B?R2RmUVJCcExlS1ZQSWxlYWlGd0hFaXhBNXdzQ2NWcWFRVnIzR1RuVThsQ1VQ?=
 =?utf-8?B?TWhOalBJU2hpNE04eVFzTzBKMUFERzRLZmtZQ0FpeTJBL25lTmgyaU03UDMr?=
 =?utf-8?B?Vk0vUjh0YS9sckVFUFd6NTdHejRtanFuMm15MjY4cWZYV1FBVFBTYzk4YTc0?=
 =?utf-8?B?eFQvbmJRRng3Mm1KaW54dXA1eXA3TFpLWWtoN2MxWTdXZWo4RGJYdlUzUndm?=
 =?utf-8?B?VUhqRkltZS9USG5zZzJBaXBrRVFIcEQvdXpJVHNUYW5RdzZZY3B1N2VCb2ph?=
 =?utf-8?B?WlJHT0E2RGFMR1BpTHM4ZDZyeEQwQXlSUThSTndhWUd3Z2ZSazh1ZUlNc01w?=
 =?utf-8?B?Wmt0d1VWWlV6RG9hTjE2M0ZuK0FvSWRJcmkwMFBQRC9SemxPdFd6ajk4ZkJq?=
 =?utf-8?B?UzFjbm1iYktoOUxlYkM5VHFDNml1Nno0aytVUEdPL1Y0U0VzYWlaL0RQbmxT?=
 =?utf-8?Q?dKmGfw1WeSqLPYemF5S4mpL2c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade649d2-9415-4eab-01d5-08dccc1c2f33
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:27:40.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp7XNki8KTeynokr4dStlLeqFJNXRu4Uirvoj7JMzjtVThfo2EV81CK9HT+9yRtlI2ZlLlVsNvf6XvoQewRlUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478

On 8/30/2024 19:39, Luke D. Jones wrote:
> The original quirk should match to GA403U so that the full
> range of GA403U models can benefit.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/amd/pmf/pmf-quirks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
> index 460444cda1b2..48870ca52b41 100644
> --- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
> +++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
> @@ -25,7 +25,7 @@ static const struct dmi_system_id fwbug_list[] = {
>   		.ident = "ROG Zephyrus G14",
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA403UV"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
>   		},
>   		.driver_data = &quirk_no_sps_bug,
>   	},


