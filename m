Return-Path: <linux-kernel+bounces-531851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D84A445C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE017A8551
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025C18FDBE;
	Tue, 25 Feb 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRwzI0VV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC818FC89
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500219; cv=fail; b=qvSpoZLPjhz1O7TAsFWOyTmMK1u6Mr2zMMxJzphha2Mv76FYXUlST/8hxzESwEb6DkaJ0QZDiDHNkS0bfYoTwaPc0aJezcj09dSJD9u7aohVyhLU+v0aZx1yuX7TZPKVY4S4Xj77WKgrS22GWMNAogJu/RlQOacdYUifmswMNy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500219; c=relaxed/simple;
	bh=qEDA8kfZr9rggoR4l63yNIxx9BziyyWnahy2zzTU9C8=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOyJSvpye9NEIx2j4GAwXLPYWKdCug4x/35ypEqv0V3wo9rMY3HA1JwOevasUeIERF3pkp9ri2OrN65E3NFaf6xWJA78JD7HELVUT630Leg8AAUk+0Xal5ET/GcT9Mqcg7en2GHEPDEH9iBUKuHngykdcKzfZssemdnwF4RRmik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRwzI0VV; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740500218; x=1772036218;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qEDA8kfZr9rggoR4l63yNIxx9BziyyWnahy2zzTU9C8=;
  b=gRwzI0VVw7Zn1rxttC5fZbbpUEPN4TdoHhcUruLQdpZbuilaCSrpztW/
   8Orb6jvBDO1KY+tpdjSodd9fLLB7jQh0hrm05eWF9z4bH0KpW8oP9VJIW
   j1w6YJbpES+jsSoQNAP/kPDbhJIh3Eegs4PGwICTgugkNtTFkWmkp+mcH
   j0oubS9WUceGwnyzhmhFBOXEcieaWJgkpXi2U1YSuVF9PcZYK7jjKVVUo
   gRdM2wjn3lJHAXok9PI+k/eugmygl5tUkzhXhippfpPSEYKChEgHktChi
   GOA9zGV+OfOgOaCMMynQ1s2ICZEHTaDErnyKHk7s+oejzYsuNZTMHtmZ2
   w==;
X-CSE-ConnectionGUID: qj02P+pTSAGJpdWF+otgtw==
X-CSE-MsgGUID: zfxMF5jCQJa9OXhALjRqvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="66682703"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="66682703"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 08:16:57 -0800
X-CSE-ConnectionGUID: ElYMoFnwQi66kgOuSzEqug==
X-CSE-MsgGUID: yzyWN7+GR4aF/GqLmZO0BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116447836"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 08:16:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 08:16:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 08:16:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 08:16:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBFeT1rw/aU2kGvDrUFfelANdsbG4giWxfMWNvOpFOevqYe6g9p1B/WZjfNsqeDEIXJ+munLxVh0mI8R3WFYxjZYLugWgvia79he6WzWp9gMeD7d0OJwxleFJwGDgnpp5ku7OwukfX3yQ0abeIiUu/QS+NaeFB3EoPno9/nPtq+ilNQiFJ65X4qPVjtRkvQtkJW7X64XszL2CuaPl1OeiIwr1vuWOU/YEwq2C7n9yzAXAGBglWqKVdt8btFfh7KhBShLtod1VeetNXUjfaTZ1tO3lvl6/MZuyNCpmszbJ56VYQF6Xf5r5IkS9/96W/dFX1j9Yy1k6HylIsReOttTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHZfXVZJYFM8fg8n+l0RfXPX3gXG5N3QWa6T0aVa9YA=;
 b=rgDAIzyBNxlKnrN9wU+CkeLPzszVsqpCO5Yy1Tfk0NHfiPzTOgBs2rgQZDdRyP0yMEATvurPGlxMFmnRp4CN/MeIXCmCYW4GNRorjbhy/pUUAiQ8QxIIbM50/7qYAvWWo09B/uNoDEm8fGSJB8F8O5fYNJP8CwOjiliqgBwBRXJ9eLel4xV5rxjj7gjV2lZSjhCmpw0Xs0yX8C+VfCGfmUHwCYWr5sLhWZXhZfJao1kMwpB6L3/X2YnDpReIGtQBcIx62cj54+AeZhq1uTjtRHY9UHQlTTqO8HPSDm25v0CwbACzVX5+h2oQmEYXxBf2LL1dQmnKJ++NZZADxCdy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 16:16:11 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:16:11 +0000
Message-ID: <545e4e79-e309-4bda-9a70-204d83749308@intel.com>
Date: Tue, 25 Feb 2025 08:16:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/42] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
From: Reinette Chatre <reinette.chatre@intel.com>
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-43-james.morse@arm.com>
 <baa225e6-65bd-49ec-baf9-166ae4f2926c@intel.com>
Content-Language: en-US
In-Reply-To: <baa225e6-65bd-49ec-baf9-166ae4f2926c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SN7PR11MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: eaad1300-a9fd-4ebd-0812-08dd55b7b803
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDcxdFRDY25sc3pUbGtpQy9JSUlFRjA2YzViNEM0S0Y0VzBRYXhKcHd6SzN0?=
 =?utf-8?B?dTVsZDlQeDE5VUJYNUhzS0dXUklSeXk3c0xib0RpbTk0RGVLZG1QU1VLbmNi?=
 =?utf-8?B?My93OWNRVjYvcGFRS0VSMWUwR0pmQ0pxcE5tVVBNNVBUSW4yT2h4WWdKU2d3?=
 =?utf-8?B?b3hUaVdMN1A3UHZmUlRObE4wdzNPMWM5dGh1Ui9tVmlNM3JNY2NMeTJ4bEdp?=
 =?utf-8?B?QjArZFJTUUU5WlVWcWljM3duSGVQcG16bDhoMjVIQmRzdzJGSFlRZE9OVFNs?=
 =?utf-8?B?VU9ydG1HZDBRQTU1Ti9uUS8rNHVUdktiNUFSYUlPVUU4aUNTcFV2L21ES3pn?=
 =?utf-8?B?NkgvQVB1aVZMdXE2eEFPQjdubm5vK2Fna1hQR05ZNWs5N0hpUWJ6SmQyVHRQ?=
 =?utf-8?B?eXJ5WGF4c0JLOFhZSFdYU2tGWUZYelRacWt5VndpRXR5RDFNR2RBTGVHRDBI?=
 =?utf-8?B?alIrODRDV3h0QVFVcFY1Y2ZFNEN6VzgzYWpyeWQvc0MvSnUwTzVrZFFiS2JQ?=
 =?utf-8?B?T0VkMUszQ0MxOGwvbjZGYkp1TThyNUsxOGpTTDNKUXNEcFJhS3orZzdHWkNR?=
 =?utf-8?B?K25XVS94dENNclpMZXR4SEF3dXVzSmlBQ1hGdWVoYlZ1VEt4dmFXRXZVK29N?=
 =?utf-8?B?V2ZzbnBFd0dJY2pOeUtJVy9NclZqWVU3UVdpRmpOdmZjREFheFRoRFRrZUlq?=
 =?utf-8?B?Wk9KY2NZRGxhbHdHRUhTT3dkQS9tVXFGMWl3b0ZGVEpWdnhDTU9RTG1mRzdw?=
 =?utf-8?B?V1pNTVdqVWw1aDYxUEZrYi9qV2dpMmlwc2xtampHTmVNcGxodUpVWThVd0FE?=
 =?utf-8?B?MlpyUmNtWWlYVDl0RmRicXVUb3JVNjFiWUVDZnJrUlBWZFpEQXAvWVRCZFRq?=
 =?utf-8?B?a2FCdzRKQTI1WTVOQ0F1WmxVbXpQcGYzSnlGZzk2K3RaeERaY0RIa3pyRlR1?=
 =?utf-8?B?clpCUzd5UDBsYjNweFMydW9uTUhPRVJrcHRFVmYwZDdLdDBZN3RsRzcyazJu?=
 =?utf-8?B?OU5oSmtTem9MM2p5STM2T2lDSEVNQis3WkRFc0V6MUhNV1RwRkJhc3BCQzBo?=
 =?utf-8?B?MWRnV1h0anEvZk4vRThhendtTlVxaXdGdTFKak5MN2hrT0RzRVZFZlhrUTJq?=
 =?utf-8?B?QjBjZ0ZRSmpzWWZDdHdFdkpBV1ZzUWg2UFJSdjBDUVRZMElTZkNyV0hIRkd6?=
 =?utf-8?B?MTRQU2xYN0t4RWtqRHJoNXMzRmZKOXRwamlUTHQ0MVhGRjNwS2FKclVZakph?=
 =?utf-8?B?YW5PdEY3VjdrY0kxK3FEK2hORjZXWklMd1dQY0xMdWpZUjMxSE9ISW9EY0Y4?=
 =?utf-8?B?TW5lWnJHY2pjR1JxTXB5ckF3NkUyS1h6T29oZXRkdWdwUkswTzczKzAraDJo?=
 =?utf-8?B?a3MzSm84dGZsYjh1U3dBcmVLY25ab3c5dmlMVEthZzBUR0dleTBRZkZ4cmZY?=
 =?utf-8?B?WHBja3lXcFNqZnFYK092M1BTL09IYXNtWnNjRXhUbW5POHpReFZ4djNFMWM0?=
 =?utf-8?B?RXhSWU1vMDNOUWNmcFl1RG9NRUlZYlNSU0pvK1l6OTVOc0tiQ2hyZzIzUU9Q?=
 =?utf-8?B?R1gyVlp0SVJvcFE2Y2F5WUVHYWtjbW5TT3hmMzMxUVk1WW0vRjgwaHozVXVW?=
 =?utf-8?B?SFRNYU82NjVodDk5azQvNjJqY2g0dHNtMVY0b3hLR2NlRkZEdVEyWnA0clMw?=
 =?utf-8?B?NFB2MEUvcVdlOTc2TjRVSWdRN2YzMXB0RmVreWw4UHprcU53N0pGQ0xkSUFY?=
 =?utf-8?B?d3dRaExkanlyeDVBeFlmZ2JHRkxwTGljdjRtU3VOZ1RmRVpJWlhXZmRia0Vx?=
 =?utf-8?B?dXhIVUpRT1J3TGlxVHl5NUppMWV1TXB0VWtteEFpS1FIU1E3T2tZMTVoWC9o?=
 =?utf-8?Q?1NJzGU6W2IXjs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVJWmVKeGJwZUE2NnA2d0JmN3p1eTJJVG5VN1dHVEdjWXVKNHphdHhJbzhB?=
 =?utf-8?B?WHhQcnJ4UzQxMHJtNWZlaDVPR3pqbk56Wk1ZbGRrNmFoSndhYzlZQmtYZUZK?=
 =?utf-8?B?UkNsRzVJM3ZKbDBoeW5WOW1NTU90TkdVdldYMFFpYkxPOUg1SGVjd1VOOGFS?=
 =?utf-8?B?V1dxYVVJR05oN2FZUmt2dU1hUE53RXRFVitLazZ3THFyOWxZQXFLMjNEc0hh?=
 =?utf-8?B?VWNVNXRUVVkrT0ZTNlkzUno4aDBhZVlZV3dIRXhUUEp2YUgvam1iUTlUSmJW?=
 =?utf-8?B?azROTlFNeTBnMFM0bW56YUlEVnJ0S05XQmhkNTV1YlFvbGI4NmFvRkhheVd6?=
 =?utf-8?B?R2tRQXV6MmN3bWd2Ynd5blUwV2JoSVI4WW9PQWkrekROMlZHNmZSbVFwOEdQ?=
 =?utf-8?B?K2JTcGpLZTJrR2kya0J0VG1URmg2Vmpjc0hjYmRYSU9Wd0w1V05xMDRGNHRZ?=
 =?utf-8?B?NTBJMnlkKzNVNzdQemRvdkdGa3NqdTEvWHFMdXRLME15aFdRNDg3ZHVjeVV6?=
 =?utf-8?B?NzhERldTRGtpaWszRmFDTUFBOFBaN29Ja3FwUlRielo5T0dVTVdaUzNPR2lJ?=
 =?utf-8?B?dlplay9kZU9PbWlNNlR1a1MxZ3cyZWFIamVTZjJYMGhtZ2hzdmRpbUIweVNL?=
 =?utf-8?B?K3NJZEsrMXVMdXNjQ1E4T3MySWR6S1UyQ2pKSytQbjZJeDVFQ1dxMXBmb2Mr?=
 =?utf-8?B?QU5CNUF4WEJYSUJ4eDVWdXgvQktvaS9NczYrQzI0UUlmREkwTmlzU1VmT2hl?=
 =?utf-8?B?b25UWGZhYTVHMElYR1lwNmRWREQ3RDRLbENXSXRxSHNOL2lrYzRNSXcvSDNQ?=
 =?utf-8?B?eTE4MHcwUDJ4VDlOa1BVUHBOSS9lbnA4dTEvbnM1T3NRZGdBMkFsU0wxVS9u?=
 =?utf-8?B?ZEQ0VkV0VENXbmY1L00vT2RDT0Y0b3lodEhTV0IrSUJUVGVpQ04yeExOQm9j?=
 =?utf-8?B?UTZ1clFMQXFRNkNFQ0kxTE85QTVrY01iS2xDSU5XVE1yWEhicy9WRVl3aEpB?=
 =?utf-8?B?RzBya3c5S3R3ZTBLN0l2SkZpN2hWTkhic0RMa2p4ZjhGY3h6aHc4ejhrZlBP?=
 =?utf-8?B?dm5ubGUxNXJuL2pJYVEwVEtwaWVBQWZyUS85c1VLNjZUcklDRW9iYUpTV3Iz?=
 =?utf-8?B?VlZWbHFXVWdZdWFGYXpUMktTMzYvcnpQNklVVjU1U0trdHFNUVpuU2xOTjM2?=
 =?utf-8?B?dUZwUTNndXZnRHNrWFkxeE1iOWRENFZUbUxmc3pkZ1hSV240UnhPMUFRMnpN?=
 =?utf-8?B?dFF4Yng2ZXlWcjdKYW82U05BVEVqSWtqMG1hSEFXRDdjYm1iMFF0S2dxZ0Z3?=
 =?utf-8?B?TUZkNVZTK1FQSUFHMnBQK0pNTDM3SVJIL1c4RnZ1MmhPb1J0RXI3eGZlbS9n?=
 =?utf-8?B?dEZvV1J5NVpEZW40V0hNVURObUhFQkwvc3U2dWpQUUN4Nm9mSnMzZHZrQVVm?=
 =?utf-8?B?a0srRGhJcUtwWThEaUtLVzNpTzk3UFdxSGJMRjZPa3dINWdqa0lWOFdCVDVI?=
 =?utf-8?B?ZWZTcUdUZ3ZhT0NoZU9mNG5CV2VFK081ak9EMUsrdlJpVmg2cEk1MWlLZE1w?=
 =?utf-8?B?ZHdST0JLbkVPVzM5b0xlSVYxdW1JcGY5TkY2dHhvSVdQWkd5UlljVGVtSHBP?=
 =?utf-8?B?aFJRZmx1RWorTW1pbHMrUGdSVWd2RWd2S2J0TUhKUTY0alhOblhHSm12eGQ3?=
 =?utf-8?B?UjFmNkduMmZXUUtnS3FOdGxmV2dPMjVzelJGdlZmODZRRGpnMjJiZlpab21z?=
 =?utf-8?B?MEl0NVBYeHBUb1k5UFVxdmF5QUQ4Z2J0dFFJOENUdjMwNG1ZRVFDbG5yUTcx?=
 =?utf-8?B?Z0hsbk15WmxhdjVKbGE5RUFTNkQ4d29mL3ovRHkyWVI1NWkvc0ZiL09GanZk?=
 =?utf-8?B?UDlCeGZtbUprSkVDQjlSVGJOTXJhU3VXdzR5czVBOHFOMUFVWi85U2ZzUDFm?=
 =?utf-8?B?L1Q0RjVSd1lDQU05THNqSHJLQ2RNRko3cE5RS1EzQW5QeVRWWmx6TTBFZEY0?=
 =?utf-8?B?YjVVYi9Eb0hJUHRIM2czdFoxbE9WbVlrUVlBWHdMbVlLaWtidW96ZEMzU21D?=
 =?utf-8?B?VXNMNlVaRUdWZUhyTDBLdStWT2t5TEJLTEd6a2lRdCs4Ky85Rlo0U08vcm1J?=
 =?utf-8?B?dytiMnlpcjhvdU50VE1FWXdwNklLclJRWURkSXA2SDRrTUdZMkFoS0cxWHZQ?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaad1300-a9fd-4ebd-0812-08dd55b7b803
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:16:11.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYlA2l105vCESxBRNKNyIcw/SXVi4HTSIHvPN7VAd9z2ey99C1bN44vsFi/O2EOYbvP2+KOcMhCtx7VN/afABMp/dpxvInQPysTRyA5OTY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com

Hi James,

On 2/19/25 10:10 PM, Reinette Chatre wrote:
> Hi James,
> 
> On 2/7/25 10:18 AM, James Morse wrote:
>> To support more than one architecture resctrl needs to move from arch/x86
>> to live under fs. Moving all the code breaks any series on the mailing
>> list, so needs scheduling carefully.
>>
>> Maintaining the patch that moves all this code has proved labour intensive.
>> It's also near-impossible to review that no inadvertent changes have
>> crept in.
>>
>> To solve these problems, temporarily add a hacky python program that
>> lists all the functions that should move, and those that should stay.
>>
>> No attempt to parse C code is made, this thing tries to name 'blocks'
>> based on hueristics about the kernel coding style. It's fragile, but
> 
> (heuristics)
> 
>> good enough for its single use here.
>>
>> This only exists to show I have nothing up my sleeve.
>> I don't suggested this gets merged.
>>
>> The patch this script generaets has the following corner cases:
> (generates)
> 
>> * The original files are regenerated, which will add newlines that are
>>   not present in the original file.
>> * An trace-point header file the only contains boiler-plate is created
>>   in the arch and filesystem code. The parser doesn't know how to remove
>>   the includes for these - but its easy to 'keep' the file contents on
>>   the correct side. A follow-up patch will remove these files and their
>>   includes.
> 
> Related to the tracepoints I also noticed that there are some leftover
> tracing defines in files that no longer make use of tracing.
> For example, arch/x86/kernel/cpu/resctrl/monitor.c contains:
> #define CREATE_TRACE_POINTS
> #include monitor_trace.h
> 
> and fs/resctrl/pseudo_lock.c contains:
> #define CREATE_TRACE_POINTS
> #include "pseudo_lock_trace.h"
> 
> I assumed this will also be removed in this follow-up patch?
> 
>> * asm/cpu_device_id.h and a relative path for 'X86_CONFIG()' are kept
>>   in the filesystem code to ensure x86 builds. A follow-up patch will
>>   remove these.
>> * This script doesn't know how to move the documentation, and update the
>>   links in comments. A follow-up patch does this.
> 
> One unexpected thing I noticed is that fs/resctr/internal.h contains:
> #ifndef _ASM_X86_RESCTRL_INTERNAL_H
> #define _ASM_X86_RESCTRL_INTERNAL_H
> ...
> #endif /* _ASM_X86_RESCTRL_INTERNAL_H */

It looks like another item for this list of "corner cases" is that the
#include of all files need to be reviewed after the code move. There are
functions depending on a particular #include that are moved out of the .c
file but the (no longer needed) #include remains.

Reinette

