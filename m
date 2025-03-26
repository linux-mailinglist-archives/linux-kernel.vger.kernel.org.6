Return-Path: <linux-kernel+bounces-577552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA413A71E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81107A650D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB41253349;
	Wed, 26 Mar 2025 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvLxwl6/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405ED24EA9A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014657; cv=fail; b=edjCd1gzpFMs8MwxszPeU5KxbH8HK8RMg0zyXA6YdkU8zQIeTLeM4TTdl6bOguNh0+duf2lIZw+7OmpL14LMsVGN5SKFrLiRlFa494k6ZG3a2M1EbKs5qdHqeVup7YL98MTUEaX7MhbvhmQkN7Vj6qkE8RqyHIO7ecRHw6g0Kiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014657; c=relaxed/simple;
	bh=hQ7BC4ZjhYaVzQ9Ny/FbZFNqybjn2Skj/DgmPBBZcJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TKb1dlxwwusYZBycndOAd5BANLHwZjqJ518m3RttJ/YSI8yVB/cF7SAsktyegTjXSI4Gw7Nb4VnB3hk621XQjupeZ5nooBIJjCVSv+omyaVrwwmjfDK4xKjjMJOlNT8A22iXoBjNr3ZnjtFjCzO0CzdT2ObFalI6Iwfk3pNQOm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvLxwl6/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743014656; x=1774550656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hQ7BC4ZjhYaVzQ9Ny/FbZFNqybjn2Skj/DgmPBBZcJg=;
  b=cvLxwl6/0M4KRWFAqxwvrXDsZWUdZoSqLhLC0ODufkMblobWu2GRXGsj
   VRWU+FHZHoZ6kYQHIiz6fg8nCBPwdQ3BL1h3frtbdFFEpWprVGSOJAxlG
   OZZx70IXTEyAM0Ls3won2F/4FKhkFhWv1GllBOEtRRHGX9E6hZXP1UZj+
   lJ2+3qCblq9U0ve4p4von8ViOGWgHIzO5x2Z3IKobZOgcX7HqXIg5lBKI
   E/pShvumeMrG3i+aB8k4Hh8y8NQKQWtKGBHEEmbVm2z2wFKOcuq0gTo4F
   6gFpr11ArlodTT5RvUCPLJoRv/Dx71Jh1xs+ueFXk+nXwDUHSmJRKZ8Nl
   w==;
X-CSE-ConnectionGUID: NQ8YUvGlR/mu0W76obuQRQ==
X-CSE-MsgGUID: CysfwWEORDmA3eolybAPeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54525575"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="54525575"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 11:44:13 -0700
X-CSE-ConnectionGUID: NfatFckWRZKPx/qlNvzVdg==
X-CSE-MsgGUID: 8fwxdyrxSkK0dHAw8ew7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124888141"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 11:44:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Mar 2025 11:44:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 11:44:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 11:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvrBNse9nTTXX/tAwYhxmRgvgJTnGykxeXEbh5vBvB6wQojbTRJAX9sI6PtKslnXAs/yRW9eom6aoWiO1eaHkyL0j0q+tVNMJIcV3diSH5Jr99rPOzKpqvRo3tv+v2khoG6kODuWTH5h0kDMIPTT8+2Ur4vzzgv9raX+r6w44VhQylE95gY4haqyYW+KuO1DNABmcYqmltvrJk7n46UBJKDBajd8mbctOM9IOkLRBOTau9Vvo5eUFSHgm3NnYcvHkqC2lMmD6nVf40m4WyvQOGIJv6ve5qu4ntAkmSbCAHDDrzpCw9iYFTGCUkGbXDhIm9QQlEpVthic4wd2nspUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHWSgWxcWwbse4W9UiZuGNLSuc0bIHCzAUGXz/r01v0=;
 b=nCEtSWImnD5xw3Un41mnmGIIRQwFCbV95i9XlLyVl+OVU9sIeoZhRPfmph0CavV/6ZjBAT9O8PZeRi5n2IKHcxUM+u8ABurerksc8OmC5AU6/TjB8xYYpXAhFGvtUpYKrWHUihnak/ZtBJWaqKoFDILSkpgng03mLdreZCObWEuQmfQPtVLkJod3P36CkhOfrWbW81B1vudiGLVf6qxKv99eFACNS0j2E5OzV8gLOuq9Lg7HYCx+vPKxY0x30FlWIXokdhgN47Y1qGFcX4ioSE57FURnAybv7vTaDeb1o8lagf915yAdvzKZ3Lz2vcEt+Gs46z6AZEWo0arPDenQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.43; Wed, 26 Mar 2025 18:44:00 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:44:00 +0000
Message-ID: <97d77c5f-eb99-4c82-9b58-9783060c2810@intel.com>
Date: Wed, 26 Mar 2025 11:43:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2a 3/6] x86/microcode/intel: Establish staging control
 logic
To: Chao Gao <chao.gao@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<colinmitchell@google.com>
References: <20250320234104.8288-4-chang.seok.bae@intel.com>
 <20250321211853.13909-1-chang.seok.bae@intel.com>
 <Z+OuPbNGC6mOCHZ1@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <Z+OuPbNGC6mOCHZ1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8008bd-28cf-4acf-ea07-08dd6c962c42
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjc3NkFiYXVVamJ5K3Nmd3RpUDVjbDIvUmdTekRZem9lZ2lMamVxV2NYWS9F?=
 =?utf-8?B?aHJtYzNlWjB2aVZhWUlnUmJTSjVjaXBsc1VBZks0aEQyRGN0Qmg2WlN4Smpy?=
 =?utf-8?B?eDVQRVRHNHp5N3RwdVI4OGtqZkVUVkdrcVVKcGJLMkVTeHMrNXRXZzlJWktm?=
 =?utf-8?B?VGxad2JLdUNaTWRzUURaUjlqY2Qya3RHdjZ2YVNJUmhtck5HVmRWeW9Kb09k?=
 =?utf-8?B?SDFwVmJrTG01R3JGdmIwN3FzZHVQc2VKditCV3VSY1NKVi90dFpJSHhOMTQ1?=
 =?utf-8?B?WEp1L0ZzWEhsVTRtWDZnZnU4WGJSalBhZjN1Z1NQckh1djNJMW5UWDZiWTBP?=
 =?utf-8?B?YlB6d243S2c4QmszOCs3R2JaM202bk9ZWVVVUTZoM0phaUp2SHFvTW40Lzd4?=
 =?utf-8?B?MnhwelA4M2FDQlhaNVRPMUhmYTBXQXBid2lZTklvZ3JmR2g3TlNBZ1N3ZjJ2?=
 =?utf-8?B?eG9iblFabTFtZVBhT08yNzJ3NitMb2psQjlGZmI1VFh6akJvTUNYemhqRUxq?=
 =?utf-8?B?Z25BdndzQStQSTQrM2VEckFUdzRzN3VMdWpLTXNJWlNCTG1ZZ2Q2UXJmSGJx?=
 =?utf-8?B?RDlZR0UwOGI4aGZnRnZrTmdsMTBpVFUxdTRFNzlDaThVZVlEMDhqMWNQYnJC?=
 =?utf-8?B?Vkx6eFpBNnJqYjBSSlVOWkQ0dGRIeFR1NGxLcGxneG1ETDZIV0t2MnRNQm5k?=
 =?utf-8?B?N1E3M2EzVWVzM3JIQk9UZ3BFVmRlN3ExRkY2Um9HWXBiOHFKNEtJWkROOUw2?=
 =?utf-8?B?NkhFMi83dUNZcVI4U1E3VUYwZ2o0VzhlK1RabmhVY2d2V3JQN1pvRTNGTUc5?=
 =?utf-8?B?eEtOVTJhNStKcUdaY2lzN1JFWU9vU1lPY0Y2TWFBRTlCY1pkTStSQVlCdTdG?=
 =?utf-8?B?blBTSE90S0JCNUp6UjlmZVVFVWplZWljODZQUDNCMklrWmkxMUcwTUFJSUVR?=
 =?utf-8?B?ak93N3NHWGdPQUk4MGhUdjZrSmRTd0duSmtENjNseGI0RTdWMnRUZ0d2TTBn?=
 =?utf-8?B?cUZIUTVjNTBzdnRPUUhyQWg1T3gwODZxT1NwVE40ME44d3RRYXJ0K3d6bGUz?=
 =?utf-8?B?TUt6KzNkNkRIY24za2NUU3BOZFRqRHcwa0MyVjg4UDgvejhhQVE4NEJSd29N?=
 =?utf-8?B?UW5qcUxwRDRUcTN4UWkwMEhudlpzSmJFaExwcXJId00vay9DUG5EWjBwMDVE?=
 =?utf-8?B?NmFhR0RMUWh2bGFkWUpmNWdDay9WWXh0V1NGeG14UjZwejYxNWRjYkF4bjNN?=
 =?utf-8?B?eXp5RXlEU2VWMmlFM1oyWmVyOUJqY3d2Z2dpTUdVZ2srL2lSd3owaFMrZDNl?=
 =?utf-8?B?cnJlWXN4bHc1L2VLZjFZRGtnR04vL2Rzd1czMEwyMWo2OVFkVmhiaUtoY012?=
 =?utf-8?B?NjI4ZEJRV2pGbGhPN0xoUEZwcjQ4NUlQSWxOTTJvU1pWcWF4dlNtUW9lVldy?=
 =?utf-8?B?bVRnbE9HOEo3UVVXWllIT0JIcWRpZW1tRGJHL1pTR3FEZ1hUempZdjZwYUM2?=
 =?utf-8?B?OHV1SlJKWjdNRHZlWTFhdTJaTU1kL0NvYWxUakhnVUt3RHhacWVZT292MXJE?=
 =?utf-8?B?R29wQmhHdGdXOTQvRTlZUmYwVGl5cFlTU0R4L2M3VFBvRGlxbytORGY4Z2JE?=
 =?utf-8?B?cUF5RFVzYVlTc3pKWURWTHFZWGpPUDV5bFB1RG5mRDk0U0dDSTlURFFDQWFG?=
 =?utf-8?B?NXErNEdmaitXUWkzemZQRW9EZU5xd0hYVlVqUStPQjk0dzhESG5oM25kRnlM?=
 =?utf-8?B?RlpWUjJzQ0lIcWhYVlQxYkVDOHByRTQ0dlVNQTVTbWZUa3JydEFNSGlMSFNi?=
 =?utf-8?B?cG5nN3V3T3N0eGRsQ0tMY3hZektjdGk0R2c4aFUwOEJYVmF2eHhZaHBtdmlJ?=
 =?utf-8?Q?2YVENrbQWzUMt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckx1VSs4RUp3dXg2TXhsRjNRYU5PbUVEZzNONWs0VmhNaDJzcjZzaERMTTZy?=
 =?utf-8?B?VmNZOWRQSkh4L2R5Mk5JSTJKNjZjYitoWnNEOG0wUWdRMFNidTRJQWQxa1Qy?=
 =?utf-8?B?ZzhEOVJESkZoWlhNRU9IQ2J3VEFBQnFNai9WNFNVNHNuTG1qeVN1M2xtblo1?=
 =?utf-8?B?di83bnNoanBtellHbkx4cHU0c2V0K2VFZHh3OCtKQkVoM1Y5YkhPZ1Zxaldo?=
 =?utf-8?B?clFQRTBZV2psdVVOQmlBSVRyaTdtdTI2MEs0Yi9qZWlkTHlPUnE5aVlmaGgx?=
 =?utf-8?B?YWtnand5SUtvY0FKc0ZGSytINVdabjJrMWRYM21XVnRYTFd2QitlekZPUDNL?=
 =?utf-8?B?Y0JmWHFROXVQMm1GNHB3bkZ1Sk54ZUhrZXhxa3V1N2k2QUtYQ3VjZWtpZnlT?=
 =?utf-8?B?VzJKbkJqdlVubVNqM2RGTyt2aGZMaFNPVWhDVVYxTmhrSGRrcHhjS3BncTY5?=
 =?utf-8?B?VUExbjlVWGlpbUg4eDVIcFNZZi8zWnpNbDRYYnZNeStmQnFsU2FvNzdQc2Qx?=
 =?utf-8?B?SXQzYStIM3dxZjJieTlSUGRyZ2prUk1LTVFJdnpndVp3ZUNhSVBQdXVSVXVQ?=
 =?utf-8?B?dU5vdXFIQnh1TFFkdHZ1clNrUU14amZHMFZlbDZpdmw0N0hxblYyMlArOWtJ?=
 =?utf-8?B?bXlJd0xGcHBEYXo5YVF3blhkb05NOU5JUHNtOExYNk5JTGUwclB6QjFTWFB2?=
 =?utf-8?B?d0lsTVRQOUpEMUJtUW8rVGlzaURRMDkxbFVSdE5UYStBRXphRjFKQWNqUzZG?=
 =?utf-8?B?MnI3cUVxSHJ1RkhRd3BmamNuTkZCZEtQZXMzbWFVd1NMVy9yc0VqbTlZNE55?=
 =?utf-8?B?azE5VUIrUDVTRlVhQUc1b2NyZWkrZmpOWEhaSDl4OGZHUGZyczU0cTZQWTlT?=
 =?utf-8?B?bWhzTkNBWUs1d1YxWkhRRFdWSkVLUXl6clI5L1E1UktYNmU3c3doSUlISUNW?=
 =?utf-8?B?SEtHRDA5ZHpKMjBqemtCcWtZaXkyVC9rWk52WVpTa1ZxUXhtUklLckE4a2xF?=
 =?utf-8?B?NkczNCtvallTVGQ4bUJnWm4vQ3pGellKdmVVU21TcHBmTzk2V0E4eFdHSlBO?=
 =?utf-8?B?QlBDRXErMERqbElQb2ZJQ1ViQzJzMFBjQitZRTF4NHF3WDJGbnR2dnQ4V1FH?=
 =?utf-8?B?d0Vhc0RXMUhyRkl5K0FDYXF4RHNnU3VmZEl5NGh3aDBFdlRoT3dOWUt3Nm9Z?=
 =?utf-8?B?SWhycmRWNlB0bHIxd2dmK0xYaXdBYU5BSXd3aG9CQlRMMEZ0dzZBZko1R05I?=
 =?utf-8?B?b0ZWanJNY0Q3QTREODJva01oUkcwZ0ZrN1RaOGczVG42MnR1ODBEdHpDSDZY?=
 =?utf-8?B?Z1lrc0xBMFdEWTdJRHZlREkrbVBjYzZjVktvOGJQNXB0eTdqSFIxU2k5L3J1?=
 =?utf-8?B?aHpOVEFZZTZGcHNiL1hjUjNvTHh2YmJDdmtmTUtXdzBvRXgwZXFiMXUrSDV3?=
 =?utf-8?B?UXl6cnRpbnpQMVd2ZG81REdhT2FMdHRoNlVlaHkvbTljTzZTSjFCN3Y1ajkw?=
 =?utf-8?B?cE9uc04rNUdQa3duSTkvNnpHK0F2c1hCcW1adGVzaHRTZFMyM2lSZXd5SUdW?=
 =?utf-8?B?OFAyK3FJcG1zOVQwc1EwRXM3K1drajJKYVBQR1BjK3hBVnpWQTFsRDlDZ1Rk?=
 =?utf-8?B?emQwNUN2VExTb1F1WExhc0pUbmFoWFlUT3JRMVQ5enMrUzA5WkhTU3lwb3hr?=
 =?utf-8?B?Y0VNYVR4blQwdlBqQjR3TE1LTnB5TkRUTHpjVmdyendnemppWWg5d3U4eTFt?=
 =?utf-8?B?V1YxTnUyMkhrMWlnK2l4THJZT2crVnU0aFZyZVRBWFg4YUl1R24xVnpPWHhR?=
 =?utf-8?B?dFRMWmxRRnhEMExhTll6d3FlWVQramFyaUdrTHZGVkk5cVJ6OWxmUWdwMVlx?=
 =?utf-8?B?NWFydmVlQS9XK1k5d2VxTFJvRk44Ymc5aVI2SExDcXdHVnliVlBuL0NZREo1?=
 =?utf-8?B?Yy9pL1BnR0NCelJrWHJEVWpLRElpM1cxWGMwSzNEaWd6eVdrRTBPQnUzVHlI?=
 =?utf-8?B?ZXJiaXhiOElZQlJwMEhxdDhWanhOT24zUVFKUU5jYlhycWR1ajBHa3YzRW12?=
 =?utf-8?B?Z3kyUEFSQU1CZkh1NVFuVGU2clhieG4xekNyYzBkcW1pamRTclJjWkJSM20v?=
 =?utf-8?B?OU1DTmtLMXc3WTFBNkt4UXFtOG92SCswMUR5NSszeFhTZUV1U2htbDlOeUl3?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8008bd-28cf-4acf-ea07-08dd6c962c42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:44:00.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLpeGXLCqfAwjeq/yL1nXCNnQLavrhKt+G4bmih+BR6looS4nE+kSy/NnjActj1W0pXsubt5cW6wLge3L69uVVbyVVXQdqC6kAKmY13H0D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

On 3/26/2025 12:35 AM, Chao Gao wrote:
>> +	for_each_cpu(cpu, cpu_online_mask) {
> 
> for_each_online_cpu(cpu)?

Yes, it looks equivalent but shorter.

> So, how about:
> 
> 		if (cpu != cpumask_first(topology_core_cpumask(cpu)))
> 			continue;
> 
> and dropping the pkg_id?

No, the pkg_id check is intentional to prevent duplicate staging within 
a package. As noted in the comment: "The MMIO address is unique per 
package."

>> +		rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
> 
> Note rdmsrl_on_cpu() may return an error. please consider adding
> error-handling. Is it possible that somehow one package doesn't support
> this staging feature while others do?

rdmsrl_on_cpu() -> smp_call_function_single() -> generic_exec_single():

         if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu)) {
                 csd_unlock(csd);
                 return -ENXIO;
         }

This error condition applies to an invalid cpu, but since the function 
is guarded by cpu_online_mask, it should not occur.

That said though, ignoring the return value may appear to be incorrect.
Perhaps,

   err = rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
   if (WARN_ON_ONCE(err))
         return;

> Shall we print a message somewhere showing "Continuing updates without
> staging"?
> 
> It could be confusing for users to see a success message following an error
> message that states "Error: staging failed ..."

This function already prints either a success or failure message based 
on staging results which are variable.

But this behavior follows the established policy that loading should 
continue even if staging fails, which is a known and invariant behavior 
at runtime.

So, explicitly stating that updates will proceed without staging seems 
redundant and could be considered noise.

Thanks,
Chang

