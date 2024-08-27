Return-Path: <linux-kernel+bounces-303252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE19609B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBB11C22DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332A1A2C22;
	Tue, 27 Aug 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BsSuwjLh"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C311A2C0C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760518; cv=fail; b=t/qsyOOIUACtP6kgX0rlpqInOhBZaz+fRlagUb+c0wNgS8fMJ6Or/mc+nq7Xu0KDlDoifgkTzukgrFqdWnF/tvcRUrf+IjMPZOzsAdXSy7l02LKL31EbUVKciYMlMY9Qr+ttzO4DC5BA13Yle/AE9goGMZdv767VW3YrrX1bt34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760518; c=relaxed/simple;
	bh=Uj0st/M3M/SxGHYVXVeLsFw1v8GVQOak1G7TU2m5kQc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ssB4UXmtpS6B3q5TLcPxEKqOuGVCCpjJtRgfD4SSVH8v57+Ed6Gti7/t15okNxpwHTVCUSUDBbnhtoqX+Yj/rZKL0SzIpTnW8X51qLOVKwlOpW8n5FxyPTQUGgPr1/dDiZh2qTH8jQplZ2A04uZfnBiy+mrBaVHKPIChBXqPtNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BsSuwjLh; arc=fail smtp.client-ip=40.107.117.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctf+/1h7pMDfpVMBTceiYR1w12f1yAL9BZbfC/iiRoWznNj3AQE7xI50tBE2XMIH7eKIA1JO+kzHf8va9pjqn2j8T4ch2G1iEP/AAXrbsX2a/wIwM3X/xyLwto0zv4yDy38LUItUdLZPACve5EfDhgfox1kux2ctGuFC1LvTyIwwyx+a4x+5ysRs6lAubP9VpJMb5nt355mVGYjDwuwLzf6zlfIv4lMBXJV+lEOBiYpgtpSKaQZDn5+5Kgj2zkjEwjvdK5w1leANhsITqBlyJmLNrPtgVLRSoBm39CkW+6s0vreJ6xpFmCMu1xHPyT6UwdEYE0q+gCVR1tC8kUuVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qgN6WGxZjl8afjN7eRid+GWMGjvT0XXrysE6YDlBJo=;
 b=GdszSdQx2l+7PFgf33/JEsClcEsWunaG4Vq77i51F1RIT0CwZThpD9exTN3WGztROytLuIlkyPUnpLwplYmzua3GnEFICb+4BE+q7tK6K2DWcd6A0LPIiGSN6aSHinNbSA1ENruDLCwYn4MKgczDvFbQ0vfCmMQ255zepTI+VnfV5pGz9CyjVvgWdXhmPfeFtTHTN20SvfVqEJ88bgRtcDpiQemJs8NJevdxRL9GTq0T/onHXQyZ6uhLafev5+WHmV5X6x+0AiBmnAQZf45vnYveVzgWpi/OBvvKUZ9/HRvHEWEA/2sZJ4w+PEMJ5cuOnxoc1TJTfggUpY2K/CNwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qgN6WGxZjl8afjN7eRid+GWMGjvT0XXrysE6YDlBJo=;
 b=BsSuwjLhejZ2bQLFJQ3RnGCZKQiY+x9vPkKY+5E6fsPAQkESXvbF9Bcnm3+RjINUkgicoBIMbXpbVJUl38kMzIdEShYPFV/MBoY5PZnYExJXwEx7Q7Me6nJr1cPdx93EVeMjibiYJia+NKsX9UdVAaMbPYTBHsNHOGh450IbZGEKwaUPJCwBFKZioYF5h+qvaxLM+qVdVKOCopS9YQcJWqKvBirRegOeWqiwnSOnnEvOLayVhq4kU8Av+mmcu/RsTqpqLooR6ybI8sa/FdMzSy+Gn3e8w5xadv1djHxADguwRLP52N3bIeGQztkMrTbjeRp0VN6TZeOG/Q7OWzvgoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SEZPR06MB5221.apcprd06.prod.outlook.com (2603:1096:101:74::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 12:08:26 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 12:08:26 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Yang Ruibin <11162571@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] HSI: omap-ssi: Remove unnecessary debugfs_create_dir() error check
Date: Tue, 27 Aug 2024 20:08:16 +0800
Message-Id: <20240827120816.3910198-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::12) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SEZPR06MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a2b93e-2a62-4228-9c9d-08dcc690f488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UcsJcXQXQo8z/mIVuOZEE2Qjd36hBx8YNyDJXCkK7nlFnJw1E+HDh9/sh8Xg?=
 =?us-ascii?Q?an5Y0CIGHuOzkaw6cGKjmFOfWZ2h4FqByt/EPSeMKA58iZOFZ45/CN6lRLVP?=
 =?us-ascii?Q?X3SzNAhXCyM2QOzF1YmLmL1sS55RXZYE31BCgBSWMcQ3nDddyfLi8oHfYRjF?=
 =?us-ascii?Q?JwM1z/6B2+7tgEiQ0MZmgwEq/UHlQrhVAZ56NgBJ5SsBL1/x80ImFU+Qg3W/?=
 =?us-ascii?Q?cWIUDc8uSXX4i536QkjtwQYHM6yMivM3bah/QX7fPbZyeOGIj4EuYJNNzzN4?=
 =?us-ascii?Q?Kt41o8u5hEUXJjRSgdKaLv3tawa0TrlPHbJqew4pOaMsPxfSSwvp3w/llQCY?=
 =?us-ascii?Q?gJ8mHnUxyejfvHua7Ar+mpzGzhwIVXOm9Zv4NrQW/Bg/n3sFKLtglns6dGcg?=
 =?us-ascii?Q?tDrOXHJM6V5Tj+vKoE/+JWHw5HAbkc64LthBRjiaocd7XUu7IR8ASH7bq6mI?=
 =?us-ascii?Q?cGjwf5ffQa6lowL0FJsUGkHj/KgnIgan8h5ACpvNPNsG0CLeaYpYbHsCSatj?=
 =?us-ascii?Q?B5J7gXyW7gNmG7U+GUZZtHRcG6u3UkkiJmh9g2MgV3Kcl44ue0tq2yVWr5hW?=
 =?us-ascii?Q?83b0H5UVtQ3ct/LgKs86gx0dCgu9YVTABn6BpTvcJn4mCUJ5RTlUUJr+JuEn?=
 =?us-ascii?Q?ZMAazqJdfuLkco/8gJFAPi8fvMqLuThgoOAY1hjwKmhvxl3DPxUhA7R/Hbgc?=
 =?us-ascii?Q?D1YEqi0sqcjCPKshZwsuffdnFSXFfD3Be79wuNB0XPBlESH57QiM23QMh6T4?=
 =?us-ascii?Q?0hqP3e5v0sBkvcdL72mP1OfEM3lodn38qSljaxQ+EM09537dXhmBlUONK+T7?=
 =?us-ascii?Q?lAmO13YN9KM2eCLKJ5HzwmCI+YipSphznPQzk8V4/aLk1hVQclDfPXdjGScc?=
 =?us-ascii?Q?T6wzarNOinkpv29iyM0w4wveFwnO91Qj+7iKxsTTZKFGhW7ZVP+8bI2RnT3F?=
 =?us-ascii?Q?iQpaYtDNXbyFhwFjkRgX5CXyaudlQfQe13EvSvnaJyzll9m3oUp9s473j7xt?=
 =?us-ascii?Q?HB2tnJtZTDmW6cXXty+cn+fVZ2HN8v5Wf09oz1s9hcE4HDrHrXlO8dBdb8eq?=
 =?us-ascii?Q?/qYpSbHhfiCW7+kJiCxjfDvblmgRCaIgqubv2VN1PiccXxUdc1fX4g4WVOah?=
 =?us-ascii?Q?JTV4EZdPhZxJa/ocC6tkba64AYElmYWFxyPCBTOTu3rldFCQHDtzaDNNRPLH?=
 =?us-ascii?Q?XO9fX+dfchN6sKMHRl6mN0PbbtSO4lLlW5O6GUsY6w0ROWOpR314YdE766QE?=
 =?us-ascii?Q?rhSPvZWVEu3n152KgE0KQZ0RPZ2m4F7/WPh/8K8Anp8diIfdMMJkHSSNYPJ0?=
 =?us-ascii?Q?02wkbJ8HVZQq1K6PUhctSLkx82wlLzQKE9EJa8HZoLwg4a2wAWbgg5aNT8+b?=
 =?us-ascii?Q?yYRV1pxE38/Qy7D0ANIxalwF8dgRQ2X6+kcKJdhOLjg2oHyS8yZdRFP8GdGt?=
 =?us-ascii?Q?GqZTfwBby/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzAQBrqh0t9/VvDlGTc8BtrxkpWDtgNRZtLjv3kE+3DVm0FUHubimkyS2dY1?=
 =?us-ascii?Q?6+JYNwNu5Rj2MNy8kfYh6k8krdnL4IIp234QemMt4PN+QLC993/aElITaGWW?=
 =?us-ascii?Q?E3lKKBvIFpPaqjvwtgL6puSoFK/1zgty6V57cufLUaGYbyAMAtXeCMiI8aNB?=
 =?us-ascii?Q?B+33Xes6Iq/+oA7Kpd4p2HH0Rbdxa9CI77Gjpo8Z/MmOixJO9zid/ZhUPfkG?=
 =?us-ascii?Q?ZygUrDImDuphXKTqk8l7bksWtxqJllLHKAh6/QVwB1nvhlJvF0Sibd4pMnnJ?=
 =?us-ascii?Q?vlctKjGdatagqB6oG8CBC+sGkLDujK0wUjnKKcmuM+yWlOKtjI3IaYmoslTU?=
 =?us-ascii?Q?d33jQKxHVzjNBeYp4721tW6/j+/4PYD2XacgaULQRplRbLvXSv4MkF37ekj5?=
 =?us-ascii?Q?3unQ2jgg6fxV7Iq/FYJOmtaTj6Y1VGLU92cK13NLvjPn233pn35yv9t44lk3?=
 =?us-ascii?Q?kiUyfGA7nRpcqiin0+To6ZbAyHtb6Bahd/r7e/s60syBTywVF+V3MmUSRfkE?=
 =?us-ascii?Q?dwXRLieWZQ87gygYkotO3jGuSv35xkGAKgOgiHGhzA9Ze9JCMUeyJyim4VNT?=
 =?us-ascii?Q?MS9UhiWSWqizRfaGVX+sWHGkI2YpwrWwwClXylgNLpFQtgVguOSdWCfDLl56?=
 =?us-ascii?Q?HHYEltBiR6A98+26//oBJD5n/B3uR5c2IdHQOqC94R7ebh6NxNG5TMYWan1V?=
 =?us-ascii?Q?d8fDUkCCnS1e2iDGOWcCpf0d+bB8LTwA886CzjpRuNT+CTCTuz+7NmIbrfzq?=
 =?us-ascii?Q?8/4lh6QpJ32JLQuQf+8Bth5aQK2aWFHkIR/8NN5FPRr37QyOvNqw+x1h8GsZ?=
 =?us-ascii?Q?Q9thAF6VHDQUR9qfUY87EUMCPr9EDVBJZslYl4TiWOUcaATAUW5fFpGhNkvg?=
 =?us-ascii?Q?4j4syiRQOJ0gCaRmhnJLF5hIjswPC8Qic7/4oPMp6SjXR5+UtN3yNdycmC8D?=
 =?us-ascii?Q?EVcr3+VDNscyPPws3+V1DEwCoq+oisfBaSN9c7G5w6HZzf/dXT4CzxEB9s1F?=
 =?us-ascii?Q?HI+oJcRCqX1AZKnz+ZQo3ccz4unVnkY0GQr/kqRRS93Nsw8fIPOKoZ8hNJWy?=
 =?us-ascii?Q?5wuwhRptQF/yNRWPplYTps2/kKa5yW2d+7YS6txRxoh5wsUEjr9R+URT8+1Y?=
 =?us-ascii?Q?OgmWvtjyaMyJkB8DNvTsk2CrB9kuq0cz9aPpKTtkWwRpll0U4JY8xKAzpO72?=
 =?us-ascii?Q?1UKtTV+4JpMtW6Byq8doNW0vioL0GOY8+ElrS6W+QzwnRdf0IsXygl8HBmy5?=
 =?us-ascii?Q?cRzxDHOiqtNYICBIUc7EEEFXEkJPm1m3V6B+hUGuweNV0Q3fgJQjaRXDlxC5?=
 =?us-ascii?Q?Qh/vEEpbJ0ybwUbHzQPmMGiFojKLTuWz/NE1Qk/DfCOQnqI6AwkqkJxEU1JB?=
 =?us-ascii?Q?8chiOmy4pw567Tz3vieYsxQXWYe+NTyaBQPx76QhoyNsKYjrogDBqIBOUxmH?=
 =?us-ascii?Q?WrAK69UcT4aPvXxCC6t9ppxTuqv+UZY1XbZDUYPmi1XeKDie90cd+bIjApqF?=
 =?us-ascii?Q?iwEk3WVQHhBJHHzljYCN/VWSicuDE9mHaKuGq+I88O2xXGITPzmoF2MZXFZM?=
 =?us-ascii?Q?1JE2fxTnjg9Lfp/HvFN0DJdz7p+8gu8jmuEcJCDo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a2b93e-2a62-4228-9c9d-08dcc690f488
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 12:08:26.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDgfTC11qRg1Ze140FUdZNUi7Ex/Pzz65BRUG07eFtluEuyW1QfdPSftAlSAKWeqcxIbTCvmgjGRpnMRncDNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5221

Remove the debugfs_create_dir() error check. It's safe to pass in error
pointers to the debugfs API, hence the user isn't supposed to include
error checking of the return values.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes v2:
-Remove debugfs_create_dir() error check
---
 drivers/hsi/controllers/omap_ssi_core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 3140990a6..6318506b4 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -116,22 +116,14 @@ static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
 
 	/* SSI controller */
 	omap_ssi->dir = debugfs_create_dir(dev_name(&ssi->device), NULL);
-	if (!omap_ssi->dir)
-		return -ENOMEM;
 
 	debugfs_create_file("regs", S_IRUGO, omap_ssi->dir, ssi,
 								&ssi_regs_fops);
 	/* SSI GDD (DMA) */
 	dir = debugfs_create_dir("gdd", omap_ssi->dir);
-	if (!dir)
-		goto rback;
 	debugfs_create_file("regs", S_IRUGO, dir, ssi, &ssi_gdd_regs_fops);
 
 	return 0;
-rback:
-	debugfs_remove_recursive(omap_ssi->dir);
-
-	return -ENOMEM;
 }
 
 static void ssi_debug_remove_ctrl(struct hsi_controller *ssi)
-- 
2.34.1


