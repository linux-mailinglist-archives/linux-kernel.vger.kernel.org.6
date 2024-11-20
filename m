Return-Path: <linux-kernel+bounces-416185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 368B39D41CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E082B257DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4B158533;
	Wed, 20 Nov 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pak06uil"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8C14AD2B;
	Wed, 20 Nov 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125930; cv=fail; b=R8gHdyiO2MWKDD5A8PlPns6X7fSrsYOjUkQIYyEObscHsOz+IvOwA2k7/ydXjmjJAZMyYHYW46YYI6AnS2OABGHLndk9vG2c/Zd6um9U0o24ddK8696ZhCoXW7a3tvTVF0Oqv2fAwfLEhUJnDsfIIHnjcfYmAMAfFDpkeGt3+ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125930; c=relaxed/simple;
	bh=n1pFxnGH66mdEotrhE/etR0b5IOhO8a+MKuojEJpf1w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Re3l9li0Y9tGcd5QBcTRyyF1N6DUx7ZgDOHq3IsMiDUU+UtAWQvNuMnwaVFKAqQhXNNw0Iuo6qrEdjZf722A0KJyDqOEpC6DmzuuHO1e8gZg2PXHaWnfxkGVPxEHXK3UlA966cIfYQkInge4Bf6ZTe3L1vVsOFxgNpn6Umc2n3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pak06uil; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKc/9vXbwMosjMvS2fHbqh3uYOIvUhaK7cnn/KMy8jRVlGpVprPXvQi4ENlQzLb+zFN0/bWL0llsDPUcZVgr5R5AhaAuoAAJYGnQsCm2doMfpOMbDj6E0mMxC9TRFBfof+S1d6kFfZ9ayqSg1XBOCRwhe46/eotzsLovN9v1VDbCzkhno2i4wB976wzF64bKRIQ+UJ+ndenjjfSfThsysJcx8TeFloJQjaI1wntJMfGoZ1nV8Z2NLoed1zJMtVFm2kRc8Oe2bsXMUIfBPi9pz8mkXfWOgf12JbuoprTTZkwfcrI9kFvAEW3MBfs0RoI+b/H0wCVfWMN9qpY61iKzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B32OM5aVvcV3/0uLflJFFPmSVUVDAhFk94Xx80x0w7w=;
 b=XL3iT9LNhK+fmEJhuYF+h7epTVZXaJjT/ibuRO33lfhrtP+F/QEofZJQCpPLF0p3hrCVB37gSpe0QXRs1G4Woha1CjMoHH6zJNp/mbFXU70BFXg/+xVdITlm0TsDAcAsA9w2YmLCWC1E8aAq6yBKyVjI7AqXCssj2yVGIBnMZhTy2g9PGecBg6XdtgAZ4vIqARXlLddEk6c+EKimhyiPLhlYbpNklsuAIV6l3DBJCR3VaXM6N2j2JA5DTSbl5K8szJ6qFu963lTfFiL6DzMijsjHrzOZ5N9/EILI+9ikVSY3PBIgLmCG+b39QPQaOd5AMlcJ/COOXuYDNLCHk26eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B32OM5aVvcV3/0uLflJFFPmSVUVDAhFk94Xx80x0w7w=;
 b=Pak06uilohzUhTE6J+njqPFpeOxvXcsNZ0JNbifeIhPzdtx2rObhv12wv6O9b7XNTNvUBNfbuN8hGjnEY3yYc33jZu227XVi1WDAs1c/f0icRD060IgpFE0M2chqUq44btLjWg9HTcFhKZt4dHcj9/wHWneGjix8+3ZbHb1Dakc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 18:05:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 18:05:17 +0000
Message-ID: <77f808e3-1dea-4a85-b574-dcdcb03697f9@amd.com>
Date: Wed, 20 Nov 2024 12:05:13 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update
 counter assignment
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
 <1757cedb-e5b8-45fa-9b70-4c78b5770624@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1757cedb-e5b8-45fa-9b70-4c78b5770624@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ddae82-e65b-4397-db23-08dd098de3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVJRTEZWdmVncmQ0WjN0aHJoYnpGQnJYTzkzSHVsYStUNE51YzR2R21wNXhG?=
 =?utf-8?B?Yzd4dDljTnNtL1NiUlo3dG02K0ZxUHkwc1FhUnlvMWtLUndFVkY2Z2t2THRk?=
 =?utf-8?B?aFArRm9EV0R5ZUVZdTc4LzI5bnk2Sng0YnE2SWlmaEplR3B6NGtUTXAzSWJ1?=
 =?utf-8?B?KzRYMzdOd21YVzNxVW9zOXdNTmxrMm4zSjlHeEoxUjU5eElRUithb25VWWZ6?=
 =?utf-8?B?b0ovU3hDRUdPTTZ3aThOWHRoN2V3VzdQbTc5RGZGTUM4eXdZdERVdmZ1RnFO?=
 =?utf-8?B?SGtRTkkwT2ZENGtQaDNoV3IrejU2Yi9XZlpOVEZobW9rREtmQmVqY0JwdHkz?=
 =?utf-8?B?TzdUWGc4ZlFrcllwQitjekhqU01lYlQ2MWs1YXc3R09SVlplVExOeHNQRWxu?=
 =?utf-8?B?blBaMFc0UVpsTUhJWG1SYS8yMHVlRlVBQTZHYTZYWGxXQXFrVGw5OWRCTFN6?=
 =?utf-8?B?Y21SVEFkK3l1aW9aR3RtV0R6d3A5bG9nM0VSdWZMUXFDT1VBdFREYVlmOHRJ?=
 =?utf-8?B?RXE1V3dIUEJtZ1N2Sm0vemVPU0tTSHZkb1lydy9LRU5aTGsvbmVxRWViTUZh?=
 =?utf-8?B?TVJwa2ltMk4vUUpWdmxNVkdHdjBaQmpnUzFaaHJwOHZaL05MZ2JJak5VSzFL?=
 =?utf-8?B?b1JCaTk3UkJXTXM3L1lhc21QTm5icnZST2E3ZVQ4UVFwV1prSkwwWVpsVVV4?=
 =?utf-8?B?eFJ5Rnk3dmVZa3F4TDRLekRJUVBsVVNTT0dSdkJ4anZMV2Z3STZQZlhVVVRZ?=
 =?utf-8?B?WFRHV0M4ZGtWNkNoc2VRMFA1dTJVdVJpU251blFoWmxQbXNEVnlDQ24rcTYv?=
 =?utf-8?B?aXQ1cTRsS00yZThKUVlGQ1A0L3lVYjB4VjFoeEF6VHg4UWwvZGxyeWhHZGV2?=
 =?utf-8?B?S211UVVkYVByU1JtTW5iWlQra2xHaDR0L0xJV01TM0s1d3IrSktOUStibDlx?=
 =?utf-8?B?bEpITTBqQ0FPTTZ1bGtaeHdHN2F1cFhSdDZ5bVQ4aVBjSE5JQWFXTllxbUo1?=
 =?utf-8?B?bjBaSUV3YjJqYkU1ZEJrQ2kwTFV3eE9GbjVtMVVtemlzZG9WR21WREk0elI4?=
 =?utf-8?B?aFljbkNGZ2QvMG5RZGFxWjdPOEVMS3BPWmxDaFk4RzRxdFBiZ1B5bjJINVIw?=
 =?utf-8?B?Qkc5Vi9HRllmT0dlUm5GZ2s3V3lGN0hub0t0ZDhabzUrZ1JmRU45UEdIaXlw?=
 =?utf-8?B?NDhqL2NTbkVaSlk4a3Q2VFVrSjhWTTJ0eDY1K3RpWFQ0dVFIUWJvay9zMTdO?=
 =?utf-8?B?eElhQWo0UTNyV1YwZjNHbU52dVdhVkFzTEdIWU0xQWFwMjA2M1lkTldOeFhX?=
 =?utf-8?B?cEpoWThLSzVOQjY3OXRUT0U3VFp6UmdMcnhXN21hVk9UMVE1SW16RzVBZFRS?=
 =?utf-8?B?UjRsZ3kxQkdiOFhOem5INk1PZVpFeGxBWmU0bGpsdHZvSFZMSWZaN2VuSTRv?=
 =?utf-8?B?UTJ0RHdoZHhBRlFwQUhXQ2tDTlcva1pNKzFleFZLcUNBeHlzK0d0dG9LYzVt?=
 =?utf-8?B?RnJYajRFeTlrTHIvUWxJM281bHlxSHBRaTIrYWZtMEQ3VGd0TmRoa3o1RjZ4?=
 =?utf-8?B?Wm1rbHhjK1E4Y2FmdVNvV2Q2RzZqUFc0WEpyaE9SOU9WNy9VdlJQYWZkeUNP?=
 =?utf-8?B?NVZZQUhYbjlMTS8wUVU1S1Z1OTFoMGE3UkdKV0o2NUdKaFgwOTM5bjFaZHUy?=
 =?utf-8?Q?aA4G+DFvozmeqNTpkLk+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkttYStYUDB5ZTV3WGZTRGxQeXFvcklYV3VvRDVMeUJDV2NxWUlvWG9EdDFG?=
 =?utf-8?B?Z3pMcXlUOU9WV01iRkhaQ2dBdlZlSG93L1RpY1lOYUdFRHNSZU9ZWnVLYk5D?=
 =?utf-8?B?K1c4K28zS242VnVyMDcydWVmOUs3ZE03enl0WWpYVTBnSkZGZk5JVXZWV3U4?=
 =?utf-8?B?TzVGQWowVkxkNW16b05td1Bmd2RmV0hoUDF2RGN2a3BIcTlGMmt0RXhPZFhn?=
 =?utf-8?B?QWpjWWZQZ3pMb1dYZWw0WEJBTnBuUHRkaFVDN3NFMFJLaDVIQ1NaLzZON0FL?=
 =?utf-8?B?Q0JtOVoxZERvS3VUSktZTUkra0NLSS9ScWJsNFIyQlRNckdpOUdETERzMU1B?=
 =?utf-8?B?S1pQSWFvNGRzRCtucDhoTU03Y05ndlhhby9INFZaTlFvV0w3L2JnTEEzMlNR?=
 =?utf-8?B?QmdnZ3lZSmdxK0tJczM0YzA2cEYxcVR0d092Y2hSQy9RbGIveU56ZkRBRVpT?=
 =?utf-8?B?bFVwWVNwT0NicGJmMHJ6dUx1SDdLV01ZVVBxWXBNU25tNytsMi9XdEhRTWJM?=
 =?utf-8?B?anFCcGx6TXBWdGhWdXBFbmJlN09uSDdqOGNKWGlZajJ1YW9DY056UDlSN3VJ?=
 =?utf-8?B?M1R4RTFVVDF0SE5KeFBjTWk1YXBnMlQwQ3A4YlRjTVFYaEtZQUJYWjk1N0lm?=
 =?utf-8?B?K2R0MENTcW9HS2c4VnE0K2ZVU2RpQTZGbHhleCtmUEJMTEFIdHB5dlFBck43?=
 =?utf-8?B?U0plaXd4SndsN3g3YjZVMmxSQ09lamQwWFc2WnVkR2JCWW5uM2NZNGhubUpK?=
 =?utf-8?B?WURiaDJSeHpuNWs1cmJscWNvSW03MlVaQ3RaazZKbjd6WWpjRkNYaU0zMWVO?=
 =?utf-8?B?b1VWNzFUWGVoSThRaWx1djZQYU9sbDBhbjhJVHRFRVYzek1oU0VobnJocFBX?=
 =?utf-8?B?aUphcUZEUXhBN1JyeS9IQlJyY0NkNXlBMkE4WlJwRzVCTVV2b2VDUkdsLy9Q?=
 =?utf-8?B?elV4c2twZ0RzQ1ltUG9QR3orYzFaU2J5KzFKWTV3RDFNWC9QZFVyZjE2SElF?=
 =?utf-8?B?Zk1IKzZPamh2MCt4OTFseS83OUxZdkhNUWphb0tvcnRqZjQzM1pYcDUyODNT?=
 =?utf-8?B?cys1Z1JyWVBRYk4xTVdXaGpNa1NBL21mdE1Fa2NxdXozM08wQmtqa3NkM09T?=
 =?utf-8?B?dW5DMU0zclYyQnZ3RVJlb0p2Yno3d3NnYjMrRG5mTWtmWWRyLy9zUC9Wd2R0?=
 =?utf-8?B?cUVMZExLRHFwMGdOcEwyek1UdDN1eVJzVWlaeklhYksvZC9CUDNpbERLT0xM?=
 =?utf-8?B?YXVIL3pYY0NwYktaYVM0THJHNnBBK0dzK1JiclpMc0ZLUmZOZXBrNDViekJz?=
 =?utf-8?B?V2hXenVTUUdXbVRsSXM4dGl5ZWlqS1ZGc1hQZWZva0J5SHRVaVZxL3ZrR0FX?=
 =?utf-8?B?VGN5UGNybmdpcEgyeHp4aW84Z2JaK1VzRGxtMlBoSThDeWMrR2xGRFRZTW9N?=
 =?utf-8?B?SWVjR0lhY05pZFQrSjduYVJSZ0RmNzd6Y2M4bVMweE4rc25PNUpDWVh3bjZM?=
 =?utf-8?B?eVNqRklzTUpNZElscUo3L05DM3FTUHFpQjZyd3NSWGV1V3RDWTVVSWxnaFdq?=
 =?utf-8?B?VGRhczN3L2tONDVrenVaK1pIQTRLbFZoa3VmSFFVdVdaOVBlWHFJN0xxd05o?=
 =?utf-8?B?Mlc5MTBBRU9Lb0lHWXkrZ3V5RzBNOVdYQVMzK2VHL0hUWTE4WW9jMlhKdU1o?=
 =?utf-8?B?MGtnUCtwbnFLd2svTW03Z1EvTVFvcE1Xc3o3RnRKNWJlRWpFL3hEVE5mYmhK?=
 =?utf-8?B?NkF0RThxVmErMzdkZ2hFWk5QTzBLU01ZdGFJWmFCbFZQQzZZVzNkMmRtNkc4?=
 =?utf-8?B?VEVycVpXZVd6QnhNbVdRd1U0NDNXY092UWErakI4YnFLZ2RKejNKR0FPT1N0?=
 =?utf-8?B?YnlUamFqYmUzdHJMVmdOdFNhVTFNd3MvSnpLV2lwbW41dnQxMG1OQ21heEwr?=
 =?utf-8?B?OVpqOVNMUU5hUHpHQThrR2xZa3VNVmhnQThnNVlQdlQ4V1ZhR3U2M2lrOWhi?=
 =?utf-8?B?dG5HaFZKS2liamx0Z2RaM2lWM0VjdWhsSEQ2QXY4UFh3OCs5VmY1RWtDVXBy?=
 =?utf-8?B?eHRUMFdZNTNFRURXeHE4WkJTemNsSjkxSThOTEZPdkhsTHBRTXVuaGZSMTVF?=
 =?utf-8?Q?0RXU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ddae82-e65b-4397-db23-08dd098de3b8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:05:17.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tp2s/HGzsfnYBa5qI5juJ9f58gC5ILxnHfNv50R3A03PgogEFt327kaalYTG5hgq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

Hi Reinette,

On 11/15/24 18:57, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> The mbm_cntr_assign mode offers several hardware counters that can be
>> assigned to an RMID, event pair and monitor the bandwidth as long as it
>> is assigned.
>>
>> Counters are managed at two levels. The global assignment is tracked
>> using the mbm_cntr_free_map field in the struct resctrl_mon, while
>> domain-specific assignments are tracked using the mbm_cntr_map field
>> in the struct rdt_mon_domain. Allocation begins at the global level
>> and is then applied individually to each domain.
>>
>> Introduce an interface to allocate these counters and update the
>> corresponding domains accordingly.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 00f7bf60e16a..cb496bd97007 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>>  int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>  			     u32 cntr_id, bool assign);
>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>  void rdt_staged_configs_clear(void);
>>  bool closid_allocated(unsigned int closid);
>>  int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1b5529c212f5..bc3752967c44 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Configure the counter for the event, RMID pair for the domain.
>> + * Update the bitmap and reset the architectural state.
>> + */
>> +static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			       enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +			       u32 cntr_id, bool assign)
>> +{
>> +	int ret;
>> +
>> +	ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (assign)
>> +		__set_bit(cntr_id, d->mbm_cntr_map);
>> +	else
>> +		__clear_bit(cntr_id, d->mbm_cntr_map);
>> +
>> +	/*
>> +	 * Reset the architectural state so that reading of hardware
>> +	 * counter is not considered as an overflow in next update.
>> +	 */
>> +	resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
> 
> resctrl_arch_reset_rmid() expects to be run on a CPU that is in the domain
> @d ... note that after the architectural state is reset it initializes the
> state by reading the event on the current CPU. By running it here it is
> run on a random CPU that may not be in the right domain.

Yes. That is correct.  We can move this part to our earlier
implementation. We dont need to read the RMID.  We just have to reset the
counter.

https://lore.kernel.org/lkml/16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com/

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9fe419d0c536..bc3654ec3a08 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2371,6 +2371,13 @@ int resctrl_arch_config_cntr(struct rdt_resource
*r, struct rdt_mon_domain *d,
        smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
                              &abmc_cfg, 1);

+       /*
+        * Reset the architectural state so that reading of hardware
+        * counter is not considered as an overflow in next update.
+        */
+       if (arch_mbm)
+               memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
+
        return 0;
 }


> 
>> +
>> +	return ret;
>> +}
>> +
>> +static bool mbm_cntr_assigned_to_domain(struct rdt_resource *r, u32 cntr_id)
>> +{
>> +	struct rdt_mon_domain *d;
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
>> +		if (test_bit(cntr_id, d->mbm_cntr_map))
>> +			return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Assign a hardware counter to event @evtid of group @rdtgrp.
>> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
>> + * else the counter will be assigned to specific domain.
>> + */
>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>> +{
>> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +	int cntr_id = rdtgrp->mon.cntr_id[index];
>> +	int ret;
>> +
>> +	/*
>> +	 * Allocate a new counter id to the event if the counter is not
>> +	 * assigned already.
>> +	 */
>> +	if (cntr_id == MON_CNTR_UNSET) {
>> +		cntr_id = mbm_cntr_alloc(r);
>> +		if (cntr_id < 0) {
>> +			rdt_last_cmd_puts("Out of MBM assignable counters\n");
>> +			return -ENOSPC;
>> +		}
>> +		rdtgrp->mon.cntr_id[index] = cntr_id;
>> +	}
>> +
>> +	if (!d) {
>> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +						  rdtgrp->closid, cntr_id, true);
>> +			if (ret)
>> +				goto out_done_assign;
> 
> This may not be what users expect. What if, for example, domain #1 has a counter
> assigned to "total" event and then user wants to change that to 
> assign a counter to "total" event of all domains. Would this not reconfigure the
> counter associated with domain #1 and unnecessarily reset it? Could this be
> made a bit smarter to only configure a counter on a domain if it is not already
> configured? This could perhaps form part of resctrl_config_cntr() to not scatter
> the duplicate check everywhere. What do you think?

Yes. that is correct. We can add a check in resctrl_config_cntr().

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9fe419d0c536..bc3654ec3a08 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

@@ -2384,6 +2391,10 @@ static int resctrl_config_cntr(struct rdt_resource
*r, struct rdt_mon_domain *d,
 {
        int ret;

+       /* Return success if the domain is in expected assign state already */
+       if (assign == test_bit(cntr_id, d->mbm_cntr_map))
+               return 0;
+
        ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id,
assign);
        if (ret)
                return ret;


> 
> Also, looks like this can do partial assignment. For example, if one of the
> domains encounter a failure then domains already configured are not undone. This
> matches other similar flows but is not documented and left to reader to decipher. 

I will add the text in patch 26
(x86/resctrl: Introduce interface to modify assignment states of the groups).

> 
> 
>> +		}
>> +	} else {
>> +		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +					  rdtgrp->closid, cntr_id, true);
> 
> Looking at flows calling rdtgroup_assign_cntr_event() I do not see a check
> if counter is already assigned. So, if a user makes a loop of assigning a counter
> to the same event over and over it will result in an IPI every time. This seems
> unnecessary, what do you think?

This will be taken care by the above check in resctrl_config_cntr().

> 
>> +		if (ret)
>> +			goto out_done_assign;
>> +	}
>> +
>> +out_done_assign:
>> +	if (ret && !mbm_cntr_assigned_to_domain(r, cntr_id)) {
>> +		mbm_cntr_free(r, cntr_id);
>> +		rdtgroup_cntr_id_init(rdtgrp, evtid);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

