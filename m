Return-Path: <linux-kernel+bounces-201670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3A8FC194
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DE11C22A71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5E60B96;
	Wed,  5 Jun 2024 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Et0q2Vfv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8E60DEA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553706; cv=fail; b=nGAH4EK3eQoI+yFUK/Mi2c3b6mpZ4PCkdenBXYvRwFZWZ9Pi2V6lizBQSmz/IFe47oN8zUREYMop9V3sPPZe68sfQ6BzvjWGyh/8zRCXcPeI5NIuhuQ7b8+AM0+2nJta5XxaGrqarneHJJP5oBAGuESH0GysqESCWssXqAf8DY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553706; c=relaxed/simple;
	bh=b/keLvhJkhbSg9tkiANVenj8bTjcsVqJR3+Rb5mBx6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKVRelTNUy/FFALAAyI/1+8+dwImOWCQzPGNDvNU4jAQNPOo63X5zCdygWsPwhsEiCtGoSPAQYifAxib57+eEnROuCvDOXeGZ7Z1dfAuToPYuj7f+9Ro8791t64FIgVB6yHis5nSS68WExPmzeOeBh2rhqagXgOuGYQzTivxbo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Et0q2Vfv; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYQgkMxb4fsaH+erucMoT/S3u5ssEphtrSMix9kBCGSPjnIj+D+aIgPRjOwhyttJ4u+e3IsGkm7DsCDr5IGVlZHHIAi97DmuAo43Ch2Og9GA8JYh0JIa2K8xHchsRLLEOxaAwVhSJrN5DD5JuC9FftoOS9QKazbHHY9X4B3mifUWKU09V5uTDQ/mZ51bkg0T/BpeXRAXnbdyGaDY4TBvlH6sBpcOxDSzVKswgLDkOH7ipqRGWSaIQjgInENUG3b+pDUKHXPiZh2JV6wFeh9kGWDurs3GDhXqEOSF6jBInvWyJjTZatgCInJ2Iba9yW2LjLGKYixeOR38k/8fa6DbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CQNcKVp1+UHy3VUFJcxaIR1h1cVll+PJt229QFB59s=;
 b=NxXa1Wfv6nxQhk2lHGAa24opgzzBLHARu7d/QzAzJkxXDVXBFIb+O29yR5wRCGU6XD5ufJMvXxQuGtagYKkoAC76mWVCYJjjwi3LRRyvGhjfsNZ5718xr6vb4APsFsAg/85OequFx3D1HPwJ3tWcgawwMhE1pXhXqxuBKDkSMeZUltu9qh1hh2R6ZZYadECXUt2+Q4ZTHTEKck+GUa7k55V3NR+fBc6ClpVXvpoiwgC4bTxb+gwiZfhyj8N53tXp3zfmX0xTYrcJisdLT2IyopwJyu4r5IKosQMMahSQkXgJR3CNSo5aekL9Z0ZAZb9HzTNJFz5DfMFj0IfRBEhjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CQNcKVp1+UHy3VUFJcxaIR1h1cVll+PJt229QFB59s=;
 b=Et0q2Vfvcd0nOy2ieTWyAb3hrQgX3KgMMrGvQMFdB6lCQhHPVDPTCbPorWF0uEUAMWyjQFRznq9c8rIkQn+aNRL2rtiHDHm7xCxgqzjLambP82QffC3kCLrVpHoFkt/8X7YvM5OgDcNOxPjF0EaMYvMNDNW2O64mayfu++M9ym8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 02:14:53 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 02:14:51 +0000
Message-ID: <9f8cb762-21d1-4c6e-badd-5d0ff7890fab@amd.com>
Date: Tue, 4 Jun 2024 21:14:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 dan.j.williams@intel.com
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
 <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
 <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::33) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1a9baf-30cb-4367-a1b4-08dc85054823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkhFN1M2ejFyV0pGQi9rV1dGOCtZM05SZWxSQjArTmk0bVhDdUxUMEFTQXdJ?=
 =?utf-8?B?L2IvZ3lnaFE5ZVpTM2taUlo0SnlJQ3JVcEs4ODFRUVBPYWNyUWRhT0R4MUcr?=
 =?utf-8?B?NFE5aG5pZ2hMclZtdld3NWRVVkk5dUpqclZ2Z2dkMm9GMXRlZG9rUzVUeFhm?=
 =?utf-8?B?YlJWUy84QXg0a2tlTHJsMFV3TWlFdWFOOHpobEs0TjQyVlVuNFJEeDdYcVV1?=
 =?utf-8?B?dG9ueXV5V3lsYm42T3QvaG13Y0NydlFpa05uVjRQQVk3SmdQV1V4R3NJSm5C?=
 =?utf-8?B?Q01mREgvdWQrT3BwbUszeXdPb0tOclhjN0ZZWXFKWmd6dFZrMXJaZC9NK1ZI?=
 =?utf-8?B?dnNiRU1ZRngyWE0yV211WVBhTUNXcmxqT2ZzbkpLV08xQzJ2dnVaRUdSZTNT?=
 =?utf-8?B?ODM3bU9SKzV1OU9JTVpMb2NBSDJRNjh5SWxpd1JsVUJiRE1TVGo2MFdrd3BV?=
 =?utf-8?B?K0FNKzI4Y2xGUXE3YXFyTnROY0QrSHZXRTZZaHBmSkdaa0NZVUwvNjh0c1k2?=
 =?utf-8?B?UXcxOHluYURGcGNSYUFRYnVTUC95VVVOc09LR05JWFl2VUErYVk1VDBGUHIx?=
 =?utf-8?B?dWtEaUpBSTJaRmc2V09nRmJ6dzhMNHNMbkFUQ1dZWkFNRVBJeldMWXI4ZVZt?=
 =?utf-8?B?VzJrSGI0WTV4NGN6SGxLVFpqRzcxaXZtTTF2b0FaOUcwMitpRDFHMW9JZmR0?=
 =?utf-8?B?NkdrWjBqTkMxbTRmMmRSTGpPaWlRQ01RYlIwTUdvaVh5U2tNSWNyTHlFR0RW?=
 =?utf-8?B?VTZTKzJGdFMzK1FZZzMxNWVTOE4zODduWi9LZUpqVmlGT0trQkFnWG5Wb3dU?=
 =?utf-8?B?aXN2MUY1eFpnY2Z0Rk9PQXExWEIyaTRlVUxTR1JYb1BYRTVmT3RlT1Z3ZkdV?=
 =?utf-8?B?UVd2NyticXlxYzAxY2UwWStZTUxHeGlsYWp2VDQ0TTZ4OU5WZThzN0NhTUk2?=
 =?utf-8?B?cDdVb0FiRHpzZm0zSU4vQUFIL0l1L3lIQWNTdmE1dVM1Qk1zdEtiNUJ3SU92?=
 =?utf-8?B?S2JPVWpNM21KQ2VnQzg3a2JFTHI0d1ZLR3psb3hDQWlqbWM3QVFHSG1tR2Vs?=
 =?utf-8?B?L0dXRGJhajRGTXlEUms4SmFHVDdRVW1mYzhVYm93K2JEV0Z6MXBNUUxWWDJE?=
 =?utf-8?B?SUdjdGFmTzBlbTVrWnJDbE9ENm96Mityb1NIQ3FQSGc4WVNPTGVwUm1ac2c3?=
 =?utf-8?B?a3hEajhrQXJmUEN1RG83dVBMSzFwbldJWnk5Z3BTczhUbC9IVVZoRnVRYTBs?=
 =?utf-8?B?Z2dPdEJ1QjUwaW5xaDFFQmIrWU1LVjdpakVNWXZ3RnZxcDB1bytYL0g3eGh5?=
 =?utf-8?B?YXAwYUlLMkMrZjRaOEtGVDBoTjNaSXdEUjRRc0NMUlA3MThBKzlzUjdHRFda?=
 =?utf-8?B?bE5yTkpVUEJOU08yVFplNTdidktETVhxS3dBV0NLRWFnV3JJM0x2MUhDblUr?=
 =?utf-8?B?bHp0UFFXOUNWSXdWdTc1aTI1WHc2OU9YYmJJdDZLblFWNmJrR1hTdlJjYUpk?=
 =?utf-8?B?OVBNZHNSL2d5a0x2ZXJTVzUxNm9yOHNBUTkxUEExS29XWWxqUGNWa0RQZm9p?=
 =?utf-8?B?QklQdGFuQ2tUODlOa1lqMWNtSENGQTN2MDEyVzZVVHBTbkZOQ0w1N2Q5a1pq?=
 =?utf-8?B?ak1vUEZhVi96c3Y0TkI4S3pITkY0SVY1ZDdFcU81TUJ5ZWM3cXpnTnlidzdV?=
 =?utf-8?B?ZU5BRVEwY3RwN2MxUFJKZnpoQXMvVmJ0akh3WXRKOE1CZ2xidUxMbytRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUYzcmh4dTRnOVdoS1dDdVZOeXRXWkxoNC9GdDJMd1c0RW5TejNpQms5Nkw1?=
 =?utf-8?B?cjlZR01PK2wzOVNvaFRKdEIwRUhNaldBOUVHUzNBV0ZVQ21NOFdYNHJNRFFv?=
 =?utf-8?B?UzRtYzRkYXlqVEJnV2FjSHd5eUNrVGtnU09KNk9FeDJUcG45YldmUyt3eTNw?=
 =?utf-8?B?bmhscmdqbGRUWHY2NkJUbTcvdFBSMklSekVmTkwzRGdxTlVCU3JHMXJ5cFBD?=
 =?utf-8?B?KzBldkxDcUJWS2hOZldabXpNVTZreGpTRU5wSTBRY3czczEvQ1ZLZG5GYkR0?=
 =?utf-8?B?V213WmovQmFFY1gvdlNNZk5CY0syNkxlNGFkYnZwN2NJeC9qZ0dCS1k4V3JD?=
 =?utf-8?B?a3pIUVVaMlEvOGsxdWgxeDRlMVlxSTYwL3JzRU9rb1ZLalYrQjZNTUttU3lH?=
 =?utf-8?B?eFFpaXlZRGRnRWdTZHVibkE4M092RUp3ekJnaTVwZHpVNlcxR0RpUkViMEFv?=
 =?utf-8?B?TkROREl6NXlTcEZRekRuZFJJU1ZucHI1dldJbW5jbGRwUHd4ZXovUDVpZytG?=
 =?utf-8?B?aFY3UkhBaUJ0Wm9tOWtUK2pORDlLeWN6NzNzbFlXWU1yYWRKYTYva1ZuYzgr?=
 =?utf-8?B?a3EwczJBUnNVQWpBa2ExcFlMM1VoMmFRN2VkeHNPV1pXNllKbm9yM0FxSGpE?=
 =?utf-8?B?WVFkRFNTWEIvdnE4TkYzNmdGc1lsekgyN1pZMUZIU3NqWlpLbFl5SU5LQ1Fr?=
 =?utf-8?B?eTA5Y0hsNFJqRG5GcWRtRWl0Zy9XNTd2RG1MRlViYmZlSE5ES2djZ2loK2pC?=
 =?utf-8?B?ZXE1eURTMi9nWnFDM3ZQbjBwdXNBZWhOUmx4ZW1uRUdkS2g0OWdBeFBvb3Vp?=
 =?utf-8?B?bENSaTA0SXNNM2crS3VhajZ0OWcwTkF1QSt6NzBhajFCZDdtR3cxbFNvdWZL?=
 =?utf-8?B?U3N0eXU0dzhxTzJmajBXR2FaZ1ZRT1A2TjFaSjdrVy9zcGFmQlk2K3B1dFg0?=
 =?utf-8?B?KzFtTHhWcExPNHh0OXN5UUs2R3VhVERTQitQUndHYlQ4dnFzL0szbTNMT3Vq?=
 =?utf-8?B?WC9hWEF5L1Z0bjdVL0FHMU5CaDZFVHcvTzVHVTZGMFBoZk56ZUIvOWpWVW9p?=
 =?utf-8?B?RXJReXJVVE9HeGVaVUxWaE1Zd0VYSkJ4ajY2WjlVOUVRMGZRbmYwYWhSN052?=
 =?utf-8?B?dUo3UDAyYTBWejExdnh3Y3FXakFWRGsvNk5ScmlyWENDeENscUZnM3V3K1Ez?=
 =?utf-8?B?VTBCYnJsWTJVTnRMY2dXYTZaQlNWb3F5T1B0QVVEa1BaWTJiN0YvVVhJUjdk?=
 =?utf-8?B?cUFFTjFRZkYrTWFLR3JIbUJRUXJtbnZxLzF3R0poMXBIVmtSQ0FwaWpPb3g0?=
 =?utf-8?B?SzRybzQ1NTVDYTFWYVRSUWkwS1p5L3BlMzIyNk9hYi8va3VmSTA4UkFCMkNl?=
 =?utf-8?B?Mm5ja3hsWlFRa2ord3gvaVcrMHV1ek55SHBQcUltVkNZZUpRWktMQTBITUtU?=
 =?utf-8?B?TXNlSG9wSGMxQVZvSHY4SCtYenEyemF6dVh4UENxcmx3a3Y4WGM2ZnQ5MjR2?=
 =?utf-8?B?dEQ0TGZvR0tJeHhmRjhVR09aeWJ3ZmRybDdyK3pFRncxQXA5eEZ0ODdwU0dt?=
 =?utf-8?B?L3FhWXRGTGVUOHRFVE9sYW5xaGk1NUFBSlVyUzVmcW9Yc1dFd2E5TU1tTkRy?=
 =?utf-8?B?ZU96MFhQSTFidlBISWlhcEVhLzJWblNUOWVwaG5pK0FpU1ZQL3MvREVJc1k0?=
 =?utf-8?B?R3lKTTdCRVM5UmNaOGtoeWEwdHcrNzBNTXdHbkhBbjkzRnA3UHpIRWVqQXcw?=
 =?utf-8?B?VlJCRnNnUmFzTHpYdk1xY2I5Z3dLNnhOVjJYdHpTUHhTZktiQTFranljV1BZ?=
 =?utf-8?B?Q0k2QXZwWTdkL09udmtwQ2pleU52QjFsZUl6blRLY3EwZjlhbGxZanA3Uy9u?=
 =?utf-8?B?NDVSSWJJS1QyRVFCRXpRbXZqTURGWHhwYU1Ca1k0L1N1Yld6ZlRHQ3JBZ2JL?=
 =?utf-8?B?WXpGRXEvT0RlODR5T25SV1I4dWcwVDNPRy9UZldCRWJnUGRmV2EyV2UzeXIx?=
 =?utf-8?B?ZVNUS3VQUXVkK09FNXhTZVhhYmVJb2lmbkY3eWxOaE52elhkRWdkamZWdGIr?=
 =?utf-8?B?U3Q3VXBRbUNUWkpsYzhHaW0ydEtNMHE3R2phMkJ2Y0F0NkVLM2o3ckxjcFVI?=
 =?utf-8?Q?3cQ2lZtbEfr9ap9CweE7l66/9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1a9baf-30cb-4367-a1b4-08dc85054823
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 02:14:51.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/wJZrHaBohOyyQRH1u7Z1s93+K7krkOGOyk4zNcQhW03dIfkJOIqGDAyZQWzlb2J4Ya3+NWnY1H6lo9D7k89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

On 6/4/2024 8:48 PM, Dave Young wrote:

> On Wed, 5 Jun 2024 at 06:36, Kalra, Ashish <ashish.kalra@amd.com> wrote:
>> Re-sending as the earlier response got line-wrapped.
>>
>> On 6/3/2024 12:12 PM, Borislav Petkov wrote:
>>> On Mon, Jun 03, 2024 at 12:08:48PM -0500, Kalra, Ashish wrote:
>>>> efi_arch_mem_reserve().
>>> Now it only remains for you to explain why...
>> Here is a detailed explanation of what is causing the EFI memory map corruption, with added debug logs and memblock debugging enabled:
>>
>> Initially at boot, efi_memblock_x86_reserve_range() does early_memremap() of the EFI memory map passed as part of setup_data, as the following logs show:
>>
>> ...
>>
>> [ 0.000000] efi: in efi_memblock_x86_reserve_range, phys map 0x27fff9110
>> [ 0.000000] memblock_reserve: [0x000000027fff9110-0x000000027fffa12f] efi_memblock_x86_reserve_range+0x168/0x2a0
>>
>> ...
>>
>> Later, efi_arch_mem_reserve() is invoked, which calls efi_memmap_alloc() which does memblock_phys_alloc() to insert new EFI memory descriptor into efi.memap:
>>
>> ...
>>
>> [ 0.733263] memblock_reserve: [0x000000027ffcaf80-0x000000027ffcbfff] memblock_alloc_range_nid+0xf1/0x1b0
>> [ 0.734787] efi: efi_arch_mem_reserve, efi phys map 0x27ffcaf80
>>
>> ...
>>
>> Finally, at the end of boot, kexec_enter_virtual_mode() is called.
>>
>> It does mapping of efi regions which were passed via setup_data.
>>
>> So it unregisters the early mem-remapped EFI memmap and installs the new EFI memory map as below:
>>
>> ( Because of efi_arch_mem_reserve() getting invoked, the new EFI memmap phys base being remapped now is the memblock allocation done in efi_arch_mem_reserve()).
>>
>> [ 4.042160] efi: efi memmap phys map 0x27ffcaf80
>>
>> So, kexec_enter_virtual_mode() does the following :
>>
>>         if (efi_memmap_init_late(efi.memmap.phys_map, <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().
>>                 efi.memmap.desc_size * efi.memmap.nr_map)) { ...
>>
>> This late init, does a memremap() on this memblock-allocated memory, but then immediately frees it :
>>
>> drivers/firmware/efi/memmap.c:
>>
>> int __init __efi_memmap_init(struct efi_memory_map_data *data)
>> {
>>
>>         ..
>>
>>         phys_map = data->phys_map; <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().
>>
>>         if (data->flags & EFI_MEMMAP_LATE)
>>                 map.map = memremap(phys_map, data->size, MEMREMAP_WB);
>>         ...
>>         ...
>>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
>>                 __efi_memmap_free(efi.memmap.phys_map,
>>                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
>>         }
> From your debugging the memmap should not be freed.  

Yes, it looks like that it should not be freed, as the new and previous efi memory map can be same.

Thanks, Ashish

> This piece of
> code was added in below commit,  added Dan Williams in cc list:
> commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Mon Jan 13 18:22:44 2020 +0100
>
>     efi: Fix efi_memmap_alloc() leaks
>
>     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
>     updated and replaced multiple times. When that happens a previous
>     dynamically allocated efi memory map can be garbage collected. Use the
>     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
>     allocated memory map is being replaced.
>
>
>>         ...
>>         map.phys_map = data->phys_map;
>>
>>         ...
>>
>>         efi.memmap = map;
>>
>>         ...
>>
>> This happens as kexec_enter_virtual_mode() can only handle the early mapped EFI memmap and not the one which is memblock allocated by efi_arch_mem_reserve(). As seen above this memblock allocated (EFI_MEMMAP_MEMBLOCK tagged) memory gets freed.
>>
>> This is confirmed by memblock debugging:
>>
>> [ 4.044057] memblock_free_late: [0x000000027ffcaf80-0x000000027ffcbfff] __efi_memmap_free+0x66/0x80
>>
>> So while this memory is memremapped, it has also been freed and then it gets into a use-after-free condition and subsequently gets corrupted.
>>
>> This corruption is seen just before kexec-ing into the new kernel:
>>
>> ...
>> [   11.045522] PEFILE: Unsigned PE binary^M
>> [   11.060801] kexec-bzImage64: efi memmap phys map 0x27ffcaf80^M
>> ...
>> [   11.061220] kexec-bzImage64: mmap entry, type = 11, va = 0xfffffffeffc00000, pa = 0xffc00000, np = 0x400, attr = 0x8000000000000001^M
>> [   11.061225] kexec-bzImage64: mmap entry, type = 6, va = 0xfffffffeffb04000, pa = 0x7f704000, np = 0x84, attr = 0x800000000000000f^M
>> [   11.061228] kexec-bzImage64: mmap entry, type = 4, va = 0xfffffffeff700000, pa = 0x7f100000, np = 0x300, attr = 0x0^M
>> [   11.061231] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M <- CORRUPTION!!!
>> [   11.061234] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061236] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061239] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061241] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061243] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061245] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061248] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061250] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061252] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061255] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061257] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061259] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061262] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061264] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061266] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061268] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061271] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061273] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061275] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061278] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061280] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061282] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061284] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061287] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061289] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061291] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061294] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061296] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061298] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061301] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061303] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061305] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061307] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061310] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061312] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
>> [   11.061314] kexec-bzImage64: mmap entry, type = 14080, va = 0x14f29, pa = 0x36c0, np = 0x0, attr = 0x0^M
>> [   11.061317] kexec-bzImage64: mmap entry, type = 85808, va = 0x0, pa = 0x0, np = 0x72, attr = 0x14f40^M
>> [   11.061320] kexec-bzImage64: mmap entry, type = 0, va = 0x14f4b, pa = 0x65, np = 0x1, attr = 0x0^M
>> [   11.061323] kexec-bzImage64: mmap entry, type = 85840, va = 0x0, pa = 0x2, np = 0x69, attr = 0x14f59^M
>> [   11.061325] kexec-bzImage64: mmap entry, type = 0, va = 0x14f65, pa = 0x6c, np = 0x0, attr = 0x0^M
>> [   11.061328] kexec-bzImage64: mmap entry, type = 85871, va = 0x0, pa = 0x0, np = 0x7a, attr = 0x14f7f^M
>>
>>
>> ...
>>
>> This EFI phys map address 0x27ffcaf80 is being mem-remapped and also getting freed and then in use after free condition (while setting up the EFI memory map for the next kernel with kexec -s) in the above logs confirm the use-after-free case.
>>
>> Looking at the above code flow, it makes sense to skip efi_arch_mem_reserve() to fix this issue, as it anyway needs to be skipped for kexec case.
>>
>> Thanks, Ashish
>>

