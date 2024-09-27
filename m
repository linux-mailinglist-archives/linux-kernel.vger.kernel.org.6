Return-Path: <linux-kernel+bounces-341212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70674987CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CCD28522D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BEC1667F1;
	Fri, 27 Sep 2024 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUf1oOhQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B214A4CC;
	Fri, 27 Sep 2024 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401893; cv=fail; b=HiwGTQ1E5c3ZLc0ANzom461khxxityKIJX5bAW1IbY2ggILv2S7XexXc+aIRy/90CVZQRC1EE7c4oLvVyBp6seZGf6w9z6B3NQseFgxY+Mf0mztcXHldAzt5PqdzjxX91f6cpRi/qntjLhySdu/YZCK90O2n9jAdD1O2SCNR91U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401893; c=relaxed/simple;
	bh=AhSUSC0BRUipzcxfEOWxStaWLrgfgAV6k8+qD4dqFvQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGN5Yxp6u8JNv5MGMLI0LAcmN1PFv8Y5uT9pXl8gAWJoCnsbMhyrBWW4vxCS58bL6Zkoh90DVLXFL/miCRJ6lFSsMBeT8QfgutI5J2wX8OS04f01TpYreHXfzGV/5/dYtibpGFiLM/X6+KX4HLMyab4vSHERbnusdpn/B7JfqXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUf1oOhQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727401892; x=1758937892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AhSUSC0BRUipzcxfEOWxStaWLrgfgAV6k8+qD4dqFvQ=;
  b=nUf1oOhQRaXEtDExK3E45IGG17dLjlP7rvl+VzV8qA9ofTBSb7M4HO8i
   YD+2NVCs/ybk65E2pvpJFs6Z8jLBWLaaZgwJApd1M7rOs4dt0Muwp9VAv
   wh7LyvLhN+YOZY5gi/FQjZdDZW33SENXfvt/Gh/Ux2qyJ7PxUg+tSs0m1
   941UYdCn3T/MQBHY7d2ldl1TSrd/p4t/Sa4hY++DsDfoUMlxIyPNrEfNV
   f/yAbmneB6ygsO3/93+aW0YUYE1IfZEgr7A7VHkSJUc5qu5hoJDM0S1Om
   L734PXv3lYs5G6id4ma6dfVmp5BYZwhGs3dlj6PWzyC/BOIJhJ78fFOlx
   g==;
X-CSE-ConnectionGUID: cPXddDvRQUGTWsb7AmGEcA==
X-CSE-MsgGUID: JLYWyQlrRoee2VPbxehnqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37117662"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="37117662"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 18:51:31 -0700
X-CSE-ConnectionGUID: ruJ7gWwJT2ix6YPatU7l3w==
X-CSE-MsgGUID: 7/yNsdlLTEOi0SzHai4ziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72450147"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 18:51:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 18:51:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 18:51:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 18:51:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 18:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLz016auhFNQoF2c7jQsQMu2vhZ4UitcIweYOU1CHOt6jPK2fi/JOMzuuKskNANXm7LnS1F+zuigXrv60VWEQhzv/ku+1OzNY/THDb5cV+xLRxuiUY2zJKvBvWQydZyw9Ho5UHekrBXYU/QSZvuUdG1/MqCOVGIn9zIJdGHmszvZ3UEJtNKMWiFIa+gx2lfbGDofWzIAphX+M4CIUehdXBzEWTAqUX8hlR7wvFgOdnOx5KvXFrCSKO6kcTx34LR8tA/TQdDKCqFJjl2og9J0RNp7LbZWudMqsC8o68MWBlq3/XyP1mlFrP23C+73ZMN19zfR760cImMUUbHgATinpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRaWv/ZabOuL8PDIzyyLOnL9SjlP2sMP8Go8y6/QqvY=;
 b=ndMnJtODXEnymn7Vmhf1ROW7knVqO+p0PjHJ42ZJJSuN4vXPfgj3I+ZgMsU214kxlZqPa+WlrOvhR1h2lr0vmS9OQNuoccPM7e8JlOh3K2b1YskRrXI8Uf/yeVKuA2euVKVO9dZwlq9T4h3k0lvZUmleswmp+IofjVwGlJabAHyUS5k4YnX1+Uv/epy9vWvqeroaj6eCs3BN32ieEwTlp8QlKQHd39vjO1tigC4YWXGzMycXQmVZJtgkSm7onqq1zazBtACFPMvY6GCi96XV9eR9l1R3RVIY+gaWJSbBgMIuOvxcEj2c4Xgbv8wKxtoiT3K7D1WDXu4rjgXI2JzKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 01:51:22 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 01:51:22 +0000
Message-ID: <0812e4ff-d8d9-4356-bf20-7d20170e9813@intel.com>
Date: Thu, 26 Sep 2024 18:51:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/24] x86/resctrl: Introduce the interface to switch
 between monitor modes
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
 <812a04c41c66824a212c2dbd30697fe0cad71523.1725488488.git.babu.moger@amd.com>
 <b84fee44-d52b-45c3-8664-b2215074bea9@intel.com>
 <773d02ba-64d0-4c03-968e-f303ffefc4dd@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <773d02ba-64d0-4c03-968e-f303ffefc4dd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: a76186b8-9eb9-40b6-3223-08dcde96e353
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDloUlFEWlQ4OUErZlljRXNaSXRwSkdEdWRackNiS0pIYklia2U3R3RoOTFt?=
 =?utf-8?B?SDE5UUN0anFoM1hxSWxabFpyNS9RNTdLTzF5NU5CSzN6RS9EVFNsZ3JhNGd5?=
 =?utf-8?B?eGd6QnMxelpSZDhjeG1OL2N1eVMwS2dTNjhnY09YZ2NGVnFSUWRwdTMzNWF1?=
 =?utf-8?B?TjIwelNOMkh0Zjh2TTM5NFFUTWJER25oNW05bkNtMmtOK0Z6SXJBNXFaMGRG?=
 =?utf-8?B?bkJBYk5vNWtjTFJoOGZYRmt5Y01aUTRBMVFhVldXVVNyK3BONGxnKzVuMFZO?=
 =?utf-8?B?UUhyMHdYUnVRNTRlNllqMTZ3b0U3MTQzQk1uaXcySmFrOFR6ckVNbmM5bmlz?=
 =?utf-8?B?NEJSaDNrYnBScnEvaGlwQzlnM0lqVWtWUWxCd2lyeEhNWmw4VDNhVkhUaWxY?=
 =?utf-8?B?OFI1dDZKV3N4VTF2c0VPNVFJT1Y1cUEzcWVsYnRnWEFnL2E5YmE2MXVXNVpH?=
 =?utf-8?B?Tk1oc0RLYm5xSVFYL2RLOHBqbGd0c0hJcE9pb09nRDZhZEc3UW1EWFM0WERj?=
 =?utf-8?B?ZmovZjJ6a29uNUpQcW9SZlE5ODFPOVBDNDZYUXBSTjZPNnJaV3BYZVZaSWx1?=
 =?utf-8?B?MEZDMEV6M1lqSkxHNWZDUkNzSmp4aldsNENYK0g4ek1MNzNJNldLTG1kdVV4?=
 =?utf-8?B?cC9ncVpCRk5rNFhzSUpwRUhHQ01lM2kvT1N1MUlVb21PZUltUVc5TDcvckhp?=
 =?utf-8?B?bXRuSWJHeFlZZVQwY3VubG9kV2RhZUFJK1VFQUhQVU5wWXUvWDN6d01RS210?=
 =?utf-8?B?UU5aZzN3MGNpOXZCY0dUNWdKaEdYcnhudE4zTnhvTU5qcUtnUnBmVXIwU3Q5?=
 =?utf-8?B?L2RvMnI4cW8wV0ZMM0ZSaXBWTVB5VU9qeHprb0tRUXNBcnE1bW1oY1pGZGtV?=
 =?utf-8?B?RmdyaFlENzlVRXpOZkRZS0ZoZ1Y1Zmg2enZ1bHpsK0EyQUV0STlXMU40WEV6?=
 =?utf-8?B?NU1rcnZocUZIdS9KVjdURllFQ3JIVDI0VGo0N1VIM3lCcUpxTE5yL0xkb3Az?=
 =?utf-8?B?UFdXZkh4MUFsekVXcVJVV0FWcnd0aXRSd0U2cUFYNlljV0E2UVFqbFlsNXVx?=
 =?utf-8?B?bzNwN3o3TkRzMUxLRDdvdGVpR3paYkRobmtDcWJGTzBFSEJubncwUWJWTmlP?=
 =?utf-8?B?ZVc3V0luRWU2K2JHK3Y5Q29KUk1Va1VVS043R3pZU2hvUUpkMTRhbU15dEpR?=
 =?utf-8?B?UXdYNXdROEpRWWlXekVwNHJpTFE0TjdQbDFDZnRES0ZWak03Yk5INTlWZWty?=
 =?utf-8?B?NWlmYUZ5QndodTc5Y1AyQ05yNjFmcEVLOXk4OUJqcTMwSzFiM3BRbWdOYVdh?=
 =?utf-8?B?WDJ3T2VsU3duKzRvUUdrczhLenlycUUyWWhoOWhEY21aYjFXTm8yT2x1dzBY?=
 =?utf-8?B?Rm5ldERweG9teDVhL1R3WmxnN0RGQk51SFdwQnJDTmF0K1NSZmpmdDBWQnZ1?=
 =?utf-8?B?VW9uTmJBeW43TEhZeFBsUFhYYjhxTXk4WEtnV1M1ZTJvZWJ1akVkVTR4Q2dB?=
 =?utf-8?B?TDl3TU9DdlZpYWlxZ2IwMWZzaVhYbzlYLzNKVXQ3VWFZa3FuaDdPMk91cEJj?=
 =?utf-8?B?TFpyUHp5MjRDZGpuTUlRK3hocTRFYjZqSE1VNjQvQkZTUmVtUmdGMUpKQU0v?=
 =?utf-8?B?c29QZ1VibFNpNDFkRVkyYWVDdEhjR25vY2xyN1pmcFJObEZkOG5XWEhoV1ov?=
 =?utf-8?B?UGlzVUJXSWNYcjQ0TnJWZ0NNSE5UUXNGeE1HVXAvenJ5Rm5FOWFHYzRuSmJP?=
 =?utf-8?B?SEswajlOYjgwSE03NVM1TFdodGkwV2RwRTlZUUZaK0tnSUJvUWNoZU1jcWVL?=
 =?utf-8?B?OU5LL2xkVGV4QzI1OHNGdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNPNnpsdzhvek96MDFGYjNRWkw3OW81L0M0ZGM2OUJsc2R6MEhETHhhdU85?=
 =?utf-8?B?WTdHeHBIZWF4ZEpBSVJqcHozNGxCb2ZKZkhPcFM3TUh0K2lZcFRJTXpoSkEv?=
 =?utf-8?B?eXFmUW9qSGRjbklkMFA4QjIzYURDU3RXWVBnR0dseUtMT3o5eUY1MGtQZnpI?=
 =?utf-8?B?elU3KzZkZkJBdUJyMGFJeW1tY3RTMnV2cUJIMnRuTFZIUXVWS1I1ZS9rSUpR?=
 =?utf-8?B?N1Rnc2lxQVdES29uNUNncTFwcURSWnFjeUtFNGJqV1VRZVVabk9GOTlXZnpP?=
 =?utf-8?B?U1FBdm5SbE41aVJ4alJPbkk4Yi9VYjZlS0RmNzA1TUFQS2hNYXcrb01KdTJ4?=
 =?utf-8?B?Ykh6ZFBuSXJIZGwxdUYxeHdWcDNyVUV5akxGMFpRNm1KRlZpK3Jkc2dka3pl?=
 =?utf-8?B?MjJqaTdwaUt0SVBHbktWQVZjbVkzd2lzY2VxSHdyc1pxQmYxQUVNbDZOemZk?=
 =?utf-8?B?QVFQNnBkYldFMWp0KzROd2ZXRVZqR1NuUlpsMFhaTllWcnlxdWNHY0NhdlRQ?=
 =?utf-8?B?SjVUUDdpZzhXN3pYK0E3K3lDb2tMSDNNTGF1aVpJZ1FpbkZqSElFSEhvTk9E?=
 =?utf-8?B?SnhzbUgrMEQ4YktDZURhVVZINW1DVE10MFJERWhUVUhHKzBHakZaWC9UODlQ?=
 =?utf-8?B?TCtsR09sM09DalpiMHdSMCtRY2tBQ1lwdUQ1MzExbE5jRjRPZlZsNm9CZ2U0?=
 =?utf-8?B?REJKMDRuZ3RqWXdrNHN6V0EwdG16dG54a051K0RQTXN5UmhXdWx5NE9GODVX?=
 =?utf-8?B?Uzd1N1BTaGZ5c0tzOFFSdUszSmRNMVpBZkFNSDNzbFNhY1FLOFM1dG95Wi9X?=
 =?utf-8?B?U1NjaVdaWVR4L0lwZ2d3cSsvalFWQzFWdzZGL1N6RE91S3VJc1p3eW8ydUdi?=
 =?utf-8?B?OExuYjI1WTVjb1VQSDFEbVFWR29LUXpRbks1ZGd0ak5jcE5keHlzRkYyRUJF?=
 =?utf-8?B?OTZaSTltLzNPMTJIaEwrQkdZU2s3UFUzVGdDSzJiWVJLQXQ4bUo1R25rL1dU?=
 =?utf-8?B?dnZEbGw4KzJVdzBWdGFDYTdqZWpsNzVRdWovbjRkNXNrdlc0Q2Z5VUozQXM3?=
 =?utf-8?B?RXp2Z2lHd1ZqUWhOVEM0Tm1NOVhmanlNbnVpemZLbGlPUDRrT004UDJhd0JH?=
 =?utf-8?B?V0hQdkNmcmtiMmRHMTNpQjdsMXpaMmxpQm4wTU9NZXRGVEhheG0zYlFoL0Fh?=
 =?utf-8?B?dE8rNm9UZlpLazE1QTVMM2hqbjQvQkdVSVJ5Y1dtcmk5VHMzTVpWWi9oYm5v?=
 =?utf-8?B?UnEzTW04ZVRKckRIeWxHQUJ6b3BRUVpkZHhFUU5qZklMY1VMNktJMzJGL2Zh?=
 =?utf-8?B?WkZXRVN1L1NROXhwZmxsQURWbmxiMjhiRC9qY0E3SUJYZnAyMVVtdFBHbksx?=
 =?utf-8?B?cjlkSGJ2dVFiRUxsV3EwVHYwem92MHNsalJObTdUNFlKajJDWTZORjVLbnFO?=
 =?utf-8?B?VUlHbS9IUzBiYlIxRlJMZER4R1U4UjZ0N2VrWE5EMEwwV3pBUDFnUmRndi9r?=
 =?utf-8?B?T25tOFllbUI0bHd6SXBNdzUyTmtvWmdZNDQzTll2Zk1SclluWVE2U3lpM3R6?=
 =?utf-8?B?ZEs5WEVmMGVDT0prNjRKeE16TmVVNUFnNEJoeTl6bHNNY050aTNUd21LUkwy?=
 =?utf-8?B?MTJEU2NiZUhRbDBLWDFqbTNIdHV1WEl6YzRseGt3aHNkMmJjQ3JNV1dVY0c4?=
 =?utf-8?B?T2FYRGJRV0pVWTl3M1B0VDFZZ2NZMk5XTzFXbTVFMTBlVStrZHdiU1pidFVO?=
 =?utf-8?B?c0s1MjZCMTVIYnU0Tzc5STVqQmh5NXZjdndxSXdRTjB1MDJGbzZoY2hiNWlI?=
 =?utf-8?B?UWhYYldDbVdZaS9pMWZYZE9lTW1ZMUZXeHhySlBMNkc5bDRyRE5DRElOY3dt?=
 =?utf-8?B?bEFtcGJFVXE2MWUvdEY0dVIyem50alUvanZUNG5KcDJiMFdVMmg4Qlo3Znd5?=
 =?utf-8?B?T1ZtSVR0T0swUkNhcHc0Qkg0Z2ZzMHR1eFloNk5uUFRsYlM5VDZwbjJDZGlG?=
 =?utf-8?B?dmNuelczMzAyU0hBYkxxL2xaREZXRnBmdCtIZldpcmlLSThOL2Q1Qm9rdDg4?=
 =?utf-8?B?TFozbWdJVEFXN2ZmZ2xDaTJDdVpmd3pBck5sZEVaS2o0alU3WEZnUkZxSkxI?=
 =?utf-8?B?Sms5ODRJWEVtVDdzYnM0L1VGNXZEODZrMDJ4b2JRUWdIZkg2aUx4ZjRXeitv?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a76186b8-9eb9-40b6-3223-08dcde96e353
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 01:51:22.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoyA54QzFi93hs393NsQT2IYGqZ3VUUQPmjI7296aOlvkvgUsqsr19soQe+cZOyqamt4U8OCwlPEOsQPNyMLMMiDJfQ2nh3RO3ugAeU2jv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-OriginatorOrg: intel.com

Hi Babu,

On 9/26/24 12:39 PM, Moger, Babu wrote:
> On 9/19/24 12:38, Reinette Chatre wrote:
>> On 9/4/24 3:21 PM, Babu Moger wrote:

>>> +	  ::
>>> +
>>> +	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>> +
>>> +	The MBM event counters will reset when mbm_assign_mode is changed. Moving to
>>
>> "will reset" -> "may reset"? Please also be clear on what is meant with "MBM event counter".
> 
> It "will reset".
> 

I understand that this is true for the ABMC implementation. My goal with making this vague is
to not have this reset set in stone if some other implementation behaves differently. 

>> Note that "counter" has a very specific meaning in this work and after considering that
>> it is not clear if "MBM event counter will reset" means that the counters are no longer
>> assigned or if it means that the counts associated with events will be reset.
> 
> How about
> 
> "The MBM event counters(mbm_total_bytes and mbm_local_bytes) associated
> with the event will reset when mbm_assign_mode is changed."

In the docs "mbm_total_bytes" and "mbm_local_bytes" are termed "events" ... maybe
"The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated 
counters may reset when mbm_assign_mode is changed."?

Reinette

