Return-Path: <linux-kernel+bounces-526537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0FA3FFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83312189F44F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A512252919;
	Fri, 21 Feb 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1EOHL2Ci"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30525333C;
	Fri, 21 Feb 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167069; cv=fail; b=FmzHaqpIydw77h83Jz9Bx0fdxkTxq4OOq5TEXeeyMoa4u2YMcbo3Fg98B/IUoYDjiLimBFQCcLjS0QBvHukpcQC6h6i/5qrlxpryhdf6NLzOm31MyUbMKNYqTOGGXRABBDgWae9Ma/dPlC0JpiZK6jGfxBXeL+ch12YfIhLLr50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167069; c=relaxed/simple;
	bh=1fCeyT2b1naJOAyUJ6IqOMcYSpoXo+K0rKnQIHvppY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ICXNhfaHLJlR73IHgU6xdPFgtGUdjwjZf5+laF4RQFnbeDoBnBJRdGf4viIbEDIKchI4dwCSjRHS6vL/AImPQRSsS8RTlVBb9UzCaqrHT12Sm60afx3Uzf5PyStY/LkvaFMEYz/xxNQ96H1yHdPaWRScOr9v2eZzmFhv7zghj5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1EOHL2Ci; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USFj/2TzADhyh7zJeoAITmIYXm8d0Ogozlrx2yAneJlGK+g+yxgIXQqQ01NQFJvOiGhaDUcdppYI0dlr09Bo4t91eB77LomCxYmqF3zyBwgeGjCDvFmjpoQVipUmc4Abmmw7YEwQ2CdaBhNwhvqwvCi6XdXRcnlLf5ZGlUD2xl10BVRKtPYzXpweDncQgStpj+mv5Eyv5d6BreM3E+naW9niro1M7QPC3tVmDQJSH972kt6mv/xRAfW4hP3n9rcaukpSXQO3kYVugb9XII0lfycY6Z9bBNSTWPrUmoDYyWai71Indk3CARtHYIRA1kJlqPFCgmNIsQzlfhx8QIV+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kwjiuvOWe2+AiRqx1lRD7HOV/kOD4HCUmwZFxoAiws=;
 b=TVaQY7c40Z3DNY5geOQ1UTu+692p/WD+vUr0gyFW09bKGSs44Vw3Ub+WHAkZN+gndC7xflZHHRtA5rcq94Rzs7oR/WfXky47mXuVSQ4MVFteOqBVLCHSSFuvmhNqH/MQ/FYYvTSbVlu7nrA0FJupER/1wEWd+hxJyipXnLzLdWTG0SFWzwFCoM9SeCNOeFyUjYa3OTxm4l/HXhLX6tkeAz8sWZQJkK935DStFOhVRfe1ZqRngXiyCQMKbqm5rdL/SyCi4dc531Wa6/t4xx9DaRgbXe/z1yzpx9T1vSmrmdXZGf9pI9nXWZHsS3fdUwqhF0vZE6661Rp7FjS2Rl3Vbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kwjiuvOWe2+AiRqx1lRD7HOV/kOD4HCUmwZFxoAiws=;
 b=1EOHL2CinVuhFPnjrpgcSl0nnJSjFL9Vn0WGhR7JuHkgCelb0xPGOW9f/ZagdtftGarnspbj4+irwyx5d3J8/EB/8Y8DgLA9limbJLYEAU/7p6+zaletdIitMxKar8uAxOTNdw0QUCX7MDki1VfHW3bnbEKEcFPiFi/pIrx2q04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 19:44:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 19:44:24 +0000
Message-ID: <226388e2-deb7-4a1a-a648-eb1e0cfb18e2@amd.com>
Date: Fri, 21 Feb 2025 13:44:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/23] x86/resctrl: Introduce the interface to display
 monitor mode
To: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <b298391d4db5806c145ba0b92d79e02a4df8d8c5.1737577229.git.babu.moger@amd.com>
 <5b6cfa6e-9f2f-4d84-9b63-14386a2fa3dc@arm.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <5b6cfa6e-9f2f-4d84-9b63-14386a2fa3dc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 527caf00-0134-4986-3944-08dd52b024ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjU5K3RqYW9Da1FmRXd0U0dkdjFVeEJ5dEpiQnBEN0dTRGFaamRSZ29XbnFZ?=
 =?utf-8?B?ZDBuNU96SE9qVDhJL1ROWjQzaDY0dmR4ZGhzNXlvQkhNMHJUK2R5dEhuQlcv?=
 =?utf-8?B?ZEVvVVgyMlM1Y2hhaXIwVk9iTTE3WFdicXZDWWNiWnVWNURMamlwL0V4M0k1?=
 =?utf-8?B?QUx2YW40UlVENUlsK2dsUXN6K0UrVCtTa1RFL0tBU1V0allxcjl6Tm9LcC92?=
 =?utf-8?B?YkhBbWpvMUZtSmh3OWJQbS85SXo2NXladDJPc2VUcWJpRFQvWEdnOWJ5Ui94?=
 =?utf-8?B?UnN5YUFSa2pOZVc0QmlpMlNWeWIxamxYc3ZKWVRueU1jMDJTamhaTEZjMVEv?=
 =?utf-8?B?RDBmdVl4dVlrRVArME84dTRRN0F4R2UrSy9oR2dPOUNuSTRwcXE5ZzQrZzNR?=
 =?utf-8?B?TkZYRmxyM1RCakNLZis2bkNiRll3MHdxZFFoVUZ1RThTQmkxSXZGTG02VkZQ?=
 =?utf-8?B?alVFcHFLbjdmN2d5M211L0FWS3ViVCtpNW1iU0pGalJaSE94dGFjUmhyWVJ1?=
 =?utf-8?B?RkNnVFpKLzdXY3FBcnY5MGVzVVlwNnJDakxaa3oxbm9PSkNCWjRwQ0RhZ2xB?=
 =?utf-8?B?SitXY0U0MUROOTB4cFNhd015R1R5eXpjM1gwcWFrVlRTUGFYQys5Wi96SzR1?=
 =?utf-8?B?U09FYXF5K1ZsWTJYaU9uUlhaU1NxQXVQSG9QTG82ZVFtc0NNRDJMT1VFV0VH?=
 =?utf-8?B?WGxYR2x1UTVOTVI2N2s4dVgxWFlsRStqalllT2VtTks3aHdXenIrbk5ZYUZn?=
 =?utf-8?B?TXU0RUc1ZWh1eHJjdTZpb1VpYVVtWWQzUkhzM2pCZ2Z0SU5pZmFlUmlrdzht?=
 =?utf-8?B?aTZRMThGWUxnQkxDcEYzWklsamxiNmU4NFJELzZkTk1sNFhwTTB1QVdZVERi?=
 =?utf-8?B?MFMxWkZ3RjF3Q2F5UHpqNEh0TDRpdnBaVUNKZ29UYVJOcWJ4a3RFZFY4Rjl1?=
 =?utf-8?B?NHRtMWFuZlJsV0ZmTlo5d25ZQ0NHcGNNZGNwck92QU9iM3RKTU1CRGliMWhm?=
 =?utf-8?B?d2JuWkd1MjZxVk44NG5iWkJsMFhHS0VHMC9TYlZBRVVHdGlWQkNEbEY0eUpV?=
 =?utf-8?B?L0d4dW1uUEJoaW9tTTVNakw1a0NrYlRvZnNhOXY3NjJPVWFIRmo3c3NCdDZ1?=
 =?utf-8?B?VFNUMVBxME1ML2hkWXFCaDhZU1VxTUJUOGhmMWY5UHRwS2hUbTZrbE9FOWJX?=
 =?utf-8?B?WUZlNG51Z0ZEZVB4d1IwSzZxSUljL0pxdmpEMU1ONURlbWR3MC9QSENFNHhz?=
 =?utf-8?B?NEg2ZVZnYkdVOGtNRzhMd2JweStRaHNaRHVDWEdibW5PVDlzQjJKZURYclpO?=
 =?utf-8?B?VzlhY3QzT1dzZ0hxTk41MVBwaXVyWlJyczllakk1Y3VnVmdWNnJrUW40clBu?=
 =?utf-8?B?c3BMbmlYdUdWYzdDRHUvTzljaUpUc1YzL0JhZHlLSVFnczM3NTZ0RUFES0Iw?=
 =?utf-8?B?TkoxOEc4eDZ1K25HQm9NTFBRNkp1TzhNVHpMWHZKWm9oZVVWSjlDMDdqYi9r?=
 =?utf-8?B?NnVhU1R2Mi9pYUJqeGMyUW5xSkpmRGFleWNFUnYyd1h3VzY0MXllWlVYQkxK?=
 =?utf-8?B?SmZOZ0dOR0kvUkoxMWFJU2hrVmpHSkNTN2N3MkZma2NQQkdNNjZkVys2aFF3?=
 =?utf-8?B?T213ZE9OT1RDS1o2ckYrZTU0b2o0WUFLTG1YQ2xHVnYxSzcvVkQvSmlYWjlM?=
 =?utf-8?B?VXkvWFZHelpxVy9hRnJ1aEFEaUhXM0dQWlVXd0IvU0dwWU40UW9IU1hTakdO?=
 =?utf-8?B?SnZPNUV0cktUT3dtc0djRy9ZaWRMdTMvNGtXQUZKRzdUOWhNRnFFSng2NE82?=
 =?utf-8?B?Qlc4Q3BJOW50ODhLblVXTnVyRkF0TUpYSTh1Y3N2KzExbEdkL1AvQ2k5ZTh2?=
 =?utf-8?B?cmVGV1lPUENkbk1Mc2VkVTZFTjNvTjhCMWJ5WWluOVNTNFUrWUsvSXRsNkRR?=
 =?utf-8?Q?K43x/sudcRc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWcybHBYYnU1V0pwUERvaVRHOTQ1MUxTNFRCRk8veG42WDZGOFhvMGRrNXgz?=
 =?utf-8?B?MWVSQWxMTTB1WVdvNUNVWmZ5cDRpcnNYZ1BQeHMzY0oyZ2VQTU0zU0hVWUZU?=
 =?utf-8?B?VFFqNjk1bHhEMkpjeG0xRG8vSjBpTUFQRjcwdHVHT0pWTHNBVStmTnh0L1pk?=
 =?utf-8?B?azBoNkdyd2xzeUMwWUNGZzJ0QWpxcnZjK1Jac2pQaFhzbEttZitUYWlKVTdI?=
 =?utf-8?B?OUFlaGVrZlV6bFVJR2dWcUtSSmhjVzQwSjQzbnYzeTg2bG1tZytXcXlRdFcz?=
 =?utf-8?B?WWhUcVV3K3oyV2tkOFBoRmhPOFg4OG9qaHNhNmV6aEZrSkRqOVRkSUZ3RDBM?=
 =?utf-8?B?b2JXMzJPcEdsMUs0QjRzN3NyU0tlZEtaMDlTamVaNlVTZDhzUnFJd1AxbmE3?=
 =?utf-8?B?MzJtRnNFTlhmd2Z5ZTFrb25pT3lOa21iR2ErUVNTdHNTdHBiSGxLQzNDelBQ?=
 =?utf-8?B?QnVBQkJJT2FhRHIvR3FIK1VSbnJRRkQ2UGJwaFJYVDdYcnpGTHJBellUR25U?=
 =?utf-8?B?eUF1U3BWdnFuaFl6SlJUNys3U1h0RkViSko4UHBXT25TR2U2MkFFbE05Uy85?=
 =?utf-8?B?RDdHN1lsMXZzclpYSHRuUU1Xa1dRZFRhUURnTk0raURBWVMrQjBmNDlIMFRY?=
 =?utf-8?B?RUJSakR0QXVGZy9TWU9YcjV6UGdLOUtDSUhWSlg3eFNNZ0twbURoZzIxVEhv?=
 =?utf-8?B?bloxUTlNUWpUTXh0MTJUY3FMeGIyZzJMdGlPeXpKOTFCM25ZNDlDdHgzTU1Q?=
 =?utf-8?B?SjVvSzROdldYTC80SUx5L2NTTHVCRWxWL0dDZFJaYWdudU1NZk9hU2FQMmw0?=
 =?utf-8?B?TW40VWp5cXg0bFB1Yks5VThmL1pYZWhBSUNDeVIxcmZ2SDdSZENCZ09iRUZZ?=
 =?utf-8?B?RlJoZXNIc1FvN01Lclo0eTdTcERsZ2RlYmRyekpQTmdxSS95aDUzMkpnYVNR?=
 =?utf-8?B?ODM0VjVIQUcvOEV4YjRlM2VnemtFT1dZOGhWR1RnOGhuQXRsTlVMeVNzaHFx?=
 =?utf-8?B?MlBTSEtEQ2dxTHlmNVFBMzNXRkxvcDYxOFV5WndoWWxuNjM4ME4zWFgvYUVj?=
 =?utf-8?B?WHpTZ3VzdWl1aVZtaXZsamxyb2pjWjRnMkhLSkhDSGVIMGdPYlNaekdBcEl4?=
 =?utf-8?B?a2tndkpDTEFBbitabmwrbVVDK08yckx6emcwajV0aDEvUTZQMjNHMzRJcS96?=
 =?utf-8?B?Nnk5aUNDV1FxdCtIOVFqRm1JcU1pWFlicjdNUzdJRU1rVGlPU3d6MkxSN1V0?=
 =?utf-8?B?MlV4bnV0U1hQalBEOTNQVFpGK25CNVMvWU9lRENhWlpZalJzWFBENlZPVlF6?=
 =?utf-8?B?VXpLTTBiL2VHOE1ZenRBaGRFT29ZcEtWd2ZZTWNpcVVMTzhGNkc3RU4vNkM5?=
 =?utf-8?B?SFNTOVg3d2MwRXF6a1c1MG5LWXVxNTE1a2prdC9FNWNFWThCQ25WMk1PWWR4?=
 =?utf-8?B?VmE3MDZuVkR1MmsvTjFPUmt3SHJlWEFrcEVLdE5qVG82REdpK2RqKysxci9z?=
 =?utf-8?B?UFBDeGNQUmNQc2JndWJSUzVXLzBrY1oyQlNlYnlKamRxTUxFcmhWRStZVFAz?=
 =?utf-8?B?YzA0eUc3TjFOZUQreWZpekVUcEVYM2Y3VVFrMTNMb1VXOXFOR08xdy9LT2o3?=
 =?utf-8?B?Z3FEM0EzbUJRUFdvSjAzTVNIV1NmakNua255YnphZzNBMUpoZnFjdG1wcFlP?=
 =?utf-8?B?UFNOVlVFSEkvdjU4MTZVQmIveGlOZm45cnBuN3UraDcyZUxod1o1Y3dpcGRs?=
 =?utf-8?B?ZFZ5VmRvMEM4THFlSlU1aUl0REFGWHVDd2VSWlBMeTVLTVZxeGhUUlVlTHhJ?=
 =?utf-8?B?R1pyNWZRZXkzVk14U3g1WVFEQWFYTkJLK21CSHc1Y09hT25XTjZuMDZpUC9Z?=
 =?utf-8?B?dFdtMVRzREtWNlRjWi9scmJ4TURuVkNVamFDRmVXdFpvV0VIOWxHNHEyajVr?=
 =?utf-8?B?VEJ2TlE5QlV2c2dML3FTTkdwbklZdFprczQ2QkhsdFRTU0NhNW5YaS9GbnR0?=
 =?utf-8?B?R0dmaGRzRlg3a3R1UWxNaVRhUFlSQ3c5cVJzQTVvaHMwMExnY2NUWTlSelE2?=
 =?utf-8?B?bVgrYkFwMEUwamZvaUpDQnp0Z0hYZXhaSjFSWVN1R3RZbHlHQzFlbTc5V3c4?=
 =?utf-8?Q?fvyM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527caf00-0134-4986-3944-08dd52b024ff
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 19:44:24.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlGa1ZEffG/MIzEvRduKS2KzjXK+l6SfoEOlhKn/AH85Pd4m20b0l4QFhFy62y9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876

Hi James,

On 2/21/2025 12:06 PM, James Morse wrote:
> Hi Babu,
> 
> On 22/01/2025 20:20, Babu Moger wrote:
>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>> supported.
>>
>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>
>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>
>> The "default" mode is the existing monitoring mode that works without the
>> explicit counter assignment, instead relying on dynamic counter assignment
>> by hardware that may result in hardware not dedicating a counter resulting
>> in monitoring data reads returning "Unavailable".
>>
>> Provide an interface to display the monitor mode on the system.
>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> [mbm_cntr_assign]
>> default
> 
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index fb90f08e564e..b5defc5bce0e 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,32 @@ with the following files:
>>   	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>   	    0=0x30;1=0x30;3=0x15;4=0x15
>>   
>> +"mbm_assign_mode":
>> +	Reports the list of monitoring modes supported. The enclosed brackets
>> +	indicate which mode is enabled.
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +	  [mbm_cntr_assign]
>> +	  default
>> +
>> +	"mbm_cntr_assign":
>> +
>> +	In mbm_cntr_assign, monitoring event can only accumulate data while
>> +	it is backed by a hardware counter. The user-space is able to specify
>> +	which of the events in CTRL_MON or MON groups should have a counter
>> +	assigned using the "mbm_assign_control" file. The number of counters
>> +	available is described in the "num_mbm_cntrs" file. Changing the mode
>> +	may cause all counters on a resource to reset.
> 
>> +	"default":
>> +
>> +	In default mode, resctrl assumes there is a hardware counter for each
>> +	event within every CTRL_MON and MON group. On AMD platforms, it is
>> +	recommended to use mbm_cntr_assign mode if supported, because reading
>> +	"mbm_total_bytes" or "mbm_local_bytes" will report 'Unavailable' if
>> +	there is no counter associated with that event.
> 
> But if you read a value instead of "Unavailable", that doesn't mean the value is correct.
> For two reads that succeed, the counter may have been reset in the middle.
> 
> I'm suggesting something like:
> | it is recommended to use mbm_cntr_assign mode if supported, to avoid counters
> | being re-allocated by hardware. This can cause a misleading value to be read,
> | or if no counter is associated with that event "Unavailable".
> 
Looks good with slight modification.

On AMD platforms, it is recommended to use the mbm_cntr_assign mode, if 
supported, to prevent the hardware from resetting counters between 
reads. This can result in misleading values or display "Unavailable" if 
no counter is assigned to the event.


> 
>>   "max_threshold_occupancy":
>>   		Read/write file provides the largest value (in
>>   		bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index f91fe605766f..3880480a41d2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -854,6 +854,30 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>   	return ret;
>>   }
>>   
>> +static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>> +					struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	if (r->mon.mbm_cntr_assignable) {
>> +		if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +			seq_puts(s, "[mbm_cntr_assign]\n");
>> +			seq_puts(s, "default\n");
>> +		} else {
>> +			seq_puts(s, "mbm_cntr_assign\n");
>> +			seq_puts(s, "[default]\n");
>> +		}
> 
> What do you think to an architecture being able to opt-out of this flexibility?
> 
> If there aren't enough counters I can expose what the hardware has through this interface
> - but if user-space turns it off ... then what?
> 
> For MPAM this would need to be some best-effort software allocation strategy that I'd
> rather not write - its not a problem that can be solved, and any value that is reported is
> likely to be wrong. For ABMC platforms, existing stable kernels expose a value, so being
> able to preserve the existing behaviour makes sense. MPAM doesn't have this problem.
> 
> Something like this:
> ----------%<----------
> @@ -861,16 +861,21 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open
> _file *of,
>                                          struct seq_file *s, void *v)
>   {
>          struct rdt_resource *r = of->kn->parent->priv;
> +       bool enabled = resctrl_arch_mbm_cntr_assign_enabled(r);
> 
>          mutex_lock(&rdtgroup_mutex);
> 
>          if (r->mon.mbm_cntr_assignable) {
> -               if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +               if (enabled)
>                          seq_puts(s, "[mbm_cntr_assign]\n");
> -                       seq_puts(s, "default\n");
> -               } else {
> -                       seq_puts(s, "mbm_cntr_assign\n");
> +               else
>                          seq_puts(s, "[default]\n");
> +
> +               if (!IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) {
> +                       if (enabled)
> +                               seq_puts(s, "default\n");
> +                       else
> +                               seq_puts(s, "mbm_cntr_assign\n");
>                  }
>          } else {
>                  seq_puts(s, "[default]\n");
> ----------%<----------
> 
> x86 wouldn't define CONFIG_RESCTRL_ASSIGN_FIXED, arm64 would, meaning for MPAM the file
> would be either:
>   | [default]
> or
> | [mbm_cntr_assign]
> 

Looks good mostly.

resctrl_arch_mbm_cntr_assign_enabled(r) needs to be called with the lock.

Also, there is no reference of CONFIG_RESCTRL_ASSIGN_FIXED in this 
series. Hope that is not an issue.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3880480a41d2..2907bb7bfa56 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -858,16 +858,22 @@ static int resctrl_mbm_assign_mode_show(struct 
kernfs_open_file *of,
                                         struct seq_file *s, void *v)
  {
         struct rdt_resource *r = of->kn->parent->priv;
+       bool enabled;

         mutex_lock(&rdtgroup_mutex);
+       enabled = resctrl_arch_mbm_cntr_assign_enabled(r);

         if (r->mon.mbm_cntr_assignable) {
-               if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
+               if (enabled)
                         seq_puts(s, "[mbm_cntr_assign]\n");
-                       seq_puts(s, "default\n");
-               } else {
-                       seq_puts(s, "mbm_cntr_assign\n");
+               else
                         seq_puts(s, "[default]\n");
+
+               if (!IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED)) {
+                       if (enabled)
+                               seq_puts(s, "default\n");
+                       else
+                               seq_puts(s, "mbm_cntr_assign\n");
                 }
         } else {
                 seq_puts(s, "[default]\n");




> 
>> +	} else {
>> +		seq_puts(s, "[default]\n");
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>> +	return 0;
>> +}
> 
> 
> Thanks,
> 
> James
> 

Thanks
Babu

