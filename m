Return-Path: <linux-kernel+bounces-438882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989929EA810
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BD81889C45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756591D6DD1;
	Tue, 10 Dec 2024 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHS5y70k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345EA94D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809604; cv=fail; b=rOTF7oXNrVeCi1m+X5+wBQQW3NqAKVrrQfTFRWBhPEKRcORIkht/Nyg/bNPdluX7SYwS6E3kKhsw7VEmuQJhOKp5ru1uBUZQ9m4PsQLxgQX1TEahsgxDCNny0xrKcoRFupzN3XdyMkLR6Ek152GmpbiGaqJ5m1Su1HVTBT1Fh+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809604; c=relaxed/simple;
	bh=dk9emKYKj1v9Bbk6z6QpQO8kbHR7+qGEuBtOIQ1hpG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HQzNqWFXNBQbjgEOOUyR2IstO6alRUsBUojSiaL2CzTyX5zpq1dIm4yUKlxTtOU9XO1Ys45AuDY3PrIFBQIMhGEaElo3Dm3i5firvbeJnxP28qyiuv01zPeqN7BUafngd2a4iOEeNJSXBX+WGa13KC6NRyoJbolRKpskkku0n+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHS5y70k; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733809603; x=1765345603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dk9emKYKj1v9Bbk6z6QpQO8kbHR7+qGEuBtOIQ1hpG0=;
  b=VHS5y70k7Xd53om73A5Z0FY6+UTOSU0y5rLWAjK9e50bYQqL6vG44XN9
   t1l8FcGAnKgGahYONWk05YA4C6LcI7RlInVmKrmx/z8haSCsaD0Auc2aC
   p8C6fVRNt0l1pn1UD9dAVWnVehgLlOSe3VQhSr8al1TU0DQYB+laVK7A4
   Qy2ZiPC1hREFQHpTLVjiYaTo9ePSU+lG9mj1YPO5vFCLrqUkRBq6fv1TX
   x38MBveJiG/cgdwcJswgXiH0SXYqpiCMOJpN6nceBgAx3vka1BzEBk3Ut
   fq2mPMKG8vsanvVxfjKnLvy8UOdVhhVdUtwK6xMuojwjKh04NWSI8AVrQ
   w==;
X-CSE-ConnectionGUID: bNfi4O7BSPiUHTptevfbgQ==
X-CSE-MsgGUID: j8JhdracRHqkvFXBmSygnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="37822160"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="37822160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 21:46:41 -0800
X-CSE-ConnectionGUID: 8+F7rwunQ3mBdoMlP+7qHg==
X-CSE-MsgGUID: ehHzksk3Qvmp3M8gFDxRTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="95117984"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 21:46:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 21:46:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 21:46:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 21:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncreCUn+Cpz4o2SuwwR1XivzsaIBJ0maSVWddOHZxO8ITR9e0uFAvRueirkpme/gEofS+bFQQPculJdBKiGJW4r8yoHkae/BTjERPk5mAh5Fd2gB+rn2WHoS/knis+XgooD/CSRpouaIopWGMTpsQyc16Xxk1nTQnU5217tM58oIwpJBXIQXpi18JNBBvvpzax0tBYunjUr6GAE7z5j8MYCCDo0y9AFO57IGsOnQr+zlUi7pt7OVpVzfGuKXaRvA5AbS4mEW9PyfQ6X3whuy4BQSoKUa6UINP2EECTfC/L3CZdQubZxUxAdenTP+isHk6kT3gowvw3ezvPNPnkTDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSg9YAA0SLidC+rw0RpS88+pvST6UGgF1cDsK5ksv5o=;
 b=pXLHWBVLUUpP1JeUthRP5Vc3xH7qpsVtUMpA7Olue4BHrEiU0cTC6WVDr2w6k1slY0Woc8f+zp2AbD/K9IY4iDgekBWZu1WS4pKN+hXVNlqrkbRITc1H1lCf8xDSEs32aTkqZ69cFo7GqzVlcS98rpILHMdwc9pVP6MYZvVLSHPiPYhV6uORo6WFkiH/2fDT/UFGS0karlLa5HEUFeHVj5/P4dFtM223rXJMpbyEpPtBVLEqiE3SDc8aS54VNNJJ3aPicshQzxLi5/1V1KCXo15Xp8V8Q+fcH2DGhZlu9LFrpJ1NT1Sxp6CsmK1aQd1HsRZ31e+dni1HioN9vImmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SN7PR11MB7706.namprd11.prod.outlook.com (2603:10b6:806:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 05:46:37 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%2]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 05:46:37 +0000
Date: Tue, 10 Dec 2024 13:46:26 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <kan.liang@linux.intel.com>, <mingo@kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>,
	<pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 1/5] x86/cpu: Introduce new microcode matching helper
Message-ID: <Z1fVslUeUwjBNwdI@intel.com>
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
 <20241206193831.3BBA3834@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241206193831.3BBA3834@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SN7PR11MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0caffa86-a12c-493c-a668-08dd18de0359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zvyAIdp34k8Z+3jnkhUXv4wOHtZ6SaucecdZv7nnN2kNLuk18L7ZoK26pe+N?=
 =?us-ascii?Q?bZKov9GkrG0hKsRqqLhE/Y59lOb+/oNCoggBHtGdboIaeotpAyjVOZVoqici?=
 =?us-ascii?Q?hbjiMuy6qpQAVhK1Y4MsjEaSE2QC7CuQHTpkanuX5iAsNMvQ5iVRFcTZsF8l?=
 =?us-ascii?Q?sTPKKvtzO/2MV8/eWLG26tHWtWqEkob/ShDrEwd9MMDPn5y0Px354wDGWsoe?=
 =?us-ascii?Q?nDpAqNUmJOlRkIvLy9fInKMwUkLwk+Zb9eQ1dJdRAPvRW3Ekp0uAZtfXjk4V?=
 =?us-ascii?Q?4/xum7bGNwhqohvvRIK8LgwG3f/3f0YKNI69xqw8fMI71EI+YrqwoEmycYvc?=
 =?us-ascii?Q?fkpgslCAyohMQWow4t6aaPQiNuJe/T0r1AfG04weLt9BkKfNBiO+8cRkYrRj?=
 =?us-ascii?Q?YoH8WRSSQHOY2vYcoqmbiTIX+1/B7Isr/kiWX6YJawAQKWgZCjwkSLYz7DkQ?=
 =?us-ascii?Q?q0AIYa9dWGv4IT2Tigi7BWmhzqUBmeVa/oWJInkjKqbB1kd9ayfkkMStfW5g?=
 =?us-ascii?Q?ytdJUD6gIHwyLHaOuxfDqHC7fktlRE4IT5I4IyBPIgMZWpgPCjKH6mVQ5oX7?=
 =?us-ascii?Q?UikXbFeDWLnQilVE1D6Db1e7j3JhRiQjXd2WCMuFOq9I/4CpwWGHgS9Yq7uC?=
 =?us-ascii?Q?l0wt5qpyTTkZ8nenUzmrXpkz4zkIfFkTmeA9hu1DjqGFD7K6tTPNLJ6uy8Cn?=
 =?us-ascii?Q?L+fCDTg04fn+EtOZcyGnq79POazqoebPjpxGizGpvRINZ6GfBZ+wQ+96VYQe?=
 =?us-ascii?Q?+Zvh7qqNF8XAW3XOW1Z3af10vBzZ0+2vrVPxd8+ZZbmSX9YyOfSh8kDo1zBg?=
 =?us-ascii?Q?JvRJwoV/B/hBGrxw4w5hEPIjry4ABvP7WbLNMJegVDLB5/aFSLW6QOP3Ggv7?=
 =?us-ascii?Q?31N7H/jt10Uc08TOWD/AO7w8/k8z8gRYrYs/2Xq87Qjlb0NBB8S3VeNDIazC?=
 =?us-ascii?Q?djT8nlPYSXy0twOJR0LBEk71vh9MPUGqZKx7ViOgBupRRc0ukv1VGLxJjYfs?=
 =?us-ascii?Q?arbO1C3vqFxunURKd0tYe5FXmZCv89A7AxLnM9aEOlC0zDHPmzTw8Jk7iEhg?=
 =?us-ascii?Q?W1UZGl5R1J/0kCL9j5uuWfmXaVwMxJOYH0TpIN7wb8m0Gxioi13M8sqvgJ0r?=
 =?us-ascii?Q?+0uVJ5AEk6kBGsRaypUmfAFI1yrUTcAyB+hb7HW5Z3/YK95wcEkgOZ2DVfJL?=
 =?us-ascii?Q?rbvcq0x164/YSbCeEYgEEX7mlAaSIQdGOoPjrvcXYFkwEPGAQSNkLjrP2rSq?=
 =?us-ascii?Q?yVg75zDzREH+kfSI/cYVZ+1WiJ6w+Xo2ip/3fhzLYjVUhMH847dcbul3yYIb?=
 =?us-ascii?Q?sU00LJXYIqSstuXF5CjdfZ7Cld9J8tDRLLOFrZYQ6b6NvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k7p1LvWEX3VXIouKasBA4Dhn4wBNohViBu867XrDb0eHCR0XDLfjPIX58Mki?=
 =?us-ascii?Q?u+ke6yimYSDpw4KygFSO1PDJ4V9REf3hRFo2jOWHQ6PxMhwJWfoi9a9tyqI+?=
 =?us-ascii?Q?lCtV1dvLYAQhBU3g91YlLOw6bkIMsZgeL8OlAQ3npC10kUbV6GxRv8Fj591/?=
 =?us-ascii?Q?NX1KPmc3Uo2KBdjE1mNt5OPWk6l4ojoVrBQx8VLRRmkiS+m9ouKZ9sGdcuad?=
 =?us-ascii?Q?lKLjwIhhjyzzjKPtXYMeShJBGkqNdoiuZIJRc8BVIFk/mZg7M1Yne1L7Pl4O?=
 =?us-ascii?Q?J4vTOLSVeh8diZbkHtbWb6IBxMYC9D8JMfl49fvR15CwDFFP2Q44havgJBOn?=
 =?us-ascii?Q?O8L/mwZ0H8YQ0rwGpQa6xa4+S1B7u1RAYVx9MoDxsR46K80nUoAiMiRZ9qJg?=
 =?us-ascii?Q?1c3nRvfXB3x/a1XBqCidDU71g42KA8ARzotLWtApe0c5wcfH0vPhHtVourN6?=
 =?us-ascii?Q?wARBrrhFmCaXOnh8W+OZBo00gUGATIpld2CCF0J/TWYRN20ZLEUaYvAG9lZI?=
 =?us-ascii?Q?jNux2W6HEKSAV9euS/4+WxO1vHWOSW7liWKOQnfPe/pobaR/9eXZPAwg7DDP?=
 =?us-ascii?Q?HfmjY3tVH2MGEk92/HQpwfBTKpQ6wLdzwAVZS+2tT1YCBPhuk3oJvUgZb+8z?=
 =?us-ascii?Q?GPUb3+31G0hZErWOsgGeIj9NomQISGcyfMP+38jKIiTIHetMXIFAtLa/aU0u?=
 =?us-ascii?Q?MwrMMbf/w4ryDT0gj2e8HQ+X4tYyE1M5WpSw6DGYyW3mUTUXC0cQvgm2nj1w?=
 =?us-ascii?Q?jBoJk6/93pdOB37drNz1jGEU+xkE6QZtZLv0NjCNwsgS68RRqucuFApfPsnc?=
 =?us-ascii?Q?eurmWmM4Pjd9U76rylN9KJ3kYmFYvIZPgWv+0nwlybb0IwRhNLxe66ADmaNF?=
 =?us-ascii?Q?/zVVWrI8+DX1DT2boYSxoBqJj5ZsJtVeptiZni6eMfbFJx1qKI/Iz5N8AMxR?=
 =?us-ascii?Q?NiY1nEkufcROnDG/xWAfBKJJ2HXqnRaSAzH18vsJWvoJvSXrMrrSkR7PHP1E?=
 =?us-ascii?Q?jJBPToKe9Qd83QvPVy3hFGo6iBUuUvkJZqW+yeMFkx3HKVKHsiEnCKZHWJ7G?=
 =?us-ascii?Q?hquWaCIuuTsn0h9whMs469q7CIUGdci/9dRtDFtLQl8gKvIOyoLuspaMJqft?=
 =?us-ascii?Q?ZZxAs/0sUdmJQGTXZEP5yO18Qnz4TeK+7C73FgoqpWNvoA8/UUN5ks9qdKg9?=
 =?us-ascii?Q?IJWV5dLSvNbWpVmSo0EStwS+RraLMWyvloxrG+TwiFYbCDihaZqdw2qysxZV?=
 =?us-ascii?Q?ap3SgC2yWpczxjh3IRlU5J/Sz8pW3CjweE65I7sqNSCPhB7CStRnFymwTsrD?=
 =?us-ascii?Q?YNbptt+Jzu3t69wxpAdmNfqOC1ClLRtiugaOsnFCmdzf4iWTGvBh5yg4akic?=
 =?us-ascii?Q?QHRW5oay/wnkswqJ5xF9I4G8WxLnokcUu+R4k+ZOngOldisQl3a+UiezVgQY?=
 =?us-ascii?Q?sCa0XPwLIRgAy8xdc0lqMW2T9FRLRKv9CFG+u4kXx5tbqog5ePOcQ+3Ds/cg?=
 =?us-ascii?Q?x6684C80TWHwptJ5kKArxDt8kGgRpJlNXMgosRnJG3zByMfh3fKo5LKzcggT?=
 =?us-ascii?Q?cDG2Z7ugz1ZJ8bKmULaJ+iZED1qJff/tz3oEdnfn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caffa86-a12c-493c-a668-08dd18de0359
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 05:46:37.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BqvL0OJEpsgDwoyHh9+lNMDfzOXoLqo080jFixgo16bHAE6ScWflM+hDbIZzBYAIe/cX354kRCGD4NOcoTyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7706
X-OriginatorOrg: intel.com

On Fri, Dec 06, 2024 at 11:38:31AM -0800, Dave Hansen wrote:
>
>From: Dave Hansen <dave.hansen@linux.intel.com>
>
>The 'x86_cpu_id' and 'x86_cpu_desc' structures are very similar and
>need to be consolidated.  There is a microcode version matching
>function for 'x86_cpu_desc' but not 'x86_cpu_id'.
>
>Create one for 'x86_cpu_id'.
>
>This essentially just leverages the x86_cpu_id->driver_data field
>to replace the less generic x86_cpu_desc->x86_microcode_rev field.
>
>Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>---
>
> b/arch/x86/include/asm/cpu_device_id.h |    1 +
> b/arch/x86/kernel/cpu/match.c          |   11 +++++++++++
> 2 files changed, 12 insertions(+)
>
>diff -puN arch/x86/include/asm/cpu_device_id.h~min-ucode-rev arch/x86/include/asm/cpu_device_id.h
>--- a/arch/x86/include/asm/cpu_device_id.h~min-ucode-rev	2024-12-06 11:33:15.663128241 -0800
>+++ b/arch/x86/include/asm/cpu_device_id.h	2024-12-06 11:33:15.667128399 -0800
>@@ -278,5 +278,6 @@ struct x86_cpu_desc {
> 
> extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
> extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
>+extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
> 
> #endif /* _ASM_X86_CPU_DEVICE_ID */
>diff -puN arch/x86/kernel/cpu/match.c~min-ucode-rev arch/x86/kernel/cpu/match.c
>--- a/arch/x86/kernel/cpu/match.c~min-ucode-rev	2024-12-06 11:33:15.663128241 -0800
>+++ b/arch/x86/kernel/cpu/match.c	2024-12-06 11:33:15.667128399 -0800
>@@ -86,3 +86,14 @@ bool x86_cpu_has_min_microcode_rev(const
> 	return true;
> }
> EXPORT_SYMBOL_GPL(x86_cpu_has_min_microcode_rev);
>+
>+bool x86_match_min_microcode_rev(const struct x86_cpu_id *table)
>+{
>+	const struct x86_cpu_id *res = x86_match_cpu(table);
>+
>+	if (!res || res->driver_data > boot_cpu_data.microcode)
>+		return false;
>+
>+	return true;

Maybe we can simplify the logic to:

	return res && res->driver_data <= boot_cpu_data.microcode;

>+}
>+EXPORT_SYMBOL_GPL(x86_match_min_microcode_rev);
>_

