Return-Path: <linux-kernel+bounces-526441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD743A3FEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA9D703E42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91125332A;
	Fri, 21 Feb 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gbgj9JvM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16E2512DE;
	Fri, 21 Feb 2025 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162354; cv=fail; b=J8sFjrvEr5BG6hEXdVqUFiXDhZ/7dVa9vPVXT0wtd8vJu4xD3TQhvi52rxctSiY9ItMYQfv8xQ8m4Yp3+KiykbuqY7HAynFnPrY/wXMJ7RJ7WaEwd+1mI3Et3Bp1J5L//0SxdQA0CTAfZg2ilvYtJNUdlCRP+CGH/x+XziZIN9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162354; c=relaxed/simple;
	bh=tih9zaWxPQhrYPTt8VTDUkiyait0FoV7QqkWYj8kW4o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gRJ+eVTz7WHLTSKjqMxQcxJylhXDq+8L+Yx1LqnIvk0pfRVSO38GxjC1DG0+Gh7zkS0s6bajUHPkgBv2uks5X52j5f36szOWPIFN7jfXqvOiyF9DsWm+X42ZPGUZ8JWkkdTyfZw7h2aVVVA+u9Rtny8eswjwrGpPhs8uhNDZunA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gbgj9JvM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740162352; x=1771698352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tih9zaWxPQhrYPTt8VTDUkiyait0FoV7QqkWYj8kW4o=;
  b=Gbgj9JvMur2e6xhjXRFBJ5Q9dGUVRDjO3Pw0i96QVYXQ+hWA4ngJYfC9
   Lwn4Kdby3KqAGKYNyRBPK1wGribmf3WgWHV07TXaCDXY3xK7V6y0VVpN5
   rjUYM3+TI0lpYjQuknuKLfJLBFFtUfltvt+lPxSMx1jecs0W9xAIYDJvw
   3HOfMcD+CrWL7B5j1aqZ8hX04oXLGiIsmN8Nz+7oeZnlrls/FuO6+gcWG
   RtM8ZPtaSS+SEVuBLYDCmJVgKqV64Kpf+xLLfMoQiXb3DZwo2dXuK2LGi
   86uqXrpFVLeMUpQWordF2sOKEZ5ZWYq0KcHIPxYylVXaz26j3IzsxkW1k
   g==;
X-CSE-ConnectionGUID: rRKiy7ZlSD6QdKHAXf7fLQ==
X-CSE-MsgGUID: zK8HlsZ3QJejhp9orZ+ZGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44772824"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="44772824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 10:25:52 -0800
X-CSE-ConnectionGUID: lUqSAgkUShmN8e4tDti2Uw==
X-CSE-MsgGUID: uu/NhXhCTQK1jGrNDCcVZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="138666305"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 10:25:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 10:25:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 10:25:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 10:25:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STocC5wlzwzB7T/KTU3eMJ1ppS3TupSR1ceBXCNfS72Q7WGApgBauIz99B6szR31sM3P3e0f4OqtxvRIng8u8KR4xA8bryo8Yg9FlLepWVyzl/64TFRhwOXC54AAhrjaDfW5ybQuCa7dB8q7gs68BLCRUlARTbwdvBerEXNVRs53UEXqHvGCKieWY65gsXHIDsgqiy9hUS8CQQroh0CiA6AxEcxEb2rmXISUKFtwbpuAgjgMJDAmskNXGztB2ZtOzVc1dI9W6AUsKOBzyq8XFcHwXztNshU6UKIAaE+2yn3WHR2EcKssjspSgMAEa2KOsDbkKz2j1zbvfehdlpmxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxgKF3CbF8h/lzgArKhBYZm2pAmCHRgEqxuM45xfbfw=;
 b=afcocWO6K5H2PG/7sa/2hbfJl78uDayYiEuAlQL8gS2MWXDcaxwHk6FzGtPsfuL0tprz4nfZwjhAcTeUh/E/JSD1rmodp7X6mRGmB4KE7F75xmLC1A7zaixgAoFvvZvW7dX85zka5I1s3BioGqABsLAbmNjUco15YLAmsS6BpvvJGOOuV0VIEcgsqyPU8K/IXsqmEluYmNEH0YJ+UaDonAOkHhUnBARcrhWfPO9/72/P2n2nAzkiP8BDCmsiaQA4fGRNJnD+UjvV55hoEjSX5W0Jvk9wm1ZL1v/0CK9i6zB6c3GbmCs8bV605f6+GH7gUjAyEoqQ+P5F4M5ep9LapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4593.namprd11.prod.outlook.com (2603:10b6:5:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 18:25:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 18:25:28 +0000
Message-ID: <e524c376-9ef8-488e-8053-b49ccafd306d@intel.com>
Date: Fri, 21 Feb 2025 10:25:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/23] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
To: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <920cafec1920358ad0c8af2e78a8f8bbd8c0b77d.1737577229.git.babu.moger@amd.com>
 <797bb878-8049-47dc-b1c9-193158b9ba45@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <797bb878-8049-47dc-b1c9-193158b9ba45@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2649fb9a-bf9e-4da5-277f-08dd52a51e0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkVTZElDWlJJeGNXbU5taDJRc04rNFowc1Ywc21nYTlpbnJ3VUd1Ni9VcG5Q?=
 =?utf-8?B?UTlPWVZML001K2hzRVdVeGl6Vzg1RVZzRWgzT04rMGh1M0UxSjNPOWVSaWRq?=
 =?utf-8?B?VmJ5dndVa2xRS2h0Qno1Qm5SL3NnT3lhZzk4RjFpMXRmdDNpSzdJQkllUDRq?=
 =?utf-8?B?dHphK3ZCdWpGSmFKUVhSZkhsTVFSdWJxbmVMMWhDb2FEenVzS3pmdS8wMHRG?=
 =?utf-8?B?a0U0OXdENTBKL3M5L3BZUVZaN0JSeGU3S0xVWi9FZVNrTEIxUy80WHlnekNV?=
 =?utf-8?B?ZXNIMTc2akhHZnhxakVFWDR4c1BxenhlU0ZlWER5NFVnSmE0d2ZadnlxR2xF?=
 =?utf-8?B?cExwY0hQcWNYUllrVTVIdFRnWVJLK21xNmJycDMvRzg4Y3dKSjJ3eGJIWTc3?=
 =?utf-8?B?MlFRVmtaU092UzNRdXcvT3Y3bHhwZXptUzk3Wml6SWQzRS81NlpDUk5oMEJX?=
 =?utf-8?B?aVV1bDlIOVArZjRmcVJtWER6QVo2RUVOZGVhUWpXM01PdCtCVjIvVlZKSmlC?=
 =?utf-8?B?L09HYTB3UndlNUl4UlZDRmZidlYwWFVMTm9mSVVCWXVoUTI2UXRraFBLc0pJ?=
 =?utf-8?B?OU00empXRmNZMGQxOTB3WFNUdlR2UDU5c25GQi8yVExxd1NOS2QwWFJwRGgx?=
 =?utf-8?B?cWszcHhwdXNDR21ERDRyN1J4YlRrWVRyZklUU1VNTkpCN0I0K1BETkpYUkxJ?=
 =?utf-8?B?SnNVY2R4TUExUDFxbUYrNC9oYkZNbEtad2tjNDlEUjllTEdRZG52a1dKdjJq?=
 =?utf-8?B?czRrUVg1UTNSMEhNcE5iOEQreFlPeXpTWFNadnlhQmNxaDJqNHhPVXpuekdG?=
 =?utf-8?B?a3hNQU1xK3lrbXorM3ViWFJ1bDAyRXQ1TUVUN3RRaDM3Q1R6Y3BrbFkvTmE4?=
 =?utf-8?B?QUdBcDhLSVA4a3JhTGVsZUlWRXRVUFl2MCthVklneXNxc2VneHRJMXJBWHVI?=
 =?utf-8?B?TDgyS29RU0RLMzZsaTgxamdkc25yN0d0Y3c3Z21WR3VRaVRmSG9zQy8xM0w4?=
 =?utf-8?B?N0JHVm5GZEwySVRyRGpqWWxhN1NBQ1FSV1dsK2JJUkgrT1o4Tmo5Z3BQN2JR?=
 =?utf-8?B?SkovaTVZYWJFRzhwK09vbzlMZURqbEViNzViVXZRVjEzRTZhdDNEdEorNER5?=
 =?utf-8?B?TjExN0xMSGlnRVVENit4RnhrNmhQTHBtZ1BHOXRuMTFqdHdpcnBjZmxYRTIv?=
 =?utf-8?B?VlhXZFNkRWtsblpGTWJCOE5xZ0VVYzN1QzZTWFlvTmxINHpsRDRJdjU5RFFV?=
 =?utf-8?B?d21hZjV6R1Fuc21zVm9rK1VYU3JNQjlvVHBaeWFZR3hOWnorOTZvemdjSEJa?=
 =?utf-8?B?RzNOSE52RlZVUXV4NUh0UGdNQXUzeDllam1RQVdYR2RSaFBiVGVoUy9Zajli?=
 =?utf-8?B?K2FNM3JNTE9ra0JnL2VHL2YrdjJBWnJDSjhXcWFRblpqMFBMcjNEZEdrZk8w?=
 =?utf-8?B?aTFZQldzV3phMGxhWXp1NGNQYlNzSkRNbmw0Y2NYeDNhd2tGS2lra0xHNWlM?=
 =?utf-8?B?RytiR3plNkFSWWhhRGNTeS9QV0gvRGFJckhwS0c4Y2duWnlQYnJMUysxZDJw?=
 =?utf-8?B?Vkp4aGJ6MEIzYWEyMVA2TmNackd6ZGIrMHlDTDYwcG4vaVllemxuZjBidVRK?=
 =?utf-8?B?SDRROS9xejR6SEFYQzFoaTVoMEt0ZnpTOFRrdVlndVZhaHFjWHVEMEhwSGVx?=
 =?utf-8?B?RWpwd0FQbUwwMjQ2RE95eDN0YzczZlNsZGdnYVJCc2taaGxCK1RtZS95MlZy?=
 =?utf-8?B?dUtibGVvN2dDWi8xSkZHMzY2RVE3MHlWTFIxTm5HK0ZUeHlZL3FtMERTQUZH?=
 =?utf-8?B?TnFBZS9EdXlTeUhMOFh1a1RxWWo5U3ZFOGJVS2FVV2ZOVjQrcjdCM2x5NzF1?=
 =?utf-8?Q?1B+BHrQpuaGR6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2hYcWkxVU9XSkZsQjdHbVpxaFdJbkdVTG9teHU2MUlveVhkZkM1d1lrZDJH?=
 =?utf-8?B?SGVyMWFwTlNIcmEvMUl5ZTE1b0lzd2RXUnp3M3JvdGxXMHFyYkYwYmtkUW1j?=
 =?utf-8?B?OUhrK1hwcEFBVVBzbndlMUlURElUSE5HRHF3a3RCUmY4L1dhRnVkMWIzc0Fn?=
 =?utf-8?B?cmN2aTRZeFNGd3BKeFkyaEhZN1lEVmZ3eXMvd1hvV1YyV0wyY2RBeGZUbFlD?=
 =?utf-8?B?ajNjcldTc1MrNXRzbmNGamY0MlB0L3g0YzM5MGkwUTE4aFBncTFHR0FmdUh5?=
 =?utf-8?B?em5HWUxaakRKenJIOXVPZFRXSnU4T3RnOXNKQkwzYkhGSjFPTmRCM1UrYnFF?=
 =?utf-8?B?OC9ZSlh4cWJiT2RJaWNLNEVyTEMxN0dKTUowOStRVzVpMXVsdS9yeU82bE81?=
 =?utf-8?B?NEZOSm81akM0Szc3L2F4V0Q2d3R4TEZwcVFqckowRXlKaWdrWUxVcWdUaEZz?=
 =?utf-8?B?TUFBcTdQenpBQjQzZHRBSHdwaWxFQUNzTUQ0UmdUZGNoZEdkWHF0TU5lMmJV?=
 =?utf-8?B?ZzhwZmw3eEUvcWIycDFrUTdMU3dVZjVMU0x3ejhqVm9SUHFkVDBiTU5nV2dw?=
 =?utf-8?B?M242UGpvb3Q1S3lmODhkS3RjTjVQOVhsZW1xdGZ3S0p1aE1tNXdwZjNGclRJ?=
 =?utf-8?B?TUlkbkFFTHpWOCs5VnFId3JMNFVDTjl6R2tFaTByTVp5eStKTHNublZkMVha?=
 =?utf-8?B?U1R2S1VIRlU3czIzamdrSHdSMFRheGU4UHppWXpLdTNIR3doMFdOSkh6SFpa?=
 =?utf-8?B?YjF5OWxnOVRmWWN0d1R5TzlZU1pMK2YzTHhGbXY1Tk84V3FGbTNJRVl2TjdS?=
 =?utf-8?B?ODd1TVBZeVl0L2hqOGUycTJ0OEUwNys0VVRUb0N5SDdOMTJyRGd1SVgxN09R?=
 =?utf-8?B?MjRFMlZiRVpsdDR1eE1lZHdMeHpNTEovclV4YTUyMURnUWF3UDBzRGx6NjFM?=
 =?utf-8?B?ZlVONGhJNUF2UnVxSFhOSDduS2pMUDFwMzIxbDVPeXNOYVdrVUFsN1BWMk51?=
 =?utf-8?B?SjFwRXJ3cEpKbFVNR1E3OFhtN3lQbmZLR2tQOFNTUDQwc2VEbXZET2RTbUJL?=
 =?utf-8?B?aERCYzNoUDExaGxBRlJSZUk4cm9wS3VqKys3SkkzQXZUZmVMQm9JNEdoUHg2?=
 =?utf-8?B?MWFEVEtZdk9kNnQyZ0o0UUtYWmJheEVtVW8zUE91ZTY0eEpxVk1SVWVEcVpK?=
 =?utf-8?B?Sm9ZVXZTeTFTaGRVQ1dhcDdScE5WK0tGSlVtRXlxYnhOdDNWZjJUYVNsbHJo?=
 =?utf-8?B?RVVSN2kvZXBlKy9iVnpMZkM5aFpxTVFEYXhjVW94Q3oySy94clNNNGZOVVlI?=
 =?utf-8?B?YTRqOWNFUVNCWGFQbWJFUkNPUS9ibXhMaEoyU1FhM05BdTJTRUhxeVFYWVE3?=
 =?utf-8?B?SmhFYmRVY0NCaUJzUXNBcWpMQnYrd1c4Tlc4TlVZN1l4NVErd0tyVlE0eDlY?=
 =?utf-8?B?Ti82UHByNUIyRkJRT1orK3laL3ZqQ0l4ZDh0S2Q1ZW5KTDlhTkJ0N0dveWw0?=
 =?utf-8?B?R3EzYW8rdTdJWWw0MVAvL2ZHY3NtSFhoMlFIWk5vV1lhNGUxMlphYnFLTzlM?=
 =?utf-8?B?Q3dobmg2cnlsL0JFZEhUZ1NidUpTSTlJNzRZYllyenVLeEplTTRZcmdZQUc3?=
 =?utf-8?B?TVlpLzFUSUVpWUNNQk96S0ltUGc3V3M3djlNRWhmckQwSFAyczVjMGRlL3pl?=
 =?utf-8?B?enUrNTFucmhHZ3dPRnNSRHljd1owRytBMTBqT0xRT0YxZGE3VSs3WjJ1REty?=
 =?utf-8?B?dEttbVhXRmNLeVcxN2FqT2J4M3JaNktodlJDemwzQzVtMUEvd0dXbHdQYnhX?=
 =?utf-8?B?QVVqbFZOcEd4Uzlqa0sxNEFWcmd1ZE1rd0trOFU4NGdaS1QraTFlNkJBc2wz?=
 =?utf-8?B?eDhabEI5ZXZZbStKK09VajZoM3dydW0yODZNQkhZSlNvdjNYWWphMVo0aHYw?=
 =?utf-8?B?TWxlcDBnS1dUVFRPWTB2OGRyeUZHck9DWmZDM2dnY21rVHVDU0dJM2dRczN5?=
 =?utf-8?B?S1FsSjRybHgrdXFPMmR5WDNoS040N2V5cHVXR1U3Vk1XcHp4bzFGZEc4TllL?=
 =?utf-8?B?dUU4Q0xxbzhsV215SW1UZWM4ZjFobU1oZ3BBRURYNEtVK3p1M3BKMnMvbEZP?=
 =?utf-8?B?WW43bVRhQmF1Z3Vmc3lXTjVodTRyK3JYSG15WngzR2ppSnNJa05wc3NSQWUv?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2649fb9a-bf9e-4da5-277f-08dd52a51e0c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:25:28.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTzBW0mZxkfRIVFStN16ALDOOQ7Y/h3ShhVBTBhHZqADQpdtPp2FF01o8xpVBlVOMqxx1DH0l25JHluitX9WSU0nCzK3ZKJMu65TwF4lrZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4593
X-OriginatorOrg: intel.com

Hi James,

On 2/21/25 10:05 AM, James Morse wrote:
> Hi Babu,
> 
> On 22/01/2025 20:20, Babu Moger wrote:
>> Add the functionality to enable/disable AMD ABMC feature.
>>
>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>> L3_QOS_EXT_CFG. When the state of ABMC is changed, the MSR needs
>> to be updated on all the logical processors in the QOS Domain.
>>
>> Hardware counters will reset when ABMC state is changed.
>>
>> The ABMC feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 05358e78147b..ca69f2e0909f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -658,4 +663,6 @@ void resctrl_file_fflags_init(const char *config, unsigned long fflags);
>>  void rdt_staged_configs_clear(void);
>>  bool closid_allocated(unsigned int closid);
>>  int resctrl_find_cleanest_closid(void);
>> +int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable);
>> +bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r);
>>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> 
> A minor nit - but could these be added to include/linux/resctrl.h instead?
> This is where they need to end up after the arch/fs split, and its harmless to do it from
> the beginning.

These prototypes were moved back to the internal header to follow guidance
from Boris that was received during recent software controller enhancement.
Boris advised [1] that items needed by other architecture should only be
moved to include/linux/resctrl.h when that support is added.

Reinette

[1] https://lore.kernel.org/lkml/20241209222047.GKZ1dtPxIu5_Hxs1fp@fat_crate.local/


