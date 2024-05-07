Return-Path: <linux-kernel+bounces-172152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC78BEE29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F5E1C20DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F3CB663;
	Tue,  7 May 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8HFEOkp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1AB65F;
	Tue,  7 May 2024 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113985; cv=fail; b=pt/dN9QlUeOYDR9CzFN1LaApNqiCEPaon3+yzUG44eOPoixABkcGGGlNNlxAq0Ez24WOO7qNMCygHteMKqSdezsQBVfluEB/BgB26/BS6eFT4gN3kfxBOytC1YlxAYjXjPiCHdcngfE4IZ19xPFCMK/2D46Ab124CnhKbIUdFyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113985; c=relaxed/simple;
	bh=R4KggQ/t+3x9b7qMONAhEnhJEgEvruJBnTY2cGf+mog=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F4BU3SZdvJMyQNoDIn6cA5TCyKNM4l1a9CqZvlbFv8AiJ+mKMKfGax66o9gD3IJ9UsgYJVspLH3+TTunLcmfealHX/pTWNaFTaVquyvG3Qe1i4gbkD59pg6XVtQJH+/ZakX7H4Snp1kDckyB0AAAMQg6j6AeQdngRs1PxTBonDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8HFEOkp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715113985; x=1746649985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R4KggQ/t+3x9b7qMONAhEnhJEgEvruJBnTY2cGf+mog=;
  b=j8HFEOkpSSC41lTHaCFRu96j09F8piwnBD4fQedTx9rKatiZrjcj+5ol
   inEKITiL00mcJxlePRNZjLf3+YI+LIP5M7GPWJuxcO8xhTCNTm6sifVHF
   oUWrCptnBmVm7z0OHiwvMKPmJTu9+nH7WF+AduEqYNOJoOzV0whQOc/gw
   UzU3+3BT3phEeKds9TATgaXIsZbpQ+8l0/+ROydiHzcEwtoBE6PqiwCT/
   k0WXUyLlvhG3li5NfZHwlQfU4z0e7iO5PXUV0VuZwOqWvmgtQ4DiSdgsJ
   lhhDowfF69S2Tpah8fM2WhA5as2rBB428+jUzoSUDDgHjsvF/ddOpyRN3
   A==;
X-CSE-ConnectionGUID: V862heAKQtiUzjGV0M4zbw==
X-CSE-MsgGUID: fCA2L2f/QLaoOCyfS0H9kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14729682"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="14729682"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:33:04 -0700
X-CSE-ConnectionGUID: r33i6XTPSMiFRC/iWHFJjA==
X-CSE-MsgGUID: dSbAIARgS8mQTsYZeeDQjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="59804929"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 13:33:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 13:33:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 13:33:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 13:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDRZ8s45OpXqUxcY5IW+3bPEiisx3q/MPcP+gL7SqcJfzeq2RhG2F3FW2yx6cR0x8l/D2ZihwltXZjqOA5/GzxLyL4/ggEVkCz/F0GjrkZdvHOqoPgqtX7iem84kbTQFefzgMKiRLoDYuAYJt1+IWVnPrndqAGOZd2ci/y77nugMHle7jFxT0PfyXjoWOvGG0TseTJ1eHO83CmzbSm6t6YEs7rTv4VdhdetDNUeGfSvRU7GCfDkC78Ey6SbxMLcgulChqyvUe0nXMo0jbDlsA6do8CRGk4YUWcoPF+FnA8yqjcJ4l2IBSdQiCcZxZD7rnwGYqPbJ2tbzxFzpKVcO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt+r7b9+eBqOqLj03H/Wk21GxJWILwjEvpce4sOIe6A=;
 b=B+y5jr/d15tHskqWpHnu5PwQULvH9YM8fTYb4j1hRMxYtfYU3V1EUZ6moSUUzdW5AgwwzZky49Yu3ScZNuBqs6OAoo6ONFw+4ooZ7fkCT79goIqU1sE52uSg//bsjhszBhNZF3ZUHD3G1vx5dbNhgJB3TFbArSXKg6FZKnqDkAa6lXpVV0j4oQSCPNmbhXX3zDsjNerh/DLsGNl04fTCYORi4biOVPFZtoyMbnu1SvDHp9HBAwlKvXn7Z6Jr8FloshU0n9QaOLyhxDDD1zPe+Usr5GCymZir0rr+J4umZvN7X6lTdKzl/RayxiVl3RdLfpQUykExm/1o/XJkkjFrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 20:32:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Tue, 7 May 2024
 20:32:59 +0000
Message-ID: <a873f6ba-904e-4317-b177-5645c3a8526d@intel.com>
Date: Tue, 7 May 2024 13:32:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <54b1fe8f-13e5-440b-bb36-4100c1d283d0@intel.com>
 <54ec73f9-6c9e-44f4-8ee9-a683bfcee607@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <54ec73f9-6c9e-44f4-8ee9-a683bfcee607@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 119fafb7-aa9e-4b94-9e21-08dc6ed4e28c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHpjRFJzK2I3Y2VmTks2bnZWUERaUG5WQnhsNTBCY3piWlNtN1VIVzAzUDA0?=
 =?utf-8?B?b3Q4NmxaK1pxWEF5Q1FkcWhVZ2NIaVh0eUplalBUTDZZbjduYUlvVzlCbEE3?=
 =?utf-8?B?NityL1NkRmdMMDdqYkVHekMvYmZlbWlkODhnWUZ4WVVKRkUwRHQ1czdIODNo?=
 =?utf-8?B?SUZWTXUwdU1nWW9kaTBsRWk1SXpaUWIrRmNSdFFEd1A4OUcyY0QzM2Q0NkhZ?=
 =?utf-8?B?dEU1bUlGWFU1T1dtZi9TTncxY2NzT2VJcDZMaWFPSXdKdjZkSDNHV1R4dUZn?=
 =?utf-8?B?Qnh3NjhKK0hnSG15QUI4Z3VzaVRsMG8rdENybENLVk9PbFRCMVpIamtzUEty?=
 =?utf-8?B?MkcrRUZTQ250czBMTUpscXoyTEpTMXNUNHVuR1dIOVQvZnpMeWVZUU55R21s?=
 =?utf-8?B?czl5N1ovM3NxZTVTVnYvRTZGbmNNWWVOMVlJS0x5ZWtnWXdzK3AzVlZuWC9J?=
 =?utf-8?B?SFlZTWw4ZUovdnVDTmJMR3Z0TjgyMGlVL25JRVNubXIwaTkrUG1sV295Sjd5?=
 =?utf-8?B?cW5xZFVWQ3dIUEJ1MnlrZzhXVjM0eC9VMDBEb2R2MXNoOHJZN2dGbnA5RjhL?=
 =?utf-8?B?SmpsOWdVL09rWWQ1ZTNjMG1qaVBlcTc4Z1dBL2E0QWV1QmVzN0FtSXlySjU5?=
 =?utf-8?B?N25pd1l6Sm0zWHVuU3FMZzVPYnk0akpsaDFhaFUxVW95dFBiSStKRXpIazNu?=
 =?utf-8?B?a0Ezcy9jK3p0bzE3dURzcW9KcGg0Q29PaVowQy9SL2cwc2VnU1IvZ1NzMjZE?=
 =?utf-8?B?RVVDaEdselpGWnFLYzUrblJRdWsrUTFhVmhtL1U3dmJhY3cxRTgwUk9rVk1l?=
 =?utf-8?B?emlaMG5TRWlSd3pIanNjYm5sdy9UTHBRZjRWMHJ0cFpPSU5SN0VlRXRSTDc5?=
 =?utf-8?B?MW15b1EydFN4VGIwSUZqRklHVkxOTXZ6UGtVbVBob3JYQ3NVZ3RzUFY2N002?=
 =?utf-8?B?dkRkdUtxR0RuWDRncWZycVdBVDV6bm43YXNndThETWRna0xITDNBTTIwUHRx?=
 =?utf-8?B?TG5yYlUyNHFLbm1sTWFnOTBmeUIrY0NHS0JmUjFiNVpKMUEvVFpNdVJmdUE3?=
 =?utf-8?B?NFRWdXZ6QmxGdDdWdk5KVmpwbWpYM1VBV2RVYTZLQUZiVEtmRzNvQ2ZXbE1E?=
 =?utf-8?B?SzNqRzFvNVkvdy9tSmV4TDlRcWtSQVFta2pVQzUxUVR5c0J4MnEyOUloTWcw?=
 =?utf-8?B?NEtqR2J1Z1dCR09iVStGaEtiZ25QR3VocDRrR0wzVUZPRDNKU28rUGlVc1NZ?=
 =?utf-8?B?SWJhdkxVa3dYTzBlSGFPUVZCNU16dFRNWjh4S2NvTDdsNGhBNXJWUm5Td3lQ?=
 =?utf-8?B?RVoyTHk3ZkI5ZzNTUUhycytJd1YvWFJseGJ6UDE3NFc2Q2Vna2ZYUlgvWmRp?=
 =?utf-8?B?bVMrcXJVY3RERzg0U1NxT1duSk5oT3Q3V3NsUlN3cGZaYnBsVWJ5UTRWRUFw?=
 =?utf-8?B?ZHdrck5LNWdoa0Y0a0NhYkZNM0oraGhkai9XR3VhNEZqejhxTDNDSU9JcTJt?=
 =?utf-8?B?WklWTk4wY2VWcmNBMWZ5Qm05VzNNUWJ5TjZJay9PeTFzRmhCcnJLYW1HS0ov?=
 =?utf-8?B?UFBna1ExRTlmdXorYVJ6VDRrZmN0VytwTVBoSTNEVEJ5a3J0UllYQzhydTEy?=
 =?utf-8?B?QXJxWmZwNDNIVHBDRUxVRVp3L3JYb1VVSzB6RVo5TllJR1BFRTdUT3Bwa2dL?=
 =?utf-8?B?YVAwWC8reC92TTV2alJwL3FhUkRNbG9RTFh4RXJGMUVNVU5lMnpXbGhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NqbEFWZlYzYjB3eityd1VPQmxxckNJdHl3ZUgrOExnU0Vwa1hudGpGVjIz?=
 =?utf-8?B?WDN0Z3NHeWVEVVJSNVBJZjVmZmtyZk5qb3dXU1J2UUFqTkFNQ0czeDl4UjAr?=
 =?utf-8?B?WVkreW1DN0JCOGR5cjZtNTJxSmtreFR0TmoySSt4a1lIbGdpQS9TL2kvcGV4?=
 =?utf-8?B?dURJUFFRRGYwcWg0NGhweFdyR1kraUJGYzQ0VnRwWmJDMkFnNFFNMEpvSkNB?=
 =?utf-8?B?eFlSdkhkUVp2ZGVjUm5ucmd5VXJpQUZjdTNlbEgvYkhwRXdGRWdEcUpaQUZl?=
 =?utf-8?B?RU9VOUVmRjBIN3JtTi9paGdCeHNuSUJIOXNlYXRtMXhyZ3AwZWd2NVdrR3A2?=
 =?utf-8?B?cHVKU2o3NW9MWndicExISVA1NEJ3OFBQN3JkdkxaVHFNM294YUNDMjJsRVFw?=
 =?utf-8?B?azcrbkFsZ0VMbnc3bXA1TmZJa05aSStRR2hrTEZydW44VkMrdkUrdUFkbDlv?=
 =?utf-8?B?TDQrdVhOc0txRGl1RXh4bkh2czZsam40cXIzN3NvdXo1UXU0ekFRMUpoM0g0?=
 =?utf-8?B?NkdYMWxmL0hpN3R2MzIreHR2TkdNaThXL0RQbmMwRVBuVU1ONUkvNThObWcr?=
 =?utf-8?B?cllYQVIwNEVRWXVFd2lXV0Fkb3VHbzNEemw4Y3FJL1NrYjFxWGl6dm1TNkdh?=
 =?utf-8?B?amhGNGl4MDYyR0N3U0l0Tzh4bVJBMy8zby8vYmtnc3E2UU82MlFZUzRuT3dz?=
 =?utf-8?B?aERvK0ZZSUVtRjJkSjRYQ3RQZWhYLzlDM3pxQ1ZFeGZGbVpNbTArTzRjM2d2?=
 =?utf-8?B?NjE3dTdFaFQ2dTh4dG11NXJzNGNEQ3Mvcy94VFYrTzc4UlVRWDdEL3ZSRlJQ?=
 =?utf-8?B?TDIzZVdSVy9tZW1BU3djUnJXU0JmUlFsbWR0ZTU3Slh5MlhTWFJrS2I4V21n?=
 =?utf-8?B?a3ZQOEt2bzZXSVBiOUtXUWNGRkVjZEhmdTAxRzhxQ2tSL0wzWld4OTdKTmtQ?=
 =?utf-8?B?S2MwbzZxdHhyRTRLTkdkR2VTUXlOMGJEYWwrVmE4SkxNS3VXMS9LMzZIRVVB?=
 =?utf-8?B?SklMckJjdXVrUDduR2p1R1d4M0Q1dnplczQ0M0MwdUI1SUdZNm5NOXZoN1N3?=
 =?utf-8?B?eDdVa1VQdDA0MXdLM1IvcmpiTlR1eHNRcVo1NkIxYlZiNFAxNHVEc0xkMVl1?=
 =?utf-8?B?WlI5MzIwSzRhcGRlMHJveWhkWUtrcTlENlZRN2RQQlNQT1lNUmZ1NzdUUjl1?=
 =?utf-8?B?bUxrc0oyeUZ3VGtHQVRCenpyTlhhTHBlL0tYTHBBQ1lsT3VocFZSVnl5STkx?=
 =?utf-8?B?ME44WmdoVlN0WGtrZnRHcHlNNmdFQTQ1M1dQQzFTUGl4azZydnJZd0gyVWIr?=
 =?utf-8?B?TFZsVWZpVjdFTEN1TkhOWGM1aERXVjVuZjBrSjEzSklaOXN1ZU4zWUZ0UXIw?=
 =?utf-8?B?SDVUNUc5R25kYisvalhiOWZlZzFBSDZCQ05qaXlQVFlOcUVaWXh6ZVFHUlp2?=
 =?utf-8?B?ZkRsWDlLRFNzb3ZGM0orVWdqMVFjNzdBZ1BpQTJhSUJBMWtOSlFRWW96Z0VG?=
 =?utf-8?B?S2JCMEdVTnFrN3hYQmJzS3F2ZzBzR1I4S3BoZVF2dGp2M1lnSWpWd0ZQWmxG?=
 =?utf-8?B?VVZYY3E1ZkxNYlFQc1dRempyUlUvQVZxRjl4ZHpmZFpqaGJLT1hxYU1iZ2hv?=
 =?utf-8?B?MDJhSUIwQzNtQzFqNlBxVlV2Y2diNG1KQ2xHeGxFa1FoZmRseWFSZTFWVUJL?=
 =?utf-8?B?QVd6Yy95cy9XUi9OOW43ZHp6dlZOYnVnSUNLSGVLamcrSFNOTHk3TlRBYVZl?=
 =?utf-8?B?c2E4dHFETjFyVmY4Y1hHYndUT29Ua0N6TFVMbXd6OEx0WkVFa29TTE1LQWhM?=
 =?utf-8?B?VkNXWmorZ1VJd0tRRnZ4N1lIYTJKV0huaVk4WWtNOGRwZWhSTTZNNDFVdEpF?=
 =?utf-8?B?K0kxbmdGVUVQQS9mWHFQY21hYWY1QzV6d1p4RVFrWXlvL2MvejU1ZEZRRXp2?=
 =?utf-8?B?QmQ2UHdTZmRVdjlCakhleUd4eEkzeDIxb0dKUU1jNGgzMkhIYjdsSWRFNkJR?=
 =?utf-8?B?SWYxNk5GSjd2VVI4ZUExQXM0YzhOL1Zpd0xMVnZaanpUUENSNGlEOXlXVXVN?=
 =?utf-8?B?ZzVTcVFTVFR0N3JaWnpFT24rUTcwejJzNDJHeHNXSnovd2lDZ1NyVm1CcDNy?=
 =?utf-8?B?cTdkWVRQVWtiZTFHaGVCYTBUeFBYdkNGZWEzNEFseFZCcWlPWE1UUFh1MXNK?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 119fafb7-aa9e-4b94-9e21-08dc6ed4e28c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:32:59.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynmdz5awc/0uq6UerEcTwFDD5xYL8YAMAVj8zzQaR609PkA0Qo/eJZr6yFaKFpjpvN2JKTJoaBDyYjfWnSjjfjmbKLPxswXotqADYXBgvjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-OriginatorOrg: intel.com

Hi Babu,

On 5/7/2024 12:12 PM, Moger, Babu wrote:
> On 5/3/24 18:30, Reinette Chatre wrote:
>> On 3/28/2024 6:06 PM, Babu Moger wrote:

..

>>>  /* MSR_IA32_VMX_MISC bits */
>>>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 722388621403..8238ee437369 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -96,6 +96,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>>  	return cpu;
>>>  }
>>>  
>>> +/* ABMC ENABLE */
>>
>> Can this comment be made more useful?
> 
> How about?
> /* Setting bit 0 in L3_QOS_EXT_CFG enables ABMC features */

Regarding "ABMC features" - are there several features connected to
"ABMC"?

> 
> Or I can remove it totally.
> 
>>

..

>>> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
>>> +{
>>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>>> +
>>> +	if (!hw_res->r_resctrl.mbm_assign_capable)
>>> +		return -EINVAL;
>>> +
>>> +	if (enable)
>>> +		return resctrl_abmc_enable(l);
>>> +
>>> +	resctrl_abmc_disable(l);
>>> +
>>> +	return 0;
>>> +}
>>
>> Why is resctrl_arch_set_abmc_enabled() necessary? It seem to add an unnecessary
>> layer of abstraction.
>>
> 
> I feel it is better to keep it that way. It is consistent with definition
> of resctrl_arch_set_cdp_enabled. It handles both enable and disable.
> Otherwise we have add those checks from the caller.

Caller needs to know anyway whether to provide "true" or "false" to this function ...
caller may as well just call the appropriate _enable()/_disable() variant, no?

Reinette

