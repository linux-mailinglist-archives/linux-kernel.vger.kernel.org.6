Return-Path: <linux-kernel+bounces-225015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1F912A96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA2EB23D32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A715B13E;
	Fri, 21 Jun 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OgJcKI6j"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E3BE4B;
	Fri, 21 Jun 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984869; cv=fail; b=A9T3hVc2aS0fVHRshBZzHwY18/MWzN0DM3dp5l7BT1kQtFM1/lm+NQ0jLKndX2s+ZrMF4KCiHRvk2XeW96EClK1sqE8jMygzXLUAThWrD2tTwHFGSZLAMwNuGT8dBIKt8R/rD8gdSeeZH8HUrRZisdTK3bBsP3bPHA8FcpcOOTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984869; c=relaxed/simple;
	bh=G/imw7sE+Byw2XRboLp0Zgo/jB3ca0TkODW6g4bBGAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PYL25RYtcZ3QLlzv8AfVBb0+ox2D2V84yOwSIVfz57mVKLq+Tsv/NWIxpWJQ+5RdUQxHvhvIYzVX0hBEfAZ7y7442AhTnhCg7EFjMns8HQ37icbIhcL2f52op9tg1xKF7SWlDXwpUyP9QERViWM6/T+CUxhpM0n3J5YBk/wdQEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OgJcKI6j; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsLBvD4fZ6Glly8ZcWqaD9T0K2Yu2J56L/cmPqwOPGocEnMLcTsUP5dsItRvVzryQcOqVLIkUbzZ96FnbTqFaYHbbiZqWOdQJmGGyoPUSotwuF++KDviN0nRzVZHJLzGFWTKzSxax6H/AtcHAERCkOWpEI36sznOnB8mIb67gUpi+CJIOJqHyg9Cf1OihDfglphlkBhWivLfMfbC2ZcWRSxBIOJpLncMNwprn0Fzd0Dxx2mkEo19pvOLzrYJe9fKlJU/9rCqo6I56Iuy+ikPdFy4dcprERPhQ4D5vx1T9DrIC5b3giyawKvl02A/DIzNl1sqMBn1ngaWU0dydxrAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBmSMip+jwQ6O6tpGQrsiFPoshpCckOV1NCmZp7BnHc=;
 b=ZkMIykitIpmFqZEuqeBM9P/yrSYEjdtY/7/CQ2scVstabVb8cMLB/Q1DaXEhMBIHQg0/Y9x8xNp6B1WzHP/k7D7NS0RwKCOD3Pq3OJFk7pA+qoVvO61G7onqsq7la9XsEYGbyThMU/iZ4PLIXaQZbJefp4/OqhZHaKVBH+eZeFFb/YIo2+pzBsazl/mf7ZVjI889HmVxSjT4JhuUVXDJkhO3JSCFD56+T/aqrBz+XYi27jqoeUItgF9oJ4aYRZD1nH+y6L43XlV8iFJYO/lsq1qN2vnUvNOjBsPn9BUmJ56wwW+adjFTmRch5OOQ3f1fNrPacVfedqacdvMMrhQFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBmSMip+jwQ6O6tpGQrsiFPoshpCckOV1NCmZp7BnHc=;
 b=OgJcKI6jxTEohaRlR8MPI2kSU8sd7OLmTSDqjenQDvx+0Ezu/rE8Sz8ox1FnXW8OOk0ABurKFjDR1njpr16IrWVRc7xSEfXwNsJ25j6Z/9bX22B7ATt8emyAjQb75YZvl84HcdpTX8UgxMnsFlc8wJ7fXkeaQeEZYUzDi/RjBxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 15:47:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 15:47:37 +0000
Message-ID: <0fc48134-b1c8-f46a-0490-10b7c724a871@amd.com>
Date: Fri, 21 Jun 2024 10:47:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 08/19] x86/resctrl: Introduce the interface to display
 monitor mode
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
 <3b9ef8bc03c1004794a087537c6f2f051760402d.1716552602.git.babu.moger@amd.com>
 <a453b19b-a909-49a5-9512-ae69c48db6c2@intel.com>
 <b792d729-669b-4785-bdbb-23230f2e993e@amd.com>
 <a14ac6eb-0ffd-4c11-9c9e-ea70f8d4a70d@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a14ac6eb-0ffd-4c11-9c9e-ea70f8d4a70d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 378fa535-99cd-4b6a-7908-08dc920979c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG9GL25saU0zdG5pNVQ4NTlFWFdCVXVkSHVUTG5xSWJPSk9PZ2V3RDVWMjFF?=
 =?utf-8?B?T3cvRmc2bEFZZi81MzNxNC91RXJKbnVQYXh2dnNxMytETGs1QThrbzZ5dW9u?=
 =?utf-8?B?K1F2NlV6dVlyMktZdHlWc3lJdERqZTI5ZkVCK0JtYWJ2Yjc4MXlWVWtFTnJ1?=
 =?utf-8?B?TUM2K0JEcUJTOWNtTHpxYUo5WjVHb3VSVExWR09DNkhVWEFFY3hlYmU5dVZC?=
 =?utf-8?B?c3lvSEQvY3Rmbk1BWWdRYW1sTUJMU3J3U3NXR3Q5WjBxc0ZwU01oTFRXSWZ1?=
 =?utf-8?B?Z0MxVVU1WUx2R3h4REl6cjM1dk5Kbmw0MWxhUExOSGdxclJibm9KWDZWN056?=
 =?utf-8?B?WS8wckdKbGNlWUl2blJRMzdnVy9OWnZnRHF1NEF1b3NtK09zaERVOE9uQ0VO?=
 =?utf-8?B?enlGanZoRTZraW1PTVdqSFc3NHpYRDFFQUthR1prRU9tYU9xbERiamdId1gy?=
 =?utf-8?B?L00yOFU4MlBmUjlmRWdrYkZxS3MxNVIreGRmRnRBUWVkUWZRbjFqUVQra0Ux?=
 =?utf-8?B?U2xWd3JoL3g3Vks4cndJMWFQa1R4Wlk1WDY5UXR5TFErays1RytraG5jSGp1?=
 =?utf-8?B?OUFVYXU4THVZYVYvekFSOXlxQi8zdUNYWVBkMnAvbTNwZWI0Ykdvc2VwMDlP?=
 =?utf-8?B?d0tXSXBjZFhPM29yOHF4VDJpQ1ZhMlA2MXN2SFFRc2RDR3JCT1dhZnhkanky?=
 =?utf-8?B?MjJ1WjdrVlNpZndDVUpPWkczSjB3YUU0dHJMVHhUNmtOaHhhNlIvT0lRNjUz?=
 =?utf-8?B?MXQ4WWV1VFpsSVZkaTNCdHh0Rkx5c2lJT2Zmc2trNGFuc2E3dnpqa1pubUpo?=
 =?utf-8?B?MC9aRlArYkVUNWVrTXBHZm45MUFjNklHdFZkWjZvNGpIU3QxSldsQXpscytx?=
 =?utf-8?B?aEpQU0o2Nk03TXNTVndWbytDRVhjejgxb3Z5ekNDWEFRS3paNElBQXFwYzZh?=
 =?utf-8?B?cFNua1llbkJMbHFzejh5SS9IbXJidW1hQ1B6MGpYTG1ZYW8yZ1JHMUlYMDcz?=
 =?utf-8?B?MThHUHljNmIxbklRUFNKRjRWY3FYMitXdWNnS0FVTkJyZmcxR1B4WDA1aTNS?=
 =?utf-8?B?MmdZU09vZkZGeVEza056Wmx6Z0FaNEcyd245MkRoemtMSmRXVlA0NjRselNr?=
 =?utf-8?B?Z3FBM2pnSGgrMHNNZEZSL1kvd2ZpU0Z0bkxRbGVTMEY1LzBaeHUzUFY5QVpG?=
 =?utf-8?B?Q1ZXb0xLaytVYmJmV3FMMWNaRy9oc0pBVXhLVjhJazhoN2lhcE9wUVhHRXc4?=
 =?utf-8?B?T0xSMDBYUFBwN2NsZksvMEhuSXk5Um5HUlVYZklpQ0Z6WEtaeVY4Q0MyaVpS?=
 =?utf-8?B?aDQvV1dZc1ByOW9vTTlwbEZvY08xUmkzTHdSd0JuQkNVa2FxeHRzMlF0TGdZ?=
 =?utf-8?B?dkpWVjdXS0FPa3Z0K0FLMVg1dkQxMllXTlNaRk9qMXJjaXN1YTVzNmVPMmVj?=
 =?utf-8?B?WlhMQU1TU3oyQXRTS2tWUlJ1aXFHV2dUSWVLMW90WGlqWkNxWHVhZW5Nclpz?=
 =?utf-8?B?RjBMQWRybkI5elBmbm9HWjRjMHBrRXFGYlRoSVVxRkduSnEyZXB2bHU2Q1VY?=
 =?utf-8?B?R1ZuNUg1SUc1aURUYWlvbkkycGlmMkhnYzlRNStuZWwybWZ0ZjlRT25ybk11?=
 =?utf-8?B?VEVtSFhjQXRFTFMxeDUxQVhxbXd0ZkxjMmJhdmdUTzBJQkFJTmdweVJTellO?=
 =?utf-8?B?Z2VjcU1udzcvUkJVbm9tekhSTUoyemE3NjAxdlF1TFMxaU8xNHRPaUVFYUI1?=
 =?utf-8?Q?d/kdACEB4sIcxSOoTJUGdZKJQqxh8sKJp688L4f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2NudnB6bkZZbFZ3V0xDVlExU3hTd2RRdUpOc0ZvZHZBNHBseDNvRW5nZTVO?=
 =?utf-8?B?MlVDekFEQ2N5UUM4OHVFMTlZR2NYbStQb3ZObXJ1WXM4RzRnOVNpN3owZkhB?=
 =?utf-8?B?Qndjb2h4RTU3N2w2SXNxWEFDVVV3SjdqY2NYMUtQdTEvRW0vSFVnYXk2dWgv?=
 =?utf-8?B?bzR2Y1YySlRZbkVoZE12cVpnYnhTUDhrY2RjK01EU3c1eTNDakFhYTVzN01C?=
 =?utf-8?B?RmxuWWpWT2lvWVpjZFJVeHMvdzhjaG1uZHBnRHBkVzVEVDdBWFdKUGpWTFpU?=
 =?utf-8?B?M3FPTmk3OVlEdDJwWVloVnlNbm0yOE5meHV4dWQzYlZscjhKWFlmRXRJUTVZ?=
 =?utf-8?B?UEQ5OCtSNWFxd2dGcXhYeW5OL1MyTGxpYVhxS0ZIckZHVzhnVHBFdmxOeFp0?=
 =?utf-8?B?UUhhU1VZOGZTSGxVUVpjMkRaTkl2VEtGU2lsaVAyNGdUTDRhMHhqNVlkUWpa?=
 =?utf-8?B?aEVEc3hvSFBXZGNxdkx6MjFlamZLTzMxK2xLQ21qMUZBOTlNSUwrc0lsMEVC?=
 =?utf-8?B?YmFlL3JNS0tJV2lQVWVUTjErODdiTmtHaXZTajd0eWFKckwveUNMTkRSdjhh?=
 =?utf-8?B?U0pxTkhaTkU0cFNRWUtrRTA5OVg4N1pwNkRRbEJXU0V3ZXg1YW1yWmNwc0Rq?=
 =?utf-8?B?Ym8rRllVM1F0NUQ4eCtvQXR2YUpPaE5jL29LOWx6UXM2RFJ2VmZZLzVIRk90?=
 =?utf-8?B?NGlsRmRmL2pmL2RKMVoxN0MvMTZndXk1czJ4N2NOdXA0SkpKaHpjeXpNZysx?=
 =?utf-8?B?NU1CZ3lnTXpKenNRa1V2dXROenZBVmJUY0d2VituN0o4aGJyRjNYVXRrY2dZ?=
 =?utf-8?B?QnpZK2J3bWhIcVdlZnFhQ3hyRmh1MG5oTS94SXYxbmczbFpwWWYxMjJqblJv?=
 =?utf-8?B?Ny9meS9MaWl2OVY0STlXeGVjdTgzTWJSOFB2WGpTYXZ5Y3B0YlJjOE9rczlV?=
 =?utf-8?B?VWlTSkJlOUZYK3plOFYwajIxMllBbUlZZFlLSlVVNDhFb0RCMHFMUGFSOS9k?=
 =?utf-8?B?ckU2ZSs0ZTRWZHgyL0ZMbzdGbkZMVnBpYVNkZWN2OEtKVHh2WkllRG1nL2Qv?=
 =?utf-8?B?WEpqdWMybUFPeEtGMWg3WHZSTkxBdE5qSnlpenFBTmZQajBybk9pZnp2czhT?=
 =?utf-8?B?YmJPREJtNU1zdWJWdzJ3S2tXVWg3alhWc1lkTm1BS29CSlFnV3hVb3VIUWo5?=
 =?utf-8?B?RzRFUXJBdzJuLzNZcEJMbnMyL2MrRFNPQllOMzUwMkZvOENZcjBmN3BvM09s?=
 =?utf-8?B?bEhqSnVrZEpEdlpaOWt4YURKMzk5MnQrMG00WTVGR2pTeVI2d1MzbTZhaTJG?=
 =?utf-8?B?a1ZHS0dvUHczZzQzbU5haUJMOHhRdzJTVnA5SEk5YnJKa3B5UllRRFBBVDVq?=
 =?utf-8?B?L2xBQ08ybXpsNVZXZjRJZExxOGRRUUNDc0hqT0NVZXRmZVg3aGQzcE1GOWoz?=
 =?utf-8?B?WjVtRXFQL2h5QmFqZ3ZGekx1eVpPNnF3Z29hU1J3ZHZmWGM3N3VLYzE1SGgy?=
 =?utf-8?B?U2ZTcHF6b2c4ZVEyZkw2VTJTYVI0YldZcjdUQmRNT1g5NFBMUFFGTnpoU2d6?=
 =?utf-8?B?aHQreEdjdmpGRkZ5THhoL2VFSzMxZFdSS1UweG41aS9uSVFtcVU2RERoQjZK?=
 =?utf-8?B?M2lSMUxvZGtqWXo3Q1dIUC8wb0xlWE8wOGl1YVFuN0cxRDBXdTl0THorUmJO?=
 =?utf-8?B?eW5LSmlvaG1BZ0Ywb01wRC9sM3R5aE1tWDZzdDBiUFpzWGRDMEtvUlZWcFNm?=
 =?utf-8?B?c25ES0FITHF6NVdsQ1dsYjdKUDJjMVhKN1VmWEFxaDZEclBKblJvZUZ0d0Ez?=
 =?utf-8?B?L2ZyYWw3TGVGRCt2ZlpIdjJNa2xJWjM3KzROQTRGRUM3a1RVQUFXWnNnc3Q1?=
 =?utf-8?B?eHlDQVMvTVRvZDl3Y0ZxeERGR3c4K29IY2orTFdBdHUxc3R6V01meGgrelNO?=
 =?utf-8?B?NkZSbUwyUjJoSC93bHpLeTZ2YjZNMDBEYmp2cTlFdllwVjJxbzFTUU5PTTNI?=
 =?utf-8?B?R2Y3OWRUUUI2a0ZXbTdoUSt3cnpsMjF4QU1RdXo1ZU9sZEp5bHhSQ3dVaUxj?=
 =?utf-8?B?RFJ6dDVWVjhQaWxQSGFIK2pMRjkzMGFWSVZDeVJkRWMzZDlEWFNUbng0U2NI?=
 =?utf-8?Q?QUM8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378fa535-99cd-4b6a-7908-08dc920979c1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 15:47:37.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Td3JZ0s0NcWEe5pQcNAGD91gr2ro3M3rDAOuLxN2ElETZC49grUTyJcxu03cToGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511



On 6/20/2024 5:05 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/19/24 9:25 AM, Moger, Babu wrote:
>> On 6/13/24 20:40, Reinette Chatre wrote:
>>> On 5/24/24 5:23 AM, Babu Moger wrote:
> 
>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>> @@ -261,6 +261,16 @@ with the following files:
>>>>        Available when ABMC feature is supported. The number of ABMC 
>>>> counters
>>>>        available for configuration.
>>>>    +"mbm_assign":
>>>
>>> This name is not ideal but I am having trouble finding a better one 
>>> ... I
>>> have
>>> seen you use "monitor mode" a couple of times (even in shortlog), so 
>>> maybe
>>> that
>>> could be the start of a more generic name? "mbm_mode"?
>>
>> mbm_mode sounds good. Like this.
>>
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>> [abmc]
>> legacy
>>
>> Keeping just "legacy" vs mbm_legacy.
>>
> 
> Looks good to me. This sounds generic enough to build on.

Thanks
-- 
- Babu Moger

