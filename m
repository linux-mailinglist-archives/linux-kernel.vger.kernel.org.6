Return-Path: <linux-kernel+bounces-385368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38D9B3640
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DE7B256D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30161DEFDC;
	Mon, 28 Oct 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uIWd53OB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218591DEFC0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132150; cv=fail; b=YHhumCJaxCMSsw7CE8YdtMMl0A7Bp4Clm0qnaIb/KJnuUlJT2htMd9lrjM5x7f/NVUTNm/b17Ao31mAS5ZF6gBlWmIycK+jZeXik6+pFjnTNjBeFVcTCMAZ2KPFLXih5AJh+7UcbMdqwGmXvXDMI2PXoiqs6EzK+kDXveoGF5fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132150; c=relaxed/simple;
	bh=vGg3EVYt5gqeLCp6Eg3Kr7I6ghNc7RTVDnflZc/a/ZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jOQZvSvjexPha0lCp1XgkmX/wi+6A+hrR3zoXf21rZ/CiS7dEriOSaOT++C+8mAnBJHdvHYRqMIIXrMQ14Kicj4MSbXHe4Tzv3BTeoKZNPU4EZi1SIcK60mAn6sB3SAUlK57rRNMyrPIhkwjNq70dD1KxxrJir68Ex/Y7eCW6R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uIWd53OB; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peXlUuPSMcYvxyk/ZmDCsDEi33xJTRTQrzYD0uLKMrN7gIuQ8gFzKvAo+msZNeurouX3179RWQEIVZlGQtyFAAE/txMOdKGOknEKP43FvLhY2JbAwVONR3ld+PaXOfmIH7QkySixmJB3J2hqN4lkv3OXwxgoMTGOYY0YNZfzQca86JR4yk985RKIvsD+5uontvGYwc+5JnBWVGMaOQTOo/sd6K/Hg+Y5toEgFSZIUVQ90Y7XIKkxnCN/dWIs9oAT5pS/05sTXIYh7r2vtDylx6xzMzKKGiS/oK2Ko9qOEsExFQg5gL60bEqzWeOqgFwBQSr0G1jF2seqEzzwudo7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUdL3W1p8XOQeyODttf9CsCNnjscSsasKglWjXokpNo=;
 b=nD39qJ+CjHCefzXWzw8YeyQ1BjrC5Pck89z3Xgvh6Y1P+tmvfTWHkkRJ2CVYyJGZUKCdt5T3MosZOv2+EVCsg8+jXbSUJ6HVUHGypP9/cv5npzqt8LJg94k2ErhKqJ3qFdH0f3IdEzs8IWJWzdolKR1xNI2En+B2aW1wgqqVMURJ1YlJhw1QKeVeAASTOCdTjMsXttVolzzBAHnMCxFjsAh9oNjeZt+JAuMu+N2diwR5w2npI/xSyF6tsUUJqfjOuSjVq9/NB08RfDNp/u5XAXdFSolZxTHXUcT7u+L6CzrejoijtX/AtXntRhDXaR5GR1k36c+KUF3HQCV3LBHuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUdL3W1p8XOQeyODttf9CsCNnjscSsasKglWjXokpNo=;
 b=uIWd53OBXEbSoYCbn2/T1i+6SaBku9Wwgp3jl2zkizAQKlIKTJ87evkOORLfA9MazB3R4jXlGKpkgOP33RyU0fNvIq5KlQpI0Bt0FJs5tEStd4iMb2rlm+6ZEXlQBSpFLBtvlMELXKAkgDRFvw80k34Md17YXcJv+VR9HlDLRAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 16:15:45 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 16:15:45 +0000
Message-ID: <c9ff351c-b802-9d26-c4d6-d94fb7ff3e1a@amd.com>
Date: Mon, 28 Oct 2024 11:15:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v13 2/3] x86/mm: refactor __set_clr_pte_enc()
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, dave.hansen@linux.intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc: hpa@zytor.com, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
 rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, ardb@kernel.org,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 jroedel@suse.de
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1722520012.git.ashish.kalra@amd.com>
 <5df4aa450447f28294d1c5a890e27b63ed4ded36.1722520012.git.ashish.kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <5df4aa450447f28294d1c5a890e27b63ed4ded36.1722520012.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:d3::13) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1973abb9-4495-4fc2-a61a-08dcf76bc6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2p3ZmRSM2orSW9DU0xFcTRsMk1JSkNlaXRBaGViTmU1RnZ4Ykc3NGlPSnNq?=
 =?utf-8?B?L0NWUFJxc0VOWnYvdXlFdkppemFocWZCeE9MSlBxZ2laS3dCR2lleVNqeUVM?=
 =?utf-8?B?T3hRVUtuTE56WGwwVnVqUjRRSzJ4SFN6ZTYvTXVNYzlBc2tvNmxtVzBGcUFq?=
 =?utf-8?B?Q3pPNVk5Ymg5RUxXWERaK3dZamxUTXVJTCtreFFQcjFUU1lKTEp0UG5BNWdT?=
 =?utf-8?B?MUdJa0IwcmZrOVdBNmc5YUtXbWVialpMWkdKQmJuRjRybGxWWWJGMVJ4K0sy?=
 =?utf-8?B?cUJwVEhCMTZ2NzA4dGd4OWUyaTdGa3ZkTEQwdWdOQ0lTeXdiK0JXUlNUKzRJ?=
 =?utf-8?B?WWZCV2xCaVJsTFBENmdzOFRpQVVDbTRMaHRJMDlIait3SEh5VHJaRTVFY1Uz?=
 =?utf-8?B?Ukh1VUpCRTBHbm0zM3FLZEtnanE1LzJJb1laS0FzdFFCSjJyVlhmUk1vN255?=
 =?utf-8?B?UWlHWng1c3lmYlZBV2E1bzBPc282TnM3UkhGcXpCN004d1R3QUdDQ1c4Y0l1?=
 =?utf-8?B?NEhHL09hRVFZT1FTVmdZZjlWRmhYYVQ5a0k3bnRNelE2UDlmc1JxaS9ZZitB?=
 =?utf-8?B?SC8yWU9vYnFmak5hRE96Z1ZnVmJTd3NLT3diWGtUL01BVHRPQXRHamRmcmZE?=
 =?utf-8?B?a0JmcHlzNCt1WFVoNWYrODlFeDFrdG0wQlJxc2ZYdUY3Yy84MDlPWndTWmVW?=
 =?utf-8?B?TUZvV01sVUM2QS9oUkFRVlhrd0trYnhhK0YxOHorUmJSMElDcGZrV2t5Sy93?=
 =?utf-8?B?eXdFNGlsRkVXTlNPZ0hOWWZYd2x2OHNjdk1haEZIalZZNmZ2R3JBNHRhbDJK?=
 =?utf-8?B?UmxTOUNmU0Y5QkdLUFc1MERqcWYyMjZld0ZpMGNvTThuNDJJWEljdWozRXds?=
 =?utf-8?B?L1VZbVBjRjY5N3ZLb3ZNd0JGT08rV2tiSkZTckFtc2p6RnZWMnFvQ010b1Rr?=
 =?utf-8?B?WDhMODVTdnlLS2t6YVA1WEFSZGVtOFFMVStvamE5aTZGU3UrczNXL2VSTmpZ?=
 =?utf-8?B?dDVFdFlncWtMWERkZEFMR1ZhV2o5MDZMSDZpVmdpTm93MUIwaFZZbGdxcFRj?=
 =?utf-8?B?akVBN2kzWmZQQysrWUpPbVVOVEdOcmNjSmlWa29wdFp2d2dwdWY1TGpPWGZU?=
 =?utf-8?B?K0FqTDFXNUdhUU41N3d1UzJsbmVRckdINXh2VW9KUzdpcU84NDVOYXZYbGdT?=
 =?utf-8?B?TjZpbGh1U0k0K3o3R3pOdE45RXFYa3lVYUZWQVlJd0RUL2lJcnQ5eTBQdHRU?=
 =?utf-8?B?QUJEaU4zVFFjZlRnOUZFVnh3Q2NzWmhJZnBzSlpVMGdMMENGKy93T0FyRFZM?=
 =?utf-8?B?aWMrN0NpK24vRXA2V05NdEtaZUQ1ZXJEZGZUS2dMRExMQmRmV2Z4dkVuS3Z2?=
 =?utf-8?B?aTJTUHZzdkk5RGZaOVdqZXhxbnFqMjNTeUt4WW9BeEZVUlNoL2E1cHdPZVpl?=
 =?utf-8?B?Tjk1UzVYVXp3NHdyYWU0MkxOTktMOFA0U25DUnZhM2dsRUJST0gyOUM5blg4?=
 =?utf-8?B?Sjlab2lkcDBUSEsydGlzUlhxeXFPSlVhb2lqemN3a0dhQndoL1VwNklLMTlm?=
 =?utf-8?B?MnpmS3BpQ1M5VGZ0ZUNvU0R2OGhyZXA1ZjVQdEs5eHN5VERiUzVTQW5ja0tK?=
 =?utf-8?B?UlNsWkd3Q3FPd2UrR0VTZVE4REo4SDV2OXJGY3BYM0NXenE1QThTajhVazlB?=
 =?utf-8?B?Y0RLTGpUR0NtTmtaZDJ6dm1FVk1hVzhLVHNyRUpZem5GY3A2aW1xTU5KZFRt?=
 =?utf-8?Q?UGsjJ/xHdjd2IPOOZ8E1/uF++1HcGPlFvJ1pwKd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhRcmVoOE9wdVNtQWR6MFp1UkRFTGY3MlExaUFkU1dzT2hNaGJQMGJlU2tx?=
 =?utf-8?B?U0gwbEl1Q0tLd0Y5emF4WE5leG1ZREQ4R0gyd2E0cGxBbER6UDFBUGhEUW5l?=
 =?utf-8?B?dEpjVGVkSUo5VTBTM3JFbit1Y3BZZ1VVZzd0NXJrZ0xxNGsrdGdMQWRwa0FQ?=
 =?utf-8?B?azlxTy9sMkNYOTI2U0JPV1BlWE9tejRmakRCV2xvZHhNNzlQTDQ2NkgrSmt4?=
 =?utf-8?B?MytCK0FXaUNXVHlyZkJRSG5pZFRnMFh4WVFZK2Iyclk5RUR6emF6L2dIaUsv?=
 =?utf-8?B?K2xkbCtTNlBudXdlN2dUK0h5VDhSZUVtMU1yQ2QvVlgzeTlQeUFjMXpuelNn?=
 =?utf-8?B?NHNKaWVoOTZxU2Jzcnc4bC9Pbk5mdGNSbHZPK1F0NGdOYTRiQWlsYnpqbjhZ?=
 =?utf-8?B?Qmt2c1ZTUXo4Z2tVMEp6VHM4SWF5Ky9PbHJVekc2Q1ViZHNUL1Y5NzRQYThm?=
 =?utf-8?B?NDU5Nk1iQnBCZTZ4am9JRW13N2Z2UnU2b2l1c3pBZXFyZFI1VFFOdkdFazhI?=
 =?utf-8?B?aWRHU1poMlBzQTNXRlc1cUVVZ0FpbWNNUCt0azk0MGpxci85dWF0Qk9zd3d0?=
 =?utf-8?B?VFIyZXByTmRYdEZEWGVlZElrZC9hWDc1YlBtbm5rSlRJeFI2aGp5LzVqUVlp?=
 =?utf-8?B?dHZ6M01WSlJKVE9JYms4OGlEWnMrNnhZR2ZobUxiUkxrS0FOL0R4WkU2TjZX?=
 =?utf-8?B?dmFwRFhFendabnJUYVJTTmJmT3hnazdMZWpUZGp2Yy9aMTVkSVRkbExXU0dL?=
 =?utf-8?B?R2ZISnE1QjR1VjR1VHI0a3h2NlFBNE5KM05PT0dQSlpwR2VqQS8zNURkSmlx?=
 =?utf-8?B?UWFnOUFEQk0xWStGbXc1UDVIeGNWNTFrK1BHZTNWQ1dISjFtSGVCYU5razc5?=
 =?utf-8?B?N1FTd3hlcCtpMFBodlRUK3QwakVRWlJnYjdORGJBNHpDM2Zqc2p6MzY4aFM4?=
 =?utf-8?B?T0dkN1BRZnI1Q21FcDk2V2pRSFRIaSt3azNZaWhRVHoyR1g2ZDFyUVNHR2dY?=
 =?utf-8?B?VlRsVVNVTWRYRllJV3NSOW5EOWVOUUt5a3dNakl4dUE5SEFMeVRyVHg0QXlS?=
 =?utf-8?B?Q2pSSEhua0xET0NHaDFuODlXdlpMTkdQb3RTMm9FaUpFbFpFM1dDUGlXZ3Zu?=
 =?utf-8?B?OUN0K054SzVDYm44SURFTHdvMFgyalp2UndLQUlKWmVRRDZTTFdmMEZST2pj?=
 =?utf-8?B?c1NUOWRZYlBsc0pBaDUyL0gyMkZBdU15a2xrYVd4ODE4azFTNnRrTVNtNkpt?=
 =?utf-8?B?VGc2c1V0TzJvZ05YeTFmUko2RGxES2RkRDFVS0NxbkJqZit5andqS0dlRW8z?=
 =?utf-8?B?LzYrczVvdXlabTJZdVZQeWhUSURpRUx1VkxuNWVaVWw0dVN5dFN6c0dOclEw?=
 =?utf-8?B?eG51ckxzTklyZ1dxelZBakVtTUhQUzFKUWxmbHkvWFFQU296VVduNHlYRTJP?=
 =?utf-8?B?QzFMVENyeXFXWUxES1ZzN2w2TGJ2akJ2ZFAyZlZBOWxiTDVaTkYrcUtvSzhj?=
 =?utf-8?B?T1NNRTB1TjFVK1g3amdVUWhUT01aVkNJOWY5THErOFNCSDFVRVg2Q3VCK0dE?=
 =?utf-8?B?Tlg4SzltSFRMengyU0h6QktTTHhMSGcyZXZNZ2NhUW4vVFU0TnkzZzhzOUFR?=
 =?utf-8?B?eVphNUpwaGlKUG5TSTdwZWk1VEk1SzY1RmFVcVJ3Y1ZRUGFZQ05zUUFlME5H?=
 =?utf-8?B?NXdhVlpUUks0dVZGOWJZU2dhZlNqbzhRS2lNeUd4cUJTd09vRkxyY3hPeG5a?=
 =?utf-8?B?MERhSXV0b2QxaFpBMmpvKzhabmhqUk5OSitQTWdCUW0vTFc4cmNGaERlQklY?=
 =?utf-8?B?bGx1US9jVFBPclFSTmc3SGswcUVycFVVUHo1cFBrZXNSZnZIa1BLZzR5T0RE?=
 =?utf-8?B?amFKVElQYngxcmh3bFZ4OXBjcjl6SDlKTFJCTW9lcEM5VnZQVkRkbjEvTTZt?=
 =?utf-8?B?SzEzOEVXcWlSTmlRamdUUEE3bnVjQm80bWdObHhUbjh6K1dqSS9tN3RHb2pB?=
 =?utf-8?B?REc1TTVHdUpQNHpuelRjMnVtYWFjZDIzMXd5WEVWUVJZS25odXVIMXFzc0F1?=
 =?utf-8?B?NUJpT3dBVGoxMTExZVNTd3ZkcVdPeTdJWXUxUWZISzh4eWxKM2E1RDFjZ2JJ?=
 =?utf-8?Q?UxDOf7/LbNiOPMXrB8fXedmTw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1973abb9-4495-4fc2-a61a-08dcf76bc6d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 16:15:45.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h65DBWHilWUtxpaW16rh54mM6pqE1z3fR7zY503srFqj8HdUlf1QWLIVawaWRC8d95fHnq1FKvZYc7dr3lnqsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

On 8/1/24 14:14, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Refactor __set_clr_pte_enc() and add two new helper functions to
> set/clear PTE C-bit from early SEV/SNP initialization code and
> later during shutdown/kexec especially when all CPUs are stopped
> and interrupts are disabled and set_memory_xx() interfaces can't
> be used.
> 
> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/include/asm/sev.h    | 20 ++++++++++
>  arch/x86/mm/mem_encrypt_amd.c | 75 +++++++++++++++++++++++------------
>  2 files changed, 69 insertions(+), 26 deletions(-)
> 

