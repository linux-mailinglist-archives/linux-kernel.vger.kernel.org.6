Return-Path: <linux-kernel+bounces-333996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362397D135
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B211D1C21ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035943B192;
	Fri, 20 Sep 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kl3zzKL2"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E733F6
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813925; cv=fail; b=fFRnF7yqmjalvSNutyUDyyh/LMqpf+6SSB+4+2NdBmtoRX0ili9+jJZRYiINaT/0Lj2xVBpwgRSmjzDmwo+ZDNvdNYXl4mmGYtfH4F2Hkug81cQAFo6BaXksDS7s2NZdHZDAc+kRgW+cR/yKWhWGrwc7VXnO8DSWGsYuGjLapWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813925; c=relaxed/simple;
	bh=00j3u/Fko/Z4Np8ZmYCAA7Y81GgW7zwfMFJpBFfcxaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJjgAQ1C1orAxutUtfTdL1vcq2YpNXQVKun/7zweEU8yCUPtTKldhrc0AOYgi1anyyxynNryGg9HsjCeHzlYy9xVRErnIqm1qjDZ2UPyyIW5hn9T10aoN1xzyK+QVkHWh6raXhLx0/5DKWpiEtFFuBU1kXCBiI5dDYXU2H0yKHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kl3zzKL2; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdPik61G705jjutG7P4w7rCMalznuPuLkzXCk2WikEEWYJk+PScdtiaaIonP0LGZKcVIoE9v0XaXkCwM2FbrqKtegBoTKpT4bLg38N69LkvNHvRqenHRZyDJ9TmV0QP5i7YxoOjauZqcOkIU1AXX79t3q1gF8xMBHOyw+8X9rptOsAXSNXN4q185FP7MKZ3OWuIVj7sryi0PSBc8i87Tr7mQAEyUsBPL/3Ax0GXB8SLERi6gPasXUp60GReYCvV6K4tDPkdqnRgNqEd78hPN7S7S/lq2loW+VPaNvm+2Gur9x7JHgq6NLPNs+AVhD9fI03CnZjWwU1yhoGLJvsv8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwLXHicWc3E5zv8v32ds7xZiZ87vzwKmBIAuql5eQls=;
 b=QUO3iufnmkLWJKZD2dI1FTXI5LPRYIt7IL+uSYB3sejzFc9rFhu+vJwi/HsoxPYRGOKJfU/qq5xNewaUKHD3SZDr1U8BVq4qonEAD5Me13eHm0iZ7qVUEnIeHYejoR5ZR2BXWU+SatkL5qbKGJL6+RmdQp4qRUBWfntE/zEeysILnIIYVlbKPAxBeAeSIDKQ58T2DN1uskx3LLLdxVA1VKnIWzi00a72kAuxFVQttYrONo3tvHKO+FxG243UCn9GsMceMkZG5qdU6LhosCu7qiEQ0plhsuQPelEySV+lXsYQpb6MeJrcyDdwza0n3z8X+6I0HPOniSr80Y+GOzkJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwLXHicWc3E5zv8v32ds7xZiZ87vzwKmBIAuql5eQls=;
 b=Kl3zzKL2SMnFAeFjEL0ThF2Hiu5vexUzS5CvD0IXo92+BEJzNXtFsA5eEJXFtry6iKqq8qAMR3YLD5s1+KNDW1r5CGruyHINrhhRtQUAEedz69N+tdyzkgB2q1geGX+EyZY3KYrxywx4FyHKAubHlC1GTPL7LshqJi4VBH0ntwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 20 Sep
 2024 06:32:00 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 06:31:59 +0000
Message-ID: <f5eaae87-23c8-42cd-97fe-542a4d17c682@amd.com>
Date: Fri, 20 Sep 2024 12:01:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmscan: Fix hard LOCKUP in function
 isolate_lru_folios
To: liuye <liuye@kylinos.cn>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Dadhania, Nikunj" <nikunj.dadhania@amd.com>,
 Usama Arif <usamaarif642@gmail.com>, Yu Zhao <yuzhao@google.com>,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, Breno Leitao <leitao@debian.org>
References: <20240814142743.c8227d72be4c5fd9777a4717@linux-foundation.org>
 <20240919021443.9170-1-liuye@kylinos.cn>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20240919021443.9170-1-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::32) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: d34a3941-066c-4196-1032-08dcd93dee41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUt6ZG9pRDJyRG00NnlmMVRETllsZmg5cHBiZ0U5Y2dsTFJiNEJReUkxM2NH?=
 =?utf-8?B?MGtvNTJTaUdIMTR4ZUtrUjFXZDZid1VhOTR5NFlJQ080a0F1cnNEUysrUmJn?=
 =?utf-8?B?MlZ6WHNxd3pBVVNUM1Eyb2N3dUVoU2pmSlZEakloZnhNeHFCMi9ScldTU3ZS?=
 =?utf-8?B?TU5OTW54MS8rWFRIR0JVeXU0SnhueEhYWTlleHZHVkxtQmNnNXJIOFRQbmxW?=
 =?utf-8?B?dDY4Y1A2ODQyTnpYMXgyVWZtS21oTm5HaFRZTWZrcWYydzhzN1dKbElNQ1Rw?=
 =?utf-8?B?WVlnOUhuc2xQQWtKY2JjUERWMlJDQ2xmRzZ3anRQMnFaSlJ2QzVNMlZoNVhG?=
 =?utf-8?B?ekpZWlFkTUVpbVZQWnlIeDluTlR2R254VjR5bklQdDl5UWlVdDlsTlhUdzZ0?=
 =?utf-8?B?Z2I3czRrMEdaUEpDU0ZsR0Q4RGJ5ODhJWFl4djJYdU9ML3BpZlJ4UXRjNklJ?=
 =?utf-8?B?amJqMGFiUG5CcVlVWklsK3djWGZleWZESlZsVGNFL3VSemFpL1ZmRXE5aGVF?=
 =?utf-8?B?R3p4R1pXTkpuUGh1NExCVFpxbUpyNzdBUE5QRFhoc0RBVmpJeDBNRmQrelJ2?=
 =?utf-8?B?UWYzN0Q4Q0VpVzgxOTNkcjhlK1JtUk9RNzVvT2JoRENGakRYamhkMVFDWE1B?=
 =?utf-8?B?clNzbDVoeXlaV3hWRUk1VWs3YVBGaWNBTXZnem9XbnFYcStUTWpEV0ZuVmIx?=
 =?utf-8?B?UXp5dUlXZjYxajAvbmhwOVo1RDFITlJ4bng3OWVGcmVGTG1pR0RaWVd5OU5j?=
 =?utf-8?B?NS9pcldiK3RsUzFaaFJlR0I0VmJMWUZVbUp3UEM3Mm56cTBKdU15S3pwdE54?=
 =?utf-8?B?aGxnaDZhTlRVemo2am5sYWdMd0FxelBzeXVNNGxnQ29ranJYUWo5OUNwMFhV?=
 =?utf-8?B?MTZkTzAvL0cvUzNXTVQ5RTdwSDlDekRUVnlMenJQVUowRlRMSndoUE5USGxh?=
 =?utf-8?B?RDM3WCt2Z09UbGpzU3I4SkttWnNpODFxMkJ6S1A5OG8wdjhMemRtMGFONkxZ?=
 =?utf-8?B?UUZnblpkNHYzUlpCVUVxQlRyUjk4UTd1RUpaMFZjWTJHSVkvZUJVSFZhdFVw?=
 =?utf-8?B?SUxVUnNFRFRnRHhzdVlycFVQT3RkQWdKWGFCcmZoRTI2SVF0R3pETGY0bUlV?=
 =?utf-8?B?RmJvdmkzaTBzdGUveTN2K0NQSEJWbTA4ejZHV2NqcXlhU2psM3dLYTBNaXVI?=
 =?utf-8?B?NFFBOUtidG5UZ1MyOUdXcUVVdG90cDhxU1JHREkrRFdOanFscGFENnM0QnVt?=
 =?utf-8?B?dGxLd2R0QWtJZGR1TEFiYkRSWEdLV0ROQW9yeXBRZFNuZ2g3WlUvQVA2U2px?=
 =?utf-8?B?Y1lKQzdkN2pkcnlrdW9oZHd2Y0thU0Q4R0l4VWx3UXhMZURPZXZLWkJNSFBu?=
 =?utf-8?B?YXloZ1o0MWd4Q01HN3Q5Y2V3YVJxcThSQkJURkpXeWpnNTZRajN5cll0aENU?=
 =?utf-8?B?dTZjQTk3Szd4NUNhb0t6TzQvNldUc0g2SUU4Vlp2aTJkdStMWnhCb1ZBVVZN?=
 =?utf-8?B?MFg0QmttMmlnVjJMOUdtY1k3T0RWRjFzSXRrc2RwWkttRWhHYzhSemJPYTJ6?=
 =?utf-8?B?dVVLSzNUR1RFYjlXYzZOQjBtMkZqeEVuRjYvcmFhUDhRdGRlMGxrUDU1dTdW?=
 =?utf-8?B?M3UreStuN3g1YkVCTEQ1TVIrS1J6SDdiUmU5QkFZTGJHT1p6QUp1YW5FYVhn?=
 =?utf-8?B?OU83UXYyZXEySllHRkhuUjJmU1FQcERJTU5tcEJWNFUxSGNnVjkzazJKMHFN?=
 =?utf-8?B?OERRemUrYTJoNko5WlJkdVlZSE1IbW1FUWNYOGtTajhCSGI0Wml4RnRSWTdx?=
 =?utf-8?Q?QjTOIBjrnZtZ5fiJnhXYWqwlfDAkK2E1BU6zs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxvWmlwRnAyQ0xKMm9UYnpyajRQSkR2bGFhQ01FcTg5UlBDWS9nQlptaE9F?=
 =?utf-8?B?a0lpSk5DNzdDenZOWUtxVEptcDYrSUtYNDRoMGpSd0V1WWU4S0U0bnhqT1VH?=
 =?utf-8?B?ZElGOXR5QnU2NVJrL2NhVFg1L2hsM3REc3dNUUlRa1l0ejBYSFFNYStieHRW?=
 =?utf-8?B?V0cvc1FqRy9UT3JpdGJsQWNtTnFZVTlTNEhKRmdzajNDZW55RktTMnBVQlh0?=
 =?utf-8?B?MTJwaXM4K1Zra1hhRDJXVFpwcXdianNRMDZQZWFyVExyZXBMelgyT1ByYk15?=
 =?utf-8?B?My9JSHJ3dDNYOFpLM0ZBMU5Xc2ZFM3BnMnFCT1RiSTVvSDl6UVBiQzJGbFE2?=
 =?utf-8?B?c1hnZUNFQTlsVEx4a1oyanpkdThmOHRCVW1aZnF4ZkM2c0J2L0RjdEFCRzg3?=
 =?utf-8?B?NnFLamF1aEV6cTJSU0NvWVRHWThodGZhSG9CS1cvclJwOGJ6UEErSnZBanF1?=
 =?utf-8?B?WWg2a29YaGhlWk5CSTY1NHptQ1RmcTdKY1pnM2Jud0Q0NkJXK1hUWko4bzh1?=
 =?utf-8?B?clNsY0hrOUNOeEhmUEo0QjZyWkN1cXJ3SGlFMTZpU0NnemV4TWVCL1E1ZEUx?=
 =?utf-8?B?SElxZGJvV2xyWEN2dUQwTDZhcFJtNkFBQkhLNkdZOVdhWHhZNFV6R1p4VkYw?=
 =?utf-8?B?Mzh6MGRnallLckM1UC9nK1dqdUs1REUvMGp1WTVCV01PbjZLUytzOGpjN1Zs?=
 =?utf-8?B?UVZCN2RWaFhtL2RZMHB4TjR6YmtKT3ZUL3lVZWR3c3N1NGNKZU1GWXRtdHJj?=
 =?utf-8?B?ZnU2QkdCeDFyTGJNU0pIblNCZEtOVjcxNTdXV1NJZFVqRU5SWlZKUUc4a3N4?=
 =?utf-8?B?elJhSnp4VFRJK1R2bGMxdWRjaTVKMVEvaTVEV1FvSkZ3WWphK2xKUTI5aVZa?=
 =?utf-8?B?YitIUGl4aGtGZkViYWZoVDBSM2R3L1RvU3lJZTBCcmJ2S25XQUZWck1MajZl?=
 =?utf-8?B?Nk9KeENtV3FtSkJaVm8wK25rVFc1UUJ5TzBoOGJoZ3ZRcHdrQWhqUFJtcElN?=
 =?utf-8?B?ZU41K3dFbXpIVXlIOVpwYjZxYVZxQmRHaEdZc3B4NUFLY0NoRThvTnptNmtE?=
 =?utf-8?B?ajdwZ0ZkbmZIWXhPY3Uyb2NCRE82d01XYldtVkF1M0lMZmNKRHNtdUhYZUhX?=
 =?utf-8?B?RnpaY2JBa28yN0I5VXA0VDk4dk96Y2crNE9IOUUxS2MwNTVEd2pDaWJ5cVNh?=
 =?utf-8?B?RzdsdWRUc0dpRzRXVVNVUEJhVkQ3R2RiNE1oU0J1cXF0UkxreW9NZFN6eDBz?=
 =?utf-8?B?blRHQmFrOUJ5eEROQXMzSWNmTklRekx2OVdKNDlFcE9RZk5rSTBMNDRqdVhQ?=
 =?utf-8?B?aFQ4eDJZR3FYTitMR0hTM0dEdEdZMDQ5QTZnNTNicUI2YWFNQk1RRkoxanNt?=
 =?utf-8?B?K2c4N013Q1RUdStZaERwa05LZlRkT2pNSmZZeURYWlhITTFoeUhWRS9xTlBK?=
 =?utf-8?B?MTNscC9lYkpRUE9aUE1XMzVEQmNER21SNWVnNWtqakNWMmZZSENQUXZnSS9k?=
 =?utf-8?B?NXFHendtQTNNMVZsTVhYVzgyRGNiOWI1Qnc1OWEwWUUxeFVOVkNZampFeHhp?=
 =?utf-8?B?WVFjMFFNVGxzbHZuemZTaGR1SHpNVFkzaktKMi9JQ21NZG1BdXVvYTJWTEhL?=
 =?utf-8?B?amxZRmFDSzk5SmxvSXBnbkl3RlV0SWtGTTUwREhyMzR1bWxQdFNRckFiSTNM?=
 =?utf-8?B?eXIrd3AzQXo1VkNyMytyb2lHMHF1WkJOVmJRVEplcU5FQzFsL29ZL05EV05Z?=
 =?utf-8?B?Q1lWUU5nT2IwTG9HcTlJbnFhT3dYTk5BZHczRWxjTlc1djF4bGtaemFMaG51?=
 =?utf-8?B?RHhwd1VZRXZCTlQyWlVLbmFHeG5YeXFBWEhFMk1DRVBERXYvUjVFcXcxRWcx?=
 =?utf-8?B?RWt3Q2JpdGlUdGtKTmNoZTF0RnNCVGdjbFhzYlVUdGtTME9vYld2Wnp1MnBG?=
 =?utf-8?B?NTB5SjA1T2RtRlo1dkdpR2tYT2JLK2x5elFGNVdxb1RJMDdSNjQweUpTckpn?=
 =?utf-8?B?eUVQemY3STcwVEVPaE45YVFSckk5cGhZYWNZVjVIRUJvc2ZqTXJRbERRSE1R?=
 =?utf-8?B?S3JUTUZRbUZoM0FOVGNQWFArblBqQW8rSEVJeDRXTXl5dVM5cUZRck80VjFr?=
 =?utf-8?Q?Ea2aIcFGNTFemUdPGG4FVraMO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34a3941-066c-4196-1032-08dcd93dee41
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:31:59.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7o8FrXqwm87f7pV1SAdhf2tBMmCUXmfXMvP2lCW+TBU/PoB2jyWwCh6rbZ1/m2bBiyR5mvbvjNI3uYd2r3Dyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

On 19-Sep-24 7:44 AM, liuye wrote:
> This fixes the following hard lockup in function isolate_lru_folios
> when memory reclaim.If the LRU mostly contains ineligible folios
> May trigger watchdog.
> 
> watchdog: Watchdog detected hard LOCKUP on cpu 173
> RIP: 0010:native_queued_spin_lock_slowpath+0x255/0x2a0
> Call Trace:
> 	_raw_spin_lock_irqsave+0x31/0x40
> 	folio_lruvec_lock_irqsave+0x5f/0x90
> 	folio_batch_move_lru+0x91/0x150
> 	lru_add_drain_per_cpu+0x1c/0x40
> 	process_one_work+0x17d/0x350
> 	worker_thread+0x27b/0x3a0
> 	kthread+0xe8/0x120
> 	ret_from_fork+0x34/0x50
> 	ret_from_fork_asm+0x1b/0x30
> 
> lruvec->lru_lock owner：
> 
> PID: 2865     TASK: ffff888139214d40  CPU: 40   COMMAND: "kswapd0"
>   #0 [fffffe0000945e60] crash_nmi_callback at ffffffffa567a555
>   #1 [fffffe0000945e68] nmi_handle at ffffffffa563b171
>   #2 [fffffe0000945eb0] default_do_nmi at ffffffffa6575920
>   #3 [fffffe0000945ed0] exc_nmi at ffffffffa6575af4
>   #4 [fffffe0000945ef0] end_repeat_nmi at ffffffffa6601dde
>      [exception RIP: isolate_lru_folios+403]
>      RIP: ffffffffa597df53  RSP: ffffc90006fb7c28  RFLAGS: 00000002
>      RAX: 0000000000000001  RBX: ffffc90006fb7c60  RCX: ffffea04a2196f88
>      RDX: ffffc90006fb7c60  RSI: ffffc90006fb7c60  RDI: ffffea04a2197048
>      RBP: ffff88812cbd3010   R8: ffffea04a2197008   R9: 0000000000000001
>      R10: 0000000000000000  R11: 0000000000000001  R12: ffffea04a2197008
>      R13: ffffea04a2197048  R14: ffffc90006fb7de8  R15: 0000000003e3e937
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>      <NMI exception stack>
>   #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>   #6 [ffffc90006fb7cf8] shrink_active_list at ffffffffa597f788
>   #7 [ffffc90006fb7da8] balance_pgdat at ffffffffa5986db0
>   #8 [ffffc90006fb7ec0] kswapd at ffffffffa5987354
>   #9 [ffffc90006fb7ef8] kthread at ffffffffa5748238
> crash>
> 
> Scenario:
> User processe are requesting a large amount of memory and keep page active.
> Then a module continuously requests memory from ZONE_DMA32 area.
> Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm reached.
> However pages in the LRU(active_anon) list are mostly from
> the ZONE_NORMAL area.
> 
> Reproduce:
> Terminal 1: Construct to continuously increase pages active(anon).
> mkdir /tmp/memory
> mount -t tmpfs -o size=1024000M tmpfs /tmp/memory
> dd if=/dev/zero of=/tmp/memory/block bs=4M
> tail /tmp/memory/block
> 
> Terminal 2:
> vmstat -a 1
> active will increase.
> procs ---memory--- ---swap-- ---io---- -system-- ---cpu--- ...
>   r  b   swpd   free  inact active   si   so    bi    bo
>   1  0   0 1445623076 45898836 83646008    0    0     0
>   1  0   0 1445623076 43450228 86094616    0    0     0
>   1  0   0 1445623076 41003480 88541364    0    0     0
>   1  0   0 1445623076 38557088 90987756    0    0     0
>   1  0   0 1445623076 36109688 93435156    0    0     0
>   1  0   0 1445619552 33663256 95881632    0    0     0
>   1  0   0 1445619804 31217140 98327792    0    0     0
>   1  0   0 1445619804 28769988 100774944    0    0     0
>   1  0   0 1445619804 26322348 103222584    0    0     0
>   1  0   0 1445619804 23875592 105669340    0    0     0
> 
> cat /proc/meminfo | head
> Active(anon) increase.
> MemTotal:       1579941036 kB
> MemFree:        1445618500 kB
> MemAvailable:   1453013224 kB
> Buffers:            6516 kB
> Cached:         128653956 kB
> SwapCached:            0 kB
> Active:         118110812 kB
> Inactive:       11436620 kB
> Active(anon):   115345744 kB
> Inactive(anon):   945292 kB
> 
> When the Active(anon) is 115345744 kB, insmod module triggers
> the ZONE_DMA32 watermark.
> 
> perf record -e vmscan:mm_vmscan_lru_isolate -aR
> perf script
> isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=2
> nr_skipped=2 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=0
> nr_skipped=0 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=28835844
> nr_skipped=28835844 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=28835844
> nr_skipped=28835844 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=29
> nr_skipped=29 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=0
> nr_skipped=0 nr_taken=0 lru=active_anon
> 
> See nr_scanned=28835844.
> 28835844 * 4k = 115343376KB approximately equal to 115345744 kB.
> 
> If increase Active(anon) to 1000G then insmod module triggers
> the ZONE_DMA32 watermark. hard lockup will occur.
> 
> In my device nr_scanned = 0000000003e3e937 when hard lockup.
> Convert to memory size 0x0000000003e3e937 * 4KB = 261072092 KB.
> 
>     [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>      ffffc90006fb7c30: 0000000000000020 0000000000000000
>      ffffc90006fb7c40: ffffc90006fb7d40 ffff88812cbd3000
>      ffffc90006fb7c50: ffffc90006fb7d30 0000000106fb7de8
>      ffffc90006fb7c60: ffffea04a2197008 ffffea0006ed4a48
>      ffffc90006fb7c70: 0000000000000000 0000000000000000
>      ffffc90006fb7c80: 0000000000000000 0000000000000000
>      ffffc90006fb7c90: 0000000000000000 0000000000000000
>      ffffc90006fb7ca0: 0000000000000000 0000000003e3e937
>      ffffc90006fb7cb0: 0000000000000000 0000000000000000
>      ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812cbd3000
> 
> About the Fixes:
> Why did it take eight years to be discovered?
> 
> The problem requires the following conditions to occur:
> 1. The device memory should be large enough.
> 2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL area.
> 3. The memory in ZONE_DMA32 needs to reach the watermark.
> 
> If the memory is not large enough, or if the usage design of ZONE_DMA32
> area memory is reasonable, this problem is difficult to detect.
> 
> notes:
> The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL,
> but other suitable scenarios may also trigger the problem.

This problem appears very similar to the one we reported sometime back at

https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/

where ~150 million folios were being skipped to isolate a few ZONE_DMA 
folios.

> 
> Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-node basis")
> Signed-off-by: liuye <liuye@kylinos.cn>
> 
> ---
> V1->V2 : Adjust code format and add scenario description, reproduction method.
> ---
> ---
>   include/linux/swap.h | 1 +
>   mm/vmscan.c          | 6 +++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ba7ea95d1c57..afb3274c90ef 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -223,6 +223,7 @@ enum {
>   };
>   
>   #define SWAP_CLUSTER_MAX 32UL
> +#define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
>   #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
>   
>   /* Bit flag in swap_map */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd489c1af228..d2e436a4f47d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1636,6 +1636,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>   	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
>   	unsigned long skipped = 0;
>   	unsigned long scan, total_scan, nr_pages;
> +	unsigned long max_nr_skipped = 0;
>   	LIST_HEAD(folios_skipped);
>   
>   	total_scan = 0;
> @@ -1650,9 +1651,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>   		nr_pages = folio_nr_pages(folio);
>   		total_scan += nr_pages;
>   
> -		if (folio_zonenum(folio) > sc->reclaim_idx) {
> +		/* Using max_nr_skipped to prevent hard LOCKUP*/
> +		if (max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED &&
> +		    (folio_zonenum(folio) > sc->reclaim_idx)) {
>   			nr_skipped[folio_zonenum(folio)] += nr_pages;
>   			move_to = &folios_skipped;
> +			max_nr_skipped++;
>   			goto move;
>   		}

I am not sure if the above would help in all scenarios as limiting the 
skipped folios list to 1 million entries couldn't fix the soft/hard 
lockup issue.

In fact what helped was the fix by Yu Zhao which released the lruvec 
lock. This was posted for consideration at

https://lore.kernel.org/lkml/ZsTOwBffg5xSCUbP@gmail.com/T/

However this posting eventually resulted in the revert of
5da226dbfce3a2. Also some concerns about hoarding large number of folios 
in skipped list and effect (on compaction) of releasing of lruvec 
spinlock without clearing LRU flag were raised by Johannes.

Regards,
Bharata.


