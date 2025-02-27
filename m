Return-Path: <linux-kernel+bounces-537527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF8CA48D02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61170189094B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0E272912;
	Thu, 27 Feb 2025 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJLt6QKn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE093C1F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700735; cv=fail; b=l/z3nQ4o9HIMnDJGkXGDmQwZju4pM+NpJTL4e3guLJIZIy4zxI6UcvpIJHe4DDCGMos6f7P9l2gOhw9UO3qEjOex1dCcXjR9su2kZjd2A9P3EXiKumH6Ad1MLgi9d9M+ugH+SQGWpB9Pm2GET+91uMq9TOilrCfRN00BM0iJuD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700735; c=relaxed/simple;
	bh=OOZaE7Z5Fi3WZMLTagxONkegA6ue7R5KBuue7pusXD4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWPmdLOre/6ijWkFniLLaKeCKP0CH0TpyEZmlrRajNJ57VM/waYjOP66Q+YSwPpTUTUW9Ez+ji1DRfw3gAVGh0A7J7vyOXEvPrtGTIIAU0CxgplOm4Izq42qkR6QoIjgkZgzXfF4YYkhX7jhMsXJwyFOfvcjjBaN/5qfFejUhW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJLt6QKn; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740700734; x=1772236734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OOZaE7Z5Fi3WZMLTagxONkegA6ue7R5KBuue7pusXD4=;
  b=aJLt6QKnUNIO/jvcB6cSK9D+MrMZiAiZ0Y6hY57lTBBUEyhCG+6mrUFQ
   bVeo7RbuFbH6LfzveA/jEWKzz5T4nC8b/FrXZXKjLQm/ECNrKvfy7x9SB
   9rvii8vfZx7x2S8Wc6VR8jSK4Wvko8IZ/44ML6/Xewm3G+MB4QYd1B6O1
   xRKwy5la4S1CeyvqW50UKzWp5A3gZLBW3mRlepLRxBDyDrroBW8XHtFVr
   DjBEL7GIf3SvVpp8wpSqdLSQNESR//Ds7zdXTEgJBypxGTdyLHOwAhIW+
   Gcbn2aEc0WHIR/s4RCMgaCgfi4KxYjwabCk1FZCTVH6mMwsjhMJvj4awV
   Q==;
X-CSE-ConnectionGUID: GcYDRzlvQrCR4M/iFHUWxA==
X-CSE-MsgGUID: C/cVIzPPQm+2UUD2tJxwlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40792673"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40792673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:58:53 -0800
X-CSE-ConnectionGUID: 2uARj4N7Rqm2mzHtxB+7Vg==
X-CSE-MsgGUID: bTwckWYfS06hUyaD6IZa8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122298288"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:58:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 15:58:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 15:58:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 15:58:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxk09LmbMSJfOlAzuyNVBXi8ctTyeFuvT8u/jTlK2Rqj3Y4FMEQN/QRCCOpgiQgUi6gvPRyOaghJ+ahl8is0IFCpKcMVWSEsWdMNVVhERk0PoeXwL8bNT++D94DQ/yOX7W4ZEqiAIoGkqafDJ9900OwNb3PP5zEfFiR3dntesvBYy+L9xI5YOTkX68Zup+xQxXb4A57v37l6lggMl0lj1zfpG0TSJiv777zVxnLqCKZXWMRCzGZW9AEmw5zn6KRSIULvFxVtlLrCrGBRC0uJZJ1/LaG4lr3IzzgCUAo6YyQTVfebS2dGhIOC5Oo8xOVeCK5n8hCJJQN9eOMKNZjDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE4mio3URihEYF0v+RmHaioCCSchOA6M393grmiAp5o=;
 b=pJyNTf6vG0gJ3wFhayqywGbPzJzTgF7UH1mXi+uCKGHm5c83sRhjH3OH15L05kdc68B6mylKfhOSLMlGGhJFuVuN6VEm2fC3Tp2xoh1sb8uxOCXuv0Usz70s6DUlTo2LJpErhzBaZHzguFouMQYAyw38zs91HJCT+tUx9HZdGrNvD5UseDQ53feVAGR1ZikqdrElefqLzMc4Hb+BPjEe0vU8I3cndKbXB2S4nxMom1kIpUihNvrqdONbSlF/WBt37R8MIHCIfH/6TyfiwgafssjLjvrQsdxluWesdG3JumiPebWlm4r5d6MC3Lt3L1/sUBKS4Q9yuxkLgdWd5Vd/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Thu, 27 Feb 2025 23:58:49 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 23:58:49 +0000
Message-ID: <46520236-e326-4559-aa52-21ace869c814@intel.com>
Date: Thu, 27 Feb 2025 15:58:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 09/11] x86/fpu/apx: Disallow conflicting MPX
 presence
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-10-chang.seok.bae@intel.com>
 <213480cd-898b-43c3-8e0d-601299526523@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <213480cd-898b-43c3-8e0d-601299526523@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS0PR11MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e496e3f-db2f-4611-cf15-08dd578aae28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am5zZms3bWxCNUJUbitCMldyeU1FQVM4a2t4ak5DQURxMnc3Z0JocTNUWGhK?=
 =?utf-8?B?cXZFcHd4MlZZY01YS1JEOWZpcU1rQ0ZkVTBldzdWc0EvSDc1cEdselgxNDNi?=
 =?utf-8?B?cUlpc01FSUFTWThDVGd4ZFVrYlphaFdJZElxNTg3clFlY1N0UU9pcGFmVWVI?=
 =?utf-8?B?RXBMRnl5SlRTN2l0eWh6eXpRei93L1JIczQyWXlQTkl2MXNsYWhDejlBYlhq?=
 =?utf-8?B?eFJuRG5BUURnbkpJUXl3SGtRYVFFODdFS2xIakpiQ0dVeHpraTRFQ2doY0hO?=
 =?utf-8?B?S1VTVEl4eHY1T3c1aFpYWjFqNDhqblp4Z2xrV1FGcThwQjNhd3RqdmlWT01W?=
 =?utf-8?B?dXM5ZE15KzQ5S0l2YXJlUTBxcTdsZjRuNXZPN2x6UHZNM3hOWUNvOEs0YnND?=
 =?utf-8?B?VVlrVERwWXpYMGlRVnJYODhuWnZuVzY4OW9zNVJYMnY5c2lGZEZLWUduc1dh?=
 =?utf-8?B?TkErc2pqRHRUOE5Da2JOVTFmWjBRNVhrMDZ0VjZERHZDK3dHd1czT0ZiSlZJ?=
 =?utf-8?B?VGFvbVBRN0EvMWxXMXErV21PeHUvblg3ZVlZN0lwWDBQY3lrT3Y4cGlhZlY4?=
 =?utf-8?B?R0UrZWxnQm5ISlBtTHhQeEFlRkVteU8vUmI3SUxka2Joa1VXMldLb21MWEJN?=
 =?utf-8?B?MzkyTjZMbTlWS0kyUTgwNDNTL1NINDZTeFdCR3hrSG9JbUdXcmQ5SnRoVng4?=
 =?utf-8?B?QjQ2eXJwL3NXUzg3Y3VLT0lBaFQzdk1sZDh4czRPUk5yMmpyYjNtZUQrT2RK?=
 =?utf-8?B?RHRwZnc5VklmUXhJYnEyYS9QazJybnNOSzVzZG1aSE5SOUVEL1o2ZDh4aFU0?=
 =?utf-8?B?SEdDbTFDUEpaT1pZSHd0LytXRXBsVkJXNVoxVUd5TkFaaGFvUW03aWNuVDJD?=
 =?utf-8?B?djl1YkVpWWFlb0MwdGJvVEVlSS9DbnNqMDRNbllJUm1CYWlOeGpXUGUvVWt1?=
 =?utf-8?B?QTFjYVhrTk02MjFSNDZUQUU1MUM1V2w3ajZNOHVpdlF0K3hMZDZDTHdsbnZO?=
 =?utf-8?B?c055OEV0bHQ3WXZkUG5jbDFHczVSYUo5RCtDYnB0ancydzVPQnJQZ1JvQjBI?=
 =?utf-8?B?Q1VmZWtuRHg0alc4OXNyMkxGL3pSNlRIOHZubEUreHMwY3BJUzFWTm8wWUZn?=
 =?utf-8?B?eHozbDhVaFplNWQrYlc0TnZhVnlvZVI0MHZOSGtSbkdzZ292em1PSlYxQnNY?=
 =?utf-8?B?MUFCTkE3SVVVREI2T21ONXVjeEtVK2kxSkZPVmMvTVhpSjRod3dHUlppam5I?=
 =?utf-8?B?UTVpajNranZySEJtS2dMTENGU2h5QzFaVSt6VVlMZ29ISTUyZkhNSXNNU0pO?=
 =?utf-8?B?S0tIdi83djdRMDFJVlJUMU9OczQ4b2lGZG1vZ2EwWjRQWWdtcG00bktjYlJx?=
 =?utf-8?B?U1NOYTVEN0Rma0hyMDgxVXRxcDFaOFhFSndyZ29VdXBieGVSN2hIY1ZtOGNZ?=
 =?utf-8?B?bUN6U2x5YzY1N1dPM01XQ3haS1RCUHZnRjdyQTN6dGR0bTlLSUZSUC8zR0dq?=
 =?utf-8?B?MXdCb2pGUm1RL1BVM3IyQmpaUTVrd2FyVGlGQmtITTM5c1VNaHlUeFdaKzlG?=
 =?utf-8?B?elBlTG1DNGRsUktXYVFLV0dHMmJ6MFBhVVNjOW1jeEpUa0o5NTVGSEIwTi9L?=
 =?utf-8?B?eWFkUlhxU1VDQzZaVXJCWTY4WHdQSEdxSmNKTUdNZkt0QXAxR21LUmtLMzN6?=
 =?utf-8?B?Q0NQVjlTQUladUEyQ3huN0tidnlibS8rS1o2aWU1YXRuYWRnaE8yYUhEVnQ2?=
 =?utf-8?B?WkFTM2Q0TGdPT2Q1aGt0am9jMWNUMyt2ZFFDNnBHbExpYWU5WThNRGFiSnF2?=
 =?utf-8?B?NEFVekFnUHVQY3AvTHAzRWVUS1UrMjl0V0ZiQkEwbGRNNUZ4ZGlXOUdpdUUr?=
 =?utf-8?Q?zOVaS+AY/fkZs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJzeEZjZ2szOG1TNGZ0MnNUSVRHNDlmeExMWWN4VGcvMEF6V3VWOVlEMjZH?=
 =?utf-8?B?WUVMQ3MyVmNBSXFPcFdWOW80RGJiNFhxbzR0VXl2L28reEp6RXI2cGtiNE1Z?=
 =?utf-8?B?Ui95UThqaTJ5RnNSWnM5dUloc0tQUm94bEJYUkd3MUJMWC9VRWxXNXA4Q1l6?=
 =?utf-8?B?RU5BVVpsMElBb3NmNm5USWh3MXRORzB2Y1EzWkRUUWUyTXRRbitjS3hMS3VW?=
 =?utf-8?B?S0t2VkFWcC9KWGJJRDNSR2hMZ3lrTXBoZElKdHV2blJieHpwdmprUVZOWDgy?=
 =?utf-8?B?SUVtQ2FQcGI1Nm9EOTI5d1ZjdHdWdXo3N1hEcEV0MzZrZ0IyY3pqV1h2L0hy?=
 =?utf-8?B?bjZoYk1RY1ozcW8vcGNQRG5XNlhEUTRyN1NFZno4U3FjcVF3UHAveVh3KzhN?=
 =?utf-8?B?SXVTT1RyRlRwdk5PTUtCTjB1UFVKTFE3WXJxN0hyTE5NYTc3S0ZpN1grYXhP?=
 =?utf-8?B?WGtPcmt6MzZNVHYwVysrTHI1R0w3V0RXWkdCSUgvY2RwU3UwMTN3Z2gydk5u?=
 =?utf-8?B?T0FReC9ueTdpOE9zSHhuWjRKZ203M09oQ3dQRWpRSjI4ZkVsemhHWWFZdSs2?=
 =?utf-8?B?OTM3alMrKzl3MnNlTEdxcXRsTlUzRW5OK2daOUl3YkRLRTZRYWQwS3R6Zk8v?=
 =?utf-8?B?d2Z2Z24yaDlaVloyUkY1d3RBUy83aU55L3ZsN2FWbHo3a0FTRmJ6ejVSWHRZ?=
 =?utf-8?B?cFZGd3BPNWlVUXhsdGsrakFyaG1oSENKQmpNMlR6QW1HajFCVnNySTUvZ1Qy?=
 =?utf-8?B?TXM3N2E1dy9wcHNPeW1kUlZmTmJOSnNpWVdyd1FsMHNxN0NFYkdjL3JtTWxY?=
 =?utf-8?B?aEhiR2Y3R05EN1RVRVFFY2d0cituR2U4SnVCdGxHUTZWMGZBQXNlR25JUzFt?=
 =?utf-8?B?N2JuRFJjZDROaWxIcjRpWklHb05URk5CNWRRSEZaYW5OLzdnRVk1SjV4OHF6?=
 =?utf-8?B?d1Q2UVlwcGZ3bFEzaW9iSG42dUpJV1kvQTBMYlNWUU5VeXF6S3VuVGJ3OHBG?=
 =?utf-8?B?dmE3WkJKbEpzL2FpRXZxcEFsUGtuVnVUWmFhRGlGMGVuRW8zU1ViVHFrd1BX?=
 =?utf-8?B?MktvWnJkT3Y1MXpiOTViWElCdVVMaWc4cGF3YnJScXV3TWptRmhTM05wKzRw?=
 =?utf-8?B?UEE3SjBmb3Yvc3UxWTYxZTdyeVFaWmJhV2JmVUJtbVNWTFpPY09XM0VIRUZG?=
 =?utf-8?B?U3hOZlRrM3haaWZSTzJWdGlqTUFXS3RmMlJER0VmOXlLNEZJajlnMm5hY282?=
 =?utf-8?B?ODZTRGtxQUJ0OEorL0hJRkgwS2lhREFzYWpzZG4wMVJDYk9PMVBBWC9qb25U?=
 =?utf-8?B?ZUYvdEFaTU1jTjlzN0tCYksrWG5TTUdIeXIycVRyVEN4MXY0Qm54cXcrend2?=
 =?utf-8?B?K3p4VWZUUWRKcDl3dUxMakF5MVlJR042Tm4rSE5LejF0aEV3aFBKUXlKZmMw?=
 =?utf-8?B?VTYxQkJ5RVRQUGFzcHhueThqczZUaDQ0Vnplb3E4dzdJcExiUk5VVWxMTnF4?=
 =?utf-8?B?Rm1DNHJpT1dPUUJXdEhjRzU1VU91SmVBNFVqSmFXRk5HZ2wrZTJVcHFxUVJo?=
 =?utf-8?B?NkdnOHVoMk9pY0dRVnNDUHhrU1hIVGlKelMwRE9wUnpHZ0UwQmdtRDZJY1BD?=
 =?utf-8?B?OVdiZHlPSjNZQ2d6VUVZWHhZbDRJOGRWbmhuWXVSOE95d09mWVJuajRSM2k3?=
 =?utf-8?B?a1RDbGkyZzFoeTBnOWJMTnhOVlhkd3hRc0pNK2lxeFJ1TUQ0Y1BEUHIwNG1Q?=
 =?utf-8?B?ckR6UlBOMzA4SXlOaTM1V1J5SHhxMDlsUEZpbXpmczRWMEgwWmFkSDFRc2xT?=
 =?utf-8?B?dTZKV1JreWY1aXdEemZVd25oQUVlT1U2SUtzYTQzR1VXSXIxYjJoblBvRFVs?=
 =?utf-8?B?Z3BQb0d2WU9uL3J6RHgvUVZSTEFvQUZFdytpeXdSMXdOdHl2Rld0SStYL2NY?=
 =?utf-8?B?WjNpZnozalUyV3RsaStrRlZoWDY5L3JTQWt5N004UVhGUDdreVB0eTNNa0FO?=
 =?utf-8?B?UFVmYTJBRXhDNkxnd0JOWnk4OUVGVXBKZXViTkUzUHZZcUxSM1E5a2I2RE5H?=
 =?utf-8?B?bmxLVVdtRmRTRTl0dGh1dkJ5dzBJQTRTN2dwSlpZSEMzSStHYW5MTjBUVHhY?=
 =?utf-8?B?bTdLOCtlRFZHcnpMZnR6K1ZWK3RQcm5MRXdsUmJBWklYZU45RWtyeCtDc0Zm?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e496e3f-db2f-4611-cf15-08dd578aae28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:58:49.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeG4xGsojxpwkWxb88ZliRvIKekuxfhYh1Rr2JBL/HYJcXYvRfiaid8EnCTH4KosCYHwkWOzPb5W5iI9E+MWSkFSRdrWj129rv2bHljaL9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-OriginatorOrg: intel.com

On 2/27/2025 3:16 PM, Dave Hansen wrote:
> On 2/27/25 10:44, Chang S. Bae wrote:
>>   
>> +	if (fpu_kernel_cfg.max_features & XFEATURE_MASK_APX &&
>> +	    fpu_kernel_cfg.max_features & XFEATURE_MASK_BNDREGS) {
>> +		/*
> 
> Does this also need to check XFEATURE_MASK_BNDCSR for completeness?

Ah, right. Sorry, it was a silly mistake. Thanks for reading through this!

Chang



