Return-Path: <linux-kernel+bounces-349872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9E98FC84
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8778A1F2316C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D273D55D;
	Fri,  4 Oct 2024 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhY+5Ck5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250C1D5AC9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728011743; cv=fail; b=E/ip3X2WSoMeNlvkjmyxsrBPe3n++qEFo1mcT8375CfIyNqHn3r6NUAA/eG4ZFVva2gZq+ji5Sm/O/UGrXJuiPN71PkFeGHSvL4aHfTRD6zGqc6PHjDSBLzA+YgT7WoYDvr7WSwv4zIoo77T0NJtgHoC2YTSdUphEAF6yqa9U+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728011743; c=relaxed/simple;
	bh=D7uKn2rP3BsHoX+BZmRs69FKKZhDW+kZaYeBLrtffEY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1ovfTj7yYu41TuNba/0tJfu/RhXMyb0IVt/vhWV6GAm7jjGRyAcWg3I1GuE60iNHSJne0pJunlfglEyvx52cNa61wMmRA/tc+9gQH5sAlTwnA48j4+v911ZsH5OSflFKXH8G5INUzdWwbelM2awEM4CnO3EtoKoi8I4Sj2qVFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhY+5Ck5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728011742; x=1759547742;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=D7uKn2rP3BsHoX+BZmRs69FKKZhDW+kZaYeBLrtffEY=;
  b=KhY+5Ck54PjyaHyXKxiz9fteTZnsEKQJL4msakDkD5nhajnQA4R+An8X
   3LqmmGzdG94pvhHAWhE9Trtx2sBwLzzI7bwh/LJxR2V2a7R0oBo+5CyyA
   cQK1V5Qc9qacL/GNTUPqJGeAETMhgU+H4Vjdz9x7GAnDvQgTKG1hu/K+a
   WsVOH7Ej6jdmXjcsfkGlRBd2kks1eAYcdcwQ6LTTvhTEMGTvbEdemYt+l
   xf5xrJKU6KrkQSp9FvxMlK188iPemcp0Brn1Htvngyo58Ze1nq7mMTdia
   PR6RIdYwkEwZ7mmNrQMWA3cnQEqX1DC5kw/rgRY7rVjYxQp3aBgkx/Pnt
   g==;
X-CSE-ConnectionGUID: WiIk9BbaTIqh5gK2CxfoVw==
X-CSE-MsgGUID: 8AHFw4YbRCuWV4fzYPZGdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="38359915"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="38359915"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 20:15:41 -0700
X-CSE-ConnectionGUID: PBo+9qK5Qyqudu+7VWvnBQ==
X-CSE-MsgGUID: LjO0uSHJS8SROVTdVJQM2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="75005331"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 20:15:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 20:15:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 20:15:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 20:15:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 20:15:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 20:15:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUgoQW14cCWH8qsTTRcweU4HMZM3SCk1T1PBJN+lvA1kuSqvbuszupPW5VWaDOA6PfpsRoGLIxHU6Db9hF037DYJFvLzx7W4ZsiJc8Iz1YJDgP6sKd23ZpX5W0v0BQ3CQqw64YqPBAGQQScQoXevwf4JjfOgUzgjDbd8FpXX9vVFGfMer8wjsfJYk1iNN26TFVsUzPW/Pop0IWZ7o7g61GYN1QEiImv2JNSUBt0GpNXtne0nnq5gjOlS+rDz8ht+Sq4KRfsKC4lE+UB38erC3NSwoyvWbfjSCiD76+tq7RRtsUGhQVLFiL/fXQHBXhYArym4dfvUgNmgnZ9e9eJ8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV5zpDAuzWalmzZhIByh4JosOx1D5Ej8Rrr4BGd7Mxc=;
 b=Y5bCZKmw5sqdsdTY6hp4QnIVAEXXDZXj0I78X7kraoNspTbZ1MGoKcktXL/dJMiKmgvKsDhPWBotgJJpPGETDsSlqCfdeg53M9Eh9OfJSOOdoMZk+N7P9WCb5S9JRt1a9t+RkZNom+LYkgbD84g9zl85vT8IRe3aFa4rDaNjvrmimwWa6gCTlriGjBmA76bxW9Wpg4+MoSP2eOqcd00NKElGxgI1+5ql7B4cj12DN9Lukreh5MqO7zxyB44SNvcCts9s1NEyNqwI7fGKOgppLDSvFC8YwJYaZY1yck7mwnk+oNp45rMluY/sI020BwNY3gMDB7x6fqhmvX2BqYyObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7462.namprd11.prod.outlook.com (2603:10b6:806:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 03:15:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 03:15:34 +0000
Date: Thu, 3 Oct 2024 20:15:31 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yang Shi <shy828301@gmail.com>, Dan Williams <dan.j.williams@intel.com>
CC: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand
	<david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, <x86@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>,
	<linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
Message-ID: <66ff5dd3b9128_964fe294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240930055112.344206-1-ying.huang@intel.com>
 <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkp_SyRBR+JsxMwM_qKpF=8+TU=36hDY6TuKMHdnLnyxAg@mail.gmail.com>
 <66ff297119b92_964f2294c6@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHbLzkoR1pT1NEL7qAYi+JXOsB7O0FnHyHFOJ+4eZf9vf5K6Wg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkoR1pT1NEL7qAYi+JXOsB7O0FnHyHFOJ+4eZf9vf5K6Wg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 564f895e-b7bb-459c-2081-08dce422cfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eENkeG5SamNicE1nekdTMlNmZE54VWZha09oSTNpR0FiVTV6R2tEMExkYzVH?=
 =?utf-8?B?WEVvOXd4Q3hCUTRwU3JyVVlqVUtyZEVuWHVwcmdWOUxZMDNQYmFLNWswSzE0?=
 =?utf-8?B?bU5FOXJYL1pCK3NlUzR1TTQ0RVFINHpFNklBUFNZR05qeW1TTC9HOTRvU3h1?=
 =?utf-8?B?UGdEKyt5NjBWYmYzU3lYeTVoRGxZUzhDNjlYZWx1TW1aanRQdXZoeWhndDN3?=
 =?utf-8?B?ZFZNckpCb3lEUldyTnRQTFYzL2R6OElndGF2VXphZnBjbEYxdHJIb1c4NjdB?=
 =?utf-8?B?bExsREF4TE1oN3JBb3YxQlZBc29VRk1rcSt5UTBUb0o4Q1BGeVBwdHZhdlZ6?=
 =?utf-8?B?UDlUbm5TbUFycEZHdHAxNVM4U1RPUkd4ck9MNWIybDdtR2pCek1CS084R2oz?=
 =?utf-8?B?SjB2UGhsNW1PUWxnWUhKVGNSdTQyT0tmV0dKVkZ0amt0VjVsLzZNNXFWMGFi?=
 =?utf-8?B?NXU5eFlHemtlSXhQc05ub1drYjgydjJJNFdnNURGa2pqMU85M3JoUEhmRUxm?=
 =?utf-8?B?N2VFcTNST2VVa1pmTUdxejhDZkI4Si93L0hmSFlpRTQ2dlRMZnBUWlhnQWRQ?=
 =?utf-8?B?eTRiLy94amlzOHVWUzBQNkNDNGl3T2dzbmJJOE1YVXgvVVJpOHJrKzZnSVA1?=
 =?utf-8?B?OW9KS0lwYTRjSTcxaEpxYWM2VUlTcThIREFveURoWjJkVjQ1dHcvcEVkVEQ3?=
 =?utf-8?B?NE1CRnI4NndqTXkyQlV3OGZoaDBJSVpLejVGZFpHY1ZCZW5IQ3RUdU9lbCt0?=
 =?utf-8?B?US9zamY3THd4QWJDRkhvejZRbG5KME5OekVjWVloMVFwemRtWnJGS3RMdnpT?=
 =?utf-8?B?cVVUR05uV3RUQUZlMU1rZStTRzVuM3VvV0FDanB2c242NG9OclVhVURSZkZY?=
 =?utf-8?B?c0pKcTBGMml2bGdhRHhOZ0VjZUZKd3BqRExhUkFxR1JaSHN3eHJ2b0g3Wmdv?=
 =?utf-8?B?S09EazRmT1dBVGViRmw0UE5ERUVpZkx4RFJmNnNiQk9lMDRaak5zZzhHdmYr?=
 =?utf-8?B?UERlN1hHWVozVVlVU0F5MzVETXpkYTJvem4wYVFUVitwMUpNTXd0Ly8yaXRh?=
 =?utf-8?B?Yk4ydDNSVHVLNDB6VC9pTTZUWU1QUDZFNm10UmN6SWEzTTNYYmtBWmxDVVNT?=
 =?utf-8?B?S2dDWGxwK1p5RUpWMVVQa1ZNaWJvdk81ZUo0dEpISzNicHdweStXMXJ2S0tX?=
 =?utf-8?B?bkxPMGZrOXZmM2dOeFI4aTVpakNEU3lETGx4NEhob2szQnc2UFVEb2hlRldv?=
 =?utf-8?B?QkJjOGJKeEZ2bVZ6NkhuUWdEWTNxVDBYN2VpU3N5dldEclI3SmZDek1UUHlh?=
 =?utf-8?B?OTZuZGFpdHdhNDVCN2tEMTJkeW9yYm84NHM2TnhYS1MyaGZuaDdkVmhlUEJU?=
 =?utf-8?B?d21IYzMwRWkyNzB3RzAzWXRQdjJsaUo1R1lkbE03NUR1Wlp1NGdHZ3d1clpi?=
 =?utf-8?B?YnV0NjAxd1lkaUhWREhZc3NoRFdmc3gyNkh1QkdROXZpYmdNR2dXNi9nbzNl?=
 =?utf-8?B?RFZXZU5jaFUzaTl2empJYTluSGJIdmtnNGMzWjh6ZVlxWmUrSHc3YkQ5Q2xa?=
 =?utf-8?B?V2cwWG5CZ0tVUk5XaXhKM0xUUURRaU9oempKdzRoSCtXc0J4UENFTkFCb0Vh?=
 =?utf-8?B?bmR3OEJLT1FZdFJJc1Z6TUJxTy9oN1dGQVNkYWJlbmpwQmk3eEg5dEx2dzNW?=
 =?utf-8?B?VFVtcUtZaGZGVVdodnkxTjlPODhpcFhLMzBlTHRoZXNBUWI0NUpTT1VBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVBYmRGSEpMZ0tZc1dzQWhDVzI0RFlleTd6dHM3cS9iZWMvNFFVZGlvZ0ZV?=
 =?utf-8?B?eDZLcytoWFk5VGdVQjZFNTJITU4yNmRQcnFpMzRJU1pjMWdoQUV1NVI2TFli?=
 =?utf-8?B?cUZrQmRmc1E1MDliclBYbW5hK0sxaTE2OEgrNDkxOWNxVXhoVFMwVzNSV21E?=
 =?utf-8?B?R0d2bWNldmhRVEJ6TmRseVZmdG1TZE1wK2psNzNDSEVUV0pBZ1BGRktSU25n?=
 =?utf-8?B?dUVnWWlXRW5KaHpoNEhCQk5haGhXQmRPc1kyaW9pQjlkMytvMEU5MnRHN1JI?=
 =?utf-8?B?blkzNWNnNlNTMnRRT2V5a0g0ZC9FY3A2S3RQSU52c2QzNTdXeFJGRk1UbGFI?=
 =?utf-8?B?ZkZpWGpiNy9kcG05SU1GUzd5dTV1eU5iTE93bnIwbW05L3h1a3RyTGExRERW?=
 =?utf-8?B?ZE8vMmh3S1lDUk1mOXRYcmpzY09Jd2tRNlNhV0EvQXVTLzFoMDhaUTk3SE9O?=
 =?utf-8?B?Z1FuZ2dMS1IrWDhoVkxrSXl3SUZuVUN4bzN3VjlPN0N1c3Q4YzVDRlNWOHVh?=
 =?utf-8?B?NFhwUU5tZzU5ZVpiaDJBb2Q2ckRSWFN3VHJraWJUYmtRUE1LZkZYNU04bmRV?=
 =?utf-8?B?UHVmMEJydEFkZHYyWlNiRnNvbzNjZmx2aXMwNUIvR0FDRmRsNncyZVpOWm1u?=
 =?utf-8?B?OWpFdmRFam51Q1NnV2J2aTFheE40cHVPOW12c2pkaGhFSXFVMUFGdE93STN6?=
 =?utf-8?B?RzdaUVlLS0VvUWhUT2Z3Mmp0bHp4WVVoMmdvcVdFdHBNZktiaVhFQ2JTelcz?=
 =?utf-8?B?UE1QZTcraUJWY1RscjJVZDNLNVRZcFhLdnBlYmQyazNRL3hQakVPaHRGMk9t?=
 =?utf-8?B?a3dueVVRbDFWNkl3RG5IY2hMR2wySG5QNWZISDVwcHUvcjZiT01xR0xiVnpo?=
 =?utf-8?B?QkcwSlQ2a1NUa1RwYm5FRHB0LzZFT0lKQmIrR3FTU1RuTVo4VWQ3dlU0UFRn?=
 =?utf-8?B?RUN3ZDhUNW11QkRFTFlnZTNYKzVSNVZOTENjV2NZWFhWWnhmNEVGb1hHTEV5?=
 =?utf-8?B?aFBmWFVhZEQ2bXorOTU5RzdoSjhLeFoydXJZa1FwUjI3NHY1dkpLa2czUUI4?=
 =?utf-8?B?ZzdZQzQrMjE1TUd1R3VHbDdSSU85cGRCNW1FbVBWRXlWZW42U3VkOU9Ndkth?=
 =?utf-8?B?M09MeTMxZkNlaVVjOGZPaEZja05LSnFZeHFKVkNVL011RkY1NHRBenR1TXRq?=
 =?utf-8?B?a2hFQ1h0OFJpSzMzdFJNeW1xZis3TmRlV1FwTTNISVI1Y0hPZ2FPZ2lEZUdn?=
 =?utf-8?B?bXA4YkZBL0xIajlMSGxsV0E4UXA5MnlqMDhxRHhRSnJKQmNTU2l4ZVpSSk1n?=
 =?utf-8?B?WDBnQy9OdXQvZllORGlDQkV4Z0tPZXFjS1FSWHdqcEJqQjRHOGdiQkMvbFlt?=
 =?utf-8?B?SzYvRlRjNE5OMWQzMHltTFRmR2VNZTdLZWZOUDRaNFZZRk8wSU4yVUVSOC93?=
 =?utf-8?B?ajJMZklmaWZBUzVUUVFSVld3Y0ZtenBEcWllVDZ1VXJ1aXlsVVBYTDhSS3FM?=
 =?utf-8?B?eTZRTloxMTlKT2x3ZDB3cGdOazBucWVWRHV3cTJuOEVTY2xtTjl3VTBXUHpi?=
 =?utf-8?B?WDZrWW9nSlZvM2FsYmUyQjhaZDJ4MG1oUUxxRVFFaEVFR0MyY2tBaWxSVktk?=
 =?utf-8?B?ZTA3d3lqT3pMUHc1bDRjdDdyMmFqdjJ2bGhxblE0Q0FacFpSalNPb2JJUVR0?=
 =?utf-8?B?RlViNStvSEdJY25sMHBQR3U5bmNIaDByVHlYbGhDODExR3VKTE1qUS8yTjg0?=
 =?utf-8?B?T2dmbktrQzMxQmJ2bFF3RUZNckRpSjlQbFB5RFJhWnJwYkthSnpaSHBpL2Ja?=
 =?utf-8?B?Q0ZaclpmSE5VNGVjTEo0UEtBWUlUR1NrUjhqVjRpdkQ2bUpzZXdDODc4RktV?=
 =?utf-8?B?dHFBcVBHdWtQSFlxZlJqejFpN1pyMmc0QWFNZy96Zm9FdWE5MW9SODZyOVBC?=
 =?utf-8?B?M1RUdDVWRlYyZnBzRkI4Ylp3dUdZRzR1WUNLUEkwOFlrbklkcThKcnpZdlJF?=
 =?utf-8?B?OHp0Y3RYWlFxUXR5UkFBVGx3UlorbmVkdnE0M2VBY2t2MlV6Y1pmRXRMYllD?=
 =?utf-8?B?MDZOb3gzRVR4emcybzRZaHY4bEZycWRBYjdZa0ZML3J6UWx6Q3NnbnMwVEFU?=
 =?utf-8?B?TGNSMXAzWCtVaWlMTC9QNS9xcnpVR1hNT3RiWkhZMm1tS0JpMy9MQmtvVEJN?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 564f895e-b7bb-459c-2081-08dce422cfbb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 03:15:34.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7b6A2UW4nBmBU+cZv+aP9gyjyPhBA6LBzoO6UyfD4zrN97xT3TMKFW8FCnTnsqypkCJt7AmSCIISUF6qQXIeaoRAMw7c+jVaBwEGHSZSAVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7462
X-OriginatorOrg: intel.com

Yang Shi wrote:
> On Thu, Oct 3, 2024 at 4:32 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Yang Shi wrote:
> > > On Mon, Sep 30, 2024 at 4:54 PM Huang, Ying <ying.huang@intel.com> wrote:
> > > >
> > > > Hi, David,
> > > >
> > > > Thanks a lot for comments!
> > > >
> > > > David Hildenbrand <david@redhat.com> writes:
> > > >
> > > > > On 30.09.24 07:51, Huang Ying wrote:
> > > > >> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
> > > > >> hot-added must be checked for compatibility by TDX.  This is currently
> > > > >> implemented through memory hotplug notifiers for each memory_block.
> > > > >> If a memory range which isn't TDX compatible is hot-added, for
> > > > >> example, some CXL memory, the command line as follows,
> > > > >>    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> > > > >> will report something like,
> > > > >>    bash: echo: write error: Operation not permitted
> > > > >> If pr_debug() is enabled, the error message like below will be shown
> > > > >> in the kernel log,
> > > > >>    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> > > > >> Both are too general to root cause the problem.  This will confuse
> > > > >> users.  One solution is to print some error messages in the TDX memory
> > > > >> hotplug notifier.  However, memory hotplug notifiers are called for
> > > > >> each memory block, so this may lead to a large volume of messages in
> > > > >> the kernel log if a large number of memory blocks are onlined with a
> > > > >> script or automatically.  For example, the typical size of memory
> > > > >> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> > > > >> will be logged.
> > > > >
> > > > > ratelimiting would likely help here a lot, but I agree that it is
> > > > > suboptimal.
> > > > >
> > > > >> Therefore, in this patch, the whole hot-adding memory range is
> > > > >> checked
> > > > >> for TDX compatibility through a newly added architecture specific
> > > > >> function (arch_check_hotplug_memory_range()).  If rejected, the memory
> > > > >> hot-adding will be aborted with a proper kernel log message.  Which
> > > > >> looks like something as below,
> > > > >>    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX
> > > > >> for TDX compatibility.
> > > > >> > The target use case is to support CXL memory on TDX enabled systems.
> > > > >> If the CXL memory isn't compatible with TDX, the whole CXL memory
> > > > >> range hot-adding will be rejected.  While the CXL memory can still be
> > > > >> used via devdax interface.
> > > > >
> > > > > I'm curious, why can that memory be used through devdax but not
> > > > > through the buddy? I'm probably missing something important :)
> > > >
> > > > Because only TDX compatible memory can be used for TDX guest.  The buddy
> > > > is used to allocate memory for TDX guest.  While devdax will not be used
> > > > for that.
> > >
> > > Sorry for chiming in late. I think CXL also faces the similar problem
> > > on the platform with MTE (memory tagging extension on ARM64). AFAIK,
> > > we can't have MTE on CXL, so CXL has to stay as dax device if MTE is
> > > enabled.
> > >
> > > We should need a similar mechanism to prevent users from hot-adding
> > > CXL memory if MTE is on. But not like TDX I don't think we have a
> > > simple way to tell whether the pfn belongs to CXL or not. Please
> > > correct me if I'm wrong. I'm wondering whether we can find a more
> > > common way to tell memory hotplug to not hot-add some region. For
> > > example, a special flag in struct resource. off the top of my head.
> > >
> > > No solid idea yet, I'm definitely seeking some advice.
> >
> > Could the ARM version of arch_check_hotplug_memory_range() check if MTE
> > is enabled in the CPU and then ask the CXL subsystem if the address range is
> > backed by a topology that supports MTE?
> 
> Kernel can tell whether MTE is really enabled. For the CXL part, IIUC
> that relies on the CXL subsystem is able to tell whether that range
> can support MTE or not, right? Or CXL subsystem tells us whether the
> range is CXL memory range or not, then we can just refuse MTE for all
> CXL regions for now. Does CXL support this now?

So the CXL specification has section:

    8.2.4.31 CXL Extended Metadata Capability Register

...that indicates if the device supports "Extended Metadata" (EMD).
However, the CXL specification does not talk about how a given hosts
uses the extended metadata capabilities of a device. That detail would
need to come from an ARM platform specification.

Currently CXL subsystem does nothing with this since there has been no
need to date, but I would expect someone from the ARM side to plumb this
detection into the CXL subsystem.

> > However, why would it be ok to access CXL memory without MTE via devdax,
> > but not as online page allocator memory?
> 
> CXL memory can be onlined as system ram as long as MTE is not enabled.
> It just can be used as devdax device if MTE is enabled.

Do you mean the kernel only manages MTE for kernel pages, but with user
mapped memory the application will need to implicitly know that
memory-tagging is not available?

I worry about applications that might not know that their heap is coming
from a userspace memory allocator backed by device-dax rather than the
kernel.

> > If the goal is to simply deny any and all non-MTE supported CXL region
> > from attaching then that could probably be handled as a modification to
> > the "cxl_acpi" driver to deny region creation unless it supports
> > everything the CPU expects from "memory".
> 
> I'm not quite familiar with the details in CXL driver. What did you
> mean "deny region creation"? As long as the CXL memory still can be
> used as devdax device, it should be fine.

Meaning that the CXL subsytem knows how to, for a given address range, figure
out the members and geometry of the CXL devices that contribute to that
range (CXL region). It would be straightforward to add EMD to that
enumeration and flag the CXL region as not online-capable if the CPU has
MTE enabled but no EMD capability.

