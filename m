Return-Path: <linux-kernel+bounces-378849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98469AD64A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147061C20F88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15981EF08A;
	Wed, 23 Oct 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nw95QxjQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431719DF4B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717437; cv=fail; b=W3Mzcpwsj6xL9D7p1mSqSOsbNN9+m2Ub1ZJgWaow0569sO9yHoSQZOgPEZr9yBj5X7g6gFIhG+lrXfYsvkielHSYfEsVjQZj+39qDuV3qXncDe8w2olsb44mv2ouTZIgipVlhBnU8T/rBfxcvfkS8TGgvGqpr9c32RsGw+P6gSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717437; c=relaxed/simple;
	bh=S4KAbSaXsQ2d6vqeEL110P9lhyeW89j+7RmecX9bs6M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Seci5gRs58FbEP57Q/HmFNQzEqvUVChq8GXLih6xMYONse4CJTZhlvbvlA2oWdIj8gCqn+eJD7NViFogceTmjgXfSRY0m1HcfPM3j4KTw9oZO7Mf4cbdG8J2z20yB3eeJnfsy65UqWXg6lCgBsn9+c6sFleEOPXcSbptiqcxWQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nw95QxjQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729717437; x=1761253437;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S4KAbSaXsQ2d6vqeEL110P9lhyeW89j+7RmecX9bs6M=;
  b=Nw95QxjQFGvRiYetR4bWvrcK7+TElPmli66KuqR8fpTqeB+opv9SAK9P
   i5NXlMvQvYCn/cKrkVPJ4nI8q0d9A4BjYx6JMhGhW38uBbq1WZH2AmUYx
   UvZsnWUwViqT1Zep5yzkiB4TTMMskaAWD378RmpeAduAUrgybCuuS+NrU
   XXiobPzMGrcXF78g3mm8UxB0WkmL2oTPFBaeobQXeN+kxiIMMGIh/NwVt
   luH4kkBanXCUXCa4PvyGJtV6VT38c3qehWLfcXjJ9iyHlvjYhNcoKkBQd
   WeXD4DcgXcHFJfwh9RRu4vjfPmNOvkKO4A19NibFtvFaWTShHfdha9DFK
   A==;
X-CSE-ConnectionGUID: LDZYbMe+SGWbeT5Tmxw1GQ==
X-CSE-MsgGUID: GkFXrdOQT+KkkiBXHwJmjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29260677"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29260677"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:03:46 -0700
X-CSE-ConnectionGUID: Q1ir2l+8RZ+w5pOHkB0mZA==
X-CSE-MsgGUID: 43O/QIgJTeGjKdhIo+2BcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="84364608"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:03:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:03:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:03:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNLQjnv4zoVrJ3v9n8RGlM/CS1uampKoWz4MYnGGfd1XMK7r9PPecJd8cSvtsIB8z7kfJMqjkeAI7/KMlBXP0OCv4+RNjDl92b2zcrPn7GHTopLoOhtW9K4ADNQTRIz+RmFKFnHSZjrPAbq2dub13y6ct7U2Woa+viMST5LtSoH+zm/CepQFEf5HespRueTJdysI3oxMhWmB4xIl3U/liZHTEIfB9PdxtYHu7BUXWTxOdBUTSM1W9gRegDflLet5ejIPQimWeB2AyIBlheiBD7xTO9hbBObGpVoltF09H6hF/QJPDg2n+1g3O2TjMB34OGoCgaovbBT80NqBgGoa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXMa3tlPq/IRrPMwWmdKT6v7z8DLlKrO68agsmo7JRo=;
 b=lptSlYDRPRvpa8fkVS6hAvO+2On6kEvU6sG+TaBZ2YJbLqMc0vtRuj9OVew44iBBqRno8ha5x0rE9YvjObTFJadHf+kq1j1dRaLGkuF8oFssrgcI8xxSI32BWTyG1H8tWnlfYLDKazWMEnOSr60MbpFuaybfo+/ZCKVpSipIo3kWRpoo0kBBStrhL7+AXnGdiG2LfVrtlokVYfSv5zF0fpFV9DcB44W8IBGfJrOYGs6JE2RLULDaYwNvoSCDfPOR9kLg8qPiv0PnRzcdRK2c0sel1wEXIDlGwKQ31LSo2byn1Km0+3AFZMX9t4PCw0ojbGz50wn3JKEdwUSvPwhUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:03:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:03:37 +0000
Message-ID: <8d4896ea-9bb5-4565-b678-51a63c560747@intel.com>
Date: Wed, 23 Oct 2024 14:03:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/40] x86/resctrl: Remove fflags from struct
 rdt_resource
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-4-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20241004180347.19985-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cad005a-f8bb-4f6c-ec3f-08dcf3a62a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzBzcFNqMW1BTmp2OGh6dUxyOHFFSDErYndLSi9VOGZEMFhnWm5yUStHWTJZ?=
 =?utf-8?B?dG13eWZNZmlFT0FVb2h1YjU4SDB0MnZjSjR1YkxaOE4rZHFNbU9hZndsM3BM?=
 =?utf-8?B?a3JVV3VDR24rWUc2czJrREJ5R3JLMnF4NGcrZnBrVldWb1VYM3BiL2lnN0E2?=
 =?utf-8?B?cmQrTE9QTWlvVk85dXc1R0xMb09xTUx1SVlPRFNhYXlleW5PL3FVKzhLZmZR?=
 =?utf-8?B?NWxyNm1oN21keVMreThScnE3azcvL3ZyL21qMjBYMmVqb0tkdHg2RmRnRk8z?=
 =?utf-8?B?RXVJS0VFUGgxdVpJdXFMTXZoZnRIckJIczlwVi9QUGQwVE9TdEFycS9zNHJI?=
 =?utf-8?B?emVXRDEwdGQ1c2NjZGtBeXdJUHNOdktNWEdzQjJKSkxzU2lJUkRoeFU3T1F6?=
 =?utf-8?B?STk2YVkyM1dwdHB4VVZidlc4S2RiUEJvRFc5REVsL2N1b2hkaDgrcENOMHor?=
 =?utf-8?B?KzBCVlBwU0hsbjV5T1JnM0pzRzEwcVZ3WjNRVXZIanBFVHZOYy9odURibDJG?=
 =?utf-8?B?d0pPK2UwdHd5SWVHa1U2OUo0QkVjWlJnVmZGc3pFcHhGSFlCaHIyWm0ySkRu?=
 =?utf-8?B?Z1YxWmxxSnlOVlJUc2Z6YU1FKzAvUisrakVIMjVMeW9yY2sxeFhEQkhudzF6?=
 =?utf-8?B?TGdRRms0c201MDV4VEdGZ1FtM2o4bXY1SlY5RElNR2FOdER5OGhzSG9YSFl0?=
 =?utf-8?B?eG8zWDcvSG1pSDYySGRURHBDRkNyemc2eHFFdjIwY1htZzc3TFp3TkNwSk5w?=
 =?utf-8?B?bTVFNExmM2dDZDZXMk5BdzJCVEFGU0YrMDFVRUxBbjN4dFZldEc1YVc4d2xE?=
 =?utf-8?B?enhqdTJIT2IwRXdFT2pPUWVlSkhBb0tmS1FQMzFocWJWV3YwM28rSU5iYk44?=
 =?utf-8?B?R3h6MWNUZE4xOGtBdUFrbmJDK2hyUEpYMDkrbFJNbWVkQzNhOHBIQjhRWmFQ?=
 =?utf-8?B?SmVWYUtPaE9mUnVYWm1ycU1aWDJObEY5K2ovTTNMenBqNkFtZ2VmZmVVQkxV?=
 =?utf-8?B?dnp2UFE1Z2EydjBWU1o1eFdkRmpiSTdWY21Veno4Nlp3aUVHTTM3UXllbzBp?=
 =?utf-8?B?MDd6enBHL1dHWDgxbHBodHROVGFpOTV5L3BxK2RXeEtOK2hKaVBtYVB0Sjg2?=
 =?utf-8?B?L1I0NGhSM0R1UXNoeEN3OEZEYjE2aGVQc3hmcUtyNW8yNkFSeGpRcWI0MUJX?=
 =?utf-8?B?YlZOSjZXQkNTdWRnNDlNTFA1TVBOQU9kZ1QwMHpjNlQxTVJjc0IrUi9rMG5W?=
 =?utf-8?B?RjB6TFJ2UzJTTEJaMVpOV3F6bmduTDhBWVkrUTFiMFhJTks1SStaWWJtMnhK?=
 =?utf-8?B?WEFBckdFRi9HM1VJMlhic0dsWFZzVlc1aWRKU1daYmpRRmFSaWZGS3NUR1Bh?=
 =?utf-8?B?akwzT1pBNlpKOXM2Y1NYUXFxWiswMWJXNHQrNVA3VzNJUUJWQ0VnV0ZWVnY0?=
 =?utf-8?B?WWl1VkZDWHFjb0l5cEYwK0Q3QTlnZTZDRUNZc0llV2lyQXk2TWpUTUhHVnlj?=
 =?utf-8?B?SDdyaUhFZU1YZFV0a0xEZlZLUEFKYlJOelhPdkNXU1pzMEdTdlFZbXgyQ3dm?=
 =?utf-8?B?YkxvVkhtT0FJNnF0UitwcUd3Wjl6bmZYaitkNmNnYmt0bERxd1NFaCtQdlVk?=
 =?utf-8?B?blZ4dTlvVzVvMERzTFJPV2o0WGwxWlBZUEEyUHI1SnBxQjk2V2dIdGRZeWY2?=
 =?utf-8?B?V3A0OWVacmNlNk5JSFphWnBudEFsVDFxYTBkVFVqV3IvZlZ5MDFmK2NseUtn?=
 =?utf-8?Q?RrWShDJJXMFfAb5Tcw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxZcGJzQ3hWeExJdFRtQ0xacDJuSlNZY1Z3SmJYRFFmM0wwaFJUODlTTFQ5?=
 =?utf-8?B?YTZ3YTBnVms0T1RacFVkNXY5OUpHWFA3cTkva1F1Q1B1a3I2ZXhnR09UaDYr?=
 =?utf-8?B?ZFFzZS9xZVRwSDFCYUxXVDRxbm53UURReStDbXZHL0o4UWlmcE9wVHFaK0ox?=
 =?utf-8?B?Qk9CWmdFYm81Z1IvQTNWeHJDZDFnRU9SeW9Za2IzYlloeXhtUElLSktEWDkw?=
 =?utf-8?B?R3V3eGNnRVo5czAxWFhZM1VVcVlJaTV1em1td3Zjc043OUNMWTR2ZTRuY3Er?=
 =?utf-8?B?UGtCcXV4eTBrV3BuM0dPekttQWpjNTNKdEV1cjlzcWU0WFJ3d01JbmNGRVFU?=
 =?utf-8?B?QVFubTFkMk9hME8yclhYRDlsSnY2Zyt5ZmQ2UU5Kd29oTTg3ckVsUHdxMXU2?=
 =?utf-8?B?aFk0amdqWDVBUVg0d0t5L0lja2JZcHFGTnJFbnpIM205NjJYenhEZFdHOUla?=
 =?utf-8?B?SVEyU21LbnhLQWdFamJtck8yWUZkUnMvUUJyeVdoV1AvMlNCamFhbU9rMk1M?=
 =?utf-8?B?SDFjcTFyMTJiUW1pSWVNcW5kSnBJaG1IUkx0R1FCZ2NpdG02VG11bG9Cajha?=
 =?utf-8?B?UE00NXhoVzVtTUhQS1l3UldrOFplV2ZnYnFtY0FsaWdXaEliL210bXpvcTdW?=
 =?utf-8?B?WEkzbW5wQmE5YTFianVkVnViRGp6c0dRN0JuZXV3a3RZZU1HWnNHLytabE4x?=
 =?utf-8?B?RE9qSmRVL1R5VVBlKzFFbVdRMnEzK1MzZDVpNEJPSGtodjMwVzRrUEd5UjZT?=
 =?utf-8?B?bnAwd016MUFHSG1vM0g5d0J0cEJ5amM0TDhmZVZ6Q203SGsrU002U3ZDa0hi?=
 =?utf-8?B?S1hxeWtSYmdrWDNJUjFWQXVpTDNqekhxUjVLZC9jSmFpSlZuZ2xHdUNya2lP?=
 =?utf-8?B?R1hwSUZOVXNndTh1VmlGSS9YeUdocTd1alpvamllUWxoWkJGVjBFY2dhK1ph?=
 =?utf-8?B?YWRvY2dUblYwckliQzhqZFVnMGlBcm1mSUlDWG5ONWc1SmE1UHhZNzRUa2s4?=
 =?utf-8?B?UDVzSmN6R1dSeGtvVEliODZZczR6d1V1MGlpL0kvMUVra2JzYmNLS1ZsYkIz?=
 =?utf-8?B?V2dFcEUvbTNVZU9QVGUyelFLYkI3NGRzYkpzNUZ1NWpScEtpK3VpcFdacDRW?=
 =?utf-8?B?eW5jZ29tS2trd1lTNnVZR0wrOTNkM0s0YlpYT0FlSEFNQkx5MU8rM3ZFWFZw?=
 =?utf-8?B?K01aK3M1ejZ0SHBkbXRja3VzMHRKMHlKZUZZdE11WitVMlErd085VW5HNmxV?=
 =?utf-8?B?VG84WCtZbEg3M01BTnFOQTFxQnVkYk1xU1RLbjZySW0vRGhSNUZDOW1kbmdi?=
 =?utf-8?B?aFV4aytTTVkrMzQ3b1k5WTZaTnplQy9tdlh0R1lWWVRtWG1qamVwRXZvN3Yr?=
 =?utf-8?B?Z0l5Y2NNTlJQVGt1K2NhNExENk05Uk1LeTNCS2xDTDhSQ1A4M1dWK09uL1NG?=
 =?utf-8?B?a0RDMmUzUWgraGpEais2amJMMjFoOEl4R1ZxU1FWY01Xei9qQll0N2JKdHFa?=
 =?utf-8?B?SnhIenkwbUFsRS9wVmQzN0RvT3EzMUoxTy8zakFUdUdJODNDaTQzanE5cmt2?=
 =?utf-8?B?OHRtRElKWVk5bU1ySVRORHk5OGJjdkVYYXQxalN0M3lieU1NUExnbnpiQ05m?=
 =?utf-8?B?bExwcWFkcTdjck9KbTVYZHN2YkE3YituWXlMcWtEblQyaGpsVSs4d2NWN3Ra?=
 =?utf-8?B?dDZHUitPUEdBTjFLYVYveEgvZ1MrOEJSeDhFalJiU1dFK3lkSnA5aEQ0VGVU?=
 =?utf-8?B?c3VPL0MxeUF0UTRTMnJ2YVJyd2w5RktubFdveUJNSk1EUHUwdHdDWmc0Y2ZC?=
 =?utf-8?B?d3A5RklEWW42UDJBenBMSGQvK2JnQ3ViZ0lEZjFkRG94MVd0clB6MmFVNm5F?=
 =?utf-8?B?d2ZhOEwvTng5VGJCc0hqWGo3T3QvbXZNVlB3Zzk0QlNXS0MyY1Z4SzBSTzZX?=
 =?utf-8?B?N1hFYmV1L0h5NkRqRXpyT0UwUjEvK2JOa2tQMzJ1K2FYa3BFWHBmdVUzMkFW?=
 =?utf-8?B?MFc5VlBjWWs4Q1Q1MlA0WUtXOWRFNEp0WFd4bmR3TWN4Q2tMR2EzZ2tmWmQv?=
 =?utf-8?B?cU9uUE5jTHlTSlBPZGlFaVVobDhhK3h6ZCtrVnZPTXI3VlBvU1lEYVUwZlR6?=
 =?utf-8?B?ck9DU1RWMmlsWGExakI5aDgrbU45aWVpRng2eENFZjM4MmdqMmEzN3VBMkVj?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cad005a-f8bb-4f6c-ec3f-08dcf3a62a34
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:03:37.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMas+Zl9ADj10rfELxBodo//Nca0vuAR8kLsBuguBjz3d6prV29OIr7It008sivcrGBdSIAs/pkYzI5XVIsv3VetQxllQUzjQpXoPgJf8e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> The resctrl arch code specifies whether a resource controls a cache or
> memory using the fflags field. This field is then used by resctrl to
> determine which files should be exposed in the filesystem.
> 
> Allowing the architecture to pick this value means the RFTYPE_
> flags have to be in a shared header, and allows an architecture
> to create a combination that resctrl does not support.
> 
> Remove the fflags field, and pick the value based on the resource
> id.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v4:
>  * Removed an extra space

Looks like this fixup was squashed into the next patch instead.

>  * Fixed a typo
> ---


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6225d0b7e9ee..2abe17574407 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2160,6 +2160,20 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>  	return ret;
>  }
>  
> +static u32 fflags_from_resource(struct rdt_resource *r)

What is motivation for the return type of u32? I am trying to understand why this is needed
considering the value returned, variable it is assigned to, and the functions that use it
(rdtgroup_mkdir_info_resdir() and rdtgroup_add_files()) all use unsigned long.

> +{
> +	switch (r->rid) {
> +	case RDT_RESOURCE_L3:
> +	case RDT_RESOURCE_L2:
> +		return RFTYPE_RES_CACHE;
> +	case RDT_RESOURCE_MBA:
> +	case RDT_RESOURCE_SMBA:
> +		return RFTYPE_RES_MB;
> +	}
> +
> +	return WARN_ON_ONCE(1);
> +}
> +
>  static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>  {
>  	struct resctrl_schema *s;
> @@ -2180,14 +2194,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>  	/* loop over enabled controls, these are all alloc_capable */
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r = s->res;
> -		fflags = r->fflags | RFTYPE_CTRL_INFO;
> +		fflags = fflags_from_resource(r) | RFTYPE_CTRL_INFO;
>  		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
>  		if (ret)
>  			goto out_destroy;
>  	}
>  
>  	for_each_mon_capable_rdt_resource(r) {
> -		fflags = r->fflags | RFTYPE_MON_INFO;
> +		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;

Fixup did not make it here.

Reinette

