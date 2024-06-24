Return-Path: <linux-kernel+bounces-227943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6A91585F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179D11C23BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710A45010;
	Mon, 24 Jun 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mYWT5DXr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960D1A072D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262661; cv=fail; b=d6MsVBYS+X+NFo4xppniGzN8eEZGVrhU3/gQ9EjQ5QpxDLczQLPCfz6PHzRVMlPYwrIReXFtzs5BtBo65Qx0jFN2rFjIfrj1QPHzFzP5gkKa5ZD0Nqy69rblKBP9dh61gd/hPQ9UlMUqK9NR5I8x+oYrjyl0cnrMlx9IuCdyjfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262661; c=relaxed/simple;
	bh=cpDhkiyodyEdckusF7YAzg7zMd6SBOea0fQvVT3TGis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NBxlaWFgMsFZfWd91B9B/SFcP7JH0k1vqk8p5WXAJyH3baaJMpLs7YKt2UR1SGFivToXXaeWspWzOUlLFMmgYucls/rVO5wSTBK3reU7nc8uMX1nzfW/cmhgbhqW1QvIUpLvPwxwSqeBP5C0M6WlEgrf2GlfFqK/hygTu5xtv3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mYWT5DXr; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqhjaRsiSgNiZ1WZ5VNntRjOnuaCpxXSpEE4z1L0aPEbaKGHKZQK0J3p7npjIMVK39svCaSQcJqN0n9s3z7sZLhjLyM0yaq2GEXdiSKU+TSGO8C/DP6DMJcdTWm3AVKFDtDwwi8Xkjyd31S7dWIdaI9EKsqign0QQxWDoUKXFcQERdRQGyOxAjdLiMWJTnGqhJP/aorZWh6sVMfFJW59DLfrA7y2YurqLrmwLoX5gzutEVKg/ZEFd++85HFxUSH6x1ivzSAkf8k36mUpW88fviN/5A+W846syQUU0wLqoCalQIuT9Q8oCjOhvtOyD7wAog48R3fQBBF+TNEaaNitLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B7cjJo21shFt7JhcyzkkX4ZK5NBC37Kn6V/22+2CK4=;
 b=iiWa5wGHM+U1TMZ7t6zH+q2BQrMjajATrOVnSma7TMVrmGXEhlZc8dnCWPVeia2beY96CH9ZUW8BHMqnmbAdTYg9zhgp3L8P1MloiBB8ARReFbYpdmQ1xRQxoTeHUVQ1+ryIKZG4DROdQt2Ap415Xf5rHhOcuQ2Wgkwyrp2LJrw4Axi9TBG2avIWt6eIhwQeyJqcxjrDKAhM2/+4fGA2vfekqZ8Lg+UKNFKHnrUf5m07WDyr9W9VTzbkE3kseXI5yK9dtqHYCgLWvmQ+CcBgLxtBxV1+5Qtc53DtXVQ0/noFz45y3Bl53T8jZWOEAFXtjOi0sbR4krfuuWes5L8tdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B7cjJo21shFt7JhcyzkkX4ZK5NBC37Kn6V/22+2CK4=;
 b=mYWT5DXr09P9YBE9z0I8qbugO/cYpBBIsOzJS+AeDA1Bk1dkg5aPbOOqsQuqtx3R4l5yUkRpT7KbXsoV97OwX5g/+NaOXN5zldwDEUXAO3nMCYP5bCyFW5ec1FeegIFk7IVRCCu567gLu4MJJdOY++Z/4LmMZdKUEJ3aHIj5hnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 20:57:37 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 20:57:36 +0000
Message-ID: <ba22b2d8-5621-4efc-8dc4-03b92408155f@amd.com>
Date: Mon, 24 Jun 2024 15:57:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
 <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::16) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: e162c5eb-a87c-45d4-b468-08dc949046d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTB3R3ZCTjhiRmZHV2dsdnM3MWFPYTN3Qm44dzBTTFlpcnRNVndWajVYendU?=
 =?utf-8?B?dGcwVEdiTk5MZnVYeEl6c2l1eTRubzFwejk5bzZHKzZzWU10UDZ3a1NHRXcz?=
 =?utf-8?B?UWd3QVpzUmpmKzlSQ0Y0UHd2QnhjRzhrTXJpM2FrK0VBUFgwMmhiUS84aS8w?=
 =?utf-8?B?UmttejRCY2RPUUR3cU5SRVpJU1MwRGZOMEJ2cERWekZzOUVHb3Jtc05MYXVC?=
 =?utf-8?B?bjFkRmE1WFdGY2Q5d3VJaUNzWDRjMkZ2V1lkdmZUMnU2RjF1d3RaNm9xWjBI?=
 =?utf-8?B?YURucDNlRkwzRW9PVklzckhCOXZLVUtiYk96K3diWDNnZnFmOCtYQ3hpVVRT?=
 =?utf-8?B?N3hubFk0VlZBQjA0dlplTEZIbHNUQkZ4WkVzbDZubmNxM0t1bDlHTGpVS2NM?=
 =?utf-8?B?SDZWcitsajF1OVM2dCtLcGxQYTJGYlM4Q1lsVi9tNExwNTF1Q0ZQcllxTUdT?=
 =?utf-8?B?S3pvRDlIRWsyZ2pTMkhMOVpNV3NubjIrcGgrSXZjOFFCa2RvSlRoZkFrckZQ?=
 =?utf-8?B?MTdwSTNweUdYQ1NLYnNuNGZFM3B1Zjg4L3Q2TlJqZTdRYkgyMVNSVWZyRnVZ?=
 =?utf-8?B?RGpWdjlvaHBta0FMNzd4WDYwRFNxc1B1VnB0S2JiSGVUVkxkOFVqMWgveUJa?=
 =?utf-8?B?UUY1ZVdNMFNsU1FlMkJxeWRpczd0V1VQSlZvQWFuWm9xbzFleXlWQmpOUVk3?=
 =?utf-8?B?Qm85ODcyVStub1ZCWTRkbjJ2MDhod3IvSGE5RGN4N0VBb2RGVDdUaU55ME5B?=
 =?utf-8?B?V1JieUxlNURraWtEbWpoaTlRV2k3VjZGMlJkRlJkYVlZRlZsNTBGZG52ejlR?=
 =?utf-8?B?Vld3RVhVQlVjWEdUNnFFSjVHaVBXL3p2dTlvcnJ2dXc1KzlFZnpBakpnaWZz?=
 =?utf-8?B?MGJBUFhKMFR2a2g0YkFsRk5sZzhFNDNCM01iWG0ycExYSStQenR3MWxoVy8v?=
 =?utf-8?B?djMwcHdDcHN4bzEwZkY3cG1UTnNLZWRNMzIyRTF3bGdoeW5UZ1dpMXdTWTR0?=
 =?utf-8?B?Vlp4UkVTbjBYVUNJdU5ZUklLZEp2eHAzYm9IUEQ3UGhRWXNmM3BQeFZDTFVi?=
 =?utf-8?B?cHM5a09MRXU0aDNadHRlR3dqSnpZODR1VTVlZE9MRk1PLzJNTmxOZ2IxWEZQ?=
 =?utf-8?B?T3JEVTVtWUx4NW1iZWRRRmRZczl2MUd1OHRVNmUvUEFQM2gwNW1JbVFab2FG?=
 =?utf-8?B?L1hMWTBQSFNkTmJFNVNDcjBmS0VEQjdDdDFkNVVTS2ZCcVVCcWs1TGhBSGsy?=
 =?utf-8?B?cXJtTmkyT0JMU2g0cURYS0dkMFRKUUlwSEEyZ3prZFdFZXp4VGZDTFlqZFp4?=
 =?utf-8?B?K0Ryd1V2RkpDVG9HV241enBGS3VobmJBZldiR1AwSkVDRVpBdXdSUC80cmUr?=
 =?utf-8?B?bk5SOXNENE5TRFhUZUx3akdVK1dSUHRSZVFkY21wZDJvNVdmK2pBSm1VSlZh?=
 =?utf-8?B?YTFWSUl1TFphTUVKOUI5TVRVRmlTeTlROXhUMk1Sb0QxeGNCVWFpbWFyb1hI?=
 =?utf-8?B?Y3NsQXIyS01ScTVLVXllYjluUmpTRnE4ellxbjU4MUIwcFpnTnp6RldMRS9J?=
 =?utf-8?B?VldMdEFOSVlvZ1V3S214VmtCb1B0NkszdXlDZ3BBOEpENVA2TWV3dDhzUEhQ?=
 =?utf-8?B?ekZRaWJRZWRxb21KYXJJeFlzNlZEK3RZUW8vOTZIUk8vSWU0M1V4bUk0K29P?=
 =?utf-8?B?QlhhUFBSWHU2ZXBGbDd5QkxLZDNaTjFuY1pTYnAzblBuUndNdTVwM0hSOVlP?=
 =?utf-8?Q?HPeWuxjr7lTqXqeX7FZXChkcouCcO3ki7N+4523?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGpTcy8xZ1M3VlhLT29EZENIcElJcGNzdlozRFl0eVhhQnc4eFBHbWxtVXlo?=
 =?utf-8?B?aVlJSDNZUVRpOCtpcnhaLzFvSHZ0U1FpclJBamEyK0xhZWVLT0F4dTFHZkhQ?=
 =?utf-8?B?eHdrbkdXSm5HZXNEZ1ZaWDFJN3ZzQ21LaGxKbjZpbWExODF1MVc1WjZQSjhZ?=
 =?utf-8?B?QTdPcmFlOXEvNUx2M1I1ZDg3L05qakVnU2dnTEtHU2syUm54VGVOQVQ3OFM0?=
 =?utf-8?B?ZzY5SmJOelFYdU5wNnY3YW5PS2UwdGQ3U21SNFc5Y1hZakg1RkZUbi9kSmQw?=
 =?utf-8?B?ZVhOVXg4SmJPQWRzeGlzVllyM2ZTanhrNFNMOEFaY3hoaUJvT3BEZm5sQXJq?=
 =?utf-8?B?MksyR2p1OU5JWHRkZWM2cFF6TWNiUldJR2Z4UmhuWnRtU3pzbG9xVjY2a3lk?=
 =?utf-8?B?a0RtYjZwYm1ESmZYaDhCeU8wN282dGNEWlQ3Nnc5TDA2ZU5YNUpwOWljOFp5?=
 =?utf-8?B?Vmx0aFdWQVg4Zi81QzZWRlJCblp6SlhVdUlKeTB2Q0xaVXNoZ2l1Q0hxcXNN?=
 =?utf-8?B?NWl6SkhGUUhBSnRmWHQ5eFFmQ1VWektyeStCRS9KY3VpdXM3VzZDM0Y1YzZZ?=
 =?utf-8?B?NVRFakhQUS9XY2RBb3JoYlB5LzZJcGs2VmdpQzRjU3NHcnNxOTkxVjVxZFRH?=
 =?utf-8?B?UzU4ME04VWF6V2E3WTEyS2cvUi9malNZUlg3UE9jMXpkSGxhVXdsa3JIV0d5?=
 =?utf-8?B?UVBlOFFDcmx0NXliNXFwdVNDWVA4UGhHVHVESytaNDFrUU9vSWRLaklUc1Ez?=
 =?utf-8?B?U1gxKzI1bFFFSGZ6MUd4R2ZjNGJ1cThmK29WMzJpS1QzK3ZSaW1uaWV4MUVn?=
 =?utf-8?B?UUtONFRzSEpTQm1mblBSV3A0YUtybkZtemNUelIwb0JTcjZBOEVUc1YzcTJ3?=
 =?utf-8?B?eHE4aGxJY3ZRV2o3S3hoN2tBWDY5NUJWT1dMLzM5SjBDS0NmU21ib09Ba0c0?=
 =?utf-8?B?US9DcFQrTHJXSGdlYy82eDNtK0Y1RDJwZlVLZGlpR0IvYndSbVgyV25FSFQr?=
 =?utf-8?B?QVZCckc0cUpWd1NvZy9OZ28zWU5POGFaMjRXbmxTMjJpOFdaTnR3VWlXRGlB?=
 =?utf-8?B?TVhLTll6NEVtM2NMdFRSV3g0N2dDQlZvMWV3dnRTQVRjN0ljMXpYK2hLVmdm?=
 =?utf-8?B?SmZYNDdSQWtVVGYrcjBUNklXcHlhcVpHeHNic2F6SDhONHh6dGtUZ2NrYTBY?=
 =?utf-8?B?SERaOFBFU2dZZzEzc2FWSG9ycWxrd1RZUWl6RW9hWmNJNGRNSXRNWEZES1FL?=
 =?utf-8?B?c0xVSkkvblcyMzlkVG04aFVGUnNPWlcxK1ZQRXdjVXR3Zm5WZGpZVGtKWHdm?=
 =?utf-8?B?Z01RbjZxaXRDYmNhVHRHbit6Q0d0aHpZVUU2VWRjTG15OHRJb0lNOFprbDRW?=
 =?utf-8?B?dFBCRUhJWm1hZHdRc1Y1WEJJb1A5S3ArWU1mSjZCWnh4Szh4QWE4Um9LSWRw?=
 =?utf-8?B?THd1SGVRaDc1cyt0T2hGV3hSZzd4OHh3Y2tkZ2hlZ3VKZmYzWFFQcUNKUzNC?=
 =?utf-8?B?RE84dFZ1ZHhQdUlJR3hTUE5KSnEyeW1IL2d3QVN0cm1yWGtxbUJXazJsNXhN?=
 =?utf-8?B?L2MrbDhZaWlKeXhmcVB1amZrUDRMa25RcHpCZ0xwdFF2MWZKUmV2ZzJibnJs?=
 =?utf-8?B?STRmSkc3dGVNRVF5THVlR2MyMkdvSERaekJTcGJ5NUpQTkE4eDVpa3ZHQllu?=
 =?utf-8?B?Q1k0aUxKWWdnRXNhOXhNejRZWU9WRWFMVGN6TmYzczZ0a3FwSVFHY2xEbktz?=
 =?utf-8?B?bVo1M1dpbEZrRHhlbkNDbldldnEzd1llMEdNR3FieGpaY1NHZjlIRlcvUWE0?=
 =?utf-8?B?NFdQZWxXNzUyUUxSRExzeHhITWx3aCsxbDc0RlA3OUM0bmpNSFpsMzhzdGI3?=
 =?utf-8?B?ODFqOGk5ZnRlVHdTQXhJL3ZIOHd5cHdPUkw0VjZ2eWR0WkZzWWlxNTNsQUtX?=
 =?utf-8?B?L3JoTzhFTDJZSUxpU29xV3R0dWw0SkdSYWNBMzhtdWVYSEZVV3FnMitoMDBh?=
 =?utf-8?B?UUVOMmpPVDNHRTZ3SE5pWUFvbkx0bDVNa05YL0R2aTlqakhOYlNsbHZyaW9Z?=
 =?utf-8?B?MDRQOS9yVERGbkgyWkl6cFV1WU8vL2JZSnIwK2llYkVEUjVMY2F5WjdCaVFo?=
 =?utf-8?Q?mIL2P8AjwldgTyuY+PvUTA52c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e162c5eb-a87c-45d4-b468-08dc949046d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 20:57:36.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54zKPnGfvfTW9CqdBIYrFkxNVOgod8G/z4W9VrS6TdXyYRXIwozx1tq8ClW1PASeqf3AB1+IvQvfOZDjOKznSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

On 6/24/2024 1:26 PM, Borislav Petkov wrote:

>> @@ -92,6 +94,9 @@ static struct ghcb *boot_ghcb __section(".data");
>>  /* Bitmap of SEV features supported by the hypervisor */
>>  static u64 sev_hv_features __ro_after_init;
>>  
>> +/* Last address to be switched to private during kexec */
>> +static unsigned long kexec_last_addr_to_make_private;
> This is particularly yucky.
>
> AFAIU, you want to:
>
> 1. Skip GHCB addresses when making all pages private
>
> 2. Once you're done converting, in snp_kexec_finish() go over the GHCB
>    addresses and convert them explicitly, one-by-one, without this silly
>    variable

it is simple to compare the current CPU's GHCB while walking the direct mapping, OTOH, comparing each and every address during unshare_all_memory() with all per-CPU GHCB addresses will just make it complicated and less performant too.

By skipping only the current CPU's GHCB and saving a reference to it, we are able to switch this (one) skipped GHCB page to private at the end of kexec_finish().

>
>>  /* #VC handler runtime per-CPU data */
>>  struct sev_es_runtime_data {
>>  	struct ghcb ghcb_page;
>> @@ -1010,6 +1015,169 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>>  }
>>  
>> +static bool set_pte_enc(pte_t *kpte, int level, void *va)
> Code duplication: __set_clr_pte_enc().
>
> You need to refactor the code instead of adding just another, generically
> looking helper just because it is easier this way.

The issue with using __set_clr_pte_enc() is that it is called by early initialization code, it uses early_snp_set_memory_private() which uses the MSR protocol for making page state change calls as early_set_pages_state() can be called during early init code before the GHCB is established.

Hence, added simple static functions make_pte_private() and set_pte_enc() to make use of the more optimized snp_set_memory_private() to use the GHCB instead of the MSR protocol. Additionally, make_pte_private() adds check for GHCB addresses during unshare_all_memory() loop.

Thanks, Ashish

>> +		 * at the end of unshared loop so that we continue to use the
>> +		 * optimized GHCB protocol and not force the switch to
>> +		 * MSR protocol till the very end.
>> +		 */
>>

