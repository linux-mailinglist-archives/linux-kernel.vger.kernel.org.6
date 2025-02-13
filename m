Return-Path: <linux-kernel+bounces-512435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B74A33944
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6387A237C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2183B20AF9F;
	Thu, 13 Feb 2025 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TF5u4qLi"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7920A5CE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433191; cv=fail; b=fOpJV1Z2S7rPh4If7caPHPSLya7O27M6Br3f5K8huJ4S9FBkN1lSWX8caBRAGuQlJLuD3TnhbWtRikOeZDv3QnlLu6ehnjRGdY+vS93Wb6P9lOozPtHHVKiZMovorGNxAE49rDvAgXwIbW8n9uy/HBEJGzrZme+8bOCEjAKeegA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433191; c=relaxed/simple;
	bh=OYUgjSygunvlNOt4qkZusQueYGSh8ayk7G/mys/Ie7s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l8dKPBNyIaA8Cwycx0RwTUrtHuuRZlSwGiZ9jkVUegTydPEbRwI41cu374PJwIK5OoJW6NDfwERjpB/g2LuSRm0xbX0eeDEQPxiPY1XCS1JAmv4PckonQd3OCgFVol8MkFvcSdRsaX/vf6GVfC7BSA7OwAGJ7JRrqSxnwrApyeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TF5u4qLi; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR5d8aMaoopVhpWpHQgJtu+Q3KRPA8UkmPLSuurxjPRb6HVxUeprmI9QITu0Tmd9vikX0bnUB3obGQ5ACGovXvdlH3tsQe+36fpkvd+SMvt5n56X6AzUyW/sGem33NKVhw8EPMUO9P/ohu1WSV/76EQ6a4z+3sfHxX6ELCFzbXN813fxFrpy5mJbJGgcdXrUXL3xZ0pYcWepa7pIXyyMjCgXnqOAvBJOVIORq2eCrGZSUfGncurPN8VQc/9To7AsVSfnzkg/rO7SDL957I97DiMhreY1X4EVQNbaazJTPdKTtp2rubQVA/G1JvkUC/pfS4/lsfEXW3zae+cMjCQMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3V/OkZIYDUbSgAkGyEC6mH7vpoNAcgP6E13DUvX+hI=;
 b=td5blAgJrNmJW+OP7LZ9t6P3VTJvQ5nHWfAV1T8bpJ15SD8mu/Ao8CnJ4NK7hMdJJB+VTNXrKnpgjATpgYt4zjdbABN7lGzyhmuYw8Xg0LwEte0ak3y/OQV4LTQAkBVa7AD8ZDSh/4iuD+JooEl5Gbzz/Xad80Tw592+Wz8Rg4ptjiWbnTiBh15jW88Q6l3CZKNqgFjPuDPVH2gXTU+qj04utQhnMmk/U2Y0Q12Tqt9ezVGKm9BAt0QQcqTW70q0v7/9mYFtJ/TreQxSBOZ7KiiQQhpDcuRnb4d3vS1DI1LKqSrno/DmSb/ONVSL21oCNp2xiCkog0kArxsq2i33Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3V/OkZIYDUbSgAkGyEC6mH7vpoNAcgP6E13DUvX+hI=;
 b=TF5u4qLiui9mEAME1D7z9vNxezGesNH0km+2iko1ww1Psxkf+pWfgwIL+F26VKt8bsCAFHoc45KJ2VpkBqFaD7NEu/yuhn03ks8XgQOy7+IGyLwivg4CtWvMd1I8J1c7GtZ1hPtghDqUSolo18yKjV9Zr1CWv7Td9hXMitCh9S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 07:53:05 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 07:53:05 +0000
Message-ID: <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>
Date: Thu, 13 Feb 2025 13:22:55 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
 <20250212124945.GH19118@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20250212124945.GH19118@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 231c5c97-335d-4c92-b2a5-08dd4c037287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTcrUnRFdE9WTlZBN2xDYnZEMlIvdkJaZ09MR0g4U2Y3c2txbzdWZmlLQU9q?=
 =?utf-8?B?cnp2SkNyK3hSZEVyNWp0ODdnS0w3eFpZKzVZS3hjMlVFNU1hc3ZtOUlGS1lo?=
 =?utf-8?B?UnVKRUErRzZhcEJUZHhaR1VjbFNwakZxK05qQ05uc1Q4N0NZUnB3K0VpM0NF?=
 =?utf-8?B?UnIrSTQzUkFTZFhzdzVSZHg2eEh2RkFUekdBM2hIUUtUQld3R2pFQ3R5R0lo?=
 =?utf-8?B?dHl6MmVDN1h4UEh6bklETHlPUVVDa1c1OVdTUTV2QlBiTnViQ0FxU2JUY0NS?=
 =?utf-8?B?YkZrMUtIVmZoS0luY1dCT0EzNDhta1J5MVhBZkZZYWpDSUZXcUFIeXM4MGhh?=
 =?utf-8?B?TG5Za2tZTkFBVnR0YWtXUnEyTWVKc25qbkFST1RlSFB4b0NlSEVyNHVmWmJ2?=
 =?utf-8?B?K1NrUGkrT2pKMDFtTFViSDdJOUduZEV5bml5anBGNXdlTnV4MG5KUjBKU1hv?=
 =?utf-8?B?Q01uU3lhU1FUWVBRS05DRjdqVHhRQXNpbW1xNEdKSDM4alNXOGhuUXZJMldx?=
 =?utf-8?B?enM4Z051SVNrNks2dml0MDQxdUxVNGp3VWFGaUQzK3Y1UjlieHVqd21LTUpj?=
 =?utf-8?B?bzVoeXhSK1QwQ2Z5ejNFTnEybGtNdEM3UXZHYStiaVBnN0lpaGRRL1ZrV1hE?=
 =?utf-8?B?WFh4Y1RpL2JYYzEvTXMrekxCVExETjh3N1VUdmQzY214a0JJS1hmUzlodytC?=
 =?utf-8?B?dDR0ZzBQSjJYVW1hcmF5eDVkYTliWmc0R2E5OFBseW1lWlA2SW9EWTZJUzFq?=
 =?utf-8?B?K1BUbzNTVWtOOFlTaHBSdkZxK0R3SWRIRTA1bmR6blIxWFZoRWFVY3BWOXRO?=
 =?utf-8?B?ck5ld3V2dCtyOUdDWXVPR2xYbCs2WkgxQjBMUXZWVVNYS2Y1NzJjVncwQ3hW?=
 =?utf-8?B?VVZvTlFtekM1cjNKNTZzZFl1eElKNElKQmVFcUxxbzFvcldxbXJQcnAwTitQ?=
 =?utf-8?B?amZPZTBKUi9SQjgxbk5Ca1dKb3NpWmNjSzBveiswZnpnOU9BYVpock1VS0Jl?=
 =?utf-8?B?ZnVjM2d5NUhOTW5HYWVYRGMycTBURzN6NmxpcUJrN0svQUNVL1pkOGtYbkZZ?=
 =?utf-8?B?OHJVUmFGU2R3Q0pUaXlvdUlVV1VFYTVJVlZER0NCZzFPNEF3OUV4ajZQRjlI?=
 =?utf-8?B?TXVSUkRDcnV4dXhCY0o4YUt1dG5YOHFDN3lwTVNMQUlwYXFlazMzODk2N3J0?=
 =?utf-8?B?UUZZYTA3YjZGZGczWEp4dDhmeW05ODR5cEtnZlFLUUlXK1JUcE9OdzJ3Vnh6?=
 =?utf-8?B?N2U2c3gwYVBZdWhZNGtQbWQrRmhGUGJZSmM0Mk16T2hVV2o5VmdWbFpPZUdC?=
 =?utf-8?B?b0RlUkR3bER0YWdmeDZrRERwTEQ1S0ZhU1dvdWw1b0x3Vm9SZFc3VTRzOGlD?=
 =?utf-8?B?bE1xeEFrQmticDYzSGZOY1AvakxCTE5lUnpFNUt3TXpGamlhVXhpZnFRcm4v?=
 =?utf-8?B?OW42b1g1ZkN4OG9JcDRjaHpEWGJHZWFnc2M1R25EK1hnbVdGMFROZ0FyRXl4?=
 =?utf-8?B?M1hTTG5aVkdHOVhuMVk3YkNwTlFHRlpNNnJBRlRVU241eDZNVDZ6SXRCRnRz?=
 =?utf-8?B?ZUlGYjNnYjRwMzd1N3R1azZZb24zUENkNy9PbUl1b3RDd2dqVFpMNHh4OGZB?=
 =?utf-8?B?UHoxRUZ1cTJ2VVAwcjZscWFNck5JZUJ3YllaU3FBVFBRMlErV1ZhdEdYZmNw?=
 =?utf-8?B?ZTA1bUhkVTA2bTJYUG9NOW5mNkpWck45ZVVYUXhhdUozZ2UrdVQ2amxNRzE0?=
 =?utf-8?B?V0loVHl3NGZ6bHdBaHVMWGhIT25TWEN3amMzcW4rQjJXakQ1Z2MzR0VsVVhE?=
 =?utf-8?B?VlNyL3NEdXZDbkZWNUJVcmMzQkQrRHk0dm5GeERFcGVVVHovdnhadkI4UXFy?=
 =?utf-8?Q?NbdmgVnNhTvVn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGFBczJKWUNmY2k3VW5yS29IWWdLQ20vZytyckIyTnpOSldQSy9JMTdyMmNM?=
 =?utf-8?B?RTd4N3ljRkVmaDdVTitFVldtTGZUZDVOQVFpQ0NzZGVYL0ZiYXEyNzdmSGZ6?=
 =?utf-8?B?V1JPc3MxblhWZTVxalIxbjFXb29ZbmdiN1F0akNZbVZrc2RFWWtiL2taVnQ4?=
 =?utf-8?B?ekhwMWFOSHl3a1FEbCtnVys2NHZiRU1NS2hnakZWbWdiVndqU3orZ3lxMFQ2?=
 =?utf-8?B?Tk1Ba1BuUjFRK3hDd0dtUnJGeG5oVEdNZnBPMzJuUUJ5QjVFUVhBTkJJT1pI?=
 =?utf-8?B?bWhLZGxtWkZCbldZaDdFc2p0SVZoZmdYM3laRkx3Q1l2VjZLd082VXBpTWtn?=
 =?utf-8?B?cUVNN2ZyQStkMXNiVDRBSklHUlZPcTlhUFhSeTNhVFlhQXBlMDB3eE5nZTFv?=
 =?utf-8?B?M09DQ29WSERvc2I1TTdLQnFYSzFEbTBUa1BSOGxEUTJkc3pGN0JieHh3ZjdZ?=
 =?utf-8?B?ZUxCOGZ1QldLbXpVaWdMcVk4blF6MlZLNERFL3pkbXFtODRWWWNHS1FzdVpX?=
 =?utf-8?B?TTZQOWpPQnoyK1pJMXA1RWY0dGc4a2dMVlNMUVlOYWJsZlVUR2w1R1R3c0da?=
 =?utf-8?B?VkJQSy9oMnpwRjRMTW1XemRFN2xicGhDZ1JwRTZyNVljRUNFRkw5K2YzanVY?=
 =?utf-8?B?TjRyQmdkcUY3MlVOS1NkanlSTnhyQWY0UEY0YlRZVklZby83L3pmMXpyNGQw?=
 =?utf-8?B?dFFIZitmdE9mWDA2WjNJUFNwT3Y3QnVZNzgyQjN2UU11eUoySTFwNXlmWi9B?=
 =?utf-8?B?NThVZjBrS3dEYjlyREhMY3lPSFErMXgyRTdqWGptSndja3FBYjcyb0luY2U1?=
 =?utf-8?B?MEZMK3VaSzlFM2c5b1N0aEdIOW5zdFNpQ0tvYUo4cVJGckN1RUs3Uy9pWE1B?=
 =?utf-8?B?Wm1qRFc3djBoZnN2cTZOVTg3QkFOaDJIMWtpVEpSNWJtSS84TGM3cnFadG4v?=
 =?utf-8?B?TTgxTW5JOE5DVnJBOE5SYTk2TmQ2dW9XZTlDckU5eTFVNzg4QklFMmlmeEhL?=
 =?utf-8?B?YnRPd1NGUWRlUjd4SXdvQWExaERGeEtRMmdCZFhQc1duSWNLSFBoOFM0Lzg0?=
 =?utf-8?B?Y05OK2xna2s2TXRJeWQ5cFVHQVVzZG9ZZy9kOHhtaVBZTUhaVDI2eHNDTlBS?=
 =?utf-8?B?OXhKakxLcVFLaTFOVW1oblh1T2JWQ2pwM2ZreUFsNEZPUEJJTVVLeUJkNHd6?=
 =?utf-8?B?RUZlT3RGK1ArazNqOFdHYk9rbjJLUmFSVyt3cjNIbXhQTm9oMGU0ZURaTG5Q?=
 =?utf-8?B?YkJHMUlXYWtaem52Tkc0MFlBVEhTb2tRM1hsUkM4NGxFcEU2ZnFhR3J2clBu?=
 =?utf-8?B?YWRpc1FYejhGUUJmNlVhc1pYdDhLY3N5MSs5NDdRaFhlWWNuT2tmcHVmT0d5?=
 =?utf-8?B?TGFNazZuM0pORWRnM0Jrck56OTVNdzltOXJkOHRvK2twRmtYQUczVkNRZEJz?=
 =?utf-8?B?QUwwQVdsdWM2d2t6RC9qZHdla3JQM1BiRVVjbjlOSmoyV1phL0drMkF4aFZU?=
 =?utf-8?B?WG1kVkljVUZnUVZ4NTJNVEZLR0VRYzlXR2xqbHBKOW9tYy9kVDZuVEZmdDlQ?=
 =?utf-8?B?OEM3bVpBRlBZQkFZcE5iV2lUQm9hVGNJTW5tSUxlL2poTndYcEl3SlZvdjUw?=
 =?utf-8?B?bGdhbWJISTJoQ29Ccnoxck9NdnhHWHJIb3FTeWhwTG8zUVkrVVF5Tk1Lbm1Z?=
 =?utf-8?B?ZHNYSy9PUVNnSU44SXVmYWMvYkxWVXQwb0VPSVB2MVo2M3g4bHJSRElCUEt4?=
 =?utf-8?B?cG8zS29yMEhsZk5kUnVxaTJTVkk5bFVieitTMXl0bFZsY2I0bjZwdnhWZ2J6?=
 =?utf-8?B?Z0w2akNUS2lKNWZrZVFXaUx6TEVoaEVHNnEyV1lZL1M4eTREakhVR3ovd2dG?=
 =?utf-8?B?VG5aN0ZiTjJER1A1MThhUEdiNEVCYXpuakRHSU82Q29wdnlYSE1wRERpNTB6?=
 =?utf-8?B?VkJ4NEtmeWtyczBDTi96WnlGSEZPam1JNG1MUEJSK0lxUThBR0t2NFhHSG1s?=
 =?utf-8?B?TlVwSXgwRXJGMkpMQk4xWHhGL25MdVlGOTFkVnFKSWF5dHJjTGEvM3R4NXBC?=
 =?utf-8?B?QUx2allMSzZXUDBObnlFd3ZBc0pHUDJaODFHYTZFeXlndndzMnlZelJ6Rng2?=
 =?utf-8?Q?aYkVMLjORe4ZIrTYtckZ002vd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231c5c97-335d-4c92-b2a5-08dd4c037287
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:53:05.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOks56PzYVtSH1NGaxKro3katSMk2Imq7YmVes3pJd+VtxmkRTwicLvUAxJqvlSf56uzGWIrxQ/iqL+zksNsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

> Does this work?
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2303,6 +2303,7 @@ static void perf_child_detach(struct per
>  
>  	sync_child_event(event);
>  	list_del_init(&event->child_list);
> +	event->parent = NULL;
>  }
>  
>  static bool is_orphaned_event(struct perf_event *event)

Apparently not, it ends up with:

  ------------[ cut here ]------------
  WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0
  Modules linked in: [...]
  CPU: 145 UID: 1002 PID: 5459 Comm: perf_fuzzer Kdump: loaded Not tainted 6.14.0-rc1-pmu-unregister+ #244
  Hardware name: AMD Corporation RUBY/RUBY, BIOS RRR1009C 07/21/2023
  RIP: 0010:event_function+0xd2/0xf0
  Code: [...]
  RSP: 0018:ffa000000647fac8 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: ff1100100d4b0ee0 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffa000000647faf0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: ffa000000647fbb8
  R13: 0000000000000000 R14: ff11000104cc9e00 R15: ff110001216fcec0
  FS:  000070acabcae740(0000) GS:ff1100100d480000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffff600000 CR3: 000000011d920005 CR4: 0000000000f71ff0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? show_regs+0x6c/0x80
   ? __warn+0x8d/0x150
   ? event_function+0xd2/0xf0
   ? report_bug+0x182/0x1b0
   ? handle_bug+0x6e/0xb0
   ? exc_invalid_op+0x18/0x80
   ? asm_exc_invalid_op+0x1b/0x20
   ? event_function+0xd2/0xf0
   ? event_function+0x3d/0xf0
   remote_function+0x4f/0x70
   ? __pfx_remote_function+0x10/0x10
   generic_exec_single+0x7f/0x160
   smp_call_function_single+0x110/0x160
   ? __pfx_remote_function+0x10/0x10
   ? ktime_get_ts64+0x49/0x150
   event_function_call+0x98/0x1d0
   ? __pfx___perf_event_disable+0x10/0x10
   ? __pfx___perf_event_disable+0x10/0x10
   ? __pfx_event_function+0x10/0x10
   ? __pfx__perf_event_disable+0x10/0x10
   _perf_event_disable+0x41/0x70
   perf_event_for_each_child+0x40/0x90
   ? __pfx__perf_event_disable+0x10/0x10
   _perf_ioctl+0xac/0xb00
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? place_entity+0xa7/0x170
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __x2apic_send_IPI_dest+0x32/0x50
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? x2apic_send_IPI+0x26/0x40
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? native_send_call_func_single_ipi+0x13/0x20
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __smp_call_single_queue+0xf7/0x180
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? generic_exec_single+0x38/0x160
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? smp_call_function_single_async+0x22/0x50
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? mutex_lock+0x12/0x50
   perf_ioctl+0x45/0x80
   __x64_sys_ioctl+0xa7/0xe0
   x64_sys_call+0x131e/0x2650
   do_syscall_64+0x7e/0x170
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? rcu_core+0x1d1/0x3a0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? rcu_core_si+0xe/0x20
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? handle_softirqs+0xe7/0x330
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? irqentry_exit_to_user_mode+0x43/0x250
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? irqentry_exit+0x43/0x50
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? sysvec_apic_timer_interrupt+0x4f/0xc0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x70acabb24ded
  Code: [...]
  RSP: 002b:00007fffb3dd4a40 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007fffb3dd6f28 RCX: 000070acabb24ded
  RDX: 0000000066f26a61 RSI: 0000000000002401 RDI: 0000000000000013
  RBP: 00007fffb3dd4a90 R08: 000070acabc03084 R09: 000070acabc030a0
  R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000001
  R13: 0000000000000000 R14: 00005e38a9ec5b60 R15: 000070acabd00000
   </TASK>
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:286 event_function+0xd6/0xf0
  Modules linked in: [...]
  CPU: 145 UID: 1002 PID: 5459 Comm: perf_fuzzer Kdump: loaded Tainted: G        W          6.14.0-rc1-pmu-unregister+ #244
  Tainted: [W]=WARN
  Hardware name: AMD Corporation RUBY/RUBY, BIOS RRR1009C 07/21/2023
  RIP: 0010:event_function+0xd6/0xf0
  Code: [...]
  RSP: 0018:ffa000000647fac8 EFLAGS: 00010086
  RAX: 0000000000000000 RBX: ff1100100d4b0ee0 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffa000000647faf0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: ffa000000647fbb8
  R13: 0000000000000000 R14: ff11000104cc9e00 R15: ff110001216fcec0
  FS:  000070acabcae740(0000) GS:ff1100100d480000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffff600000 CR3: 000000011d920005 CR4: 0000000000f71ff0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? show_regs+0x6c/0x80
   ? __warn+0x8d/0x150
   ? event_function+0xd6/0xf0
   ? report_bug+0x182/0x1b0
   ? handle_bug+0x6e/0xb0
   ? exc_invalid_op+0x18/0x80
   ? asm_exc_invalid_op+0x1b/0x20
   ? event_function+0xd6/0xf0
   ? event_function+0x3d/0xf0
   remote_function+0x4f/0x70
   ? __pfx_remote_function+0x10/0x10
   generic_exec_single+0x7f/0x160
   smp_call_function_single+0x110/0x160
   ? __pfx_remote_function+0x10/0x10
   ? ktime_get_ts64+0x49/0x150
   event_function_call+0x98/0x1d0
   ? __pfx___perf_event_disable+0x10/0x10
   ? __pfx___perf_event_disable+0x10/0x10
   ? __pfx_event_function+0x10/0x10
   ? __pfx__perf_event_disable+0x10/0x10
   _perf_event_disable+0x41/0x70
   perf_event_for_each_child+0x40/0x90
   ? __pfx__perf_event_disable+0x10/0x10
   _perf_ioctl+0xac/0xb00
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? place_entity+0xa7/0x170
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __x2apic_send_IPI_dest+0x32/0x50
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? x2apic_send_IPI+0x26/0x40
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? native_send_call_func_single_ipi+0x13/0x20
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __smp_call_single_queue+0xf7/0x180
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? generic_exec_single+0x38/0x160
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? smp_call_function_single_async+0x22/0x50
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? mutex_lock+0x12/0x50
   perf_ioctl+0x45/0x80
   __x64_sys_ioctl+0xa7/0xe0
   x64_sys_call+0x131e/0x2650
   do_syscall_64+0x7e/0x170
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? rcu_core+0x1d1/0x3a0
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? rcu_core_si+0xe/0x20
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? handle_softirqs+0xe7/0x330
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? irqentry_exit_to_user_mode+0x43/0x250
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? irqentry_exit+0x43/0x50
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? sysvec_apic_timer_interrupt+0x4f/0xc0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x70acabb24ded
  Code: [...]
  RSP: 002b:00007fffb3dd4a40 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007fffb3dd6f28 RCX: 000070acabb24ded
  RDX: 0000000066f26a61 RSI: 0000000000002401 RDI: 0000000000000013
  RBP: 00007fffb3dd4a90 R08: 000070acabc03084 R09: 000070acabc030a0
  R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000001
  R13: 0000000000000000 R14: 00005e38a9ec5b60 R15: 000070acabd00000
   </TASK>
  ---[ end trace 0000000000000000 ]---
  watchdog: BUG: soft lockup - CPU#88 stuck for 26s! [perf_fuzzer:5740]
  Modules linked in: [...]
  CPU: 88 UID: 1002 PID: 5740 Comm: perf_fuzzer Kdump: loaded Tainted: G        W          6.14.0-rc1-pmu-unregister+ #244
  Tainted: [W]=WARN
  Hardware name: AMD Corporation RUBY/RUBY, BIOS RRR1009C 07/21/2023
  RIP: 0010:smp_call_function_single+0x11f/0x160
  Code: [...]
  RSP: 0000:ffa0000004b57ba0 EFLAGS: 00000202
  RAX: 0000000000000000 RBX: ff11000153ad8000 RCX: 0000000000000000
  RDX: 0000000000000011 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffa0000004b57be8 R08: 0000000000000000 R09: ffa0000004b57c20
  R10: 0000000000000001 R11: ffffffff81621ef0 R12: ff11000104cc9e00
  R13: ffa0000004b57c08 R14: ff1100013732af40 R15: ff1100100b830ee0
  FS:  0000000000000000(0000) GS:ff1100100b800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00005e38a9ea8930 CR3: 0000000003440004 CR4: 0000000000f71ef0
  PKRU: 55555554
  Call Trace:
   <IRQ>
   ? show_regs+0x6c/0x80
   ? watchdog_timer_fn+0x22b/0x2d0
   ? __pfx_watchdog_timer_fn+0x10/0x10
   ? __hrtimer_run_queues+0x112/0x2a0
   ? clockevents_program_event+0xc1/0x150
   ? hrtimer_interrupt+0xfd/0x260
   ? __sysvec_apic_timer_interrupt+0x56/0x130
   ? sysvec_apic_timer_interrupt+0x93/0xc0
   </IRQ>
   <TASK>
   ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
   ? __pfx_remote_function+0x10/0x10
   ? smp_call_function_single+0x11f/0x160
   ? __pfx_remote_function+0x10/0x10
   ? event_function_call+0x115/0x1d0
   ? srso_alias_return_thunk+0x5/0xfbef5
   event_function_call+0x98/0x1d0
   ? __pfx___perf_remove_from_context+0x10/0x10
   ? __pfx___perf_remove_from_context+0x10/0x10
   ? __pfx_event_function+0x10/0x10
   perf_remove_from_context+0x46/0xa0
   perf_event_release_kernel+0x1f3/0x210
   perf_release+0x12/0x20
   __fput+0xed/0x2d0
   ____fput+0x15/0x20
   task_work_run+0x60/0xa0
   do_exit+0x317/0xb00
   ? srso_alias_return_thunk+0x5/0xfbef5
   do_group_exit+0x34/0x90
   get_signal+0x934/0x940
   arch_do_signal_or_restart+0x2f/0x250
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? event_function+0xa4/0xf0
   ? __pfx_remote_function+0x10/0x10
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? remote_function+0x4f/0x70
   ? srso_alias_return_thunk+0x5/0xfbef5
   irqentry_exit_to_user_mode+0x1e0/0x250
   irqentry_exit+0x43/0x50
   sysvec_reschedule_ipi+0x5d/0x100
   asm_sysvec_reschedule_ipi+0x1b/0x20
  RIP: 0033:0x5e38a9eb87dd
  Code: Unable to access opcode bytes at 0x5e38a9eb87b3.
  RSP: 002b:00007fffb3dd4ae8 EFLAGS: 00000202
  RAX: 0000000000001553 RBX: 00007fffb3dd6f28 RCX: 00000000000020da
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
  RBP: 00007fffb3dd4b00 R08: 0000000000000001 R09: 000070acabcae740
  R10: 000070acabd010b8 R11: 0000000000000246 R12: 0000000000000001
  R13: 0000000000000000 R14: 00005e38a9ec5b60 R15: 000070acabd00000
   </TASK>


Something like below instead? I haven't tested it thoroughly though.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d2b87a425e75..4e131b1c37ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13645,20 +13645,25 @@ perf_event_exit_event(struct perf_event *event,
 	unsigned long detach_flags = DETACH_EXIT;
 
 	if (parent_event) {
-		/*
-		 * Do not destroy the 'original' grouping; because of the
-		 * context switch optimization the original events could've
-		 * ended up in a random child task.
-		 *
-		 * If we were to destroy the original group, all group related
-		 * operations would cease to function properly after this
-		 * random child dies.
-		 *
-		 * Do destroy all inherited groups, we don't care about those
-		 * and being thorough is better.
-		 */
-		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
+		if (event->attach_state & PERF_ATTACH_CHILD) {
+			/*
+			 * Do not destroy the 'original' grouping; because of the
+			 * context switch optimization the original events could've
+			 * ended up in a random child task.
+			 *
+			 * If we were to destroy the original group, all group related
+			 * operations would cease to function properly after this
+			 * random child dies.
+			 *
+			 * Do destroy all inherited groups, we don't care about those
+			 * and being thorough is better.
+			 */
+			detach_flags |= DETACH_GROUP | DETACH_CHILD;
+		} else {
+			mutex_unlock(&parent_event->child_mutex);
+			parent_event = NULL;
+		}
 	}
 
 	if (revoke)
---

Thanks,
Ravi

