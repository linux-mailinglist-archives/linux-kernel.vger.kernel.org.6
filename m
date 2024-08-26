Return-Path: <linux-kernel+bounces-301058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BDB95EBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488ABB225C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069113CA8A;
	Mon, 26 Aug 2024 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nD6YmoyF"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010032.outbound.protection.outlook.com [52.101.128.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA813AD13;
	Mon, 26 Aug 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660673; cv=fail; b=WL3lAfoJdBBGbixnfTJ6R5C90UMa42rNWGYPrQ+GxZUoLJGReeKFiTBlJ1nKCcE69Sx8yIdn5mnGCMWWFfHRwM4YgmKeTaQ8LQsmvXzTr/HY2+BNPN8rzcEvcR0N3UMuVEECqCluRjmXMO8oW9diMfxJQ5bCw0BRLzt5DbhnHZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660673; c=relaxed/simple;
	bh=Jyhk/ACcW7BmHdQ+pWMsaUrZlmvvkeXyGamureVZiF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PadpUM8qVTGe7g+1niUa5LZG2J3dNC8LxBD7gVpWquY+jy50Wfzp1HRBzPn74o2EeVf8j3SPlEhhxTEubOWmj1RmQ2dIROzILLw3jArwWMbd3ranZMQ/v3QFo7hxBklHAbJoifEENp/TnjpOePPEyyZvUbtHUA2pDVDvZjmbxDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nD6YmoyF; arc=fail smtp.client-ip=52.101.128.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE0UzW+w3FUEKhdiUmjVFdFgAnL3F8PsvkKHDr+lE5yijMJpU8aygTjN3u+V2/pLRbj4SgEDe5kxbC4VqmnJnY5MunC5+r+PXbt2DePajMay1mQlaJ3tCFyliNPEgjY9OPQhstsa8kR/RpTRFNIVP9xkZbzE3iqPg6WvIuor5gkV0qDNoOuhw5y9my7JTnBmzFhtS/iJG3hknUqU8mpJXIlOyK/Yyd0LTbOOJn5UxS2Qpe1IfHgFymVzuhQbhdsAB1W1nQhFxSDG9hk8tO6EgS1k2pwJOB9PbAF5nZwNZyypFFO3PpRB/MVW7a2RJ882en/sLbJl1cwMDNYxXB8okw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCw5w8EU350n+BCInvshnTXKpjthG+654hsAT1zd3Z8=;
 b=zQ1PKjPMB6tV0kxhH3JjJAhA9thjRUPhlnl5l50j95BjV1jM8RuyqkD6NmRdFce6q3tyLIeiPtPIXarefap01q6X2HyyR5sgDZ0H7fUbF85nkdkIcQC57Dp4B/bSCljZPMf4NKDwU72UNsWMeFGjyxRezxrWmM0TGjrEj8I84iD08K/goYJvrlbfLzpv9YSlc9nDw/1Rsw/2lynAhfRIyH6DMlVAdhd5Z34ValYfx26B6tDwlxJPGlvFbBvZYjvfe/hbY5hyBMLZHHtl08Gz9Orv+v2aO9qEqcQsM1Q7bYW0uw0BH3SHmz46b9Zf323C1SN0A8bULjadp+TaCpnMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCw5w8EU350n+BCInvshnTXKpjthG+654hsAT1zd3Z8=;
 b=nD6YmoyFijfuZkULgtOtsH4sPVELMX8iVwxWrD7bC67nKhGys8dWaBHYW9Duh9aXAdPHKJ2o3VVWP5hdlAuA7iRsnrG87pSk74X0sDIkroUM1tmvQ1lXdDceWBCCmWMsMcXliJ82RVOeVTy77neA/ggvFAg25IYqb45jEc+2avjr0LDHKpthe+lf30nACV8rwN68JpX0HlZAAUt8Z4XG3hUsFzpjzq4fl2fJo+vV9aTb3lmVNZQ0YToxk8XalYTHVxIlag7AIcbyiszBVPc7Vxz6+CE2KpNCq5Z/FLN0cEv/RkJ77wF1p+VEUBo3G6S1BYJFcyGy/f346lz1kGq9Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB6665.apcprd06.prod.outlook.com (2603:1096:101:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 08:24:25 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:24:25 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-riscv@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v3 4/5] usb: mpfs: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 16:23:52 +0800
Message-Id: <20240826082353.2373-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826081900.2284-1-liulei.rjpt@vivo.com>
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd17397-f1f8-4431-60f5-08dcc5a87ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AwzSxa2HqILEvdMAIe1CMFd+n3ovaci7fdOAn7tc8VJzcfaE13hZK6mI/T1X?=
 =?us-ascii?Q?tDkxVWQT4NyWEv3tD5YlPBqb0wp/mgFxO73IBsPMIr2vG17Q/YUGSHZBqOp6?=
 =?us-ascii?Q?EPmXEz5RawFuH68OsAOKUUm5Jl9OjT7x1MWoOa/e5lvMjkmCsJya7OmU6Mm3?=
 =?us-ascii?Q?gpF5jmM5R++/8N1Hirjyj42QdcP8IDo6VYnDoZFNOA6KoR4/f9dl35t45wPF?=
 =?us-ascii?Q?ofpnS4vEM8gNUh37PqXRlby6qdM6yaV4fNAZqDWijVQ65RYcDtibdEMK1/TK?=
 =?us-ascii?Q?gNmrJvv17/obUD7S1RFWl8IGlOdQMPGPcLaEVeLlFnwp89neo2PETTuGtqwQ?=
 =?us-ascii?Q?5x3lh2dJq6s0Qk90m7CXQgHQx6huHpA9M+YlIaNI6IBItx5ybWvpbYRS/DSM?=
 =?us-ascii?Q?eKEmiDZ1Z/ESTfb2/Bp26KGJ6XnFo85AjgFdh+e2CctWxROZUs0pzqLEIxuh?=
 =?us-ascii?Q?osLOut2+Tjg/EOjEoTXmMcjhRYT3ITDlO83f+NbpHbG81JazLeaSr9xPgAT9?=
 =?us-ascii?Q?O/FYDWc5URI2Z/oSbgRUNFxkXENVseg/46ewcI6bSr8ie5ACP3QMflds/iSc?=
 =?us-ascii?Q?3hATB6o0+E2XrB7AqKZOTnaK/A5fFhsziM8/b29MvhPxbpbzsHwuVVsdvMsP?=
 =?us-ascii?Q?Qkg15OkWR4BLQhsZlRKAuOvmvSt7J3l9EW4PSGIBkFoaB3gXs5fL/+Gil+g0?=
 =?us-ascii?Q?Kh+wucV9TW4iVPgw0w0uAqoFT04Wv2g+tLJfakEXAWGRL+ekFS1x+xHSBM4D?=
 =?us-ascii?Q?V04N8tWp0C2fBNdYfwNKheLK1Nc09qP+7tvGI6viqb32HT9HuWYSxTY/zgKg?=
 =?us-ascii?Q?mgYUKDTzxUJ/1xXFxFk6NeYBYbWdwyKi+ypULMo5UD4kFF2H7BBXY8ZYVTjh?=
 =?us-ascii?Q?8HFu+hBdX9X44LPwGkoBHVubvc0AKOSACWuem+tU1p5ML/dgb51CEwR0KrRH?=
 =?us-ascii?Q?n+D44AGIcu0W5B/iF/GccNHBkNdGoBgBT4InBcI3IFcDtdjXSHt3QZcKom7L?=
 =?us-ascii?Q?T4EvD46egJ2wnUnMeyYgo2tpbFotc+WnG/YYtVCsSlpZ8RzXh2UVRN9b3CkP?=
 =?us-ascii?Q?d8KZnNCVA69ZwzkqDuBH/kFk1qynFsgIo3A+fzbd5vo86gsxyqVsw6r4xt8L?=
 =?us-ascii?Q?Hh5wWAfb07fpCmR7EU4z9RLxuQgKvPou15J46CH9DuCPMdQZeqL0Hl78u3nZ?=
 =?us-ascii?Q?4b4axlrCzNrc0Up0PVZgRxVq8SG04hzAXgAZKPfHl2q7rqcYMNW0XwDn+PAB?=
 =?us-ascii?Q?8xDdUNSVRfCNEhFkYnGi04C1fYYlmXy4tjCMLELdVPXChLUGYizINR55Sb70?=
 =?us-ascii?Q?RUSZGcpKSWVfqZsxbOuNdxhNNZrgVesUZqAO6uhS6W4aWdaLk8V6CZtoggmD?=
 =?us-ascii?Q?fPFA/+jABTNvT9k2FxL+3eZqXJPfRxwAaIkioevoduqLItLr/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbN+OrBG56hYG17bin0Wo0Xv/C9bnyYbvBtxs1IBY1jrY/7SMl2sHslKidpb?=
 =?us-ascii?Q?ag/bvnv0v2h/vLbRqkWhR9v563nGTzSPbpsluhdp1kHJN2C3S9xMe8OeHqk+?=
 =?us-ascii?Q?aY29B638R1RqNlkbJaR1n/AX3uLbV0+4K8t+p6vA3bceK8Q8lXVV8FBgfErk?=
 =?us-ascii?Q?FVAYUoab2XUPhoCDZqZZR79GxAaAjBDJFTAASQvps/twSuD87q6yxTEu0xZ/?=
 =?us-ascii?Q?5SpXqmhWGCb2yYCoYfSBcL20yCz/kWskbruIsOFoRXxfs6baQXBwYWmmDCnG?=
 =?us-ascii?Q?raZ6Dr5nVDYWpBhDMDOhKvP77mod9fMd2WmrVHLcnGZUKIErFSrjgmFDHqnu?=
 =?us-ascii?Q?YskZGQTDvN92bL4j+njw0d4S9KKgshQrmMytBgW1CnvFZyHl24tX0ivFCflV?=
 =?us-ascii?Q?3Cn5G67WhQuTxR+FmUVmqWCzq2jDxy2W/M9eX1mccIIv74XrkIy5PEGkwqFu?=
 =?us-ascii?Q?gpDnOuYBcDeQadTcr5Bi1XP6Cr5EysVjUZx/cNtTRuz6LvGh2KiL1DEG0GPu?=
 =?us-ascii?Q?VfrRbux/7SZIsxq/OH1J6Pl00XxhbsQLcJ59GhfhzVpYiQVH0oPQSThzOHEn?=
 =?us-ascii?Q?xEbJ6YdwFScObb8eGnUwGCKIDo+/Kc16APzjwTIG0j20sVCWU+Bwo0jk6kvG?=
 =?us-ascii?Q?50JX8WEfifkrHB3mgjUq4yieC1dcbKrygB9XMApCi7GT36PfE/GYq+l5lx1M?=
 =?us-ascii?Q?lOj8CozsaJ71pWPCCo72o1wAQbEfC/OhRAQCQdWRfzN4av8Oyy/25iVp3Y7g?=
 =?us-ascii?Q?it8JP6YrrsxNGiAaGd922KRY9i7RB/UG6bmkEuwGQ4cjp1bzceykUZZbOS6g?=
 =?us-ascii?Q?375OyBl2HJ2V59hGnK2rO2bRY2r6f/DWHTboM+ZNfAh8ek3ozCllQU02CPgt?=
 =?us-ascii?Q?ApL99drzV+Ov9R+B+N3kOK3/0MChKtK87OwG3Ksp/hfW13AuLp5dewyaw6XS?=
 =?us-ascii?Q?3LcCmH8Kt9Vq6J7Miaze2TRKFIblbJ8LzGumZy8+ZYrlSNVbzP1guqH/HxDC?=
 =?us-ascii?Q?GYmTcBLlvJJ8lVFwNos/HSqqbew+w2ngUrWnDb1LQUuMphatLa+g6Hpq9Cl4?=
 =?us-ascii?Q?G1gRhyEh5t6hLxPK8+VBZZiq8Pq4vd/+9yFospiZcsryIfQtbLtLy1aPbe7/?=
 =?us-ascii?Q?BFH7ZAT1BBR0tSgj1/e5iPH200EPIe1ei/tYRXDAsab+dRXIj+HQE0bm2h0f?=
 =?us-ascii?Q?2lz7dmo8ij6LVrN6YznvUAXVgVzMai1XulOr85jXW/CkCdBQOxt9VI6PB/it?=
 =?us-ascii?Q?I2zeYcFMDRFq4Gl/i90B3N17UEb75+4PiObsRa17tCLI7ohiZYbHqSrUBYzK?=
 =?us-ascii?Q?2ClXInLSmAk3M4n6GndFdegaFYmS9LWk5yTEtSiLASGSo/qcI/NPOcV7D9ft?=
 =?us-ascii?Q?JeEXwV5olPbjSiMsYp1/UQntBzmeUitH1MIKgekgZeCYp6GvlSWnWFTCJXdc?=
 =?us-ascii?Q?xgS1HukGijVwXD7kzAFbq+A9/ySI4ilIXmZUNX8/ACWaFRpekp0r0LGadO/r?=
 =?us-ascii?Q?ltiU2EVoCboSQAgKL8KL3maQOtX+VqW1fFjetq/PQguI1AU16yq7lBJX7BJP?=
 =?us-ascii?Q?LwTm2d0cxYPpf+POmBzwm0GNtDUK+Fopo/Duh6vt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd17397-f1f8-4431-60f5-08dcc5a87ec8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:24:25.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR7IY8h0nRJzHAXgACAO9NLfQqnoyeMFhIsXUl0y31ns1XM0QynmGvx1BC6UX2zcD3EI/gplZ3+PPwkMS7WbnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6665

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v2 -> v3
Fix the email thread.

---
v1 -> v2
Incorrect usage of devm_clk_get_enable() should be corrected to
devm_clk_get_enabled().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/musb/mpfs.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
index 29c7e5cdb230..ce6ad65c5fd0 100644
--- a/drivers/usb/musb/mpfs.c
+++ b/drivers/usb/musb/mpfs.c
@@ -159,19 +159,13 @@ static int mpfs_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
 		goto err_phy_release;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err_phy_release;
-	}
-
 	musb_pdev->dev.parent = dev;
 	musb_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(39);
 	musb_pdev->dev.dma_mask = &musb_pdev->dev.coherent_dma_mask;
@@ -184,7 +178,7 @@ static int mpfs_probe(struct platform_device *pdev)
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		ret = -ENOMEM;
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	pdata->config = &mpfs_musb_hdrc_config;
@@ -203,7 +197,7 @@ static int mpfs_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to register usb-phy %ld\n",
 			PTR_ERR(glue->phy));
 		ret = PTR_ERR(glue->phy);
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	platform_set_drvdata(pdev, glue);
@@ -211,27 +205,24 @@ static int mpfs_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb_pdev, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(dev, "failed to add resources\n");
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	ret = platform_device_add_data(musb_pdev, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(dev, "failed to add platform_data\n");
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	ret = platform_device_add(musb_pdev);
 	if (ret) {
 		dev_err(dev, "failed to register musb device\n");
-		goto err_clk_disable;
+		goto err_phy_release;
 	}
 
 	dev_info(&pdev->dev, "Registered MPFS MUSB driver\n");
 	return 0;
 
-err_clk_disable:
-	clk_disable_unprepare(clk);
-
 err_phy_release:
 	usb_phy_generic_unregister(glue->phy);
 	platform_device_put(musb_pdev);
@@ -242,7 +233,6 @@ static void mpfs_remove(struct platform_device *pdev)
 {
 	struct mpfs_glue *glue = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(glue->clk);
 	platform_device_unregister(glue->musb);
 	usb_phy_generic_unregister(pdev);
 }
-- 
2.34.1


