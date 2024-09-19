Return-Path: <linux-kernel+bounces-333726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2874197CCF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E53285098
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3C1A08DC;
	Thu, 19 Sep 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThOYGKnb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAF1EB56;
	Thu, 19 Sep 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766418; cv=fail; b=BlDnfLRQpM/dVXnEbvQDDASwJijfHq7FGB0NAs9fudp7hdULUcGDCiqwop0yJXhpLofQHvexXedQCw6H1oz0dljlz3BUuowquwyuhPSZaIiFbc9AC7JDNBqgcCf6liaRuwALyesCrUF2ee+/Ezooo0wGr3EmucrUtmSWB5igAt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766418; c=relaxed/simple;
	bh=MBW4rIUXNe0fsvxY44pZzNqm+wyLrqdLPtPR+peznN4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YbdOywpw4sDSeR4S0cvMuWUsYvF0JY6qt7d+H7Cptg720uoa5pIpSYz8H2nHdZB/cKdPdJ2qZDoXSNwikhHkCsS2vsuyi7otUXGYgJ9g73INcxOu/O1vHvFWSVZfwpv5b7k4iHSpxlwvzA7GBH4NIoElHZw0LrdoDOxD9llJm84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThOYGKnb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726766416; x=1758302416;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MBW4rIUXNe0fsvxY44pZzNqm+wyLrqdLPtPR+peznN4=;
  b=ThOYGKnbKE5cIbwfvUm+rZA124iRzTn2E0G0u3agrh5HZC2K203jz3cE
   g9XM8soBtmY9yFZYDajcCd68OSDuunxBtzyydwtDyxhyVhuG5kZzH88af
   zLqL4WkYyEl5kssS2di4JcqLmRyP4ctNxc1jKuBkIL9A9CULWHr8QJjnt
   rPxWglDa4zZPgb41S8U+8Gmo7fpE4dX6Gw2r8+Gfqd+7h853KFoneHTsK
   u8SGU3h9nqiJym1b75luWXkKjYlPtzaY+ZputotHzmnLA6MuiKCiw3u2s
   lXh+WAIF3Vtyv4nJXNsV4jybPvx9tmpXJCNVFo/PLP+Ex9RsHiEgPgFY+
   Q==;
X-CSE-ConnectionGUID: iaCDJQPQTgyMwh6zJ9DMbw==
X-CSE-MsgGUID: EDxU7oxlQze5U+yygSr7ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29489185"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="29489185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:20:10 -0700
X-CSE-ConnectionGUID: Z5uKMaHhQvijfT8H3c2a/w==
X-CSE-MsgGUID: /U49ibaUToiwBKapbfHpvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93289077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:20:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:20:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:20:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:20:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuRr6+BXEXSoIdfnBmdi2imFxN40YTDEI+THM06kfeYE53yusCo1KPQmXt9QE4ayBcUNjsbwFo1bn21tyMqnIFUT5yNA1rs5np/iIVbC4Nonbqr5pT/Ua8AATNscjg3+RpCEGId7IW/Ymkp3Fd8ILmcaq9v0X2XIw+cxcDKhYO8d9rSs2jjVDoTywV7a7rdDMKZmxpBH7oUrJ3sE0vyFAnKtgMzDPIgLf8rGUZoK9TtF2J7fFDLdNBAoh3E4rLJ7nGWAsNLq4Tmzxpf6xkWsOx2+pYjnexRC+9DyPIFjNS4tKuVgKEAaFHwAoQWR+3ye5BNT27esDnZHejo4+2fl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs2yVUDHWXfLWbClfOYpyRwowZEdnBB9Qwq1sIB32vU=;
 b=V3xVv8CXTfD/keIXR9mQ1GuhuF5GxOrC+XyZZgHPkDYhZ7YuqkYbiJtEsOVzowepxJEULH2aMBoqo5gHTjxSdMC6nnirgAmSzWcypmsvyVcJbr3+w0SVZlFhodsjXqUo0mb1aOwHU4e6mY+PFZJ5+pZ7GpUXfEveq07L6o5n19SiHMp2seQ1JpFyFUzTMh63TmLfNc9EifsDnsHOLJN870wUJnd/8Hs11SSVhq2BiXYuPUcKmDgDOk7XmYwIWbRgOI3uqp9W7/QrxdxZSN8wJbKNWQxSrUe4K5fOFEKDRCx2J5CTysDAjX2cYgrKky0kL+IJJeJ/IwU6oulk5K/OIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 17:20:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:20:04 +0000
Message-ID: <9109e7fd-34e3-485e-bd20-dfd4c68edd01@intel.com>
Date: Thu, 19 Sep 2024 10:20:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/24] x86/resctrl: Add the interface to assign/update
 counter assignment
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1725488488.git.babu.moger@amd.com>
 <39a621b5281753c9f13ad50808d478575cdb52e6.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <39a621b5281753c9f13ad50808d478575cdb52e6.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:303:dd::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f6404f-690e-44aa-7d03-08dcd8cf4cfa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmRlRys5TUQyNS9Bek1vMkM2RWFpMktVYnVxTE9vQkRkOHdtU1NkTGZtT2Nn?=
 =?utf-8?B?MkdZdFFxUEV2QXRNMmJ6UVR4VWdNa1pIYkcxL21uWDVkZlBVcno0M1pnSzFx?=
 =?utf-8?B?RmNVZEhqeEkycHVLTmV1VnpvZG1lQW50MCtmM0RBTjlFYkg2bS9JY1A1cGov?=
 =?utf-8?B?a1VGa3RLMUh6bEREZVFzR1hkZjdWMzF2WGRjeEs4cEYzSXpCdjY0V2VPdldt?=
 =?utf-8?B?anJSMTU1U1pjYkN3eGVOLzJubWd6c1VvQUlCZHlybTB1OTlRZnlhL3JDdFhX?=
 =?utf-8?B?UE9QR0dTbXVWZFVXZitpUUxacnFzdFNFQmk3dHVZMnltNHdFK3liQmMrNXVU?=
 =?utf-8?B?MDBGUk0rU2hZQ1pxYWJ1dUpoWDRaVDJHT2hLTnNKd240b3BIc0NCak56UFYr?=
 =?utf-8?B?SHpjNnJESUdJRCtpK2xzbUVPdENFUnMwUUsxQytJQnppeENIYlhNTkhKRysv?=
 =?utf-8?B?L2xITFBxcUZGOW1aT0tyZ1h1cWtuOElmaFVxQkMxdXRRTE52NzE5d0EwaVNr?=
 =?utf-8?B?WStRUG1XNHJ4OExIaVk4dVFEblJ5TXluL0ZidEljOTYrZ0hKWUxTRnR2RVlt?=
 =?utf-8?B?ZktWNkF0WnBJbGduTnB0TVNSczNrcDNiTS9UOFZNalVXbnM3ZDRua2M1aEx4?=
 =?utf-8?B?dUZFREI2ckRGOXRaVmdWTmVSSUtOVXhQZUZVZnZranZjYUpBR0U0cnkyNVMr?=
 =?utf-8?B?Y2VpUDBoeE1vMEVrZDRUZFdzbGExT2VRY1hlL3BlTGFjMFpVTE84QmlZT01u?=
 =?utf-8?B?YjMxYVkyQjNSVS9oVXphR1NhR3cxbGtTMVpPeXl6cWdCa0o1dVliTE0wejVj?=
 =?utf-8?B?QXV2SFRBNkdtdGIyL0JsSEh4bktkdXUrdXNzKzdmbnJtRVdxTUZWYjU1bjk4?=
 =?utf-8?B?QVcrYzlrUklnL3F6SnRWdDRYVThCV3VSOGp3K0piVnlNVWZHQUp3b0FnZytL?=
 =?utf-8?B?eVVyQk92VnM4eFN3dVlkZTlnN0RmaEFPdmRKWEtJaXQyeVNQY09KM3BQY2NZ?=
 =?utf-8?B?L1FBU3NCaEUyamZ3UjZFNCt5MThvdVRXNjFRY3l3Y09jQUhhS013MWZBbWZn?=
 =?utf-8?B?c3JPbmNIMXJqeXh3NEhsa3NsYWlXQ01YemUxRXJnMURnVkd1bDVTRHFpOTNL?=
 =?utf-8?B?S0hEREpRV2x1aTk1aWY3SzhoNFZ2RFcwem1zSzVkb2tFK2t2dFpweHBCWHFX?=
 =?utf-8?B?NkFCM0M1RUJienB1NWdiektOUWN4MERRNVlRSlNEWU1kNk1tR0FkSE83Nldo?=
 =?utf-8?B?aW82R1Q3NlA5TDBuYXpNN2VNY2tYT2VHa0RaWkpJVlVvbEJhTWN3dllxN2E0?=
 =?utf-8?B?NHFEVmFWUElUMWNJNDVxa1lyc1hQZkdRWHFSSGw0MG01R2RHcmNyRmNoczB5?=
 =?utf-8?B?VmlIZ3g5anJNdEdiV28weHBsVE5xVnZGeno2aGQyVHB6Vk9GZGw4TWZKbHlh?=
 =?utf-8?B?VFNiakRSQlpnUzVSaE41L1lwdWdoSnJmNHJqcmRXcVdqNlFZSC9uMnRHcXFK?=
 =?utf-8?B?b1VJbk5QSDhKNzJzaUdSRytBOG11Wk1UdjVuWUI5UUpadzJaL2pyWDRuWmFz?=
 =?utf-8?B?ZkRDZ3FrUy9NYm5hR0Z3QjZpRytGeGdvZ1hEVmsvNFdldmhxcjJSZlNaWUVP?=
 =?utf-8?B?M2Q4emJmRS9XYzlEa1Q4WDh4YWZkeGUyV1luY0Zid3NmWFJjRlRaZ3FsbjJw?=
 =?utf-8?B?YzNvODl0R1haQnZybGRBOTRjTWRFS2ZtczRUbUZpaFhheVlSWVBTYnRSdlVG?=
 =?utf-8?B?QlM2b08rMHpzQ2RobGpmdGE1NjA1cFl2WS84Z3kzOUgzOUdCOE9Pb2RBZ2lq?=
 =?utf-8?B?a3RDUGYxUHVXaktpSjBEdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdzaEZRNFlCemZ2a2FlWW9JMGdKRitOMVpHY0VWcVVWRGhiTEorSllQUXpZ?=
 =?utf-8?B?cjFOSHp4bVd2bDc3NktXTjN0RkRYY1k5UTRSdVhmVHpXbk11RVpRcUlMcXdT?=
 =?utf-8?B?Nnd3dDIwVm9NVmJyS01HUk9RelYwRzIzanNIZmhGOGpvNmE3WUl6ZHVzb3BC?=
 =?utf-8?B?dnl0NUpETmZGM25nTXlVTjgwT3hITDNXOFFaQjhtd2RTWXFqWGprbzdwb0U2?=
 =?utf-8?B?NmlDN0EzeTNKQXhrcHBWSDJ3RzhMMXdtTHNOSmRkV0xyRlczU09qem84bXZ2?=
 =?utf-8?B?YzY2ZzVBaXFYL2dpU3NhcExlZ3dHUzQzWWhScll6ZlpwRlR0RHl2N2V5VEUr?=
 =?utf-8?B?VjZ6T20yR2FMYWJzb3FWNTNnK1I4Y3UxWFZreGZiQXkwTG8vRVRTbDZGanVx?=
 =?utf-8?B?blFJLzZKdURjTU5nV09NSnVhcWFmSGdPaEhjZG80YmhkZU12MTBYM0licFV2?=
 =?utf-8?B?bEZNei9Wazl4ckt5NTQyUXNFVDdWWVcxbFVZbFhySVM4aldKaUxrVmQzSlU4?=
 =?utf-8?B?SU5HTXppdU9IdE80cmlBQXRkVEk0UmZ4RDVnMEc4QXVoejlVU3JUY01ycEdr?=
 =?utf-8?B?TEdvd3JkeUkrQTZHdXN6Yk5jZjM1SkMrVDAvVlVpMTlkVXF6YU81d0hsZk55?=
 =?utf-8?B?aURqNU9tS0wvZDVqQzl3SFZrQnZ5ejhzY25VRXIwUG9BUGhQUmxFVjgvcU5i?=
 =?utf-8?B?bjdxQ3VoRFEzU1dmbDhLb25GWWVKdzFtZnJHLzI3VlVNYXB6YU1EUTdDYmhH?=
 =?utf-8?B?Z3NCbzJPMnluMmF2eU5yODVJR3hXWmlHOUNFN2ZCc3JqNDQxZnV6TFdwbzNY?=
 =?utf-8?B?WGdITEVPZHBVSm53SzhkZFhYMkk0NmhlSnlOV2ZFUHdqcVo2dENya3VvVFB0?=
 =?utf-8?B?NDNUekhXWFZIVFhlVzhHTlVXb3Qzd09VcEQyMVVrdWtGQUJoR0RUWUNIMHh4?=
 =?utf-8?B?RG9OaDNLK2FvaEVtMU5GOW4yQzF3NkRTZ0dQRkRuVmVDaGNWNTJEY2ZxTTVL?=
 =?utf-8?B?b3NwSXI2eDR4R0lpRkx4UVc2SDJjUXkyamxySzJFblZLNWsxVnhGVk54TUpC?=
 =?utf-8?B?RTdkRTlQU3JldlBLYmhua1dzSE9mYzVQU2tQUi9PZ3l3MHc1OE92T1ZvTFdN?=
 =?utf-8?B?Qm5lSFR0SkFyQ2NHa21iWGJFTC9LU1MvTlVzUGxLUXJ2T0YwUjdtek1hbnFm?=
 =?utf-8?B?dW9yT0pVMCtMNDdZbGh0T2s5Tkxrc0tnL2N3dWxWcFl6c1V0SFlWMkFzU254?=
 =?utf-8?B?aS90ZFJHb3NsbS9DWVVBUHEvVDd2NWl0Y0VyVHR6cUVrUlpmZTZRWVNCRTRB?=
 =?utf-8?B?bmUzNkloWEd0dXhsN0xNMjV1YjMzMThlbjlPS1Z1NFlHd2x0dVJrd0RkSE9j?=
 =?utf-8?B?M2I1SGEzeExnRHdGZmxxNW1tRDY4QXMzNnJjaGxnQ2w0SlRORnc4ZlBmZzkw?=
 =?utf-8?B?NWhoVVpQWjBscTk5VG16enBXQ0NTclZndUIwT2VrMWRNN3piTnptMG11KzNu?=
 =?utf-8?B?ZXZSMTE0c1E0MForQ3VEaEJSbm51V3lXYzBUNEFxVE95d1VrZnpxOSsyWUNa?=
 =?utf-8?B?NHZwdUtVVkphemxIck5OTi9DUjBVaVhpcEJzb1pnMFZDdHVQSWxqUkU5cVpB?=
 =?utf-8?B?K0NObWdIeFg4Qi9RRHJNK2xoTE1heWJFdytlTVBWRFFHVm1pZ1FUYVdCZmdQ?=
 =?utf-8?B?dDA2cUJqeFU5bGFYVHBROG14TnNsaGlabzhmT3F0OG81dUF4NTcwQWVFMDJW?=
 =?utf-8?B?bWl3YzdiRmc0S0hhRE1KRTBjY0ZCZ3dLdHYyVHg1eVY0akVmRHV1WHhkVTlx?=
 =?utf-8?B?RnVKSEUvNTYyNkFiWEZrK0pTT3pYM3FPb1E1TE42RTA3b0VXSUhPWFZUWlZl?=
 =?utf-8?B?dXRuUTZsUndJNHpDNmpYdCtSd2FVZUhhUXBOL01KbEx5ZkdUYmo3QTg2RmF5?=
 =?utf-8?B?dy9UVFc3N2N1OUQrUlFISjJVY2pXWWJ4Sml6NDRKRDVLQndHTXNob1M2Ulpz?=
 =?utf-8?B?SmVPUzVmWVc4QVdPU25mYjF5QXF2QThQd1NvbG9EQlRRTDRoRjVKa0FrekxI?=
 =?utf-8?B?b3YwbHhZeEZzRmxUME02UXpjbDgwWUl2VjlYUm5SSWNXbU44SWhBTzUwVmM4?=
 =?utf-8?B?eUw3S25XU3hCMmdmT3VHeU1vSFM0d2xaOVJTdkowMElUMUFISVFIK2ZrYmg4?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f6404f-690e-44aa-7d03-08dcd8cf4cfa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:20:04.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Frea9UJwS1z7SDj+QRxWzdqBK5SjffnQe8/h6ds40ECt/0kuMC60qLumSshQQ4XsdNc0p/ulrbhGMeaMOQz12lomt0HINi0nZyaav+0IQPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7ad653b4e768..1d45120ff2b5 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -864,6 +864,13 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +/*
> + * Get the counter index for the assignable counter
> + * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
> + * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
> + */
> +#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
> +
>  static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>  					 struct seq_file *s, void *v)
>  {
> @@ -1898,6 +1905,45 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  	return 0;
>  }
>  
> +/*
> + * Assign a hardware counter to the group.
> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
> + * else the counter will be allocated to specific domain.
> + */
> +int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			 struct rdt_mon_domain *d, enum resctrl_event_id evtid)

Could we please review the naming of function as this series progresses? Using such a generic
name for this specific function seems to result in its callers later in series having even more
generic names that are hard to decipher. For example, later (very generic) "rdtgroup_assign_grp()"
calls this function and I find rdtgroup_assign_grp() to be very vague making the code more difficult
to follow. For example, rdtgroup_assign_cntr() could be rdtgroup_assign_cntr_event() and
rdtgroup_assign_grp() could instead be rdtgroup_assign_cntr()?  Please feel free to improve. 

> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtgrp->mon.cntr_id[index];
> +
> +	/*
> +	 * Allocate a new counter id to the group if the counter id is not
> +	 * is not assigned already.

"is not is not" -> "is not"

Reinette

