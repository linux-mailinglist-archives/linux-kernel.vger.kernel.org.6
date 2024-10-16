Return-Path: <linux-kernel+bounces-367168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94999FF56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537A7B213C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0834175D56;
	Wed, 16 Oct 2024 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUb4EfPO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0FC2FB;
	Wed, 16 Oct 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048917; cv=fail; b=XqqJkX+i5UG61Qrm+mdUSvAg28Q+eTyvZlvqbf/9BFaMQiBrnAR2CDL1nOWVMLHuNUGpfo7jh5soP93DxmBbXFqhB7Pf63FYv9VKn+zn9BTmrEBo7Xc72u9rCakMAdzlNXCVz0UMMwL7UZn+iIDI7jFzDyfE0+s95JyewOVjJqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048917; c=relaxed/simple;
	bh=ewxWf9Q+pbx+UTU4N/BaB/RS214ndDBryJ8WKzChYsg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ge/omroHq53w6i6vDLAi/zD3YrynN+JPb3eyz72Djq8JqzjvsDFUcgwCkTy+PrmkKJ20Jd9UPGAJ7EcVRfkuonuXg9loWCkacsjI5baQy3haS1CYc6cI11kjokNKveRFnR0HKklNv6VZ0zrNKsR2bByN7RuuVZqi78BZoJCP/A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUb4EfPO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048915; x=1760584915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ewxWf9Q+pbx+UTU4N/BaB/RS214ndDBryJ8WKzChYsg=;
  b=iUb4EfPOz6jDxU0SsPYrYvxyHn/OeDe5akfOamkOS6JG/T2BO26jEpRz
   X3CRxizXv3rxu4hq72gFbwcvawQY3N2M3ReAlySvTFZHBxjQCWYng6I8D
   0hGZcWBe4kj5lSoxg2D5KRyfjAWDL0EbAH9viz2nBkYi+ad+I7wnftZYu
   zOrRdLgMx1jN7qfcA9xVG07T06A4jXyozPUO25iUGhAZXDCQzPP0dkT5B
   VyZt2mXVTF+1ngDKRcwK4JSHckaAXakHPCsASjdSJ7+b28JGWZ61Mbb9X
   59yaFc9wu2Q/xsM6VdPqWy/YRFD1qQ4l4hUZoU5nZ0Hunwss6YjQPEKOe
   A==;
X-CSE-ConnectionGUID: OUQ7wbZ1QmqgYk+aoTtw3g==
X-CSE-MsgGUID: 0dqCMs+/RgC/y/OzSuGDsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39850395"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39850395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:21:54 -0700
X-CSE-ConnectionGUID: XegSwtA0SfeJXxUohU1gww==
X-CSE-MsgGUID: u1lRU0aATmKEPinuvdtlxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78553686"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:21:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:21:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:21:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0jLpuSVaAMRAGN03tsN34V1gE8Hw3Qnf294c8Zfe6IEAExhQyolzzq89jo4bDfzrlYCdjgStrulfcQ3PsBjhCtvDxxfVFF+gSYLyhUqM/ljQMi0MBMwkrr9SR6546GcBUvnYSfEpc54p4q+JvFRXkxkpqVjp0JNu/G3sLzgVKiQQHCVP1UVgFp/7tZNHXzxba8Nmi8YXlVrajDD+SUXAfuRGYePCsk5ftcDhu3Igeki7wTVJY51TaibrotW3ZJamBFFsfnibmm45X+EVNtE8xfU2hjRDcdga+tFTGwOb9KsefI94MKCPNAkjCUH1u5B8youLLqYcnzWgageatwqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0UQN44B7xzyjFHU/hptbNCuI5kiSNfhIbzVg7RDTN0=;
 b=lwrwdMYM7CNd3ch5yZgoL58+DRjQfSH30RQgvRtHkmS7XUc/W160IDDbAYTGaj9DhelIo7TwCboRqs54Ktf6sRLs7mRHjeBP/7ZbojJRSMpN+i03piY0d2X3/1fyaBvbyJJ2KHTMLvrCZl6A+Ax9jNr5KD+8/omldnZtL28IwuFbO9sYj2TkDKXhRM7VLXywvHf+bmqG/GWHxBtaPtgMqdEtjX9dwr5nzN12BSR37DOncwF0bU4PimDXjkcGM12LUbR0dbAHtxtbw9Tx2RtpcUOuA68lio3qvseMRl/ZyD10X7ZYLLTiVVjFnQaKP6k+O007xw7eXMnXnRH2fcV5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:21:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:21:49 +0000
Message-ID: <6af4b2f8-c6f4-4195-8c5e-d2efe0384521@intel.com>
Date: Tue, 15 Oct 2024 20:21:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/25] x86/resctrl: Add data structures and definitions
 for ABMC assignment
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <94cfd19bf9b16570b07649e1058b4ee55ac8c102.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <94cfd19bf9b16570b07649e1058b4ee55ac8c102.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f5e7f1-a73a-4010-8926-08dced91ac5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dS92VmtxS3lRMVRTcVo0WG1wS091eExyZzZCUDVOL3VOMXBTMTFPV0pwaXBC?=
 =?utf-8?B?eEp4UjR5YXpjTnhHSVNlM2dEUHhqN1JyTGxSRFRyWEQ2dnc0ajF3WDlOOGt1?=
 =?utf-8?B?NUtuekM5VHhwK2lDNG8zSjdkdGNTVExmTmxNRGQ1VmkySVRMbnFPQ3JCcmxw?=
 =?utf-8?B?c1p3Z3FNUnhDK0xEdTVyMzlEa2ZSQSs0VDZHdHhqUCtmMEZPdTdiUEt3b2Vi?=
 =?utf-8?B?aWtTMFRZUG1pL3NLa3pQZy9SWGQ4WFZadmljRExncHExYmJPcXBHdEE1QzFm?=
 =?utf-8?B?eERZZy9QdTVHQWttQTBDUzAyK0YxTG0zRWl6UjVrRDJTTG44QXVXMnV6TS9T?=
 =?utf-8?B?akJHRjJDTlRPYVN3SmVSMm9sS1pFRjJSenVraFkzQklyTWFWSm5yUU1XRml5?=
 =?utf-8?B?dHl4S2loSGhFTlpZMm5VQUlhZ2k4MUtRamZseGZCdWQxZHRDTjhUd1JMajh0?=
 =?utf-8?B?eGhJZER1VndLOUIwMTJtS0x3QkpZVzBYYlVUZTFTSW1iNllZUWxHTi9weTh2?=
 =?utf-8?B?U1ZsQU5uQ0x4VVBSWDBGQ05nd1RQMjdFMmoraVZPbktVRlFHTDdOMktRdXdt?=
 =?utf-8?B?bFlVU3BONHdwbEZnRy95akFQQjJ1NWFDMVl3YUplQjJONUswWTJweUJ0azRD?=
 =?utf-8?B?ckZNbkZobXhlS0hTOW42K2VZaVdSdFU5Ulh6Rm5iUjhHN21QWDFPRVNYbGM5?=
 =?utf-8?B?RXI0Q2VlTEp5V2ltWFJPZStGOUt4MCtFcnNBRVdhUk5GVThNaktiSmJxSElN?=
 =?utf-8?B?elZLd1FIRW5ZcndnOHhtRU5rNW5mMG9WSHFUVG96NnVyVzNFNURab1FYT1ph?=
 =?utf-8?B?UVlmU0tCL2NzOS8rZ2pCbEluVlVVazNxQXRxbU9vRElnK3haTEZIeGh3VXBQ?=
 =?utf-8?B?bjB2VHBZRjlYSU1TclIyNU13cTM2Y1phOXh4elFTT21SL3JrVjhoem1hWmZD?=
 =?utf-8?B?MGVaSjFld1dQL2tYeDczOHVUV0JtNnY4aTdDR0FoQmZGanptUk90T1VONk52?=
 =?utf-8?B?MStNSW1lQlk3WDBkRWd4bFMrSFoxTEhERFBQNTJFVjFhNW8wa1I5eTBmRFVj?=
 =?utf-8?B?QlFocUN3VEo2YTErTDlGb3BkWUFpTmFVblYzd0lveXF3T3M4b245ZW5FcjNj?=
 =?utf-8?B?b3NHalJML2RhcmhrUWo1VDl1VEpHRXZjRTl2TUM5dVJWaVFrZG5EUHBZMG8y?=
 =?utf-8?B?VDBxeTBkaTlmTC8yUWMrd2NFRms3cStpODFwazE0cVBXS2NxMWs0QTRpdnd2?=
 =?utf-8?B?QktLTU9OR2UwM01KY2dPMU1YREROcnBzWFNoeUpJaFpXOWlJRjhqam44MHdk?=
 =?utf-8?B?MFB1L3lrN3FvOTBJNUNhQzBCY2RsSTQzMTRSR3o0RjF6VnlXdkFySWVKSnVU?=
 =?utf-8?B?TzdmRWVXRXc0dklTNWt5VG4xS0JmSFd6SU5WZGtRcjlqNGJqYnVzOTJaUVQ2?=
 =?utf-8?B?Rk5oYVpaVE05VWJRK2RVNzRuTlpiYkZvaiswRnV4WVFOeUQwWkV5aU9DWjJm?=
 =?utf-8?B?WkNiMGhEb1JGMXJLUmlXeWV4YlQ4K3pKZ1luYWcwaGF0Q2plRFBVb3EwUmJW?=
 =?utf-8?B?SzNGWFI1c3Z3WnJPYzNEVWgrNnR0Z2hXalhqNkdQdEdKMHpsRTJmbzBhSGNn?=
 =?utf-8?B?NTh4enhuWXg4NkpsTi9MK0JRU0k4Z1pOV1l3TW9SYk9XWWN2aXQvS2hIekxC?=
 =?utf-8?B?TUVpa01pVUlBSkdtU3k0SXhmbU9hWjY5VnQ1OUV3aWR2ZDMxN3lhUlJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnphbi9UdE10Y3dJalBLZ2g2YWVTSUxJeDBNaUUzbk0zM0MvS0ttNWlRSjhF?=
 =?utf-8?B?a2VMM0VOUnB4MnpQWENnVldqakpreGZnTlhPbmhLMDJkYzl1MlJLeHgwYTl4?=
 =?utf-8?B?U05zcm1PUHhHdkhYTTVpcXpUQndHZFVQUTI5VlpBVnp4SzFiLzNCWG9qOHVK?=
 =?utf-8?B?NmVjQzJWemdRYXJTWVN2Z1hOelhtaTRQWUJ3Vm5MekltT2FCNEtHTElrM1Ax?=
 =?utf-8?B?cno0eUI5NFVhKzRJTktaVUFoTDhWOEl1RzNwNUJJMlZQSkZZUHJOZlVYSkhN?=
 =?utf-8?B?cUFUaFk1MHRUQzBTc3pva0ZzbkxkeWM0MGVrZXRLMHo4NmVpbTBDMkdYS01I?=
 =?utf-8?B?SUlucXhQWnZveVErY0E0SURxaVdaZVBxWGd0d0Z0c1MzbVlsakM3Qk1kM3Zp?=
 =?utf-8?B?dFV2bmw4ZkNFTUdXNG5rU280MEJSbmJIbzlmNGcvTTV0K3d4Mzdzc0RWVmxI?=
 =?utf-8?B?SDFlck5FbkFLSlEzWFdQTWU2dGdNRC9HWklseEJ4VWhzNUg3NGZNc1NEN3NI?=
 =?utf-8?B?L2F2N25ZZy9weDFpOW00NzhSNzhQb09NSWh0NzlNT1FFRHdDZkJKMzVUSS9U?=
 =?utf-8?B?MHRGOEJ4U1BFS0QxdzZqbUVPQjZaeWc2Tm5UQ1RNNXoyYmxJSXAvM0hPWGRH?=
 =?utf-8?B?RFdtWll3VGdXYTZnM0p0WlNRY2VXQjBGMUozKysza2RveGhjSXhyV2xESjVT?=
 =?utf-8?B?b2pUdmNOb2ZPV2krdDlkb2VxdmJrclVhcTlJQzlNWlFGTXVlS2lxdlZ2cUpx?=
 =?utf-8?B?aEJlMGNoYnJyT0FjeUJQYTA5QnA4cStRWE5SNlZIYU9sTTVPYjJNbkxLRFpz?=
 =?utf-8?B?d0FtU3JQdzg1Sld0Rkw5bkp3cDhma1AyMklvb2FBVEFPeG1FSGhLK1pUQko0?=
 =?utf-8?B?T0p6Sis2Z21WNWhua1J5NFo5ckwrSnFiNFo0M1RFd3hpZEkyQ0k5cE53U0tJ?=
 =?utf-8?B?bWlUZU9TbG4rSHB4d2xwbWlHdUdRQXhsTTNpMld2ckplcGZ4OG1zODd2cll5?=
 =?utf-8?B?S2tmZG4rQUsxVmIvalBRQVZSM2VoZGdHai9PVUJFdTNFTGdMTmM2UVVFbGhM?=
 =?utf-8?B?TjhNdTdPaFFHY1lCcjBQT1JCc1FlNGh2d0VVN3lCVzhhcWZLTFdGcnhOcGxF?=
 =?utf-8?B?UE9iTnlhdVZ2VzRTVFJadDNNanNnWkwwUnFUclFjbHliNXFQNU92aHFYVFJH?=
 =?utf-8?B?K25XeStxMzZ0YlRHUXZ1SGdxS0lqUXRmUWJrNmt3UTREajJvUGM5Zk1yUUxq?=
 =?utf-8?B?dHpHZlNpQ2lzd1Z5SG9ZeFkwQU1yWkZyU3lvcUlkQ1lUOHV0WmdxRnpiVFJF?=
 =?utf-8?B?SFByc3FoL3Rkb2JuL3hjWFZGZmwzbVlsa1RpQzhNeGhKQXdvMDJFa1V3Rm5u?=
 =?utf-8?B?R3g5MFVjbElCWVB0SEhPcTdaR3BNa3pCb1Y1N2FDaWtIbit4NStKZUNYc0cw?=
 =?utf-8?B?ejk1WjBUTjRaTG9oQ0ZlYVUyZFREVHRoOHA4SXFTeFd1d2p4dFdRa3JQTkZX?=
 =?utf-8?B?ZnNHdE8xOUFwRFUwaFh2STNGNDB2Wm0yc3BaaU9NbE91SFRIZ3RGUE45VnBz?=
 =?utf-8?B?WCs4OGlQM2gzdDMvYzRhWjdXMk5ONGtpQ3p2YmxpbC95c1laRzZVN3hxdFhZ?=
 =?utf-8?B?b1VpMHFGdVdZQWxUUzBRTXdkd1lSaXYrWEdmblphTktrVXZ0NXFORzBodVlr?=
 =?utf-8?B?OTArb3BudXBqZlZCcVMzYkx6YUFZcVhxL3ZLbk5UbjRyYVhqNkp2L0VSUWdT?=
 =?utf-8?B?eDY4RE92MVJsdkRkZHArVHV2VGZXanpaMEo1OHdxVWY2eVFoNzJ4UVdlcFVa?=
 =?utf-8?B?WGUrdTJwMEdrUmR5b0g5RkpZb0lPdlNFdGtPMFpFZ25lNG1HSDVSWGYxVnZq?=
 =?utf-8?B?UDFUaitGMVk2dEQvTXhWU0Qwa3p3SmVaR09qdjVvSmZPa2MrRE5SUTl3MVp0?=
 =?utf-8?B?WE5ZellpeTBPNHVXM3hmM0p6QkYzb1Y0dGk2b2RDRW1QQU9mMGtveFBOaTl3?=
 =?utf-8?B?NlhiLzdnTEl3SWJZQW1LSDBoSVpmaC9zbmJnUk1JbFpudmNLelJYeUZadXd2?=
 =?utf-8?B?ekNodSt6aHpKRUlOZ0xza1VQTlJVd2E1WktRNVVrUVVXUGU5RVRvNUptdkRO?=
 =?utf-8?B?eGRoTnBzVnErSVJoMFBWYlRiZTlTMU85TlI1MXdsQ0xua2ZHN0p4a2dKbnh3?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f5e7f1-a73a-4010-8926-08dced91ac5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:21:49.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3ZmWGzmnb4YwXP/s2BTfBtdtcGpuahAVMbMlScD9CcryjE0CFD1gv/23rw4SmiqDZnxOyOOGwi6JKKeArByPIq0BewQBin4z+xASWuxPXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as the
> counter is assigned. The bandwidth events will be tracked by the hardware
> until the user changes the configuration. Each resctrl group can configure
> maximum two counters, one for total event and one for local event.
> 
> The ABMC feature implements an MSR L3_QOS_ABMC_CFG (C000_03FDh).
> Configuration is done by setting the counter id, bandwidth source (RMID)
> and bandwidth configuration supported by BMEC (Bandwidth Monitoring Event
> Configuration).
> 
> Attempts to read or write the MSR when ABMC is not enabled will result
> in a #GP(0) exception.
> 
> Introduce the data structures and definitions for MSR L3_QOS_ABMC_CFG
> (0xC000_03FDh):
> =========================================================================
> Bits 	Mnemonic	Description			Access Reset
> 							Type   Value
> =========================================================================
> 63 	CfgEn 		Configuration Enable 		R/W 	0
> 
> 62 	CtrEn 		Enable/disable counting		R/W 	0
> 
> 61:53 	– 		Reserved 			MBZ 	0
> 
> 52:48 	CtrID 		Counter Identifier		R/W	0
> 
> 47 	IsCOS		BwSrc field is a CLOSID		R/W	0
> 			(not an RMID)
> 
> 46:44 	–		Reserved			MBZ	0
> 
> 43:32	BwSrc		Bandwidth Source		R/W	0
> 			(RMID or CLOSID)
> 
> 31:0	BwType		Bandwidth configuration		R/W	0
> 			to track for this counter
> ==========================================================================
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  arch/x86/include/asm/msr-index.h       |  1 +
>  arch/x86/kernel/cpu/resctrl/internal.h | 33 ++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 43c9dc473aba..2c281c977342 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1196,6 +1196,7 @@
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>  #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
> +#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
>  

As Tony mentioned, also please correct order of this MSR.

>  /* AMD-V MSRs */
>  #define MSR_VM_CR                       0xc0010114
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 86e3e188c119..de397468b945 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -602,6 +602,39 @@ union cpuid_0x10_x_edx {
>  	unsigned int full;
>  };
>  
> +/*
> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.

"ABMC counters are configured by writing to L3_QOS_ABMC_CFG."

> + * Reading L3_QOS_ABMC_DSC returns the configuration of the counter id
> + * specified in L3_QOS_ABMC_CFG.cntr_id.

First and only mention/use of L3_QOS_ABMC_DSC in this series. If this register
is not used then references to it can be removed.

> + * @bw_type		: Bandwidth configuration(supported by BMEC)

"configuration(supported" -> "configuration (supported" 

> + *			  tracked by the @cntr_id.
> + * @bw_src		: Bandwidth source (RMID or CLOSID).
> + * @reserved1		: Reserved.
> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
> + * @cntr_id		: Counter identifier.
> + * @reserved		: Reserved.
> + * @cntr_en		: Counting enable bit.
> + * @cfg_en		: Configuration enable bit.
> + *
> + * Configuration and counting:
> + * cfg_en=0,            : No configuration changes applied.

Can this be expanded? (sidenote: It is taking a long time to get clarity on how
to interact with hardware. These incremental cryptic fragments make it difficult
to know how to interact with the hardware.)

For example, "No configuration changes applied. Counter can be configured across
multiple writes to MSR while @cfg_en=0. Configuration applied when @cfg_en=1."

> + * cfg_en=1, cntr_en=0  : Configure cntr_id and but no counting the events.

hmmm ... still the same (""but no counting the events") strange language I
highlighted in V7 ...

I think it will make things easier to understand if similar language is used
between the descriptions of the different fields.

"Apply @cntr_id configuration but do not count events." 
 
> + * cfg_en=1, cntr_en=1  : Configure cntr_id and start counting the events.

"Apply @cntr_id configuration and start counting events." 

Can it be added here which of these settings (or combination of settings) result
in counters being reset?

> + */
> +union l3_qos_abmc_cfg {
> +	struct {
> +		unsigned long bw_type  :32,
> +			      bw_src   :12,
> +			      reserved1: 3,
> +			      is_clos  : 1,
> +			      cntr_id  : 5,
> +			      reserved : 9,
> +			      cntr_en  : 1,
> +			      cfg_en   : 1;
> +	} split;
> +	unsigned long full;
> +};
> +
>  void rdt_last_cmd_clear(void);
>  void rdt_last_cmd_puts(const char *s);
>  __printf(1, 2)

Reinette

