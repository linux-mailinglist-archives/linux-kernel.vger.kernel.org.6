Return-Path: <linux-kernel+bounces-378966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A109AD7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E061C217C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477C1FE0F1;
	Wed, 23 Oct 2024 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ME9mH9eU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414D4D599
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723335; cv=fail; b=Tb93S80qQH0bLgadKivjh+BjZhOjELOla3x7rr/J9+Vhs01/kc1LSlP4xs+TUvu8lmkzHHpnofmprMQlwG2qQlwCa0lWrAkoAhP8Y1ib31KuB/xzjfiekvPVqBdYSzhWUuiMaltvx9m7kRj87jl1R2KJsC0Ik/B+/EzfDvx3GX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723335; c=relaxed/simple;
	bh=qM3En673oQ55G5QZh/Ve7fS/fYyXguIndtiEheN0mJk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kf5kjfrFUVaSi9mRmp/5GB2/AbCXciSKZMTBNHHbQLsBuEbraR0Prtu+r0SSYiinpCiRapENd89UfUalZgC3yGHc4sg1kjf/+O0axj5O3mHhFJVjrEFM8+vBG0iWe3rRXUoTNYNAtNxLwZGkUWEjLvVjJCRSJXsrfekjipZPMA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ME9mH9eU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729723333; x=1761259333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qM3En673oQ55G5QZh/Ve7fS/fYyXguIndtiEheN0mJk=;
  b=ME9mH9eUKgUWkTYa02szmfZwEiIkPcjWMXWQmGLDGkIdASAKVn04sfd3
   0hecNKREFaFld08enKJEPX85r2Tz+LF1Ys1VGA2umL01+WYRczQkm+h3h
   0bnFjjRMZkOsAcN8VuxzS13+i33CUaxK4senQkP/LnatkBaK0jkTo+eZt
   qV/dqE7/nRMiQlp3/Z+1Rv5wj75zcoQrpePJfdd1hiZ73yIh0HP6MkdPW
   0lgD2hc5vYBdxUY9XMmI/Byqw8nWN0hRkdz5dONhj30STQGxkSzOm6jao
   0lcwdbLPS3720Og1jQow4dfJlWvRecQRfirmtE45WVViY+p14N3NDXhc2
   A==;
X-CSE-ConnectionGUID: 2pwITPMFROivKJHccFvexg==
X-CSE-MsgGUID: 0nxXwDWLSC6HXoiDXgyWGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46801139"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46801139"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:42:12 -0700
X-CSE-ConnectionGUID: YiJEUgFESSyCrZKVrli+rg==
X-CSE-MsgGUID: GdPWdP87QOWC88YM0XDRLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="79975525"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 15:42:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 15:42:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 15:42:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 15:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEr3w4BwIh3AVFAsy43Aj81xbhuXwXPrFtMNUV4U7UiqUae1kHVM+h2WAn6yjBQCmB6NcxZrBl8QMH2+y8VNcMEoCQ5j5juoxAUUsrnxbQzGcT+rr78IqPY34VE7R/f69U1NOWtBPW30LjEA0Y26NsAr9SgL6m5HjOeEJIqnmvmTZ20SRSMnjmnXDZix/ssNXMUenxg5qVe1DrPh/zKfjRA4tFeeXh/W9cypWjCvV2ZkCQF0i1D8d6ScCpI4d1c7JAUphTPuSZhh6R1OpDwu5wh0KdjDwz7ssuTBwnh4aSBtTW0D/0n8UFfLZqO9W9Nlqcvi2iwyA7clFkXn3skAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA8JO/v8q1zYCRxjc1bF0q15A8X5DBUP9x6SkRzRlyE=;
 b=s0buUa3Gw/xnmhRQl3n03KqY2+lrLspXXT1zRU3uTRPF2xlasFhUuiD0lUaUlzro53nEGuqpUxgeUiT5hbXIUff6plfJoUbYxEUjNUNBAmFet2oA6zzwKSrQNPbhXW+7mta7f+8gEbx6P73JFgKe7zGmfQT4H/BNQvlWHQo2/QFhOYSmHa2pstfqhf5zTKLqUJP/BjO3pR985u24kypLQlKOmgN0mzfyB5vQCk5o8brR0sMYjHSXslIqCJO6yClnh1O2tbd2ybz8ND+V/b8UoIvY+dSEiCGRswOZV372vd3NYLvaLn3uPJzFwtZUA/SzuQ9bs3LrUfTJ1wIXttsibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 22:42:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:42:08 +0000
Message-ID: <adbe208d-7a16-46c1-88ec-ceb99122f84c@intel.com>
Date: Wed, 23 Oct 2024 15:42:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/40] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-23-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20241004180347.19985-23-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:303:85::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 96401885-fdcc-48b0-3dd4-08dcf3b3ed4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzZCc2RJTFFWeFlpcnN3RmRrdzV2V0R2aHE3cmdHWWFhQlhiRk9FeHRwLzd1?=
 =?utf-8?B?aTBNK3FIM3hBWHZzOVY3VzVhR1JJK1ZjeFExQ3cvK1FvNmduNUdZN2g5T1pR?=
 =?utf-8?B?ZDE2T05LdEFhQ2xlSFFWRlREa1VENVk5WnM5V1lHb252S3lwWm1vWklyQnRy?=
 =?utf-8?B?NUk0Q0VEa3V1elNFMis3emhVWjhISVFGYk9ZMjYzMnlWTmFHZVorbSthZjdm?=
 =?utf-8?B?K1FZWGJHRmJGT3JpOHVuSGt0VmM0L0JVejFDcDVuTnVjTHlRMTY0NW16VEFx?=
 =?utf-8?B?T1BOWThTc3dNN3MrdUZTSmc1L051ZFhFMm45NER2NTgwbVZGNlJCcVg2dXly?=
 =?utf-8?B?a1ZTdmszOUhlaDFoT1RiaDgzcnRma3pjRG85cTdzcjdYMldrUWFkNnpxQzlr?=
 =?utf-8?B?NmZibnVRQlB1ZTZ4MWx2RUp2clJ1RVd2Q2ZvOTgyYzJyMFQyVTlTZWd3Vkl4?=
 =?utf-8?B?KzFZUlJxeUlCSExWS2MxOGlycnUwOGFaTWc3NDBkUnVNZWdmcG5icnRaZDVM?=
 =?utf-8?B?aEhISW5Kejh0UEhTUzdYdVNpUDVKaHZYNFE2UzZ2emw4QUE3UDFpZmV0bGdu?=
 =?utf-8?B?cWdjeS9NRkJ1blFNNXZQSS85b3lWS2YwM1NGUDdRdXhmVTRPRmVZM1dWZlpW?=
 =?utf-8?B?YkZPSWdwWHViNjJWdXhUNVFFUGxqTWg5OVk3RkZwL3E0YVgvRHlod1Q1Rkgr?=
 =?utf-8?B?a0ZGVUxiRmNNRWkycjl6SVBUYWVLN3k2UmFqR001ei8rZFgvYjMvM1hRaTRT?=
 =?utf-8?B?QnhBdUdCYjlYQzhEemo2MnBwRDlBdzhMdHZDTFY0REc2am5TMndpQ3lxRWxD?=
 =?utf-8?B?R1lMeHJTdUM1c1Vmd2F3QVRUNFVsYjM5dDBBY3FTeVpUZFlaVXpROWFlUjdu?=
 =?utf-8?B?TVR6QzBBWlVrTEJJL2cwNDBVRWM2L0NsR0VobkIwUHA0MHZDTXpRdVNJUThs?=
 =?utf-8?B?bHlKelo2Y2Jib0JpY2RaTm1vTWF1eEFSWEYzeE1BMWs3NG9sTDg4VGVIUXhE?=
 =?utf-8?B?NWRJRWpVbk1DeW5zdVN4QXBiM1Q0aHJMN0p2ekQ3RUM5Sk1oSkVyNHFYU0M3?=
 =?utf-8?B?WVczaTc1L0t0a1lIOTFWSXpFNzBvQ3U4K2d2dTQ5eXMxVGpHbXVEYzljaUl4?=
 =?utf-8?B?QUxZMkZ2alpxL2NvanAzZ3RKTXEreW9oUnloNTJEcU5Cb3FMdTM3YVZnbkdS?=
 =?utf-8?B?L01VMU8vd2lPd2xjUEg2SUx3QTNhVXd5RnBDRm02czJIRFlXbmw0RFZCV2Zw?=
 =?utf-8?B?TGJ1cHB0V1c3VHFIcUc2d2szQUt3YXd4dFIzSVFmcFpqeWZ2UytiQkJLdDZZ?=
 =?utf-8?B?UXNvbnlrWng3bnp5cldNVlh4LzJmbzdvZmJia1VDQ0xxYnNWTWxGRmgrdEZp?=
 =?utf-8?B?c2NBWDFQZ2JXWmhucUtTL0tqTnFieTFkVmZ5VkpyUzR4bmxIandrNTFCaWJJ?=
 =?utf-8?B?TW9kbk5sZUxtWlE2OUFxRUsxcjg3dHNrN2dLTGttdzBJazlSajRFa3pITTBI?=
 =?utf-8?B?dGVoTEszRmhmRWl5RHUzR25qdm5ZM1FoNFNuNVFQczNIQ3JJNmR4T2lHckVQ?=
 =?utf-8?B?Mk1YMk5FTkNxT2R4TUFyLzhLc05Qb1QxQWRaSVRwMHppN1Q3cXFqS0VHN01V?=
 =?utf-8?B?T2E1cHRvZ2xBVXl0WTFmZUpwYTNhaHF4bUI4VGhqMXA0R0tESDdYMnE5eVc5?=
 =?utf-8?B?MFpIZjVwMm12ZklHRXhpL0dOS04rWXk4RWRzazF1bkx6Q1A5VEhWN3JRWVFW?=
 =?utf-8?Q?FU4vY1gBH7ct5faERqWa7CELU8etGLFUm5F1X8r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWV3YkxUWXVFdkhmTFRuS295VEJpc3MzV1ord2pnMlR1djhmTU5Sam5yRkh2?=
 =?utf-8?B?Y2dWTUdKRGx4SHNVR1Z3cmxhSUVZM3ZieXNxcVQ2V2FzWkJhTXV2dkxDUzQw?=
 =?utf-8?B?b3NKUE9OSVJnTjVZTkxrNWhvQyt5WVhTMlJ1UkpmWG1qcHB0VkFXUWw2Rkc3?=
 =?utf-8?B?dDNpUW1XditqaHUyTVRUZ0g2YXBDNm1qYTZVQ3FOQWIwaUxVVDNobmdUa3Jx?=
 =?utf-8?B?K3VXQUVYWXpReWt1ZG5OV2YrS0NwUWdSZjF5TGd2dlZ0Y2ZWZ1N0bW1ad0tK?=
 =?utf-8?B?eVBYOTJSdmNaeGtOZHlHTXNDcmx2ZGsxcThIZVFWUjkyQnVSclhvR1l3NWhh?=
 =?utf-8?B?VHNhTzFia2VRRUpKZjNWdDFVNTQrWUQ2M0tiYVY4N1Qxb214Znl0Qm1WWlJ2?=
 =?utf-8?B?UUkzbU9ORjZ6NzFwYksxNDljNEpyb0k0eVRjTDdOdmRTb1hseEZ3UlhJS21L?=
 =?utf-8?B?WkRTZ0hOV3d6MW9Sb2FKRXdwblFKRkgzYklUK1hWa3ZOUnlkbUxHR3JzTks4?=
 =?utf-8?B?OXdKTkZtWExoaFdJOVpwNk5tWFdUMjZRTFZHNDlmRFUrMDhtVUhoa080dVY3?=
 =?utf-8?B?Kzd3ajF3T2V4VytkS1pta3hoSlh0R3dTcEp6bFRQQkhRdCtJM0VsSmJ0QVJZ?=
 =?utf-8?B?Njl5M3RYY3I5OUlCNkZLeWJEYnFjZ0dZQkVQcDRhZ2tPbUNhQ0gwd3Y3U2pj?=
 =?utf-8?B?WS8vbzNzK0FQTlVtSklqM21JSHZTNnFQZVM4cEE0UmVJUVdHcVFsY3MzNzRI?=
 =?utf-8?B?anR6YjNRczFRZCt2dTlEU1dES0xlSS9wU1cvQjVMY1hDU0RUMllnRUtMY0VZ?=
 =?utf-8?B?WGJzbkxBTzh1L1JTTEExMFp1OENjb2tEZlZZandFUzA4MjBZVWsvZDhRODhm?=
 =?utf-8?B?L0ZnWGhEZVNWUTVueUxJNFF6MHdTN1g2Z1UvOWtkSFRiSDB2TFhKQ0FaZG5M?=
 =?utf-8?B?cHhzTkZSbERJZ01XQmpxYXIrbi9CMnlqaE5oSnNDNUFGWHUvU2MxWEdYQnFM?=
 =?utf-8?B?SjBoZ1FzZDg5SkFXUXhPTDhXWkx5WEFTeVI2RFQ2VXEwSWJXUmVYcWw1Vkpp?=
 =?utf-8?B?aVdLamZUUEhPd3o4WjlobWtITG85UERMbWJDYktVd2FBWXRhcUVWbStxajBk?=
 =?utf-8?B?U1VpQXBVenJnZ2JtSGlYbkdaVHhoNUluMEFOanh5cm11cTAyS2hqTTJ2S3FP?=
 =?utf-8?B?b2h3eE1aMitYV1FTWXlORUg2cE5vR3R4VkYwQTlCTElFVUpsTW9GcDVVS3Qx?=
 =?utf-8?B?LzJUZ2o4b01pSUo0OFlibHRaQlkxc1JjSHZ1dHBRK1NwWE5RbGFpSlJvdzRQ?=
 =?utf-8?B?STloOGJ2S1U5ZVk4bU9tL212OWV0TkJDemxMRWdUSXR3VmxPa0lMWTh0cm9K?=
 =?utf-8?B?SWp6NlhoVE9LejJmVHRzRDYxWEI2bWllbExvMjFjWUZlZEowdHpyaUd0V3N2?=
 =?utf-8?B?RUtBK1V0UzZFWjFEUkJkMHRzNjc0cDJrZ0dZM09hcXZ6c1dMeEJTV3NGbXVE?=
 =?utf-8?B?RUZIV0IrN3VLMU1Hd1FtclNMdzZLWkJ1b3AwTm5pMStxdXhDalNqa20rdGtS?=
 =?utf-8?B?ZWgrZmxTRThXaksxY2dEYUd3eXVzYzVoSXhZaVROR0FkVUpjcDIvOFEzMC8r?=
 =?utf-8?B?d1A4UGgycy9SU0hJRUpyNjhGbDBHcFZjQXZXUnhtc0o0blpKQWlaSVlkMWxw?=
 =?utf-8?B?Zm1BWU8vOWlkSit6UlczVFh1azgzeGN0THZNdmRqV3Y5RUZOcWJRK3VjRXIv?=
 =?utf-8?B?U2ZwOXhIYU1pc0trNUpLMVlPazVDUHVwcnI5OEdIVTNtcElITkhUc2hPc0ZU?=
 =?utf-8?B?REZRSmY2WmVpUXBZYWNuOVNhckVKNHlUTUdXU1dYb1NsdFVEanJvVDROYmNk?=
 =?utf-8?B?NFRDck9OeGNhcVcrMWkycjJzTWVYS3Q5dDRsckRxQzExTmFlVXN6RXM0UUxW?=
 =?utf-8?B?NEI0WnhnVU5sdEdWNU9FajZpZ3FpNWQzUndnT0I0YkRic2F2Qmh4YmRVMldK?=
 =?utf-8?B?UHJUMWRWbXBqUGs0T1FLUUIzOWk4cHV5eU5vaURZMVhXNTI1SlhhMSt5RTgy?=
 =?utf-8?B?eVpWek54WUZUYXdmQTdaeE5TOUc5OGZkS0RFVWtqK0hnUXJPM0dVTWtWTjJQ?=
 =?utf-8?B?OS9TYjJ2MG1objU3OElUd29OeUFCK1NPSUJ1aDBCd3lDL0ZTeTJBcXd3M1pW?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96401885-fdcc-48b0-3dd4-08dcf3b3ed4e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:42:08.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8mSLpByxVOUZISgQN0/5gYW4oemokNd1mnXHh/QFNXvBXDRQT40jUkZduWcUWxKNuczFv+2NPYUH8lvc085r7vnj1Vr7i2p6gwUJiJbYMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> The mbm_cfg_mask field lists the bits that user-space can set when
> configuring an event. This value is output via the last_cmd_status
> file.
> 
> Once the filesystem parts of resctrl are moved to live in /fs/, the
> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> this value is output to user-space, it has to be accessible to the
> filesystem code.
> 
> Move it to struct rdt_resource.
> 

fyi:
https://lore.kernel.org/all/fc424d4bee8ac9887703fecbaad26dba3c633f72.1728495588.git.babu.moger@amd.com/

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6b076216911c..92a94939cf93 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -415,8 +415,6 @@ struct msr_param {
>   * @msr_update:		Function pointer to update QOS MSRs
>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
>   * @mbm_width:		Monitor width, to detect and correct for overflow.
> - * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
> - *			Monitoring Event Configuration (BMEC) is supported.
>   * @cdp_enabled:	CDP state of this resource
>   *
>   * Members of this structure are either private to the architecture
> @@ -430,7 +428,6 @@ struct rdt_hw_resource {
>  	void			(*msr_update)(struct msr_param *m);
>  	unsigned int		mon_scale;
>  	unsigned int		mbm_width;
> -	unsigned int		mbm_cfg_mask;
>  	bool			cdp_enabled;
>  };
>  

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 0072c2e5947f..84588ab1994d 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -218,6 +218,8 @@ enum resctrl_schema_fmt {
>   * @name:		Name to use in "schemata" file.
>   * @schema_fmt:	Which format string and parser is used for this schema.
>   * @evt_list:		List of monitoring events
> + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
> + *			Monitoring Event Configuration (BMEC) is supported.

Making this arch specific feature something all arch can support is probably the
right time to remove the AMD marketing name. Maybe just:

			Bandwidth sources that can be tracked when memory bandwidth
			monitoring events can be configured.

Please feel free to improve.
	
Reinette


