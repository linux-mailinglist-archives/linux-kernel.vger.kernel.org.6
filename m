Return-Path: <linux-kernel+bounces-173499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB98C012D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CFA1F25C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F7127E10;
	Wed,  8 May 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCDe0tEY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C491A2C05
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182907; cv=fail; b=uOPSK204ujA/iutnebFls8WD5E0anbY7ma2D+YA/b5LEL514/aXRSoVGsb5LQLNJSxve6RM9A2dcpAvdo02c0Loc7UQjDnUgd4BGv/9SX3IoI526OyEc9K1g/z02mqUs04nEDtyb8s2ROCs7y5cfONWhyAIaciKyR6xOxgNsWg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182907; c=relaxed/simple;
	bh=tTfu15T/4jpz9PywKiadq9SeZ5L5+cYLnfZmd04iIz4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M4g0jq9zurk8ZNdoV5ME/E5X0aB0OZNzBYSBIToPT2APuuzpsqmR+ZHRqteA7X+gLY5Vey/T0/5ie2rVLIdABMQirwj9HQHIzrqLYYTZ6FGJ8rBIOvgdiUKUxrxY7dkHhMPWjPRD8mhWU9QikVCqPpXr3ZQ7fbvdiQ2WSXgNdYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCDe0tEY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715182905; x=1746718905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tTfu15T/4jpz9PywKiadq9SeZ5L5+cYLnfZmd04iIz4=;
  b=ZCDe0tEYELHkTOCuvyBTgZExYMQ8woI2SnxleaeKntYkKTuk4JDAjqU6
   wGoQE84txdn5Bp2ZWp19/nHp2dGIGHYYEKi1vesfmfiVabjrGwS45hqZt
   xjIvZPrANxx5cAhCg1qvyzsJSyMqnkXbR8lk5zE1q4cmM1pnfWmLuzhmB
   XiJ4J47atT8mYTF194CyuHKHDF85CeqJuJVwkkJXi2rQR8FpqkLPSt9xQ
   c8oMtLNlHDZkCfD94dwS6TT5PZK6ynpH13HbR6H7nuNPRdLMrnTX4fyjg
   FRbeXQL54/+dHmGuLMkW0sVsdb+xhFspBp5AL9euE50ej4917dwoBc69c
   w==;
X-CSE-ConnectionGUID: qoYV4v8/R+a9gnF/1PqllQ==
X-CSE-MsgGUID: tF7VEm9eSJWU/hx8XvxQYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22458548"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22458548"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:41:44 -0700
X-CSE-ConnectionGUID: WvyfFfmdRnK1OLk2jHYr6Q==
X-CSE-MsgGUID: KnjYc9bqQLG6hiFNYpQshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="60094581"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 08:41:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 08:41:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 08:41:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 08:41:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 08:41:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awq0Tl2bxsW7jAYX10pwcaJ+02qUAUwyAXayOIHSdqMFkE3zcvs8PfUdxH0/6TcCXGRIwKrx0wPfaQVm3zgjjurmKAdz1yYwFHLjIjsKQ5rK9tu7LLxJFFaQxS0DjCH7uKWW2f/V9IcSxkwr4NtMy7YM5T80rAXYY+x2wYDJCzQ5502W8Yi55z5yFLD2QCbTXAPEX15XmdYxTO1CyvLeUefTQRFZvo8VimkKZtupKQuW1ffxbinkTjiarsysUR9KDBQ1/qt2ZqCw9Y6MwtGsF1QAUMceWuxTc45Vov0lcNgrQ4iUTgkH6OJLWpJ10YjCGnohBNh7Wjpt0fMctSI4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nqz8sBjYm2XPcCQShmXrB4GayzK8FWPSKrmOHH73MI8=;
 b=n6RE6/4kqqCtR5iNJpVphWqFbUfYTiSaxrQUpfW0A64jTRVuvTtMnWehSlaAihG2GHf3PiiKY1kBbrLfQlZ6vmqg4eOzzxXphb8eO6nWvEVDRdY1APaesfnEcB+kDO5GtLPI1eJ63XlVatWWk8GHnpPs/BMifYdulboJ1QKiiVdDfFzTHRIohzBbJC3+Isr6VSLiyScHDF53+xctqhSnplQtXac7ECIEGP/O/+IUtOpL9zaGTcFQRpvAZF8GkxotaRbt2iVgh+KAbeVyx/oJZURg9hW/d1CP9xFJKIVBvg9XadPBgsb0xyZk6r+Q8MWkrFz+CrPwNiAhKxgKMPVqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Wed, 8 May
 2024 15:41:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Wed, 8 May 2024
 15:41:40 +0000
Message-ID: <b60aa6cc-7396-42c5-9a42-db8d6e8bfef6@intel.com>
Date: Wed, 8 May 2024 08:41:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: James Morse <james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>, "Shaopeng Tan
 (Fujitsu)" <tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie
 Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>, Peter Newman
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240426150537.8094-1-Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8e3ed7-d46c-4ef4-1373-08dc6f755ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHNZU1kwVWN4MzhaVElZRTRHbE9CNmdHUDc4ZzZyOVRaSzhqTUFKejhSUG9U?=
 =?utf-8?B?UE1wZnRuSnhQV1J0ZjgwcSttaTVZaDMzcTc4YXZMaHBFNXl2ODRvSzBjTzJl?=
 =?utf-8?B?K0dxemFTR2d2ZUVsdlZ5NkVyUjBxd1Aya2J6ZUJCUU5ZNElGN0M3MmJyWTV0?=
 =?utf-8?B?cHZ1MUJraWUwaWxnTndmSXg0c0lPazdqcUZPWUFhN1ExVWE4RFppakk4eHNE?=
 =?utf-8?B?M0x4UDFzVWU1c2w1Nkw1MHJseHBVQ2xBRXUxVjc2VDZJRk5EMFpUd0htV3JT?=
 =?utf-8?B?NHlzRUU5NUFOdG9xQ01qOFlNbWJGMzM1TGU4cCsxL1dkQ3ZTcWdUVTQxZTNz?=
 =?utf-8?B?eFRPVzFFTTdja3dETEZKQkwvOU9VOHBSRzlvZzZrdURoT2s2Zi9iODdrS3Fa?=
 =?utf-8?B?ZGs2SWRzQS9iYk5HZUtVdkZ3b3Fsdm9Cc21ucC83Vkh0cEwybmNxajlPemF1?=
 =?utf-8?B?VnB4OTdrNWVXbjBnOHNtUGM0eTNDTWs5V1dNUEcwZE53bzF5b3oza2k0TXN5?=
 =?utf-8?B?cUErZXpFZzJ6dEx2UGNHZ1ErYU1KbE9qaloxdGEyZVdVZExXQjd4WGRkcXA2?=
 =?utf-8?B?Tnp2SWxMYytnblR1OC9ha0ZydVc4SGdkNFJIcTZKNDQyNDlZTk4rRzJMd0RB?=
 =?utf-8?B?OHFGcUhMTlJBMGt5R281MzZZemtLUHZUakd1ZWlwUTY4RzlObEVOaGtreExp?=
 =?utf-8?B?ak5JMWNGc1c5OTJuUGYzTFhyWUhmeEZVdmRYT0g4VEVaWjlFeWZvNFB5Tm96?=
 =?utf-8?B?OHlveUhqdCttRk1FSWgrcmxVOVFwME5QNE5HdnhKRXpTZm56cE0wT0pJZzRs?=
 =?utf-8?B?Zm1rdDFham5GNEgzVDgwdWl1bjNiNnE0V09kaWJhb3RrYjNyd3BHQmZFcTJ3?=
 =?utf-8?B?bm92M1pFdTlIcTRBNVFUenEyU0p6R0tnRm8rNktZanI4Z09tMzJYN1VMczlQ?=
 =?utf-8?B?M0N2bDQzN3ZUK1Z6UmNhN1BrZ013VWozWWJPOGZsY0pwYVAzcVpRZ3BRQXJU?=
 =?utf-8?B?dTlMOFhySG0wOG11ZWtzdWh5MUsveGlYditVMFE4YWpoeWN1Z09Cc20ycWY1?=
 =?utf-8?B?Z2QvWlovNVN2UWw4R2hDM2NxVlNadGIwMmJBSW9xQ1NYVFFUMmo2dXpURHND?=
 =?utf-8?B?K3NRZFYvZzhHRU9sejZ6Um43ZmFySVE0QzVlL3UzY0JjOERrbDRyOHVaRkNR?=
 =?utf-8?B?aGRMUUFWdU4wN0NRTUZ2cnR3VWtUdUlmSGZvTVM0ejFsM2RpTWJoS050eWJ3?=
 =?utf-8?B?bCtOYTZ3R3BXTkhjaTQ2QjJHYkdoOHpteSt6eGJsTlB2ZVdsNXBMKzIrWHFQ?=
 =?utf-8?B?cktnZW42RU1udklTSTdrck9nZGEzZkpqbHZsc0YwcFNpcE5iV3Q1V0tkb3hZ?=
 =?utf-8?B?TE5qcllHdnRzNlYzcjRIQ1BxMk9kLzZESi9ON09jUlJlcUZoOWk0Wm5LMjBD?=
 =?utf-8?B?RzhyWHg4bnJicElJQ3M0V0wySHlHWVFWN2NlTjgyWFJycVlzUkZhcDQ5amZv?=
 =?utf-8?B?QkZJUnJQRUx0bmx2eVhHVHQ0QW91ZDEyNm1TRDd6Y0d5SlNCckpsRFNodW9m?=
 =?utf-8?B?WTNQbFFSemJBd0FiYUQ5L09PN0FjWnBQS3FDaVVkNWVsY3plYVVob2drU01u?=
 =?utf-8?Q?jPpvvhauqLJQjtMw7G+4q8FgWORZeE1myuPbue6VWXZM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhUTFBHOUt5RXNKNVJlSGxmR25PZ0xGRFdzMUVCS1V0a0tYVFlxc2loSlVn?=
 =?utf-8?B?bk0yT0x1SnpUamVUMUlkM1RocTZHZUtXSVY0WmRYcDU4UU1TR1FUZGhBRDNp?=
 =?utf-8?B?WmpJSWFkaVo4eHZmZzNMTzhvc1FOM3hUV3hLR1YrdjVUeHRzYS9NZEU1dGlq?=
 =?utf-8?B?dDdlOTdBeTl5cWRBUklub3FvVUZCZkhuM2h5M25wMExtRmcyVE9PQ1BGd1ow?=
 =?utf-8?B?LzdwLytuc21FSGwvekVxUFdXZDhHZHRVTkY0SGpOcW9EN1NEcnlCYUF3dk9U?=
 =?utf-8?B?akZJa2ppcStwZEZBV1NoOU4yS1VyOGhNcmYwZmo4cjd1NXhaV2hteWlMSGNO?=
 =?utf-8?B?ZndpelV4Y0tkeHA3UEhwZ3NnQnhGclU1NjFxYVM5bmFsNlpwTCtKcFVLem82?=
 =?utf-8?B?M2ZoVzR4MW03akx4N2J2VUtKeStubmtzN3JnZG9IQ205OXJJTHM3SzBHTWw5?=
 =?utf-8?B?UWdZM3pwMUtFTkdDQUlGRlVRdDBtYjlLckhUL2NjeTR3N0twcWMxSmlRWG1a?=
 =?utf-8?B?WTNQV0FBVWxMdk5OTGNoWHlrcEVVZTFjcXc3RlZRNXNuQkQ5czZsSS9iK3lk?=
 =?utf-8?B?dGkxZUFYcVhVdko0SGZzd1hWZGx1Z05SL1BYaXJyMDBNdVBHSjR4bGtZU1RC?=
 =?utf-8?B?ZHZxK01QWUlTZ3pWL040WHZNdmdoa1VkZWFGNEV4cElOb1FTcklVVE5iWVRI?=
 =?utf-8?B?MkZrUUJ6K1cwV1BIODFkYzc2bGdWV0cyUFYvZTFWb3VVNVg5NjZBTXkvTG1i?=
 =?utf-8?B?QzFpbVByRmFzby9QbGJienVXQTA0MXJ2NnhRc0JJblExd092dmV4ZlM2Y0pq?=
 =?utf-8?B?bDJtcGxlMnhoRW9kZmNUbjNHT1U2OGt0VStqeDhBMnNsbnJBQVliZDlpOHhK?=
 =?utf-8?B?amhoVUZHMzBvUnlwbDB5dnJHcmM1N0VhSFpLWmwvOFZ0K3VWYjJ2Mm15TkI0?=
 =?utf-8?B?d3B5aENOakZGNG9mVHZ6YXhZaTFSUVdWbnVvMS93Zk5zTXl0aXBtcHV6Y00v?=
 =?utf-8?B?SEdyeENKVktuTkxwd3VselI0Y0Z1b1g4aEhmY0luSGNJMk5NaUVIVm9yRkpZ?=
 =?utf-8?B?dnFzdE1jQTgwRDBaejhVcU1GYkFaaEUwZDFtUktHeTk1MWhMUkpCSFp2Q1ZU?=
 =?utf-8?B?NXVBZjkrelhhRDF3N0dZZi8wRnpaSGxocFQwa3l0WmZ6MENDVEg3Y0crYjZo?=
 =?utf-8?B?eTZ6c1dsVEpCSWsvMHVPbkFaczY3NEdnRmU1WDAzNzB4UlljQlYwMWpFRGRP?=
 =?utf-8?B?MjdPZ2gxam84VXZjN0ZxalVVTzE2K0VIVllTbEUrL1BFNDRlZVFhTWlIcEJv?=
 =?utf-8?B?V1ZES011eUprbndxd0xvdG1RWHZVVU40ZXd4WDhjOXdKQS8yOXVtVGZKcUY0?=
 =?utf-8?B?dU1tUmFlc3VHcThkdXMrYnllVlZpckJTYURXSThaYVFOY05uVzkrRlJLaURo?=
 =?utf-8?B?UVFRWTRKTS9UUFYvOEJIQ2N4SXBuVjFjYmVUbGZYdFV2VFlNQXJqWGVUNDNS?=
 =?utf-8?B?R1B3RDJISFoxZ3lUSTRaYWdjbjRZL1NWRFlDWjBmMTgxNXJuZnFNd3haRlVP?=
 =?utf-8?B?MVZkcE1LOEVOckcrVGtIZS9PUVJ6WXFxMy96U3E3bkFwWG5TUGE1QWJVcnpM?=
 =?utf-8?B?UVZVUHVpNm9QZ0I2K0Q5amVQVzRBQ0xLa05oLzN2VmhNYTdxSFBXQ01XcXQ0?=
 =?utf-8?B?d3dveUhDcjZqdmlKcUtLTkUwZmd1c2VwU2EweEtBb09FcWM5aXRGQWRNU2d4?=
 =?utf-8?B?RFhZL1N1WFJPbElNV25PZ1c0WkJKajVnb2pjZ3RUdDMxY0Uyb0psWDhvYU5R?=
 =?utf-8?B?aGIrQmI3dy82UEYzQitIWlllWEtXVmYrdjAvS0toWndrVHpLRlhDNnhHOGU0?=
 =?utf-8?B?cUVLMUhSNFJObUgvQitxRVpYdzRHZnl2LzVsMVJ2Q0E5V2Z2UkI4ai9TOCt4?=
 =?utf-8?B?UWNMTkF0Z1dPTU5FdUo2cVFBRFcxYjVIZkpNZ2dvcTQxYS9kd2xWcC9sR0xw?=
 =?utf-8?B?ZnJWaXhjZlUwN0hpYmJROUJvU3NOOTlBRmNUWXdHd09vbmZ3aHkvbGZ4bjJt?=
 =?utf-8?B?c3N6ellTbnNia0xML1FsWG1DN0VwQVFnYjFhcllOajZPWTN5SWt0alNOQmVG?=
 =?utf-8?B?NXZMaDZiVFIxSEw1WXBqRU5oQTdZemdsZHp0RmtWaURtcUlKeFVQNHJrSTN2?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8e3ed7-d46c-4ef4-1373-08dc6f755ac7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:41:40.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQxkLzfyyBL26BrEvc3LiAFKGpv87hqlOvUHLZxQRkwFzwqq93gvLKm171FZ48aKwNGhjcTw8FeedL0Zf5FlUDTTzqnO87lRs55PKP0ZYdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com

Hi Dave,

On 4/26/2024 8:05 AM, Dave Martin wrote:
> This is a respin of the resctrl refactoring series described below,
> addressing review feedback.  Many thanks to those to responded with
> feedback on the v1 series [2].
> 
> See Notes and FYIs in the individual patches for details on the changes
> and outstanding issues.

What are your expectations regarding this series while considering [1] and [2]?

Reinette

[1] https://lore.kernel.org/lkml/ZiE8%2foXyjBef2qTy@e133380.arm.com/
[2] https://lore.kernel.org/lkml/acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com/

