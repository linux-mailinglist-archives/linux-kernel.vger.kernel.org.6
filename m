Return-Path: <linux-kernel+bounces-222243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B8590FEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3667C1F22A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D019F49A;
	Thu, 20 Jun 2024 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uWmdYrM2"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964319DF8A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871809; cv=fail; b=o2aNcgVN0xRk50MZ/1zIfSrWYdfnLTR/ZuWpMEJUi5e5f5hEvfRJmu34+XigwlyPIvuQpjbUo5O+F8XkschXxIdcgHrg2KLG/6uehzBuysV+FqwLm5nrEN1+Eid8op1kynx7TEsZu1QF1hTKpwXgoDxY3gkM7HK605y3LN4H8wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871809; c=relaxed/simple;
	bh=olaYxjgnnvqCB2XmWv0XSjyewKs+7IelCYOYPSQkLzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WMa6HldREViwxCf0lSP/D5ugHXXHIap9QUKklocwQ7Cy/phT9z2lRScZFzld8toKGXErrjEH+0WHXaabkqcT/FupBEh4ySTjxTvTV2MDMiIH6D/Rh8dtthvMZMtHpNYcnRVO+21NjGaCwBOTWvF6tn66b0tS//pYg/RVnT+TToo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uWmdYrM2; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFEKrqQqxzMKNZt21Ydo0adgfDfRDK4N4Psh+qBgwSLQBmT+hq/gxSaTseTIkjiSg+PwMb5sUuZhqUXDBJlRvKA4yQmeA4uFcPRuOn6L5vdFF7Cw3ULyUYfmATsn6fOkd6ZkY1AQhRyKkis5U2i/Gz0vDjb3M9bs8E7KqvuCvHvwKhx5eF07b0NcC4XeA/wqAL84SAk2/gLerUGxRdGqzkVWWld+hpCZsdd9TJ5+2tGgVEOOd9fc6398BdlZqnWr2Po0+J0q9/v0E2mk8cyhbsetAht8asx/y38eLdjU8Wt37u0N14S8pQ8Kw/NkSCLGOUs3f+LXD6M5SbrJrA7sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1jo6l7INRTbMb1izh5Te9wefXBEr4raXCOFgpEPxAE=;
 b=AptyUURKH1EsHoluG2Kva5mSOR0hQsIhr0yGwbsRYoZk/5atte0yUGwgG4TL8eArCxwhNCTzhGkWUGQBd52v/EgJSEBvfvKYHv5NnBrfXa7f/lhdt5+3fMfFcUPkG4mNZsA8Afxv5tEJjvZzGZLKa6QmDxPLpt3Is70xOxaeM/6Etzsyi3o62S7DBogxrAsUKluIrOb9+v8bi6Oj2ez3kd6pug4kkZcxazFLiKKMBny8Z0CDLwJCr9faMUGWu9fAnZYzA8CZh8g5oF02mvFr3ljE8LKj0E3IWLVk7+QKINaD4RiGiRmUqc8w4l7RH7H5ofhZe/LUsRBQw5aZ8CnMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1jo6l7INRTbMb1izh5Te9wefXBEr4raXCOFgpEPxAE=;
 b=uWmdYrM2oumxbs8zoiMBq15zExBTwky48qW0ldN2EqUt5lXb2NysUA3FIscZLJjSJcNiYgsTHfnIAtVeTE07LkFljy792XHMByaEz2V0X9lIDzBtEoJUZBbIIqiznib2jh87/zl17O9xNV2l1bEkxFB4j5avZZu3aZFaSD26bE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Thu, 20 Jun 2024 08:23:25 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 08:23:25 +0000
Message-ID: <a14396bf-856a-80f8-9cb8-61031a342e96@amd.com>
Date: Thu, 20 Jun 2024 13:53:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] x86/sev: Move SEV compilation units
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Ashish Kalra <Ashish.Kalra@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Michael Roth <michael.roth@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20240619093014.17962-1-bp@kernel.org>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20240619093014.17962-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4229ea51-7a92-4157-6673-08dc910240f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmlCRVJneCtMSmV6RW1KZFZITXlYaEJXTjlBbG5tU2s5SnQ5VU1nTVQvNXhl?=
 =?utf-8?B?WXFQaW9YRE50V0dUU3RucUc1elhyV1Jka2g3V3E5blYxMkRId3R5R1NXZFFH?=
 =?utf-8?B?Q3FWbHYwWFpZNEwxaGxnMUhDb3dwRlhBY0FMbkxzdzFlZGhBYzBuWDhRUmZP?=
 =?utf-8?B?TUt5VjBMMEhwaDg1UjFoejdRY2JLRm42bWhLZklUbUdZeENmUGREcnQ0Qk53?=
 =?utf-8?B?Rml2Tm5xaFNiOGJPV0tIenFvVnIxY0RsbWlYUmwzT2p2UEZrS2drYkQxem42?=
 =?utf-8?B?elArVVFFaU9Cek1ZN05uUHFYVkVidm1mSHAremsyeTJTZjRhQVlnRDdESEdZ?=
 =?utf-8?B?TDNobzF3S1RnRW4vWXBCd2RUQzFkcWdnaHVrVTRLcDZOZEhRd01yMUdvZm9a?=
 =?utf-8?B?WVZjalNWZlR6RUMrVGdjdnpjZjJRVmtycWJHeXJnemtGb0VJa0MwSXpBWGJs?=
 =?utf-8?B?MC96a3R3WW85RGYxVCtFQ0hLMXYxYTh5WHdVVk82QUN2R2FvWFBsckFjTXFS?=
 =?utf-8?B?U2ZMdnJ0dC9MS1lLaG53d0xUcXNyY2hib2tpU1FMWWRsK2JaRjlKNU55VTRT?=
 =?utf-8?B?RGpRS28zdTVDUm5XQ0NoZXlqL3M3Y01tZUovSVVUMzEydE5BZWtuUHYwK2dz?=
 =?utf-8?B?bU5jdkVWN2E5aURkVllaSXY1YWR2a2NqNnRzRFF2SnAzMTQxeEE2c3FyVWNT?=
 =?utf-8?B?L29Hc3FZOTNCSlJjYUttUHE4VDVyaGVDZlNtaTFTZW5YeGVwU0doRFdaUCtt?=
 =?utf-8?B?OStmOGJoMHdneWJ5UTE5eERYNDFSSmNqU3ZId0lTYUhORWRGVWh5SFc4ZHBm?=
 =?utf-8?B?UEE5cm1YT3YrYjVic3BTQnUzU3pGUU1LV1FSWmpkbVMrSEppL3FGYVEwUmRr?=
 =?utf-8?B?Um4vSFZtbUlOaUJFUEJZV2VaV2R3bXd5aGVLVDkyMGdYK1Rlek05M2ZSUUI4?=
 =?utf-8?B?NExEdndMaWxUZDgycVJ5NWZUV0Y2dWYwOXZrQ0pSV1Y5bStIM3BiS0daWExL?=
 =?utf-8?B?bzR2S08vNkZlUjF4a1paZUYrQzU1RGRWZ0hzT003NGJCSzZMMEZHclpEaU1z?=
 =?utf-8?B?RFJIVUVndGEwalFjcGpzNGk1UWZRNlZkSlNKTFBWU3VhMjZFUzVYSkREdzU3?=
 =?utf-8?B?T2hvOForbURrT01mU1UrNHlNaWkzMU12YkFFd2ZMTjVlcHpZVXdSdHN6NGJB?=
 =?utf-8?B?aklNUXpiNzBMdEd2bncwSnZZWlpqOXBnbTB6MiswU3owdi84VkVoRCtWQ1ZJ?=
 =?utf-8?B?KzUwQmIweEJJMnhiTmllWnphcjRDbjZsMExWcjNIVGpPeTEyZjU4c1lEVUsy?=
 =?utf-8?B?elA2UDVvTnU4a29LMmtFMDNDUE1RSTM3QXdHN2lmUkhsci9wN0U2RGo2T3cz?=
 =?utf-8?B?azc5ajk0cmxNQ0t6MU9jWWpaNFgyQ25Fa3BnbEJ6ZXlON3hKZFFRMWhKWXN4?=
 =?utf-8?B?TjduOVBlSTFEZ2w3SUxNQnJsY0ExZ2crNko5NjdqdmpZUE5GcGYvVTdxY3Jv?=
 =?utf-8?B?U0NZU01FS2oweDhJKzBzU2F0WEFEZnJsU2tDZ2QzcUhXRVlUWTViNG9abkFM?=
 =?utf-8?B?Ukt4SVpRNnBhbzYvanBGK2tyTHZwNUhSMjkwbVJIWWk5UENHRWxUUUovNFFu?=
 =?utf-8?B?cTVsUVNoVVVwWE1wUFhPOGhmS3M1ZWxBUHhVanBIeFpiUElwMnQ1QXBBck96?=
 =?utf-8?Q?ygn2zjUhHZ2shbfslRKV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFBycXY2ZHhVOTFLcFhCb0RzenZpb0N1VjlTY1ZuYVVYZ1BicnVNbkV0ZHRF?=
 =?utf-8?B?Unl1NlRPcnU4MzhxU2kzcUtsckg3SytmSS8vQVRWeElrWUxGWmduNFc4c1ZE?=
 =?utf-8?B?Y1N6NG9xdXgzUmRTY3B6K1NSRy84VlJydXFUc295S0RnNWdZNVlILyt1UjNB?=
 =?utf-8?B?V05XL2hNL0FlTlZncHZCc2JaaGVtTDg0VldHUm9tM0ZqWFhza3oxb0FTMVRa?=
 =?utf-8?B?ZUx3ay9NeWh0NHZaVnVuSk11TmNkTE82dG1oWUM1c3MvNGlQUEtKeTJjOXNZ?=
 =?utf-8?B?anB6UFAvS2NqdTdFMFJrS1RPcm5lMEhZQ096QjVlcnA5WHkrR1pXWitvOVUx?=
 =?utf-8?B?YmxDZWE2YjZwMlhHR0FtM2UrcG56eWIySlZ1akpTNzFOQWY4VE1BK0V0dWJ4?=
 =?utf-8?B?RWIxd2NRckkxZ1VPWDBpb2ZwVmc0bmlTYTI1MWFCWTBKNnBXSHNEVnVJL25l?=
 =?utf-8?B?WTJlM21hVy9YQ25YV2RteWUvNExNVDJvbWxCVXpSTlBQYWJiVFR1ODU5eEV0?=
 =?utf-8?B?WHE2K0V3dDExQ1VmTmtJRzNVWnd0ZUwxQjlxRXYwaUg2cE1Qb3hHeHZ4L2RN?=
 =?utf-8?B?aFBmNGlFRFgyamdPV1NPSEFNWEVBTXhsd1dxaFYwVXpsY1Q3YlVicFNkVnZ0?=
 =?utf-8?B?L0RQMUpjNjIyV2NQU3ZPc010U1VuUy8rL2EwaEpEellVQVJqTXZYeGdVeksr?=
 =?utf-8?B?YXlXR2xmMHVSVkNtaWMvRGlWeVpRSzNZUkNiQVVZN1FxNHE3YU8zajB1MmNV?=
 =?utf-8?B?dWZyK20yZ0g0REdKSnFjRmtwK3Q5VDZDQm5POCtFZzN1cW1VbUtHbUNlQ2hE?=
 =?utf-8?B?LzZoYXdaaE1lV2R6MVpQbHoxUkFYcXgwaS9KQ1ZHNy9MS3lqbHlSdXZNT2VO?=
 =?utf-8?B?TlcwczkyRUlOcWVOS3hHcTF5Z2RFUUNDcEVLK2pIaGY0RzZGbzgzRzM4Z2J5?=
 =?utf-8?B?TGdrZnFSMFBlZXBid0VYbTJVUk9WcnhhVmlEU2tENm9lMVFHSFlWc2ZVRXJK?=
 =?utf-8?B?aDdWQTFZRFJnamFOZ2Rka2RwKy96eHlRbVdIYVQ5TTl5K1E5MWpqRWowT29G?=
 =?utf-8?B?Z1FVWTJsaklackFLMTVnWTNqcW9rUk5meDRidlVJMWNZZjd4SzNwbTRjckta?=
 =?utf-8?B?MmZaQVdHczl3SWpNb0h6QXpMdVNmczFxZ2RDZHdxSi9JR2RUcVlYNldCWHIv?=
 =?utf-8?B?VFY2NlR5TCtON2krcjM4dWNsdGY4cUlJTWFmckRXbUVtWTVqTVdNQ1dPekVi?=
 =?utf-8?B?bWhHL0tTUEpjMEpPMmFKL2VRSmdRa3pUVHR4UWJiWXF1T0kzU3lVNVlaK2pB?=
 =?utf-8?B?R1ozY0U5aW5kZzRHZVBCZkNJdW9uM1Z2bUQ1TUZ6akRKZGZmMDZ0ZVYyQzlr?=
 =?utf-8?B?RlhJeGFXd1VWQkxRZVYzWU13RWZmT1JIRHRzanBUby8vVENyTkwydWRndEox?=
 =?utf-8?B?dUZkUU8zU29rQVNRV0o0bVhMMHhkZW4wczhMMHZaY0NGdTFpenArbVhvWUNL?=
 =?utf-8?B?WnJHZGpDVm13M0VZMzllYi9NNVYzck5yWXY3UngvWVVneGZ6dFdaemFRcmcv?=
 =?utf-8?B?N3V0bnMzUVNrY2F4Q1EzSXMxU1hSSXVyUVFOc3VLNEFxMmJ6ZjIvMkRzb1Fs?=
 =?utf-8?B?cmJVaHp6aG4zVElzUzBvNFJzZVRnM0daWGdtMnlSa3hlbUtwcjIzOGdYbnFj?=
 =?utf-8?B?anNZQXVqcGt0a1FVSXVuSDhNNE1kamJJcVAwcG0rUENtd0JPSUxydVlsaXpD?=
 =?utf-8?B?elVyL3VwWmkxQ3VzZ0Z4d09uZWRxTkJxY3g0Z2FBWlpqbncvclNHdENmU0NK?=
 =?utf-8?B?dTV3Zmd6cEpHci96VW95OWE0VVRTYXAyVUJJQ0lKNzU5Y0JUN0wyNTJ6ZzM0?=
 =?utf-8?B?cGk0UnJsWDN1akMrREdxcXZZelFBa1JNRTdrVDdvNXVDUHFwdGFuUjFqZzdq?=
 =?utf-8?B?ek5MakJFa21MZnVYdWp6TlFlK0pockRWaTdZbDV2SkVKMmJ4c3JpbXFLN3dQ?=
 =?utf-8?B?ZUoveHB3RGpKWDFJekRUamtULzZETno3N3Y5STQzTTNKalJvVVBVWStOSmli?=
 =?utf-8?B?dE8rODdHaXJCR2VtbUxSbmtodmphZ3dJdVYxV0lBL2dESjVCbVlCQUUreUtm?=
 =?utf-8?Q?DiCSDNW3L3DE9ZsDYC/xWQwk2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4229ea51-7a92-4157-6673-08dc910240f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 08:23:25.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAk9J05TmfMJbhszOEFizbTuYS/bdCjlhRwZ+9IKSrg35dLIqpCbGDWCu4EdllmlDh0zhWI+ipmVj5EadoIgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961



On 6/19/2024 3:00 PM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> A long time ago we said that we're going to move the coco stuff where it
> belongs
> 
>   https://lore.kernel.org/all/Yg5nh1RknPRwIrb8@zn.tnic
> 
> and not keep it in arch/x86/kernel. TDX did that and SEV can't find time
> to do so. So lemme do it. If people have trouble converting their
> ongoing featuritis patches, ask me for a sed script.
> 
> No functional changes.
> 
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Nikunj A Dadhania <nikunj@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

I have rebased Secure TSC guest series on top of this patch and will post it after testing.

Regards
Nikunj



