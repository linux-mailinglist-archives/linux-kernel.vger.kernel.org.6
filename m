Return-Path: <linux-kernel+bounces-316726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF796D325
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CB42887E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBBB1991D5;
	Thu,  5 Sep 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cy/Kc87V"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011069.outbound.protection.outlook.com [52.101.129.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E319882C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528456; cv=fail; b=fe25N9pWDAPRYSoRTKv1xsk2fY2Uetzu2Ylmxlz2Z8SXj7gvTAEWfjzODgYLo8Uzkk4gZrGcq4dmcLNTHLci7WB9c3OQkl6Xi3yE6+MMV86vJfd47dSP6agK5QtsUk1WyyTcu1oguVo83J3WTt6RUc7LUlc1mZQ57SIU7diOnTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528456; c=relaxed/simple;
	bh=48OAfQZ1VRYsdMDpACYlR0t8TrU8OlNYwWmweQQUevI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pqSvZnKovaBSSqN5Khw6pdcPEkQ6JIi+s00reNnPAkBBb8lU18LIRU7Ik45jkg9qU5fQ/gF+GDE/1C1ah1oXfe28l5FnUbQF33L4EYzBYmL1KWAuXbmlh4nMNTv6e75O+3KH+FRYccSsD/j+8tMwBaXmnBMoDmi2/ZN5sf7Ei1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cy/Kc87V; arc=fail smtp.client-ip=52.101.129.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jtd7JWk+9YCnCFa1HO/p/3OlzvRWyC0GdeyHdAGFsJIA3sL2wetwgNtJI7/jefKd2N7/O0tcX0qZF6iTQqvDYCO7JPM4inoboZOPy7yKBMdCHwJq5CwTBq39U5jMPEHgjrRwk8KN609/qp8J5s477W+6f/jT9P++JHToS10Wv2mKgdpaCNgoeE94op/BYobcIssbtnmnqYrht0toLUM/2s7p4PlFPfjtFUFm1FCDH5qjqYcCbcQ78jF+8xOhCFUJ7L1o1Vh7Q74D6EbR6yj3pWmt8wTfrL/4b9vJROzmyVavrYbyThTFSkr9CsyK7PlFtX+9K5Oy+SNVW1EvjJ7YOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBQ/xFp9MicaQDM7AuT0c9IiBNiKZuYWGpzNCrqhqug=;
 b=QM5yrR06XaQ98gG/ivo9cnQstma5x83R/byUpX28HpRcVKr0vPLSoiaerIqtpL0TgaTwOd4/5zflXIwbtAQTRuG6OvxqWfXngtkOw7+xx9SNWkIXXL73udjOdHFEfp73FCNmlEbfPfX5I2Z5CeQhsWeF08CZAnYq9dzK232iriaoeOyhRleYPBTxfknQwXBGSaWzIcCtJhoQcyPwNYWW89eVft6mJS8Zz7zIahOsI3Yd+dEy/p2BrrHBsrCi9rV7n1e9nAjOwZnBxWjdgEbnJZ/U2ziWMcJ4eC6ZF8CQz1HAetCjIb5r3ST+1Gwmv4z2oV8sEz5JpgRv2IFLkNtmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBQ/xFp9MicaQDM7AuT0c9IiBNiKZuYWGpzNCrqhqug=;
 b=cy/Kc87VBKqsRVXW7McexynzqVum1JF3pI3Fud6tJqv+y26ykIu6vGRMOgVZQFk9dIiQlVkOwyiHmRWhN+iTagS35eMsk4ugNVudnBLvlTOKhKKR0D4FmcasCvh+wgmK+lxPxZP7IbWZY8BZGzW6JJxSlJ/MvyrgLbZPb3iuvcxwSgO+fdP/TigOOdcs8K3S4iQiToEUKCZ6cXhlgO/KE4vJCZsrpyweti4klfyigL+BayBwmeCBWfARb9d52+tiz1JPZXEc2/OYKFfhHrwg4SP27dHV4qcMmamMfP7Mm9+p16Xdf9LV4fSiUseQGqj0A/nY1EoNcvn46UPa8dhS/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SI2PR06MB5162.apcprd06.prod.outlook.com (2603:1096:4:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 09:27:29 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:27:29 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: lee@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] mfd: Convert comma to semicolon
Date: Thu,  5 Sep 2024 17:27:18 +0800
Message-Id: <20240905092718.95011-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SI2PR06MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6f3ac7-b9d0-4f01-fbda-08dccd8cf674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s06JtHWdkl/vc15Fu+1QKrHXH2buOE/5yhFA9U7pjCpluXl42ifsS6uZdEq6?=
 =?us-ascii?Q?uEO9DcvJgy8Ep2lxieU8150mo0Kyh0TxFnr1fJI1E/XoPBEZnM5/oP6vtQv1?=
 =?us-ascii?Q?grcw+IDCRpcglrkN9IVDQbAlZPMfpIiuYFLJFnHzLRgfRdmLEM0/TeCsqCd6?=
 =?us-ascii?Q?ky2lia+avViv2yc2vSu6BQhNQz8GAYNcNQqU7/9gSodG1rRBwS2+lOiKBM/q?=
 =?us-ascii?Q?hS1Na+RewkCj96BWIvbgkAVQ1WjdmDXtEZh8AZg1Bhe7VoHbFOnpCMWkyLBR?=
 =?us-ascii?Q?ToQf2lthMCjsxDnDqy76rqc76f7Om2xvp+pQWlPFOONq27uXsGmNBjAGXUmd?=
 =?us-ascii?Q?B14mcAkAmTLn/yc5veYBRFrFqUZNqYS0QMglU7dW+npHj95zUvNi99lTrlaV?=
 =?us-ascii?Q?Sc2IuYbjO3jG56IwQN/th0DZFt+jLi57P96eOw1a4C5yCtDcv/if1AVsn4Sf?=
 =?us-ascii?Q?kmMZKB9f6I8NQDGqD0Fx7xbVoSL+2d0jgAU72GSMXJapKPBvjNg09wtKcpKR?=
 =?us-ascii?Q?/0OmN6yXvsqnWYAWqEzXy7avSHhNnoFcr062dOR+/T52t7OQwOEL6vLVpHuM?=
 =?us-ascii?Q?61bs3kyVQUFk4sM8iG6SJ+tT6t/5Os6HRBXYfq29sIdtInGf7GvpOnIMBRtp?=
 =?us-ascii?Q?zqqM8G3Iu5lvQxhXYGf1kcKd1OjbglHg3xscEZP0brpl6wEdY8xvrVZg/DWx?=
 =?us-ascii?Q?SAKFh5UzL5ALJbyFnvtIO16PeOw5FCQhCswQgkQI/iH9Mw/VicBpfGiR1bAK?=
 =?us-ascii?Q?2jNc/1eFSZKscfk6TxUVonCb5S5QXI7ucC/iMnuC9b5ZY14dzzHpThEhfwe9?=
 =?us-ascii?Q?9ISoTXVEPpO/ATT64t59wE5o2ZjMIEI14VXObjGJPwaajxLLKR8OL6UOxLCw?=
 =?us-ascii?Q?TjlT4b1vtFuvIXQxERE+KMrc0x9jdINdXVcs1x1TDMxcpaCpRFpMje/XVHAj?=
 =?us-ascii?Q?PYViLIb5cefvuE4DOT04pOt0G67N001vrby4L/2zzJNguDskt/qw0rJFCv/6?=
 =?us-ascii?Q?dELTDRMDgUtrQE7V5OGG3U4ssof7lAfbe2L0DB64G7rqODBE+9IkmQlJXzIK?=
 =?us-ascii?Q?Mxqk/6YqoJxlYN0EurG/mJ7UWm6Xd6jVbQqZHsbHF+p9vXTy59ROZiYVSyU9?=
 =?us-ascii?Q?IwBvoNljl+asnNUOruhAqGF/HsQbMShHyFnI6siLJrDZ+6tAEz6u9pWrxYQa?=
 =?us-ascii?Q?CR2uktCZm9pmp4VJVwxiPMQeIHPhdwYWwD+ltnKEGDn47seKE5FJ5UJ5WeVZ?=
 =?us-ascii?Q?g/gfiTWRxXOHK9HSwD8eug/uHPr3ZeBW8hcWrSGcX5NJVE1Q393DK9Vqf4yg?=
 =?us-ascii?Q?JKcfrwn4lvaBA6XCwCrTJ1KHcK6Bl8MgsgWEY10Qq6E2qVFqhSkBXJk781sm?=
 =?us-ascii?Q?qa4jYVia7sp4yOPfPTBs3Q8MBKhCuad+L+WmJM+bI3iw2oRnIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PcAExRj7jD39OTIqqfItZAAb54E8NblPzXEp//mAJ55yyby2f7zGRsPk557d?=
 =?us-ascii?Q?TG3iLc0yizODbkuiDdOBptXOibTa5aXt+O4gIbDmmO4KHbQE7oHLf1z+oaYv?=
 =?us-ascii?Q?NtdqfbAuGFaobIVJvIMxnQpjOFY20NRL7ZYK7xW0JRCS84MRBNbkkdcuZYFD?=
 =?us-ascii?Q?w1LL72gGwB+3hBVoICViCeoWri0HDkUdohz9DF7trkeXaIZY501tpc+Vhh6T?=
 =?us-ascii?Q?KKcat+yPnSUS4DWohk4Cu+04N7L+rRsWpFlju339FhhdUgNdBM7OSkOxBKB6?=
 =?us-ascii?Q?qXBun9CI87MdAlxLVP88PkxZMZzjZuqhhdXLL0tOefdb30yegxzEL7zpGnL7?=
 =?us-ascii?Q?KW7MCeufR0nCsfNZt1a5/4/kDkxdOhaX8SGj0GGQ7txei5CWOSYm8M8+lkx7?=
 =?us-ascii?Q?wEUZcTp6Gxvk8vZf+nj3EWoF0VRwrgwsp8T6l9P1WdPAaJtCs6q+31UMSURu?=
 =?us-ascii?Q?oe5RJWGCyXD9/C5ep/e+oUxRV5ZTAJhKa2/4KgFU3k4fKBZxwdCIQ73nIi0E?=
 =?us-ascii?Q?0EZMxj1qihpFjIZHaxjCSv7Uxlje1zTKHuYbnOuo/FFYtNquxr82kQGZK2QW?=
 =?us-ascii?Q?sP4AWw1N6SG7EEcAPRwssax7KKrUiVWUEWkDnIJnW8uXOuaZSWGSeidKqj/r?=
 =?us-ascii?Q?mj8cC0rGFQS3oEsT80sGapsWziyJKlJh2UraE5Ko0ko+ynCVqx2+m5WH4WQH?=
 =?us-ascii?Q?5/jjerOd4LtwboL/FH63yVTA61ynvSnSahOnmVGsbMmBBZyI1ThBvQSNG0X4?=
 =?us-ascii?Q?RABZ0qhQ/5A32pcjFXX3ZrK/2zLqrRwSkqEjshOQPg4EWr6dJjdcFHHHwySu?=
 =?us-ascii?Q?AS7unEnvXznPkiVWCBmQLEN0x16Qj33M13bZJ7jolg3uxOOcxJaR8yfkYRSR?=
 =?us-ascii?Q?NJZuDkyv8lN+2SI6A9RQLtqGLPKhF4mBOmmYGPyt7Nh571o6O08LgCyG4qcM?=
 =?us-ascii?Q?Ak3hI90ZKtgOJxUiv+eMTfJ1ksj8cb+VvaUaMOxHUj5QQ9+ibfocyZcl6SiR?=
 =?us-ascii?Q?hSLoLfcZULkH4asnTEbXm7Qvfju/kHHgJ7TGXuf8aMXoCkNl2nQ8Gp4zaJYw?=
 =?us-ascii?Q?uitQbu9uC2GfPjhwd0puT1ji2XWC0NxwjeoJ+1hHq+Pl3zdqUXvKFpvHEeKl?=
 =?us-ascii?Q?Mtn6Wo71rpR35v5A3jOkHEk2wGrkFLxOfnVw8Aet49oajBUaxcVBZEV/rFCv?=
 =?us-ascii?Q?PvOlbm41OKjgH8388LuLrPnvzrBGgAXHgNnIgiJReWnv22hK6EtKU4ExaFeP?=
 =?us-ascii?Q?bPgX4JbC/CQd0FikAIVYHxTwy+eJOBPeHLydB6JiZ2aLYTAkLEnV/YM13+Pw?=
 =?us-ascii?Q?LIaZVkpXpSGxloafSHz6VLgrA04AK3Cbvc9ZiE7CrMqZwJAh/2IYCfpnnnQB?=
 =?us-ascii?Q?rz6MmUnIwJvRkuGXiEwee11BhNKnnCg1+0J7J87FhDNCVBBQBLIpNHHd75hG?=
 =?us-ascii?Q?PPJAJkZPUr8g+YXU2M8XUm4YOlG9oMB82Be2y4ZRlY63Ovu9novOyOY8y0RX?=
 =?us-ascii?Q?qKDWoq7qHpKPy1c9Bqw+TZf1oxoiJApYezHthKx55uGMROs7UT0yPxTwgOWf?=
 =?us-ascii?Q?hz3+x3oCcJ1Ph0isFkhAKmVH+7EDYgJt9ja2P+Aw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6f3ac7-b9d0-4f01-fbda-08dccd8cf674
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:27:29.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZtLkJGI6BAxZjlNv3BQE6jmBpfAy1ziVLaL2EoXw7cb43nXLJgs5cQB1jD7v3f3zIGNfxsxDDcVASo/1wXoOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5162

Replace a comma between expression statements by a semicolon.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/mfd/atmel-flexcom.c | 2 +-
 drivers/mfd/rk8xx-core.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index b52f7ffdad35..d5df5466eaf5 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -95,7 +95,7 @@ static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
 	if (err)
 		return err;
 
-	val = FLEX_MR_OPMODE(ddata->opmode),
+	val = FLEX_MR_OPMODE(ddata->opmode);
 	writel(val, ddata->base + FLEX_MR);
 
 	clk_disable_unprepare(ddata->clk);
diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 39ab114ea669..c95de65c2f12 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -618,7 +618,7 @@ static int rk808_power_off(struct sys_off_data *data)
 		bit = DEV_OFF;
 		break;
 	case RK808_ID:
-		reg = RK808_DEVCTRL_REG,
+		reg = RK808_DEVCTRL_REG;
 		bit = DEV_OFF_RST;
 		break;
 	case RK809_ID:
-- 
2.17.1


