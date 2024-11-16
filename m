Return-Path: <linux-kernel+bounces-411560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E402E9CFBF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A493C281391
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAAB78C6D;
	Sat, 16 Nov 2024 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EvaJfu8M"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08E69D31
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731719524; cv=fail; b=BdUIsWx8QvL9m5tHF89F2OXo2M6GczP9qCpj/VcmBJeocmqDUzEhImTi0r0ukTsX7vZ/vQOc+h6Z9nJ6eKnLV1jyobm28pjZ3sCQGFKCTgqIhfmosbrNllSF1BpjBPUFppz2Qo/IwQIiIuAC78965hhHiWZqUz+DipWY4fgY3a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731719524; c=relaxed/simple;
	bh=Fgn9UI/K/kwuXBxaxX8nlMWfoHQ3kliVG/CE/7Rfuzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzlzrNjI3XL2p3OS4qGYtezKMrKwzfJNC1+YZ+QMCeMCdFa1NUmwo2E19pRpmEqpiL73xsKT6jPFDoB67EFiIVreq/g8+bpL8HFnSt3t0iLUjRPl6+dzSapiv0gog76vcQZojETVoiCrRwotAm4ixmJPAVhReWDKIv7eX+BTh6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EvaJfu8M; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmVhglJyzQmhXJmBwiUu4Y/Rs77ZNWv2wjM+7P7ourtIo5wvmAXrMy+clM/vc8UO3xuyrIpt+3nPV2fQY+0wRq6qNNcNHdf9Ox625soWQPVG2MVqKUfv8e8XrI1pPf/rPH4mEgkdB9XiCc+ZbicXE4zquRmjKjTw5pxdfKkP2D80o3gzjCbTl86PDyWiZjY9lDiPxIdY5tBG2kflm+rBmbby0Yzr2ZQh5VNauZ4smaT5dbLkER4t+YV6Kb7K+FjY2wnCi9Q3T5ZeJMMOup6+twbhqfLotvV3Wf07nSOzClp1HN31VY29MqPxCurmJJkqoHbwxG5aN0wwrHp64PXO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl1gZNU9tA3KFBdLCCp5Vrz8UNyjfPaeZTdL8QeuA0A=;
 b=iwdsy9BUN7Dzjqui8jpH5ZbmibQD78P52Kia7q2dcn9KmcgoSJBtKNtCDB7ACm/eP4i4bJiOvbQvC/G70uCpDhXeFP3CjMxuied4Z2LEdPtfCpFLWjRi/pDMGwnkI85BszmEaPHY7hk2SQnS5LxIUEaeDdZrO918gbFew3Gv9QIGPCVYUcMXok9HokbC/OnJqlpvmFNIIgwqjpMNYOplzGznawzEdyJ5dwP/22HZQwa+wGw6P1qFhM/4OM+zuePP2/75TskJ7+bCPDU727sm/SKdu9qX7OPHNZXkSiXeEAOzPFTKbkVCa6sMkCGFGW6YGKfEo3f5z82sATWVtBQt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl1gZNU9tA3KFBdLCCp5Vrz8UNyjfPaeZTdL8QeuA0A=;
 b=EvaJfu8Moecuu9O14Xm8iSW+687vkGNSGnPJ8AK0fX5ZZnQI/G/DjNcOgDCrEGHMxLGoeppMfx8BIGFEmSA50DpJlSLoPwtqw6BXdzT8ao4tDb4B0HCl2bqeOEVV5hi5YuJoi1+8VzMFJJ+zJLDmr05OOXc3+aP7nn2B8P9aXiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Sat, 16 Nov
 2024 01:12:00 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 01:12:00 +0000
Message-ID: <b582295c-6199-4eb2-a10c-4ee703b10f4d@amd.com>
Date: Fri, 15 Nov 2024 19:11:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups
 for kexec.
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, thomas.lendacky@amd.com,
 michael.roth@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>
 <20240420130533.GNZiO9nShSxjxB-FQn@fat_crate.local>
 <ed4cb373-e626-4b79-b692-df5ea2ca8899@amd.com>
 <20240426125803.GDZiuk2-YonyodvSbi@fat_crate.local>
 <5d515e4e-5db8-4840-a200-a67e7df8043b@amd.com> <Zzfst1FwR/DJqtGg@kernel.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Zzfst1FwR/DJqtGg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: a14f5272-0af9-4055-b8c5-08dd05dbac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aktsZlp5SWxZNnB1Q1o0aTZxYVJsZGRYczRsTjZhbjdGUlloc2t1WmMzakx3?=
 =?utf-8?B?ZGIzOURuT0E2VDY3L1E2R294SE81UDhtQWJlUkxYbzBmZmVvbGZvMWRwazdv?=
 =?utf-8?B?QTJ6TmhOQ0VRTCs3V3FoUWZpK3FsU0EycEhlZGlweVpGN2FUODZSUTZLSGs2?=
 =?utf-8?B?aTdWNHIwaEllQURPZ1U2QUl5VjZ1SThURy9EZnZ0WU5vaEY5b3VVZU5hMi8r?=
 =?utf-8?B?UU10S3JSRFhZOU5PZldaTHlRYzlrY0EvN3lJbFZ3SUtYMFZUZUE3UTcyWWh3?=
 =?utf-8?B?cHR6TkZRbGtUc3N6THg3YUswYzhpQW1DcVphRVJhUWRIZk1ybFh2WW9wckp4?=
 =?utf-8?B?UmsxS2U0TUgwZHdTdGZ6aTM1bk1JbVVoU0NDalVzY2tqNEsraGdVRHJUdVNa?=
 =?utf-8?B?QTFzcEtwQ2kvK0JtSmhrZTN0MUx2YXFHbzhGT2NLb3dsbEh3R1k4MFI0WmVR?=
 =?utf-8?B?NmhicXhqSXo3RDNyQndpMWxqZWYrMmNjY1VEUG5DZHVTNzh2ZTZJWDY3TnFC?=
 =?utf-8?B?ODFKclRXYytQd0JCOGg0QVRDUjN2TjZIQ3lwdUtqV2ZabTJmNjEwSW5scWs2?=
 =?utf-8?B?WUF5NEpSaER5K1NYNGVjZnJ3TXVIRW8rQTFwcHBtRkJUcExTbkNiWW5ibmlH?=
 =?utf-8?B?dXVzQVY2OWJzSWhaRmtZaXR2YmN5ejF0d2FwaW9UeWZKMFI2N0daMnh4MGFX?=
 =?utf-8?B?WFQ4bmc0YmVQVUlwU211MmUxLzN3Zy9oQWpvcWNkaW5icHFqYjAvcTE4TFp3?=
 =?utf-8?B?R05Lb21Qa2srRVVvSjJnQXFFbXBhWXB6SE5hcGwyUHBIRVFiYWNjVFNTdVFK?=
 =?utf-8?B?MTNTOXhENElEZDJFcndMalZuck9tZDR0TjN3VWdzUiszWEZFd1JybXFIQjVN?=
 =?utf-8?B?WGFUVXIyTnVMZUhVWEtlRjZkV21EY3B2MWpKVWs2dDhkKzEzK0V0TnpDNkFW?=
 =?utf-8?B?UFFHbTFUKy9IYng5Zk1yWURmWHNpaVdPSDJiV2ZrNERORDZ3eGtiTm1WS05D?=
 =?utf-8?B?T094cGhxSEExdFhYUVEzd3NsSHh2SDZEVGpGaHhQbjdyUStxK2RuSnlKRVpJ?=
 =?utf-8?B?WnhEN2dESEI0SW84WEUwcmR6U0ZNWDdNV0FvM1J2ak5YV2NiaGRaT1NFY2FE?=
 =?utf-8?B?RHQyeE9PVW43V2NMTkpMRDhTeVhwTWhoZFJoOC85QTU0all4OW9DSWc0M213?=
 =?utf-8?B?S2x1eWNrbzNEdzRoRnZ2ZVJ0ZzBVU1dKUlJSTEloOWZ5LzdIYVNqd2MreWVP?=
 =?utf-8?B?WWVsVll0T1lPRlZBYmVqVXhMKzQ3Mm5IUGFSWmRhbUNITmFOY20wcGs0YzZt?=
 =?utf-8?B?b2dpbEFCMEVvS0hIS3FjQXhxTmFQRXNBRjVsaXdrMkFJNFJKNXJhbS9FSEtn?=
 =?utf-8?B?QVpYREk4WWxXdk1BTGNVazIvZFIwdm15dnRnRXdTelJXaUNVbDVKZERpOEF1?=
 =?utf-8?B?OHVRbFdibTBvaEJpUmtkMWppN1FEWW5OTWMxNStKY01pOXJ4cStuK0d2TU55?=
 =?utf-8?B?Yk1KL0V4eXJ3SWFpbmY0TWhoUHpQWVJray9SaUFFdmF2b2RKRUMxQVFaZFc4?=
 =?utf-8?B?a0Vld09jTnhoY1RWVHRFWUdxczB1N20vY0xOc1N5RHlsNCs1L0FmM3l6YkZM?=
 =?utf-8?B?SmtNL2gzYWxzMkQyaEZnSUszOWl5eUtjV0tvWjFZVEIxSGJVU2pXSUZyY0JC?=
 =?utf-8?B?THREanRkdnZ6NVVDc2hFZ3NFdWs0RUVsNXJSMGJCM2tDRlI1RGo3ZzJaTTRS?=
 =?utf-8?Q?sLxZwnu7Tgv6j0iJmfASSQaxf6ZmhgBNIOsjKrY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU8zdndyamlIN3JFQ01CUnh3RlRsL3VvNllMUVc3eVdJQndwWnN4czhnbk93?=
 =?utf-8?B?ZmlpOXpMNTZxV3VkaHV6SmUxRG1YRWdyNG9xVkliODJaZXpuWFlpVkpMdDRB?=
 =?utf-8?B?QzN0eXZib3JtMEt2RkRzK2gxcldFWVZtdHM0Z1ZSWHJXdjBHMUxmTklRemxs?=
 =?utf-8?B?ZW4zVlVsS3BzbFZsY3hhaGRtbEZGaTZXSUphYm4zci9YbHRjUzhCTmtIZHBS?=
 =?utf-8?B?MlR1SFArbnRCVGQ2cVdHMWdYUnc5eDFqb3FpS0VUSnRhZWdFakxkRDZrVjBL?=
 =?utf-8?B?Uk1vakZRS3EvM2Y3U25qMWdaOHRpUmJUQ2gybXNiMUZFdjdVMXloWWhReW4v?=
 =?utf-8?B?SFZjU1lYV1hsemhZYmtaU0hURElPcmJKR1AyaysrYWtTZzg1MDIrcHJLUHV0?=
 =?utf-8?B?R3NJQ1UwODVINVFNNjMxUnVqZ0dnTmkyZXZEMVRRWHJqektnaS9SOWhzZm1j?=
 =?utf-8?B?YjFmeDFKV2w0MWE3c2FVVkpYeG5TS0ViY0lnNXp6cmJSNTgxcVJ2RE82STdt?=
 =?utf-8?B?UTVXU05JZTNBMTJBckhZZjFLTzFDeUhWenVEZThoeUFXMHIxMFZPS1Zub1p3?=
 =?utf-8?B?S255NzU2RFo4VHROVXJYdUhUTmNEUVdIdU9OUytCeERQejBrdjcxcDU4ZkFt?=
 =?utf-8?B?UzRoR3pLZXRSamI3N3FLcHgxWUYwaDVTdDJTVlZZUzZGRXljWmNKc0tzN3pY?=
 =?utf-8?B?OS8wbXBocmNYdjRhS3lMa0tZdHIxU3lnUDR0NEhneTJWY05pQzQwZi9zOW5i?=
 =?utf-8?B?NG53VUFKL2JNeWZkVC9MUmJsSUZZVkZXdnhIZ2l5Um9lNEh1ZDUrUjdLTVZG?=
 =?utf-8?B?Q2tsQ1R4NFlyRk5kblVONmVrc1BDY3ZPOUZvWFVEVFordlFyWi9XTjljemI4?=
 =?utf-8?B?ckZXcFBmVjZnQWNXSi9VOFVReW1CZS9qM1lHTjN6SGlRSzVSYjVKdG9WVzNO?=
 =?utf-8?B?QUwxWjE1VzQxZjVpY1FQenE3RDRlbk15UHIxcm1nc1k5UFRzZWlmbExSWkxL?=
 =?utf-8?B?RCthUTlJU0ticzNOMittWW1YQTM2eTZ5UExKSzB0QUphOFN5Qkt1cHdtWDFj?=
 =?utf-8?B?UmcxY29BZkpybVNoVTcrTXRHUFlYMXg5M1U5aHU5MnlUSU4zUXdsdzhCZE1F?=
 =?utf-8?B?S3JQWEJ4a1p5aHFwK3JNUmU4ZmcrL0FoK2FXSkwyeHB6S1FwNW12aEJmZ1My?=
 =?utf-8?B?SnMvdGNmM3p4SW1xSU0wTThWc2Y1Sk5qY2RYaUgzV1dybW5lSUx2TlA1NU9D?=
 =?utf-8?B?SjR6SGtQa3dMMzJnTURkdGM5NlJPazZ1czVvZnl3RDFIMXprOHJlY213ektF?=
 =?utf-8?B?TnhncEMybXJ6UUsxT2tBcGVMN1pTNzc3WExyYVlOK21SWTN4eDhVTWhGeENs?=
 =?utf-8?B?SjRzalFmQ2NrSHpjbk1Bb3F0UFVrdmoycmpBNUp6L3lOOW1aV0gyRGIranJD?=
 =?utf-8?B?K0xEWUVZRThQOTJLa1FuMmVZL3poMXdOaWkxMmUvVFJxS1VFY0RpZlplOVhm?=
 =?utf-8?B?cTJ2dWJNd2J1bzU0VW5iMFovTnEyZHZtcEV0ajlLT2pxeDNyY1JydmR2cUMx?=
 =?utf-8?B?aVM5aVJ4TjkyTWxFMHdqSHdtb1FCWXFVaDRlaU5wUTVqeStaQmdneVpRVTd5?=
 =?utf-8?B?K1g3SzhOQm81aWZRVUhlUWJZOFAyWUhwLy9CRCtGbFo4R0VUWTRyYXh4UVpT?=
 =?utf-8?B?a24xbGtGeVJrdWVDV201NjgwV0M2dUd3TFNJM1RJZEc1ak5CdUpoNVRkY0dC?=
 =?utf-8?B?YmxIWDRJVjIvSFNKVDNvNXR0Nk9FNGM3REpia3ZaNU9YV1hzRk0zU25tUkcw?=
 =?utf-8?B?V3FZZ0NrcktkQ3d2K3RaWG5kSTZ4WjArVXhoY0cydFVHSGpTb0lueWI5RmJO?=
 =?utf-8?B?WnZaZnN2bGlDVmp6aTlteG1XVEk1dVgwTG9hVmV0UktkT1B0d0xRUnEvS0Rv?=
 =?utf-8?B?N2U2VFpieFNQRmtlYmZqdzBlMHcvVGJLOVA0T3FvRDJhTExRUWxObmFFVzkx?=
 =?utf-8?B?N3ZFQkdBL29TaU8zR3QrcFAvSXNCV2IwV3pPZDhTMEdwR1FpS1Fza2x0bE5F?=
 =?utf-8?B?UEZ2K1VGVkpnaW91bHp3dlNadnN2dlBsMnpKK0pRNXhiYnFJK016QmdLOE1X?=
 =?utf-8?Q?KkN6gnIFpMJLVNIum14cD6GoI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14f5272-0af9-4055-b8c5-08dd05dbac23
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 01:12:00.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRCPtR1Us2ne313eMuFTld1gg1cnCrpOIKku/hsAq4DC0MZtuxYrlbnJNoZxLaPE3L3RAw14BVmBGWBwStv0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278



On 11/15/2024 6:52 PM, Mike Rapoport wrote:
> Hi,
> 
> (sorry for jumping really late, I've just found this accidentally)
> 
> On Fri, Apr 26, 2024 at 09:56:25AM -0500, Kalra, Ashish wrote:
>> On 4/26/2024 7:58 AM, Borislav Petkov wrote:
>>
>>> On Wed, Apr 24, 2024 at 06:48:08PM -0500, Kalra, Ashish wrote:
>>>> This callback needs to be invoked as part of setup_arch() as it needs e820
>>>> table to be setup in e820__memory_setup() before the callback is invoked and
>>>> snp_init() is called from sme_enable() in kernel/head_64.S (startup_64),
>>>> which is much before start_kernel() -> setup_arch() is invoked.
>>> So?
>>>
>>> snp_init() still runs before e820__memory_setup(). So what's stopping
>>> you?
>>
>> As i have already explained above, snp_init() runs before
>> e820__memory_setup() so we can't invoke this callback in snp_init() as e820
>> tables have still not been setup. Again to summarize, the e820 tables are
>> setup in e820__memory_setup() which runs after snp_init().
> 
> I agree that snp_fixup_e820_tables() should run after e820__memory_setup(),
> but I wonder if it's ok for it to run *after* e820__memblock_setup().
> 
> At the very least making changes to e820 table after they were translated
> to memblock creates inconsistency between the e820 and core mm views of the
> memory. 
> 
> So I wonder what would happen if the memory from the problematic chunk was
> allocated by kernel rather than by kexec? Couldn't it cause RMP fault?
> 

Yes, we discovered an issue with SNP guests when trying to use one of 
these pages and there was a fix pushed and merged to ensure that RMP
table fixups are (also) reserved for memblock.

Here is a detailed description from the patch: 

The RMP table fixups are done after the e820 ranges have been added to
memblock, allowing the fixup ranges to still be allocated and used by
the system. The problem is that this memory range is now marked reserved
in the e820 tables and during SNP initialization these reserved ranges
are made HV-Fixed. This means that the pages cannot be used by an SNP
guest, only by the hypervisor. However, the memory management subsystem
does not make this distinction and can allocate one of those pages to an
SNP guest. This will ultimately result in RMPUPDATE failures associated
with the guest, causing it to fail to start or terminate when accessing
the HV-Fixed page.

Link to the patch: 
https://lore.kernel.org/lkml/20240815221630.131133-1-Ashish.Kalra@amd.com/

Thanks,
Ashish

> -  
> Sincerely yours,
> Mike.

