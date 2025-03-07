Return-Path: <linux-kernel+bounces-550441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCFA55F98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3CB188A7C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23C1624E0;
	Fri,  7 Mar 2025 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaPvoHw4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C93398B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322412; cv=fail; b=DKmudNwo4vzIoRrKJ6hy0NiHoedL/9kx5KME82oUV9ivmkxkF3zmSPM53NmysMbrGR6SYQ8mjE6wvjV1oZpEaMld+Qyxsh4KhQuOjFqsfGAO5/R2psGmWKCC3+QEgjoGuQxkvlQJiVLAX+MOzrHP+tnhD39h7tqXr9KY69DwI6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322412; c=relaxed/simple;
	bh=MJlGp6RIgcNWvOCI3pXUnz4OId8cP2LXnBFvSMWVdg0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LuVgyihjgsI2xG3za/SwQ2FIq4NEvNNIt3TLYdG617flFlkoOXK18Q4BHVV0Ga/CGF6YjgIP2qsj9il1CUU/IBPYGMS4delj2tSdIXJwn1jVcsWlJDPQnUPyBWntO+C6x6WC8JDKbIWT7X0YSYvCWLmWxi01XPntLe0t8vjDaRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DaPvoHw4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322411; x=1772858411;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MJlGp6RIgcNWvOCI3pXUnz4OId8cP2LXnBFvSMWVdg0=;
  b=DaPvoHw44+iU732RV7P2hYlCW1m5k/hVNWtAyUgYEKmX4xhrkLvO2DSJ
   SgOkR8ItKhECttmeR0GiMaDtCRoHsgB2ecrDy4VbOtbQN5En4rOQ8nSTd
   T3s+zmgsGxm1487MNnDULmAhfQslaZzVzCS3olWqq+0B5Ex1yVazsrPli
   f+wmNa/nosDp857b9y1j/lyqgJYNx22HMRCzbRAU7mNEXjWyIUjssrfcS
   5PnPf15C9CAUdHDbP3OwcEBLke7utYlWYuhJKgDjyZnBKp9aDK5gFP38/
   /QhkbkwpE2VE/0gE35n5FCOIg9VMa2wLJefctB0HDvisYwMN7m8JAcMrZ
   g==;
X-CSE-ConnectionGUID: NOBMdYmeRC+h35RjQJEPzA==
X-CSE-MsgGUID: 6Svb35qKQX2pQU6+i/4H6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64802897"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="64802897"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:40:09 -0800
X-CSE-ConnectionGUID: +dn8CDtjQFeq3a7iBLxqIQ==
X-CSE-MsgGUID: AgnPANx8T2Cc+bteqgefFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124425619"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 20:40:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 20:40:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 20:40:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:40:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZPBUSzAdzX4BNxnmc+kP1kt3RUGE+aPjciHpWzSeiepUvBsoeS0DV20tb/z7tfsSxrIdODcqHAeueykqM3YgY7LeY/Chdjv4tCc/R7ESa60m8TsOb4Zu14FVEH+Mv8+oPzwosVhzVmII3kGPP9Q0O2NvsXwatMjmeuIbjyMjF9GOYwCp8o87S4f+EozyL5ZFaA2Kh5mmyMfIN3n5Rl/J+axAZ2IZU8E59xFgNR+V4dnXO1shorh/NNr6BMPvsm+Vjw7PvriKBYMbC7DV2ju59SSRmoWur1cDXlfmug52n1hVQ5YtgjLxk+GN++d+ZjwhXMQ9vubp37FEXrsJ3fq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ktrL343oUGCoUo0vh0QgoU26W2MsUQV4KwAPTA/oZ4=;
 b=xGmGgRo/jD4+tTWHjxFRqrcrb2J/QZS1wmiByda9u97r90+vnoCTTLG3zM3rkDOs9leGeVveuGYoxpsXX0EwIH1LWiaPh9yLdYzwsp6zVUvumI1vj51f6z2e7+tqlirWkUFOG+fEyAvdVc3ho7ICPA1/d7PbfL/q2A750qxdBIZg8KVFzQHdvMxBBPkPRFYRloGG32zOHj03f5RjvwUndOR6ziSTjxNIwLsMm+yZjazwhO9xMU1tQqYppUZ1QnYCVO+LZyi0s8p6afk5NKUl6jaC7Kkehs0TJQWHJmJL/1FVr9fgk7wi4qLVIWzQp8zO7G6Es3snc1nwPrDAdAoOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:40:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:40:05 +0000
Message-ID: <a1a64dd1-7180-4845-828d-0d327d29fde4@intel.com>
Date: Thu, 6 Mar 2025 20:40:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 31/49] x86/resctrl: Remove the limit on the number of
 CLOSID
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-32-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-32-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 6faef531-cb74-4c3c-4cc8-08dd5d32218f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE5zU3lVVGxmKzNTb2ZMQXlRMDU1QnkxRTJJQUJaSFpLWVRDYkNyWTNVNkRV?=
 =?utf-8?B?SkFqMzhWSS9NaEozR1BMLzFBZEFHNElIVkliSDhjSENBZmJxMS9RRFNka1hX?=
 =?utf-8?B?dnZKS2J0VjkvckNYak42dUpxSUN5aG9ObUVGMVoxVHVqMjR1cERMTUQyeXcy?=
 =?utf-8?B?cW4xYVF5S3ZVdzZtdVQ3UVhHV2g1aml2dlZWYW5rK1dJY0J2NitMMFRHa1Vj?=
 =?utf-8?B?bFdkYnBxdlRqU1VwQ3dvRFVqVkJhbDJOQlRJZnlXQXltVG5BclVRblh3aXQ3?=
 =?utf-8?B?bEppY3U4RkozRUdXSEh3QXp5OXh4bkNRbHFXM3A5S2M1RGpFcWN6V0VZVVVv?=
 =?utf-8?B?MkVkWjZQTHRBVy9UWXo0SVk2TGFFeFNYVm9OYmNwWDVqVHA5K3ZNSGF6dkhC?=
 =?utf-8?B?YnFZMmZRYVljQnp2WVZsdlFoVHBxbWhXK1pkK2daS2pOVnFkcTJiU29Na1lL?=
 =?utf-8?B?YUgwNnZGTlRDWlJLZkYwL1ZLcG9odWVUSENCYy81dEJtWG9LdmRwRXJKNkw2?=
 =?utf-8?B?dW03eW9ZaE84dnNnaUllaS9SVC9lTXZNVnpzWTdDSHh3UHMyc2hYZ1BObkph?=
 =?utf-8?B?UDFNWG9mY2Y5TGd3Q3RBSkV6QzdXcmF3Y1UvTWxZcnppL3VEQ3phOGM0TVJT?=
 =?utf-8?B?ZEM5bytRN2NWQ2loSTFvMm93RWo5bC9VRmlsZWZ3U2hhRXduSGVoUk5kVjFC?=
 =?utf-8?B?S0RmV2Y0Q3RHQkptU2prbU9hNXlIM2VENFMwUUMvdXJHejlodkNlWGlJUW12?=
 =?utf-8?B?MW1kSTlLZElabW96SlVSelNHdTY4L213N0dXaHo0Y3BsSlpkR2tibkxTZjJS?=
 =?utf-8?B?WEUvU3JIZStwSGl0YlNyclZTWnpEdHFHSlRtNUQ2djE1VThadEJOdVllVUZv?=
 =?utf-8?B?Q3gwUG5sMFR1MzZSZGJkNEFzSm9vZzhTbUxST1NUckFlNXV6R2lTbjZlaWQ5?=
 =?utf-8?B?bDNMZm5MUHBIVi9wR2R0RnQyeDBQakU3SkFCTFF1a0RXNGdtaTEvWDAwRGZt?=
 =?utf-8?B?Nzd5bmkrYjYxWFFCN3R6bXVySWRCUmc5d3VlVk9XdGlvbGt0dCtWMDNVTEZT?=
 =?utf-8?B?RnhvYXF5ckQvYytLVmU5ZDNEa3Zud3RJc2hoUitRL1V4c3huV253SmFkZHZv?=
 =?utf-8?B?blRtblBKa0k3UVRiR29iSkpWcm9VdnVDWjVGSDc0VXVQcW5PdTdhMCsrM1Zn?=
 =?utf-8?B?VmZlUSttcFhZSHpUN1AvK1Z1MnBhRDZhUFBqS1QxbHZJU1dFcDgrWVJwdmdi?=
 =?utf-8?B?aGRYeC93RG95bXk1WE9yVDMzbW52WkFMUldFdGV2TXlWMnVDRE96bWZNYk1u?=
 =?utf-8?B?U2RNMnFzakp6NDZRQStVY2ZLRlNURGZTMUluVTJraW1kNzRnd2FZdVUrTnVE?=
 =?utf-8?B?THZSOWlXV083ZXE0TXVsaGx6TXNkZHVsQVF4aVlMbzNndVFNOVg2MEdJMVBi?=
 =?utf-8?B?dWRtdUdxeGtPVVJtc3YrWkd1U3J6Slh5bTRiNy9ibTBSQWtvaEdtMWpBZndh?=
 =?utf-8?B?WkdkNVFSVVRHNkhLWFR3RGtZSjRQT0RoODlSdTI1VngxTnBDcmV3a0dkcjBX?=
 =?utf-8?B?Y0g0VVlFU05yZFdLOW93aHZuc05DeWU4dVFNU2VhWGlNTVhYampyb0tMRmJK?=
 =?utf-8?B?UTd0WkJiemVaMzQza3VkRkhXQjRIaEp2YUFSUmtyRzh6YnRjMVZsYmxaUWk0?=
 =?utf-8?B?Q01mNU1hRmJ4S2J1RmViMVZ3eisrQ21KVWdmTTgvUk9Ib25pdWlLOGNhRWJC?=
 =?utf-8?B?OVEvRTF2YSt6K25pNlE4QWFYNEN3WDVUYWRTdGZJN0QyNTlCZFBLM2VQMHVJ?=
 =?utf-8?B?VVBEcVV0ZS8zWWY5c1lmcjdTaU1iR3hBQXdYL0tpdEd5VUltY0JEa1dOcnJL?=
 =?utf-8?Q?6vxHzw7w9NuH2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVCTTk2KzE1aDN1ZXkrMm45Tlg5Q2ZRaUh0dkN3VXRnNndCbzR2ZFAxTHMr?=
 =?utf-8?B?MDJJZlFHRTd3MVNYZHVZWElKOFJGWVFZRDdwcXJicDlDL0pmVS9rampNVk10?=
 =?utf-8?B?bFZ4eXdaa3JkOWx0MHNpazVpQS8rWDVHb241bndHUFMyczNzZXpFZXNraEE4?=
 =?utf-8?B?Syt2NitJc0RPZnlCdm5BTE5ZSEJMOC9BQlBaZnVhdjFJS1E0L3BDUndoNDBh?=
 =?utf-8?B?OWJoTG1pZk8yWUR3L2hocXdBTG1ia2ZBVWFtOWk0VzBXekVoUDMrOXUwbnZD?=
 =?utf-8?B?a1lwNnlTbDlrTEEydjd0U0ZEbFpoaEFtdzE0OUFVL3RaOW1SOHhwc0pPRXBj?=
 =?utf-8?B?TmJQZ0lZK3d1RWE2dVJQNG5oODkwckNkNVZQQjlwNUtVVUtlZTZ6SWNTY3FY?=
 =?utf-8?B?U08wdmVseXkwa2VoTXRYOGxieTBFVlpUUjZWL3I4N3BqQkxYallxNGMzRnUw?=
 =?utf-8?B?OENoSzNDZW9JK2ViTG1jZGJxUTE0dDUrY3NVSlUxcEZNb0xzRC83RGljL0lW?=
 =?utf-8?B?MUo0dlBFRjNCSUlMaXdZdGxTbGcrckxQbUIzUERhNWxZSTlUUFBtRWZDNllm?=
 =?utf-8?B?L3F3cEloSThRZHlId3dPdzVzMVZpbXR0NE9uUU53bXF3QXBkbElCaHFsb1lU?=
 =?utf-8?B?bHdDN3FQVEdpd2lVY1l2TVpVekFLazBEb1daYThkOWxDSExFdEU0Y002RDlK?=
 =?utf-8?B?eG8xZ3JxQmRjNC9mWkVFZWFGUnhROElWRndGVDRsZHlHRUtJYVBQbjlPZnBx?=
 =?utf-8?B?amEvdVNlc2trRHJGR01OSk5xRlJDOFllZWZFbUo3QVo2WVV1YVpjRTUrQ3dO?=
 =?utf-8?B?NElqOVRVUmFaVWVVZUdQUlV6SEk4MXRjbzVxY1lGOC8yU3VMOFYxNzBiam1N?=
 =?utf-8?B?MHBFSWFud3RXUWRFdmtSMzRYcC85N3hvRkJPSGxERVRpVVpHVC9ZdEhOSkww?=
 =?utf-8?B?MjNpR3NrYW55UVZkVFc4M2hQTXFtTzFtb1JSK1FVQXd3TE1pTzF4OHhMSVpD?=
 =?utf-8?B?S09GMkV4a29HUW5Tb3FvalJTTkc4SmxPdVlyZjZHNURmMjR6azlpblpjVnZq?=
 =?utf-8?B?WEtadHRmVU1CbGhXVTEvcGxWaHgrd3Mxam51bmpuWTlDTWxjTGRHbzVOUG5l?=
 =?utf-8?B?N2h6M2hyVEhhallqT28zeUpLTlowYzVTRk0ySDVUUHgyVGUvU1Q4M3dHM1R2?=
 =?utf-8?B?aWo2VzhOd0ZRRGtXK3VUSkR3dVBBNmxKZVVkM3I2aGVuSmY3TERtS2lMWnI4?=
 =?utf-8?B?KzhrTGE5czRLRjNEdzBDblZGc3lpMjZzaFF5b21ZZmdvS3JsaE9DME1zbHlX?=
 =?utf-8?B?U3ZwRjZaUlI5VzdPbk1BUW5KeEtqTS8xSWhZa1o5dHkwVlNsTjFkZ1lPMkJO?=
 =?utf-8?B?VlFSbC9wb3NGemI1TmdVNXJRM3ZhME5CYTR1cTk4VTQxa2NCL3pyWWd3ZFQw?=
 =?utf-8?B?b0tNeE5uTXJTRHRoTEFNUU0ydm9jOHdHcjQzT3F5Y0NKOVordmt1ZmZXQjZn?=
 =?utf-8?B?WCtNU0JqQnFTY1JKZUlzbDdsMkc1bHRjWElud0szY2pzMVVobU1wQzlHT1A2?=
 =?utf-8?B?VjVqNlQ1WUhlbEZhaDVWSVRFc3oyNWtYTC9NWks1dEVVNkpoNEhwTkR4VUgw?=
 =?utf-8?B?MDQ4bkRoZXFFZzZCQWhaRzB3cWl3Z2dNMUZScGJMQkpWKzdRQjNsb3YwT1hz?=
 =?utf-8?B?NmxqanBnbW5RNlBnRGtLK05qOTl4TXE0QVQwaXczMDNHWUVGSWVGOStHYW9T?=
 =?utf-8?B?V0JycllQdnN4YWJiZEZLSXVnckpReFNtK1pzRERHb05MWElzOS9OVzZrYS9i?=
 =?utf-8?B?cDJialcveC9lNDZtWkNwOG1HMmJ4Z2FEeHFRNnI4a3o2WFB1SGs2bzI2N2Jq?=
 =?utf-8?B?Wm1wSUdMSTY2a05Gay9Gck45c0VLZWg5M3FOS3VXL1FmRHo0VlpIanpnOXBS?=
 =?utf-8?B?OWw2ckYzTGp2RHRGNFdEa0p5NWxWcm1qUFpJam1na3crbVhSTUV6VkV1R01R?=
 =?utf-8?B?VEREbytsdVM3cXBjWFBSR01UcjNHb0pFSFFVYiswMEd0Wm5tNFdLU1lOS1JN?=
 =?utf-8?B?RVlHUU5GV1hvSEtuZzlOd2NsWkt0MkMzTXU3NHorcUp6UTgxUFBCSUpOcXBV?=
 =?utf-8?B?MjZoNklSeEVuTjN4cWxuNTJRclVyMGVUcGgycVliRUI2U3lpeExwa0J4ZGMv?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faef531-cb74-4c3c-4cc8-08dd5d32218f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:40:05.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orLAF3xRt7PSG6D9fziuTRaS1mi14visEZCZuBhAKYnWbqnX2KZBERoxJxXVV/bdP+kj6yXkqZE1ZcvJHrN6gf+ghcxSsRqofNjcj/l5sJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> From: Amit Singh Tomar <amitsinght@marvell.com>
> 
> Resctrl allocates and finds free CLOSID values using the bits of a u32.
> This restricts the number of control groups that can be created by
> user-space.
> 
> MPAM has an architectural limit of 2^16 CLOSID values, Intel x86 could
> be extended beyond 32 values. There is at least one MPAM platform which
> supports more than 32 CLOSID values.
> 
> Replace the fixed size bitmap with calls to the bitmap API to allocate
> an array of a sufficient size.
> 
> ffs() returns '1' for bit 0, hence the existing code subtracts 1 from
> the index to get the CLOSID value. find_first_bit() returns the bit
> number which does not need adjusting.
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> [ morse: fixed the off-by-one in the allocator and the wrong
>  not-found value. Removed the limit. Rephrase the commit message. ]
> Signed-off-by: James Morse <james.morse@arm.com>

...

> @@ -3071,6 +3085,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  		resctrl_arch_disable_alloc();
>  	if (resctrl_arch_mon_capable())
>  		resctrl_arch_disable_mon();
> +	closid_exit();
>  	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);

Above is the new change in this patch ... I am trying to understand the choice
in ordering since I expect that freeing resources is done in opposite
order from what it was allocated. I thus expected it to be before
schemata_list_destroy() but it is instead done as the last thing before removing
the superblock.

The changelog does not mention dependencies that need to be kept in mind.
I thought that there may be something going on with open files ... for
example if user kept "bit_usage" (that calls closid_allocated() that
depends on the closid_free_map) but a quick test confirmed that
if a file is open then an attempt to unmount will get a resource
busy error. So rdt_kill_sb() will not even start while a file is open.
Specifically, user sees a "umount: /sys/fs/resctrl: target is busy"

What am I missing?

Reinette


