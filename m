Return-Path: <linux-kernel+bounces-519107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3981A3980A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9615D166C99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ADE22CBD0;
	Tue, 18 Feb 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDL8iFEZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02123198E81
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873002; cv=fail; b=TMO9ytXZfkM8yee53T6TPkeFPN8MztXJkl7tiuPRYZV7Uoxe4lbIyQJHZ+4RuD9Qg7zIEP9gIp2LcNlfMmOmTp2jk2twlt197A+VVGfaWWkOOQ4FfZp+2UOpst8/2nkjGcI4QTkJ99BgbmMSSwRUv0q0kC3eve+owgeo6uRkAsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873002; c=relaxed/simple;
	bh=0kXtDVlLxpCnN8eJMd/STjEKVl0iDfKkQbzQcCp69J0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yzz6TnGKM8T7fM5BFSAi3cqKStegPBdIS7LyA+hlH+MP9zZHT4dySaAZJsC83pVg2lzarIxJn/arK7GDsQnDlB+sXhIU/n0xZDglrZ6pXHWv+0MTWvgtaY9uhExQArDCbX9/7g1LWN3DHOoLd9bCBUDrLFju7OF3+P6JnQMV7gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDL8iFEZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739873001; x=1771409001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0kXtDVlLxpCnN8eJMd/STjEKVl0iDfKkQbzQcCp69J0=;
  b=JDL8iFEZW0vCBgP+jVSwggukHqNZbeVcjVbJ46xdK5d7vwR1YhYlLR26
   NHwX93GbM7Ir/0kMZHSXlgiYQZpRtTRLs+ir7EZXcDdD1jAqhXNVQ+ab5
   ANVAG1CpgufTZnEF9ZJgUTMISqhFKyHxbDUxmh+XBES/rqqBsBBK0/vKI
   GBmonUFxXOn68CNH36pB9sHVXn+TV/W4xRvT0Yhv3NPNaQQN6BkN6rLLa
   OlWxuJMoElKNxvpuYA8X5wuNTdFvrLxb47UcwY++3wgE6B1cPl4VkQshT
   SUq6aW18sj/joZ9oz3+bT5AC0Dch2fThWmvz2SeGHTwlqMLgz7kl3oev/
   Q==;
X-CSE-ConnectionGUID: 50ajMFwLSJuIlT9/nVlM5A==
X-CSE-MsgGUID: tOVPSzjcQZKgdYh2U7pdqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57966662"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="57966662"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 02:03:20 -0800
X-CSE-ConnectionGUID: HW4bBbySSbK/HgYqtbdqAw==
X-CSE-MsgGUID: jTdOfK+pQQCQUAH7u1I78g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118475469"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 02:03:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 02:03:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 02:03:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 02:03:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP2Zl/Ucty91pX9q00HPNmO6OHk7Md5Scvji/8zLo6czywb8PBCneOx7nhOavKDdTmogYBvf6FEop4mzvNnbw959SpFHm/CkChUoYbJZO/b9segrsH3SVYbQe1V5lR/GcLtB+VS7EwNVmgX/qjiB/Bbro3wgK5MJRR8oqKu1GwsvvaS1Wh17JZ/zCn7wo3J7qA+MWZY3hOXokjFRj27BhRnjJTkmGxTDULZwcBNYM4KQVNiRTtdRc/hPoz1Mgn2Sa6Wle9Jxep7XTZ+915BCsQQI7l1HT0db1v9VH3bvU48bn7aTq2ns4mUi9VBpLZ2CEPwwytnuoIy5kDHlBHVz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cs5OqAx/TNVJPwr4LuZvpcw23jQJMWm3msDxOaqHr0=;
 b=YMei3ibm9GZd1elVLz7pXTWnz+tkdWIF6sdc5e3pGo6144Eau8ckkzBGvXWEvmAlKD6AI5QY6FclPtiw5UofBUe5bOYK061ES3u1i9ihU7uycVDEW/zayqCx57UrzT74d4I50pMKyhH/tE5yPvsZxgTOwNjDtZD47nGpOAhPNhFSTUpOr2AUV24mLnbp2v+5lc/Sz+LcmTlB5cgGaxlvlt72lDJ9PdXIald6RoKilCH5U/HqlKMBPDlRKxjooxKc4dgFDSAok0lne920dzd55HMgXCmzLDFrThkj18zZtwXJCI+UiFIO6Rx3zw2p1tYuKvrYIkkbTCS/O6NZLbamEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) by
 CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Tue, 18 Feb 2025 10:03:16 +0000
Received: from DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::f97d:d6b8:112a:7739]) by DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::f97d:d6b8:112a:7739%2]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 10:03:16 +0000
Message-ID: <06eff380-a386-44d1-9115-33a08c2d8c95@intel.com>
Date: Tue, 18 Feb 2025 12:02:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/vmemmap: Use direct-mapped VA instead of
 vmemmap-based VA
To: Andrew Morton <akpm@linux-foundation.org>, "Harry Yoo (Oracle)"
	<42.hyeyoo@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <osalvador@suse.de>, <byungchul@sk.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<max.byungchul.park@sk.com>, <max.byungchul.park@gmail.com>
References: <20250217114133.400063-1-gwan-gyeong.mun@intel.com>
 <20250217114133.400063-2-gwan-gyeong.mun@intel.com>
 <Z7QaPwI1eMPEwHii@MacBook-Air-5.local>
 <20250217214342.33b4fcc4e775cf5ca70053a0@linux-foundation.org>
Content-Language: en-US
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <20250217214342.33b4fcc4e775cf5ca70053a0@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0102.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::31) To DS0PR11MB7904.namprd11.prod.outlook.com
 (2603:10b6:8:f8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7904:EE_|CY5PR11MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: c724687d-cc24-4974-c9c7-08dd5003764e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck54RlN2OHZxVGl1RjJORlBoTkYyNlU1dGtRZmlIM2twU2xYZVVvZmtNQUkz?=
 =?utf-8?B?NFZwTGhQSWtXU241OVBzdjA4TDFQWDhKODNNYkNQSGpIeGdqbURKZUh4UGhm?=
 =?utf-8?B?djVZWWM4SzZ2WnpMeGhBZGswOHJwWXdKdkZ3Mm9IcXFDbW5mUDd1eThaYjZm?=
 =?utf-8?B?Zk12d2U3TXlkK21UekpoRFlmNElrV2E0ZWZoVThqNkNUVnBGTnhQbCtYSXNz?=
 =?utf-8?B?WmVFYm9PaTcreVR5dEwzNXI2L3VVMDdFYnpENVFGdXRROG8vSnVJbllSdmxp?=
 =?utf-8?B?UldBV2lLWlJQb0pXS1czeHgrZnVuSmFwWkFUNHNuVW4vVWxoakNMNW9PdnNz?=
 =?utf-8?B?aVFWdElZU29QRURlSlFpTVQrNkxzdEo1SHB0L3I1QUNZYnZvUVAxNVh0cmNz?=
 =?utf-8?B?TE10a3Q2a1dhM1l0QkdQV3BtMDUrNEhEclU5N3EwM1h5VnV3OEc2cDZVb0Nz?=
 =?utf-8?B?UE9wSFVOcHpwNlBwbkRvTEZhWVEzY2dxSXl5TFhqQ1luRnJSMEJ5bExDRTk1?=
 =?utf-8?B?d05pZGRyQ2tndWs1dlUrL3RiRXVqcFRwcDkycnFJb3hMM21kYmpIR3FtbnBl?=
 =?utf-8?B?eGNibjBPejZtcmwwaGpIbFFwZDlaOUZ1NkJGdmFMMW8rbjltNUNJeDFyZGZG?=
 =?utf-8?B?VjF3MktUQk1Hc2M4TzVHVjZxbFp6RW5LbmJ3d2luMmt4WlZNNGdYNzRyeEhk?=
 =?utf-8?B?R3RqdG1WZlVoVnhBckxlRkliN0VVWnRGRjhOaVQwWEhmL01WNXM3MU1laUpG?=
 =?utf-8?B?NXZ6cG1SOWRDZmJXVEMwZ1NhVDhTakM4UzlreFpDUGd0YmgwQ2RoU0d5MHBU?=
 =?utf-8?B?YTJqYmNKK2dvZUJKbW9ubnhiTytwNnlqbFd1N3N0ZE1mYU5TN2F4N1h0cFVi?=
 =?utf-8?B?WUtkeGtxcldOZVVPcXlTMjRZd09pOW9keHJFVkNmN0Y3UkYrcldyenRvTHN2?=
 =?utf-8?B?SGZoTVNMYkcrdHF4TmFPOVFKOGVMV1pFNm9SN1l3ZE1SY2lDRW9qbWRhQmty?=
 =?utf-8?B?RU1DWU4xbk03cFB5VWZpZWF0aTVwc0RNRzk5SGhNaFZQb0FPNFhsczBtRXBi?=
 =?utf-8?B?V0ZWZ211NmdQSGFSUTR0d2hBbzRRMWtBSXJOTkFwWnluQUFqNjBqNG55c1BM?=
 =?utf-8?B?aS9SZnp3WDZZemttRFhjRFZ4YUIxVEJFUm5CMHdRcExxb28vUlZ2ak1tREQz?=
 =?utf-8?B?VitXK1ZmbDI5d0U5eURtN2pybWlmelN5dm5HRi81bUdVdTlPNTQyTFVCaHpM?=
 =?utf-8?B?N2gyTE5ERkFxZGlQYWcvRVFIRXFHS09xMVRYbkJSSmhVTGtvZGY0Q2N6c0ZY?=
 =?utf-8?B?eXdyS29pNHJIejBxbzg3OW1OUldoS2orTEkxQnRBNlRNbi9KUmV5M0dNYW5m?=
 =?utf-8?B?REVNaWM3OXRRMzcrcy9XYUNBczdDcXZ4WW1YemRyS2lIdE8zWkRteG1GMkF5?=
 =?utf-8?B?WEZlMkFaVldEQUVWVFRreWgyc0JSdFAwUG43bnUrMXVvaysyUzRIUFhyMmVY?=
 =?utf-8?B?czVFa0VGNG96TlJ5Sm8yY21xWmczSUpzbFRxTUFIczdYZk5nanBRMnZZUS9w?=
 =?utf-8?B?cDVhYVBhNXJOL3NDWTd6emp3SE4rdkRWUTRpRFV1Wjcxclp3MTFIbFI1dUxk?=
 =?utf-8?B?ZDZRZUxDYjc5WVVJdG9pS05MeXp0K1FQRlR0VnpGREZZNDJYWG43YlhSWGhp?=
 =?utf-8?B?N0RQS3Ard0o3NncxWTQydzdYdHFoVkx5QU4vV2gyeDU4SnBKNzFZTEJtQWYy?=
 =?utf-8?B?dmxJemVqOWE2aGlqMnN3dDNVOW9PditlbEJ2S1RhTHEwTGFJbkFJV2ZhZGJj?=
 =?utf-8?B?cnRRRXRGR25GVlo3Y3BYLzRRNjlJbG1hUFNqbEpCa1N4L09RZWNIcnE5KzBY?=
 =?utf-8?Q?eZVlLuz5UGXX/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRQY1lFVkw2eXFGYXhnZUVpMmRqc2YrMUhYaFpzbHFuQlRERWl3YVBuZlNL?=
 =?utf-8?B?U1VWZmMwUSt1bXMyQ1pGQWM4a3htdmdpdEJQb3pmVmo0a1ZJK3ZuSFNIdzA5?=
 =?utf-8?B?ZS9oR1k1a21FeVhTY1MzaCtVVDZsT2M4bnlMelNlVHMxOEpBUnRBNFBXdFJa?=
 =?utf-8?B?ckFCeWRlYnJqOEo5Um1kQ0hRazB4NmZGdEpBWnJvMTRydGNad3c4cG1HOUF3?=
 =?utf-8?B?aUJTajRLOGZZU2N4M2h6L08yOGZua0g4K0VUdUlNRG9VSUd1clVSczI3R1BU?=
 =?utf-8?B?Z095NktZV0tyVlpPM3p1dmtaU2p5ZEcydGhmdDJhMzByVWpMcXNPS0JJSnRM?=
 =?utf-8?B?aUZEcEhrbEJOTEhNWFF5TUVEWTdaTEloVzZVUjliclU1eWRCWmJXeWY1RVVq?=
 =?utf-8?B?K1AwZFUyYUZkSnYvRGY5QWtsWXFmOTZvRUxHV2dxUzhKblV4ZlQ3aWNpeExX?=
 =?utf-8?B?RnBLM3UvdEJ0RFNJQ0p2aGx2d3ltYnVkNHFYa29WQVhBeXRVZlZHQVRDMEJt?=
 =?utf-8?B?MnZpaVhlMjhVcllGUXVGTk1SaW1Ham53ZjVRRWZLcUo5bW1iM0NLWTJGUzZZ?=
 =?utf-8?B?V0pzdVNPL2NsaU1CVHBXTDdmaHlIRE96VVA1a3VQczI1WmlYcDJzK2tpNklF?=
 =?utf-8?B?T3lJL2wwSk5vZTlOVk9hcFJJSnZlN3BuMTJhUmFSemsxTzVVRmhjSUdOdVQx?=
 =?utf-8?B?ZWZYYmxwWEo4SGVKTGJWMlNhazh0UVNwYTlJdEhwcUptZkdRNTFlZ1I2RFhm?=
 =?utf-8?B?Y1lidEVyeGpyaUhScm1VL2RiSVhEcFVlbytuV1FseDZWN29naEJ2cWFlb0dw?=
 =?utf-8?B?ZkdBUWVLVzEwNEpJaHZKN1g0RG9qNjFtdmFtSXA3QS9oaHVlWHRuMDJ5V0FN?=
 =?utf-8?B?MWNzejM0bU9KemJiSGZLZ0xJMWdZZmN1dUVzRWlZVHo3b1VxN1kySnVJWHM5?=
 =?utf-8?B?dHlFbnllOHJ6RFlZNDd4ZUJMMXYzL21XL2V1cXhROTZkQjRJalRLQjg1Z2Z2?=
 =?utf-8?B?YlcxYS9yL0JDS2NPL09FekVmbXllLzhlYUl3MU4yT0huUXB4NGpPWG45aGFp?=
 =?utf-8?B?S0QySkdWUTVmS2lMcWFHQmplNjJLRjQvcVcycS9XSW1WejlDcVdPbXRjeFhQ?=
 =?utf-8?B?TVpBVmplaHhuSHVLb3k1Z3ZYVmdXVUVidHpmcVBHUWZzWGZlQnFkakY2RmVI?=
 =?utf-8?B?ZXpMWXdrZ3YxRzEvaUl4aC92U3N6UlEvK0lJZFB4cFV1L3hsYnhTcEF1cEZ0?=
 =?utf-8?B?elRZU2JxMTM0YVo2ZFJ4THZlUlo1TVlVUjYzUmpPc3NGYWh1Ym9mSzlUZVlz?=
 =?utf-8?B?N0t3dDlmNU05d2huZWgzc1ZpRHFqNkNGMCtaVlUzRzBQUHF2VmdiUFZrQWw0?=
 =?utf-8?B?OXdTdllQUTc5bFFXcG1VcTRLMFFqR0pQa0s5VFBFTTZrVWRKQjdLODh4SnJa?=
 =?utf-8?B?RHVSMVB0TFgwQnBLbTJoN1hoQitLZDdwTDBqczlMa3g3Uk55dEtqcnl6OFRD?=
 =?utf-8?B?enVjbm9HU2RvNDdOczZRU0pZTE9lYWEzU3V0UERxeUtOWHVHT3NuOWp0Wmsr?=
 =?utf-8?B?MXkrZXI3RWdLQ2dqSzRIdkw0VzNtNkhYOGtvR2F6MXlxZVlOcHh2REpLSFFz?=
 =?utf-8?B?RWgwVWQyNU9OTUFPUVhkdUJPRjY4T2lUbFFiRWJLeHBuTFlyTGVZNkFYUDBS?=
 =?utf-8?B?Q1IvVmVJL3F3Ti9JREtzWmYyczgrT2g5dS9SY3RkYXgxbUdwZHZLTWllU0Ny?=
 =?utf-8?B?bi9TOHpDZ3hYajU4UXlYRGdORnBreHFNZDZaeW93UGU3QWJjckZiUy9HVHln?=
 =?utf-8?B?YTB3S0M4b1I1NzJqL1BETzRxdlpXdk1YMnVjSmgyOUxGN2FjQ3FwRXREcEgz?=
 =?utf-8?B?ckdiTW8vWGxVQjJibkdWOExSazRXYktWSDcwZFBMdUlxZjIza2xIbjhNTWZq?=
 =?utf-8?B?OVRpY2s5M0gycGRTNWtYS2hNYTNZSVN3RHlUMlFCcW5zeSs5aWw4NURvYUJ0?=
 =?utf-8?B?V3hTcUZnY1BoY05CcHNUam5qbHlhWlJ2QlZ2NUJLTWhHZGg2QzZRaEN2SGFh?=
 =?utf-8?B?b0MyUDNBWnhCSmU3NDNXamhlRjk4Qms5bGI0d2d2aEV2dG5KQ2M2a3BPUEtI?=
 =?utf-8?B?cnpWY0tUR2hOYkdFRVJZZHBxbGJHQVQ0dWYvdzBLKzRpM3FWRitjVGR0NkF1?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c724687d-cc24-4974-c9c7-08dd5003764e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:03:16.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YpIuxn3YtGxlchGOYrpqR/YgVYmNozvvQ69jmwdZdlYHEKrI5sxcBa0H9m5rJNH0h6WCBUZZvPKGhn9b+fvBP4p0K1NurTTpLUp0RJdlmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
X-OriginatorOrg: intel.com



On 2/18/25 7:43 AM, Andrew Morton wrote:
> On Tue, 18 Feb 2025 14:27:27 +0900 "Harry Yoo (Oracle)" <42.hyeyoo@gmail.com> wrote:
> 
>>> page table when accessing a vmemmap-based virtual address before this sync.
>>>
>>> Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
>>> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> I think this fix is reasonable without changing existing code too much.
>> Any thoughts from x86 folks?
>>
>>> Cc: Byungchul Park <byungchul@sk.com>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>
>> Shouldn't we add Cc: <stable@vger.kernel.org>?
> 
@Harry, I missed cc'ing stable mailinglist, thanks for point-out.
> I'd say so, yes.  For many subsystems, a Fixes: means that -stable
> maintainers will automatically scoop it up.  For mm patches they have
> been asked to not do that - such patches require an explicit cc:stable
> (the MM developers wish to determine what is backported).
> 
> An explicit cc:stable removes all doubt.
> 
> Also, this patch should have cc'ed linux-mm, please.
> 
@Andrew Morton Cc'ing linux-mm is also something I missed. Thanks for 
the mention.
And thanks for the explaition of the fixes on mm patches.
> Anyway, I'll grab it pending additional review and I'll add the
> cc:stable, thanks.
> 
Thanks for the review.

G.G.


