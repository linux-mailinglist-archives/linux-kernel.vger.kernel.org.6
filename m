Return-Path: <linux-kernel+bounces-243826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2B929B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B041F214E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1456A7494;
	Mon,  8 Jul 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZQ83d6JD"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AD3D76
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410027; cv=fail; b=RQ641R57EQl3cumCuZdBuXoATaKdDM3uOQTxa0hwemwOzB1ih9SPzKABWEmT092+f/KCqnIGc/V50ncWSCCrMDG9whgmTcGfSxM8OUmH54pSpTF3Ln1UbALVpgW/iFN4nCpvU7Ls16kuI5j5XQiwpmNiN8kfjQt+kGE0RtqegR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410027; c=relaxed/simple;
	bh=7Hpep9JSmcjNGF8CgHTsgPSkDmrYcr9DPk3ibt7pskY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3Mp7iSr9zlfs3ZiJaPm1Bx5e/z3Ot5McQRLY6QKPSJj4LExeT0KbtwMcEofxYn41nNf15IbTqu5WIweKghpWZ5l/SMebB0clMS0KKxLb+apuUDVJ1XQBfjC2vDYASjYItxbIrv8FpGhVAw1dHHx8fmq5AzMyE4Srv70arlsEEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZQ83d6JD; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loQLmRbkdkNFD6/+VyPXUU2VJmOllr0LQudhEH1yzJa+Bek6N3RLkSlnt0HxPgMwnYazbEyV4E+BNFv3mCpPtb1HxmKEkSmhi1fM69adQzoglydfzt2iplCqrDmie1LrpbE/QCYcSfSyXa0FISQjYCajYlYElbasO+fYOypkQLfNmCECj/7jctuO7xPPlmWzURcyEddldvd3DUhC2A/xFMiezAxe5yWzq1H1yZk7kbB+Cgbxo5rSzoIk5QaTE36/hCW+FWwvH9tXN2SxMMyCS9wE4PEmSUwzJIB2mSvw2/RNH45U2UP6rxBvwshTzDByt+tsCEJE0h13jBnrt+SG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ScI8Z7MgiWbzLIQmdfTQ6j5gVe92OL0WA1tbC0JVDI=;
 b=nIzGMiUg2EMoxIZ58N2l7GUsT3PlHvqLXwe7jG6xrCpS602wQGtbNXZsFV0aeWd05hmkFZMFtjV1pDSq92qFNGnDSjlM1up+uKghbM5xzecUY1qOTjLa1mRIfBww1n1KOyqaXVc/dJudw31CIrg10/ohy3U3e8+7FpPGtiN3mevogCqreTuR/g71rDcubUOJSJZkyz2lCk0KuCSqp/EvpWV6OUHc/V2ef67Hs3pxn996iNkf6t0obKzd/34C1znK++LYpzo9v5LMDKlMR591XgTzsqTkNQ3cyO2iKqvsPhpDymUWyPqu+6b1Idf5by2vdRM/Te9HI1LGvvr6/E1cAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ScI8Z7MgiWbzLIQmdfTQ6j5gVe92OL0WA1tbC0JVDI=;
 b=ZQ83d6JDaxfyTP9mqrEYj+vGuRTyT88DDss7CnhtVSw5nPklDLDAeCvqSxIOsXoWha6WPAhWOhpqF62am3GNzO10h1iMH6rxz5eKEwxZgJOOBTB0DhR8GVOdNhs2hsb1g6YMbQZW0z5auVTRHMiL6rCgAFFoKK1kkt/a0Mt80PRLIk3VAPSUHaOombc6TQ+PmMUpXHjW8S8YuToNYwPpNjRaa3ckASWByp2sVwavRyNC6R0BruWCGyp0kPRaMpjtFRksXcldPmCeDSE5JEWCZAEPmcKTC99UvFq/og6rI37lNVvG3l0wEOlCJxes2qZ9HD4a4K5wbUFs1zyRnSw01A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5222.apcprd06.prod.outlook.com (2603:1096:101:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:40:20 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 03:40:20 +0000
Message-ID: <7964fa25-0ba6-43b5-b215-4e381a355a08@vivo.com>
Date: Mon, 8 Jul 2024 11:40:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shrink skip folio mapped by an exiting task
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240221114904.1849-1-justinjiang@vivo.com>
 <CAGsJ_4ytMMbPo4EuNSQ-A75T+5h3O+nM127xcMg+QpKjf5D8Sg@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4ytMMbPo4EuNSQ-A75T+5h3O+nM127xcMg+QpKjf5D8Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0973c09e-64a1-4798-0f47-08dc9effb0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmE1MTdLUXI0YXZPSi8wM3JsSzVYQ0VBVENmSXpqREhrNllFV1Zab1B2R1ov?=
 =?utf-8?B?Y1FQS1pkMDJWWmpJYUoxM0p0Zy9mOVpPZDY5ZStWYTI5OVhNd3h2ZTgzTzdK?=
 =?utf-8?B?dTVkTDVBVE9kRWhWT0FkYi9WSlp2eXNNaW1Oc1N6SjJIWDJ2TjFDZ2ZOUFNQ?=
 =?utf-8?B?M3JEVkZIZXBxanhnOEhCRCtBemlpVnREYmcyVmg3cFIreTVkMlU3dVM5VnVh?=
 =?utf-8?B?ZUFMdis2L2xDenFUK0E1U015TzRGdVU2U2hPcU9tRldRdkZWWUZyQ3p6OFNF?=
 =?utf-8?B?bWtxY3E0aVdORlk1bzBCQm1sbzRRVFI5Umxacm5EeTgvV21abUFyQ2Y2SmJ3?=
 =?utf-8?B?aVoyU3UrTHVBa0trU2R3b3QvU2R5aVp2MmtzMVYyN3YzY2hrVkRsYk5KS1Bp?=
 =?utf-8?B?SlV3Wk9rMTFuRzRPRFpGSVg3c2MwZWhERkZmUlhvbGJiZEgvOVZZRDY5N0FW?=
 =?utf-8?B?RThNZlZDbFVxQ2lNbjVBcHBXV256cGhZZCtGOVNxeU85TGNaRTFGSlZpb3JJ?=
 =?utf-8?B?RUVyZ0lHK1FoY21ISm5RUDlXZkdudHp3N0FSQnVkanZWR3JWekxhVjk1RzlW?=
 =?utf-8?B?NkNaTHlEMytiOHprOEZKcmJMQ0tKSWZNc3ZFd2E3SE83M3N0bXI4VExJNERO?=
 =?utf-8?B?UnlKVTQzbTJWek14bWNZbUtaM2VFbzcvdzEveEJMUjJVYVZwYzVLNmJRbVY0?=
 =?utf-8?B?Y0lNLzhQUmsyaVQ5VGNtbXZmcjI5VGZjbkZnNU8wNy8xMGcwZ2dHWjhWYVRm?=
 =?utf-8?B?U3ppYXBiaGYzTW5UaFY4NGVWaXAwOWJld2Q0T3U5RU5wdlY2NDJuM0RudWEz?=
 =?utf-8?B?TGVlOEV1Z2ppamNmWGM0ckJSUWZ0VmFZbzNSdTBTTFZLR1BNYmw2M2laMmhp?=
 =?utf-8?B?RzlTbjNheUtPVVZaenZWbmpaT1VBWGlpL3NkQkloSHZ0WnZVM0JHV1JkMkM4?=
 =?utf-8?B?NzNqZm9nKzcwUEtqS0UyY2hhNFJyWmlQQlk4T3RHZHRvTDg5ck5vbEoyaVZO?=
 =?utf-8?B?b0FNSjk1WHNLWjc5N25KWlJkVVk3cVdrYlB2cG42a1Y0MTBNNWI5Yk9VN1U5?=
 =?utf-8?B?Y2pPRVNoLzJ6Z0ZEYU4vSjNyNlE2TVpUZWJieUNMYjdUL3RFbDRNem9pdUUv?=
 =?utf-8?B?WjAvMlNxbWR1MnRFL20yTmdSZ0FuMTNidGRzY1FDVnNueTcySnpZSEw3VTd2?=
 =?utf-8?B?ZjZCSEN0T29XYi9yUjNrNWpyeVA2TWl4dGUxU1JvWDdhTVJwVm8zNGVVcU5z?=
 =?utf-8?B?MXh6MHUvMms2aFhHb1dzRkQrQzNWejNiOEpwci9zaDBDbFJ4cVRpdDJTbWQ2?=
 =?utf-8?B?cndmbVRQbjFUWWtYZ3pWUGJMeVR0TmhNY0lySWo5cEd1RFR6aldpNDBEa2xy?=
 =?utf-8?B?SFdKVHZtZWxIYmlNbDBlNDlJK2JoYTE3eFdVMjV2Tzl5RUJpdGJxQWpmMFFx?=
 =?utf-8?B?S1RvbHRtWnJLM21vbnNiRS9rMzlIVEF2alVkZTZiek81VWFsWFJyNVFtMVIv?=
 =?utf-8?B?TmpQaml0aE5lelBXYVNFRkFHdDNUMUllRXA3QWNZQnNncWZObU9BaWZXdG16?=
 =?utf-8?B?SWlNYjV3Q2VWSU4ya3VOTXYraTdPcHVUbkw3K0lVODdudzR2Mmd2c1N0eVkx?=
 =?utf-8?B?NEFmMFFiazlZeWJ6YUdjS2luRkdPYkY2YThhVDRwSmZ3VlJRekg3TDRpOERV?=
 =?utf-8?B?c3hCaUxMZUVnSnR3RmVHc0MxRjJSaHdhMHQ0cU9NaGY2MnI2Q1VnK0hndUtl?=
 =?utf-8?B?b3FIMTd5azVKeTlmTVZWL2R0RmxyamVFWGVsNDg0bGplbm83UEYvQ1RuODFk?=
 =?utf-8?B?UXUzSnMxMDBhV25DcHNVN25qSEhZVnh5Z0VXNkN0bm40SytTcEZycWk1MzV0?=
 =?utf-8?Q?hdB9FzYqQiEpq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnpPUXdnYy9QRVNFbXZLNVR1Y0JmNm9iWDJidzFWZGJ4d1V0aTFhMmhtV21M?=
 =?utf-8?B?SG1lQkJ0MitPOCtNditXN0hVVm1OMEN6WFdZeDFXRWlzdklXQkMwZDdady9l?=
 =?utf-8?B?OTI5Z09JRWdLQUV1TG5RaUorT1lqSVVQdktOOFRGdDJVVm1oNVN1SHBpWDB2?=
 =?utf-8?B?L3NSSE1kdzFBMnhSNFIxVmNyRGRvYWd5Y3RiQWViY2paT0Qra3daM0NtK1pN?=
 =?utf-8?B?dDhobUcyRk1YeVNJdmZ6bitERWRDRU5yWDh0YUxaUndiNGlUZ1ZTMGpUbFcx?=
 =?utf-8?B?UkY1NGxpQUZiVlNtaHIreklndkdMd0htL09OUmFvOHVHTTlHeSthb0JHUk55?=
 =?utf-8?B?RmxNcDdqY0llN3JkenNQendJeWFmNnZuVUVzTFYwTE1hdVNrb2R5dHV2NThD?=
 =?utf-8?B?RHN1SHlUNHJHV3lYNFJab3ZYWnRTZHdhK3dIVXpjVXlVMkVlVG9MZmNPOEJO?=
 =?utf-8?B?SjhNcXRYWXFKS1RiQ0hYVjNoTlJ4bXlSQW9mN2NIU3lSdnQ4cFpNOENhVUJn?=
 =?utf-8?B?NkJJelowWHloK3JkZm9wQ2Zhalhrb1MwQUYwMTVSbjN5VzlQNGRpeG93WEcx?=
 =?utf-8?B?WXk0cnpxTVRkVC9sSzhlR0Q3NkNOcHkwRjFRUHcvbmxIWFpua0s4V2RIKytk?=
 =?utf-8?B?YWF6QTU0Uk1jNWJ4RFFRYWFCcFE4aHlVeVd4Z1lRd0QxbXNFOXZsQU82dXVG?=
 =?utf-8?B?VkpvVWdoVGlkUTlabjgzVDhQTUNIejJzdDkrYkIxK1pPZnFMM3VKZWxCUGE5?=
 =?utf-8?B?NkJweVg1QkpZUkFJM2NzaHpNOStzRmR4Z2loRDlaRE1wNWhPWHlSaWlWajU2?=
 =?utf-8?B?YnpySW5wdS82SXk2SnBGd0Q2LzVKV3pPNkYwUUJkVHpIZlJONnYzSkdGRUND?=
 =?utf-8?B?OGFuYlplUnZsakVDNWs1T3h4U0pzTnFLRXlHOHpqcmJhUkJSMHdVTUdiWnR6?=
 =?utf-8?B?NDFYd2VmYTZocVVRMTFEeGN4d0JaMjRqckgydUxHalptVy9FK0hsbWZhcVRP?=
 =?utf-8?B?OVNCRDIzeVNUZEp1YnNrOTRjeGZMMkNycE03RzlTZE1zT3pwSS90RmVOa2lB?=
 =?utf-8?B?UXJ6Q3dlVEFQQXMzNFlZelFkdTZCQm4yM2IrNkk1WlFxTGYrZ3B6c1VkN0dq?=
 =?utf-8?B?VlhBajEwZ2RRTytxQUhEOEpJTEo0cncvOURuU25TUjVqejN3cmZqcnY1SHpI?=
 =?utf-8?B?Q0UxY1Y2Z2FyOWd6empEaGFyNWJIVmVXNnprR1AxR0c0blNCZENhOTAxdTBP?=
 =?utf-8?B?Wi94akh4SHJ4c2JOU1ozOWRneFZmeUJNZ0hGT1FZSjZ5NkpoMDRDOWxmRHZq?=
 =?utf-8?B?ZGlpb25zaXlVR094aDVuOXJMeGtPNnkwN3RaRVhvYUthVStqYTRTU09GN1lJ?=
 =?utf-8?B?V1NGaHBTSzlZZ1FxVmljU0FHa1BxNjE1eW9YMWNUaGpzUXRjRWlUOTV0dWlt?=
 =?utf-8?B?a1I0eGQ4SHI2OXRwc2FBYjdlNE51WFNnQnZKeXVYdXljSDg5WmIvMWhnZ1BE?=
 =?utf-8?B?Z2lFSzBKd1M0T25wTnJ1ZThKbVNmREtudmRUZ0Erd2Jzbm1oaHN5MnZzaVFS?=
 =?utf-8?B?UzQzUXpSejZHdmU5N1JhV0cvMC9mZEgyTVdPcFpHak44amhuTTF5WUJLT29L?=
 =?utf-8?B?VmJvUFFnY0VkOXE4em9DUVl1ZjE3amtiODY2UURTcFRYdDRHWU5uWWJJL0RE?=
 =?utf-8?B?bnVEZkNIekFBWmZBL1BlQTkranVQMm5uOE9GRVU0eEV6ejFHdDFEZGFzYVpO?=
 =?utf-8?B?V2ZJZURKVXhIZ1JZcks3ZldpN2k4OXltWWd5NnJzM2V4ZkQ5WjBNUDY2RXNp?=
 =?utf-8?B?TFZxNkcwYnQzV3hDZkF0cUpxTTBtd2JMbklwWnQ4SzhGZmNzUU1FaFhjM2k4?=
 =?utf-8?B?c2Y4dSt3T25ZUDJ4QWd3bjI5bUNaYkJtNExiSWpUelhhU2NqdjRjbmZvMTh5?=
 =?utf-8?B?YnV0VzJxSUYreVlCOHV3UU5mTnA3eGl3SXpZZXNUUGk5WmpMa0hIMTJxQkNn?=
 =?utf-8?B?SERWSUUvNVZHaEsyTWs1SWNleS9YZ0hEbmtHak1UcklkS05LRVdpU0lzYm1R?=
 =?utf-8?B?L3ZISEZtQXVZOG1yeVNSM3R3aVNGMXpHelFYYWk5TXZjNWtHNk4wN3cwRWxm?=
 =?utf-8?Q?RbBsxwsBPoVT2Ph8ww40PKaQM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0973c09e-64a1-4798-0f47-08dc9effb0f6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 03:40:20.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2j7203tmz+F7kqdAvS6Y3+CTvpL/10Uyn7IG2MmmeAUPdgt7i6CZgd/nauVaqte5E/03YshChGz/qkW5TB5ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5222



在 2024/6/30 17:35, Barry Song 写道:
> [Some people who received this message don't often get email from baohua@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu, Feb 22, 2024 at 12:49 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
> This is clearly version 3, as you previously sent version 2, correct?
Hi Barry,

Yes, patchs are as follows:
v3:
https://lore.kernel.org/linux-mm/20240221114904.1849-1-justinjiang@vivo.com/
v2:
https://lore.kernel.org/linux-mm/20240202012251.1aa5afbfdf2f8b3a862bced3@linux-foundation.org/
v1:
https://lore.kernel.org/linux-mm/20240124124308.461-1-justinjiang@vivo.com/
>
>> If an anon folio reclaimed by shrink_inactive_list is mapped by an
>> exiting task, this anon folio will be firstly swaped-out into
>> swapspace in shrink flow and then this swap folio is freed in task
>> exit flow. But if this folio mapped by an exiting task can skip
>> shrink and be freed directly in task exiting flow, which will save
>> swap-out time and alleviate the load of the tasks exiting process.
>> The file folio is also similar.
>>
> Could you please describe the specific impact on users, including user
> experience and power consumption? How serious is this problem?
1.At present, I do not have a suitable method to accurately measure the
optimization benefit datas of this modifications, but I believe it 
theoretically
has some benefits.
2.Launching large memory app (for example, starting the camera) in multiple
backend scenes may result in the high cpu load of exiting processes.
>
>> And when system is low memory, it more likely to occur, because more
>> backend applidatuions will be killed.
> Applications?
Yes.
>
>> This patch can alleviate the load of the tasks exiting process.
> I'm not completely convinced this patch is correct, but it appears to be
> heading in the right direction. Therefore, I expect to see new versions
> rather than it being dead.
>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>   mm/rmap.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>   mode change 100644 => 100755 mm/rmap.c
> You changed the file mode to 755, which is incorrect.
>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 3746a5531018..146e5f4ec069
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *folio,
>>          int referenced = 0;
>>          unsigned long start = address, ptes = 0;
>>
>> +       /* Skip this folio if it's mapped by an exiting task */
>> +       if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
>> +               unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
>> +               pra->referenced = -1;
> Why use -1? Is this meant to simulate lock contention to keep the folio without
> activating it?
>
>          /* rmap lock contention: rotate */
>          if (referenced_ptes == -1)
>                  return FOLIOREF_KEEP;
>
> Please do have some comments to explain why.
>
> I'm not convinced this change is appropriate for shared folios. It seems
> more suitable for exclusive folios used solely by the exiting process.
1.The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
the folios will be freed soon in the exiting process flow.
2.Yes, the shared folios can not be simply skipped. I have made relevant
modifications in patch v4 and please help to further review.
https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/

Thanks
Zhiguo
>
>
>> +               return false;
>> +       }
>> +
>>          while (page_vma_mapped_walk(&pvmw)) {
>>                  address = pvmw.address;
>>
>> --
>> 2.39.0
>>
> Thanks
> Barry


