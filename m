Return-Path: <linux-kernel+bounces-565164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2BA661F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA97E189D721
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC63204596;
	Mon, 17 Mar 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOq1LRux"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4D15B54A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251786; cv=fail; b=b29rssByxbKs04HoYzCVnTCZ/1CKeh1AaG3aLqWFzv5QLp+AA+P9PC2TumCFysQgx+t9dI5vHq/ZhRInJL8S7fciUBJlJohilbbzVGPNxpxYXrkf3scwDTczK0eDKzpLCr+dDBVGmzjdMD8mp+4G8i5YQiRywrYFQSwc6H79AVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251786; c=relaxed/simple;
	bh=5ZuTloIgUMVADsb/EMMzkDxVWOCDzC6+Uok+CqRLJkg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fWAIDvwMl32WnZHYiPW3cPSXg/ZVvpGj3h/b6513XKTZgTLxEAAqxzo186d/d8M0VnDo3mRHy1Xc3Zi/M7nngMrZ7XbzIFStw0eNK8O8Uy3G8xieaUtitaL0UXF34kpakQ6dW6B/VL0mBaYg1ATDDDPl1n5YQhILwZRirJkb94c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOq1LRux; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742251785; x=1773787785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ZuTloIgUMVADsb/EMMzkDxVWOCDzC6+Uok+CqRLJkg=;
  b=mOq1LRuxOr/l3XM3NJ3cSk//G/z4wNknh3xxSoQ4vFvZJC8id+3F8CwD
   OrWH4EM6LkBQqV/EOB7lJa82eUp5FpTaBAnHdOJPArba+I+W1T6jOad4O
   A3TgNSRa8Xu/Ds3irztmaHYjf28mqtFz7N/kQmTJM91KBnF3fVEGQpMkz
   6TsF91S/hdAvJrR+kgj54y6867w5dP9prYFu4M9Vg8wB0pe68doiNW9z4
   ZLq+siATx7j9r2s2QXsoYlcFQDWU2Q79O/8uEQM+ftfDQf7mwhpTKRZU5
   u/8QUT+0rqdbsYkTcOghui/Fwto45bQ2CrAKGM/DvPiZzXicB/k8yXRkS
   A==;
X-CSE-ConnectionGUID: bd92+Z5ISv6jinX3GqSWNA==
X-CSE-MsgGUID: 13dEB5ptSZO/w2r49D0rTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54757779"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="54757779"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 15:49:44 -0700
X-CSE-ConnectionGUID: 8ILSMkQxS3WESlLuXsP36A==
X-CSE-MsgGUID: Kj0jLQcaSseS0eKVh4CqzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="121902586"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 15:49:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 15:49:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 15:49:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 15:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ620zKzagquuES0Ik8JIKD5HjaOdtU5oySBHVgWiRyuF0EC09UOnVXiZ9XWIffais5MYQbjZeJUq9ykVyAr4DlE4q9sUsvgG0t2W8zmxzfgpC/5T7YzDZYvIm6yY9j7+IQTTlQdJ+zqCPRw539TNzNTE5AZrkkgAr6rilSqQ/XJhooPTj7ibi3YsPZonr9OvtRStC+OK0rTasN7HF7M4Uhd6wiJ+ieRxRygRIoguOpew9i7iS1XVhFcbOIJTuWabl1s4F0dvatGtRbCr49tJS2ZJ4uogQofNyjsQcNeYl1x/oqi2Ii3VJuQSNDocE0E6XR46LOjo0szW5+YKxaKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R7zVIQEr7FTXHsSVScYLzH9OZoKobvYgdrvej/fMmQ=;
 b=tQvHVm5gu2gK1fkWffGJl8HvfpI93YqL5Z3LIBSV/YZ6osnPKPmZpoQb0QITVDcL32Jsabk2hKInPXK+XoCUJrDkvwLb3+ittgHVYn23CFh6ukWwoW+yxxrCSmuqnf98+sg/3IjrUjri+YlbXPuvoYzrd6tfwPm3JNRIv8rXitxMCq+ZImCZXjWXQEUugeozSN8HNSBv+X4DHqsQmZQey31gJsxpffhVmIVLLCFswwvL1nblLMgWhT6aGqbMRgXJ6QrBKD86ThpdtulhXUEyB/E7reCe8UbcSmMTQW/Cm1V/dm25ItoudRmqVqsodFlP6+nOyOPZHT/ExCW38k/2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11)
 by IA0PR11MB7305.namprd11.prod.outlook.com (2603:10b6:208:439::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 22:49:39 +0000
Received: from MN0PR11MB6277.namprd11.prod.outlook.com
 ([fe80::9c5a:4ff2:f1f0:95e4]) by MN0PR11MB6277.namprd11.prod.outlook.com
 ([fe80::9c5a:4ff2:f1f0:95e4%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:49:39 +0000
Message-ID: <95a490b3-49ad-4bb1-8894-9fedd18b8ab5@intel.com>
Date: Mon, 17 Mar 2025 17:49:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] tsm: Add TVM Measurement Register support
To: "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"hpa@zytor.com" <hpa@zytor.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "dionnaglaze@google.com"
	<dionnaglaze@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dan.middleton@linux.intel.com"
	<dan.middleton@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "mikko.ylinen@linux.intel.com"
	<mikko.ylinen@linux.intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
 <20250223-tdx-rtmr-v2-1-f2d85b0a5f94@intel.com>
 <8e3736c1a0b650179dab177feafdef1a596f81c7.camel@intel.com>
 <aa492474-e975-4121-8e0f-54414a7f5e65@intel.com>
 <f031cf8e34ef82649e32c8060ef4a42a2e185783.camel@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <f031cf8e34ef82649e32c8060ef4a42a2e185783.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To MN0PR11MB6277.namprd11.prod.outlook.com
 (2603:10b6:208:3c3::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6277:EE_|IA0PR11MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: b32bea4f-4930-43fd-6ae8-08dd65a5ffb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHJFbWxtQm9jLzcwZituWUN5N3cvMHVhVEZMaytkbTJXaDRnbkliSnVnanBa?=
 =?utf-8?B?YWFqd0ZFY3NkQTllT2lRSVVyM1MrM25FLy9vVXA0cll4eFM0OW9mNnFDVkl5?=
 =?utf-8?B?YlovQ1RaUkpsTTl0Y0tBTTQxek1wcXVTLzV4RXNiQzhFY0ZsU3FwMzU4TTFN?=
 =?utf-8?B?cG0xZ2hzTWIrSWpFQUwxMEdLWVFrMVNwd0haMU1RQVJjdEowU3Awb0FibHgw?=
 =?utf-8?B?QzNJM1owQk9VMVJ1U3RjakRFRU1ObjcxbGRsU3VtSFlzQThvdmxhQUhQMnU1?=
 =?utf-8?B?UVQ1TXVhci84SHZneG1kSFgyRjQ5ZHhVT1c3eGVMN0tYaitHaVI0V282S3ZM?=
 =?utf-8?B?UDJDdThxSDlvS0dqRGJ2em94NjhiZmMzUDRIUlhySWxFOUVadDM3RXp4QjF6?=
 =?utf-8?B?RGNxWDdKZmhIbGd0bzViaEt5QlFQNkVYSS9zTk1jTkFoUTJnUisvVkluclIx?=
 =?utf-8?B?ekNMVkUzejdnVzhMd1J0Sk9VdEZuOE5HVmlvUTFPNWE1Wjdod1pEWHJ3a0la?=
 =?utf-8?B?M09PK0RJM0tQeU00OFpPK2gwSWNrUVd2OWFRQ1BJaHdQWW1vdVRCTWphN2xp?=
 =?utf-8?B?dVRIZG5iQjNpT0o4MWNpSWdIcFQ0VkZtaGNWUDNZSnBoTVJuK1gxYXBmV0hF?=
 =?utf-8?B?ZzBLM0ozWitFMjBLdkUrTUQ1M09yeEtLUWZaTFVmUDhyU1VtdS9FMTJCUlRW?=
 =?utf-8?B?ZUVBNnQ1RWFISkNxMm1UM0dyVTdmaEZFTnNjbVNFYmdycWkvM2MrMVVwb09M?=
 =?utf-8?B?L1ZCMW05RFUyaVA4UHdWV3J5NmJrbm8wMElkSnBEaFVnVDROTlpoRnByY29W?=
 =?utf-8?B?T2NiSTZvL3l3a0xOWHdpOTZiRWFVYW5YQ0tsdXoxUSsvL3NUaldwZmtwNEVI?=
 =?utf-8?B?TE5wUjFFbi8zZ2lualNXL0JlNCtNd3FFOWVQQzNpT1E1bjVkRnVBaGVBUlY1?=
 =?utf-8?B?cGZjeUlBcHptQXQyNFh5aGQrMW5aUkFLRzRtQTkrUEwrQlk4aGpaWUY1cjRG?=
 =?utf-8?B?N3k1ZnNZdFl6cG4vR3YvNjROTHY5K1g5clFLSXdwZlpxeWJ1THNGaGdzUXpN?=
 =?utf-8?B?R251QWFWWFFqeDlLMlZXaGI0VFh3bGNrRTlGclVYczBjNTl6dmg2M1l1QmNZ?=
 =?utf-8?B?dUtoNWdzZHdleW1IVW5EazNiZHkzVHZ2QldycnIyYUxkcE9hNHNpSkdHZHNP?=
 =?utf-8?B?S3MwckxIeVlLZXcrbUhDSVNYS1JNMGp5TzJhL3VrVy9JSnNsN2VOYTlQayt2?=
 =?utf-8?B?a1RPRkd6bCtUMmdKZUtYaEcrb1YwVklSUVRoTTJMSTZaa2k3NE85VHhZMVJD?=
 =?utf-8?B?OGIxVHc5ZExKNlppRzBnTytpUFJwY1JuQmZhbmV4b0E1UjdkbndmdkhrTGFO?=
 =?utf-8?B?QmtiODV4L01BNHpORUM1OFpOODhSU0xLUTcrcE54cEYyZkNWYVBYQkl5NCs5?=
 =?utf-8?B?REFvMTRMMW14eVY3ZlF1bFVvTkN1V3lwQnQrRGRTVHYvc0xhVytyaE1kSnRl?=
 =?utf-8?B?L3ZhaGRDSnRvNTRtaVc2cWFSQlhJdWlJbjNGYS9VeWhMOHZIbDBOOFAvbm80?=
 =?utf-8?B?NjFsR2luT0d6dWZuei9MeXpNVDdCT0xNYWpycW4rUm9zWnZCUzZVYUJzYzVW?=
 =?utf-8?B?bWcyWXZFUnNaYnlMaFh2SHRSUys0alVpeWJSTWI5VHArOVhDbEJiWGc3NnY2?=
 =?utf-8?B?bktQYmxvKzNUNlhTL0Vsck5YemhIYncrWmZMSjE0T200VVBacXQzb25sOCs4?=
 =?utf-8?B?L0RQckJXYjVqTU45T1RWT2FOZjIxREhMWkZWZVpUWWNWZW4zWHcxNExvdWRi?=
 =?utf-8?B?Z09GNWkzSkYzTlhVeWp5WENZc0N2alNVaXUzN1F5cDBYdVZxL0orVXhOSldO?=
 =?utf-8?Q?XIoxE/BXqVHNx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6277.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVPNGM1eDMvNExLcm5PeDkxekxhc0tvOHRGZ0VYajF4NkNtVGVzZ1dFczdY?=
 =?utf-8?B?S2cvK3lOZy9EUWVYejlGRk84VDJiU0dEWG1HTVFEdlBLMEU0YkQvcDhwdjBN?=
 =?utf-8?B?SnQ5OHpHeEVWeENTb1M4UVdvL3E2c0JwL0p4Rnd1SUdHOStpK1hhNnZQbjJw?=
 =?utf-8?B?Tml3VjlRYXdlbUZzNlNEMVdtK2h0UFlXaWJkbkRrY1Q5d3lVaWhGOERiMUVv?=
 =?utf-8?B?azFraW9CeTRxL2g5WHBqUnBxeXlJYjBUbmFiU0FjY1ZtYlhWR3plcU9hU3lv?=
 =?utf-8?B?VXBmaFhwT3EybkhldmdOTDJoRnR6SlBLbDB3aDB0M1FjMzdTcUpNb3g1R3I3?=
 =?utf-8?B?LzR0d3czK3JtL21tVnlKUlk4SjVyVG03VVpJdENJRlBrek42aDRjQ2JQblpV?=
 =?utf-8?B?Q1dOU0dDZ0h6alo2YmNZeUM3V2lWdUw1eFJBdTY0TTJZTHlpMXA2eHFMQmh1?=
 =?utf-8?B?R3RScnFrR1ZyV2VCOFljYzZmMEJONDc3SkFzOUt6dEhlQ3VUVUJRNFF3bEFr?=
 =?utf-8?B?NGNWVEQra3REYUNvRVR1a1hhc2FJMVpDMTF4aFBHZzA0WjBYcmxNTHI3N1pu?=
 =?utf-8?B?dDlzWHB4UFFoeVRPOEcyUmtIV3QzTlFaaHM5QVIvVXI0T3VzMzVBSUk4RUxS?=
 =?utf-8?B?TVZFNmpZenlRa3RQYStqRWxhL29yOTF6Vlp3UzFWazJPRjFpQ2lBYUZYcGto?=
 =?utf-8?B?V2kyekJSbWFPdlpDc2dnVnorV0h0cmprVkN4TEw5bTVRZUVSaUdmbm14aURK?=
 =?utf-8?B?MTVQcnFDUVpKeHpDR1prVDNxalR3RXp1ejF0U2M5R1Y2R2pGTnl3cnd4c21L?=
 =?utf-8?B?cXpleUx5S3ZOWFhyNUF5Z3l4eHlNSHh0T0lLVjdISjZkUGk2OC94aVdqVFhT?=
 =?utf-8?B?bmw4VEkwMDhzZmhwRFdyTUhRMVJoNmw1cjgwM0F2L2NrZzhSUEtDMlZQajZw?=
 =?utf-8?B?RGxDekhBdTFTSFdmS0d6bzNKTTU1VnR4Rm0xMm5ubFhzYjhwUHNvRm5lUlZF?=
 =?utf-8?B?N0ZBSC9EQXpUUEhzTi9aYlBHU2w3U1JCTVBtSitqTVNKSy90K2FRYWFlY3E4?=
 =?utf-8?B?RU5wVmg2enhrRHlNTG91Nkx0L0NRZDh6OGg3U0dEeDRLOGVrbXdjZkUzcThr?=
 =?utf-8?B?akxYcndDSGlqbXF3akx3NzVvTmhsc2R2ZFZhOWFxOGVoWmtjSlBMTXE2clZ6?=
 =?utf-8?B?MUJtcTlpZkNVWTNzZGpWQnFJTkJabHo5VGRzNjdsejN3SWIvSG9MaFlkQTF2?=
 =?utf-8?B?VWV5aG9laTVKay84cXNrM2RNM0tYWlpLNWtScDJCazRWQ29kQXlKR1JLVUxE?=
 =?utf-8?B?MFgwc21RZDJ6M0Vxek1ha0lCZUZoVXpHOEVGQXF0WldGdWtheGMwRjhQYVZS?=
 =?utf-8?B?OUQvdC9CcUgxOGtYNExJZFhudW5vTEVnNTJtR01iUFF2UWZjSWdYRDZpNzlw?=
 =?utf-8?B?bEx2T29pYXZQTXpxVy9JRC9tZ1RuVlhVQWdGZTVRL1B6bS9pK1VTQ1BwTUYz?=
 =?utf-8?B?NGN1K1BOajl5Y2lRQkdYdHlKTkZvS3JTTHZ5a3ltU3pRcjVWMkFXVTZ5WUU4?=
 =?utf-8?B?ZFlVTHJDLzU1WGFyd2xDMzRUWUFET1JUM3cycTdNaFRlVndXRXNqUVFJWEFl?=
 =?utf-8?B?RWZCb3c4RldXM2Ztd012OVdnc210TS9pT0xDbHNCc1o3Q1dLWWVIN3ZFay9w?=
 =?utf-8?B?RzlUOVJ5RkJaK3ZUS0t1VHFvdDRKMUh4T3RLSWFIZ3dLT01UYVgwL3lqU2Jm?=
 =?utf-8?B?L2pJVVQvYWl4dXJNSWx3Rjc1VWpVM3QrdktFczM5OGI4Z3d1TndJR0dkUDVD?=
 =?utf-8?B?cXc1MDlQRWhnREpQcmk2NHRQOXR3UWYralZ6Y0FFQkJGYWs1dGN1Z01sZWZz?=
 =?utf-8?B?T0h4K2Zaa3A1Q1JkbkpCZ2xzZTgrL3NwN1N0MEt6SGJDZlg2M09qVHdzMTlo?=
 =?utf-8?B?NEZ1eDBsdm5xbitPQisrLzczNVBGaWpKOHJMUW5UZ29FdVp6ajIvUWNITGtM?=
 =?utf-8?B?MWpBTGQ5TjhDUTc3SjhaY3crZzBiaDA3ZFB0WEkxcDQ4ZGdJZmp6UGc0MjQx?=
 =?utf-8?B?cXVPdTkxY014SE9iTW5WQitUNUhVb0xQbU5RYzBmQm5WODFpTTMybHM2UkpE?=
 =?utf-8?Q?T/k3rmNSobf7Ms6E5APAsYNPJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b32bea4f-4930-43fd-6ae8-08dd65a5ffb1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6277.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:49:39.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuU8Ml3lH7glNeRjnctugzNdR7+CSwFqalBZq0Y1iHmZ0nULr61/0a+WLCZ1oDlw9ojkV3717ZyB+qnWq8u5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7305
X-OriginatorOrg: intel.com

On 3/12/2025 6:11 PM, Huang, Kai wrote:
[...]	
>> The key difference between MRs and reports/quotes is the lack of
>> context. Reports/quotes benefit from having a separate context for each
>> container, ensuring they don't interfere with each other. However, MRs
>> are global, and creating separate contexts would be confusing since
>> changes/extensions to MRs by one container will always be visible to others.
> 
> This makes sense.  Could you put those into the changelog?
> 
MRs have been under sysfs since the first version of the RFC patch. I'm 
not sure which changelog to put it in.

> I still have a slight concern (more like a question) though:
> 
>  From attestation's point of view, ultimately, those MRs serves the same purpose
> as the static ones -- to be included in a verifiable attestation report to
> provide trustiness.  I think in most use cases the runtime MRs will be just
> extended once at early stage, e.g., during system boots (since they are global
> as you mentioned above).  And after that, they will just be read by applications
> (e.g., containers).
> 
There are applications that require reading/extending RTMRs way past 
boot. For example, a container runtime may extend the path of the 
executable started inside an existing container, the container can then 
read the RTMR back to determine if there have been additional processes 
started by the user since its entrypoint.

> So the question is whether do we see any requirement for containers to *read*
> those MRs independently w/o the full report? From attestation's point of view, I
> don't think there is, because those MRs alone are not verifiable.  But I am not
> sure in your mind whether there's other use cases in which providing MRs for
> read in configfs-tsm would be helpful?
> 
MRs, when read inside the guest, are considered trusted, as the guest 
trusts both the attestation environment (e.g., the TDX module) and the 
underlying communication channel. And there are applications like the 
example above that read RTMRs inside the guest. Please also note that 
reading MRs are very useful in debugging/diagnoses too. Just like 
"tainted kernel" messages, they aren't necessary but are very helpful. 
As another reference, TPM also provides TPM_PCR_Read command.

>>
>> Below is TDX specific:
>>
>> Report0/reportdata is an exception, as report0 serves as a comprehensive
>> list of all measurements rather than a container-specific report.
>> reportdata provides an easy way to request a report if inter-container
>> race isn't a concern for your application.
>>
>> I can see the confusion here though (both Mikko and you raised the same
>> concern). I can (1) take away reportdata but leave report0 as it;
>>
> 
> I don't quite follow what's the value of leaving report0 w/o reportdata.
> 
The intention is to allow access to _all_ measurements of a TD. There 
are measurement items not exposed to sysfs, such as MRSIGNERSEAM, 
CPUSVN, etc. They are not exposed individually because their uses are 
really rare/limited. Leaving a report0 here will allow users to examine 
their values when needed. REPORTDATA will be hard-coded to 0.

In other words, report0 here serves as a "container" for all TD 
measurements. It isn't meant to be used in local attestation. Its name 
"report0" merely suggests the its format follows the TDREPORT v0 
definition in the SDM (so people know how to interpret it).

>> or (2)
>> take away reportdata and break down report0 into tee_tcb_info and tdinfo
>> (and strip off report_mac_struct) so user can still have a comprehensive
>> list of MRs;
>>
> 
> Ditto. W/o reportdata, what value are you going to fill into the report0?
> 
> I think the confusion is _why_ do you want to provide the full report0 via
> sysfs?  Is it for local verification, presumably?  In which case, probably you
> don't need to care about the reportdata?
> 
> I can understand the purpose of exporting runtime MRs, I can even understand
> (sort of) the purpose of exporting other files like 'mrowner' etc, but I am not
> sure the purpose of exporting report0.
> 
I can see the confusion from your comments. Guess neither (1) nor (2) is 
a good option.

>> or (3) take away report0/reportdata altogether. Which one
>> do you think is the most reasonable?
>>
> 
> 3) Seems more reasonable to me, but I am not certain because I don't fully
> understand the purpose (use case).
> 
>> In all cases, I'll incorporate
>> Mikko's patch into this series to allow per-container TDREPORT under
>> configfs.
> 
> Sorry I might have missed, where can I find this patch?
> 
Mikko's patch is at 
https://gist.github.com/mythi/1c54fdb143c961146453261c725cd485

I'll incorporate it into the next revision.

[...]
> I think it is still valid question that whether we need to make those MRs
> consistent for all vendors for the purpose of providing a unified ABI to
> userspace.
> 
> IIUC, Dan has been wanting unified ABIs around attestation.  It would be great
> if Dan can provide guidance here.
> 
Yes, Dan and I had discussed this long ago. Just a bit clarification 
here, this ABI is mainly measurement but not for attestation.

Given the lack of unified HW from different vendors, there cannot be a 
low level unified ABI. A higher level ABI (with HW specifics abstracted 
away) was once proposed - i.e., the log oriented ABI. But it turned out 
difficult to agree upon a log format. Anyway, the abstraction doesn't 
have to be done in kernel mode, as long as MRs are made accessible to 
user mode. This patch is laying the groundwork for that.

[...]
>>> Please correct me if I am wrong: in my understanding, the purpose is to provide
>>> a "unified ABI for usrspace" for MRs, but not just some common infrastructure in
>>> the kernel to support exposing MRs, right?
>>>
>>> Configfs-tsm provides consistent names for all attributes for all vendors:
>>> 'inblob', 'outblob', 'generation', 'provider' etc, so it provides a unified ABI
>>> for userspace.
>>>
>> "attestation reports" in this configfs context refers to opaque blobs
>> consumed by external parties, while the guest acts as the "wire" for
>> transporting the reports.
> 
> I interpret this as there's no requirement for containers to *read* those MRs
> independently via configfs-tsm. :-)
> 
Yes and no. Containers have the need to read MRs, but doesn't have (the 
need) to verify them (and the credentials backing them). It is a 
separate question whether to read MRs via sysfs or configfs. The 
structure of configfs-tsm is optimized for usages that doesn't require 
parsing/interpreting the quotes from within the guest, while The 
structure of sysfs-tsm is optimized for the opposite.

Please note that, at least in the case of TDX, quotes have a lot bigger 
TCB than TDREPORTs, so shouldn't be used unless TDREPORTs cannot serve 
the same purpose.

>>
>>> But here actually each vendor will have its own directory.  E.g., for TDX we
>>> have:
>>>
>>> 	/sys/kernel/tsm/tdx/...
>>>
>>> And the actual MRs under the vendor-specific directory are completely vendor-
>>> specific.  E.g., as shown in the last patch, for TDX we have: mrconfigid,
>>> mrowner etc.  And for other vendors they are free to register MRs on their own.
>>>
>> In contrast, MRs (especially extensible/RT MRs) are consumed by the
>> guest itself.
>>
> 
> Yeah agreed.  But eventually they are for attestation, right?
> 
No. From the perspective of this ABI, MRs are "mainly" for measurement. 
By "mainly", I mean there are MRs like MRCONFIGID on TDX and HOSTDATA on 
SEV, that are simply immutable storage. They are needed by applications 
for verifying, for example, security policies that must be enforced. Do 
you see the need for reading them now?

>> They are vendor specific because they are _indeed_ vendor
>> specific. The intention is to unlock access to all of them for user
>> mode.
>>
> 
> Agreed.
> 
>> The semantics (i.e., which MR stores what measurement) is
>> application specific and will be assigned by the application.
> 
> This doesn't mean the kernel shouldn't provide a unified ABI to userspace
> AFAICT.
> 
A log oriented ABI was once proposed, but we failed to reach an 
agreement on the log format. Moreover, this may be a problem better 
solved in user space.

>>
>>> Could you elaborate how userspace is supposed to use those MRs in a common way?
>>>    
>>> Or this is not the purpose?
>>>
>> Sure. For example, CoCo may require storing container measurements into
>> an RTMR. Then, a potential implementation could extend those
>> measurements to an "RTMR file" named "container_mr", which could be a
>> symlink pointing to different RTMRs on different archs.
> 
> OK.
> 
>>
>> Of course, we are hand-waiving the potential difference in the
>> number/naming of the MRs and the hash algorithms they use in the example
>> above.
> 
> I think the number is fine.  E.g., in the above case, the application could have
> a policy to map a given container measurement to one RTMR (e.g., container0 ->
> rtmr0 and so on).
> 
> And I am not sure why hash algorithm matters?  If needed, there could be a
> policy to query the hash algorithm for a given RTMR and feed extended data based
> on the algo in each loop.
> 
The existence of a "mapping policy" implies the application is aware of 
the underlying HW, meaning the application cannot work on new HW 
released after the application.

"Querying hash algorithm" will work only if the application is aware 
(and carries the implementation) of the hash. This was how crypto 
agility got introduced into TPM2.0, as old applications can't understand 
new hash algos.

IMHO, what's really required by applications/attesters is the ability to 
log "events" (e.g., a container signed by a specific authority has been 
loaded/started), while what's required by verifiers/appraisers is the 
ability to verify those "events". Neither party has the need to 
understand the HW specifics (number/names of MRs and hash algos). 
Therefore, an ideal solution should be log oriented: Applications append 
"events" to logs while verifiers extract "events" from logs, with the HW 
specifics encapsulated in a separate "bottom layer". This ABI is part of 
that "bottom layer", upon which the rest of the stack can be built out 
in user space.

>>
>> Generally, as shown in the example above, common names (e.g.,
>> "container_mr") don't provide common semantics (e.g., different hash, or
>> different measurements may be extended to the same or different MRs on
>> different archs), so we avoid using them. A full solution would require
>> a log-oriented ABI and a virtual measurement stack. We're laying the
>> groundwork for this today.
> 
> As above, I don't think I am convinced that a unified ABI doesn't work, or isn't
> necessary.
> 
Please see above.

> Again, no blocker from me, but I am hoping Dan can provide guidance here.
> 
[...]

-Cedric

