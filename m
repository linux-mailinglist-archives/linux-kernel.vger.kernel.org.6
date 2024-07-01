Return-Path: <linux-kernel+bounces-237024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561791E9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88EC1C211A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C5171653;
	Mon,  1 Jul 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Axom1mnD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8811381C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868315; cv=fail; b=u+ka9msBgnf5yademb+rHUEiFwrpkP9aRykQLqWBeC2NC+i02gpQXVhMtCAHSoJjaKR/eCZ7qrrcCPDXQI/V/A857j1joNnGwroimihP4nI1HvbQ37fh6KIrnEreX1LYaPHHfCiXDHlywx0FPYnrWPk/Gkk3s8LELIFFLOJ4O4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868315; c=relaxed/simple;
	bh=iZ2Tjj43yeBFHbiG9NC/kcQUWLRqUir0tDQdqyBIi1E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkBanKhqIJBa3X90oFT5kp9EV5j3XdzxHWpavgfck8+Fo0tFLduxzFWpoUOSuKcmWLkEbjFDhYjU971pvSdjyQNSaH9xkGJzE9N5xSbbF/wfaSoDGnSUMaHIYUURPjchudKc4qJnJ4wkVvqTJZYGOQ7IswM3T1Oj0PIF3XSC+Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Axom1mnD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719868314; x=1751404314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iZ2Tjj43yeBFHbiG9NC/kcQUWLRqUir0tDQdqyBIi1E=;
  b=Axom1mnDdm+q3Pyh3Sl+h3exXQH0qQiyE5LSW9WMyA45hIsK1dqSuKHO
   ahOHPPQ2/UBgXGaEuXO16dzaR5bGdi3xurmi1pd0wgwaN/TEwAXgTcedS
   n3ALbMpumyE4EePgnD+bIy4QCu2/Z/nOuYtSWUNbCOqY0vzncWtAwQf06
   IVDMIpe3/mBGO9B8Dp9TbkvXYw1j+hEJEPNgBwlBWVVP8z23NiXZknXzf
   cFUV42N0VQWUp9FEVgcY0Q24IYXO1plibqbC+w0ei2HLWNz2SFdqWuupT
   CuwQ81GQQP2HSsLlhTzBxOANhHT7e80rJzgG8KUATS8FA8p4fEe68gMiL
   g==;
X-CSE-ConnectionGUID: S+PN+Xo4RWCQrEFsyadJrw==
X-CSE-MsgGUID: ed7Eie4VRzO/XYrSazfHAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34560841"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="34560841"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 14:11:53 -0700
X-CSE-ConnectionGUID: IqFGOBEGRpGBbXBWyBibqw==
X-CSE-MsgGUID: ZYqoAUaWQ3S8zNBwAbRgWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="46401478"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 14:11:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 14:11:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 14:11:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 14:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1lqSwIWfzJoci7UxTYrNXCZCHG5CJZ451orw3WDa4WhM7swydOwzX+OBS+zjy/7P6ntJjLyzwpVANbkIz0EfZMsX2aF5FQSaF3jsTCyEsAyO5gJbbb2BcWsmPR3hE2sBE+TfcDLDv2PMdmILd3TGAefgmK6XtF078d545jFrqHJXlusC0tACN8e5pxMdtWhgm2BBEg2qTqdjHOHiYs90TeR0gCC8Rfkeju/lWsTEQFvsdsaiJoRamqCTkgLAHPP4LJVEy1aLLKO+1SvAbGsuEPe1CA0Qal0r+8MBNB1gSXx+3N3slwX5yZ6tjCz4Q5YVmcSyr9iJBviG1HwDT/1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGkhZ+Mo77T0vFkk1y74j8fMpShyM9ACt4dWJY2+37I=;
 b=T6JOliwnms8lVEhuZPKIsGg94Bc20Ssr1dPSLColKhObseH9YbbkKoG+VKsTG1eGBSvA1/TxH+rjvH3QahLY7zbko2FnovCcblLQjLhTqKptGVFqtHGu5W5BztWlrNtCriBj9CuvaEIOGSwYDg1wolbac93TeMzhed8lKWPcd/344L/GEYFPhxlzQQdltrwM7FLR8wprIk/aLlFD1uq33qbZ2h0oLJWtuIUBf+8WaZ6vxokEZVMHuMOrDw5vBBsRPjkLQBouSSvt8LavDJ7ydU2xkL72ImJ1jiGHXKdu5X8m/66oZflb88ZoaUVg4nhsUsoy1ch30NU5ACtrEXEKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 21:11:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 21:11:49 +0000
Message-ID: <64a0fd8a-7c2f-4121-ac20-433cfdcefa9a@intel.com>
Date: Mon, 1 Jul 2024 14:11:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/38] x86/resctrl: Move monitor init work to a resctrl
 init call
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
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-17-james.morse@arm.com>
 <c7b3c16a-afb0-459a-b1ca-c420122f296d@intel.com>
 <21d1598e-47a1-4fce-ae5d-ca66419671c2@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <21d1598e-47a1-4fce-ae5d-ca66419671c2@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d556e5d-b84a-47b1-4581-08dc9a126bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTdzRGhDZmpVNFdmUXcrWUZnMkxZb2lqMlhyMy95bmdwbkd0QTdOL3BoRTZ3?=
 =?utf-8?B?eHNqODdIRVYwYUw1aVEwMkd5Q1pQdTFZVUZyTVNWSnRidzFQaEc4cHhzM2ZO?=
 =?utf-8?B?NGxIZjdLSXF3WU9UaEkzNTVNYmVvelRkYW41L01yN2hBenNzQWdWVWoxOTBH?=
 =?utf-8?B?QUZSRnR6MzlLZjNjak5TOHJBVjY4MGlMcHE2WmMraVU5MGdHb1NaNTh6dzVo?=
 =?utf-8?B?QjZOOFlqVS9hQWNQMEY2MUY1UUtPRTdGNzNwUEhRU0NueWNMQ1pBdk9HdmRv?=
 =?utf-8?B?WWRUazd5cnNncy8xQmZJbXJIKzg1SWZoYUhiT3FuVDFXQlFkRDNNNTRFSCtj?=
 =?utf-8?B?UHZ1QTFHQms3NnRSTEpRWDVwWkw5OFcrVUFaUDNxSDZHYUhkTG5XVldnNlNX?=
 =?utf-8?B?YndUU2Q2dlRtc2RRM1VsbGNGNjBBNW95K1NneVR2enJqVXpEUDZBN1JwbFNN?=
 =?utf-8?B?YWpuVDJKUGRLWHA0RFJVbXNKV1pFWGovVUQ4WTBsMExTb1BRNUVlMXFxL05J?=
 =?utf-8?B?Qm9jeXVJRVBaaElJSUZxbFhXL09VczVnWGg5Titxby96OTNBcW5qYlJoVWhC?=
 =?utf-8?B?Tk1ENXcrampOaTlXL2tmWm1BWFNVUmlNeFZ4dVh6YlJZSTBuekNQakNqeDRi?=
 =?utf-8?B?bmorb1lMbWhEUHZUVDB6TjVYdGpvVWE1T3ZLdlFnNzg3RjEyVG5LNjl4MmE3?=
 =?utf-8?B?ZDBpYnVwbUR1Z09jVTZLN0Z4YnFOQU54YUdJTHBCWUM0VUxiTlhWVW9FVHRG?=
 =?utf-8?B?N0FZRitKSEtPMXlYRTRqblh4SGkybnZob2pDVW9XZDFnMVdSbFZEdTEvV2VY?=
 =?utf-8?B?eWhkSkl2TFdVbFE1MHdMY0VwSTYwZ2xjNC9rRE1HbUMrQzFxK1lPbzhBZ2ds?=
 =?utf-8?B?VWRpOHNjTGNvRE9tL3ZSTmQ3Z2RZMEpEeU5iaVNsTXFWancxemo1UGFSTklJ?=
 =?utf-8?B?cUJrS29MNmNlRDJGcFpqVVNGbnV5V1lReHdiRmduNHlyRC9VL2YvWWZTU2lQ?=
 =?utf-8?B?b3dhWlpEQ3dmMHlrZ3NJMC9ZOVlQa0h0bXhDY1pHVW1LUHA1eHN4eDRWTXpB?=
 =?utf-8?B?UXJOVy9GcUMwS0pBSXpMSE55aTRCT0pZR2svT2RoM0tCT09HR29WWXM1eWZh?=
 =?utf-8?B?bTlKTjNQaTVlRjlQelpEWmRzRmlrYXJya3hGOEZ2dUFwUTZoOWxGZkhJaVkx?=
 =?utf-8?B?Ky9mcHFyREcxODRGcGRYd1VLT1JjZ0Q5MENSdkxMWmdDbE9tWlFqYUZDM3FC?=
 =?utf-8?B?a3d1Qk1vTzA2QjJ4ZDZDMkJTaW9adDg1K3V1ZHZwMmxpcHBMUUdZcE1YUUh3?=
 =?utf-8?B?SDVGazhOSjlIVXJ1N3E1WXpVWm04QXBVYXMxaUhtQjltTEl2dUVDZVRvZit2?=
 =?utf-8?B?eEpmM1N6cTZoQmFrcWJCcFZYLzgrRzZrajVhKzA2dk5Vb29hcWNKeVJnL3Nl?=
 =?utf-8?B?YnlXeDNvUW0vQ0NJeVIrVWlkY1RPK05kTjNuczNpOVpWQ3J6ajFyRkUzTEl4?=
 =?utf-8?B?U0dzQkdMU3p4VCtZZkdSZzZOU1dUK3l6OUl3am85MWlDWHZGMWJvbDNQZGxw?=
 =?utf-8?B?K05oUFNMYzZNNWxTT2Y3WDRhNGpCbGgrR2FhRUw1UHFHTHJ6WG8zRHJ4Z3hp?=
 =?utf-8?B?d0VONE92bWZZempwUmorakRPYUxCT1hPUVAwZnNHam0zVW5vc0RoYW4yQlEz?=
 =?utf-8?B?ZEEwSnJQcXdUdy9CTmU3SURkWXpCcFJBMnNSaXVoWmRRUW5EdEFFZUdodm83?=
 =?utf-8?B?Q1p4QkJzWVhlLzdwSTNyU1V4bmRqb0hNa0h5RlRHbSs3N0tEUStKL0Y4MUZP?=
 =?utf-8?B?VkF4RTZEcFlwRy94SHdyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5GWnY1UnUvSjA0Z01xS29Wc1JUWmN4eURja0dpRkM1RDhxKzBZc0o4THJW?=
 =?utf-8?B?UUJDUDV3Tm5BTGl2ZW8xLytnQW4zYi81bDcxN253aVh0QWhwMnVqY3c4ek92?=
 =?utf-8?B?OU43SVVZSmNXOVZtUU1jcStUWXlEbXBGaVIzWXRUZ1gvd2VnRVZ1cXRNVk9w?=
 =?utf-8?B?b0ovZXAwb1E1RTM4T0dhYTVYckYzTGpQc2xhV2Y0QktpQXR0YWVFWTZydmNI?=
 =?utf-8?B?UFJtdGJvZmllaHVTM2dmS1ZxelBaMnIwSzJiYytFWEFqaFlncEtJWmJoZnZU?=
 =?utf-8?B?bkVXaGFIUnhkdXpqVC9WYUwxY2trQmQ0SFQwczBhVzdaZ0JtdCtSQ1RRaUor?=
 =?utf-8?B?d3lsVHlZMmdrazJib3gycXZlWi9ZSDhlcExWamU5N1hBN2V3eHpZalpBc2ly?=
 =?utf-8?B?ZHc5YW1NZ0NGbDk3QmhzZ3VzbEVGd2F0MzhiTjNEUVpGWDRacmowakt6TjIy?=
 =?utf-8?B?RUkvaThaWVhBMEQyZWpPNlRnbzg2Y3Nia1IyaFZpT0JObGVwS294em9nVkl3?=
 =?utf-8?B?WG5kQUxvNzVEVkJjcGtrLzF5Z0FNYWJRZkwyakRySzhYRGltL2Zzai9mYW84?=
 =?utf-8?B?S1VEa2xGTnFhdXprM0tiN21JNUU2aEViYjJDVTdUQXdQTElhV0QwR2VWNlhR?=
 =?utf-8?B?cnZTVHhXUnk1NWJZdHBZUFFuV2M3T2JKZURpYjd6bUh3akE2Wk9CanJZUlJ5?=
 =?utf-8?B?TnlyM205M215T2EySE9Na0xvaTYzOS9NSmpzWXVtdzR1eXU1STZhZnEyVkMx?=
 =?utf-8?B?aE1uZ3QvMWVkNjBsb1ZIZXdlZXhRM0tPWmdpNnlybU1GcmM2cW8yUXBOY0l2?=
 =?utf-8?B?WS9OL2N6Wjg0RzhnTDVCQXExV0JkVEdZeExXdGNsYlBwODlWeTRhQ2RZbEZq?=
 =?utf-8?B?aThrelZ5a1lFL2lYNFRFMTJDRHR5K1BrUDRhKzM2SEdReHdnSkkvOEpVMU9B?=
 =?utf-8?B?ekdDWlhDMEhnQWR6SitLQWxlRzVoNjJkazBMRkE5T3o1TUFqRXNNSTIzaFdn?=
 =?utf-8?B?Y0lMUVc1dWtkZFpxZU1HM2F5RnBXNjNZN3Z3azJRalFWemgxOU1FTUgveDBM?=
 =?utf-8?B?M2I5SmpBblBQNWRrYnNCUUhFeW5WMzltUGpMbmZab0JQUW8rZGNWSFkyTE5L?=
 =?utf-8?B?bW9Jbm5aUXoxaHBVdU5EblJZejE4Y0lwSlZLTVNLcjFIQjlMSXd6ZGlsZ0cr?=
 =?utf-8?B?R3UrM0gzWGRtRzRQWVVPMjU4OHZ3Ti9XbTdpbTVzZldSR2wwaTRTcys4emVT?=
 =?utf-8?B?aW9zajhYaW8wbnQ0amxsYjloZnZGaDVCclIxUUl5OE9qRDBGM0lPUTE3eG1w?=
 =?utf-8?B?S2pnaHM3NjZ4ZzdBZStiT0h6bUJIU3hSOWNVVi9OY2poT2d3d25JSWk4ME45?=
 =?utf-8?B?TTZEV2dDMjJqcFF6N3lZaEZybmR1N0R3VzZmRHI0REdCMU1DSHByMHExSEV5?=
 =?utf-8?B?eWE1eXRENytwaWdUc1l6OS9EMlRLcGxreDBUYTlVMmgyUHlzZG9heEVGWjQx?=
 =?utf-8?B?dHphR0g5T0EwTFlkd3k2d2JJVWlLb0diK2kzT2pQMFdDVG1maDF5emZsUWVh?=
 =?utf-8?B?NjUwSVZ3QnE4MXNGVFQxZFJ0ayt5VEhaWjJ4amxQNithbXlualJWYk5PdE5O?=
 =?utf-8?B?T2laeURpTFNWSkszdDRhUk5US004SzdkdzYzZGVqdHVPV2tUcW82WUNwY0hy?=
 =?utf-8?B?c0t0SlpxRXdSVnBFcXJqWG1tMHB1NU5XbngvWGo1eU9nWmx6di91NDN3MnBH?=
 =?utf-8?B?NnhhTnNuNUVrcktEVG81aUc4cEI3RDdEUmhBcmJzdnhuMDVGdytpeWJEUWd3?=
 =?utf-8?B?VE94YmZkM3UzdERoNTZHUDl1VXNBdUg5ZmRRWVRHcHpSM2NaODlpN09mL3hr?=
 =?utf-8?B?K2RkZ3RMODZkZDluSmRDVDhrZ0k1Slk3SG8vWVplT2NkSElmZWJONlJKeFdL?=
 =?utf-8?B?d05lYlBPdGFHYkQwR1ZnWnhnQjA1TlgzRmpJVCtOb2JvWEZSK0FCZERzNlFk?=
 =?utf-8?B?QjFuWVlHZGpmSzBvL2R2a2s5SzhhNXFuTVJGQnM5eTYyNndqOVBFYnZtelRC?=
 =?utf-8?B?Zjl5Nk5zYjJuanhxaUZxSVhDSjM3WDBaYzRwcituamwwTE1DajdOT3ZXU29D?=
 =?utf-8?B?WW4yYWYrRXpoalk3akN2UlFJTFBaaUluZkVzMjg3Rnkza2l3ckh4eHpQcEoz?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d556e5d-b84a-47b1-4581-08dc9a126bf7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:11:49.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GPuXT4cmvwnNlPVF79eqwAVsdc0VzsHRessdtch/1cZmhMMaoTTT/+YsCQ3BrtuGTDcEp7RD+6ffhImKYgiM6BwmRYz8amzAfwAtG7EwC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com

Hi James,

On 7/1/24 11:17 AM, James Morse wrote:
> Hi Reinette,
> 
> On 28/06/2024 17:47, Reinette Chatre wrote:
>> On 6/14/24 8:00 AM, James Morse wrote:
>>> rdt_get_mon_l3_config() is called from the architecture's
>>> resctrl_arch_late_init(), and initialises both architecture specific
>>> fields, such as hw_res->mon_scale and resctrl filesystem fields
>>> by calling dom_data_init().
>>>
>>> To separate the filesystem and architecture parts of resctrl, this
>>> function needs splitting up.
>>>
>>> Add resctrl_mon_resource_init() to do the filesystem specific work,
>>> and call it from resctrl_init(). This runs later, but is still before
>>> the filesystem is mounted and the rmid_ptrs[] array can be used.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 7d6aebce75c1..527c0e9d7b2e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -1016,12 +1016,28 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>>>            list_add_tail(&mbm_local_event.list, &r->evt_list);
>>>    }
>>>    +int resctrl_mon_resource_init(void)
>>
>> (Lack of an __init is unexpected but I assume it was done since that will be removed
>> in later patch anyway?)
> 
> Yup - I'll add and remove that if you find it surprising.
> 
> 
>> This function needs a big warning to deter anybody from considering this to
>> be the place where any and all monitor related allocations happen. It needs
>> to warn developers that only resources that can only be touched after fs mount
>> may be allocated here.
> 
> I'm afraid I don't follow. Can you give an example of the scenario you are worried about?

My concern is not a scenario with current code flow but a request for informational
comments to prevent future mistakes. Specifically, as I understand the CPU online/offline
handlers can run before this function is called. Those handlers do a lot of setup, getting
resctrl and the system ready. It can be reasonable that some future action may need to touch
a new monitoring structure and with a name like resctrl_mon_resource_init() it seems appropriate
to allocate this new monitoring structure there. I am hoping that resctrl_mon_resource_init()
will have sufficient comments to deter that.

> This is called from resctrl_init(), which is called once the architecture code has done
> its setup, and reckons resctrl is something that can be supported on this platform. It
> would be safe for the limbo/overflow callbacks to start ticking after this point - but
> there is no point if the filesystem isn't mounted yet.
> Filesystem mount is triggered through rdt_get_tree(). The filesystem can't be mounted
> until resctrl_init() goes on to call register_filesystem().
> These allocations could be made later (at mount time), but they're allocated once up-front
> today.
> 
> 
> I've added:
> /**
>   * resctrl_mon_resource_init() - Initialise monitoring structures.

How about a more specific "Initialise monitoring structures used after filesystem mount"?

>   *
>   * Allocate and initialise the rmid_ptrs[] used for the limbo and free lists.
>   * Called once during boot after the struct rdt_resource's have been configured
>   * but before the filesystem is mounted.

Can there be a warning (please feel free to improve):
	"Only for resources used after filesystem mount. For example, do not allocate resources
	 needed by the CPU online/offline handlers since these handlers may run before this
	 function."

>   */
> 
> 
> Thanks,
> 
> James

Reinette

