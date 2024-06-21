Return-Path: <linux-kernel+bounces-225062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B2912B56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438392891ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416F3364AB;
	Fri, 21 Jun 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ByymExJo"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299515FCF6;
	Fri, 21 Jun 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987378; cv=fail; b=K1immql5Pc6DkohkG7Ed5RL7PUn5JL3Hl16/jJLscuc+PR7cOsxig98LMbly7I1rUyMhXIpF9f+j2whZ76WQvGMhi/zCSzSEvsRgfEL1sElvrqrn/MSwVs9SQ2N0TFomL/i+Ho657++eA5DRninslpRYJTcmqdEopQ5RL02AXXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987378; c=relaxed/simple;
	bh=PXe7fGYSrDkg9mOZlyiHP5KN/z+SURyGJ2hr5XKlXi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L/vagAoGIf16jytK11FUkQ4NRmLLF+9svPSfSBwyQAdbZsyMsn9UUvSfeoOzXJwZ1b4czU/k1F4ZQsCBCYgV8aewM7qWktICFRW29cyf4iOytvFYohMDDG9nWzKLKXILXpO1rnGR4+/W7ccdIfmCi4ceIPaJHDdA3tssFipw/aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ByymExJo; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NObiTRynJZOtDgRmLHF7Tmu+GD9YOG6O77Q2ly8ndimRPbhoR2I2Z7F7jZY3OnpY0AATvb15DI/gzAjUioC863TWEvBmW87xgzOwehLZ2cwoDDWj6+kZlmhO11FeRQ/RmkBkklxR9jnhD1vO4wSfF+x6fwCCxxmq1IMCMO30YxbNcrj0x8zxNzaRFBtEi6/y47iHjLS20EjCsBP8V8Et0+4m0J80S4S5jlnzgVX2+/sXQrCmr+xTlUqMZ0Kfyw+lOwhWTVmB9STEakBr+AuN6WHKUlD+VGxrjvz0z/6N5ZnGzTKFH9vp46XsIYaQaBCYw3JH9Q8IEnNrcQVVAgCIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpzVSe1dF5214YTc91zlf+v2g3IB3C3YiVazb6x6FRQ=;
 b=eEAXgT6/YbxZvnruG6GwihRDaSpjpg3yZo2cwgx4LiQYEFmHcl4f3Sl/u4qSCsXjFvX+HZ2shOgsAtf5a+5pbN2t2YYry2LYTX0vF8wEHgymr1zZIkMNOGMQW72Tn8v56O3kCWfnsB1fpICUb/VXQWiFHRUMCHmoBN86dwaN2ZVvQZdJhfvCe/HTN0OFx5PicbJyegpkpwmwwW0FDDR6Ojy2HclEyYH2iphex9iXD6v2nQMQK3WTV9xIhaIK/Sff5USD0CagoKlKq8kVA7E+XjyiX3P6A7JQKdikFwV1OWk1o6wnn8ps9aOZ/ORRki/kVbTd3up6ow5UtNSJWQUsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpzVSe1dF5214YTc91zlf+v2g3IB3C3YiVazb6x6FRQ=;
 b=ByymExJoXTiSd0zFsaeM+OoVSB4s4DhR5hWULqqUE52wXNYBViE9MKsiGkHW0mZADieILuuk3BkWPdBl01jXhRGkXsfVvDJzD++xo/RTLlMMNeht9T4vqRamjm5D7o6cX/fBgMcas4649ERUyrYJHcwcnBzJuk306J79NGd5xj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Fri, 21 Jun
 2024 16:29:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 16:29:34 +0000
Message-ID: <3197b4fd-c998-c332-3dbd-4c0afd949f4b@amd.com>
Date: Fri, 21 Jun 2024 11:29:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 16/19] x86/resctrl: Enable ABMC by default on resctrl
 mount
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
 <74f014062885d707701873527c1b12268603a525.1716552602.git.babu.moger@amd.com>
 <b722c5da-812c-4ccb-ae7b-e7bc9c9de50f@intel.com>
 <343960a8-b364-44b1-aebf-ebb7fe0a1466@amd.com>
 <5789ec24-3633-4e9b-8b1d-595d27e1eb8e@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <5789ec24-3633-4e9b-8b1d-595d27e1eb8e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:806:21::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b45d1c-3e21-4daa-40e0-08dc920f55f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEowWlA2a0J6RllUY280aWc4VXRSWlpxNmdESFNqN091L0YrS0liTHI2M3VD?=
 =?utf-8?B?QkFSVlBjUnF1ckZCK0FSNmwvRGdENkR5MGF3RmVjV0JUZXhHZjFuSmxEZys2?=
 =?utf-8?B?MXUzTE1pc2NqZFdCZkZmL0pzb0lscFp0T0grSEF3RVZVb3pjQnBZbHdzSVV3?=
 =?utf-8?B?Y2xvRXRoTVB4ZkRBSlo3VC9EMmJLQnNqcy9KY2E0VmgzdUdIR3QxZ2s0TnhT?=
 =?utf-8?B?eHBWSGw0R3FySHFOcnJaTWF6YThudVBBY0ttZ1F5T213Y004RkM1QVYvZStI?=
 =?utf-8?B?dVZVZDhYZG8wSWlCeDhSYzVyNCs1dURlVXRVdUhLektndmJuQk9EZ0FVemVs?=
 =?utf-8?B?ZDZPUHM4RGJLM2dOeHFNQXc5SGxhRjk4NDFnRDBmMXRJSlVHQ3UwOEVqS1VD?=
 =?utf-8?B?eXJJeGdscVlSK1U1amxkK1RzYkgxekRicmd4d2xEQ21yaGROWC9DVHJjMlJN?=
 =?utf-8?B?eERxQnNkU0dKZldJOFUrU3NUZjNqREtVTEZpSDh0TXZ3cmtJOTdPRWMxUW1G?=
 =?utf-8?B?a3NQNndUTzRwTlpCSi9zV2ZzdW82aDRxQnZqdCtaNkZJMHVINm80OGZxZG1O?=
 =?utf-8?B?MkcyM0dLbkJiaEl0M1V2N0FRcWFMNDIrVUgrcFlZeHpjR0ZPRWg4M1NKcDlF?=
 =?utf-8?B?N0dXbGVqeDc3UGN3cTVmMmxySGd4YkdaUDNxN04veXVGNndFaGtRWXUxaG91?=
 =?utf-8?B?TnhSRnFxUzBPeDR1eXU2VGRFYW9PR0pMYi9tMW5EWGJjY2VHVDFZSnJORXRk?=
 =?utf-8?B?ME5NSmozays0NFBBVkQ3VnEvamw3dS9rZzVEVGI2ODBJQzFwR2R3Nm9NVG9w?=
 =?utf-8?B?VE91L3h1KzUzWTM3VkxONFljdHgwZHFqMkJlTmxkYWVUcms0K2ZwUXlLMHNR?=
 =?utf-8?B?bFFFc3FTNitQSEFxSDdoV0dHMnNVaU44b3M5NE1UTnR5dGJXTVRvMHQwUUFv?=
 =?utf-8?B?RlJoTWtocUlmTitPc2pCbk5VdEQ4dytkcnQ3YXVaU2VnZTJkdTF1ZWhUdHVn?=
 =?utf-8?B?ZlVTYzRla1J0b2VkZmRqeVhUZEFFSXFEc3BkQXVOSDVLMG9jUkZtUFRhNjVU?=
 =?utf-8?B?T1hEcWVNMlpJMFhCVDkyWUZwckp2dXRQT2MzNG54R3MwOXh4Z0Rnb0NqVVdC?=
 =?utf-8?B?YitEbzNicEVtRm16SUR2b25uSUR6WkxsT2ZXMDhSeEJNT0cxYmQwalN0bmla?=
 =?utf-8?B?RG1LZUYwY1ZqNVd4KzV3eFNXVFRWN1J5Y3NZTUNiZ2NETGo2TmgrMUk0dGFI?=
 =?utf-8?B?TjRjQmRsSXhyd2ZySVI1dmIyQlQzMjZBQ005NkY3bTh1ZEFrZVFuR3lyMGV4?=
 =?utf-8?B?MFBESWVUY2pWR3ZUREh0ZDdQazhqUTBrRE9IdjlGRU1jcGR5QjdJYUVkRi82?=
 =?utf-8?B?SUxDeWh6QlE3RDMxN3d6TDNmSjBLdnNITUc3MTVxZ0hvdm1qbFAzbndjc1FF?=
 =?utf-8?B?Q0VYcHVEQTZ0VjNBZlVZbkdodGRMZXIzb00zUE1ZOG05akdhbUdTZm1aS3Fm?=
 =?utf-8?B?dmlaMVdiKzl4ZVprVnlCTDdYV2NTWTE1a1BoNkxVVnhSUHgzRDYzdVFSNkN3?=
 =?utf-8?B?ci80b1U2YmxEYVFuL1BtSkpuVW5XR1NjT21GLzUrL1d3ZDZjYklqSzFpVXBW?=
 =?utf-8?B?N3dIcmJ6bktGZk5veGUxNHhsZHZKVmxwNDBnL1pha1E1U2dDMThXVVdLQitT?=
 =?utf-8?B?MDJpVE9ra3pDQ2RZWk1BcEhOd1pabDIyT1dXaFdlaCtmQjVMbm0zSDFUNnRn?=
 =?utf-8?Q?WLiMC7d+jOtCIpjgIEpXwsLDeCOVLZj0Hbnt76f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFNOcGpOTTdCUDBaLzhUTytqWmFvZlRRZEE1S2dEYm02cXJSa2lDeU1vVTZj?=
 =?utf-8?B?YVpPOVM2Y2l6WFZNempCWEhFUHJqeTE5OWlVdEhkS1M3dWVBT2RodzYzVFFU?=
 =?utf-8?B?NC9vamlWV3o4Sy9pRjVTRHF6TEZORGJqL0cwS2JtRXdxeHRaOTc5cFhiQnVC?=
 =?utf-8?B?eVRNYWdRUDlWVWFKOE9Bd1FUYkFjM0R5TFp0WTdoOFpZQVREdFlCY3pPSmo3?=
 =?utf-8?B?VXdFRG1vVEZoUVBCRnFoK0NvTDNaU0Myd0xSWEFKbm93WENzRHRDQ2gzekFG?=
 =?utf-8?B?SE9XYmxOL01GQldGVnArbkVhZFBCZVlsaW1JS3JNSlpXNXgwVGRBbG1MeU5X?=
 =?utf-8?B?dHFLSzUzYWoxa01MRlUyak9YRm0yaC9BUkZNblc1TTRma29xS3VVT3ozVkNy?=
 =?utf-8?B?Z1B4Z0k5cXR6YTVHNDZ0MnY3dXFPZktBSjMvcTlkeVRBaTNRSmt3UXhDdld1?=
 =?utf-8?B?ek9zelBNZHZkWlQzY0JFU1FXT3lITFoycU5OcytDM3N2ZEZoN2NkY1BmNE8v?=
 =?utf-8?B?aHlOWEM0S2dBL0Y2RzMrLzk5cEJtK0tURGRMZ2VvRlZrYkhKdm1TTXM2WnUy?=
 =?utf-8?B?VnVaMlFJcHNqVFEzaXE2OGo1NE93cWthY3diS0Q5YjZBK05CalJLajlUQktW?=
 =?utf-8?B?QU1sSzdUbGV2WlI1UzgvbXBOSTFVREdxVmZ0YWdHeUlyTUhnVU1OWE92N3JS?=
 =?utf-8?B?andRZUNkL1BBRXBHNVd2eStwTm5RVW1JV2ZQQ1FzTUFGZ3l4emlvMklsYzd6?=
 =?utf-8?B?OFNBa05zUFdIWWhLMWV2Q1Q2dWJFTHk4djJ5QVBrZGhaYzdROU5HK0dxQVlh?=
 =?utf-8?B?WCtZb0pVY1BGZ1lQbStiZVVhRE84bXJ3WFZodUpyZXhBWVgwYkY4OGZnVm1Z?=
 =?utf-8?B?MkgvRE9sejFoQW1LdGNRRk5uak5FeXEwQnp2TjlJbHAvSytrdE1oOXFIOW1y?=
 =?utf-8?B?cFE5QmVaRDhaMk1iak9qVUIrUnhVNUhna0FwMDB4VmNQdzAzWDQxVFRncDVP?=
 =?utf-8?B?K2ZoMEZaSHQrVTdkUlJkRC9ianJoL0tBVUFOcXQxcGdkMDI3VUN3WXk0b1Z3?=
 =?utf-8?B?NTcvRmhKOFJrcGlhUml2T3hVVnJNWjNsZitjaFVTcVdPRGFiMmYzeFhtVDV4?=
 =?utf-8?B?RE5JMkpEbUVWVC9pMlYxY0RuaEw2SkZnaUxFbnhNNnBGMkljQml3TkVnWktw?=
 =?utf-8?B?SFU1ZkxMR0xGN2p3eWhTN0JzOU1hV2I2dlRBK3FaeFV3dktYUENUTzJRM0xK?=
 =?utf-8?B?dUpZbDNZUW1PZ3JOUjZSdDFBMnNxS2J4bVdZOWIxVjRYNmhTdzRaVTB2NXQv?=
 =?utf-8?B?QVU2MC9uQmlndmdWdHNud0crNnQ0SEtPQU5JVlRPZXNDc1Jyb2xyOGh6WFlG?=
 =?utf-8?B?WHpRanVLaWpqYVZ6WXQ4ckxhNXRTcVV2YkwzSFczYmRjeXVPbFNvTWZNVHUv?=
 =?utf-8?B?YkFnL3VNbkR3UGVYVXV0YkhlUTJjbHBRR1VnUEM0Q2FUZUwyZk85VSs1OFh4?=
 =?utf-8?B?M1RjbHZwOW1CNldWUWVEaXlRdjJKNjhJdXhURUhOZitUVVlOZm94a1pTN0p4?=
 =?utf-8?B?aEJMcFZrVWVFbWp3MkFOdnkzNWtQVlZEcG9SUHBIZW91czlQRFhtWVB6WFl5?=
 =?utf-8?B?R1FIblcvMU0zZjJHRFU3NEtrUjdKZ09adlQvYUJMTzFMYlJWWGdYS0ZBei9D?=
 =?utf-8?B?VENQRTQ0Y1h6VnZDSzV3TEdLOUkzMjhlbnY3bFJldXpMNXBnSjRTR1pNdllx?=
 =?utf-8?B?eXRxQno5RGJSWHl2ak5hL3E0Um5PN1FGWXh0RWttMzc0OWpQd0d2bXpTMVNG?=
 =?utf-8?B?OHFibUpONGZyODJNRnNiT0gwaGs3eG8wbllUZXdtTXZJM3FYa2VPeEtHTWIz?=
 =?utf-8?B?QnhpQi8xYXB5eVR5ZlVUTS9uMVR2VUtoK1ZFc0ZhODZSaFZ1Nk1VaXNsWWJw?=
 =?utf-8?B?aTUrTGdxaXVVOWJBQTZDQTNKeFFKQzVOUnc2UkxXajl6ejFHQlBWak4waURV?=
 =?utf-8?B?dFFudEcxR1lmUW9YQXBCZGFUZG01WDYyNWtpd2J3d2N4YWxrOTlUeWpKUDRJ?=
 =?utf-8?B?TE5BSkNzMWNObWFGRnlEVS9La3dJNkhFcWtuOERPcTd2S0ZUWnQ3aU5xZ2RI?=
 =?utf-8?Q?QKZg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b45d1c-3e21-4daa-40e0-08dc920f55f7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:29:34.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/TiaCTB37t/c8IDCCCychqXlry6AJyE4UoaxeARJi23HvwedTepxAExI+s5sz2G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906

Hi Reinette,

On 6/20/2024 5:49 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/20/24 7:46 AM, Moger, Babu wrote:
>> On 6/13/24 20:50, Reinette Chatre wrote:
>>> On 5/24/24 5:23 AM, Babu Moger wrote:
> 
> 
>>>> +        if (resctrl_assign_events(&rdtgroup_default) < 0)
>>>> +            rdt_last_cmd_puts("Monitor assignment failed\n");
>>>
>>> How will user know that there is a warning? This does not return an 
>>> error
>>> so nothing will prompt user to check the status file. Perhaps add a 
>>> comment
>>> in the docs to help users at least know that this exists. Another 
>>> helpful
>>
>> Sure. Will add text about this in the documentation.
>>
>>> thing will be to have the counter return "Unassigned" if it has not been
>>> assigned
>>> since users familiar with old interface may see "Unavailable" without
>>> knowing that user action is required to get a working event.
>>
>> Not so sure about interpreting hardware reported error.
>>
> 
> I only see "Unavailable" as a hardware error and that is already
> supported. "Unassigned" is not a hardware error but instead indicates
> to user space that no hardware counter is backing the queried event.
> 

That is fine. Will change to report "Unassinged" when it queried when 
event is not assigned. thanks
-- 
- Babu Moger

