Return-Path: <linux-kernel+bounces-517533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A60A38213
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242C21885634
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8A6218EB0;
	Mon, 17 Feb 2025 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnqY+YQK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE95217739
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792527; cv=fail; b=bXNwpnK+eKbGtvqKjZftxGoVonIfHjA+G7D8WWQbm0IjtUGoc/SNXBKNPANsSF9QP06qkntM+izus+H+/5OrJbrtAJLjHSLTNTr8VHlNMWkCcjB35kpjSgNOr76e9SImisKiTSxzRJ/yBMlAKSW9YHYMsFZsjRJagRWzHd4ONT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792527; c=relaxed/simple;
	bh=TLt0H2wRs1hTV8L/ebf2XNj2Dlxu47a+iSjFkvYq+4U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mZdCYgCpVrSnYzYNKrKGkCkk55xmvdHokmCKbJnNMtM6Cc5EgPSpEfNCS4S7/I6/jqnzgzjwGrGm1wUlSN8Vm4Khbsmxl/pHIdCVEf0UNqQ6OnS8BOeDAJcA7umySDPTIR6q3B00R/wRcicLt6b8Yr0CovtRpBWPtw7kfhN9GC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnqY+YQK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739792526; x=1771328526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TLt0H2wRs1hTV8L/ebf2XNj2Dlxu47a+iSjFkvYq+4U=;
  b=VnqY+YQKT5JjrNOF9+4EuEDresy05Fy0OO+g9IOj4kQEdN8GSjm3RczO
   tjC4jJRoIeJ2kN5RfLfwwIHY1ZmfX3SfCt/mq86pH2gGYEBugJTCADqka
   50gP8SeD7vLpoygFBHw9mNmJb9ViqN2io7VtOaVZKMWsxV/wXLjUI3G6G
   ougCxE/tnwSTxX/gbCeziNRbyfw3Zu2uLtPTbk4jLv7RkiYaGpuIiTCus
   3/OqvryD3r6hB7s5AdNlwmZ+u/nZbmnwWlUT7rSEGMsc2nUSbYu5B8WDg
   ipqhtJ25kCr1ytMa61gaBttL5pK2fUJgMfwHJrKQMxJ/1nbNEVFA4gZbw
   A==;
X-CSE-ConnectionGUID: U97MXHQoROmjC+NG3ci5aA==
X-CSE-MsgGUID: NUYWjalrSaKjZNqwKQbyww==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40394123"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40394123"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 03:42:05 -0800
X-CSE-ConnectionGUID: dYx7Ezj2QO+yZhoBkJiL+Q==
X-CSE-MsgGUID: ZydAcJffSgKvRGQh9krWDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114725432"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 03:42:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 03:42:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 03:42:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 03:42:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqubBqJh7zcj/mi7mA+WJmCZmtwigXIrFl+W/HnWQlB55AP6eTKI4Xu+uBbIbclIY3gxvaa/zVWYMyVyB0XNGTRRQH4DZqi5LrKJS10zCbiHTwzDQzU+aqczPL6a9B/rT8P5Ri49YrVtOuEtrEAzIdqL7RM/svgznO9l0lv+DDM+7kkhboItG2D6cbrxfsY6DpMu4cnOe8rs8aNYINqGZwX111a5qzocwRrqbmRPPll+51rTIDSzd67jF98YUpc4cWxzYIiBm6+KDuwVBzxdyD5+WYtCLSBsRMd9gHRMdAn02J4/1qDbpB7DlLMw95/eNCSEWxZg1B9F5TASNbDxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9LX+k9NnFHU6g+FxHRUg75fEy+O4EzkbqAAFUTPcxg=;
 b=kk6ENs1e1R+TmdDBqDru+x+0RPUWac47BNZt5lHPpY8pbLgLClUF59ia0fOb0MzzFRDWTe3ZMAHsqc8sRqoQsM/cWQRxg3bUNJfzW7U0NCP8Xd8gBeLHOnb6RT/3TN0ElZvlHGRJ4IY1R/vp1EUYe+C6saff3qDQK4Bx1271a3nxdS9cO1I5cwnxUoZ7CXyXc4GvNy34MtqorDsK+A2+kwKEnfBdZoVLv1Gv0h9saQTs2wPzx43nwWeKsAEXgeoczQfkeLfzI1KdFPjUeTwSgVuS61zpYxWtD1oYQqMgJ28X6shhbar6jqwdZGgp4puhPFelSgNzUc9283KzXJZCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) by
 CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Mon, 17 Feb 2025 11:42:01 +0000
Received: from DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::f97d:d6b8:112a:7739]) by DS0PR11MB7904.namprd11.prod.outlook.com
 ([fe80::f97d:d6b8:112a:7739%2]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 11:42:01 +0000
Message-ID: <9c8b047c-e4c9-4abb-88f2-f7e15b59bd9c@intel.com>
Date: Mon, 17 Feb 2025 13:40:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] x86/vmemmap: Add missing update of PML4 table / PML5
 table entry
To: Dave Hansen <dave.hansen@intel.com>, "Harry (Hyeonggon) Yoo"
	<42.hyeyoo@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <osalvador@suse.de>, <byungchul@sk.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<akpm@linux-foundation.org>, <max.byungchul.park@sk.com>,
	<max.byungchul.park@gmail.com>
References: <20250214195151.168306-1-gwan-gyeong.mun@intel.com>
 <20250214195151.168306-2-gwan-gyeong.mun@intel.com>
 <25b9d3f5-bfe8-48a9-b11b-819d19cfae1e@intel.com>
 <Z6_d1MvorGFpxdU1@MacBook-Air-5.local>
 <0bed366e-a0e5-4d1a-b677-afad23235bcf@intel.com>
Content-Language: en-US
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <0bed366e-a0e5-4d1a-b677-afad23235bcf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::20) To DS0PR11MB7904.namprd11.prod.outlook.com
 (2603:10b6:8:f8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7904:EE_|CO1PR11MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: d467796d-8a16-4e32-abfe-08dd4f48175f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUR6VWhDMkwrbkJxOU9yQ2RieVVaZHdQVVBaeXVDOEdYcHBPM05kUHhSUXdj?=
 =?utf-8?B?ekFBWDRyZFlpcXRmMlNFYkRKbXRmM0pMdlp6TEJSV29vNldpbTNrK3E5UlFk?=
 =?utf-8?B?SXo3QjU5ZWpWSndEcGRtckhsaWVtY2lRZ3ZFQm5tVCtvMEZ6V2NRbXFZYlVk?=
 =?utf-8?B?Ujd1bmRVMmlxa012RkJpNS9YWHU4STZmN3hFR3NPSFNuaUQrOVdCQVQraXJ4?=
 =?utf-8?B?UlBpMFJpUzdwZUd3djlKL0hhTUZGUWNpZW5vTDFIcURBbzlkMEdDeGtTdG5o?=
 =?utf-8?B?NERmOGxBZGpoaGV2MERNbEhPcit5OTFTdHpueDYra213NHlZaHloZmpKRllZ?=
 =?utf-8?B?VTk2WWNlK1NqS2hubXVYbU5PaEdFcFFKVGdlaE55NnhPQ2pOaDBuWmV3V3V4?=
 =?utf-8?B?bmtMVTR4K2g2Wkh3bGRPU1RRL0xsR2tWZ044VDRXQkhyMnM0VTV2SUpZTWxR?=
 =?utf-8?B?ZFRINkFlR2k5anRiOS9FYUpkdGQ4cnNHUllxVGRnV1d2SCtQKzN4NG80TkJT?=
 =?utf-8?B?SmRsOUdRcU9SZkNKK283VmtrclUyZ2NObC95K1dvQ3puMUZ6cHNrMEVxYmMv?=
 =?utf-8?B?Z1ptblpBYmI2anJLZ2M5MkZtQnRuTmEwdzY3L0ZTOVB1NUNGVTlGb01qcCtM?=
 =?utf-8?B?QllDN3lTV0pXcElDSFBENHRDWXdmMFFNbHJDQjA1cVAydFR5bWpLMHFrK0g1?=
 =?utf-8?B?WnpnL2VMbnUycms1Z2hDVGxPOGQ1cnNOWVkvL1ZHRXFTTHlEc3JFZFBwMEtX?=
 =?utf-8?B?c3hYbHhEQ3BXWW1Td3phTVVacFhWV2tXUldNSkxtZ0xwYnBCc0Q2V2VqU2V6?=
 =?utf-8?B?VTFPRDVha0dvZHVYUG9uU09zdSs5YjBON1BZSGRnbVpGYmU3clREUUp5NFVv?=
 =?utf-8?B?Nk1TYXNKMHN1TEd5RC8yclNPVkRFdUNpMkQwSWY5SjNyNjRqMFZwY2JCY1ly?=
 =?utf-8?B?NmFLdndWMXZacjRGcnc5TENNbVZxU3lPMTB0ZXlYNW1HM2JMVFBneTFuUldQ?=
 =?utf-8?B?THpOZUl5cDVjelZJQ1ZVZXhoZXdWTGtxMmhLMTBsbjY4WVFld3lwVmZ5ZWxM?=
 =?utf-8?B?ODVYcGdFUEh5cEFqOURSUTdLUGNvT2xXRDF0R0d1MGVMalRkTFpaS2VpZGFG?=
 =?utf-8?B?QVhFV2twSWFLSHhPM0NnM2g0alBLc0RiVWJ6YnZETUorNFhOZHlSNUpoTnJu?=
 =?utf-8?B?UGkxRnhvRTdoMHRLV1B1MTlueGRYZnplaVYwdHBjaEZsYldpbVdTSlcwREli?=
 =?utf-8?B?Zk56YU9wTFNFWFRXSHYxUjZleWJ0L3dmajdZUDVyc05LdXBSSjNEaFNtOG5T?=
 =?utf-8?B?UVBnNHA2NjIveXdBTHN3RXZuOEVBWVd1SmtBNUpWbnhvZnBpNDgyRmpzaWFx?=
 =?utf-8?B?NXlpeGxDUmpIWnM1Z2ovYko3WHhUMFBrSkZUY3paT0ZsVmdqNGE3N0xFMHdy?=
 =?utf-8?B?R25vdWxRaVFJSXNqN1g5RHJBYi9Kb29STlQ5VGhyVDFhcWowMEhlUUlDZlNq?=
 =?utf-8?B?czJlL0VTcnVwM2tLc1FreUMvYUo5dU5CNlJTemQ2OFlCcjJseTNXZ2NKWUVK?=
 =?utf-8?B?L3ZudFQySUhFQ3I5cC9ZSVhuTkhOMnhjVDRvSkhmOVgvZHBEN2YrMWNlclcx?=
 =?utf-8?B?U3pwWDJLU2IzZ25WaE13RUVSNEZQLzVOdVFwa3UrVHd2eEl0TXpwSmVYU3pH?=
 =?utf-8?B?aWw5Yyt1dDh2MUQrdGNTakYxbzJZVVM1bmZjdkpjR1grMnNwRXZJdDVsRW1S?=
 =?utf-8?B?cnVDWjNNRElTSzY0TFVuOEpreDl1bmZTajJXajIyRnhJbGhnNTY2amtHc2Zy?=
 =?utf-8?B?aUxmSUxYaVFrYWNoUlhYQVJXMktORTZlNWJWMHlzaTNmbSt6NklQR2xnMHdT?=
 =?utf-8?Q?AeErIy3ZvT2mn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0czSll1NThNL3VURXNlSVkxYXhBY1E5U0JpNmVUM2dudkFhV2haOVB5WWRs?=
 =?utf-8?B?NmlDbVRJQ2lERHJ3cUNLRzk4Z1pNZkEyK1dDay9RSFVFVWZHeHJoeFlXdlJH?=
 =?utf-8?B?aGFkRlRxMGc0ejV6VWovajdCQ1cxMWpNTXMyS1NBT3d5Q2gyN29JRW12dkJS?=
 =?utf-8?B?dWI1Z0krbzc2ZFZSS3ljWFViekE3WERHLzI4cTJNVVA1UmNtc2YyRmpnb2xt?=
 =?utf-8?B?ai9tSU91Qnl5L0RCOGg4Y3p3dWovbkVSQ0tWRkpHRllrUVlYU012eERiSUln?=
 =?utf-8?B?ZjgrYlJQN1ZnK3VXWlJPZDI3N0xYcXZSSGRKOXg1MGpwdXNXMDlDdXoyWDBz?=
 =?utf-8?B?WFJLdVVXM0J5VVdjcjJFTmFGZjBjdTIvRFYrUHlDY1BselZMNUJnV2d3eFRh?=
 =?utf-8?B?TlVFcXlJVDNGSHdndWJSdWVQbllScVVqNkFRZUFrbDRIelhqenM1Qzl0NldO?=
 =?utf-8?B?dkZDcHpBMGlWMDdNT0M0NDlreE9LOEV1Ulc0TUVhUGswdzRsSitxRTdqbW00?=
 =?utf-8?B?NWZWTUxiRXVwbkRaWUdsUXZ0cGtVcWYwWVJtR0RjKzRXK2IvdEtMR3pFZW1J?=
 =?utf-8?B?ZzVtb1ZrczhXUHJzU25UbU9TcktSSkJxMjRITFFyS25NQ0xQc1lHeVZobTJY?=
 =?utf-8?B?Vm1xL2NId1p4dDdMMjA1ODJZZkNxV3poM1UyL3FaeXlET2pwc0k1bU5BVllO?=
 =?utf-8?B?S0RZM1BWbFo0VkFYdXloRS8vS1kwWWRiZ1J2RnpXbGFyd1FpaUZDL0c4bmpZ?=
 =?utf-8?B?L21BdkI2SFFObk90VFBaSFB3YVhjYThwbkJuUjdwVDRvRmI4YlBsVGY2YzlK?=
 =?utf-8?B?cXRmakFQR1ZrNWovU1g2K3I5dHdOT0NFanVDNU1hQklLcjF1UWpDRGNhR3BS?=
 =?utf-8?B?VlJYTWhwRm56eDlaakdNblArYTErWm5uSURkTnJyTjlPaVpRQno3UmJ0TUNU?=
 =?utf-8?B?Y1NoeXNad1plMmJaa01WYmtNWUhuTXpqc0VPeG9QVm5vWnhlZDhzZ3J0bnRT?=
 =?utf-8?B?SFhOMUNzcjdBSXZGVGsvdXlLZ2JPaHVMU1hPekhKdForS2pWZW40d2hqbWY1?=
 =?utf-8?B?dkVJcDd0TGJHSmEvRHlvcG1MeFRWTGJrUXY0ckZKRXJmUmRuZW9jQk5EYUd0?=
 =?utf-8?B?enlxZXBLOHNReDNmZzl2NkpKRnJHV2Jtd0FuVVI4OFYxb0ZZYnpSQUhKRndu?=
 =?utf-8?B?TWNISzdYL2s1bTZmRXdRSVJXeFVHaFNKQ0Y5MjVwT2JkMTlrVGxNbXBlZVh2?=
 =?utf-8?B?Q1RFbUx3NDBSQ2tyT2E5ZWNlWnJzd0dCZFZlMkF5NDR6RnIxZkJHQmg1VUhE?=
 =?utf-8?B?czBwRlJESzhPRVVGQ3pHZGNZbnY1WHpBK1ltd3VOdmFsNDY5ai90VDlubUlO?=
 =?utf-8?B?WmdqK2dVUGtZYnlsd1BuL1c0QnExK3NTa0FndHVWVStvMXpDaEhBNWxvZ3Jo?=
 =?utf-8?B?UWNCcWhDN3JOb3d0bFZIcU5JeTZrVUdpdEVpT2JPMDc0Ykh3ZGpJbGwyOGp0?=
 =?utf-8?B?TWFjdDg4VzQ1SlVJeWhjMDltc3pkbWdORlU1Y2E1MGR1NXlCa1kxTFp5ekZh?=
 =?utf-8?B?bEdjVTdjR0tCdUwvWGJxZ0wzTnZEM0tJSXBWeDB1Y3JjYnFuVk1JRlBiRXpN?=
 =?utf-8?B?cDBOYjltMndPSVEySlR0QUsxVzV1djdVU0c5OTlrNmJqUTFSb0l2UG9QVkVi?=
 =?utf-8?B?RHBKQUNNcTBabmQ0Rk1abnk2ZmR6dnMzVllIY0t4dGpQczJhZFNOQ1lONnFy?=
 =?utf-8?B?VlJQaVorY2Z3K2M2VzJ4elhtc2dwRVRLQmFRUGNSRVFTL1Z2ajd6N1M2T0FB?=
 =?utf-8?B?bXFTWkNoYXRmc2VVYWdNVVJCTFJMWWVkcDJMSXBqNmdqenpJQnVCNjRSTk5h?=
 =?utf-8?B?NGVnZUxhczFFZDRIOGJkNmxMREhveFR0S2l3cnlKNDhvYVlzcDc2cHFobGNl?=
 =?utf-8?B?bitYSTM5QXhGOFNacDBleWRTb05zelpmMGFTQVN3eTd6N0h4OEIrbmZoN0hI?=
 =?utf-8?B?V1VQV2JlQy9rNFpybzZtdUJWYU8zM2hadVpDUXRZVHJoeDFISk1WZW1zQ2Y2?=
 =?utf-8?B?VzM4WU4xUWZzRnM1Vy84Y2pCbm9WUTljUWowKytadVh4NGtLcEdhdC9vWEFi?=
 =?utf-8?B?c3R0ekJaMG4yNk81TUNzaTR1VUhqb1FJcnlDZTFZaEhBVHcwOWRnSG9tdldp?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d467796d-8a16-4e32-abfe-08dd4f48175f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:42:01.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cxkpm2waBKSIglpGhIK1fjdTMx3DOUSV/m3uH8/0X+W3y9BrKo9ww2+nzAROXhD9m5IeYQKfpN3Yi7EPwMVcpBmAhiJA4qH0vdh9zgv36Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com



On 2/15/25 2:29 AM, Dave Hansen wrote:
> On 2/14/25 16:20, Harry (Hyeonggon) Yoo wrote:
>> On Fri, Feb 14, 2025 at 11:57:50AM -0800, Dave Hansen wrote:
>>> On 2/14/25 11:51, Gwan-gyeong Mun wrote:
>>>> when performing vmemmap populate, if the entry of the PML4 table/PML5 table
>>>> pointing to the target virtual address has never been updated, a page fault
>>>> occurs when the memset(start) called from the vmemmap_use_new_sub_pmd()
>>>> execution flow.
>>>
>>> "Page fault" meaning oops? Or something that we manage to handle and
>>> return from without oopsing?
>>
>> It means oops, because the kernel accesses part of vmemmap that's not
>> populated (yet) in current process's page table.
> 
> Your 0/1 cover letter got to me after this mail did. I see the oops
> there clear as day now.
> 
>> This oops was observed after increasing the size of struct page (as a part of
>> developing a debug feature), but the real cause is that page table entries are
>> only installed in init_mm's page table and then sync'd later, but in the mean
>> time the process that triggered hot-plug accesses new portion of vmemmap.
>>
>> If the process does not directly use the page table of init_mm (like swapper)
>> this oops can occur (e.g., I was able to trigger with `sudo modprobe hmm_test`
>> after increasing the size of struct page).
> 
> Makes sense.  Thanks for the explanation.
> 
>>>> This fixes the problem of using the virtual address without updating the
>>>> entry in the PML4 table or PML5 table. But this is a temporary solution to
>>>> prevent page fault problems, and it requires improvement of the routine
>>>> that updates the missing entry in the PML4 table or PML5 table.
>>>
>>> Can we please skip past the band-aid and go to the real fix?
>>
>> Yes, of course it'd best to skip a temporary fix.
>> The intention is to report/discuss the problem and a fix as a starting point.
> 
> Do you have a better fix in mind?
> 
Yes, first what comes to mind right now to safely access the virtual 
address is; translating vmemmap-based virtual address to direct-mapped 
virtual address and use it, if the current top-level page table is not 
init_mm's page table when accessing a vmemmap-based virtual address 
before page table sync.

I will send a patch first with this idea.
If you have any better ideas, please let me know.

Br,
G.G.


