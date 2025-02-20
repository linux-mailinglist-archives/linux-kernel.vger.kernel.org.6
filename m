Return-Path: <linux-kernel+bounces-523010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415B8A3D0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE3B17D95E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F92524F;
	Thu, 20 Feb 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iojaYWyh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE21DE8A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030138; cv=fail; b=Ux94ixaZCbsqOcThK7NOt3M4oBjMQZY14ROiX1CaYsRdZIwCFsxuHm7obcNF4GeDMYbc3FnFjkR1Dj9tHjXBk0mglp6TKrlE0Tg+x2tDzzmBs/LkNQ9uWnn2rh3BYbaostpMvHlduzrUJd43WCDW6VyRR4IuE1yKN29CDi4KjfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030138; c=relaxed/simple;
	bh=dmwkgn4b6x/5SiidRFxjWsmmg3ANguRDP2eDsz/ecRo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NsAEmvMppRlHHJClCanoMAJ2EWJToYksCntoiSSMhauOxKflyMbzfpWqTuwlzy/Vn/JrN+jzaH4pH0uiZVqIKq/UFQJe2US00Mm0DsNDhRVT4o95QcGMvkk7CBx0eEATFiR1ORePssXjQCzIBxijlEIDibkHszlgqqI0U5+SNQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iojaYWyh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740030137; x=1771566137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dmwkgn4b6x/5SiidRFxjWsmmg3ANguRDP2eDsz/ecRo=;
  b=iojaYWyhVGRtFAuygntlyPvWOV+TObKxSlkc1KRNZcxsAxLk2DHvdF0k
   ruAEdnEEmhV2/d0xsMZwH/wOtrY5Nc0Wl/Lqajoh6pYo55RmLrGTprBZ6
   sBaJ+CMW8KNirOyl8bBd1mQWG5dxETHATcWmmcx1d0jKJOiJUHOAju4FH
   LiYFv5TTpGNKTY1SzReTHISZljvpqU0ASv1zrLst0K5WrVSZmRlzevABy
   /Yq8SHb0qgVTZDpE4aUJjsMLOCaSzdXkNcG20aP07RMJiSk1tIuRPNO0n
   I++m64zCxmtd09A3kLoB9tAyAEQ/Oqp758jD2yHysnLUaTjph0eQfEyN4
   g==;
X-CSE-ConnectionGUID: qPPQTZCDS3SyOvTPKr//dQ==
X-CSE-MsgGUID: Kf8ZOED2RBWFrkthf4nI5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51412860"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51412860"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:42:14 -0800
X-CSE-ConnectionGUID: OLhxCfnzRkqMwlzRi1mX8A==
X-CSE-MsgGUID: VEM7nI4SRP6a2fthHEgYaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115476758"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:42:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 21:42:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 21:42:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 21:42:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vslqGBD0VIaiYe2+GofC2oT5+D7WtydIUyXPUoy7p9tq5e6YQ08yO0hXKkZ19MwTdBZTzVTuDIqrVX+hapDgTTD+6v7LfNex8udrrFajQoTI23seWVCi5nwCUjhaV+eM0Hsio23KoD8vE5ez8nWnTIRw7XHyl8zfKt8u70pciiPPzG3iLUlXgQgEIC7R3fVa0RaB2i9I6xWdI37u/av6wxiK7J+NQO/R9GRQe3mHFH8GsvBMqv/9w5IHq6zve7OJe8x+qG/z6NjpFJG8/FfEjhg1I855HcVcdv1aoEEEypfm80kCiDnXxfQ+/9NiR3eezhi/n/4LSfyqp7KOVle4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cvVmhd7FOzzr3qPF8pxm3VtQmgAUrWjR8TdVFzMsk4=;
 b=JgSOFlFo3w68P2YY/Vb/zld9rghivvuvVhAHI+2pzMO9SGN1LM3etbAvnHlabRsh3oQU38YqkOMeSVH9dIUnXsedNO6GuoP2p4LUA6lXgq9vBiHq6j8bVroCMYPC3qKCH9jvJtv2B78BYKUK1c8cee52Ms9LbCdQd6dxSOAA+p7X+0bxTzN9NWHWgv/yjW7NeCIyJV8qA5K4WPikFPMROVw2qEcqVoF3sCqjuzjKezCMJiuX3hJgrnLCH2A7Y2udv+Tqp1KKGs1hpweSaJG0mSM/fKUSqNsSsMBijtN5GSyZIxiznvirZ6u1nIZs2FKyzfc5vORAWx6bEXkQwYt/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 05:42:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 05:42:08 +0000
Message-ID: <9c47b921-0c10-4092-8dde-3337a5f5a36d@intel.com>
Date: Wed, 19 Feb 2025 21:42:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 38/42] x86/resctrl: Remove a newline to avoid confusing
 the code move script
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
 <20250207181823.6378-39-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-39-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c0b6d8-164e-4d69-bb06-08dd517150b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlFtN0dLTlIyY3AzaDJySkZnS0Y4YVdHMm5UcjJ5M1BYQWF1TXoxR1pjVkxr?=
 =?utf-8?B?VTVFQVR2MFBEUllPTGlqdXpzWjRHS1lkRmpVMVZOWVh1WTJuNXl6R0QvVGFm?=
 =?utf-8?B?VytJeFVTZUFEOW5JaWRrYkE3NTRnb3BBY2lVaFMvbk1WSlVvNUZiamxsc1NP?=
 =?utf-8?B?Q0xsSCtOUUZPMHpjdGVsdnNzZy9Pa2FsLzV1QzBwS1RydEpKUzBKNDAxUjBJ?=
 =?utf-8?B?Q0JPZGJrRmE2SXh2MmFSUUd0eHo0emMxNlByRkh0bGRpaXpZT2J0N3I4Y3M0?=
 =?utf-8?B?blEvdVUrTldjSUV5c2F6QWdOaTlEdGtBamRVVkxJZDc5VnRJeUk5NmowNGlF?=
 =?utf-8?B?SEtmZUZQbXA5UzQ3a0xNRmhGMTdLWXQwYjVSR3FtK3g0MFFKeFRJZnBmRHVx?=
 =?utf-8?B?M2NEa29pc1FhVjltMDNUcFJUWWFLS0pVTnhCMmRiZDBCbkpxU0ppNVVjcjhS?=
 =?utf-8?B?TWdMOUUwVVk2QzFISVN3UERXbGZwNC9lRWNmaFVtQ3hGS2J3Qzc4U3NQZnNK?=
 =?utf-8?B?elpoUHZMdXZiRENhZEY0USsxUVpmRnN4b1F4UWhFYmNzM2lmdG9QUWpUdGth?=
 =?utf-8?B?eGM0U0ZTRjNYY0ZkamtrMFJrMW1UZ3E5ZXkzWHBpRE5WWnNTcm5uVVNTdVpP?=
 =?utf-8?B?NFB1d1VYd3d3dDRMQ1lTSjBlODNzMXFISlM3T3RScUVlK1E3dlJJS2MrYkxN?=
 =?utf-8?B?WFIzM3Vicmp6MFdDZ0VZRVRBY1RmSWlZQitWM044UmVYU0xOU3ZldnJQYURx?=
 =?utf-8?B?SU5RTEVZbDdoK3d6RHNHWHNId2NpOXdVS0Zwa1pTSTF3TlV4LzNCUm54RHFM?=
 =?utf-8?B?T0hyNVVaTWsxc05KNkdOU1hBMWlrTktnSnkvY3RHT242czR6QnJwWjRzL3NZ?=
 =?utf-8?B?UjRySGlIaWsrOExXMmZEOTVDY0I0NWRMSEdDR1dzOEh4YmFIZFpkbmk0Z2da?=
 =?utf-8?B?VGtqMm1tQ0s2dXR3b24zRDg2QU14MG1xWW9oR1YybGd3QmdPOUcrajMxUkdn?=
 =?utf-8?B?RUVlQlovYm9nVnJmTkhSOEorQ1NrNFl6VngxVHhFTkYvMTlnMFZiUmxLWXB0?=
 =?utf-8?B?cWk1MWViVUtMR3RxaS9WN3czSVhqdEdibFZYQWk5NVR4Q1V3blRla0JUYjJC?=
 =?utf-8?B?Y1hhVVZmdnd2bjlaNEIxQUF5bXhmMGZQNUw3d0N6azlUWE1neExWVFVaR1Rt?=
 =?utf-8?B?eHEwTlhTazY4bkdMSzlHeFFGQVZBREZLUjhJVG00akxiN2RrZ2tvYzBhcWVZ?=
 =?utf-8?B?SFhiR2RjcWczdmlBd095WmtiNVhuK3RDaXcyeXFRNTVieG56Y2h4cVFGcGJr?=
 =?utf-8?B?MllmVzdZakhGaGJCNXhDZVJjOHE5Y3JlQytqQVlCRDBjd1NwTm9vdjBCMGNW?=
 =?utf-8?B?TXozWXlxUnRHYU50TkgzTUZwZUVEQVFqa2Z3c3VkeXFGQzc1L1JXMkZ4T3Ev?=
 =?utf-8?B?S3FybGtWdXArYVJxUVlPOU1HVUF2cnV0OGFVYUdOME5rTVVZVVNDL2Jha21k?=
 =?utf-8?B?bEVXZnFyWCtRVGhPMTJ0c1hwa3dZaFJxUXVZMEk0Y01BTWlFZ0tvQy9vcjEr?=
 =?utf-8?B?YUErVUlJM1QxUjRNWmpyZmRPYTBoYjBOTnBGaUk5cE9SL21iZnhOMTJtV01W?=
 =?utf-8?B?VkRSdk94Zlo5UGgwVWtWYklyQTdUSUpmd2JwT0l0ZXRoT0hLU3A3TEc2VzlU?=
 =?utf-8?B?ME9pU05Na3BqWERDVXh5ZnEyUVdRcFRmSmJ2MTR2NHNCaTFmZVQ2dUQxbGJS?=
 =?utf-8?B?MnZIZ0lXRjZPZjRZRGgyd1JVMXQ4VHJEMk9sOVJ6RWRnM3FnT0ZRc0o4d3Mw?=
 =?utf-8?B?cG5nUkJDN1hReThZcVpvM3YyS2FNeUFpZ0ZXRFZLanRqaFBGZjVxZTlNUVVm?=
 =?utf-8?Q?7NFuXrtxP06P8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhVUVhZL3hUaldhVVBucHUwQjBjY1pOckdBUDVRTlo3RjZBYTJzSzdxU29V?=
 =?utf-8?B?SHp3cnhDWWx0NDZMTmV5b2p4d1hNdkVualhwNnVpcHFMSmFIcGdJa3g0bndi?=
 =?utf-8?B?R3Z6SSt3WUdCQTJxVzdNTWdva3QvMXlHUW43ZXdyRUhwT0dRRVQ4bVNFSHEw?=
 =?utf-8?B?QWIwbDBhTGpYOFg4YTRydFFKSGRYbjVNRnFkNHdpNE5zVjFkTEtuZ2hJaGVQ?=
 =?utf-8?B?K2k3Z05zSVJ6eUFCdW45L2JkUXBmTzJwUmt2UVEvcW02V2ZGV1hCTXl4aHFw?=
 =?utf-8?B?dURLa3lUY2gydlRNSFJyd0FpellNdktOZVBVS202NCtEdEY2Sk91TW84NlNQ?=
 =?utf-8?B?ZXpZSUdQZkJ3R1FkSElJN0FZUlpubGlzcW1GY1BWaDc3TnU0eDRZSWR6TDlG?=
 =?utf-8?B?SlRMM0VHQkhQNU9KZzZINW9EUTJONUJMbGRHMkwwYWtEVDRMcDhsbHc4VHFN?=
 =?utf-8?B?RWFnYmRwSXVxUEVHR21JcjQ4RXBaNVRvUkQ2T3I3Z092YW1hMzQ1S2Y2eThp?=
 =?utf-8?B?YVdiZ01mRzJtdTlpcDJ0Sjg1QW51WGRnSnRPWjlVcC90N3ZSYm96OHdlNFZa?=
 =?utf-8?B?MkRNVGtWSEdTa0oyanF6T2pra2pHNGl5dmdFcFUveS9iWjJZMGw3eHlKNmdN?=
 =?utf-8?B?NGJXZUNWL09DNTc2eE1sR3U2S0tsQVE0Nm5UMFJENWMyNkI3ZGpwQ2FreE01?=
 =?utf-8?B?OXlSS2NUdFJ1Z01xUW9QRFovK3Erek1RRi9IRTRCRWYzUnk5MVlpeGFpNzdT?=
 =?utf-8?B?MjN2Y09RNFJKSDlySU1JQ25vUDdKQVdSNCtjbUNtWTU1YWg0VGN2RkEwcWl5?=
 =?utf-8?B?Q0xvRzVVWTZvOUFPWVFUSEs0OVRhMWkyc2hxVjM1RkxzUWpQR29IdTUzaTNH?=
 =?utf-8?B?NHRxYmVMVGxpNTRPcVp2TkowRGRiQ1NoZzhIVmllMmNUNEYwWDdqOUVJZm50?=
 =?utf-8?B?a1NRMHViQ2NtYUJXTFIxaGtFeUdGcUwyU04wK3RJcGlJNFJHRDVCcDVLVkxB?=
 =?utf-8?B?bDg1eGFGUzlpZE9meFFZVTVGUDRyQXFJOTZwK0tXSW83R3pJdXpyNVJyQ3FI?=
 =?utf-8?B?dHdCNWE2OTdKcnlieTQ0VWhHT01BcXZQNmJSektGSktPbGpPVDdNUmZ3Zytw?=
 =?utf-8?B?ckIzWjhqbEJJOW1pek1uNlkwRTFXNUtXUHpBd08xQUNidW4zTGZqN1o3SXd2?=
 =?utf-8?B?OEpFSFhiUExUOU5zMThaWEtCMUJjYTJhdCtJeDJKc0poMUVPRENIQUpybklQ?=
 =?utf-8?B?NG5PTzNiMDg4ZURQSkFpd2J1VkZ2dWloNGQwMFZTeEpsSHlwdVJFVldCWTdD?=
 =?utf-8?B?WmdyNVJ3RlZXNWxGaHVBRVBvbUpPTVBxOGJCaXU0UlZzYWZFREtxV3I1dWJJ?=
 =?utf-8?B?elN6aXFBMjA1TUJMdG4wQkJtK2VYN3NUMVhMWlZ0QTlxMitsemFsWW5FTDlC?=
 =?utf-8?B?eHFZTlpyODNIbFZrRGp2TTg0bFBNSkI4S3hmL3EyUWVnYW9sUnE2dXBJWFg5?=
 =?utf-8?B?dis1dk9WRXE4aEd2VktWbWhYbDhqRGZQb0RCb2NmOUM0azJicU5BVDh1M3V6?=
 =?utf-8?B?MVdPbVZJQnE5azZ2emIvdzlKdmJEOTgyNWhjeUV6dFRCOWRRYTBYMnJvOWhv?=
 =?utf-8?B?bW1HY1NYZlJmLzZldzlROEppdWxrMW5YTVJ1V2JNNWtybWFhdHlRaVBwanpy?=
 =?utf-8?B?TUhQZ0g4U0g5Yi84UVpETGJxZS9sKzRENHFlQzlTUHFGTzlkL2luSElxLzBF?=
 =?utf-8?B?TUFpeTJoRzJFaVl5QUhhSXVKcy8zaDlFaDdUU00yUDJEd3hSSTRFVDBMRTlR?=
 =?utf-8?B?UWkxMEpHNDdWQmx3Q3pDUy9yajdIRWd6SkdIb0NDNzNJTWFONDBmVlJabWp4?=
 =?utf-8?B?enI4ZHhuQ0JLL3I2eGg4RmVkZ040RnNCM2owMVNiRnMvUWxNY3ZzbmhvQzVL?=
 =?utf-8?B?QzdOd21HalloU3RGeWVKZXBLcjljL2ljMG96NEkvVWRpRGVseUhvZTBrSHpB?=
 =?utf-8?B?aTJLbytNbFV6c1lOdHdPK2NnbzFDYUdXZVlZRVFjcE9VWjlRV2FxZEJCcVRG?=
 =?utf-8?B?bUg4UU9oaTZhZ0ZlcG16TjJ3SENSdFgwS3ZsbE8wSUk4NnRIcURzcTVvOTAy?=
 =?utf-8?B?d3Z0dGF0WG1QOFIzR1lOQ1U3TmhTdXFSZCttM25CMC9XSWRMOUFZekwzdlNa?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c0b6d8-164e-4d69-bb06-08dd517150b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:42:08.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymNJtXDApl1X5xvnL7vn4HRuBh2PwSHd6BzRMHM1HMnsT4heHp+vJMfVCEHMPepUrHSru9lhgAm90beOpxdCweUIM9lCA+p6qqMCe1FuA/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> The resctrl filesystem code will shortly be moved to /fs/. This involves
> splitting all the existing files, with some functions remaining under
> arch/x86, and others moving to fs/resctrl.
> 
> To make this reproducible, a python script does the heavy lif^W
> copy-and-paste. This involves some clunky parsing of C code.
> 
> The parser gets confused by the newline after this #ifdef.
> Just remove it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


