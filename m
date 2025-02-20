Return-Path: <linux-kernel+bounces-522764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3A1A3CE49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77C1189565C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9589130A73;
	Thu, 20 Feb 2025 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcZ1iVpH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4F33985
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012904; cv=fail; b=f/gv1xiKNU82M5rO3RLGcUbvWl5cJbveoT7WIwGo9X7xZtLFCiqPEq1Dr+6J2EFLqsUJY/UlMoYrPqxOYEK8dqA1dQENRxgHUZEymhp5gACKgYcwe1gY5ZxiilQUKlBjEqXE/uH3tQRsZG6DQ0s20iXKAs/2F/jRiUlceGeiPM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012904; c=relaxed/simple;
	bh=VXmRmrraySVXh0MOsyzU9s+M7+Pc8nmB7Bf4bxarDoA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m7+8yMT1KejO5wOXyYknegwZY7wtLb/+vTO2N3VaqQPIIhz+dfpp8gQbDd3pKj8lY//IyxADr/x8hzw1zDFw8McN4S8xZxSPLY/1sr3d/7evGEK0XH8zjj388Etjd2z/1zL8bXCtc3pFmmsLJGqPfN+1ehFW0O4R/3cdgNCBQtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcZ1iVpH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740012903; x=1771548903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VXmRmrraySVXh0MOsyzU9s+M7+Pc8nmB7Bf4bxarDoA=;
  b=WcZ1iVpHU5FWa3SGaOuXjW0SS0epWU0TsDMO9lnQz78P1ojimiweh+6A
   MCINaPqzv0ymr2NlMYiCBoTQVdWFv6aFgG/VW67V1DO5pOBsFhVI2/nJ5
   UVub7pkWtJSvaGQxdyPZK290Jtwg+wwEc63RNxM99iJSytloatlI5ksVp
   TMUUgc9iE4Acw+py08V/wpRVUCKF9W8/PKWCtunhx7q95/pOsc7hss+nj
   J5mueT9aWnrrusRtkmXCHkUxh9k4L7H4+2Ti9SdF9ebWl4ye1hefClBqy
   tZeyMEDdm/bkz+6Kp/0swtLtDGKFJEEHaa6XwbAUSzC3HpVkalhAfG3+O
   A==;
X-CSE-ConnectionGUID: VGhC6nstQvWbGqnhJbUBQA==
X-CSE-MsgGUID: JTsiFHDpRBa2t5z6AYlqDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40631124"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40631124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:55:03 -0800
X-CSE-ConnectionGUID: 4lgGLKyVQYqZFoVqS4lSpA==
X-CSE-MsgGUID: af3pfitDRKagaBB41EAVWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118983497"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:55:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 16:55:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 16:55:00 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 16:54:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWDc38mXF2KgQnJGBIZh1grcNFAe0WOfNdwSFvafmCFadzIwe66yl6CgFfumqR1bdeYryBiYPQ1B4Gv1KLZmxK1yxku27e1HDtGsSdR05Di9mnOGTBXZtWdPSr4CEcct2TrUtblzJcGJeGTMdqLc74w7Ja3CjrKc2ucEUpRRpuSydVxqrx810+M14nv50qz0tFD6E6PP14tiFGzq6tSAfz8/X0lFjVxCh3R+BJQRYfl7Ba6nJve1nZUhWs6zHGvrOTC5abE56kkbqScP1E8rWGrQxoU1gUGoDSrt3B34PPvRAZFpZ8b3T+p47oaXNKU1DT/C40nfK7DGdc5/grYsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq6HZwSNsMjThVQ94jSsbi6jlRWLwUEUCn5+/CZP6xQ=;
 b=DESynqndZcsPvJce3XB+wGEjiW19FzyBTaFs3JfBILEzS6JpPKujt+m0r81ORSk0FUnmWrs5hc09QFu/hnFcwMDa/BY3ZCKUDsA6gnxx4x9G2/YXmpfYq0N1/Lw11mVH5BivzoWv6Oqc0lPW2b5udKCvrZl6aG7MAtTOAHwJWM8IIvcGzrsNDytGGRuvgjnmoW/yNpCzaqUR9TQFJtc289hDv4fwQWICWEJ8x3mcpiENspDYJwCmI8v8Vh52oL1ptWIpnuTM95gUYee/54fXMHiRrO8qbzuB9FvXDZW7Y2rCnjboLH3G7K2Z6BurNgYY9Not1V+91eA0Eb8Q+MUChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 00:53:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:53:39 +0000
Message-ID: <2acf1b5b-1ada-4b52-a6af-8d8441fa66dd@intel.com>
Date: Wed, 19 Feb 2025 16:53:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/42] x86/resctrl: Add resctrl_arch_ prefix to pseudo
 lock functions
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-24-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-24-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:907:1::41) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 2317a056-bdd2-415d-7fa8-08dd5149038d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0l1ZXpmbGRCeVhjZzIxQ2FEZ0ljdWQzNjBVcU53VDEzQXprUWxKWjBqUmJJ?=
 =?utf-8?B?RzluL2I4enZtYkIyWnM3MUE2ZlBnckUydVRubHZCdS9ZMzZqVW5KLzNzT1hD?=
 =?utf-8?B?dFNzSnhBK1BDUFdPR2RwNG16RGlDMXhJQ3FEbmp4M2pPaEhXTW5HQ0hMYnp2?=
 =?utf-8?B?TUF0U2lRL0Q2NWN1K0xIc2JVd2didEtRMXJTeklzUUdabEFONkJKOGpDNTUv?=
 =?utf-8?B?K3JhNS9HMURnaVlXbkc3R3NNbmRCYU5DL2Yva1FlSkVmdFphYnAvU2NZZ2VO?=
 =?utf-8?B?OHZaVkZzYzZWVVB6cGZib3dadVAzeXFMYmUraFlSMW15RTNPSGxsMkt5S25Z?=
 =?utf-8?B?a1l2cENGTjRSRDF0NU1SMXdIR0dka0ZyWkxvRFd3RzQ3UHFoSnd5czRjNWZW?=
 =?utf-8?B?MXhNbDEyVCtaWnh4SnVyM3FNS3N2UlVDK0Q0ZC9keEh5SnRmY05Wb3orVWhm?=
 =?utf-8?B?ZFFYOTFQbUk5TTNNRDlFYmpXTWhwZGxNUXN1UVJtbmZLd1JEUUQzQkRVeTdv?=
 =?utf-8?B?NUFZdzdyeDdyZDlxdEpwOURhejhycVpMSUhnUnUvNzFHWWZqd21tci92bUts?=
 =?utf-8?B?OHZyd3Z5TDJhTnpLcStyQ01RbmZxOFlOa3dmUVNCdmVCdWlUSU5aZ2Y4aFBi?=
 =?utf-8?B?YjNyMGVsVTVhQ043UGVyNVE0YS9NaStkQWRZeEt1MWFJbm0xeDE3eGpleUk1?=
 =?utf-8?B?bFV6M1dRMTZ3bmthRDdKblg3R0p6c09SNUZTUm85UDlnK1BjdkNkbmFCMmF4?=
 =?utf-8?B?YXVNK1lUTXlkZTF2Vy9PNyt1Y2k1SllMUjRxME9CTGJKYnlkSXE2NkFWRDhm?=
 =?utf-8?B?dGl1U3hiMG1qR3Y2bHpnS2pmaitIbVV2Q0xjNHlYWkFVdGI4UmVTRU00WjVi?=
 =?utf-8?B?MTBndEx4cXpMUGxNNVozeFRaTkF6R3duTVcvbTgyNDkxQVJPMDhDeUpQUXF4?=
 =?utf-8?B?WlBIWVo4c3lXbGlvaldPMkJMYmIxWGwzV2lCQzVuanRsemcwaW5rOUdIdTVI?=
 =?utf-8?B?QnpmK09QYWxhSUVDbnJlNE1wTGtQU2NrTEthRUQzVFZ4RVlGdXlWQkJhQjU0?=
 =?utf-8?B?cFRKWnVibEFoR0FhUE1oa3FWUTZiUkFMT3JaNUNtRjNJdzVkSU1Nd290TzRo?=
 =?utf-8?B?Wklja2JjWGgxMEU1Q3VXYURjQU1HcTNjaG93Z0xrN0toWG9VSHlPR1oralpB?=
 =?utf-8?B?d0VCRmlqd0lOVlRXTlhpakJXckVqWGI5R1pibnRyN1pCZm9wL1hHWFprTkxG?=
 =?utf-8?B?YXB2NFNnK0NOcG14ODYrWUcxelBCZXNhditDdjltRWhqMG50cm14UFViTVoy?=
 =?utf-8?B?MU8rUVNJWTRUQWR2UkpBUVQ1bDhyMExOcGE0NFNGTGxLNC8yN05pN2RkUUJT?=
 =?utf-8?B?VU8rMmJhMHlzVk16ZmFJaVY4L2syd3VxVHZiKzJ4c2VDV0hVdGcyenA3ajlE?=
 =?utf-8?B?OE9tVElBdXViTXNQeHl6RmxwajRYcUtySHpEalJNWDZpeUhYMjNQaVBIWVpl?=
 =?utf-8?B?K3pKYTNkT3cxTXJPSDVwazdCSW8xc1NSU24yVkVVUHBsVnFNVk5BQ2FnaVh0?=
 =?utf-8?B?dHRFbllIQ3ZNRnFKa0JaZTEvY00ybGhPV2o3T081OTc3NGlOZFM3K29xenZj?=
 =?utf-8?B?WnpVOERSVWlUUkNrWTVyMWcxdlJtQUdxVjBqZGVCRTBPZjRBTHFrSWNreWZm?=
 =?utf-8?B?VGNmMTdmUG4wN2wrZys3NzAwOEhIbEhMSXBaM1YwcEdXL0I1OHlpOXdIWXF2?=
 =?utf-8?B?d2gwNHl6Z25WRjYwUmo2V2VXSWVaUVNPYVI5ZE8yVGNmcTRsclViMFVTWVV5?=
 =?utf-8?B?cUlieXdDdnJ2N1hKTEVZcXM2YTd0SS9QMzJHZ3VTdUM1aDdkMnNYR09mSFN4?=
 =?utf-8?Q?GC5ddrlJpE9F9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnV3WXFyZmVORFZaVHlKUXMvUU90QkRXakw2d0FRc3FpYVBmTWlGQjhDalVk?=
 =?utf-8?B?Z1k1K3lSNkdVT1piYVFJMjkydFZQeHJHVXo5NHpaWTM0ZTVoWndwVjhXYWtX?=
 =?utf-8?B?T3NNK09YeUhFdWF0OXpDZWtpZUl5b2JORG1NTW9ZajNoWVE2Qmc3S3E0dlht?=
 =?utf-8?B?VEl3aGQ4K095c2I4VldpU3JZWXM5SjhoZGtqUE5nbC9PTWxCaW5lRjNiazBl?=
 =?utf-8?B?bGFhd2JtS1Bsa0w2aUwwaXpDVGpDMndiSG1uWllUdEZ0bTg1WXVyZWdIbVBq?=
 =?utf-8?B?aG5zdmYvcExaZTFIeFdCVklvWnBDeWpEMUJnK21LT1NwTFl6QWgvUE1TS0RC?=
 =?utf-8?B?aUNpZUxtTE9jUnh1Wm4xZ0lmUTBwd3MyM1diTGozbkU5ci8ySkwyekREUDI1?=
 =?utf-8?B?TzN0ditUbVdMWnJ3a3BYeVFLNTlvcUYvWHZaL3pKb0dYS1F5aU1mVEczWVZM?=
 =?utf-8?B?U2xSVklyRVNoT2lSS0dFSkR1UFE3OUhaNEJEdU12c2xEK0hIcWxqOUpLZy9t?=
 =?utf-8?B?ZW9LNVVoc3Exb284b2hWY2hZWlVLVDZOalN3Q3MvL1QrbVFLQWVlMkNIcnZL?=
 =?utf-8?B?SHg1di8yczVIdGdNTUJjcUFmYWpsOXo5aEVQV21aNHBjdFk5N3hZdG54T3R3?=
 =?utf-8?B?dTZXTUx0b2hwUmtnRlFrbUdMM0VDS1ZVVVRDQk10STJWc1gxWm1MNVhUNTZr?=
 =?utf-8?B?d1NQc0E2OXRUY0FNT1F4SGRWZGFvSHZrVll0Qk9EdzFWYnMya1hJUENMNEJJ?=
 =?utf-8?B?b05XWTh3dXhNMnpSTkNhRkV4aHRNcE5YbWFmeDJvL0p6akRDSmRwdnBRU1NE?=
 =?utf-8?B?aHdyNWFaNXRESWpRc0ZCS3JTUVdBWnZFdVUxdVUvWmNnY0V6QWVjZDlRMmc5?=
 =?utf-8?B?UGFLUkE0Ri9xVzJNd0piY20zV1l3cHQybk9GTnBqdEk0OHlCRk9XbDgvaU92?=
 =?utf-8?B?S01NTGwreCtKZUQrS01zRDA5L1JOMjB6RkplMWZaeUJRVjhUQ05xcGxiS3p1?=
 =?utf-8?B?WkQzSnZTamJnNHdITTVjbTJSeitqYXNYQlg5bEthQUc5ci9vSGlIN04xaWYy?=
 =?utf-8?B?d2JTaGZZRHNON0VneDJpaEI4bUpCLzk3RnQvK2ROYVovNVI1K1dMcFVJN1dl?=
 =?utf-8?B?UjhRbVJHbWhKaG5Hbmg1akhieTRPUUh0YzFTZHdOYmtHaEpOZWtMdGltQzFi?=
 =?utf-8?B?K1U3bVRlNkNsUGNWUUMzRllaa0l3by9VTjZmMzYvZnQvZld2Um1QYXloR3hG?=
 =?utf-8?B?SkNJeHh6MkdXM010TjE5am9QMncxWXRaUVBwblk0RHRJWWF3NW9LVHpndWQ2?=
 =?utf-8?B?KzdNVVVBQy84cFN6czN4T0ZOZ2p4dVk2WlFkZ0oreXlhS0EvbnMyVzE2ME1Z?=
 =?utf-8?B?ejJjeDB2OVltR1owOTFxU3dIc0tTM1JSNEhlTHYzdUYweUhHTHFEY0FkWTNn?=
 =?utf-8?B?QVRPdHVmNHpobEtkakFZQUlCb3hYenFDTWN0ZE9iNTV4bzFBWjZDelowMDFH?=
 =?utf-8?B?bTFqeS9yNlNOUld0TWs2UTlFM0ZkTGYyZ0NQWU83cGRPNFB2MHBpc25PS3NV?=
 =?utf-8?B?bkJaOG9xdFNRemowL005c2JJUDNyd0xWc25oNlB6NXJ0QWhFNkFtdXpwMklp?=
 =?utf-8?B?R1N1M014eThyOXJDQUE5MitWQ2xhMlJYUVF4YzNpWVdGOGxFWklrV0d3NXM5?=
 =?utf-8?B?VzVLbmdUdlJEa0dhU0hmYUtqYUVLOWpsWll2ZWdYZXBGQWVTNDBqdXFONGJY?=
 =?utf-8?B?TC9HL05EaG41WnIrNlVLR0d4Zmk2MDJ3eXN0dE9Pdi9FeU9QUUI1dHdBN1hE?=
 =?utf-8?B?eTFHZWZjVTZJNVh2bHZiUVhDRW1zOTY0UWVGa0VCSWVFbnNWcVhmYlZvbEl5?=
 =?utf-8?B?UFhUMGFIRGllczN6RWdJQXY0a3ZmS0dmdVdJdjNqenIrbnJpK1JZRHp0VXVM?=
 =?utf-8?B?L2psT0lUOE1mMHFocDhnTlZ0eWRzaEdLek5wcHVxcTlydDJ5M1hJMVVnQlhz?=
 =?utf-8?B?VWZRbnlDMExHNm1pMUVreWh2YXdUYzY5SmhRTXpNVGNsRy9qMVdVNHhXS0l4?=
 =?utf-8?B?MVNaYjgyY2JZQVdzTTR1cjRRSXZweS85MURxQU0yVUg5anZZOTZiNEhhRjEr?=
 =?utf-8?B?bUpJczRCWUxyWXpoV1hsL0hHSTVrazBMSCtaM1RQSFhPdXhWeDJaU2h0RkNI?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2317a056-bdd2-415d-7fa8-08dd5149038d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:53:39.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHkiWhmEXmgvn7Y3qBsL4rzviGu3+EYn6nQZodKhRZAg/muH+HMYgf0sCjMsWT7ruThcenTsfoM8rNEmzGvfGbmWCv8TI9uybUNReWAYdM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> resctrl's pseudo lock has some copy-to-cache and measurement
> functions that are micro-architecture specific.
> 
> For example, pseudo_lock_fn() is not at all portable.
> 
> Label these 'resctrl_arch_' so they stay under /arch/x86.
> To expose these functions to the filesystem code they need an entry
> in a header file, and can't be marked static.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

...

> -static int measure_l3_residency(void *_plr)
> +int resctrl_arch_measure_l3_residency(void *_plr)
>  {
>  	struct pseudo_lock_region *plr = _plr;
>  	struct residency_counts counts = {0};
> @@ -1205,14 +1207,14 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
>  	plr->cpu = cpu;
>  
>  	if (sel == 1)
> -		thread = kthread_run_on_cpu(measure_cycles_lat_fn, plr,
> -					    cpu, "pseudo_lock_measure/%u");
> +		thread = kthread_run_on_cpu(resctrl_arch_measure_cycles_lat_fn,
> +					     plr, cpu, "pseudo_lock_measure/%u");

checkpatch.pl does not like this extra space that sneaked in.

With spacing fixed:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



