Return-Path: <linux-kernel+bounces-294550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3922E958F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE001F24018
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68301862;
	Tue, 20 Aug 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SBz/Nwj3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CE18E35A;
	Tue, 20 Aug 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724185106; cv=fail; b=YldYvnyb/dlSA7hCuwGxhZsCUTHZzdwnPpxcDFW/A0W9AxRexcuEdTLtGJx0gwgRHKuHgcpC0Awf2AH1VQJs5YDNGkTtXTy38cqylC0Q/WEvcp6hMS7dn+nSPUi0LBZ4N0K7XCaPqD8b3PrTcwa6+ojEMEjV8+0AUIaPZlz9p8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724185106; c=relaxed/simple;
	bh=PPdc2D1tRvXnCmDpT0Fw5WPvwPPxn9Yxgtz4mOeZIS8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RG5XchctkWA6RvIGVlk2Gml8uJ092S2hK4UPEDq0MP2zjRbZb4mZa0LYSfPjotGI9eSbO4DaM2MnT+KmmPTV6wPnYuhzBHwUCAilQNEQbOsrJu68TLDvERj0bFQ3zKyQ4lji4nIeJqy361DH8U+mF+/mgnNnqJEHWBJpY7ValKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SBz/Nwj3; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLh9EnYQJQGPNc9PMwHB8AD5Jl/tIOpvJ9Z9Iqm3df4sQ2lpzPaTQE0nZHM0nz3zzKyYnVbjFnTSD1ECjg/qw2BiqcvoKP4XXoW4jfUSraAzSVSMcY+n7KMzedgKZoqJJmD58GBnDN+9uhj2Yz5v+Rhtu2eVWdjL3omUKcZlQdqXxGTO7R2zzfWy535uZcS97ZtKpPii1iWrmOjf3oyHDRo4nG8098Szjphqr5Oh0fDihQqT+5WJOEXSdbKdzZhgEnOESCpJx5cOH+y7AEeq9y3zn/T9IlCsUGpz3GXKNPNiNgM0IVn7yZoiPDhNRhmWSneHIBGqf30yX3vPDT7wpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkH8wf7wH5pKbQP76SbpEfI8rj79YwDEVapP1NZxHF8=;
 b=zG528ZcTvnAJSJO6R8G2GhQFyFXZHT/kGwqtSYM5RbtAkS1nxUrsDxglP6KuzLwMtS8QiBA6gYDGuilPouFE5C4MRJoSmge4uvc+Gkr71vUe20cO7ab8ImsRVIxi2pZZT9OGhWZ9QxI4fJ/WkknnPcbVFapM5vjBeJHwBtmKb8zWfUn06jpd7IGDk8JkfsS7EZrBYb8DrdKYmchwjY0wZLDZJvsjyYjR71MWyMLKajd4lqWdbgtrIbiD8sSqeDevnpohLjELFwWhyoD5RPdQUcqkztn/Z2PlAK9UwYTQ2SXExQA2FjJBEBLKYTSVPJAKwzeaI06bMGW//ndOnUhjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkH8wf7wH5pKbQP76SbpEfI8rj79YwDEVapP1NZxHF8=;
 b=SBz/Nwj3Jghd4gxD85YsEI/KUdsG/Dd6qzzyrXVbrKqri1qZZy5rc275n1i+tTkbDfk6sYc1MJR1sjCjXjBSIfZnJep25Qo5m/VKrSVGJkoeXX8+/qSsxVbsmDvSXn7Pcxnw5stXKjaDxWeM4FtvWHL5RzSCVkSaQEhsG8QkE5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 20:18:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 20:18:21 +0000
Message-ID: <f36f5459-cf5a-4401-8a00-cca83c293fdc@amd.com>
Date: Tue, 20 Aug 2024 15:18:15 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
From: "Moger, Babu" <babu.moger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
 <ab979768-a98b-417b-b319-6f14da88b857@intel.com>
 <16263da0-603a-44a5-b6be-58c66b8dd863@amd.com>
 <6b1ad4b2-d99f-44fb-afcc-b9f48e51df6e@intel.com>
 <b80a9e76-764a-4303-ada8-aa4d08559664@amd.com>
Content-Language: en-US
In-Reply-To: <b80a9e76-764a-4303-ada8-aa4d08559664@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0181.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b6e5f6-0d70-45fe-49b6-08dcc1553c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVhqc0FOTFhBRzFrM0s2Z2V4L2REenlxb3pSZ01CQUEvQ2lRRUd3L0ZyQUVo?=
 =?utf-8?B?TG1sK01Rbzd6aHprQURyelJ6eitvN3owbjhjYWwwUkVxMmRhWmNvamNPeXRQ?=
 =?utf-8?B?TTZRU3BHcTBRcitmTEo2RXBRc1dBYmMwdEZEd3BmSUM2Rk94LzNHM3ZtZXlq?=
 =?utf-8?B?dy90bU9VTmRhYXZ3Mk1kS21WazZTOWRIR0txZnY4VDVuZ0lnYTVmZmpobGp2?=
 =?utf-8?B?dzZGZUtpZW9HVExqWkNmN21Pc3JkMVNrMEVBa05iUUsrQ3RYblZHRDZrclFC?=
 =?utf-8?B?cGM0VkFRcXQyVXZwWDBaZFR3bXpqYkpYSWJlSWp3SVFmVjRwZWw0eEdGeW9j?=
 =?utf-8?B?TDNNMTlPR2ZHYURDbmJ6bDhtSEM1b25iSE9KeVg3NHNOM09WNGkzcWRsdVdH?=
 =?utf-8?B?QU92aWRaeDV1dWhkeSs2bzE0cnlmaG9OOHRRWjJoV2xibStBd2VhM1BkeHd0?=
 =?utf-8?B?cHpPbThBZzRTUmFPcTMxRmxJTTUyNnFwUVpUZzVkUmlMc3NsRnJSaDI4Tit5?=
 =?utf-8?B?Wm1iYU1FeFNVY1JuWGEwMzRaZE42WG9zbUxRbkd2WVhqSW5TY1pPTEJNUkNS?=
 =?utf-8?B?MHR1RGRTSys5QWNYNzZZZ1BGbWQ3RFVVbll5bTZuTjJ0VGQ3WmExYVFNdVdx?=
 =?utf-8?B?MHpXdGZrQjF5dHZoVm9ZbEYyc3lpYjIrUEUyZXA4ZnNzY2k2Z056QnZxRzNa?=
 =?utf-8?B?MFYxd1dHZkN3UVkzd0ExT09PdGFNenQ1YnlEUVdiZXFTNm5WYUNwRjU5SUsw?=
 =?utf-8?B?QlBMeVBFYmtZNmVYb0YyTXJ1d1o2cFdFY0o3S2pvS3JZQkp5MnBKbW1kR0Vo?=
 =?utf-8?B?QTF3NUQ4UVFnWGViUzdNTnhUQ0dnL2RRQk5hT2lnMGIxUjk5bzhTS1VIYlIy?=
 =?utf-8?B?THdVeFRxZmpNcWcwbU96ejlCenZyYWxKc0h3UVR1U09naTZFbWtYZU9jZUsw?=
 =?utf-8?B?QmxQTmZjVndETEtaMy9ncURhd3JKY0wrbGZXKzlTeVB1ZG5od05ZcGFSanlQ?=
 =?utf-8?B?R3VEUCs3M08xSkJSVmwyQnNIc2xLYjFFd2lsVnNZN2h0TDUrNkVsb1FrcXo1?=
 =?utf-8?B?OHVOK0Q1ZTNSeHA4UzZuM2FXK2lBR2pyT0tpSmFYQlc4K2tTbnVqN2hlbG1M?=
 =?utf-8?B?U2ZtSnBaZGsyZ2JnaDZwalVBTHVrRGRTeUpKalE4QllHZEFNQ2RUYTdCc0lk?=
 =?utf-8?B?Y0xhRkViczRTSjNPQlU1RUVSOFdza3hQVFZaNmtGMHo4WERHQXZHdTlpZjI4?=
 =?utf-8?B?L3pWbVcwSzlDd0kzeDFyQjBieDRVY2d4a1habThJUmREenFGbkIyRDdIZ3l1?=
 =?utf-8?B?cW1VMWVvVWRtYTBBSUFjcm5aVzNJTUFGWW1aMjl2dmpYSjV0ZWNkcTJNUFI4?=
 =?utf-8?B?Mk4xRlkvdGVIKzdaOU9MaWRtaE9KNS81NHJURGZZQWMyZEpFL3lmcUF6YUE0?=
 =?utf-8?B?endFc3IrNElvYTBIZU1nKzZ0MXYvclJnWjhvMU85ZzZiZHF3MXVlWmQ4U3BX?=
 =?utf-8?B?Z1hVNVhmOEpvMWsxOE1Yd2piVHY5cm91YXJnR0svYjdZdTZuMEhSQUE5WjBX?=
 =?utf-8?B?RGRRL1ozRFpYNlY2V0NSQStlUzFwS0hSSGh6VzFmQUlJT1pLTkpQdDZnaXpm?=
 =?utf-8?B?YU5QK3hod1Ezb2l1S1NJSHpWb24zT0RSWi8xdEdCYTF1QVY5TUYzZmd4bll4?=
 =?utf-8?B?QlVFK28vb2VITVN5WGlLOHR0YW1adTRkYmxQWFluWU94cXNkK09VUTZNdm8r?=
 =?utf-8?Q?NNO+S1YLtHYJCMsE9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWJxQUJjQXN2cXpCY3o5dC9UTjR6UGErMUtENzBtWEVtMHpJSi9ReVd0RlVu?=
 =?utf-8?B?MEFqMHdGaTl5NHFpOHBSL2NPYURHTHlYMUJNMEw2Vy9CVnBNcGxDRU5jally?=
 =?utf-8?B?ZkVIelV1RFVoNGVUbHN5WUFXZjA3RjE1YU5xYncvYmlYQzE3ZklwMXVjcW5m?=
 =?utf-8?B?bmJXSmp5bzNTaXBUcTc2aENreXFvVkVoR0M0U1RPQ3FxYktVYkdqWDNQWUpj?=
 =?utf-8?B?eHNYMTFyV1g5eEZyR0lPWVZ4ZnAxMEpUZW53emNvQklNNGRZMyt5Um8xQU9G?=
 =?utf-8?B?eFZRWWgyRS9oc0JmMlpEajBIRW1KdUhFa1lUaDI2MlkwVmt3bnZJUzQyeUM2?=
 =?utf-8?B?WGdWUTdhU0NhSENSR1N1bUx1V0U4dmNETXF3aGExUlltZnRORW11N2JvbktQ?=
 =?utf-8?B?Uyt5Mmo5K0lmSmx1TVJZM3RQWitnZ3oxdGVLMDZXM2tzSDNyTXYyOUlITWRY?=
 =?utf-8?B?amN5M2UyN29FNy9QYkZXbW1Wb1JUb0dFV25TM0UwTWdWWXVkdGNXdldRcTBN?=
 =?utf-8?B?dGRRcDZXV3FVaXB3Qm9vNGkvNmczRnJ3amhTdFloR0dmZ2RDc0k1dFVmdFYx?=
 =?utf-8?B?aEk5d2dQRGxGOWNRVzJIT2Z0YXdETjNUUjczV3hZTEZrYndnaU1xSnJFRHNk?=
 =?utf-8?B?dDMwNTFlUG1jSHF4T3pNV3VHbVpITkM5T2pEbndCTUNFekRVUU5RZ1dFWTJY?=
 =?utf-8?B?RWlDUVo3YzJkb2pIYkNqck4wZVdLL1RxN3RWRlZQSndFckdheml3dTJhR2xv?=
 =?utf-8?B?RGRPRHJpbTYrUDIvZ1Zucmc0REIyd25wY1ZSeVlQR2wwdHFsTEVjTndCKzlj?=
 =?utf-8?B?VXl3RFVLSldiNktJR1JCSm9tMklJK2FWdWhmeDdLNnByTk9OWkdPT0s0eGZl?=
 =?utf-8?B?VUJyZE9zWVRrdXozYWhwOUVLY25rdDFGcEFCeGxUQ3RmcGZId1ZsV0pHWm5V?=
 =?utf-8?B?U21PMXZoSVBvRzIvekdmeVVyM1BBSk1DUjN4TDhnNmZmbVR1bFFNRzF0UFJM?=
 =?utf-8?B?TnNXUXhXaFRoVUFSQXp4azJWUlJHQ3BaNVNSM0Q5Q1pSa24xV3FPSC81U3E1?=
 =?utf-8?B?NElJVUR3Vm9sb3ZLeHVMWFRxQjQxYmJYUkgzbEVMbXU1S2NMblFWSXdMbDNF?=
 =?utf-8?B?cWlxeEhtdXNSY2N4TDk5T2NXVHpXL2Vqa0lmTno0Y1BlR3U4YVd2ay9EY28y?=
 =?utf-8?B?azQzZGVHQXFZMWxWM1hBTFJqeXM1bUp1dzNQem9iUVh4SzhxSFBPZzZIa1dj?=
 =?utf-8?B?elltTVBMeWlhcU96bm5jc3hXMlNTSzlLS1Fqd1BwZ0Y4QXkxY1RBVytDTWZj?=
 =?utf-8?B?bDJJak15eWY0Z0toMkl2ZDYzZlgxL1BqZlVJbVVvZ0JJWjhUUTVoK1FtQW96?=
 =?utf-8?B?UTRxSnE4L29CNUpjZDIwUkt0ekVWUFkwMytwRXdqSTVCT013ejZEd1JPRGc5?=
 =?utf-8?B?UkhHWitFTERxb0c1ZndVdWE5MFkzWkJxeU8yMkRrMnFYeFlhZ1FRVHMvK1lj?=
 =?utf-8?B?OEVISzk3S3NjQ3pSMnpnMDRZZFFyRjFTRU9RYXc0aFgreXc0YTNJMEVDcDdP?=
 =?utf-8?B?d0ZPUEZpaGl4RFBpYU1RT1hnWG9zUkNqYmZUMmxKSTl5K1M2c0J4Rk05OFZs?=
 =?utf-8?B?dFM5TXByVVYwUWZMcDJLTmpBQUNHSWV6dFhQYVZnVVpoVXBpWTIzYnFxTk54?=
 =?utf-8?B?K0JYamt3eVpKMFRIb3B5QUw3NW5wTnR3Ukt5Z3I5NUYwRG9IUGs0eWdyQy9m?=
 =?utf-8?B?UjJZNFlydElpSGtZZStVRUVMQlhTamYybVVEanBhVFZ0MjRpakpBSUhZR3JS?=
 =?utf-8?B?a21QUDFOZmlvZXk1L1hQYU1yNFdkOVorbnhPUUl4Y3M5c3hUSkpwdkZZekFX?=
 =?utf-8?B?VnQ0TE9hK3cxMkx4MWg0amUrVUhJYzV5eUFrVHFxd1ZEWnRIMEs1SmRYS2dn?=
 =?utf-8?B?eVZHSFUxT3VpN2xUckFiVGZPOHBJemNTN1d4dXhvNkRuRGxEUTd3d1h3Ymdk?=
 =?utf-8?B?YStaV3FLVnk1cEdZMzkyV2lQTnl1NGkvMGZWNWdleWw4dXdSTFdBNlZjRVNX?=
 =?utf-8?B?OStDUVNYdUdFMUQ4UHJxTGZlWmhRN21rVmtlSEVXNkZTMkdEYkdIeHdMakl6?=
 =?utf-8?Q?MBkA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b6e5f6-0d70-45fe-49b6-08dcc1553c9c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:18:21.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPF4yWVzOBKVt9lWmDRq4f5U26EuHjKGgWwHe9V94LTyyvPD2zML0IVXH0UxhQPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525



On 8/20/24 15:04, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/20/24 13:12, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/19/24 11:18 AM, Moger, Babu wrote:
>>> On 8/16/24 17:33, Reinette Chatre wrote:
>>>> On 8/6/24 3:00 PM, Babu Moger wrote:
>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 66febff2a3d3..d15fd1bde5f4 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>>>>>        }
>>>>>    }
>>>>>    +void resctrl_arch_mbm_cntr_assign_configure(void)
>>>>> +{
>>>>> +    struct rdt_resource *r =
>>>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>>> +    bool enable = true;
>>>>> +
>>>>> +    mutex_lock(&rdtgroup_mutex);
>>>>> +
>>>>> +    if (r->mon.mbm_cntr_assignable) {
>>>>> +        if (!hw_res->mbm_cntr_assign_enabled)
>>>>> +            hw_res->mbm_cntr_assign_enabled = true;
>>>>> +        resctrl_abmc_set_one_amd(&enable);
>>>>
>>>> Earlier changelogs mentioned that counters are reset when ABMC is enabled.
>>>> How does that behave here when one CPU comes online? Consider the scenario
>>>> where
>>>> a system is booted without all CPUs online. ABMC is initially enabled on
>>>> all online
>>>> CPUs with this flow ... user space could start using resctrl fs and create
>>>> monitor groups that start accumulating architectural state. If the
>>>> remaining
>>>> CPUs come online at this point and this snippet enables ABMC, would it
>>>> reset
>>>> all counters? Should the architectural state be cleared?
>>>
>>> When new cpu comes online, it should inherit the abmc state which is set
>>> already. it should not force it either way. In that case, it is not
>>> required to reset the architectural state.
>>>
>>> Responded to your earlier comment.
>>> https://lore.kernel.org/lkml/0256b457-175d-4923-aa49-00e8e52b865b@amd.com/
>>>
>>>
>>>>
>>>> Also, it still does not look right that the architecture decides the
>>>> policy.
>>>> Could this enabling be moved to resctrl_online_cpu() for resctrl fs to
>>>> request architecture to enable assignable counters if it is supported?
>>>
>>> Sure. Will move the resctrl_arch_mbm_cntr_assign_configure() here with
>>> changes just to update the abmc state which is set during the init.
>>>
>>
>> I do not think we are seeing it the same way. In your earlier comment you
>> mention:
>>
>>> We need to set abmc state to "enabled" during the init when abmc is
>>> detected.  resctrl_late_init -> .. -> rdt_get_mon_l3_config
>>>
>>> This only happens once during the init.
>>
>>
>> I do not think that the ABMC state can be set during init since that runs
>> before the fs code and thus the arch code cannot be aware of the fs policy
>> that "mbm_assign_mode" is the default. This may become clear when you move
>> resctrl_arch_mbm_cntr_assign_configure() to resctrl_online_cpu() though
>> since I expect that the r->mon.mbm_cntr_assignable check will move
>> into the fs resctrl_online_cpu() that will call the arch helper to
>> set the state to enabled.
> 
> There are couple of problems here.
> 
> 1. Hotplug with ABMC enabled.
> 
>   System is running with ABMC enabled. Now, new cpu cames online.
>   The function resctrl_arch_mbm_cntr_assign_configure() will set the MSR
> MSR_IA32_L3_QOS_EXT_CFG to enable ABMC on the new CPU. This scenario works
> fine.
> 
> 
> 2. Hotplug with ABMC disabled.
>   Current code will force the system to enable ABMC on the new CPU.
>   That is not correct.
> 
> 
> We need to address both these cases.
> 
> 
> I was thinking of separating the functionality in
> resctrl_arch_mbm_cntr_assign_configure() into two.
> 
> a. Just set the mbm_cntr_assign_enabled to true during the init.
>    if (r->mon.mbm_cntr_assignable)
>        hw_res->mbm_cntr_assign_enabled = true;
> 
>    This is similar to rdtgroup_setup_default().  Isn't it?

I just noticed that I cannot access rdt_hw_resource here. I may have to
write another function resctrl_arch_mbm_cntr_assign_set_default() to do
this. What do you think?


> 
> 
> b. Change the functionality in resctrl_arch_mbm_cntr_assign_configure()
>    to update the MSR MSR_IA32_L3_QOS_EXT_CFG based on
> hw_res->mbm_cntr_assign_enabled.  Something like this.
> 
> 
>    void resctrl_arch_mbm_cntr_assign_configure(void)
> {
>     ---
>     if (r->mon.mbm_cntr_assignable &&  hw_res->mbm_cntr_assign_enabled)
>             abmc_set_one_amd(&enable);
>    ---
> }
> 
> 
> Yes.  The function resctrl_arch_mbm_cntr_assign_configure() will be called
> from resctrl_online_cpu().
> 
> Does it make sense?  Any other idea?

-- 
Thanks
Babu Moger

