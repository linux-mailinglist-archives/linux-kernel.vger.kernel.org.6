Return-Path: <linux-kernel+bounces-537677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08EA48F02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C4216D783
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E17186294;
	Fri, 28 Feb 2025 03:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIBx/Duw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1917A2F4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712397; cv=fail; b=N8x5YAnco7znsy6LCiuXLj5vmjY1BW18mZIhfTzkNUJgrqzQgPQ1ztEh8fb8SH5a3iMz4hHzADAXtbg5YFQiaYHOICrGUSLw2yjHPAKXZyUnooLVyNuRB8nOW2DT8QAMbz+TGZylbOmtN3gkw7MSkLWCh5IaKZ9Ffcdu/sNSpNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712397; c=relaxed/simple;
	bh=wDq6qDJoStnHF7GvyaQwUyeOzIPNo3OsgVKAMyvIUD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V3d9TlvyfTMRbp2Mgquz2+6oVD+CbLTfDnqt9hjMPqlvHmUGytz+0qMI7OnzbRTYDfoisnxKRMDOFdIZVw6X4mpFAO+XF62dCTktEmFrVi9N4PE/DyRK38ICDduA59EW5bt9QGT2RNQv16nMF5bskD1qABxVPqivTNlx3yrpZPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIBx/Duw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740712396; x=1772248396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wDq6qDJoStnHF7GvyaQwUyeOzIPNo3OsgVKAMyvIUD0=;
  b=HIBx/DuwIfBjISk/g73Ej77clYIRX4p4HMVZkejAwc2/YNYHx1xF3dFK
   +FwB0CC8I/SA14t0UMA2MEHDfNihyDbxEIVpCII/RfpXjGgyVynpzjlZa
   NrpBC6AX3HoyhHPgOBGvjPvK8Ie8koa2ezRRc39ptspx/OS0SqZKSz6Ig
   fyWi6bO/1V/YTUhij60jJ3URq0t+Zs3a7FuQke9f4drSgSI4s/S46Xpbw
   wttjo06/A+qq12mcpvZrBQ0MsE4taV8uBtl/gloK2dfpZBBT/ZbNTGm6Z
   4PfiNrD1BW98RcMP6/EAcXllQlI2+e52RDrRx9IH8X96p1b8ddHrxHQiw
   A==;
X-CSE-ConnectionGUID: 7FPEy341RRWOpOTRTptAXQ==
X-CSE-MsgGUID: XcjbPWajSQ2ptPHOhwIZlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52274326"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="52274326"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:13:15 -0800
X-CSE-ConnectionGUID: 5LI+Biu7TFqEUKfc3oK48A==
X-CSE-MsgGUID: bxhQqCCfQpihtE2NvM0tRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117087192"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:13:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 19:13:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 19:13:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 19:13:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Khn0eGfvMzpHq/VqSsRQT8zpxP6yEBvre8xqx9C2JsBf+e6gvUCSYiydy0AQcsIVFstKYLHE7STnOUMqn7ilr34rZl42nZTGDgD5frgFV4Zz0NaJyP868xGzJhgCzGRsDO66kG+3db3Imkd38eC536ZQPB0PngAy+EOD+I/+2+X5FOIgBIsqfOKWL768uQnyP+c83GmQsTFqmKDhxzH1OTpASXDtnhS3Evi8qnjq783QjUYROLGupf3PEf00e1hOtIPD+4kfQYZmIk6fgMEpoYh9WGb4NPjhBxsFBKn0AkvW9U6ttAJBUoyCcfjWvbhDhIjHlVoUD65gp20mPrS9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYT6sDKaVRpbDImuRDQe5OY24vbZ6HGZuYo9L57HcX8=;
 b=kCbZlh3//mLBAZ7w0GNNGDOUffEjtc7IxOVqXrD1mPHzBOD9G3Tp4KlAzPCIJLDv2aED9yoySVO2aoPTOkRfWU+E/3+xV0Orw2R/6B49weQFTH+ST4Vhpd3hMYpfhDkUCLnH17lVn9NQeu3gqMeTMaGzFRMDx+A5uKBOdbPJ1Db0OfMEK5KzMtYpVusmm3ljoKUK9eLoDb5mDWDV8JfU1BaMb1IHnVeFOXox4A2Ngi2LOdSBX4W5nLDKCR01NpNzDdHW3U+ActtgNEJ0l0DSOJaWlk3uxjo1jj0XhToJW39IS6J5YRKIzOJOp0rY1iTkgIPX+N87yW00cso++g8IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:12:58 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 03:12:58 +0000
Message-ID: <1d269a00-39a1-4c64-ac00-d90abe420f0c@intel.com>
Date: Thu, 27 Feb 2025 19:12:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 06/11] x86/fpu/mpx: Remove MPX xstate component
 support
To: Ingo Molnar <mingo@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-7-chang.seok.bae@intel.com>
 <Z8C5B9PJUqkEDGH9@gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <Z8C5B9PJUqkEDGH9@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ec20ca-d007-4707-0cd5-08dd57a5cd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXNBMnBtWUFqM0NrR2VDVlJtTUdzU2NJSGpDTDRyVlJ5dUM5bGI5dm1nbmlu?=
 =?utf-8?B?QWpuVDNnWndQSnY4V2xFNEpBUThuY3gvR0pFSVhHN0FWc0RSWWE3WVhWTzJJ?=
 =?utf-8?B?WXVISFM2d2o5MzZtaXRzem9JbitiL2EvZk8vcGRzR3ltZitYUWJ2UmhRQTAy?=
 =?utf-8?B?ciswMngvUVRKZFdHbHZiQkh0NDhQaHVaWnNhQnkxNUMvcDFXT2VldjRKa0Jp?=
 =?utf-8?B?M0FGYU5wcDdodUVTOHhxQzZhQzZNdXFUU2xwdWgrOUxXWU9hRkZIandaVjdm?=
 =?utf-8?B?WXc4VVpOQlhXL2JLZEV4OXFjb05ZSXBrMG9aRmFvN1dNTzh0OHpTcU45VWJL?=
 =?utf-8?B?YmRrdnYyL1ZjSGFrSEhZTzJKMjlnQUlib1M4R09UTXN0QXV6ODg3b1MxWTRM?=
 =?utf-8?B?bjdZb0RYcmJpTkx1NW9GWGRFTVR6VHBiTk1sNlU1OHozYmtCT3RkbEp1ZThR?=
 =?utf-8?B?ZVFFSjhteXRYM1pjTFY0dzJDZzIwcit4WDZXSEZXRVd2b0ZOSEtFbk1QY01N?=
 =?utf-8?B?SWpwZjFVUVBLdWVBczUwZGFjYjlOdFNtUnExUjZJR0ZZUFVoWE1VRnlySTEw?=
 =?utf-8?B?aGdDM0J3ZGNGdG9idDNFUUxSNmZvRDh6UWF4bFhpbXdJTEgrYjRERUpRdCsz?=
 =?utf-8?B?QW5jVXVkQ0gxWFJjMU0ydHlIdEhUVThSZmR3SWVLZDFSR2pvZy9XaWFQQkp1?=
 =?utf-8?B?UDRoZTJuMzdsMWxLWmJFTmZVczhmSjFxZHJJT1BWNnM1Q2xlbHRCRlNLMWlN?=
 =?utf-8?B?UStHTDBPcmF6YkVNYkhSV1gvL2JYMWxiVDcveGE2TlpHcDZPb2VPUUd1aCs1?=
 =?utf-8?B?bUxSSXRTb0s3bG9KRjA2dXppRmtlRmN3YXlNS3VPdSs2M2cyaUN0RTZJV1hu?=
 =?utf-8?B?amtaV2ZFT1ZmZVp4eW5KbmsyRllHaTJUY0VZL2dyYTkxS3ZMSk0vd0NsUEtC?=
 =?utf-8?B?aEVqc3lQMmNlenJxZFc3OVhpYVBRNGtidytYTDgybk4wSjZxTGhEVTFlR2tG?=
 =?utf-8?B?RGtETEhMRzQ0UUcxbEQ3eW9ZdytpV2pRVTYrcnhqNjBHT3NhblMwOVJ1Wm5I?=
 =?utf-8?B?ZHpqbzRuQ3dzbXJJck5Ic0FUUFFXUm1SVG1iZnNhd2NQYnUvZHcyREJRdEJ4?=
 =?utf-8?B?UUpMeEVSSkh3NG5IQjRJdlhTVHMxSE5xcG83SlRKay9BVS9YdjYzdlBPN09N?=
 =?utf-8?B?UUprMGR3V3VvSm0rRDRyQVVlc1dsMTBrcTdTR2xGdWI0eFpYYW9kdGVVNjNX?=
 =?utf-8?B?bFZvRWh0QmkyekRleVNIY2VVejhNN0JYU3NjM25jVWVIZGk4cTFobVFIT3VI?=
 =?utf-8?B?WDJOclkvcGNsQVkxYlhzSm1EenNrQmFYLzBMTGVvd1J3NVRRdWJpaUFyMXFR?=
 =?utf-8?B?eVkrbVNsZ0QwVDhlNkczcGlIRTFhQ2pxOTJxSGVLd1NyT2ltdXgyYWZJS2J0?=
 =?utf-8?B?WGNORjBLang2UUNRVjBXYUQ0RmpyUWlQT0RIdXRzaWR2aUVVUGNvcTJPQVha?=
 =?utf-8?B?dEdZeFBWbEdsenU2Z0t3dVQ2amk1WndhOWQ4ZTNIamxMTFFCSi85bVlvVytY?=
 =?utf-8?B?azNHUTd2L01ESWxMWkNCSVk0T1RNMmZJaDA4dm5ueENjM1J2T1VXcEdrNDE0?=
 =?utf-8?B?MkhLdzRtRHNsRjlvelYvc3hpV3lNZVNWMkNnTExxMlE2eUdyN2tYbW5EZ0FB?=
 =?utf-8?B?VC9YUG5qUEFoYTk3WDlBOU9EWTBFbm1Oa29uQVdlQ2pVZnRaOUpTSzgwa3NR?=
 =?utf-8?B?NjVNaTMrOUxKREJCVmVXbkc3QjVIWFFpdE1HQkpyblF1c2R5enpHNDdmcE8r?=
 =?utf-8?B?czJJL0JoQkNvczJXUzhOMWc4OFljUSswYTdhbkVjRTRRa2x6MXdUR29peDBk?=
 =?utf-8?Q?6MjLKp44SUmjx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlKN1h0aTU3bVhrWk0xWjZZNTNNMnRHc1B4VXpscVM4Y0dLdC9qd1R4c3BK?=
 =?utf-8?B?UC9YWmJwa1hQYjFRUW5qWVhsTEd4NTQwUlFOdnFVR1NUUnE5VDYrd0haTVZt?=
 =?utf-8?B?SVlKbTk4L0FLNDBYTkdEckI5THZ6V1dmMWlLSkdrRGxtVEdyeHBhRmQwUmxK?=
 =?utf-8?B?eVR2LytVUUkwU3NpcGkwZTBBK1A0TUthSU5Ycm9tVDllSjU4UElSZnJRUXl6?=
 =?utf-8?B?K09ZYXRUbS9kN0pKVVVzeWpVN0xpeE5YOUwxd2dCVmtNUm4vaW01bXQ2Y2NB?=
 =?utf-8?B?bzVRRmY0TDl3aDZWT3pTT0JuVGRpdWZqNXpuTElWUllacHZYWGdZZ1pzRnZN?=
 =?utf-8?B?UTdyVU1ubklxWUp5TmRjdkl0RkIvODd6bmtKcnpsQmF6ejluR214dU9ReUMx?=
 =?utf-8?B?QjlocXhMVUF2dkdMNXRRNGNpVlZHc1RYOVFxQzRtSjJuUnhnci9GRTYweDUw?=
 =?utf-8?B?RzFuVGltY0ZLSHFQam1Oc2s2RS91OWVsV3hmT2d4MzFLTDFnY2JwV3Vsa0x3?=
 =?utf-8?B?dEduUVpNenM5WFM1ODc4SUpqK0kraERDYnhZMVZWV2tnQ0FpRGliM2FGYmNj?=
 =?utf-8?B?cGZjRXhpejJXZ2cxeWFtUVBHNXpJVWdGbVI1Q09WY0QwTWJnVkJxRTdQMGl3?=
 =?utf-8?B?bDNDY2p5VTNQald2dmhJY3ZlQU5FWW9jaEhuSnhza0R6emhnV2tzcERVM2Ju?=
 =?utf-8?B?Z0J0QWwyRXU1OHY0Szc1QmRiNXEzcXdCaVVSeUN3YnNtZ1kzem1tTy92em1y?=
 =?utf-8?B?d1hXbVpRanVkTi8zUVNIUk1yOXNPVHhXSEZoYVJaNkl1VHNUblpwN2tjV0JB?=
 =?utf-8?B?aXlkUmpJaXowbFZtcnVhTUpmdlBFTFZNWFo1ZWJSWUR5R2plM21lZklzODZm?=
 =?utf-8?B?OThtMENOK3czV2U5RFk1TmZMOXVHL1ZHZVArV0hYMUFNZXF3UldZZnhyVUZn?=
 =?utf-8?B?SE0zZmdVVkpJamFGdXdKb0pxVnM3V0RNSnJOUGVOV3p2VnIzZkFZUFk0aHpG?=
 =?utf-8?B?QkY4Vm5rRkVKcCtpSjhSak1HcXYwUExVYUFGRjFudEluWEJhc0p1b2NtOVBQ?=
 =?utf-8?B?alUvRWlnNTVDYXpVWGt4NmRmaVRVQ2FEOVVpYVZHNFNDVjlTSGw1ODg2SDMx?=
 =?utf-8?B?VXBSVGwyc3dNaVZlaGtXaGZGaUFxTUFtbWlzNTNaTnQ5U0k0QlMrYlB6Z1B6?=
 =?utf-8?B?T1gxY2k0TVc1RThpY1VKTGpadlFsZDZhdGVXS2N5cGZKOHRXMjlaNmhhQldL?=
 =?utf-8?B?bGtrdnlpMnVtVC9qbG1IU3NXUURwZ0lQTzJOcllpSW1wSUxnaWV1SmVEVDI5?=
 =?utf-8?B?T3RZT0JrdjZuNjVvY24xWll3VEdsUVljQzVmbFNmSGRibHA1bmxNZlFoaGZM?=
 =?utf-8?B?bzJmMDQ0NHZvZzQ2NUVkbzRpc2hvRmFCcWJHUWNoOTd1UFpaOUNYa3hER3lx?=
 =?utf-8?B?SzBBOVdPNEZITzNLaUFYdzAwQXlLTWtLM0VrVForbVBnZzF4bGNWL1VzZlNB?=
 =?utf-8?B?YWVaOW9XMUc0d0VOemVxR0h3N3V2SUNyN3VzcHJCV3dYZ2cxTnFiWGd5Y2xH?=
 =?utf-8?B?TEU4Z0RrM3E1eTRmSU8wTER2RDlNSTVyOWoxQnluL0N2TW8zRnVIN2VBMXE1?=
 =?utf-8?B?bEdwSjhzK0dMaFduZGpsdkx2SFdsZTluUmZ5aWpFVmNHd0h6VEhkWHB3dW5k?=
 =?utf-8?B?Yk5VRUZFSFdTQ01uSys1UDRVL01uOEczTUpsRmRucjFieUVSbGhSNzg0WllR?=
 =?utf-8?B?bDdLRFVrVmR4SzVGeTFtcm1BTldJemZDU2tRSDJPWTNKSnR3eVd5UTBrZE1m?=
 =?utf-8?B?anh0SXNubzFrSSttbG9ZZkNjbk53SnhxV01weWw0UFpkZ2x1NlBjK0I0dUhI?=
 =?utf-8?B?RDc4bUs2SmxuNVJSUTUvZmVHOVVTb2MvSUFGYi85MCswTGpET2RoTTVuTlZD?=
 =?utf-8?B?VkkvSUZtbnFsWDlkdkRNMVRaRnRvQXNOczhJMUZNMVpOV3Y2d0ozS2VqdE1K?=
 =?utf-8?B?dlhWRW4yektJczdtc3RvMG5XMzBSUTBCa1VaVWNaVEhUODBFUDNYeHk1RE9B?=
 =?utf-8?B?QkFNbklQK3JxMlRrelJ0US8yWFp5am5iQXRmL1RmeEExQzRTelpUMCtTOFFF?=
 =?utf-8?B?M05yb3FmNlVzano3WHRhOXZSN055dW5VOGFQM2F4eXdsQmtoVWl5SzYwMXpk?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ec20ca-d007-4707-0cd5-08dd57a5cd6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:12:58.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUuQSOmJNfKXLAYYeTjFjU34KPxmvLxja3AYXAwTzm/szWu3SvQ3GaRd/P81OWR7PjuO7syo9tDFAj73X1jaKhvbnd7o8CWN+/PtGvPFRYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com

On 2/27/2025 11:12 AM, Ingo Molnar wrote:
> 
> So can this patch be moved further up in the series (without breaking
> anything), to make it easier to review the impact of the APX changes?

Will do it.

Thanks,
Chang

