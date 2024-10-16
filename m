Return-Path: <linux-kernel+bounces-367148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9999FF20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110F328381E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8316F824;
	Wed, 16 Oct 2024 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBWcDaKO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8514D6EF;
	Wed, 16 Oct 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048073; cv=fail; b=hmbO/cKSyOyKRSULQY/v+R133EVz8IYQhsdqpl7xO9M740ko3i+F3r1QtkAJGIUmK/UXdb0dh8k5w6pkYTKPnKEwM0AKmd+85861HihcH9IEV2e1SJ+Irtu8mUYcuqfsD+XyikgzuLM3hRDBt0nBiOhOL2Cwj3XXkg6cVDrE/ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048073; c=relaxed/simple;
	bh=xhwpQuAI42FIBxKwuyKwcb2U7XC8zw0EV9lNzX+Ykfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JzKZFWeU7zrR54xK/+yvBJ4jXuR57+YQLWb0h0sbnMiRAKW/TBxp+bg9qTztMPbwYHS+k9YcsIoP+rG1vJDLpOkub1gbZK4gaV+SvJIkoauVRdBlUttzgmRkHCNH5rgoP8H/whT+1hKJq+uX9KG2cdt2M8YrFmx13AeSWUY9QVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBWcDaKO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048073; x=1760584073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhwpQuAI42FIBxKwuyKwcb2U7XC8zw0EV9lNzX+Ykfc=;
  b=jBWcDaKOI4ZxcLqPSFo8RqQcPs6lqne11z3kcL9mK/80bmhTEuc5VcYd
   84jR3YehTIZME75+a4y+VQb5LRf/AiA3q4W9aa0BvkgWfQe9IiMUhW0sZ
   JaV2yaWpSB7sPSSWdpXhsDIfaL6Yj8G7TP08W7NtbRVSn72P/zpSY/NlM
   zfZwPnMNBIat5YLd65mvkcOBdZjg1s7yDXKXtcbQxlVHCMxoXXobm92n7
   1hyiWnisq+WATzpxkqyI3c+PBJ8Ktho7tMDLDB1Jb/drB9qiBSUgNQMxa
   w+m0B1NORfo7LJat7Qtelzrol9p5Jw+BKar/sNWmbxjZLPl0PLsrhAjK6
   g==;
X-CSE-ConnectionGUID: LDvJFfe9RbOA5pJiETVMgA==
X-CSE-MsgGUID: Q2TdFR86SfGTAoiwJuBeIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45954279"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45954279"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:07:52 -0700
X-CSE-ConnectionGUID: kSODQ0hKSBatX4HDR42+zg==
X-CSE-MsgGUID: OhLUuihET62iYsGaAjHYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77980146"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:07:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:07:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:07:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:07:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DspGRdl+q7yCAEQOjI/yTLKZLx4ruoyu6X1fPvp5WA3il40BAhgDMno/YNSNZGQLt0LIxwebf6AgmkOJSp8tchbSNmh45m5wCZEBOS6wFe03mjiNLGpuUZ/LVAObfioQTnd/v3TN443wXOfg0QUKrl41TgEP3JUt+w4Jrb3duz7rMJmQbJClmEWOc+tuCmD/ugPJ8przOZupP+DmdxxOxkOPzGiL5m/ceZ21joIMe9GuPXGyAL6hOXNrk/AWrMNsFbMWgrz+/GBsixwHkskmHnW1DAe4JPWlvGB5KISQnzmU2VoYjbSchC5OWlPH7fPyVrjFCMdAjKir4ngw39UzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae6UnlYbHTxEHUC57WjAnlrRhfdWQeZUqNxbxdB/yU8=;
 b=TGwGcjWLWOASq3u9RG8H99pX5NvNsiXp5qOseT3bee+nzEusmr9qI3W7c8S+CJdDT6E4lDuP0Woz0FIejftUpsaDfkOaAR0oKgQi7GDYgwHjVMmo66f1dIFK0EDbBpCFuNhLWbymNRuycKTjz312RZyrNYAQXKso98HiVLo2K44+EGBqNqI7knO1AHMU7y7zY0jNV8ob9q9/ramshDd8UY9v/8YobFNwq9gUPEhhr126ZF8ZLkwRVNkSnRQi6lgpUi2idu+sqRqXkw5CgOyZG5NkETZ3aSjcVWckhg4Wg/mHf0VG1D0h+3Rw6UF+Qtbw0+yzIvk3wtFP4picM/PU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 03:07:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:07:47 +0000
Message-ID: <0a18e4ca-cc70-4d91-90af-43319b700e2b@intel.com>
Date: Tue, 15 Oct 2024 20:07:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/25] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <66b9a99a06b3cdd208dd8c490c47342bafc62ae9.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <66b9a99a06b3cdd208dd8c490c47342bafc62ae9.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c734cc-2eac-45b9-a06f-08dced8fb60d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUxVQitzVGtyMktJWStTK0ZvVnlLdlVpYmxCNmdFckQvRjM5blVqVm1kTnh2?=
 =?utf-8?B?WHpCd21WNW1MUGFWejZ3Q2hGT1NLd2F3VVBjNEdESXFndStHbDV6dVoxSlI5?=
 =?utf-8?B?Y2g5ZzlDSXhjSlVucEh5ZWlEOVExdzZVR0RmT1E4b29xek45SnFMQkJMKzlx?=
 =?utf-8?B?UGwwdzJlZFZiNWhBd0NPS2NBbGI2S2Y0Y0JxM2xpTndIa0hybmV2bGI1Zi9y?=
 =?utf-8?B?dWE3Wkt5TVAyRDIzMTBsRmxndHVmeU04THpqZ0YweFZlZ0FiSmZFODdLUmtE?=
 =?utf-8?B?MC9zRXBETHpkTnZORTk4WFRKVHRyTmt3dVlRQkkrSVI5SGZDOVJTL0RwNVdP?=
 =?utf-8?B?RGpXcjFJblUwaytLNFZQVVQ4OGs4ak5FRUZ3MXB6blVRUlRWUmYxYTJjRm5z?=
 =?utf-8?B?SmYwY3VYWlgvNnFaRE90dVdaSU9hVk9XNGtMYVU4V21Uem5mWVZNWXRvVXRm?=
 =?utf-8?B?NDBUWVl3V3dobEZFUzIrckpQYVRiQnVITFB3NVJ0blp4WGF1dHV2R2ZJRUhX?=
 =?utf-8?B?UGtDYzlZOFpXT1NTNVhzWDhiNVdocFdLaG1PWFRkQS8vUER0M3dJYjE5SjBh?=
 =?utf-8?B?Ui8xK1FZc3pmVi9UdlQ4VHp6MW51em80TE4xSjZNTlFJbTNBdmcvZklodzd3?=
 =?utf-8?B?cEFKemdrang0djNsSDl5NnBOUWVQZUsxNmZOZ0R3U215ZUN6bHRRNldCZGlU?=
 =?utf-8?B?RXFOR1FBcFR3VkFDQ1AvSXF4dmhkZytVaDc5blM0T1V1WThPcFoyQVV0a1c2?=
 =?utf-8?B?cWlnWU5CaHNNR0RCK24zZTI1Z0p4REdlRFlpLzJlNHFXUVc2citJWDQwZGVl?=
 =?utf-8?B?bUhlYWl2d1MwNzR1eVg4RFBSWW1hTzNCeVY5Qm9ITVVER0IrVmtmUkZHbkla?=
 =?utf-8?B?WFM2dmI2S24zZXBPR2ZLVWxsMnZEWHF1ZlhDMmpseE9vKzhEY3RiR0MyVDYy?=
 =?utf-8?B?S1lHaEFYOE5QYURsY0ZWdHBTSktzM2NCUElCUWtkbDUvWjluUS9rWm9iSG5K?=
 =?utf-8?B?cHJEbVNHVXA5endJSWxVWlZjK3I5VDhDRDdGOStua0YwbmgzcWl0WExUVVR5?=
 =?utf-8?B?K3JsZGZ1dkg1aEdpUlMxa2V6MEE4UnBmMzFEMGVEcENyY3JCRExad2h2K2Q1?=
 =?utf-8?B?eGpiYTh4Y1luTjQveG1vUFl0ZFVrQUZ4SjFNTGJuaDJXMVNiWmZTT2h0YlRO?=
 =?utf-8?B?TVFsVlFvT0IrbDkrN1lwZHQ5b0tEZ0Z1MGoyL0tad2VVamR6dkpTZ0xYRnNv?=
 =?utf-8?B?QnR4VFJHZkQ2dXl4eCtTRjJvaXp5dWJUaWJvRWJYTHV5M0pNYTVBcHQxU0Y1?=
 =?utf-8?B?QVFkdXRoV0IvUUZ4SFp6Q091YXJIb0lHR0pOaktSZk5jb0lzOGlmQjFBbkdw?=
 =?utf-8?B?M0tIOWJ5NWtxWDM2bmhCTDVSRk5vS2xid0J1TDNLNDRpRWVOWSsrVG5rK09l?=
 =?utf-8?B?SlRISERKTUpxdUk5NVBDczNxVlNFcktWM09KQ2ZDRnkrcDdUdzZXQ0phQUJ6?=
 =?utf-8?B?a0J6NUtKUjBHZ2dDMHkrVXV0TXpEMUljRFNZVXdlTkhWbjExRDZlQjQxYS84?=
 =?utf-8?B?eUZYcDFrMEUyNXBuUmlFRHI5TmV6R0IrYjlidXJOb21UTm9WTTRPNk9RWG1S?=
 =?utf-8?B?S3lVTkkwYVVHNGVjSDVmWEdUSmp0ZnFDaXo2dG1UZVJ3UkFSSGh5clRSRExq?=
 =?utf-8?B?Q0dMRE9UbFlHUFhQWDY1Wjg0anJkYXhGZXhubUliRkVRS0RybFRkNzVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFZLa3JVVTFRcHp0Vk0zdkkzdmFnSlRkM3NiY1FkbnRhTkg1MlhJcTE1YmdC?=
 =?utf-8?B?SkcwYlc3R1hIZGJUd3JSdWlWNXM4eTNkZjJtZnRjMldLYkYrNFV6L3BLaDVW?=
 =?utf-8?B?L1lTbUVPOTJiRmgyZ2M0S1p6QlBITkpuSkhYUzFqM3NmcVA4Z1I5dGtuVGJF?=
 =?utf-8?B?aFlnWVRHa0F3QVlLVExiUFM2cmc2UnRoSWl4NjJwRm1mOWdBNE9BQWEvdVVa?=
 =?utf-8?B?SmorQjZqbWNublFoRzk5cFdWUVJXRkdvYzN5VzE3c3kwU2FGRlcrRzVLVlBm?=
 =?utf-8?B?QlI0WHgrd0hreWpLSGNneUx1V2U2VUpNREYyY040RHUxVHcyS1JWcnRad0FO?=
 =?utf-8?B?U3RKRWh5UHJ2VFY4ZDhPYm51Sk0yWUxob1poUDJUTThISE5DNkloTVRCN01k?=
 =?utf-8?B?SGJpRFNqNUFLR1QxMkJuUmVEL2dIUHdzSkNRbkhHK2NuNkl5UG5YQkdsR3Rm?=
 =?utf-8?B?VEdkZ2J1M3VjU3drdkgzZ2N1aFRuanNWQmp5Lzh1OWlxWDJRSEFZRUhVS21l?=
 =?utf-8?B?RFB3aE14VWRvWFNVTVk4WnBZeUtCT3BtazJQMGhRQWdyaThScnlDY1JkSTh4?=
 =?utf-8?B?V0JRM3l5YlNvNEhaREZCajlncG43MTN3amlRMTE1WThrNmwyNTVqNjFOOU8v?=
 =?utf-8?B?ZkkvQVFrenVFbGoxZDFUT0EyY3JiVkRrZ1BVNGYrWStFY3NDd0p5YlZsam8w?=
 =?utf-8?B?Q01ucHhmaGJjb2d6MzNpRlYydnIxUTJ3eWhFbVlBMG9VUWdHWmhGOHE5d1U0?=
 =?utf-8?B?NVdRN0dGSnN2alhkYkJscTkvWC9OUXBXQWFKK1BCYWlBS3dCK2JMTG5kUGJF?=
 =?utf-8?B?Y0wyU25KRnF1dWhCN0xoNFNYSlhWL0hpTXlHUGR6dnE0Um1zQWZlUkNmYk9I?=
 =?utf-8?B?YnByRVRNSzVSZHBPZno1WlR0VXNkS3dMTU4xQ2tzM00wWVl6RGRYcmtIamRL?=
 =?utf-8?B?eHF6blc3WUxkS0ZCbGQwR1Z3M0hiYUwvcUg2SWxiRjhJWUpoSndmeCtCTWNn?=
 =?utf-8?B?Z01GVkdqZXJ1WTZ4L21JQUhpU1k0SElqWk5kd3JaRitjRHZiRmd5U3JBNVA2?=
 =?utf-8?B?eDZHSTljaEZ4ODRmTkw3bExEYVc3aUhsMXJYelNMdkhzTy8walNUZGJkdUxH?=
 =?utf-8?B?SGxMZjBpT3gra09Ea1ZLTzN0UTJNSDM3WUN0UWhPOGxQVzIydVExenVHaHBM?=
 =?utf-8?B?cWFtampvUU9nL0NtQ2d2VkJZZW5kS1BFWlhaa2tuMG15eE5BaUlYSXo0dnR1?=
 =?utf-8?B?UTJuNUhyVGw4SU1ZOVZxRG1UZ2NWU3I4ZHZOcENhOGxCblg1aEtFd1A2VjNi?=
 =?utf-8?B?ZFlMOEZ3ZXV1ZVhZUjkyRllkZ0JIKzIyZ1o1SzlzTUQ1bDBLaHdxZWVOKzBu?=
 =?utf-8?B?QWxNcGJsY0JqVmhsU1ZJc0NFYVhlMStvQ00xUmhoakhFZTdjV1B3bEJhcUNP?=
 =?utf-8?B?eCtHQzBWRE5kNDZodVdRM0RmUmE0SWJEcGh1MGtTTjgrTmhvT0RlR28vclhr?=
 =?utf-8?B?eURTQldHZ2tOTUQyY2RVdDN4cEdQWkgwRC9nbHpDalV3dXJ1KzV5RkNzNlRn?=
 =?utf-8?B?WDg3bWNLY2o4RHNBd1dUMGRBWkVCd1ZSV3pRTDNDUzRhZ1JXT0R1b3hhWldD?=
 =?utf-8?B?S0o3MCtMeTZqazA0eURYWkhWSUprN1ZDNlE4cnM4OXl6R0lVblpsZ1h4bHg2?=
 =?utf-8?B?aFZ3YjMxQXZkeVoyQldCU1djY0ZZaVlEMGJPK1d2eWgya3JkQjlkWXVNYU56?=
 =?utf-8?B?TFVodE1XRkpzOEMvVTlMdjhIaVhHOHlMRGROeVpMWTkxMGxTckkvWWtybmxX?=
 =?utf-8?B?UDlLZDNZM2RsRXpHV2E5THUxT2w2RmxkOWxHK2YrRXpmRmRpUkx6RDY0LzUw?=
 =?utf-8?B?RmpML2lWc3lsek4wZmxyd25OT3cxL2dWTGlFd051Zy9kbSttdExRRS8wMXhQ?=
 =?utf-8?B?RkNrYXc1RjIrMGR1QWxab1hLREtKYnJYTDFUWmZXUndIRjFVem5IVjNRTzFh?=
 =?utf-8?B?NmpmcTFrNnpvTFhOR3RkSy9NbXljRFZsYy9TdDl5V2lhM2hBUDZZTWREYUZS?=
 =?utf-8?B?YlRROWJYNlVzMmJRc0ZuTk9KTlErL1crMG4wcTVzbVBPbEpDQS8rd3dCRCtH?=
 =?utf-8?B?bEIvNnFuaVhUYXA5UWpUVWNZRGFEODhuYWxSNjIzR01sN2JhQStOVEdmN0tp?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c734cc-2eac-45b9-a06f-08dced8fb60d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:07:47.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syOx78uOcNC1F72QJUkd91wlOdguB7cfs0SDFmEu/WeOZhlwzAwc9MKPyxV/vkUTdblgk+Scsr3mTp9WNj0c7XAqmj/H279LvnsGoFGmjjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Add the functionality to enable/disable AMD ABMC feature.
> 
> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
> L3_QOS_EXT_CFG. When the state of ABMC is changed, the MSR needs
> to be updated on all the logical processors in the QOS Domain.
> 
> Hardware counters will reset when ABMC state is changed.
> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

With the MSRs ordered numerically per Tony's suggestion:
|Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

