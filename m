Return-Path: <linux-kernel+bounces-328868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4259978A26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A404B241C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EE14B97E;
	Fri, 13 Sep 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLF3lQCN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FC12C470;
	Fri, 13 Sep 2024 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260296; cv=fail; b=BjXzU2s+8FUV2/Xz4SGxTMjkwjtyGNHdE248BUdchh3ZlbY7Laao64uZgp/yUKcPONB6Ykv4OG9szYiSNfJr8R/OKs8sXjUGEiXlKgexVQp72umurtysCwYZQNBsItYXePBE7QKD3K4Iy2G+tSyM3Mq9eCBDDf+BKP/Nr8s+vsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260296; c=relaxed/simple;
	bh=oYO5qoqqAPc1dkoWLVXNFCQmA77lDQLl9PRU2yRf5e0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cIVUQdQHt0Fmbr8ny23U4z05nk6CGi45iQ5L76k5uYWoZKhm53MU0QK9V2QpnfWstz1+AwwjPJ+p7qAz6g1zBq4cXHDjJoZ83c1ICCOMRiBCJ+jAvMnfXO1zhozAfkFVX+mZ+g/WbvAb6TBj7vVJiml/5+Z8ND5cIZOIOhGh6nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLF3lQCN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726260295; x=1757796295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oYO5qoqqAPc1dkoWLVXNFCQmA77lDQLl9PRU2yRf5e0=;
  b=ZLF3lQCNX36a4gOE2pP/hGpT3glLeb5isZ5bon0WZ7PEoLaoPgtuJCZG
   luhw+5ybtMXv805n1ME3skvtXylSEs5KWRhfAajrPQRmdGCfh9smRfO9W
   fqQ0XnrTzY2Qeii0ERkYfev6gdKToaRbV/7ut3BOpYPUsqQoTgHZH9J7k
   xTvo+Q/dM+C1SN5Qk4CY5f24NSefzvAva3cQUKYEPi/YVzGNJOsaUhnwB
   /24c/O5M/cnFTPFzwWQGs7ssXg3vn9UWj5YrH2nqdKMd69En3w/JfDwCg
   wvu0N5fNVmNmmsXsv9S1+qYvHEPNAvtYDoTafR/3JguoD8Dc0BIIlUD7m
   g==;
X-CSE-ConnectionGUID: qQ8t6CiqSnKeU7Ly+2BhWg==
X-CSE-MsgGUID: uEZ/yJj5RiWS6DcHzv5ZZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42685214"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="42685214"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:44:54 -0700
X-CSE-ConnectionGUID: Zdpvu5aKQl2MGP6ut9GX+g==
X-CSE-MsgGUID: Xzl3QnacSrmpIUKd1fudUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="73005311"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 13:44:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:44:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:44:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 13:44:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 13:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xumqDSEePI8BMZV8FKn69zhg9MsLxgIUOZXx8GqLWgJhh1SFNGkHyl2kcCldWdvXUjuGEKJmywTgDranNsDScF+Fb0U/7bmxNE6RRbgOSd2jaOaORqezI4PT9n3AkJs9MhVhPXZtrKhFNWuxO48mt7NxY8uq3Evh33SI2qQwUP2Im/hB9IQ7EYMtEW3DejV0UFXgR4otyh+rFMb4syM1/qjzKkQ1pJx4ueAVe8ZIdv16AtjtIDv5rJ5olx2dlfegO0y3JvLgzh2dL60APYhBFOJu03jkhv769CJYXAb3Rp7A7pS+2jOTiZPMQl+6m5Rb3XK3w69Zqu5VxzzsAxx/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ3YaHj6H6OxPsjWJgQ0g2bNL+LWrw0+vJtR9BDLEJM=;
 b=OzxGyHQBMqJUtuFYAOPfjC/SpkiFp3vmfd9Qovhh1ZCanBDFNd+n748d9Ddv+S2H7w+bLEyATIzV8V1pcR3JXpv3CryQqoLu8PXrLazBts6OKwgcdrPn8d3L6KTkwgz/Jk4L1tR8hLNQEFZ7UPMkVgyWEXlWHf0l2XwchFbUXGjZAgbkSVXqwVemeAClMypJob8357/XPSfWgLBhGZ99fPOirRk51sSwRJ1UwEPiDejWm4A2WKOnEJ7I1jl7k22Z4MCg6uWWsrhVZwHlhMZq/ldMXkO0jl/muteIzrfy1VnCKd9OBe9NZDHSTmgj7B6QTVDIQmJpzelv+kAMwXd8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 20:44:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 20:44:48 +0000
Message-ID: <d2083424-409a-4b41-8996-d8ff9f51db2c@intel.com>
Date: Fri, 13 Sep 2024 13:44:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] x86/cpufeatures: Add support for L3 Smart Data Cache
 Injection Allocation Enforcement
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
 <8378af17a73455661845830b40864ec1cbc303ff.1723824984.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8378af17a73455661845830b40864ec1cbc303ff.1723824984.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c530053-7b74-4195-ad1c-08dcd434e876
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHhIaWR2VERsSGlaMUdiMGFKRC83NnNzT1poa0F0ZU1rRFJHdHpVYXFvT0d2?=
 =?utf-8?B?TG9kLzU1RnZWd05lakppdXR3TmowVzFxMFFuRWhlMmhDN2lrby81eGVYSG5J?=
 =?utf-8?B?RFVjcmhyaDFTMDhwWmFDekdxcEVPaTB6U3pyYm1FZzBjOHpJalc4RlNsY2E1?=
 =?utf-8?B?T3Q2azBmQXFrWEJFRmZ1QzdPUU8vWHNGZ1dmazRvWHdqZ0xqVktWMzBIL0gv?=
 =?utf-8?B?UXZUZEZ0OWxEOFBMTVdISkR4WDZKN01ad0ZqM0VFMG9sQ0JSSzE3aXBYN0NL?=
 =?utf-8?B?N0kzbkt2cjJqM2Z5dVdySTFFbnZ5MGg4d2FHaGF5MDdsS3RlWTRoYithMUNQ?=
 =?utf-8?B?Z280R2doUW1kVXZDUGU0RndIVHAyS0FvRXg0bWlzSW5IaUJkLytyd2RwWG5k?=
 =?utf-8?B?UGpjYk5JMngyMkJWSnNqTlZzNzJObzhMdTRuU2MxbFRkczMxaXFnWVRCZkx5?=
 =?utf-8?B?bmQvKzBtY3N2SGhpcFFjQ1JhRnR6RElNd2hUUTZIcjJVTEdBYW14N1pLbERN?=
 =?utf-8?B?bzgvRHRUUUlENE9UcFo1YWpzZWs4bW9XeXZxZ0VOTjNMN01mOFh4anQ0ZnNJ?=
 =?utf-8?B?UXlTdUk5VDJPRXZXS0gyUGZBb09RdUY3WVhCK0FLaGx1S29pWDBuT1FKU2FL?=
 =?utf-8?B?a3JZZUthT0tTK1h4WVRZdmh6ZFVwNG5SZnF6R2RaQXlLUXJtNm0rNDBUV2JM?=
 =?utf-8?B?VHVpU01PU3dvbWRqRlNzNmRWbHRCK3RHRkxJUVFqTGNoMUVudVgvWjVieG1u?=
 =?utf-8?B?bUFvRVcvN3ZpSVlmcnlkdTZTYWZqQmx0OGRUd2UrVkVtblo4SU5DTGRwcFlm?=
 =?utf-8?B?eTVaRUZaYWhmdVNNMHFzbmp4OFBvYUZNMktjWXlneWZWQm5YWjNNYUxZeXcy?=
 =?utf-8?B?YUprWkhqeXNNckpLbUN0b0tzWTRqaVl1enFGcWRadldXYmQvcmYzUFcyUGdV?=
 =?utf-8?B?KzhwZjVVZnFjQ1pWajcxQTRhR0h0VFpjNHg5SGV6YmpxVmhXbFZNK1F5ZjdJ?=
 =?utf-8?B?RDdxM2tKbHVPek9CZW50T2h4ZElCbjF3WDJWSnNGZWxSL2c2cURsWkozck5J?=
 =?utf-8?B?Ujg5Ym1mbVhOUVZjVXk4Nm5aa09aUWp2Z1VnQ0dBdGZ2ZDJ3RHZSRjFvY0F6?=
 =?utf-8?B?RHc1ZmtMbzVNY1prcldhWmU2QzVjcUpld3FmUVhYNGNHclFGaFZqTWN2elg0?=
 =?utf-8?B?SWo4b1huVDJGeVFtQUpnV2I2Zk9oQ1VuT0xFUVlUNXBrZ2thaWtORnlXYnJB?=
 =?utf-8?B?d2ZCT2VzVjRkZXc4NGgyREtwRUcyNE1UNnlzUU1RampGaDczWSt5ZzdKMzEv?=
 =?utf-8?B?Zi9VTlFjWlJiY041WjFZSkxxVG1LQytabm5vejdQWXNaNE50cW5pV2c5RUc5?=
 =?utf-8?B?V2xQWml1WU54ZEkrVUR4bGJRa2F2QVlIbEEwaGYwbmMxUUhNVHJucFU2enc1?=
 =?utf-8?B?K3Uyc2ZtMCtmcHNySWMvNWREMWNCYmZVUlpJUHRVY0dFUkV5dXh5UWZEUk1D?=
 =?utf-8?B?NnJLS3ZaSXhTazdPWmtYNlIxbXdrT1B2SVRCN3hSU1NFNmxVN05jWnZEWUo4?=
 =?utf-8?B?WEl0MDN0KzRkaEs4anNUMG92SWZjUENxemlVZ3IzQStYREpmYkpZZDRXdmhN?=
 =?utf-8?B?bEpkNlltaUlleVNZalYyems0NnRaYkh6NFdKd0syRytXenNBSm4xOHBzamJk?=
 =?utf-8?B?NGZNYXZmWWlQZGxVcitIQlV0VWRReXBiaVllbHZwRTh5SU5sdE0vb1dnYTV6?=
 =?utf-8?B?NGJ3RUFlMWVCbjUwbTFmZXVIeWl6V3oweXYxWitkdmxZZkhYT2FYRDJJWFNW?=
 =?utf-8?B?TExIS2hrZ3YzOEpXdE9MQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzd0dVJZLzB5VnF3ZGkyNkNtbW1YV2tkZk5OQVl3VTZqU0FBVUl5ZEVVOHJF?=
 =?utf-8?B?ZVpXTUQwMHo4ZHFRYndOalluRy9DQjdiajBjblpjSlRWOXd6c0djVml0WC9H?=
 =?utf-8?B?WHBJWGVmU0ZZbWVhU0gxVjg3UHd3dDJtSytiMnQ3TDB5enZ5TEY5ZmZXWWdT?=
 =?utf-8?B?Z0Flc2ZWYmhsWnVXZmEyODgrV0l4WXFOdjNLYjJWODExWDFZVjVTV1F5TVR5?=
 =?utf-8?B?ZnIrTkdmenQrZHl1WlQ3VjRSQVFKK0xMTUxhTlZiQlRqaUhZczg5OGtwMUZU?=
 =?utf-8?B?eCtsRjI1OFVCNTRvK0hOTzV0VS9McXhpRlZDWEFuczd0WEkvZlE3NzZBVkxY?=
 =?utf-8?B?eEFVT051YnBhQXoxVFVNMWhLVEZvTVdGUEJXNmgrZE5XbzRFRm5aVTY3dlhZ?=
 =?utf-8?B?SytES3IwczhWMHQ2d21CSFpZZFZNemFtalVkUWxNamdoWjNOZDB5ODk2NXJp?=
 =?utf-8?B?cW92MUE1SXBHMkp3RzljNjJOY3dZdi96Ujl0ZUtSQUNlU0ZIUUszTjNTcHNs?=
 =?utf-8?B?aklUUk1Nb2Ezc01RZzU0WWNBUllsTmVIa2ZDUXdTOG80UGJhL0J5SjBvV1BO?=
 =?utf-8?B?YmY3dU0yZFpWNXVjR1RnUGtMWmFEb1FWa21zZEFmZ0c0OHEyQjhHOEtBKzVJ?=
 =?utf-8?B?dkdOWFZaYUdVWndtUkV4QURRcGVCblFvbkdTTGd3NWdkUitSeDV6TEN3UnI1?=
 =?utf-8?B?ZG5QZ0w3djFlZm9IT21uK01UUjVvWFdNa3ZrQW5WOGV1a2M2R0c0V0pxMWJr?=
 =?utf-8?B?Z1I0ZHY2YUVNeUJ2QmRLa0ovTVZzenQrdFlYQU4wNjhSVlMxa25NM3kwVzhh?=
 =?utf-8?B?OUUrVjlBeEVIb1UzVWpQTHhBRjN0Q2IzUTNpSVZhL3pZMXgzZU54VWNWRTU0?=
 =?utf-8?B?emFwN2RINTZndzN4M2ljMkdaaENINDl5bjdsQzJlZTZuWnBidHNFMFdVU05V?=
 =?utf-8?B?c3cyY0N4Zjd6VjA1M3BzZjhubHBXVndYdHByb3dRVlAwTXB2Rzhjc0tWKzhR?=
 =?utf-8?B?bjhhYzFRZkdqKzUzRWMwU0NZUTVpRklHOXBzVm9JL0c2dHRDb0V6dXRiN1Yw?=
 =?utf-8?B?STZiR3hicUlRSGFpTEh0ODBxU1dkUXd0WUZkcFZ5VFpxTGdSSGF3UnJxbGs0?=
 =?utf-8?B?aDZ5ZVNXNWpXZGg0d2hGVmtPaGJPNXFOZEN0endLLzZHNENSWnBBU1NoRzgv?=
 =?utf-8?B?Nkl6YjJLL2tmM2p6SGhjdDBwdjVTZk15N1lDSXRNdHVzci9rbkQyTWtMS0Ju?=
 =?utf-8?B?U0dNM3kyWDYzUnZaNEc0TDJkOEt1SXhRUnVGbjZscS9iS0VqLzI0c29vOGYx?=
 =?utf-8?B?RjdqMFRHOUJFbDhxditWNzMwMkgrdFZ6TS81RWlPMDFSREUxNXdSdFJ0V05H?=
 =?utf-8?B?WEtlZTM5S1N2MTVDOEN0RWVlOHdXMnp4Z1FDWGJxVFgvdElNb1h0ZUlMUE5N?=
 =?utf-8?B?dTc4RDVIN1QxRXIzMUJLY1ZKS3hIcTNuV1VGRGJYSVErVGVmaXg3VW5CcytS?=
 =?utf-8?B?RUVwN1BDU1lYcGdubDRBR2o3RkFmUGZHNzdCMXV0cEpCbVU0YTFhQU1zNWFM?=
 =?utf-8?B?OEdQNlNLUjcvdlhJbGgzdlBqYm5qMFVwZy9zNldWek56WGhWWEs4OWxOSGxn?=
 =?utf-8?B?bE9ibk44N2VyQ2pqMHYyVlltcTdCckw1VzJpWmdBNTRCeVdVWmlmUjUyZnFU?=
 =?utf-8?B?NmNFRUZzak8rS1hBb2hkN2pvTWtSbDBHZHFBZGFEMllMbUNRMmV4Q0J6QW5I?=
 =?utf-8?B?aGlORzYxNWQwWEQrMnRjK0w4RjVFd2lwNWE4eGlBaHJPcUFrQWpRdDExMlh3?=
 =?utf-8?B?SFhEaEdEaHRiWjIrVHlzYm9jTGFDaS8zZVJ2MW5tckJYSGRJMDNPSXBGa1F0?=
 =?utf-8?B?Rk1kbmUvZVU3Sm1HbGVqNjBUN1Fqc09Fb09kV05MMFlzS1MxbWdMSHhMYzRH?=
 =?utf-8?B?VFkzZnBwN2NOY014bnpqTTkzYzNFMHNadlNFR0NscjVSTm1BeUVzaUt5a2tr?=
 =?utf-8?B?dHVTaEFYdzc1eSswN3R0TnZTK3FrR2hmSnB1eGpveVdEc0dmaGkvc2tvSmcr?=
 =?utf-8?B?ZzB0bC9HT3NSSEY0clZucWJjb3V4V040ZUNDU1ZBbE0zc3NydDRMTUtENlBX?=
 =?utf-8?B?QXZTeXRwWWh0anZJa0ZHcytKcllHWDlZWlBzOXpnRU1qRDZnK2ZxSTg5b1Na?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c530053-7b74-4195-ad1c-08dcd434e876
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:44:48.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cBr2pJMlnPB1zaa7Ay2EHGiVHqJiLBMe5WZwQwPYiYPzDK9J8eQun+YkO/IMoMLj7LZyxvfp6oUPFGg5xabYF3yp00WZ46D/g7lwvmw+KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com

Hi Babu,

On 8/16/24 9:16 AM, Babu Moger wrote:
> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
> insertion of data from I/O devices into the L3 cache. By directly caching
> data from I/O devices rather than first storing the I/O data in DRAM,
> SDCI reduces demands on DRAM bandwidth and reduces latency to the processor
> consuming the I/O data.
> 
> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
> to limit the portion of the L3 cache used for SDCI.
> 
> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
> partitions identified by the highest-supported L3_MASK_n register where n
> maximum supported CLOSID.

"where n maximum supported CLOSID" -> "where n is the maximum supported CLOSID" ?

> 
> Add CPUID feature bit that can be used to configure SDCIAE.
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
>   arch/x86/kernel/cpu/scattered.c    | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dd4682857c12..5ca39431d423 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -473,6 +473,7 @@
>   #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
>   #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>   #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
> +#define X86_FEATURE_SDCIAE		(21*32 + 6) /* "" L3 Smart Data Cache Injection Allocation Enforcement */
>   
>   /*
>    * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index b7d9f530ae16..1ef42cc4cc75 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -70,6 +70,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>   	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
>   	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
>   	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
> +	{ X86_FEATURE_SDCIAE,			X86_FEATURE_RDT_A     },

The need for this dependency is not clear to me. If there was a dependency
then I would have expected it to be X86_FEATURE_CAT_L3 but we have not
previously needed to do this. For example, X86_FEATURE_CDP_L3 does not depend
on X86_FEATURE_CAT_L3 and in turn X86_FEATURE_CAT_L3 does not depend on
X86_FEATURE_RDT_A. Could you please elaborate why this is needed?

>   	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
>   	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
>   	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index c84c30188fdf..88f00575c9ff 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>   	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
>   	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
>   	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
> +	{ X86_FEATURE_SDCIAE,		CPUID_EBX,  6, 0x80000020, 0 },
>   	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>   	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>   	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },

Reinette


