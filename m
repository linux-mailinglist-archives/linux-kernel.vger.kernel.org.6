Return-Path: <linux-kernel+bounces-177542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621F8C407E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C732728469F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71614F11D;
	Mon, 13 May 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Wf1eFSjt"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E114AD02;
	Mon, 13 May 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602435; cv=fail; b=IkUjUWOfoJT+YDhdfCVCHgaNEAt7E1DdowfRabsAU04H6tQ/GxfS7P/WG4aBMrqCfp6IBDQTD+VT7o8KHY+qj6IV4ffTPkslA9Uzuwo5KnAAyZTEAdI2YANEmuBNSXYp1cmfrQsNB+27kSNQMQN3QXF5ePvK26FqaqssQHkRjYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602435; c=relaxed/simple;
	bh=25CNK9ozuwLnn9ixmVLEPRQ9prY3nVebV9iMeWWTmqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u0tIlOBSEcNWwrn7igjByev2pgfYnIMnNCQSEfYU81X76+vZIlD6hDzfc/Yi9vY82HSj3an2aig+ZFBczFBudfcBvm9L2pY4uBRAOH6zKoCx3lE6HgJXuLSonr5omCK9HMPM0GVvgo8pJyJKV3638J+rt1B4jwyOZCEY3nJKTGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Wf1eFSjt; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7RzOBr2SSaz46MUWFcDUWTxPWdbs84xgJp/WsR48khbfehSZw3k7Q4Eupv9YMipfJd4sM6MYLI5hE0n/wIk3al/uulk5lcOUIXDwyQvvjmMnV6ShtvglSW/pkCK5FIemM+kQ1qO+AcZWjf7zuEaBfnkR35zQ3fYNjMVctFXVf6PJhbgb+ipESZsAUT8A+Gxpr0MVaqXckLdYkIOO2PXZwIJilIfgGzV5HORrBihVHwMR/0qZ2M1pbcZPJZOIHyb/t4BSF4TrEJ4rqln8Hb0kFRt8bLvx1BQUCjfXWizvgwkbekFeKiMSDmUyDNzDMPnTS+VGzfaviivFZO5jQOZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfwKxDL7jppSiDvnWDWjLj39lVp6UCWmSqklXW8Jtr4=;
 b=H99J5QNrf2rULMomydgQc7eNlpEtpt/0+UBqg0CCCWau1cgyKDSmQFS5zz41K9KYHZP6T5V2uVei7kDAAvtWcBRZgOM406XRwkDqj0/DKdz9Pt/YLFFpxgoJ1AL7M9UgIzEhsI9ajIbLn2vXczB99Rp+dwmglbXpc2MVHhzEs7c7h9Ie5AbsEt5dkEyBg3kPxd+X8IhJzt5s6Vl2DdUaoxdReEPNauHsyanXi9F4iaivRNAr20UhkHn4/nBqz9Jyfj51DZenteQkgrdeX2cxoxAv0/202XCRSAzdwP5MkFjocHCc4AYsCNCId1TTYbktlhP3TEx356rtOxw1vJ0x9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfwKxDL7jppSiDvnWDWjLj39lVp6UCWmSqklXW8Jtr4=;
 b=Wf1eFSjtWi5deUA0v7SHkGOJfNCsk4jmxZ+FnMKgNNdeIB+is15fD2TfcSxhk0EESPfyTstmY+eVGiPagiUdDPPmWzBj3S/9CT9kcRwGINJ+Dk7Dlyk4+MJ/QxbmZq0onlJCTP836uLMR+IsGdYkVQ6J+/FXNLfPRXFgCKAXHT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:13:48 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:13:48 +0000
Message-ID: <557d219a-dc00-4595-a3ff-a464908d5e03@prevas.dk>
Date: Mon, 13 May 2024 14:13:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco
 frequency
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1a9ec9-98ee-49c8-c538-08dc734624a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVBieFFLb3hUMkdRQWF4b281dlNERG1COWFGdjd0Y1ZxdXNKdVNHeDhqZWpi?=
 =?utf-8?B?bldIYW5kYnR2TmFWZ2l3MjRMS2txRDNnQk9tMG50MW10Rm9neDUvZzJYSlAr?=
 =?utf-8?B?YlhHLzcwcWNWajMrOGRPYjVYR09JWitSUTRvWjFRV01hdXNuVFZjUlFxNzd5?=
 =?utf-8?B?blUrTnNKbENCUVp0MExhVVJQTlY1ZUVZYS9SeTNnTVdVVnlxQUZtcVFlYm1L?=
 =?utf-8?B?ZmlQVS9rMC9XOGFQZmJ0UmRvZEVIRlBHdU1SKzlOcGkxWTZlUzBRSGtJUWNJ?=
 =?utf-8?B?VVJ6dVl6T0V3MlpiY0RUU0tPMGMyN0JzM21ab1RYZjRFMDZzbk14SHJGd0Zo?=
 =?utf-8?B?N2JvaHFRY2V4c3ZvcEtZcDJzYjZtSEkwWGpBMTNLUjZ6aWFtRWphY3VxUVVP?=
 =?utf-8?B?NmRKTVQ0bk9KdUZ5YXh2TkJEMElaSEFVTHBZYWxvdXRWTkFyTzhiWGxCVnR1?=
 =?utf-8?B?bUpIaGJaREVzM214VFFDMUlKOEpMQ0NoODVKdlNiMW1Lam8vWXBsVm8rRU1r?=
 =?utf-8?B?dVNoK291RzVlZTRhRUp2RTVMYktRS1RoVUVyVU56Si85bHRxS20vamx2QXBS?=
 =?utf-8?B?Tkkra2czbUhtbkhyemc4b0srdDBDY0RXa09NekFBTVlxNTlsMnNVVEZ4ZVFa?=
 =?utf-8?B?K3pFeTRTVkluNzBGejlzYno5ZUU5bEhVSUtBMW90KzRjSjVBMzJNQnRxSGJz?=
 =?utf-8?B?SUttSmNFdjJlYUdzUzg4cCtzWUlzMFN0d1JrSkx1cjJ6U2JSdy9KOEl0Z3Jk?=
 =?utf-8?B?aE1LMGNnQ1VLaUh5d0diOUU0OTEzcGZ6RDRWTjFVdWd0MzRqQy9Zc0ROdUo2?=
 =?utf-8?B?WXB2Q0ZVYm5mNE1SbGNqeklLbW5iRlJtQWVYcVdyVzNKaThxN2lnRHlWaVQx?=
 =?utf-8?B?YUR4NUhYZDhaeHVlZjM5SnFNNkJxZi9CR21YQ0srUHkwMWkxMklCYThPMUUr?=
 =?utf-8?B?cDA3U21hejVDNTVYSTlIb0MveXRIU1JMMGlwMTJqOW9sZFl5UlJHekNYUTV5?=
 =?utf-8?B?dDN4eXdnQlRYZmVZR2o0T2RqcjdkZnZnUW1CUWM1NWFtZ2xzY1dCbEJJZUk0?=
 =?utf-8?B?VC9vT3hPTHVNdnVTellxbW8yb29CZXZ5TkFxd1NDMGVZVnNnSmtDZ254TkxH?=
 =?utf-8?B?WnZqK2FTVWxCWU14MXdoeGZLRlhSRjZNQlB5SWY2aFllVEsyZlpmbzl4bXpq?=
 =?utf-8?B?SjcwbWFQRWJsckFCMWUxamxPUTNXNTlPWmRCZjgrV2Vtb2lFcVFQTU5FK1dS?=
 =?utf-8?B?cGhEYWdIQmFhdXVJTWhXemE5Mzl1eG9UT1BzRnNBajBFT0JRMEZ5NzRMZUZj?=
 =?utf-8?B?aGVxN0Z4TjBocnF5Qm5xbE8wUlpUVDRlNXB2a0d6L1ZFQ2t5eFF1dGJydkhl?=
 =?utf-8?B?TWk0MmpCTHdZWmNKanUvcTZsaER5NExqWlVSc09qdFRZSkUvSmtSRHVMelRG?=
 =?utf-8?B?TURBZGFKWDIrZzhKakhMbHlyMHZGTkxnOTdHM0t3UlFzY0Rmd2FkeHR1eURI?=
 =?utf-8?B?R0xGVzJ0TkJPZUM3WExtWGpEdFNEUHJDRkJrLy9xMmFHZGdVWjhDSmc3aE41?=
 =?utf-8?B?eThraUJ0R2U1RFF4cVVXTjVBUlVwWmsrcU9uYVFmdkRFZjFyNThTZUNhbmd2?=
 =?utf-8?B?TzNaVXBrM3FyV2dsS0hEYTREWFN2eDc5V28vZGhweDhQOFBOOEw0UVRJVFpl?=
 =?utf-8?B?ejlGVk1PMzJDY3hOVWhDS2YyMzhFUHBNQWs0dGdYL0pORmwwZzU5NEhuQnNP?=
 =?utf-8?Q?vJRtU3TgfWqRmyqOi1O8NwVDRI2Wc3kUzaUIiUT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmcwSjllbE5NaFovNnEybi84QjMyMzZ4ZVd4a3JJNnhTbWdrUi9NNXY1N2xR?=
 =?utf-8?B?UzRwa0piSjY1WUxkQjNYZEI2TzNKT2xLazBrTDI5bmR1QjNuK1FZTjRjTUhs?=
 =?utf-8?B?dTdkS3UrVlFuTEsxWm9Dc0owWGxibjY3VjFSUHRDZjZ0QUE4cnV5Y0ZyRFBN?=
 =?utf-8?B?VTVoekwxYUQzQ1FsRUFkSmVJcW5RaEpKWTBxM0NzNE9tN2dSNS9yME9KQTV6?=
 =?utf-8?B?WGpzdEg3WjlGb1hCRnZDeVV1VWdKS0t0R1hnSGQ4eXY4cVlFNXhHeG9HMTZF?=
 =?utf-8?B?UTZMYmNyNkhwU25ldXJES2tRekRMM25pWm5kbzBqbTNZSFlWQWlreHp4NnN2?=
 =?utf-8?B?eG5ONUcvbEtaRDJsc2FVTHFiU2RXN2FBSjJsbjN3Rk1hTlF2dmUzc05rRExq?=
 =?utf-8?B?dkhqak1obWFjbkNyUEhrM1B1ZWdUdVg3QXhJRUZVT01QS2ZKa1NjSzhnT21k?=
 =?utf-8?B?K2NkcjBCdWpsWEN5clR3UlgzVE5DbXVJemhJazN4UEdRL1YrbnBmRDFiZmRm?=
 =?utf-8?B?OUZpSHIrVEhmbFNKYnUvRXhMMmhBWFp1RnlzUjlqUkQ4Z1RHYnFyQUttUlMr?=
 =?utf-8?B?b0Y1ZkFrUWlGVnk4TStOaWxVd1k4MmVvcXlIclQrSmhwak5BUDRXWWp6blBh?=
 =?utf-8?B?aVBKTXB0Um0xa3lmKzI0Q1VHeWJRc0N3dTJwOHp1RXFqMVczdStvNlgxeGxO?=
 =?utf-8?B?ODYzQjBKQ3B2Qy8raTdGMjRhSkFnZlFrOUFIYmk4cXVuKzFiQVNDcFJYQUZW?=
 =?utf-8?B?djFSOVNzNkxCd0djSUVyc2pYdlBOK0o2WjlxaE01TEVxRmdyTnEvN0JJRUJU?=
 =?utf-8?B?b1Q2QzR5V0lsRGpmTS8yazJ0d1BJVXBTUENMRTU5SmlrK2FtalZTRHJ4SUg4?=
 =?utf-8?B?T2pMNUtvWkVUblNjWTJyUnJ2SDhCcVdlTVAzeEYwWXU5c1M3V0tZNTl6MXVi?=
 =?utf-8?B?cE0rOGtSTlgxNGZkR1NvWHVjVjhxQU1CelJqdVYrQnFwVk5KWTNFZkFDaEZJ?=
 =?utf-8?B?eUgvMnVRd1kyQjZNOXA2ZlIxOVpvTE9mK3lySHp2c0NSM1RuSERSaVBHd0h5?=
 =?utf-8?B?VTB3amp0cE4xbEt3dEVZc0xzaFoxRCtqM3BGWlBCYWRvblNvUGhVa0p5clpp?=
 =?utf-8?B?K3hEZEJXN1RvY1RQV29xRStKWCttei9XSFBLcmhvZHdSOXNmRFAvcmxQMUdP?=
 =?utf-8?B?cDVSTkZ1S2xvdXpSK2pIbGM5c1dMNC95Mk9UVHFsTmVna0ZPODgxKzl3MWpC?=
 =?utf-8?B?bWphL0prNlJwQ2JFYWF2NG15amdnOWl0b1hUQXZ3aE5zYzFMcWNwRGN6VWhY?=
 =?utf-8?B?OFQzYVNBNUtqS2hhbGFMTFp1ZnVtVFZFbXVWL3N4eDI2UDYwSE52aDhJejEx?=
 =?utf-8?B?NmNvaE5IbkdVWFRZT3hXTU9RSlBBc3AwZ3BmV2FwSEJnL0F4dUFTS0E1N0VL?=
 =?utf-8?B?UDloMzZSbS9ac1hOQjMzaW0xTFZBN1RITHBVUW8wOFYwVzBQNi9mR1l3cFBD?=
 =?utf-8?B?ckRGOTFlYmpYTEpBQWo0UjhvWGhmQktvTWpLQkUwa2Y1Tk5jQU8zZ0Z2b2Fz?=
 =?utf-8?B?dUJWRmh0TURGc3J2SFdxb1JCUFpYamxNQXlPL01hS0tLUnNqSUpoWXJWdDRz?=
 =?utf-8?B?U1g3TFV4ZFlMWE5BZ2RvTFBtcGsyTkUrQnBBdFcyVkNRUUZwZ09RQ1ljYWFl?=
 =?utf-8?B?MjY0dmJpRmxRYXplaHhtbVJpVzFuZmQ0UEZrUFRBMTlrK2JQbWZwWTNxdU1h?=
 =?utf-8?B?TExMMXEvNExZNmlOY1pCSllxZmtsSS9vSXdsSWl0RDFaL3hXNk4zOSttR1I2?=
 =?utf-8?B?OE9XRjJpWllsUW5BR0d1R05Dcmh3MUJRSG56cXQwZkZFTUxwbzloZTNIeFg1?=
 =?utf-8?B?L3lWdFIyOE5tMnREL055ZnVuaHU5OUhFd0V5RzROTXVtTTJFMjB2ZVNtdzNV?=
 =?utf-8?B?blVSVU01UG45WWZQeHN5RTlWKy9PYW5zL2dENCs1UzFOS3ZWZUFzeU85d3g2?=
 =?utf-8?B?YTFqdlgrZ25FSXZIMmtLOHU4SXlYbFVEckNWSW9FRXV2VlErck95M3FiK2JL?=
 =?utf-8?B?UGVxa2VyNzVha25xa2FHbnI0WXlFbkl4T3NGM3lremJ2ZzE3Z1o3NkJmTnZH?=
 =?utf-8?B?VGd2ZnRIcHl4R1J4NWxVYldqSHFmTVJaNlYvRFk1R1BqakxpRmhCaG5IM0Z5?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a9ec9-98ee-49c8-c538-08dc734624a6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 12:13:48.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InY616YlwNtrZmCvUEY247KNVIszwaiuFk22hoj0+mKlsm8ztOoIg+bXT9yNcASxW9oxJU6bJAIwH2+OJNNVb7v5b/U91LNM25fkQ2qSIUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7344

On 10/05/2024 11.19, Peng Fan (OSS) wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The fvco frequency range is between 1600MHz and 3200MHz, without
> this constraint the fvco may out of range, the real output
> frequency is no accurate.

Could you please point everybody in the direction of where that
requirement is stated? The imx8mp reference manual, for example, merely
lists constraints for p, m, s and k.


>  
>  	/* First try if we can get the desired rate from one of the static entries */
> @@ -193,6 +195,10 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
>  			kdiv = pll1443x_calc_kdiv(mdiv, pdiv, sdiv, rate, prate);
>  			fout = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
>  
> +			fvco = fout << sdiv;
> +
> +			if (fvco < 1600000000 || fvco > 3200000000)
> +				continue;

If this is really a necessary constraint, it seems that one could just
up-front compute the only possible value of s, or at least change the
logic so that one loops over a smaller range of possible values of s.

Rasmus


