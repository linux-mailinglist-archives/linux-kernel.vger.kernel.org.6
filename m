Return-Path: <linux-kernel+bounces-221703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A7E90F76A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ADB1F239A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A5158DDF;
	Wed, 19 Jun 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N/RiiT31"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB9A55;
	Wed, 19 Jun 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827864; cv=fail; b=K+drP5GHiejIj/34Al4+ZueVe0cLOfCOCyYz1LzyPQUBrRhvI3unve0RcBXL9CrieT/er3K+y7jh4jLUX95x0+qa7QC5iw9HdrqHXZhspyyHGc04AXCYlTidLRJN68wcEIRijBtzk3kBVdhpjWRCiWw41Q/ByxWhB9gXAsn4/8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827864; c=relaxed/simple;
	bh=h1DxaI7ZlIHV+afEWHVkpD700zNqvZ9F3md7I63mhSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jXhZkGeO04smxeDXXT3Q+D0MnaKfTe9oQl7Wnow48GLDa8tQ0SeEwK27uPlpiiBIrid07Cs44bHzTjOgpg/ToFrz6B2ySEn9A6zvC+fqOntQKXuGqPAQ2H+PT2g7TJ6bl0MBkpn+YbOeQuzTBPvEQpdq6Uu/DJ+P7WitJb5GQAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N/RiiT31; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQejlBZHwle51Gvg12YhAze9zdAiDZ3DeADO+ag8Ku1x0IlKIi3MQVDGOjAhhLGlTMNLkNqB4/kONeNcuqYEbUG5e5bBcLyqEFguTtmZYcqCHD/1QLwp0lEl44IyMXq+V4OEXmC2b2K08EgKTuLOhN1gBci/Q1yIzeFr89UEtYDh8FugIACaRfMsm+MeTYvzVj4ISQxsLZ4zosiUrxQU/7s898Xk8BkDVEP/aB57KYMoMbg5N13heoTjuyiTRGXUucKK/1z2epiOvru96RgeBGrIuSyIEsD5v74paroh04titB58RYa5zk7P3bEBuRo1Jepfp+KNj+0Ztanrp1nPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WRYFRU8Uu5xI9Y+m5kJd+3Xv/SNemLOUBvkdm8N2nE=;
 b=KEv6J3Mvm7O100AT5eQI2sqN+znVqYJqsmVqPlz8PG4dlAVRNafVp2nLpx8ULIJGHr6rfUdOA1X2UuMAo6/06rQMJWwtJxEamWnqFF+u2HV2Ai9p/7CEHvlzzAn4kxjh63GiHNvNVvxgUik0mYKBNBCvUNYDMnz6gFLkqEj9oEFZhCP9gk8F9BiMXpnC2Vu3dAIbBW3hLDji9BcJjdtC4GP5gvZE5B3P7BgerK250s1NZyWHHetl0ekAG5ZvxlyDMP+Bgcs9ikvZfUQCFso9CpcW/LuiL2Dm0u1HY1zOt/UIeLxlR0ddWgM4BTXg68KVKtmQYP32mK5PYtI9LZ1fhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WRYFRU8Uu5xI9Y+m5kJd+3Xv/SNemLOUBvkdm8N2nE=;
 b=N/RiiT31Gm9gu0ZIMKI8OI/CocBLG7okcUbdTfMv05m0FvZzIt1F79iQjssYtC8KDtrAgwbN5Hb+dDK/7o8+mfkQjlBeMBtHrlQ8zXK8VbE4JpBgYLmCy79FxavcKJjDDWknozLWo9tpR+P+RAmB9D2snKniyDq4/cQusRqJE9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 20:11:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 20:11:00 +0000
Message-ID: <5b110b95-b50d-482c-ae00-b59b7382875e@amd.com>
Date: Wed, 19 Jun 2024 15:10:55 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 13/19] x86/resctrl: Add data structures for ABMC
 assignment
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <a68ff64d52eff2de91a3c6030c2650396ea7fb8c.1716552602.git.babu.moger@amd.com>
 <31497c62-fe32-43a6-ba8d-361c4c89422b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <31497c62-fe32-43a6-ba8d-361c4c89422b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0151.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a2a6f3-0c05-447b-65e1-08dc909bf00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3NlTjRWb1ZSV3JZT0VOU1FHeVdvaEhPSHVkVnpaUDhZdDUrV3czaUwzSzZh?=
 =?utf-8?B?U3dXREsyT0JyY0R4c1VjQ0VGRjdLaHF4WlpsVlZhRHYyZ3hpU2Q4N00vQlFP?=
 =?utf-8?B?R0JHR09wMkpIMXorMlFXWEZVNGFIZGNBRDN0RndyemxjOCtzT3gza1lXalRZ?=
 =?utf-8?B?SGlGTkV2cFZsNVZPZFFDVEd5VTI2cnVkbzBwVHQ3MkVLSkk4UjNXOUxvdjFi?=
 =?utf-8?B?RGJNdi95RWo1RGpuaThNRHd6TE50YXU2V0UyL1FFNkhrRlZ2em41TG9TMDNw?=
 =?utf-8?B?MnN6NTlCaW5xWEZMWSt3ZlJpRkQ3WE5aT3M3d1k2VkNtSGlDMDFZcHF3QUsw?=
 =?utf-8?B?TE1STWdMaE5YMUp0RDFwOTFrUnY5aGFjOW42UjJLZHF0czlMdFNsdHZoU2V0?=
 =?utf-8?B?Z24yKzJTSWZuSzhYZWIreDFsaWw5K2VZNTduOEpqWWdyOTdrWjcvYVlGaHh1?=
 =?utf-8?B?Vk1GcnlpeFZBVjhLcGcxMFJjOWlGd0VlT2dUYlIzMmszeDRpZklQU3laSC96?=
 =?utf-8?B?NnU0d05iY0FaQnB5NlVCMEZCaVNCY0NKWmFCcC8zSGpCb0hTQ3NNUUhTQ01Y?=
 =?utf-8?B?WHJLbC9mR3Iwdks0OHhYYm43d1dUdzZtWGRSb2pZYUR1TGNoa3J0K2RGV0lT?=
 =?utf-8?B?UHBHR3BKSGFYR0xqYTZqeDFpbEhGVmY3bDY2cUt3YmxmVGJwOTZaT0JOODJJ?=
 =?utf-8?B?bUF3bnBpTzdtbzdmVldDOEE3Zmw4UysyNktDTkhwd1Y2SmpPYWtFWnV1dFFL?=
 =?utf-8?B?dTBMdzNQYVpJcXM2aXF6S1d2SFJLUnRtQ3lqSUVDN3Nvamp3aVQ4ckI5NWM0?=
 =?utf-8?B?d1VnclpEdWFodUxmb05LaWd1WVJLWjZteFVhMEk0aTdFcGI2alRUL2NqNTFl?=
 =?utf-8?B?S3lBM3hGbWxYN2tSbVE1VVhRQ05SY1Fmd2hWSGdYZHhVZkhRYXRUWndibUd1?=
 =?utf-8?B?ZmUvUUlScDNxcDNuYTRvNXl3L2QvUUZzREhqc3BPbVUveGhkb0hXOThBcFl6?=
 =?utf-8?B?TC9na3ByZHlJcHJncE9LRjJwY09SdGUvM1RFU2hiQkhQR0xpaGI0dmpzamFE?=
 =?utf-8?B?SENaMk9ZUmZsamVJZWxTUjF1K0pScEFlQnZuSzRGYkpJYjUxak9LUlJGZXhr?=
 =?utf-8?B?RDNzN0QvcGRDSHlvOUgzSlJGazdydGI2aHdETHJPTHI1Tlpzd0dGTTJaUEY0?=
 =?utf-8?B?dis5OW94b0Uza2duYkpEL3VBcnR3QVlIc3F1STBtTmd0TEFCMm1XTk5TOGRQ?=
 =?utf-8?B?alE0QmplQzB3VTJuRXEvWHpZcjhVRkJmZU80cmVESnMrbDFpYTVDMUxlOHcr?=
 =?utf-8?B?UlplZDZMVHZ1R0VJcWFMM2s0Y2pOamQvL3lmVmtGZ3Z6SG1lTUJ3Z2w4SU1L?=
 =?utf-8?B?UFcvS0FtVUZuREV0QUdwR3FUOGNkRmhmMm1za09lWFNldTgzLzFGc0Q4UjAw?=
 =?utf-8?B?UTRrTjV6YVlkRjlGUi9TdnJVY3lrb1R6elJ5d3VpR2pNTmNyREd5azQwOE5S?=
 =?utf-8?B?Z0cwbXZ1SjRNamJCQ1c2MjBwdmpHVWt2UTJ1dmFIZTYySFg0bW15bjZ4MHc1?=
 =?utf-8?B?RUErbnBBK29jaWtBYTEvakNPUllKWGFOVXROUEc1Z3ZNVk0yZmNnNDc1cXla?=
 =?utf-8?B?Zlh2UDRWb1haV01ESTdVKzMxcUdZWmNqWWpsOHpkTUQ4b0R4RWJnWFl0b2R6?=
 =?utf-8?B?Vkp0R1pWZ0tBMWtFUVZyVSs1bDB3T29HeThheG8vdGhzT2RCV0ZkSnNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmsydEYxWVM2NTZNd1F2VDNOQkR5aUI2bmVvNlB6NzFGZGxPUFBPOStOeEpK?=
 =?utf-8?B?aGV0SDJZWXpzeEpEYkpkOG1wVExRSkRwMHkxRU15dGl5VjR3MnBpS2dHbnJn?=
 =?utf-8?B?OWhpSS90VDJXTkR6TnJPRkZKT3JUd0RkR05pWEROZm1FMUVYTElSRDVrOEVS?=
 =?utf-8?B?UFhzeEdVZ3laSWNVL2Q0dnJpWDZieHlXdExvWlpRaXU2WVJ5WW4wZW1QdjJP?=
 =?utf-8?B?cU1PclZoSllhREo4ZnlPQ1o2Q1JMS3lGcHZpeGhYeEhsNEY2anFJZ1RhdVNI?=
 =?utf-8?B?VkZLYlNBa3ZEWkcyd2RsbHdDV3B3VlhuZXVqcUIwSjBuOEI5L3hrMUsvYk1h?=
 =?utf-8?B?Qm5DOWFaeHlEUjF0dGZHSDdDRG1hQ1RpL3NMN2VmTWV3a2ozVVBWZ015MDBI?=
 =?utf-8?B?MHdFWFp2K1dyendDbkxQclR4NzIreHJZN1h2ZENXSFRDaFJFWDRmZWdVMEN3?=
 =?utf-8?B?MXhPcytDZVBISFJIRWlLZnpnaFlOdGRWVHhTNzQ3azIwNzhJbW9uUGNXc0tH?=
 =?utf-8?B?Y0ZHRUJFUTdoOWVwcWNERC9aeEVaU2FuNzAxSkdZWUhnT2hXMENKM0loVjZE?=
 =?utf-8?B?eFJoSlB1UVpZWjVZK0RvZVVxMEkwVk9mazc2TGRFeHZwdjVOWHpDK2ZBMGtY?=
 =?utf-8?B?MkF4SGpsSjNsbktnTTIzUm0wM2VoK09VTE9DVGlONEs3WlA0US9hQjJsZjlT?=
 =?utf-8?B?Ty9QVXliVkxMY2dJUUNDQUpMNm11S1NLNklPWW1tbFBHS0ZsZldOKzV6aDBQ?=
 =?utf-8?B?OExRb3EwOWJrcGxHdmszUGQ5Y2RWbURtdEdhTHFleXJGZkZKLzA5ZlBlREZI?=
 =?utf-8?B?Qkh3NWw2TmxQcGdSM2NHQm1HMHVKZi9SbHlSL3BPTWN0em5WMWw4dm5MaWFR?=
 =?utf-8?B?dERIbHl4a2FDeDdUcEkrekxKeXNESzdVbnNTc2hxVVdwc281VFgvSFVyeGl6?=
 =?utf-8?B?OGxzWVVJU256ZzlTbHNJdGU0aWczbVJodHNhbXgvajBpeXZ5d3ZzQ2hadWQy?=
 =?utf-8?B?bm04Y2ZvbTNlVy9DMVM2KzQydndjSWVSaWthMzB0TnJKRExKYmd5ZVArTG84?=
 =?utf-8?B?enZCdDhyL2ZhS0tXSnBidkpCRDVGTTBxSm9kb1FXdGdXbmRneHkwTW13aXpX?=
 =?utf-8?B?VjhKdXMwTEJnL2t0ZE4vTTBIYTJtVkoyOGpiWW16NHZBMXY4eGg0eGdZVnVP?=
 =?utf-8?B?L1BEK1JrVkF4dmh5VUtnNmZ6M1dJeUc5Ry9qeTIzeHVZb0VWbzlIN0MyNzQr?=
 =?utf-8?B?aW9PenkwaEVwYnhIWHl5QUhBMGVUQ1JMdjNuWmpPYitOTHpkSE5HRXBoQml5?=
 =?utf-8?B?aUdDa09WTHp1MDRwQXBUT1NZZnpBem1TVlkyR3hKRGNvby9MbHpSQzBKY0ox?=
 =?utf-8?B?QUdra3JsTEdPUTIvMnljQjJpU3NTSzJhSlQyR0diNWpvaUVCTlZFc2RLNWYy?=
 =?utf-8?B?K0pxaG9JdHRuSXBEUlhKUC9GTU1pSmhyeGNDYUxQenNrTUJ1TE1uWldXUVhK?=
 =?utf-8?B?ODJPUmJpbzRqeEh6emF4SmVaZ2lISFVzcktOdEJXQzFQdnozYlo1Ri9zdHV3?=
 =?utf-8?B?bDJ0U1RKTHhCamY5bGtQZXNqRWxpWWljeGVZMTRiSTZJUEt2TmZQSEo5SENv?=
 =?utf-8?B?UzVTNHhyRTRaaDYrRTkySWtCU3dMYWJHZ3VwS1NTaWlGL1cvTTkwa3NwTmw0?=
 =?utf-8?B?TS90eHhpVU4yYU9qVnhqditENUdYbFh3TjVET3ZWUVg5cHpzbVk2RUlGdVlB?=
 =?utf-8?B?STRKbHVERnFiNWcvQnNRR0s2dkZHQVl5NGVUaG1UeHlNZFlqSUQ3dU1hRzFo?=
 =?utf-8?B?UzdSaEUxZ2dOSlZSaGp6R2kwV2xKamRTWkhMVGVyRElKcVpFSUprWDhucENI?=
 =?utf-8?B?eU1xcVo0M3VSS0JLT1IrTW41NmdJQUlFcmR2REM5UEdiMHpDTFpYbGdWcm9W?=
 =?utf-8?B?bHJKM1U2anlvN3VVdi9QU2dIbW9ScDVkS0ZPQ3htcHlVQ0tpUDd3VXZuaDBx?=
 =?utf-8?B?QVNrTnUvZ0xWRTdmSFV0UTc4WFhMN3FRSnZqcGZhNFl2M1ZNUEJ1ZUQ0ZUlS?=
 =?utf-8?B?SkUrVWJzRHhoaHl0dTFNYnJYdkV5ZGFUR3JyNVJTVEVRcTA5NEl0QnNNTjhk?=
 =?utf-8?Q?8q7Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a2a6f3-0c05-447b-65e1-08dc909bf00d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 20:11:00.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm4xGuEdRNGR2bAHhwjUvv4IeZ4rRG9OYf0YdTArBQV2huH60996eCZdULEuX9ZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

Hi Reinette,

On 6/13/24 20:44, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as the counter
>> is assigned. The bandwidth events will be tracked by the hardware until
>> the user changes the configuration. Each resctrl group can configure
>> maximum two counters, one for total event and one for local event.
>>
>> The counters are configured by writing to MSR L3_QOS_ABMC_CFG.
>> Configuration is done by setting the counter id, bandwidth source (RMID),
>> bandwidth types. Reading L3_QOS_ABMC_DSC returns the configuration of
> 
> What is a "bandwidth type" here?

Its bandwidth configuration(reads, writes etc). It is
mbm_total_bytes_config", "mbm_local_bytes_config" in
https://www.kernel.org/doc/Documentation/x86/resctrl.rst

I will add that text.

> 
>> the counter id specified in L3_QOS_ABMC_CFG.
>>
>> Attempts to read or write these MSRs when ABMC is not enabled will result
>> in a #GP(0) exception.
>>
>> MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
>> details.
>> ==========================================================================
>> Bits     Mnemonic    Description        Access Type   Reset Value
>> ==========================================================================
>> 63     CfgEn         Configuration Enable     R/W         0
>>
>> 62     CtrEn         Counter Enable         R/W         0
>>
>> 61:53     –         Reserved         MBZ         0
>>
>> 52:48     CtrID         Counter Identifier    R/W        0
>>
>> 47     IsCOS        BwSrc field is a COS    R/W        0
>>             (not an RMID)
>>
>> 46:44     –        Reserved        MBZ        0
>>
>> 43:32    BwSrc        Bandwidth Source    R/W        0
>>             (RMID or COS)
>>
>> 31:0    BwType        Bandwidth types to    R/W        0
>>             track for this counter
>> ==========================================================================
>>
> 
> This is copy&paste from AMD spec but needs some translation to map it to
> resctrl.

Yes. Sure. Will elaborate.

> 
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v4: Added more descriptions.
>>      Changed the name abmc_ctr_id to ctr_id.
>>      Added L3_QOS_ABMC_DSC. Used for reading the configuration.
>>
>> v3: No changes.
>>
>> v2: No changes.
>> ---
>>   arch/x86/include/asm/msr-index.h       |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h | 30 ++++++++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index 5f9a0139e98c..6d2fe39ac68f 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1172,6 +1172,8 @@
>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>   #define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>> +#define MSR_IA32_L3_QOS_ABMC_CFG    0xc00003fd
>> +#define MSR_IA32_L3_QOS_ABMC_DSC    0xc00003fe
>>     /* MSR_IA32_VMX_MISC bits */
>>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 60a1ca0a11a7..45ed33f4f0ff 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -107,6 +107,9 @@ cpumask_any_housekeeping(const struct cpumask *mask,
>> int exclude_cpu)
>>   #define ASSIGN_TOTAL            BIT(QOS_L3_MBM_TOTAL_EVENT_ID)
>>   #define ASSIGN_LOCAL            BIT(QOS_L3_MBM_LOCAL_EVENT_ID)
>>   +/* Maximum assignable counters per resctrl group */
>> +#define MAX_CNTRS        2
>> +
>>   struct rdt_fs_context {
>>       struct kernfs_fs_context    kfc;
>>       bool                enable_cdpl2;
>> @@ -211,6 +214,7 @@ enum rdtgrp_mode {
>>    * @crdtgrp_list:        child rdtgroup node list
>>    * @rmid:            rmid for this rdtgroup
>>    * @mon_state:            Assignment state of the group
>> + * @ctr_id:            ABMC counter ids assigned to this group
>>    */
>>   struct mongroup {
>>       struct kernfs_node    *mon_data_kn;
>> @@ -218,6 +222,7 @@ struct mongroup {
>>       struct list_head    crdtgrp_list;
>>       u32            rmid;
>>       u32            mon_state;
>> +    u32            ctr_id[MAX_CNTRS];
> 
> To match "num_cntrs" it seems "cntr_id" may be more appropriate?

Yes. Will change appropriately.

> 
>>   };
>>     /**
>> @@ -568,6 +573,31 @@ union cpuid_0x10_x_edx {
>>       unsigned int full;
>>   };
>>   +/*
>> + * ABMC counters can be configured  by writing to L3_QOS_ABMC_CFG.
> 
> extra space

ok

> 
>> + * @bw_type        : Bandwidth types to track for this counter
> 
> What is a "Bandwidth type"? What are possible values?

Its bandwidth configuration(reads, writes etc). It is
mbm_total_bytes_config", "mbm_local_bytes_config" in
https://www.kernel.org/doc/Documentation/x86/resctrl.rst
It is a bitmap. Will clarify  that.


> 
>> + * @bw_src        : Bandwidth Source (RMID or CLOSID)
>> + * @reserved1        : Reserved
>> + * @is_cos        : BwSrc field is a COS (not an RMID)
> 
> Please be consistent wrt "CLOS"/"CLOSID" in comment and member name

Sure. Will change it to CLOSID.

> 
>> + * @ctr_id        : Counter Identifier
> 
> Please be consistent with "cntr" vs "ctr". Earlier the series
> introduces "num_cntrs" so cntr seems appropriate?

Sure.

> 
>> + * @reserved        : Reserved
>> + * @ctr_en        : Counter Enable bit
>> + * @cfg_en        : Configuration Enable bit
> 
> Why are there two enable bits? How are they used?

I am setting both these bits when configuring, I need some clarifications
on these bits with h/w team. I need to know how different combinations
changes the behavior. I will confirm about this.

> 
> (please match other kernel doc wrt : usage)
> 
>> + */
>> +union l3_qos_abmc_cfg {
>> +    struct {
>> +        unsigned long  bw_type    :32,
>> +                   bw_src    :12,
>> +                   reserved1: 3,
>> +                   is_cos    : 1,
>> +                   ctr_id    : 5,
>> +                   reserved    : 9,
>> +                   ctr_en    : 1,
>> +                   cfg_en    : 1;
>> +    } split;
>> +    unsigned long full;
>> +};
>> +
>>   void rdt_last_cmd_clear(void);
>>   void rdt_last_cmd_puts(const char *s);
>>   __printf(1, 2)
> 
> Reinette
> 

-- 
Thanks
Babu Moger

