Return-Path: <linux-kernel+bounces-265110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C56593ECBB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1147281A57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187980034;
	Mon, 29 Jul 2024 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N914p6yV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9481211
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228612; cv=fail; b=qx063pJQXVsg7YyObO5x5GzfBeSex4JxCfTmZtaxmWwEXXcRtKTXo3Z+7WGntypcTiKgnZkfykvfndRB6Mod+/WM3d8WLozOb6X/f4kSuSvOMkPYJ9Gzb82uPwKvADZezFwOrTP7XYd8s3KVuJaLYElM5/xcvzy7hh44jeNrA2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228612; c=relaxed/simple;
	bh=jNI4LXn3XWsaIxj2rAY1N+nAiYzn6d0TUl9SF1Ecg6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XyQ5C8AXqSPmukJSQmRnAjvKAf+vClUjXuRsivben1GtoLED6Ib6MfBAVIcgnyww5XhH3QH4nwYs0jh/4Rmqrf/K5FduksD/op05SD1U43CnKvF98J7+KbQmcDV+WF0aJ5koKV5zKFXQNFr9fZmuGCO08PUrKayQd2VeI9cimPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N914p6yV; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtQyeycWhkFfIyyAcFmLxIjfRdYxyTTlMCyBJCXmE3B3Jnp19/N5bC7pcm6ydijYqwnshmsOhVfMoOLm/n0HQsA6sjgZ7dax/rJLN0ADf/KgsCCqs/q5gYXAoLYj+tztIGfu43GaDL1J+CtrExXQJVwpr0SzYHwzWY48Xs2Y0DKreHk0JS0zBnqy5OgwwvPiLA7fVVzD6M1XIiIMfGmYsMPThaRxOcd6EPMmxd9VgeOoWIxE+q5wt+7S9LQ62eLOxZVE2QyonTOGJblTyVaXuu94GhiJkI1C95pUlYctfBCvK2swwlQJZmm2SEixZ9CRgU7MF6kXRNOjTvRxm7gScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEJ3q/KQNJ6cQCiSEt2RTdR4KkOS5pcNDTIUSnzQxj0=;
 b=QwS0c1qZP/fRCfxNhxgsCGelI2zQmVyrwr//C0w7xevWtbW0vOEs4g7bWES5Y2lLQHCVJb+EIz0wDzqBYRvBuyKCz+GBW2dE6j1N5HDk9h9FJYBGEE/sJIEBLhZ3sXJ+xpT5k34DhJAXr+0QtyODLUPKrOK1pxbpHV7GmwuP2O2Ysxuo27meCUIGIbt8jb+f4MEWotywHzzg/hltEjJcFG+7XBKQuMQgFnHI43dCXfCzjI2LjNPcO6aVGoQvlRCSMWWkmzP7RULK0Z9ThYES3XjA+rcSjEIhRN48eddxnCjmmzFLv/ntHpVFA8sgQkdK6cnuC+0m2LcUG3BI9ZeoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEJ3q/KQNJ6cQCiSEt2RTdR4KkOS5pcNDTIUSnzQxj0=;
 b=N914p6yVwbMLEyjlS7dfiRjp690U0pQVBSOTathfqfcu7aQX0aibIHgABGobnNClEYReBw0Ks2VHhnRgbkOyxrcHvMzupVD5FV5gNutRDu6FtPPkVy7BVKRoLzKoOV2O8lVZf962cTcw6aA9BTe1I6z/e+2TTu7kONEUBOopfKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 04:50:08 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 04:50:08 +0000
Message-ID: <5660bd90-3094-418a-8a05-58e222dacfb5@amd.com>
Date: Mon, 29 Jul 2024 10:19:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Zhaoyang Huang <huangzhaoyang@gmail.com>,
 "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Neeraj.Upadhyay@amd.com, akpm@linux-foundation.org, david@redhat.com,
 kinseyho@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mgorman@suse.de, mjguzik@gmail.com, nikunj@amd.com, vbabka@suse.cz,
 willy@infradead.org, yuzhao@google.com, steve.kang@unisoc.com
References: <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
 <20240725095933.2640875-1-zhaoyang.huang@unisoc.com>
 <CAGWkznHHEmQaVKT+QnA9p7WYz4BRo3XpHfuSY6VADNx_4ELtUw@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAGWkznHHEmQaVKT+QnA9p7WYz4BRo3XpHfuSY6VADNx_4ELtUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::18) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: a2af23ec-37b9-4435-0ced-08dcaf89eb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkczcFRNWWFTRGNweHV0YS9tOFRVREF1ck1zRzc1ZFlHNC82djZTWmYwRDg1?=
 =?utf-8?B?MHBaUGh2REgvY3BjTzFMUFcxRk1KNVVBWE53ZmphYTNZdEI5YXc3dnZpVXRp?=
 =?utf-8?B?bS9kbE1GdzZyUVZCNFdlZ2szVHFLbTRoeFc0Z3U5ZlJMTXBNS2kycGJ1a05s?=
 =?utf-8?B?UlUydGZabXNRNmgzMFJvWEdOQ0lRUWhjUUJXVi9JNy96UVRYUjcwVVFBelpM?=
 =?utf-8?B?dDdyc2VwVGtHN2VnNVNMK1NPVkdYakpUckJjVUpiZ2dEOVdrWm9tVmsxbzY1?=
 =?utf-8?B?c3dpcFBxVGJGU1cway9wT0ZXbWZJdEl6UTNLT1kxdU5EY2Q1Z1pUUi9VMlBm?=
 =?utf-8?B?WFlvSlZRWXc4TU0xMW1pMjVrTldEaUNqWmRlSG04UjRaUHl4SG9TbTM4ZzNi?=
 =?utf-8?B?WWt2VEZGWlowU08rS3d6d2hCdmFNR2p4RDFJOU5Ud2NPVkxMWVNJUHZLcHB5?=
 =?utf-8?B?OHMyMnM4dVpMSHJ3cmp5VElIWmkxUnhJdXVsNkV5TWdqVHdualVVZTJJNW04?=
 =?utf-8?B?SjlvalIzUi9jZENobHU1eGZrenFnQ3hhU0tCeHhZaHBPOGxIWStjNkJXVmdS?=
 =?utf-8?B?bkxDc2IyZ3NTREFWb2ZDRFkyVVcxWG9GWlN0WEREWnA0T2QzSWQ1MHBpUkNQ?=
 =?utf-8?B?c3EvSW9NbFQwdE9Lb0FXeE9KM1NuL0JrT21LdDB4dmY1YWwzeUkxME4zMlNz?=
 =?utf-8?B?emxKck9xbG9GT29EcG5sOWxQdWJuL2tjb1B3c0VDcUNrUElLSE0ydEpRdXRC?=
 =?utf-8?B?R0ZFTjJwWkpXMUZpZVFDcFdkbmVXZXRuQ3lFMm5nbG1MVVRvMEVUNTNXZUZi?=
 =?utf-8?B?SXZHRk5Od3NEK3h0ZUlPZnpnelZRMW9KQWFYRzNwWlRwcy82UjFrMzl0WGZ6?=
 =?utf-8?B?NzR2cldoNE1LelJvMjRJODlJZVlSMHRIOW1pak04ZXRPREE3REgwSUg4amJG?=
 =?utf-8?B?RkR0MVZ2azhKeWYva00zVVdwZDVWTGRYNmVKNE9EcmhjNTFJSmRNRGczNEFI?=
 =?utf-8?B?RVlud2piVERQNXhBYWFjdk5aSURQQUVOc0pDRmM0TlBwZzZ1K3BkQnhkbEdT?=
 =?utf-8?B?UnlkVnNDNk1MRVBCelZ3U0x4dmwvZTVmY3NGTUNZMXZYLzZGa0RULzNkRWw4?=
 =?utf-8?B?TVRkOG42SXFvcVFWd3Z5dHRwbnlnYjFDa1ZkRHlCaUt6SURIeDJhYVVuMXJp?=
 =?utf-8?B?eUkxcjRrQ3F0YXBZcXBQaEE5VWczaDg3WEUxY2JNMTRtTDY5VC84TWNzU1Jn?=
 =?utf-8?B?QXliY0NEekdXNklIdjBucStRSUVXNWJ2bUtqL3ZldzdKa2Q1QWtCN3FabDN1?=
 =?utf-8?B?YURva0UzUjdKTU5oNnRLdE1QZXppTVlBeC9uRDJ2N255T0RDRHd1TGlJQ1E0?=
 =?utf-8?B?UWNrOVdtaGRoQWU3dTNFNGRERVh4cnQ0elRtWW83elE5U1dMNHVJd3ZwZ29i?=
 =?utf-8?B?bTZhc2ZNaXlPcnNCaU1NbC9Kcy9TVFl6OUh3bnVubGxOR1E2b2tpM0ZJLzJi?=
 =?utf-8?B?UUVmbHdseVhkZ25NSUZYdGFNUGR2dzdyN3VmRWZISEZsUkZ3OFBFamJOMitM?=
 =?utf-8?B?TlhnaHRteXJxSlphUk1NZ2pmYWlzdkRhMDhWVFVMTjRBVXduZDQ2YlpDamNl?=
 =?utf-8?B?SjhUbG9HcUhZY014WWk4SG5PWUZuSnZiVGZtUzh5K292c09hL0RxZzI4Tks5?=
 =?utf-8?B?ZUhIMEw2WEs0aUt6YWZtQmVDT21PQkhPS2pOaTlOWklqK1ZZcVJkanp2ZUNw?=
 =?utf-8?B?L1ArQ3pXa05TaFpYVXloYmI4M095NzJWREFyS01PNXRDakNEZHo4VGl6NzlV?=
 =?utf-8?B?MVQ0d2pRSUxOY1kzVithZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmJ0VGRsT2pQMWJPR0pOMjF2QkN4RjB2OWpxYUdjMWEwaGVxbXpQem9VWHVw?=
 =?utf-8?B?NlNuS3RFZnpkYzF2VVJBbm9WblJQTklLVTExc0lVK21rSFI0SzVuR2VNdU1G?=
 =?utf-8?B?d2NleDZxTDZ2cEFnRndwcVRHem9maTdtWkZhVDBCUVRyaWUvT2tZajh6S0FZ?=
 =?utf-8?B?ZnJZUmNEZzRPUHZ5OTJyKzE3OUw2VG5iaStiLzJsMzViUGhydURITmpZaW5Q?=
 =?utf-8?B?SmM1Q3RJNmgvYXA0YkIrNU1KZ1ZZNmRTZWNTMUV6UkQ2Q2ZMUkc1eEVTWkhD?=
 =?utf-8?B?TXBTcUVoUmNCaHlERXUyU1pweUhtV2xnbHhSZEhZc2RIUjJKckVmNjRldTlp?=
 =?utf-8?B?cC9NVlkvaWVrQXBkanZUNlRQTnRGYWRpMUZzN0RLYUhINXBYRWs2R29ZaVJI?=
 =?utf-8?B?TU5pTkZCQ0FwZGtXSlFNZ3lxbm1HRklrVkdBcFgvSDB0MFNucDJXOUxPVkZk?=
 =?utf-8?B?N1VkeUFneVZEcXV1Tk10aHVPTGMwdHI5aXZrZ3BHZFVSZS9xS0hrby95Q3lE?=
 =?utf-8?B?Q004TlVzMG9hQ0xkRkMrM0xtcG9tQ09GRktXcndpeVZUODlMTEFrNVpYRnYx?=
 =?utf-8?B?MEIyTkJWY1ZobUNxWHY4OGVubGhZbCtxU3gwMkx5Tmd5K2w0OEdxUGdGeFBj?=
 =?utf-8?B?aDVSc2JUTzJYdHJPL1l2cnhIR3NKbmZDY0F4YjI4Vmtja2xkbnFjdW9LRXc1?=
 =?utf-8?B?MXVGeDRiV2FzdnpEdmtXSmw1QXpZaE5pYXBTKzhDeHo5Tmh3MTZ6ZHVzTXBC?=
 =?utf-8?B?NEpkeFRud1FUSWk2QjZJVU1nRk5tV3pRVWN5b29qQnlyRk42OUJlTjArZXc4?=
 =?utf-8?B?S1p1VXN4cGNudml5RUVFNlByVEllTkFYSDNENVIxeG5EWFhGVlVoQWFRMG9K?=
 =?utf-8?B?VkZsSkxmWDB6TWpSL1dHMWl4OGdXL2FYM24wcEdhOUdqRW44RHZQcWxLTVVw?=
 =?utf-8?B?QURCbXA5eTYzellhMk8yVFYyZXZsa1JOV1NPcEU0cFhENzRGNnJmR0NTYmtt?=
 =?utf-8?B?L1h6ek03TWI0SFdQcUZXVXg4QVAyVjZ1bG1NMkQ2RWhITG5jOXdPS1NGbUxE?=
 =?utf-8?B?YlEyZG01T3Z0aFFpb1B0ZDBhQytxN3Q1YW1vMGpuME9Pb1NYb05lbzNYOHhh?=
 =?utf-8?B?bVFRbUhwaWFKY2tGbUw3R2ZsK3VmT2hONWIza2IwR0taWk16ei85RjI4WXRU?=
 =?utf-8?B?WHdLalBlb00zUmduaEhSL0hyNHFZR2FBMGpxNzlWTnVTYWlaUmRnS1pUSUdZ?=
 =?utf-8?B?UW9TL0RsL3RvcERsWTFIN1pubHhma3ZsSWE4TGVpRGFsdGlmaHlweTgwTExY?=
 =?utf-8?B?aTZPaDVXZ2REVnVmRXcrRm9Dck85SkNtckpMZmVWRFZKam9RU2FrN1A4dHFI?=
 =?utf-8?B?bXJWZmFhcm5zQ284enRHYmU3aWkrSEJDUmRWTGU0TDJnaHNYWWZzSVhaRmIx?=
 =?utf-8?B?RDZ1QVpWanJLRW96SEZBRU1KUDBRS3ZEOVJzVXJhUC9OQ2FIVFNIZ1dDaGV2?=
 =?utf-8?B?MHRhUUdRY201UlovVjBQSldPWUs1aWl2WEVlanRBQ0VZSVQ3OXF0T1ZQWC85?=
 =?utf-8?B?OElYQVlndFoyNXVySzQ3RUNoME9OT0hlUjdXYVl0UU1NZUZ6VUNvc0xnR0FT?=
 =?utf-8?B?M3VCWGJGUFdoSStqTlFxZ0lHNDJKT0hSM2lQVWlUK3h3L29oL2NJQ2hQdlhx?=
 =?utf-8?B?empRNE1Delo5T3RZeFh1RXdXZk1PbUZvL25FR2hQLzd2SjVJNGVHa3pUL2w4?=
 =?utf-8?B?am9rZTRkdlpmVXJRdlM4WWxKUU80WVNlWjdFdVVzUHdQMkI3SjRJT2k0eGhy?=
 =?utf-8?B?R1phdVBOVDc2eUIxdzZZdlRnck52ZUNvb3RBT2xMZ1pnOWp1elNQMjJJeXZt?=
 =?utf-8?B?cEYxeklISS9uL3I2b0JUcDJlTXNQYWpkZGQ3TkloQXBNRzNQM3dwMENtdHFE?=
 =?utf-8?B?aEltUkVoVHBGQkp3NWowTnJHcDZraWc4ZVoyZ3VyWVFBNnNLTTkvdW9ZOWZ4?=
 =?utf-8?B?Sk1YbW1QY0RkUTlqSmsxUGRYZVJWeU45TVhSK0VKdDZtSHFtbUQvQ3FvSVBS?=
 =?utf-8?B?OVhTbU1GUHY1QkdMSklmaHpFNnZHdHIwZzRnWEVXTHkwQTdYcHRIQnJMTHRO?=
 =?utf-8?Q?k2K3hhWLS+Cx6c7YxL3cmlxQP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2af23ec-37b9-4435-0ced-08dcaf89eb79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 04:50:07.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EldyBvnNw4Z7jocpJXFfkBAfOGpiaVQhFRaA3hxT+8loFE/M61NPVQbw6y8GR60X2DBCZswRfmaV4ywhKYgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079

On 26-Jul-24 8:56 AM, Zhaoyang Huang wrote:
> On Thu, Jul 25, 2024 at 6:00 PM zhaoyang.huang
> <zhaoyang.huang@unisoc.com> wrote:
<snip>
>>  From the callstack of lock holder, it is looks like a scability issue rather than a deadlock. Unlike legacy LRU management, there is no throttling mechanism for global reclaim under mglru so far.Could we apply the similar method to throttle the reclaim when it is too aggresive. I am wondering if this patch which is a rough version could help on this?
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2e34de9cd0d4..827036e21f24 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4520,6 +4520,50 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
>>          return scanned;
>>   }
>>
>> +static void lru_gen_throttle(pg_data_t *pgdat, struct scan_control *sc)
>> +{
>> +       struct lruvec *target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
>> +
>> +       if (current_is_kswapd()) {
>> +               if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
>> +                       set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>> +
>> +               /* Allow kswapd to start writing pages during reclaim.*/
>> +               if (sc->nr.unqueued_dirty == sc->nr.file_taken)
>> +                       set_bit(PGDAT_DIRTY, &pgdat->flags);
>> +
>> +               if (sc->nr.immediate)
>> +                       reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
>> +       }
>> +
>> +       /*
>> +        * Tag a node/memcg as congested if all the dirty pages were marked
>> +        * for writeback and immediate reclaim (counted in nr.congested).
>> +        *
>> +        * Legacy memcg will stall in page writeback so avoid forcibly
>> +        * stalling in reclaim_throttle().
>> +        */
>> +       if (sc->nr.dirty && (sc->nr.dirty / 2 < sc->nr.congested)) {
>> +               if (cgroup_reclaim(sc) && writeback_throttling_sane(sc))
>> +                       set_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->flags);
>> +
>> +               if (current_is_kswapd())
>> +                       set_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->flags);
>> +       }
>> +
>> +       /*
>> +        * Stall direct reclaim for IO completions if the lruvec is
>> +        * node is congested. Allow kswapd to continue until it
>> +        * starts encountering unqueued dirty pages or cycling through
>> +        * the LRU too quickly.
>> +        */
>> +       if (!current_is_kswapd() && current_may_throttle() &&
>> +           !sc->hibernation_mode &&
>> +           (test_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->flags) ||
>> +            test_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->flags)))
>> +               reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
>> +}
>> +
>>   static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
>>   {
>>          int type;
>> @@ -4552,6 +4596,16 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>>   retry:
>>          reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
>>          sc->nr_reclaimed += reclaimed;
>> +       sc->nr.dirty += stat.nr_dirty;
>> +       sc->nr.congested += stat.nr_congested;
>> +       sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
>> +       sc->nr.writeback += stat.nr_writeback;
>> +       sc->nr.immediate += stat.nr_immediate;
>> +       sc->nr.taken += scanned;
>> +
>> +       if (type)
>> +               sc->nr.file_taken += scanned;
>> +
>>          trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
>>                          scanned, reclaimed, &stat, sc->priority,
>>                          type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>> @@ -5908,6 +5962,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>
>>          if (lru_gen_enabled() && root_reclaim(sc)) {
>>                  lru_gen_shrink_node(pgdat, sc);
>> +               lru_gen_throttle(pgdat, sc);
>>                  return;
>>          }
> Hi Bharata,
> This patch arised from a regression Android test case failure which
> allocated 1GB virtual memory by each over 8 threads on an 5.5GB RAM
> system. This test could pass on legacy LRU management while failing
> under MGLRU as a watchdog monitor detected abnormal system-wide
> schedule status(watchdog can't be scheduled within 60 seconds). This
> patch with a slight change as below got passed in the test whereas has
> not been investigated deeply for how it was done. Theoretically, this
> patch enrolled the similar reclaim throttle mechanism as legacy do
> which could reduce the contention of lruvec->lru_lock. I think this
> patch is quite naive for now， but I am hoping it could help you as
> your case seems like a scability issue of memory pressure rather than
> a deadlock issue. Thank you!
> 
> the change of the applied version(try to throttle the reclaim before
> instead of after)
>           if (lru_gen_enabled() && root_reclaim(sc)) {
>   +               lru_gen_throttle(pgdat, sc);
>                   lru_gen_shrink_node(pgdat, sc);
>   -               lru_gen_throttle(pgdat, sc);
>                   return;
>           }

Thanks Zhaoyang Huang for the patch, will give this a test and report back.

Regards,
Bharata.

