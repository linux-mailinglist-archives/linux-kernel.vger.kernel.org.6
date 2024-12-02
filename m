Return-Path: <linux-kernel+bounces-428450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E450D9E0EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFABB2F6AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864B1DF743;
	Mon,  2 Dec 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zkdVnfQq"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312561DFE07;
	Mon,  2 Dec 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177229; cv=fail; b=oII/sj9gaLfM8mk7x7ULae7HiEFbP3e3xnRiUeORxz4dktXQqO0BXlQfNdJbF011FU6Fv1vrhxRtMl+6ULKbkx62383BpyvWHUInw0tL3n6bWJG/3IDS/gC0+cQJgO0KSQXJ8j/FH7QagvQy9njVnZLUSCiSS9VZdf80yEAJg8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177229; c=relaxed/simple;
	bh=p5qxh/ylp+e1HJ7jKNREst2woYmkskey5pOrLCNfGFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EL6RkkVxLu4/Th0Vmi/ESodNKdZp5xWgXYTdeUnOCKzpbmkVLAe1rOzh9cbhCogo1NghxxFR+FZ5wQmXSMrgAqLckKa6VLCP4EGzAKyosaHtzyZSoNZ6fXCIa0rwfIJXhK6lMd9nWeMOst8OwHDuhq3fUlf3r2Whn5jAo3vjGLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zkdVnfQq; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO66VWgccTQ7Y+9Fht64v4CVrQOu+7YQGGxosrARAcwEqFhgUdTl8uFYwbrifPQPs0MlGfih71TEof7KoUfoILtnr3X41GTsiy2hLdZLgsGy24vVxmUxaMbMsUcCLAMknqyBhOuju7hEDdgDQnUoH4S3IFbdnfmnwTms0l7UrU48u71RxwyuAicKp4OAZPAfQu0JmmyqUwHHpzL7ThXD+1Cmxtue+ElG9xwAfgRLe4qryL3yGaTncys3JGMnwjQlQRIhfEM128rCeb9Y6mSmnaev3agwq/TBWPGq1EW+j98otR7ve3M4ZpCUEFHMMTXC2XDBh0WnohoXjTZPoVuCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuyeRWUsfgCNk3CrOfCBsb9Y/C80C4Az9iMtuSB+OJI=;
 b=f0LCX3vuLT/9k7atBYlw4zCuHlnSNM95uaA93vYj+S97DFkQTnWQ30Nhf3ommH8v2W5ipRJdCn5O/FZCz+KaFAhugTMpDrEENDdTclTv58IGbfkE+hnINKEwq+jRmtcNs7yBUjpTB/aO5cd+BqxDbDYaUFeURAIkDtD+AhE68lxDu72+AWA4AHbXZwm/LnfYpLwHGxhKkZkzFacE19RWKdoSFmUdls6UaExL3MpNQPCnW286uBXGMG3mwSaI40R4KV91g+AKQhcsFuGDz9l9GhMV5fwZKIbSXARz7o+wk+ou5D1OY6shNREFhVd3DL9XeylWkrsD0sLWvuR4qynjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuyeRWUsfgCNk3CrOfCBsb9Y/C80C4Az9iMtuSB+OJI=;
 b=zkdVnfQqRMx3e+2vGOBpn58bjWhxJuuphR4kNv0lveWPoahn6ZPPMJ+/dnYpNQJnrzxiyF4JzxbwHk+k8ZTWM5+XIVeIH10+ahgD8QpwiUjkt5x2joO666HkIHv607g7ndu6l/cL+a6F3A2iY5O4a2boDSVZtGZ4TTQqUJXc+b0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 22:07:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 22:07:02 +0000
Message-ID: <0b0d0627-07e4-4fe4-8de5-f6e5a5148dc7@amd.com>
Date: Mon, 2 Dec 2024 16:06:58 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, fenghua.yu@intel.com, x86@kernel.org,
 hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
 akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
 <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
 <5a8eaf67-baaa-4278-abe5-cf68f795d4bf@amd.com>
 <c9b0115e-d994-4239-b2b2-12359878ec7a@intel.com>
 <03b5f7f2-d347-44de-85bc-0a346651d487@amd.com>
 <83abb31a-c2a6-4319-8b56-174b7848f4ec@intel.com>
 <bc26b599-0a0e-46f0-bfda-83330a34293e@amd.com>
 <10a197e4-bfa8-4d42-a229-b755378781b0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <10a197e4-bfa8-4d42-a229-b755378781b0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:21::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: d8177ca2-9af8-4cf4-a759-08dd131da6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?di82UWFyNi8zcWZTY2ROMUFWd3h5MGNUTmY4bUY3ZkpvODNCenVHRVNYSTh4?=
 =?utf-8?B?a3lOK2htRmVHREVnUGhQTGl5NEk3Q2M1bFh1NnNHMVd0SnhOOUZEalhXYXRv?=
 =?utf-8?B?WjEwVC9ybWFweG56MndQeEwyYnNLQTFoTFZ6anEwaWV5ZGtySU9teGdzUFBL?=
 =?utf-8?B?V0hFRmFaM0ZFMjVLSkZmczVrLzNrc2wxejVkdGJpUXd2eXNqeWhmcnVzalZM?=
 =?utf-8?B?Ym9KZEx3b0JuUENLKzdsckZKQWpKa1NINC85cEFaOWlOYStEQk80UlhjWlNV?=
 =?utf-8?B?NXJubDIxN1hJUEpuZFlRTFVOZTBQem40NDFrSXlqbTVwSVF6Vm52N0tpNHpk?=
 =?utf-8?B?Rk1NazVxZHo5Sm1oOU9LZU9iYjFETW5vSndJUU5PL2E5RzRQamcwdGI1ZVhJ?=
 =?utf-8?B?Qm9OcjZrV1gxeFhaOWw4Vm1oNkp0N0NqUWFGc25sSVVpOGU3WmRaUGgzSmRX?=
 =?utf-8?B?U0dzTlVtOVFJV1JxbkFQbVJ3ZzNpNnRjZUxnWGsxSmRDdXNTMXcvelZFbE5G?=
 =?utf-8?B?RmlBc050ZU5ST1NEbU1hUlU1YXJrOEl4cElVcUlEcDYvUE5WaGhWVVVnVjl6?=
 =?utf-8?B?eGFKRGo2cnRySXJxTFF2MGRUeXh2WlFod2hadTRybEtnTGE5TTZIanRHQ0RU?=
 =?utf-8?B?TCtWWkM3MzNVaDZXR0I5dzdvOWJ5Zjk1dThuTGNkMEJJLzk1cSt3WWVIdTN3?=
 =?utf-8?B?cGZtZTVXbGhTZkVueloreTE2U01lWEFJTHprNWlZTkpvUWVneXJMTFVWYUZP?=
 =?utf-8?B?N0tKVHY3L2FwNEl2SlRHTXl6UEhqU2MrbVlUanUwZEZZaC9IczFlZkIvU1pR?=
 =?utf-8?B?R0ZoYis4UTdET3F0a3lMd3g3YXYyeDgxZWNucmJidnA0b3RhYkdTWHp4VkEv?=
 =?utf-8?B?cHRVelh5RS9Od0tnaVJUeFZSVk5Xczc5aWlMak5RcTRHcDlHdk8zazlSZU8z?=
 =?utf-8?B?ZnVhTTMrL1JjeSttbjdCQmVPdUJ2NDlzV1RZd1Z1dHpuMTdSZDM4djlCajFw?=
 =?utf-8?B?eFR1MU1DUVdhdFFjR3BueFpCWFJTeU51RWl5bWFRa0NoTEFnc01LSEMxUUEw?=
 =?utf-8?B?L1VYV1k0eGZoMExVZjhoRlFLRmlwaW5YaktyKy9TVzBRdDVCLzhEMDRzeVR4?=
 =?utf-8?B?SW5LRWdUWnoxQ0hzcitDQVhrckFod0xDWmNic0orWklSbGp4RWFmRTIwalFq?=
 =?utf-8?B?S0dnUzNxenFuMHBadVdiR2V3ZU5ZSUg3Zm1yaHhKb3BHRzJaSHA3ZGpOcEZ2?=
 =?utf-8?B?ZjFIbi9OSGZ1aUVPbFZ6N2VDYWtQZnY2MkhHZXUrWTQ3UWMrSnp6N3pJRnR3?=
 =?utf-8?B?dE45K2R0RncrYWdJM1dJUEwvSkY1cUpaelZOZ3lvZjRnRUxoc2d0VzYvNmRY?=
 =?utf-8?B?Q1Y2eGRDc2FyMThYdWxnUU1BZk1YZEtHc3dZK0JLYXdtcmc1UHB4aXRtOTl2?=
 =?utf-8?B?WDdMc3I0WjMrbDg0ak9aOVArWXB0ZStIZnlOcnNyUFZYcHJNNXd6NEtZQmJR?=
 =?utf-8?B?b21YY2N6bENiMFJZNGJ1eW5RYXJlMEs0OWJNVk9SU3B4Y2F4VGo3Nm0xRFlq?=
 =?utf-8?B?eTNTbkVhY281NkFFd1MxcVpCYmw2UnNuRW9lZGxqZ2lmNkxPek9SVEM1Qnht?=
 =?utf-8?B?WktSNlo3S3VJNC95a2l1ZndudnZpL0RCMDl6djFWSFdYT0JURFo4cUN2SCty?=
 =?utf-8?B?WXpxYnUrMTM4K2IwQ0Q3RVlnWmF6V2RQSlkyYzJESUR5Wm1BVk1TMGUyUWsy?=
 =?utf-8?B?NVlEWmZuV3VmbzdDUEJiVGF3bWVOSmY0VWFqTnhXYWtzdlEvS2wraUwwRVQy?=
 =?utf-8?B?eGxWbTZqREFmQlEwcjdDUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmhiVG1GTmpVQmw2MDZobEdGa0dJTHRBM0Yxam44K2p3cHgvNmsxamFLTTJF?=
 =?utf-8?B?cnRDZmxWT3cwdTA2aTNuMnJjVWErL05XSldkMEdvVmVhU3pxWHdrcGNIUGVu?=
 =?utf-8?B?ZE44dndvM1M2ZWFWY1B4bm5IVFFGU2VsbG9RTU9KUnFkeXQ3QzlLYzQrUWty?=
 =?utf-8?B?cllFUmhGeGYvUTNvdzlHTXhnbDUyN0NCa2pTWVFFNWRMbFdPOEFNQTh4SUh5?=
 =?utf-8?B?Yi9nSkJSaWIvaUlCWlNud05kajBrNGtBck02cmprOG5OT0lwZjBodlU2WjlD?=
 =?utf-8?B?M1RHc25aak5raDJVTXBMUzdmT0RwaGxJenQ5WkdUangrSVJYK0ZPS2NCYTJW?=
 =?utf-8?B?L0xKZzNXM0VGRFdQWldnbzdHR2l2S3NrNXU4VHEvUVZJaVZmYW1LMnBCWGl6?=
 =?utf-8?B?NGtZNEVrTm92L1JsSFJjOXlpL0pNRUxIU2JBaWJpb0gva01Dc2FLaXBNYXNh?=
 =?utf-8?B?eGpjMTNyMTRJK0hnV0Z2M05tNjVXQjhyV0lyRG9ESlhqK0tFTTMxMEVNemd0?=
 =?utf-8?B?ZTJtbWxzMHphQkk4NTBGMVNqWm1oRzR6cW15SEU3QXhxSWdta0JVNWE3Zmgz?=
 =?utf-8?B?M3FWTGRFZGl4dnFnZFRJWHFVS29pam13Y1JuNlZ6bWVMNHEyWERjRVBHN0Ez?=
 =?utf-8?B?WlZOaEpTb0VuYmhYRUo4cmF4WEtZMXdwVUN5T0pCaDgyRmt2bmYwSS9iSGtp?=
 =?utf-8?B?SjlFdGp3OS9NZDNmajB3eXVwbE9XWXg3M2MwaVZyQnlubll3bExWeHhZNnZz?=
 =?utf-8?B?eFB1Vm5TczhHMmY3LzFPR1czY0RYNWpXVEhLa1FGRUFpWnBxQThJcFVzMUhE?=
 =?utf-8?B?UEo0QkdVcHprQi9zSWVNVzJvUmMyeVJUMEZJQ21sOVUzamZWaFFITFZWVytu?=
 =?utf-8?B?aXIrUDR6VHViZ0poTm0wMjRRL0lKUDhtSnpDN2JUSGlQMHQxNVVUSGxTWnJU?=
 =?utf-8?B?aTJLVnJsYnN2QVVCNHdsbEFEeGZza0p1NVN2cVBkYldMc2IzNmJUUjUyQ29H?=
 =?utf-8?B?ejZla2Z4MmV5b0xYM0RnUjlLR0NoT0p5RkV5UWVrTm9VenNXSWc5SE9IaUZB?=
 =?utf-8?B?eC81SjlUNnNpcUgzM2M5WU5rNk9UczNNYVVTdXY3dDlGZkdpd1YyNndlUDJZ?=
 =?utf-8?B?eW5nbnA0eC8yajRJODVsS0JIWlZsMlUxSlZHUFlEWkRxTElzZFlCSlZNQUVV?=
 =?utf-8?B?dW1mV0xrQU5VR0x5bllsMUdiWDJIby8wWVlucU1TbGhHT3V0eC9ualdydGY2?=
 =?utf-8?B?aWI4TWxKdTI3SktrWlR1WDNBM0RiT20xNzdKVUJVMFJzUEpuNS85dzJSN2dN?=
 =?utf-8?B?a1k4cUhYUTg5aUtCYk1PMXFYd2dsVnQ3azA0cUgrcytRUHlySG9jeG1EUWRs?=
 =?utf-8?B?b3VsaVF0V3QyNkRnWTBIUEszN0t2MGdJenBMTkZodXRTWnc4a3J3NmJMYkp4?=
 =?utf-8?B?aDNCVE93YmJZS0V4YnNlc1oycS9pQWtSNXdqZkpVWUFIMHcwRmM1aUNOQnNQ?=
 =?utf-8?B?ampYVnZrQzZReUloaHV4ek5yY00rOXRyQ3BPRGQwUmU4T2JqcXdTZ2hQL1lS?=
 =?utf-8?B?TnU0bFZnOHZNazlIOXQ1OXYvTk8zNFVaZmhyOHFkQkt0aktDR2FFaUZ0Tlh0?=
 =?utf-8?B?NWpzZCtKQlpYYUVtQXdNTW5tRHM0eTc3ZmpEYmUycmxMOUFEcUE3UytqcnBD?=
 =?utf-8?B?eUY5SmZFdkxmR3l2SnZPRFFCUEoycGdkdGpKSzJkbXNTUkU1bDB5OUQxWldO?=
 =?utf-8?B?MmxObGMyK2RpMXRnc2N6dVhnZUJ0dVpXWGxaRHpIdUxwQkwvMU1vTkRzbUVz?=
 =?utf-8?B?SXBNUjQ5bXVpc1NLV3hBZnJueGZSclNjUWJkR0F4QzdwK2haNE4zb0FDNGdz?=
 =?utf-8?B?V2FBZzJDMXpTOHF0ZmpObmEwWmY0S2crUGc4ek1LZjQ5WHRROXNpeDVTdVY0?=
 =?utf-8?B?QTR5WTdJRXVwY0t1T3RmcjE0cGdYU3hDSWllNDNFb2JiTXlzOGNNRFNkR09w?=
 =?utf-8?B?YyszSExOUGN4T3B0VnU2VUxONElTSXNYTW1yR3VtalZnS3VmWnpmSTNXMUhq?=
 =?utf-8?B?b0NvZ3RtVGlWa3QyOGtIMTZSbHd1SURuK3dIbWJwUk54Nno3Q1k2Z1hwYmhK?=
 =?utf-8?Q?hHos=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8177ca2-9af8-4cf4-a759-08dd131da6a7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 22:07:02.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z90WyJN3vlj3z2w3AgWsie8aD/s7E5heQF6DcskJdlXlU1OyFtKuiYN+LmTiktXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

Hi Reinette,

On 12/2/24 15:47, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/2/24 1:28 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 12/2/24 15:09, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 12/2/24 12:42 PM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 12/2/24 14:15, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 12/2/24 11:48 AM, Moger, Babu wrote:
>>>>>> On 12/2/24 12:33, Reinette Chatre wrote:
>>>>>>> On 11/29/24 9:06 AM, Moger, Babu wrote:
>>>>>>>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>>>>>>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>>>>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>>>>>>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Babu,
>>>>>>>>>>>>
>>>>>>>>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>>>>>>>>
>>>>>>>>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>>>>>>>>      For example:
>>>>>>>>>>>>>      Resctrl group mon1
>>>>>>>>>>>>>       Total event
>>>>>>>>>>>>>       dom 0 cntr_id 1,
>>>>>>>>>>>>>       dom 1 cntr_id 10
>>>>>>>>>>>>>       dom 2 cntr_id 11
>>>>>>>>>>>>>
>>>>>>>>>>>>>      Local event
>>>>>>>>>>>>>       dom 0 cntr_id 2,
>>>>>>>>>>>>>       dom 1 cntr_id 15
>>>>>>>>>>>>>       dom 2 cntr_id 10
>>>>>>>>>>>>
>>>>>>>>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>>>>>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>>>>>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>>>>>>>>> group:
>>>>>>>>>>>>           struct cntr_id {
>>>>>>>>>>>>                   u32     mbm_total;
>>>>>>>>>>>>                   u32     mbm_local;
>>>>>>>>>>>>           }
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>>>>>>>>> current implementation deals with domains that come and go. I do not think
>>>>>>>>>>>> this is currently handled. For example, if a new domain comes online and
>>>>>>>>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>>>>>>>>> not configured to the newly online domain.
>>>>>>>>>>
>>>>>>>>>> I am trying to understand the details of your approach here.
>>>>>>>>>>>
>>>>>>>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>>>>>>>> monitoring domain structure for tracking the counter allocations,
>>>>>>>>>>> because the hardware counters are all domain-scoped. That way the
>>>>>>>>>>> tracking data goes away when the hardware does.
>>>>>>>>>>>
>>>>>>>>>>> I was focused on allowing all pending counter updates to a domain
>>>>>>>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>>>>>>>> processed in a single IPI, so I structured the counter tracker
>>>>>>>>>>> something like this:
>>>>>>>>>>
>>>>>>>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>>>>>>>
>>>>>>>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>
>>>>>>>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>>>>>>>> domain.
>>>>>>>>>>
>>>>>>>>>> Are you doing something different?
>>>>>>>>>
>>>>>>>>> I said "all pending counter updates to a domain", whereby I meant
>>>>>>>>> targeting a single domain.
>>>>>>>>>
>>>>>>>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>>>>>>>
>>>>>>>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>>>>>>>
>>>>>>>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>>>>>>>> for readability)
>>>>>>>>>
>>>>>>>>> echo $'//0=t;1=t\n
>>>>>>>>> /g1/0=t;1=t\n
>>>>>>>>> /g2/0=t;1=t\n
>>>>>>>>> /g3/0=t;1=t\n
>>>>>>>>> /g4/0=t;1=t\n
>>>>>>>>> /g5/0=t;1=t\n
>>>>>>>>> /g6/0=t;1=t\n
>>>>>>>>> /g7/0=t;1=t\n
>>>>>>>>> /g8/0=t;1=t\n
>>>>>>>>> /g9/0=t;1=t\n
>>>>>>>>> /g10/0=t;1=t\n
>>>>>>>>> /g11/0=t;1=t\n
>>>>>>>>> /g12/0=t;1=t\n
>>>>>>>>> /g13/0=t;1=t\n
>>>>>>>>> /g14/0=t;1=t\n
>>>>>>>>> /g15/0=t;1=t\n
>>>>>>>>> /g16/0=t;1=t\n
>>>>>>>>> /g17/0=t;1=t\n
>>>>>>>>> /g18/0=t;1=t\n
>>>>>>>>> /g19/0=t;1=t\n
>>>>>>>>> /g20/0=t;1=t\n
>>>>>>>>> /g21/0=t;1=t\n
>>>>>>>>> /g22/0=t;1=t\n
>>>>>>>>> /g23/0=t;1=t\n
>>>>>>>>> /g24/0=t;1=t\n
>>>>>>>>> /g25/0=t;1=t\n
>>>>>>>>> /g26/0=t;1=t\n
>>>>>>>>> /g27/0=t;1=t\n
>>>>>>>>> /g28/0=t;1=t\n
>>>>>>>>> /g29/0=t;1=t\n
>>>>>>>>> /g30/0=t;1=t\n
>>>>>>>>> /g31/0=t;1=t\n'
>>>>>>>>>
>>>>>>>>> My ultimate goal is for a thread bound to a particular domain to be
>>>>>>>>> able to unassign and reassign the local domain's 32 counters in a
>>>>>>>>> single write() with no IPIs at all. And when IPIs are required, then
>>>>>>>>> no more than one per domain, regardless of the number of groups
>>>>>>>>> updated.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes. I think I got the idea. Thanks.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> struct resctrl_monitor_cfg {
>>>>>>>>>>>       int closid;
>>>>>>>>>>>       int rmid;
>>>>>>>>>>>       int evtid;
>>>>>>>>>>>       bool dirty;
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> This mirrors the info needed in whatever register configures the
>>>>>>>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>>>>>>>> updated.
>>>>>>>>>>
>>>>>>>>>> This is what my understanding of your implementation.
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>>>>>>> index d94abba1c716..9cebf065cc97 100644
>>>>>>>>>> --- a/include/linux/resctrl.h
>>>>>>>>>> +++ b/include/linux/resctrl.h
>>>>>>>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>>>>>>>           u32                             *mbps_val;
>>>>>>>>>>    };
>>>>>>>>>>
>>>>>>>>>> +struct resctrl_monitor_cfg {
>>>>>>>>>> +    int closid;
>>>>>>>>>> +    int rmid;
>>>>>>>>>> +    int evtid;
>>>>>>>>>> +    bool dirty;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>>    /**
>>>>>>>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>>>>>>>> resource
>>>>>>>>>>     * @hdr:               common header for different domain types
>>>>>>>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>>>>>>>           struct delayed_work             cqm_limbo;
>>>>>>>>>>           int                             mbm_work_cpu;
>>>>>>>>>>           int                             cqm_work_cpu;
>>>>>>>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>>>>>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>>>>>>>    };
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> When a user requests an assignment for total event to the default group
>>>>>>>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>>>>>>>> entry.
>>>>>>>>>>
>>>>>>>>>> If there is an empty entry, then use that entry for assignment and
>>>>>>>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>>>>>>>> information from default group here.
>>>>>>>>>>
>>>>>>>>>> Does this make sense?
>>>>>>>>>
>>>>>>>>> Yes, sounds correct.
>>>>>>>>
>>>>>>>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>>>>>>>> initialize during the allocation. And rename the field 'dirty' to
>>>>>>>> 'active'(or something similar) to hold the assign state for that
>>>>>>>> entry. That way we have all the information required for assignment
>>>>>>>> at one place. We don't need to update the rdtgroup structure.
>>>>>>>>
>>>>>>>> Reinette, What do you think about this approach?
>>>>>>>
>>>>>>> I think this approach is in the right direction. Thanks to Peter for
>>>>>>> the guidance here.
>>>>>>> I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
>>>>>>> though, I think the cntr_id would be the index to the array instead?
>>>>>>
>>>>>> Yes. I think We can use the index as cntn_id. Will let you know otherwise.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> It may also be worthwhile to consider using a pointer to the resource
>>>>>>> group instead of storing closid and rmid directly. If used to indicate
>>>>>>> initialization then an initialized pointer is easier to distinguish than
>>>>>>> the closid/rmid that may have zero as valid values.
>>>>>>
>>>>>> Sure. Sounds good.
>>>>>>
>>>>>>>
>>>>>>> I expect evtid will be enum resctrl_event_id and that raises the question
>>>>>>> of whether "0" can indeed be used as an "uninitialized" value since doing
>>>>>>> so would change the meaning of the enum. It may indeed keep things
>>>>>>> separated by maintaining evtid as an enum resctrl_event_id and note the
>>>>>>> initialization differently ... either via a pointer to a resource group
>>>>>>> or entirely separately as Babu indicates later.
>>>>>>
>>>>>> Sure. Will add evtid as enum resctrl_event_id and use the "state" to
>>>>>> indicate assign/unassign/dirty status.
>>>>>
>>>>> Is "assign/unassign" state needed? If resctrl_monitor_cfg contains a pointer
>>>>> to the resource group to which the counter has been assigned then I expect NULL
>>>>> means unassigned and a value means assigned?
>>>>
>>>> Yes. We use the rdtgroup pointer to check the assign/unassign state.
>>>>
>>>> I will drop the 'state' field. Peter can add state when he wants use it
>>>> for optimization later.
>>>>
>>>> I think we need to have the 'cntr_id" field here in resctrl_monitor_cfg.
>>>> When we access the pointer from mbm_state, we wont know what is cntr_id
>>>> index it came from.
>>>>
>>>
>>> oh, good point. I wonder how Peter addressed this in his PoC. As an alternative,
>>> could the cntr_id be used in mbm_state instead of a pointer? 
>>>
>>
>> Yes. It can be done.
>>
>> I thought it would be better to have everything at once place.
>>
>> struct resctrl_monitor_cfg {
>>   unsigned int            cntr_id;
>>   enum resctrl_event_id   evtid;
>>   struct rdtgroup         *rgtgrp;
>> };
>>
>> This will have everything required to assign/unassign the event.
>>
> 
> The "everything in one place" argument is not clear to me since the cntr_id
> is indeed present already as the index to the array that stores this structure.
> Including the cntr_id seems redundant to me. This is similar to several
> other data structures in resctrl that are indexed either by closid or rmid,
> without needing to store closid/rmid in these data structures self.
> 

Ok. That is fine. Will remove cntr_id index from resctrl_monitor_cfg.
Will add it in mbm_state. That should be good.
-- 
Thanks
Babu Moger

