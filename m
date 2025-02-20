Return-Path: <linux-kernel+bounces-522959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C359A3D090
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F770176B69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50421D8A14;
	Thu, 20 Feb 2025 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dl6SuHd/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E03FD1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026927; cv=fail; b=j2M5BN4pdZ1Z8wkZ7IDFd4+r3vqpbFvdQBftDaptZhV6B76S/ZRIZmWOHHaZFm5KQI7ySlL5o1v6Ifq9v5sCowRAOjvrOyxdKfCaCIcorbFE2NWWGkulAmBa7dB0RA96csKjxyYRbIu0i+iyzpVU+CXeWBsRwh/Ts8nL4lSdaUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026927; c=relaxed/simple;
	bh=LElyZmmoHUH36I/EgNoHZPvtbZVXTksxVHH6O7Cr7VE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ll+TGQM6rsVl2dnzmK8GuUOz121Yq7FYvMj53YsYB46azOPnikuyTOfLGD62UCcYQQORTyRaL30dCcF6wXlAnXzZwDQp3H25PkQoSYjgD/9dl8P9w71SC3Kf9Th8ZTl0IYOl63s+26hu7P+haxgGmbzOwiXbgqF6VTz5g01SoSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dl6SuHd/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740026926; x=1771562926;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LElyZmmoHUH36I/EgNoHZPvtbZVXTksxVHH6O7Cr7VE=;
  b=Dl6SuHd/D20YieW+EdHOZ34/VxJb/g3tXstx58c4A6EtDgQ6RD+s4+Xf
   7ffGekMA9Ii/X5yVYsT3Tj/55qI90AJqUC5oYAtNQQSYEIi5s03QjgfQT
   Stg149zzXNJGEMz+kzrexKUoMfaL87SYF9Y5Hu92ep11Mk5bFcE3BEcSo
   b5p9LhXXZsYinql1WOAync9UiKL9aZL33RGQGWFELzoDVhMA02PP9XBnB
   l6cVZZiAzdgK46CpGKnbaFppFL82k6/6UH2PsTCk7ifKOoY3b9daxQ/fx
   R5EgDnL4dbVfGrH7lJAXCmqfSTscDNFGQ1gbI5S2+M2dpiAp6Er3SSfEs
   A==;
X-CSE-ConnectionGUID: GyY4dZKNQaSUZvJstYnScQ==
X-CSE-MsgGUID: Hy0abxGfSgGhFJyxO+O84w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51003850"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51003850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:48:45 -0800
X-CSE-ConnectionGUID: /cpAurr9RaSqp6974YwUIA==
X-CSE-MsgGUID: U/An8gYBRvmpaOVoKssckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152125790"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:48:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 20:48:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 20:48:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:48:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXjlWdbz65D/Th3l+BA+xMqFu05GLM0zm+5L1UOvosZmWftKPMyoeDeKfooao/5UfIkJeGhQQpZ51KVhjj0uPgvW0CmwV+1mFbsNrlrxaKqPKGmZWdGojbGKQoE6kBX3c1SZRmdY8RuIRWBsrWPZAjBjtZlgNvi/sJxsxP6/77VWkYnsWfMykhBusDSRzTF3dyR7OxBgVnQ/I3SpstGijCbCwEnRyQuXdZnf4c91t9tFFFylt4Ft141THsZliCwJOIDnePpEYsjUhBzUVxJq7QPH0ppr8otc7NI2FmJm29nl2fxXCgqVKi3eq6eVRl8DhRi3qGxCLrOJTPoKqJCiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBxcVkyyM4CuCgrK+xSvTK2C2VaPT26zuor7gVsxUdE=;
 b=L9TlocH0FkoK5Q8yC66BIRiupkNo7XbACArCvmkKMoevvixGFuiIOLByaVAkUzrHHomeq6T9I6ibZJW/zLQk61VDUnbyOVKWawNVvVdYUnz6UrQrx7dWRWJiWsS1DiCD/yuqdClfikesLDRykB6RgNiiiYf5tlWGYg1BRwFP6FUCVumUJHTenH1titzdTFxCps7734rb4UfJp10LENwJuTxOVZZXddqk1OJX1moCBv3rV9u6V2CIDvN1+ThAl9+nC1EGidBKpxWbCu03jkcAUixGWfgnHrJPO0cf+hMap/3CPAhrB/1KlcOZ/uzVgg+np9+rpwnThuoOUaVzq63Hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 04:48:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:48:26 +0000
Message-ID: <2e5b2101-dd13-425b-ba60-c31b4100490e@intel.com>
Date: Wed, 19 Feb 2025 20:48:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 35/42] x86/resctrl: Move is_mba_sc() out of core.c
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-36-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-36-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:303:8d::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: c65307cb-0d79-4903-dacf-08dd5169d03a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlpZRGR5VTRsRzNuSVQ2VGltWDF6amprTmhhYU9vS3RCMyt4THNIeTVaeENi?=
 =?utf-8?B?cjNkOXh0eVY3MkY4MTJlMmhoZUs1MDQxTXB1Sy9OVFRSdXUzTHVlZkc0Q3ZD?=
 =?utf-8?B?eDMzMmZiNWRTeDZ1OFlIaUlqeDNScnpjaDJIWkpjMmprRjRzWjhaWUFnYnAx?=
 =?utf-8?B?NUNGMHBjZk03NnVGWUdOdlh0YVFNcFBEWVJyTHQ5eTdnZEZFaVJsWEJNMm1S?=
 =?utf-8?B?TjhpOVNGN3E3eFE5SmNUL2xhd1N1dng4eFFzdTltVjlJVG43cDNqam95SVFa?=
 =?utf-8?B?eXhDMXh6dk4xdGV4RThFYmxqMUFjYW5UcFkvKzRvSU1hWnlycnFBRFdUemRW?=
 =?utf-8?B?eXNURG02SThYL2ljYzRmcVl5ajR5VlBQOWhJTlllSFBOOUVUYWtQYTN0UXVq?=
 =?utf-8?B?OSs4cjdSb1JielZhUHNLb3A2eDFuRHB1TmFRd3VQZWI4WW9GZGpEY2Frb016?=
 =?utf-8?B?d29xQ1pDc241ZW1OeUdrR05YVjV4amdVMzJaazJpcWJ3TUExcUpZbWx4UXFO?=
 =?utf-8?B?cXkySWNTNnl0VWZHYk1meC9HZ3RDdzJONUhoTDFoUUJ2dGFkdVpOQ1BLNHhI?=
 =?utf-8?B?YlRJRnV4Z0tFL0I5aGN6MmFhTTEwbEQ1MjBVajN3RGdOVWF3ZTc2VC9NTXBJ?=
 =?utf-8?B?VUFRUGM3eDErbE85Y21hYzA2Vm44Sy9OdkxuZFhhUFR2dmFtQmlvQjgwNWly?=
 =?utf-8?B?THVzcURlbVBFNjRrUUgraW5INEt0aDNvUFRjOFFIUWYwMGVDRjdHUkJlLzY5?=
 =?utf-8?B?Wk00dk1kSlBUOVd5eUtNcVRLMURjMks5UUYreENicTVFSy9RdVRmcG11dmxJ?=
 =?utf-8?B?d1RLNHA5bHVtbDZhc3JCTDFYZXFWWWJScjMzaXNoZUlMQUJtMlEzbVprcmw1?=
 =?utf-8?B?ckFjejROdEcrbEc0eTJaM0s2ekNsNm44T1I2UXpuS3JNT1djUmVZNDgzdnpo?=
 =?utf-8?B?ZUJKM3VyKytDbnkvN1RLeExzTXdkNHpqV0k0aXMzVU9lQWI3bm1ZcktpVGtK?=
 =?utf-8?B?VmNxbUw3SnZ2VlNYMjRJS0NCWURjVDdLSkNZemtQdVhINjhYbnZ5cUZTQlhC?=
 =?utf-8?B?ME9IZHE5MWtBajdDSVhISUxRUjNUVjdNOHcrMmg0UnBkUUorOFdpZGdqNXZh?=
 =?utf-8?B?bUIwZnlVV0tjSGxKdDhqVWQ4SE40TjA4YXJyWGhWeXRmWVY3blZYektYNDFR?=
 =?utf-8?B?RjI0OE5aUThmSlB4Yk81bjhxcmdUWUlENTJnbXlWdkxnblo0MjlSUi9YTkwx?=
 =?utf-8?B?Z0thSzlZdUhFYlpFQnpUVSs5OUVuMWNHYVo3WE1NT1BlMktCenBDUG9FNVVJ?=
 =?utf-8?B?VDZkakNZVGJ5SXh6RHQwVnJoeTRoc0RtZndxWHNzUzQzR3dPWEhKc04zWnpl?=
 =?utf-8?B?VkJqL2NMSFg0eXZxNUtQQW5HQTBlZkxyQ1FUdDcweDRTZUV3SG9zTEV0dzVz?=
 =?utf-8?B?WHF3SWorNjAxaks0Nk9jWkRuQ0R6WkJQMXkzRzk4YU8zeXl4ekQ5Q05YQjNS?=
 =?utf-8?B?eDVmSVdBMmtnSW1vZXBSMEFySU5TMFNicTZCci9FWjZ1ZndPdlFUTm5aNUMv?=
 =?utf-8?B?WTM1bU5YbTBBdFZCQUg2OUFYMzhCVXhRRUYzcUZiYytTYjNnV3BWc2RmaHNE?=
 =?utf-8?B?NU1PeHhJenIxV1czNzBpNzdDemZpNHN6b0hYNmR4eVVUNEZIZnJDanhXNXNF?=
 =?utf-8?B?Zm5WczhqclVOQVdqeWtCSThTTERHTG1VRXpYWTlQb2paSGZrdmpPWkxHSVJT?=
 =?utf-8?B?UUh2NlN3bzlJaWs4S2lwdGNnQURMSG8yc3JROTNRTWs5eU5HYVByVTBiTENv?=
 =?utf-8?B?cXNlNFp0QyswYkdjUHREVEw5ZFg2VGRFNFJjRlRZa0RrTDV5SlZXaFZYRjJ6?=
 =?utf-8?Q?1Svm3r6+Sjc9n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RYUEljTVRtdW5mRnhBSndCWFBZRDlaQzBFc0Z6Ylh5ZGdMamlwRkxZVW84?=
 =?utf-8?B?Yzh6NmNMRmx5UGJMUnZEcElsTWJvMktLME5vbUpjbHFvQk1OUzFNM00rSzVp?=
 =?utf-8?B?NEhzN0FVQU0wLzVBR0RDL0RDQ1BCQkVmUmZqUkNPZmJmdnU2MXVOa3h0YUJl?=
 =?utf-8?B?Vk1rc2ZZUHBOcHA2bnBjeHBJai9nWDdEQXJ0RUU5TkN3QlF0VktZbWRxNHhh?=
 =?utf-8?B?ck1PWXk2SXFnK3ZQMVd4Z0s1ZkFHbDRGb1ptbURoamJIbGorSmJNeEowTmhS?=
 =?utf-8?B?Zll1NFlFTGJqRTcwUmdweE1FL3FmcW5hMzk3QkRNZTJ3K2NNbTc3dUJrTGNp?=
 =?utf-8?B?aXJwMUZ6U0xtUmUwSUM4aUhlVGJuN2tYczZYaWVBL0xnWkNMSk00c3NKY3pV?=
 =?utf-8?B?UkxBcXJYb2ZncStPTGh1UXR4RG91Q1kvSXRzYmpBNE5oeC9taUhaK0QvcTQw?=
 =?utf-8?B?NWRxczlUQ0pySm95Uk4zbU16eFl4L2xZVmhwWE1zRVZBYXJBME5KcVlWdzdG?=
 =?utf-8?B?WTkzMGNjYUtDUCtrTFJKbGxMdkt6TS9VTlhGU1VtTWlXWWFGTjNGUEtMb2k5?=
 =?utf-8?B?YjI0TTdDMkVLQktXNDE0OEo1Tys3YUpUQ0lhbEcxdUtvNzZoeXJ3d3Fac0FI?=
 =?utf-8?B?SWI3QnBYWHBTV0ppdm9rSEFqQ25hTmVKd1Z4MTlxS2RjQUd3eXJycjJWWkM4?=
 =?utf-8?B?YUt4RkVQdWsxZkF5Si8xNG5BU3hJbDc0clRBYUZ1aTJyRms5R3lWOG9OL25B?=
 =?utf-8?B?d09FSlhleEFQdHBqNWE0RU1MT012UWxobmc1cm1qMFNwUTIzaFhOK1YrR2Zr?=
 =?utf-8?B?dUNJdHcyOWFuTHF6cTVHejIrSkVSNjZNTjhIcU9Vb1pLNlZ6enZ5ZWdSNXdH?=
 =?utf-8?B?ZEx1M1JiT0p3dE10enhJcUJRMkh2RVFiYko2YWdyYVRzb0k4c3hlbEhLeElT?=
 =?utf-8?B?WmZKbGpFekRqSG9qM2ttRitEM2pLWklnVEVmaGFiajRTVEtTYnVGRVVwZ2tD?=
 =?utf-8?B?K0YzeW1yZ3Q1M1dvVCtmZDBzQjNRN2hEWTVNaXNDRnUvcWhxRVpjWEZ4NGow?=
 =?utf-8?B?RWR6QWZWaGpKTVlSMnROcEtLNmNhSGFwWlBMblBJbE5DamkrY0I0WDc2NDVN?=
 =?utf-8?B?WDJ4d3ZpTGI2aTd1MzFVVW1LcGc5Z1Q0WTRJYWhPUnJSRDRwMEV2b3RWeUhJ?=
 =?utf-8?B?NnFSTE5Oc3hNRjZKbHQ0NERiWE00M3l1UzVzd1E4MEIyYllDYlhxczB1UWpi?=
 =?utf-8?B?OVJ6dHRuMXdBTHJiUGdQTXp5UWxKYUtCK0oxdFMrVWRoRCtlbHRPTDVRNGU4?=
 =?utf-8?B?OXppVDVPKzduamVMc05salNENnFQRFZwZS8wVSthbGQwemxmOUtkcnVuSXl1?=
 =?utf-8?B?NHpnMHlmMy9pMGpXTTBYY3p2WFQ0c0g4SllKN3BVNThSTHdsN25xTmo3YjBL?=
 =?utf-8?B?RDA3c0MvenFYRWZiTXdsUzg2NkJNelp4RHB2MmZJM2lKMXgwWE9IcWlDVVhY?=
 =?utf-8?B?NElBYVRWenZ5eDNrblNNNTc1TW82eTZ1ZFc1ODA0bzd0bWRQOVNoV2JzblRC?=
 =?utf-8?B?cHhYQlhNWGdDcjZVdXNQaWJnS2lMUzNuWlFzdjZ0a3BITFpIQytRVlBoZXBN?=
 =?utf-8?B?dGNlcEJxZGRBTis4dDg0VzJiMHY4bFBlTUxPMmJVdDJGSDV0c2VTeTN2cldL?=
 =?utf-8?B?bEdvYUdoSStwTmZNVm5sRDNwT3VnMFNBMis4b3NJRDdUdERPSnN3eHRUTy95?=
 =?utf-8?B?R3dHNWZyZzlwK21FOVVLZUJJOHlWa0NhYnpHb3dmZlZWUDJHVUdOempEenQ5?=
 =?utf-8?B?c2NTZ1FBVkFYZDNKWFFPcXV0Ny9jdnYwaU5JdVBrZHdZSUdYclA5UHFkNEVG?=
 =?utf-8?B?Ty9HVkJpeWFCWUVCN1hCTGdxQ29JdHBHbGJ6L0VRaTN4dGNmTm5XOXFKNFRq?=
 =?utf-8?B?SmdjZHZIVkNRMW9UYk5tY3FmR0pqZERoam1xRFI2S1pkVWRpZk0xY2wveFBn?=
 =?utf-8?B?bzRjYUJKSjgrdlRhYnB2YXZXRlcvdFZUS3pBSjRCbWp6Y1BORWdCKzkxV3JY?=
 =?utf-8?B?b2NBYnB6bENSTGV6eWxWaENoWWhWV2QyQUZGNEZTN0lrbXQyaXEwTm50aHR3?=
 =?utf-8?B?TWM5SVkwaTlydlVSQ1lrNm9haE91TG9lTnQxemhhdXFWYVcvTFVRbHpKaXFy?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c65307cb-0d79-4903-dacf-08dd5169d03a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:48:26.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJdgu54JTNwWCqQrTNefezgWDZKjlk1VvyWs/7o/6qwJ2sqS5dm6VbehAbBk7fF/On8uZHp/PYyONH5zm3eyoHXTQ9IXmcpJfXtERQ4xisI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> is_mba_sc() is defined in core.c, but has no callers there. It does
> not access any architecture private structures.
> 
> Move this to rdtgroup.c where the majority of callers are. This makes
> the move of the filesystem code to /fs/ cleaner.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


