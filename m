Return-Path: <linux-kernel+bounces-417425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB4D9D53E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF127B229B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3E1C830E;
	Thu, 21 Nov 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WS+l+dBY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A141BD03C;
	Thu, 21 Nov 2024 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220405; cv=fail; b=CWBmuJOj7IDlMwH0ITjBl3bxG5QIAE41PWPbn3PVtjXEdLs0wfL6HbyYHjotim0REabRFZ64Snff0h7xdEq3nTJjgJn6zmbhu2X2Y5xMiHSSQP8vjMSh3cPLrDpS+WlMJcfkKd1+rA52OgLs0xV3oJ5AsPxSf3k4u8weGOwyoxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220405; c=relaxed/simple;
	bh=/benwleMnrNbcsHkTIzonqpyj/p9ZyopP4JpHWQg68c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+/53xvNKjnlshcTAPZm0Cw0qgJ4HMuX+1f4odHDcKhgdXs2Hxn0UVx+Mif+wU00y7EF/Efbg9hXZE5sZMijmTMbbyxPqh0H9ewje2uiEsncwXckeTE8WbaXINsOvhNQFL1+S2cxJHzz32BSOjnnIlWgUggqTrPPoXY+RWkGjPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WS+l+dBY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732220404; x=1763756404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/benwleMnrNbcsHkTIzonqpyj/p9ZyopP4JpHWQg68c=;
  b=WS+l+dBYlbryDLokYW0gJSeAf+pyj3Jj8SXrlJvb9V8S284Avr2ByitL
   yu1GZ4DKtM0d7DWksD3QSO3ZOj8YMT9AwIYL/74SuoubiGvg5dEpoct99
   hZALwEMSVJG+YZ4e99M/HXn3SVUcURzVcAwRLjPDvvpKXw7XRe4U6O7Yw
   NCfNSkZTpeAaqCbKMDlvKpFjCMGOk7/Ny9ht4Fpld2bd0Zy9wP7gCInkh
   uOLKaFVn1aqORLrJhzXgANif+GhfYnlpWYhEWV26HSBBNiFIDe9hevFmj
   dvRRT9l/BdBgbHtpeei0a6ROBbl8KsOwHALey1kQVTWSmvwZyu0BaeeVs
   w==;
X-CSE-ConnectionGUID: yB+wKz57R2mtxvSPUmH60w==
X-CSE-MsgGUID: 7fL9crw/ReaHRbihK/smvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32106827"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32106827"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:20:02 -0800
X-CSE-ConnectionGUID: o9uPZYneQDKFKuraWKmNhQ==
X-CSE-MsgGUID: m6tlkNxwRIKUuLm6Vqa39w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="94449254"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:20:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:20:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:20:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:19:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOWMY9C3Dxm3kKKJO2NVVzFfKspBL43UNo8jirjKIh141koCBEKN7D+Wm9gdiY4MGos860wPOlMZ7iy2KAzPhnDaSa2qSqDpXmhSffmy0sQilpG7jjQxFCqPJ54RoUbnqxgeU1fGNbVrFpi4mFZeJEkikGm6GErygG4LaxR4I1JGyVC6nlGghoCh55744Ucd7fa9VYz47/WuLl7/+3AGojveO5k0ZRGaHUUHSN/o2mytSurocQPmXcBN/FXST3kOYjTP7zwTo0T98VkVtdff2U5KaGbieJnn3SAdRABkO87Xxtt6HgsZMvNyhlmoh4Llz4wMVZVYnzrCcNozGW+HEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkRQm16WlaVlFRFIOFheEQMAoThu9k4jev58+WtBbpU=;
 b=T5TARSlAV76xM2iFQLXXJwPwMBZOC32+t3itzR7smDPkHZkowzWwM9gnUQkBlHFKmKEGf8DuBnSfPstjkhauGmMwOk4+zQIVoGaJW/k/rX21Uhp1ipXRkOXpDPesGWwjWA8DVJqgyB1Z50VAMr5ehzTUwa8I2u1VkOKvyZtRPE6g1BlepV+MnTwMWAt9uZsH3s3fkdoCuCZK7VBjYu7+wcp3Em0f0MnuUuPY3y/Zi6cGESgi1hP1Z5D6Mh0lEW4sOx0eLMomY7bitgpVPEwYM43DSvagx7a/sJczcjQQo2UhvPskPuCP0KGKYROjir0DwPRWTF/T7LqvgcX8HPCeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 20:19:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 20:19:00 +0000
Message-ID: <a1417f89-7d07-4e9c-ace4-1248fb2f668b@intel.com>
Date: Thu, 21 Nov 2024 12:18:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
 <5a7d8ff1-91c7-4e75-9730-3aa0703274a6@intel.com>
 <e108846f-930b-4afd-90c6-2266af96816f@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e108846f-930b-4afd-90c6-2266af96816f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf5a980-4eae-41a7-1187-08dd0a69bc39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEpHYStleWRJMW82bGw1RzlScEdwTkF0aXpVUmd5UVpkRUc1Ykl0Z24zbjNr?=
 =?utf-8?B?UnMzbmdzbmVxYnZ5U2E4a2ZKR2xOV25DK0t6cEFNTkx1eVY1Ykg2eFJHTnU5?=
 =?utf-8?B?TjNGTjM3Z285MXRKekZGMEFHaFdVbEJNNE5GbVRUSDc3UHEvQllNMlFFSlBy?=
 =?utf-8?B?ampselZzVGprV0trb0pldzdpNFZSSlhaSDZ0ZlYwam0zcVFSTlZsUFBPRUVE?=
 =?utf-8?B?Q2VPWm5jQnhQelVkazRtYnY5Mkp5bE5JRjUzRzM4UkJBNnptZFpaaXpSZGZX?=
 =?utf-8?B?OUtRblhTUTZ4MXlmRGtmcVNiMUxhSkZsM1ViS3Y2akkyOThpckVRNXpvd3pE?=
 =?utf-8?B?eWlwR2I4K0lsVFByL21iZmJhdXBPZVNZT0VxWlBLUDhCcjEwU3ptSjdHMExt?=
 =?utf-8?B?am1oNDRIck0weTJqNFRoRDBGdVpoL1RzT1BBLzVSNjBwdDB3ZlFkTXhGaHVJ?=
 =?utf-8?B?eWtLbkZUQTJPWmMrMjZXSEJRRmZUWjZYQjE5ODdJWm1wY1ZEeU9Ka3pheFdl?=
 =?utf-8?B?V21jdThvRGlnY0E1NHhVaHZrOEJqZVV3dGJnUXlMT1J3N08rTHBsbUYwT0pz?=
 =?utf-8?B?cUcwVmEwbXJYVzdpYXd4OGE0Mkk0dExwSWlhbGZzSFlQeUM5NUJ5c0NPTDB3?=
 =?utf-8?B?djFCNkNjQTZnMm42Um1adUk3VldiRThBQTlPNDkwNDVVUEs0L0N2WUIrTVlG?=
 =?utf-8?B?ZW5tVEdjVCtqVGdDMm5QWTZHSmNWVXUvYWc1NnJpSWpLcEM1NW95d00vMWdV?=
 =?utf-8?B?eW91ZEUzWXl6cEF2VE9IdnVtZmJkRXovTHNjNW94SG9MQk0wWjVOblM4WVVF?=
 =?utf-8?B?R0RmdWN3U0ZDS2FteEluekRObytXQUUxUGZSaGpleStoVlpRdzJjSmljM29D?=
 =?utf-8?B?SlQ3WlNBZkVuQXJxOGN0ZlNhL3IwdW9iZjRKYjZJcmI0dGMxS25DRlYzNU1B?=
 =?utf-8?B?b0dDcDFaMHVrZytxTXFrVmY1T1dwcUptd2VrYTVoYndRR3F2cko5VDZ3SVR3?=
 =?utf-8?B?dzVSZDhCR3ZVM2lJWCtkNGpkMDJEdmxiamJNTFdZQXI3Y1ljUmZFMVdKSko1?=
 =?utf-8?B?WDdYaDBDajRUTXR1aVVYeXVZK2xNTXVKN0lXZ0NsaUN1N0pIVVcxUm42WWlW?=
 =?utf-8?B?bGZncWJzTkJGK1VDNjBXRWpVSlV2TjI5cmRvQm5pU2xSVEJIVXNXZEdhdFh2?=
 =?utf-8?B?SHc2dVMrZXZIRVloZjhyZ1A1RWZOd1JrQmswdHFaRCtTMDFSL2pkQ3l6TjZU?=
 =?utf-8?B?UGNTeHgzWnllOWJ4VGFFRVM0WElJZ3JlWllQZTY1UHJWZUlPOXlCSEdhOVhF?=
 =?utf-8?B?SlVLSHZLekp4dmNaY3dJY295Nm14R3ZjZ0I2emc1bG9hYlh4YlR1dFY4N2cx?=
 =?utf-8?B?Z1JVbjZLMXNrL2hBVWpMa3Rqay9CRGRrbzlkR3RLd2t3L0x5YjcvSXFSS1ow?=
 =?utf-8?B?Rkk4dXphVy83dW1qN2RLU0lrbGZWYWpkYjVwdVhTMmZ0YTVIeEhDaTdLa05x?=
 =?utf-8?B?aDJhVC93SFZrQ01nNTFQd2luVTA3NE5RWldqUjBYMjFaK1UxRzJ5a2ZiU0o5?=
 =?utf-8?B?V1h4ZldudEV6dWhIQ3M3cFJzcGRDMjFrM0VwTXcvQ3BZalk2TGlaenh3VEJH?=
 =?utf-8?B?K2NOQjhvWWtIS0FURHU3V2g0bnQzWDhlUFJsVldsOGkxb3diRG1lQ1dQMEJE?=
 =?utf-8?B?VjlNOUNtSFpNQUcxOHdsZXRGTnZxNGV4UFhuUEpRWUtwcVkyNEFINzkzVVYz?=
 =?utf-8?Q?TuLfv8JDILZRQQTnbNHisU7fbb7QnsJScyRiEAs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnA0UFBDQUxQOEJnN2JhUEVLZTJTbE5sRm03NnFVMmNMYjFHTTh5OFlvNmRo?=
 =?utf-8?B?c0NVOUROMWZNUStndHlYZHVaVGJ5SlFJSndYNWtoWk5zcTdoZUc2YmpFdFlU?=
 =?utf-8?B?bVJibmVjS0lQNFhHQzVPd0Z3SUdJWlBOTjFETGNPaHFBbXNPMHpySE9FbjBT?=
 =?utf-8?B?T0sxY0hyYWh0VW9IRkw3T0hyc3RQcFlkV0lva1Q0djNyYjh1MFZReFNacTlY?=
 =?utf-8?B?ZEhMQUs1bHlSVDhEVU9LN3A1dVdENldUMjBBZUczeUsyN0IweXpnc3ZIOGFa?=
 =?utf-8?B?aW5RcUNCTVRUS2tCdWFOc3ZDS2ZpcW1ZZ1cwVm9Wbzg3alRCQXpQYzdZazhu?=
 =?utf-8?B?Z2VEdlliY2FQcS9TOXJsZWttcDRhVWFid0RlUnhXaTlQQkNLVWgvOHlpUWNY?=
 =?utf-8?B?c1Y0R2ZkbittL3FkU2ZqZnFDUkczVnd2blhSc1J6bWpBZ3pRL010UnNpZHJy?=
 =?utf-8?B?ZUY0TmFJalNwamM3aDVJTjZBcDFnWHRNNmdiNjlrOXpCRU11MEpkYmRoS25D?=
 =?utf-8?B?bzNUNGN0TnA3RWg4WEtEUGxYSE5XbU9oYkVOV3F6UWZ3QVRDRjl2UkRwSjJa?=
 =?utf-8?B?Qisza0tMQWtxNDZVWnI4bWRRZCsrY3RIeWhDRGVMOFBYRkc1bXFqZXFBY2cv?=
 =?utf-8?B?ZDd4ZHEzRklxT2tJeHFLcmVvL1lXRk84cXREYmdlTllnKzh1ZTR3M3JMY2xZ?=
 =?utf-8?B?STZUWkFnQlRsaWFxbDY1eCthNzZpeWdQNkNDSDlESy84ckg4a1oyUHdxdXFZ?=
 =?utf-8?B?M2VreENTY0lmNDlyM3VCZXhlU0xacTFQUFNpUXM0cG90MTNxRnRObTltNElw?=
 =?utf-8?B?K3dsd3MrWCszazI1OEZ6bmhVK21EVzFEMVJ3cEplZU9NYitYK2JXUnpGVmM2?=
 =?utf-8?B?aDBmT09BRWI3cVVxWUN1Tmc4UmI1SXNScG52MDJBRjhOWll2N0JUT3c5RitW?=
 =?utf-8?B?K0toZTd0bjhQL1BtRlRCZVprbnZuNFg5S1hGYzNnUm1scTB1cFlKaC9UQVk2?=
 =?utf-8?B?MlEvYmhqZU5WZm5Gc1VXeHJGeG8xRXpHQnBLN29vTXZJc09lZng2b3I1dldR?=
 =?utf-8?B?MFJKajJmeGJTZHRaZ1RFcnpic05MbWsyVlVpOUtCbldaWWZCckNsc0FITVUz?=
 =?utf-8?B?WVpPM2FTUjZlRFYwbUdjM1VIVTVIMWtMdGtYZHI5QmVTa0dIZ0xWcE1vWG5u?=
 =?utf-8?B?Y3RLVWF1cVFDUkJpMW1QNGE1ZGdMVUtEdTRYb2hMUGZCMDJ1S3FXamFxaUJs?=
 =?utf-8?B?V0dDcVlBVUhxWVczZk5OZU5ndERPNW1lR3k1Tnp4VFhCRzFOc1FGVzVxQWR3?=
 =?utf-8?B?Wkxod2Nvc0I4TC9UaGJGK091ZnZkb2tvNFJJd0lnc01XVzFZUE1uNGltQzRk?=
 =?utf-8?B?L2E5aSt2S0VQSDFTYmFRaXFsQlg1SFNNekFEZWhFaUNQYW1QR0hCaU45OFJ2?=
 =?utf-8?B?ZkNmWU1wcDBqT1ZkdzBhNDZKYWlJL0dSNmsyNTBzWFZnaC9mUUh2dHhVTzd4?=
 =?utf-8?B?UkhHK2JUc3Bhd1VjdzhtcFJ1MWtkbDhMaVhJZ1h1dFFaVDBnbExncjVqbVZY?=
 =?utf-8?B?NE5MYmJ3VEhpSk52RUhqV2MxNDJkU0tIZXlyZXNWZ2daSTdRaDFzMS9rQU5o?=
 =?utf-8?B?OGR6WGtPd0txc2ljSHhyWitrYVl3Wlh6RTZkV2loZ2MxNHVIenBYdE1HWDQ5?=
 =?utf-8?B?NFloTUZFaEt5OHcreTU3aUpPd3RGbkExNS9YMm1qcDlSQzJFRnBKc05CYkRz?=
 =?utf-8?B?a1ZPUGVRN2NYSXZNZjUrRFdXTk9objVSZi9yRjNrdFNWekUzZWl3QndKWWg4?=
 =?utf-8?B?M3pKcitMMUVFTzM2Wm9qUkdpZkMvQUZWdlp6ODZ3THRSMzNNYyt5M1MvSDFw?=
 =?utf-8?B?b2xkZnJwY1JLbkQ2UldXVWVLTG0zNjZ3ZGFQMWtXdWtPSGJzSlRGVHhsZE5E?=
 =?utf-8?B?ekFZdkFRbkZXbkRwQUVKV0JUbXFlc0lRT0IzUmIrMlBsWWV1M2pSQTh2NnBX?=
 =?utf-8?B?SVV5WDJNc2FDSDkrMEtCQWF1OGp3bmJ1RHljQkRUa1Bnem1CY1NuQkQycjls?=
 =?utf-8?B?VHhZcWtKdkZEZVFlL1grdUlHeTYweDlsL2VWMzVvK1VwSVNVTGNyV2d6YnEy?=
 =?utf-8?B?MlpzSnVRRHdwc0NEem9EbVJyNUZMWlBmZkhtR0JKMHh0Y2FHV0FFb3pvZkpQ?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf5a980-4eae-41a7-1187-08dd0a69bc39
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:19:00.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiNticalRlAwTWL3b9QqeFrgIQvtXDDx0d7k1CJsItFa17xucPQ/eD1t7Q209m5PYm6j1WQwWbxepSYO+2GJ7I3qtQSlRQy5GMuQx4N99f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
X-OriginatorOrg: intel.com

Hi Babu,

On 11/19/24 12:12 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/15/24 18:44, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>> The ABMC feature provides an option to the user to assign a hardware
>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>> assigned. The assigned RMID will be tracked by the hardware until the user
>>> unassigns it manually.
>>>
>>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>>> specifying the counter id, bandwidth source, and bandwidth types.
>>
>> needs imperative tone
> 
> How about this?
> 
> Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and
> specifying the counter ID, bandwidth source, and bandwidth types.
> 

ok with me. Exactly what ChatGPT suggests.

Please do note that that first paragraph informs reader that
a counter is assigned by user to "an RMID, event pair" while the hardware is configured with
"the counter ID, bandwidth source, and bandwidth types". There thus does not seem
to be a clear connection between what user assigns and what is programmed to hardware.

Reinette

