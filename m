Return-Path: <linux-kernel+bounces-348114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7998E2AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED69B281057
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B722141B1;
	Wed,  2 Oct 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VxnFobcQ"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF31D173A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894216; cv=fail; b=CFiWJEPLwf+WCkzpOmjXt4injiRoYDi2rjQubiHFhUATYO7sXBVSqztgSGgO2SRU6nW6MN5DZ4ZqjzoolxHaTowGxYEpV4Jq5t1fIAYjOFk1khWi9y+8qgx4qpJkkFzxTLLW7WTNOZyKpgkqfsLSoMJ4YBP5n40RMFN+zr75pTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894216; c=relaxed/simple;
	bh=B4M7ipmf8HD6rzhNEaNUpOH2FS0mie/5fQVMXzbvXrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rD8A28XKAbHyK0fwlefoJq347rCO/kug6hKectCokSJoYA899MMF+gLPVrNO1U4mSxLqv7LGm0SEKUXeC2PMzbSar78vn2unlkc/NZOmTXK+CGda9t7tVPQqijtXC7neEUyIveFiNInYoDrKfl1rwFGgThz16vNIM+w7bLf5YwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VxnFobcQ; arc=fail smtp.client-ip=52.101.43.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1dpmsRGaGtETl/l9vuovHiLJP/brnkX7VzxKbT328I5xXhcmmyHTsja789Dp1UrLObbQfudN6kkenlBF6SsDxM7hTuR8v/Z6iEBbFYb2YsFoCCHZ1LrfefqqMUZs4R2TTdbX8KtSTKMR/t1SlsBWJU5CguEhYjt49axTjHMv242kMlWjr1Ce9K5ovTH9R4qsBosvKEGRH0B/XPhAdupA1P8STYUOxQR3oQ5iZ9jpza0y37WySS9HRNRI/NsNWC6rHkd0Wk4duUns0RGeJcdfnZJ4S+azXr2npn3lYRC3PJr68Xp9F4lIPSqEFPaxMz+fbiuWjdqXT3NZmX355M8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFz3SCFAGLqPehfntPfsLCd7EwKN1me35dprABZXQEw=;
 b=j2arFmhW57nOCy0em84MpshjO53rzNrJHpYHSmjMaNDWVQYbAWr0GXosCDaeKxWxiUESp4MlUWrMwQKtdbtK29be5OMs7qbO5/y4AHGXWm3TBa4diSWDtehM1QY7N1Tfbf6ov2MYXk2o6qEWyJFtdjy/6ac5U2dQP/tNHGeuFLpTPyTEAja8otw5n+/S8KH6SUYETjOXz5z4NSraZM+xVO1iwP3XQsrVNRNpzbT0mBvqwCOXetg69yXZOHZfec3UHEvpzKaF3bLj7eEN67n4e2T+zUUvF7YBPgcrpeodPFKZ5BQYSwMHOR0H8RP9U+r/V7JLUss//Eq/hcluRbLkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFz3SCFAGLqPehfntPfsLCd7EwKN1me35dprABZXQEw=;
 b=VxnFobcQFyd1/pfrIP6Bt3Jet93E7JyWAaxfyrNQebgOQgB2jcyA7+3spZgshTcL5VQiFv882fMYz7/x7J3qJYT/TMU77cgBTC0UT4X1zrr+6c2wWtNQG8u/vfGW1Kvc8y4iV4c+lRjq12Hc9fhGY/XM09X3WZQm8fco6UwMor0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB8642.prod.exchangelabs.com (2603:10b6:510:308::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 2 Oct 2024 18:36:52 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 18:36:52 +0000
Message-ID: <1058a058-ea71-45a3-aee8-5c9197e5f3f0@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 11:36:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Robin Murphy <robin.murphy@arm.com>, jgg@ziepe.ca, nicolinc@nvidia.com,
 james.morse@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <0a0c6d4f-e9f7-4fe6-9bb8-25772856c345@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <0a0c6d4f-e9f7-4fe6-9bb8-25772856c345@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e3da97-bb65-42af-78b4-08dce3112eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjFnS2ZCaTFyZlNzcVZ2d1VIZG4zQUluU21hQmNubk9Ha25QeDVLdkhJOFJM?=
 =?utf-8?B?Q1JySTBLSnpaMlo4QllqU0krMEplNWZSanAwLzVHb2ZocVdKekdXT2d1WHkz?=
 =?utf-8?B?TkQrYyt1M3pwT0UwRVVIWGRGRUljTVF6WDRzVDFxd05KczYrMEREWGYyT3BB?=
 =?utf-8?B?cWVNa3BrcEx1TVp4enhlVHpqMVU3QXhYcUFjRnd1VDI3UWljSFRkbGMvdG1K?=
 =?utf-8?B?QWx0RW13U1A2Z3RRRUlvWXdWYUpwbnZyWTZMckw1c0VlNTR0Qy9oL013TmRt?=
 =?utf-8?B?T2UwYXRkTE9YK1EwbERTeDV0Z2huYWxISHIrWGZSTHMweG1jMkp5N0dBNnNh?=
 =?utf-8?B?cEQ2WC9PMmRXdDZBU0I5V3FuQVdHS0EzbGh0a2VLVitLNDNETS93ekRra0dQ?=
 =?utf-8?B?aUhERDhEWi9OaTdKcm51aUpyelpQTWtlUHNOeTVlK1hDblorVDlaZzhxdFN1?=
 =?utf-8?B?RmliOFFadHAvWHZLTkd6QWVvdGhsdDJEOEg0OXBYYXlYOU95NlpFVGlNa3N6?=
 =?utf-8?B?dlZKUzl5UVYxd09sYkk5TmdEc0paNlRQZzN1RjM3bWhXeDh6UFFUWWhaZXAz?=
 =?utf-8?B?c2s2S3N5RkpiZTVaeGxBOCszTXhSenZ0T3NlVDhOQWhmQkoxY3ZpRWZkRXFT?=
 =?utf-8?B?eEtoQUxoNUJUYkw0S25WdGRpSXp1UHNwa0c2WXZ6K1Jqa2NKWTBxQ2RYNEdo?=
 =?utf-8?B?MSs0N1B3Q0k0aDU3T0t5eGJQN2FOQ3NDc2c4YVREeksrdnZyR0tibWZmY1V4?=
 =?utf-8?B?ZXZHZ3ExOVZ4d0pwSDdnVEJRMDdzdkJWdm8veUpWTHEybi9NcXRwZFZtSzNR?=
 =?utf-8?B?cFRkeXNETnFIV1hEMHJGQWZLVW9XOTdVbnBhcGp4UlVVTUIwV2JGL0NzVkRE?=
 =?utf-8?B?L2RJSG1lbnRoMmJwVnIwb1FzQUI4bzBCMlA4Q1E3Wmt6clFIL05wVmtvN081?=
 =?utf-8?B?ZlArM0k2VXJIaGwrekdtUHBuZU5tSi9GZjhsY1pnUmE3Wjg1RFdpOW56dXYw?=
 =?utf-8?B?NnJ3eXlXYm8yZlB2VHpOS0xhWkZtNVVHNU55WVVuOTdUaVhYdDVxcEd6bkdL?=
 =?utf-8?B?SE1vdjl3UFNuZ0daVmVJM21ySnZvUkFXWWkxN0FQZ0tYZVhuNHBpV2pzSDJr?=
 =?utf-8?B?WWRTUzVqczRZbXBMOVpVeXRmUjh6SEd5Y1RFNW5CL0lmWWhJYzFnZG5SbVp2?=
 =?utf-8?B?VVB0dUtVSm4ySEtTblJnOW5UZlVCR2hSbWI4NFhERDVSbThXRyszT1ZrWFFX?=
 =?utf-8?B?cTVNL2pHeWltKzJlMSt3cEl6cjhHbjFENjdJa2VyajljY0Fta2h4eXl0QUs4?=
 =?utf-8?B?SDJSb0RiMEQzM0R5aGdOQ0Rtb09PR1ZHUGF3dU5sVnhGTEhTSmhXU1FscDBD?=
 =?utf-8?B?TlpYaTl0RXdUdS9FalFLanQySjBVdXM2czByQU11Rk9BT25aTFJ4OHV0eXJS?=
 =?utf-8?B?RTFSUGRaSmVCYVFubEFxVUdiYmpiRUlqM2h1VzhWVHUyRWZGdXl4RzBNdENk?=
 =?utf-8?B?eUQ2TWN1YXJvY2RIdTVaLzdPZGZ5UkhKYnN4UzlyWlBhMnp2RmpudXY5MUdq?=
 =?utf-8?B?NjU4NExNYnRGbmZqVE9nZjJOYldVU0ZkVndxS05mRjY2cS80Tzg4WmhYcEV6?=
 =?utf-8?B?VktPV3c5VU9rUVltSjVzelFLWmNFZHk5eURxL0JGRmlqaU5pMHcxRGw1UGhQ?=
 =?utf-8?B?Z1NEVUg5RGJmUG5kdkRWYU1PZWhOSjRNdjk4elZLcUhBb05nNGc4RFRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0FKRS9iQVR0ZmxJRmEwZWtsQTY3eHZYQjZtaTMvMXMyWnl2c29xaEkySnFh?=
 =?utf-8?B?Tk90VE8wQXA4c1NPR1lwV25JQ0kyeXFDS1d2K280WTFzd3dLdEhpNUVKazBy?=
 =?utf-8?B?NmFwNHpNQzJGUGIxSlJHcUQxZThneTM4eEo5d0NYOVJpUW81cW5xVC9EVWdW?=
 =?utf-8?B?d2NwUjM5bUlTZ3RDajB1S2JkUXoxMThFMThTNnd4cy9SWmlvSGpKZ2lPWnMz?=
 =?utf-8?B?ejNld3I1dG9RUittNUVUYWVvSWtWaDhVeE9nQ1JxSTJoeTlJdEp4bEpFdHU3?=
 =?utf-8?B?VTVvdG1obzRUbzBRUWFWV3RpSzh0SW9HU2w4ckk5YTU5NWM4L3FocjFKZlBp?=
 =?utf-8?B?WjJGQzhFbVMvTFJ0K20zdjRnVDl1NE14b0VlbjdPaGNaK3NWOEZPeG11OGo1?=
 =?utf-8?B?aFhsOWFqZW1NbDdTd1Z0eFZRTHpoaGRGeU5vRTRHYWhZL09rSytreDhXN3ov?=
 =?utf-8?B?b3k0V3NPRzhxd0d6S3B6czhPVWM4a0NpWnFzL0JBUTRUaUJqMzNpR2hRcGlN?=
 =?utf-8?B?NytZR3h2Mms2VDhkbFRRM2R2SDAraGV2TE5MSjhuN3V0Nm84N2liU0c0LzJB?=
 =?utf-8?B?ZWJmTnRHL3FjYnN0WE1VNGZ4U09CNDdqQ3NjS3paZVJTNlg3N3pIdlVYeGhN?=
 =?utf-8?B?aVV2RVZtcGVudGE5YUg5YkxZYktSNmtpTjI2ZFVwTzhRMGRNSllyY0x6Qkhr?=
 =?utf-8?B?amJoU2ZLM0tFZkk3MTdSbW1PQ1VaaXRvWDBuUFJRZmxudFJ3Y1VmckE5MzhM?=
 =?utf-8?B?NThKazNpdll6L3E3ZXo5S1ByVitTZExnK1lsdSt5dlBKYlRsKzdvM1poTzBN?=
 =?utf-8?B?REwrK3VuTFBpbUZmV1RDSkh2Nm1saDl6Nnc5VDcwRVBNbVcwdlFvS2hhK2Jm?=
 =?utf-8?B?dmdYWGhOWUszYlJZMWNVTG85b21uNFVDL0UzZHpEVGo3L2cvZnUzUGM1MG56?=
 =?utf-8?B?NWZMdG9DVGFpekFwMVJsRWVoS09CZGk3R3pub3lOcXNvZVRVVUdPU2hsbmVM?=
 =?utf-8?B?TWtUMXBaSWlDSmtMU2JETlV3UWs4VDBpOG4xR0FxdlRkdFVGTzVYMTVLeWh2?=
 =?utf-8?B?UUMra1Jmd1lZME5lQkQ3N3kyUHVnVUNTTkN0VzdnK1RSYXZudkpGL3NXYVVy?=
 =?utf-8?B?MWM5akJOdjFFL01FYlBMVVVlbzdkSEd6ckVYQ1FzV3BqTEJmSkZJNHVWY1dU?=
 =?utf-8?B?V1ZVSVp3MXFMNnRKRlNrbXVPeCtGRTZ4cjZUcU56UEEyOS9rRG9nVzJVdUUv?=
 =?utf-8?B?eTZ1dzJ4SVpNa2FVbzhkVFVGUlRCbG9vazdpMWNSV0FGb3FTZzN3WCt6UGtM?=
 =?utf-8?B?Tk0yQlZtbHRmMzArNm0rMEg1UWJSYWtMTlh2ZjhiZmRYN1JXUTdXUE9mbVJa?=
 =?utf-8?B?OGkzQWZYZm5wQUswc0hETUhxNXVmL2NSNG40Nk8wR0hFVEdueEs1aUxPUGwr?=
 =?utf-8?B?NXJKNVAwbVFhM3VISmM4S1M2ZHhYWFNldXhobXk4dC9lQUNINGhkNFlRNkZB?=
 =?utf-8?B?WTA0OFZ5NlJzMWxQcEpySzJiN09aOFNIN21sVVFWRkR5dmlTUk4xUkVuT3NJ?=
 =?utf-8?B?UGtvZ2Y4Wll1ZFJZTkpOVjUxSm5qUUlPVllXMklUbE1TN1lzc0N6UkNhTm1C?=
 =?utf-8?B?SnoyZnltQTAvaVpwUGRLMzFwY0VTdjIvdWxtN2RNQW4wckFoaTl2OURsbXJL?=
 =?utf-8?B?dEViOXBYcVYyQklkZGJiMWxmZWczUHcyNkVSZjdkK25sSERKRlNMc2MwOFpz?=
 =?utf-8?B?RzJ4WGZSYkpLRkQxWS90a1RxZEQzMGN2MzF3UzRTMWM3R29lMkt3eUhuZ2ZI?=
 =?utf-8?B?Ui9yWlJSZWVCelZkWFZqT3hIMjBweTVtSkkxaE9LQkovQUVDUDI4bXRkSy81?=
 =?utf-8?B?dmZyMFpFcURNZUdQVWNVZExxSllyZ0FmV1VRbWh6SWgxS2FSSnI1WTcxQXg2?=
 =?utf-8?B?T2s5WU1OMEFpbHRJcDFYMUFYQjg1bTgyR3BrTHdyNjVMY3UraFdXVC9LSUxs?=
 =?utf-8?B?dU1mQklaN0tzQXpHNWYyTGpCb0JHSVRHa29DRjF2NnpSUTVaR0xVQk1aZnBC?=
 =?utf-8?B?ak0xZ3I2Ty9mUVhveDc1ek9seDI1NjhWend0d3lYbjVIdG1MQzZwNjhsOXVr?=
 =?utf-8?B?ckIybFZ1b25xbEw4THVFTUZNRCtXMTRWS2lvaXg4Vk9wK1hQak5UcVFQYWNJ?=
 =?utf-8?Q?S7iNwjXsg72vksnn4jKoO1M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e3da97-bb65-42af-78b4-08dce3112eed
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 18:36:52.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOWdalE7/V6UMRf4BtFlVGyz2Zd9e+Vvwo//g+eIQpswiKcAzralpgD9kwh/3JgkpjUIaJpILrKkKFminqhe6texobxNu1p9y0YgCa5h7wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8642



On 10/2/24 11:21 AM, Robin Murphy wrote:
> On 2024-10-02 6:55 pm, Yang Shi wrote:
>> The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add 
>> arm_smmu_strtab_l1/2_idx()")
>> calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
>> is 32 bit value.
>> However some platforms, for example, AmpereOne, have 32-bit stream id 
>> size.
>> This resulted in ouf-of-bound shift.  The disassembly of shift is:
>>
>>      ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
>>      mov     w20, 1
>>      lsl     w20, w20, w2
>>
>> According to ARM spec, if the registers are 32 bit, the instruction 
>> actually
>> does:
>>      dest = src << (shift % 32)
>>
>> So it actually shifted by zero bit.
>>
>> This caused v6.12-rc1 failed to boot on AmpereOne and other platform 
>> [1].
>
> FWIW it's going to be seen on any platform with Arm MMU-700 since that 
> always advertises 32-bit StreamID support (as other SMMU 
> implementations may do too).

I see. Will add this info to the commit log.

>
>> UBSAN also reported:
>>
>> UBSAN: shift-out-of-bounds in 
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3628:29
>> shift exponent 32 is too large for 32-bit type 'int'
>
> At best, those two lines of actual UBSAN warning are the only part 
> relevant to the point, the rest of the backtrace below is definitely 
> not, please trim it.

OK.

>
>> CPU: 70 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1 #4
>> Hardware name: ZOLLNER SUNMOONLAKE/SunMoon Lake, BIOS 00.00. 
>> 2024-08-28 18:42:45 08/28/2024
>> Call trace:
>>   dump_backtrace+0xdc/0x140
>>   show_stack+0x20/0x40
>>   dump_stack_lvl+0x60/0x80
>>   dump_stack+0x18/0x28
>>   ubsan_epilogue+0x10/0x48
>>   __ubsan_handle_shift_out_of_bounds+0xd8/0x1a0
>>   arm_smmu_init_structures+0x374/0x3c8
>>   arm_smmu_device_probe+0x208/0x600
>>   platform_probe+0x70/0xe8
>>   really_probe+0xc8/0x3a0
>>   __driver_probe_device+0x84/0x160
>>   driver_probe_device+0x44/0x130
>>   __driver_attach+0xcc/0x208
>>   bus_for_each_dev+0x84/0x100
>>   driver_attach+0x2c/0x40
>>   bus_add_driver+0x158/0x290
>>   driver_register+0x70/0x138
>>   __platform_driver_register+0x2c/0x40
>>   arm_smmu_driver_init+0x28/0x40
>>   do_one_initcall+0x60/0x318
>>   do_initcalls+0x198/0x1e0
>>   kernel_init_freeable+0x18c/0x1e8
>>   kernel_init+0x28/0x160
>>   ret_from_fork+0x10/0x20
>>
>> Using 64 bit immediate when doing shift can solve the problem. The
>> disassembly after the fix looks like:
>>      ldr     w20, [x19, 828] //, smmu_7(D)->sid_bits
>>      mov     x0, 1
>>      lsl     x0, x0, x20
>>
>> There are a couple of problematic places, extracted the shift into a 
>> helper.
>>
>> [1] 
>> https://lore.kernel.org/lkml/d4b53bbb-333a-45b9-9eb0-23ddd0820a14@arm.com/
>> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add 
>> arm_smmu_strtab_l1/2_idx()")
>> Tested-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 +++++
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> v2: * Extracted the shift into a helper per Jason Gunthorpe.
>>      * Covered more places per Nicolin Chen and Jason Gunthorpe.
>>      * Used 1ULL instead of 1UL to guarantee 64 bit per Robin Murphy.
>>      * Made the subject more general since this is not AmpereOne 
>> specific
>>        problem per the report from James Morse.
>>      * Collected t-b tag from James Morse.
>>      * Added Fixes tag in commit log.
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 737c5b882355..4eafd9f04808 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3624,8 +3624,9 @@ static int arm_smmu_init_strtab_2lvl(struct 
>> arm_smmu_device *smmu)
>>   {
>>       u32 l1size;
>>       struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>> +    unsigned int max_sid = arm_smmu_strtab_max_sid(smmu);
>>       unsigned int last_sid_idx =
>> -        arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
>> +        arm_smmu_strtab_l1_idx(max_sid - 1);
>>         /* Calculate the L1 size, capped to the SIDSIZE. */
>>       cfg->l2.num_l1_ents = min(last_sid_idx + 1, 
>> STRTAB_MAX_L1_ENTRIES);
>> @@ -3657,8 +3658,9 @@ static int arm_smmu_init_strtab_linear(struct 
>> arm_smmu_device *smmu)
>>   {
>>       u32 size;
>>       struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>> +    unsigned int max_sid = arm_smmu_strtab_max_sid(smmu);
>>   -    size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
>> +    size = max_sid * sizeof(struct arm_smmu_ste);
>>       cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
>>                           &cfg->linear.ste_dma,
>>                           GFP_KERNEL);
>> @@ -3668,7 +3670,7 @@ static int arm_smmu_init_strtab_linear(struct 
>> arm_smmu_device *smmu)
>>               size);
>>           return -ENOMEM;
>>       }
>> -    cfg->linear.num_ents = 1 << smmu->sid_bits;
>> +    cfg->linear.num_ents = max_sid;
>>         arm_smmu_init_initial_stes(cfg->linear.table, 
>> cfg->linear.num_ents);
>>       return 0;
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index 1e9952ca989f..f7e8465c629a 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
>>       ioasid_t ssid;
>>   };
>>   +static inline unsigned int arm_smmu_strtab_max_sid(struct 
>> arm_smmu_device *smmu)
>
> Nit: "max_sid" implies returning the largest supported StreamID value, 
> so it would be logical to either include the "- 1" in here and adjust 
> the other callers, or instead call this something like "num_sids".

Will use "num_sids".

>
> Thanks,
> Robin.
>
>> +{
>> +    return (1ULL << smmu->sid_bits);
>> +}
>> +
>>   static inline struct arm_smmu_domain *to_smmu_domain(struct 
>> iommu_domain *dom)
>>   {
>>       return container_of(dom, struct arm_smmu_domain, domain);


