Return-Path: <linux-kernel+bounces-378936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E6A9AD76F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA9B1C20BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47ED1FDFB6;
	Wed, 23 Oct 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7kxTJUC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5D1C3030
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721967; cv=fail; b=rFD+xRjEcwmYpzHQwIjebW7qoVKVK/fSue02Kq5yox02qJ8N0GWmV2bA15GnwHGXCQaaOJElEMeyzF24DFOwq1Q21KwTklpBfJbvM27Tztl/AJC58wV53aZVo+9Y3Oc6xsPsVeHhjoaWyz6ubusJtNagjsBP6qbMKCA5c/5yweo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721967; c=relaxed/simple;
	bh=E0+ekdGSOTlq3TC0ypIbdDzkW1Ywo18eZEvdFtlS9UE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D22tdgu1yeuCptNo1I9ClQ4VbPhqBl0exAW4bKrTtA+KSzZxOWuGtJjrl4LMIHlDBLOlqzkx0zHtvIag7sBdtxtsfzHLfHTbk1IweD7IB6eIXuNrBITBcg9z3toDu4ZqAIv0Fe+GdZ4UPli4vieWPSNC4wQttKq/PWlQCQlcmlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7kxTJUC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729721966; x=1761257966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E0+ekdGSOTlq3TC0ypIbdDzkW1Ywo18eZEvdFtlS9UE=;
  b=n7kxTJUCiV43fWa5hggY83sBaPl0ovWckiLvZML8dgTCtSd8LfEZv3Mo
   nLtSjWXfNJVqxrivjrB863aYfbLCuKRW+HyT3a9TF3VONLYO2TLd7ZGFP
   pxLoPo0fY1w2eJBZJZ7fwEyxktjlWR7jqjGpdM9IqC1APV2Yjy3OFhycv
   eTaMFrt12YScwfWI0rwCc/1mOKqBaMWSNFR3BAm1iCnu/0Tihr+HT0F3Y
   SulAQFd2znqbJS9FChW3TDaym6hXPSPI4Z3gi6oAIrGicPCVnxVKmZdFj
   SbmV7HVvGS2BWqVtZlbQxxE+IlHoNlsZlDFYwSPCru2eQu0yGpwISV9Xj
   A==;
X-CSE-ConnectionGUID: nL9XvdV9QqSihBTb33SW8A==
X-CSE-MsgGUID: BHS/nqK7TGSPVF+GmUn4Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="16960504"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="16960504"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:19:25 -0700
X-CSE-ConnectionGUID: TOkRUuu/T/2MEkCUoOQQoQ==
X-CSE-MsgGUID: kKeCaGgiQROFBnTO8uIwiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="84963113"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 15:19:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 15:19:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 15:19:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 15:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED3JzoGrntSZ0klsDXN+QwDX7g7e9V0HvO1QD20WA6DIPGbCA+rijZyXpmaH676AE5QKTDmlh+xm+ycXDi/96uLZr/BNqXib3NxbI7JNE52Tl9vGtpPYfaUJguLDe0F7haLOfrTZXIJV39dAbmUJp4UvDFWObM3C6uMYB1u7OGwhFZPK7dzVP3PAe6jUgQod2XQuX4LE56V8HuxOArpXTJR+SuKzaQRqu4V6quf6Jf0OAVmimGgZJ71ImDjtPz7G9P6M3bSk1Y7YPDyP47czO6Q27chhOyUea81NL9BR+jHRUYj/hZmvbWwdEdg0vyyW/9J7cOzScD2sj7m/Cqja4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JFn0CSI8hJR0ec0xz+JsicIrP3t/A24fZbSk+Gf0UE=;
 b=VGHCiSkU00dflhvSy0c8ZETs53U6w3wlGX76OKHddaU7lj6duehkgNfqYvR53iU/avt/cHVutYKUtPHz6aLbkv+u34YwUCbma2aTvOMEDp9gS9n4DdNZIbjGiqmlmTXxpp5q3Swc8Vv7DJCm7dIq+6NRLk7pRR4iYl9NMSvcUzjkCg1aQVUUMD5GLlQuiUMvKEGDXI7evRdNTnZuqoHedmcQi0swz+WTmRhXJIRohRKabUHpjg1/d/lqHb2hhCXP1l9Ok5BdfCW168LZvi09SRIpp9IBBqT9hgpsUCA5UwBk+fuSbYTiiaCadXo/IHAyH+LYSHNDN6AZQfBJVHqPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7706.namprd11.prod.outlook.com (2603:10b6:806:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 22:19:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:19:16 +0000
Message-ID: <a0936b56-4a60-4fb3-be65-91e65d360aca@intel.com>
Date: Wed, 23 Oct 2024 15:19:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/40] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
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
 <20241004180347.19985-22-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0323.namprd03.prod.outlook.com
 (2603:10b6:303:dd::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b96567-4279-4434-2468-08dcf3b0bb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWM1UkNETU9SUmxWM3ZjY2U5T08rTURON1BFblM4eE56blhSM3QzRDhLd1U2?=
 =?utf-8?B?Z1hCVmxYZFp4ZmNNbjdENjZLamhUSDNwZXVoNWVDaVJRRlJRcDQ0VXNvNFZx?=
 =?utf-8?B?a0NGd2ZMTDRDbGdVRml3K2wra29VS2FMaHVDaUw3ZFhmSXg1MHNrNUw0R1Iw?=
 =?utf-8?B?SHhieHl1Yllya2VVRkE4OHlNVlhrVlJLY0F1YXBrc3BXWnpLVittV1lpbnRv?=
 =?utf-8?B?SUIrZGw3OFF4UFNEajlzUmZDa3BDam5GWjA0RDZ0OGp1NU5ScFpWYU42NHJD?=
 =?utf-8?B?T2FIN0ZJSERjRjdpbW5xK1Y2UFYxK1VCbHpuMnZFNDJJNEVudFB0NitPNk5X?=
 =?utf-8?B?bXRScjAyVDh0NHdqY1RuRjNzdGVSWTVWL2V0QXk4a1pZNTVIcjV5aTM2bWZE?=
 =?utf-8?B?aWZzMHlCR2lzdk9iTlA4L0ZpVUxDNFluSmU2V3BydmkydjZ1cFVSTFZZUnUv?=
 =?utf-8?B?NXh1K2JSd3Jva3VjZjRtdExxam9laGFrbmtxSFBNczRQdkNkNU9lK2JyYzdm?=
 =?utf-8?B?am9nMWhmNHJjZTNHZmQvUDB4OXZVZGhrbnlhOTBKRmEyeThXN283TGVtVlVN?=
 =?utf-8?B?K1A0cVZWZTRFRUw3c3g0WXNvTDlCQzB2blRzS2NiUkxPUFZWb0MyMitLdUV2?=
 =?utf-8?B?eHd6Q3BhK3FleFVldmpKTXB3cHZXNTViaVU3amhnaUlQcWhCWlhNamRmeG04?=
 =?utf-8?B?R0JjUWlMQkNVaTRvL0FnbzRJaWZZdGl5K2Jkd0FYWVQ2N3JrNWRSdkhvMUd1?=
 =?utf-8?B?dXZxRUJUTDRyMEZhWXRNenIvOU9KWHlxbHF4bEE1ZjhZOHJrRWZrYjc0Zk5m?=
 =?utf-8?B?ZmdZbDR6cXFBdklGcHpCd3lvRDFEVGxtRW95Tk5oMW0zRHBlYUVqM2hGRFkr?=
 =?utf-8?B?SU5ZVy9rdENlaXJlSGFpRmlPYm9LREV2MFVNSVdzTzgrV3ZudzVBQWZIakg1?=
 =?utf-8?B?bDZ0clcrUjBhRzlwb0t0ZzNDbXR4eTlHQ2Q5K2pVTHJ5MWRTaTlCRHdYM01I?=
 =?utf-8?B?eTRtUURmT3RtWGFVckdKek44Z2orQzlvUFJSZTNFekVsdUxEOGNhMm1jZVpa?=
 =?utf-8?B?bVJ3V2RoYTBZTjYzaWdHNWNUVXlqV293d0NXVEg0blgzRHBOMUxyUjJWMCsw?=
 =?utf-8?B?WXNkb2lYaVkzSy8xdGNBT1RBMDE4dVF6QXZWeUNQV0d1NUtJTlVpb3JvTDVK?=
 =?utf-8?B?b0UwYzRIOW13YnJDZmNQSnFDSkZuMkJ3bGZ0OEVjeXV5dHpRRE5zZXdKM01u?=
 =?utf-8?B?anE4MkxNdFR5SnVvcENpRFJZSTlPQThCNndRdG52dFVkWjhHUlNyQnU0Vzdy?=
 =?utf-8?B?TS9sN0VRTGorQ2ZCcjMwTTFjcFNONjAraWo1ZXJ3MVFRZXR3WnhhdnNjVzZE?=
 =?utf-8?B?citiVEYzZGI4ZElmSTJTRm56ckNMbFBLQ3gwTjllTTV0VWJQQ09JNEt4V0kr?=
 =?utf-8?B?Qit1V2pnZUU5dG5xV3FZMWNxN1FMU1o5cEk0Yk5aWWhFTDBPc1NES0JJN2tZ?=
 =?utf-8?B?cU0xOHM1cXhRV09xbVVWSllUOUVIUzVib3kwdVpqVU1Kc2IvMVloMGprejM2?=
 =?utf-8?B?R0NoanFQK3VOR2NmKzJKeS9QMzJHL1pDQUJBa2hhMTlKUVpqN3JjeGxsSS9P?=
 =?utf-8?B?V2h1THowbi9MVXhYUHZHOWJvemoyNEJrTlBsamxHWGJmV0ViSllla2JNMmNn?=
 =?utf-8?B?LzkyVXV4ckU4NmxFTWZ3VVE4UFFtUytNUXQ2emdlaFc0dDdjRWVBak85Mkdu?=
 =?utf-8?Q?nvFH1kzhaYrpQk91y5Ur0yeIhyaRXXRTMhRmed/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpXTXpmZ01HK005UFZFbVR0KzVJTnh4T3pzZ2FhUEJrTnZ5NUcwSnQ1dmZz?=
 =?utf-8?B?ZTNpNmpuQkhTeFBFYjVIVmFQMGV4ODhzK3Y1MDA2OXNxNjZzRUZ3S0pXak4x?=
 =?utf-8?B?RURDZ1Zsb2lpbkdOaW1KSmRCNm9NMHdQem5sekdHdDRrOW9OTFRWcG5DZmU2?=
 =?utf-8?B?VHVtS0lTWEMrTEJQLzZtZ3gyNnBZTXZ5YW1FcHNSazBKeG5MNElyMEpJSTRn?=
 =?utf-8?B?SkRDTmprSnZndVUzQURyUVczU0J4RWh1ZXR4c0EzQ2ZWVkpqT2xjZUI3MHBy?=
 =?utf-8?B?MWtFNGM1eG5vbWVydnJPQTVIb3EwTnpVSnBXWFB2YzBGTHNta0VKNFpzSWZR?=
 =?utf-8?B?M3k5dHI0NUl2b0FKWjlRNm1Bck9CSzVhNDlTNXZ0VkhIWkFDVURrTXN2ajJW?=
 =?utf-8?B?Y1BBeGVFYjJQY0xjYWJsMSt3ZElnOGRISmtKUnBFbGc4TkpZc3NESkluVDN4?=
 =?utf-8?B?clk5bGtYQ2lxMDJ5VGFsbzFjZTZzY2I3dlFuNUpwSUJsRUE3K2hEcWRSVHdl?=
 =?utf-8?B?c3dPWUNVbmFzTTFMWnlNTnk4aXRTWXg2ZnBNdHZZWldJc3hqLzNZaHJpOEpn?=
 =?utf-8?B?YVBZNGlYY2ttWHlVT0ZoWnVnOGxhMjBkNldQRXNmaUpqK1BnNC85a1ZnQVY5?=
 =?utf-8?B?YXVTTm9kUnBjY3NMb3ZxclZUdTA0WHBPdjdxOXUxdjN3TmRMV2w0NjBPYjZR?=
 =?utf-8?B?QWJYTmh3UGk3Q1g0bVgrTjBDY0lWdkx2VnJ1NnpOTFZtdFQ0dzBRWlRSNkpj?=
 =?utf-8?B?NDR1dWZwUlI0S08vR09obC9IbWNzOHN6NlBqSmxkUnNKNURuZDhkTG9oS2Fi?=
 =?utf-8?B?ZUExcnJJTVF5MEFMSFcyakFycHVEeTY4c1hGY2swcVpCekZWVk9oVmNtRVQx?=
 =?utf-8?B?NVNKQzdYOFBGZkFIQ2xaNFIrdUJOZW1tdEZ1VEJsTGFYOXBhRjBiRGs2RHp3?=
 =?utf-8?B?ekJBa29MeGt0b3AyUW5IY2c1MXN4dG5ERHpRQlpVdThzQUozekhHeFE0N2N4?=
 =?utf-8?B?aURsRkRQUjVESGxFSTFjOWNacG0wdC9WWGVTZHBMdXlzRU4rT293ejNRZW9J?=
 =?utf-8?B?Uy9ldGhnWEdiYmgxcTN3YlRtNlBvd2VKOGJDMW9qYmdBam1RdWF0N0s3VFJY?=
 =?utf-8?B?SVlqd2h3VmN0b2RnNTZRLzZCTEpuNWkvN21CYldJc2FMT2RQSFA1MTJUTlZj?=
 =?utf-8?B?SzZINm9nOGNuck12NDIweFZRbjA4VXZwNWJOc0tPb2pmOWRrbUM3N2wvSGRr?=
 =?utf-8?B?ZGE4d0lWSVZOS3JvYklqOW5CcVhMa1JVU3I2N2FPN2c3QlV2Sk51cWs3N0FN?=
 =?utf-8?B?Z2ZKbkNzZW45TkxNZFcxcXBUOVh2MGdEWnlzZUJxTVh2Vk1JTzJSZHlOMThU?=
 =?utf-8?B?WlJva3JMeE9GTkVJTGFXRjFZU0lSdnlQSlQxZWEyRmNTcjBUbFBEZnlyYTV5?=
 =?utf-8?B?YUVuMWg4RTFtTzl6aEg5L1RkcjJ3L3FsZGVrTHpWMWJHRXp1N2lnRklZZmsx?=
 =?utf-8?B?cGkrTXdOb1hlY2V3a2E2Q1dOOEpOcnorTk9xK3JrNVJ4Vm8vd05IVDZrYkt5?=
 =?utf-8?B?aXJoOXExem5qMHBZY2svb3IyWUNaMHFIS0tvcU5rN3F1S2ZlOTJkcEFqQW16?=
 =?utf-8?B?NGFCVUVzTGFGN2huWS9tNzJPaEZTN1VkSnlLMmhFWkVIeEFDdC9kMzZxVVUx?=
 =?utf-8?B?UVVLeFFQUkc5bUJod2hGTUZicVozZFFFN1QrUW9lRThqaHR5V0lOVkQxSE9V?=
 =?utf-8?B?YWd1S215WEh2Um1KeXpQUUtzSXpFUkhabHB2Vld2b1NFRkRLbGZEdE9YOUZn?=
 =?utf-8?B?akxWUTFJbWZVcW1pOW5MQVVnT00wSW9KU1YvRmcvVlJQYXNyQmVtNjBPQk9M?=
 =?utf-8?B?NE14SUZhUFUrMnREMExCZWoxWExLZjFzdytvNEpKYk5QTkM1VG9KNDVBSDJv?=
 =?utf-8?B?MjE5a1g3dUY1WXFUZjRRVjZaRE12OW5sNjBMMlhJa2dLdmx1c2dFb2IwVmwz?=
 =?utf-8?B?Zy9KZlpsaTBRVkxuZEIrUHY4UElXcTJncUo3dmFsQU1ucGtTWVlzYUtoc1N1?=
 =?utf-8?B?Wm4rNXN0c3FENjQvTDJCWTBKZTFmbFFUMTVYOFFab1EzMGpvandTaHdHRmtu?=
 =?utf-8?B?ejdYekExS0wxb28xd2IzTHEyUlQybW1VL0VRVVlYZitibzRoYzdwY3Q4UTZi?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b96567-4279-4434-2468-08dcf3b0bb6b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:19:16.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lywQ0nRKEuiBWeUEVICrYSMUgglZ+4x21BrVZIp5bIj0/thlKB/gDpMs0GxBIJrrxZtbRNixi1YDtfv8byGFedKvE5R5TBEH9sAoWzJkxFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7706
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> @@ -315,6 +322,24 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>  
>  bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
>  
> +/**
> + * resctrl_arch_mon_event_config_write() - Write the config for a counter.

Please avoid the term "counter" for events ... the upcoming AMD work adds support
for counters*. 

> + * @info:	struct resctrl_mon_config_info describing the resource, domain
> + *		and event.

Expected "config" to appear as part of information about function
that claims to writes config?

> + *
> + * Must be called on a CPU that is a member of the specified domain.

I am not sure about this. Is this documentation intended to support authors of
arch code? In that case it may be instead useful to know that this function will be
called on a CPU that is a member of the specified domain to avoid confusion from arch
side whether it needs to take some action to ensure function is called on right CPU.

	Called on a CPU that is a member of the specified domain.

> + */
> +void resctrl_arch_mon_event_config_write(void *info);
> +
> +/**
> + * resctrl_arch_mon_event_config_read() - Read the config for a counter.

counter -> event

> + * @info:	struct resctrl_mon_config_info describing the resource, domain
> + *		and event.

Copy&paste? No information on how config is returned.

> + *
> + * Must be called on a CPU that is a member of the specified domain.

Same comment as above.

> + */
> +void resctrl_arch_mon_event_config_read(void *info);
> +
>  /*
>   * Update the ctrl_val and apply this config right now.
>   * Must be called on one of the domain's CPUs.

Reinette


* Awaiting Arm's feedback on that on whether it works for MPAM.

