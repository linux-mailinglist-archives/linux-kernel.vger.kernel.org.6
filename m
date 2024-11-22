Return-Path: <linux-kernel+bounces-418774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA79D658B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA298160F55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033418C002;
	Fri, 22 Nov 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kqx9w9YN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3741176ADB;
	Fri, 22 Nov 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313242; cv=fail; b=rRG2ZNn+Iu1FvQpp1LvBYCzmub3vqpGy8rIWvkngprE+1r2u5VcIb4p6IFR0MK+Glxw+ITrK83NzAMYzGJ64eDBYFJZJwWWGbsRP2BBDHpNbdkWrzunynXAkZ7cjsGy8LS9mLdViLV5ojzucW2jq1GeJHADP/fZccNmU0ADVUmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313242; c=relaxed/simple;
	bh=dB1yc1xZRhJ+LIISQ6/1bhVAJSjAWuaME5C/0lDuTPo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxBwh2lID7TvGbLtUtXUP6oA4Iw9UV3YNVTbsaAULbb8ejtEpTVz8+qEg+mwqoOD0UzK7EJBaPkIJz5ZNFnuU9NDteS+cI1WgMp8JtWSufUUtNj6Z2DqGjBNsTP+x6F0PJ3K87TgMQTHVmcuEsDEf8UIgxSQBpf6YDRPq6Qhw3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kqx9w9YN; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732313241; x=1763849241;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dB1yc1xZRhJ+LIISQ6/1bhVAJSjAWuaME5C/0lDuTPo=;
  b=Kqx9w9YNqOTYjZAVvt97EudOxASGGrJhwt7OGqDtxoMeWepVRGa8J//j
   CA0rX2FfaGyz/Y9efDBiK3WyoaLCV0OKsuD0GyuLCp3rGsHg5iqg6eYfI
   XeTAlHrqF3NLNmB0yqIM6A8bQB9gwOZ/TvWvr9fbzV12uQXMRVcv2CaeM
   knIdD5NOcXOTuXX3gP0WUxnhnv6HczboxJchWGuqWIkREAFeBHkvsB8Em
   HwtyaZxbNXlC6+cRL5jLpoNlp5QldSiNutcOXx/A6UsIScH5l4nP/QCMp
   sXRFRWYp8tSkDfZUooGvStdunr8fD7j3Md2NIcoN1T1pGUaq8U/QRs1PX
   w==;
X-CSE-ConnectionGUID: 2vIp9KebTsy0MSs2sSjI5g==
X-CSE-MsgGUID: Gvsb+hlkRUG/ffdo2u7OAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="31870386"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="31870386"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 14:07:20 -0800
X-CSE-ConnectionGUID: Fz7Bz/sTTCa/ylFJn1k7yw==
X-CSE-MsgGUID: rEPZc6L4R+qoiPuZ3k9GUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="94786351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 14:07:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 14:07:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 14:07:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 14:07:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQQ/pd9fGWeJRLkZmRDYzrY8MyqFcZj4X//k7U0p8qX2y2J9PI3qulGnYGJ9ZHgZntv9GHmaRDQ5PG8c5DCOgZBtbUaagvIcpvKvuVavp/7JZyFt4Nf2xBRLuo9lNjEd90YuDrdMXQIwFm6jK/wB4VK7QzpmocBJPbx0yNXBpWd0wJpUbipmLvKvW223ecOCo/GhFjxKDZouansFLQBLYhPBUIGFssP2jMq8c74EucWpx4fO1I/7HnPRVE+7b4bwf4La+XKHG23HHiGXZU77pDK7tQHX+9lkQtRYIbpoLdDumH2KlsHcR9sVB0OyBcEdKiaarb/7vddIkJkEYdmDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxyMM+9YDTbuC5u5AINlnqixusN6JJ2iLehkHYT7jYY=;
 b=JCRrBMSf2sxKi1v/PVzdwQOoKZjOrqAYM/bCqhxAFf79oh4JJ1VP5ecwoCf3Dc/QPnttZQhlW3xn7OKC9iLpVQLUdYR8XwPFqm/aAT7gds1bRCCEZ7ClntEweRUkWENhjFAZGA+5uAjYf05VrMBWC3r4OrHBI2WIKfrhCg1UhGMhw7YG5BXAlWmhQnhA7mAnirVB6dIMkLuMFJ7/9ep3AD7VFhZ8DFMbGVP+XVnEhT5ki/cXgLkGy4UPekTgp73sAJYSZgNS2iJPmISXTtqTKViYoH4W2BXKmPPAy5KrceYtb3yXuONYQsmZwK1QaLQEYXb1gaG9aVnXrstkb0LA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 22:07:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 22:07:06 +0000
Message-ID: <f4e2012d-8f1e-4d01-bab7-178575028db3@intel.com>
Date: Fri, 22 Nov 2024 14:07:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update
 counter assignment
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
 <1757cedb-e5b8-45fa-9b70-4c78b5770624@intel.com>
 <77f808e3-1dea-4a85-b574-dcdcb03697f9@amd.com>
 <7fe1298c-d026-460e-aa0d-76144abce524@intel.com>
 <2e774d31-d63c-4bc8-b88a-1cee74533a5d@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <2e774d31-d63c-4bc8-b88a-1cee74533a5d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: efdce55a-d61e-43de-7ac3-08dd0b4200dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXEvN0pVcEFXNHE5RTdsUFA5MGc3MkQwV20xN1pqREliLzE0RmZPOVp3d0tv?=
 =?utf-8?B?Y2FVVWw5VjA5UDJ3NXBKQVdTV2xuN0R2cmhlNGR5S3ZxY0JjMFBQb1pYSjIy?=
 =?utf-8?B?bFhYckljQjlOZ0pXQ2loK1lYdDhHZmZPNFl2bUJ3RUY0UzZldnpseHhJRU5I?=
 =?utf-8?B?V2dkcmo0TkkveTlqcEYranl3K2xlVHViRXFMbGhxdll5TFBrSTVzMUY3UmVu?=
 =?utf-8?B?QVgyQ2FHNmxtWkluRVB6b0UyUkdydFlDQzNYREovSXZxOVdZTm9sS2tVdGFn?=
 =?utf-8?B?Z2lTaTVYN0FkR280cDl5VXRrTURlTmZXK2V3ZmRWL0Q4THVnb3FZbU42c1Z3?=
 =?utf-8?B?RHp3STVZeVh6akI5ajZScExUVzdyYlJERVlQMVNZaDRXeHRibnJmeFBES2xL?=
 =?utf-8?B?SEovYjZBR1RsOFpCSndGQkZlOUxsUE1GVk4vdy8vMUZ0ZnpQSi9Qc3Bma2xa?=
 =?utf-8?B?Vzhlc2M2UVhlZ1NNR01VbTcvWVpYUGpJVkxmQ3p0OVMvbitvdUg5RG9tTzFW?=
 =?utf-8?B?N0svNFBPR3A5Z1pWWWVNRG9PMTJwOGFhNDN0STNPYllJWTJ6MUFGblA1a1Fp?=
 =?utf-8?B?Zk85akk1d1pYR3FBRkh6TzNYclFBK0JjK1c2QTEySDB0T3h3SmcvczlZSHNU?=
 =?utf-8?B?bTltVWpUWGFuVkFNNVRPWUtwRlhjNGxKblRNOTdnRXlMLzVyNjFac1AvNHc1?=
 =?utf-8?B?bEFYT1Y5bUdoVkV4MVhsdWV2T1lNVnllRnNzS05wOWtiL2szM2F0cW9ldjdo?=
 =?utf-8?B?c05GTUQ2WnJoTW1KQk1rRlFTRCt6STBycUtzcHF0U3NVdjM4Q3Jibyt4UWxo?=
 =?utf-8?B?RHVCUld4RHdDdXBDdjIwejF5cHRnZnpIcXMwRmtBbGFXcTJkLzZldm5aczVC?=
 =?utf-8?B?Y29yVy9DVnVFdFQvbVpObXJMMVhzaVlaM2ZTUDNkTVBRZzlQaVdYNnZoQUkx?=
 =?utf-8?B?L1JESUczTmUrbnVTbWcxSW1WdXBJRjVCVWNsM3FhbEVLQitjTGlDZzJEc3o0?=
 =?utf-8?B?bzkzcnI4UjZ4aFZhVGY0SSt2QmVIeG1Qc3ZXbTBEQU42VExicks1VHMzT3BQ?=
 =?utf-8?B?dmc4MlRjSVAwVS9wSm5RSWNnL21SMjBqK29HTVlwRm1haEQ4L3ZWZkR6eWJE?=
 =?utf-8?B?N3p2MnV5MndaRlovZnZBaWZXRVBqWUljNzh2c3E2Qy9Sci9BQXNBakxaSWti?=
 =?utf-8?B?WGdoTlh6bnRpTnBUOXFMVlQ1aktLRGNoNmtRVlJXMmcwUGRGUm14b0lEdTVa?=
 =?utf-8?B?ejdXY3RFMVUzOTMwanNManlaMmtGQmRKVzdPOVpjaEZhNnNMQWRiMHViWU9P?=
 =?utf-8?B?Y2FUVHlha0pqeTdsbFAvWEd5aERTSG1oa24yTFlVOXNoQkExWmkvbU9STjdK?=
 =?utf-8?B?QjNrcGM1LzE5TGZxQUUrQnhzbmFiVWJhNTVPT0diUHdQMnBrdlFrTjlTNytT?=
 =?utf-8?B?ZmY3QXFkUFRVd2x0dWRRekl3dWhRYmRvU0NGUXhFZFBNNnFXSjIwQ3F0ekxm?=
 =?utf-8?B?SUtMeS9COS9YeTArU0o2WlVhWEsxKys0U1pkd1RtYkswWS9ZL2FhQy90RUg1?=
 =?utf-8?B?b2pKMDA0SmpmNCtKUmpla1V2OGNJOXZoYTNsc21IeE0rcVpGQ0FiYVlvbUY1?=
 =?utf-8?B?NVhUTG1vNHB0NzJ2VWlYa3Y3OS9NTEU2c1ZUOG5rNlFOL29Ib1U5UXQrT3J5?=
 =?utf-8?B?dTJNdU8yN1M5bGF4NStEV1FNNWpvSmFNejk4bXdmZ3JhcHZxc1RBb2FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1RzV0pBanIxZzE4YTcxZ1V1T0orbm9BTVRGOTdOUDRaM25PeU8wbFg2WnFY?=
 =?utf-8?B?dXhiMUFTSi9GTXJ5ZU1iRWg5YzMrOHVpZVEyckVsKzlqOFVNQkp3dG14MkVK?=
 =?utf-8?B?SGtCRlY2R3pHSXFzall4WnB2VVZWQzRsZDBkWlViSU4zY0xOVkxIRW45NXJN?=
 =?utf-8?B?bzJSRW9GYnkwazVIRnpRSTY3aitsVjZKUFpXU1I5eHNRUTdUenRnaEpSbERR?=
 =?utf-8?B?cVhjcHViM1gwUUgxRWpsQjdDUDB0Q29ETmJXTmI2TWhobTBzYkJhL2pWY2VH?=
 =?utf-8?B?QndaUGVYbGtkTXltR1cxdW5nVXN4Um5FZVF5Ui9FMi95SUpBdklFd0tRQWw5?=
 =?utf-8?B?eVFWVm5RalM3N1BwNUJSemswZG51dWlybThVY3ZrQ2d5ZHJUZldwZWRLY2hl?=
 =?utf-8?B?cFBYVjM5bGJRZHRFZSs3NVZ6Q2dQVk5YZ1FwSWxwaWJ1OFVEdVFvbVRoUXVX?=
 =?utf-8?B?V0l3S1MxcWV1Sk5pMGZDZEVFMEJnWENjRmtsaXhPQ0tpR1lQeFFiYjN3US80?=
 =?utf-8?B?YUZWSEtzY2ZKVUM0MTVsVmVUU3hFRGQ2SFB1cGVJRDFIVlhqOGpyOG5kQnkr?=
 =?utf-8?B?VTgxYU8rZklPeDcwV2U5MEpzbzAvVUdOK2hJRDdWNzFWWWpYSkRUK2pwQnY5?=
 =?utf-8?B?ZFYyejdhb24wY1hrMWNhdUxNNDlqby8zOThjOEtWaXEyK2RCOUM2bGV2TnBC?=
 =?utf-8?B?ci9TZTRXOGNZNFZjMDc0ZXhtQnlUalRrYitRMFZUbzg2SjlaWFhPRHIwc0x2?=
 =?utf-8?B?OU8vcXNGam9XVXkzTDhRY0tmekZLUVRKczc4bVB6cXN6YkVLcDFWTTJuQ3dP?=
 =?utf-8?B?eG1ieWVjbnJsYjkxMW95MU1PNkNPVUhVRGRkRVlpWnljakcxQThJdTNLckNy?=
 =?utf-8?B?Ky9TaCt2LzJFVFR6S0RKQ1Y3bVFjdDA5MTZOOE0zUkJtRmhDMnFBYVVFaUFB?=
 =?utf-8?B?VVRYaHo5TG4ycHRYMFE5YUdJbzQ2Q2x6VGR1OFUrdjQycGxmaGRIUG9hcFJz?=
 =?utf-8?B?UmlOSG1oeWdHMVd1bnY1YkQxM3N6YmFlVVBxaUVLWk1GWnI4emdTbHV5ZkVk?=
 =?utf-8?B?YjQ5aGM5My8zS1BYY1dMY0Nvckhrd2lSTndRL0crNEVJNlhReW1rY04wcVpG?=
 =?utf-8?B?Y2tiTFNlalN3aEhOS2M1WmtuVlFPL1pYUTJCdW5tTm93SmRoN3oxQlJCOWtB?=
 =?utf-8?B?Nm1LNHBsSTBmSHg3aC9Ra1ROMFZ6UUQxemdUU1ZYTmtLZjhaTzNwSldpam05?=
 =?utf-8?B?QUEzUjFyMDExTWdrQi9HMzM1enVBMXY3bFdETHZMUzdWOXVDckJ1UjVxSDdO?=
 =?utf-8?B?YlFHMEdmeWhpNzdWZ3I4eTFwR0RmRDYrSjgvYUgrdmtNQmdrblRvUTR1cW9O?=
 =?utf-8?B?SFpQaSs5WEREQkRuWDBvSnQrNXJoak5EWGU5OHZKM245bll2b0tJZ2N1M0ha?=
 =?utf-8?B?Z29mTW5icE9nZWJsdFVOMVRKMzk0NlFJYlNVMXBoK01DZ3lYdDhTWnFZNnhO?=
 =?utf-8?B?QzFkWjhkU2Z3ZmpXaWdrVGJTakMvMU13OUJxY25lRHd5RmdmSVhZYVJGZ2J4?=
 =?utf-8?B?Nm45UU1uS2d2OHRNZ2tzdkU0ZEZZbXBUQ25IRWtmYzhjc2pwZkNWcGRFdWVE?=
 =?utf-8?B?b1RrUTFVMXZ0U04xRVdib1V2di91RGI1NW9YdEJnYlA4cytQbDZTZWh6MXVy?=
 =?utf-8?B?UjM2VVBWWG9HT2tFZFh3REozazVlQldlOE0zbUtMakJzVVpreUhnUmVjRS9L?=
 =?utf-8?B?dTZVZVM2d0orcFN0UStsWFpHV25WRUswRW55TTVoT2RMUmdCOWRvQmJWdEs3?=
 =?utf-8?B?eDFMVC9jRjlhaXVQbUxBRXROdW5ra2g0UkdEandnbjlPbXJRS1FWZ3plajRH?=
 =?utf-8?B?NzIvbWFxZ2VLZ2pVWjNvR2E1UjdISmVEczlCbVhvWkNMeVpEWEtLdnFGNGMy?=
 =?utf-8?B?NVN1RkI2YWVrclB3ZDI5ckZKN0MvRlArT0JLSi9DdTdOUEcyU3VSMFRFTnVr?=
 =?utf-8?B?RVp1akV3OWxCbHd1Sy9mR0RhTWlpRExuZDV0OVNjc212TmFrNG1jZDVYNjJp?=
 =?utf-8?B?elFtaDRWcVdiaytadE9HUEFmRTUwWk94eXg3T3JkTzM3UXVNbDVOZFUxV2N5?=
 =?utf-8?B?S29HMVpvNHpyN2NMeGlLL2RBd1N3b0xSRjFwRFRPVVpyajlaQThsdzFDSTZL?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efdce55a-d61e-43de-7ac3-08dd0b4200dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 22:07:06.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8bwlk9IDAMInp/KZv3De3jC/FAk4r5v9X3hrfryWOjdFKK27nemTzmyO5nniVjkCJm+A0my/S1dIQtvZnlbUH09WJrvOrWb+DV5bHvpvv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-OriginatorOrg: intel.com

Hi Babu,

On 11/22/24 1:04 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/21/2024 2:50 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 11/20/24 10:05 AM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 11/15/24 18:57, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>> The mbm_cntr_assign mode offers several hardware counters that can be
>>>>> assigned to an RMID, event pair and monitor the bandwidth as long as it
>>>>> is assigned.
>>>>>
>>>>> Counters are managed at two levels. The global assignment is tracked
>>>>> using the mbm_cntr_free_map field in the struct resctrl_mon, while
>>>>> domain-specific assignments are tracked using the mbm_cntr_map field
>>>>> in the struct rdt_mon_domain. Allocation begins at the global level
>>>>> and is then applied individually to each domain.
>>>>>
>>>>> Introduce an interface to allocate these counters and update the
>>>>> corresponding domains accordingly.
>>>>>
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> ---
>>>>
>>>> ...
>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> index 00f7bf60e16a..cb496bd97007 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> @@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>>>>>   int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>>                    enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>>>                    u32 cntr_id, bool assign);
>>>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>>> +                   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>>>>   void rdt_staged_configs_clear(void);
>>>>>   bool closid_allocated(unsigned int closid);
>>>>>   int resctrl_find_cleanest_closid(void);
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 1b5529c212f5..bc3752967c44 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>>       return 0;
>>>>>   }
>>>>>   +/*
>>>>> + * Configure the counter for the event, RMID pair for the domain.
>>>>> + * Update the bitmap and reset the architectural state.
>>>>> + */
>>>>> +static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>> +                   enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>>> +                   u32 cntr_id, bool assign)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    if (assign)
>>>>> +        __set_bit(cntr_id, d->mbm_cntr_map);
>>>>> +    else
>>>>> +        __clear_bit(cntr_id, d->mbm_cntr_map);
>>>>> +
>>>>> +    /*
>>>>> +     * Reset the architectural state so that reading of hardware
>>>>> +     * counter is not considered as an overflow in next update.
>>>>> +     */
>>>>> +    resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
>>>>
>>>> resctrl_arch_reset_rmid() expects to be run on a CPU that is in the domain
>>>> @d ... note that after the architectural state is reset it initializes the
>>>> state by reading the event on the current CPU. By running it here it is
>>>> run on a random CPU that may not be in the right domain.
>>>
>>> Yes. That is correct.  We can move this part to our earlier
>>> implementation. We dont need to read the RMID.  We just have to reset the
>>> counter.
>>>
>>> https://lore.kernel.org/lkml/16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com/
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 9fe419d0c536..bc3654ec3a08 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2371,6 +2371,13 @@ int resctrl_arch_config_cntr(struct rdt_resource
>>> *r, struct rdt_mon_domain *d,
>>>          smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
>>>                                &abmc_cfg, 1);
>>>
>>> +       /*
>>> +        * Reset the architectural state so that reading of hardware
>>> +        * counter is not considered as an overflow in next update.
>>> +        */
>>> +       if (arch_mbm)
>>> +               memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>>> +
>>>          return 0;
>>>   }
>>>
>>>
>>
>> I am not sure what you envision here. One motivation for the move out of
>> resctrl_arch_config_cntr() was to avoid architectural state being reset twice. For reference,
>> mbm_config_write_domain()->resctrl_arch_reset_rmid_all(). Will architectural state
>> be reset twice again?
> 
> That is good point. We don't have to do it twice.
> 
> We can move the whole reset(arch_mbm) in  resctrl_arch_config_cntr().

This is not clear to me. The architectural state needs to be reset on MBM config write even
when assignable mode is not supported and/or enabled. Moving it to resctrl_arch_config_cntr()
will break this, no?

I wonder if it may not simplify things to call resctrl_arch_reset_rmid() from
resctrl_abmc_config_one_amd()?

>> One thing that I did not notice before is that the non-architectural MBM state is not
>> reset. Care should be taken to reset this also when considering that there is a plan
>> to use that MBM state to build a generic rate event for all platforms:
>> https://lore.kernel.org/all/CALPaoCgFRFgQqG00Uc0GhMHK47bsbtFw6Bxy5O9A_HeYmGa5sA@mail.gmail.com/
> 
> Did you mean we should add the following code in resctrl_arch_config_cntr()?
> 
> m = get_mbm_state(d, closid, rmid, evtid);
> if (m)
>      memset(m, 0, sizeof(struct mbm_state));

This is not arch code but instead resctrl fs, so resctrl_config_cntr() may be more appropriate?

Reinette


