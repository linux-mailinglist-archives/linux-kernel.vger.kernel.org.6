Return-Path: <linux-kernel+bounces-333685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91197CC5B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B5D1F23BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486BC1A7254;
	Thu, 19 Sep 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zr5PVT+2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFA1A705D;
	Thu, 19 Sep 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762605; cv=fail; b=VMG9PVGmWoUUYq5GqVnIToZrcw1YHRDBur7wzkTRECxJuzr0P1HhY74SB0U0pzjgMEiqt/y9oaTzCYPUg24Xh1RWvKLazGeT8PZ2g7xexA6KpxiVgIZk5m4N/bl/FxAAG1v11ofE6BzGV8p9rosEEXghFsQbDJj45ollyWoBrUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762605; c=relaxed/simple;
	bh=j1Cwi2aIrxAtlaK73jk0CvUioFZXBlTAY0QPwxWtq/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwKk9GVcPmRPKlz5KaFD3jUhxoC0tRQgfA3A8khNWe4QIR7MVEKEAQFLFQFWzfyS5ReQK0PMoMFnXQPdUfSaCJr3wIAiUePTaI5QS1vnWKpBEybybooIJz6bYl5b4kRpnAYp+QH0wkPlewcYHQEeqMyxT0OnUpyk3co08d/iZnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zr5PVT+2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726762603; x=1758298603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j1Cwi2aIrxAtlaK73jk0CvUioFZXBlTAY0QPwxWtq/s=;
  b=Zr5PVT+2mWYhzZukEkzuaEyWXAtDnihJjI2OJsvlWLxREb14zf5NWcnD
   1avsvUZPasI30LuleGiXV1U1wgPkArXnTBlibs5EuLeQBohi9em4kWtkp
   x/e7m+8/+l3zFNndp6PXk6oGdWiRQaWp6+/rMghGNLblRL2QFVr0fxdbO
   CvETX3v01nXTvuvUalHvqmGkb3xYA/B2o5Q1O0wQ2YM9oSSQuYk2iFTFH
   CdLXDsK39at9NHsIno5+nAHSGpC5CbnZixd9wXQSrdgVryxP92n/LOoLy
   JdRhdotR+Q1NdJW8KBdhor3TYhFlyPsN4NlOHu1LE+HCmgGR4VdeZj6U7
   A==;
X-CSE-ConnectionGUID: rT0TyNScQ2uqGD5M7KdfLQ==
X-CSE-MsgGUID: z8a/TUFbQ/q4SBvz7sLz6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="37118828"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="37118828"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:16:43 -0700
X-CSE-ConnectionGUID: DH6bNV14RNm0GJCAlq52Kg==
X-CSE-MsgGUID: 4RYNl5EVSyWm3PHhHJVlEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74527642"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:16:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:16:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:16:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIWRJEYtOsSJZICaUfAUDP08rB7kHIL5SMFpW/Rrb41j9iC9cHaqjPRDwi5QsZcDlkQGZPl+O5fm2INsZ9XNd9ncjWUNFQVZAglDiA1kHTaG2fA4/mP8RWIgjnLLwAbJQg00I7ByTXJkFOZ5JuuzRChVEeRzX8jLMuH0QAeysY6tRUb0aVHXaH6dQOATPmJ/EHkLt0Jy50A1F9uoFzDK+guHd1Y0awlEUew0URKhc6XK4UlS2e364cq899C5bXtE1PbetEEM293d7yRNPvY/eY9Za5gNLmR7N6hahxnWwLcRQtqofKnE5ZE2Xf53ndX22dzNvd9xAxHNZmehcCotBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzosnQGGPLc5Oe6K6wegtuSeRu+UsM9qp3FksyZIkUU=;
 b=Nl/3xShn5XacUA2NWlpn6xoCn+k7nOI4PKLWASX77dxvA8Y+x63p0Exir9WgA+t2fjFGiXrLDqQCSFRR89GWMXVijtQveBMZbAdozqamW42ImCeoOQEbAzYDq7eVUqhDcbtK3e77pUd7iidMy1pj91AJAbp1l6QvEI4IQhNbcNVS0rIz3AyHGpc/0H5WAzxU+u7fbfiEIaMxi0FIW4iupecr15y8DmYMEaZcYFeEhXfL5JVJjorzfw0c7gT2RglpV452+dgn2PzNsqBrkppLjriZikt37I4Om3aveYlE09sths0q4Fh+ytAP54lCQwk9q9ZNsUVZ6ebi/zjMXvC8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 16:16:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:16:37 +0000
Message-ID: <62813c04-c247-44cd-a604-9b5f9a3e9453@intel.com>
Date: Thu, 19 Sep 2024 09:16:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/24] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <01aa73f659a24b5c54b5104f1c35c32dd06c3376.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <01aa73f659a24b5c54b5104f1c35c32dd06c3376.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: e808d8e0-f66f-4712-404c-08dcd8c66fc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1d0UXVZdnZnUlBFQk9CU0NYSzRUQzlVK2F4ZTRlM1YySU5Tb0tvdlBVNVha?=
 =?utf-8?B?TU9Db0oxMXB6SmFHdDVheDh1NGhXUTI0OG1rbk1iQUV6U2tEQmZKVEg3b2Nk?=
 =?utf-8?B?aUxFTHViU1dpdTJUbkV2NzdLeEJnUThnS00ySlg3Z0d3MnNrMldteGR6SnFq?=
 =?utf-8?B?WVB3WnJSbUNqZzBqeEY4c29RTlNjVzU3TVNIYUFtU3prcTRvMWVzMWlGZ0FW?=
 =?utf-8?B?S3gzWEI4S2hyMm5WRmNZMjllUTFCcHFTOE1Qc09OT0hhaXRlYStMdVI1VUhO?=
 =?utf-8?B?N2xDa2IwalRrSVhwRUFwUTNucFd0UzdnZjNyL3RqMWFSR0pKUEtvNWdoM05u?=
 =?utf-8?B?Y1pVQlhJUkJxNWtjK0h2NWpBY3ZTOFBmVE1yUEIyaEt5Y0x5M2VSbHIyanli?=
 =?utf-8?B?MXUrUWJPdWJ1dERFSElsK1FTU0hHQ2kxQ3dmSjRWYzFDVTJOaFkrV1RGcnB1?=
 =?utf-8?B?eVRRZ1ozdDN0MkFVanBoRjc5MldOTVE1TlllaDV0OTBQTDVYZXJtM3I3cnoy?=
 =?utf-8?B?VFBKR0ZIWHgrV2xITkRXV0gzVktrd1hxOXNLK3JwWXovMzJCaUxYbmZJUkx5?=
 =?utf-8?B?YmNPQmVHMmcxR1dKQ0JnUVBZOGxrL2dvL0xsTTlIN1FQMnIreGt4NEVGV1BC?=
 =?utf-8?B?aFZRRFdqQ1lnSzZHTVBhOVNsNG5uenBFTytHY1hlVm1DcFNZOGY1QWQxRFl6?=
 =?utf-8?B?UDZxajdUUi9iMnFyR1U5T1lpczVKajFUbFhvQ01FbG9aeGVUazY3YmowSU9j?=
 =?utf-8?B?UTJvOVhqN0k5eVdqdzBqNlpQRjlrc2thc1RheWptVmE2cUpqc0xmZWpZSjhr?=
 =?utf-8?B?bkh0OCtGNXZ2dVVHdml1STZwR2cyc2RyeEhOMFpHWllJcjBQc2JocVRZNUFS?=
 =?utf-8?B?aTRhOEg2eTNjZDkzbjV0WFhYRHZSMi9kLzY4aDFtY1BML3pZSFpsRzk0dXox?=
 =?utf-8?B?VCtxRnl0UjZyNkQ0WlVVeTBqTEdyUWQraDlmMjlqZTY2a0hBUGswQ0E2UWVp?=
 =?utf-8?B?d3pxQjdmVk52eG1sbHZWaUh2eHVOcHV2ZC84YWI1RTh6Yk1rbmFTR0RXK0Va?=
 =?utf-8?B?aWQrKzdHdUVQSjE0TWM0VzVneW5ucFpyUmIxK1F2NCs4NXZVL1N3WjhKcld3?=
 =?utf-8?B?N2FORkRFMithYWRUbjRxaHUwWWFTZlBYTkZMTWk0YjBIWWl4TTN1NmtuYTRq?=
 =?utf-8?B?RUNWRWFlVlMveDIwZmlDUml6OEtkTmhuN1JLUzJHREd3OFlmUkg0eW9kc3l4?=
 =?utf-8?B?RWxGWUc0SWh1bHlNaXR2RmM5QitKTWpQZU1WSXc5QWFiWEtJM2lPVkZ5emlL?=
 =?utf-8?B?RFdsbS9lTUxNbzhpZkxMR0ZXcG4rbWFxTHZ5c1ZvblNKdVFzRWE3WDZ2MWRk?=
 =?utf-8?B?d3V0a05LZjdXcWEyNUJpOTBhckthWWdVbTkrME1iQWhiZnk2VW8reU45N1FF?=
 =?utf-8?B?dnV6OHcvSWxCc2xpNkt2MTdSKzEydTc4WnErcjNCa1FNK2JpUzJid24yNkk3?=
 =?utf-8?B?eTlwQ2NKRGdHTjdpQzRLd0FsM2hnOFo4TTVxR2szanNiRmdwT1pLaEtlOWFH?=
 =?utf-8?B?TG1hS1RGc2JsTkNiU0VONm5NOEh1ZWUrSkVpa3FEYTZvamt5NGczTHphcjN0?=
 =?utf-8?B?UHZ5SWlkYXNSZVlXcFJqTzhERTh6a0RQRXAyc29QKzVFaVo4R3dJVExHNHJn?=
 =?utf-8?B?Z1QzMzUyaDZUQysxTXk4aWhkc1FGczU1dUNmd3ppUlY4THZ4TVh4bjN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUphLzRnZU93Z1VzRGM2WVgzeEs5ODk4ZmtHWnlDbWtMY3R3S1hQb05zSjBJ?=
 =?utf-8?B?N3RRSHhFbHF6QVAyRjZYVWoxVDF2L3VzK3NWR01qTk5Md21mSzRiWjRwN2Uy?=
 =?utf-8?B?cG93T2JFc1V2VWRoUnNuTXVXUHl6bVVtdGl0T0EyODFtYjRlWHdDVm1vdE1J?=
 =?utf-8?B?d2Q3UkwrZko0aHZIZ09iTGtlUUNuN0drcmxRRWl0NzErUUd1cW0vMHpmMjk0?=
 =?utf-8?B?WmgwaGl4UzBTdzJJRWJIWUJwc3BzZVgxZmVnSG9WRmtMa0JzU1dGa0lvdXB0?=
 =?utf-8?B?VWNQOFl1elVsdmEwS2g3Q0RXUVFTMC9IYUhLUkZDV3ZEM1d1WE1CdU1WaUxn?=
 =?utf-8?B?ZUhkYkY3RnpNcDFJWUJrOCt0NlJKU29MOUo4T2EycFo2RytWdklNVGkvVHkv?=
 =?utf-8?B?ZVpLNmJ3YVFTSjlnYzlIL2h1Y3RBRldpNzJvYzBQYTd1cjRUaG1UYkhJS3RT?=
 =?utf-8?B?cWkxcVYyanhSSU1WM1NUaUtBVEpnV3dkYit4TXZjaXNjTDIyTXN6M0F3M292?=
 =?utf-8?B?OW9KcVpiaE1FcEhxNStmNkpDQ09PRU1UQ2VrbGJ5dWVma20rdW5MVjNrQVBO?=
 =?utf-8?B?T3NHTUZPVEZneU96Si9hQm4zN3J6d3hNRndrWnJvcGxtaXJ3NnI2VnRtb3ZT?=
 =?utf-8?B?anNZMnJ2VzJaY2s1YStYMW5MQ2pMSW9hNGhLWVNkN3NZaE5BVmdlaWl4d2tQ?=
 =?utf-8?B?VEU5anRYbG9SdEJHTzZQVzcyQm9HdXl6T2s3eGo2QWJxeDR2QlhkUHorWE1l?=
 =?utf-8?B?VVY4UEM3QUxIbzFqczNrTHhIQitweFgvOXgvVUJ5WmJiUER2Ri81dVM4WnQx?=
 =?utf-8?B?WmVwQmxTdk1LeTFRdFRWNUs2QTYwWmZKQUp0OWR1TmthcTd5RmtUQ2NBMnRS?=
 =?utf-8?B?U1AyKzF4MjlsaFNTeGZmbmhXMjRyaW5FVFE5clRWVm1pbW5Ld1ZJRDFwSkZm?=
 =?utf-8?B?TTg4NzRsYnA0OFppcmxmM001U005THlDSnduY2M0cGFjeVJ0TmlNWGljMTJo?=
 =?utf-8?B?MjJQS0JkZGdLeG03RHdUNkV5eHIxbFZ1T2VMTTJGaWYrNHIzNnpuclBkazJW?=
 =?utf-8?B?SnpzOE5hdm9qRkpuU3ZIS0VzWkFmMFRlZjJVUENrZGlmRjByWXZyMFVPOFRE?=
 =?utf-8?B?UmxleHRhWmorQVJDN2NycGtjVDhtUmV1Kzd3UUVlTDJJelFWeThYQ0JRa1g3?=
 =?utf-8?B?UmphdWJZMXZlNzI0enVrNDF1eDA3dHR0THJxcHpkdnliNDBReUZNakR1OXg4?=
 =?utf-8?B?NTBlbndScEI2YndQdDBmVW1URmpQTFhYNnFVbTRIaTJHL0Z2MDlvWmhXZmJB?=
 =?utf-8?B?VnRnUzRqYnVmVXpCRjg4TEhyK1ZNNWdSd3JZN0FzVmpIWnNaVmJ5SjRQVDdU?=
 =?utf-8?B?M1g5b3lYSXBET1RnbUtrc3NZZVdFckxBc3ZwUE55Qjd4YmdFOWdKalFOTG1Z?=
 =?utf-8?B?b2g5ZU03NHJJcDE2ekRGQ3VGVDhkNWVCblFmYnR2eXJteTE5QU5pWWxrZ1RK?=
 =?utf-8?B?d3d5L1JDL0FHNnpab20yVUxjZWszQmN6OVMyYXl2bHdqSWVHdnZ1OUVUSEhX?=
 =?utf-8?B?V1J4bC9hcHdkeDl1WDN4MDkwelE2b2J6L2IwV3pFczF0MzFTazRabFRuSGZL?=
 =?utf-8?B?TlF2UnQ1L0JUL0VEaWV6THZHV3ZPVmFlNE1ld3hPZEx6TGF3TlZCVWNDZ3lS?=
 =?utf-8?B?cW5JdGMyUFNlazM4L0lxVGlGTGpoY1hHc3hoenlzZFBnRDBBSXpySmlBUWRC?=
 =?utf-8?B?c2FLWkRNT2Z6MFo2ZFYxQzNEcnlxaE9LSEYyMHBwNVdDZFVUdGdraTRUM2s1?=
 =?utf-8?B?OWVBUUIvdkorY09CK0VlUVhoUVpieUJhc1ByVTc1OFBUQVZNY3h4WU9acjVN?=
 =?utf-8?B?UmZyTWNiR1U5YUxtUmhiYWE3dXRPZTQ1Z1hlVDltcDBGRWJpVGxMZnM5aXRW?=
 =?utf-8?B?VGtUTXNxYjJ2dm5Ec2ZWOUJIL2o3L2ZYckVsbHlmZVFka0RUR2lvWkNNbWZn?=
 =?utf-8?B?aEVPL05iT1N5dnB4cEsvREtETmFsdFhyQjlUTTUvSnZBc1ZQVUVHYUdOMEhR?=
 =?utf-8?B?bGxhK3ErTEs1eVl1SEU0VzYrWVZkODVMWVpZRkxCMnFhYzBXVnFrdSsyVUw4?=
 =?utf-8?B?aGRsU0lhNUNXb0ZicWZ4WmhCMlRwMGFwdHJUS2hsZWxDSERWWVJDeWpSZTU0?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e808d8e0-f66f-4712-404c-08dcd8c66fc1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:16:37.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw9MkDfkAsJ9ekNNkY63w2Vx4wkRz1DOSt7PNJQFWq9wzvHCC7VN+JMJjC4L3TS6Z57R4gK4MkKhI+Ki2lXS3aFv24C2OZQojr8Ni6YlyZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 795fe91a8feb..6a792f06f5ce 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1229,6 +1229,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			mbm_local_event.configurable = true;
>  			mbm_config_rftype_init("mbm_local_bytes_config");
>  		}
> +
> +		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
> +			r->mon.mbm_cntr_assignable = true;
> +			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
> +			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;

This should use GENMASK()

Reinette


