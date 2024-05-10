Return-Path: <linux-kernel+bounces-176107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B948C29FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF80B24FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B764436C;
	Fri, 10 May 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZT1hI6p"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364A18044
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366207; cv=fail; b=K03MbraHURkKpwqYqW30a1xklKrUV0X/hXkUzikNIwLIwGI8Nit2SPWOEj6O1k/IS5o1oQMB4aA7Hkrhpnho3MShVYaBBVG8A+ZJ9YBtoUPs8cttCZfDUU2NqQ9rHS3pwf35Tgzg/h1rSoXpXNst1AMgEbQzQA02Bh+Uu/OYwZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366207; c=relaxed/simple;
	bh=39jQrtdFRTJ8GxcRWGno0d64GrWOKqwSO/yyJK5mPU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OmLYHMK210ErZ76Hk3Fd3+n1rRoTc5TDTKyETU6U37HmQEcSdKPSqj9M+D6WyRqbrmptUbVoNgFmjINBHrq+VAfJjlR/W5xbkKb2FgbcVRdoHhAVkiXWSYjg+l3C7huU8PhmhK4qo2INfFDtSfpPlqR3tSonxapHpTUmmiT5p/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZT1hI6p; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6pyJULv9XhOIIuPFopI0v4tU4gueLpHrE22oaTk6L9TJHS1ctqsfwG/Sqj5nTHs401O67rxzxOfoX85cwlBmvWi/1ECLW3+iYHxpkAIaa6sfZgTEPDPoqpoHgVYt73T8zt1EiLyEwZN3EgbC7QD/ERzG7Z3SAphTFIMqDVr6VWFEN5DESTAPZH3Aw0KUAQq+8Z+Xa2tOzdfQ2h2fHhsH7wFR5Jjq0gxfMlfyc8PUy81k7x/pYbUmXLCYJFHJ0GtPjVX99r0uhs/MtxF7fjTi5uEKX8/hm52z4ANxqJ3h+ZJIdSRwn5/bEdYOACdW3wAplX7BwbFZ4J6MOyGcHSYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fonZj/KQCxyy+x7E1h9+pYGVnIBcN6fuWcTQBH2fITc=;
 b=KdMFKCQgFw7t9kCTP5+E3DFzZt3RlnrbvYyNkmYfgxYvJRuimbpS5gD9i8YyJjrzUYL7P2hYFFMkKqkruoSir5D/QRL7pkE00hF/n97ONTgbnwK1yYepVsO1eX6WEsdMHNIJocbbm4QMpCosW3eREgL1frvrnCtetP+ZRjih7/MCSijqP0H2EjNck9Pop5/Dr6A1Y9Zuuk7gfRls1TlzGQomJd63wBKGS3HUNql02VfltAFvlvlpKnRG7FIg/XnpOpYSh673NsJZLitC+WuuiNYmz1DBOtVCptzdfYRHsTNyu2EmxqG1+TC+jCz9y5z9rCRqic+MRAiHDi26JJ0WCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fonZj/KQCxyy+x7E1h9+pYGVnIBcN6fuWcTQBH2fITc=;
 b=wZT1hI6pQJoEHrTjcTQj+HM/buHqI+WKEmoPTJsblZsPbWKPCS8cydp5jvsDmGK8K+6RujLlS9kh1dApUds3yRq1uYd0VZWHvGqyVlRAVfart6YAyLaBSpDXyOiI9H/JBRuYptkWlH28bcn5LBWc3QdITlc0R0TuCOs4gtOnkWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Fri, 10 May
 2024 18:36:41 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d73f:2f29:b54f:3111]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d73f:2f29:b54f:3111%3]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 18:36:41 +0000
Message-ID: <adc782c1-eac9-4525-9f44-cd546dc14beb@amd.com>
Date: Fri, 10 May 2024 13:36:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Ruirui Yang <ruirui.yang@linux.dev>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
 hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1714148366.git.ashish.kalra@amd.com>
 <6dfe98fb95d7193ba2d692a2b6900a4d5d73db26.1714148366.git.ashish.kalra@amd.com>
 <Zjydu25Z26dH81NX@darkstar.users.ipa.redhat.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Zjydu25Z26dH81NX@darkstar.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0118.namprd05.prod.outlook.com
 (2603:10b6:803:42::35) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec9a646-a989-4f34-5058-08dc7120220a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEFROXZlWFBrZlFDMmRJaVExRlNEcFUzMUV2cDdPaEk4TDFIQXIxVXpiczB6?=
 =?utf-8?B?UXBzSjVOQWJJY2pnbFJNdXlxQzVmMzFtdGprQlN2cXNoa01XUzAwNFN5ZEtl?=
 =?utf-8?B?YjFpc1NiRG1UYzNhN3lkNUZObEUvOUMxMUJxa3FMeS9kNjNNRCtZVHorUHp6?=
 =?utf-8?B?MVZ1MXV3dGswd0QxTVpMcloyVDNDK1hvY1FmVU9EZ20zTm9ONjZaZ2cwbGFX?=
 =?utf-8?B?U0xMaG1tYTV1Ukgvc1JKVCtzenZ4NHpQZWJSZEhtZHRLWkZLMVN2d0h2UlRo?=
 =?utf-8?B?ZUFqZCtPSWx1d1dZNkRZVC93Si9zcnJqTmptTFpsZ0pyVGlWY043UWM3STRC?=
 =?utf-8?B?bVJNbEJVdnJDYlhZK1RrRElsb3RiNWdldmxKbkUwNHdrdGJlcTNGdDlpME5I?=
 =?utf-8?B?cmRjTzA4b3JZQ1RVa2haTkc3VUgyQldlK1hSRnRKNzU2K3d6cEJiVXRQL2dE?=
 =?utf-8?B?cmF6eDB2YjhZOHQ4b0p2L1RqWGNhelJJOUtaMlpuUlI1YjlnelN5OEdsR2RR?=
 =?utf-8?B?b0JFL0kzWFJrOGpqUk5GZUpIVElKRzNXdVJObGQ4QnJpdm5oN0NpenhpdEIw?=
 =?utf-8?B?YjhHS04vWlNkSVB4Rzk0Ync1TlRtSE0zRjhudFlUemw3Z1dBSHA1SUVoak80?=
 =?utf-8?B?eEVqWlgxaHlUL0ZyWjNtdU5vNmFtZnowQ3NaSlN4dlZYcHBFYmNkTHlZTVdO?=
 =?utf-8?B?RGd2K29SbVUyNGY5QU9IUXZIMnkweDA0NmtlcmFmZXU5MXlhTUpnTVZBKzRN?=
 =?utf-8?B?cDhDNVkvbDJTcUJJeUtoWVZDWXptWk85YWw0OHdaQVVlSUQreEFsTzhadE83?=
 =?utf-8?B?WUZvSWJ6UGwrUGUyR3p3K1JXU3MzU1hEMks0NHR4WkpySzBGd1lJSEhickRt?=
 =?utf-8?B?Ymhld0tTZ3FkTzUrK3lYc2xHNUJGYzlOckNjR0VZNUNKZDhaWjR3QlNzVWdo?=
 =?utf-8?B?WHc5bWQ3dFd0eU1VdHZVeXFQMmVINkZsZ2dJZDBPV0RxYmlrVXRBZFdxV21z?=
 =?utf-8?B?eXFMWDVjQ3dkY2gyTStpUXFoR084b3FxNG5RRWF3enRLUjNUelNnTHhKT3U5?=
 =?utf-8?B?bUNqdEZleFU2YWVLWHRERzhTSmJXZGl2V1ZWTDJrUFpac1lZS1JBZDd0NjhI?=
 =?utf-8?B?eENkYm5nQjQ0MFVxNFlSL3hkUUZQajJidjBYQ2VQdlRjMUhxRkVWTXJFRnFZ?=
 =?utf-8?B?Nyt6NTEzUit1QU5SeG55SmN3UldBZjJ4UWdnT0NRalZ5K3RDdy82S2lIVmFC?=
 =?utf-8?B?bjUraVl2N21tT0owVzJxbzZSODM0Zm0xQVFOTHJkR2JLRGlZYlBmeE9ON2s4?=
 =?utf-8?B?dUNNVm5ZcE53TFVPQ3VySGgxZ3h3WllDVDBnbGR1eVIrVU5wQSt1blFGWHJ1?=
 =?utf-8?B?VnVtWjk4dW9QRDlnSHZ3TTZGclIrWnRhQmY4dWhoMkZEWXNuL01lazZEWjAw?=
 =?utf-8?B?Smp4R0RuYmhlWjlKWnkzOFVIYnpock9Mckt3RmVXWTV2ZkhVajB2V1p0T0xR?=
 =?utf-8?B?azMvYVF4Q1Ayb1RsUWZidkt1N3FwTitQVitBQUcwbFlXOU1xd3BaYVVGdTRS?=
 =?utf-8?B?V1QxaDIwVzQ0YkYvcHFRVDdiMFVGTTBiWnptazRqZ1FjZ083b0V4RTZPblRX?=
 =?utf-8?B?NGFuTGEvNkJONS9YTUlxcUdRUlg1UjJyaHdPd25PNlViZS9scTlPcnFpZ203?=
 =?utf-8?B?RlEzZlFVd0s5OVphdmNabG9DaUorRnlxcWx3R3I4TnBwK3FDdjBZeXFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpQaFF1MnhNSmgyVVZVRkx1bFgzclRtelcxcWo1VWMrL3JCN2s0TTU4dnhv?=
 =?utf-8?B?c1ZhOThiTG1lb0JJTUlPc29xelNiWFgyRmE4MFNrTlR1TjUzWGNVR0xQVDlJ?=
 =?utf-8?B?anlTaFNmamZZNkdRVWo0TnlhT1E2dVNuV1BYU1JwSlZxN2xuYW1Tak9MV0RM?=
 =?utf-8?B?T2VVOVJtYVRJR3FYYkZaQ0J6b0gxZTFPSFVGK1BsWnRzL1dPQlJDZEVNVXRI?=
 =?utf-8?B?TTF1WGdKbmlrODVIaFlvTEU3YUtSWHBZbTBiSHR3Y1ZORUtVRVU4WWNPblRx?=
 =?utf-8?B?M2w4bktONlhJck1JWk81MG1Ybzd4Y1EwWDNyK2pDdmh6NkRTL1hyS2ExS214?=
 =?utf-8?B?SGdCTDFYUTl4eWh0MWFXRnRDZFYvcHVOc21KdUtwRHhyMWxpUWpDL1Zsa2JH?=
 =?utf-8?B?T0hRVFBoaXhlcUxuZzZOVkU0QUZOQ3BCbnFQMTFmeUFoaDhBNlNTYWZnNUlR?=
 =?utf-8?B?eXlCZWo1M1JBc0l4QW5PNzZiMDFqQnFEZnk5MmJWZE5ySldBOGM4aWlXRnJL?=
 =?utf-8?B?eEVOa215U3cyY1FMMVFsM3ZOSDRPTVNlSHRBT3JyS2tXVHE1WnBaQXdKQTNX?=
 =?utf-8?B?U2VZMSs5djJwakt3V3pBaWZFemJlMFg3RlRyRm1idWg4K0V6c2ZOKzVLVGlw?=
 =?utf-8?B?U2ZvdFlIREMvYUpLbGRwQ1d5YlVtMnZBazc5WkFQOEF0V0R4aDNUajdSdGpm?=
 =?utf-8?B?a1dxNUZyRE9XWk13SHpJdmM4UE43aTVFQm5tcVlDNTRnKzVYS0ZCWVJHeUFS?=
 =?utf-8?B?YzBhMHpuU0kwR2tkNzAwc0hlU1QvMmN6VkhnTVdnN2pMK2JYZ1Noa2ljSkhX?=
 =?utf-8?B?a0VCR3Rld3EyMURpSnF0Tk5rbWhxbmM5bWtGRU1UWnNiKzZMMm1qWURvSExK?=
 =?utf-8?B?djFPalRHOGwwYVdqbFdyS2tRTHVLVEFPeEhuem9pNGp0SGl3L2JxTlpzZWlv?=
 =?utf-8?B?TE1WVzliNzF1K0tjSlZpb1NMMWtSZU94TFBnbldTNlJxMkNxVmlkcGpMd2gx?=
 =?utf-8?B?N0k2L3pLekhtU01reElQc2Zkd2d4Y1I3KzZkRzRCdUpCRTNscWtucWgrOEQw?=
 =?utf-8?B?VHNHVXNNVitIQ08vSDJpdTc4NEVCZGZhNitwQ0hVcElkbGdhVTVmQndyZXhi?=
 =?utf-8?B?RDVqUnA3bnhvc0dzVmJyYndFL2cxRy9pMURWU1U1b1FneW5kRWUrd3A5SzhC?=
 =?utf-8?B?OGh6TEN1K0dGZ1ZCMWlicTN6Z3Q5OWNyWHAva093dHlCbU9jN1ZLa1JzWnI0?=
 =?utf-8?B?d0RMbzBsZDIxM3BKaVNLaC9CMExqQmJsNm5wTmdPOHhpWHBYekZtMmIxYUty?=
 =?utf-8?B?dmdJV3d5Yzk1VlhldmFNNm5uYzBnbUxscTgrZjFXZzlneEkvQ3AwUldtTmxs?=
 =?utf-8?B?am9NNzVTRjFLZkMrVUhpanFOUE9sblBNdlhVWFZzZGQ4d0szckZKbFQ4RkF5?=
 =?utf-8?B?UHZGZEkrQll0L3BkT3VIRy9TSGFlQXlXV0F4cTRiRks2c2NOMVA4Tkp1ajB6?=
 =?utf-8?B?eFdiYThxbnFvdlFjUE5GY0hZeUhMU2J1VjFwaERRTElXSlhjOXdPTnRwTG5n?=
 =?utf-8?B?WS9wb1hjTW12QUcvK09Gb1NKVHkyejBjZ0l1MG1lRGQ2Ly9OOXNDdE1WU3oy?=
 =?utf-8?B?VjcrVnF5cDZGR285cVVzYk1nNmgyYVRqci9iYUE0MTMwcXlyOG92eVhjVVZ0?=
 =?utf-8?B?YWl6SGF1clplSEJBTmIyZ05WT3BDaS93bGlpRE1wOUpuTHVmS2dRNkIxRWVw?=
 =?utf-8?B?U1BDVldXZXpyVHhYQURUR3hSQjJoN3p2Y0pVTE1ZS2JkaVVveitLd29GaXVQ?=
 =?utf-8?B?cXhLSnNzN1ZrNGRlck1uVzZnOHZTNHU0QUxlRGVxSDhtZEltbmJRVzA0cUJl?=
 =?utf-8?B?UGtDQnBrVHdHRzFtY0V3aHlKQllReUlRZWszKzJzUXZqYjVxMDV0dno5RWJN?=
 =?utf-8?B?ekM1R1c0V0Njd3FhQm1seUVENjkrL3l4bUhKV1h0VXBXSmdvbTEwNUZEUDF0?=
 =?utf-8?B?VWpBeGhKUHJEdngrNzZ0dE5GQnJYQmhqRS80d05nWE1MR0dFZDJXQ3UySm1O?=
 =?utf-8?B?SzJvLzV2ektkdC8xYktvSkJYRWJXbDNDcS84RFB0citxeEloWWQwdHpHakZn?=
 =?utf-8?Q?3uDa0GPK2w5Lp5uKqgwX6S3bc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec9a646-a989-4f34-5058-08dc7120220a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:36:41.2112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Scg0zI+n/EOlCoFdh60LU7kOxJPg4M0cYRvF4Op8WVwb1u0q9DWRDKz6smNPe2+XEVuCjKejhLAqOQAEGdAq+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

On 5/9/2024 4:56 AM, Ruirui Yang wrote:

> On Fri, Apr 26, 2024 at 04:33:48PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> With SNP guest kexec observe the following efi memmap corruption :
>>
>> [    0.000000] efi: EFI v2.7 by EDK II
>> [    0.000000] efi: SMBIOS=0x7e33f000 SMBIOS 3.0=0x7e33d000 ACPI=0x7e57e000 ACPI 2.0=0x7e57e014 MEMATTR=0x7cc3c018 Unaccepted=0x7c09e018
>> [    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:
>> [    0.000000] efi: mem03: [type=269370880|attr=0x0e42100e42180e41] range=[0x0486200e41038c18-0x200e898a0eee713ac17] (invalid)
>> [    0.000000] efi: mem04: [type=12336|attr=0x0e410686300e4105] range=[0x100e420000000176-0x8c290f26248d200e175] (invalid)
>> [    0.000000] efi: mem06: [type=1124304408|attr=0x000030b400000028] range=[0x0e51300e45280e77-0xb44ed2142f460c1e76] (invalid)
>> [    0.000000] efi: mem08: [type=68|attr=0x300e540583280e41] range=[0x0000011affff3cd8-0x486200e54b38c0bcd7] (invalid)
>> [    0.000000] efi: mem10: [type=1107529240|attr=0x0e42280e41300e41] range=[0x300e41058c280e42-0x38010ae54c5c328ee41] (invalid)
>> [    0.000000] efi: mem11: [type=189335566|attr=0x048d200e42038e18] range=[0x0000318c00000048-0xe42029228ce4200047] (invalid)
>> [    0.000000] efi: mem12: [type=239142534|attr=0x0000002400000b4b] range=[0x0e41380e0a7d700e-0x80f26238f22bfe500d] (invalid)
>> [    0.000000] efi: mem14: [type=239207055|attr=0x0e41300e43380e0a] range=[0x8c280e42048d200e-0xc70b028f2f27cc0a00d] (invalid)
>> [    0.000000] efi: mem15: [type=239210510|attr=0x00080e660b47080e] range=[0x0000324c0000001c-0xa78028634ce490001b] (invalid)
>> [    0.000000] efi: mem16: [type=4294848528|attr=0x0000329400000014] range=[0x0e410286100e4100-0x80f252036a218f20ff] (invalid)
>> [    0.000000] efi: mem19: [type=2250772033|attr=0x42180e42200e4328] range=[0x41280e0ab9020683-0xe0e538c28b39e62682] (invalid)
>> [    0.000000] efi: mem20: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x00000008ffff4438-0xffff44340090333c437] (invalid)
>> [    0.000000] efi: mem22: [Reserved    |attr=0x000000c1ffff4420] range=[0xffff442400003398-0x1033a04240003f397] (invalid)
>> [    0.000000] efi: mem23: [type=1141080856|attr=0x080e41100e43180e] range=[0x280e66300e4b280e-0x440dc5ee7141f4c080d] (invalid)
>> [    0.000000] efi: mem25: [Reserved    |attr=0x0000000affff44a0] range=[0xffff44a400003428-0x1034304a400013427] (invalid)
>> [    0.000000] efi: mem28: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4488-0xffff448400b034bc487] (invalid)
>> [    0.000000] efi: mem30: [Reserved    |attr=0x0000000affff4470] range=[0xffff447400003518-0x10352047400013517] (invalid)
>> [    0.000000] efi: mem33: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4458-0xffff445400b035ac457] (invalid)
>> [    0.000000] efi: mem35: [type=269372416|attr=0x0e42100e42180e41] range=[0x0486200e44038c18-0x200e8b8a0eee823ac17] (invalid)
>> [    0.000000] efi: mem37: [type=2351435330|attr=0x0e42100e42180e42] range=[0x470783380e410686-0x2002b2a041c2141e685] (invalid)
>> [    0.000000] efi: mem38: [type=1093668417|attr=0x100e420000000270] range=[0x42100e42180e4220-0xfff366a4e421b78c21f] (invalid)
>> [    0.000000] efi: mem39: [type=76357646|attr=0x180e42200e42280e] range=[0x0e410686300e4105-0x4130f251a0710ae5104] (invalid)
>> [    0.000000] efi: mem40: [type=940444268|attr=0x0e42200e42280e41] range=[0x180e42200e42280e-0x300fc71c300b4f2480d] (invalid)
>> [    0.000000] efi: mem41: [MMIO        |attr=0x8c280e42048d200e] range=[0xffff479400003728-0x42138e0c87820292727] (invalid)
>> [    0.000000] efi: mem42: [type=1191674680|attr=0x0000004c0000000b] range=[0x300e41380e0a0246-0x470b0f26238f22b8245] (invalid)
>> [    0.000000] efi: mem43: [type=2010|attr=0x0301f00e4d078338] range=[0x45038e180e42028f-0xe4556bf118f282528e] (invalid)
>> [    0.000000] efi: mem44: [type=1109921345|attr=0x300e44000000006c] range=[0x44080e42100e4218-0xfff39254e42138ac217] (invalid)
>> ...
>>
>> This EFI memap corruption is happening with efi_arch_mem_reserve() invocation in case of kexec boot.
>>
>> ( efi_arch_mem_reserve() is invoked with the following call-stack: )
>>
>> [    0.310010]  efi_arch_mem_reserve+0xb1/0x220
>> [    0.311382]  efi_mem_reserve+0x36/0x60
>> [    0.311973]  efi_bgrt_init+0x17d/0x1a0
>> [    0.313265]  acpi_parse_bgrt+0x12/0x20
>> [    0.313858]  acpi_table_parse+0x77/0xd0
>> [    0.314463]  acpi_boot_init+0x362/0x630
>> [    0.315069]  setup_arch+0xa88/0xf80
>> [    0.315629]  start_kernel+0x68/0xa90
>> [    0.316194]  x86_64_start_reservations+0x1c/0x30
>> [    0.316921]  x86_64_start_kernel+0xbf/0x110
>> [    0.317582]  common_startup_64+0x13e/0x141
>>
>> efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
>> EFI memory map and due to early allocation it uses memblock allocation.
>>
>> Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
>> in case of a kexec-ed kernel boot.
>>
>> This function kexec_enter_virtual_mode() installs the new EFI memory map by
>> calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
>> in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
>>
>> Subsequently, when memblock is freed later in boot flow, this remapped
>> efi_memmap will have random corruption (similar to a use-after-free scenario).
>>
>> The corrupted EFI memory map is then passed to the next kexec-ed kernel
>> which causes a panic when trying to use the corrupted EFI memory map.
>>
>> Fix this EFI memory map corruption by skipping efi_arch_mem_reserve() for kexec.
>>
>> Additionally, skipping this function for kexec altogther makes sense
>> as for kexec use case need to use the the EFI memmap passed from first
>> kernel via setup_data and avoid any additional EFI memory map
>> additions/updates.
>>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index f0cc00032751..af7126d9c540 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -258,6 +258,26 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>>   	int num_entries;
>>   	void *new;
>>   
>> +	/*
>> +	 * efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
>> +	 * EFI memory map and due to early allocation it uses memblock allocation.
>> +	 * Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
>> +	 * in case of a kexec-ed kernel boot. This function kexec_enter_virtual_mode()
>> +	 * installs the new EFI memory map by calling efi_memmap_init_late() which
>> +	 * remaps the efi_memmap physically allocated here in efi_arch_mem_reserve(),
>> +	 * but this remapping is still using memblock allocation.
>> +	 * Subsequently, when memblock is freed later in boot flow, this remapped
>> +	 * efi_memmap will have random corruption (similar to a use-after-free scenario).
>> +	 * The corrupted EFI memory map is then passed to the next kexec-ed kernel
>> +	 * which causes a panic when trying to use the corrupted EFI memory map.
>> +	 * Additionally, skipping this function for kexec altogther makes sense
>> +	 * as for kexec use case need to use the the EFI memmap passed from first
>> +	 * kernel via setup_data and avoid any additional EFI memory map
>> +	 * additions/updates.
>> +	 */
>> +	if (efi_setup)
>> +		return;
>> +
> efi_mem_reserve is used to reserve boot service memory eg. bgrt, but
> it is not necessary for kexec boot, as there are no boot services in
> kexec reboot at all after the 1st kernel ExitBootServices().
>
> The UEFI memmap passed to kexec kernel includes not only the runtime
> service memory map but also the boot service memory ranges which were
> reserved by the 1st kernel with efi_mem_reserve, and those boot service
> memory ranges have already been marked "EFI_MEMORY_RUNTIME" attribute.
>
> Take example of bgrt, the saved memory is there only for people to check
> the bgrt image info via /sys/firmware/acpi/bgrt/*, and it is not used in
> early boot phase by boot services.
>
> Above is the reason why the efi_mem_reserve can be skipped for kexec
> booting.  But as I suggested before I personally think that checking
> EFI_MEMORY_RUNTIME attribute set or not looks better than checking
> efi_setup.

Thanks for reviewing the patch.

I will move back to checking the md attribute instead of checking 
efi_setup as i was doing previously and resubmit this patch.

Thanks, Ashish

>
>>   	if (efi_mem_desc_lookup(addr, &md) ||
>>   	    md.type != EFI_BOOT_SERVICES_DATA) {
>>   		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
>> -- 
>> 2.34.1
>>
>>

