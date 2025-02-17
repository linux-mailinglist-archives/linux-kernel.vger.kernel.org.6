Return-Path: <linux-kernel+bounces-516880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69374A37939
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A95E1886F96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D6C8CE;
	Mon, 17 Feb 2025 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+dMMSGc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A49611E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739752828; cv=fail; b=UGnH9dhqzegZZq7kbrRuUwB7S6HPUsLeaqfPnVrz05DFeu4Ob+3JBqTyQ3YbK3qpR6NYjRUI3oR9aXUy4av+EnBwXR4QUD/kiUexh6AwmPyjFboUcoNE0V2lVSMM48DqEGvo8oIWIjLPGYwgB6B0aAyrwVTDeiPNiRysHIqdUZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739752828; c=relaxed/simple;
	bh=J/qxHFU1iPGau5MnQ4rZIrjOquy5ZCoF4crjoqZY6lo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nmmFUt3qtVv72WS0QTET0jXhg6PbMPpf41dFWE7tB0OkIjS//3cJ9w0ieu8AX5FwxTo+zhawI8eHRbsrWDEKiU8LkIEP+2DFd82ZF4UrKvQ08LNHeRgLlW3Fx3yM8tpfDn4ITu7Q8ZsrkFj+T+g82/0lvgqcxxe+MuwfTjYomOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+dMMSGc; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739752826; x=1771288826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J/qxHFU1iPGau5MnQ4rZIrjOquy5ZCoF4crjoqZY6lo=;
  b=X+dMMSGccmdyUReauU5aS0C9iM8N0Q+bQwDkQ6ybCMjvPGnbaDdFNY1v
   Ae43eqxMl6FATHcwTsKVPtpTTTnOwHKACpA137HqqOtIMhKYgs2LGq9mc
   KfDKCHl5/gF8Jwh/LTjVi7cjAJpFUh/A6c8T6zq7JU/9IXauktEQy8qqM
   2JELItI/siGxrLNnPhdRgqaOsItKrY8PLI+b48YQliu+oZXXamGbEgzR7
   IGy8eGtAAhjzWXNWF7+xR4Hba5fJHW+BG3n6mGrSCeSVlYMymkye32qHv
   IBV0hV0r7aLfOG+H6EU7zj7doud/Ibwl0qde9rieUkFOUAMpunVW633Nv
   w==;
X-CSE-ConnectionGUID: 17G5OceDSS2Ia98KGbHyGA==
X-CSE-MsgGUID: jbF2j1ScR3isPPxbe9uxzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51853069"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51853069"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 16:40:26 -0800
X-CSE-ConnectionGUID: Bm9MG0U4SHq2GH2WP4yTXQ==
X-CSE-MsgGUID: SOXBHh/qT0WKn4qHGzIIvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118903112"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 16:40:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Feb 2025 16:40:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 16:40:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 16:40:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pjck6bf1iXZwHuNHi4BSlNXFMYdecbFTWtoHRYEwYvrtOEQQnbik6rtdlGMYqMUSIb6PnT4L6fLVj/YW9fq05962OJxfQPMV+Iq9cSxCQg0LYgmzsJi3ftYztAB9Sw+1MWngzS2WN/rlmPjNG0lCZAirOd/75S3uabp3pZllV8j2me3MEND4glutNfEmi5QUgwW1vcoYnv9sjY7SrHLv0xYDMfl/Z4dQHz/6+w6wVHWCcd0OCPMTDVRZs5A0BpqT69lKN1MfZc8Li8XkLUI4kVm22sWphLhSUQDGq9KS7BspZbHuE1MMgvH53OT4yy0pRCgP8Y07/Z4gasonQAZvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLzJjl2Dipi0OY5W4M47C+Ojq7CPbH8Z4X4Qseoto1I=;
 b=bLk0CW+p9NZ6IJgdZ0XN4xBoTR4jvmMvNJS4lAFbVqTK4kn5TGbht9ur7Z7ibJKeDGf+ZQRaJSIYyKXclmtQm8nIqHEHVFPQBlhoFzDLUgFlhsWCLcotWFMvcKHZiirvfVNz5A+ni206XxPry8lzZluqSgsOn6YDhmUJz1txG4iNUWirQzwLMs01wT/H9l+Ol4e0z7uBYMLphcjYD9ZO8myIwcXp62kAtY0dxauSCnDUGLd77q2CvwPEZCOnwC9L+y4mDT9RsyP7sSLoVnuPpHG5srbPaqIiEHluL43z2ElLpmBKCWL2knZ+XXSV26nlwIlklLyezeHfHCl3PIFG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV8PR11MB8581.namprd11.prod.outlook.com (2603:10b6:408:1e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 00:40:20 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 00:40:20 +0000
Message-ID: <5b6a06ac-b98e-4e15-9b19-913aec8bf4df@intel.com>
Date: Mon, 17 Feb 2025 13:40:01 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/tdx: Add tdx_mcall_rtmr_extend() interface
To: Cedric Xing <cedric.xing@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <20250212-tdx-rtmr-v1-3-9795dc49e132@intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20250212-tdx-rtmr-v1-3-9795dc49e132@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|LV8PR11MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: cece612e-2822-468d-88f9-08dd4eeba87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXVQdUJ4QlM3TzdRaVF6VUxpSVVHcUl0bktmcVE5ZUtFU1NhT1AwN1lOdTVJ?=
 =?utf-8?B?YjNueW9hNHkzdUNHazIyaEtXRXB3aEpxZ2Fwb3dteFZXNEN0dEh2aWlMcWNs?=
 =?utf-8?B?YkZmcjhKYU5rb21LaXZCRm5jZ1ZKWFpjQllzdXdYdHdyYTgrdHpVQjBndXoy?=
 =?utf-8?B?djdxaG02dFdQVDgxZm1WWjRnOGNJNUJzVG54aHlHODZjd0l1WCsyRGNpUk9m?=
 =?utf-8?B?SVlrK3hJaXo1SHlsV1J6OW8vRzRha3d1ejNScHZZU0MxQmRpMEI5YTZZQkh1?=
 =?utf-8?B?NGZSQVpsbjl0TG55MWhpTi9Lb1FSenp0bEVpLzd5M0hqRVdkWHAvRktGbjcw?=
 =?utf-8?B?QUFGYTgraWhlR29uUlBEZFVUb2ZMV1ZMTWJCS0ZlS0x2eVpYT2l2NzJDU2FL?=
 =?utf-8?B?djZyUmZqWVVIb0dEai8xbXJXTWRzUmpNdGt3b0xwbFJqTW8zaTZlNmxBUGtE?=
 =?utf-8?B?ZnVuaURHMEY3NkdsWHc4dTQzVi90T0ZuU0RqMFhZNUVDMk54SHROL1lmNUxk?=
 =?utf-8?B?eG84TUczdUt3WDY5bER1eEN2d2hZMElRZnZ0RnhWdjBVckUzc2dRaEF3T2FH?=
 =?utf-8?B?WENRekN6RXVUMkhtYllHa085djFic2xWOVhyTnNTWXVveFpxMU0xL0kvUUM3?=
 =?utf-8?B?d1RhemhWMEg0Ym5DV281WkNjMHg1b0xCRVBtUCtJMFp6b2hDeVJXck5tTzA5?=
 =?utf-8?B?VFFaWmZDeUhtb1E0TVYraU9EdU44a1Jlc21xTWFMQy9IS0QxeHFqRnBDczA4?=
 =?utf-8?B?VDlXa3E5RDFBVWNnS2MrdzBpUGliazB3MjdBd3g5NFo1RXFGSCs4L0dEZ0pG?=
 =?utf-8?B?ZzljbzlzOG41cmt2Z0hudGRvcFhoZzRuMDU4a1NTbU53Sm95RjU2aGpmV2RQ?=
 =?utf-8?B?R20zNXMwdEhKdFAvZnlScHhIOHh2MHAvdTRjQU15cXZwcDdUY3ZsMFBBSW5H?=
 =?utf-8?B?bUZHcmhjR3FxeFhXaWFmYTZRTGRzZXBva2FGL2ZHSGplUDJCRHU4YUZ5Umxo?=
 =?utf-8?B?bW9FQ3pETTFNZ1JoYndmSGdTbVJIOE4yVkVxWHBtelJWVEhtcWhRaUVTei9u?=
 =?utf-8?B?anM1dlZtMVYrMzluY0J2NG9KbjlBMGxMeE9BT25LTmh6THFPaHh5NGo0Nmlx?=
 =?utf-8?B?cUYwYndGMldNREhGRG9udVQ1Q0F4bm1vQlI2bjNrSkJ1UU5zZW14R1JmUFVS?=
 =?utf-8?B?bnJrekFRL1FERVJwY2l1RDhGN3NSa0VsSStFb1I3ck9PdU1OcDI5akdoTk5L?=
 =?utf-8?B?T0xQaHBDWkc1L3JseTlTbHJTa2pBZVhtVFgxM0luZjQ4NDVMT2VsdUc3T0k4?=
 =?utf-8?B?bDNOTzYxd1BjaFNwd1Y1a0JReEpJeWo2QU00S0VWN2tmMEtES25ncTlOb3RN?=
 =?utf-8?B?Rit3bzJzaW9iVS9RWFlsNHcyTi9nWUZEeS9zTHRiN25Xb2h0MjFicjlheXB2?=
 =?utf-8?B?a2FacEo3NXMybHNNSTI4R0FyWTc0YmJncHJ3TXJ0cTRKTDB3ZHlIYnJrMlY3?=
 =?utf-8?B?bXkxaEtzeWx0SEVmbk9BdlF6ejNYMFQrVnNtek9VREdNR3k0c1hySnV3ZGVn?=
 =?utf-8?B?R29hazBjT0hoeXNJWThMMGNVamJwTDA4SlBMNnkwNm1Cdk1NSVMzYWNqSFhT?=
 =?utf-8?B?RjlFQmFOamxKWWkxeDJmeFFZOGdMS1FsUExvd3dNQUIwY2VKQWFjWVliY2kw?=
 =?utf-8?B?WWhhL3k4WXJsY3lxaldabDN2WjNMNTdidnpoYzdoYm1wN2RVbHFxdHBIVzlu?=
 =?utf-8?B?c2lPdFlkaUJHbTZxYUMwZW45OHRVZlh6ZUtpcmFwU1g3QlNoWTdlUFFyUUhD?=
 =?utf-8?B?Y2ViK3BFSXdnbHFCdU9OejZkcGVISG91S3pxVndIRkNSbFJBbldpaHY1cjRN?=
 =?utf-8?Q?cOZdH5Jrjyal7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGw5elZJV2FNL3lZMUY5MjFGa0J3MnI0RHRXN1NGcThKM2EvZUQ4Z2N0Nm5E?=
 =?utf-8?B?Um4zclFWTE9QSy9WT2F4WnRIRFdJc3FmcFVkbzAwbWcrRDFPNlMzMmpZcjJi?=
 =?utf-8?B?QmRKSVQyQkVWU3p2N2JsTjJENTkzWlFrMTB1d0JBY0FJdTlsRGRhSGs4cVVJ?=
 =?utf-8?B?L0lYRVV1TkY3aXQ3aTBhcHBHMzZ5ZGx3cFM4RjAzZjIxVVhPcmZZUUdFUjBO?=
 =?utf-8?B?bVcxWTJzc0dpaGU4dVZPVktLMVNZQy9PTEJlUE1MMU1hbWtsRXVTYko1MDdl?=
 =?utf-8?B?M1plaGRkQ3p0UFIrRWRTbGo4WThCZU9aYzhDUXpzM0h0ZStPN29yS09mR1NS?=
 =?utf-8?B?NCtFTWZFMGE3ZldIZWFHUEFxZVlndzdPQlJ0VjhxTkpuZFkzbndKRHJkWkEr?=
 =?utf-8?B?ZHNPNmM2RXVLNWVsZmplN2hhbFVUTVBKMUhiZGxHcTkvVTBoZFJDemRCRXlR?=
 =?utf-8?B?clhac0Y3Vk9ORzJHMkY5T1g2V3dDTzZpZ2gyWGhURmQ0MCtpQS9hRTFJbnFB?=
 =?utf-8?B?OThxNmt0Tmh3UGowTmVQK2x2cEVtUGNmTVVhdXhTNUFKRmNsdkFodWFETko3?=
 =?utf-8?B?dWFPeUtUaEFsTXRWL21XSExMTENVajJnSGYwSUlHV3VVdDJoTzZ3L1hHSmFE?=
 =?utf-8?B?a1pqc1hJM3k2QndVa3JmbW1HdnpvaDRWUVhCUG4wRDJEWGEvMXV1aVlJKzAw?=
 =?utf-8?B?TWVNRXkxdmNUTndOUWdOaFY1ZCtFSlk5cWNHenZJQnRWYWY5QzZqZHQyYWNr?=
 =?utf-8?B?b3hiUGd2TGNmVFVBWTMvNEdPUmJTbnppbnBmYXFaQVFSZENLNGlVZ1U0bk5V?=
 =?utf-8?B?L1JVdHIxaHl2ZWpqbnlSaHpvd3dSK0NjV08xV0k2aE1qTkZXWVpBcUlMTGN6?=
 =?utf-8?B?RUtGQ2htTUdqY1c0dEZSTkdrcEIwZ2lyT0lML0cvZ0JNQk9ISUM4c3ZiNEtG?=
 =?utf-8?B?OWEwcW5PZGJWNnRYNWtOTUhTT1phOWZ3Yi96Y2FDWjI2ZEl0cFJFb3pteG1h?=
 =?utf-8?B?bDRLeUZnVktXRGtrZ0FuWEtCOXhDV0dNWmhJNjlWbks0L0JFM2Jtcm1RVThJ?=
 =?utf-8?B?WUNuSExQNCs5TGJyOE8xbXd6N0dybHhsTnBJb1hxM3F5ckRqaUN3TVd0cERQ?=
 =?utf-8?B?MTNwOC9TTU1ieGw0VEF4Z3FEUnA3RkZGN3llYTQ1NlpRQ21KTDZwMWdnYnVp?=
 =?utf-8?B?dEJGbGRnQjhNRmQvQnNDQTRVckpRZmQ3bjB1MmI4VjJQYjFpS0xvR0pjSGZI?=
 =?utf-8?B?RmpycWhaUEdZMEIwb0lNZ1dwSk95OEkyRmZWRjRiUHNXaG9hV2NRaFhSbDA2?=
 =?utf-8?B?dHRidG9FL0d6QmxBL00vZXVWV1dxTS9iVmFRbGhsd1FvemJEczl4U09ZclA5?=
 =?utf-8?B?aG1mTEZyajV0SzZsVUROWHhETGdPdTNrR3NUUE5XSTVma1E4N3BvbGs4ZThU?=
 =?utf-8?B?NWhOazM1YThzR1NBZ3NKMzMzYmNkLzFFVkNRbkwxWGFYb0VPaXo1bFgrM0Jn?=
 =?utf-8?B?QWFPd0Rqd2FwQWdBbVo2eTBiRnVjeVpUemxDOU50UlBjUFl5emh6K290MHJZ?=
 =?utf-8?B?Rmw5ZUwyWVRDODJGam1NeFBRaytlYSt0MFdBczNLRDVDYjZ4UDN0a2w0MDBK?=
 =?utf-8?B?VHNpYXNtV1hJU0E4RXQxRlNuQ3BNUFhaY0s0bXlURE1WWFZ5UVF2ekp6WnNq?=
 =?utf-8?B?VllIODFGcWc4bzBoeXFVcWF1NGFJb0lqU1ZmQ2JJN3M2VE9lZ3hsK2VzOHY4?=
 =?utf-8?B?em40SXdSNGFWWXRBUEcyNnJITDFrS2VMUnFPU25rcDVVUFJ6cTV0d04zVTlC?=
 =?utf-8?B?TjBWbVlibHZYQVFmM1Z1UXRDUkp4R0xraWoxRGJOVDlGZ2xqRW1EZU9LMWEz?=
 =?utf-8?B?dTd1S3NJSUJFRVZhVTJYZFhGdkY5cUlZQWRHYWlhUTVCSEdrV0tWQWYxNTUv?=
 =?utf-8?B?M09BT29vV2ROaXdzcGJBZDBpYnBib2xMbUlHbXVPQklkSDZ3bDhabkN2SWxG?=
 =?utf-8?B?OWdqMUVhQXlsbnE3NGh3UUtyMkUzTlBCaTBCdnQya2VYVFZuS01kRVhFbk5H?=
 =?utf-8?B?elFMaGxNWERuVHJwTHhjM2k1cDN1QWFrcXo3bjlIOUdiN2g0Z2o0cWc3TUlB?=
 =?utf-8?Q?zMBbm5Aiq7ldNYtjKMpoylFOu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cece612e-2822-468d-88f9-08dd4eeba87f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 00:40:20.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2f6y7yLqTBdpLf4v2fvZcpCiLplQjo3YQKiqmJ/R9AolRsc1PeF+Zjttzc4NHiHs7a7n73/7JL65drdUs/viA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8581
X-OriginatorOrg: intel.com


> @@ -135,6 +136,41 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
>   }
>   EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
>   
> +/**
> + * tdx_mcall_rtmr_extend() - Wrapper to extend RTMR registers using
> + *			     TDG.MR.RTMR.EXTEND TDCALL.

Nit:  I would prefer to name it as tdx_mcall_extend_rtmr() since this 
matches the existing tdx_mcall_get_report0() (and tdx_hcall_get_quote()) 
better.  But no strong opinion.


