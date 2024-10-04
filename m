Return-Path: <linux-kernel+bounces-351440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10DB99113A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58CF1C23630
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA22A1428E7;
	Fri,  4 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKAO9D48"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C503231CAC
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076714; cv=fail; b=K1u56Laj/ecRKh9RaBRv9sdTsOyxqYzl3JU1jkfol5nfnhsMqxNw0mqs2v1sj1cjqYLRIVPkYRTt1J4slqeiRa+Y3bNij9QYUY6KzxEzOlpCjzghkS/QIHt0HlmpSpXtK8CGdTNostGG39VKg5wpk+6KnidgwIopUuL4tqG7/WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076714; c=relaxed/simple;
	bh=8u5KRd1Y75vgE5tgiVdudiLwkGSvk5UmIC1P6MTPj/8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Anvt0a5rsIo4zxu+sjkxlCqjQSXV9VgkKB/5Dgt5nM7hVl4NTtvuJtVmJK61MrjkMaugFJ1+Z9DbDA9IeyWpR3sPwUQ0OAU9+reAgLoFyPZzRtPGw9/m0BOSXeRsAzqojJYJnH8bwZ77qjd4tM/KsWqFdZTnhJysg8nWq65ekRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKAO9D48; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728076712; x=1759612712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8u5KRd1Y75vgE5tgiVdudiLwkGSvk5UmIC1P6MTPj/8=;
  b=KKAO9D481xbmqHRkiY2rngUxDKFsBij+exW8ZG2UmUTFLGVy+knqB1no
   NTyI/45YPid0p3Aw4IiUgS65Ht5kqiS1TNJUek9c3xp2rZai0kxOhhz38
   xNcLc5y2dpcAvQzkuVRD0jPloIU0JdksjyNAD9Xvi9XbuQswv0FWlggFl
   +gfwAcySPutI2djrxNUzcvusrjhq6b6uJuD5btc40uGbRvd6ttfzvJRgF
   btNz6GeeAXpdv3ssd25mHqW4p5Zdo874qYZNkeq1WPT5Mvb8zfHmZLe+i
   EXk7NFLuOH9gL7YA8TBVmADgtr4GdPMh9MHApgW2ozH5z8lPbA3HXlYMw
   A==;
X-CSE-ConnectionGUID: 9cuckghhSde78qs+KB5ZMQ==
X-CSE-MsgGUID: Fqk4vyxlSj+jTT1dq6V61Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="31195878"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="31195878"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:18:30 -0700
X-CSE-ConnectionGUID: DMys2qFTSXOVsJOENEkN0w==
X-CSE-MsgGUID: g2FhSq5jRWm4LCYraqXQXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="79394775"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 14:18:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 14:18:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 14:18:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 14:18:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 14:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylsOvjHN+i/Q/6BRGga+eqbo5ux9lV+IlR3NhGvA7F3ebinOboIjztDQmAxf5xYfgfnhsKJhcAg4fftzQHjUitaEkDOA7r0zgk4eiV2jesURVKwE93wN+CVixRdCN05MpvuogzvBG0P9ureaxzLQJdfKkgnwqOG9lacbUeqlYLdxHQm+tsXHBrpqXrrv6PMZxslJAfUaxadb5kMni+AKa8oBIMpcOStm/n5RjF2rVhs2aZ9tEh+pE28uhHgCBk64LEbO5tSBSuJ3djXkWgCHfPZilz+i2DBFx7xbigR22Gdv9+utMWesRACJWcK+6SVIYArhllTbAsHphUHvhn++2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6Y4IziJKOVk9bP/nVwygTFxi1YQIepVjHKwj4tE9Cc=;
 b=buuSyaoXAEt8HNJ3E6+hRcJuqOvkqWe3Gt0BDzTcMXbbOndjFCsUxTF+DXwh27dUeqbtZ5lL8IAEDvPTipHZg+bsMWh4uWXBptQJN4PI1McpMcww5OfHQ307RT7Ji/wdDYaK08uJLAlAwAwYYYPyYeLraB6q5i09eW7O7AZ/mfGMB500K7938Gf6tST1Q41r5nXCYDo61ytyLTe0SHNIjtulMoDjnrr0bv+VhH26C40mYjUvMxautQaPN3I2wKtGOcVJBXnwvdxdfi2/vnvBGeRVqdZPzZLOyTCvtx0bkWiA3S1JbMGYiWoDgHn+7vab3FnIFfYlJQojE5xfIr4hPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5198.namprd11.prod.outlook.com (2603:10b6:a03:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 21:18:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 21:18:27 +0000
Message-ID: <a1b78dd3-db42-4bf7-b004-e718b582e28c@intel.com>
Date: Fri, 4 Oct 2024 14:18:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/40] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: b576abe7-b858-4898-f449-08dce4ba16d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0xPc0F0Y3VsRWRhcU5ES2RHNlJ1NloxbnF4alREWjRxVjFaN2FzS2F5RDc4?=
 =?utf-8?B?WW9reWZVdmZLM0tlaVp6VDRxckgwQUdVRGhQMUtFd1AwOUNlTnEzYTB6aHRR?=
 =?utf-8?B?VnpWMENPNUV4WE40NWNEbFJ6TnBNV2R5cExabFJtTDJWQnBaellTdWZhQyts?=
 =?utf-8?B?Wm41a3EyNjFObnh2c05hb0lQUzVEeHFCUUwxOXNidWxmUHErZzRlaU5NbXdV?=
 =?utf-8?B?cExWMDF0TjZBWDk1TFVTdXVIZXNpQUFCZXMvdDh1WVJwZXExbnRpclk3bUNY?=
 =?utf-8?B?TjNNYlpKY3lyV3A5SE0vOGw5c3VEMlgrZmJFRnA5dzhSZ1RZTEREOXhrNXp2?=
 =?utf-8?B?aVgwdUtKVitWNkNiNHBYOGVqeW5EMFV0NDRoQ3VtQ3lOanRBbGlsTEFzOC9n?=
 =?utf-8?B?a1h2NXhyUnlzR0tyRHdvTmhYSUlJYkovVjQyQ0xjdnBrb1FpUWRGQUgrZDQ3?=
 =?utf-8?B?R1JpN0tSdE14Q2xOZkI1QlYyMkQvbVd0dDhieTAzTTk1S0NoR011eFFpUFll?=
 =?utf-8?B?TCsvUHNUcVk4WUIvQnRLd1dDOFdGK0RSYnhCS2hIOUlNbkxOaHZhR1A5RVEw?=
 =?utf-8?B?NEt1Q3dPTVdzMHprVi90Nmp1dDVIVnNOZXVQM3RobjlpWTVrejBlclorQkJv?=
 =?utf-8?B?YTBrUGVVY3hITVBiZ2pGa2hTVmt5djBDTElyZ0U4R084TlNMQmNFbDFwc3JL?=
 =?utf-8?B?UkNKZlRYN254cWNwSkdGRWZmQnRsYkhTSVFadVBURFYxZi9oM2RiV2wwQ3g5?=
 =?utf-8?B?K3RYZXFnOXZVZ3c2MkJ3dmE5Z3g2SmNlN2t3dmJaWm43VEUvNHlydU5LYXJL?=
 =?utf-8?B?ODE5c3ExQjNocmpyb3p2eVVBdkgyd0FEMFd0dityNTdNN3NMbDZVQkJVbGZu?=
 =?utf-8?B?MGxVMWFRYnZoRHNXU25CUGYvMGdKby96aFFFRVJzQUNLYys3bnM2UFRCcXlo?=
 =?utf-8?B?Mmxla1A1anRHdlJaSEJGMlcra3VYakc3aXZpd01xUFFRTXBaQ2Z2dlVMWCsz?=
 =?utf-8?B?SU1JaU0vLzhZa01vR09Od0RpNCtSdEpmMUZ4SzZ5MDhMMnNVNU9rcUw5dFFE?=
 =?utf-8?B?bjhLcFJXbGJSSnJjYUtwb0VSRmxEUkJjR2JudEVoSkRzYXNTY2xCZkt2NENu?=
 =?utf-8?B?b2hUcmRDakk1bFV0OWpUOUFZblZnK0ZHSXZwTU1kNlBBWXJQKzRIUUVrcDBa?=
 =?utf-8?B?TlA5NmtGWW5mVXlGQXdhV1FRVUdibUgzTzQwRk5saDl3clBnSGJYTlV3c3FV?=
 =?utf-8?B?dXNsSy9oTzhMMjBsV3UzcnhLL2FBNGg0K3ZVQnBLZTYwUGZEcFloblN6endx?=
 =?utf-8?B?WlBucS96NmNrZHlnRTRPQWoyT3ZkcGs3VkR3aDg1U2VqOUVvbXJjTzhZUWRh?=
 =?utf-8?B?RHJJUS9vRlhWWVFuU3hkK3FsaUJxdG9rV1Q2UDRBSTI3bUt6cSs0bnQ1Z21S?=
 =?utf-8?B?WG9TL0NtUDNqTXhsK1Evb3RmbnA2RWJhSGJ3cVRmL2h2aGQwdzVQRWpRREJ4?=
 =?utf-8?B?eDA0QkxZMStQWi9qUDE4REZ2azhuQ2ZodDZWS1o5U28rMm0vbXdLTDQrcXVl?=
 =?utf-8?B?Sk9tMytYK0xnZEtUUDhIMWJSclBsZkxkWlZOb3ZEZE9teFRRTzhoOFhGcWhz?=
 =?utf-8?B?Y0Q2Qmc2bUlTOTQrRU41a2tBdmFrd3VIWjBmM3M1dldTQ1dxT0g1aUZBYVVV?=
 =?utf-8?B?U1duYlYzUnc1SlFQYUo4YnhlcDlzeHNDMjhIZFQxTnJSTTRwazZDSlJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3YrY0c4YldMM3NOTnJ4TDdmeXVrOG10amJWMEVwSEtJdngybUNDNXNhZExw?=
 =?utf-8?B?MmRTUUQzc24xWHhReFpoRm9ZeHd0OUJxSkJXZnFneW0vMjErSVlweTlGZjdN?=
 =?utf-8?B?Qk92cytJU3JzQ2o2Rm1CZnRRUGlvVDhPTWlTTXJ1VjhKZ2JiWFhqZnNuV3lY?=
 =?utf-8?B?OFVtMnM1VHJmL21xUEp5MjlOZnhxZ1dVQnlVTEhsTGFGZHNLcjRwYnFQQ2Rs?=
 =?utf-8?B?OTJLTVZTam1mK01vRFJla2lnd2ZMZzdKTjQ3OEVaYlg3eEs1Znh2Nm5PZjF1?=
 =?utf-8?B?c0s0NjVoL0hYY29uQXlvZzlETmdFZ3JkakpialdNNXZ5Z2UzNHRmVUFpSE8y?=
 =?utf-8?B?NlA5ejdBV1QwWU1odUtYNEg4V3orYnlpbzczQ1JkaEpwdDR4K2oyWXJyc2FT?=
 =?utf-8?B?QTQ1Q0RMWi9GcHpLM1J0aWwyckhTWEFiQmdCYTNxVjZLaWdmM0tDY3VUcHNJ?=
 =?utf-8?B?ZzR5OW93bWVwc2JxcEd3TE9KaHF3cHU4NlN2aVdDZEdONjQzZTJoeEl4SW5X?=
 =?utf-8?B?YisreU02cWYzdVRQTUI1RUFpbzV1QXEycW5mNHNUU2I3V1AveG5NRUNtbm1q?=
 =?utf-8?B?Vm5vVFZLMVdRVkhtWnp4azUrM25McU42bnpRcE1vVElnRU5SY3JBRGQycEQw?=
 =?utf-8?B?REJrQ0F1SmVLZ2ZzdVYzMm1pM0ZLZmw0RnAycmYzTVVVTWVISWtuOTRvNjk1?=
 =?utf-8?B?eDJOUGl5aFpPOXo2L2d4eUdwVDlLdHVPSnpseHhEeE85WkhaVEJpK1Flb2NG?=
 =?utf-8?B?YUJZQVgrY3NhTlFaTWlKa2sxL2JuNkdFd29KZEhuTXdXU0FhaVlIbkNQdzZK?=
 =?utf-8?B?Nkl1ZDgrcmJNTzcwR2pHZTBzU3BhZDcySUtOU1JPNFNPYlRacUExTTFxRmJ4?=
 =?utf-8?B?Nk1aV3pRN2pLd2tYWk9ZSFRub0JCVE8zbnZQYXMxSUErOHJuOWpYR2t1MTJp?=
 =?utf-8?B?amtQazZ6eE8vSGVudXVBMFZ1LzRCcnRLSFFNaW5MUUdGMzZnTTZ3MjlKR0Jr?=
 =?utf-8?B?YnkwREJrUERMVDkyWjlBeERRdm9aNlFkRnBZdmVCbmJrdzhFaldMVU5TTWpC?=
 =?utf-8?B?RlVYSXRKOWxKa2JvcThLdU1HYUhsaU1FcDZJN3p5VjVhK0w3THlUSkY5RE1i?=
 =?utf-8?B?NlRGRWZsUTRBdVo2UFBsNnNrejJGWUUwVWdMdk5tYjFEbjg5MkJpS0Rud2Mx?=
 =?utf-8?B?Tmk4RzB6eFVscmU5Q0hUVGpOWlo2OVV4dGZKRE91c3hCQ09PeTJ0Mk54RDVs?=
 =?utf-8?B?Ri9XSVpkSDhZdzEwc1FIQUVBSTJucFJsYVRyam9DTG5RVVowVkE1Qk03aFJG?=
 =?utf-8?B?dGhjUzJRbGhUK3BvakdqOWRlT01vTWlTbi9Sd01QYUVaWmR0SkxFcmxZZ2t0?=
 =?utf-8?B?U3kxdnp0b3pWellQSkV1VktKTzJrc0tLdWNxdkxCZXpHOTF4UmMwbGJFaXZS?=
 =?utf-8?B?dHF5TDdPWkZlbE54bHZ4ek40WGNBbVNOMEpPRTBIb2RCRnN0eWtRM1BQRFl5?=
 =?utf-8?B?enBNMkx4anZ6YWEvZzdOdzdtL3NGVUhvc1NmN2U5NlltczFPdk5TK1IxL2M2?=
 =?utf-8?B?RnBNWkxONkdldmx2b1BpcmlLZ2grT0YweU02K09Ga1hnaWdhQVIwZFQyWk13?=
 =?utf-8?B?R2lHdlFncUpvMGlNWUV3T01lVEYvb0MwQnY2TTh2TE90WS82R0U0WTFDaG1s?=
 =?utf-8?B?Z3ZDK3grL0tHVStobjlwK0NETy9NaFA4QlkyNzN6VHpEZ0ViRlJoaHFTeTFF?=
 =?utf-8?B?akxFMkxHeHR0WnI5d1haNVpXVVVNaEhCay80WGFhclFLd3dQRzAxQm1UV2lq?=
 =?utf-8?B?OFRnbWJVVDQvVXlEY252Q0NjaUt1V25HY296ZnRQSDFwOFg4aTNCQ3AzRjBY?=
 =?utf-8?B?ZGhNRHVQOXo0VVBGdC8xQm5iWGEyUUkyN244Q0RYdmdPb2FNN1N6WlorbUdr?=
 =?utf-8?B?a0U5QTR6dnJQNXJEZGh5RzRlZmZnSXVuNkI4STRCUG90NVRXTkprM1hNYkRw?=
 =?utf-8?B?VGxSU2VGbmw2Mms3UEh4RG5iUjB2OUU5eHpLWFhlSHlIYjVwdHJ1UVNzVS83?=
 =?utf-8?B?N2puck5uQTNEVTdNcnh1Rit6eHlwR2kzT0l1Ylc3WmxOR3BOM0M2WEdJVUNV?=
 =?utf-8?B?K3EyNzZpZkhFa0NBL0ZrdkFCOXZsUWg2dHF2S3RoU3o2UTg5WXg3N0t3TlNk?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b576abe7-b858-4898-f449-08dce4ba16d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 21:18:27.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZTiChfOn732pl0YNsgofmtOEkDTuNSdFxOGM2u2GtJSzvS7bzfnkpvuhZr4aa7L70crWeBXx9lmggWq9URSHc/AZlJqyNQEzanoIh+LBwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5198
X-OriginatorOrg: intel.com

Hi James,

While you wait for folks to consider these changes, could you please take a look
at [1] from an Arm/MPAM perspective? My understanding is that Arm/MPAM also
requires assigning counters to do monitoring and [1] aims to create
a generic interface to do so. Is [1] something that Arm/MPAM can build on
or are there some changes that can be made before its inclusion to help 
with future MPAM support?

Thank you

Reinette

[1] https://lore.kernel.org/all/cover.1725488488.git.babu.moger@amd.com/



