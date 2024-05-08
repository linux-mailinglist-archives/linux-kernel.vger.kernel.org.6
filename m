Return-Path: <linux-kernel+bounces-172557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0548BF396
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6697B1F21350
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42B387;
	Wed,  8 May 2024 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bow2ZU6Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B33201;
	Wed,  8 May 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127739; cv=fail; b=DpnyqZZ6je+DR/RT7COnnPkb+8U8mXRtNrxDC2jL0OLU7/OG1pQwOgQELT+9bVqVkZyAp0raGnCNLHfz3U+COUL45P/3IGdr2ju+xWFx4cNGhu94BHQGWTdjIv0nzaCvExWyiZMPoJ5z+3dBSTzCMfDX21BuVRoBZfrcB0bM6P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127739; c=relaxed/simple;
	bh=LWdjatoeJOFac/7FuPVHzAY/BetjgtRjNpmNYI3KNdA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eo4Q6PlWwoAYFNZ7+ke5KKJILSX7HdoyyaYxpd9GchYoWQv49XZgJKxxVdCLL7GR813v9hLNRdK1OF7uETshdtm685PKmsSL8bjetpakOM9radeEHxbpX47jvpSd4+utQ+33PlWxWvWTa9SYfmDD8ModrfXKVyCP8n/JydUIP7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bow2ZU6Y; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715127738; x=1746663738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LWdjatoeJOFac/7FuPVHzAY/BetjgtRjNpmNYI3KNdA=;
  b=Bow2ZU6YCW41FVTCMLGdOf33qN7p8v3/qsGiXYq3f4pJrM1hKmxjHtgC
   Jgybb/FIS//dzwd5MMzgsHe0d2Bj/yBWHYVGecgssivqnp4N6Wqh5wVnX
   yaXLMoMbOz5I63AKhzD0y/IYGwHNAcnZHtB9IflqJpYr4kQ9PzycfoXuj
   mpUGXmjJgJWma0X3rXrWOGMbylGGkb9Mubp0BDECHSLvVkq8E0UuIzunF
   0yAYV3+LO5HZnxvA7NMyPwvqLdaBCIh3deDbeFO/YRmBz7LrilzJcMfyv
   IsIFqE6vrlTj+0K7R5snxG71NL5FEvkcHOkNecdpkdSAXQTAK/4AIkxS+
   Q==;
X-CSE-ConnectionGUID: ZnjCDveCSpSG4yxPeHDb0A==
X-CSE-MsgGUID: aDJcMhS/SRC5upJWZypACA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11120747"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11120747"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:22:17 -0700
X-CSE-ConnectionGUID: bNHRGM+jRVWvfMikUW6Vzg==
X-CSE-MsgGUID: UFm0FxKJS+2V1ylF3iL+bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29234305"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 17:22:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:22:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:22:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 17:22:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 17:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQNcwM+xSV/CQ+En0Z1IJdcPA22wR1hRG1u+5VVdhIvt4pdtMRi4L/9xmudvS292MzWMeIspdcQJ9e0MsKCEo3RX2Z7CnsfRdFSE4B3wf4irplD3alTIV4WTo5xKoHjXzka8Cukc2GsoRkgJZrXEA3ZaJXBbzedXOVJcaEH5P8ranizPcXW0zMgw0qUSefu3QLzLS18pDt1LVnpZQv2oH029S/bBJlJabhObo01jLNscwmdfDK6llSitpKaGHibYTzvxbMJO8Ag2CRy4IuueaZn4dAmartajIyAlnZnoUW6dTWlcU9FBJ3gfZAjHPx8xyTSKV2RSiUbh0yD3VpcAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxLU6RuRr82x7m+aKtJYngkxzJzkX10irD2Sq8nOZGk=;
 b=OSjFJPOHZxyFDrTwg5vCKFcLnDkIEw10CgRns6qQ5pyyHjLiVwALj1rpKwrkMNUten9g+0cSwBV9fyfdoxt7wXoAwZYH9VpR7yG7kLo0ARYwxvk/tsrijJvnkvecIfyZ3PsL6yEm/Us/65Qktfv0ZXM8VpLiUTrfz4SFbJm2gUVyn/0shyZIF3ZgkE55jIeEUS1An/rsL3FXU3lE7C8oCCFhgq4nMd5M+k10lLzGY75O5Hns9HEz4x/F6nneEJ7GAPBxAxcjpUefcFXkBbfNUEGjRcoT211/9xHFN634fayvACiCe4OalaOrxNK3fD6rB1tdT9TrmHffO0qzAGaK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 00:22:14 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 00:22:14 +0000
Message-ID: <748ca5b6-25f9-4636-98aa-9b7c379846f4@intel.com>
Date: Tue, 7 May 2024 17:22:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/intel/ifs: Initialize AMX state for the
 scan test
To: Hans de Goede <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<tony.luck@intel.com>, <ashok.raj@intel.com>, <jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240430212508.105117-3-chang.seok.bae@intel.com>
 <5337c72d-1642-4cee-88a6-db9df97a01f5@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <5337c72d-1642-4cee-88a6-db9df97a01f5@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 65713a44-bf20-4a90-2816-08dc6ef4e8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBhekJLTldMRkRMeUdvVmNIdkxjeVdmYldndGFwbWUyMU84eVBQM3lUbFBC?=
 =?utf-8?B?bGxRSy8rRkxycXhrcm01L3RLY0I1YU1ZdGxTY3BJQWZFUjRFQ09mZGwxZ3Qz?=
 =?utf-8?B?WkhhYnBsQVIzMGV2Z2h1WlJQQ2hDbHRpS0NMTUhrVE9vNC95ZFdIOEtjeURm?=
 =?utf-8?B?ZmhyZ0RNTU1PelYrTkcrVEtqZ3VZVDluZEJlTExrRnpyRGxGL2cwQUNWaWRt?=
 =?utf-8?B?Qnl1eFg3czhTTDFhZGFwY2l6b3RhNXEwNEkxakk1ZG9jRDV0c3JqRXVxWFAv?=
 =?utf-8?B?Y1dSRlF0bE1jaGZDcEpkWWxHamZySEl0dWdyTlVwQVhlajA0Qis5VDBnbHUz?=
 =?utf-8?B?ZE5IODl4dFFXWmtuVGpXSTNxSGNhSTJZZGlqQllwc2NHMFJWNHpWSnR1Wmc1?=
 =?utf-8?B?My82b0JSK0M5MHl3ZXlpR0pzTVpWNWEzWFowZHRuWXMyRzlUZjBCZVRmREx1?=
 =?utf-8?B?dnkwQ1o1K0ZBNkkyczRSQXhDVUpiOTNFaWtIZFdscCtMMDVIeFYvTHd0azha?=
 =?utf-8?B?TXZoME5rSmdaYVJZRmQxdlpGMVc0V1ZrRzlaTURwakQ4a0ppV25KelUzajVF?=
 =?utf-8?B?dkVRVW1NbTV3VFNCYm1HTmZNVVBGdGVCMC94bC9HV0VVdmRheFh3OFo5ZzNl?=
 =?utf-8?B?MGRoVTY3NVhPNFhHZ3dib0FUR1l3cXhkSmUveEtnUnFUYW1UNlgxTElIR2dD?=
 =?utf-8?B?MHZGdkZFQm5LZVQrczJvQnF3OVdJemVHRno1TGtkS2hodmtIMXhoWGVxODVJ?=
 =?utf-8?B?aGoydW0xbjFZdlpmZlZzUFVTTEdOQVI5UndoTUlwWlBuM3ByWGpYTURuVm9X?=
 =?utf-8?B?QjdEcGRzUjNqKzVIbGd2Tm9LV3RPVzRlT056K21zOGgrdkIzaEJMZFZreHBQ?=
 =?utf-8?B?aUNtOHQxVnpkaXF1ckNsSzdXa2wzUklFTC83T04xdU1vd2VSaHJLSUxNWkpq?=
 =?utf-8?B?L1pqZVJwSEJibU5za0FFQTBDdHVMVmh1c1N6WGpiZHFUb3FsT1Nzc1ROYlRx?=
 =?utf-8?B?SExoYTJIM2N0ekZ4WEdhN2FBaC9sc2hhV2NkQWpqekkyUkVUL21lTy9kYkY2?=
 =?utf-8?B?aGVDa09BbzZwWXIyOHdLSmJyejVaUzVnaXZFM0pRc0VUUWw5Ulk5T3BiNHhZ?=
 =?utf-8?B?RnI0NnE2WEFoR2VuNXl2RTZqZXlpZk03R25lZDlZN2IwRkx4aEE4ZnlBTFNI?=
 =?utf-8?B?dVJ1K2xpNWcwRGVCSk94QTJEa29yU0x3cU9Pclg2cm91U1JMT0UwMWxMMnlT?=
 =?utf-8?B?Z0tsTUtBdDR1N0trbmY2R2RHSlhYZTZqeERlajFMNWJWM1IzTnJGdkRSK3dO?=
 =?utf-8?B?WTl2RytaYlV4YW1XVW81aGwrbWt5UnJzSDF0RXBQb1pUaWlpcGxUT1NQWk5m?=
 =?utf-8?B?bUlGT2RUMFZJWE5wR0FlRXJkQVJCUGFHQldrbU8ybGczK0xRUldNOU11MGp2?=
 =?utf-8?B?bEJLeEJrWWVQbU9YOW1Gd0hSMEZXTEJobVV1RTRyZGJpS3hKTkt6dm04RXUz?=
 =?utf-8?B?amdtT1pkNnd0YVZaeDh5NlBIR3BSMFBzbi9zWThoSnpCaXozSkRkSytBZVdL?=
 =?utf-8?B?SG12dTNHSlBpazBZc1l0NEhQVW5BWElDL1FQRXFwd1RtUEFBQzdhV3ZKZlU3?=
 =?utf-8?B?aFFKU0ZQQ1V3QmxhWjUyUXB6MTNCODg3dnpPWE1rUjFoM1ZyK1o0WDJKOXpw?=
 =?utf-8?B?bVRSTXBkcFNRdVVpditHZFc1Y2lOeXhnbGJ4eUY2MzJPdWJUeTEzT2FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk52VkNEVzJPaEZIOGMxc3VNeHpaaTVZTUpTZUpPMk5iNTVzbWhYQUZhSUFo?=
 =?utf-8?B?bDNJVm0rakFobHZDbm84Q2kzM3FQR3FCV3dqZGJkVk1TUmRiUlBHQkJxU0Zp?=
 =?utf-8?B?emltYXdDTWNEd2dpV1U3SFFRT2FLdUpGaHNLSzNYSnQ2UXBQbUJFYXI3RHQx?=
 =?utf-8?B?eEk1UEtMUFN5dnc0ZVNTQTJBNERyUUM3SmZKdmxXcy9Cb3d0S1JndTc5c1Jh?=
 =?utf-8?B?SWtiOHllMCtZZXVHbkxwVXREaVNkSDRNVVVLSFVJQndubmJETEhsRlowbWxt?=
 =?utf-8?B?T05SK3ppWkZ6TllmYndkbnJLNUJLZ1JhOHJQL2FsTFZabXBpeEhTNmVnaWt2?=
 =?utf-8?B?NDZKeE1QMkwxZVdHUUJUZnRxRmxNSElWTzJIUy9ZWVNnQnQ5SGVHNm9Sa2cw?=
 =?utf-8?B?ZE1jcHZma3dsNitCZWFVUkZjdlNpUURaZkh1clVsWUM0UGdVSHN5aXNGOWpp?=
 =?utf-8?B?eS9vdjlkYTJObFZtdllYUHVsSG1SSGRmK3MvV0tybDNhMGc1V1pZZ0lDNm1T?=
 =?utf-8?B?ZEJMUWxyWXpCTysrS3JtYlU4cHp0MElUdjBRcEsxZ09xaHpkT2RIVk80R1Aw?=
 =?utf-8?B?Q0NkbDc1U0QvMUR6Ri9iNVlUc2pETll4MkU5V2RqUXFrUzkzTmpGM0FuNXNr?=
 =?utf-8?B?Q2hrdU5BNUhIRkVrU2pGRDlJdFJmWFFDbTFTM3ltbU42a2oxV0RzMHVVNThR?=
 =?utf-8?B?S0VlcldRS2EzQWdoUGFMZGVCTzQya0VFYXNDTkw0eWJ2eE81STBYNnNFYmJC?=
 =?utf-8?B?VC82Y3ZnYVlZZUlGbkl0QUxDQThlM2daRzZsYmtEeE42OEQrcFI2NmF6US9X?=
 =?utf-8?B?MmFPNDdSYWRtN0ZZRnRlRzBucW1reWlTSE81eWdXaUk4Qm96UDRwei8yMTRL?=
 =?utf-8?B?RXYvOFVKbnM1WUNPTVhmNXlPQmtldzI0cytucitKYk5rZUxVM3FiVzJXVW85?=
 =?utf-8?B?eU9Ia1FWY2twR3dzQnI5RHJnRUFpVmZBQ2NpN0h3SDh2cGxac1pJWE9wMXoy?=
 =?utf-8?B?aXI2RWI5YUZ6WUU1anNMNzZEZm9WU1Q0alNwZk0rdFNlemVXLzNyYVVVeUxX?=
 =?utf-8?B?ZWhUQ3cwS2pEbmpocy9aZHVqVW5WdlhoZUIrSk9pdDBadGhqVzFDbGxBS0Mw?=
 =?utf-8?B?VXpIU3orNnExRG5kYytuS09JU01qRVZrSFMzMnppUXJnZkhjUm8xNW9SemdN?=
 =?utf-8?B?YUpMNU9MNnNkeE95Yk0rK2ZLR3RoWHN0elk0WW1XSksxKzc0M1ZoUG1hWitu?=
 =?utf-8?B?YzY1WGFOSkxhOURwcEQrVHlheFRqNXdqYjBiUzFvQXJUZkdLendVY1ZGNlox?=
 =?utf-8?B?Tm9OcVBSQkpTRUZoT3Iyb1BrNUhveGdoVkpDMmUvaFdxZm9tdWJvSHlBaUg5?=
 =?utf-8?B?RzJxVXdsWHdWVmFTSndFaU85dS9SMDlNZUU3dVNwbUZFaFBDNjhHZmdMVHd2?=
 =?utf-8?B?b1FOUjZWZjZDclI1c3pkSkhVNlp4N2pYVlFNVGhiNHRtOXM3SUdNZFZoNjFt?=
 =?utf-8?B?MFdJN1dVcUUrNDYrdXdmWUR0Q1FPVzFLU1gwTGw3OXhOY1VUdFVMK2g2a1pn?=
 =?utf-8?B?RVl0WDdxZmswbUpTME5VL2JCMUtuWkNBTFZCK2ZIOVRXK2NHcnVvRnNtckpS?=
 =?utf-8?B?T3pLdDlwL3MwK2NxdnQ0S2E1Rll5dUp3cGxOUFNxbCt6UnA1WHhDWURCTkxT?=
 =?utf-8?B?OFdCbUY2dFNadklNK2p0YW9TT2ZNY2NpalZPdDIwNUMvdWxwKzUrNjFpdXdY?=
 =?utf-8?B?WlRhV085RXozZGFaZ01xelRETG5icDBsVjJpaFNwOXZpcm4vOXlZbTYrZXRI?=
 =?utf-8?B?M2JNVXJQMHJmMm9vdXc3ME5jbk40VFVZUFRma21RNUZ4VExPUmNtQ1RKcjlR?=
 =?utf-8?B?TWFROEVyOG5EazRMMTkzSVd3SDBraW82MDYxUTUwcUZyU3p4V0pEOHFmc1Yv?=
 =?utf-8?B?U2FENjI4cmwrVTB3WDNzUVhrT21waXRQNGdIL0lCUlhrTnliSGNMMktqL0Jn?=
 =?utf-8?B?b3B5V0RXSHVvOEErdkRFcjZGbTgzM01RV2FBem1KWmlIL1RybzFUQVB6cnVT?=
 =?utf-8?B?a3pWNkxCeFpzeUV2MGNYZDRRTnpqTnV1UXIrbW1FYXFwMUliUG1CZm53UXl5?=
 =?utf-8?B?TUdUYkRGQVAyZTBmMk9vMzNFWWVzNVAvNHhkemExd3BIOW5pVUM2dkV1Szh3?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65713a44-bf20-4a90-2816-08dc6ef4e8e9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 00:22:14.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/jPVeHVVSrWEj2BhrOlm09JqqhXpYw1l9np+ZCo5rfinNkJlAs0V4QCdUi01UmVIoUIGc0bEWByWvbJX4iFO1fW7llC5vppSMwXE4Scncc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com

On 5/1/2024 1:58 AM, Hans de Goede wrote:
> 
> Thanks, the patch looks good to me.
> 
> I believe this is best merged through the tip/x86 tree together
> with patch 1/2 :
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> I have checked and this should not cause any conflicts with
> the ifs changes current in platform-drivers-x86/for-next.

Thanks!


