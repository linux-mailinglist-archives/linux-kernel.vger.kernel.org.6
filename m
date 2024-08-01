Return-Path: <linux-kernel+bounces-271807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB14945374
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E3AB22F81
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D514A0AA;
	Thu,  1 Aug 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IW3j6Xo7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62E1799F;
	Thu,  1 Aug 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541250; cv=fail; b=f9p25za/8N+7YPbQWtdvg20r40Lg3C1gV7PUGlsYV+Kjz8mo7gjFJgeGgGO0vlFFiTDOpFUZ3s/YuUrcoALISNwokHC5E3b1lZL4fiTB4Zf/d3n89ND2ZEcvWojN3rwe2OACovpe/nDC76xCaxnBbrF2qkc6lTsIkI4YuYHQCUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541250; c=relaxed/simple;
	bh=Lfa+vxojfysYwosqpdQ82Lci7OUFyxPMSLxhqF0GOk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jZGjQF+NbIfA/XFx3nRkt5LlFDMIqpcicQHNVwofjEXYACWg/k85lNMcN3JY8hNlMxryYMJytHkGpRaaskmYjJo7rtSeQrA7AO1ObXo2WDqi5gYxxPysaJKfeeq5lDQRW/Y6eFOnfApLd9KgynegFc5797/peI4T2mkVXFGwuJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IW3j6Xo7; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtVqgTn7Qn2Gk1AVN5YJGq7EYHJR07gQ7Yswq8qfcZLFl1ql3WPNmKydWcXI4nx8fyu4Ewa3ANNtboEcc5bZBaoR4XCmKNLQdtoTbQI0mS7gtDVq+W/KTkF4/I00M2IElgYZSG+ZF9cVoTbQH7DD5kAaP1zwcsNphyEMcvyMznaAebz/CmiMDgSD3OWHS6I9bERYRmIQgVviYFSwAKTNdRL2p2ptyJAQIMAYyWyga4XieiWWnUE95g9eDUNrwVeiHGsqmQTfB8YRca+wr1e+sMkxkaZBQWRlmsxc6TpsRpFLAtqwgmmVlyaHhEb1CRAptjCT/TznXlLnOM+Ba/oqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1ZQOt8/H9dsOAxj5xr0O0eqxYNgpzec6/J20JN6Ni0=;
 b=i91uPb7xosYJvU50q9ulMbMf6gkhHwIBxlPokFy41LOo6/W4U7cadI7bRn2cOCPNgyuR5KhSKOu4c+c3Iz+2AX39M0btYNk6VkCQ4ho9Qtp5SbKLJK6q8tr72+XlH+9fVIp/xNiz4rIKOC5fSF+qJm14gTsiVkPMMDsZdZj0Nx0sf36ZRODTTtYA10e/UENBUMu0vzBvPVr2kJW9fyU6asLdbChyOsHVXREK2EFlWd0ha6LdG8XkxKmk+M+YvkNoKVTG5USBnyGA8iF5NW2/FFbhkXDnrDvRZM6uiov2O6rdqgMIJom9waGCF06klU7uddvF0TphKBWtdTbNOmJObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1ZQOt8/H9dsOAxj5xr0O0eqxYNgpzec6/J20JN6Ni0=;
 b=IW3j6Xo7paqo5V4n+QU6bihvZHZpYBYwTygCrKN7bJwC+TAwkI50rAWaj4TucFAzUKZq1YeLlq5YWSEenTLXmIo9XaKOwO56vqB/VvAeac0os0pUj5kZTPWyPo7S23rtB2PCDScCb9bIwv5k9GoaGBbYDuBcozPEQ0s5jqng7jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 1 Aug
 2024 19:40:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 19:40:46 +0000
Message-ID: <a4979a8a-28f5-4fc8-a625-ab6b0e3c0bba@amd.com>
Date: Thu, 1 Aug 2024 14:40:42 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
 <CALPaoCjL92Jwm=Ynt+pEpSt5KLVxnJL8KOKymZ=WP+cUufy_Uw@mail.gmail.com>
 <54127ad5-8dce-b783-acf2-61bebd0db86d@amd.com>
 <CALPaoCiv9pFg2kzG9i-mVy4D4EP600x38F+WSXR2DqoZ9GjecA@mail.gmail.com>
 <6535bb31-8f91-4b0a-904c-45f320308966@amd.com>
 <90282397-fb9c-427b-80e7-5bbc325527de@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <90282397-fb9c-427b-80e7-5bbc325527de@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:806:126::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1083dd29-0ef6-4f09-acd5-08dcb261d6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wi9XR3BtMkNGN3QxV3R3dFlHc0hxN3lBbEhoeXdjcllXdnlIbVNGSkZHbC9m?=
 =?utf-8?B?RDlUTmwvUDJCNDNzVFVpanJzYUFSV1RXdngvU0drVDlNUWVQRmlBN0ZOMmk3?=
 =?utf-8?B?ak91dWpzcWtuRncvNDdVcUcvQVlpSkFFQlFjWFIzR0Naam5qVjJpRnhrZFlT?=
 =?utf-8?B?U3NzVG5PRDRJejVrOGVEZmxIcWUzWGtYT3d6Wm1EMnBxWFR6R3ZSRDNCdDly?=
 =?utf-8?B?aC9zSnphSGg4bTJ1MlhlV0lDcnVIRmd5NG5ncDVQaEFEelJkRWxTTkJONUJM?=
 =?utf-8?B?VExVYjBGNkZzejRudjd0WWhnaWY2RzV0dkI0ejc3ejVHT3dGSll2MlhXSkpk?=
 =?utf-8?B?STJiM2g0bmVuUVhUUEhXK3NuU0o4VTBqR3kzWks3ZURzRXpYL2RXandtSC93?=
 =?utf-8?B?KytFNjN5YW1hS0JFbTJob1NxOXpwZkEyV3EzQUtndTNaS1dsNURMMk42NEFn?=
 =?utf-8?B?K2FVRVZpbE5SK3htcWRXY0t4RStrMVoyVVlLU0s3Um1GM21UbnozUFRwbmVD?=
 =?utf-8?B?VU5iaHFWNFgzMHhNQ05IZ0x5dEtETWNIUTVpc0pOanBtUi80d0EwWm94SEVV?=
 =?utf-8?B?MFFobnpHR1lXS3VyNmVtM3BtNXVBK1BLK0VHSHlocFFaRFRpT2Q5TElxa2M4?=
 =?utf-8?B?N2tVeHBaU1h0T2NrNTZPcE16SnFjN3JRRTlGOEROVitWOUNZMWRtTDdBd016?=
 =?utf-8?B?SVY2KzJSV2dNUG1yN2RIYkhUbk1jcnhZaEVHN21tZjNSQVp0Q3IwSU93VDlE?=
 =?utf-8?B?bWhsYnEwMlhKYURkcFc5L2txMDJNVDRJL1hFTlVxbm00OUZMUFVnVGtOZWQw?=
 =?utf-8?B?a1l3eXBIUktLT1Iwa3F4WSt1bERRb1gxQmQ0UTFYK2NRalJ5eUdvRkl6cEJR?=
 =?utf-8?B?YUttWUh6d1YxMkNQczN0VUZSRnZqelNCQ2grcFRCa1NjNDAzZGpEbmkxdG5B?=
 =?utf-8?B?SW1pZW5JZWRQbkZaUkNjaERIRXErUGVvZTdQZFRsaittSDhKZkJIc2h0eS9Q?=
 =?utf-8?B?RVBYZzFsclBjOGJIYVA1NE5WRzhhK3ROdWZaZjZmM0FtdmQ5bmRLdmRlOGg4?=
 =?utf-8?B?RHB6enhaS09McGpPbSt4ZzNMR2RjbDFHVVpXT3grYStLLzVRUy92TFcrQjlv?=
 =?utf-8?B?NGlLaUV5TjVsaHF6MlcvbVVOM1lZVkcvUUtWRVpaaFlVY3VLeXp0S2ZOLzEx?=
 =?utf-8?B?THBZR0pPY3lwMGZ2cTJKTmlNYkw3TGI0MGFFZ2NJd3V3VE8vRzlDODQ3eEht?=
 =?utf-8?B?MFhic0dTWWkvYUNDd281ZUhDR1ZWdU9zTk9qc2ZaS0tzZXplYkJjZk5GUC81?=
 =?utf-8?B?US9iN3dFbm9VR3p0b1h1UkJhU2ptNlloNHAvaitPZWRJTG5EZ2tjUmlzQm9M?=
 =?utf-8?B?WW9xNkIvcmIyWWNieE01SzdjWEZyRjRSMkh1amZBazNFcThuUlJTaldwQk8w?=
 =?utf-8?B?NHpQb1VMaGJld20zWXMzWFlLOG1FTnJiM2E3V3pnc2lmVGlUS1MvY0Y3V1di?=
 =?utf-8?B?eGFTUnF0RjBwOGk0aWZFZWJlbG5kcnZyKytoNStodmFrMnZ0UW1lZ2xaYzhP?=
 =?utf-8?B?eFQrRUNrRXRiOFdPVnU1M05YaU5sbzljSU5rd1ljQ1FQTzlvQ1AzTEJCaHhL?=
 =?utf-8?B?b3MyY2xKc2N6OXJ1Z0JxcFFJdW1vaDFjeXI3ZkRhTVUwMVhzdnR1b2FGWTNY?=
 =?utf-8?B?TFV4MmlyM3NhdFg5YUJJQ2VTZnRYN3d0eE9wSlBtQytvUlplUkFlV0l6L21Q?=
 =?utf-8?B?eXpOaWJkN0l4MU50a2xONWFTcENJMmpBYm9NVDcrQ29PSStNOFhNVmJ4cS9N?=
 =?utf-8?B?UnptcDJlNGp0ekg5OWtUZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGdtQTdCQy9VbUFtVEhtRmluMnRXdWNYUWFsNFA3V3RUZWJ1TFhzYW9xR2I1?=
 =?utf-8?B?bTB6d1pyTGV2VUtJam5xNWxrY0ZZcFNFby9pUDBZMWtwL2FGTUxGVzBTdXFD?=
 =?utf-8?B?bXdTdVdsVk93d0F2SUQ2MlZyZ0dPVStLUFVmODhVY01hdHhacHkxRmVJNjh1?=
 =?utf-8?B?WW5UVlFMU2VkRjNqR3hYODN2QWFqeXBQb3VxVUVIdmhkbkdBekdCbFVxOHZ3?=
 =?utf-8?B?ZXBYcllVeVhzb2g3SERHdTV1cFIyMkRKZ3R5djA0aGdxSGduK1VyVkVMUEpP?=
 =?utf-8?B?WHMvT1BlRS9SdC96aDV6Qk11SGpVdmxmNUE5NVFJU2MyVGJ5emtkQVNVb2JJ?=
 =?utf-8?B?YmdmNmFNdkpMaXEzYXNIVStPSEVJcHdtNjZ4WldwQVQ0U3VpRjR2T2xNUWl5?=
 =?utf-8?B?YTFDditaeEhQZGZZcC9RNWVUdjZvMnhoZDJjYzJLc1NUNUViY3VZMEw0YnVs?=
 =?utf-8?B?MjFRVUM3ZDE4OVZRZElHZEI1ZEJaVGNYUWhscWxoYWt2bndmczhIWHNSTklp?=
 =?utf-8?B?R0pPT3J2eVFDVjVxVWlqVzRnNjNUcHVlL0JCUzFrSndLWkNMcmptTUY4VGxZ?=
 =?utf-8?B?M00rdERjd1RnbEg5TFYzZVNneVNCRGRPRjlmUUdOem10VmVPVG95bC8zOXZJ?=
 =?utf-8?B?aXlIZk54MlB1bVVLQ1FBbG5UeXExK0h6TXgzLzV0QmJlTmNpbWpjcE5BUEJI?=
 =?utf-8?B?cmRIVk9KbzUzQ2Q3eGVsdHFySFE4V2FGYUVGb1dpQngyaC9YTmUxY203TzJp?=
 =?utf-8?B?YnhBQlNRbGJNckJ1dVpvYkR1MGYydTRoUkJXbzZpZCt1OXNzOCtIMDVITWdw?=
 =?utf-8?B?U3p3UzYxaWFkcGJaSXVZVkk2RU56ZGhUT1dTYmEwYnFqZFBndTRyMEFTb3RU?=
 =?utf-8?B?ZnJ0MmxTK0VSaGY2S2tFU2dUVGRJeElVaTdvakVZWHl1clBPNG9zZWNZemli?=
 =?utf-8?B?VnYvYVRwVDR1bTF0MkVVNmlhMGtVQW1uM2tzSTBUL3V0UmVjRkZ2NHFtaGdn?=
 =?utf-8?B?QlVjc0xBdzROeWJBUUZtUHZDQ2g1YXExWm9BTm40SkRaamFOcllPT3psNitM?=
 =?utf-8?B?NXAxam9lc0IwcjhzV2tXV1NEZGZBR1JpQVNiT0pCaXdMZU5FaERQblh5bVo0?=
 =?utf-8?B?cndPaFViWVphWUl1ejdPY245Zy9Pc3pzbFJBTFU5Zk5pNlJ0dkNjOVUzb0R1?=
 =?utf-8?B?NHQyM1BBM050Tm9mZUJhRlI1Mlh1MDhWMk1GNG14NFhqVC8rZk9TdWhMR0FE?=
 =?utf-8?B?M1BMM1hCckZPeVlyeSsvUTJJLzNHdmhiWW9QVm8rdHM1VkEzQ0VkU1V4YXFX?=
 =?utf-8?B?cGVObHdmc1llWE9tK1ZDeW85U3JXeDNnRCs4blpWNFFpQzJ2NlF2V2Z2MFIz?=
 =?utf-8?B?TVhOYXh1cXpyQTRTQ0lCTFRPb1ZHWTh4Z0d1MVVyU3lyVU9jWXdvOGQ2eWVK?=
 =?utf-8?B?dTFDSnIzd0FWNXdGdkl0bG0xNXFxNmFEcEs5ZnhHNEppTmFnZWQ3R01pWUV5?=
 =?utf-8?B?eVNhbWlLU1lyNW9qbjAwMno4cXNnNDM0MlFLanQ5WXFvbm9hVVZnVm1CWlEv?=
 =?utf-8?B?ZzMyZEpkcTk0RG9hMEFWMUJJeThPajh1NmpYeGNzRldlRUU3aGY2ZTZZSlk3?=
 =?utf-8?B?M3IrWVJGbDZkK3M3MFdqcWNOL1c4SkFHbHNlTG51ZVFNOFR6ckJOU3gwUHN2?=
 =?utf-8?B?MWlLcEFvSmZGTUlKbnc5QWlQcVc3RlR3VVFuR0ZnRkdKVUJCUGZybjJKWVdJ?=
 =?utf-8?B?a0FjamtpSmtrYlFXcTVoQUZKdTlrN3ZiYU11YkdXUGxuMDRETy9rTFFHU1NE?=
 =?utf-8?B?REo4WS9ZMFVXVXRRQk1zdWxRamNJRHVrTFBwa1h2N3pzTW5XOTZDRXZrVjE0?=
 =?utf-8?B?WWhIK2w0eUtlc2lDUWdzZGpYWi9GN2FSc3FXanFob3o4N0ZZZTArcDBUNHFC?=
 =?utf-8?B?citWbW9MUmpLRVkyQk5BWGJhWmdLcXVwWHBUMCtMdkZ5Snh1T1pmU25Od3dW?=
 =?utf-8?B?eFpDVWJEK2J5ajdZbG44VXNxdkdaVzFHdCtibGZzOGRYc0FSdEUyaVkxb0x3?=
 =?utf-8?B?TUpqUWpvcUtlVWROSEhGWWVIdWtZclZzUXRpWWNKU0VkMHZZTmFyZ05KZDlm?=
 =?utf-8?Q?Kw8Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1083dd29-0ef6-4f09-acd5-08dcb261d6ca
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:40:46.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMuYNwmoBBkzTfdXXITKBRI27AoCMVVgU2lgMYumKGAX+Xu056MuTidOhCv6hfiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

Hi Reinette,

On 8/1/24 13:56, Reinette Chatre wrote:
> Hi Babu and Peter,
> 
> On 7/25/24 10:28 AM, Moger, Babu wrote:
>> Hi Peter,
>>
>> On 7/25/24 12:11, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Wed, Jul 24, 2024 at 6:23 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 7/24/2024 7:03 PM, Peter Newman wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On Wed, Jul 3, 2024 at 2:51 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>>>
>>>>>> Introduce the interface to enable events in ABMC mode.
>>>>>>
>>>>>> Events can be enabled or disabled by writing to file
>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>>>
>>>>>> Format is similar to the list format with addition of op-code for the
>>>>>> assignment operation.
>>>>>>    "<CTRL_MON group>/<MON group>/<op-code><flags>"
>>>>>>
>>>>>> Format for specific type of groups:
>>>>>>
>>>>>>    * Default CTRL_MON group:
>>>>>>            "//<domain_id><op-code><flags>"
>>>>>>
>>>>>>    * Non-default CTRL_MON group:
>>>>>>            "<CTRL_MON group>//<domain_id><op-code><flags>"
>>>>>>
>>>>>>    * Child MON group of default CTRL_MON group:
>>>>>>            "/<MON group>/<domain_id><op-code><flags>"
>>>>>>
>>>>>>    * Child MON group of non-default CTRL_MON group:
>>>>>>            "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
>>>>>
>>>>> Just a reminder, Reinette and I had discussed[1] omitting the
>>>>> domain_id for performing the same operation on all domains.
>>>>
>>>> Yes. I remember. Lets refresh our memory.
>>>>>
>>>>> I would really appreciate this, otherwise our most typical operations
>>>>> could be really tedious and needlessly serialized.
>>>>
>>>>>
>>>>> # cat mbm_control
>>>>> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;
>>>>> # echo '//-l' > mbm_control
>>>>
>>>> What is the expectation here?
>>>> You want to unassign local event on all the domains?
>>>
>>> Correct.
>>>
>>>>
>>>> Domain id makes it easy to parse the command. Without that it parsing
>>>> code becomes  messy.
>>>>
>>>> How about something like this? We can use the max domain id to mean all
>>>> the domains. In the above case there are 32 domains(0-31). 32 is total
>>>> number of domains. We can get that details looking through all the
>>>> domains. We can print that detail when we list it.
>>>
>>> This sounds like only a minor simplification to the parsing code. It
>>> seems like it would be easy to determine if the final '/' is
>>> immediately followed by an opcode (+-=_) rather than a number.
>>
>> Ok. Will try to get that working. Will let you know if there are
>> complexities with that.--
>> Thanks
>> Babu Moger
> 
> Dave suggested [1]  "*" to indicate "all domains". This seems an intuitive
> addition to the interface to accomplish this goal.

Yes. that is correct. Will try to address that in v6.

-- 
Thanks
Babu Moger

