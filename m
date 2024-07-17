Return-Path: <linux-kernel+bounces-254604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001093354E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EA7B21F53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00F3FC2;
	Wed, 17 Jul 2024 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNMqbmub"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9CED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182116; cv=fail; b=TBUsFzEpOo9MTciZBB1YGEPRHcj1V96O/nAV+oZ1ltbdVfegQE7vVfyJthqrshscOIBGs/WiejIKmImTe+S//ai8NFqzbeFaS6Gv1HV1mysOGP3avM0QxioWkRwtpy0LU8kN2I0Le7XTa4l36DUg+VCQNMKhNs4+BSd7Py3IE0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182116; c=relaxed/simple;
	bh=lIWRymtjbpLFdFXaNpNHOLTZDbO0z3sAQ+PZ1UZjAdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4BbP7jlcBVKYdwEt3T1hMbDJS4tj2Ws81MgPBZ664qOiQ7ZffYT9p/8/wAwGhO4BCZY2VMkmYHuPbcQPuwp30gc5SlfORFn8nx7BQ74R92IiEiH5ExLRILC3kYzUzcXxDqU/qJyhyreg+HQHRFh5yrNcub2ado02K20uLQc+q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNMqbmub; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721182115; x=1752718115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lIWRymtjbpLFdFXaNpNHOLTZDbO0z3sAQ+PZ1UZjAdg=;
  b=YNMqbmubJUTsDwZOSa1b6tx4e7o78eTRxmmbZEevF+2z1HI5/gfIAlIH
   H/Ew556QVeXc0CHp5tiA5obtWr5pz7LerxOGK4NjyWc+bN7OcsrEbHv6T
   LJ8J3gH+OnTSPKPkUZt/AstrXj4jkLjBynwzoWeWFbTEcyafvdQF8iuiT
   hig4RxiSZQExb9g5BADDuYu8MmMnNOWI4E6Wn5P2//Itag/gbDWPZTjAg
   nXMTaJKJym8kuBg9iQx4bKFFms42iYgakCKlXbZTD/BjnRxNQ3mCByidp
   KPPLvDF1/z22OCY92DHZ973Tjm1FbzxXm51DqghqzIHEc2HyN4hkbIl+r
   Q==;
X-CSE-ConnectionGUID: BDlw9ioqSJOCL/j7CIbr3Q==
X-CSE-MsgGUID: ufZGOUsxQWqjkjfTH6kqHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18852492"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="18852492"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 19:08:34 -0700
X-CSE-ConnectionGUID: XhSasG0iThGEAE6AQAnujQ==
X-CSE-MsgGUID: ML5QVeWpRvKLm3hFF/CYzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="81268275"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 19:08:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 19:08:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 19:08:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 19:08:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 19:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z25CmSaV+qxR2W4eBVrC+TdfV98HTYGGIvtSVBQ+c4g+cIvq3vk5lNCrBF2UY3mawaIa+pKtYfH0QW9CFIf8DvITXx9MUvH2R5wKTHafCS60zVbUMDrIKWLJEY4PE5E/fphVZPfPSjkWMflPScnwlRHke4NDgNU8onhHibW3QW9C25Cq2cUAz26xSfZ2viEY2YVwP815S82O0e/3DRCQ5EYasdjD/F36qM4Y3rxNpDDDgR1BD2Uy+nPI4yIr9BbzDSHnH6KJR6RIDzvRg6WZzplJBmhk+AiMs6w6I9lx/pz6A4k+zBlePiRVadZ/Nkcdk8OYgy5bvJff8DkyOEIK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zZKIZm/NSbAYNYvgotc8ZOYavS6rgE9hENehyhk+qA=;
 b=uGt0DaVeod6/lHA9dMJwjZTWjnobBJ9kmh2NuOG1bKnfcuZlLOXgwZV0skDh0laySOBEegLq16NmOiVeY+VTfN+mpfrEiG3SDE7Tus0q1v4YEOO9jIFjW8JsfoK7LPaBHx6CWbsLY1+GQXQ91gy/5ZZVhqUdwbL87D86+OhRpWXN33PmN31bf7wkJ9wpthtzrV+P53eXfn13q4we7kL2B2MqNT0RUF90uxNiEOEC90RW/S3q5vrSd9p/3+xyQb4ipYxbY5pF32EjqeBFrNJeTu2Piiu/CmkfcCb+G7eyxUiOH15kMF0AGLqpZOMuYUpleSG66FZIVPDV4I9EFar5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 02:08:31 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 02:08:31 +0000
Date: Wed, 17 Jul 2024 10:09:13 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Hillf Danton <hdanton@sina.com>
CC: syzbot <syzbot+4c882a4a0697c4a25364@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-use-after-free Read in
 handle_mm_fault
Message-ID: <ZpcnyYS29p/Fud+L@xpf.sh.intel.com>
References: <00000000000037cdb0061d5924b3@google.com>
 <20240716115504.1136-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716115504.1136-1-hdanton@sina.com>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d19dd3-9064-4263-9708-08dca6055acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BIW4cExw0O90s7dP5XvH0PtcbE6bQIpO2I8zXJyAELkI5ll5X2gjRQC+3Fvn?=
 =?us-ascii?Q?JvMQQEbRISW6PRBkVxQgy5j251qz43V3wfmrF8I/8gY88G6MkcuN//kkCeua?=
 =?us-ascii?Q?hsJMbQILtmQ3LEFewl9HSxrEeyNmRaMuV1Z42k0w3zr1qQVsbzLnKFvUUsQT?=
 =?us-ascii?Q?9G1OPPa0J1ltDS6DTfwUcaGxXx7RoirtTYxxYkpHobC8MuMOogZDQXusJCau?=
 =?us-ascii?Q?Wec8H4r4Wohp4rsgJJTO88mPdZ1aoIUfdBCjJ5eT1R8iPtrGJU1VPjvVGCxJ?=
 =?us-ascii?Q?wChtMCVzotNFMKdjUSlSnUNVa9S6uGutFtIFw2fywV5BVeZKsknb82FcaGO3?=
 =?us-ascii?Q?H9VxaISkzdp0aPZFxxtTKwf991691LRPDe/lfp/Sf6fbmuBplRh3HKmxHf+u?=
 =?us-ascii?Q?PAt73YGh2LwQqlfc1S4AqIucuFec90X7CyGOVQo8hJZnK4h7QOz8HWFnJcTc?=
 =?us-ascii?Q?fzpQiHAwJcLMK7CA0GBl/XsM4HDB9Bl8iDLDR+z8osbRH+ZEfdfG9d/TQz6k?=
 =?us-ascii?Q?VyGkcY/aEhgtQ/bt8N8alUiENFpMuY/c1rvBBeg4maTiRI7rCbqlcAhlhxOR?=
 =?us-ascii?Q?eYHelAkYHXOzOP0pIgLR9HeUmSaBx7nePoujsfK50A410a4VRqS7SE2zzaPv?=
 =?us-ascii?Q?N6tnUd4lzdu96tLFzwW6R/KvQSfAocRkhpJ1n4U1G4YZ7rCjP2E9VDoQZGDo?=
 =?us-ascii?Q?PGGmVVPFWIOC63eEPLuGEPSrLHCyusoMSUTi80rGk8J3Vh5BGRNimDA39/fv?=
 =?us-ascii?Q?jYJvIxp5vGYcKCUp9Ml5Yax7i5ZIF06xemw/O+McpeMigHnFg76IKY05Y1BO?=
 =?us-ascii?Q?Z99S5FatFIuqk0FA9i/ZuiELLlyIVsdN99O4r7Hf1p87u3jgP/P9Xe4IN+D4?=
 =?us-ascii?Q?kGlkiUCeR67t9dYqd5X/wi65kv9I8QPG4roTEPqEBFQSmNOEWon/XPAxi2ZF?=
 =?us-ascii?Q?9lvVSdI0uOf8oUj5AjMeaiFBdCRAMapcGkYg7pB3Jf/PiLZcIUVU6lkcxoOh?=
 =?us-ascii?Q?i6fdts9ijLGxcC0rVrI1Sd3WdyrO6fdcDFHyBYT+jXSHc9dLT9PXl74ty2FU?=
 =?us-ascii?Q?RwIYU5OtvtocMkOu66cE6F3+mJzxU3UH0jvNc5aMGi92kXnE7cVoCpMasKLY?=
 =?us-ascii?Q?R/hlN+aelCoElx5wDzdufoc2r11RYm4ZuTPfUAHN/C16l1B7L5+P6Vk2gvlt?=
 =?us-ascii?Q?ltZJMPiPoOeq9zjEqpLZsLyg/8ktpTIOGbjUn37wqhjnRuOrij7WA7Dl+VcH?=
 =?us-ascii?Q?BVd7Y7FWw2K1fFjVoEaR9kMj9cL5igL1vVZgbjK8pkRLnrN/q6ZlNt5g47DW?=
 =?us-ascii?Q?aSU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G6HxLwI3e3qcesKWP6Ihz6wAOP+RmvC0NpyNFxth8/dawKHP82n5nJj3fIkI?=
 =?us-ascii?Q?kZrBTf7bHxfMjtuIeBBUz/X+v3oQPS1BpXYibsLffTTMyg9ez95wJIIfdL3+?=
 =?us-ascii?Q?Fx6p9BlkxLcQIpU/EXo+2PLdj+2ZP16listOw9KtbCpG96mkhrWMpBS7CV8n?=
 =?us-ascii?Q?lSloos/4dnxHC3L2wDGayx93iyPxARXnvNVd/Fk9K+xvp72sWuOWW3xLajIW?=
 =?us-ascii?Q?zz8aUXYKaiXD6GhUkBDAZ3HFqUqQn17HTAqVaaCNox4Bn5zo+/32e+pA0YWV?=
 =?us-ascii?Q?BKpUv7bqNDZCfb7TUnj9wlnPH3VsQrPfQcu7Kt+73GAuLkx6WyluU7WbVHTs?=
 =?us-ascii?Q?0SPIhx2S2LmiqDd2OwIFuJklFttsNXz/MMG50Bv2SjaKI2ylpnJBpS/EZxq1?=
 =?us-ascii?Q?phzJ6UWbXd9vJbwchdecDw5RMdZn+ttD1qbe50OD60Na4HRQWPBuEhzDV7LR?=
 =?us-ascii?Q?Cpt807/T1oMPSehgs6ZBv0g/D1bfrCPMV4sueh6Tx87hRZRlnAcjiYcKmE24?=
 =?us-ascii?Q?hV4HKzihaNdcYXnTM48n0mqJ93ybtEQeyNJB196LGDoT/Ri4Bv5R+uswV0y+?=
 =?us-ascii?Q?UgChkjiru8POjwIlAOGR1GSJ7pcOcTfZKh1tUPX41HBsvo3Xrc5eb4zGFXew?=
 =?us-ascii?Q?Xnm3oyuBAdPkwQqfii3xUyMWhSHYYMbotUZ2Vl+dFD1oSugsbYR9oER23CMJ?=
 =?us-ascii?Q?1ZxBti/Nqkh7Uprcy/NMTeuqz4B+sitKzmXtd8HwK8/IGkBF9iTk49oCWlfV?=
 =?us-ascii?Q?rAWbE6Jqc8LpfUfLvkn2ZcqUylln/ybSv1VNnG4FvMA8vSNIsrUcTjo6Cy4t?=
 =?us-ascii?Q?gXmYuu1PqrJpVZb1Lw2PsoQJS78YlJHn9qoMRjMx6rL4FYkbrFyR8mIgvjZH?=
 =?us-ascii?Q?xqXqtwQWY8VmhNbqk7VIG541q0LCfccVa1L8vZ+D5fz1MafnP7BgeaWJVyPb?=
 =?us-ascii?Q?N+hRE95dtdNhzYRdrr/wMk/q5pULtlsfWJW7JMBVcDTS6zdUXph1ytH/DT3b?=
 =?us-ascii?Q?eruCvpbWuF85JMNZidh4/0j/3Z/xPf9yj7w3xj6J9g4T4IUsPlddogunOqYD?=
 =?us-ascii?Q?ZFoIbNxL3H5bYki/MHWEIUeQrI6KRhXAn4j24RhDWrVW2x4TQzHJHqfxIhv+?=
 =?us-ascii?Q?Y2qSXNqBJRyAQ6l22YsVRTy/dCw8rQhnTTKB7rrErTkJFi4nXneVoCcW0rlI?=
 =?us-ascii?Q?UnLpxZjVZmHFZqXnersloGxKjmj4ta31u+FHNKEbqmYYC4DoCy17vJ6PQQoZ?=
 =?us-ascii?Q?CDFrrvNXBWC5aRQoyw2ygdP0kUO9sGOtzkDmCW97279vOHcDhMXMTGqt5+YO?=
 =?us-ascii?Q?WG4XbVLShHaHlV29kefwUBMx2oEPOgVI+eTLzzrmAPrJqvohj7+eMhHNVbMP?=
 =?us-ascii?Q?VikCrRUC+m5kadH9CU8t3/8mltUAFMYVCV1GwlGXRQbCPUkndvcfMLdUHx5Y?=
 =?us-ascii?Q?6xEN75gBv7hzIC2qqBwf/lpMuQEmdciw2qAC2+X+ssG6t0w0+a+seAv0EmvY?=
 =?us-ascii?Q?lxsknuH+qQQlM+fGt9jbyd7M/waIAFUR+D8ie4Um9h8yahYbxiV9KPoQ41J/?=
 =?us-ascii?Q?iNf4XD5Cm2aYP/vVd4lMJXOdVYNhEowSWH9m5d2m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d19dd3-9064-4263-9708-08dca6055acf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 02:08:31.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrklWdcPfhOmo/8aZjY4NOIeEJmJmJ8MoyGFHmVWKClwcEedD/1EwrQqEC1uaZSoIFRd7C7aJl4P3q3KhJu3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com

On 2024-07-16 at 19:55:04 +0800, Hillf Danton wrote:
> On Tue, 16 Jul 2024 01:29:17 -0700
> > syzbot found the following issue on:
> > 
> > HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
> > git tree:       linux-next
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ce3259980000
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  3fe121b62282
> 
> --- x/mm/memory.c
> +++ y/mm/memory.c
> @@ -5808,6 +5808,7 @@ vm_fault_t handle_mm_fault(struct vm_are
>  	/* If the fault handler drops the mmap_lock, vma may be freed */
>  	struct mm_struct *mm = vma->vm_mm;
>  	vm_fault_t ret;
> +	bool droppable;
>  
>  	__set_current_state(TASK_RUNNING);
>  
> @@ -5831,6 +5832,7 @@ vm_fault_t handle_mm_fault(struct vm_are
>  
>  	lru_gen_enter_fault(vma);
>  
> +	droppable = !!(vma->vm_flags & VM_DROPPABLE);
>  	if (unlikely(is_vm_hugetlb_page(vma)))
>  		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
>  	else
> @@ -5839,7 +5841,7 @@ vm_fault_t handle_mm_fault(struct vm_are
>  	lru_gen_exit_fault();
>  
>  	/* If the mapping is droppable, then errors due to OOM aren't fatal. */
> -	if (vma->vm_flags & VM_DROPPABLE)
> +	if (droppable)
>  		ret &= ~VM_FAULT_OOM;
>  
>  	if (flags & FAULT_FLAG_USER) {
> --

Should fix the following commit in next-20240715 tag kernel:
"
f73fad23fa mm: add MAP_DROPPABLE for designating always lazily freeable mappings
"

FYR.

Thanks!

