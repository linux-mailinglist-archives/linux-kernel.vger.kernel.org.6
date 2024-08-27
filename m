Return-Path: <linux-kernel+bounces-302734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36459602AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90DD1C222F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718F146D6A;
	Tue, 27 Aug 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ThqmIOqw"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010065.outbound.protection.outlook.com [52.101.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CBA8F58;
	Tue, 27 Aug 2024 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742303; cv=fail; b=HSTwz01lZu6Z759bYfgTQsBjinatVk5x90J7WrXcIMQbKuYG37rnqkqVxfQB7iQIVW6FWY91FJ3XCnCEThK0A2al2DrZ20zZ0otZShS94CI6StX3b8W2jW5aO1f4+ydLNs1ln0D9FXW3jk+nm2erKkCnFeObFrsjiucdO14EYZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742303; c=relaxed/simple;
	bh=JkoA0bEAF/3xPXpYVx/KeKC150LTAio+2bkekBMF5Us=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uRtMFdcZ44BharmaqqyE87Tfn64ZL8KC10omD3wGG+HaMbsXglTNSE+A+w0uKeDaT/sC+IXAjXdOI3T1rh/dQE0WmI4yVlVias2NNIs/R2RO4T5Qx+1FPdrcRmR5RKLRHjyXhlGbnwC33LZCdlrG3EAw9JTA7keZshoszgGS1jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ThqmIOqw; arc=fail smtp.client-ip=52.101.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+qOy5T3QfSval5gtFeAScppSPM5BUw1kAH+/BGiRfLlKIMXdlg7PimpwiZXDPR0bFMn0LInJhmy9HtsEFkvZCO7Qy9FcabsFe+3Ar7rX2u2N4A6+OeYCzmQDxEBvsROnHQ10FaJEsr246hdirmlwxUZFMcN6wTRTCIKIn/dEw5Ce32aiB63BD3DDoFZu77AWPxT8JOO8SF1vFnXvioFOslri7DVu2OC6KWL+3svoZ4RKep4qjFZrzBrekjUBcfdwPNwceV+gSSlod3tTTOLZljmvZ8cE+2pMwWXN2QpkdvpeeZIhuXd/aErw2Pt9U26YDh4K+xW6FddWP4S0C3/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmVDVWLCTpXHPeiMC/CIIBMIj0AnhLI63KeBOqjWimk=;
 b=svZVU1Mau/iOJp4FBTD8vZA+E0xIZ2GYV9itGnWvISQRTWmTnwGoToENvz/bkY/chBOQIi59+3p6mqkBahlkwScqvU2rGTS+kSdZuOrCfqDYq6lXvbMZlOIjYYNk7zyXQacwxkUZkxOmVxN89v0szfFOcP1QoVoIxyiwmUgY7KDeH9mYhsJ8kJSmPCt38DqVrdM+8rEhb+UvUCM1y3WMKksReCgx35g26rroPX/trzgA9K/JkYwqRERpnflH8fj/1MRJfZYxG7lgZpqyLH2DnpaE5svW3K215c8PIwM8NlSy40cDhfvbxpSSPq8BfLN4L63kIw7YGDeTOACgAuK4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmVDVWLCTpXHPeiMC/CIIBMIj0AnhLI63KeBOqjWimk=;
 b=ThqmIOqwaeUn3Fp27LG3eEWl2BgMd+yKfURraVJAchUzqCRscqNZ/z1z5BJuVO0Umez49PF2zometUQJCpLSYqAXcKxUqYSUHkErASw/0liq+5q4gN1v99CQukHjJ3m4Ri2A8HDU3ZIOqVRswHd+NZN6wY1bOlEGTJ4BZzAIX5AS1fY5eWogN1Y0j6RuEuXETca+lS8qIvDPTCZNzPC5UOD6Un6qxZXdJSnQTc6skpqJFmS8wYtDQI1eo97x6W3u1rbdTBCYr5sVOBxKzuDQawsEv2tEKNIaIUMUt4yMPQ5v8QqYgGIPTBTfMlfaekUPE8sQAGTix/3MNEgaoAlFGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB6753.apcprd06.prod.outlook.com (2603:1096:101:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:04:57 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:04:57 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: jim.cromie@gmail.com,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] hwmon: (pc87360) Use min() macro
Date: Tue, 27 Aug 2024 15:04:42 +0800
Message-Id: <20240827070442.40667-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc57dd2-7125-42d1-0555-08dcc6668f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5MeuyZabhAy+He/bBpBaT3OhI26IfDx87Fv0gxaph0z+MuIPxztx8AdZeXj2?=
 =?us-ascii?Q?Jj4UiVXC5EldcTfQSZ7IfWwDu8Xy0UIONbMyP/CsPaDM4ymYrV+J4fNlQRfF?=
 =?us-ascii?Q?G4DNGwdb8A7T7cMBfzrco42I3MnUYitEknNfEfAFeD/tIvox+WqEKefi5GQV?=
 =?us-ascii?Q?cWto6KPbqcqgZFLN8am/6SHZXSg+LOMDTyPcOyotYkJKW1a8DBFZ9ZfIzVbi?=
 =?us-ascii?Q?LAWrwzhJx8YncoiLNXLTKak+iWOhLnnIqFYKklDrmoKWnISf83PJLjxF3SSH?=
 =?us-ascii?Q?obxgdcjMzXMDbJungtj9RdkYPpxylekX6/UTQXQvi2zAY9OZuNxqiSTUhAav?=
 =?us-ascii?Q?A/KfYGDce2tMca68y2lT/uMKJ4THSNNUbR3ObJxxuMDG8uax1rHAde/hiiZ2?=
 =?us-ascii?Q?1hQJWhq+fEa4k5HN6l/Gt7VAGB0KHZk8BEsq156yLhiY6/ZncEs+5xbYHOUq?=
 =?us-ascii?Q?Zj3TXla8vKgGJ27A1+41QkWo9rZZIDjA7xyZeaH7xkQfXyMFg26n/Vy621rM?=
 =?us-ascii?Q?Zl43wB88dWHzaFf7WJUoF7xvc7/LjIJi79G77F+eWejYt6+1NydfQFHfbQ7T?=
 =?us-ascii?Q?CJsh9BFCyLC8fZCzd9HEuipX4uWIZclWQJ+wP2VzSOQvHPnwWu/KXKZkyacj?=
 =?us-ascii?Q?HYz5f9aPGsxvl2mLEgsEmLLdOBn1Hj205hYlv1xB8GWS+TrsaIaPl9J0en32?=
 =?us-ascii?Q?SH531kqeYOu70TUcP6mchTNTE3PgJzElU7fT1MrQHt9cLNtgRdlV8XeXKJf+?=
 =?us-ascii?Q?wc9XDlbD7kgSKCO9kWxqqgaXcjCywTlCroXojeauPg26xu+lnH9nvXs/qOGf?=
 =?us-ascii?Q?vHNdOHjt77/auJ54ndQYYjSC/w1bXUsETTwuMfpEpd/5FUyl94XG8IdP0+i4?=
 =?us-ascii?Q?OQseTdx87SQtgSxvpArcOBrfQxlXbqX/8vNibUH1lVIcLmLw0h3RNSaNRACe?=
 =?us-ascii?Q?q1f82+uGQiCNkUcFv5g80qykXkNwKFK58jrqt7m+82kO/4rc7C8jQF7QAyPX?=
 =?us-ascii?Q?DZN70m8GgyTCcGmCCnKfE4czOapKhi8IyazPrxjBIPfx9spONQM3qS43KRkS?=
 =?us-ascii?Q?H9enSsSvqK7FA8zBbGPrv5L/ey40ezoL5gmBVpNLcso7J9sPXEdvoMpWVSJv?=
 =?us-ascii?Q?v4TNOkGSlf+IgBVfrb6rUi0XjOsg2uVkfsmZcTrBfzqIxqGm1nchL29QS+ng?=
 =?us-ascii?Q?8CSDf12j6r6SAMldYFoNGfE95dYxRirDfuS0+0G4fugA6yAwY7rfIfHsIY8H?=
 =?us-ascii?Q?OXlGNawbBb/QvQ9XkNC8eTWdcuLOjMWaRmPMHLl+JxaCtbkz+aiG614R9mzF?=
 =?us-ascii?Q?Kt0AmzFXjVnuPxnfMnTrqswzNhYudMa3QIwLVyLsCw7QHjYOtJ43sJ+wQWw7?=
 =?us-ascii?Q?emzgjFd/PvNr6JWQ2zsta24+fbnutJf/hJuKUSiyw1ruVmmzOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+JTRSofiE0fpoZPulUJc3zRW/Yx3BCB5FuwjuF01NkCUsVN948TjcG95TD2?=
 =?us-ascii?Q?zfjI5+YLX5D2i6YMS3DAfrv1VGwQNFGLxj4yXzm9R3o5topgk7JWWce+YIlm?=
 =?us-ascii?Q?+oby3zm1Sl/EBxI4dSQQLngw4imuGYVJAIo5N6t74BI/+eFERXssGJuv4AgE?=
 =?us-ascii?Q?Mm8f8lEIHNOysoVp/UeT3UyQt6TqjTCCd2H8LXjdFlQNMP6kz8rm0N5Zh4rW?=
 =?us-ascii?Q?bYKl7QBnxMf1s3cnquD1Ph2v1IcAJ+SVQW6FpRyv4adptOynVGN2e/H3Kp0V?=
 =?us-ascii?Q?/sDQQz3++/XfrRdkn0Th8SikW1blgzq3L9G62BOype1R9kmUJLIhSnGfuAeU?=
 =?us-ascii?Q?n7OHJAwjCIoWE0RoyvXuUd0ynT7ZysgnDtyJcvOaIxp0FjY9ucTbmakdGwNJ?=
 =?us-ascii?Q?LrrVcX70DgwlD+D2CbMxMq1A/3s8CwZPOl/mfaybh2j2MiMC7AqAcRPx55Tf?=
 =?us-ascii?Q?kbiZERJyhQd3G+hhLyquSmIOWW0C4MKl7rP6rbvVHqr4sa5C1o77IDidgguO?=
 =?us-ascii?Q?3qMz5xK36SnPE3Do4KsvsELZBF4YF4rHKeZ6GxTzGQpgSf/ajnZEJ/U7S2q4?=
 =?us-ascii?Q?vIurJjeh/dW7SE9BYcTxGbhUouPhitrhF/XnO3+lrifCQxW2m6AcoWXFdYVi?=
 =?us-ascii?Q?4UT68mEqJRSZCJiLZ1UhlSyLHzjfC+3YpCbPfE7y0fP7jVEFq2X3D2LYF3wg?=
 =?us-ascii?Q?JYqg1skX3yp6XeuMj5BjjolDCmAshN2Gy1OxRMqvXqW2W+Q8rQetQESrkI5d?=
 =?us-ascii?Q?inX9vPiXAZmP8VJJaFjIh5QbdtU+m8XeJk9zqNWXY+cGqBbRJoLneDQ8F14t?=
 =?us-ascii?Q?081OpC2ArMLNKnZfJZwd0IVEZsaVBogtTNoUyELpSX+CMq24EDA/Th6cTb6d?=
 =?us-ascii?Q?aZDJmr8rHj8WXWheFvOrll3KZYfK9PrBWlXbJ7ZSi9TazArUQtYYy9F6YUWr?=
 =?us-ascii?Q?MtjJKMJjQA9XZ+2sI1Jj0DNQ3NieorP3WI2mZEoD0myECTTIZfbu7cXANVI9?=
 =?us-ascii?Q?rYsn6elvqzVeXOXzwyC6Nmj8Gzsc7hlo9zV1hqT+xSi5dvJviB8CI137miTA?=
 =?us-ascii?Q?mwokJ7ti7p/ifUfxhxyoccG+IB+R9hbrBNRys044lg+EWMfKk3AQU304INHB?=
 =?us-ascii?Q?5w5N+XUMQ8k7+vNVy6JgjyfchHdPvLiOK4DFIrU1frbC3vO26tmR1HRIohYD?=
 =?us-ascii?Q?2ybWvNlU/mJ4qE4Z6fTKzL0ZTa1e7ZdtbD767WU8FRNheFeqslXXuBxryUxe?=
 =?us-ascii?Q?qDOXPuvhpVG1uOAb399cuP2nPajBTnbLUIdJb/3UyWqNmibf0MJYhpKK2Kzs?=
 =?us-ascii?Q?sUff49u8Ls+HTUz8SinWUV2dd8FcNUECf3XXFvlKW6w0up5NlumtHaHnuin3?=
 =?us-ascii?Q?sKnfcSgcj6AKIapGfgss+HzxkpeZfHAXZ6Jvg0bxEGqfBsHksMkC3sj0OwYg?=
 =?us-ascii?Q?JuiPHgzvGgGtZV2pi0RF7ruAuwFZlID53Kro6WgXeevwVI6qR2RX1Ogm8WYQ?=
 =?us-ascii?Q?j3sSNWuzZuoEsjk/hV3P3qzcmuNFNaa+s2X++uY4bvJwdlS7XAk2+OlhQKj9?=
 =?us-ascii?Q?Z4DlnDLvOiXHShSja4GZ0s+pB4XZu2sTXXv7Ah4k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc57dd2-7125-42d1-0555-08dcc6668f7e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:04:57.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmSFkHEzFqgPSoU4x0STW4pwe2cE8y1ILH5ymq/xQjHoioQ62x3Mp5Agw4AfXCcOOI6lqkyu4lVVg6Ixyw6SKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6753

Use the min() macro to simplify the pc87360_init_device() function 
and improve its readability.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/hwmon/pc87360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 9e9681b2e8c5..788b5d58f77e 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1315,7 +1315,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 				    (reg & 0xC0) | 0x11);
 	}
 
-	nr = data->innr < 11 ? data->innr : 11;
+	nr = min(data->innr, 11);
 	for (i = 0; i < nr; i++) {
 		reg = pc87360_read_value(data, LD_IN, i,
 					 PC87365_REG_IN_STATUS);
-- 
2.17.1


