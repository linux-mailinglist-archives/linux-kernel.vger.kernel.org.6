Return-Path: <linux-kernel+bounces-575619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D7A704E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B413918854B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5D25BAAB;
	Tue, 25 Mar 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIkzVMAm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3FD1EB3E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916015; cv=fail; b=Mo8ZagGpq8fmqugv3lPBqjrHoa2ctoWHqf+y1dnSQti5Y2W0yCn1aCmsBrgfkRsxqWXTaPoRzgB+GMgXFqie/30ypya5SoxBbGVACq53OfhE1rlVmxwCMAvrLsb8PSgLRjsrFBR0Y6Lo66q+/bgF7XUUDuZRVBxA11eW5KBvvDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916015; c=relaxed/simple;
	bh=FiG2fepG9JeHGkGacyDZrda5qZyHcmxbnt8KIk+i8ZI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b1c0VMsU0is3xTHpgxoiQvMShhVzwP8vInbf00IgMyK3L2MTTy5gEyYOsVg933MF1u9YlUJWrg0nRc97Q5pzU4FtPXKK9Hk+Jl9vXRwtsvVDfs4f59pbfP/NsElvfUW44F2IoZWJVwcxwO0WWPolbaVrMG8qXvkjGBtAOAfvVjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIkzVMAm; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742916013; x=1774452013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FiG2fepG9JeHGkGacyDZrda5qZyHcmxbnt8KIk+i8ZI=;
  b=VIkzVMAm2qSV9hmlaZMDSlYWWveA8S4owfV0hM5jabHixqYutYrRZxPe
   5btEc98rvkkaXcA2MEAsFa9XcJigarI+R1oAC7R48/53H+CeZVxR3z3IS
   t1N2sJHwmP0DbX4aS4H7bZPrqvERtrnmxB04Rwy5cS+LBMaLTuLDApw1n
   66NivPMJpyA08DF2ff2/r1DyajxmqLlS7iwcOUJtJ0/kYT2ghCVzYTxby
   K8Q84z9zFvnVK+D5XOy9qBvXcLMbLtGgWQjoC2ycXmeTBAHUMEA6uYA67
   p6GvTn/EEh8fuqT+SCQ+vat7m7GYbKOIiP15Lmyd55FRZ0IXcIKf9wGTa
   A==;
X-CSE-ConnectionGUID: 4R3LhHkDT/+8RGurh0xscQ==
X-CSE-MsgGUID: vhk36kqeSyummIfR/00zPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54833618"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="54833618"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:20:10 -0700
X-CSE-ConnectionGUID: 5nKDWCKiRP6BfAnKnACvtA==
X-CSE-MsgGUID: blvj3E+NS8uVfeDgalI3/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124126423"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:20:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Mar 2025 08:20:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 08:20:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 08:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY4r+ECAPCb+ljuJ4M4bUxfS4HLbpxUgbxsrzmjgTuwMfbGJOlcFOt4tyuLzUIAjKBOWv41d3pPRpzKOTRSuq4kxvenzT9wUdCLoHJiKK/RX3Ih9Gn3hEzgQ5v0m0tinUvj7knIU6np3iSmDpfiq6D5j5rP55myzsoNfMs9FwgRt2gV2dtjkvIkhlGxPqG5a1LKn835yezblhNDD29gLWp1NPGB0M0jEA58f95HyBTZ0yljcAV+2I0riT1Ii2TZgpMFr70KSZQ5Cyu1gU1vzcOEan1nfHfiBovtfoF1RPJUd8RiM+mMBzX2MJBYHYBURJkf6rXsmkU9ScD+e+X54zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGfbTIy/jWy069xrqZ6UutV/BSOVCOmlBSYlTiL2NMs=;
 b=mEbeQwXvF/ocuyOd/2NafJu7p5GLRubX8UeCnVN3+kyTpJeZCDiX3D3rKdg1GWrDEffNkH3AdEbI4Vv3PjONoWLxnNZOc0p80l0936P189sCy5rPf7E561+6g/DaqrMCECLY+G9lPTjGD50Ll3xQsv1BdTjBKtBFoTZz2V0LNShbB/vntvUO6KTjMmkVImEnaK5yzErgkAea21cM1MPElYJlADtZhwQFxeG/pxCTops8JZeGlpp/SUHJzStfUw5QYQ1TnSidmc5ZUl9Dr1qsnI0keqTvu0oNujVJyw3ecdBHODKeVZ4IiPYm60Zyoo8btMbFDNCQzss6UQKdbKOROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 15:20:05 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 15:20:05 +0000
Message-ID: <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
Date: Tue, 25 Mar 2025 23:19:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
To: Peter Zijlstra <peterz@infradead.org>
CC: <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, <tglx@linutronix.de>, <len.brown@intel.com>,
	<gautham.shenoy@amd.com>, <mingo@kernel.org>, <kprateek.nayak@amd.com>,
	<yu.chen.surf@foxmail.com>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA2PR11MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 139bf49e-19f6-4ed5-d84f-08dd6bb08555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekh3eFNVNnFUT2E3R0I2cFVkdDBrQnpnKzZvWXR6aGNLSXluNGdTRzA3R2FE?=
 =?utf-8?B?UG14TjhLSWhIZitNT1pjYWIxK3dGNm9MVWhwU0d6U1BHU0h4a3NLMGc0K2Fz?=
 =?utf-8?B?WGhVQmZ0Wk9jVTFWS0ZHaXNLeFZWQ3dqUlN6ZXdGOHZIT1c3R1pVemNTUllq?=
 =?utf-8?B?N1V5RWdxQm84NGMwb0FicFErYlNuWGhFWnU5YnNuK2M5dHlJcWo2ekFjVS9i?=
 =?utf-8?B?NUFFTzIxRU4yQU5ELzJlM3FtOVpLeGMxc2JxWmg1RFE2L3FOTDZWMHhETXh6?=
 =?utf-8?B?aVFWVkx6YjNlZ3I3RytaeUE3VW50bnlHS3lncGg2UXF0VG81SVJPd0UxUnh3?=
 =?utf-8?B?RWNrOGFRVjlLZmNqSVhwNGlmcjRmdnIyM2l0NkIvN1FMelJjTnZ6NFhGSHBY?=
 =?utf-8?B?NnlCTDFBblY0NG5IOGRhRDRLUENwUmxvYUJFY3dNOU9SNTZVcUp3YWs1Rk5n?=
 =?utf-8?B?T3M4QzYzOTZNMXBKVTJyL3Iycnhra29hMW51ZjUwYXNJWVoybUVld3J0Tzdx?=
 =?utf-8?B?SklkeDJaOFVsN2NZZUE2OEtJR2xWUVY3RkNwTEJPK0prL0VkTWltM0hPWjJY?=
 =?utf-8?B?MmVjcUFRTENWU1VNS2NUdXpRS2FmMGgxY1MvYld2YThYaWF6Sml3NjFFWDdr?=
 =?utf-8?B?VmdWZlRKK3ZDMTlQY2ZqK1lwRTZjUXAxYVF4dzVqczhVelVTQW9zQWdFcTdu?=
 =?utf-8?B?aWlXcndEV1dldWJ5RnZlbHRLaHk5ZjF2bnZSYjRmeWlYQVBiZkh6d1RLZnVP?=
 =?utf-8?B?Nno4VUNKK2VHcWlkM2d6MXRVdllHKzk2a0FKTjl5N1djeU5tZC9CUTkwVW9n?=
 =?utf-8?B?M3hEeEk5cTA0b3VWN1cyUmI1WTEzaWFyTmR1YzdXUG5sekt5eVdkS0dmV2Yw?=
 =?utf-8?B?UUlJeGMyajV3NkJubkxudWJJa3IzYzdMcklYNEZ4dGJ0NjdIaEtqWUJOcklE?=
 =?utf-8?B?ZjY5MEU3dllpRUJacUp1QTZIZDJ1WUdRYVV2S09VUm9pM2I2NitKNTJwaHFn?=
 =?utf-8?B?SWNvbmRGcXRablRmYldKN2k4WlVzc1h4blBOSXRjZ1ptRmRHaXduM1oveTJG?=
 =?utf-8?B?djV3OFpKVHJESmJnZSs5T1UremtxeEl6L0U4V1JmN2xYejdxM1N5a0crdkVC?=
 =?utf-8?B?WUQ1UjVBeElvQ3ZPY28wT2F2MEVJZERmUVhzUUdQY1IrWWg3T0wzWFgxenVU?=
 =?utf-8?B?eWRac1BOelpwVThZVFhZWVBIdWh5SnMwNVJ3cFBmWU0waU1ETVhmWlNZVGdZ?=
 =?utf-8?B?QnpHaEZuUzZVK1VWSnhYMXRKNHpIWnhLYXlvWFNjcVhlSGdFdkVlOUdsT3Nv?=
 =?utf-8?B?K0hxb2I2dXkwcXQvRU4vUDZEVGNnL0p3cW5ldnpLWlpJYjRWcEV3UEV3V29H?=
 =?utf-8?B?UzB6dldXcmcxOFBPVVhiQkdESVptLzJjSC9SYXhBRTlQU2xTeGxxWjdhdDlY?=
 =?utf-8?B?Ty92NmNFY1JEK2pvdStMcDZENmhlTk9DVW1DSmpTaDZXZnJHTUFqQ2V4U3RT?=
 =?utf-8?B?M2NPWWJZYlpFeHFwZkpXbmNnSzAxTVdURElhN3Ria1Jyb3pLN1MwWVRIWm12?=
 =?utf-8?B?YjlocEVqME1KR1N5eXlJM2ZNR2xIdkFHL1Zkd2h3cDF6eThtaDd5M2sxSE5j?=
 =?utf-8?B?RmtRMTFrak5uQXpRMGEvelB1ZFVuVmV0YzB0YnM2Q1FYV2ovdmt3VWtLZkFS?=
 =?utf-8?B?OXlzS2lmMkJJenlQTnI5d21CWDdLUUR6ellBTTQxbHMzM3RsalNZS2xsZ1F1?=
 =?utf-8?B?ZSt1clkrc2ljQnR2TC9samJOUk04SXk0aFVveTNBbnlQSHE4UENqaWpIWmcw?=
 =?utf-8?B?MWVrUVh0aEZrd0dvOHhDRE1VbVovWUpRU0V6c0hXSGR1bUJNZGlTMEhJV29o?=
 =?utf-8?Q?LxE+454FQsVsj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBaREVPeGp2R2RkQ2xwZnh3VFJUUDkrM2tHZUlvQmduZkVZWTY0U0hZOEZt?=
 =?utf-8?B?bm5CbDNPK01MZElaclM0eUtBdFQwTUs2VUkwQ0c1ZndYcGtjSFNwa29SNkhC?=
 =?utf-8?B?ckY2MDVNR003ZzZiRGYvZHB4aGk5TTVla0VoV2ZnUDJ2bzZQTGZSdEtxQXpH?=
 =?utf-8?B?Q1kwMDlhUE0ybTAydmpEd25ZdXVxT2t1MGhHSVBCTFFKOW5CdEJZTEVFS3Y4?=
 =?utf-8?B?eGFadHlrbjNxWEJBYzkrNWFhOFBZZEdaWmwrbUN1ZngyMWRzcU9TRm5Zdmpm?=
 =?utf-8?B?ME9FVlBIOVJLRUl2bXBsSnlRR1FTWklPRVFNblZ6bnJIeFRoNFZsNkZkNmV6?=
 =?utf-8?B?VWtQL2JQN0dSWkpZQWNXNFNydk5rb09pZWQ0V2RRQVdtek1pb0NHdnNSQ3Uz?=
 =?utf-8?B?RTBwTUpvc1pJVlhqaS9vd3Vpc1dGSlhTTXB6OEdwTEJuQklUUXBnb29sQXV4?=
 =?utf-8?B?cGRMcnBWRjE2ZGtHbWd2RHZPM25XZkYxWGc2NEZxV1NxcEJERENvUnJ3UmFZ?=
 =?utf-8?B?U2pGUmU2SEJuOFZ0Zi91QXVmV0NYaUVmN3oxWEZmQzdWeHlFRlowVmpkTXlr?=
 =?utf-8?B?ZTVMSDhQMERGUVdIVnlBbDArTk5ha0dxc2ozOWV3WDJKNFRjQlVabHlHQ3ZD?=
 =?utf-8?B?bm81aGtUSVFKb0pwdC9VU3N0Zi9ucnVjL3d5cGRKN2hwUkFYMkxzUG5BSjhE?=
 =?utf-8?B?RjFyaUxLMEpoeExvOHExaVJSVEpYVy9hemdZdTdORWd6ZlRpOHdXSHZQUEVX?=
 =?utf-8?B?MVpHL3A1WFEzZm5ORlFGeGlneGZlVU9yN3EyZjZMTVpiVTZHaTQ5RnRIYzJh?=
 =?utf-8?B?L0Y0MjQyeC95WTNITTlVNnJIc2VXUWVTRDlJM2tEMkhYM0dvMEpHUG1XU1Zx?=
 =?utf-8?B?cHpYcVV0a1lySmdWTEp6STdjbkszQmoyYmI2dVZzN09DdE14b0lNR2xtSVFR?=
 =?utf-8?B?bkhaK3hTVmhScythaVlLS0s4WUpuZTA4M3VjYzlTVlF6bUJnYUdBVWZIcWht?=
 =?utf-8?B?dUlBYVZ6V1Y5bUJhNkJLN0tTeUlrRndxdVhiUDJJYlE2RmMvSDgyZjk0Qk5s?=
 =?utf-8?B?NVUzTDZVaTl4a1krSDdvdHJvcVRqOHdaMmZNSWxNSG9FOXd6bnl3VGFsVFl4?=
 =?utf-8?B?WjZCdEJ3aTRldkVWa201ZnZSSzFEaWFsUXArOGpHYXZZTHRHMTcwVSsyRzFH?=
 =?utf-8?B?SzJaN1FnOCtmNVdUVHFEL2hFWjdqbnF4ak0rWlFoVXdtL3JKbG95Vk90M2d2?=
 =?utf-8?B?b2x1VXFMdjRPSXJnUlhsWkk4cWlERzFyTFZlK1RZRlFVYjE4T21Fa0NvUDI1?=
 =?utf-8?B?MzZQRlZKSENzalBjVkVGY1ovUnk3ckxHMHl0VFFKbGJvVEZMRTM0bXB5eEVk?=
 =?utf-8?B?eFFnWTVRTXEzMkUrYXVrT0hqcDd2bEVWM0x4N3p3NUI1YW5sVkhpQTMvNGpN?=
 =?utf-8?B?dFJsYlRTRm9QenI1RjlFZnRCTG55NXlwdGdCc2VwUGJMc2g5MisyZWRCVzlh?=
 =?utf-8?B?b0ZuMmliOXd3T2RTNXQxTEgxbDlvTGFINWJKdVZyUDl6Z0ZYQ2hPWGJvVmlt?=
 =?utf-8?B?VE5yM3psbW5KdFBnUXRmVzk2cWNOYTcvdjZhK09Hblc2dnRzbWxQZmdRa2t6?=
 =?utf-8?B?aE5uT1pwbFlQMGNRUlFneXlzSW4rckJpdDNETzBZTTZpYlprZkFtV0xzTkQ3?=
 =?utf-8?B?NDJiZXlEUEg2TW5IL0RhR29FRVdaZ3lNSVJFMGlkNW9vM2VOQmpaVFJDNnVF?=
 =?utf-8?B?Z052blNMWDRoNHV3SGt3N0dzNGNPdmN0MTk2M01DQ3JyelpnU011VFp5eTZs?=
 =?utf-8?B?NjF1RFlXcEthQnBKb0xoclExVUI4YjlMeGVuZGtVemRRelpaUnk2OFgxTmJz?=
 =?utf-8?B?SGZydzIydTUrbHdCcHRySFY2Kzd5M0xWWFFNWHF2aHlPSTFtM2J4N1o5TE5E?=
 =?utf-8?B?Z3ZCbFo0NHF4d05McDRCc1M1b05xdm00cVJET2o2NU1mTVdWL3FjcURVL0Vm?=
 =?utf-8?B?VWV3NzE4ZVB4WlRDWkFpNitGMlhTMXI1dkROeTdwdnNpWThTSngwcHREOG0y?=
 =?utf-8?B?OVZZU0hkaklMRWFraGVIalJuV0w3Z0FMS0Y1TkNiVE9NNmQ0SHVVRTdzMU5L?=
 =?utf-8?Q?YTyx0PvHYTdZsrhU6j+GOXzLk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 139bf49e-19f6-4ed5-d84f-08dd6bb08555
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:20:05.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP3TYuzptgoi+K34FCqUNDbsqWMnBfd4NLcg4A8xJRyxRRYD1A73A5bkVt9Gnlhtogy5BmRHGN5D/wR6HmLjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5052
X-OriginatorOrg: intel.com


Hi Peter,

Thanks for sending this out,

On 3/25/2025 8:09 PM, Peter Zijlstra wrote:
> Hi all,
> 
> One of the many things on the eternal todo list has been finishing the
> below hackery.
> 
> It is an attempt at modelling cache affinity -- and while the patch
> really only targets LLC, it could very well be extended to also apply to
> clusters (L2). Specifically any case of multiple cache domains inside a
> node.
> 
> Anyway, I wrote this about a year ago, and I mentioned this at the
> recent OSPM conf where Gautham and Prateek expressed interest in playing
> with this code.
> 
> So here goes, very rough and largely unproven code ahead :-)
> 
> It applies to current tip/master, but I know it will fail the __percpu
> validation that sits in -next, although that shouldn't be terribly hard
> to fix up.
> 
> As is, it only computes a CPU inside the LLC that has the highest recent
> runtime, this CPU is then used in the wake-up path to steer towards this
> LLC and in task_hot() to limit migrations away from it.
> 
> More elaborate things could be done, notably there is an XXX in there
> somewhere about finding the best LLC inside a NODE (interaction with
> NUMA_BALANCING).
> 

Besides the control provided by CONFIG_SCHED_CACHE, could we also 
introduce sched_feat(SCHED_CACHE) to manage this feature, facilitating 
dynamic adjustments? Similarly we can also introduce other sched_feats 
for load balancing and NUMA balancing for fine-grain control.

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/mm_types.h |  44 +++++++
>   include/linux/sched.h    |   4 +
>   init/Kconfig             |   4 +
>   kernel/fork.c            |   5 +
>   kernel/sched/core.c      |  13 +-
>   kernel/sched/fair.c      | 330 ++++++++++++++++++++++++++++++++++++++++++++---
>   kernel/sched/sched.h     |   8 ++
>   7 files changed, 388 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6..3ed8dd225eb9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -800,6 +800,12 @@ struct mm_cid {
>   };
>   #endif
>   
> +struct mm_sched {
> +	u64 runtime;
> +	unsigned long epoch;
> +	unsigned long occ;
> +};
> +
>   struct kioctx_table;
>   struct iommu_mm_data;
>   struct mm_struct {
> @@ -890,6 +896,17 @@ struct mm_struct {
>   		 */
>   		raw_spinlock_t cpus_allowed_lock;
>   #endif
> +#ifdef CONFIG_SCHED_CACHE
> +		/*
> +		 * Track per-cpu-per-process occupancy as a proxy for cache residency.
> +		 * See account_mm_sched() and ...
> +		 */
> +		struct mm_sched __percpu *pcpu_sched;
> +		raw_spinlock_t mm_sched_lock;
> +		unsigned long mm_sched_epoch;
> +		int mm_sched_cpu;
> +#endif
> +
>   #ifdef CONFIG_MMU
>   		atomic_long_t pgtables_bytes;	/* size of all page tables */
>   #endif
> @@ -1296,6 +1313,33 @@ static inline unsigned int mm_cid_size(void)
>   static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
>   #endif /* CONFIG_SCHED_MM_CID */
>   
> +#ifdef CONFIG_SCHED_CACHE
> +extern void mm_init_sched(struct mm_struct *mm, struct mm_sched *pcpu_sched);
> +
> +static inline int mm_alloc_sched_noprof(struct mm_struct *mm)
> +{
> +	struct mm_sched *pcpu_sched = alloc_percpu_noprof(struct mm_sched);
> +	if (!pcpu_sched)
> +		return -ENOMEM;
> +
> +	mm_init_sched(mm, pcpu_sched);
> +	return 0;
> +}
> +
> +#define mm_alloc_sched(...)	alloc_hooks(mm_alloc_sched_noprof(__VA_ARGS__))
> +
> +static inline void mm_destroy_sched(struct mm_struct *mm)
> +{
> +	free_percpu(mm->pcpu_sched);
> +	mm->pcpu_sched = NULL;
> +}
> +#else /* !CONFIG_SCHED_CACHE */
> +
> +static inline int mm_alloc_sched(struct mm_struct *mm) { return 0; }
> +static inline void mm_destroy_sched(struct mm_struct *mm) { }
> +
> +#endif /* CONFIG_SCHED_CACHE */
> +
>   struct mmu_gather;
>   extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
>   extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6e5c38718ff5..f8eafe440369 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1379,6 +1379,10 @@ struct task_struct {
>   	unsigned long			numa_pages_migrated;
>   #endif /* CONFIG_NUMA_BALANCING */
>   
> +#ifdef CONFIG_SCHED_CACHE
> +	struct callback_head		cache_work;
> +#endif
> +
>   #ifdef CONFIG_RSEQ
>   	struct rseq __user *rseq;
>   	u32 rseq_len;
> diff --git a/init/Kconfig b/init/Kconfig
> index 681f38ee68db..14b15215318f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -950,6 +950,10 @@ config NUMA_BALANCING
>   
>   	  This system will be inactive on UMA systems.
>   
> +config SCHED_CACHE
> +	bool "Cache aware scheduler"
> +	default y
> +
>   config NUMA_BALANCING_DEFAULT_ENABLED
>   	bool "Automatically enable NUMA aware memory/task placement"
>   	default y
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1b659b07ecd5..bc9d7dbfd980 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1314,6 +1314,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	if (mm_alloc_cid(mm, p))
>   		goto fail_cid;
>   
> +	if (mm_alloc_sched(mm))
> +		goto fail_sched;
> +
>   	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
>   				     NR_MM_COUNTERS))
>   		goto fail_pcpu;
> @@ -1323,6 +1326,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	return mm;
>   
>   fail_pcpu:
> +	mm_destroy_sched(mm);
> +fail_sched:
>   	mm_destroy_cid(mm);
>   fail_cid:
>   	destroy_context(mm);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 87540217fc09..649db6ea41ea 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4514,6 +4514,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>   	p->migration_pending = NULL;
>   #endif
>   	init_sched_mm_cid(p);
> +	init_sched_mm(p);
>   }
>   
>   DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> @@ -8505,6 +8506,7 @@ static struct kmem_cache *task_group_cache __ro_after_init;
>   
>   void __init sched_init(void)
>   {
> +	unsigned long now = jiffies;
>   	unsigned long ptr = 0;
>   	int i;
>   
> @@ -8579,7 +8581,7 @@ void __init sched_init(void)
>   		raw_spin_lock_init(&rq->__lock);
>   		rq->nr_running = 0;
>   		rq->calc_load_active = 0;
> -		rq->calc_load_update = jiffies + LOAD_FREQ;
> +		rq->calc_load_update = now + LOAD_FREQ;
>   		init_cfs_rq(&rq->cfs);
>   		init_rt_rq(&rq->rt);
>   		init_dl_rq(&rq->dl);
> @@ -8623,7 +8625,7 @@ void __init sched_init(void)
>   		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
>   		rq->balance_callback = &balance_push_callback;
>   		rq->active_balance = 0;
> -		rq->next_balance = jiffies;
> +		rq->next_balance = now;
>   		rq->push_cpu = 0;
>   		rq->cpu = i;
>   		rq->online = 0;
> @@ -8635,7 +8637,7 @@ void __init sched_init(void)
>   
>   		rq_attach_root(rq, &def_root_domain);
>   #ifdef CONFIG_NO_HZ_COMMON
> -		rq->last_blocked_load_update_tick = jiffies;
> +		rq->last_blocked_load_update_tick = now;
>   		atomic_set(&rq->nohz_flags, 0);
>   
>   		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
> @@ -8660,6 +8662,11 @@ void __init sched_init(void)
>   
>   		rq->core_cookie = 0UL;
>   #endif
> +#ifdef CONFIG_SCHED_CACHE
> +		raw_spin_lock_init(&rq->cpu_epoch_lock);
> +		rq->cpu_epoch_next = now;
> +#endif
> +
>   		zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
>   	}
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e43993a4e580..943af076e09c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1166,10 +1166,229 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
>   	return delta_exec;
>   }
>   
> -static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
> +#ifdef CONFIG_SCHED_CACHE
> +
> +/*
> + * XXX numbers come from a place the sun don't shine -- probably wants to be SD
> + * tunable or so.
> + */
> +#define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
> +#define EPOCH_OLD	5		/* 50 ms */
> +
> +void mm_init_sched(struct mm_struct *mm, struct mm_sched *_pcpu_sched)
> +{
> +	unsigned long epoch;
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		struct mm_sched *pcpu_sched = per_cpu_ptr(_pcpu_sched, i);
> +		struct rq *rq = cpu_rq(i);
> +
> +		pcpu_sched->runtime = 0;
> +		pcpu_sched->epoch = epoch = rq->cpu_epoch;
> +		pcpu_sched->occ = -1;
> +	}
> +
> +	raw_spin_lock_init(&mm->mm_sched_lock);
> +	mm->mm_sched_epoch = epoch;
> +	mm->mm_sched_cpu = -1;
> +
> +	smp_store_release(&mm->pcpu_sched, _pcpu_sched);
> +}
> +
> +/* because why would C be fully specified */
> +static __always_inline void __shr_u64(u64 *val, unsigned int n)
> +{
> +	if (n >= 64) {
> +		*val = 0;
> +		return;
> +	}
> +	*val >>= n;
> +}
> +
> +static inline void __update_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
> +{
> +	lockdep_assert_held(&rq->cpu_epoch_lock);
> +
> +	unsigned long n, now = jiffies;
> +	long delta = now - rq->cpu_epoch_next;
> +
> +	if (delta > 0) {
> +		n = (delta + EPOCH_PERIOD - 1) / EPOCH_PERIOD;
> +		rq->cpu_epoch += n;
> +		rq->cpu_epoch_next += n * EPOCH_PERIOD;
> +		__shr_u64(&rq->cpu_runtime, n);
> +	}
> +
> +	n = rq->cpu_epoch - pcpu_sched->epoch;
> +	if (n) {
> +		pcpu_sched->epoch += n;
> +		__shr_u64(&pcpu_sched->runtime, n);
> +	}
> +}
> +
> +static unsigned long fraction_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
> +{
> +	guard(raw_spinlock_irqsave)(&rq->cpu_epoch_lock);
> +
> +	__update_mm_sched(rq, pcpu_sched);
> +
> +	/*
> +	 * Runtime is a geometric series (r=0.5) and as such will sum to twice
> +	 * the accumulation period, this means the multiplcation here should
> +	 * not overflow.
> +	 */
> +	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1);
> +}
> +
> +static inline
> +void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
> +{
> +	struct mm_struct *mm = p->mm;
> +	struct mm_sched *pcpu_sched;
> +	unsigned long epoch;
> +
> +	/*
> +	 * init_task and kthreads don't be having no mm
> +	 */
> +	if (!mm || !mm->pcpu_sched)
> +		return;
> +
> +	pcpu_sched = this_cpu_ptr(p->mm->pcpu_sched);
> +
> +	scoped_guard (raw_spinlock, &rq->cpu_epoch_lock) {
> +		__update_mm_sched(rq, pcpu_sched);
> +		pcpu_sched->runtime += delta_exec;
> +		rq->cpu_runtime += delta_exec;
> +		epoch = rq->cpu_epoch;
> +	}
> +
> +	/*
> +	 * If this task hasn't hit task_cache_work() for a while, invalidate
> +	 * it's preferred state.
> +	 */
> +	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_OLD) {
> +		mm->mm_sched_cpu = -1;
> +		pcpu_sched->occ = -1;
> +	}
> +}
> +
> +static void task_tick_cache(struct rq *rq, struct task_struct *p)
> +{
> +	struct callback_head *work = &p->cache_work;
> +	struct mm_struct *mm = p->mm;
> +
> +	if (!mm || !mm->pcpu_sched)
> +		return;
> +
> +	if (mm->mm_sched_epoch == rq->cpu_epoch)
> +		return;
> +

[1]

> +	guard(raw_spinlock)(&mm->mm_sched_lock);
> +
> +	if (mm->mm_sched_epoch == rq->cpu_epoch)
> +		return;

Remove above duplicated [1] and keep the check here?

> +
> +	if (work->next == work) {
> +		task_work_add(p, work, TWA_RESUME);
> +		WRITE_ONCE(mm->mm_sched_epoch, rq->cpu_epoch);
> +	}
> +}
> +
> +static void task_cache_work(struct callback_head *work)
> +{
> +	struct task_struct *p = current;
> +	struct mm_struct *mm = p->mm;
> +	unsigned long m_a_occ = 0;
> +	int cpu, m_a_cpu = -1;
> +	cpumask_var_t cpus;
> +
> +	WARN_ON_ONCE(work != &p->cache_work);
> +
> +	work->next = work;
> +
> +	if (p->flags & PF_EXITING)
> +		return;
> +
> +	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> +		return;
> +
> +	scoped_guard (cpus_read_lock) {
> +		cpumask_copy(cpus, cpu_online_mask);
> +
> +		for_each_cpu(cpu, cpus) {
> +			/* XXX sched_cluster_active */
> +			struct sched_domain *sd = per_cpu(sd_llc, cpu);
> +			unsigned long occ, m_occ = 0, a_occ = 0;
> +			int m_cpu = -1, nr = 0, i;
> +
> +			for_each_cpu(i, sched_domain_span(sd)) {
> +				occ = fraction_mm_sched(cpu_rq(i),
> +							per_cpu_ptr(mm->pcpu_sched, i));
> +				a_occ += occ;
> +				if (occ > m_occ) {
> +					m_occ = occ;
> +					m_cpu = i;
> +				}
> +				nr++;
> +				trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
> +					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
> +			}
> +
> +			a_occ /= nr;


In systems with a larger number of CPUs within a single LLC, the 
division may lose accuracy.
Can we either use multiplication for comparison, or just use the 
accumulated total CPU occupancy
of that LLC for comparison (by removing a_occ /= nr)?


> +			if (a_occ > m_a_occ) {
> +				m_a_occ = a_occ;
> +				m_a_cpu = m_cpu;
> +			}
> +
> +			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
> +				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
> +
> +			for_each_cpu(i, sched_domain_span(sd)) {
> +				/* XXX threshold ? */
> +				per_cpu_ptr(mm->pcpu_sched, i)->occ = a_occ;
> +			}
> +
> +			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> +		}
> +	}
> +
> +	/*
> +	 * If the max average cache occupancy is 'small' we don't care.
> +	 */
> +	if (m_a_occ < (NICE_0_LOAD >> EPOCH_OLD))
> +		m_a_cpu = -1;
> +
> +	mm->mm_sched_cpu = m_a_cpu;


There might be an issue with mm_sched_cpu bouncing. Perhaps adding a 
threshold to compare the old a_occ of mm->mm_sched_cpu with the new 
a_occ of m_a_cpu could help. For example, if the latter (new_a_occ) is 
twice larger than the former (old a_occ), we can update mm->mm_sched_cpu 
to the new m_a_cpu. Otherwise, we keep the old value.

> +
> +	free_cpumask_var(cpus);
> +}
> +
> +void init_sched_mm(struct task_struct *p)
> +{
> +	struct callback_head *work = &p->cache_work;
> +	init_task_work(work, task_cache_work);
> +	work->next = work;
> +}
> +
> +#else
> +
> +static inline void account_mm_sched(struct rq *rq, struct task_struct *p,
> +				    s64 delta_exec) { }
> +
> +
> +void init_sched_mm(struct task_struct *p) { }
> +
> +static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
> +
> +#endif
> +
> +static inline
> +void update_curr_task(struct rq *rq, struct task_struct *p, s64 delta_exec)
>   {
>   	trace_sched_stat_runtime(p, delta_exec);
>   	account_group_exec_runtime(p, delta_exec);
> +	account_mm_sched(rq, p, delta_exec);
>   	cgroup_account_cputime(p, delta_exec);
>   }
>   
> @@ -1215,7 +1434,7 @@ s64 update_curr_common(struct rq *rq)
>   
>   	delta_exec = update_curr_se(rq, &donor->se);
>   	if (likely(delta_exec > 0))
> -		update_curr_task(donor, delta_exec);
> +		update_curr_task(rq, donor, delta_exec);
>   
>   	return delta_exec;
>   }
> @@ -1244,7 +1463,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>   	if (entity_is_task(curr)) {
>   		struct task_struct *p = task_of(curr);
>   
> -		update_curr_task(p, delta_exec);
> +		update_curr_task(rq, p, delta_exec);
>   
>   		/*
>   		 * If the fair_server is active, we need to account for the
> @@ -7850,7 +8069,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	 * per-cpu select_rq_mask usage
>   	 */
>   	lockdep_assert_irqs_disabled();
> -
> +again:
>   	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
>   	    asym_fits_cpu(task_util, util_min, util_max, target))
>   		return target;
> @@ -7888,7 +8107,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	/* Check a recently used CPU as a potential idle candidate: */
>   	recent_used_cpu = p->recent_used_cpu;
>   	p->recent_used_cpu = prev;
> -	if (recent_used_cpu != prev &&
> +	if (prev == p->wake_cpu &&
> +	    recent_used_cpu != prev &&
>   	    recent_used_cpu != target &&
>   	    cpus_share_cache(recent_used_cpu, target) &&
>   	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> @@ -7941,6 +8161,18 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	if ((unsigned)i < nr_cpumask_bits)
>   		return i;
>   
> +	if (prev != p->wake_cpu && !cpus_share_cache(prev, p->wake_cpu)) {
> +		/*
> +		 * Most likely select_cache_cpu() will have re-directed
> +		 * the wakeup, but getting here means the preferred cache is
> +		 * too busy, so re-try with the actual previous.
> +		 *
> +		 * XXX wake_affine is lost for this pass.
> +		 */
> +		prev = target = p->wake_cpu;
> +		goto again;
> +	}
> +
>   	/*
>   	 * For cluster machines which have lower sharing cache like L2 or
>   	 * LLC Tag, we tend to find an idle CPU in the target's cluster
> @@ -8563,6 +8795,40 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   	return target;
>   }
>   
> +#ifdef CONFIG_SCHED_CACHE
> +static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle);
> +
> +static int select_cache_cpu(struct task_struct *p, int prev_cpu)
> +{
> +	struct mm_struct *mm = p->mm;
> +	int cpu;
> +
> +	if (!mm || p->nr_cpus_allowed == 1)
> +		return prev_cpu;
> +
> +	cpu = mm->mm_sched_cpu;
> +	if (cpu < 0)
> +		return prev_cpu;
> +


We observed frequent task migrations during some highly context-switch 
benchmarks, which led to performance regression when the LLC was 
saturated. Could we avoid task migration in cases where the previous CPU 
and the preferred CPU are within the same LLC?

if (cpus_share_cache(prev_cpu, cpu))
	return prev_cpu;

> +
> +	if (static_branch_likely(&sched_numa_balancing) &&
> +	    __migrate_degrades_locality(p, prev_cpu, cpu, false) > 0) {
> +		/*
> +		 * XXX look for max occupancy inside prev_cpu's node
> +		 */
> +		return prev_cpu;
> +	}
> +

Tim found that spreading tasks within the preferred LLC might help avoid 
task stacking:

sd = rcu_dereference(per_cpu(sd_llc, cpu));
if (likely(sd))
	return cpumask_any(sched_domain_span(sd));

> +	return cpu;
> +}
> +#else
> +static int select_cache_cpu(struct task_struct *p, int prev_cpu)
> +{
> +	return prev_cpu;
> +}
> +#endif
> +
> +
>   /*
>    * select_task_rq_fair: Select target runqueue for the waking task in domains
>    * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -8588,6 +8854,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>   	 * required for stable ->cpus_allowed
>   	 */
>   	lockdep_assert_held(&p->pi_lock);
> +	guard(rcu)();
> +
>   	if (wake_flags & WF_TTWU) {
>   		record_wakee(p);
>   
> @@ -8595,6 +8863,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>   		    cpumask_test_cpu(cpu, p->cpus_ptr))
>   			return cpu;
>   
> +		new_cpu = prev_cpu = select_cache_cpu(p, prev_cpu);
> +
>   		if (!is_rd_overutilized(this_rq()->rd)) {
>   			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>   			if (new_cpu >= 0)
> @@ -8605,7 +8875,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>   		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
>   	}
>   
> -	rcu_read_lock();
>   	for_each_domain(cpu, tmp) {
>   		/*
>   		 * If both 'cpu' and 'prev_cpu' are part of this domain,
> @@ -8638,7 +8907,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>   		/* Fast path */
>   		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>   	}
> -	rcu_read_unlock();
>   
>   	return new_cpu;
>   }
> @@ -9288,6 +9556,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>   	if (sysctl_sched_migration_cost == 0)
>   		return 0;
>   
> +#ifdef CONFIG_SCHED_CACHE
> +	if (p->mm && p->mm->pcpu_sched) {
> +		/*
> +		 * XXX things like Skylake have non-inclusive L3 and might not
> +		 * like this L3 centric view. What to do about L2 stickyness ?
> +		 */
> +		return per_cpu_ptr(p->mm->pcpu_sched, env->src_cpu)->occ >
> +		       per_cpu_ptr(p->mm->pcpu_sched, env->dst_cpu)->occ;

This might encourage more task migration within the preferred LLC, 
leading to some performance regression. Is it possible to raise the 
threshold for task migration within the preferred LLC and use the 
original delta time to determine whether a task is cache-hot?

if (p->mm && p->mm->pcpu_sched &&
     cpus_share_cache(env->dst_cpu, env->src_cpu))
	return  2*per_cpu_ptr(p->mm->pcpu_sched, env->src_cpu)->occ >
		  per_cpu_ptr(p->mm->pcpu_sched, env->dst_cpu)->occ;
}

thanks,
Chenyu

> +	}
> +#endif
> +
>   	delta = rq_clock_task(env->src_rq) - p->se.exec_start;
>   
>   	return delta < (s64)sysctl_sched_migration_cost;
> @@ -9299,27 +9578,25 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>    * Returns 0, if task migration is not affected by locality.
>    * Returns a negative value, if task migration improves locality i.e migration preferred.
>    */
> -static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
> +static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle)
>   {
>   	struct numa_group *numa_group = rcu_dereference(p->numa_group);
>   	unsigned long src_weight, dst_weight;
>   	int src_nid, dst_nid, dist;
>   
> -	if (!static_branch_likely(&sched_numa_balancing))
> -		return 0;
> -
> -	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
> +	if (!p->numa_faults)
>   		return 0;
>   
> -	src_nid = cpu_to_node(env->src_cpu);
> -	dst_nid = cpu_to_node(env->dst_cpu);
> +	src_nid = cpu_to_node(src_cpu);
> +	dst_nid = cpu_to_node(dst_cpu);
>   
>   	if (src_nid == dst_nid)
>   		return 0;
>   
>   	/* Migrating away from the preferred node is always bad. */
>   	if (src_nid == p->numa_preferred_nid) {
> -		if (env->src_rq->nr_running > env->src_rq->nr_preferred_running)
> +		struct rq *src_rq = cpu_rq(src_cpu);
> +		if (src_rq->nr_running > src_rq->nr_preferred_running)
>   			return 1;
>   		else
>   			return 0;
> @@ -9330,7 +9607,7 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>   		return -1;
>   
>   	/* Leaving a core idle is often worse than degrading locality. */
> -	if (env->idle == CPU_IDLE)
> +	if (idle)
>   		return 0;
>   
>   	dist = node_distance(src_nid, dst_nid);
> @@ -9345,7 +9622,24 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>   	return src_weight - dst_weight;
>   }
>   
> +static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
> +{
> +	if (!static_branch_likely(&sched_numa_balancing))
> +		return 0;
> +
> +	if (!(env->sd->flags & SD_NUMA))
> +		return 0;
> +
> +	return __migrate_degrades_locality(p, env->src_cpu, env->dst_cpu,
> +					   env->idle == CPU_IDLE);
> +}
> +
>   #else
> +static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle)
> +{
> +	return 0;
> +}
> +
>   static inline long migrate_degrades_locality(struct task_struct *p,
>   					     struct lb_env *env)
>   {
> @@ -13104,8 +13398,8 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
>    */
>   static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>   {
> -	struct cfs_rq *cfs_rq;
>   	struct sched_entity *se = &curr->se;
> +	struct cfs_rq *cfs_rq;
>   
>   	for_each_sched_entity(se) {
>   		cfs_rq = cfs_rq_of(se);
> @@ -13115,6 +13409,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>   	if (static_branch_unlikely(&sched_numa_balancing))
>   		task_tick_numa(rq, curr);
>   
> +	task_tick_cache(rq, curr);
> +
>   	update_misfit_status(curr, rq);
>   	check_update_overutilized_status(task_rq(curr));
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 47972f34ea70..d16ccd66ca07 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1171,6 +1171,12 @@ struct rq {
>   	u64			clock_pelt_idle_copy;
>   	u64			clock_idle_copy;
>   #endif
> +#ifdef CONFIG_SCHED_CACHE
> +	raw_spinlock_t		cpu_epoch_lock;
> +	u64			cpu_runtime;
> +	unsigned long		cpu_epoch;
> +	unsigned long		cpu_epoch_next;
> +#endif
>   
>   	atomic_t		nr_iowait;
>   
> @@ -3861,6 +3867,8 @@ static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
>   static inline void init_sched_mm_cid(struct task_struct *t) { }
>   #endif /* !CONFIG_SCHED_MM_CID */
>   
> +extern void init_sched_mm(struct task_struct *p);
> +
>   extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
>   extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
>   #ifdef CONFIG_SMP

