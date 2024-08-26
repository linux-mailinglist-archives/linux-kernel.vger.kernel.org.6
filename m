Return-Path: <linux-kernel+bounces-302254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43F95FBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BEF1F22A04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7B19A288;
	Mon, 26 Aug 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sBlyr1XM"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020134.outbound.protection.outlook.com [52.101.61.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCE13DDCC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708040; cv=fail; b=ViaCPHi/7V+32Uwl6JeLKo6UAt2lRSoMEmkT5GspLV2RUN2Ls1KxFzfyax45SMCyaibfUvxriY8Qjk3NSSqaEgPuGeSz1YF77KaDGVuTO+nLOdSQiiCcc8NXBYfdd9+vEy131knAILcI64qvGG7cmnE7v3mFkk1Z4brvMHczpaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708040; c=relaxed/simple;
	bh=s2ZG+IuHAXtTHf5a5RA2LGUQhmf9TxYYovRHR9zcTrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l8F2Y2iDmeIon1b4a2KvkZOn42xYLCRDWAKDeNfxw2zbhBqQPOHR0IVzvSM/4HtpOaKyOOfMEX86VfZafGRLukddM8fRJhqeFIMlOsvCA35K1MrEslTv4C91IBGN1eNDGzICKiZ8NU47sgdFsX4oq2NfFDzoEi6BsiLkYPehxzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sBlyr1XM; arc=fail smtp.client-ip=52.101.61.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2zVwA+CweSDQ8W1jfvjDAO2rbKC29haLCj6ZQzCKmEjX9GHqKcI2minKISs+tMC+owXCF46a5ZWB6icepZ7RDNfT3oBmf4iVY7exLWm94CiZ0dwyn+yxM1DEjxMiajng1is+mSmmFJVx4mHtaYbZ2cdNaZSg2dxd79JP83W0VeypLJeS5WTGxpcAs7pOgAJoxmUq+o7cGm/qVdBzA/vOFlDjROENyif/QrNkYyUuAEMfn0OFEFNDTsMbEOdJ09z96lTm2f5nP1D4kk3dDmGmJf64UcrmYZQ1AP2qdQe/qmsrcXUK6cPN+w+LD5Gr1fn8lzVG91YP15XHxQp0q4naA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CXMuTOUVxKtqEO6kjGwUXaww/Ll5KRgIwOD12sQcX0=;
 b=AdWBVb9/VjTORFEYCQ+SUc46AQ8g1/X2PriCItgYiegFqCNxK3tfwsK8KPTT3wHRP5yGXBsK1R7C6pg4HGogMadvHvFkjH1AiH60fyhi/GrmUOE2GzioKiylnJvSPBkfljOqekv0N6AEGZOn5vmLeIBpoB9F25zH1yIfryNo/kUq4TeXjB9QPsGuOT5TcVYzDWyms88fXqYBsmfgqNn09gdPwVo9HygGwx4r9c33c8IJjdtlsQ+dkn1r5yp9vXVoGMSCMGWkhFp4t8es5O49UrC3A9IBPPnJmJQL/LfQF8CdhQ83+VKx8kmJPf8ljfOG1fz9zfEupxbc4cXhO+7LaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CXMuTOUVxKtqEO6kjGwUXaww/Ll5KRgIwOD12sQcX0=;
 b=sBlyr1XMVPy7mc44xyNWEheEULuGfdkT/z85steKXoYIAgOr2TmvZIJcOJI2f8t56OKz7dNeCfD+E6HL8vkcnE+6yzlYMuhZuwI86OwsZjloCLH7qNV3RyGy7nCaEb36DEtXv7pIUnWwQih1ac3jp+7czYq/ar9fU8Bg8KHBVxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 SA6PR01MB8927.prod.exchangelabs.com (2603:10b6:806:42c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 21:33:56 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:33:56 +0000
Message-ID: <ed1c5933-0d7c-4b61-a779-758e6752cac6@os.amperecomputing.com>
Date: Mon, 26 Aug 2024 14:33:52 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH 1/5] Add dso__is_pie call to identify ELF PIE
To: Leo Yan <leo.yan@linux.dev>
Cc: james.clark@linaro.org, mike.leach@linaro.org, suzuki.poulose@arm.com,
 leo.yan@arm.com, ilkka@os.ampercomputing.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
 <323e931fe9f8f080eb0dfc2e29d112dd7edf1fb2.1724104248.git.scclevenger@os.amperecomputing.com>
 <20240826131341.GA4167@debian-dev>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <20240826131341.GA4167@debian-dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:a03:54::47) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|SA6PR01MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a391f1-098b-4cbe-cd6d-08dcc616ca00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1lld1ZxMG5kd1NBanVyNG5nZHo5UUkvV1F4Z09uTEhjZXZqR0p5TzZPNXdI?=
 =?utf-8?B?U2NJcXlNZDBpb0VWUU1zcnRFdTl1dFI1Mm5jU2MyQldjT0k1cHpyNW4xTW9l?=
 =?utf-8?B?cDZaVmN3ZjRGTkRxWm9BUW1PaDhJVEtsRUtzQm5VQ1h4OWpLQ1IzRjRLMXYw?=
 =?utf-8?B?OVlrWnpSTUdxdmVSZE5UVDFDNm1LTm5odWxsV2F0UnoxdENaZ095UTZ2V1dB?=
 =?utf-8?B?ZitFYTBlYkJLR2tNM3dKaU9XMTVSY2VZT080SUxSK3l1dW9YcnJ2eWZ3YUNQ?=
 =?utf-8?B?aitQU2hGMk8zdTVadGRvbFdKTWwydmlTRFBKekJMbnNhTU9Sc3VGc2YrVTR6?=
 =?utf-8?B?NkpPZHpNb2tMSzRvUm1tRXNqUjNJRXhKOTVuc1h6TjhCaVdCMGNDQW9lVjAr?=
 =?utf-8?B?a2VlVnNmZjRaVXRmTGtmUTRoOTlkSFF0MUNpVkwxZzQyUW9XbGRpZmNXUUUx?=
 =?utf-8?B?NDlTbTZKQXp4QUxrcS9SY0ZacWtWcHpWYVRpdHJ1c3hoQ3F2bHdscUdDcGRZ?=
 =?utf-8?B?NEllL2xmUGFQVXN2djMwMG9JdTlIcEpkdC9PZFd4K1RhbjhTaUJ0cDV2STl2?=
 =?utf-8?B?R0NpV0Y3b0EvOWtuT2lEQWdtLytPQVR0cld3MmZrZldnUGFIb1VVcGNCRlZv?=
 =?utf-8?B?L05uOEVuZVRJUzRtOXZTT1BzdDU3UUtFaGVHQlRycVBlR1haZ1BxYlY3Mkdi?=
 =?utf-8?B?b1M1QzEyN1lySHlET0V2Q2VnaXBzVXZsZklncitJVG1JQjhXK1lRNGpuWGU2?=
 =?utf-8?B?ekF1SW5URFh6UEtoanNQQ3hVSVpVbWJjenQ1UjF0YVVNbVpuTWxWM2g5MDVG?=
 =?utf-8?B?aDFYQ1dVN2dwQUxNRU5QaC93YTU2T3hndVg0dTdKZk1EalY5U1J5djhJaFNz?=
 =?utf-8?B?TVg0MFJMbStnM3Q0Yi9EVThGK0wrQVdENVhGZGpwVGloSzQ1OHNyZFE4S2dr?=
 =?utf-8?B?VFg4ejBRQkg1RUVsL0dEendoWlgvL2FLeUlVTWlZWGQvKytLeVhRK2E5S0V5?=
 =?utf-8?B?cytibG1HbDRXa0QxTHJZNER5ZzhLMmhGQ0JYZzk0NktzRk9aRk43dUJsZ2R5?=
 =?utf-8?B?TmJPNWh4MXlkdDI5VnUvN1Fnb1VqMmMycmxTUE5yTEUvOWNUanZsRnMyZmxK?=
 =?utf-8?B?ZmxsdTByVkJIWkQzVm00cWlOTGRQRzYyWmw1UFJwTkRkZlBGTk9peGVSTUpO?=
 =?utf-8?B?QmlWTFZqa1A1dVZpcXdYOHQwcTFrSTNJOTdTdVhESElkQ2ZpaktNZENLd0Q3?=
 =?utf-8?B?bE00SWZmVUtHeWJWYkZkRWQ5NVJzMGlzNGlReTJwVHhlZ0gzZyt3TGVRWGkw?=
 =?utf-8?B?NzRJR1l0S0tyN0pOaHdQR0NEWEtYM3RMS1VBY0FiaUhFakp3MXN1K0NTVm8x?=
 =?utf-8?B?ZnYrcHBYNFNlWVFTVDBTbk5TNzNtSThvRGwzNk9VY05qdmV0eWcxa2JUTG5V?=
 =?utf-8?B?ZUFlVmFZNDk1K09taEVQUW54dkVnK1Zydm9COURkQ1NJWFlkWjhiNjNWTU8z?=
 =?utf-8?B?K1QxWkJZdzU5L3BLbDhrdEQ2cmx5M3ZqSWFSV0dvaXBhd2pvc1NtditwWGFH?=
 =?utf-8?B?bVBnUDVsM015cXlEZmtoaUxlb01FNE9ScndlQXErWStJbkEwc3JjQW43K2Fl?=
 =?utf-8?B?R0RwSmlhV2NkNnhrYllRZExTaXRQMTRFSVNuWGFkZWc0WUllNkNqRTQ2V1B1?=
 =?utf-8?B?ZkNZVjN6MW1zbXJjaERZek92LysrOERXa0NBb2pGa3owRnJrMS8ydlJqVEFt?=
 =?utf-8?B?V3Q3RkJhNFdYSEUzZXl2V2VoYlM4S3owbE1KSEh3cGQxRE1LTVl2S1Nud1Fw?=
 =?utf-8?B?SXYvN3hPSUZTaXRIYUw0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmFiOXB6OWVIVDI5ZW5HNVBkNXMrbU5WaWxTWFRPWVVWbXRWVHFNdzkwenVW?=
 =?utf-8?B?eFVHakVBSVV2V2dEZWRhZW1NKzNxZUVacUVyU09FaU03UzdOT0dyMkl5ZUI1?=
 =?utf-8?B?MURjWkhyNnR5VjMzc2FSNDd0cUdvdnMyNEZrMHZuc0IweXFudGUycEpSRkNw?=
 =?utf-8?B?VnlxZXFEWnVkRUp5cW0rYU5TbE9QSjN6K3NlTXNleHJPSVFpek5WNE9pTUtw?=
 =?utf-8?B?RnV4WFducUhheDlORmZWajZPL0lQYjBBTTduMXZOVTRVUW80dndldmZhRzVs?=
 =?utf-8?B?dWlseXF5YzZBdTZSSk1yaUpWQW1zd29ocVBzL2t4Z0ZGRzd2blZ3Nk5TcFRU?=
 =?utf-8?B?WDM2TFdTNGROUkFLUkRNbjRxWGxjZVcrZ1hsZjQwaVd1M1Ztay9BS0l4akY5?=
 =?utf-8?B?K2hvN3NxZ045clFGTUhIL29iZklzajJTQXN5aXRxaVVRRXZKR1ppUmcxbCtC?=
 =?utf-8?B?SVlhQUpCS2JSVG5kTzN2YWkwZzNGaXAySkh1TkV4bi9odVBEYjBxZDlTa3li?=
 =?utf-8?B?bC91ckpUNk5COTdFNVc1a2FIMnRZL1BycmswY2dyWWZISWtlU01MK1JNZU9N?=
 =?utf-8?B?NTFjUDFKTmZOMUV4TDZHdEtvS0VxRDRtczdzQ1ZiaXhQMnpjS2xBZnJ0VmxO?=
 =?utf-8?B?T0YzWEtZTmJiS3pFVXhKcG9hU3R3ZGtPSjZ1YXRXR1EyKzg3RHVvN013UjdU?=
 =?utf-8?B?M21Sdk5SSVF3ZmVWUTBXdnVCRFRKK002ZlFoNnVwdDNXWWF5MGczRFFjS0JT?=
 =?utf-8?B?TWxQaUpvOHRQR1NBUHdnTzF6bjFFL0U1ZDdHTUNPRUY0M0U0aEw2N2pyM0Vj?=
 =?utf-8?B?SVBDR1BEM0FqRm1jVkpIWExKamdMTGtEYzhmN0dGTjJ5TXgyK3BONVpzNVYv?=
 =?utf-8?B?YW9DbG5TSTBVN1dHRlRYYzZpTjluSnhMYXVHYzNxVjlwUDFLaDFLRXVNRGly?=
 =?utf-8?B?Wm8xcXZVeUUvZkpXUGRWcEFMQitOU281UDRUcEJHd1dpNUx5ZUNYcm1tRWo2?=
 =?utf-8?B?NnN6L0NXTkFLVTYrcFNEZ09LY1ltWGc0LzdidWJ0bnpxRlVjdVdreFlmbzFh?=
 =?utf-8?B?UW1qbXBOUDRFWENja3lIWFdhUlRpV0xIRlIrWkM4STRnLytHVEVPVktQa1Aw?=
 =?utf-8?B?enVxd0FROU1NSWt3dXJZckx5VXNwWmpPRXQ1OUh4U2hOam42RThRNm5mV09m?=
 =?utf-8?B?ZllMM3labGw4Rnd0WlhoeEZycllwUkRidjJDQXVLKzZGTzFVbkJEbUVsNEI1?=
 =?utf-8?B?bEh4VXRBV29McDNYeDFqV282ajVRWlhBQzhwbXBxc01XbEh6TkJNcUpSbWR5?=
 =?utf-8?B?YWV0bndjTnRBeUYrdCtRbzJoYlFUYUxJajVMMjhaRCtWbUJkTTJOT0hEdUQr?=
 =?utf-8?B?OENZanVsYnlRZ0JhVzBtbDNOMXFMcHo2NitzQkxXOEhNTUtLUE5kRkhnZ1pF?=
 =?utf-8?B?OFVFUXplQUdXMFdBS0VDREVOeXJrK2ZEK1orQkE0Z3BEUHVOcGFEZUZzOGww?=
 =?utf-8?B?V0t1cXJybnBXMFFRd1hJeFNJMmthQ2lVOXJ3S3Q1NWdHUmowMHB3eDZQMXVO?=
 =?utf-8?B?ZmhhdmRjSlB6alRYekRXZWd2Mjc0Rmg5Y2o0dHR2VG16bzB5dTk0RkVsVEEw?=
 =?utf-8?B?bmI4ZzR6WW9FeS90Mis3ZFhrODZqUjNxNmxEKzNGSm9OR3hMQmJPamNUQWRE?=
 =?utf-8?B?SUNaVGRrUE1GWEdBV0JkNkIxSWJ1ckkxT3RMNkhuZWllaEpraVUyNUxRWHVI?=
 =?utf-8?B?RTgwNjh5NWM0L0ROVXRpUW1tUUQwcVQvUkZJL2YrK29RdTBOWUlKdmVzSW1W?=
 =?utf-8?B?aFVoUlVJOFRBTUpJbkh6MktJWVY4SmFUY3dOM1ZWSmJaTTBJMzdTMjNxakhN?=
 =?utf-8?B?b3pIVDE2aFFVYUI0L241dFpsc3VCZFpYWEljOWhQMjdTNm80UmFVdkRXQ2FW?=
 =?utf-8?B?OWdoNXQxenloK2xVZVZuNE91c2VOMVVnRnJTNWgzZnZiblhZTjl0d0JkNE5U?=
 =?utf-8?B?MDUwREE3NWZsbjJQSUEzeHNtSVNKeWZyRHVVMEFOMUNUZ3RpSHc0c09jZkVP?=
 =?utf-8?B?Z3NvMERmTExVdXZ4cmdoT2ZNeHFSZytaN093SU9GbE1Na2VGbEV1UXhWQXV1?=
 =?utf-8?B?dmRHK3lSbXdDMTJhVzQ1T1Jjd20yVWFHVm0wRlpEMVlxSUNiMzlteXpjWUVJ?=
 =?utf-8?Q?5YnftOSJtd92TZpQiv9uEXLwQvxjcVxOH6QVLPb76Ygh?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a391f1-098b-4cbe-cd6d-08dcc616ca00
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:33:56.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzVKYafSMbTA1FUUPfLRDz+i0rMktGsBMNYpv+XN6hDBb5UN7qI1PVc83NF19h8vUScDoVrO3GKOlpthyhMJ++uM3sYxh3/JVdqGJkrbKkLuHZb8+7Gi3k+XP0rpXiL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8927



On 8/26/2024 6:13 AM, Leo Yan wrote:
> Hi Steve,
> 
> On Tue, Aug 20, 2024 at 04:11:35PM -0600, Steve Clevenger wrote:
>> From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>
>>
>> Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
>> the DF_1_PIE flag. This identifies position executable code.
>>  
>> Signed-off-by: steve.c.clevenger.ampere <scclevenger@os.amperecomputing.com>
>> ---
>>  tools/perf/util/symbol-elf.c | 55 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index e398abfd13a0..1d4bd222b314 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -662,6 +662,61 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>>  	return err;
>>  }
>>  
>> +/*
>> + * Check dynamic section DT_FLAGS_1 for a Position Independent
>> + * Executable (PIE).
>> + */
>> +bool dso__is_pie(struct dso *dso)
>> +{
>> +	Elf *elf = NULL;
>> +	Elf_Scn *scn = NULL;
>> +	GElf_Ehdr ehdr;
>> +	GElf_Shdr shdr;
>> +	bool is_pie = false;
>> +	char dso_path[PATH_MAX];
>> +	int fd = -1;
>> +
>> +	if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
>> +		return is_pie;	// false
>> +
>> +	dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
>> +
>> +	fd = open(dso_path, O_RDONLY);
>> +
>> +	if (fd < 0) {
>> +		pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
>> +		return is_pie;	// false
>> +	}
>> +
>> +	elf = elf_begin(fd, ELF_C_READ, NULL);
>> +	gelf_getehdr(elf, &ehdr);
>> +
>> +	if (ehdr.e_type == ET_DYN) {
> 
> The code looks good to me, just several nitpicks.
> 
> To avoid indentation, we can firstly check the failure case and directly
> exit for it.
> 
>         if (ehdr.e_type != ET_DYN)
>                 goto exit_elf_end;
> 
>> +		scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
> 
> Ditto.
> 
>         if (!scn)
>                 goto exit_elf_end;
> 
>> +		if (scn) {	// check DT_FLAGS_1
>> +			Elf_Data *data;
>> +			GElf_Dyn *entry;
>> +			int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
>> +
>> +			data = (Elf_Data *) elf_getdata(scn, NULL);
> 
> For a safe code, it is good to check if pointers (data and
> data->d_buf) are valid before dereference them.
> 
>        if (!data || !data->d_buf)
>                goto exit_elf_end;
> 
> With above changes:

Thanks Leo. I understand your comment about excess indentation, but I
don't believe there's an excess here. Valid points about NULL pointer
checks. I've made changes based on your review. Please look for V2 of
this patch series. Besides addressing your comments, V2 is mostly to
update the mailing lists.

Steve C.

> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
>> +			for (int i = 0; i < n_entries; i++) {
>> +				entry = ((GElf_Dyn *) data->d_buf) + i;
>> +				if (entry->d_tag == DT_FLAGS_1) {
>> +					if ((entry->d_un.d_val & DF_1_PIE) != 0) {
>> +						is_pie = true;
>> +						break;
>> +					}
>> +				}
>> +			} // end for
>> +		}
>> +	}
>> +
>> +	elf_end(elf);
>> +	close(fd);
>> +
>> +	return is_pie;
>> +}
>> +
>>  /*
>>   * We need to check if we have a .dynsym, so that we can handle the
>>   * .plt, synthesizing its symbols, that aren't on the symtabs (be it
>> -- 
>> 2.25.1
>>
>>


