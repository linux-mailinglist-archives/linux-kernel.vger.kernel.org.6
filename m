Return-Path: <linux-kernel+bounces-522608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D09A3CC44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843E4177636
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DC2580E7;
	Wed, 19 Feb 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8ZyTt2D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619E254B06
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003972; cv=fail; b=UGmMfbqh+WCxvuw1lFQKF0mmAlXk0hOwi6kYuY6PHTGBNV4iabw5Dkx6LhXviLarzUjwELUx/TSX56ssohmeIdE49lWHRr2OhXs/eiCZQ3od8MH01SdVX7HMv8XKmCkH6Bc0wB8BB93tjZs40F0zT4eh03TClQRpW185HTNM0O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003972; c=relaxed/simple;
	bh=10Ltgkd/p7XolPRbNM4O6RtMBHVUWM9LCTWzngp9hII=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUqSDK4ek27+alvnqm4Pu6BPsgyWIM4kcKM429w/jfOC9kGoTYsXhY8VSOWEU++H0laZxFOWKqixEhNNNwfsnD31VRDXvMTYCk+aKzp+iZpz8TkoW89aVZ+JFZqyo3VW4hhDQF7opCebXUNYUrESb80bS4RTGqKZxfZifP63ovA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8ZyTt2D; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740003970; x=1771539970;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=10Ltgkd/p7XolPRbNM4O6RtMBHVUWM9LCTWzngp9hII=;
  b=n8ZyTt2Dd2sJ4kjdipxh0gRSd+xy5Lwv/gU+GNYk1wbqosUwwsHYTaO/
   FV2KF5dDUjjHBVu4TiCTfzMvpNkeg/6bg3MVTPBN7lo42WG7dIcraG7ez
   J9mPJKg3+0aCBHc4jKTMgdHd7ktPjuR4cMp2qb319kmHjixJI2qP7szhp
   F6tI1wbp1r8NvamuydJnRum97l5p5TlUx+yY3qtuml60VcfyEv1Do91Zu
   KFxOmvYaSnzxqn/bvU9Xd8DqSlYjwryQb6ccg1jsxT5Vk+KnnGW+I1hLA
   rTcNEq9RniYhY0nDUGPSiFA0blqdyWBhRZGsPJeIAdNIAwrqEH81yYRBx
   g==;
X-CSE-ConnectionGUID: f9Kl9tr3Qt+1FeJcbkEGPA==
X-CSE-MsgGUID: q49lVwSaSw+fqPilstJZjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40968925"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40968925"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:26:09 -0800
X-CSE-ConnectionGUID: n37SWVuASBGx0MfekoPdyw==
X-CSE-MsgGUID: bMygQJnWRMmkg6U8+gE0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119947270"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:25:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 14:25:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 14:25:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 14:25:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/gjvu8p65vwy+QNQyGoyVZEjeTrO1hveDkcxRG7/3Ozy7V9rtkOQV+CBfp4nkfN5RxDrXFbcBuQlxjiKdt3xFB7zxIFtso4Zo8+JC2im61+jVjHfSNm71kGMEqSE+e+PlYR2bnaygT44coC0woNVcnFsL+5sOMOLWk42J0lawLLzRNrF7jzAeUracXUd2/RPPswngFlxdTm1Rsyd36OmbkADKSElw9UVg+1CAXRHfcBFlLR/8/ccmHywScFRfCZyJvkKNqLxuWcLZwRZ7ySo2WQmmel2QbxW//PYYTej31DHWM8T+usk1IQqYQEqO4PTslUGHsPlOsIL2qYcvh0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvrxBd148T6QmYoFiFe0HTSkZWfTeW1U1ScCdj2bsLM=;
 b=HC2aVb8v589bNfPRK+mc3fL22Mow2Lvri4A2X+Q1l8OXlFlIszHd4Tzq3jpOH592sAjjY1fudLKeLSrIiAIz1eafqRiysoC9UAx1/3r2cRVYJy8p/w/NBx0xyLfnlywFanVzsFYBe+aypIecyYZM+bGLkR1Gj6lMEfYwhrX94YjurzmCqpcRISgFOTP3+YNXFKM0pmKyyGRcFdKPT0ZrOacsAFWxD4cET40ql9PmW35OeHIBlwxLEwY2ShLzE5kpt/rACa7eZikuK8Cr/ys+fBUGOlia7WPu1LqZxmaptZDyfsiNXe3hVebWWr0XDeRZw8ZoUHsWcTsVfXoYrzlK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 22:25:31 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 22:25:31 +0000
Message-ID: <d5db93c2-9ce4-4ad7-a64c-cbf3c1020ff5@intel.com>
Date: Wed, 19 Feb 2025 16:25:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Dionna Amalie Glaze
	<dionnaglaze@google.com>, Dave Hansen <dave.hansen@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com>
 <c2cf2184-7753-454e-ac99-8c4f3c9c3d16@intel.com>
 <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com>
 <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
 <ab2036d5-5b6f-4fa9-995a-fba63c0a5209@linux.intel.com>
 <f4d344de-70c2-4fd4-bb18-2912cf0f3f98@intel.com>
 <CAAH4kHYq7_3vLXQaCA7iKF+mC5Pg0cn-1FsB-iCbN7Jim9a-OQ@mail.gmail.com>
 <650b6236-50d3-4932-b5bc-056fd29c93a7@intel.com>
 <CAAH4kHYye2ApqYb3GmHSt2Ge4B1m55mA54Ch-f1RCzh3GZuHOw@mail.gmail.com>
 <cccce005fc19dc05caf67c454bd669d524c862bf.camel@HansenPartnership.com>
 <8009a9fd-c7b1-48e3-af8b-8f481328c597@linux.intel.com>
 <6e773bfd1275d4f8c7df1ca65e22ec42eba12a8e.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <6e773bfd1275d4f8c7df1ca65e22ec42eba12a8e.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::12) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1d19d1-4d95-4d10-7183-08dd513451aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXY3VURNekl3Q2ZSNGFxOU9zMlJURXd0SUxjeDVRZGxsZlJqbWs2MUdtYTht?=
 =?utf-8?B?MFpYS0FtWllxaStiZmxqNVdWelk5TENCV1BEM3RBWDZKWnBubzBvZEQ1YVQ5?=
 =?utf-8?B?Z3dwakllUXpBUDR3eGV4cHFDd2VWUklEL1Q5SFNXWmNXZ29Ba1Jlc1lreDVu?=
 =?utf-8?B?QnQ0VHFYWldzU0V5clJLajYxQ3hHaXR4YlBIQk54T1NINXRmRTU1Ylpadkhy?=
 =?utf-8?B?YklUQTk3dEdTN2FyQW9MT3d5a3VjTU85MUl2S1RGVEV3RVdvYVpxQmVITTNB?=
 =?utf-8?B?YitrSTdKUTBhZ3hPaFNmOUlDWjhLOVQrdWlWN3B2b1UrQ1BoNnlId04xU0Vk?=
 =?utf-8?B?ZU5FVkUrRjQrNkx6QkduYTh0L3c1TTE1ZEs2cnhadUl6Z21HeHhkK1NJNFVL?=
 =?utf-8?B?S0F6L1V1ZXIyMXFjTUpTSTduNlNUcW5nWW40akxQNnUzS2MzS3huZGo5WndS?=
 =?utf-8?B?N2t4bGhSVDJKd01welR3d0pDWEZFbEFMUUhxRmM3Rzk5MHZZT2VWYS9iN1ZG?=
 =?utf-8?B?emFmRHFrUkpsa1NhT0YreVFNNWdEUU9nZlNXZEpBTXVsaGYwczZjT3N2L1B1?=
 =?utf-8?B?WStDVHVXZVo3anpSQS9LaFdBLzI3SFVkQjMrLzFsRlNpbUYwQkVzZlpBRjk1?=
 =?utf-8?B?RW8zL3Z4OW5KOVZOYklUTlF5MjJITnV1M0RVckMwbDhWR2tXSWN4dm84YU4y?=
 =?utf-8?B?NVBhUTdDbUNqK3dMczBZb1hlV1JLTXFsY0hEaXlRMlhnbC9IYW5kandic1BR?=
 =?utf-8?B?RzhJak1jZ3FPVXMvek9vaUFjS01lZS9JVlh6OVdKUEd4ZVFJNWt1b2FCMGwy?=
 =?utf-8?B?UVFpQkpZckM2WFNmZ3lTRTVqSW14NEczaTg3STVJdERTSGprRnNmY0Qvb3ls?=
 =?utf-8?B?eHhVSFB6SndxbkxhYVdodjFxZFViSWJ0MXRpQmMzSWE2YnMvQUJjOG0zL09l?=
 =?utf-8?B?V3poNDl1eG03UEdubEFPc2xkeW9EMGN0V1hhSDJpbytlaGlqeEdKNEQzczFR?=
 =?utf-8?B?UC94SnI0a080b1V3QWdpUFg5djFob2xIUzhBT1ZHa3BtN2VLSHJGOEYraUht?=
 =?utf-8?B?Nmg1SU1hZS9SSXFKSFlUUkxiNnh6YlJaWTNzYkFoeXBrUGdoeVRuQXd5bnFJ?=
 =?utf-8?B?dkJ6U3IzVmVFeFYzY1k3OE5wL1JTKzA5RTBjNWp1SFBqOFhIZndzaWJzcXIz?=
 =?utf-8?B?ZjZxdEVhWWtyMURpQXVrRVo4bkJja2U4Wk1pb2JZcUs4TDBGb0RaeWZuS21J?=
 =?utf-8?B?QmdPZXRVV0cyNHVDSStKS2UyOEpHYm1wcDZVS1FVL0MrVjJpczdmVGlOS3FU?=
 =?utf-8?B?QVJWV1Z0K1AxZlJ0WlNQbm1CQ1Q3VzhjUjFJRmpYSlU1c3I1bGlJU25VQ25h?=
 =?utf-8?B?UVN2OExzRzFqZ0Mwck9pRGJGN2ptdUxPUHVQQjJNNzFUVnV4U3grSTRCN1BW?=
 =?utf-8?B?SUM1RDl4MUkrT0dEdE95WWx3OGpuOWtlVUhGeGRWL3hwbytNbk53ekFPSlNt?=
 =?utf-8?B?ZDZHQk5pd0ZtckF6OWl2L0w1ZVRYV1FwQzZRMnFMMUhkVWNmWDdBZzVBVnFj?=
 =?utf-8?B?b1lGSE9vQWdOY2Q5YmlTeCtOREdDUlF1eGl0b05SZml4RmFCWlNyMnBra0xK?=
 =?utf-8?B?T2MrMXVjVXZMT1pVNEN0dDVXVHYzbURPVUpBTlZWaUx4NGd4OWYwd2dqRWlx?=
 =?utf-8?B?bkhSRWNtdk5wYng0NzhRa2MwVm1hdWNsU3c3NnczK1N5RUdNOHpWVlg2Rm10?=
 =?utf-8?B?VXdkRjZ2TXJ2SnhhQ25STnl0bUpZdGVQQWZSRDhJVGZOeDMzRWk5SlhsUnNz?=
 =?utf-8?B?clB6M0V3cHhVejdDRTY0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1senBxeU8xcm95Z2VCbHJOdGovcE81VHlhdzllTVM2eis4a0ZRZzlmcWxL?=
 =?utf-8?B?c1NlWlRLbit4RVpjaFIzZFlMTUVjVjVyckc0SXY5NnhjQXlldjFLQ24wVDRi?=
 =?utf-8?B?bUlYcWVUazJzOWdBMko2ZDd2MUpFOWF4a1lLUHFJTElxdzNodlVLYTV6eWlM?=
 =?utf-8?B?Y29mUHlzY0xmYW0rU2RzeU9ISWF1NS9kQmNuVm9qQVc3R05BQTR3Tzl1SnRT?=
 =?utf-8?B?bEtOZ0lUN1gvNGM2MHJyZ3RHOUdGUVNjekh1ZmVFcmN3MHBsWXBLcjFSUkht?=
 =?utf-8?B?VDVDOFR6eXkwTTVJdkxHR0s4Qm1jVzRBMmhPejBNdlhaUVZmVWtkWEptWnpG?=
 =?utf-8?B?eENyN3FoMWUrRlhyWlNwbWZqL0h2a01tMkFRZjhWTmo3TjV3KzBPTUtEK3l1?=
 =?utf-8?B?QWVibDQvTWhaRklpeEN0T0hNendZSnRmS014S1BBektOS05wb1N5MWV4TDI2?=
 =?utf-8?B?SFVCbkpFZTZHQWlwRzNReGFHQ3I2akh2WFczVkRxelliNkcxSmxhcDZkdGJ5?=
 =?utf-8?B?ZTlZT04wWkpPWHVxVXBLdjkzb0ErcVVXRGhtQTV0b3RXU2NhS1pHb0ZqZVdn?=
 =?utf-8?B?WWg3eG1qOHB1NGdxLzV5VnZScis4eURDSTlFc0hQRUNQb2JieUhXL0t3TUJQ?=
 =?utf-8?B?QVArdUFmZDEzdytGbjBvVkczVERJSmgzdC9OZVVaMjN5cE9PMGw4dUNPbHBp?=
 =?utf-8?B?ZmhJVi9yTWN4d25mOG53dHlxTnQ1TUs4RVhXUWs3NEwxVUY3NUJPY1NsL3Fv?=
 =?utf-8?B?dnAvb01MUVd5bXZqQmVlcnljNmJZQWN3V3FSYU94RDFpVmlBZE4yYUdzNmsx?=
 =?utf-8?B?MlJ6cmVwMkI3TThaYlYrZjhsdkl1cnRERDJrNnZXNStHN2U2ZWU5N0FaMDNV?=
 =?utf-8?B?Ull3YXdaTEpoenRQYXRzQkw1MEl6aEhFb2JLdEpFOVNhNWFjbTNnSElhY0Rh?=
 =?utf-8?B?S3hmOEU5Vnh4bTJYalpyaS9OZmFvN3lIbERFQ3dIaFRNUEtHT2ZkbG5BU0RF?=
 =?utf-8?B?RGxFZnYwSy9EOW1GMlJ1clJ5c09neXJIVjJsd3lCaXVZYktza29oTm9yWDRP?=
 =?utf-8?B?enhESE1WMmpQNjBxQW5kck9ieGJHRHlXNGxwNSsvL0hvR1lJc1pRTitNOFhq?=
 =?utf-8?B?cHdLYUw2djhjRjhxWk95VzM2SWx2Y2YxUzU1cEJlV0Rlb3RzNG1sMWRLamYz?=
 =?utf-8?B?dk8xd21kMlhWWDd0NThHUFdHbDl5ZElNQzBLL3ZuU2JOcHJZMk1FQ3cvd1ZI?=
 =?utf-8?B?Z282Y0hjT1dLN240Qzl3a1ZBemQyckVJL0N2Mlc4M09hOVdhSEZxamhOTnpW?=
 =?utf-8?B?RXRjeTBFQ2t0RTdNVnZDMmx3SnVGYlJzOEdBYjZiRXBYWnB1RFpsa0tTbGNl?=
 =?utf-8?B?L1F1cUhOVEQweVJzM0dPTVk0WDhBSEt5ako1bjJQMnhSVHFVb1ovY0E2U3BU?=
 =?utf-8?B?YUdDamNLSnRhemk4dGpwc3NQd3llalZWdmhwK21kRnh5RjVQU0RvU3dSODk0?=
 =?utf-8?B?cWwrWGVDSEhOcHkvK05BYmFDMGpYUVhwbHBCSjZpMEJnWEMxL09uV2NjWFMz?=
 =?utf-8?B?ZjJ5VXNqTVdWbG9qMTliWWREVUZPSVdSU1VlU0hscFJGeTlVMmxmRzM1N1Z2?=
 =?utf-8?B?L0N4ZkxzOERQTkhiQmR0bUg2Uy9sWWVVeTc4VEFrMzVjN24zMEI4NTJDdDB2?=
 =?utf-8?B?VjdUeEgzUi9uUjFlRFVSSHlwZklXYmg5WXJkdU1BQ0d1V3IzUFI5RnY2bnVH?=
 =?utf-8?B?TFJkcXU4YTJ4TlZMSUN4U3QwV1h5OGljM1pKR0FqamtuQ0IzeEljUkVhQjhL?=
 =?utf-8?B?VFZwUEt3K1Zhb0hBNHNmMXBpbXJZMWhFN1d6Q3JSL2hQRVgrZ1BTODB1dlZL?=
 =?utf-8?B?NGp6QjJPRG1mUmgrN2o5akQwckliN0taWWhCWENBM2Z6dHJQS3RnY2ZhRjdY?=
 =?utf-8?B?dG15bzV3cUxNT3kvWkJLWkp1OUcycElTcmhjV096alMyTjRrK2NGaHJYK2hV?=
 =?utf-8?B?c0RGbC9DT3dGYjRoTmVmc2VVRHYvdkQxSUI1ZDFvN1NUU1R5ZEN6RytnNUoy?=
 =?utf-8?B?c2RmaFQ0bklrU0R0bWtQS29tV1ZuVU45UDdySGhyUytWay9hUGdDSEgvRkFh?=
 =?utf-8?Q?Uy9wH7opvBbQY+hoM/jcnk2/F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1d19d1-4d95-4d10-7183-08dd513451aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:25:30.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RuMnBU+7uKjTbvBuaiM83waL//czGdfp5evFuFBQK8JX2O81JAPBAC2ChSRWXi7y16tNurk5826Ex8GeTtcSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com

Hi James,

On 2/19/2025 2:53 PM, James Bottomley wrote:
> On Wed, 2025-02-19 at 09:24 -0600, Dan Middleton wrote:
>>
>>
>> On 2/19/25 7:29 AM, James Bottomley wrote:
>>> On Tue, 2025-02-18 at 19:21 -0800, Dionna Amalie Glaze wrote:
>>>> On Tue, Feb 18, 2025 at 4:41 PM Dave Hansen
>>>> <dave.hansen@intel.com>
>>>> wrote:
>>>>>
>>>>> On 2/18/25 15:57, Dionna Amalie Glaze wrote:
>>>>>>> If there are actual end users who care about this, it would
>>>>>>> be great to see their acks on it as well.
>>>>>>>
>>>>>> We would like to have this for Google Confidential Space and
>>>>>> Kubernetes Engine.
>>>>>>
>>>>>> Acked-by: Dionna Glaze <dionnaglaze@google.com>
>>>>>
>>>>> Great! Thanks for chiming in. Can you talk for a second,
>>>>> though, about why this is useful and how you plan to use it? Is
>>>>> it for debugging?
>>>>
>>>> Confidential space on SEV depends on the hypervisor-provided vTPM
>>>> to provide remotely attestable quotes of its PCRs, and the
>>>> corresponding event logs.
>>>> https://github.com/google/go-tpm-tools/blob/main/launcher/agent/agent.go#L97
>>>>
>>>> On TDX and ARM CCA (maybe RISC-V CoVE someday), we don't want to
>>>> have to depend on the vTPM.
>>>
>>> I still don't get why one of the goals seems to be to artificially
>>> separate AMD Confidential Computing from Intel (and now Arm and
>>> RISC-V).
>>>
>>>> There are runtime measurement registers and the CCEL.
>>>> When we have a sysfs interface to extend these registers, it
>>>> makes the user space evidence manager's life easier.
>>>> When Dan Williams forced the issue about configfs-tsm, we were
>>>> told that it is bad for the kernel to have many platform-specific
>>>> interfaces for attestation operations.
>>>> This patch series is a way to unify behind the tsm.
>>>
>>> You say "unify behind", but this proposal doesn't include AMD and
>>> it could easily.  All these RTMR systems are simply subsets of a
>>> TPM functionality with non-standard (and different between each of
>>> them) quoting mechanisms.  The only real substantive difference
>>> between RTMR systems and TPM2 is the lack of algorithm agility.  If
>>> everyone is determined to repeat the mistakes of history, TPM2 can
>>> easily be exposed with a pejorative algorithm, so it could fit into
>>> this structure with whatever the chosen hash is and definitely
>>> should be so the interface can really become a universal one
>>> applying to both Intel *and* AMD.   The only real argument against
>>> adding a TPM that I've seen is that it potentially expands the use
>>> beyond confidential VMs, which, in an interface claiming to be
>>> universal, I think is actually a good thing. There are many non-CC
>>> use cases that would really like a non-repudiable logging system.
>>
This series does support crypto algo agility per your comments to the 
RFC version this same series. The 2nd patch contains a sample showing 
how to add multiple algorithms (banks) to the same MR.

It isn't limited to CC either. Any kernel module can expose arbitrary 
MRs, real or virtual, through this interface. Again, the sample code in 
the 2nd patch shows how to, and it's quite straight forward.

>> Hi James,
>> This isn't excluding AMD. AMD just happens not to have a feature
>> common  to the other architectures.
>> Intel TDX, Arm CCA, and RISC-V COVE all provide architectural
>> measurement registers.
> 
> Calling them "architectural" (implying via hardware) doesn't really
> deflect from the fact that for everyone some pieces are going to be
> software (or in this case SVSM) provided ... it shouldn't matter where
> they're located.
> 
As said above, nothing will prevent a vTPM (based on SVSM or anything 
else) driver from exposing any PCRs through the interface defined by 
this series.

>>   SEV happens not to have these today
> 
> As I said, the vTPM is fully equivalent to a RTMR system, it's just
> implemented in software.
> 
Agreed. Again, nothing will prevent a vTPM driver from exposing PCRs 
through this interface.

>>   but should they in the future, they can draft off of the work here.
>> Might also be worth remembering the original author of the series
>> represented RISC-V COVE.
>>
>> While someone can emulate a TPM using the architectural measurement
>> registers as a backing store, they don't have to. Certainly it's also
>> possible to provide a vTPM in a protected region of memory, but that
>> shouldn't block the legitimate interests of using the architectural
>> features of TDX, CCA, and COVE.
> 
> What I still don't get is this.  The difference between RTMRs and the
> subset of TPM functionality that also provides it is non-existent.
> It's like a distinction without a difference.  If the SVSM authors had
> written for a pure RTMR implementation (just usng a CRB API) would that
> have made a difference?
> 
To be precise, RTMRs serve the purpose of RTM (Root of Trust for 
Measurement). The TPM PCRs serve the same purpose. But neither is a 
complete RTM. Per TPM spec, RTM also includes the BIOS boot block (CRTM) 
because the TPM device doesn't have access to processor memory or the 
flash device where BIOS resides. In the case of TVMs, there are static 
MRs that capture the measurements of the initial memory image, which is 
equivalent to the CRTM but measured.

This series models the full RTM (static + runtime MRs), which isn't 
fully covered by the existing TPM framework. But again, nothing will 
prevent the driver of a TPM, real or virtual, from exposing PCRs through 
this series.

>>> Just on algorithm agility, could I make one more plea to add it to
>>> the API before it's set in stone.  You might think sha384 will last
>>> forever, but then that's what the TPM1 makers thought of sha1 and
>>> that design decision hasn't been well supported by history.  The
>>> proposal is here:
>>>
>>> https://lore.kernel.org/linux-coco/86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com/
>>
>> This was helpful feedback. Cedric incorporated it into v3 of the RFC
>> series:
>>
>> https://lore.kernel.org/linux-coco/20241210-tsm-rtmr-v3-2-5997d4dbda73@intel.com/
>>
>> We thought your silence on v3 meant you were happy with that feature.
>> Lots of threads to track though so also not surprised if you didn't
>> see it, or possible we misinterpreted your feedback.
>>
>> It is retained in this patch set:
>> https://lore.kernel.org/linux-coco/20250212-tdx-rtmr-v1-2-9795dc49e132@intel.com/
> 
> Heh, OK, you got me there.  After the negative reaction to the above
> proposal and nothing changing in v2 I did stop reading the patch sets
> ...
> 
Glad that you see it now!

-Cedric

