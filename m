Return-Path: <linux-kernel+bounces-234421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450591C671
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846AB1F24DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D06F2EC;
	Fri, 28 Jun 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cXtlS4i2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9363BBC5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602069; cv=fail; b=qgJvcOvZ0v5o6bGFM3/x3iRRS6fvFl9Pf13b0laUVN9TACWXAmu29NRxepZpAuoC99XNaL/4xRykCgoBhvyI8kxAphfBkFSMLcehYauTQnMbuKescwQAT/7J8FSLVn/aui47fhfb4MMSgyre3Df4MWLm0dxrYDx+faeyg7D6PEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602069; c=relaxed/simple;
	bh=B20YvUwFqzM9wkdaU7lU/iwRfFHFsAdndrxDqp/ipfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XMRj4cIObPODqFBWSbWD38SL3f/bZyaCK2CTw+OE2q0c5GnOyWuK0S9+AsrhIu26xxhTKhjqnNDa5X73z5jRHDB98LjwUu9byAtDNRyj+n2qoDk9ueexbTrLuKb9S73T2Wljkvtjyo/jvH64jstFPlcgCzG+Wqud7uffHFxc4E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cXtlS4i2; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If2IxYdtDJz7W5DsC0JdMJE8SSM/45VtW6sxAHuM7aZwmq7zl4TKIDfVO/wofUsxbEwv3g/9u3cw18NmlV1Yk7bBbBtA69DfQCbU6lzaKPNcbFdS/9Lh+c4PQ+I8e3LPbEItCc98aCtmoCtFJ2/m35zFK5bj3errmjcoxjvZ1cPfOCMzkq5VzZ/HFhCgvniLew+MikiFe0xVY11anbeRCTYf2WZoGn9a2FR0kYravPED5tjg2PganqTKswwe0vbLtjeqh1exdFcjulADqABSNMW1JTvaxvIz27gZQct95dcpxWpEeKZodLKa6DFGYKL4FdeZskQ83Put1pKHTSHnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExCGcpq7Y4fVaP4LFJwb2idlcZ6EmFpm+eHzmLjDIKM=;
 b=THdH6JPbkGexEM56OhSRkmKzG6Dmfh/B5rnW1GIqqAHP3wf5kXTWe5rgS1BHIUesud6zt0Yskkq1u24PevYz2kEcyBWTZjR98PXdTKdapF8NqxyLKmUBlWKxmDPeTO0007JuB01EWEZW6NwQAowUl+5cuwNLt6Q2SlpdFT1DhAPKeW5BRxFwcxYApByIKeHeCNc1W+T973b5V/CIPKXeOikWvZsQCDkZ0NWEzzIY2i7Gogdh33oHnS1xuHkG4Y7op3W4GqRlWRyf51Zdwvd7OC3Nzbkxq9NfCTutqOo6I1KQH7zZpPNh+lHD/dTiM6p/wkzRLXMYxkscxpde2nEMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExCGcpq7Y4fVaP4LFJwb2idlcZ6EmFpm+eHzmLjDIKM=;
 b=cXtlS4i2J789P6CJYficqOi5AZjl4nxSVb4F/xo3l8dQ+GJUsVkSTQl1NSvMqLAox+1BlQescv4s+fmpgLMBvAofkcQtH9KAtccydP30tAeGQqtmv7pSu3rjWNo928Zw9HzwUq0cIhtb+vFbWc0uMd/Q0IBsFUreaL8lgvWOoBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.36; Fri, 28 Jun
 2024 19:14:17 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:14:17 +0000
Message-ID: <e030bd97-21bd-4ec4-89d0-bebedb54c408@amd.com>
Date: Fri, 28 Jun 2024 14:14:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
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
 <f4f780b6-d55b-3342-977b-6b217ab19b1d@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <f4f780b6-d55b-3342-977b-6b217ab19b1d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:806:d0::32) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fe034d-42f5-49c1-1a32-08dc97a68182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmhsU3RkRzlQdXBtd0JVRmJ6OVQyUWg0RjBHYVRKY0pDdWxmV1FTL1pacU81?=
 =?utf-8?B?di9pOCszT3hrd1ZRNXhyRjhHaWtXcEFyeTJvbUdYNVpsblhvK3JHbldqQ2VT?=
 =?utf-8?B?RXE2aVlBT2pMNGx1VEFLQ0ViYUE1RnJtZTRFQXk0WEdMbi9qalh5WW5YUWNE?=
 =?utf-8?B?em5GRXZOYmxmdEVUQnBQRko5NEFlQUY4Mzc3RWtTeE1UWnExUXJUUFg1dWxL?=
 =?utf-8?B?Y0JXU3lzeTBrWlJndDIzaGpiZ2Y3NFV1VmRFQkJpbGYvM0U4aGkvbVpNUnBW?=
 =?utf-8?B?MHJDeEFacVdDa2RjY1lzZUFRdGNxQkl1TWt3elpFdlhybThYaHdzRFBpbTF4?=
 =?utf-8?B?YTJLeElGSlhhSjh3YkZkdXgxYTBIS1BxR0VNR1ZZRUZ5Y2Vqd3NlUlJFYWlo?=
 =?utf-8?B?ZGhkL0pneDlXR3ByUTJ5ZHVoS2JLZ3dGVDVVb0RERnVkYm1neHREV2pmeEtG?=
 =?utf-8?B?dDFhVVFibGZxWlJYdldEd09TZzhkSSs3a1VSaWdteVZwc0xHREpDc0ZUWk1O?=
 =?utf-8?B?NDI4aStrUFNudU11N1lSZ1VZaDJLNUg4L3BQV3pMUndQWGFvVXduVGFDbUph?=
 =?utf-8?B?dnNJOTh3TnN5ZFZnZ0lYYzN4bFlMNzMwV2JTNWJHSEpXazR2K3R2UEVNc2VT?=
 =?utf-8?B?dWVyUkN3bld3VDJ0UmtXSzY2OHBteS9WdktLN3FkQ29Eckk0LzVWQlBJRSs0?=
 =?utf-8?B?M2VhUHl1K0o2TWQrZXpUckIxZ1NVamh6d2dHQ1EwZ0Ztb3ltd29GdlJLM2dq?=
 =?utf-8?B?WU9GbFpPMnhTaElXamRNdHNjeUlUTEc5ZW9WSEhDQ0RtWStpb084d2JnNnhZ?=
 =?utf-8?B?OVVtR29XT0Q5bXVQdCt1ZWFvODBUclUyRzVwM01QakY4QkpmcWhramc5ejl6?=
 =?utf-8?B?eWV4elJ4bmJmK1kzdTZKTHNZVnJGY1NPa2FybmtXbnNRNFVXeXFnYnByZXk0?=
 =?utf-8?B?V0ppOXZwRFhOMm9NZHZDVzZGZGUvVmJIdWduRE5XR3Y4YjE4WXM3TUk5K05Q?=
 =?utf-8?B?Q2NzS25NZyt5cjBxWTd0eG5UNkg2SFB0ZURFOUwrWGxwcTZwb3d5em82RkxV?=
 =?utf-8?B?YTIxMWRQZWE0NFlhVUYwbXl6ZDczdE0raGRJb1RKUVpRZDJ6Ty9ycmd3YXZh?=
 =?utf-8?B?aVRCbGRFUHpvYkRQUVVVRytoUzM1cncrSUU4VFF2dTVRUEFjaFo2bkpMNWlT?=
 =?utf-8?B?VkZPVmRjaWNNUWRDTnJ4OU1kVW0vMGNOVWNWcDFpTFlsYzQzNXJFK08yV2wy?=
 =?utf-8?B?Ykw4cUdEMzYyaVk2UkZ5bHV4SURrNTg3MVI5THpOMmsrMjhTU3QxbjliWklQ?=
 =?utf-8?B?c28xMG9qSzY2TmE3YmVybHFLc3kwamZraEpQamJaSTBiSWM4dVVFNmFpWW5Y?=
 =?utf-8?B?bnF5RTU5WlNDajJ2a1g5L1BZVmlXRHc5RzdJSXdNeElGSHdkOXhrM3hmZ1ZS?=
 =?utf-8?B?cFRCcXZnSktSMklrRDBBTGFzQWo5TEwxWEdkYWxXZDViSWgyaS9ZQVgzZGNJ?=
 =?utf-8?B?NzVVakJCZDVjaFNZMy8rTG9qZHVreURCR2dOUVpvS29OdkFNVDlaQUFEOEFp?=
 =?utf-8?B?Nk1FTllnQkJwZWJwcWlEbTlvV0VXYmwzWXlWM1NCL0ZUckt3N0JvY2dDelcr?=
 =?utf-8?B?RDN6VHJkemQ2ekQ2OVdmNWVaYXBTTXhOWk91QlJCRW0zeXk2WWE4RjU1bmZF?=
 =?utf-8?B?YVphZVdJZ3pUemtmdUorM3NLMnZaYXNoSkQ0Z1p1c0RhNXViOFA4anhuN2NI?=
 =?utf-8?B?bitmQXVMdXdKYmRtYzVMS2tYbGlXU042eHErMFVPVktlbi90VEtJVmdaYi9N?=
 =?utf-8?B?S0JqVU93dmZpMU4wc2tGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Unl5dE1iVU9JSmFqNGttSWllMjNIb0VjSnlRS2U2WTVtMTJ3eU1BdU42d3I0?=
 =?utf-8?B?QU96MFM1S0VGdDRrSkZucHZkaURSVmI1T3FJNWpTOUViU3JzQjdMSWd3YVBS?=
 =?utf-8?B?L2tsVFVxSUZTbTR6bTVNZ3lvVjdVUEhqcCsvQWNxSXBESHBMVEQvT3M1STND?=
 =?utf-8?B?c0IweDI0UVhVLzRUYkpkMFNOSldvV1NWTnYrYm1kbmdFZEwxN2t0TStqMW9x?=
 =?utf-8?B?NGxzcHJoV1lMd0RVM0pNT3FJR2RDOGpGSVFjZ3ZCUHdGVTlOVzdkN01mbkJS?=
 =?utf-8?B?V1dxWUdBbmVkU1NGSE13SlVxN09XRUs1NDEvNmNrSFpVOVhmWUREck4vZXRv?=
 =?utf-8?B?WFlCK0xVYWcwRVd1aDM3NjcwVkhBTURiY1c0aGpkOHM0eUlBaUc2b3JlSzNZ?=
 =?utf-8?B?RlJlYytKaEZFVDFaOHFkM0o1TGFITVVnbzFwSnp0N2V1YWlna2g5bVY0TDQ3?=
 =?utf-8?B?SW9DWklhWkk1dmtYZUlhMTZEdGRRYzlGRzVEeWFKMXk2S2lwTHZhMWVvM05o?=
 =?utf-8?B?MXkrYk9ZTjRJSFlnNkRLd3RMMVkxdHZldGZvbmpJVkJ6eXFpSWh1MTBNd1N0?=
 =?utf-8?B?TEhnQW4zYjVXVnRzQzZIQXJuSGRlL3ZqRGkrM20xdk9wcmw4M0hWMGh1dUZ5?=
 =?utf-8?B?cWJvNFhzY0IxWXRvbHhZWVQ2b2dIVFdsbk1OTEM4ei9Pd0s2bk1XZGJzelZV?=
 =?utf-8?B?UUxBSTJ6cS94WjBFSEh6cGtRdFU2dUtNaDNuc0dvSWxlOW93cTlvWmhQc2JC?=
 =?utf-8?B?dkx1dGJhRDE2aVVyQWtOd25jZURxTm04WlA5ZGZESHl1RXhvUGUrNzFDT3NE?=
 =?utf-8?B?T0RNNzh6U2k4d1Y2S3h1SmorVm1ITkdjZnVPb2JzUE4rQmVPc0JTblg4dG1n?=
 =?utf-8?B?cStpTTdIdDlHZmMrMDgvRjdSWG5iUFR5VkVOV0FydnVZSXY0WTNPZUpzSGFS?=
 =?utf-8?B?MndieWFnbk83b0NxSTNJSXFKVFhleUxUR1hNa01iTko2cnZSb2p2c0hqVSt0?=
 =?utf-8?B?U3ZscHExTDR1SkJBakE2QjBaZG5ucklqN3BzeUQ0Rk0wcE5OQlpIYjBoVlFy?=
 =?utf-8?B?WmwwbCtmZ01NVWRSTmVJNE9sSFFNNlJDaTlLZjRwY3R6NlR6aTFzSWxZU0No?=
 =?utf-8?B?ZzZTOTdVdlhzUllmMlpSVmdFcytSdC9ZdnVwdHBpSlRpM1AyeWFmVWNnZUtj?=
 =?utf-8?B?cXQyVlhhUnV4TEpMWmw2TTFjNWpQWkorUzBEN3dhRDdvR1BOWCs2SDA4Ni9K?=
 =?utf-8?B?WjZnVEVvZ05abFAvYTMyNitsYnI5RXRueDc0WVJ4bXNIWk5kbWFQWk5pd0o4?=
 =?utf-8?B?c3k1WnlTVHBjTElGTXBXcmlMZklzR1NwcXU1SWtRTmRLd0UxS0pYU2xWQXk2?=
 =?utf-8?B?V2ZoR2pkN2JHOUNYNkFJNW1wdFVHQlNSb3JwMUxYbVdxYU1lakoxT1A3clBD?=
 =?utf-8?B?UkJUaXJFSDc5MjQ5dzV5VlZUdGV1WndoSXNpN3lHWWFyNy8xUFdlOWU3UWRr?=
 =?utf-8?B?OVhtYkxlQ1pZNWNYK1ZwTExORGg0Q1QwaXcwZUZQRHRyTGdVTXkwSFZWVk5J?=
 =?utf-8?B?bHNORkRlRnkyT2E4NWQ4eGVBZmJvYWlQR0dsaG1xLzdPbFVoamRlZHF4cHpo?=
 =?utf-8?B?QVdJWEJaVEU2V1hNYkZmbHNvMUdhSXRtZ0dTOEhwM1U5MXNNYjIrN1VwU2dw?=
 =?utf-8?B?SVhWRHJOdlRyaWwwSlhOS1pMVlZkeStSeENjT3pvaU1sZWN3TzA4VDNvNnpT?=
 =?utf-8?B?RDV6NFlGbVF2blNtcVNQYnBPNkxEcURTYVlXRGNyYmV0b1ZReW5mQlJSNmgz?=
 =?utf-8?B?VmEreEI2WVdxa0JQOVkrRmFrbGlKMWwzdkhVRm52bGdRbi9Wcm4zY0VoSThT?=
 =?utf-8?B?NXZMWXFFR3BocGxwbzlLQm5hSVA2UmFMU3VkM1hpOXN2dFY2Q0JCMjBtZnpV?=
 =?utf-8?B?TlpOWm1qbGlQcy9yVGpoQlB5RUZvdjZHa1BUaVh2cHQxS0ZCVTZMQnQrSWtX?=
 =?utf-8?B?c3ZrWDlubThKM00rVFl3ajZsVWxQNmMzcnNMYzg3RExyK2dGYkNySjJmNkNj?=
 =?utf-8?B?ZzR0ZXNNOTNqSDl4cmhldGFXb3I5Uk9Xd1VGcHJQeE16L2ZtbG5ZUS9JUjY2?=
 =?utf-8?Q?STzT61Ob/e/680csnHnCWv9EF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fe034d-42f5-49c1-1a32-08dc97a68182
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:14:17.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARfxBApPNCC0QymJ98ExXq745NjbopFawagkxq/oGqmpBfWtVUf8z+lF5Nsmr1LaqQ3wZHVsW6fxCBmE4GRMqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

Hello Tom,

On 6/28/2024 9:01 AM, Tom Lendacky wrote:
> On 6/27/24 23:27, Kalra, Ashish wrote:
>> Hello Boris,
>>
>> On 6/24/2024 10:59 PM, Borislav Petkov wrote:
>>> On Mon, Jun 24, 2024 at 03:57:34PM -0500, Kalra, Ashish wrote:
>>>> ...  Hence, added simple static functions make_pte_private() and
>>>> set_pte_enc() to make use of the more optimized snp_set_memory_private() to
>>>> use the GHCB instead of the MSR protocol. Additionally, make_pte_private()
>>>> adds check for GHCB addresses during unshare_all_memory() loop.
>>> IOW, what you're saying is: "Boris, what you're asking can't be done."
>>>
>>> Well, what *you're* asking - for me to maintain crap - can't be done either.
>>> So this will stay where it is.
>>>
>>> Unless you make a genuine effort and refactor the code...
>> There is an issue with calling __set_clr_pte_enc() here for the _bss_decrypted section being made private again,
>>
>> when calling __set_clr_pte_enc() on _bss_decrypted section pages, clflush_cache_range() will fail as __va()
>>
>> on this physical range fails as the bss_decrypted section pages are not in kernel direct map.
>>
>> Hence, clflush_cache_range() in __set_clr_pte_enc() causes an implicit page state change which is not resolved as below and causes fatal guest exit :
>>
>> qemu-system-x86_64: warning: memory fault: GPA 0x4000000 size 0x1000 flags 0x8 kvm_convert_memory start 0x4000000 size 0x1000 shared_to_private
>>
>> ...
>>
>> KVM: unknown exit reason 24 EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000000 ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000 EIP=00000000 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
>>
>> ...
>>
>> This is the reason why i had to pass the vaddr to set_pte_enc(), added here for kexec code, so that i can use it for clflush_cache_range().
>>
>> So for specific cases such as this, where we can't call __set_clr_pte_enc() on _bss_decrypted section, we probably need a separate set_pte_enc().
> You can probably add a va parameter, that when not NULL, is used for the
> flush. If NULL, then use the __va() macro on the pa.
>
> Thanks,
> Tom

Yes, i have done exactly that.

Thanks, Ashish


