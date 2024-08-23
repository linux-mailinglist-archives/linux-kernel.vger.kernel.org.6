Return-Path: <linux-kernel+bounces-298655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9295C9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAC4284404
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26F16BE14;
	Fri, 23 Aug 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ETjU1/u7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19315FA7B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407648; cv=fail; b=bqM8kR7upgrnd7oXPQ2e5oTHvNW/+kCMOvkoYE2llyG8zXUelCLaAzxoYnSlY42mNOI4o/hz1shNxrF2pKRcR6sXIHaePb9qZUUhGGULOnPgXbi574FD0F7DrFZ1/syNbs9lE/0qILOzgBXXGp/Pjbl96Vfr0e1R65qJT8m4QYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407648; c=relaxed/simple;
	bh=4PfRyMmKG+mPeQdDstye/hc3bL88gD4jHhXsTnqjEO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvcB4W9bAPx06yBDawDh4UnApppgDloK3GFb/9JAMpYjow7ADF43CChjCC2xWpVrvJZHFpTIrGXyHJBhfhMjcF34zB1hRcIMFqKrxbSTsRqd4fvG5r1fHBQip86EZcKbvcozmvxQn28wxyyBJF1N9ngXZ0O13jrpEhE8olU2u1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ETjU1/u7; arc=fail smtp.client-ip=40.107.215.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM2y24Dto+i3ofkwWItDaAkYgTqNpKHMOpaMdU+qG4JpgiSdoE1ZENqxNK0RO16p4Sgn0Plz3bi4casEnT8LZZIGdHCX8n5VqEBCwwDviCVvM7cV+cmbGJsh2MlI6hBKs7kHtrnC1tBI44yzbfici3dYPiRrstaQ4MgYmGJAROIeFNTd2GgBrbfPP/bJP70wyGveb3aV6NmC5ZQTP4Nsxmk4PB1H0Hi8jkb0QnXTewJbgAEIx9noD3jntqjESLUi8k8e1Zs2YnqTVwrg2Mn/OsxhAA7IikxMzVga1S9x39Nv44SeFoWPtXyR5GLSh0CTqXOJI4gW+QIZCRBJ6m1b2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBvWYkQXqq4/BmGVStz9xprVOkVflEx7dUpoGC3yRhY=;
 b=rL+epGlmVaoelk8g8/UxeyT08rn/H9jNWcDFkolGBUskuv66a48ET+0WwaoINUBNSRKqJ1j+UPS1oC5CvXD7WyeP7L7qX2ZzofSTtNmyKkqRsJA639+i3WzhHh4ZQ9+YWjnJ/6z2yLOud7Uo1Okk3NfTPxbiiSRWKMVCly+tP0oQbBEiOHnnRxkW8hwCAxEps0ba1Obao1zE3hSzka+ejUAch5/OClQ9uctFHSlnXGjF1LBcHxXp312W1mWMVLqR/1HuIyOjLvpJgLF+vyPrkH11WBoQAIngZ6uJ8yv89BUop9C3xnT4Hnp0HEZNJVnwDZngjb/JNWBqGXtfRKsIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBvWYkQXqq4/BmGVStz9xprVOkVflEx7dUpoGC3yRhY=;
 b=ETjU1/u7IVj92wwbe3YGrVZu+ikCjiVsyeTsojBTQM2XfPdmkh9aqUN5mv5DY3k5lQsQvq+vj/adID6Cmo/bjtkGqAAynnjhzCTiLikr18rZULAjkRa9K8u8FdiF/QCiSpHPSe6XAe3KD+J21vY3GZP7m6f/OVldN/2S+Zzqr0nGLUPWLMyPfO0C0cIyqjwWVAutgZ7aJuVamJ6b4/265f2IlbHFFc/5Wznu0TRgSTB2fDgV8sMA+dSiTJUVdI3RX/Wevn7GYSvQU1Qc/LUpiDWtkRJVBOPLadSylsH7UdQ6vqTHKWkqR0hxDIKqGWfpYp2z2C2bj6cUh2ma9ZTpdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TY0PR06MB6854.apcprd06.prod.outlook.com (2603:1096:405:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 10:07:20 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 10:07:20 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 2/2] bus: imx-weim: change to use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 04:22:11 -0600
Message-Id: <9bcf916828934b497ea13d27405105159aef1bff.1724408198.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6afc96fc30403966d9be783c659b422186000a86.1724408198.git.bo.wu@vivo.com>
References: <6afc96fc30403966d9be783c659b422186000a86.1724408198.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TY0PR06MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7d596c-713a-4dc3-0ba2-08dcc35b5fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1+RC4tZ/EEWgcch3KRaeX80YsTReF61gfFo/ctIsC6LAinYpnXiWFl8iUpUp?=
 =?us-ascii?Q?idW+03mYTW5yFoBv52eFtI+db77GFCPLyB4PFQXFHChYNH2eY9jpSIVtReqt?=
 =?us-ascii?Q?dPqpxo0ubF8F5qXvqVSaOwbmSkSJUZQKs4E8IoroGWMtgFdIlnJgX+yDWJux?=
 =?us-ascii?Q?gWfikRcBEyr3Nl/v7G4ylmUacq+XoDWdGmOD4ZqLw0efocs0+kbcCvK0bmP8?=
 =?us-ascii?Q?7kvlc8lJzSIq3j9jyg7BCxdr/Zu3upnsQCOnfpMFHDAtf6c4zs4Wg0Nq+t8E?=
 =?us-ascii?Q?o0/z3P4HAGSyLwh6UlIQbMEPIWmAdxKDuRGBTU8E5y4qkuL55wg8nTllOtdF?=
 =?us-ascii?Q?I+ypDv5iy7buPwClIUX+QlUgzjT8elUCI2dl7f/qFN0SeY1c9UngCBwnlCIA?=
 =?us-ascii?Q?xDyjaEuV5uVCHLii2a8+i+GLgfTe2HtWiEY7pzVV5/IlzqmunvaXjYNjJlZ0?=
 =?us-ascii?Q?tCA5fYB+GnhwvE9lbFsHvnksaYwXS1GA6teESGcWKhSVfCVU3Noaw/m2H5nN?=
 =?us-ascii?Q?vhoPvWo8PkFWWkqeEnlliQUacPmA5t0cGO5da7iArdawqETWjcYM/BZd72pM?=
 =?us-ascii?Q?J8CNWTucNu830scEjqin3erEtkNMSavooqqBNx2TmaE0uE05dogIQIoeAGO8?=
 =?us-ascii?Q?AsbTFgU2tDIC2uPbdn/0Nx3GcQLh1QupKZ/4Huy1y+9eTVFGTocNebSvHmHe?=
 =?us-ascii?Q?9sb27s+UgPWmlR7jvzhDmyMUCZYRQh59dWbyBTa89JevU6t0ayEP4Qw+g+ON?=
 =?us-ascii?Q?7BWgb5co6YJLzga7qIzj1E9ZZpQTCJs2U+G/OQ/Uvriv2fqPd8pcyUpyNnDc?=
 =?us-ascii?Q?uOj4as37KzN58Y0weofFTITo0vKmzmn8ZUiZTx4K/ICiX3weRg4JueJXalgc?=
 =?us-ascii?Q?BMV8kyIIVH32UV+8FeMmlbxt5t8Z/MU3N0aJnPV+GiRvLlKRkU8XyUlRvXKW?=
 =?us-ascii?Q?JrLGYiUQ9jVGxiPcuwZ7tBIyf98sFSbSzjk/hKShXa6mSvtJUd2LriIu7y4u?=
 =?us-ascii?Q?hMxIhRg5WEVpYk4XnmKRIsg7M7fXoOvcgSheexMSJE6LgiCneAMlViASq30W?=
 =?us-ascii?Q?XPzH7UYLN2+AKK7HBRe7Ko3JjZvm6vdzkGGO8tCtLg/dc7h5lN3a7B5G+GPp?=
 =?us-ascii?Q?Dc9M/KDUnNNZGR3KAZvVOFSMFE71q/IUrJN8NmqczerEP4+1vl957dSwPrZ0?=
 =?us-ascii?Q?CLuLQvbA5EIKHY0B0jMfMbJNQ1IE8QrfnkiUoh2e380ddetyNtt1GHiffUun?=
 =?us-ascii?Q?agx5evFYMSec1ApvJVWz/jxhVPE5VJgOyzg/e222dEpQC16Cb4Z/ESKlliWK?=
 =?us-ascii?Q?QYEv2MFsCyqcOqf1ZKpGQjANwVB0Hx5rziStJfJVel+yRyGOdHYjz6QrMV7m?=
 =?us-ascii?Q?2Q/mMeFhkycL+yx4uLPrgWzj01MYs5jan2h9ZpwleF90UCBunQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GEKc/l1S22FdOuGv2AaCAwx7LjL0eofVD2KYTFix3ZnzW6vLMMn6floC4ElP?=
 =?us-ascii?Q?pDjuk2hY0JFIrIcZB6u4ZWhBijy6xtL0hOLRlkQaWBZL9POY17w8H0dOhRQi?=
 =?us-ascii?Q?JfQiAdEkCMzBthAgBy3CcAuSmFme0AysUPTfMgraYYKMr1Vab6tviI1F0bz0?=
 =?us-ascii?Q?GW1cwkXqoWrbALLPn9qHsPISfg1cCTiF7s4QzgTd6RPxZVZlyz6LiSrLeCZi?=
 =?us-ascii?Q?kFpLqk9chMIuHKfOZGmCMNev1mMrWPEtYeNHZpfsH6KN8pPAtMSCibKoiZ/n?=
 =?us-ascii?Q?SPnGAD1jnQjoGO8vwOyM7Y6w0Q3L8M3CUf8aMMQst+eHuUI99ceSMSpI05Sx?=
 =?us-ascii?Q?vENexIdfN5Hi+QoaFr8ZVM53bB9HQhnIavUE2TqheitvIRgIRUjKSrguPqzt?=
 =?us-ascii?Q?LUzKCYi6rjBTtai1FtlBgor7oEe8yBDXB7rajKsj1yhYzKYuNNnYJuq5SD/O?=
 =?us-ascii?Q?UIxsQV7IeX0uky4l9FW5osNEbF2mFMKGL/hLxTWz0wff4jj7C+aLhToN1CEZ?=
 =?us-ascii?Q?ekxaomb0+a1lgmXvUyWBUncMUV0hETvzggYpeCjbkA/s8WL518RMSu80U0cp?=
 =?us-ascii?Q?mQ+JFbcdHdAMyo+PtpS6srSzGYUfA6qsIndqIq3UYduNUEfJo9RpbAFZJZ8p?=
 =?us-ascii?Q?T8KsPycXp4IzxyfnhNgZJHT160Q2IysEk8N5dd9XM9IMpy7XHdQGYDhy+iA8?=
 =?us-ascii?Q?6s1ADjLnvG8Ii4bHdeW1tgHdBTlYZhnBIlehr6DX0JfcUHUOvlTZc9uEtql4?=
 =?us-ascii?Q?9hTEe78qYzShTSfDCSAGuivrVinbtDFjXt5w1sUhgI0skt2hSvctvoe8Ylxh?=
 =?us-ascii?Q?sDMjoYRUF5ZjfpzkADV5CdbvdisVE0IRXF+t0zhu8VNd7ucVcI/sUOAESKjS?=
 =?us-ascii?Q?U42t3MNNiMoBs4rxL2mQXkYmHhJDTMDyCy5+GlviLzYDyn0hK3gjXiXbgz+u?=
 =?us-ascii?Q?xOhfSpaajIpADTOh++b/ZlwBvuFqvxw7eeHT2hdqqDLPUu61Kbg9hXzYAaXj?=
 =?us-ascii?Q?nWPKqiuXvZlgiIamtXh5FTJxOiJIrbeJ+Nm+0qtjyp/sjYqZ8y8vS4p0RwUA?=
 =?us-ascii?Q?n6xCqoIkSMxR9wbMCbx6bUqxb191t3rV3P1ZvpmM2KQeNpfs8riLQ8wlvRts?=
 =?us-ascii?Q?C9IWPeDnZB91iYwqOQBnpryn0XI0dSHOijYqjrar7pqplqO1ACgm8szsqD7a?=
 =?us-ascii?Q?sUGrYdzQ5XlpVnB4KJqzNKyp2iZYu3PJ84Ri/PDzsNes/FMgqrP5oh77V5DO?=
 =?us-ascii?Q?K0m2gp2Y6hScz/eeK1BqZ1R0hYUmh/gCqc5CNegRHthL0lUVwf0zz+91Dwgh?=
 =?us-ascii?Q?y4ocgYloz5KUC+vVQ7Rw2aIR09d2WD/KUOwSfP0wGX/FHWx92fR/lxuwzFim?=
 =?us-ascii?Q?ousYCvOon1lk6yyPQhuAteDJ4rLFGUocQe/2B//nw0twZj7yVU26nLMI7b//?=
 =?us-ascii?Q?/Ymppzfc7w5qb3L2x9FAAN6UoBbLV9xLNwKB46ypcVLuLIM8axYV2+kkG627?=
 =?us-ascii?Q?OnVT/Ri27GSY8gTSDjLG6YqTaPaQcOQPew1iTVNa56YZuwM+GKk5gKY+VNY8?=
 =?us-ascii?Q?LEg8Rl5s+CpgBh/ZexwdP/GmSvaX0G+jM1jFOsOz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7d596c-713a-4dc3-0ba2-08dcc35b5fe1
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:07:19.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoVjWMWCclLgW49SmEcP/oGBpA1dn2kATjP+5jHUPv8MmuxCLIfco+xpY2SPXhxiTmcuWA5LpAyjIIvy+PFk+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6854

Make the code cleaner and avoid call clk_disable_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/bus/imx-weim.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 837bf9d51c6e..81483461b514 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -282,19 +282,13 @@ static int weim_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 
 	/* get the clock */
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	/* parse the device node */
 	ret = weim_parse_dt(pdev);
-	if (ret)
-		clk_disable_unprepare(clk);
-	else
+	if (!ret)
 		dev_info(&pdev->dev, "Driver registered.\n");
 
 	return ret;
-- 
2.25.1


