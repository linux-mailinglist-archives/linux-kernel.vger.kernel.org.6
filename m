Return-Path: <linux-kernel+bounces-546029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D157CA4F55C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C42188C2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597D1624DE;
	Wed,  5 Mar 2025 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIwoXSrI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992D41A8F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145193; cv=fail; b=lHKAYAO2FwcbdyJ+M9KPsHh95jKbpQ0udN6bWDytlnvuXljJrND6NcZV5VAsfNZ4hwT8N4nZ9SCjqVnYL3cccW7VcCYBnHMWgdFX2uixYqZS0XprS459xoT6iFczxfhs96j3rLwRdafxgBWP4h5g9dQVVQ97ZHcQIQiLwyTDM3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145193; c=relaxed/simple;
	bh=Ko6jK4odBAvqMHOfvnaHScvhqkaWSd7sORxjsmb9xfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T7x9ULNsT/XGh6VipU2z/yVuHJ2Rz9F4+1aUlTh0C9eSUuFXnlHyhVN2agQW+Gy2rx0oYnyCq6Pud64KUqrEYw0BY7mzgVKSPmVBK9NZz9XcLfkYI6tOm2hEIKHwy7oQHPnD2ZowmhD+Vkv3MCvTjI32LJjCux/ncJZmlGN0dyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIwoXSrI; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd6gwfzWbPfHakQR+eXaM2BEi6o7UqTVlfgnxE8jkXWxKH13RCwghtPeOA98Hkj9tFLiFd+6nmkHeX9U5BrRPfWJvUpGWBjqC1GmMYROWOlr5LpqHPPJjF3E/tJ17HiT2vnP5Yd2VYF9D+WRZVawP/jv5qJV9US3ORwA9B2wzk3saG8cNxh7U6objop6KHl/pKnGu5mowYU3D1kX46ORbnoud+QR7/MD4ErDjwjUKCy4Ls91cGwQhSpcAhGb4UX+a7RjVRfwqOxCFHf2u4/Vg3SwKO6CIJ9oxht7y4h+KvireiHOdjYrVm9r0NOxsl72dTG2DT2J1UkqvJ9dwpbrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7+NxOT97he8opOlSINfJrjyRPiQv1TuiprvC1ywwtE=;
 b=qsLF8hS6Hjf0KLfIiHYkiZZlybsIHh98CiraFor7d+XRbED06W+WXve5mBGDHU+pDIhu8usuYoLRx8fHEHDsMOuTmDE9s+k3T/Bf5I/2sRJjXa3K1GJg4Z+uJFtePDidWOh4CcJ9TqvpTLg1voqJmDylR0h/241THo2DgaqMFSblLfgGHw7NWt/sBMpA08qEwuqcwtXYjyjGjcRdXgn6dqE3VJvQRnK+t2ZADm01ZqjGXjUoJDHOQuLQ5U1W8zEjGyfQLlQMrp0Mrvy33v86uD3BpIV+R68RMkp2MvGbvWRCT8ILnbaqN44us4rNj5guarCOqIIGKbk/pdwWXZF1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7+NxOT97he8opOlSINfJrjyRPiQv1TuiprvC1ywwtE=;
 b=nIwoXSrI6BrAOPfHPTNdFna80CqOsUbVktpbZxlTYMFZDvcw5JikECQgYCBYio6+FmCGGY1cbWZ0aZPOxxusGks1DRFsLzCN1xGMnhKS64CWRNG/Pnzorlo2sPxzUkQiNfbq6Axme8o4f9iToPk/MKh6AdsuIh3PD9EUmex6efouQmaRBuXeA7IWQpCPNWQfdI1moP7DQojpwGA+tYbovJ5WJtf7V/btOj2vlL9F9KxzmoV0lCt9rmcl3PdqdXQQVMCwbl1Cw7hhLUgM3SaVsqIfj2i7IGTQgM7JO2Hxc2AHm8bGLHFcpfZFSEJ/VbHBULkvJaYv84teDp1HMTAJWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Wed, 5 Mar 2025 03:26:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 03:26:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liu Shixin <liushixin2@huawei.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org,
 Shivank Garg <shivankg@amd.com>
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Date: Tue, 04 Mar 2025 22:22:47 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <920B1678-E116-4014-8E07-B5DE0EA6E4E3@nvidia.com>
In-Reply-To: <8A4FCFDC-E75A-47B7-8D0C-8874C25BBEF8@nvidia.com>
References: <20250228174953.2222831-1-ziy@nvidia.com>
 <23d65532-859a-e88f-9c24-06a6c7ff4006@google.com>
 <0D97A437-56A9-4C1D-9759-EAF1F7DA5AE7@nvidia.com>
 <8A4FCFDC-E75A-47B7-8D0C-8874C25BBEF8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf7e664-33c4-4863-e5b2-08dd5b9584e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmpPSGJDSWE2Qi90OXJLSndicjkwZlVjc1YzdGtzUmVjSUZKeVRuNmhBYjBE?=
 =?utf-8?B?T1d1TDZCNmwxcHZ1eTY1SThEdkRHaGtoVmtiUnZzNk5ibXpRQTlxSlpaSWJu?=
 =?utf-8?B?cVpSWnR2N243OXJWaFNEdjBjY2JQYUg2OXJWTzlRYURIRTgxbGVwNWErbWo4?=
 =?utf-8?B?NUh5WFBORjg4Z1NYaWp2cVRRRUlwU3BzK0luQVNjVCsrOExYNGdVK05kTWoz?=
 =?utf-8?B?eDAyUWk5TnRSYkNFNlBVbzAzUjFUamtUYm95TVE3MHlQSGowRW1WYW5GQWxE?=
 =?utf-8?B?ZE9nVzh5SkFWM2kvYTRxMUpRY09MVG1adGdqdHBsbE9IbWtHeVBXRHNKRkZI?=
 =?utf-8?B?TkcyOUhNQmpLeTl2eVZJeHByZW9zOWQyVWxlb0tVc1lrKy9rWTdWN0d5c29t?=
 =?utf-8?B?V3U3bW9BQnlaNFBpcEpEUnlCWGlJOGlSWnljeFlOS1lTRExPVXQwdkpqdnl5?=
 =?utf-8?B?SXhhYjhsZHpCcjNZTUQrVmxnejVOSUhoUlNUbGEzNkdaOUhCNG5OVUVJMUxD?=
 =?utf-8?B?ZkhMUy9sVzZUc296bHB2V0d0N0FQYmxzdW1NR3h5VU16Zm51M0pFMXkrb3Yw?=
 =?utf-8?B?emVZUFVNSzJXSUNTUWZ0WDZqbHRsOWRPbmN3WGlDT09ROEpGT1NNZ3dPbjhn?=
 =?utf-8?B?TWdSOXpUY3lEbkxUUm5hcTJZZ0VGOWZKLzVNU0FUa3NHSUJDNER3VGpLb2dx?=
 =?utf-8?B?REJ3U0FBRWZjWEpNQUc0TmxUdUpxLzNVdnpwcXFlR1dHU25uQXZkbkc3L3dP?=
 =?utf-8?B?L2VzMjRkWjdsWHZ5dUNTWFYwZW1TcndMOGdMd20zVHlLYzU3czNlT05VMjUv?=
 =?utf-8?B?NmMzcVJ1czJkazBMM2cwVWtrWjhSTFZHNnpybXpyR2VFOEhOTFhxT0dBeUR3?=
 =?utf-8?B?U081cDVESFJKdE5VSGRjSGlVN3J3QXJQdnNCM0NWTlU4cHJKcksrTDhvaXZw?=
 =?utf-8?B?RmVPcjExbTJPdnZyV3Z5STFzbzBvRk5kMU9OYjQvRGpHaWpqRWF6RWpJdGRH?=
 =?utf-8?B?NXJVMEFlbmR1T1k5bUtEQmlRNUM4bmU2MW5oNjNNM0xiVW5ySGNqeVdWcHB2?=
 =?utf-8?B?dE0wZTduOTMyWWxRQ0NubC9yNE9LcmtWNUxNK3pYY1ZZVFhEWTMyb0FYaVhv?=
 =?utf-8?B?RHNFMmQ2YjRaeFM0YmpNQUY5WDAvbDRJcVBEcXptU2hab0ZyZ2JHR0JmaW5H?=
 =?utf-8?B?ZXF5MnVXNi9nR3dBRDhqVUlQSy9NWjdsU1JIRVE2OHgvSGtsbDc0cWNzWW9V?=
 =?utf-8?B?NjVvaHhYRC8xVkp1ZEl2WW9zKzlSaU1JeG9ETEJVZnhUOURpUEFTR05qU2NK?=
 =?utf-8?B?T215SHUySDNvMndxTitncGh2ZTZLTFdMY1hUSS9sMU1hcDZiNzhQanM0M2Y5?=
 =?utf-8?B?NEpSL1BQaUZQcDN4SWFjeHZhOWJudmo0Q3VZdFJNaUxOUW5lMW9WQmNhSDNw?=
 =?utf-8?B?VTJHZEFyOGhhMFpNalhoVUJKaVRjNVpobXpybzJ0dGVFbnhlZVg1NjNZTW1L?=
 =?utf-8?B?c2ZQbFRMcjJOY2xiYXFYYU1hZ3Z6dFpYZ0tKbzZEQ1lMTXlrVkJIajFlWHFx?=
 =?utf-8?B?Q25ORXNlQ21iditVY211MzdwNnl5L3VMM3BIUWxqZFRVczlGRUhMczBCZ1hC?=
 =?utf-8?B?ZE9sZ2pGWFAzTU9QQkFYclZaNVZYWEEyVkJhS0gwL1I3OGZXUWNoV0VkeHVI?=
 =?utf-8?B?VGt0d213VXV6QU44ME1FL003bFNoYkpNOEZqOC9XeXdGK25Xa1ZDWlVLZEpo?=
 =?utf-8?B?M3hXSTV6bDF3OHhpTWZZdzhzUFMvYVZkdGpvdGxpT3M0SVZzcDFIKzE3akJm?=
 =?utf-8?B?NjhSVGNTOGZiRWdlQkdtdmJGNVlZdkwxYnZ0emlqVkxkYldlQTJaWG8zUVRa?=
 =?utf-8?Q?2EHMIcnQYoL0Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNxTHNwRGxRbDhtZzB0ako0RDg3RGZjVkx6SXpDaitBMlpDb3FxbnNGQ1V4?=
 =?utf-8?B?MG91Y2toRzhod3hZUlc1OHVJa1QwRFkrOSs2ZUs1bkcySGFqSG9lM3MzeUZa?=
 =?utf-8?B?RjZPemJ6bkg1WStMdGFxVDh5Nm55dThhRWF5M3d4TjBDYkUvTWtvblNhSGtC?=
 =?utf-8?B?Szhuc0t4YlJkb0RwVWlRdVZVMER4Y2xQNE5VdGlIODNYaU9jdnlnMFVQMVJG?=
 =?utf-8?B?MGphekRQL1M5ZUtENEsrQytjRkRRY0p0SFp3QUIxTUZ0N1RoL2pNMFI2V3lR?=
 =?utf-8?B?NW5HVDNBUVQ5UitQVHV4d1IyTjdXcHBna1JTVVNQQW9jUlcxZkpXZ0hnNlQy?=
 =?utf-8?B?VXlOb1pacVgvWDlaL3h4aElsMnNOeGdYSC9lUUU0RkkxYzJ5cFRxOHBWNXdQ?=
 =?utf-8?B?TWtZcnhMQUJPcjQyY0YyYXhmVi8wRUZIOUYwYzIzbEFFZHYyUlZ6K1lDL056?=
 =?utf-8?B?VkMyeUJrRkQvRHNhQmhDL3psQ04xaWUrNVpBWm1pU0VUcEhSN3F6QVkrNkVX?=
 =?utf-8?B?aXR3K0dnQ21EejN1dTkvTEdEUjIxZU43KzZrL2F4UWxKZXdtVzV1TFRQZTBE?=
 =?utf-8?B?ZXo5UHAvS2pIelNyTG8raGFUd3cxN0t5RGYrenBLUnVlQXEvQncrNUVTdlFx?=
 =?utf-8?B?TnRQWVJ2WkpVS24zamJGK3RweFRLUUg3TlliUVNkWm9DYTVsSFVXMHpnemQ2?=
 =?utf-8?B?ejJ6emNtQWRFQ2ZuTWhIaXVzZGIrUGZXdUduMUg5ajIxN2pXZSs2UXZyb28y?=
 =?utf-8?B?cncxRHVtY0h4Qk5taVVJQ1AxeWZkNGo5Z0Myam1qcU1pcjNneURkejdDbEpI?=
 =?utf-8?B?SFJjbjZJS3JmZFFaZ0Jyb3BhTkt2MzBGREZyRjVvMlBudmlJcW1XUFM4bjYr?=
 =?utf-8?B?NHdLcmsxWXY3L3JlNU94RG1ZazRCc2JZY0QwWk5Gbi9RR1hlOVQ3QVh0QTlM?=
 =?utf-8?B?SHY1TXQrNDZ0M09DUU14Y01JTGgwMFJ2WTFVZnVGVFJBRlVYajRlL1dlUC9P?=
 =?utf-8?B?NmloUUx6a09jTm5obzZZaFJkYTJaek9zWE1QMExGT3dPKytJajh6cCsvdGFW?=
 =?utf-8?B?NWJrYXU0MHBYOGNURTNpYmxYWnFKbnZWZ3RWbDBDcHlvSG9paGtnSU1ETGQ5?=
 =?utf-8?B?dCtUeURzWVVLd0tGblY4ZnpiNk15WkNmam52Z0tkbEZYbDQwSThkTFozZHcv?=
 =?utf-8?B?dnEyR3hBMnVtZldrN3VZa0ZVVHVLbWJmSDZkSXdUOUtVaExTNytRcTVaTS9R?=
 =?utf-8?B?eXVCaUE2eTV0d2ltQlBrN0RuTktDN1VhcGN1YkY2Z0E4WXgyUE1nbm81azBw?=
 =?utf-8?B?QXJYMHJoSjhrTzRoVzBMdEc2VUlNV1RqZmErTTRWNFVubFU2M0RVSDdjb1J4?=
 =?utf-8?B?NjI5Q2FHeGZKam15K0xQbXJRQ2h3WU5mN3BuSlhsQW1sWXNyZ1ZYZXZkWVNp?=
 =?utf-8?B?MzN2NEQyWnlJYXJBcFdiaDRFOXVRWWtNRTdXMExCd0xTN21mcThhU24yUFlW?=
 =?utf-8?B?ay9LeERod1BLcEgrQytOUWdMTFpTUFZRQkQvWmY1S0NYNlpKMUNPSWZHRDdH?=
 =?utf-8?B?bUNac0JPNlE5M3RpQ05BOERQRlJtc09LL0dxN3FlbDVkcXpnZWYweDU4eHI1?=
 =?utf-8?B?cE1iNXZwRmgyRVRkNjdHV0NhSU5sUHBwUWUydlBWRitnQ1E2TmQ5YTRkaE9h?=
 =?utf-8?B?bTVFR2xObFJvQjBkaHg3TExyRTd4Q1g4NUdNQlVYMWRlYlNiYTJpTm9xQXkx?=
 =?utf-8?B?SmlDcmRyOFdCR0VIeldZS2w2VmZwMEJnSm1hdVF2NVVpMWFVb0FOelVNeWNa?=
 =?utf-8?B?U2dJOS9PSmFRVHZsYWVaOTROMzNxc1Z3VW13d1dLMWlVRTRQWnE5T0dsK0Vo?=
 =?utf-8?B?emVyYXBPVks4c0RMcGJoT0ZYS1dRc0d6UVpPN0c3Rnk5ZjFVSHlUeU9KQzMv?=
 =?utf-8?B?UGF1eWlRTmc3ek1aQ09wNnl2c0hzM0tjNTNXYmFTSU9uU3YrQzJCSHN5Q01X?=
 =?utf-8?B?djJPUU50aXNYVTFoSE9JRlZEM05IV0d3TDJJempJUVR5ZG90ZXFVdkVab3RW?=
 =?utf-8?B?b1VnK0FrWnBBRlJBMGRIamFGVC9acFRRcmplbTFvbVl6WnlheHJIekpXVXVj?=
 =?utf-8?Q?hzdxLIlV2rASgYGgVtW4d4KKb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf7e664-33c4-4863-e5b2-08dd5b9584e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:26:29.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8snGEHTemdfzubWBMzrVuZTYyAwxju0IvEhenNlPXdsLoJ9+HmYGV8XGM7LEFPk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

On 4 Mar 2025, at 15:07, Zi Yan wrote:

> On 4 Mar 2025, at 12:18, Zi Yan wrote:
>
>> On 4 Mar 2025, at 4:47, Hugh Dickins wrote:
>>
>>> On Fri, 28 Feb 2025, Zi Yan wrote:
>>>
>>>> Pagecache uses multi-index entries for large folio, so does shmem. Onl=
y
>>>> swap cache still stores multiple entries for a single large folio.
>>>> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache corr=
ectly")
>>>> fixed swap cache but got shmem wrong by storing multiple entries for
>>>> a large shmem folio. Fix it by storing a single entry for a shmem
>>>> folio.
>>>>
>>>> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache corr=
ectly")
>>>> Reported-by: Liu Shixin <liushixin2@huawei.com>
>>>> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f86460=
80@huawei.com/
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>>>
>>> It's a great find (I think), and your commit message is okay:
>>> but unless I'm much mistaken, NAK to the patch itself.
>>
>> Got it. Thank you for the review.
>>
>>>
>>> First, I say "(I think)" there, because I don't actually know what the
>>> loop writing the same folio nr times to the multi-index entry does to
>>> the xarray: I can imagine it as being completely harmless, just nr
>>> times more work than was needed.
>
> It seems that you are right on this one. I am trying to reproduce the
> issue on mainline but could not and I did see shmem hits the entries =3D =
nr.
> So it is likely there is no bug in mainline just inefficiency.
>
> This fix might just mask the bugs introduced in my folio_split() patchset=
,
> since I reverted my xas_try_split() in shmem_large_split_entry() patch
> and still hit the issue. Let me do more debugging and get back.

I need to take this back. It turns out I did not turn on large folio on
shmem when I was testing 6.14-rc5. After turning on 64KB only large folio
on shmem, shmem swapin got stuck using the repro from Liu Shixin (running
compact_memory all the time then doing linear shmem swapin). But if I
turn on 2MB large folio on shmem, there is no issue.

I get no issue with v6.13 either. So this issue seems from 6.14-rc. I am go=
ing
to rebase my folio_split() patchset on v6.13 to test the uniform split
part (the non-uniform part would need Baolin=E2=80=99s patchset).

>
>>>
>>> But I guess it does something bad, since Matthew was horrified,
>>> and we have all found that your patch appears to improve behaviour
>>> (or at least improve behaviour in the context of your folio_split()
>>> series: none of us noticed a problem before that, but it may be
>>> that your new series is widening our exposure to existing bugs).
>>>
>>> Maybe your orginal patch, with the shmem_mapping(mapping) check there,
>>> was good, and it's only wrong when changed to !folio_test_anon(folio);
>>> but TBH I find it too confusing, with the conditionals the way they are=
.
>>> See my preferred alternative below.
>>>
>>> The vital point is that multi-index entries are not used in swap cache:
>>> whether the folio in question orginates from anon or from shmem.  And
>>> it's easier to understand once you remember that a shmem folio is never
>>> in both page cache and swap cache at the same time (well, there may be =
an
>>> instant of transition from one to other while that folio is held locked=
) -
>>> once it's in swap cache, folio->mapping is NULL and it's no longer
>>> recognizable as from a shmem mapping.
>>
>> Got it. Now it all makes sense to me. Thank you for the explanation.
>>
>>>
>>> The way I read your patch originally, I thought it meant that shmem
>>> folios go into the swap cache as multi-index, but anon folios do not;
>>> which seemed a worrying mixture to me.  But crashes on the
>>> VM_BUG_ON_PAGE(entry !=3D folio, entry) in __delete_from_swap_cache()
>>> yesterday (with your patch in) led me to see how add_to_swap_cache()
>>> inserts multiple non-multi-index entries, whether for anon or for shmem=
.
>>
>> Thanks for the pointer.
>>
>>>
>>> If this patch really is needed in old releases, then I suspect that
>>> mm/huge_memory.c needs correction there too; but let me explain in
>>> a response to your folio_split() series.
>>>
>>>> ---
>>>>  mm/migrate.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 365c6daa8d1b..2c9669135a38 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -524,7 +524,11 @@ static int __folio_migrate_mapping(struct address=
_space *mapping,
>>>>  			folio_set_swapcache(newfolio);
>>>>  			newfolio->private =3D folio_get_private(folio);
>>>>  		}
>>>> -		entries =3D nr;
>>>> +		/* shmem uses high-order entry */
>>>> +		if (!folio_test_anon(folio))
>>>> +			entries =3D 1;
>>>> +		else
>>>> +			entries =3D nr;
>>>>  	} else {
>>>>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>>>>  		entries =3D 1;
>>>> --=20
>>>> 2.47.2
>>>
>>> NAK to that patch above, here's how I think it should be:
>>
>> OK. I will resend your fix with __split_huge_page() fixes against Linus=
=E2=80=99s tree.
>> My folio_split() will conflict with the fix, but the merge fix should be
>> simple, since the related patch just deletes __split_huge_page() entirel=
y.
>
> Best Regards,
> Yan, Zi


Best Regards,
Yan, Zi

