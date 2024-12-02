Return-Path: <linux-kernel+bounces-428469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B449E0EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F39B27534
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF81DF75A;
	Mon,  2 Dec 2024 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3bbGZjC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CE1DED48
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178422; cv=fail; b=JLeXGXZejEK6106mLTFQX5mY62GBsthSeZQHBFjywo1/0XWpWJKJXPlnnD3UgIo8ZdupRCtsrbTPMkYG8MlaOjs9PW2AtZUjLOAvRDmram1Mu15gBx4Kc6mrvXqVVskBwDZUdj481qQTppoH/MSY7fXPxHp2goB0qrruo+dQd+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178422; c=relaxed/simple;
	bh=nzxjqcrG30+br/IRp43chhHOy6ifDN27En0j4rfuIlQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p3f0kctAwJE7WmzfJc4gnBzwo9VNNPgMI+QctCL5KFxd/b8IpZOLnUDXcVDbhFQ/9/mZ0x8lPyR7UsjWmfkoDxNhnaaNSGa0LE/ZXF33dwEKgc9/UW4kh5o74M1zRgVf8+MTukgMuexe1KcGfmAALG2lcjse0bVim5JaeP0eqHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3bbGZjC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733178420; x=1764714420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nzxjqcrG30+br/IRp43chhHOy6ifDN27En0j4rfuIlQ=;
  b=M3bbGZjC+VSXfuRhBU1gtdqDBUO70wz7nrq6KzW7H24Eo9DMUaZ+Ukin
   oW5d3yhzLC3AnbhlST8r84PnLgX5bVUeabKc+G/fesUu/0pSc7Lm18vSK
   JqoFwUK/Qt2Txt6vFqPuaupEqaYxBkInWwO7HccD+OY+fNvg8c5T76+DC
   jB3ieB3YPllzaBDzVpx2IkV6K85yxTDcFWYq63FADaLnsoje4sW43m+PR
   htTon/TcQQf2qorPgXztNI3zxu21WWnQtRxCQ0qPtYuDjocfcQh91Ty6Q
   rK/jjmyGLAY6wT6vgzlUh27i/MrEe/oX+EDFXX+iJe9B8RepoY57SE/o5
   A==;
X-CSE-ConnectionGUID: IjQqmOgOQiCi+MDD0wf7Dg==
X-CSE-MsgGUID: 9NA3KdvbT8iP1SKzvZGCdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="20958049"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="20958049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:27:00 -0800
X-CSE-ConnectionGUID: t52Y8gVRR62rDoawN/Zveg==
X-CSE-MsgGUID: jzp8k/q8T9SlDu7faU39cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="98012566"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 14:27:00 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 14:26:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 14:26:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 14:26:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2q7ugHf2rw7wqCqaVpsRaHJmp3zGdzP2B//kzmwxb5FW8KKFS7YaiRTP4HeuS0tDPhsCyP6xB390eRYUPsNnkxRNP6bQB5NTdiz2IwWtgXjq6WA4zFu8wlNcDvo07VkiJiJ1tixiaUqewXFk4Y5k1qOkmtd0x1UIKU6iGbEinynFs71r/9yb1DrhNSz43RR+Ca0WrlNqGQZXaoSctBuCVPPcliAligdJe7DR4yXlus3v8VKDC/Xh+ndCACysQiAUP1S5D1P2RAIjUSEvOQglYfY+fwcz1/xU6L3+WG1nqb2zZTZ+AQoRe4crLBxdKXPmrNWUcStxB/ZORqHzcTTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtWHC7IY5S25Z0mmHDOvmrMZWREP+/2CVJvUbabyY+4=;
 b=xz6ZOHZUQFUNIw8eJ0FYl0slieA8nZ94X5LpbJ8/1+ljyHQ2YYB8JQt0yVlZpVCQyXW0dfVigdG7CmOT5ZfvCW6nrw4EFMU8FFKIX8sS32zVoX5UsXuk8A9MUUd+5c8TF3OzXw+OzNU4cv3ZGkZcdM7WzPKxDPF27xIzekK5N1HBVenU6C/5eh1rGShui3OOdv0UhxeP8o1INbbcEeYiNT+InvC57j1CB/g9CSwvP3P8T33gs9+3eXFpQfU3TZZKtdwjqSrOHj0zfCQOq88G0cd592tPgMnWwGYHOXpvP9D5Id4BREBcmxyifl6dFiCQVWpQuNU8u+ytwSNWl/EYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 22:26:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 22:26:50 +0000
Message-ID: <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
Date: Mon, 2 Dec 2024 14:26:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl mount fail on v6.13-rc1
To: "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>
CC: <linux-kernel@vger.kernel.org>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Z04pz3AlvI4o0Mr8@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d999934-9659-4572-8682-08dd13206a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWtSWURKTVRzU0ZIbFJvMVNBQ2V1MFZlY1I5MjBtZWt0MmJ3MXhWcWQyWEpT?=
 =?utf-8?B?c1kyOTg4eElnZnB4Qy9tbE83WG9QUHhmM3gvQnhGUVlyNXI0WmRJc0d2ZEJ5?=
 =?utf-8?B?RTFjelpJMHhNNDF1WDRTZ2FGKzlyNFZNSUN3V0c1KzJyRC8yV1ZTVC9GUHJa?=
 =?utf-8?B?MGpZK3RkL3BaelV6aUlXNUZkV09sOVNENTM1N0JEc2U1K1hUazdFZ3VuWWNj?=
 =?utf-8?B?OFMra1FLYzdCNTBDMWR0OENiQWNPY1NzSEE4TWl3TVJtbDI4T0R0czBnREVp?=
 =?utf-8?B?STZiWWxyWXFQa2tDdHoxTlRMcWhwMGZtbjNpMmVFM0IzUVJmR1ZJNE1KQ3Rt?=
 =?utf-8?B?bmRHMkk5Y0JmbS83QmtiQnJPcFNGRWE5K1lEczNrNkJoWVBaRTdvMmxDQmdR?=
 =?utf-8?B?S0tXYyt0REVBa0gvUDFJNG1YMVNkOFpBTHRlc2xIb0NuRnJCWDFWMDZicEFF?=
 =?utf-8?B?eXZUTktCNG5mT0dlWkpwU3MwdW5hQVQwUlR3WC9xK3NwaG5OK0J0MFZ6Rnhh?=
 =?utf-8?B?bEVRcnY5d3lYT20xZ0xWNnpneXdpS0s3bWNOZ0RuN0g1a24wNXBEam1RWFhX?=
 =?utf-8?B?cGkrZ0M1S1Z3aUptKzNSc1ZnMitjeXluL3BWN3RaRGV3d2JLQks5MVpnZGZP?=
 =?utf-8?B?QmhEa0xQMDI2RStSYy9sVVZsTXNUTGlNeXZOcHp2OHRWdlBwd3A2eld1TDI2?=
 =?utf-8?B?QmY4dVpqdzJjZWpia3daNFArbVZqRkpZanZlYXVkSm1ERm93VU1lTTBhdkYx?=
 =?utf-8?B?V2grUkNKeDZIMGNUOHJVZlVhZDRRZ0NlaXhuYWNLNmZnWi96dHVBejMzakdJ?=
 =?utf-8?B?TENzTExTNGdRODlZL2pMUFlrNk1SajZoc2F5YW5zUjQyUHI1WFZKRmJScDUz?=
 =?utf-8?B?Q1VNQm9HN2JTREYvZ2pVdzRNMFJ6K0lUd0FrQnp3V0lOYzlMNzY2NnRHREhY?=
 =?utf-8?B?UTRnWUhsNjdDd3VrbmNWeFpQRnMwbSt5UWZwdS9rZUpJbm9iRFNUcDdFOGt5?=
 =?utf-8?B?QXdodVBxSWdvbEdlUjFDNitmRUpnYTBLbVRwa05Oc1B6aVBLWWpTMmNjYlJO?=
 =?utf-8?B?ZUpYU2NvRWRkbGIyZ0xSSXJhSFFWcFlESnozaHo1U3IyWEhqam1EZ09uNlMw?=
 =?utf-8?B?QThJdU55ek02YXhiSFlHdXJIOXRFZUsxOUZEMUtXL29ab0J0czlVaUJUcWlQ?=
 =?utf-8?B?K3drdGo2QndkbmQ2d2Z5Zm5NWGdjSWVYNU0wR0pyQkR6ZHdCUGIzV25OM3NQ?=
 =?utf-8?B?S1REdGt6UFh6STNVK3FremtqYytKallod2IxNVBSN0lwRUVLK2JvQXVPdkdz?=
 =?utf-8?B?UVlnVXpuS29udzYrU0htdkI0WUtoaUt1M0xKRW5ZNktQOW1pQjdhdlRCSmR0?=
 =?utf-8?B?STQrWjZQRWVUUzVrK0xaaFJTVmEvN25EQkdmQnRxWGU3Tk1OajJVTklidWxr?=
 =?utf-8?B?YmZpU3VYdGQvWUY2UDJ2M3ZQTCtXQ2dsR2J6U3J5N1h2VVYzQW5Hdjc2OWY0?=
 =?utf-8?B?SlB4UFpTSGd6QzhMSXFLL2lyMU9paGh4OUNQODZtbnc1eTJsY3BhTDhtdS9X?=
 =?utf-8?B?VjFhOWRSakZGN2hYVzVNbktYQStZZ0VmbEF4ZTNFUG9NSVRIRlpaZnpCcDBQ?=
 =?utf-8?B?N1RHbnRHU2VqSHZlckpPWEovc2ttSnZBZXFpU3pxdXJQZUo4TVUranE3V1pl?=
 =?utf-8?B?dXVtZ3pGN21LejhUYWl5YnEwVGxhOXBUWDJGcm52bDQxb2tiUkdFM1hPV2hU?=
 =?utf-8?B?alpEdkJpOUNlaHhnN2h6L2lyRnNMekpnWGt4U0RQeWYwYWNoQlR4YVJ5aURN?=
 =?utf-8?B?TSt6SEtrSVJiTXIwaHM3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3F0d1ZuTDFHN085VStEclV3VVM3eUVhTmgxZ2RwTWtyOVQ1Ym1RSXNibDdo?=
 =?utf-8?B?MjBZQmJCb2ZQaVdJMnhDUHNoZWIxZDVGNHR4bFp0d2xqVElUNXZpU3NnSW5y?=
 =?utf-8?B?cXFjZVBuZmlqTlY0Y01pcjNQdWZqaUJRZnJrV0JaVnFqd1V3R082RjI0clM3?=
 =?utf-8?B?RVNLOGFlSnlsSzZqYUZGekVVbFh4K29BUngvTGVrWXVaMEsybk1vcVJUMWw2?=
 =?utf-8?B?TEJ1YzZlc0l5WDIwQ0NseDA5aWExQXZVOCt2QzNPaFI3OU0zZzZheko2YzR0?=
 =?utf-8?B?TmFoekxoMlBxdllIYjREdUVSL1NiL2M1dmtTZjNYckRmZnhlajRvM1NXTnhq?=
 =?utf-8?B?T3JJeWxpRm5maENTRWEzL0t4eFJNczBsTEZqNVgvaGJ6ZnVTVFhGRXU0Vy9T?=
 =?utf-8?B?U3RnTlNoNXNlRWIyZmFjRjhaNEN4MGVYNmRpa281VVBuUnpkUVYrNUFGMU5u?=
 =?utf-8?B?OUJXQnkvNFNEU0IvQVFUSzZHaHJndEFiQ3FzZHhhdlVQTkxoQStUendCZWs0?=
 =?utf-8?B?eEgxeUUxMlZLT1M4VnpPeFIzSEdlQmYyaG9TWmZMRVl4MENJTWlGNTNXMStj?=
 =?utf-8?B?ajVIZHd1Z0N0RllGN2lRYjNoeVVIZ0Y4UzJ0NVBlN1pHTWtMaFNFalo1R3dJ?=
 =?utf-8?B?OXFRUm93MkJuQllYaFdJQVJtRzdWNEVIc0FCMWtpZWROZmFoejVFWURZQzVG?=
 =?utf-8?B?V0tEaWwzQ1NaTFViSUdGSWFLVHpzdXhmR0IzR0R2Z05ibkl0aEM3cXY5bFcx?=
 =?utf-8?B?d2NnZlU1cUc1QVFSNU1SVDVYUm00cW4yNityT29tWlNLM3RhN0M5MUlONTIz?=
 =?utf-8?B?WllEZE1oS3NoZzlQcUl1cjBzelRveng3LzZCSXZkallmY0R1VFVaeHpoM2Jy?=
 =?utf-8?B?cnBLVDB4bW1oU1E5QkVldFhqQ2FtQk1LenVXRTNoVjliOThvenNtK1h1a0tz?=
 =?utf-8?B?NGNOdkcyTGVFcFNjLzFqT2UydkQyYW9xZDJLUElpUVgzZEcxVTZiVkZxOHNm?=
 =?utf-8?B?c3NDRGsxbXdHZExackllYkJOK0RncVF6ZzVSN2NZdzc2VHAvUEdKWlI2NkE1?=
 =?utf-8?B?OEJnOHZOc0ZxazUwYWVKTnhSeFA3bkhVbWNzZ0h5MWFSclhSQzM3Yjk0OFVJ?=
 =?utf-8?B?Vk9MMkhRWXB4amVYWjdsZSs4K3JsSVFQOU1JMHoxd0I4L2pubE9KN1FlTlhS?=
 =?utf-8?B?SEluQ0NsUW4vVkM2Vmx6M1lSamxpMWkwWTN4Y3R0azd2VmViRHYxM3Vzc0Q3?=
 =?utf-8?B?R285MkYvMlVXUlF5ZC9GMXFhZlMzNERWbTZHVmhObTh3VDk1Z25YdnFwZVFO?=
 =?utf-8?B?N0I2dDdEY2JSRWNZVXVNMFF3YmY2UWhQQ2RjdGZuelVhcUh3bVdGK21YWkdO?=
 =?utf-8?B?TnhaYlFaalZwZjEvT2ZIVktJWmJjeUY0TFVNYW1seUNzSkFGMVMzZDYzY1Ro?=
 =?utf-8?B?UzBibE0za0dsY1R3M1F6Mm45OUxGZzhuV2IyRldta3E0RnlTam9kTnQ2d1hE?=
 =?utf-8?B?bUZRcTNTUXFTYitXMXRQSVFLU2llaXBBQldzTG0zOVJ1VjRQUVVGYlZhS0lE?=
 =?utf-8?B?QmR3VmMyYWlCZ0FpNEIyK3BuVC9lRU01V0R5dXhXREF4WVRocXI2M1N3ektk?=
 =?utf-8?B?RkhranMrcE4xNjFVRUFpU3pHc3lXQTJvZVhodWgxb1V0eExydjVId2FoN0gx?=
 =?utf-8?B?NER1S1FjblZCdzlPamtoRHNSMytKOUxyNXBKdFR3bzRjVVBHakoveU5Hb3ZZ?=
 =?utf-8?B?RlF2a1RqMUFKZVVhRE91RjMvemdqNFVZc2wxNGs5dHU1Nkk4bDhsOHhDQmdG?=
 =?utf-8?B?Mk9IZk0vRUZSOWxKQUtPdWt0TEtRMVBCWUhrOUt0NGpLMVN6bjVjWEJQcDAx?=
 =?utf-8?B?NGVJaVVJYXZzNFJhMjdUWXpiWDlvQ2J2Ly9jUkNjKythT2tBYUdBQ3JYdUUv?=
 =?utf-8?B?Z1dqT3ZtNlRrODZzbVNYbE4xR05hTElmQjBQTER5Y292KzJuRG9wSDNTbms3?=
 =?utf-8?B?VzZKdC9jWWZ4Ymd4eVl6cFFNeFRudHIyYVZGRW85aHUzMHJ5QlpKSVQrcndK?=
 =?utf-8?B?WnJYYUx0MjZnMkdaUGttR1RWQ3lQK0tlK0ZIY3BNZi8rcHh2eURvMW93NGl1?=
 =?utf-8?B?OHVPMnozaFU2Nmc4WHJwS1NiNTU3OElmOUtNT2J3N3FtdCtodFRUQUw2ckto?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d999934-9659-4572-8682-08dd13206a67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 22:26:50.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOMveXQKsO53bt+AL3rPkffLkKxFggtun0SyeLrzRLlEDbgcY1go7wS4SYHlr4t9W7ykS3d3Gq1p8Mnx1B3VckceB/e0X/CoXiBzT3ooU8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com

Hi Tony,

On 12/2/24 1:42 PM, Luck, Tony wrote:
> Anyone better a decoding lockdep dumps then me make sense of this?
> 
> All I did was build v6.13-rc1 with (among others)
> 
> CONFIG_PROVE_LOCKING=y
> CONFIG_PROVE_RAW_LOCK_NESTING=y
> CONFIG_PROVE_RCU=y
> 
> and then mount the resctrl filesystem:
> 
> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
> 
> There are only trivial changes to the resctrl code between
> v6.12 (which works) and v6.13-rc1:
> 
> $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
> 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
> 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
> 
> So something in kernfs? Or the way resctrl uses kernfs?

I am not seeing this but that may be because I am not testing with
selinux enabled. My test kernel has:
# CONFIG_SECURITY_SELINUX is not set

I am also not running with any btrfs filesystems. 

Is this your usual setup in which you are seeing this the first time? Is it
perhaps possible for you to bisect?

The subject states "resctrl mount fail" - could you please confirm if
resctrl cannot be mounted in addition to the lockdep warning?

Reinette


