Return-Path: <linux-kernel+bounces-318100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B872096E85A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1DB2867AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD94437A;
	Fri,  6 Sep 2024 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBYSUAfW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB091CD31
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594169; cv=fail; b=JHfcGO8ycYRvo07hbMaKhAWxQqxULcdhw7P3j7i1yVSPK/QFJ6qf2OeK1/WwVRkuvl8lRsCz/GHgIwjkOla0Xfqr/ZpT9smNP9FUWTHLM1RRep1FEbVWNMEikUORj+82toGgOiw59HcbQalOqo3aZ+As6Keb0IIXkYaP2YT9JzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594169; c=relaxed/simple;
	bh=HO010lRDT3VPfFqVLPIHgd0gLqRu+lJMsnWYXalPkvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CJLarZPg2Hi9Jgn0i25rZM895kirMr6ZDS5gtZLxh7sgh8nzuLk/aJy6iaqP3vDhN2tpLTx4PrVlzTm9Pz39FrQ4xl6wuUrl0bmk4ovca8PcezkvLU4WWZoGEbSgwsLsllK2IlWsxs0ZecR88cgFXH36sSOiLwIVlKGn7kITjis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBYSUAfW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725594166; x=1757130166;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HO010lRDT3VPfFqVLPIHgd0gLqRu+lJMsnWYXalPkvo=;
  b=QBYSUAfWYPfNgb1lakyke4ey7QfEZsqCxBgfcMyzn0iXgITnDsV2A5zW
   vcZJdGfi9Cw9zm/jKLi2N9Q8okj1O2nCXuQWVMIFx05vpdVTvgu8M/Jf4
   WvUd5i9JxxR2aJPUJRxY+oJkv1k7Mi9WaK06dT5vtPwN8fIIlrdZ/2Uio
   tmKY5J5EPpatWSCd9BVrNwXTOiH2+qwnVi16ClDPXFt3oazP3fQpfzfjW
   hVeBxekLe2Dx4JKOYdKyHdqKyrExYGSXVKfbowX22VqC20w87hhK/l/Qi
   h6c3FR3HxDjiSqW8tOghCDGgDqmO5vxtJfSvM7bT3kmKy9k6Eq/wdf0AX
   A==;
X-CSE-ConnectionGUID: dtPmByNIQ22lGhcq+ytO8Q==
X-CSE-MsgGUID: nB1TRZtDQsmlCVJEWleSgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24215607"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="24215607"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:42:45 -0700
X-CSE-ConnectionGUID: 1hk3t/KgT1KHkx+B4k6dPA==
X-CSE-MsgGUID: +gS25unLSaawmNkvxJMRSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="66163465"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 20:42:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 20:42:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 20:42:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 20:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+qX1LevmrKEg3oSYPtHsgQbGH4cgkSwMCCicHw4HCoYVyI3B1VTWNAVOcbqHyCMOwjqzvG8ltaxsb8xZVpLzc1d2WK2g+zQN/mft9I1nyX/hq9o71f5nF5+O7FoNzRkQVv2UNSoENU+kAas3wGbF549sxCTPkW0rSPWzpY9+WuN6PEbd4WAsE/mkVvQjSo7HEaomhzhwZ+nbaoaaTkz25GQBJ6TT4L2x0XV62Jwf2eCHwgtF7p1PdkLFjTNnBwZ4UG5ZnxDKlXIR3Nl928BqOIJdT5C9MliDeMCXI9fPbIxiZhAON+1qBr9hWO90uQxxbosGqxVLwDvKLAa1zuDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvSh/q+OM3ukFndPLtWRJA7VorgJctrnz4v+tGM20Q0=;
 b=bXVtPbaQ/tLaEN3vDol244DWgWKxMNhODf8W57dBn4cr7e0aw7+VqwAf5PHXwfuafpgFOHhSHGsufPw2ym9d8S07H8MSYYERRUE7jgWYY7nmZryDPO9TWxycHUWREmn/1wQL8XLa/QC6CpLTyOPBlfIcEXhBDV+vPOnWvR7tkhZSmIYt2fOsBhsAYaImt6aY50AZPqGbfGo04prULOeiQqBCrSJ3GY4hyqH442noU2Cn7zFdQRKIqtdoPhSJzqUvjIvuKVhVV6aADSyvrki8SbGC9PdjV4ulMUEPu74U7cJV4DxRWXEB+kg/+QOF+23shfuPc45/Vm6WZxPbe2y2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CY8PR11MB7777.namprd11.prod.outlook.com (2603:10b6:930:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 03:42:43 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 03:42:42 +0000
Date: Fri, 6 Sep 2024 11:42:34 +0800
From: Philip Li <philip.li@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: "Maciej W. Rozycki" <macro@orcam.me.uk>, kernel test robot
	<lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>
Subject: Re: error: ABI 'o32' is not supported on CPU 'mips64'
Message-ID: <Ztp6Khar6h3T4RSI@rli9-mobl>
References: <202408310705.y2OPq3Xs-lkp@intel.com>
 <alpine.DEB.2.21.2409051011570.1802@angie.orcam.me.uk>
 <f661ed7e-5d69-403c-bfc8-7581eb8a6e76@app.fastmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f661ed7e-5d69-403c-bfc8-7581eb8a6e76@app.fastmail.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CY8PR11MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: cd512c3f-83f6-41dc-2645-08dcce25f686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnoxSUtnWXNCNTlOWHJUNjBmbTFSZ3ptWmJZQVU5aFNRcGxnblVRRHJZVHF1?=
 =?utf-8?B?YmpmUDZ0M29EM09aWmZxdzFDRG5udHV2QTlIZXR3dHRLcWEzaE91UzZIQmwv?=
 =?utf-8?B?Y0VyWk5Mdm1zMlFsbVVWcHowNUU1RVFWeXFxYmY1Zlc4VEFCc1NPcVVScytR?=
 =?utf-8?B?RnUyRkt5cWpSU2hRMmlWL3d5cmZ4YnZEcFlpOGZwSVJIY1NGNzlybmNYbWxi?=
 =?utf-8?B?cHB6U25hUjcrS3ptOS9wQmJ4dFpodmwyY21oU0VZeXc1K0FOWWplbWYwVDJX?=
 =?utf-8?B?QVlJTStDSTkxU0ZEd290WWF6dWlnWFZYaE9DZk13YmtTYU9JTzcyQWVkaCts?=
 =?utf-8?B?UUo4NitremNZZXI4Y0xDMHhBdE5sRS9LZFFzTFhzV1h4amdYUGlLbWVoTmUx?=
 =?utf-8?B?UEg5dDVTcm9QUitPVnUrVTRaUnowcTlwTWRETzJsc2JNOU9KdXpOdnRBUWsw?=
 =?utf-8?B?Z0EvbnFscFk1bEFsUTRmamlDWTdWNThTR3VwM2xERnVhYmNZb2QxWGZQVGhI?=
 =?utf-8?B?d09QenMxOVQwYUdRaG1wK3ZXV25hZXRHNGRtQjdQNjlIcWhRRk9YeGkyOXFx?=
 =?utf-8?B?eU55MDg4VzN4cFlJZXJXUFRXVXhHOXRraUNJaHJRWnZEZWpPR0MxaDhBZ1VH?=
 =?utf-8?B?bGNSUmRnV1B0WExCTEgzTmZid1MzbTZvVEo0eloyVFgreGNhNzRSY1RlK3ps?=
 =?utf-8?B?UVdTZ3ZIQ2dvZWwzZUp5OVJHWWNZeDd3VkkwYUNvemR6THNpbC9LSFFrdzlV?=
 =?utf-8?B?TkhjdEhpVk9CZ05kVW9HSTdRQkl6Vk9YZERBZWdVZ1Z5WDdVMTdRL1VGM1F5?=
 =?utf-8?B?Yzc3eERSWktmR0IvQ1pKSGVTYnVVUnZ5TjhSVXNhSmt3TlBacXltdGREdHo5?=
 =?utf-8?B?eDlydUJCQ0ErZnVlOWNqdWhPK29LNkMrTEo3M09sRnJLMDB5MDZ6MTRGdkxC?=
 =?utf-8?B?OXg0RlNRdk0rYWh1RFJBVG5oZ3l0U3dUYXZhSEx6c0NnRVdqdFd4UEdXL2tZ?=
 =?utf-8?B?b05VNW9IcnFXU3pvanNMbUxQdFNaK29WVmVaU2doa0JzWXJYR3J4elo0SFdC?=
 =?utf-8?B?ZzdOUGNEcU9aUlNiT3hQM0hFNmo2cm1lN3ozcFV0akk2UWp4QmMwcDdEcHN4?=
 =?utf-8?B?SzJvbE5YWG4vQVRPWGpveWJPVGZGWUwvUUFybDd6cTJjYjVkTnNtZHhack9O?=
 =?utf-8?B?MnAxSDMrS2ZwcHlYaEMzOFhBaDJzSWh3bzNwU0lpZGJ6WjQrZHV4Tis0TEVs?=
 =?utf-8?B?L0o5TElYL0lUUnJwRWdydEtUL21ndjJwR2IwRXg2bXdGenlFcUgrcEgrcmx1?=
 =?utf-8?B?RUZXTDhCem04RjVLS21nRDFGTUVMZXk0UFhLRjFiU2kwUnhKSE92Q0hWRFhB?=
 =?utf-8?B?ZUw5SHorV0VCWkdzR3UyYzVPRld2d0RTaGNTRUI2QU91aXBIUHFDTDJNTzBG?=
 =?utf-8?B?R2JZb1JLNFVya3RibDEva2haZ1lqeEVGaTFNbnc4Y3RwVms2MkhJQlBRd012?=
 =?utf-8?B?K1g0clVMWnVhaTdYcHduUWMzU2NkbGtiUmk5eW1yM0V6WkY1RUdlbmhWOVB6?=
 =?utf-8?B?WEFFYmVRa0lGN0lnOG5KMUJoKzA3TTNld05qdTVaNWN6WmdYaHkyMVhSL0tN?=
 =?utf-8?B?YkhHU2ZSMUFvU1M4cEZiSVVLeG8wdlpVa2FvN3VwNVBtdFF0SzM4MWF0NFJG?=
 =?utf-8?B?ZnhHVGpWM0ZobVQ4dkRxc1ZPQ0dleHNJeXdyRlhoUVF4TVRmN1h4VDdVY2po?=
 =?utf-8?B?UHoyZC9Ba3BvaFl5aHdrVkh6QnloZlFGU1lFcGpjbndVNlpwcTdWVUNlOUZ4?=
 =?utf-8?Q?4TOipstQRW0lsRdDY0y49oW//KN5sxdfEfNC4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXBFR1k0SytPZ1Rac25NSmVQNWZ3RnlmZlV4QlRxV01iWmlPSzhnaUs3c1Jl?=
 =?utf-8?B?WkZOM1g3YjBiTm1kcU04OVpxU0xRTDZZbStqcDZzaXJ0eWlRWm1SUytyby9O?=
 =?utf-8?B?Q3R6dTVOa29jdlJDSmZieG5wam83eWM4cjVoMlRzdWpvcXZyLzZqREhWcTNR?=
 =?utf-8?B?cVZSMDZ5cEdveVByWGVNYTd5WDRGbDUyMUJBOGFpbFplWlMva2dzTHpoNXRs?=
 =?utf-8?B?UDZNM2kwMEJ3NVJ0WDlwOVVIaWMrNzBsQVZ0OWVyWjZWKzVIWVZrUlprT0Fu?=
 =?utf-8?B?b1U1SnFJTHJDd0JzSWRBdkR0U1JEUHl1RUhuTkhvbkk5SFBZa05DSkxVWDlh?=
 =?utf-8?B?SjBzL0QvVDk2bEFTZEVGYlpzRkFFaVc1T2k4WTdORVduVEZsY0NrdzBjTDhK?=
 =?utf-8?B?dnIxOXBSdkdmb0dSQy9qOUJ0VGdRVG52M2VkTW4vUFhIMnhUSU9USUU4U1do?=
 =?utf-8?B?NXZhWGwwLzR1V0QwUSsrQTAzVFF2K2greVlyT1dINEY4V05zQXVkZVRIdDlE?=
 =?utf-8?B?amFYZzA1S3JjRXJIc09KSXFBT2JueTFTTHhIVDdWQS9NcTFISitYMVEvK3ls?=
 =?utf-8?B?QzhTcWorT1hnemsraWtoMnI2a1VvaWZXTktldUcwdGJVWFlWcUV6bHg4N2Mv?=
 =?utf-8?B?UGNjdGFPTWdCVmNVTG14d0VjTzdwRkRKMzdoZDNJVE5iTUpyNnZtRkFKUTd0?=
 =?utf-8?B?QzhhRHQ4UHZReXJIUlc3NHNEeTdqTzNQL0kzVkFPRGtvLzlBSU9IYjJzRzRG?=
 =?utf-8?B?Rmtsc1YxNjBabW5HVEVFc0NNcnlkK3VIMXdTYnBDK0M4SlQ3a2hTWHhqcE1r?=
 =?utf-8?B?YWxCMEI2YlRKUkdQaU1EZS9Mbm5LalhPNURvWmhIS25nOEQ1UkJiSmxiRzBv?=
 =?utf-8?B?d0p4M1lFa0I1YmtkNnRGQjdiR0JrMDFVOGdKbml0b0pSYXppN3hBVlNiV2Rm?=
 =?utf-8?B?MGdUKzRYbmxEYXc4UE1sTmg0SUxDSFQrNVRCdXllN3QzajFWRVBvLzh5TCtu?=
 =?utf-8?B?ejAxSTVBZU15L20rNk05V2xpeUp5ejNCbWZlQ2FmcUpuNWJMeHFhUGR0eW5W?=
 =?utf-8?B?dENUNlVhbnNiRU05S1JadGQ4dysrcXcwZjh5L1JTd1d2SGpIREdKM2M4ZVdE?=
 =?utf-8?B?MForTklKVnJ6ZFNvays3eGo2L1ZsQUkxOEUvNEY3WFRFUkFVVkIwUmFjVVdU?=
 =?utf-8?B?L3NaQzl0R000NXliYjBlQTR1bDUyT3hTcDlnSjFrZ3dSK1BOeVVqd1ZqZ0tT?=
 =?utf-8?B?amE0TmZOWFhUY2FtaklHc1FOZlFuSU5oSTJZZTNQYks3SjhlbENsSCtMV2Ji?=
 =?utf-8?B?SUUwYU5vcjZGZkNHZDF5a1kvdGxETDBTUTdpR0FyQnJSSEpiMGRMdnFPejdC?=
 =?utf-8?B?MjVabktnbHYxc3hsMWVESHJnaU1MTStBa0NFVVFJWHJheUFULy9HNE5id0Nn?=
 =?utf-8?B?MUF5bGNjeWVLNlRuZmtIdmwycjhtWGt2MzR1KzE5b2FvQVFFblNWcXhzaEtZ?=
 =?utf-8?B?cExOTEl5djlSYmYydWVDeGgzcVgyTW9pSWtDZTd4cHFyT2hwdUZaUE1lZXZq?=
 =?utf-8?B?eEVMZzF5VTFuSDBzVDhPdG4zamMvTWVPd05NelBmTEIxd0wwTEFSaEhsQzcv?=
 =?utf-8?B?S2kvdE5CUGlPMFBLZndyNERGNHFwRGJtKzR4aFl5Y2tYcVRoS1RWNWhlaVRL?=
 =?utf-8?B?MUt2dGVvY3dQdVd1ZUtiUE03eVF4bEY3MkpxSEpYK24xLzNjUk9HaUZzRW93?=
 =?utf-8?B?Qy9CNnVQQWt3LzRlclVkMkVyUEhIM29wNVdvaUxBWU51aWpuKzFLd2hXZDc0?=
 =?utf-8?B?U0JvVXVhVkR0dEpGK0ZUVlJxa0xWSy8rWVpmM0E5ZFFBcDhDamU5ZFUvbncy?=
 =?utf-8?B?bzRIRUxHRWRqaWUzUk1EdVV0YnBZcTdhSFczZ245SGxncHNGYXZzZERzZTNa?=
 =?utf-8?B?ZS81U3dBZFF4c3RtaXR6TFNPRUNod0VDOC9rcWNNZkdrYmFMRFZCU0VjT2lX?=
 =?utf-8?B?S3U4REtER0FEQ1d5VEkyTzlMQ1NUazBoekRGZDhVejdNT3cwdk5EeDNGWitx?=
 =?utf-8?B?Tm04SHNramJGYlFVLy92a2FjWmlYNDRreStnMzdETUFwZEVxcW5ZNFUvNUZI?=
 =?utf-8?Q?+NVkt69ntp2GjO+BACwe1MHVy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd512c3f-83f6-41dc-2645-08dcce25f686
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 03:42:42.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asEQ6TuBsCJ0hOE4VQHNGg1B8sfiiFRvx6bFBwaj5cFd0s/e7dgB4ujTMU+ndNizADEu3lOtVc97Vm5bE0jF9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7777
X-OriginatorOrg: intel.com

On Thu, Sep 05, 2024 at 10:56:15AM +0100, Jiaxun Yang wrote:
> 
> 
> 在2024年9月5日九月 上午10:22，Maciej W. Rozycki写道：
> > On Sat, 31 Aug 2024, kernel test robot wrote:
> >
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   fb24560f31f9dff2c97707cfed6029bfebebaf1c
> >> commit: 2326c8f2022636a1e47402ffd09a3b28f737275f MIPS: Fix fallback march for SB1
> >> date:   7 weeks ago
> >> config: mips-randconfig-r121-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310705.y2OPq3Xs-lkp@intel.com/config)
> >> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> >> reproduce: (https://download.01.org/0day-ci/archive/20240831/202408310705.y2OPq3Xs-lkp@intel.com/reproduce)
> >> 
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202408310705.y2OPq3Xs-lkp@intel.com/
> >> 
> >> All errors (new ones prefixed by >>):
> >> 
> >> >> error: ABI 'o32' is not supported on CPU 'mips64'
> >> >> error: error: ABI 'o32' is not supported on CPU 'mips64'
> >>    ABI 'o32' is not supported on CPU 'mips64'
> >>    make[3]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
> >>    make[3]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Error 1
> >>    make[3]: Target 'scripts/mod/' not remade because of errors.
> >>    make[2]: *** [Makefile:1207: prepare0] Error 2
> >>    make[2]: Target 'prepare' not remade because of errors.
> >>    make[1]: *** [Makefile:240: __sub-make] Error 2
> >>    make[1]: Target 'prepare' not remade because of errors.
> >>    make: *** [Makefile:240: __sub-make] Error 2
> >>    make: Target 'prepare' not remade because of errors.
> >
> >  This is a compiler bug.  The MIPS64 ISA does certainly support the o32 
> > ABI, so they need to fix their "CPU 'mips64'" definition.
> 
> Just for record, this has been fixed in LLVM-17 [1], while the bit is still
> on LLVM 15.

Thanks for the info, the bot will ignore the issue on clang-15/16 in future.

> 
> Thanks
> [1]: https://github.com/llvm/llvm-project/commit/7983f8aca82e258174849f1cc6a70029353e9887
> 
> >
> >   Maciej
> 
> -- 
> - Jiaxun
> 

