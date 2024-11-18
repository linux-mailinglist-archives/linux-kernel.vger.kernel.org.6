Return-Path: <linux-kernel+bounces-413555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9386B9D1AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5AB1F217F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EDF1E7655;
	Mon, 18 Nov 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0jHPEPr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C118A92D;
	Mon, 18 Nov 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967690; cv=fail; b=fiALGMm0j9qeGPaDFP975j3iMa6xxBrE8WW3lmPbGZflPVI/zc67WcaQcy5saRnf7y45mWAsRM1VZ5X0JyX/YekdzcaBVHWU5mC9Cxm44PL2LeMcLuV9ZIQsVlmpjnqD+cQ6ZTT53W5ZmfuzCtJN77Dnw9tuUDfiY4sS418OjR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967690; c=relaxed/simple;
	bh=p/qpAQiP43nUJTmoXoVdpBAZ5770GxjmVs93SijNXWQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9FROR3jzMRmzgTRHm47T5YCw4iLqYzAh7Zcq6Ukr4JJOVfLyCRJdCl/0L8jXfrrIEjInLxOz+83pIINGzRQeclU7h2tmRyUGW93uDqLAmHX1Xmb9x1/z5xTDptFGg7hqxMsNC0FCM7ELX//IKQe3PoHWC+p7KJbdITOfgaeAbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0jHPEPr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731967689; x=1763503689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p/qpAQiP43nUJTmoXoVdpBAZ5770GxjmVs93SijNXWQ=;
  b=I0jHPEPr3n8kNyVODO7/kgqk8iRjyAi4ktghI/rxAgKeBF5XrMfibNYi
   JuJ51sVWLS+4BlIEmTij/Wp4JxCb1iHNoDXSvpsY/AJw+E5Io2xtCfo7a
   5nchy4IGzX7aOVSjyYs+h1TvZYmOlhbHepYaT422wmx54BA0Z9jfA8uTm
   IleDpcF/zueT99NI/zgHLe6mCneEkB3z9rzLDZyHy8C2U7jKPQaUzX2xS
   c83w5+M5wISHJA5+bDvWFoX5bAUtkWZXZ6yVJzisuVjoLglbCn6eenMTB
   8A8m/W9kUhSHuDif5mAfaMDeTLyAZG5wzrpcQOLoMkECPb8tZZoWj2PMh
   w==;
X-CSE-ConnectionGUID: uBAfoKtySMKORJtJLN6nVA==
X-CSE-MsgGUID: fuzrs+tESlqZe0T0hwblrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="19557455"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="19557455"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 14:08:08 -0800
X-CSE-ConnectionGUID: ke2ECMvqTAyevb5TUPOAqA==
X-CSE-MsgGUID: 7mgCqllWR6uWbwshTso21g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89783278"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 14:08:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 14:08:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 14:08:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 14:08:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBtM1q+UC5lHA3wuHC9Oui0O9seSB9TJdWfxN6SrQ2IpYk4Tk2tSR1TObIsZkRCFrPOyiMbzsAkNTMb4PBExrjwUK2bde7HUXBXX2T6Oz36zWPW3jZtL3BRyXPbI2FbD8GWdmZ6xZ5yet4WEpjptfgfjlR03E+rLGAA77xxHaswv1IR5P6kvzYzmLspte9/WUYO9yeJq7T3tRaY06/EDobTGBzbIBsDldb6IELKJZUBSvPRFiKAKtXzexKDyMsM94H92PY+PEcUt8SB4rmmb8Haoc9j6JrL1Ec/McpX25+LER15U5xt1T5uYBElKSFRezc/qQeJOVHadoQnDP5/4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvS18VBFv6u5rcURerz2BcwuMzuzuPCnOmhP/ubGgjk=;
 b=lDa+d1rlk87jM7DxSXKzS7qAxRnr7SDpXOTNwN3/48u0dUWOla0LNMSfKrPXRwKExzv1sE/0LRb3hQt6mR8YlfGxwrUX4o+fG/cLwtunYU1eZrXOW8CJDIXyfod6UOlODeBJMeeDi3Ck1FhBTfF+koxNhzLYkmr3voD2i8XdiDutkvAIRnwsIfO3JuLT3E6Qxodh2WmRRc7foMQie6EujIsL7ZTgZdLInEaMYxzfFjm44xyGMPeeSXbnrD3Y873TP6VYGcnt/gjAAnMgvs+kwK9OBXt/Ggy4k5Fdlkts272zkiCUUPj4lo9Ti4SLbI7sPs0eAi0FxfyqzX3ZJgs0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7341.namprd11.prod.outlook.com (2603:10b6:208:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 22:07:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 22:07:57 +0000
Message-ID: <b29b8732-8b6f-47d3-9432-88884e744f56@intel.com>
Date: Mon, 18 Nov 2024 14:07:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/26] x86/resctrl: Add __init attribute for the
 functions called in resctrl_late_init
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
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <2372314c135882d233eb8dba69af7c245efdcc8d.1730244116.git.babu.moger@amd.com>
 <55bd64e3-50ff-423c-ac75-e25f2e1c9ffe@intel.com>
 <02e304e5-597d-48f6-b61e-24f366f60fda@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <02e304e5-597d-48f6-b61e-24f366f60fda@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f40bc06-462b-4ad2-4dac-08dd081d753b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0dmRUxydUJwa2lob2UrZERocm9jL2ZKMDJtR3JzNGZlcCtXMlFQU0FlNGtL?=
 =?utf-8?B?YlF2SHRkUUtYNDcyMnhGU2lLdDI2SVNKSEQyMHVxeVlqM3ZZTmZiUmxjeWpt?=
 =?utf-8?B?bmlZTytlQThmY3BZZkNRWUV6SkxCTVhLSFpIbnRtbXVzQVNOdWZvQnNnRDVG?=
 =?utf-8?B?bVR3N0hQeXZOcjdPTGpUZVFrb09YazF3aXoxZnVyTnpCUmJ2OEdZclFBN1cw?=
 =?utf-8?B?Sit1Y3dNMTYrbWtYTGJTM3pyVklDT0FtcTVXRG5oV2F5NmRxMzVtQytoTmhS?=
 =?utf-8?B?ME9GSlZ5dEdSZUJMZkNmSkRtdTVIMTRvVWdRQU50a0ZSNkU3KzFIUEVPaUEz?=
 =?utf-8?B?S1Q4WlZIM2oyaGZwd2phRnRRVFMvZGErb0QxZ29iZFFXS01NNXR5SDRLaVEw?=
 =?utf-8?B?U0J2aFJSTTdIWmVNdkNCY2ZiT1V0bklreDdtRWs4dVpPcUE0YzhJMlVkYWU1?=
 =?utf-8?B?R1doQURsZ09wcEFRY082c3RnVDRCWjYrNDdKQURkKzBUSjZrdy9WblppYlVW?=
 =?utf-8?B?TlkwbGdROUhRWUJWelpnWHQ5THprYmhpSnlVajNwc1EvQ2tGcThSK2dscXp6?=
 =?utf-8?B?R1BUbmUrSGEzNUdDS2JZbjdmZDQrQnFZRU9HVnRJZW5IQ1VJNUZPREgrcjgr?=
 =?utf-8?B?bHBlWTJ1MU44d2VySlFHeDlwQ215K09CK3pjdGk4V2hIRG95SVNBellxUEM5?=
 =?utf-8?B?K2NWa3Y3aSttWDhnNWhqRlFLUHRNRWlOR1VKWjFDdXUrSGp0VzBRSll1M3hi?=
 =?utf-8?B?MDNDVHdUU1RvVDVvbGtPdjIwdXBiaUZ0c0NWOGJiNVpmUXFDVzU3UHlYc211?=
 =?utf-8?B?bGRnRGpZM3hrbVJuYjJaa3gxRlBBS3YvQU1EZ1paZTJ2T2w2UnN5QXRYdUJF?=
 =?utf-8?B?MEsvZW9uZW1uOGNnMytoaEUxTXpuZDA4VjdubzIvWW12NHJzS05hZEthbExK?=
 =?utf-8?B?TjhqRjZ3cHo4dG9OZ21xL3J4OWUzYXJlMG5YNFBVVzZmQUtFemJZZjVMYlR3?=
 =?utf-8?B?TTNvdkQvNGVZdTQ3a244RHNZSlNhc0xtVmJDQWU4enE2MnpJTDVTdXFzZUtz?=
 =?utf-8?B?L3NMdDVqaGhFSy9ER2VtdGJEbVY3RzJwRjZ5Z2owbFg5OEhzT0pQdnBEUzdL?=
 =?utf-8?B?dGd2N2J6QWFhMGNweE9ZRVppQXViZStYQjIvTWRnYTFHRG9oU3U4cmh6VWNy?=
 =?utf-8?B?V0Q2anU5Rm85Ulg5UFhOOUJCc0szRUZyc1p6NjBaYU01cHNoSjNhS0ZNVTNl?=
 =?utf-8?B?YkhUem05Qno0WmtXc1A0d0VrMVdCUC84N1JBME9qZlBFdVc3V2tUZXUyV1R4?=
 =?utf-8?B?cGFXcEZwQXFBZ3hoT0VCZTBpckhnbFFqRlhobDk4OGpNSHJlZmtoR2hvS2Vp?=
 =?utf-8?B?OFRIQnEyeDUxOG9BTHBVUHIxR1lRRXhCK0VicmlFbUpkVWFNUDdlNnRTUStW?=
 =?utf-8?B?c0JEdFR0NjAvNnR4TlJMY0laamkzRE43YmV6Q0xlRVhjY0g2QVdhSjRCKytZ?=
 =?utf-8?B?SzFuaS9nTS9xcEJYemRLRnI5RHh3OUJyVmxDdzhPVzY2ZHVMUzN6clA5YjJP?=
 =?utf-8?B?OWQ5cWZhZ3JqQzh4Y3RDb0NseGFhWTAyOWZhUU5vcGVpMkVHSWtqSUIxbE8w?=
 =?utf-8?B?WkdqOG5YcjU2UkVBelkrMVI3a25oOWwxeFhBVllEMkI4QkVyUDNsSG1YVllM?=
 =?utf-8?B?aHJnMTBsWmRiWkY3V3pUYkpDUDNMRzBOckVRZVRmbFZ6VXVuMGUyMGxRRmJS?=
 =?utf-8?Q?f3XdCyi9+lCX1fDbXLUteuBMFhI0hpUzmqx/N1h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdZeE9tdGxsbElVRC8zQ242MW9zZXVVRWNKLzVxQlFCNzAvdHhvNjlLamgr?=
 =?utf-8?B?amxxQXdlY0daMWREenU3T2Y0Z2FOQmZHdis4NGVNYjBRMUVhT3N3aXZkT2No?=
 =?utf-8?B?V1RTbDNST3d4RXZpOTZqVDh0TFJqMnN4TjQ4dXlRaFMzQnhqcTdyZVVNMzJ3?=
 =?utf-8?B?WHl6Z1h3MEd5MjVSYlhmaVY5NDNRVlJPNVFzdkNhWS91WnJtU21lQ0FNbmdU?=
 =?utf-8?B?N21vdHgyVGEyTnNobkZXRWJORkdjcTJqYjB6SERPeXUzYWlsK3JmVnNFY3lm?=
 =?utf-8?B?VUxjM3lLUzVndUJMbU43Y05IZ1NPd2ZlVEpIUDRSemJiamFza0FEVUFEOTBW?=
 =?utf-8?B?QkhIb1A5THd6Q2J4aXJGMVd4UU1ubzlGN3NkbS9WVGJ6aUlLWDZMN2h1MDRD?=
 =?utf-8?B?NzdGck5EMU5GdFJBOC9CRHRzT0JDSm1ydU4rSnZhOW5lZmdBK0N5Q2RQTXNa?=
 =?utf-8?B?SHZ1MzkyWllMQ0Y5UEFlVFdVdVVxMjFBRU1KLzZLYThWZUtQT2RBVzlYQXhS?=
 =?utf-8?B?YjlUS2JQeGxXK3FscHRKSTF2L3hMeWhINWE3clFpM3NEZTJrYUFxMW80Q3k3?=
 =?utf-8?B?THBVK0JKMWNHUXpnTlFPV3kzNUZhZ0pGTFFwU1hJY1grNHNGejFndEpZbjFm?=
 =?utf-8?B?bE5vUndIMGhXb1dvYmNSS0FvNUtsMDI0aS96MmwzSUM2ZzhXRktjS1duVjBX?=
 =?utf-8?B?ZmQxRm1LVnpFay84dGNsMzM4b1hjelBudVdwV3c4Q3NZMG1NOGJ6QmprVWtF?=
 =?utf-8?B?aU42K3djdXB5TEoxcG05UDJvQisyb296NmdvYkFlOWhxSWZvWStxbG1FTkdt?=
 =?utf-8?B?Uzg1VTkwZlJWTTdFT21naGR0M3hCZ3FSeWlnVlJNcWlZUHlyc2laWmhQNmtj?=
 =?utf-8?B?UWZHU3E5d0x6UWZMWlQ1bFBSN1ROaUUrT2dBMjNMTktXSUJBTlUzOE12RXlk?=
 =?utf-8?B?UWh2VjBVVjRZRVJuRW93V2xnWE1QVVZVRGladnpBMlMxbkxtZTczRGI3K01k?=
 =?utf-8?B?WHk3NFM2bGRJZHV5Q29VcklpU2pMOEx3UWV0d2V3dWpSOUYxSFFWS0g0T2pK?=
 =?utf-8?B?WTQvTXI1dTFNc0N3WitybHUzK25Jd2JaZForTHN0eWlQTXNMeDV3ZUh5MjBQ?=
 =?utf-8?B?YnFQRUlBZmhpRGQ5TytndWtmMnY1d1dnYmovUGxxMmd5dW1pak5UQzJKQWVQ?=
 =?utf-8?B?T0hNSzd0enhLL3pnWk1QaEZwZkpLblJuZWd3d3ZYaEdDanZVazgydWpBMFMv?=
 =?utf-8?B?L1ZlNW90Vm91eDJzSFlNZC9MSDJMa1hKMDh0VWNiS2VMVG1MU0pEWlhRMTVp?=
 =?utf-8?B?MmowWFJzWTl2bjRGN3AwcjQ3bUtMRllVT2N6bys5aDViK1hIWU1RSEFVb0k4?=
 =?utf-8?B?RG1jQ2NqYk1ZVElSbXpnU2prSTNIYlhlcVJCdzNiVDBEUHI1ckpuTDMybzNO?=
 =?utf-8?B?NGdMK2hkcHFCZWNvSWRrSlBGbzN1OGRpUUIyZnAyVXhwZ1RCUGFUM1RjdU15?=
 =?utf-8?B?SUVuWm1rVEVJbEViVERRclhva2JXa0VmdzJyWGJuWk5zZXdlU1l0eGpuWTkr?=
 =?utf-8?B?R09Wbm82T0xuZUFmUHprYWlDY0JxVXZ5MkxyUS9aaTgzaWNTOWxhaFl5UEoy?=
 =?utf-8?B?K1dTUlNraXlORjRIVnN6cm1HdHZVU3NZUEpJT3NTaEpHOEl3eDJZRUErYUhO?=
 =?utf-8?B?Qzg0dGpvdUhTNW0reWhqRHRCOEtlWXRFZlYyaDkxaGlpTHRBZ1JZcWxpU25O?=
 =?utf-8?B?bHpBZnlIL002WTh2NkdLNzdmUm83YUdtMUQ5WWdhZ0dLc0c3MXo1b0VKQzVY?=
 =?utf-8?B?bGV6Rnc2ZXdMcTR4TmoxOUhqYVVjMEpCRWxCQkdxdFl1WUJvL2pIdVkxalRh?=
 =?utf-8?B?SjZsRjZyZUpEblpsTVZaeXZKRThpMzlUTVRVeThnOEZoTFJxeENhUG1mZ2R6?=
 =?utf-8?B?THJVQW1adjNodCtLSWN4V21hUXVpWDdmT1dUU2VaWitNSnorT0IvRGFOVDha?=
 =?utf-8?B?TzFWeHBiYjlEaFlnN0xjRXRSRWY4N1dqQ0M2eWk0R3p1NWlzejR6VzRUYkx3?=
 =?utf-8?B?TUxhSXNIc2ZZb0I3eW9qK3VqeTc3REFmQVQycmgrbmV0TGtNSE5UdUwwNjhs?=
 =?utf-8?B?RXovMUZUaGNGaExqeTluRlVwWExoYUI1VEhpNGtiZUprL1FZeDJ1aTdSZnB1?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f40bc06-462b-4ad2-4dac-08dd081d753b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 22:07:57.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6HrSgyYeEzPLr81JggXJ4/XrJTPYxEVWmQ8fVTS/weU05Rl84PLtol+KiPIxOQdTyyVL5S2jSVnOl4lS3F2aJZhUb4rBnVm/mjCj2WsWH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7341
X-OriginatorOrg: intel.com

Hi Babu,

On 11/18/24 9:44 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/15/24 17:21, Reinette Chatre wrote:
>> Hi Babu,
>>
>> In subject please use () to indicate a function, writing resctrl_late_init()
> 
> Will change it to
> 
> x86/resctrl: Add __init attribute for all the call sequences in
> resctrl_late_init()

I am not sure how to interpret "call sequences". The original is ok now that
cache_alloc_hsw_probe() is also included. Specifically, this can be:

	x86/resctrl: Add __init attribute to functions called from resctrl_late_init()

> 
>>
>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>> The function resctrl_late_init() has the __init attribute, but some
>>
>> No need to say "The function" when using ().
>>
>>> functions it calls do not. Add the __init attribute to all the functions
>>
>> None of the functions changed are actually called by resctrl_late_init(). If this
>> is indeed the goal then I think cache_alloc_hsw_probe() was missed.
> 
> Will change the function to.
> 
> static inline __init void cache_alloc_hsw_probe(void)
> 
> How about this description?
> 
> "resctrl_late_init() has the __init attribute, but some of the call
> sequences of it do not have the __init attribute.

"some of the call sequences of it" sounds strange. It can be simplified with
"some of the functions called from it"?

> 
> Add the __init attribute to all the functions in the call sequences to
> maintain consistency throughout."

Sounds good, thank you.

Reinette

