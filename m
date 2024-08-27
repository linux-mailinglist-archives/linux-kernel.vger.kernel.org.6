Return-Path: <linux-kernel+bounces-303811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C0961557
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5702B218D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680F1CF2B7;
	Tue, 27 Aug 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dSba9TOo"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C591C9EC8;
	Tue, 27 Aug 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779259; cv=fail; b=OQOvwiNIxuLCWLsA/MHbdcDpuDqEMseOtecjKSFNz+9v5Z6chjisuiv6m3UnwzmlY+OruB1RoS5tH/CqD+W4wDwKVt0eL6Z9GYBSNuWntmvb4qZEjc4Dz8x6TIBEkwzh2f+MUAslrB+S/2qKb+VEtfmPC2dOd3K8+tDfD2T6eak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779259; c=relaxed/simple;
	bh=Lo/Ym3n7MRou9PKlQ8IoOzaG25kjtavOvJEfFGArmoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7ztADkl/5caUhObT5ffc3wkSaWTg3NSLhKGIHjh3A/3/1TdvkY8gHkfFtfTfha3dh08tPOyaLCfZ7Nmb5ycHZmMR7L7h7MA33EZErxSB8NBxQwt7AgxUP3P3XP8KEf5ZGJGzcHOXq749oHxascHjGkpqpz4uOg4dHiWfbgCCLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dSba9TOo; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEFMNhGrg/5Jkhd5ZO7/yESKnIS5f4HS1nEsaUQWR2Jzv5n8J7NwdBI8GoiPOs1EqSEIF3e81oD8ApX81Jc2WhBRWF8JfFBu+YaPttZKPYdgGEZleVZLR2FN6Wo/ZP4RvQR2Y5nsRf4iZTNXKjR+oOSzOGWCK38B46isVFcI8slIYNl5IXRG8Kd3hBVZ9ByetnslZ4PR04EbffC3otNr+9GugoJx9Tg2hFDzAhWrdvtlhNLo8G17S/zv2uRuMIk4V0uMMnZNN6Ot0ORhVhUY10CKg7jb62lFLp9m4kFkzZZgExyBLnIvf4I01q2t+2dwkBCak7MsgO/wvzbAtnq96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/yuSZNPkSUlPRc2h/C3DHCAhy3d8UFiddc8cRzc0D0=;
 b=czc0BE1s3jWoLA4IvS2fAV5SsIJqdqRq/8lNqxExLertxdS2xsBU411EYjfZgMLiJwfComtTYYWWOzuPbiufs1FO/zwjdTiov9sUuXQ4qrgzT5HL25HD6uM6EWJaVbQzclha257gOheXtuH/2ASEenJC1ToOurIR4nM8O7EV36FHabbPSUbQ2sUz7WtaAfqC2D8iFJcMfMwsj5cVlZrrJfE2s0XJrXs22jbBW/gFCkWXApqROqD5qPrp95NhAAedzYWzo8XwruB39MZuTVdsx13lGZ0vpFDlGnyLWUs2fn5AJWG37L/JqSKAHn/Y5E+WyXgXEym4tegP4LcpuHcOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/yuSZNPkSUlPRc2h/C3DHCAhy3d8UFiddc8cRzc0D0=;
 b=dSba9TOo6QjqHTqG0TCJkaiQGaEq6Ab5WKblkMhNSOj2cJAsFuhfnbkvFfe0RVTgau4l0WyboDFrVy+TjmqKz0yqVuY/5F62unfPCpw6Fa0rMmQNCC6LHxTmPjqGd44yzVoaMw2uLE8c9CiDQcaTGu+3DUxJOCwrwRb1vpnTk9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:20:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 17:20:53 +0000
Message-ID: <e5a06b5b-1281-452e-ab9e-83ac0edf2418@amd.com>
Date: Tue, 27 Aug 2024 12:20:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
To: Perry Yuan <perry.yuan@amd.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, Borislav.Petkov@amd.com,
 kprateek.nayak@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 bharathprabhu.perdoor@amd.com, poonam.aggrwal@amd.com, Li.Meng@amd.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiaojian.Du@amd.com
References: <cover.1724748733.git.perry.yuan@amd.com>
 <c4c66679fc6f8432c0402c8def2dc1b09eaa812d.1724748733.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c4c66679fc6f8432c0402c8def2dc1b09eaa812d.1724748733.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9129bf-b2a7-4789-a0c9-08dcc6bc9b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1o5Q1d2cW83VFlqOFJRWDY2a3lUREdMc1JCZ2dDTjJhcjdMNVEzOGZKUVl1?=
 =?utf-8?B?R0R2a2lKWDQxbGptM1AyU0dlcGFyenpCaHZVMUZlM0lUQjBYbmpPTFNwa3hM?=
 =?utf-8?B?REppN0FiaWFUZTRXUW1ZbFI5dlphK1p4N2hNRUs2cTZJMnpxMm11dE5iOHZW?=
 =?utf-8?B?U29VU3N6RVdPM0dJaW53ZDdQUTRDbjNZQTFwSzUvZ1lyK20yTDdmeG5PdHRE?=
 =?utf-8?B?VnVpTTA2NjhETU01RkRMQVRhdlZTTDBFRnZpM1RhSmQrL29tMnJzOXNza1A5?=
 =?utf-8?B?cG5PU2hUa05qUkNsSU5xZkwvSjdpUVEycjBqRml4K3JoS3htZnI0eXJWOXky?=
 =?utf-8?B?K0htV0d1OEdoQllWcW1VN1JSMmhiWWFDWTF0cWZDT05vaEZYZFlwT242TGhB?=
 =?utf-8?B?cWllU3kwa0szaDVoZHVmU3ZYK1pGQllvVXpkb1ZzRlpWditLQmdrWVhqWG5L?=
 =?utf-8?B?TDFSR1QycWxhUk5iLy9BTE80S29MREhQSWNLaEhsZHI5ZVlIaDNSVm5zVkVL?=
 =?utf-8?B?bEk2emJyV1FoR3BBVDRTT2NsMnlubVZGLzh3dDcyRmNxcVNmNml2OFVqSksx?=
 =?utf-8?B?N1JTK0YrT0pxWlc4QXFrUkpoaHVpdXkvSTRIZVNUYzM2MlIxTGsyUW93QUhn?=
 =?utf-8?B?T0sxNlMzWUVqVzZoUGJoYU5DVkM3aUhXY0dLeVljNUdiVkUvbWFkL29qWkYv?=
 =?utf-8?B?RFBiWUR4a29rdXNOb1pHYlN3b21yTThDNS9SbVFOQzdZQ0VhRGJoQWtQU2tm?=
 =?utf-8?B?UE9kQTl4M1JjWDkvcFY1MGUyZEFuWGhCTStrT3BGbCtUY2xBRGN3bDA2ZVFR?=
 =?utf-8?B?RTdjclpTZ1NrcjJTdStvN1p1ZU05YlVMNmZZdUZDNnlURGpMeUw4eHRoQUNX?=
 =?utf-8?B?clhpSDNaUXhGcTBRVkM5cHRHMnlNejZmcTFyR1U0WTJoZWliN2hUYkU5OS9L?=
 =?utf-8?B?L3gzQVFKWHJzVUJqT1UyV21UVG5tUUgvQWtIbVViUERMNVZxTUZyOEJnbDUv?=
 =?utf-8?B?VFZFcXJBeUYzemdIZFRmMmR1cDl6cFhYMkNPWFVEU29KSFU1TjZEM1NWdnBr?=
 =?utf-8?B?UnNUaTRLZmZwalVrS2VZY2k1Y0FaNE9TQTBNZXlQWVZSQk1xVTZsWXhKdzE5?=
 =?utf-8?B?VEllQnJ2NGVZNGFzY2t6MW41SHdnejVwMzU5YktXblhqQTZGWDN1QWZ0VGwv?=
 =?utf-8?B?dzJEYkkvR1BPc0t6YUF5eUhmeXdSS0dBbk15ZFEzb1F4L0lzdkxicElVWXF6?=
 =?utf-8?B?Q0FQa2FGakFnVDNBQ1RucXBsQll4NmhUdGFtZkNqVXFpMjREckN2ZHJrRUty?=
 =?utf-8?B?VS8xbUlMSHpqMytrR282MWpMWWhpRDBacjVDUlFRbUpXcDFtbk9pQ0NrcjdU?=
 =?utf-8?B?UVdvbVdDOTBqU1JhQnZpOHZqbHNIVnk5Tk9Mdk4yMEY1VXp6T0VhUGFWa3Mv?=
 =?utf-8?B?cUNzRGU4VFdEWFZCOXAwVVgrNDBBK3RDVWRxVG9wbElsSUFhVXEvZ1RkNTZB?=
 =?utf-8?B?UHdkdnV0YXl6MytPMVpuZCtsQ1dwT3VxdTNYWFRNV29Ra05zM3FHYmVqT25Y?=
 =?utf-8?B?bVcxS2M0NXNUWVdlY0xuLzZkQXVLVmFwUk5lUWtsNWtGc3F2R3Y3NG40Qk1u?=
 =?utf-8?B?VXl1bHRBSmdyZFU3V09mQU4xRWdsUWd1N0ZqbHVPcTJjSWlwenhYNEVweXJk?=
 =?utf-8?B?aHZsOWE1SjJDZjg4UlpGSDZmYzJscDBBT0JxUWROYy9JdllmRnY0MCtXbkd0?=
 =?utf-8?B?MmJ4OWk0ZkFQd3Fsa2k2SEx2RFBkK1NsQmJkeWJMQ1BXRTNvRmh3YmlzUjVJ?=
 =?utf-8?B?LzhpUzNCZ2N6cllDWXA4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnlXQjJsdG11enBCKzdqd2ZvRW0xZ28wTU5tT2tSSnBMdTR5VEVaektqWXZN?=
 =?utf-8?B?OFVrRVdja1oybEFjeEhSVzdDL09tamNPbVNWeGMrT3Y1WG5pcHpMc2FmY0xU?=
 =?utf-8?B?NlFVOEdpZ1E2ZlpxZ0RXZU1WOXRwayt3cGhHd1VtSFpjZVMyWWZYRWhNODNX?=
 =?utf-8?B?VklSa3BHSEw0ZzJDUmZqeFV0Mm9QTU15ekNrWFpJQVFBanZ2STQ0aUVWMTVz?=
 =?utf-8?B?V0VKWnFVY09ZTGNNdDFkRjJ6M0FoNnF0T3cwOVhxTjAxUUtBSmhIVmJKb2VH?=
 =?utf-8?B?bGZiaHNBSnZZWUowK2pXRzNXb3pZWlJrQnBlTnVzeVRhdTFid3hTTXNhY3hM?=
 =?utf-8?B?S0FoeStheUVVaSttMUJOT2FVRUpQNUpTK0lsZ1YrUkUzVWlIcjBlRHpSLzZD?=
 =?utf-8?B?ckxSV1FlQXdNWXVXbTR5WlIwT3BzV0JlYUF3eGczbWxjNUVna2xhZzBTQUlt?=
 =?utf-8?B?dHdiUjY5c0lCUFZOUWptSmt1U3RpdWd3R1NyY1dUMzFyUWtoS3lsb2tXakFk?=
 =?utf-8?B?eUxQSERycHZYb1k0VnVyR3UreWwwQXpsMFhDWVNtRThBbndMNmRFTlhGMGRy?=
 =?utf-8?B?MnFvN2Yvd3lCdHdxU1hkQWJHeWlwZUtmVEQ0OGVwWGNVZzQvZzZqK0RmbHh0?=
 =?utf-8?B?Yi9GYW5ncDRPNmpVUHVaYmxkRDBWZld2VmJDTVJnT2M5c2dZWnVwa3NHVG05?=
 =?utf-8?B?U1BSSE8rNmUrS1B1SG4zQ1dCWU1rZk9KY0s0NlBCd2pKVUZyeTVxWUxZWFNH?=
 =?utf-8?B?ZDYrSU9nLzRMMU9UQWkwQ0N6UHhuNWpwSW5GeUZqSzhnVmduUlI4Si9UTElz?=
 =?utf-8?B?WERJSUxKY0NZTGVBNmc4MzkzVEZ1bzFUOFVrSVU4azBDVVRPMUtFbXNHMGZB?=
 =?utf-8?B?bWxkc0w4MUs0SWdCQ01URThJRzdqL3IvcWxnNDA1di9JVkV4MzUxMUZCcnJY?=
 =?utf-8?B?Z29ic1JEanE4WkFXL3pLWVhEaDVUYmR3Skc2L0ZaT0hnVm1zRFRySnBNZTV2?=
 =?utf-8?B?NStNY1lBbEEvaFY4TkZ0dXJ6aHl4UjRTTXNvTUdKbThQbWFlMFgwbS8xQzdR?=
 =?utf-8?B?U0lIMUlaU2dDYVRLN29lTnphbmpMaUMrVFVtV0hOSG1QYWZROW80MktJVzI2?=
 =?utf-8?B?L0RGVHVSNWxuNm84REhCa1BGTWIvaWoxa3ppMXAzYVphcmMxeHp2cjBIbDY0?=
 =?utf-8?B?RkJ1bVBxckR4M0k4Uk10eU1Xc251dk5ENFdxaU9ndXBzTzlMTzJsdU41ZEx5?=
 =?utf-8?B?amNSL2ZpMm1hOE0zS1JKUXdRaFl1VXdVYmlZL2I5UE9ZZWowYlBXZXl2MWwv?=
 =?utf-8?B?bURXZXhiUkRpeFJJT08xYXM2VHVGcEl3QXFFdDVnVjVEdHhtT2tzSmF4alVL?=
 =?utf-8?B?VWhUdzF6ZXFBYVhJc1krQ25EY1dJRmNFRi95TWFDMEFsYkVTV3U2cnNLOWI4?=
 =?utf-8?B?YlZNVE5wcXIwWTVLd3lZekVsMjhBaG1CNDBKYUhrNXdqWkppaHN6SlFCTGhm?=
 =?utf-8?B?MU54VG1DNEk1aHhvamtYaWdBNjA0ekw1eEhrS0ZPWHpiSkNDTG9GaXc2c29V?=
 =?utf-8?B?VXFhUTRuSGpkNFl0aVVEczdmVkpPRlJNSldlUXhrTEd3bEdLSkVqdXlMWDA5?=
 =?utf-8?B?Tm82ZUIwSDNBcThScXJZWk1WWTlwYXZBU2M4YUY0SFlFeVYzZUttR0FZUGJR?=
 =?utf-8?B?SkttUnJxaFV0RWhqNHNsdnJqQS8xbkZ6aWU1NDVmSnEwOXFOK3c2UTljaXlR?=
 =?utf-8?B?bWFEUzBEYTRpdlFIZDBZSDJoWml4VndKVFNQOU5KbmZxWnM5RlN6Znl4aTFM?=
 =?utf-8?B?ZEQwY3BRTm5XbW9YRDU5WEc3c3NQVXUvNnlLcEJPb2E1VTVFVWhBYWhxSzEw?=
 =?utf-8?B?c3NFYXVIQ1dqQTNjN1prMzU4TXFoQngwdWtaWnVZOUp4VHFrcmwxRE9DTm03?=
 =?utf-8?B?aGZnWDdCandzSUMzU2FDSzB2ZWtFYUxnUEpyWnR0L1NnU3l5MW16Y21DT0Zm?=
 =?utf-8?B?RTd0SVhneDAwQU0zbEFvOHN4a29DSU4zcFZFM3NleThpdHluRkdZaTAzVUFk?=
 =?utf-8?B?Ti92RVRZR21SNU1DcHRWUStSSnd1R2tXY2dPMlRkTDZ5S1lQeTRtTWZWWXhQ?=
 =?utf-8?Q?FQC75/31UFSsZjUvULAxkCc/z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9129bf-b2a7-4789-a0c9-08dcc6bc9b07
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:20:53.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StbCKkEIdq8tbgeEG8F9FarOVd5gISjqlWQlNrQGCILsY0GqGZYrKGvaI/LFplVtHbpV77WYatsTLfcrkgN4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

On 8/27/2024 04:36, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce a new documentation file, `amd_hfi.rst`, which delves into the
> implementation details of the AMD Hardware Feedback Interface and its
> associated driver, `amd_hfi`. This documentation describes how the
> driver provides hint to the OS scheduling which depends on the capability
> of core performance and efficiency ranking data.
> 
> This documentation describes
> * The design of the driver
> * How the driver provides hints to the OS scheduling
> * How the driver interfaces with the kernel for efficiency ranking data.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/arch/x86/amd-hfi.rst | 116 +++++++++++++++++++++++++++++
>   Documentation/arch/x86/index.rst   |   1 +
>   2 files changed, 117 insertions(+)
>   create mode 100644 Documentation/arch/x86/amd-hfi.rst
> 
> diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
> new file mode 100644
> index 000000000000..351641ce2821
> --- /dev/null
> +++ b/Documentation/arch/x86/amd-hfi.rst
> @@ -0,0 +1,116 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================================================
> +Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
> +======================================================================
> +
> +:Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> +
> +:Author: Perry Yuan <perry.yuan@amd.com>
> +
> +Overview
> +--------
> +
> +AMD Heterogeneous Core implementations are comprised of more than one
> +architectural class and CPUs are comprised of cores of various efficiency
> +and power capabilities. Power management strategies must be designed to accommodate
> +the complexities introduced by incorporating different core types.
> +Heterogeneous systems can also extend to more than two architectural classes as well.
> +The purpose of the scheduling feedback mechanism is to provide information to
> +the operating system scheduler in real time such that the scheduler can direct
> +threads to the optimal core.
> +
> +``Classic cores`` are generally more performant and ``Dense cores`` are generally more
> +efficient.
> +The goal of AMD's heterogeneous architecture is to attain power benefit by sending
> +background thread to the dense cores while sending high priority threads to the classic
> +cores. From a performance perspective, sending background threads to dense cores can free
> +up power headroom and allow the classic cores to optimally service demanding threads.
> +Furthermore, the area optimized nature of the dense cores allows for an increasing
> +number of physical cores. This improved core density will have positive multithreaded
> +performance impact.
> +
> +AMD Heterogeneous Core Driver
> +-----------------------------
> +
> +The ``amd_hfi`` driver delivers the operating system a performance and energy efficiency
> +capability data for each CPU in the system. The scheduler can use the ranking data
> +from the HFI driver to make task placement decisions.
> +
> +Thread Classification and Ranking Table Interaction
> +----------------------------------------------------
> +
> +The thread classification is used to select into a ranking table that describes
> +an efficiency and performance ranking for each classification.
> +
> +Threads are classified during runtime into enumerated classes. The classes represent
> +thread performance/power characteristics that may benefit from special scheduling behaviors.
> +The below table depicts an example of thread classification and a preference where a given thread
> +should be scheduled based on its thread class. The real time thread classification is consumed
> +by the operating system and is used to inform the scheduler of where the thread should be placed.
> +
> +Thread Classification Example Table
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 0        | Default        | Performant                    | Highest             |         |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +
> +
> +AMD Hardware Feedback Interface
> +--------------------------------
> +
> +The Hardware Feedback Interface provides to the operating system information
> +about the performance and energy efficiency of each CPU in the system. Each
> +capability is given as a unit-less quantity in the range [0-255]. A higher
> +performance value indicates higher performance capability, and a higher
> +efficiency value indicates more efficiency. Energy efficiency and performance
> +are reported in separate capabilities in the shared memory based ranking table.
> +
> +These capabilities may change at runtime as a result of changes in the
> +operating conditions of the system or the action of external factors.
> +Power Management FW is responsible for detecting events that would require
> +a reordering of the performance and efficiency ranking. Table updates would
> +happen relatively infrequently and occur on the time scale of seconds or more.
> +
> +The mechanism used to trigger a table update like below events:
> +    * Thermal Stress Events
> +    * Silent Compute
> +    * Extreme Low Battery Scenarios
> +
> +The kernel or a userspace policy daemon can use these capabilities to modify
> +task placement decisions. For instance, if either the performance or energy
> +capabilities of a given logical processor becomes zero, it is an indication that
> +the hardware recommends to the operating system to not schedule any tasks on
> +that processor for performance or energy efficiency reasons, respectively.
> +
> +Implementation details for Linux
> +--------------------------------
> +
> +The implementation of threads scheduling consists of the following steps:
> +
> +1. A thread is spawned and scheduled to the ideal core using the default
> +   heterogeneous scheduling policy.
> +2. The processor profiles thread execution and assigns an enumerated classification ID.
> +   This classification is communicated to the OS via logical processor scope MSR.
> +3. During the thread context switch out the operating system consumes the workload(WL)
> +   classification which resides in a logical processor scope MSR.
> +4. The OS triggers the hardware to clear its history by writing to an MSR,
> +   after consuming the WL classification and before switching in the new thread.
> +5. If due to the classification, ranking table, and processor availability,
> +   the thread is not on its ideal processor, the OS will then consider scheduling
> +   the thread on its ideal processor (if available).
> +
> +Ranking Table update
> +---------------------------
> +The power management firmware issues an platform interrupt after updating the ranking
> +table and is ready for the operating system to consume it. CPUs receive such interrupt
> +and read new ranking table from shared memory which PCCT table has provided, then
> +``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
> +
> +
> diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
> index 8ac64d7de4dc..7f47229f3104 100644
> --- a/Documentation/arch/x86/index.rst
> +++ b/Documentation/arch/x86/index.rst
> @@ -43,3 +43,4 @@ x86-specific Documentation
>      features
>      elf_auxvec
>      xstate
> +   amd_hfi


