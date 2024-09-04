Return-Path: <linux-kernel+bounces-314952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8828296BB5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A2A1F24D29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5241D416B;
	Wed,  4 Sep 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="I1HAOolX"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA11D096C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451188; cv=fail; b=A8lr2jhNHzSHHIXZ5ioQSKxU8xefaMNL2brX3oG6c8mvUBMBe6Mx1abESI6/qHH0FWn9OxBqqS43kqCx1nJeutJb2ylD5KLUZrQRbUPwXVRbLnvICcWM7KEzkH49+e5Sq19a5u+/Bf+hc6JrIYkrP0sjldQkFUMoMUPURHkstvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451188; c=relaxed/simple;
	bh=KALWduEk++2mK+APUfNkHlZPElBLu2NwiH+u5hnfCH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iI6OsFibc1JCcDavglPdtP5zm1PVk4AT3IruT4yyMSmW0yPd5/YScmJq56jcLVvWhveikoJTnA3aID0TVfGXvWtS4WcUrnifDPBw9TmfIwlbG4uTP2pB4MXsUQ5J/m92d3C7mEw7pDogNF5DMoAUf0RtMgjOvKkX2wJVBfkiyvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=I1HAOolX; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYcOWdvCXy70xZdVbm0G30Q0jVOdSYnc0umKC7DAX5VyAqe9F3IprRBPyF+yqL5CzOJqydmDhvfyuecd3DVHD2csptmM1CfZlLQzwXWNEoB1sdGdnil/+8K+W8Lfm3kuXFUXPDa6/vMWQL22/E9YyZlxpWw0+U5ZhqETwPtysnuv4Oyc6xP3WG9cRAY6xIRgS0u32yVS9E8ht+tVjeXcHZyERJIUjjrK57hAvK7kr3zZIpvswmXuV53NLD3KodHb49/YE2/02EZqJo4j2DsND5FEoaE79hANCCnQpK/fUHM46zbf54+M9Gq2GGORD9cvnQEUkhL1G3cOdJBAozKqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KALWduEk++2mK+APUfNkHlZPElBLu2NwiH+u5hnfCH4=;
 b=dZlKOtUcoSa3PZp7fBpKwWkc383H42z6bx5pSyBNU53D2kk6Buhr0LZ6WAQ1CfCv8JmUpTHDZaiMsmFIYEeJEl8wj/p33v5WcfGxuWROsVblkyHVx4N/qoVqd5k/ltAfsuanUPsFa+yhKUDuOXehZsu6GB0QeResNx7mwLSENL+i5vaSzFx20W0Sq6iqKUNvd74hVtlcCtHAC2zl+4jcOcHkFK4t3KcpSepsnKyoppdPrloZyvvPzm5y9tPpgXJu6KZoN5HErfl4b7fMCoI8TmVbRdHiiLDnpzsm1XPv53OpzutSyyfeuiBvlwPEcNfOjsEvaEuh/nlvGSKtRpaR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KALWduEk++2mK+APUfNkHlZPElBLu2NwiH+u5hnfCH4=;
 b=I1HAOolXDFUIXsPplkDzNSMn+Ku9Hj1VNY3eJtM3ctN7uYdRqOjFAaUdaUN+o+N/ebJlj3jW1thGRrQxu4GBdY2ukZkdJWO2KAKHN6dpOiB30ZGRrQf2FrsPbLlfw+ewgx7Y2RdKEF8DEQdLnZCHNPrLKr3tjaPrbqdjhD6sPwoM/Uk+sRVgt7NQnscUGtOkugD5N/cDW1lh6NHQ7X87TaVTnRNhsaebTypVx4fg5c2d2qAsqLtLiycUn1L7gGcKo6YYuXHLX4Flh+bXgbQBKvmW2Nss14HNJ8Sf4rwAlOyyeVEoKGl4fEmYYJOZLEhSbFwoAec9TTp29ri9v6vSvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5507.apcprd06.prod.outlook.com (2603:1096:400:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 11:59:42 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:59:41 +0000
Message-ID: <d1939f2a-24a2-48a7-9c64-5acdd7c5d478@vivo.com>
Date: Wed, 4 Sep 2024 19:59:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Skip the reserved bootmem for compaction
Content-Language: en-US
To: Mel Gorman <mgorman@techsingularity.net>
Cc: vbabka@suse.cz, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Rong Qianfeng <rongqianfeng@vivo.com>
References: <20240902122445.11805-1-rongqianfeng@vivo.com>
 <5fmd2poyeas2pomho2io5zgmqd26vnxd77czmlhqn5tapy4fv4@5tdcqamzgyj5>
From: Rong Qianfeng <11065417@vivo.com>
In-Reply-To: <5fmd2poyeas2pomho2io5zgmqd26vnxd77czmlhqn5tapy4fv4@5tdcqamzgyj5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eef45ef-1a8f-402e-d001-08dcccd90f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEZscFZ0cTROeG81Vm1ZZmxENnQ2S0RmSGt6eDVjamJSbHhNNEt4enBpZTZB?=
 =?utf-8?B?WFl3SUZjbjUrbCtFM2dDcTJyU1NrUlhKRU15WHJKc1N6UVVIZE43aENMZXlV?=
 =?utf-8?B?Vk1vRlZoeGxJRDhYbjdXVTlDcS9xMXpqSE5KY0NwNVBLVXM1REtmdmFWcHFD?=
 =?utf-8?B?ZkZpT3JOeklyKzdibnM5YVo5M3AzREVuaUJHSHkzSDVRZUpjMzcwSkJ0WFBZ?=
 =?utf-8?B?U3owKy8zQ1BBZDVsZ3gyRFE1Q1VEa1dtd0swN1N4bEdjakdqWWhZTVptWHZu?=
 =?utf-8?B?dnFUQkhEYy95RXQ2QzlyV3dOWExMOTEwY0o3S3RRdERpeXYzSXZ0cTkwd1Zl?=
 =?utf-8?B?YWdBWEhHWGlKVGhHdFJPNjVPNTJlUE5GMVZ5VUlWSzdxQmVxcTVLblBKTXFV?=
 =?utf-8?B?bHVjVE9wL283YzVmdUxLd0Zocm4xY3RBcE5NUVFtQStPa1dYQlZxd1dWU1JQ?=
 =?utf-8?B?eFFKMGNLVU8rMkpWZE1xcVhNM3RBNUhxUDhvSnZtN0JlaXkzd3dpUkJyS0VF?=
 =?utf-8?B?LzFFRTlveFQvbjZvNW5VaUV5cnkwbVJUelZLNWwxazNHcGdPeU5wMWZ2MVl2?=
 =?utf-8?B?RTVTc0I0ckc0RU9pY25iaklHWHNDRHNNK003VU1FaHd0Y0hNcE1md3kramY2?=
 =?utf-8?B?MmNGUVBKWlJiVEF1WmdSN2xSTUV5UFdLckFZRGxNNm96WFY2bU1oQ2l3b0pn?=
 =?utf-8?B?Z25Ha3F2a0c3L0t5NlRlK1V0VG8vZW55N2VtcW1jaWtEMG5KMEVIZnFTZklm?=
 =?utf-8?B?d3ZSNFh1V2RyNzhvVE9hOGk2a1UwLytNbVV2ZktqUzd4czY4Mm1OdVVoWU9S?=
 =?utf-8?B?TGNnSUpTd3hoVUd4N2cveEVwYUUyY0UxeC9LTUVKeC9aYk9tSWF5eVc4SFJO?=
 =?utf-8?B?aWlWUzMrN1FCWTJ3L2I4YTJjK0drcTd6dXNWMkUyTmtHM2VVQ2dCbkpZMHVC?=
 =?utf-8?B?ajZ2bHNYQXorcWFoQkc2MUJOeENCRVpQbmkxUGxId1dGOUhBUUpRcTVwZkds?=
 =?utf-8?B?aWt6MnJCR0kvVFZrcWg2VzJyOWhzSzE3azdpRlNqNW5LWStnZEJrVjZ1aWkv?=
 =?utf-8?B?dld2d0RvVnlZQ0ZkUWpHaU5JL2ZrL1A4YmpOUUx6bGlEZ1d4dHhvSTVGaUhC?=
 =?utf-8?B?d3k3UDJXTjBEWFFRaWo3NXFzY3RteElVd3d6NHV1eU5wSjd3ZkhCNytYR1JY?=
 =?utf-8?B?WStHVnlLVGpKN3ZlRVVGNm11OHJDTkdMdkdzV1FyQnptZTB5TjVZV0NDTG0v?=
 =?utf-8?B?ank3STY4WU9URjVKRHFvalR4N0gyQy95cHc3a0lFOFdSbXlsWGJ5U3JpMGdi?=
 =?utf-8?B?TWFlQjN0R2JVUDFHVUlWRUdxMHJNMGdtSDR3VGxoL3A5bzQwbXArMmd1aEla?=
 =?utf-8?B?cmhWeWlmYm9yM1NXa2lINGttN3ZXQldvWXlPbHZhK2NpalpLQU1FUnMwbjRa?=
 =?utf-8?B?TGdjdmFYc1p6SkJEeXdsb2pEUHpjV01hdmhBa1g1dXJna2pscXVmdVpoRWI2?=
 =?utf-8?B?ampTTkZzeUFOSlZPZS9BQ3crYSt3RHpoNnZDai8vVEUycXJJRWZBRUpMWVMr?=
 =?utf-8?B?QmdhUURsdW5LM1Nab0orMTBHc1RlVU9jdHdXYk55aXNhV3NrVXZoclRuYVM0?=
 =?utf-8?B?OTQ4N1pDaXZkMk1Sb1pXSGNML0xDemszVmNHWFo3QTFmcCtPd0FaUStwR1BU?=
 =?utf-8?B?T0xNVkx5aHVlb3pTWTdmRXJxZW9XQzVxaUtBbDV1YzNBMU5PMCt4akNINUxR?=
 =?utf-8?B?cUVXeHBWK2cxZjR2amVQZjhzMnNhMnhsdXRrbWlGcXRISEs5ZUIweW96UDJ4?=
 =?utf-8?B?QXE1MXZ2Y213QmUwT2ZKQklxZS80WlEyVVZHa2lROGxDZGMzRGIxcmY5Qm9r?=
 =?utf-8?B?alBLZHAvTlhwQUZnWjE4Znl3SUJVVXdUWktYelUxSHY3N3Q1ZDQwbEYzcnpH?=
 =?utf-8?Q?f7yjrRjveFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDRqNmhrUVh4NjI3ckRHTThRR1lOb1E5SHlub045UUMrNUJUOVQ2NVVYMEhl?=
 =?utf-8?B?N1RxdStOaCtvSDZMaDB5UzFBMERSZjF4NU8zRFVmbVJxTllXcW9kV2RlSW9z?=
 =?utf-8?B?ZWl4eTRQZXpSQyt6RUhOcFZaUG5FeUhEZ1hyejdQbDhsSGFRdUJEK3pMM0dP?=
 =?utf-8?B?S2ozamVIbU9WcmtidnFUMWlxMHRmU3RKN2tFT3RoUW53M2tBWWQ2Mmd1UXVY?=
 =?utf-8?B?Sm14Z1FCV2FoWUdGaGhkd3kxeDRiZWtrSFhzUkNST2NNWEVyOGZaeERoRFcv?=
 =?utf-8?B?MFhHWGpCZDJLcEZxUlkwM2NNU21sYUFpU3pXZ2hSZFp5S1JUTktQbEtYV0Np?=
 =?utf-8?B?NVpibFJkWkVtRzFwdVhiR0FsV0ovdWpvSEdtYVEveFV5RC9SRXJsMjJON3hl?=
 =?utf-8?B?QkJlWHlRMHQxYnlhR3dveWRHb2dXNTJ3OHlBTVFFazB6bWRSNjA2aWE4L24y?=
 =?utf-8?B?alh1MzkyMGdSMEppTDUvNnZUTWcvK1pGMGpKcWFXWTNTSndRNFlweWs5SCtv?=
 =?utf-8?B?UnNrU1F6Y29KeGJCMEMyTXZZUTZQQ21Xbkk0S3NnVVRESE1XZ0dncDg5dWJC?=
 =?utf-8?B?SU1IcHFkdmpOeTRVS2pPTWQxTUZlcGdMMXpVVTVVZDBidElFZmYyY3hJVC9h?=
 =?utf-8?B?UEk0SzJtdmxGN3hHRmtyZ25YM3pDSDNrcTVwNmIyLzhVQjVEUUpOamVxdzFh?=
 =?utf-8?B?TVcvdWdQTFozRW5vNmJWL1BZZzdaYVVnRU5aVUNRU1QwT2lQdVljVWVxbXE4?=
 =?utf-8?B?Z1Y2QTJEWDBOTTRuaEhMbVltSVhDaHN6bGpIYUhaS28wd2xxSnh5SUFPZWNP?=
 =?utf-8?B?SGZhTEtiWEVidFltOGQrdHRPb0NjTFhranpZMjczNjlaZXdOOFMrRXhNVkNr?=
 =?utf-8?B?SWJSb2ZXWXJPYXptMXNGbE5kRGh5WWxlaHFlbHRGL05kMk1Fdmk2c29DWTVm?=
 =?utf-8?B?cHdCckJmb1g4WnlaTEJSUXp3T3pVRE02TnlGTGxqSVBDOGhidm8vek9XUjBO?=
 =?utf-8?B?TlViZW9sM3U4SkszdWhncjhSOHRJTmFYbmo3NjNmbS8zMDlheWtYd1Ruc1BQ?=
 =?utf-8?B?YUlLQlN6ZzZNbTN2Q3RsU3hwb0FUcTR1MGlWZ3NhVlRaLzJNRU0wNkkrNDJB?=
 =?utf-8?B?ajZ3YTdYTHpLeXNjQ0pQYkwxOWpST29rNFVud1NMeGJ5OWU2Q2xXRGNuSzRD?=
 =?utf-8?B?QWpiYnMvYTA2SjU2TnBNSTlVcTY2WXBJUks3dnNEaUJ0NTUxWnNtbTFKOTZP?=
 =?utf-8?B?N3REQVUyTUtUMVY0QXFzTXhYdnJYZnVlVFRzbXpvd1J2NGlVUVF5Q2pTSldL?=
 =?utf-8?B?VWxUSWV6b3hxU3g2WXYrdjFYbnA5KzBUVzhsVHNSNHduYTJmVVBGaklrK3JD?=
 =?utf-8?B?Ui8vbUh4a0d0Q0NJNkpGblNWdmFlTjB5d3A5NlF2NExpMHU0aldsYnRVZFFx?=
 =?utf-8?B?c1FMTVFlang2aExldG5oeGM2eUU5Sm8reWtRbUsyTlp4cVZXQ2ErdnNKRlZr?=
 =?utf-8?B?STNQMGJQeEdCSkVVWjJncnZwY0dtN29HZmlINGUrdTdXZkRsM3ZYbDZpTzJI?=
 =?utf-8?B?d2xKK1o1T3V2SlcwY3hXMDVNSkVnS1g2b09VZ2tid3RZOHdBMlJWVmhzRThT?=
 =?utf-8?B?SHF4azVTZFczWXA3UEZaejZyUGtJRmxYSDIvN3RHY1BDbFY1SGsrOU1IRUlC?=
 =?utf-8?B?OThYeUZOUThqWUpTczdONFFLWldkZ3l0VmVLcmRRUERYYkd0eVQ2UTJIYWxa?=
 =?utf-8?B?LzMrdE14akVmKzkyS3l0cXRRcVJxOHE4K1ZwcFR6aHcxem9tdUtudjMwYzdB?=
 =?utf-8?B?elpkSi9xZlEyL1k2T1ZDZWFLRXd4UnNKZ1F5czVpdFU3K0JmQ3N2R3JvQ2da?=
 =?utf-8?B?ZXRnbDVqRXdGWkJvTFIvTk5LOUlqOWxsbHd1TVZDTUppMWhVbWlYdU5veWp6?=
 =?utf-8?B?K0hNUS85R2JaMlVWT0hWOWhpQ3hJQmxyek9HSDNOWE1ZbnkyYnMwNVhOdFhB?=
 =?utf-8?B?ZkJLa2pROE05Q0hIWGo3VjIxc0NpYjZ3TFNzTkROREZFNWZzUStlUzBaRVAv?=
 =?utf-8?B?a3BOTHh2YXMzN2wwWHJzNFpWRnQyUTNmOEdRZTlEVmlYbVRWNFlkTXl5Umlh?=
 =?utf-8?Q?H3xKi7WMBkY2HYNzihY6aKy9T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef45ef-1a8f-402e-d001-08dcccd90f2a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:59:41.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxsbOKAqddHQTbSrOC3M08kY3OCjmO55mmiDgafYskoyyq+o4+R6WcuxZjAx9URUCay6pW4RCwWtbPA6hARyUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5507

Hi Mel,

在 2024/9/4 19:13, Mel Gorman 写道:
> On Mon, Sep 02, 2024 at 08:24:43PM +0800, Rong Qianfeng wrote:
>> Reserved pages are basically non-lru pages. This kind of memory can't be
>> used as migration sources and targets, skip it can bring some performance
>> benefits.
>>
>> Because some drivers may also use PG_reserved, we just set PB_migrate_skip
>> for those clustered reserved bootmem during memory initialization.
>>
>> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> I'm not convinced the savings due to skipping a few pages during the scan
> would justify the additional code. There would have to be a large number
> of reserved pages scattered throughout the zone to make a difference and
> even that situation would be a big surprise. I'm not even sure this can be
> explicitly tested unless you artifically create reserved pages throughout the
> zone, which would not be convincing, or know if a driver that exhibits such
> behaviour in which case my first question is -- what is that driver doing?!?

Thanks for taking the time to reply.

At first I thought that there was not much PageReserved pages, but when I
looked at the memory initialization code, I found that no-map pages were
also marked as PageReserved.  On mobile platforms, there is a lot of no-map
pages (for example, ARM64 MT6991 no-map pages has 1065MB).  These
pages are usually used by various hardware subsystems such as modem.  So
I think it makes sense to skip these pages.


//no-map and  reserved memory marked as PageReserved
static void __init memmap_init_reserved_pages(void)
{
...
     for_each_mem_region(region) {
...
         if (memblock_is_nomap(region))
             reserve_bootmem_region(start, end, nid);  //for no-map memory

         memblock_set_node(start, end, &memblock.reserved, nid);
     }

     for_each_reserved_mem_region(region) {
         if (!memblock_is_reserved_noinit(region)) {
...
             reserve_bootmem_region(start, end, nid); //for reserved memory
         }
     }

}

Best Regards,
Qianfeng

