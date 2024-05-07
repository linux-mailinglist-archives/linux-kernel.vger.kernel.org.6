Return-Path: <linux-kernel+bounces-172156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982118BEE37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66F31C21C38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D82E62C;
	Tue,  7 May 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ngDHoy3o"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F27E8;
	Tue,  7 May 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114465; cv=fail; b=Q9hAgmRHZHEq9pyslJLF8vipXsjM4rdHZh3UJnkEWnCcnbXpHt2Y+cZwS9eJMYQGmdMmUyOgX6iTW5FRwzjZlXa067ec0cl7KBVOJ3U/699Z1THCk5WuNrThxLp9xpoeZ4aAkZ6jKj42HFnzSI9iRgtBbw1DVCm+I2v5YIHPlcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114465; c=relaxed/simple;
	bh=+8IGmpzmQ6xYi7ewfWIAWv9Sdx+5CIoiFcNWLvVe03I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GmeGn5XGJsPG/kaJR/MZHR4JDt22RuRI4WGVACO07ytP0WC1/EWe5AbzryQ2CBImNohOJZLxcQveRoqxaHfhZyTZ/+sjiHdbQG8VfcbxQD3z5636kNE3qhxFuaD/H3R2UQL+8qgz9kWg+XC1L9iVgp3JBzqJTAL20RUWBUm0POw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ngDHoy3o; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em59cu8AIIPKO7ss804M8Ch1iQGstQajV9mo0e40PixkOlrB+2KmiDeno5Ba9mlWiSLQhCKTZI+FBb9NMmyIsvwbhK6zWchTMwAFDUaJiZf9Y0pn89dkCuDSLcDYgpne8W0rgwq1zj9eoxndG4Ei++C9ScE25SMxLWeE54xOBgLIBpbcYrpliNO85/V/zGNU0rRkRiWeucP8EaAE6oU1st2pYheveXuokp0io59onH/gV2QyR/6cOhUfzNM/GdOqwcdbvbTKQF9xZo1gjHTWzQka75yPjw+4vSzmzz/Ngg0W+wiqt2Q+ISs/AhY98UMpK0uePtZTnxo5yQobgw+G0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enf11JMOmvnRMxfvDjBOIoMwts3myPoVm/BfDff0qCA=;
 b=cR0qBsRUPqHJeX6EaZacNEy74Yl+yIfZntX12P2UvPyt/IqgTKO8FCi9OsAH9vFptvMwtzfuNKrSbNjglBiPHvuE4bDm5MaBv5UuuOy7YuXoXWb+5I+W3GK1f7L+OB0BxxOPv5vBjStJsylkkL4kis5em/kCY6gRz0CnuyzKA26LxNAJKcGN3+rI1KzAgZmx8WJ1J0MVy4+HdBfJSSEFsTN58AAvGsEfWdpnEN8m4AXXxZwRV5LCjhKULUXvsriDo8KTRWrxxfpgP9XlEBOgpIr39QrSgWXPvEzePGgg31QhEYWjlMkgBdPmD8MAzOEB8DjFeckAC2qkr7ZyZq2Rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enf11JMOmvnRMxfvDjBOIoMwts3myPoVm/BfDff0qCA=;
 b=ngDHoy3oZYUwDKdjep8wsCRAiGxtPT/SM2jhuzGrU2hVLzflJ7dUfzWwC1ksYWZeCXBXSG5Mzma6jbtaWUhAuPPksbqnyYj3yl3f1Wf0TkAa/ziXHT7DC3bNPu+BQwrDpa9B6tz6mHaTY/D7EESNYKq7VrcTt8v+SiG6jsZHa00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 20:40:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:40:56 +0000
Message-ID: <b367a6ba-3ff1-4173-bf71-cd7a04bf9882@amd.com>
Date: Tue, 7 May 2024 15:40:52 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 10/17] x86/resctrl: Add data structures for ABMC
 assignment
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <c3103dd30bc07070380a01922f66208759afe837.1711674410.git.babu.moger@amd.com>
 <3149b62a-b9a4-49c6-a757-5a0e36df62df@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3149b62a-b9a4-49c6-a757-5a0e36df62df@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d343bce-1725-4662-78ab-08dc6ed5fefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2ZsSmJ0Y2xCTFdmOVA4NmxoTmhJdndNWUJ6cEZKbGVBRi9LWHRsdWJlTitx?=
 =?utf-8?B?dy9xZThwa3o5cjlIUlNKb0hBUDJjNmhZaGROakhUOTN5cVY1R242T1JHbjFl?=
 =?utf-8?B?TStIakNNaStrWDV5NVRJODgzaHpIcitIODVIWFZnN2U1OVdEeDhPUkQ3ZTVL?=
 =?utf-8?B?aG9FSFBhU0gzRHAwVVczVEFZUWc4V3pOZVJOUXdFVUs2RGJjaHdtZlJHdm5Z?=
 =?utf-8?B?Z2RQMytlajhzTDRwYXBuWGthZHVGempaN0FRUjBHTmlDWE4vOW9ONzlTQW5F?=
 =?utf-8?B?b2oxdTNoZ0w4eWVUcDM3aTd6a25MeTh4NWhRdXYrbURiMHErSjliODIzTHJZ?=
 =?utf-8?B?dFQwQThOQjRaT1FnYytsZzdHSDFQTGEyWW5CMG1vK1U2YTF6aHhFQ0tKSERO?=
 =?utf-8?B?T1ZtZHh5dGFTTHpNd00zSWRnVG04Z3VXbzN2czVtZ3JSVXV6Q3FBK2R2SnB4?=
 =?utf-8?B?VmZTUEVDU052Rlo3c2xsVjZtR1drdWlPWndBMUJ3RnRtWDloeVNmZXBVdDZN?=
 =?utf-8?B?SUxwYmtkSVlUb21CWlBKUWczNXJmL0tuMWZySmZoK1ZBN0h5eWZBLzRIWDRS?=
 =?utf-8?B?WmFiL0xYbGtENVY3NHRYNGJBT3M4Y3Z4R3lDdGducHh1eVZXRG9oRGNlbTRC?=
 =?utf-8?B?VDRmYkdKT2tzMWREZS9nMGVHb0swRnV3QWdKODRzZlcwWE5YMFRUUXhwZUUv?=
 =?utf-8?B?R0pnZ1pQZTJ1Y0VVWDl6YVdaMkJ3MlBYYWs1Z2YrbWl0T2c4QzdrTS90OVcr?=
 =?utf-8?B?dk1nUDZac2dheU1VdnlyRG0xaGE4MGZqaGtqVEd4dUs3NE8rdEFSZGg3OERa?=
 =?utf-8?B?VXZuY2FVVFU3cjhBQ1JNaE1Nb0dsYU5jcW4reEcrbWhYbitYTmhRY0ZVZ09s?=
 =?utf-8?B?NmhFeERXU3ZkTXljYzRiZ2tvWWRMdnVCZGpGLzFXRXBWSlZ6NGRvQVJKejhQ?=
 =?utf-8?B?bDJLWWNiQTUzbE1WWThkdnkrZml2bUNDSVRKZm5CMWIwRmhYRWtlL3YxYkJO?=
 =?utf-8?B?Zk1TR3lCSi9wNy9LWnVodlpLdmVjZmUzejI5OFU3ZG5DWjE4ZE9LUHRMcTJN?=
 =?utf-8?B?S1hSZDVLWnphVVdua0FpdTNkR1dwWFFkc043M0wrcmtkOGlZWWdna2ZjOW5Q?=
 =?utf-8?B?alNqcDgyRU9kWXREM1lKclZ3dmFzYTI1bmtoQXZrSkgzOUF1cTVoVklGRUMw?=
 =?utf-8?B?aUtDZzF3SWRUbDhqb293eWt3cDV3ZFhjNTJFVDNkVFB6d3U2bGpxczZVMjNo?=
 =?utf-8?B?S2ZTTnhISWlBQTNzQ0pmSHlWMzRya0xTUFlwNTFXc01TUDB3WHFOTjlIWUd3?=
 =?utf-8?B?WmYwZmV2akxVM3NsM3k2NXlBbDZzT3Y3c2FrRHVBNW9ZVmpTd3ZkRDQwblJJ?=
 =?utf-8?B?UUowSFE0NFJRMDB5MFIrVTJRd2w5akxOM1M1SWVYaHhFbE8xQW9PMS92K1Bx?=
 =?utf-8?B?MTV3T2tyYzVVZ2JUNUFZbXJkSURWZlJBUXgxMFV3Q1Jlbm1qRjFHTndjZWZC?=
 =?utf-8?B?ZzdQQTJuSzJPcndVUXMreFFpa2swQzlCY3o3cDFPNHhxZ0ovT1dVSVJIMks1?=
 =?utf-8?B?bERYU2d6dUljNlExM1lRMHBFc1JGTjNmVGRxTDN0TWFUaEZiWnRydVlTdGpy?=
 =?utf-8?Q?itzG2nlxI70DqlPa8fHM4XoBKyNR3ennKltBetWIQ1mo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCtTbmd0TzEvbVNtTm92MUpsL3FDT2lBdFIzTUt1UGVUMlJsRDMxTEhFcmgw?=
 =?utf-8?B?QU1hejZlRys4TG9vcy9FV2tLenhLMk56NWEvcWU5eVpZZnZvT2hRZ2F0bDRx?=
 =?utf-8?B?SUNzUFJPa3pZQXNpSXFsOHlpRG8zaklBWFo3TmpML1dNSFFiVEkvNU84NGZv?=
 =?utf-8?B?dUNqWWY0TGdVbG9CcTF4S3ZzZm1oS2lIZWlWQlBLbWFDK2hFUEh6cEY4emlM?=
 =?utf-8?B?eWQ1V1FkNnRoRUtiOE5aOFhoMXNTVmVCL1FLTnU1VnE3d3RPaXhOd2FMT3I2?=
 =?utf-8?B?YWdYWGQwQ2IyWTdlUDcxTDFCTld2ZHlTbnVMUFBKemQ0dGRXK0NMRGpSbWNn?=
 =?utf-8?B?MnZPaVlIMTVZbWR4azBrUjYyMVpLNWNBcCtoV0I4ZmRQeWFTd0l1T252SUZ5?=
 =?utf-8?B?VGx3V2VVSkQwTzdMR0JWSWJYNkZIMFk0S3NMMXhHVGQ0WHZISklKUkduaHp3?=
 =?utf-8?B?QkNmRUdMU05tRDFnWUhtM1Z2aUFvWmM1N083MUlLNWIxQnVZb0RzdFFGbWZx?=
 =?utf-8?B?YXZlUCs5R0N2cHVJdjd0NjREVndFUktta0Era0lVRWxEdXcwRDFWOFYvbG5X?=
 =?utf-8?B?RXpsblFhNXZ0amFOUUFpNk1FeHV0NU9FWHV4ODJ0Ni9wcWpGNnNESG9xK0JQ?=
 =?utf-8?B?YzdpdzVyaDltU3lzYW9MU2JIaW96RjE4dnZwS0NFSWZwemtPWHdqQlF1Wm5H?=
 =?utf-8?B?Mng5aVRtYmpGVTVNM2FMcnBxb04yWnROR2J3QVMrck9WRmdzalBsTFhEeGp1?=
 =?utf-8?B?S3hCMjIxYkZWSFBOek1Mclc4MWpaNVdqYzRvSTh2bXdSZ0FVQjdVamk2S2hl?=
 =?utf-8?B?TlJlYWRTS24rcFdyejBaTk9ta2tndG1RUUw5ZCsxa0FINjlVSzYzRFBBUHRI?=
 =?utf-8?B?OU9IZG9selMzRlZNcmJ1UE5Za2RjWUp4Z2lXZXhqVHJWUTlDYmczeWxtYmpQ?=
 =?utf-8?B?OGdwaTUyK0pxaHhjUkFZYnNyM0Q2MkhHMDRaSXRQOGJCaGZSVXl5N25EM2NY?=
 =?utf-8?B?MVpGZ2RQaTlSODI1Tlg4YWdYZVFkTTBmbXQzQUhlcHl4NzYyNW9vanNCZGJ1?=
 =?utf-8?B?TkxZOEhzYmlUM2xjQ2VCK29aSDJQQkFIUVpSZ1MzSll0Ujd4cmxoN0dJQjli?=
 =?utf-8?B?c2x4WGRQTDkwYllEZzZFVFRvZStTRzJKRjFTVEE2N2RpamJKdkN1ZVJGWDB3?=
 =?utf-8?B?MjdXbkRVcCsxcWdTN1RnQWFKdkJUZmJZRFNzbzh5ZmJWeXA2UzRPQmxINC9t?=
 =?utf-8?B?Z2pRRmNwMzh0UkFqaGRocWhEaEluUGZ6akJFM1IzY2oxejRwWmwrWDZxWTVI?=
 =?utf-8?B?Y2RpbkR1N20rQ1ZGQm9NSlR4c3BLVlR3REJnTlMyNE8xVkR1Y1ZLaXAyeW1G?=
 =?utf-8?B?THJqbXFkRTVUV3NQUGQ5U1hsVGFydXV0aHB3TjV4Ym9RK1pBNmNobUFJNXh2?=
 =?utf-8?B?NXEzZTlzbnFYWFFIYXA2QWJ0WGRaSnpCVzBJS2c1bFF0SEN3QWVKUjMrNStK?=
 =?utf-8?B?bGxEamNxUVQvcmxnSmprSzMzUFBpREw0aTZ3Z3hYZ0txU1N0dnpHWS9BN3dO?=
 =?utf-8?B?cHhuNi9TaEIrZFdCME1wZWlNdTlMWGNBbzAxMWNNVG82TitSZHRzaFpDT2Ns?=
 =?utf-8?B?OHltRVVHb2NNdG82KzhzMzBNbzVOTTloR0ZqTzFERlBoeUhrVHgvejRVOXJY?=
 =?utf-8?B?UDNTVkgwdXVoNkx4eEtXSHJzUjhZVkRBWkErZEN5ZS9JSWtRY1BDcWFhdmdK?=
 =?utf-8?B?b2JjOEdYekFLNUZQVkd6YUQ5K3YwVnRYZWM1Q1BGcXEyeUFWMFkzYklDVFhC?=
 =?utf-8?B?OUJ2QkZOT1JML0N0VjFRT2VKNGpOMHlYeXQ4OHlRdFNPT09MSFBOYWlOUmt2?=
 =?utf-8?B?Qjd0MXd3ZXpGM3RnNmxJOHZCYXVLekJmcEhUTEFSclZ1QkFuSUlUa2JpZnlx?=
 =?utf-8?B?Q2JHTFIybnVDRE9Rb0p6L3d5ai9yVUsxc3duWUpxNWVSNmF5eVNjOHpEaE81?=
 =?utf-8?B?N2JCOEYzMmNUcXQ1bUpVTm83R3NCYnJLRE9iOXFXeUU3VXJmVSt2KzVyMHlC?=
 =?utf-8?B?TTIyVEQ2OUc0MWFrbjV6L1dvM2kxTTd4MnloaDJRWlRTSVBzL0ZVblZwa3or?=
 =?utf-8?Q?JTdY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d343bce-1725-4662-78ab-08dc6ed5fefa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:40:56.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybaZsoooxyAtIT7XfN169MLOR5nbov4rhba1COQYxyER/4O8D/Zjy+0DaSUIoZzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401

Hi Reinette,


On 5/3/24 18:32, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> ABMC (Bandwidth Monitoring Event Configuration) counters can be configured
>> by writing to L3_QOS_ABMC_CFG MSR. When ABMC is enabled, the user can
>> configure a counter by writing to L3_QOS_ABMC_CFG setting the CfgEn field
>> while specifying the Bandwidth Source, Bandwidth Types, and Counter
>> Identifier. Add the MSR definition and individual field definitions.
>>
>> MSR L3_QOS_ABMC_CFG (C000_03FDh) definitions.
>>
>> ==========================================================================
>> Bits 	Mnemonic	Description		Access Type   Reset Value
>> ==========================================================================
>> 63 	CfgEn 		Configuration Enable 	R/W 		0
>>
>> 62 	CtrEn 		Counter Enable 		R/W 		0
>>
>> 61:53 	– 		Reserved 		MBZ 		0
>>
>> 52:48 	CtrID 		Counter Identifier	R/W		0
>>
>> 47 	IsCOS		BwSrc field is a COS	R/W		0
>> 			(not an RMID)
>>
>> 46:44 	–		Reserved		MBZ		0
>>
>> 43:32	BwSrc		Bandwidth Source	R/W		0
>> 			(RMID or COS)
>>
>> 31:0	BwType		Bandwidth types to	R/W		0
>> 			track for this counter
>> ==========================================================================
>>
>> The feature details are documentd in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
> 
> This changelog is purely a summary of the hardware architecture. I have not come
> across a clear explanation on how this architecture is intended to be supported
> by resctrl. When would resctrl need/want to set particular fields? What is
> the mapping to resctrl?

Something like this in the changelog?

ABMC feature provides an option to assign(or pin) an RMID to the
hardware counter and monitor the bandwidth for a longer duration.

Hardware counters can be configured by writing to L3_QOS_ABMC_CFG MSR.
Configuration is done by setting the CfgEn field while specifying the
Bandwidth Source(RMID or CLOS), Bandwidth Types, and Counter Identifier.

Add the configuration register definition.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> ---
>> v3: No changes.
>> v2: No changes.
>> ---
>>  arch/x86/include/asm/msr-index.h       |  1 +
>>  arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index f16ee50b1a23..ab01abfab089 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1166,6 +1166,7 @@
>>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>>  #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>> +#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
>>  
>>  /* MSR_IA32_VMX_MISC bits */
>>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index b559b3a4555e..41b06d46ea74 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -106,6 +106,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>  #define ASSIGN_TOTAL			BIT(0)
>>  #define ASSIGN_LOCAL			BIT(1)
>>  
>> +/* Maximum assignable counters per resctrl group */
>> +#define MAX_ASSIGN_CNTRS		2
>> +
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>>  	bool				enable_cdpl2;
>> @@ -210,6 +213,7 @@ enum rdtgrp_mode {
>>   * @crdtgrp_list:		child rdtgroup node list
>>   * @rmid:			rmid for this rdtgroup
>>   * @mon_state:			Assignment state of the group
>> + * @abmc_ctr_id:		ABMC counterids assigned to this group
>>   */
>>  struct mongroup {
>>  	struct kernfs_node	*mon_data_kn;
>> @@ -217,6 +221,7 @@ struct mongroup {
>>  	struct list_head	crdtgrp_list;
>>  	u32			rmid;
>>  	u32			mon_state;
>> +	u32			abmc_ctr_id[MAX_ASSIGN_CNTRS];
>>  };
>>  
>>  /**
>> @@ -566,6 +571,24 @@ union cpuid_0x10_x_edx {
>>  	unsigned int full;
>>  };
>>  
>> +/*
>> + * L3_QOS_ABMC_CFG MSR details. ABMC counters can be configured
>> + * by writing to L3_QOS_ABMC_CFG.
> 
> There are many fields in this structure ... how is resctrl expected
> to set these fields in order to configure a counter? Please expand the
> comments.

Sure.

> 
>> + */
>> +union l3_qos_abmc_cfg {
>> +	struct {
>> +		unsigned long  bw_type	:32,
>> +			       bw_src	:12,
>> +			       rsvrd1	: 3,
> 
> Considering how "reserved" is spelled it is
> unexpected to see "rsvrd"

Will change it to "reserved1" and "reserved" (below).

> 
> 
>> +			       is_cos	: 1,
>> +			       ctr_id	: 5,
>> +			       rsvrd	: 9,
>> +			       ctr_en	: 1,
>> +			       cfg_en	: 1;
>> +	} split;
>> +	unsigned long full;
>> +};
>> +
>>  void rdt_last_cmd_clear(void);
>>  void rdt_last_cmd_puts(const char *s);
>>  __printf(1, 2)
> 
> 
> Reinette
> 

-- 
Thanks
Babu Moger

