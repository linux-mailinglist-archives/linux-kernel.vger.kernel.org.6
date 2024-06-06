Return-Path: <linux-kernel+bounces-203445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B79528FDB5A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCD51F23BC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD3A525E;
	Thu,  6 Jun 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJ3EzT52"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B31C2E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633254; cv=fail; b=QF05MoBWVqoUlNtuJPdyVIowkuDcBQreWT0cRcmXTEsfpS9tNLoyVL/HGen2iaZjYqwCgGa6+ieMtK2HMHXQKHR+9uS2OcJwAwVRtclPsPTHArRS8OLLq44avlq8akTnv34xf5i6/83NGsFyeRhtVUjbTKvWZMbnCrExYPQFmfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633254; c=relaxed/simple;
	bh=CGKze3ZmLD05pXGLnhHQ8tfMs2eHqgO49quc9ArOSBM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QYuCwTEHvguTjEKiQKutZPRtxGi6uer48Zc9OnzAYCy9NpjPfP6xTLYvHJ7tOGudWlMfGyIUV3A9EvhAu9eAnGdzxg/eAXcWk+OmLmk7QJG5JnoqbzJzXfJUj6aBohtnvzCg+Ir74qMRta5fQcB/LN6B4lbRqX6rLINDML/VVj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJ3EzT52; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717633252; x=1749169252;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CGKze3ZmLD05pXGLnhHQ8tfMs2eHqgO49quc9ArOSBM=;
  b=eJ3EzT52R23asMcW0zEeAVg/AT1TFGd6H6YRDOKmoKGJ04Bug8rxgHsT
   KH1hE4nWI8T/Ed0O2dAZYeDNwuNvre0kG+kDxkFod3ET4vFObH/jQv20t
   kCCT60fAO6Lm3mFbofjJ40HorwDn5tPMAy7GAG1Un4138vRBeJL2E/25f
   Kd+k+uW1tCLl9MQtPkVmA3NQOHj4Lk5uCy0aUYwOJy+RPhLW5GUa+yDZE
   8NyVmxmYpeB0uVhn8BxUgRPCt/ZF4oStWw3eyKvUBY/eFGCaLp3lXWuyo
   LcLiUzffBP2sjNtL46xBfC1LIzKsebxRJ2wslrGiruFZffUgC+sGF0aTc
   w==;
X-CSE-ConnectionGUID: eDxRmrUQSBy44flYtGcMhg==
X-CSE-MsgGUID: yZfZkA2rQiiKsl0mFGbNjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14431019"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14431019"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 17:20:51 -0700
X-CSE-ConnectionGUID: +xKtQe68SeSebp6FtOF70w==
X-CSE-MsgGUID: o1J8bXmDT+KSf5qk7F8r/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42230620"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 17:20:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 17:20:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 17:20:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 17:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsgdnxFOApi/0L45zRlsX+Ko85+tRPfoM+N58XEXvIl8+ttjptfc/3ZDxAw/a5djusMljBt4e5uz4MRNZK2Qaf++ZkdGAwhkuVArscjkGeLZ+EWr9fSpIkE2p7Fo7JTtCmPYImKp+faiIzVZVxziO+2o3R68LklP7BJA6bJf3peREPMfy7tBstEK40ne24RihcAl+AA5iXXkXg4UkoPYJHEuyCmlvYhKLvk/XS0v4yGONxfdhZTXt06mbFF4oHwGKab4svaGSMo51kcisJA0AOThv3XG9krvgcvD0QNo++azM8AVentuIsdj3JNF5JANgDreIY8x+x1obnl+8HFqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IkPspuxYoXXX9i+BWa4baHLgX0wdisAe1Qqqt2gz6o=;
 b=hyvQcpgSNcRDJX8o++2WHxjdaithSz89nkmf12O0CWHCwXsn8Eh5Dm5o/c4HdmHrXl5erHlQKWi+MHsbNu4YMdLH0ChKdHxHl2P5I8Rxwaf4jbHyIVzSWbwRGMw4pWLtGnhS47bSNPSBiAGcc0KX0iOPrus1s1PQR/J9lYbFPvQRFVkm/l3r6l4mGOE0/74lzVfRfbmuK1PVj3fN/ttQTeFUXAQUkKGL9tlUfYZ07Fv3JdIQTMIq+NWn2UVRB2AElAqdTAQtQo9OhWKGFN9cfL8caY/2JrYb6g3mVXLvl+hpht3SarS9/YgOzPGtOV/hEU45ne4BnzANe0dES9CFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 00:20:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 00:20:37 +0000
Date: Wed, 5 Jun 2024 17:20:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Peter Xu <peterx@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
Message-ID: <666100d39dee4_2d412294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240605212146.994486-1-peterx@redhat.com>
 <CA+CK2bCCeamiaoTFybTd5nW39ixVPDM2gV2rMmK+2PfFAyE+9w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCCeamiaoTFybTd5nW39ixVPDM2gV2rMmK+2PfFAyE+9w@mail.gmail.com>
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: f273ebe1-28d4-439f-2744-08dc85be7d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEVvakFONWpod01lVloxSUxjSWVTRFRxMUFlOXA3cmZtcXlTYUZZdG5WZXo0?=
 =?utf-8?B?UG5hNGt5Mi9PQ3J6R3ZrYlNmU2dkQ3gvM2ZNeUJPSlFuT2FmMUU4bDhpaWJX?=
 =?utf-8?B?TnpiWktqd1ZCTDgwTUYxMnVTcWQ5R2dVcFdiV1BPUy9wc3J0TE1Mb2lTL2Jt?=
 =?utf-8?B?YjFyQ3RhZDN0MUVwaXU3cW5vb1VaSllqaUpUamEwTHp4V1NSaEcrMldISDRC?=
 =?utf-8?B?MG5XRUJJalIzbjJmc0dMUmNOVUljdmQvYno2Y1NMMGdqa0YvZi93UWNKN1dC?=
 =?utf-8?B?dFJjTmkrc2RSNHdyalJicTdpTmI5aHVuZTFjM3F2WHh6SmNXek0yanZqYWw1?=
 =?utf-8?B?UXM4Q1VBTUI4K2NiR3lXeXFYR3p4aDlCWWJBK3ZFSnA0b2ZON0laQ0xMZHMw?=
 =?utf-8?B?MzZ2aUMvRGZFeURHaE43UE1LYStOeUJrekVVNklRNjl3bS9mbHB2dXBpeW9q?=
 =?utf-8?B?RzJNUXZpb0ZIc2RLRWtWZEhmcDFUaFlvRGFjQngvbm56K3JEaXZ1Vm5ERUk0?=
 =?utf-8?B?cERlbEFhT051U0dXWTdHWUxJMGtkc29QQ282ak0wQ01VdGNzK1JVcUJxcUxQ?=
 =?utf-8?B?ektHbTN2YlNSNEIzT3REbGJ0ZFNoc3B6OHlPSnQ3NUM1bitnRG1HOWJsR2lv?=
 =?utf-8?B?K3FDWE9sQ0Y4VzdFNEZzVHQzbHJUWHVsWUx5VlYyUGtrZWc0anhVWE10OCtZ?=
 =?utf-8?B?NXgrLzJ5OVc3a1p2WTZNUVZ2SXQ2V1dtZ0JYQStJMDZHdnVUN2hNOUh1aFZp?=
 =?utf-8?B?Rk9GTFZwSnp1cit3dHNDSnl4U3IxNVZ1c2VzUDFrY3NFSVZlb3lQTDlkckNQ?=
 =?utf-8?B?Q2xlREZpaERlY3JXb01kWG1GSjhxY2Uvc1BSeGlNV09pNWdpcC9pWWVWOHJT?=
 =?utf-8?B?L29mdFl2RC9LRnJoSUpkSlpCRFBURmp2dmNjSUtlQ1EybjVWdzF6SjlDdFJh?=
 =?utf-8?B?WEhJT1dTd09uS1FybGpGSlczSGV3Z1VtZ1piUmZQN2lWT1lCeW96SEk0NVF6?=
 =?utf-8?B?My94SjlIVVRoTWMwSEhNUFVGdjRIM0kzdE45NDh1aFcxWmgzRDJnYTVhNEtw?=
 =?utf-8?B?VTZ0cVA1SmJ3MnI1RDZyWW1kdVpwRkJLWDJxK3MrVk9mK0RLV3NVcFdLTHVS?=
 =?utf-8?B?WXF1K3FNaE9UUTZrZGlkUjRXbThOaWNhWnB6MDhGRmdBS2gyMW02TkttcnFC?=
 =?utf-8?B?Z1ZaMDZOTVhDREFNdVhHNlFBK0k4VFgrOTMrc1NWT1pQOWpFRksrZ1NOc3Vq?=
 =?utf-8?B?TWt1WFpRR0daK1MxOXY1aXYxMndrMy8vV1ZVd3FpUXVDUVV0Qm5GYXVTL1dZ?=
 =?utf-8?B?S0Jnbm5ibVlwK0pEcCtwcUZ4cXhoVlFIWWR3eVI0azlhK2poblFrSTRRcnBX?=
 =?utf-8?B?NmN0clhOQnhqUUkwL3htRGt4dTFDdE42a05LUUxpbEdTYmdaR0YvRkhnemJh?=
 =?utf-8?B?ZlBYYW9UZUtLQjZoV2FtR0kvbWZwNTQyRTFtZlpTSksyNTNQL21qWFpyMXgx?=
 =?utf-8?B?TVlnenNsTjRxOGFlWUVqejdFSFdheEF1Q0tEZUtXR1VBT282RHNVYnRFb1Ny?=
 =?utf-8?B?ZGdaZzVKM2pKSFRZamg1RkFyNk5DeDFaQ2N1ZXAzN0JVWFNmY1BtUWN6OUFI?=
 =?utf-8?B?VjA1akFoZS9KN2U1d2JLaDZUNTc1ZGN5VnV4S0w2MjdsRUFOb2pwUlZQTkxq?=
 =?utf-8?B?TU1NRDdVbEZITFlITTBraGZLRG5UYUticDJZOUVxZjZ1NTVQejRtWlFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZveDRGb0JSKzRNUlM2b0FrK216WmxjNTVBcmo4WEpQN2ZiTENBVlBWa0JT?=
 =?utf-8?B?SDBxWmJ1L2hZdkxsM3VJeDIzMUhHSjh4TFROdWJOU2J6REpBNkNxTDZjRHFC?=
 =?utf-8?B?cHN3SGdaN24yWUpWR0djUkIyTGVLWUI0NjNGbGtEbUZOR1F0OTYyZGk1S0Zw?=
 =?utf-8?B?RzdEMG9Dd25aL2lVMnMzc2JKK0hUaXpGNlQyUmdRT0VyL2RlWVhhMGM3NU0y?=
 =?utf-8?B?YjdjRnZIaFgyZ3p2SFMzM211Y3hlK1BTL2IvTlowOTNDQmQ2d3ZxNjVHd2JQ?=
 =?utf-8?B?N2tMVXdVVCtiT1JOOHlNY2FJQzlVdVRCVXJZLzhGZE9NdCtQa25uRlRRbUZO?=
 =?utf-8?B?U3JBOGpBWklPSmwybTk4dnN5UmM5S0ovVEJsaGx5YW5oekdMekZYYjhQS0ky?=
 =?utf-8?B?d0xXZGNTM0xmbVh2bkEyeTlSMUN2SDJQT1lSK1JXdVJ6cCtPVkRhNy9tM20x?=
 =?utf-8?B?c0YzYm5NWDROb0ljc21sbUJJb3QycE9GbUpKTkVVYTVMZmI4QUFDZkJsbkJN?=
 =?utf-8?B?QnJDeHl5dnFVOVZwaWx0VFhVMGc3SFZEZ3ZDQng3TkpBS0JLTENTVmhvRWhE?=
 =?utf-8?B?dTVmZjJ1NnVuSFdBRzI5MFZGQlhTQnF1Z2lGWEVKaXNEYnBaUEhyK1NZZGdy?=
 =?utf-8?B?emMrMVV0akFod3dtdkl0K0FlMDRwMllYWXdGYlJFdWcwanplOWwzanNXZFNi?=
 =?utf-8?B?NzNtQnlFSk9oTkhIWWdCZHloZ0ZhK0VkV2JXTU1oSCtxeXVTMUIzR2NWZXNN?=
 =?utf-8?B?cjFhRVpJYy9QY05GK0ZnUXl2SGIvb1ZxbFR3WVo2Rjh4V0U2Skg3MUhTSG45?=
 =?utf-8?B?M3dERlBudHVQTkhHZTgzQ2NQbGE3a2xEL3QvSGtyMXBLRkVnZUFSUnI5WGMr?=
 =?utf-8?B?dFdCM3c1ZU9rL3RWQ0tzR1doT0l1THFJMXNBemJaTE82cWE1MW42QUxtUy9I?=
 =?utf-8?B?MDg0b1JzT3pzVEFydEdSQ2IxVUZQeTRGeWJXQVpKMlA0eHVJSDFoMUhuRHY0?=
 =?utf-8?B?ZnhMeFdWSnBzT01kdFF6QmRhZGQwQjh2QzdRTWkvYW9aZ3lNVE9OTUlGTFlt?=
 =?utf-8?B?dU9zZm0yNVlEdk9LU2ZKancyaEVrRmZCem5YRWFSVkRxSGRqVFJ1UGRVMjA5?=
 =?utf-8?B?SlkxenpkT1REajhTeXlPVjhpZ1lFS2xCZ0lIb1NzWWI5QkdZRTNOSDFRSmxr?=
 =?utf-8?B?elZhSkVoQzlOOEZvbTdhcE1mTkZtb3RsQWdwRHpYY0wwYUI4OEpENWlVYXdt?=
 =?utf-8?B?NWZta2NqdUlzcHNEOGl2VWxUSzhqM29SdFBqOGhreVR6cjJkVHdYZElzd1Rr?=
 =?utf-8?B?OUVhSHFpWWdkQXZaWGh3Vk1hQ1FSbXE4MS80SkZpbkpvdm9HUEx0NnZGQy9v?=
 =?utf-8?B?Mm5mYytLRjd2L1laV3lVT1Rlc2t0bnF3WHJWdEZPRzk3TTdXYTZwYUw3Q3Zi?=
 =?utf-8?B?ZWllZ1JIS05sZ0dlcGtFaGY0UG5mdmlZanRMSUFMbm80bU51Q21Qb0JsWFRa?=
 =?utf-8?B?a1VxNEd2ckxkaHh1UW5NUjlrTGx0MGF6by91S09pZ2duczMrZ01qc0NMbnRm?=
 =?utf-8?B?MnROdEYrMGY4U1UzMmt5OHRqOFNUZ3FoMDBkS3F0WTI5cGZGc0JhT002YjdK?=
 =?utf-8?B?SjRhZ3R4K0p5MFEvbW0zUDlvamh3S3NkdGtEY2JLa1cwaUhVZ3hLTHgrSU0r?=
 =?utf-8?B?UEp0dWlhd2ZRL3gzVDZ0VVp2UFFubkNmYVB3NGorT3IweU9jS0VTUjQzVUc1?=
 =?utf-8?B?R1M1K25MZ3RwT2NPTzZkb083UFN3LzVBZVhFbHNTYm1NRkVKNmtyT0owdE41?=
 =?utf-8?B?UStjQUJJVjdRUmd2Mi9DR1RUMkcvYmMyNFF1TUsrSGdHNmZ4VjhEeGJUbFhZ?=
 =?utf-8?B?Q1loUXZBK0RzK3c0c0FrWE1ycTBDVnpMK3YvM3I4WHBKb2l5NHVpY3dCS1k1?=
 =?utf-8?B?eDdBd3NvZ2toQmlFdUdSYVh0T0ZPbVc3dHNWeXVBQ0NuYW9IVlVhWHZvK3hZ?=
 =?utf-8?B?RHh5QXJDZGV1KzVnTHBzRUg5SklacjR5emhUZjJ0RWpJNlRhaHdLNXlCSTZq?=
 =?utf-8?B?RzJNMUVaOHg3Wk05cU9sT1hDNnFQSytPL1o5WFUxdWtFTkRkVHRZY0dIZzdF?=
 =?utf-8?B?Rk1SbU1iWU12VUJiVEtuYzZsR1h3b1RqdTZPVWxNWmkxQ3BVVVVseWNhSkJQ?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f273ebe1-28d4-439f-2744-08dc85be7d9f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 00:20:37.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWTyAjwzumih9Mjc0LqEMhHFpMrqLTQmczslN6C2ds8Q90IkQpLrNNCkbe/7hd+mokk1bdqOGkAZNStxqnc4xJT5H+tFTCgYMahu+QEh2rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
X-OriginatorOrg: intel.com

Pasha Tatashin wrote:
> On Wed, Jun 5, 2024 at 5:21 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
> > pages: they map PFNs directly, and they don't allocate page_ext at all even
> > if there's struct page around.  One may reference devm_memremap_pages().
> >
> > When both ZONE_DEVICE and page-table-check enabled, then try to map some
> > dax memories, one can trigger kernel bug constantly now when the kernel was
> > trying to inject some pfn maps on the dax device:
> >
> >  kernel BUG at mm/page_table_check.c:55!
> >
> > While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for page
> > fault resolutions, skip all the checks if page_ext doesn't even exist in
> > pgtable checker, which applies to ZONE_DEVICE but maybe more.
> 
> Thank you for reporting this bug. A few comments below:
> 
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/page_table_check.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > index 4169576bed72..509c6ef8de40 100644
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -73,6 +73,9 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
> >         page = pfn_to_page(pfn);
> >         page_ext = page_ext_get(page);
> >
> > +       if (!page_ext)
> > +               return;
> 
> I would replace the above with the following, here and in other places:
> 
> if (!page_ext) {
>   WARN_ONCE(!is_zone_device_page(page),
>                           "page_ext is missing for a non-device page\n");
>   return;
> }

Hmm, but this function is silent for the !pfn_valid(@pfn) case, and the
old cold has BUG_ON(!page_ext). So we know the caller is not being
careful about @pfn, and existing code is likely avoiding the BUG_ON().

The justification for the WARN_ONCE(), or maybe VM_WARN_ONCE(), would
be if there is a high likelihood that ongoing kernel changes introduce
more pfn_valid() but not page_ext covered pages? Is that a realistic
scenario?

