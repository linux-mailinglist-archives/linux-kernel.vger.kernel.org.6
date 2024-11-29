Return-Path: <linux-kernel+bounces-425551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB1A9DE69C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7657A164C55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B319D07B;
	Fri, 29 Nov 2024 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAdB1F/3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12F155352;
	Fri, 29 Nov 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884187; cv=fail; b=JK4LmSIIs51WNlYOP2hU6ihxNA32Q0qkyysuOlfqxYAw4yCgwByS8P+FDZkzQM4SZoo4yzLwPpGjSvNY8dNgoIYbooFx25QmpHVBA2Vx2Q6itdg6lvh1IPTNBgS4cfyy4WmEsOMShnVBYByssZ1SN+Q89pkTJ3b2lKCaOrIlm1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884187; c=relaxed/simple;
	bh=7X5kq80hJMg6Ls3j43cRr9BCcWU+iIzKEv+Ta3jX/SI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nUQ2kbi62Fo4nhpJeb7+9kIooIOxoaxwxvQmKxrjHpXoMMNlgUR0BYrvSsQ19ytDfq6+9KOWCtPdAquhxpRUXqEu5iKoNli0MmK/7h3+2graTMwwDUwhdEMZPuO5zP6K9vY1nRpGBLkhvxRtKwAGOgy4HteAbYifoKxtk4TTsu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAdB1F/3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732884186; x=1764420186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7X5kq80hJMg6Ls3j43cRr9BCcWU+iIzKEv+Ta3jX/SI=;
  b=nAdB1F/3EgY4DwOeFRP8fg9lSt2bs+8piGfAsdaYVUTqr5caUD5J4I1r
   tjE4TfMm5K/4IaQZESsoICbq6hjA36konJ+eeFreAw0tskqcc7WWEb2xm
   Rj5mbga5LPPxZujxbdf2WJ1o/3ye1gSFNw3wbsU0l+GmkjTaz94jg9L6w
   dZHpSPZv9jzrTX4whRip50ytc0Hl5mFimaU7TZQRRXGh4n8S89c1N/8/B
   AdY2xYCgTiz1T9FVzXQcFo2L3ByyeD0381+pruZnNDaIpPZiQxzzsKYhu
   /4crNHagB2OAH6ag1z5b4SRVq7m5L8eIZcqHYh8uVdNyQIYzsSgDmkKzq
   w==;
X-CSE-ConnectionGUID: ZZHVXrxxQNuCXTQhw/bjnA==
X-CSE-MsgGUID: wKYrvTsuSlqaYmBK7yMunQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36789964"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="36789964"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 04:43:05 -0800
X-CSE-ConnectionGUID: ghDXdsbjRGG0GiCwLeYInQ==
X-CSE-MsgGUID: AhwaM+9JRDOj0t+ojR459A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="96899115"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2024 04:43:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 29 Nov 2024 04:43:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 29 Nov 2024 04:43:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 29 Nov 2024 04:43:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt2e+EinPhR6w1vWKeEi38wvjS/InRBUpCFLKb9hUNKi6M/Iez/tytwChaVwcJeuKI2xJMCqpGDx81dGJGcFsNtvCZs0yplGOT4qAh0OI03zmR4safI65WWGgfUjtUevOC3z30leAsET+pwiHHSz8wGNUegDDcB7GJUZ5vSZwdVU/GtiU0FC54DQIV6/FKoYGmpEeEPzDYjgDSQXkDFj0E2MduEgihC1W0R4gwBhZ075vjw/putwTJ+cpSAUHroNCvUpNsQojUd0ePY7wX4/+FfQVlFULuRL3zjM7DIH9ld2UOoBROmTrYHE6j0eQuUOW4EMUsuCKmKDirRXnPCggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X5kq80hJMg6Ls3j43cRr9BCcWU+iIzKEv+Ta3jX/SI=;
 b=iUWOuCQWKOEqOTyrSy/3Ms7CyteoREWHj9B419kKrz4Av5Jj8k8QdwpEUU8TDfkBygM9T6vt1hrQHfNoY24ZlPzbzHLhd5mTYt5qereE9XXAJSe8WCzvnndtqOG9zjWnvQ+i9UHpNxaPqiZDjJwB9v+J/1gV7ma0P2e5uSRs97Ci3IpiIW3Y3v8SI9veB3oWfBbQVqwRe7WYpals+FJcfR5ymfnDjtYRF+ZAGZtX+Azj2ZF+lCfC3Qax6Re1QIVp2XjB2BafKkMoHYt8ySjxU/LaumZN1LyufXNaj88ZhH5YuLuI2vtIkDvbLBgAjTE05GgUgXZL6IuHCrTdzpdphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 SN7PR11MB7490.namprd11.prod.outlook.com (2603:10b6:806:346::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 12:43:01 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 12:43:01 +0000
Message-ID: <818b1423-6659-4fa1-bf6a-b92dfe374da7@intel.com>
Date: Fri, 29 Nov 2024 13:42:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: Intel: avs: da7219: Remove suspend_pre() and
 resume_post()
To: Marek Maslanka <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
References: <20241128205215.2435485-1-mmaslanka@google.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20241128205215.2435485-1-mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::15) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|SN7PR11MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: f394766c-8339-41b5-05c7-08dd10735c0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SS9UTUdtSERlMFhGTVZpZ0RWNkw1eWxWM0M3S2dndFdyck9UKzNSZ1NpdlBL?=
 =?utf-8?B?WkVYKyttem1MQUM5K0N6d1hoZ0JVSHJUSFdUWmFtYVR5b3d6dDZHNlVjRTBr?=
 =?utf-8?B?WnVBVUdIMWNWUzB0R0Q3bU5rQS9qeFVBTGFzbnpTUm9leTBsVkY2QU5Qc0V5?=
 =?utf-8?B?UGk0QXhLRjBoU3RWY2lwMHJjdTFVZ0tkN3ZwOHV0bVVsanJEd285RUgvUHhP?=
 =?utf-8?B?S2NFaW1vK0F0V3M2YktWVWN1bUswbHN3L1RKREIzYlNEaDZqU29US20wWXBj?=
 =?utf-8?B?UWdoa2Y1eGNNektwZytlTVRTbjRvZ2NzMEVrOUpHK0oybkVBNmJYVnV2N2Nu?=
 =?utf-8?B?S1lqdHhuWDFBVmVYQnNET1lhRzlGS1IwSW1IWTlCcmJTTUVSOUsrUlczZmht?=
 =?utf-8?B?NlpuZ3FGVnBUYlZuYnlsWnA5QVJTejFXWnNEUWszSVBnQWwwTTRYTHU3Qk0w?=
 =?utf-8?B?MlBxSCtqeVZwSGVJUzhrTlBBMFA2THRkZGFwTHVIQUNkdjEvV3NmTVQrY3Zh?=
 =?utf-8?B?VkNuWldQUXhzVEc5bGJDR3ZSaFdSdEpoVUJJTVlWTlRhVENoQy9hUHlZa1hG?=
 =?utf-8?B?OTRYVGkwcy9zd3h2Ui9uUFJlcnBKTFRjWloyOWVnYXJwUWtiL3ZPKzkyL2Vz?=
 =?utf-8?B?TDY3azBJS3FVSEJ6d3RyL3hDczBWbW5WangyVXFXdUJ1Q2ZoRjdJNVFldkl0?=
 =?utf-8?B?S0JuTmIvWjM1UldJTm1OYjUvYkV4OVFsSzdzVTlFSHR6d2Jtc1JodXVFRExx?=
 =?utf-8?B?Zm1pV2QzV0JXNXlmRGJpOURxUnM3T25DVm02SDNyK09QenhaMFM3THJIMkU5?=
 =?utf-8?B?ZUcrMy8zQjk1WW51RVZPc282TU9aZEhyWnpCRGlnMkFac2tUcSsvcVgxaHFX?=
 =?utf-8?B?eGxLTldTVVFMTnJ6Z3p5eVBFNERXRGxBOVlnRUx6U1BUc0pKbXBqejdhYlQv?=
 =?utf-8?B?alpaWnd5RkFOMU9Jdnc2OHl4bmp0RGpLcEQ0K2Nwa3ZwaEtmQmFHQmFNMXRo?=
 =?utf-8?B?b0Zya1h1RndCL2Q5Z2dsdElpNk5GUTdBVHpEQmlxNlViSHRPdnIzMmdjZmZz?=
 =?utf-8?B?TmVTS0s5R1JHMmVhMlVvUHVVTHVZQWc3V1FPRXJhWjl5YzhUY0hQQldNUWVu?=
 =?utf-8?B?VFZjQkhrOHhrM2svdHU0TDZEWU13OTUydjM2dndXNGVlRkJuMTNOQzUvbmN2?=
 =?utf-8?B?NTdtYnVpYWw2cDNaSUVUZFhjV0xkNSs1RnZuWnhDRm9LbFlGYzhFa3lraUxx?=
 =?utf-8?B?bk8vMkFxcU9JRDVhLytWMEthSGRqRnJBazN5RU50NmlyMlUyYUYyMWtndlM4?=
 =?utf-8?B?MG1UcDY2UGZmWlg2TjNyYUI2TkZoSWpOeVA3VE9meHdXYmt4dUZXU1QwbElU?=
 =?utf-8?B?b2pWdU1aejNFaHhqSk4vR2JWK09BZjlUNVZrVU5adFBIMWFJRjdKenQ5UUhN?=
 =?utf-8?B?MnpRK1ZScDY0aUF0S2J0bmNUanA5ejNKRFJWQXVENEdHYzh6WVlDeUg1dE8v?=
 =?utf-8?B?RkRmYzZrUFF4UFZwR2JlTGp0TVZJUDJTTWM0NTk2MncvVEhPQ1VpbW1LMXdM?=
 =?utf-8?B?L0k4TW1XLy83b0hYTGRUVnRjQlF6a1dMRFU4SWR3dUFNNFFla1FDWkJCeHVB?=
 =?utf-8?B?YTFLaklNeEtQbXl0UUJISm9GVGhrN3RHQVllOHZUVzNKT2tldXc0SEFHR01x?=
 =?utf-8?B?TjBnNHJ6TUZiSS9rQzZiNlJ2ZHhaNFh5UnNQQlF3U0VQOTRoRVRlTFlvd2c3?=
 =?utf-8?B?eXEyT1hQYTF3Z2lKRjlIWFgxY3ZZd3czc3RyK3RYQWt5a3ZQRDJacHpIY0pM?=
 =?utf-8?B?cEY3OFJOcjByM0pGMGxSQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlBhQ0xrM3ZnUUM2dkFsbUVXbFA2dlV3MGdPUnlJaWZTeC9lcDJqWGEycDV0?=
 =?utf-8?B?QVFxaGlTbXpXcld2ZVBja0ZVV2RZQnZYa2hEOXhMM1YxY1hTYTlqdGxuenV5?=
 =?utf-8?B?ZUgyNm8wb2Jrck9oSUhNR3JLeC9uTzQ5UytTRWNKbGFUS2VCWTdVVFRHc1Rp?=
 =?utf-8?B?M0kvejBXM3VVeEE2OGFlVi9EeUhYVEN5OFowRmEwcytRZE9WVEU5VGFacVFt?=
 =?utf-8?B?eFM4cEFZTkwrUkxIbEx2ZmNLSHdtT0ZaUmIrQTZXbEFkSXorRS9URWZiK2t3?=
 =?utf-8?B?Y2NuS25GU1d5dHlUK3hwNS92a01OeFQwc0EzdmdOaFRsZU9nVE1CU2YrelRz?=
 =?utf-8?B?VHloaDFNbkdmUmd2YnlIczNWbWpCTS9ScmNnUHhmL1BNU3hwQnRHYTdVaVFL?=
 =?utf-8?B?b2o5eitIc29TOTRhdFozR09tMmQvVjFIVTZxem5xZ3o1MHJEZjVQY21paUpB?=
 =?utf-8?B?STl3QzYxcDNFUU01c2w1ckhIbWhqaDhPSnV6cS9YV0pRQUZCYVlxUTEzY3N6?=
 =?utf-8?B?UmNqSnhpZnI0anBIV2x4N3oxS2czTDM5aGYwN1V4anlCUWFCb1VIL3JoZ2R0?=
 =?utf-8?B?R1lGODFKamZuOWxqbGhhR3dXcndKY25kR1pmRjRreEJ1RkcwWXVsdWoyTWFK?=
 =?utf-8?B?OGh4cnVvd0huZFkyMk11R3ZmcWMzSHU3Zk9xTlRwbllIYVRCRUlIWWJQMDdn?=
 =?utf-8?B?ZjBVelFTQ1JHbCsyTXh3WE9LUm9TbHdRQVAxcWduZUlua2NPdnFzd1hQckh4?=
 =?utf-8?B?WTJHZFY2UGpQQ1JxbytjeG1nb2xPUkIzUXNmZXFSOXVudGNaZHE0bG9hNTZu?=
 =?utf-8?B?KzQ5Vi9DVWZLM0JxVFJJTGplYUVuZEtaUHBSTFlpNTlhN1FQRVB1dHJ3dmI4?=
 =?utf-8?B?VzNOYVMwUEtpR1JKVTVoT3lINjIvNTQrakN0VXdPU2J4UGhlZUNTN2doY25M?=
 =?utf-8?B?Skp1QmRwQVp6WG00dFJIOS9zSnhJd3E0czQ0aXNxMERWUWVHdTcyWW5iM2ZP?=
 =?utf-8?B?NElZUzI2elJFMnIzK2tMZ2owNTlLbkxlT1pHZURKWVhJU0Jsemx6T0o5cEYv?=
 =?utf-8?B?TFo1b0pKQjk1QUg2QjByKy9KTEVsVFM2eGpCNDI0M2wrMzk3Qk8zdklSR0Zy?=
 =?utf-8?B?L21kRU5DWFRVTzNVL1NCdWlEbThTUlNZR3NVR0cxZ0FQMHdtekI5MzZMMmor?=
 =?utf-8?B?Nm5IR0JIcTVOTExnUVVZNnB3Y3dnOG1LMjhjb1Q3Tk5mZk90UDkyYTM4R3o4?=
 =?utf-8?B?enZnNUEvN1JJMnVoNTFXc0JoZWhEM2NibmgrdlV2WWU4QlJoM1BEVVdvOTR3?=
 =?utf-8?B?dDlFUzVwRzFZUm04Qmlrc3p4am9qYzFkSkMvYjkxQ3d3OVVWdHp1NVJ4SGNw?=
 =?utf-8?B?Qy8wVjBqQzdSQlZ5Qk4vby8veFFLamVKbDFOdTY4SHVIbkRmenBzVVhmcm9C?=
 =?utf-8?B?UjhIeWlWU0ZDOHdHRDFhODhiR3FLSktZVHJNSHVTV1NjaXZZLzl6Z0FBbjZp?=
 =?utf-8?B?WWV3cDJLNUxnNDRxeDkvTDN0WHlQb01LOUtja0dEK0NkL1l5azd1Q1FlVUNR?=
 =?utf-8?B?aWJCd25RVEVJMXNxdlFBL3FRVVAwNGZHekd4Yy9JTkxEVktPN1FpRVQvTmlZ?=
 =?utf-8?B?U2tjQytiRHlLbWVReW1hM3puUk1uMGJueGxEc3VRdTlWYjNvTXlURTVLaG43?=
 =?utf-8?B?eTdqRFFHaUJqcGZvVklRTGpNY2xkTW4xK0FJYVcxd2Q1R0p3NkZTNGIzWlZn?=
 =?utf-8?B?VytRWEZ6TnVaVjF2TzgxN3h5SzRiSG42V2I1VGpYOUtQWllXYU03MUYrSktk?=
 =?utf-8?B?cURlU0tzVnJXeDVMWTBJeFpYVnZoUjcrL1FmaG5rWmFCRHhSa1dNejZVamND?=
 =?utf-8?B?N3cwVnphRmNUdkoxeE9Fck1rRFRSTE1NaEM2U3Y4NzhLdHpLOWczR2JnTk9B?=
 =?utf-8?B?eFhuR2FTUDcxWWxMTE5yL2hva3UvSGRRYmJpY3lXRXE4ekd3b0dlK0JkZFZ1?=
 =?utf-8?B?a0ViMmlKUGMrbUZUNzFlT0tTd2N3ZTUzTnB4RW1BMGdVTHE1MHVteExzMHdJ?=
 =?utf-8?B?Sk1VdG4vbUJFeFlSenY4Y09qcm1IM2hQbjJmWkhhYklpOXo3STJPR3o0bExs?=
 =?utf-8?B?aldUOTdIVGZnc0RWYmhlVGtqeGJwUm9JUTViRkFabjNFTjJpZk44a0g5QUto?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f394766c-8339-41b5-05c7-08dd10735c0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 12:43:01.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzUbhy0hYmqvnXFjV4IWeGFc8ntS8g6C87pmtZV4WQyCj+2TQNkPnsSp05r9/OZJ9bjswSE4yhRhheYjr1ecpDoRidE1S2/+9fF+rgLAutI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7490
X-OriginatorOrg: intel.com

On 2024-11-28 9:52 PM, Marek Maslanka wrote:
> The presence of a plugged jack is not detected after resuming the device
> if the jack was plugged before the device was suspended. This problem is
> caused by calling the
> sound/soc/codecs/da7219-aad.c:da7219_aad_jack_det() function on resume,
> which forces the jack insertion state to be unplugged.


Much nicer.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

