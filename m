Return-Path: <linux-kernel+bounces-549857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A004BA557EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF04E3B3307
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD720458B;
	Thu,  6 Mar 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="saLIhU19"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8191448E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294597; cv=fail; b=PbkRkSsg+bp6asF1MWukWcwhlm78plMVqlEMsyRY3cccAkVnnklGiCxLZAOeK2i9Kw7sdeGF0AIa4vYM9TPJvYfgFyPLPjNVcJ9Gf3YdRj4tmVJ4JiUmeAY6irnj44bqvKpJl+VhpQN6L1nCmcLrWieT9N2PhtqJIInlKR5GSGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294597; c=relaxed/simple;
	bh=2SP24WJOFLiwost02n45YhU0/1PSkJppFSiKhIS2U/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qzIhdehMExupBS197pKFZs4azs82W97Qp8+nAI5I1cOfFw9RtuNDLepdLdAXn3DCqvgx8l9RVccbXgDPHnwg8wMo34mHxjpS0yMaY88njg3a+/lwmp7Jx8+iF+qdEXiTf3DPQIaTpXOPwvgnUacb9O2JIrONs6mstIWDkPSCOhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=saLIhU19; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH8QYJT+Fd1WXfdETgMEasf3pZTA7ekB5sj4+2SXZTPwUT8uzM4flvcjbmAhg4PoL1XBeJDOCQ24a3cmNPV9YhFmR5dtaSQXGXqNggRhekERNF21EbE2UdoXmNtyGXDpqqgGpF8U+G/jAKgwk9w8p0QuC4wnMqI24JRLSFs6jCLGTwZ89IQ0ttfBcPgA4Wi5gPi+WLevDaTrKsqo1aBVTTv0AeR/5fTsdCTdH+sG8VG8wpsa4Cn2emzukv6wAmDDqmlKL8Uhxxmct4evO5SwD13AMqMEWkIlB15WZTRcUk2IDgy/FPliPNgFAjOn2UdeKX7bMMOHkQtdMZibTsY1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SP24WJOFLiwost02n45YhU0/1PSkJppFSiKhIS2U/0=;
 b=yXZ53jS1ZR57V+rXtXgF40rzuqgyniMJjYYXRqQfTAZbmrpEo2IlNVVtHS6EuMH30tuk3SzZjbnkveICzr6WGTPHraUXsXqHLm4mJFSmPKbrmQ/Ji/c68Ju+RCeg1z1JOzvkQfs/YCs9Lip3vy4FRQXQFk0WAW/lOHK4OiYlqtyn3XgX1s3BqLJp+XNYXk66FGx0n7YDbuOpPeFafMduG5wPM7K8xr4858rIeJ9iDChu8+GehuQUVBV1/cLPbKjR5kyX+NKaxfxegZXGKhLUd3SX3jJ27HiAc0lYHAna/1BsBrEqe93XKzcOyqwny5nsEawI+cXbhmVpaQlXDI4jRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SP24WJOFLiwost02n45YhU0/1PSkJppFSiKhIS2U/0=;
 b=saLIhU19ovDXxtj9zMucrjPqcAd56Bc0OkSYpz1DXqRZdZo33x/2KGZsCcYLB0xd0tz6t6xMHP7DZ2FAob7eay+f0TM4hFEutQdP1s4a5o/npt3DdSU3dO0SuWelHQ6xjpNIQuaHl9gSoGlCaxw/q1eVZH08DFFnAo4sQ/u4y1vOAXpfOrHmRc72IHz9f9RrX532I/9k+Sybj99A1WNxIx9+HNf1pf/YnQKoBwojcOk8h7yJj5/L0oEcRD6MBS4L7itir5t/fdgwjl4YVGDf7ZMNNgnLEP+eBNC+VF16N1IaPHwZD1C4r4VYM4A3ey6l0iyqW/TJWkBaTf6c/BnWdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 20:56:33 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:56:33 +0000
Message-ID: <37c8bd95-5cc5-41f7-99a5-6e701cec80e3@nvidia.com>
Date: Thu, 6 Mar 2025 12:56:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/49] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-2-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-2-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:40::18) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: ac11b8b7-bf49-437a-a961-08dd5cf1606c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1RYSnFENlgzL2FVQXdhcG1CS2FBVFRreFZwK3p2RmEzaEJScThjRDVGYWFX?=
 =?utf-8?B?aWptU2JReDJUcGxpN2syWVc5TnpKZkJBWXBCS0d5dnpDSjN0RlBIUnltL0t4?=
 =?utf-8?B?NXBIWmlUTTVmK2pzVHl2RDg1eXFqZ0lYSTFhTlFIU0ZCVUNtTTNZR2ZZdjJY?=
 =?utf-8?B?SlJ3YjhNRS9uTVIzZndpSEEwcVVvNmhSbzM5UUxicitXcnY3c25ZL2MzTjdY?=
 =?utf-8?B?dldQdmIrTDJHSmJhTkx2ZGp6WHMzam9XeXNYdHBEblc3alpQNDRXc3lIMG9W?=
 =?utf-8?B?YW5vNjBTaHdoRnVzS3czZWI4UXg3RzlmSTdzUlJNUXZjaGRXa0dkUUNkazlh?=
 =?utf-8?B?eTBMQkNFWmEyL3IrN0R4aFVETm5mcW5BcWNpU1BQVldmdDMySlA1Mnh2R0RF?=
 =?utf-8?B?WUNrVmRDZStoRjU5WDJZOHZ5Zkw5OHdvZmhSQU1rTVh1R1duRVplUyt4ZUdn?=
 =?utf-8?B?RWp6WW5NWHJ1ZGM5WWs5TlVNQVZMOFlCWlNRTjFQTGpDR2wxWHZPWXhvMHZo?=
 =?utf-8?B?TkJCMXN0aTN0WVJscjMveHh5Ly9YVGh2Y1UxcEV2c0JhVXJHOExpa1JHMjFY?=
 =?utf-8?B?QlZqcldkaEFTeE1HdVRmTEd1RnNsRFVNNm1OYjRpK1MySFhITllJaDgzOEZY?=
 =?utf-8?B?NzgvWElPT3d0amIvelc0K1E0NXdKdVJlbUFxZ3BkMndQNjN2cm1tOC95ZkVp?=
 =?utf-8?B?dkFXUzA4ZmJ3aitjQitmQVZVNlBnd09ELy85cGREajhXNk05U0h4ZHFUSFNs?=
 =?utf-8?B?STg4enFRd0RRM3Q2aE9kYU9SbWhsc3pvaWs2bzRWdzg2WGtHLzc5Z0x1Z215?=
 =?utf-8?B?K1lheWJzTmwyR0tLZE9HM2hZSmIxaFk5MDMxZGJtL1VneTRJb0JmdnQ2OVZP?=
 =?utf-8?B?R1RtcXpVWkZQU0FOeTNxSVJoUmErdzEvZXB3Z1FNTnFQR1RtUU1xNXhZMElC?=
 =?utf-8?B?Wk1kRE1oVkRlR3lBZEt1U2IrOEpQZlpDN1BSZmMrdk5MVW1KRS9XaVM2WFQr?=
 =?utf-8?B?TW43dmlCdHdmR0psMUl5alJYV2RjcUFWdE5YU0FTNTI1M2d2Zlp1aDB3c0Zo?=
 =?utf-8?B?dklBUU5kUlMrK0NUTFpldk9iUVVLbFRUVEkwZVZOWGZNNnFybXN6eGN4dXg4?=
 =?utf-8?B?M0c3TUNZcEdBMXBFV1Nxa0s1UUJpWVRHcHNWWUFCMkhSbFZKY0hHQ1ZKeGZE?=
 =?utf-8?B?cWkyK3VlKzhjaGs2QXFqWi90cHVxUzcwaWt1TnRRakgyMEJWRGNyZmNlM1Nm?=
 =?utf-8?B?bXA1T1h0UXM3bGR3NFFTcmdEbjU1YVQ3L29vWlZIUVE4YnpIQlRtTmg0em1v?=
 =?utf-8?B?azlQMHZkZXJ0dzZMVnREZWRLem9aMUhLQktpZ2RxU3BUVG9zWkEwNWI0RWtx?=
 =?utf-8?B?Wko3Y0hxT0JHRjdCcExncFlFcXlxNjRraURzSGJnbG1lUGFZc05hc2Rjbkhr?=
 =?utf-8?B?bzhMMkxPVzVWVTVpL2NkZnovdXlmb0s2dHFRdW1NSTB5dDNyVGpnZGs1QUJl?=
 =?utf-8?B?ODNJTWQ3V3JCNE42Y2NaYllUd25XQ3lIMWRDUDB1V0h1cXJERzFWT3p4dzJi?=
 =?utf-8?B?YTk2emF5dGJWKzh4Ym01Y1NFeW03RWJ0SUJJL0RqKzI2RVQ4VlozV2ZRclFq?=
 =?utf-8?B?eXJqWE9tN00wUnVXbEhSRXErLzF3REU3TDdoWkNhd2VyYUV3dkxXYjJBT3pD?=
 =?utf-8?B?bnJhODAwVjBwandGLzhUd2dxdDJsTTVScUFxYVhyUzFKd0d3enpObEg5VDVU?=
 =?utf-8?B?MlNjYVpqemJxQ3orYnowWXg1aStBVUgwZGJuNktoK1BGY1g0czVXRmIvS0Zz?=
 =?utf-8?B?NUJTNDBUK1hVQlo0d00yVytFQm9ndVlBUjU4Tm5DYVJ4djNtSjZlMEtSLzlo?=
 =?utf-8?Q?BUT/qSOeyTovx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFhQUEpHQUplY2xzZ01jelplV0FqTnB4Q1NQdzNtbjVzTkY3YnJnWVZ2Z2xr?=
 =?utf-8?B?QUJwbkJjR2lscklhU3RLaXFabVkrQlBzajkwZ3JFR3NZeTlyYzBiZUpZbHhX?=
 =?utf-8?B?MWMzVW5GaTY0d3lFWmlTM0xkUVhUZGVCVnIveFRDMkt5eHB6aDdYd2F3WU9y?=
 =?utf-8?B?RzZaeDJpQ0sxWWZxdVRZVjdlQk5rcVFrSWNUMUtjZTdvbHVuall6RllBS1l6?=
 =?utf-8?B?Mnl0VCswWUxNVDFOTHFXeG1RTVJDMG9aelRodWd2S2NWaE54Q3lQeHdNazU5?=
 =?utf-8?B?UGYyY1owUzZUbkhZb3doTjErbEQ5czJSYzh0NEtJUEgwbVhRY0o2TW1rbzFi?=
 =?utf-8?B?OGErWWdtL29wT1pUeXV4bXhXNUpCdHdRdk1yZHRzMTVHaVNOTEpIMlZleUVl?=
 =?utf-8?B?U2lRZ1B2d2F1bThNcU96Wm81SklhcVBhWHUyWVI3TkpzTlNORHo5T1dKNllJ?=
 =?utf-8?B?azBYVkcxbHZ1ZjFNYkNVbTVEZXp1UGM1WnM0UHRzZmh4ZnNySEljTk9EaDJF?=
 =?utf-8?B?NFZzOWRCeWl1Vm1IUytka3phemNKRmlCeDVyK0swUzdYWnliL3YxWkhMQ29r?=
 =?utf-8?B?SVJHcUZTSnZqcmlkUTROOTdWV2FnNmR1Qk9DWFRSamxYZ09UdXhVRityek10?=
 =?utf-8?B?WWprMmZ2Q3NvUGtjdmtnVGpMTTNGaWpGZ0hMcWZOQmRITWRSL3VZcmU5MG1N?=
 =?utf-8?B?Z01ySGlmdFJISzZiT0F3NHFLbGJ3UVpCUUJQclRCSVdsOTFFN1hzNlpLOTNH?=
 =?utf-8?B?bWpIM0NXdDcxdHp5OXBnWmZaN0xKWldkVW13OEhQdXcxWERzd2RVdWZFU1JX?=
 =?utf-8?B?YnBjSHRCOHlmaWM1UzUrWDRqWGF5aW5UQ2VIZTVLOXJZRHZyaGlTcCtyOVBs?=
 =?utf-8?B?S1gyeWlNblkwYjhZYlBnS3orSlFhR1o2RUZZNzU1QWNGbkV4Z2VmbnVseUt5?=
 =?utf-8?B?aFMyNmgxTzNFcjhBS0NLSWFxRm9DZzU1ODYzSWViTW10aUwvQmdqRnhGV2pm?=
 =?utf-8?B?a1FzdDNZaE55OFoxdFhSU2ViZ2g1ejFaWWRCMkxBcWxBMkUzRHRrb21KeFBo?=
 =?utf-8?B?QkV6cEVGbVhmMWpuMTMrQkRYMmlBNStIQ2ZlMXVWT3NiaEJzckptZUpESVRP?=
 =?utf-8?B?VmNqeHNKNHZNY0hyS204eEdCZHhEM3RGaTVUaGNEeG9hR2tZRU1vT0pLZXUv?=
 =?utf-8?B?a0g3UjlHc2tPNHJjd0VCeU1aRmtRYkN4WVI1MnpXZDFuUFhvTjlPajByMERP?=
 =?utf-8?B?Nml3SjVnR2VoU2w2UVRrTVpHSXc0QW9rUFVZTWJWQ1o3cC8wamJnNm91bzFH?=
 =?utf-8?B?UlVWaFgvRFdpTEpCOHU0VmNJVHNhaU8vRkhGekpsS2k3N2NVK25JbkZNM0NY?=
 =?utf-8?B?ZG1jRzVsenBWMnpCZTRGaGhZUFU5WXZIWVk4c09NQWxRQXRhdERNVmh0QWY5?=
 =?utf-8?B?YjV3NGhxODk2Njh1aGhJc0ZtU1lhM1M4VjJBYWZkVGw3SzIyMjlqZkZxRmE1?=
 =?utf-8?B?aXBDMGlZVnFiL2M5V3RnNTJPUEtLbi9ycjNnTmp3MUJweWFIdmt2c1FhRENR?=
 =?utf-8?B?T1hBS2VRYmQvMTh4UFpDMU9zSVBwbUJZOEdsdmZoVjNCMWpLbnROK1NQWDBX?=
 =?utf-8?B?VTRhdzhOS3FLbmZORzlMbDA4UUV3eW5Yenc3Tms1WGg3bDc2RlZiQ2w4c1V0?=
 =?utf-8?B?aHB5bm8rTHVMYUhvbG4raHJoNklyZWNyWGs1a0R2QkN0WENkblpMSjJIVDl3?=
 =?utf-8?B?VUNOMW1INHNtWWprVDBKRXJpbmYzSGw0Q2tuNGQwZTZlam5yOVhFQTNRMlhu?=
 =?utf-8?B?VmdRbmZJNjNQTk1KcjlaUXBxOFJ6c3Q0bEZCbE9yQlMrWGFDMVU2WDdpeGQw?=
 =?utf-8?B?WHdzdTRtNDRzSXhGdGRtdlJSZzRHcjd1OW9MZ1FNdnpYaGllME9ibmFZK2d5?=
 =?utf-8?B?WjVLNUVqQmcvZUloaDlwV2JOUExwNnNzQWx3aHVYSERLUHV6dTYyRUtwaVgv?=
 =?utf-8?B?STE2dHU1eWI2Qkt4YkZsNWEycEl0L3RGdHgwQVdNK0dTSFJwd1FibmVma1pR?=
 =?utf-8?B?MTk2UW4rSVJaN3RVYWJxZTJGRGFuUEtzZHlPUk9jc1lSMEdRWGVlWlp4Z1dO?=
 =?utf-8?Q?BfSrb2fZOow+4pfw6cSccIuvJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac11b8b7-bf49-437a-a961-08dd5cf1606c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:56:33.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgcvJB73oRMf1weCJPK3qMRmDP4/EZ046SpgqH7+ZqCHcHDJQMGZY+WvV8mMUMR1dWkQ413k5MFnUAc838IePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> searching closid_num_dirty_rmid") added logic that causes resctrl to
> search for the CLOSID with the fewest dirty cache lines when creating a
> new control group, if requested by the arch code. This depends on the
> values read from the llc_occupancy counters. The logic is applicable to
> architectures where the CLOSID effectively forms part of the monitoring
> identifier and so do not allow complete freedom to choose an unused
> monitoring identifier for a given CLOSID.
>
> This support missed that some platforms may not have these counters.
> This causes a NULL pointer dereference when creating a new control
> group as the array was not allocated by dom_data_init().
>
> As this feature isn't necessary on platforms that don't have cache
> occupancy monitors, add this to the check that occurs when a new
> control group is allocated.
>
> Fixes: 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


