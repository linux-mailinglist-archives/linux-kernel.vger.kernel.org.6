Return-Path: <linux-kernel+bounces-325498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C9975A67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF65D1C22D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E91B86D0;
	Wed, 11 Sep 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MqiuofRY"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D791B4C4A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079410; cv=fail; b=gfogYKQP1PlLyzu2EwKCsWBzlsHWXXLF83k6cx3dbMQC0Lbjw2b8UGZaJjcVxszsZeahxxNm53aCoARStjunBySUGwpyh5layXlvz7R8zYDkgcYB1EXcLGOdU1n0p1sE8BZ7oa0eBUi1qVv1+SM/6Xjtw9HgYaJn+WET7LT3Rx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079410; c=relaxed/simple;
	bh=PseVY42gmchX19BUw0i2uOVAfg+p8cwis3M+GwhtQjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9kPnhml7caZORiX2KBfkogLxUvDMEUt4CF9dcxgfU/TBUV3fdij3+4768t/LtBf/6vJ5wU5RheFlokwRW0sThZvEWIztOOv+NG5nfIo2cONcO4NKvTVv9CVDsFL8PVXYkZTTKzjwoEXAoqyWQfFwqGj67qGxRXMGAZvaJOYcXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MqiuofRY; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAZxP0I8NdkSoT3P/+0v7UR6VmogwVARuQe5z9GK4sxJzXzaKFEagtCS3BIlEytek+tzp7bp/dHKQ5vE1vXtEQEKDvGZ6radblwtwC31SIJXLFGsX6AsYGWoHlpftbjiY6CCo63wOg1WUtBPWyNOey/ysSmt9cJocfrjKa0c3HlsWUTv7J+cztJVYOr/+zQw1HGF9G4onNeYFp38+B1Der5Jk9YvUk5H4PWaxLb7vs+0K4iVikuH3+qGvtf5GKZA4VxNfp3MJ8k1g/HTYWD0+cPfLNm4hwE8MYgSd/v8CHR7nghmv8mzAuwNBgPSyBrL8n0dEXB0JVuKP5M3hIBSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WguP5SRaO/cvlCTrzquUKMn6RZbjmrsSfRSxIFwvnG0=;
 b=tOClSgSpowuA7ZuekuRZGB2B2VhiOO5KJugLpOE6ApKuTuAKH0SK6cG/JKcAKej/gaY7Ql/AkW8myfppbNsMEWFRwNZHyGDCjlld0+382A4iowt1FPw+gSor2n0e7pmm/iLH7Xtm+XL+FMxu0AJ+T5aBdP30dGXoyKjjo7+sqLlIB0FuBXXEb1xBnMTw2ELg97Nsyd1nQnnYi6vyxCj6/ZzO8z0qC3f23xtXJygb9k8QGfgnUw8xDP8KHgVNsJK/5bWyY6zGWpazPUDPzLW0c+ju/edkMFWpJe9V3s9SVDROANiZ0dVGSuBhD7d89evB57j4aPOBTbbmF59SDGMpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WguP5SRaO/cvlCTrzquUKMn6RZbjmrsSfRSxIFwvnG0=;
 b=MqiuofRYnaUDktOm54+NaqAMPKSeH175/jOPvUeEiiAW3N2lLE90WLg+s5YDkndLIlpfmlObQJ2ualT5K5ttr56S3hflRi6rvbaX7+n56+fH6eVdNGs+JkQUxfJv2Od6lEuzpfvFEZoRQeivaiGwA1vDBv3hsrLPCqkz7gt3+g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 18:30:04 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 18:30:04 +0000
Message-ID: <59ec07a3-2215-2745-d045-e06b7b151d61@amd.com>
Date: Wed, 11 Sep 2024 13:30:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/7] Provide support for RMPREAD and a segmented RMP
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
 <20240829065636.GBZtAbpOVh0lHr7VxG@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240829065636.GBZtAbpOVh0lHr7VxG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:806:127::21) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be8aa5e-2f63-4141-c56a-08dcd28fc0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0kxL2JIMFM2UktTQ1FrTk9rMnc0b1R1aW9IbWVpWmRFSjVEcGszRjFRT0lP?=
 =?utf-8?B?S2dJVHVNTUg5SDFMUktHMHJUdmgwaUpLTTNRMmpzRmdXWXZQcElWYTJ1Q2xO?=
 =?utf-8?B?MkEyR01jdVMyOWJXdVN2Mzc0cDJVQWlJWERyUURjRjNvclB3MzQ4ckV5TUxs?=
 =?utf-8?B?SDlMZ1R0NSt0NUgyZDcwVWg2N3o1eVdmclA1UUpER1hYeUd6dFR3K255dHZk?=
 =?utf-8?B?Y2pQYTAzUmhPYlVGallmeHBVNStHUEkzRnZ2UkRINWVTdmE5ZTV5aHFSWStJ?=
 =?utf-8?B?OFZIanFDc1VoN0NBakJGZEpMazZKdy9kM1NSYXdHT2tPUGRNZUFHQVhGZGU0?=
 =?utf-8?B?QnpHM0VMT2xSNCtCUW1HWWc2MVgrVHBNSTVqVHVMbFNUNTdMVzFnR2JJeHZO?=
 =?utf-8?B?ZHo5M05Jd1JrUTI1UU10OUJZSnd2WWNqaGtIY25vb3MzTE5FTnIrOW9aalN2?=
 =?utf-8?B?YWxJMXlvanJYYXpldGFZd0diMk5zOWhnMmdtSGRqKzVlOVgrN1dUTnBBalFj?=
 =?utf-8?B?UkxwcmNQLzB3MUtQLzBaME5hcWRpeGVnajFtY2VZY2MxMnk1QTI5dnJFc1c3?=
 =?utf-8?B?bjJZMjhUSVZSUjFwWkdXZ0svTjRwK281NnFONXdsVmRJYi9FOHo1R1ljZEZT?=
 =?utf-8?B?TUY0alhWZlh1bVZDdWVJbW1vSDZ0ZURiMnRsS0QyS3dRRTZiYzhlaGgvajJl?=
 =?utf-8?B?SkF2VUwrSWM2a0F3Y2p1ZlM2ckh5OUxJa05lTzExM3M4N012eHovc2xPaFJ1?=
 =?utf-8?B?QUJnSVFLRzFnR05CVmt3cldza1hGdEYvVWlzZFNzVlRYKzdHQStuSG51aWg3?=
 =?utf-8?B?MTBld1BPTDVLcm55dHVKMHJIWDdhNWE2S2pKMTdWYWNMMzM0Z1lXVmNQWng3?=
 =?utf-8?B?cVhZenhOdTBxaW41N212eEk1UnZiaFhQOWtTNG9wMnprVkw0cGtLc3l0ajNH?=
 =?utf-8?B?a1ZXU3huZ0RsdzF2cW9uU0RjaU5vKy9WR0NJTHBDb0tsOHRJM3J1QzVHK3V2?=
 =?utf-8?B?K0hzNG16dU5QeE5RTWhTdVB2UjRPNUZCOWpEVWV4N1ZFUkpjTUE2T1d1Q0RU?=
 =?utf-8?B?OTc5L3h1RmgybUJ0WVpzSDVORlNJRExidmM0d2xCN1gzb3g4Q3lMUTFzUzN0?=
 =?utf-8?B?elpoZUp0UWJ3YkJ3RDAvTXZOaHNWeGhDQWRVWDdUZmE4Tk5odVNNenVJRjBr?=
 =?utf-8?B?cjZ2NG8wUWFrQmx2c3BISE9pL200QnNKUlEwSWVrVnhNRWxaemFrSVNSUFlw?=
 =?utf-8?B?N2k4ZWhycUxqRVRkYmVsNFhBZTJWUCs3T2U5V1A5RVB1dnRFNiszQ3ZIcWRu?=
 =?utf-8?B?VUpBNFVFb1QzSDJKZlFZYjBPVXpnTGIzY0tJU01Lb3dJSFFxWm1zeUpVRGN4?=
 =?utf-8?B?TGQ4VEhwUlp6WlJTZk16MW1mbXljbm11K2x6VWw5V2REVFBxV0FlMzRaQ2Q3?=
 =?utf-8?B?T2hLT2xMeTRkTWxDSFdtdHJZb2x1Z3pmMkozZERLamduWUQvZjJsY3hsNXJD?=
 =?utf-8?B?NS9OdnV6Wlg4Zk1sbmU1RHAzNDVqSkNFQmIyZlJBdW1tYVhZeXlpQWFoZTMy?=
 =?utf-8?B?WHFiMVc4NVR1L1ZxZFR3TGYrTGo2L0JUaGJMTzA4cTRidzVsZFUrMkhsRjBE?=
 =?utf-8?B?dTEyb2kvZmVqckNYVUk0M216L3Y5UGJEUStET1VxZXIvdlpqOEllc0QyMjF5?=
 =?utf-8?B?Vm9uaE0zYzdCcTlaVGw3ZFFiUlRqNWo2Y2txdndFTXdJblRkSmxtRnpsRDlE?=
 =?utf-8?B?NGpxenhreUFXQ0o5anhXenJWOE9Wd1U5TkNPNjJLeE9ocFdjUGc4aW1MS3hP?=
 =?utf-8?B?WGNWa3dCcGthZjdibDJvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3NVSHVlZHRKSmVkVHZWaVVYQW5XdG9DMktIMU1OcnJucXRyS2N2RDJ4bmdw?=
 =?utf-8?B?QUxNcXRqSW00MTYrTkVCZHFHcXJJQU9YL1k1RFpUemZvdFdCQWNQaDRUTlRn?=
 =?utf-8?B?WktIOVppOUNUUWlJQ1g2K09wcXpBcENhSlhocDQ0aUEydisxSUhwei9CczFq?=
 =?utf-8?B?QkpkNVl5RHZDNXVrM3Z4bmFucU5YdWZySGRzdm5RR2pkbDk2VE5hWjJPU1Uw?=
 =?utf-8?B?V1dFT2F3NTVOeFN4eklrNDIyVUM5MXN4VUM4MFQyZXBBTC94Qjd3ZU9yYUZj?=
 =?utf-8?B?WWllTU1RMExLaGZZY3JvYjlrek5waDBDYmlZV1hXMkcrS001NWJLSXYxcXhz?=
 =?utf-8?B?T2xzb2VFTEZJMmRKSlRvZVk1YjFCREtyYjFPQWNaZmlkd0czcFNwSlNCYlBm?=
 =?utf-8?B?K3J2ZnFndFQ5RkVkTUFxWTJsQ0hveHhjS05RL3dFSWdmT0ZkMlFwc3BoSkw0?=
 =?utf-8?B?bE85c055bjFTK1QxamFXTnUvUUxxUVBpNkVndVRJRXdwUkp5blZxSWtyMG1R?=
 =?utf-8?B?WENoa2hnWjRwMlpBYnRtT1QrRXNwcnBYNGVhQmJwa2VlZEFjQ2JhRzlYVE5I?=
 =?utf-8?B?QlcwNlBweEJTT2ZkVUpmN25Gc042akUrUlA5ZmZmdVFWTkgzMVp6Z0YvOCt0?=
 =?utf-8?B?bDNTTmFuT3I4SzRpTnNTVW56SHBYVk0ranlzV0NoMnNOOW1OcE1FUzF4NFl6?=
 =?utf-8?B?U3VpU1RnMmFPaGhxOEkxT200QXBUMzV2Q1ZZcFRjYjhrQlZ6VHpZdTZkYkJ4?=
 =?utf-8?B?dThpeGpnV3JYZFloNkUrL2hHWmRIZHJUcHQ2aTZJbjY0Zk5UNWF3YjVhMkQz?=
 =?utf-8?B?WElPaVhGUFpMcnlrMlZlT0hzQ0luQXJRejIwM0pZWTRDWkxqNU5Zall3VjQx?=
 =?utf-8?B?UDlTNXBJZlZBaGlWSG5ndDFhL2kwZXFGNFFsMUlHNFpaRDBwdFNsS29UOStS?=
 =?utf-8?B?OUZ5SFVuNVhWRUlGeXZ1dXg4bDRZdUFEaUNpSVdWL09YbWhIMTV1STJ5ZFlS?=
 =?utf-8?B?RlVuNjdyY1N0ZGgxYlhtcnh5WE9KbExzV1BrNXQrLy92WHFEbTRGSVcxMUNI?=
 =?utf-8?B?bWNsUmpaWWtVbkF4dVd6V29BZkM0TnlJOE1HcDU1TnJzYWcydy9MaU9jbTVs?=
 =?utf-8?B?S2VmQ3hTanAzQXhGOSt5TE1BTXQ1dzdMVjlJWnE5QUJyZ2lJQStGRDBCdFh0?=
 =?utf-8?B?RnBNbnhWZldmamp2WFNMYjdzcTMyMUs4UzBzTnJEVkU1bVA3ci9iQ3lVNXQr?=
 =?utf-8?B?NG5WZXRtR3FwN3Fpb2RQemt1REpaOGZERk1RWGR2S1V3Z0xKeGMwZTMrU1dU?=
 =?utf-8?B?VVJiZFVveXNmdGRJNFJNNWtkeFlXdXI3TENPMVVnd3N0eUQxOC9UVGZKQmxi?=
 =?utf-8?B?UVpENTBIRVpaYzkzRUpSNzRzdEtidFF4VVN5M2U3aXZvOCtvZkN2b1RCVlNV?=
 =?utf-8?B?cmpHb3NGM09ROTh4RkFGR0JGZmttS084Z1lKM2tzeEFZQmdiQnN3UFF3OS84?=
 =?utf-8?B?cVArUXlnVEVRVmhkQ3hiRnFueFlGS0N5bjY1Uk5FWDJ1dEhEdXZFbGFFYUV3?=
 =?utf-8?B?SE1uUmJ1SlhodkdCaUpsaXdPdFRvMkhSa2doT0N5ZHEwMDM5Tmh3WUY1N1Zl?=
 =?utf-8?B?RHNnNmd0eC8zbm16bkU0TXJIa1dGSXNuOUUvRkhYdWJDV2E4ZFlteHc5L0xN?=
 =?utf-8?B?eGpQSDVGdlhLSG5MUHZhN2U0OHhtMHBLQ1c3Nk1Ec1hhYzd4K25pSEcrRTVV?=
 =?utf-8?B?aU00TzZ1aE91WW14cFl3Nis2MXJPUG5yRFNIUHpGS29zYmZlOWVSZERIQ252?=
 =?utf-8?B?ckNpS01qbUYyUjdYMFF1RndFU205cE1CMlhiWlRWMnc4SE9kMndqR3hJaUdj?=
 =?utf-8?B?S2oyY3o1ajFMeWsxZEtReDNPM0pNM2d2ZGZ6eFFrd1ZJUmxlcUdwMkdzL1Nj?=
 =?utf-8?B?UmFnam5sM21ML3RXUHpIVU9kcTRmZmltOGlnZlpBVTZ1WmhSTWtPNnI1V2Nn?=
 =?utf-8?B?aFZIc3pCRlZEYnd0T1ZzdFJkN3F0OEVPa3pBRitZWWpNZmpLY20xSHRJTnhI?=
 =?utf-8?B?VTEyWmRKVU03NldTazZVOUVzR2h0dm9xRVV2QWRnOXJSRllPdS9HRW5kMEwr?=
 =?utf-8?Q?7Gf1kYoTLB234X4K5R6Hme7C+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be8aa5e-2f63-4141-c56a-08dcd28fc0d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 18:30:03.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mbRbUFOh+f/nwzws481er8SvD6u1Vko09ZxGXJ0WnF6kZ33V1cjrSwQfS9+GsNLwVVbxbhH7cSVhnsMeM5Seg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

On 8/29/24 01:56, Borislav Petkov wrote:
> On Tue, Jul 30, 2024 at 02:40:00PM -0500, Tom Lendacky wrote:

> 
> I could very well use that nicely gathered together info on segmented RMP if
> it were, say, in a section in
> 
> Documentation/arch/x86/amd-memory-encryption.rst
> 
> for example.
> 
> :-)

I'll add this (and info on the contiguous RMP) to the doc file and send
out a v3.

Thanks,
Tom

> 
> Thx.
> 

