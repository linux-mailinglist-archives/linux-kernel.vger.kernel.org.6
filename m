Return-Path: <linux-kernel+bounces-173809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E548C05D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708F0B24DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B0131744;
	Wed,  8 May 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxUCe+vX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70B12E1F2;
	Wed,  8 May 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200931; cv=fail; b=XbkkXZ7ekr2qAcstCyzSa4INkw8MBNL6ld4uhk84opzfr3PSdhHvHsTK4G9+9kFbAExUCm8oMPUb0uzdrAV36MeFfZcNtusaNzZE+DfzyYhEvErxJ7DzszkNH55WqEnWJv981WsYi5qzudPfYO3ViQEQm+eryeLMmGmd9ibN1nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200931; c=relaxed/simple;
	bh=veuevydN2XGqd53V0+kppNcbVVadA6U69odozkWeBIM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UQAjXl4foTtx4lEw6qW68wD7gVZkXokPnkJlYLnOEFN82bh+F1kKrfPg6TsukJLGHlOuchvC69upuDXggt61SICKl7FzFgk6Hb0y+3P6sw4+x0z+pIkkm6KJ0ON7zaRZisNLm2onYqjt9IgvyPRKVaDW2PPVIBC+Th6eopJkRgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxUCe+vX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715200930; x=1746736930;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=veuevydN2XGqd53V0+kppNcbVVadA6U69odozkWeBIM=;
  b=VxUCe+vXCCJGiShwg0HNiQD+EQjkrqg8YQfQZIGbVRl+EaHyHVOiAlru
   /flcA2ZqPU1Jr/9oOuVfTuBBBC9Adk03vrB3g/ULyOkJDlMIuC1n043Pp
   MSjX1r5jFVhVvtc7a/MLDniNMbhn6lR5CV2zZWAwrULonpYFHTfCmKsCq
   aZXcE0eVwzFlhs83gyXcISjk4fKo78c+gY9h7YRhzHZmIhSvgjb5swQKq
   0602MPwXExqToZLxGdOA2wmczY8SMcXCKhPqo9eFgsnPAa7hebEasjZBU
   8nfZgSGTIj3ZPFu/e8kCJRtBYb1ktVETpiD2vhvAmnNR8n2t3pDxB1tKx
   g==;
X-CSE-ConnectionGUID: 87rezKFfRQWOHaHqINFs+Q==
X-CSE-MsgGUID: cjmJ1QRtT5yDLTpSO6u88A==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11301949"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11301949"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:42:09 -0700
X-CSE-ConnectionGUID: Wg/+snXQSZCrJ7w0B7UPhw==
X-CSE-MsgGUID: Ysx+FCPNSGSfCx9C7AqaoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="52209068"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 13:42:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 13:42:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 13:42:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 13:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfJ1//U+igczxYaKZ2ft4wc06yQCQTyAeZsySfk2HvflGHsP+P9edjFlbKNYqg9EzdnbJ0sl1RAmdX2FDQcpuVO0gxxEPMmKdwPByD07pM9fs8+wDWFTYfNeB+in5emwmi3Uv1BIDvVhL+woOYR723agUluaDjR9amldE8Djy800Q9OXVBgBs9aCQvnFZzXXAS1oGQj5xwFTMZ5hZR7NowbrgkmdiQN3i1yKU+rqdRTPlsMfpTB7YIJKyAskJJaMFFr1A+VD+4tluh9fTJ9jp5GLRIGc9N1yjWWWDRJKV1sMQ6bBOxFreJiogaNpbVWVVJTQsNVdq63iEgfRRjSrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3QNzWtg/Y+n/xmOZzj7ixrSoFZnHFsHMjjwBPp+hTc=;
 b=cWEJ02WrV4JajTBuF5+VkDk0cWd/4Qdmjhh7N7iBU1NcWaWGkoelXsUbvw4q6y/RGzA0Cd+H+nb2Qvc0RAJjASdsRWtBStoImmeujkvRzuHlZ+kjWns+gjmn1DehN72/pBhWy8VjRzyoZFPoQEM/ZTEULCIRb+MDvVDOuqPYKuJlXB0wwRxEccJ8gMBrPTkcjViRg8hU7Oa6o2fhbTx0L/kpvQDYazDgPMqO4z476MSE8ly4L8+wNd2+MQkAEQiKvgyTHv4kFCstkeJ5xgjQYsckPBxlNhici4C0/4vxka8ge3GqRqNBcXuemh8nBWF40HO8Jpzc8PSw3WS2ewh8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 20:42:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Wed, 8 May 2024
 20:42:02 +0000
Message-ID: <b8a87fb1-838f-4337-8940-8eb1c5328a2b@intel.com>
Date: Wed, 8 May 2024 13:41:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
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
 <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
 <2016b830-64c7-43bd-8116-bdfd239221e3@amd.com>
 <ea75801f-e56a-486d-85a4-85c57bce0c81@intel.com>
 <7e92200e-d68c-4dc4-85c3-7192a23f8cbc@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7e92200e-d68c-4dc4-85c3-7192a23f8cbc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0378.namprd04.prod.outlook.com
 (2603:10b6:303:81::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 382ccb05-b27a-4fdc-cf29-08dc6f9f5072
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjhJaTRNYkM1Y0ZNek1NY2VCOWp3ZDhFblAxcHg2MXhhV1RQRU8xTGE1bnpz?=
 =?utf-8?B?Qy81SVlUbDVnTUlkcHREc0pvcjdsczhDdm94QWx3aDJYMi8wWHIyMFdTYkRa?=
 =?utf-8?B?NVlxUk90NCtiUEdxSUx3WmE0ejBVY0d4K0g2SFNHY2VGWDNWdHRFcUFVeGpX?=
 =?utf-8?B?bXhxM010ODZEZVdyMXU0TnArT2pQclJLbW83Q1JvcjFDdWcwVzcyZGhIYkFr?=
 =?utf-8?B?eHp1MEx6QlpwelpKTkNhUVlWc0N6cjRKNzVwS0ZqUTcwSXdFUWQrOTFxcW5s?=
 =?utf-8?B?ektMTFhKZC9Cc2EwZmd6YjVueW50aVNZS1JWSyt5WmxnY0QvamRQV2lMVjdU?=
 =?utf-8?B?UWtvTUJMUHROMktoQlhKalp3MHR2UHhqL3AzV3ZnL3BaektCOS9heGlwQk1a?=
 =?utf-8?B?UUE4d3ZaWEtMajRQaDZ2L0d5TUZSeEcybGlybThMWTkrYWxxUjMzSUtlQjJx?=
 =?utf-8?B?L2dtV2lhNU5LZGlQWjEwZmpnckVhSWxrT09kVWwreXA0blBBTHJkLzQxNjlF?=
 =?utf-8?B?NmtzMmV1em1yck50U016RTZaTU8wSFd6MzZrQ1NISENFYkJvUjZCZlQvSmY4?=
 =?utf-8?B?OEtaVHdUSGhOWXc3eWxUY2llOGRyN0xzZXUyNXZSd3ZXUis5K2QyTUJSVlNX?=
 =?utf-8?B?bGhGcXVmM2dsbVVvU2tPZkdSU0lGb09SUTdsT0NjenlaL0ZNaUFJMDZYV3A4?=
 =?utf-8?B?R2EwdXliT1U3eFo0TDRadTVVN1dkSVUxUm1hMy9iejdDbGgra3p4NzV3NWky?=
 =?utf-8?B?clJCMDhQYjM0OVJhNkJRN3dkaVBtTXVBSDBwWjJjb3dyeTFZYi9yRG9mUG1i?=
 =?utf-8?B?bmhMdUkxRDRCeDgrQjlna0FObHpjc1dGMEYxbzZJRGI4WnpwdHp6dzhKTHRG?=
 =?utf-8?B?UGpTd0dPR2tDNnFHOFMzUTVIamVoNUg1bGY2T3c3bnhESmJ5elhtZGk5T2xh?=
 =?utf-8?B?YWordmp5MkRMc2tIVmgvallBdUtZNWg3MVplVzJFZWVXZEJCWStJVFhuUkZG?=
 =?utf-8?B?TzhHRWdlT3ZzVEVucC9oOWdFUFZIZGpmU1ZhNWpJUzFzNHE5N0ZUbEtzZG5D?=
 =?utf-8?B?azhVRDZ5ejRBZU5Kc1ZnWHNKUnhxSklaOVBaK0N0M3hFU2dhbTBvWU9TVm0y?=
 =?utf-8?B?NGg4ZjVubmhncGtLUXBrc1lwaHVQWjhNc0k3d1lETVJTTi96UWEyWlA4MjNG?=
 =?utf-8?B?SkFTdUx3VGFWREtrWlYwSDErU2V1RjRFTCs0eVBmTzRXODlrWkk2YUE0TCtE?=
 =?utf-8?B?TEJ3QysxTlhuNE84dC8xS1c1clZBbDRLYjNmZElTRWFhR2pWMjNZRzlPd2I1?=
 =?utf-8?B?dnpBelRyTU5jUDZoUXpwNWNKRGRzUUtTSlRSTHpRRVRXWnluWFhmemhORzdO?=
 =?utf-8?B?NzBBMG1EczB5V09LNUVTTllEa3ZINWNlRUtQUHFMVDEwTHY1eE1ELzVHQitK?=
 =?utf-8?B?UVZ1UWVVSXhDV25SQ1lVU1dCaTFkOXhPYmZTa0szTDRaV25sc0FaZGVIL2tF?=
 =?utf-8?B?cGxuMDhFWFY2dk14dVR6TGpvQmVSYmg0UnhOYldMQ1M4cmhHTnFvSXNMWjUy?=
 =?utf-8?B?d2VBTTNoemFSQytMR0p2akdOUHZxcEowQndZazdhMk9iZzRKOE0zbmt5VG1q?=
 =?utf-8?B?WmdFZWxWMjBWZ2NmcmNNTXhYa1RyRXU4UmtVckhwY0hnUmFqL0w2K1NZWGlY?=
 =?utf-8?B?aGVySnk1di9UcU4vMUd6dkthbkRpSkV6dCtvVlpCSmZUVk1DcWx6dVRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdQOVoyaXpOeU1tb3FFRml6NjFBZzRpUjI0TDRsdDVDcU1OWHU0V3l2OWFM?=
 =?utf-8?B?WjhxYmhqWVpOOW1yTW9KcDc3OWUrQ21scnl4S1ZGWjFoNmMzVGo1QkdMZGd1?=
 =?utf-8?B?cnU4QjlROUxCajFHeFBBYkgySzUwZjhZdk1VSWVxQ2U5N0ZydTJVUVJ5RC9k?=
 =?utf-8?B?U3JrNXJZRDErYytQelAwdUR1Y2Z1aWxRUHJ1WDBKZzlzMlp4Sk9tTDFtazVS?=
 =?utf-8?B?UVN6OXpGbHRWYjhwMFdLMzI3dWhua2dOQ3RyWlFWejZlcmF1UEtFd1RwUXBo?=
 =?utf-8?B?RG5oUmVxdnlWditYTTA3ME5SNWdtRHVUOXZsTDVYb1lSRHJpdWx4YThFQjdn?=
 =?utf-8?B?ekJwU2c5TGhuRGp4Ymg2TGIrcFF0MU1WY2JubUtGajdjREJVSlR0b3oxenVo?=
 =?utf-8?B?UzI3aUorQVF0bCtpZ1Z3ZllUTDN5UUJTcG5CcUdRTXo4YUFUanU0ZVRDaDFW?=
 =?utf-8?B?a2lTR2tjdSs3K01oODVGaXRuTmxjTENlRzNMc1RiQ1ZYZm0vbnpkVTBjNkha?=
 =?utf-8?B?c3NsbjExMnZPWFdtS3JYcmV0M3pXa0pXSDhjZFBxVGJOV3RqbDl4bEVCdGhK?=
 =?utf-8?B?T2FNdXE0R2xxVHJyTEQvVXhRSEdvcEhKNWtDMndZbVVaUm1iczgzcEllTE1I?=
 =?utf-8?B?VlpmQUlkTlRlODBkTWRBWnBPUEs5blBxN01MMit1MHZsRXdyMitUVmUrdkE4?=
 =?utf-8?B?ZExnMTk3bnZUUjM0TVRra0g0cWJZcWVpSVA4cW52OE9xS2YyN1V4RkxhWTlE?=
 =?utf-8?B?ZlFVOURjeC9vVnhtUm9ZK2JvcWhHOS9YY0V1VTUyM0dtZWRyOGowWjdKc3Rq?=
 =?utf-8?B?aVpCSmJscVc3NFhqd3lHYTVGYVpIVFVSMUFNdUs3Y2d4MEgwVWhNKy83S2Vq?=
 =?utf-8?B?dS9yYndGVnB0bWpNbSs1Zi9KZzNYcnV0dFppazJXbnBVYkZYdFZBemJCRnFJ?=
 =?utf-8?B?UW12R0hIREt4RE04bVE2TmtkdWFUb0hjNDFUeHgvVUVoWmZ6by9TZkI5NUtI?=
 =?utf-8?B?V0FYK1VmVURxMmd4TmwrRnE4S2xrY3JoQUF1Q3dhZkdIQ3RkeVBSK3VkeW9k?=
 =?utf-8?B?bG1uOWtWMng2aU44cmdZem8rM3FaajM2ZFNObVRtWUovWjhUOHU5YmFnVFVU?=
 =?utf-8?B?c3dVUGM0ZWtJTUdRaXcrMnFKTzJWWGNYMWRBUFQ4WXhiSmI3aGZRL0x4bmpN?=
 =?utf-8?B?ZGpYVjBLUmpVUkpOeTFFcERjN1FsN0I4TU9vUndnUytmeEt1KzVQSjRsaHpJ?=
 =?utf-8?B?M0p3YTIrVGp6dlhuT2pQb01DM0NvUzNReDVMVVVIcU1tZVlzeVczMkZxMG1L?=
 =?utf-8?B?YzJPQVc2enJjMUlTWHhjZFU0cHlMMkRLUjhMV2twd1ZJUE1HYWdXSHNrUWhj?=
 =?utf-8?B?SkZLcURKZHhHcGUzR0RTcGhzZVBiSk96RXdVblRuMlIxL2pvbGNscm9TSUNk?=
 =?utf-8?B?bjMzK28vNzRpUzFMQ3M2TkN5eHZLb0REZVBaS0NDMGszZWRjNHhvWG96aG9K?=
 =?utf-8?B?KzVXVkRUbzZyK2hNMFFldThKS1NOSEdBUTRXbCsvKzZ5WXMzV3BESytIZytj?=
 =?utf-8?B?NjRzMVhyS0lvRXA2R0tNNFBDcGc1SGFQSnF6MFMwUkhJZ3I1a090WG40cTJE?=
 =?utf-8?B?aElOSUpXSC85Y2FrR2JucEpPendxOEZwM2JUQWphSURmUHFXblFWdGtic1BF?=
 =?utf-8?B?d0lyck1BR3M2UlcwbUs5M2hMYnJyQnpiVERnOURnK3FhUDdsVk1vQ3Ruamls?=
 =?utf-8?B?aEFPYWJHU3hOakFtUHh0Sm5oWlVNOUxWVFNhMTExTDl6SFg1UkFrOG1hNTNX?=
 =?utf-8?B?ajcvMkdna2dRSHBWaU96RTE2S1NBbTRrRHVTNnQ4akdBUDlqK01wYmEreW9r?=
 =?utf-8?B?NndkZWhDSU42WkxQVG9kVHZwY2YzZlJDaCt3UGhvWXBhc2hGQVlzaHZpU25T?=
 =?utf-8?B?V2NiNnVDdWJ3VDJxNkR4TFRSNGZWYUNmUEFqRDZSZDA5L2x0WFJyUHBDRkc3?=
 =?utf-8?B?dVdIdEFSNEVuK1NGSUhwdjkwK0FFRDl6bS9QSGVqcENuQURZRUZGMng3N2JZ?=
 =?utf-8?B?OFZxZXpnSUpoTU82U21XelNIemhzZGJabjNubnpDcGl6bXozYm0rbUtmdmxn?=
 =?utf-8?B?b3ZJcHAvZ0V6SWliQXFFMW1oOVZ4WkhTUlZ0NWVQTmJ2NWtDR0FUN0JsQUFQ?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 382ccb05-b27a-4fdc-cf29-08dc6f9f5072
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:42:02.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBG3iCpwpiP8zrRpucAghNS3u+Ip+nQYyQq87mdEQ5ytm+lpO60PI0MOobR81uhe4KzDXlJ1nvZBVFIbJmS1R6sexbL80g0oFlK17qoAsjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
X-OriginatorOrg: intel.com

Hi Babu,

On 5/8/2024 1:07 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 5/7/24 15:26, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 5/6/2024 10:18 AM, Moger, Babu wrote:
>>> On 5/3/24 18:24, Reinette Chatre wrote:
>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>>
>>>>> a. Check if ABMC support is available
>>>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>
>>>>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>>>> 	[abmc] 
>>>>> 	legacy_mbm
>>>>>
>>>>> 	Linux kernel detected ABMC feature and it is enabled.
>>>>
>>>> Please note that this adds the "abmc" feature to the resctrl
>>>> *filesystem* that supports more architectures than just AMD. Calling the
>>>> resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
>>>> other architectures calling their features that are
>>>> similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
>>>> a new generic name.
>>>
>>> It should not a problem if other architecture calling abmc for similar
>>> feature. But generic name is always better if there is a suggestion.
>>
>> "should not a problem" does not instill confidence that AMD is
>> actually ok with this.
> 
> The feature "ABMC" has been used in the public document already to refer
> this feature.
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf

It is clear to me that Assignable Bandwidth Monitoring Counters (ABMC) is the
name of the AMD feature. The question is whether users can use the 
same name to interact with "similar but maybe not identical" features from other
architectures, which is what this series enables.

> If there comes a conflict then we can change it to amd_abmc. Didn't see
> any conflict at this pint.

How do you envision this? The resctrl filesystem interface is intended to be
architecture neutral so it is not obvious to me how "amd_abmc" is expected
to look? Why would it be necessary to have different architecture specific names
for a similar feature from different architectures that users interact with in
the same way? Sounds to me as though this just needs a new non-AMD marketing name. 

Reinette

