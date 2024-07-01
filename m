Return-Path: <linux-kernel+bounces-236931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE9591E8BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9752834C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B47016F848;
	Mon,  1 Jul 2024 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3l8r/pIj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145816D9BA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862781; cv=fail; b=u7c023vBWy3RkK98fzlhIhJWsCcLqOJ6bkus87pUoUiGFrsuFoNEljp8FM/xD02SZKEGwgi1/qL6hBJmM6OjriNAHWiIc2p76tnCrFsOy/rROCjKZhAlnu3fiXSUmuvFVh3mtkHbNjHtO+iUq28y4yno3IL8h0oRjiDHDae/Mls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862781; c=relaxed/simple;
	bh=WpU9uNSaDQRkis2asAX/EmWjlY3N08/t5R6ER7C+w9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2a6wMLoqb6px4IM8hXCZfrn744sC1r3J59MuilArKb2gD/cZZMbBmqJ08iIpVE/P5VKf8wOWqymTb2XZkwbYtq1V0BcKbCXB8HGhQZZ3bAzHP5m++QTSgtsJmguwDlk1Sbay9MuXJPOSuYT62/ZU7DNACKUIj6ZtSJe0UPK+Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3l8r/pIj; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMNpRP2SYcez1g8q1hLYUCMObqdVTuUMhsz85EsgoyLhJ5fsceHpEbhAZivtoijdjL99UxPzt/h0aLG8D1otO49fDtFiRLAoNy4wrv0vvFDKaU2OlG2yaQXCFDavPqFTbfhNpTKimOy6ObrTy8K13wuIsddmyYzWmAjLwnwkuOZoxQjsIpYHtd5TWuBVTEyjGoVNUMVKnXcVHN8j0VbCHnn8i3bj2uJLQFn5u0th+7BFk1dTaoGy4BB1krGLjCXbgZk5otXFepZgXS+iWfFT8NLLhwBHaBRkx9AV7UmidS/H9XOMoNJ1Sx/Acwd/hZ+lBy8mNNcWNUF/q0Ag1/vEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpU9uNSaDQRkis2asAX/EmWjlY3N08/t5R6ER7C+w9U=;
 b=WsSbnsy6IRZN25FLwF/6gckvE7HLKNp8w0IHNbDGgCE3wlTZ4zwQmNuGAeDIsDQEFC83NjcFwIibJttSuvhkBLgw++z90QIiMXVHQSkjxGNFH+pZU3fbhBpCaxZrp/DNr0zfAWmO+ufvkB/zIK9ZESLJreIZVpO5rchOAN5IO2WsTgWGHDonedfg/ogwJF/qoQ0fAk2w/mLGItETtOVQUrabetKaC4GskhnCl53JrGT3QKT5nnRwXI6DwTiAmtwGq5hIxDocqTmw/823p6cKMJcsHVE8F7pYIS/aWOF7MhFGuyw1lu51OFtJqdV/3iJBGPB03v46ZiX8bO9ZZBNpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpU9uNSaDQRkis2asAX/EmWjlY3N08/t5R6ER7C+w9U=;
 b=3l8r/pIjoGI93gJwdtJ/Ch0/ngK92l9AZUL0ZBpbmBfb3Y96yQ3wIuNtLCsEQN2PH0ZdzjZFtPu8ttJ7oK23BftskYR2dNvl8iPsy80h7xmRAUfIH5YWtDTqyxdUwL2BimnG5MMT3B8Fzbl+YIaXpQX6G8SH/N+1T7BQ91wHbl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 19:39:37 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 19:39:37 +0000
Message-ID: <306a9358-a452-4595-b1d0-8e38a53d9084@amd.com>
Date: Mon, 1 Jul 2024 14:39:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "jgross@suse.com" <jgross@suse.com>, "luto@kernel.org" <luto@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>, "Rodel, Jorg"
 <jroedel@suse.de>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
 <5cf60d52-1682-4244-b892-688b22eaf4a1@amd.com>
 <8d970528-0e57-457f-ae00-862b4d320a2a@suse.com>
 <0dfcaae1-9ee7-47c5-b530-2062021155f0@amd.com>
 <25478bbd92a0dacb6d52d7ffd214374e151a9338.camel@intel.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <25478bbd92a0dacb6d52d7ffd214374e151a9338.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:805:ca::21) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d56fe01-8797-4e99-9f20-08dc9a058a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEdtTG1vSXVBNW54dlRBZTVBcGxaSUljd0pPdE5pVS9XRW1WTGwrMmhqY2FG?=
 =?utf-8?B?aXgycC82SWE4TWJOdzNlcFlJQXR6OFNyUmhkQWhEclhRT3Z5ZGdtSzhnazh3?=
 =?utf-8?B?SkNNSm9FNDZ1d09NaTA5YWlaaHR5bGxLRXc0b2FLdzBHbEFnTGZCNm1CRWxo?=
 =?utf-8?B?SFQ0K01jUHpjT1JNMTRqZ2lUSlhtYXNnKzY2d2F2NTFxYzM5dFpyWk5qOEQ3?=
 =?utf-8?B?aE1KM2VLelBzcnFTOE03a29HUENCVmhyZXR3dS9RdElBQ3FSYjJSMG84WFlh?=
 =?utf-8?B?YkdobGxlUHFHT1FvYnUvQ0IzbGswV2Z6VTNwdkpqNTNwYzcwVFZHSXdTTkxO?=
 =?utf-8?B?UmhkWFJVcXkzV1B5TmozREkwdVIwVVFVajBvUEdNNDMxd29iSEVURXl0dEtk?=
 =?utf-8?B?SnRTNC9UZUJmSk9mRlVlNHEvK3VHb2xEQmFTTUFJVmNFQks0RmJ6bFZtbWoz?=
 =?utf-8?B?aVBRVEFjK1ovd0hmbGVYSElIcVRYN0duMDV6dFFOckVCZW5DbVMvMUI2SUxU?=
 =?utf-8?B?cVVXUVpNc0MzSEZrbjZQS2VRcHNERkcwdXRkeFhuMlBid1ZaRXJPN1pqNXRL?=
 =?utf-8?B?d1NWdnRldmJrQ2tvWmdEYis4eVVZSm51NjdwdSt3clBHSXZUd2ZidEZ3UStv?=
 =?utf-8?B?V1NwdG9KQ1JUTEluY2IydUEvMndSUENGY1ZxZU9vdE4rNWduZy9PNklxZ0ZQ?=
 =?utf-8?B?M1lhVisyTkxPL3RRS2xrUFk2NkR5OTlZamdTZDRRSGtZeHdtd25MMGZCSzJ1?=
 =?utf-8?B?YVcyMW82dlluNk8yd0JtbDhZWFJqOUVjY2VHRWp6L1RQN2hUZ1lRUzFqR3ND?=
 =?utf-8?B?dTUwK0cwM1F3VVdveU9lOXB2QjBzK3NVY2RJeWtidm03YjBsOFFHUEhZK3FM?=
 =?utf-8?B?U0pRUE1xQ2xDdlNnWFFtN3YxVlNaL2Y3bWpFcURIV2RyYlBIOEZZQytWa3Iz?=
 =?utf-8?B?S0hwYTVMY2J2ejRhem5peHp0NVd4NlNYbWkvUmdyV3ZESS9TSU44RkVrWkwr?=
 =?utf-8?B?Zkx4M2xDZ2dvalZXbnk5VTVkdVVGUkVJTGFPOVlqalo2K29QMTZQWnYvSzF4?=
 =?utf-8?B?VkZkM0dJUnZBMG0xUkNwVnBLWVJVTGhuTzVBS1VNaHJOck1oOFUvM2Z2RTZa?=
 =?utf-8?B?WnZwbG5iVDFhM01YTTdTY0ljSHExRitra1V0c0Q2cmM5dVIydFFDendsdXJ0?=
 =?utf-8?B?bGpqWkRkck5Ha2FnQi93Q2FqWmpQZjE2V1c4QmxjUDNBVER1SjM5Mi9VeDlK?=
 =?utf-8?B?M0ZKV295NTFJT1hWeENZb2lTZG5hdEZ3cEMrTVZtZ2VQSXAzc1dLU2xxTDFF?=
 =?utf-8?B?dEhHeVl3UjducGRXNmdFMVI3RWMzN2E3RURIQnV0YTNlbXZPQVNONGZSczhk?=
 =?utf-8?B?YlRId1IyZkhhMFZtZmN6TEhsTEczYzZSL0QxM1JvWDB5bTlhVC85M09MUDZx?=
 =?utf-8?B?eFcreCtkMFRqRTF0K0l5ajVSaEpKazlTUCtIYnNXbmt4OXd4SGIvVm91RmJu?=
 =?utf-8?B?bXF3UWZFZ0wvTDN2Skp1NytYMjlaNnhYU2FvUDUyOEx6UnJVTGNqNzVMc1Az?=
 =?utf-8?B?UDhxTFpGblF6NStNN3hHUDQvM1FvQ0I0dzQzWWViOVlVOGhKOTNUWEpQektV?=
 =?utf-8?B?a2Ewdi9RMDFNS3hQRHNSRWxJTnZVOUR3a1djQ3V6VjA2S2FWbjArVFM2TnRS?=
 =?utf-8?B?M3dmbS9uNGVlTjZIK0JYUXRoRURHRVVLRWFrSnlKRFZtQTIwSkpWSnltSWJ4?=
 =?utf-8?B?OWJVY1NOVGMyZnZteUdjS21UT0F5aHdneXE4dHgyRVR0Wi9YTEc1TFMvTGxL?=
 =?utf-8?B?VEZJaWFmVUxEc1dBTE1nUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0JlSTdjeUZOdG9BTGpOUk9zR3FTR0F5WHZuZS9rdEFQd0VsTDdNYVkxYXZO?=
 =?utf-8?B?MFMrbHk5M2VkM0Ryc3lUMjJDQndOQlhOcDRRWitjU3RHYmtjZmdKMENkL0Ez?=
 =?utf-8?B?SjBmZU04d1d6Ni8wQWxXb2lFdDhZY3FFLzh4UE85SUwyM2pnenR2QVIvbjBs?=
 =?utf-8?B?VWhMUGc4Nlo3dGo5R1dYdm92VzB1SlJsUkRaQk1BTm91U1B6SGNlV3hMSzRP?=
 =?utf-8?B?aGNWMGp0VTdNa052QmhmMUxJVFl0djhMbjJsdFl6ZXpCZ21sRTFHWkU3L1Yw?=
 =?utf-8?B?YS9wejBnWUo1MVJoZmZXNVp5ZGVLRHFJak9TVG1SZGhpcEdDbStsT3NVRVFV?=
 =?utf-8?B?Vzc2YWdpV2ltSG9QRVhVSklWWjZJWTJGUTJXK3c3UUxzZHVLNnA5Q0tQTEVl?=
 =?utf-8?B?VGh1dzNnOFZMVlBEeE81c29WQW1YUWpkU2xEcXd4RFZpY09aVHB1cXdQRVV0?=
 =?utf-8?B?c1BoSXJOamladjJTejBNeWVuM0JRNlNnZERNc090Y2NXMEVBT1BKcitncHpM?=
 =?utf-8?B?UnhwM3BvbWtCTkM1R01JdVBBMGJtRHBTS3BoL0JIci9BcXNNdWtEUVVCejZs?=
 =?utf-8?B?VHV5YkNUUzF5N3c2UDJzY0grVmRtL3ViNWpZbFZRMWpTS1YwbmRjSG0zYzdo?=
 =?utf-8?B?UE5MbTg3RkdPcHJMcWlPYjdROGxEb3I3SnlwQWYvMGNUN3lJL1MyMU1Xc3BJ?=
 =?utf-8?B?eEYydU82OG1GT0h4bXBjODRGK3FISDdRN3Y4N1RiSy9yR0FVZStmTkpNbUNY?=
 =?utf-8?B?OG5vbUJTc0RUMS9DcHNQbFM5Vks3akNHQkZMdThOajlka3hSWVhQZzJwVURL?=
 =?utf-8?B?K2tWaTYxNEZTOUt3WnBJaU02dUx2R2tTbDhOWkJwUUZnQWdnWTVLWlNteGhy?=
 =?utf-8?B?elZ6MHF4ZzFHZWo0NTB6UnI1dTNWMmtVQU5odW5PZk5KVzJ1amlRc1M2VFFC?=
 =?utf-8?B?UlRxUnZWY2ZHU20xV3Yybklub2laTy9UTDFUdVM1cXprcXpTL0Nzc3drb040?=
 =?utf-8?B?WUZtd1Zpc1NWSFpZcVovcGFSTFFOS1oxNXM1eTk5Y2hWNGlKTkI2bXBxdnZV?=
 =?utf-8?B?OGlNVHR5SnJIOXFmUG5IVDRLVmlYTlZMdnlSUHVqY0hGTDVMTURLc3VhdmVq?=
 =?utf-8?B?NHJkL3dFNCtvYUdFS0RUNEFqVlNobDY2bjJ0U3FXYjhkZHpsWEFSZkEvRzJE?=
 =?utf-8?B?L3VmcDduaGxFRU13cFhVOS9yOU4wQVNkQm51RXRMckQ4YytYRTdScmExSFpx?=
 =?utf-8?B?d2pkWnlyZ2pRM29IWFF5TzBiTlh5WGlWeHdlK1VQeUhNRkdCREVseTFJSXAv?=
 =?utf-8?B?a1VEZ3NhaXhZVGhseFpBT01CY21pWGp0YzQxSzdrMWloUFQ0eXRyS3VpUmpG?=
 =?utf-8?B?K3BzNnp5MTNDK2lobTBEMW45SnFZKzBuUUVJazdXYkN3a3dLZW54OFZCOGdV?=
 =?utf-8?B?UFBRdFFxazZmQmljb21vQlhjMWxpc0lxRHBWUEswUDNuSlFMZVZHZ0pTTlA2?=
 =?utf-8?B?OHBYdkR0UTZMNk9sT1FNemI0cWpYZzlJK21GcUFJSEtLMVlWdVg4OWJmaFY1?=
 =?utf-8?B?dGtwRllML0JUZGp4b3hSWkFEeHh5bkZNbGdtcHVEQlNrNS9qTCtIWDUzOGFu?=
 =?utf-8?B?ZExlNWIwRkJkUERwbU94bmF1Y0V1d1RvSzdLRkZPcHRPLzVuMENNOEkrNWFW?=
 =?utf-8?B?OVV6MkZyVVNkUXQzV1Z4aitHcDAzY3lab2hZTk96N05hcFE4OHhWL085NTY4?=
 =?utf-8?B?OWhPS2VKWldLOVRZSWU3eFZKeTNTYnBqWGhaMHRET3o2Y1pRMEwweGJuSzJS?=
 =?utf-8?B?MFlnam5IeGZuUXp4Vk9INmQvQW16QlRzdXpvRG5pVko3L2MrRVc0aCtqVXY0?=
 =?utf-8?B?MHZhNFhXcVNQSlpZSkQ4SGxOaHUrT2NNVjFVMmkrUjRsS1czQ3BSTTJLN29a?=
 =?utf-8?B?bjFqZEk4ZUdQNGRSSEswWjJzaWxrYm1pcWtVbC9tSEE1bnMyQ2RyUmVuVk5Y?=
 =?utf-8?B?YW9iVE44SzN4U01LbkQ1aXpzc2djdEFnbnBEWDEvY21kU0lPcGhRV2tOUmVx?=
 =?utf-8?B?SERmUzVidWYwN0Y3S1ZkK0JXUkxBcGFIRCtlSlQvbHFYL092ZWk5WmIzcWt0?=
 =?utf-8?Q?iLN3EKMefaIY2F7KShXcbCPqb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d56fe01-8797-4e99-9f20-08dc9a058a8f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 19:39:37.0768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQS3HKe7lWHRfHszGzmWrtU6/uTxhbTT+K4OSPkbtfwAJksIhj/38L8IbaWMYONCeLiQywcnD2pOoBJGPCNBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065


On 7/1/2024 2:13 PM, Edgecombe, Rick P wrote:
> On Mon, 2024-07-01 at 13:59 -0500, Kalra, Ashish wrote:
>> Then what is the caller supposed to do in this case ?
>>
>> As the return from lookup_address() is non-NULL in this case, accessing it
>> causes a fatal #PF.
>>
>> Is the caller supposed to add the check for a valid PTE using pte_none(*pte) ?
> I did a quick look at the callers, and some do their own check for pte_none().
> But some don't. Some also assume the return can't be NULL.
>
> Can you elaborate on your goal for this change? Just a cleanup?

Hit this issue while implementing and testing SNP guest kexec.

So trying to understand if need a generic fix for this issue or do i need to add my own check for pte_none() ?

Thanks, Ashish


