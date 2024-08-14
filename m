Return-Path: <linux-kernel+bounces-285845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33895135D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5311A1C20915
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7163CF5E;
	Wed, 14 Aug 2024 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZcNX1cN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEC37144
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608304; cv=fail; b=AoKpIvytlbzYoI21JyzOVqbkDe4mAyHTmzgU8X6pHCJls9VykShks9c766FeH8qQ5fs6ZB7Hldt4EGn4UtxrXfa+y5jT93+Lc1Ue/676/V7eKsJbr76FSxTr3KajgU44VTOtqPyxp1gVats9KKpIJ+n1PS4ysH63J+96kqAALTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608304; c=relaxed/simple;
	bh=43+0YQ+XdzZlE1oIigTtMShKPERvbtyuer7ouXx7r0s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdEM59IRlyFVi5FOBwpTxzv0mjn5p4pmpcHyrUFPhDeh3XuMOXu+G60SjUY03Ncyl6hpRaPcF8GLOi6arD6GnPwkBRgoWoU6rQdBCMMkUyV1NDnFphx2sfYMQ1HVuvmbBUkheyIgL24f5JhYu3sVmv5EYI6WzXDKALJ4Lytvocg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZcNX1cN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608303; x=1755144303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=43+0YQ+XdzZlE1oIigTtMShKPERvbtyuer7ouXx7r0s=;
  b=IZcNX1cN9Dfyp9OeAbz4NHhnHeUkPeG4Nm6QnjUtG1QPq4IlWdzmQ1N6
   Y5EF9Dr0CARJjcdmCvIpD+bahksW/03WSddDALogFsu/Xs2xr5Z2x9jfj
   JqvjQZxLyqxMpRq9mU7fofs6aW+nv4yDX4hRqmSXBf0uNNRTEYWXeGuKV
   PUDng3NTTIhcEBs4paMTlSP2fy5AMqzU28prFbhIxuLzgGm+cASrCl47i
   tORjJw8Ji2mkbNDmGTIFJr0GWk5J+xJg4n62l/gIVfBHeIzHaz3f3uwcE
   rfWpk4kpmfAH9SIQa78GWLg5uHSvYGbsRSR+wHbKVP9VF55YC7an+JUk0
   A==;
X-CSE-ConnectionGUID: UUj/Mc+ySgmZzriDfZIuzA==
X-CSE-MsgGUID: nXeOGUbYRhOuz3tc8PGQHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="24713296"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="24713296"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:05:02 -0700
X-CSE-ConnectionGUID: fKP9pHjtSpGesyhQHJ7ldA==
X-CSE-MsgGUID: R681yAOQQDGocJbQKT3tAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58835904"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:05:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:05:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:05:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:05:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQQF7oSjFYIpJxZiy9DSq3dAvJrQdGXuxlPEIEx56TyZcopc0dRt11W1CL7VqMckSzuXPsw+mjLvdrqGr5rUlUAGmpEX9/6iJISFjEvtEGvP5++iqfDWzbMR5W3/Ky/j+DpF7pFCua4Z7fo8no1ikRpDT3lj9d0choKEUJRBPb7I0pgLPKuMu5H9EGDZSxip1B17tQaA1MumgFNsZqoINWJO3vDiL0b6BkHZKyb7r0LwhBZAUGMFpnYHLtA+G4LKpLFAD9vlFmfnSxTzxw4+oF/5kX3f9553w0KOuPecdHxjS2v+ogdjD2Rm154n8EMVBKDiCnYUpBsd6LPhLpXYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0PbPJwCjpTDIGDA2v2X4soYXD3Y3m3e2xw0CrP3ejI=;
 b=gzRBShujx4TuwpWLqrvmF79ll7ReX80tCuCBr6+ANbW/TU5cfDGvQBrv9vdlxN8NdjUnlYhTYiFydHTOFLQqT/kVFGi1NIAx/TP/Fbe6EP83q/J5caTtL7NuKING2SfQaBZGCaLKM7ZshH+HIJL9D/4R6InAAlpxk11UKf/yiaIXRvlIFLVeHYMmKqP1U/m0+repfKGmQVgGICz1B7ghnq67IUj3DDLFAI7areAgpOnqG7rgWxVDi3fpsxBJ7/6MXjbXB4R0mN++QJzxwd6jbe6IooTLkjmkZnvB+Z+KpFjAi4TBG5ch7N9t3i7fwWd9vzTAoUaqAorAVhKBc9s5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:04:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:04:54 +0000
Message-ID: <43c2a525-b8a8-4ea3-80cc-b29dec6e1bfc@intel.com>
Date: Tue, 13 Aug 2024 21:04:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 37/39] fs/resctrl: Add boiler plate for external
 resctrl code
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
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-38-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-38-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:303:b6::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 13db940c-55da-493b-a251-08dcbc16410c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTAzU0dsbW11aG5hY2hsNmlQTGR1MG5aTWtnOWo2dSt2bVBGY2tQOG9Xb0RG?=
 =?utf-8?B?aWl1Q0l6cENZRS8zbE01NFZyQ0ZkK08wbHRzS2NYL0Y1ZTRteFUvZnRPdGdJ?=
 =?utf-8?B?QnUrZFFUejNUUDU0YTFEYTNETkM1R0o5WVVGS1BjYzFEbmhQUHJxRXBUZURa?=
 =?utf-8?B?UHhvdDhSNUVYNkRmajdQSUZ5dnJhQkdnL014ZlVQMzNRMFc2S2ZwbmJ1MkEz?=
 =?utf-8?B?eUhCQ2NHNGxIeGJ1V2hBcXR3emdUbHhQRXJpbUlRUjdLRmZjLythcTJJNmIx?=
 =?utf-8?B?OUhsVTBSbFdjMVppNjNRRW4wTzJLNlpZeDVHWWVlMWRUYitTcXJ3WTFnbE03?=
 =?utf-8?B?Wm5LT080eXlRS3lqRnVkalc1d2RzM3ZyWWJXWFpKN2FNdjhYcUIya09mY0xm?=
 =?utf-8?B?Nm9HL3A0U1JDQlNDbU8ra0xvT25KN2RCSVNyUlhiVlpyakRuejZ1cjgrb0lR?=
 =?utf-8?B?bjBDWWRpa0E0Uk5DWmZZSFlLNkI5eHlOWWdKM0U1SE9LQTd1blpJSGZaWjAz?=
 =?utf-8?B?bXl5eHBSbjdtb0JLeG9uSENDdVYraTVLOEdHTGE1aTgzWWhlKzd6QnBnNnZh?=
 =?utf-8?B?Q3VhdDQwUlRMVGhxOWVUUFUzMUZzazdMR2dwZlQwaGVuQ1B6eUFwZjZ6Nngv?=
 =?utf-8?B?VVMrVDlyc0IzOHA1K1NkUDFBUUdtcE1LUDE1VzUrK1ExY2VtWTNvR0tEYkpF?=
 =?utf-8?B?UWZxZXk3b2o3L1p5ek5vNlBxa205NGZ0ZnJzR2x2K3pCb01OVW5VNUJ0Z2wr?=
 =?utf-8?B?TTdTb3BjbTlRSnVYZTB0RDU2YlRYR1pwSlhPTDR0MDBuSTNFVEl3Vm43RkhY?=
 =?utf-8?B?TGwyVStSb0NKbmoxTWJjTWhHaVRvQ29sSnFCdUNSM3VHMkp0SkxqY21sQS8r?=
 =?utf-8?B?ZjZ4Y05WZFFFTXA1K1dQVi9TSmRMd1lTempOZUpiNU5GaVM2RTM4RHg0bUoy?=
 =?utf-8?B?Z2dpV1Q3R0FoaGNEWjZta1JaWkxDV1hic0RkU1BCS0hYNUx0dVVnVE5odW16?=
 =?utf-8?B?Y0tkZWpZem5YOTJNNEpkRmRSdlM1eVJSYlV1QjhvWWpNVlEvNW1aN0FQMXJY?=
 =?utf-8?B?VFJWand5ZGQzdXhWQVl0VWZydTFCK0pKc2dQWVlWbzRXV3lpNFJOTXdIbjdC?=
 =?utf-8?B?QTd4akNlUFRia0lEMm41WDVES2FmSTF5R0d3WGtLeWdCWE1ZT2VONGlMNzY1?=
 =?utf-8?B?VHQzWTlXOG5SUVZBZktLaXFMUWQwZndPN0hFN3dTWk1ZMUZnR2d2LzhpY1RU?=
 =?utf-8?B?S0FlNE85aFdlL2JZbmF4d2pKVmxBQVl2RSs2bENwckZwbGx3MW5FSVVJRGY0?=
 =?utf-8?B?QkpwSGZjK2xneEZvVkJUSkN4M1JYQkh0MHR4V3ZKVzZtL1d1VkcvK09WRy9h?=
 =?utf-8?B?dURBVWxYZkNuckVsdnBQYklYQVJ3OTJwUjlLQzY2TGlyZ1E2NE5NbExiVndh?=
 =?utf-8?B?M0lXcklnTm9WNHo2K01nUUtPQTQ4b2N2eWNHT3Q2Vm5vM1BlZnRnWHBrTTh5?=
 =?utf-8?B?SjFHeWZKZ2hKZEdIUm8xZ0pKUERVdG5rallzdVJ5dlhrSlEwTzA3enN1WkJY?=
 =?utf-8?B?YUFNWDRkRTVrVjFpVW9JUUdnWTN2YlJXdUlxM1g1Z2JqcTJnc2tPR0R2UjJD?=
 =?utf-8?B?cHc2aStjVmdENXpIcms5ODk4WWlRUWNBK0x5Ulh1RGFuM1FSdDM2bFpGNXpy?=
 =?utf-8?B?aUhvSXNwQ1dEV1RNYzlreFFhb255L29lR2hWTCtJNWJKS2U4Y252WUNQbjR4?=
 =?utf-8?B?RTNISUJvdnZNQjhTbDFxVWNCYnEyR1pVSm5TcVFXcHhEMDQ5bDVwaVFDdjdQ?=
 =?utf-8?B?cXEzSEZ5TEtSdEgvZjFCdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dllpc2VWMHRqSGJBNXEvajVwZkJHN0R5dEJyV2NJd2dKa21oaGp6bTJWRUF6?=
 =?utf-8?B?VzIrbmZxWG83RXNMQ2V0UUdlRjJBbGRrYkpMM1FwRUMzSmlaUE5YT2o0di9p?=
 =?utf-8?B?RDNOckxlNTR4NnJOOGhTRldleVVyQ1RDczlPYk5jekdldk5iaVFLNTJzaW1F?=
 =?utf-8?B?NEFTYVc1QXNqN2RweDRxbmNUNk4yRDRSODVRZG1iOXR5b0hLRzkzMTk4bWxm?=
 =?utf-8?B?SnBFQlkweWl3VG42UWphRHdrc0ZiN2Zsak5Fc24xU0dkazhSZXJtMXRzcUJX?=
 =?utf-8?B?UmtWMFNwWkhsZG96N0hubytuQ0JPRFRVK29RUU8yRmcwczJlMzZNbCs0NVph?=
 =?utf-8?B?K2U5WU9kRWNtMStzcnpCOU5ERVlBNzU5QWF4T2xTT3J1RXVOMnJjdzZaVHJu?=
 =?utf-8?B?am5rZlVITnBmMGhFTU1mZTZqWmZWU2J0WFo2UC8vZHJ1UUZNSFB6bDIvVXNn?=
 =?utf-8?B?NUZIOU9IT2xkNStJV01HQkNBeVJlOTRjVGR4dFNDYlEyeFFQVlhCWVMzUDd5?=
 =?utf-8?B?T055eXBLYmc4UEJEYkVKOXFNZlVXOGRyTk1EQ3pROUdDMm5obXdEdmxwQzVW?=
 =?utf-8?B?V28rc0k4SDRwcW1pMENVc1drckxGbTR4WVJmVUF3cm9taTZuVVlBZXNjVUFO?=
 =?utf-8?B?VURCVitKMDFFOW1LUzJJcWIwdytoaFJxdkpsVER3UVBxUlVqOXdMWXMxQjE2?=
 =?utf-8?B?QlhadzRRbnM0UERHelF5b3pWNE5EVEdIdVpEZlk4b0NPSWdhbjlUUXlGOHN4?=
 =?utf-8?B?SE9IOWRSODFCb285QkJVWHBDQ0N2VUdPWmtMWFdkSldGQlErSVZxeENGWHda?=
 =?utf-8?B?dG50NmQyREJ6VXBtUXkxcTAyUnpSdVVvSFNqRWR6MnRBcE9ZbXVxaG8xemJQ?=
 =?utf-8?B?bkp6SnhFVEwveTNQU1pYcmoybG95MVBoNEdZSkJyY2dyOHZ4UUt3UlR6dmRp?=
 =?utf-8?B?YW1HNlRzZ2d1N3dqZTlWd2hRcHVjdnd2ZlREeWU1Y00xcW9JRGtYSFJwcjhi?=
 =?utf-8?B?bmFKU0dnRDFCQnpIb2lYdGJpMjh6YkZRQVhTSzR0ZTlBSDRmMnJ6L2daNS94?=
 =?utf-8?B?blcxYXVGSk9yWmdFK0ROdCtWZmpWanp2WVcrTHc4Y292SzdUdVQwOFhvYUVm?=
 =?utf-8?B?bWhwZzVscWRaZGdvanI3bzR2ZzZZVHNlRnJGMDgrYVlsQktaZEZCeGk0ZWRn?=
 =?utf-8?B?NnVpZG8wQVZSTnJpYlRYS2NQb1c2TGFmeWlRS1E2VGExSDdNenREVnZGZ09Q?=
 =?utf-8?B?VXFFZHVCRE5qUWI3a3JhLzNGZVB3MXh6ZUZpWkRKYUx2TmMvQkFXa0Rwc2pV?=
 =?utf-8?B?eHZTaHBhenVKWmVVZDlneFBCUzhGcmRWR0NTSEdyQktkSHlUNDJReFBEVFpS?=
 =?utf-8?B?OWlhWU56Q2xxaDVPRlhoRThSbTRHTWVEb29sdUEyTGszU01TZjZsRW5NbmJp?=
 =?utf-8?B?N0pmNkdPVEloQ3Z1UUhUYVhSQjFHYzJPbWZmSk45WDJBRjkydXUzV0J1R2Nh?=
 =?utf-8?B?MnJYVGlwWkhKclRhZktvb3FvaDU0a0cyY3NKZEJpVG5FUEZ6NzMzeDlSVldS?=
 =?utf-8?B?ejRJQ0xUU1dxc2lLNjB6azUwRTJ6MkhXYnZQV015N2czWC9PSDl1TkdZTkJP?=
 =?utf-8?B?bUh6bXhCTy9rQ09NYUhNTEg5ZUIrWWN2YnljSlpqczQ5VnZTeDgzZWJzMTdN?=
 =?utf-8?B?OHVOdnFBWnBFdHRNdnJwVzRXRUYwYXdXZkQzTllGV3MzTnVHaGROdDk4b2o4?=
 =?utf-8?B?aitkSzZYbVQwSTdET0o2WkNYMEg4N1BaOHlPME1NLzE4bFRiKzRUUmQ1TTNW?=
 =?utf-8?B?bGEyalFnZG9yYXQraVc2bVZydTdkSEdYQStJcEEzcjZIV2YrVW1mdFNFMU0r?=
 =?utf-8?B?eXo2bmk0UlU3cUxRK1l3czROYlpXWmlLQkJwVVZWZUJIRGsrVVVMemxIci9T?=
 =?utf-8?B?YlhrQTBKR0xNM2xjSW1HOStvQjA0OVRUakhpamJTMUVRbXBYWUFKbWw2MDRS?=
 =?utf-8?B?U0xkZUovN3JpWnFPRUZoUnQwQ3Vtb014ZGMzN05lbVBSM09BWGVMTTRwQjhj?=
 =?utf-8?B?VWdzbXVsZFJIeCs3RUVCTjVNY012cklNN21rYTI2akFuUUtQYldPWlJmKyto?=
 =?utf-8?B?d2lPNzJGdndHQmx3S2ZVUWMxSDd4anZraVRNeUtEeDdNU0RXTmZvaUZhb01K?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13db940c-55da-493b-a251-08dcbc16410c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:04:54.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3P+lrMkOKLI1vfBZjKTI6HjQI4OwdFTGIjhQg9g1JM5ZZzuPgVWtyFjW2dN9Deve56tnnL4cVw212V5/H3XygymnnufWX616hkqWqAlKOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> depend on this.

It does not sound accurate to say that X86_CPU_RESCTRL depends on
ARCH_HAS_CPU_RESCTRL when actually X86_CPU_RESCTRL "selects" ARCH_HAS_CPU_RESCTRL.

> 
> Adding an include of asm/resctrl.h to linux/resctrl.h allows some
> of the files to switch over to using this header instead.

Please replace the vague "some of the files" with accurate information about how
files to switch over are chosen.

Reinette

