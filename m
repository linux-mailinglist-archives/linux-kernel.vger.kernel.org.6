Return-Path: <linux-kernel+bounces-298171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A9695C35D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7526028531F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E524B29;
	Fri, 23 Aug 2024 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZvD0YAH9"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABACBA46
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380879; cv=fail; b=svqqaAc5K8NfV7rDeCm514aiuvYH+BrLYn+v4OlN6YgQfJq7nJ3bC3DXZWDcD6QA6W2lsUvHRJpXysw6V2k5PPr15WRY9C9kEte1OSvtLGRVsri2eHkcaDJhb7OejeMe5t2UBHHwNjBvxPVNsBxD6IW9OjtIrMGJWpsrnFWcGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380879; c=relaxed/simple;
	bh=k/VHlbpsF6oNMfvIfv+LQ72LFhn/q+3KovvHW1Jlw/k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tuzg6O76JVJ0Xo51/BmhXiwDWQXy4w7+qzbdtZqZZNqB0B+gJkY0J40itv1HBltTo//yDfJUDyLSuX7szbnRl3op7L1qLxko+FLYW2gjmaEIic+Ace9vBuEMb72D06gUermER8kgbrkuQ4EU9i40w4HsxONybHvgKkrAvZBVn6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZvD0YAH9; arc=fail smtp.client-ip=40.107.255.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fgenum2up/9DK3NYrV3bg5qskQDYpkNIp0zziLKGSamCOD1plU9pSCd7D5Aa0KX4SBS++JYTxSXEfSuRUELBfo4SHRYaSMZFOdFOOnK1S7ClZf3/hAKdlRtkGL4PqogWJxIYxh2IXPizuVhu4/f01+1KaO1BAxrGWpQdbfLOFa+qHe5rOIgLiOs3iFHoeWLnREatz8vIkpQI+ZQWQTKP1gqZSP1xlIxaCcQTn42P5iR30waiOK3xcffiDcGNjdHDfv5G9W8NHdwD98CHk3S/sf29sZn1LNsGGamWm5U+zDBLJCNSz5QQ7YrZdpNnv18zrMVO919F7cKORroTuwQsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2B5Bbr51NeVvgRep9n1XX0/Ib9L+WSW1zbDuzGVwL8=;
 b=PEMCQeej3lKotDsL8l2csGC8siNoM71rPJlDzVMbiXsswpGUHdIeHamLVHFpB8i9q74as723wNI1JutJDJUKFwDmveS7SDThPTxr+/giZcNFB8EvrMyCgmtA1FP6SxF8TZb1y9ReSZ3BDCVWGnKMeJYVJ9LHsBxWtTfg9YkCJ01Ay9VZJyUHY4h7fBuLyrStHwZDCpDuF1twFYzFY6OTRLj2jDxcDDnfQirPJaoCzkzp4vKTxNqbA41hSNen/qMkIfyQrDZnWcfDiGfPx298z5oO6jyrfneaSqQUrOhIJF8oK7JdW6bE3J6lGeWik52+umKHN5dMgKav8yw36yFGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2B5Bbr51NeVvgRep9n1XX0/Ib9L+WSW1zbDuzGVwL8=;
 b=ZvD0YAH9YgpD1bdKcmoWmbl6StNXfzvVEEdw+SHmfIbPl9qo2vxozNbBDSnIW/VBdrfMuQUMO4X9WhLnpsnkQoy7AO+SBCiFIul7MSFt0Pnn8dO41mBrEQ9a5lk3ADocYqL9OYCSWtP6FL3B2pIFbSdp4TC4VpOoZ4hFs7mrKz9ZYvjf1KXckWyF87auqwuQeIRttp8F0GmHwGtcrXwOLv8dLIwYhuUBR19oG/LqhBPhKRYkgW8E79fDi15FoZTps/jBTgpSeTNzZYbj03curoJCTB6sftyecnpAqDDsMAhvkWHVhpJv8B0EZXQv0JLv+AeTBVqQB/r+Dv0MozZnCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEZPR06MB5095.apcprd06.prod.outlook.com (2603:1096:101:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 02:41:11 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:41:10 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3] platform/chrome: chromeos_laptop: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Fri, 23 Aug 2024 10:40:56 +0800
Message-Id: <20240823024056.3031644-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEZPR06MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 758dc9ce-8a0b-425e-fd9d-08dcc31d0c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vz4bTyCqTNU5wP1w/tKaUsr4B9ITCr4TYoZuH1f0icrQCTDgReFehjTDCDuf?=
 =?us-ascii?Q?It/2/bdJxynrtUmA9hVOJyeOMRbqjZGPzYdWZ5niqZMhm5K4UYaroftNH0YI?=
 =?us-ascii?Q?dc8V59lut9PN53ao3ubVClhN+JpBEcz615Rp78OPgc0bkmDh5K6P7eB3aUN3?=
 =?us-ascii?Q?fKnnTyPvhPDCBOKtE768zqdnUSvKw6w7DLAnocnQvHeHRuNiOB63nV+vwIuf?=
 =?us-ascii?Q?GzCAgq49qHbvahiPdNhI34TRB/IQoqGmSDTz4JNCmnQI59zM0bvO93efUFgG?=
 =?us-ascii?Q?WQTZWsPK9OqP01B6S9Ta+QuDOE/LyASoqdgkJ9dvGFfM3jxPl5VRwm86jlLt?=
 =?us-ascii?Q?meK1dKkDnTvPClIGkwgntchIL6nkLjpaKS/xZXMNqzokk7LA2UT1QbThonxu?=
 =?us-ascii?Q?YdAHHZBLzTCFw808B3S4mUlvAUPnaEhO4Paj/NLpa0FodB385XlH52uzu2y3?=
 =?us-ascii?Q?pT1tGwmxKvKuYsbpuv9mFlxtX/9iTXsl02NS35uahmbqWjar9fcdlZMEF+0c?=
 =?us-ascii?Q?A2KGWlvQyOa1NTI30BWKIxmmJROv4MU1KBswG2ijSP2OSIIJ2YpiPuyNIhFg?=
 =?us-ascii?Q?4kuuXD4qkgUxOef3ujcOdMOWTpAhGUqMF5jwPsVqdCKTwq/89t+caaUZpmmj?=
 =?us-ascii?Q?v3JDWKq0vpOG/obTP6IqiL8mt8cfowtR8LKQ8Sg50iG0BZTnBhjraJ47PY5C?=
 =?us-ascii?Q?QLfuTVFK9D+1WdmfjZt9vzKCtmmqAiOloPeTRuDgZh4Qmj0WRJYWWttQmJva?=
 =?us-ascii?Q?iFg0PigNOjNN6+3/oNvUI0oygkV9Y3GJdVic+dzMC0KfF9NOGs2tIwyRnqiB?=
 =?us-ascii?Q?WAlhN80f6EfyKxI7t0/+rQEerllPYHVzEknwUvDBuaQrlxwvjYZMAvlPJw4V?=
 =?us-ascii?Q?c0Pf4KIU8mVyYvFLDMHQ++3kAjTKDyKewChEAwNBZcR+NGxOmNTs8LXmy1HH?=
 =?us-ascii?Q?E08FiE5yUid+B2+Wd12wR0y5UzJH7hq2+5x2Lf0eC5aqVEZaZ7eP7a1XM1fW?=
 =?us-ascii?Q?wELeRFYEfrN3W/+W8b1Nro9Ds+86QkbwteyZXOHsoufV/k0FemUJeyVjJyrC?=
 =?us-ascii?Q?9LLo1vVx1itBfD9hrzUT7Aq4RTr2oJAioADbxsou4gQP8vtj0vpE81OxCha8?=
 =?us-ascii?Q?BlX6GPh+2naGezR1ngoatj4kUcWBGnOoqeH1acp4yn4xCPp/HXsZTcN+Urtw?=
 =?us-ascii?Q?wPzXXWjtB7dp9V3vQXbb4OQy+JO/Uhy5AaLGm2QnEJ5vKbSn50lJwkBVrkh1?=
 =?us-ascii?Q?3exDM1UydKQ15ytFIiwrpIbvwEBFikowNZQZZH4v9GhmqUGr9CP2OctymyTU?=
 =?us-ascii?Q?3GsNDCWAXH3sfZpODwoNLT74Zv6IRwwRerZY72vGmdTIkkvnrVktq2JJ74KN?=
 =?us-ascii?Q?uDk+EixZzjcn0SgaipEWXbrM6nerURDZzrKyhy+xh6Wc7KXuPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21UsbUtPup9QpLhmbXu3BCqaVWwvKnA1buY1mRPxJsreW3n0rBxPztwX2NH9?=
 =?us-ascii?Q?N/LNntkwdwEGohTv84cX/kPCIFXKZJXU4dDsXY9stCQTY9sUkKzMqKjhZLh8?=
 =?us-ascii?Q?OZFu4S7nAeoJWdKzxlnJ1Cd6pfmvDyTz3p2xJvYrCgRRNg9uhggQbySiMyby?=
 =?us-ascii?Q?k6ClO5YNg6Ty1hcgOqajGRUd8vOz5wjJPaXXI/46FGNtKKOKnK3f/we8SmyL?=
 =?us-ascii?Q?Q9kCnLdsz9udOFBI5U/OxYf5bGHEjImQcjahQbn8AqUcNm9403Nf6O/pyLC/?=
 =?us-ascii?Q?NrLaE/r9/XrWxNk++77Zd2gAJepD2TEjrresDhW9RvJzc0aVwPURmeDCZHAn?=
 =?us-ascii?Q?DSBm90vp4MzA8y0KcX/1JhFGV82jjFXTMVxOH2QCMKiAg8g+uGFBiJUgWf/n?=
 =?us-ascii?Q?Zsuo7N++Cdys51bdf+cBm1bSutonDLIEJvgjrFpXpAzFmOV0X7RtBP1tzONz?=
 =?us-ascii?Q?+DbXGi7Jdzrt5BIkZzXMvu5+w0Tnw18Q0SgTNO1cyM7WoRxcPH+LAS+TaZtf?=
 =?us-ascii?Q?bS6SMFvlmmW3dQImOID7FmmOZpLVqLZtGAJqk8xkebV7q4wVuDPpSfqjRTBF?=
 =?us-ascii?Q?HrjWLkLffaCrz/gGud8orydxxu9QhL0FIBsKzC0MpK5UDVG0fr5VgLgtZjWM?=
 =?us-ascii?Q?LerR2qEQXGVySXiQkn8+M788dZYyw/fiAdNwkRXy5q5pMJMAx+quRuE7YZ7W?=
 =?us-ascii?Q?wrTmKjcFjTg+i8+nKafwQ/dkQhp+t2GADEq6dnKTayEJEzINzGk8pr8JCxzH?=
 =?us-ascii?Q?pTprjsqfV8jhw5eeu2exsOsvhTRNdSUN5RpNBqcBo1EoTARLNR0vk+EsWTPq?=
 =?us-ascii?Q?AuTUa77bUDSRSpyYVuxEUe0JMGNJgV4yZ/DPYx8121BUQOq679JLXvpzth8w?=
 =?us-ascii?Q?w++GkUwbnUpFCEIvvBqg5fmCME/jsursBHQXhL79ZueRmTCDdNI/grJktZdG?=
 =?us-ascii?Q?a4BaPxk867etlf2ddZhPpQCXs66g81qvrAJXgQrtvsyp4Hf7amjZT4RiEYCN?=
 =?us-ascii?Q?SCQ46VdR7VRInMtPfOHVGwQ1V43xlNXDUEN0hUGZpbx8YFJJnu0wDCwMPp63?=
 =?us-ascii?Q?Lq2MEjv1lYYcQdot80A4V5OQ+gtcQKjTRCypUnhbs4fpwIq5HhO1lOucwBI8?=
 =?us-ascii?Q?WW4L6C+lYPwwwUG8duptwNvUg8S1S7Zl4bBVjRiVWW5wD2M2STrckYby3Uub?=
 =?us-ascii?Q?tbe4/I8TXhoDsE0WPARkcjhIMlH3gtT8aYQ7KMMSury/Zci2lnq46m76GzMN?=
 =?us-ascii?Q?9nBA8U+LoIbGGpvh0ZbmKX2NMPqBccjvztPBraprYt0C1+UpA4HdxkFaucZg?=
 =?us-ascii?Q?SpgwZbxOuak1BvLOTo5yH8sn9uJ5tKcalzwpOywzTSWPbjtcWpXnetAuBUQr?=
 =?us-ascii?Q?qQPcNGC9XlwdRozib/dKFqIoLfXIeepny30ivJfulV46WRFOyJotUcCuM27w?=
 =?us-ascii?Q?Co6Lkc4X7ttujCIS5mHMR7BxRY+B6UlM11S1qyyxWHP7kO9FaeK+TgjbuT6y?=
 =?us-ascii?Q?dXl0SEQlPDVBebrS7/9oX3a6TDiZXUaul2MdSKEa/KI6ErS79vmwPbVcFoQA?=
 =?us-ascii?Q?OZqNLzTpD8L/rgY3tAauiW3uGOU3cIq3BV7+gtJj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758dc9ce-8a0b-425e-fd9d-08dcc31d0c44
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:41:10.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Woasy7vRDu1daAAz02K+9xrpJFB+GmWPkZ3sUMJbGjQvhayqEq7qy2NeW/Mo0hNNGC8eK9Y7zN8Yn3Aa1Gpykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5095

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
v2:
- Use sizeof(*i2c_peripherals) instead of sizeof(*src->i2c_peripherals)
- Format code
v3:
- Fix R-b tag
- Move this information below ---
---
 drivers/platform/chrome/chromeos_laptop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index a2cdbfbaeae6..3ab668764383 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -749,10 +749,9 @@ chromeos_laptop_prepare_i2c_peripherals(struct chromeos_laptop *cros_laptop,
 	if (!src->num_i2c_peripherals)
 		return 0;
 
-	i2c_peripherals = kmemdup(src->i2c_peripherals,
-					      src->num_i2c_peripherals *
-					  sizeof(*src->i2c_peripherals),
-					  GFP_KERNEL);
+	i2c_peripherals = kmemdup_array(src->i2c_peripherals,
+					src->num_i2c_peripherals,
+					sizeof(*i2c_peripherals), GFP_KERNEL);
 	if (!i2c_peripherals)
 		return -ENOMEM;
 
-- 
2.34.1


