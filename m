Return-Path: <linux-kernel+bounces-574869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF2A6EAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4857A3E93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C1419F12D;
	Tue, 25 Mar 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dLGt83fE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1239D530
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889619; cv=fail; b=YtrCNCrE2Ib4WuPgeqcH5VYlv3gzmG5WyA8Gmj/83Z9wS4LgKFlYTRSdOGQQc4oy/tbu3N2ecpFFRvEVwxawL7Z+0CHrUu4UPAT1t4CwEfTzAzY8ltoWrqOgnaybyJwqfdBqYWiratc0x7mlR8nioAzmrLybCLXlvpNFvvtbzsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889619; c=relaxed/simple;
	bh=K3e5XUfCy3r9sLQnO0MITDr+5xPP1GI8/Q+LJIXHYqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAG90qGQbGDsuQ5i5fXKn8Rdwy8STAXPsTwUaZ9PLo4KLzl0DvxfE+fUA6TycpT5g0/lbdezHRioms2UlFH9luOZcPrAewvxv8YXuVwrsuZA0Ki/ovRJvOb79DWKj5YSg/lxLHRCiL1aOO2ZjK3DMTDbgJ55JCj4OHKLKNKqUus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dLGt83fE; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlUbQgGnEMM5mc0IEcCzFG8JTn6p2vkUG0qegdOLXJC7VRigPl1e8bFSDKPiArm0TYiAc4Vyd4Plgbahy9s4ULchf1X9tIcMvzElQUUkSpfexVGDpbCWdTa89xdsrxoGayi1JELwyEpR0W5YaAP0VRw1nQOKaxrHYbEwKJ/Cr2QOIspww/FkOVBQnTnGqTUVhUKNwk4N9rXUbQcr3aUP6qEjNeP46AwSYCU9v90+KN+w0PN1VEf1fhfaRQ/PHbxXB3eAfB6ecU7MpF6JEXpCeEODK0d8LkMorN93NFxa2puqwixrMqf2J8tqQlcxMuIZ5y5EuVyUGRLiHnskeuo9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Anrmt+l8ERKg3L9AJBpYRaM6HXtel/1qWFeufoIQqw=;
 b=KcApz3ykHxZAqFpEBXkmaDkiGyxbSJDPXwTPeW906XyuFmOELCo/u7ydrdFj53vbzMifYaBR33QwM/8svs01ARa1ITyvnfBeVe9dE6TRV4w/R45AwUjk/18YZPuAd0aVfWk0JwECWAqKI7FQhXVfLRoS93lZ6NqpIGTzC4n7hYS2fK897fGHCApPfiJlu7TaPS4oA36z85AWFu+Us5WxE2O+bu5Pmf8TWvyqkMnpv/KfWTJBKCtGtjlWoNVQ9Myn5uAd7rDh/XIn0xb6cTbN1yTd6mat4BS4IHmz/BUNrL4AePbxRrN+L39MuYtjOQ/sKpX5vhlKeFySljI4KjvyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Anrmt+l8ERKg3L9AJBpYRaM6HXtel/1qWFeufoIQqw=;
 b=dLGt83fEaXUsdJIXLgUHQUib/0g2RCgMgCf4dlv4PcIZs/BGcXGAp49y1qhmuPEaKnepLn+g+AAfR2TP17o2j86whTAg7aKlO9yO5hmc1cyHbq8tl1HPTabhffkSTjNpS3VVdggURNXkqarBeyub4YdhElltBtCnQaXh9WVjAtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:00:13 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:00:12 +0000
Message-ID: <4c40bf22-292c-4a3a-bd32-4461c2d4f7d9@amd.com>
Date: Tue, 25 Mar 2025 13:30:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -V2] mm: pcp: scale batch to reduce number of high order
 pcp flushes on deallocation
To: Nikhil Dhama <nikhil.dhama@amd.com>, akpm@linux-foundation.org,
 ying.huang@linux.alibaba.com
Cc: Ying Huang <huang.ying.caritas@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Bharata B Rao <bharata@amd.com>,
 Raghavendra <raghavendra.kodsarathimmappa@amd.com>
References: <871pw33695.fsf@DESKTOP-5N7EMDA>
 <20250319081432.18130-1-nikhil.dhama@amd.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250319081432.18130-1-nikhil.dhama@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::15) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c287e5-19ae-44c8-c5fd-08dd6b731214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXlPckhncGh3N0NTMkE1alVETEJLb0JPTWVZN3JFcXkvUkNweDZjaituWnJD?=
 =?utf-8?B?cnBtcDZZQ0U1c1NqOWxmelU5bVF5SHpDSWtMRVZwVmJSVnZ2dGRKSXByNTNP?=
 =?utf-8?B?b00rVGhnNU9Idi85ckxoa3dDME5DY0ZvTXJ4elgrQUQ2VmRmKzZxb1BKVzVo?=
 =?utf-8?B?WWVMdVpHN1dPKzIvME9oVGFJMlk5eGFpTVUrM1RDQ2xmS0pndVBYbDNlMnVh?=
 =?utf-8?B?cjQrY2hjUWR2dXZ3bzFITTNOdmVxb0kvUk5tZHhnMkE1cXJYVkJvUzQvSkNH?=
 =?utf-8?B?VzY0eDZSOGtORE5LbGsrY2gramdhSXU1SHQ5TUJxc08yVk1WR1VBNnhlTllq?=
 =?utf-8?B?YldyZXZMTm05RXBjejJaSjdxTnNBb0ZOQjhnaEFVQVRqd2lqcWFieEdRRGt5?=
 =?utf-8?B?cmd5aWtZRHR1SytQampCbERCZkpMblVYa0hHUC9WOHQyK3NZcGJRamVqODJD?=
 =?utf-8?B?RVVzSlZHYnFqQm42V2tpUThUbG9BVlcvRTZIVSs3aEpWbW5Wck5nTmZNazU3?=
 =?utf-8?B?dWc1bllDU09ISXJlTDQ5RUJaTTdYYkNmRjh4dVpDS0tackIxTWF4NjNEWHRh?=
 =?utf-8?B?Y0lTWXJSZWJOeUFRK2x4VlU0TExsVjgyQ2U5cVN0eGlWZldIU0JPdTl0Yjhw?=
 =?utf-8?B?SkxKeTVxTVB6Q29kZTdiZDBncWdMd2ZpZXJqTk5jaTN4TExrTUJnaWV2NHhO?=
 =?utf-8?B?bkpRV1lXQTBVMHF2dFBuL1FSOENMOC85dEV6STU2UElFNjdLTGpEWFNEbEZh?=
 =?utf-8?B?a1M4L29rcTJ1RkxjTVNlNndCRkdjNW9LdHVuRGFBdHp6VUN5L2VLek96b3Nv?=
 =?utf-8?B?QnlKR2dxYk9kNmhQeFRSeWtmaGVCajkxbVhNOW9YeFJ0cFdCMCtwa0pIcE9F?=
 =?utf-8?B?R3N6ekxUUlcyd2dwZlZHVnl1TWFIbmxnSVM4Q1RDdXF0RjlBd2ZiaWF1Vi9I?=
 =?utf-8?B?SzI1TUQ1QUJiWVFsaGpCZk5rYnprbllLalF0K0s5amJxVTFjMyt5WWU0NDRT?=
 =?utf-8?B?MTV0bjFOc3RiVEtuT3FJWlRyTy9uY0laTzFGbklYeXdjY0UzSTBoUCtZRjlF?=
 =?utf-8?B?azN1dG1FdFpYcE5raW5JS25UVWtqaDcvOWlTRjg4RTVLTHJhSmNwRzJhaEl6?=
 =?utf-8?B?eEE1Wk1maS9UUnZveEpyQkNuaUtGZ1pNU0MwUVBrT0F5Vmc0dE0zbHNUbSsz?=
 =?utf-8?B?VkErWi8xODQvaktXc0tlbTRzWkJEQ0hMQ1gxNG5pLzJHWHJZQlUwK1M1c2NX?=
 =?utf-8?B?bnorUW03VUNMMk9GcGFGQk9rRGtjVVVndzZ3Tjh0YXJ0NHRKajdHUnJPdytK?=
 =?utf-8?B?djRVSnlURTl5ZU9uRDlEV0g5L2p4RHNmZjNwakx0SkpXWFQ4d1FoRjZBektN?=
 =?utf-8?B?MTBJS1E2UnM1YmkwUFN4QnBjVEFxTU1GL1hOZ1NMd2xqcHJXdW54YXdOTjRI?=
 =?utf-8?B?ZGE5a3lmQkhpR2I3Rnlkcnd1Z3RJaTZtc2c1QWRGeUpNUFNOWFhDaGdINkJ4?=
 =?utf-8?B?MjJZdVpwM0lSakc1NXltam5TMzJycjBGbE1lUEhZdUxTK012MVoxUmlMU3JI?=
 =?utf-8?B?c0VkODUrb2tVelJ5NWhlL09VYTR5YTFVQzIyL2l0ZWVHQWk4Z2lQcWJlQVBC?=
 =?utf-8?B?SFpDQ3pLSFpGK2hnZDE4SEdKSC9La1RaMWZTYzUxRmR0dGowNEJMZGF5UVY2?=
 =?utf-8?B?WjZmLzZ6SmRGajlibXB1V2lpZ3NFaUxFWGNzUFVWVkVFMFRXNG1OWmdoVE1D?=
 =?utf-8?B?RXA3Q3R4NzkvcjlwN3JOMEtsWm1oakczV3NXWUxCd3JzSytXeTFjUEpmVTNj?=
 =?utf-8?B?eW55SWtVc2FJTTZmSFEzdzVBT3AzSVliZHhWdWJNb1dSczNGQW1jS05lVFNa?=
 =?utf-8?B?TUh4ZkFwa2NpSUpRK25abEVNZExRNUpVS0lkMTJjMy9UWTd2SGpyMmJNRlNj?=
 =?utf-8?Q?ZInEnixRulk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmx4ZURjZlBzQ08ycW1xZURQN0N3TzdheW9uV3FtYXBYYms2TnlEVnF4bkZJ?=
 =?utf-8?B?ZWd4NHRHYTEyMXg0R1BlR3pHSnlEOTcxOC94d1dDV1Zlb2YxUHAxaHRwYTZC?=
 =?utf-8?B?dVM1OWxPcURGSklhL2JOd2UzNC9GV2pmTDIxZkZ2NXR3SHkzWnhqMHpvMkZS?=
 =?utf-8?B?aG9HUkV0Y2xjOGJlSTA1KzArMitKUHFKME1qU0o0Zkd3eVdOSnhVcnlyOXQx?=
 =?utf-8?B?Y1o5anI4V0swWW1QQTc3dkJNcGJoWU9QU1dPUTV0SmNpSzNTSDBLNU9ieVZi?=
 =?utf-8?B?bU16VzZVRkhMS082U1VMQTJsZWpLYmR1TTU2UjVrRHVzQ21uSHhJVUY4ZVF4?=
 =?utf-8?B?UWQ5ZUl1QlYyWjU3K2tPSVBFdnI3cklHVmhrT2ZHS2hsNTR5MWdoZWs5bVk5?=
 =?utf-8?B?MkdybnFZUWhnYnpWejZNa1I5K041c2Rhb2JJN1NpRjluaW1XT1FiOEZWaEVp?=
 =?utf-8?B?K2JTd1FKVEd1V1BybWljMzRzQXc1UWZCdGhJR241WHlmcUlCYnFBdFdYYlFN?=
 =?utf-8?B?Z1ZUVDlrSjZoU0J6ZmdYakRoUjR3OHhoZXNVZUh2VytudHpBOEZvKzlVNzFt?=
 =?utf-8?B?ZyttczBRaFNZRXJ6bmgwMmlQNVFDSlFNa3RUSDE1NC9mVC9tWktNa3gxRElM?=
 =?utf-8?B?RFdrT0NOYnVZQ053RHFlTnFrbWpHRUF0RFBwNlpobVRFdmRJcFByNFowaUgx?=
 =?utf-8?B?b3JxOFdYdjhiR2ErUzkxQncwVnZXa0NEYXVDZDhIbVhoYitvZERNM3hsajNw?=
 =?utf-8?B?OFg4NHpOdkVIakJ3VlFxY0JlSGFZT3o2aUVJK1MwVUlGRm5tdk1qbjBBUUxw?=
 =?utf-8?B?U3NkdU9IeWRFUXNOMjdlNU81aUFjQXJ1bG9oZnc0ZHJuRnkvK2VTSXI3dmNJ?=
 =?utf-8?B?S3hCYmY5dlVjQ3Vkb1VORUw1Y0lSWXloalpLS3JDdllQRHRnQ3ZRcE9KaHRx?=
 =?utf-8?B?ZlBuQmZCcktFbnZBZ3B5WDh4MTFXZXJYWEYvUlU4ODlxWEFHR3B6RjB1Q2pN?=
 =?utf-8?B?OW52ZjVlb2J4T20vZHlEWjI1WXZNUTdkYkh3ZWZHUzI4NTZNZmliWEhiSllm?=
 =?utf-8?B?aVdOUnlKNnIzaWRQeUdzaC8vRDlCVWYvc2JiRGo3NXR4Q08xbm4xU1JwcnVB?=
 =?utf-8?B?QUFudlIrNC9jcDZBVzAxc0VPRTkwWE1Rc3gxeUk2Q0JNaW5NczhadjU0a09h?=
 =?utf-8?B?Nnh5cmI3elhKNWtudVZQZkxjaHlDUzYxNC8vUUdUZ2ExakkxTEVsZ3Y3Y0Jp?=
 =?utf-8?B?bXMzNDhVMVAwbnFOaDg0bjJNbnRsN3RKVW5SeGdEKzNZL1NUK0pzU1BJeWtZ?=
 =?utf-8?B?b1lkK2ZHVm1QOXY3clJKV0duN1Zqb3NIVFNEMHNrcHhORDNCQTBFKzYraWxJ?=
 =?utf-8?B?UlVIRGsrbEJQcnplelV0R2FZWUNwZGswQnVmUDJ3cVh3MnpGUktBODRNU2NZ?=
 =?utf-8?B?emRxdVkyc0p6clVnMFBIcFdrVnFEUjV5R0xqeitSYjVLK0thTzE1VTR5Wnlw?=
 =?utf-8?B?Q2dZUXQwSGtOcmJPZWJDdWxOUW4yaXByVXR2dlh3VnBjb2lpcDlkNnMxMFRU?=
 =?utf-8?B?TllnaFZrR3o2c1hlVi9IdTdwaW5UTFFXTWx4UDlMOUdCVlppa3FtNXFJQzIz?=
 =?utf-8?B?ZTFTUVA0bmhScnFrSk01eS9QcVR2enB5YVZ3SC9WOExVQlUzcW9ULzZpTTRY?=
 =?utf-8?B?QTZHaCsrN0hVSVIyekxCL1FhSzh2b0Jxcm5xU1RjQ1l5cGJRVVA0aGFWWXcv?=
 =?utf-8?B?eWFldi9tYkMyZ0VwdThNL2pmV3dTM2tnVGVLU2piTWI2ajU4bTl1ZjVGdUNa?=
 =?utf-8?B?TUVZSCtnclZpSk4vd1Nsc0tZV1Y3eHlXenk3STFYYWtvVGprd0tvMTNsRjB4?=
 =?utf-8?B?MjJ6Zm1ucW91eUt1ME9XMVdVc2dPejF6R0NlSDFJT3QxV3psNWFwNnV1OE5Z?=
 =?utf-8?B?T0pkWFg1K2VjNWtGUnZvTy9JQlNCRVdTTU5BWTM5WXpXR1dqT1lBWnpraUhO?=
 =?utf-8?B?bnN3bW9UL3VPVWRERURnWnJpYWhRaUVkS1hrbE40RmRVWHFDaFl6eEV5d1Fa?=
 =?utf-8?B?R0NOVXJ1S2NDV0Y1Qy9XZnltU290MmlqMDJlV3pONGwzNFlIZThmUjNxVE1Z?=
 =?utf-8?Q?NIIWCi3XcsuBjonodbMwFUavd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c287e5-19ae-44c8-c5fd-08dd6b731214
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:00:12.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wk5nLLtVh0cJ5sEWrwcE5L3l89boP1SDM535kQz063jr/XBPcSQ5usLdfc551bH9Y1aIoNLwHSsOaIT9osUATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

On 3/19/2025 1:44 PM, Nikhil Dhama wrote:
[...]
>> And, do you run network related workloads on one machine?  If so, please
>> try to run them on two machines instead, with clients and servers run on
>> different machines.  At least, please use different sockets for clients
>> and servers.  Because larger pcp->free_count will make it easier to
>> trigger free_high heuristics.  If that is the case, please try to
>> optimize free_high heuristics directly too.
> 
> I agree with Ying Huang, the above change is not the best possible fix for
> the issue. On futher analysis I figured that root cause of the issue is
> the frequent pcp high order flushes. During a 20sec iperf3 run
> I observed on avg 5 pcp high order flushes in kernel v6.6, whereas, in
> v6.7, I observed about 170 pcp high order flushes.
> Tracing pcp->free_count, I figured with the patch v1 (patch I suggested
> earlier) free_count is going into negatives which reduces the number of
> times free_high heuristics is triggered hence reducing the high order
> flushes.
> 
> As Ying Huang Suggested, it helps the performance on increasing the batch size
> for free_high heuristics. I tried different scaling factors to find best
> suitable batch value for free_high heuristics,
> 
> 
> 			score	# free_high
> -----------		-----	-----------
> v6.6 (base)		100	 	4
> v6.12 (batch*1)		 69	      170
> batch*2			 69	      150
> batch*4			 74	      101
> batch*5			100	       53
> batch*6			100	       36
> batch*8			100		3
>    
> scaling batch for free_high heuristics with a factor of 5 restores the
> performance.

Hello Nikhil,

Thanks for looking further on this. But from design standpoint,
how a batch-size of 5 is helping here is not clear (Andrew's original
question).

Any case can you post the patch-set in a new email so that the below
patch is not lost in discussion thread?

> 
> On AMD 2-node machine, score for other benchmarks with patch v2
> are as follows:
> 
>                       iperf3    lmbench3            netperf         kbuild
>                                (AF_UNIX)      (SCTP_STREAM_MANY)
>                      -------   ---------      -----------------     ------
> v6.6 (base)            100          100                  100          100
> v6.12                   69          113                 98.5         98.8
> v6.12 with patch v2    100        112.5                100.1         99.6
> 
> for network workloads, clients and server are running on different
> machines conneted via Mellanox Connect-7 NIC.
> 
> number of free_high:
> 		     iperf3    lmbench3            netperf         kbuild
>                                (AF_UNIX)      (SCTP_STREAM_MANY)
>                      -------   ---------      -----------------     ------
> v6.6 (base)              5          12                   6           2
> v6.12                  170          11                  92           2
> v6.12 with patch v2    	58          11                	34           2
> 
> 
> Signed-off-by: Nikhil Dhama <nikhil.dhama@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ying Huang <huang.ying.caritas@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Raghavendra <raghavendra.kodsarathimmappa@amd.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b6958333054d..326d5fbae353 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2617,7 +2617,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
>   	 * stops will be drained from vmstat refresh context.
>   	 */
>   	if (order && order <= PAGE_ALLOC_COSTLY_ORDER) {
> -		free_high = (pcp->free_count >= batch &&
> +		free_high = (pcp->free_count >= (batch*5) &&
>   			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
>   			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
>   			      pcp->count >= READ_ONCE(batch)));


