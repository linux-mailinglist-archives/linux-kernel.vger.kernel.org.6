Return-Path: <linux-kernel+bounces-201436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C28FBE89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646901C21A47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6B1442FE;
	Tue,  4 Jun 2024 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LeCxTF4s"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086E143754
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539134; cv=fail; b=kQ+TIh63G6ZSmioUb7TYyE5nFcZH+i6OKmzN5o1dGug1t7+Jhmf/YMfCjv6+tM56R5snmPNyGvaJUQXv5cQr6Hhm+1C30kmvfT3OAGtkp+GjwPfB4ivIcwn0ZFiiEax9QiUbv1pwmxIbWDdfWo3ARUkcrsfdwdOS+MszD0frgjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539134; c=relaxed/simple;
	bh=xAlkzTPP1vzT4Ag5z7a5BYG/ahqfIaCwXctZU4lBu4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKLu4uGmqm7z+S7QaW0xrr51TdOaetPrpohge6QBUQPLYZXa/b8n4wTWaFHTn793Gpw1einCtzR5dociE0Rotl8VEZf05Zt91ORV36qiLsgFEAeDZT2lYuxwASlLSyZlMz69Myty5qqZ3N1zMhaH+1bnQGm1ldX66MwRjh+6d4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LeCxTF4s; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUPvyxDk8yf7rf3gehr/mAWpXZlIyhgPtGH5RjyeB6htKiMMHd6YwKpsrp56EhKxRCo3mEGdM2pkwmpzMkec5XjTnUToYzVjkaGYzKuKgRSNOz458cFyhvEgoVKd2p886kpEu4H8u160jMir2zOxd3VI3yemPbiB8EkbpikZz1kDesjDYeGJlQkKP12kv4a6YK3k3hoPSxk6QaxvR3IAlX9Nm9oWNXvo+rKBwTTEMj8eDwqblmTPR+FDSop7igpQHhP5gXzN71Lsu95A+LMboxo37Y7BBufKGonFm+WqSakXaSrTYDJlxp95jHKVFiYDRmhvKwLOdcHcX7mXysykVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAlkzTPP1vzT4Ag5z7a5BYG/ahqfIaCwXctZU4lBu4U=;
 b=f69Xfu045P68jC9EbeCzuS4LqDubQZUDADOjBXtsSvmRad9yzuZibxYrdKUhNWyfwIOp5t5zEXAxXWJmq2OqvZCTry9RBiMQtcbbxLnB55ysiMY48FYskvf4yAFGRQf5sHtGaMw9lv7RK/sS22Ffsypa0l+4SEiE14NLRkFrE5CN68KYF7F1qDTofTnsqZ0eceXpahQ15Yzq80Ar8wE/PjjF4ys7p3pMj4FxzssaIXyQySV2DvqkT/nUj5qzQ12s9EA9iDk20NC7KRRdaD17Gs174mQGe4XqWLUazd5gYCfvMl5I4+nEU4dRVteKFPF7uMcQ4YwheA7nVKAws6HYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAlkzTPP1vzT4Ag5z7a5BYG/ahqfIaCwXctZU4lBu4U=;
 b=LeCxTF4sUHz6YPjW+5dOGSykju3kjUgP2K95sJYEDFNJrC0aGRyneHsDPtE2F7YJF9VKQmlaDKCfl75lo1ftPEqgECaWz4VIUX9fw+KInaW94CyXHCBWD56FTthBEFvdeKW2bMFpxb0c9CNnKTH+/gMKu2YUgu/RuRDY/CKtXFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 22:12:10 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 22:12:09 +0000
Message-ID: <36ad5079-4326-45ed-85f6-928ff76483d3@amd.com>
Date: Tue, 4 Jun 2024 17:12:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
 hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
 <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:806:24::16) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e447cc-be37-4e3b-014d-08dc84e360dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGV1RkVWMVVpY1UvR01iSW9GOUY1NTVSZ2FuSll3ZXhJc2FSeXI2c2tQSEdz?=
 =?utf-8?B?UEIyR2crdW9Ta3cyQ21JQVk0azAzb0lMUXhmTlFOMEMvaVlleEgzYzJZOG9q?=
 =?utf-8?B?eHNGUllEZ3FreHZsbFBSbm9OSmV1VkRIelFyNE1LWmlYa2wycGNFMktKMHo0?=
 =?utf-8?B?Q2NRZE1xZlJMbEhsRlRJUHhEa3MvNndPQy9YK1pDdldoQjVNZVFZdkRHcGtB?=
 =?utf-8?B?VStNY3B4TTB0RUgvdldNL1ZWeE5OdG56eW1ycENsYzJlVE43STVjbUp5bSt6?=
 =?utf-8?B?dUFHajd3MGJYdDhzKzA0TFR2Rm13a2FiWE1jKzVhd00zWnRFbSs0U3IxWTU0?=
 =?utf-8?B?ZEM4ZG5NUURPS2ZvcUMzVldDeVp0WU5SS2g3S1JqMVp0dloxdldQTkV3K1dq?=
 =?utf-8?B?aGFKaW40YWI2dGg3OHUxMm5qVEROOWNqdWdxanBXYjdkS3VnakxEQ3NUN2Yr?=
 =?utf-8?B?QVQzTEY0VndacnRmSWE1a0pQQVVKZmt5N1htSkV3MUM4cHlZRjhJeEtpQ29T?=
 =?utf-8?B?cnVBbmc3a1NwVHVHQ0FPY3g1UWFLbWJsV1EydnlORmhmZ3hHb3cwcHJXV3pQ?=
 =?utf-8?B?dFlQcHV5RWk3T0lBWUhsdHJOdHBjcHdWMW1iR0M5VFJIQ1graGdFS2hNWHdJ?=
 =?utf-8?B?MWhldEdOV1JOT1FaUzRnRWMxeSt5MHlKYnZ6SEw2NXFRdEFhTXAxdkVOVlg5?=
 =?utf-8?B?c2NPN1A3UFpRWU1ubDY1emhQQ21LazRzRDNQejYvK0U3Mk5PcWNqbUVHSS85?=
 =?utf-8?B?WnZDTmY3ZlVCU0VqNVRDYWFVTzhaZlMrd0RXc1pmR1pLVDdzc3pxRzV6TEFy?=
 =?utf-8?B?UlVEaTUzRXdmY0RHNWxOcG9ZdUNTN3NlMW5jVHdVZU5MOFhzVmxnM0wrNWVh?=
 =?utf-8?B?SGQ5SWhKUzhQUlhERmxHaExCdlFVamJ0UngxYksrOS9zMTFhTFhnZlY0bTJr?=
 =?utf-8?B?a0g3alBXVmx0SlgvczFCNlRzbDlPV1VkcTYzRlhyWUhTTW9ub21pMWlyUXg5?=
 =?utf-8?B?QkZTNGk1TlFkbmdwWUtRbmwxMWgyTjVXNnEya0ZuYmcwang4L2JKa3N0T1U3?=
 =?utf-8?B?NHY0L3dNWmcrUCtWTHUwc2FRVC9oUnI0MzgzT0hTb2FBYmhSUDA0SURZMWQ0?=
 =?utf-8?B?UU85S0xjcU5yc0xsWENJTzhsa2hqSlFyZW1oRy9FbnFjNWMwWmRvWnJCSFpa?=
 =?utf-8?B?aW5RM2NUYWhFdnJNQzUrY2dWU0dSTXcvNjIxT0QwWStBK3JjbmlCNGxWZnFV?=
 =?utf-8?B?UDhYZTBCTWJQemV5Z2pOTFZmWE5zYk9ucklmd1l6ZlRNTDA2alQyQkhqSThF?=
 =?utf-8?B?UWw1d1Zxajdoak1PN2JidU5sSm9EN3JySXc0U1VYazh1UTBQY2QwVi8xWXdD?=
 =?utf-8?B?aXdCVXlYdXBXK2QxKytkUUc5SklNeVdBOEdXeTRGa1hQMlFsVXZyMFRFMGRQ?=
 =?utf-8?B?R3lNTTVZZzEwaVU5VEFOS2ZZZnhRN3hTbE1TdG9PUEw2MzJUbTdSUzQ3Zm1Q?=
 =?utf-8?B?ZCtFclVYZi9SRE9yMEZhSFFVL0pCR3VKYnF1djhWejZIRWhIb1E2L3o2K29X?=
 =?utf-8?B?MjMwZDhFN0p6RHZOUGwxNVo0Vk9KZ0hUVHVEVnJXbW9sNGgxMVNxMFdnZWd1?=
 =?utf-8?B?eXhZckpWWmFadm9pYVZZbUorVTRWV2NLdEMxSGZMN2QwazJ0R3RJTjB3Qk5l?=
 =?utf-8?B?Ni9yOVpWVGZhTUozSjRScEhTS2JwcktMbFdndWNVSFFGZ1NxNVhONkdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTFNTlN1YWY3Z2h6dVBlRzJBTFFmcklVOGx6bHQwSFJ1NGJxZFNlb0NBV2Fs?=
 =?utf-8?B?a3hEaDVud0ZUZGFVVmxhaXFDZ3pLSmt6YjhzdUNYVDdIUUNDNUFWbk5TNGx6?=
 =?utf-8?B?ZWRtY0xwekFmSm1VaExIYVVjWjRDRTVMdVg0eGpNTklTcWp3WTR0TnpucGRF?=
 =?utf-8?B?UWNSUjZvOVFySVByZlNIM0NmcE52a2xEYk5XQzhTWU9HdWtYSExmaUxVV1Vw?=
 =?utf-8?B?a2FJeEoyNkNmWVdTbWIycysvUGZkQ2hoOUpmNnREUTBDNE9MNUlZMWk5K0M4?=
 =?utf-8?B?ci92bEJRU011Qmt4TDlVcVhMd3ZqWUdpMzdPRlhQcGxXQXcwMUxVYytOWkdO?=
 =?utf-8?B?MDhtVW13VGt2ZEJISTFKeHd1c3VVV2xYNGxMK1U1VTZqMWVCU0lIeHlKaFRm?=
 =?utf-8?B?aE9wSEFqZVJUTjhpbXM5c1U2MFdDYnBYVUtwNm8ra0FXSFhpTVVGL055VDBa?=
 =?utf-8?B?anBCR2gzN3NKU0pUSzREdmJzajF2bVdnTlppbG5kUktYMkNrUUIrbUUwcUtt?=
 =?utf-8?B?Z2lHYURYdGJreDQxOUd3YUYvcW0wTGQwak1KMnAwbzZTcnVKM0ZoMklJRG81?=
 =?utf-8?B?akNZWmw4d0RoL3BaVUVkQ1JTU25zcFplaW1GbUlOZ0dBUHRiSU5yRVNWUTRn?=
 =?utf-8?B?MERpeGFvbWUvNkl2Yk45endXUHhMTk5mcy9oME1lMmNueFZWa0F1YU5MZmly?=
 =?utf-8?B?UFJIdU9DNGRHTGtvOHRNRVhnM3hsWHFUT2hka0Y2aDdyS3BQZUFwampzK1RF?=
 =?utf-8?B?L3FleGFCL2IzeVQ0blNZeG9HN3E3MzZEU1NrWjFUVjBNY0hBTVpTMHpPb1FG?=
 =?utf-8?B?bDBncllsM0o1cjNHUUNHczZWaXZrVC9rWS9VWjQ2eTZuZ2RlMStRNXp0ZWxC?=
 =?utf-8?B?UTlQZW5RN3ZZZ2dVQVUzWUttUHpST2Z0MHNoa1VmLzNsbUtIQmRRTC9TTFJ0?=
 =?utf-8?B?TUVaNGdOa2MrR1cyUHR3YVNzNko3cXd5Z2V2TWw3dFI1WWk5Rk40NWl0MzhB?=
 =?utf-8?B?all6bU5KUWlhNzRudGRZMzJnZGd3Vy95ckNzWWpvQytPQVhLc2dNMFhJWm95?=
 =?utf-8?B?LzUvSC9hOXJ5SzZTUUhDNXBCbkJyZmJ5TVZVN2dtd2g1dDh1TE9FYWtyODFR?=
 =?utf-8?B?NDduNWpvWUQ1UGVtbHkyUUJWaXRUZDJNMDZJU0NYdDM5OExVM21LazQvaitk?=
 =?utf-8?B?Tms0VFQ3V3Nsckl2NjJWL2Naa0lwL0IxTnNpZWQ1ZmdHcVRIVG9XWVRmdm5p?=
 =?utf-8?B?c2xWM2M1Z1lrYjNFQ21oM1dDMC9vSEdGQ2pDdEtKYjQ4aDhNa21HdmVlYVJL?=
 =?utf-8?B?STZtbkdGMis3a1FsMEFnMFpHYXN4S0RzSWtJcDdvQnkrakxYMjhVcE9XUEYz?=
 =?utf-8?B?N1QreGc5L3cwZHhoZW1ySzNlYWZYQ0toSTZtWkZVUm1HekpKZDkwa0lxMDlH?=
 =?utf-8?B?QlorWEVIWHJobU1NMTdLMkFMWlJBVVVpK1VYVHAxNElDVHZRTWtvL3hKRis1?=
 =?utf-8?B?bGxIMnhXWVM1TEplR3dsWUk1M3Bxa0R0YW92WktGKzlkZVFxeHhFREpLaWJ6?=
 =?utf-8?B?NGdMZjAxZHZNdndNVXZFb0dHdUIxYmZCdlgxem9mUDRWbU5qNjZMQ3hHMWdK?=
 =?utf-8?B?eGZzTHpwVXRYbm4zanZEZWZmSTZKeXJYVzFCQW5pWnJab0EwVDVRYkgvYitS?=
 =?utf-8?B?UTkzOTFmYk1wb2k5RWpmazMzRGdaWDA5d3lWektmTldmQ08rbTRLeEprQTI2?=
 =?utf-8?B?THdXN2VvV0Eva1hUSExYY2laTWw1TEFoTWZZN1VSM01vdXNLTkY1cjlCNVcr?=
 =?utf-8?B?aWJScTU3bjZvblo0ajE1MmIrK2w1RFdWc0NRQm5jeW1mdm1JVzJxWFBhTnVq?=
 =?utf-8?B?bk0yc1pQOWlHN3lFVHdNSjJaM3o5ay9NMTJ1Q25ISURqRzJiUDBIN3dLcnhD?=
 =?utf-8?B?MGh1TFZqaE5oclpHM1N0MTZzaUsvYjUxZWZlc1JEeCtkdGZaQTExOU1wVTJk?=
 =?utf-8?B?am82WTNmeERIVGdwQ0hITDdJTUJHNWYzV0VWc015MlRZZlFmaHVXUkpOcVIv?=
 =?utf-8?B?RkRYelJSQWpqREFwQ2tBY2ZvQVl2eHRrSi9scFYwOXQ0SW95dFdkcS83RElh?=
 =?utf-8?Q?MDTQUNCHRezy0ZUd2AKbhmKfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e447cc-be37-4e3b-014d-08dc84e360dd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 22:12:09.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH9RtDoU/4851r8yOjS5AXCLARASBh2Jw6u9DrRjZB2hMtQQWm/R2aDw5V5ahAc8T8hhwsRDkNZS4NHl7aY8GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050

On 6/3/2024 12:12 PM, Borislav Petkov wrote:

> On Mon, Jun 03, 2024 at 12:08:48PM -0500, Kalra, Ashish wrote:
>> efi_arch_mem_reserve().
> Now it only remains for you to explain why...

Here is a detailed explanation of what is causing the EFI memory map corruption, with added debug logs and memblock debugging enabled:

Initially at boot, efi_memblock_x86_reserve_range() does early_memremap() of the EFI memory map passed as part of setup_data, as the following logs show:

...

[ 0.000000] efi: in efi_memblock_x86_reserve_range, phys map 0x27fff9110 [ 0.000000] memblock_reserve: [0x000000027fff9110-0x000000027fffa12f] efi_memblock_x86_reserve_range+0x168/0x2a0

...

Later, efi_arch_mem_reserve() is invoked, which calls efi_memmap_alloc() which does memblock_phys_alloc() to insert new EFI memory descriptor into efi.memap:

...

[ 0.733263] memblock_reserve: [0x000000027ffcaf80-0x000000027ffcbfff] memblock_alloc_range_nid+0xf1/0x1b0 [ 0.734787] efi: efi_arch_mem_reserve, efi phys map 0x27ffcaf80

...

Finally, at the end of boot, kexec_enter_virtual_mode() is called.

It does mapping of efi regions which were passed via setup_data.

So it unregisters the early mem-remapped EFI memmap and installs the new EFI memory map as below:

( Because of efi_arch_mem_reserve() getting invoked, the new EFI memmap phys base being remapped now is the memblock allocation done in efi_arch_mem_reserve()).

[ 4.042160] efi: efi memmap phys map 0x27ffcaf80

So, kexec_enter_virtual_mode() does the following :

if (efi_memmap_init_late(efi.memmap.phys_map, <---- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve(). efi.memmap.desc_size * efi.memmap.nr_map)) { ...

This late init, does a memremap() on this memblock-allocated memory, but then immediately frees it :

drivers/firmware/efi/memmap.c:

*/ int __init __efi_memmap_init(struct efi_memory_map_data *data) {

..

phys_map = data->phys_map; <----------------------- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().

if (data->flags & EFI_MEMMAP_LATE) map.map = memremap(phys_map, data->size, MEMREMAP_WB); ... ... if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) { __efi_memmap_free(efi.memmap.phys_map, efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags); }

map.phys_map = data->phys_map;

...

efi.memmap = map;

...

This happens as kexec_enter_virtual_mode() can only handle the early mapped EFI memmap and not the one which is memblock allocated by efi_arch_mem_reserve(). As seen above this memblock allocated (EFI_MEMMAP_MEMBLOCK tagged) memory gets freed.

This is confirmed by memblock debugging:

[ 4.044057] memblock_free_late: [0x000000027ffcaf80-0x000000027ffcbfff] __efi_memmap_free+0x66/0x80

So while this memory is memremapped, it has also been freed and then it gets into a use-after-free condition and subsequently gets corrupted.

This corruption is seen just before kexec-ing into the new kernel:

...

[ 11.045522] PEFILE: Unsigned PE binary^M [ 11.060801] kexec-bzImage64: efi memmap phys map 0x27ffcaf80 ... [ 11.061220] kexec-bzImage64: mmap entry, type = 11, va = 0xfffffffeffc00000, pa = 0xffc00000, np = 0x400, attr = 0x8000000000000001^M [ 11.061225] kexec-bzImage64: mmap entry, type = 6, va = 0xfffffffeffb04000, pa = 0x7f704000, np = 0x84, attr = 0x800000000000000f^M [ 11.061228] kexec-bzImage64: mmap entry, type = 4, va = 0xfffffffeff700000, pa = 0x7f100000, np = 0x300, attr = 0x0^M [ 11.061231] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M <---------------- CORRUPTED!!! [ 11.061234] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061236] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061239] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061241] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0,
attr = 0x0^M [ 11.061243] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061245] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061248] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061250] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061252] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061255] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061257] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061259] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061262] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061264] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061266]
kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061268] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061271] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061273] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061275] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061278] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061280] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061282] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061284] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061287] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061289] kexec-bzImage64: mmap entry, type = 0,
va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061291] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061294] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061296] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061298] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061301] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061303] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061305] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061307] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061310] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M [ 11.061312] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr =
0x0^M [ 11.061314] kexec-bzImage64: mmap entry, type = 14080, va = 0x14f29, pa = 0x36c0, np = 0x0, attr = 0x0^M [ 11.061317] kexec-bzImage64: mmap entry, type = 85808, va = 0x0, pa = 0x0, np = 0x72, attr = 0x14f40

...

This EFI memmapphys map address 0x27ffcaf80 being mem-remapped and also getting freed and then in use after free condition (while setting up the EFI memory map for the next kernel with kexec -s) in the above logs confirm the use-after-free case.

Looking at the above code flow, it makes sense to skip efi_arch_mem_reserve() to fix this issue, as it anyway needs to be skipped for kexec case.

Thanks, Ashish


