Return-Path: <linux-kernel+bounces-522955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7DA3D086
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5BA3B907B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE611E102E;
	Thu, 20 Feb 2025 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrmm4Pcc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E913FD1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026588; cv=fail; b=BxQLQ5MWllPSqJv1CybGWH5qQZf66Av4Pt1NTIPGwVVfj+wh80XVoECb6ZST6aCAxZhkjVeBo81f5JqMPEptT1HFNsaTTqA9BdnJIT9Lsu6nKbuHbUHH+8KrK6C/0Uc3/eu5JYLSUqFLhpV/WigNAb1PAC/5AGvNolVYPlu0aWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026588; c=relaxed/simple;
	bh=5INC2IO+JmR5UFdOhWswFgyugcZEaDLEPas/YAqSknc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MKWEsnbgTpkGpkzxFIJSPpYUtcD7IxAGoaZ/M+DBN8U7nLQFd9yqnqdo4OkmqQgI20eA1A7Ltt4G11s7n84H7TslzQo98Spc0mk2YULQS2qaEYJSFNx6osc2BJ8/YzOriDoL5i92UC7gjTvqxJUG1JuAixRggMQvsMR7c+DoBDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xrmm4Pcc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740026586; x=1771562586;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5INC2IO+JmR5UFdOhWswFgyugcZEaDLEPas/YAqSknc=;
  b=Xrmm4PccTj392ABC4R545BAcjM+a1vGS4X7hwLYNddCIr/jRALMgXc82
   Ke6RDhfPXlJ+ZqvPZLttkkuTqxmU2YYOl0CKOqVobo6X6UclqOV20oEdL
   jGk6ea2rHYsEJZ2Z9SF0MV3XpowCh+yQRmPCBE6q2kbhBcyzWsDgrpsl2
   Puh1df7aTGLmSxANUoKMhw1vzzsctGn5IIoLeW7fg/r7JBTCmJ/qMpBSq
   3uGNB5dfBuxI/1P57D2/3KAtgILwZepwSoiw7lIbh1nSfDl5N7JE98GU7
   WY3e/RXZL1ioUeojhyM/zF5etziRouNWm/xdVuDHAl5smNslUZz2TTj2B
   Q==;
X-CSE-ConnectionGUID: rJJePBizTB2nN/EMD9WO7A==
X-CSE-MsgGUID: DD0u9HKNThujLLeZgvGiBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63268574"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63268574"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:43:06 -0800
X-CSE-ConnectionGUID: d7nKfZeSQaqlo+Hzlx59rw==
X-CSE-MsgGUID: Gp6ja/qwQueL47DPro5iuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114654815"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 20:43:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 20:43:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:43:04 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:43:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH7yJIez+LqB7SR9i1/XwAB3Io6Es+/cyD5+gsjl33U37X4TPLtiZD1XGLWn475fWbfn8YTS8kHzWCKRoWRh7JYXtLR3IuPO00Ra6Stqo2Whhl9edTEx7K/klXRLEnDVVFBsdRxatyq7BlYnbpUFYjIViaaYXDGIclLnMgy9FlzP55uW8OEK+ZWD0vPBWdHYJjNH5vNZh0W/mV1sKNt5R2CUhE5zAxdb188CEys82W64mcewn2zQdR37x8Xf0yCyZfcrABhqeacH3sH5bJUQnOqoQODXPzXIGpKmCH0++67oEP+HTe4STLiB9ETNSusrY2uAXcKlDz+KqhR0e24eBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSbEwFiY+YXCqaaNsZn5cxpjgErrS84tMFoC1vhc9Os=;
 b=ujwX1nDrI+6njefYv4sJ+Rzs1WJGW3dsneVuXCjqMU6dJlUg+FZJhNOyiwKd7GQc11wSavA+hflwlXENrd1ttoEPH+DKO9DcFMHspJx+HFDcyanS0fkZv8RypVgKUuvUhEvvACLfUnho7njFUCLS7MlyxJv/q4cEzgP/PZM2d70KpxuMRznpO4z+w8NGJeHf/+ZEgdSjGwWLUQ/ValQJdwzucNmLPlmuiJSQ+r54v7LmVuXqYHZZlC2YQUHNR8YMDs1lKzhtAqZvQEpRMp0XlcAKwLIP8lA5g8Z7HfTThIlt//wJLgMoL4jVvDpzV3YqQFsQtqswrNO/JEvNuaF0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 04:42:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:42:31 +0000
Message-ID: <91026839-2f2e-4562-aa77-6901148c89ad@intel.com>
Date: Wed, 19 Feb 2025 20:42:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 33/42] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
 <20250207181823.6378-34-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-34-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f51e80-8183-47f2-2fa1-08dd5168fc6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZENsVW9BbkxjRzZRN0ZydWRSUjduak9LTlFEdGx0V0dNOUVYOCtsVDNjc2M1?=
 =?utf-8?B?aDIyWWNHNUIxNUJXTm8rcW1XcEx6SmozWEQ0Mm9kRVRCZldkemlZWUJtREJN?=
 =?utf-8?B?UnJTWSt1SUp0cmNoYWE5cjdTZ0VnQW5lK012c1RwbXBiRnFYMVFmbEo2NnMv?=
 =?utf-8?B?eHlvZjRDdk1uSytmSkJPNWovQ0ZZSjFlM3I1ZHo0cnBlZkNzc3BRRm9idnE4?=
 =?utf-8?B?Y09uSnV2U1ZJeXRPYmRPOVdBQUk4aEFyK0ZvbXg1TWV3d2ZyT0dkQzhQQyth?=
 =?utf-8?B?RGJ6bU9zTUsvTWQ2Y0ljcmZUTkJURlc3TTBQTVNYNGdHV0VYWkxoQnpIV0ps?=
 =?utf-8?B?ajRVTk1peHdzcVIzMmpsMXZnNkJSTS9lSjdWNGttVktvbDRDcWJtL2VtMFFa?=
 =?utf-8?B?aGZQNjJSU3RGZkZjRlBhKzd0Y0Fwajd0WllXdmdzditJUU5RVm02aTI3MytD?=
 =?utf-8?B?bm1EZU5wdjBvbUdRMVlhYWNyRlNtVDlMd2JwWkVxaDlsTVFNUGxvUVYyeDc0?=
 =?utf-8?B?NWNXQzJ0SkZVUEovWXQ4bnAxekVBR29ZVlpveS9uLy80TjhUTFpwZzFnM3Vz?=
 =?utf-8?B?eENKWEMvakhnNXZRckhNWk16S0pRSUhoek9UWllXRXJrYTZ3TmVGbmprM1pJ?=
 =?utf-8?B?NGxBbGtvUTdzTXdyYVhXY0lVd1BDaTZKaktGRFZTYWkrL2RPSThob2ZxeWQ2?=
 =?utf-8?B?dStBdTJVcGZTNWttSHBJZXh5SEVrVEN2ZVd0bXZaZVlnRkhTemhYc294enNr?=
 =?utf-8?B?RVN1MXYzN3ZWeStsSkhydmR6UERjcGJuTk04KzhXdWZJRit1dnFYY08wYkxu?=
 =?utf-8?B?UXB3bEs1NXhIV0lOc0tuYzQ0SkYyMHQ3aWVVUWZzWEYxTCtxaWNqN3NyU1hh?=
 =?utf-8?B?NG1VSFhYeGZtTGhMTjJQMjE3ZGtwU21UYWxUS0RacVpxb0tFeEJHUWhjSTlX?=
 =?utf-8?B?b0RFUXVmK0hSbzFWcE5ISnZlU1dQb2RETmJ0eEFjZFJUcnluOUJaUVpKK3hW?=
 =?utf-8?B?SnRPKzI2MzkwbWErR1g1U3E4Y1AzZVRPL0FPK1dnc2lYSEFaRWVXNjg2QVdL?=
 =?utf-8?B?TS80ckxkUVBoQkNuejI3OElPVVo2OW40WjBBcDBzNUZMaG1jYzdoNEs3dGNx?=
 =?utf-8?B?aEJDSXNaMzJydFp4bCtMbW1GRXdDbnY0Y0VDOEZpc0lhcms4VHdnZzJYcTZV?=
 =?utf-8?B?dEg1VWRqcnhycWNRa1oxR20zK1VENjBXSnh5WjFhS0s1NThJaHFTWlExQXVp?=
 =?utf-8?B?dXdIcjBqTkloN3VMUDgrMC9IVEtrZUpEekdoUWcxd3JXc0JwTVpMVHRiSlI2?=
 =?utf-8?B?Z0ordEJMbXVNVGZBY3MxN2RBNStzbWhqdnRPMmh2RFo4QlhPRVRRMXd1YUd0?=
 =?utf-8?B?ZXJKeWNsNGhPeE9GWkp3bklwWERBemY1eFBkWjhQZDZVUUVsNDN3WDRCY2hv?=
 =?utf-8?B?djVKWTU4Z1pnNHVTcU44NE05Z2RVOW11V0xQRzhUNGI1d2F6S2VMOFo0OXBK?=
 =?utf-8?B?elVKOUhTWUtPRHdQQkdqMXNiYWxKdEJzQ3NSallidDB6UFI3RTNYWFphdi9x?=
 =?utf-8?B?UlpQMlFyZThQSjZ5ekV5Zlhncm9tVit6UlFQT3BPRlZlMGMxSjFMdEZLWnpp?=
 =?utf-8?B?eGlvckJ2Rm5aYUQ3T2hlaWJhZ3hnc04vMjlQdkNJaGFmMXJrU3RyWnRVR0E5?=
 =?utf-8?B?QmtjTXhTVTlBYUNURUdoWXR1V2JQbG9DWXZIUFNtdlhlRjkvd2djRHZaM0E1?=
 =?utf-8?B?OWJFQVoxUzNzUVFWMzlJdzgreklhSWlPOEFqOTlvaG55SEFVcmhadndKUUdy?=
 =?utf-8?B?VXM2RjRTRGVWcFN6U2pxSW5ZcEI0Tmw3MzAya1NWZVZJSVltNUV2YjczdGVJ?=
 =?utf-8?Q?Veo+mtFA4QbVb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEpCQXI0SWpRamJsb3I1eFhOUE55SnZidEcxT3FKODJjcUJKelZMRCtPVjB5?=
 =?utf-8?B?ck1EWlJzbHcwNzIwVjZXWm02VVhEVER3NTA4U1V2MHlMRG5FMWlzTTdTTUxI?=
 =?utf-8?B?TGQ3N21hNmFkbEZza2NtNlAvODRGTkpVdHBnZ1NHdVhWWU5yM2djMTFTcU90?=
 =?utf-8?B?VCtuK0VaaEdyT0Zad1ZwenJyMjF0Z2lrSjlFUys3aW55TlRKRWxIZHRhY0Z3?=
 =?utf-8?B?RDhmaVRUemgraGZwWEo5dHBHaW9Hb3cvQWpvRmhLMkFVdngrM0R4RDl5ajN2?=
 =?utf-8?B?T1dTTlJyRlBRMFVYVmRjOWVWMngvN1oxblYrQWFSbkNHdDZTQWZuUTZPamJY?=
 =?utf-8?B?Q1Y5N0ZrdWFBQzRUTHVlVGxxclFGZHIyeWY1VFYrayt2MWl0Q0M1bnNoZHgr?=
 =?utf-8?B?UERqVnI3N0x4YWxhdjNFeUcvVlpUOEZXSkZBem0vTWdVbXAxdm93aWVnNVlj?=
 =?utf-8?B?eW9mT2c1QVUvVDlKeVR5cmdmUEtZMXZHWVBNMFhMemcrMzJOR1ZvWGFVeDUz?=
 =?utf-8?B?TGlvK1IrdWU4em5yaEIvd2pEU3BtY2xERyt6OWhxYnBMZk1VcTgxejRJRzBu?=
 =?utf-8?B?RGhPa2tpRzhUcTRrM1hMNXhRcHREMTRKZjYvNGtIUDhuckRMOVhETTdpYnRN?=
 =?utf-8?B?SUVmSGV0UHBJQVRVYUdvSDRZUGVhOW95bytGNlh5TVMyMThmQ2NxZmt6bUNk?=
 =?utf-8?B?L0hMTE9JVmo1Rmo5b2x2dDVqRmRDY1ZPUWNOa0tuMDc3TFI1eDVHS3JYNnY1?=
 =?utf-8?B?QndsdTBONWxlYU1LSXR3RWRtYmhycFZWUVJXYjZsOVlJVlRqOUttcHhtcWdR?=
 =?utf-8?B?QXpWbTE0aEs4YmRUbmhKa21CVFp5QTdaMHd6b0pDKy9WdnNtKzR6b0RYOU1L?=
 =?utf-8?B?Z0wzazlqclhvMTRQVnR0ZGVJVlZUbE1Ia0JjRllRcFhrcTduVEdFeWNJUEor?=
 =?utf-8?B?U1hJeFBqSzdqaGh0azB1eEQ4TzVFcFpFNU9GWHNlbE1VK21ZWFhDTlhseU9x?=
 =?utf-8?B?RHAxZEswMERzZ3NINlBLRDI2QjZiWnZNTXpsc0FDa1BvcGlvQlV4dnc2MWg3?=
 =?utf-8?B?YkpqbHpmaHl6RGxFZmg3Qzk4WGdldTk3SFFKNXQ4aGtSdGxPaG4vUjliQ3Zl?=
 =?utf-8?B?K3MxRmFiSTZidm9vRmNmdncrSjUvelc3RnE5MUpGR05NVkN5RHdJVExpanFC?=
 =?utf-8?B?bGlCTmR1YmNGcmtEcDlkUDNyYzQ5ZGhIMGNldlAwcTI4dmxrQkdwbDhnd3p1?=
 =?utf-8?B?Z054QVduY09vcmw3c1FYVE45T3lJNW8vR1h4TnZWNGRidERIMGtNVml5RzJG?=
 =?utf-8?B?VHREQXR4WUdDaE8xYTBvNGNmemtNQzZ1dGVVQXdETFVsK3d5OG9COVgrU2xX?=
 =?utf-8?B?ZjltT0ZkempBcXR1Y25vTnRvcUJ0d25ySDZwWUptVEdZdzlBcEluZUgrTE9z?=
 =?utf-8?B?Y25hN0ROQ0tqWEtsVnliMUpIVFYzWGxnOGg3V1N3alh5OHMzNXpFakxHZWpB?=
 =?utf-8?B?dnlRRkMvaVdEY2dFeWszNXo4TzBrMVFyc1lHc1c0NEdSWHVOUUxCa0wrcU13?=
 =?utf-8?B?ZDFQU2JlKzZnbnVNT28rQXFyWktVdXFFOURuWTFEekxPOVRLKy9zYnVSRGNQ?=
 =?utf-8?B?QlR2TUYrOXVDRGdEbUk4MkhKZklLUDNIZE9oVWVUNTVrNi90VUg3c25yUjRQ?=
 =?utf-8?B?Q3M2b2ZTQldPRkRFbUpzTm9TbFVobW9wUDdsNmlwZTFzTmVrRUtobTVhajhI?=
 =?utf-8?B?VG8xZVBzZUMwV1ltQnBPYmprdllQc2lKVURiZ2ltTm1nYUhsMHFNQTMvSklY?=
 =?utf-8?B?NmRlWFZ1b0JnMS9rb0l5R3hEQzQ4OGR4Wlg2UWNNUDNyQ2Q0R0ZFRXJjQXBU?=
 =?utf-8?B?czZ6bGV0TjZRU25IT2xUSVgzTEFJbGFhdHhzeHUvbWYvdW5oY2hwYXpuUHNC?=
 =?utf-8?B?NlM4WCt6NUNtbFk0SktNNENnOW9NQUd1Y0JjSVN1ZlBEVnV5TE4yQTZqbkRS?=
 =?utf-8?B?S2dFekc1R1pSeEtlUTJ0aE5VNXZtY0krOE1EOFBwd1JFRkZYVHIzUVkyaERC?=
 =?utf-8?B?QjNBSmp2UWErRWxSRWpzU2tSL0dwaU5uR2ZMZFRLY0hCaHVURTBLajBPSkF4?=
 =?utf-8?B?Q1ZvNUF5UzV2TDgwS0NQWldSL3A0b3NhTS9YWDEvOUNnOGp0R1ViSlcrRUR2?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f51e80-8183-47f2-2fa1-08dd5168fc6a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:42:31.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IL94fhLA1gmvS3r0TX7NH/YgWOC5VIiBcCBN4vx7+XJHi6F9lG0kesjiz/7yf64agMIPUQBHp3J6agXQsbhWXF6azLTsberx5rOmpgksPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
> resctrl can't be built as a module, and the kernfs helpers are not exported
> so this is unlikely to change. MPAM has an error interrupt which indicates
> the MPAM driver has gone haywire. Should this occur tasks could run with
> the wrong control values, leading to bad performance for important tasks.
> The MPAM driver needs a way to tell resctrl that no further configuration
> should be attempted.
> 
> Using resctrl_exit() for this leaves the system in a funny state as
> resctrl is still mounted, but cannot be un-mounted because the sysfs
> directory that is typically used has been removed. Dave Martin suggests
> this may cause systemd trouble in the future as not all filesystems
> can be unmounted.
> 
> Add calls to remove all the files and directories in resctrl, and
> remove the sysfs_remove_mount_point() call that leaves the system
> in a funny state. When triggered, this causes all the resctrl files
> to disappear. resctrl can be unmounted, but not mounted again.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v5:
>  * Serialise rdtgroup_destroy_root() against umount().
>  * Check rdtgroup_default.kn to protect against duplicate calls.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6e30283358d4..424622d2f959 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4092,8 +4092,12 @@ static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
>  
>  static void rdtgroup_destroy_root(void)
>  {
> -	kernfs_destroy_root(rdt_root);
> -	rdtgroup_default.kn = NULL;
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (rdtgroup_default.kn) {
> +		kernfs_destroy_root(rdt_root);
> +		rdtgroup_default.kn = NULL;
> +	}
>  }
>  
>  static void __init rdtgroup_setup_default(void)
> @@ -4371,9 +4375,12 @@ int __init resctrl_init(void)
>  

Could you please add the kerneldoc you proposed in
https://lore.kernel.org/lkml/f2ecb501-bc65-49a9-903d-80ba1737845f@arm.com/ ?

>  void __exit resctrl_exit(void)
>  {
> +	mutex_lock(&rdtgroup_mutex);
> +	rdtgroup_destroy_root();
> +	mutex_unlock(&rdtgroup_mutex);
> +
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
>  
>  	resctrl_mon_resource_exit();
>  }

It is difficult for me to follow the kernfs reference counting required
to make this work. Specifically, the root kn is "destroyed" here but it
is required to stick around until unmount when the rest of the files
are removed. Have you been able to test this flow? I think you mentioned
something like this before but I cannot find the details now.

Reinette


