Return-Path: <linux-kernel+bounces-368425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B29A0FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93641C22D55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC5210193;
	Wed, 16 Oct 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu9gyHpy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C745008;
	Wed, 16 Oct 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095974; cv=fail; b=NWdJ+ot2G1yBMn/8fuZGHIXmkLZR/j3+ahxGTkemuFohkuob3qOylb7KanPYy6ryzAA6ILfUqun6ixTsKt4JTywVEHdj/rAfyrAr3vwMVw4TMr2IrGTbbZSBon1AeQsfSHVGkHTSUgyroBIlYCyjnPHgtdco+Bp2kygVJb48Occ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095974; c=relaxed/simple;
	bh=aaIzaBMO47Yj8Dap1c5uuQcRZa7HklVBVePCLcDaoZg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUM24CgnlhwfkmavsmX5QUaf+ZrunWW4jU8oZsIzV6S/AUx0X8DpPTAU20iZDbltbNaWIM9+iafYuqdOb1YD6t7epfqkBu0yJIYRSxrB23cQrF8zPY8IqRWRKGMBcCCL/fbUlbcK6gc/QkP1+S9OBqxQ7IQxx/Oyle0saGg3Ht4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu9gyHpy; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729095973; x=1760631973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aaIzaBMO47Yj8Dap1c5uuQcRZa7HklVBVePCLcDaoZg=;
  b=Gu9gyHpyEjbcnvxK7WfcqSW3CupnBD64wzCsBxTnTrObNqGoVy+ZF3Hk
   RVVet4z2DODdmNLjmvJOZWD9WluVuCcEIBl6j9HXrWg8oqg/R8huSGhHz
   RfDWzAj4IZYdWQDs4/4RdOkxC9rgT0aJzU2yt8pzWZycnF4BgHmubWJtG
   JK8J9+4Un9JX5QMv7gxHfaqtJUI6oFUSQbztQwK6B0R4//aMtcLZnQ3dj
   +FsKsVybGTtfeJya8qUidiQxriqBLk2IY0hWRVSqlnSQh6+UZJFUGBel5
   O4+EMa669JIeTUE770EOJdGEREVJB2jZDJxWtanCh7ryYH4WMmmbMCjaS
   A==;
X-CSE-ConnectionGUID: 9I0qhwJmT1q8h5TrWP6HEg==
X-CSE-MsgGUID: vYird5MHQ7ezvOjCm2horQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="32355343"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="32355343"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:25:56 -0700
X-CSE-ConnectionGUID: 0p/yHBxEQgGCqevNwwN6wA==
X-CSE-MsgGUID: uePATqvFTnCJmyTOmG8C9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="109026939"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 09:25:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 09:25:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 09:25:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 09:25:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 09:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpKpL46dBYvDXmjOElOd9hLyjbziiIKJkpK/MWV3jmdiFKtuPSjVQvJkxIrPltjjpC1bBv7ixsdUmkGULRjUjfGHlbsNBzX2GDOBc11fRSqmth/ZHaDBGmXk1tvlqFbYdYIF2oYZ73b/UxzTRdU277Jb+WQpNxqDTnMkyVtLyDTTn03GnUk7aacqDJhojm/VkAOnjnXI0lRIagru4tm7egmIFK8J0b3vTh5VzTG8Yng5A+s4FBeUkASipjgmaXxRdL13u6vUh03Va0UUkr/vcVwqNjSwoXchCBpD88uKplPcLS1FGRDD5DxobovECk+yP+ts11jseL7JLdKcOKVs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctt9Crat8Y3DMv9rVcAl6AB6/awFVVpmYJLhXjRxEBo=;
 b=Bj6OvYyfMNTHhqFFKTaUaywuTB5U/7nWIBvG0avDTAVR2J4RRjuVpa5fYiyCF4iffUfgvIIZsMUeNgQYKa1hlYoyi7p+RW4uyd79lpJKaOifJtSVG4cP0mZxO3HMQi5XUgJ66WyGT+WT37cOQGxyOiqvavwS+nly2JcG6/nroBcct8ciBDjof13LSOKpNqt+BOiGk/vnBWbMwT3FqLbvSTi/Z6/d1lcYHHEmroHjFW6RiJA/8fCrFykgj+uZ+h22yTi7a7fEGpiqqK+8WsgfUEQC7uGl5V/6yCjSfBa3+y+AR3RMtIMLmXpPiQQ/KwCxE0kGKdmJGIFZKpU8/jwp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 16:25:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 16:25:49 +0000
Message-ID: <dbf8081d-136f-4f91-a773-ef01538cceb6@intel.com>
Date: Wed, 16 Oct 2024 09:25:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <6b63542e-0ffb-4612-838e-5f3dba8469cd@intel.com>
 <df9b3513-1a83-474f-8772-f10cf96c14f1@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <df9b3513-1a83-474f-8772-f10cf96c14f1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 90402a08-7d4e-4df1-2c53-08dcedff3261
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enBIQ29wTzFpVlVPcnRla3g5RzNWRnJBK2NoUjFUeFU1UHU0a2IwZ1JOckdS?=
 =?utf-8?B?ejA2OVVpZGw5d2N4RjUzWTZzREF4bVl3VE9jTDJCTE9pK3paOVBHUUg5d2Uw?=
 =?utf-8?B?aUNKdSttQzNidzFiWUM3cEhBMER6aW12NEFRNWJQeGVUd010bnVHZmo5SEIz?=
 =?utf-8?B?dmE5SGdTMGpPVDgzK2lyNThlaC9KRERLanR1K0gvejUvTStBZ1Zac3ZrYUZt?=
 =?utf-8?B?bkdQKzBOdGpDeFBaamgvWDBmSENFbDAxb0ZHd29PNjBDVnluWEN3YjBkVklQ?=
 =?utf-8?B?a1lvRWQ4alhNc1ZiOU1GQ05FdWFCVCtWSXE2cjBuZGZPWkgxWjFoOUdTV3I4?=
 =?utf-8?B?ZlpUdlBEMVk1U1ZJazQ5Vm1rV1NtTzNSTW83UnkvWUF5YU9UOHpTbmlYcFUx?=
 =?utf-8?B?aVVzYXRKZ3lPVnh0aGo1L3Q0Y0RrbEh4c1pJZ1h6TExqaCtyL3E2enlxYlp6?=
 =?utf-8?B?YndzZHNuMnppQXNaSWVmcmVDTThzenQwR29yOGJJazI5V3ZFR1ZiVGd4bVM3?=
 =?utf-8?B?R2tGSXpJZW85d3lGOGUyalR2dnB1TEF2cmNLYTBTTTdPOGVvVWticlRZbDcy?=
 =?utf-8?B?UzVGeE9PTHNUQ1Q0WXRJSURMZm9Xa2VoT1BBeXdUYTduOVYxZ3hYZU43eTU1?=
 =?utf-8?B?M09VU1lKbWo3Y2pvQ0NlQXNNdjhkTzl5bi9PaHQ5MnhzRHRvQUZxVTJmK3BD?=
 =?utf-8?B?T3VFYTAxL0Nic290ZGw4d2V5MlN4U3gwVlVSeXREY2JkSXNvWFo5c2ZLVGZm?=
 =?utf-8?B?VFhmcDB3NXNJTk1XQ2kxanpQaHVZaEpNUHZnSDlRRUYxZndNajBMRjhWM2RM?=
 =?utf-8?B?V3hVRjRkWDJpUWJYUGFsUEYxVVNjMkwyTjd6Qjd1dURPYi9PYlo5NHovWkUy?=
 =?utf-8?B?Y2JxZjNVRitpaEdCSVdEMXZpZDlGYWxacVpic3ByUHlYZ21WK3p0Y0dGdjF3?=
 =?utf-8?B?VktwV041YlFWU1M3emo1a3N5NFJrUlYwVG5qTEtJaXQ4YWMzQ2pwYXlxcDJk?=
 =?utf-8?B?emRFVVNQYTVRcjQ4K3J0UWhMc3M3bCtUU25mdWlLejhkMUVIRjZyVy83RE9w?=
 =?utf-8?B?S3krTUVScXh5N0YySE9KK1RQc3pxeVFiR3BLUHc1RGpZdkJTcFJBOWp3YzhI?=
 =?utf-8?B?TWVmK0JLR2RiaVY1RUZ1L1lhbjEyVE5VK2VRMjFVeFliWHhWZFBucXA2V3Ur?=
 =?utf-8?B?d2lKUmpYS3NmSWxJTERrMlVwMnBFTkw3aWVsTUZzYVlCRVpZaC9pc0F6amx3?=
 =?utf-8?B?U1R0Njgzb21DMlM0TVNWNWx5RjJDbFZQQXA0ZXRqSlZxTE51RWdTNCswQ3po?=
 =?utf-8?B?cWY0RHdHL1pMdDJ0MkhpaEJSTTBMakVSU2xqMnRtcUMxbG41SVZoS2NwMHBN?=
 =?utf-8?B?U1ZuR3FJN1lCOTdSNVUrVWpBYUZTUlJhOU9MWTc5SHNaVTZxSFN3d09DdE02?=
 =?utf-8?B?KzVmVUt3WWozaTRVaGJzWHc5UWd4N3hhQzhvSk83RndxV1FJaS84SjhNVUpm?=
 =?utf-8?B?Ky9wbFhkUm5iL1dkOUp4aGorTnlXenN4KzZSa21ZcmN1anQ3NktZSHRvSjZV?=
 =?utf-8?B?b2s0SHE3aDhqeDlXZ0QvQkpqN3VWK0RNeHJodG9jbDhVdXB3UXFtbFpoQVUy?=
 =?utf-8?B?NDV1Y1lSbk5Ia2kzbXhiMUpyS2k2ZDI4bmlaT1FIQjZtQStOMkxDUi9yTFNR?=
 =?utf-8?B?ZzFyQ0o3OWJPUnVWU0wyZlhMMm0zOVJBbzYxSTZSbzVUdWp5VG8xT2FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlGa1JSeVlRRjNpbm9VMU9RajM0d0tSYmVrVlB3VjdWRlFEaUtaQVhsc1Fi?=
 =?utf-8?B?UUhSSUg4Y0ZmOWJTbXJ1VzBvU3Nvd09FVi95UzlDTUwzYUp4N1QzVTN6STFU?=
 =?utf-8?B?UC9sdFF0ZkxpSUNlS3A1WGpuU25PZGY5NEFSbWJtbzZZa0FZNVhsN2ZpU2g4?=
 =?utf-8?B?Mjh0N0taZlNYNU0vMkJEVkt5RlR0WXprcFZ3OWxMd2hlOUFmUjA0djFzQklu?=
 =?utf-8?B?ekp0RnVBRGRDTGJtN0o5RkRDYmpBRGtzTmppVHM4aEtmdXVIa2JPRkt3Ynha?=
 =?utf-8?B?SGlVR0dob0l1M2RHSlJiMTdVOWJVamdDQy9CNEg5am1OMmtnc2dheUFOQWx2?=
 =?utf-8?B?TXA5b1U0OVJNOGNpSmVabHp2WEFnMFcrK0M5NkJCRVdKYzBLUGlkWUF1TGZP?=
 =?utf-8?B?b0czWGM5LzRENWN4WHg5TzNuWTU4RWwreitIMHpkVTAySloyRGM2Y2k3LzBE?=
 =?utf-8?B?b094MW5nT2FzNkkrTTZoNDB2TG95bzhwMVlSd1huSFdqSFZSem54SktWV1Av?=
 =?utf-8?B?bXBqWmNyUloxRHErOXV5SUhOWmF1QmdLZkFIRkVwS01wa1gzdFpSU2kwUTVW?=
 =?utf-8?B?WDFWTDlyUDRlMWZiQWUyWHdqSWcycytPWFlGWUdEdmZsVC9LbHdVSU5xdlZ1?=
 =?utf-8?B?RkpHeHNvWGhlWDRjc2VRaXNFMXRwMjg3WGlQZjZ3THNmVTM1TzVZS0N1SjZp?=
 =?utf-8?B?L25Mc25OZDBQWEVOT1VOaTZ2eVNoK1VNNTVib3cyZUI2RWdWeEl5VzExdFg4?=
 =?utf-8?B?L3UrNUF1N0tVMFo2Q1FVM1VEVCtDKzZKTFN4WjE1bGtOL2tHYlM3bVdOanpW?=
 =?utf-8?B?V1paNVQ0Ymg1YnNqQlE5cHdERjZlaVRmMFFMK3R3ZUdWRkl0YVpBOUhIbXhJ?=
 =?utf-8?B?KzF5cytmUUtEUFBkd3o4K0htSW9TWkkzdWs3c1hoSUhQU1pqRi9LU3ZPZk1X?=
 =?utf-8?B?Q1p4VmpUMWJKTVRGTFVhbEN2UnVBRzJ5OGtiNGNUdGpCZlZhZ3BuM21zRlBm?=
 =?utf-8?B?U3pjOWZYNjBVdXVyZkNRU0FCS1piekk1OGU3QTdRSGdzOTJPMXpib3EyRkF6?=
 =?utf-8?B?VEhrMGlrZnMyZjEvdjkzUm45MURIRnI0a25WNkdNdkd4UXFteTZIMW5ybTRm?=
 =?utf-8?B?Y2svSnZTQXN2QVNXSEJWREVFWVk1NkVIdG95VXJCVDdjbkNLQitxNDJwYi9L?=
 =?utf-8?B?cjRPVW9OVWZwNUZiQkpMMjJiZmNxUVo2ejY4bmV1OWNPRzdaQ1lTbXUyRzNY?=
 =?utf-8?B?aEdHTXBhcTJVTEVTaUxPNGtpaURvcTFVZlZNNmZEWlJqWkxOd2lTUTltK1Nk?=
 =?utf-8?B?L3M3UFkweGdzamNRUVplRDB3OURzVUp5WURkTElJbVBoL3RySU9GaE13Tzht?=
 =?utf-8?B?YUs2OHZYTUZXMmFwajcxRGNKcGRxZklncE5KdFVWUU93Z0NzYlNBbjhHYlpR?=
 =?utf-8?B?R1E2cEU4TWdTWEtXVnNBWjh3b09ob2czMnZPcVB5OGw3cmUyM1ZIZXhJVm1I?=
 =?utf-8?B?T0EwVEwwdk4rYi9OUUpUTEFIMHlNRnQraW9Sc2szV1dWZUpKNUR1SVp2QThx?=
 =?utf-8?B?OE5pLzhDNy9jZTBTK3BkSTRFeS9LNU51MzVvSk1mWEtObnJ0SThhV2JFcVU3?=
 =?utf-8?B?ZGtvRWlYdWFINWk3aWo2VjRjTWhIdkFSa0c3OGw5TFE4VWZONDE0a3NUditp?=
 =?utf-8?B?Q1RYSkJMOUtCekx3eTNDcDdoL0N0Nlk0LzJielk1OFkxOXpTYmhweUJUSFRa?=
 =?utf-8?B?aUNxbml2Z1RtL2dkWTJCVTRmbFgzYWpRZ2NVamJmR3haWkx3eU1xNEFWT3ly?=
 =?utf-8?B?T2lnSWlaeXY5TGYrYlFsTDRDZnpkNE9aVE1QQ2ZpdnkrVWIyaHJxeUh2Sndm?=
 =?utf-8?B?aFJiblNjTVpsalkvK2NxN0tQTUZac2Zydk5iNG9TTGhCc1h5UC90R3ZGaFNZ?=
 =?utf-8?B?MXpWeDNaS0wrRndrVmNRZVFhMm9UYkZyNkZpYjBIWEcwNEFkUnJOWEpvNmVx?=
 =?utf-8?B?Q2tGVFduQ2haMFMwREU2VmVKMkNyUDVwUHM2MitVdzlQYnc5V3dDUHJMZFJX?=
 =?utf-8?B?ZWV6eW10TDdxWC9CQmpKa1IvRHhVdHg5dU1VRDJKcVJGK1hsZlBhWkVaQnB2?=
 =?utf-8?B?V0MwY0NoOHVLY2NKSnp4RVdCbzdBQm45VVRlZGN4Z2NNc292WW54UUk0TE03?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90402a08-7d4e-4df1-2c53-08dcedff3261
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:25:49.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUlZop55+jilOWuVHzkVockvDyxGfMQiE0Fnc38w0d49ZHu9wt5StH1beJ+/nGMrkxyOB45tSoKTcFuMBTgqKP09A4JQMETGzpBu3yvyUPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/24 8:57 AM, Moger, Babu wrote:
> On 10/15/24 22:12, Reinette Chatre wrote:
>> On 10/9/24 10:39 AM, Babu Moger wrote:

>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>> index 30586728a4cd..e4a7d6e815f6 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -257,6 +257,40 @@ with the following files:
>>>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>>  	    0=0x30;1=0x30;3=0x15;4=0x15
>>>  
>>> +"mbm_assign_mode":
>>> +	Reports the list of monitoring modes supported. The enclosed brackets
>>> +	indicate which mode is enabled.
>>> +	::
>>> +
>>> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>> +	  [mbm_cntr_assign]
>>> +	  default
>>> +
>>> +	"mbm_cntr_assign":
>>> +
>>> +	In mbm_cntr_assign mode user-space is able to specify which control
>>> +	or monitor groups in resctrl should have a counter assigned using the
>>
>> Counters cannot be assigned to control groups. How about replacing all instances
>> of "control and monitor groups" with "CTRL_MON and MON groups", similarly
>> "control or monitor groups" with "CTRL_MON or MON groups".
> 
> Ok.
> 
>>
>>> +	'mbm_assign_control' file. The number of counters available is described
>>
>> Looking at the rest of the doc it seems that the custom is actually to place
>> filenames in double quotes, like "mbm_assign_control".
> 
> Sure.
> 
>>
>>> +	in the 'num_mbm_cntrs' file. Changing the mode may cause all counters on
>>> +	a resource to reset.
>>> +
>>> +	The mode is useful on platforms which support more control and monitor
>>> +	groups than hardware counters, meaning 'unassigned' control or monitor
>>> +	groups will report 'Unavailable' or count the traffic in an unpredictable
>>> +	way.
>>
>> Note two more instances of "control groups" above.
>>
>> Please note that the above description implies that counter assignment is per-group. For
>> example, "specify which control	or monitor groups in resctrl should have a counter
>> assigned" and "useful on platforms which support more control and monitor groups
>> than hardware counters". This needs to be reworked to reflect that counters
>> are assigned to events.
> 
> How about this?
> 
> The mode is useful on platforms which support more CTRL_MON and MON groups
> than the hardware counters, meaning 'unassigned' events on CTRL_MON or MON
> groups will report 'Unavailable' or count the traffic in an unpredictable
> way.

This rewrites the second paragraph of the section about "mbm_cntr_assign". It is
not clear to me how this section will end up looking since the first paragraph still
seems to refer to counters being assigned to groups ("specify which control or monitor
groups in resctrl should have a counter assigned") while the later addition
to this section by "x86/resctrl: Introduce the interface to switch between monitor
modes" starts by specifying how counters are assigned to the MBM events ("The MBM
events (mbm_total_bytes and/or mbm_local_bytes) associated counters").

>>> +
>>> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>> +	enable this mode by default so that counters remain assigned even when the
>>> +	corresponding RMID is not in use by any processor.
>>
>> I assume this should remain RMID since this specifically talks about an x86 system?
> 
> This was a suggestion from James. Let me know if you want me to change.

I can proceed to assume this is a paragraph intended to be x86 specific. No need to change.

Reinette



