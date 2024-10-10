Return-Path: <linux-kernel+bounces-359371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35324998ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BF81F29368
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C581CDFA9;
	Thu, 10 Oct 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r782EMS6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE91C9B64;
	Thu, 10 Oct 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572096; cv=fail; b=j8RAUF9o8+U6ZZAPDAmFXgFFP6LxhNZsogyJmK3L1askPCkoWMLdlkxL0y65ikcml3PwSvb0aaWdNKrhk4eHR7RwRi1pQMKfQjogXdlIxv6D36wmWbKcyXZDC80VGRZ0JnHe1uKkkv1299ySNNkF3U7ikuH3DQA98AauonoW7kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572096; c=relaxed/simple;
	bh=r1y0f+cJ5AXcQnuD7APrlwiwnsxj6HAI3Fu9ikciht8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=asdVjPpN3/z1cwb+1LpfKHP98O5lIkZe5N4BwnvH0aNYYbrvZFJ1kDQZK2C20Yuw0db0P9sdaL8XG7tY/REh/KQKI3mkhAoUzEDVFVEOHcrropN/r/vX2o2N5tXOi5bSBJ8LTaWheXkB+prbyeO2NtYQi0Wtrgc5SOH0SVe0erg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r782EMS6; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri9+ZO0rxxvxCcL67yF6qtNjUNz2+0OvLqAqusy5+e9tJ7FzlhPWxtWOIgaPRqQvVcKZib15nArPGmvWYTTo0GfSjeMslq63bMJyPJqc39lLZoXi/3jI2CPflp637qaCIFHBDzWab/EeopMJTBNBezD/vwFvjinGOH6EIj9sIBXsk5U39Py833zvUtVpXEWkwuIn/kJLr2IPWR/1u4FPUqtxatKk4K/GAW2zXB+UYONSk11Po6rQv7/jVtI9PlMKXQuMcIR9JObnGmlJqatO1SwiWSPx9jjGq2/keG6a71nem0IlduZ1AfARLmfqrffbVR7yQRmUzs8zELWp+OdjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByskEeCzYXI8YgGwROyLIR72FipP1iA+pRSN5ud81Ac=;
 b=BKIrDG01Z/e7PsySCKxaHsgP7F9nJy0oixd9Heha95uYIKn/oEP7afhM8o0+Qv7BGxudphFxj7mT4gR7hicc6C+kFt/Pu0ewGYk1s32mMCxJpOE5kEnVIQG21Qjepd2eCSRgesf2x3rZXNf1ttUlgRTG7tucvkBbGcwqyjQwn+uMyd75wDRfuarteEoBI1Ii0l39VDywibh3KT1NmNV6LfhKMDy/ZMpqXYGqi0qoadLuA8eVmsElzNHi32V4aCUgRo19s3Wy5A96iyIhfhKzVsPu249V5N0lYL53PV0bYusa2HLov+mCQ5kuGaAcZirntlM71bsb7K9qHTveKVaHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByskEeCzYXI8YgGwROyLIR72FipP1iA+pRSN5ud81Ac=;
 b=r782EMS62b4uS39qPLrrHdrlRvhwWFuPnp56g8gPN5SVTeXD6Xlf4TG+bjkZOhhMUYIPx3cd7cDoMXuSo9iEaJK6bbM9gqdwDse6/MuuumotGzNfIQBwhVFAPDqvRBXeOd68qtG4skh9yx89MJT6PmrR+so9G8ul1ExCrwioKXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 14:54:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 14:54:51 +0000
Message-ID: <4da658fa-3cea-4388-86f4-d4b0fb5f0903@amd.com>
Date: Thu, 10 Oct 2024 09:54:47 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
To: Tony Luck <tony.luck@intel.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: 30448b64-e6a3-440f-b2ba-08dce93b7e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2pxbWtoMHRGd0dSZ2NaRjBKR3J6TWRhMjBMcHk3NURWWXY1d1FrbzE2Vmhk?=
 =?utf-8?B?aSsyUXJNMW00SGwva0hpeW5CdGN3YXVxOEhzL2pTVWhxT0g0RGV0UnIraW83?=
 =?utf-8?B?RUVhUDZuL3VNUVk1MDNSZjdBZFFpUnJPZlV6NEJVR2JORW9DSkFUZm9OMU9F?=
 =?utf-8?B?VWY4eEVpT052Sy9aWUFOM2dhRWwrSUI2WTkzK1VzK1MzQ3d2ci9LNVI3RkFn?=
 =?utf-8?B?VWFyaVJBZmFDRlFESmRhR2VmczVKbk5EOXErcnkxc2tsME13Q3pQcE9oVnh5?=
 =?utf-8?B?bVFRNGtWc1Fxb3Roc1ArVjV6VGhYUWpzbDRLOGRkSUxOTzJ3dCtsaUFGZ0s3?=
 =?utf-8?B?dVlIR09QUEtlZUNYaC9yY3BvQk41SU9lYVNGWDh3cDVxQ0ZtVXl0VDAyZnMr?=
 =?utf-8?B?SUFxRjRoMnQwbzJZUXU4endrNEJheFFXQTU2VExGTUw5UTl4cU9xcEpGT1Fi?=
 =?utf-8?B?Zk9pTzRIZmJJRCtlajdmTmt6c3JOdmZQZThxc3F4NEVLTXhKcDA3SXJYejh5?=
 =?utf-8?B?S3dsaFpVdjBBTDdhOGc2cVRxREJXUWhram1mYS9QTElnQVZCTW1LL2xnY3lU?=
 =?utf-8?B?Wm9WWlVtNEJBL0tVSUVwc0g3NjlRWi9KMndmN0plczBxTXNSWjV5VVJMRlQz?=
 =?utf-8?B?RFgzNnhNeHMxQk82WWRhSWhXYXRwSmVZN0ZtRWlsU25EQUpiK2JVQmVpbDFv?=
 =?utf-8?B?SW5XWjFFS1RLejU4ZXlGYzZ6aWNuZU0yd2I0S2tOZ3dIOWJWb2dZeGg3M3pX?=
 =?utf-8?B?NmlZWmpQc3cwZytDaUtpbEZGSGtEZXpYYWFXZnF6VmQvZXdFaDErUGJVeU1h?=
 =?utf-8?B?bzBDaXV4TU8zNjZuYldzUFdRWWpRU25QZjhQTFIremcyMVRBV2swNWFLOVpp?=
 =?utf-8?B?c0xsSCs5eHRFcDF5U1dkMlU0bmFFeW5RNjRVbTRiU3ZJb2JTQy9jYzU0WDQ0?=
 =?utf-8?B?KzVVZDk3Si9MUXVSbE1CTk9ZN2JNNFdjU3RYY1FXcG9JVW9mNlVoWVVzdTRj?=
 =?utf-8?B?TVZJZUYrVjh6OGwvOUYrME5mWVdGUm8rVmxpMkQ2RXRjSWF2TUYraEtXVkpp?=
 =?utf-8?B?NVIzd0xJbC9MdG1DQkMwRjk2cnp5V1ZUTkVjRWorbi9hVHhXOUZJVFFndTEv?=
 =?utf-8?B?WVlPZ3V6ZXdWdmxkM3hINmNoUU9xT1g2UnZxMko0ZDg3NHJzNDZGRFllL0RN?=
 =?utf-8?B?S0NoeklTVW9BdnpMRjNTT2ZHZ1A2ajA3K0ZQTk10OFhNZXFJRUFTZndIL2sr?=
 =?utf-8?B?MkdiM2lKbzYrdmZoVjNlekl5MzNCR1huSCtkQkNOWHBEcUV3NHMvYVlVSmJJ?=
 =?utf-8?B?cGZtNjdEUVNKR2k1VWlzVTdzbGttY1REbm5EOWI3UmtTZFJXckNNRHUrZ1Vk?=
 =?utf-8?B?cCtGelprMllPL2F1dVZsblMvU05CU2RKcUozUm9ndDZDZzZySzZWcHI0MHBh?=
 =?utf-8?B?Tmw4YXpSQ2xCSU9odHFmcjM0YmlSdGpESlFqRnpaejlyVzk4bTZZWTZpSkJI?=
 =?utf-8?B?UHlBK1NiQjBZYldhZzUvbzF1RkRjQTBLblhRVTdZQkRmejVoQUt0azcySlVu?=
 =?utf-8?B?N1F0dW00Y2JBSFpscVZCYTA0ZEJjOE80dUMxKy9ndFRIOHdLL21adHZzLzdR?=
 =?utf-8?B?Ry95Mlc0cUxEZ2RrTzMyUytkYkFwOXozQnMybklBRE9vQ0VOUTJ4a00xRCsv?=
 =?utf-8?B?ZmpSSGVpV1JpS2g2UUQzeHRxaWJ1RitLS1lMdjJIbWZsYjhURHNvdUxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTFCNUVHV1RadXhKTjJ4elVYS1lEUG5ybzc2WGZDcEU1R1hFRFFRd0Z5NDl2?=
 =?utf-8?B?TVdsQnJyb2pRL2Z6ZERNRVBDZlZyV082V3J6cy92cmpadEJ4Ukw1Vlg0L1BJ?=
 =?utf-8?B?WHB4S3crQkdTMTlULzVnRERSQzlnejVGaU01NjE2cTFnd01TRVExK205RExq?=
 =?utf-8?B?TzNIY3AyVFp2QzAydk9Xc0VXR05ROGhnQmJJVUFHOG4wQjRLcWE5bjBEWk9U?=
 =?utf-8?B?TW5qMm11bkdXb1ZMZVo1NEhBdFlnZ0xUWitCaWNaTTczUmRkSUsyMG9LV0F2?=
 =?utf-8?B?ejV4YzBQcXFXTnNmQkFmckxiVFpGSWVlWEN5NnlqQmp6MmFyMCtBd3B6MnhP?=
 =?utf-8?B?cm9JSWV4Y2lRMFlnRjloQkdlRmhNTFNlRWVpdjdNOVcyUmprc29pTVRTWWNL?=
 =?utf-8?B?VzhJZmtuZy90cjNYT2dYMVhGTkZwS3ZuVCtSR0tZSXA3U3MwU2p5UEsxUXQ0?=
 =?utf-8?B?cFdzYTN2czhRWHJZRVkxaXlVVXFFaDNTYVprSkJHblpXek1Ea0MrNTNCU2w1?=
 =?utf-8?B?TUNDbE5XVENqWFA4MmE5UnN3alNsYm1Vb0svWWdVS0RJQ0JSOVNja01EdUhh?=
 =?utf-8?B?QmRNQUhJR3ZRanUzODJIUWdENEh4MTlVbnFCbUVFWko5dXY2TkxFTmoyYW9T?=
 =?utf-8?B?akVlYzBWeU9HUVdSSTRoRXFyVTlPTllqYkttQXVsWFZ5dWRQV1grcGptakVV?=
 =?utf-8?B?cUtveXhXY2xuM2wyMWtiejVTclR4bGZ2TXZwckEzN253elZSQXR2blJLeUNY?=
 =?utf-8?B?YWJ1aEc4clFRVTk4bERYMk1ObmpIWXV6QTlTdVhFeXFYY3ZDZTNzMkFOOFJN?=
 =?utf-8?B?bTVXSkNXODNMck1xaXdNVjZoUkpyQmxKZS9GVHFBZFAzS25ScTRXVVZEL0Rv?=
 =?utf-8?B?UUJGTEJPVGViNjV6UFZLTFpEWDlPaU1BTXFUZGtZUGlveFROUEw4R1U4NDFP?=
 =?utf-8?B?YU52OHVrMWlFWVJ6VTJhazZDT1JIOWVnUEpGU1RxT2l4WXdkQlJEMXpIN0FH?=
 =?utf-8?B?dDFVemtVRDlYeWQzeldnS2NFaUJvU1JzWWduWFdKVWlZanBRM2ZaMmdvWTlQ?=
 =?utf-8?B?anpxWVJQRUI5RjJ6Q2tiNXBISW9rSVVTTDZBc3k3NnRGUWpBQTlrK3lRU2Ew?=
 =?utf-8?B?UnBreFMwakkxVkxmSzVXamVWSlNCRUpZbGdXdXgvY3pjK2JPeWxVS3pXdmp0?=
 =?utf-8?B?SE9MNEpGdTcxcDJyc0Nid1NsempNVWtIZVR4VU1oQlRvVHBBOVZLblAxL1dV?=
 =?utf-8?B?UDBDUFU0Sm04L1NHU1FmSkhQaDFpWkR2bXZVRUh5bkQySTVkOTZjM1MxU0ND?=
 =?utf-8?B?dmU1RytlN2c4aG1tOVVGSjBzTGVwT25YSElNYmxQNmo4TGdYZEFxK251MnhD?=
 =?utf-8?B?UjdncVZnU0V1aXVRTVp2UTFjem4rUFc0Z0R0QU9UQnpKZGdIeldsTS8xdWtn?=
 =?utf-8?B?UlFXSGRINzBXbXdiUUw5SnNhUU54MGVSYUxWcnh0STZITTF5Uk84ZFJzRnlG?=
 =?utf-8?B?UmN2dlZvazZhN3liYVQ3ek05cVNsL3EvNWlEMXNhZzNkYmIwa1FBN0xGTXp0?=
 =?utf-8?B?N2lIaGswUkc2Q3V5Tk9PL2w5UVRaS1U4aGFzV3BreWdraFJDS2FROFNSa1Rq?=
 =?utf-8?B?dzh5MWVIbWVhK3RrTUFOcGNDUFlaYjlML2djaTJWSTlhb1E5UTlCbWN5ckg0?=
 =?utf-8?B?cFhtcDhUdlZWb0RFRjgwUlFDR2NnRXg5Q0RIT09yOVFIYmRIcTBhZWR0Uk83?=
 =?utf-8?B?c1BkTzFFMXJvOGNNYStqaTgybG9kRzRaczhSLzdxR2JWR3BLVmFQNzVTMmIz?=
 =?utf-8?B?ZTNlelFMSCtKMGhkNHphdHFZMERBbDJEQ3lnMS8xc0RRMDQ2U1A0MHl6Y2F5?=
 =?utf-8?B?bkRuejlrOUhHUTJGbDJEOXJySSsvRW1oZTB2dUoxalQyakYvVms0MFQ2WlUz?=
 =?utf-8?B?WDBxSTkvWUVjd1FPWlJ3RzBHaVRXUEUzWGVONksxTWIwWlBQQ0UrZkc3ZUdK?=
 =?utf-8?B?WGhDUVZPWkVKc0ZPTG1zd01FdmUzOGthZ2s0SmtwOStpemxkc3FUdm1VWGpa?=
 =?utf-8?B?cWtQRzVxMU85RE96MWJHL0svM2J6dEpvNHlycFJaVEFhRExmaE5BUDE0Q3Ju?=
 =?utf-8?Q?BHSY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30448b64-e6a3-440f-b2ba-08dce93b7e9d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 14:54:51.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGP2zliVBRdh4r8ECOfU9ISx4rr/BTzg/nsPW/GgVN1fH8AsvCVigCiGL5j1y36o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042

Hi Tony,

Thanks for reviewing the patches.

On 10/9/24 17:42, Tony Luck wrote:
> On Wed, Oct 09, 2024 at 12:39:32PM -0500, Babu Moger wrote:
>> +"mbm_assign_mode":
>> +	Reports the list of monitoring modes supported. The enclosed brackets
>> +	indicate which mode is enabled.
>> +	::
>> +
>> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +	  [mbm_cntr_assign]
>> +	  default
>> +
>> +	"mbm_cntr_assign":
>> +
>> +	In mbm_cntr_assign mode user-space is able to specify which control
>> +	or monitor groups in resctrl should have a counter assigned using the
>> +	'mbm_assign_control' file. The number of counters available is described
>> +	in the 'num_mbm_cntrs' file. Changing the mode may cause all counters on
>> +	a resource to reset.
>> +
>> +	The mode is useful on platforms which support more control and monitor
>> +	groups than hardware counters, meaning 'unassigned' control or monitor
>> +	groups will report 'Unavailable' or count the traffic in an unpredictable
>> +	way.
>> +
>> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>> +	enable this mode by default so that counters remain assigned even when the
>> +	corresponding RMID is not in use by any processor.
>> +
>> +	"default":
>> +
>> +	By default resctrl assumes each control and monitor group has a hardware
>> +	counter. Hardware that does not support 'mbm_cntr_assign' mode will still
>> +	allow more control or monitor groups than 'num_rmids' to be created. In
> 
> Should that be s/num_rmids/num_mbm_cntrs/ ?

It is actually num_rmids here as in default mode, num_rmid_cntrs are not
available.
-- 
Thanks
Babu Moger

