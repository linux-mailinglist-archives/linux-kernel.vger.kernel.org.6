Return-Path: <linux-kernel+bounces-347371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6ED98D1C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55FA1F21E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004971E765A;
	Wed,  2 Oct 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ufPeY+7W"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05191EBFFF
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866536; cv=fail; b=ZBHBChMvVgcQi3vNaV8D1voh12nsWnKrEtSuHumBuUNrBeyFYIeMelL0dfNU2hyosJ+odM3xwet5SSNNdnVPKZPLFAD1p7SWDBLsMS15qn0bhmmdYFC1vokhNNViByERKgTIi/vV0TxFVfi/yz01cDhb5qAfeKFd8j6lfZLnaCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866536; c=relaxed/simple;
	bh=14WjyWzAIkbzR9mpPJx751Df69hHlXX/T878hkYYAzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uHU2ePQf2M3ZVQY25azlSy4hdfxNYoMr2JbNAzPRI0zjYjQZEcsYphqO0dCOFqwmedy7UGrERtTsYF+HF177IwKbGA7dN92wJtIIsBwoC8wf4Q3wRmpSCH2Q/ioBEJDpMVs3Kte2TyorJfGuiO/uW0+0aW6QcAd1iW3ITfk5IRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ufPeY+7W; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtT+v/0D1EB/E+T99rrKfcAbcreK3hYei963aYjvffz9jKAxg9JLpf1YL+U2SDUOb08vjmp8qbQo1/eDDg8dB4OO2tgtjSd0szT796mGinV7s+TJitZSv0+4YAN59D8GGTJv1ickVJ4uSk044mSTzO9Wx686mKbhP6ITxF4x3nPQiCL16DWyqGg41FWboAcQX7xY+NbdCs5aItILSZ3OsiRyTQvJ7pJ2ba05FgLj3w6DFeMxOT21+JINlx9acIe9/E2jL+5FlfipLqefEwt72CVVcaVIq3ey53rolWwLIjT0yaUC9oGW+R2VioyZStG5pgVpd8tC7q5BqrSa/eNykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fGFJ0J3f+1rbw/3dOHkdfpeY8voW6Q8Cmb8rv5T770=;
 b=wBoBcvdPFZYA4qJg2r/8PVOaL+ytL/nVE4jJFmRIZ02PLfQfUQH5Q379THvdswD8jgndX1nEDdbEeiQ0gTkVgW69PjxelvErBXtuh7qpz1tKnLK3rlGd/8DIV0olu/4fxBKMWWBA/9+7x7kj4Uzfh/WoxiR/YD6+9uVz8cYRiBNNYqBs1p2OTwst/f1BCfSPMoOFsmQjwaZ7MinJhf/pjSjg+TcHaCvUXyNrECZv5iKiDMbcKf6ce1fv4k86vxDG43hEoEAEEj437KD2Fcqt4zhzwYxLZcGXsCLyTRMFbtFp9VBJ5Llb80llrO7HHP43VoHu2fquGugpb2kbDAWBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fGFJ0J3f+1rbw/3dOHkdfpeY8voW6Q8Cmb8rv5T770=;
 b=ufPeY+7WDJ0swDWbTfPLcqFuhc3FVbB3wcjjd68Uz5BeVDTzPbZ28JCZUnS8KoVLLzu7zZRxnr+zuI3c5gSFlcIEGW107EgYEomLzJ2q0620PE9QyBp0rWDFn/sOJPuXReK07rq0GlcxsyVAddwO1Y4x8xm61pGe6csxPa3/FoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 10:55:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 10:55:32 +0000
Message-ID: <54953d15-3d0a-4fbb-9e8a-02dbfb2d8a00@amd.com>
Date: Wed, 2 Oct 2024 12:55:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: add support for new SMC call format
To: Ronak Jain <ronak.jain@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920055501.2658642-1-ronak.jain@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240920055501.2658642-1-ronak.jain@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0126.eurprd09.prod.outlook.com
 (2603:10a6:803:78::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 37681cb9-1db8-48ca-f545-08dce2d0bc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXk2aDFBbnVpQmtFTkFCcmN4NnJYSEJMekZnMC8rZW9yMmRrbDBGREphVUw2?=
 =?utf-8?B?SVVyWTBvM01SWHByNnZqb015ZkFjNEwxTy9pd0FzSEpRMzhKOU1XM2NuYXIx?=
 =?utf-8?B?VVRkalpLaUFkMktkZUhKa1IzbVh4SGprMXBKQmVtY0oyMERVVllHdjNYV05Q?=
 =?utf-8?B?ZHBTRDI3S3hQTjUvRlBhSEd6aFRtd0JCdjZPcU1Cbjhaa3NtcC9Jalk0aGtC?=
 =?utf-8?B?R1ZMaGtzUFhMdFh1dFRYNEJKYWxTTU5iTWZmYVdrdmJJNVlRVU1ZR29laDcv?=
 =?utf-8?B?dkNETmMyV2tiYlRKczR2L0d5NWZod0doQ2lZVzB3UjNaaXZWbzIwa2ZzZUZZ?=
 =?utf-8?B?bXNFempTK0FXbDNvdTBQbmcrVFlONHUzOCtvUmZ2KzgwSVJHbzVlOUk1VnNx?=
 =?utf-8?B?UkNqVFBqeVFEWS9iR1NGZnFERzZjNGk0ZTB0OVp0Z2NwUHMweGNXWURzUzll?=
 =?utf-8?B?RTBVZ0lSMzFiakNQUzJBT2ZJdjEwWG9QODNBZXhkWW9SLzJ2alZUTllMbTMz?=
 =?utf-8?B?dFlBaUl5d2t0Z250RGNqdWNKK25zSlJzcVQ4VlZvVHVOSHVzNVRiNjhGUmto?=
 =?utf-8?B?dFIxRVZiOHlSUUhRZW5lakYzYy9SbmdXMVluVi84aUVmeW13ZStOelF1NERv?=
 =?utf-8?B?L2lVQ0pBMnNaMU1KRWR4VFQ5cHRreFBIdm8xaEhkYTYvaTFUaFMrMUY1RHhr?=
 =?utf-8?B?N1ZVbmdKT01pSCs0QWYyNlY5ZklQVmFxME1zcTU2VS9mL21SYTR4NFdLTDJB?=
 =?utf-8?B?RktqazN2bHdzTEc4RmtKN21weTYxalZjZ1BIZTBDdG1HNGlVSGpYNXdaVlZh?=
 =?utf-8?B?SjI3TFZNRmY5M0N4SE8rZXhLeG1WNzU5ajRvcDV1aFBVdFZXenBQSzRVRVg0?=
 =?utf-8?B?TitBRkUrZ04ybnk0bjEzVGVoUmFqZ0h3QnBFalhLSjg5M1hqbGhNb3JaYVZI?=
 =?utf-8?B?aVNlVEQvTUVrelZRdTVoWmtLakNORklLN0E4OWloRThrZHF3cUptY3F1a3Zy?=
 =?utf-8?B?amlTZ056THloNUJtQXRobk1BdUJZeXNrd0U4MG1nQmVrUS9Fc0Rwa1hPalBo?=
 =?utf-8?B?dlhYeDA4U3JCa1FtVzFFN1hHVkZubHI2ZUYvU1lvWWFzN0ZMV1grV2wvNTlz?=
 =?utf-8?B?aGJLb0dnQldOd2toS3c1NkYrWU9pdWErTGRrTHZKZ2h2VmR1QmV4L2c3ZEVC?=
 =?utf-8?B?SzZUaFlObzdQcHNncVRhYVpTdlNNa1owSldPR3A0ZlNMOUNKU3lWOWkweVd2?=
 =?utf-8?B?cmdWbDZGaGRiUEtkNHUrdi8xRXRHeDZLSklVOVg0eFhJSVJqNWJDN0o5bE9U?=
 =?utf-8?B?ZFp3SFA4aFNVVWtteFhJQ3FJQTI0ZVdwUVFNTUF3bDFLdVdrN0k5ejZTbnNW?=
 =?utf-8?B?aXN6anRvWUQwYlFtUjJjMVBNYlVrdm1ZdkdNMWpOdkhUMEQxd0tkbXUxQ1BL?=
 =?utf-8?B?ekhoTDI4ZE5rNXpFSW9CR3I2RjBKa3NxWTE4bm0zNjBTaHBsZlVSWmxBa0Uv?=
 =?utf-8?B?NXpWWGxkYWhuL2VqMlFWblpqUjNId3VmMDRhQUsvZElMTE9EakRTQnYzV2Zp?=
 =?utf-8?B?NUw3d0hYeVIwQ2R5Ymh5SjJ1dDNzVW4yeE84TDgrSXRPZHNPZmh2Wi8wdWht?=
 =?utf-8?B?Qi9oRGlreHB2aE1CWi9tNXJpd3k2bTZhYk1reU1RZENPbHE5VjBMc3lkOGRS?=
 =?utf-8?B?dGxTUUtWNjJpRFdZeUtraE4vbEF3STNnTTRpTXlueVRPVXV6Wmw4NWlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmdueEIzOWM4bEZrS25DRnVnb2FUZEtreWdYTW1aeWJBdHZoNkNnaUNpOUZa?=
 =?utf-8?B?MHNuQUtvK1FFRUE0VjdkMzVyYitFQXJSRDRrNFNxT3FsUm55WUJCYkd2dCtu?=
 =?utf-8?B?cW0rR0lwcHdySVlPVnlSSnl5QlJ2T1ppMXJRVFJJcFlhOHhwNGhjcmcyUWs5?=
 =?utf-8?B?TkJxYm43bmYrTDhqWU4vTXBCTmJRUlFLcHRIQWNlampObTR6eFFTRFA1WnZ2?=
 =?utf-8?B?ZGJXT1FrZ3FnTHBpTW04bDZnWk8wcy92RkxiOTlJSVFFdllFT0lqSGNDS2JQ?=
 =?utf-8?B?TXF0dkFBczJLYTRQd1QxNTBEWGljNHhvTy80b2NSc1d1dFZDeFNSdlRURUdv?=
 =?utf-8?B?c0dENGc2MkNhNmIzSWYyOVQvc1BuaUx3b05LU1UzcUNpVi9YTXJBbjk1RkxU?=
 =?utf-8?B?MEJNS3Rydk1XZGhaa1dKQlFoeTFzTE5Pb3JERjlZMENxUlo5MFpZQnZMNmcv?=
 =?utf-8?B?c2sycUwreVc4emQ2N0lpVytZamd0QnhLMW12cHJMZ3JaaGZTQ0hFWVo4V1ZK?=
 =?utf-8?B?QllhU3daQzFidktob2hTM3RETzRYY25rQXAwY0xXam1hTVA1VjdHTlFiR1lV?=
 =?utf-8?B?cUM5c1p0ekNlSGdraEVPUWhxYSt0bFhIMU9hYzhad0RWQXYxQlNYdjFqS09t?=
 =?utf-8?B?Nm15bVRMRmhJeVhSd21yYm5OelhnRTlnQlk5cGRlVXNwODJLNFBpMXk3eEUr?=
 =?utf-8?B?S3B0Tzgrcmt4dFBXcHREaEZJWm9adEgxWHlxNUhZaUNiZWZaeGRzUy9Wc3ph?=
 =?utf-8?B?dC9nZjBXS2w0SUJoS3Q3dnd2c2UxdXZHanZLMzNkVWNrOFg0MVAySzU1VDg3?=
 =?utf-8?B?bEdiTEtLY3VqNldaT0Z5UmtKZEFJSjR5aWVjcFNtN2dIQXFNTzNlSUU0S2JJ?=
 =?utf-8?B?MXM4MHo3M0NXeS84MkcrUjgwOUVWYXJXL1ZTYVExOGcxR0lhRWRZRHBqNnJB?=
 =?utf-8?B?bnA1bitTUkVjeFQ0QUkydW14L1diS0dFcmtIWDFaRDI0T0FuKzFTU0hMWWFC?=
 =?utf-8?B?U0o4SUw5WVpwNkFLSHlNc0ZrOXN6NzJuYmpYcEFYdVZ1dTY1UklQYStCdzAv?=
 =?utf-8?B?S3ZUdk1OUzdneDYzMEdHbkhiQUZ2UHpteGkyMDEzVVlCbE1kMDN0ZC9iQ2Y4?=
 =?utf-8?B?VkovNXFHQzJYWFEvMWxPWnpmVFNOK3pBTDdwYjFZUkFBajVhWWJ3NE5Xem1h?=
 =?utf-8?B?dDF6Wmorbml1OW9ReFFIOVl4M0xvYWtFM1dqQTZ4aUllcXBwMzdWMEZQd1RF?=
 =?utf-8?B?SVNoZ2NrVzVUV1dKYmFTRWlIQzJFVGkyRHY3Y0tkUUliamRBNk5LR2JaVWxa?=
 =?utf-8?B?ZXlHSlFVelhMR1dGTnovd3RyVkpwS0pOZERNVWR2Y09ockE1cXNQTmZvVUJz?=
 =?utf-8?B?THdMYjVINEZuRVF5RkVtM2lUdHpkVlVQTFl1UjYzZGk0emxvK2pkMy81a2Zq?=
 =?utf-8?B?VE9sT2M2bjl2YWFDZloraXRtclZETThmSWFSZS92ZTNxOTRaYmhEYy9rWVNV?=
 =?utf-8?B?ZzFQaGJjUExTY3l1aUlnRlVUL2trdzFHK3krS3dpcWE1U2ZqNFluNEV6NjhR?=
 =?utf-8?B?RkRZRHA3YjJwUjQ4MjFlSGx1L0U5dlRGbTA5Vmg5OWh3dnFMbVhOSyt5cGR1?=
 =?utf-8?B?K2JIVnRLUE1UZzF1dlRrVjNPa3gvOHVZV3FRSmt2Vi9INkJ6bW53OTVvWkJi?=
 =?utf-8?B?d0htQ2ZJb2VOOElkRHRYYVAzWjMzMDlZMGVManU4cWdtRy9QWGdDc1JlcFEr?=
 =?utf-8?B?cFI0NmNkVFpWWHZHRWhOdFByeFM4SmVmbzJNQXEwaGo4ZjFiQUMxN1dzQ2pa?=
 =?utf-8?B?dHlTZkpiaThaclE1a2UvMzFXK1loYkFPMXZxbmszRHRsYm5iRm1Mdkd4c21p?=
 =?utf-8?B?VmJvOWlNRnl1Q250akp5S1YzajJPVExtSE1RcE4xS3kxNUVNdnBqK1NXU1FG?=
 =?utf-8?B?V3RzYk9GemVrbGlDSDNYcWhLNkdqbXEyWmgwdndBdE9Lc29YSjhYWkJWUVN0?=
 =?utf-8?B?RHlSd1NrdWMxUkY3Z1VoT3A3NDZ6YWZueWpjMHpENzl1dFhyejRTWTRSZ1hm?=
 =?utf-8?B?UjhSb2NnbjFVNGNlalRiU2pwSTgwbU5vMW56UXpQTXN0SjhyTkR6NzdEVHQ0?=
 =?utf-8?Q?qbjQ2pPos2CzrVV91nL821N5g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37681cb9-1db8-48ca-f545-08dce2d0bc8e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:55:32.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kBx4Hnmoxkdhct/qqrYjvX+aRLVCcFdAVKRPmOEer8hP8kuX8BVssEOmf03qja1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876



On 9/20/24 07:55, Ronak Jain wrote:
> Added zynqmp_pm_invoke_fw_fn() to use new SMC format in which
> lower 12 bits of SMC id are fixed and firmware header is moved to
> subsequent SMC arguments. The new SMC format supports full request and
> response buffers.
> 
> Added zynqmp_pm_get_sip_svc_version() to get SiP SVC version
> number to check if TF-A is newer or older and use the SMC format
> accordingly to handle backward compatibility.
> 
> Used new SMC format for PM_QUERY_DATA API as more response values are
> required in it.
> 
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 137 ++++++++++++++++++++++++++-
>   include/linux/firmware/xlnx-zynqmp.h |  26 ++++-
>   2 files changed, 157 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index c8be32d9c6af..5ab0dfb2b225 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -3,7 +3,7 @@
>    * Xilinx Zynq MPSoC Firmware layer
>    *
>    *  Copyright (C) 2014-2022 Xilinx, Inc.
> - *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
>    *
>    *  Michal Simek <michal.simek@amd.com>
>    *  Davorin Mista <davorin.mista@aggios.com>
> @@ -46,6 +46,7 @@ static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>   static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
>   static u32 query_features[FEATURE_PAYLOAD_SIZE];
>   
> +static u32 sip_svc_version;
>   static struct platform_device *em_dev;
>   
>   /**
> @@ -151,6 +152,9 @@ static noinline int do_fw_call_smc(u32 *ret_payload, u32 num_args, ...)
>   		ret_payload[1] = upper_32_bits(res.a0);
>   		ret_payload[2] = lower_32_bits(res.a1);
>   		ret_payload[3] = upper_32_bits(res.a1);
> +		ret_payload[4] = lower_32_bits(res.a2);
> +		ret_payload[5] = upper_32_bits(res.a2);
> +		ret_payload[6] = lower_32_bits(res.a3);
>   	}
>   
>   	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
> @@ -191,6 +195,9 @@ static noinline int do_fw_call_hvc(u32 *ret_payload, u32 num_args, ...)
>   		ret_payload[1] = upper_32_bits(res.a0);
>   		ret_payload[2] = lower_32_bits(res.a1);
>   		ret_payload[3] = upper_32_bits(res.a1);
> +		ret_payload[4] = lower_32_bits(res.a2);
> +		ret_payload[5] = upper_32_bits(res.a2);
> +		ret_payload[6] = lower_32_bits(res.a3);
>   	}
>   
>   	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
> @@ -331,6 +338,70 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
>   
> +/**
> + * zynqmp_pm_invoke_fw_fn() - Invoke the system-level platform management layer
> + *			caller function depending on the configuration
> + * @pm_api_id:		Requested PM-API call
> + * @ret_payload:	Returned value array
> + * @num_args:		Number of arguments to requested PM-API call
> + *
> + * Invoke platform management function for SMC or HVC call, depending on
> + * configuration.
> + * Following SMC Calling Convention (SMCCC) for SMC64:
> + * Pm Function Identifier,
> + * PM_SIP_SVC + PASS_THROUGH_FW_CMD_ID =
> + *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
> + *	((SMC_64) << FUNCID_CC_SHIFT)
> + *	((SIP_START) << FUNCID_OEN_SHIFT)
> + *	(PASS_THROUGH_FW_CMD_ID))
> + *
> + * PM_SIP_SVC - Registered ZynqMP SIP Service Call.
> + * PASS_THROUGH_FW_CMD_ID - Fixed SiP SVC call ID for FW specific calls.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_invoke_fw_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...)
> +{
> +	/*
> +	 * Added SIP service call Function Identifier
> +	 * Make sure to stay in x0 register
> +	 */
> +	u64 smc_arg[SMC_ARG_CNT_64];
> +	int ret, i;
> +	va_list arg_list;
> +	u32 args[SMC_ARG_CNT_32] = {0};
> +	u32 module_id;
> +
> +	if (num_args > SMC_ARG_CNT_32)
> +		return -EINVAL;
> +
> +	va_start(arg_list, num_args);
> +
> +	/* Check if feature is supported or not */
> +	ret = zynqmp_pm_feature(pm_api_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < num_args; i++)
> +		args[i] = va_arg(arg_list, u32);
> +
> +	va_end(arg_list);
> +
> +	module_id = FIELD_GET(PLM_MODULE_ID_MASK, pm_api_id);
> +
> +	if (module_id == 0)
> +		module_id = XPM_MODULE_ID;
> +
> +	smc_arg[0] = PM_SIP_SVC | PASS_THROUGH_FW_CMD_ID;
> +	smc_arg[1] = ((u64)args[0] << 32U) | FIELD_PREP(PLM_MODULE_ID_MASK, module_id) |
> +		      (pm_api_id & API_ID_MASK);
> +	for (i = 1; i < (SMC_ARG_CNT_64 - 1); i++)
> +		smc_arg[i + 1] = ((u64)args[(i * 2)] << 32U) | args[(i * 2) - 1];
> +
> +	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
> +			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
> +}
> +
>   /**
>    * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
>    *			   caller function depending on the configuration
> @@ -488,6 +559,35 @@ int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_get_family_info);
>   
> +/**
> + * zynqmp_pm_get_sip_svc_version() - Get SiP service call version
> + * @version:	Returned version value
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_get_sip_svc_version(u32 *version)
> +{
> +	struct arm_smccc_res res;
> +	u64 args[SMC_ARG_CNT_64] = {0};
> +
> +	if (!version)
> +		return -EINVAL;
> +
> +	/* Check if SiP SVC version already verified */
> +	if (sip_svc_version > 0) {
> +		*version = sip_svc_version;
> +		return 0;
> +	}
> +
> +	args[0] = GET_SIP_SVC_VERSION;
> +
> +	arm_smccc_smc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
> +
> +	*version = ((lower_32_bits(res.a0) << 16U) | lower_32_bits(res.a1));
> +
> +	return zynqmp_pm_ret_code(XST_PM_SUCCESS);
> +}
> +
>   /**
>    * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
>    * @version:	Returned version value
> @@ -552,10 +652,34 @@ static int get_set_conduit_method(struct device_node *np)
>    */
>   int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
>   {
> -	int ret;
> +	int ret, i = 0;
> +	u32 ret_payload[PAYLOAD_ARG_CNT] = {0};
> +
> +	if (sip_svc_version >= SIP_SVC_PASSTHROUGH_VERSION) {
> +		ret = zynqmp_pm_invoke_fw_fn(PM_QUERY_DATA, ret_payload, 4,
> +					     qdata.qid, qdata.arg1,
> +					     qdata.arg2, qdata.arg3);
> +		/* To support backward compatibility */
> +		if (!ret && !ret_payload[0]) {
> +			/*
> +			 * TF-A passes return status on 0th index but
> +			 * api to get clock name reads data from 0th
> +			 * index so pass data at 0th index instead of
> +			 * return status
> +			 */
> +			if (qdata.qid == PM_QID_CLOCK_GET_NAME ||
> +			    qdata.qid == PM_QID_PINCTRL_GET_FUNCTION_NAME)
> +				i = 1;
> +
> +			for (; i < PAYLOAD_ARG_CNT; i++, out++)
> +				*out = ret_payload[i];
>   
> -	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid, qdata.arg1, qdata.arg2,
> -				  qdata.arg3);
> +			return ret;
> +		}
> +	}
> +
> +	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid,
> +				  qdata.arg1, qdata.arg2, qdata.arg3);
>   
>   	/*
>   	 * For clock name query, all bytes in SMC response are clock name
> @@ -1887,6 +2011,11 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	/* Get SiP SVC version number */
> +	ret = zynqmp_pm_get_sip_svc_version(&sip_svc_version);
> +	if (ret)
> +		return ret;
> +
>   	ret = do_feature_check_call(PM_FEATURE_CHECK);
>   	if (ret >= 0 && ((ret & FIRMWARE_VERSION_MASK) >= PM_API_VERSION_1))
>   		feature_check_enabled = true;
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 5b938fc2adad..76d85ad82ec0 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -3,7 +3,7 @@
>    * Xilinx Zynq MPSoC Firmware layer
>    *
>    *  Copyright (C) 2014-2021 Xilinx
> - *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
>    *
>    *  Michal Simek <michal.simek@amd.com>
>    *  Davorin Mista <davorin.mista@aggios.com>
> @@ -32,6 +32,19 @@
>   /* SMC SIP service Call Function Identifier Prefix */
>   #define PM_SIP_SVC			0xC2000000
>   
> +/* SMC function ID to get SiP SVC version */
> +#define GET_SIP_SVC_VERSION	(0x8200ff03U)
> +
> +/* SiP Service Calls version numbers */
> +#define SIP_SVC_VERSION_MAJOR		(0U)
> +#define SIP_SVC_VERSION_MINOR		(2U)
> +
> +#define SIP_SVC_PASSTHROUGH_VERSION	((SIP_SVC_VERSION_MAJOR << 16) | \
> +					 SIP_SVC_VERSION_MINOR)
> +
> +/* Fixed ID for FW specific APIs */
> +#define PASS_THROUGH_FW_CMD_ID	GENMASK(11, 0)
> +
>   /* PM API versions */
>   #define PM_API_VERSION_1	1
>   #define PM_API_VERSION_2	2
> @@ -51,6 +64,7 @@
>   
>   #define API_ID_MASK		GENMASK(7, 0)
>   #define MODULE_ID_MASK		GENMASK(11, 8)
> +#define PLM_MODULE_ID_MASK	GENMASK(15, 8)
>   
>   /* Firmware feature check version mask */
>   #define FIRMWARE_VERSION_MASK		0xFFFFU
> @@ -62,7 +76,13 @@
>   #define GET_CALLBACK_DATA		0xa01
>   
>   /* Number of 32bits values in payload */
> -#define PAYLOAD_ARG_CNT	4U
> +#define PAYLOAD_ARG_CNT	7U
> +
> +/* Number of 64bits arguments for SMC call */
> +#define SMC_ARG_CNT_64	8U
> +
> +/* Number of 32bits arguments for SMC call */
> +#define SMC_ARG_CNT_32	13U
>   
>   /* Number of arguments for a callback */
>   #define CB_ARG_CNT     4
> @@ -130,6 +150,7 @@
>   
>   enum pm_module_id {
>   	PM_MODULE_ID = 0x0,
> +	XPM_MODULE_ID = 0x2,
>   	XSEM_MODULE_ID = 0x3,
>   	TF_A_MODULE_ID = 0xa,
>   };
> @@ -537,6 +558,7 @@ struct zynqmp_pm_query_data {
>   };
>   
>   int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
> +int zynqmp_pm_invoke_fw_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
>   
>   #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
>   int zynqmp_pm_get_api_version(u32 *version);

Applied.
M

