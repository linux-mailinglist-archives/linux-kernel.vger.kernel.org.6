Return-Path: <linux-kernel+bounces-236784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD591E704
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F175B22B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178316E88C;
	Mon,  1 Jul 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aRGCojjg"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34816EB75
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856687; cv=fail; b=cgNwVGaYwlD5p0T0CBxdiCJpLqS+o1Oc+sEXwD5xc/69UJYjstj3d8//mGS+qD2GK0xpfbjvjNO8jovKwKrBqCOzhGhKxkyLXQRiU9YcTax8EYgly2BDWoBVs36Hp2O5u/h+ooW6S9UEQB+Zbovmhlj/l9uS8Rv5YomJjzBOInc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856687; c=relaxed/simple;
	bh=wY+aqkQFEjKquMXvdxwZnrY4yS1Z+bgeZWKZ7nmYKAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYUEXJmwoXjA8fb7Ilc2cigBb7JIioBuH9EWMIYVqfE5U4ZNrEuR6EaOMofv00jD7AuXdrhFrKjQLtS2D1bjEGJzCdeWcLZc9jYhDHE8jjJHt5S0XQGn01i0uAp/I+8e/Zc7zSn9v4DfeB0PXWCsGMj9HcXuC43VaeyLzMGkTA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aRGCojjg; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWOF+rSLt/tVr9Wh0gyzYhjEp9+m2C9nVlQJMeTP4zTbj39YUDHjnEHZKbmcVRbinPLBvFrQTsczMAixbA5d63g521rq63snSlfOD+GkR2jCdPmd57bcGGG3CDzVDaIXK2n/0h4ompwHSxjpslTpM+ys/znAo6kz/Lbc2Odkac9drCDc8IdFJ+CiZhK8B80D2l+rKAWdoYChn0sRrtAKsJSiVNvMafOnSG7hfgWRuXzLWPt1vywFUlsVTYvI+MkYgIcXPPUIgGzxhTMDHWrm/V7pgffsAZTvvqWPvMZICEAd1Y0T6O6mYIWJK459kV/B1mIwpRU4AWfkjFgKr0I39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY+aqkQFEjKquMXvdxwZnrY4yS1Z+bgeZWKZ7nmYKAw=;
 b=cbyIIapLr+CLHV6fD0FCRw9yBdeSR1SZVt6daMMfZ/scnJCZmX+/q6jG9jqExIGDq3+ES3HWNeIZV3ZqmgkMntftnbYhiOKIYgcD9o4D/HqrCM6ZzcifH/dFO5vf0brSel7UzQU+SO/SQWRvIg1iI22OQVOM0ISIJjxUffl4bl069XCoDCO6zTu9KffUDvXpUbsQfx7R6XNoxLEwp2a6yv3UpECS3fjRCLMdluBrjgwe+etiRCvJKZlpR99haMdn6MepEEKMverncVnbNpd9gtW1I6QwwG2jFYOFfEIu8PvccnhcZ3/5uTt/QIjn45j2ejVQT3UjiJ8TM6YMOINkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY+aqkQFEjKquMXvdxwZnrY4yS1Z+bgeZWKZ7nmYKAw=;
 b=aRGCojjg65v6MCVgT+k0476CXEaTCQfjiAK1xp3FYCik1hXtTVMgczQtczQK5asxXd+9K9BRF/ZEKSMql0culHPrY/1cQUo95y1RjaCIt9hG36/KTzGNPVtLJ0LkK6OnAAF7lZd1UMHdF7DL73pkgIqPo4S63FRvb5cndA2dA+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 17:58:01 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 17:58:01 +0000
Message-ID: <5cf60d52-1682-4244-b892-688b22eaf4a1@amd.com>
Date: Mon, 1 Jul 2024 12:57:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Content-Language: en-US
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
 rick.p.edgecombe@intel.com, mhklinux@outlook.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
 linux-coco@lists.linux.dev, jroedel@suse.de
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::24) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: d59aa314-e34b-4d84-cff4-08dc99f75910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGZweExYb0J0QlBQYVdmSlQyVVFmUGdVSTZ5N3lxVWd0SU5YdjJJVGZXdC9s?=
 =?utf-8?B?RUhXZzQ1RXVFNGtDQlFjOHM5c1h3b2wzNDc0ZlhxN2NEY2xYZWRzQzhpaUF0?=
 =?utf-8?B?djJRVFBMb2FuNXFiSDN2T3VSQXlmQSt4VVM2N1F1Z3dxeDdVWGNSNzJyWlJP?=
 =?utf-8?B?UjFvLzVGN0l6Qk9LWHdxTlNCOGFxTFpzbVRzVm40VVBzR2VwZ0kzcmpPbVUv?=
 =?utf-8?B?SGFTYXQ5dWN3MyttWUxQQThiSjNuZGowVnNXZ1hqcE9hOHRPKzFqcXVvcmZX?=
 =?utf-8?B?K2w2cE8vQXh1TDg3azNBSzdNRzUyNy9HWVoyT2lIREdWam5KSHR4cmxRTzMy?=
 =?utf-8?B?cmRuaGllSURLM3k4YTJiUW1aUUdTc1ZTNTIxbFk4Zzc2U0Z3SktLMm5SbmVG?=
 =?utf-8?B?b3Nta1dqUWpPMk85QmhSSURBY0R3NlZtbVFVQXBHbjRKa3FYa2FTRjhCdU05?=
 =?utf-8?B?eHRxdCtBZXVWbmx4MmhMSWhTSkwvc25NTGVuZ3UwemM5M1VCSnRkbnZnMmxP?=
 =?utf-8?B?bkxqb0hXa2loZUIyTS9FMjVLclN2aHlxQVN1R2FJUGgrb1NGNG9hSU9aSmNK?=
 =?utf-8?B?K1p3emVnQm9lTTVXbGxLNytObzhDQ1NvN25Ebm0wUVZKd3dpZzE2MWlrejRv?=
 =?utf-8?B?emRGMlpEYzU4dUE3RWx1SVNFQS9sSXgvemNoRWlMUmhQSVV2SnZzK1R2T2s5?=
 =?utf-8?B?QzUvU2FTMzN6WFV3cTF3M0IzNVlvZVh5bDNMSjh0Q08xb2Z2SDhHTEZ0b3Bl?=
 =?utf-8?B?d1hiWldFZlFNdjVQVXdkckUyTmxsWHczZGJuMEEvS3luUzQ1TmhUU3B4L3Yw?=
 =?utf-8?B?aENnQzZrdVErYk56NlpBZlFqbzhOeW5xVDNwVEpvTnlNUXEyMXY1d3pERW1D?=
 =?utf-8?B?eWtRSElicDdibWRrS21Wb1ovUW0rTVhsNTM5MEdzVVBrSzdIQTdBVVF1aEtX?=
 =?utf-8?B?V09BRW1JVDhDdFU4QVRUZlNBamtYWHI1b0hMMnFHOTJzRmpLRyt2cnM3eGJq?=
 =?utf-8?B?OXNUK2dXWnlTU3llMjV4V0FtT3cvdUhMNUN2OXlROU5CeVN6d2p3NFpJdUNt?=
 =?utf-8?B?dytKS01wUDVOZnlwUEdsd0I4Rmk0TStMdGlxc2kzQys5MDAwak9wWjV2RGxz?=
 =?utf-8?B?VDVZWjMwVlhMVllvVzBiTVRmWCtoa2ZIUVJzVVR2RWxySDRGaVUyVTB3ejFr?=
 =?utf-8?B?WlNOZFg0YW1BaGtNQldmU01ycFhhZGhBV1RmblE1ZTNZV2U2OGxsY2l4ZzZI?=
 =?utf-8?B?TnkxY29tTlBoNlhlNlRPdTlYc1lBR3U2ay9GTVBpakdpTThib0FZd0tkL2FR?=
 =?utf-8?B?am1TVU5SblF1Y3dHV3lmdGwrNlFHL1NaRW5xdHBkeEphczdIbjM5RDhZemlw?=
 =?utf-8?B?SjhKeFNzZmsxL05INDRHanVjTm14RnZ3Zzd2SXl0NTFkdUExK0pzRXd5MUc1?=
 =?utf-8?B?TnVCbzNTbTJZWXVJZEZQZE5zeFRNSFE2TGxnODl2ZzVDTzZWUW0xckxwcWdZ?=
 =?utf-8?B?blF3TmZ4TjNLV2dpU0lLMVN5M3dhRUp3RE83SmhmbHFpY0xlbC9zbDhwcnhF?=
 =?utf-8?B?a2c0dWpqNHRqeHBDZzh0SHVidnlaWXZnVForQ3lwcXp1S1NqVXJCYmxtWU5y?=
 =?utf-8?B?NUV1YW5SSjlDYit2KzJyNnpBZXNlSWQxeURCQnBSaVVXdlFMOVpTVXBlOFpn?=
 =?utf-8?B?TTZURldIa055dXZick5TTTNGbElDMU9aRGcybzhGWk4rODhkT2djb2VrUi80?=
 =?utf-8?B?Kyt2bjFkbHN5dEpsbk5yUHFEcC9uK1lsbmRhYUQ4ZXZNUWROeFRyMWVNOUh1?=
 =?utf-8?B?WTVLbCthL3Jxb1MvYjFkZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGZXRTA4c0dhbVlxc2x6RmhwTE9RMDdDZ010QWNZWkE2UGQ3TGs0VUtjWXYx?=
 =?utf-8?B?YlgzaXJFVUV5ZjJvTzFja280T0xjTHdDWlc2eW9rMnNrZENyUEVWY3VjZW40?=
 =?utf-8?B?YysrUTVMZzZaa0UwZG8rQmFNdUVZWlJ5b1dadjJGb3h0VjVqSWFIN0d5ZWZk?=
 =?utf-8?B?dTUzWWlQTXBKYVRNZ2hJRlg0U0w2SmdaK294Z0FvdUNYRDdCbmxyai8xajJM?=
 =?utf-8?B?RDRVZXMrZE1wYkUyc3dCNTRjbkkyVGxodURPOHhBV2drR2ZJeUtRM0xuZHBD?=
 =?utf-8?B?TXIyV2tGYVRVZzJ0dGxnZGI0RlZyd05LektrYXJGMjBNUUpCaE9ydk9EVnZ3?=
 =?utf-8?B?c1FNZFI5dVhKb0JlOE9PUUNmQnE2Y0VEVkFuTk1FMjNOL0VjdkhRME1RTTRr?=
 =?utf-8?B?VTRKWVVxQ2dUdzhsT2dWTG1ZZmgrYjRsZnFQcEh6TmtEZTEwVTZKYlNqK01L?=
 =?utf-8?B?NTJ6N2N1bm11R3puc2doaytoUUkwbWVzemtqYnFRNG02U1o1ekpUUnNqV2E3?=
 =?utf-8?B?VWpPUldrdWZUWkxUdFBkTlltR0h3OVhEL1hHYnpRM3U1TEVlWnFtTk5zbk5H?=
 =?utf-8?B?RGxSZ2FaVnBDNEdzcnZ6NEZLSWI5TVJSek5wdzVja1k2eHBqaHpDaDl2cHJH?=
 =?utf-8?B?SmtoZk9lYk8xM3V1SzhBQ0tGckxBdERVTlZ4YjhqSm4xUXBnQnZ3MDFSc283?=
 =?utf-8?B?ZEFqMFhhdFczc0c0b1hDZllGZ1N1ZU53Z1VqRTVrc2dGZHh1V0RFT2dRdjVu?=
 =?utf-8?B?M1VSNHVnakR1azRoZUZXN05SSFVHb2ZwNnphTFhmczh6QThOL3c4azhrYVE5?=
 =?utf-8?B?YjR2dS9USzY2bzBuRVNWSG16c1UweloyZS9uZ1A2enVXeHI1cVh2TCtmUTlo?=
 =?utf-8?B?S3pwT01kRFNYMGZvWkNENlNkd01UR3RtQ2NCSmpoSzZ3dElnNVlsVDFYWm1Y?=
 =?utf-8?B?Y2cybHpZVG5ZcG9Cdm91VjRtK3dSZ3A4NXJkTVVXa2JyWHYrQzVkVEplVmhh?=
 =?utf-8?B?RnFNNFkxU0lZKzFGbFMxWUFJRW8wT010bHczS1gwbTF0dThJOTRxenBlWVY4?=
 =?utf-8?B?Y2I4V3dRMzNWdTkxVHdKSUxoMU5ZcGtlckM4QTk4RlVxYWhWelJCVm1rUi9X?=
 =?utf-8?B?Mk8rcnByazJqQTl4REFOTkNuS2hKODcyeGtvVEJ4bUxsVkUzUTJzT3VHb2sr?=
 =?utf-8?B?bU9pdjlXK2l6d1RrK25Ka2JsU3FzcmlsTnZ5NC95eEZmUUg1aWdTSXJqZ0Rn?=
 =?utf-8?B?VFNMalhxN3MxQkZ6Q1hEWEFCYStVMGpCUFJEditHeFh1Y0VoalRQdVB2WEhE?=
 =?utf-8?B?cGNxbGVwbUN5LzZWenkwM2I4ckpmeXlGdnpUUkw4L1cxY09tM2tBM2xPT0c5?=
 =?utf-8?B?ckpHNmtXQUxBVHN0NE1rZ05xTVNFV0UwWGVva2gzUndEaXcrRzA2blJsdFIv?=
 =?utf-8?B?M1E3cHcxWGtLODZic21QckM4UnlQVVZKWktWajBqU3hoWEYvTVFKTUtSZzQ5?=
 =?utf-8?B?TWJvVDhlSFpaQWVWWnNkcjYyNWV6S2dQRWNNRENtU280akJTRERsbnlqaHFH?=
 =?utf-8?B?a2JXQ2NDU2JVdHIwUytXMk1jZFBqYXdZMnVKMzdRVzBOcFBIWnhmTlFNbDBl?=
 =?utf-8?B?Zld2aDAvcElXdzgwcnBYdncvZEt2bWszRS9jZldkMHZaWDVReXhoOHBuUzFj?=
 =?utf-8?B?RjFIRDBhVTQ4QlY4c2xNY0w4RG82NFl0a1FCbDcweWdwOHF5LzhNcWpCOEFn?=
 =?utf-8?B?QUJIN2IwV0JLcWNRRjI5aFhpOGhsV0hrMmZ4Z3EySjhEWGdickJjdXJlOUpK?=
 =?utf-8?B?WVgwZVZTWmFQUWx0TEVSeFN6aW9uQXRKdldlY1IyTnA2MU5NcmZTOEs2WXF1?=
 =?utf-8?B?U0NPOUhmb2t2M29hNEdxbjJCOGd1OUJrTm5yZkNrS21JaElzc3FkcE91UGd0?=
 =?utf-8?B?S2g1Y0thaWlBNlZ5QTN3cHJTL1I5a0VnQVMyciswMGVEcnp1cFg2ZlN1d0Rt?=
 =?utf-8?B?ZXRUTGdZL3V5b09vNEMybzk3Z3NTMUsvTGs2OGFYYWMwa1k3aVA4aWRxY3I2?=
 =?utf-8?B?Vk0xVXRlTXZTM0ZzRyt0Nk1PcjNXYy84SWEzQlZzOEtiOWRBQnRCdmNCUWU4?=
 =?utf-8?Q?kZXEpWvNY8oOdgQxgbjpdUWRJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59aa314-e34b-4d84-cff4-08dc99f75910
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:58:01.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5pKm0JZZFxUoJe7e1tCBJZaR06nx7mKmgHsYQwdtoQ6LIUX1bSrqaaRBwEykhRVe0IjGjrNWr98GVdpDY+mTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739


On 6/29/2024 5:20 AM, Jürgen Groß wrote:
> On 28.06.24 22:52, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> lookup_address_in_pgd_attr() at pte level it is simply returning
>> pte_offset_kernel() and there does not seem to be a check for
>> returning NULL if pte_none().
>>
>> Fix lookup_address_in_pgd_attr() to add check for pte_none()
>> after pte_offset_kernel() and return NULL if it is true.
>
> Please have a look at the comment above lookup_address(). You should not
> break the documented behavior without verifying that no caller is relying
> on the current behavior. If this is fine, please update the comment.
>
>
I don't get that, in this case the PTE does not exist, so as per the comments here lookup_address() should have returned NULL.

Thanks, Ashish

>
>>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/mm/pat/set_memory.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 443a97e515c0..be8b5bf3bc3f 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -672,6 +672,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>>       p4d_t *p4d;
>>       pud_t *pud;
>>       pmd_t *pmd;
>> +    pte_t *pte;
>>         *level = PG_LEVEL_256T;
>>       *nx = false;
>> @@ -717,7 +718,11 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>>       *nx |= pmd_flags(*pmd) & _PAGE_NX;
>>       *rw &= pmd_flags(*pmd) & _PAGE_RW;
>>   -    return pte_offset_kernel(pmd, address);
>> +    pte = pte_offset_kernel(pmd, address);
>> +    if (pte_none(*pte))
>> +        return NULL;
>> +
>> +    return pte;
>>   }
>>     /*
>

