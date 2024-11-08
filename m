Return-Path: <linux-kernel+bounces-400854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258499C133A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06481F23198
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C75E3D6B;
	Fri,  8 Nov 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5F3AIQl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCF1BD9C5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026170; cv=fail; b=AbwZh1DE1kLZ9JHujcY/jkh9dV5pBzJpUUd89avc+8uipISFsaOvCmEZK5WmL0iLfSCXVAX/HfHnvb0zRsOLy99MHyYbJxZr1GFsMu/PbNmhECsuaq3as5Zv30lfGgdyFKm/TW5gqlHxWH317orPzTlyOrP3T4UrjJuur+3WkuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026170; c=relaxed/simple;
	bh=lVxuMRj206XRQIBE8YnFSyb155ktRxOMAa+MTCT4Feo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nB1xBJL3xa/CfC4/F++tMH1FwlJbax3bLc5IoSdOPhhayjYp8is42UZvXFhsN8WWf04ls1zlfHhgQ0Gsy3F5OoJHjW4Ya8AykVFd2ZwG5LV0zujLcAM58xM8EhTawcoBATu41HqTRexEqI8ZfyIeBsPY4VXT8mYQIAYIQhin04g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5F3AIQl; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731026168; x=1762562168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lVxuMRj206XRQIBE8YnFSyb155ktRxOMAa+MTCT4Feo=;
  b=J5F3AIQluoYXBxaiD8UK9+m05QWGRt6ela7D94FKM8PuC1CkIRCy8QBF
   wkzwVLHdRZBP+vpIWo0laPk57fuKXlQ+05SYkP0x0PyaeA+PGTtPPgw+6
   nozaL4wb9zCa/sIpijAXtjYBelqin8K0d30JUsav+BgpE8iJOS20EW3XG
   HpH7L4XP+Vo3cfKui6r0wyvOeM3E2G9E2QNxJTkHCo82BAcxWVBw8bXel
   UAK9tC5N9Cb9kUqZph0g5idzjipdW9WVxrPLuKctBRSDbfGtaWz0+uGQJ
   YRgz0raxGJCO4++zQJqziEwEh3u+qTseBaRrs0hemXm5fLXX3OefN2DWG
   g==;
X-CSE-ConnectionGUID: tEIBYiddRR+gizycS/ysXA==
X-CSE-MsgGUID: N3DdokjVTTSAaxGBx5cUKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30299540"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30299540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 16:36:07 -0800
X-CSE-ConnectionGUID: PrLx3AxFT9uGNJ3i5exxVA==
X-CSE-MsgGUID: nWpt3ZCWSTm7RtSFtTbFog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89243406"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 16:36:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 16:36:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 16:36:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 16:36:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVH9nk1wHTwkyyJ8zhtRRhfTgSSKBDXQVLB1VlARAcItPM8vwIsaeftYQVEbTfwDMKuwMYlzY4Ri63JCjKCtcCRjMLx/qDBQ+xFvSZX/sFi1ObNzr7n6alDBszNcLTeoUOFzQp5NU4pZHverExgBzzB06e4J2PXPY9EUsN4vHgjL/xfqYu5spOGxTc2a8tKv56vTY+Q+ns5oD6cTk+kFXmDf/MFbgnWS4D/uQ/ZzFPU8oIpP8Rblrafgq4yoiOHpcG1aMkcx5CtsIlDb86DNAeZ/dHxGNpMdbiQwgeHHh3xjuWcwb6ZaPY8coWChHYyxkKhfaziga3VdCmPqKpfVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DJmj3L7lc/WHOnE9j7271DuEdp9MAmWNoDTalhtGvM=;
 b=F5Tkpgfh6nUd+T+zE+GrqicKQ3lJ+jL930q3VWA4rutE8VmuZ4vDiu2VBsrcMCPy/U3JCGjCz1v7Mxgme7zGXY8xLSO37c2/VAGwup8ibLMuqYOxoWLpoQSwFxVmrmaz63aTQO/EoQ5BlzFYWgN4sqrPeFaWFTIRwIvKgqTLwobJjRH+MTqYK44zL9bo5RuyrNS301Gb/lkQ/wNIaLSy2LAO/reD+kT3slmFWTn7WNORIgaqvy8krPG/w14IF8SG007H8Y/3Obo3+s3YljiDWKk0wMPHlWCIPP6hH2tYmmAY4tIbSTCP+d6AAsYw2ge2vVz+RGmBwQI84yGtviAZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 00:36:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Fri, 8 Nov 2024
 00:36:01 +0000
Message-ID: <5a42aca9-ff38-4fb5-8eb2-a43262c8c630@intel.com>
Date: Thu, 7 Nov 2024 16:35:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
To: "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
	<x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Sean Christopherson" <seanjc@google.com>, Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20241107233000.2742619-1-sohil.mehta@intel.com>
 <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com>
 <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com>
 <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: d01863d2-e61d-4e1d-2d34-08dcff8d51d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NERxTW03K292dHBKMkJEZS9VRzc4Q2x6OVh5d2k2TzZ1MGpXeVMxRXR5WXdK?=
 =?utf-8?B?UU53MnNmZm9hbkR6VjN6RUhFSmJZZVlxUEc5UG1tbVRsVHFNaFRRaWZuWlYv?=
 =?utf-8?B?cXJjcXlJRVE4b08wUXFHaUJWbG9jdjB0enk1cGZpNklUYXNjWHBMMlNzVXpZ?=
 =?utf-8?B?cEZzcVFkRVMzdWVydFg1ZnBseTZIMCtmMEZVMlBmUjNudzJyWXhPblV3Wklq?=
 =?utf-8?B?Q0lLMi9FNEYyNGNRWGkwMmZJVU9JbzI4bFhhaUdCSDNjRUlyYjNrb2tTWEhv?=
 =?utf-8?B?dnM0QnMrSWZtdVpLNWxINmZic21URm1WUkVhcHpzYVZLcXNzaDBwdlU4UUZD?=
 =?utf-8?B?eWc3VnljSEkwL1Rjb3BsOWZ3dnZsem1UMkUwTnZDRjFjbUttVzlSaXJwa2Ns?=
 =?utf-8?B?ZTl4REJKdFRFb1FBQTE5T1UrWFhTdHl2L0VaZTdZTDgxdEhqWUhveUVPU2pM?=
 =?utf-8?B?Y3dUcTBMSExuT2hFeHBheTRjbmtUMTZWTG8yWHg0dTduS1ZOY05HNXowdW96?=
 =?utf-8?B?c2wrekZaNWdxSHl3M0JWeWc2bnd6M3d4U01oMi9CRyswUERTMjFPMmxjOTY4?=
 =?utf-8?B?R1c0NlVUMjdIMzUza2pOOFlJeUpCbUQ0ZlZvM2hMbElQR3kzT1poanNqZFQ1?=
 =?utf-8?B?Um5kZEVVOE5KWlJIbC9BSEhDOFoxakticmZUbjZhNmU3R0tkV3A2WUdFRE1a?=
 =?utf-8?B?M1dOeGNYZDkxOEdMT2hsTkVuZEFtMTRmZUI4Q2hMK1lBeW1mWUM1M242NlBj?=
 =?utf-8?B?Y3V4TEZEZEpqVmRiQlFielFieEJ5V2tYQnJNaFpQSjgyaHVQelkzTDJyOVp0?=
 =?utf-8?B?YjRZNUloeGYrUnFaUHFTanZlbWlUQjBUWEZOem1yd3dXWkh5KzJINU5tWnV1?=
 =?utf-8?B?Mll0ZWFaa25zT21qaGw0ZW5QTHpEZ0RqZWxTUzZYSXR5cDZMRy9aWjhXV0lD?=
 =?utf-8?B?RnF0b1ZmK0J0ZU5DZkUwSHNKV3phMkxxNkpLenpKbSthTzYwTzFieGNiMjEw?=
 =?utf-8?B?enlDc1ZCci8xTU5IWFdOeFlKM1A0QmRFK2NPWGY2OUUzWXk5WmVjb1dWcC84?=
 =?utf-8?B?ZGR0TTRoMjN6M2lOWnJqOGRlSWtUejJ5dU1OOFU0bEEyeExIVzFIYVA5SVI3?=
 =?utf-8?B?VjZ4VDRVeE9hMWl1dkFYa204WVZmTzhJclpKaDM2WC9KVWpvdUw2elZpRVVo?=
 =?utf-8?B?N2xBc2F4TjRUQVNzRDZ5Y3E5QnIwVng5WWlQc0xmR0hudzRMTkZIUDZObita?=
 =?utf-8?B?dWJGamVRakRHTEx6NVh0bm5Salg5c2l4SmJnR0tDRHQvRzFyWkI0Z2VNa3Ji?=
 =?utf-8?B?TjBncmNMT3hYN0NWUzZMdG5mVERrQTFUNm5oTXhtWDhhV2NoNTZvSUY1MVpF?=
 =?utf-8?B?ejVwUklSQkI3aHZFbi9JME1Xd2RqUFExSkwwclNZN0dVd0loM3dhLzJMcUtW?=
 =?utf-8?B?K1U5VGVFam9mRDJKMXg2TVBrNUZNaHZiRHFCaEszdFZNbVYxbjJMa0w1VkFl?=
 =?utf-8?B?dkZTRHVxc3luZVhuNlJlNUtIcS90Mm5URmFLUktPM3hYak5MdFlYa1VUQUU2?=
 =?utf-8?B?MTh3N3VTNjlqT29pRDR0dHRaK3dHdnhnei94OWRncjd5Zk5QbWQvQ3A0V0hT?=
 =?utf-8?B?V1VYMW9IR21JOVdzNXNBNXl3M0NjNkxhQXlsZm9HMzhBZFNneGtQVmpoVncv?=
 =?utf-8?B?Tk5jWVdOTWlyQ1ZJRG5WU0NzQURaOWVnY1NOVVhuSm9yU0g3dFFEa01kdUN0?=
 =?utf-8?Q?L8hwhqTR/11YbkO5js/lbGex66ETG3LYzgcNSng?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUo3bEpZQ0YvMTRPbnpONUkzWGJGYU5leDdWSGdOdnRuUmp1ZVhZQzBnY2xL?=
 =?utf-8?B?WXlOU2laOVRUd2I5bXkzRTh0WEQyRHozQ25Ha2krTEJGbFVjMDN6VDZXdXBu?=
 =?utf-8?B?OVRnL29keGI1MC9rd2hscUdHb1BPaUpsNlBvWU8yTy9hZDhDUjFkdlhrTHc4?=
 =?utf-8?B?dzBVMDNiQi94dU1VWlVuZEtrRVRPNGhjbDRaUVpxMXREZUcrRnJrQTBuU3BS?=
 =?utf-8?B?VEFFTXZpaUc3REx2aWgydVFjRXhWeStNTnRlY3BwdklNNHEzdHN5TVpjVkdP?=
 =?utf-8?B?U1FuaWxQMENROGxkMTZJV0w0NUg4WGNFeU1EdnNCaENnS29ZUHBGZUFIdHRG?=
 =?utf-8?B?TUlVeCtobk90L2JXNXk4em1QMXhFNWRyd2FPUjNzaVJiQS9BNWZaMG1GQ1Fr?=
 =?utf-8?B?TFk0ZktLMG9RRUgxL25wOWUvYVdkVlRDalQ2Lzl3a09zSUtXSmE3WUxxNWRw?=
 =?utf-8?B?QUhuRHNwTnlUd3lmazZ5cTIzUkJ4ZXk1U2EvRUZMdUs1VVlSamhRQVpWRFZx?=
 =?utf-8?B?SzF2aXJyZmtFVFYyRmN2NFlmSlp4VmRLREVnalljZkVMNDhoei82ZXRVTWNs?=
 =?utf-8?B?cW5TcUd0dENRVW51eEhqUVN1eG44V1pMRFFMWUNKM2J0SjI1N1dMS2ZlQ0s5?=
 =?utf-8?B?Q2VKN2FCNzVwVExNUjdNbjJVVitmN2lKNWIxQTFkMVoxUkIxQnNwQUFERytx?=
 =?utf-8?B?UFNmTWZFbzllZlRDVm04UnNidnEwT0VjSHZBaDhrcW5mMnNDNnN3aS95OE9H?=
 =?utf-8?B?MVpFSFlLMWZmN2FFQ29sRUVvY3JCK2ZYSTBkUHV6YmR6aUlnY25UcEFERnJi?=
 =?utf-8?B?T3dPNkZ4ejhiTWtwZ2hPS1JNcWVyc3VmWXNJcEJkd21reStjaHBCTUV1S2Y3?=
 =?utf-8?B?QkpFRDF3UTNaY2pXQ2RCcFp1K2lSSUxnalpkbUNMV253MkcwT0VOYzZrNzJk?=
 =?utf-8?B?dzd6aDFYd2ZYTjFrbitsc0poZERiY0xqcEoxQWNkZWZuYzVHQlV6QmNxZmk0?=
 =?utf-8?B?QzVBNkhUSTMyUlk0eW0wVndackJFN1V1QndNYlluZ0NGd09MdTRvRy94RFVp?=
 =?utf-8?B?SldJU3YvNXJDVnR3Z0VIZlplUTduY01qWHVYam1UdmxlVE13Vjk1WjdFWm1B?=
 =?utf-8?B?SG1nVWtSbWxaL2hZZkQ2ZW5hdUpnM2NaRkptKzk4aGt2bjFLOHA5NTVORWxx?=
 =?utf-8?B?L1pzS1dYZnNhQUdxU1QvNGZ0bTVLc081bVZjU0RSeFVkNnBEcTZXSzJRRHpT?=
 =?utf-8?B?YmkzSjZTa1RQWmNFcmxUMGhoTzh2dzZKTkF3TEIva01CbXFOKzllamtRS3E3?=
 =?utf-8?B?RFkxUG01NklsY1lhclAwYmMzZXhZN0lrTEJ5MTc4bW13cjR4RC9jRTBrWWo4?=
 =?utf-8?B?KzhGUGxjZFBheTdaUmxUeE5KWmZnTk1oRG1ucUdMZkdXajFNMFJxNk5paGJG?=
 =?utf-8?B?SW9ML0Q4eTJZckdIdGh5ckpPYlEvdmcyYVVVZ2lLSmZkdGpaTi9SVUtnVWJn?=
 =?utf-8?B?NEFodTg2dTNCZSttSWJEY3NZYnkyL0gvcm1SRVllSUdXaDc4SHMzWmxnYU1q?=
 =?utf-8?B?NVAyNTlMQjE0SXVCem5wY2hCOTJ3em9EUm1Gay9KMkZOcTB0Mk4yMXY3R255?=
 =?utf-8?B?ZlF6cnpKSDBveDB3cG5jckJYZWZ6Q3NMWkNzTUlmMjRvT2xQZU9ldlRQMnp4?=
 =?utf-8?B?RzZ5VEJDYTE2QlhsOU9KT0sxb1paTEFHd09MUXFVNDZzUGZhR1NEVGQ2b093?=
 =?utf-8?B?dFFBTVNXV1JYckg3cW0vVWxxZmRKWXNYWml5THA1SENnY2FpRVpqRTZicUtp?=
 =?utf-8?B?eXh3M04xZGVQT2VPV2U4YkNwYWFlRGJvMnBDeWRFa3NJZko0b0lYSytZRU8y?=
 =?utf-8?B?djNlNVFPM0UrdkRoZCtlMjg4eVBhMk1IOUxYbGdWZzlodGhQU1E4dndsZlho?=
 =?utf-8?B?cG51eWUyVkhXSjFjd2srUmcxNXBiWXpxOElTTEMyUEk1NC9Pbzk4TjAwbDlY?=
 =?utf-8?B?U1d1V0hzQ29VVjVFakk0aUpGWkIwdjJpaXB3aUV1ckhWNTZnSjBmc0FTVlo3?=
 =?utf-8?B?RXpqNWVmc05OUTZ2QzRVMVVPQlRJSHlvQm9TYTlCWjhBRUFBQzNXZTVRaTNY?=
 =?utf-8?Q?fgS/9Qyy0PSmifv0CNWlZqPYf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d01863d2-e61d-4e1d-2d34-08dcff8d51d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 00:36:01.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBL33kNKrFyiwfY7SAm9ZucMn6zrHyVB3zugOEiYiHJPUgDes5Y7GproCmNt+iZ42BfExcrZ3+5EHIK1xm5xPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com

On 11/7/2024 3:49 PM, H. Peter Anvin wrote:
>>> -	if (c->x86 == 6)
>>> -		set_cpu_cap(c, X86_FEATURE_P3);
>>
> 
> Be careful - these bits are used in module strings and so modutils need to understand them.

Sorry, I didn't understand this properly. How do I figure out whether
these bits are used elsewhere? Can you please provide a pointer?

Sohil

