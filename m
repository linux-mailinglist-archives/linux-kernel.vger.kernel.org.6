Return-Path: <linux-kernel+bounces-300264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C647795E1AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEE52863D2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23376405C9;
	Sun, 25 Aug 2024 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Cw/ED7Ri"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655D15E88
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724559494; cv=fail; b=oPxdldLGBBt0BuqoC2yO2YO3gmzPTd7MRFiytSBSB2URNCTM+DQHAx8fbcbVwgwBfw94whCWflJ5a47z5zarzXYH6tBdQ1V2ZpJ/xbHPuoOEM4+QVIFwfKMYG9hl7YDdVAIU5nLPb2gcePqrKA8H9jYQekKA7/KYq/Bk/bAMCsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724559494; c=relaxed/simple;
	bh=qvx/auCBRud5c5HHpGBWxjGUfIIOFisH20oBEs4PwjY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzYwslTRlSwECRJDK9InYfo1ECjceqpvX9B5r0BbXIhBxcVZXJkeqNcD+vbnj2VR3Jpk2+Xf1TE7QmV/6f4sIbrrDEh99TSKJDs1ejtQxsEI4L/wTLjsJa/zfSuQr3P0bal0D9jL6o1UX0EO9GEXQlJAETJz54WasxkeVfxoEBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Cw/ED7Ri; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjUxGj1ghkTwiwJyASH+kX027xmZpIVsDjd2k4sdmTo7qr0uLcEw7AbaVpWff7KO6WTvrohb7xd6XmPLRLbigJGRgJWeVGZlNo9mo9xXxuDqDPNqFOLW/JMc8drQNBNELG0wHSNL5/frfAnJ4jd2ZfEqAq1JqVgdLzheMKcoDW1uz9dpMO4iQKRXZBMqhw2mMZz3eiiojUoW3q6ukVmimCx92W1DDvNl1S8TnEE6QcnvEYwcHKFJrRewS6WSQnKGGh1g9trsmnu3rKnJTAoj2Bnk8nd+bx5mUQg1hniFrxmnn1WBHExSfG5X7XuEn7O6QlLmYTZGKzFHTYKaLpf84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDQL+B2r3sR7TmTNF9Q+TxkuTDgJMt3mT91RbJ+pruY=;
 b=U2yX10dwNbpwrudH8qdwAcHpEqCqurQAb4A7Z2WJijlBu90i/6lOox0SVkHwPCCyG3zxEBYdfBRtXEFmdDYCT62a0KEZfcd95pPGJ84KOxU8P9DpsrWbFPT/GNnzcerUFlMD7+abbuAVzAQ+MsmFnNvRPKAxHn5heICZl72/7ly9M1mlNPAgv1YK2OLfU8Zxe43KSKfB3xh1+raotYjInklok7HKuaS54nJVct/9jKjUtvdUiIechtdka9wOqCES0UFNU8v2MjGj2uh7zfN2tkRNfAgPF04kFLKsOmUkRLXk46pGiw+VnbYAk22jImbp8w4WtcUNqW4j2KjPgg3XZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDQL+B2r3sR7TmTNF9Q+TxkuTDgJMt3mT91RbJ+pruY=;
 b=Cw/ED7RiHYy/zzfxyAkUiwfE6Dy+IgYJ3GOXX+1SuqHKFci4J7+PsNKoq8YR6byqit/AhnQDiLzOQIFX3pUr07K/Z5KVFZuT18Cu9UbR4oB8HZr8gaHQ/J8IS/otIr4th9/tYrrqKHo7N+86WvIlA/yX1nFBxwNwWFHL8aNp5b0s0i7Y4qxy/e10aA+eBAuYIX5IBlvtA9g7tvV2/iExTwF5pxrKt+fArabQIytr/TTbmYtwCGmvJiCdZKChAkCLPFupMHiV0R5mjp2LTP/xQQZqvF5vra+nkymEVZ23KgddU/xfJUExRblC/sE0IXOotvSzGBNvIHPOkptFfyVb5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sun, 25 Aug
 2024 04:18:00 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Sun, 25 Aug 2024
 04:18:00 +0000
Message-ID: <2693eb70-ea92-4da4-b1d3-05c4297d2a2f@vivo.com>
Date: Sun, 25 Aug 2024 12:17:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
From: zhiguojiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev,
 lkp@intel.com, opensource.kernel@vivo.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20240823150206.565-1-justinjiang@vivo.com>
 <20240823223559.942b53cea16d5cfc6b70bf2d@linux-foundation.org>
 <4ebdd333-50b0-4066-808f-6ff829d989f5@vivo.com>
In-Reply-To: <4ebdd333-50b0-4066-808f-6ff829d989f5@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 474c8bc3-a92a-4e05-8f28-08dcc4bce7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFNMdHNjLzY2SnNreFVmTGVvSlBZdXdhZlRpcEk5YVBseHV3NGN6UHhuUUpG?=
 =?utf-8?B?WitadDFhVU0vWlFEWUlibGhJZ053TFY3eU8zazRCa2MvZzNmRVpKaGxDTHRt?=
 =?utf-8?B?aUJIL2xDV0VhWG5NeTg3djh2OHBNY2MybDNheS9mOWZOQXpGcjk3aXFlYkVx?=
 =?utf-8?B?NDVtZkxlbHc1akxocW5BNENHYk9SWU5yalZUQW1SckJYdEdlMlZYUXRMUUQx?=
 =?utf-8?B?TlZ3dkdwZGg2S09hYjlPVXJMbDd4QW1NUlU5dHhydzBGUXE2UWc5S3dtM055?=
 =?utf-8?B?a1phejJvTzFwL3hYQW81em0yQUxWcVEvNldyM2FJZzFjY0pxN0l1dnBlNGVn?=
 =?utf-8?B?c0JyQTdaVmgyRjNlREhpS1hIVnIvZnVoaDU3cGNLZG8zL2Y0SW1BQ3dwcmEw?=
 =?utf-8?B?NnZib1orelp4Rzc1M3REb2VwNENrandiQ1dmUXhwZkR0VUxYYTlidHJ0VFRI?=
 =?utf-8?B?bWNRaDZuTHI2eDBFNFF6NFI5UW1MbmpPU0lCVnpqcXdGZ0FmNjhGdzV6elRh?=
 =?utf-8?B?dm8rcjBPV3RqeXo4dGRTaCt2b2YvTFNiOS9Kd25tQ3ZSR2tGWFRYeEhaRDVU?=
 =?utf-8?B?SGVvMHRtOGpFUnNvZ2I2T3BGUDRyNU1BNTVLWG9maVFHeUlqRWVNZ0ZGRWdk?=
 =?utf-8?B?WE16Y3BBVlZkeVZaK1N5RUg2c0Q2alBmTkNwdXdKeHZMejdPUXlaVkMwK2RD?=
 =?utf-8?B?alh2am9Rdk91elJJRGkzZURkcmNZZGc0ODJwNG5BNFlleDVSRmQzWHk3SWho?=
 =?utf-8?B?a0FXeE5MaHVxSnA1VDRhTUpRUjZ1MkthTndsZ2x0UWllYTVMbVJTN2pMc3FC?=
 =?utf-8?B?VHJnU3JtbnVLOGRkNElHTW5aYU1IRlAvR1VSWCtiNVZMVmJZOEVhNWoyK01V?=
 =?utf-8?B?S1R1V2orYlo5a2VmSWowajJYeUNYcXJzS1pyQWJIRVBkeTZnS0x3Q2JydmUr?=
 =?utf-8?B?a1N6UE8yOG5BOEFDSktUTGlwenZyS1I4YXJMSTYyT1pwYThPdzV0bnJ4OHJ4?=
 =?utf-8?B?a0pyOTJDejZEWkFuRXdCbk9NVHN2VysxcnZrOUtEUmROWXpyZ0xFSE9ZbFFB?=
 =?utf-8?B?dUY2YktaWmxFOVRJOHNYTy90elBVZGpFSkdjcVNSWEVacmJFbWhqbkh3SFNk?=
 =?utf-8?B?dXZQd2RjSDJYMnAwalFlVnUwRGtreGJpa1Q3aldLQjIvVHN2eVd3RVM5MUtY?=
 =?utf-8?B?LytyRExZQXgySER6NFRodUs2U0dwcDc2R0JuOWdROXhTRU1MYVZhUllNc3hs?=
 =?utf-8?B?blZiVzdHMUJLYXA4aUViQTZqcmFqZUxCcGxwcEdDOGYxcG9wTG1LUURueURo?=
 =?utf-8?B?TWRqb05IcG4yQTgvQTVFUjVBWE1JNVBORk9ESXRROHE2QjVkaC9ZNWh0MG13?=
 =?utf-8?B?emVLY1AwTytEU1VxVG4xcWVWalBoWjVDOWFCUlA1MjJac1VVeFpzUDkwb0Nw?=
 =?utf-8?B?S1oxRGdydy8yWHJEOG02SzJxbVVIb0VCZ0dhZmlTTDlHRzFwcHRxVDVkRnpV?=
 =?utf-8?B?SmYvVGRqSGlabFJSOFdjWDFHanhmVjQ3Z3ZoZTJvQ2ZWK3Y5TjZGNlhtOFlz?=
 =?utf-8?B?eE1ndXFjUmViKzhwc2xvQ3FtTHdLUEZQajA1WGo0d2pJTVBFMERNOThyajRB?=
 =?utf-8?B?Q05PUjNXL21RdG5iYk1yZ3VidjBQeG9BTGQyOCtxQU14K3IzS2k1Sm51YjJ4?=
 =?utf-8?B?VHJSUDdhK3FRS0pZNzZKSThCdlV5ekwwdnR3ME02OVBoYkZZRWZWTC9LaEkz?=
 =?utf-8?B?ZmV4OEN1RVpkUlRNaGx5elFCMXV3S2d4TTZQeEpxbHRHWGpsaEZaTCtFSkgz?=
 =?utf-8?B?N0YrbEczQ2FIdUxyeTVQdFR5U0tYRmNFR3ZjenZtMEVkek1qOEQvb05Rc3ZV?=
 =?utf-8?B?YVpKRjNNVXJ3UW1VTm8zNWRmOFYwYmtKVGEvNjA3NFZHSUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzZsdUxUaHNwUnBBU0dML2kwOTlOVW15MkFmTWJLRFhHdTYvSm44QU5LNWcz?=
 =?utf-8?B?bFJENTJWSWkrUk9tZVpuTWcxOEttMlF4K2FOWnExcVBxWEZ2bXpsL0EvV0Iw?=
 =?utf-8?B?cjNnR1d2K3NkUjc4ZzYyWktvL3dJem9rT3V0V1JTdEtLWk5pU3AzaWI4UE45?=
 =?utf-8?B?Unp2bHZ2cHl0SldBRjBBQ2pmckFMeWNLQ2Rla1RmOXRGOUhjOW8xang0ZkFs?=
 =?utf-8?B?ZEJ2bDFUQkhPTkxxU0F3eitaR2d5Qjc0Y0c2TldsT2xNbUpUQ2xmaGlHTXpl?=
 =?utf-8?B?emordmhxNFIvaEdYSGtRUVVoeC9NM0V6RnBuRFltMGZKRzN5K3JBcHZncHBK?=
 =?utf-8?B?UGQvZzdTZ2EzcytSVVVOR3BCUk1OVTJtTklLZHZFZTRuc0pRNUlCVG94akV5?=
 =?utf-8?B?NThTTE5WSTRWakM0NlladFp4T3pJRVRmdFppM1NxdTdlbExEVnNOTnBsRHRp?=
 =?utf-8?B?Mi9YU2J5Q21OMkdPc3JUY0JXQ00yZlNvZTAxbXF1MDJYQ0E1VGFPdEpBOUR0?=
 =?utf-8?B?RzIvTVlyenlUZ0hKZXJBVTdGQ2NpZVpibm1rMHd1OGc0ZTluY0luaDBOU0Ft?=
 =?utf-8?B?MWc5WWpzTnZIblpHbXBSeXllZG80TE93Q0NZVzM3M1hJQ2ZZbGtGcitUckc5?=
 =?utf-8?B?QzF5YldLUHNyRTV2eDNocDBIOUEra1lKNTFQa3RQTXJGV2ZQZ0JsdFRrbWt0?=
 =?utf-8?B?bE8yTWJNdzB0OHhUK2grWVpDN2ozSlVpWFo0U2l2YVRwVDFpYXhLazk4NXY3?=
 =?utf-8?B?c2JGdGtXcDNDWHZqRU4yL3k2akFWVjdyVFIzcTJQaHhNdkQ4SW5nNFdWdXp4?=
 =?utf-8?B?c09MSTRxWFJJbTZPQ0JQQlZDMHkyK2lzZVBkRlg1b0RMNUdnZDZBSDV0aUE1?=
 =?utf-8?B?UkxwanR2Z2RNQldIRS9XTXR1SnRPTlN3NDJ4M25HOGZCaW44MHNCWDRyOW9Y?=
 =?utf-8?B?Y1ZFU3pEenNNdyt6UUZuUXUzTmtPd09xM1JXR3hjWUgybzBlSjZMRjJvUElv?=
 =?utf-8?B?SUZldmV3Smk0TzdhUllVbGk3eXVveFFsRHJYdUxKK2pLSjBlcXlLR3NaV2x6?=
 =?utf-8?B?azhEZ1pGZXlUOUNpSnRqNzZZeTk5eGpkOEc0YmhJZUYzZXNpSjB3d29MZ2Zz?=
 =?utf-8?B?TjJmTkJ1aHVVVk0zNzBQdlFtU21DVmoxbTd5NzN1K2RpS2NSSm5ydjZKNVJM?=
 =?utf-8?B?bk9qdEU0cXZnME1UMVlySnV5SGY1RDZibHVFRVc4TFhDRWQrTCtpQkZLZnVk?=
 =?utf-8?B?Zk9vdjVFYkt3blZLREtZMUdvanFzRGlOYnd2bGNmNlIvbmZubkFGbHp4Zjg4?=
 =?utf-8?B?TWxjOFBPM3c3OHdWM0dGL2g4WTZmTWl4M3A4RlBMOURiS1pwS0lMMmVQUlhZ?=
 =?utf-8?B?SXFWNDZkcGZ4eVNHcWQ2cC94MDN5VXg2MEJiS1ozWTRJQXFNZ0ZyQUdpbVJa?=
 =?utf-8?B?ekgrYXpNV1F1U2swZTRZZktmVlY5M1Z6WldaUEw1RlViOHJOSHAzYkpoZ1RB?=
 =?utf-8?B?M016MHN4VUJDRWdjYVB5MU9pWGl0UHczYXpXOVFGTlRGWEFBZ2NBUEVOZ09L?=
 =?utf-8?B?M1hTYWhLU3hXNC9GZzZ1UHRwdXNma1VrY3pSejd5bUJxRDhBNis5THhVRGRN?=
 =?utf-8?B?S1RXNXR0QVNZaHp0SnZ2RmJBZU5mTUlpam1IUFQyUk5DQmczbzV3S3l6SWxK?=
 =?utf-8?B?MW5NOE9iSS94VWtVOUZ3WmFKYm04Y0g4NjBOcWR2WFh3cjMzemgvVXVYV1N6?=
 =?utf-8?B?WFVVWTl5ZExhTUNCSXZISDBabHF4blVYYkgwdXNJMkR0M0M1bVlDWFVKN3R5?=
 =?utf-8?B?ZVVIeVYwS3ZVa3Q4THRtd2YwMUYyVHZxZGFaUk1CVUFtUk1meDBwMjVqWkZJ?=
 =?utf-8?B?a1JrRXppeVBOWVFOVHNqVU1xV29BOXZDQlpZMHlXRFBGRmoxaW5pNGNiSUhC?=
 =?utf-8?B?SDBXell2QXZMTSt1QmJpTEZYbERHdlRuck5MTHltbWR2Szl5eFZVM21BV3Vy?=
 =?utf-8?B?NCtpNjZxNVRGTTRWSlRZcDBUNjVUZ1lxV1dzY2I4ZTUxSWF6RHQ0ZndqVll4?=
 =?utf-8?B?UUwvTVNTRVBUS0lBc05QRVBEM2FNV0pka2E2K3VhVVZhc3FWZzQ0RndYYkVI?=
 =?utf-8?Q?QcGnmn+nbYvCqzP6UT4XT1071?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474c8bc3-a92a-4e05-8f28-08dcc4bce7eb
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 04:18:00.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unzeRQv9B9jDwpY6vBb8IQPwaJo0PB9cs2K9gvWpkwOqfL1qjA+ct8rpVLDooyZKASasv2r+Os0XxfnSDfzrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052



在 2024/8/25 12:10, zhiguojiang 写道:
>
>
> 在 2024/8/24 13:35, Andrew Morton 写道:
>> On Fri, 23 Aug 2024 23:02:06 +0800 Zhiguo Jiang 
>> <justinjiang@vivo.com> wrote:
>>
>>> After CoWed by do_wp_page, the vma established a new mapping 
>>> relationship
>>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma 
>>> are
>>> not same, the avc binding relationship between them will no longer be
>>> needed, so it is issue for the avc binding relationship still existing
>>> between them.
>>>
>>> This patch will remove the avc binding relationship between vma and the
>>> non-CoWed folio's anon_vma, which each has their own independent
>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>> I assume any performance benefits are unmeasurable?
> Hi Andrew Morton,
>
> Maybe, this patch theoretically has some benefits for rmap traversal of
> avcs in the system overall, but it seems difficult to test specific data.
> However, I added a debug trace log (as follows) in wp_page_copy() and
> observed that a large number of these abandoned objects still exist. I
> believe this will have a certain redundant overhead impact on anonymous
> folios' rmap avcs, so I want to remove it, which is also the most
> essential value of this patch.
>
> -- debug trace patch:
> diff --git a/mm/memory.c b/mm/memory.c
> old mode 100644
> new mode 100755
> index 3bf1943a4..bca96f791
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -83,6 +83,7 @@
>
>  #undef CREATE_TRACE_POINTS
>  #include <trace/hooks/mm.h>
> +#include <trace/events/vmscan.h>
>
>  #include <asm/io.h>
>  #include <asm/mmu_context.h>
> @@ -3412,6 +3421,39 @@ static vm_fault_t wp_page_copy(struct vm_fault 
> *vmf)
>                 folio_put(old_folio);
>         }
>
> +       if (old_folio && old_folio->mapping) {
> +               struct anon_vma *parent_anon_vma = 
> folio_anon_vma(old_folio);
> +               struct vm_area_struct *child_vma = vma;
> +               pgoff_t pgoff_start, pgoff_end;
> +               struct anon_vma_chain *avc;
> +               bool is_same_folio_av;
> +               bool is_same_avc_av;
> +
> +               if (!parent_anon_vma)
> +                       goto exit;
> +
> +               pgoff_start = folio_pgoff(old_folio);
> +               pgoff_end = pgoff_start + folio_nr_pages(old_folio) - 1;
> +
> +               if (!anon_vma_trylock_read(parent_anon_vma))
> +                       goto exit;
> +
> +               anon_vma_interval_tree_foreach(avc, 
> &parent_anon_vma->rb_root,
> +                               pgoff_start, pgoff_end) {
> +                       if (avc->vma != child_vma)
> +                               continue;
> +
> +                       is_same_folio_av = folio_anon_vma(old_folio) 
> == child_vma->anon_vma;
> +                       is_same_avc_av = avc->anon_vma == 
> child_vma->anon_vma;
> +
> +                       trace_mm_wp_page_copy(is_same_folio_av, 
> is_same_avc_av);
> +                       break;
> +               }
> +               anon_vma_unlock_read(parent_anon_vma);
> +       }
> +
> +exit:
>         delayacct_wpcopy_end();
>         return 0;
>  oom:
>
> -- debug trace log:
> RAM 16GB machine, boot trace log:
>   HeapTaskDaemon-5815    [000] .....    57.962911: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.962925: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.962935: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.962947: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.962960: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.962970: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963025: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963047: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963057: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963068: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963077: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963086: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963095: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963104: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963114: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963123: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963132: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963141: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963151: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963160: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963169: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963179: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963223: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963232: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963243: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963263: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963277: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963288: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963297: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963307: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963316: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963325: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963334: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963343: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963351: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-5815    [000] .....    57.963360: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    Profile Saver-3127    [001] .....    57.991334: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8121    [004] .....    58.927945: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8121    [004] .....    58.928210: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8121    [004] .....    58.928234: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8121    [003] .....    58.932256: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8122    [005] .....    58.935746: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8122    [005] .....    58.935907: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8122    [005] .....    58.935912: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8122    [005] .....    58.937307: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8122    [005] .....    58.937325: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8122    [005] .....    58.937330: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  processor-excep-3331    [000] .....    60.042006: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  processor-excep-3331    [000] .....    60.042864: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  processor-excep-3331    [000] .....    60.042893: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  processor-excep-3331    [000] .....    60.042933: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  processor-excep-3331    [000] .....    60.042979: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  processor-excep-3331    [004] .....    60.156496: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  processor-excep-3331    [004] .....    60.156628: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    Profile Saver-4298    [000] .....    60.311901: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [000] .....    60.825851: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [000] .....    60.826154: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [000] .....    60.826450: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [000] .....    60.826519: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [002] .....    60.837051: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   binder:1720_1A-3281    [001] .....    60.843870: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [007] .....    60.848054: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.849531: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.849676: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.849711: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.849759: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.849801: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.849812: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.849818: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [007] .....    60.850114: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [007] .....    60.850308: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [002] .....    60.850765: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [002] .....    60.850770: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7919    [005] .....    60.851695: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [002] .....    60.852102: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [002] .....    60.852120: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [002] .....    60.852124: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [002] .....    60.852129: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [002] .....    60.852136: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ReferenceQueueD-7920    [004] .....    60.852299: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [003] .....    60.855833: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   SnapshotWindow-1952    [003] .....    60.856436: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [000] .....    60.860096: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [000] .....    60.863771: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [000] .....    60.864041: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864255: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864261: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864373: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864376: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864379: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864381: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864384: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864386: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864388: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    mali-compiler-8132    [005] .....    60.864390: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [004] .....    60.864668: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [004] .....    60.864841: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [004] .....    60.871942: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [004] .....    60.871960: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  PowerManagerSer-1856    [004] .....    60.872276: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [000] .....    60.898670: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [000] .....    60.898816: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [000] .....    60.898894: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [000] .....    60.898975: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [000] .....    60.899023: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [002] .....    60.908909: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [002] .....    60.909095: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920062: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920174: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920227: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920356: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920419: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920426: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920438: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920449: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.920525: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.921085: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7982    [003] .....    60.925772: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152644: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152708: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152720: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152729: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152738: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152746: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152755: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152761: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152770: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152780: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152787: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152843: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152852: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152865: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152872: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152879: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152885: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152892: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152899: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152906: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152913: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152920: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152925: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152932: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152938: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152944: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152950: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152956: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152964: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152972: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152979: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152985: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152991: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.152997: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.153004: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.153010: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.153017: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.153024: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.153030: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.153037: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7235    [001] .....    61.153044: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201692: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201741: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201752: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201761: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201771: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201779: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201785: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201792: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201802: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201811: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201818: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201862: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201871: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201877: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201886: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201892: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201898: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201905: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201911: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201917: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201923: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201928: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201934: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201941: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201947: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201953: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201958: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201964: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201971: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201978: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201984: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201989: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.201996: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.202002: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.202008: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.202013: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.202020: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.202025: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7723    [001] .....    61.202033: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  m.bbk.launcher2-2470    [007] .....    61.256512: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:1720_C-2875    [000] .....    61.263076: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:2757_2-2792    [005] .....    61.273692: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:2562_A-4454    [002] .....    61.273713: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:4905_3-6219    [003] .....    61.274793: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:5103_4-5352    [000] .....    61.275539: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:2562_A-4454    [005] .....    61.278025: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>           NormHT-3019    [003] .....    61.278292: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  UsageAppPidMana-6780    [005] .....    61.281626: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  UsageAppPidMana-6780    [005] .....    61.281633: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.283432: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.283453: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.285153: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.285185: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.285190: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.285197: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.285205: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  m.bbk.launcher2-2470    [006] .....    61.286188: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  m.bbk.launcher2-2470    [006] .....    61.286296: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.288272: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ndroid.systemui-2504    [007] .....    61.289578: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290225: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290255: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290289: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290320: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290336: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290344: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290347: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290422: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290431: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290435: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290444: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290454: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290805: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290839: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290851: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.290859: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.291183: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.291208: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  bluetoothgnssco-3134    [004] .....    61.291217: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.292149: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.292170: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.292190: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.292247: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:7783_4-8143    [003] .....    61.292877: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.297263: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.301792: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.301833: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.301852: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.301862: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.301895: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304695: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304699: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304701: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304704: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304707: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304709: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304712: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304715: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304719: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304722: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304725: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304728: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304731: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304734: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304737: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304740: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304743: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304794: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304798: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304800: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304804: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304806: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304809: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2778    [000] .....    61.304813: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>           Poller-3115    [000] .....    61.334540: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>           Poller-3115    [000] .....    61.334649: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>           Poller-3115    [000] .....    61.334895: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>           Poller-3115    [000] .....    61.335042: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>          battery-3131    [001] .....    61.346283: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>        pie_modem-4828    [000] .....    61.357512: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    Profile Saver-3264    [005] .....    61.369759: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    Profile Saver-3264    [005] .....    61.369774: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.389873: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.389979: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.391443: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.393149: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.394116: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  NightPearlSubTh-3741    [002] .....    61.394121: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.394384: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.394699: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.394738: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.394846: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.395038: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.395207: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.396856: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  NightPearlSubTh-3741    [000] .....    61.397907: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.399286: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.399814: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.400471: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.400583: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.402722: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.404684: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.404783: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  NightPearlSubTh-3741    [005] .....    61.405408: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.406521: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-2714    [003] .....    61.408788: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.409364: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-2714    [005] .....    61.410221: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-2714    [005] .....    61.410270: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.412004: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.412914: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-2714    [005] .....    61.414456: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  VivoDisplayOver-2453    [005] .....    61.414679: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  VivoDisplayOver-2453    [005] .....    61.414775: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.416500: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.416678: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.425169: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.428085: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.439897: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.479768: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.479860: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:7783_4-8143    [002] .....    61.484606: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.487507: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.487731: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.491316: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.495249: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.495260: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.495301: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.495378: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.496233: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.496395: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.496958: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.496977: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.498412: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.499505: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [000] .....    61.501465: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [000] .....    61.501479: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [000] .....    61.501538: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.501563: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501675: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501692: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501698: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501704: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501707: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501711: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501722: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501727: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501729: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501734: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501738: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501744: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501747: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501749: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501757: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501759: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501763: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .n...    61.501766: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501772: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  martmultiwindow-2687    [004] .....    61.501783: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  martmultiwindow-2687    [004] .....    61.501836: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501840: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501847: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501852: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501854: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501857: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501860: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501866: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501874: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  martmultiwindow-2687    [004] .....    61.501898: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  martmultiwindow-2687    [004] .....    61.501907: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  martmultiwindow-2687    [004] .....    61.501911: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  martmultiwindow-2687    [004] .....    61.501915: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>               sh-8169    [005] .....    61.501984: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  o.secure:remote-4982    [000] .....    61.503007: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-7918    [005] .....    61.509140: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.511729: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.511737: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>         Single_1-5255    [000] .....    61.521244: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524405: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524428: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524449: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524509: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524541: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524549: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524559: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524575: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524580: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524601: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524605: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524614: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524618: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524622: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524627: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524645: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524657: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524665: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524724: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.524740: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525124: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525143: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525148: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525152: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525156: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525162: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525219: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525261: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525279: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525285: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525304: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525322: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525373: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525454: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525458: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525471: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525475: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525478: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525482: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525488: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525493: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525497: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525527: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525542: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525545: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525765: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525791: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525847: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525903: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.525954: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526025: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526035: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526284: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526317: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526322: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526331: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526336: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526347: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526351: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526416: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526438: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526505: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526533: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526556: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526560: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526572: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.526682: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.527702: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.527767: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.527881: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.528018: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.529450: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.530086: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.530576: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [005] .....    61.531608: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532191: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532250: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532256: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532263: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532268: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532333: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532541: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532563: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [007] .....    61.532755: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532832: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [001] .....    61.532856: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [007] .....    61.533662: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [007] .....    61.534509: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [007] .....    61.534640: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             main-8182    [007] .....    61.534722: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.534774: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.534806: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.534818: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.534839: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.534867: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535202: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535212: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535250: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535260: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535264: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535269: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535312: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535315: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535318: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535433: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535436: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535438: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535457: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535461: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535491: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535504: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535508: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535518: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535526: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535533: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535540: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535544: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535549: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535552: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535558: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535567: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535572: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535577: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535584: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535587: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535592: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535595: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535609: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535614: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535618: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535625: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535631: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535635: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535644: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535647: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535650: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535663: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535667: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535670: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535680: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535687: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535692: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535705: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535732: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535772: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.535788: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   Signal Catcher-8189    [004] .....    61.535946: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   Signal Catcher-8189    [004] .....    61.535955: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.536181: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.536234: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.536257: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.536311: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.536393: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.536410: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  perfetto_hprof_-8190    [000] .....    61.536467: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.536490: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537091: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537096: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537148: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537175: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537189: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537205: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537222: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.537332: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.537482: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537540: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537546: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537606: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537681: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537733: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537742: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537799: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537809: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537842: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537857: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537909: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537938: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537965: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537971: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537974: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537989: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537993: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.537999: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538003: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538008: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538014: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538018: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538053: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538056: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538111: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538122: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538142: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538164: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538177: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538189: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538195: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538255: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538262: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538268: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538276: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538281: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538289: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538292: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538312: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538348: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538466: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538483: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538508: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538523: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538533: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538546: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538549: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538562: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538575: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538617: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538629: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538633: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538635: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538727: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538739: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538791: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538794: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538796: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538861: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538921: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538954: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538969: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.538981: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539005: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539032: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539054: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539072: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539100: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539168: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539309: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539375: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539382: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539386: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539389: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539398: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539401: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539405: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539415: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539421: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_1-8196    [005] .....    61.539432: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_1-8196    [005] .....    61.539440: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_1-8196    [005] .....    61.539452: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_1-8196    [005] .....    61.539456: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539526: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539577: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539586: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-7791    [002] .....    61.539617: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539629: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539640: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_1-8197    [000] .....    61.539658: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539664: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539679: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539685: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539689: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539693: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539700: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539709: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_1-8197    [000] .....    61.539711: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539713: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539733: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.539759: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540008: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540028: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540033: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540056: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540059: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540061: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540065: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540077: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540082: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540101: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540104: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540128: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540132: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540152: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540173: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540178: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540198: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540201: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540214: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540221: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540239: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540265: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540339: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540352: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540359: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540371: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540374: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540377: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540457: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540511: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540623: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540636: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540641: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540756: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540788: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540805: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540824: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540828: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540836: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540852: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.540961: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.541017: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541025: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541053: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541071: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541094: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541161: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541213: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541224: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541237: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541241: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541288: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541295: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541303: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541341: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541367: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541373: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541387: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541409: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541426: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541463: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541705: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541727: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541736: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541768: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541773: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541829: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541843: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541848: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541882: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541892: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541900: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541962: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.541972: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542128: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542152: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542357: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542514: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542529: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542550: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542554: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542600: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542631: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.542653: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.543529: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.543592: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.543600: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.543606: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.543611: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.543621: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.543720: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.543752: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.543804: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.543809: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [003] .....    61.543814: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.543879: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [004] .....    61.543920: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.544478: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.544719: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.544916: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.544923: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.545118: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.545375: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.545925: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [000] .....    61.546508: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.548130: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.548269: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.548972: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.549254: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.549279: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549485: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549501: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549793: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549840: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549883: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549912: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549937: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549973: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.549986: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550008: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550027: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550042: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550052: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550062: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550069: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550077: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550124: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550133: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [003] .....    61.550229: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.550328: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.550390: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.550397: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [002] .....    61.550483: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [004] .....    61.550619: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [004] .....    61.550669: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [004] .....    61.550718: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [004] .....    61.550789: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [004] .....    61.550798: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [004] .....    61.550808: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551001: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551121: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_3-8199    [006] .....    61.551161: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_3-8199    [006] .....    61.551196: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551318: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551425: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551430: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551435: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551442: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551491: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551612: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  re-initialized>-8182    [005] .....    61.551620: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551827: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551834: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551861: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551917: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551931: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551944: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551975: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551978: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.551997: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552055: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552083: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552125: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552209: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552219: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552225: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552232: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552251: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552255: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552266: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552336: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552362: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552369: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552398: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552407: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552412: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552418: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552428: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552433: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552447: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552455: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552480: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552494: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552512: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552557: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552571: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552652: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552664: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552753: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552788: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552817: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552842: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.552854: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.553004: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.553295: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.553912: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.553955: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554006: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554017: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554069: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554072: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554079: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554095: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554133: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554152: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554167: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554170: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554179: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554216: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554223: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554230: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554246: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554253: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554264: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.554269: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.554455: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.554482: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.554504: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.554898: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555004: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.555011: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555343: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.555361: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555398: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555439: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555459: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555464: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555569: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555580: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555595: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555601: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555604: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.555623: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555624: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555658: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555672: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555831: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555902: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.555985: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556106: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556144: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556157: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.556428: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556560: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556707: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556763: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556767: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.556787: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557010: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557022: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557115: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557193: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557208: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557258: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557355: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557385: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557450: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557456: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557459: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.557596: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.557725: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558069: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558101: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558107: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558322: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558341: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558345: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558348: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558351: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558388: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558391: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558546: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558549: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558627: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.558875: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559037: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559153: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559196: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559199: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559202: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559207: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559212: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559217: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559220: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559224: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559242: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559268: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559293: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559454: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559946: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559950: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559956: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559972: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.559976: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560014: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560071: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560095: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560124: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560153: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560170: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560187: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560191: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560206: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560395: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560407: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560429: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560446: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560454: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560460: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560466: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560469: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560476: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560485: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.560505: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560577: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560588: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560593: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560596: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560600: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560603: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560608: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560610: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560621: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560625: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560632: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560639: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560656: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560660: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.560686: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.560705: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.560825: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561067: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561186: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561227: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [003] .....    61.561266: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561306: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [003] .....    61.561310: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561326: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [003] .....    61.561331: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    61.561338: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561355: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561359: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.561370: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.561733: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.561759: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [003] .....    61.562023: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562462: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562470: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562488: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562496: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562513: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562524: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562531: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.562757: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [003] .....    61.562800: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [003] .....    61.562814: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.PerfThread-8206    [004] .....    61.562976: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563140: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563256: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563272: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563276: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563280: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563283: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563288: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563321: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563348: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563353: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563364: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563370: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563373: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563378: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563386: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563395: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563415: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563462: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563479: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563487: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563502: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563509: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563516: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563526: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563552: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563565: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563580: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563584: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563589: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563613: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563620: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563625: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563693: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [001] .....    61.563768: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [001] .....    61.563775: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [001] .....    61.563781: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [001] .....    61.563785: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [001] .....    61.563790: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [001] .....    61.563794: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8205    [001] .....    61.563800: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.563879: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564234: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564501: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564630: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564654: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564663: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564810: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564842: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564855: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564869: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564887: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564894: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564898: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.564908: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.565128: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.565415: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.565457: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.565462: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.565467: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.565564: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.565664: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.566328: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.567005: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.567168: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [001] .....    61.568012: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.568845: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.570162: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.570174: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [003] .....    61.570286: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.570520: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [003] .....    61.571810: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [003] .....    61.572348: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [003] .....    61.572457: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.574653: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.577148: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.577176: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.582914: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.582923: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.583285: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.583812: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.585169: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8214    [003] .....    61.585181: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.585275: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.585302: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>         Thread-2-8214    [003] .....    61.585494: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.585860: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.586393: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.588550: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.588553: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.588978: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.588992: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.589069: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.589243: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.589250: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.589254: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.589259: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.589294: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.589311: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.589324: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   CrashCollector-8215    [006] .....    61.591261: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   CrashCollector-8215    [006] .....    61.591423: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   CrashCollector-8215    [006] .....    61.591466: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594138: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594172: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.594277: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594344: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594361: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594366: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594370: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594443: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.594447: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8219    [003] .....    61.594843: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.595427: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.596552: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.596557: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.596742: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8224    [007] .....    61.596834: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  SharedPreferenc-8224    [007] .....    61.596880: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  SharedPreferenc-8224    [005] .....    61.597093: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  SharedPreferenc-8224    [005] .....    61.597102: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.597188: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    SqlWorkThread-8223    [007] .....    61.597231: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.597912: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.598073: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.598090: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.598135: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.598252: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.598280: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.598284: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.599089: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.599144: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    SqlWorkThread-8223    [002] .....    61.599328: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    SqlWorkThread-8223    [002] .....    61.599384: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [000] .....    61.600943: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.601528: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.601534: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.601559: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.601625: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.601683: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [006] .....    61.603507: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [006] .....    61.603512: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [006] .....    61.603518: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [006] .....    61.603745: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.604983: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.605058: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [007] .....    61.605065: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605135: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605155: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605159: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605165: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605171: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605176: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605179: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605182: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.605260: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.606762: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.606887: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.606928: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.607469: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_2-8197    [006] .....    61.608228: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608703: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608813: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608822: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608831: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608863: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608913: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608975: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608979: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608986: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.608999: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.609007: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.609024: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.609078: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.609082: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.609107: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [004] .....    61.609152: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>         AiPool_1-8229    [002] .....    61.609778: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613231: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613244: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613249: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613257: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613261: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613269: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613273: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613277: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613281: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613286: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613290: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613296: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613301: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613304: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613308: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613313: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613317: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613368: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613372: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613377: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613381: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613385: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613389: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.613393: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.615399: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.615458: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.615574: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.615592: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [007] .....    61.615880: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [007] .....    61.615976: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [007] .....    61.616001: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.616801: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.616824: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-8191    [003] .....    61.617197: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.617936: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618230: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618247: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618270: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618274: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618280: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618341: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618413: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618416: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618464: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618929: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618934: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.618975: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.619049: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.619056: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.619316: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.619555: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.620097: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.620104: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.620143: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.620661: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.620691: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8217    [005] .....    61.620738: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8234    [000] .....    61.625835: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.626662: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_4-8230    [006] .....    61.629081: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:8182_4-8230    [006] .....    61.629092: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [005] .....    61.629296: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [005] .....    61.629366: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [006] .....    61.629971: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [006] .....    61.630066: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [006] .....    61.630075: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [006] .....    61.630081: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [003] .....    61.630257: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [006] .....    61.630264: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [006] .....    61.630268: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  AiSdk-InitThrea-8241    [001] .....    61.630450: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.631137: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [002] .....    61.631564: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  AiSdk-InitThrea-8241    [003] .....    61.633065: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   LocationThread-8242    [006] .....    61.633687: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.634667: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>           NormHT-8245    [004] .....    61.636064: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     AsyncHandler-8239    [007] .....    61.636804: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.636962: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.636990: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.637008: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   binder:1720_12-2903    [003] .....    61.637180: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [006] .....    61.644697: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.647449: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.647480: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.648033: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.648671: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.648708: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.648718: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.648905: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_Agen-8213    [000] .....    61.649650: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.653256: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.653265: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.653425: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   mali-mem-purge-8202    [000] .....    61.653620: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.653634: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [004] .....    61.653727: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.656629: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [005] .....    61.656703: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [002] .....    61.657788: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ivo.ai.gptagent-8182    [002] .....    61.657795: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    binder:7571_3-7625    [001] .....    61.661005: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  AiSdk-InitThrea-8247    [006] .....    61.661161: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.662599: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8256    [007] .....    61.662861: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8256    [007] .....    61.662929: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8256    [007] .....    61.662931: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8256    [007] .....    61.662998: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-7-thread-1-8252    [004] .....    61.663503: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.664238: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8261    [006] .....    61.670084: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8261    [006] .....    61.670168: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8261    [006] .....    61.670171: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8261    [006] .....    61.670774: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [003] .....    61.676618: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8262    [000] .....    61.677176: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8262    [000] .....    61.677293: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8262    [000] .....    61.677303: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>             init-8262    [005] .....    61.677899: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    SqlWorkThread-8263    [003] .....    61.678894: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    SqlWorkThread-8263    [003] .....    61.678909: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [003] .....    61.682459: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683149: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683194: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683233: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683240: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683260: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683291: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683304: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.683337: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [003] .....    61.684546: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [003] .....    61.684580: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [003] .....    61.684673: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [003] .....    61.685496: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [003] .....    61.685508: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [003] .....    61.690148: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [003] .....    61.690169: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  MLUpdateTaskEng-8255    [002] .....    61.690862: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691805: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691829: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691836: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691844: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691850: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691860: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691868: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691881: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691888: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691914: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691921: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691928: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691933: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691940: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691945: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691952: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691957: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691963: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691969: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.691981: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.692035: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.692043: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.692103: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.692111: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.692810: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.692872: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693009: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693016: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693023: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693044: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693134: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693137: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693147: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693167: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693177: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693183: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693229: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693253: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693261: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693278: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693287: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  pool-6-thread-1-8267    [000] .....    61.693330: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693343: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693361: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693482: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693493: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693530: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693572: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693640: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693649: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693768: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693857: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.693908: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.694554: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.694599: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.694607: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [003] .....    61.694650: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>       Request #1-8268    [002] .....    61.695905: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697803: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697810: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697815: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697820: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697825: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697829: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697834: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697838: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697845: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697849: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697854: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697859: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697864: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697868: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697873: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697877: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697882: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697932: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697937: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697942: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697946: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697950: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697955: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  .vivo.aiservice-7583    [001] .....    61.697961: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [002] .....    61.698200: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.700863: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.701275: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.701841: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.701851: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.702429: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.702438: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703156: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703164: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703172: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703176: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703179: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703185: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703190: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703194: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703200: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703204: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703209: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703213: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703216: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703222: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703226: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703397: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.703634: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [002] .....    61.703821: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [002] .....    61.703926: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [002] .....    61.704182: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.705250: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.705260: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.705329: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.705574: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.706333: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.706936: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [000] .....    61.707058: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [001] .....    61.708706: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [001] .....    61.709536: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [001] .....    61.710736: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  LiteThread_2d63-8254    [004] .....    61.710948: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [001] .....    61.710999: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [001] .....    61.711451: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [001] .....    61.711963: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>    TrackerCore-1-8270    [000] .....    61.713088: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  OperationManage-8281    [002] .....    61.717872: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  VCodeThreadPool-8282    [002] .....    61.723841: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   CrashCollector-8215    [002] .....    61.846548: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   CrashCollector-8215    [002] .....    61.848613: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   CrashCollector-8215    [002] .....    61.848807: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  Jit thread pool-2679    [001] .....    62.135099: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.168928: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.169657: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170039: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170049: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170104: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170109: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170114: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170120: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170124: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170129: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170137: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170142: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170544: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>     RenderThread-8167    [000] .....    62.170772: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  displaycamerafl-3137    [003] .....    62.368817: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [003] .....    62.633555: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [003] .....    62.635021: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  NormalTask-thre-8290    [001] .....    62.635090: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.636348: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638088: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638100: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638120: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638127: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638192: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638213: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638293: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638407: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638429: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [001] .....    62.638549: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  NormalTask-thre-8290    [003] .....    62.641705: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [004] .....    62.643398: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [004] .....    62.643414: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [004] .....    62.643436: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-4-8296    [006] .....    62.643491: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-4-8296    [006] .....    62.643501: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-3-8295    [006] .....    62.643603: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-3-8295    [006] .....    62.643612: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-3-8295    [006] .....    62.643948: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  IOTask-thread-1-8293    [002] .....    62.644841: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  vivo.nightpearl-7783    [002] .....    62.835733: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.948572: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.948716: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.948769: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.953295: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966345: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966492: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966544: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966616: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966678: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966694: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966704: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.966789: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.967441: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>   HeapTaskDaemon-7936    [002] .....    62.973245: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ReferenceQueueD-7937    [000] .....    62.974855: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>  ReferenceQueueD-7937    [000] .....    62.974864: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>          suspend-3136    [003] .....    63.350079: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>          suspend-3136    [003] .....    63.355014: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>          suspend-3136    [003] .....    63.355130: mm_wp_page_copy: 
> is_same_folio_av=0 is_same_avc_av=0
>
>
> Thanks
> Zhiguo
>
>>
>> I'll queue it for testing and shall await reviewer input.
>>
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio 
>>> *folio, struct page *page,
>>>   #endif
>>>   }
>>>   +/**
>>> + * folio_remove_anon_avc - remove the avc binding relationship between
>>> + * folio and vma with different anon_vmas.
>>> + * @folio:    The folio with anon_vma to remove the binded avc from
>>> + * @vma:    The vm area to remove the binded avc with folio's anon_vma
>>> + *
>>> + * The caller is currently used for CoWed scene.
>>> + */
>>> +void folio_remove_anon_avc(struct folio *folio,
>>> +        struct vm_area_struct *vma)
>>> +{
>>>
>>> ...
>>>
>> In mm-unstable a lot of vma functions have been moved into the new file
>> mm/vma.c.  I suspect folio_remove_anon_avc() should be there also?
This patch belongs to anon_vma rmap's content, and it seems more
appropriate in mm/rmap.c?

Currently this patch has still some issues, and it may take some time
to fix it.

Thanks
Zhiguo



