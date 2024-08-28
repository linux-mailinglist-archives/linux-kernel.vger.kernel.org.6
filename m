Return-Path: <linux-kernel+bounces-304412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46C961FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5D61C238E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC5156F20;
	Wed, 28 Aug 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aUgacC8p"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010021.outbound.protection.outlook.com [52.101.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848F14D452
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826394; cv=fail; b=M3LJ4NPIyW1o31u0UhgUQQYMKIA6uULklEVrUS/h64zzvG4ne4SFmRT+tk17xSGin/gc4Qmr0mq8zLUw6gm5ZoYVUkGiwOEqH3S6I1Tx7AnHKHCfQET7tu5PLIX+z0jqgHBQxCgImLFpLWNXYtr5bK8BHDYEmdaW05rmeFOVTsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826394; c=relaxed/simple;
	bh=NpgpwZkyJDm8f/65MVMsSEVr66KP62EQ1lOCz+MC6Lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FLLY7HIXU6VoHltV1+cNBq/74TLi+UGTRGJsjK/YSV3oW2G7OrPVso673/4EfMljm3nVA/6mAwa0+Sq8WKmVv1r7twBNJ/RQB0LYGmnv9IevW3gMoH12faDqkvw/vCCcEBHwEfo+sUYuQ9yyMZ2Mo7FMq0lntOynoFBTZNqBpzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aUgacC8p; arc=fail smtp.client-ip=52.101.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQpZUC2i15pOaieIRo60RwiRjDtm93xo2jrUnDyLQCH0LbFIT30gJU2H+hkUHa5Nlk0LaOk+imbFkqfbRJYNXOcZNffVkS+t5KmTgg8Lu0rXbedj/vMch74Z661k3e1C1ljzZaPmD5tw5Fu4k9uQ1Btrj8l++Fz6+zh3kLPu/nqSH8LlWxj/xtn1bYpbMdUfi1PFkNzoDuNNcH82HHL1PJHhRmBHBKFu3vWOo1qhnfHwCF7YBJvxKgd8xNlX+ANWGRt6TpaFVotA0Yso1ayC6yLu73mOTB94440F6D518g4o+q+UkATLXf3pT7MztNnQkgLlMjNUqGwgYaThlgZbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hsso1qG+BC3FNzKP7EM78GF92dUJGQ84hLVog3OvTY=;
 b=hT3dkG1NLWhEMJL1c/9r9sLXXOkjdZppgmvUAVyFE5eag6c2/6g31DUkmLC152M4xFlTa8fHSE7qwl7sz2UAnuLygeaVizgCB7O3qhAMjX81snC74QVfrylKCquYKrbwsslp+4LoHk86gzp2ge2CFPVgclfFjf52w2ikLZWmGyjp6kynEKAjxO1So9gu/UkEWkTXx65tJhBhqCg4ujNrb9CC8eqwKWo5tUbmFtporNmu9HPaTGEwXnFc/ufZdlKpP1ZYxuC2nljW4aMtUPhsvJNNqyQCG0HYkR+hmPdzY3DQh8f0R87QAYRHukPdA50zBfJYB+NHqzItM8Zl5hS+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hsso1qG+BC3FNzKP7EM78GF92dUJGQ84hLVog3OvTY=;
 b=aUgacC8pkrhMfdCT4/28dWTrLG/iUpzXLsRtRCuGVL3/t5fVbgBtaWFBYTHjuT7F2XzvZ0WkLcbP2yZoVi3Xi3qOoJvuTOVo7/QRp5/j8nfWdb7i0pr7PoObHawj0VTRuweE+mCKqtu7qjhrGtY3fKmsL/iea2L0/BoEPstzeoDnGcJhYvaSBSbB2KmYGyPGxgd/wJBaDQuuSubFTJt8oNrhO3S4lcEqiCNZDUE4/hYTChYp0tOWJWktpLSv+/L4OROgGRhZqltvJ1ACpHfQgRhKP+1nTwiDh9GQWsoWW2bKUXkONDMbZ1I8qX1JjtzdhsOLmNqV0zM7T8ef8wN1BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5645.apcprd06.prod.outlook.com (2603:1096:101:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 06:26:25 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 06:26:25 +0000
Message-ID: <72ce06ab-4ae6-4e11-a7da-35c14e7d8c4d@vivo.com>
Date: Wed, 28 Aug 2024 14:26:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: simpify page del and expand
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240826064048.187790-1-link@vivo.com>
 <20240827175959.8f0e9a228407a7be16b328c1@linux-foundation.org>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20240827175959.8f0e9a228407a7be16b328c1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c3c01e-59eb-497b-5e5e-08dcc72a5758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NCs1Ymd4ZWVnNjRnc1FoMzFiVHYzQWk2T1JOaTdPNGwrK0xkVmxjYXpadm90?=
 =?utf-8?B?RmhKVktUTzd5VUtBL3NYZVpRK2d2ZkZnSmhsNVY0aHJ0SVVzOGtpWUw0Z0My?=
 =?utf-8?B?RUpOa0NpQnRaSnpYa3BreEFBN1NBTHdPYWRDTFY4c3B4aFB2d2JKV09qZHhF?=
 =?utf-8?B?UnErMjcxYkRQUGFmc3FhUkVKMi9PYnM5dkJwbFVIKzNzVkJYR2FjM1EwMk9E?=
 =?utf-8?B?TXJnbmRpU3BWVGNTTzU5emxQZ3hVTGllWUZsNVRURlVkbC94YTBhUVpHMHUw?=
 =?utf-8?B?aVZCRzZRRThRWEYzNWE5R2VseHllb0ZjMFh6b29jNUNGMVkyZUFWd1cyeTZJ?=
 =?utf-8?B?OExEYVRRL0xReS9xSGdVVmJHYi9PNCsraDFxbU8rY2l2cXNCdER1NzVqUFcy?=
 =?utf-8?B?TitQZlFyaFYwUHZ0Ym9ManlndzJUemNUYitTSjhmTnVkVmphUE92clpoMmYx?=
 =?utf-8?B?UUdRNWpkbk5sc3VLbXJYNU53dlJJcmdyQVJnTzB6M3NKK2hacGZxbFo4R2xY?=
 =?utf-8?B?eVJ2ZFpaeE9RMHJBQ2tpWTA3NTVBREdMaitCaHBETlZIMFY3MUJESlkrRkpk?=
 =?utf-8?B?TTlFUDhPeFRJNXZTVjJiTit6YWxhVVp5NnBwc1BKMUNaQVVBSzAxMldWTHFH?=
 =?utf-8?B?a3h3VUFWZXdGb0xqZ01oUUNQVTRMNjV1b0s1Si9ZQmVXclUxdmd4MDZrenhj?=
 =?utf-8?B?SllQaDh6SC9mbHJweSsvR0VtN1VpcUJhbUU3NHhTT1ZLbmRGNG0xalF1K2or?=
 =?utf-8?B?NWVJSUplWTQyb1NtSWVUOFNtb3lHRWQvRlFQbXYzLzRpQkNHa2pIVnA2UUpa?=
 =?utf-8?B?bHBUWkRDYjVFcGMzcnpKd2drS3h0WEJDdUp6L3grR0hzR0FBZFE0QVhUcU1i?=
 =?utf-8?B?cTVEdHZnWU9xVVRSTkNNVkJ5eGJvazZSZHBHOWxTUk40Y0ZrTlFtNlVwTlcx?=
 =?utf-8?B?TDMxSlBOUlVPWlNlMG5lVExWd21yREFvbVlUL1JIUkFwT2ZMNWVUWmZrdU5P?=
 =?utf-8?B?dVh5bWowZXBNb1hWN0F6SHZ6UG1MRHlRTzU0K3p0b0dHektNVWZRZlR4RGE3?=
 =?utf-8?B?MlhvWGJNODRUa3hVRVdaT29OZm5UWjV5NFRpRGluTElmV2VzNFlBbWM5NjhR?=
 =?utf-8?B?bXh5U29RV1FiRVRqNW9MaU41T0dBZk9aOTNzQ25peWRDMnlTOVBWeHREWThU?=
 =?utf-8?B?SHJHK3p0QkVJZHhtRnhCNDdUYmNaUDJ5TVV6QzZpSFVJczhjSXVxbjBDc3c3?=
 =?utf-8?B?OUdXWkdSUFlvRnB6L20xZDRkRVFlQWluamFZWmZ3VFZ5c3JMOE1sSGQ5QnZL?=
 =?utf-8?B?L2VvRGVhWXl0TnJrYUpXYWhHRCtJNHVjMlR2VjBTZWtrWHpaMHo3Tmw2bUsx?=
 =?utf-8?B?eHJYYUhuejZROVZickFINzVQOXR3UDEzTXp4LzJtYmlaMFZhTTlIWnZSZmN3?=
 =?utf-8?B?NyszdXFWS3ZQWitxVjZ1aXc0Sk0reVpVZTVLbGYzV3FyWVpxM0tBYnYrbk4y?=
 =?utf-8?B?TzY0THArRjU0QWUwK0JlcWJiMXpMNlhYY0E0MjRSaHFpK1Z1Y1V3VTIybjh0?=
 =?utf-8?B?NjY4cW1VcjNmN0NzME1MRVdVU0J5ckRNYVEwKzhpK3k2ZnpacGFKdmY1enZn?=
 =?utf-8?B?amJrUUpoUjc3SThRSytxMXU5eGt4cnJGWTRDbU1FRm9ZVTJWUWR1YUxxbUxx?=
 =?utf-8?B?Q1c2b2JOY1g5NGlvVHMxRnZaMjZFY0k1dEFaQ1R0YnZ4YlZ6K1IzMytoRWdq?=
 =?utf-8?B?b290akNmbEdTWXpNWUd0UlQyTGdyVjhhQ2xlUVpST0xNbndFVzdIdUVmZ20r?=
 =?utf-8?B?bDRiRUdCTDJpUWgrMFlXaWxzc082cGxpeitzT2t2NDVvN0tZQithK2FZeDI1?=
 =?utf-8?B?Y1hXeE8xMGdrbHBFK29CSTNqM3VpTzZKajJkSTVBMWdMTGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djJhMStQWHZtOG8rZnR2Z2oxdURMNGR4VjBPbXo4bmFhU28xcFZJM2lCeDRt?=
 =?utf-8?B?R3pvOU1QTFVuZmpqRkE2dmR0RytIOWhrSHYwTVpGL1Q2cUs2SU1GQTQ1OXJW?=
 =?utf-8?B?QmlXR1JNN1QwcllVQnFtWEFaZUpJR0N6OXFKZHJ6YU9nTkc1cVh4MU9vQWRr?=
 =?utf-8?B?Y1gxQkI5RGtiMkZ1eVlETkp6WEZTeThXdFl2b1VUVVl2cGFuSFFZZThNeWtu?=
 =?utf-8?B?UUdxTTUxZHU3dmJDRDMyMFBCL2E5WjdUNmx5TzhDbGZSVkVMWS9ZbEtZTDFr?=
 =?utf-8?B?Y2lsZTYyY2JoOVd0T1M2VmQzbW1oZU5yNjZob0xnUmoyWTVtKzMwcDd5cXhm?=
 =?utf-8?B?d0RBSHlMVm1scEwwc2hYMURka0dJQllTTnIzSGpBb3FPZENlNkhyamVZWXFv?=
 =?utf-8?B?NlMyK3hqb1QrQm54elNJZW9qUDJ5K0YwSEhQM0hLRS9wNnhxbGNReVBkWU5E?=
 =?utf-8?B?N1ZubzBLMFFJalpPaENvY210VGVKU2ZVYnNkdEt3bE00Vit6REdTcDV4OEVH?=
 =?utf-8?B?MHlBRi9ZUzRBMjB4cWZMMUZldzNIbHpHaGUvQ256TUxLTHg4WVZCYURTZ1Rn?=
 =?utf-8?B?SFEwRDlNdjBqcklpMDhUcE8yOEVOQUhxSHN2Rk5xQU1jWTg2TFlWc1ZVczZh?=
 =?utf-8?B?UHp1MmNoWmJ5Y01qWG1SWXRrNUZsRmYzdk9yUVRGbVVLcXRjbk9YM05aaWNy?=
 =?utf-8?B?dm0zVWZBN2IwNmt5WTNNY1h4Mmdmc0s2aDJSUW1zSWpwZkxDK3VERXd3MWdm?=
 =?utf-8?B?UUlYeVduZC9YZk9BWHRaa2oyUm1FT2lNVStiQ0p6bUR6OWJsMUpoSnZXaEcv?=
 =?utf-8?B?Skc4RWdwVURwM3VveGx3bzYyOHRhd0RGWnYxTUgwSFBXbDVOS2IvQ2REdEQ5?=
 =?utf-8?B?bHllSm1aZDQwRWNicGtqaUtvTmo5SjdEbU5PQ295eFBMZUV1NElHcmJWUUtp?=
 =?utf-8?B?VTRKYUlTdDVnSnhHczE2RktoQThtRUtDcmRLQW50NzArbW5CNUtyajNVR1hN?=
 =?utf-8?B?N01tSlVJMzY3M3pDSWFEOW9LNC83bk9QWEJnNDFjV0lKa3FSTG9kczdrcE1Q?=
 =?utf-8?B?VkV4Z0hmRFB4Q2s5NW1hR2NuUjFzczUvaTlQdmg0eldFT0s0c1NBUjhtbGMw?=
 =?utf-8?B?UXhwT3pzejkzejNaTldpa08yRzcxZTdZREpzQ21GQWgvWHdRLy9WNVlWRzhG?=
 =?utf-8?B?bGdkUlhwaVo2WEtNNTRXNmtPeGRWd1VsWmNRb2JoOCs5UnBMczRqL2IwSVd2?=
 =?utf-8?B?WXl3MzdqN2IwQUV0Q1RvZStZdFdIUVphTnNQYVNqUjRVQkJHR3R0WDdkK0pY?=
 =?utf-8?B?czJ5aHRqVG9jMjljV040QUZYcjBoNDZpN0NpNDlOSXA0bmYwU004bUxYc1I4?=
 =?utf-8?B?M2V2dWtyMGVrVzNkVGVod3FzSWd1SWFXRG1CV1h4cFJwdWNJWjBWWUhrZmNa?=
 =?utf-8?B?eDVFR2tTSDBqMEJWK0JQZUtMTUQ3YlhLdDdqUUVweThPQUc5QkFpS1Q2SkZU?=
 =?utf-8?B?WHpoSUtzRlFSUnB2b2s3VW1JcnpDV01EWHFwNDVaL2I1UW8rbUNaSHhUNllR?=
 =?utf-8?B?ZFBxSEZSQTVCMzZ4d09nL3FqOGZJOEFRL21xMEFwMzQ2SThVZE5FRjB2RU9B?=
 =?utf-8?B?RGxsYklsQXd3NHVaMTNleVRQejRmbG5mbWVxclhUK3ZUdlZoWm9HRjBnSldM?=
 =?utf-8?B?bitQMHdCU2ZuaWRZb2tURmwrK3RKODBMZDJOVWdpYVhNTEpCMjNrK0s1S2xm?=
 =?utf-8?B?ajdxWDREM3pPTExkTEh1dTNFMUR5SHlNbldOaDdhNDFsYjNyZnZHNFFoRFly?=
 =?utf-8?B?TzUveHRsWk4wYVpDb2E4eEU2U2UySTdJeFlPRytTQTc0dDhLTmxWTW5ITDFZ?=
 =?utf-8?B?WWYxaTBlTzZSenZlV2QvdmFIaThWUW1UUlA3RjhxUmk5Titwd3ltWkloMHZt?=
 =?utf-8?B?c1crNDBpOHUrVStYSG5scTU3ZzR0NFpydVdBNVIxZzFlTUNUanVESUF2c2s1?=
 =?utf-8?B?emljZ3IzcEhMZ0ZmWmt1N0VSek5uYTdUN1pjUDlEdjJzUkRsN0VEdkpsL3Ro?=
 =?utf-8?B?ZEVlZmdRUUVjZWYra0FtcEkvSHpUSFlNYUZUa3RpYS9UUzlxQXVhNzh2Zmh6?=
 =?utf-8?Q?32ne1Xf2WfJU33flPSeYWWZ+1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c3c01e-59eb-497b-5e5e-08dcc72a5758
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 06:26:24.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYRGBRlqZ3aOlEMKdmhk2lcEEUeX4xC1V3ojoVtgXtJIJHmWC8YnIaCEC3Y2jhjuopECxFoW1XMLssmGiFjERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5645


在 2024/8/28 8:59, Andrew Morton 写道:
> On Mon, 26 Aug 2024 14:40:48 +0800 Huan Yang <link@vivo.com> wrote:
>
>> When page del from buddy and need expand, it will account free_pages
>> in zone's migratetype.
>>
>> The current way is to subtract the page number of the current order
>> when deleting, and then add it back when expanding.
>>
>> This is unnecessary, as when migrating the same type, we can directly
>> record the difference between the high-order pages and the expand
>> added, and then subtract it directly.
>>
>> This patch merge that, only when del and expand done, then account
>> free_pages.
> It isn't obvious to me that this is a significant improvement.  Am I
> missing something?

No, this is all. Just want to avoid account twice.(add then sub)

Thanks.

>

