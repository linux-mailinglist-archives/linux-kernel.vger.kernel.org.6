Return-Path: <linux-kernel+bounces-550458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C97A55FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369A41893770
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0F145B27;
	Fri,  7 Mar 2025 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMgpdwn6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4A13D503
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741324042; cv=fail; b=eY7JC4O3LYBIsVJltmicQzAWp1lK34KkPYod7semUAFe4b/F5CnDao4tSKnpYvWAINCEwXqIFS2IgXyKaq/lpZcroBn7xwp3vDRWq4Lc3qklBXSU0JOI8syRQ8VmbgcggJJFvDtWwb5i1Il+eFXY619GyxIMoJ5KSTGqQTKxc7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741324042; c=relaxed/simple;
	bh=zCJlkQueuJzSW6qUE73aheBjOKHYStXxP6AK9QSZNQA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gkl0o715WBKFOq8p3ICujv2uYOn/kaa4IaO1F+bILvAjNnuLwkMvQD3zyAXyTeGvQUEsQjcfx3Yca1QAh+m0khtSr95zhNPaklJvJuYKhHcR/Ld++XmRH0UFkyDwWGqBNyc35MTq17fFB8MtkG1GMVaUNbbDzpjzNbv0oflDVbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMgpdwn6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741324041; x=1772860041;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zCJlkQueuJzSW6qUE73aheBjOKHYStXxP6AK9QSZNQA=;
  b=RMgpdwn6RmqZSCgs0Tx3KTpIv0zyZlHQFWcvNGCfo3+WHfs1gRcsIJlz
   k1agpvWeITmXcPzQOM8/kOJysDEm42eM6WjZufHCPwjLVh9BUTXr1Ncs3
   5KS+702FwO/rLdNapLvQWrHdJtWfVhGyyIVzF6UAVYklns1FDzAHDXX6X
   z3gp9769OONOZVAYbsnJAqy5UPChi9VyKH5JeseXBO5MZclkN47YtRdV5
   bbyBE0y52HIjRL8rimbvXurPGQaIE4bli3GUVaqzhGKtQAu+iz3VKqa4J
   lhGd7NjQVQULsNcAEDomakDga09PHvlkBadN/NDWHMuBUtHIObOvgpgM8
   w==;
X-CSE-ConnectionGUID: 3OA8WYH3RB6CnaALHOVO+Q==
X-CSE-MsgGUID: RuTkCs/qTtek/WaXZqKMfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53006247"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53006247"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:07:21 -0800
X-CSE-ConnectionGUID: Kz4PGUtvTHe65PLPcJt7kQ==
X-CSE-MsgGUID: NHod68EBQsib/IN0eqbmCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119150925"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:07:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 21:07:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 21:07:19 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 21:07:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5uKohNspDtvvb8ABjrVejgEzyI7M1cmCXIZKtHb091NYZ0vT6C++aOeqBoxKJR1LEPrhh2w3R6oJYDyc0Xb7TOou6jUSc/t8ipiWSY6gLGJIx9n/bwmgV/wp/erUf2FnRVY6ulGtLL61bNlErKYEtWP+I5zWG9Uhcmwd8HzfDhhUiSjjwq05JLpfkvBJrXyIGnzhgsuselg4oM25G/ShDp1Uvsz/wVGOm3dyduKSNZkVtJTsfMdRr0RyHc26shAGd2tSsbFaaoVuGzUO7BmUmkusETXOmCo6GiCLk59yEyArhMLhxz+fADCDDciZ22fV9uoRFrRi4PrzMxvI3yngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URc59P5XsLNzKpinA3C5hs0uCzKeS4xtCbMiFTERCTE=;
 b=Ov038h7VgBNlLsrfxaeY26PAtARVvDRx+hZMbUG7v8N42LuLCQ3p5Re0sbypn8L3MNaknKTo4bwGhp7n7gCT9jU2/cktAdi3M8ZrZuJh0ATq7JWQUbsd5kuqudEgwyeriEdbQSKwpKMlPMIaJSujs45+tY5gcYux6IruhUvAiPXHZRbqfrCjpSLXbcu1M5oJupIEvpK5AgwAQ6n1PkQbWVkdEY4csTnbJypz5phrQWvVRajfP2dNAbyd9PeZNOAdDTDpDZdDmuG0Q7giYmkwiwvxwYbWbIed/OSVqj8IA3U/U20IhPV3xq5vy8yALlmrUJt2xwFjCF+aSz5lrFvSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 05:07:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 05:07:16 +0000
Message-ID: <33cf0a63-1b76-4156-81b5-93f7c2ed1064@intel.com>
Date: Thu, 6 Mar 2025 21:07:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 47/49] fs/resctrl: Remove unnecessary includes
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-48-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250228195913.24895-48-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:303:b7::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 617766f2-3eb5-4259-8457-08dd5d35edb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0IxTWhJNTZsSHBuMFRCdWVINjdWTFB6MWUyWlpScHoyK1p1MDlzcnF4SVYv?=
 =?utf-8?B?Z3pxMTJ2Ym9YUlZuRXFzTDVoaW1pOXZLajEzREwzcGNMSkRLb2YycDZPdWFy?=
 =?utf-8?B?UDFUL1ljVFBDbHd6cXFRazhaT0twQU5UK0xDay9jME5EdXJrOUtJRGVQN3NL?=
 =?utf-8?B?MUp0bGp3MXdRUSthd2JpKzN0eEg2ZzlHbHNvRTRLMlAxYXNTcWs3bDlZRDl6?=
 =?utf-8?B?SGkrZUZiOXE4QVlWVDJJUjVwY1VoUTQvZDVoTlFnR1dGZUp4Vng2RlNYV2x0?=
 =?utf-8?B?Y2JtUTN1K0RSZ01Ic2IzdkkxcjVWV2FRRTI2QTdsVDJZV2U1b29wWVNnN0pW?=
 =?utf-8?B?cW1OOXlSSkJ6eEFCUFduRjRmcjM0d0lLRHcxcTJtNllkWXFsTm5SSmtkMGpo?=
 =?utf-8?B?Q1NrN0ZNcmdLZUhueDh0YjlkU29WZm80ejVNUy9Najlma1FtNG83dElOc3JS?=
 =?utf-8?B?SUVZRE9BTjZmREh6NGN2Vm4vYWFyQ2dHUmRqekxZUm11OFhwa2htQXhRU3VM?=
 =?utf-8?B?c082eXpEeW5iQnBoN3BVbWJoRERpY3lDMXVXOTdHMzlaUjlVQ1Z3eXE2K1JP?=
 =?utf-8?B?WXN5c3E5a2JrTmczbjJuTi9hTUtuYnZGeFh0SGpNak1RbGgwVEUybFV3enVW?=
 =?utf-8?B?WmVlcHVIMnNzbFRsd0hYZzlJZUhpMk15UHpkSkN1NzNTNkx5SlJKVER6bFdR?=
 =?utf-8?B?YS9scXdOenpYUmZ0V0MrV3ZqejdzZEpRMDRidmxobUpZc3ZQa2FURlNmTVhQ?=
 =?utf-8?B?T2U5OHlSUnAydDVPQUJ2RzU1bUMxQ29rMjFBbjZiUFRJcTcvRnZXalBMODVO?=
 =?utf-8?B?UHFZTUI4NlA3aUJjY00wY2FJSXMvdmh5aWxxNHF2MlVIREtDLzlaTEMvVkdq?=
 =?utf-8?B?SVh3aFcwTCsxOWo0MkhUMXdEdFdDQTdpKysyYzYvWlUwaVpldWxLVURGendj?=
 =?utf-8?B?eHVQNlBZMUdSMVRHamVQRHkzc0xDWG9pb005RzdtMGF3akJYYUwzTzQ3U3Rh?=
 =?utf-8?B?NytSYTI1c2tnUDRWUHg1VENXd1owbzVyUWhPQy9sZWhCVjZDZU4yWDhMVjl3?=
 =?utf-8?B?YnRkVXkzTTRsYVNtTXRkclR4b05aUEdDa0xJdmtqS0puL3JZZCs3b1ZMRXlk?=
 =?utf-8?B?d213Y0ZNR29lSUU0a2lhUVR2SEMrQXlpS0FOUW91djZGTk81a040aEZHcllz?=
 =?utf-8?B?WlZ2bXg3dHVyQ3phc0gzQmZmbHJuOEFWdDg5b0RkZCt2cHdtTEt6Z05GTmxz?=
 =?utf-8?B?ZXZycEZoNDZaai9TdHo4WTNBOTg2d3FRWGsyNHozMmxUVEp1MVZ4QjZRdEhJ?=
 =?utf-8?B?VGg4aGkzTkIzcTJXZ1NmU0luUEVEb214ME9ITjZQVW1WYklHdE9XcW1tbUVD?=
 =?utf-8?B?QmJrRVplbnVUSVdCc2tweThvTjVXNi9BUndUNUd4MHIvMWV6Y050UER2aHpL?=
 =?utf-8?B?ajNaNGZQTmZ0ZnV1M0doaWhmMnN1Q0J3UGk4WDhpWmRTbVplZ2U1Ti9jeFBL?=
 =?utf-8?B?NG9pWTNXYWQ5alRka25GZWE4VDE4eUg2em1jUlNaajBWTGN4UHJiM2piTk1w?=
 =?utf-8?B?UG9sdUxJUndCMVVQNnY2Z21xajJpNm5pbk41V0ZGM2RITnFnbW5SeFYva0pQ?=
 =?utf-8?B?dXprU2EzVU9ZWk9XZmRYSGxXNFNLMnVaM0NCSklEVTN6RXhWbytyU21DejhJ?=
 =?utf-8?B?YlZVMGJDalZtQStIS1c4MUp1SmNOQmdJSDNham5nVUJ5V3I3LzRrWmxDWU1Q?=
 =?utf-8?B?QlpxZXJyVEVnWnF2cnFueHVnWTNGWmcyMmtoUHpnVHJKcE5rSVVsS3ZUL2tB?=
 =?utf-8?B?eVJQbGw0WUZ3NlZ4am5DcEJ0RnQvSFE3SVNpeFBNZHpKUGdlWldYeS8zVnVZ?=
 =?utf-8?Q?XUNfFCM179w84?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTNZeHd0T00zWm9UZXlqL1Y4VVV4UlpzSDBNM3FkRHVYbHVrczZ4d3FZRENL?=
 =?utf-8?B?eXV2aUFJMEtJUXpQdlkrbFNnYjBkZjFNeDQ5OWRzcTgwNnQ1R2lCNTFacHRE?=
 =?utf-8?B?eGRlOGdnYTdVUVRzM1NVU1JCTytlSCt2VjFwYUFrai92eHZhNVp3OFlJdUNV?=
 =?utf-8?B?d2wvekR4ZG56Q3ZQNmN6V2U0U3p4aGRCVVRGak9jckNNMmgwWjV3YUhYZ2lj?=
 =?utf-8?B?dDhwNStoM3VpWE92MGZxZFNzUzB1elQ0U3dta0FMdTdVV09TTlYrVG9xRXlz?=
 =?utf-8?B?RFRESEJyemdXTDhmbThQZ0VnR1dVcFhzTExhZHBxcFQwT2NGSW5MTzdFRHdJ?=
 =?utf-8?B?UWxoZ291cjJocGgvMHh0aElvQmovNDd5S2xWVys4RDkrUUFTMVpRbmxvTU8v?=
 =?utf-8?B?N3BLdmlPbW1QeUUvQlF0dDhRaTB3djhOQ1dWaGQ3azkyZ002RkxOckdKbmRw?=
 =?utf-8?B?VGgweUtiNGdibDkrdGwvUDdMVlEvSStrUkUzTFF1czdLNTluNU9MRy9LOEhm?=
 =?utf-8?B?SGFNZ0J1L2cwWkY4OVVkMkNpTnpXY25XZW1WbkEwVVVDSld6OXJWS2tiQWR3?=
 =?utf-8?B?ZVIzK1ljNUdTV0cyalJRbGFXandkQ0NHdyt6TC9ETVE1R2RQeTRTNGZBUWlX?=
 =?utf-8?B?YXllT0ExTVdzaW9heXdWem5laDIzMi9BcmpDNmd5ZGhZVFJPQXVSMG5EOE5v?=
 =?utf-8?B?NVJtY2RvcnlMRlFxc0RkMGlUWTgxQ3YxbEVJMGZHV2I2dUJ5U3VOQmc0dkZh?=
 =?utf-8?B?K3htK0ZYSjZyT2RkVExzR2pMM1RGWnFIRzROUGwwYXBpRWwwMEI5a2VLbldr?=
 =?utf-8?B?TktuOStiMGl5M0JhcUlUL1NFS29KaW1VelN1MzRXN3pBV21oZSs2SlFPaEpM?=
 =?utf-8?B?RE5zN2RnL3hHUkpSZ3ExODhxMFlNS1ZhRWFkc05ZOFlOeHFGS29VbTFlLzZR?=
 =?utf-8?B?OHVaUWxrTlBQQXJrYis3V2Nvb0VTZCs4RUhYN2xkWWVjOXRVd3Yrc09Eb2xv?=
 =?utf-8?B?VmVXQXVjTkJKeUkzaUFhWkVtcENMN3BQczVzaktSdURVZWtuclBPUWlhT2RH?=
 =?utf-8?B?WEloYXl1M2ZOdm1FSnRNcHFrTTB2UEUzbmpOWGRlRUNHOVd4VVI4NjlaSUkw?=
 =?utf-8?B?TklqTzZsYTlIaEQ5QUZSSVMxVFRFM1Vtcm5oaEphSC9zTURPditHMVQ2K1dZ?=
 =?utf-8?B?YWFZU3JyVkcvajM1cEdJOUVRNjFGV1BoeXVma21NVGdYWFYwUXZwbHdhdDFB?=
 =?utf-8?B?dVo2TGdFNmZwOUUxUDNsdDJieXRheEdScmZITEZaQXhCR1kvUFh3YS9TT1hF?=
 =?utf-8?B?NEsxZUhuVFJqWnRFaXd3Mm1aalFFUUV1RUtuTlBYM1N4cEZLWWhNY0daOUF3?=
 =?utf-8?B?MHQ4NEp5RjhuckFmeThnSU4rVzRXS2hxQkl6OCtWT3NHMGIvZWZpSzVWeSto?=
 =?utf-8?B?TnZzTzIvYjFxWk5qR3owUjJqaFZZWVNKc1ZsVGhkcUd3SXNWNktBRnhmVjZK?=
 =?utf-8?B?bitsSVpOaWYrZVA2LzdobUY4dDJMTHpWZjFEMUJCNXkwakpUTHR3RVduR20r?=
 =?utf-8?B?bmxuN1ZLbHpMWWY2Z2VLSHNkWFROUEladW5uV2dFdHFya2tDUFUxVmxJOXlv?=
 =?utf-8?B?Q2NEMVlmTzZXdDJOMjlaYXBRaFZnM3E3U1FuNFVldVJJc2hyWm8vNnVudE5r?=
 =?utf-8?B?WnZObGhpcWJtNzJjOHZzcnJmQW4xTmlsa2xiOUo0UHZHZWt3b2xMdXFJN3V6?=
 =?utf-8?B?VzY0S0cxaWlPSlBlUVdQaHEwUTlwcFlMaU5HV21lQ3ZYVjNCeU43K0NyR0ZE?=
 =?utf-8?B?K0RydlBmT3VPMHRmOXJ3NjJNaHpabS9QVjBaVGZLWkVHN1JpdlpURUJSQ1pO?=
 =?utf-8?B?WUxmbW0yZ0lZSHlwMFdVY1VNUjU0ZUVoeElzVEJOOWNJTVQ4QmNQR2lKdkpw?=
 =?utf-8?B?WHdubDhMSzRIZGJVUlhWY2lQZ1NZWDlWMDIzZlBtc0JIVngrK21oalRjanZU?=
 =?utf-8?B?UGpOVkRISlROYWswVElRRnorRHo1Y2tKNWN4ZDJ2ZEZNZy83OUZIb0ZFSVRE?=
 =?utf-8?B?dnB3VnZFVmhGejdsb0FPZ0VhMEhvTk1EMWhlWlkyWCtGR1dpRHBXTWRPLzhG?=
 =?utf-8?B?V0l6MzJOcU1wckF0eHFnUDlzWU1QbmJXTHZFMDRUSFZNVG10RTNISWNmcXZH?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 617766f2-3eb5-4259-8457-08dd5d35edb1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:07:16.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAxLjRllfYSUpgrcUHvS/GXlJXjyevFY1RituOXhZjbucxLfvrwY530jORPFLBTzl4DXpRamoav4cvCoNx+k9sU3fbzisN78wl+dbUebYIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:59 AM, James Morse wrote:
> When splitting and moving the resctrl code to live in fs/resctrl and
> arch/x86, some code was duplicated. This was done to keep the parser
> in the script that does the moving simple. These extra includes are
> harmless on x86.
> 
> Remove them to allow other architectures to start using fs/resctrl.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

I think it is going to take more digging to find all the
unnecessary includes. For example, one that was easy to spot is the
include of linux/kthread.h in arch/x86/kernel/cpu/resctrl/pseudo_lock.c

Reinette

