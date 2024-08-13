Return-Path: <linux-kernel+bounces-284202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDE94FE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CCD1C22B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7CF487AE;
	Tue, 13 Aug 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFuLoe71"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8744C61
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533001; cv=fail; b=CxdjWcs711N0x3+oGfBHh+KBqNktm9rAXJnjSi0yuVN42v08wVFo8WvCmao2+Wdzkzo9g8av5E7W1gyIqjYml5npL/VtCeuMMpgA0tse0fZTpdmMuGSkw9xEs9jTgB/emuxscJ7fJlRTH4CgNCVN9FCc0TKAIqCTyM8Yhk7HKro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533001; c=relaxed/simple;
	bh=y7/d0jLFDKC297Bv5OFUWjsV2KfZGDxYrUTjjQ/ai0E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sK+QeF9tF4FP8zbOiN+oBd6gijc//ogy/NWInzSo2tVhewdIC6BCkGjF9hOzAMiM5VN5ShKud62s5BQ0ljz6T7KyvXdEDFiSISGswLgINlSfP2t2XdTc+b1xu+a2HcRXLrhRp1biFVyJ/0LlYrrGCdtVkXxF3S4+pj64HNee2No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFuLoe71; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723532998; x=1755068998;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y7/d0jLFDKC297Bv5OFUWjsV2KfZGDxYrUTjjQ/ai0E=;
  b=YFuLoe71oMW0VJiI2EeXZuYMqEYl7wiEs29KtSZWV5Hvq/JzADrMrIxe
   OXR1kHiG/2r2G+HmYQzV1/XOyqLu+aZmCWXD86eBaCbI5aolk2FOQj8PG
   i8+DdkjAfAAVH4H6Vm1q1oqfI+dVRT5lYTHhHSeeDHKGBLYxMwzUdUPbD
   HVwMlM2LMR7yKucG49n01t8A6BcMnWClSQLs0sPTM/YOQ3nxyjOvd3NPg
   4MsH/7eV2lrzs/niVSM1nBaYfakGCVeZgv6qbcwGx6gdwEJsn2/4nS6Iu
   s7owBkC51Pu12NU9XM2tjhIjs3T5sIXmk4zyNhjXPgf281gAvm6MuXBNn
   Q==;
X-CSE-ConnectionGUID: 4yInA2lpR7CUYkC3oj/fDA==
X-CSE-MsgGUID: +PpAYbO6TY+4NLL86ffqLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33060853"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="33060853"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:09:58 -0700
X-CSE-ConnectionGUID: HzAg0iN3R2ySKiOmUlpI/g==
X-CSE-MsgGUID: gMWLHK8iSa29MlgCovkmUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58438890"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 00:09:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:09:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 00:09:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 00:09:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEb0eCKcxaqZMQJmhmLh6AsHeQPNKq63erC9jOUaRgSUt6pzj+FQoYAf6aFyjyNp4aYmGcTw8k/Gms1p90spGNkihXI7Xe0WBnoZPbsGPSBD+27zRxllvegKAIwusNEdzoorhZP94DvRwflqe72Sw2qpErK2KTxVkZ2ZXTZqAT6i9sgbc7n1Yp28oyKtvOI0AimQNaP7MLe7nv5VQIOpzBV6DjwitfQAhpNoa4rXs8ywpQ5KI2T9i2ScUNX7kYRtUM9EVaSKisGXxmiOwpSPk/o8m7CKveb3j9ZIE6iObmH5apCOk16f94diIC7EfZKJ/r7Rsq84ckZtQj6bYYnjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C5+s5UPlk/lu0IOVcB8k0JDgIVXGlcX5CZpvYWiMB0=;
 b=OSpEkF8mjHPrV5MWmfrl7bhxnpYEV37uOprwB20vAlV/rJgMOEcMfoJkiBNRZQQGNs+wUYmHAJT/qxxV4zMgr9d0bvjyOa50dM57M7yg8hlihAX2Swv3caYacqJhjmg5clFvjjH0/mWc6oOgkxmB1lhYyNyjHVZ3qXkmZ9HIEj2DIanp/Qf63eGhqoqi57+jaojtOzhCkP63eagCbKY34RIek6LW7BDzZP9k0SnRWImTFc8/hkSB3srhvUPBsR0sJiNTYRv1qmfBBvxTxFjYteFYVYkvUni83KpuogOqNENW/rfAwDi7vmsafahZ8MkZVcyLTPa4e8/TpfLLGZKyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB8395.namprd11.prod.outlook.com (2603:10b6:806:38c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Tue, 13 Aug
 2024 07:09:54 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8%4]) with mapi id 15.20.7828.029; Tue, 13 Aug 2024
 07:09:54 +0000
Message-ID: <817150f2-abf7-430f-9973-540bd6cdd26f@intel.com>
Date: Tue, 13 Aug 2024 15:09:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: Mateusz Guzik <mjguzik@gmail.com>
CC: David Hildenbrand <david@redhat.com>, kernel test robot
	<oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Huacai Chen
	<chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
 <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com>
 <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
 <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
Content-Language: en-US
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fb86ac-6fad-435c-eead-08dcbb66ee7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0hBT1JjZm5EMzlzWUVxb0xTTi9Yem5LamRlWUdBdVhkdkltY2M4bWRwSC9y?=
 =?utf-8?B?VExEeWxveHBmeCszd3A5VlRlZmFyakJsRHB6MUwyU0E3RUlFMkRMRGhVL0tx?=
 =?utf-8?B?dG9YZUp4TDRqMzdEeHkxVXVKeUFpZ1pFelFLQmdJcEtvdHZTbE9YckxNb0ww?=
 =?utf-8?B?T1lGTXpidUVjZk1DTFcxNE1uRDdKdVExY09lbmo3enpQem0xeWhwdkg4Y2I4?=
 =?utf-8?B?dzI2QVJsaVlaSERLNk5WV1R1VDRLVFp0YXVtMEZlRjNUbUJpM0o5aVJaa0hC?=
 =?utf-8?B?dDNrcnhmV2Yrd1NvQ05sWTUvcXdVcDVFb0t4NHZxaVdHV2swbGhCS2w5aUth?=
 =?utf-8?B?ZVcwK0Vzbm1MZXVSQlJJbVcxa2RkY1BYMjlIVGN5a1JLUmFoR2VVRmxLYXhh?=
 =?utf-8?B?aitrYjBGTHRDWSs2emNSS1NWNndXNmFLckkvVW5QM3VRTGNHWXk1VXFsN2V3?=
 =?utf-8?B?MG03dnJXb3dtNDZGQ0U5a04rUC8vbTFtSzJaSHdsVlFxOHpWOGthNHJVODlV?=
 =?utf-8?B?QVVwbzBXZUVOVlloVEN6YXFzdTIrMndxRWJEYTYzeWZ4OUZSOXJWVDhZVlE2?=
 =?utf-8?B?bElnSnZRWmhpL2srbENUZk53Z1FhTUp1WWNJaGlkK3pVQ2tQa2NhbUgwQjBU?=
 =?utf-8?B?SUs0L1pQWEhJRG14M1lvazhJQ3lscERXUWxZcHpHbkRzOUYrRjdwbk1hUE1t?=
 =?utf-8?B?UlN4NWhlcGJBU3pzM0xETmJlVzMvMk42RVk2RzZHcnBTdjI1bmFWRTNsZlJI?=
 =?utf-8?B?aDdpU0dWSVU5ZktBZEZFY3k3UlI1UkNHaU41bDhHeUpRM2ZGNEVkamR3MTU0?=
 =?utf-8?B?YVhsVlZRdEpOOHNLUngreFNOcWpVNlZsSk9UV0dKc0tBSDZEY0RlcndXak5L?=
 =?utf-8?B?eUxiZ3pnNnRDaERpOHUrY1BibWdsYmtZeXBab0lML0VHUmY2NnhQSExZcGo5?=
 =?utf-8?B?cm9MQW1HZ29qTWpCVXdIVTlRdjd3UmRBRVJnTUdaUjFJUkN4TmdkTmlLcXJ0?=
 =?utf-8?B?S1lLR2dEb21Nb3Z5SUpmTVNwazFITGh2NzA2aVdHNjBmdm1KVngxcHZhNkcw?=
 =?utf-8?B?VS8rYUF0UUlNaStBNURkZXVVb1dYRHV4YldCc3FJbmdWOCs1Ny9hbUhMTytq?=
 =?utf-8?B?ckpzV0lwU0FMTzVTT1crTGJlOSsxMFhBNVV6VnNWcjM2VHk0Nnk0bUpzVHVF?=
 =?utf-8?B?YUFWcUorN0hHK2tWZ1R4UWFRS0RrendtYXR1SGF5UC9XTTdmWDZYMzRxTjJx?=
 =?utf-8?B?Tm0yazFtTHRWdk0rcXNlWER0clZNdnpSclZMUWw3cmNid3BwR1VCRXRiQVh4?=
 =?utf-8?B?Y0lXb01TTU9sd3RjUm5MQ0dkOTA3TFFkZU9SUEx1MkloeFhEcFByQXJ6M213?=
 =?utf-8?B?NlphQ0poS0M1aUkzWXJ6UjJrbWxWNkl0bHBoZHJ0VzNROTNlNnd3cnNWYWNF?=
 =?utf-8?B?VmI3bHRobjJnSmVIRG9Ma0dXdG1zTnhaTTNBeXpMVTcyT1dPalRTVENob3hN?=
 =?utf-8?B?and5dC9Xei9ENHhlNElnd3VkWmZMLzVpNkh4VXhsdUNLWkxFc2lSUUdkK2o5?=
 =?utf-8?B?OU10bS8wK0lzSkJ5VjRNUTYwZzhUZ0wxWFE1N0FIZWk1MGZsSVdhSzlFVjEv?=
 =?utf-8?B?aDV5S1pWMmJwVi8rejl3MjdjRGhyR2JhN09OVjd5U3VRVm9CWHN4bFh3UEpu?=
 =?utf-8?B?NnMyR05GcHpSTnV4Y0ZUNm5JY0tTd0ZDOWNiZUtiQTBEb0VwL0J2SG1HVk81?=
 =?utf-8?B?d1hJN3Z5MUNnVmo5bGdSVDZlWU5zZUk1MXpoUnY2dTl1QWFvU0hRa3dpWkNz?=
 =?utf-8?B?d2hqenIzdXYwL0gyMC9nZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Unp3MjlwS3pic2JFMmVmMHhPRnc5dGVyRWs1R1FXejhxNE53dnkwS3RPcWk3?=
 =?utf-8?B?UnlNQnFYKzh3Z3FuekdSTFZJaW5xazhLZkt2WDdDUU9PLytQVkNJYnJmMWEy?=
 =?utf-8?B?V3hFWnRxU2VTMlhPV3hqK1h1c0toMkFHWE9EckdDUW5Yb1hCOUI5dmJlQm0z?=
 =?utf-8?B?RUJiaUlvTGc0aXd1cUI2c0cwdjJWWldpSjRINExLK3hlT1BVOHllNXROZnlE?=
 =?utf-8?B?WGo1cEh4OEVvdXJLV3duU3FxODNNZUdvWWJPcFJBWFVWKzJNSEFVVFozRXJG?=
 =?utf-8?B?TXgzR2VOM3R1SjFCdTB3UEkvNlJpa2NmWnc3Y0ZjNDIxZ2VZWXBJODE4Y21l?=
 =?utf-8?B?eWZzcjk1ZXFpMHNJWjNPY3lyNnJLM0hWcE1PakNWMlY5aEJYYzdDb21IVytI?=
 =?utf-8?B?L3RXOHZUaUgyaDcvZzlqQ0VPaVZuV2VLaHRRVHM2cnBhOXRBS2JUbGxrbDJT?=
 =?utf-8?B?OFJSN01rdmtaWFhZTUJIdWNUUGVzWGVZajEwQkRsTEpXYjIwUnYwdk1RTkdh?=
 =?utf-8?B?U2Z3aUowaVhGWTVYTHF0UHU4OVNTZm92eFU1alhjb091OFFkQ2dvamJZRlJx?=
 =?utf-8?B?NGdtLytRTFJUaDlpZWVKQW01WGViajc2YnNEOEl0Tmc1UDhMcmIvdGt6ZUhR?=
 =?utf-8?B?aWFBOXdvd2JhQUErMS9QcFpvYzlwV3dBMmlDVFNtZjc0QXJpSDN3L1BOSTVz?=
 =?utf-8?B?ZGRreGdFMlhtbW9vRUtaSmNXZ1hjNHR1WUd3U25SR3B1QnFFNzdDSE5IaXZa?=
 =?utf-8?B?Z2E4clV4TTlkVnNrQ2ovRG1WTXpXQytBdnpOclBNZ0JDK1pmL2dSYjhjbE9q?=
 =?utf-8?B?SEtUY1lSN0szQUJ0R1lNRFZnemhqWWsrUFp3VVZheW1qbFFKWW1haC9SdWNE?=
 =?utf-8?B?TnVnMldiS1lwL1JhRDcwcWxpMGtra0Ryelh3SjVTMUxnb2FSb2xuY09SSUFW?=
 =?utf-8?B?T2llakRIdlRjVjJTOC9DWG5HZkRka2JaSVZ1czNrZGZOSnFibHo2ZE52UEZu?=
 =?utf-8?B?N0h0MFZIakpodU9HR3dtOGtkSXJxbkptSFlYVHBXaVV5UHF1YTNWUy9yaXZD?=
 =?utf-8?B?emdKcVh1S051YWFnZE81NVFiOGRaYVFNTTVKQnEvMWtCc2xHZklic0JPeXFt?=
 =?utf-8?B?Z1B3R3lMRzhzTDlyTEkrdDAyRjRZMjlab1d0dHVwT0VnY0FtTExCeVhvKzFB?=
 =?utf-8?B?WHJDbWZaRmtDSkl5dklzVnFmTUdSb3U2K0wyZjlGMXhPZ2hTVFFYWG9IdTFz?=
 =?utf-8?B?RXR3cUVuVUpiUVVWV1lrQWJSRHRCenVTTmNya1JOSnZsS0VYd2doWlFIQ3Fh?=
 =?utf-8?B?QkNkYTRrcHRrOGtJdWhaY3lPMXlpSWF4bkhndXc3bnhRdG85K0cvSmJwMWw0?=
 =?utf-8?B?VTFGT3dBMFpOUnBibTZvV0xGVFdZNUh2eDN5NFkwTGdkUmE0U1ZjWkNKc0Zt?=
 =?utf-8?B?d2Vady9jVTRiOVlhUTFPSjZmbDYyY2N1NElqMDJ1aEpnbmFpNHFZRTBqdWVm?=
 =?utf-8?B?UFJ0cEZvQklyZFJOREpFUXEva2kyYS9sa0pRRVljQ3BYTFdObm44Q3NOTW5O?=
 =?utf-8?B?VStRcldYcUlUb2NvY005MlhtV3p0aEVwL1VyMXJ5bVRMNmFDeVdsSW9NQVlr?=
 =?utf-8?B?a0NEMGw4Q2k4dGU0UUNENDh3NEVFSkhpVm1wZ0gwc3B2UGd0MnZkZ3YyTXdK?=
 =?utf-8?B?R2gyWkc5SmhtT1VYZHB2WTJTeWFxK3U1cDJOR2ZsOGF0WlpPckkyWnc4UHcw?=
 =?utf-8?B?eGtjdW4vcHJlMmJNVllNWk53MHVPbnpFS29kaGhhSUJtckJuYmdONEhyT1VY?=
 =?utf-8?B?UURUcU03eW43VEFURVZOMXNNWjRGZ3g2NUh0ZjZuaHlTV1RlR21heGVOdllu?=
 =?utf-8?B?azVoS205eGljN3JkU25EQnlSL1dHS0pVa3RJS1ZpK1o3ZXVhR2JXUXZOdDl2?=
 =?utf-8?B?WVJqb3c3ay9mWlpQYmw1SWcxb1A1Z09zSzZab0FNUXczRWsySUc5WE40YlVS?=
 =?utf-8?B?d2hJcFBoNTZnRXpoTFo4L3NSSFBoN0EreW1UdkpWb1BDSWNXbmZVcCtadnRJ?=
 =?utf-8?B?b21NbUU1WUwwVUdNTkhKUWJ3VGdUL0xlQ1hWTTZPTDlvWC83TlRYQmYwUFdv?=
 =?utf-8?Q?3TRLE6prVg2ji7WZWGBrocTa9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fb86ac-6fad-435c-eead-08dcbb66ee7a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 07:09:54.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmEvG1qX+t/az3Jo33XjK0CwCVpwYLDAO9Cxbf5A7LPnF9TaJ5Kyn8ZcRtAO+HC05X6qlOmUBtMlUtIorBl71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8395
X-OriginatorOrg: intel.com

On 8/12/24 00:49, Mateusz Guzik wrote:
> On Mon, Aug 12, 2024 at 12:43:08PM +0800, Yin Fengwei wrote:
>> Hi David,
>>
>> On 8/1/24 09:44, David Hildenbrand wrote:
>>> On 01.08.24 15:37, Mateusz Guzik wrote:
>>>> On Thu, Aug 1, 2024 at 3:34 PM David Hildenbrand <david@redhat.com>
>>>> wrote:
>>>>>
>>>>> On 01.08.24 15:30, Mateusz Guzik wrote:
>>>>>> On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
>>>>>>> Yes indeed. fork() can be extremely sensitive to each
>>>>>>> added instruction.
>>>>>>>
>>>>>>> I even pointed out to Peter why I didn't add the
>>>>>>> PageHuge check in there
>>>>>>> originally [1].
>>>>>>>
>>>>>>> "Well, and I didn't want to have runtime-hugetlb checks in
>>>>>>> PageAnonExclusive code called on certainly-not-hugetlb code paths."
>>>>>>>
>>>>>>>
>>>>>>> We now have to do a page_folio(page) and then test for hugetlb.
>>>>>>>
>>>>>>>        return folio_test_hugetlb(page_folio(page));
>>>>>>>
>>>>>>> Nowadays, folio_test_hugetlb() will be faster than at
>>>>>>> c0bff412e6 times, so
>>>>>>> maybe at least part of the overhead is gone.
>>>>>>>
>>>>>>
>>>>>> I'll note page_folio expands to a call to _compound_head.
>>>>>>
>>>>>> While _compound_head is declared as an inline, it ends up being big
>>>>>> enough that the compiler decides to emit a real function instead and
>>>>>> real func calls are not particularly cheap.
>>>>>>
>>>>>> I had a brief look with a profiler myself and for single-threaded usage
>>>>>> the func is quite high up there, while it manages to get out with the
>>>>>> first branch -- that is to say there is definitely performance lost for
>>>>>> having a func call instead of an inlined branch.
>>>>>>
>>>>>> The routine is deinlined because of a call to page_fixed_fake_head,
>>>>>> which itself is annotated with always_inline.
>>>>>>
>>>>>> This is of course patchable with minor shoveling.
>>>>>>
>>>>>> I did not go for it because stress-ng results were too unstable for me
>>>>>> to confidently state win/loss.
>>>>>>
>>>>>> But should you want to whack the regression, this is what I would look
>>>>>> into.
>>>>>>
>>>>>
>>>>> This might improve it, at least for small folios I guess:
>> Do you want us to test this change? Or you have further optimization
>> ongoing? Thanks.
> 
> I verified the thing below boots, I have no idea about performance. If
> it helps it can be massaged later from style perspective.
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5769fe6e4950..2d5d61ab385b 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -194,34 +194,13 @@ enum pageflags {
>   #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
>   
> -/*
> - * Return the real head page struct iff the @page is a fake head page, otherwise
> - * return the @page itself. See Documentation/mm/vmemmap_dedup.rst.
> - */
> +const struct page *_page_fixed_fake_head(const struct page *page);
> +
>   static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
>   {
>   	if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
>   		return page;
> -
> -	/*
> -	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
> -	 * struct page. The alignment check aims to avoid access the fields (
> -	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
> -	 * cold cacheline in some cases.
> -	 */
> -	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
> -	    test_bit(PG_head, &page->flags)) {
> -		/*
> -		 * We can safely access the field of the @page[1] with PG_head
> -		 * because the @page is a compound page composed with at least
> -		 * two contiguous pages.
> -		 */
> -		unsigned long head = READ_ONCE(page[1].compound_head);
> -
> -		if (likely(head & 1))
> -			return (const struct page *)(head - 1);
> -	}
> -	return page;
> +	return _page_fixed_fake_head(page);
>   }
>   #else
>   static inline const struct page *page_fixed_fake_head(const struct page *page)
> @@ -235,7 +214,7 @@ static __always_inline int page_is_fake_head(const struct page *page)
>   	return page_fixed_fake_head(page) != page;
>   }
>   
> -static inline unsigned long _compound_head(const struct page *page)
> +static __always_inline unsigned long _compound_head(const struct page *page)
>   {
>   	unsigned long head = READ_ONCE(page->compound_head);
>   
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 829112b0a914..3fbc00db607a 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -19,6 +19,33 @@
>   #include <asm/tlbflush.h>
>   #include "hugetlb_vmemmap.h"
>   
> +/*
> + * Return the real head page struct iff the @page is a fake head page, otherwise
> + * return the @page itself. See Documentation/mm/vmemmap_dedup.rst.
> + */
> +const struct page *_page_fixed_fake_head(const struct page *page)
> +{
> +	/*
> +	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
> +	 * struct page. The alignment check aims to avoid access the fields (
> +	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
> +	 * cold cacheline in some cases.
> +	 */
> +	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
> +	    test_bit(PG_head, &page->flags)) {
> +		/*
> +		 * We can safely access the field of the @page[1] with PG_head
> +		 * because the @page is a compound page composed with at least
> +		 * two contiguous pages.
> +		 */
> +		unsigned long head = READ_ONCE(page[1].compound_head);
> +
> +		if (likely(head & 1))
> +			return (const struct page *)(head - 1);
> +	}
> +	return page;
> +}
> +
>   /**
>    * struct vmemmap_remap_walk - walk vmemmap page table
>    *
> 

The change can resolve the regression (from -3% to 0.5%):

Please note:
   9cb28da54643ad464c47585cd5866c30b0218e67 is the parent commit
   3f16e4b516ef02d9461b7e0b6c50e05ba0811886 is the commit with above
                                            patch
   c0bff412e67b781d761e330ff9578aa9ed2be79e is the commit which
                                            introduced regression


=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/testtime/test/cpufreq_governor/debug-setup:
 
lkp-icl-2sp8/stress-ng/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3/gcc-12/100%/60s/clone/performance/yfw_test2

commit:
   9cb28da54643ad464c47585cd5866c30b0218e67
   3f16e4b516ef02d9461b7e0b6c50e05ba0811886
   c0bff412e67b781d761e330ff9578aa9ed2be79e

9cb28da54643ad46 3f16e4b516ef02d9461b7e0b6c5 c0bff412e67b781d761e330ff95
---------------- --------------------------- ---------------------------
        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
            |             |             |             |             |
           3:3            0%           3:3            0%           3:3 
   stress-ng.clone.microsecs_per_clone.pass
           3:3            0%           3:3            0%           3:3 
   stress-ng.clone.pass
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
       2904            -0.6%       2886            +3.7%       3011 
   stress-ng.clone.microsecs_per_clone
     563520            +0.5%     566296            -3.1%     546122 
   stress-ng.clone.ops
       9306            +0.5%       9356            -3.0%       9024 
   stress-ng.clone.ops_per_sec


BTW, the change needs to export symbol _page_fixed_fake_head otherwise
some modules hit build error.


Regards
Yin, Fengwei

