Return-Path: <linux-kernel+bounces-304528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82D962155
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D841F26E24
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971B15958A;
	Wed, 28 Aug 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Evoh5aPP"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2058.outbound.protection.outlook.com [40.107.215.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0286158DC3;
	Wed, 28 Aug 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830533; cv=fail; b=HdR5VGgrCO75Ora/WS6Uib8cjlzvXNCxmfLUYlx7uTQduO9xnJEUVBTg8xJXHmbk2xg7fyPRzpE1oHqrqpubs0qHWsqDdEBk3BDTw8EYyRp4wyB3KxG2dQiNS1f2D51jIKNfr+uu9Q83YRgCw5KyFOedIZKYNVU5A3r2hJ4PhpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830533; c=relaxed/simple;
	bh=LHb3XlHAyWqKYOdz13khk86aaMuhpE2x41dedWJGoF4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FQp2haMFnB0YOvbbED5cXWs6Cfz3R+OUuMT9y82qwokDZhcpTumiyRmpG5uppUWNj2s7b5LHlmENYtq+ZTNLPfje4IqeTL00eZYHqv4T4FndYJLHb2Lz1MvfFEM4q/yzGI1hLXnA+UHFTe3pK1vXkGqV3cfINk6I5XbeAG2Atno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Evoh5aPP; arc=fail smtp.client-ip=40.107.215.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDs7+cB2lWROOPlxLg7jVuEWFBhUx5hrJnZwDN5mdModZnSz1fbeBTWk0SaAMKy1oQ4HR4OZ1uJsHjY8Tj6rTqhP9qhgOvd4ay+nBQr2bMR7bNHc0ktEuXBN8jqADi70RUJ5iceDjE8VtKixogQtBEuhItb17XaythNUU2yRYn3mchx22yvxIt5u1v/ZnUrwjS8yV70npBkhKoqMerSLL6RUwBmPVqI0vMZC3brmWunW1aVsVn8SKDHY8JpvI3mvHv5nFvPhtupNCwVA5IiPpzuz7+DDfl+dU3eoonP4PsBJTXeqTDYwuDZoKPVu7sFxYr7opm9t0bBQZ6t9SXNynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk3syY9M69MI1gbG8uyqmMY7/mBAMEK8M3vb+AMvLmk=;
 b=u4bk+MJC/YU/C/QqR7HQqBMaFcAajPwRJh0nQRwc52iGjwjtPXlD6dlnY3nPF1Cy0quqESYLwDM8EfIWGi7Rui6gLGowpMfY/WawmbJnWRjcvrNbq5KRbx1Q5wG356q/MD8z8Z0ljnT0dDsmC5uvo7PllfWtM6ZEA3qbUwb4Rl6NufMQTU7e+S+2aV1UtmhNl8URtGa2OScToIwSrmLa4zdtuxh27m9tIIajBkMftNMaOfh9Jhcm9/ADIfwB89c6CmprSKfRdEulhBEwvg8lD8+0srYJt3bAEK6Czx3bpzjbEIRE93bYL7+U1lB9hUgkKWIKyQv7RifpDPIa0TIVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk3syY9M69MI1gbG8uyqmMY7/mBAMEK8M3vb+AMvLmk=;
 b=Evoh5aPPGJaFo/NBpI6ftW7yX5vIRSHjPHZzJq2RqzeiXDprpjnkhJG1rCYmoZAfI9ZD8HO0JUUfXWOMkaGKf+f4SGKUJHTZvlVwnpEHpLZq6ROIjHI66RdT0FZaa/KzB8OhrnhFd7pu2psIjShFHOdiBh+cWVqo3DwtwP0oVA1n9dn93hj0DNgfrOGqOD+9MUQaRS+hsztUUxOcNn9c9Bz2SnJ3PjSQe00CFRBu0W0NgA8mNTOY380+5fxtJr0pTLdKBJ9nQiEV/eodLmu5AOXYSkyOCPY1k7jTY5qyb5/dqD/FUHaXZ5p9Pe5qD51xYSXdAFtY0GmBpd1UNq9RuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 07:35:27 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:35:27 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: david@lechnology.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] clk:davinci: make use of dev_err_cast_probe()
Date: Wed, 28 Aug 2024 15:35:15 +0800
Message-Id: <20240828073515.950677-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|PUZPR06MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ca7eb5-8d59-4649-5a4e-08dcc733fc72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SREKQzq9DNQMZnef7jgU0hSXBxfDj9q+OOmYqTvsyIOLym9dgUdKV/H1l6fg?=
 =?us-ascii?Q?RYU2xv/QTIYTejNQ5Usd6J9PjgQqblyw+d1CpsntlgUpmeBx+8pYEcnz1DpA?=
 =?us-ascii?Q?LfsQpgDPRt7bFDD2N/bw1FKDK6qQD4UDidWVRyLaHyV1t4J0HozqO+UUlEhk?=
 =?us-ascii?Q?RmyHTIbfe1iN3MiRrNfPVELqiy8Vcrl1mfGTGWS+S/ou9HnO2XkjdQ6PBWHw?=
 =?us-ascii?Q?ZaTD8pAy8VYceLLEsz8TYOk0pCu302jvzmwg1EGfTgeEuNxs8SLZKD5C4rjn?=
 =?us-ascii?Q?NqehUwkEfKQN77omMAYsLyVICHSngDiU8XbXY3GVwtcDtORjs9z7K9IXNFvt?=
 =?us-ascii?Q?AjAAAotPnNqmiXcZ9Ci5Hl6OPaN1GgdI33lBkBHyW0wE5Bd83339a014OPU0?=
 =?us-ascii?Q?KKd3FH06qUoHHBekG6fKk92BwheeSKkfQjRIex9yEKFtsLyYID+C4KQlP1uX?=
 =?us-ascii?Q?LDsGBOaJV349T6JkY9Z0CCwx+nME3g+JRlNwz2aOoB0DBGFn/M4TDBClTDSH?=
 =?us-ascii?Q?ryKhENAyTQEg7ePryilwWf7giyr6yaIhTeGP3A8+HsVOJ2c7OTeFSpn+bFkc?=
 =?us-ascii?Q?eVk01hgaCsd3ZagrN8RTKBWGv5WAQnFHCHX7IdqvKUzopY7IyOUeXcmYelto?=
 =?us-ascii?Q?FaW6f0wXk0pGPqWu1e+lRmHCw62c9Ze8R00V3AghinabaXoewWshVlZbgiV8?=
 =?us-ascii?Q?AuJDjxhucmr42gcbFkAb8zbuN9YCJGLCsNUFo3v3kC7JrJx6EpfPHSQ7g4Sw?=
 =?us-ascii?Q?80Oph36p15ZwWVBDnUq+f2xJA4brXbokpgEYi4ne7sPQnP1rwIeEybv2WP/B?=
 =?us-ascii?Q?owxOfVM2gq6F3yyoRZcInFznjZL7N7PWf3YuajPs92zSfrmHnyw/ZVXi5AV1?=
 =?us-ascii?Q?foPlcjc1Rp25+gRAYg5Y+OH6k9E8NEy3twxqehPN1Od5tXgOo+xQ5YF+zKIu?=
 =?us-ascii?Q?NBhd6sCYDtfJYx8RHnFHNnTfeeGW+G6skau4HwDBvwCOV/2WVXtVcCT6iIff?=
 =?us-ascii?Q?/HOOYmEusL4K9amQbvXweZBnX6pBcoHWlMu/6IlwFrpiwCBaRiAeq/A9Rtrh?=
 =?us-ascii?Q?Zexn0LTnzUzHujiQTXKnyWHSp6/ajCaoHoxPvJSMEdl4LgvEhKdBJROhk4JG?=
 =?us-ascii?Q?HPHILkHVyr0PAHE3zHoTKpSjOyOVGueJCx7aVlrpFBy3pe8jw2PvWUuLullm?=
 =?us-ascii?Q?YUlxNaXmN8q4rt3imBvJft+D8yeH+9jvWL+qghnoHcmGI1nn1Z8hVsZAOx/z?=
 =?us-ascii?Q?VuUbJzb1Twym9oM9czAm8uwpThvQQiu9Q+8FV4jVIkA0YMYgJlLBIXUgCqGV?=
 =?us-ascii?Q?SZqKzGmowGibfQgcSXlYn/Rpr7zlvskzLPLydRzjw7qXmJltD+Qe54/VZoRD?=
 =?us-ascii?Q?IcPtFwwuqJdTkTnr9ppUFB5u0EWgew3rWUQisw69A+To4KBrpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrWNm12lqjiHw4L3iwEgXdYmt54s13GjQucH6jhqQXA7p94x+AKRFEXD57Zd?=
 =?us-ascii?Q?tpIJ2psL5MksXJx83W5hvdGkV5CJ+znWfaPthyTMvG8aqPur1Irlrv1cewDh?=
 =?us-ascii?Q?chszUaCHKvDKfptupadb2be1nwFUjcsx5CREPkX/7pUima3BjUszCDb2kZG/?=
 =?us-ascii?Q?tRWvRlgiaBtrQZooaulSIgGCcnBg39Tl8Ps+yN7AtwN3aqSjc865q3RZBJCh?=
 =?us-ascii?Q?7/azsb/XQ/iuA+NCyMejvyXx12LOTlld8OZC05+MNhArMDfDNOKtAwf93+BS?=
 =?us-ascii?Q?iIftVvTpy/jfykKwufWgJR9JnrSlxSU4RaqxzmTiDsGboTjg1TAHsPE8Au0Z?=
 =?us-ascii?Q?PJ50VxUOQRgLvlWUv29aeSTp8Wye4rw0BXaXZz3CcapLXyRMZ73JDHqsYgic?=
 =?us-ascii?Q?frUOdgKWw2xKY6IQUr9ghb7gVcwzF5jCQL7QgdVPY5FcN7/rK7VtcI49Xzez?=
 =?us-ascii?Q?h5kuk2pW1CIwekKJqM0ufjHFIdzj51OgOxa2MVlczCIFRxmbd5DKP8XkBhOg?=
 =?us-ascii?Q?LfhRG7nDUo3qAYhGwkbmUazTPLlX0uwVw+ygSapkFedUJQKukKN8IxkKCdtP?=
 =?us-ascii?Q?VPqTUwVa/wmhFRk9n241JpFNxmY6RBlFQMBrZeZdqK0JEksOOBmlkwvRdUNv?=
 =?us-ascii?Q?8KqDPkaXEoJ1gTWvvjKGNYHL7qLBAeIEdO9ow3n4hGseEo1TCEhfCKGuFR/U?=
 =?us-ascii?Q?OjFZwd1nOlSLSU0uKvSFI5KTqDouNMU+KM/VZIyaFjgrvZOmJ7n0pL+ZTTe9?=
 =?us-ascii?Q?AWzrdJisyLivhBJ3ZayUm/VX3HYnVa993QCZTQq2FTkfJxzX5I4oheR2thG8?=
 =?us-ascii?Q?sj0GsvZdB7VvSGmrzhY0sfvzQib5UI7CvrGbr6mrTOiArZECsq2IGa2fRlyF?=
 =?us-ascii?Q?2Nk4iUxjfFxKhrfzwfDA1sZqHNRNLmkTWkmR0h+2h6/uaM1NSaQEvLuWpAoC?=
 =?us-ascii?Q?BD7uGGZo5yB/+6YJ1zkt80w+swYO+Xm/YEwT0UKxTbDMQgzbKf7hLc50ZTUx?=
 =?us-ascii?Q?XUpGWm0R9g57ajnJaOnYmkVInvmKDt/mDKPW6ZtUghlZWedU/HN8Mc4B+Cvl?=
 =?us-ascii?Q?znkj7qG7uNZaLaei1irbYOwc/yOL/PCIcV3hcjdjN55TB/74unkY49tMYFF0?=
 =?us-ascii?Q?OyJLXHNRtqCXvpH1M7gdx7U+R+Eyh6wThV5udZjOfy/MhZN3ItVl1ceqxcMD?=
 =?us-ascii?Q?Q68Si2P2fMN2Oi3XO1NZ0JsbZQUWAJB0maO+9HP6KrCvXUfnAeckcSH51rOK?=
 =?us-ascii?Q?J+lm5eOTHz+1FflBW7r1DHwQML4SVSPvkxw1aGddd4xSCBWi4VAujOf/cuqa?=
 =?us-ascii?Q?ADO3pG4+ob4yqqfZGk9dWP9ArKbk06hn7/TsYRDielD4ZR5VSFRRidgNNb/8?=
 =?us-ascii?Q?tlYbDCDdzBTQoPST6GBfLb9LsZy7CD5GgdKf5DUp+OTab3ugvLH0ZkKaT8Iz?=
 =?us-ascii?Q?einOO7Ak1BTvqHI2b8SeFaKOkW0JD9JlNBJ4FAZ9IDG6UlwJicdkUc4gNamy?=
 =?us-ascii?Q?m8lEQ3KJoAlsAxsI8PC8Q7YVnsCRFxfa6f5qjPmEU+obcaIOY2f9e68CBH5y?=
 =?us-ascii?Q?nHLbxLsxJpK6oBcH3CWcNGoEYULI5hT1jrIFW0/t?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ca7eb5-8d59-4649-5a4e-08dcc733fc72
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:35:27.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TYBR4k3ARrYeoaakti+6JdJZQHiZZsVSckBKd8SZUk/Rm+t9CJ3ErQ8RlZmDHwxjbiPpSKBbEtIjV8+9S4MZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/clk/davinci/da8xx-cfgchip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index f6da66748573..a5109fe8b16e 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -513,8 +513,7 @@ da8xx_cfgchip_register_usb0_clk48(struct device *dev,
 
 	fck_clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(fck_clk)) {
-		dev_err_probe(dev, PTR_ERR(fck_clk), "Missing fck clock\n");
-		return ERR_CAST(fck_clk);
+		return dev_err_cast_probe(dev, fck_clk, "Missing fck clock\n");
 	}
 
 	usb0 = devm_kzalloc(dev, sizeof(*usb0), GFP_KERNEL);
-- 
2.34.1


