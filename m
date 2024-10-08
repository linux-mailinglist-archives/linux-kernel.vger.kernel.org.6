Return-Path: <linux-kernel+bounces-355603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800BF99549F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47EEB28F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ECD1E0DE4;
	Tue,  8 Oct 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljhtDRTP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F31EA73
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405636; cv=fail; b=AOkRCabJ+3wDzhEtebdjbZE4Z3q6pdEkka0gVkvptbz52kFuyHbTJjpSo6WJgWF2+Jc5KC44zxdjNeJI4CMGdCOuMeEkrJiN//wYTcyPV3J+wisoP18oipMnS0hzID3ZH52Pe3a4Sjl/+ckEjhP22GXmV7EMsjjeSYVDI4Jtaac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405636; c=relaxed/simple;
	bh=4+Qy17PmVFO8s1euSvUIZHZ8Pp//5yVWWLuf4Flybl0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jgJBdUqg1xNHMosZjUuuvnOw1fJ4yXOzv+Tu4Q/I53HWCnOsI5jv8nu9qqOfV/dC1x9L6wPSZDMPwnKf2KF9KsgmZpIhHETyZsNMW0K6WIflS11zexSpaZo3GueIbuVNZUerRqGvHs3eGEVu9jTTPQr6yqLo2kQoRrcjwj8wPWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljhtDRTP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728405635; x=1759941635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4+Qy17PmVFO8s1euSvUIZHZ8Pp//5yVWWLuf4Flybl0=;
  b=ljhtDRTP0YDGnMuLBD8P+ch04vGzKD79z6nsLcy4Dz6OLsJHeJXgmqSG
   nxAXZPV5vVqutNNlSzEXw4ZqSpcLPeierpy3TB51P6+nA2n0hgfwQbTug
   0QpI6IOYQvG56G1fLdOmaCmxk2icLKUrGQGCg9rmRApkHClvl7lAO6JGg
   E4r16csmV6z2gLbEEESp4JSEhP+gXKP7NV6Qw9m/RR9XODp2zRFtIFOrN
   jIwl3H2d9HowaGMbUh5Wgq6qE1U/eUqy8wSldXWliL5q+zlaMf18QdkJ6
   gQedxjL63Iv4WLMrWi86hoGMgTthxAn0iHET1Qgd3QtRA4zTdwgeV8toP
   g==;
X-CSE-ConnectionGUID: 1wMWRGK9QO6kYNy8/Cc40A==
X-CSE-MsgGUID: /VNTRyDXSJC6W93vNAjxdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38274634"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38274634"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:40:34 -0700
X-CSE-ConnectionGUID: BzJWDoRxR8G0cPRbdWShsQ==
X-CSE-MsgGUID: /87u89phQ0qFUVLfU9Vopg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75458937"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 09:40:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 09:40:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 09:40:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 09:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stRaLmcOjEKFYUkqWkzb3Jcznt0r9lTjD0m1/evKNI+iCq3Tn58tVb9UWh8QFJz8NG2/GoAmxJb2D/SklISJDGjiSybHeqER6cJpHnXSeU5RNaOwVQq2P0IUkJ/tzBnP/7qtKUuMLcHRRTalbDxLz+dRUF7gj3UBd+iOsyWwbzwWsQZ+yhLJgHflUPrW+UoPc1ahSaP6VpD2uUXSOYePEmyjVH2mqSLA3nYLZPdJB0oRLyoxroLgXCEF1hnnuFKGy+Ip4pYNPH4xqjvqko3eKzLLH4YRjTFt/xJvDoDYf34KW7whGw/rIcSNvlIKCjZFLO9MES1nYB8DaS+7jr5iuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf573PKxjtBY2jS+Kvx9KlGFlnd6U6g2NnF76p/AtP4=;
 b=RhiNWL6M/gCRQrrLP/qGLjGycWHM6S4Y6kAVOT/Ranb2ZtpfeujE9Y3M78N+yH837+JLmMy5LX5ClULHTZolLwAquSnWIKGZY4NdbQNWwDrNaGrvmUuz/O00kHUhbksodhPIfjanJTEanObLDU9Eh4Ay407b0Sj7Uo8dkTIwfi/rvwggMxHsQNBYE0hISuVS3K7eB/lC0tuRs7siIXGco0wHlMWhT30X+PWkMDIXvwuGH/FUrWGKRbgv80mFzXdRVJ/MiDU/P0aAHBTnzeusq3kBvW5W2E+Ks03iQBdtJqbQR3aH94HxngHkUAu0F0MA3VVlztVzkKSjxYpfLLKWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 16:40:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 16:40:30 +0000
Message-ID: <439810ad-92eb-4fa9-be35-82f54624c0c5@intel.com>
Date: Tue, 8 Oct 2024 09:40:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/40] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
To: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
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
 <20241004180347.19985-18-james.morse@arm.com>
 <ZwR2D4ISzIrZRTHi@agluck-desk3.sc.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ZwR2D4ISzIrZRTHi@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:303:b9::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f4dd25-3881-4e69-6dbf-08dce7b7ebba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YklUTlhmZGc5YkdJNTZqdTBlQWwxbDNPdTUrQjhvQkVNdDl6amp5OW5FdTNu?=
 =?utf-8?B?b25JMkg5SFdWem95aFhVSkV2c1FBRk1scXR6bzVwc085STAzVDZuQ0toMEFX?=
 =?utf-8?B?S0NtMDNzR0YzZkE5WVhqcVVPZ2dxSGQ4R3EveXIxZkQvTjYvN2E5ZjQyclhz?=
 =?utf-8?B?dTV2RGViYVhyUmxzWHRkQm03RUluUUFpemRWeXltOHVDQkp0WnVXbkpCS0J2?=
 =?utf-8?B?NndPcG5DeHJBdFE0WjZkK0pVV0dMTlR3dVllRVlsdGlEMUt6SEs1aVR2LzBy?=
 =?utf-8?B?Y01wcXVwODh5RS9xYUhvRU1WYWhCVDZSZ2NpVUdvd09zNjVsK29pc1lROHU4?=
 =?utf-8?B?aU5TUGhBZEIyUXhucmc0S25XWGJ2bjBnbjNWNDdzYkkwT0drcndCaFYrRzRL?=
 =?utf-8?B?U1lqNzN3dUlQYnlJanBKdlZWMEp4YW9OaFlKSENYTXBGUWFzVjJYd0N5bHU4?=
 =?utf-8?B?S3IzOFRNUHBNYTRPLzdoNUtCTlZUTmpPRVUxNCtFR1g5MXk5dVNKdWxYT1lp?=
 =?utf-8?B?SEtJUnJqUWdaOHZPc1ZpSWhhQmlqeEdlNXhiMmorOEFET3dtcDlMM1ZmdlYv?=
 =?utf-8?B?OTB5eVM5YmNvejZXbkRTTWFoRVNNSGpFNnlxTzIzT1BhdUtUSXppcmVjUTVH?=
 =?utf-8?B?K3AyR2Z1SU9lY2Judm5xOWFUTmt6TElUWm54aDBFZytuUmdNeDRTckV4Uy9o?=
 =?utf-8?B?ckxvWmRENndOQ0hnNitSVFQvUVB0ZDNhRmg0MzcyK3lSaWNRNEtyYndkYzhD?=
 =?utf-8?B?SG9VSHZZYWVOYktDVlNVZ2FUU2k0Qk5yRURKaFllMzNTdlRZUU9JdzVOUjB0?=
 =?utf-8?B?Qml4UXhGWGFLMEJWZlFHMEo2YjByUHNyVytibnNZam9Dc1dDSUYvRmVsTm9F?=
 =?utf-8?B?RHhQaTRac3VjN2xPaXUxdE5obE9PVkRCMWpuRm5KcTQ5WVdKK0pMMzJJb0Y0?=
 =?utf-8?B?Mzc2S3VMM2t0QXdQR0N2K3hBWlQ0ZDVudnhLaHBTTnpsTWtwNytLUnBvNkFU?=
 =?utf-8?B?cy9uZmZzNGtmKzBHNjRzZnU0emNKQkFGdHpKMHhNY09BR2JxUEp1alhLREJq?=
 =?utf-8?B?dWlYdTNES2d4ZDRGN0hidlVwTXhLYXNaeEN6NzhDVkRJUGJEempCNFd3NW9s?=
 =?utf-8?B?YWVIYXZFalprVnBhbnM5TDZBYVp5S3Vra2dIVkFNbGd3TG55Qm05SGxheFNN?=
 =?utf-8?B?VDRiM1RSaS94MjkzaDdleUttQUpBQzlnQXNYYWxzbmFQb1U0NThvblQ5QUc3?=
 =?utf-8?B?emp0ejFWbFhCQ1lHdUF3MHk0UXdxVFVLU0ozUWd3ek5MWWluN21STVlqL2Z2?=
 =?utf-8?B?UnRuVmJwT1k0NDBiaU1VUlVrVDQvRkptenlXVUhpRnBaOVN3RjJEOG5PYjVt?=
 =?utf-8?B?ajdFazJtSGNxSkl3YlUwRDQ1Z2hqRjBGU1pjU1g3Ukl4WU0xSzJHMXFCNUNL?=
 =?utf-8?B?Mk44alltK05MTXhucTJpaE1ka3ZVUXRCSTh1Wi9qWjRBc04wNkcrczJOZWRa?=
 =?utf-8?B?aUM1L1lkSkw3R2l0c2IxclMxRTdRTUhCWUxMamh6Ym02Y1JxbkZtaE5uVEU3?=
 =?utf-8?B?YVRKMWVraEovODZpVjlncGw2UnRHWkdOZGl6NGQ3RXZDOUlmT1ltRVcvKy9q?=
 =?utf-8?B?eEZjNEVPT0thYUE3akthRytna1lHWFRPdFFkTXBQR1ZaVzFGc29PQ0lkdStP?=
 =?utf-8?B?QWR2ZHJCTGlNcTFWZm9SREtyK0tmQ3IzKzJ1Z0VuaDBLUGVzQTZVeVhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmMwR0ZkZWVSVi9WMUJsODExLzg1NndMbUFUeTJ6M2lNVG1zVXRmaDE0SW1R?=
 =?utf-8?B?Qm9sbyt6ckFrdElSRTNqTCtJUlJlbU4yaytoRlNsR1dLN3IvWlhCU2QvM0tV?=
 =?utf-8?B?Vzl4WmRQbisyM3k5Zmw4eXdyUGhUQ3g4SEMwWXEyb21kZ2E4ell2MVUweC9s?=
 =?utf-8?B?WU8xd2NVclYwSVRvWlo0UnZNdW5ONGpvV3g2cElQRnZmd1c5RGNFL3BQOEEx?=
 =?utf-8?B?c1FKeGdXcXFsQm51YWpueDU1c2FVUThYcnd1aHJRY2xiWVl2UTM3ZlprVGhL?=
 =?utf-8?B?MGRPdWcvSnpCcWNXRGUzM0FoYmFxcFUrR3Zzdlp5Qmp2bkRWYnlGNHFMSkxR?=
 =?utf-8?B?MmF3SUxTTnliOS9rSTU4UlkraUh0ejVPSjhMUTFBcllrcWxBMU1EQWpFNTIx?=
 =?utf-8?B?SDl6aGNPVnRUVlJGd2J2YlBmNTZvaUpJQllzTnVvY0x2YWlBY1ZVRFF5ZDNy?=
 =?utf-8?B?NWRFNTJvNDE5dm9SNGxZZDMrb2dJcmQ1aFUwWW1IV2FmZmRtZEU1TXMxVVBv?=
 =?utf-8?B?cUxGWGJaRHBSNjJ0WXlocGJFaDhiQnlWbzFJbWxrTnBHMGdKQ0xFd0RpaC9J?=
 =?utf-8?B?UU5oK1FGb3pEdDNnMjFmaDgyZVpVZHNxVUhhUFRqaWNadkJaYnR3cUgxMTFY?=
 =?utf-8?B?aVJndlJZcVpFTHYreVBqTEpKT20vZkcvam51UnVvL3RkN1NzSzRqazkvbEFs?=
 =?utf-8?B?Q3plYzNlM1hzWmVoQ0R4WUFUWlRUa1pra2FHbXRvd2d3K3Bka2doSENuSmth?=
 =?utf-8?B?WGRoMlFuNUFCVDllZ01tdjhQUUN0RmtvY1JLb1UwN3R0dnQ2MmVTQjZXMmxX?=
 =?utf-8?B?SHBBQ296R2tuaVlZQ210anRrcVlvMlF1Y2xXaGdBVHhtYUVwREdiMitvU3VB?=
 =?utf-8?B?cityL21ya216RXNtb1NuRVoyZXRoRzQ1Qy9oK0ZmM2l2U2hhNzdsM2t5S0Y2?=
 =?utf-8?B?YldRZExhczdYVmwrbEhIYWo3dkVxcUdtZnIvRmJkYlQvQUJmK0FvWklDNkVX?=
 =?utf-8?B?eFBkeStQRTh2UmtNTjYydGsvRVo1bDdCUnVnNlk3ejJNYnF4MytxRTFNTXRr?=
 =?utf-8?B?YmJ6V3JwaUZEa0hQWmJmMDlLOU9qOUhJS3hFZU9qamo1YldiVWRtcUVJK3BW?=
 =?utf-8?B?M0x2ekM2WmN5bWl6dWpGeXk0NlRxTjFZaCs4MjRlVFlsTGFqZzdhV2M3R1dU?=
 =?utf-8?B?RlpSd0hGaWJ4WVlmMWtFZU5sV2wxcDkyZzhFdG4ySlR6ZXl0KzBrTnJSUTN1?=
 =?utf-8?B?TDlQb2hUN2JqZGdMamVrQW9oeSsycnIvZ2RqZWtodWxDRUREYUthbGhwZjdZ?=
 =?utf-8?B?Rm95VFBqa2IvdmFRSGx2S3MyeWpiTVBESi9lb09tb1JiOFByTjBEMDBMRTFj?=
 =?utf-8?B?Sm9XL0Z2ZGFqYTl5YTBQdkdkY2hJbUk1eHE0M0ZqS2R4K0NiUHNWOHRZRWVE?=
 =?utf-8?B?b2plbTFIckVTek9lQkF0OVZpZHhZekJ3YVlwMlBZcW11NzlLSEVLM2d5ZGgw?=
 =?utf-8?B?ZURLUmtyMm9jd0RPK3dqRHJPbVRDZ1pMNDZ2elNta0puQyt1enQzTWVrSmRE?=
 =?utf-8?B?VDgvUFVUTk5GOGk0SFg2RmEwd3FWL1JuOHN0OWIxY0tIaDdIdkptUzN3cWVy?=
 =?utf-8?B?MDhBM0dDSlp4Tm1vSTY4ejJVbmRLZlhFb1FFdFExVDB2T20wSVdPZG1LNmc3?=
 =?utf-8?B?SytNRzJGNjNieTd1TlQ5YzRUNnc0UWlUTHVaVnA1dE9jZnBNRnZqa25hOVMy?=
 =?utf-8?B?bGFpMXNxaDR1WE9oWUdwaVAwWlFJK1UxN1NnZm1EUnJYdDBVWmNkVVpESkVP?=
 =?utf-8?B?UGtoZTNTTFgzV0lWSTZCSTRHYjVuQzZOYmQrU0hGTkhqNmZya28wQU4yaFdL?=
 =?utf-8?B?Mzhsb2pnRDE0ZUs5VjMxbUE0M1BvWGsxRGRYbm9Wc0Q0aFJjc3RvOGZuQVZx?=
 =?utf-8?B?c1RITTIxbDVoUVRWbGZZTTNFeFFUK2c2b1B5SzdKK052V29NcnNOWk5vYm15?=
 =?utf-8?B?MG04ajlqQUkvUzNhbUFGaWxtaFMyaGpZdDl5TmFPZzYvQ3M1UjlPU2VmcjZZ?=
 =?utf-8?B?YzBiN0xPakY3SWpkZklQYTlnNHphK3hiRTBCR3FTVk00dlVHQVJUTkpDYUxi?=
 =?utf-8?B?Snp3VElMNGdGZVh0RFFHYXkySUpOOGFuSHVJQWYrTElyaVZGVzdWTnBOQ2lO?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f4dd25-3881-4e69-6dbf-08dce7b7ebba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 16:40:30.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx5CXkpM6UEQ6O5++HeQAdaoqEiNSA5Pr+HYNNENjqvA0Ecvlfn9fL/VzAUkdBTuYf7pUEcb988frAHnvCnESwcpSaV0rF6MmZBp8k/teFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
X-OriginatorOrg: intel.com

Hi Tony,

On 10/7/24 5:00 PM, Tony Luck wrote:
> On Fri, Oct 04, 2024 at 06:03:24PM +0000, James Morse wrote:
>> The for_each_*_rdt_resource() helpers walk the architecture's array
>> of structures, using the resctrl visible part as an iterator. These
>> became over-complex when the structures were split into a
>> filesystem and architecture-specific struct. This approach avoided
>> the need to touch every call site, and was done before there was a
>> helper to retrieve a resource by rid.
>>
>> Once the filesystem parts of resctrl are moved to /fs/, both the
>> architecture's resource array, and the definition of those structures
>> is no longer accessible. To support resctrl, each architecture would
>> have to provide equally complex macros.
>>
>> Rewrite the macro to make use of resctrl_arch_get_resource(), and
>> move these to the core header so existing x86 arch code continues
>> to use them.
> 
> Apologies if this comment was suggested against earlier versions
> of this series.
> 
> Did you consider replacing rdt_resources_all[] a list (in the filesystem
> code) instead of an array (in the architecture code)?
> 
> List would start empty. Architecture init code would enumerate features
> and add entries to the list for those that exist and are to be enabled.
> 
> The "for_each" macros then walk the list (variants for all entries,
> for "alloc_capable" and for "mon_capable"). Note that only enabled
> entries appear on the lists.
> 
> There are currently a bunch of places in filesystem code that
> do:
> 	r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> or
> 	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> 
> those could become:
> 
> 	r = resctrl_arch_get_mba_resource();
> 
> 	r = resctrl_arch_get_l3_resource();
> 
> Then the whole "enum resctrl_res_level" and ->rid field in
> struct rdt_resource could go away? Remaining uses look like
> distinguishing MBA from SMBA. Perhaps better done with a
> flags word?
> 
> Advantage of doing this would be to avoid the generic
> enum resctrl_res_level having to be a superset of all
> features across all architectures. E.g. ARM might want
> to add L4/L5 resources, X86 may have some that ARM will
> never need. RiscV may also follow some divergent path.

Ideally resctrl fs would remain as an interface that a user can use to interact
with all architectures without knowing architecture specific details. Platform
differences can be exposed by resctrl in a generic way to support this.
I am afraid that allowing architectures to diverge would require resctrl fs users
to additionally know which platform they are running on.

> If this v5 series is close to being applied then I don't
> want to derail with a re-write at this late stage.
> All of this could be done as a cleanup after this series
> has been applied.

Due to the already significant size of this work I think it would make it easier
if the number of functional changes are minimal. Specifically, only those functional
changes that are required to accomplish the goal of moving the code.

Considering that one goal of this proposal is to support architectural
flexibility I do think it would be easier to understand its impact if it
is implemented on top of the arch/fs split.

Reinette


