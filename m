Return-Path: <linux-kernel+bounces-233964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5991C02D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C601C21045
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061401BE84F;
	Fri, 28 Jun 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ay6P1s5U"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7611E889
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583297; cv=fail; b=bkRGK42oGk+m3dXKtnACo5FluR+Z0FpGiLS6H10URQGk9az/rgm0qod51YnWvDGAPRZup2uWYLXcVz3Yz+0FgXW1QnGG7WH851uxerFTYlCdEIH7GtJcFaSF2XYqYEZCNpf5+3lCU9LodQLswpfdznWyqyMTcCHEPqXgoYholCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583297; c=relaxed/simple;
	bh=CMZPIuF/TrelxjdqqVPCb43gDK7MUaZhn+DXsdz9g0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UHVgBxJ00YwXwIBiYXJ8pzAO9vLNjeVV/iIWp9+VXNxPhQv1BEcuRpEd05uTVNSqKKqEhClIIPxaeg4vmewIg/2cEnwzyhbeqJgRcmTPxPMnk71+BKwOKsvNMXJMZ8oZALlAH1S77PdAu8JOzDT0XMNO9hgYwjiCI9dtgUjVKaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ay6P1s5U; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjlUjW0k6RHLm5mkElVLLUNbP03KkwjZKDayyAGmpkBbaOk6gegBmz2E7g0YqaGJ0QqUEcb6S2xXi/4ca8o5vwa0p0ApEskq9Aajn+jtwIlGHeTrbTPHZghdU7REQhdtBQh+Yqm2wHmNkTtxcmsi3qVijrTvLmbkaYAsg9SbaXLeZPylcCMyuELfqnzLa47XH9tWXVrBrntV1/W2RyQDBz4o4uAizsBthFJwWEU1jLCtyFR+yVvtcSboVEIbJgIpfIEs05uSAEZEqvk2cjeR+xQftZ276YfxvSbQyI2WeeCpbjUkl3EHPUq4db+AjY9yu+3OUT7fGJzvWqMR7AfJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPKj/dJvq+W8vlbqdv59/L/A7Qr1Y3s4YYyM+XroRCc=;
 b=QXrDdT76elHwQgXFC03RGFFf+b32akCr0UK0hR86p8sOt3r3sMZsHw6LlFIBe7AnkD0HLvO4xPE2XWgx8EyDhAschpmcNB5ooZlYrDsbwmDOH5oTZKBpov434TO4eyxAI5dXsL+yA6Okhl3n/bn4AkxZfxZhlUklsEpelBn0fpS0yym1C1c5fFLtl73xhz7EcBQgAIUtgjJ8gJ9qa2S1qIGNZIn7V/kPTTZC9tuE0LNxua5zDmJGkxqAMh1wXLGOxkzN1a6FizSAnu/BNi3Zt8q78RmorW8U6he9qH8nUjb/dt89jTaOkJSQWZJf4nCHYGd6vDBadl/+1+n+2yj+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPKj/dJvq+W8vlbqdv59/L/A7Qr1Y3s4YYyM+XroRCc=;
 b=Ay6P1s5UsvJ873yLQJCbm9/rWsnMUhFixZLcwjkxAS5+reSgnnzxE9wIGKmeNdNs31MLKmZ/HvgbfcmOC+ppinGInygoKNDZ2rwqMEXQRg456GH7wM6PAbBJRHZn/k+1TWwwBGy8DDnK0DUI0KFiY45dMpkelPfMOZLOMVXHNW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 14:01:31 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 14:01:31 +0000
Message-ID: <f4f780b6-d55b-3342-977b-6b217ab19b1d@amd.com>
Date: Fri, 28 Jun 2024 09:01:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: "Kalra, Ashish" <ashish.kalra@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
 <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
 <ba22b2d8-5621-4efc-8dc4-03b92408155f@amd.com>
 <20240625035909.GAZnpAjaV72A50kcWs@fat_crate.local>
 <8834ead0-26f5-4228-889c-483d60e73380@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <8834ead0-26f5-4228-889c-483d60e73380@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: bddf1a1c-e321-4252-4844-08dc977ad02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzltVTlFTkZybkwrbDU1aWZYbitEVDVLMVpJUGZtSlpUM2F1aHVmWnZCRUJH?=
 =?utf-8?B?YlBJbklzY2xzUUZPSGpPQ2JLaU16cGlsTC9IbklOdjB6QzY0dlJMQXRhRk1F?=
 =?utf-8?B?MDZ6UHloSTJEWEZ5YWdLSGFmblFYSVN1MzhGa25NYVlhbEdEbWZVVWhLTmgx?=
 =?utf-8?B?d3FRRFFmaFhGWktMclNTWGJCMFRmSWFtZzA3VDljVmRiY2t0SXFZU3Y2dlFG?=
 =?utf-8?B?ZFFyU2wyZ1JLbC9aaSs3dTIzZk5IdE5nNnZlcDhYRTYrRTNHd0NJd1NGallB?=
 =?utf-8?B?MHpjOWV3Ykl2cXBtbFhvN00xK2tJVCtkZTJiUXRJNGRWMGltTzNjZVlNWjlV?=
 =?utf-8?B?aXlzenRrWVVxclZSUGIycFY0MnNVY09VWVBtQk5uWUU0Rk8rNHVJMzNIUDhl?=
 =?utf-8?B?ZENHUUhZY2x5R0tHSVNFZS9aY1Rlem1jQXBuUUh3WHp4YW5aem1QR0RZcHpI?=
 =?utf-8?B?R0c4eXVKZmh0RVcyU3gyM1N1TUorRm1aeUxkUUpNTXdzdkFaUU15VWVua012?=
 =?utf-8?B?QmhjdVRON1ZaZGIzU2dxSTJ4Z3FZbHZjcTBjMklySUl4NFIzWGI2eXhhWjVI?=
 =?utf-8?B?SEhTQmgyd21QaVB4NFhRQ2dCVVhlUytwZThEbzBwVVhWWm0wR1BsREkrenJG?=
 =?utf-8?B?OFVGYU0vMkI0OVVoN24yUFVDbWQvWHY0WDNTWVkvbHpTMzFLU09iYmFXZEpU?=
 =?utf-8?B?YkxjN2FvanpwOWk4VmpkL2xDUXFONTFFRWh3UEk3RERUSEROYS93bk03Y1RE?=
 =?utf-8?B?b2w4UHVTZXVFUFQvSEdDZGh6dnBmNGVqaUFBOEZHa0o4ekljc1pMYnhjNVBN?=
 =?utf-8?B?TnlSVmJ4anl2dG45cG9INW10cC9EZkc4S1JzUnhoMnNIV2doSVhOdkxIem5H?=
 =?utf-8?B?YlZ1b240a3NEMVR4RTdyQ05uVTVDek1vRTVSeFBuTzFpdnNKL0ZQNDEzVkRh?=
 =?utf-8?B?aUFyVnVOQ0RLUFp5SXgzYis0dVJOandqUC9wVDFaZmtudllRVS9qM3BlaXgr?=
 =?utf-8?B?OVpmb05PWWI1Z3dtUG5SSlNMbmZUMVo2aGRTdEEvZ3NJMGVSOE5WdU12OHpx?=
 =?utf-8?B?cnhnMHk2L21XSGdQYk1lRDhIYlVLVGthdTBPbi8zbmxYWUtTS0pxc1RDU1J3?=
 =?utf-8?B?YlpvZitKN1RSSDRxSXIrdEFwYTdwVHlBejM0T2Y0RWxWSnAwc0o1TWNLYlBk?=
 =?utf-8?B?cXh2dGw2V2FwN29CckJyMWVaaUlYQXRPeC9mV3N1ZnBaWXFMazJyWGZVNkIw?=
 =?utf-8?B?VlkvQytIVGY5TU5GRURHcmFvYUtSWkhURHB5M0l4TDBSRklTeWJzZ3Qvc2lK?=
 =?utf-8?B?RGVWcjN1UnF2NGZEWDZPRXJoaHhmQVFHVU1PZHhoNnpSWkplSVlmTk9LTS9m?=
 =?utf-8?B?Q1JaZXB1ZjRwZXZFMDBQVmpFOURlaFlMVHhOb2lmaCtQZVRNTUhERlJoM09t?=
 =?utf-8?B?ZXRFdlF3WU9ySjZQYkV3T1Q0b1RGTWtRRGlEMlFOSWFmYUJHOThWak5PN2Rw?=
 =?utf-8?B?NlVpdmYzYXNOMUdXQTdBcFlVSXJtNytFZ21aS2NRUUZNK2QrRk1mOW81MTVk?=
 =?utf-8?B?Y2RLSGNpeDNlWVp1a1pCMjJOdVFOQnJlMi82TWU4cExncldSM0F1TURZOHhC?=
 =?utf-8?B?dFROLzdWWDF5YUhseDRpbmhPdWJlNWV2R2F6Q1BmTi9qemtoaklKZXlmc2Ft?=
 =?utf-8?B?MTZSVDlYUytuUStrSGpKSnZlSWpRVk8zNGl3K1pBSCtQNWdBdU9EczlnZ3pQ?=
 =?utf-8?B?ZHZsS0cxQjNWNmxOK2dRb3lEN3RENERnVVdHMTBwWVlueGk4M3JySHRNc29r?=
 =?utf-8?B?RzFZQU1SMjUweXhqZmdGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDdITzBPMGExMGJqSmNFdkVpNThQVnZWbWFMSlk5RVlaalZ1dGY4dU9kUDdm?=
 =?utf-8?B?RDl6cW9OKzREUU94S1B3L2wwK2NleFRLbTd3azdXZW0vZU5zQWZ1bU8zYzBi?=
 =?utf-8?B?Ni84QUMvSUpmVmswSFkvTFRIUlJuOGM0aGUxWFRWaWppY0twSml6NzBvTy9Y?=
 =?utf-8?B?WldpaVpVM0NjdCtjVjVpM1pnc0Q2bjlZVXBMSzJRSXpNSmgxSEpnUHloenBi?=
 =?utf-8?B?SEJzWmY3TFladGdubHc3S3l6YmxwbWtocjc5STZKdEJQd0VXSmNRMm5WTkhR?=
 =?utf-8?B?eFE0QklyVlJiTVhzZTE3STB4SEJWcDRKeWF6TGJSOVJzdURDNzdOeU56VG9I?=
 =?utf-8?B?ZXJJeFNlK1VCVlhHMFVhb096VDdCdFQ0T2paM1lkeGU1YmtaWmVsbmdHbElu?=
 =?utf-8?B?M2dyMFFCVWlNM1d5dzkxRWhRRTFhTjhLSkRCb1BaVGlWSWd3aHNDRzRZbFJ5?=
 =?utf-8?B?NnBWZVViZ2dQYVJWcDBIaVNQdjhMZkxaeTMyQVRDVjhwYXZ4c1FKcVVnQXR0?=
 =?utf-8?B?NWFyYksrZ1lNL2VIb1dRMEttWFV4Z0FGS2F5VlpjemtTNHFXM0YxT1hRVFc0?=
 =?utf-8?B?SXZSdzZNVSsvUHpjdUVEaE5DeE5OM2owZUwrcmZiRWxmelNlV1R0bWFpS2wz?=
 =?utf-8?B?aktTcHZVVGxIaFJIelpkWXZKeXc3MGQra3lvdXJDSTh0RU1EeHBXMjlNbGRm?=
 =?utf-8?B?TmxUeU9KZGNwWldCcjZiOHZjbmcyOHlJb3AvTHJudkl6a2QyM0kyOXVybUpG?=
 =?utf-8?B?R2l3TU5uRWlYUUVpK3lQd1puRVp0cmliMWhjU0xGU1JKMU1WVmhEM0UvU0Yw?=
 =?utf-8?B?ZTFkMHlvTk56UDRQakQzZXBtM0dMeE5LNmxweVJpcDdSNXdTQkNpaldYSkdG?=
 =?utf-8?B?anRxUzRsaGxpZ3RVRHV3THFPTlFtcVY4eXpST2pqQTRYczRKajNpLzhMWWlH?=
 =?utf-8?B?NUJlQmxNcGd0N0ZFcG5tUlpiK3c3aHIwQm4zTHBiSElPR1l5eG9QenFobzd3?=
 =?utf-8?B?S08yVm85R3FIVnhpSFREL25CYUpldkhTUDZqaEk5cEpWeEpIVVB3VlBORDhv?=
 =?utf-8?B?S3pFU1V4UUJpRC9yOWp2dFZwN3Q3dFF6U1M2K2E4TDdaR0JKT0tQRGpPSVBw?=
 =?utf-8?B?VFZkOTgxNytnWUhvYzQ2czFGMjg4WnZldXJXOW5kSGdIKzljVnZjZWRPNGth?=
 =?utf-8?B?SVIxcDEvcWU1OTIzWFBqSDVzMVJ5cnRMMm1IbS91MkRtUjIzK2RZR1Fqd1dR?=
 =?utf-8?B?bUJLVTJ4RHJtVHJ5bFBERzBLck5KV2t0cng5emIyclVsWXltUHZVUDdoRmpj?=
 =?utf-8?B?alMwTnZpLzJURnQ0M3psZ3JDK3dCcE5HZFFhM0toZmRHU1dhK1JxSW5pMlhW?=
 =?utf-8?B?NVFNeG0zQWpaLzVsM0hkNlgrSW9EeUk3QnBjQkx6dmFGa0hRNEZIRkR0aDNG?=
 =?utf-8?B?T1VIaFVhWVhKU2QrRlR4U2VYQXk0VHdabzhMM2lWU1NQd1RPZEJPMWJJVTlo?=
 =?utf-8?B?ZHA1Q0Rld2dHcFk5T3Y3UUNHdWRqeG90b1o2bldIalBYeXpIRzhYV1BQQkl2?=
 =?utf-8?B?QmlhM054a1pZSkZFS0NpZEJEY3J4WjYzZUdrQm9ldk05QWFscWlBZHkvN1Vr?=
 =?utf-8?B?bEtNdVh6SlhrcEtvWXFKZ0N4K1Nsbi9nRHRuUTFLa1NJVzkvUEJEdzZMSjc2?=
 =?utf-8?B?aHNXRUN6Q240cVRDSW5Rb3RlZ1ArMHc1eTFFRWpCVzU2MGZsVlQvRUI0SGh5?=
 =?utf-8?B?UHJwaUE4UUFCY0R3VVY5T01FODd1OUFONUFVeTEyemwxQVRMMVlQb2VVZEdJ?=
 =?utf-8?B?SVp1NmI2UjdtWHIxVXBGV3oxdTlRK0trcFMzbk1jc3RkOUYwVjQyZ0ZQd2ph?=
 =?utf-8?B?RDE3cm1GY2FlWXh4OS85cFg0c0c1cW90S1IvV1VCa2NhbHhzbkZBQUY0ZEdz?=
 =?utf-8?B?NFZBbnI3bDNDRjByaDZFbmMwczhHdjFEd3EyZ3VOZVlpOVFGOHZjNUFjL25n?=
 =?utf-8?B?dVptdEZibE5ZRHJZQkNWVkZyeVdzamg1cHdabmRKeW9takRBcFNDY1Fsdmhs?=
 =?utf-8?B?R1VjYWhBOCt2L21DR25tclRLY1pHTmhFSUxnajg0QUpxMGVma3JhdDF0VzE5?=
 =?utf-8?Q?WyJSf9BqRGQ8nCwooM24kQJkf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddf1a1c-e321-4252-4844-08dc977ad02e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:01:31.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhN+mW5bGQW09OEME7nv6UY6NAHVIk/ErpKNoPBHF+unpz+jX373s36WoEZg7L8TPAx8ZST7Xp6uqknNAlaXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

On 6/27/24 23:27, Kalra, Ashish wrote:
> Hello Boris,
> 
> On 6/24/2024 10:59 PM, Borislav Petkov wrote:
>> On Mon, Jun 24, 2024 at 03:57:34PM -0500, Kalra, Ashish wrote:
>>> ...  Hence, added simple static functions make_pte_private() and
>>> set_pte_enc() to make use of the more optimized snp_set_memory_private() to
>>> use the GHCB instead of the MSR protocol. Additionally, make_pte_private()
>>> adds check for GHCB addresses during unshare_all_memory() loop.
>> IOW, what you're saying is: "Boris, what you're asking can't be done."
>>
>> Well, what *you're* asking - for me to maintain crap - can't be done either.
>> So this will stay where it is.
>>
>> Unless you make a genuine effort and refactor the code...
> 
> There is an issue with calling __set_clr_pte_enc() here for the _bss_decrypted section being made private again,
> 
> when calling __set_clr_pte_enc() on _bss_decrypted section pages, clflush_cache_range() will fail as __va()
> 
> on this physical range fails as the bss_decrypted section pages are not in kernel direct map.
> 
> Hence, clflush_cache_range() in __set_clr_pte_enc() causes an implicit page state change which is not resolved as below and causes fatal guest exit :
> 
> qemu-system-x86_64: warning: memory fault: GPA 0x4000000 size 0x1000 flags 0x8 kvm_convert_memory start 0x4000000 size 0x1000 shared_to_private
> 
> ...
> 
> KVM: unknown exit reason 24 EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000000 ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000 EIP=00000000 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> 
> ...
> 
> This is the reason why i had to pass the vaddr to set_pte_enc(), added here for kexec code, so that i can use it for clflush_cache_range().
> 
> So for specific cases such as this, where we can't call __set_clr_pte_enc() on _bss_decrypted section, we probably need a separate set_pte_enc().

You can probably add a va parameter, that when not NULL, is used for the
flush. If NULL, then use the __va() macro on the pa.

Thanks,
Tom

> 
> Thanks, Ashish
> 

