Return-Path: <linux-kernel+bounces-430263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0899E2EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F84B2E154
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F161DFDB7;
	Tue,  3 Dec 2024 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5O1b2aG"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8E1DE3CF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263357; cv=fail; b=rfbQdI2rg8mYBp8wQosDL6iwvR9h3j2ALopsFE/WlIlwY7sJXIu2OHI1KMHDr8QdXsCbCuViGNAE4Y0KNi/mg+GYeM3hdVtGCFsqZa8YVaBEWYLDXyftA9oyPkmZAVDe9LRXgzwW4ZpVaD7z63CwvaeR12iKmZSrOsYDhSxeb5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263357; c=relaxed/simple;
	bh=mmKBsLQNwW48J3hPyoHMAp8FMSIfLpE2W4sgHQvBh8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EEkT1Qs4TVRLzZOpnX8pysVfd8O/pZByzDmBqvsfREqC7FQIxHHVQYiznkQdGMtphcfpEv+uadccjcuHEIxITzkqLh6pjmb2GZa0Pf0yVw4lx+Owbqo2FFWgAkM0U8M4RRNbSrDjxikSqyY2aF0SXeNgSSLOli4PCSoRX9P9V0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N5O1b2aG; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm4N1MGYZr/skOkAvrmefnFgWEsNonyTN8v143uRPTsJWSRPkG+AdRkDgOA7spmR7Z4s6yyNtXsukMLI+FW+bsT/1x5Dijf/GqOn2lV5e0EFd+r/j1CgkkvXeL0D3Ly9DNcxocpFg7En2zOETchYo4qAXSYlcppuUvM5cT92jhtsS6P+ZG2swbJ2Q0lS9SSOuioOvn00dFWAU1erWE3FtC+sIWx/SyONiAsVlK8Gg/0cB+W0JhKSpmcSG6LKbjffjxe3OSTZ2XIMCbYZuhKZG0cwlMDgFrbDbeVpf7JySy7qPOP8duHc5uN/K5epFYK2CB/8Qqw+quMho33IhfVcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPpFwAynRzSatSTC0SbcZshFvKBpIqFYojGAMmHgUlI=;
 b=P111JZdPjHdEuoHAem44XPfbLFIHIAGwSEdssEnrGDNEJW0wwpDA5mXVsUHuQyXw9HOfjpcSF1gUy5ctPIjP2fA0wuvCWueFkjA5haU+WnitxM5cqU7Ldiql+QSD8ff88BuApKZdk4Ix/3zmLkQRnkWfqQA++mIH5Y12SmHqmrQZFqZUxLtV/497U7NsTQ7C34bzxUn5G0PFe4UhCUKxpEGT2Ua9hAt06N/V5rEoJhrCa9gQ7SIUh8RBwqiOkipZ+SYmRadFgjl+kjMavbh7zrqOf8vaS2+F2p0hxdB+4na7tU9w8lRS3sUUf/c/fLbU0JetL40mJVfFruCYEmb0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPpFwAynRzSatSTC0SbcZshFvKBpIqFYojGAMmHgUlI=;
 b=N5O1b2aGUFfhlMbYvKNJVKw0FO/wMiR1xvDa12wm6Y6kOujYMSM0oI8sdfkvozyHi1y/PrioCK7c8DOZq6cG42Ninlhls60EmY9irkJAfGUA/fT3jZIhqP/GEnhojkW78Blka+TeIgp0JHhP2oCtc+QlSKNBIgQDrb7F2ZCxvqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:02:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 22:02:31 +0000
Message-ID: <f71aff95-3aea-4681-9d35-9847b086cc8e@amd.com>
Date: Tue, 3 Dec 2024 16:02:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on
 systems with AMD preferred cores
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, Perry Yuan <Perry.Yuan@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241203201129.31957-1-mario.limonciello@amd.com>
 <20241203215454.GJZ09-LmEWPZ502B7R@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241203215454.GJZ09-LmEWPZ502B7R@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 1455483b-8ee6-4564-817b-08dd13e62f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aldrNEN3SDlJbTdPd08vdFRTL1gyeFpHcUo5dkI3cUo0M1liVUNqMk5qanlR?=
 =?utf-8?B?ckFqMXluZGhaZXJMQk9rQ201dGd2aTBXRERYeUxCd01WeC9QNS9VcE5PK3Ur?=
 =?utf-8?B?RFMzMFFaamJGRE5hOGlTYzBFcEVFY3lHa0RoSnhieDdndFJOMlZhUmFKZVRa?=
 =?utf-8?B?SUxWMzd1T0d0SysrN2V0RFk5SG1FQXhlOHJnVWorR3hIOUttaTJyOTFsWVlv?=
 =?utf-8?B?ZUZxU0dSOFZWaEZQNGNFSFhBeUFFcjBWWGthZFo3M0tlSkNuVTZDbTZKZWF4?=
 =?utf-8?B?M2xhTFNRNWF3VWJycVJHRndNVFh1WUxTOE81MzVXaWkrSEdrZkpEU2FzcUor?=
 =?utf-8?B?UXlhQTFjZWo2UTludjZxMWQ1c0JCQ1lQd09EMmJJdTF4amNtc0FKdVdCZ3Y3?=
 =?utf-8?B?am5oWGg1N2ZKNTRLSEZOS0M3YzFxTTVWQjRoVTJJbnVITjJTTWl0QjI5dzZk?=
 =?utf-8?B?Mi9vTkxQQWxwSk9VMkMxYmhCcDdBbkI0OFZCNmN0WjFXVnNzMDFNMEoxNGRC?=
 =?utf-8?B?TVAxYlVYcFpZMXlwMCtHUmpsV1o2SjRPbVJYdE9ZTjFiSzN4K0UwcTU0dW12?=
 =?utf-8?B?S2JhemVIZko3elZoN0RMNmhrejMraG9sb3VTb3lIWHhzUzljNE9uZlc1bzN0?=
 =?utf-8?B?TGY5WWJlVWRLb2VFSHJiU0NCQWxTWjhNMkllYW1qKzNkdXZ4YUxnN3dVeGdy?=
 =?utf-8?B?b2l2TFdzYXByWFV2VlNhbFIvVnBzb280RGlXN3B6aDloOHQ1NS9xZTJtY3Zj?=
 =?utf-8?B?S0NtL0RGbnVVN1o2dFNjMFA3aTNzcjFNcU5UcS9qbk9CK0V3VkZ4T1NhaGc5?=
 =?utf-8?B?MkNnWThWN0tTaHhsd1RydTZRdk5DTDR4OTlmYUNXMVBra0sxd00vcFBSbGJC?=
 =?utf-8?B?NkJNeUFLbVJlMmlmR01JQ2tGNFBVdzVHM3VoQnpVTWY1UWg5a0Npb29BOVpm?=
 =?utf-8?B?aHYxcmhtU1o0SXZOTGs4dGpBaml6TzNwUkVZeE5ZY2VaYjZVRTFnMVNZMFZQ?=
 =?utf-8?B?RzdZZllEWHU2NDF4djduOFBhQVowcEI3QkJkYkliNnZ1RlB2eUNxWHZpdnhB?=
 =?utf-8?B?b3JxUks4QmhUL0UxL045TlpSb3doY1djYzgydyswR095UEtPeDhqM01seTFV?=
 =?utf-8?B?SnJPak5DcDluTVcrT3lEV1diR05rUDRJVjFIa2xFZlA5RWNXZVM3d250TWRK?=
 =?utf-8?B?Z0phdHFsaDdtalVzZ0FYQ3NXQ3JPZERVa1QrOW5uQzFPcFY1alJ4NXVXeW94?=
 =?utf-8?B?elBOdnVkb1BsbjBVZlNjQkthb1pjcHhLMUZ0bDk4WFp5VzJXRUhkcDg5b3p4?=
 =?utf-8?B?NTBzTlQzYUVyQitrWHNkR09Ia1E4MlYrSXlnTTN1bXM5WFBDbEc4Y2hrdW1V?=
 =?utf-8?B?N0sreTg3U3Jva2Z6N25ZUHIwSng4bFgvUzFkbmwzdDE5SmQvTDh2WHZNdHR5?=
 =?utf-8?B?MmtrWE9BbmRTNHFHTURaWjNqWkkxVXJKUU1TS3R2dmc4ZG1RN3BaSzVOOEl0?=
 =?utf-8?B?WXIwVFZ6aXJtUnRXKzAzNllPdjJLRnpSZkxUZjgzRjhBcFBHMFJzNXVTVHBS?=
 =?utf-8?B?c0N6U3V5L0sxc1FNRWNmN09NaDFwU1VlUVJJamRqNlZ3dnROWW8zTFRaR2JH?=
 =?utf-8?B?YytLY20rTFU3WlZTVUNhdFdnM1Z3cXg0RUU0eHM4MVRDNmxwQmFSa2VtckEv?=
 =?utf-8?B?N05uRUg2TzQxZ2J1VVdoTkVKWDlnazI3T0lEcFJreW10Nm54ajI5QnRaazR5?=
 =?utf-8?B?dGQxRFRLdHpVdGZ3MmhaWjVlM0Z4dDBjdExRRjhKMmlORFp4V2piV2xTR0JP?=
 =?utf-8?B?bXIyeHVYbUVBazJCV2Jvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkpkN2toZXFaU2hJWmF5dHY5VUNJdy85bEdSdmI4bzFlRW4zN3JHZytWQU9w?=
 =?utf-8?B?WjNFbEFlbXBvNmxOems1eE5BRlZBS1p0SmpPVENCWGp2aEh4ME5QK1oxdXIv?=
 =?utf-8?B?cml1OVdEZzd5UGhNZjF1QVd6QlZLcGNBbndzMGcwT2VjanBKRGFjL0FIOWFq?=
 =?utf-8?B?ZTlOWjRjbFNBWlMxU2p4RnJBRnFMS0wxWkdid1VMRG51SENmOHk5eTN5ZUMv?=
 =?utf-8?B?SlV3VlpuNnc0cTNRRlI4cGlyQzRRSGVXUFhNT2YxeW9jTVNHSUJkSHpDVUZ4?=
 =?utf-8?B?MmZxcG9GZ1VNY1llWmphQUVaYW05OEVza29kSzJzaEJ0NWtJSGUwWmJxMThM?=
 =?utf-8?B?SmdRcStiSGR3bG80bTlVdmI4MnNHeXdrQ2NqVHUxcG9MTTZIMnpqUjRrek40?=
 =?utf-8?B?OGJGZklmUVkvNG1ZK1pqUiszWTNqYUtBN3FGaW9EYXFSSU1FV2RnTDQrN1Ur?=
 =?utf-8?B?SU9aRW9RcWdIVHF1RVdCOUJWazRlQUczM1VzaUEvR0RBNnpGeFN1NDVyd0NH?=
 =?utf-8?B?cFBsMjlqWVVkb01HZ1A0Y1RnUURJdjVXNmE4T08yZUZJaWQ5K3VuT0lDK2gy?=
 =?utf-8?B?NWJDUldHVDhsNVVvWXMraWZ6OHBlakNibkhSeU53Q2I4ZDBmL010cUpoSWJG?=
 =?utf-8?B?TFhkYitVL3ZWNGxuK0tOQld3K2pQZ2FKUm52RWdqaHl4OVQ3RFIzVmdBcEIr?=
 =?utf-8?B?YnVYblAydWZXcTZMVWQ2K2Q2SGRMSEJIQjkwd2pkbnBTNmhOTkpNY2VmSkoy?=
 =?utf-8?B?UXpyaEZnNjJWT3A2YmZIQ2tHdnpQQnVXYXhqb2NpWEVOMGJyRTNxa3pSZ1Q1?=
 =?utf-8?B?TGF5bmlOcFkwSTNqNTRLbHVoNEVuMHlMOElZaXNRbkkyNDg4RkR6WHk4TGpE?=
 =?utf-8?B?VS9SRGF1eDQxTitQcmdxL1FzQ1JmNnA4TEFmK3M4U0RkaFllZzBQVnVBOXBJ?=
 =?utf-8?B?T0xsSVFTUXYvZi9GWUptN00xOU5WZWFCVWM1eVpVdDZsSnNvdWRrN1NFZ2dt?=
 =?utf-8?B?Wm1taGQzUk14ZEUrajk3MC9DbHFFa2MrUjdCWjQ3UDNTOG04YkpBZ1FxbW1E?=
 =?utf-8?B?K0xSeitqTTczSldXOExPMnlwb090NXZJZ1FVMkhOU3lMNSs3UUxJRmovOE95?=
 =?utf-8?B?bXhuWm9DMDhsZ1dNZVN3c21QOFZoZ2dpazNwaXhYTkRPaVZySDVtdWNTQUkx?=
 =?utf-8?B?N21WcWd5YXUyR0c5WDJhcGZubU5lTFM3ZVJBRWNUNVJ0dE03ZURDcElyYmRO?=
 =?utf-8?B?WjFsdWtHYmFEcFlBWVFJVHJBalRXWDRnT053MFVCUUllQ2VWS3NHZXowN2Yx?=
 =?utf-8?B?QnEzZHBNV0RWeTROU2dQZlZpS0p0SjduNGdtc1VtTWNpTnJBL200akNxVGNO?=
 =?utf-8?B?bnZZQ0VRam5ORnZFUzU1Z3M0NmFJRS9Wd2VzanQxSVVKck5CNXBBZThIZm1T?=
 =?utf-8?B?K1NTTFlnendGckI2YlJmQTVPSVlLQ2JZL2VtNkZNNjRiUkdMR1VUam5KQWF4?=
 =?utf-8?B?eEhXajFJNHBqeEhMVGhtaWplSUJXVE96TDdoREIyYUMzTDR6SnFLQXJOUHZV?=
 =?utf-8?B?Qktab3NnSXRFa3U2V1VnL1FkNmRzd080TWlyaVhwZ24wOW41VUt2OUhFWmRq?=
 =?utf-8?B?bDdCaUpBNUJRb2hWS21hazBHa05zM09jaFJNRjNjVzJQZjRBbjZOVEZaTjZY?=
 =?utf-8?B?UUZLdnNJS2liNVFtYnlHWGhKWlFjbGdjcWFKV0pkL0dnSlhpWDR3L0o4OVFn?=
 =?utf-8?B?YVlPVk1JRzd0WGk4a3dBbkpsdHRWSXlwK0JGenpIWlI3NjNWTU9tMXBMQnIx?=
 =?utf-8?B?cmorVFNrRW8zVzhkclZZcUJvRVdVTlNoQlJLZU9xL1dVYVUyaEdVRnZ2TTRP?=
 =?utf-8?B?aXE3WXlXL2NUMDBFdnhaZW5uUDN1TFlSZEFqb0FpRjVYME96Q2h4ajBscVBV?=
 =?utf-8?B?b2hOK0lQL1lobHI2QkxHZmhDdE9jTnd5Y2x4T1JLSE10VndUTUdLWDM4Qi8w?=
 =?utf-8?B?VEE5Z1JvN2FFY2tCWVZBQzcvWlZVV3BLUWFLRGtxUmRnS1czTG1CZlJjb2lz?=
 =?utf-8?B?SE1XSFpVSHU2Q242Y2txVlN6R0MvQWVsUU9PRUdjTDV1bUhTN2xsQThrRlNa?=
 =?utf-8?Q?PgNUjbP9g2TXTIZJ7zarOIOtP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1455483b-8ee6-4564-817b-08dd13e62f49
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:02:31.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AmjK/Y0ApLdXqeZOtave+jYskjwoPJp9E+D9jEsT9ttfrv7FRWJm0es23CAY0R+wXZ8+kDVJlfnXMdlVCQxRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842

On 12/3/2024 15:54, Borislav Petkov wrote:
> On Tue, Dec 03, 2024 at 02:11:29PM -0600, Mario Limonciello wrote:
>> For the scheduler to use and prefer AMD preferred core rankings set
>> SD_ASYM_PACKING for x86_die_flags().
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Fix c23 compatibility issue reported by LKP
>> ---
>>   arch/x86/kernel/smpboot.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index b5a8f0891135b..6a38cf3feb1a9 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -62,6 +62,8 @@
>>   #include <linux/mc146818rtc.h>
>>   #include <linux/acpi.h>
>>   
>> +#include <acpi/cppc_acpi.h>
>> +
>>   #include <asm/acpi.h>
>>   #include <asm/cacheinfo.h>
>>   #include <asm/desc.h>
>> @@ -501,6 +503,15 @@ static int x86_die_flags(void)
>>   	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
>>   		return x86_sched_itmt_flags();
>>   
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> 
> You're going to call this on *every* AMD and on Hygon?
> 
> So that whole effort with X86_FEATURE_s was for nothing?
> 
> What's up?
> 

Preferred core classifications are available on "non-heterogenous" 
designs for a few generations.  There isn't an indication they're 
supported which is why amd_detect_prefcore() was made.

That's already called during the boot either way because that is used
to identify the boost numerator.  The boolean value it finds is cached, 
and the next call will use the cached value.  So I don't expect this 
change affects boot speed.

