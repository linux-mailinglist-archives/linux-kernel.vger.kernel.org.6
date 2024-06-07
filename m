Return-Path: <linux-kernel+bounces-206667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3285D900C7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66FD285876
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F99A14D2A6;
	Fri,  7 Jun 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="c0EKNs06"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248C14B958
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788790; cv=fail; b=L8o/4zq+tCY/W7ey8z0Xi3WApC1MLYk1+kcNmBKeWDPkEBvav07GB+Bhc/pPzENNJeOZ2b7fgT5vFt6nDZj435lBbrSQq64nBzWMaCDYFEtdSnOt7nr7OaS6rvyAXhl8khfu3vO5YErrL9X8ZaIPiID2TZXNESgSWeXEWFN36iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788790; c=relaxed/simple;
	bh=P299zoer4QZk9Oy7dKbzcW0x1MSQBBC6znsso2D6PAI=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=uPbod+7ZRQZm8g0ujdjai+GsnabGwkvJoxaAPjUP62Tfp25lc71AuwPRNASKo6BisXHBfZrD1APaoNHQkmyjy2U8wwkd/GQobqc2KlnVLZJt48wYGuGgf1eHS5wmil2TsR6yxItMNLvouCg83MAybZi2Yb3/ItufI6iW8rkKNKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=c0EKNs06; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO9N9OrCHdzDV0sZIt/lmtZr8ZonfymmYr4OL5x4QDp9A9N7Qwr0q78qO091o28qahMr7lS/qP8LRYYPcblX8E4ILrKwmhhqqN0a9Jy7pn5iAy+NP+3FzW51XwLXVBprTTQPrqFUIx7pqFWzilSR9kh9CRRAQ1pRLoog+sS33mWooromIN3hc5znhPKgqY2Fyi+tX9GsNr1VNmvce2lYyXj+MNU785ywYi3RQ5fTKD3dKfhZv+eyffdWK6WHrFLll9fGi7JPbMqvzbV9B/ELyQBnQDmdJlwK9Fdc9WPXzyDoI8BXIkCp/r8+ub/vqEvqLkNVXYbXuTAwgA5YxF6q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XyEo+S9cYAhAQB0N2LBcpM3WObX7aMvwz4nEw5h38Y=;
 b=ARnmlLIZRGGP6QwIIBWRA3cqmPyw6IhqwuovAlmr6G6KA1N8Jgyv/MLRc1+H4RiUIiiB0aRgXcuwm2qYDoohq5WPQz6MDmSm2q957rpv+P23nxusPSP4B1iDKI5YXfj1xkcFLWnizgzr6UH+7nlVRWTyProDR3506HG5mUG17GIkw+W2dZ2C7NLjrMoKBA6n7nxZh/3grGpT4krbWU1hgzOm2hnLFc2c7WbqRGh5uwJzLPU8xLYuW359EK91BURmeg2Ih2pP8aNVpuQxnlkPOiEeB7JUogK1I+h2DqU3AK0lxJO3Yd532YD1MqMOEalnV+J0itYxEc82bpDYaDFAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XyEo+S9cYAhAQB0N2LBcpM3WObX7aMvwz4nEw5h38Y=;
 b=c0EKNs06HhUVPdEfZbaULFGw6v1R/tr7ENYVTJgsZFQe7NXI2zDW6sNNGiMeSylWC8RtWD1de7r0lQ8pMa1wBj3vrByT7IC/vo8wDb13xMcny57Y8cDV+sytqYKj0R/cWOLunSLrZSUbOP67jEZtMEz65CEap8J/Zg9D9axnbKEy8Dsjs8bJxNAJdDDVz3E9rNcXaNZB/qOK/XI1FcZjGImQPc2zCPlgMs7Efydhod1IjCkvjvdHJl+wF93qbBdV2i4Ckzl7bLiOKI0S51tAI5XinfE3JMAeOZKwdkU5qwRXwVIcL38YrY/ibVpRjrAmqRq8pOfmDLK5Sr2NouCVWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 19:33:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 19:33:02 +0000
Message-ID: <60089a71-dad2-4a87-a304-a738e3334d4a@siemens.com>
Date: Fri, 7 Jun 2024 21:33:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] phy: ti: am654-serdes: Remove duplicate define
Content-Language: en-US
To: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dc781d-7d19-4e7d-ecdf-08dc8728a565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajJtQWhHaUZzRmtPUnBwL2ZGOFlMa0ZvUnl3OUsyZG5uUE1SSGpCOGpGaDVi?=
 =?utf-8?B?N0sra3hVbjFiSThsRkxmYklPUFVneVg5NXdGdVNtR2pHc0dkdHZSMGhIeFdC?=
 =?utf-8?B?UXRVYjhwS2tNTmFCSDcyTkVyNEY2MlJmc1g2bUVraVVnU2ZHS1hORVZYM2JP?=
 =?utf-8?B?OG5veDQxUFE3Ny9RTWVRZWxvdFNNbjcxaFZ6R2U4dlBVUVZMQkZyMENUSTRu?=
 =?utf-8?B?UGp6dE9waE5PU08yemFLc2sxTVFkNkJ1Wm9RWHYrWm1EcHU1YjVUd2RHMTRO?=
 =?utf-8?B?NXp0M3NlME5WQXlmdmtKT3JVUHo1MVlaUkhMSytHVlpxb1pDZlVHTE95RkZE?=
 =?utf-8?B?ZFhzRkc0Z1JLQ1V6aWptT25BYWtKa1F2OGJuL1YzZytQTlhuelhtUWVsYmpo?=
 =?utf-8?B?b3k4djVYTDJVQmxUN1JqWW5tcmM5Z3I3VDBIT3M2a2JJU1k1aERGS1h5UDVz?=
 =?utf-8?B?a2NLZHR2Qy9VNDBGOFBPOTVwcHdMWnZMdWFCRXN6YnRJQm5NQUU0K0Q5aWdz?=
 =?utf-8?B?eE5vZFdaNEJRVGhqd1JCc0xUMXNwejdBL2VQYkhSNWMrNzNTbkRWWlFtNExG?=
 =?utf-8?B?VmtvdVN3bXdNMFNVd0JRcGZaelZGZ3Rsalc5Z01Sc1lWajA5SWY2b2N6U2o1?=
 =?utf-8?B?a05WNWRvcmo5T2pFQTlSeUxPMnc2NUpIV2g4RXZ1SUpGblpEb25KTTVQV3dS?=
 =?utf-8?B?WitmeFhJMmQzb2pjNnk2WHhuL3NhQkJSY1g1bGdmaGF5bUFxd05tdmNWTnJv?=
 =?utf-8?B?RW5OV1cwbUx1eTNkMVkvY3N1Y1VEd0s0ekNsYWNySlJ1dGZYQ0xxdFBOT1hv?=
 =?utf-8?B?VUZQeTNNZ1hwUGtUck5Oc3dVNm9YTHgyZlZBaG43TjdjbFJSUWRYWlZxemxC?=
 =?utf-8?B?ZzliTCtYeVFpMWE3ZDRieGtha1NuTitmZ3V1ZG94ZmZrK1hRVFZqREZCVzdq?=
 =?utf-8?B?cmNoMlRqc1BiMG1WL29ObW1XWnNPRmJreU9BL29zODJiMFdkelJhKzJFTnZi?=
 =?utf-8?B?YkJSWFc4SW52aEpyRjIrb0xpWmJ5aFRYaU5WSjE3aFc0UU10TWg0Uk1tR3d1?=
 =?utf-8?B?blV4NFBaNVZhbnNmR1dPcHdEZlJxdTZlS1o1RWttYk8wZndJUEtnSGIxSWha?=
 =?utf-8?B?NkJPOXVVeWJxaEp5OW5YUHRTS3ZLRHFHOUt5aG4vUHB3dnEzMGxueGdZdVVo?=
 =?utf-8?B?NTNVaktsUEtxOVgzSmN2OGFXN2FxcURKYUtiN0FMM2wvZkhZVkJ5clRmdTM4?=
 =?utf-8?B?RkZVQ29LM1UwR05CdFgvQ1JEUDNRYjBKdUsvQ1BDeVdBT3NuQmFjRVM4VElQ?=
 =?utf-8?B?K2FSRjBUQTYrVHZRWWlsU3VId0luak1xampvNUFqc2JzTzJHVTV0T2NmdVVs?=
 =?utf-8?B?cXN0T2pvRmdrUmVXOFNycEx2NFpKUXd0UjBrMDltMURHSSszZUs1NmVudkcy?=
 =?utf-8?B?eHlxZEJha1ZacnZ3cEZsTUJNeXR6REJRRFZIZHY3T3RCUGEwQThyVWR2TUt0?=
 =?utf-8?B?TXVpdCtGQ1pKdGVMSXVZUHZmcmVDRndBRTBSSUp2bmlhQjB3eEM3QXFSVEtl?=
 =?utf-8?B?K1VrYUNNakgzaWYyN3RzWkVJWjFuM3kxcHRNVnVDMjFDZTAzQnl1VzkzeGFW?=
 =?utf-8?B?YzM5aFAxY09OZGozd2dRdG0zNk9LSEdZMSt1bVgyREhhbDdLWWNrTEN1QUE0?=
 =?utf-8?B?N3lTVFgxZCtCU21oVE5sNk9KMWl4TldaT0NPNkhOVlV6aktjZjhCdnhVcUZm?=
 =?utf-8?Q?/+j4va/ZwUHp9SZiYtTvpf/vLY/zocdAIOFJ3gy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ZDNzRic2I0SWdTR0k5S1g2ZEhBSkN5cWhocFZDTCtBS0RGWEZMaTFmVW05?=
 =?utf-8?B?NXBiRVhqVnMvMjBUN3BhODZLMURZUFE3bXhpdFZ2SllGQUdqK2pESWVBZWNi?=
 =?utf-8?B?YmRoL3lOSkVBMUZmZEVKTTU1U0owS3NseVZTeUtnSURESkFXOUdDYUpmMVNR?=
 =?utf-8?B?OXpYRHNQMmpCOXBjbXFvQlJPSUNWSEUvZUF6b0dPWlQ2U0lLUUhZVm1Id2Z0?=
 =?utf-8?B?dXNkKzFoTlZYd0pQL2YrRHpMaG9YM3B5VUZXVUtrRk1oZkFndzNLYTZsQXpK?=
 =?utf-8?B?QS8rS1UrUnZQb2VCNldsYlRNcG9YYldjKzJmZjFqaDlnVGk4clczQ01WNjhT?=
 =?utf-8?B?Y2ZuZm9NOU5Tb1RnK3IxNmxMcjBxVkFXYkFPemF0STBOR2pxUVhNTU9wcUpO?=
 =?utf-8?B?NU5UNjVFR3Y5aEQwZ2tjaWFXZThNREhXMHpsVnp5a0lTT1hqNUpGcDVNREc5?=
 =?utf-8?B?STFJSWRPdHlDWWZGTUFJWXRMQ2FobkhNeDV0V3dtOG1IM1daZHk0aGlWdCtD?=
 =?utf-8?B?ZXpyRHE2WktqSGN0TjNqdUFvTGF1cFhyOUR5U1Q0Y3RMN0dSVUxSS3prS21I?=
 =?utf-8?B?dXdGNDFvTm9DUnUwK1R3V0FVc1o1S0NqZFY0Y05ueGRuNlBEWWdQdnhqOTd6?=
 =?utf-8?B?VmRlMHpSNXVWMjhwMC8zZTdZa1ViMlhlNmpOVnFKQmdlREo0U2FRT0NHV1FL?=
 =?utf-8?B?U3JIY0pNYU14RmdodWxlVng0NGc0a0pRaXFiVmI3VTRXdnVBTWppQ3hnL1Fm?=
 =?utf-8?B?YndUU1E0NDFiaCs0OGZUMFBPQm53aitaZy9OL1pzUlpYb2FmVGJudklmdUp1?=
 =?utf-8?B?TkxqbEZEd2J4OHdUaHEvWUxXcHozeWlPQWlLQ1VXV25aeklSZlBuVjN2dmtT?=
 =?utf-8?B?WExmZ2VoUHh5djBmOXJXdGU2M2ZLK0hlMm12NHdzSnM5T01DN0NyeCtuNjJT?=
 =?utf-8?B?TlYyRzB3WldOUkx2YXhHTkNXMStXS0h6UlQwTnBHa1gzaHNqSzdtWW11SXFQ?=
 =?utf-8?B?MEZlR0krOTNwZHJhQ0FQK3VmVEdWYmgvbVBuSHhlc3hoWHVDTThWdGFvR1RI?=
 =?utf-8?B?TW0wWmxSOUJUVUJ6aEVwUHRXa25laC92Nm1vTWVZdVBCdTc5bVhPdFJMdGt2?=
 =?utf-8?B?SkswYW5FWTJmb1VqVEtOWWNZUjR0c3RCZ3EvKy85aXdRSFRoS0cyUjdjQnh0?=
 =?utf-8?B?WENpVklzajZKWVFjNGliRXFwYWI0TGhCUnFBeEFVK2t4NjArMHpRd2J3Y00r?=
 =?utf-8?B?ODRNMUZBVGVrZFJaMTA3OEliQlZuVXNrTEdFanBYTVVtZzJXT2dWaHJ3dnpV?=
 =?utf-8?B?VWppVHNYVDYyMTVqUWRDU3krRlRlR0xzYzR2b1pYMDV2TzVDSGdhcnZxNDBQ?=
 =?utf-8?B?MGt3cHQ0UTQzdzNTaHc4dVJHc1J3b0hhQ1N3ZnpVZFlRY202VlNDay9ZTlM1?=
 =?utf-8?B?cXhJMURhWTduWGJjUzJ6cmk0TldRWndvN2NGWU9UN1k4VjVlUkhOaUM5N1dp?=
 =?utf-8?B?ZzloMFpVa01lSEhlR25YMnh6RHZnV1JxNThuRHFFWnh3eXdlMXZHNFMyZmJP?=
 =?utf-8?B?QXo4VUNPa2xKcXV0MzFWR25SUDZKNC9lOXZZOVVCcDZFOXdlcVUwOWhNbHl3?=
 =?utf-8?B?bURnMWN3L3d4ck9KOEdaQ1pFanQwbWpVMXdjdkY3N3BFbFBwVkJKWHVvRm5V?=
 =?utf-8?B?azZadGw4ajVYVVZFMi9ONDNKTlJBYmMrVW9jbk52VFlaNnByM0FpVnhMZ25o?=
 =?utf-8?B?d1NzUWY5bE5mYWw3TERMVzkxOUR4QTh5MG84OEd6NDZWTGtRa05EZ1A5L0hY?=
 =?utf-8?B?TEZtU0RNTkdFNjFrVUNHWTZ3ckJxK0xhS21pZW9UM1VtQTA2T05Mb1ZsVldV?=
 =?utf-8?B?bWZnZXJZRUc0aTUxRTE5Zll2M2tmQTZCRDQvK2FzTWNKZWd3dXZxT1pxTWhr?=
 =?utf-8?B?VWUyZkVHeXhuTitWTE5JVXNrMUZGMGMvMDc4c1dlK1FhcDVHL0JtTEJSMnZV?=
 =?utf-8?B?TE1xV1JwbWpTK2tFNVFpQXJUczdHU1FSajBQZWlwVjVXMVNLaUhYWHBaQ1h0?=
 =?utf-8?B?allDRXV3QmdMOStJdVNiMXRPQ1haeU5VVHNUMko2OEZzNXU1SnJ0dnlVdGdo?=
 =?utf-8?B?S2ROUG5PNTcxV2phUlQ0Q0owRzBzM0dSbFlML2ZicUJiQ29yTzg0NjFiM1ZW?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dc781d-7d19-4e7d-ecdf-08dc8728a565
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 19:33:02.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8iqDAy1kBhDs++nn26+6jvhtdAsP+6+laePncpMVuy+BMZfUluIEzOPwmJ7IH5TiW4KTQf8h1jjSbLIvazmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8226

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 8b3b937de624..673449607c02 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -30,7 +30,6 @@
 #define LANE_R058		0x258
 #define LANE_R06c		0x26c
 #define LANE_R070		0x270
-#define LANE_R070		0x270
 #define LANE_R19C		0x39c
 
 #define COMLANE_R004		0xa04
-- 
2.43.0

