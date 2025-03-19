Return-Path: <linux-kernel+bounces-568777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1CA69A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB3F188AA57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA82144A6;
	Wed, 19 Mar 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXMWkOk2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D816F858;
	Wed, 19 Mar 2025 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417627; cv=fail; b=mZvrB4ZkHEfhgJkD7ooetj3j2uT1fIjyNKUyDo43e9z2fMyCJ0e+hVbzISp9aNsFqViKjaAP2jk4XZsP8jE+YaIvVvQKDDyQN0dHqLKMWbNkDVw8T0UWHBlZ1Pfexv+aDUJU9HogTyAkzBd/HO85pMfqHGYS2bou4MLjXn3wej4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417627; c=relaxed/simple;
	bh=dI7BTuV5C91oc3iPqvg940CNA/4UMIJnT3S8haGbCwY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UJSWfHWsZV5jd0m6xmogRSI202OMJ9AVjkSXqO8uN6v5osad7Xvr7mBz7nREpglwPUxG17jQVm7AbecyMQMT6+65RGSc4L/gEev3qL/+uHITZU/uNnNXhyRKHoSw0Wt5wFtMtBNSFg2k4ghTQ+e0rmVDMUtXm3POrvYMnyiz8+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXMWkOk2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742417626; x=1773953626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dI7BTuV5C91oc3iPqvg940CNA/4UMIJnT3S8haGbCwY=;
  b=iXMWkOk2xGVnVAKlrRUtRi2NeEVZSqBScstvXmu6vMPSZp2vGDgVoPiF
   ErUVCY1DD1OW8uhGrFm30don2p74mBfnDKMZJfCcGS6QlsH5O5vyj/148
   KJqpKFWHs/19tXwG5phXxbNs+y0wryuaP0bR59v75fmf6k/XekqYFBtPI
   CYYFVpT3VOW8FCNRfOiLpZVebU7hRedoycir0Zv3gDR0gxxPqCiDWMWa5
   CAkYi3gvBiSkITpJylXutZ2XCNvB6UKE/mccBemLLeGCTWzCqRrqgeHFY
   lkVGkQyZZn7u6U4Hzh1tHN9fU++FXBIgiWEoFFOyHDVVPOaG5bjsYl3qL
   A==;
X-CSE-ConnectionGUID: FOJVYwoERYKMTSLZnJtqag==
X-CSE-MsgGUID: ertmVKfDQF223eYkmpu7Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43550175"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43550175"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 13:53:45 -0700
X-CSE-ConnectionGUID: 7s81hIYqSTWtGe70PuPltQ==
X-CSE-MsgGUID: VNstVpXAQjCItVHfzsyqpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="128007528"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 13:53:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 13:53:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Mar 2025 13:53:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 13:53:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Db5q+gYC58d6dHQtXPtKgqcD12SishOp7IiyqrFQmkQPXVdSaYVozpaR18QMFOtoCDW05fg+McEybiCA/hu8NTVqm/uHUMr0Izg7AR2ovFI6pTwWpXrH9rMw/cNPJrTZXGW/dpFXN0fY6W33F3kBX4HCCwVxMYqxA72i21IoWznr4Aj//JEk1rigQH/6cEKDJU6pXWYUcmYYtyudRyanVY18vg85jYiHl4kF0OfIspY0dXmHMYJKL/SHxTGdc/M0LSmffeyoBJW7e1Q8auokSq3UNnFz41zw+xYrqEXJrrJFwW4iRODH3CVhtLoZwmSHIiTrbB74ju0bDbAd8L/gsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfXqHuwks9+cMI02jClGDa5h0yZ1syaqFgnRUfGgeYA=;
 b=IGRdJ674R08y1vTqBaIjvC115B5tM1qm0PPDogqZHA2gCermh/x+qJUNNb7eh3HBbCrBcJCU0gu2fa7CewTYR4btSFWl1+r8G/yXVHMlKYgCcMlY9R7SEZFnG4ziFB3+MbXrgyFWX5aG4mtv1kDa1vQrAV+Kb7m/LSuNvODvFeS/wG4YF3IyFKuasc8z7nCGAmLYyWGy6hrIAEpJ5Njj8BV9c0+UydDm8v7SxhUxgWp8j6T5xynS+tm+V9U4NJUi+7uM6mvJZhqKGqzRy9hxwI5w/BQvB/XrDcdW1Wgpzv9WNQekDjfcGVl/Zt5xkCVuLAqivwZgoLA4W+zC3bOkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 20:53:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 20:53:27 +0000
Message-ID: <ad3867b7-cf4c-4098-9639-e98d1145617e@intel.com>
Date: Wed, 19 Mar 2025 13:53:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Moger, Babu" <bmoger@amd.com>, Peter Newman <peternewman@google.com>
CC: <babu.moger@amd.com>, "Luck, Tony" <tony.luck@intel.com>, Dave Martin
	<Dave.Martin@arm.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<akpm@linux-foundation.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
 <CALPaoCj7aSVxHisQTdKQ5KN0-aNzN8rRkRPVc7pjGMLSxfPvrA@mail.gmail.com>
 <8babbd2a-50ae-4a18-8e48-5421539ef0e6@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8babbd2a-50ae-4a18-8e48-5421539ef0e6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: bc21485c-0fc5-4147-3659-08dd6728189e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVM0eVo5ZmJkUUozbXJmb0JOdlJobjdsVkl6cm5oQzBLeDJFajdWbURWZkFK?=
 =?utf-8?B?dXFFaE90K1d0RUpjd29rV3ZOMU9LV01NYVdkN3p6VGlsTTZMVE1OTURUMm5T?=
 =?utf-8?B?NkJzNUorS3VlRS9sa21aQkF3Y1VXUXQyZkhKa1REVkVQTDF1dTkvUzJpOWtQ?=
 =?utf-8?B?L081RnI5TUZ2R3U1ZkFuNWtQUDNzWWVBWjVwMWZTWjhTUTZQbk80TjNubzdn?=
 =?utf-8?B?WnYzL0dYVTk0b3hpbll3dXZ6d1RITXZGc0dEcmFzeUMra2tyc2l0cUZsQmMx?=
 =?utf-8?B?ays5MEpzK3lkcDl2SmVWZHZJUHdDZUpFaHN6dkVjNUVEcGx1dkdjOU9KVit2?=
 =?utf-8?B?cXNoU1pUdGdMaFNSNFpLMEZRQjhmNFBSbjhZWDd3dys4blVaUnFLZE0zRW9Z?=
 =?utf-8?B?RXJjbGlOaVRIdk5GRXdJbWhZdCtjTUhrM0FwN2pBQ0NvM1MxWTVaRU9JQXg0?=
 =?utf-8?B?YXVVVmtQRkIrRUZRY3NHQWtmYkdpT3pHdzlpSzArNjA1VmttNnRWUVQwYml2?=
 =?utf-8?B?RmhXOEcrRjQvMEVYY0dlRHNoTWpNQVZQV3RHZFlkS1JmdG1sa3hsODJWYlR0?=
 =?utf-8?B?OWwzQTVkTkhmdWE0b0s0YTd0ODdzWGZKL1RGU1pId09iNWNmcWU2TnpscWZU?=
 =?utf-8?B?WGhVdWFwVmVwM1E3a0Rmd3l5djh1b1M2L1hZSi9hLzV3MnBvYWUzZlZPa2lr?=
 =?utf-8?B?Q1FLOXBSd0o5N3Yxb2ZXQVU3czJoQ3o2QmRpQWtxb1FYbk5TQjRsRVBKUnJm?=
 =?utf-8?B?cmdSUjNITjViTkJkNGtMaEdwSjFnZEw1Rmw3dkZXelNTbjA3Sm5aakk4Q1Ay?=
 =?utf-8?B?ZHNrdDB6Skc1NWFlQWJBNUlFOC9aWjhBYUZyTWVHcEtHaUJZWU8xT0hIWURR?=
 =?utf-8?B?dmxpQ3R5aDdlSUZuWlZFdnU0bmI2aFpwMisra3dPbVpsR2VCemZIVGpBenlh?=
 =?utf-8?B?WXRibzMreTh5S20rYkxiRkU4TzZKazIvOXhaVEtmdXYzWnBCbm82KzhzZDRl?=
 =?utf-8?B?aEVmL053RkUvUkZpNzVHVFIwRkViazhuNE1KMUoxYi9ndnJsaDI4aG1LeXdN?=
 =?utf-8?B?T1FDTnZ1NFp1bWZnNUxZd01OVVlVRlRycWFFRmpKbHFDZGdkZVVkWVNDZDAy?=
 =?utf-8?B?RVc5a2w5aysxY01TM0phRDRhN0tGVW5BbFBzYWoybVJreEsrekppVmxkdW1n?=
 =?utf-8?B?WklVczZpS3prUlRzcERjemMrSE9jQi9SUXZWcWpIdE5TNVQwWSt5NHBMMG9X?=
 =?utf-8?B?eFNVZWdUNlV1NWhPU3VyS2VnTGZKdG1rZzBBdFMrWkQ1RmZ6VS9oMUtQRlhJ?=
 =?utf-8?B?dHpVLy8wY3NZVmg0OXY1WXo0UXYrWjZTYi9kM0dVa2JMSkUvVC9DZCtDbm1k?=
 =?utf-8?B?TTl2QXZqV3VKekY1UC9YaTRFZzM0QmM2QmNHenJxVjlzWVdsdWZ2NkNBMFVW?=
 =?utf-8?B?Yk5JelhYTFRLUmowcEZta05GU1FxZUd0UERrYmsrVForWmhmWnFsVVh0ZkZT?=
 =?utf-8?B?UUV0dlZxSDV1cWlDUGw5WUJpbDhybitKZGdFdFdkVy80Q1V0ZHVUZ3RrZDNy?=
 =?utf-8?B?djkrS2M1QTg1clJRTVVYaC9LNUlSbzhIaXQxZTJUTWYxNlpvZ1pBck9Jbk1R?=
 =?utf-8?B?cmhtMWs1ZU5nS1NXalNFYUVSenhjU3cxMlNTU2lsV1NNR0FDeDlOM0dKaVJ4?=
 =?utf-8?B?NFQvaXZ5aTdzMG11VEhpdi9HbnBFaC9LM1d4VFB3TFA2NzhlblpMUUJyRGRL?=
 =?utf-8?B?ZFV3NWlLSUFxODl0MW91WUo2TXZKdHlhdUROVjlua3JBbzRyYytlTG1Hb1g4?=
 =?utf-8?B?YjBMOTduQkpMSG1CZVFjMEJwNW4yVjdqTFV4LzdmMDhzejc0UVBaSTh5bVp6?=
 =?utf-8?Q?H/fk7OP3YhpLx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVlblhyUWdtaUFjNW1oVk1xazB1TUxsVmNsVHVxMStQai9hRUsrZk1MTzRa?=
 =?utf-8?B?cnV2WkY0WUNXMk1nNmZEU1VRUDk1cG1MNEJGUHhIQjY4Y2doci9lWFlobmdR?=
 =?utf-8?B?MENTZ1FLdTVrTWRsYmowam5EWFBSRG85SjFsVkxwdks4Y0poZWIvV1lHRUsv?=
 =?utf-8?B?Z2tKdS9FTk9xR01oVC8vZTB4N1htVllxanZTTElGQ2hKTEF2WFNYUFhwSTls?=
 =?utf-8?B?RWFNaUFWWk04ZkhIcEpmZUYxVElJYWJnSklMaUNmSk1aeTd6ZjFBN1VHV3cx?=
 =?utf-8?B?TlJ5VjFlMHpJdWVIcHRxQzcvVUZ2a1RMd29BaVpRSmRPb000QmorbWY0WTVh?=
 =?utf-8?B?ZmFDaWxQQTVBMEVzRHptSXE0d0k3UHlKbXB6LzhUYktLZWhWcHVKdnloV0xn?=
 =?utf-8?B?UmREVzNQL0lZYm9tdG54UFhKbEU0SWdtZHAvazlVNkVVWWhrZTF3Q0djZU00?=
 =?utf-8?B?VkJuS0JUWDk1R0ZaTTE5VG9jdlJuMVVTdy91VXVVckxJNUFYNThnc1dxMHRO?=
 =?utf-8?B?dkVhOXFCMXpLS1JDei9EaGR6YzU5QUN0cXV4QUFXN0tZaklDSk1ZeC8vM2tS?=
 =?utf-8?B?ejdFcXpMWlF2MFpQbmVOZTMrTk5XdGE0dzR1bDNCNDc3SG10dVo5bjYxS0Ur?=
 =?utf-8?B?MlBtbUxNLzdkNHlLSDE5ZUxNNjFEQU5HYkRLVUVnazlrbnZpNVY3WlI4K1Rp?=
 =?utf-8?B?YmN5aitDbXdlQXFWdTFvUk1RL2JSeFdZa0VHZGhMZWxMdy9FaWhveU1vQXAr?=
 =?utf-8?B?MHFvbzBtZStWV041N2xxRHJjY2VkVFQxb0RJZE82RzNnSk5obHJxSWo4cU9P?=
 =?utf-8?B?aVMyYndKTm9DSzViQ0NKNkl5YTJZaHZkcCtxcy91d25xcmpBSFVRbTM4Rk9Q?=
 =?utf-8?B?dWhqRVUrZVlndTBoK0RNT0ZKZ0pnZFEzSzdkT0xXaHNyV1pxek9obkdNVkxm?=
 =?utf-8?B?M0trTmdqQ2dZQ29UNVJ2M2Q4c2w3R2thZUd1ZGJmZkpCYjFhUGkxVEJEU1Zq?=
 =?utf-8?B?a0Jhb3F6NE9NMVRLYjNYWnZ2Ylo5aTJ2VUpWQnpKQVhpT1lCWnliRVlQYVdY?=
 =?utf-8?B?SzdlMGNIeTR4Vm5vRVhOZFB1ZDVGZjZpWDJoQlRZV3NSSllGcHVuVVFTR3lp?=
 =?utf-8?B?YkhxdThjaElwVUJZeUdPMmZZRVAyWlFrd1N4U1UxMzVreFR5Q3dzMjlXT1ln?=
 =?utf-8?B?c0NsZVFYRmkveVVxM2w5VW5OQ0IvaDZBMWoyaWdWK3czL1N1c050Mm9yWk5t?=
 =?utf-8?B?OEZqSVhpeEhGK28rbkxVSityN2NBWGJzS1ZpbHhSbHFjSjhGdEs1UXowRWht?=
 =?utf-8?B?QmE4Sy9zbEZoRG9nSmZGRFF3N0U2a2VURWhGekc5cUwrZ0JxemRPMVRCUTNI?=
 =?utf-8?B?TnA0K1lCVXlZY1hqNjBpNUU1U08zK3F6eXhsMnZNeHRJSCswZHZBd1lwUmw0?=
 =?utf-8?B?NUZycGNhWW84QUNXUW9HbEs3aWNRNHNsVXNsMnloc2x2Z0E2SFVhS1hkSENo?=
 =?utf-8?B?ZEtzNTVLQWRLNVZtYUs0OGhockZRWFczRytQZHNqZUN1U2oxVTJBaUdCYWxj?=
 =?utf-8?B?Q3RiYXRjaE5Za3UzQTB3UHBxd3YrN1BzaEdwRnliZnNIeWxiWmRPS0pnRUFZ?=
 =?utf-8?B?RnB1cnU5UDAvSzFCN01LbTJsdi9oK1cvZG9FTFdPemRXOVlYUmMveDVVUWt3?=
 =?utf-8?B?QjNCcFNTNUdiWWYvbzRzaGR0K1BXbXlNYWE0SVRKcVJWcU9HOEtpaGNYOUtV?=
 =?utf-8?B?bGJiRm12NlFEc1VWeXEzM20xc21ieTNJUEdCeC80UGVxSjhYc3FVRlNEZ3Vi?=
 =?utf-8?B?Ukk4Nk9lTi9xUEpSbVNaWFRpZWRLRzhhZmVJOHZ0STNmN3ZsdEpnaFFmMWxr?=
 =?utf-8?B?OThSNEhJK0V2YUR4aTJyT3Z0Nks1RWQ0bFNzd2FYV3dJalNVOEpINnNzQ1c1?=
 =?utf-8?B?MG5MU2JHQ1lIa1ZNUHdlaHR5eXRvS1FCd0lMQlhVWitwcGZCUTRqVGozeVBu?=
 =?utf-8?B?QW9IdWpTcTRzM3k5c2k2LzVJWUorMnlPQm1pMzVFeXcxV0xLalZ5Y3o2U1ZF?=
 =?utf-8?B?RStxeE1NOEx6TzVvWUlYY2hJYUw1eFJTQlloeEx4ZHhKTlJiVFFhdERaVXdl?=
 =?utf-8?B?ZnlZYzlhVDYwMkJ2RmJqS3ErSnY0SzhmREJsQUVsZkQ4S1liMHVnWW9FRWlq?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc21485c-0fc5-4147-3659-08dd6728189e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 20:53:26.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2M7n2jLk9vatgcpg7b5GFvhv7JgXOrhd3Nq/BpIApOQsHwds1Zv/6IYRQvWQHPXgqj7qaCbv/BW/bKmPEQCgv9HxPfmbi2HdfyJ9GxKW5bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com

Hi Babu and Peter,

On 3/17/25 4:00 PM, Moger, Babu wrote:
> Hi Peter,
> 
> On 3/17/2025 11:27 AM, Peter Newman wrote:
>> Hi Reinette,
>>
>> On Thu, Mar 13, 2025 at 10:22 PM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>>
>>> Hi Babu,
>>>
>>> On 3/13/25 1:13 PM, Moger, Babu wrote:
>>>> On 3/13/25 11:08, Reinette Chatre wrote:
>>>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>>
>>>
>>>> Here are the steps. Just copying steps from Peters proposal.
>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>
>>> Thank you very much for detailing the steps. It is starting the fall into place
>>> for me.
>>>
>>>>
>>>>
>>>> 1. Mount the resctrl
>>>>     mount -t resctrl resctrl /sys/fs/resctrl
>>>
>>> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
>>> will continue to depend on BMEC.
>>>
>>> How would the k existing BMEC implementation be impacted in this case?
>>>
>>> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
>>> files will remain and user space may continue to use them to change the event
>>> configurations with confusing expecations/results on an ABMC system.
>>>
>>> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
>>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>>> llc_occupancy
>>> mbm_total_bytes
>>> mbm_local_bytes
>>>
>>> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
>>> and mbm_local_bytes_config, which may be the simplest to do.
>>
>> How about making mbm_local_bytes and mbm_total_bytes always be
>> configured using mbm_{local,total}_bytes_config and only allowing the
>> full ABMC configurability on user-defined configurations. This could
>> resolve the issue of backwards compatibility with the BMEC files and
>> remove the need for the user opting-in to ABMC mode.

hmmm, yes, backward compatibility is a big issue with an earlier suggestion
from me. Users with scripts/tools using mbm_{local,total}_bytes_config
would expect that to continue to work on systems that support BMEC.
resctrl could continue to use mbm_{local,total}_bytes_config
even though the inconsistent interface is not ideal

> 
> There is no opt-in mode. ABMC will be enabled by default if supported.
> Users will have option to go back to legacy mode.

I assume there will still be the opt-in for automatic counter assignment
on monitor group creation (mkdir)?

> 
> The default configurations will be used for total(0x7f equivalent to enable all) and local(0x15 equivalent to all local events).
> 
> Same thing will show up at
> a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
> b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter

These files could possibly be read-only but the moment user space uses
mbm_{local,total}_bytes_config to change the configurations between domains
this will be invalid. In this case the file could also perhaps
read "Configured using <path to>mbm_{local,total}_bytes_config". It is
not clear to me what would be most intuitive to user space.

> 
>>
>> It will be less clean implementation-wise, since there will be two
>> classes of event configuration to deal with, but I think it seems
>> logical from the user's side.
>>
>>>
>>> To follow that, we should also consider how "mon_features" will change with this
>>> implementation.
>>>
>>>>
>>>> 2. When ABMC is supported two default configurations will be created.
>>>>
>>>>    a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>>    b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>
>>>>    These files will be populated with default total and local events
>>>>    # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>>      VictimBW
>>>>      RmtSlowFill
>>>>      RmtNTWr
>>>>      RmtFill
>>>>      LclFill
>>>>      LclNTWr
>>>>      LclSlowFill
>>>
>>> Looks good. Here we could perhaps start nitpicking about naming and line separation.
>>> I think it may be easier if the fields are separated by comma, but more on that
>>> below ...
>>>
>>>>
>>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>     LclFill,
>>>>     LclNTWr
>>>>     LclSlowFill
>>>>
>>>> 3. Users will have options to update the event configuration.
>>>>     echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>> We need to be clear on how user space interacts with this file. For example,
>>> can user space "append" configurations? Specifically, if the file has
>>> contents like your earlier example:
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclFill
>>>   LclNTWr
>>>   LclSlowFill
>>>
>>> Should above be created with (note "append" needed for second and third):
>>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> echo LclNTWr >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> echo LclSlowFill >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>> Is it possible to set multiple configurations in one write like below?
>>> echo "LclFill,LclNTWr,LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>> (note above where it may be easier for user space to use comma (or some other field separator)
>>> when providing multiple configurations at a time, with this, to match, having output in
>>> commas may be easier since it makes user interface copy&paste easier)
>>>
>>> If file has content like:
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclNTWr
>>>   LclSlowFill
>>>
>>> What is impact of the following:
>>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>> Is it (append):
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclFill
>>>   LclNTWr
>>>   LclSlowFill
>>>
>>> or (overwrite):
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclFill
>>>
>>> I do think the interface will be more intuitive it if follows regular file
>>> operations wrt "append" and such. I have not looked into how kernfs supports
>>> "append".
>>
>> I expect specifying counter_configs to be a rare or one-time
>> operation, so I think ease-of-use is the only concern. I think
>> multiple, appending writes is the most straightforward to implement
>> and invoke (for a shell user), but I think commas are easy enough to
>> support as well, even though it would look better when reading back to
>> see the entries on separate lines.

When the counter configuration consist out of multiple events then it may
be convenient to just write it all in one go and having a shell user use
newline as field separator does not seem convenient. Appending writes sound
good no matter the field separator.
Reading back we may have to consider both what looks good to user space and
what is easy to parse by a script.

>>
>> I believe you can inspect the file descriptor's flags from the
>> kernfs_open_file reference: of->file->f_flags & O_APPEND
>>
>> I haven't tried this, though.

Thanks for looking this up.

Reinette

