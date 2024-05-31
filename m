Return-Path: <linux-kernel+bounces-197304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2A8D6909
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966E5B21874
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217927D40E;
	Fri, 31 May 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="11S+DYEX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE77D096
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180576; cv=fail; b=NCA5p/oWPKW4u7dFC9dYluOjVz/d5Me9kUZi/3d+3baak5Hay9t+zaE70fQ3XFXNAam8rm4PH6LNEGjlOX1qgAEUDTlk2FpjFTJYb7dJXOOwaBqvOSeWPFqltekIbnrYi9lwvR2eiSGW+mM6KCybAVagEchw4IzpCksRhyr3ibk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180576; c=relaxed/simple;
	bh=2n4/0x1JFPsWZS9j9eUbXm4imxtPMV+Vn/m3hI1HpDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paqCwyBs9404cJN82AuYpqxiNOkBi+jKxHP8sgJk3+9EKihrzwyHAwVcDarVCHJ68CSOu6Ar/iv9InHT10kBMNmv4gSz3kiHvvsfbJpfok7W6Qs88yd2z+AvT2hSKvgTOfvATEx41EaCHxXaj6E7wjO8LvJkLKgOL66CQgw4ZHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=11S+DYEX; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq5G4mIHd1X/flbPE2V5LUrW+57mhrM//WyXYX0Gv0aBOM/Q7F15GUE88vr9e3B6WXChhHsdrdmm1Mdmhb9Cd9s6vO3SVY7dpe7+wmHqpRDB7jUchuhoFQ0TJ3mU00aNUAmX1Nf1knR3/RHZIIyWOTR8TkdccKX0m9caerK3GMapfFw89eaWuOSUX3PXtPiJGBqG7T3+hFuE1BjHVXPFscyQoM9uvVCV0nU167L1dWuhALUsoA92eGUhwaXaOBnbeVbriEmKGLMlo/peyUnIquM4BCFny+BkL8NmhTGXuX4b7zGegkgctjU0emorCZchk88w+OnXgcQwt6MDZIYW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1cV9OLZzejUVJ4CFzT0bcSGiJSTXpSUEmR2+fSxUhQ=;
 b=ja7lIh7vGG/bb3FZu3/YvEZMX6nHUBeDGfzAd/NK4+ZsU+dyDOJ9ttP9hZaRJIgjLoW8EUPDjDuUj9BTkEBtXW3jiQPCW6koQxXiytk/lZSb/S9FkcpW+t88ECtcib+VOEEybOtbe7YG2+aLCyu0K8SzQDuNhdA/x7YWoJ+Qd9MvoLhA0cKX2Em4fp052wGAskGF9M03UsA1oyXn/Fk4W26sUsCDDr6zH+6t/f5uEjTG19hqi5jJLsP83PauoQJTSusowfQKbIVoumM0/Lq6ZPKidRI7kv1CzcKL+c3rBM72DpxDrRTQWVAXrO1kNwsXSs4MDdY0AQPnDK33xxF6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1cV9OLZzejUVJ4CFzT0bcSGiJSTXpSUEmR2+fSxUhQ=;
 b=11S+DYEXYI6RT78s9d17maJPezEvS3l8QrMzVVHHfT2e9HFQ/KsW2OSrsJ0Qv3N2iLwDyr6uKrNJoGoWooL3hsxm/Fii0w6oQJFSbbqdgm4iNB6sVUdISPoJmAMdRD0jiDyZncilBqhZK0S/UImSChamwNYRCD6KTV1KKUfvMUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 18:36:08 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 18:36:08 +0000
Message-ID: <ad55da28-e5e0-a348-3cbc-d1a80d0ab2bb@amd.com>
Date: Fri, 31 May 2024 13:36:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/15] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>
 <20240531125503.GEZlnIp7YobFu7g9iS@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240531125503.GEZlnIp7YobFu7g9iS@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0155.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::10) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd4f593-ef46-42f3-1bc1-08dc81a08979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTdLRHdCNktFU0FzQ0cya0RvZGo3U0p5akVoTVlrK3ZLWitucEhaKzVvSXIy?=
 =?utf-8?B?UDBzVnhxdmcvY292TzNBdkt6elZIUlBnU3dvMlVBc1ZwRHJveUNlMHNjRlRj?=
 =?utf-8?B?cHMxazdYSExPUUpzKzJnMVBmZE91eVczdmFhNW5ZNlFkTnVFNFFtZmVPVUVy?=
 =?utf-8?B?ZjFTOFlFbSs2ZjJJYSs1Vkc3UFA0b1MyQkg5WkY4cHd5WkRqTzRQVkEwZkRv?=
 =?utf-8?B?MVhCeGh6bWNiNSs1ZHZIWjdBaStzUlJUc2tidWhCS2xZV096cXROc0lDSFJP?=
 =?utf-8?B?RFFnVnJaSllFbXUwdUcyQmNpdEFrQVcvaDMwM0NSL2laL09UbGdyU2xjNSt6?=
 =?utf-8?B?TVNJQlVXcC9UODM1M1d4ME5zV1JlTjdUeDV5cENPNGtnVEhxNENkY1lNZXZ4?=
 =?utf-8?B?QUhYWEYxVHU3VHJKTGNJc1plM3BkWDRUVnNub2JtUko2ZzE5TkJFdmNjYWdn?=
 =?utf-8?B?RzlsblBtbkFTVlc1bkV2eXBUeTZ5YlhGM2F2MG4zZ1ZHMmtJZks5ZXZVem5k?=
 =?utf-8?B?MEhpZFBWR2Y5RWFHbm5EdFp1R1BOTWJGcU1tYjNIRU1Ha3M5MUFjSlhoVzEx?=
 =?utf-8?B?Y2gwbE1zZmxma1ErU2JiWDdUOHI5bkxQT0tvTFVZclJBakFMSStTNEx2QmNX?=
 =?utf-8?B?S0VJcjhUTG1RUEE1SUp2U29jVDJmalloak82elBwWXFqdmhtd1VuV3FiYzcy?=
 =?utf-8?B?LzNhWk5CdWtSSDAzN0NQYnFkZ05wY3NQOW9WZ0NlbjZVWHZ3cHBwekJpZ09t?=
 =?utf-8?B?VkptTjRVT0lETklWK3RBNS9iRkJQSkU0ZGVCYU9nQWI4cHB3TUswc211REFh?=
 =?utf-8?B?aEYzZlIxNmlvdkFkaURqS3k1N016cTJBcURRd1RKZWpMNXdtemZuS2U3dm90?=
 =?utf-8?B?b2VHNDU1ODRyWkdhYnZRclArNVNJbHc1MW5jZWJzV2h6cUFxZS9PcnBPVzVz?=
 =?utf-8?B?eHU0QzlKaEZKdFdFaEt6SzRvblFDZFBSeFpGbGFyMFlHcEtLY3kveFZBTUt1?=
 =?utf-8?B?NWU3b0ZqTlZZekhIWG1FK1ZKL2dHZzRFWno1RjJUdEgrNk1zYlpwWGE3ZGNv?=
 =?utf-8?B?b04wSlBKRkFJalJSbDBXZkp3K0VqUldpSE5sQjZEYmROa2dKcTZIRDczcjZy?=
 =?utf-8?B?TVBKZ1Bjd2VMeDhqa1lqQWVraTFVQ1pOOHZmRFVoTGpNbkJNRXJNQ1ZBMW9T?=
 =?utf-8?B?UUE4Q21Tek1xdWRzSVlkTDlJNnB5OElkdzFFUDI1cGszN2pSVzdzcDdCNVNS?=
 =?utf-8?B?TU9tY2JVL2wxc04xeDV0RDc1VmpmRFVqS0NZeE4yeHZlZWdqamZwY3RCOVJt?=
 =?utf-8?B?enYyMFJzZitsL1RUQVZlTjNtOUd1VytQL1gwWXdhZlBCUHh1N3pmMlNxekJT?=
 =?utf-8?B?bUtieFVSeWF2YktVV2UzSTUyRmtWUGZwVjJDR2tkUUVTd3N0WXpnZGhHaGg5?=
 =?utf-8?B?czNyOWdvRVYrQXh4L1djS25Qem4xUUMzbFYvMk9maVFwM2p0cFJtWlEveHRR?=
 =?utf-8?B?TmhTVVZaUXdDVTR6QUl2Q2Y4S3gxQ2dhQVN4M1RsNURiVFVEbWp5RGt4Tlg5?=
 =?utf-8?B?UVFkbkIyOFoxc2hLaHNPaGpEeUV2eFNDMG4rODFJSEk4Y0dFN1k3ZnovbDNq?=
 =?utf-8?B?KzhyNkE4R3Bka2V2TmpSaXJRM2FkSkFJWVg3VE9nTU42NVg1Q3RseDVIQktr?=
 =?utf-8?B?QWFMbEtWeTBsaFA5NWNiWHJxZnpheVc2dEhoS0xyMnNhNWNiYXhBUEdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3c5Mmxpd3JHUjRNZG5rOVN5NGNEdDYvNmlPRys2SlVHZGRFQXV4K3hGS2NG?=
 =?utf-8?B?NExNcHFjM3FZbmNQV0ZoMndlL0VTOVZzNUg3K0pvMi8vUmNzNDRvdzBGQzZ4?=
 =?utf-8?B?Q0c1UHJMVHVWRHJHd1VaUm1yMU4rZTlqVnRXcyszU05SdlpZSzRPR28zUnUz?=
 =?utf-8?B?N0UzOWFHZ051UDdYRmhIZUwxQU1CN2xMUWZjSTZJYW1BWGQySVZhOENWbDlk?=
 =?utf-8?B?UkUyRjhpWENUK1V5NGJzVEV4M21lbDcyd0xobExMZEltcUJxeHdOaERuZGFa?=
 =?utf-8?B?SkR3NmJBU2paREw1Y2RNWFBUMms5enFOdU90enZFRWR5WUxrUFBxWWN3S3k4?=
 =?utf-8?B?M0gwSTZ4azZZb1dEMmNNL1FwK3hyU0dTZVh5MkNaSEhlN3JUZHlBMjNWSncv?=
 =?utf-8?B?Vm90QlVJVDRIQlZ1SThIa1Qzam5TTDJOcyswUmJJSGZJMmpQdXdNRVJRWWhW?=
 =?utf-8?B?ZGRHVCtBSHd2K1l2V1pqdVVFSUhId09XK0h0aVpTb1lydzF3MjFHejFqaWt3?=
 =?utf-8?B?NXlFU2JMbnUrVUpvTDlUdTk2M0toYnNvTzEvdmtqVUtTYkxEdG50c0pmZmkz?=
 =?utf-8?B?MWJ0ZVNpWHdlaWQ5UVl2cEhDSlcyWUR1RjczZWVrbGJQbUNQY3kxc3JSZmNB?=
 =?utf-8?B?Wk9sbWN6dmswNTZxd2xYb3JSRDd6ZXNhZ2JpMzlTbzRHQ3FFUmRlVzVrL2gz?=
 =?utf-8?B?MWFTT1pFSE5tZllCQUdxbEdhcmdOYW16SUZ2MjNqSGRJU2N3c3htWGZEUFNV?=
 =?utf-8?B?V1ppR25iS25qS0pTdW9EdmVheWYrTVNCMy81WXZCOTByWDRndHViS1A4QTZS?=
 =?utf-8?B?aGJjZWcwV2N2bjJMekx2NkRZS09vWVNYNDVERjZQbmtBQ0JTd05RakFjVGor?=
 =?utf-8?B?YVR1YTlaaFhnSUJKMjFMZFR6UDErVHF0M0hjY1FNa25UcTdNc3htSytnMzBG?=
 =?utf-8?B?ZU1xMkw0dkZMQVZ1YWJIK2dtSFF1RGFuL2JzeGpJYUQrOVQ2cDdyeTQxOGth?=
 =?utf-8?B?dndXc3ZuVitKY09yRFdWaDBlN2dTQlA3THpyR3ZsQi9QTCtHYlZHMm9tUGNU?=
 =?utf-8?B?eFkzYmlmZ25DL1VMaDB4REJ5TGNleEl2Nm1oOUxyVkMwSGxOQ1FJZlhpVlNo?=
 =?utf-8?B?Vy9NMFBLZGJsSmowVmxJTUM4UFB6TnhCbkZlbTdtQXpGVDhVaTRiOFVOYXZT?=
 =?utf-8?B?a0FuSFYwUU51ZWNvT1VjQWFsYlJ0S1dtcHlzQW9rdFpiWi9GZlU4bnFHOWps?=
 =?utf-8?B?NjBnSnc4RHN2M2N3TUwwb3dtbVczeGZha3dEMjlhajZua0N5UVcxdTU4S2dG?=
 =?utf-8?B?NnZDdkNMSG1rTGIveG5HQ0pkL3BiMWU5Wm5Mcmx3ekJDRmdEbG1wZGMvZmRv?=
 =?utf-8?B?eXlOeEVYVnJ6aE9pd2FwVXI2RTErOURIMklwcDB6RGJCTzJJVGUvUUpMVno5?=
 =?utf-8?B?N0tOUnd1T3NmZFFWOXM5MzFPNE5iMnV2L1FYclV6SjUveVVnT3JTN1RyMXps?=
 =?utf-8?B?eTdJS3pOaSsvM21UalVaSW1KalloTjgrRUx5RlQxb1NibkNaUEFxZzlyUWhm?=
 =?utf-8?B?V0FSKzVVNzlRTS9pWENNSytjVzRuRFpDQzZjOFZGZVRIK0J5Zm1waEVSdUhx?=
 =?utf-8?B?cC95VzU5a3MwRjVzT3hqemxjS0pxbFJFdVRBWlVya0ZyaEdReTlSVnBCZTg0?=
 =?utf-8?B?TmgyZ0J6b3VHRWNyUDhGZnBPTU83UG42OVExNFVxcG5RRG1DTVVHREhid2tE?=
 =?utf-8?B?SVdmRjFUM3g5WXRvTlVEcCtZUUgyWnZQOVBFeEpFZENYU3J1SWNtSjFURWtr?=
 =?utf-8?B?UW9VOVdmSEZRWUJTYnNTSmRwNHhQTm14N1Z3YVNPOThXUUtMamxuRnZ1VmpD?=
 =?utf-8?B?QmNpQzFUby9xVFRSenkyczZLc0MrWFR2endRTWlhb1o4WGRoQmNGVjM2cTN4?=
 =?utf-8?B?SGw0L0lkYXQvU0lVZFZGeW5iYkovY282Tmh1cFNycXhoQU8xakx1amk3cUpy?=
 =?utf-8?B?TDA4RDF4QWI2OTZwZWZIME4zaVBDbkIwZ1RMdGFsVHdFY3Q0MjllWHZXMjU5?=
 =?utf-8?B?SEhxR01zRTRRZUowRlNQVEc5L2RTems5RWZMVTdMWWZsWHk3b1dIOHRzOS9P?=
 =?utf-8?Q?xKn1k6Rszz63ICCF7ZZN7bdvS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd4f593-ef46-42f3-1bc1-08dc81a08979
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:36:08.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMNAugMFQliEvARRd/mSKrfFioghkT/mpqRmCLoKmOXU20vp0btolC+ks/WnmTLczZoZYyAaLDWOFCqsIWNdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725

On 5/31/24 07:55, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 10:58:06AM -0500, Tom Lendacky wrote:
>> +int snp_get_vmpl(void)
>> +{
>> +	return vmpl;
> 
> The vmpl doesn't change after init, right?
> 
> If so, you can make that vmpl variable __ro_after_init and drop yet

It already is __ro_after_init.

> another parrotting accessor.

The sev-guest driver needs to access it. Given it is a driver/module, I 
created the accessor rather than mark the variable EXPORT_SYMBOL_GPL(). 
Your call, I'm fine with either.

> 
>> -static u32 vmpck_id;
>> -module_param(vmpck_id, uint, 0444);
>> +static int vmpck_id = -1;
>> +module_param(vmpck_id, int, 0444);
>>   MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
> 
> Can the driver figure out the vmpck_id from the kernel directly instead
> of having to supply it with a module param?

Yes, the driver can and does figure it out. However, this module parameter 
was added in the off chance the default VMPCK gets wiped. Then you can 
reload the driver and use a different (less privileged) VMPCK.

Thanks,
Tom

> 
> This is yet another silly module param which you have to go and engineer
> into the loading and have to know what you're doing.
> 
> If you can automate that, then it is a win-win thing.
> 
> Thx.
> 

