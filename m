Return-Path: <linux-kernel+bounces-234242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D7D91C431
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C9C1F22751
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7971C9ED9;
	Fri, 28 Jun 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXB9jtcD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D4D2E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593592; cv=fail; b=irZdNHxwCV2ViPI4CeuhIsFvCb0Hjaff5ziSvvvklqPSEXE8CrZ0iD3N3ObAUAE/QDxtGi+oJO+ZBPeWXSny1R6PR1DTPMlmgzTqX+X39g/LKmeVe4Fc7O/hI4TeZx8OKAUR65h1zMDIlX6Ep2uDPGQYwDBQySlJ0I9OTBp4SAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593592; c=relaxed/simple;
	bh=YV6au8dnZqy64s+CUigNAuatVGlI9/sCuCkMpQLU3r0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YI/mF941MKUaxPvHCIq8ng0d88jbgSfW0KmjCoGgg6Z6nDdgeJXqPpLAI6XZLqknQSzG4dKRv0hV1Z9Qear8B9AWN2WhhZw/vC1FhNrIz6J7N9GuzxbyXR9rEtggHJwzHJ4oAMOfS6ymn6xnhZ12N1dT8BicVrtrM7OdGwnl9PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXB9jtcD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593591; x=1751129591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YV6au8dnZqy64s+CUigNAuatVGlI9/sCuCkMpQLU3r0=;
  b=QXB9jtcDKq6w6wl7NHhpR5muEqH24UcRwUHMPO6mBpGHvP+Hd5ML+YwY
   gFyH9kNam8Hw+THZiDmFDgHtAMi8eO6IFXU3JVnD9u43e0G93ld3IcSLN
   ZcRiXM/kjbCSo5JelbGy4EaFJgeKIy7HQDs2ECfy/CijE8sTzEyDGFlxS
   szoIeE42q/o/c+tGtbpnQzYxYKNc5DZKmFxwLqlONyzeOAiXY7AQOcQcA
   UtGrlEVRMFrg+2KS9fiwMo7UYXnASWCU8oA3TXXjsxPAAPiIIaqI0Xacl
   JDFnU64jIACFLrMW0oKbl9raMKLj5KVEv5coi80eFYGHo+LM+FeK51M+f
   Q==;
X-CSE-ConnectionGUID: yIua3A7uRE+o8+vsvTnC6Q==
X-CSE-MsgGUID: Xm0Wtbn0RjCHd0PFcXqbIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16621016"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16621016"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:53:10 -0700
X-CSE-ConnectionGUID: Fg04iK0/Tn6Ek1qy4dKqLA==
X-CSE-MsgGUID: poOeWqeERAO6IHEobxza4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="75521888"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:53:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:53:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:53:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:53:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImA3c8377oOifybzckMOqH0ilY3dYwl+prCDyqHtoqXAEQnkKrrJyy3o8XPBLLqB+617end838V0RlpEwcPfpz71iw46tlei8ZQqDiCvbgAlAZBhdu+s39mYTwjaXShqQOrIqi5tcuDtaUPaY83y/OMBNUjXtKU8hQfhontEWftDuOglW6zUgylg0WiFK3iC7+3agKEDL1Gc/x02Pnv2LwGpOxZMINBCotDGE0bj30qxwbDIDCJYPzlr0B1F7qTUuqgpuwcyF6u7Z7leiDOWPTRCglXmKLo1KO8CoF+t9g2vsVxjpjYVfwUkJKoImFT4U4JXx6zzSYgcj6ygMjeiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5TPtrlNL4VmjiwYtvA6BE3D6z7IZvK7/tHfRgUUwW0=;
 b=C7fRsUsvvaJeKJVk7by81GgQokLJeGL4JSfXkiRgLI20yhDNq+oewMnFLP/p+KSnIWDXcCMZ+TEmOqNh5gG5YUcbRTK8QEubJZi+aPd5foI8dB7Y5CwmFFhhUwCBO2MWmbNvX5GOzphHlVsC8OgBX+pqK8Kvome8y/aJ1JdZEzEU6hP0pbukX0KBcHmBzxVy3kgYU3ljr4eIZ3em0t+wz/Sya3AHoUe5jDp8xIW+5cCUi5SPU59XMIqKo/y+BZywpNghD9P+aNEAi1/HjQvTQqCLkKN1C6JgZvAE4hc3vdQZQdwyH6TqKKE++rui/R/UQdZR+k892l1p89nPq55iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7543.namprd11.prod.outlook.com (2603:10b6:510:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 16:53:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:53:04 +0000
Message-ID: <4ae9d344-c950-4b6f-ace7-1c1bf2c0812a@intel.com>
Date: Fri, 28 Jun 2024 09:53:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/38] x86/resctrl: Move mbm_cfg_mask to struct
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-22-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240614150033.10454-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: df9412d3-6fb6-4226-e3ab-08dc9792c723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2N6REkzb3JwaHVyWkVESTA3YlJUdXd2OE4yQnduYTNScjViU2xtTFFsYXJs?=
 =?utf-8?B?bkF5UGFsQTFXeUQwSXFoUVVPMG01WW53RFhiSTZwT1ZJUklKMWErTmxIREZx?=
 =?utf-8?B?SXhmMGFyQy9LQ3ZsV3RxRlgyTjk0Wml1L1dtYWJkTlUwSUdlcDhSVDNabGhn?=
 =?utf-8?B?MmY3b0lRTWdieGZ6ME1Fd2lXNHl6TUluQmlOL3hIS1hnWnArV2Flb2k0R0VP?=
 =?utf-8?B?Tm1md1lYN20rNWVWcDBlSk0yUHJsRlpURTh6U1E5Yk9aUGt2eVFHeU9GZWxC?=
 =?utf-8?B?ZEhGUUpOVlMrRk4wOGRwaTBEZE1FZG5XVU1VSHdRU3lQTUw0ellwd2d1Uklp?=
 =?utf-8?B?NXlSbk12MjJQUzhtOFNuTEIvWVEzcENFa3Rrb0NQd2tCQ09pMjVpSG1leE9t?=
 =?utf-8?B?Uk1uSUJpM0hkK1R6U2NvUi9JOFVGRU5pQjJvRWZmTnVycTNSeEhDV2RJWTlx?=
 =?utf-8?B?Zm1VS1NlaUY0b1dpVE90akk2MlRYbEwySUVWenQ2YjN5SUxCMHRSQ2N1S2ZI?=
 =?utf-8?B?K3lVNWpaVG4rSDE1ZC9jbmtVQVptek0yYUVRNTJvRHk5Q2VESm5LSjFKUVhk?=
 =?utf-8?B?VG9nSDNKYzUrdUszenQ4MlRacFR4dVpJbzlZeFNoUXRaaytQNVZxTTl5ZU5P?=
 =?utf-8?B?b2J6QkNNRmoxaGxSWFJRejJDOStuUFlIVExnM2ZHOVBWNFVJaEtaQUdTRnI0?=
 =?utf-8?B?QlE3UnNCSWZ6d2t2NStzaitPWjFDQ2dYRVZtVkJRbmN0c2NYZHFCbFYwd0g0?=
 =?utf-8?B?ejRLTytLWFBYUThseUNXM1FURFJZZDljV0tSTEJHQU9Ucms2M1grTlpzN2pD?=
 =?utf-8?B?c0xMaGEvbjhaQ0VFZStFZU9PODJ6YmticDNGcWlJK1dmNmhmVDU3dGQwV3gz?=
 =?utf-8?B?NndmVm9KbTJxSTBKM05HRXg1UGNmdmRHSWcyTFRhblpwRFZreTlORlBLaVg1?=
 =?utf-8?B?RlVTRlZURW5DV2VSeW5rd3pTVVRjMUxjT0VYb1FYRmxPSzc5OG1OSFFZMEtC?=
 =?utf-8?B?RndDalNvcVhjWGloL1FaUDg2azhvS0wvbnM2MGdvSDZYN1E0VEtpUlhzVzF2?=
 =?utf-8?B?d2VZSVc2Y3kzNkxobDBUb2VvaFFuSlBvUkFMbWZ4T2NrRDA2NFErdStVVG93?=
 =?utf-8?B?RTNucTdrZTA5eTZnZVZlK0U5Rjd2KzZoenROVmcrcS9SSjZ1QXFWWERDbXg1?=
 =?utf-8?B?TnJ0aS9MS1YzNnJMRTQ5UXJTUXcyM0MwMGM3T0lKY29FU3pHSkxNMlpYT3BF?=
 =?utf-8?B?aWhick5VVXRlTGIxM1doTjc2YVVkM2xzK2puQnhJMkJhR0w2RVE3MkRsRmpJ?=
 =?utf-8?B?UDlxRGxnWEI5bFBvd2I5bURyUkVJS1BPRDlrVEpHbkdhKzM0c1RQbnJ6eTR2?=
 =?utf-8?B?bm5yL0YwS3Fjd1drTlVPVWhvV2hxWkpBcnQrYlhONTYrK0ZkcUVSb1BmVllY?=
 =?utf-8?B?bmQrQkdDbEZYRDNqb1NxTllyYXl2bG1tVHlCNTRkRjZoT0s2ZnUxZG56RElR?=
 =?utf-8?B?akpUTTRLU3VVQWRMTHJNZkRTWnBKQ3BLYng1dFF2T3FKOGpuelpRaHVNVURa?=
 =?utf-8?B?emQ0dmlLSXc2OHdhaG5XSzNHeUZoZDhlUzVuVkx6ejhsemRJb3daN0JSVnE0?=
 =?utf-8?B?ZDRFd2NMUjRhWFNmN0JxbzlUdE9yUnVMR0hBbEt4N2w3N1VlVk44SUxGVlhy?=
 =?utf-8?B?Tm5xNlBBZ2FxWVk1eW56K05uUWlibHZxVzAwdStGZ0xrZVAwSGRHSkplZ3d4?=
 =?utf-8?Q?OjmDPMbC6Jw8BBeTiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STMxNEJTU1JLSExQdm9wMG5GMmlVZGJBNzRUTHNIemRhTDlGSmVGR0kxZndB?=
 =?utf-8?B?VFNoMXZ6VGZRVFMveUk1YTM2S0JLbklmV3ZJbjM0L3JWQzRyWHpQN0h3dEVz?=
 =?utf-8?B?Q0JGYTRha1VWVm42Q09sbzNkVGJVbHJiQ0lwMlduRUxSUmp2alRRa1ZaQTNm?=
 =?utf-8?B?YnZnVld2QnJvaXhjVDJ0RGg1RnIvMVFocE9SOExCeCtBWkxpckpKU1hqTHBE?=
 =?utf-8?B?d200VUROVkhZL3FtWXNEWUIvb0gvZUVDVnppSHdiMkxCOXpRT3B4ZHRIbGcw?=
 =?utf-8?B?REFISWFOYjAyY21ZK1FOVklxOEJQRlZmNE1Kb3d3cURHVGV0TnFuRUpuVXNV?=
 =?utf-8?B?a3U5NFh2Sm5qdE9FV3NjOVVXaUd2OFlISmhtSDd3NElYRy9DNW84WGdxenZM?=
 =?utf-8?B?L3dZbWV3cG96Y1NodThYdGRLM1NycFhvNXNDNXpXdngvOXV0bTdTa3k2ZDRD?=
 =?utf-8?B?M0hNUGF4dTZzclNPMndwQVJkOUE1NFBnNCtTd1ZyMDZoakNwM1M0N2RDVm9K?=
 =?utf-8?B?M1VRNXhZeVJQOHlhQUpTbXArMXNKNUJ2WFhPNTYzMkJGNy9GR3hWRXo0S2xq?=
 =?utf-8?B?NGh1blF6K256WnIvUEVLa3hmU0tqZmo5ajJFZHphcGhNdmI2ZXNKcUplRVF2?=
 =?utf-8?B?SHdlQ3VFNUJleDlINWJWUmQ3M0c3aGY3WnJUMWZrMjY1UzN5aFJkajl4dUJ2?=
 =?utf-8?B?RFIxN1Rpc1ZTM0VGRVpCemVYemJHVmRTNzNyOWpQODNXYXV5Qmh0Qm15RDRh?=
 =?utf-8?B?TzRLZ3h3WFc4MWtvYUVUU01jcTY3M3hMbC9sYjFEWDZaZllEOGgvRXZ4cCtI?=
 =?utf-8?B?anZvS25ySTBoZUZrV3RBeEJrVzV4cndSSzdCemxIazVHc291K0kvRXNpelRC?=
 =?utf-8?B?YmlzVXRENXRmWDRtUXdGNENVRXBidWVXOHFXMEhTODVheUZXaHY5Z0dlelVK?=
 =?utf-8?B?WnpyZCtsWEd5Z0loa04wVllZQmJYU0hVOXRpMW9OQmZOazhXelJnNmMwTE04?=
 =?utf-8?B?b212Vjd5cVQreU83YkpTSUJTZyt2MjJOYjlJL3RtRi9qZ0FJK1g5bmpoYXQ5?=
 =?utf-8?B?WW9mNENhUzdiVUREQjdMdWlMenI4b09xU0NHVDd4Q2VKZkxMdHFCQ21aYWM3?=
 =?utf-8?B?Uis0N2dwYXlkbkdpcXd1K2lCdXdQRG9rRERpdjZCcGt3Wnp5dmZTL1lYY2RW?=
 =?utf-8?B?SVhFR2RJckN4d3lZUXZVMzRBdjdYTUFaZTg4YjBLVGpkTnJsK0JYeFY1bTdS?=
 =?utf-8?B?aHliYU9LaUprVnF2NEJQekdKL1RpMGJESjIvTGtqQXdJaThjbkFRNXB1T0FM?=
 =?utf-8?B?K05VaWc1UGU3V3RqeUJINzIxR2tqUVpkZlRRSndyMjlLVmF2M0piVFF2R0xy?=
 =?utf-8?B?Nm9yeFMyT1FVSzlSSHZ5ekF2emFtWjVMRldQakx1dWNzRzJBNXp4bDZ2TXVS?=
 =?utf-8?B?MHp6SC84bzBXZHBuakx3elk2NXNLRjJheEkzc21KeGNZZzRFTEtndEJKejgw?=
 =?utf-8?B?aThCbDFyb2hmaDE4MkhJY2NZTW53VkF5dEhhajJEZmRLL1dUSEF2UUE5UFBT?=
 =?utf-8?B?K0VDeG0ybm9JK2s3NWdXbzBKOEJWVUc2TUNvd3VwYktnRFZ2YXBIS1FrbWZw?=
 =?utf-8?B?UW1FMVRuTCs1aDNvbWhZanRsTkNCbkVGRXZxVGs5SGxsK3UvQmNGSVhya3dT?=
 =?utf-8?B?Q1hnMm9RU1VVRXRZd3c3am4zUkVEMC8zdi8rd3czLzJTS0FVY0lheUJCUFlz?=
 =?utf-8?B?aEozZUpjdlBvTmNKK0FpTkVvZzNpNFBBZUZnbnFxSXBPc3J0VitZaFZNZWpB?=
 =?utf-8?B?dlVjY3pvM0g4VStqeGhRVTQybFp4WWpRcWRGT0c3SHlGaEJLK0pyYlJpbXVt?=
 =?utf-8?B?YnhWV0RmUWN3R21Lc3VMTmMwSmlNMjBKdkQzaFZ2SXE4THhhUjQ3UDVCUU5w?=
 =?utf-8?B?aHZJVjY0QzJxRkFzcjNleG45dHRONXFHYk9iWi9BRHlzSTVOc1N1cjY0NjIz?=
 =?utf-8?B?eHV6NjZhUklRakVFOVp1NEhSUEdraGN3cWx1WjRpelZNRUtpczJxdW5qNXFa?=
 =?utf-8?B?NUFhQ1c3b3JOQ1lvRXhYVy9USmREM3lZMFlLM0tvWVUzdGdlUUxYYnpzVWpZ?=
 =?utf-8?B?TzFWdUpYOVoybDFPbTQ5bE1IN2NEYVFTMzA3dVR6R3VmcFVEUVhDOWo1K3Uz?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df9412d3-6fb6-4226-e3ab-08dc9792c723
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:53:04.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtH8m5BHLZsuog4Pt4SwrGtqgbi6/ASkEE3PeO6vLLycew2XnVRfPy7mzji84ejmhbpQZ9O6jChvGfqgH30SjjEInBh5IJLqIHp+CM+yJbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7543
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> The mbm_cfg_mask field lists the bits that user-space can set when
> configuring an event. This value is output via the last_cmd_status
> file.
> 
> Once the filesystem parts of resctrl are moved to live in /fs/, the
> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> this value is output to user-space, it has to be accessible to the
> filesystem code.
> 
> Move it to struct rdt_resource.

Change looks good. Please do note that there is work in progress to
consolidate the monitoring related data within a new struct that will
impact this change:
https://lore.kernel.org/lkml/8f73c9ec4c9999c262d9297d46a03209a8affe3f.1716552602.git.babu.moger@amd.com/

Reinette

