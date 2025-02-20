Return-Path: <linux-kernel+bounces-522775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2CDA3CE64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BD0189B080
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFDA5FEE6;
	Thu, 20 Feb 2025 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1wKdWvJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711192AEFE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013425; cv=fail; b=FRQhcYwQOCfEGxU+rCsa16TKcoFfFBa22yovplFmX6qmEQEybZ6hTdN6zX7rozvinptMoE+rcUIgREaJqIehxtRh4sWpgHkYO7671Agm8eQYzz9HKL2F6zkQXOsZeVKSGLc2W8ZinEkDg/RN4drE0BHizd+AO4qU/+T7u4Q/sBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013425; c=relaxed/simple;
	bh=uVq50vMlE1gGe0oI3tiNbFVGbqLb0td8xIDpAYeOBn8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h8wrAFh/mBH4WsqAP5Mw572umAnRhz+KFkGe7kxibqFM87L1c5RipfSCB5zvLSC1ylvMnQOyk97f5uJA/yBvL5DpJ1UzrqH9rtHQJ2mfq3uaTnUfc6Laxgyb8r4Cj0vEE5fTMOQwnYaAyP/14RfYoRWWc7J4vdSUt04yZy2Z/x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1wKdWvJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740013424; x=1771549424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uVq50vMlE1gGe0oI3tiNbFVGbqLb0td8xIDpAYeOBn8=;
  b=E1wKdWvJGQbiXItYSgfwsyPKPWpBuo6oKZv6q3E49Z7gwRahOWvipToA
   ex4vebbEpHHupCkY84perthkYXTNpJcVapd/ezFRRhbBLJeHqSkMb1uZ0
   q+J2n31As/WMIaOL92kBSjaaT3qFLieojzzwQ8eHhtFMUVnY9zYIPnlwg
   M2kMPi4dJp3CqE8A+rjKDQTaqbnhBmXrLmC2sYxzrsxUNxVv4d1rcGH3U
   7afLoEoc9u5XMTP0KgjRCQxJ2GIevtqS+EwPk/5QeI2J1olQ/ww5V8iXN
   1VpnknPn825ABbDvvjFLFcoNLtyXQCZf/NiI/x1KEJHTVVJfkZTYGpKvu
   w==;
X-CSE-ConnectionGUID: 04pvMYvoRp+1N50fcWWGDA==
X-CSE-MsgGUID: eh8PPXLOQuG1GXCrq24wGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40632104"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40632104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:03:43 -0800
X-CSE-ConnectionGUID: VDh7Hs93TnSK2GrUsR8rUw==
X-CSE-MsgGUID: mMjVuRa+Qv6FRlkmMTfVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118984779"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:03:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:03:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:03:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:03:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR9o7BREefHb0X/jHtmCS7k+frYvJCCXU1XyJ01dhwH/9n2a/QkVA7Uv30bcZ00ZKQJ7wX66otqUSp/exOxNJ7oGonpkL+kE3qrRS+GfgSL5EMEFpw5KY+O3naG1IB9snSPsuLuArXw1HD08m1ZLA1Nbxg09V+uFD/X+XqW8Ghsmr/2dverp1RsreZ2GAMSZvkBaNpi7VzLCOiWOwE73Xe+udOXYseO5kXvPzsk5+Nsvy89znABmEZF30vMX0kqfMXTMoaf7jtIZMnjc1vHk/oJMCPmi1nicUqExHeydw/9zhEqg5Ds7joVkw91NAB5IzNj7a6x12genOtS24xV45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cywSgtFv8+wrC98wSNGhVdydHDGO898a5r0zBL6fDLk=;
 b=vM0ALv/mS3BdEjkbUKWbZ92hiKbW7Wd5JAzgLuCNjYUe6S7SdVdBgaToa7xS8aBpi+4lalUeA+8L6Y8/8ONm2BNEClW3++AxeDAIvOawj6ljez/PCwzCkH35GokgTfCp5d1oSHYDM7Fj0XZz8vT0EBBpuDyvYAzRET8dE40nmyAXquOMES3Lw6ePlTbvn7VVQJPeVz5Ac/QR6ySZF2dvktufjSUSx9yF2ybyoXRG+nDNRODEY9KMb0n4j6WO2g2R2h1gzODwwfM3Uw0fE/u6vz9nXhVgbrEXmNYrNymZ0I0ua9b2i0ub5ScWV9ccqQsdokstrkoj1Ff/b+NgfXOxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:03:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 01:03:36 +0000
Message-ID: <f170bbd9-17dd-4025-8d80-e735c8e55eed@intel.com>
Date: Wed, 19 Feb 2025 17:03:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 26/42] x86/resctrl: Make resctrl_arch_pseudo_lock_fn()
 take a plr
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
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-27-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-27-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:303:8e::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a36ea17-f9a6-47d1-da83-08dd514a6769
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckxIM1Y3dkpaYjBSeURIaThQN2J3UTY3M1BYUTBtZEp3ajVBbDdEelUrbmF1?=
 =?utf-8?B?NDJTZDVjbk1tQzIzdThaaDgxcWxTelF0WkRoaUdoMjkrUVRlaFIyTUNLanVE?=
 =?utf-8?B?VmJEWllOUHdpVENTZTVYaGEzMlg2RlUzYnZQUit5bmpJSGw4QkZHdThvRWpl?=
 =?utf-8?B?V3ZwcUt3STg1UGZXOGhsUmp0V2xHUTkwVFR3WGppM3JIQnN0TUk4cjEybUU2?=
 =?utf-8?B?OGRORHBEZmpxT1gvR2ErWTY2T1Z1d3ZFbzY2V1J3L0YrbDREQmdrcjcycm1x?=
 =?utf-8?B?a3pmRklSTzE1WmJGSm5KS00wM3hSbUdaYXZWcU9ETkZ5RSt4WlZmeFFUd1N4?=
 =?utf-8?B?TlBHaWpCUUk3Wk8zZ20waDJBTWJVeFVWU0JEQW5PSkFxaGlJWC9sbFJvNXVV?=
 =?utf-8?B?YTVQRkRqQmpzczgrSXM2UTVRQW96NVZrcFlyZ3o5YStWYlFxVlBpMDU2WmRz?=
 =?utf-8?B?VG4rc1E1SVk3ZTZiZmNuTkJ3ZkhZRUY2V0x5N3dYU1F0aDJGbnpGNXBNTWlj?=
 =?utf-8?B?a3lENUpPRThUWU9kREZNMks0TkZ0QlllZTV5QzJ5dGJzK3dGNW9iVElyQnY1?=
 =?utf-8?B?ZXVUcWx6ME1FZEVTUzY4QVQ1ZldHQmdFNTdadmQ4YTJCN2d5elZOQzYzZTcr?=
 =?utf-8?B?c1A5a1BsQi9ZR29Ga0xRbVQ0cWM2dmhNNHVuV3I2aGlMOUVweitrWXR6QnVO?=
 =?utf-8?B?SHBWdU9NS2FrdVFQN0RaZ0dMU0U3VERtVmJ3OGp1TThPeTFCS1dEdzZueFox?=
 =?utf-8?B?NjE4OHV3SXlpdlYvRUc2QW1PTWQ1cVZlbHFnQVdlTCs0K01jaDNhbmFkQmhR?=
 =?utf-8?B?OTlUa2xFZEJuODBZSjBZSzIrYnJRalkxY0d5ZFJVSEM4Y1dMV1ZMSjAwR2pR?=
 =?utf-8?B?TEhXV284SUxWMGlZYXYvOW5nZ24xd3dmeGQ2aldla3pCTXU4TXc2MXNFREpa?=
 =?utf-8?B?NzlDSkkzaGl2ZStNMUVHMnZobWt0Mm1PRVNDQ0x5ZFlYN241c2dEZm54bGZy?=
 =?utf-8?B?akZ0VVFQaGJWM2VveHEyYUU2Tm9PTkVSQVJVc3lTQklRWmRkZStCY2xOUkZC?=
 =?utf-8?B?S2REdmlxallaNmk1eHE0aEI0amsvVzI5V1Y5TXh5ZWdidHZxUmlhVW5lb01X?=
 =?utf-8?B?SGhoeXFUeDF0NnRVRHZZOGZ1MW90Sm53dWFLVVRIa0VRbGRLNERBdUxPSVA3?=
 =?utf-8?B?K1VRbzZkeEcreWlPV2hMZDlwM1ZZbzhRZ2x2c2Y3Q1BDaFRSNUhqY0ZBQ1oz?=
 =?utf-8?B?anAzeXBXZDJIMHpZUEoxNTl3bWtZSGRLbDZEM2lnbEJocXJla3hVWlRsaVRo?=
 =?utf-8?B?Ymt3QU13SjgwRzNQVzJNVUVjTndrNDRaSUNwbDBoMVhKZE5JV3prelJZZU1n?=
 =?utf-8?B?cDZ3dVJLeEhERHE1RFFVYzNZWVVYWnFvM1pUT0k5bHpBNEZwS1NNbWN4WUor?=
 =?utf-8?B?MW1pcS9pMXZ4SnNoQm5vRGdMY3BqUUFNL3VFb2R6RHZ0WFBkRkxEVXIyWk1Y?=
 =?utf-8?B?MExVWWxXcFBacmlyZWYyeURwVUwrYjhpTDg5RzMwRzJYV0pvYUlzcFVNLzlu?=
 =?utf-8?B?cHNFaWp5dnJxRDVGUU1TNjdKeG1uUTB5ZmR0YUVqY2JKNEI4T3lmV2NMOVRz?=
 =?utf-8?B?V2wyenlxSGNRNVhqQVFhQkRHeW5iM091d3ZlNFlyVit6cFVnQ0JyQVJZaEdC?=
 =?utf-8?B?WHV1VHR0YmY3WWhYbFByZzBUVm5IeVlxVk1MUVpOaFRvS2dHUmVDeVNtdG9K?=
 =?utf-8?B?WjdUSTRtTGIrbmJqa0JDZXFmZnZ5TDhKQUI5cUZQRFV2MHZaKzhxUk1qUThL?=
 =?utf-8?B?WTNhSlZRb3VLbzlYelVyN0x1NER0aWxjN3ZmWVV4dmh2dHM3THRrUXNRMlZX?=
 =?utf-8?Q?9LOSvnspzi4Tx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxNWjdaNCtHb2JTb1czZVFmZjRJZ1lZUUNSUm9ZN0htYmlIWDc1L3k3M1BC?=
 =?utf-8?B?eWp0WTdRNWxqWitmdUZEZjJGalQ4RzdERktMVUJzOTYrc3lRL0p4R21qYVEz?=
 =?utf-8?B?aHY0VFl0ZjFTVHZZcDZ5c2l3Y1ZqSEZDd2hoRzhReUdDUTRmNEhud2RXL3di?=
 =?utf-8?B?QWx6eG5CdVpvUXM2bUlkTGZkVWNwMDVXTnVFOFdZaEtxbVlTazljSEd3YjV3?=
 =?utf-8?B?T0xNdXc4N3ZFU1dYN212Z250SHE5TkFIeHFML0xWSE9mdkJXQ2ZpajRpN05J?=
 =?utf-8?B?bnVvcFNjNkpUSHU0ZjBWUHpvOG9pdWpnem1IY0NzcW9rbUdHZTMxUHVXbVUx?=
 =?utf-8?B?cFdEVmdGQUE2Y1UxWmhRMFFWa3hpSVQvNmNsNUthQzh5aUc5azc3Q2xsNkVj?=
 =?utf-8?B?enNUaC9JQ1RmWmRUd1IzK0piZ3NTai9Ic25nQTVZY1NxL1lYK2huQWx6dURO?=
 =?utf-8?B?Y2IxTHhBODhBYzFvd1BxT1Y3cU5xYkdmUnVBUFpxK0pLaitiMnQrYzdxczBT?=
 =?utf-8?B?SVFKUXdMelFQS2xsdjl2WnJCMzRHOHoxWXBGcUVVbk1hUXQvRlpDdERtbU90?=
 =?utf-8?B?L3NrZFI3RE9mQkRWaG1qZGxkMENNaUg1Y2Zic1BWaDFNdk9CM2tENFd1MWVS?=
 =?utf-8?B?VU44QVFXeEI5bDcveWMxeTV2eWRXN2txbHpTL2RzWTJWZEFOOHRjWFN2Mnc4?=
 =?utf-8?B?QTRGbGlRMGVNdUsxOXpndThuWGdrS3BWTlFIcStOYk91c2RZVVlXT216bEpN?=
 =?utf-8?B?ME9yeEJMNEM2S2YvRHliclVybGxJMXJzZCt3Vno1eFE0M0hjTlJvUjd1UUdq?=
 =?utf-8?B?bjZVT0JocTFuS1p6TWpzYU5NYzBxS01EYnFxNjl0S0J3cnU4SXFKTmRldEtn?=
 =?utf-8?B?UkM5K2pRUmRSWUVKUys2azE0RnVwOVRMeGRsVGw5aWJjbXM1aXdCVHVpUlU0?=
 =?utf-8?B?SEpHOEVXdGF0Nk9xelBhbEticzhaY1FMTW9RS0tvS3VFRmVoWlFnSGtWbGI1?=
 =?utf-8?B?MFREa1NRUkFPZlRoUWp2K1pTUHZIYk9BOHVvZ2Znc0ZjN3BUalMzOVBPT0Rm?=
 =?utf-8?B?Y050b0trYk1ta2p1dTdIUTdlSi91T29ZUjRWMjVWbWpva1N4cTVpYzNQVGtE?=
 =?utf-8?B?ZG5BU0hBUHY0YkdIVUhrK3laNGtLUDhSY2Q5TFpZdzVBbmtEMDAzK0RxV0Zi?=
 =?utf-8?B?VDBrWWs3V21HS3IyQ3pZcTJ1YUw0d25STDIxRlVOdC8wbHFjQkE1bUJ1aTBt?=
 =?utf-8?B?YmlzUGx4Wmd3aHRSbjVneDVRaFZzTGlDcmluUzVkM2ljVXJUcFpyVnp0azdN?=
 =?utf-8?B?bHlyekNSY3hWcjRIMWErOXpuLzdaWFlRVFFoMzJzSFZhK21ZMlBuZU1CVm9O?=
 =?utf-8?B?aXhxdnFaZmVacWJXY2ZTMHhRYlNjd0lWRFNMMWtHeXJab05rTWtad2Job0NV?=
 =?utf-8?B?cG5JeUxhcEVGRy9yc2M3bDMwbVQ3QnRLcmJ6bDBZL1RaaUJtZGlVS1JFZXNz?=
 =?utf-8?B?K3ZSVkp0K2RyUXRqOVZvMlpUbmVPN2NTUHEycGhtR1dtcmE1LzJLSXg2aU12?=
 =?utf-8?B?cGF1Y0tNRmR6VGI1QmRTNmhUSER3WjBza0NTdFdwb20rbnJESlA2enY4M1Ru?=
 =?utf-8?B?TnVxcnBvVEFXZVVXRWFaZGl3cFdwaEdwZ3VDQ0RrdWZMZE95OEdjcnBpblI3?=
 =?utf-8?B?cTdqV0tqTXUyQnRMNXd4VmJqSEdIckxhc0xNWWNySEVoK214Um5UYnU4QWY0?=
 =?utf-8?B?YzVmS0J3ZkNHVS90SWkzL0R0dDN2b1RCY3RpdkFmVm1CREw0ZjZOQ1BVOVY0?=
 =?utf-8?B?YzR5QWN5ekhZMVFsN0JndVlHY2R1VTNQUWNaeHV3a2tudnp6SVE5TTdhWGl3?=
 =?utf-8?B?UFhNdGUwN3huNk5hVHpyVVRGOGRIalF6RHlpMGFZT0R4NkZoN0p3c0ZXcXFB?=
 =?utf-8?B?YjdHRHFOa3ZIRE53SlUzUGE4Y2Fud2dxT1BvSTNKRmdZR3BIdW51eUJGczRZ?=
 =?utf-8?B?OFZ0Q0VEOW9SSXRMRVBhQ00ySkpkSGl3M0tJVnNxUGNNOWZ2VVlvRHU1NFlH?=
 =?utf-8?B?dk1PZEJLQXhPOU5rZnJRTjRLNmNQUUNYWmZRV0kyTUtza1hTTGkzSVhhelQv?=
 =?utf-8?B?ajVoeUJ2YkZNK2xBQnRnN3QvUDB1dGVXTFBIRlhGZkZRQnd6SDMxMURmYTlX?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a36ea17-f9a6-47d1-da83-08dd514a6769
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:03:36.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bThDlgKVgxQpDO1+wr8eElOKYJPodOn6sk/xEPBxnU8E0QHUc+6yLMS/MT7eG5C/Q4HbU1nw+CLKxm/kgHCI4HeI+qtEc3w7T7foNz/KIEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7828
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
> and takes a struct rdtgroup as an argument.
> 
> After the filesystem code moves to /fs/, the definition of struct
> rdtgroup will not be available to the architecture code.
> 
> The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
> for the CLOSID. Embed that in the pseudo_lock_region as a closid,
> and move the definition of struct pseudo_lock_region to resctrl.h.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

