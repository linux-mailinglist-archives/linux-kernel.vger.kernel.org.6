Return-Path: <linux-kernel+bounces-333752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE1597CD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21963B22E44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628971A2863;
	Thu, 19 Sep 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZX8eOkh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301FC18A95C;
	Thu, 19 Sep 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768764; cv=fail; b=SE1qm6rcCzTHl7ZFcBhogEjj7SLE1N3oSMcDGkY7lNR+zGoPoMGW567VBAl8kbhz8ydoJNT3X7cZ706eBS+kV4VbHqjCF4Ud6Jnbj9tt4vubm/ZHDNT7pA6FYx9V3AcyRIJar7SI3Px2a6LQAg8E0qejb8hv+p6xejandMMyels=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768764; c=relaxed/simple;
	bh=BAoJyl7KOMV4ozye0OTzaepA4ruPNsxgWzf1iU3Vav8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uedR5+BUVECVOm7pFyt+4hRU1uzBFPmzETdgMLEPEX7iDqzRZ4oxq710faJd78yYgOSHeaOhdTd0TpH4/yPH9qdGEPc5Rs0e3EtdSyn2+cHHEX5OGo50PqIoHg8UTmG7KnD934y9E52k3ai1ihRngDWuX3dJh1SjDVr9dDAkwnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZX8eOkh; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726768763; x=1758304763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BAoJyl7KOMV4ozye0OTzaepA4ruPNsxgWzf1iU3Vav8=;
  b=NZX8eOkhkwY30WxOl/8xjB8CDdnaySB+j+3GtNBj8mxXJIPMNW2vJ0d/
   JYH4imZIl6R2/tgTIkpP0Xa2x6rxLsmalRW0Kpw9hKJBdsbAxNqJJJso4
   rvRwTLZj5pjjUa3rIjFs2BDNApQ7CqA2RllIpxozpfSgGZ0tlUHMRIo4m
   TfmvwFeErtOzA0C+pGIV1LPtxClmlgQG8QD6Cz7MwlHyRKHQ5sofPXvM/
   2V78pyyWCD5SiG9FPukCuKNrr8n4+Ksi2m/Sgoh2PZXGcTGGVmxhMC5wy
   zxkWfOeaQrthz8PR7MiF5GunLZp/46RW60gbo1PjwYSwCS7P9na4FWMW7
   w==;
X-CSE-ConnectionGUID: xpf0Hf6YRUSBJaTd4F/TXA==
X-CSE-MsgGUID: nlqglABEQsyltHmXl6auPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36885093"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36885093"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:59:22 -0700
X-CSE-ConnectionGUID: eNdP1f4PSPiQX3h89lMkaA==
X-CSE-MsgGUID: fwRbpA+ESrOO6noRbp8L3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="69608989"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:59:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:59:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:59:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeDL8YT/UK9QIouAGkMXLS/ju2gbOKrBG66gs/dfSV+BoDRhGfzKvpQZkaTmdgVWHOy0Q9G9S91x1sIfofS54YXjS6dNH7WKIj7K3tC/QO8Uo95+C5Ldgl1H2pSL9Tx0gQ8BCC7FduEO0bFGh1uLPek2ybVm/iOYYq9da0m/fsqOtPqoumwuG8doV7Eqk/ESzJEOtqg0rR6Md+JvkbjnagS2pD0LXyX5Lig/sui9PS+j3VQAxecJf9MAX111xgmh6LxgWni18gSel6XlYlH/ixgqU+mJb6H0Lq+/AcVweCrNmqRQtRiS7DZv3C85L06/JT0iEJhNx0JGC0eUYspgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrhtCJIEuHaiUePAs6IZRHjQyh72tKhzyVmP5eBfQwc=;
 b=qq0AYHc1LHmZ8SDFNNTmdAhtBU5BjV6WmgAh4EYga65VWYoIRQUMbzifaguVTPH1szwbnafBsn40qDqcKLgPJzCRt6GljexOYcLe/3ZM1LdxgpU4CVovWV0Yz+XZx5lqHHMYQmseQuf0WSBepE4ed1whGe0lVKe9IJg/8k/FzD0DVuEu9tRTOLKJmBIX+OgosNB7QpWRvVvI+97UuRoHTuwkgy8YT6z9WVcZTIw+1cFuLoxxQu5x7R0I5Lscsyyfz2o0l0eUaQb12CPPqDvBOp9Z12+tjg4g3t8fEn2W87mCT7K9jHf2ZUVfXMFt/oMTxTHjX0/I51oVBtkLu0ayWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 17:59:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:59:15 +0000
Message-ID: <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
Date: Thu, 19 Sep 2024 10:59:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 101e4f12-2032-4c14-30e6-08dcd8d4c647
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUR3UHZZdE9yMHIrU0V5QjB1a3ZrTzUxcXZYR3I1eENNWDNKbkV4a3Z3VVEw?=
 =?utf-8?B?Ty9mQXBJZytFVDZFQ1hRdkJ6YkhaOTlNUm95dXZkaEg1NW0yQU00TlJLNlcy?=
 =?utf-8?B?UmhJR3BBRVlFcUtLeUVsdkFWeGVVSmJIU0JmWDBJRFZXM0hUVDVkL3lHbFZQ?=
 =?utf-8?B?TDVYQUI5dkc0bmUwVE81Z3VNYnJHaUNnajl2SWdvSHZERlA3K2EwTGZqZEZJ?=
 =?utf-8?B?c08yMEVXT2oyakxlaTFNNDMzSk9tYTQvbGJ0ODhHMm1pYW5xc3dHNDBQS3Vp?=
 =?utf-8?B?TEdEL0J3SGtGMkJtK21GV0NLVUVwa09Pc2hpNTdrUG11RXg0aWhRbHAycTQ4?=
 =?utf-8?B?YWZBUndrV1RsUzhqUDF3VlE3NFcwdHVPVWpMa0ZjZUhJUHlnbkhVR1M5dXRZ?=
 =?utf-8?B?MHhRRTBid1NoNXhwdzl1bE5hUGJubmRFMERWa3FCV1JWcE03bUZNUUkyMnQv?=
 =?utf-8?B?ZGNYWWJiak5xWXVEQWt0eXd0bEEvTGx1Z1RhdWFXbGI0QXZkSkNQWVlQL0pP?=
 =?utf-8?B?cVNBb3BSQXZvUkZHZVBzZ3RsRkVydmJoQkw4a3VBeDJjMERYNCtQcTVXaTQ5?=
 =?utf-8?B?UGN3NmFnVUJwVFB2WXVWcjhtd3FISzdNVVEyY3doYjkyVldQdFp4djFjSVJY?=
 =?utf-8?B?c2doMVZveFBUZzNhTGwxRnorTUcwVG1sV0V0TTBzQmpRd1Q2WC9GUjBlclRZ?=
 =?utf-8?B?Ulkvc1NSUmRqRHRndjRIZHZQZFoyNjhHeENvQjZ2YmozbVpSaE1hc3VZcVBE?=
 =?utf-8?B?Mm9NeVhuV2RIUmFPbGJ3dGhUSUMxSnFwcWcvSEt0ckpTVWM1UDVHZmk0c29P?=
 =?utf-8?B?TlFPZWoweFl3MlBSUkR3Yk9hdC9UWS9ERk5EbUpWdllhOUp2UWN2MS9kcVNr?=
 =?utf-8?B?UDhMazUzNGJqbXJNWG9LbUxzSktwUGgwUGZuTnl0a1g2Ni9IZ0VXVnpTVk1F?=
 =?utf-8?B?ZkRxWjlMK2J3M2JwcllKU2d6N0p3YjFKWlNaSVRUZG1zd1JTNTRBRmVtcGxE?=
 =?utf-8?B?S3NRMnpkSTlGOU01SzJrN3p1OE15YzlqdXVOT2tUbllvZFFtaFNlSThmV012?=
 =?utf-8?B?TENyeDB6cjNQSy83cWh1UVdHUlFiQVVQSTdsOVgwTDkwRWNFdG9jMDNoM2hZ?=
 =?utf-8?B?NkpmN0dsSmNlQnlqK09vcm5aYWVMUkVrQjM5VGF2NVNYL3pHbzR2R3RMZjJl?=
 =?utf-8?B?K1U3QVIwY0V5eU9DdFZRNnBKWFhXV0p5YWkxOFlCV3NWRkdSWDV3dXlvanJL?=
 =?utf-8?B?bVUvWFc2VlIzcGg3R1BZYXRPTExqNm1EN2lQQ0EvcTIyR1VxaFFTMmtKcnVj?=
 =?utf-8?B?SXVuTllQZ0E1WDVVZk1ONjhFTHNOckNpL0wrM040Z1ZyYTI2SWo3cTZpRkNF?=
 =?utf-8?B?TUZCa05wTVQrMVJyVW40SzhtZzNRUkt6MFJmd0htZGxrSXh5dU0xUC9EVG1V?=
 =?utf-8?B?WWJFMVhHNEp0ck5UYVQvQU5hUUxucEpzM0Nhb1I1aFJEWDZ6ZHRjODBCdEQz?=
 =?utf-8?B?WmhYRkRjbzkvRzB4VFNkR2piZ293NElXZkVhMGdobzd6UU5KTUJBUkJwc09t?=
 =?utf-8?B?YXlNMlp1Y1lHbmVSMy9aQjBOY3NpR2VrZkpoU1IyS2hzR3Z5bkV4WkNpcUJh?=
 =?utf-8?B?QnV0RXd4VFFXcWx3U2lsVzZrQ2hEaFlMOFE2N3RyY2VBQzBNd0lJYjcwYmNI?=
 =?utf-8?B?QlhBTU9odEdYWUFmYlR1YlBEckkwbzVwcy93OVpVei9KTGNYUkRxbzJtY2hC?=
 =?utf-8?B?M2VzbFZBdTRnWS9QRjg4NnJMbGJJNXFHY3hTODF1dU5GODQvLzllV1FzNmdv?=
 =?utf-8?B?SFZYd0xnNW9TYW9MZ1BPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGp0b3k0akxBZUxUZXAxVGwyWkF2SGMya2QwZUtjbDhVd1k3QU5haWtvNFd1?=
 =?utf-8?B?THRRbDdsNGx3d2hrVjdJclowdDJTeWRON1RQNWhKaVEwVnZ6TnRpN2dkNVZ1?=
 =?utf-8?B?anhuREQxbFVwUkVicWVRRGFOcUEvZGhCdnZvU0ZwU3NYczNoQ3BpQTdkdk9Z?=
 =?utf-8?B?SWprOG90bGdlZnA3Wkl4eDJPYVY1YllTWjJDZE5pdklYNDBuVGRqeUtmSWh5?=
 =?utf-8?B?emdlNlJPdHRyeG1CYkZjZ3E1QlNLeFF4VmxYNnRzUkNiZ2hPWlExQ1VPUVFH?=
 =?utf-8?B?OGdLM0NNV2FUbXIvOTRzZlRma3pjdnVUZmROa0szZWwxM1dNMTJFWkVXb1Bn?=
 =?utf-8?B?TVE3a0dDN201UHp0aDd4Q05iK0FxZ2lVSnIwdVNqakVFMjA3dWFva3lEK1hM?=
 =?utf-8?B?ODcyeTg0Smg0SEx3dm1YZG9pdThIQ0wzVXY0ZkRjTkY1ZzRKUVVDNnFLQUdx?=
 =?utf-8?B?WlVsRk9Lc1VMZnY4SEl3aTEyOVdFVy8zOXFWKzFJNE5QU0VSOElPM0FLU2Ey?=
 =?utf-8?B?MElnOS9IdFdwUU9WWTZ6TUROZkZnWGY5SjlQYytTckFkWDR2ZnZtbGYwWFMv?=
 =?utf-8?B?YzdhY2czRUE5Y0tEYkU4MkVkQmJDVHlmVDVINDNGQ2RuRU5FMFNqR1ErQVhx?=
 =?utf-8?B?a0JOMjZubXRHbjlvTW5IM09vOGxkbUNCdm5NeElRc3Nob2orV2IzTnFhL2FL?=
 =?utf-8?B?Wk9XdjJPcU5Gem4xd0s4OVdNaDMxbnBXYUhvVGsway9tNERlU1Y0MFdEYWFL?=
 =?utf-8?B?L3N6Q3h4ZjgxRGd5MVg0NE03MlZSbGwyb0YzczhrZS9FUU82ZjBUOGpwemgv?=
 =?utf-8?B?TWpkWnRwZlNBUHNQVHIwZDdWZWhDSzlMTGJvWktDVUVMNjR6TEZ2NVVZTi8v?=
 =?utf-8?B?OWs0OHRWQ3FJdGY1WkZlcDhmVVk2S0JWcDRKdjFZaW1obUdIQ2FINnowWWNj?=
 =?utf-8?B?N1JPQ3RHdGFFM0I3b0ZodXpRY3BveC93Z2xVb2R2U3c5Q2ZCdWhLY2JJZk1E?=
 =?utf-8?B?bW5EZWdCRjdrQ2hlNmk4akZzakZuMmFra3lPaFYvZDVYRC83TmFKRE1pNUhv?=
 =?utf-8?B?Yi9OeS90QnFPRVJVdUpubTByOEpOTDQ1VGM3QytBdWhQdzlVTzhsT2oxU1RK?=
 =?utf-8?B?RWFvSmwwTzRoeXpIbWV1dnV0SG05OURlRFVPcnJDOXVLempSRVlQK1lVeUU2?=
 =?utf-8?B?MWVTNUNHNzFGdEpMeW96SHhYRnpNV0h2N0FVSEx1V3R5Z0RLeWpUN3FsK2R6?=
 =?utf-8?B?bDJrcmpwWGt1cHJuaXlNR0hLelk4NWNLdXdyOWw4K1B5RzRqMDl6blVCanN1?=
 =?utf-8?B?ZTZhcEIyMlVReTNSVmtHK2lUTC9aaTF2RUF0dTh0N1pqNERLdUN3TFBwWWZi?=
 =?utf-8?B?eGN0YndpcENFSkthZU52eXBvNlJtd2xyejdxeVpEdzlndEkyMW53NlM4L2tl?=
 =?utf-8?B?MHhWWG1tTldPUWlNZmpJK2tYRERtNTRETGhZa1BJYkJBQ0F2aHJHS3I4anJD?=
 =?utf-8?B?TG9SdWlZclBYRStiVWtmalBORnVOQnhNQUZHMGN2N2xJK2FKY3lGU0U0am5u?=
 =?utf-8?B?WEJwcmk4clYrdS9RRk92RUZiNlhOVEZybTR5SVdpakRpS1hGTnhseHhDUGdQ?=
 =?utf-8?B?dUlSMjhOeU5kVVVUWStpSHBPWHZOV1lGU05LSXV5TDQwTHU0dnBnRlRtM0x1?=
 =?utf-8?B?aG5HN1BkSDAzcmFVOEFrdG5RZXhGVlc1S0EwRWJLUHRaUUF4N01ybFBvV2tU?=
 =?utf-8?B?S1pDRGlaUWJGbzB6dnlkdVdCell2cVF3YmVvS3B4S0Yvdkl3ZFRxdlh3ZVpo?=
 =?utf-8?B?YmJQZE1TK0tZQ09rNVdJMGRRaVNpWmg2Ui9rQmM3YlFacExVOG5TZFhDb2ZC?=
 =?utf-8?B?dlVMRXN6UDR1TFpxVkJKdk5iY3NiOWVPVzdac1dTUlFaM2lCdEJ0RkdxTXhI?=
 =?utf-8?B?TjJGSjhlNzZ0TWhnWFRsYVpsVWNVNkNmS0Vwcnc4TlQwQnZyYU1uL2t1S05W?=
 =?utf-8?B?dWRBbEFLdWx2QUw2Z2x3Y0F2STBJdk10Smw2ZTA5bitKdVR4YkdFWHRldnpH?=
 =?utf-8?B?NjQzOEtDNk1iNmNzZHFqNys5RGVNYjVodkRwN055czNvZlpWRHlpWmwvY0JK?=
 =?utf-8?B?YmM0WHhwNDZ0RGpwdGlqbzl0Q0ZvKzhKa0ZEenZadlNRUUtiOEZHckxEcGFy?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 101e4f12-2032-4c14-30e6-08dcd8d4c647
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:59:15.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd9vizRGKVqD7E2863JCNE4pL+TVATRMh5rq9EOUu2OY12i73QTU/WAyaPfuJaq7RlPj1YwcFEuw6CzCsD29PU4evTi9kqSbl2iNiOlhk+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Introduce the interface to assign MBM events in mbm_cntr_assign mode.
> 
> Events can be enabled or disabled by writing to file
> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> Format is similar to the list format with addition of opcode for the
> assignment operation.
>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Format for specific type of groups:
> 
>  * Default CTRL_MON group:
>          "//<domain_id><opcode><flags>"
> 
>  * Non-default CTRL_MON group:
>          "<CTRL_MON group>//<domain_id><opcode><flags>"
> 
>  * Child MON group of default CTRL_MON group:
>          "/<MON group>/<domain_id><opcode><flags>"
> 
>  * Child MON group of non-default CTRL_MON group:
>          "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> Domain_id '*' will apply the flags on all the domains.
> 
> Opcode can be one of the following:
> 
>  = Update the assignment to match the flags
>  + Assign a new MBM event without impacting existing assignments.
>  - Unassign a MBM event from currently assigned events.
> 
> Assignment flags can be one of the following:
>  t  MBM total event
>  l  MBM local event
>  tl Both total and local MBM events
>  _  None of the MBM events. Valid only with '=' opcode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>     Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>     Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>     Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>     Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>     Removed ABMC reference in FS code.
>     Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>     Not sure if we need to change the behaviour here. Processed them sequencially right now.
>     Users have the liberty to pass the flags. Restricting it might be a problem later.

Could you please give an example of what problem may be encountered later? An assignment
like "domain=_lt" seems like a contradiction to me since user space essentially asks
for "None of the MBM events" as well as "MBM total event" and "MBM local event".


...

> @@ -352,6 +352,98 @@ with the following files:
>  	 There are four resctrl groups. All the groups have total and local MBM events
>  	 assigned on domain 0 and 1.
>  
> +	Assignment state can be updated by writing to the interface.
> +
> +	Format is similar to the list format with addition of opcode for the
> +	assignment operation.
> +
> +		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Format for each type of groups:
> +
> +        * Default CTRL_MON group:
> +                "//<domain_id><opcode><flags>"
> +
> +        * Non-default CTRL_MON group:
> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
> +
> +        * Child MON group of default CTRL_MON group:
> +                "/<MON group>/<domain_id><opcode><flags>"
> +
> +        * Child MON group of non-default CTRL_MON group:
> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> +
> +	Domain_id '*' will apply the flags on all the domains.
> +
> +	Opcode can be one of the following:
> +	::
> +
> +	 = Update the assignment to match the MBM event.
> +	 + Assign a new MBM event without impacting existing assignments.
> +	 - Unassign a MBM event from currently assigned events.
> +
> +	Examples:
> +	::
> +
> +	  Initial group status:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +

Similar to previous patch, looking at this generated doc does not seem to reflect
what is intended. Above and below are all formatted as code, the descriptions as
well as the actual "code".

> +	  To update the default group to assign only total MBM event on domain 0:
> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	  Assignment status after the update:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	  To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	  Assignment status after the update:
> +	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
> +	  unassign both local and total MBM events on domain 1:
> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> +			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	  Assignment status after the update:
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the default group to add a local MBM event domain 0.
> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	  Assignment status after the update:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
> +	  the MBM events on all the domains.
> +	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +
> +	  Assignment status after the update:
> +	  #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	  non_default_ctrl_mon_grp//0=_;1=_;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy

...

> +static int rdtgroup_process_flags(struct rdt_resource *r,
> +				  enum rdt_group_type rtype,
> +				  char *p_grp, char *c_grp, char *tok)
> +{
> +	int op, mon_state, assign_state, unassign_state;
> +	char *dom_str, *id_str, *op_str;
> +	struct rdt_mon_domain *d;
> +	struct rdtgroup *rdtgrp;
> +	unsigned long dom_id;
> +	int ret, found = 0;
> +
> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
> +
> +	if (!rdtgrp) {
> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	op_str = strpbrk(dom_str, "=+-");
> +
> +	if (op_str) {
> +		op = *op_str;
> +	} else {
> +		rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");

"_" is not an operation.

> +		return -EINVAL;
> +	}
> +
> +	id_str = strsep(&dom_str, "=+-");
> +
> +	/* Check for domain id '*' which means all domains */
> +	if (id_str && *id_str == '*') {
> +		d = NULL;
> +		goto check_state;
> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +		return -EINVAL;
> +	}
> +
> +check_state:
> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
> +
> +	if (mon_state == ASSIGN_INVALID) {
> +		rdt_last_cmd_puts("Invalid assign flag\n");
> +		goto out_fail;
> +	}
> +
> +	assign_state = 0;
> +	unassign_state = 0;
> +
> +	switch (op) {
> +	case '+':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		assign_state = mon_state;
> +		break;
> +	case '-':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		unassign_state = mon_state;
> +		break;
> +	case '=':
> +		assign_state = mon_state;
> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (assign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_assign_cntr(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);

hmmm ... wasn't unassign going to happen first? That would potentially make counters
available to help subsequent assign succeed.

> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (assign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_assign_cntr(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (unassign_state & ASSIGN_TOTAL) {
> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	if (unassign_state & ASSIGN_LOCAL) {
> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		if (ret)
> +			goto out_fail;
> +	}
> +
> +	goto next;
> +
> +out_fail:
> +
> +	return -EINVAL;
> +}
> +

Reinette


