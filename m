Return-Path: <linux-kernel+bounces-395677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301D9BC18A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41277282CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B01FDF90;
	Mon,  4 Nov 2024 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEDjs7Df"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819471F755C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763432; cv=fail; b=mbxl1+gbaI/J5ephZezX1IjLSAjWsL4UniZ4ZjbMIk+jAmazmW1ifeOyq8vCcbICSKJFFO45ZCJZR3kL/N2YVGuLI5ED7poQFXeSyTPOZqtrj5LEj74o68s2JpjPgyDWiGy7x8yEZY0ehsmT5jWxRq5Bt2yEURbk4W1Va+NYI+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763432; c=relaxed/simple;
	bh=WI9yBXOAxM69FhOqINqEoBXAYNmDsVpXG1Y08wb9zLE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PTV59KxtVeh448kHq9UB9WtZ9zyCeudGqhzjpWl3vEVfAp37O2UgBHwHu8TLLHvxJgpdQMxgvnZ843hg+7LFcu4VdiNITMR2GhuQyPkZEE+ZdJZcnDeoGmzh/gFhYxDba/LSYhYi50+As6V3PfZLTKvWDN5b1RCZtmYSRN1Mb1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEDjs7Df; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730763430; x=1762299430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WI9yBXOAxM69FhOqINqEoBXAYNmDsVpXG1Y08wb9zLE=;
  b=UEDjs7DfFyvj05JvHe8zy33yXY8TPUPtnvSa2ppd1Gi/uQJ/n5phCiEA
   +DJeaL6ht0m3sqEveTA7ZsppUbYaOyvXnP+W6WdKnHOqd+Qk7M00z05F+
   426A3De4z/gnZWl+JmtKa0BApWs0lkZGRVdb57mwOvondhr9bFhX0AWA7
   YcL/OdSG+/IZZisrvOEhssokA+L9VSE3pQfMA7am4L1HKzYX4j+TAgDU9
   LuLhqt/j+ChyCaZPvZiWsNcVgK1/ELLoFpVRlGz9DN3V5FNdxdUpF5m4v
   K/SrOR7cIIYtpQamxvptGHCG10c2+qKilqy59hQY8hBrmXIyqEwWs59MV
   Q==;
X-CSE-ConnectionGUID: CgHp0f4FTIS/uzCYUaPiSA==
X-CSE-MsgGUID: HGlJgoGfRHO6r5Ffl4uokA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="55885608"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="55885608"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 15:37:10 -0800
X-CSE-ConnectionGUID: hwR3Xf6hRUmTO38ek9I0ww==
X-CSE-MsgGUID: sL0Sd+UlT86GbJAL6W1HaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="88321163"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 15:37:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 15:37:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 15:37:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 15:37:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlsYPaxXHq0rxqaMlgWXadFNl5FQU9C3lyMOSOqPH/llvIUtRjiXq3SEjfazAyvJF9hFkk0VmmijKCYAZ4CXsz3hz9daHygpjWwvThs/5beNLAtWGiz81OVL0lakgUuFsFkaeVvDCOdruSskls3DQQpkhOWMJzudhdb/Daty28Elhc+B0SRE38SBFtWDZVAmVlba13sd3pbRIBkoi7uEl+kG1B5fj26/G/lgfddm31ovaLXtw0T2v1PZ7tcjdtGExkAU1+RjUvmsUDy6QtRrv5Jg2+AbmpxE2qb55YMurCxAFjUoVkKvqNw0FOdOyLyXKOQhcZMqii3+KsALNt88TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm8MXTChHDShvgX3A+6Q2LmF7Bw9s1tfNc691Rpfe+Q=;
 b=qnfO/HxywAnEd84Lb7xEf741CfzqT/OzA2JnPyPRbWVT90NPCzW/5XCZ//TW+axNnDYPJgFkgyNgiD/z95yeBdQCe1HCBiYjIeOQAwh+r2zbdldZmsYM898kzV03FnLQz4vezKIQLI2al9vq6SFn5uDuxRi+NZOwBLXu24fDAOtRDzBqygV5wyCcjsnvBX8fOaSJgXWWWSjRRLwRj0LQPbMQ99NVcMu48u5ThTUKXS/EcBI8Ve9vfib1WqKp8EavUoFkZrIWEv4RcgmP181DeT1XfYML8jSifdJzPV8cDpK8N8j7xgWZc1t5iYH1AtfC9UZG8yeZpYE20u8+TtVy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 MW4PR11MB5797.namprd11.prod.outlook.com (2603:10b6:303:184::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 23:37:07 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 23:37:06 +0000
Message-ID: <cb7537b6-3379-4f9c-a53a-8736c8b3ef65@intel.com>
Date: Mon, 4 Nov 2024 17:37:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] tsm: Add TVM Measurement Register Support
To: James Bottomley <James.Bottomley@HansenPartnership.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>,
	"Samuel Ortiz" <sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>, "Dionna
 Amalie Glaze" <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>, Mikko
 Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
 <20241031-tsm-rtmr-v2-1-1a6762795911@intel.com>
 <46609f9a-8451-4961-b307-a13512bbd92d@amd.com>
 <f51ce51e-cf78-499f-b03a-cb45d5364b13@intel.com>
 <b4ab9f3584a83418053122303226490b910ab65b.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <b4ab9f3584a83418053122303226490b910ab65b.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|MW4PR11MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8fb245-6045-4168-1542-08dcfd2997ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm14dTZNS2tXbTFmZndXeXI3R1A4VVBsNXAzNjA3bGd2WG9YczFjOVcxczdG?=
 =?utf-8?B?bk9WbU81cHVTM0loNm9HZWVxazREVUE4azR5WjVHSXBkbE5venBwT1J6UUIx?=
 =?utf-8?B?ZmdIUXNBdTdleHFKdEVaMkdPRlpnT2NYVnRUZ2tYZ3ROakVzYXRvZ2V4SWR5?=
 =?utf-8?B?WWt3ZnhiTm9WZkJyL01tNHdKeHJ0YVdsU0lQclJvdUdHNXEwMC9CNDBtb2J4?=
 =?utf-8?B?c2tvQks5TnhMOWRhVTYvdUw3cUJqUFl0bHpYR1MxclorUlRKVENQREx1RUZS?=
 =?utf-8?B?bXNYd3FBRU50VzZKdG1FazFMM1lodDJUN2MzdmxMSEZHY1NyUkFTVmlsMXJD?=
 =?utf-8?B?WWhLT2RnakZyMnFlY1pIaG0vQ2kxcmFUenJEc1lPSjFMRVhBNElrem9FZjRU?=
 =?utf-8?B?MG14UDlHakxnWEdPZm1EaFN0bEdjclBleVlxQWNFYW5oUjJjc3FYVE82MHJo?=
 =?utf-8?B?VktlbHRUcHpITUE3T3ZzdDFaa1BDRnJLc25PWmFnSll0dkQ1RHp3UFFHNXBy?=
 =?utf-8?B?TGliVlJtdDBKR1NvaWZ4SVVjZzRaeUxneXNKOGpWb0tpL3lydHJ2MDdGU3VN?=
 =?utf-8?B?by9yaGlMMFAzVmlXWXdCWHU4Mmo3cHJhUkcrQ0J6Q0E5bXpFMjFGbnlsbnY2?=
 =?utf-8?B?SFdRL3NqbUtsdm5CTzRuN1ppNHRuSUhTSEFuZ3ZSK1hsL21IR1JaUDgwMWND?=
 =?utf-8?B?RE9QdmhNYmN1UENubnlrMDZBL3AvRWxFTWlKMkpuc1FmSVZjcWRLS0NtYkpq?=
 =?utf-8?B?QW1tb1dvbmVVK1IrdjZGdHZPN1NIdkY2VUoyK216RWFHK1Z0eURyajVCK2xr?=
 =?utf-8?B?eEs1aHhadnkrUjYxTDJhd3YyVkdnZElCa0toVzlPVTNid0Q4MFNNRFNienc2?=
 =?utf-8?B?K051L3ZvZ3NoZ2FxV1JlWWFpQ3NHT0RTMWJ0WjlRVWMwa3d3S3plTkdJMEcr?=
 =?utf-8?B?TEpGTzBQMWpYVmJtKzFReUR6RVpieGpGSlNjL2RGdkNVeUZKblNSUXIxWEs3?=
 =?utf-8?B?UjBCNkxxMWEwS0hxVUJuWEhxSFZtcURxbWorMEV1Z2t2K3BZclA5RkpGeGlh?=
 =?utf-8?B?SFI1NExDdk1UN2hLQzhPN0N4SHJFSVJ3MStSMmh1aVJkNm9KS2RVaEluRXdu?=
 =?utf-8?B?eUs1bTBwNmptYUlsMkM5RG1xZjhnR3FLMStWQTVKTHpOY1JJVWNSTncxMUI2?=
 =?utf-8?B?WTNrU01UWDhiM3VnVzA4TmtYZml0MTVIU29QbWxhV1E5cm5tUjkyUW54OHVq?=
 =?utf-8?B?TkNhaDRyNEsxMjlCSThaUzN3djZ1eW1zSWUrbUtjYVhRdnRET05KeDhJNyty?=
 =?utf-8?B?RXNzVldpSkN2c3dTVVFNYTFzMEp6aEtmWldhMDZkZnkzS2VYOGRrZkE1empZ?=
 =?utf-8?B?ZEhKK0tlb0pJcXBYTEdZczIxdGpNZC95VTMwTUVtWUl3bnVwcVUzUkJ5clBn?=
 =?utf-8?B?RnBtazhBdmtyaXZDR2RFdGlVQmpic1BJVHhMK0tqN1RiQTNibFVkUjdKUG5l?=
 =?utf-8?B?OFRWTk9pTnZhTU1INXdkSGpFcVcyTCtodmZZQTg1SWV2OFg3UzdVVVJCY3RJ?=
 =?utf-8?B?T3MwUWZJSjZIYTFWVFVnRUZkUnl1ZW5pRzZ6em5uUzYyU1NjTnQ4WW1jbHlo?=
 =?utf-8?B?Vm5tckxHUWowOWY3UGJuVnc0cnZZUTNSUDF1Y3VOMWY5Q2I0V3BibUdFc090?=
 =?utf-8?B?L2czeEFEQ3BZSnI1aWxHeTYvZzY5RnpXOHBqODF3RVkrWW9maytpWDFDN242?=
 =?utf-8?Q?weymz/O/KmalZeMWd8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRNSFpOOXFoNlZUbVRjV3Q5RkFTT3FwY09BM01QWkRLd0lSeElBcWdhU1Zu?=
 =?utf-8?B?ZFd5WEVLS1V1cmJNNEZTT20xOFdaU2xsTWMwOW1pMnlBTDU3aVFRd210dVZU?=
 =?utf-8?B?emRuZkFreU96bnloTmN5aFNXaUZpK3ZrZTljTVVubndSNThWU0xEVzFycmFR?=
 =?utf-8?B?L0M3T2l5eEh2OC9yanZmeUptZlBzQUJqNjhuSG1ZdnhQaGhzMWd0dC9hY21z?=
 =?utf-8?B?WGhobHpVcHc3QnJFWXdXMENaVE5MNTNKVTFlRFJoOEVnT2lRWHVHaUtTand0?=
 =?utf-8?B?bndwTDM5WDhUajRWcUtTU3lKOG16SHZVR2NPWWw5NXBpUlBGeXY3d0pySURM?=
 =?utf-8?B?RFhnYVZpdTUwcER2dWZLWGZ2MmdudktFcktkb1UrVm1BT3M2Rm9yR2sxZFpL?=
 =?utf-8?B?TVl2NTdCZUpoUW82OVRSOWFPenpjV0RSSWh4RkVieEdybTVrbWpYVEo0eDNF?=
 =?utf-8?B?V3FTMzVQaC8wNStmVy9IN1ZST21nQUpXMXp5QURIanhTWEFmUjBoTjhaa3NT?=
 =?utf-8?B?Y3duV0YxbmhCNGxpNkNXZndGaDJnazNaVW03K1A4NWtXUFpLcm1DWXFYd2hN?=
 =?utf-8?B?dCt0VkVhK01rWnZoQ3VObG1BWnp4VkxBWTlSTHU4WkdYOG5mTGZ2d3JXanpp?=
 =?utf-8?B?UmpjVHJZYnJqMzFGMW9TZVZJaUJjL1VXTm9sblVFUUhUSEpBT1QwSnZpUW5X?=
 =?utf-8?B?VHZRMU1kWXM0N0FlVUZYNEpUT1BmdkJuNlN2LyszSTBqQVZIdTVsTmNraHZj?=
 =?utf-8?B?V3NyN3ZDa1htZ211SWJXTUxhRmFJUU52V0kzMnBaeVJad0VxUnFmZnA2ZWo3?=
 =?utf-8?B?TXNaUFRTd2NvTjExWGNJbGRDbE1mbGUzUjdYNTVQQjFwcXB4NUJvbXFLUXR6?=
 =?utf-8?B?UE83VDd0cGt4WUViVVFkY3FLR29mR2Rrb1BKbUJaNDllclNjQmtYbXJmSjhJ?=
 =?utf-8?B?T2Zpekp5OU85eVR2ZGZyQnA5OXRvZ3hHRDBmWFRHaHRZOGZ1TWUrdjFJZE5Y?=
 =?utf-8?B?Yk5NVzhlL1JsZXBxKzF1UWlmWFJ6VTZOS0NxS0xRVVRNTGNpK1htai8rWVJt?=
 =?utf-8?B?aHl0YW1LYmZPQWxUV3dzS2xNZWNTcTVkRTdYWlZnaDYvck80WGJsdEhRSEx2?=
 =?utf-8?B?dkxvUDFsUzFtZkEwSWxRcGtXTS83T0FrMklPSnZkMWxZRGZ0THFWcDBEdmRj?=
 =?utf-8?B?czU3NU9RMnBsQnJkUklqSWhDQmNZMWVvT1pLT285U0NqL1NiZW9EbXoySXRI?=
 =?utf-8?B?ZTM4Tno1MG9YSmQxeEJWWm14NkpqajYrOTg0WVovaUdsbW5ONnE2VTQ1VnVK?=
 =?utf-8?B?Q3Zrd1FWR0lTRkovdHMvRWdMVncxd2FkTDA2VzVDY3R4OE9uNXpZRTNHYXRw?=
 =?utf-8?B?Y2ozaDc1RldISW5hVjVXUnRNYkUwbzNENC90YitQRjhWSmcvRTZaV2sxQUhm?=
 =?utf-8?B?LzhwOVlNeG84SFlxQlhBMmhwQzgrVTFlWmp6TnVDY3RIYVBMaUs0c1dIU0pi?=
 =?utf-8?B?QWZQbUk0ck00VU15RjUwa294MjYzSnRROWVzTi9KUDhoenNsWUMwendVblhn?=
 =?utf-8?B?SjY1Y1hINFRmdlRVNXhWMTdReTlwZ2MxYytNZk5ML01EMUp3VFdRWm42R25H?=
 =?utf-8?B?ZjRmdTlTQXN2Z0V5WWkvSEl5aUFPWGh3Ny9vUEZNNWFrOWNCZnprUG1lSjZF?=
 =?utf-8?B?MzlkcHFaUUVMdzhoeGZ2U1huRk9mMVVzRGNtZGZ4QkJjMXhudk1YaUxWaE5u?=
 =?utf-8?B?eTJObXR4MlpyakpjRDRTOEJwWFdTK1hXNXZ4cE9mbVdhUmZDZlhhN1JVTUJG?=
 =?utf-8?B?QkF4VlJlQTlwVTQybHIzaDM2UGZIRndmaGRoSExxYnBOL2U5QjE0UDNZczBY?=
 =?utf-8?B?dTd2Y2szbGpldEU4UWp6UFVWWVR1WWVFbzdldERadW9uYWVNZkhCWW9KYnI4?=
 =?utf-8?B?cjhRQ2ZOaDBtTXQ2SENsU0RmTTdQV2hNSThPakdwQ2lYSjZMeFQ1Ukt3c05m?=
 =?utf-8?B?bzZHN2FuVXhwVFBzMVVuSDlmOGtSY2xwYjB3MkhCOHRKLzVrSjdUaFp2Z2VS?=
 =?utf-8?B?NXJGWVlEN0dnM09yOTZVVkcvUUZvRVl1aHVFNThvTnJiMzFKaUc4ZXNvQjJI?=
 =?utf-8?Q?IjIHBYX2KTwJ+edAvxW7H8kio?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8fb245-6045-4168-1542-08dcfd2997ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 23:37:06.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2zyBI1I1HDA6G5LXMZHIKPyNcc5tX+Z2xFju/OVq7U619rGqjfS2zS5ki4Y53Lzp139xX+fCwK4OH4dLJ1ipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5797
X-OriginatorOrg: intel.com

On 11/4/2024 4:22 PM, James Bottomley wrote:
> On Mon, 2024-11-04 at 16:14 -0600, Xing, Cedric wrote:
>> On 11/3/2024 9:51 PM, Alexey Kardashevskiy wrote:
>>> On 1/11/24 03:50, Cedric Xing wrote:
>>>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm-
>>>> core.c
>>>> similarity index 95%
>>>> rename from drivers/virt/coco/tsm.c
>>>> rename to drivers/virt/coco/tsm-core.c
>>>> index 9432d4e303f1..92e961f21507 100644
>>>> --- a/drivers/virt/coco/tsm.c
>>>> +++ b/drivers/virt/coco/tsm-core.c
>>>> @@ -1,8 +1,6 @@
>>>>    // SPDX-License-Identifier: GPL-2.0-only
>>>>    /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>>>> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>> -
>>>
>>> Why remove it?
>>>
>> It's not used anywhere...
> 
> Yes, it is; it's used in this line, which the patch doesn't appear to
> remove:
> 
> int tsm_register(const struct tsm_ops *ops, void *priv)
> {
> 	const struct tsm_ops *conflict;
> 
> 	guard(rwsem_write)(&tsm_rwsem);
> 	conflict = provider.ops;
> 	if (conflict) {
> 		pr_err("\"%s\" ops already registered\n", conflict->name);
>                  ^^^^^^^
Now I remember. I had been seeing the module name somehow got printed 
twice in the log, so I removed it. Probably something wrong with my 
build env. I'll add that back. Thanks for pointing this out!

