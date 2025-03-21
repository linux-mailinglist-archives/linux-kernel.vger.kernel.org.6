Return-Path: <linux-kernel+bounces-570598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14555A6B254
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461327B13E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234F200CB;
	Fri, 21 Mar 2025 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Te7doTm3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07999A31;
	Fri, 21 Mar 2025 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517368; cv=fail; b=n+2W5yT0zya/tPwDAIlKm23WDolJKZzgoiiBXzVuHYipdpf918RR7peqgT11N4HRhi742OVdhaYilOCXAwPyUDCv0YWotkFKfrU4S0oww2mAYvg+Y8TThdrrDgZMgaMmz9R2mNk/9D2LVo7idqbSvk8Pek9vu0MahZD0qg07MbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517368; c=relaxed/simple;
	bh=0CW7Fu6T5lPgWi1MOVVRkT+wD6nNdaQQgVETAH5XU7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jY5/8OK49Z376ZvjGW1kbQ5sR47m3sn7OPjMT4jEJvTc1PIIH8T9esYIZ0zP0WfAPjoTYAgUnkbjgG6XgJFZ4bCWPq1rvygYnk74p4mP5HCXtky7aqsD4PJESeSxSsa/w3ODIWzdwnnHMf0FBYxCxUmep7novpdCTIc/0MtTtjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Te7doTm3; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0PLn6Bedo5X/1EL8prm1WldvfaL6g9XjjdH+OYzjpbL1AnKoJSqmQyAewCtEiBVPxxtO9PQVJBuxVsSh1kSj5wFrCVmF3ethrEjl9tzmpYgj8gPuCk5dSJnsNR4AMoBrZap5+2VauZ/34szkBLRs9gemb2apCf8a3mlZEjkOluQVocfX5knaUkKQ0vlzbvnos3pwagBhL78WcOecO4UuDI/euvEP3ALFcTEunfWmRrHJrNLYHi6agYN+e6ppvTD+UnJYs6luqOpjbbhs27LLafmqepzysB4Rl7YMjNc+kRugKYyxvWtXyGv3D6DF27JE0ES0nzQ/NThIw6eF3szNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnUfra+YE7EP7CoCKLGSUX6Uzso8BX2QxXl81noPspA=;
 b=w2bLK5Ge+Oyo8zQvtHfDLCaGIUnzQ9p1ez9vgDUSxmelSeh5QOTFeQQ3WrS+Hlrmz8+ZAWFCu1S0XxZxR/mfn0eHJPRcVVLq+Ip5NXjH8ra4GOC65yZxB/WfNqpWyZD/f/KXu0GNYPebOR+B+tpnL3duMcIX7BYlr78E+wv1eSp/IF4uK1bfKW/N3W11ueT9Tz2TYVo/FWgBVqIJOI/UxJ4iZJLBqqduEY/dnJVx2v2Ad+VdKxOqp145wJEIsd3CKHpzjzVVU5G6ZZBNWWaKemKSvHAJUvoYhCHQ8/MN0KgWde2qTGlA5Knpm8PAkEo8XG0ZOdOnIVE7Wci73zuvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnUfra+YE7EP7CoCKLGSUX6Uzso8BX2QxXl81noPspA=;
 b=Te7doTm3+rA2DJl8K+X4EgpKrFRqwK6r5rkv4fiAkR3fGnKRU9jhT3DFrQ4k++IDVtZzWE4w6509Jli7A8OIH8C4XUiD22jTQH4IG7x5fdUk5eJ2c2hary8Ye5mI5U5BX1r3dDDNmSY6XNhKnSypc7tHdT1RXISoPUplp1B+Or0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 00:36:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 00:36:01 +0000
Message-ID: <4b66ea1c-2f76-4218-a67b-2232b2be6990@amd.com>
Date: Thu, 20 Mar 2025 19:35:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
 <c840cb69-41fe-49a8-a7a8-d75f68e1d84c@amd.com>
 <0cecd52d-253c-4b2d-9841-a86870d5945e@intel.com>
 <1244c9d3-233a-4da7-97d7-2c4097b3741b@amd.com>
 <c378cc5c-c589-43be-a101-e2c625f23688@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c378cc5c-c589-43be-a101-e2c625f23688@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0089.namprd12.prod.outlook.com
 (2603:10b6:802:21::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c909b33-a389-4243-1d1d-08dd68105aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXJCeWhCcVN0ZUpoakZxc3gwZm4xbTlqdDYxTmVqVUNRTlhlVXJDV3lMQTBv?=
 =?utf-8?B?U0JTWkRXdDAwOHBMZzBJT1lQTGNIWnhoSDVuN2NTWlFRbC9OUFlFR1JvcVpC?=
 =?utf-8?B?ZGY0WFFXRm1xT3NVOXludm9YNElKRDJGWDdBa0ZwWkFESjNWZlFGZ3dtVlFX?=
 =?utf-8?B?R2o3NGg3VkJjTWhkR3FzRDEyMStMWWFFQjYvOEV0TGhiNXhBTXk5L04zZldC?=
 =?utf-8?B?T3FHWVJxMm1KQ25RZjVpNG80bW5Yc1I0NnFXaDdFek1pb3J3ak9Ba1VHcTFk?=
 =?utf-8?B?bjk3SW0xWjI5anl1dUdYUm51bXA2VlVhREg3K0xQNFNzdHprOWNkY1JzZXVP?=
 =?utf-8?B?ZmdnN1pIU2Q4U0N3bVFXS0tBb1VjNC9oR3doaTYzSG9Ya1RNNUJuMXJpUkZ0?=
 =?utf-8?B?WUFFYWFGTld0MHBaOW5FZnRmeVpHV3EvMjRmRHFLeFBxeHZvb3dwNXNtYzM2?=
 =?utf-8?B?eTd5SnRFQVd6VkdQVmVsanFndW9mZU1vaml3enJiSjc5RzQ0VGRkcnprdFBR?=
 =?utf-8?B?aXg1WmVnVnR4dDQzeFplQTBmdXdkMjJuNmgyb1JTaW5DMGp6Y2RuMldPQ05h?=
 =?utf-8?B?ZHlXeDNMaS9rMklxYmtXaitQYXBObldWMm8zb016d2dvUEFaTTl2MVFCTEYz?=
 =?utf-8?B?dWNxdUdCRWJiSTBmamFvSStjQjdIWHY0M21Cckl3Yk5kOXlNQmJMcXNlZlEz?=
 =?utf-8?B?K3VheDYwcXErUDJMMU9LS1U4NlhKQmkzZ2FTNEFUQUV2WXZMMDN0czQ0RzZ0?=
 =?utf-8?B?OGExMG5wWkthZW5KQk1qRjI4UjJyeHRhVlhwM2lZNHhBcEJneVBQSHpwMnk0?=
 =?utf-8?B?Y0RUK3JFNy9saTZQUlBtREpvUlpkZnZwUnY4M2VyZDM2SXZBeFJPVzdFN3Q4?=
 =?utf-8?B?TGVWRnlvUmlySnhiWDhxai9xVlkrYWU3MFZ0c0VGNjE0RFEwSEREcVJpUGha?=
 =?utf-8?B?SEM3dVJjd0dnRFR5WVZOZEtvT1U0UWlsczBSWW9nUVlhT0lCK3FxMTIxWEtX?=
 =?utf-8?B?NUdNRHJ6eFlFVWdwdXNWVy9DUVFyaEhXR215VU81WHZtVzM2OHV5RjBNaDZK?=
 =?utf-8?B?SlhEeElKQnpoY2YyQVFETFFDakRSL0kvanE5QkJ4eTNMNU91WFZ0N3VjMGsz?=
 =?utf-8?B?Mzd0YnVCVE11c3F4UVNkT2MxMStHMi9ObmJzaExiWkNISTJqMDRUMHNoOWpN?=
 =?utf-8?B?RWNsUnVVVzlHVVQwQUlYdnlBUXdxUGt6WUtUbWlGRzA5YkJxcUVDSmI0VG9n?=
 =?utf-8?B?cllkelhsTktpaWNRQVd3a3FSK1N6Z1pUR2pNR3Z1ZklGVTVVbUZtUVM0aFBD?=
 =?utf-8?B?TFlTd0tiVi9LaGVVWkR3TG1Nay9uV25OUVhZZERzaENibGxDYlZTcTRQVU1Z?=
 =?utf-8?B?QjVZZEVkRE1XODVNNTJiTUVLay9tUVM2UWVFWUI2NmtyV0tGMzVjUkJtbVdz?=
 =?utf-8?B?ODZMMTROZmdXZ1hKMUxIUkZzWEt3K3dSWXRGblQ5QVYwR2tUZmxZM2RJalJY?=
 =?utf-8?B?aXdKMFJVeFRTM1JCN2lIajZvMXRZMWIxZmxPcWwyVW42cG55UnhuVDkvb09q?=
 =?utf-8?B?RTBsMUt5TDR5ZFhrSlpXdGtkaW5WU2ZLNWN1QnZybkdhVGZubjAxWkRDcEFt?=
 =?utf-8?B?b3RSWDM2V3A1M1p0azY2dHQwWEtXbGgzRGdlMFQzVTd2SGhKWnlWeGpEa04w?=
 =?utf-8?B?ZWlMR1VyQU0xRHRrQWNRWDBoQ0JSbW92NUd0NTBSQ0JFdEtzMkNBa0IwaDJ3?=
 =?utf-8?B?Y1h0NVFqQllaT21IeUJHR1JjbExyaThQckNBN3hQMUcrclVHSkJEQi9LR2Vz?=
 =?utf-8?B?a2dBZGVLQkthYTg0c1RVbS85a0lvZmVid1pscHBjc2tWRHMvcDhwd2ZQQU5v?=
 =?utf-8?B?SEEvRUc5eGhRNlVyYnh3b0RqamRMMVlDc3dPK0RSN0pUZ3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yml2amZtVDhZZ0lsOVBXcTNBVGVOQmdFVVNzTDA5ZTMzWmZmdnQwT2ZFb0Ro?=
 =?utf-8?B?RkhxaVM3bEhKZ0F2MUcxSEszN2hTVGRrcWcxamVsZjV2RlYyV2tMUy93K0ZG?=
 =?utf-8?B?NGhwWVpSL3B0STlYK1E3UVQ4djZxQ2hXQm5sNWhVUm4zdUYyeFpjdmdnSVM1?=
 =?utf-8?B?Q1IxMmNUcHlTSjFSWUdhUDR3dGd1cmxlL09VMStPL0pEd1o3WVVvYTA4aUF6?=
 =?utf-8?B?ZnZxMi9kUWhESm5VR0gzVXNwU2lUYVhPVFRrU2JZREI1R3lESllaRC9laHRp?=
 =?utf-8?B?Q1RIcnJiRzJpOGkxek92aGNTSm9uai9XVUxoYVJ0ZlJneUFyMW9LQnNsWS9Z?=
 =?utf-8?B?emFDSGVzR1hoZ05JZ3lpazArdjU2aitjY0xpMFVsampjd1hHdkJuVVdnRXVW?=
 =?utf-8?B?Q0g1YjBLa0dlR2l3eFFHZjJhSDdhUGhvVUg1YVR2T0kwQkdveW1PZDJDc2NB?=
 =?utf-8?B?eEw3YWwzSUw2VWNtVkJ6c1lwTVZwOWtmdGdMWm9sdzVxQ2g3Smw4RHRUQkNO?=
 =?utf-8?B?Y05KN2U1WXFaelErTWlvMGZ0SnUvaWZQbzY5THdHUFJza0p5WEk0SHl3Nitp?=
 =?utf-8?B?SUxCODE3VXBGNW1xbEg1NEswMFJxS1pnVjU4RlRoYVQyRXhvMHpGbmhvVTB1?=
 =?utf-8?B?U1RtRlFLVk8vYTM1MTRxWDhhbTdVeWZ2cDdVYU9UOFJObjlxN0U5MnFiNGJD?=
 =?utf-8?B?aVBLS1Rza0Y3bzNNc0pVUVpSMHkwNHBSMEtHYmZ4RFJWTmk3dnhEOFZWd3BM?=
 =?utf-8?B?bitQLzk4QWowSmFpUWpGMmVsUS9nN0hGR0xacENZRDdyNHh2eUVRLytpTWVR?=
 =?utf-8?B?UllwdVU3Ymd3NEJ6b2Z6MEZHZTFGaW8wZyt1bUZlZThyd0JKQkNUQ093QUxK?=
 =?utf-8?B?eEtmZ1dKY2o4M0lkcHdFVCtueDFVZ1pWNVE0Uy9CZkhFYk9HdDBpa1pkMkEw?=
 =?utf-8?B?cXpwNlRWU3dsV0VOUEZwcHl5djdqVzlmKzNMd3NsKytZSE5adVNrUkZIM2hZ?=
 =?utf-8?B?SVZDSHI5VmtIYUZZVThhVjJjaUYwTzhkT1hHNUVmRFF3Y2RrMTEyZUpHL2VG?=
 =?utf-8?B?eVROTTVSYk9OR3BnV3hyVnRZUGhVenl1RmpabEFuWkd0WVZUTHhoZjNESkRY?=
 =?utf-8?B?bDJIN2VGSFAzZWdBYmhMUTQ0WlhNQWk1cEErSWQxVUdiUkcyUE1XZ2hTUWN1?=
 =?utf-8?B?Q1Y1aFcrK2lQZmFpYlI1VXY5UGM3S0pNcDVORDZPMW52RDJGUUptdVNxYkZq?=
 =?utf-8?B?clBoaUIzMlZQMzNoa2QySE5OamhQTEloVTY3OEwxd1k0VzVlV0JmY3JReFBo?=
 =?utf-8?B?YmNVbEJKckhTSHdsRHF5eXF0dHkxOThZU0grbWZCWGt6U1RkaWlJT2I1U2d4?=
 =?utf-8?B?WVJkN1hUdTBSazNGQjVhbEpYcHVFT29iTUlsa2xqeHVkYmlDOEtQNzZsRnpR?=
 =?utf-8?B?bWlZL05veDFWSkJ5ZDg4NEdDcFpnUFZ0Y25weGVXcCt3UmFLMFFKaW1LOFpL?=
 =?utf-8?B?N3d2d2xnNUJSSjZ0eWxOdVRtNmJ6UFMrczQzTTh3TjRPZUlHKzVkVE9lVXZ3?=
 =?utf-8?B?aFlEdHlhQVdWZ0lyVjFsOCtSdGYwc3RicTN0alVZRDZCTGxCeEp4NjJxbWpO?=
 =?utf-8?B?SXBqNjVVbUxWWWRQalZkbXdPakwyOEx3alp5VFFjVEZjN003SXlNYm5KbTZ6?=
 =?utf-8?B?YkxIQUc1T1JVRkhIOVNmdUNjb09sS3gxZFFZRG9lQk16dkhzL2FYbjhkdXE0?=
 =?utf-8?B?YXBEclVGOUVFbVhjeE4rSDBMbzdndTd3NjB5V3ZqL2xHQmlPcUZLUStjTGd4?=
 =?utf-8?B?V0dETlBZb0dZNFBsNGtjRGVJWi9lSzdGdi9kdENoK3BkU0hxYUxXSTRqc1lX?=
 =?utf-8?B?T1ZtNW9nc3l4UVIrcmUxTjNhKzlHSGJXcUd0UUpabzE3UlJjMDdWZjA3YU1H?=
 =?utf-8?B?QzUyek5kcS9QUitjVDg2UXNPSERwbm5yYnhhWW56VmtlbVd4N1VqS1FES2ph?=
 =?utf-8?B?b01TL3hBdFhBdmJWamJic1FMTytNZkt4VHIyazVGcFVxUTlyTEFqMys0WUI3?=
 =?utf-8?B?ZkRNRTB1dWJvNlVHMS9OcC9WeEpDZFJBVENMU0lGcUFKYjFTRFJ1TGtQb0Qz?=
 =?utf-8?Q?FPpA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c909b33-a389-4243-1d1d-08dd68105aee
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:36:01.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUji8jwYYIEl6pFc0OlazyQtaZsoo76+QQFCwbNgxdjVoEECA8wTtmsSbjOpNuFY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609

Hi Reinette,

On 3/20/2025 5:35 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/20/25 11:12 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 3/19/25 13:36, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 3/14/25 9:18 AM, Moger, Babu wrote:
>>>> On 3/13/2025 4:21 PM, Reinette Chatre wrote:
>>>>> On 3/13/25 1:13 PM, Moger, Babu wrote:
>>>>>> On 3/13/25 11:08, Reinette Chatre wrote:
>>>>>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>>>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>>>>
>>>>>
>>>>>> Here are the steps. Just copying steps from Peters proposal.
>>>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>>>
>>>>> Thank you very much for detailing the steps. It is starting the fall into place
>>>>> for me.
>>>>>
>>>>>>
>>>>>>
>>>>>> 1. Mount the resctrl
>>>>>>      mount -t resctrl resctrl /sys/fs/resctrl
>>>>>
>>>>> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
>>>>> will continue to depend on BMEC.
>>>>
>>>> Yes. ABMC will be enabled by default. ABMC will use the configurations from info/L3_MON/counter_configs. ABMC will not depend on BMEC.
>>>
>>> I see. The previous dependency was thus just something enforced by OS to support the
>>> chosen implementation?
>>
>> Yes. That is correct. We went that route mainly not to change the
>> rmid_read operation.
>>
>> With ABMC, we need to set Extended EVTID and ABMC bit in QM_EVTSEL
>> register while reading the cntr_id events. Will add those patches in next
>> version to make it clear.
> 
> Thank you.
> 
>>
>>> Looks like the two features share some registers.
>>>
>>>>
>>>>> How would the existing BMEC implementation be impacted in this case?
>>>>
>>>> BMEC will only work with pre-ABMC(or default) mode.
>>>
>>> ok. Does this mean that if a user boots kernel with "rdt=!bmec" then ABMC will keep working?
>>
>> Yes. That is correct.
> 
> Just to confirm and bring the two email threads together ... it sounds like the
> expectation is that existing users of BMEC are expected to use mon_features to
> know if mbm_{total,local}_bytes_config are supported. If system supports ABMC
> then BMEC will not be available and thus mon_features will not contain
> mbm_{total,local}_bytes_config. Existing users that rely on
> mbm_{total,local}_bytes_config will experience failures and are expected
> to switch to ABMC?

Yes. Exactly.

> 
> 
>>
>>>
>>>
>>>>> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
>>>>> files will remain and user space may continue to use them to change the event
>>>>> configurations with confusing expecations/results on an ABMC system.
>>>>>
>>>>> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
>>>>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>>>>> llc_occupancy
>>>>> mbm_total_bytes
>>>>> mbm_local_bytes
>>>>>
>>>>> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
>>>>> and mbm_local_bytes_config, which may be the simplest to do.
>>>>
>>>> yes.
> 
> 
> ...
> 
>>>>>
>>>>> I do think, and Peter also mentioned [1] this, that it may be useful,
>>>>> to "put a group/resource-scoped assign_* file higher in the hierarchy
>>>>> to make it easier for users who want to configure all domains the
>>>>> same for a group."
>>>>>
>>>>> Placing *additional* files higher in hierarchy (used to manage counters in all
>>>>> domains) may be more useful that trying to provide the shared/exclusive/unassign
>>>>> in one file per domain.
>>>>
>>>> Yea. To make it better we can add "mon_l3_assignments" in groups main directory. We can do all the operation in just one file.
>>>>
>>>> https://lore.kernel.org/lkml/efb5293f-b0ef-4c94-bf10-9ca7ebb3b53f@amd.com/
>>>
>>> I am hesitant to respond to that message considering the corporate preamble that
>>> sneaked in so I'll just add some thoughts here:
>>
>> Yea. I noticed it later. Will take care next time.
>>
>>>
>>> Having the file higher in hierarchy does seem more useful. It may be useful to reduce
>>> amount of parsing to get to needed information. Compare with below two examples that can
>>> be used to convey the same information:
>>>
>>> # cat /sys/fs/resctrl/test/mon_L3_assignments
>>> mbm_total_bytes: 0=unassigned; 1=unassigned
>>> mbm_local_bytes: 0=unassigned; 1=unassigned
>>>
>>> #cat /sys/fs/resctrl/test/mon_L3_assignments
>>> 0=_; 1=_
>>>
>>> We need to take care that it is always clear what "0" or "1" means ...
>>> Tony has been mentioning a lot of interesting things about scope
>>> changes. I assume the "L3" in mon_L3_assignments will dictate the scope?
>>
>> I didnt think about the scope here. I was thinking of changing it to
>> "mbm_assignments".
> 
> ah, I see, not a general "monitoring" file but specific to MBM. This still
> may encounter difficulty if AMD does something like SNC where MBM could
> be done per numa node. Perhaps we could constrain this even more with a
> "mbm_L3_assignments". If anything ever shows up that need to do MBM
> counter assignment at some other scope then at least we have the option
> to create another file "mbm_?_assignments".

Yes. Sounds good to me.

> 
>>
>>>
>>> With a syntax like above the needed information can be presented in one line.
>>> For example,
>>>
>>> #cat /sys/fs/resctrl/test/mon_L3_assignments
>>> 0=mbm_total_bytes; 1=mbm_local_bytes
>>>
>>> The caveat is that is only for assigned counters, not shared, so this needs
>>> to change.
>>>
>>> To support shared assignment ...  I wonder if it will be useful to users to
>>> get the information on which other monitor groups the counter is shared _with_?
>>>
>>> Some examples:
>>>
>>> a) Just indicate whether a counter is shared or dedicated. (Introduce flags).
>>> #cat /sys/fs/resctrl/test/mon_L3_assignments
>>> 0=mbm_total_bytes:s; 1=mbm_local_bytes:d
>>>
>>> b) Indicate which groups a counter is shared with:
>>> #cat /sys/fs/resctrl/testA/mon_L3_assignments
>>> 0=mbm_total_bytes:s(testB); 1=mbm_local_bytes:d(not needed but perhaps empty for consistent interface?)
>>> #cat /sys/fs/resctrl/testB/mon_L3_assignments
>>> 0=mbm_total_bytes:s(testA); 1=mbm_local_bytes:d(?)
>>
>> This format does not tell what is going on with all other domains. We need
>> to display all the domains. I think that is important because users need
>> to know what to expect reading the events on specific domains.
>>
>> I think we need to convey all the following information to the user.
>>
>> 1. Event Configuation: What is event configuration applied here?
>>
>> 2. Domains: To which all the domains the configaration is applied?
>>     This is useful in multi-domain configuration.
>>     We also need to know if which domains are assigned or unassigned.
>>
>> 3. Type of assignment: Exclusive(e or d) or Shared(s) or Unassigned(_)
>>
>> 4. Finally: Where to read the events?
>>   This is important when we add "mkdir" support in the future,
>> mon_data/mon_l3_*/config_name will be created.
>>
>>
>> With that in mind this might be helpful.
>>
>> # cat /sys/fs/resctrl/test/mon_L3_assignments
>> mbm_total_bytes: 0=e; 1=_
>> mbm_local_bytes: 0=_; 1=s
>>
>> This format tells the user all the information.
>> mbm_total_bytes and mbm_local_bytes configurations are applied and
>> configuration are coming from counter_configs.
>>
>> User can read the events in
>> mon_data/mon_L3_*/mbm_total_bytes
>> mon_data/mon_L3_*/mbm_local_bytes
>>
>> mbm_total_bytes is assigned on domain 0 and not on domain 1.
>> Reading the mbm_total_bytes on domain 1 will report "unassigned".
>>
>> mbm_local_bytes is not assigned on domain 0 and assigned on domain 1.
>> Reading the mbm_local_bytes on domain 0 will report "unassigned".
> 
> Thank you very much for spelling it out. Much appreciated. This looks good to me.
> Please include your list of requirements for interface in the cover-letter and/or
> patch that introduces the interface.

Sure. Will do.

> 
>>
>> I dont have much information on shared assignment at this point. Dont know
>> if we can display shared group.
> 
> The proposed interface accommodates shared counters. The expectation is that
> users can keep track themselves and if not, then the information can be
> obtained with a read of every group's counter assignment. The issue here is
> that this may worst case need a large number of file operations if expectation
> is that it will still be possible to create num RMID monitoring groups.
> 
> Using files inside monitor group for this information may actually not be ideal.
> If this information is needed then we could perhaps add a new file. For
> example:
> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes/<file reporting which monitor groups share this counter configuration in different domains>
> Of course, I do not know if this will be required and this seems manageable as
> a later enhancement if needed.
> 

Yes. It can be done this way.

Thanks
Babu


