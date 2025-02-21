Return-Path: <linux-kernel+bounces-526259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C095A3FC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC56F17B796
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE8211473;
	Fri, 21 Feb 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DOLzUtFL"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765561E7C09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156698; cv=fail; b=PmPH6Of7+lxIifkDuwH3uYsSbRbh/w6FZa5+iFszupqsw/N6HA3T+B3g7NnP0uaGTh60906KoLwWSCdsXnKGSW+8xJSBQYTb3Tu6/Crt+lk55v8hYeC29dhTO0qaMFMEnU8OMIUIxuZmOV1A7s3G4cj+SnVCsLzS4Fmy8SlvBnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156698; c=relaxed/simple;
	bh=01a2jpDJoa6jQZMbja6atjSxYy0baRSa9jKST5uGJOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hO1kkMrjciSjOGRcHGjZNYhW3/yaKKvqaAePV22JHhDAmmHoi07gaPxXfOo9qRxH0eVdhO7J78gDW+LjxNOiQDJw4TpEMRii5LebIB3lOOtFvIFET6dvq/dx1wqo0tQgN0/jig2UXi0XiM/oqr2b3iFjCvZbxOUmrYhIDCePues=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DOLzUtFL; arc=fail smtp.client-ip=40.107.241.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK2FHz8d/YLhLqgauUJR8TL8jmFcBJdt+0Fczf7AHABx79HAQi9e6FDwTEcYevEjjxdnYe542e56F1er0kFHaYsEj8Q7RIPfEfLGR0UeJ3NOqIjHH4gQ3Cw+kB5HCFtdUo0DE6ZzDzoLlBtV8PwyQLxXkPJaRO0TvqZa9k/6Kfly5tNsFQBn4QvBjOI3K5cxyz3XKA5Uai4AGiyXV7nifNF1dlIJCDE1ZwaLk/iNOFS5PWFs5/NwVs9hbFPkJ1LHLUPnJmfJLVoZ7ugeG/GWrazJ2A/4CjHY+Ja73aF1HWoH2Z//ScRT6oV/4EIpNLI6QRZ7AYbw87VJyivlQpyzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK4gpGJVpyR0pJGikVv86mYJ4k0cSFlwIS90PVu7zHM=;
 b=PMwslWFyiZthmDD7N+lD/YKLy486lyOL0490BYrthI81by5k2wr0NQPpRDTvp91JxjxHPeRJN2KQ+7HOJXpZeZezf7oCMwMPqOO8YxBX1aq5WGBtVSHo5MvIKoIO19WIpba97B9J2oeapqWFAp2fce/KznhU4bLoT/iadhXU3huN+o8yE18SOVnwJFTe6qUvpNr4765P5V7h+33u41/V/RdEyeAO/mvcimblcwkk/GUnXlQE5342OcGfjleKM6o4eAmpcoVQebCb0+Os15VM7sW+0oesmwFIVrvSOnL321XQwl4+AePiQBOgN2TIvFssQDj9VsugaZsFvB3NumLE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK4gpGJVpyR0pJGikVv86mYJ4k0cSFlwIS90PVu7zHM=;
 b=DOLzUtFL42EGZV/kuwHgSDNWhnQB06p0j++2Etzmh1jLmzVnsgp19aX7aYYJIPqO7rER18YIBYQPt6Jf+/VmRvbN0QC83fLJRd2E5vBiGiiNE5paC+KqEYTPAhC/vVwC1cX+cqqFvlShtImz13uRskn1So1liRa6NZL2ltQx7F84nJCU5qrzsWkoplevGwDSQj8WYfftJJxciZMAZZ5V/LTxi/vMuuH7m2bA/aPmoPJBU2BO+tGfh6qqWzdCJUmv1OrqkjGiWgRVslrBz8O0/q3G3mMFBCrwWHLEW+UH+SBSdPb7V56iEKaTIRBK81DFcG4qOrtOxP4CZHKRe0bG5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:51:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:51:33 +0000
Message-ID: <e9964501-d19c-4a4b-9653-2081067fe45a@siemens.com>
Date: Fri, 21 Feb 2025 17:51:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/gdb: Add $lx_per_cpu_ptr()
To: Brendan Jackman <jackmanb@google.com>,
 Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Rommel <mail@florommel.de>, linux-kernel@vger.kernel.org
References: <20250220-lx-per-cpu-ptr-v2-1-945dee8d8d38@google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250220-lx-per-cpu-ptr-v2-1-945dee8d8d38@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: e6490200-b454-407e-db3b-08dd5297fefb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGlJdEszSEU0Sk15QUpXSVl2R0RzQkJ3dXNWWXFhTmEyaE9BODNYd3ZSNkgv?=
 =?utf-8?B?MXBGMlBBTU5zTHo5MG1Mbno0QmVwcGE5UldGQ1RIemhtZDBKT3RFVEZiM1FI?=
 =?utf-8?B?dXhNR2ZNbkprTmdVWjlNcEw0Ylc4QXcrblhLeExqZHhkcjQzUkRpcGRLQjNU?=
 =?utf-8?B?ZGV0UDZMUWlUaEszbERZR2JHRHZKWG1ObW85T0cxbForc3lIQ2VjNEQrS0l2?=
 =?utf-8?B?eDZrOVY2VlNsMXJic3lSZHRaTDl4TnUyVGM5Tm4xTkpKOGxuaHVuMTBCVTQv?=
 =?utf-8?B?WmY4eWJtSWdVUFNZM0RyL2tBWXhzMG82ZUVtQmorUVRLMHZ5R05XbTFwZ01H?=
 =?utf-8?B?dWRKR3N6M1FPZXlzWnlCMDlsYzFjWnEvNG0xUWpSdVkvVWZDV0R0dWQ2ajRN?=
 =?utf-8?B?WWU0RklrOERlbG9jSWJ1VUs5VjdYNXhxaVB6aHppSFhoZTVBYzhiemNOdFl2?=
 =?utf-8?B?aElSSmhjbkprMnArV0h6cUJ6Y0ltczRSczJWU0pPZXJVNVYvWWxhaGxsZ1Bm?=
 =?utf-8?B?d2gyUzYvMzJ6UDloRk00ZlhVdStKOENtMEtucis5Z213eFJ0OW14TXNLSnhq?=
 =?utf-8?B?dElCNUpCbi9tSVI1YUt2c1NwcTdaSVhEZlIwUHpSbzZqNkhJOEtxeERWMHpk?=
 =?utf-8?B?WjNHMkkvdm1vMmtoRE80eTlyNUI0a3RXa2VpVjFzblhSZ0dxaEMzT3N5N2lQ?=
 =?utf-8?B?a1hXd3FNajFGNXo0dVF6aHdxQTIwRlEyS0pURFM0NGQwaWRocEpHUVFvUC9h?=
 =?utf-8?B?WlltNDVKRmQwQVAxdnRYNS9Kcy91WHpLZHBEdzhlelBWUmV4OWxlRjBrVDZo?=
 =?utf-8?B?VStIbjVXblo3cGRqeUw1NE9QL0lSZjVjdkZnQ2pGVWxwR1hsTGdjc08vcWlj?=
 =?utf-8?B?YzZOVDhjakc5WGtmZDFxN3BML3M0ZkhlNlJ3UVJYRjJMVFc3QndXcERYOW9M?=
 =?utf-8?B?bXBiQkJzU0ZzTFZKcnQrUG1EQi9SMWZWd2tEcUtmR3puNlBadjA3OGM1czZZ?=
 =?utf-8?B?L2pMMDVIR256enZPaFlQbzNBWms2MUp3YUdVYnk0UDBVdmtYT3pRUzlvQmV4?=
 =?utf-8?B?Q1JEakhYdHg4c09UMFZYUnRhOXhmMWYxUGlXTUs4c3lWRUc4ZXBjaTVRWVRZ?=
 =?utf-8?B?YmdXeWUyelk4U0MxdGNpNlRreFZCL29DY2kyRFpzUEV0eXZjZjk3YWRXZzhH?=
 =?utf-8?B?T2RDSkJrTHo4Z2lWeE1hdjFvd2l4RUZ0MlhEUVR2ODlSMzNEWnNVMUUwTS9s?=
 =?utf-8?B?NEJuWmx6SDNNazdYRUFFQUttR0RoWlVOK0Q1VkZZWU9zYXUvblZYMzNZVmlq?=
 =?utf-8?B?a1I1TjRzQVJRUFpRU1B4aEtndDhHUm5sYlNKS0RaYlVGNVdQelRScTJyeDA1?=
 =?utf-8?B?ejR5d1VWQUNGYzAwRXA0MnJ5cDRJZDc3QWorK3BCREFhcnMrMGtQOUF3UUdp?=
 =?utf-8?B?U1l3dExEajh5Y09nNFhFZndMR2JTWHlTeFRnanI2UUdGVnkyWEI3WlVlejBi?=
 =?utf-8?B?MWVlZnlEcUI5MWxKa2VqL1E5V3RBbTBwTmVabDV3c0JFVGFuaDUweUJlaXB1?=
 =?utf-8?B?UEM5cmYxSXVuOVoxR0Jjdy93V2FiT2lFRUI0WkZFemFoaFNRbVcyMEJrZCtE?=
 =?utf-8?B?elR4WTUyRWdmQVh1dzdXNDE1cWZXRlhPR2M0Q1dia0lweGhrZ1ZhZG9zRmhs?=
 =?utf-8?B?VFJ2MC9SM0ZMQU95VHJHTjhWRmpXcW9QZDZEUjNMeHlYY0tkcnIwL0IwdlZu?=
 =?utf-8?B?bW85MU9YZjVzMERXQTZpcnV3WGNGRzhkTG4wQk5oaWh5U0hqSnVNVUNKdDE0?=
 =?utf-8?B?VklHY0hWVnBMa0RUdGJxWi85L2xHank2eEV3aSt0NTB0MUZpeHB2R2RxVWc0?=
 =?utf-8?Q?jdJMUK6lA0iuU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDE4bTFEK3JkaExpbm8xaTNCU1VoMjBuaC9wb1ZTU2VUdFJTd005anljcG44?=
 =?utf-8?B?WHZxUkhJWG5TYXVTeDFZUlFkL01EbW9yc2VQR2g2eVVRQjhvak5NYnkyaE94?=
 =?utf-8?B?TU5Odno3WEt1V1JkdFVRUld6WjNnZEFBN1prbU1PMDIzb084RWZhdmRMNWc2?=
 =?utf-8?B?OVNXYWZRUUxnUUxNRmJtRlpGTGQ2aXp4bnFTSm1Db3V4azNOL2w3VENGM051?=
 =?utf-8?B?T3pMSCtNcUNxU0NqTVhWanRPa1RXMlE3OGtzNGpsNEplUHN0amhIZEE4NTV1?=
 =?utf-8?B?RlFTVnhDVEsxZGtlb0FIZVNoQUpBNGFEbVc5NkE3d1E2d21HSnlXSjFOK2dq?=
 =?utf-8?B?OTREQy82ei9LbFhrUFFWZzBwU1ZZSGJ4UW1mcy9rR0J2Mkt2T0hOTldGMklv?=
 =?utf-8?B?QnlYUWJ5d2RnVENxZTl5TVJLU1I0ekdPQkE0TXlJelNIVXhoczBmWTBjWkNx?=
 =?utf-8?B?Zkl0cFpoUXlOZnR1cG8vNlZnek13QlIxU0lnL0syN2VhbExPRmM5ak9BbE8r?=
 =?utf-8?B?c3pzcnZIcjByWm13SW5UdjBUYW1HY3o5a3ZXRlFMQllJQ3ozYW12c2xOTWN6?=
 =?utf-8?B?QlVBUW9mSENYN1htTE1vWWFJQnhFdGVRdTA0TStoUGEvaGZQeFNtNnROVitp?=
 =?utf-8?B?TS90Tk90T0FXdjV6emhPTUQ1bTY4citKbEM3YWVNeGIxK2pMWDh0QkZKVFQv?=
 =?utf-8?B?aVhOY2taZFF5S042eGorTGRkd3ZId1loSGR1a2U3T3dhUFphR2Y1U1h4SWt0?=
 =?utf-8?B?Z29yUzBlT3JwWkZ4Zzl6ZzVoWHJxTFVpc3ppVTlKSVA0elN2clNIZ296WlFt?=
 =?utf-8?B?VC96MjdBd3p5UlJSNHZYZFE4YUpLZGcvZXBZZmh0M0NpcWVjTnBHcWFGeVNo?=
 =?utf-8?B?WUR1OXBKRjlRN0YxZ1Btbm9ZNzBnejUvR0tnQ0ZrblQ4WU5WejIwc3lXMEdD?=
 =?utf-8?B?NnVuenRidk5JSXhTRWFYcmRocFhuZGdvYml6Vjh3bGFZS0ZxSmo4RUhvM21z?=
 =?utf-8?B?c3pEeHJ3NExqR3pDK2ZsTm9TWGJXenFZelorYWNId09TUEdFOGpoTFdzSWxF?=
 =?utf-8?B?amFJeEloZFk0eDZBcHc0QWNDbWxuVzZaVnNLeVFtZlpVcUZYdVVoZGErMFFq?=
 =?utf-8?B?ZlMzMTFFM3NnY0lkT1E4cXB0WlgwZ0U5cThRNXJ2aEIxUUFKM2IyVVI3QThh?=
 =?utf-8?B?UklTc1BNZTRjTWxqeG1NTERlOS9pZmd2VTNDSmR2RDVsYkZUeWNuT0VvZFh6?=
 =?utf-8?B?SWgrdFk3c2ltWjk5dnZqUTZnbDVGdkZuTktTTGxGVHR4bEs5TXU0RERweHV3?=
 =?utf-8?B?NFBadkJCd3U5NTRLcHF4US9vam9tUnFEdVNKbWovaFUzclRXQzA0ZTVnSTRt?=
 =?utf-8?B?bVBXNmdNOTRMUElWbXg0QTc3Q2JWclVoNS9uTjZ5NkFPYzdBVDkweWZLcjN0?=
 =?utf-8?B?Z0lmMlNWaS9Dcm5KVGw4N216aUY5cTk3M1l6cTBVMHJEdmpNa3B5WnpLSkR2?=
 =?utf-8?B?aEFJOWh0YXluczUrdXJ4NzAxQ2puOW5WbFAydGdrczYwa1pSd0x0cUwvMnRp?=
 =?utf-8?B?Z3NtVjlsVFdtM2preS94NkVHRkUwK2VSTERISGVJUDV1d1d4UHFtcWh2YWdK?=
 =?utf-8?B?M2ZZcWU4WXBFQTNDNWZVRDVick1CRkpjaEZ4TStLSHBnUG9PTXEvM2dSQWd2?=
 =?utf-8?B?UmpjVDVZM3RtNitTc3l1a1BvcU1yclhaWi9VOHB0cXhMczB3b2Y5UWF0MkJH?=
 =?utf-8?B?SUtMVm1aZFVhT0JKVng3RG8rSHlBK2xoWk9vY0hBaDVtSXdmS1BkWkdyVXFT?=
 =?utf-8?B?eDdQRUZoT0V4YWF2V1ZnR01VSnBHVDMvWnlzY0JRbDVYZzIyVWRVT0hiZTlV?=
 =?utf-8?B?Y2NxbU1EMDlVTHVjRG5UQXZtZEo2eXc3Yk9NNHl4OEV5cjZFNEErSCtaQjR4?=
 =?utf-8?B?ZjFQY2RUWE5NOU1tUGxjaW1DazdRbk13WXB6blBjbVJYbm9aWjVBd1dyQytv?=
 =?utf-8?B?MlV6ZTNzQmVUMDJZenVpR00rVFdOT0EvRDRlRjZQV01ZdnNKZ3VwR0xENnlx?=
 =?utf-8?B?YjhiWHQyb1ozUk5FeVlOSmQxUjhJZFk2TVIveVpFeUx3ZVppajdXMnhTOG5k?=
 =?utf-8?B?TDF2c05iV2Z5aktrd3N6Z0xrbW9rRXozM0tPamZYUVg3dXBUeHppWVJpbmlP?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6490200-b454-407e-db3b-08dd5297fefb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:51:33.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0iDdzo+XWOwZXKIh9IrCx+QYCxqexq9AkCmkwrsWPHhojBPpy6SQDEtixN4idxyBHcrwaTh+Y0T4TfhptiW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5748

On 20.02.25 13:23, Brendan Jackman wrote:
> We currently have $lx_per_cpu() which works fine for stuff that kernel
> code would access via per_cpu(). But this doesn't work for stuff that
> kernel code accesses via per_cpu_ptr():
> 
> (gdb) p $lx_per_cpu(node_data[1].node_zones[2]->per_cpu_pageset)
> Cannot access memory at address 0xffff11105fbd6c28
> 
> This is because we take the address of the pointer and use that as the
> offset, instead of using the stored value.
> 
> Add a GDB version that mirrors the kernel API, which uses the pointer
> value.
> 
> To be consistent with per_cpu_ptr(), we need to return the pointer value
> instead of dereferencing it for the user. Therefore, move the existing
> dereference out of the per_cpu() Python helper and do that only in the
> $lx_per_cpu() implementation.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Since I think this is an uncontroversial patch I'm sending v2
> immediately instead of waiting for more review comments. If that's
> annoying, let me know and I'll wait a few days next time :)
> 
> Changes in v2:
> - Formatting fixup (was missing a blank line)
> - Link to v1: https://lore.kernel.org/r/20250219-lx-per-cpu-ptr-v1-1-b4492fc471e7@google.com
> ---
>  scripts/gdb/linux/cpus.py | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 13eb8b3901b8fc5e2500138c7d204ac5f7c9858c..1a50a4195def6a82f1391f5e162a5d063e794db8 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -46,7 +46,7 @@ def per_cpu(var_ptr, cpu):
>              # !CONFIG_SMP case
>              offset = 0
>      pointer = var_ptr.cast(utils.get_long_type()) + offset
> -    return pointer.cast(var_ptr.type).dereference()
> +    return pointer.cast(var_ptr.type)
>  
>  
>  cpu_mask = {}
> @@ -149,11 +149,29 @@ Note that VAR has to be quoted as string."""
>          super(PerCpu, self).__init__("lx_per_cpu")
>  
>      def invoke(self, var, cpu=-1):
> -        return per_cpu(var.address, cpu)
> +        return per_cpu(var.address, cpu).dereference()
>  
>  
>  PerCpu()
>  
> +
> +class PerCpuPtr(gdb.Function):
> +    """Return per-cpu pointer.
> +
> +$lx_per_cpu_ptr("VAR"[, CPU]): Return the per-cpu pointer called VAR for the
> +given CPU number. If CPU is omitted, the CPU of the current context is used.
> +Note that VAR has to be quoted as string."""
> +
> +    def __init__(self):
> +        super(PerCpuPtr, self).__init__("lx_per_cpu_ptr")
> +
> +    def invoke(self, var, cpu=-1):
> +        return per_cpu(var, cpu)
> +
> +
> +PerCpuPtr()
> +
> +
>  def get_current_task(cpu):
>      task_ptr_type = task_type.get_type().pointer()
>  
> 
> ---
> base-commit: f527c5c2abb60ddfd6b929d479b985071500419d
> change-id: 20250219-lx-per-cpu-ptr-c9dfd3098721
> 
> Best regards,

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

