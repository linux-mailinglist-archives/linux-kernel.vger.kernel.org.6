Return-Path: <linux-kernel+bounces-290340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE6955275
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD071C21894
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7B1BE250;
	Fri, 16 Aug 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dF+4Wct5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD64315D;
	Fri, 16 Aug 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844063; cv=fail; b=FBnHzKP+JxwFj7+5K9yXysh31R+b7ZQLi4JMelloX9SelhPVv2vIYCDJHHkURhBftNNiKCIhetQI+9arb6TNlcbL+fm7+z12ggvwzJguMgFHNUR/nzaphdV512MuFpsokhAO/8PxETzqFHIYjmgTqOEqqWgsdVvJm5p2c0rKMbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844063; c=relaxed/simple;
	bh=j4hovLCjp91NkT6hH3g8fR1yCuK1KACrChtDMoHjVYs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0UgkA37EJOJqiGvkLylYwZa1Pcs13xQnFFrt4HvDL+AFOjpsCqLSTQmvWCLV6bnbd8/O4wZ2MF+i+noIeS46O4J/ZXqwCMN+hVOZC2zkb+ccoXDJKbbVrRphrwg8PANT3s8NrFReGW1FAN0zu5HqrHYr1bXhHFU3ub9TIJ2Pew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dF+4Wct5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844062; x=1755380062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j4hovLCjp91NkT6hH3g8fR1yCuK1KACrChtDMoHjVYs=;
  b=dF+4Wct56KoL8VW6ftUk/ZyrThQBluyd/nw3s3hCP4d1MTniPTDZz9Ex
   vruCKnDKnyLLGWncQf3dW5DkviPHTnk8wr5/9d03lmWt4UA/nIqwn+kIP
   a35k34zTRvAFwfeAoeFEfPaVvviRBgHmdW59StL01rPz49F4v0ShprIAH
   VvuHV7fCErX9eyySPYf++ICtpAqkv5snHMB5G6DUIoF8iZSJmcIelP4pS
   GGZMmTCDmErSW6AEs/3qdAI+RfKsp4XXJV0m8/nl/igp+inXF1tP4zBdp
   nUY+4KN2i9dDtVUFQ4yWagkDOpWOunTZ7n9Z/1wGgYXVRbGAQwcPGReiK
   A==;
X-CSE-ConnectionGUID: HzMBu/maRKOfcB4Lptoj4g==
X-CSE-MsgGUID: fFhMTIPJQGu3s6pEtwd0MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32823444"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32823444"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:34:14 -0700
X-CSE-ConnectionGUID: 7xVhBbcKTdOFaLb6ixHmnQ==
X-CSE-MsgGUID: R+e3qspIRRm3MZOyCCc/wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64619256"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:34:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:34:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:34:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgEfZv6K89nqW/MvUqI21BZycW/e6UyOOs/KhcLTZ2cEG07OAERXmJjI6H9Dos+yhGRQnWgg6aTTNbLmx5D41jo6SnoVMHdnPLkqWkdQLSkbFTCvq6nWSSMWvm7ejcU5LiZR+/isH2LX1UBM8LBI0RaWYKyNxh4CMLFN5ai55+hPpINMVNMKTgUkYDgcOWFciR8bBCtAjvd3Z3p7FmzDDI6QibK+EZHXsB/3xN8cPcqb/U5wsPWl8CNYLISlWAzpIUBi5PcBIWjOiE/O3D7+wXHj5ETD/pR2xSNmGw5XACMMC6GdYNkYE/dKcJiTeUrSTc44poVL/0MNqCqVJ1Mpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4vgQmIkplDqp139fN7OW/l/IyfKesH6QCGDyH8b6/8=;
 b=Zk+2sSw8WX/pcBVDR4sphxl9q1DHTvB/Cjt01aotKv0jp8nSF+BHZ7FtBLqgCidhH9YuZY9sym8w2RSm5PsLirl/ryXH1sudJZ2fZAH4QOkcHo4CTDKJr+vWOWGKwCvtDoBgnGLnW8AknGTyU4s7XKAnTWBzHV8Q3vAQCQAdumWluXNrn/+YsjtOnWBIZweqBxw46Da/61ZgFeKFZcuO2+mmLLt8RZGfpjoiLEBqAlMbZ5E2Iw0cXxi2WwuNX1DaCtbB9ZHO9i0340IiKmXFpcgRkCZP4KBCBBqaVq2EMeMe6F3khaIa2Yyu5VmtEPDccn6rKpRU7ztk8z00qBK2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:34:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:34:07 +0000
Message-ID: <6c1305ae-caa3-4da1-a0c2-3948cac976be@intel.com>
Date: Fri, 16 Aug 2024 14:34:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/22] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
 <da3c2f99c07987d59d9df1db0a0a85ec323cd67f.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <da3c2f99c07987d59d9df1db0a0a85ec323cd67f.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 2748e52d-5867-4d0e-039c-08dcbe3b28cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2k4TXN3MDg0YTIycWYwZ3h2T25UQTY4Z29kME9tUWo0UDJGOENQVHBMaXNU?=
 =?utf-8?B?SU9oUUVRcVpsN0JpSWs1UTU2Z3Bob0JIMTRQS0lsVkRoTWJEcWkyTGZ3OUdT?=
 =?utf-8?B?Y0xTMTAwQjFibmY4UjJFbHZvOStjRklaZWY3UTU1WFRtNnhScE10OVo5dG9B?=
 =?utf-8?B?YWhYS3F6YmRZVFVjZ1lqQ2V0VEIxaFJpVVNsNVhEUmdkWldGUzh2NlJiQXQy?=
 =?utf-8?B?N3VVOVNFRXkwM1Q0UEJ1Mm4yNloveXFwZUdoMUJhRGJIdERKTGVYaVc1TWgv?=
 =?utf-8?B?eDhMK0VTRmJVNHVkbzhiMTJRdjB2MXBTbG9CYkJqcklLdGJPMDl0MkxNOWhw?=
 =?utf-8?B?dmpOMGFKcHhPREo1MDl2WjNqaVlyUDltcHBNMFlyd1h3TnhVeFdqbEdpRGMw?=
 =?utf-8?B?NHM5cVlHeEpTQ3F2QWdTNUhCbnA5eUViUWxOMndMcG9uOEZaSUxoUXJNZGhP?=
 =?utf-8?B?Rng4dmdCWmNnVTN2RGE1Z0RscjRwYjdpdEdRT0NMVGJPZ0pmRVBtU3V1MUM3?=
 =?utf-8?B?cHVGNXFqMTdRT1QzQldpRkdHMDhRMHp3Qmx2YTRMRkxaZlpRRGU5ZENuVWhB?=
 =?utf-8?B?VVQwVTNrUVRXVG13Z3VvdEtQandyTi90WTR6TGxWbHp1dE5NUnBzTzVBc29B?=
 =?utf-8?B?WkdDNU1HUXZEVlJPcXpHLzBhbEYzOFdmb1Jjc1ErWEp6b1lRMWFEaTRYVmJi?=
 =?utf-8?B?Vmd5NThKc2VOWEhMQ0FBeXhNR3l6dVN3aVB1akphRUZPTXY2dlV2eDJjR1FF?=
 =?utf-8?B?SGpyczB4a1NIdjBnSktocWFKZUJRTTlncld3amV3YUlBZHorZVozK3J1Z0ll?=
 =?utf-8?B?cHlUTnhIajdzYVNNUmFwcFRIY05UOU9xZEhsL1ZwTDk2OGtCcGVDUnFRMkU5?=
 =?utf-8?B?YXZHVktCM2hjeGFKK0c2L05hMEVLOC9aNS9kTVZLaWdGdE1EYXpMWkxkYmFH?=
 =?utf-8?B?Z2VsNjFoUDRxRDEyTkJzdXRJbFA4S29GN0hEc0dnT3Z1VUNQcEpraFVnZHNX?=
 =?utf-8?B?UXVtNHNJa1VlMXdmb2p5Mm01NTJTS0tpTmlnMEt1NjVFNndPZTUyc1BRT3hL?=
 =?utf-8?B?bkFjdGxheEJMVG11UmJxNTI3QmlRTjIxM2ZzLzJ6amJjUUhWUU9lM2RXKzVs?=
 =?utf-8?B?N0RCOGZoVjRRUHNYbTFOK0lRclc5dHFEQTNPaUIzRTMrK1dYMEhtMXUxQnYr?=
 =?utf-8?B?bitCUlFadVZOWlRKZzVJc1YxSzJseFZiRUk1OVRUTmpFTDQydzA5bzU4a1RY?=
 =?utf-8?B?UUdXK2xYUEtsMDJYZ05rMzdrYlNGTWNzYjBwVnMyZXE1dEVDUXJHZGpUcW1S?=
 =?utf-8?B?WmNObWh0SGFxQ2lmVHFqeWJSN24rbE5ERThYODlNQWR6VkYwK2hBUndPbVEz?=
 =?utf-8?B?K2tKcFFmYnEwaWRMaGNCd1FSU0tnM3d5ZmVZZFJkVmFNc2M3MXZxbnBPd3Mx?=
 =?utf-8?B?LzZ2bU15UGhXWWFXcDR3Q3R2YnExOEEwYlJyTjZOU2tWeWcweWJ3eEtrWDRM?=
 =?utf-8?B?ZDNIMmpieVQ4VjRRbldpUm5la1JWdHRrSHFwcTQvMzB0ek9uNk9KN0hhTCtn?=
 =?utf-8?B?WFIxZXFkTHc3NldIT0FpczRUVUxyK3BNT09YSzU5Smw4YUtkaHM0WEhoaHlj?=
 =?utf-8?B?S2d5TkdzMWdTZXVyODJhK0tXVWg3NlpNSnZQWDlXQ3FrTUt3TVoyNUk3TWhV?=
 =?utf-8?B?QklNMXduMiszY3BtTU50RVdiS0xER2VyVmxBZEQ1OGIzcWw2RWxpNDhJK0Zl?=
 =?utf-8?B?bTNMdndNeFNkOGVqaEZpdXdvVUJxSGwvYi9XRVlzQnc4UFFJM1hrQlhxd3Mv?=
 =?utf-8?Q?pD0V1vdZAbbwCsP781u1XhsHKr6+NKY7lbMBw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhVekVWT0pGUUN2L2JkbEdIeUpaN0VLQ2o4RUhVNEFOSWlpUmFNUDJOWERo?=
 =?utf-8?B?QXBJVHczZ0VnVGZVbHZTMkRYaDZDemZoVFEyRmp0b1hyaVc5R1Q2VzVGVDUz?=
 =?utf-8?B?VzFWVFBEMnNtcVZ4b1NCcFNDWHd1Mm5lckF0NzI0Q0Q4Z1VsWEJPTDBUOXRs?=
 =?utf-8?B?aWxUcUpFTzU3S05tNGxWV1owQXZPK0pNS3NCNzBIWENLM1hBTng3WWoxaVR0?=
 =?utf-8?B?cXBCRzkvRTJzMkhQTW4wcU9RMnNiSEJOMUx1empodjAxOTRNWFNuZmhMcGRn?=
 =?utf-8?B?Rk15b2JVLzBHbEJ5VWVZYW10aWpPMnZEeFpBZjlMVGZodU5IWWsveE1yTyts?=
 =?utf-8?B?MEU2Tm03T1dsRlhBcEplSnZtNmJjYm4xeEcrRk5UcE1GMTM5QUt5YmFEY2g1?=
 =?utf-8?B?WXVvVTVZQWhKWVcwSjR0dnh0ZnBTUEF5WUNmT2ZNVjAwSGQ2VjlLMXhyRDc2?=
 =?utf-8?B?RkcxZEZjWmpKK2RiNllPVDFNdGdKTDQxeUpIZCtuZE5Ld3lxT0UzM2NobjZ2?=
 =?utf-8?B?MlNoNVVYd3VsS1NEcU5XL3NzOE1qNVJ2TjVXMlhLYVlkdWJRbzh5VTRhN0JW?=
 =?utf-8?B?Z0w2ZXlGbzlIZFhITXZGL1dJUEZrdmpuWEZGRUNmcVhJdUQ0S3BsaTFuU1hZ?=
 =?utf-8?B?WWRMUGo1OW5sUXBNUFZhamlXTXg4b1BpR1cvY3ZvMWFGQi9pU0RMTmZFbk5M?=
 =?utf-8?B?K3hwUDlHWW9WTVJUUnVJczVUVEZ0TzZiT3IzTCtQSUZIMGVZRXRCMjlQSDhI?=
 =?utf-8?B?TkEyUGQ1ZTdqQ1QwbGpSTkdpM24xdUJkM01kem43YnI3eU1Kd0wxaFhYbjl1?=
 =?utf-8?B?RkFncDl3Nzd3MXVCR1BqSWVodGZiY0M0MHkwOVBKT0J5NGdxS3VWNzJqYkxn?=
 =?utf-8?B?NS80TitDNTdOdzJOdTk1TVRBaEtXZVdxZnY2OWhNMkx3N2dqYmZYbDEralZU?=
 =?utf-8?B?ZktVWWFBNm1JQWc5SnVFMnoxYW1YVXRBeHlKVWZ5SXFvbUxObzZuTDdmWEZh?=
 =?utf-8?B?RktaRDI1WFhyalZRNUNwMS9nZXg4K0JidkZnWGNxR3hVU1VLZENwekV0RWM0?=
 =?utf-8?B?Mm9xWE5YaGJlcEgwTkdCREFheDZZWlBpT1A0bW5BNjB0VjdsMGU2UFdDWElT?=
 =?utf-8?B?WC9qS0pwOTFSdWdjWGxNQTJKaFJBMnhqMVBJRllRcVVyRFluWFkveFVzU2xj?=
 =?utf-8?B?TUNHRlBsd21iYUtoS1Bhb2RFUUwyZGdUSXZYYXpwL05kUFJiaDVwZ21Cc3Bv?=
 =?utf-8?B?THVPOFpsVXZnV3ppblFOTVJ6Y1R5WXFKT0RidjZ2MWZxZDJodGpRcHhLS2Y5?=
 =?utf-8?B?bXIvSjJNSWdNR3NzL2M1djlvT250ZWFZelNZbExRZndOenloN2FPb0NZRC9N?=
 =?utf-8?B?T1VxNkhCZVN2L2tjOWloTU9oWW9RR1Q5VFo5NXhtTEJYQUF5Syt0bnhYcTM4?=
 =?utf-8?B?Z2NVYTY4bklWMnJUbmhJYWdRZTVNbEdXMnc1YmhkZmtaUUdiazJnVHdET0V0?=
 =?utf-8?B?OWZBQUNzVlJ5V3NSWTZzNURHQ1pIUXl4TERnck1nVjZEb2UvSGlvYWh6WFhY?=
 =?utf-8?B?dWNBZit4SmFXLzdUaDMwUThOOW1aanVvZ0c1RHpkaHpKOUVTcXZVeVRUMWFy?=
 =?utf-8?B?Vi9NQ0VkRGcvVWNsaDhBM2pTVldyZ3JmMEJ5QlBTYzVabkw2R1RZbE1PUUxX?=
 =?utf-8?B?RDMyVy9zUEp0bUMyMGkvRVFDUy9SNFdzRWlwaVdVTFdteFBDMDA4QTRTYjVq?=
 =?utf-8?B?V250RlUwRC9xdzlrT3hoM2JFUzdCYkZPNmFlWkdITi9HSnpNL0RHdXY0RjBq?=
 =?utf-8?B?RUp5K1pRcUI2Yzhrdy9tRjh2Y3huZ3FJR2l5NnpOOHRSeW1YRWZzeDZwT1Z1?=
 =?utf-8?B?dEZmQUprMm4zSlRJeG83c0dweDBGMUtyVEJTNGJ6akVNUmFLTERzakI0VnBt?=
 =?utf-8?B?WFBES2hwamRBSWhzK3JKY2dWb0JTLzV5RFg4VkVFZFI1NzE2R0xGMG5MZnZi?=
 =?utf-8?B?dkJsZXhiN2VBYUxaR1BCb2dFWkx3Q28ydXUxdTlWZWdEWG9nd0ZpU0tpNDNp?=
 =?utf-8?B?dGJtcTZrdU5xdUtRS2UwOGdaNnEvK2JTaWFaWGM0dEs4aW56eXYzc25iLzgr?=
 =?utf-8?B?WWV4Y3hibDZFRWxudlRKS0ZRQy9LUk82UUJXa2tWN01ZNEFtSTl1RVFNMms5?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2748e52d-5867-4d0e-039c-08dcbe3b28cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:34:07.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JCFOI6XbWPiYPG3aEmmoGGMo9KqpS2Ge/oB5x/NlcfQ/uV7GT211++btQO6Ka7snz9zk97jAqmDVic1dDQ31dCD5NAKcC7/Rd4U8KzQ9z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware

Here and in all patches, when referring to resctrl fs please use the more
generic "mbm_assign_cntr" mode to distinguish it from the hardware/architecture
specific code that involves ABMC. Something like

"The ABMC feature provides" -> ""mbm_cntr_assign" mode provides"

I also think that being explicit with this separation will help us to see
gaps in interface between resctrl fs and arch.

> counter to an RMID and monitor the bandwidth as long as the counter is

Please clarify the scope of this feature. Above mentions that a counter is
assigned to an RMID but later it is mentioned that the counter is assigned
to an event. Perhaps consistently mention that a counter is assigned to
a RMID,event pair?

> assigned. Number of assignments depend on number of monitoring counters
> available.
> 
> Provide the interface to display the number of monitoring counters
> supported.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: No changes.
> 
> v5: Changed the display name from num_cntrs to num_mbm_cntrs.
>      Updated the commit message.
>      Moved the patch after mbm_mode is introduced.
> 
> v4: Changed the counter name to num_cntrs. And few text changes.
> 
> v3: Changed the field name to mbm_assign_cntrs.
> 
> v2: Changed the field name to mbm_assignable_counters from abmc_counte
> ---
>   Documentation/arch/x86/resctrl.rst     |  3 +++
>   arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index d4ec605b200a..fe9f10766c4f 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -291,6 +291,9 @@ with the following files:
>   		as long as there are enough RMID counters available to support number
>   		of monitoring groups.
>   
> +"num_mbm_cntrs":
> +	The number of monitoring counters available for assignment.
> +
>   "max_threshold_occupancy":
>   		Read/write file provides the largest value (in
>   		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 5e8706ab6361..83329cefebf7 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1242,6 +1242,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
>   			if (WARN_ON(r->mon.num_mbm_cntrs > 64))
>   				r->mon.num_mbm_cntrs = 64;
> +
> +			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);

The arch code should not access the resctrl file flags. This should be moved to make
the MPAM support easier. With the arch code setting r->mon.mbm_cntr_assignable the
fs code can use that to set the flags. Something similar to below patch is needed:
https://lore.kernel.org/lkml/20240802172853.22529-27-james.morse@arm.com/

>   		}
>   	}
>   

Reinette

