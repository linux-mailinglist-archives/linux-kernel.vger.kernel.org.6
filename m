Return-Path: <linux-kernel+bounces-300876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D326A95E9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49543B20BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0718563E;
	Mon, 26 Aug 2024 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p5346Xhl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2075.outbound.protection.outlook.com [40.107.215.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A2770E5;
	Mon, 26 Aug 2024 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656000; cv=fail; b=eZpDNtBkUaboWm3FcBsjk2QZ1j8c1+PBcwRqgGA8WIPplQ7undZ7wuiaVV6A7mF4z7Wz7KmbHmjDFROdK3fjAzdb/6BpakbWRA/HxflNpVqTa4ckJojS8m0SDL39KDALBanykMuomHuXID6BhStwamaKte9qK4A+7RQN3dIUiAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656000; c=relaxed/simple;
	bh=u0+n1GQwDE7rBJX44eooamoelPv0ctmTtYeBw6eHikI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q7OzkFDFoLGW53GA+4G1sf3PQGSxyOwTZdHf8DgvPBNVaUqJdZHCzJ60g+DRe0Fb+pr9V+30zgLQj/Q9hTFulgkdnmOFWGI1ub8+HswS1gLOsgP8uRx0fEfEfCpAUmP1rlyvggwTY7VAe2khMTuf8RnWyg2eLx635Wt2Nvc2uvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p5346Xhl; arc=fail smtp.client-ip=40.107.215.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koEFL6X/ynvCfoT60WytssfEQWhlTJvYKeg79KMW2wF5XYzn4+Qz5UHx7wLcHb3KvbkCx3avYNSDe+Hwz7PJmuYHowZ7YlkXULYLQ9c4MQZeaeTAALIToDHWV3DthXcM4IvaKM1u0Hny3ul8GXTxaooOMu68HnMvywos5xzormCRP/H7ADlaKaFx1yxqF5eq8vUSenW9UJVLJuG973ID+hxNwUh8lNwFYkgyVi2a0VZ80q8jILz7a/S2V4gyLP/QGqxVw+3/URWmtIO3PbspQ7bqWAJLiDrandlNNxXoMrAkMdZttXV/75mvvLDCOq7iscxaXI9/uPwW/V7W1BwxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCqA1B0nQSFfKg/8VT5mteK6iwf47eBKT6V7sKALC78=;
 b=W4a2NY/InC7OqOKn4/UJNx05cl4w5lKpNSsTh+qaeftIhe5VQJsYmlg4WaFMbcOin3tDlHv8sgs2I5FlGchMCKMNmQdA45S0FwJUrgG4JWtsFyx8jqPJXJy9l+zEqz6JJK4facaBPDDmzV0AP7FfMLeEohqSdkEX26ks03wo+Uogk2gM8kUDVx1hNvLXvPwoKKmFztJR9XU+8yjyzvdy0sm+nMlM3+Vs25HcxxC2Cx4A0ArRnsLgPqHpxuOPzB5QKFSM0t1jL7dnee/sfm02N4asIuKtLsDz+QBo7z1GXSq6hXo8bMWHh57wxv+xEsCz7bUAUcoMpkOb86ML1zI/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCqA1B0nQSFfKg/8VT5mteK6iwf47eBKT6V7sKALC78=;
 b=p5346XhlSaEaBDWUEUovMSGbsZnxk5bPyTB9V7csyiGEEd+UQdrs8InREaB7mKfAYLKVXao2RomOm8ITUV/jr29HE/hba8OBugaGAhFY2JSJIgRg3w2C6MZ3gfDRYd9x73rZYZSbfSB0PZmivX5j3Z2sx7MJoClzl+JE04wFl07pHeRKAIhlGrm+uqoCcAYYOPycxMX81hCqF5Ox2Zru3w0gV3t+Yu4biIvOhEvyVKX8R1rgsDKluxLLfdiGTU72fQkw8hWatl3A23oQkFQ+V8iSL/RO761J/HJlkzqSluygtlvXY+mW/9OVo8AfNRRupLiU3m17oO6OdadEXIF9RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:06:35 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:06:35 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v2 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 15:06:23 +0800
Message-Id: <20240826070624.1891-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:404:e2::26) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 417bc7dd-8643-43d7-44e2-08dcc59d9f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x1MAVraWJq7/Z9u6HhKz4CtTncCGPUZEBFga9khaWeM7/buGh5kvUt4Ew3CN?=
 =?us-ascii?Q?SUnaHswHUNAVChX9a/hx5sPLZWZcns6/sU8xD7lhvpUU7t5L2QaPIvphXpuw?=
 =?us-ascii?Q?uJRCaChqCW4z8Tnys8FRjKtFh832Q1PWDKISZBMaWj9yGrtDVeP06+yW9Bvn?=
 =?us-ascii?Q?aQ5L/H42gy+p9/1wpF5J5obnNTWI7TRQNsr2FqJLQjAj0P+U8kt/kLpi7B8+?=
 =?us-ascii?Q?c6ISbyJickwjmJ5wlbcbc431xiZF0EN4FcMpUEoPAxfnJbsoO4wgJ8wrCjMi?=
 =?us-ascii?Q?TBUATYtILoGAnAav/8QnPPDcLlmlj6DgHmOZbQl5xxJDnpRLg6Gw5hqLnrQO?=
 =?us-ascii?Q?1yNvbVw/yl2+dFA7M/DggEnS9Y452yzoXBMzkf/T5ueh8UNB1a6mEWxo7OUU?=
 =?us-ascii?Q?ayODF4LdebgV7CBkpDlL5v/blXYSwg41qa5gKeJSThvIQow1xWJdoCkmak2K?=
 =?us-ascii?Q?XL515/du545SH7qCDfgyEUhIk0ZkQQh5+9c4d+OSCb4JPQb0Jb4comCp45Uh?=
 =?us-ascii?Q?ofQsqxSfQXqOdGS2zePXdrsVsm2kAs10thN2OBex3utfGO+C06o/UXMjWKqZ?=
 =?us-ascii?Q?emtNtd1GbMSmQbnCE1TnJzuDXr/LySkQitZm5sHDsvFtmK72b7g1Rh6GysU/?=
 =?us-ascii?Q?P7MFGqHIa/vFIOC3xc0vbqJYN+g1WnlCPM6sBH5HpB/d6Q1t53KdvhPytmbH?=
 =?us-ascii?Q?cOGBtC+j4awABqGPDlxYQhncY9PaCN9tRhGo+GRvZoBr90o12DrG5zIg4oxz?=
 =?us-ascii?Q?5FXduHIfhq3vpYM5SJgJTIR2TZx7HYAqECu3NaJJJw9hVawg0SQPCuH/0ZZ5?=
 =?us-ascii?Q?CH2ksTfWTLYst/p/J2Royy1PgZCGbtBNGQ+M2Zt9rVY4Z6hMnU1dBo4BuOrJ?=
 =?us-ascii?Q?fWST6TWRxq2USvcduHE0iD0uStKibvyP+wNdeQdO5xwmmefC9XlDak+ONm/9?=
 =?us-ascii?Q?pVyBcQKL3k/le6JU6yCbODeHA8rygPUA4HBCkVAwCt2Xg3aCZO7HYXKsnZl/?=
 =?us-ascii?Q?54ik8HapHSMaR3Adc7Z05zhvONijpA2sO8duc4tScN82ILvg3NN/u645/Xu4?=
 =?us-ascii?Q?LoDsRIKt8q72u3RW5y61n6dZ5YSbyAJG6bDZC2iRiEqUyVE3rH95zYI0lnft?=
 =?us-ascii?Q?4rI35ee4WUK57k8Qop3tht/5wT2cExHPOTC/Sf/+IQDOJz9m/Xjg5pb9nvzd?=
 =?us-ascii?Q?IsdX/VUCeDKK/KM4O7zbu9GDV+JYxg0VDYXcPyiHf4DBEN2ONQheU4XQ5diu?=
 =?us-ascii?Q?MJy6UBt8xTfu+mHCKhRQgP/DGHc356teFltNbK/CN5AphgF+wmEp2LYaO/nT?=
 =?us-ascii?Q?U7BGBSrLXjAy2qOmEUxCcZ5FFdzFzkd+/AQdBfs3BXDcb3NnfzkoEW/Lyl/F?=
 =?us-ascii?Q?EqQcwRzIfYfhr+zbFp4rUFTzQ6YxRt1UWRyhz4vtL2x/PV2Obna5yUf09x0t?=
 =?us-ascii?Q?lu0OWnT1bUK4FbdpoLBaTOePFsGSI7S5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UZOphrMFMUV39/0e1/pEhfIcKoTKBg2IyO1g6wijOXT6YI98utt5MBiJhBq1?=
 =?us-ascii?Q?EvslTWBN1duVkUfmgfic/eKYgAcyxL+8RRPaIJOz9+noUq2g4RrXnLLasc3x?=
 =?us-ascii?Q?p6LouTCYhI6nD8SiAfVjRF4eVSu5sDFxRuNH58PSHhU334wNnhZTFCHqdnN0?=
 =?us-ascii?Q?HFY316IfWcEaggnu+db3Qx1Mk0ztT9XfvZpFkSNAGQgZtMCamCG/1owUWlro?=
 =?us-ascii?Q?N3u4LDH8tErmRPzQt7mzlqfExDyQChLBwhtqhmEdYEOS5F4ONwa3e/meYMnG?=
 =?us-ascii?Q?ouTG6GGw7l5rtGU+wNHkTUCTbqBXTIqtUkNa9VcQtMe+1bjt7ewpU5lWOBob?=
 =?us-ascii?Q?OzEsiV9H5h+cDZocVC+QwEbSHFPK4CGWaRILmlU2cwMwJdzJUwdySbjid2l4?=
 =?us-ascii?Q?DJxAow+U46zLm9Pa7uaSpgHu5TBpgjq3EwZPVwBLeJkCTJR55zN/KEENZ6k0?=
 =?us-ascii?Q?h/f8nJds3K+6ATJ2/0z0zPROAlGE5BCvr6UgHxIxhcuydCrYocRa/QqyAYi9?=
 =?us-ascii?Q?ELkbdtlliCYFAEXmA2ZuQFC7Cz0jAuhzz191lkWeUdSILdss1JwNsrzp09W1?=
 =?us-ascii?Q?gdzCmMnlW0EjCZ0xg7BpuDPZs2+ZXA2HeU6xWVSw3Kb1YUGZpd2B5VNd2Fw8?=
 =?us-ascii?Q?DNCIckrX+5FcUvyG8I0sx+CIch6LE88Fh9Wu2HXyFhtD/WdQf1R8MYQCGM7t?=
 =?us-ascii?Q?HvuK0X3JpA3JuP/T3V2td/5jPSESJf7aw5vMFmm3WlPgpm6zZHVM5uWV4mjo?=
 =?us-ascii?Q?KQ8IlHpVvu2kLarXfKu6g+LH92GpXHr5pg9eNtG6Gixnf6RSsNMu40vxTEQl?=
 =?us-ascii?Q?araW0bm2NSNbTUiPaA2xhdclw8AeWlc77E6TnzeA8yl81rdsa2DrFRwIvCh0?=
 =?us-ascii?Q?Z0KK47Qh+q+fI65Ev+iHxhbRklL1+8aZC6e47uL0vCfmM8xeWjQrue8E0P9f?=
 =?us-ascii?Q?0UJn8vtgtxs/Hg1hhKpjLctripbP/rIPRNJRIilgRDNOMBzCUfTyCIlba/Q5?=
 =?us-ascii?Q?TVgmumxt+D346ugyeyJA+93q2F2ZhdCdpa1SnZB5yIzHLP+u44oc2x4tDhtj?=
 =?us-ascii?Q?snLA1s7hKLXih4+K4sd3S8QA+nfsJg10vIBzAzN9PMnedjGvbCAoTcRQWzY6?=
 =?us-ascii?Q?Tc/oN5t5TfgNJGceO6whFg8Ccos8Ewx/e2Ot91WyJ8dQ5LU2ZKWLUOkRnOD9?=
 =?us-ascii?Q?p01JLwT2VNoGfp9YR7Rv6ISA/4XEkQpsN1qMSzkqiRmOZSSNVhPUGSDxJENk?=
 =?us-ascii?Q?BX9LcE5aVNWoLB6HtPXSQxLxx8f/F6KJCpuvwd7ObaXfsk0dEV8yfBECTvE7?=
 =?us-ascii?Q?UZYtRRZ5mE8LeEzGY7dD8ySHsLuh54IVjkinx5KyBmHhY7z2FV6Xi98XtrGN?=
 =?us-ascii?Q?+ZQy3aWhiY1NRnc/8H6UVRET0H1UCd2pSFBYPZkl9J/jWikxcnsfDQbQVfII?=
 =?us-ascii?Q?BLwrM47/HCkNBM+Lmups4KUhA6JE72dL0ZmhYZkj4pHRk+FoFGDridTqLfr3?=
 =?us-ascii?Q?z4/pSganZJ4a+kqLtDwcIYQwLLjJ4ofjCaFmK4rmdRooRZFGpOgD4M++tW3f?=
 =?us-ascii?Q?yj5XelVMu1dRGorYt0TzN5oa4FZvg7MsKtWNSocw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417bc7dd-8643-43d7-44e2-08dcc59d9f1f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:06:35.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPsRQxGsz6CDOXwGJXbPmrl/e3i1dixRFs3lKyyRqwvJzh813r8fTe/MWqBrmHpd9QDzE476EcfH2PYmXwvDbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v1 -> v2
Incorrect usage of clk_prepare_enable() should be
corrected to devm_clk_get_enabled().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 1a6317e4b2a3..0619507d187e 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2398,14 +2398,10 @@ static int pxa_udc_probe(struct platform_device *pdev)
 	if (udc->gpiod)
 		gpiod_direction_output(udc->gpiod, 0);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk))
 		return PTR_ERR(udc->clk);
 
-	retval = clk_prepare(udc->clk);
-	if (retval)
-		return retval;
-
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
-- 
2.34.1


