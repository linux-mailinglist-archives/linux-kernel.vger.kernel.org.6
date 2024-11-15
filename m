Return-Path: <linux-kernel+bounces-411498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B99CFB17
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D6281996
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9C19D8BE;
	Fri, 15 Nov 2024 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Po+NceeY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C74192B76;
	Fri, 15 Nov 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712895; cv=fail; b=R6gUffjETylgL1wtFdrDAmXiiDt4LjVyX7j8dXY2xqWu8s8t4eUhPubnTIEDW2KOluy6LbqPRSFZhpNk6jgDq4ySFq+RmmC3oX1NpLTNiZ9V3EER0rVmxnRNf7lkSUAaLXuGXc/slOXJOTXY8P/JFMoSQLL5V5WPO7bwEAFjytY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712895; c=relaxed/simple;
	bh=Rm4KL9bMiXb71HFQfg5VCW4Xb3HwOFh+ZbRmYAG+CQw=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtFTtUOvskrUHUVhpjzFJMqCKu/y/Z1xMlFztxxefj0EVzt3LJGxTuQdgm/Xpe61QTjwf7tCYWJJ69slQQnZ9vXFrbYnWIdA/yjKOz8jyGge2pOkw9GDX3qqIX4XDy+pQUq3yOF4uzUfQ9c6FH3l3IHRDzONFVxhsoudQ1stkeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Po+NceeY; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731712893; x=1763248893;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rm4KL9bMiXb71HFQfg5VCW4Xb3HwOFh+ZbRmYAG+CQw=;
  b=Po+NceeYYCUcMG7V85Pslm45bBOobbmtudvSxmYMugev7Of9AY2Ctpiu
   +U5Fs0PlBiRDy6NFwh7T/ijZp7WfXtOKn6rlX8mZy4jUkg+9AFuivWmhI
   7uN/IbcPhS9qTX1OnDRV68+9wEE9ksBxYgNtxDu7I7IsrsRxDrxaBh2W5
   b25BGGaLPTDUDyjaMDm5Z4KmVLqiv79G/e5DtHluo2hf+wxUN7TP4aTdk
   t8mLY3bRLghhszATuXw7zUHTsn2mSzgnNQK1/1ujMNt61w4D9lOjkBmyU
   e6X0bNEQHXuhVfOwjUuCAcXR6HHBgZE8dnzy8BDrLwgUMk0mu4D1Yusw5
   w==;
X-CSE-ConnectionGUID: X0neOG2oS9eZ6SE5XDyxQQ==
X-CSE-MsgGUID: q9GTUnwxQwe55YuEQ7tZ2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="42383410"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="42383410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 15:21:32 -0800
X-CSE-ConnectionGUID: aT94N4ntSNyoPR6ctxQYAw==
X-CSE-MsgGUID: hPywPPT0RzysKSrE1f3COQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="88453536"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 15:21:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 15:21:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 15:21:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 15:21:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCp1xdVKD1breoyclzLGBFXubEoMl1ZlfTTYEdVwMHQNC6VFmEwFrSXTesA/A9maEcT8XE42cX5v2FIJjzMfQdQVDWo4PYy/+/mJO4JF7EcgO8b6MaYg0rwMZ6qwV3+aOkQOowg/XZiZkX28EBRrgjBKwLDCnNwpK1NWCj6WoG0twWQ6Fm2gSyx0CMY37NAfIC+HK6fnAzHYRMOHf6dJnVukX66kKJEakIHdjb+zsdQO3IP/sZlQGGo4l/j+gwExaZe+s0c/3gGwVRG9P/kIIP574rfU2wUcD/peHCnDeaB4X9Uxu3isP+ZEXhFW8j1X1EzuQ0v9uQgzspRiRZmRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5H0/T1pgSj8dOrUFUAokmfQXVaUCuJ3Mo4EOaGd1h0=;
 b=c7SW9g1cOCnYHMDFx9XR9QdMGtKthKEgP4MbfdsszhOm5z5MZVTFDryJfOoGf6vFJFFX11cs9cVkLeoyNK3Gd5KduUtRcGgdkYsYVumlJhNXbJXD5XE/QhdbgNkRO8OgTmCfSbO6xJJEmdTQtrp8m6GNaMBy/53IZe8R+4saulHW01D4QWpvKaSPgIHiW3zCLO7YNPr2wB42mWSpi7OOkKeepiGcMU9+DxnFyprtB64HaXWYxX6MCPi9Xmr/Q0AD6/E56JXmY5FLGB0SQyUQZcWQrG+w7R+7VLxL/ydhxmDiEiI1tM5na6jVlCv3smItyQS38vYjijQqCCjwXm12dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 23:21:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Fri, 15 Nov 2024
 23:21:27 +0000
Message-ID: <55bd64e3-50ff-423c-ac75-e25f2e1c9ffe@intel.com>
Date: Fri, 15 Nov 2024 15:21:23 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 01/26] x86/resctrl: Add __init attribute for the
 functions called in resctrl_late_init
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <2372314c135882d233eb8dba69af7c245efdcc8d.1730244116.git.babu.moger@amd.com>
Content-Language: en-US
In-Reply-To: <2372314c135882d233eb8dba69af7c245efdcc8d.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bc9d3b-0602-4c0a-a9c5-08dd05cc3a68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjNFdUxXMUtTOHRjZGNadXZsZllsZklRbTB2NCt3WUNYTEUyTlZKd1FxdGw1?=
 =?utf-8?B?YmpNcThhQjl1VDFMNUZGdE1kdDFIM2xjUEwyeHRET2dEQTFuSGR3ektkTWNn?=
 =?utf-8?B?LzdoZ2NQdWx5cHNhWlJpdy94Um0zTzFSR0ZaT1lMUUJVQlg1UlN0RDBqY1Av?=
 =?utf-8?B?dURRSERwMStGeThIWnZOYkZqWGRkbDF0VDZXd05yK3p6WjJWS3ZsWVVzWVk4?=
 =?utf-8?B?NEpzN2cxYU5jL3puZkE3cTlpQmFXeVViYzR0Vk5NZm8rWjdjTVhYNUY4WnhJ?=
 =?utf-8?B?aEJwV1A5OElXM0ZpK05WZUpQRGlFWGF5TDliZVZNZ2tWbWJmK1FPdWNyd0Vt?=
 =?utf-8?B?K1p2T2JjNm9lZnA0d1lxODljMWZRTnAxajBDS1dVZ0hrNmw5UTd4YWRDWFJB?=
 =?utf-8?B?N0lxRGlyaDJlRmdneFZld3lvRGw5YXcyNWJaYkJHcm40QWtOOFN5SEZTd1Ur?=
 =?utf-8?B?Y1BNUTRpNCt2Q3VZNjV5VVhnNmZ1bnd0b0FuYlVhbzNadytKM3ZQNzgwQTU0?=
 =?utf-8?B?RW1ueExKVTZPWkJ3UkRrVk85YThCYk5OVWsrZnFMamZDaFNWVW43aGEvVkt6?=
 =?utf-8?B?eE83MFhtc0d1Mno0UTFQUm81dTBLYnhtZkZIZVl4T29zUTk5dnpvckp4UmVG?=
 =?utf-8?B?ZHFnREpBeUtJR0EyZTN1Wk5ObWg2WlY0UldiVUNVV2ozM1BsM1cyM01PeWNu?=
 =?utf-8?B?RkRYSTFNTjdoTDlwNHFReUxpcUFDUzIxall1cGhLN3VhMFFEVFRlSlk5TWVK?=
 =?utf-8?B?YkRNdUcxaDlrcGM1SEJ1blVSbzlkZWVFNzh0UjNsZFNCWlFVRkI3QlVYUTZG?=
 =?utf-8?B?eDg3MGwyVUl4ZU1DZDNUREFQeWptRWc2c21GZTFLSHBHdW4vNDIySTJJakJu?=
 =?utf-8?B?MXdPSi8rYlpvZkNrSnB3VE1ubi9iZkZDcGttVjg0OWdzM2oybHNXN2VjcmY3?=
 =?utf-8?B?QlNTWklMbngrU1hpbmorQWVYTUdOWi9HcUxrNFpvbGVqY2s0UWwzTHV3QWcz?=
 =?utf-8?B?Y1VEM1N0RndydlExZ1lqZ1RsOFJnTVJrT0tvVnBqeEZlSm5aSHNTTlBtcXRV?=
 =?utf-8?B?ZzlidnRvS1k1SG9VUXN1RnZ2T3ZyZUpWZlR5QS9iWVBPTXlLdm9NeHltYXU2?=
 =?utf-8?B?TFM3bWthVDhZMTltMXhIT0VCc2swaWlIN2tqeUJQY1ZrSTJGL2VRc1ZHZVhC?=
 =?utf-8?B?TEhhUG5zaXBZczVUMk9lc0trR0tyVTBKSytsTzJBWndoK1J5Sy9Ja0JtTWFO?=
 =?utf-8?B?dG14c29jYWNIOGhTQ2h0aVlYOXlrdnBNcEJsQlB0cG9WVHhQRjB5cndxZEtP?=
 =?utf-8?B?ZmZmVTdwRUpNeUw0bzJDZ2tvMFhKT09zS0c3d01ZSzUrMEhCckkyK2kxMmZU?=
 =?utf-8?B?S2xQS0NCWlFvckhLQWRzQzNzVjVJTUg2eEFwbkFISTlVdEUycHpZRkY1YitR?=
 =?utf-8?B?UDg1SnU5c2R3bzI1SHZORUY4eWx3cFk0UW9pNDVZOGRYRENBNnlRM2hOQXN4?=
 =?utf-8?B?NlRWQm5PcklWcDQxaDEyRFgyS3hqNWRwZzVSb2xRSUpPY0hWY1plTysvTm4r?=
 =?utf-8?B?anNIY1FTQWUzOFB5OWNRbXdabTlYTzJjemt0TUNtc0Y5WThaOGhtK1pUOVp0?=
 =?utf-8?B?blc4ck1sMndPSGNOWEY0MUlLRzdOVXd2bmFJd2N0clVOaHFWRmgyVEhRWjFz?=
 =?utf-8?B?eC9GZDdENndBMHJKMzlGMmROM3FKdE1JOUtFSTdNbnZGRnVSUjg5Vm1CbFlX?=
 =?utf-8?Q?bw9DShiPPRnYAWXOkdmo1rc/zW69Q8XO8hWsBz8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU5ESHJSbXJpcWFVRzdla1h5VkxYRmtrdzlXRXZpOWRWbGNmbTBRUUFNd0F3?=
 =?utf-8?B?Tk9WVTNsdFZiTUdweUFSUXhDdU9Zb2FtQnVkcDROSE5wNDZBWmRFbHhyanl1?=
 =?utf-8?B?YzBvZzBiVk1sRlJnaTRyR3dlTkhFQ3NxQVUrSk4zNS85SGhaaDMzUkE0L3Z4?=
 =?utf-8?B?b3EvMHVQekxPbnVuM2w4ZHhVSkg5M2dkVjVuQXBjWmhTNTlQNmtlNURWb1hx?=
 =?utf-8?B?WWI4L240ck1YUUxYUUhnY0xOSTVGdkNpdzZLOU5yd2JuRVJxQzdYMm9sTXcx?=
 =?utf-8?B?VHBRRnkvTTFmcHplUEIxbm51anFTUmxIVm1sU3R6QUtqVWErcy9nczVxU0Ro?=
 =?utf-8?B?WUd3V1ZGVzhtU2hjeVJONlZsb2dLMDVTWlZNRHFPNHd3TE9pVHlOT2ZkMDBT?=
 =?utf-8?B?QmRBc05yNU9RVVdzMkJ2aTBTT3RUbTBmWUhETVh4YzAxTWxPeGVNZGYxUCtt?=
 =?utf-8?B?dXZ4akh6SDc4bGc3SEFHeTRKQlo5dTRlZHp1cjhQWkxiT3h4WFQ2RjN4QWti?=
 =?utf-8?B?UWUvdVRxMlJFV0R1T2l1L1llWG1NMnpxZ25WbE5XMDVmbjYyUDU4QjJFY3M2?=
 =?utf-8?B?WTJKVWZrVEl5Y3dOY3Vubit0MGtSL00vNVQ0VW93MXlWOUlkZVBGM2k2SHVS?=
 =?utf-8?B?OStiMlQ3QzZ2Ry9QWXdCWU4rcDZYQVB0S25UTDFHdjR0VU1SSnBSV3RDRGpU?=
 =?utf-8?B?WFFVT1FZT0hBTlRnbXprWWRFNVBabGM3RzlOZUdPUnNJbXgrR3BzZ1lZeE02?=
 =?utf-8?B?L1lrSERpT05yU2xVbDZaOU81UmNvTTJiWUthM0xNeWhUWmdOYmo3VXJ5bWpr?=
 =?utf-8?B?ek1LMDFMUjN3RkpMWXZTcVBITzQxQ2xZaFRjNVRoek8ybEFMRjJ2NXhJUTFv?=
 =?utf-8?B?Skw2TEtPMHBYZ3RFamdyUW1TdGFTV2JMLzYyS1A0bFd2QTNaVllNSzlqREMw?=
 =?utf-8?B?cE1TWW1qWUw2eUlXWExpSGs0K0hCNlk2N0YvNW5FSjkxS3VURCtGTzR1TVZs?=
 =?utf-8?B?VlREQmF6Q1ozTUxtN2lva2NuNDh6WFB3aWxBUittd1ovTEt3Q3VDMk5wNXhk?=
 =?utf-8?B?R2lzMzRuc2ZuVlRnS2dxS2t0RW05OUN1WVRqdHFONEFmRlc1d3NwaGQ1UTV0?=
 =?utf-8?B?UFpQb2d1N2pwaE5Gem93bENOMk5CUU8vaDMwV0hoelJLOVdsc1UreFBrUFJ1?=
 =?utf-8?B?cU92ZkFnMFRFdGh0UElTdHplYmtqV0l1NmVDU1EwVTBNaWZKb2FBV3NQMVFB?=
 =?utf-8?B?eTBUcEVZQ1ExUStJK2hoSVNmaGdtL3p5c0txMVRWZ3JjeHVlc2owQ1ZBUnVu?=
 =?utf-8?B?U0RmQmQ5V29HTlBXWWxrYmJ0dXBZeGVpak03a1hLVmx5WitFZlRKZm12TDlh?=
 =?utf-8?B?Y1Zpc3ZZb2hMVFlOeDVGZHlVMDhzZGd6SjRndzFoZzRrb2RIenZ5dVhHZmJP?=
 =?utf-8?B?Ums0WlAzK2VRQnRDTUQ4L3N3emhTR1FmVEFGZHRoVkx2THhhcHg4UTM5Zit1?=
 =?utf-8?B?Nzl6NDhWRGZmdDBFck9VVWNRQkRkQzZDcjhqcTZpckdXQ0pDWFIvNVBoSDd5?=
 =?utf-8?B?c09idUlOZEEvTmhaZWNlZzBKV2JycUxaM0U2VmZBRE1rNDFPOWFVQWt1M3hP?=
 =?utf-8?B?bGRsM0I3L1E0MDZ1YUo0UTUwemY1VXVlekZ4am9TckhZQzJjejAvOHRWWkdo?=
 =?utf-8?B?UjVkK2t2anhOek5YeEFLM0pFbThtM3lzTmZhRGt0U0NUeHhVTXc1ejF5dk8x?=
 =?utf-8?B?RXg4bitFLzRVWlZGNlBwcENtbEZnV3NXcEk0ek1aRE1ydFVZMjhJazltU3o5?=
 =?utf-8?B?RE56TkpHTzlZVXVyZ2g5eW9FekQ1SWpNSFdJRVphQ0ZHTVRMN2tsVUhpb1Ev?=
 =?utf-8?B?QkwyYmloZ01ybUhxcUNkalVOVi9HSDRkREVRQ2xBZHAxdVVSeHhMeE0wcVF6?=
 =?utf-8?B?dXpMK0FKeUg3L21IUFN5RG52NU5ZRG42aWIxUUNaOVNiMVNmTXl1VXJIYzBX?=
 =?utf-8?B?U0lqcmQ5cWUxeUcvVjZaeXliZXRSRnVQVFAzb2wyZ2k0dThkOE1neFZBdmQ1?=
 =?utf-8?B?RjFqdlkwV3M2MTJtKzU5UmxITU1HTjJiRmVBb05MbXAxU20rTGhMZFUzL0NY?=
 =?utf-8?B?b3BoMlQ3Rk0rUEJQNVRCY3I5WjcraTc3aE9TYVhSbkR0c2cyUE9SdmdBamhI?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bc9d3b-0602-4c0a-a9c5-08dd05cc3a68
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 23:21:26.9581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZn6z+sNBdN21rA/tSjwS1fE/h3KRm2ZbGXMpA2ZiD4PD1nXZ9yrPsjhxWo0l+L8q3nAbkEXiX+iep8ycmvchcpi1Mc10qzqRO8qr7h5YV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
X-OriginatorOrg: intel.com

Hi Babu,

In subject please use () to indicate a function, writing resctrl_late_init()

On 10/29/24 4:21 PM, Babu Moger wrote:
> The function resctrl_late_init() has the __init attribute, but some

No need to say "The function" when using ().

> functions it calls do not. Add the __init attribute to all the functions

None of the functions changed are actually called by resctrl_late_init(). If this
is indeed the goal then I think cache_alloc_hsw_probe() was missed.

> to maintain consistency throughout the call sequence.
> 
> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
> Fixes: def10853930a ("x86/intel_rdt: Add two new resources for L2 Code and Data Prioritization (CDP)")
> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Moved the patch to the begining of the series.
>     Fixed all the call sequences. Added additional Fixed tags.
> 
> v8: New patch.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
>  arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index b681c2e07dbf..f845d0590429 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -275,7 +275,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  	return true;
>  }
>  
> -static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
> +static __init void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	union cpuid_0x10_1_eax eax;
> @@ -294,7 +294,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>  	r->alloc_capable = true;
>  }
>  
> -static void rdt_get_cdp_config(int level)
> +static __init void rdt_get_cdp_config(int level)
>  {
>  	/*
>  	 * By default, CDP is disabled. CDP can be enabled by mount parameter
> @@ -304,12 +304,12 @@ static void rdt_get_cdp_config(int level)
>  	rdt_resources_all[level].r_resctrl.cdp_capable = true;
>  }
>  
> -static void rdt_get_cdp_l3_config(void)
> +static __init void rdt_get_cdp_l3_config(void)
>  {
>  	rdt_get_cdp_config(RDT_RESOURCE_L3);
>  }
>  
> -static void rdt_get_cdp_l2_config(void)
> +static __init void rdt_get_cdp_l2_config(void)
>  {
>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 955999aecfca..16181b90159a 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -627,7 +627,7 @@ int closids_supported(void);
>  void closid_free(int closid);
>  int alloc_rmid(u32 closid);
>  void free_rmid(u32 closid, u32 rmid);
> -int rdt_get_mon_l3_config(struct rdt_resource *r);
> +int __init rdt_get_mon_l3_config(struct rdt_resource *r);
>  void __exit rdt_put_mon_l3_config(void);
>  bool __init rdt_cpu_has(int flag);
>  void mon_event_count(void *info);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 851b561850e0..17790f92ef51 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -983,7 +983,7 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
>  		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
>  
> -static int dom_data_init(struct rdt_resource *r)
> +static __init int dom_data_init(struct rdt_resource *r)
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	u32 num_closid = resctrl_arch_get_num_closid(r);
> @@ -1081,7 +1081,7 @@ static struct mon_evt mbm_local_event = {
>   * because as per the SDM the total and local memory bandwidth
>   * are enumerated as part of L3 monitoring.
>   */
> -static void l3_mon_evt_init(struct rdt_resource *r)
> +static void __init l3_mon_evt_init(struct rdt_resource *r)

This change follows a different order from the other changes in this patch. "Function prototypes"
in Documentation/process/coding-style.rst indicates the preferred order is storage class
before return type. I acknowledge that resctrl is not consistent in this regard but we can
work towards the preferred order while keeping this patch consistent?

Reinette



