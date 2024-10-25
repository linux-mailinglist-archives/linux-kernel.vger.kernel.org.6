Return-Path: <linux-kernel+bounces-381519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A419B0070
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C17C1C214D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219B18BC0B;
	Fri, 25 Oct 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MAdf7seq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB5481B6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853278; cv=fail; b=SpDbpkHVDaDqq/9scLqYawQzze5gpd94UftATxJT5WlJhxRD0p3yloXPLOQXCfJgBwwAasgec1XOzTicQA4KjMclIrT7u9TqhpN8Yny2t3ACCVWTI4l5iabejqEl6rQwqityEwFP0ATDmApnyOGgw/ejSTZSjs0JnXJyW2D/hy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853278; c=relaxed/simple;
	bh=zOxHsfTd8wh2ih+/OUD77Ixa2DG0a+0skJ2GSbc4Hfw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/7awb3Jf9jzaHnJs7pCtJGQVktvolgFVF/oP+Zgxc3E6vjjsqnld+FWIscruKc3N52TUPkxq5pYGe3pr+JuE9ULP/B4PDh7fPW6mbuMtrv8ETaP+7VMOoEXtyZwJwsysNlqzXtOjooq4mEIGGqqsMwSZSSrtcQ0W2lwhN629q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MAdf7seq; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2K5+2EWWtCpmmMCdEesNo0NekVVFIuPjNB2rR0c9t8m/fSPudKX8RLnW+Wo67xmg47X3j1sRpT/nrp8CQOrgzbhNU5olLFFj6BUrv0Yl4xGTuRNzlBZTNpXK3m5G9fnKyCHuD8PrPCVm5QrG+fQwl6139h5MR04GPuuKwrNLj5A5KNwkcLF7sSEYcOI5caaIPJv0J2R/LjKy+5AaRaSSklZao60A9Im7iWHdmwee0BMz6dxLnrQUJWdw9/gn2jQUcsKz+jBZ98BFzLilMp3u/zzIlZTcIBFXLX0edqo2SRoDlge6nW4+DAZ0zvJDQ5SQ8+Uym8qV4bRpffYrmEgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un9JSeyaptRXR+2QTszPUeM85UIKe1ilTgzTHQe4XlE=;
 b=CONFYUPxNPaECvZGBPdcMkqMhocbRUKdoBfftvrTDwaUfz/fEr0y7i0gslhk8w+D3IlwthTGD5GvQdIhjW53PrjFcdP9sog9Ym+qO/9h6rqcn8Ef82ulms8FsYgszKfW63ix9ccYHUNYhJuN644lOG9rJBlZ3G8r1Ud6thwU00qtXdDYJJFHAho2sHm3xNGPSdfA0aOx38nlQm9Wznali9QDxtTKmZa0ucFeQF67Ha9L/bA1tqgadGY4lJ2/h8L4zkONUnkKgfm+X8zhqUJkcYlqxdEAaBseAGDkvTkXVZTdUpWH7GDSsWJsyGyD9I8wEoepn9nS3B3N3DApUIZzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un9JSeyaptRXR+2QTszPUeM85UIKe1ilTgzTHQe4XlE=;
 b=MAdf7seqXSw/L+7XK9LOAmpJwq5vXSK8LKvUXWZhBFAnnkUmE0RYkLr+gUXtSwij9i1g3PC7tcYVmCFyJ9b/FD9zGYVtLouW4csZhvDj6KfoQ2wCLDf6NXKW2/jJDCN6+0dY3Ebjg8DHHD4kWGUkgyH1C8TRHuLfzqoNa1GsDpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 10:47:53 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 10:47:52 +0000
Message-ID: <c94987ad-22fd-47f3-a353-8868fb4592a8@amd.com>
Date: Fri, 25 Oct 2024 05:47:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] x86/sev: Require the RMPREAD instruction after
 Zen4
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <54f2b69c783436339e2927091f93dedc3fee1d79.1729708922.git.thomas.lendacky@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <54f2b69c783436339e2927091f93dedc3fee1d79.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: c7358a65-1611-410f-c8bc-08dcf4e27985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTBYT2tYelp4OCtHWmI4OGwzV1J2OGF0NHl6eHArcUp1MlBsREl1SWp6UENo?=
 =?utf-8?B?TGpsd2NueUFyM0xBVGF5MTA5T3MvR2xBMzNZbVh0WEtuS1pBS0F0UkcvN0JS?=
 =?utf-8?B?eDluVys5UVhtdlQvZ0psbXhXTFVTYnpFU0RqbndncXo0c2NvaDFaWWc0WGsr?=
 =?utf-8?B?UGlkVHFieUo3b1RaWWV4ZnRtQ1JMcWg3OWVQVFB0L2dJYzhYTU5ISGZHbEJv?=
 =?utf-8?B?b0doRndYL0JzZ1p4RFhMempYVUlaT3FtcGxTWnl3Yk9mdXl0UngyMWJsc1Zm?=
 =?utf-8?B?bFFHOTIzZzdRZEJIS2JmMUxUQURpa1JtYVdRQkczVWRYUVBKVUF1S3VBREFa?=
 =?utf-8?B?QXh6VnVHeDlNbXlNbVlMRWVMMUtKZHdqNWpHay85UGdYQUpjaXVPV2ZZRFNI?=
 =?utf-8?B?R1BVbWp3VUxDc0t4L2xLUHM3dTdZdzAxd3p5bzg3cGdEWlVqOCt5VWliS3lR?=
 =?utf-8?B?bExBRzJ0NXZuYWQxQkQyb083NFQ5Z29XK3o1MW9xNS9md1Z5bTVMUWxDRmxa?=
 =?utf-8?B?dnZUS2hhNUUzSXFySk5ILy92SGRqZG5hWWpoRkNZb2xJbHlYbGF4cmZ4dWph?=
 =?utf-8?B?WVFoQVJKbTk4eDJKU2pSMFNOcjFXSk14c0kxZmN5V2lhUC9ISjZBU3lPM2c3?=
 =?utf-8?B?WUlCc2VVcDJhaHc5YWxiRHNwK21odVhFWEJLSjEvVXA1bUtJd1JxQngwaXR6?=
 =?utf-8?B?a0NWSEhmVGJGVnRoMkdUZytGUHJiTDJxQ2pPbWxuRWRIRnRqUzA1a2RYRWFz?=
 =?utf-8?B?NGs3MEp2Njd1dW51RXBTNEFOVHpCd1hpSGRoVEh0VmdSSDZIUW83VHUyM1Fh?=
 =?utf-8?B?ckUwcEk5Ym1kZGl5eURkTUt6aTgyMjRwSWs0emt1cVRQVW9qSmYxaTBxaCtP?=
 =?utf-8?B?R3MrUzFNNlNtMDhETTZja3ZORkU5RDc3RkZXL05ENWdybklYVlMzTWh3WVVW?=
 =?utf-8?B?dFUzT0JBYXpIV3lPL2FISkhqRVhrVkROOEFDaGJlZHVMRU16eTJ4Q2FyZ0pq?=
 =?utf-8?B?RmVSNURSK1BxUzRSZFpuMVowY2VlRE1mei9TS3paRnE4eHkvSnlzWndmblhB?=
 =?utf-8?B?M01heEYvMzRscVFWcjloSmFwSFJZVUxOK3ZnN05CUUlpZFR2WGlnZWxFUVl5?=
 =?utf-8?B?ZjFkVG4wTDc3SGFqSDNCTmNwaXNCRkNyTUlGV0x6QlhUQ2FNOStCallLblR1?=
 =?utf-8?B?OU0xdVlrU05hbkcyWUIrVTZLdSt2OTNTekpZeXlGUTR0a0J5MEZEQjQxZHpB?=
 =?utf-8?B?UTBvQ3JheEhXVzRraUlCd0t4TjBwbTV4UG9reFdNY2tUek8xcUF1cDBNVkEr?=
 =?utf-8?B?OUJYOHNqUGxPRnhPdllwcnRVQjJXVkxpZklCcE9xSWRIOVY1S2Z0TlB4RjEv?=
 =?utf-8?B?KzBCbTNMUzJDS1ZuVHpMS05vMkhCMWtyQ3pHaFRJdnE4WU5BYXBhdVNsN3Zp?=
 =?utf-8?B?clJJUCtsVGtDMGo0and0d1ZIcHJHRnNkTm9wckNnbDZoQnVVMWxlUWd1NXVq?=
 =?utf-8?B?RnhOUEFDdm9pUk5keGwzalp3R3JobC9nbjVmV2RkLzVFSEhDTjJqdFI4ZHN2?=
 =?utf-8?B?akJTS1BmbEJ2UnBPVnQ1UDY0M0h6RmloRWtYR0lOMVVKeWdjcFJucnN6dXpy?=
 =?utf-8?B?SjhpT0NkemVBYnJqeSs1R2ptQU9lSGZyd05qUCtUQW9DUzBhWWZtaG9XRHBC?=
 =?utf-8?B?UTh2L05hT3Q3UC9yY0lyTmZjWWM0bXRjUVVsb3laQVhkeDRTNUlWeUpEeGhQ?=
 =?utf-8?Q?iPg6CWF/RP4ovKfC2cN6D4a60I7kYBmsHT5xoxi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dThDSUZ0bDZrWjlCall5NTgreDV4WTlkeUprNHJrdDVnK2dhYWZRdzg5QmhO?=
 =?utf-8?B?L3duZDZvVTMxZFFIaDhtQTc2YTlvYkZQMnNoMUlyeG5JNHhiNFU2UU9VODRM?=
 =?utf-8?B?eitmd2xHMERPek4zRWhGaGZhejI2dXBJT1VTWXBhVnJHdjhlNHlTUmxieHZu?=
 =?utf-8?B?NXcwQmlLTXhZaXczSGtza2k0R1kvRVdxZk4zRG8rSTMveHpJTzNZNXBMdHFz?=
 =?utf-8?B?NXd1cjMwYzdBSkdwNGluMDMxeGtQY0ZkaDFyYm13M3JHbm04Mm1YK2VTRml6?=
 =?utf-8?B?SzUzYmxyZmM5ME54WkdkNCtjR0VQYVdBT29PN0V6Q0FFWjR2Yk9zeGlOVFdo?=
 =?utf-8?B?d2lsZlNsd1o1clVOZm85a0dnSVFxeG1wb1RUMXgxVDV5dTNtN3dJaDZnVlFh?=
 =?utf-8?B?S3hZcG5YV2gxM3o4cmhpRkk5enp4RFppU1p4MlVrNUsxNytVZ2E2b09QU3Nl?=
 =?utf-8?B?MmdFNXB1THIrSTBrckdVTGhPb2IydzM5YlBxZitWMFI1SG1OWUtqWWF2OXA5?=
 =?utf-8?B?TGxwbWFJdUdRakFabmxsSFV1NG1kdXdka2hGQWhVZUpaamdkZjNmVU5LeTBh?=
 =?utf-8?B?Wk9IMkV1MUZTWVEycXJFOVlUenF3RHBwaXByNzk2UDRHMjNweE92bjhPRXZu?=
 =?utf-8?B?ZGdFTXZZT2dWU2YwTEkyRjA0aEZFNXNhcEZ0ZnJ1a3Z5ZlF0SFUzZG03d2or?=
 =?utf-8?B?QkcrOS84S0k1cnVGd2R2MDF2ay9iTy9oMTBwVmJCQmVQSzRlcDk3WXdOdW0x?=
 =?utf-8?B?bm9sd09ZbWtwSHNvc1VLT1NvRUt1a1RROWJHYnBGdDltN2gzQ1BxZWRrR0hj?=
 =?utf-8?B?ZXNYYTZaQ3BscGpFNHZoWkxKMlRnY09kMjMzaXlIQ2dHL0FwbDZkT2xKbElO?=
 =?utf-8?B?OFEwZ2VrNUJyQnJDWGVLLzVuL2NLeTBjKzZGbXk0ZzFRdGh3a3NXVkRXOFBD?=
 =?utf-8?B?RjJmdW50SkgwZmUrNWtKMnBlUmx3WS9HUm12b3hhQmljWDcxZXpaU1JGVEhj?=
 =?utf-8?B?YlFrdjhYWS9HTXhKbTVxRXU4b0xwR2ZPRnRqYWQ3K1ZjelV4R3pGZTFDOUcy?=
 =?utf-8?B?M3BkcFBWaUwvTHZLeEdDalVDTzJ2c2hMU2ViK2tPL1ViU0liM0ZwQ1NSK1VH?=
 =?utf-8?B?WnB4Z2pCZjZzTmZrWjU1RDhpTE9iVHA5VXhWemNQc2Q4SUV0YkpSNitRcjRm?=
 =?utf-8?B?YWNlQmNTbU9EUDI3dkFhZWZGVnhYdkxZTGNxdEpXMVh3THl5amczZEVNZkFS?=
 =?utf-8?B?U0tic2N6Ujgxd0ovU1Z0Wm0vc1NhaG5COGh6Wno0ZGdwbXFvQ2RVNC9qZlVB?=
 =?utf-8?B?VURIT3AzbE1ab2RXS2ZaSzRBK3dYZm81azE3UW50bEx3TDNVOXVJOU8yRVM0?=
 =?utf-8?B?WWhRektIc2Q5WGd5UXBZMFlrdUJ2Y21ZYUtpaFJxV3p4NXpiajlUejVVT0tw?=
 =?utf-8?B?ZFlYR1N4ZjBMK2orYzBXT1BNWnhrSElvRDBqQmN3MmRkdktxTG5scGFYY3kx?=
 =?utf-8?B?dGJ3QnZsVmlXcVp5clNxSDZxWTNhM2t4MHVrYTJ5UnM5blRocGNLb0RmT2lj?=
 =?utf-8?B?MjVaT1hFUEZ0Qm1kNitYcEluR2c5WVhBaTJCT1g5Nm5TcXZ5OEVkQ3d5YlV3?=
 =?utf-8?B?YkQvbWpqSzVqa0p6c1R0blFwOXR6UTVBVzliUDFBZ2tuREFOMUcwbnhNQ2gx?=
 =?utf-8?B?UUJyWUVBa3Z4aVVTUTVsYk9Xb3J6TFhWR0FjQ2wrZjFJV25pbnZUc1VuZ21I?=
 =?utf-8?B?NzhSSzVHUU90bFVoTUJCZUlLM0MycW1lWjE2L1gwaDZWMDVpSVVtWi9BZlpV?=
 =?utf-8?B?dWtoQlFzaFh5aUlSMWtjQUd5ODFpL0ZHeit6RlhsMVFjeCsraHpGbmN2SGZo?=
 =?utf-8?B?ZGxSYkxZQnFrTUNwNFQvQWhYN0ovSnBPZTlOby9lcUtFMkJzL1pWNUQvT1pC?=
 =?utf-8?B?MVQwRk5KWmlnM0R6UnNFc1lOenJhbDBKcUhQcmxpOFJUNnY0dDNWSCtXL29n?=
 =?utf-8?B?QUdoNWVoSHdNbmhXYTJtMUtiVnh0S3JsVVIrTFhzMkF5SlpZUnRSSEh0WndH?=
 =?utf-8?B?WVlNTGxiczdXQkZvWEJxaW9OaXJRSnFOamJkMXMra1BrTVdKRDJ3enBMUFVP?=
 =?utf-8?Q?y+25bo2LLFgtQvfTxI8766sBt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7358a65-1611-410f-c8bc-08dcf4e27985
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:47:52.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhQvuxe2W1qNt8J3eIMQ+H/dxV2QP7dcTQbhlFr/xGMWuOz1tdA+eUO5B/1KQLfRvRpx4viuC/0ZCLEwDHY8DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946


On 10/23/2024 1:41 PM, Tom Lendacky wrote:
> Limit usage of the non-architectural RMP format to Zen3/Zen4 processors.
> The RMPREAD instruction, with architectural defined output, is available
> and should be used for RMP access beyond Zen4.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index fab5caec0b72..547bcdf50f1b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -355,10 +355,15 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
>  		/*
>  		 * RMP table entry format is not architectural and is defined by the
>  		 * per-processor PPR. Restrict SNP support on the known CPU models
> -		 * for which the RMP table entry format is currently defined for.
> +		 * for which the RMP table entry format is currently defined or for
> +		 * processors which support the architecturally defined RMPREAD
> +		 * instruction.
>  		 */
>  		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
> -		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
> +		    (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
> +		     cpu_feature_enabled(X86_FEATURE_ZEN4) ||
> +		     cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
> +		    snp_probe_rmptable_info()) {
>  			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
>  		} else {
>  			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);

Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>

Thanks,
Ashish

