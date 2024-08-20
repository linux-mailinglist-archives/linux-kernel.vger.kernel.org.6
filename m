Return-Path: <linux-kernel+bounces-293177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07BF957BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EBB1F22C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579A4502F;
	Tue, 20 Aug 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KMhOoO/1"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA52E57D;
	Tue, 20 Aug 2024 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122776; cv=fail; b=ts1F2wpT4MCpg6La+L6T1fjiYOy8CUD+x9jQilmhj/6cRVhbfSrGC7M+KhaeJE12+4iA4MveS8OZn6PmFwh0idaauYRKuoqmD+wbi3NUyMI14erWkiXGHuvyuyLnb2kpYdX5msHlGfskS017HuIk+4PjP1H8n54BQKf/xBMPaf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122776; c=relaxed/simple;
	bh=IBOoBaVNx9AKYPKA86p9a+Wl++9+ND1ueObtTsMBoUY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RsnAehOx4mYzjOAM6QOXr5ajcpXRnS3Js7rLsvWy2+Fpc3ZZS4UlIUj8uj2RbhjuWMfbsImNPOQfoKgR3QktccAppPXFs1AM0IE8ucn2aLgOPRr6GbpWsqdtw0GGTBaAeOfc7zZuSnmpA/NQyvwmWK5Bl+MbMWqY3Wa9zk0LuBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KMhOoO/1; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksoNfIGQ+iORrBWGgOd5GjA42apEJxhuQnTSBob2PmULngH5X6gqvvQsv8obJNAchj+z/HbSjO+Fd4U92D/AT7XI9ILuIVzbCXO7QsPruBDZN/804ouxfgECKuByUB8FfOY0jcdC5kmTaL14FOpErfGNOvwdegTrlTFN3Kp45aLyypjga4Q5Ryp0gKC6sqxhLBFewkzXk/aSi0M3RCM4jHx+y2II1dzhoqNRS8R3JliXsfkTa90F6DHvddlBf0s7mrmWlG9ouXeEuDFkCj99rFRheCIxkTvzT2GibFUaaE0AUiKT1bRBuljcdL997zX2rkKbmxVJEALTVMsrIeVBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IhBHtjhViEJCXGGxvgJMrhPHotzBLw8UYtdsZzBkN4=;
 b=RESGObqVcI3n+gmsXorKRHPYQ9TBQzfZXBmSLHpWnprFwXdE8roKoGPN8MlhqId0jFdh4SdnqAj2P/0w9RQ5bYlpTtz/jg2XPEr951lPWGs+Xze0jjknGix1DpJlnqZjfu98wnKxRgm+6ZdvVVMJnoqNwqVN2iNs9WQ+tnCxLioe6H/yFSgWf6awV7g8aXmUgkEBadVCpWPVonqkDsU3Axg8bJC6x1X3ILsAolOogtHjJbuylaegLZggO/FGN3qiy7R+RLmGWTmXcRemvi4aACTXkhspPz+fDCnZM+aVHy4872p1vg+XK8uOXwrn+JQ4xqtaRTuYGcR2fsWll1SviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IhBHtjhViEJCXGGxvgJMrhPHotzBLw8UYtdsZzBkN4=;
 b=KMhOoO/1eYjq7bsZcWZIGDhiOUBTs0NpTkGa9HVwJQRgSgc8uA8OdX9ZOWOOWi2Gt+Pr3fX4d2/7Wb16Kh06kj9a9sJxbgGJtWoEJxb6D+5RacJN6zZ5O98oUuQDmCv42syacyOb0osUaKMSCaYilnDanmvIpei99ey6zWqcJ1rlvZ0IBKaHG++qWz9YxBj5RfSE0G9jYtYqbLhFnAQ2NdQIGnL3+k4XPT6tCEyGEUE9GR+ik00KNxnCEy8lIJ6w13gFqLs66YvShnSafoNaZtCEB8Y0zra2pA0RYf4If/pRswEHhOSbaw4D+UG8eNtG1hroRlsOFC9u9Jfr4/lQMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by SEYPR06MB5858.apcprd06.prod.outlook.com (2603:1096:101:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 02:59:29 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%7]) with mapi id 15.20.7849.021; Tue, 20 Aug 2024
 02:59:29 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	sboyd@kernel.org
Cc: peng.fan@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shengjiu.wang@nxp.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] clk:clk-imx8-acm:fix wrong pointer check in clk_imx_acm_attach_pm_domains()
Date: Tue, 20 Aug 2024 10:59:02 +0800
Message-Id: <20240820025902.2355565-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0188.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::20) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|SEYPR06MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a6034f-1b03-4b96-66df-08dcc0c41b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qomo7WYBbQJw1fSYGQFOrylWMeRMj3SQhf7oO83EM++sP23criWnwA4pGKjf?=
 =?us-ascii?Q?PLpJESxnmRZfo3szFrkToFS2jQzDqQGkTavZobPow1NZiUPrK/D4UIjq4oEk?=
 =?us-ascii?Q?ermNTk058nY6yx2hBf6H7hS4wF0AdX3DqJBT7mTuZJk1MADB2CmFAuzJlayA?=
 =?us-ascii?Q?T5TXnZt0dE2l5hnWh/Lvr1OTJNTtglDLME/KmrXccFljmrfWswZ1YBGFPVYT?=
 =?us-ascii?Q?t1YS7MJ301Z0NWkE1KCUB+tCuNWOjQHiAjRHhYMJg6mrfmLbcENunV4wtyVT?=
 =?us-ascii?Q?KttoL4P8XJx3wzHY0sOUGncJhW9URcqPQU0CgFPrOrM/NznY6q1aWMatIS2M?=
 =?us-ascii?Q?ZbygmZiicC6zkgn6xqMn+XNw+GI9zhM1BXbdl8mYwvTl/KerOXIjJ+tvMLZ1?=
 =?us-ascii?Q?lwfq8WEMM78d/BYZ/XYLqISm9dcoltuZgEpm7FMLAQJor8MER9PyyLdvdoQy?=
 =?us-ascii?Q?b5Ss0LCABn+TLR7z9+Bs54pTyZOoi3xCy9klWpF+CZdTZb4nGt/VrfkDb/wV?=
 =?us-ascii?Q?0mXZGIBMxOOCaqF6pOmgAbTXFezf0MS/h5cEy/8woBfxroTmWGqY7PsTcFOW?=
 =?us-ascii?Q?/x5HWm3RDOXFqAKC+bgGv0w+rZhRbaNK+hZfikYbdeJPcIPLqXdQ0CRyKCSl?=
 =?us-ascii?Q?IpAlVTnLSYoOgJC3tjtUMlDwqfgtcENlCs5nQo6RP9rRngR2fYqsaChySqzw?=
 =?us-ascii?Q?zDNry6K7N8xk9aH30/Z0TO9dM5YPCysiWZO+zPtvx5oNHGaw93DuZLKsQkyy?=
 =?us-ascii?Q?JioDGHavdB7tKAZlCVLdAL5VDPplC52eS9J1GaO/DdK5YfGIpENeQOLlq/No?=
 =?us-ascii?Q?kylTCn6UkxOqcxLbGuBIadAWoMpwsECyxSmSx4fP2Ptlc36+2GzbLosObXSu?=
 =?us-ascii?Q?L30dSV+hF9V7KaeLgKqgwdyp3EacRUYltX78HfXS6rRxoGXSDrxauDbTAdW3?=
 =?us-ascii?Q?7MNO7Zx+na6f15uySZmrjk1pitU0sP3AafKk/Bgge2DgwqecfCkPodveIN8s?=
 =?us-ascii?Q?0bsZSOIu0g596i7Iw+4hWByf03kjIpf1iwHd/4dIyUNgsxEGDgQEfc5KYdZW?=
 =?us-ascii?Q?lfsRlg0VMim+dqrhnRQczyfmbIIEhsxWN40olX8UfkuRu98l6IaHEF14/Dm0?=
 =?us-ascii?Q?6qXJ9y+ieJHbBqeagxkv7s0rEMFxpT+yjsPEVDiVHjnGAFAxneeW4SHe4oS7?=
 =?us-ascii?Q?DhvyYH83+O/8QHmGnKMrXxKgg6JV6ZY5XIh4Kd3bVxt10heUCL4EPh60ItDC?=
 =?us-ascii?Q?795g4k88Lub4L2KyhNFHnf3K1xgff4hjQH8kip9s1J2MtEEmQR/nAtC9GuHg?=
 =?us-ascii?Q?ukyMvmgiaMgKJ152VoiMaDbWXwSAaKBq6kaoW0S0pdl0lWgrASjy5KQ2LGAm?=
 =?us-ascii?Q?xnG322aoBxtWpS8jAsf5rwL/1MJpheN1sZI5lB6r3rsL2Nqkiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b64ZQM9tKEPlyr/F/iD5NmugMAGq7x3EQXHNCsfr975WsOMb7/Pdj5dXmQpV?=
 =?us-ascii?Q?QXN1HuDCmVLDVvwjXv6HHJre53ZdGx5OMkAUsMpAOzbCG4Z4u6HFtDWhYoUu?=
 =?us-ascii?Q?jzTNk+go/FJYWO7bz4bpLWjbi7xe/L0krHammQZRVN6wsKCHJ+skgQwJi8PN?=
 =?us-ascii?Q?j3I/gznppr8S1g6wgHcMmUnAxhwuDFQZyRnbx0hqHrqvwj3vTpsLbbOkMaIe?=
 =?us-ascii?Q?ocOVYFkVOHlc4kB3KpvBQ74RtBJ1rgpyWOjJHb0T7sISW4BPO6KxTstXiQA1?=
 =?us-ascii?Q?1ujS1PDV8RKYmyx0FJfHw3PYPYXJG9coI2OG4T7cKC7EQB85tkPl5wizyD+4?=
 =?us-ascii?Q?WWudjoPB74hOklLdqe5KWMwS6rUSlfOZEAczVgkF8WRyTWQZQgc+sRikfOF1?=
 =?us-ascii?Q?q7ijuSmqgGGCU2SMROoZrTrIxTTkxHBWXR662NO+ruWW5Fqii/+3677JPpfT?=
 =?us-ascii?Q?0Ez476Jm3SGmhGiiGKPG9PUMf76TkVquxZLc7y4CqgU9NpRAaMnWzV2SyHFR?=
 =?us-ascii?Q?LwUpkEpa/KAwbNjtLcn+z/5cp04hUFDBC8BvO1r+fdsoq8I5tf78xnHg1Wtg?=
 =?us-ascii?Q?2B92gUpOypWYlAhfuHlrqBhcb07Pg0qFuiQ8h4XfW9s8bqYv0P+ynv2AzF+a?=
 =?us-ascii?Q?xGyDfQc9E1ccV7/beu+qtsDkDK2/UwxPaqrD/T5YoICtx0bXOoqINeI7b7vq?=
 =?us-ascii?Q?MdIWkIb44furOs00Kn45e9hgCKD9+Chd0o9oxLBxUBD9DrWmCSdyE6q1r/la?=
 =?us-ascii?Q?GwsAAm4bUSRGZi/Bpo2DgEEvaB1VxOawPlr0FYoD9l6mE5oNAVwuNQuWOS57?=
 =?us-ascii?Q?ONVTYB+jSXN/7P+Wssy8Q1tGi1g/sm+8z3RQYidSKtadoNzK0HiblxE7n4ky?=
 =?us-ascii?Q?hdCnMZH9d3tOmoxHYwqnNYwVdsomNIHhaauOBGRcu3XLSPsPhLMS/7Jgs1Mz?=
 =?us-ascii?Q?ItnxnfhuzSnxC7Y9tuGpysqKgkrwxvBPuJxMbHTNT/kyNDANL02ZmWsj9spz?=
 =?us-ascii?Q?b1N9hM9WwqrMaBugLFJdsOZBGvDMhlr3tmni91FbpvG9Kf7xRvXVqDiJuTwA?=
 =?us-ascii?Q?r1Pq4LuPdnMn0cDI/PZa5tNqWsuB5yswKGvUnuoFF0OZYJQCo6OOFs46VRn2?=
 =?us-ascii?Q?2Sozv3s94sAI6m5cK36E9czdNnTr+ytdld+SLm8KiJSG7gSN1OgwXAM7kiDP?=
 =?us-ascii?Q?P1g6RPdF9HjbodxNz7Cy5rDlwK4CfX97vuGAgeHR4Pa40vpCxeEvQpDCj4Wn?=
 =?us-ascii?Q?k2ODq9gzDkuUK+jcrSYYC7WW9L05qRiQi6dncSqHB+OiJuFoJC5TPIOXsB6t?=
 =?us-ascii?Q?qvvScsUfgz3EeFnkj1Y7ex+Nn/M8oyqnYHE9uPPAWd4WhdFvKqNe0j5UTYQf?=
 =?us-ascii?Q?SgxZiwWcmn8xe45GxSPIlQcKdbnJ/2A8XfpdsEP2ZPbxqFAgQKY1fDh2wDFB?=
 =?us-ascii?Q?rFOePyOwEXlZnloSjR1FLCZAKBKE7NLSWwtSQy4terEiPIVASCL/hMWz1yNj?=
 =?us-ascii?Q?xjtCcB3l076YcQbbAgpJ+/+TIxyLPYAO1xVNKPiBjdhw68qZNKGtU91VhdxE?=
 =?us-ascii?Q?MJVj7tz5bLnvaeE6EjE+9ge/oueq4zoFfkAI+rOe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a6034f-1b03-4b96-66df-08dcc0c41b81
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 02:59:28.9321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYkAQAvY0IVkXlX7ZpN/WJnwQ7eieX7fv/A2GPlKPBK7CWcBM0Jqo1zF9lfZ4cxcf92Sb1MkoJVGO59sgDAHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5858

device_link_add() returns NULL pointer not PTR_ERR() when it fails,so
replace the IS_ERR() check with NULL pointer check.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/clk/imx/clk-imx8-acm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 1bdb480cc96c..ed8cad8d6a57 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -289,7 +289,7 @@ static int clk_imx_acm_attach_pm_domains(struct device *dev,
 							 DL_FLAG_STATELESS |
 							 DL_FLAG_PM_RUNTIME |
 							 DL_FLAG_RPM_ACTIVE);
-		if (IS_ERR(dev_pm->pd_dev_link[i])) {
+		if (!dev_pm->pd_dev_link[i]) {
 			dev_pm_domain_detach(dev_pm->pd_dev[i], false);
 			ret = PTR_ERR(dev_pm->pd_dev_link[i]);
 			goto detach_pm;
-- 
2.34.1


