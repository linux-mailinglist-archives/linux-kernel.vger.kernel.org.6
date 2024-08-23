Return-Path: <linux-kernel+bounces-299518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9895D5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992E128354B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D5139D0A;
	Fri, 23 Aug 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0Pvcyom"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F918EFDB;
	Fri, 23 Aug 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439711; cv=fail; b=HzfDCBmfO40GCPJNqkmdrOs+wAp9JG/W7GgBzwHEt+ZfjtYvbj4jcjGXxD44N7Xmsjny7ojaWbE0P8djeqpRIZBKrYl/INNPZRPpvQPIJk0IRadXrpKtiUpCP0ZvDIvXXvWCZhgeqAMrQrLPqImhXzGKXjTRZHlvca3axCEWl7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439711; c=relaxed/simple;
	bh=iQ3EEGXuEaKnikQhh8+3Wj0tqQXWvTjK35Y0CblrRyw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ha3J09tshAk0iYbUg9vabNpzh47elD7wfucKC1u1PNTQNDQLPQ2pLNjaFzijEYZlzuC7MVi4c0yYFnhBsgrMBXahS0944tgmX8wilHArPJnQA7AssLR9uuX3+WkcN9v0O/BIfQnMI/7LwmXtms1uXkZBpGMAOGlhyYkoYxlLXK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0Pvcyom; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724439709; x=1755975709;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iQ3EEGXuEaKnikQhh8+3Wj0tqQXWvTjK35Y0CblrRyw=;
  b=n0PvcyomB1hbDCFODsJQVY1M5tlyAHh1R8c5u62x9AY9XNmYZzpjtiHo
   kVpjlED0jw/mE4IBDPHr17E2s8QmNMKc3LpMUbArMp6G83573vUgCVFc9
   pryJ/uwi8HRc9w2zZ6uBWWDRUVD3KN2d5tSWJ6C0bu4GKJA3Jzq130yRt
   nv43MZZdi/1ZKhn6iudWHHQ5aDP1oPmatT9AlsCP1AW7u2Y9u8d7asIeA
   FWOUi40tCEmsHvi7EcqSLCPelwBq7oDttO7+AuEEzCSOARSiLnN2MDtMr
   F/UaqAC+EM0yAT/H7m1S0NsOV7XyANagK9Aw3u6Xjmtk0oExCGMp2NbUs
   g==;
X-CSE-ConnectionGUID: wLAo+QjYR/etCSXk3ECvhA==
X-CSE-MsgGUID: Mb5qUiIJQryAbyc4MIxqrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33581387"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33581387"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:00:31 -0700
X-CSE-ConnectionGUID: dBZ/rVRyRO2o8occeAYQ3Q==
X-CSE-MsgGUID: K1Z/9f7IT8C+u9oQQZng2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="66582811"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 12:00:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 12:00:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 12:00:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 12:00:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 12:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=la1S7AvFDbpoNn1rmyWZTGmUg9df4/6T6/tP6Y/sxoX9KRND8ZAys0sxxld6CNfq7VXBEXzTczGkzgFl6amuA0aUDUiWu0JPi27/Ssb3/t4wX/WXK8dVxdXD1em2aZ9bJUPkWGpWTOjvyFpXLmM0r+snyQODNKyr7zMqCPMyTg71CdKO4ekcAJfL0b+dq/Rha6DjYblTQX8QzMQVhj2WLVI8fgqDOkJTNI7RTjwjIXPo4QrQElt8nCpiOqFCWf/EAywuJl10Ww85L/5r23LRY1B3A+l6vZ+V+XbnWfiYXC7JSiI9TDp9nc7qT55TGlKe9M45Quit8jsAn/osVZ6ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UayOKp7noS35zxxy7atfoSejKfK3fP9S2/HlCUpHwlM=;
 b=pIET1Qws1egZcmL0jRIJRsJR88uirAKofElcxd3uYnpqPCp5AfRU7ZwDblSSa3HulyBa3R8BVVUgiUjER2hSvuvTFHRL6rbWrZMpECbzvCNyBjv2B4qKudpNqjO0B3XktUND+k3u1CZs/HaqoGI688TZkiXtU5YdTXIz15+XlY5ZlC/kxR6OVo5Bv8LFz2hlWWj/5VPmIZIxq8bnEfsrb1MYO7sLIvqVfrTJeZijtUycd1CJLZlstt4sZHe8TxQmppLhOQzj7mEljL9JoBo2fdI/aoHIiNhy84oi+yo0TzzTBFw0s82JKoGRxKrrE4hpjvWi8V76xaJV4B5T00NSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5758.namprd11.prod.outlook.com (2603:10b6:408:166::18)
 by SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 19:00:29 +0000
Received: from BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::5183:feab:8a06:b19f]) by BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::5183:feab:8a06:b19f%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 19:00:28 +0000
Message-ID: <0073903a-b228-438e-ae36-3f7dc9b3f878@intel.com>
Date: Fri, 23 Aug 2024 12:00:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86/intel/ifs: Fix SBAF title underline
 length
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
CC: Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Shankar Ravi V <ravi.v.shankar@intel.com>
References: <20240823184337.2923179-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <20240823184337.2923179-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0001.prod.exchangelabs.com (2603:10b6:a02:80::14)
 To BN0PR11MB5758.namprd11.prod.outlook.com (2603:10b6:408:166::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5758:EE_|SJ2PR11MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: bea53dbf-d5d3-460d-383c-08dcc3a5dacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW5JMCtlMHFjNUlqTEJCU3BGcHVsY3prQUI4aXNRTGNBTnI3TS9VaU1mQkJS?=
 =?utf-8?B?OC85bitmZ0puT2hSeHBaVGRNQjlhblhCaTc3cStMN2NhU1Mwb0ZLTnlTNGNO?=
 =?utf-8?B?aXRhdGxOSjZoVnEyVzU0UkhpT0VtQldTVjlMNlFyMG16TmRxM0U4aTZValpG?=
 =?utf-8?B?NFVpOTlpNFBCWWdVK1ZRMzRIamIvSGFSZks0YUlHWFczK0Y5NGJUNzlONnEz?=
 =?utf-8?B?QXpFbldjUnlOREkycnR5YmVNanFtOWJCK3hXelYvZGhzZVl1T1VtYk85Q0xQ?=
 =?utf-8?B?K3pPZ1RCdlVkdEFsbXo2NHRYMXV6NkhKaDBHQUlQM21aZ3ZEdWxuRFlDYnJ4?=
 =?utf-8?B?NEY5aFJYVE1IVHM5TnAvZjkzYUYyQkNzQTRRK3B4ajY1TTdRQlpYVldLZUVm?=
 =?utf-8?B?VWR5dGYrRGxsQ2p2M0dHano2RXcyWUQzcTN4aVovM1IyTi9kSDA5OUs4OHhI?=
 =?utf-8?B?SERKK1p1aEhKaHFhT2poTGkwNE9xUmw3UXVBMUpyMXcrUGJzZGpLODVTZDRF?=
 =?utf-8?B?Y3RLWmRLMXBkWGZZOUtDYWJxL01rb1J0U05LWEZJZjRKMGV4bjN5T2V1enBP?=
 =?utf-8?B?bGJ3ZG9xeUVyd2t2eE90ZTdYbU1RenpGcGlxOThKVXNDdWhKUTZTZUVZTUdH?=
 =?utf-8?B?OURDZVVkYysyaVY1dFlBbllZOERNSUwzMVJRdStpSU95Yjdpb013NG1BNjVp?=
 =?utf-8?B?alFGY01DOTVFaGFDMDlJdnMwZlhNWTNNV1JGSFFZWnZkaGhMQmhOdWNCak00?=
 =?utf-8?B?Q3JiTU03Um9pOHZ3TDYrUk12WTRtL1NYNWQyaTZyaEZ1R1lKdTBLRytuNVI1?=
 =?utf-8?B?QzNYa2duQ01Qcy96aXpzL2E1clVRZmNzWFFSR1ZoMzF1RzNoSUl3dEVvZlBL?=
 =?utf-8?B?eGZYZHRETk4wTlpQSDlZZGQzNHpneTNya2tNZUIwalNLY3ZZUEo3Z2l3ZGQr?=
 =?utf-8?B?bHpYYnpScldjS0RoYkRnRmlqOThkVmZtSVpHYUNrTjlnYWp0VnZxTHUzTFVK?=
 =?utf-8?B?U0hoNVk2dUo3aktyM1NkM0JtVll3SDJYZmc1RWRzZ0twZmtkU2ZwWHFQZCtV?=
 =?utf-8?B?b1lwODN1S21KN3krbFJtT0pGdFFnUmVGbElkNE1XQ0d5R1hTcmVoenlsVEY1?=
 =?utf-8?B?UGVaam5wUExHSVB3R3AvYTRUYkVQQjJVaTFWWkFZTWZuZHhEVHpXWHV5RUdF?=
 =?utf-8?B?UU5pLzVzM2tKVnRzZHk4YVpoTG1jcWVTeWQzOEJjampoME1KVU1ZSHNVZGFl?=
 =?utf-8?B?QUI4Wk04bnBpc3B1UGJzK1RKUGdtbk5Vd3d2MUsycHI3MnZaaXl2TEtaZlFR?=
 =?utf-8?B?cDBnSG5xeXRwQldRZ3ErbEtPR1g1S0xBbkU2dEZpOEUxT3g4SkoyUDB6cFlD?=
 =?utf-8?B?aVpyTkJpMkluejV0V3pkbUZNU1FCaU0xWVl4THpka2JZVXJvT0xPSW04eW5U?=
 =?utf-8?B?WlZEbExWZmJWWDVIUGdzTmFVdm8zR3l0VlVtWmhncytsdHdNMUgvU2pJVElt?=
 =?utf-8?B?czlic1k5YS9EOGFNUXgyMFRaTjE0YWZqLzRhTzhWVXZQRUtWTmhoTE1FQTRP?=
 =?utf-8?B?ckhpRlQ1YUlvMEJrdkcybXZSamFhWjdSc0lPUm5pRjRmL05ta0F3WmN3Z3FC?=
 =?utf-8?B?TGdxcjhKL05CU2pFbml4eW5hN01EU2N0TjRhVXY1T0FSaURLWHhRSHFENTBa?=
 =?utf-8?B?Yk5qaW5jVWlWTnptOURkczJXcEh3MlFUeFlmYzBER0wxYWg2RitGelB1Wlp5?=
 =?utf-8?Q?oSvbNOBV/OquDvr7/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJpck9TYWtaeUpPUFJSb1hCWFNWemFTbUZTdTUvOGpLRjB4UDRlemtnR3pZ?=
 =?utf-8?B?V0pTbVJYZzFDN2l5NWNTUDl6TlV2d3gwOTNNYWhqNDNyTldNdGt3UHpNWkNU?=
 =?utf-8?B?M2RpQkNTWHp1eTUyMERQRmZzWjJRWERYZEtmVUpjOHZCWXdpY2REbjhXUWJi?=
 =?utf-8?B?cDJOZmhYK3dHYnk0OGhnMEk2OXBlOUNralIrTFBlc0ZtREtwTzNuTC9JTy85?=
 =?utf-8?B?M3lxU05pOEt3M0Z2MjBNckVhWkQrRDZORGJ4MnVrUWxzT0tjQktMSzR4c3ZO?=
 =?utf-8?B?Mmdva3dGNDJHbGFhMU9Qbk1XcldPMVVtSEgwUzBxczNGYkZIRGw5TllnK3FS?=
 =?utf-8?B?Y2cydnRIQm81TE4zTG1iNUEwTy8vdTNZS1pWUHFIUEZ1WjhJR3FLNlRXcEdq?=
 =?utf-8?B?a2Z0MERtQy9NcUxMQlM0WDYrVEZwN3RPdzQxa21YcEZOTTN0c2kwODNzSDdx?=
 =?utf-8?B?V1JCNDNsbDVaV2czTkk3cFpKaUNCVTFqUWVNc2RxRW42VWRDK0tkWkFHQ3FU?=
 =?utf-8?B?bFAzajZ3b1E1MGxuNEt6ODNLejczeW4xdU5zd3F6THBCU1Z4TXAvWW1LNlFS?=
 =?utf-8?B?TFlySFkreXVJZVNRSDN5emRjRDE4M1FKcE5PemhpdldhNkhORThZR25SL2tX?=
 =?utf-8?B?ZjFLdTZZeVdRWStHZjY3SUNZSUlFUlhncU80UUZTVjVaWEVvdGFPTFVFSDVu?=
 =?utf-8?B?TTA2MTBHRlY3L0lTc1N3eEcydEJJcTJKSTBPbU1tRnJ6ZkRNRGFGNHdMNGFx?=
 =?utf-8?B?eUtZdUlzaXFSVFhWNlBQRzkzamEwTDRuT1Y0Sm1Ua2RwQjhoZG1NL1J3cDU0?=
 =?utf-8?B?WkhWazF2cHBPVnZET1lqcGlGMDlHbWdJaUhVaVlTY0s1SzIzQVhiZVhTRFRB?=
 =?utf-8?B?ZERwcHBVMUwwMFdWc0hvZEozb1psVnFFNkJtMFUvcXhFRE1takpFYkwyREpF?=
 =?utf-8?B?Vi9RemErcUtzY3NwMWNyYlJsWUhCUWljN3phb2ZDcjQzQ3c4UmpIcGxqSWh3?=
 =?utf-8?B?NStjMlFhVXA1RTEwWkFtMDV4TStuZzMrU2hXcmthbEdkR2RQSG9pM29JZ0RP?=
 =?utf-8?B?cmJENGJzNk42bFpVd1hCdEhyNzVtbk84MlRnVmZkaW52U1AxcWp3cm1nYjdy?=
 =?utf-8?B?UktsVUFic3A0bmhYa2o0VVJ6LzhPN1Vsb1BvZzBZRmF6MW5HNDI4TjRNOGhC?=
 =?utf-8?B?L0FzQm9VUHJ1bmF6aWxVNUN1S290blJPOEdpS2daaWVhZzNCMGZjY25Udjg5?=
 =?utf-8?B?aHZ4WCtEZVp1eEdYZnpQVWtmM21qb0NWZzdoRXNSaW5LdDNremxRVHdwTEx6?=
 =?utf-8?B?YlJJNG1USzlnbzFZTHhvYUlKZThxUnBKak9Fa25XczFrWTRrWk5CQk9scHE4?=
 =?utf-8?B?UUJ1U2tuZHlFempwelNuWjlhSzRVOWsxYWpNRlRERnQxckFzM21oaWlKU1Fv?=
 =?utf-8?B?SCs2N0lnS2FpcFpOcCtCQXpXSkN1blcvL3J6VkNlbUZXc3lEOTBJb1YzeVpK?=
 =?utf-8?B?bldRVlQwdmsrUlBhZ3Y4NkRoREw3K0MzQTJ1M3FTaDU1L0VXWXVXT09nTlRq?=
 =?utf-8?B?Q0U0ZEVlYkxXRGZScUVWT0RQRkNFeDhkUjg1SFdUVStVbmhLUXQ1RHdIRHQ1?=
 =?utf-8?B?cTQ0WjVSUUtyWEVGWGhDUnpQaFdpV0UwbFB1c3AxNDczSzZKMWJoVzRoWFYz?=
 =?utf-8?B?NjRoZTJFbTZMT1NUbHRPdG5yWEFGRDBCTENHdDVERWttVmVranA2c013dzZG?=
 =?utf-8?B?dVdnT3hLNHZ6TkF1b0dWVzlVdU83VXF4SkhYZGNLeW5NemtveDJ2MVB3dXpm?=
 =?utf-8?B?TUxxcVkzckFSRXJPWUhHc1NPRENZMEJYRTI1djJKeUtmMDBlTWI5UlVkd1da?=
 =?utf-8?B?TjNGNEZWWDI0anRJMDNjd3BQMnJEblFsWGY0VFFEeGFFRDJFMmR4WEdlbUN4?=
 =?utf-8?B?a1JtVnJ5S3BLNkZhZEFCSjFqQ2dObExVbDliQzhJK3ZJVTFrbWNSSGRBekJW?=
 =?utf-8?B?elcrQS85YTE2Q05QV1czcVZoVzBrSE9ZSXpuOTRPL2RuNHRDSnpMTmtOYTB0?=
 =?utf-8?B?clRUMFRNMUhSNjJMd2FXMmR1NEVWWnYrUENsampFdUhCSGtQcy93TGoyc1V3?=
 =?utf-8?Q?eKuwAmkribCKMoe7rED/PeM4s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bea53dbf-d5d3-460d-383c-08dcc3a5dacd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 19:00:28.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSkBTIvqWOzYbg2vhKODbn3loAkQUdErkJBKD2euV3MtniHIR+dY958A2tT++8TBVt4kU5+Ye2h855joJbhkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
X-OriginatorOrg: intel.com



On 8/23/2024 11:43 AM, Kuppuswamy Sathyanarayanan wrote:
> In commit # 0a3e4e94d137 ("platform/x86/intel/ifs: Add SBAF test image
> loading support"), the documentation for "Structural Based Functional
> Test at Field (SBAF)" had an incomplete underline. This resulted in the
> following build warning:
> 
> Documentation/arch/x86/ifs:2: drivers/platform/x86/intel/ifs/ifs.h:131: WARNING: Title underline too short.
> 
> Fix it by extending the dotted lines to match the length of the title.
> 
> Fixes: 0a3e4e94d137 ("platform/x86/intel/ifs: Add SBAF test image loading support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20240820134354.2aec355d@canb.auug.org.au/T/#u
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

Looks good to me
Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>

>  drivers/platform/x86/intel/ifs/ifs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index b261be46bce8..5c3c0dfa1bf8 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -129,7 +129,7 @@
>   *
>   *
>   * Structural Based Functional Test at Field (SBAF):
> - * ------------------------------------------------
> + * -------------------------------------------------
>   *
>   * SBAF is a new type of testing that provides comprehensive core test
>   * coverage complementing Scan at Field (SAF) testing. SBAF mimics the

