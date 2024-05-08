Return-Path: <linux-kernel+bounces-172556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588F8BF394
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D081C28790A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B538B;
	Wed,  8 May 2024 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe5k4DoD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EA364;
	Wed,  8 May 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127710; cv=fail; b=UvP5+tbaHksMcQk05Fu9ZbhrrTR3r7ifYMmo9gbetFbyO5eRdm3XoDguyYQqyg+Grex4FB0gzlk0sKYgP26e7GWMiGZb2F3t2ic6KTh5uA97H4YX0L6zXau6+epOuUXafNMIqgWt+YQwY7s+P9XqpPK1kmtDj9POR4PoMvT4nRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127710; c=relaxed/simple;
	bh=g2KGXpsW8+ChaLQb9HLai6K+JZpSD3YjuUsxKvaHLl8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dCeoDxO4n87/p/2Le3287jECUYnjnnEjmOb4i1O25Ej1r6EuddhsbBYX4j0T5UYZGh204itW2lCFQS0IJgdT36JoDF5IpEXKRCytd+M5knB6/fRGwbKlkuDdE7oEFqmCs7R2qsKybQ498iVv2+5e+uBRCtF1KOPJv/9OBMB5Eg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe5k4DoD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715127709; x=1746663709;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g2KGXpsW8+ChaLQb9HLai6K+JZpSD3YjuUsxKvaHLl8=;
  b=Fe5k4DoDpeBgqQmaMikKVVjF0p716QGb/YiJEhL4C3TzDyjJGcpgfy61
   Ydk9SDYE+myFWy9jBJnIwgnrWvctaUtLYDhok5AiujQajscL4P75IU+rm
   UncWqswEjMI0cOgkCytA6QT9uIhOK0ybSb7qf+o4wVPMSehqU38hs0aj9
   JLoqQH5RZrT3VjJelfqdBzUNdTkV5A54moKzgmoVNt7+zd5CSyDxdLiLr
   FwzLB4BAisuzbty3G+TBItH5reMfklgJKXAgzHTkhArRAlJL6rtrq7v+3
   +CwjTQh9GZHZ+n0ASwN+8GWeY/xta11eQKE4hUnRlN0/KzF0CqxqBYlbt
   A==;
X-CSE-ConnectionGUID: WiGv9BPjQg62N3YgAE+aXg==
X-CSE-MsgGUID: REal47H5Tk24z+qgcHkl4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21566424"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21566424"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:21:48 -0700
X-CSE-ConnectionGUID: PmiK1yuHQk+cDMo3EdtkTQ==
X-CSE-MsgGUID: X6m2nckjQBaGSnJN6RmAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="59548622"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 17:21:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:21:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:21:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 17:21:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 17:21:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABH3wLMtDqY16iZEMXIqOPMXL9Go8Ptza+elAt51VRpbr/Dt8xzwECvyLsepUZA3A65dQU7Tbbfy4kQ2Bp1TWJev7ShORZizd0B6CT978LgoMDAAfVXFD+AlM5XSt6ZybLSY4Jp8+mKt4BpgEZQrF10t1vDRXxKqm8IYLy7UPfw61Na0f0iKtvd0YqLBS+fYlc2oOU17BEpn+FbjrI6NmZ620U2uq+glI7sMp9PvqPZU2T8/BqVHCys0wYEBBqWVxaw2aigkEHRrQQFL7Lq5CNuwcZgWvMumPDTL/GJ0gSso9C1PPF8uxafguQYZScqNqdQbBRtG0keYLVcFFOrwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1dPXzcNE1fWQqE9WiFPfoabPMt9g8S6vwmszrU0Tgs=;
 b=mAVPHwqIjbm8gtXWGfdyfZPVHR3xfP3rvxN/9PVJVsJn7WBaDE7OFgIFXgzjVhRlK5oE8Ouk0B4CDAsyzqNF0gWG+agCiC4mJTzTZlMjmnnUvw5FupZHnovRrCLrOwsXMBIoTqNvDabLEtCu3B7BAbljuFQMoCwwtml5Mu14nHw1x0Y7mm0YjYHOkGjeC4WfvG/fdnqcZpFlNOrRBBLkr9NWdb3zXu44YQhJ95mLxMftunGdfb2m0FWGl+nP+i/VXvCYXCjb4xjCHJUO/e/GP4uL+Q4vdxa+Xq/7DAZE2L5t92/EVU6iKlrbWp14aMtYQ9tEkeIM3cAqpwFZca+PtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 00:21:45 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 00:21:45 +0000
Message-ID: <a81bea39-be24-4900-aa7d-fcf31891354b@intel.com>
Date: Tue, 7 May 2024 17:21:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] platform/x86/intel/ifs: Initialize AMX state for
 the scan test
To: Ashok Raj <ashok.raj@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tony.luck@intel.com>, <jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-3-chang.seok.bae@intel.com>
 <ZjrE+6UEhKFFYvBG@a4bf019067fa.jf.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ZjrE+6UEhKFFYvBG@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6993effd-2885-4103-d27c-08dc6ef4d7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUNNcmlxRmtpbHg1cWNEczQyTW1Ja04yVmFCbFFoZDB2b2NQNGR5eWhhajg0?=
 =?utf-8?B?Lzlna2hsWlJieWEwZG1jbzBXcU5xbXJvN05kNG8rK3FjQXFBb2xobFVpUnI4?=
 =?utf-8?B?MmQxNXZNMlpZb2psc2U2d3JyWkRNOEVYVFQvTG8zVlEvRStrL1VvWk5SYndY?=
 =?utf-8?B?a2w0RVFva3hoWTRvUCticFd5cWtDZHBpcVVwVDY0SU4zRjBaQVpSSG1iOXd1?=
 =?utf-8?B?bGpmaUoyRVlwMDRLb09JcWU3U2xPdFF1TVpHWlp4RzdSUlFCT0xlYlA3Ym03?=
 =?utf-8?B?SFlGL2Z5RFd2WFRJbEx5a3hROEpsSHJOR21Ja2RIOHgybnI1RXdUbGttTDBH?=
 =?utf-8?B?Y3lYa1hUUnZ5MVl0ckZ4YTRhbzdlakRVRHF2RjlxTFRueHZEZjV2U2V3ZTdQ?=
 =?utf-8?B?aHNjamo2V28zS2pNL1QxUFBiNDM1b2ZsTEJvWWhnT1dVdURZZml4aUxHY3FS?=
 =?utf-8?B?TGZSK2hiNkdDdWFiYUpsUHN3SElQam5mdEdkOVdBUlBNTzhOTTczdTBhTW9t?=
 =?utf-8?B?Z2tpVUNPVGw0NG1ZQjNjZGlXMlNERkhYYVFkN1ZRSkFDZzlmZ2FWNkpxWXhZ?=
 =?utf-8?B?aFVySkZvK3RPNEttdUVVcSt6RGJxeTQ0T2h6TFlJQXJXeDVuZE04ZTRSN3Bl?=
 =?utf-8?B?T0s4WUtnaWtMNG1TSVBNZHJ5ZGNMME16LzdmSUxEcjBsY2pyOHFYRnpISlUw?=
 =?utf-8?B?d0hOWk4xWk04S2hOVm5JWGlqd0kxWFd1WjZudmZqS2RTUXpCM1EvZ3Y2dTM0?=
 =?utf-8?B?V3JGUzdMWThacEpYREhsQ1pSSVJmdFVVU1gyaVphMjA1UGZPVnRNNXgyVm00?=
 =?utf-8?B?NUxDRUE1ZXY5eVVMNjJheFBSSlkvejRjZEFyU0RyUlR4RjRnN0c5NEpRNVpV?=
 =?utf-8?B?aGRtL3RaV1JOdjI1M3ZNMDNnRnVZU2sxRnBmT09QSE1WS0Q4R1ZMTDhxSDFj?=
 =?utf-8?B?S0l0SnAzVUI5TmhGUWVsK3FhVmEwNHdxNUNMU0s3c3A4NGgwZXdkTk53MUhv?=
 =?utf-8?B?V2tRbTk0SlhnYnAzaHU0WEU0Wi84VktIWWc3ZEZRNXZUV0NLSndjZTNKa1Vi?=
 =?utf-8?B?VUhnRklvblRKRVJSL2JlWEk5a3pWaUxsdHVTeXM2b3l5T1Z6WElBVWZYLzB2?=
 =?utf-8?B?Qy9HQUEvOUJmNW5WcWNIL0lrOVhhTGErSFIrMmxFUlB2Wm9pQVQ3K05DeFlE?=
 =?utf-8?B?QkRscVU4aWFhYlZSWkxCY3BIZ1JXUG82Q3hNc3pvTGk4U1VuNmc5Z3FhTFFX?=
 =?utf-8?B?M3BaVFdJUUh4eWJEWDdiaWJMU2dBSklrNWVPcVhXRTdGWTlvMENwRVUrbXNG?=
 =?utf-8?B?Z0VDT1dlalhsOWxFbnVPOFcrU0xMbzRnc3ZSdWNkaXNiVjZhdFNFT0tqU1Bm?=
 =?utf-8?B?UERDeHN4aFRrUkxlMGhRQVpycVdZWDRoZlZhWjYxM094eWJSK2tPWkdWSitE?=
 =?utf-8?B?eXBFeVBSdzd3OElRZys3clFOZ2xMTjh5VjZwTnFWb3QwazRSdFNHbEdFUWFh?=
 =?utf-8?B?NVZoSHRUUUhCTm5weW96SWR1a29UdjFkSk1wUXE1MXZHRUtKaWpUWFRwTlFv?=
 =?utf-8?B?ZnFPY2lzRHBjV3YzQVE2UkFDUjZtR0RJN0M3d29vRFNiVDhXNFhVa2dJVkUw?=
 =?utf-8?B?eTl5d09sdnhycHptOHAyVjVwb0NVMHNBVFNtenY5YWJoanNJaVZLUWFBaExK?=
 =?utf-8?B?Z2NPUm8yTWxhUSsyVnphZTkvMks5WXRaTTVKbVV0cFMwT3F0RkVSbVN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpFaFgxM2pDTXZVVVFYZXdaaGticDlyY0pFZ2wra3JLdjJISE93bll1cFNz?=
 =?utf-8?B?cm05Nm5hVnduMnpKUDdoWnRpSno3TVIzL0t2U0wycktsVi9qcnB0NG9WSlhD?=
 =?utf-8?B?aWZkWnRacTNPWHNHYlZiM2dJc2FSZnBzekRpa0dXVjNTSUFNSzN1ZnloWjh4?=
 =?utf-8?B?Yit3TmFZYXROWVRFakp4TkwwVmJ1Q2JrU293VzM0NHRDU0U4ejROZlF5d0s5?=
 =?utf-8?B?TWphb01qbnJ5cjQvcWkzdldoZjNnLzFEQ1VVVm9mSUZRM3lMbExUa1pJeVkx?=
 =?utf-8?B?QXlRZXZpNGVEMGRhWmpSa2FGWVZWaGl2NGFCMDFCWjZtbE5WamxOeHVPbnlO?=
 =?utf-8?B?UEF2U0I1OWcza2JvZ21XVUYrRUNzWUsyQnlrSWN2SllSNC9VZmYwbHlIdk5C?=
 =?utf-8?B?aVJpSFR3dEt6bUU2QWtOSzZLK0tMWkt2L1FIZ0JxbWRSTG12ejJLSE15UGh1?=
 =?utf-8?B?dzFmWVBsbzI3WUpFS2NlRkJia1NmUUV4MG9mSFVxNHRSYjVhZEFKVWFVOHpG?=
 =?utf-8?B?amFCZVRUTHZkNzl5WVBZbTVwd2dxeGNuNnEvZzNxSS9FTEpndUtLU1d3cWVy?=
 =?utf-8?B?NGtlRE5pVWN3MDFlb3FQb1YzS1JHRy9oWlBGcTc1c1hQVGxqdzVIZFh0Y3FB?=
 =?utf-8?B?MUp2dXpQbmRYZjJFczEwWVI4aXVYcktzQ3dieVVCOXZqTFE5MEtZMjJyaTBp?=
 =?utf-8?B?RzlFUGxZUy9XS0ZKbUZyS3RFcWtQVzl6WTQrV1JjdVZlOW1VUWZDeTMza3VH?=
 =?utf-8?B?ZWhDeStDc2Z5QnR3d0NLRUJwN2tiVUhwc0J2WnZ6L2Z1ZDRrMkszOGMrQmZu?=
 =?utf-8?B?MHdkKytuQlZBNWZNQ05CRmFaWXZIYTRqY0h3VUNUdHZRRmxnTVgwaC9sS1g2?=
 =?utf-8?B?QVhJcWtiMUcvS3FicmJrVkRXUWZRM2JyTVJEUWlDL1A5UlZ3VmlQeXpMTmlx?=
 =?utf-8?B?eGNXSldVcDJSVFdTTk5Eamh3c2hFT2ZFY0ZzVDBKdDVmSCtGTWNSOXRodGpE?=
 =?utf-8?B?TzFmQ2hrZUpXTnVza1Ftd0k5TTZiNGZwRXMyTElKc0U2OFRadi9qMXR3ajMv?=
 =?utf-8?B?OVNjODUwWUlWQ2NwRlYvZjZ4VEN3YlVLbHNVcE4rZk9tZ0JJMk11bS9wcHNF?=
 =?utf-8?B?Szh6Z1Z5THF0QmNjU1FKdU5sdk9xU1FNQW9USFppMlNIZ256dmhWR0NOejhr?=
 =?utf-8?B?ZnBrekFQOWw5cmQ4WkswVDhDUDErNW9QS08yV0p1b2pna09ibjlyZlR4Z1E0?=
 =?utf-8?B?dldXVjRYKzJYc056MjV5SU10ZENHOXdvSkx4ZEFFa3BzREpjaS9ON0t0Skxo?=
 =?utf-8?B?RDFWZSt5Y0RDa2JYRVcrbVpURUVncEtPL2dZaFpoVG9TTVhlOTZreVFmZ2Z1?=
 =?utf-8?B?NFFEK0ExQVZXYnZCSDByalpad3ZXdExHSjdMTVJ2dkxmbjdzanZIOXl0Uzgv?=
 =?utf-8?B?NHNHaENrcTkwYTVVKzdVaXdyN3lzaHpyditJUmlMWFhKVkRLOGFoMWF1SzJD?=
 =?utf-8?B?V0dadXRpZ3dMRWRVWUM2cnpVVmV6NnpjTEwwRVlISmVrY2NnVkd2MHZSenRy?=
 =?utf-8?B?QndHZzJScjhvNHU5TTdQbXNBQWpHMFZEdFFscnVoOXZxb1Q1NWJVK240VTUw?=
 =?utf-8?B?RmlUZHY1Q043L1Jnb25lTFRXc0srb0xTb3ZBcWpMdklYb25WQkMyMjQ4SG13?=
 =?utf-8?B?UmVVUkJXMGFLemZtZE8yNmo3KytXR2dqYitOR0JHUnRDclRlRnRFYlNzMEgv?=
 =?utf-8?B?WlIwVU9hdjFOTkVud1RNb2hhYy9Dd3RGRUk4b3lZcXFhWmRYZXd1QythVyt6?=
 =?utf-8?B?cGhjQ3pacDFNN2l6ZnVQTTVvZGpPQTNadC9EbDNBbUoyV1VpZW1CL0ZPMVR3?=
 =?utf-8?B?dU81bGUvQThpNjNqaFhSdk9xQzFRU1lmMFRGQ0E2NnQ5V1l4OE9zeUUyczQ1?=
 =?utf-8?B?N3ovQ0tEMkthSm9LSytVN3QyYU9LT2RWTjAzS0NvVTVnekdHUmxXYldyQ3dX?=
 =?utf-8?B?UVFLbTJENjA2T0Q2L1dEQjdCalVjT2gyMkZma1lsd2RZTTVJeXlSTE93ZXNh?=
 =?utf-8?B?eXhML3pXZXBIeEJUQkEzTE5CWnZMMGFEdi90Rnp0NVpncms4VWQ5cHBqVjhw?=
 =?utf-8?B?RE5McDlNNjZ0SVRTVk03eU9EbU9mQVlaK01sQ0l1MHVkS1gxRXBPNExhQkRl?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6993effd-2885-4103-d27c-08dc6ef4d7da
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 00:21:45.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lO6FjqQVm/BA9slPU3UaoytGAFgeIMhoinHQr4GD4Iwt1ksP/50fi6QGop11Bz2bGpVGY7iLQNOWH0F3e40p1DgQ93QXnRflL6SqOgktjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com

On 5/7/2024 5:19 PM, Ashok Raj wrote:
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
> for both patches.

Thanks!

