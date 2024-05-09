Return-Path: <linux-kernel+bounces-175007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0B68C1898
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15206282B67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785F128813;
	Thu,  9 May 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQYVfNlU"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F385266;
	Thu,  9 May 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291153; cv=fail; b=KyzXn44ZxzVvh5riZDNUs1iOdFNnxPeRWDPdYFWx+/WWx8b6Ndjg5i8UvXUD/73iCvLF9DCAHkMS5mVOQZs97b4fq9t91jevYLAK9TsLwITePf6D+Azj+GifFmxcpRRF9za5mkHSXAcHcZOLAsRuN2yvWhBuOumjqdxSKYof2IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291153; c=relaxed/simple;
	bh=IXLyjlurkFKuwxjtjlcoCsAuk84N9FeLPnS7az51Ls8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dWe4B/xB8zwxJcYhdKA8ZaQ8GmFgEO+jTfQSQyLUFpnB12Ian+wZvIeMtAb+DQB9m81gW1JZTigILy4v04rP7CYmIHCKDzj6dYIWBkfH14YW1N7nSWbWmQa7gjwwEJbsuu0voQBKdShUQnFEO+uRgQF14SOlSTp8/cmfBIn9jYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yQYVfNlU; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfruV5IpTgzRUjBpdOye9Ytj84WgAdrkeLBZcRUC118HyBWAEkVjxEZ1OySl60STyXNLCx7EL7HJXHG6MYB7QFuLGm8lvW61Tqh/Jqi6D6wFMuLmvRI0tn+Yl5BhU9+Ht2Dz1lldhoz4k3vDrduOlx1HLLH/xSbRFvrBz3TKvf7OZz6VcZ+lMikSUPrmav+a0Yn2ixBIL2LgO5WSFuewUaYiVk/ddip9OJYzoY8vJs/WPANvLXMZmdR14aMJKCZYlZo4ZaTwmseVyKs5Xj8fkB3CbFI0Jl7W0ZNIDuzbaVUmPRzBFPm4IBVl0xPNWoHbxSzbjmrRdcL05ilTYRYRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1gz461udHGOu/HJGAeAx67zdBStnA+KXj1tGGRf/4c=;
 b=SagNm9ughNeC6uIV0yc5yKHWSqJmTEfxiErEYEuJsTIxwvYOAsw2dDsns4oNwbyfIrWM8+3EMlGZ+CD1YyW+v/EDqxKbPXN/1+esESREWydFXUxkn7Q7cr2VUP3fzmcQ3825Z2bpVAVq9ASPe2HwClxT+A+oMZevCfTlwyLtnPJcKBY1b8tGNDkHkfuwyu1NOxo0jJxcr1iMSIurC1Y6v6tymYHy2CE0uMcD3pEAbhdf3AtC3ptcqq2Z/KOfGTY0bKP2V9pM50EjC9wdaAoN6a6cix8DrWdL9SFXbzWUFuV6GiKDhygIiChtm/a5MY2oQFuwS4Yq9FHJkIOwIFS0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1gz461udHGOu/HJGAeAx67zdBStnA+KXj1tGGRf/4c=;
 b=yQYVfNlUzZ6cG1/JH3cIAt8A6b+w0DE4Eo3NNAUG0uaYBNQaerHpAb2DrqIdO8lb/9YAaDrdP+MnvIVlvEXQ8/RoWbPEtciQs4iZwsJb4QJ4hMmeOWx7DAb67cXYWGORnm5FcbR2z0biYhqcDY5ikuyFB8Qo/QHiX6kMBVoNsI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 21:45:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 21:45:48 +0000
Message-ID: <ed0bc0b7-c37a-466b-ba2d-dcb3c5123b85@amd.com>
Date: Thu, 9 May 2024 16:45:43 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <54b1fe8f-13e5-440b-bb36-4100c1d283d0@intel.com>
 <54ec73f9-6c9e-44f4-8ee9-a683bfcee607@amd.com>
 <a873f6ba-904e-4317-b177-5645c3a8526d@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a873f6ba-904e-4317-b177-5645c3a8526d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:806:125::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d22b57-85c9-4546-8d84-08dc70716399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REZhVWM0MENyMG9neU9EcSt4RnJpQk9xZnN5Wm9HNGR3M0srNDc0T1VibEg3?=
 =?utf-8?B?ZUlDaHBxaU9wOUVaR0RObHcxbzh6bEJFSUJnY1FpUGRSVGR4MDJXdUFEUXV5?=
 =?utf-8?B?Si80VGNneWViellXMWViS3FPUFVsZjJzSUFCQy90YkVJTXhici8raFd3RUM4?=
 =?utf-8?B?VVNhUWRTWXlQUTFrNDc5dVdpaTVzRm55TkRZMDJhOFpYbHdnT0F5ajN2YmdS?=
 =?utf-8?B?eXNXeG5DWFpoemc5YUFEVE1ScHB4SVFTRmtOa3R1Z3cyRDJHam56YlVnRWZp?=
 =?utf-8?B?b21DNlBmR3doUGRVUWxNWEVNZDZURFBlQlp0Uks4Ty9EcFBlR3doYklCVXEz?=
 =?utf-8?B?WHQ3eXpIeW1zZHpxS1Y4cUhMTzN5WTl6cXd0bFFJYk0yV0UxMWhoZDZGaWRS?=
 =?utf-8?B?R3ZMNW92QXF4WWNqM1UwQlJBNHhtTXdVQmZicmoxa3g1dnJyckM2cEFjVUd6?=
 =?utf-8?B?dkhyYk15K1UvRlYwamtYQW1ycnNDNy9sUFNNN2prS0poUXEwR3kxc1BjM0JI?=
 =?utf-8?B?NkcxbUJHdnhkNTdveDBxQStUT2tabkd4b1IySEJZUWJ2QU5Eb2RXWFd5SFFr?=
 =?utf-8?B?aFRqRVluTDRDd1ZYM3dSRjZQa2l3dDBsTGhzZTF2Tmw2dzRhMlM1QTJqTFpn?=
 =?utf-8?B?RzFZeWcyU0hyVUt2S09oa04vcll6eXlUdnUyRjdkWG5ybERIcmRyaTIrK3V6?=
 =?utf-8?B?Rm5HRmpydUtoU2h3cVNyTWl0SXVtY1VnY1hNQ0FvcmlWRGo4NzE3ZG8yelUy?=
 =?utf-8?B?YVFJQkp3QTY3YVVaWmVaaE5xVXA3T09hRmdJWDdHcCt2REY1czZBdXp3NDQr?=
 =?utf-8?B?QktjTFZTaTZLOHYzRUZ0TlhiazRHRVZZSzRxd2NOUWdKaDcrTWpmcTI3aUZQ?=
 =?utf-8?B?TTVGOVVPVUhDVkljM1JydEU2L1VwcjFnUWJaTjk4SXphWmhsbkZ4OGQzUGk4?=
 =?utf-8?B?d2U0TENmSTlzMGtOVTlPTmNFM3NnNFI3T1BhSjhRckw1SXJNUEJsUnM0MEpV?=
 =?utf-8?B?RzRhTmJpajNCYnNDQ2c5UXF2Z01ZNUlkdHBQb045aU9xUVZRSUF3Y1IydDBl?=
 =?utf-8?B?NGYvNkg1MTZmQ3lSZ1lSWGlkMFpiOGcvVVFpa1hKMUJsa1hVMjB2UkFyTkRJ?=
 =?utf-8?B?dUkyazk2TDdjMnVEVUNyMWY5RTcrUE1iQ1RtaWZZNStIMi8xSzBxanQvWXlV?=
 =?utf-8?B?d0swZEwwYndaeGl1NmdJaTlqSFdFNWpLdTI3a1BJV09YK213ZUYzTEozcjNZ?=
 =?utf-8?B?dXkveTB3YVV2NkMxazZiTnA4MmpxME96M3lHelFDZm80eFVWdHU3VEJLOEor?=
 =?utf-8?B?RGRVM2tvWUFzRzd1bXZXMS8xUXV1NGFtbDRBUjViY2JxQ0hBZW9mWmU4UkV1?=
 =?utf-8?B?ZzZISG50MFdGa3Yzc2MyOXRDZCtpSmFIVXlNQVFaOGYzWUtxaTVOTHVoL0xk?=
 =?utf-8?B?Wnd6S3l1OW05cUZ4MnNOT1kvV0lwTUQ5YjFJWU9uSk03NTVKdnZZRktBMFF5?=
 =?utf-8?B?WkhUTHoxSFRUVFJzRXBBUkdLM2o4TzJRaFRIc1M5UDh5bVlWT0Ruc2NRWkpa?=
 =?utf-8?B?TTA4UzZjNE00dUxsV2JtMHpJZ090UHVMRXJheUNjUmhzWWppVEhVUGwrZzhh?=
 =?utf-8?B?RnJtbUFoNWxzaXFWdWgxNWNzdDNtREJnMUZhZE81WHZKc0pVMWttY3FCbjVx?=
 =?utf-8?B?MzlXcjVMbnkyZUZrekhWcEhzNjhERTFPVFg4bG1wVGFnbHZwbDh2cGdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHJ5NFlpRUpTdlpMelZkYVQrVDRmMWd4cEZBYUI1ZnBzQ1cwRG5IMzd5MXo5?=
 =?utf-8?B?ZnN3ZkZZTmdsMWFDSEpvRVEwbFZDeW03VGtxaFF6SEl0SWhLaG1aWlF5b3Ar?=
 =?utf-8?B?NmQ4OVFLS3lPQUE3NVVFVG5JODJQZ2tYNkxUVWFGaGplYWN0L0gyREZHa2p6?=
 =?utf-8?B?OS80aGllNTRIbURlNWxnT1pobkpjM2ZTeldhandkYmpxTDliQ3orNUFNbWxr?=
 =?utf-8?B?djloM2xrL1VFa3R6SXFQaDc4L0xtbXI2dVRjTEpsT0tMNlQvUW1QQ2dKQ3ZP?=
 =?utf-8?B?NlhwRW9zUkJNQmxuaTY0UmNSQ3djWGNENTJjdzVrTTQzQjlScHdvNHlGN25Z?=
 =?utf-8?B?Q1RwZ2JnTVFrSVNTbU1sVXJLS0RVanU2V1l5ME03N3JlYkJTbEVPMzAwSkhn?=
 =?utf-8?B?ajRXNFRpSFJRek5vTlk5alpTK3VZcU9OMzN3Ri93SW5qRDk2QThzamdIZUtL?=
 =?utf-8?B?MmVIRkdYMW9STWh6N0Q3eTlFNHdzcW53VTR1QjdneUhWNGFCdVN6VmxjSjU5?=
 =?utf-8?B?RjB4MGVFZzdEQmZaM3BSV1dWQzNuWDRuTXFpU0JudnlmS1JCcEs0MHN2RTM0?=
 =?utf-8?B?cVhvTGhHTklaQzlBNjJna3hlcEFmRHAyQ3VWNTY2RTROeVZBVng0eFhQbGlH?=
 =?utf-8?B?eDI3WlBFVGlzc1NPblhlbjJnQWdQamJmTVl2SVBpYUd6MU5MOXo4dFhrSGc3?=
 =?utf-8?B?SjJobUQ5VHFDNjdRQ2dUSGhPTUw5Z0NYcmkzUzBaM0tzMW4yTC9VS1hlSFNl?=
 =?utf-8?B?NVVPRkVXUHMrc1lTWlJ2UkxuK3VkaS9uMWVBdnovRThKdDAzNWxEKzdXNTdx?=
 =?utf-8?B?WDM0ekNiRWQzdE1xOVRlSW1qZ1haVU16NCsvZVVHRVlaNXNoSlFzdDRhV1Bo?=
 =?utf-8?B?UXpFMGVXZmpIV2FUR3MxcXI4ZC9qVWtmdUFQeW1rNWROcjV3aUl5bm5IUmRQ?=
 =?utf-8?B?SHlHbVRxalQ3QWtTVlA2Si9KTHVNOHY2QUtKQy8xdlpjbTQ1MG9YdGxIc0ZU?=
 =?utf-8?B?RUpiWXQ2d2FnbjVzR3EwRGprcnh5d0c1ODJpdXpMakkwZkV4bzFzUXE3cjhZ?=
 =?utf-8?B?SG50TlFQTDFrWS8vTm1ac3RvZDRwY215NnlGQXRDNWFPUkxTTW1icHRvSVRD?=
 =?utf-8?B?a1VLSjUzVVdXQXk1YnRIRnB3cVM3YWo0QndUTDJaNmNxTkFibEF3YWZqdmZx?=
 =?utf-8?B?dmpmTzl6dS9zMGsyUGJlZDJyQVY2UHJRbUxxUjc0b01BMWZCMDVNSEFXV0tR?=
 =?utf-8?B?QTJBUmtJYm8xWm9EY0xQWFg3MWtxby9uUm9sYkV2VktYUlh3eHl0aFV5Njl6?=
 =?utf-8?B?MWhiZTZxZTFlaXNaYTJUV1dGSGxtQVVGL2pXWU1uMmJLTHVBdENoSStEU3dS?=
 =?utf-8?B?dFQrNW1IUk9NUnM1YUs5TWVqZ0JxbVFUZTlhZnV1TWNpSTRhMHIxMmIyTUpV?=
 =?utf-8?B?bm5lbVJpVytPaDdpYUdKaWJmc21wWFpXSFB5QVNKcTh2eUVPQWhML0dSUE9v?=
 =?utf-8?B?Q2tKNURPYS9rUFYwL2M3UXV0UmVxTWowayt0aXdSdldQSmxqcUZCdjFtR0Jx?=
 =?utf-8?B?MkErYlA0dVZDRHZXSHhwdjI0NWljRnpCMUNSbDIwTDFlMkNxY0RHNmxKNUdp?=
 =?utf-8?B?OHFuNGxHS0N1Qnp2cFB4K2xMd2Qva1dpYmREZzJ1a0tZeGsxUWs1amhWcjMr?=
 =?utf-8?B?ZVEvaW9ET3VlZkZFYWVSZ0RuM2xob2ErY3Ywb3VxS0FaSEgwN21scVNJOHdZ?=
 =?utf-8?B?UmREZU5wcG1lT2RETUZBT1g1RDlLbmtVY2hxeGIwMVBmTVF4U0dFQ3FaenQ4?=
 =?utf-8?B?N04vMTJmOFpyeURwM3BOaTB1QTNqTHFHQ21FbERHb1I3YlBMWkJxZi9hbytH?=
 =?utf-8?B?UXVubmd5NEtPQjRUT0FyOVVmU0RQdmZ1d3RWdnhLcUZzcGd2dkFrQ3EwV1U0?=
 =?utf-8?B?Tnc0a3RsVVhkb1liMU1nV3Y2cS9ZSUI0SllZYVBRUUVMakNDN0FRSVFQQzM4?=
 =?utf-8?B?MUVFRDdaSWorMDZsQ0E4NGZuV2VkNUJHV0JyS2YwYm9BY2ZNb0VGRGkwN25H?=
 =?utf-8?B?dnJUREoxWnU4aXRja0YrOXE1OFAzM3FnS3NLRm5JTUd3THg2dGt3T0tmZkVY?=
 =?utf-8?Q?eAcM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d22b57-85c9-4546-8d84-08dc70716399
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:45:48.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z/yXAwUTuCQM410Z9WEKJz9KYNYU2hAl0xaedzJSpvaUw2ldl41AZZ70hPb0Bjk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320

Hi Reinette,

On 5/7/24 15:32, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/7/2024 12:12 PM, Moger, Babu wrote:
>> On 5/3/24 18:30, Reinette Chatre wrote:
>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
> 
> ...
> 
>>>>  /* MSR_IA32_VMX_MISC bits */
>>>>  #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 722388621403..8238ee437369 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -96,6 +96,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>>>>  	return cpu;
>>>>  }
>>>>  
>>>> +/* ABMC ENABLE */
>>>
>>> Can this comment be made more useful?
>>
>> How about?
>> /* Setting bit 0 in L3_QOS_EXT_CFG enables ABMC features */
> 
> Regarding "ABMC features" - are there several features connected to
> "ABMC"?
> 

No. It should have been "ABMC feature". Will correct it.

>>
>> Or I can remove it totally.
>>
>>>
> 
> ...
> 
>>>> +int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
>>>> +{
>>>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>>>> +
>>>> +	if (!hw_res->r_resctrl.mbm_assign_capable)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (enable)
>>>> +		return resctrl_abmc_enable(l);
>>>> +
>>>> +	resctrl_abmc_disable(l);
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> Why is resctrl_arch_set_abmc_enabled() necessary? It seem to add an unnecessary
>>> layer of abstraction.
>>>
>>
>> I feel it is better to keep it that way. It is consistent with definition
>> of resctrl_arch_set_cdp_enabled. It handles both enable and disable.
>> Otherwise we have add those checks from the caller.
> 
> Caller needs to know anyway whether to provide "true" or "false" to this function ...
> caller may as well just call the appropriate _enable()/_disable() variant, no?

Yes. We can call resctrl_abmc_enable() and resctrl_abmc_disable() directly.
Thanks
Babu Moger

