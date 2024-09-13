Return-Path: <linux-kernel+bounces-328878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E8978A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EE51F23F65
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27090148855;
	Fri, 13 Sep 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbX5tDaP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F946E61B;
	Fri, 13 Sep 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260774; cv=fail; b=Q+GEfWK7VUNxUBt/T5SO6d/WGkc5d2ynSk/TQEAkr5CC0fZaayA9NzzBh/7DDge7om1yNbUZsh9Wf0v6PNhVry1wuiP1OXKBjaeNITCWv1460k58wdzETT5w8HtR1vFdntwco2mqqA7tGWgn/jcOMEEIS/NWCjttbdfNcot1Zhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260774; c=relaxed/simple;
	bh=FnntKvtPaABZ4Y4rY0hoYcJz5GlfWKfbKh7iHsjtbSY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nINB+RMVCdGrmqWtJsNBhIFU9bEwvSpxdMl8MCguZg/oaXymDTdDWICQSy4SVulD8T7sYuBSQhAlNDiTr23Z7/QCwDElwhBe/DcOJQf31GYE7SiHfDPe1u1hBvY8z1avkX2LxEdoH853PTv8KWJcK6392ErTgVrTeO8jzdIpjSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbX5tDaP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726260773; x=1757796773;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FnntKvtPaABZ4Y4rY0hoYcJz5GlfWKfbKh7iHsjtbSY=;
  b=fbX5tDaPDDw4EGuuTgBoNn+VkJCyRKbnBSZ6tQB5PB6fY2EUhH71Pj1T
   HKw/4rjVNTwVIPMfUUIw6cnElGK51K9MkwuDEHriNhoHvBqfT78LZI8p+
   g07tRTLk1jT0mZ1XpgghsX+VvSq0TK5iDshmwlLTaCPPsfUfAuXacdBrd
   hby+l4nfWFG5EmWMSM/6kyxstx3C3DHzWqP9VH1LeOeneNZ4MWwxq+z8c
   V6JSosD9kQIYm6Bfg+/5lgWnn6dTHdZ3+imrQjM2fOKbGft+H91Jk3hYg
   OK5YeRDgEpY0g0LmWLDzpBbv8Fgq2x6bk7y/GHIuCB7DVHgms/M4m6OjJ
   A==;
X-CSE-ConnectionGUID: 57AKrEl3TGur53js3BUTUg==
X-CSE-MsgGUID: qsTHEVf2TQKAwHO8P0Si3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25112550"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25112550"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:52:52 -0700
X-CSE-ConnectionGUID: fWabFMl4Q6CpUAPcvnDTMg==
X-CSE-MsgGUID: wCgs8KgeSqSd62i07i3Lbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="67815675"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 13:52:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:52:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:52:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 13:52:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 13:52:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvtZfjUeOWAUNWR/IcOtvokuRzbO2mrEoS9nlq/67wCP7yxs9ifr3EXYlsc7HUnU/udUCCkCyfjTtqdB+/6HcgOVGL5EvbOPos49sQsSo/RiUxLepnybKJNjILK8jdeauMkFgPFA15t3xxmumKxXj4VhgpU8G+AEuCa+29g+RdeN5PgJ6vJ4zI2RzizZt4LyVZi0XZpr6umA/loxazddYdn4IXg+NgTS0GQ1YKfGF0vN7DdOr5qBRirlf5IXscbs5kSPCtNFeRtKaxrVT6kZ1U791WSlijA4U9HeuY0v0GR1A09X6n4QqUylMKvf26v8Wwxu+jMtmrbbanFBs5Xu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V15Cexsn5NDjsT43+QMGqSDPWsaL/6fUAEoDRO9iIo=;
 b=QyLnjXA2PfiOWtrUo1vzuuM5QA/E2YHLPQKZ0MFEAH5deVvmWGebXyEc7SoDhDefx/3pP2Q/RT5Kb+SuOXBiGnpaKVWYp7vGmGXCwvmGSh7OZ5tlSsmxlmQJYclKcVLhJtUczRQQUNqL556vj0H5QSHTRXLQAGa6aUsGmx1XcyyIyDMdRkYYlCHyW6EgaDn9zU/ilgZUwnBG++FP5ygYGHFFrBd69jx9TaTg42nuz69+BcU3KDeXrBbGmWxW0XOxNi+fy25ZsxeyGt1+Oeh3kgFKLR8DFgchAnn0J74rZJ22fP/mKBtOjFb4mkMmTGfuXhVJ2dgB227DDEKo/15HRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 13 Sep
 2024 20:52:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 20:52:39 +0000
Message-ID: <f1b98b0f-d2ab-40a3-87a0-193e67f345e0@intel.com>
Date: Fri, 13 Sep 2024 13:52:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] x86/resctrl: Introduce interface to display SDCIAE
 Capacity Bit Masks
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
 <52902dbb00069b4f6685835deab83748a7472b8b.1723824984.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <52902dbb00069b4f6685835deab83748a7472b8b.1723824984.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb19c65-1bfc-492f-9d99-08dcd4360132
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sko4cW9IZkk4ZVVGdzFrVHJtVFI4emRVSDVVUzQ3QnFmMjlTcXFQaGJqVE5U?=
 =?utf-8?B?VUR0dk9pY3ZXSUNKNW1UYXJFOGQvRUZ4Y0hlYi93Mi95QXlTOE94dGdYd2o0?=
 =?utf-8?B?WjZKd0hUMUVqS01JVVNGdG5aS2tCRlpEbk4rN1F6cjBPOHRlekV0UDdHY3da?=
 =?utf-8?B?WTlFUVJ2cVNCM28xV0dCWWR0anpSell1NXExVDB3ZGZjblY3YmhkZU0vZ0Zq?=
 =?utf-8?B?NGx4SGNPRzFETGRZTVFFWWl0S3EyUUlvb2Z1TUYzUlllaG11czNIbElUd01w?=
 =?utf-8?B?QVA1ZDUzUklDa1ZiQnF0SEdCUlkzNCsxTUxGMklSMUU3d3FTUjFKSUxpUTAr?=
 =?utf-8?B?OEl5RG5FeEN0anU2ZTZEZDRZRmtReW1JeXFlUWxOZEVlQTdpUEdIU3UrcC8r?=
 =?utf-8?B?Ym1aeVlBRDZ4Ri8xUHY0ckhGN3RGYUJ6bTZSa25aRXlDdDdtTllwTnVOQ1FW?=
 =?utf-8?B?NmtkSGZxR1ZzSExOeU14UkRqR1N6aUNidGg1N0xjTVZZNnloT0xVeGpsd2oz?=
 =?utf-8?B?UFFBZkZ5MnRaNDFKMG1YckNoOEtFUkppbVR0U3JmV2VGb1NjRzNIcUk3RGU2?=
 =?utf-8?B?SUVxcktOR3hCWG9tMkhtd09JeG9veTRjNTN2Vjhoc1BKYzdUUFR4QUo5bS9J?=
 =?utf-8?B?RGI1UnhQUzlqc0t3di9EWjl0VVlzeE9nTmFHdkNqeDhnNU5uS0VRQWwxUGQ4?=
 =?utf-8?B?NDhRWUhxNTVIN0lyakRyR08wNDlYa01CNVFPY3E1Z0RaUkpRbXQzU3FXSXgw?=
 =?utf-8?B?TW5tNjZwd002QlVsclBmZ0xNR0hDRlZBMXRSOWRQOXkyRE1zUmNvTWowbHRQ?=
 =?utf-8?B?UlpFTFArREtDOEE5TzN1YmxLK2paZWxBdWVlbXJValZUN2h0L2hZNW1UZkhz?=
 =?utf-8?B?VHUrRVZ1U2J3MXYrY0hYL2dHcFlWVlMwVDRwUnEzUVN4UnhGYVh2dW5Pczk1?=
 =?utf-8?B?UFRIOUhwaGI5YnBqV3dWbUFSTkpsbzZEV3dJZ1FGRVlRUWt4SmlkMGhnTUwy?=
 =?utf-8?B?SUNtaTQzQ1V4WXVFM0VRSytCOUJoT3hFQUhRR0dYSzNOVDgvaFBkUSs3Y2dO?=
 =?utf-8?B?SUZ3ZWhhUlBRWXArL2tURThtZ0pick9JeE1FcVFTa1pVUVBLeDd6aTFBQ1NT?=
 =?utf-8?B?R2pTYU1tZHIyS2V1ejZ3ZHc0MTlhc3pITWhjTDlld0I3Nnl2Y2grYnhhZlpq?=
 =?utf-8?B?OFEzWUp0WTJSbVNwL3dod1gydVlqeUdGbkxwU015bzNvYXFtMG1vUFA0aGlC?=
 =?utf-8?B?YkJXUE1oYjNSYWNvV0JzTktvM3c5dXowZTBJdDJKMHdHd3hRRXppQ1dtQUh2?=
 =?utf-8?B?c0k1TmNNVmVUWFlXZDdDNFBBdFZMYU4zUU9xSDdtRmhWNW1Sd1IxanZFTUZn?=
 =?utf-8?B?UFJheDFrYWN6cTZnWWRwSG5MWmYrbW93Z24zVzRlR2xPRHpDU2ZhWXZKalky?=
 =?utf-8?B?clluRXc1VU5Qemx0bHdtb0JkaXFLeGhEZWM3U0JFV3RzaDU3OTRyME4rbGpI?=
 =?utf-8?B?N0thVmdRYlIyNzlvYXJ5VVFuUm90ZHh4anM1ZWNwblc5THY2OTlOK0Jqd1R1?=
 =?utf-8?B?WFNQOE1zOCtJTVQzUkpQVVYvVDNSZ0IyNnk1T2d4dlJmdFNONEVXdlpIRGE0?=
 =?utf-8?B?VnFoVDdPU1dnQVJjbVJ6K3UyT1hxbStMZUVWOEJVQS9CVWd6bEFlSXdMSWVT?=
 =?utf-8?B?akVIcDZiZzJSbHgrNjI1Y01FWGRvQU4rOEhnUFBOTE9FSkNwa0ZOQ0dIZktR?=
 =?utf-8?B?K1ZURXM2bjNQNU15S2J4NUtRendwcEtlN1A1M29xS1Jsb3pMZW55V3BYRVVG?=
 =?utf-8?B?ekcrdWpFMzdzbVBKT00zZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJkTHBRLzNGVUdXclk2MDRnSWlOYkNtU245MUNjaUdXdFEyTUNrVG14Uk9L?=
 =?utf-8?B?RVdkeTZyWVJKSW51NGxEL0ZqblN3bFltbnFZK1hoS2srTDhIQWFKd3BiUmZk?=
 =?utf-8?B?MXBOUkk1ZitLTmp0Z1dWb0txbmUya3Jhc2ZUVXhYZTBKdmN5QnIvWmNUVG5z?=
 =?utf-8?B?cThUWkNJd1BiZlkveThpS2tFSW5ZbVlYcCtwTHJaTTdIV2RyZkN0dzdpaGpo?=
 =?utf-8?B?OU9aOFZkazhHLytVcmg5L1p3bDhsczZzSks2YVZrY0hSR2ltZHJtRHl1SDUr?=
 =?utf-8?B?YnBPSG11Z3kzdjdyYkZSeExNZFRUVkpLZWRZUVRuUGtwSTZqR2VsS3ZPUWll?=
 =?utf-8?B?bk1RQnl6UjFxbWVLVHpQeDR3NXNMM0FKK0RwRUxiL3NmZnRsck90OHN3S0JZ?=
 =?utf-8?B?c3BvVEM0TW9idjF3dy9uYnZVNzBMb2ZKNjUwTXcrWm80OTFkNjNmRzREUU55?=
 =?utf-8?B?cGhFOCtYZ1ViUTl3Tll6QzRTM3U1ZDlYMFB4UHl1MStzandzc3c3TkVnS3pG?=
 =?utf-8?B?NlAwdjhQYXU2cXNqYXNSYWJCS0NRWTBPWmFUVWRpVFJwYWRlUFBURWhOR0hW?=
 =?utf-8?B?SWdMNUw0c0FKUStMRi9lRXVYRTVnUXo4RUVUVjNhaEg5U1BhRlJGd3FDcFg1?=
 =?utf-8?B?aUtpSmVValdkMmRNbnkwNERVY1IrVDhLaTNNQmFUeHlaT2lIbUgyWjNKdDM2?=
 =?utf-8?B?U3ZVeFNwYm9VbVVZeDBJNGZXVm9HYWFiTFI4c1U1L01aUGJGQlZZUjVCSWU3?=
 =?utf-8?B?VUVHb1FUcVBHb041SFdSb3J2azBubEZrcDZrRHB2SVdnOEZkVU8vbHRCTlM2?=
 =?utf-8?B?Qk5DQm1oSGNqWlB6bnBid29Ea05VSlhzK3p3SUcwdGNCdEZsNFMreFpkbS84?=
 =?utf-8?B?Y1djSy9TakhJdWpxRmpPcVc0SzB4d2FlcjFmNUZzaFZ0Ly9pUllhTUphZDlT?=
 =?utf-8?B?bjJ4b0NXVG1nWmVRbnovWXovcGYrVlp2eEd4d2FOWDFLeVduQnQ2YXMzaEFH?=
 =?utf-8?B?M1B5cXExSDZtQWJkakpWSzJvdUViOTJkb2RpVURHbFZhTG9VR2NSZ1RHWnlU?=
 =?utf-8?B?akNtYWJQR0xaVlZWNWxKQ04vMUFYa1RqV0V1cG0zZnA4VjI4UzNCT2R6aEV3?=
 =?utf-8?B?VnJVckVTaDBPL0h5Q1pUUkVTS25TSTNRYWFnWElaT3pHZEVqTjVoZXNGcUpk?=
 =?utf-8?B?UzVJSWFsdDdGYmptdldSa1VzWFdZcXI5VnMvZjBvZ3gyMEpyTXVRN2paNlVF?=
 =?utf-8?B?VGlXNlRBNjF6ZGhBaUt4Qy83WEZkeHRlTm0zNCtoSmhpYzRJbTdjQnYwL0VL?=
 =?utf-8?B?QVJvays2OElrR0VCL216NloyY2RDTXdZT2pMYVV0cFdObmtZVU4wMzFNWDVR?=
 =?utf-8?B?OWpmeVFQViswUFZsR3hDSVdKTTh0TnJ5T0FKREZ6bE5OU0RjTUtLK1lzaVZk?=
 =?utf-8?B?VE1nT3E3eGpISlFHY1VaWUQzcEc3VEdoQWhpa1VidUVWdWpnMGw2MFd1cXc3?=
 =?utf-8?B?RmtLWkUwZEhUNHNoTkhKclhnQW9Ld0dOYjdXc2h6TmVtMHZCbVM5Z3NTbksr?=
 =?utf-8?B?VFdnaDhSYWJDcWVYUjZMOTZXYXB2Q1R6NTlKbDVBcFlpaU5WR2VUbmg3Zmcv?=
 =?utf-8?B?eVJOL1dnUmJVSzJhUnNDNEVYa29FV2NYcGZWK2ZZMFJFelkvdUxsQlQ2cUJF?=
 =?utf-8?B?SE93TXZYUm5uSjZ2SGIrWngxQUNyb3FmUXppdHE5dlBMTUJXejJmM3NUQ1BP?=
 =?utf-8?B?a2NjWDdsbnozcEdISDV0ZkFOcVVIMEdtaFZnK01NWm5qQVdjYU1MU245bUMv?=
 =?utf-8?B?blJ4ak5SMHNXc2NCNWJic3NlQngreFhQenFsc0tQZ0M5MzMrclJUaGtHckVO?=
 =?utf-8?B?TW16TGJUSTVPWE1ZL004UFJaOElDUW9vem1WbnpXWkpCaGw2azBaalp3eVpN?=
 =?utf-8?B?a3lTQlJVbE5qTFFwQjJlZStQL3JpcFpsb0lFcHRWMUNuamFTUjdQMGFaMGox?=
 =?utf-8?B?U1Rma0NTWStMWkJTNlhhYzd4dVQ4SnFtQUJNOXNYNnlVR29sS1pKNGI2L2s1?=
 =?utf-8?B?SEFBZm93OERsODQ3L1NkZktvNWNtUVRGM1dScFoxaXVPVHFCenNFTnFUc1hs?=
 =?utf-8?B?VWQrTWtVZW9GRE9FT21yaDg4bFhEVTJZbHJ4L01RUmkweW1wcUcyT2paa2tu?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb19c65-1bfc-492f-9d99-08dcd4360132
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:52:39.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIKc+JsEpd5qayWLW1qWGwJ6ciz763omuRblHytqx+Mfw7n63+Yfjn3tcsItJrNrXInA6wU1FmqAd00C8HEjBeqoJWtTucvqv3ZmFlv+CzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-OriginatorOrg: intel.com

Hi Babu,

On 8/16/24 9:16 AM, Babu Moger wrote:
> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
> partitions identified by the highest-supported L3_MASK_n register where
> n is the maximum CLOSID supported.
> 
> Add the interface to display CBMs (Capacity Bit Mask) of the SDCIAE.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>   arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++++++++++++++++++
>   3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..fc99f4d17e6c 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -439,7 +439,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>   	return hw_dom->ctrl_val[idx];
>   }
>   
> -static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
>   {
>   	struct rdt_resource *r = schema->res;
>   	struct rdt_ctrl_domain *dom;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 9a3da6d49144..f2c87ca37b13 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -663,6 +663,7 @@ void __init thread_throttle_mode_init(void);
>   void __init mbm_config_rftype_init(const char *config);
>   void rdt_staged_configs_clear(void);
>   void __init resctrl_sdciae_rftype_init(void);
> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 58e4df195207..51bc715bb6ae 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1922,6 +1922,25 @@ static ssize_t resctrl_sdciae_write(struct kernfs_open_file *of, char *buf,
>   	return ret ?: nbytes;
>   }
>   
> +static int resctrl_sdciae_cbm_show(struct kernfs_open_file *of,
> +				   struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +	u32 sdciae_closid;
> +
> +	if (!resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3)) {

(same issue with this file appearing in all cache resources, eg. L2)

> +		rdt_last_cmd_puts("SDCIAE is not enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	sdciae_closid = get_sdciae_closid(r);
> +
> +	show_doms(seq, s, sdciae_closid);
> +
> +	return 0;
> +}

This really needs protection. (You should have encountered warnings
via lockdep_assert_held(&rdtgroup_mutex) and lockdep_assert_cpus_held()
found in the functions called.)

> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{
> @@ -2081,6 +2100,12 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= resctrl_sdciae_show,
>   		.write		= resctrl_sdciae_write,
>   	},
> +	{
> +		.name		= "sdciae_cbm",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_sdciae_cbm_show,
> +	},
>   	{
>   		.name		= "mode",
>   		.mode		= 0644,
> @@ -2187,6 +2212,10 @@ void __init resctrl_sdciae_rftype_init(void)
>   	rft = rdtgroup_get_rftype_by_name("sdciae");
>   	if (rft)
>   		rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
> +
> +	rft = rdtgroup_get_rftype_by_name("sdciae_cbm");
> +	if (rft)
> +		rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
>   }
>   
>   /**

Reinette

