Return-Path: <linux-kernel+bounces-248202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66092D9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9100228125F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C11196C6C;
	Wed, 10 Jul 2024 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HH4MFtfF"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159B1946DF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642360; cv=fail; b=WO96dxg+bHqBGsjdVSQQ4YFqtxlt63HGGQV7Om8ADF0jLr4JGYubq/KlPolSTaQc1evxbCTVlYlLbR4YUi1RyCgnGvROToife8tvvdOJjMOlR3BZ+5Zx8hHKVRrjyIxSi9WqGdcEKE7BVxgaemZVl7QDj1GXqM5tFYW9ZjWw+ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642360; c=relaxed/simple;
	bh=pQT3A3iFD4t8DDIgBU3kYcsjahbHK8fsGPA+Tr8l4Qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ewbjHwoU7gQv/E8i6vYgVN/fTunrkjrG6A4LfBkpPHhiH91bNYoTDFPU3hCkGLzIMzWzAvB0Mu9rRlyY3FzF4El5X5q+vXqH63pmfWootWmwrOdSAIG+e8V2jSqvKw5jbz5XuW7WbMkzJiPh+6OjnHUblK1BTrjrxBmyYCosWSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HH4MFtfF; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmO0BNaKT7r41OAIH0ytmEppE9nk8qI2p0s+zYLafLQsmIsvKVB7RCpa/zEvK0f1EaoVqa/Bb+wdD9tXHPRbBrq6YJoV7Nj2YX3pe+fKx0qYKe1NRUmDOQ9A0pqUV5CbJMVPm8ur2PRpPT0uLp1curRkfN5+GIJscmvTP99HGDEq6iZ9irWYH2JQ80/DvnNBnpbNsJr69k7g8h8Eg4nh4lV15SpvWWYtSiMk5oggpeLGIJgQTR0g0rflxGbV6mmQW9kyiiik4EB9yN6Vh7NVx+wonrzt0hOGk8VgISMlpAHr5oQgaWC/mi7+UJD70bjmRVP4eSXsevrP5aHx191V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQo3up3+UVI0yHmsumEvPLphNlq7ubMGqr+Qy+U3fEE=;
 b=FUTXYj5HcKMV4aWQQuV+r/1ohQqnZ+XfmXEqBMnsPRb47xo4D+j9g+oHPYVCEFu9RNistEU2oi1PW1Smwl/ODZGRu1RnGrCr1wMVM2stYH73iuWO1BvWUQrOFOEtwiUOwTSn9WhNO9n90KI+LNVXf6+e6m+wX4Dj6Mote8zWpWY4qNUmkdLGBmesetvgtcMDPE8ZSmzdkSQQPCZZ4HxoLCG6gS6W6wRBoof8sVP9jwLgUtxdYLvUl5iCch7PIp/01BhCGdZaG0IgfcYyD4IYnc/9vuIOxGBF/XAzg8pBkY45VWu+aMLGfKXFmXf2gcSNwbDb+6SGPMj0tQv0K9cDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQo3up3+UVI0yHmsumEvPLphNlq7ubMGqr+Qy+U3fEE=;
 b=HH4MFtfFdtsKP7WsKWzNeHK4fzYy/MXW3f3bpahP+YUqueWfhKigp+6W+i9n3XYwPxPsCu2UOEvdzm0vhVQnDompiUrV8R+d2/axJu5QpWo134UCn47epzsbxkejwkCCrch607W6FVaIa2c5KkbWMIq/zxBg9fA6aLyTp5YLymg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 20:12:33 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 20:12:33 +0000
Message-ID: <570b2f87-2a0a-4a8b-8781-b9a70a1d87a2@amd.com>
Date: Wed, 10 Jul 2024 15:12:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 x86@kernel.org, hpa@zytor.com, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
 rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
 kai.huang@intel.com, bhe@redhat.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, ardb@kernel.org,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 jroedel@suse.de
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1719948376.git.ashish.kalra@amd.com>
 <ee7d5134e67964bb5c602b5c5d69f5a1decf4597.1719948376.git.ashish.kalra@amd.com>
 <20240705142958.GCZogDZlbQWU5vHU34@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240705142958.GCZogDZlbQWU5vHU34@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::19) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 6842e690-6c30-4472-8987-08dca11ca245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVhWTVNFcng4OWtKNWE1OXZIbEFoSlA1STVTK0toOTVJWUJGb0FlOXVUcEx6?=
 =?utf-8?B?dGhGVGJMekdZdHdlM3hlVzFPcUtPSzFUd2x4QkpORHM4eXBIZml0WlpUa1Ar?=
 =?utf-8?B?ZUs1RFZWUjFabTIreFdCdXNINWE2U0dvUjZSN0ZZZ3VmNXFsc2RpMXVOR3VD?=
 =?utf-8?B?a2U5c1FyR0tuVHZDRmhXclVqdmt3Ymp0V05CUUZtZTN6R1NrQ0VHVUM2Nm5O?=
 =?utf-8?B?cW9MczU0dDB1dkp0VENuWnhuTllWdXJqbGU1cDg2UE5KcE5Ka2pDMjNTQnBy?=
 =?utf-8?B?QTZCUTRMaHBqVVUwSnpTcjRwQU9CWCtpbk0rd3QrRlR4cko1RTNqd2VaNmRp?=
 =?utf-8?B?MVR6TjFjblV5OXhTVS81ZkFaU1BQcGYvbWs0TTVBdDlLRW5ib2RmTmp0bmda?=
 =?utf-8?B?cjdFM1FRWDgxWEZUT3JTOVd3SWdzTlQzRkd5NXR3YTdqR2x0K3FaSVhpTXEx?=
 =?utf-8?B?ZDZzTi9mS2QxWXVUUDR4MjJzNmZ2anNnM2hPZ2RKK211MGhOSE85Qmw5cnlF?=
 =?utf-8?B?OEtka2NvejFCVGVCMHl6VnJXbThwY09hcjVwMUpkQ1hSeWxHTHE0TDBDMXcy?=
 =?utf-8?B?K001UjExR2VsRURqaHI1OENwZ0V6MmhFdk8vV3RPc2RxcGNEblJCRGdncUhs?=
 =?utf-8?B?dzk1aFc0SHBkeDl2eThvL3VQUHEwYjBjZm80SUNnWWhyK1FBKzZjaDB2MUxD?=
 =?utf-8?B?QjRIR2RkUFUycEVPZXhYQlZUNVVMQnFsZWdTVG41WEE1QzlNV09VQjVYVVZy?=
 =?utf-8?B?a0ZSN25xdU1Ya29rSjVSYUdoY01NeDFZZml5NSt4bzNjZ0w0bjNKR29NckYw?=
 =?utf-8?B?SGR6UWdSQWNKWVkybUo0QlpNTEgyeEU5RnAwQXpHdEJLSU1IVitJMU0wU0FO?=
 =?utf-8?B?dVo5dzFVSW1kNXU4NzZBdVpqbHFqVzg5b2J4dEU0aHlMZnBVSHk4VDlVMndB?=
 =?utf-8?B?dkdMTjE2eFdsbU5sbnB3aFhEbHdXOGd2eDAyNTNjeC9WQWRyR2FOdmlYcW5S?=
 =?utf-8?B?ZEh2ejM0eGtaWUdtRnFNU2w3WlBMOERvTVdlaGVxZ2ZXZU1Eck9JZm1EcDJo?=
 =?utf-8?B?QVpCOVNRV1dEWWZLY0RUa3EwZWlndXducDhrcktySUh3Q0Q2YXJWdUxpcTNI?=
 =?utf-8?B?VzN5NFpVU1hxM3BGa3AwcmdWeEF1TkRRNVJDdStpSk05Q0Z3QjJLV0wvR3Rj?=
 =?utf-8?B?aWl5c0FnaUdPekc4M0QzWFpHMXQ0eFptem90dWJPdmFFZXppOXp3UHVUbmVL?=
 =?utf-8?B?WEJsdWdTYjhoM2JjekZBRmZ1S2dDalJVczVBWDN5T3Fzcmp6Ry9MZTRoOHNQ?=
 =?utf-8?B?TDRGV1hWWEdjanNIVGlDMGVOcm5TeDNNbHJCZTdRZ2ZlMlpyOS9rVWl2WU5E?=
 =?utf-8?B?aFh2dzVTMjd3bTQ5Wk4rM2dBQmUwdXNxcHQvYVFzd01TV281WFBiZDIyMXY4?=
 =?utf-8?B?bVJrMU50VWs1UFVtUEdjamp2VDBUd2F6UXJxSHlFK0FuWXB4NWgzZTNEYjFv?=
 =?utf-8?B?aWs2SWhmYklzQldja21XTGU1NjBHaDQ2RzdvQXp1ZjRNUHhJYkdXWjZEL2Y5?=
 =?utf-8?B?U1YxSmpQUjBqdEE5Y1FseHVSWGgva3lxcGFDNnJzMmh0aFdDc01NaEgxUzVB?=
 =?utf-8?B?UWRpNkVhTGpmYmk3UDNKMGF0UUhGZGNrUjFoWE53TDBjS1Z6RmJYSUxxZEEz?=
 =?utf-8?B?a2FNV0pndXRySEo5UUhvMU9OWXFKRFpXcy9NdnZlRyt3MFNJbTREYll1YjFF?=
 =?utf-8?B?VzYwNklHR21ENmljNE15aURIdkN6djgwMWRKYzhrUHBFZVQ2MkVZdEJPSGNa?=
 =?utf-8?B?RERQZldLYklGWkI2K0VMQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkIzWU12cVltREhaTlJsVmRPN1N3Z3ZJaEJTREMrVzhzSW1GQkJBQmhCNnVw?=
 =?utf-8?B?K2VhamtmejlQTm84aUFqN0x1bXNocXcvTmdpNENDdHZiYlN1OXQ1Y2RxdTcz?=
 =?utf-8?B?RGFTR21DaGhjSlM1YnZZTWFyRkM2KzJhRzErMi8zaUZJUVZ6aXFWVkxTVFJF?=
 =?utf-8?B?OUt3M0sxbFFJSFkrd3JuN1diVDF2NmdKS2hIVmhMbkk0S2dvSG1UT1gyMHl4?=
 =?utf-8?B?a0lMY0NIblBTaTNHM212ejlsSlMvUXdYcit6RGs0RHFTOU5EK1Y4bXV3eWIy?=
 =?utf-8?B?MG9tS3RjbXI4UkUxZGpZRWJKMVdEdU41UGk0MWdXNEgzVW5Qank4YXRWSkl0?=
 =?utf-8?B?TTZKYUxhajhyWlRRWFZYaGZUV2pzQ1MrYjc4Yk5DbC9xTi9MZklBcnhNWm5Y?=
 =?utf-8?B?dVpPaEhOR3c3TVBjeWtOVTZuNVpBYlNXUjNoR010QUx1TmhKKzNUc3F6WmVa?=
 =?utf-8?B?Q2p4QXoyNEs2NTZ4bU5TbktmZGJHSStxQ0pteHJ3bG8rMHVockhYNDFDeThG?=
 =?utf-8?B?cEdzM3JBbXIrYlVFNVptampMNFVjV0dlUUF0VnQ5V1FWTEExaU9pK1NCOEdY?=
 =?utf-8?B?ZXo3eVZrQytaVk1kV242Z1JlN2VjRmMxTlZoUGhXZkFWUFFDNDh6SENueTY0?=
 =?utf-8?B?amRsWUFzNThrK0lkdWVKSGhFSjRyTE5VZzBNWGlkV0lSMlVkQ1ZpS0tCclVG?=
 =?utf-8?B?dW90ZGhVeEp2Tzc3bFRrbXA5QVNVS0VpVlI2eHdFOVc3TGdRQXlGM0lENnA2?=
 =?utf-8?B?eEJmNytMVkZncG5hT01kR0NQYkhlZXFOTUR0bXFPWndUNzJBTWxQcUlPelQ3?=
 =?utf-8?B?WGpZeDdJWGlIRFBmM1o3RU1lT0F0NUNLeUlPZHdQNW94ejl4UmFnWUc2Nnov?=
 =?utf-8?B?ZFhPWU9RWWcwN0ZDL25KOTJQZGZRU080K21nNGFPeHFuemU1TkFOU2dQYWlo?=
 =?utf-8?B?cFdzLzRsZHN5QXR3TVp3RGdxdHRFY1Bxd3cyc21nMkxKcTdidHByV2I2cjk5?=
 =?utf-8?B?Y09xQzhGdUJNeU55SzI5aHA1OU0yQnF1MEpqbVBqblBmdkNxWVV4M2czd0dG?=
 =?utf-8?B?OTN6VCtKbHRDV3dMZ1FoMGhuMXhUdThtUVlMb2xvUzF3RXZldlhNd3NnMG9k?=
 =?utf-8?B?UEZKMTNPaU9zTnp2YmsrY0U5NVJNQTJnZExyNUNIWUN1K0cvMDhVb0RHUkJ4?=
 =?utf-8?B?S2FIVFFxT213NEYyQ3ArcHpJQ0d0eWFTWUpNU3BRU0lCeHFHc0xENGFHVE03?=
 =?utf-8?B?NUVzcUtNeXE5cExYcTVUd1lZYVd4dmY3dkx5d1YzaGE2bVJ3Mk43UExpdEda?=
 =?utf-8?B?ZXdJNEt6RG8xZXRrYWxBUzg3Rkg4NDhWdVZLWGk4TW9xL2tiZ1FIbnF0SjNm?=
 =?utf-8?B?dll3bWRxU2dYa1ZrSDVpcHFLN1V0bjJTeUtNZmJHbjh0MFFaOE5ySjhVNTQy?=
 =?utf-8?B?Q0hsc3B1TkcyT3diWTd0em1LSHRFL0lHSTUzUTNFVlBXVkZBaEVYdDVScXlY?=
 =?utf-8?B?QXU3UzN6TzdGODA2YXpjZFY1QTEvS0hnTGRCOUlHN0szc1QxTDJrcndsTVMw?=
 =?utf-8?B?Z2QreFc5S2JOODNyblhqbkdzNDNZdGRNRUFtZGRmRHpXVHhVcnpiK0xNb3l2?=
 =?utf-8?B?N21lZFdrMHZnbFk2bjlBc2lEM0ZIY2pZU205R3hzRWRtZklxYUhQWWtTb0Q0?=
 =?utf-8?B?ZkQ2UEtraGphajVTQkJqWjIvZEdNNlBSbTZDcTE1NGk5T1RLM09pc1I4anVh?=
 =?utf-8?B?Ym85S0FiaGhYbUViYTArKzlISW5Vc0tMQ01jNmFPbWFvYS90Rk5KZTdKaDF3?=
 =?utf-8?B?TUM5SnRXMUMzb0Z5YjRTQzUzOEJlU2pIcnBCVzF3VC9GVXBrclJTUXp6d2Fo?=
 =?utf-8?B?UjJGZEVXejJ2eFYyYkd2alE5bnB5bzZFc29yL2phdExOVkJMeHkzMjQ1VFZq?=
 =?utf-8?B?QWsyTjJ2ajZlL01xYlRNdjZJWkgzQnVzYzZvcmZRUWxsRHB5OVo2OFNtVytK?=
 =?utf-8?B?VFFuSm9hRXVJWFBOMkNka2QvcEt5OWNnbE9CelA1YkNVVFBmVGpzZjR5WmZC?=
 =?utf-8?B?eDJHU0srZ3RyZzFoZkYzbUpsdFN3cFo1N2E1NHk2YWhmOGJsTXRSMTlKemdZ?=
 =?utf-8?Q?Y/lrergFrgBnqijvvjQgpAPPs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6842e690-6c30-4472-8987-08dca11ca245
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:12:33.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjS3f+v+UPUi2XTWDpBWEkFiuUT+qDqy3dV1X1Pq8gTgh6U7tFiXLTZo/uvNMqMoIzp53xI35VtVehLCHFN5Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

On 7/5/2024 9:29 AM, Borislav Petkov wrote:

> On Tue, Jul 02, 2024 at 07:58:11PM +0000, Ashish Kalra wrote:
>> +static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
>> +{
>> +	struct sev_es_runtime_data *data;
>> +	struct ghcb *ghcb;
>> +	int cpu;
>> +
>> +	/*
>> +	 * Ensure that all the per-cpu GHCBs are made private
>> +	 * at the end of unshared loop so that we continue to use the
>> +	 * optimized GHCB protocol and not force the switch to
>> +	 * MSR protocol till the very end.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		data = per_cpu(runtime_data, cpu);
>> +		ghcb = &data->ghcb_page;
>> +		/* Check for GHCB for being part of a PMD range */
>> +		if ((unsigned long)ghcb >= addr &&
>> +		    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE)))
>> +			return true;
>> +	}
>> +
>> +	set_pte_enc(pte, level, (void *)addr);
>> +	snp_set_memory_private(addr, pages);
>> +
>> +	return true;
> Zap make_pte_private()
>     
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index f263ceada006..65234ffb1495 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1022,39 +1022,14 @@ static void set_pte_enc(pte_t *kpte, int level, void *va)
>  	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
>  }
>  
> -static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
> -{
> -	struct sev_es_runtime_data *data;
> -	struct ghcb *ghcb;
> -	int cpu;
> -
> -	/*
> -	 * Ensure that all the per-cpu GHCBs are made private
> -	 * at the end of unshared loop so that we continue to use the
> -	 * optimized GHCB protocol and not force the switch to
> -	 * MSR protocol till the very end.
> -	 */
> -	for_each_possible_cpu(cpu) {
> -		data = per_cpu(runtime_data, cpu);
> -		ghcb = &data->ghcb_page;
> -		/* Check for GHCB for being part of a PMD range */
> -		if ((unsigned long)ghcb >= addr &&
> -		    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE)))
> -			return true;
> -	}
> -
> -	set_pte_enc(pte, level, (void *)addr);
> -	snp_set_memory_private(addr, pages);
> -
> -	return true;
> -}
> -
>  /* Walk the direct mapping and convert all shared memory back to private. */
>  static void unshare_all_memory(void)
>  {
> -	unsigned long addr, end, size;
> +	unsigned long addr, end, size, ghcb;
> +	struct sev_es_runtime_data *data;
>  	unsigned int npages, level;
>  	pte_t *pte;
> +	int cpu;
>  
>  	/* Unshare the direct mapping. */
>  	addr = PAGE_OFFSET;
> @@ -1063,17 +1038,28 @@ static void unshare_all_memory(void)
>  	while (addr < end) {
>  		pte = lookup_address(addr, &level);
>  		size = page_level_size(level);
> +		npages = size / PAGE_SIZE;
>  
>  		if (!pte || !pte_decrypted(*pte) || pte_none(*pte)) {
>  			addr += size;
>  			continue;
>  		}
>  
> -		npages = size / PAGE_SIZE;
> +		/*
> +		 * Ensure that all the per-cpu GHCBs are made private at the
> +		 * end of unsharing loop so that the switch to the slower MSR
> +		 * protocol happens last.
> +		 */
> +		for_each_possible_cpu(cpu) {
> +			data = per_cpu(runtime_data, cpu);
> +			ghcb = (unsigned long)&data->ghcb_page;
> +
> +			if (addr <= ghcb && ghcb <= addr + size)
> +				continue;

There is an issue with this implementation, as continue does not skip the inner loop and then after the inner loop is completed makes the ghcb private instead of skipping it, so instead using a jump here.

Thanks, Ashish

> +		}
>  
> -		if (!make_pte_private(pte, addr, npages, level))
> -			pr_err("Failed to unshare range %#lx-%#lx\n",
> -				addr, addr + size);
> +		set_pte_enc(pte, level, (void *)addr);
> +		snp_set_memory_private(addr, npages);
>  	}
>  
>  	/* Unshare all bss decrypted memory. */
>
>

