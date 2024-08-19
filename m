Return-Path: <linux-kernel+bounces-291537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C972A9563CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8189B20F58
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE421547E6;
	Mon, 19 Aug 2024 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l7ab2XEz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7A13D243
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724049717; cv=fail; b=GvjGpUb5o767Sx80i9hGiRQM1VQzdJkZb0qJqdFy7XaxKUfTdFxMy5DlAMyPjtLjIj6QUtsfmcfqbM3dpeh71HJhpCBtBB2jk5KKQu2L8neOrfQdPL3uGMWN+5fH4np72g+1QQ32XwyWDyVUbOkww7CG5//zao4DCyLBlPsq3bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724049717; c=relaxed/simple;
	bh=lvKRuJ/ouWDicmZb4EY0u5JsmypmWnEcriPd3+nTRmQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhIXAKFQ3ptjYm+bU97Y9G3Anq47bRoainIlnpftXdAx/Vt5SFYyZoKgt/ASid5yCeaeKfIEMYFtuR432MDCdVoeXdlPVYTE5885WUJLIe7+i/KQ6R9PZP2XGUvalP+TbnrlZTKjlqvcbCJGtC8DYCnJj3WlUFOozsE2ZMRz1PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l7ab2XEz; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iao3iKcQ9qakqMeF9CAZvoN67NkohLIURfE/KdEs6ql/BB0HeZEVxvY58wLHrDeKOjeNoHWJ6TKIsgckyllEaTRV17oVL5//w05cpM3bTnSG3Oe/2j1PEzqQzxKqo+A3molwdGJdJHjzOHdMioqoJ/crjIf5REaNaiSe/Akqme9mhQsICKfdsVYDn/eIVQ1etUoDFFxotXlFhTCJP2illi+fSsRkIQCexd0TlvwybUXg/Ca2YEoGh5E6eCJFvclui41mcUrmAkMkEUH27FNCfM6IuvNM9lb1ZHPyUpWQ7FRR3IRUUBX0dFzKXTEZXHCnN5l+zGMsqD/3Udwm1uaOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGZvXLHeVGmrEWkAk3H4PsYijMGplQzm+gbrdu+erlA=;
 b=gTpHDsXN6/6tFOM1o56tehDE0WkwBtszI4VvQcDCcAv8pWT4MVF6cES6NSrYgDSYxbfiyFf/nJwZ9D0eM8jcXRcdckhCy6uNN5yLoBhlifscUWQr0+VdI1PTK+5WkOeKZqCnB2xPIuhIDeceOdU2flqP3QAeRVQeXMiB791UJoCBWvN45+kNUIuLdN7TTIN9EUEDNltcCSrwy0yDYD2EzTcf0ryxTMabwTU34WpDJ9UXZ/1Wbqn+o0YUbcihv85d0d5zUYCyoRrPETU9kQkf8r646+6wf0qLZNZuf0gEoUFmxLorcidJjtfnoAmwwx5tP8mWtmh8HcOqS7X6vMjciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGZvXLHeVGmrEWkAk3H4PsYijMGplQzm+gbrdu+erlA=;
 b=l7ab2XEzacgHGGeHGZadYWAiqR75oP6kZucAUD9vcH0Y4YMHASohLxLnRDRczvQghMQFNZsT/aVTa4+xD2oIQmBJn+v0bCoqLLbP01/9einggB2+iC1bdhsbhb6qDfTDPPkPhnjGEdFEIIszOqoCpsYSwTTxx9Lp0xf8pIcTahs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 06:41:53 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:41:53 +0000
Message-ID: <9b8f3c29-3404-4db4-80cf-8fd1b5d018c8@amd.com>
Date: Mon, 19 Aug 2024 12:11:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO
 mode
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
 <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
 <94e789ab-2e64-4a6e-804f-b5e7b2a952cb@amd.com>
 <0ae18e57-ef79-4fd8-9e9a-4c57b480b267@linux.intel.com>
 <d0ca0a49-311e-4af3-95df-f7c6f85e184f@amd.com>
In-Reply-To: <d0ca0a49-311e-4af3-95df-f7c6f85e184f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 78199f69-695c-49ff-72cd-08dcc01a02d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHZVQ2laQ0VZQTB3cmZHTlpIcGgxVktEd0p6RC80Ull1T3ZTKzl1OGYzWUpW?=
 =?utf-8?B?NWRHbWROWnV6Mll2ckt6N2NqU3RUcS9oWmZXZ0VuL2t1YWNVOThGcTVJc25Y?=
 =?utf-8?B?S3hnazBkdEtnWDJEZkZLS2ZOa3JlZi9takFhNG5zYzRpMkthOERDVU56eUh3?=
 =?utf-8?B?YXpPVGVXQkgxbE1ybGp5TUJDVE1RMWxZVVptcC9rODZXTjR6QjV3cTBIeExM?=
 =?utf-8?B?RGpxcWphNkdnTTVLQVR3WWkwa1FMQ1ArNmVMSU1yWVB6ZlRPSERpODdWZm14?=
 =?utf-8?B?eDdRUFhZQW52QkxJd3lvaDhzcXplRXgzcXdPTlhmWGx4SnVVenNhemwzK1pP?=
 =?utf-8?B?NUtjZDc4R1lzL1dwQndPaEdKUzduWWVQaHNSUGdZK0QrQ1FLeXA5d2N1ckNx?=
 =?utf-8?B?MmRZL1AzMkI0YmhoVFJ6dExwZ0FlNk9JZDFZNHdrQ0N5SEkzMXpndGNndmpO?=
 =?utf-8?B?MmxLQ0Jaa2JSODdSS2FDbW81Qk55Y2pDZjJnTjJCVHI1ZTlDb0o5b2REeUpI?=
 =?utf-8?B?V2ZJek1LVHNyV3lsUk1jc3Z1QS9SWExLN0c0WjRUd0lSYzErL0tEQldUY0dX?=
 =?utf-8?B?ZkErUTJXZnpWZUM2OTNmUUoxck02MEFGNEMzZWRsUVp5d245MWM3Wko0cUVI?=
 =?utf-8?B?V1BuUGR0K0cyWk54bzBXWkhwZ3B4c0ZmdVBXaXByTEVSUC9WUVkzd0lndUFw?=
 =?utf-8?B?U216UkxITGhtMlZ6ZFFoUEZTMytKd29CQWhEWWovYnVUcVVlYWxRdHZ6cEVF?=
 =?utf-8?B?dFNSU1RrQ3FZL0h5bjJPN1B5eVprUkR5dDZ5ckRWdFh0YmI1L1JRZ3Y4ZDlj?=
 =?utf-8?B?VHNJbGQ3aVVYTU54aUwrTUFXZm1BRGZQMi9STC9mendnT1YwUU84ZTVLNXhk?=
 =?utf-8?B?YkNIdHBVY3JjcjVES2ZLSTM5UnQ4L1RURzF2NWlIOFpGbm51Rkowa0FHeXVl?=
 =?utf-8?B?blNtTE1TczRrRDVlZUhRKzEvK2E2M3FkZ2FDZUZuVFN1MnFGQnBmQnMzSXJx?=
 =?utf-8?B?WjFoSWk4ZG1iR2c3ZU4wRStITThvVWhkVW4wZ3ErWSs3Q2dLRm91MndLVkZR?=
 =?utf-8?B?VTFIbTNWQi9aTW9yOU9vVnA5a0NpYm50cGRsU05hc3MyRHJ4emNQdm5lUjJI?=
 =?utf-8?B?ckFjeTdiMnNucklCSHVDNWZJdEUzRkgrNklZbVVpNDZvamYxWmlDbW56OW1O?=
 =?utf-8?B?UTR0V20vM29oOE56YkNjdmY0R3ZWNjlwRzRsTi9hSEprU0YzRHVRdUVjRFcz?=
 =?utf-8?B?NldIMTFlazgvaG9RWnd3ci9BVnRPWXZNRUFrRTJCZXBPSTZxT2E4Nmc4bmFJ?=
 =?utf-8?B?UEVzSmx4ZlJpbDZOSXFpWWFicXpyck1TanBhOUtEdS80a2k5eEVtN0lKakVi?=
 =?utf-8?B?MjBOeWpOVE43YjBzb1M3RldqL0VITGIrVHdOUWhzNEtsZ2dCZWpNNFlMWSsr?=
 =?utf-8?B?WlZIc2JqZDN2K0lWUzdMVFcvQjN4ZytkWXU3MjJGcmducDRDZE9Wa2hDSlpu?=
 =?utf-8?B?Ly95S3FFUVM2bUk0djF6NDlXalVnWlpXWjRXTDRzY3pqVTRrVDB0VTRNZ0Zx?=
 =?utf-8?B?MDliRUNlekYwTm5hcXBxY01jQzh6emFyTC91WVNGOFlIS3Fub05nTkx5b3NS?=
 =?utf-8?B?MW9WVURnU3NMaHlRWEo5bXhaU0pPQlI2bElpZ09EM2Vxb2Zsb014YUFNOUtG?=
 =?utf-8?B?T0c4NlJLSXlNY0dROWNvWjdYckRWc3dLSlFXL3M5OHhHbC9FTyt5Z0xXSkZG?=
 =?utf-8?B?aWtCdEF6ZHNqRlNGa0F1dWZvS0RURlFId240Mk4vZ3N5Y3RaZVVrR1ZpQnl0?=
 =?utf-8?B?UzRCUmg0ZW9RMCtBeW1Ldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXpNRlBNZW5FdWRaOURrZlBVOGlIa0JJa2VMVk5LaUxTZUlISEhkeC9kRm1L?=
 =?utf-8?B?WHdVcUdsdXZWUFJDWHZGZHBBeDlGWHUzM3FnSVpCUVFyS3pOaHd2U1FmSEl5?=
 =?utf-8?B?dnJOQUx1QWE4R1dpMlpsWTlBZzFoUlVEeDQ2bjJCK2F1cW5PT3JNT00zSlIx?=
 =?utf-8?B?cDhIa2YxWENnZnBrQU9lekgwakltQ0VZZS85OE11S3NkZGdNc1JQWFRZQld1?=
 =?utf-8?B?ZXdFYksxcHd0YnZ6Z1I0WnRsalphaVI1MDloa3FCc1F3WXI4SXkzd1gwZkNB?=
 =?utf-8?B?L0pYcDNkNGhOVmdiL3VMRDFQZ1dnYXhYdnk2LzVKL09hbk1OQlp4cytjR2ps?=
 =?utf-8?B?Q29XTUg0c0o4dGJhT0lWcDRlTmZ3cnVia3FVTzd6OG1JZ3lBTGtiMFVDSmZl?=
 =?utf-8?B?S090djBvM1RYVFNOMVg4M1dFUXA4SXI0QWRiZ2dCT0IwUnA2QVlOT293VkVs?=
 =?utf-8?B?SjEzeENUSTJobDJ5eHZ4cC9zYldPd0owM21zczFDbzVEdXd4R2hGdTUwRWdp?=
 =?utf-8?B?SW1zd3ZNTkhIWkc0bFJXaHpkOWtJaGdZNC9YVng1ZDJoZVpGRCsxdGZJMno5?=
 =?utf-8?B?TDJjd1FUbGYwd0RybGNNR1h5cmYybmRXRkxVcTBlek1zQU85UkJuN2FkN29J?=
 =?utf-8?B?aHV1NGswMHprK0V1c3BmN2lodXpNbWJNcnZ6a25od05WVWVxbHhFTnhYNi9y?=
 =?utf-8?B?ZitNU3NJL3AzUjEwR210aDZralRjUDNjVytHZUFGSC8yb29oL3crYzEyL2FO?=
 =?utf-8?B?TDF5Z3o4ZjFEMk5rYlR4SklWL3l3dGErUDExektIWjlOWkE1c2E0N0VVUVNU?=
 =?utf-8?B?bS9udkdDRXliV2VsczRWSnRVdWxKb0k3UjVmTENlOVljTERVYWtDalc2Zm1V?=
 =?utf-8?B?NlkyL09YQmh0bnRxRmtMSVZyR2xZMlc1UU56MUREejRmejFjMk81UHROUFRi?=
 =?utf-8?B?SXR6QmM1cDdiT2x4VWI1WnVYVUdNdURuVTZEdk5TWnhZamVPdE9iZVlQaTJu?=
 =?utf-8?B?ckQ1ZHgzMm1TNXF5a241b2dZQ1JKOHZUQ1VLdUgyOC90YzgxMWtvRmljYUpT?=
 =?utf-8?B?YlhaRUpkRXIxZjh3MkorRDlTUURKUHU4Q1FRV2RobnM5VGNzYkpDM0xUOTBJ?=
 =?utf-8?B?dStud1VpREJGeHFuS0NsTzczNEpvc1JYWFNSaWZ0cHVNQ0RxaG14ZG15RzN2?=
 =?utf-8?B?cnJ4bzFVUzRlajNWOFZhNURxalUrQjZaV3RCUEpyUjBSbWlYTW5VUSsrS3pu?=
 =?utf-8?B?cGdVUGVjbmEybk0yUEs5OGwyN21GK296NGZnZnBOUXYwelBPaHIvU1o2MHZF?=
 =?utf-8?B?MXpHRXh5MFZvVzlYZkV4NlI2YTE4MHk2T1pxYnp3cm5ObTdZdjRrM0RyQmtZ?=
 =?utf-8?B?TTBKbE5qL2NFaEFJdzR5d3h2UGFLRHRxUU4zYmZrYjVndDRrSTlKQkNCOTZX?=
 =?utf-8?B?dkdodmxBS1JPbnhSbWd1a01HcUIyeTJNY1lYWVliUjRFZitQL1JRK2tYVGR1?=
 =?utf-8?B?M0lva1RMa3RBY25BTFh6TWFPanIzdnhMNnVsRWl5R0dER0ZmRWRxVDR6eWtl?=
 =?utf-8?B?TjVUclVXVHJLSnRHRUlkV2lFeTRLeHhwMkVjOXgyRXNvekFCZ3RnR1MrZ2hv?=
 =?utf-8?B?YnV1WXZTTDg1MUVmQUtDLytiS1N1endhWXNVS2VDcHhzTTVZYWZNa3lWSkZR?=
 =?utf-8?B?NWZUbDN1VFBzSlRFR2NCZFN3ZFRzeUo1RnlwOTdZREo5Wk15YytNTVRqRVhZ?=
 =?utf-8?B?ZkgwOG1IaDlpZmdoQlllbldvK3V5QmRqdWZScTRsU0VaakFvaFZpN2RNZHhD?=
 =?utf-8?B?MitNYXhiUlJ0OXkvZzFENmpYQWFXc3d1SjZKUE9ZWXNSd0dZZVo5cFNuYU5R?=
 =?utf-8?B?RVZudnhpY1NoMHNuaStUMzlyNWE1K1NFR0I2b2wweG5UVGZhdjdGWTVtamlV?=
 =?utf-8?B?bG1iTk1DQmNPWFZqeTJHbThOTWlXdG9vbXh5RzZya1UybWJ3ZDJlUGJrQU9W?=
 =?utf-8?B?Qm1jVmhsbThsa29ZQncySGVWRkgyREFMdWVxT1JIelQza3gwOHRoMHgzeGhL?=
 =?utf-8?B?VHNBeUQzaGlEVjJHbWdvSVVWMy9PZWJJS3puaXdzeTlrejJkNjU3N3JZRlpq?=
 =?utf-8?Q?88Awy24qen0tRBTyX2VeAKZRY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78199f69-695c-49ff-72cd-08dcc01a02d6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 06:41:53.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfRM6oG0nJGRfVn6pALYzENsjWAES3Rb5/uGNF1MBFFMJWm8BH7NZ3vre4LOhi7FN/zYUaHqrCGEUsj1awhjTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065



On 8/12/2024 15:02, Shyam Sundar S K wrote:
> Hi,
> 
> On 8/12/2024 14:47, Jarkko Nikula wrote:
>> Hi
>>
>> On 8/9/24 6:44 PM, Shyam Sundar S K wrote:
>>>> I was thinking these quirks can be passed as driver_data more cleanly
>>>> and be specific only to affected HW if AMD HW would have an unique
>>>> ACPI ID for each HW version.
>>>>
>>>> Above X86_VENDOR_AMD might be too generic if and when quirks are fixed
>>>> in the future HW :-)
>>>>
>>>> So something like:
>>>>
>>>> static const struct acpi_device_id i3c_hci_acpi_match[] = {
>>>>      {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
>>>> HCI_QUIRK_RESP_BUF_THLD},
>>>>      {}
>>>> };
>>>>
>>>> and set them in the i3c_hci_probe() as:
>>>>
>>>> hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
>>>
>>> Nice idea. But only problem is that MSFT wants to have the same ACPI
>>> ID present in the specification.
>>>
>>> I have replied to Andy on patch 1/6. Can you please put your remarks
>>> there?
>>>
>> Well this is implementation detail later in the series and I found it
>> better to focus ACPI ID discussion in 1/6.
>>
>>> Yeah, agreed that having X86_VENDOR_AMD is too generic, but felt its
>>> good to have additional checks only after the HW is fixed, rather than
>>> being speculative now.. :-)
>>>
>>> What would you advise?
>>> Most probably there will be future HW with either exactly same set of 
>> quirks, reduced quirks or new quirks and X86_VENDOR_AMD test will work
>> only with the first case :-)
> 
> I can add an additional check with the CPU ID and distinguish them(so
> the quirk gets applied to the affected HW versions) and just not
> restrict to X86_VENDOR_AMD, would that be fine with you?
> 
> OTOH, Since these are quirks (where its a broken hardware problems)
> and the idea you suggested is related to driver data (where driver
> data is meant to store private information about the device)
> 
> static const struct acpi_device_id i3c_hci_acpi_match[] = {
>      {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
> HCI_QUIRK_RESP_BUF_THLD},
>      {}
> };
> 
> does that not conflict? quirk vs driver data?
> 
> I am OK to implement it the way you prefer :-)

Jarkko, any feedback on this?

Thanks,
Shyam

> 
> Thanks,
> Shyam
> 
> 
> 

