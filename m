Return-Path: <linux-kernel+bounces-294455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E925958DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FED1C21929
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34311B86F1;
	Tue, 20 Aug 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcDYmDU7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CC1B9B32;
	Tue, 20 Aug 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177550; cv=fail; b=egX9oNAEyh1BvJ6D8oICd1EaTWMJwRAjgqJONLB2uJ1x3cSYw8BwZ+tlxjapAEPJJLug0KZ33+paUpVUkTqwzmG8ls2HrMcpXMzmfCNnlyxcnJEqKtYIclPmxkGGjwTXy7Mvx1QQApjD2L7tHNX+EIeDQykgSwGgZiE0+Y4N6Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177550; c=relaxed/simple;
	bh=EL1U5etA+C3fYbIxfYagFpRO0y1zRfXi3HRXj6qucXQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2GWyM8y1xacJdyd0xtakZmP4Z0wA9x2dRkEi7sJUFBxhd5yN1U33WPktZIWI2HIx4vKkQJkgkBhK3fFo1ul9B5rSgsWI3r1RatAq+vuT3qxAfJCDGO/pFoDO8Ud8xkrt+tsaN81rhFCLacFAxlkaLsoGRLJFe+BsIuBMEwFWs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcDYmDU7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724177549; x=1755713549;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EL1U5etA+C3fYbIxfYagFpRO0y1zRfXi3HRXj6qucXQ=;
  b=JcDYmDU7cG8DUnPXofTs0esZmzLD7IUNKS6CuInxiS4z2+z/nW2g1buT
   YHIPYqik43iZq8XAY3ynGvqZbdnLqXLTOnfl8/QXCWcgLjrWVAJw+oICw
   gNdi4l8rNim3bg+pxukb3BNIbFh6PyGJC5QfAEB7rnR7sZnyn2forIPwS
   gRGcY/EhRFuEDk96eyiA0uTh4B0JEazC6+/772jTbdMM9dXAwqDkDErBd
   vcjwYz7p/dhqmTY7PUfcEc0SRgBxIaI7+Jxw6cDIG7YGd9Rg116HH47ui
   3dSpRtRl6B4po15hS4apaKNY1oEo1yFqqR0mdQzKMCc69i+cq15j3bZbW
   g==;
X-CSE-ConnectionGUID: O9qmbRaVRxyUiszQRdYqHA==
X-CSE-MsgGUID: WEHb+NhwSnaSAkeaFe3zJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22633720"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22633720"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 11:12:28 -0700
X-CSE-ConnectionGUID: KPTUV108SqegjWWyTPyh5w==
X-CSE-MsgGUID: ySrax3xKTvWTZW4G7W/f9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60668053"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 11:12:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:12:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:12:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 11:12:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 11:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCzp02MCDn+QOvUz8asfmSjFRXRCxjrsZuuPxQhz6zRtIcc2LcWlfdn3Anboj5UUi60MCGv3p0CNYTyHqJUxiOy+SKfPLWDVcmYLveCTNofFodjHvbRBPmLmU1WCwHSgM36H+YI1tRAGcJwL9YvSrFPlo3vcuUnedUyxXY7p/SLoZlLHjkO/9+g7ufzqdrsh157Dymh1jA3hqNdPuzGkHhuz7qpDA9VNnUEdmOLJJC3/m00cJz2FBAah5Otx1/T7WzJPH2NAFk1SK+1O7MU1R9CesurGNyLY/mr8JkD+MwT2Jy4mzetAzWNkMwffY4GJpnpXpcgC28rV/AAQ3DLkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trHV/lRmkATdYgltpqvv6fNvJPK99mK4PzZHkZXOMqQ=;
 b=E79E+Lqq1f8VPgUfBFHk0MQ3pj8O0u6/lV+angU9DJ9xijCDMzl/NlNaLK4tVDXmr3rFwutoxs459I82rG3JvMxyDyjiNxUdI69FQZ+9CkDIWqwzZ4Nu38f+1t9fKvte3IOrIzxqgen7Q/CAfRu5EA2GIdbxuh7m73owvmz2qE49tE/QPj8U7zLLLEnl1uP6o80LIi1iYrI3uSx/dgZPdKzIdK91sulVhtMWfZXLtTfHS9EohrMaESOFLqiwTjnuMxdK4wexjD9bxCkSJYjTy5wrDnQzb9zoaQDdlZ0njQCfup0NqOBVXurdb7UmmgsbhmF47nJLBi4gMa5lIBrsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6240.namprd11.prod.outlook.com (2603:10b6:8:a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 18:12:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:12:24 +0000
Message-ID: <6b1ad4b2-d99f-44fb-afcc-b9f48e51df6e@intel.com>
Date: Tue, 20 Aug 2024 11:12:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
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
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
 <ab979768-a98b-417b-b319-6f14da88b857@intel.com>
 <16263da0-603a-44a5-b6be-58c66b8dd863@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <16263da0-603a-44a5-b6be-58c66b8dd863@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0322.namprd04.prod.outlook.com
 (2603:10b6:303:82::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 49243768-40f3-4000-b749-08dcc143a46c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHp2VDZiRXZsYllQc2xiT3RMOVFCYjlTem1IU0ZRY1dDdGN6L1RUdVQ4ZUl1?=
 =?utf-8?B?eXRkL1Q4YWJJWXdSOXYyQlBIWW5MR0JFa09XNmRxREYrQkprYlpmSnV1Vk9l?=
 =?utf-8?B?QUlrNCtDVWJMQlF5WW5UQmRRNFpGTGZTSEd2c2VBQW5vVHlQWkFJS3B0T0NF?=
 =?utf-8?B?RC9HNDc2Y2ptWmRhWmFIa21rcENnbmh5OGRCMkJ5bmgwTjJOemRKdzVEelMr?=
 =?utf-8?B?d3RDRUtpQ2dVSUpXNFczSVZpUmpjcjY3Uy9weGtDZzdZNW5ORzc4V1F4b2lY?=
 =?utf-8?B?TGhGTEtWTmR0UXR3RG1HdjJNb0QrSlZ6WWI0L3VKYlJqL3IyTUJvaEJYbllu?=
 =?utf-8?B?VFdMaEcwOXczQmRtU1J2RjIySXVSLzA2RXNkUy9kd3MyaDRTN0lvVkZRb1hp?=
 =?utf-8?B?SWdMbW1TL1QvVFQ3U1RFbkpDYmF5NmVyTWU1b2ozUVJ2TmVzaFRpRVpZZlYw?=
 =?utf-8?B?emtReUFBVEVvOXRDTElseVIwNmFkVXg4RSs2RVlYa3RIdlFSbk9idzZtMkZW?=
 =?utf-8?B?QTcwRC9hU2lIVEJJMWJJNTBGRURQNVU2eDBvcktTa1NMSVpBWFFNaGJLZk14?=
 =?utf-8?B?d3VGdUZETmJtbXlIRkZ0Qit0T1ZuLy80a1JKbTZxOXdBSm0rUEZYeHBlOHBz?=
 =?utf-8?B?azdGN013YVFsM3hCM2tYQW93L0FlTFV5RmluSDBpNHFzbWNDaVNLcTZTRXlE?=
 =?utf-8?B?d0JXb0l3NjBtS0dyRjd4ZVhzMW93d01CWDAzN1dBLzhHZkR0bUpoL29pV2Rn?=
 =?utf-8?B?Q0ZFVVNvTDJhbWJkTVlCd2lDY2FpVVg3K09pRkNXQW9FVmRuUEk0VjlVTmFT?=
 =?utf-8?B?RnRUQ0ZtdE1YZGkzdzZ5UUNzZ1FGOEQrc0RmRlJ4ZFIzc1lCYWxSYitHUm9h?=
 =?utf-8?B?SmhPR2srYWhLWGZHam96dXlZdE9hNVl3ZmMvVlA4MEozQ3I3aU01YkhtaUdp?=
 =?utf-8?B?YXRveWlXYnBDV2NVWjA0UjRPaFBhT0dZR3A3eDkrb2s5VUk5bTl1VG1RRUNh?=
 =?utf-8?B?ZjlHOWZ2NzV4aWs3SG5UZ2lwallXQkZ6eDEwdGYzY1JVRXNOQlVhb0VBYVRk?=
 =?utf-8?B?eUVOYXYyWWwrakxGSEpGRUZOdkdmblZkME90cGFWL1R0RjMvcnhxb01rWHJi?=
 =?utf-8?B?d090OWV5YlFxSWNzL1hVZXhnWmpxVjkzSXJNK1FRTWpsa3dwM3JybHJQdjho?=
 =?utf-8?B?dThPQmcyZGdSL2JqQVhycXNsNXpXbzJBNStaQTJYaVpHOHR0WEpoNHFqR0xN?=
 =?utf-8?B?L0tXSHlJV25yMUhrbnlNZGliMUo0L3Y4Z3h6ekM0TlNMaWd6cjd0eXA2YmtK?=
 =?utf-8?B?WHozRmY3aHAvWnFqQVlXMm1Db0Z1Rzh5L3VlNnJyTi91T0t4a0FuY3pFWVE1?=
 =?utf-8?B?M1o4SjR1VzFmdDdaeis5eVQyemNMb1BQZ1JybGRGdi9wUkNxaHprZ1RiOFYv?=
 =?utf-8?B?QkN3bkZiQnh6YU9peXJnSGx1cGdMcmxCbjNkaHJ0RFQ5SnBuTHN1NDhaNDI2?=
 =?utf-8?B?U1E5TjdLRDZSYWVaS1AvUTBOSjduUzhmN0dQKzcvZUUwM2RuY1VRdWt6bnNp?=
 =?utf-8?B?ZXZLWVk1RDhZMWg5NHFvWHU4VGdEbVNJc0NsVzVKbHp1bVRYb0I1cW9YOElx?=
 =?utf-8?B?WHZyWENrajB4STdyY2JJbG8rZUJwd3JSVXRSYnJUUXlmamZ4ZC9zY0dKZFI5?=
 =?utf-8?B?SkN2U3ljcTIyaXZDV0FwdUtuVXdjblBXYXJERjlOL1Z1RlI3ck93KzFsbFZQ?=
 =?utf-8?Q?r4ihHdfxq9xyVWjpY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWFWUE5IS2poWjNrZHVRK3NLRDVJUG9LZlFkZEVqa3QwcEFCYTI0VzUyQUw1?=
 =?utf-8?B?K2VscGkvWjMzRHNDUDBLTkRHVGt5ZmJaOUNaMzNPZnNyLzVMYTJNVWNjdUk4?=
 =?utf-8?B?cWV2ejl0NDhRSko3bU9iSzdoSHQ5d2wzMW5telVBdStHTFRlaTdQa0orQk92?=
 =?utf-8?B?OGppTTdtdDlrYk9pdTdrWDJ4TEN6RzZjUHhvWVM2T1VZOWRadEVyYW1CcUtM?=
 =?utf-8?B?UDhrNUU1U2x1dGUxQjg2QlZ6SERUV1BHQnVQblJnVDQyWGdkS1pRTUlkTHhI?=
 =?utf-8?B?WjdZdjNscXlleVI4bVRONDZhNVlCSW1hdm5hcnVNbVZRcVZSSkwyYjkrcDBv?=
 =?utf-8?B?NTYwQzFkQk9hM0lnOERUVm4xZER2WURLa0c5ME5vNFhkUk5neVlUUXpMQXh1?=
 =?utf-8?B?cmxRdHY0akR0eGNQdjJEQ21lRmdxRUU3ZnBMZW1mbUlnYzF5KzFVVFVzZU9W?=
 =?utf-8?B?R0RONWU3MGtEaEp3TDl5Z1lYQTlidUkxckFYTit5by9qLzZKelorcG5WbER0?=
 =?utf-8?B?ZnhNWWlyeTFVUUhSTm1SbGczRnV3TDNUQk4zTHdHdGNyV1VkUHd2TWxYRW5p?=
 =?utf-8?B?Vm1GN1pZTWRScDA4RW9UalRWSXpMbmYwbWMwQXlYeVJ4bGFMSWFyUHNnSVZE?=
 =?utf-8?B?NFhpWXlsMzhnSVlpbHFhdjJJMG52UDh4WWlOWElOREw3SHZleEt1OHAyak5Z?=
 =?utf-8?B?SHhVeDlRWUtlNFpkdSt2WTd5SDVONmMxeHVHdnFKc0ZCNU5Ka3p2Y0JyNk5n?=
 =?utf-8?B?ZWNGc3Z6anViVnZZN0paNEVjRmRZNFlBNzNFOUtlSGxoQzlFVVZ3dzlhc2ZP?=
 =?utf-8?B?MnF6Mm4ra2orRzMzaUtTenZtb2xZL1NyU0VUbml2ak5icWozQk5qRjBuekl5?=
 =?utf-8?B?QS9BRHRxKzhlVlduYzUzdGt4UkVSUzVGT2tZdkI3VkpTYjFjRzVOSWF0Y2ZI?=
 =?utf-8?B?NEcxUExnUGIwa1oyNElmb01KWUhEOXErQXl5VmZhYVRiQnJBbGtNdGR2ai9l?=
 =?utf-8?B?bSt4QkpjUVR1NmtrY1VpdnQ1clBnVFIveXhyV1pDRHBpSzMzcmlFWU5qNVB5?=
 =?utf-8?B?VzBNUURXcWRrOGhOYUgwY2t1aEVQSWpQNU16QTh5bUNmMFF1TktlWUZ0SkdR?=
 =?utf-8?B?SVN3YUtNbVhtWFRQYXZ4MTRUTXpVeHN3TlJBa2JTenhKT1hvUUV0bC9NTkk1?=
 =?utf-8?B?aDJHVXA3YktsSUU5T0RmcHdhUnBOd0ZRdHF6dTBhcE9BVS9EMDVLcGJUdldY?=
 =?utf-8?B?RDgxMGtabUhDM0swaEg3emRheHFMaSsxaHdiaTczVWllRGQ5aFU2MGd3MjBE?=
 =?utf-8?B?aFYyYjBTcmNWUDg2eGsyb1dTb2pjUFJDYjN6VXR0cFk3cjVOdU9BQXoybWhX?=
 =?utf-8?B?QmFybXAxdll4QVR0VnJVN2NkdHhrSTlwbUxrM0k2bE1HRWdueXk5cXlPajVT?=
 =?utf-8?B?b1RyQnlHSFl3ZFF1UFljMEtDNTZWSnFDRFhCelhaQmQxTTZ3d29ybDg4OFVn?=
 =?utf-8?B?TnZaRFlSNktHUmhBZVphRVkxSzlkL0kycHRQLzE5ZlZtSUdTdG9xMS9RYW9k?=
 =?utf-8?B?SVRIUG9xdjFpTFFUWHpvWTFNOHZKdXVYVmRETEFvU1JiZ3I0dmExQnVOWGt6?=
 =?utf-8?B?b1FrR09ZSkdXL0MzNUNsSEsvbEp2MVB6NktoWGwzMkptU1FhOEJLbnFtQXBS?=
 =?utf-8?B?amQ0YXBubllYaHhScE9kRFlOL1o3UmdjTGtZU1lNci9iS2t0SXFibjhNYmVW?=
 =?utf-8?B?cHBvWXFiTUlWOXZ1bmN5VjNoTFJmQ0hvcnRRUEVYVFE4aHI4ZDZGaGI5Q1NI?=
 =?utf-8?B?Qnp3ODZWV28xdGNpM2M2ektXWndqQU5VL1p2VjEzTFJOWFpFQ1ZUbGRHRmta?=
 =?utf-8?B?Z214a3hOOUFxTEs0bDBpN1B0bCtMYUw3UlRWT2ZxbWc3VTA3UFFXVmVIaVZl?=
 =?utf-8?B?azQvZG5SeFk4a09xM1JPckNCRG1KK0lFbkhQQ2hEWjZRZThFRUJ3UWgwWEtI?=
 =?utf-8?B?Z2JJOHBlR0p0TTlHaXV4R0ZOcDFHK1dvS3hwQytSRDlSNk5rRldmYXRadFNi?=
 =?utf-8?B?M2lFVWwxSlVWVzZ0SlFPT2pHTExXbFdiQ2t4ZktBcjl2UmtuN2JJR2RCWlh6?=
 =?utf-8?B?blE1NVdDSHpPTlpYMUtNNUY0MUQ3RTRHUFhBZjlHVmpwRjUyRHdtb1ZYWS9r?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49243768-40f3-4000-b749-08dcc143a46c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:12:24.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5PNGQ5SwuhCqnATc0iMeQgKDC3uBCNFlLPxeeerZf9vSlPOQdkhjzz2Hb3CohnSggu429B0IKgiBHkQxLVnj2yC0Agw0hv7CL49Sk1GPBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6240
X-OriginatorOrg: intel.com

Hi Babu,

On 8/19/24 11:18 AM, Moger, Babu wrote:
> On 8/16/24 17:33, Reinette Chatre wrote:
>> On 8/6/24 3:00 PM, Babu Moger wrote:

>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 66febff2a3d3..d15fd1bde5f4 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>>>        }
>>>    }
>>>    +void resctrl_arch_mbm_cntr_assign_configure(void)
>>> +{
>>> +    struct rdt_resource *r =
>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>> +    bool enable = true;
>>> +
>>> +    mutex_lock(&rdtgroup_mutex);
>>> +
>>> +    if (r->mon.mbm_cntr_assignable) {
>>> +        if (!hw_res->mbm_cntr_assign_enabled)
>>> +            hw_res->mbm_cntr_assign_enabled = true;
>>> +        resctrl_abmc_set_one_amd(&enable);
>>
>> Earlier changelogs mentioned that counters are reset when ABMC is enabled.
>> How does that behave here when one CPU comes online? Consider the scenario
>> where
>> a system is booted without all CPUs online. ABMC is initially enabled on
>> all online
>> CPUs with this flow ... user space could start using resctrl fs and create
>> monitor groups that start accumulating architectural state. If the remaining
>> CPUs come online at this point and this snippet enables ABMC, would it reset
>> all counters? Should the architectural state be cleared?
> 
> When new cpu comes online, it should inherit the abmc state which is set
> already. it should not force it either way. In that case, it is not
> required to reset the architectural state.
> 
> Responded to your earlier comment.
> https://lore.kernel.org/lkml/0256b457-175d-4923-aa49-00e8e52b865b@amd.com/
> 
> 
>>
>> Also, it still does not look right that the architecture decides the policy.
>> Could this enabling be moved to resctrl_online_cpu() for resctrl fs to
>> request architecture to enable assignable counters if it is supported?
> 
> Sure. Will move the resctrl_arch_mbm_cntr_assign_configure() here with
> changes just to update the abmc state which is set during the init.
> 

I do not think we are seeing it the same way. In your earlier comment you mention:

> We need to set abmc state to "enabled" during the init when abmc is
> detected.  resctrl_late_init -> .. -> rdt_get_mon_l3_config
> 
> This only happens once during the init.


I do not think that the ABMC state can be set during init since that runs
before the fs code and thus the arch code cannot be aware of the fs policy
that "mbm_assign_mode" is the default. This may become clear when you move
resctrl_arch_mbm_cntr_assign_configure() to resctrl_online_cpu() though
since I expect that the r->mon.mbm_cntr_assignable check will move
into the fs resctrl_online_cpu() that will call the arch helper to
set the state to enabled.

Reinette

