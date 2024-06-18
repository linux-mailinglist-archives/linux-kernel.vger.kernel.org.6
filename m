Return-Path: <linux-kernel+bounces-219935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8090DA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7A82813DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D113C821;
	Tue, 18 Jun 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZqmSRL7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333813B79B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730537; cv=fail; b=NCYIVEBrPd2zJy0S5OBVCNWLcJYjTmvhulvKb06zfRs4ZGfesHY4rpGc03phacO1yMNd0MhtxWdvCjoR2LWTAL3ZK/2CE7QArGzVG+mIeKAnSSIFxmweZopLC8VJxIPrWCT+yHs3y2q8Mzt3mnFxedalVPQSJk1i6aums3+ae5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730537; c=relaxed/simple;
	bh=RDQfwV7MNObELlQ7oWNj9ELASCaP2JqgeT4Q7HEqAU0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ip6RxecMTn6cc+Tb3p/M57HUx4ARb2xDlnjgFS0vAPgv8RA+uua7y0taa3+rNODwpn8OwSpSdjPPl6hBskY5kChB/J702Zd3+hx8qZvLfguv/W99qKyC7nR0ABnXFm9ECQ3SY9YUSwufHf+ZNUv0wNyfxxhnszUV2ymKnDaWMFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZqmSRL7; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718730536; x=1750266536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDQfwV7MNObELlQ7oWNj9ELASCaP2JqgeT4Q7HEqAU0=;
  b=OZqmSRL7p7XtqMUMeeThHKSAmL1Tnr7fBDBy3jMZLpSH8ALobtBDub0d
   8649BwmFq0tCIZgyiDxqwxSElYmSx2bqWxdtl75NMYynzSsZ3g9gEBygz
   HqUrXLOFPxw1GbY7ybsVIrMdrIePNnYOvHwnY0Hrgk3tfkgalgIoilNvD
   JSPVEfv1L2CALyubmiP1XUvxb/bHidovVbxcegLdS1Zw433Nd16ppQahd
   xcu9THPb7GXweJCBWW8rF7lZ6A3Hyc+dsKqeBcfXejzk80czFo+Iv3Tn/
   9IWuC+4D92rhKiJs1xjuuES+Wfaj11bniMYP0+MzixEqkS5Qx3BQ0V9E/
   g==;
X-CSE-ConnectionGUID: 2q9cax+JTcafTpXu3+DYvw==
X-CSE-MsgGUID: IJnK6zBBRtW0V6zgqayTaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19451776"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="19451776"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:08:55 -0700
X-CSE-ConnectionGUID: 94k07rmfRLmT8Se+w0O3dg==
X-CSE-MsgGUID: QZVwb6q7SsKTNkCr1BJjIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41568788"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 10:08:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 10:08:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 10:08:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 10:08:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 10:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5eLsmUzgSlROz/ZAv9PuRrI5uGB0HczhZwmnRNuWTuFvDdlCIOwHmci5spc176u0c3BtMN+A54nbSLWl5bvQbz7zz3WsNfY7dd6DVDa4Ket/GjO3giCUnQwwjwLZmkAUt3X73sYLIurj9X8LmpW6ZAl/7+6+y6W3UHJb3IIjftnPDtwH4qkaCl1EI61ai3VI4WBdeBCKh0FVayDyiZ/HQnhCiYtvx4d5msNRpg5DfAOiqOPkVpHDkT+a/K073D/z+0mw1+uJb67fYRmnS5my0CQRymvMbyTJtadTTDKRQtiEmuhI2QHrgU1r3U7OR9HOxxRUwxKHLwB2lIRb6wDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu/nx7Oo99a09KseI7oNo1dF7rVl0jA1oEhOde2t5jo=;
 b=fOElVWlBAdPtn28WWd7oOr+0Y1PnFif53BGx08W5Hvw67uOgzZOmOrjAmWp14nQlTItQR+Wd0xTxSs3036GlikjXEr6WOJ0Wyi7N1if+HHJWN72EvFNdU8+sGlbFlYpFmwv20eN8/tRY1++ND7NhFuiX3LjzNqD7macdGDzRRsUfbLE6z+lqUEa0Hn2ib0C3fU5AsmBx3QCQb7cnhTUSv6bKUiZw5uD1r9zSwMzp8WWkYc2Xvsbaz6PPWLI+OJ60DLmFO/dpbvhyHoIKYwXEai3TRxNAS/qY/336qWBLcZxOLmIQ5aoqpRgW3VKSoLeIxWZ4NENnYnoN4kuuJGHC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7640.namprd11.prod.outlook.com (2603:10b6:806:341::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 17:08:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:08:50 +0000
Message-ID: <f30c9a16-27b5-44ab-a55d-b2f9f3e4258e@intel.com>
Date: Tue, 18 Jun 2024 10:08:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Don't try to free nonexistent RMIDs
To: Dave Martin <Dave.Martin@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, James Morse
	<james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>, "Shaopeng Tan
 (Fujitsu)" <tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie
 Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>, Peter Newman
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
 <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
 <ZnAkOhFWzDqhlSyt@e133380.arm.com>
 <a37917d2-8ad9-4192-a3f8-9789193d53d6@intel.com>
 <ZnFTnzm/jctgN2wf@e133344.arm.com>
 <d476585b-3cfb-494d-b25c-4aeb6244e21d@intel.com>
 <ZnGy8B4FA+q3YkhC@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZnGy8B4FA+q3YkhC@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c25e1c-8daa-4739-7cef-08dc8fb95300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXgvQlpPdmpPUEY4NEttMFMzbE4rejdReFBGS0VOOTlIdHVXd3JwV09UT29k?=
 =?utf-8?B?RkpCTmN1Mk1OT1k4ZEhwVit2MWZ4NkhLQngzOTNmUVlFNEdFZXFGUU1qcnpv?=
 =?utf-8?B?M29YRXVvTDB1ZWZxTksyZUF2V0VXd1J5anZ3WmNHYkU2R09LTm41bm1HeFB3?=
 =?utf-8?B?WTdXbzBJTFBsamNkeUZ2SDZnY1pMRFpmRnpMYXorM3d5YmZLZWp0Z3lIT3lp?=
 =?utf-8?B?MG1rZW5VZDl6RFFRWTFySmozL0VQT2RwcmxVSUFtaUlnd1Q3MVY0MWVxRjBq?=
 =?utf-8?B?T2dwbVhRdWlabUY0dG5WUzQyanVZdmV2dDNMVjB2T25WRDR2QldyREdCMjFH?=
 =?utf-8?B?WnZCMmNYbG85UW5oeHpWakJMZytvNVBQSnYwMmJPb1BPYXMwb0kvQnhqUndm?=
 =?utf-8?B?YnNveWFiK0VuelhVVDIvQkUzVkFoR3JMNEhubC90WDNDU3JmTmdVYVA5YWtT?=
 =?utf-8?B?TXJ0czlSckpsSFlRZG10R2hLaWw2c3oxU0J0TDRPeW1Neksxb0lyTEtORHFk?=
 =?utf-8?B?aTIzdmxsMmovNzZRd3gxVkxCdHZmZ3dZc21ERkprV05hdWVvSFUyYksvUzhj?=
 =?utf-8?B?cWdQVEZGWEI5N0pMaFROS0VJVVk0Rzg4TXZ0NHJiUEpta2FPd3prdmRnM3Vp?=
 =?utf-8?B?SDF0QkMyWWg1ckFHaXo3ak5JUlpkSWttMkdmakR6M3J0Y2tTdVYxanBHMjJ2?=
 =?utf-8?B?ZVYzQWUxeWVPWWIyYmErVmFBbDBCNDVKalpvcnJvZGxZR3VueGFHYmx1Zm5S?=
 =?utf-8?B?SlFTRml4L2RnZ3RsODdiTHpxeGIzNUQvSVg3djc2L0l0L1NzNmZTYU5lbUZ0?=
 =?utf-8?B?YU5PYm9jd3AxNnFhVmhnK1dOcE1qR1JDMjFLaXVXWDdDNU1NY0RydlpxeHEr?=
 =?utf-8?B?Uk0xaGttZmlKV2k4UUhYZ0EzbXhqOWY3akg0UlkxK2dsbTR2UWRVMUoxUS9B?=
 =?utf-8?B?T21Pd29MZ1BWTXFlWnZERFhVZm1rRS9OWGQvUmtVSlVKQ0R6SXNmeFNZY29L?=
 =?utf-8?B?d3VZY3VIcXZ5SlQ4ZlFvMk53bXdiMWdHZG9VK0VqMGd0WXJEQkc4UkxDdVJ3?=
 =?utf-8?B?Nk5JbGJKK0VzSHMrUlBvbUtVKzFLQkl1cEQ1VmxWclZhY2lHNDFMVFo0ZWFY?=
 =?utf-8?B?azBDL2ZDM0dmSDk2NEkwVEFNYXJDTEhDcm1GZXZkY3dDVGVkeHRaak1JOFRk?=
 =?utf-8?B?SDFHZDhWYllWalJnN0hGOXJLQjJXSG5UbG0zNEdyS0wrRGJEbFdFemFVcVpk?=
 =?utf-8?B?VmRMME5JVjRLeWRQYmFyeXRIQkYrZFlZZU9UUGhzbkFCUGNVVEdHNEMvWFRE?=
 =?utf-8?B?RmFLRGp2VW5HU0FVaGpGdnpIdWxGTEFwRGt6UWo5eUtFdWQrSUF6OTd0WS9l?=
 =?utf-8?B?VGdCTDFZY05yLzlXYnExY2t3TXhwZjVjMHBzL1l6STQ0TUpRSWZGbkJ0Sm1E?=
 =?utf-8?B?b2xWSUNpRTJTeVRjNTZUVi9BYTVZSW5OdVRFd1pZZHlFVnN6dVZaNmxlS1lD?=
 =?utf-8?B?bVMwRGc3ZEpzdzdSMm5kU3JLeUJZOGI5YnV2UXgyS1ZydlI3aXlVZklqcXBh?=
 =?utf-8?B?aTVJV2Q3VGw3TzkvTU4raHkxR1dOL0dNL09RUVJ3NVpUZkhHcEk0anVEbzZB?=
 =?utf-8?B?cUFmNkd0Y1cyYWs4ZHF5SE9KWlZFaVppQUYrNTBXOWhyZ2xrbHVJZ1BNMmJi?=
 =?utf-8?B?UDlnWkcyVHhSVXZoSWR1OGZzU05FV3ZpbXBodWxaQWVhL2JyRTV6NkcvMjdw?=
 =?utf-8?Q?EPH2a7k9beIzE73vfY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnI1UmNnZDA0YmUydWxUSHJjSWxDZW9pUW9IUUtXS1JDRmhpK25uZk16VjRZ?=
 =?utf-8?B?bUJLK2RCS1VRaFJSYWF4RWZocDZLTStZOFpuTVFLajRXdjZsV2ZiTWR6OW5x?=
 =?utf-8?B?bkV3dFloUVdGcU14L3Y5eFkrc3pVQ1A4NHNSL0dBenJjdUdjUUJJVGVCakc5?=
 =?utf-8?B?YzdKc3BNY2JMNUZXN2NLUCt5c3JjcUJ2aC9SMlNpSXBQNEpaaFRmc0h1OHpI?=
 =?utf-8?B?blRFRTlmdHVadWhxZEVyVTYrR3dXdkwzR1VSNDJ6bUQrdVJFTkE5Q01YN3Na?=
 =?utf-8?B?V0Rvd2lON0tQS3pzaDFick1SWnA4SXJkM3BPVnhTaDFXOUduU1lvQjhGZXQr?=
 =?utf-8?B?V0hUejNlMXNVcU9xWk5sTDBRTGZOZGM0MU9TWGVPY2p2b2hSTy9SeWdNSjZF?=
 =?utf-8?B?RGdmR2M3aVBodXNhbXZ5V01jTm5lVzM5aTdHV0Z4QytzR2FNUW5tU1V2VzRi?=
 =?utf-8?B?R2dMak4rcFQwSXp5elNCTCsyUVBOaDNGQnJ1VlFxNi9aRVdlblkzRCtCYnhJ?=
 =?utf-8?B?d0tQVE5LSnZHR2owcFVOaUU5TG9rODRadjNkVlNpZUczVndkWWluQzV0VHlD?=
 =?utf-8?B?VmplRVJWNGJtc2VnbEdJOU80WkNZN1NUSWd4VmNHTGpRNU1KWkI0blRUbmtK?=
 =?utf-8?B?cDFtSmxGNU1yNlNBRXdnUGowNm9hRjBOVTBwRlEvSjZuSnZUckx5WnRmMWpB?=
 =?utf-8?B?RUZjdTBSeFVXRlBqQ3EyOFJtUi95WHoyM0liTGFKUTVjZHMrNEVPbHBCTHRU?=
 =?utf-8?B?Y1hwcXZQaVBmY2pDNWM0azNxMW95a09PeWU4NnI5OG42MFdGMllqTmtzbndL?=
 =?utf-8?B?K05IOFpmOHRSSGpCcHlnTDVFUnpYN0dPWUl3ZlhyQVU4aGhYT2daakZuTTA3?=
 =?utf-8?B?Z2JLQXFqU3NVOEdpNTRxZkUxYXM3T0VsMkRoNGNpZzRvN0RoM2lwUnFlb0NW?=
 =?utf-8?B?amFpYzlGcVVBT3pYaElzY3AyTmVLR2RQeW10ZzZrRElwYnc5WVNudjNkRlg3?=
 =?utf-8?B?WC9DQTYwNW9VcU1xQjlWYVBNK2hVR1BGSklkRVVKcGV0MDBNaUdZUk5xN0JQ?=
 =?utf-8?B?UGN2UTVLMmtWSlJxeG5kZFJybFBQaDQ1QjByMzVyajBzZytLOWxpQUo0UGk1?=
 =?utf-8?B?S0llam5vdGtaZHlvNWNEdkR5VzZSME5DeXBLeXZQOGhMMStqMVViYzFhWERw?=
 =?utf-8?B?Q0g4ZEFzRjR6S2dHQmdBTFBqV2tYL3ZDemgvbzZXYWlQWHd6OHczWlUvaXdv?=
 =?utf-8?B?YWF3UmlRMDRtQlorSk92eERqanAwUzFYMWh4eW1sU015VkNqRFZnMzNmKzRG?=
 =?utf-8?B?VlkzREpsTXhBYjBMY3d5bTA1R0pSVXlLakFPdW5LRG1hYmZHbTdHVmFVcmQr?=
 =?utf-8?B?bGg2Ykt1c2NZTHlNNWZHbm5RZzBXaWtyVWx4K1k5WGNiWWF0NW9qQWVheUoy?=
 =?utf-8?B?OGtqbldDVU8wOTRmeWFGVVY3OUtZckZpRzhuZmxCd3RzL0V3SWxXcnJ3NXJO?=
 =?utf-8?B?ajA2QktRb2M0VWRiKzNyaDZ4OVprc0h4cEk2OTBWbXVpRm5mRHdXMjhaQmQ4?=
 =?utf-8?B?MFBxZTl1SVd5ME5sNGN5SHFsS29XR3o5UmRCWDRreGNtblpUR0E3aGI1Q2Zz?=
 =?utf-8?B?Y0hxM2NBdXdXRWZiS3FJc1hRNi81WHpKNTVsbFdBQzA0cWxsZ0o2U3pyM2Jx?=
 =?utf-8?B?VGdTa0k3NHZwNU5JUUwzd29PTlBwbE94SG94bGNlODhBdEN0Si9idG9jRTZG?=
 =?utf-8?B?bTBsYkpjOGtrMHJVZ25wdGN2ZmRUYVRiQlFwbm43L2pBblFPbGNsaG9lUjln?=
 =?utf-8?B?VUVNdnE0K0l0RG9keXRHaVRGZlNWLzFyWUdtZE1TRHJVVTBOQ3VCenFtN0Y1?=
 =?utf-8?B?WWVCZzRic0dNWGp1WVR1S2NtTU56YW5PajFOQUNscDFVcGNadGNGNVd2Tm40?=
 =?utf-8?B?cWRDQVRtOVMwNHhyV0Q3SmkrNStWbUZqQWJ0aWdRRWorSkV6Z3NaWXdjZ29K?=
 =?utf-8?B?RDVrTkdsT3BMYXozYVVNbS9vbi9IVWI4NURjMWZWQlBVYWljRGgxcGUxTmRy?=
 =?utf-8?B?RjlOMVdZZnFOTklodE9FYlZ6bll4RWNxenhhZkIzR2k0Rmk0N2Nma1FpQlk3?=
 =?utf-8?B?enN6M3BMYkJKMTFYVTg4WEJ0bnpXOEpLQXRXbnRIVUtWZU5HNHozUDM2TkZ2?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c25e1c-8daa-4739-7cef-08dc8fb95300
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 17:08:50.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ewi/lkk6T6OfGKn0pNJVOXWezGnGk5VfX5/Te1cTOdu1FBUSRY3zNz8JJJ1TmWFC7oFrZseU45GFFykxNVZM0N2HaPYCEmJpFoRfmhuSa44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7640
X-OriginatorOrg: intel.com

Hi Dave,

On 6/18/24 9:16 AM, Dave Martin wrote:

> 
> Either way, I don't think this impacts the tested-ness of this patch,
> but please shout if you have concerns.
> 

I agree. The submission stated that it was tested on x86
"for the monitors-present case". When booting with
"rdt=!cmt,!mbmtotal,!mbmlocal" (as I did in my test) resctrl
is not able to discover monitoring support and it
thus tested the "monitors _not_ present case".

Reinette


