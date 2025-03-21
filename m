Return-Path: <linux-kernel+bounces-572065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C926BA6C615
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18907A94FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E318922B8AA;
	Fri, 21 Mar 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hV+IQrqu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259828E7;
	Fri, 21 Mar 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597422; cv=fail; b=OOzdnKwuLRgx21oVAtK9S7uyYdbxDhxzN7+B9EWObOjWe4bx0wKul/biDZ90TtsYR8J+P5iIhrFblMulNhQpZG/b7mYeyU5F6Fp60CdK+mGoqE/cXK0y+VSvdhmso977LZYvQpEHoYIlRixz7/RkENgUu4avgGSTvEJ2YQEYTok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597422; c=relaxed/simple;
	bh=GmwmkLkPGV3UWh5SzHdAZcgLuGaROUpr+ANFZPrtSoI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TjVqhTgNsQT6ad45DECm+j4QDLWenDjhykkII0qu2jHWnMXajKkgkUSlOagBGJlqOW3dqfH1ndntLniw4BAhyP1hP7pNG1H5orm9FjXjPqOx6Yc/RLFqrvqHR7rGXHn2iQ9LEXroE2JszyIZtuUgrjKT+b7hxBqiDpJs0ABtt1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hV+IQrqu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742597420; x=1774133420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GmwmkLkPGV3UWh5SzHdAZcgLuGaROUpr+ANFZPrtSoI=;
  b=hV+IQrquUwbWxVsg5tpqC0E8Bs18zviEb0OhJR/Takpc8AJidJ9OHyhH
   vgEjzISgdJ6wpH77v0Gt92QN4yoE8nBXGLAF6jaWnknX/3dJ5w5dFweVx
   3oYxOpBY1XwdAVl6fchtI/QUZQOCFnD3T+NnsRDWpYxq/m65qyqfxdnsh
   rLm5V2rkqaSXVK+JyCFcLAtJ9JQKyCqAJKawr0y2+VcE3CRIyKYNcQhX+
   Qx7ssBOGOt2qRjW4H3KpSO5DoT/SQSbIyI3N6RCuwUd6koH8v7rHiGgEL
   Xhan5xI4F+S7AGWqi9hwR7XtmrvcwLOzo1M3fMac2xhfDb8cQTz0c+aF7
   A==;
X-CSE-ConnectionGUID: v9OxLaAtRz6HsJu4IjGf4w==
X-CSE-MsgGUID: OBNqOPV9TPOJ/nz96xQWhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="61401237"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="61401237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:50:19 -0700
X-CSE-ConnectionGUID: ZHWeILpHTtSuiRaWuMZ3ew==
X-CSE-MsgGUID: eEylVfhMRni1XbVmhyrhSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="123490444"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:50:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 15:50:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 15:50:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 15:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3CoeGMFC+yRRB64bdYzQtemuMw8HDSSfyDZBgeB6qHy/30uIj4axF5avJJuqxQSWo2s0WvrWhxf1aTLSsdx5y6L3kTn+QGu99/VRsOpn6Ob/ONL3WJDMtEjWCnAqI5Y07bek9fWlwUyDRAewq3reulNIoj5g7goxc3R2vBJUMKXMnAbHVowCy2mxHIMucZsQiyfKiEOBSp8ARjGKujO3u9twcrx8OnLDEoouoklb4jyffDyhANq6WAa1kat7hpsMkGmOzUusTO62wbPcWIpf89EEXHcVecb2ZFLEAgq313mvSAb/O3nTbXjKq+KF8puxU6hGr8avlkzfRYzt5CSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FeJ1me+LJ/L9lSNHMFyRH8wnGkYgyhi19jBHfkkvW8=;
 b=TPjQbWhhPj0lz6PWka7NcqoKcgcBrqO7jaHJDrvgtGL/faxpPc04Z21zqr4s/ci0zWhGQilE1p0gRhF6sRjr4DdLlV8CsxDWCNauFOLD+gmMK6bnTdVs2N97yJKfYiwWag1VZTXn0Q9feu0iV3bWj6hwGNVeSpiHzbpXcNLr6Cu+2A9g5jLrRbvQZchnCOtm4oP9HwMtHIFZa0W8ZnW/pnDz1Gi/cNHMxYxcaeciidXK9d0YmAU1/E0ueC1Os15PB+XYyyrlKI4rTaW6i5FL7SuFTGPhMWwZ8F8gJEK/dMCgT9OjASPs9FbZNsLE/JM2pzIoYNy7GhOPUXKjNNLVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 22:50:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:50:11 +0000
Message-ID: <7c135464-d859-459b-b86d-e8c18f106fc4@intel.com>
Date: Fri, 21 Mar 2025 15:50:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Support L3 Smart Data Cache Injection Allocation
 Enforcement (SDCIAE)
To: Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<jpoimboe@kernel.org>, <daniel.sneddon@linux.intel.com>,
	<thomas.lendacky@amd.com>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <peternewman@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <corbet@lwn.net>
References: <cover.1738272037.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1738272037.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0274.namprd04.prod.outlook.com
 (2603:10b6:303:89::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: cac537a1-4d17-4a3b-7bf7-08dd68cabc81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1ZVMTM2L1lJdTNScVN1c0F2MHNrZEtzL1NTNmRaU3FvQU9IaEN4UW9MQUFj?=
 =?utf-8?B?KzZsdko4UGQxdlFZRGhqMHdaaWdHN3ZOcG13S0ZuL0ozUGxSOWdiTkFjNERF?=
 =?utf-8?B?Tk5XUmxneW15QnNBQ2hPTkt6UWgvZHg0cWs1NE5ZdGg5N2M0REFFWTd2SVBL?=
 =?utf-8?B?NGhKT3VYUGduVGtlTWp2VzZPb1hYSmFLMloyZGVvYjllMlNQTUNGN2dnU081?=
 =?utf-8?B?NFFGNHZ2S0VqWVF1REszNkh3WjZ3WXIraVljcHIxSkZLaGpCN3B1R2lUSlRq?=
 =?utf-8?B?WlZKWXVnMHFyZ2ptRVF5UzFnUmpldCt0MXZ4RmZ5aEswN0pBWHdVeG1aemtq?=
 =?utf-8?B?NmFzemZtaE9ZQkcrMjlKQXhXKzB6U2NjWmVHZFdkbjY5TkxUMWhBSWVtelVn?=
 =?utf-8?B?amFiNGxaNkQrSWZJazVYVnFyQUZ3RllaYlRmdlZmS3pXWXhoeG1QSWxIWWM1?=
 =?utf-8?B?MHNoMFdOd0w1K2VLSnZINkFhRkl6cUVrZUQxZ2hUZDBUUnBlYkxVdTJOVCtD?=
 =?utf-8?B?MGZEa0dPUm9iOUJYd0ZqSWgvU2Jza3pPN0hvTkJ0cWhVenAvcGpqN0dPL3dB?=
 =?utf-8?B?QkpJMS9DTXAzS2dQOFJ3Y3ZqOXl3NTkyWDhoWnhwODVGeEtYMDR4T1l5bnJu?=
 =?utf-8?B?c1VEYUpSbUtEVTJwY1dWWTVKQXhOQzl2MXd6Rm9WWTBpdVA2WjFDa042MC8w?=
 =?utf-8?B?TXdmRlJEZjltdFM0N2Z3dGRPZmduLzNqaTZVeVdqRFYyQU0yL0xvVVd2NThV?=
 =?utf-8?B?R1lVZkNLMnIvVndGNkgvLzNTajcwWlJYdEVLbWNMbEJDeERLYXNsTnU1SUlk?=
 =?utf-8?B?SzVSL2xpYXc0TGg0cktlMTJzZFA5d2dPNFNjcko0c2pMRDNYWXlOZ0xWT3lh?=
 =?utf-8?B?Y2RpSVhkSk55MjdDbkJMSlRYNFRRZHBVcmxZTGlXT2VYYjJUc1dyck9ZYmRT?=
 =?utf-8?B?Z2p4SktuelpWbitqUit3MkhxLytRVE5sZFhrZ291OWhkWVhTM1Zqa1BDZlkr?=
 =?utf-8?B?ajV3QlpYSDVEeXlKZTNPdUFBOGg1N0h6UnBXa09aSENjdUlvRWV1WVhjUUNS?=
 =?utf-8?B?a2x1YUJ4TWxsbmRVYzVUdmFPOFBNaTE1dy9HT3Q1aEg1M0Npd1pUeFVLd1I1?=
 =?utf-8?B?WXdudXFxUTVBV25PSGh5VlVHSENjR2I4SzJNVG4wTHdGQXNNY0dTY3lDT1h6?=
 =?utf-8?B?UW13VGtMTUE4WUhmS09TNkJyNjRlcGxoMVEvQmNZYlVMK014cDlWdEVleW90?=
 =?utf-8?B?NnJtV3VBQ0JkK3cyOG1NSVNPbzZTc08zZlUvSzk1QkF6YnEvaGtCendKRzFZ?=
 =?utf-8?B?WVV3b2JKRHkzWmdZemhCVGJRK1IwL0RiMGdBcnphVkl4cDBiOGhCeGFQL0FC?=
 =?utf-8?B?S0JVYWFDTjIyQmtVaHcrKzloelZxT3oybnBPai9zdFcwZ1VHQ21zSWdvcmh3?=
 =?utf-8?B?UDJoUEM1NFBucEZ6Y3Vmb2d3cEVPdXRKMlBUQmI5T2FINlRuaDhDVk0rck1v?=
 =?utf-8?B?WW9FcjA2TEpJN1cvYWgrZDZzUjFiak5EWjkxOStGQW9tNmV4NXFKTW0yN0pH?=
 =?utf-8?B?TnZuc3dJQzN5OXVha3JYRDQzOHFydWlQWlBXR0xDdC9maXhxSE5ILy9DdUxu?=
 =?utf-8?B?dEhsa2gvaldkS3VmZmdoRU9RZjNqMmJ1OU84akp5YlRTS1pwSHA5a0lWRzBu?=
 =?utf-8?B?VGJCY1NaeER4eFl4VitOMnMxRitkZm9zMUdOUTZHOHhkNVNwTlJpWXdlT1Br?=
 =?utf-8?B?SU1XUGUvdTQ4bkVsaitvbWlkYTkxOUNPNTRGY2VXRm5ROHpURnVVaGNIbjZO?=
 =?utf-8?B?SHJHSVBBSUR3OFFHNWdFbnM1aGV3ZnFCay8rN0lWeEpkSCs0bS9EL2x4WldF?=
 =?utf-8?Q?IqSklAN+0f7vB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mys4SlJxb1c4WmlPQUlaWUZTem9hdWJXMWRhUXJXd1BsTnRTL2NrSVQyTnZQ?=
 =?utf-8?B?MHUxSHVjdm1FNUdGWWgyS3dBUnZnUlMvQ1hiaXRWWFBuN0xLZEx2cERIY1VE?=
 =?utf-8?B?UjhaRHJKNnhjQmxabm1tUlIyUDU5NVA2eUZZSzVKMEh0L0xnVHR5LzdHZmZo?=
 =?utf-8?B?emNQck5uMExRa0RmYUVISmppb1V6UU1LR3NSd0JIWmhLRkd2ZWMvQm5UTmF2?=
 =?utf-8?B?MW41RmZQcnUxRFpaTWRXZEtGNGJSaG11ejI4NXl4akZORUtVRGRkMnlPd0Ey?=
 =?utf-8?B?YUtWVlZja1ZSTXBzR1NDUzFUcW1QZ1VmYkc4Q3ZzWTROVkU1TVYvZVYyUktQ?=
 =?utf-8?B?YnJEeDVkellnazlyMHNTM2R2NlIvMGJIazdUaWxzU2F6U1JoY3ZXU2xadWVr?=
 =?utf-8?B?bGNvcWFEY2hKOUN1QzQrZFIzWGd1RGludUdMVXp1cEpuaDZUdzc2SFVES2ZL?=
 =?utf-8?B?L0ZjZDRQSTRqeHpSWUlkMWs3VFdYQVBkcTZlS3FiMWVsUnJuNS9OVVArKzAz?=
 =?utf-8?B?N25sYlEvZVRKQUZjM1hqdlE4S2RQUkgwckV1YnZ1c3BzN2NxcHRab0xyWVZB?=
 =?utf-8?B?T3N1MHZSblJqL3orMkltNy9LSER6QXFOWWtPRVNhc04vZVB5a25VOFpnMkc0?=
 =?utf-8?B?V1RJS1BKMnkxYlM1VXl4dE5VdUVtbmw3ZWhma0MxK0RzRzJWbXBsL2EyZUI4?=
 =?utf-8?B?cFd1bzBWcklMZGtjb29jbDc0aEt3ZHZGYlF4Um9rVE1OUEcvZTZncTJ1ZkMr?=
 =?utf-8?B?NlA0dmVSdDZlUWtvTElRQWZJSHZXcVdxdHBZeGMwN3BoVGljTTJxajE3MVd0?=
 =?utf-8?B?dVd0TW1sVmU4dVNRZjlpNXBhZTZjcmFSdzFGak00RjE1VTk4VVp2cGVJWjFP?=
 =?utf-8?B?dldrUmNzQzRyUDZrMUowQ1crMTJ1STJveFpOeGp0UEdNM24vSldJSlhlWWNT?=
 =?utf-8?B?aHA4UEdSeFlFZnYyTU84SVVIVVpSUk03Rk4rTlpTMXAvR09oSXREc25xTCsr?=
 =?utf-8?B?aEM1RTZuL2l0SG1IQ0tXYmJwYzFkeHYwK2hsZ1Q2ck15cmNaNnhramxvcjRq?=
 =?utf-8?B?Q3ZEZXM1dzQzdTRoWXVJSnRVZ1h1b1VZOVZTUDRIaHVNRDJIcnI2aVYxaFdE?=
 =?utf-8?B?OWdmcmJHdmNqMUROOEk5QWtteWpaYUlySDlHbkU1Nk5ORXVSWXBMYjNBWWti?=
 =?utf-8?B?bDhMN0Z4TmVJTHgvMi9TQVJrQ054Rzl5UU9CT1J6WkZxanFHbzduKzliNU5R?=
 =?utf-8?B?dEZ5OTE0ZS9TUHI0ZlJpWkd1RGtSUmRIalNRMGFqRUhYdm1TVjNDOXlEclYx?=
 =?utf-8?B?cktYUGpaRmowUlkxOW9KZ3F4Y0ZkRHpPSzcyUDRsdnJVV3NTdWN6Tng5akxE?=
 =?utf-8?B?R04zZ2Y4ZXN0dmlSL2ppQy9BN09HQVQ0bkN3RnJoc3AyYlJEMnZDSTFpNnZN?=
 =?utf-8?B?WHNoTmVWUkRlQzU1YzFqdEhmVjd3eWw4Wkl2U3psRWI5cGdvQVNCS0FIejJj?=
 =?utf-8?B?YUhaenMyNUNaL1E2QzNUUU5tY2FkY3VRRTRBSUlVdkx2eFphaFJqM2htSkRo?=
 =?utf-8?B?MDMrb2x5WlBOMUFaRVY0Ym12SHRxaHRuYzVTcCt3MXp3a0ExejRiM05kOWZo?=
 =?utf-8?B?THpKVTBZL3d6cGttNjNUTWZrbUhZWFR4SGZUcGgvaWRJS0RrclNEbitTdFR2?=
 =?utf-8?B?K2h5cWZENmJ3ZmRhVTZFZUJqQ243ZmtKcmphYmlEOEpmQWxyRmEwT01IMjVi?=
 =?utf-8?B?QlhuYkFHUmVKTFVBZ0hjQ0JKbU55c3JUM1AwQWg2ajMzMVBUa3JTYnpIcDVj?=
 =?utf-8?B?N1A2Z2lOQXZOSXVHS0hlZzlPTVNKbElUbVBNUjdIYVhrZG1GS3VSdVNveWdw?=
 =?utf-8?B?WXNua0hTemc3U3NxMGI3ZkNhWlpqeDZUN2Z6S21yTTlFT0hXQlpucnpMOGFE?=
 =?utf-8?B?M29YNy95OVpqakl1OEI2Q3NIQTY3ZXI0S0NGZTlyS3BKTDRPOGdVMTBycU1m?=
 =?utf-8?B?MXU0WG9wM3RlTko0SkN1dFJpa016ai81OUI5RHZVZU9MV2p3MldKbnJ3UWFr?=
 =?utf-8?B?VkFLRmZzSkJBcFF1Mi9aSWtoZ1pCN3RDZGdHYUliQTNhVEVrNTUyNW9qb3V1?=
 =?utf-8?B?ZEVEbnVyMmtYN29udzh1cXlrYnJtMDdETC9hS0l6YkN3NnhJT0FGWWNxY1VS?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cac537a1-4d17-4a3b-7bf7-08dd68cabc81
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:50:11.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9NJbWGCa8iYJIkdmMYHOcDraM6MEKp+KeO+APuAk5cygSyQmAHRpCUwzb01is1501BK3rzxSAf2bGcflOv6c947mvOJznv2s56HrtWuqYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

Hi Babu,

On 1/30/25 1:20 PM, Babu Moger wrote:
> 
> This series adds the support for L3 Smart Data Cache Injection Allocation
> Enforcement (SDCIAE) to resctrl infrastructure. It is refered as io_alloc

"refered as" -> "referred to as"?

> in resctrl subsystem.
> 

...

> 
> # Linux Implementation
> 
> Feature adds following interface files when the resctrl "io_alloc" feature is
> supported:

Please note that, for example when L3 supports io_alloc but L2 does not, the
implementation also creates the files for L2 (since it sets flags for all
cache resources). "io_alloc" may just be present for resource that does not
actually support "io_alloc". (more below)

> 
> /sys/fs/resctrl/info/L3/io_alloc: Reports the feature status. Feature can be
> 				  enabled/disabled by writing to the interface.
> 
> /sys/fs/resctrl/info/L3/io_alloc_cbm: Capacity Bit Masks (CBMs) available to SDCI
> 				      supported IO devices. CBM can be configured

(please use imperative tone throughout)

> 				      by writing to the interface in the following
> 				      format::

("in the following format" is not followed by a format example as expected)

> # Examples
> 
> a. Check if io_alloc feature is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc
> 	0

Considering that io_alloc will be present for resources that may not support
io_alloc I think it may be helpful if it instead display "enabled/disabled/not supported".
User space can still interact with the file with typical boolean variants recognized
by kstrtobool()

> 
> b. Enable the io_alloc feature. 
> 
> 	# echo 1 > /sys/fs/resctrl/info/L3/io_alloc 
> 
> c. Check the CBM values for the io_alloc feature.
> 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
> 	L3:0=ffff;1=ffff

Is it expected that more resources may support IO alloc?
In above output the resource name is redundant, but if
more resources could support IO allocation then it may
be more intuitive to move io_alloc_cbm one level up in hierarchy
and keep resource name in output in order to potentially
manage multiple resources. I do not see impact on feature
in current design if files are kept within resource directories,
but in that case the name seems redundant.

> 
> d. Change the CBM value for the domain 1:
> 	# echo L3:1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm
> 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
> 	L3:0=ffff;1=00ff
> 
> d. Disable io_alloc feature and exit.
> 
> 	# echo 0 > /sys/fs/resctrl/info/L3/io_alloc 
> 	#umount /sys/fs/resctrl/
> 

AMD also supports what is exposed to user space as "shareable_bits". According
to APM:
	Depending on the implementation, some portions of the L3 Cache may be
	shared by other system functions or used for some other purpose not
	under the control of the PQOS feature set. The L3 Cache Allocation
	Sharing Mask returned by CPUID Fn0000_0010_EBX_x1[L3ShareAllocMask] is a
	bitmask that represents portions of the L3 that may be shared by those
	functions.

Could you please include what (if any) the relationship is between the CBM
discoverable via Fn0000_0010_EBX_x1[L3ShareAllocMask] and the CBM of 
"highest-supported L3_MASK_n register" when SDCIAE is enabled?

On the resctrl interface side the documentation currently states:

	"shareable_bits":                                                               
		Bitmask of shareable resource with other executing              
		entities (e.g. I/O). User can use this when                     
		setting up exclusive cache partitions. Note that                
		some platforms support devices that have their                  
		own settings for cache use which can over-ride                  
		these bits.                             

Even though this was originally used to expose the content of
Fn0000_0010_EBX_x1[L3ShareAllocMask] the intent of the content does
seem to also apply to the "io_alloc" CBM also.

I also expect "bit_usage" to appropriately reflect the io_alloc mask.
From what I can tell SDCIAE does not enforce isolation between hardware and
software use of these cache allocations so it does seem to me that the
existing legends apply. 

Reinette


