Return-Path: <linux-kernel+bounces-290339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8544B955273
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB41F23EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE91BDABF;
	Fri, 16 Aug 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl7eSmR0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742994315D;
	Fri, 16 Aug 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843998; cv=fail; b=mN3MTOCUl/UPwBmnHEp3OkXFoJ5eeqQBAKOsmy6DCvhXucAyuz/5O3QYULbZZTWLiyz0sqBlkFhreEw/vGJYkICEGl3dYmhxFr2YlYMAxrXsGP48/C7HYn3uK6WQ4BHF5lQd58WDqe7HZxRNAdviMdoXKYoigJtU/Qu8WaPN6oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843998; c=relaxed/simple;
	bh=UwU2eoqSEb9sIpaBsNVwPd1/B6RvEEif3aWb0/idKpM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTSACmBEwPqrxsvnSwounct+3XoHwzQzpCGd7WrUIu5/OlsnXPih6qZtX/477e+b/kDGccFzD8IlakAW9j3VqGfk9veoTNu+jBUsHHBK5Hfxm12rKuPy48EejaWOSy1+8SoqEJaVG/cQ9eXS1txZhi3tXiBnOAzgZsn+OPjDaj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl7eSmR0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723843997; x=1755379997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UwU2eoqSEb9sIpaBsNVwPd1/B6RvEEif3aWb0/idKpM=;
  b=Wl7eSmR0Q/Zmtk7zx0D2eprBZZ7ZSTdXlK7gFE/zqWHwnWioSFqdafmW
   +Aozit01x2E/S7kGLOU6MnbHJkOb8VpNYExTQjKx+0+9wggdbXJ+bjGgK
   BIlDDca91yHX0Stqrhzla06ru/uydw4IYPBSi7927Z1y/YMmAFKB21x25
   CrTqofC56WKULy8kEUiN3wPKqCZlJYwz8RFtQEj+J6RSQ/c66Q3QKSZas
   +sL99eZCZVy7fPiegTBLkbR7v7/X4Bj9PQrT2DuZxx3ON7Z9vew9pAzpT
   i464m40J1S1qzkT0BOQP0i8SeDIaTwzo+U3+G1DDSdKgIC9beuMKs0Apl
   w==;
X-CSE-ConnectionGUID: qFNxNYVXRgm94xkfO1DHsw==
X-CSE-MsgGUID: QHn2TG3JQWOYWVEAMAA8ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32823329"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32823329"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:33:16 -0700
X-CSE-ConnectionGUID: pQZsxl+2TwuYNQUUgrQ0hQ==
X-CSE-MsgGUID: WYCp7nGUS3Gtsx1r/GIfyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64619147"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:33:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:33:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:33:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:33:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDLbHd/qGeiG/RxqpEto/QPReSSvVL2kekP2fjzBXjZH6Vr2ot/dUnY9JO7arHyaf2TiHPpqiTtt5tthPF45Lpn1iff7eYP4YWF0eEVr7i+YEvPxnp8bZk+qmtLQD9+4KWMTEAZvYOSHFstK0bmV1FHZ0QFdE8/iT1q5Uld2REXCtTYqGBRQLgdancm34NRfbog8ZJt0TS9UTS5zNk3lS81tNCN3XTFNszSKM0OHOgy5N7pVCz327w/uRMDS+FKdJAQEXevE+9w6LAitVLdMJqsJKOp+hVdIfMiuZHyNVqEv6tbBi0fWfvwsAtYLWSRkR+MVPJ6oHtSCTYsa/9CtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz/ocfJc0G6UCiiMMp9M8ubxPNHUpPIv9BetZAxsVA4=;
 b=n8xjSKX1L5f9j6/NVWWQDo1F423+RpJtretaXlgOAKdYy37PCZ3i7f+c2LQON8VQO+AvxLgn3z0jbcdyYkc0EDZoEmf/+G5HJWlEH6dxzfX9ZtyA+5LrQL+2BP+z0SVQXGHbivZ9+pRN7LlQ+rWtAd3sgpms5YLnbEbDDOcYkplCLQiohAavnLP1sc6zGTpwCDHlnNISAYuIG4PhtbK0sZER5Qghg15dCIMKgkucJCksl1k2gzzW2pCWiYvQTe3f2Y+mBB8sI+JBNY44dDn9JVd30Em3gpfP5HXBYpV6wdee8rU0RZmja0SMs2Bc3gVQ5SP3635jWsE5sNTIoKOX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:33:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:33:03 +0000
Message-ID: <5e2fb414-3593-4d1d-b47c-a7dafb454e0c@intel.com>
Date: Fri, 16 Aug 2024 14:32:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/22] x86/resctrl: Introduce the interface to display
 monitor mode
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <c8503402c5dcb17012b2010f6accf00db245dec4.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c8503402c5dcb17012b2010f6accf00db245dec4.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: e897a04f-42b7-47b8-a2f2-08dcbe3b0222
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE1BbzE4KzEvTGJUN2dHWUVSTUhTVlJmR0M4ekFFTERObGlWVkZGYVpMR1Nw?=
 =?utf-8?B?SXM2Z3paaEgzNkdFYzR0ZnFieWFvOHBQdUkybDVIWE9YWXlUOGQzNHRDSlUx?=
 =?utf-8?B?aVhaRHREbHNid1B2bUhFcGFtV2phMnlPMGJTd1RjYVR3Z1JENGhVTTFPMGxJ?=
 =?utf-8?B?UHVWYTRReXBPZEtCa3JMMU5McVQ1TjVoeGZjcm9hV3NmaFlvaU04UXUvUUZq?=
 =?utf-8?B?MmZ4ZksvWEhidjZ6M0hKTjJqR1htanpiM091cWZMMzM2UXZzaytvKzM4K2N2?=
 =?utf-8?B?OUZVNVFJc1VIcVJNR0JRUGNBUzR2MTJKeklPRTlhV1dEQnlGZHlKSHBMOHp6?=
 =?utf-8?B?RFd0Z1NWRGNTaHZKemdXd0ZnWW5aNjlZM0NudzNKY0liRmxCcnQrNVYzelBT?=
 =?utf-8?B?cnd6NEN1V2NONjJ3WFgxQ0JiVk9TQjJkai91cHVURTJhOXRhbXM0cTZrTldZ?=
 =?utf-8?B?TkovemtEOWdSekJqR2Y5OFNEcWl2Q2dTVUZzQ2trdkZCbGkzMXV0ZmxwQURy?=
 =?utf-8?B?RE5oai9kWFBPNTV3M0VDQ1RFS3d2VU5HaDB0YUx0ci9LMGNUaDZ1SzhWeTBL?=
 =?utf-8?B?OE84VjNwSFpLRkJTQXJnc3JtSzg4MUxURmQxL0ZtZ2tPV2Q1ZkhKWkhHamZr?=
 =?utf-8?B?cTBhbkFYZUZiWkQvbFkrUDRHejMyVkJIVTNWYm1TTFhxeU9zU05LS09pYWwr?=
 =?utf-8?B?dFdIVFlKQytPSXYzQ0p5S2k2RXNhdDBMYzBFeHlJMUhQWUN6eWtsRHYvS2Jw?=
 =?utf-8?B?dFlEZk9nTjB5R2NUSnpZNnI0elpWM2dXZlRsOEtuQXJNOU9IV1lLRldwWko4?=
 =?utf-8?B?ejhnK0xPY2dlbVlsazZPNnFoZ1Z5Q1B4enZCUFBRMVBmRDY1NkNSV0ZnWS9k?=
 =?utf-8?B?Z09GemdlQTE0dUh5SGhaaUcvdzZZTWlkWHdNdlo2NjhnTkhaK0V4NENtNFVk?=
 =?utf-8?B?RjZFUlFNaFVvS1ZINFhQZzlleGxNUkdLTEJJc0NVa1QyMkh3MmREZ1F2RzNi?=
 =?utf-8?B?emxTSVl6ZGFpTGNUUGM0OTQzUk10QW8ycW5RYkdCWUgvazExSndjSWxYOXBZ?=
 =?utf-8?B?Z21BbkdaaDd3QlRSWnppcExqTmR2cDFQNjNNeXdBYzE4NzU4OXpGaVdBU3FJ?=
 =?utf-8?B?ZFhRemZ6SG43UEFQS1RVZDhudXRpL1hqQ3k2TjdVUkoxcWcvbVZZZEhnTGxX?=
 =?utf-8?B?K05iTStJaGNXTUJ0cVl5YXZPMUt0NVNZV2srcTdsdjdObzl1MWJnWk1VcmdD?=
 =?utf-8?B?ZHhuSDdEOFZZMXh1Z09mSWZHM3dSeDRvclk0TW5UelVPR3JRSGFaSXBxbmow?=
 =?utf-8?B?TlJpZGEwdTJWL3hxZHVvRitrc2UyeW5veUtOc043UDJlR0pnb2VCampJdFJL?=
 =?utf-8?B?bXJtMDQxYkZhSlJqNG1aUGxDZzI5dzJVa3FtUFlGMGtSZUlrQXZwWGFrZFJv?=
 =?utf-8?B?SzdLd0lHZHgxMVVlNHNBQnh5RDhWQWUrcm9oV0JwTmlsNCtCUDZBTGJEWFNi?=
 =?utf-8?B?dzBIOXo1NVQxUXd4K2R3cFZtdk8xbmllWWIzVXR1OVZ1SllhZlRpLzhHN2JT?=
 =?utf-8?B?WnJLYjlXYWFvVlpHQVMzYWgxc2w3blZOTHVXcHZITVJKRzJGNFpRcFRBZUJv?=
 =?utf-8?B?UEZZTGZDSTBXZWg2c2syU2VJeEd3cHlxSVQ2UzZRR0Z6aHRwNGFCQ1VTZW96?=
 =?utf-8?B?dFp5Q0EwZU14Sm9qMkNHZjRrZ3VOd1E0TU0xcEMyZ1VQdFZNK2NpZUlPdVQy?=
 =?utf-8?B?bHdWaXBzR0MyVG0wUzdSWGtReGRuV0NPL2NFTm5SbXVMVEdENVFYUk5mN3JJ?=
 =?utf-8?B?bGh3ODVKUTlIaWMveUl1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXp6UFdPZmN3WkQwUG1BR1EyODVsTEl3cE5tYitlV29pQjJ5YWFTbGNRUGU1?=
 =?utf-8?B?NWxsZFBOSjlOcXJNalR5OHF3MXVpQTJMZGFUVEIwYjcrQjlJeWlycFZ4OEhQ?=
 =?utf-8?B?Mi9tL0JncGhqWlR3QlpjV1BjekxQbjdMQ3g2SHhHVEZPajFKTFdjQkdKQWtV?=
 =?utf-8?B?Y3dUejBmNDhMMlJ1ZFpkRjNENEw4bTNDWlNVdXRuaE4vNUxJcE14L2JuK3FB?=
 =?utf-8?B?aWZPOFhoTVZnQ1RTc0VhbU00blhSRlRsbHpCZWxSSkduWTVZZWJrcGk4Zndk?=
 =?utf-8?B?QmxONCt6dENUL1lsdkg4dVZwcG5SYnp4Wkp6MnlLN0ZSL3lBOW9PNTRtTHUz?=
 =?utf-8?B?d3VSZEtIbDYxVS9XK21kVjBwN0xOUDg4cGhBenNmTVE5NDdncVl3NEZwTWsy?=
 =?utf-8?B?K1l0bmEzdXhjYldWdWxVcEx1emY0NjZjSndNL08zYUxuQ3JkdndjUWFJWHV4?=
 =?utf-8?B?WjRJczhteXhoVmp1UE1ibTlKam12bE9BQ1l1T2U1WVg5eHluTG5Td09jVU1o?=
 =?utf-8?B?cmh6SE8wT0FlUjFZTEpEbXhSeUJWL1V3V3E0M2c2QjF6aExEa28rQ3dyVFM1?=
 =?utf-8?B?Zk52Um4xalV1U0Vna0NrMGdyK05FV1FnZGRqYTgrS0VzdUh4c0Nrc3JlQllo?=
 =?utf-8?B?SkVmMlJ0VzhmNjNvc2o3aUFudE9UbHVJcmZmd1lhZ3JxbFFOektVRFM2Q2sv?=
 =?utf-8?B?b3prTDlvS04velFtcXpTRmlMRTBZR3Y5ZXRoK2ZENDJILzFDeDgzQW9iWElP?=
 =?utf-8?B?eERSWVNmV3BXSkkxUllCT0xKVWswWWVCekxvZU5QbG9TbDM0UmlkWHhlY1B5?=
 =?utf-8?B?ZUJ2Q2ZOWkxMQ242U0g0UVVFMDhJRXFCUVoxMnhmT2hEWGZrZytRaDVNbDFD?=
 =?utf-8?B?UWozc2tQRlIzSnJQWUx0TWc4cHlnUG1kN25tOWo0cmNTZXZzaEdLUkpka3FZ?=
 =?utf-8?B?SG5JT0lid3Vyc29pYk1Ra1RkemRTMmFNaVk1YVhUQ2hrTktnUy83Vm5UYUlX?=
 =?utf-8?B?Y3pGRXVqV1A2ZDd6K2xYTDZ6TEdCM0xoK2JXTlpXVEg4VVc5cEpWQjYrV01j?=
 =?utf-8?B?YTM2OXhpL0x3WEdKZUtZZ2NTOW56RkZXV3pKa1F2QTBHQ0hFOE5reW1PWE9u?=
 =?utf-8?B?WHVFN3BaaG12VzZidGx6S2NMRmtHVTUwM1NONVRzYUNEcnpFZUFPajZvem1n?=
 =?utf-8?B?UkhOMENyT3V3ZGhYMU1OTE5TZHFGcVdidTVpcTA5UWRrRzQ4bnpPaTZaY211?=
 =?utf-8?B?SzBnblZ5MmQ3aVovVGUzbUN1VC9zVk1ISGQ1b2dmbVFoV0tOSXM5aU8zY0tR?=
 =?utf-8?B?S0lBcGE3bW9IaVdtUVBLM0NoN2tyb0xONEloRXp1SnBwUE9LLzEvTGZXS3JE?=
 =?utf-8?B?eitRa0J2dndDZ0lMWk9yakZUZUNVdXdCYjJ4M1REL2liTFRuSmsva0pGU0E0?=
 =?utf-8?B?K1BDMC9xTnZBMGp6bmE3YUV3a05RZFpMZWNLZ0lYWmRvM0xRTnp3K1VTdC9U?=
 =?utf-8?B?Wit3Q2k4eEFmREJMNkZYQlZQS3RRTU45UFJkZTFiYjdIN1gwNnN1Nlh1RnYv?=
 =?utf-8?B?cUYyajJXVXlLc2ljV0paTDFyOGt0Ukt2a1dTOFdGb0Jmc1I4cG1qVXJrSHN6?=
 =?utf-8?B?c1VPaktGSjNKV1RyUkJlUmVXdkJhdU5keTZFbDB2d0NzU3Fqd1ZZRk1KRTM0?=
 =?utf-8?B?TlVhVklHajlGU2duUjd5RzBUdFJpL1dRdmV2bzRxbFcwLzQ3MjdVMjJhSGZv?=
 =?utf-8?B?T2w3SFdJVTZOaVdoYmNma2FESlJPY1JDQzh4UERXdmcvUWt4blBnUlpTSVpM?=
 =?utf-8?B?cGhKTnYrTS9UMUpKaEx0NWVVR01jbnU3Wi9uaFl0RFBWbERWLzFYREZwWVdq?=
 =?utf-8?B?R1NvMVJpbUp2Q3dCZmptaVVNRzJIK2U5SUI0Sm5XQlRLUUo0eDFHQnlFOGpl?=
 =?utf-8?B?YXltcnBqZ3lVOWtTb3haU3BVTEVhbURNNkhwOUhmYmFzSk4wTFVQS3dGZW9h?=
 =?utf-8?B?OVlFOTJEM2wwVTVwWFBJQU1pM1BOREtHZ01PTmpuUis4Tk1KREJaL0c5bGdJ?=
 =?utf-8?B?S2l0bFRXSmoyREFFcVpEeVo4a21VdUR3KzNyZzEwZ2h5WEw2Sk51Znp4VjhQ?=
 =?utf-8?B?b0VWWERXcDlWMXBUSFpsM1B6WlArdW1vMGp0WHdOK3l6ZnE0WkRUVjZyQ2RP?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e897a04f-42b7-47b8-a2f2-08dcbe3b0222
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:33:02.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO/71PZYpr+cEZ/cJgpk0dYY2ceo2ThSGZbahgCzmZod8yV+W2xea9W99WqISavCclySZUG027gTjOAYV5mpPVTSj90GKXzW3qcRqOJVoAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

Hi Babu,

(expanding on what James said)

On 8/6/24 3:00 PM, Babu Moger wrote:
> The mbm_mode displays list of monitor modes supported.
> 
> The mbm_cntr_assign is one of the currently supported modes. It is also
> called ABMC (Assignable Bandwidth Monitoring Counters) feature. ABMC
> feature provides option to assign a hardware counter to an RMID and
> monitor the bandwidth as long as it is assigned. ABMC mode is enabled
> by default when supported.
> 
> Legacy mode works without the assignment option.
> 
> Provide an interface to display the monitor mode on the system.
> $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> [mbm_cntr_assign]
> legacy
> 
> Switching the mbm_mode will reset all the mbm counters of all resctrl
> groups.

The changelog also needs to be clear to distinguish the resctrl fs
"mbm_cntr_assign" mode from how it is backed by ABMC on AMD hardware.

for example (please improve):

	Introduce "mbm_cntr_assign" mode that provides the option to assign a
	hardware counter to an RMID and monitor the bandwidth as long as it is
	assigned. On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
	Bandwidth Monitoring Counters) hardware feature. "mbm_cntr_assign" mode
	is enabled by default when supported.

	"default" mode is the existing monitoring mode that works without the
	explicit counter assignment, instead relying on dynamic counter assignment
	by hardware that may result in hardware not dedicating a counter resulting in
	monitoring data reads returning "Unavailable".

	Provide an interface to display the monitor mode on the system.
	$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
	[mbm_cntr_assign]
	default

	Switching the mbm_assign_mode will reset all the MBM counters of all resctrl
	groups.


....

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6075b1e5bb77..d8f85b20ab8f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -845,6 +845,26 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>   	return ret;
>   }
>   
> +static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
> +				  struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	if (r->mon.mbm_cntr_assignable) {
> +		if (resctrl_arch_get_abmc_enabled()) {

Since this state can change during runtime this access needs to be protected.

> +			seq_puts(s, "[mbm_cntr_assign]\n");
> +			seq_puts(s, "legacy\n");
> +		} else {
> +			seq_puts(s, "mbm_cntr_assign\n");
> +			seq_puts(s, "[legacy]\n");
> +		}
> +	} else {
> +		seq_puts(s, "[legacy]\n");
> +	}
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*

Reinette


