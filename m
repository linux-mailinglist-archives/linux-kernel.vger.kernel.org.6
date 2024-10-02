Return-Path: <linux-kernel+bounces-348076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A898E231
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834A92811CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A2212F0A;
	Wed,  2 Oct 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bliSE8oc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10EE212F04;
	Wed,  2 Oct 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893241; cv=fail; b=KK7ln7J9yH56VXwGoUDZG0QF6eQPWo5gcOB2WEiSp1f7JXIXuiUV8m+WY8mRh4arL5UZ2P0NUi6b6jc8gfUIRvgkgpoPXiWOauiMQU0UzHxNg7mowE4xMBhxpqRhE3MD8tBjXB1czOSxpcjX88v/zteQj586GsbaP0HsFqHlIxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893241; c=relaxed/simple;
	bh=iW7fAoXUMuEIwVcFc7kNQuFrH+gfM+ILuABCcAbtHps=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mg5hQpwXoTeiHa0eqXCUWLwL8QANaibANBXfayTz7/+7lj0jYoly22gY4b/3L+V6q9uAaJqrduy5v5wiw82I88hRSSz6m9lPKf8FVUmlcrZzH78tPFbEY7u51FoxyNZqj2jOmiw9JIyANe0JQQMol4U9SKZ8yqUemYHWY3I67GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bliSE8oc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727893240; x=1759429240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iW7fAoXUMuEIwVcFc7kNQuFrH+gfM+ILuABCcAbtHps=;
  b=bliSE8oc0t+9VY4PX6dEGtL1Ss3LeRvVZXaGMYmh2mgtyfXb8Wytq/7R
   Hkq4w0oEUmPxyoCWXSu6OS0jZpmOzXV0uQ4aXtSQv5M0I12/Sce9BcRoN
   OHS8eFhX9uXOmL6/ncxgzkMRer+JKwvJUs0KU06iAbIGgo0kSlzLVt0my
   UKyqF+cU/+IQpjIwNZAKeqO+NPYSafvS9u94tEdejeWd/3Tn/IRJa9DEw
   Bjzw3hXhmolwiHayns2CfiWBYvpfLFlrFpHffpBIhdJklBqiv7giXKSJF
   Tspsdzm6wnpW9L8RyKsv9Tqar8OLc5VoV4s0WBnYhLN1UL9CsRH6ux9TL
   A==;
X-CSE-ConnectionGUID: 6o/7KF97TMicz2DOq7W2XA==
X-CSE-MsgGUID: 2fAR5dgtR/yr5d4s7ErGKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26957030"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="26957030"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 11:20:39 -0700
X-CSE-ConnectionGUID: eGelZtkQQCm65sqQzM6Oxg==
X-CSE-MsgGUID: B9ipfjfLRp6pRguK/9+QOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78618512"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 11:20:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 11:20:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 11:20:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 11:20:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 11:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIWSjJLQctsszUXj+BLt7IwtrodZ9J9zAFFGIplQzaTPjz30SBLIkPyZTNoR+FAxbsqfQqO4mwAs9c1s6eakeLwpltOJ0BSrisF64mJd8m6NfEBC5DojLdPhQDdxT79BUUOf+jG8YcMzDw9164tWEzygu/ErcP9vvxrtbmeq0mRs164RSQwhqieNVo+b1JJRlOFjQDd7e39bbkJDZmFCTt1fsu2bKMJqOWFzhfaWAHcpwtxkuJpBxk0J5NNFtJ6xVh3wIFdN9YCTZPmTfNcMIq7jykeGsKgYseI4qIe0NzabV7ZRVhT6DBGQyo4CFphGm4OBX3SL+f90AdJ9Y9UU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmZ4qIAEY4U0U3PD/2BW0+EwjglPfKkvjnNWRvTeT8Q=;
 b=EfgbBDNlgbIdd9s6Dc5JkHE9pWSgeCYf9K8dZxjAdaWHoyCRsYWiKzGUU8TpsKBgm132VF7yiSHHHDiUauzPWBcI5vJTrujBaHmOpMWao/2Uw+ICygJ4IdmsFqY7AEX1RFtYat3mD5CDMq2MqUOYqWnTnOG/+3vy2oREBa+RIHpVoOPorpvkgHWXjnIT9yMLPfCdN5eWPb9+n20GS6O/HvF755Cqu1tv9jsOsviphCr4mjI2VA0RIfvsqt+teRzwDj9xN/N0pinzFhXHb/+gJ1jG4TFUtBhw2gaXpQUE+xbULuXrVFpAA3DAC+79/Ros+iWoNJukTKriGCqvvK4HlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 18:19:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 18:19:51 +0000
Message-ID: <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
Date: Wed, 2 Oct 2024 11:19:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1725488488.git.babu.moger@amd.com>
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 4453aeec-2ff0-4854-30f7-08dce30ece9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjMrNkY2ejFRNWNyU0M1YUIvSkI1NjZZcE5XQ3c5ZGY3MDJnRXZnTnd4cEJt?=
 =?utf-8?B?Q05qVjVvY2VsUEh2b1AwNDNhdlRRS0QzSTRKSSszTlZBU3BqVEp6RThzbEFK?=
 =?utf-8?B?dGZFMXkyeHNucTBtZUFGbUtnT202ZDVmL1VNUDY2OHJTVHV6UkNMVlQxV3lN?=
 =?utf-8?B?aStoOUVGR0lwaitCdFFQNjlLZGR0cXB0WFlmNTBwRkplQjhKaUxXYldhV01B?=
 =?utf-8?B?TVZ2UllQMGwyTkErelR2Vy9ob3FCejlYMURFUmxXUkUvSk9qdlFhR2VJUFdk?=
 =?utf-8?B?SS9FRjlCUWR4KzY3QldaVGcwNFl5OVZubStXeTZOaFFvV2NyV0hkT3ZoNVZG?=
 =?utf-8?B?SDNtdnd1ZXFKZm40YVBqdEZYNE5Yd0czUit0UkYyN096cmY2a0gwL0ZYYVZz?=
 =?utf-8?B?bHAzV3l6OUU2cUVmRHQrWmFxWU5XSDJRQ251S1ZIa3FmQjNRKzhML0M2Snl6?=
 =?utf-8?B?YktvRW91MHhVa3kzSnhKV1F4YUhLRTNtQ2VhOERXRjhvYlBnSXlsK1o3NWd2?=
 =?utf-8?B?cDk5bWk3TlZXTWZ4eFhmN3VZWjZ6T3Q4UDBaOFhSd0tTeUY4aWE3cnl4ak5n?=
 =?utf-8?B?M3h4TTNSakRQUW1pMGJxdUYwNU9PbHhoam9HZVZPb3puWVZrdTVPOVI4d2hx?=
 =?utf-8?B?NFd5cVRWTmxRTmwxYmtkc3VtSWt5clRQcEoxN3pmTUNpR0M5QWpCRk1sOU9U?=
 =?utf-8?B?S3hSTnNuTUVOTDhGaXlQckdsZTZDd3dwQVZIZXFnd3NFejRWS3BGVmhMTnRK?=
 =?utf-8?B?T3hvRE1FTkUwbktBcitzVTB3bCtUTVJLVHhvSFRRMkpxUUVhaVFya0MyYUQw?=
 =?utf-8?B?RDVKNkNWSk1MUmtvSE82UG02YUxaK2grVjNLYkxYcjV4RnRTMGNLWnhYcTVW?=
 =?utf-8?B?V2JsQUIyNUJ6NDZkQVdkQWYxVE94SFBCVnNHbTJSOVEvNXRrR2xmMk5IQ1J4?=
 =?utf-8?B?eFY2cXdadEFFS0FQQzIrQjRhS0RCNkRtbnlLK0xQWEsvRThtWkRJWXUwZWIz?=
 =?utf-8?B?WTBGdGdPMS9qRmtHcmxsL3RDdVltcmtWeWwyV1V2SlRnOHRESU9KZ2N5WmQ0?=
 =?utf-8?B?YXIvVkVBM2hodDJoZ3FlYnBVQXlTczREZVlmU1NaOU9GTlkvbkcrOVlQMDhG?=
 =?utf-8?B?a1RRa0VLTWhoUlMxZXYrWDJTTXJtd1VGb1R2Q1IvaXo0Y3k5dndwT3hhZGlG?=
 =?utf-8?B?RXpqMGpnTGdmSTN0R2l3ZXZVVkpydXl1ZGViTHAvQ1kwZ210Wk1TK2lCNTdk?=
 =?utf-8?B?YzZJVUtIbHBNZnp2L290ajhFK3lCK1NLVVg5NUszT1dxMjRHR2ZacWRmdmxN?=
 =?utf-8?B?NlNXZGVDeEg5NldDU1E2RnBHZDBRUk91dUZhVVFybEEwMHdIVVQ5U3ZjZDNZ?=
 =?utf-8?B?S0tCQjRZTkVRQnZxYzBNTGVJQ1lYR0lwR3hEWDdaTmo3cVBtLzNFMFVwbXJn?=
 =?utf-8?B?YjkzOVN6TFkrUkJ3WW1selRZRWFmQ1ZDbGJzS2lablllSmJBc0hRQjBxWEN2?=
 =?utf-8?B?dGZ2UTYyVzQ5ZExMMktGaUdyZ3RkdnRyRFhCeGVqMTZuaSthd1VmdTlXYTFl?=
 =?utf-8?B?UFdlYjFKWWsvQjZvSTdaUlc5UXpFVS9RVFZqTTdPNjRyUjVMZFp1ZVdqTUth?=
 =?utf-8?B?QU9wdk0vaHNRZVd0VExJNGVLdS91bHdSNFlNNDZQQjdRZFdaYWRxTklRZUdu?=
 =?utf-8?B?am9kZ095d0htV1VGN2twczg1UTAyaDVlenlPRStlNko2QlBnNXhCbTdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3dDTlJrbVYyOFgzUW9GZW41N05MWlFIUndkN2gxKy9waDdvNWdiOHdPeXA2?=
 =?utf-8?B?dlE0WlNsTEdKYVNMYjRlblhHNUpMZXBBRnNzNFJudCtKSi9RQmQwYVV2MXU0?=
 =?utf-8?B?NUt6RkRVcTFNZlpIQUJCeEUyMG9MZjZIZDQvTXpPSXlqVTZzWU5FdlJzWjI0?=
 =?utf-8?B?RWdHVEhpZzZlQUY0S05VTkhzcFJkOGlBcHR6S09nQ251blBhWjFPeXpndkU1?=
 =?utf-8?B?OEpIcUJRNVc3Zkt1ZEdzOGhUSE40VHV3UWVrWnBmcWkwL0tRZzNtQW9ZY0tT?=
 =?utf-8?B?OXJMQjMxeFppVTVwRzJKQlU4TUFHQ2tjV0p4clJDQzdWM0JFR0k2OHRQZ2Zh?=
 =?utf-8?B?dmRuZ3BJMERkNVBoVjI1U1VzUCtPbHowNUxJV2RSZUdYMDFrZzNzZVdSOHd1?=
 =?utf-8?B?VTN1MWZlMWdtL3NFMVBJNkdKV3E4N3dsV2tiMzd6RnNzUFQ0SjRGekxHeGZ6?=
 =?utf-8?B?bDgwdGFHNitNLzM1bCs1d2d2Z0hRU2RYa3VXTHhvWTlHSlU5QUUvV2F0WFhq?=
 =?utf-8?B?bVVzUVRMMzliNGxvWWVzQ1NmNlh2SlA0MXNubWhNUDh3Um9PV0JJem5QY3RJ?=
 =?utf-8?B?UUJtN1M2d0FiellTOFlyOFBzNk9rODd3TkZ0T3E4ZlhiWUwyaG1RQTBsOVNr?=
 =?utf-8?B?M3lhb0tWVVdPWVlPRmFDYi9lUTlpZkJNMk11OVE3ZWlYN1NtWnpPZHByeGh1?=
 =?utf-8?B?eGZyQ2VCUzlRajlhamk2cyt4VWMySVFLM04vOHhpblo2Z3FxZ1JES1VlSnU3?=
 =?utf-8?B?QktqRC9LaHJQcHJSSUZNUGlqSnYyeC9RcWIyOHJSL1RNY1RjdTI0RzJVSkxv?=
 =?utf-8?B?Zmx3c0lHV1ZvZlpEaFlYUnJONFd6ZUFqOWxFTm5yRFRMbWpNT0pxV3Zmc3NC?=
 =?utf-8?B?dTBkU1N1a0xBMWxSZ3pyNWduczRKemdKVHNmL0VrTFVCTEp4clJTdWc4ajNV?=
 =?utf-8?B?VFF1SGw1SldicnJla2tqU2JVdXZ4Z28xT3RidDgrOTNONU85WjZ3SzBYTDYx?=
 =?utf-8?B?QXQ1cmFJVmoxZkY2S1lkZmd1RFlqL0N4WXA5aGtkZVFtQjRQMEFjYm0rRzk2?=
 =?utf-8?B?dDAxRHpUUDVXU2RqczdORTRTYzVOOWlGUHc5WHpqWTRrVXFGQnd5L29tWTJF?=
 =?utf-8?B?UWlDdEd5U09rSFRBZ1V6OVZkTWdwOFI4c0VWR2phOXdkVU1oZThaNGUycURL?=
 =?utf-8?B?aUR0c29BejQ1MGZCZlRmazhTRXgzOGFROGpNamE2cFc3K2pNelNPNnpqYWlH?=
 =?utf-8?B?YTRVYzdzcjRhdDFldnNsUEFNOUw1eS8rKzAzZVZNK20yNFBVc1k2VjN6NE9m?=
 =?utf-8?B?WjQ5YTU2TWp2b2MyTGNUYjU4TDNuM2FvbWx5enoyRmliRmJabVhPUzk5aXBy?=
 =?utf-8?B?ajdUS0VYUGRnRVlRZWpCT0xsN3pweVFhQk16WC9vc3g5Mlord2ZlLzYrYWRp?=
 =?utf-8?B?ellPbk1LMDI1dTRvODFaNGM5bVJCckM3Mlc4ZFdEb2VVNWlBQUpVVkgzTnBF?=
 =?utf-8?B?aFdMK3FJL1BJeU5KaFd1RVBKSk80TjZEenV3c25nNjFLYmZBNk8xSFpBeFFX?=
 =?utf-8?B?L1lJMU9LL3ZKMEkxTXFvVzhPTXB4NXBTWmw4bjdyeVVDQzNmWERFazZJSlo2?=
 =?utf-8?B?Tk5hSGlOR2lYOVRoaG8xSGkybi9yRDUxVFMxdW4zZTRGeDlOM0xJWndqSzJo?=
 =?utf-8?B?VHZHbmgzZmY5bmtCV2E2UGxwNGYrWWZvazVDK2tNTnZrNjhZU3h0a2hJRDl4?=
 =?utf-8?B?cjRFaStLazQ3dktIaG1uMzROanRWYStTblhoN21OZnhjdVNVVk1CODNlMmEv?=
 =?utf-8?B?TUNUTzQ1ejFNbVgzZXB2UjYvQldySUk5ek13MXpsU0c3OTBQNStjYzFhcVFO?=
 =?utf-8?B?dUZqRjhzMWVJS3FmRDR4UzFaaU1zRFp4azhxNEJXNC9iWEpTNzIvcmJ3Wk85?=
 =?utf-8?B?d3hWS3FSUVdSOVdVQ0JYTjN5bUJIQ1ZjNHAwaCtLcU44SFZXTm5PaTdycis1?=
 =?utf-8?B?bWRoMmJyWnNsZDJNM0Y5ZHlHWW5Rd0xTYzBaOFl2ajVMYW10eXZBRmtCS1NK?=
 =?utf-8?B?SHV2alRsQUs5ZXBweVJ6Z0MvZ1ZQM1dpVTY2eHJkbGtPZmF3R0FPMXJDclFZ?=
 =?utf-8?B?cm81b1hqNTg2d0VJLzd3SzlkWkVFaDcwTE9QMHVwTlJXcFRCblllTFBEZnpJ?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4453aeec-2ff0-4854-30f7-08dce30ece9c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 18:19:51.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceoHYvDzP39Ewm89sFGmkGJw3a6MHTjAH8YdfyeMeZxv3Mt0kJeeI5kUp24EQng+QzdlLZRZIdj8YGJO6VRMVgfW5yWuh/v6QfDlEbj8wmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com

Hi Babu,

On 9/27/24 10:47 AM, Moger, Babu wrote:
> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>> On 9/4/24 3:21 PM, Babu Moger wrote:

>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>      Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>      Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>      Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>      Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>      Removed ABMC reference in FS code.
>>>      Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>      Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>      Users have the liberty to pass the flags. Restricting it might be a problem later.
>>
>> Could you please give an example of what problem may be encountered later? An assignment
>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
> 
> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
> 
> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.

The last sentence is not clear to me. Could you please elaborate what
you mean with "are assigned earlier this action"?

Reinette

