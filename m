Return-Path: <linux-kernel+bounces-550438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DAA55F95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441FD3A5215
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F7518FDBE;
	Fri,  7 Mar 2025 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1VlIdxM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D21624E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322316; cv=fail; b=T0jBgVoCoyfD2vUGGEvnbtPbCkF+NOhmfMgS7qibmlnpkR7rYU+9jZ6TDL/aK+PWBRBFSH7iG+vPkISzeqgFouBFuCcPi24rNg1Xq+Nvqm1vOerku1tQr9sgAlAbqHbJ8xaa3eEBfdTrrTHdMluKCVFcfPShFJhCoI4zO7o1yyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322316; c=relaxed/simple;
	bh=fYIbReSD/CMrxe18kBtjPlypmUcb9i2YxSifpTU6kWY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DtH+/nn6MIrSoozV1Vw0p8FfqLsI8rAy9dIeuxi4iqn5E+xK58F8zSjlNlPv5mjWXfrv0GwNy/uLYHl6qQTtruH8FX85Uce0qg8XhkfFloW07U3iL9hpd6A41yWCPI4DskQj+WT35MTCO0/gFYwRDxbhWrZvjQVy5R2geXzOiog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1VlIdxM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322314; x=1772858314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fYIbReSD/CMrxe18kBtjPlypmUcb9i2YxSifpTU6kWY=;
  b=I1VlIdxMmtm+i8D8XZyHFgyryUiqinJQmlrYcURsHWDxVrGqR0MqkV27
   1S1t4FWCUfN+JoK+FY1B9x0UEzFZh0DgVYKY8iJu+qbVONaOIY1y5aYTs
   BDAFBuCVw3D/MjGJatqzCZlNoL8mTTDKpHf57M38fGEJZ+YjNoe4Ngqy9
   dugeVw+FecFpDZQW7m0CQSv2zPxK/JRN0IXEJOu1hP1QFnekWINlmq01x
   eDzmMfZHSpzkOhzLtZSWrJ8nN/wOf5KeJh+R1YKCRj63tQPZ1oX6iVk9h
   ICDFxeNkupXwpYVJOBPnOFULQrt2c7JF998/dbD2LQypGCzy7k+1enXA4
   g==;
X-CSE-ConnectionGUID: OTl62IP4RxaMmCnbLHi82w==
X-CSE-MsgGUID: NwEzzKFYR1WaPGOgEiRA/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41615286"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="41615286"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:38:33 -0800
X-CSE-ConnectionGUID: GUrt8guPRrmEDPXqI0YMeQ==
X-CSE-MsgGUID: 1IF/4YaxSoi9+XugeeXM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="150019522"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 20:38:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 20:38:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:38:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:38:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/DefvFPJTvGgn7mf6Xnva1dKVX7kHMy1OQtIjmvHZbJdfE2XCDlieNcHaykNe1+59RGziryPFkw1nL4D9PeNCTrJGJUeIJSZD8G566RLcUVurbayCRiuK2MjzoNam5PxsiTi6SxbNqY9rH3xVfY7LVaXbIe5Bajh/TkCIXY0AGWv/PO2n1bqP7JPkP03ANBjw6KuB8tEfzNtRIIc5fMJkLVJRwKGfXDygSVTeSqx7jLhIe56i+zs0bF5tJdQcri1Q5MXdXP05hYJX4TAN0ggqVjLpEgpG0tcvHhx6VWxejjyroZtOZQeN9/Qg+IElNk/fQ3MOOnE6f90q7a6qDFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt+VBDyCg3PAvA5Q++TLaehTdvo1xFE9sa89n2Ltg74=;
 b=UZJp03RCmSzh0FDZ7qfQmRisopfVxp41bKMB2mz968LXrKY+GRbzILwd7uyx76P4rT1A5KcSGTGaexqM0twwVvP53wQq1frRDsfXWVjJvaMFsICJY2vZHykTSQyBZWTxE4TcWFR95e//m0hiQVchOoTGY3cKe12RWQ5Z11PWCAko7JgFrMWrQZAQIsOBIvgfh5+hnhvgyKW5JTMN0NbN1Es0bN5E9Lt2h4mEvpoy3cz4rKh+olt/4TGm4o/cBhlI2nEn+RsaIReRq7+E4f+FZhUPnCT0652PSlMy+aHtWo1caA6Rwvx8Mq749Vz61BZEEqIA5wTlrq1p4P3L0EP85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:38:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:38:01 +0000
Message-ID: <5ee0c380-1286-4419-822b-eda0d791114a@intel.com>
Date: Thu, 6 Mar 2025 20:37:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 29/49] x86/resctrl: Move get_config_index() to a header
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-30-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-30-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e90a9c6-549c-448c-1100-08dd5d31d81c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEZIRjB1QmpnMnE4NTNjZ0VCQzkvSGxUSVo2TjdhR2t2NmlwWEt2eDVBOTZE?=
 =?utf-8?B?Q1NoSzRzVjBvVzBFTS9GTGxXNzk3TkpGcHZLV0xad05ibG1SL0ZlMURKL2sr?=
 =?utf-8?B?ZUlaQWdwMjM5aUhxZFBrMkZTelNEQ0YrTHdMcSs1azVTMTI3YkNlTm5LRHZC?=
 =?utf-8?B?MSs5MjRwTmJ4K1JUSHZaLzZBY3kzU1VTNVo5bkpVZnhxOGtLbU5oeGxvT3VQ?=
 =?utf-8?B?L3owN1owVXBkUWpOQkxmc012QWRVWWxMc1Z3clVXUStlSFlvNlJwOEkvaG9w?=
 =?utf-8?B?VlRsZGFOaFpQKzJxMkxDdVBHMVFuS2NBVU1WOHpoSUhxQ2V1aTI0cGhXdmFm?=
 =?utf-8?B?QnJQdkVPMjVMUHh2SENwT1pRTHZ3LzBRZC82TmI5bmJLNE8wemp3cmtMQzM3?=
 =?utf-8?B?R0k4aEwvbndxcmxPNzRoa3FTVitUaTFjaHQxSUVSM1RCQnZMOFdpc3RlbDda?=
 =?utf-8?B?Y3VFTlNBaTYySENBbnlLcVlVZ1poM3RpYmlGV2RkWlg1L0tIMHpncHQ1MmlI?=
 =?utf-8?B?c0MvczRPMnRIOUVCV3VEOHRHZ1ZpeEtWU1hVNmU4UzJOcFZxUlYyNTRUL3Fj?=
 =?utf-8?B?dnI1NCt3a1FzZjZJK0lsM21LMHBvK280UGxnUnovQjh1RXBSMGM3cVhuc2JL?=
 =?utf-8?B?c2tPdVFsSGZMcVl0cnVPUkNuUWYra0ZJTVNRMFh1TkdZUk9OcVFzNkhyOFJS?=
 =?utf-8?B?UEdqT3BxM3V5NGVwT2JCTkJaNHFhWm9LOEJlc09GK2hNaGRUUFJwL0dtS05y?=
 =?utf-8?B?S0V1Z2d2ekxRdlNZd09ITk84Sm9pR01lUlNnd1hRekp0S2FNelY4T2U0Y0FX?=
 =?utf-8?B?d1BGbjZmODdMZ29zS3RndkdlWmljR0Y2MldWN0dLL2NYUndHYWxuMzNXUkRz?=
 =?utf-8?B?ajBMd3d0dk5IcFBjN002THFlb2dvYzJxdER2emRjdXArM1dOeVRjNmwxNnhw?=
 =?utf-8?B?S291YnUrTWs5ZVhXdlJtTVFKR3hSVk9VWmduWWZGNi9oN2dlRVRYYTJsTU5l?=
 =?utf-8?B?YWxWYzA3Y2hPV1dnd3QwVkdJWU1pTS9yK2N2NDhKQVowd2hlVU5TM2tBejU0?=
 =?utf-8?B?VHBkSEVWbXZ5S3lIRW5sRm9ONzRtdlcrWjFIZ0lvSlVkK0dWU0traldaSEJG?=
 =?utf-8?B?T3hkTjVnRzc1cjRWVWRhYmVNYmtRa29Fb0FBRTB4T2tpNHI4MGhHSWZMbWxY?=
 =?utf-8?B?YVJWNkJTNDZQdlpyZldrVE1HTW42eDBOOCtGY3ZTSEltL3Q4ZlNHSlV4Z1dG?=
 =?utf-8?B?RnlvUUtRb1crRUtDbERKSDY5TEtLTVFTSVFSU2txaDAreUYrWXBRSUtNUFhu?=
 =?utf-8?B?SkEzZnY3NXpHWWlmclFtWFhTRDJEY21TMVBzY3VmL0JDWDdwcGRHL0ZVK1dh?=
 =?utf-8?B?UzlhTUhSVXY2VEIrMklhcSswUzhZQlF4eGJDVGFNSzZlMjNwMEdGYXFacUxX?=
 =?utf-8?B?bFRxVDdBa0ZKaU4ySmdBZGR4eDdoM0tDa2FvelhFajYvc1ZSQ0pydVVjVDdi?=
 =?utf-8?B?ay9PRXl3eVkwYlNSaTJxT2U5VlRIZEZ5UmV5TDR5TmNNMWZ3WENmY2d4Rkhy?=
 =?utf-8?B?a01DNnl2L1kweVRUdVh0VHh0eWVLMTdyTkZIK1crR0VuOGliRzBhU0tnN0E3?=
 =?utf-8?B?ekFVQ2hCYldsd3g4UWhIVUN4aFc3NFQzSTROMFpKektPMytRVHFKWUtLQnZH?=
 =?utf-8?B?aUVLNmlOT2JtR1AxRjlwUDU1TXlIMllLbnllOUt5ckhVNzkrTVZPNVozM3pZ?=
 =?utf-8?B?dStWQzErVFMrOG9ITmVoTFowditJWEJ0aE9hSVlvMnZsMWJMUVRBL3F3Mm5P?=
 =?utf-8?B?ZjJRR0N3M3ViMlNLWkJtdXFWTWQ3QmdidHVEV0YySm1EdDlwVU5pa0t0cFM3?=
 =?utf-8?Q?hFgdufUMolDRy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9YQTFxU0tyd3JvbmNLV01QOEZ4ZnE0OTFZVjBlZUFYMDF6SmVHWEFHRXNo?=
 =?utf-8?B?NnlOYzVjMEQ4SXFyTzZ2OFVzYkNudWFKem0zUWtyaXJWUGZNekpmdVY3OEVT?=
 =?utf-8?B?bkxZMlNGMFlMVThLalRLako5MlNnb3RQcDRzNUk1VURZOEczNmlSWk1DMUFC?=
 =?utf-8?B?dld1eVJPR1g5MVhNL0pYS0V3bDZQZWlycDFvdEJrRmpjWVlsZUNqc1hrQkZX?=
 =?utf-8?B?b2RYcXYzc1M1c1ZrWk15NHp3YUdGdkVOaWhpMDNzZ0xQVlRHU1plVGV5emN4?=
 =?utf-8?B?Ky9QWnYxZExoUjJJbVFNQ0xCQUd4bXpBVm9OSEhVeXhxNnB4SEtCbnA0UXRh?=
 =?utf-8?B?YnVWT05xYUNudUtIcW8zZldDUzlVQ3AwZXRaSU83Z1dIK0NqRUUxdEF1ZDdW?=
 =?utf-8?B?dHZtR3k1bmtIV2RCYmdyY1NQdUdHbWhURFJUUHZPcmgxRlpGRjNCSUV3NjE0?=
 =?utf-8?B?TlBFSHRXcEJZUWczSFJPNWsySmhJRHF2OGtxQXN5cTQ2MFkvU1VSaTZ1VnBp?=
 =?utf-8?B?VDVuNG9TRnRpQWJVMmZkU0kxSG5DbEl6dmE4Q2QvendaVjg4RmlRNWVLMmYv?=
 =?utf-8?B?SHVSK3hlZ0xQdzBRUEZ6eENwdzZXa0RWVFhsREY2c1hNSWp0a05kZ0FpOHo0?=
 =?utf-8?B?Vm9MNVd6cnFpUzBqSjVidDVPdWJiT2YybS9qMjFhR0JiU25XL0dXK2VzRjl6?=
 =?utf-8?B?c1VUaHhOU1o3UGJSWHBVa29vb0ptWVZlcUVQcXNKK0twU3dJRUc2T0F3VVhP?=
 =?utf-8?B?VE82UnAycUVDbTZYM2MwYTRCejgwUGdqYlprUlZYU0NnSmlNRUQ2dkhTUnIy?=
 =?utf-8?B?d3g0QmF0cEdIaFNUZzhCTFY3SEJ0Q0RTUFBaQ1V5dXNrVm43MkpVTFNVdVox?=
 =?utf-8?B?elpaZWVnTGNxOVlXU3lQTWl2aU95bWZvR0tCS044dDBTNkFpZmFWdjdCSDNv?=
 =?utf-8?B?SkFlVTRhRFgxamVEL0hzWEJWbGcvWlpVa3JhQjZsYVJGUDdNQWkvL0tTRjFJ?=
 =?utf-8?B?RjlNOExZS0MwN3UyQmYrWDJUY3cxcnozUFN4QXdQcVFNLzJNUlBueU5VYkgr?=
 =?utf-8?B?Qk1yc3RsRk1lYm9vMUVPSFZQbjJvV0Irc09uQVdWa21oTnhrYmRjekx6cWhh?=
 =?utf-8?B?aTlXYUhDd3E5Q09mRjlTK1NhS0VZSzJpaDNpMk9oNGgwNi82eGtpMXh6T2l6?=
 =?utf-8?B?NktwZEIwL0hNYXRvMUtET0RWZER6SUdqVk9IcDJuWnZkRXp1Ynd1amhPM2Q1?=
 =?utf-8?B?MWl4ZUQ2eVUrY3gyRUR4Nzg3eCtGMWdmZm1HU05yZkR0T2VqMDdCbnZyQ0Q4?=
 =?utf-8?B?YUgySVBVMzNBM3VadWh0YWE4eHFnTGFOWGphT1FUUG1zRzJNTlMyRm5aMU10?=
 =?utf-8?B?NDZITlcwSXFjYlRSQWpxeDE4dXYvTXRNV2dad0hHV3d2Z2FQelcrUFVUU0pm?=
 =?utf-8?B?Vk5KSi8vUHFvV3dZQ1kvd0NPbnAwdjBGcFBQSG8waVVHSXU3KzYwNEZqUCtD?=
 =?utf-8?B?RnpRUHova1NmTVljZXUwNm5obzlaQitGdW0rZkVlVEZLcU1ScUE0cjF3dFRV?=
 =?utf-8?B?ZHpkV2NUbktaRyt0TVZ2bmZERmRicE9QTnFuZGF5Z1VycU44Qmt4NmNvVGw2?=
 =?utf-8?B?aXQrZUtvY1FGaXNUNm9DVHdrc0FPMlY1TTNMb0NxNzEyTTd0bFB3Rko4Mzcr?=
 =?utf-8?B?cEI4allWM3I3RXBuQ1owSXZFQkd4cnNQTXFZN2V1eUViMDJQUEtEczg4WmxI?=
 =?utf-8?B?MUpXNjhLcDcxMUlxQW0vRUt2UWJrV1FmdXpDYiszbkxtWXo1QU5NVHlFd2Y2?=
 =?utf-8?B?OUZ2ZHlvSkU2QnJiK2twVXRLT0laMzg4Y2xJOU1NUDNobzVnWVRBbHdWVjU5?=
 =?utf-8?B?VDFONmVNN3hvaWljcDREMkt1MDRCY2tQRW9wYVV5TmVJc1lPWUtsZERucFlx?=
 =?utf-8?B?Z0FjamI1RDIySXN0akJUWXRNS3FhVzdDOENwLzZmMlM1L3ppbHQ0Qm5YblBx?=
 =?utf-8?B?MXQ4YjBWN3ZLZklUVXNYbzdGb1AxVkdYWVN0Z1BOQk9EYStGY25PeFB5ZmFF?=
 =?utf-8?B?T0srVHdRb3ZveTVEaitranB4bFlyemFGUnJjb0xLTEFieUdTcmdPbklwTk5t?=
 =?utf-8?B?R3JkdGFGWndoNWpNOGFWQlMrbUVyU3hkWE9KakFXMDEyYjBLbTNoczArK3V3?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e90a9c6-549c-448c-1100-08dd5d31d81c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:38:01.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EZpgzBpzyfomMXWx8sb8vKZ7dGxH5AzYKAuWrm4hRzBHXRF4SvWMx4oj1gmiJtYGogqW1IiN0MlymBTqu0tQ6IKBojUxCElrIZYH/YveRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> get_config_index() is used by the architecture specific code to map a
> CLOSID+type pair to an index in the configuration arrays.
> 
> MPAM needs to do this too to preserve the ABI to user-space, there is
> no reason to do it differently.
> 
> Move the helper to a header file to allow all architectures that either
> use or emulate CDP to use the same pattern of CLOSID values. Moving
> this to a header file means it must be marked inline, which matches
> the existing compiler choice for this static function.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

