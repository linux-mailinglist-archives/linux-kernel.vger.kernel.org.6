Return-Path: <linux-kernel+bounces-379033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED96C9AD8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FA81C20AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A81FF7CA;
	Wed, 23 Oct 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7jlT74S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D211FF047
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727785; cv=fail; b=AW8bzqCrL9GLTs+Y4m4L9NMbr4Noc6g93Fo3Mrkqkv89xKjMIkWs+bG6fVgfHwilRdV5rBZKgemR5LcPFCRT4o7+nAop+NLBFrANXPgXooFBfnWMbQ6359PY/I8mFSUTfJb0ZVv1dPOPJtb6rifOA+Y7NQT1ahpuViyIwxV9l+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727785; c=relaxed/simple;
	bh=n4DoF8aygHYnnj9QoAY05Y/nvOmlXld02bCGTUPj0sU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TBu8M76OJWC37ltkfxXIhM/b99O2Fc5hFD1PbNsAQWJCrwAj0Jp85Y+GVHljH8TEVE986XYWJrXos83fmBIRNpU7RutDKpEdqEMoDlx8korKDBDXwpDBmTjnezizbdbLC52sqzD+ROE6G2t1iBsMXrwWPdT4g+4SWW2atYpqlY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7jlT74S; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729727782; x=1761263782;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n4DoF8aygHYnnj9QoAY05Y/nvOmlXld02bCGTUPj0sU=;
  b=c7jlT74SmdFUY7wtdmJikgkTkSnCiaFDCf5H2FegyQ1TLzkATQuPtaXf
   ENLbBvhu7JOZOxsKk8G0Fddmjxh86eVqVnhmmryNz/m0vnxYbUTVlBi/W
   inijntLGjrtIgUsd3jSpmUqWwAoSqi3bWc2r8ZKX4UdH7DQj5I7RDMf+e
   fgdgADIj9kSkwMpPcy5c6Eu4sJ9ur7f92G61nV8VpHDj/kMz88pPHOBOi
   k9GWpTiHgKEFH/aQAAvrP8gDTkOvkbTmipwx5f8s1G0L3SWNhwEzToV/j
   j9Gk5GKizlUUjdibBP3wM7ITAgc7KxigOO2igc8lbY/mZwvb4rDZVeNEh
   g==;
X-CSE-ConnectionGUID: NZvQTPWxR8estAVZ2bu9Jw==
X-CSE-MsgGUID: FRdjxFLqRMSviXg4mENifw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40453306"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40453306"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:56:21 -0700
X-CSE-ConnectionGUID: ScLPkeZaSmOMnmf9y6Nxnw==
X-CSE-MsgGUID: w14JrflOTNSHan7+fUBj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80595484"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 16:56:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 16:56:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 16:56:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 16:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1hxcb9UVWpKnVkCuUkqJhG9ySHmsPEyOT8BtK9KMnm1+EoPh8ImWIGpbYg8YRcE6NFkP9KBa3jjss8Epeqp/kj+zVaV4w2FlYLy+T2Nl/nTN1obSJuym+FdjoDQPkripx4Zwf0KLQcgwDyIgfla+/9b55xLPk3wbiXkRuOO2W39rOAmA4+lHFsWLvf5D0UC1aiBx5cE8+sKR+Q5IcE0y3WEgikXO6NCRCspS3UsDXyVVTEdG5XiNQfyhGt6LIxTG/JAa5A+gvi0gL7MaakTtmKJOQlSUNHMI7kgcHze8kUpoBoThoqMpoqPLARNlCZZOsxJAqyQV8sploFbuDv0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6PVAMlUSwrCFkpzHl0ZMoazah2vq+OZKhBHXVaqfwY=;
 b=idrcSbpqOGuBop6hGO0w9bB/mQV2aDWnkL1oiL9BMkpkxbcyPlxtNM9sg/yhRj2EPY/gvY6F4QS9j3knFx1PWRBN+2Omdf1LCIvHZfB02r3ncmsbcH24Afx3gmnZ91N+3iMyGpjyJTRuLuuDOBVXDmE1Su9zbLk2ZFMOeIyk7mTvkb2nLHdL7cMO2jUqLJB0etWrWhUMqqvH9uthxHuuQpHG5d2mRlC5V6YM0FjNK4Rz8fZ5GMUxmqx/lG3p/mYtL/m5ozCakqL/PILY4LbiLpXfPnV4XM5jUOWpk4GzaKtHNHX95pzpI0LSqMRDTTd6aVNnnvoOIvlZkLGXz8iQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 23:56:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 23:56:12 +0000
Message-ID: <2897562e-fc97-4cc4-b4ad-316e84c87c9d@intel.com>
Date: Wed, 23 Oct 2024 16:56:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 33/40] x86/resctrl: Drop __init/__exit on assorted
 symbols
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
 <20241004180347.19985-34-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-34-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: e77f30c8-60c4-4109-b95c-08dcf3be45d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU9IdHlRV2ZxdVNDMmd3QUV1blBHRHBKZ0h5NHlHd0c0MC9zUHF4eTFzSVQ5?=
 =?utf-8?B?L1FVYzE4bm1oVzFFOHdwN3F1eHYyMCsrWVNGNG1ZZUttMFo4c0huNEcwbFZz?=
 =?utf-8?B?UGxFMGpmbzBXODRsSmZpaUhvUk5FenlpOE9aMTNnZWQ4NU1Vb2hVZ0FXKzN0?=
 =?utf-8?B?YVZyUzcwcFdkY0RhR2FjR0tHWEN6Q2dRc3F5QzMyWk5MdVdOamphb29GU1J4?=
 =?utf-8?B?Sy83c1NQUGJiRkEwSWpZL1dnemJLZEpLbUd6Q0l3OWlqQkFKTFM2aWFUbm51?=
 =?utf-8?B?UkNBZ0tCQmE5VjYreENTcXZ6TzNBY3picnVxZFhPMXJ2ampPWVZvaVhTWWZU?=
 =?utf-8?B?VEJjRzRFNFE5NTkwbWZpSHN3VTZpSFFrSWdQSVlqOGxRQXVJaFBTVzlQL205?=
 =?utf-8?B?ZFVwT0lsdTBHQTFpSnk3YkNKMUtVb1dPcE9JdW55R0VXb3QwTEcxcHBmbEV5?=
 =?utf-8?B?UVZLV3MyVGF3clV4eXQyUWs4Yks2R0N0UUk2VUlkaU1Vdi9IMVhBbGlzaStV?=
 =?utf-8?B?a3RseHJiK1JVMTM4bnhHdEZGdzNXWjhRS1llRjk5NDhmdjJKRjg4QUxOSFAv?=
 =?utf-8?B?ZTdoYWpaZWpoNko2WjlvUmZSMHpSVmVENFZBdUNxeWY3SDRBbXErbDBhNUpN?=
 =?utf-8?B?cUY1aGhJQkZ3MzRxQkY0dlh6Z3F3Y2lGOTZ3VVdoS2tFTnBrdC94SVZoblhS?=
 =?utf-8?B?cGhEeGxIR0JTTUtVSTFOQUNIajArU2c4SlRqTUlzd1J2ejZPRmJRaDEwd1Np?=
 =?utf-8?B?NElVNy9SUFl6RFRjVUlGNVNFcE9MaXhiSitrODRaQnR1MW83WHRyRFZSdjBK?=
 =?utf-8?B?TFV0ZEhNeFF0OG5UZzhPZ0ZrTkFRY3poczV6bVRkQ3BHb2hKM21xUzRkTVZY?=
 =?utf-8?B?Q0ZrSDZwNXhMNXlqcW01YnMvWm50ejNzdUlwUVNLRWJDcHVhZXNkMU1leHdu?=
 =?utf-8?B?WEludzlSZ3lxN2pCdHBhd09HbURKY0d6b1JNZDV1d0FwajFnaHJaZ0RjYm50?=
 =?utf-8?B?Zyt4Q09UMzhRRlIrRnN2V3hZcXhWdncyTzNPRE5qc1lhRkZiTkhVT3F5L3Vm?=
 =?utf-8?B?L1Y4MFRZdVVDSVNrWFlhaU5uQWJIN0RSM0tnL00xK3pBdGw1a0VnL1BKV2Vt?=
 =?utf-8?B?VmFoL2ZpQzdoNENMdWNYOS92WFhKRTBzeitMTGE3OHJ1aVNQMUFpVVVxUjJi?=
 =?utf-8?B?dHBhanVGTk51T1YxOW1pbzhYQXRpL3h1WmtWUEZYVDVXYTZRTDF1Mk8rRFVL?=
 =?utf-8?B?RDlnc2tVcStGTi9JRnJQVm1rcEZ0elJzbU4vdzQ0aml6ZXBBdjk5R3N1KzJY?=
 =?utf-8?B?Z2Q4bExIb21rMzQrdmxFUFg0UGN4Ymk3bVU3T29RVW04L3AzeklJVHN5M1Fy?=
 =?utf-8?B?U3BuU0thc09uUjhmemhtVFd0eW5URHB4N3hrTlFyVEpOUEhlclF3YVcxeS94?=
 =?utf-8?B?cTJkMVRPZW5YM09XV3RRcFcwUmg3Tm5yUFB2WUZ1OHpndGZRR1IzTXRLV1RR?=
 =?utf-8?B?NGxqM1liVUszMnd3anVIWWNuNEE2OWNyMC8zMTZaTThiUzJkWUZLZndoaDhs?=
 =?utf-8?B?L1hveFZIckFkWmwzbVl4TmpmNldRc3JJcW15RlVzeC8vRnpsaHEzeVdoNXBK?=
 =?utf-8?B?K1BHQ1luM1gwMXFxeEJSd3BLck1iTkYzRWJ4K0t4OC8yUm12cEVxL0FUdUVE?=
 =?utf-8?B?bXRPMXozMEYwRzlXRG5hcDZONXBDM0N4Qm9nTlVLRnZkM052YUNyMGdTRDgz?=
 =?utf-8?Q?76EObIOYDt2RVLTJhIZe/8G821J2NDTmZb2X4S+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzFwZEppNmhvZEZwR0swTXV6eXdnd3BRR3Q0M0xUNGp1cC8yMDkyOWhqNWxS?=
 =?utf-8?B?U2RVWklCRFJZVnNLYlZlOC9ETHVpUVgvMFdxS29NODlZYnBUZXdBUUxNUU0z?=
 =?utf-8?B?cEcwNVlKZnB2OUpSTUR0YTdGT3FYWTdTYWpUNzVBNm84S1ZNZGR6L3FWQlkw?=
 =?utf-8?B?SUY3cTUyN1ZqT1c4VnJvUHk5a3JuZit4TjE5WDVFR01BTUY3S2x3SWRyK1BE?=
 =?utf-8?B?eWFzQnZlTU5kakhGK05BWjdkbWhmbEl4OC9yOG5TQ2xsL3dEKzBRdEUrRjFL?=
 =?utf-8?B?aTkrZkMwcFpwKzVzdG1JbGNNWS9OOGJQOVYxZUJ6VjJZdFJ1OWdoSVA2b1BY?=
 =?utf-8?B?MEFIclJBazhTYXhRbkI1amtlYWhFVUcwWUlqemhscEROVCtRRmtGanBIM1pk?=
 =?utf-8?B?LzFTR1RjbEhOSFRwTFV5Y25ZbWlTTHdqSmN2WHJKaTFCeFdEK1UvR2FMQmZL?=
 =?utf-8?B?eFVlalBjdTVhWmZPelVtVHh6YlA0V1FHVWcvYlFQOHNmUm9WUE1HRXptcTVO?=
 =?utf-8?B?eVlXVDV6cmJIOEU1UmZZRlUwOGtQWjdXVmFZaGhHZjZvU1JmR2hBdFBKOFRz?=
 =?utf-8?B?M0RGQ09aakQzOWp2Mlh4ZWdxdUx3YlNRZytiY2gydzc5QTFyZUMxaStZeURh?=
 =?utf-8?B?UnNSbnlPNDQ1Vzhma3Q2WEpEVmp1NGsyeXBhbjg2d1hOQTFZdVVmL01PWHJp?=
 =?utf-8?B?NFVaNHp1UGxYTTJvSXZJRytqeVZDNFZ0M01vQnc1VndqcnhVRkhEK2hRdUdt?=
 =?utf-8?B?ZmpRUGRES3NOV3hBMmZDSGd6L2VYSXNWZEtYWUdxNUt0YjdKUFp5RkY1M3lU?=
 =?utf-8?B?MGRYUDRDenhzcHk0VXMxRTBBUXk0NXZtbmdwNWtJcTlleXFTdHlvc09Bd3pj?=
 =?utf-8?B?dkpLVjVjZXhZeDdGNEd5dzN3eE1nUStKZ1VGd2UySjZrczg4UkpmaHVJRVZh?=
 =?utf-8?B?amJWRGQ2Wm5NTFpxN0Noc1FiYWl3WFZ1blV0WWE0eUxjLzZYdFl6djlIOEl6?=
 =?utf-8?B?N05jSTh1cmk2QWg4YVNNZy9WSjFkbTNzOVVPOTByMWwyYzVnMG8yMkVOK09P?=
 =?utf-8?B?QUoraHZzblpyTXcwU0g5YmZnWFExQ1JTc2s0Q08xdU96b1RUWjl4SDAvUHdG?=
 =?utf-8?B?aThTZzY3cmJTbk9vOWY4WG9Bc3B0ejJFbTlIVjdieEw3UVp5dCtmSXlDM2pn?=
 =?utf-8?B?eUVXRGp0a20rdStmQ2J1V2s3Wmd6dGFaWHd3ZkNJSVhvVEVxVWR3K1VXbVpi?=
 =?utf-8?B?OUhrS3VqN2FNa1kzTk1zeEVnWnpVQzVhZDNuZ00rTk8wcUhFNFU4VXVxSjV4?=
 =?utf-8?B?VmZSRDNoMnkrMFVodkM1ZllDenFqRlpvelJjQkI2NVlGbUZzZjRHVXRWNGJT?=
 =?utf-8?B?U3FUamtyOXNJYnJRS1NVaHUzdnZ6amdaYUY3dkVLUjNVOURpOFhvZ2RubGxB?=
 =?utf-8?B?eFhqNTdoM3FidjNSRUJLRm1Ga01ScENmcGYrY1htNjd2bnFrVVNKcEUyNjNL?=
 =?utf-8?B?VUwwalo1bldvZm5Ib01RUHYrN09zaW1XQTVmRmUraUpOL3o2WG01Qjl1Wmdk?=
 =?utf-8?B?SFFSc0VtNlY2NDdjR2puK21hcEI0UFBJUGdOb0h6OFRFZHI0R1dIVkxHaVln?=
 =?utf-8?B?MlZYV0Z1dTBTTHUycFRZMWZGS3I5UU1QUEIwUk0xZnU4dWp3ZWRVRWZwUENk?=
 =?utf-8?B?Q01PVXlPREJOdVM1aE16MnVlZ2F5Y0pvQ0JkOGx1OENCQkthZFZndzJQT1ln?=
 =?utf-8?B?RmxyY3hVSkRPbU50dFdXaVVnU3oxbG9zQ3NyUXhRb2gwVmliUXBVcE1CV3p2?=
 =?utf-8?B?Y0F1dTdiVDUxZU05VXNFL2dhOUprTmEvejZMVk5kZDhuNEJVclY4WUFRZmNO?=
 =?utf-8?B?eGRtUFlWMWtHNHphL2RoYXN0OVd2ZmRMaVFRNHRvc0NVYTYvWStoV25rWW1C?=
 =?utf-8?B?aHdTZ3o1TzZETmNIWFc5MFFrQ3VqNzFXYzFQODRtbVZWaklTZXZkOWhZYkV5?=
 =?utf-8?B?eWh6Z3Q0d2Npc2l5TUFsWlVxSFkyUGR4MXFNOEY0R2dRNU9HY1lsZHNWVzhz?=
 =?utf-8?B?YkNhM1M2bjBERXJkS0pyNFQ5dE5uM0ZXR0pjN3VQQ3diNmt3SWE2S0paQkRw?=
 =?utf-8?B?SjhrYUI0N0xlR2lodlphV2dsbENBTTRob3dsTjNOaklVcVVLV21WbnZuWis0?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e77f30c8-60c4-4109-b95c-08dcf3be45d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 23:56:12.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM5bW6d+tzDm6zGfjpZ4QOWQ6OOMek0dGX6yplm2D1ww9+Hv023opK26oY4n/w/dnobSxYokJWY4Jzb4nwEUqKqtJvJwN9NSiLUmwNQcc/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> Because ARM's MPAM controls are probed using MMIO, resctrl can't be
> initialised until enough CPUs are online to have determined the
> system-wide supported num_closid. Arm64 also supports 'late onlined
> secondaries', where only a subset of CPUs are online during boot.
> 
> These two combine to mean the MPAM driver may not be able to initialise
> resctrl until user-space has brought 'enough' CPUs online.
> 
> To allow MPAM to initialise resctrl after __init text has been free'd,
> remove all the __init markings from resctrl.
> 
> The existing __exit markings cause these functions to be removed by the
> linker as it has never been possible to build resctrl as a module. MPAM
> has an error interrupt which causes the driver to reset and disable
> itself. Remove the __exit markings to allow the MPAM driver to tear down
> resctrl when an error occurs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v4:
>  * Earlier __init marker removal migrated here.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 +++---
>  arch/x86/kernel/cpu/resctrl/internal.h |  6 +++---
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
>  include/linux/resctrl.h                |  6 +++---
>  5 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index f484726a2588..f713ac628444 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -775,7 +775,7 @@ struct rdt_options {
>  	bool	force_off, force_on;
>  };
>  
> -static struct rdt_options rdt_options[]  __initdata = {
> +static struct rdt_options rdt_options[]  __ro_after_init = {
>  	RDT_OPT(RDT_FLAG_CMT,	    "cmt",	X86_FEATURE_CQM_OCCUP_LLC),
>  	RDT_OPT(RDT_FLAG_MBM_TOTAL, "mbmtotal", X86_FEATURE_CQM_MBM_TOTAL),
>  	RDT_OPT(RDT_FLAG_MBM_LOCAL, "mbmlocal", X86_FEATURE_CQM_MBM_LOCAL),
> @@ -815,7 +815,7 @@ static int __init set_rdt_options(char *str)
>  }
>  __setup("rdt", set_rdt_options);
>  
> -bool __init rdt_cpu_has(int flag)
> +bool rdt_cpu_has(int flag)

I assume this can be dropped when resctrl_arch_is_evt_configurable() uses
a helper instead?


Reinette

