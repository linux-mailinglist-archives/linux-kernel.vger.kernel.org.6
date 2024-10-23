Return-Path: <linux-kernel+bounces-378984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2239AD81F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41589283EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DAC1FEFD9;
	Wed, 23 Oct 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0QPPCC1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9319CD01
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724389; cv=fail; b=nU76oDkgi0tjn4r4k2Yf2Hb6uy/rE+33y/P19eKhPffdXulDtCtx5sqwFqhJkRIyfwkIncPBX1sbbFOLM0wDX9Nl6suRlLEciveQkaDv571SYXMbohDkQTRffemYkzXqpjZ7MuFDKioeNO3wu3eS8XNIdzCUN3gYcdbT0O7mkp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724389; c=relaxed/simple;
	bh=7WTAEsrByR08UHBoJFg3zg8xgOrbJ39HTWZezpBXStc=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tVaXasEu+I6ylbekwTlp5OtmsKycgQOnh/q1OuPtR3JsOBStTJEpHaNP/1O6dXQu2UF3v++k34Z+i4Q7QVOivsmlV+TUa0pRhCOZ6D/c4OQOZLuvIzuVjKjTvaqxJOKQE+OJmJPPzFs5Imtjmo541My2TZ9luJLl8XLWSLKrRhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0QPPCC1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729724387; x=1761260387;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7WTAEsrByR08UHBoJFg3zg8xgOrbJ39HTWZezpBXStc=;
  b=l0QPPCC1MZTZol1xfZbMFPTcA8Pt1g4yB1tsUf/CY/HrwDxIymZHwXXB
   ZgYxKGhGETLnxRES3rEaODSL5AES2Sbm8r+oab+IyR7ggQPZPJ0ECEjaI
   TDIrQAUjIJbS0e6r81QIDpcOw2j8foIbrlVi7Qr+fB7M3hCbxxUtpiJBV
   dWPghDKu4fpFrgRgJqWxKDcnslyJ2OqdwZuBCKeUmNkWWv4fDdYvUUcX8
   +z1+MPBTjUTnXdl8MKQ7Oo1LTEnbIGgh24RAj0CJRiFnpGQby0zWD0hjT
   lbaz4TwUoS5MGmvDZp3eR2en4Jl/KA0Gd00fX4TxQNosLXnozE9BwU2B/
   Q==;
X-CSE-ConnectionGUID: nmil7oRpR+y/2wRUAPko2A==
X-CSE-MsgGUID: yEwMHPbZSdGtmAzSH2qHBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29233307"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="29233307"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:59:46 -0700
X-CSE-ConnectionGUID: dYs9ig8qRUyMNl+LhXKVAQ==
X-CSE-MsgGUID: COYxOARMQ0GUr9Bgm5RJwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80322779"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 15:59:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 15:59:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 15:59:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 15:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBH++BTw/HbimSElIT5D3das4APkGaLFy9B87Q6KZRAZ3pgCMKWMFEuYO8U14JlUug9wqa+yqbmaS1+pptV0abQtFZLDaQoGo9A0E88nKe7RxK07bb6jiWk0zHhA9vV0eOgLkQ1pakFgziH+w+IQxYwkPjKKx28X19gA17ievckZwGJSIDvVevjo0ZSJEmqmNtSI/5aDYuvC5uD36IqRl7Tp8TOsO/jqlrKcHhCgej8Lje21k/Flvoz+vGvJf8ATmsa6y3tUOvoHkgVSrovCwVLBaXY/vhUgC4K01V/u+IxO/ohYe7CLpnSShDt29F9o3Y6vgUCajvhBARmTRBKJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKrn4NjRwFODJTjTKykCzYljtdhY5P2feeJGr3Odzsw=;
 b=aBBL7Dj1vQf/7wC6kQjb0Tcl/WPK/e5m39ncB8b+cNH1cS4s61/RKg3bSr3pi+fh9SnHyGLMKtOntzKiKT/6i+jFtXM01U6va7tpX5eELpYszDIftEeH389PCkEvfcHpAmkzZ5L/imSHK0YJVvIr4nsitZKzKsDHf6Wt2eU6MIY6uBH5c/1V8Op3preMIAfmtLHECkUg+Dcm+H3qz1/s4eon1gXvi+7xOPsrVykBlwHvWuzWD8mHEowdQOOZgC0wBzKjeTMDCL2rel35nYtkELbgqnS+xj2yBM7o6jL9V3gjt4GtzMsfrbBVvSpipLDzdHi6DSvm+zzxlX60SSyf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 22:59:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:59:41 +0000
Message-ID: <9ef7e709-7bc8-4bf5-b5b6-960e2eed5cfc@intel.com>
Date: Wed, 23 Oct 2024 15:59:38 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 27/40] x86/resctrl: Move thread_throttle_mode_init() to
 be managed by resctrl
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-28-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-28-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:907:1::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 95aca9ab-6602-4323-bcf1-08dcf3b6608b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0x4bUVSK3U3RUNEOUc0QzhOTXFNbk1vSERkTkpaR3FhRml1ZmdlWTY5bXgw?=
 =?utf-8?B?SXBoNWVTOGt3Qml2dlNrTU1Va0oyb2QvK1ZtMlJCWFRHU0FYTVpiN2JkazdU?=
 =?utf-8?B?K2dYcUZPMXluTTJMejcyTHVlcHlYMmhIZ2cwK0sxQWpqRzMxbUFSVG9ua0RS?=
 =?utf-8?B?MkJoN1BPVk8wYTgxN0Jvd3hQSDhrWUkrTnh2RTlaeC9kSWJsbk40UHZYYWl1?=
 =?utf-8?B?RFY0Y3JhaCtPVThSUmRGYUdoNUpVZnYxc1ZJNEtlaEtRWE5MSDRaV2phVElw?=
 =?utf-8?B?VXhvYTJaaXJRL0hXSzFmZlhYWjdPNjZYUmRrZG1odGNMVDZRRFFWZDJTQnc5?=
 =?utf-8?B?VXo4SktHaDNjc3ZxZkZqZDVJZFk2aHgwNE1LTU5jRFlGME5Ra1pxVG10KzBx?=
 =?utf-8?B?bU9VWnpsLzFnajZWdzNjZkNDS2t3NHFRTTFBU2JHb3JqMzhqYmlRbTBPK1B5?=
 =?utf-8?B?a21DdGcwZUZwVWtNTEt4cmRnZjk5SlgxNXp2bnovb3lNcWgrUHphdEVkWWJW?=
 =?utf-8?B?MVlrM1NLVGIzTTJ2MndZMXpGeDZkUi9qQnNzZCs3STZ6bTFJMm1IMXpveHdG?=
 =?utf-8?B?OWFJdUxSRnVBQndLUnIwM3p3TWlPSkFsWlg2dnRyZmNxdFBDMTRKNk85RGo4?=
 =?utf-8?B?T2xmbWNzN3MxZWtDVHhaNDVQWU5HOVNNY0QzeldLbmxlV1QyYUp5a3RiVXJY?=
 =?utf-8?B?eHBUVjBrYThHNWU4UUM2YnNvM2RjWGx3SHgvUWhRcGh2M1QrdHZpS29SQ1k2?=
 =?utf-8?B?V3lzTEhzb3pwSngvRjhqTDBhWUpnUW1PU2RvMkowYlVtRFRYRjBWb1ZYekxv?=
 =?utf-8?B?VUhXa2NCcWM5VjJtSG1oVXpvV3NmQS82VENiYXhvSktKTnpqMDhNNHRTbTNp?=
 =?utf-8?B?WVNmeDF2K2Ezak5WTDFkTHBDM0pqdktmWHJQWXNVWURJZXIxM2dwRTlFTjE4?=
 =?utf-8?B?aWhVclJLdGRWWjdzYTVxbXpXdFFhaGQzRGZ1STY3TEY3V3ZBY0R4THJNS0tU?=
 =?utf-8?B?L2FKNGZJdTZka0hYYjFyUXErdnBPQ3BhUytmUXdzNVk3RHpGQlBEUzdyQlJa?=
 =?utf-8?B?ZUxzbE9Xbml4SzRyRHFrcUVvVXFvbUFYVEdyb3pDeVB6QVFJUXdoZStYUGIz?=
 =?utf-8?B?YWtxSy9xeDVBUXJnV2xmSEI0dE0xampwTm9ZOXdUODZJaHpONmNaSjF0S1cv?=
 =?utf-8?B?czlHejhLSzBhNlgyYnZrVk9pY0NIM0NjOG1pM1BxZkhza0RrTUdUNFE2akVU?=
 =?utf-8?B?OCtvTFhkNk5EcFZaRkVpVDhqdndvdWdaNTRYYTNKYkFBOXNBeERKWm9ZVTVH?=
 =?utf-8?B?a3VsdVVuY3QwUERUbERha212ejNMTUdDV2VGc0xpejdnUTBWbkJwbXRNVkpM?=
 =?utf-8?B?NzNqSlBJSWR4MzhYZXQvR1FOaG5lczN4UjVseEdtV1d5MEM1ZnRlN3NnRzRO?=
 =?utf-8?B?VThqTFNqd2JOR05Lb0t3V3dRN0Q3TW1BUlQxL0xvVUFwZnI1RXJZZHFkWUVu?=
 =?utf-8?B?bDJvb08waG5HNHp0L0MxTGl5SWEvOFFwTEw2WDVmYWRGOXJZTWpZWEpMRjNz?=
 =?utf-8?B?YmUvSnl0cVgzRTN5TFR5L3pvN2Y5YWJGdTFBME5ZalI1TXI3QnpLcFc3Wmh3?=
 =?utf-8?B?UnR2bU9Dc2JIUHl4cVpER3BpcUpiWUNTZzRKSXBLS2dtMmtxU0hoR2JVK2sw?=
 =?utf-8?B?cGNQd1R1ZkRuZTIvVHJFZVVaTmNQYjQrdVd2UkdBUmZnWlpLeWRHTjJ3ZFZT?=
 =?utf-8?Q?H138+hXNveyW9W4YnZQxr+eD2fhYlHHXleWWVbE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNjdXZuaWZBdzVaZFhKNXZDUFp5Wmo3c3VXT2FxdWhNYmxibHJ6QWhaNHJS?=
 =?utf-8?B?dG41N3JuTjJKcWtwSzlpYS9CUWY2M3NuS3BuaEZna1JaWlFDTkVHS1RNM0dx?=
 =?utf-8?B?TGw2YUIvSy9KeW1pWW9HSW5XSTM4ajMrNHpxYkFKTExWWGl2OEVicDlCdGFX?=
 =?utf-8?B?WkpVQ3gvQ3JWRXRxYmQ5ekVqd05oMDUxVk5WWmYrS0lwbXd4YnVYenc4RDVI?=
 =?utf-8?B?U0hmSXdLeU5aeFppcEtLSTd5NFNRbEN6TWtDT0hnN0tCR1d6aGk5MVU3OHo5?=
 =?utf-8?B?L3FLQTlRM3g0Y2FKVlZUcWJFdkVrSDhoN2l6SEdNSmlwczNyekFFaHZRWVFN?=
 =?utf-8?B?eHRHQTFldDVLUnlaWUg0ZDN2a1JodUZlN3c0ejJReS90YnZTRzJnM2RPVnRD?=
 =?utf-8?B?RFJrOFVUVTR1UWlYU3Q0OUNRNmpSc3NpSUZ2RzBSSUFTbGF2ckFaSzQ4ZFlX?=
 =?utf-8?B?MHZGeUNiVjExajMyMVNzV1NhZFdUa09mNWVNWXExa0QyUXhpU0lOU0RDaXpo?=
 =?utf-8?B?Sit2TUZXcVN5MDc3cDNINGpSRWNlWGhleG9oc2xvcHF1V1RRY2x5YmM4ZG5R?=
 =?utf-8?B?NkVjblhJRUE5T1ZnTzVmeUliQzFSV3dEMXQzbDduVzZ0RFdpdWNxTEMySzFm?=
 =?utf-8?B?d21LcGtISVowb3V1S2FJT1BhTjh0Mm5uTi94UThJSzhZS3hRREo4UG5Ka3JK?=
 =?utf-8?B?cllnSyt5eUNOU1loaG9HYlgxakJSUlpqVVk5cm5YSnZFM0tyZmtkUTB4UjNB?=
 =?utf-8?B?V3BSVUIxNlZ6RnpmWEdzSjJlTy9TcW0rRnNyT2F5NVVUU1lZVkpFRlZZMXVU?=
 =?utf-8?B?UEZtYndxZnJWSXV2ODJ2clpaLzAvbno0SjNxcy9nVWdFSlY3RW9sYXEyMlNM?=
 =?utf-8?B?UWxzaHhtU040YXRRbXRmUnQwK3dxek92UWhhbU1IRzkrL0RnR2dwMXdKM1Ju?=
 =?utf-8?B?NU9OVkVzS2w2QWZNRS9HMGRXMnh3R2Z6YU9BTnp4RVNFdC9CVC95R1N0L0tT?=
 =?utf-8?B?bytWTWd5bytoNVdaVFc1UG9SQWpyUTZPS25laUpKaGl2cEh0MnVleHU3UlhF?=
 =?utf-8?B?Z1Q5WXYvK0MvVXhFZC9GMHplL1Q5THlFTDN5RGZBYXJYdnZhQm5UcTd0K3ZR?=
 =?utf-8?B?b1NDcXVhcU02MEhqQlFOU1hMQkVrZ1huYzlDYUx0OHlta0lzc2ttZFF1OVdZ?=
 =?utf-8?B?R1ZNUVZUZTZEMlNHSk1DcGp5U0R2QUd6bjYrTEZkRUhrTjh3ODdSYlNFMTd0?=
 =?utf-8?B?NENlVnlmNHRHRUZkbEFEWWc2UlU1SW5Xa04ydjFFR1JSNVJpY2NMbVJzOFdj?=
 =?utf-8?B?c1lwcjFDNnVQTEtiNnR3dkNRd0Fta0hHNTZmaTNFM2lBRWkzaXk5WkVNK2tw?=
 =?utf-8?B?WGZ6aTRPZ2EvdHFWaWpZcUFpMm5YYUhaWkJNODJRL1g2UkVacnRSb29qaExs?=
 =?utf-8?B?bk5wNUYwdEpoLzlKbTBpcU9vR3NJMUErVmpsRGw1K1grUGY2N1NkVHNteVpO?=
 =?utf-8?B?ZFVCUys0cjhUc0dvOGt3Nk5LOHYyclZZZEYxOUhvd2x0VnZTc2d6MmlVdWxS?=
 =?utf-8?B?OC9yQVpkN1NycWRpaldKQmpPeHI1OEhIOTBHNFZLMVo2a3oyeWVDS0hCQlRo?=
 =?utf-8?B?UEVWQllkTXJjTDlnZFAyNXhzTTczTlB5SjJKT2hWREVqQU5GcWIzR2JmcTRV?=
 =?utf-8?B?cnNKWmhZUDlvdUliTnQxQ1NDTWlrM2dUdjdFcWNQU2EycmxuS2lpVmMxR01q?=
 =?utf-8?B?bVJhREFpV3pEcnFHempqRThTNUl2ZHNEbWc2cjQ3OWZqdllUUzE2K1l2SlUz?=
 =?utf-8?B?eHdZanRjbndHVmdrZlpudkNqY25HVDZsbWJRYmlMRk9kT0J1L20weWhiS3Nk?=
 =?utf-8?B?aVVJK242NXlNL0wrSngyS0NjakhTUGxYelJrNlY0cDRURXFJQ01HU0VORlQy?=
 =?utf-8?B?VG5WSlZjYXZJbmxEYjdLM3ZlditJSGJnekZJWVdVZ3lwOWJwRUw2V1l0WEti?=
 =?utf-8?B?aVArbmVZSTNLZ1ZXVzAvaXZCM3dGZkgvLzFYQTZ2L0dOQmRoek1oNHR1OExp?=
 =?utf-8?B?MkhwRlFDY3JBRGQxd0tLV2lUdis2dGxiUWNTZUhvWmt2M3pXSEdzVEVlRERk?=
 =?utf-8?B?RFhobW9iZm5BUXpFQ1ppbDJnNUV4QjNFV2x6RTlKRjhBM2Fjd2dQc05uLzAy?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95aca9ab-6602-4323-bcf1-08dcf3b6608b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:59:41.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7y/TqcQ2/82kEfpESxN9/PjqoYA5w4LIElDIB4FClkgg0ibu963ysCnC+mKMXutc4CGXgUv1ii/XsYwPW68YAevMz/UJv5tXpj1bTqUM0Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> thread_throttle_mode_init() is called from the architecture specific code
> to make the 'thread_throttle_mode' file visible. The architecture specific
> code has already set the membw.throttle_mode in the rdt_resource.
> 
> This doesn't need to be specific to the architecture, the throttle_mode
> can be used by resctrl to determine if the 'thread_throttle_mode' file
> should be visible.
> 
> Call thread_throttle_mode_init() from resctrl_setup(), check the
> membw.throttle_mode on the MBA resource. This avoids publishing an
> extra function between the architecture and filesystem code.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 1 -
>  arch/x86/kernel/cpu/resctrl/internal.h | 1 -
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 9 ++++++++-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index b5ad1ed2a4de..0da7314195af 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -228,7 +228,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
>  		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
>  	else
>  		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
> -	thread_throttle_mode_init();
>  
>  	r->alloc_capable = true;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 9c08efb0e198..30de95e59129 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -495,7 +495,6 @@ void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_mon_domain *d);
>  void __check_limbo(struct rdt_mon_domain *d, bool force_free);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
> -void __init thread_throttle_mode_init(void);
>  void __init mbm_config_rftype_init(const char *config);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 3f10e6897daa..596f5f087834 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2048,10 +2048,15 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
>  	return NULL;
>  }
>  
> -void __init thread_throttle_mode_init(void)
> +static void __init thread_throttle_mode_init(void)
>  {
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  	struct rftype *rft;
>  
> +	if (!r->alloc_capable ||
> +	    r->membw.throttle_mode == THREAD_THROTTLE_UNDEFINED)
> +		return;
> +

The goal from the changelog is to make "thread_throttle_mode_init()" not be specific
to an architecture. It does so by checking the value of rdt_resource->resctrl_membw->membw_throttle_mode.
I thus expect that as part of being non-architectural it should check this for all
resources that initialize resctrl_membw, this includes RDT_RESOURCE_SMBA.

Reinette


