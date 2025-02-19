Return-Path: <linux-kernel+bounces-522648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFF0A3CCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4956A18984CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706D025B696;
	Wed, 19 Feb 2025 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivTG7E7i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839D25A34B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005892; cv=fail; b=gajQWNNFHtKACRXObhK4ylthWDRUhy402oavH5/EXbyHe3zuaT6uIr+H80OXKFT7f6Orzei5T19aGphGefU7bAzt0Kn2zkaBRk+LGRpvCuUzhFwGZaYgOGaPtZKuvHnU1xS3HgJSvve9peMY3gLdbYADt8LHAwnmOXWF5PNL53k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005892; c=relaxed/simple;
	bh=NSx7ZNUUPSHE1QIjVxJ4XnpOcFj6EVQrSo5vbu0mAB8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWv34Y/ZUk3PaKcbPusrlY80vIq0CzjAFez9SVVGmdFzCqdBJG91ttX8oyXRlZ9Y1kZb6HiQDR2kXFKun93dRg7aDL/W3Z58+NAcFtaqapjVpSQckI8pKL9BuldjBJKSgrRlNH36mQiQBRRCXbJXi1AtgTAuHv2lTtpJxaJl4ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivTG7E7i; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740005890; x=1771541890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NSx7ZNUUPSHE1QIjVxJ4XnpOcFj6EVQrSo5vbu0mAB8=;
  b=ivTG7E7iAHsSK1imSu9QVcnSiFss6lv0cS35OuaVHeG3xj7e11lJc8CF
   bGXowD8FDlf4qcQdZdJcHTLbbIFhVK+tA38wZnN2PP/o8dyPOOcEgFU4H
   RExFJw6nNnVNSLwEVCuCerY6cV5Zke9VT2Z/64t+gchF91jYlxL/NgbGJ
   i1rM+G4vSW8Ne973wGWGHbLBFzTpLhOCnxXlZGhskc4S6ys7OEyDztU4B
   eMTF5n3dtA1koUuI8oRqf0Um0VbPHy7+7tPlbvXZYGRnKFq60+JXm6xBW
   xXLpffHcKOcPe5XTQSkE9sfrfb/T5dsCZMA/PYBnhd228PMqSJ3oHpv8G
   A==;
X-CSE-ConnectionGUID: CQmbAaYSQQSDAE6gOKVQMg==
X-CSE-MsgGUID: +VJOxMcAQp2I/fw8zTCKOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39995981"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39995981"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:58:09 -0800
X-CSE-ConnectionGUID: 9m9z9w4iTxSmSdNPbzW8AQ==
X-CSE-MsgGUID: OAQ7cI6rSEKrhPX4q2T6iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115523193"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:54:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 14:54:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 14:54:27 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 14:54:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWwe9fSs3fDzHoCXQG0qWcGnPXcn6mMwqtI0FXFHH7aAnpH62U+NUvm4mKoP7GMkFpleg7HQFdt9zhGQVvXwL9ACydSoKVznnhc8kR1oEF73fTGsba0YtwN7c8AvPhN5Sci7bHUK1x40y5JF9YvhBVg1Oqm8+d0x0EHfEyY6VfkfH+hfepF7lrykB9CKxI5w7P965uRFQQQr9fQ2QEcj/cWh9MeljCRvU2rAYBRoOHV288/v8jbXzHhbFTzb+xbPchIyNTHqE9RE1zaS17XCoUOEigzqyNZm4Y7CNWaMETV4TxKbN4tiOIUBCf2j44fB38qz+qxdOoCezQAH9w2Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAy3RIuxOOVdB3SeHbwdBWKEg3ZUKFoh2zgWXBS+CPM=;
 b=no6my58LdDbO8vAiGgH0sAeXyMSTkM/qfTR3Veed0EzKnQ0SS6v1kcSphZxN03aBE5zsnh6caNnpsJnDRh6Pnhcl/6Hs8PlR6NzjIhBkdU9l9Yf0aiECamewlQeL4mAJ5Vb4i9/7VuTYmzENi9opq2tn9KZWl7BreIHx7txpxB881b74+tOrF6YZNDSDybbMbIrqXwvfn2xicwqKBIUHLs8j+uax6jfzkD3hwwrs8Aee33Fls6czFNvnisFsnWUEdXYkL59wkDyQz79UBMDvxHbwviPVioigSHHdbNzjcGR/MddFQ8DyWDzYAbkQjU4nUM3TC89XD/F1FQQjisA18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 22:54:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 22:54:03 +0000
Message-ID: <d689293d-312c-4334-8f3d-be2da49c30c5@intel.com>
Date: Wed, 19 Feb 2025 14:54:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/42] x86/resctrl: Generate default_ctrl instead of
 sharing it
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
 <20250207181823.6378-9-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af63a0d-6f02-4d1e-a68f-08dd51384e9f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTM3bXVsbG5HZEdYdlZEak0xMHRJL1pMc1lYT2s3NDBqcjc2TU1tSjQ4N1di?=
 =?utf-8?B?TElBYjArNXFMU3pBcEhJUmpVY1h4REZWL0FCSnA2RmdiMDdBSlY5SnJrS3Fh?=
 =?utf-8?B?bCs1ZGttQkoyZDJPaXd0bXhTRTFrbnplYjJCTEhyMVdSZm5YNVJHaXZJaS80?=
 =?utf-8?B?ZnhWbU9sTm5uUmxvWWMvaHBnR0ZPWCtWRFdoMCtKa0ZGUjNSV0dLdlZqODk5?=
 =?utf-8?B?Qm9ybis1Q1luUThteFdYZVlxSFNLL0hodXpjK3Q2d0VMQ3NzT2ZPTm9md0Ew?=
 =?utf-8?B?bWYzQm9CR3pKemFmVlZEeWhsbzZKVG9sNnVnQzFFbGgxQ2UraGdFR3FySUxG?=
 =?utf-8?B?Z2YvZ2VzZ2p4bHRuU1RleThrU01IUDIrQW5xN1VEZ1dYYlZRV0ZVd2o5TnVP?=
 =?utf-8?B?ZkRTUVFTRlBTWHU5VzMvOXdNSkNQTG1sQWY4YmlJM3FxZzloMHFZbE5FMnZ4?=
 =?utf-8?B?Sng3K21PK2RVSHBXYjFsbytYck9zTXZVaDdLTGFKczV6aHZkNWhQVis4VXpB?=
 =?utf-8?B?bjQyaFNBN3BDMEhRR0FNOHpmd295dHBhMWdMc1Vadm5JeTBoZUo0WFE5dWMw?=
 =?utf-8?B?ZzBTU3V3VFBGcm1lTm9hNFFKNHViOW5ZcU1qbkVtNEVHOGtEcFgxWWNNcEFn?=
 =?utf-8?B?M2hNRU9aVXdaM0lMUG9XU0ZnY2RYQkVXMlQ0U1hXQzFUMFFxcG12Y3ZHMXRS?=
 =?utf-8?B?OHNVZm1PYys0WVl0Wkh1aGcvbXFmL1hYV256UkxlUWM4VGo2NitPQk5sUGRP?=
 =?utf-8?B?MFBXMktnVnBuNjNXM1ZUaGN2d1M4a1orSEx6SGk5eHVVOCttaW5ZdFNXZDNx?=
 =?utf-8?B?VFI2MVJXRG1pdHBnNW5NWVcxSER4cFlxajRCaVlWdmFvR2Vpc3ZOSXFMRmlj?=
 =?utf-8?B?SDZDZ2xMY3RZN0xEMFZrelpkWWN4SkJGV2J4S0RuYzhZOTRMb2IxWmh0RHNu?=
 =?utf-8?B?bDJMWVBBU3JmTUpveDJsV1ZUUlFvSEV2NUxUanFEN0ZmUHgvMG4vQjB0RWFN?=
 =?utf-8?B?dnNET05jb2RCcXNlK1hUVHZKaUlONjB2RzRUUUJjMDU3anJUejNVczZDdm9H?=
 =?utf-8?B?aWRpNy8zempwM3RodFpKL1Y5WmhKVUprSmRMellPMjV3TDhHU1VlbkJsSTdU?=
 =?utf-8?B?aGNGMkpxVkVzM0JrVVU0NTVDY1NnSTIxZUhwZG9NM3dEc1NyelBNemkxMTA0?=
 =?utf-8?B?Ymt2RU1BVUdiZnVVNmdKM2VWbWJpUXVzbTFsbm52VDk3Y1Yrc2VBcnlYWWp6?=
 =?utf-8?B?cW9DbkpvVlpLT1N5M2tiZmtVQTI2cmhxdkhvNFAwZFB3MFZzRk5wMHZ4V0c5?=
 =?utf-8?B?U2VscXMxL0d2YkJaYjJ0UTBUd1NQVEl2azZjV1NqTUJQd044SzNIVTJwd0tk?=
 =?utf-8?B?eTdxc2tIeWdBcU5OaGNGeTFSUm5FMFJWb3FUVlhaQVgzWnloZjllWTJ3UHlo?=
 =?utf-8?B?dWFWV3ppeDlLS3NQcFRGV3ZqYlgwazdwN0l4dmM4NFlldU9UVldaZ05XNi8v?=
 =?utf-8?B?WTdvU0pTbE5FTCtJRWZzU2dhZjI0V0NoUFBiY0lTcDk3THozTmtmMkV1bVA1?=
 =?utf-8?B?ZlRmVUFOTlJPNkJqbXBGQXhXUURKQ244SDIzK1V3SXlmOHAwWXFRVFNvZk5p?=
 =?utf-8?B?ZTFKMGFULzIwMllTc1NwcTZPSEQyYnJPOTROaDROSzY4azVKUlJNbElJNDd1?=
 =?utf-8?B?Yy92RjAzTEQvdGhlcG4xQUI0TURDTWxQYnJ2RjRkRXc1UkxmMk5tRU5ZeTNo?=
 =?utf-8?B?dmJ1RlJMQjZXbE5RVGdIRG1mbjlzOUhOaU1oSnlOdU9nZDlWTC9meVBlQ3Rh?=
 =?utf-8?B?Z1AvL3RTNnN4aStuZ1pHTndBdjJueHdWS3E4R1hUWEFDVisxWlB3YlRhZ05M?=
 =?utf-8?Q?UY1F1KWor0q1S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L013U2RTOGhnYmZhWmdWamU3TWdKeEhWbnVrV0VYYTJ2UXFlY1VJaUpwaTZD?=
 =?utf-8?B?bHZDSjcrTEh1TGlEdlV1MlBMeGIrRURadVVOM2NFdDl4Ky8wVU5NTFkzaCti?=
 =?utf-8?B?UjRGS2Y2cGdFbHllWWc5SkxNWUV1UndFdktVUjN4WlIwMFhoS09CdGNaRElE?=
 =?utf-8?B?cjlYaHpxd25XMEdtSEErM1c4UytpdUZqR3Bmb2lvMExrdUtVMGo3WC9WVW00?=
 =?utf-8?B?cEFlYlRqd0Vmb3JSV2FhbjdTOTlwMnBEYzNLS1cxTUxlcWt5Q1dXa000V0NY?=
 =?utf-8?B?ZUxzTGREbGppYllqOWNjcEhseUZZeHRSUlBaVVh0cENOZkRpWmFwQXdCWlVu?=
 =?utf-8?B?SHp5K3lrNktxaTdvRUtsSFVQYkZIV3VYeXl2Z283S0RybWl6bjNPcXhMM0pC?=
 =?utf-8?B?eDJJK0FMSFZUOVB6a0hYT0ZYa3ZxT3NJcVdsOThMaXR6akJyMXBqUDJnMjJM?=
 =?utf-8?B?c1R3ZkVNVXc2U3pGekVhajJ0OVNRSVRkRktmUW1uYW1QS2w3Z3VTZndDdld5?=
 =?utf-8?B?V0hhbHhtVmxTUTJMbDV0a282cWM0d2poWVczQ0tzSVYvcXVhOVBJWXFmMi9k?=
 =?utf-8?B?cjNCbkFHakVFWnR5RG42MjE0ajNhZ0pteVlvZjZWdkU5cllRbnhSdWh4bjZH?=
 =?utf-8?B?UkV4eCt6SnNza2N4V3p6TEtldVdkaXovTlZxd3pnNmFreVZtZk8wTTRaL05V?=
 =?utf-8?B?KzgvTXZFWTM3MmhOaW9UMk53eGV2eGg2V1F0Z1FYdEUwUVV6ZlZGSk14UzFO?=
 =?utf-8?B?R0JjSE1aaytMQTdGU0RnWHJOVmRqYVJYS21ocHlwS080SXpsME50NDhrUnNF?=
 =?utf-8?B?M3FyYTI0Z2Q4Zm9URTg4RTlBZCtrK2dFUVNSemxleUpwWHU5Y2ZpNEltemQ0?=
 =?utf-8?B?QkdYaDJHU252SEdtNE92M2xmMWJyRDlSTGJnWjZpNVU4NitJUUlUMkZWK1R4?=
 =?utf-8?B?Y0VXWUZWUGxjYXlhdkR4Uk5FdnZWRE9MNFJodWgvRkwwMVhLZ255R2xIZVk5?=
 =?utf-8?B?Z0JBQlNjOTVlTVREMXRQZVNOcG1NeExlWkJuZHA4OHQ4dUNsVEtnNU9kNitI?=
 =?utf-8?B?NS9wSEc0MUJ0ZzRPaUg5OFBXMDFzanJsVmRlK2g2cUplMkFycHRKV3grODhH?=
 =?utf-8?B?V1ZrYllQeFUvMTdMRE9aQjhSUzI5bGFxTDN6RTBNSUFXV3JqYThnM3pGYmhM?=
 =?utf-8?B?RFE5ZzAyTWFTaW9qaGtsaUh4aDlHamw2ME1mRExGOFU5ZVJnMTFCTXR0SEo5?=
 =?utf-8?B?NE1GOFgyQVJQcW53MmJBdjFpZnRCc2pXZnVNK2NDak5HS2swcDhvdnQ3bUtM?=
 =?utf-8?B?dVJZR3JTR0UvbXU5elpjSHozajQ1Q0kwOWNmcE1aSi8xMnYzS1h4eDlIbGt4?=
 =?utf-8?B?akNncWJXZ2pqaDU3TUI4UWdBTEtEYU02Y25RYjJGQnJDME9KMHlpMzFxSXRx?=
 =?utf-8?B?V0loZ1B4dndseUlKQlBGVkVva2QrbFpGRmZJd2JpaVNtWjBKbkRjMlRnVmhp?=
 =?utf-8?B?UnVXVFRiWWZlVmFPV3Y5cEN6QlJZcFVLbDMxZmtQN3hDZlpyRm8wTzdzNHoz?=
 =?utf-8?B?Z0xQTm4wV2R4YWVUYncxOE1GM2sxKzZJNnZwYklrcnAwdkR5dmM4cHlUSy9r?=
 =?utf-8?B?RWtzRDZRcEZvVytaU0ZCWVpEajlOUW03SHRyajhlMmhSL21ZMnJrT08wYjU5?=
 =?utf-8?B?WDc4RkUycW5lakhucU52d0tlSFhJSFZORHlrUG1jVTRUMndkbEIxbnNIbktn?=
 =?utf-8?B?MVhZWngvemFMcmhncVJsWlA4Snd0UHdoaFoyb2NFUWZYVVEvWlN1cDBuZGNu?=
 =?utf-8?B?d05mQk9YVy9ubWh3YnBWRTZWcnJWR1cwaHg5WlQ4U252aXNGenp2NVdOTS92?=
 =?utf-8?B?YVAwQ01rOFpkb1FlYkZUdm9kdVpIcldFbFNzVWxZNnN3NTFKSTFhTW5Xc1Ro?=
 =?utf-8?B?MFhPeHZaNXZMemxkbEd1aW82MDZVeVBhSTA2SjFQVnVzcGhLdjhuWFc4TE9n?=
 =?utf-8?B?UDVqNTJYc2RVeW5UMTBPY0xKMmlwVmxTdTMwQytmNFdIQU01SE9iTmdySzZr?=
 =?utf-8?B?SzVZZFlmbk5qSEtWWEFyc2VnOUsycFFxTEw4VGRubGJ5aEhPbnZDVmFIdXhR?=
 =?utf-8?B?eGhiTEt6a1pJYTRKMTBycldaYXJDYlhQcmhya0ZlUTVqbmFRY3oyVXpMTnhZ?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af63a0d-6f02-4d1e-a68f-08dd51384e9f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:54:03.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvToEUt3R4DY9gYHN4YswQYirbCOmAUy1PiACmlEszkKdSAi+IflWLo/MprHVatMz+ri3XTyoga/sy3TzxeUiXewGS6//jc1+y6QxlNtEb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> The struct rdt_resource default_ctrl is used by both the architecture
> code for resetting the hardware controls, and sometimes by the
> filesystem code as the default value for the schema, unless the
> bandwidth software controller is in use.
> 
> Having the default exposed by the architecture code causes unnecessary
> duplication for each architecture as the default value must be specified,
> but can be derived from other schema properties. Now that the
> maximum bandwidth is explicitly described, resctrl can derive the default
> value from the schema format and the other resource properties.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v5:
>  * Rewrote commit message.
> 
> Changes since v2:
>  * This patch is new.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 16 +++++++---------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 +++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 +++---
>  include/linux/resctrl.h                   | 19 +++++++++++++++++--
>  4 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4504a12efc97..6fd195b600b1 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -143,7 +143,10 @@ static inline void cache_alloc_hsw_probe(void)
>  {
>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
>  	struct rdt_resource *r  = &hw_res->r_resctrl;
> -	u64 max_cbm = BIT_ULL_MASK(20) - 1, l3_cbm_0;
> +	u64 max_cbm, l3_cbm_0;
> +
> +	r->cache.cbm_len = 20;
> +	max_cbm = resctrl_get_default_ctrl(r);
>  
>  	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
>  		return;
> @@ -155,8 +158,6 @@ static inline void cache_alloc_hsw_probe(void)
>  		return;
>  
>  	hw_res->num_closid = 4;
> -	r->default_ctrl = max_cbm;
> -	r->cache.cbm_len = 20;
>  	r->cache.shareable_bits = 0xc0000;
>  	r->cache.min_cbm_bits = 2;
>  	r->cache.arch_has_sparse_bitmasks = false;
> @@ -211,7 +212,6 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
>  	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
>  	hw_res->num_closid = edx.split.cos_max + 1;
>  	max_delay = eax.split.max_delay + 1;
> -	r->default_ctrl = MAX_MBA_BW;
>  	r->membw.max_bw = MAX_MBA_BW;
>  	r->membw.arch_needs_linear = true;
>  	if (ecx & MBA_IS_LINEAR) {
> @@ -250,7 +250,6 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  
>  	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
>  	hw_res->num_closid = edx + 1;
> -	r->default_ctrl = 1 << eax;
>  	r->membw.max_bw = 1 << eax;
>  
>  	/* AMD does not use delay */
> @@ -281,8 +280,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>  	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>  	hw_res->num_closid = edx.split.cos_max + 1;
>  	r->cache.cbm_len = eax.split.cbm_len + 1;
> -	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
> -	r->cache.shareable_bits = ebx & r->default_ctrl;
> +	r->cache.shareable_bits = ebx & resctrl_get_default_ctrl(r);
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>  		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
>  	r->alloc_capable = true;

Using resctrl_get_default_ctrl() in the architecture code like this seems awkward in
the way that the caller depends on resctrl_get_default_ctrl() returning a bitmask, thus
requiring caller to be familiar with internals of function called.

> @@ -329,7 +327,7 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
>  		return MAX_MBA_BW - bw;
>  
>  	pr_warn_once("Non Linear delay-bw map not supported but queried\n");
> -	return r->default_ctrl;
> +	return resctrl_get_default_ctrl(r);

I wonder if returning MAX_MBA_BW directly would not be more appropriate here ...
or returning r->membw.max_bw and doing so in previous patch.

>  }
>  
>  static void mba_wrmsr_intel(struct msr_param *m)
> @@ -438,7 +436,7 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>  	 * For Memory Allocation: Set b/w requested to 100%
>  	 */
>  	for (i = 0; i < hw_res->num_closid; i++, dc++)
> -		*dc = r->default_ctrl;
> +		*dc = resctrl_get_default_ctrl(r);
>  }
>  
>  static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 23a01eaebd58..5d87f279085f 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -113,8 +113,9 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   */
>  static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
> -	unsigned long first_bit, zero_bit, val;
> +	u32 supported_bits = BIT_MASK(r->cache.cbm_len) - 1;

What is criteria for caller to decide between using resctrl_get_default_ctrl() or
computing the bitmask self? Most callers already seem to be using
resctrl_get_default_ctrl() with clear expectation that it will return
a bitmask or not so it is not obvious why some callers needing bitmask
use resctrl_get_default_ctrl() while this caller compute bitmask self.

>  	unsigned int cbm_len = r->cache.cbm_len;
> +	unsigned long first_bit, zero_bit, val;
>  	int ret;
>  
>  	ret = kstrtoul(buf, 16, &val);
> @@ -123,7 +124,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > r->default_ctrl) {
> +	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > supported_bits) {
>  		rdt_last_cmd_puts("Mask out of range\n");
>  		return false;
>  	}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1e0bae1a9d95..cd8f65c12124 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -978,7 +978,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
>  	struct resctrl_schema *s = of->kn->parent->priv;
>  	struct rdt_resource *r = s->res;
>  
> -	seq_printf(seq, "%x\n", r->default_ctrl);
> +	seq_printf(seq, "%x\n", resctrl_get_default_ctrl(r));
>  	return 0;
>  }

While the function is "rdt_default_ctrl_show()" the file is "cbm_mask"
and so here also resctrl_get_default_ctrl() is implicitly assumed to
return only a bitmask.

>  
> @@ -2882,7 +2882,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  		hw_dom = resctrl_to_arch_ctrl_dom(d);
>  
>  		for (i = 0; i < hw_res->num_closid; i++)
> -			hw_dom->ctrl_val[i] = r->default_ctrl;
> +			hw_dom->ctrl_val[i] = resctrl_get_default_ctrl(r);
>  		msr_param.dom = d;
>  		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
>  	}
> @@ -3417,7 +3417,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>  		}
>  
>  		cfg = &d->staged_config[CDP_NONE];
> -		cfg->new_ctrl = r->default_ctrl;
> +		cfg->new_ctrl = resctrl_get_default_ctrl(r);
>  		cfg->have_new_ctrl = true;
>  	}
>  }

Using resctrl_get_default_ctrl() only seems appropriate when setting or staging
the register values where the value returned is not further manipulated with
assumptions regarding its format.

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index cfe451ae6ded..a939c0cec7fe 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -216,7 +216,6 @@ enum resctrl_schema_fmt {
>   * @ctrl_domains:	RCU list of all control domains for this resource
>   * @mon_domains:	RCU list of all monitor domains for this resource
>   * @name:		Name to use in "schemata" file.
> - * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
>   * @schema_fmt:		Which format string and parser is used for this schema.
>   * @evt_list:		List of monitoring events
>   * @cdp_capable:	Is the CDP feature available on this resource
> @@ -233,7 +232,6 @@ struct rdt_resource {
>  	struct list_head	ctrl_domains;
>  	struct list_head	mon_domains;
>  	char			*name;
> -	u32			default_ctrl;
>  	enum resctrl_schema_fmt	schema_fmt;
>  	struct list_head	evt_list;
>  	bool			cdp_capable;
> @@ -268,6 +266,23 @@ struct resctrl_schema {
>  	u32				num_closid;
>  };
>  
> +/**
> + * resctrl_get_default_ctrl() - Return the default control value for this
> + *                              resource.
> + * @r:		The resource whose default control type is queried.
> + */
> +static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
> +{
> +	switch (r->schema_fmt) {
> +	case RESCTRL_SCHEMA_BITMAP:
> +		return BIT_MASK(r->cache.cbm_len) - 1;
> +	case RESCTRL_SCHEMA_RANGE:
> +		return r->membw.max_bw;
> +	}
> +
> +	return WARN_ON_ONCE(1);
> +}
> +
>  /* The number of closid supported by this resource regardless of CDP */
>  u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>  u32 resctrl_arch_system_num_rmid_idx(void);

Reinette

