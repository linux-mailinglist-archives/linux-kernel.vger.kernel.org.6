Return-Path: <linux-kernel+bounces-285832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42070951349
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6638B1C22498
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01A47F5D;
	Wed, 14 Aug 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAgKV68M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC04D8A9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607886; cv=fail; b=dtF6Gb4WwlzpusVWo/XELGY/a/3Ff0kLkqY0hc526mrsnNJM2XdyH7rtSD1qMSzNGfhm4sYId0AyQFJDuinJFmGFVEkzfDujtqeDzedPJlZykMzAxzaDxHV0IheH96mtYj4mbA6YixYHcpgrPNHW7ftI0/No+1UHyR/1v2ye23Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607886; c=relaxed/simple;
	bh=yL0W/kGsCakJq45vxRuXRfj7ueTkOhDBs3zHzG1XEvg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBR2fWTLwqzQdkGd/S3gVzKeGEVvjK2dMYwCnT34g+hUrlk+yI6tmziKtIR+IRqVW14egAOiGF2ow/NGukutyieKf18ascwJyRfuLOkoYgPyM+y5Ubv3Nz3Da19ZgYG7YXuLCVnjdRj+FtLxhJMRaHv1qnnR6coHaWjquAL2EUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAgKV68M; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723607885; x=1755143885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yL0W/kGsCakJq45vxRuXRfj7ueTkOhDBs3zHzG1XEvg=;
  b=MAgKV68MBxafCbGOR1oXcv4/H/hvoG0SP6CUrLsb97Am/ljJpMojOEKO
   rTrlyK5jy1v8uhTyjPoMX21glmDnuazPy1BzEJmjmJfvWf8hQM619BCax
   htptHGz1MjBv8FZsfJLJlUUlCpmHUeKaLA/Zngsln4j7SP/t8h3bGEYTa
   mSllrYeSaGnmCYFPXYCOzQSYhzoNs+HhfMAtNJSWZlQwN1Y/OGp1m0F+C
   8SNgg7km7CN3EtCfny6PcjjyUqA6nhqjQrJ7DKPMPFYadgFaDCHKhjq6E
   STbTyP9qkitghNitRnCt6PQZAOrB2mKULiVxUquSKRmfG4+SXzWqdFAm4
   Q==;
X-CSE-ConnectionGUID: ZnGJatNgR0qwVPdcBhhDoQ==
X-CSE-MsgGUID: U4cxmVVyTeimoScB6K2fKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21360471"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21360471"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 20:58:05 -0700
X-CSE-ConnectionGUID: CDrXrz9JQbuoLpwISArTeQ==
X-CSE-MsgGUID: C65MDy9+QdKOtyzlQMLs+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58872294"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 20:58:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:58:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:58:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 20:58:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 20:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Ub/hTA0jinxWT24g/vWzHRbzG0qhMo6i7mzuqserdN0pfhvx90VUc1E0qHCMjLos+PoUUGRzUabyHCSekvjV0agDxcArLlRD/HmNL0m3zRwbCpFKVPIzoNY1zBwggn4OEK49lw3ohzx3oGKgdxwHW0gbFoT+L+skmvq+8pcqV2pMZDUy8uM7xOD0mjZh5TT5tQpejpSctIjkyHeeazJoHHHfrgel4iB0OPbRzB2fVG/Vga+CJhAjE+y4Cd2URThAzohQ1rZlT169MJlblF2jfhqMn/JJtfyOqbvC3jXm1E82ZBvQ0A+8nEm/SMvYM0ornEWvZsNy3H7a/vCQXKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCQZG2oDTVZRmBfSLJkgmaJdsrIDELbYivtz4jaOK9Y=;
 b=ArCs3yswMh2kns8Cnn0iSYRuwmvvMT29guUyZnRQ/UVz2gzhKWU6HH2oKCjH1K41WRZyp3sO1phcG/BnjZaFX8MrGzSjJAoT0m8NG5cIT5SPxhQOpgleNPWuuEZH1Zr9hnjE3CqVU2/medJqarxPx+AHkVeYurIZlMs3dnN16RUi4SFTDUiyHv9K8Kqul64Y52sLvJesbaFI/dkOgYVmQhdf4I/S4skTSUhHbNKNDxw3HpTPdWdRceFd7qBN03UWDQeXxTA+F+wilcKNLEcmwEq6LSNdL1FLxJm9K92u2nE733N3ciM3MX/Kbp2I1NNEkT6uxOYcDwTT9kxQ+KZt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 03:58:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 03:58:01 +0000
Message-ID: <90234a6d-d924-444c-b1c1-8cd90fd6c492@intel.com>
Date: Tue, 13 Aug 2024 20:57:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/39] x86/resctrl: Use schema type to determine the
 schema format string
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
 Martin <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-6-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9a0ae9-0e9b-492f-c837-08dcbc154a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eS9LVEprRC9WdmRqaC9sbC9JNy9nY0RDS3U0YUlNMTJxYUFzN3pJRW5HZkJF?=
 =?utf-8?B?akVibjZXVEVxN2VWeDRMc2padzQrS3hNMjhucEs4NHpFeGVXM1p0L05ncC8r?=
 =?utf-8?B?S3pJdHpOZmYxTGdCY3ZPWFF6T1RpQk5wUFdLRHB0SXNuV2RTazhXbjU4TDJU?=
 =?utf-8?B?QUhFYW5KVTRsL2VURU1pUk4vdGNNMVVLaW90NjYxazdjYjgzWU82R29RWHM3?=
 =?utf-8?B?TEtydFJWNk42Wmo0c1U4SlI5VzBBQmdySnRrRUJhd2h0RENQeCsydHUxZ2w2?=
 =?utf-8?B?SEYrd1pzTVBUeXVWT2cyOU1WZUMybjZDTU9OcEFDSStWVkcrdmZYZE1ZdHFq?=
 =?utf-8?B?TnBxWk50NTBSVVJRZ0hudFpidlhBQlg2WTVkVE5PTFNOVGZEWG0vVFpvWnl6?=
 =?utf-8?B?RldpVW5Tc3J4NTFjSmdnbEVCUWFCRTEyTXVuVXZTcUhzRDR2Vm5mU1daalh1?=
 =?utf-8?B?S0JuTE0xU1htNDROTHVBWlVIVE1CZ1ZlRFdpU0lHNVFMZWNCdWdielJwVWNP?=
 =?utf-8?B?SjcvS2Z4T3pWKzZJYnpQYnpyTU92M3RMSGJ4ZjN4SUI3Qm1wSjVud2RySTNM?=
 =?utf-8?B?RldnN1E4UEFBQ2x0NzNNYmVydFBPNnJsSEF0NFpOa3lNMys0Z1l2NDY5YW5t?=
 =?utf-8?B?QWVZVDJhZlJtVjdXUE03M3VkVmJwc1lWWW9zZnd0SXNMY1J2NlFTT2RaTEs1?=
 =?utf-8?B?YkhwdTFjVUNaZm1FaEFVK2ZFNkNoZStMNjBzZHRqN0FiczZjNHBWQ3FzWFU0?=
 =?utf-8?B?Q2VXMFpobHlsT252Rmx3U2NSMnpMNUc4Y2dRWmdITnl3L0s3RnFzM1lQRk9Q?=
 =?utf-8?B?ZkhOUDc1Z0FmZUFSc1BnaFdnbnhvcTZQRFQvSXJsUnZDUmg4b1BJYzN3ZVRm?=
 =?utf-8?B?bTNHOXcxMnB2RU4yR28rK2s5K3BrOStTdDkybjA3Q0U4L0VmZDQrcjN6OEpU?=
 =?utf-8?B?NFNPeTRYNzd0eWNLNXk0YmxKUVJvTDROSWVyeUxnNVR0SHFXNDBFaFpsWlYz?=
 =?utf-8?B?SE90OGszNVVsY3ZYdG5BL0kwQXkrR3A0b3V6bTNhdlYvbW9JLzF4Mzhsbzcv?=
 =?utf-8?B?MzkyaDlKd1Q5VWYzS0o2Lzh6S2xvZFBCZkRGSDFTQ2w1UU1uOVB2QjNhbzN2?=
 =?utf-8?B?U3VhWCsrUWRFSDlzRnJhWlROMHc2ZmNqYXFObUFPU3RWN1lVRlNQeWkvZkFN?=
 =?utf-8?B?Z0p2SjZlUDNRd0Y1a2htRnBneUhYU3pQQllOc2xRSElpMW9SNjM4Z2w3QU9X?=
 =?utf-8?B?anB3UWtzRC9FTlRRaVdqZEo4SHRJeWFEUWc1VThzU1FhWnhHbU8wQzY1YmJm?=
 =?utf-8?B?WjZ2LzNqMGYyMU13UHpNeGlmRjJoUkJQeUcxdHZmVXFrRjlWRUoyeW1KSmNI?=
 =?utf-8?B?V3kzdjE2VVNNMzNnZTF0cmhiN0l0a1BjdlJyMVd5MldyUFBkTGR5Zkt0bEo1?=
 =?utf-8?B?QmdUNTk2LzhTc0NhU2FPaXFINkd4TnBnbExPYnVKL1pPUHduSHIyZlV3UHFa?=
 =?utf-8?B?WUxsa3YyTjlpU214L3ZNSURaOE9nWFp4ZzlzVmJ0UVpYOXlLSStnTkhQWE1y?=
 =?utf-8?B?Qlp2Rld2ci9PSHg0dXJSZVdvNjVaUWNRUDI3ajFQb1Y2RkhSOWlsblNvR0R5?=
 =?utf-8?B?SEJOKzhVT0VnWVRFdzdicHdxTDNRYkxJWjh3UDRaMFF3aUJsVGk2YTY3ckIw?=
 =?utf-8?B?YkZ4bjBBK1pqZVZSbmtlbktkSEl0Y1NyQTZPcm9haVlJSkRnWUN4NkFzaE1w?=
 =?utf-8?B?YVlvYUZudGswb2Qvc2pDS0RFRm9mKzkzTmtiQUtKMXVXNTFYaHBhMzY4Rnkz?=
 =?utf-8?B?U3VMZGYxWmpqbVV2aTlJZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lnbFd2cElXNE9GenR6ZUpLa3VuaHR1dHhOM3lORk04cGNERlF0b2o4Qjlw?=
 =?utf-8?B?dHNwVHk0TWpGNFVKN2k5anFUTk9CV1RIaHl2L0FBbENRTGdpUVhMdlp5dFRG?=
 =?utf-8?B?MDZNV3JEZ1NpNzV0dGF3Z0VlQWlENytmTjdkUDZHOENHSTdCOXZNNzFTUEZW?=
 =?utf-8?B?dys5ZkE4b0ZabjZUakhDOERpem9OSkdjZElhZXdXb1crNDA1OEQyb2UvYzM1?=
 =?utf-8?B?czgwczFnWE1UOEF0TTZMRFp0eUVZTGJWWld6VkdzeTNFbG82K3hMZElCUUVT?=
 =?utf-8?B?eEQweVRZWlU1WUpMTEhjalhHS3hsMERMK0VYc1VLeFJDTE9URTJZMys2U0Vv?=
 =?utf-8?B?MjZYZUpidHJVblZINDFNaTIyQVJTQzV1SVBVRlFzaC9OYnlMc2JYV2dlZDFR?=
 =?utf-8?B?SVRzME1XeDd1ZjJsQzY5RDZ0NkxDVTlKU09QOVBlMVpYYS9zY0Fxd0FEUnIr?=
 =?utf-8?B?SnBsTUQrbjNCVVd6MFh4N3UwRnltTzFSRlljcERZYzU2bGlPK2RzcjZkeC80?=
 =?utf-8?B?RlJ3VnJOK0VnRGtUSDJkdFRwTjVzWnRFL3o0YVE4NW1obHBwTkdPcXBRaldM?=
 =?utf-8?B?dFg3TGRJNnFDL0MvR2lENGlJaEtxOHAvTmRBU09YWGlxM1BOZUFrVE96TFpX?=
 =?utf-8?B?cVJLaHRJREt0ZnRaOVBLQzNaeFFlY08rSE5BRG1VbG1xWjFrS1pkSlJpeDYv?=
 =?utf-8?B?SmpaNGJCMUVJN3Z5NU94NFJQVEVhejNxQ1FxcDlPNzRaT2FucnhVamVrSm00?=
 =?utf-8?B?K3QxTC80K2ZqSlA0RjJaYlExMTdsTTVjU2Npcm43d3NPdWJrK3ZidnYvQjBP?=
 =?utf-8?B?THB5eW1WWkVhYTRUYWk4Uk1BamJRODV1eFNlZFU0VkJxekdFUDdTUHk0elcv?=
 =?utf-8?B?L21TbFIzY05Hci9HcnZZY0FyMWJKQkJ4ZC84aUcxS0lvbGV0WEI2d2k0WHZJ?=
 =?utf-8?B?Vml3Z1d0eU1iUW9TMG0rT0xvNGUyVG9IVVJJaXhRdDdiaWRpSzBpY2N3b2gv?=
 =?utf-8?B?ZnU1UlBWVk82K3FIMzdoQm0xUmw3TUF5TXROV1JxVEhwRWp3aVpKaWhYL21B?=
 =?utf-8?B?TnUxQzdwUGU1ZUI2M0pSV3gwY3pTRU9reVJWMlNPdVFVRWVHSmpOQm12UkFr?=
 =?utf-8?B?cGZOSUc5UEdjdm00T2prdjFqUzhWSkYrYnM1MDZDWko2QVQ4cTZ3WXdteURh?=
 =?utf-8?B?NnZLRC8zTzlhZWV3MWJ5emNLQkVjY0F2YjVzY1luaVhuSkVFK2djNXVNWnJs?=
 =?utf-8?B?VUVIUVhmZ1UxU2tDUXY4TmlaandSa3dVbjh0TFRnd0NpWnlBaGRsMUxFWU5G?=
 =?utf-8?B?YmdzOXdZUGVyN0Z5cXpsMHJCSHdwY1ZVSktuOHhWaVQyb0d6M1BQVTFQeFQ0?=
 =?utf-8?B?Zklrby9ST1EzVDlnZE1CMmxWTUMyR040S3pmRjNwNmgrK3N5VkhDdTRERDJ1?=
 =?utf-8?B?aEFha2JBU2J1TDd0Sm9OVWpMQzZ5Zk55RWhWbUpCRzFPQkwxQVdRTVcvR3dM?=
 =?utf-8?B?L255NUxqaHBTamRUMTFCcXM3YTFnelc3WDJ1QkpPSlJwZGlhTXZOTkU0Um1S?=
 =?utf-8?B?RjVpcjVoalI4VHppcDlPOVhhcWpnNFN3NlRSY0R5SWtNcGQyQy9xcHZOOEVO?=
 =?utf-8?B?ZkZ1cG9aMWdES2RxMlJSTEZCUWcvZzR6anhxcmM1WjE2ajNyWmpCM0M5Q3Bw?=
 =?utf-8?B?WXFpTTZzOWVnV3Rpa00wS2NoaUF4SDV5ZTNqUzd2MDBWYzNiMS9VaHFHeVlC?=
 =?utf-8?B?SHZDcHpaaFFrRDZyOE1XKzFSbWt6MGZUSlhVT2xZTWF5M1poNmtBc0tGZ1l4?=
 =?utf-8?B?MSt4UllTNjhvc3d3cXlGSW0reFhaZUhlRng0OGwzampSdEdhTk00NVdpQ2Na?=
 =?utf-8?B?M0V6SUFTUFp3VTZJV2l5WXR6TW9UeEZ1TGxUQ3BzdTg4cm8rMDVsZUJXVjJK?=
 =?utf-8?B?dGt5d1MyemJiMEpoQlAwbGZxU2VvVUhqcHgxZnZ0WXgzOXd5K1hvQlQ1NnM5?=
 =?utf-8?B?NW91em5Id1d6ZU53UXhWWmVVWHZjN0hqbUxvUUxSQVM3WEZQbjZ0VjdHeFlk?=
 =?utf-8?B?VDVCSGlSamdOaHc0bHVpUVgzS0I2Q29KZnJqYWhBZVJqMTF4bWFmUTNQWHhQ?=
 =?utf-8?B?NXJwbVZGMHY5dHdXaUlSNUZ1cVEybllHL3NNWDNrVzFnQVNqaUFlM3lsNlQ2?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9a0ae9-0e9b-492f-c837-08dcbc154a8c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 03:58:01.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCVfjSQBcY871dp9T4XuhwSlG+Pecic6O4AXPGVUHsQpGCPF+JlAiIEoA4w9rrk805JXrsPq90ufx+huq/qBnFVRscE1iHx00bETaoCNxn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com



On 8/2/24 10:28 AM, James Morse wrote:
> @@ -255,6 +253,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
>    *			   user-space
>    * @list:	Member of resctrl_schema_all.
>    * @name:	The name to use in the "schemata" file.
> + * @fmt_str:	Format string to show domain value

nit: please follow style where all sentences in this portion end with a period/full-stop.

>    * @conf_type:	Whether this schema is specific to code/data.
>    * @res:	The resource structure exported by the architecture to describe
>    *		the hardware that is configured by this schema.
> @@ -265,6 +264,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
>   struct resctrl_schema {
>   	struct list_head		list;
>   	char				name[8];
> +	const char			*fmt_str;
>   	enum resctrl_conf_type		conf_type;
>   	struct rdt_resource		*res;
>   	u32				num_closid;

