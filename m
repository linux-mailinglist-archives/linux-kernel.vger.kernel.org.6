Return-Path: <linux-kernel+bounces-183330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6288C97BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F5F1F21C53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909EBA40;
	Mon, 20 May 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l0kqSyXX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A329475
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716170904; cv=fail; b=TZwbUw1mOqLj62+Sxjx8Ep1gYlGhxJ1dexYDS0OmcAlHzVIH2vVCT7A4Xix48PDOiv2ca8khqY9yWBIewBGDiOn7e0CYb8oATsZCxotnhsr59BnWcReFsL1usmZjKqnRj1Yw8VgaWzSXKnHmZtrqUAeL8NvDpU7LBczrhqZUOFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716170904; c=relaxed/simple;
	bh=oFPGQwh9xthbvjKA5VqFH+eMWp9GjLAo2ahDCP+YU5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D4YAREyvfAlHeT5NDqbPWNPsKbFYB4/jxQ8L+PIsxf17OwvdPtb6KWFjPJ3tEFBhS9cRaHsD0+NgyHzog+zHTscTiT2KNA89hyvcHWJSNdRxyEFt3stm/E2aEsSEULVbvQ65Qm1UOybaqEDoAbEnImIlM/DfKX6xdO9vD2mnomk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l0kqSyXX; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmh0aspuTVwvYoqFJW0mAlK7UAlIfyieAzvpSMwD9/KkJLY7snsVdbd5vT8F5NUzloJjbZ4Wi0WJz6txeOhO8Dz+floL5Ke6d8Clv2Kde6+yuyXf3Tz1W+Gi4XLa+CB1EOEQjQZZLCi3zI3GqEeUGpWEoCXFjbC3wUvxzaJv30ZE43bBPdqbRw0uEUj42OZUN4Oxb+pdC26EIbR5PngszZDyBMY+1/pPlRWzyoh4LS1+s8fj7L3tfv9ybktd+I7cPKJNG7rGWwhWiax5A1Mf/Ltg8wOeVMxcZeQ55ry/MiG08y5m3YNPlqs77iELQvfBPYwvsdUKz1wGFsm7ezBuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9ZtX+YMNjQbJ4I23aiHvfPqFHWDWOCcxQu3fG8vz7E=;
 b=JXSLCGGYdx7gXNNQb7e65TpXaSYMT3GwaNSOD7ChIBUWs+vgh8Eep3cSKKU4VYPc2Ge18+xtY12cEIF8cGThNONTkoe5lbqX6Eod0c0MJrwFpp0xsPRRl4IjYi4MK4Kazk8XewlVcOEHn98CCUIGRs2JOmUIp/FvS3MQugrcXXpLps1OCEB4VnkCct93A190UG2DEOHsVnMFY5xUaZuGQjqVLi4UN0bjmq2+HeJQ6dzUI2ACKgFOdBu/A/jyAv001cGuWV30ZSYpZbDGX0Tjd4psktvwaQkrxYJKb0690DF+MeB6P7sQBU+nMxT/n2uvoJFmD4MA26D7UwFb5aigVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9ZtX+YMNjQbJ4I23aiHvfPqFHWDWOCcxQu3fG8vz7E=;
 b=l0kqSyXXenzN1Lw+UmOAhD4rsgyQkWFQAaVdgliJsjSfNZXn0T8A/Ri9GOtSZz2JIzqvjkJwqFtSqdnvg4604vexSFrvIq1yWbLGjyFXYZEJlBvaO32ZnTWQd+8XjemqOWa0mB0u8G0jjNL24Os3Brh5h0zmr7PzSrW7v5f23wmx4aP2jo8zoNpBY6bdXYY6JR+PTLEOQbkxwRLi8wAb0cqNd+0LV59PMBJCTB7GGJbrvdln2TnlshLyH7tokind6iYdUen3dxueG3ok6htoIsSt3kH3ge3T2AiKk3nqvVjFbEeshFzGMRe2LmKtjhqXKEO6FjYqZ/1xU4Lj3FeBiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 20 May
 2024 02:08:18 +0000
Received: from PH7PR12MB7186.namprd12.prod.outlook.com
 ([fe80::515c:f534:ac0f:4775]) by PH7PR12MB7186.namprd12.prod.outlook.com
 ([fe80::515c:f534:ac0f:4775%4]) with mapi id 15.20.7587.025; Mon, 20 May 2024
 02:08:17 +0000
Message-ID: <04079a4c-e5da-4ffb-9527-669abc18d0d9@nvidia.com>
Date: Mon, 20 May 2024 12:08:08 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/paravirt: Ensure calls to pv_op functions are RIP
 relative
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, ajay.kaher@broadcom.com,
 alexey.amakhalov@broadcom.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org
References: <20240517024224.995517-1-jniethe@nvidia.com>
 <20240517100714.GAZkcsUqHxScXJErxP@fat_crate.local>
From: Jordan Niethe <jniethe@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240517100714.GAZkcsUqHxScXJErxP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To PH7PR12MB7186.namprd12.prod.outlook.com
 (2603:10b6:510:202::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7186:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dfb631-eb9c-4501-ad3d-08dc7871b686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clAwaTZzd3lCa3FJalEvRVkzd0dMeU1TNG9FYzVRR1V4REVIS2g3b0tzdGJY?=
 =?utf-8?B?OHczMm9FdGtxdndlMHh1U0tzTXV1K3dBQ1hjNlBsRXdHWTB5aFZGczEza1N6?=
 =?utf-8?B?UEhWODVoTU1pQUNNa2pXZXN4dzg4Y0hmYlpPVFpiMWZXNCs1MFphVG8wSk41?=
 =?utf-8?B?ZmYvdGZWcTFCQ01xbTNIV0hlMHZUd0MxY2p1cGtvZFp4MUVkWlZLc2ljamNK?=
 =?utf-8?B?UFV0Ukw1aGhKSmZBZ2ZvNFlTNVVwenUxcFNWVTM3aEpjWmh4Qm1OYURnZ3VJ?=
 =?utf-8?B?ZXR3N2Y5QnljTmFmcktqTzN5cGJXdmsyMEdxSEVjbHlWL25xQXljZ3hwZG1I?=
 =?utf-8?B?QUFmdjNwSk5UTi9MWWF3S21ENExHTmtsY0E1VmFOaU1wTGFEbnZ6Y2J6SVlP?=
 =?utf-8?B?MXdXcjRqYjIxS1lHNmJuZ0lQUlJkTG1LYUxQWFpTUUdOM3BOUkg1R3B0d2di?=
 =?utf-8?B?cjRnWHVySGgrZmpHK2N5eFNUd0ViWWYycXUwNjdHSXd2RVdxS3pieDJINlIw?=
 =?utf-8?B?OFBGblBXWVFyZXdlV3U1SG5lUE9xREZ5SFBOOG9Rem9PaGtCUjUxNFV5bVpO?=
 =?utf-8?B?SnN4UFY0TlJUbjkwSFZJVi9PQkk4dFhJVmNSMEpBeGFpMHpCbm5Td0dZNTlD?=
 =?utf-8?B?dUREczhremtVUW9HWHVwZk5UeG5EM21mOG8xSThhbWwxak93L2ZMSWVTRmV6?=
 =?utf-8?B?dmdvNy9CN0JNblhIeVR6RG1QOXd4d0E4cForWHU2WDdkRFI5bDIxeGp6UjRE?=
 =?utf-8?B?Ykw0bnlSRGJmR0IwR2t4M0hBZjkyWlNKcTJsRFpORVpZOXBQUlpmUmJGYnV6?=
 =?utf-8?B?Nm5PdllUTmN4eWxUMzJwd3loR09qaFpCSmlNd2J4TU54UUp5QnU3U24xcFQv?=
 =?utf-8?B?ZDlpOUtVYm1TRkZEMW1tRnJydFJvUk5LRTZhZ3hNMGk4UXlEZkxreDM1Z05q?=
 =?utf-8?B?Y0p0aGI3eEtZRFAxdFdFa1ZiNG5uMytaTy83K0ZuYU15bjRhT3hxMUZyeFNL?=
 =?utf-8?B?Vll6VFNqWFRQSE8za3dIcVBOMUpxdmdLV2E1VWkrMzJ6blpoNFJVTnpFNTVV?=
 =?utf-8?B?a0EzdERVbHluVzN6TFJuODhCQ1hraVpNdFBDWHh4aytqb2NYS3M4SU1yVnpl?=
 =?utf-8?B?cTF1bWdOdHNBSEs1ZWFWc2NYUDBEaUVLK29tNENoVVdyT05lc0dOYTNjeE9S?=
 =?utf-8?B?eE5GMDVyMmJpWGY4MU5RaWYvUXo1QTRwdjB4M1JjSittb0NIUTlxaVgzQ29F?=
 =?utf-8?B?ZFBJdEpiaDIrK09ndE92QjNlYm5xMm5ncjd0em1YL2lLWXVaeVE2cWtPQ1N1?=
 =?utf-8?B?WXJ2djJrZE9vU1l2cVd6SWtSRkFyemhGdXhmR0NQWVYrS0NPM1RuL3BtN25D?=
 =?utf-8?B?aVpMYUtDWTlEWjBXdUxvNk9PTXd1UWwzQzBwT1VYcDM4Uk5ua0F6N3ZlS1ZL?=
 =?utf-8?B?S3JIMnVBUCtCYWs4KzFRMkI1Nk5kZ1Y3N1p4Wjc5ell2b3pnMnpram8rbG9E?=
 =?utf-8?B?NTlydytDWXNWVUc5UE1HcWJCUkIwcWsyTG9sZHVVcEpKaEd1aENkR0hSS2k3?=
 =?utf-8?B?Qy9FamIzQnp6NWpsUjNBbjBVMWxKTTlDUXBvZlRqelcvREo4M0lCQlAxWmpQ?=
 =?utf-8?B?WFIrVXBzM2FIZUNNTEZqMFA0R3NnRDA4ckp4dlhJTkJwZUpzSjQzZXl6eHZU?=
 =?utf-8?B?c3dLUG5sYTRLZWJjRjJhL0FrQm8wQ0k5MkdOTllRMzhxVGI2NVhWMVdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWRCakRyZTRzREhnRW5aNzNNMThsdzVPUU9FbEM4OXNybW8ya0NDQW5YcXE5?=
 =?utf-8?B?VngrVllGbUNRT2UvVUFVOUFwQmYralBBbTBhQS9kdzVyME1zcnlRaUxGYnhj?=
 =?utf-8?B?OUJ4YTNGeG1zSzNiUVNSQmtqa2pNbWNqSWVSeXhEVWs4dzQzK3ZEUmx4UHov?=
 =?utf-8?B?MXpxck1vSTJCYzZ0ajZUdGNzTFQ5YUlrMzhNTjMxNVdQVWM2UEtPNG5BcjdE?=
 =?utf-8?B?S2Z0SmFseVBtMTVYdzMvclNHWGp4YjJMZWY2VFkyV2xtUTFHbERPRERXUmxw?=
 =?utf-8?B?L1VOa05jc2IxYlY0RmtiQjRUQ2JYTTBLQXZPaFN5YXVJTDM4SEFBV2RvcDlr?=
 =?utf-8?B?cUdhVGZmNjZtNUJ1R1YweXhGMVRNcmlYS3RlM0g1SUVqT3c2ZmhXUEtZekRq?=
 =?utf-8?B?bGpsY2dSYWdwa0lYaTNmMWdOemN3UVIxK0hITFZCZHU0NVVHc1hnVnBObndQ?=
 =?utf-8?B?akF5ckhwU0VkK2p5WnFOYklVZElqZkxZNUtPeHRMY0tRbDRkOHl6amllUlk2?=
 =?utf-8?B?akZWem8zN3ZpQzZVd3FweTVyb0tMMmg3RDdOWGgzQmx5TXc5aGpIMTFHb21y?=
 =?utf-8?B?Rm5pTDl4dHRyUU1URlFscDRCS2puUjF3dmZUVmNIS04ybVNZaGdFVFhGdTJE?=
 =?utf-8?B?UW83WllNb1JVUE5EcWR2T2QzT25vM1NzTTRUcHpBTUlpSDlCdml3Nmw4dTh3?=
 =?utf-8?B?QXhCVTJWeXFWRC91QlRHSVNaTEoyUGFzbjV3bG8vQzdLNUk5ZEFhOHJScFRo?=
 =?utf-8?B?amc5RnlVR2NrclVHeU9UV1B4dHBScWtkeDZkTXdJa0FHak9XakI1c000dUxU?=
 =?utf-8?B?Qi9GZGxrdkE5T1hNVnc1QjdUSGdtdU9aTDN5TTd6TFdUYTNSemtaeFJNcm1i?=
 =?utf-8?B?SkJTUnVJR3Z1Y0QrSjdFY3FFaG0xdmZCQkkvT0hzaXNFeWJ4Q281aDJFc3RC?=
 =?utf-8?B?cVcvd2V0ejN2RVNxK01vZXdoZzNrYlAxMFpLMkRJc1BDOGlSZWtkVTdEbFlF?=
 =?utf-8?B?S3VVczNoaElXcTVMM0JBWC93enlhWHE1WmZqTDFFWC8vcncrV3EvUGMzZWsw?=
 =?utf-8?B?UUdQNTl0K2hpcDRWWXBLbE05UVJGRStKa2R1S3dkUnVaWjlITkdwSW5PUUE5?=
 =?utf-8?B?YkdabHVkalJnZHQrQlR2Zmh1eHNEbm44YVhIRGhFeThvTE9FMTZ1MTJyTkNS?=
 =?utf-8?B?UVJaTlYyWU9TVHdmeVozMEcvOUVyL0lHdk0zMXF2Qi9nWUp4YnNtUExCYitL?=
 =?utf-8?B?NTVSdFFlVWNtU2RpWjN1ZGgyZHJMdktDWm96WUx0Ym5zSklFa1M3d3F3cS9B?=
 =?utf-8?B?SUh4VitvNjd4bndFYmdlSmVzdFEvN09tQU8wM0RSNkVWTENlcHNmVGx5b2VB?=
 =?utf-8?B?dCtqbTFsMDdxbkV4Sy9CaGVrUVBTSUpMci9Xb2IzdTZCWGZhZGhKWHJpZWR3?=
 =?utf-8?B?WmdJdE9iaFRqWSsrb0hUbnQ3YkxoQ0tTeDNPQlJwY1pESitMYSsrOExRMzVH?=
 =?utf-8?B?NmJsU242UHcvejlWaHRtbU5oNTlSbEkyVHNVSFhEdVFwOTBzRk00aS9RTzRR?=
 =?utf-8?B?Szd6ejdLY0lIRWE4RldKMWd5V3FkY1oxYmFINjdFdndmeCt1VW5qNkMxNXFL?=
 =?utf-8?B?QjdMVzVKUU1KVFJQZEFIT25FeUlaV0V3eGZKLzVQV1o4bzQzTmxqdHl1Wmo3?=
 =?utf-8?B?YXFCOUYwb0hFSmwxRmRyY2l0MXcrL2JqaW9rWmNwcjdySEdKNXdwSERVT1pp?=
 =?utf-8?B?M3lRQzFLVFdGbnpJWmtpZC84VW9tVy9HZmx3VE9XZ1I5cXhRbXVSbWpGZHR0?=
 =?utf-8?B?OUc0WllTb2VRN2FTdUIxUnU5SVhNVG5WNU15MmtkYWV5c1ZtWjBFcXkxQ1Q4?=
 =?utf-8?B?eGhvVVpzNlV1eUF6alZvUUY5L1lrajM0a2dRYVY5ODd2b21WQmpXZXZYNitM?=
 =?utf-8?B?S0syV3JSZFpkWmNPczg5cEh6QTA5dXRBSXVxVWFTb1ZuQ08rUEZwcStleGdk?=
 =?utf-8?B?L1o0enRYc2swQVpqNXU2TTFNOVB1TVR6bTVsN0ZXdmRUWWZFcWNwNWhURkRv?=
 =?utf-8?B?N3VJWmFUS0Y5dnVLNm1BalJXTnRzMXNQSUhVQ2JoTTRTcmx3QnJCK0I1eHhG?=
 =?utf-8?Q?HLmCP6ASrDN6WtDCOjD5Escd7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dfb631-eb9c-4501-ad3d-08dc7871b686
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 02:08:17.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6Yx0wIcq0VdMIQp2H3YsrfmHuAnnw9ZP5Oo8joGcQ3WIFi/OBu0OI81D1lTLbxpXj6B/uM4jeD+Mo0ej+8K3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

Borislav Petkov wrote:
> On Fri, May 17, 2024 at 12:42:24PM +1000, Jordan Niethe wrote:
>> This has been observed at lower levels of compiler optimisation but
>> there is nothing preventing it from occurring generally.
> 
> How can I reproduce this?
> 
> Thx.
> 

Hi,

I run into this building a module that used paravirtual operations with -O1.

I'll try and get a minimal reproducing example.

Thanks,
Jordan.




