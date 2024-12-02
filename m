Return-Path: <linux-kernel+bounces-428408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6C9E0DDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568A716574B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6891DF26D;
	Mon,  2 Dec 2024 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hz0Iv4D8"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913170800;
	Mon,  2 Dec 2024 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174920; cv=fail; b=WbjfHcFlihhNA4+Xh9Lz4ZCqUnenf4illuKJAwttZSQhtpjcHR9Gkot2pFfehMi+LS5s4q3ZqO2zQ48uNwPFZDz7fK+LE7pCPC7ghMhRVpQ5jY/sJRf2M+RscNJZB5wIhq0JCN5bPq4p+lBpjVs/1n0DJhUBgNuxxy40E1F0gxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174920; c=relaxed/simple;
	bh=p4vQEpmRVNj0gmgwgYsn9IGDZiOrCHNFwUhJZSMCEHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lA0aQuvEg7IqDsUZqSuXf6hF9dg6UqUwFUlSAW9xYlse931DlcHwfdPEowv84Di4ZU7RXqiU/bmL8M+9AEWu8RpeUPpl5ibKy1+35X9Abs49dwbeXVTnEwOClreDfarYY+YYiyPdndjQsVXW7ym6efkJDRLwVqc9N4xbVR7qBGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hz0Iv4D8; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6WuzDbwXribydoVk0bR3gOPFcjT02TyGISiplHYNlHtKts1mw85J01CAjrDlUNu1OFsntZa2wP/3953CEQDvDNVFNQPUfQXjS/zVom61MVwrqBAkUoK+B/iUwT5bwSu/EKEu6IfMg3MuELPWRh0Hn4w7Kg77AC83qw4d7WC9f1oETrzV3914kiAftG3xzNmBWMw/HydNe5/GWZOc4BNkVbkjtpVLNbHVojIbGHCJWbe1kkUZ2qXtKUXv8rZhj/xQKsF+YGgIK/ovaNIlyAB2PpJUdXXTfiJu1deoclkt7UOwk+jQ25sUMCnWD4hgjU+UmXaALWX9fzS9UAhL9EIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbEaLzAuGFuMy1JLuQhMqi/dKOlzXHFU2oc8Tohr1ag=;
 b=iF7AzMsO/3+1J0Vpqx3sfF9BDhjzIid4qDzEKuuE5Kbolb++bhBIWMvVLZcS+lN8OswdN3QV7J0e7s1ByHUdQbZ7JB0mpxDhTB1AETQGchjbzcF48FL/PTvWJ9DmImxM9INYPhiDneRyHodHlj7Clegkq8ybZfWwQKYSy/ZHxExfs2o+8OVj+9BMsPHGPYYCSvBZISqCf8CQWHN/hggLBKlNlb+hY7J/E0h5v04zbgcSZFcLh4CRBpg8U+Zt/v8/XQXeCfKPXxv/d2ixs5dbSD94WudswEbysW1bGfsnVxth27izLZafeTG2lsa9uSN0G7T8w2NVxgaR7GH/TScRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbEaLzAuGFuMy1JLuQhMqi/dKOlzXHFU2oc8Tohr1ag=;
 b=Hz0Iv4D8Frn17lw+cDhh6nMULOVXeyU3gZqktKoRHl1vkVPOJMBxmwNFZcofnWF9LSba0ewiyd1PUpnvLod3hiV+TOf2V8x64mDyKCqISF4oSHVtLV3+wq2Wj4rSSTM0+D6ZR5kAylESlxQk+JI8qS64LypKjZKUsYZ3jAFxu+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:28:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 21:28:32 +0000
Message-ID: <bc26b599-0a0e-46f0-bfda-83330a34293e@amd.com>
Date: Mon, 2 Dec 2024 15:28:27 -0600
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
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
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
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <83abb31a-c2a6-4319-8b56-174b7848f4ec@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1627f953-0533-42aa-deb6-08dd13184546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGF5cXRtRmNTRUc0ZEI4TU96a2Y1QmxWTERYSFAwRFJBaGEzSndRVldzTWw1?=
 =?utf-8?B?SnR0ZGc1d3hESnZCUmYwd3dyTG9YZVlBUXh6T1FRRmk2SjZIVTMzZ2tpZzdI?=
 =?utf-8?B?bFZSYmx6ckE0Yi9mNUFoV01ickg1VnFUQit6Q0RtY2EzUHBCOFY2VDJGN2Ez?=
 =?utf-8?B?L3RqNytjelFZcEdCU29aMGdCalZyNzA1aFF3LzlDUTlVUWxpc093Y1JkZE4y?=
 =?utf-8?B?Z1d5Ui84VDlNWEdqUWp3VFZSVjlydUhvN1NuVFYvQUpzdU9aa1pLdHBpcnJ0?=
 =?utf-8?B?Ri9LczkxQ2VQWUcrYXM1c3lJNGlZN0t5Um1lYzNQUEpRT0JhWGN3VGgrcnM2?=
 =?utf-8?B?UVhtZzJBdXdPdE13YnVsTkVzR2lPMXlaWnZlYUxIOTY3MkNHc29vaDVvY0Zv?=
 =?utf-8?B?QlNuWkZydDNDQTNNUVFiVEpoTWF1NTl3TmNUQko5ZUZtc085akpCaXYzYjRS?=
 =?utf-8?B?Sk5FZ0lqSmdKNHRTRll0WFI2RXBDOGpLaE16TEcrcjdxZjI2ZUhFSmtZWjE1?=
 =?utf-8?B?NEx5R1QwV1dtcTNod1VWb3N5dzFHcmNod0ZidSthL3VKa0pEUU5MdWFNZnZt?=
 =?utf-8?B?MUJKMHJRbWl5R2dhNGxOcFpyaFFHWFplbkFMNFZlWkd5R1p0b0V6YU9zTm9o?=
 =?utf-8?B?NHNPd1dPZGl6ZXN0RTR5ZTgxNVNiSU1DeGhqdHB0YzdWY0NzOXp3SFFlSitJ?=
 =?utf-8?B?Z1haUHR4a0ZjKzE3dVFJOFA1UjQ4WmpjS082MkwrRkJVTkF3anF1Y2UrZy9P?=
 =?utf-8?B?RFVRU013dnluWXgxYkZ6RmZseGhGcGZnUUdaRzh0QzFxT0Z1R1JxQktnMzhs?=
 =?utf-8?B?ek9aOGlwYlh3OG1XWkFUUWE3VUkzYlpaSzNtUVV4TUpEamhPM0phckVhUElW?=
 =?utf-8?B?bkFSd3dMdDc1bHVEMy9zSGdvWmMwTlhrWGxFZmp3WnZKSFFHbmVSbjNtelp3?=
 =?utf-8?B?VzZsclhEbWNQMzlYbFJwcFNIazBxSW1tNW90dHl4bnpXOWF5c3I5cWUySXNq?=
 =?utf-8?B?dnFiemRTUzZMOGNiSzJ5b01Bc3p3S29udkxGR29DMEtzKzZBbXdKbndpREFq?=
 =?utf-8?B?alBTbU9PS0pNTUhoQ0s1U2xORTdZVVBneDBTeTZKYU5vOHVzbHVha29RaWoy?=
 =?utf-8?B?YXh3amNkZkdRMXo4MGZtVGxtWnRySU95T2dFZHBScXVkS084eWNxM3BGMEhI?=
 =?utf-8?B?MHVLMlo0enNsMmNIR21iRFlBZVNNUitIVHBXRXhncjlwV21Xd0ZsZXZISzJR?=
 =?utf-8?B?UklXY1lMYldOU1Z0aG9RdmN5Ymc3bG1CbjNNeGVlV2VlbUZrbi9oN3RPWlJl?=
 =?utf-8?B?Zlhwa1dTUVdPRlVmWVg0TThDM2tPMjgyQ0Q1L0Z6a25nZEZhWk9DalBvWlRs?=
 =?utf-8?B?Tk9wZHBwTUZyakJOMjZRTUdjeEhkeElsMTZvNmZtSjE1NW5pQ0tvak15VDMr?=
 =?utf-8?B?d0FOSkt0UUY2NVhNYlJpNzRVTWtxSSt3bFlvSkYzR2IrZmRMcHl1Sk4vNVFz?=
 =?utf-8?B?NiszcTdsQkVvSTU1Y3VNODI1WlpEVHJoK1NYTEpGYkg1cXdVclZSRVVNZk84?=
 =?utf-8?B?WHpzaFp1bVp6OCtEZU9wTG1qVXY3TjE3VmhuR1V1Skd4dkRleVlMTkxFaFZG?=
 =?utf-8?B?RGg4MHhsbnpqTmtCeVVQQmxlZ0dZT2FvOFZVMW5WQ3dGN2NOdjZyQjhQOFFQ?=
 =?utf-8?B?VHNIOUVGU25FZDRCZ3JKOGdMSFFkL204WjlrUVBMcW1BK0hnRmpVWGxLckZq?=
 =?utf-8?B?T253bzF4SEMrZzNHZEVSSldCNW12blFzejlyWUxtUllWRHRUbE9XTGlsTjcw?=
 =?utf-8?B?R25TS3VnbVFJMWhzQVBrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1dMUk5nM3NWOW5YRFdrT0tVUU5uOUk0R2NXVzREeTJUc2Zid3lBQWovOHpD?=
 =?utf-8?B?ckE1dHBQdExZbEpVakkybjI1cEF0U2RMWHBqVGdKSlR1V0dkaHNZa2RPMlVj?=
 =?utf-8?B?dFpWREg5TXJ6ZDBHVWVrN0txQ2x0a1RsbXNPRXBHS3NzdXl1ZHVPMXM2WGp1?=
 =?utf-8?B?NVVaMVFmRkptTG8rTkZHQVJ2cEdJRUEzZG43Q3A4Y3BQQzVabkV3NEh1RWNM?=
 =?utf-8?B?V3BqUENDMzVYZWRadHkyTjZjZkJMK0cwV2Z3L3p5SnlrNTB0N1lHTG1wMzZJ?=
 =?utf-8?B?S3BXSlQrZkdITTFaRUUyQ1ZPa0xlanRLRHcvbmluZmh3UVJrM2xxY0RPYm56?=
 =?utf-8?B?NEMrdUlhakxrc1RmZ2RQUUVHTWRnVWpnS1J3RUlHRGViOTA0enJFdEdSUnlQ?=
 =?utf-8?B?a0wzRlVqcWRJaFcxWHYzeVVGckRWc1RCOFdlNlJlbHNaRXRyR3BNQWtBSlhN?=
 =?utf-8?B?WWp0bDdoZXF3WDE5RitDSW5xMjgxaWk5R2I0c0ljTlp5Nzc4a1VUbW9vZmxh?=
 =?utf-8?B?WTQyNFN0ejl3bFNMZ3VjdHZuWG15cjJlT1BraHczMWFIaTdmM2RpSGhOQmR5?=
 =?utf-8?B?VWJlRjNwbXRzS3lEM1dJUUU2ZVpMdkpMaTEzbnRDUjhVMXlXaG85ZEtSbVlv?=
 =?utf-8?B?blRTR2JyZGpZTGhyVjR3a21tOXJrYjEwWnIwbmxFZWtkWnpVdVp3MVBHTEcx?=
 =?utf-8?B?RmpmeW9ZWXlmUUpxOTF3Vkd2RTRGRGp5SjRyUVhybVgvZzhBNEoxdmJaUm5a?=
 =?utf-8?B?d1h0d3BDNWJ3ZUY3Vyt4TUM5Yi9nWWZBUEF3U2puN2lqL0R4T0xSb0czYzI3?=
 =?utf-8?B?WmNSajRPVEJrSWFVNVNmMkc2bEFaczFhKzViRnFkRVNPWXdjc2wxSmtDdmMv?=
 =?utf-8?B?QjQ5RWRGUFpjZ0VtRmJaNG9EZnhyTWRpSkxBeFEzQVVFVVF4MDlrZnBtc01n?=
 =?utf-8?B?dG9jWDErZk9WM1FtYURlbDVMSGZqLzhTQUhhajQ5VEJCc3RtTlpWUEY4T1Ro?=
 =?utf-8?B?QnlsczRGbW9XWVdUY1RCQ1hBTWtFcW9aQ2tyV3ZyYzJBK012SzRRK0UyYWRU?=
 =?utf-8?B?bC9aZDU1T201WnRXWFlGV3VqNHcwQ3g5M2grQ2hybmdnajNLZzlibTByNjRl?=
 =?utf-8?B?Y2QvMXFUU3NNekkyRTdEZkVaaHA3bHZ3bVN4OUUxZC9lN0pWWjNmQmRWVlFt?=
 =?utf-8?B?bFdyOVo2cGNKR2Z3eC9kLzRIMk1ubDBSeVBmNEE2Z2dIMkkvbWhENTBhaWNL?=
 =?utf-8?B?UzMyZ2ZIK3RJN3lUV2lSQTBGR0NPYjNZRzhoZXJSMk1vcE9MeDQyUXZ2dk9C?=
 =?utf-8?B?YVJXektZQWZublhWekFnZkFtcWdob2hIcGZ3RW1aK2tsYnBEK1QxdnRteGk5?=
 =?utf-8?B?aFoxMXNOdFpURThSenB4ZW5aV1NCRzhBc0t1SUEyUFhaM205UDhXTm9qL2p4?=
 =?utf-8?B?WUFpYXp4VGVpUUFwUzl3YUVJczkycW9UVE14amUvcExKaVB1em8vT0FvT2JJ?=
 =?utf-8?B?WWpOKytxaTdROGxONlFkbzFhNDVvYUlXNW1MNENjQzFIcllsc0c4TDMzL0lR?=
 =?utf-8?B?ZjlZVm4vdUltTmF2TFNySXAwZmpFWUxXQkdDTnFrdE9vWlRaT3ppTjR4K1Vu?=
 =?utf-8?B?WjBBUWQyNFh2M1JyK1dncDlIOCt0a1RVSVF1MFZMbjNIQ1A3OXJ0bzhicDhv?=
 =?utf-8?B?NXMzcVpBZWpKRkE5UjFFTGZMNmNtaW0wdXdoRkZlNm11cUc3YlJYMnhFUXk3?=
 =?utf-8?B?RVA0Z0VkTGhqUWFUUkV0NlVCZlhsd1FzRWxIc01zTWQ0czNkK2hkQlVKY2Vr?=
 =?utf-8?B?OTM5S1c5cXV6dlpkcDVxdHNjdUlSRVJYTndsNHoxMGp2NThQUG92bU11T0d1?=
 =?utf-8?B?U2w3K3NSekVxUTRaQllVNWtzYThLUFlVWjYwc2dJc3EzdnRZWmFFbFdxQ05a?=
 =?utf-8?B?WkxQdmRtLzY4VXVXdEZNbUxnSHdlbGcwbXhMbmxSRllwVUJGTXdXdCs0cW1D?=
 =?utf-8?B?RUZTVUZDcElqRXRYVnhEWHdFWU9BbWRiOVlVSUxxcEhObnVwVGRzR0JQSXlF?=
 =?utf-8?B?WnMvcnVVRThFUXdnSXJGOVgxTGZjWXVnSEx3bE1ucDhpZXNPdktnZXdXTDE4?=
 =?utf-8?Q?/vVU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1627f953-0533-42aa-deb6-08dd13184546
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:28:32.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQEMbCGm//PPYMrLnxGKQ3PuN1i3Em7NvJVtSdTsuacHWVYKS1mDNic85/C9A/NR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

Hi Reinette,

On 12/2/24 15:09, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/2/24 12:42 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 12/2/24 14:15, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 12/2/24 11:48 AM, Moger, Babu wrote:
>>>> On 12/2/24 12:33, Reinette Chatre wrote:
>>>>> On 11/29/24 9:06 AM, Moger, Babu wrote:
>>>>>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>>>>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>>>>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Babu,
>>>>>>>>>>
>>>>>>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>>>>>>
>>>>>>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>>>>>>      For example:
>>>>>>>>>>>      Resctrl group mon1
>>>>>>>>>>>       Total event
>>>>>>>>>>>       dom 0 cntr_id 1,
>>>>>>>>>>>       dom 1 cntr_id 10
>>>>>>>>>>>       dom 2 cntr_id 11
>>>>>>>>>>>
>>>>>>>>>>>      Local event
>>>>>>>>>>>       dom 0 cntr_id 2,
>>>>>>>>>>>       dom 1 cntr_id 15
>>>>>>>>>>>       dom 2 cntr_id 10
>>>>>>>>>>
>>>>>>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>>>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>>>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>>>>>>> group:
>>>>>>>>>>           struct cntr_id {
>>>>>>>>>>                   u32     mbm_total;
>>>>>>>>>>                   u32     mbm_local;
>>>>>>>>>>           }
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>>>>>>> current implementation deals with domains that come and go. I do not think
>>>>>>>>>> this is currently handled. For example, if a new domain comes online and
>>>>>>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>>>>>>> not configured to the newly online domain.
>>>>>>>>
>>>>>>>> I am trying to understand the details of your approach here.
>>>>>>>>>
>>>>>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>>>>>> monitoring domain structure for tracking the counter allocations,
>>>>>>>>> because the hardware counters are all domain-scoped. That way the
>>>>>>>>> tracking data goes away when the hardware does.
>>>>>>>>>
>>>>>>>>> I was focused on allowing all pending counter updates to a domain
>>>>>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>>>>>> processed in a single IPI, so I structured the counter tracker
>>>>>>>>> something like this:
>>>>>>>>
>>>>>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>>>>>
>>>>>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>
>>>>>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>>>>>> domain.
>>>>>>>>
>>>>>>>> Are you doing something different?
>>>>>>>
>>>>>>> I said "all pending counter updates to a domain", whereby I meant
>>>>>>> targeting a single domain.
>>>>>>>
>>>>>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>>>>>
>>>>>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>>>>>
>>>>>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>>>>>> for readability)
>>>>>>>
>>>>>>> echo $'//0=t;1=t\n
>>>>>>> /g1/0=t;1=t\n
>>>>>>> /g2/0=t;1=t\n
>>>>>>> /g3/0=t;1=t\n
>>>>>>> /g4/0=t;1=t\n
>>>>>>> /g5/0=t;1=t\n
>>>>>>> /g6/0=t;1=t\n
>>>>>>> /g7/0=t;1=t\n
>>>>>>> /g8/0=t;1=t\n
>>>>>>> /g9/0=t;1=t\n
>>>>>>> /g10/0=t;1=t\n
>>>>>>> /g11/0=t;1=t\n
>>>>>>> /g12/0=t;1=t\n
>>>>>>> /g13/0=t;1=t\n
>>>>>>> /g14/0=t;1=t\n
>>>>>>> /g15/0=t;1=t\n
>>>>>>> /g16/0=t;1=t\n
>>>>>>> /g17/0=t;1=t\n
>>>>>>> /g18/0=t;1=t\n
>>>>>>> /g19/0=t;1=t\n
>>>>>>> /g20/0=t;1=t\n
>>>>>>> /g21/0=t;1=t\n
>>>>>>> /g22/0=t;1=t\n
>>>>>>> /g23/0=t;1=t\n
>>>>>>> /g24/0=t;1=t\n
>>>>>>> /g25/0=t;1=t\n
>>>>>>> /g26/0=t;1=t\n
>>>>>>> /g27/0=t;1=t\n
>>>>>>> /g28/0=t;1=t\n
>>>>>>> /g29/0=t;1=t\n
>>>>>>> /g30/0=t;1=t\n
>>>>>>> /g31/0=t;1=t\n'
>>>>>>>
>>>>>>> My ultimate goal is for a thread bound to a particular domain to be
>>>>>>> able to unassign and reassign the local domain's 32 counters in a
>>>>>>> single write() with no IPIs at all. And when IPIs are required, then
>>>>>>> no more than one per domain, regardless of the number of groups
>>>>>>> updated.
>>>>>>>
>>>>>>
>>>>>> Yes. I think I got the idea. Thanks.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> struct resctrl_monitor_cfg {
>>>>>>>>>       int closid;
>>>>>>>>>       int rmid;
>>>>>>>>>       int evtid;
>>>>>>>>>       bool dirty;
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> This mirrors the info needed in whatever register configures the
>>>>>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>>>>>> updated.
>>>>>>>>
>>>>>>>> This is what my understanding of your implementation.
>>>>>>>>
>>>>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>>>>> index d94abba1c716..9cebf065cc97 100644
>>>>>>>> --- a/include/linux/resctrl.h
>>>>>>>> +++ b/include/linux/resctrl.h
>>>>>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>>>>>           u32                             *mbps_val;
>>>>>>>>    };
>>>>>>>>
>>>>>>>> +struct resctrl_monitor_cfg {
>>>>>>>> +    int closid;
>>>>>>>> +    int rmid;
>>>>>>>> +    int evtid;
>>>>>>>> +    bool dirty;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>    /**
>>>>>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>>>>>> resource
>>>>>>>>     * @hdr:               common header for different domain types
>>>>>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>>>>>           struct delayed_work             cqm_limbo;
>>>>>>>>           int                             mbm_work_cpu;
>>>>>>>>           int                             cqm_work_cpu;
>>>>>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>>>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>>>>>    };
>>>>>>>>
>>>>>>>>
>>>>>>>> When a user requests an assignment for total event to the default group
>>>>>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>>>>>> entry.
>>>>>>>>
>>>>>>>> If there is an empty entry, then use that entry for assignment and
>>>>>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>>>>>> information from default group here.
>>>>>>>>
>>>>>>>> Does this make sense?
>>>>>>>
>>>>>>> Yes, sounds correct.
>>>>>>
>>>>>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>>>>>> initialize during the allocation. And rename the field 'dirty' to
>>>>>> 'active'(or something similar) to hold the assign state for that
>>>>>> entry. That way we have all the information required for assignment
>>>>>> at one place. We don't need to update the rdtgroup structure.
>>>>>>
>>>>>> Reinette, What do you think about this approach?
>>>>>
>>>>> I think this approach is in the right direction. Thanks to Peter for
>>>>> the guidance here.
>>>>> I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
>>>>> though, I think the cntr_id would be the index to the array instead?
>>>>
>>>> Yes. I think We can use the index as cntn_id. Will let you know otherwise.
>>>>
>>>>
>>>>>
>>>>> It may also be worthwhile to consider using a pointer to the resource
>>>>> group instead of storing closid and rmid directly. If used to indicate
>>>>> initialization then an initialized pointer is easier to distinguish than
>>>>> the closid/rmid that may have zero as valid values.
>>>>
>>>> Sure. Sounds good.
>>>>
>>>>>
>>>>> I expect evtid will be enum resctrl_event_id and that raises the question
>>>>> of whether "0" can indeed be used as an "uninitialized" value since doing
>>>>> so would change the meaning of the enum. It may indeed keep things
>>>>> separated by maintaining evtid as an enum resctrl_event_id and note the
>>>>> initialization differently ... either via a pointer to a resource group
>>>>> or entirely separately as Babu indicates later.
>>>>
>>>> Sure. Will add evtid as enum resctrl_event_id and use the "state" to
>>>> indicate assign/unassign/dirty status.
>>>
>>> Is "assign/unassign" state needed? If resctrl_monitor_cfg contains a pointer
>>> to the resource group to which the counter has been assigned then I expect NULL
>>> means unassigned and a value means assigned?
>>
>> Yes. We use the rdtgroup pointer to check the assign/unassign state.
>>
>> I will drop the 'state' field. Peter can add state when he wants use it
>> for optimization later.
>>
>> I think we need to have the 'cntr_id" field here in resctrl_monitor_cfg.
>> When we access the pointer from mbm_state, we wont know what is cntr_id
>> index it came from.
>>
> 
> oh, good point. I wonder how Peter addressed this in his PoC. As an alternative,
> could the cntr_id be used in mbm_state instead of a pointer? 
> 

Yes. It can be done.

I thought it would be better to have everything at once place.

struct resctrl_monitor_cfg {
  unsigned int            cntr_id;
  enum resctrl_event_id   evtid;
  struct rdtgroup         *rgtgrp;
};

This will have everything required to assign/unassign the event.

Thanks
Babu Moger

