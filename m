Return-Path: <linux-kernel+bounces-518349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459FA38DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFC7188C081
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD9239085;
	Mon, 17 Feb 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9XIXWXT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BE237180
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825856; cv=fail; b=lRD9fFFsVpWZMdawTkuYNPIkw+WbsPkdlm9odXrAqc4Lk/8BjehJhAKGArEAOv1v4uX+/8o7qPntSNwexoea+BZ/MOOVXQWKA+++pJRiHrna4XiHvN/IAQYcwQzFYy4tuPMAXnqX5fsqKsZ4W7dll2vk7YlmCwUtM/j+487homY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825856; c=relaxed/simple;
	bh=tj9Rsebrm4/EIYNyD7vf0V6NhpqFzLPXMFpX/BJ1Xhg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iedN45QqDJJQZXXezhY6Jh4RHhDArwsKxvBqJyDVAjs+uRIU/14UZyOplAmfyi+7MaqPHTlkzzwk71VKT9kdGKM6wwQJAPMaUB8ayo8AWGjgHvJNNkMzbToDewNsOz7vmvXRXqa83EYfE8ObBJriTFdattlnfgCqDSyhE+BLgoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9XIXWXT; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739825854; x=1771361854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tj9Rsebrm4/EIYNyD7vf0V6NhpqFzLPXMFpX/BJ1Xhg=;
  b=Z9XIXWXTV25MB6a8KipiB8MAUOUOge2oiG6OYBiB76GrulBN5Dslaqmp
   fNF4RD1JeEwZSfTkWQgPeoC7I0R3/22FsJnqL2ie++opdlhPl6Aphwv8f
   h5FVDQAySxeHBYDPqvCgQ+ua34/JvbTj4pIHfxttLwQ0dpf4qCvXc6DFi
   tmkkvBSrn53llQa2vzHvIOQcZZnnW4FfUczAU1WCWQ09XhXcyZuPPSZoc
   WGCb/0ZDELewUidlF25ezvd9/dWZmcCRIlx5m18XjVXlNGCpYcMLt1uRz
   fyds5n9TDt8T32dBIkFJE0ElmX2R38JErIlMupN6kaOUszMpggOL5idAP
   w==;
X-CSE-ConnectionGUID: q5FZJZKTQKKRrumul9YQcw==
X-CSE-MsgGUID: Zv8EGmp9Qt+5C2Utsy9ydQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51133165"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="51133165"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 12:57:34 -0800
X-CSE-ConnectionGUID: DkNuP0OlTZ6Xn1v4y0PRGw==
X-CSE-MsgGUID: o3pKfQgETXGGk8ji9Q5RIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="114077391"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 12:57:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Feb 2025 12:57:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 12:57:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 12:57:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2MO1J0iXxTfCZm/xmUC4jYjQtuTIE/9zheQ528ePClTE5efefKEQC+31bviZI+WSvJDd43+aktZhTVrovwe6Z/tCX6vGMJJmxZTX0uIvIUp4SGFyvPd4YQV/5dPZzAfsUjRPIuKt2is9oyYPtCtFaovJTthIA6zA8zgGWW/wn0FuJl6W83TOXlPFkdotMhZ7MPQ5G1qpwLB/66caNq9tWTsoQDX+6iZzFX9/DeAaN7Vp8P6aw1XZ1QaGXjX3xirNOA84ENaLgrdmSPCzGuqxUv6/gxBtElt3JZLeUtqfzu3gGPnXdvI24zDUSShjCIC+p8svqqijq2mhosXTotYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuCEdTySEVai0xg6sNNiz5PyC4tNt3u40+RNGeUmGe0=;
 b=bXZ0bWsbztcB7PlAVAVnOdQrVe7b6u7oloo35AFpkoByuZ/jFfqauWG0MQ+dzwNaa9bqB0amJ3whGapkVjssEg0H/fmyDq7addbsThy2xOuDlkSzLsSP70+pMVSyKqpzBvxVeCMtorkVR7NVJII54YIOeVpdDX11iREbuZHy6qhEE5hXQsMhNWcwoKa87/hPeAQk+pNQnqYhKMxzwgszFCGKCN22KuG6T9WTjBMVJvRR14PdvjoKVpcrAZX1feWWmMbf/V8JA36ke+je5/MdyTMowK+zM4vzn9NYDBk6AeYQbuiROFqNmZ/nScRMiDOmZU3CjAQanONf5toUB6eVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Mon, 17 Feb 2025 20:57:30 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 20:57:30 +0000
Message-ID: <10ab62c7-d2fc-4014-a235-700bef017a3e@intel.com>
Date: Mon, 17 Feb 2025 14:57:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tsm: Add TVM Measurement Register support
To: "Huang, Kai" <kai.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <20250212-tdx-rtmr-v1-1-9795dc49e132@intel.com>
 <828df2dd-a099-4146-96fe-0915cfa2e4b5@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <828df2dd-a099-4146-96fe-0915cfa2e4b5@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc606f0-42ca-4bb1-129d-08dd4f95b158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXV6U0doQjZpSWlwZEF1NW1jZU01eGN3TjZYUDZkYlFla24zQU1wejY3em53?=
 =?utf-8?B?N0wvdmtCTkJyWW51VCs5YzYyRGtueGpzOC84aS8wMEs4WDZYWFBKbzN1bVhF?=
 =?utf-8?B?TkE1d2VxZHdsMW9QL2tFbDgrRHBRUWplREFRNm5XRXljYmJZd3UvcS91MXhx?=
 =?utf-8?B?SDRvdUxreElJSWo0djhZQzBSckV1UldRNHFZazhRY211c2xsazlHMnVkSFZy?=
 =?utf-8?B?MkVIaVNYMXE2LzJaZEp0T3ArT2lCV0Y4ZkFuYmlTWUFZVTZVUmhOUG1najFY?=
 =?utf-8?B?YitNczhCNXFYdHZkUzY5cXF0MkN5UUdmR3VIUFc0bU9OSlh0NXhjNUpOeDBu?=
 =?utf-8?B?bHI2QytyT0VrNk5XbllVTFQ4eWVvLzFYVUlvQTl5SGxneVJidEN5dmVnSEU1?=
 =?utf-8?B?aHBkMGRVTHM5QlJQZHpuWVVKM2N1OUlIYldvNlVwV0lsTW5hMkNuWFF0enFW?=
 =?utf-8?B?a2lUQzU5T1NZL3ZXN3lJQUJZSTducnFkejUxNzFGRW9xNldsRW04WlV1UWpl?=
 =?utf-8?B?ZnJKTjlIcHcwS3E0N1hSY0xsNkQzVTFpMFNiU0RScWJmWnhxSEtzbmY1cWpj?=
 =?utf-8?B?TWFKay9BQmFoSGFLaHU2VGR6WlVCL05sdDR2eUVCV1ErVlh2YWxtVGRFdTdx?=
 =?utf-8?B?bDRwZWk0a29tVzlFQkZaN0J5b2RYeXFxMDJzVmpzR210WDJXNHB5c0NxNnVq?=
 =?utf-8?B?R2dYN0hqWE9FK3l5QWdGSy9SVHg5dUZNRk1lbzFZVGRKcTRnQXp0NnlxeHlJ?=
 =?utf-8?B?N1cvZWhndTd3cHM0dk1McHF1aGd4WkRYeXEzbzZvMmpXK1Uxb3E4LzNxbmdQ?=
 =?utf-8?B?cG9Halg2RyttRU9VQkNKeG5nQ2Fsa25uWHJONTNad0V5bU91N0UrQksrczB3?=
 =?utf-8?B?OW8vTWh0c3ZDdEVPQW5aUjBDVXpCaUpraTRBQlZlWk5XZjZNVk1FRDIwbXBk?=
 =?utf-8?B?Y1VpTEJwcm8xOHRBUlZJd3ovZ1V6R0pMbXBVRmQ3a1hMVlZTQnJLQU9NemVF?=
 =?utf-8?B?YU5VWHo0ZHhyeVJFN2FUQ1l4TGVXUW5OUkZaQ0c1M1RrUmZhaElBdEp4djJ0?=
 =?utf-8?B?SkpYQzgyMlFpZWFOVXBSUVJyOG5KL3NtS3VoS20vbnRGMXFpTkVNRzF0UUp6?=
 =?utf-8?B?M1JGTk9kU2dOZVBjS0pUMVI5L0QvNVFqb2NFNWlDbDF4aGtpT2JZQUowVGZx?=
 =?utf-8?B?SkFxVUprbDE1QTVIV2xDN3NIMURuMzdUd3FUMEU2S1Nra0pzZHZORkdkUUN0?=
 =?utf-8?B?Mys1YVJPSlhjc3FVM2M1N0xHTk1lVFFzSHRrdUVZZlRNQXFyL0NnU3JpK0Iy?=
 =?utf-8?B?T2hrVTFqZTY1eW14VzVxSzlCc2hXTEorK3BrRGN4UE1wN29ic2FnRmRSN0lR?=
 =?utf-8?B?emcvZW5YYSt3eXFFSFJaYXcwK3pTQThCVGxFNXR2UWRVdHZuNmRDaVNTV1JW?=
 =?utf-8?B?UCtHZE1aR2tFWWIxMitlQllNejdocXhFRzR0VjVNOUhMS1pVMUZBMUR2Y011?=
 =?utf-8?B?bzFhNWlUTDlaaUFVYWRINXlzY09kdndYSldpUzBTQlExWWRvRFFzek84cjRx?=
 =?utf-8?B?aWhSc29WZEhsTHE4OXFidWFpRUR1YUp2b2tPNndHbjg5TktzTHR5WU9IUXlh?=
 =?utf-8?B?a3JoaFY0aER6aE83bEQ3VWhHSm9ORUVMamJwTEVDRk1XSXg5VE1BbE5LUUll?=
 =?utf-8?B?Q3VXMHZDbjNXZ0pzU1MvWnpmcm1IZjRYMkhlSmgzRlFkK3N3d25oc25kbVl5?=
 =?utf-8?B?VUNTS3BTQU1nVkU2RFhGaVRObEIwd2FacGI3bEZGUUhrWjFoRkRkaHhBM1ZJ?=
 =?utf-8?B?amd5SmdZSWtaWld1U1hIY251emdxaklvNTExc3NvbVlyS3NIQ3VUdU1yd0pJ?=
 =?utf-8?B?VEJrRlVMVDJpRWxQcXpUVkR0Z202RDFNL0JoeXhGa1ZWdFNlOS84eUw5alhP?=
 =?utf-8?Q?QG4rO9zFaOI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNhRHhUSk9IbnBhbE1nNFlUZE5nUnRqdm5hcHlPaFdFbFRaVWJ4dk9FWGE4?=
 =?utf-8?B?K1NCb1FyckdiaENKTDlqZ1owNXZWSW1uV0lQVUNqZHFpYk90Q1dvaFNlMTlv?=
 =?utf-8?B?eWNpTDRLZnJVeHVZd1NvRlU3M2RyeVo0STdIWTFFY2QxOGlxK3cwSjI1RDN4?=
 =?utf-8?B?MTdDUXZnVnc4VUxMNHBnMHN1bFVxZ1lpL3BpQVFPN0FDOGVQNVpqSG9JTVNN?=
 =?utf-8?B?MXM4b2gyQVVldEJ3eFJHcXN0SWJZMnNjOXJlbGt6d0Y4akRidDVxWUJZUkNJ?=
 =?utf-8?B?czZwVUxOQ2ZSdFhRSDZXdnlPUTdVWUhSZ0VKNmJWOGJHQ0lEc2hwN0MrVVpZ?=
 =?utf-8?B?ZWI5eWd5Wm9jK2p1VzEyQ1hGZnZLbjhETk92Sk1iVk1pTTNQWFBUWGRDMm5O?=
 =?utf-8?B?bDBibTFiMXlyajNIb2FwK3ExQS9jRW9vUi80eGtpejNudGovSCt6ZXhrZnM2?=
 =?utf-8?B?d3NlbWp1OEQ2TW9TanNaUEh3QXpTYS96S1BhbWptSnMxVitmZGdBdFdoYkpF?=
 =?utf-8?B?QWV6M3FZY3NWWUJ1ZEVhOFZ6anpYQzVKK2s0MHJwdDVURDI2WjJuMnBBTmkx?=
 =?utf-8?B?b3dKalR2SnZXb3ZoQ2dYdEl6R3pTTWhEOWxuVkozaVZacEJCVjJLVFUvQ0c2?=
 =?utf-8?B?UWIxOHoyQUVudHkxdW1kclRJTTF6SllJbmV3Y2szeWM2TjVRNm9UeVJrWTkx?=
 =?utf-8?B?WlUxaTJpRDJHN3pFL1dFRGpxN1pOS2tKMzFYMTFJcXNwbkJabEhRSFd2eUZi?=
 =?utf-8?B?RWZJRUN1UkxRSnA0UGZjaU05Y3ZPZysyait3UkVaNnk5TkZ0VlB5Tkp3Zlg1?=
 =?utf-8?B?a0wxbTBjaDlhL1RBTkJIdm5wYWRFVG1JUVllYVFqZzNLOWtnTE0rU3pka1hj?=
 =?utf-8?B?WmpYT2xpRHdtQVBsL2dUdS96Qmd1aXdwd3AraUl0ZEZKUjJrbEVmcGs1MFVJ?=
 =?utf-8?B?Uk03TVRpWjRQODZqOVlhendtVmN0WTJQbFd2ZmFnRTdUZTNadm9Nb0xnT0xw?=
 =?utf-8?B?QnBvb0FsSHRVRDd3VjQrci9NSWcxcDZGTy9uTU51OU5sTmNXL1Q2dC92amRG?=
 =?utf-8?B?QTNzbmlNWW1TUWR3MXRDaE5QdmdDQlpaSUtPOGxMdUtvK3RRbTE0OHpyeHBS?=
 =?utf-8?B?Um5raVBrQWxwMWdnL3dWVGt6OTl2VE05YmdPcEVzU2JEbURJUUllTjRYQitK?=
 =?utf-8?B?WjZGb3lXYlI1NFZ6L1k2SnEvaFF6ZGc1OENxUlIvMGYyQUdMeXhUWmhPQzRW?=
 =?utf-8?B?MllJTElyMzNZaExkL2UyWEJPTEx5c3MrbkxMVjBTK3JvVE1jQlViZ3FjV0N3?=
 =?utf-8?B?YkhOZWFja3Yrb2R0a3FmNmpXNmYvZG9kRlFoWEh5SGR2Z3pzRk5sZzZoNmtR?=
 =?utf-8?B?UkxFcUtrakltdGZnMHhuVER5L0RUOWtGdFJML2xldUZOa3BBUTh0VndNZ1Qy?=
 =?utf-8?B?RW5GcUZXM3N6WUdnUEVnK3pNbjBBZXNEQytRbmF0TlZVbDhpVmp4UkdreWNH?=
 =?utf-8?B?R0wvZ0VEZXZCRG1hZXRCdEszQ3lDQkFyREVydmhQSksrMTBUc3NCMFhWQWdw?=
 =?utf-8?B?eHdoQ2dMR3R1dlVuVzFWcHJxZXBScUdocW5vRG5mS01Rd1pWV3pZbjVCWXNy?=
 =?utf-8?B?YUh4VmRMVTFlT1BXWjhGalhIdlc4ZThLcisxNTh5QkN3TW5sVmVnRHVERlhk?=
 =?utf-8?B?dDh3enpvL3RBYWs2R3J6V003NXQybGIveFpZdTZSM3dPUjlBelQvc0twb2hO?=
 =?utf-8?B?bURxQStqUmZhNlBnMXZ6aEp4Z2kvNHdsWk0xcXpFZFpGZG12UVlZZGoxWDlh?=
 =?utf-8?B?VmEyanB3cnF0VmdJMExJMld6aE11VkowTDhOajY4RytNSitMOXo4L2xkVUIv?=
 =?utf-8?B?TG93U09EMTNrOUtvN0RYRGcwQkpZZ0NSWmhLbk1vbWZadEc4R2xZYXBTQTRj?=
 =?utf-8?B?RTdtdUJtYVVMSGVHNHBCbWo4VDkreWlkVGo5Vk54WWk5VFNMVEVzU1duWm9r?=
 =?utf-8?B?N2tQdkRpMTZSY3NWSDZ2cmhuemtlNlVreHRabS9HczVEb05ZQWllNERFUU5z?=
 =?utf-8?B?Z3lMS2RFbzVMeGRSK2xZNGY2WG1kRDdLUFFPdEtEL0lVc0oyS09wZDJnejMz?=
 =?utf-8?Q?6hkj5Afg0EPEKX5xTEJzdyabz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc606f0-42ca-4bb1-129d-08dd4f95b158
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:57:30.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfW/GPD+N72q3h9glqnq6xIL/Ab4jl0DJQGo/cDCJE6/iZuHoW7YQt7ulmOguq1ZcLp6rc4yQD1pmz+PF6oJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com

Hi Kai,

On 2/16/2025 6:17 PM, Huang, Kai wrote:
> Hi Cedric,
> 
> [...]
> 
>> +static ssize_t tmr_digest_read(struct file *filp, struct kobject 
>> *kobj, struct bin_attribute *attr,
>> +                   char *page, loff_t off, size_t count)
> 
> Better to rename 'page' to 'buffer'?
> 
> Since page normally implies 4KB alignment but I don't see we need the 
> alignment here.
> 

'page' was used here to imply the size of the buffer cannot exceed a 
page (which is the current behavior of the kernel). But I agree with you 
and will make the changes.

[...]

> The logic around using pvd->in_sync is kinda complicated.  MR operations 
> seem like a classic reader/writer contention problem and I am not sure 
> why pvd->in_sync is needed.  Could you help to clarify?
> 
If in_sync is true, then "refresh()" will NOT be invoked on reads from 
"live" MRs.

For example, on TDX, if an RTMR has NOT been extended since the last 
read, then the next read will return the cached copy of the RTMR value - 
i.e., saving a "refresh()" call (which must issue TDCALL[TDG.MR.REPORT] 
to reread all MRs and can be slow).

> [...]
> 
>> +
>> +/**
>> + * struct tsm_measurement_register - describes an architectural 
>> measurement register (MR)
>> + * @mr_name: name of the MR
>> + * @mr_value: buffer containing the current value of the MR
>> + * @mr_size: size of the MR - typically the digest size of @mr_hash
>> + * @mr_flags: bitwise OR of flags defined in enum 
>> tsm_measurement_register_flag
>> + * @mr_hash: optional hash identifier defined in include/uapi/linux/ 
>> hash_info.h
>> + *
>> + * A CC guest driver provides this structure to detail the 
>> measurement facility supported by the
>> + * underlying CC hardware. After registration via 
>> `tsm_register_measurement`, the CC guest driver
>> + * must retain this structure until it is unregistered using 
>> `tsm_unregister_measurement`.
>> + */
>> +struct tsm_measurement_register {
>> +    const char *mr_name;
>> +    void *mr_value;
>> +    u32 mr_size;
>> +    u32 mr_flags;
>> +    enum hash_algo mr_hash;
>> +};
>> +
>> +/**
>> + * enum tsm_measurement_register_flag - properties of an MR
>> + * @TSM_MR_F_X: this MR supports the extension semantics on write
>> + * @TSM_MR_F_W: this MR is writable
> 
> Why a MR can be written w/o being extended?  What is the use case of this?
> 

This is because "write" may not be the only way to extend an RTMR. For 
example, the current ABI proposed by this patch can be considered "MR 
centric", meaning it's the application that takes care of what to hash, 
using what algorithm, and which RTMR to extend. However, theoretically, 
applications should only be concerned the integrity of some sequence of 
events (the event log). Therefore, there could be a "log centric" ABI 
that allows applications to integrity-protect its logs in a CC-arch 
agnostic manner. And if that's the case, RTMRs may be marked RO ("X w/o 
W") to prevent direct extension.

The use of "W w/o X" is to support pseudo-MRs. For example, `reportdata` 
is such a pseudo-MR that is W but not X. So an application can request a 
TDREPORT by a write to `reportdata` followed by a read from `report0`.

>> + * @TSM_MR_F_R: this MR is readable. This should typically be set
>> + * @TSM_MR_F_L: this MR is live - writes to other MRs may change this MR
> 
> Why one MR can be changed by writing to other MRs?
> 

Good catch! I'll fix the comment.

>> + * @TSM_MR_F_F: present this MR as a file (instead of a directory)
>> + * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
>> + * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
>> + */
>> +enum tsm_measurement_register_flag {
>> +    TSM_MR_F_X = 1,
>> +    TSM_MR_F_W = 2,
>> +    TSM_MR_F_R = 4,
>> +    TSM_MR_F_L = 8,
>> +    TSM_MR_F_F = 16,
>> +    TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
>> +    TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
>> +};
> 
> I am not sure whether we need so many flags.  To me seems like we only 
> need:
> 
>   - TSM_MR_ENABLED:  The MR has been initialized with a certain algo.
>   - TSM_MR_UNLOCKED: The MR is writable and any write will extend it.
>   - TSM_MR_LOCKED:   The MR is locked and finalized.
> 

W/X are independent and both necessary (see my previous explanation on 
"X w/o W" and "W w/o X").

I'm not sure if there are non-readable MRs. But theoretically, 
applications inside a TVM (CC guest) may not need to read any MR values. 
Therefore, there could be CC archs (in future) that do not support 
reading all MRs within a guest. And because of that, I decided to keep R 
as an independent bit.

L is to indicate an MR's value may not match its last write.

F is for CC guest to expose (pseudo) MRs that may not have an associated 
hash algorithm (e.g., `report0` on TDX).

LOCKED/UNLOCKED, from attestation perspective, is NOT a functional but a 
verifiable security property, which is usually implemented by extending 
a special token to the RTMR.

> The TSM_MR_ENABLED may not be needed either, but I think it's better to 
> have it so that the kernel can reject both read/write from userspace.
> 
I'm not sure what a "disabled" MR is and its implication from 
attestation perspective.

>> +
>> +#define TSM_MR_(mr, 
>> hash)                                                           \
>> +    .mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, .mr_hash = 
>> HASH_ALGO_##hash, \
>> +    .mr_flags = TSM_MR_F_R
>> +
>> +/**
>> + * struct tsm_measurement - define CC specific MRs and methods for 
>> updating them
>> + * @name: name of the measurement provider
>> + * @mrs: array of MR definitions ending with mr_name set to %NULL
>> + * @refresh: invoked to update the specified MR
>> + * @extend: invoked to extend the specified MR with mr_size bytes
>> + */
>> +struct tsm_measurement {
>> +    const char *name;
>> +    const struct tsm_measurement_register *mrs;
>> +    int (*refresh)(struct tsm_measurement *tmr, const struct 
>> tsm_measurement_register *mr);
>> +    int (*extend)(struct tsm_measurement *tmr, const struct 
>> tsm_measurement_register *mr,
>> +              const u8 *data);
>> +};
> 
>  From the description above, I don't quite follow what does ->refresh() 
> do exactly.  Could you clarify why we need it?

I'll fix the comment.

Basically, refresh() brings all cached MR values up to date. The 
parameter `mr` indicate which MR that has triggered the refresh. On TDX, 
the 1st read after a write to any RTMR will trigger refresh() to reread 
all MRs by TDG.MR.REPORT, while subsequent reads will simply return the 
cached values until the next write to any RTMRs.

-Cedric

