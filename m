Return-Path: <linux-kernel+bounces-532543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70141A44F11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF19173597
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132020E711;
	Tue, 25 Feb 2025 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjGNWnjO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63320C02C;
	Tue, 25 Feb 2025 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519679; cv=fail; b=ri0fZ7jATHgpxYhmc4MsmPqGGL6NA4VhtCSHZXDyhUhN/X/JcOOETl6cGLnHKlLVIW7KjA64t5s5E+uAXCOSdscRkxAHnXhMMZyyBZfTR/nh3wyhX5qW3iaI6qDURWz2ep+GGxsjqWcBN4EXua/cqJlLCJ7qDBej7Sqk4FUOUV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519679; c=relaxed/simple;
	bh=cgRhJ5Q9E/BrBNyqQs5StErtGYjfvGTJki6/9YA+FjA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eY5s8bHgeClpI5dcvz+INdagyILsAkH6G5eBqCF3bTLCjewIGS3NjMG8Gu2FENzCdxSrkRIwoqZYXxFqsfVxEp5Y+coqtbQoEgFigP8TUxQua6ACtuR5SpcZmFo7hyFGInYyvl4d9wzrN+Ypjw0FsD3ewKshnFm9LFOz9eGskV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjGNWnjO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740519678; x=1772055678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cgRhJ5Q9E/BrBNyqQs5StErtGYjfvGTJki6/9YA+FjA=;
  b=EjGNWnjOkemvV7Y3E6V2PIw8JgyJy3dtTmI+JMm/+7QaSZ7dmBMt/sNt
   TC/t9RFjx96DRF1uZAzwelLvMhAPifqZRt3K97Ni7vbjEK9oDMVGnwf5m
   5/GJWWDpQz4rTY3bfLiCD/G5CcIFBFlI5zoH0z/W85FPz/qvIT1SjioB+
   qkW6rjmvir0i5xup5xIf1/REc95lRluB6WcLJeMVgNbPG0gGFkPvWtIlM
   g0fBniTZ5lKhwONWA7qAAlCnc4h1Q50dOGRQnFl1xmozZ5YgIk9FOMs9N
   EJ+B1selLXPKICFle2xhUzB1pNSXw6zSek2yjy0ZEeiGnn2bioXtuoKeS
   Q==;
X-CSE-ConnectionGUID: EhXzH43ETwyyVklozrY3Yg==
X-CSE-MsgGUID: zXffgG8cRuS/FljASfZWrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41551815"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41551815"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 13:41:17 -0800
X-CSE-ConnectionGUID: ALR0Ds5pQ92qBBNT0PqPtg==
X-CSE-MsgGUID: NvAeHLrWR0u1zBPksZ+i/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116523698"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 13:41:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 13:41:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 13:41:15 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 13:41:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z79dzbziLZ5aumIFwA6vaufo0ZixRGo2R6/UfBx1hX1s3a2feokwjREIdo1iay9xwZJdj3vWPcIhisX/Q5lqgzqxWiABmxRnXBir/FY3fhdBHCPqqwJKSXcNttii06Gm+zEau6/+rkREMj+6NPk6JkkJbqoV+wn+0HG/DasN9Sw4b0X4jbJ5gxcqU+mxAYlJq0jegQmrYELd87L/I75R1/qWB4ckh35EZ5mfmv4cjkVyFnOy8owLRPEOKRt6n9gx2cgAVEthAXPjnDQ5zhkIT3wujiEEBdhlCaQfrbpa6srN1/+92NuUCDJ1K8y/h1aKGnAFnsLUyyxzG2Z0HHHt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB6qnpylwzBkUh7uc1brPIJ5HS8ajo+I6JlSryphJek=;
 b=IAoP8zauD1bfXVJ59vfOIwjcbnMnXufpdv3Xt5ayxH6OlsTeBonmBGmo29FrPwz+1IUvnb/mVWE4hM1nHuOwo80Mbtx3hV+12f8OhiJMJHrMfN96nkl7g7Mvb0WyOfam+IPMmJy4QTOkf3U2jse67Bao1Cq1KVSHh2sxkjli1cUC/efa9a7LB7qZTQGkqs0eROlFv1jwd8yDdEbdyXeX8JyCBCzew2N95nnx2LEqLi6NG8sREWD4JR5OKuAjnnkzpBHZcAl64uuuVbn/R0bb0uzzeBXEM0CTBeTftBgR/tp4joi9WCU7vbvV8BJLA3BbtiQ1GDX9hXl3+T5bMON0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 21:41:10 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 21:41:10 +0000
Message-ID: <631798a4-303f-4e56-afd0-2c217fa10d94@intel.com>
Date: Tue, 25 Feb 2025 13:41:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, "Babu
 Moger" <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
 <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:303:83::18) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|CH0PR11MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef1ba29-4375-4392-ab1c-08dd55e51e4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTRIQzRwcUl6eTY1QXFxQzdYQU9xMmhBQW9wTjVLWlA3TndQNnJhcUphS2Fo?=
 =?utf-8?B?OUlYWUg0bTZ0NjQ3cTl5enVoQWtIUFZIT2VnaDdidkkvSUdHYjl4MENNckpG?=
 =?utf-8?B?MGU2ODd4U2FwV3krc0l4cFk2T0pSaTYrNUxSTWo3N2NyRkhCK1ZYbzIwaWhI?=
 =?utf-8?B?WTZ4WkxCNTBINXQyMTlQVlU2bU5pT3NQbzJadkJFUVVLUGlXWVZhUEtrRlls?=
 =?utf-8?B?SXNId1JRaVoxUktZVmVvWHplNFdvT2Ztd0pOWFpROHBuVmlFQmFXdFp5Y0hF?=
 =?utf-8?B?b0NBMlFhSXJDRWNYUGxFLzRqZzVERk05dzkvKzRQRkRUMDhEc0ZRVndzK0gx?=
 =?utf-8?B?Z2hnK2N5RUFTNzFwbUorNEJzaXVtTy84c0JWTytmUzJ1a2JlSGlWSzVJdksy?=
 =?utf-8?B?YkxJQUE4ZCs4cytCUXRnekNLb0lZQUFTc2JwRnFSbEREelJyYktPbEtmd1lC?=
 =?utf-8?B?T1drYTJ1VTMwc2NVbnhuQTZucDdJMUZLdU1pc2J2VmZpTjhrNjg4ODFrdHZU?=
 =?utf-8?B?QjB1ejRhUXk1Mi9vK3lVZStKZWRoL1VtSnNqYlpQVnhUVlZKZjI4WnJVM0xY?=
 =?utf-8?B?d2Z3TTRiWVY1eHE3N1BLRlhMOUlwQ2VFMHVWdGs2ajNBalo0TFNTeGlKTTFz?=
 =?utf-8?B?ZkxiemlCOG5HOVRwMkU4TExqWS9pa0lHeCtZTzZ3NDNIcDdqLys4QXFqNnMx?=
 =?utf-8?B?VHY5YWh4NDFOZ1hVMU51RE51UTFaZTdIVU5CTzEycnlSN0ZBMTdKQXNNaVd2?=
 =?utf-8?B?dUhJVVVxZE5vVFY4TUNlS1NvdklUcnYvcVI3QWo0M0VQV0xqVVRRM29kbDBC?=
 =?utf-8?B?cHB0ZHZMRktkWGl0VEhwVjNMVi8vREVRRzk0cHMxL214RkJNaFNMblQ5Tzl3?=
 =?utf-8?B?N0s4ZndObHVGNXprTlN2ZDYyaEVNR2YvQmI3SjF3bVFHTkcwTllZTG83ZTJS?=
 =?utf-8?B?OUliR2lESmlJU1R2NDI1eGE3SjgrL0xFMjFRNDdPN2E4WFhsQVFFY1NDSDk3?=
 =?utf-8?B?S3NUYTdrVjZxeFcyVEtOTDJlOTlzK3ZNcmozajFUNm1WYVFmS1p1NEZ1azlM?=
 =?utf-8?B?Yld2SGk1R1pSbG9IWGw3NGRZeHhsQnhVZzVZb3RSN1FyM3dmWWttd1plOGU0?=
 =?utf-8?B?NWxSeXBrTzJHa3lYUEpuZm5SZUpGM0lGQ1laS1ozV0svREExcm9MclB0dGVL?=
 =?utf-8?B?UjJGOWJTK2FNb0Q3STNYcXFDWWcybzN0MlgzRTF5WEJTME1jTEk5SlBFN0JC?=
 =?utf-8?B?T3dOVjVrTFlVMC9mRDJPanQ5bjMzRnVxZnFsN1FPbDIyMEFQWEJQZ2YwQkp5?=
 =?utf-8?B?dGN6eFBYaTVlejVXSlBwM2lQb25tL3BROTIycm5MWjBLaThtUjZUVUErTSt1?=
 =?utf-8?B?MEtTUXRldzVyLzNtK2xoMzgzTllMMy96YUxSMlVPY040SjVYYnkweDNsUlUy?=
 =?utf-8?B?Q3lZVVZSeVRlR2dibHpMZ2x0dGtnQkRUTnlvR1Zpa05ZMlVtZEFOeUlTM3Z6?=
 =?utf-8?B?NXhZanNacVQrVy8wK1RSWUJhT2NPM21Ea1d1MU13SjgzVTQyK2NDSkM2QW1O?=
 =?utf-8?B?WXQ5S3FwU2hoOCtpYkdxZHBNUHYyYXpXQzNwN3BrQThUSyt5bFoyV0dVQ0E1?=
 =?utf-8?B?YWtENS8wV3RaakRxaTQ4K1ZLcHRCbk1nWkxPaVBOcVFIc0cxTHhnUTl2RzlY?=
 =?utf-8?B?Q2owSVdMNDVhTFM5dUIwOGlTNm1wU09CL0gwenI1STZFVmxKejRMaEVpQUpv?=
 =?utf-8?B?R3Z6UTZIQnpRWmJ6dFk1bjloMml0L3A0Z1NZL2FsYVY5NlF0dHplWmpRYUdH?=
 =?utf-8?B?YTcrSnFoOTFXdU5YVytPVHpKYzF2QlhML3gzN3lHTFdhaElWczJIMmNxRTVm?=
 =?utf-8?Q?Tj33g82d1/GnZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pFVDFRVzlKNmk3alZPSWdNa1VDZlpBR1AxRjdUZUVnVVJFMHhSd3ZObjY0?=
 =?utf-8?B?UDMxM1o5V3plaHRBVDJqUENvQUdRcy9ZYXRTTVNBbkEyNGk0NGprTkNoYVBr?=
 =?utf-8?B?MEU3ZjluK3I4V3hUOFh0dmphTGgvMnBsQkdGNUN1aXR4Zjdrb1JpSlZxeFNv?=
 =?utf-8?B?dnVDT2g0cUhDNU9UOXhwU0ZQWW5WYnFRbUtLZXo2NjJWNlN4ODBTRCtlYmoz?=
 =?utf-8?B?bS8vaVVUaU5TbURxR2N1dWRvU1NPVFNDTmdxOHZRVXpyZEFCaDI3NkN4WVJC?=
 =?utf-8?B?WmUvTnNKWnN3RkZYU0xBMXl5aUUwS21vSER6NGVvelozcVBORzA1TWRGQVBI?=
 =?utf-8?B?OC9TM0ZVMUw2Y1JVWFMxY0Y0M2JvZEFmeGFUcGl5SlM1TG51b0JwRzBjVWIv?=
 =?utf-8?B?eFFpL0ViNk1IKzZzZDQxSVRoTllHbkk0ajVZZk1taW9aUDNCY2xUMGZObXR1?=
 =?utf-8?B?K1BVbVdoQUFtWXpoQ1FJZjQ4UGFpeXd4MWdURWlsUGtKQTAycDNrSCtNL3cz?=
 =?utf-8?B?VE95UTJwUTFSaXFJZThXL3dhK3VZZHpOeVI3VmdCTmYwaDZmbTRGTG1LR2gr?=
 =?utf-8?B?MEp2bEtWb0lQd3dqKzVUalhSUFZnTndGOWNZK3JlV2w2TzBFbHlBcVplTzhC?=
 =?utf-8?B?OVZKMmRTZ3lmazc4QnJ6N2hod1dqd2srWjh5SkdzcXRZcGNMUVplbXVlemhY?=
 =?utf-8?B?ZldtSFRhZDhKeE9xMVJRVzJpNkNEMEs1aHhSakxsWVlKNCtvM2J0WU16WWU0?=
 =?utf-8?B?ZG81UTFQanUvdVFJMTNmeXljOUpHcGFHWWF5ZG9VUzBBRnArNytkMXlKZlha?=
 =?utf-8?B?L20zbldKZlg0aEM3Z0hDZytTNFBUSnMwV0VrZHVlSzRiVU8rVjJEalBWTkYx?=
 =?utf-8?B?OCs4cGhJZVhuVG14VjMzQnZFd3hPZUdyK1RXYjBuekZya3pBZUxrTXFDYklR?=
 =?utf-8?B?bm5JU0JnTXdjZVpGK2Q3OEpSKzVKWlYrNWR3K2tVZDZDekpnYlZGZUxpblcw?=
 =?utf-8?B?d0prOXR4MFhiT3RPSllCZnhISFhLWmJONFBmcC94bkRscVRsQ2tZdjNWMm9Z?=
 =?utf-8?B?a2dqL21hdURUOVpYZzJBZmZ5ajI0M1hHSE5DZjBaSmtrNGFYRlMzcXBIZXFQ?=
 =?utf-8?B?VjNSL2VaWjdOL1lSMXNpSGxGYlUwM0w4c0VuZ0dla1lXbjdRcWwzMUZaS01F?=
 =?utf-8?B?WHA0bmtrYmxBS2o2ajdvYUZSR0JtaFlzTHJzZFQ0a2ljNUl2elNOcGNPVVNK?=
 =?utf-8?B?cXJsTzU4WlducWxIUWhnVy82TkduRllmMW1rNXdhMEo5RWY5MnFPVmpSSjgy?=
 =?utf-8?B?Y3Y5TWw2N0piQWlieDJUL0ZNRnZvSmM4K1oyK2ZkOWhnVVEyeVZXZ0NtT1Rw?=
 =?utf-8?B?R0VoVkErNnZZOUFLR0RuQjgrc1BqbnEzWXU2TnY2SW4yd2RaU3ZPRWh2Q0Vz?=
 =?utf-8?B?NEVST21BenBzdHRpTlpnK0ppblo5VEYzQ2lhRmJaS2VPYUNQNkc2WWMrYW5W?=
 =?utf-8?B?NDA0QktGK2hlVlduK3dkRDVsMWFGbjN2MGRoUUhYYWNHMWMrVXhIRGVpUnJU?=
 =?utf-8?B?NmJsWThlN2ZGUkdCWDB1enFyZmc3SzMzemswSkZFK0k4Y2YydUVFOWZFNDVh?=
 =?utf-8?B?Sk9IUTZZaFowR09QMVJ1WTRxTUVteHkwbWhkd3N1ZkNtODQrc0JvaGx2bkZr?=
 =?utf-8?B?MVdOMFZwOXp1aWJ4eUJzd2Q0ZE1KZ1JtbGZoYlRpRmhVM0ZOS2R0Y0U5cENY?=
 =?utf-8?B?RVhxbXIwU011S0NRREF2aFoxc2g3MDdLSGM5Z1ZrZWdKNUp1RXhIQW5odFp6?=
 =?utf-8?B?anNyVURkaWhzaForWEUySzMvVElwRlcrRkFlc0lIaG02VXRzWHFBSmlVZ2w4?=
 =?utf-8?B?dUxaanNBdDhQcXBYTmhUbUtDbE9TNzY1WTZTY01rR2hTcEg1YW16QnZKY295?=
 =?utf-8?B?dCsxNUp1S1FFMHpyZVgwc1l3bHEvcWhiaFZoU1crN1BVcE5pWEV2MUltV3Na?=
 =?utf-8?B?RHZRd0VXa3RLOU1aNFVhcTFxYUFzbGdYb1RZamNydGxiZFZKOTdhVHlLdW5H?=
 =?utf-8?B?dkVPUWpWaHRkNkc0Y01Fb2hoYXZ1VmdIT3pDLzFHYnhmMTlOOWFNSHc4Yk5n?=
 =?utf-8?B?Rnd2MWdzU2pqcG56c1RINFdYVFk2TjRhQ1IvWjdlRkJ1amxwemJPUUVZWEln?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef1ba29-4375-4392-ab1c-08dd55e51e4f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 21:41:10.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFbSO5Pp3Ej3FlLDpbemNfB0eEtGUNb3qYf2JDU8zIX1uW1HLbRjmMUebWbYOcW2lpPB1JCcopt84tbfN7PNgp0SPTZJL38n98fkmK6rQes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233
X-OriginatorOrg: intel.com

Hi Peter,

On 2/25/25 9:11 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>
>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>
>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>
>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>
>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>> for.
>>>>>>>>
>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>
>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>> customers.
>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>
>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>> event names.
>>>>>>
>>>>>> Thank you for clarifying.
>>>>>>
>>>>>>>
>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>> which events should share a counter and which should be counted by
>>>>>>> separate counters. I think the amount of information that would need
>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>
>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>> writes in ABMC would look like...
>>>>>>>
>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>
>>>>>>> (per domain)
>>>>>>> group 0:
>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>> group 1:
>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>> ...
>>>>>>>
>>>>>>
>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>> configuration is a requirement?
>>>>>
>>>>> If it's global and we want a particular group to be watched by more
>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>> for that group in all domains, or allocating counters in domains where
>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>> there's less pressure on the counters.
>>>>>
>>>>> In Dave's proposal it looks like global configuration means
>>>>> globally-defined "named counter configurations", which works because
>>>>> it's really per-domain assignment of the configurations to however
>>>>> many counters the group needs in each domain.
>>>>
>>>> I think I am becoming lost. Would a global configuration not break your
>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>> globally then it would not make it possible to support the full configurability
>>>> of the hardware.
>>>> Before I add more confusion, let me try with an example that builds on your
>>>> earlier example copied below:
>>>>
>>>>>>> (per domain)
>>>>>>> group 0:
>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>> group 1:
>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>> ...
>>>>
>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>> I understand it:
>>>>
>>>> group 0:
>>>>  domain 0:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>> group 1:
>>>>  domain 0:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>
>>>> You mention that you do not want counters to be allocated in domains that they
>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>> in domain 1, resulting in:
>>>>
>>>> group 0:
>>>>  domain 0:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>> group 1:
>>>>  domain 0:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>
>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>
>>>> group 0:
>>>>  domain 0:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>> group 1:
>>>>  domain 0:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 0: LclFill,RmtFill
>>>>   counter 1: LclNTWr,RmtNTWr
>>>>   counter 2: LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW
>>>>
>>>> The counters are shown with different per-domain configurations that seems to
>>>> match with earlier goals of (a) choose events counted by each counter and
>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>> understand the above does contradict global counter configuration though.
>>>> Or do you mean that only the *name* of the counter is global and then
>>>> that it is reconfigured as part of every assignment?
>>>
>>> Yes, I meant only the *name* is global. I assume based on a particular
>>> system configuration, the user will settle on a handful of useful
>>> groupings to count.
>>>
>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>
>>>  # define global configurations (in ABMC terms), not necessarily in this
>>>  # syntax and probably not in the mbm_assign_control file.
>>>
>>>  r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>  w=VictimBW,LclNTWr,RmtNTWr
>>>
>>>  # legacy "total" configuration, effectively r+w
>>>  t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>
>>>  /group0/0=t;1=t
>>>  /group1/0=t;1=t
>>>  /group2/0=_;1=t
>>>  /group3/0=rw;1=_
>>>
>>> - group2 is restricted to domain 0
>>> - group3 is restricted to domain 1
>>> - the rest are unrestricted
>>> - In group3, we decided we need to separate read and write traffic
>>>
>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>
>>
>> I see. Thank you for the example.
>>
>> resctrl supports per-domain configurations with the following possible when
>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>
>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>
>>    /group0/0=t;1=t
>>    /group1/0=t;1=t
>>
>> Even though the flags are identical in all domains, the assigned counters will
>> be configured differently in each domain.
>>
>> With this supported by hardware and currently also supported by resctrl it seems
>> reasonable to carry this forward to what will be supported next.
> 
> The hardware supports both a per-domain mode, where all groups in a
> domain use the same configurations and are limited to two events per
> group and a per-group mode where every group can be configured and
> assigned freely. This series is using the legacy counter access mode
> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
> in the domain can be read. If we chose to read the assigned counter
> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
> rather than asking the hardware to find the counter by RMID, we would
> not be limited to 2 counters per group/domain and the hardware would
> have the same flexibility as on MPAM.
> 
> (I might have said something confusing in my last messages because I
> had forgotten that I switched to the extended assignment mode when
> prototyping with soft-ABMC and MPAM.)
> 
> Forcing all groups on a domain to share the same 2 counter
> configurations would not be acceptable for us, as the example I gave
> earlier is one I've already been asked about.

I am surprised to hear this at this point of this work. Sounds like
we need to go back a couple of steps to determine how to best support
user requirements that now includes per-group counter assignment.

Have you perhaps looked into how users access the counter data as
part of your prototyping?

Reinette

