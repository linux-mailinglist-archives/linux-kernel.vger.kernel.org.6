Return-Path: <linux-kernel+bounces-333196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D697C544
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAA1F2286F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96779197A88;
	Thu, 19 Sep 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dM+lmyGq"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020094.outbound.protection.outlook.com [52.101.61.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7F195B37
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732125; cv=fail; b=AWh5jtp+SMVW1u8fL25zH6VHqFVM3QXF6hAlhTMcIVlPcLEtRh/X03WveTsrS/rcGszi8KlU5CqNeUEn5kHmmqnDEWbBHHg1zBpk280ht88Dzbtkd0LmmbxTHIEQH2UlvFMe990lObdCv0OnUxXRGwlYx55oWWNSK3QKk0cA6jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732125; c=relaxed/simple;
	bh=28dEbpQ7Z4T/FNAnDb5JXjijb/fxgt43slBF5cTS+vg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fg685KJq2Rvb+sbUwotoBGSOzBwomP4wjAanSVpg1RwLia5tFNlRcAwnOGm3fJQawT7hU9d7gQym2fsN7jrW7rU2NOqN8NZby/TPf7gPc5nB6n6wSHJwt/1yKi3OjjZUzsVQA34Xsx63TvfXBQJIptkYG2WDTEL3N0d3SncGSfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dM+lmyGq; arc=fail smtp.client-ip=52.101.61.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMtbGC/goo7/fT5Hulgn7yjqoBIL4lfgDhgdyIh1MFmRlboAvYd2fnbR+mX43AYmwM3jaaMH8gvo5OGv5HwcWVoRiKbnxPURHzoWLvoWkKelVSMQ9iTaoRVLKhcAtMHknx77S/uvjwtx+g9WHkjMaCEvBmgSunV3AAadhVBn2tpZyNAWVtZxvc9pk3VyfS5EbCoMSC7y3xWB6+UxIu3i666OUrNnu7hAlrissviV3SrCVHW3Sri/1W+Kj5ejNnlAKUwQ14gX9PQa5yhLTDRzAU6mzVxn+/nYIDmuCyhyF/rOs8osjk65nYidIKb1I/a96UrLL89llcY4f7DA7UFBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR3S6ATFg61UicvRSjlkJxRjpWf5I6Oi/49bkBsGQY8=;
 b=QPEirNDWgYauCu+IGWIMxXz4qiKdIf39mJxXuJAwCIb7lmiYMzhj9qoJnW/MtBjn/QD9Bk5Y9FCmDzZF8ZEJNPupEfM3GS4xqmAIGhBa5KI8Ulsf8xC9lmP3nXJYdBGkTBdXMF70OmgA3t9gm74Wfk+mmkMz+4D1nyIGyE7P5j3Ml4iDGZeoZBs9ucs1vXiwVO519JMR8dzXTowZ28t/t/ojrbe6nGZoqQieh2r9Vw2Xzvm5kzDlXdjnaKg3hu6+eoVzZiqUhfb/cpCtAMEG04uG0tC47ruuAynPOtZdwuZyLa5NiVZDDmjIC9/M1dtBYELiv8jUnfnUvhptIP62wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR3S6ATFg61UicvRSjlkJxRjpWf5I6Oi/49bkBsGQY8=;
 b=dM+lmyGq2UAgT4i/QR0siBXmsWAazvjZHBY9NaBXzp+eYynjITzHzIHSk6lQXJpgWbbt1+DvO5sa+EQqjS0ALzKYCOasYQDXn7UfJr/tRsJy+Y07jDITsglGkN2COVF8nN7zF4nxqBwU4zb87lBZH5l7f4Ewmajx0s+NQF2/xoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MN0PR01MB7681.prod.exchangelabs.com (2603:10b6:208:378::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.23; Thu, 19 Sep 2024 07:48:40 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 07:48:39 +0000
Message-ID: <4656ce44-cfa0-4aed-b45f-001bd3d437ea@os.amperecomputing.com>
Date: Thu, 19 Sep 2024 09:48:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH 1/2] hugetlb: arm64: add mte support
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, muchun.song@linux.dev, david@redhat.com,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240913183404.3517556-1-yang@os.amperecomputing.com>
 <ZuhP80DOWipwB0AR@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZuhP80DOWipwB0AR@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0289.eurprd07.prod.outlook.com
 (2603:10a6:800:130::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MN0PR01MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d37c1de-3216-49ed-b425-08dcd87f79bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUVmcnRaQ28rL1diOHlLNlhlWHdsVWpqdFI0T2x5VnBJR0MvMm5SQVhCdDVh?=
 =?utf-8?B?Y0tmejd5SDRXNjk0TXJobU5YR05vNjZvS0dZeUpuSkdqWHNpUlZRUnU1UEZ2?=
 =?utf-8?B?WHRibjIrWk1tcXNPTzk4WTlzKzZIb1BMVzhNMGtBOWVHVU1TY1U1bW0zektD?=
 =?utf-8?B?WGJNa3BoZlErVm8vUEpWR0ZpSVNkNUNPdkRHdGFDSnYvTXgzTzAyV1JaOFpa?=
 =?utf-8?B?SHBYR2ttMW9VOGZ0eXRJVnRpcVBYaUxGem01NWpaaWpLdHJWamliOXZGN1lN?=
 =?utf-8?B?WkV4dkUxZEhFaFo0WVUxOUZwT0pKMXRkK3plWFNUOUZJVnQxVHVtZ1ViTkJT?=
 =?utf-8?B?SWdrMlNRNk5aQnRMaDFTWnhtRnZVK0M1bk41QzlaN2RoTTlpTjhKbkxGRjlp?=
 =?utf-8?B?ZTJOZEovMS9RNFhySW5XbnlZZXpEZVpnLzZ3cW9HcjhOL0NPdWhicEV5YVpJ?=
 =?utf-8?B?NFJoRzBIZ3JXYlpzK3pTS1pXSUptTXVxYVJpRlFUMGRtaWx4djFuc3NFVU96?=
 =?utf-8?B?TDY4Uy9TMSs2bFNrcUxXRHdDdGkveWl3cGwyem5ObEo4SDVtY0ZOWFNMNndS?=
 =?utf-8?B?ODVYNnZqZDY4WjlFL0ZVSVlwcnkzdWE0aG5pZ29aUUl0TFIwbjUrZzI2UkY3?=
 =?utf-8?B?T1JKc24yNU5oYWxOZVhOdElIYTkrcmNhVTEyZ3ZYL2hYbFNCMjJIdDAvM28r?=
 =?utf-8?B?M1d1N2ZNN1BPMEx0V0d5SUM1eTZpaDVQMks2Q1JaK1VhMEdsUTRCam5PODc0?=
 =?utf-8?B?ZXN1WFk0emJleEZlZXRUcEx5WWNUMjRlRHRIaXV0bWxjSnpSdFMwWjBpZk92?=
 =?utf-8?B?NklLeExyOUNNcjA4R212dzBtZ0c3WVRXTkVXNWxTWk1tRXlVYjlMZEQreTBy?=
 =?utf-8?B?blhpQnJZRHZDOGpxblFZMzN2bFdVVWlzbWFpR0JYZGR3bUNjajFMQndZU1FH?=
 =?utf-8?B?a3FYa1FJLyt3TjFEQWllUW9OUG90bkxZK3pIZkhBNUhjeEpVekhRY1VTU0RT?=
 =?utf-8?B?bjVrVUFvZExGSzJMR3RrWE1KcVo1WExhS2t3TmdLNjlWTGhTNHZaUk1QM1hN?=
 =?utf-8?B?MXIxYi9qaGg2dVhKQ0VkcDIvZWFZdHhvQmpsSEFlL1pZSktJa25NRU11VVlu?=
 =?utf-8?B?bjNTbHdxS0R2ZS9EZkZUZjZXNUp5ZUVUL0pNRVczQzMzOXBxYXU0azJpQTZ6?=
 =?utf-8?B?OG1aYjl6SmFpQktZTU1XVFlCZGQxVGp0Ni85YTRlZ2QvOGZHUjhzU1QxS29U?=
 =?utf-8?B?UUZiVlRUczNyL2ZZSjRwV0FyTjQvb1h0VkJncnlPMEx3Z0lxU1hCSGVXRy9S?=
 =?utf-8?B?aStISnhleVM2OGl3eEcvRUMvV015b2ZkSHdWYlhXdUZpckZQR2o2dXJvRVhC?=
 =?utf-8?B?VGhQRkVUSi8xbWgvMjN3aFYyVTVmdzBjcXN1VnRRZEVHSnFWR3JPMEZrSkNE?=
 =?utf-8?B?czA2R1FBd2hZWHZXcmk5Z3YwMUhBZDl1RzBnTnp2V3BrMEd1L1RIcThPMmRW?=
 =?utf-8?B?MHhlZGUwU3FieS9jeXhvUU9xalQ5WWFyeHB6T2V2cytVblIwa0VPc1VwQVdj?=
 =?utf-8?B?V1p2WjhqamwyUjRtaWowQXFsOFNZbWMvQlNiRzlaUXlyM3JBOS9uN3BqOUVS?=
 =?utf-8?B?eFkyanBYTDB5QmV1Z2hacnRiV0lBT0R4M1FPSG1zRHJEdU0vekpSL29MdHFm?=
 =?utf-8?B?TEhoMGV2NzVQeGYwcE15d1oyVUdDcVppRnFveW5yK2U0MXR4Y0VrRFNNUlJj?=
 =?utf-8?B?akxLMmdudjdLRVJUMUNFbDBvUVlGQ2E0Z2M0ZS8yQXF6bzRSYXZUdnFlWEEx?=
 =?utf-8?B?TjNOVE13bTI4VWJRVkd3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG9uNkVvdGJRZmJydmw4TldtdnBPNnhNdHovS2JJaytHS2Z5WEtFaFdpSk9S?=
 =?utf-8?B?NHZBT2dJK3BQTnBiRUVkUXVZZmxxRXUvN1dUS1lwNTB1V1BoV3lleEVsLzNa?=
 =?utf-8?B?Tnh2SFowaTRGRHdCL2tMeVdTUFpid3BKb0ZwUHFnMVNMdTFkQ1pGczZpQzRm?=
 =?utf-8?B?VzlGRy9TZFJpclNvMnJUUk0ya29Rci9jZVFpQXB2UUlmS0RxN0JGcGZUc28x?=
 =?utf-8?B?a1daOUdRZVlWQkMzUmZHanhtc1E5MkRSSDE5aGIyaU1uRnhwWWVNMDYvNDBt?=
 =?utf-8?B?RlZOWER6b3l0enhhRHNGOGZHYnFnQm5TY2ZmZWJWUW54dDYwYUxtUG1KWkNp?=
 =?utf-8?B?YjVtTTg2b2QyUEJkVWFtVG5RbENFdTNsQWIyK3lkQnl5UTRJUk4rZGc5aW9o?=
 =?utf-8?B?YTMzTVRwWTZxaytySDIvY3JaUUtyK21IWFMwWDh5UkpuWXFWSWt3aUszNlZY?=
 =?utf-8?B?OXN4VmlCVTJldW5DRU5ReW44TWRkazkwVTFvdEQxVDhPY2ZvcHRvT05mODlp?=
 =?utf-8?B?Rm5icm0ycmVTSXBwelE3a2pLeWp0cU9SWWVYWjRpUVNvZ1lJRWJoUitLN3lH?=
 =?utf-8?B?YVI4RWNUZGNyUGhDRGxzQmNLbG9PalNpYVhvRzBNUTZRRUhtaXErOUZUc2xZ?=
 =?utf-8?B?YW5wRnpQT01PV1J0MGErV1FTWDJQa3NMOVdTcDl6NTFaSWVWeWhrV05QaitO?=
 =?utf-8?B?UjltSHJ1Yit0UkRpZDR3S0txK0ZIZllyYk9RRUhZOWZ2b1BQbGV6TmV3ZHUw?=
 =?utf-8?B?Nng3SXh6S0lKaGZ1VXVxbFhHVFdQUEl3WUlqNHZoWEpxNkMraU5tUUZqRjJM?=
 =?utf-8?B?aHA0QkdnOHVKZWNDUXI0REh6ZVNxK3RSOEM3c1ZCS1ZKNENYRWtrblA2bjA0?=
 =?utf-8?B?Z0dzRjF2elRnQ2MyemRpaG5MUUZ5QlA4VnlLNnk0RE9Vb3RBdE5YWkNyS2o2?=
 =?utf-8?B?eFJGWUs3WlZYcGlYQjl6aEdyT2cvbS9GbDh3d2tmbEFZN2xmVlNYdXp4TTZn?=
 =?utf-8?B?Um41V3ZzdDlRb2J4WFY4SEpOdGoyQlNCa0VLSFNiR09vVnJleWMzVzQzYTRn?=
 =?utf-8?B?ZElBcUNzcDl2bTd6cTBsWlI4cmFwRFlmNGJDQWtpd083Yi9XUHZ2OTQ2TU1x?=
 =?utf-8?B?VTBEdnZ1THFmSmJOV0U3emhudnBWV3pQSHpQbkhEOUVKR2hnYWdtTmhvaXVn?=
 =?utf-8?B?YnZmRmx1VEd3eEEwVDFuRzgyZmMwVWxIU21LUjBJYTJxdVFTVmpSVU5qeVo5?=
 =?utf-8?B?b2hlK21nTEE5cVQ1cHpVSkpkTHI4bDBNd1ViLzlmdVVwMlhnbU1kYzRHZ3Mz?=
 =?utf-8?B?OTgvY3VFbzhBVktwNldwcDNGTzB6YXJBRU1RczE1U0lqTVJMSkdBaUhXTHhS?=
 =?utf-8?B?VHdzRVZoY0xKTlN2VmREQ3FaVTBjSzQ1eERiM1gzWVVaWWIvWml5bVNDcFl4?=
 =?utf-8?B?TEQ1QkVUSGlocG9HZ05RdDBrU0NlUzRGZSswY2VsVXhHV0JHU1lMU2l6bzlt?=
 =?utf-8?B?aHFBd25hbzhMRmZBR2t6Nnp6SU41WXFTQ0ZmQmlHYjE2YS9ZSmFGNm1MdTI3?=
 =?utf-8?B?aGgyRUxwYmxCZDlobXBGNlFUemg1YkFFaXhVRWJkNk9KL2EyUW4zY2tWMERp?=
 =?utf-8?B?VFpydTFKUlQrdWhuWjgvUktiVjNYYzZaUDhSRnFvMXNMbGNLK2U1Qk1ybUxo?=
 =?utf-8?B?VDExNUsxRUhPZkpaNytDQkowOVZZSmp4ZmJzR3ZYbUNjVWo4Z1ZFKzNRUDM2?=
 =?utf-8?B?UFJTSGgxMFM4U0JGd21YaW9LNU92bk1VK1gyWW94ZGRzRUZnQkZKNkI0VmVZ?=
 =?utf-8?B?VWxmVmRuSjVvVVJaQlJRWmtES0RDM2dHRGpoQjVHcE1iMEhiWjMxV2RWNmEy?=
 =?utf-8?B?bTBrd3JYWCtlMHdTNGVWN1R4Vk5HdkNSbXVxeHRER280ZzgvcTNjYlV3aXFD?=
 =?utf-8?B?MlY2aHlKSDNPZDUySmRjZHdmTDBzWGxJcWZwY1V4S21KN0pzeWk5ekpXLzVK?=
 =?utf-8?B?dmJXZXNDai9JZzJsL3lrWHNiQXdKcGpBVTJtUVp6QkorMldjNXo2QkZlR0x5?=
 =?utf-8?B?RTIrY2tidGJGVnVEbHZFK1owMUNCb1N2c1hpUFJkRG9VQVFUU3liWU5nV2V6?=
 =?utf-8?B?dE0xSjFnL3Mwd2tkUGFucjJpRkp3Q3lVWGtBZDBSU0dsSmhSVTZDakNzSHVz?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d37c1de-3216-49ed-b425-08dcd87f79bd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 07:48:39.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5teY2v/mtPe81Gpm0sTzDHfRmg0S7U/z9xejkboeI4TOikIzNIfVNbZ7D2fcOUS7+Q3YbRSkA/3AaaeTJTAIO2W/trxLVW0DBaiI+eVsc2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7681



On 9/16/24 8:34 AM, Catalin Marinas wrote:
> On Fri, Sep 13, 2024 at 11:34:03AM -0700, Yang Shi wrote:
>> Enable MTE support for hugetlb.
>>
>> The MTE page flags will be set on the folio only.  When copying
>> hugetlb folio (for example, CoW), the tags for all subpages will be copied
>> when copying the first subpage.
>>
>> When freeing hugetlb folio, the MTE flags will be cleared.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> The patch looks fine to me:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> You may want to rebase and repost after the merging window.

Thank you. Will rebase and repost it after the merge window.



