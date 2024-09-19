Return-Path: <linux-kernel+bounces-333733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8497CD15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D0828591C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8B1A072A;
	Thu, 19 Sep 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGeFhlNX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB717999;
	Thu, 19 Sep 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767085; cv=fail; b=Bx55LlvxMGyTBFpeT3dDPSoz2LXk3ARBc7DH1joQ4v5N/SKOzi78wciZYQonpN9B5IP2BdK5v7/G+6i3zW3Sx0CvAbUi8vuP8vdz6ARzS5Rls0BpVWSLx4fBVMLoEdYu57lXQPw1brMC/kBhCPw4sPZLEsjie8+e+B3OeSVKjUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767085; c=relaxed/simple;
	bh=oeqh6Y4Mb0gYLTNFHsTvULw7tQY/1iqp0qua3TEKZXU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZpHgSqAbItiqlKkVVL48BrUfuybddCo5huOpoIFPGpqH7I+hkpO3JjoyJGe8FtrSHzUcA8r2QuTgT1NELWZigUkSk9/twcRM80htjWH3hvVzzrB0SkbDMXY38lb18mKD5L345gSv/LAK7efdKck+QPSTXRsqTaCtkS3TkPmMtug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGeFhlNX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726767084; x=1758303084;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oeqh6Y4Mb0gYLTNFHsTvULw7tQY/1iqp0qua3TEKZXU=;
  b=WGeFhlNXgRm9Hg4lbwrknvo+e0PAN/yVsBQhbgQEgwwmsP6gE4dRH6fJ
   nmFXdlQpGPliAeEdE9drve6DYoiXpVf2jJMXcgm/54ZCsSKPrq/cDbL22
   yw87hk/tUFoJ1cVYCgm91VB8tKuN0mxB9TsKGAuDA/swVhKrXRPkHlQi7
   1jecruaRGube7/zXla8uFrUTlsFjy/oc2PTt+gfLj6TL93FFX5oJU5Wax
   JDrO94i4QKFvZTSqKSwLcjmGA3BYQvFBP+cjQIaHSsxU0UbTx1svXZtTg
   FlTXAKa41Hm73QyN7y7fnCeuFGT2ZzbYoVoxvabWagy594upI+dlMo3Fp
   w==;
X-CSE-ConnectionGUID: dqIzq1ZgRjmNdwndzIWgnA==
X-CSE-MsgGUID: ikRYvFssRQ6jO+3g+4Z8bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25871221"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25871221"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:31:23 -0700
X-CSE-ConnectionGUID: +maZ9xxITAG4r/MIJjwOHQ==
X-CSE-MsgGUID: AIVoGCMNQeetaJDuC2PNyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="70306489"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:31:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:31:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:31:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:31:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drRvOwFMUGJpL3WXp+YoLCGReApvphRz6FyTxCBp4iEc29NsmBSzJVbC5ewO7lBJFaQ9D30f3qcElSTXUVWH7VlMqriCcE/E26fZRFwwHn7H/3LqKLGdeMm+zQi4OIGUpHd5hPZfdM19nMgeKzP1z9vahruu5ceyhUmAPjTxzSNYmr4MmPY0AEM9BIX1PSrY8acMwA5L6Ks2ec6Qd+4bBWiwcfSZYM3dUyaMntWYDKzYFx8mhEa0GrIGBCyO8/9EUekGPIns+GoXneYMPN+DRXtiVs2PENmcrh+dkaIt5cPYKgo4t/gKA6RJ708gYYg1Z38kz6yRVYk7lFuSq8ukjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTVkYZ+HlpiTrttnQY6b+6aG919RHio2j/gH8ZJwBsA=;
 b=OogtuQWN3duUkjoQO/HmwtWlFaxeGiGyspGB1bQb++pVCvpNDPMzbNNKF/R27pi3kmCh70CDdbUF8HiTCrlWcCc0m+miqF1Yl6W84JdvB/Vz2i9tJ7DkOHJsYxySwXGoE8TgWiL0Lnq1Nrf74qQBThrnA1hoTWpz/gdK0QqwV3R30L1vJ3NEYZIdcVyLPj+6MUmfOiz230M9KWEJ9N0RATFJcFvTlcKJO3pyjYXVSOvRBVWpAfZSWZXnJ2IkJ9tOh2Ph4m2bPwUOTfBxOLBvo+OGvXWn8Gdk6KBgo4CpcrBO6alZQ5GRC0QZ5I4XU0Cszcsl59DzjjyNJPNSndMcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 17:31:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:31:18 +0000
Message-ID: <f5f61804-3743-42ef-83ed-6c198c4eef74@intel.com>
Date: Thu, 19 Sep 2024 10:31:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/24] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <1c5b054d8fbc3f7ad22c686d0d5e21e6573187bd.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1c5b054d8fbc3f7ad22c686d0d5e21e6573187bd.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:303:6b::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c35eb80-9987-4bfa-ad3f-08dcd8d0deb9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlQyWmpjQzZzY1ZOeGRxYTlpUjBuWWkyN0UvVjVMYXBhWkRVTmk4c3psNXcy?=
 =?utf-8?B?TGVLT05SY1ZtbVoxdUowWHVYV2RBN1did25pVVFJdGpraHkvYWVLVWMvQm9S?=
 =?utf-8?B?SG5iSWdBTm1vZ2NWM3F3c1R1UXM0R2dyMGRmS21xaDdHaHEwRGRZU01qME1h?=
 =?utf-8?B?YnRYeUxkSDloZk1mZ3BQaUxYK2JVQXVaOGdsM0lXUFdVUmZBNWRsU2Z3TlBi?=
 =?utf-8?B?V3VGRFo5NVlQYzlqaTI0ZFFoWDFTazFCSnNWa0NCZGpEbklHOEhQNTNnUjVw?=
 =?utf-8?B?aWlMOUUwRmZIck01RkErQUREc0ZSTVZmc0drYjZnYnJIcktyblZXaXRRQys3?=
 =?utf-8?B?MDNwU1p2d2l2VUpBVkw0cHV2NHBzaVlLWDVONThmbytRZU9zMEZMTkQ5bGIz?=
 =?utf-8?B?N214YXlBSytQWFAzdU5tbHpBL0RLVUVteVJHVTVlRklYNkFGSG15ZFd2b0w2?=
 =?utf-8?B?UmFUbVBiaC91ckdNZzNLa0g5TGFCRGdrWDBmQ294N3lQdzhtWFpUN0lBQ3Bh?=
 =?utf-8?B?ckFlN1ZIc2ROMkFTbVFEbDBNTUJ0dEM1NGVYMkdGREhTMkM4YzQ3cnVhaHI1?=
 =?utf-8?B?cEFJT0M1MlZTcHdzZnBSVDV1anBiVHZOOWlhaWEzOXFpcjBSMWUyTnlGM0x3?=
 =?utf-8?B?WjdkVzdPMlhLcGdYUFFab1pDZEF6Q1dkUGVtZjNraW9vK1dtam4rYVU0YmpB?=
 =?utf-8?B?NlY4MUpIN2hJaUJGSmxtSnZyazZSV1NlV3k4cmorMVBiQlE3UnRKUzU2a1NX?=
 =?utf-8?B?OTNKQW9mdjJGbGRPMHFpYkVUbXNpUEJsZEtUeXVEMVFtZ0xEUllkbW1EY2Nr?=
 =?utf-8?B?bEttWFo4U1BYb1hqS0dVSCtKeFA1L0NZMkp6b1AvL3grVE9Ndzd3dkdxOXo4?=
 =?utf-8?B?ZFhXUXJ0dlBHN3hHUUV4NzcrSkZ2OFFkaC9hWGJDR2VTL2dCdzNCcTBOR2th?=
 =?utf-8?B?WUtEMjVXZk1OTHNzMmQ1K2VtWE52YW9vQ1kzalFFMHg5SEJoL3BSYU9Ia2VU?=
 =?utf-8?B?WnQ1SkY5bGNmU3NtSi80ZHZ6TU1GQ2l6Mml1cEx0Z1JnZ1BiSmdxTXJoUU5z?=
 =?utf-8?B?aFdPZ29PWGZ1alVGL2w1NnpOeU5ldm1JSFdPY0EvU09xVmxBNmNRMytOQmxx?=
 =?utf-8?B?Q0hGVU9EQzRIeGw4cGE3SnI3MHBPRWp5aUNBQnFvWG9PbUVvYmRtcjRIbFpY?=
 =?utf-8?B?NzUwdW5XUk9YMlFJQThwZDlLaTZPOU5sK3AvZzNMSHROZzNoVElNTnNXZWxW?=
 =?utf-8?B?YUc3UEZMV3Y4YmZHREFDY2FGKzVGdldtUitKM2ZRaXNZejJzUGJwdnZQOG4v?=
 =?utf-8?B?Z3FDbWVhMGFxLy8vZmlTbUtzd21vcEo2cGdCYnNHZ0x2dndpMGU4RG82NTNI?=
 =?utf-8?B?OTRoRkJWVG5WcHNaOXVGNXpsNG12Yy9CZ3Q5UDNUek9oRWhpeUNnWDVUclps?=
 =?utf-8?B?MC9nQnNaN1VNdnZCbDdvMEoxVklQOGQ3U3dwNW5BZEViMjB0ZEIxNCsyckZD?=
 =?utf-8?B?QVJWRlp3RlBrL29WOVVmVVVVYkNNU1ovdEpQWHhLN1FxM0FQTjV1L0JYWGdV?=
 =?utf-8?B?RFo5U2VjVVFiTmpoMUdycGVSZmcxVTlFRWtqc1pmb1NhUXNoaGlNNWhBZXRP?=
 =?utf-8?B?b0N4Q0FUOWZFMXRFZktvT1cxdzE2MUFFZlNzQS9PK3pnSDB6bFltYVhLUHor?=
 =?utf-8?B?ZXY4aVFOOWxNOW5FNnZsMjNkZmU5SUQ0a0NoWk9zckk4bSs4N1pNdW9PRGN0?=
 =?utf-8?B?eFNWT3BpMXF3Zm0zT1BjWW9YYzVCM08vVFhzc2JuS0pCRnd2RHBvUFlVekZM?=
 =?utf-8?B?d2N2dDlPaHZJSXYrdnN2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVQSGJkYmxhdUdiSmZVMzMzSmNXalhMQXlxNTZZKy9yMXlvd3VWU3VoTy9x?=
 =?utf-8?B?V3pMRVU2VTRZb2hTbGwyR3Mwem16U3ExVFF5RXdvMUowRmVBQmoybUtLQklk?=
 =?utf-8?B?MDR2QmNYbXM0OVpuZ3lPcVJ6TUkvRVRwcmtTeEZqbTROOUE0ZTZINjRPYzJX?=
 =?utf-8?B?K2ZXWEJBMVh2UDRaV3FwYWRsamVFZVVxUWk4Vzk3bE1nWS9Za2JsTk5MNGU5?=
 =?utf-8?B?RG5iSmdraCs2anlOOUlIbm5DQ1lwQnJnem1QYWNIWjNjNVlGb1dLQW80bVB5?=
 =?utf-8?B?a0o5MldwbnlXQTBNSFhyenhhcVRxbXpXbEd6dHZIOW4yRDVBSDY4WTBNU0Yr?=
 =?utf-8?B?ck9HV0tJcGpRaGhmbVRWOEd6cFh0eWYrcmRvd09BNWxEMkpMdS9zaWh1YTJD?=
 =?utf-8?B?aTdRYVF5ZFRZVUpVbHFGREdWMU1UU3hLZ0UyWVBpdDRKTVMwdGlyM3ZSSzZa?=
 =?utf-8?B?L0lsc3UvaE1sbmEvQ2lMZnZDNFZINHA0VFFQU3RtbGFUUy9SOHlwTi9sZm93?=
 =?utf-8?B?N1FiVjJzUWdWNHlGaWlDN2IrTlNoY2VHS3RHVjg5UFllU0ErUmFkZVprbXdF?=
 =?utf-8?B?eUh2TkhGSUtlcmN4VW5IelN2enF0Z1FaOVRLb0xSWTV0WEg5NkE3TVpEdkps?=
 =?utf-8?B?QW1RTTdKNUJpRFNQbVNyWDJVSWlBY25SUUppOEVORldmVWhVQUdTSUZGZmRZ?=
 =?utf-8?B?aHFxcjVZd2xFTTFOcnFoTzNaUEkyUk9yUHdKUHozTmE0R0EwRjBmdlV1b25O?=
 =?utf-8?B?TGtQUEJ4anRueGlKYlY5RVo5aDdlZkEwRkdFdUZyc1RoSEFMSnVRbnYyZzVL?=
 =?utf-8?B?Wk4xS3lsSnNDWjBVVlJBcmtSUmhubWFHY0EyUTZweVdNbDdWeFFab1prLzRD?=
 =?utf-8?B?eTFvbmQ3UllkNlRoRDFGaEpibE10eFRlZUs0NnYrdVdMUEcvK25laGdnL0Mz?=
 =?utf-8?B?aEZrTldEbXV0djJaQmhoZURvc3lOVng5R3BsOGlQc25pdkdzemV1cEIvZ0JG?=
 =?utf-8?B?L2RaOXpFcjFITFJjUWlISnVBNVUrbHlHREVvTXNiNlVTVjc4a280M0ExY0RH?=
 =?utf-8?B?SUcyWFpjclpRZThhUHpydDliL0ZablFjdXJBSG1UdUxjZUdVT1FGYmM5bE1P?=
 =?utf-8?B?VkpMblVuU2RnWXBjci9oYlJ5OWVQcUxCZTFsRmNzMTFlY3A1RHZGbzh5UFpp?=
 =?utf-8?B?RGd6RnNGS0JlTzd3VXpGeCtNUkZCZFpGQlFFQSs2enNOS2hNV0pOOHBocWFJ?=
 =?utf-8?B?OURoRWdZS3BPdDl0TU1FOW9KVDJ4ZTU0eDJHVWRMdzJyaXliV01veVR4RUhk?=
 =?utf-8?B?WVdodWZuMUhPdUNxR0tvczFPUE55VWVpN0dramlQTmN4eUJlTEdyVTBjaGpH?=
 =?utf-8?B?M1Zhb2Qya3JGckR2WGRETFgyQ2lnMldoZGpubTJQL2tmaVR2MEZLaWRQNXla?=
 =?utf-8?B?Nmw1S0xaSlJKUGcvQ0hta3BmaWNUa2xheXl0d2UvUEQ0ZlYvbU83eU9tZzU3?=
 =?utf-8?B?QW5VVURXNjNNRERicms1RGVOdStweGMxOXBnZGhGdEF6cTNZZTJheW8weGhp?=
 =?utf-8?B?YitoOXNhTVo2S3NOSjF0NzRhcnRJZkhQck1jU0FPcWFkSm5nZ0JoRVdIQjlG?=
 =?utf-8?B?RHU2VTZkNm1oc1lic1IzeTIvWFRKNUxoV041Y2EwczVyZU5EZjBjZVcxbW5G?=
 =?utf-8?B?TnloQXp3dHN6MlZRZW9yMDc0Yk0xT25pSXhIay93a3o0cFg4dXREdFBUdkIz?=
 =?utf-8?B?Q0l1bTNWbDF0SldYYWRRVmFITEZ6MWswMzVpVVlCbXNpTjk5WTJ3NitlL1Jt?=
 =?utf-8?B?MXdrdEg5MHFxSTAyc2JUa3kvTTQ2OU1BTEdQMnRsU1FPNTNObmsxZ3ZSb0VS?=
 =?utf-8?B?K2d3YUR4MS82Tzc3OGxzbWNtLzBRUzljc2VIS0krOVkyT1UyVE8xQjNJSzE5?=
 =?utf-8?B?ZWZVRGRnZHgrb0VNcnBBVjN0cEkyQ1NaOTR0NFAxTjdNRlZ4eWl4LzczVyt1?=
 =?utf-8?B?Zjk1RmsvYnhSd1RkZi9RaXNQem1ZVGI0MkJGWU1CMWZVVy9jMVpmeTcybkJa?=
 =?utf-8?B?Rnlxa2l6b1hNNWtuYkt0cjJ3TVppNUlVbmhmNWZLZkMwNmhMOXFvUDJUeDZq?=
 =?utf-8?B?d2xKOGtZR3RyRE9UMEtlWjJCbE44WGwvTEdEMHFycCtuU0t0WS82dGZIVGFK?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c35eb80-9987-4bfa-ad3f-08dcd8d0deb9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:31:18.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuEwO80jasmHmHZCJ0xvofGFCoA+D1Qq/iqyNr8lwm238iR+DdWhByeiDC3MazYuPKXj7eBxeuBKevjasig0Wku3SdjBDt085+zJ4+1n8Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> In mbm_cntr_assign mode, the hardware counter should be assigned to read
> the MBM events.
> 
> Report "Unassigned" in case the user attempts to read the events without
> assigning the counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Moved the documentation under "mon_data".
>     Updated the text little bit.
> 
> v6: Added more explaination in the resctrl.rst
>     Added checks to detect "Unassigned" before reading RMID.
> 
> v5: New patch.
> ---
>  Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 3e9302971faf..ff5397d19704 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -417,6 +417,16 @@ When monitoring is enabled all MON groups will also contain:
>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>  	where "YY" is the node number.
>  
> +	The mbm_cntr_assign mode allows users to assign a hardware counter
> +	to an RMID-event pair, enabling bandwidth monitoring for as long
> +	as the counter remains assigned. The hardware will continue tracking
> +	the assigned RMID until the user manually unassigns it, ensuring
> +	that counters are not reset during this period. With a limited number
> +	of counters, the system may run out of assignable resources. In
> +	mbm_cntr_assign mode, MBM event counters will return "Unassigned"
> +	if the counter is not allocated to the event when read. Users must
> +	manually assign a counter to read the events.
> +

Please consider how this text could also be relevant to soft-ABMC.

>  "mon_hw_id":
>  	Available only with debug option. The identifier used by hardware
>  	for the monitor group. On x86 this is the RMID.
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..fc19b1d131b2 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  	union mon_data_bits md;
> -	int ret = 0;
> +	int ret = 0, index;
>  
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
> @@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	evtid = md.u.evtid;
>  	r = &rdt_resources_all[resid].r_resctrl;
>  
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {
> +		index = mon_event_config_index_get(evtid);

This should use MBM_EVENT_ARRAY_INDEX, not the arch index.

> +		if (index != INVALID_CONFIG_INDEX &&
> +		    rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
> +			rr.err = -ENOENT;
> +			goto checkresult;
> +		}
> +	}
> +
>  	if (md.u.sum) {
>  		/*
>  		 * This file requires summing across all domains that share
> @@ -613,6 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  		seq_puts(m, "Error\n");
>  	else if (rr.err == -EINVAL)
>  		seq_puts(m, "Unavailable\n");
> +	else if (rr.err == -ENOENT)
> +		seq_puts(m, "Unassigned\n");
>  	else
>  		seq_printf(m, "%llu\n", rr.val);
>  

Reinette

