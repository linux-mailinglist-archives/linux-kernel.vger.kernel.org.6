Return-Path: <linux-kernel+bounces-328869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C001978A27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E72845C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8442042;
	Fri, 13 Sep 2024 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9eEVLEx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968A1465A4;
	Fri, 13 Sep 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260319; cv=fail; b=Es59Eh/sWOyFvf3s9DwdZ/JpGjIIkzOyTJxeViD74gcog1b/RmwijiYnDx0JnnkGZLOsFZY0ZK4Aa7xyUmaRQNoud3DeIhba9bZeufbuvY0uqGG9nMw/N2UPCKl81SXfURMddUJagPagQbbIhUfafSQ5T74go6WuX/7WLorjr38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260319; c=relaxed/simple;
	bh=MmJCUk79XBrnhgA0EOcWh7Ov5wUAQC6SxYUs8IDlF1c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LB/W5MOcriKIz/NOpOVhuaE/9Kl72I4m8PfpQvzojO/rSBJmMrbj0XeIIOEKSGB0xxIHuclh4dYsktqvL8JMWnbDxsRgDipkZPXIuE9lWQ89/WPLswxqaiyJ+uNLtUT88CQlzT3Q5vLNjV9a7RjJrRAqUNc0MT86sdOg2bFhHek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9eEVLEx; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726260318; x=1757796318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MmJCUk79XBrnhgA0EOcWh7Ov5wUAQC6SxYUs8IDlF1c=;
  b=O9eEVLExVuSuxyBF+tCl4fkRho4pJKV40AnU7zGSOxknGCBovGpK43MN
   v8TbhuSnsjf9mgj7tWI8cLEM48ZWn+gQSzy/hqB3JAfP1PYNmKQ+8zmWL
   LpTph5xrdG8wcQEoFBD20SXXlltpwMjS718kqneSbEsBqTaTPQ0uK/gGO
   xYcWF52KpslLluuddQCE6i4n/NOD0QwayvBujk26EwwjbL6mu3LTBVn+2
   Sey5yJRc79zPWGpu+LKNdjA1kT9xOgGrhGcVdQTYEnEuq8GEqMFscZz5m
   sEV4G412zjndrxMTdonwPciufzDhfwtkN9btOJVcBKvSV1Eq4PdbIlaRH
   w==;
X-CSE-ConnectionGUID: gWbZdy7zSmqrjwZn8i+IBg==
X-CSE-MsgGUID: 3jc2aPSMQyWldO0C9+LPog==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="36311442"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="36311442"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:45:17 -0700
X-CSE-ConnectionGUID: 4PtEts/gQdiDMHhNkdEsBA==
X-CSE-MsgGUID: 2SNiuy6xT7+yrZvGEf6rkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72306687"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 13:45:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:45:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 13:45:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 13:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9l2sdxmRC/fLde84L0Nwqhim1y2+ZCzoAP7ruiigNahzAaAcMFLYEj4R4c/T8++h81FYc+KIcZsD0TwjjmH+sEYU2ilmirfS5Ui1/R3p0FWvZgMqGR+Bp5XcLY7KBXidtcP7QSVdqfLfVXz2IuJNQar5QsA0sxQmHx5ojc2vVtuyEmGIdVSTnXqt71/dA0DT3MSmIDHbl2FRHYQIm8ue9Ve1Vt4fJUUuZWsfvPe5oc2ABGsstBnnOBfB7z1ANv1qmUjGynS5PICRNeAtuwlRyEvvv8OOBsgZcPAw33+yQgRDwkYrQFxKcYxjymaCWK+4//0yc1mJlqF6xr5rbxzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK6FBkrEQ8taGvulNdIq9ZRfTRuZdaL180S0sFwF8OE=;
 b=PXNhXZhwIqM1NSCICKCOKUanWFW7AMj7gmF34Sh82PJhIfrnSRPdg8NC55GcaKYneP78ZBBOp4CAA/QEFJ8PAAOtLfF2RA4pBfT8bec1ynELl9TqHf/Aexfa0e2elrS61Hdd2J4wy5n9fsYWy9qSdPuZrk+q/8zrr275IwQjuHQZ9bZZqzDHOJekeDzfjpbv7ZkMLAxk8yqwQFVepicMGyFWDdfpW4ggRvF/F2ZrjnWHI3RbFXSNisWjKpFJwPyTRgCvuvK2a0TQVw784j8xDhg5PEbDf2/S77NwvDE183aB8KcGNva+lhC73RW5qO8mJLUrSX2Unk/Ymn0xl127Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 20:45:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 20:45:07 +0000
Message-ID: <8b8d1523-b925-4d6a-856e-e08cd84f348b@intel.com>
Date: Fri, 13 Sep 2024 13:45:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] x86/resctrl: Add SDCIAE feature in the command line
 options
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
 <c9dc15428edf7164a1ae73f10348f3fc4cb9fbbf.1723824984.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c9dc15428edf7164a1ae73f10348f3fc4cb9fbbf.1723824984.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: fd44b845-a4b7-48c6-f7ed-08dcd434f37c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmZZMWFaZlFZbWw2SS9oWkEvenhZK0NIZWJEV0lsZnkyeEt5ckx0ZS9FTm9h?=
 =?utf-8?B?YkNadmxRVVJ3YkZYYlVaVG01cTFZeEh5REtkaW80OTNRVVNjbDNJLzFzV1pZ?=
 =?utf-8?B?TU9STzU3RkZab1diSWtyN2ZoRmVUQlNhWnpLZmNRNGtXdEtJOSs5RzZzZWhE?=
 =?utf-8?B?Zko5SFAzek5uMnF3Rk5CVGpOdkxFVmNuanlGakZ3TmR0elJPK0pJQTJWNGZQ?=
 =?utf-8?B?Rkwyd290ZnpPZEVPb0FXaTh6SUtCZG1OWGw0VGtFYnJDVmVBNjE2TWt6eXUy?=
 =?utf-8?B?UnkyQytxSEU0bEdLYXJtRTNTa004dTlrd3BuVitPOW9LVit1OUZWS0lsQ3pp?=
 =?utf-8?B?NlZ3NkdPaHBZdkpZQ0wxaGxtcDFKM0NrWTkvekNBKzY0bTUvN0NocENiQWJo?=
 =?utf-8?B?b1NVelZyNmp2eU9MM2YzMHB4MDNWV2k5NE56enlBdHR2QXNhT2dBRVZtSisx?=
 =?utf-8?B?YUs4VGxBL1Q2Z0R3dXl4ZG1SWWhqQTZFUTlXTWh4bGpmc2xhVzBkMlpXSHZv?=
 =?utf-8?B?TWprNHBLSEVjK01wOUU2bTRRWmV0eXVoQ2VpN0ZYaWd0citxSERhaDljZzM5?=
 =?utf-8?B?ZWh3SlNISHlwTGc3Y2ZaTmx1bTljQ1Frd281MnNIc3BiSDFiT2UyVjJJT0ha?=
 =?utf-8?B?L2ZjazdzU2g2bzh1dStkL3Z6dFFDRkhMK2Fxd3ZHVTZ5ZzMzUlM2TmRrRDR3?=
 =?utf-8?B?ZGtHYkdIMkg4dzFBVFBNeVJOVE5WVVdCaGozNU85a2JCQ0xYeno4Q3RxbGF5?=
 =?utf-8?B?eWFQVDV5WElVMElzNjVqMlR2Y3gwa3EzdjFsekFRcWt0Ujl6eDFrUlFyTDIy?=
 =?utf-8?B?a3FSTzhmbEF6bVpITjBpSUxPRG9qTHM0c0h0bnp1ODRXRklBU1FNMGQyVjJP?=
 =?utf-8?B?c1FGaERLWEcwdUxzaW5XU0RKUWEwRUhBS2ZTcVVMNjZSOHVUOG9XRzRLQm45?=
 =?utf-8?B?MDRvazV5bHo0SGVBakkxT2IyNXQrVVByVjdad0JSWGdpdFY1SGNOL1hKekE4?=
 =?utf-8?B?c0laUHo1SXIvbTQ4Z1IvcGNQN1NzWFBmQklUWWxPNktIVkFCYnlCUy90bGJa?=
 =?utf-8?B?cFpRMlVMWVQzQlcxOHhKQlZZSnAyUXR2RkQvUUpwaGNrY0ZJWENpdGNyYXhR?=
 =?utf-8?B?SWY5V0t6YWRDclFOaUp3RkU0c0x6OGZRRk92c25uWmxhQ3Q3aUtKczVaTlBP?=
 =?utf-8?B?c0I2bk5wVlViRHZjeE05MGk3dU0xTGZ6UTFzSDB0NDg4a2hYTm9YN3pQUnNz?=
 =?utf-8?B?Wk9Md1dkRVVhQmJMak5nakZIY2NKQVFOVjhNZkZaRnJkdlVDaVY1T1BPNkRQ?=
 =?utf-8?B?bjV4NWgvWFkvMFR3QUMyeHF5ZEVCU29nSlZ3dVBhSjhvZXFSU1N1aFREK0Vx?=
 =?utf-8?B?NGRhZ3ZVL2hDZTU2RWNIUkNmTGZRN2dpcHRiWDRXNW1XeWF6SmRtVHV2SlFr?=
 =?utf-8?B?OVppWWI5OENHeEUySU1QMjZpZFRiakpFUzhrUUNtT2pTWENnRWo2NklEeGVm?=
 =?utf-8?B?U3l4T3RiRlJQc09FRWJoTTN3b1h3SXBIZjlhNUJWbzJJK2hpNk1nR0g3RUtJ?=
 =?utf-8?B?Yjc0UjI5OWNaQ09TeXNBYW1JVnRSeVBPNU1FVVJjb1hDY2RHeGZBRlh0UEdN?=
 =?utf-8?B?M0pkTVlWaHh1VlZZRE1hell2ZFBETGRmY0FyaGFkdE4xTFdyNTF0VlFJNGNs?=
 =?utf-8?B?M0l5QjF5V3pTOGFPZHNGRjN1NDh2YkVqRExKVjJ1QStRWXFja0JRbld4cGZ0?=
 =?utf-8?B?Q1RvN3k1V2h6ellITG5nd0tieEN3RnY0RUNwTjJCTitPNnprOEYzb2ZxcFd1?=
 =?utf-8?B?RzdzRVVwTDJDVVpGZXRZUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRUd1pGQThnWlF3d25nWkxCRUpXaXM0Q3A1OXUvMXl0NnI2ekRLd29yaHR3?=
 =?utf-8?B?Nit4T0VPTjNJVHV2VzNJcTVWRDVGbkZ5UHBXYis3SEtCZS81d281NDFzVWlY?=
 =?utf-8?B?b3RLVHR1ODJvQnl3Y1RpTkcySTZPbm9IUlVmZnlWdkgzSTNUbzN5Ty9UWVRC?=
 =?utf-8?B?c2RYMkUrSnFHUFM1SzcvSEpqaDhKZzVId0FEcHp6Q0dWUFVvT0FMeUpMSGdu?=
 =?utf-8?B?N21JdU4wY25nbWlNWXo0SmQvdkNSdEVCSFA3VHhGWk9uaWZiWHR3ejFsTDE5?=
 =?utf-8?B?WUpFQmZ4RHdQTk1Zb0lDb2lRNCtGeGc3b05TYXhHcjlmL3phVmNvVG5VRzhD?=
 =?utf-8?B?MkJkK0k2WjRxWDNNbmdjT253ZlRmeEpndUN2ZXQzY29DWEU1WDlmeGNoQ0hD?=
 =?utf-8?B?a2xBb0xlYjNIV1BybUtrcGdZYVhkdmVVRC9UZVZ1eVZ4UTV1bTJUaHh4QmFG?=
 =?utf-8?B?dWZoQVk0VnFQY0RMNjlNV2dEREpwQmg3VDczeW1oSGRuajFQa3pvTkJMbWdN?=
 =?utf-8?B?a2ROSmtRb2hHL2NSc2lUN21XaHJNME5TVDZMZHhWSVFEM1hlblJzRHJXd25o?=
 =?utf-8?B?MEpnVG0zWDdRWVNzeXZGWFZ6U014VDVTTHA4SGdMRnZVcHBCaTlPTzFpNHBi?=
 =?utf-8?B?TnQvZWtMTGlNMEsvQ0ZKZzFnVDlsS042bE40alhNZ1FzSXZoalE5aDZ3ZEVt?=
 =?utf-8?B?bmtWN2wwdjdrK0VXVzJKc2dQQ3BFenRoNDVkRXlWUGJHZHpObXpzaHRZQk8x?=
 =?utf-8?B?WGdESU1kWUtuQUV3QWRGRWFVV3lIMlczdmtmRkxsNlNIcUVXTzdoOCs2OEw1?=
 =?utf-8?B?QjI0Mmlzb0F5blJaTTYwUC9yMHEycjdhOGtjc1dOZ015d3FTT1ltSmFBZ3RU?=
 =?utf-8?B?TldiRldRRjUzbitZWDQ5cHBmOFBDUldoUTlVU256NmhpekkyaElhVW5EcHd2?=
 =?utf-8?B?K3lQV3JjMUYwQWs1WHBOOUNqeHR0aXN4dkJZanJ4NmhJQlhmN1FaZ2xjazJy?=
 =?utf-8?B?dC8xNW41YVFKMUVMYjFpTExkL3ZxWjZPMkdmVituUzc2eGVmdTZocnp1cmpM?=
 =?utf-8?B?T3Q1YS94MmV5UlJaQzBlRW9BYVZtb2d0UWRZbnVvTVgxNGpUTjFyTVVURDJD?=
 =?utf-8?B?S2NTOHZJNXA4aWx6VlNKZ1pPZFh1REJqaEJsaVpqSHJreXhQSUowbmRVd0ZL?=
 =?utf-8?B?QjY4NjVScnpWRmZXL3UvaXhnUXRJUFovMmNJQTlZU21xZXEvQzFqOG8xT2JB?=
 =?utf-8?B?bndxRytnaXpMbWhMUTBrVmZlNEVOWGNYY3I5L1FsRmZyMnVRZzArOXBoaDlh?=
 =?utf-8?B?ekZYQUc2d25BWUdHQkh0TSt0K0R0aUdldEZOWnYybTZlQS9rODcvcW8rVXVE?=
 =?utf-8?B?WlRyYTZ4eXJXRDhoRUNQTUNqSmFMNFpWN2hiMWh3RUErUEgzalBOcllnN0t5?=
 =?utf-8?B?cHd6OGNLWEh0ckY0WTVsUjJJN1NBTXFXVjNROXBLZG10SW5wajlWSDNMb0ZG?=
 =?utf-8?B?Q3V4d0pIVFpNNzNuWW1hdGdEUTFFSmpZUUFpeTZWZGZ6LzVNNVRGS3hIUVVk?=
 =?utf-8?B?dUxaMzVkWXVjRlcxNVVpMU5paERrTThncVBTOGwzZnIxRmo4OXg3c3g1S0kr?=
 =?utf-8?B?ck5BNVdrbHdpOHZkazcrS3owUktPQmkwZ2o5TG9ZRnJFM3E1S0JNOUZSV2JE?=
 =?utf-8?B?YjA2VGVrV1lseklNS2lneXEyeVMxd2RCaG5vWFNoWHNFWk5lWWlQUkNYbjh3?=
 =?utf-8?B?eUVKQW1ZbjFKVit1cStHQTFtTWhLNVZuWEJ3N2dPSnJvRXJveGlQQlRMR3JU?=
 =?utf-8?B?aDFqTkZaZTg4ZDlzUmErNGhIc0loTkQvOVcvbktMSE1uWVZpUGVaWnA4ZkZz?=
 =?utf-8?B?NkFuNS9ibmsyM3duUFppNy9sbHlvQUo1UVVJelFhZTBpTWxUdGQ2SUZYeDFG?=
 =?utf-8?B?d2w1RmVnZkhDOUFFZm0xRVRzbElNRkRzV21laDFDV3Y5bWxJUFhOTjBnbVdr?=
 =?utf-8?B?WjBIUExhdFBVWkVJMEZYaXZDZTNpbmF0WHRyREM5bDRSeEllSGluRWxyRHJ0?=
 =?utf-8?B?cmRIWE5ycUpPZ1JRWEhYVkgvY3NIWmVGVVBzZ2hacU1MZkNOb1RiMWlHN1Bp?=
 =?utf-8?B?dkIxNFdtS3loeXQ4Um1jWGZIWU91OW9jQzk4b0FRdUcwNUV5SGtxYmNvS3JL?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd44b845-a4b7-48c6-f7ed-08dcd434f37c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:45:06.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYLPPybk7BmIL5QWdSmLaqOM2SQn+ovOVE9ZV/EMJf2rDFBtc6kVQa3oIpgmvNU083g2gCb+GIEsmgXJjXBXFey5dH606dUWlV3/wKUJHqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com

Hi Babu,

On 8/16/24 9:16 AM, Babu Moger wrote:
> Add the command line options to enable or disable the new resctrl feature
> L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
>   arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..63f17d23b8f4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5604,7 +5604,7 @@
>   	rdt=		[HW,X86,RDT]
>   			Turn on/off individual RDT features. List is:
>   			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
> -			mba, smba, bmec.
> +			mba, smba, bmec, sdciae.
>   			E.g. to turn on cmt and turn off mba use:
>   				rdt=cmt,!mba
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1930fce9dfe9..c4dfc768ddf5 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -801,6 +801,7 @@ enum {
>   	RDT_FLAG_MBA,
>   	RDT_FLAG_SMBA,
>   	RDT_FLAG_BMEC,
> +	RDT_FLAG_SDCIAE,
>   };
>   
>   #define RDT_OPT(idx, n, f)	\
> @@ -826,6 +827,7 @@ static struct rdt_options rdt_options[]  __initdata = {
>   	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
>   	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
>   	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
> +	RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",	X86_FEATURE_SDCIAE),
>   };
>   #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
>   

Why is this needed when patch #5 introduces an interface to enable/disable
this feature after mount?

Reinette

