Return-Path: <linux-kernel+bounces-381811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8621E9B04C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90BA1C20359
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D21FAF17;
	Fri, 25 Oct 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yl3JzdI7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDC1F757F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864577; cv=fail; b=ht7JyQhAAmv/Bb3v9JwiY3sMAu4jI27eCIOL9qrb/jobvcssDIcAtoQir8rApTAdmInFLAIF0ksdh3AGsJXpjTPiANzK/Qy0DUsq/B8btpaAVfuDVavMaRf8hgZSYY+1XjCgWjg+vLhGwaWAe+orhe8swz9KjgsnbyltW2XKRP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864577; c=relaxed/simple;
	bh=JXWj/JpGpm6LrJrT5SSPhK5C02n5Ub6ZhH23ZQP84Gk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQht0/8Jshat71j9aRsGhB8jYrvzXmSTGz/JeWgIXFj2UsKnYD/RcGq3onzux2XUWQU0kWaF+/d1nVJVo9Vs9lqvCdakpae5mmhPoJ4p7dOmE739Oyv3PNoUlFeQ5/C2/admAHNV3hUJKirT9W+NiW1ZLgGWXFpF79Dxr5M92Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yl3JzdI7; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU53yoBbadgiQmlwKWskURO9LAZsqJEWVPQs5infDGlkZ9ZRz60NB9pZ95qgDVNHLNwI6kyLhb59dWD9YMFYY0OTcye0akgHRfaaz2/ZG4fz6pAaV83nM2FelpedFKc5hw/52wjmNM4gyc1FghYPg3arLIBeVOOrlXy0K3arOM8FJWX8wcviCn0WQZf+ofo/iSuqskQcvHpNYqkci0f0MBgNbn8umd0ZXAvw67+ufOMucUrKPRrGifhngItvkHzq98ebph5P+Wf/mEqAxzrjHvCBhr5nrY/hkLUC7PSq7TbBR7CNq06MdTHVpBTMXnbIGkURG+9doLHHOdOtsJnzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXsnn8XU2bzThkGNi+3wS0oPRsB5/U0ytkk0DK6ju+I=;
 b=JontRfX7LxH3XoYMchLVvru5ANtxFFZRGclAH7Hi6bAEXREcKnGx7EV/0cS4FCYdBBGFbA6xFx1PoV+3C9k5nUj3GMDmqSORP89X4kQ4mX3QwcAB3fqWxBi6NjDYVDNW6txV7QVM6v4RceKd9+xEMUrztAsvtc8B1vh/BwgDknv20P0XvgYf8DyJop3W+H+dRCvPhyspZJzOTdtBK73MGei82PMWqq8f/ah3gqk86JsiyEiQuyIyUtLGzFkFeKO1l+3gt+ukfVM3yyI7Iu0kw6e4+LW59iia3y1XMWrUTW2pBt93HEJhwgVfj0+MxoDpbhFv6xjIT4VXftLcz0C1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXsnn8XU2bzThkGNi+3wS0oPRsB5/U0ytkk0DK6ju+I=;
 b=Yl3JzdI7Uf+xsXYMLxEJC8GjASvdRy+5F+qSQemJFPzxXn+nLBS4TdPjXsR9QdF0iErglMNQvdZbvfGHc3mdciPSY5JsbuRshqu1Ny5F37YYGvYsoVVneaxZjlpngFfI24kOah1eaJvXEAFHzdQZhsvoWVON2tJAwufHW+Vdl+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 13:56:12 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:56:12 +0000
Message-ID: <528f1a15-221f-6419-3f6d-7bd45f75d48f@amd.com>
Date: Fri, 25 Oct 2024 08:56:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
 <20241025120920.GNZxuKcBsMvYTd0ki-@fat_crate.local>
 <2dcb1db1-fc1b-0fd0-f878-470cfd22e8e8@amd.com>
In-Reply-To: <2dcb1db1-fc1b-0fd0-f878-470cfd22e8e8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b91ee1c-1e6a-4413-5f38-08dcf4fcc93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtjb1huOC9MUDhuVEJBMTcvdjUvcjY2Sm5NTkQzalJ6L01YVGtIN1pDbFNL?=
 =?utf-8?B?QzRXYU9QNVMxczNHQnlkckxTcjZqU084SExmUUZydEtnNGlmV2Nub0tCSm9S?=
 =?utf-8?B?SllIbnBGWkhNcWkwcjlVb1BPV1laamRaUUVibnhtb0JMVk00anZVbFlOSHRn?=
 =?utf-8?B?ekQvWE5GRWRVa3NJSCtaaEZyazF6c0lyQWV3eXJzQ2FKdkVBZmVKb1pNODI4?=
 =?utf-8?B?cFpmRVNlcTZIaldvaWd1YVFYcGU0VTBDNnAyYjE2eHdJRjBjbzdReC82UVRL?=
 =?utf-8?B?SGw2UVNtR3lpeEE2ZFN2b0FqZVllL0lsT0lyVDFHVVppWHpvUisrdmYxSlhX?=
 =?utf-8?B?a3ptY0pvMEo4VzJyR0xPM3h4N0h1TnRCMTFjRUJpZmZwbFVxS1RoK1ZJdy9k?=
 =?utf-8?B?WEY0QzJLSWpKSEVqenBmQVRUVkgvbHZ4THgwcDlsTWdxSEhwQW9UZDZmcUdZ?=
 =?utf-8?B?dHJIcFdOTTJXSWViWGVabW9JK3djZCtWOXdNSnFaZGlpaUdOeU9id2VhVkw2?=
 =?utf-8?B?LzZRanVRMjhHMjNIVSt1OG14UytrTktZc003L3RXUEVpeDVta25Vb3RxcVRN?=
 =?utf-8?B?S3VkTlFabWJzM1R1WlFndm9ZS2RMVWJQTjM2ZkpPMEw2elNBdDNpTzZaSk5Z?=
 =?utf-8?B?Q2dJRVM5VHVJUm1mR3k0MU1pMUYzMXplYms5aHFYM2taSVFkK3AyT0VDbThj?=
 =?utf-8?B?M2loYk1GTXBwYjBhTWliWUFTN0VhelR0RTBQUWh0aEMxV3FnNWlwREFOc05N?=
 =?utf-8?B?ZzRqbXJLVDducHBGQ0NkL0lEYnFvQmNpVGtJYU1jcDRJTGxUZTBKcU9ITmVv?=
 =?utf-8?B?YStVRVZTNDkyRXdlTGR1Zlp5dmNxQmxrKzkvTERMckpiRk1WeDRady9PVW5i?=
 =?utf-8?B?T2pWYk9nZnVZaXlwYXAxTGpURWtjTEZMekFBQ3I2STlzdy80eU0xRkpQRHJi?=
 =?utf-8?B?NklEVTdJY25CR0JsY3d5d2ovOGxrdzF1ekgxb3ozTjVuNy9KN0dnc1N3eFFI?=
 =?utf-8?B?YlFJZ3Bsb0o5S0NmZmZJY0hxdVNqNkZaa2tXMmtPcEZjRVdYOFJ3OG16cTli?=
 =?utf-8?B?eEdPZUI0MXczOFZibGZxYTF0bG9TNjl2dUdSRGhscE4rdWxxT1lFendQOG5M?=
 =?utf-8?B?N1BpUHFyQWdhVTRYenRpNHo5M0RuS2ZKQnRBdVNvNnVwL3lXN040OWFvZkNH?=
 =?utf-8?B?aGxFQWVhaE5wckhYM2pkT3BBNEpQV2ptWWh1V2UwQ1Y4SXNGOW1DdWNkcEla?=
 =?utf-8?B?OUFwd1FHNjNLbmZJMldlWGIrbTd3aXprbS9TV1pOUHRwRE1Tb05uSFd1S3Qv?=
 =?utf-8?B?eVgvOS9YKzBLUVIvVFRrS25nVmJ2NHdvb3Vvb3BkeGNtaEFYdlYxRE9RQnpI?=
 =?utf-8?B?ZzRabmlTQkJEOTE2dFhVVml3L3A5N25iaHNpVDlndGlZRng1elBiR3FtaE54?=
 =?utf-8?B?Y2dDeUdTN1phKzk0REttMmdiVXliRHNjdkZRdE1Ic2tXRzRHOS91eFdJWHUr?=
 =?utf-8?B?MWVUVFlSL0ovcnkyTm1zdWw0dDhEVzd5cmw4VWN5RHkwRFIxOW0zTUlFWDZu?=
 =?utf-8?B?RThKTDZGbksrM2twR1ZSV2tDcnMyOXdmeEFEUFV4UndNRWpra1R5empTbjln?=
 =?utf-8?B?MEJDZXNJaWZSWm0zc1JrVElZVnpQaHJ4VG8yL1ZBVUNaMHJpb3pVTGFSSXlC?=
 =?utf-8?B?T3JWK3FiVjZaZms5S0ZSZEthOTRRdHlxSENaMStGQ3FuWUtQWElWSCt1b3Jq?=
 =?utf-8?Q?kt4tRt8h7Q0zp+lPmT4Wf3ackK35xPbWS/q9v70?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkZaMEdYc25hSlVOd0tlclJ5UnBuT2V3VWFtQzVwcXpiWVhJUDByUzE3VWlX?=
 =?utf-8?B?M3pFakdUWjBqUGI4QjBiVXlZdjlFL2VYbTN0M25DYlVocEEySzRmUjd4dFR3?=
 =?utf-8?B?R2ZBOVB1K0ZUdEFiRmRoNUc2cW9qeXlnVU5KcmZWN29ZUWpwSytCTGtkQWU3?=
 =?utf-8?B?MGYrZW9nS1FsSkQ0WGZpd3gyTmpuclF6ajVoejdRcW1nWGtnQXlVaWMycUhx?=
 =?utf-8?B?TkRaVk83aURvd3lLd0RzU2lXN1RXK0ZyN0p4QkVMa0cxdWwwWFcwZGNCTTRm?=
 =?utf-8?B?b1pWbFUrZ3VORUtWZXgyOG51c2xrM1pKWE9GR1V1RHdaNlZDM0djRW03VkNp?=
 =?utf-8?B?cURwWUxHUW1GOHNiZUdnaW8zc25NdHI5anhpMzVmU1ZKaEk3RUEyeG94bHZp?=
 =?utf-8?B?b0JrY2VtdUg2NDZoWlRzR016QWZxTW42SVdyOFZNdXV2aFkyakNrYUZ5b3Vt?=
 =?utf-8?B?dExqdnR0Njl0emtZOUdQcmdRM1g5TUJ0dzVTbzJoUTdYbVFhdmpTRzRhYmQ2?=
 =?utf-8?B?ZjJQWktoZmJYTFFFQ0w2ZnhBazhjYXloNFFjMVRpWUVGL2lHeGpvMS9QL1Rv?=
 =?utf-8?B?NURLckZuNnVMcnpCQ1JIQUNuYW9Bb1drS3RuM2puWnl3UlNldnl5UlAxZmVs?=
 =?utf-8?B?eUtzMW9rb3A5dm54UzVYekpQM0czRlNzMWZCcXpkZWppRlJLNEtPdTcyT21q?=
 =?utf-8?B?cVZXT1VZbnluN0VZN0hRU2JGa1ExSm85VEN2WlVESkhBUng4WnlBa01hR1Vk?=
 =?utf-8?B?WDlPb2ZjVmJOUElzYS8yZkowQkV6R3VueVRLWlExLzBDbFJLU2s3bHdNclh0?=
 =?utf-8?B?M2VkNUs5YzdQMGlIazhZZUh0bFgwd3k5RUhWTGNLWnRiOVlLMUVpZkJ4elNq?=
 =?utf-8?B?SUljNGRSVUEwNmlyZ0pBOHRNd2lTNkpXRWtxL2ZyazhNY01FWnRLbzVSdWt2?=
 =?utf-8?B?a2RBSU9IS1FYR2RPWTUxWmdGSCtsNGxGOXMvUUtVTS9JVGJCOTAzQWc5MGdF?=
 =?utf-8?B?alFDeHJESG5yMTdXcUZIaU5PS01HTXVqQ1ZiWCtpTzh4d0xYd2Y1a041VTRy?=
 =?utf-8?B?WTVKOGgyZWtUMGhPbU8vdmRiL3pmclg5MXVQZ2E4dGloQUlkU0dBZnc0dk1v?=
 =?utf-8?B?NTF4aUpBMTd0bThVd29ENWh1TnhsVVVHWWpydTdIUWZhb2pZMDY2QSs1Y3Za?=
 =?utf-8?B?NWtYcU1YbndBdm9TQlh5TXZtYmN6RjRSNHBsb0RpQi9NTEpFRXppRW5OTFAv?=
 =?utf-8?B?K3VPTlRmdXNHNktRQ0puUDhFbXNUYzIvOHBLTitRN0VmdUVocmxUa0s4L0ZS?=
 =?utf-8?B?TzRlV1ErYjVNeDQzRENadzBra2sxeWZHZHRXZE12RG9vZ2pKTU5adUtJYlVi?=
 =?utf-8?B?Q0cwaHY4djJQOXcxWW1hZlh3ZlZDeE44WDkrb01WenFrcStjRlBISjJteGVW?=
 =?utf-8?B?Wno2TE84dURCZVo3VkI2QjhpamJwZU5EeUZsVHI0SjZ1amFQMnB1bEN0U1gz?=
 =?utf-8?B?ZWJGZzNWZVprZ251Z0tzSjNJVjFGaU1pZjFPUENLalVZY2wvQXovMGUzbTVO?=
 =?utf-8?B?S05RV0kxc2F0b2UxY3ZOTFFpY3ZiWGVvbmtyTlh5c3NlOERSRXMvTkxkK2lo?=
 =?utf-8?B?VmR3M0hISDFLWkRWVHdjbHBwb3ZLZ05vUHA0UCtmSFZJYmRlb3hYLzlsU2dk?=
 =?utf-8?B?VlNjKzg3TW1wZWY0cVg2Mm9yVm9oQWlZaEdrUURNVEZoSW5CRnE4aFRHNVN1?=
 =?utf-8?B?ZVN4VW9ieWw5MFEzbTJ0SmU3U3poR0NET1UvK0taemRVSW5LQ3FnOEM1c0Rm?=
 =?utf-8?B?Q3Z6TitjN2NmYlRTZ3JaUzNKL3QrbWJLak9Gb0RBZWxFVllmVFNsTEFVSml6?=
 =?utf-8?B?VEhGSVdxSzR2Yk5vVDVHeWlqekZEK2JGRkU0R2xrQnBab3JNZ1NVeHJtVGxL?=
 =?utf-8?B?cng1aWY1VmtlV2Z6bFRRMm8wQk9SSHRTdG1OK2RFMytOVFdNc0JIaUR3UVRa?=
 =?utf-8?B?MktFdlBFNW9DMGpIUjNjaDh5MGZ4dUk3cTcwQ1F1cjlsN1UzdThxSGk1TDNO?=
 =?utf-8?B?c2wyTUViT2h6WGJBS05BenpIczJtVm5NZEttSVRSTmpiUXlUeU9WYmJWcnNZ?=
 =?utf-8?Q?K86MfktMnCJe+7mnylsVwt74u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b91ee1c-1e6a-4413-5f38-08dcf4fcc93a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:56:12.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9ZDY+AD39QW9kXh3vpafm1uM2rrMnOUwVoxLoWturfs1TlqbpDnjMCCGuQ9nE9zshPGsbvu9cxr6TLfknvzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205



On 10/25/24 08:47, Tom Lendacky wrote:
> On 10/25/24 07:09, Borislav Petkov wrote:
>> On Wed, Oct 23, 2024 at 01:41:55PM -0500, Tom Lendacky wrote:
>>> +/*
>>> + * The RMP entry format as returned by the RMPREAD instruction.
>>> + */
>>> +struct rmpread {
>>
>> Hmm, I'm not sure this is better. "rmread" is an instruction but then you have
>> a struct called this way too. Strange. :-\
>>
>> I think you almost had it already with a little more explanations:
>>
>> https://lore.kernel.org/r/20241018111043.GAZxJCM8DK-wEjDJZR@fat_crate.local

And why am I not getting the replies you made to the v2 series but getting
replies to the v3 and v4 series...  very frustrating... can't find them in
quarantine or anywhere, dang email system.

Thanks,
Tom

>>
>> The convention being that the _raw entry is what's in the actual table and
>> rmpentry is what RMPREAD returns. I think this is waaay more natural.
>>
>> Hmmm.
> 
> Just wanted to show you what it looks like. There still is a lot of change
> because of the new argument and using a structure now instead of the
> direct entry.
> 
> I can change back and maybe add some more detail above the struct names if
> that suffices.
> 
> Thanks,
> Tom
> 
>>

