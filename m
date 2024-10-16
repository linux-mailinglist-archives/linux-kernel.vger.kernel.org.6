Return-Path: <linux-kernel+bounces-367150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04599FF25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F531B22B11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A416F909;
	Wed, 16 Oct 2024 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXwuWnTm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F513AF2;
	Wed, 16 Oct 2024 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048359; cv=fail; b=RlYWTLEKT+uF5Ou8GrAEyqXFrJ8Y23gSpbCfc/FN3NlC2WL3THcY471W0wOrqj306L78Ky0tenB5sqo7/YNUSo3ZWZcgny4S2piLmFflnyUxtimBUSGIbi+Eaf3+0NSZ3XJiZmoPFvgPdvyO8beIPgh7lVaJTmCTa3009vi6UI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048359; c=relaxed/simple;
	bh=D39CHV9vNF2rpekzj7oO4RBoQc+oaUIjlXjpOiE4aoE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlJINaJ+YxTHpyrDjL3knbrZgqXgZWTfGmOUmAfYDPR2Ii5DDLOLh1u8GlV9G5DU7KvzumPr3tkWxUimvAHQ2VUSNJHX+7c5ndoC1N1lcxnRtXZNJd/j+SfWjrtNNum6HRNWwaanV3Qvqyz+NqvSo3wBxnGnKZPe8Q5Q0MCrH4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXwuWnTm; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048358; x=1760584358;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D39CHV9vNF2rpekzj7oO4RBoQc+oaUIjlXjpOiE4aoE=;
  b=jXwuWnTm3i0q1ZmLymM3lnOtCPai6Z+GyP5oGCBCgaGcA6MXVs8+Huu5
   jo9vn5KfRhdrA8VicukjZG0aPvmGXBSss5P2yQa4JOAwaCxyoH3WqSjwg
   Pbw3/uC8dyo1+IjRXlbLHxG5TaLZ1bW7wjkmiU+8SciPfrXEK2BDwgJ1M
   /Tc6VA6jjbUKQhUOkZzXebMzXkLW7M2vih3sqZJcw8U0pENpteFmMsOIf
   D05zsG3twKpQkKRKO3rxA30AJIG+WUMvYrJaRDMYbwF66cnCTzBkQ85C6
   9wxY1I4781adUq24xWo28u4yKI2bLnhX3aLF1XTh6M8QzGB1AAvUj5A4z
   A==;
X-CSE-ConnectionGUID: mZtDBxbzTJe/wiJ37z5Q/Q==
X-CSE-MsgGUID: G19eF354RNipnEx2ww+clw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28354658"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28354658"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:12:37 -0700
X-CSE-ConnectionGUID: 7wOVWYgkQGSS0EvVrWSPbA==
X-CSE-MsgGUID: fVp3FbKVRkyGkaxroZZWpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77716039"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:12:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:12:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:12:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:12:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSlPn/ZqDKuwBcfE+vgW7PoBwbLLohaKwOQSQhk8+aoR6ULIs04e92he3wkUP1fjRmKnZ1XiILAilcabiBDtqgB2g+oRA38v+tIH+HYPfAsadYfCgC75F991ORa2eZtbGXrTbkHjX3Qo1Tdw87HuIWmkqQCMMJaRFD1giQKlgaTZAF+YguKHZXX8oC8/85kea3/iE0otCZt4Vp6EoJ6Wxk3b9os7/nA0isodh1QPe12iVNnC+BBeUPvYsi3eJtpWE3UjLPNWn1tKgNwtQkw4ZTkwjcwjPzriDNJ3wxrqnfgPPSNRn7Eyd6U3+1VZvSniXSx1POLdiFHKBqx39w/eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKe2OW1ldZxbZV306duL9gy8SRqumfNxpGweJpc3eRc=;
 b=DFirtfVlTPK1k4YNvtMcPxaNnX8GeYxrwWVeYSS2XHOfEj8ruFkZX2eoILkpR6r4wVaB4fOamqdDe51QnXOTNuLwbQ9srrAWbtfoPGjUQzURy57+dEv8DvHh+QnKSQ1gSe/MgJ093RHKLJJR1xpHDLJpQ9j/z42DUvKanYfwDlrd3AcjJupqA/hwu/q0JDRtzR6QjX78jofDhEa1LoP47rP+/oYXXpA28VxDHlvKISI0f+GFkT4rGJQKwpmRndKQYm4YeJCM6jLubWfhrGgHysAzqIJbKf7tmv00fbDg8cLTjuMihRQ3yImdGWl3CVNajrZ1ouU9cqlX0Mv9QYX/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 03:12:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:12:31 +0000
Message-ID: <6b63542e-0ffb-4612-838e-5f3dba8469cd@intel.com>
Date: Tue, 15 Oct 2024 20:12:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 65694d9d-2e09-4530-56ca-08dced905fba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGs0cWdUNDJJaTVjcHRjMGNxeWVFamNDcWl2REQxc1NrM1NBL1JBaGlqOElm?=
 =?utf-8?B?QTN3dXpvVldIcEJoSnArdHpXV2lLeUs5cjArdStlakRHc3ZmcS94blNKbEp4?=
 =?utf-8?B?M3ZBWTZLYTNmdSs2dlFlWEdiRnRQMW5KblJuejJwZnlKbXF1R1plcFpSQnZn?=
 =?utf-8?B?UG94WWtMWVBYbkNHLzd5L2RyaUloVVlETWIzeG1BalN4Q082TjY4M3lUbEov?=
 =?utf-8?B?UTRuMnEwdVg0NG8vQURUL0pqUkVnelBGOFRKZ2dNZnhIWFJmaUJQYWltRU9V?=
 =?utf-8?B?Q0JmM3lBSWpaR3pwT3IzeGEzMlo1cXhEK0xsY1hMTmR6ZWpoeWZtRURsRk5H?=
 =?utf-8?B?SWNLSGcyRHVhSHNZMDF3OS8rRk1TUjJ0Q2E4TDJNNklVSktIK2hkSEJLeEhR?=
 =?utf-8?B?QmtydkwyWGt2UWthMTZjWENBeXp3b25LQ0tkZWxjSDAvY1JVWlhOaGU4U2tI?=
 =?utf-8?B?NVF3bXJ2MWxEdXVPTTk3MDhqcGF6cFZYZWhPMUlkOGl6Zm95Rm03N0hSVndX?=
 =?utf-8?B?bExvUzlhdk1tT3hzZ2tPTGMwZ1UzdUd0TU51VTdYOGR2amxkTGN0NTVocHhF?=
 =?utf-8?B?MGZDOHdmYStpNEloYS90cXJFOHZnWGlMR2hjdHpFRnpDQkpOdElkcFQ5Nzli?=
 =?utf-8?B?TWRscVVtYWRQREIrckk5VnVNZkYrbXZva1pxelZVc1RtZXN2bk1jUlI5NWcx?=
 =?utf-8?B?M2UyZ09oWkhldU1xNWZETGh5K2hWcGgrcHhEMTUvOUYwNEZyaWZCZ1V3MjMw?=
 =?utf-8?B?d1R6OVR4SkNXZGFqVGYzS2dQYTdNWHpnWWQzNnhpazRNL2Q2OFE3aUFsUGNl?=
 =?utf-8?B?bVFicGFMamhiWDB2amo0R2hxQXErK3Q5S0FMTGYxS0RrVmhEUDh3U1VxaWFz?=
 =?utf-8?B?QjluYWZBWnd5a0RCSTBReDF6YXlOK05MNWNBVWp4UE9IQUxJeUNxQkpPdDJY?=
 =?utf-8?B?TVVqK2VmSmVhL3NMOEdVbmFGN05DVkk0TEllbnhEcmEvVEx0cVdjcXN2cEJJ?=
 =?utf-8?B?TVlHNGluZ1J6QW12dCtDSWppYnpSTno4NGZOYVZSMmRmSkZxK2g1ajBqeW1R?=
 =?utf-8?B?WHFWK1FBOXB4NkN4Z2F3OGRPV1MvZjA0QlZ2cXpzLzhCdXhUZk9BOXEzR0ll?=
 =?utf-8?B?SzZIdURnMFMrN1FQVnh5Vkt2ckpISEMzN2EvMEhRTTd4U0w2K0RLZ1RycC9y?=
 =?utf-8?B?U2NDVFhIOXFCNGdFclp1WVVMWHlHWDFxVm5TLzVqcCtyaE9udThGRjN0YVh4?=
 =?utf-8?B?ZXBKZER3Vndlb2JMZy9CUk9BMDAxMS9IT1FHOFZFTm9OdFI0RHo2NE02UlRr?=
 =?utf-8?B?K0FOemZ2a2xHZ0N0b05IY2lrK0xkUHBRMzJKck9Fa1N1RmJENGRWMmZubk1k?=
 =?utf-8?B?TGRNbXdtU2w0R2s1cjN4elY5dW5ZQkZSVWpPNHZ6aHB6Z2FsdFcxWkxuNm0z?=
 =?utf-8?B?NUZDRXV0M0dPSFo1SHJFSi9EcDUwcEREa2NBRXkvT3RmdlQvdllSM1pVZEpI?=
 =?utf-8?B?OHNYL0dQTDRlK0s3NlYrenhwbTJYRXF4ZDhsZUplazc3d1AraHVndW4vc1c3?=
 =?utf-8?B?SWRzcHN0NThOYTZEWU4zOVcvNUZKb0lHZ2FCd0p2Qm5QUGg2dDl3UFdpTUpS?=
 =?utf-8?B?Y20wbVhwLytjaWRrWWt4QzV5VFNwVTV1eEFGSjBFM0VYSUxOY2kxNmppMkVW?=
 =?utf-8?B?Nko1aGFpK0RhdlAyak10UTdmTWVOZG9LeGtFbXZjMGYzOEpRWitGQ1pBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1NlSmxkeWZZbUdPTW9Pb0FtdDJ6OFppNmNndEdLWXl5NExRVG9qcGdkdDUv?=
 =?utf-8?B?RXJaQ3huNkxNaVVZSXd4b1kvN3dtWmxoOUJYa0FOVGQyLzErRU90UXFZcEta?=
 =?utf-8?B?R1hBRCtGWXgrV2d2STY3djNnQ1l0WmphbENMMmFRdW1yRTdkaGx5cUFuRmtR?=
 =?utf-8?B?R2JrZFdrMEsrbXk5Z1RuTzBkSkE0NmV1WWRIRWQvN1FOTFVzTnNZVjdBQkFa?=
 =?utf-8?B?Q3R5U0FFdk0xVk1NYWk3ZnpUWkJxbEU1dlRmQTR1VlpWMkpqcWd6S0JUSjA3?=
 =?utf-8?B?MWtjVzk1V1NZRzhyMWYxK2tTdGFZMXVQelN6QmxDa2lGUFl5OURXbElSVHVX?=
 =?utf-8?B?OUY0akJ1M09vUGFNOVJCU2RKM2ZxYlg4L29ZQU1SMzRRdTlLOW4ySVNiUmxs?=
 =?utf-8?B?T0pUamhuSzlNT1gwVDZLR3FmRVhFMEpvTktwR0lsM3dvR0dmVmJrdjd3UG9X?=
 =?utf-8?B?U05uajFObjhCVWl0MUFZUHE3MXh3SXFCVk5qR2hwUzlFUmwwc3REQ1lhZ0VE?=
 =?utf-8?B?SG1WOER5dXVudzJrT1BzRjVNWlh5clJpMzllb3N1Q3owNGFrZFZHOW0ycVc2?=
 =?utf-8?B?a240R2Yrb2laK1N4Rk1DenpYSmh4dTZIWXhvWGtMbUNvTnd6Ry85Rzc1RFda?=
 =?utf-8?B?TW9VblpiY0tpQTE2T3lUZWhYQngyOENoS294b1J0MW41cUFsc1YxR0ticWxu?=
 =?utf-8?B?TFZyYTRBdXY2R29tRXpUcDJJMXZYZjB1aU1kUWdCemwxWUNWamFrWG9BNVNO?=
 =?utf-8?B?bHMrZVBhenRyY0tFNzdKZTlHWXdKampNUEw5ellUb01RZGVUTk5pZWRnQlZ5?=
 =?utf-8?B?T01NT2hwQnE3Ly9ISHJpYkhTY2wwVGw2YnV2Z3NlOGhneGVlcnp2Q3B4b0g5?=
 =?utf-8?B?ZDBaOThuc3VHTlRiY0JEb3lHcGlxK1V0ZHZPZkxZWTRGdkJUQkdzdkJjNEg3?=
 =?utf-8?B?QjRFY1BkYWw1KzlXemU0YXpBWjJObkVTU3hzNExkMlhjdmhtdGZrY0Q1V0gr?=
 =?utf-8?B?RmZMWVlEaEI2VGxIcXVNRy9semt2R21TQThlU3l3dmhmcVYwNWJibFZyLzVY?=
 =?utf-8?B?SGxvdjJPdkZkbzk5NkZ4bXA5MXVPR0NjUVcydDA2UWhzdnRTTVhpWnB5aXV5?=
 =?utf-8?B?bklBVTdxNjlFMXQvK2l0Nk9jeEZDTlJtaTlJOGhCOEJBK0diVGp1L1pZR3Bl?=
 =?utf-8?B?VVNDdURvYWtzSVRzd0RhTVIyeUVvMzgzaXJwYStmK1I2RmRoY2IwbTNPYWxZ?=
 =?utf-8?B?Rmdya05CQUlZODRmQlhMbVlGamJGZjdxMFV6T0wxNWlPdmQ4T1FJMTBYbUZx?=
 =?utf-8?B?OWRLMElZVWpLN0g5NlB5cDVNTmI3Y3BUa3V3dTMxaVYxb2w0S0hPSStCbVdU?=
 =?utf-8?B?d3RxVWZPam1Wa0JUN1l6U2JnRTJDeHRlS2hXTldNV3NwM0pMc2RLdEhlOGtY?=
 =?utf-8?B?TzM2U0NPTG82NytiM05VL2R4c21aOWdmS05Qbnoxdnl4ZUdkaGo2cHorN25u?=
 =?utf-8?B?TlBKdjhwVXlJTW1XT1VzV1dkQjFXTDhRcUgwR3pEVVRuZkJ4blJZaWlPS3lj?=
 =?utf-8?B?Zmg4RENVMmlacmcyNUFzYVVKbWc4UWVtUU5UdC9BTFBUNnhoSFh6d2Q5QSsv?=
 =?utf-8?B?aXNVT1IwcGZzci9VazJoQlVDWnM1TmhuUHR6RWpkRDZzVlRlMXFBNHFqNWty?=
 =?utf-8?B?RjVNN3pKWVRuakRLaXVqdXhVVGFDWisrM1ZwT0NOSlFGRWVqeUJQMVJJbFZ2?=
 =?utf-8?B?VjFsS0hTMzA0T2c4VmUzNGFoSWxkL1NOVVNTM0ZEQzZlcEZSZXlwaGR0L3ZO?=
 =?utf-8?B?ZVMrdnFsbVo0Rk9ONnlDenVWbE5UaXpLZ3hLNlFZVkROYUc5ODFJTHJCUUdJ?=
 =?utf-8?B?SE4zOGFVM1BWa2UzOHJvbjgwd05lMHA4STNWWkw2ZXdEaFBQUmFVNWloc1ly?=
 =?utf-8?B?d2p3RlpKbG8zN3plWFNJdldSTk0wcjYrYVBES2xBU1g5VXFuZzEzZFd3SzZn?=
 =?utf-8?B?dmFjQlB2K01zOGZTaUZubU5mUHhrQnpxUHRpa2JLQ0dpZWVFK1ZXUzAwZUFt?=
 =?utf-8?B?dVJBc0RhVis4VkdtWGd1Q0RDL1ZtOWl1Z2VwZngzWjNJU0p0M3NQdEJhaFR6?=
 =?utf-8?B?MURVbUY2VlVDUWpDR3dVbGFPY2twaENTZ0tqcXI5Ui90T3AzMjdnUElNdU5l?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65694d9d-2e09-4530-56ca-08dced905fba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:12:31.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpDGaeJiwAxE3FDJQlI6Q/kEvZhxc4GeCFByPO9DhPYQ8uOyT6QARYKENH3NEKcotJvLzrrHuyTq7lbvLX49LmOk3mOtaGOozjqMlfmYr50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Introduce the interface file "mbm_assign_mode" to list monitor modes
> supported.
> 
> The "mbm_cntr_assign" mode provides the option to assign a counter to
> an RMID, event pair and monitor the bandwidth as long as it is assigned.
> 
> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
> 
> The "default" mode is the existing monitoring mode that works without the
> explicit counter assignment, instead relying on dynamic counter assignment
> by hardware that may result in hardware not dedicating a counter resulting
> in monitoring data reads returning "Unavailable".
> 
> Provide an interface to display the monitor mode on the system.
> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_cntr_assign]
> default
> 
> Switching the mbm_assign_mode will reset all the MBM counters of all
> resctrl groups.

Please note that this now contradicts the documentation. Perhaps this sentence
can just be dropped since there is the documentation within the patch.	


> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 30586728a4cd..e4a7d6e815f6 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,40 @@ with the following files:
>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>  	    0=0x30;1=0x30;3=0x15;4=0x15
>  
> +"mbm_assign_mode":
> +	Reports the list of monitoring modes supported. The enclosed brackets
> +	indicate which mode is enabled.
> +	::
> +
> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +	  [mbm_cntr_assign]
> +	  default
> +
> +	"mbm_cntr_assign":
> +
> +	In mbm_cntr_assign mode user-space is able to specify which control
> +	or monitor groups in resctrl should have a counter assigned using the

Counters cannot be assigned to control groups. How about replacing all instances
of "control and monitor groups" with "CTRL_MON and MON groups", similarly
"control or monitor groups" with "CTRL_MON or MON groups".

> +	'mbm_assign_control' file. The number of counters available is described

Looking at the rest of the doc it seems that the custom is actually to place
filenames in double quotes, like "mbm_assign_control".

> +	in the 'num_mbm_cntrs' file. Changing the mode may cause all counters on
> +	a resource to reset.
> +
> +	The mode is useful on platforms which support more control and monitor
> +	groups than hardware counters, meaning 'unassigned' control or monitor
> +	groups will report 'Unavailable' or count the traffic in an unpredictable
> +	way.

Note two more instances of "control groups" above.

Please note that the above description implies that counter assignment is per-group. For
example, "specify which control	or monitor groups in resctrl should have a counter
assigned" and "useful on platforms which support more control and monitor groups
than hardware counters". This needs to be reworked to reflect that counters
are assigned to events.

> +
> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
> +	enable this mode by default so that counters remain assigned even when the
> +	corresponding RMID is not in use by any processor.

I assume this should remain RMID since this specifically talks about an x86 system?

> +
> +	"default":
> +
> +	By default resctrl assumes each control and monitor group has a hardware
> +	counter. Hardware that does not support 'mbm_cntr_assign' mode will still
> +	allow more control or monitor groups than 'num_rmids' to be created. In
> +	that case reading the mbm_total_bytes and mbm_local_bytes may report
> +	'Unavailable' if there is no counter associated with that group.
> +

I reconsidered my earlier suggestion and I believe it needs a correction since
counter assignment is not per group:

	In default mode resctrl assumes there is a hardware counter for each
	event within every CTRL_MON and MON group. Reading mbm_total_bytes or
	mbm_local_bytes may report 'Unavailable' if there is no counter associated
	with that event.

Please feel free to improve.

>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy

The code change looks good to me.

Reinette


