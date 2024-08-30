Return-Path: <linux-kernel+bounces-308349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF7965A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C61F23FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D01C16DC29;
	Fri, 30 Aug 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZjV3gnLR"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25916C877;
	Fri, 30 Aug 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007445; cv=fail; b=ripg/Cf2M51hxIT8CY6qQOhsyRI1JJYA44Y9JyWHGH64pYF95SQa4yCfwJqkFcbaEplxWrKBm3qJ27Hzkzxw8JfpXBisyiYQhG+hAG2YiYcHe06wuej0FthUeKaR5c+5fjRhxomHQ5OrKGmaJ5i234KZ74/TdfgKHdVxNzi0NxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007445; c=relaxed/simple;
	bh=nsTxJ5BbmEaEIKATMqhweGGtxAeYJUjUvRgrA3BPyZE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DjkC5nEBu8OxgUUojH1iDs3xikBiROamvizHxNpX8pMHYRXKEAyqQeLKiIthartIeSy/u3orjrt9LZEzHiJGU9MaK4Wauc3hT3RYV4q0eDo9/zmkevcMWUW6IKYfxbDX5nQ449p9xtUqH1azBCCCphqlEDHIaNV0X1BOv4YQT0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZjV3gnLR; arc=fail smtp.client-ip=40.107.117.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvoHKIiYeLyzu5D3p+Busd7jlUgSjwykEB7XQO5/bBvuIuUuWgx+koY7aypCwf4Xrh3QVyF6n+XaIcTLbSeHFd58rnxdPeU4A0Lpb8aMLlPaB8RViPKibDoe2Yrq0CYj5jbeCn8ywT97fENI51g9wkkHwvF9jIBnW8iQp9CvHsF66vHpFbfj9JZuwTTspib+ycSaOepvww9nnLcg0DGZb73Z600vda/O3eFMjm0TohpMM++T34IJj0ZfgAzpqFI+ONc4zj1cthC+OBkELnHXKfYWb//U/CdwAFs6lOB0r1OBMR3bJm+J7r7ECtaOqES36NUpozCvCwqV3uFgSQa8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbt5pSVLf+x36XmfMjNOLkergrkNyOe5t1VYIFLXNWI=;
 b=eM1z8EoLuW8eQ5Oiu8pV19CfTtDpa72sf7U9M7CmY+yHDZ3MUQnYxt6DfXKgAPoNVj16USxCHjdptWCAWATNiWsNarcPjX0D02Ke0MKPERLdeVz0ac91e/LXU5SA1F9QoP4qb3KWVF58CkmpsiS5qHaGCqEk5dFEN2zRwNkcamBvoiSbmG6g6PxJYhaXu5v6SFbgYhNp0SoeOH8R5ojoBQjwBpXS5iVOn4Ey7MXExRctLCgva/KpseKu7/C/H1SSjDuoXZFLQqSDRUMLmlrC9M5efn3hitbfZg5lFlFhRzzMMB3Mm59F6JJJO7f+e5yrVgEkwO/l1aeEQBzn9Rtu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbt5pSVLf+x36XmfMjNOLkergrkNyOe5t1VYIFLXNWI=;
 b=ZjV3gnLR9/F3WaEi07XIZ9+enl6a+nyp4T8OvtX268zaf3xufAGwKpbunh8nnB5YmR4/xL7uAI8pqkTyqvEJxDEs9B1XR98oaVaSSEqZVedf2VbsQZEEhaqvVfs+gmBkOUZTYV5FaOnMfNd/JkkAQ/Mzgwch1OfEvHy/TguZEqR/06ymQP6r2XQK3oOM+EqP/29Df7xsLN+S2T/fvHO3mg3b8FUOxUrwNUiMDmBoluyip7B3qDV2miXD3/VoV+ahIZL8SujChWFAQKbdkiOcjOwhntWguIO73LcQYnztBY6YiPSO18+nYaTmyue/tND3beKTl3oTG9PUqTtsCwkqdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB6681.apcprd06.prod.outlook.com (2603:1096:101:16e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 30 Aug
 2024 08:43:58 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:43:58 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: ckeepax@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	linus.walleij@linaro.org
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	opensorce.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v3] pinctrl: madera: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 16:43:09 +0800
Message-Id: <20240830084309.395129-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0235.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::31) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c8e4b1-5fc9-4af7-1df2-08dcc8cfe383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVtnJQTzjNMvwrdk/70jaMcJTtsUYYeLJ8spGrQk3XmUePPZfejPEo62k3La?=
 =?us-ascii?Q?2kf0aoWfg7k/5B7C2ALKEZ9ePzkRn0LBigS10Ytjwx7qRdPmqrB47hizj3Id?=
 =?us-ascii?Q?ZwHc8SeaEU0LkKxZqa6896yA2udSQUxCPYtYaoziD7GMG8aXlFhxIxvkA57q?=
 =?us-ascii?Q?Dw8qScERgbuDGX1zpf5yA0/bbPkuISTvr9NiuhtLSO8sh0wGMXuTyS/t5s60?=
 =?us-ascii?Q?Ha+wpVKKM+W8glJc8v5hfLbOjOHdJHW8WnLMFMs0g8w+GsNQ8a4aR5miRf68?=
 =?us-ascii?Q?baHwSYEeigHiHy3vRxP51rx17hHS9TiUGalrBbiQ8L5z6RJ812q/xll3zp6G?=
 =?us-ascii?Q?kE7jq8M0xqKBgljogPFSbKnaipgB87JIBDhHTLgZLOZYO62M/wF51daEa/Uo?=
 =?us-ascii?Q?FCxnLvr+db8jdJM1Usot5C+BuxzZfusXzA4VHaB6V5FUCZdxBFoN1EpVYnjT?=
 =?us-ascii?Q?YwbThlOhmkkrjNGFXa5FV1exXvK6Jls3gQ99M38Sqi31rwrtM4OlcTH41ot1?=
 =?us-ascii?Q?e1rQMIDBaQIgmMykSe9g5xJBFCri6ES1lw7Fztx/rAFKPZ95Uq5m7MKZuq4j?=
 =?us-ascii?Q?Qre47o45zdUVnyzELCCKu9VzsfLcz8H3JHdsG4c7NSK2Kg5nTq+Q9ZjzONkR?=
 =?us-ascii?Q?LuVja3I+S0xKyjDLvGWBebHHm/tNNvj+KuL+yEw7e60KN9zuwk/V8g/VIQan?=
 =?us-ascii?Q?iYMnBa9wni9bbn/5YXtzEZ8TiI3XKaHrUOTIkWkINu2HLdCNqaa9p435aoAY?=
 =?us-ascii?Q?+WkThZIP5FQi+HWE0PboaIOB+xumgc6SkGrqGRKF2DuMcXK8TufFHcLS+Yt7?=
 =?us-ascii?Q?QCo9Y/gAo0gBscZIYNCwdjOXkODsc6ltWYwoVPKqy1Hme1+JHW8RqkZOvJZ7?=
 =?us-ascii?Q?qj/UFm+cwft+qrIFTNXYgA8ZICBK6GFiUTaYuQjkecGolErIsix73JciPjcw?=
 =?us-ascii?Q?cadziJSKU4jamPzEb54W+0RHBE91xnQVTIeLnQTeveJwnYneXjRL1rI6s8vk?=
 =?us-ascii?Q?k20it+DWMioNfdA352W+hhL/2abClVv/BjJwdxHfwiXEOhJeobIT4g6P6GEK?=
 =?us-ascii?Q?/hQVGLCcn2hI5VNrLVGHsUy7tkPH1e4SazVPOZNLQsfFq8gb97Dg9wMzf6so?=
 =?us-ascii?Q?9BOBAMTv+QQ3KiujrkV+Wd6G5KmltIrHxM2ObZkyS+psXDjchMQi49Ijk7gv?=
 =?us-ascii?Q?uxKfM8IgRrXl6NAr49wtk/WPVJPRW5olnZpgp4sLQ++Q7qYvFsql36sOFi0F?=
 =?us-ascii?Q?mDcRLPB2zC6Bi2Ryy7Ef8cVcLt0+iaU2KVAJV7tsEMeqv/9YITfp5pUxdrVc?=
 =?us-ascii?Q?JvvTwqEumwMLeeg5bw87XbPFM20NOWGW6rDunDDyjeNy+m2+SkUo65Dj08EU?=
 =?us-ascii?Q?pRv7kZrpMX1LedQGKKcIrFgyYReP5l0HTpuOV8/8z2QEFjj1Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z8Uj1bVNq1I9r+g/tB4EuYr5JVNu13ky8W8EZFO8xypezJ28cnBliL0JHZMJ?=
 =?us-ascii?Q?cs7R94KJHOyaIl46VoNgiqWQN8uAF9s1mYJn59AT22BidN3xCDRLfcbePeJW?=
 =?us-ascii?Q?MXP7Ort5E21ygxgQNbUab809o8N20R9NIu8EUD+X2mdzymyWgUJFdeh+yVmK?=
 =?us-ascii?Q?MH5mLC3etfKnIqXprBgPiDi7K1deo9vbOllg2eVNQFOpv1jC2FuxcbHSpTl2?=
 =?us-ascii?Q?vGq3s/05yIeB7xlel4xf0NMdrprGyQ8786n11Fau3Hghl1aQIQUoziylNl8g?=
 =?us-ascii?Q?LidWhvj9mq6J9mMjR59P8iu8dMta4hOx0b4IRSb2F3sGXAd++vy8ss5loxqX?=
 =?us-ascii?Q?00uNeAnaFynxWMV5j95zCfR/JBgarsDSKvz9GGONbxmDlwvM9dXrEPsJ06ZU?=
 =?us-ascii?Q?6lx9D1KAxIZeMe2ap7eU/awLVaRoYwEGVm7Ktl+man09r8O17x7tB4qXipOc?=
 =?us-ascii?Q?HzhtBy7jm3D9sj5es2tlzlDvBMRxP1KdCtkVWBfLWNzdy9LvOHRLJz67a18g?=
 =?us-ascii?Q?QWiHV74fqOcBKyZIta0bVCE6oMBSNzwsocwi7en3gNzL4WY9vxxKitK4YkQP?=
 =?us-ascii?Q?1PBej5+KkktNo1OOc+sXP1eu7bxGOMC839fIgFiE8Qd0cGPNn4uuCi3grqKa?=
 =?us-ascii?Q?y7apWeX8Cc1uh5S4SMlzYlHOXFgEbscQqT7GQskAhFuzizC9TnxNCZXAq4b/?=
 =?us-ascii?Q?g5/0Gn5L6TPorf/3MwVOUy1i15G0xSmgYQY4nV8xWLUOWbALWbrd71B2JYWc?=
 =?us-ascii?Q?Ze5qORWPNwHoEpKn5ZwEk0HyXJxIdJh4DZPrpUplH3BLHXQVnmAMm/LXT6+y?=
 =?us-ascii?Q?rVP1SbKIsHVa8jox0sfZQj6gHXMGVODRTw5VhhFAL0iAeqXc3kJNBl/AwFBz?=
 =?us-ascii?Q?mk/pIll8gL3ZvyIVxDp5kIRym4wevJqvEo67rNd0sTFB/ydtMF4JCRxa2sxD?=
 =?us-ascii?Q?SKUAU3V/l9/U7fQrSSGLR0+FYv2XSjOJSL51Q7Ic6A6lT4oURblnGnyPsNIb?=
 =?us-ascii?Q?flDz9vPCR5iJkbs+HgYs2LWX743FxzluvVs9MWgL5k0OwnDolWIn1WYCRl1h?=
 =?us-ascii?Q?TLIKVUKHiZrLeVkloFizCFW8YEunuh1upys/ZT4n2jxfT/qI1q2zAZb8RDe5?=
 =?us-ascii?Q?Y3Lf+TqJhxsdNYXr9AyQ72Qela0g6Y+T89PkNiP+LqRrG7TgkMVUuosFr+c1?=
 =?us-ascii?Q?zO2daevB7CO70z9x0GevXAzgBEtjxMj+GZ8kSwFbtfCoph2tgMffTFILjOmj?=
 =?us-ascii?Q?9w/EcukBRMn1EvRw5xAB2s/bAdabFT1blyGHYK8wdc2HDvJkChIARfRSuZoO?=
 =?us-ascii?Q?g5uRqV0g6xAp1Q5Vcb6/G1uCHQOiiotjVtzBdmX7qqaZNsx9xoTndZIE+NnL?=
 =?us-ascii?Q?JS1VG7DSw5n+dkRZZU/xFTyQjGd6/cUcx4QGE2y/O/w0JM1dHx8VQBsCqZVp?=
 =?us-ascii?Q?Bmebt5YE4QShvedyxsUL3Umy8lVlvZkw1QjTNV1Cqoc6rgLuod8b1t1BTdws?=
 =?us-ascii?Q?Th+UNDOkvJzQ89v+TyN8FwJSBSfVELo4zDZJq9HC+cXnapsST886b4rAS0xY?=
 =?us-ascii?Q?OYurXUVYda49bT0wH32qaVfWn8kVgh04ZYYepMmQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c8e4b1-5fc9-4af7-1df2-08dcc8cfe383
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:43:58.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvUKXlpe9F106mB4D8OxCPEt0wMSNJ2phs92+pRY2WSIkh4Zw41miRXe7KhXdm6UaAJXcSgiNDgoaxM5lZ/N5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6681

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths. 

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v3:
-Rewrite the subject as 'pinctrl: madera:'.

 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
index 898b197c3738..2932d7aba725 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -1063,12 +1063,9 @@ static int madera_pin_probe(struct platform_device *pdev)
 	if (pdata->gpio_configs) {
 		ret = pinctrl_register_mappings(pdata->gpio_configs,
 						pdata->n_gpio_configs);
-		if (ret) {
-			dev_err(priv->dev,
-				"Failed to register pdata mappings (%d)\n",
-				ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(priv->dev, ret,
+						"Failed to register pdata mappings\n");
 	}
 
 	ret = pinctrl_enable(priv->pctl);
-- 
2.34.1


