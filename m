Return-Path: <linux-kernel+bounces-295150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E819597B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB52B21BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B61B5329;
	Wed, 21 Aug 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YYMjRKK2"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010058.outbound.protection.outlook.com [52.101.128.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43371B5328
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229696; cv=fail; b=BxKLSUPlmI/S4cJcWsu+zoY0ZqqrhowWNs+crM5I3RXbkENjvqQ0DekztAw81TJtizwnj5reHTwaU3zYew32RD5eAkA68bQB8v3uJvKy0x1o6BnWS9KorVG5T41KYEsCWcROBa6XlHXZ1Y6eaMgXg21Mz2ivxZP44FJDewFFn5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229696; c=relaxed/simple;
	bh=MP+OiL+qHLX/foHZ1PmRCkVp6wdYenM+cd6YHxmdli4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dST7oe743n0zME9DyXnCnlUgK55BEjwyNYw6MRodWXuwc/gjwPDUyfjjiGcMnkWt3RPkE9HxsFCQgX1Jp29bgT1k9ZLeNzch1iJSw+u3gnUQ0X57T6LQYbH/FFJ7ISUxt2tvqbWXc8skUuNszXqhy2YOte0xyyxdcuG3v/OOYj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YYMjRKK2; arc=fail smtp.client-ip=52.101.128.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm/dk0gLHL0UyGXPLBwqHMzfUGPCmkKVF4Ab79xLZ/5urRizCOLwRCIfG6OBeCX8R6iN6f7Zg8u0LQ3YOck1H+8c9HsV65/x/8Wy0IzWOUktQA6PUhGl2SwyXwjYpUe7R8g8Bfidbyl9fttSfWBq6K03/Ira15dAw0GKdasLpCi8pDIYqrvOmRTdJSXKHUJhdTf/+krp/EZ6OrtdfnQP5FpP4bEw4ehGMr/HC+jg+NTQTb9ZF+g5Cj9RAh550P+lVChTl4WuOaChc8rkb/rAIRhFtg5SXkeHrSD+qzYArjbUOEwD5NxOCmuRlExlFeuLsQq4kwrsr5rmZuf9nVKkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONAkwLav0VFhhulhS+xP7QlcU6fQVnHab+LEI+Tpk58=;
 b=ZcenhPUYgU8bQN+Myu/0l+NoqG7EYxK7qe93Q/1U/S3ao1GWPzA7AO2ZdSxX3QxA6zHXXesrmwtjIwITHl4hrSzrmt6AW8wx5PkaWZPAG1o7EU0J6P+363MXHvoO+d4ofd21n2z0Nwc9Tny2Py1rHDeJjkQ/iVNt7h3Glc/rUw/SGh13ycqZO2mR6HLy0xgH1/GxHaMzWBF81DcSFQTsx7w9/KWWEsPRfZZgM/Y9OfTGn/4i5/ETzScUaIJbR4q6O4Pqvgcm7RrYh3+Mq+mY1tpoM4qtIwPX10AralLXibUQI6zc56K/jd8h9hKXTNkbI90Um1lcKUTDhwS2irGfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONAkwLav0VFhhulhS+xP7QlcU6fQVnHab+LEI+Tpk58=;
 b=YYMjRKK20GSGrojF5ADkis+ASBm+3Qqb+yFMuIQP5ybVcCxqPAhe5vNCh+jPHZz0txYRkUqBr1ctgElKf7TdMAlflso/BzMMBe7zjHyiruG6j1aVmPm4WGX44Gn2sqi3hnxWI3pGMLnngRYYJ3D+bcwNasG0cEGDp2no3lzZ93HovZELtCcsEZgQzlQFt0mELKrDT+a+4mBcvrxZLxYCKtyDHKw8gkONWSd/qfcZzgkZprlkS1q2rkfZwFlmN9uEfIZBQ5WgkG69YFbz7wUj8k3pPRBWnPwyAfXMU8FCM9wjf8zHCd+RvuHtd9qQ3sA2q/QPVDifqMpjdJnFFeTDqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 08:41:29 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 08:41:29 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] platform/chrome: chromeos_laptop: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 16:41:03 +0800
Message-Id: <20240821084104.21095-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0369.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::13) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cccc2e-3eeb-4ac4-6f71-08dcc1bd0d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uILvpkR5VjUcq/z30IvYpEOnkZer8ECr1mwgQTN4XcZ9wEixzMokuXDk40zO?=
 =?us-ascii?Q?J4upwdv+RdCY6p/BcbaYOXtjyPp49Prw9njBSLcrPCo0GzMoOzqnPUxUfOx5?=
 =?us-ascii?Q?RnMO08n+25qohhFNfrneQF8HZ8rpF/5z2lJRVOl7fluZEvO9ViITV5nmLzmH?=
 =?us-ascii?Q?ymPyw+/mPDFcGqdTGBb9FAa0z07iGid6kk9FWY7pYRWBApnDDHsnA9rW3lAe?=
 =?us-ascii?Q?amv8vzPqiL8dBhavhTlgMATzfQ3NVCgS4LLAMrCWAt/Jmdf6kMhCcVfqNagU?=
 =?us-ascii?Q?pbqv5W0B833uFKpJ7E6hqdjdMSGFs9INFwf9XqAjgAUS7bPXPpAAjZEYe+1V?=
 =?us-ascii?Q?9hnXg2r9Z/a9hR7IFHVDBhvqwarOFHEyB6MN6yyYyRwTB1h+2OxMbHbShAz8?=
 =?us-ascii?Q?jVri9alnV6NpejP+6YbMI3ou9itRHv+6TWjFBBFZt2F9GBBotU3GOZbLa7kL?=
 =?us-ascii?Q?0R1ChhRuiHmmfA22FEQA2jd+snZJrxIt7u8UbK3Qty1f9uy0SbP42bhLkiOY?=
 =?us-ascii?Q?SBSdvDOnJa3AnRwH3YF56EYGB3oueC2FsiQMSPFZcdVOOkjsD4TydNPMFgx2?=
 =?us-ascii?Q?5vB4Aafz2FSIOdkPabA1mdmsLs1FbaKbjFSO7mV9XffVk+cUT9Yf8G/9kDiK?=
 =?us-ascii?Q?+1RpgI7dKhe5lqAPHRZd626FiuZbihbRnx0by+ED1xgcK88jYcKLNtxM9q8E?=
 =?us-ascii?Q?05e/9Cy8JoTirqQ9v44E13U/YMTVAKPe/wVMy1orJH/KtAmbAWe/Bo6ffAUY?=
 =?us-ascii?Q?P/a78eAtvTEXRMZ50jYpD5lkC9Lzafsv82DxsRBQ0KxxydReuqIUh43f5GAE?=
 =?us-ascii?Q?DUcU0En4Ddf/3B2N96AHM7gQq5S58RW2BIy7stJBuDkpiu+rm6Lsti/qROSa?=
 =?us-ascii?Q?uwQOFg6Epydim+uuCQ0Bi3hBMQRvxyeCQ0SZ/Wnuhjp9pDUmvvYINqWHoBD6?=
 =?us-ascii?Q?h/V1hCRFcnZcS+d8bBoqVjHWnhzeQvqyZdDdp2fxDP5OIGahaQKZym9VRmGq?=
 =?us-ascii?Q?9oGqVWWoGqbqxa58NXpCFqlnArNqqLA+d/J/u1qB8rngCC30gqYlC3OOyXOM?=
 =?us-ascii?Q?C2mfa/G3vjufQa7gJVw2pwJ1nzXSedB/B8yGh3+IvNmqszE6SWNHtfgjBY9T?=
 =?us-ascii?Q?1CcxJ2couWJDbk6hzFzkCK76xAkolxt2+Ro7GljuYizpdNtTSN1HxWMSftw0?=
 =?us-ascii?Q?anWc2W3fey7vweRYVK4Q9ZbMebOoDynaLeT2TeEDNYp/qXcD0nmI5fJTNYYe?=
 =?us-ascii?Q?+BwNi9k1fFAUxp/b4tVfeOogu8bOORr6nCXxghMIvBvXO9hzQ0aL64e6iFAQ?=
 =?us-ascii?Q?o6/BbycpFchykX8AMJAqEfyzQpJrPOqjTAVXK6r4ZucRqQQLeSJX2Duj0sq9?=
 =?us-ascii?Q?cN26+V9SLXOxsEx8m1r2gsAVf6pKtmH/xLG5gCwtJ+PSjEMfPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t+l1o0AG6kjyUsUqN6aISenOreM3TwNzPsEoMlkZRx8cFVdhM1KlopIvmcy0?=
 =?us-ascii?Q?3wIaA8+EfGJPdQ4JmZQhajmn484HXC9kSPlBZCx4JQkdauB30kOE/QXSCfR6?=
 =?us-ascii?Q?Gvg0uKSmkGW+LG+5G3QlwSj7z2VokthH9rCYBkQQO/YkimjO90uSPtttUEaM?=
 =?us-ascii?Q?AyIaabJfLLRGtqLKEUVTxDNW7pA4Ya6nQ3qb9K+ohbbnrTnq5VdeT4BoWzmK?=
 =?us-ascii?Q?LrlDWCOaBhTMICP6C8Mj1RA//vqjBxIwYAI4Lr/2TdQNjQOktwXCi6EH48j4?=
 =?us-ascii?Q?daLK85sRfExQd/6ef8z4F/szRXhyk6VBYJTIbKhDEJ2hXkrIROM8kFAG8bxX?=
 =?us-ascii?Q?S4o6FC/zipLYidXjCTBdgAhgwgRmRELhInD+4hkWfNNyELd8gY5dc7CRwZO8?=
 =?us-ascii?Q?Vqbeh73okf18FuNnTVKqEzhruA0ZKfpSERswVFyQFnJjOp+EKxTpfLt3aoYY?=
 =?us-ascii?Q?Ie7lLNkwatfd5SEaG/1saqw9HfXwGhP+qqS3KyRz2YYbwR8z+aPz1uXVtn8m?=
 =?us-ascii?Q?mKLSaBcG4mSdsfbouYKxZTEXjkY4Y5DtvV57hitPI2Z96A6n0bDK6Zr/SK8l?=
 =?us-ascii?Q?6ZV/wStoYkLm7f0Rj4On/WhNjHCE0NDOTCzxFoWbWoTzmd/JCTlYChfuLeX6?=
 =?us-ascii?Q?4fbpplHxMjQwClc0/+VVkHZ5I5kNQz3x33kuUaIl741dvI0sMmCSZypoNBuj?=
 =?us-ascii?Q?blrqCnKFjta5DvJJEH1j0U7vo97knK01TyY0PAojdM/QGs/qqNtUbjzu2+96?=
 =?us-ascii?Q?XsGgy9QhuNTwa/nT01FEf50ssOhmzeVIb0QxYgc6+wkCw3sjeJnLqAQLoq1g?=
 =?us-ascii?Q?wSeXcfXJdjwoBpJwtGUo91LU+ifLp4F6bF/jLivBwKaYWbLyv3SLvlzuXE1d?=
 =?us-ascii?Q?UQH7j7kIyUNHbfV9lGLeOPB6IzhgbOhfhdlNDjDnAlTHo2kfl1Q7VODEoFNu?=
 =?us-ascii?Q?Xxw+Z0b1ISBtG4P3dXd5RTjuQdhRmVQ3kmu6kLd34K5Z5UiXK5NLdYKK/W6S?=
 =?us-ascii?Q?zFD8QTT5iaOQb/WOx1Rn4+gs+GnggQbbwcGxpiAwv81O36nxVeFmm399X+Qc?=
 =?us-ascii?Q?1P9S8bh4NyW2gvi6AeYqaSJMtD+4WidRI0OtHTQ+mmZwwesqBVAs65IL+FzE?=
 =?us-ascii?Q?ev0xjvEvvlcFFve0Db5ww3hBAvotlVSnZ+nRsWPRYpcWkf7jbtf1qChWfyYG?=
 =?us-ascii?Q?b9c6jbU5wT4ewSTMXwxrtklFyq+1889N1OBcKJkRmbl5UoeuGSAWb/xpjlyW?=
 =?us-ascii?Q?Uhv3QbMKROiYPjdiPDO9U1sMHLEoZsvbeXuEQyllU4TCdfXE2u2GpEaOZS/L?=
 =?us-ascii?Q?9tZuVAFgaOcYlI/d/Eqf1AXNpqRoCzFON5RC4xw1iShYFN2XJjm633KGhoFA?=
 =?us-ascii?Q?kuCM5QK50++2v7pZefQQDHnNqXyJ9Q/jbqv/WyZoGKPUWYdvkKHqVcQeTUV1?=
 =?us-ascii?Q?UE7wmTfmR3AhdhKclP0qx2Ry9YfMWfJ20xmAalr08dIiGpVpn56u5bzjmnJB?=
 =?us-ascii?Q?22VV9rGRa7zudvSXvpmaDHaBTKz5A6/fxpvlzA+k4OvaesBn2XYFtCBy0Tob?=
 =?us-ascii?Q?/WC8gK3uR2+nFaffpuz876ZUYNk2IbrJbYw2a3M0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cccc2e-3eeb-4ac4-6f71-08dcc1bd0d67
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:41:29.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3/uxAdx9Kh/rK1PNdfwMHXT4SDdE0WYRvng04gKK42iani42+IrV12lZ0bxwP1XYYAGwzOOUK4HxIrvQejF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index a2cdbfbaeae6..7bedd82dd3a5 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -749,10 +749,9 @@ chromeos_laptop_prepare_i2c_peripherals(struct chromeos_laptop *cros_laptop,
 	if (!src->num_i2c_peripherals)
 		return 0;
 
-	i2c_peripherals = kmemdup(src->i2c_peripherals,
-					      src->num_i2c_peripherals *
-					  sizeof(*src->i2c_peripherals),
-					  GFP_KERNEL);
+	i2c_peripherals =
+		kmemdup_array(src->i2c_peripherals, src->num_i2c_peripherals,
+			      sizeof(*src->i2c_peripherals), GFP_KERNEL);
 	if (!i2c_peripherals)
 		return -ENOMEM;
 
-- 
2.34.1


