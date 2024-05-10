Return-Path: <linux-kernel+bounces-176106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B6A8C29FA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F34281C61
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A538DDC;
	Fri, 10 May 2024 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TALAMS2q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5111713;
	Fri, 10 May 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366066; cv=fail; b=ga3oIvkvjWwCKURba7aH/jjKYLAUlUsUAugM3z90NSzotGC5UU7rM29eyxaIWM7jZy4DUMkCGTVea3RXqxOh0vPuS7UsOCDca/+92jz6W+nbVGKLU0ZmJOwa48keDUmGpKiDhrRqVeS8YziE/Q+mpb8X7UqkIsKLCT2gahI9fvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366066; c=relaxed/simple;
	bh=sHAJO2Doo9/OxmTmVhnDzppPMc1ivhCRkQHA30h810Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gqfwgzy0LNPSokec3XmLEU/f4vkite0FvU7BxSr9KAd8EBtJqU1rbKWbCwfmzDd4rI2+DjrtWDGJVHvC/gWfBaCABBPxkx5qo9SmF5gKo/ubrg52hVgISY4GmCBGxnitOkJ1OHVhDwGVC/szAOPBLWnWMVbHXzwJkpBVCfPGvlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TALAMS2q; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715366062; x=1746902062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sHAJO2Doo9/OxmTmVhnDzppPMc1ivhCRkQHA30h810Y=;
  b=TALAMS2qcdPiTJUjRvOFZqgr7++2qI3u30JsN6hP7Q6wErNEc2WI7tE9
   WMnfsztaCLhVNWkx1SvYB+SKq/o4snq0vWGTomLpczE5EOzYm3HaxJnkw
   SdA0B8P++2gtH5yU1h9Fr42xo6dBBJ/Fe73GwSAkWQwMy9rV/R4JAA+d3
   PvDF11zFBa18qOC6wvmInRlZJEa3k4PXso1wjfOPi28qFbBD1tgDQN6ge
   uW8Y3l+m7XSuW1tlFYWU7EMTQSBJQdfDy+nr30qLbdtvzlB9aVx4zjEw/
   yHURpQbssdb8a0qLQ2Vuq/mqWMHmfPqSpNOYFolbb9JEHgS7t1T6AJwvb
   w==;
X-CSE-ConnectionGUID: eOuFYxKdT3CxXgtv+u/W9w==
X-CSE-MsgGUID: //jcwFPSTbawKv1U+4XqRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11489132"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11489132"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 11:34:21 -0700
X-CSE-ConnectionGUID: LQ1TKq0QTPqfDzNi6frYKw==
X-CSE-MsgGUID: qPUrbX2BTOCBepi+jkARUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29646117"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 11:34:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 11:34:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 11:34:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:34:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk/f+9ShiCUFyIV9yEer2CrwQL8ywWLEUATUxux5LEmyCBd8IrAk4+sjMvKaJ4idqRA89EMOLDKjDk+xdpfJl9IxlGS+w6Wj/FX4tSoTvKDjIw73aXtZ7yR0VxtMxgu3xjcFK/BgSm2n8EGdhnGMEs/BzIjhqv0D0wPNQdcZDAdfSZNp1k7ejxOEnI1Q8QcZtMwIGOjsV0GHzFmzGY48AmDaacMHcmZHcOMdL81PaRynYqurPhGRyPx4Szs/eTMwOAgQPi+iG/iuwqH/fXKxSRLFkLvC2tPn8XxJmFNtWSS/v7TcafBXLJCTk7EdL4odCihjm52atUWgUx/eDc63dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7ZZXP1pbO8ZigXEZlMGaX39mYXiuYd83S1oiGk8nZE=;
 b=bJesDnOYgM4LWAqfOs2ISu4U6N3hZHPry3zFEd9YSBNM/pCzVfmSlHHaZ6CsuS3riT9O9MeNM8bune6Xn3b+u69iYARFRk1kPJVoAGR8iwATLTvGK/Y6oXvT8ZhK0bZNDu+xf+VRYkSvsDbgziiQPqBeQumk6GhocWKfvvgvaHLzQWr8u61BHMC3Bsk9Rvmay9sP6cIs7lC+DKzw1GAjJPpwEAspE0OzUhte0I/Z//bRBcunm2KYzbfiqR3aq74CtHFLuCP7lJ/9oG98GJ55pwgtbSGhL8V4uUIv0rJ4reGjRUcsSPJ6TuvL6cz4YeySoVIUISZX+F3qxf1FMjhy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5040.namprd11.prod.outlook.com (2603:10b6:a03:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 18:34:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 18:34:16 +0000
Message-ID: <51af9362-ccb5-4393-9dfd-8615138df217@intel.com>
Date: Fri, 10 May 2024 11:34:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
 <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
 <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
 <753844b6-b68d-4b05-89b0-3ac36e1c8564@intel.com>
 <be20ffe1-ef8c-41fa-b359-9ebfaa326ebc@amd.com>
 <50d006e0-8488-4579-ab4e-701e1a8f410a@intel.com>
 <4363899d-2203-5829-9074-beb6c0e583b6@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4363899d-2203-5829-9074-beb6c0e583b6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:303:86::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a2294d-59ad-4dec-586a-08dc711fcbef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akcvTitLdFBVejJBeEszem0yUXlURk9xK2UxVTdva0dsS3JYQkVXSFZ4NmF3?=
 =?utf-8?B?QVBCb3k3cFJOMmFiZWk0UWljeVpyOG5KVDhaUXF0ZWFnME0rK2hIOWRUa0ZW?=
 =?utf-8?B?SUw1YkJNQ0pCME9jYXRwTVM2dFBmRnBBejVPdndKNkJ2dUpBMUVRWVFKbUVP?=
 =?utf-8?B?Z3ZnR281YjYvVzlYZzZGMkdWdFBaZWE2aFhNYzBKUlpGcEVYMVVlMk9nNUhu?=
 =?utf-8?B?Qm1DYlNWWWc3MW9ENU5rSVpZQ29CUUQySUd2YkkzTXM0bFVFT1hsOHZNWFNU?=
 =?utf-8?B?UVhEMFJ1aS82RWNYNy9iOGV5d1d1SDlMdGxxY2NpZkFqU1FxcGZwT1ZOREhH?=
 =?utf-8?B?b2ViWUVuSmJRSTBWMHF3WFBwSFpsTzNpYlQxS2xpbVV4UUYvbjAxNkF3T2du?=
 =?utf-8?B?WlVYdjNPTWRCcmNPUlZMOUhQWkFjTVdXcWdHR05VQ09BSmNFbWVDc2xCc2pO?=
 =?utf-8?B?TG4yRzJRa1VUekNxK3NiNExPOTNTZS9kZjA2T240Rk9RR1pBTjY1ODBzaDFV?=
 =?utf-8?B?UEZQUUE5YUxiQXFqZ2JDVzk5UllVUVRiU04xUFZRWkdkK0h1a1pob25nRTFq?=
 =?utf-8?B?STYvSlBNa29kOG1sdTI1dStNTnNmamdmekRsdWltZ0s5a2RnL3oraWwrK0Rm?=
 =?utf-8?B?T1NiOHdTblpoYldrOGxNUGt2b29ja3lDaSsxZFJ6MUMwQXNFTFIyTHFqVUlv?=
 =?utf-8?B?ditxaHZmS0IrSUFnY1ZaT2k5K2NJSlVNRnptREsvUE5pTG9wYldPbGQ3WjJ4?=
 =?utf-8?B?VmxVK0lFcjNYUjlOTHRoekcrNE1qclNJci9PNWRNTDdUNjNFU2dZZEV5Smdv?=
 =?utf-8?B?dzhCOVVWSC9BSlVvVVZJbzFMVy9SZklTL29CY1RBSHdPR0xXRG1WSFI5Q3Jv?=
 =?utf-8?B?Mmwwb3NkbU0yOXgzZzc2eEhKb01zM0VKWVJpdjdaY1VTM1Z3MWo0UTVhbUtO?=
 =?utf-8?B?Smp2RE4wN2xodm5jYjkxbExUL0lHdjFxdXp4TnBNdW80SGNVTDNvU2tUbnFC?=
 =?utf-8?B?UUdzYkpSMWRsRi9pKzYvV2ZVWS9tcURRSHo5U2ZTOHh0enZtZjBlVEpYQlR2?=
 =?utf-8?B?eGpQRG1SOVhwbGxHd0dQakRXN3VkTDZvdWM1OWxwc29DNjZyVTdaaWxCRzFF?=
 =?utf-8?B?VDIwMGQ0ZUgxa3ZxS0pzU1NNYlNLY0VkS0pJNlppc1h3a3ZVc3VBVGU2c1Q0?=
 =?utf-8?B?Szc3MFc5dmhLN2Z1U2lBWEY2ZzdBV3IrbGEzKzVpejhXdlkxVm52OHpGV2hm?=
 =?utf-8?B?NmxlVzdZRTB2R3F2bmRIdUh1bEtmSE04c2RqS2RQcFQyRm1KcXNRRWZBZGFJ?=
 =?utf-8?B?d1MxOW9IV1R0MzFNZ040cFlaZ3dEMjhPaXFhZTJZMlk0MlRTUGh4cE1SL0wx?=
 =?utf-8?B?N0pDRWxQL0M1K2QyNjFJcTVDbWxyMTVvQlpjR28rUUt2ZGp3cGtWZTZMVUtS?=
 =?utf-8?B?emF0SS8yRC9vMHI5Z2VlbTVXUHFNbVBwV2hBS090NURHeXErRkF1bk1BVmZ2?=
 =?utf-8?B?NVdpMTN1eW9XcG54UWVhL0pVcmh1T3FtdzVtczZaSE1IR056Qk1teTg2NnFO?=
 =?utf-8?B?YnR3WWxSWDluNXRQS1I0SWs2R1F5dUl5RXZQVkxZY29rSWFxdFlIMEliTnNu?=
 =?utf-8?Q?TL137Lcks96ZDzA/hzHZflwqhoULYSG/hUNNVzG7ko1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek52aDl6bklQVlBMN3BXK21GM0IxNzZLVHAzVllObXYrcVYvTFY5MEF5RmRs?=
 =?utf-8?B?dC81SEpkY1Z2d2pZMnM1RStSREIrUDRqaEdTcVhNWGhKZjBYQkQ5UFUrcTdZ?=
 =?utf-8?B?UGZXdTBrRmFNb3dLbWN1OHdxejhWWlJ5T2Vpa0tROTJCQ0cxK3hYc3J5S3dj?=
 =?utf-8?B?bU1oSzVSZE0yR3lldzVUUzZrd2ZYZXJlM0F2LzgvVWNJMmhyMSswWEZ0Y092?=
 =?utf-8?B?c3ZoNmR4R2hRaEt2bFRUUjJjS1hjL3NBMzN6ZEZ3L05xaVJyK3JwSDNDVEdV?=
 =?utf-8?B?bWZ0cUhwczNHN1N6eFpkckJsamdiSmZXMWg4ZVM2RlBNR2tBaVlPZkJlM0Z1?=
 =?utf-8?B?bDcyNk82ZlN1c1d1TmZIQ3VZbzcvckp4OXZpK2xlMjN3WDlFaDhjR0l0dUpF?=
 =?utf-8?B?WGx1NFpjcSthQmd3elVSOHpnWlpuUjc1R3dNQ0RlQTFCRTdNcG9mR3ArQ3B0?=
 =?utf-8?B?dDMweDdPREYvSDhzUWFwOHczZFhHUzBrM0ZzdjRoOGFsbnlsSGNnRW55eHM1?=
 =?utf-8?B?WVF2ZlMxREVwQjV2YU1UMzJneW9raXB1L3FaQlhyTzNjeUJHM25EamNBWThq?=
 =?utf-8?B?WVBRWUVsNURtQkh6dFdoNEttNVREMkkvZHpBeWhRNFhSVmhoeDNSMStqbUxr?=
 =?utf-8?B?OGtGdEVnOWdRNDhoeGVzaEY0YVc0MEVmb2JkSzM2UTM1U3JnQlp0Tm45TUJ0?=
 =?utf-8?B?SGd1b2xjd0pSdU5neGcyU3Bsai91ZzFoSVBDcnRRbHBpb09DRDFrT1FhZ3Z6?=
 =?utf-8?B?Z3RXcDk3N01qeG5OTGE1UWxOZGZsMVVXdWE5RlUxeXJaaU0rM1k3a1pGWEhy?=
 =?utf-8?B?YW5SQlpYZ0ZIeEhpMVdJdGd6SmltOVFRa2dWTFNXRCtCVlBnVTE2S29XZDI2?=
 =?utf-8?B?WitGRlF4Q21ESmtyWWpJRVMxVE1qR2djS2VvYkV3SVJ4M2F5bklKaGxsc2U5?=
 =?utf-8?B?OVhHU2RhUmx2NnNFdjcydURDbEFMQUlEOVNMMDIwWFQ5cnBYSUY3SWlBNXJT?=
 =?utf-8?B?dUVrRFlXWXBOOWtDd0dqRHB4eVRpRkFFTDZtci9HU3cwNnlGVjJVL0VOclZv?=
 =?utf-8?B?OHZuMUxCQ005Rm01aDZuenE5Z3dVUFQ4dFpSSVlBSkdkYStGSXpJd2ZMQlNP?=
 =?utf-8?B?RUE2RDE1OXdpTk9sL1VqWTcwYUpmSk5aRE5qTDlGZUFqbEhNWXM3Mktsbnp2?=
 =?utf-8?B?c2MvM2svcFJJZi9ML0R2ZlNEK1l6UmhLTjYzOTVVUGdmbGVoZzFsTWhoMHNZ?=
 =?utf-8?B?MHA0U1B3eDBWR2Zwem0wZGdZRHVDdWtnazJ0V0xiK01yampybm02dmdDSlFC?=
 =?utf-8?B?Zk1tM1lJeXovMWJGWnFhcGQ5cU1qcldjSTNPTjVPRUNXbUZNUWxvd29VWU5P?=
 =?utf-8?B?UDJSN2lKQTMzUDZNQXBiVjQ4b2k1NUxFdTFzb0JJS3NWU2MyZEFkUEhzdUNJ?=
 =?utf-8?B?R3l1aUZTb0U4Z1NLQ3BqNHE1eXRQWStFYjhuOFhqWVBCd3FLZWdWL0IrZWxQ?=
 =?utf-8?B?d29mYWQxaXZwcFcyRFVVb0ZIendGRXVoaWlLUmxyNFFreWJuYWRnRUxMTzZa?=
 =?utf-8?B?R3ZMN1ZTbjZXZHlXMEQzSDcrbGV5NThBSTA5TWNKWVBEVk1STWNiZng2OWNt?=
 =?utf-8?B?eU9uUVREUEg5T25jRXRYWTdpeUEwcDUxR2x5cng5bXdIT1lwVlRFZkM5Szg4?=
 =?utf-8?B?dXMvZjQySGhtUmtVVXZsTDMyd0RSSXpTVkluL25KZm9HRDAwYzhWdG1xbGh4?=
 =?utf-8?B?cnV5TzdKdUtWaSsvazY1TFNmS2IzS0NjZDFqMWc4MUVRUG5JYkhEUlA3cUlX?=
 =?utf-8?B?UTV2ZC9qbmRLcUthNkg5V2wrYkU5bzJGak80UXRpVWVXREpWQkNpSEI4dDYw?=
 =?utf-8?B?a0hDVHB1SWx5bU1PMzdFZWhOVkZWcHQ3QXlJWm9IL2s0YS9XM2QxZWFabFo0?=
 =?utf-8?B?RTR3N3ZTRTVBMXF1VGhiUlZKSG1DS01aRW9nYWtRcnZpc2xsOGJseDA1QWY0?=
 =?utf-8?B?TDhlZDdyZTNZTDhXdEphOUNQY0JOMkxBVHdMYUFxbkFYVzlZdE12VEFSVVpw?=
 =?utf-8?B?eUNHT0tISFQzcGJTY3FiRW02dlBSbmp4SUNhWFNHc1NSMFB4UWM1T0NUR0xa?=
 =?utf-8?B?bzV0Y1dVaEhsQURUVlpUWUJkQmpxU3I2aERUWEFOdVBuUFFCYmIvN1ZTZHJ5?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a2294d-59ad-4dec-586a-08dc711fcbef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:34:16.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cneuZo3vvHiUOjaAycejKgrCtSaGk48k45WVJ/H+LyHJli3eC73LaUVsssts4wYqad/YXStJFUBdHkwnc+2JuggyF2WVqdMC/8zuk0TqAgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5040
X-OriginatorOrg: intel.com

Hi Babu,

On 5/10/2024 10:01 AM, Moger, Babu wrote:
> On 5/9/2024 10:18 PM, Reinette Chatre wrote:
>> On 5/9/2024 3:34 PM, Moger, Babu wrote:
>>> On 5/7/24 15:27, Reinette Chatre wrote:
>>>> On 5/6/2024 12:09 PM, Moger, Babu wrote:
>>>>> On 5/3/24 18:26, Reinette Chatre wrote:
>>>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>>
>>>> ...
>>>>
>>>>>>> + * @mbm_assign_cntrs:    Maximum number of assignable counters
>>>>>>>    */
>>>>>>>   struct rdt_resource {
>>>>>>>       int            rid;
>>>>>>> @@ -188,6 +198,8 @@ struct rdt_resource {
>>>>>>>       struct list_head    evt_list;
>>>>>>>       unsigned long        fflags;
>>>>>>>       bool            cdp_capable;
>>>>>>> +    bool            mbm_assign_capable;
>>>>>>> +    u32                     mbm_assign_cntrs;
>>>>>>>   };
>>>>>>
>>>>>> Please check tabs vs spaces (in this whole series please).
>>>>>
>>>>> Sure. Will do.
>>>>>
>>>>>>
>>>>>> I'm thinking that a new "MBM specific" struct within
>>>>>> struct rdt_resource will be helpful to clearly separate the MBM related
>>>>>> data. This will be similar to struct resctrl_cache for
>>>>>> cache allocation and struct resctrl_membw for memory bandwidth
>>>>>> allocation.
>>>>>
>>>>> Did you mean to move all the fields for monitoring to move to new struct?
>>>>>
>>>>> Struct resctrl_mbm {
>>>>>            int                     num_rmid;
>>>>>            bool                    mbm_assign_capable;
>>>>>            u32                     mbm_assign_cntrs;
>>>>> }:
>>>>>
>>>>
>>>> Indeed, so not actually MBM specific but monitoring specific as you state (with
>>>> appropriate naming?). This is purely to help organize data within struct rdt_resource
>>>> and (similar to struct resctrl_cache and struct resctrl_membw) not a new
>>>> structure expected to be passed around. I think evt_list can also be a member.
>>>
>>> How about this?
>>>
>>> Lets keep assign_capable in main structure(like we have mon_capable) and
>>> move rest of them into new structure.
>>>
>>> Struct resctrl_mon {
>>>             int                     num_rmid;
>>>        struct list_head        evt_list;
>>>             u32                     num_assign_cntrs;
>>> }:
>>
>> This looks like a good start. It certainly supports ABMC. I do not yet
>> have a clear understanding about how this will support MPAM and soft-RMID/ABMC
>> since the current implementation has an implicit scope of one counter per event per
>> monitor group. It thus seem reasonable to have a new generic name of "cntrs".
> 
> How about renaming it to "assignable_counters"?
> 

As I mentioned in [1] the "assign" concept is not clear (just to me perhaps?). It
really seems to be the marketing name percolating into the implementation. Why is
"assignable" needed to be in a "counter" variable name? Is a variable not by definition
"assignable"? Why not just, for example, "num_cntrs"? I believe that things to be
as simple and obvious as possible ... this just helps to reduce confusion.

My previous comment regarding counter scope is not addressed by a rename though and
I do not expect you to have the answer but I would like us to keep in mind how these
"counters" could end up getting used. We may just later, when soft-RMID/ABMC and MPAM
is understood, need to add a "counter scope" as well.

Reinette

[1] https://lore.kernel.org/lkml/0d94849c-828c-4f10-a6f8-e26cc4554909@intel.com/

