Return-Path: <linux-kernel+bounces-296430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF795AAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA571F23193
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2712E78;
	Thu, 22 Aug 2024 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iNl9RF7U"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01D15E81
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724293965; cv=fail; b=GlN4MuB/efBnOor3WV3N1z3fWpPwTFJwo+aMACyOl57aKcDPlxKoXyMxBI0VFRTOI9+VaSMpNdnARjWRlyOs2eSDTU/OS4UAfQitFJeYIn6iz4UtfgFNF554wrqOtMjMP2GdHb5AwKDO28hophA+uAbIPW2N9Wd3VTeNYK3BV2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724293965; c=relaxed/simple;
	bh=+1GbXJeLdHIbOj335RSXvjLGGFispZbjIa7AQhWDvUE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RtntucAiIeiB1MYhzfAUVfYgWx1i8epAMnOoPjycMq/naGOPiZP4Lrfee+xpH5wfNMzlLKjp4EEas8a/A3DNkMGq1prZYpZtqDw16dNn9uUWkR1IOeX1YGsniQ2gEaFVGYgOnptpDyVcbUoR8z0K8ExlaFv8fSEIsET44dZ+NIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iNl9RF7U; arc=fail smtp.client-ip=40.107.215.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1GdJS+3J9uUHXDv2sP5G1QpWvPU2dUNEXpnsWIB+llftEFl+JeEd7EwNcoJH0fK6GKJYeGqHHTrx92vVSgsiAC9UgjDd0VTfeo6q/qixyXtbTtmIlkgjw7hFnT3pYNIzp5r/GglS3sHbDjpNvyoWvmalWpuMahSzHiG4zHV4KopYlEGl4bkO8w5sfdoWmVap53n23KyjGb08q/6T9je59EGA1T+PCsN/D+A5HvesFZg8PUhaQGREygJYTGJroX4IL7TCU9Zw6AvSW9GQndc2fW2CZ1+zlFhQntosv9H/NGZpxRhWSJA0dFAU+wWxnpdehR0aItYIjHjA+kXw50eCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yZVl83JrJFaDRsKTNAbd8Az1qepEJrUYlr84LdAsxY=;
 b=ln3KFDcIT3RNxOL7sWc8ImEC7NN2iHh4B4UFFujDC9OxJa4cbJ8kurPNJ76JevQoYoErPypEOK4EoUiR+pwNm2Zxxb56kG2p96tMfY5VSRV7yN/1KgbwKRvsRe+UBnG0qTcRUgX7kdi+acHD7ebmw4o516n5/+0oEuYiIGX97X/P8vSYGjekyssHYQQQquISR/wY4LCi69TOrSTcOyo3WavahQRVaPLcQ1LLRhgenYrHyvfQzak7cMBLgNLD2wLFqs2ZX8peAuTvajLiOVENHlfkXGiEKDxUHPBBedUQWF6DJmvxXQ9i/5ypd959ArKATMiUB9Aa7fW9RGExLuAVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yZVl83JrJFaDRsKTNAbd8Az1qepEJrUYlr84LdAsxY=;
 b=iNl9RF7UHJMAH9iKuUmkoNEpoyl/j9a7tX/FEoGLti7/+2pMv847mOUJ8FMN5k8hNsMHygN5eq8D3Z7noh6wlEiLk1fvYnQ6m2+RBOMVLbblxOPzil51TnC08IHJansx3m+6O8GxUZM8cEBLd7IDghknY158W+OSA2euA5X31Aua5U+irw+FK1OpstBSQY8GBGsiuEg0HhlXKgrPEh5L/QzWOix1O0uc9tiOJYJFtwW7KYmv6GGCYkgDOgLZ0kosXiOnftvDRkVk5gHnWq97J4PfuqscHIzIye7VwI1vzEyZ/7c5cXh/RMMcE02GjkC3ruGpPZy8Y4yqMYLBeKF/Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by PUZPR06MB6187.apcprd06.prod.outlook.com (2603:1096:301:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 02:32:36 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 02:32:36 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz
Cc: roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] mm:slab:use kmem_cache_free() to free
Date: Thu, 22 Aug 2024 10:27:04 +0800
Message-Id: <20240822022704.1195439-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::7) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|PUZPR06MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b4fabe-9699-4ddf-acea-08dcc252af19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWB6uqKqDKRvF1gZCN0p/PklZXg2r49lQ35uaJ61dGkwpG8mbNqdZjwe/juy?=
 =?us-ascii?Q?0v0legEXr/o7X4US9lkXES33xeRRJ51ySMKhPevzAaWLNuBnAXreJNOb8H0j?=
 =?us-ascii?Q?ssFpDIplwAa2SV6IZS9rz62hyFCUqQWxQ9Q053MIRG29QkxcRBaK82za3P7R?=
 =?us-ascii?Q?p3oRJolyyTSH1H0QZ8ZEmQ5MINK1ohaivXZVtuoajrXFXEG9+pg+KVhXP2ki?=
 =?us-ascii?Q?ZBd+5rplr282IUEjIWoGTcq1YP7iE1yfZU9G1gRzhJ527tpqBO3VdxtE4tx1?=
 =?us-ascii?Q?yBFBVKWOtnp4kDq+8tYRGo5a81epFIrYkz8xJ18v3Ov2KWtBGLOq/QfizMv0?=
 =?us-ascii?Q?4bAWfX/uCqmmod9wOO6nan5QuZ3iqjhXRgG6vt97fEtvto8ls5V5QEaTUBSK?=
 =?us-ascii?Q?+x+XPaSVmbhdY3jXfG2XkX/oFg++zI8mr3zYgkQINm1P2/TUNP7QCLCmiWzh?=
 =?us-ascii?Q?ZUgF6tZoVaySxDUNrSWP3gJ3kiucDtLRPRBH1ubz8etLdCC/dfIwq3E3Kw/g?=
 =?us-ascii?Q?azpgHfZm8+tBTlBuedMjXCab+tgzzFSiRnw1VAAexE9ncX73rsG3ysIxXEVp?=
 =?us-ascii?Q?t83MGaiuFep5O7DmyfKircmAK0ffMVEODOyle1ZUTZHDW2sEhLf0UNGY3o4U?=
 =?us-ascii?Q?fPKSI6RLbrZFiECj31F6l80oK1fF20I5d4Gq4Wfo/ZY3/rSMzSh9Xq6TZ+31?=
 =?us-ascii?Q?/SREnY+eiQWAfJluWwyPNdVf6mLCaopLeZrYVdoRbIgvmzByWH1+7NZJ+u/r?=
 =?us-ascii?Q?vCkBFRxjP5r5fXpj/2xtXovRR4X9kmNs2aaSBd0DV99Lv6MZRk/QGmvf1xqI?=
 =?us-ascii?Q?oEDdDg77eBXJluSKCJOR0YeDAmMzdgm0uisH4GQ2TFxf6BYH5WhNSjTjiabW?=
 =?us-ascii?Q?dP/Gbt5qPeG/XnRbKJFtfTDtwwe2zEYcOQzl0IV0xpTXbdOonEcjRg1fgp5S?=
 =?us-ascii?Q?4LxY0dDNBxkFILS3Tf7oMA1QAbbW5Su/pkiitV2CH5+w1qrnMWruFpLvHzAI?=
 =?us-ascii?Q?Q6OTmgYZH0O6FWJs0pGGGFrMkdlv58uG3fNIxpPVWZlx35cegEZ0UKeKDsnP?=
 =?us-ascii?Q?mKgpzrxyjFVfA1GdDtcGSRMgatU/Xl8LruQdFWFMVY3kssZ8U4/onDy0Rjo3?=
 =?us-ascii?Q?1UyODLYULAsgUXMkoHDeZt+A4m7QtxSLTIUrG6jAsrnA/O8xePIFrxk/lXGM?=
 =?us-ascii?Q?ggS1b0zrBqMx2+6DFVbsIILLqXZ61pvSKCqRCoVbTgRpzTMfY0yJ9DNN8N7Y?=
 =?us-ascii?Q?pBzkOVTDBNfr60OI/QW07cQpLqjPg40IUadHs+jRyZl24Ta0uhhHxSZyVNjm?=
 =?us-ascii?Q?lsxvHtQYYpOP13N9BDWSn3c/0blwDt6cQsECVS0yyesgxLSN3rK7rRVVGjMz?=
 =?us-ascii?Q?G+HzWfYGTl+6jF9xqlrNhQZvlUWdWvOT3KfOJaV+eDy0QOZc9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6N93Zmd8pZPu2l+X2pvepRy5gyJudE91sSsYPKOIWn1HQl+51YktRHCUf1Yj?=
 =?us-ascii?Q?cSCvz3bBf8LwYd3YjZX7dRBCJ1nfCwQbJwIqLLxDznzPk2LrXu7+AtgRq3mr?=
 =?us-ascii?Q?7KDlmHwJFXoqd3h9P14zfNZTpXbW+V7uAGrLKmp9903PeK7PqXsPbW+NsMTc?=
 =?us-ascii?Q?VP8jtYOHs9Ec0HFRZxCSSfBtOAB/wm/fZV7b/g9G1VLEll/AgwGWEcar9HLQ?=
 =?us-ascii?Q?7xzwSEKQF9ZlzeBxURUPRf3jFm4UoV5nC1C2T9cx1Nxq6djej60z3iX4r8+e?=
 =?us-ascii?Q?1l6QMyPxN8/r+udNpHjK06gcXsk4NZAvcKGFfgEL08fJqJI7TwCyaStybuPZ?=
 =?us-ascii?Q?T+oMFiS57EQrWhKr/MpA5jSzonCgISHneAqQfqtz6K1rKNmSYwiJ/e2EurpD?=
 =?us-ascii?Q?atUN9TkITayz0ysPOJVmszApqBUC8LIRFBGAHdgIjri79MUq8De/ETAyriD9?=
 =?us-ascii?Q?Xs2KixDIZJxe4xyamBG9Wc5Woy8l2foWb1gcfARXgOEhJO2z4zxySOR8jOz4?=
 =?us-ascii?Q?/fYTrd9HyHqrg5raubo+W0IhKq4KQ/c05crNpg/yq8xGRssZQo7axXKLl/Da?=
 =?us-ascii?Q?GRJLOutkOWlYOBsq71He0/Fv8pxIxrRzhLwcJqm5NweFFcQT6ihi0UJPvDEw?=
 =?us-ascii?Q?tBmzY0hJcZyZU2pM1pPtRMT/roxeOkZz49l0hFnkgOvcbra7X3VqW7d+WweD?=
 =?us-ascii?Q?vgrdjNsFCnOmCbRym0r1Qb7rFOcy+wu50E+kjqGG6ULyAZMhxJhPvLDeds2U?=
 =?us-ascii?Q?Z3XteGVRXBR7e+6/LlxGwNrLoFAB+vNCNm3zMnpAn9VfxCPxYmda4WKGcbWe?=
 =?us-ascii?Q?aGgk9sPzDGO5waD03oUpViPGq6WsnB9ji5tyF6gE8NwL8kha8ZhtkTYq9iQW?=
 =?us-ascii?Q?Vhg3EIfqUuXW0KAkbgPy2XitRjCfJ0pdtjsUMX/EH58pBvKy72D6jk9JjgIi?=
 =?us-ascii?Q?l9DmU9NIIpmXrJ4sMSEj89e875FhICq39plrGR9Yw0QJUgEzMeedCNB1vZek?=
 =?us-ascii?Q?3zWOxtYhudN2D80eH6c+88DhAe3WSC9smkW9YygX0+e5vWe8R/ewhNp2zjg3?=
 =?us-ascii?Q?uL5J6zvA5QdMlF112a1MeLc440o1wGGYQwMXdh5HJG3AKCKBArvnV62czJeg?=
 =?us-ascii?Q?lWrGcPpfR0JHAXPJGRAavw8XxYy4nNua883IaLZhrEOKvOO+7+APZptblU9o?=
 =?us-ascii?Q?bl0gNr4uKLgyCP1S/zEeGXsbOxwm6ISNoErFnqzBMyB1mD/udx9R/S06SJW3?=
 =?us-ascii?Q?Vvc/tgYyhayGa+VfVtoSWZEOHfGRBsRGKptt1+rWyf3dbkAkk0XrIuh/NiNO?=
 =?us-ascii?Q?5Cy1D0HDLMUdt0cKGKn2AoWhZdfvU7wdj9WJ1J9dqsvyoY8c5ldSrykKfXXq?=
 =?us-ascii?Q?K2/pAsDHguK7Cs7IMAfXMkPP4Nq1IFK/N4IOUSzJKqTd6DAbqpdEma/DufW8?=
 =?us-ascii?Q?1uFX9ZpPwd9NfyMjyVCi4ykvkNZ/If8NyUfumIa3B+YBAteuQ5JvZ1Ubc0R8?=
 =?us-ascii?Q?Es1bmFCWQKopOzD7Yw6adB65k8UY+XC+rGD2ws+vWn9FLykDFgurioZPFwCx?=
 =?us-ascii?Q?lc53+HFueOc/UcXnoXlHfeR9js8jvdF0sCSWNKxq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b4fabe-9699-4ddf-acea-08dcc252af19
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:32:36.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLlUINiBdPUKBV8GBCucOHVgFuo2D5EEoXncSPJj09BCPS30aXkM1U4vqrGE7danJVN0wTLW69w1ikiup4fkHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6187

The kmem_cache_alloc() is typically used to free memory allocated through 
the kernel memory cache (slab allocator). 

Using kmem_cache_free() for deallocation may be more reasonable.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index da1b00665..0463df45e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -491,7 +491,7 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 fail:
 	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
 		kmem_cache_destroy((*b)[idx]);
-	kfree(b);
+	kmem_cache_free(kmem_buckets_cache, b);
 
 	return NULL;
 }
-- 
2.34.1


