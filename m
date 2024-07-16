Return-Path: <linux-kernel+bounces-254321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8E9331C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A0728255C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA781A01C1;
	Tue, 16 Jul 2024 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bgShgGGD"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740419F49D;
	Tue, 16 Jul 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157690; cv=fail; b=A320fBlxC44gXFg8zfLLtSvmNet/EwFoR4D8ZJJGyOZgWhPDa0FjcYynWIt2AgjaJ4fX0snzDx81KcWHgTpUtUIBcNGwytUNc/34oHWrESsHE8ZnHCZzBQl7AzQAOqIrTWCg82aKakFPbhGMwx5K5Ez3AnOanDM7SUbdlCBNtls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157690; c=relaxed/simple;
	bh=5SQxjdiPMrd+vCAS4cZlbQfJ/SNsAk3N/ExNDpvjJrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZC2piBjMKfz/nGdoZvDsDykmi0C0hNhB0lfeGfa2e+4lDXzR9lRtVFNXaZFfs9fx9ZFbmUhcOCEv1bn09OoAGeuvQ536CnCkhhoeHMtwR+ASGIJMTBdZIolOAdRWNPB7QV/jF9zJhAZlnXLWO1thFV6Th8XOTFJSj751gfdLSg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bgShgGGD; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRjZCG3pdFO4Ut6hT1You6o53lfWnOpvpq4cEDNsq6nyMQNw8NftJ5BXQBWSR+OCj6lDcE3s8GrZeFXQPN7agM7YP2SqVLUwTf/uqlbyb/jsQqsgWy+a0x8+0sJNAGTFoibutLgBXWY/thEUQYso5cF04/pbVF685yZiqsz0r4ReuNtdbhkHBD8T9BeRhBB+foeLhldhcZVAgFrCgE4SFmrHv3/Bz0AGwKiyuBNDvPhMi9AZupXnMiI6MrJiteh6FhgMI4l9/a6U9u0VixQQzB9Xl8ghD6dEEodUyuT+4aNePehseAJHnvl6Ay7S3KTc/sx65DnhPi1u7h0wU0zUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emvuvKQDwnHPDPf16SacGjJuKaIID8AQQ0/UpPSPBOk=;
 b=JS4YSJxmbqV21U+pNMxqn+wUuXEg+PBjCYBNX0CNoI8eE5IQEJpuPLIGXXVEQtHeLk5N4dj92di33WIi7cySg2liLfid27tC3u11VmOhtIkaHMwVUYGBded3IyLs51L637bxw9JhokaaE8uEPcQ8pdesn+rHhvhPWHzFwCpTdmfU8hKMSXxZR/j1L+iWRMe89Y8wN4aRkNeNK4AuhIAzUSRhwDcIAw2d6hpYZa6jHD06M/jf+paJxvw9AsNUo08iSxxXRqu4o5BwXIz80lu38yz6YRTkHNHU2SlS1/YBlmOwmHcF4vFDeMSKCAcjm6h07u1fNtD/DWUFl2IF0ezsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emvuvKQDwnHPDPf16SacGjJuKaIID8AQQ0/UpPSPBOk=;
 b=bgShgGGDJGEN0i4lPU8rn9dHS+FgigWquQW/IryulP4S7RN6XcpUhZvdiT7WZTKnjMhIO2896M0B2hD8iGl2CpfbAlnvzd9Ag8IdZJUj8z5T0DQ7nFKuQSZhoy8uZYixT/imIUw/tJWpUsxAY4YEnthOpp715K2XZ+d8Mq8QA8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 19:21:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:21:25 +0000
Message-ID: <b10fbeb9-6ab8-4cc1-a786-9a62faa27946@amd.com>
Date: Tue, 16 Jul 2024 14:21:20 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 10/20] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <f3f03d4c3518474d3e8a591c22d965ba5b934361.1720043311.git.babu.moger@amd.com>
 <6a68fabd-9a37-4183-8234-36ab8fab9b5e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6a68fabd-9a37-4183-8234-36ab8fab9b5e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:805:ca::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e1410a-e7f0-4359-a4d4-08dca5cc7c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkNua2NIeUJndk5LQ0lsdTJ5NFVVMVIwRCtMbWZXeUNpdEZiVy9LOXp6WG9H?=
 =?utf-8?B?cmZmeXZBd2VjLzZTWnV5S0lTdnVVVWgvcklKTE9SVWhEdDY5N1hVQm04TUR1?=
 =?utf-8?B?Z0ZJZEdjSUtZTldBR29kUkE0bnI5ZGprNmJyQzlQMjkzaUJmY0lKRFFwNVV4?=
 =?utf-8?B?eDZGdFJncENSNWowdEFwTk9udk5PNDZSc04wYm9SUFR4VmhJaVc0NGw2d3Jv?=
 =?utf-8?B?cEtJSGl5eEplSUpkOVkvMFFRZzROOTErVUdQcFE0aHgvYytxUnFsTExIZ2JS?=
 =?utf-8?B?NWU5TCtkc1hoTXJoRTlWdFRFRUNFTEcrT0NPOEpEcnFYVnpBZkJFR1hXWGVH?=
 =?utf-8?B?bldUcllqUUhpWXlzTklGVjBMaVhZWkNFUndKSGFvSVFiMjZ0a3ZOclhzVmJD?=
 =?utf-8?B?L3NsMm4xMWhIWFVITVJVUWdab1l3YUp5dnpCamVoV3ZYckRqWS9uQTFWVCtm?=
 =?utf-8?B?Qk9CSlBNYmx4aFNib05hb2FkTUE1cFFXdEJ3TFN4SFh4enJqOFFsUG9RTmJn?=
 =?utf-8?B?R2F4M3U1WjRORVoyS2JIOEVRQ0wxWWtRQ3VLOW9obUE2S2xDUFBSMlFjSE5D?=
 =?utf-8?B?Q1JRd0paQkVqL01wcTdpOHoyVTlNUmR6T1ljbVVGemdUSjl4WDFaa1NIUklu?=
 =?utf-8?B?U0dEUkZ5VVVRNlNMTk9EcTlWN2ZCOVFkS01hY2Q2R25pZTVyQ0JjdVNSbkky?=
 =?utf-8?B?WHhpNTdtZC9oVnhyajErYmF3b1NNTklMV05yMWFMbUo3T1dZejZJTEVzV0k5?=
 =?utf-8?B?TnRJaGpuTmxiakNyYTc2eUxiclc3dWNZbU9pV3orZ0VPc3grSk9TdHNIZ3pJ?=
 =?utf-8?B?WHE3NEJma1FiZ2xITER4bFNzOWlSNVRjdVdiTWRvU3FQd1B3UndYRDBreFVy?=
 =?utf-8?B?dG4waFVjNU9SVGt4dkxrM3Z3MW5uRmF5VnlpNXEwSUZIdHdmYlRvVmlhN3J6?=
 =?utf-8?B?V0V2QXo4NS9Fd0s3WTBIM05zVVhDU1dHV0pwcWQ4ZVpxRVN1OXdYcEREVXN6?=
 =?utf-8?B?c1ZOYjNoaGFjLzhXWHkrbllWQXVObU1WdnpSU25KeEppdkd6OVVLQkFycU4v?=
 =?utf-8?B?QUJSOXZQVWsrM2xaK1dMUVhpUVJEQ3pVWngwZkVsWnVzcFpVVjhHcU02Wmg4?=
 =?utf-8?B?ajk2RzNyVGV1RkpyRm9HZEc0dlh4d2licnNhb0hGaXl3MUprNGd2ZS9kQTd6?=
 =?utf-8?B?ckgwUjFKbUd4dUI0enlLMTdoaU1ERWJNbkZ4aXpMNWJzVlRieFFhaTR0c3Vw?=
 =?utf-8?B?OVVldU9BUGRaQnF2bVZxd1I2V0g1TTNtZ2FZa2hQazZyNjlGWGVlQlJUZlht?=
 =?utf-8?B?VnVMWGhmQjJCeVh5cUlVV0IzVnNUbi9WTFpFUUgxTkRSWlBPaDJiTE5heWJh?=
 =?utf-8?B?TXpveWQ4S2ZGT2JDYWtOeDVZdmQrQUJVSXpUNzVVejJSKzNia3QrelhVUTlz?=
 =?utf-8?B?OC9LbWpjLzIyWForZkNmZEtqdzVqanVTdjZIS1lLM3kwUVdzVElwci9UdkVu?=
 =?utf-8?B?VEJZZ1QzNFdwVGFwL1N3YVpCNTlucmFESFZHby93VXJCbVJiSERWZGZkblFB?=
 =?utf-8?B?bjAyYlRvdmtueGNDVi91YlBsa3Z6TG1xcWtpVDhHekVtcmhOcGpqWjhsNEla?=
 =?utf-8?B?Z3kwb1haR1lpM0g4eXlUcGNITXJwdlo1ZEIwNGhMWkF5VkRTeS9NR1JYdURu?=
 =?utf-8?B?Qmc2aElSbndHMzBwQ1ova3hUOXJkK0hmTk0vUUowand1NG03REczZm1wRSto?=
 =?utf-8?B?SFh2YXRwV3FnVEEzT2JVS2NSZlN2UC9oSGkxcmFBT3lLMW1IUUQxKyt2Vjlj?=
 =?utf-8?B?MFNROXJCTkNYYzF2UEFMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVNHSGhhTFJBRDZGdTd3KzhtbTVDMjdPWFphTXp4ZldmVFNkMEc1QzBUa3Z6?=
 =?utf-8?B?a0lpZ0luV1pkQWZYZmtrVGNCcmkydVU2aCs0Z3FxTm50WFFEMk55aVJ0TTRi?=
 =?utf-8?B?Ymo4VjR5T05ieEswRkJtQ1VPakpXcWNvMGhlM1AyaFlZemt3ZVNrYi9LRmp2?=
 =?utf-8?B?ZEtuN0l6THZSNGwrQkxzTys4VlBzanFqUCtUcS8yclNFV29lK0JtcHVjbStv?=
 =?utf-8?B?UFUvZ09mcmgrQ3hEanZORHcxbENvOFJRZ2FHYUt1WUFvNTN3NjAwcU9uWVJu?=
 =?utf-8?B?WVJDTGJOcE9xM3p4aXpTR2pPaExvMmJqT0ZwbFNNQ2ZsMWQ1aGhmOG1iS2ts?=
 =?utf-8?B?bTB5U003Z2JybEdjNHd2c0Qwb2lmR0V0UUNxT0x4cVpYY25KUTluVlA0cTlU?=
 =?utf-8?B?ay9vRG9pckhMc1ZoU0VVbVlMUDMzWUVhalJOTFlVa3BobWxPZmUzbkh6OGdM?=
 =?utf-8?B?eVRneGc1WkxrWk5tdzlMajlEYkJjS1Y2T1RkdFFTUGhqMXJoemp3NjFTNHNR?=
 =?utf-8?B?azJOTGtXbjlFWjN1Rm9IQkF5NHRZZ1NnNFp5K0YzNmpXZ0c5Y1hCSGFPN1ZG?=
 =?utf-8?B?RFI3NUM0UzUvRXUrd2Q5R1BVUU9EMFBOZ2hYZUhRdzBkeHcvMzJuTklja0VV?=
 =?utf-8?B?Q3pwd3crMGFrR1B1UmZvc2FURmxNSmxGZmFSendpNUQrS2pnZEF6VXN4YldW?=
 =?utf-8?B?T0loQXRUdEp0UVp4NzJVWm0rd2lsWVVJK1RiV3NzMUFlN3dTU2gvdHBDTjRC?=
 =?utf-8?B?S3JqOXQ0VmphcUI0cVVWWG5ocnFBMldXRDdCcGxXU0ZNV2NId1lrRkk3cC8r?=
 =?utf-8?B?R05SWGNhNWRvZE5GWjBsOGFWMDUyZ1pDNkM4WWtkR0s5NkFpbUFqS2dLdDlo?=
 =?utf-8?B?b2Vkelo2STgzZGdLTkNDR0NHenMrMEJGbm03cE51cVdVanZyU0hxWnhuVG1o?=
 =?utf-8?B?dW1tYmRKcldLSHlCUG5KQkNObEhpdHlNdzVmSzFmQVdWVGpnV1RWY29iREg0?=
 =?utf-8?B?MnRaUnN4NUxrcTJydHZZd0JKVmQ2U2NNNHB2dFowTWpVazJSdU4zTndIbkVN?=
 =?utf-8?B?eDFjcFFINEhkOFFoK0taZXRkeU5YTGJVRUNkWlVwWWZXUWNYd3pNaW1ROFBz?=
 =?utf-8?B?MFpQcTVZQm81WXk3em11aVQ4blBvNWdOcG1CaVRkaG5WWGhrSXBSM2NHNnpk?=
 =?utf-8?B?MmxqS3ZJSHNNeU5FczQwdjAxRTFkK0VPcmEzRGhxNG5BQjVVN0tnY2NHbmJ6?=
 =?utf-8?B?eUQ5S2ZKNmkrSFErc3JXSEhwTkJzNDAwbG52ZmpuVEl2VHQ0OGRkNDIvNFNM?=
 =?utf-8?B?NFVUR1ZKbDByVGhFQ3dxN09BeGNaSlYwbGpMcWxDcWk4WlRKWWx2aWNEZms1?=
 =?utf-8?B?aHI4MkxDQndub2p1VjdWcyswRzZpQzlyNHZUYk92eGlQUVg3eXJKYUJIZzdY?=
 =?utf-8?B?NEdqRFZWRmZBeXN6KzYzTjMza09USUt0UGtzalFJd25wWTBhUHlMdTNpeG5K?=
 =?utf-8?B?NlZuVVh6b3d1MWxHMjZwU0dSczBlRXBVQ3BMS0M4RXlZdUdpejlqQ00xRmlq?=
 =?utf-8?B?bDU2MFZ3UWxpMlFNU1dQcnE5b3BPNzZnSmZMZW4wQmlqN05kbkVwT0pUV2t1?=
 =?utf-8?B?NXJVMGhHMW0yVjhOeHBVRXVBMGV1c0dQYnVrREJaUEpxK09wWjJsS2JGbWZO?=
 =?utf-8?B?SndRTVJUU2dEMHNpSGtEbmVtMUNFUktQU3dOSkxRSVhPQ0h1aG9MVGk4cDlh?=
 =?utf-8?B?UWliYnN6dXNlWWdFdXRlbWE4ZURDWU9YNUdUbWR3OWhjd0x1ZHNVT2VGL1hN?=
 =?utf-8?B?T0ZBT3crYXZ2b01rWU9aYit6M1RBTm5lQm5neXdjYUEyeGhsY0R5NitxTmZ3?=
 =?utf-8?B?c2czc21TWDVLdFlLbllQNDlCMEU3MWdlTDAyR2lzdVZvUHpzUUhsL3dtUFBN?=
 =?utf-8?B?V3ZHLzNQNmkxQmVTYUxKNlIya3IyeThNd2Vrbm9PSVpySXpNMlFuTWZPV0k4?=
 =?utf-8?B?YTZ6WmVFWWg1ZWxEclNQdlFZa3FId2lKdmUvcUJkU2FDaDlweGF0dndNU2c5?=
 =?utf-8?B?SVpscU1tdzRkOVZkUzUyYk5HZnFXcnM2d2VSY0pmdjlxc2Y4UGlkaHRjdnJo?=
 =?utf-8?Q?8PBg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e1410a-e7f0-4359-a4d4-08dca5cc7c0c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:21:25.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFLI/eemQ8GrGHrRVhC2gSoUlwA6MOo9qq00v921Co7CK2im7HsmcYkd3IAPyJEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251

Hi Reinette,

On 7/12/24 17:08, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured to track specific
>> events. The event configuration is domain specific. ABMC (Assignable
>> Bandwidth Monitoring Counters) feature needs event configuration
>> information to assign hardware counter to an RMID. Event configurations
>> are not stored in resctrl but instead always read from or written to
>> hardware directly when prompted by user space.
>>
>> Read the event configuration from the hardware during the domain
>> initialization. Save the configuration information in the rdt_hw_domain,
> 
> rdt_hw_domain -> rdt_hw_mon_domain

Sure.

> 
>> so it can be used for counter assignment.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: Exported mon_event_config_index_get.
>>      Renamed arch_domain_mbm_evt_config to resctrl_arch_mbm_evt_config.
>>
>> v4: Read the configuration information from the hardware to initialize.
>>      Added few commit messages.
>>      Fixed the tab spaces.
>>
>> v3: Minor changes related to rebase in mbm_config_write_domain.
>>
>> v2: No changes.
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h |  6 ++++++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  | 22 ++++++++++++++++++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>>   4 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index ff5cb693b396..6265ef8b610f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -619,6 +619,8 @@ static void domain_add_cpu_mon(int cpu, struct
>> rdt_resource *r)
>>         arch_mon_domain_online(r, d);
>>   +    resctrl_arch_mbm_evt_config(hw_dom);
>> +
> 
> This does not look to be an arch call called by the fs code so special
> naming does not seem to be required? If it _was_ an arch callback then

Yes. Correct.

> it cannot take a HW resource as parameter since the fs code does not have
> access to that.
> 
> 
>>       if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>>           mon_domain_free(hw_dom);
>>           return;
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 0ce9797f80fe..4cb1a5d014a3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -401,6 +401,8 @@ struct rdt_hw_ctrl_domain {
>>    * @d_resctrl:    Properties exposed to the resctrl file system
>>    * @arch_mbm_total:    arch private state for MBM total bandwidth
>>    * @arch_mbm_local:    arch private state for MBM local bandwidth
>> + * @mbm_total_cfg:    MBM total bandwidth configuration
>> + * @mbm_local_cfg:    MBM local bandwidth configuration
>>    *
>>    * Members of this structure are accessed via helpers that provide
>> abstraction.
>>    */
>> @@ -408,6 +410,8 @@ struct rdt_hw_mon_domain {
>>       struct rdt_mon_domain        d_resctrl;
>>       struct arch_mbm_state        *arch_mbm_total;
>>       struct arch_mbm_state        *arch_mbm_local;
>> +    u32                mbm_total_cfg;
>> +    u32                mbm_local_cfg;
>>   };
>>     static inline struct rdt_hw_ctrl_domain
>> *resctrl_to_arch_ctrl_dom(struct rdt_ctrl_domain *r)
>> @@ -662,6 +666,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool
>> force_free);
>>   void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>   void __init resctrl_file_fflags_init(const char *config,
>>                        unsigned long fflags);
>> +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>> +unsigned int mon_event_config_index_get(u32 evtid);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 7a93a6d2b2de..b96b0a8bd7d3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1256,6 +1256,28 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>       return 0;
>>   }
>>   +void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom)
> 
> A function is expected to have a verb in its name and the verb here seems
> to be
> "config", which does not seem appropriate and creates confusion with
> resctrl_arch_event_config_set(). How about resctrl_arch_mbm_evt_config_init()
> with proper initializer of the config values to also cover case when
> events are
> not configurable (INVALID_CONFIG_VALUE introduced in next patch?) ?

Sorry. I am not clear on this comment. Can you please elaborate?

> 
>> +{
>> +    unsigned int index;
>> +    u64 msrval;
>> +
>> +    /*
>> +     * Read the configuration registers QOS_EVT_CFG_n, where <n> is
>> +     * the BMEC event number (EvtID).
>> +     */
>> +    if (mbm_total_event.configurable) {
>> +        index = mon_event_config_index_get(QOS_L3_MBM_TOTAL_EVENT_ID);
>> +        rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>> +        hw_dom->mbm_total_cfg = msrval & MAX_EVT_CONFIG_BITS;
>> +    }
>> +
>> +    if (mbm_local_event.configurable) {
>> +        index = mon_event_config_index_get(QOS_L3_MBM_LOCAL_EVENT_ID);
>> +        rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>> +        hw_dom->mbm_local_cfg = msrval & MAX_EVT_CONFIG_BITS;
>> +    }
>> +}
>> +
>>   void __exit rdt_put_mon_l3_config(void)
>>   {
>>       dom_data_exit();
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index b3d3fa048f15..b2b751741dd8 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1606,7 +1606,7 @@ struct mon_config_info {
>>    *         1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>>    *         INVALID_CONFIG_INDEX for invalid evtid
>>    */
>> -static inline unsigned int mon_event_config_index_get(u32 evtid)
>> +unsigned int mon_event_config_index_get(u32 evtid)
>>   {
>>       switch (evtid) {
>>       case QOS_L3_MBM_TOTAL_EVENT_ID:
> 
> Reinette
> 

-- 
Thanks
Babu Moger

