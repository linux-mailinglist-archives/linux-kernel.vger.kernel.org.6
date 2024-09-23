Return-Path: <linux-kernel+bounces-336214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47D97F0A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF9D280F25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540919F134;
	Mon, 23 Sep 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jAqtQN0o"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BEFC0B;
	Mon, 23 Sep 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116399; cv=fail; b=acO8svMyWerWNo4Y4M169qU7jVCaeSNq13WDJn3R/BjSDY/SM0nqs5eaBE0/AyOCbtJnOKMYPSL0+qvJFFilTeB8Sx5+S4RqO/5ut/Vb3l8bNCxmPLZuz5Xq/Q0zEc51cjSpnFs7VPC3lMjm9TKo5VwYiv5gsFK08fsfmdXr7nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116399; c=relaxed/simple;
	bh=/CwujI0uPcS0/zRS1TTnuf77bwp6VmQ/WG+lpeoPysc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G9eVkxalWPY5922L9qOK888kJjQT7DOvmCBhuNnvPxtiKtlQ6AAPSmk3CoizvLXm+o37lNEHArn26kOQf3lr84kdnHpbXtyRmz6kbiOU3pgMBjJOStZCj2HfxP38mAb5VhdHaMc387umYW7WNJXs0U1+Rh76aJSso0+WUcG4490=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jAqtQN0o; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRhBv9qCPQTnzF0aq7tcakBBd31y40jf3GtSDeX/DngKKLKIXzFeOFdFC3r13xJQtoCmxlQRp5RPYyuMT0k37PASMUVceLlYeM58e4GXcrP+OjXxpNFs2DnHHpVYmU6VhovCVeIk1m1Ht5hNtqGTbwpYND25m7UVhVR5bZ2VxDK1UAqN/ZhQoupMIF4l0irACJcedjllHMJItDWRgql+gS8I4HPSWCeHSzM0cvwPI0a73jbaFY7LMZKcy2avbbo0gEHY2YQoI+nMrVbiZu6Fo5wcSWDkosaOcb4n++sABCbZ/X3bVIaV7KGK1lvxms8p8mpZZ6S+F2ZLvwVLWhW33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mVG4KggC2FzLVIscrFBP17tSa6yNOa+BXTUrb9tu0s=;
 b=DyQUYKarIsOl1pmcxmKkrvjSonq41H7G29Fjarqc5RRe2ziaeK6tkhaWzGfUTSccrFSgLHsU79YRxSokx0YWfPqBLUZYCfLWaaanjnDjk1ohVfaF250jUoH+yyYD1ukKZ8sPu0juZeKlCNI7ehguojVSM0WovdheNMMbOksMQUACMgN/TNEX1qP2oFu7VhI6en52Md3rRTRhzNPVU8idLNKcZvuoQTmXeP768jl39w3aeLNLJRCg/b79EymZCcj80hGhjkoKQQ0cqQcfgwUj2czeH/1+Sq8ag3Kv7bg03SFh4qEsy7+PHb7uw4JiNwVOskIm6wFaRcqzD7BbpOPN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mVG4KggC2FzLVIscrFBP17tSa6yNOa+BXTUrb9tu0s=;
 b=jAqtQN0oLVxXJ+CkzBsBEkwZS8LydCx3Nhg3acH12LWQ9bcaWY17/W2Rc5SwEzPeYVJy7hV2dStDFy74SdvnzCa+ZMPw/I2hqbEcNTuFYC4QBax71SQv41+oGYpqz6Zl4oJonng654hIMtX9/o1T7Cb1IYxs9Rp5oImPyiqwkrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 23 Sep
 2024 18:33:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:33:14 +0000
Message-ID: <c333ce4d-3e4a-45b1-87b4-42a4d35d0ad0@amd.com>
Date: Mon, 23 Sep 2024 13:33:10 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 09/24] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
 <50084b31-49e4-41c7-be1e-24773d03d5d3@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <50084b31-49e4-41c7-be1e-24773d03d5d3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:806:a7::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: fe42328f-efef-4ddf-501f-08dcdbfe2f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVM0WTBtUk5GOENrUWZoa0ZVU05QQ2xpa29lV21zTFMySFptRStueUppVFJk?=
 =?utf-8?B?VWlvdDhhR3hzdVRxWGQ2M0ZVMDJscTZ6NGhNZWZXcmw2VVNEMkU5b0dVUHRq?=
 =?utf-8?B?RVMwSERTMVNtQWJGYmdQcytHL2M4RHgrcDZjK3ZydERSVDhuVGswekloaU5F?=
 =?utf-8?B?clV4ZkdEVnJwVWlWcTJOT3hONDNsdDdrdWlkVGwzNDVnbVc1M2RuRFJjQVNa?=
 =?utf-8?B?QzJMRGRhamc1bEkrbW1STkJEVEIyUlU2L3U4eGgrSEczS1NtSGd3SzNBWnp6?=
 =?utf-8?B?bmVVUWRPQ1dhV2ZtQ1Bsait3OXRpNGRTUVA1bjFmK2VaVWZWenBkcjl0VUUy?=
 =?utf-8?B?NXRVTW9QTjAyRUNXVjkxNHkyTFJkcnUwb01BaXNmK1NyWHkzYTl1cytyUXN6?=
 =?utf-8?B?SE9tNTAzRU55TDFnY0Z3MmRwM0JJdjFPTXVpMVluQy9EQnEyb2hFRXRhdUpn?=
 =?utf-8?B?em04VkxkaURIOElSUHlMN1ZIUVA5WEdWMUtPYmpuWjNGUnNlMTRlUERZNzk4?=
 =?utf-8?B?SDByQlNYTG5qSEl3R1l6cWV4Q1NxVkdPTGRjeXEzT0JtS0ZiZmJzVW1CVmE5?=
 =?utf-8?B?NGhYb1FrOXA4T1g2WE5hWHdwdndBcytORDI3MDVNZCtKMXNkeVB5bThjRXdt?=
 =?utf-8?B?MThvaG9sZFM2NDVLWGo0YXY3WkEyaEVNUEtabm9keWZuZXZkd3F1NTdRMUlv?=
 =?utf-8?B?dGJORlJZa3FQT3BXYTQ4dmpQSitBRW9JSm56cGhpK0hnbjlvaHU5bTdCbW8w?=
 =?utf-8?B?aWdoeVUyOFd3RGtGRElLMEFCVlBpbm9xWUo2SXpOd1UxNGE5VWkxZEExRnFW?=
 =?utf-8?B?NklQK2tyMGxYRXJET3h3aXJ4RDFoOCt2b05qUlkvZXhBNW9HQ2tsVXA0eE1M?=
 =?utf-8?B?dkxSV0RmM0MwMDdIVDBTUWxjQjV3OU9aNHFKK000ODFSTmZJa2d2V0kwQWM3?=
 =?utf-8?B?dmlyWGJxTUJZSE82RVplNTgwM3Jjdy9sOXZaYTF1ZVBRT0IzWkZTSEJWcERH?=
 =?utf-8?B?eDJlNXhUV2hyR29YQk5hZ2tZRC9hd0VOZU93NUNHODJRN0w2SkFnaW1NeXBi?=
 =?utf-8?B?MjI2M0hiNWZyOGJwTVd3eWRBcUpNZ2lnYm5vaHBIdCtQTitKY2M3OGJmT2RU?=
 =?utf-8?B?cFlsUVAwTVpsOXhtUXVkVHFSWUFyWFppVHZxUlozcFI2NFBoZGFsSHZIWkxF?=
 =?utf-8?B?bUIyWGRFWDI4NkVUa1B2Y0VocjY3NlJVMWl6bU11WHpSWXkyS2lZVWVKSHZs?=
 =?utf-8?B?cUNDcHJ0VHN1RjZlSUJnRExyWGREMmtTZnZ6VGdZaXhHKzdUYzBsdXV2eE0z?=
 =?utf-8?B?QVpPVXNMRTJIMTZQZ3NtcWRHd1dJSmdlZ0hEa1JZaTVOMjJhM2VmZDVXT0du?=
 =?utf-8?B?eWdHcGdVV0dSRW9MblJBUmlNR3RHb0RuelNEeTNlZ3NWZUdyVUdVSjQ3ZDNX?=
 =?utf-8?B?L2RkeHFCQlZqY1Y0WW9sbVA2RVBOOTJ1OFVVU1I5azVqWTZsemdjaWc0S3BJ?=
 =?utf-8?B?YlFtNFlvY1RneTB3K1dPbGV1R3VEdm1NdTNoREpYS2crNFpQQkFlaHp4QmIy?=
 =?utf-8?B?SFRSbEJBMDdsMG1kTExvSUhYNUVwTlFiYkxtUE5MT2JHK1oyM2xya3h6c2Ny?=
 =?utf-8?B?ckEzbzBLZE9Dcms5dm5mdFZWWkIwcjJjZ3o2WGJPc09WWDc4ZFlJRTZ2UE1h?=
 =?utf-8?B?UkxnTytpOTBvZnd1WFNTR1NGcXRqajNlaFVFRlR2TTMzeVQzQno0QS9ZOElP?=
 =?utf-8?B?ckJaSkhVNGZ4aGNMbVRIdTBDV3RrMjhiNUdRTU93dVRIM3puNERzTE91NWRq?=
 =?utf-8?B?N3QwTEpVQ3lncmR3cG04UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWpCZ0k5bis1cmo2Z3hqTDF5aURPMThxU095S2NYb1FEWmRBVnBYNXFZcEd3?=
 =?utf-8?B?ODg5eXhQeEliR3JBSUxHTlhNLy9LWC9MMzhURHRQRkVrUmt2VVBBa3FYRENw?=
 =?utf-8?B?cjhEdHBlc2FCbGdudWxLZTU0cWhyQW9STFNrZ2F5L1ZPSUo0bVpreXh2SENC?=
 =?utf-8?B?ZzlQQm1rLy9zK1p0ZUpRNWt2MkM4Y1I2ZXJUSExnelJxaGN1Zk5MdUJ3K1RB?=
 =?utf-8?B?QjZ5WkMzVkUzaFhDc1dtYXNYVEJVTE1iM1RzTlA4cnBkR0VKZ3M1emU2ZWF5?=
 =?utf-8?B?dFhhMGxiWWpodDdwNFI5NlA5Y0xIaUhqMHlFYi9lWWtoaFJ3VDJLRTJXb2dO?=
 =?utf-8?B?L0xhOURiY3IzSFhYRncvMFlHbDdDc2FiaHB4ZDVYdFJqSXFYdHVRRGpsYkZC?=
 =?utf-8?B?VFgvYUZrTDlKb0lzK3FiRnJ1eXlHdFdaL1FtSGNpMENNdkNzZGNTWVNwYWdt?=
 =?utf-8?B?T0Npd0NPT1FMRzN4RExDSjBHNTZ1ZzJjd2I2QlpzNlViUHVDSDI3R0FsN2Ir?=
 =?utf-8?B?NURvYnpLYm9uN2Z2TmJDM090Mk9oeXhqZDdlQ0NRdzM5KzJJMjhCT1RvS3lY?=
 =?utf-8?B?ZFhnVkhQbG84QkVsbitlY2hrallUZXBVc0lyVEJvUmNGV1Rldy9RZmhpZU43?=
 =?utf-8?B?dnQxcGhrUVYzV3Zod3ZSSnZIVFZJZm1tY1FHaDRQNDRpdnlRUXpkc3dyNENX?=
 =?utf-8?B?a2toc2pHU3dGQms1R2pVRitIYTVwY0Q2dFJ1WXRrL3dLUjAzUHZkc0xOR1pu?=
 =?utf-8?B?UDNpWmFlQnNzQU9vRjFVN3k1WVJKMjFtSmpVYnRiNHJiZ3ZRSS9VcTBWYW82?=
 =?utf-8?B?TWNJT2E5SjdjbXVQM0FWOUdycHFtYUs0czRweWVoYytPdytTcXVKSENJU1Rh?=
 =?utf-8?B?K0dWRG40WG01L1J0MmdhTlgyTEl5dndLS3VpcWppUWxsNnJBWGlpUXlvRUp1?=
 =?utf-8?B?eXQ1V2MrLys3bk9mOHphaXU5bFZkd1dsaDhlQ0VTOEVnK1NSMXFkNkFMUVVW?=
 =?utf-8?B?ckJibzFnc1VrSVg3Nm0vT3VyS0kvYVNmRWVWSmdNQkxsRHNJdFhML1VoTDZi?=
 =?utf-8?B?ZGZNTDNDSVhHei9xTSthYVYwMm01RnRBSTUzVS9FNTNVTmFNUVE2bGI3UmVK?=
 =?utf-8?B?T0lsMCtLNUExVEFyWFhWRHd1alp5VEFqR1NTMittbitMcUMrVjFLcGNPWklk?=
 =?utf-8?B?Ync3SmdzVkNnMUhhMTAyUzl3NCthT3h1VDVpTWF4eE9vRUMzRGQzS01uUjFz?=
 =?utf-8?B?Z2NLVEZhMlYrYlZCcXpUMHM3d2VpMFZWUTB6cGNaS21XREdQa1l6amZ4ZHVy?=
 =?utf-8?B?Vi9seEYwaWJvZ1pkeDJaNHE2Tisyb1ViOWs3MTVWNEFBbjFUUWNJVW01Nkxo?=
 =?utf-8?B?WFlSN0xjelh4VTBHb0JYdkVuLzdvQ0hTZDl0VG1Ra2Y3MEZIcUp1OExnR3Ex?=
 =?utf-8?B?b1E0c0c0NWNkbW1WczNLUDFRblJTZ2c1MFR3SmgvWHA0V085RUpmdFV0ZXAz?=
 =?utf-8?B?aGM0TitrYmJoaFdVVVVZcm00RC9lcWVUSEd6bmNBNEF5dHEwOTlvcEdNWHNF?=
 =?utf-8?B?TGtJZkxRZmZkUmdhOStOWlUzZkNBK1ZBeUE0SlU2d2NZOHZhd1BaSE1PdGVE?=
 =?utf-8?B?bEVVbEJxeXBaNzJ6VkgzU0xNMnBxV0JzalNUbkNKcmdtSHFtQWNxeU5EVEcx?=
 =?utf-8?B?Z3pacWVkUlQvR1NaaHdIUmJ1b1BBdm1KMzRlNHNyMEttOTNKQXVkeUFIR2FF?=
 =?utf-8?B?NlF2MkhOZnZnYUszRE05UEhzOVJNUUM4NmVOVllrb2FGN3BBYksyNFl3bTFU?=
 =?utf-8?B?N0thT01NWmtlb1duK0ExeUNwazc1WVJUdjVpTS9ZaUh6MmczMko4cmpOeHZB?=
 =?utf-8?B?RGRtY0oyRkFRZTRpdEJOVGh6TUFDeGlvaXJzWElWS3Q0TlRDdGhHL2YyVHp1?=
 =?utf-8?B?cWozQWFib1BnZE5GQWJVbTlJRkNFVjdDcFZreUgrL0VKK3ZacnR2TkpSR2Rr?=
 =?utf-8?B?Y25TODlvZjRyaUQyY3Jrc09Bc2M0Qy9xVEtqamU0L094cW0wTSs0NWprTVNh?=
 =?utf-8?B?R0xxWkM4UnFPeFVlUURFcDU4QnhUbUVxdDc1dFZCR2w0L1VQbjlDd2REZ1VC?=
 =?utf-8?Q?rWBI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe42328f-efef-4ddf-501f-08dcdbfe2f7b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 18:33:14.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMobNYnsaw2MViAl2hNWFaxyamJ6XMJXafMEOJefegD+TbMcuQcx6ET5TG7AeSEZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

Hi Reinette,

On 9/19/24 11:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Hardware provides a set of counters when mbm_cntr_assignable feature is
>> supported. These counters are used for assigning the events in resctrl
>> a group when the feature is enabled. The kernel must manage and track the
> 
> The second sentence ("These counters ...") is difficult to parse.

How about?

Counters are used for assigning the events in resctrl group.

> 
>> number of available counters.
> 
> "The kernel must manage and track the number of available counters." ->
> "The kernel must manage and track the available counters." ?

Sure.

> 
>>
>> Introduce mbm_cntr_free_map bitmap to track available counters and set
>> of routines to allocate and free the counters.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index e3e71843401a..f98cc5b9bebc 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1175,6 +1175,30 @@ static __init int snc_get_config(void)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * Counter bitmap for tracking the available counters.
>> + * 'mbm_cntr_assign' mode provides set of hardware counters for assigning
>> + * RMID, event pair. Each RMID and event pair takes one hardware counter.
> 
> (soft-ABMC may need to edit this comment)

Agree..

> 
>> + * Kernel needs to keep track of the number of available counters.
> 
> Last sentence seems to be duplicate of the first?

Will remove it.

> 
>> + */
>> +static int mbm_cntrs_init(struct rdt_resource *r)
> 
> Needs __init?

Did you mean to merge this with dom_data_init and don't have to have a
separate function. Please clarify.


> 
>> +{
>> +	if (r->mon.mbm_cntr_assignable) {
>> +		r->mon.mbm_cntr_free_map = bitmap_zalloc(r->mon.num_mbm_cntrs,
>> +							 GFP_KERNEL);
>> +		if (!r->mon.mbm_cntr_free_map)
>> +			return -ENOMEM;
>> +		bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void __exit mbm_cntrs_exit(struct rdt_resource *r)
>> +{
>> +	if (r->mon.mbm_cntr_assignable)
>> +		bitmap_free(r->mon.mbm_cntr_free_map);
>> +}
>> +
>>  int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  {
>>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>> @@ -1240,6 +1264,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  		}
>>  	}
>>  
>> +	ret = mbm_cntrs_init(r);
>> +	if (ret)
>> +		return ret;
> 
> Missing cleanup of earlier allocation on error path here. Even so, this does not
> seem to integrate with existing dom_data_init() wrt ordering and locking. Could
> this be more fitting when merged with dom_data_init() (after moving it)?

Sure. Will do.

> 
>> +
>>  	l3_mon_evt_init(r);
>>  
>>  	r->mon_capable = true;
>> @@ -1247,9 +1275,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	return 0;
>>  }
>>  
>> -void __exit rdt_put_mon_l3_config(void)
>> +void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
>>  {
>>  	dom_data_exit();
>> +	mbm_cntrs_exit(r);
> 
> There is a mismatch wrt locking used in dom_data_exit() and mbm_cntrs_exit() that is
> sure to cause confusion and difficulty in the MPAM transition.

Will merge this with dom_data_exit.

> 
>>  }
>>  
>>  void __init intel_rdt_mbm_apply_quirk(void)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index ba737890d5c2..a51992984832 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -185,6 +185,25 @@ bool closid_allocated(unsigned int closid)
>>  	return !test_bit(closid, &closid_free_map);
>>  }
>>  
>> +int mbm_cntr_alloc(struct rdt_resource *r)
>> +{
>> +	int cntr_id;
>> +
>> +	cntr_id = find_first_bit(r->mon.mbm_cntr_free_map,
>> +				 r->mon.num_mbm_cntrs);
>> +	if (cntr_id >= r->mon.num_mbm_cntrs)
>> +		return -ENOSPC;
>> +
>> +	__clear_bit(cntr_id, r->mon.mbm_cntr_free_map);
>> +
>> +	return cntr_id;
>> +}
>> +
>> +void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id)
>> +{
>> +	__set_bit(cntr_id, r->mon.mbm_cntr_free_map);
>> +}
>> +
>>  /**
>>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>   * @closid: closid if the resource group
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index f11d6fdfd977..aab22ff8e0c1 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -187,12 +187,14 @@ enum resctrl_scope {
>>   * @num_rmid:		Number of RMIDs available
>>   * @num_mbm_cntrs:	Number of assignable monitoring counters
>>   * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
>> + * @mbm_cntr_free_map:	bitmap of number of assignable MBM counters
> 
> The "number of" is not clear ... it seems to indicate tracking a count? How about
> just "bitmap of free MBM counters"

Sure.

> 
>>   * @evt_list:		List of monitoring events
>>   */
>>  struct resctrl_mon {
>>  	int			num_rmid;
>>  	int			num_mbm_cntrs;
>>  	bool			mbm_cntr_assignable;
>> +	unsigned long		*mbm_cntr_free_map;
>>  	struct list_head	evt_list;
>>  };
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger

