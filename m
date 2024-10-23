Return-Path: <linux-kernel+bounces-378970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC299AD7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4745728284B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4AC2003A1;
	Wed, 23 Oct 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXqPC7A7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CD1FF5FD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723473; cv=fail; b=Qel6JYSdr/VEOiFOW0sE3H1d4dQuAemx2BkAF6yzLpJboBJYdE+q4+RqAXFvp/uMOMIf2ng3YlMprmFycmVhHO1kQlTjcx9rp1r6c+GHLn8ZY3lUxxlCWsavAZObTiACKMdgxLHHtjh4htiHdd+lx52HyrJssBuXzCz/2ZGbfm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723473; c=relaxed/simple;
	bh=Sq8A2JmtIp0fPMgeTlh3GKXOm4ccjUILrAMwUzggCXw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lrd6XIqiB+GQ3CiK4DoGB2PRS3IiU5EHw/U1ZEzwlMIX3qlt9Nbmv5xXHdj5sc4Ms7ZN0lfA6jHv90QLWSQUG7UuPcHFJhG0njVQEgfHYNp7xy1EW7YQ8YpeZNd6WAz0HCLjzv/PCD4Hglu6C7fHpnV4CyJ0U+hRBCn0oph4mOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXqPC7A7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729723471; x=1761259471;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sq8A2JmtIp0fPMgeTlh3GKXOm4ccjUILrAMwUzggCXw=;
  b=hXqPC7A710rfm6C7szcRYi7oN77ZVoOBDoY1TujnBAjmzwAPinGkHdzt
   iwkyIEJJpQuWKgJ2WVKeOQZvreuFOpiTPpBK6XdSEQtPR54hAt3LJbHMh
   fioS+5Tbnu2B1PbktpstyjvDY/Azq1+Ph/WqmeSLLacHM8cWIgZeOT7tm
   oUH0zZTrZt+KuyF/4e8XnR3UQFt8ZB906Zs79B1r2Jr2kZHalRGbNS29I
   wB6pC3fk8ZWkDlh4T+Vr17dBF9SBg+idLeNAzNWqKg6ZxO314VqRGVuDV
   d7uPlwbdo3dqvMpOw4Izfpe+/A8QZ3MsYi9Mo934zlyZhwuvq9/88aXnc
   Q==;
X-CSE-ConnectionGUID: VNv5nU85Q5O2M8dxmW6IHw==
X-CSE-MsgGUID: 6PLhnso2Q7q8fMtWdj7Cgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46801354"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46801354"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:44:30 -0700
X-CSE-ConnectionGUID: ibj0Jyh7SoWXye1JYZ9f/Q==
X-CSE-MsgGUID: TjJ0IkKqT4W+2DVUYiE1ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="79976134"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 15:44:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 15:44:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 15:44:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 15:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFobOFZOUIjpllumuyj9HULpTVegUfgRq9YWZFzgU7AcOqarD4TbbBNyPw82Se3KUz/QO9dafQjtrvPC7N5ek3iTkL+nC8Y/b+XOwJPFLFu3nuQasygirvmgw/HRTSRb1avHhO3j117O9Y5dWW84D3cOHfuOguYyFDIH4pHXzFNd9HVdAThSuieUfbhnxF7OJcu91/P453fMSQIAbNtqMOAkjEueIAVe42T1zsWg8874px3jTjpPrMOJKW9yIBXDnPNoiSVyAoqVJ5kkF3q0tmyz+r8uqAAm5sMetP77KHod4pkw8p/Au2t42Fj+SppaVvf960ScIX05ppAs5t7Ghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq8A2JmtIp0fPMgeTlh3GKXOm4ccjUILrAMwUzggCXw=;
 b=B0x4ExxbTm3i8sQOwNDyv7zbmWhnUsT2v/MxzB1/PpRFPBitWDf7MtaVmWFiMLkIgDHPsMMDQzfejsWJYUXbr5dMkRL8bnnyOwotsegF6yeQ7NEDwEkeV4eywW07MbfUIN+4pjR8HgNR8DmcN9KTtVMpEM85plKarlt//Ky3Xzu89Ts6DWPQhzga6QuX8SWx3gUq0JDdadtfYSmzHYHK8zP7LMtoLD6YXu02R2SSJVUBGP/39KwShNYNmwhR6XSHJgV6T9BW2kglOEfMVNYyI2bzmuv3D5659APTw3wDufGNs9xAefiuPjJMI/qPhg8wAwVjVmRomVet1/RtZgTtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 22:44:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:44:26 +0000
Message-ID: <cba3e0e8-6632-4c92-9afc-f3c10c719bd3@intel.com>
Date: Wed, 23 Oct 2024 15:44:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/40] x86/resctrl: Add resctrl_arch_ prefix to pseudo
 lock functions
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
 <20241004180347.19985-24-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20241004180347.19985-24-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: dc70f086-14dd-4479-5a72-08dcf3b43f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWJJY2RpT1M4TkpWYVFXUG9sekpVL1ptU0VOZlVaWDVJTkU2MnRjS3gvVkFr?=
 =?utf-8?B?NWhZTXdHOXl6NjBpZmdtSTBlclFUemJ4cXg4Yy82dmFtRUl1cXZmM1NxamVN?=
 =?utf-8?B?WEpXcUMrRDZOQUNuYnAxdWpKZ2tNcFRSVjlpcndLOVdrRlZ6aWVuUDQxaW52?=
 =?utf-8?B?YzhuUGtHZUtDK3BYYVNJYjhQcUQ4MnRTaGZBV1pZWUszT1J3YjJBYmcweXlI?=
 =?utf-8?B?dHpMb2dUQkg0SXRzajZDTDBDNWNJNWUwZnVrQ2E2bDIyUzcrWGhsUnV2VnlQ?=
 =?utf-8?B?UUVrRXRwY1p5ZU83dklNWFY1NWJHZm95OXo0WllSZy95QTdJTDFjQXZONkRm?=
 =?utf-8?B?RU9yQVA4ZTdXbFFVWmNBaG93NHhObm90VGhOOXpMYmJ5UFphbTNtNEI5Z2ZO?=
 =?utf-8?B?YjdHU1V1VWU0YWNNMzVwZFJJeVdkMWx1S0p1QmFNV1A2ZS9TQlpkRjI4MUE2?=
 =?utf-8?B?dW1BK0NPL0wwTndLdi9EV3BvWER5UHhOb25EWEtCaDFRY3lvWmdpNFFaYUJ0?=
 =?utf-8?B?QVVGUVNPYzBEcDZQMXVtVkhtZU1IaENpZk5RUGV3R3M1SzVmaVFhWCtFUkUz?=
 =?utf-8?B?QUg4U1M5bnhRU21HbmRaMmhjdExabFpxejJKY00rUnh5Vm9yc25qQ21xWVNS?=
 =?utf-8?B?Q3gyODdFVTV2dXdRY0d6c0pJblhia0pqZzk0TGlRcHhRVXBOdUp4aFE3dXVh?=
 =?utf-8?B?ckNlWWhVSnZ2WURmSkZwZGIrNW42ck1IcTdJd1ZpOGpIY3VCZklMYmVVL1BF?=
 =?utf-8?B?Nm9xYjl3SXE1V2NuQytZclNQQTI1QUF5cUVMOUgrVnFFMWRLSVZYU3JZMW4v?=
 =?utf-8?B?Uzd3VWtON3pjdndkaEFHQzRRd1hVZzBMTXBFZXEzSk9Pc1ZQTDJON2g2MEZj?=
 =?utf-8?B?blZGTlN1UTBlamMvT1ZDMVBINmFQb2hLUWkvUjNvVDJ2azVHZmFjUkd5Uk44?=
 =?utf-8?B?UjJSam5WbDZtZHFkQmdmVWFJK3NyWU9aZ3BhNlZXSWxDOHhEN3BvbzBWbGlD?=
 =?utf-8?B?cHdPRlp1NmkzNVc3a29sZ2dkL3NsamFEcWRFaCs0WnVwRDkrSkp3dGp6NkZu?=
 =?utf-8?B?QThlUlJUdHU1bU5JNldwcmNmVU01WHc2TE1oaXZqQ3p0QXErZUtaN1JhVG4x?=
 =?utf-8?B?MEd0eU1rdWx2bU9ySEFnMEpISFBZMTFQS3JLL0JaRytHZHZmVTlJd1dzalpu?=
 =?utf-8?B?RmFBNUJyRWxRYkZ3a2QvNHNHSkxTV1AxbnVsMFNFR0JNdEl5UlFWUytLdTFw?=
 =?utf-8?B?azF0dXR3VkFIT3VXTXZZY3ZZRERRZjhUV1JNUlYyMDRQeHc5bG1mNFBISXc2?=
 =?utf-8?B?STYxWkJXckFRZUozc0VkbjBNRURBYlQzbGQ5NTZDaGR0WGEwR2MwMngyaVlk?=
 =?utf-8?B?ZzAxNkxhZ3BkNFM0eFlKdUhma1RsaGpuK1BKSWtGS2FlR0pnS1Y2VTQzMTJo?=
 =?utf-8?B?NzlEbWEyaWlKaVpmUlc1OXlQb2ZrUktpZlZWV3dMVnI3VGc2ZHNhQUM1L0tO?=
 =?utf-8?B?cXh3U0FwVE1qWDF2WTEvdlo4K3Z2YjV5c3RkSUUyTTBYdzJxUldMeURWL05E?=
 =?utf-8?B?UldmV2xBMWZvV2pvbFZRRjB6WlA4NFhpRDM3d1FYWVE5VUJ5aWtocnZiRFo5?=
 =?utf-8?B?WmNzMWFmcExZRm9uSmVVUTd6ZXhSY09qdVdsbk9tMlppOFJVQzRsZjhQZFQ3?=
 =?utf-8?B?Qnpob3BEVjdLS1NzaXJkQ0QvN1k4K1BkZUM3My80ZS82VnVSbWU4R0Y2SE8y?=
 =?utf-8?Q?BjR3HWsV+bQ6r6A/UUvLRzNbO1+oOWZ0aOmZSjS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG0vL0JVQTM4WDUzS1JmUjczWE1GNHJGZU9KVGVEM2xGUWZQOWxKbWp4SnpM?=
 =?utf-8?B?dlB3TEt0UVBYVjdtWGhUVEMxekl0OEd6YTNnMzN6eE1ZRGdSZkIrbTRSbTBJ?=
 =?utf-8?B?YTFNY1BNR1c4V211T0NGWFNrL3pvVGlpSjdvY3dqL0NNdXU4V3FDUTNVZk5a?=
 =?utf-8?B?TDZQdDhKK3RqcS9QdUZhQ0JJK0dDTXVqYjVXVDgrVlNjS1crT1JFd1l0Y0sy?=
 =?utf-8?B?QWhhTkRPajlZWWQ1czdjOUxsM2ptNkd4QzZSODhEcW13UUNWOGNyWkJBTkJR?=
 =?utf-8?B?aG0xQjJnQW9oZE5mRmJ0d2pMMnZ3ZzVoNCtYQU5scUF3aEd2UWVsdTcyakpa?=
 =?utf-8?B?TENTM09UUGxmcnpablBGaEYzZzZZZ01xOVpxYlZJNVEvbEN5a3V5Y1E0blZk?=
 =?utf-8?B?S1FBb0ZYcm5VUDVYdWY4WXNiNXBDUTNRb09aQ1JmelpMaVBONS9abzR0VUMr?=
 =?utf-8?B?bVJWVWhqVTJNVEZpOWJWM1JWcTRsVjFNazV6WXRqR242UTZwTlVTWmtSOXBT?=
 =?utf-8?B?WE52Szl2U0RaSG9QWEVGZ2dneng0eGJxaStDcHJoY1hHUWxFV0xLQmgzZHVK?=
 =?utf-8?B?NzN6WTZBd3FobjVFamtOeU1oMkFJWUw5c3h4RGc1SkRGOWU0c3FFY0M4bUdI?=
 =?utf-8?B?SzdVTEYrTFpBdTZrclQ5alVOMmt4bmVqaExndHBOS0FkVUt2czVOeEx0cGs2?=
 =?utf-8?B?dXQ5ckdFMnJwWko5RDdYc2hOekdYVXJTTmtRdGFrN1prWER0dnE4N1k4Y1RR?=
 =?utf-8?B?Ti8xMzhhVXg3Y1BxQjgvVklFa3ZmU2psakMvY2dTeDBZbEp4THNSdU1sWEUv?=
 =?utf-8?B?M091cmN4cnpLNDRQeGFrUnltN3krUm9yL0t3SmRLajI1dGFOOEcrOGRaSnR2?=
 =?utf-8?B?RFFGdzI0MWRuS1BibGJEWjdqQ3JaUTRaSC9TTDRpblJhRDl0MGtFTlpEbFho?=
 =?utf-8?B?ZFRVaUdpbTBxSjdDYmo4aHVhTzNtWUdjN0tUQUtENG8wZmdRYTBNOWlqMHMx?=
 =?utf-8?B?T2ViZzlaMWloQVpiY1l5VUtVelpuMXlSRWoxaTBMOVJ1eGVjdUZRcjh4dytL?=
 =?utf-8?B?SE8xR3FOTjhRcmQ1QlM2N2pUSEpiRE5mNjA0S2dyMHA0ZkRKSlBCQ0g4NGtj?=
 =?utf-8?B?YzhQSURrK2gwQ1lkcElYZVMwc0x3dGVHb1NXSXFXcFRmbEFGdy9QRUd1dnZT?=
 =?utf-8?B?L0NHODFEbnlpekJ1aVdFdHhQWmI5RG5rS1RtQXp4TFBNZFVmYVoySFJxVExC?=
 =?utf-8?B?NDZ5ZjdtQk1PYkRDWk9DMWEvb1hybEpqQUhkU3AvV0Z3ZUI1TE9KY0FOVUNX?=
 =?utf-8?B?aVkvaTJtNDRtUk1UcSswWlZvVVZTb1BYdnY2ckZpeVNjV2hwVDJOZWx6NEtt?=
 =?utf-8?B?dmZRaVpKQ3N6MTlkMUVUV1hHUEdvbkoyMXB6cTk4RVVHcGdTMWhMQlRTY0lI?=
 =?utf-8?B?QjVnOXRsaDdFTnBJK25RU2o4Qks0aDhqNU12VVNJOWNSV2E5dU1vUnBYWHZq?=
 =?utf-8?B?LzBJOXpLZlBlUHVMa21tRXp6VTV2WFJHa2k3ZGg4K2FiWmp3M1YyeEdvY1Fx?=
 =?utf-8?B?c0JIYmZ3NHAyejlnbTBmbGxSbVRtM2pyUlRwVTMxL2xqUFpuTjFkODJvVU5R?=
 =?utf-8?B?cjEwbWJXMUZDVng0Ky82SFRaODhaaklYZktzNlFhQXFvNXBYNTZiVk03NXJy?=
 =?utf-8?B?OUN1MUhDOGtrVDF2ZHJoZ01pUTBtN1BVdFN2VERWU00xS1plQUhFRzl1SGFu?=
 =?utf-8?B?dVRHWUdBK2Y2K015TDVldWtUaFZ6T1lKNFllYytxRXNVQlFwREQwaHJOZmMx?=
 =?utf-8?B?dk02dkpJSXRIZm16b1VWU1J1cHJwU1hVd0FGUWdjTnp0VTVmekJVd0ZpMGVX?=
 =?utf-8?B?dTB5NnVzK2RoVjlvRmtCNUFQTUZFOWhjR2hYdk5ocFBZbDlibHZwRDZDNzFH?=
 =?utf-8?B?U2JmbGVWNnR3YjlWTVZTVlg4MzRDSjVLdGpVaHl0aytxRExlVUhXMmVoWE4z?=
 =?utf-8?B?WkZzMHppNE1BTC9tQjB0N3YraUZ6MnVRVkJnNWFIdnB0VVlYNWtYR1pTSjhq?=
 =?utf-8?B?MFI1M29TVjNSQXo5NjF3dTJQRWUyU3RRdlRBcy9OZlg2dStGM1o4NGxYQUVv?=
 =?utf-8?B?aTY0UDFZbWlRcmxrYjMyYUJMU3dqRmhsK1BJVzNuQnMxeEsxY3BzOXhqNFJR?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc70f086-14dd-4479-5a72-08dcf3b43f98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:44:26.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfGkOKrkBeT406dvpAilLxAAi9wfrJNN1x0FxmulFvvUEzsZFjrpyEV3iunIP7zs7nZsX7cw+QXJMf6w3AWMppRoVKv0B9spDOz42ccaqPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> resctrl's pseudo lock has some copy-to-cache and measurement
> functions that are micro-architecture specific. pseudo_lock_fn()
> is not at all portable. Label these 'resctrl_arch_' so they stay
> under /arch/x86.

No mention in changelog why static is also dropped during rename and
functions moved to a header file while no call sites are changed.

Reinette

