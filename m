Return-Path: <linux-kernel+bounces-417464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33E9D5462
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D385E1F21AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA61C9B9A;
	Thu, 21 Nov 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfgkzacF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE4132122;
	Thu, 21 Nov 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222735; cv=fail; b=d/BZ0YFXhj/vmH+TaCyQFzHv3aKc2+bCp3oPUTv1M0BGA0+ArjI7O5+eRmFAlElC1eEUFkYzfeitEdroaP78HToRxXp4qgukr8/lASgNzFkfA2OoBkzKcjcxLeHEIXu3VTGqnoVILaJx6Q8nPlJAkauJE6Da8sWs0SgDT5GFYfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222735; c=relaxed/simple;
	bh=Lupc2Edyb5LeoV+lwAPHkRYn1jv8ZJ9D2/jWm0TJaHs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MG1Oeh9HfDomi0cNS/zpSGon0bLcw0+06mFf7OumoqiGdqjGDeP2Qy0AUooH2HkwyS3Tuw/hSWJ3ojCrIH3eBivq0GwOMg+ZdVXRExsndCnwLpFb+uBoA/fF00/+ra4SwvkqRwWi6ivKYwKIfZr+5E2MqnypWdSJaQuzCEqOR1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfgkzacF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222733; x=1763758733;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lupc2Edyb5LeoV+lwAPHkRYn1jv8ZJ9D2/jWm0TJaHs=;
  b=HfgkzacFU/54EeA8iVKtJkrJCE8E3huIEZSMnq9qmr3hKf9tg7wcx85A
   DijbSAzGkWsDBKb/HO4hXUNPsl+j5TnQJyObXEKnQPsawzUAsyX93tf/8
   P4VSFPyakwpz3126zgbskFpFJgm+ntsj2QWESu/vDp4HPw2qHSuHF+UP2
   /GyCx25uSQGA78iukm7p6FD+Kzs30WowbGLkwTQsgUvp5OkGfTlqYp1qx
   rW34T6iBEt++0RyGjYZxO6A3dUVS92bNvm1pNmcSOAaL/0D/ML+X7YFKs
   ynoTZSIB9d4PEWbQLqy3LM0OmHnLQ2k5Qw7mYVG3JHJJ0wmWd0KjLfQ2h
   g==;
X-CSE-ConnectionGUID: hlHd3jBoTuumcb2p1z/wOg==
X-CSE-MsgGUID: hNcJPULiTEq4QEJ75wvSRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="42877956"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="42877956"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:58:53 -0800
X-CSE-ConnectionGUID: S2CaP3N6QL22/u0d3JTnSw==
X-CSE-MsgGUID: JL+4uYyHTGu6LNfLfd2p3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90302764"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:58:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:58:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:58:52 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:58:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zay5ysWZ1rkIiws7jSTEKm1Is/3Cb/xz2QoHA2iX2rqzewkYCiD7+iaLpsGA726IBsTx6ZhNUPMxQ0452TC65jc8ysD0H41VfIobSaToyJOyVoEZoUX+vvISJQac1+d08faQ4LzUAlV1Z0N1mywi0Bbdwdh7jX7XUKunc3jAKk36s2Gd5FKg+SjvD8CH60E96y7jnBhsBgVOgqerE24H5BRdDmEtuLTC9SsxcPzw8flUwJ37I+LEOzgNaLqa+CUDs78NG8YZRFngMHMSeKpNE8hZsynzNNrHI3IGZwRKXoZWQbctpditjK7229LWyRO5ytlrB92v+WeE+ylyOYQtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQQ/V/5NkaLsDx6LjhtuDkHYhsrpnwlCsF4x2yLu8+Q=;
 b=uKM4z73cswewKSIS/Ou6mTwmHNLdMcdAiowYZJg+ayxS5MuD4s4U4jD4/vgFDQY8dco2jtdlSG8YBWoZUZx++5qQFsIKA9Ny8fZ3+BO3zemwQA8wOCN+hLvSEaNlFOVYJ+lfJXWFg0LYXlTPOt7OP8ea4r7CI4B4xapAcd+9DJGuF9a1l7qsQ1a8xVfR1Nh3x4aVVoD6Tnuk19o8XOY/4ofQNN5jnXwHTDGt6VD5zlc0bhHpbdyHfK8+vqqO8Gr3e/iryloVAtgB2oZd7EcMGXKPPj01nyLCpXELQ4/BAaLTcLij1ND+eYQ3lcLa30g0LlWvs3CaFtwwJBJGTOuPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 20:58:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 20:58:38 +0000
Message-ID: <82b51e46-3da4-4b49-8ad9-45ed18fcc2e6@intel.com>
Date: Thu, 21 Nov 2024 12:58:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 24/26] x86/resctrl: Update assignments on event
 configuration changes
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
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <89e98891f50d1d57c1cf8bc18c1f562ac58d2cce.1730244116.git.babu.moger@amd.com>
 <b78a01b4-3583-4689-a894-96dab5dfb9fd@intel.com>
 <31994778-74aa-0b61-cf93-14c25c872e9a@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <31994778-74aa-0b61-cf93-14c25c872e9a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fde868-6cd2-4181-1aa6-08dd0a6f459a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmkzSWNzakZEcVJtT0JrNmxqblBlS2h3b01aODdXZHRaaHJCSzlSb1JTamR3?=
 =?utf-8?B?cXRmellOUFhlWC9aMlRPdmNkaGVSUjdCWTgvMEpBU0hxdmdwWlNXMUJUcmxp?=
 =?utf-8?B?aWpNL3RGdnhabG1tejZsN0RxRWZVZTM1VVhUdmZoekxUTmQvSUZ6cDBDK3lM?=
 =?utf-8?B?OFE3d1o3MnlhNkRvYmZaNWdiLzRzWVBmM1lzMXBrdkNSbGc4SmFreHRZU3RC?=
 =?utf-8?B?SVE0aEQvandDRVNHcE9CUDhZTkY5cDNqbS93MUx4Mk5TaDJCdjR2N1FiRDZm?=
 =?utf-8?B?bmZueWltdGFUOHF1c2xMQkhzZVI5K0kzV3lVait0am9peFdJaFZFNWZPK0V6?=
 =?utf-8?B?a2x2Q2taMWRZaEZ4eVBFZk5Ra1pNeHVNZnJ0bjhmM1N1dTAzS2pvM0tCYnBF?=
 =?utf-8?B?dnFCTWdwRFUyTzhNSTVROG9wNlNmQUx2MWNJRXp0SVFZY01KZ1hWZlR1OVNC?=
 =?utf-8?B?ejhlVGxqc1JWYWdXZUNSeUxTeC9MNzZHMEdmZVVJWjZOamhqNFUwaEx6MWZP?=
 =?utf-8?B?U0tiaEpNZkdFKzFyUHNlRkZlNkFINllvMWFlRThiamxSVzZvaURocWF6Mys1?=
 =?utf-8?B?L0lJd1F2dDhQRWxSanEwY3haMlRBUmp1Q3p0dFBFL08zbmdZcFNBTGV3SUt3?=
 =?utf-8?B?K3JOMDA2WDJCaDZRR1JqNnhIV3YzbzhZaTB4d0NTdEFYTmthLzR0cjVGN2Z1?=
 =?utf-8?B?SWwzME8vemZ3MGhZTkFWN0JrQ051cFpwVzV2NlVIamFFZmxVTzZUZG41STNL?=
 =?utf-8?B?NW1xL3J3WS9Oa3Z0bnNucjRtUUtnY1FvUmtoWEZyeCtMT2hxV0NQcUdETGRZ?=
 =?utf-8?B?a1A1Z2RIWllmb2FVK2VZbU03MW81Vmh5Q0psQ0R3dk12TlFKS1VNWWhVU2py?=
 =?utf-8?B?UkVhV1ROcEJyekdxRlh1MWRHNm1SMW0xTUtVTUVRejdYQXFQaFN3STNNalM2?=
 =?utf-8?B?ZG9UelNLa044Z0lHWFNJRE1yRW9XM25UbjNPdkl2UVQzVmdmamFPSDNJQVZz?=
 =?utf-8?B?V2c0cjBsdXdETk80ZUVGNTFOdDFyeUNwZVZzRngvVGtIUFF2UXI2SEZTQ1lS?=
 =?utf-8?B?QzZhdW96TnU5NVFvdVppYi93czZGZTRKbW1Ba25JWGFWalEydGlaMXkrVUtk?=
 =?utf-8?B?VlcxMmdEUVMxNm1UQWJDTmFTOE9WYWxOOXd1aWVnMHZtRkR3Z01MQnMvS0hY?=
 =?utf-8?B?OE9BY3NsWDF2RHdzTUR6RnZkSlhuRk9MY01NL1lnemVSRnZLUVZjd3R4R1BR?=
 =?utf-8?B?NzcreHZVcmZOa1FQNnZYYnpXMmUrb1doaUM4YmdQVUprRWxueEUxUmt3RVYx?=
 =?utf-8?B?b2Zxd29QbkRSMTZERDZ4T0I1bWdNQ0FWZ0tEU2xJSjBCVEpjRENiVmNUV2t1?=
 =?utf-8?B?U09aQnZKQ1FnV2VxZFFEN3RPbi9rOHIvRUs4UFlCdzZ2ZnQ2MXEwbFJzY3hz?=
 =?utf-8?B?SldPcHZLWnpkaFZYRUZjaUh1b3ZFRWlFTDZPdmN6YTRnTUVER3hMdytJSHNS?=
 =?utf-8?B?ekttSHBkT0NGTWVkaTkrdDVaRUdqSmRoa3BLOTNTWWp1dWJ5SWxBUnQ4NThX?=
 =?utf-8?B?N1c0SXZJQXdFYmJHTnRaY0dMV2dVc3FzVk4zK3YybkladDg2Yi9FYW01UUxx?=
 =?utf-8?B?dVRLNi82QXVJdFIzaEp2NmdKMDhTeXpHMHFRS0lQZDdOQUlmb0lYbEFtN0Ur?=
 =?utf-8?B?cjd5RWxuZi9rUkhlNVhLU1pEVi9DMjZ6WDV3dEN5V2xxV1FTWnlwaTQ3TndQ?=
 =?utf-8?Q?3cZXOO9NbvoljF7k9j7dUPJw6IuiakVt8a4hEVl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZ4Y2xVRHhsMS8vZ29uMEhWWEdnbFJhTkhXcU4zaUZ3bXdldVRlYVJjWmhl?=
 =?utf-8?B?eU1NZWN1dkk4Zzgxem51djRhS1BIWElJS3ZTcGdtVVZ2enE4Vzg2U1RnN2VI?=
 =?utf-8?B?aDNDR2Fyanh4SENKY0ZYREtLRXp3WHJvVWhLaFJCUjhCODdoVjVKMFRSZ29y?=
 =?utf-8?B?ZHI2b3lZVTZsWVhWVmdydm9OK3FGbVEwRlhsbWIvVDFxSWVMK2d6WVd1K0Ju?=
 =?utf-8?B?WmdYRVIvdWxqditTd2lPNVNHZVpjRDhsbmhjQTVkNkZjcytmV1RwdDYzK0Z4?=
 =?utf-8?B?MEJzSXJIeG1oREhOL3dzdFI5ZXJZWnNsNndrMTZsQXNoS2VlbURvdVd4Y2RD?=
 =?utf-8?B?dGFGeERUV2NxWkNWenVPMHQ2VDlXNCtqN2NsZGN1NGtJV1Y0WUNrTC9kcDZP?=
 =?utf-8?B?WTdXVDBzUitWMi9RUTJaVDd3VDNLaG5BSFVZSXFhazBnUHYrUUc3K0djNDRl?=
 =?utf-8?B?Nk1nK1h6clhqRlhOOW1YQnZnZnVPMEN4S29HYlVZai85Y0NIM3p6VEdOcm5u?=
 =?utf-8?B?Nk54RzlJTnhyT244Y1hTQ2NlblBDcUJjeGg2ODMzeXNxcnVkUVd0MHJ4QTNF?=
 =?utf-8?B?UGg5MWFnRExxdEEybXMvV01GY0tEcVdNeHhidnN0WWdXZy81ZkptOC9QekR1?=
 =?utf-8?B?ZGVaa0ZqN0J3NDMwWEIzMk5WY0lldmtsT0oyYkg2NXlvTXBScExRR0FidG5w?=
 =?utf-8?B?dks5MjN1dk9ob3hNaWtleGVjb0hnNHpaYkhORG9ZbTlycFpXQzhrNWJ0aVdi?=
 =?utf-8?B?TmxsaVhMNUI3ckk5b2VDMVFNZXZmaks4MllmKzkvVjhGWSswSSt3TmxxbitI?=
 =?utf-8?B?TWtmNmpmMGI3R2FzcEZ4ekVnakRIcDEzK09PR0xPblNGc1RuZEhBQ2hHUWlO?=
 =?utf-8?B?bDdBNkZqVEF0L1J1U01COWp1NmtkclZGeVNaaE9keXgxQ3dXb2gybjdMR01q?=
 =?utf-8?B?YnB5a1o3TUtoRzd1aUR2dnJVT0ZzZEJhNUo1OEgyRFVxZnNkSWxveWltQXpF?=
 =?utf-8?B?OGpKd01GUktkNW90RHhLYlBTazc0SGZVZGVVV2dxS29RRkRXOHhvZlNNdkNT?=
 =?utf-8?B?cW9BV0VrWFJPRFNSMFVBMm5PbFZXaW4zciszWUh2aGt4WFlBSEVESC85WlUv?=
 =?utf-8?B?bU5JdTRKU3U3b1JkUDYwdlB3T2gvWG9sR2c5YWMvYjhFbkg5WERMVFA4U2RB?=
 =?utf-8?B?QXkxRURHdXdoSlVMZVBiVjNWSksvUVZFTkczMTRVYm1lcFBBeVRiQnRBVkkx?=
 =?utf-8?B?d2tTT3B5Q0wzRkZ1Nm9DRTBwMUExTzZNMS9yY09OWW9uZyttUHVWYjA3ZGRO?=
 =?utf-8?B?WHk4S0ZGd3RDVTdTUWlxSERZcjN6VmJMWlJqK0x4Q2lzNjFQVTlyNHJoMy9s?=
 =?utf-8?B?SWErNHNZRmlsZTVmdHc1dzU4R2lNL2NNWWZiaVFXODM3ZHRPcGdlTzNyTUho?=
 =?utf-8?B?UzY4TjA1VlBoS2NPR2dlS2dacm85aDMrM0pxK2VrRmlCTjAxNnpsQWROQnJo?=
 =?utf-8?B?UDFsR3diQjRMYlZZZDAzcW1ndGNJYUZkZjY0b09rNCttZzEzU2J5ckJJQXNX?=
 =?utf-8?B?ODIvOVpsenNUZm55R2RnVFVtK3l1WjJMcHNtdkdZWVY1OGwwSElpMU5BN24y?=
 =?utf-8?B?L3pWVGpTM2lqNjdUL0lWekNlNVZWU3BVd1VKRmxGV1ozNlYwM2pWL1JBY2Qz?=
 =?utf-8?B?TStyKzE1end6Z0R3SXZKalpJaklQZ1phOWJvTlloTlE1ems0dXBlWlZzOEdY?=
 =?utf-8?B?TmVoZUMxUE9DMzNYN0VaemJWYWVWWmRVc3BPK2o1dnBIMVNzbWZ2VEIyUFFY?=
 =?utf-8?B?L1hMSlJ2TlMxZXVnZGFuNWttemt5VUtab2JQai9raXkwbkFZaWlKTlBuL2Za?=
 =?utf-8?B?QklxSUlVT1RENmNIR2FDK3V4ekFpOXJoME5JMEQweUNVU2RvRVJmMU4vcWVk?=
 =?utf-8?B?UmExVEZOOFFVbXM3YjJ0UXJvRjc4Ty9XeG9mOWtQRklESHJJd3ZnbVFrQ3ky?=
 =?utf-8?B?VWkrUEdKdlpWWklOeU0xYXBxQU1kOE12cDBBOFFreUhtMFk0eDl3R0E4c3RK?=
 =?utf-8?B?RHZxcjVEaS9xWUpXZk0za2FlN0plOTg4SjBpK0o1djNnQTFrYStjaXcxdDh2?=
 =?utf-8?B?NHlqZEhNTjZodTlYcUplRUt6SHNmc0s1bVdYVG1uMkNyb245MmdtMi91eG94?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fde868-6cd2-4181-1aa6-08dd0a6f459a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:58:38.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h94C7OT/PzB8SmmcRpts2WsvcD/83V7+qmZaLoBM55L2Z/1KNu3nVOU+qIBOiDTnqKk0bti+FhpWJvuzE/KWwKYPY/oT0tRgGdACI6S24Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-OriginatorOrg: intel.com

Hi Babu,

On 11/20/24 6:14 PM, Moger, Babu wrote:
> On 11/18/2024 1:43 PM, Reinette Chatre wrote:
>> On 10/29/24 4:21 PM, Babu Moger wrote:

>>> +static void resctrl_arch_update_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>> +                     enum resctrl_event_id evtid, u32 rmid,
>>> +                     u32 closid, u32 cntr_id, u32 val)
>>> +{
>>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>>> +
>>> +    abmc_cfg.split.cfg_en = 1;
>>> +    abmc_cfg.split.cntr_en = 1;
>>> +    abmc_cfg.split.cntr_id = cntr_id;
>>> +    abmc_cfg.split.bw_src = rmid;
>>> +    abmc_cfg.split.bw_type = val;
>>> +
>>> +    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
>>
>> Is it needed to create an almost duplicate function? What if instead
>> only resctrl_arch_config_cntr() exists and it uses parameter to decide
>> whether to call resctrl_abmc_config_one_amd() directly or via
>> smp_call_function_any()? I think that should help to make clear how
>> the code flows.
>> Also note that this is an almost identical arch callback with no
>> error return. I expect that building on existing resctrl_arch_config_cntr()
>> will make things easier to understand.
> 
> It can be done. But it takes another parameter to the function.
> It has 7 parameters already. This will be 8th.
> Will change it if that is ok.

Please correct me if I am wrong but I am not familiar with a restriction on number
of parameters. It seems unnecessary to me to create two almost duplicate 7 parameter
functions to avoid one 8 parameter function.

>> Since MBM_EVENT_ARRAY_INDEX is a macro it can be called closer to where it is used,
>> within  rdtgroup_find_grp_by_cntr_id_index(), which prompts a reconsider of that function name.
> 
> 
> How about ?
> 
> static struct rdtgroup *rdtgroup_find_grp_by_cntr_id_event(int cntr_id, enum resctrl_event_id evtid)

... or for something shorter just get_rdtgroup_from_cntr_event(), but no hard requirement.

Reinette

