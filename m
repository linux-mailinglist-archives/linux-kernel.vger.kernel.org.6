Return-Path: <linux-kernel+bounces-526770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783EFA402F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2549E424CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED772512DB;
	Fri, 21 Feb 2025 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhaB6/zx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B74205ABC;
	Fri, 21 Feb 2025 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177827; cv=fail; b=g/42nSAqBTzlGT6cdz8sUsCDZ0W3oVeZlvfHbqztMxem+r6exjNJSTwA0Djjoe5CKnCaedLoDNu4OuaCqWpwJAw+iAxEM5gM20wLcnnX5SUWSy5tMUoI1JcQLOnG8AtLbYAS+OHMNzOe/y8MQb+S3roO+waT6Elp4WmjLDh5SGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177827; c=relaxed/simple;
	bh=vHVWnWfs2KVHnKU125e0DDGyvDpK5Jjid/O3YPTbVlU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n6WEUMrIf5aykb5EpyowGt9+6sIc6JnB5j9eGtUFnVYe8t8lJyua4xcP96EXFLTJsIO8nOssR5I1BQEq1CX+dnE7yu8BjJftj5iphBeXZS1ruFDIfSc7Ut4/NFxQqjOfiq0AH8f4lJ7qY3u0m4+jz4R9ea/TXaN1xuWbl2kOpU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhaB6/zx; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740177825; x=1771713825;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vHVWnWfs2KVHnKU125e0DDGyvDpK5Jjid/O3YPTbVlU=;
  b=nhaB6/zxjPHFBIRsRXpbWpxHz3VD8kYibpXO9CXKiKFiKXz4Jm6Ep7NZ
   tn9uS6bk3e96sDWd2NlxKM9Dve+jBZfWX3E+Wncox14BXTwGR1qoH+IBA
   ngRSkixO6ZtoKk3D7hSK1mvAUW2aM1hIValRmvwSd0Ks6GlpwME7pALjD
   uwbOIwiT9CQtFgHORKfiQELI3nuEqmX/ZDodQLnfQjXSZXT9aervKcB7D
   nUIBhifXM3PolaNe72/sv9KpsgDetTT6UTMURRIrTaVgHVUgGNBMI7nDb
   zo/ClmVJ1yhsfGFWZssAfZ2cZuoq1+4m6wYOw1cablppTVRRz6W7Vw6YC
   A==;
X-CSE-ConnectionGUID: sWI+PiWUT7e+hlR3PRo0RA==
X-CSE-MsgGUID: tnzwbVlWSceGDhuuEnGYjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58424604"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="58424604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:43:43 -0800
X-CSE-ConnectionGUID: LiI7cR6cQfWwo6lSF4cy2A==
X-CSE-MsgGUID: ShvC76/uQLqOuXk+mlYaiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="120589457"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:43:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 14:43:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 14:43:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 14:43:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmqWPV/PWJpTxP4+RqlmXLtll6MzTsstG/4/9yE9ti1du/M34IXsDxYjozLlzSkD4spW9m7SoTDwzZqBZ5iJUgdo53JOfjoY+xQsLP0OAkj6wOL887h2u4nPILmafgrORHbJqwPQZAebuR4mWwvn56MO3c2O0rVRo4wrq4/u61FBh7yO1bgPYegAioOepSzarKVcvicwclORixP4Mv8Jrw9KJJLe1agugEFR6r2Xh4cc7feTPQUmu8Du8OrcTPSpP8Xdy3uYRbFxhcnNUTl5dJDqsTUecBt2dTL9Zb5OIBZ3L0mPBbMwQrIMst+ceV4GjlKubU2YquzTIrzgkQ06tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8bygQajGKK2EcpWbbOhPvLnpdABDzVzgP4VhAwWeSE=;
 b=YZqU27U1205XeOEFUNoj9kzE8DQ5XuLRFvorxMyXBSBUztCdp/NRSzMULHeQ3mlme9ULC5/1VCZRDvhUTt0RwWzOPYp//SRVnC5byVjgUrrVKE2PsOB6Wxguks7c9RpzGEOKxgnElq+QXnNWeaSKiiNhj7zM64QpDwUWrSKXYM213a/QLFSqRS+DWoDdYlKqDS44DLcSUwHWhJsoDo3LCmkkMhgS1+Tc5dh/qglKm6jfVwd3GMR9Ck+CkpRkFgkTbloqOsRqX4YAC71RGPAa63TE+Mt3QiVyUI34UMW1KaS4qxRehGfVtxty/oXIvGe0x10F/o8UzQ6xeEdtpJbs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 22:43:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 22:43:38 +0000
Message-ID: <5eac22b9-9b39-4c04-bc96-abd18f4347b6@intel.com>
Date: Fri, 21 Feb 2025 14:43:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>
CC: Peter Newman <peternewman@google.com>, "Moger, Babu" <bmoger@amd.com>,
	Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
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
References: <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <Z7dccLOTPzySYTXL@e133380.arm.com> <Z7dqXlOMsw7Kb8F2@e133380.arm.com>
 <eb435a64-70d4-4821-908d-686243fec7a6@intel.com>
 <Z7iuJdfgYNCeytJE@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Z7iuJdfgYNCeytJE@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7e1225-803a-459b-e2eb-08dd52c92eb6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW1jS1lnVElLWmU0ai90L0hkaHJUNUlWaVpqblZPSVMyUHNRQUxoNElaL2Fi?=
 =?utf-8?B?OWs2dG1oSHdGMldFU0tiRk83YzhpaUhlU2RaNWV1V1FiTyttK0ZmbXBrNGVT?=
 =?utf-8?B?QmtsNExGWlo0SURRZjhIVk5lVDFaMjM3YXhZZWlqZEZRdFdnY2ZQekthUG4v?=
 =?utf-8?B?QnllUHRnVm1PeERMd0xxSG0xd1Z5Tll1bWZLZE9NT3ZSZkh4NUpydzlmUWVq?=
 =?utf-8?B?VG1PcHcrVjRxK0FYSU84b25ET1NjR2FaOTV4MzZucTNKRitUMEZ6VEtEZ0JF?=
 =?utf-8?B?RGNzOTBjVkJVM2Fkc2p3a3pZd3o1Z1I5bmx1Qmt0M3ZxMG1ZS00xb1Z6cmhs?=
 =?utf-8?B?UTg0a3ZmNzNUMmh4SlNtNTd3bjlxbEl6SmZiOVdQcHR5NEs4dlFTbnYvbEtm?=
 =?utf-8?B?eTR1cmluQmxsaFFyMG9ndmxjUE5FLzhIUExUYlc3U1VSYThRSGxDNExlVklR?=
 =?utf-8?B?Ryt0TWczeHJNRFFlWEhDRVVIcnNDd0c0WUg5YmVtNjhKUXkxTUFpdnphQytv?=
 =?utf-8?B?RDVjSmkxQjBnQVZreEdiMndYZkZVMS9ScDg3MGZiUldWYVdvb0ZOVGVEazdL?=
 =?utf-8?B?VFFNN3cvKzJNVXFRT2dkRmRteWtDNTloSlc5Y050ZFhmSHdNNHBudHNxNXdo?=
 =?utf-8?B?ZG5tN0E5TTRVNmFwUXI1WDJDaFZ0M0FyKzdXSUROSUo1UGlyaEpDWiswcXd0?=
 =?utf-8?B?L3Jqa0txVGNSS3pMcnNYNWFtSUxZY2l3RlA5OUVoR1VPMFYxTlI4VGEza0ti?=
 =?utf-8?B?L2VhUnVocjB1QUI4TUVkN3ptQkMxY252T2RyQnFaY25GSm9VbnlzRjJWTnhN?=
 =?utf-8?B?SlljTEhKK0l6MmlqRG1DOHFMQ05aODVjYmlLYjRKcE1hTzV0MmUwSFVmMU9V?=
 =?utf-8?B?OUtYTWVwaUpFOHF1V3RreFJJRiswa21uU0E2ZVBPOHNDZUFOUnhyWHkvTkdN?=
 =?utf-8?B?OFBSWVFXOUtINmFKeCsrN0ExNDZaRTJPRmpnaGYyWHZ0S3RxbGpoNTUzZHhJ?=
 =?utf-8?B?UUgwZkkvSXg0SStMeGxKcGVhRm8vYmYxWW8zMXQ2aVdjQS8zQitGd0p0WDdJ?=
 =?utf-8?B?eUhsSmpBRTRsNENURGRrMGxkYU5FZFl2a3VvRHlFVHhLZnpxeTFuYXdBemVV?=
 =?utf-8?B?cnVTa2dVSUhVSTRMVFZENEkyNzFIVDdHY2ZWWVBWaVRkZWJYY2VKRHFUQ2Vo?=
 =?utf-8?B?S3NLUmxVTEI4a3EvWlRHZlJHbnU5TzBtZlVtYlUxRGlLYkZLb01DTGhnQzRI?=
 =?utf-8?B?Ylhzb2txZFcyQmpmdEFzR1ZvcmlnT0dvckx5STdheHd1bkY3aXlKNmVONUNB?=
 =?utf-8?B?Zjl1WUJ4NnVHaWp4T1FGeXVZUUxoNDJ5WjlSenlpTktSalNFdGh0U3lqcnpr?=
 =?utf-8?B?Z2JjTWR3cFlvNngwckc3VnJ6cmpPajhCQzBlZmhEcWhTRjJZOEJtWVBYNkdC?=
 =?utf-8?B?bGMvdTB2cEl1T2duZEZ4azhHK2tMdjBLU1JoazBpSW54bWdBcTduY1oyU1h6?=
 =?utf-8?B?TUhrMytMRitmV1dMK0RDQm13ZGlxREx5RnJkMkhDREc3Vmo0ODQweDk1ZWMw?=
 =?utf-8?B?Ti9paDAvTExya0pwUmd0MlpscHpPa0xUK2hqblFHSEtRS1ppcjVrcTlZNFJP?=
 =?utf-8?B?bnh3L2gzcjVGa2lFb0Y0aWNLWWNKd25VYVdYSkp2ZldPd2VjOGVXMFA2ZVc5?=
 =?utf-8?B?NWNIUEFPcC8rYWgyaE51aGp5T1BLMWxYUnF5RkV4M3o5M0UzejU4cTY4Ykxq?=
 =?utf-8?B?UmEzRFJvZWtKNnV3MlI5c3NXcytML3FYU2xVUXFSSm10RUZ0eEx6a2N2NS9x?=
 =?utf-8?B?ZFdKd1VTRXRDcVRjUm42MzYzMnJ6TEllSkcvM1oxLzFJQ3AwVWhBcVNmYllw?=
 =?utf-8?Q?rESSwKwR+CLNK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWZWRTNZZzBBVi9sbkNEWnlRQWJXbXBrMXpxdHF6dDNQbnlyVFZGcVhlTmMv?=
 =?utf-8?B?cTlid3FVR1dwQ0NNL0dBeXBsT2ViQnd1bzFDOXFla2VDdVU5UTJ6NnNzZStW?=
 =?utf-8?B?d3hLRUFyREx0WFZLejFuZ1lyR2piWWp6Zko0SEdDZS9kTm1KeDM1cDJFL1VL?=
 =?utf-8?B?WStGNldkWWtIZWhmMzQzaEtFMmhwckIxRHA1Y3V0eFlIUXNqS1IrWW8xY0lR?=
 =?utf-8?B?RUE3RWs3cXlObHJmbk15TEhnWjJockpQMG1zem5qVmhYUDMrOE9PaEYybkNm?=
 =?utf-8?B?RHhkandVK0pFcm1HSnpJR3I1Uk1Cd1ZhR0dzbklML2hCTm4rNms4U2NBWURu?=
 =?utf-8?B?OGpiN2J0MzVtWkVMb3JjMXc4NXJpZWovVkdlWEtTdENwMVV3YTJnQXIvTDhX?=
 =?utf-8?B?NUp1SWl5bVo2TE9aQWZLTndJVTZjdXVaUDJWd0xzczJwQ0ZzbGNrSmdodStF?=
 =?utf-8?B?SHU2Q281QlJIQjlXSGFQeGxXcVdyaE95Y2dQY1dqSEYzd3ltT1dIL2l4L0Ri?=
 =?utf-8?B?YmRYUS93bFRQSlhDeTBnYzUvV3NPYmRQeW8rQkhMei93RnE4QVNYRkdnenpu?=
 =?utf-8?B?b0FCV2tGNkFPRjhzS3grSnNpREV4TE5ZN0VTMUdzVkl5anlGcnVkSC9kcFVD?=
 =?utf-8?B?L2FZMld5SGtUaERIN0hBS3llTHU2UW5wWkVsYjBrUGRPb3dGT0VEUUNpN1Z5?=
 =?utf-8?B?YTNLcUdDOXl5NG5PZFowYlAxeWNoOTFiSmp2QnhpYW5oVWVUY3EyTERLSVRh?=
 =?utf-8?B?NnBTU3daUVFlVE5ZL3l4SzNnbUROYzVCQ3lpZE9IMURTblFwRm5VMUVJRFFK?=
 =?utf-8?B?OWdZcmVadGREODdMVDRMRXBTbG5nQjczMWF4enhnQUxMNndiUDgyaitpak1H?=
 =?utf-8?B?NmhMYzVjZERZbnd2Y2lNOVdBMElaaEpURHYrbzBMeXhaZ2hSbitUdXQydEtL?=
 =?utf-8?B?U3NCTmI0SjNia1p4QzY5bE93R1ZkRXBIRnVLTGJSdjZaTDl5V1NQT0Vhc3J3?=
 =?utf-8?B?bUtXbzhiUG5sWDV0elpsejMyczZER3RabmEwdFJ1Vlh5amVkaHYyeGJQdTBX?=
 =?utf-8?B?RHdIQ1FxcG5pRDNuc0lPYnBERmRHdGY1VE1jVTF5b1pCNUt3SDA4bFQzNmc0?=
 =?utf-8?B?QWNvSjJ5dUlxNVlBSWpzSE95QW1xMVhFYWcrOUpPbHp2RXI1dFUrZjc1Ky91?=
 =?utf-8?B?dTcrZ0Z0dHlkdUZMZnBPb0JWcTlaZ3QwU1JyNWpmMnFWeXNwcFNoZW5rRHJq?=
 =?utf-8?B?U1RWN2E0MnhCMUlsL0ZKQm82RlNKQStGNnlRV3NreWMxYUgzY2ZNMVNKUnV3?=
 =?utf-8?B?c1FuZXd6UGc1QnVKa2U0V3pwbXpSRG5pWldrMFE0WmI2V216V0dFMjhGYW9m?=
 =?utf-8?B?MWpCZ3N4QndBUG5XRmZjMzBKUmlkMnhZUzJoelpDSCtpeDM4Q2J0bTB4QWNq?=
 =?utf-8?B?Q0xrYytxcG1GS2ExN0ZrbkwrcDhDbFRaQnJpNHRDakxxVGFueCs2WnJFeHVu?=
 =?utf-8?B?dW9JUjdxNVZKZS9icG8xb29xdUJWZHluOWQrQlV4UDBEOTJKL2lXaFlwQTQv?=
 =?utf-8?B?NFRJNVVUQ253YmQ2c0ZaWm52SHpQU2lIOEE0ZS9tMFdGS3JETExvVWpqanJX?=
 =?utf-8?B?SWFaeGM3WEw2UnBiQkcxSGYrSjNiVmlwM3FweHpYT2lONm5xWlR2NWIwUjN6?=
 =?utf-8?B?QmFiS1d0eXltd1JpRmRnbGEyY1FuZEpndGRxSHg3bXdSdTFLV1pBOFdlbjdC?=
 =?utf-8?B?RDhCRGJXeldxYjB5NU80NXhwYnEvaFNrMVBuRksyTC80RVlMZnBENmZPcU10?=
 =?utf-8?B?ZWRkUG1Uc3hNcm1WTHVkaDhBNEQvd21xckExM0tOcVZ2WnBMLzUrTVgxeHhL?=
 =?utf-8?B?YXRuTEZyRTU4RnJwcUFxOUpjREhmUEtLYU4yeGc2SGxXWEo5Q3FHcDdMY2ly?=
 =?utf-8?B?VVNTbUFxK095QmVPYlJ6cStaN0R3NDFKK21VcmpQaURnby8xVXdnNFZaSE1Z?=
 =?utf-8?B?Zjl5RWR4TFlSSUJwR2NMR0lrcW1uZEpNZXJ5RmwvUi9paUtnc01sL0pabEov?=
 =?utf-8?B?Nk1hYU9sYjIzSzVtdWFWc1VWcDRiVUV5SnJmUXhNbTROQkVFUUEvZjVla3RD?=
 =?utf-8?B?R1BjMDNKZ1RQRWk3T0l6TWw5ZUZrTFBPOElQbmphTEdENTFnaXZhMCtwcTds?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7e1225-803a-459b-e2eb-08dd52c92eb6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:43:38.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J076G6V/RhvfCN0uv01Fi/Prp7xiIq+fzwe0nloV918cWqnJprup/oe+jG/HEXkoPBWjpcEFfb5bGn+IOJaoB/XI0V90JTjB3xp96A7wLTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com

Hi Dave,

On 2/21/25 8:47 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Thu, Feb 20, 2025 at 10:36:18AM -0800, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 2/20/25 9:46 AM, Dave Martin wrote:
>>> Hi again,
>>>
>>> On Thu, Feb 20, 2025 at 04:46:40PM +0000, Dave Martin wrote:
> 
> [...]
> 
>>> Having taken a quick look at that now, this all seems to duplicate
>>> perf's design journey (again).
>>>
>>> "rate" events make some sense.  The perf equivalent is to keep an
>>> accumulated count of the amount of time a counter has been assigned to
>>> an event, and another accumulated count of the events counted by the
>>> counter during assignment.  Only userspace knows what it wants to do
>>> with this information: perf exposes the raw accumulated counts.
>>>
>>> Perf events can be also pinned so that they are prioritised for
>>> assignment to counters; that sounds a lot like the regular, non-shared
>>> resctrl counters.
>>>
>>>
>>> Playing devil's advocate:
>>>
>>> It does feel like we are doomed to reinvent perf if we go too far down
>>> this road...
>>>
>>>> If we split the file, it will be more closely aligned with the design
>>>> of the rest of the resctrlfs interface.
>>>>
>>>> OTOH, the current interface seems workable and I think the file size
>>>> issue can be addressed without major re-engineering.
>>>>
>>>> So, from my side, I would not consider the current interface design
>>>> a blocker.
>>>
>>> ...so, drawing a hard line around the use cases that we intend to
>>> address with this interface and avoiding feature creep seems desirable.
>>
>> This is exactly what I am trying to do ... to understand what use cases
>> the interface is expected to support.
>>
>> You have mentioned a couple of times now that this interface is sufficient but
>> at the same time you hinted at some features from MPAM that I do not see
>> possible to accommodate with this interface.
> 
> It's kind of both.
> 
> I think the interface is sufficient to be useful, and therefore has
> value.
> 
> The problem being addressed here (shortage of counters) is fully
> relevant to MPAM (at last on some hardware).
> 
> Any architecture may define new metrics and types of event that can be
> counted, and they're not going to match up exactly between arches -- so
> I don't think we can expect everything to fit perfectly within a
> generic interface.  But having a generic interface is still useful for
> making common features convenient to use.
> 
> So the interface is useful but not universal, but that doesn't feel
> like a bug.
> 
> Hopefully that makes my position a bit clearer.
> 
>>> resctrlfs is already in the wild, so providing reasonable baseline
>>> compatiblity with that interface for ABMC hardware is a sensible goal.
>>> The current series does that.
>>>
>>> But I wonder how much additional functionality we should really be
>>> adding via the mbm_assign_control interface, once this series is
>>> settled.
>>
>> Are you speculating that MPAM counters may not make use of this interface?
>>
>> Reinette
> 
> No, I think it makes sense for MPAM to follow this interface, as least
> as far as what has been proposed so far here.
> 
> I think James got his updated rebase working. [1]
> 
> 
> perf support would be for the future if we do it, but the ABMC
> interface may be a useful starting point anyway, because it allows
> counters to be assigned explicitly -- that provides a natural way to
> hand over some counters to perf, either because that interface may be a
> more natural fit for what the user is trying to do, or perhaps to count
> weird, platform-specific event types that do not merit the effort of
> integration into resctrlfs proper.
> 
> Does that make sense?
> 

This is reasonable. You did state earlier that we should aim to draw
hard lines around the use cases we aim to address and I think one
way this work is doing this is by being explicit in user interface that
this is all about "memory bandwidth monitoring". This is not intended to
be a fully generic interface for all possible counters for all possible
resources.

Apart from that time will tell how many blind spots there were while
creating this interface.

Thank you very much for all your very valuable insights.

Reinette


