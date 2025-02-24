Return-Path: <linux-kernel+bounces-530165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B94A42FED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016703A6E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072B20127B;
	Mon, 24 Feb 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5SMul36"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725711DF242;
	Mon, 24 Feb 2025 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435650; cv=fail; b=e9Y0D6dP+TfJ9CtkPyVrNgWCxMQZ8S9hSnOh7E2Z0AwgaNS54LZmKniUimOcelYUWvm3MQ07AqXQTlZiKBz++PPVPPPtAFcfIdn6a8qBTU+vJJpUjgLrMVPK50OmXRSHHf2Af+xo2l5dT52rFhLvCifiOMqApGApsgd/E/nstXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435650; c=relaxed/simple;
	bh=N2z90pIjyhiD6qfbcR+KqK726VvS9muZE8xAyLR1NKI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8jpamdViK3fRGClgRf3y4eBpMTDPiq0/o13DSfeqFt/p6NmMurAbhEtgvDu94WmKJ4mD7SX18k9CcdKiI1h5nwYi51vra6xa7piEekjjUGc/i4EszxC43n1a0sf+74g34JgNdTw0eUpS93l+L2RTI3zlxtAN8Ewm9yS9B0rZII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5SMul36; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740435648; x=1771971648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N2z90pIjyhiD6qfbcR+KqK726VvS9muZE8xAyLR1NKI=;
  b=Z5SMul36VKb/XKVXbLANMdAlOwphAAb3BYm9G5n8XZmQVuwajDjXCGWK
   R6PdRpVBjvhdc+OK0uAyQ6++eztutsVzUvrQ7qbyhFK331n6kAHzZ3sRY
   DliZQvTH1kMOzdcoPlwxvCjZ/5+WQbkqWz2KLzlSnzwpBOQesgKB381al
   fhsRPoXwo4vPTCj6G/jZGT5JOBjji+FSpo1SEKLgprY4KYiX16MPKg5Fw
   sYPxWb8NmRH3Q7NL4/4064Z1Tga3y8hFgFmsUwzlrutevs3ZqGuaFz0tP
   UFNk9dSyALRM0TBx7gZKP/EajJ2fqgk7J47zattmlMeybFvHDt0VcMyXw
   g==;
X-CSE-ConnectionGUID: sC7P2ZhlRa2mFybWj2v+5A==
X-CSE-MsgGUID: iwG28OAOQW6+xr2FVT+HcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51849765"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="51849765"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:20:48 -0800
X-CSE-ConnectionGUID: v6YIb3rdSGm0NwxDpWEXBQ==
X-CSE-MsgGUID: lfY6v/z9RpyoA+Hi+uoG1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116676978"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 14:20:47 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 14:20:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 24 Feb 2025 14:20:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 14:20:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1tIGn6Ek+26ivlNF8zz1/ilPtZ89gbrIAP4iHSY3NdVfB/cqPSYKV3bqWsvOLU/dOrkqTAeq/Dv2TPIIMJRwF9m2P8Mry3DzcT6xQmbvqCIa2hhposu30panAzwKtuXedR3vO4fYNUTVm9FxCbXWfFHCHLHIfkRblo7WSZrueHoI1pBw2xtb4N+WcJqGghH3gLhVP3xgZnwVN4z15JD1kJvLWt5pH/HZJPCp7YwH5wymzDKFLdFbmX7xSKUI6rkbBfjtezELHC2SCMMX3CRH3xOhV3FQraF4ktQDthE5cWqah88iXhVzu/4ipae/Ym6E4xAovxCoB7UA1evIGAdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMgPrIe8HPjDWqCS8fx/8YL3O92v0J0fFiYakkZQsfU=;
 b=DKmEDQj2t5hYGJDI1c6A6cMajMEFuk1ZdmxwkgOvnulEbm7YVeToO1d3lWr29Xl1CtrQ56zvAFkQkBkCsjHBaAWq02xcok0fu3m1f+Ooc2HR0J+Kust4ZHz9TnJg182NCTz2wP4oTDYIkixaitbXa8yFIBr3wEaGj14KKKQGXUe47SLViwYskf/BEPNfeoQr9pc3AWG+SQq+X/2tdFJ0YrddZWKUSOpSPm2ueYH14pWLciOYgshfRnhyMBf+xDlxiolvoPbOpSdv5pEMDfd64XuTDrYZzqbINRywh8ZK9s/TSvzzlxX9o1sa3Hf4grfIpg0I0M4km7BrRPm/sXzHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 22:20:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:20:38 +0000
Message-ID: <29399510-f65c-4509-9ca2-fa618155058c@intel.com>
Date: Mon, 24 Feb 2025 14:20:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 20/23] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<peternewman@google.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<akpm@linux-foundation.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <4a48aabf502897bec1e015305d7b0b826bb20841.1737577229.git.babu.moger@amd.com>
 <b3dc2fc5-4ee6-414d-90bb-97baa0d67dc5@arm.com>
 <7b3d18e3-1f7d-42cd-bc32-fda4a81dfc82@amd.com>
 <3fb20135-1b8a-42df-b670-5fbf29acfa85@intel.com>
 <c866ffa5-0a4e-49a2-bd11-86c94360b7bf@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c866ffa5-0a4e-49a2-bd11-86c94360b7bf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d97f16-7934-49c5-c3d2-08dd5521779f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTBjYUc1L043YUI1WC9GeUlvOG5uUWZtY2h3MmNyQkRGbFZGblVBVHdHSDNV?=
 =?utf-8?B?aXllTEEyUXVjUURDMS9aMHUvaGl2aDhWVlZnMUVCeXV4YUh6amFTS0MvN00v?=
 =?utf-8?B?K2IxMk5HVXdwUzNuUkRQd0JGc1d6dTFhbForbE4wdEdxVDgrSmNNakNMNHUv?=
 =?utf-8?B?dENwMGhINXRBTjBCQVJqMlhuTC9uejZJZU5KUUNCcTdIMVFseTdQUHlUOExM?=
 =?utf-8?B?aWxlSS9NdFZZMzZxV0RyQ2tBNXgyWWlqZGs4L1RZd1BLS0UwZVZXSEtMeWwr?=
 =?utf-8?B?d0tja0draXczZ0R3N20vd3pTWmxuZEhXTndRMitzbkF0SVZtRWkyVkJIei9a?=
 =?utf-8?B?anZzUVZpUGxpdzMxRHB2RkJMS1hEL3hwMEVOQTZKcUxocTJBYlMzS1h5T3po?=
 =?utf-8?B?RDdETWQxWVpJMjlaam8xNVJMWFllaFRWZDVGbzA4cWJtZTdWbi8wSmordllo?=
 =?utf-8?B?NUZ1WStLZXk4dFdHQzRUbnR6cjlIUkVTSWhXSUZYUEZmZmhNelExMGlROEFy?=
 =?utf-8?B?d0Q5L3ZoNHE5R3RKb09tcVJrMEg4cUtSbjU3Z2g4enI2dURSMWZNVnR3WWZM?=
 =?utf-8?B?b3hTVDNqVklXWVhNYksyc0JOY2ZYbEVacTRvRGFEdG84dldaZ01aa0pyWk5h?=
 =?utf-8?B?SmhhTmprSTRhOU1yZ2dabEN0c1Y0eGpqWGI5OXpHQ2F1dlJpekp3ditrNitF?=
 =?utf-8?B?anVYTGpiVkw2YUM1cmhCUWRmcXhYMjVpL0U1YS9KSzVtd2xyRkFiV0xnN05v?=
 =?utf-8?B?SWJDRGJCeHkrdGFyQ3hhdW9Fd04xKzFyNEpxT2UxYU9IdjYrT2VnUmpIYmFj?=
 =?utf-8?B?T2RDbmxHK2gyMW5KOWJOS3ZnSFhaTWRlcnpSSzRkVk8wSUFXT1BOVXpWcnJD?=
 =?utf-8?B?cGlhOVdBbmZ1Mk0rYjIyZ1JKU2V1NDlNdXZlbXRvTjQweXQrdHkwenN5QXJR?=
 =?utf-8?B?TzFLSDVTRkFnZk9naXVxa29sR2h3R25mZ2xHMHdmNU5rdzJhMWxqcEUwbzJ0?=
 =?utf-8?B?NzNGWFBXNnlXR2U2K0xMZ2FJbFRVUVZTeTFuNDBxOU9VSFU3NVF5VHJWWS9r?=
 =?utf-8?B?cVIrNVgrUUhyUDVzclZ2ekcwNU14Tk1XalIybEZFZnBSeU1hdUJySS8ybGVz?=
 =?utf-8?B?Q3BIM0pyMnYrbjNXamkyMUZSV2JreEF3Mk8rYUR2a0o4UktXS2Z6N1FqUmFL?=
 =?utf-8?B?ZEVNTExKNFVsajlYbUg2QmJxVmVjbVJoRlNpWWdHMXU4aHBZZjVKbnBqRjJ3?=
 =?utf-8?B?YzYvVVVUVFZUWjhVcjNmNzJCS1ZEeUhPelZQZTRnMFVqYzdwRlpBeWpQSXNk?=
 =?utf-8?B?aWhXcWFtR1VVWEExanorc0RJWTdYV3llZzhpWlhiWUVVMTZ2cmFSWmlaaVVm?=
 =?utf-8?B?TDFHQWpzdnR6RjRCQVJjU0ZKRjcvaEFoMGc3dmxhN2kydEJaWGx5UEtXRkdE?=
 =?utf-8?B?aXRzRU1ydThyYTFkcG40N1QvWCtab3hmTmEyeStMU2QyQ0N6VnlGR2VIL0NL?=
 =?utf-8?B?cXJCdHJZYnAyZXYydWVFKzkxYUxDZXorT0MvNkRKcXN0Q2lVSFhaQnEwbzh2?=
 =?utf-8?B?UFpVYlNFT0VrUWhoODZVbDl0ZFN6Y3Fsb3lkdThBSE0raExCOE9PNnFJVkM4?=
 =?utf-8?B?dHh3L1hDR0FJc0ZneE5RSDRXdURpczBsOEEvQXFsRFE0VWJqeFBvYlNHQ2xL?=
 =?utf-8?B?VElpOFBrTGVFd1k1NnpEUGxGMHprcmxxbUxITW5iZ3R6YTkvdDJZUHZnNlc0?=
 =?utf-8?B?bDJRR2VjeHpmR3k3TlBQdllwVlBhNnpreVZQaExoN3kxa1B5QXFWUk9rOThF?=
 =?utf-8?B?dkpaNGZvTWNNVVUzcUkyMUk0MEppTDFOVnM2ZjFwUlBmcEVYNTZGOVFtOWh4?=
 =?utf-8?Q?hHkKrjdz+QiNs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBHckxSc2pSOEgyRjBSdmt3ZnN2TDZ4WkgzRjZxKy9USHJrNThIZ3BZbDJT?=
 =?utf-8?B?emE4N0hWcEoxVTJvcXk0M1h3RmtZVHkyNFQ3WGtaUEhwUHBFRHg2eVo5VXg4?=
 =?utf-8?B?emZ5OC8zZ0VNSVRoVjc5VmNrNmcyRjFjcnZ1MTFVRWhXaHFHazZ6SG9lUWRn?=
 =?utf-8?B?TXd2VDV0Q1FmNnZ6TEM0NERjaVpwT2FQenZweHRBdjJhUldEdFRsUTZIYzRw?=
 =?utf-8?B?K01tSUFaeE9WaDRUMGQ1bGE3YmxsSytjTExZMjlsZ0dCNFZhR1ZwN3hwUXVQ?=
 =?utf-8?B?VmZzaUVoU1ZHQ1Q1WExpd2xPMEhLZkVSSzdHeExFd2diNmVBMUp5cThRNDNM?=
 =?utf-8?B?eDZjZVI5N2d6RHN2VTFPWDYybXl0Skd6MzFZbmlWYVRtNXJBdmtVSTM3OTA1?=
 =?utf-8?B?Z3d2NVJqOURaVmFmYkVuY2F4TGJpbnhNNnZwYnIvellFTXZGQXBGM21GMHA2?=
 =?utf-8?B?RkN5Tk9qakQwNlF4WFQxQlJHNnJNLzJOVHVCVmVhcXhhTzFLL1E3bm52UkRT?=
 =?utf-8?B?cm1Sdkh2OUoxWncvT0NsalNCN3RHWjhhdzNrMngwNENmUnBxWU5MTFd5RWp0?=
 =?utf-8?B?SUp0WGF2QVJCREtpMXpwR2pDQUN3Z05ESkw5MUdJaTVjVzdyRHpWMm1NQ1Js?=
 =?utf-8?B?ejdFdDdrUUNqTjFMekhtMC9DNCtrTEsrUEVDWVZNZmZZMTZZNHNuMG1KWDA4?=
 =?utf-8?B?anBWV3RpQUdBdXZpK21QdSsra2Z3SXo3T0tIM2ZCNThlMmRZbzkwc3JoQTcx?=
 =?utf-8?B?UFRSczJBYTNaaW5IM3VORGx0aU9uRjNhRmVDMEZMblpnK0JDZGtYbW1oaTln?=
 =?utf-8?B?b291NnIyTmY4VkxNeXEvTEkxUDFaWHgyVzlnYjNOVVMzalZnQmRiTDFvZXBi?=
 =?utf-8?B?R1pzUUV2TTdacVZxaUhYT2NWdkxDNnpoUzV1bEVHR2RHZXJmamRQQnBCLzBj?=
 =?utf-8?B?MU1GeUlEYkJ0S2UwQTRFQkduM0VTSUo2KzZiQk53eGZJWVFIR1RiVFRQa1VO?=
 =?utf-8?B?dnVWSkpUMkl3U2tzVndPamprTjVBdGU4ZUJ3TEkrVTBaQWRYbnZrbllDUE1j?=
 =?utf-8?B?c1ZhNCsySEFJVmV4RGZXNmRHS05WVVZGRm9mRE8wRmNubTBsRnN6enJnSVcr?=
 =?utf-8?B?a096NG5rSUVQWkNVVGxIR2tpR281aUJEcUxSaGdmTmo4OGVRdFh5Q1VWOU1T?=
 =?utf-8?B?OCt5UWZsektCSHJmYkRXVGMxT2NicXpQYUVueXhOZysycDZlSzZMYUZCLzR2?=
 =?utf-8?B?Ly9xeEFvV1pkbkJ6dXdOamczQXg4ZVc0dGN0UXFXUEU0Y0JDU3crbVhtdGpT?=
 =?utf-8?B?WjJ4NWY0ZDVmYmZDYkVscFh4Y2xra3dleGV1Q1lIMmNWcnRTZ3U5QXJEcXJE?=
 =?utf-8?B?ejNWZzdDeDFzeXZiVHFPcFFWQWlHWXlVaG1vRGt3YWgyc3ozOVlXUldTcCs5?=
 =?utf-8?B?bDVzeXFtcndGek5sOXN0NFVzaVdHamFoOWxBUGFFeFdTdTVjY2ZvWGVlS0l0?=
 =?utf-8?B?STk2OXZCUUQydjZSb25XR1NKNDRKQVRHaExncHR2Ym5JZWZiUXIvN29kV01U?=
 =?utf-8?B?UUxUQlFpWmtTWkR0OFBFU2N3RWVmdElZTFljRmdQYlZ2Q1lBVVFiVHFoYUJ5?=
 =?utf-8?B?M1dCMENwSExBMFFVMWZOWS8ybVBOdGo4bUJ4UXQyMFZQL2VUUkE1VUl3MW41?=
 =?utf-8?B?ejdSc0NFMitoQzA2SDA0TVJrWGtmdHRnaklXSTQrSkVwLytNRXpld1ROc2FK?=
 =?utf-8?B?ZVBXVzZteTNKa3dJRVN4ckdCcERjbDM1SUp4Z1ZCMFlJRVRzem81VGRxUkJk?=
 =?utf-8?B?cWV4cHQwK2lJOXhuZGwxY25pVjh3M0s4RGVxNnh0NGEyM1pPZVl0R3pBa3dm?=
 =?utf-8?B?Q21kemdIdDQwTStsaU93VWVJNldaaWp3TTdqQlRMRnRxMC9pb2VLRzRjMVFy?=
 =?utf-8?B?UXRXRHhvRWFPN0IyMmFxY0QvRHdCeFBXcjNwaEt1cTRiTUZ4ZGpWekRMdXpn?=
 =?utf-8?B?Wnd3d0dWQlJRSWVTQTZqRUdaVmw2OW4xMVUzVFE1UnBVOTRLcDB1dHM5cHcx?=
 =?utf-8?B?bHdQM3FXZWNsYWpERGtXYVdDUXFlb0hORXFmcEh0L2J4MEk4THZSQ3JPZjhI?=
 =?utf-8?B?TEdZWDVtcUhHbkJYbXJRWkhkZmZFbnBhNEsvck9DWHJmSStLTzRLRjFKenN1?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d97f16-7934-49c5-c3d2-08dd5521779f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:20:38.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qKnBoOBa9cIOdf2ctG34xE6wz2YsMuL67kLDEg+Q8VCq+uisySMdD6Jg9aqeSEY9+VfBk29+F0/kT3tTTgEgwRWGXANyi5FrluqH+2AmVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com

Hi Babu,

On 2/24/25 1:18 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> 
> On 2/24/25 11:01, Reinette Chatre wrote:
>> Hi James and Babu,
>>
>> On 2/24/25 7:49 AM, Moger, Babu wrote:
>>> Hi James,
>>>
>>> On 2/21/25 12:06, James Morse wrote:
>>>> Hi Babu,
>>>>
>>>> On 22/01/2025 20:20, Babu Moger wrote:
>>
>>>> This sequence has me confused:
>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> index 3d748fdbcb5f..a9a5dc626a1e 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>> @@ -1233,6 +1233,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>>>  			r->mon.mbm_cntr_assignable = true;
>>>>>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>>>>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>>>>
>>>>> +			hw_res->mbm_cntr_assign_enabled = true;
>>>>
>>>> Here the arch code sets ABMC to be enabled by default at boot.
>>>>
>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 6922173c4f8f..515969c5f64f 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -4302,9 +4302,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>>>>>  
>>>>>  void resctrl_online_cpu(unsigned int cpu)
>>>>>  {
>>>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>>> +
>>>>>  	mutex_lock(&rdtgroup_mutex);
>>>>>  	/* The CPU is set in default rdtgroup after online. */
>>>>>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>>>>> +	if (r->mon_capable && r->mon.mbm_cntr_assignable)
>>>>> +		resctrl_arch_mbm_cntr_assign_set_one(r);
>>>>>  	mutex_unlock(&rdtgroup_mutex);
>>>>>  }
>>>>
>>>> But here, resctrl has to call back to the arch code to make sure the hardware is in the
>>>> same state as hw_res->mbm_cntr_assign_enabled.
>>
>> Another scenario needing to be supported by this flow is when CPUs come online later ...
>> after resctrl is mounted and potentially after the user modified the assignable counter
>> mode.
> 
> If the user modifies the assignable counter mode. It is recorded in
> mbm_cntr_assign_enabled already. When the new CPU comes online, the
> hotplug handler(resctrl_arch_online_cpu) is will update the CPU to the new
> mode after checking mbm_cntr_assign_enabled.
> 
> Are you talking about different case here? Please elaborate.

I am talking about the same case. James started with "This sequence has me confused"
with "Here the arch code sets ABMC to be enabled by default at boot." snippet not
seemingly matching with later snippet where "resctrl has to call back to the arch code".
My goal was to highlight why resctrl would need to call back into arch code even though
arch code establishes the default. 

Reinette

