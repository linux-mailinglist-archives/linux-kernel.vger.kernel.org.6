Return-Path: <linux-kernel+bounces-537673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B558EA48EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2ED1891A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5D186E20;
	Fri, 28 Feb 2025 03:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7jlefII"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1917A2F4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712262; cv=fail; b=jvtiuf8rxqsZLREjg00gK/tB4VPRfQG4VAntbNQC0zGtKDiAMGvTMHzekTzB/bR1969uw4XMl9kPj/TNQa2PsH7Eq+oEGzfBWreyKEYk52PzjMogKUTXD6wH0NT/+REm5+OikKdmTxJ9gUEVGQM3Nb/OMPK7vNiTtZvqxmv6CSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712262; c=relaxed/simple;
	bh=kf8A8Jt8QMecNTY7ZsCnbSlp2Ke+TgjCNFAO4mvDpJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKSZeOl3KYyYGyC45Tyt3aoC5EzE/zTevaU5mKdLj0d+eByetKh8BH//OVA/SO/miMpshIsaDkQmWev1JqOpIDWCjUbOalV4At+cwZ5b6SQOKkkQsrV4yV8mR10jM/tWSgrKuL4jyocBkssUxXkl0ppJaH0g5BWBybQuO5E8wWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7jlefII; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740712260; x=1772248260;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kf8A8Jt8QMecNTY7ZsCnbSlp2Ke+TgjCNFAO4mvDpJg=;
  b=D7jlefIIEiNsB0X/whfdBqrXNxMeRNdbRSIElc2k5BVoaKL/ZIe322eC
   jUY+v8XWFxbcfMpvzCZOekuNZ+WMEUX0/1rZdAZ5OZmNrpAWlpAisEhfY
   2x6+kk3go072A8l+1EBAUxSpR7c1M3DwagGL91LX4tUQ0X6gMgg1JZWw0
   IjiYRr2W8gHyTWjRKXaONSXPh+lvE0qU6tCxtOY/WfvGsyfYPGAFJK2DC
   1KT0rWD8dg1TK/IC1WXqxc4NZCa4nnKK30Ej/0KD803PbWQlIuFGe+V+1
   +0WxCdwaErEuAwTYb2n+XfOHKLvPE3U6a0KCVcTV9NECit6Q0axS/20Ft
   g==;
X-CSE-ConnectionGUID: dTldlhQaQ2SJmT0scuKvtQ==
X-CSE-MsgGUID: s4ZE0aAkSnuFiH7Kwf6feg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52274170"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="52274170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:10:56 -0800
X-CSE-ConnectionGUID: 9DR7Lvp0SKC0Udwvfwirtw==
X-CSE-MsgGUID: 3uxl4L8hTdSCxzEBN3ruOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122227366"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:10:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 19:10:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 19:10:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 19:10:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLRduzs293jG3xgxUVS379lOWUwdSVN50QFeZ0GHCNfXIxDpMT4l1p2PCZkJ5HX8FOk/c8DRwIpmoekakl+5+HsPN7QcqLQHY6cId7XDRSEDxw4dh5WAOWT1f/qJCrmCcIgP9egJ3otQPvn7lbrMhfhntuFPkhhkvaStwjfpHSIHPKv/JJ/vYMe7SIgMc2ijnwxsk5DaJiSMMTWcBX0DnuiZ/HzWIfye7SlMuoqwfWDBuXpUs1QGcI+Tgo1eWbjqAtRY3URCUfJTMgrr04xpWuBkCSw6e7hyonkANe/qC2q12mCCsgtcOI8+kvCC4Zj6290IQdBR9cFJxzohJktLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZOisd+vsTHx47Ji3TDghfYJwtP2u3qktChBB2j9se8=;
 b=q8F/3P2vV3IPxZ1nX+P8sv1GvC5YyG1g38nGvwwM0MYGxQfoU9MuLL5IOk4kfmjx1wBRTfRHfzh/zzpeDSlF5BANBoLuJAQ6UsB3EmoAg2hQZXyjDmtDJpbewcy0M2hQTTYaCXPbAxnkujlDA0wrghkB0iMlko/V1DSao3nZ1s5+GRpEYc8JRvl/x6/lspMlFK3xBmF9+yxjPaLex9VT7nF4bKZ2ab4hNOrNxO295xLWVcnFM1u7HWoqiPRsgYNR59t30e91FNouqQlCbA3CdtBNKq6QWCRoTR9Ay7r075pm+MaJ971BdXSVO1UayJW1p0vke1aG6lSsqVjg7hsFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:10:52 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 03:10:52 +0000
Message-ID: <afa6abf6-83d8-45d1-9e05-64e95680e7c8@intel.com>
Date: Thu, 27 Feb 2025 19:10:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 00/11] x86: Support Intel Advanced Performance
 Extensions
To: Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <Z8C57rzRt90obAFg@gmail.com> <64be7980-644d-4b16-a8c1-5598ea63aeef@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <64be7980-644d-4b16-a8c1-5598ea63aeef@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6119a67f-2692-464c-00bb-08dd57a58266
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFhvVDUyR2FkZzk4dWtuUi9Xa2JNQlhJMGZIa1J3THA5c3lxK3FyUXBiZ01L?=
 =?utf-8?B?d3RwMzhoY2FhWEYveS9oRU1lR28vMTYxRzJaTndYMFhzYXhJenpYMklOVDVR?=
 =?utf-8?B?RU1iVW9Vc3FHUU44N0NMSnQ1bWl1RjZUQ1A0ZHhYa2xMSkJYdXJhQ0hHTGt0?=
 =?utf-8?B?RlkzVlZjTXM4SkFqZDdyMFUwWHFLRm5yZDVSTnFVVzl1T0dYSTQ1bjBiOGti?=
 =?utf-8?B?bXU1S3M2djBZcXNidWF6VFovZDcyT1JKdERPdXhhWXdMaU9LMVdPaU4vOC9F?=
 =?utf-8?B?ZEIxOXo0dGdmT2lRdjloQlplN2cxNlRnMU9lMmdXNDNwSjNDUHhCYTNPL20r?=
 =?utf-8?B?WURhSnR6TGxodk90Vk1GdFpoYmJYWFZ2WnlCWUxlNEF1RjhibHM1b3FYQ2tu?=
 =?utf-8?B?UCtwWWdmS0t4K05zKy9CdXU4bkpxMFhPY0Q0QnpUMHNTMHAvWnhHRmdVb0VI?=
 =?utf-8?B?elpTWDZSSVp4MEVBMjZ4NitybFBwZGw1R3F3YmEvSkhNYVczcC9UT3Z0QnFI?=
 =?utf-8?B?MXZlWWJYZmhPY0sxN2tVcnBzTkpsdkVQdG5RTjRiUVgxdW9YdDJsaVkxVTY0?=
 =?utf-8?B?RjB0WktFbThTd0xIcWpQQTdRaUIvR1hJUkZCOHlBcUszME4zRERyNTVoL05F?=
 =?utf-8?B?QndTdjdGbzV6VlRSVHBVZkZzeVQ0YVp0dEJNUExIbUlNN3NBcGJnSExYcCtw?=
 =?utf-8?B?c2UzOHhjRTFxQTgyTWxaNmdaTG1pY3laN2ljM3hPbDhMQ1BaZUtmeVYvc1RY?=
 =?utf-8?B?a21CZ1BtZmdkU2FmcjVsRk51QTFRZUFLY3VmaWltK2tCOU1vRXlraVBySm8w?=
 =?utf-8?B?UHpLdzJEd1RseGNBWnpVVE5IT1JaSFRrZHNjb1NPL3FLZHNlTW5qbzRsZnEv?=
 =?utf-8?B?TnJjazBZU1VwdlBMODJTd0p4anl6V1I1NzF6Y1BXQlVCUHhZWlVUZEgxTElD?=
 =?utf-8?B?MHBLZjdvUU5KY1p0TzBjWGJzOTRKT2lSUUxYU3VLOGQxemNTMlNqdzNReTk1?=
 =?utf-8?B?VWFIYVpNYjYzZUJudmFQSmNVZVQ5cXJyaE1WS2tVZnR1b3BGZURVY2RIc2lB?=
 =?utf-8?B?eDNkOU9jbTl5UVI1WnNwTWx4bmkzdm93QXYzaE45dWcwMDFPd0YzTjRBTEdZ?=
 =?utf-8?B?S3J6TlBHdjRZZ0Y4dWVSTUpEc3BMbW4rY0pIL1d4aU5oNE03SWpYSEVOM2ha?=
 =?utf-8?B?S21pREcvMkovNHM3dUlJUVlsUmdWWWpTRHdWa3JBQm5RVlRRcXdMcUNYdkh2?=
 =?utf-8?B?ajgvSzc0S2ZJUFRkb2UwRll0Nm9mdU42SUh3U2Z5Szk5WUVNdmRYT3lRUWx3?=
 =?utf-8?B?YnAzR3NkcDRPSWlzZ1lKZWxTRFpjLzZjQ1hOV1YrMVhJenZrZHMyTmlhOFd2?=
 =?utf-8?B?bWVEcVNoVCtURTI0Q2FYdkdlRzVHQTl5R1dRT0FTOHgvRVZvSXJXcG4rZ2VX?=
 =?utf-8?B?Wk1Xc2JrYm1VWGRqaW9UTWlWRGVoNlBVWXVPWGE5MUtpQ29OMHlEK2FCTTJB?=
 =?utf-8?B?UE13S3I0THFhM3IrQmcrNlBQZzRVTVROeDBsblovQ2FWSnltZ0dkYmxqWktu?=
 =?utf-8?B?c2RSaDNna0N4clVlWUV5cmIxdDBlTDRLMTRDRFord1YrdkcxQyt4ZmU5WWdp?=
 =?utf-8?B?amhrZDhMVTV1QnBSTk1DaUxURWVtbmMxMlN4QVIrS2xpMVdodFhEdGVTbWFI?=
 =?utf-8?B?aG5JeU9mTWQxVHlLUGVpVGVWdjd5NFZSYUU4UTJzVDF5UkVVeUxIT0xwSXR0?=
 =?utf-8?B?THFGNmYvaHZiZmFWMFlrWUx4bG9Ucnc2K016M0JPRVB0cW56VjNBZWJlMVpw?=
 =?utf-8?B?bnBYMVlyd3czVVM1bWllS3ZQWm1xc3RjUmYwdkJ1UEczQTZNNkhybkR5VTJ5?=
 =?utf-8?Q?2ZQx4yi36oDT/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZWUlVCSXl6bjRLN1ZicnhIWFRhcUxvN0hCRkpFOXNnU2duYkpSTVhqV1Nj?=
 =?utf-8?B?aFRkMXp1WmZtbFo0SStGQkFZN3YrSXl2MmFBVnJPbDV3YmFFOHhFUUhhNlZE?=
 =?utf-8?B?UzB4QXlxTDcrSnc5ekc3S0UwNXptMGVqaHJtM0RmdGkvaTV6T2QrMVgyY1Nj?=
 =?utf-8?B?b2p4L3dKTEVGVlNzL2FiU1Frb2h5UmkwTHVsQS9OR1hwTEltN2cxcG1RQ2g0?=
 =?utf-8?B?WW1raGhiL3Uydkh5K2s0Y2dpZW1OKzRLT0ErakZUYzk4WENad2NmRzI3V0hL?=
 =?utf-8?B?dXFYNkhKRWN2ZDB6akNxRm9mMDFkUE02S3J2Q2NtNSt6T1o1Y3MrUTY5akFK?=
 =?utf-8?B?dEpyTjluR2N5MlUxL0JlbkJPVnNCVGlaWkQ0amUvOXVFRnRqZlJkd0lHNFlY?=
 =?utf-8?B?U1N5RUNhRHA4all6ZC9yYnRMNXNITitUcnBDTmJET3lXUzFGWmpEQzhodjRF?=
 =?utf-8?B?cjJBNmV1VHJ0ZDRidzZFMTBETFU2Z1ppVlNjQS9ubGNsbyt5RTZCZUpUbGgv?=
 =?utf-8?B?K051S0hlK2ZIUHJFb3V1bUtqU3A2dGdwdjRlaldrMHhBczRISk43ek0wZmNQ?=
 =?utf-8?B?djNTazhHY2owUDV4bnQzQ3Fic1RNamEydi93QnVJbWZrcG5uVzNDbjhWU2s3?=
 =?utf-8?B?NTdBVnE4MlpBbnVXSmYwb3RLK0xNNkl3ZXkxbW9rOUU4M1FwTmxrT0RiQ0Fn?=
 =?utf-8?B?dGNNK0VVemd4MXlreE9jc1J5dG9meXlVdDNuTkVIcXhjakdHZklYdzRMbDVl?=
 =?utf-8?B?WTd5RXlJR2dSbXRNeXFUay9yZGdrc2xSa0NVcHlRMkFSN3pFeGhQRXVBTUtI?=
 =?utf-8?B?eWh4Y0RDS0U5dDNmN0pHZXFKVm5tdzcvTFJJbk1EVzRmYVp3bUtFZkl5bzIy?=
 =?utf-8?B?ZXJtZjhIbTYyRUp6bG9QT0xiRnhmWW9JQjhaT1JqUnVDLzBxTUFZSHBpMVpH?=
 =?utf-8?B?MmtFSFVBVmp3QXRuY1ZGMjhScWl1RnJaZWI0S2FGTFBqaHRTZ0p1ZUpVVFZ1?=
 =?utf-8?B?TzhYeUt2THBvMmlFYlByQThVYy9kajJsSWVTemFmb2FLWGZvOFJLak1jMTR0?=
 =?utf-8?B?eURXcFo3Lzh3cTJUV0toUVE2d1Z2eDhnQXRCbGVhZHFPNENFcHFpbmpibWdj?=
 =?utf-8?B?bGZJeE5TQXBsbW1LMjFWdmliNzJkck5sSlZ4b3JGRXFGTUw2RnUyYmdZblNU?=
 =?utf-8?B?UXlScEw1UGVnRHN6a0VzYkRLRERlMnRiZzVPTzhOM09UZjJzZVJMNkdUVERH?=
 =?utf-8?B?V0RzM3dSSzIvdHA2dEhxb0dWRXlJdUxCendiL3BweXc3Q3JFakJ6a2xpVFdN?=
 =?utf-8?B?YVhXMHM5WllmZFBOQXNsQVpzWTJkM1VlOENrNUhFaGhYTVBVZ29xSkxmZUVU?=
 =?utf-8?B?K2ZnN20wRG1ZVDhZUVVQRk9LL2NPcFo1Mmhkc3p4WXA1ZWlyeXNIbEY2NXZj?=
 =?utf-8?B?TmFONjVocDZhUFJ4Q0xDVG9WdS9WVnMxN2R3S0RKbVZ5ZWdJaDhGYkpKSGlC?=
 =?utf-8?B?ZzNuY3gzbnVuamNMTzJZb2o4ZERsbnptdXY0WElDRkh3UUxaSVJ2Q1oySnQ0?=
 =?utf-8?B?WGFYclJUbldja2lKbnNQSkVGc1JqVFN3OFozU2xidVc0cHZvZ0kzaEpWVUNS?=
 =?utf-8?B?QjVWT0RSU2xVZzNXc3c0RDdPdDB3dk1keW9sbEgzNGx5ektMTGpPQ3dDekVh?=
 =?utf-8?B?SWJ2c3dtQWlNMjM4MGp5QS80UUVpa1RLREZ1MU1KRmRVSGZKL3J4UG9Zbndj?=
 =?utf-8?B?dWZ5MlBtRE1HVU5CRUlZS3NwR3pBVFRXTjlNVElEN1ZoRUxUSmxETUdjbVlp?=
 =?utf-8?B?SG5hT21GdjdQVmVGdGxxZ0FwdWZVNmFUdlVUSTRvN3lRd2JaQTYvQVV5MWN3?=
 =?utf-8?B?V3VtbWk2OWdiMi9lL0VxQTJ4dTlPSUJFWUJQeWtPRndLV0NTckw3VUdSbjBW?=
 =?utf-8?B?RVNwSDkyZlRtNWpiRG1rVXV1OUZkaVlwL1JJaVpVQWx0UGFMWGZXd2JLOXd4?=
 =?utf-8?B?VWNkVmtCNFdHUjdIMWQrU1hJS09SMFNTVXZYV29GUHAvSHVIeFdJcHgxdlNJ?=
 =?utf-8?B?TmtTZGNtb2l1UFVtL0FVWTBQaE5QeGdzalhUQVl5SFNXUVUrbDFkR0l4Q3Ry?=
 =?utf-8?B?cVhrMVduYTM5ZjhMeWlWRVYxSFdqZmtucS9VTDB4emRnak1waFE3N3VoOEpn?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6119a67f-2692-464c-00bb-08dd57a58266
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:10:52.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5jCLtXc0Mb3ljDez9Bh4Bs1NytLM1MGbDovZb+bbyWO4OgUteUIyZQuYBJgGrsgf/M8J0YRwMZS9EFaiKQUtXnb/nqxqFVjJ1Qkgydrn1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com

On 2/27/2025 11:36 AM, Dave Hansen wrote:
> On 2/27/25 11:15, Ingo Molnar wrote:
>>> by userspace applications, with no intended use in kernel mode. More
>>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> details on its use cases can be found in the published documentation [1].
>> I strongly suspect this won't remain so, unless there's some horrible
>> ISA limitation or other quirk that makes APX unsuitable for kernel use.
> 
> I think Chang was trying to say that this series is completely focused
> on userspace AMX and basically ignores the idea of using it in the kernel.
> 
> That said, we honestly talk all the time about using it in the kernel. A
> kernel compiled to use APX everywhere obviously won't run on older CPUs
> but it _should_ have some really nice advantages. I completely expect
> the kernel to be able to be compiled to use APX at _some_ point.

Yes, exactly. My primary intent was to clarify that this posting is for 
supporting userspace APX usage. At the same time, I don’t want this to 
imply little or no potential for in-kernel use.

Thanks,
Chang

