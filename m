Return-Path: <linux-kernel+bounces-336346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A99839DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421031F2190E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D148172D;
	Mon, 23 Sep 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9gKiRBQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919B8563E;
	Mon, 23 Sep 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130543; cv=fail; b=Lb0TJt5r6iSLSpIgE0zl/dB7YAQ2P2KQ9Fdwn2p0VVWu8ZuZjJ/yQj7VhrCIQBVE9h8MsbWqOzjSF9Fny4XnmsKgsR8zirX5mIL8qK+MWHsHU6+JgGuwZZCLSJU9+toi72o7MJOxGd8hNRVS8TJ0bZ0rma4vikrJxEZCRVR3r5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130543; c=relaxed/simple;
	bh=3OcAZHZWV22nwC3ke10FBYc7Yycgubs/VDIbT5KdlNs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UospkXoot0YROpwjZO7iJgk4R2ANVji57ROL22vd2qYIWDjVCrNuLkJHkZwW17AXtCr+tRoQn+isX3WF/MTV001J6Y1EGLlYr2pZcqxjlIZ2pFRxCmHp/+gL/e6n6+GStdmAIrAPvN5i4CiDZe0hB63vp2vgnm2y/PfhGs9PWpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9gKiRBQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727130541; x=1758666541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3OcAZHZWV22nwC3ke10FBYc7Yycgubs/VDIbT5KdlNs=;
  b=f9gKiRBQagnt9D4oZV2MXb/T93YkElREd5vazFoHDTRYHJ51Rm9BsuiM
   E0Olp48B7PaFwLZUNM6Hc/Xhq1UR2abpLMyjVCMLki/bUoDtT7w+EwHw1
   3gghw6SdTnUAjDd7GsYMvG2/2F3IpgEcuC14H6dUggQKCV9VqtddeN1C1
   udfg8WXQeQlNRbIUSI6u/hLfhEhrPH0T80OX3ztywJqAtT+9fl8eXXxKi
   JCIH4rMJoJH3GhNQH20UelZeRF3MBXyyNT7gn8OPoELmwzoknsP7+vYLr
   4tZiRfqkfQwWaW5OxgFRpSJu5yFn/wUbO/u73kqj3fTDLufhnA5Qu4cmV
   A==;
X-CSE-ConnectionGUID: qfcfSiitT3W/6WpVYwrxbQ==
X-CSE-MsgGUID: 5axzpp3PRzKtIrt2mAxMyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="13732556"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="13732556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 15:29:00 -0700
X-CSE-ConnectionGUID: Os6dOO7zTMeegnUH7bsk9A==
X-CSE-MsgGUID: Jzk22CmsTiaG5CIgp6W12g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="101935195"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 15:28:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 15:28:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 15:28:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 15:28:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 15:28:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMzjBSO6tOgAUeVk3NQqcaZwSVjt5FgS6H1S3T81HLH03mxzrxpNcy2X+30716FdKnnIlp2fV2/lXy9Gm35ETCDsoO7luhO5GKsXg+gpw+Ab/hNihVw84xiC6izipJgaXSEKb4L8DDY5TcpLihPdN7K1IwhA6KKRErzyz09E0ACHCDPQUNt2TpBLvsU5q6tUd7XNm982xdDx/Z+CAt0Tac/yxCJM3Ko/NdBr/hD/IvwDWCYUGv0nuqkA8JgCCAJ1qJV25U8MNraALSnx30jlBVkuAo61Rlyt24xfdHLBCUyDENJYNgNfJxsqkIgsQ1lRRWXUuOCCW1zeROI03B3i+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/91+66KIgd4nPo/EnRhmd+/4dGlRYTOTOWyGli/fY/8=;
 b=wJmCdZyTLd7Ye2XFudTQLoixNVsYOqk2OYHUliN1SE7nRIf/a0xuUqkc3IKjdZQEC5oDVfWI59qiXeLgJkWQVZ+GPWQyzNoBKeGxVEIOy5t+m9dxp+0ZtFYHXcdZ1PLmQs5O91/61DmuG5J409n7q3U2gnoZ+U4A8vEL25El+9bpJXTcDQ0wI3NK/ZkIRKAVKDicTmxrIzq1r6lA+oI8H6fxKcPphgzykiLt2eOUYusXoUAf+trp44jnVm9Fjraa9784MxTRGTCqHgq0LjXsTncdTe+131ItiDRk3hca2HJX1vkFXficz/pZ73dAU2GNh23y7rdSwisCcuN8h+PH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 22:28:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 22:28:55 +0000
Message-ID: <175ac51f-62bc-481c-a31f-b1e372ac343a@intel.com>
Date: Mon, 23 Sep 2024 15:28:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/24] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
 <50084b31-49e4-41c7-be1e-24773d03d5d3@intel.com>
 <c333ce4d-3e4a-45b1-87b4-42a4d35d0ad0@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c333ce4d-3e4a-45b1-87b4-42a4d35d0ad0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:303:87::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ace523-d983-4143-23e3-08dcdc1f1c09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHRrblRkODYxTndWUVR1a2psSmI4ZGg1cDg0aExoczZVRlNoNHFmS2RaQldx?=
 =?utf-8?B?YlFyMWliWVpUbXF3QWVwQUhMNmdsYmwxWjFzNHNvWDNjS2tiWVoyakhoSCth?=
 =?utf-8?B?alRhZitLZlZBa0FVL2hxK3RHOENPNDlQQWs3SjB1bjRQNlFITFdKQVR0M1Mz?=
 =?utf-8?B?VWhVNzczQTJwQ2dnVlRVd1hJT01JdmFvcFpmVExneXpIcUpuQUw1UkxoQ1Yy?=
 =?utf-8?B?cTRJMlpBTUl5ampnTmF1NGJQNDR6TmF0VlNrNVdXOTFHNk8yc1d0ZnZUQ201?=
 =?utf-8?B?SXBzYWh4VVlUTExKZFNRMFVheGk3TVc3dzh1eVVRTEIxNHF5V3plQTVpSkty?=
 =?utf-8?B?REtQN0ExWEJNYTdFbk1KQmdhZjVxU2JXTkRWaTJFc3h6dHhjeGxxdGZtN1J5?=
 =?utf-8?B?QWNqcnpTanRoQ3JwVU8rK21MeUhjTG91MzhvN1BPM3lIWDAvT29ONitsam92?=
 =?utf-8?B?WGFJUE9pTGkxdWQ4WmZwTGUxREQ2UXUvVHduKzl2UXh3YzRpTnEzWTRmaUp3?=
 =?utf-8?B?QTJKZGdXOGREUDMwK09USFBJQVI4NjREZWpDN29mWjBjSW4wd0RXSjB1OE4z?=
 =?utf-8?B?RDNrSTgyb1czdUJVZW5zOGMvazlSOEVaV0p6dUV0dUNnRGpIandOK1NMYm9C?=
 =?utf-8?B?ZGFvZlg5Y21iaTFPWE5jNnYyVnlUTXk5OFc5SFZrMzdVNEFrMm9FOFhpSGVL?=
 =?utf-8?B?bWIrZWFyMmJxL2VkU2MrdGRqSjdrdzg3ZWE5Ylk3cXoxWjV6cUI1eWtldHN6?=
 =?utf-8?B?ckdDMU5GK1hmVUNhT1VKRHhPWk8yRUV5bUtKUUdvODlzaC9MUzRJQmpYbUxC?=
 =?utf-8?B?SjB3SFdxRFJFM3ZyellQaXBNc3pPd0tXNmtBWWo5dEU5UUxWSFZPdzBGNU1H?=
 =?utf-8?B?OXlMT2d6dXY5RVduUDlhMUk2V3B3RjJqc3l2VDdnZkhkQjNyaUM2M3padDhs?=
 =?utf-8?B?SW1tZEFqbkkxRkN2V1dBLzh6VWFtN09IaU5sengvc2hSenBMYVBleUtQb2Vl?=
 =?utf-8?B?VklwRE93enE0aFZlamlMSHBtSXRLYW9aelpRUVA5L1gwem5QbUVJK1hwWU12?=
 =?utf-8?B?YUhFOXlhWk1Ud2xzLzBLc0dMd21NUW14Y2VLR0JtVnlrdXpNaGZ2ajdmU21W?=
 =?utf-8?B?L2JCWVZUWTdtVjVMMFByNEdGT3lnb0tjSzB2eVVTTXBOSjlBK1pqeGdjZ1hz?=
 =?utf-8?B?aUYyQU5nQlpBVjlLQVBsaDRDWUl2bUhHdVJadTY5NVNQR0xOWFVlNGlmOUU5?=
 =?utf-8?B?V3pnWDR4ZjI3bzNvNVJYdXRtSUo3ci9TWjFyaEZxWnZuUzQzNlJNNGFZZ3pl?=
 =?utf-8?B?cVZrS0hQbmpKN1VHQm92dElrT2RIdDZlWUd2NWRyVzBSM0tieUNuL0U2VmVn?=
 =?utf-8?B?MGhIRkxaRms4elJtcjZrdDhDUGNYNTRyNUFodkpnakxEM0VhMnRBMFpXMit1?=
 =?utf-8?B?VkJ5cjMwMkk2Syt2ekpVYWpSWWVCaXk0MVlKRWJ5YkdqMGpPcEl2b09GZGl5?=
 =?utf-8?B?L2xGZVduK3hVS3U1ZGpzSVJpWnpFeEpicDJSQjM2WXZ0eDNxeTJZWVF5K0xR?=
 =?utf-8?B?ZlZXdXpCNkdJbkNsM3k0ZGJydE5YTy8wT3hrRU9IZVR0aE1yaGlnQnhOOWNk?=
 =?utf-8?B?VGczdXQwallaaEdNelpCZ0hHRk1ic0w5NWZXSVNmNU5UYU1lMUlZUTAwWHNG?=
 =?utf-8?B?ZjQvdURnZEdidjBFckQ5bEZpNEVsd1FhRnlpdlhXU0ZTUkd2aEdiLzJJUE5L?=
 =?utf-8?B?RC9ML2JlSnBxNmxDaGZ5YktiK2I3Q3lNay9ZY3NVbzlIMzVIOU1TQlpQVjJw?=
 =?utf-8?B?ZXFVZXgrRDlHS0pMREVRUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUg4bVlxSTlOem9KbGlySVRueHlaL2NiRkpHUkNINmxyQWYxMk1tM2lta1VD?=
 =?utf-8?B?YmQzZ0t5Tzd5TUFaTG5IWGZCUDA1R3l5QU1kN2dGdTBVN2N1SnBrV240Q21a?=
 =?utf-8?B?WXc2aExYZ3VzTjFwREtJdTdqMlcvcldHSmF6WktnS0lBRXRNMmNnYXcxeDE4?=
 =?utf-8?B?SjJJbUNlMW5SRjczMUljUjg3c3l1cFpwbG1jdjVqalk0dThLZGpKR3lhWTF2?=
 =?utf-8?B?K3N1UXJCMUtHUHNrSGt2aEIxYk1sK0krZnQvWnRONzcyNDZUbGI0VWFPMVpk?=
 =?utf-8?B?QlVpVUJpeGpTbnFsekkxOGJhVDY4aisxMmlHL0hyRi9UTDlCdVgyRmtYa2ZQ?=
 =?utf-8?B?bFFrS2x2R0orSDdIUHd3T0xXaU8wTzA5Wnl5ZEgvcVlGQjNuMUMyOTRmbWN1?=
 =?utf-8?B?dW5uN3RINFNLNWU3V2g0cEJCZGhiaVM1VmtxY2ROcEd5UlhUclpIRVYwbjUz?=
 =?utf-8?B?U0lPL2VyNUtyY2Q4UU9ZaGlDRi9TNW5rRjVmZmFOdFd1NlhEWnNCNnNVYm80?=
 =?utf-8?B?Z1FnZHFJczRwNlFMc0Q0Y0UxN3RReWR1TzdDbUNsZGl6OFMwVzNkZE1yYjlX?=
 =?utf-8?B?Q0tpVHkyQTJKR1A1S200SWVpSjZVMWRsV05yVjlYYytBT1NvbHBKR2VTby8w?=
 =?utf-8?B?UU5xNFpxdEhPMjFCbWtyK3hueGxGVndjZ01vVEwrV2piZVlYc1BvekdhT0VM?=
 =?utf-8?B?b1ZCNzBmUVRZeVVCWlRyQjltVEtyamppOEFOVEpPOTB3YS80TWQxRlc1V3c4?=
 =?utf-8?B?dW9tWWREbkJFTXBac3ZTbXdrZXlNbGlsU0FUZ1JKK01GQUYzRUxUcWQvTjZw?=
 =?utf-8?B?blJkcG94OVFRbFpEdUJGSzNQc0Vkb0h1VXlGWUU1V2hlNlhQTHJ3ZmxzejBN?=
 =?utf-8?B?ZWgyWjVIWmZaVEhvcVJmR2E2S3E5Rlo3L0dHd2F2cnJKNEt4cjY5byt1cm1o?=
 =?utf-8?B?bnlSdTl2eDd1MXd4WVZjdmcvQUZmUEVJU211eUw4ZStqUkN2cGdsaHU0VVJT?=
 =?utf-8?B?T2hBa2NrYTl2TENZK3V2R3k1dkhRbjMrU2RUU01YR3RacmI0ZjZGcERGMHNp?=
 =?utf-8?B?bnZSNHRNUE13QTJaaFlndE1PNFJrVFh4VDloQWQyZ3kwVGlUdGZmUnNxOFFh?=
 =?utf-8?B?NEFxUFB1YWROZytOVVlYQUtwV2tnUnlhS0dMcmc4RnhPVVo0dTFhcGtuZ1Rk?=
 =?utf-8?B?amZaMzAyaHB5NUFSK0lHZDVnS1VKc3E0ZW11RDdCOEFGT3NEeGhDdkQrWldW?=
 =?utf-8?B?VXhPN1R0UzFYNTAwT1RoNnJxdzk0emNZRE1SVFFXejdMMUVpdU44VDdac0Fs?=
 =?utf-8?B?WnJsaXoxTlRreitjYjBuVUhEVVFkM2pVcVlVczJxMEliWlNIQm8weEtzRkN4?=
 =?utf-8?B?TzNvTURiSTI2OGE0RzVmSXZ6VWZzUGNiSWNMQTVsTFRSWlN6RS9iQ0VQQ3pB?=
 =?utf-8?B?VjRxbFQrRHEveGk4TnF5N2FyUWtoc3RYcDRKa2JTOUFDbzBacGRRR1JyT01D?=
 =?utf-8?B?dHhycC9JdEg5NWdZdE95WmVaZ0JNejJBVm9JYnJ0N2VBVmpkSnlHRmlkMzU5?=
 =?utf-8?B?RStnMThZTjA1WVdMbVZzZlFVQlZQeWplcTNlSWdOT2xIUGs1Z0poZjMwU0d2?=
 =?utf-8?B?aHRoS2tRYkxiN2l2bXcrTkhpdUxWK3ZRcGNNdzdLRnZidEF3NC9TNWtObWVy?=
 =?utf-8?B?MUF6K2wwbFNEallXMWRXbkxKdFpGcUhzZ0tYajdsdVAyMFhTZk9xeGJFTFF6?=
 =?utf-8?B?RC9mNnZxWk5jamY2TUZKdFp4ZjQ4Q0pPWjQwSUVpeEFzS2V6SndTVmxtOGw2?=
 =?utf-8?B?RndZbnFPVFdUSFdlOTJBeWYvU1NDQTFQQ2xjWHdvNS92aVhxZmI0dE5zdzhw?=
 =?utf-8?B?K3pJdng4TytXQ1BhdzJEVmtjY0h5Z25EUHNnY3NuekJRQytTV3A5cVFxK3Fx?=
 =?utf-8?B?T0xVb3pCY1lldm1pdWlYRFc0R3B5VmlhbjhJMzBMdndENkliSVR2RjhCRm5o?=
 =?utf-8?B?L2U0eWU5cExOWUJQQmVCeCsxMnBMUTRndFozeHhhN3ZiODdTZWxneXltRTg0?=
 =?utf-8?B?VHRBSHB2R1d5Y3NZeHI4T2YyeC9kVXl6dVl5cmZlSnRxQzZVZVVON3dFMkt6?=
 =?utf-8?B?ZllEOHJ5Nmw0aHZCM2RkdDhZajVURTBZdzFzRjFjWjl4MzZLZTZnUkVyVUlY?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ace523-d983-4143-23e3-08dcdc1f1c09
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 22:28:55.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AhWEtSwxlRh/bRp6hLBOg7+WRMbRrL4lkyQWnKPQEe0x7GY8WN9BD/MQ3OGmLpESFO2f9voFdMATVmEQBIuaAJA+RepAO3LClK/W7724+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com

Hi Babu,

On 9/23/24 11:33 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/19/24 11:42, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>> Hardware provides a set of counters when mbm_cntr_assignable feature is
>>> supported. These counters are used for assigning the events in resctrl
>>> a group when the feature is enabled. The kernel must manage and track the
>>
>> The second sentence ("These counters ...") is difficult to parse.
> 
> How about?
> 
> Counters are used for assigning the events in resctrl group.

Apologies but I am just not able to parse this. How about: "These counters
are assigned to the MBM monitoring events of a MON group that needs to
be tracked."

...

>>> + */
>>> +static int mbm_cntrs_init(struct rdt_resource *r)
>>
>> Needs __init?
> 
> Did you mean to merge this with dom_data_init and don't have to have a
> separate function. Please clarify.

Here I was referring to the actual __init storage class attribute. Since
mbm_cntrs_init() is only called by __init code, it too should have the
__init storage class attribute.
I do expect that mbm_cntrs_init() will be called by dom_data_init() and
care should be taken when making this change since it seems that dom_data_init()
itself needs the __init storage class attribute. Looks like this was missed
by commit bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")

Reinette


