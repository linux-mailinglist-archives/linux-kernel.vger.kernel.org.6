Return-Path: <linux-kernel+bounces-299625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE595D7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547ED286678
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340119885D;
	Fri, 23 Aug 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/dsiGoW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DD193087;
	Fri, 23 Aug 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444331; cv=fail; b=GN8qK7kJUEpRhI5tH/tz6wNY/9vhPkJschob5gRGmzjYcEci7uulw+LZpOIveMq7qyJ7IxJOG4rzFIWmnkO3BhbWhurKATeswmBr6Tnt7JpUvNHLSCZqHSHSROwOXhHLUOG3mNy39sDv1fmU8nqYU56TtQ0d6mH834cRouPSj/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444331; c=relaxed/simple;
	bh=tEPnsa/LWVeuL39UlGCOUdCaiCAnzt1bLhCBCq6wLzM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBQLdm2yIWMhMvhnnGFNBdeKIsHq2l27/XwGYdz7TSNp/IdlA2wLF0O+gsXWaxQ+FhJmJ6HpjtvdCueNZ5vhYEpi+akPal+ZYV2M8+BkVN1Fw4caRGT7AeNLS/INSTnKXW0xx+C1BRIwzMpzqY7DEdw+WEvmM/t2RrMyExoJBFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/dsiGoW; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724444329; x=1755980329;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tEPnsa/LWVeuL39UlGCOUdCaiCAnzt1bLhCBCq6wLzM=;
  b=N/dsiGoWLWFnBf/e5ehJesqsLyhZwzEF1vLla65iVWI1tvtsT/6w+02/
   OKMHfpEWRUn3j2PFcQytrTuWJrcNQBwsT81vAH/EBmjFF9i4+gLycmMMv
   J71HoCFeVNdrzR/0zMKHR7ax1OfO9X6yvX4Rsqw5oZfQWG4r48oPb5L/c
   ch3ZdAU3VSoWxt3qrgadVHrVsIGYWim68ypjyek2w9KUtjfdf/hUA+/19
   9CvJFRovZ8Jn8mizHvMWRSzC9qlPvl4eDxYdxhIfIbxSRsDTK6dbGwPcO
   yWA2bRhS/TAfoZr3K4uFpaWl1/tIFTEZtJWw+PyRZuv8UwdNhee/IwGo4
   Q==;
X-CSE-ConnectionGUID: lsx40Km8R0G3Rn6xFa6JYg==
X-CSE-MsgGUID: iK+c7MfjQh2RwSgeL6vdIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="34087517"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="34087517"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 13:18:48 -0700
X-CSE-ConnectionGUID: LfteMBpkT5S28I0Ug+sKDQ==
X-CSE-MsgGUID: 4ZJ+7PIeQFikJ+MWjemeaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="85082382"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 13:18:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 13:18:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 13:18:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 13:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMI9YyUtp7YBT5NJBA9Zg1kAcnWwwwjTxut7TDpUCUtujXMvlpYKDaHEsHVN6zAQ1AEbeTIRzDcv35FcKfc1Tb1Jg5la3aKKLLzYPDiQ3Vyyvzd8RsOKt6fKFsUqly3VhivAMVi9jgCE1NsPKjmMhKdDJfHNPhq+SAkv16t6ji2y6MkCf3ojR3OENBJ40G808oBT/hRScsh0rpKbd6J5d0ZvcanGanSBWSOGldkbIKnEy/fr5dIA4PPa9N2r2O7Q18qP1ic3ReEqR+GjnUArbCmkSmYOZOzmpdRfa5KBkYlDuRogpmCpIMIC9JdS/gBhzda7iZAeSuAM5ssfP5eWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRQNN5ZJlVcxMuDKO9lo4ZNYdfCDt3QCqdBWKYekVpI=;
 b=EMR8pvEcHZP4qrFEaB9TXItdMaTma8VyM5eI7TZHSVI0v5P2tVQO8Sc/XQv+HQBiN65MlVxKUru47G5x5G3GB6RveiKvkCIWrWK1RvvniXMVXOvW49JuBhRkzm29NsNCs7F/Bl9weG3HgrREtL1D1dUaWS9uGYTyWTo6VIowk/hvH9EjBmUXayM6vo8ZTevUA4aPNu1kQ9lP9a5/CbGPfOSP1Qbd8271PtECYJ1GMydKbnY4vyrexw3HJoC7u9Uu+2YZVRbP4IgF4kybidyU7mrqr8lN4hp+uSLTV5us6rC+e4BsudOWRKXsKOL27XsEU6TY6W8GLu90h56zbRxpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Fri, 23 Aug
 2024 20:18:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 20:18:38 +0000
Message-ID: <5e1426cf-f966-447c-8455-88b70ab324d9@intel.com>
Date: Fri, 23 Aug 2024 13:18:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/22] x86/resctrl: Add the interface to unassign a MBM
 counter
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <09da6e20b695086558d6cadefbc4830961e6e60b.1722981659.git.babu.moger@amd.com>
 <e2b9bcd1-4b5d-4eb9-8e3c-604a4c5cafe8@intel.com>
 <f4d5ddac-9399-4581-b914-ddebe1824463@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f4d5ddac-9399-4581-b914-ddebe1824463@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: b7acd939-d697-439e-12ea-08dcc3b0c648
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1RXaU85bVJyMTNWYUltd1ROdGlDQWp5cnhBK3U5SHo5MFZ5VWUwZ0dhSG1K?=
 =?utf-8?B?aGRzUDhpWDBUQzVJQXdkZXlXd3JoSThNb3pIcHNVYkJGMlRYWVVxUHR2TkNj?=
 =?utf-8?B?SXJwKzJjVXdqMDl6ZHhoWlhxN2drekc2ZWJyZWdCWG8waWZXQlZlT1d5RnFv?=
 =?utf-8?B?a28zWTF1NDJWTHByRVRYVFlNZlIwbzNvZTNmTnp6bzhTLzFSbHpOYkxYVC9m?=
 =?utf-8?B?M2lic1htQ0JXRWwxeWRobCsxM1ZhTWVwTzY1TE9jalh0b2trZUZNQVZHR25I?=
 =?utf-8?B?S2N6QzNmVkZFazUzZisvcGg4TkQxcEhBbEtHUUExdnZBdzRiSElsQUM0Q1pG?=
 =?utf-8?B?SXlWc1k1ZjY0U1lHYmlNK1EyRWF3Y3J4QUNMcFpLTlhuSmQ2S2d1RnduQ2pW?=
 =?utf-8?B?bWk2dWpSQko1QXBUdEY3WkhtbWUyQ2w2MXJHbGdQellDUUlTbTVOYmJtWDBX?=
 =?utf-8?B?YVhJNGxYUHVnNDVmT0Rab0ZSd0p3T0p4SWJEd3JuN2Ftcmk4RTE0ZHNnOSsw?=
 =?utf-8?B?TWp0emQ3NWdZbGdJQThxSEovdGhBa1BlbW4rNkFmWmV5bUVKRkJNblNRd0Q4?=
 =?utf-8?B?NG5NOGJoUXFMM3ZwR1phN3U5cUZtbDFEUThyMnU1cVcyM2ttYUVNL1E1Z1dz?=
 =?utf-8?B?d1JBT2ZHTUZRaFVSUkk3bmRFUkRPc2QwczFNQlhHdEhsVlQ3cFVQZlZWQWdk?=
 =?utf-8?B?aU9YMDZpeWw3NXdCdENLek9UYVZKSTZUUGcvM3RtcG4zS3ZDVEtzVnIzRlF3?=
 =?utf-8?B?UXMyeUd5LzYzTlZBdmhGbGQwQjhqRTdMaW9VaTFDbVAvVnhoYjkvT1Y3dnRZ?=
 =?utf-8?B?dmg2MXI5ZXhIUHpPVmdlV2ZhdVJhczI4dUFkazVtRkp0ZFJnSHJrWUhHMDdO?=
 =?utf-8?B?V1BWdzh3dmVlWjB3NUdtYldrSWtMaVlENHJseUo4Vzd1ZlUxcW1wMGh2NmxR?=
 =?utf-8?B?cU9hOVhNOXN1NHZoQXFQck56YWVVZU9XdzFwTWJScnNEbWh0N1NRb01nbEwx?=
 =?utf-8?B?azk0TTc5S1gwRWpBYW1lbkJtMjl5NmlQMXZaVjN2WjlkSkpsR2JUZUVZNzR1?=
 =?utf-8?B?OUtQWFcvOVdNTHdvbEpWOTA1WVJoVC8xclNaS3d4YkhCWHdGVTlsOHZ0ZmRU?=
 =?utf-8?B?blVPK2V6QmcyTFpnZlY0bnd6WmUwcnV6VnBBSi9qajJveC9VTGRYR0lGUSti?=
 =?utf-8?B?WmlCTnRBa1VDZWNWTXkwd0xVN0NxSFB2bjRvTG1TS011TGh4S2pkOXd0SmhX?=
 =?utf-8?B?NjAwblFQejJmV042WGk5aVQxM0ZWcEdWUnFTTmRFdHVsWHpmMCsyTzlqZS9R?=
 =?utf-8?B?OVhRTmowYXlaV09jSml4VVljVmdISGlNaVdTY2Z1c1JGSW1OTUYzUXlBS1BF?=
 =?utf-8?B?dmpjZzBJblJLSjN6Wm1CaWdweWhHdVd6b2IyQ3FVcnhEcnBqYzVFYmpBdEdT?=
 =?utf-8?B?RHJPZVB2c3VNTk9pNWhXckNjdjg5ekFQdmNHTEthV0h1VFVTeXJ1bzY4VVBB?=
 =?utf-8?B?aFBNYU1hK2NWMEpKUDU4YVlSMFlYOVBpNEloeXc3c3Y2S2k4R2FybEFRa1NJ?=
 =?utf-8?B?VHc3RUIydE5pOEtvY2JCMWV3M3NZRzJrenFwREJxMWdIdzRMaFovMGtHSzI2?=
 =?utf-8?B?cEN6TFdtNEJVb0kwYVE2a0xKVkF6b3Y1OFp1Nlo1SUVNYjkwcmxZWVdNdEUz?=
 =?utf-8?B?ZXROajNISnMrWXFPRzFYaGMzVHhzUU5FZ3VkY1VhU3hYZkVTVjc2VWN5R2dM?=
 =?utf-8?B?Qyt1MEo5TkRZMk96MDB2UG1PNHZUZnN1WXNobC96VmZvczhkV2ZWbDVYbENa?=
 =?utf-8?Q?aOtr6HtV8hnHOtMSHcJcjd5K/gZ86+lnpWnCw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGhaYmVIQytmWlpFN2RybFZQNlY5LzJmL0pNTTh5UDZKNFJraWNHK0xvOTRx?=
 =?utf-8?B?alBQWVczZUVYR0lETHZ3YWlZOXJpM1FKYXpmSGNuVUljcy94NVZpQWdOMFp5?=
 =?utf-8?B?VVZnSFRvTjJ5TVJlcTl4U0RMcGQvUGVJRUVjakUvcE83NE53dGQxU3p3WVZ6?=
 =?utf-8?B?ZGJZUUpKdjF1dGdkNklBT01IYXlSUG9admNpMmE4a29CU2JvMkc0N2VWSXUw?=
 =?utf-8?B?RkwyWHV0dG9lRi8vcmhEZHNoL2RMeDViVGk4aTNPNkNJcFZobzgvbXN4b2Nx?=
 =?utf-8?B?cWdnL1JYN0hCeXFWNlRZbVNrUXJPanhGUXI2MGF6Nkw4WlhFK1NJRTFGUEF1?=
 =?utf-8?B?WVNlVUdXTUwxNXVpYjl4dERBc0pEZFhpUkdBaGx5Y0ZBZjMvTno0L3JOcmh5?=
 =?utf-8?B?T0ZsbGhYTldZcWRJSWp5QmgxVmh5K2s3SVAvTWhwaGt1TTdGWTZ0dTVWZEVN?=
 =?utf-8?B?QWthRllPSEJMVEhocjFtejVRbnZDU2dDczQxbDBjdmM1RTBnUlk4V1dyUzB6?=
 =?utf-8?B?cWNuOWRlYjBJVjEveTJaUVdQRDZTalBUOFNNRVZROWZwK3N4SHY0L2RwdlNS?=
 =?utf-8?B?OHNIK0EwUnVBL2JhOUdZSlh1OHl2U3EzUjZiNGtnZnRJc0M0Y0srNFVLdDRx?=
 =?utf-8?B?MjRUbXR3eXduNGJPakJseFpHOXVha1g1UDd3MjBpQ1R6ZE80Z2hnRENsOSs3?=
 =?utf-8?B?bzlqRmE0bng5NFFJdnFLS1VQcHZSY2hIOTdxRWtYTndnU09rUHdnQXQ5SEta?=
 =?utf-8?B?Rm05RzgxU09qc2Z4Yk9NSjMzWmZOV0wzNC81VmZiRkdmaWhUYy94WFZLMWxt?=
 =?utf-8?B?SW5QanhNMFlCblkrMlVXbSttUURkS3V2cjRMb1BxY21wekFGOXJJYVFHUHBw?=
 =?utf-8?B?MnBkbW5MSy93c3paQUNsQTF4K281U2JqY2Z5K0VGd0hkaFNpa1Y3MDJLenRw?=
 =?utf-8?B?c3N0aW5yb0VrcW1pSzg3YlJnK2thR3JwQWpzbXFDRC81WTJuYnR3ejJMQkZE?=
 =?utf-8?B?MDZxUi9QcHFHeEJIeWZ6aSsxTjdRT0R1WmYrSHE0UEI4TkNLNThQaUdsUVg0?=
 =?utf-8?B?dVZNdURrNWdyMEc2Z1pSSHlaald5Z3VNNmFDaXQ1bHVPRlR5aHZmY1d3MlVX?=
 =?utf-8?B?M0lKNlNBSXJBOWdYdEFmbFYvSE9jK2hIODBrdWdmV3V6QUVsNDN3Z2JnVzFP?=
 =?utf-8?B?UU55N3pzb0ZMdVlmUDVlSDFBRm5oM2JOREJoSzdXaVRpODJOSFQzdjZDYzZQ?=
 =?utf-8?B?UU5oSURlTFJrUlk0MGF3bnl4Ly9RS2hIVkpTSE5Qbzk4aXMwaWxZMVR6TEk5?=
 =?utf-8?B?UDhwakZ5TEVqQkJIbXJRMjVxL1VRZ1BjN0xveXdnRkE5WGdvZVdxS3hBekE1?=
 =?utf-8?B?N0pneFlUejNsaTZLbXRETy9Nb0V2aldBSEdjZXVOWHNFaFpicnpxWURxdlRO?=
 =?utf-8?B?MFFDZ3NSSi94S09ZQldjNjF2eHpObVBpbzZESGt6dWEvTU1TRDFqZFdlTTkw?=
 =?utf-8?B?NW5WQjE0UEd4REhBM2FpTm1iMDBhbmxwWkU1Q2N1ZlNCQ09KRlFyTlhpSVFY?=
 =?utf-8?B?eXVNbmI3N1VFRnlOOTZRSEVPdGp1V015b3BmLytZalkrTXJlVVozaEVidXlI?=
 =?utf-8?B?emYyd3BXNDg5eFRjNmhCdzVLSXVHUitZY3pRRUFtblBlQUk1NGx6OGkrWUl6?=
 =?utf-8?B?WFJESTdxd0EyRisxbncwZm1mYzkrZEhLR25uR2U2R2NrRUY2R3NNS1hwQzJQ?=
 =?utf-8?B?R2t2QWZDRnMxZ0VNSVNKd1VHOVVYZ3ZZRlUxejBBTENpRWNWTGZCMy9aTlE5?=
 =?utf-8?B?RS9majg0Wno1LzJvZENUWjd3QkdYOUUvSW05OXJaM3RUUllNWjBRSGp3b2Fn?=
 =?utf-8?B?RXJpUGxjc2ZTRStlRGQxb0dDRGF4QW1XZ3JzUkxkQXozbDFYaVMxY3pFTmlk?=
 =?utf-8?B?dDhKSkFMamdIYm9WRHlxRGRGdjNYQzQ4S3JDdzB2SUlEWXozUDhub2luSytR?=
 =?utf-8?B?cmMvS1U1TnRsWXRBVzVxNE1RQTZIUCtaM0MzNDU1N0dxUmZPUWxncTBqNCtD?=
 =?utf-8?B?QVBKSXRhSkd5MDNMMEo1TkZHWEZRanROUHBDa21KeS80UkhxY1h5TXpXL3Vr?=
 =?utf-8?B?MW9xR2JjdU52MnRLN1VncUFhNURmdmZCQmFucSs2WDZBUEtpVlAzM2VEYzVO?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7acd939-d697-439e-12ea-08dcc3b0c648
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:18:38.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGywx01V5ber+g/C/pCyQMpb1yM+goH+AxImLyT7KuQ7jPPNyv4ZVK0wLSR0ptXf7h0UEMSxxgbdtxF9Bx2zDdzaoamImZSLIeLKIg8pELQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

Hi Babu,

On 8/21/24 9:01 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/16/24 16:41, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/6/24 3:00 PM, Babu Moger wrote:
>>> The ABMC feature provides an option to the user to assign a hardware
>>
>> This is about resctrl fs so "The ABMC feature" -> "mbm_cntr_assign mode"
> 
> Sure.
> 
>> (please check whole series).
> 
> Sure.
> 
>>
>>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>>> The assigned RMID will be tracked by the hardware until the user unassigns
>>> it manually.
>>>
>>> Hardware provides only limited number of counters. If the system runs out
>>> of assignable counters, kernel will display an error when a new assignment
>>> is requested. Users need to unassign a already assigned counter to make
>>> space for new assignment.
>>>
>>> Provide the interface to unassign the counter ids from the group. Free the
>>> counter if it is not assigned in any of the domains.
>>>
>>> The feature details are documented in the APM listed below [1].
>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>       Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable
>>> Bandwidth
>>>       Monitoring (ABMC).
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v6: Removed mbm_cntr_free from this patch.
>>>       Added counter test in all the domains and free if it is not
>>> assigned to
>>>       any domains.
>>>
>>> v5: Few name changes to match cntr_id.
>>>       Changed the function names to
>>>       rdtgroup_unassign_cntr
>>>       More comments on commit log.
>>>
>>> v4: Added domain specific unassign feature.
>>>       Few name changes.
>>>
>>> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>>>       The function is not called directly from user anymore. These
>>>       changes are related to global assignment interface.
>>>
>>> v2: No changes.
>>> ---
>>>    arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 ++++++++++++++++++++++++++
>>>    2 files changed, 54 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 4e8109dee174..cc832955b787 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -689,6 +689,8 @@ int resctrl_arch_assign_cntr(struct rdt_mon_domain
>>> *d, enum resctrl_event_id evt
>>>                     u32 rmid, u32 cntr_id, u32 closid, bool assign);
>>>    int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum
>>> resctrl_event_id evtid);
>>>    int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
>>> +int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum
>>> resctrl_event_id evtid);
>>> +void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup
>>> *rdtgrp, int index);
>>>    void rdt_staged_configs_clear(void);
>>>    bool closid_allocated(unsigned int closid);
>>>    int resctrl_find_cleanest_closid(void);
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 1ee91a7293a8..0c2215dbd497 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1961,6 +1961,58 @@ int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp,
>>> enum resctrl_event_id evtid)
>>>        return 0;
>>>    }
>>>    +static int rdtgroup_mbm_cntr_test(struct rdt_resource *r, u32 cntr_id)
>>
>> Could "test" be replaced with something more specific about what is tested?
>> for example, "rdtgroup_mbm_cntr_is_assigned()" or something better? The
> 
> Yes. We can do that.
> 
>> function
>> looks like a good candidate for returning a bool.
> 
> Sure.
>>
>> Is this function needed though? (more below)
> 
> Yes. It is required. It is called from two places
> (rdtgroup_unassign_update and rdtgroup_unassign_cntr).
> 
> We can open code in rdtgroup_unassign_cntr. But we can't do that in
> rdtgroup_unassign_update. But, I will check again for sure.

Similar to rdtgroup_assign_cntr() and rdtgroup_assign_update() discussed
in previous patch, it also looks like rdtgroup_unassign_cntr() and
rdtgroup_unassign_update() can be merged.

Reinette

