Return-Path: <linux-kernel+bounces-522768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7DA3CE57
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A618117552C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EBD156C69;
	Thu, 20 Feb 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANBZLlqn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA15155336
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013195; cv=fail; b=Fz+SAPCFzKT97Thf+FLDBoslqOUFgF1JOzVSofrxnB+CbmBGiMRATJ+158CuECMRdbBF081hvGVT/S4CXEUSSDnOyCDShQD1Sj7lf9My52qHrRs9+skCtg75X86lcaX2Vp5kuGkjhBOejczsMFdnSZjc6Eqe5aWIb9FLKfcxm4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013195; c=relaxed/simple;
	bh=EUrboRQ/yT58tbZlNaLA9qtGlA2TbWkrTGIIZ1m2O5s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nGS6mS6MW3bt0NeQOWhcvFwGZimP8j9eSHLIf9yr1ogPx0l0BDnaLS86+P3znwsYL8/nEl+2SjgKxmJiPRPY/0QMJp6TYmsGO1HWU/y1cVslJZ585Ajz9Zqs36QEi11+FCznLbBBAuMp2XUTIhSCtNRkAkjrS9NkszJ+xlU3w+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANBZLlqn; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740013194; x=1771549194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EUrboRQ/yT58tbZlNaLA9qtGlA2TbWkrTGIIZ1m2O5s=;
  b=ANBZLlqn5gku6JWNR/wHC9YldRM2t4+bJWR4svTbU7rBBi0KX3D28Y4u
   hOxpzok0fRvSilx8UidFoOq7MW+XqKXIbXwzlCoe9Xc7eY4XkjZDP7AL8
   CMKNS8hm/k7W7ddGu/+/Vm85Xed4RFbEHaa63uceUf8GMqP2tICcq4RaM
   na1yyS9QJHI/U2DG6YxDC2FDw4muBxiaZAAJ+pvv3g8rB6XWIHhi1/N8C
   ko0hvlo9sdKxKz3x+zkTZEB85oULeb6e1cUVzNhRWeml/vBzulC3ugxxH
   yhHhZ67LoPf9xDiUPxuIbuWsQ1GJGx1i/2e4E1V+yYsKLgrB7Y5YejLJB
   g==;
X-CSE-ConnectionGUID: S5tAr5PsQWqo/ysq5ZCm9w==
X-CSE-MsgGUID: EMXxZ3rHT/CvtcQic6UijQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40631454"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40631454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:59:53 -0800
X-CSE-ConnectionGUID: d/6fCIG3Qmu5KvTNupnzoQ==
X-CSE-MsgGUID: q8VwUWu6R+2xe4Bs5lJ9kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118984002"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 16:59:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 16:59:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 16:59:51 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 16:59:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os13dCM6KWjIFpMV70sAdVvpWzmW6lcN11VYDO1bfKZ576knglLyzz+WQsqWZCmXajGvoM2pFruJi1yPiFH9/CwSwJEQqcHL2JpzOvmAZhKHrUIr/W7M+W9+uIrmV0ONhkVoRbJR0GxzE3L1aKbgPLBUNm3daMaFvfeLXHzNQuvcjpuvMsdjJe0LYDqqmWRn6ZfRHFupNI3lLsNdV/vibSYOd+6t09+nOsnlMWhqg4kuOU7SFQtTwt2uzGDdkLlzrFieP9n2/aKhRsVStq1czR7/qsBwTYOOd0X1QyNXySEMHVQ7cXmXdMru6td5p9JsZ5OOFPkNEN7PkaP6yoLANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/akt64e6cRcWMCbwJnHY6Sf39jsuRIsKHUaIV+Z2Lzs=;
 b=Af8Y1mH4J2Vcgt191J3kA7K+eFbz72I494qx+4A7eupSqEFmihfHN6ydiwBVxkv8+FBmmqXRUxUMxR+gsZHkfBnj6BXvxM8THJfGqEOfDgmuEGOHr4Um8MRfmeRtxOawSsSJgGcx6dtZ8+QtUSZh88JMH1XjUCw1nD1XDYviVYYKVPlcKk/cvnFRimOlz+0hrnbt0/RLub/GYEPIqIUpAC2q83Ys5oJSDUHAFp/OCav5mzDH912pMjld9anBnAbqWnjpeYvJ3p0Uk3q6nO2UALxmkjAC5bmLiUn6ImeP4BNDpf20eWLqqpoN18uaEaNtWNEIdEzYeh0IGVXbmSNFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 00:59:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:59:32 +0000
Message-ID: <cb8449cb-e43b-48ed-a0f2-9d399de4c1fa@intel.com>
Date: Wed, 19 Feb 2025 16:59:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/42] x86/resctrl: Make prefetch_disable_bits belong
 to the arch code
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
 <20250207181823.6378-26-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-26-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 170f1f62-b79b-4143-1cd5-08dd5149d633
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWdtalNWS0pUZ05SbjZwc3ZBWGYzR05vaC81Wkh0b1dpVjJBd1FUZlNrOVdD?=
 =?utf-8?B?OGJ4NDVYWmc5QUMzRkNkTWZ0V3Z2eklCMUxnbW5nMTBjOGpNSDloM0k1Zlc0?=
 =?utf-8?B?M25uZ0Y5VUZNWHZJcGZjYWlWdW1neVJHamZkekRVdVFzZEw3c08wV0F2cDM4?=
 =?utf-8?B?RkdzNDcycnM2RGR6L2ZlN2piRng3U1Rrb0s4bWhCR0Y2bkthSTNIRDMvOEVT?=
 =?utf-8?B?WExTeXBDYXJlaGtiQlRCNHFHejVkSE4zSGQ4ZHpmL3NNb0cyUGJMUnhzdzFs?=
 =?utf-8?B?NHVVUWFoanhHSmwvVWR4SEozUkhCdjhWMS9ISzcxaGhyVHhSa3NjenNHamdY?=
 =?utf-8?B?SlBxSUJqZnhOY0V6VHZ0WHdYVlMxTWxNS1I1WUpERXJWMkQyM3hJQlUvdity?=
 =?utf-8?B?RUxsZFVHN2tyaHRsWVRpVGhubTNCU0VkUnNieEdBSGMxM0QwSTArbndhUSt4?=
 =?utf-8?B?bEtyZ3RnSFBaQml4YzB3bkk1VFRJQTZNbkpJRWVNVk5YOUNUd3BtQzBqUUNp?=
 =?utf-8?B?UFE3K2tFTjd5N21vdU5JMTJFTmJUQ0hwaGNGR0s0d1VaSGgyZDFCSlA3QWtm?=
 =?utf-8?B?WGY3R2xPSkcvc0FEaGhkN0RET2kvaTNweWVuMG5ZYkFrRVkxZGVnSFZoTjVH?=
 =?utf-8?B?V1FZdEVoRW5jUEVxSDhKUVNyc3BwNjlWNEdsL3c3UGdPZzVuZFRRSFg4TUN3?=
 =?utf-8?B?b2szMmFIdUJlWXFyT3ZnWUx6Sms4NkVlRDFoQ0w4SGQvOC9vUXdmOWswMlg4?=
 =?utf-8?B?alh1OEl4VVkrMGhmY3dCZGF5bWNrcUJIODh0cGZwZWJCWkswajgyVkU2NGZN?=
 =?utf-8?B?alQxYm9JLzgzdnp4WjRqQ3VqZ1JLK1k0eGhwRnUwZmNnM0k3UFhBUFFxdU5W?=
 =?utf-8?B?R0dyWS9rbWlyUWJSVGhSRFdyMmVnYjJqTWs2YUtJUktNbEN2RnJMeVVacmU1?=
 =?utf-8?B?TVhoZm9VTitHc1BhYmFWK2tueVZQalljN3ZncllJV29kajdSWG5XNVFWUnpm?=
 =?utf-8?B?QTVFODJ0ei9jWmJjN3BsSERYL3VROEoraTdFcThwN0lsQlM5ek5DaWg4dU5K?=
 =?utf-8?B?TDd2Um1ITFVKWm4rWUdwNzhJbksvNTJlcWhPSG00dmZ4Y3pIY2JYTXNpT0x4?=
 =?utf-8?B?MVYyczJVZWhJRmZJc250N1h5ZGNCVUR1c2lEcFVIVTYyTi80cTY2OFRpc2k2?=
 =?utf-8?B?Z2x4UGp0MmVrOUhSanNjOC9CcXg2cmU5b29QdWFBMHc1QWdVeWplc1RSOUhN?=
 =?utf-8?B?akVndGJDRW5PclQweTdMZDhQTUcvNkgweUJ4MytyQnZHMHE0OW5haFNscWtt?=
 =?utf-8?B?a2VDNC81eEJ5TFlRZTNXV2tVSFFkMG5SRkhEdUN5bEFlMmkzM2MrUkVCQ1pC?=
 =?utf-8?B?ZTlVMkt5QXJpTzY4WTROWlB4Y1NrZFVYQWVCMTBiWTd6VUdCQlF3Z1pBeVBv?=
 =?utf-8?B?N1JhSTdYcjBqQk5oYVNGWUR2YmJ3dlAzYzh3UkQwb0hGWmFwVW1uK09xZHZB?=
 =?utf-8?B?cHJTVmZuL0VZajRwSEJLVm0zdW5kYmdWL1VWYzVuWFRtVGZEWnVNOGwzTCtI?=
 =?utf-8?B?VXdQSkNRbHFuODlhamxUN3pEQmFZaDRSQ1hBR3prbUlTa1lxcFI1VEltUnd3?=
 =?utf-8?B?MVpucHNJWXN1cHpJdWtBNUR2WXBXUTErM1NIZUtSeno5STlsa0R2V1RlMTNt?=
 =?utf-8?B?T1RBYVJhRWtoanUwRlNkem0vLzVBSno5SVY5Uk96MndHYTdUYUZGcXRzSGk2?=
 =?utf-8?B?c0NMMldpYklQcmdja0hYK3FneVNMZDVZUXhrRGpZeWhHbmVjcDBncW5ONWYy?=
 =?utf-8?B?ZHJMRC9MR21RZFVaRkRUTUw3VkZwUmxCQVVUei9YWE4wWVFIcmJRYU5XQzVH?=
 =?utf-8?Q?9HLe8IUbFjfGF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3owYWlaR1Y1UnpRM1BYVkNtdjkrd3l4SGRkU3lKV21MS29PUVBpVXN0QmZq?=
 =?utf-8?B?S0FpRk84eXdYOUc2WG1PSFVxSTdEVXFPYy8rWDUwdm1qbHRJM1hHN01veGhu?=
 =?utf-8?B?M2lVTlFVcGNKUTVmdEFyMlZFTVVVSWRhTGNSckNUWUplcG9hRnZhWXluMm1P?=
 =?utf-8?B?NVQzQlJDVmZGNFF4WmpnQitTaGRIbHROMXJ5R3ZtdzB2ZG1sTXJtajdCbVN4?=
 =?utf-8?B?U0NhRHdvM1BaL0tiTUh2N2JQbnhWYWptS2JkWjR0R1FBcXJFTjQ4Yjd3aEZt?=
 =?utf-8?B?RnhHU1hFWHcxYWRBbEJhbFVweTE4cEE1OXd5azIwNm05QzV5STgxbUJmWUdq?=
 =?utf-8?B?UHlNRjZyanNMWnc3ME5uUlcrdkJPZzJ3OXVBaDBEZjUrVTFubVZxNzJZNDB0?=
 =?utf-8?B?NFI0QXhKVkpmSkdzN3dJRzd2UVQveGxlNlZDWnZmak9JSGIzWG5YOWNZV3Zw?=
 =?utf-8?B?dEtaKzZ0VEZCNWpoQVlaVzZ4a1FHaWJwemNQaHBLeDFVSlBZZnBFdGhLNnBI?=
 =?utf-8?B?NC8zWFNJVW1FeWkvdUx5UWNJT3Z3S1NTRk45SmJBOGF1Vkd1dXVRS3EreExz?=
 =?utf-8?B?MHNHS1M1NVFlWThBdmF5Q0o5ZjA1bStobE9aemlRQnJrLzczazJSYnpuMkln?=
 =?utf-8?B?a1lvY0NwT25lS21kNjZiSFBzdE0vNVdFd1hpRkVKVDViV0FJU3JrWkpGczYy?=
 =?utf-8?B?RDNSaDIvYTV1dEFoWGcvNXhzeG4xa1I2TTJOWGxDVnR1alAwTnlPUjdLT1Z2?=
 =?utf-8?B?dWx2T2NNNlJScUdZb3ptY202MjZ0VWpjRUlFMHJBUS9Rd09LaUZzdDZGaFdP?=
 =?utf-8?B?SFNTRDVMOEVya3cxYU1RUG1Ub0w4SExQbXliVVhwL2V0ejEzaUNqRU1IZWhE?=
 =?utf-8?B?eFNoY1N1OTYxcjhJTElYU3BRekVTRnNZMmRYQWh0WHg4cWZ0cFN1K3ZiSDFv?=
 =?utf-8?B?QXZkdi8zOEdWSk1rQmtXNjBwZk1XcjJkeHUzRkVkQm1oUUpqZ0Q2eFdLZklU?=
 =?utf-8?B?a0hDZUpBbVlYZnU2RjRleStkMnhJaWFKUHpUZEdXVGZEd2VzMXF3N2RtV0gv?=
 =?utf-8?B?SUw2a25aczVSRHBOS1RwRE5VVWVRamxuTTRGZzlTLy9tSm5kTzRFaEhBYXUr?=
 =?utf-8?B?WkZVZ1FMb3VTZ1EvSUg0VWt1TkxIM1M1TDQwSU00Ky9JUW9KYzRyOWR0Y0lh?=
 =?utf-8?B?c3AwVzhoNFlWZHFoOEVLSks3Q2ZwVFoyRzR4VGxvVXMvby9lNWRuNUwyYzkw?=
 =?utf-8?B?Y281azhvZ1M5VUhYSFRpaVBDV3BsSWdyY0VmZDRmejZML1oyeEIwSFpHNlNK?=
 =?utf-8?B?bjloTFUxSG5TcWQrdUFzNHZVYWkvZU1TTHJXNFZ4alpuY2Zob01JN0hZZlNp?=
 =?utf-8?B?UEpMWXQrbUFISmFNbml0YXB0S2h2YWttQUZBU2JHUitGbW5JdEQvUURscnQv?=
 =?utf-8?B?WXFWWFB6S2lxdVYzTjRtYmdtdkc3ZmJxTUwzeUFXMkZNWCtEeUdVaGd3T2Ur?=
 =?utf-8?B?LzIxbDVkcFY2V2I2MUdhRWVWK0FycCtXZm1xcVg3MUVCNVBMNFpkU0k5dTRD?=
 =?utf-8?B?aUdINmVoc0plRlloYTN2OFcvQlBCbVM0RlBJTE1jbWhoQW5kSUFaOFM0clor?=
 =?utf-8?B?SnlZZlVmTjdkeGd3cmRwSTNlVTNtRk1kQzNEZElJeUQ1UE5uangvK1AzUDBT?=
 =?utf-8?B?M1hqeC9mUWFTRWd6R1Z3czJ6Tmh5K2lEZTduT2VRTnpna1BUR1RSc3VKTlJq?=
 =?utf-8?B?Zk42QUw4QzNFallmZGxLdlpjT0h1UktwcXZBbWxMQy9NS2sxUHJrZ1V4Y3Np?=
 =?utf-8?B?MjJOSTUrdU9BaW1sdlFwZWFKdXFuYUV0K08wRFJNZlRGR003SUlXQjByaTVG?=
 =?utf-8?B?cnFtZG5OR1I5SmtBdnZqdy9CTWFWYm1NT0owcXZZUnRiakE0eEdoV25iZ3NY?=
 =?utf-8?B?VjZlVGxZUXIyY0txb0gwdWd4UnNrRnpVSHNSL2tscFd2dXlYNUpYd0xtQ2Jv?=
 =?utf-8?B?bGVsSkkzakFTWC8xM2VlZUEveFhCMkJYUWdOdFRiaVhFMks2eGZKZ0ZZV25w?=
 =?utf-8?B?TmJGN2FsZVcvNFJQeEY1MFY4c1Q3d1JvZEovRjVwZVhwOTdRcDNxMzVadTN4?=
 =?utf-8?B?cXhvdVM0Q01xUW9HRXVJZVkwMUg3MldCVmpUSUJSbS9IcmZwQmxlMFYzcEVS?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 170f1f62-b79b-4143-1cd5-08dd5149d633
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:59:32.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5FLtWmiZLHSwBmfySxBL5gR/wyc51lMPA1gpUpK87s2Xj6O+Bpf2lhnuUBQZZZs+XkOIzKfFApqkOK/WaZ4S0crWL2sK2XDVeml0uaPgYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> prefetch_disable_bits is set by rdtgroup_locksetup_enter() from a
> value provided by the architecture, but is largely read by other
> architecture helpers.
> 
> Make resctrl_arch_get_prefetch_disable_bits() set prefetch_disable_bits
> so that it can be isolated to arch-code from where the other arch-code
> helpers can use its cached-value.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


