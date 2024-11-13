Return-Path: <linux-kernel+bounces-408402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4629C7E57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E24E286184
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CDD18BC30;
	Wed, 13 Nov 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUmltptY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D833CFC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537671; cv=fail; b=AIgCQGyd/pTuxDScbM3mF5vDz0Q3i3pYpPASOou2TQ2qqfHS1W+HI6cZ2QcBCWBAvCRbwoShLhQ4rECYFivE9uQdj68ovPAiEr3R5QzK37bGxclVUsAHSr5R3R8keO1MIYjfhJfCgLcXuKiMeFKbfrq9B6+s7moHojCrqiM3p4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537671; c=relaxed/simple;
	bh=UyPTzq7jGVrRWXJ5kOZG6um6bnqsowqzF2NzdM8oj4k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1uWiQrHegLQ45UaAA/NvmyTPd0cCzd0Yn0V1QKklfBXEkSg1qtCr2WTEcTK+fx86oBzegLOKhm5vczO+Ed76cdAjrbagIHayTh3VRtIuZTsCQbAuXK0/x4h1kuuRo2DlPWB6YghfKuIO069Y2eeQpttLvDxvBRMa4i7ejRGigk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUmltptY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731537669; x=1763073669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UyPTzq7jGVrRWXJ5kOZG6um6bnqsowqzF2NzdM8oj4k=;
  b=mUmltptYVDnmfZzXtzMDyeh+IG/+S6aBL6mZFtGSLlpZZR6wb5aoX7e8
   73RMsJD68tQNIVoSxsih7IfQPu0myscYJ+jdjVXz4C53MU15r30UxX1Zk
   SDSHr3SM4hhlDaf4LDieP8zEJhfN5whUlaiWhU1Sz2VsvRA791GZ7TkcY
   O1babFXVJ5xUpJzqD+NFBnQbNd1tmc9cuEdmi1vNjKYu/aTVHNN7k2UL/
   tLq4V4emxtjn48+dS8eUtoPJDuxeSW0vucv1AswHvd/ELowAIBYRiog2I
   YPdZ3GR3cn5CANfHEH70mNaLyS/Zu+uywbnTi8vWxQJbSz1Cb5NesdhHr
   w==;
X-CSE-ConnectionGUID: UHvhcJHARRebicvY33/vZQ==
X-CSE-MsgGUID: RHZqnV7mSzWob8peFprpPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31310257"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31310257"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:41:08 -0800
X-CSE-ConnectionGUID: 1llaCKDcTz+FyTA5dbfyug==
X-CSE-MsgGUID: oVXvD04uS5mT6ZviHtG+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88434352"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 14:41:08 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 14:41:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 14:41:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 14:41:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svrDbnX4M0QkuxSq82RJZlrCqaMdiIj26mIGVTJpfgAhqgQuw09LZJZUlkO13O0nzhcpdb+N7XCcqd7w3iHfuImgk9Wq+cx7J6jSiyRfVqZJ+un3x6mNiCRwWYf/nAZKXDZqMKo0kUmMu+Q20NmaJe/3NQr2CVNjM8ecW5UlLxWqrddlKxIjGww19xx8bDmE5nc0xLlm2dBQBssWUrWv/GZnZGtUePuu7y9lI5wWfFzoxcYnW6npfiPRytFF32ytAHyDYXwiviJDzMmF4aivSXiJO6Rs0li+/IUe/gUe+C66Ou3WMAJQQWvnUgtp4MDwm47PIQovUMPGBvoxjouVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JC/9NMizJc6n1iro/NCPRTvD4UHxd/v9Q8vbiga6t8=;
 b=vBV4WRR+7tNbblTsTHX89sXcIB7PdO3hX2Tp+pYjzlYeO5vXBhWQiAjjaec2r2ZTuIi0pyzUXXVx+NW1wyYdPBoyuQZpS8nDpfsb4KqP/5s7lRCfkEzQOQmFJFf7ygVVobyHat/mZcphOpAmX0Mm7AEGpHp5WoMMo0OcRcA1BXr2Acm3JDM1pdatv8f4J2yhxulGFl8NCEORM2rfnQoMkAxES65aJlCVxxDE6c5ZEuc3ElRkEXBAEQ9mMXQwK6FWlrpsRYxcAnNYBc2Qn8EjL2anS4oKASHIdU2D1LBRXHB/bGzQtVOQpwRMSUjGePXsVLZ+7qydkEsXaH4EIwFGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4749.namprd11.prod.outlook.com (2603:10b6:806:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 22:41:04 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 22:41:03 +0000
Message-ID: <45a8ac0d-9f79-405a-80a4-40f5886c3bde@intel.com>
Date: Thu, 14 Nov 2024 11:40:55 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] TDX host: metadata reading tweaks and bug fixes
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
 <1e00cac3164ea0f20ba2cd68e3f4790c6f1da091.camel@intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <1e00cac3164ea0f20ba2cd68e3f4790c6f1da091.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: aacb438d-eec3-4283-c2b7-08dd0434413e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWNxZ3pGWUhMZ1dydWxSVkRLVWozbHNIU1RMZkhBalkwVzFGalV1NmVDd0k2?=
 =?utf-8?B?c3ROK3JNMmptTWxiWkp4V0kvaFZEUXBIaThoakVLdnloSmtObStmR0NneVZP?=
 =?utf-8?B?SWRWSW9QTEhJVzlHWUpvZ2dVS0RCMWYvcDRqK3VMakJYZW1Mdlg5aUJxYy8y?=
 =?utf-8?B?UjFiTjVnQnAwTDc0N0tRZzVSUnJDOUJzbXpIcHJSaFhVL3FkWFhtclRxMm1V?=
 =?utf-8?B?d1drUXJOejJhZ3RkdkJFMWVuYys5OU5WUzkxWUxMQ2ozTExBV0l2OGw2VjRu?=
 =?utf-8?B?WnhYTWQwbUNSZ3d6eUR3ZUNWMUtQcmVoWHl6U1U1QUtBWUtzYXd5ZXhtTHRz?=
 =?utf-8?B?MUFPbUUzTHlVcG9zSlhla2Q3MjVtL1pOYzgxVVdINW5YTlFOV1c5TmFBeFZp?=
 =?utf-8?B?VU5EVGNuNlZ1YklWZ3BIMWw3d2k4aHo5dlAzbHBwUHhZb2EyNWJTdlgvTUlx?=
 =?utf-8?B?a0lCV2FoMmJFc0lobDRxM2hDbWtXdllWSWI2dlBFOWVaS1NqM3dTTWppSS9U?=
 =?utf-8?B?bml1bksxZXJqRzlsYmpWUm1qUjh4YzVTWVVDdlg0TWdOTjM1NUd3ZGRMMUVB?=
 =?utf-8?B?RWliRTFHeXdtQXY5bVJGbG5CV1BweERJb0pncG9aU1lqcGdpSXJmbG9Td0U3?=
 =?utf-8?B?UHBsZ1ljcVdhTElkbnh1eElrYVlsaHZlTGcyS0dmZDErOXRFUGJPNWFNTTlM?=
 =?utf-8?B?NHZGdVI1dmlDanN2TlJVTHZaWEthQVFxSTB6SXl3REd4NEFsVWNnQzQyM1dR?=
 =?utf-8?B?alA5cEtVd3pkR25Vczh3RDlSR0tXTzk3UHJJaHlRMGZPUEFNY3pYUzVROGUw?=
 =?utf-8?B?dm0xTWVxSytJK1ZHUWRaQUhNY1c1aWNQMjE5aEkxR2RSUVJBak5lcXdqY0Fx?=
 =?utf-8?B?NjJzcFRHTDRrWVRNVlMxbm83aW5Qa25EWFppRUk2MjFtWUI5aWsxd04wK0Q5?=
 =?utf-8?B?Wk5tWk5XOXlueEMxeHpWOEU3NEpMZFplUmVOVDE2Mmo4d3FIdThZUlVFaDJp?=
 =?utf-8?B?VHV1TEdyd3NkQTZDVjRNL05nQjZWc3Ftc0dUUndSRVVGRXRXVEFtZWp5TG4y?=
 =?utf-8?B?QXUvUFRtejR1RkZDdWNoVyt2amNWY1huRjNic0o4dW55S3BPczRRK0V0TTBF?=
 =?utf-8?B?R2E3N2Y2QXUxSmhUOTF5Nit5RUVrVjF4cExTZm5ZTHQ4NjdaUmZPaVFLMmZo?=
 =?utf-8?B?emk2Sm5nUkx4MlU1Qi9vOVlFWDV1MGJIelJObzNaZzByQ0loRlRsQTczMWdo?=
 =?utf-8?B?d2YrNCt4QUVtVWNQTlVvU3lUcy96UDlBeTdHUFh2VENZb1l3b201Sk9wODNu?=
 =?utf-8?B?Tis2aHZ5cWYwWGhJNGJxS0RCejhiSTAvMnN3UWhrVHpSSHgwYjZvOU10b1Vj?=
 =?utf-8?B?cUJHYnF5N0tORzkvSUU1TFpERkVnWWpyYUE3MkQvRnUyN1JSd2o3UlBVSW9E?=
 =?utf-8?B?N3FEeU9xR0w5WUp2dTVNTXJkQW5FaHUvN3Y4UTlUemNsVkJacnF4MCtBbHZu?=
 =?utf-8?B?K1N3TVY5YXU4eXdIT3dEWDNhM2ErMEw4YktQYkpSMmtDWVVMTlIyQVRYRndG?=
 =?utf-8?B?R0lMS1BUM0VzSWx2Zmg2ek92allZSDZDeWloMHJVcnJCb1pDZXV5aHk1YTFw?=
 =?utf-8?B?ZmxqMWh2S0ZsK1liUGtobnNnam1LN3BMZWtaMGZkWXMwR2hEY2thT1RWdkUr?=
 =?utf-8?B?UGRneE1rYXZWSStaWlFOMFc1TnExNEtxbzcxalpsMm55TzYrMFkvN0hwQnU1?=
 =?utf-8?B?ME1ETmtseWdMUldrekNnNjkyNGh0YlF2eUwwcFZNT3RPczZkZUt0YUZKYTVv?=
 =?utf-8?Q?aghH4Yz6qvYo07aDg0ZvXe2LThyV8Prqr5uGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWIxNW9UdVI5UnVadGE3dkx0QjRRQkJnTlp3cWFZNFZIR1FNdFB5VG55T0Zr?=
 =?utf-8?B?bWRtaEJWbUU4bXZjQVJoUE9vYittQ3dzcXhCNHFxV3dOZlp3MC9FTWVMRmM5?=
 =?utf-8?B?eHNZZmtobG54R1dmWlh3Y3RabXJxS2tKYnpOVXg2Z2IzVGtKU0ZESUkzQkFq?=
 =?utf-8?B?YVBiejRvZEM5V0tFSTRYMEo4cEZVbVN5cS9tU2pVUXlnUXpObnZQT0krK3p1?=
 =?utf-8?B?RlpsbkxvNDY5S0ZtY1duZXlCNjhpc0wwU1NVajFSaXRCOGxtWHdHZ3J6M05K?=
 =?utf-8?B?RlFGZHBDQTNUY2orVUpDTjF2VzVBc0l2NTJRQVdrazhyMG0yWFdqaVVDdUd5?=
 =?utf-8?B?TUdpbmlqNCt3N25peXRzYnVHSElGQlpBUFFsVy9XcjhTWkxxVUhnc2lGYlhJ?=
 =?utf-8?B?VFZrU2tsVS9qMFRZVnVlZWJpUjhoSi94amJGMzF0R05ZR2ZYdEcyUGRyaWt4?=
 =?utf-8?B?QnJtaGdYMDYvWktoZWgwS1JlRllYL3lYSDliTWtlQVp2cUJMV0l1WUxpcm5w?=
 =?utf-8?B?a3pYcnJWTURmdlY0NjV1bTU4cTlldGFOVHhSVnBrRzQ4S01hNVpINDhxNHVL?=
 =?utf-8?B?c014aDRQSHh5VGhLZXpzL1JMY25JUjZGeEhZSnozZjJDNElpUkhZVUtRSDQr?=
 =?utf-8?B?VzV3Rzg0ZWFQd1orcFJsYXpCY25MK2lUTlNVV2k3dlFWODN2REFUbU9tSXhi?=
 =?utf-8?B?ZXczOXZhYkNycEI2ckVOdXZhYU1TRHJmMU1YYjcvOWIyYUtrUms0QkVXNmp0?=
 =?utf-8?B?YkFuOWlrVmpYbEhWNHA5NVo0dm1Jc0F6WG5ET1dBUlVDWjV5eUtBS3JtSU80?=
 =?utf-8?B?U1RoUXFjM0RUcGNiVm96alFWQmNqMWhRdTdlVXhkMWMrblcySUJSeWRBaTlp?=
 =?utf-8?B?YVpnc0FBL2RCUGl5aGhKc2Q0QlltOGd2VDZXT1R2S3JDdkdNU0E4QWRxbTJv?=
 =?utf-8?B?MXlQRFBWMGE1SDBjcDFQRXNNcmlHMndnR1FpSUJsd2ZqT2tJQ1RGR0NvM2tj?=
 =?utf-8?B?YWR0Qm1TWHN3RUc1Uno5WWZiNzRmcDNza3lGY21CV1lQRnZCM3BLWGxjRFJJ?=
 =?utf-8?B?RXN6cTZZdXhoTVNRT0JvMTVaRVYvS3N0UTI3bUVIY2dqT3g1ZjFZcHp6MC9s?=
 =?utf-8?B?RHlzbkJ4OTI4ZVRFZ2VPN1k2OFozN3NBRS92WWpOQ2hFbFhnT1l3MW5zM0t6?=
 =?utf-8?B?UkZLd2Z2d0NKYTU3OWxhZm5ZMjlTeGp4Rk9NTGVhRGVmSU1oYkNpdHhWTGNH?=
 =?utf-8?B?MXlSV0FsNFVwaWhPejhYcm9EMnRnL283bVlUVjQ5M3huWkVlVEpFbWp1Y1V2?=
 =?utf-8?B?dE9qZjFkM2ovSHVuZktDUUVmQzVRcDJ1dnZQOXpwNW90UFBVL2Nzc3I5ZG43?=
 =?utf-8?B?YVR0V0VpZGZ4aVd6ZGd4MmYrc1F3QXllUVZaelJPVlplSk02MWpNNlhVNEQ0?=
 =?utf-8?B?WUJSczFqR3JPU0ZJOEZSNkdjZEJGNlYxVXBLQVVDa1hwTEVTWk5VNXFycFBN?=
 =?utf-8?B?dy9Mb3Y3RWxJTnlUYmFUaEJqMjY5dmpVR2phTHd1N2tkNXRpY2Q1anhyUFlr?=
 =?utf-8?B?UDdnYTJLekEwa0hFaXZOTENvMysxeDl2Q3lTMUZnRWxjZDIxM2szT2JYUGI3?=
 =?utf-8?B?Q0pxYlZheXlGcTBiVkkyakw2ZkRmVEpnSldpRXFKRVVTclpiTUh6a0VWY0Vq?=
 =?utf-8?B?UHlVSXRYRVdJTVByTnNsOTVTV2QvYytZYXQzYjNJcndjYm13MUJ0U2tJZVFC?=
 =?utf-8?B?UHNTYXNJMXlrTDVJUFRtVWRpQXMwNDd4WGk1eXArSnk1ajBLMVp5MndGWmpI?=
 =?utf-8?B?TjNLM3lXNnlxcklQN2lDcWxrKzBvRW5SK3h5a0g3R1RNczRSNEc3SmFHeTdY?=
 =?utf-8?B?OW85K0Yyb2ltbnU5c2tVUHB3MUg1aE1TZUQ4aXFpNU00N2ZmK0dwWVUwZGcw?=
 =?utf-8?B?aThhc3V1bW8rOVJsV1Jlenpxb29zeC9qRHdZOE5yUXV3ek5GNVFwVkdhWFIr?=
 =?utf-8?B?V3RWbjlWc2QvSS9jMGk0VFJ4aEZFZ1UvZnNYZ0tXMUZjWU9nRW1zWXVsdFdM?=
 =?utf-8?B?eUpJL0pXNFAvblVuWTFwMXVZN1JXa3BKS1BGWjRoN2t4VjVubHNWTm9qSUpL?=
 =?utf-8?Q?WGZHvn3agon7BPf8hz4SVgpBU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aacb438d-eec3-4283-c2b7-08dd0434413e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 22:41:03.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imbjvUK3b80vlOxdU5dA8EdN5o7hs08tF2eSXM2/eG/TliWjAt2DJoXv2nVXR3e1hz1WpvUgfvZlRpQTi+RXkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
X-OriginatorOrg: intel.com


> So I think it is not part of the "bare minimum". I don't have any objection with
> it going upstream with rest of this series if it doesn't delay it. But I want to
> make sure we don't have any more confusion that will cause further delays.

We have two issues that need to be addressed.  Addressing them could 
bring the infrastructure that is needed for KVM TDX as well, so this is 
the "minimal code" given the goal I want to achieve here.

> 
>> 2) Some old modules can clobber host's RBP when existing from the TDX
>>     guest, and currently they can be initialized successfully.  We don't
>>     want to use such modules thus we should just fail to initialize them
>>     to avoid memory/cpu cycle cost of initializing TDX module [2].
> 
> I think we need RBP MOD for basic support, or it may cause crashes when we start
> booting TDs.
> 
> Does all that seem correct?

We will need additional patch to save/restore RBP.  The more important 
thing is it's naturally bad, due to the thing that I mentioned in that 
patch:

"...clobbering RBP could result in bad things like being unable to 
unwind the stack if any non-maskable exceptions (NMI, #MC etc) happens 
in that gap."



