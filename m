Return-Path: <linux-kernel+bounces-214198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1590811F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E373F283052
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20E1822F8;
	Fri, 14 Jun 2024 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHiOYs6E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F03211;
	Fri, 14 Jun 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329925; cv=fail; b=pbRP1Ee+QtCrHNJUCZh3KwXWvWLRG6+bgqE6ylFM4tRIFay17LYnCbbKUvol+yg7KKYiqB4h1wOHeZ1AtN9SC46tQo2IpNaC/L4GZTbGOKMgQ9zIOsHlKasAXpNItyt0MHqtVPb2/CibvB3OuZD8YZccgmNFMdM0qkXMP7jYV7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329925; c=relaxed/simple;
	bh=CfMHkOl287WexE22iQ4ATFoUqcofrA98rlQAzWWnImM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sYiCSLlmZ0wrBAUfOnwcX5OwMCXKI+EtkJiCH4VyJ6RDvqag2LMU9ZYhUqXp5K/x9CsfxV8OzvTf8Qs+kR/mbJuutYI6OLocvEWJlSTLSQFvTtn1wI3fSBNYC6dUUnStjCoSj2948QdnZBBkRB/gw++4kavJN3XaoTqXh34CA0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHiOYs6E; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329924; x=1749865924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CfMHkOl287WexE22iQ4ATFoUqcofrA98rlQAzWWnImM=;
  b=GHiOYs6EjmmvXnvXq4S3X5QON4V57HSKraARD6A7qMFfGWoY9Ots9PLW
   hCE78769JUBKL/A4NTk4dDn0beR8LmQ4s7LZpwSR1nis91ieZjWe1t91S
   Np93JVyX9M68o5Sb0qxQPt5i42JQ9K8sSzZ9aMia0H0LKzAQBdUTu6ckn
   zsy0lx9ONq5LcKltgjPz0ox6Aes5MWcHW0YxI3Zhh7fH6NbvYbMkR1nSI
   LZ7/3Rnb09bSSjxGc28iwyf8OMjpFfaoPu2CgQOVUhxehfnXEeGz8g9Nq
   shWUl9I+r4ASFyjtrVPBLcu5vApokpnV1NHsvkC5mp/kMg5asR9eBT6pV
   A==;
X-CSE-ConnectionGUID: FgTGpFEcRgutMug89RnhIQ==
X-CSE-MsgGUID: JC+Rr71jSLqiXgodpB0AWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="19023055"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="19023055"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:52:03 -0700
X-CSE-ConnectionGUID: VwduZPryT9axAyhiAl4aHA==
X-CSE-MsgGUID: zSf2+90DTECjdN+gRUcijQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40271497"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:52:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:52:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:52:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs0yEMuxfQoWTRLXkLueTGevalxkoCQ9h2K0LZMObD5ZfkbswRL1KWQVSariuoH/OcfMhTEHrtAMU9GluPo/DLiuqiRUeOIoKPoMlfCaTnnXtZg+9hJFIWoCluFDHqEa7SqrQ2KpPbVxsjAJDW35C8Fy3Oc0U+olqEXMyMaEmYxcdcQCirh6g7+7593adYtLxUiYnEi/cLsiaW/8Cj1XzK2vlpDrPZCfZApguiqiE9oRG/CX5pc4sEOV7UeWxC4PBuCx3RhOiN/g+OOkwCl1JwNdhCZrwUJL0KMlodd7v3XC0oOYJPhPec3vCo6IT09rZLKz5O8httxiRpTxAbeq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5vgGfasXa12ePB/UhzmZDdpHHHJ4spfmu6wwZ1NF4g=;
 b=bMDMduISpKj6SgVokqTnwv63dygG2uPFBauUuE9lvuVG9765j90WSGda4KLhSuekvdUuAkeTAz2kCzZzwiqvrxqSwGpsb0QGU3+/V8zglqfXIqVQBy09JLL3E54c02Aqr6acuwPODg04MKJBS0guYpK4hELff0OUCY4vItI11zQ7AmmncQUCXUIL6cHEhokI6gAjoswpd7DnimRi/71JvQt0ceQCnwrqGRCwG3eKTdoiU6vpuokZilBtg2TVFAlPw+EyEkU421tDUvqpuI2sb45N0PkNh9LbSWPW3UZuItuVoH9IJPbXLzUI2u4KOPQblLN0PA9OIQS1le8nZFQvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 01:51:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:51:54 +0000
Message-ID: <9141ea08-5109-4c61-880b-a5136405878e@intel.com>
Date: Thu, 13 Jun 2024 18:51:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] x86/resctrl: Introduce the interface switch
 between ABMC and mbm_legacy
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <0148e3317b0de3b5d1eaa58af37a2910783a69c9.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0148e3317b0de3b5d1eaa58af37a2910783a69c9.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:303:dd::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: fa943014-75dd-4ecc-d2d4-08dc8c149113
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2k3OVBWZ2lNMENQK2trc092a0pYb0FSUXU3eFA5L0hBNUx2TmNnUVBzaGx1?=
 =?utf-8?B?VW4vc1RWUms2dk16Nm43cFFENWFUYk9rSGs5bWxCVTZnRUtFOGhUZlNCVFB6?=
 =?utf-8?B?U2twN0VYeXZOeTdpY1dLMTZIUXdacjNrYnRDTWpIeWJoYndvbXFJaXR0OWxB?=
 =?utf-8?B?ZlFZWWc4Q09FVStUT2dxVmlUcjhnNHhMS0p1ZS9kMlVwWXlWMnJVaEdpVkZP?=
 =?utf-8?B?eEFQLzVYbHdNekNGUGc2aVV1RGREMnJrV2xsTkhvakJadUUwamhKSGRHTGdB?=
 =?utf-8?B?ZzBBVnZTY1Vrb01ZcW05UVFCUEFkdWJlL00ybnR5WjFUdGpUbVQ4YnhGZ0pI?=
 =?utf-8?B?RnJkUGNxb09GdmRQblhpcVg1U2JIUlE5dElWeDhXajBUcTBTTkFKdDZVZjc0?=
 =?utf-8?B?K3laU2Z0UHpqVFVUcGx6MTUxcnhvQmRnZVZtVzh6RXl6ZmxtdWNhUnBva2th?=
 =?utf-8?B?YTBTQXF6MmdGVi9pUmJmTmxJcVBCT28yRjgrd1hWV2pDMTFrSXMwWlVjWWNn?=
 =?utf-8?B?WkVJTm91RGJwcXFkRzRhMHFVT25KNXlnVGp2KzRVVjN2OHlNNkVUR01NdjZl?=
 =?utf-8?B?M1NqNzV2cFNPQTNBbFF4dEJGejl4Q3hZc2Y3dTFjbEhsZUdkUGptM21rSEdO?=
 =?utf-8?B?cmtJeTVJNGkrNG9pQWJncUdiSTUveGJvcXQvVHdhQmZBektQVVc3WTBVWWRa?=
 =?utf-8?B?TlFoY2M1cWxjUzcxQVh6cjBjeWxKNGE2Q2Z1RThWZHkrQmtUakNHQ0Y1UlZm?=
 =?utf-8?B?T2w1U25IWVRhM1FLaVhPak00L1lIMjBySGRKcForME4wcVhaQzY2SDlGMUtV?=
 =?utf-8?B?U1k0ZFAxT3dIdm4xeHNuQ2JsOXRCZWJONHhXSTA2RDc4MXlxRmpHbFNnWGp1?=
 =?utf-8?B?N3hTZC9xMS9USzg4OGE1MitzcjVQbFl3NnVzTnVHLzZ2Y1RrQjNncDZuWElD?=
 =?utf-8?B?S2xOdzdOL0s5dGxjQUVsYkt6alRTOS9aN1J2OWJzeVV4R1EyMlIvelBWN3Rv?=
 =?utf-8?B?T3lwM2tWTzBnS3h0RE96R1gxeHo4WHFvN1ZCZkdrQ1VPbG5LcVdUeEJDOWV6?=
 =?utf-8?B?QyttTCt6cVhYZEtDaEk5WmN5TDZiQTlIY29JYUZIOTJvYlh1V1lXM3NicDZY?=
 =?utf-8?B?RThJenpLd2U1dTRlWHhEQXoyb3NYb3BxTzN2eTZjWHdMZ0RZTXlGVkdRa1hs?=
 =?utf-8?B?NW0rM2hadktzTmtJUzJoMWMvK1JneVJ4cWovc2VzZXZGd1dJQkJRVnNCRThm?=
 =?utf-8?B?RkJQbFlxOHZlM0tndzFjUFBRQ3laRFhWV1JqZ3RocVpERjhNTG91QXlOMVRw?=
 =?utf-8?B?N3graDVlT2JXc2M2cnYyS1VlMlFtNVp5Y3VKV2VWYXN6YTV1L0FVUENmZm1v?=
 =?utf-8?B?OEF1dVBkQmk1UFFGc3JRUmRkd2I2ZnNHRWN5WHV2YnRvQmdCamhzU01tNXlW?=
 =?utf-8?B?YmthVjM0V2pFRXlTMWY0OCt4MlZTN0VwTm1QZmgzcjdFS1NMdkE5Rjc3ajVQ?=
 =?utf-8?B?TzQzK1JQOHZyYkd2YzUyemRldTNoYkNsazZSdTVXMXR3dFh4ekR5Mm9jNjVI?=
 =?utf-8?B?TC9qTVkzQlhWYU94ZTcxbjdCSkk3b0YrOW1LaTZXdE92NlFValFpV0dxZDV6?=
 =?utf-8?B?K2grYXp0VnlkOTBqZVJhblN4TCtJT3c3RkFobjY3UGxKd0JsNXo5N3dsSmla?=
 =?utf-8?B?eERDVnEveTZKbGwycHBwQXlDbmZIa0pMSklJZHAvYktNYjJQdHlBeU1HejdQ?=
 =?utf-8?Q?fBefEyDlJXtsONBbYA+PrSOx+dStrkGm/qPoIAn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JieHVva2FDREpFc1lmcEpkcFpERkRUV01ZbGhBYllMbDlLRmt3cm0vZ3c3?=
 =?utf-8?B?NXZMcHlxckM0VmNzcTZsWVc4dmUxLzJKZW5hY3lLV2NjZFROb01OT2JzczJI?=
 =?utf-8?B?enRxL3ZocXZyeEUyajRLWlFNWjkvUVZMRUtadG5LNUFHRW1qakJkR3NieG5D?=
 =?utf-8?B?QkhxckZhaksrbnYzS1JuSUdwWlo1emhQMzl1OTdFRjdGN3BsQ1BRQlRLbGwx?=
 =?utf-8?B?ek1UOXBFZHhuVFVpMTJKdFZscVVUN1ZvMkoxWGFuNWJhOXFvNk00aGlJcUFy?=
 =?utf-8?B?UEJ1ckQ1cXUvT0FZZkI3WCtsYUc0UjVQSFhRbUhvdkQrVE05bWpzRVRjOFBm?=
 =?utf-8?B?TTVPdFNmWnE1L0tHeTJMZElpZzhLNWFXZTg1QzRxL24rN2dkWGRjNWh6MWZv?=
 =?utf-8?B?Y2Ewdk5iRkxodTI3dzBNaG9hd2EyYzAyV0N6SUNXUlJrUmVBZGUva0lhZjZT?=
 =?utf-8?B?bzAwVmNJTzhBTVhNeXdtMkxlc1d4YVVKVk9nRnU0U3BFVzRNSGlEeGV4QnJU?=
 =?utf-8?B?LzZiRm1HOXBJSTdtTVJRcTdPVndzdlpNUTJDTWdqdGtxZUV6eTFySDVHVy93?=
 =?utf-8?B?c1RobkZKZU1MVmUwS2RxRkorMzAyNUJyQmRjeStYSVByU2d0UVBIWnVYRUpp?=
 =?utf-8?B?dUJhbE9BT0g2TTRtc3l1UU5TK2VJekh4K3R5WnlOVlQrOHdsTW5nczVuZkRF?=
 =?utf-8?B?TkNaMklOTWplcnJlMzJibHFWRDRSY3lSTi8zV3NkMTVDQUswMWRPRE4xZXlU?=
 =?utf-8?B?U0ZhbUJLdTBQOWlLQnBHNk9Ha1Jpd1hoVHN0Ykl0Njc4alE1ck9GcDNZdTg5?=
 =?utf-8?B?b29qekJ1M1FWWisrYm15VlltMk0rdUFGVUxqRDMra0s5c2xRMjdZVGNPMUJZ?=
 =?utf-8?B?bTVLc3FTNGpnSmdicHhGbWMxYllUUnhGZGJaWTlhOVQvZmpwVWdRUlBVWDM1?=
 =?utf-8?B?OVNwSTVRQUpxK05PRmFXd3k0Zm16ZjE2U3ErSEt4SEIxak1CN2VubW9aTXBq?=
 =?utf-8?B?VjkrZmMzdCtnTUh0RDVYbWprdFl6aGpvNnNsOXNGZWg3QkVGZGpUcWRJMDM3?=
 =?utf-8?B?aURjWWlFayttUWpVdS9LcG9Oam5BWkJOd3VLRXY2ajRFSTZBZTlxZG5Bb3li?=
 =?utf-8?B?V29wVmR0MEk0TDdrb0lMY0NsK1IwWjZIcW1kNHFsViswSVJIbDRweHRaUWR5?=
 =?utf-8?B?RHQ3VEZ3cFZEVXlLZ01qWVhiQ05NaWVGZmgwVGRaMVpXK0tvSXUvSEtZZWVZ?=
 =?utf-8?B?UmRVTzkycTR3aE1XQ1Raa3UxV0Q0V3dMY0kzMWhZWmEzaWZBTkFYMG5zV2Jm?=
 =?utf-8?B?TjM5OFFrN1JwWVdPOWY5VVM3cUprNTFSME9HSi8ySHVRbWUwRlVzRVUyOUk1?=
 =?utf-8?B?UHV1clRHOEUrSnlBc2NCN1NGSzdHZlBqY3oxQlRnWTg3NTBTdUdLOEhvbDcw?=
 =?utf-8?B?OGd5ODF0aGdkZ3B2aDJ1eEtjaHBndEppRzV5N0xLakxOc3o3Q3JjeFRaMUMv?=
 =?utf-8?B?bnlQTVRFOXNEQkx4SjB6WkEzejB2T1BYNkJZeUpxOHhxS3AvYU5OcDFxcmg4?=
 =?utf-8?B?cDZCOGJRVUIwS0VpVytZWmlLOUY2MWlkbW44c2FFekg2ZWp3TEVVUnkvems0?=
 =?utf-8?B?ekhBMUxkNXBCVFI2cUx2STJZaWoycGsvMVFlMXRIbmQyNTlZZkJKOUNNSWoy?=
 =?utf-8?B?YnBtTW9sc1ViV25vT0M4WlJIRHZmUEsxWWpTczhTNGgvUFVvK3dHNzkzd3BU?=
 =?utf-8?B?RlVkTGFJL1NBUVRvb3Y2N3BSUkRobGxrNzV2SmFranJaMUVVWTB5KzhpSlZF?=
 =?utf-8?B?eUtWQUNSY0phQSs5VlJEVVNsa0N6ckgwRU5NdmNaZ3lQcEg2YzRJMTRITW9n?=
 =?utf-8?B?UHJPbi9HLzBIVTg5VVNYV1dNV0kyWFFiektKWlpOOXFoMWZSUmhnQ1pQWHpV?=
 =?utf-8?B?Y3dySm1iWkZKdjdaemZsMnBrT2ZuQktJaVBSWUVrRVk2cFBkbEZkRnNJVkU4?=
 =?utf-8?B?U2dmN1J1MlQ5UWl5UlZZSFBrL0pFK2dKQ0xiNVJIUGZIT2lwd0RHczNKUEdO?=
 =?utf-8?B?OTJRM0FPRTkxOGtFSTZ3YkdGOVAvL05aTElHaUd5c0FaOFdrZXRvRkZSSHRG?=
 =?utf-8?B?MGt4dGJ5a25yd3JqRkFIQlhyenZrYnVKWmlpRzNhWkhRd3JFNFdNc3hidkFi?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa943014-75dd-4ecc-d2d4-08dc8c149113
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:51:54.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFfnE7dV9FQtHnwgS0qV9/y1Oh4bjjkF90Pld/Pz8igwVoPjKfkHKmK5UndDEckplOVIB6ey8qK6i+fFwMgB+XNqOjGnarW+B9tcsN+R7yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> Introduce interface to switch between ABMC and legacy_mbm modes.

shortlog and first sentence of changelog do not match: mbm_legacy vs legacy_mbm?

> 
> By default ABMC is enabled on resctrl mount if the feature is available.
> However, user will have the option to go back to legacy_mbm if required.
> 
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign
> [abmc]
> mbm_legacy
> 
> To enable the legacy monitoring feature:
> $ echo  "mbm_legacy" > /sys/fs/resctrl/info/L3_MON/mbm_assign

Missing information about user visible impact to counters/events
and any mitigations needed in implementation.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Minor commit text changes. Keep the default to ABMC when supported.
> 
> v3: New patch to address the review comments from upstream.
> ---
>   Documentation/arch/x86/resctrl.rst     | 10 +++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 +++++++++++++++++++++++++-
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index ab3cde61a124..fd050d4d22cd 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -271,6 +271,16 @@ with the following files:
>   	  [abmc]
>   	  mbm_legacy
>   
> +	* To enable ABMC feature:
> +	  ::
> +
> +	    # echo  "abmc" > /sys/fs/resctrl/info/L3_MON/mbm_assign
> +
> +	* To enable the legacy monitoring feature:
> +	  ::
> +
> +	    # echo  "mbm_legacy" > /sys/fs/resctrl/info/L3_MON/mbm_assign
> +

No information about what the features are or what will happen on such a switch.

>   "max_threshold_occupancy":
>   		Read/write file provides the largest value (in
>   		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f452b6d9bb99..d77ff059269a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -908,6 +908,43 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
>   	return 0;
>   }
>   
> +/*
> + * rdtgroup_mode_write - Modify the resource group's mode

Comment does not match function name. Seems like "mode" is the generic term
to use instead of "assign".

> + */
> +static ssize_t rdtgroup_mbm_assign_write(struct kernfs_open_file *of,
> +					 char *buf, size_t nbytes,
> +					 loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret = 0;
> +
> +	if (!r->abmc_capable)
> +		return -EINVAL;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!strcmp(buf, "mbm_legacy"))
> +		resctrl_abmc_disable(RDT_RESOURCE_L3);
> +	else if (!strcmp(buf, "abmc"))
> +		ret = resctrl_abmc_enable(RDT_RESOURCE_L3);
> +	else
> +		ret = -EINVAL;
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -2087,9 +2124,10 @@ static struct rftype res_common_files[] = {
>   	},
>   	{
>   		.name		= "mbm_assign",
> -		.mode		= 0444,
> +		.mode		= 0644,
>   		.kf_ops		= &rdtgroup_kf_single_ops,
>   		.seq_show	= rdtgroup_mbm_assign_show,
> +		.write		= rdtgroup_mbm_assign_write,
>   	},
>   	{
>   		.name		= "cpus",


Reinette

