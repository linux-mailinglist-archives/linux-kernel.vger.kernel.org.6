Return-Path: <linux-kernel+bounces-173426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F598C0046
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D44A1C21218
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647E8626F;
	Wed,  8 May 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdDFUn64"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7884A23
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179291; cv=fail; b=Ik8wuzk4fqLxgPnJyZuqwJ95pMZJGsWwomvK+TswLu4lWClyWFC9IYEYApFINsEBAR2O9spcMwJPfY0vNellQ22ihULFfHbKWS3pVPp1XaZgscwjjA8IEuCSWApVWKE0Ne5DbttldHiH/upor5wTyHBQyBaX0X5NlvI9On5mQ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179291; c=relaxed/simple;
	bh=0FxiJiXzObCvrjXl9ktmI61z4SEK0UN1Gc7Oonj2GYM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VFf2PAvynbe098A3aXQcxYkONu4jdjK/ecxO9/EMphL0brJAWQFr+kStVPxLOhoDspYIl6bZwFhutAOUp45l+VApRPzDDC3xuND4BKCvOrp9+Oj84zs8vDWqFghAZdS2uwVXkccZhUCht7bhxGWQTtPTqJzDo7pCZAxMunUK9Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdDFUn64; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715179290; x=1746715290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0FxiJiXzObCvrjXl9ktmI61z4SEK0UN1Gc7Oonj2GYM=;
  b=HdDFUn645tvg9ZbMUgVeYRRwtOJaiAq9XUJXdRqepZ8/25QiqlXG2XbR
   cygPCdx1Ie2LHeosTW0LH2aNwfB/JO+3ov/zY8+LyHAEzz7K/lkQSV4FP
   /0kEtTRW0KXchz7Z/yo1nV8EGjuuXuDlpxA0apN3rDxaToupCewHQefuX
   muJIdtylOLlUxzc3FUBm+a22drXXaF81KuvBSCgkbxnnCCnQRLnk3dZ6a
   bHVNg1DAbP6O2KG/95oqiyr0XT4RLU7FRJwi1DbX27wI3uQHQNm819sg6
   kRA4V7hNVglJLlD4JbGu3M8o3vk6OZL/+a34XXVWRSaoHBaI7mzIkInav
   w==;
X-CSE-ConnectionGUID: ojfvEJNSTl+BlarftdZDmg==
X-CSE-MsgGUID: l4sHYhV1Qk2tmuMohKbFhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11199921"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11199921"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:41:29 -0700
X-CSE-ConnectionGUID: BsHziCUjSbmEoDvqBLwYFQ==
X-CSE-MsgGUID: lZGFHPH6Q0CDHAIhoWdWCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="52120789"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 07:41:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:41:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 07:41:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 07:41:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoRH7mp4T48fo1F8gype9xxqcMBAQujAvRfrWuysfARQZxciu9dcpDUOf96cPAcOQhT31JC76U49fnFfP3xxaincSad2ojwSze3QvhUDK3SLRcoAS9M/ytp2mtTg4cqCn3j88plNwTpFm/4TFr0gpMW9wPHV72s7wV+easAq3ussyjx3VcT06yWJ5dQSM227+FoFQY1U3x48zl0TkC4yw+DieofwmqHOek8VxT2mA/ueRpVED8TUgSPJbhZMS20q9ajqTeV35I7BqUY76IQmiWhOEMctCB0v8Vmp+POKmh/Ehb+spDvJ06GPLohssLnvu/jySAqchEA+VEUTgj1L+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD7of/VBhPCRQDMr2adIqxqjXyC7GqAffWt9JM/Bbsw=;
 b=k6TWapJNl3qYwMN8L7sPtXb1P0ioh5RGr9AswvUbThj3iHw0qgzJnzpWUXeXC4chC6V3mFK84c1w5rNe66blBuZyKuYTHK+EpAHujPYYAPKQ4Ge688CtFC/6EsBc1Jw+8YPIogV1Xm/vS2su8XGXG/5IMd9R4n1xATEEazGCRcmHPkXn3ATg1Z5l61sFzz8ukMCfuv5CNtyLQJ/D9og9ljN2tRdwpxHGFmBM2Y/69NtuBwwiVIlMPm3nAb5SMNgy3kSmmOOBuGNTL07tzVnCezi8ddBcKruD+V38W1GG8eH0dmnIz73Lwe1PElbgacDOsuKPgSf39qzvCQVkRyu9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 14:41:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 14:41:26 +0000
Message-ID: <821d3abe-c15d-4118-9dcd-f4c1b71fddb8@intel.com>
Date: Wed, 8 May 2024 16:41:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] dimlib: Use *-y instead of *-objs in Makefile
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, Tal Gilboa <talgi@nvidia.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>
References: <20240508143039.1196671-1-andriy.shevchenko@linux.intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240508143039.1196671-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: e318c87e-55bd-4b56-87c4-08dc6f6cf085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1BKZGowLytFVllMUHJUMlE3Q05ySEJoZnZQZHloTm9qSEZiNVRPWGI1MHU5?=
 =?utf-8?B?anJDaGZ3REwvcnBCNnU4ME1JR25VZFQyT1F2MVJ1UnRHZkRLb0d0cVdYKzVj?=
 =?utf-8?B?Z2VhQkVMM2RzNDc3aVJhS3k3bTNwbk9BMUZ2dnlsUFhCMmx1WWt1OXEzcERx?=
 =?utf-8?B?YW42VnZWR25scnI1dHRGcXVMbmVTam16ZkQ3TGp3enJIUWxIa0ptaUMydENJ?=
 =?utf-8?B?eEIwS1BHSWNQbHNWNkM1VmdDSFI3T013RW1vdXZsMm1YOVUva2ZmOXJVTk1o?=
 =?utf-8?B?QnBmNUxyMy9JN29OU29paDFBdFZQa3Via3FYMTNmN0U0eDJyZzZUb0xXRHVH?=
 =?utf-8?B?M0VSV3J1dG5DWnEyTGtqMGQ0d2x5QTNrME1mNHovZ3ZheUNlRE52SmIxeWVS?=
 =?utf-8?B?b3dKKzdPZVVQWmladTVoVHdHMHowSzdnVDlmbVlEL1RVVGJ0OEs1UWREODcz?=
 =?utf-8?B?YjFwaEZNejMzT0hTL1pBQm54RTE3dU1rRThMLzhBKzN5Nml0dFUwTzRhdFdq?=
 =?utf-8?B?NHZOazIzdzU5WUhIS0ZGSXNjeHB2cGRHcG9xcVhoTHYwazc0T0I4YjFFRk5P?=
 =?utf-8?B?ejRoc1BoSC84b29tdlhNaXhzUm1nbEFBTnVUaUxXVjZQZVBoRkRJWXhaUWZM?=
 =?utf-8?B?eStDMlNEREs4L0NUcGpZb29KRGJvSEhZdUtiVVM5OGJIUWRYbkJDZTI2VnhN?=
 =?utf-8?B?ZTV1TDhDSzRQYkloTkFZWG81NThkeU8yMTZqMHhsMGlpN2lZY0srVEQ2Wk9m?=
 =?utf-8?B?S2gxN1VzVkNobzlaMGhkc1FpbE5nTVpSZFlKSnpFRnhvSFNET0h3YWpsckV6?=
 =?utf-8?B?OVFVSlJyenVTL2xtZzFYQmpiQTBCNXRXN0RVVTAyVFYrOFhPQ084T3FNZFNn?=
 =?utf-8?B?L2JmdVlXQXQ1MjZwaTVsRjBXYlU2c3Z3Z0J1V3Q5SldNM3BzYlU2aU02eXh3?=
 =?utf-8?B?ZFRYYTBpaG14TzFuR2FjL2FRY1FxenBQcC9vcUwzRVlhRERPWTZHWmpYM3dT?=
 =?utf-8?B?NktobDlTVEd1RE9LL0RUNTBpQ2JPYVNoUXRtMUxjektmelFBL2RxRlJ1TTN6?=
 =?utf-8?B?cmxzQzRQRFdKcjJ0cTNUTlh5KzliM0NxbXpTYllDSC9rU0R4ckVoa0Nzc21t?=
 =?utf-8?B?Rmdoanl6TVNKOHUzU3hvcVlXbE45QXc5RmR6SllNS1IvR0tOamZrZFpFVjVF?=
 =?utf-8?B?c1orRGMvcjh0SzlOaVRVdnNKZEh1U0ZtSlRDWDFEc2RocXVvNDJONkhiR0c0?=
 =?utf-8?B?MDhVZDRzU1lWYktBZmFQQXFqSDY0VVZnWEI4ajZIbDZhQUo3aEJNYzJSaHVn?=
 =?utf-8?B?azU5L1R2dlA1LzJaYWEvcVAvMTV3QmZPYy9pU094a1NOVnNrSFA2NUR5ekdr?=
 =?utf-8?B?WUJVRFhpdWhCYnBnaGtjZmRRK2I4WURTTk5DcW40WVRsTm9KSGlHSzVLT0FX?=
 =?utf-8?B?bjlHRUY3czMvOG44K05YRW9ZU0JwbXJXcFFiZm1RUzJ4SlZubXVFYi95Zkha?=
 =?utf-8?B?cytDV3hjbnZOWUJQeUdXSkc2Q0lkbGdycTc0aGFRZUYwTmdteW5vVU5CR2hR?=
 =?utf-8?B?VXp5LzllbnJUeFN5MC85d1VFR0VvTmhrTnhFbko5US8rMWhLRmtlY240UDlE?=
 =?utf-8?B?UVFEY3pYLzNRNmJxK1ZPY25CaWdjY25FTXE3bXVRTTh4anFPbnpRNFJEb0tN?=
 =?utf-8?B?MDBheFllOEhNaHIxMHRnUExSaW9aM2tmSTNic1Qwb2dZbTBSOVN0OWV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZPT1paQW00Z25xSnNNNHExcUUwT0U4QVhJNXFpSXQyTE9pNzNWVGRUeDA4?=
 =?utf-8?B?ZUVqc0tpR1BNS25EdkN5a1ByeEoxNWw5SCsrR01kSG5pcUJrbGs0eUtidDNB?=
 =?utf-8?B?Ykw1eGpHM1BLTFhaamFScndrZ0tGTXZjalJucE5TZHM3RlJyMHRTYm5XZkpE?=
 =?utf-8?B?dnFpWDA1RHdnRm5tcmw3OXg3WjRYOWZsZDdQQkZKeFFId01rRWFwbFMwV1gz?=
 =?utf-8?B?QXE5K295T3VWdFF6M08rWndlN0p2SWJ3WmlqRkFaV0I0K0VkM29kL3A4MzJ1?=
 =?utf-8?B?V0NvMTR1aHpsL2g2NkpjNC9keHNITm4yZ3RuN3huYnJVOTJYRnZqckZIdFhq?=
 =?utf-8?B?MXVoTnpCUXNHZzdzZHFWaDVNRS9UdTd1NTRBRmN4OU9JclY0YW50b1M5VFE1?=
 =?utf-8?B?SmdhVVFsMExZclZsNGl4NDZsV3l0ampQSlVDbTdZeDl6OHJYTGxuUm54Vk5B?=
 =?utf-8?B?WUhpTEhOZERJc3VpOVhqMGtLdHRZcGxkTUdEOTJQYWdZK1IyWVY5b2xodCtY?=
 =?utf-8?B?emJmK0NSZ2JMUmVpNEdrMjZ0U0RkMklTaDZ6UGh1SGF3SDQrakVra2gxM2NJ?=
 =?utf-8?B?V211K0xNMEpCSklaeHJId2YxVGlxWFFpL3pSbG5GRUlmN2E4OUEySTA0OXBC?=
 =?utf-8?B?YXF2VlJQSHl6NVNwb2R1YjQyajNRa25zYVIwY1NYS3BwdkdBNEFlb1pUdTBK?=
 =?utf-8?B?KzlTTURYNVNlV0RNbFVkNDJBTSt2UWNCQmYxTkdXZ2JwbjROWjhBcFJObGNV?=
 =?utf-8?B?QjZPZkRVSG1idk9iMkRHRVlMZmlwbGlyQkFKOW5OK2xiMzF6RDIxV1RKMlFV?=
 =?utf-8?B?bVRzYVZ3SjdqSnZVbEFnKzQxZElpQUNPYUFzWG5VWktpYUNHUWtuOU9LS2Zr?=
 =?utf-8?B?QzAwYkREOVZkZm91eGM0MStERURiVUdjUmVHd0F3eGdDNHYzcFhhSlZWUFNF?=
 =?utf-8?B?ODVsdGQvNUJNdHhPMmowaEV3ZzZCd3lOVk9hc2drM1RMWDQzZmwvZnQ3MlNz?=
 =?utf-8?B?Si81TnVZQVZIK2dFbzhXVWdmTGhTVU5lcTJqc0lhdnVvb1EwOUV5M1NubFY3?=
 =?utf-8?B?UWlkQXFrVFhVbC9KeFdRQ2dhcnE0TVEybGRkY0RHamZNN08zZWh3am8xVStI?=
 =?utf-8?B?dmFockhrSCtZWWJ6WitDYXVwcHBERDBndjJFdmUxODJGdEhieXJNNXpaLzVn?=
 =?utf-8?B?N3RpcEEwVDBaUXplZmRoek5Oa0phR1lqeXYvU3lEOStvek4zdUxqS2FxL0pp?=
 =?utf-8?B?NkJjVTdBNFVMTmVYUXRaR0NuRXEzSGFEOFFMelBwQTFZT3luYnkzelJ2UVIv?=
 =?utf-8?B?UExnTUNQSVZVZFlTcnF1WnV3dSttbllPcDYrSlF2SU5ueGFqSG9HelJEMFFm?=
 =?utf-8?B?MGlNdEtwRjlrWDlwV2M1QURDcyt5a1BaRjU2bG5QbzR1NVVDQmEyT0FRVnJC?=
 =?utf-8?B?L3FqeWc5blZQRmxwcGZnOCtwT244aHNaaDhYVE90TGFBc3VnT204cGZpY08x?=
 =?utf-8?B?aFBVOHZEQTBlUVlrUXpoNk5hQjZ0WkZEWU9uYzFhbkd6Rzg5QVBhRUJ5N2tW?=
 =?utf-8?B?SXpEa2ovMldxc2JFOVVnRitLMUpBbHA5LzFCVUdkTE9Bd20yM21mMG9GdUhy?=
 =?utf-8?B?NGljL1oxbFJ4UE1PMENjVlNhRmhvTmFZTnlIUzFnYTVhOFZ6dmZ2RTFhWHYw?=
 =?utf-8?B?ZTlWd1pRY08xRFE0YlhWN0hJRmt2N2tjU1U4UFJNcVlzaG42cC9BbmNhcEw3?=
 =?utf-8?B?MitMc2N4S2lqMm1rRVVlem1HMkliYVVXaHJLN0hOMzRMcEcrTnoramU2UnVC?=
 =?utf-8?B?WTk4OUFTbjYxRjFITnNNejJmK2FEY3FWcGxnY1I3MjZLN1ZEejBWdXRNUUY4?=
 =?utf-8?B?K3ZxQTN0K3ozUVRpMzBnS2RSU3pLMDc5NkdXcVN0ZytwZDdZSjZVSkc0QlVF?=
 =?utf-8?B?S1Fnc3hQT24xTUdQTUlyVDJYdXc1VTBLOFhIbGN5VFJ1MittSHVRRS9xZTgx?=
 =?utf-8?B?QjlOendIZ0NUV095RWhjR1JQZnF1VDZqUCtzMEsvZzU2SmVyYXp5ak94VUF3?=
 =?utf-8?B?dWdBbzJKVUV5NVREeWlJamNiMlFFbEpDbTd5d0NrWTRYQUE1Zk80Qm82SjZH?=
 =?utf-8?B?dDlzNnVLa25DRmN2STNrTCt4VEpBdDRqTndMTm5SZmw3aGh3T25GR1krWVVV?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e318c87e-55bd-4b56-87c4-08dc6f6cf085
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:41:26.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKy2ZwKNl9OO308GaKbUWMWLCPgHBAL6JHSxNNIpi0vE1ilj96Z71ptwNgFH7N+T7fEkcuo3b3wPeXXmCuULtrz/oGJEa+tsvlwj+xbs6uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 8 May 2024 17:29:42 +0300

> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> 
> Reported by Olek. As I said him this is correct change which is
> documented in Documentation/kbuild/makefiles.rst "Composite Host
> Programs" (mind the meaning of the word "host"!). 
> 
>  lib/dim/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dim/Makefile b/lib/dim/Makefile
> index c4cc4026c451..5b9bfaac7ac1 100644
> --- a/lib/dim/Makefile
> +++ b/lib/dim/Makefile
> @@ -4,4 +4,4 @@
>  
>  obj-$(CONFIG_DIMLIB) += dimlib.o
>  
> -dimlib-objs := dim.o net_dim.o rdma_dim.o
> +dimlib-y := dim.o net_dim.o rdma_dim.o

Thanks,
Olek

