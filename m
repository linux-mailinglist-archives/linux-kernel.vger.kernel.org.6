Return-Path: <linux-kernel+bounces-310592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86922967ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D1DB20D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D9144D0A;
	Mon,  2 Sep 2024 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iL9mIK35"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83582195
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255075; cv=fail; b=AaoX4Q8GHVh0N5QBoLD0bvNaeG8hxwe02XxTSDkp9q0r5QBkpeYKcpffOfPTAsaIEHb3iNNyZwIUoGu3SgEGexBY46uOrzHrZUrqgHbmFk38j5yRNDw7GTikGPsNAoh9osEF4U7bK/OqhmNBkVUR12M+4spQVFqDNAik/Aqw7/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255075; c=relaxed/simple;
	bh=iGXLbrRPagw+lkjrxKm+ib9qokGzo+i8/zo7myIjPsw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Typ+EI4fxflJtxhUFXuW+sYsJdcfVa9v8jzz/cZ/ebDk0U/4LTqRSBcjLKZzVhLYvpB/Auy98PJ/6Jxe4gWRCAK0fkohROcHK7sEccMII4m7C66hF88w9U9k233RUPjM7vjVpWC3oNUSGNKKRTaP6JR/r5Y22giEw1bFqtCtGME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iL9mIK35; arc=fail smtp.client-ip=40.107.255.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrdPs67zzLW8o0mviCk4Ea+Pq5WchGcxlz5YH0styeAFjHJsC+E8RkxywKpd/oqaQSSNisnOVqX9XAJ0bPKiaFw9yP5o/I8OME+id2u8kYJiR5GIZYmj4TzCBwRTBvy2/x2RtKUZnzwvPTpf/v4uc8aHtdiGaVDtdlEPpN07dxDwOobePaY5wssy9mi0Ws7gnWAhI1Fkh1WloHj0PzsMRP+leRtM4IK47cMKze9Dln+JHWj0JoH5byNvax3A9SN9YPOBlXWimKvExFAXO1SF3bqZl1HuoctZLr+WCVXFmk94D+jQmzchpLx4AiVl4zlvb6BwTMBwiZL9P8P5Ng+hJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqvem/fIX0XGLiMzS6niOK+1FV800GGzQneLgN93B20=;
 b=i8pqGAnYZ7LEB3T1OKqtpj/bRivnvsJ+EG46iH+F6jcsS5+eTvmYb0gt1fTnv5bAP4FAFZvuDkccsqEwbpa/dtfccTpPiXwZKYMQYVimTGUgPy/N8j80riLhPwiBy/DZXR+vf3yGW/WWaQE6m1XKJZpWm05uh2psukbyf3W8ZAfifO9jC/k5fSFzEoeQT7nHNvDOiOLwP2h2HPk3gJ5mYIcYI877DJNWePyudFmt/XH6tDzIeT2dXVSrFww+9LEKSHA1b/0dr50pgBJroAuDL+SlRVZ/Fhk8JXVnDvS5Uk7hKpqMHw/LNpS4vGNGIDx2lRXg2kOCXajsPwHYz2SRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqvem/fIX0XGLiMzS6niOK+1FV800GGzQneLgN93B20=;
 b=iL9mIK35j20D9BFT1w6vD4nh0F0QiMKyyVpPp8R6K5wnXsyCs/ZkmFtzKwXfKNT9VgT37K9A7wxR9iPOhCXyI1nhdLtihygH6QgQdygWMHNOrT6pNeJudRMOUskll82CzwfsvMqiT6bIbvGKu03YFpX1uoNpSYmhsvs9Q6eE/j6gH5ZKJKCeFHKuWqHAb1XM0VY5uzjN8gssHn7+nnrQTTRkFL4poJGa0Ka3O61hyBCy93OhdvATdrMsDUuNOpNNrsUh2/ODruVAOcnf1edT8OO1vZtI5QzCRoVdBCnW/rgXQIa8W23XMNy3oeJ1ZK8Cz+oOEqpyuvKgLRQ1YFnxKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 05:31:09 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 05:31:09 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v3] soc: mediatek: mtk-mmsys: Simplify with dev_err_probe()
Date: Mon,  2 Sep 2024 13:30:01 +0800
Message-Id: <20240902053001.930379-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|TYZPR06MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 8435befb-e610-44c9-a556-08dccb107303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6m+gD8hvWWjF8YVc5P/Yc9zVxIq6K2r9JJGFwZxIaf3Gir9bi9z6l4iZshJV?=
 =?us-ascii?Q?fXq+3B3QQ2Uf68S5mzMLLLZPrJ+iYwyMzlO7oeBg+4OOFsekMSa/vKJMWlqS?=
 =?us-ascii?Q?Zz9S7q2LNkW+8SfZQGuILGxSTOsY4qlfccYuZ3FDNK4/cqpXtIOlbsXo3qlV?=
 =?us-ascii?Q?t8i4oKmnLLSXWUPK+ryUjU1WdsG9sAYgKFrPahmD9zwfgpkb8OyeBbe6jFm0?=
 =?us-ascii?Q?V/oVWsLRyEmSZU4m2oVFxsd1RM3PHGEafsGhhb0pX8PmrolzScvfUeS9Zg7X?=
 =?us-ascii?Q?KXclCKijzVQpneWkrtJfqnQmOgOc5XQ8eLo/c7tG7nqmCrhJrmqjrcG2yA4G?=
 =?us-ascii?Q?TBGdbTVJ5RpwvrofStDOIpKblG+y+ncI+KXOUpmtuplaUSBFyxxlT9ObVvgB?=
 =?us-ascii?Q?yoc6MMGniODd9HX+X6EQXN9HzU54qTlBh94QiGQ4o9aIDYBxyxgdG84mcpzR?=
 =?us-ascii?Q?T/v9FYi7K8Zzo25mdZOukuh8fapnBPr1HG/wikvImHaLxZaTo7j+W0a74G9s?=
 =?us-ascii?Q?gsPDr/ek9HUbXPCX/E19BpnDFmjFNpIlg4yXP7TRLDAlIJ6IAsqqSLdwtm3E?=
 =?us-ascii?Q?qARDwqcUUuulrmu9m7vb1KJ23VPbhb4ucqBPyXVBbz0870hMVlsPSDWqxNAg?=
 =?us-ascii?Q?N8od+OnrCPK5OtN2g4JUMVQQr6V6JAeCnYNQog/vwvDk3ikbAGx0lQbGNRsI?=
 =?us-ascii?Q?Okdj2cZrBLv8juD8sEEBuKi4VzALlwJMuZTChXhDRfP4jGevP2xwxrvhDSLJ?=
 =?us-ascii?Q?JXCtaf0YvZ1bUJrpgNjbtjt1BFwWc8oY0C249PoV8ODRbmbY0sYnmVZRL/R1?=
 =?us-ascii?Q?nA4a5eVCxO5myfQp7ggTmR4XXr8wa1KcY3FLanoOBm2kZZFFAmrvNMhf0Ut0?=
 =?us-ascii?Q?JlI91NedL5/YEaEKGYaZKckijkofCN3yuUzG+VhJeQP8w/+m5E0NMGqHWbpS?=
 =?us-ascii?Q?ULjxe1b/lvz+aXz9B7whdkaKuqwAaxvw5d/BxggEYiCXiC1PANypm9DhcXCq?=
 =?us-ascii?Q?LNeBn3qM/tNlaHhaj6NMxw5sL97gw8BeV7V4ljkQySGSvOG7dFJ93hWcJBFC?=
 =?us-ascii?Q?Io3bXFhhZv4SSEFqgEBNrCAXSF0Gz8gk0LyN+ufieCw74M5x0IWHtOpsInal?=
 =?us-ascii?Q?2mIXbarLkJVb+l5vICaMy5ZTVrTG7aVs5tk1yzZc0V4PhxMMtIJh0/ZEZDlQ?=
 =?us-ascii?Q?cEVQ4hDPu8WACURG9a9sZ7EdrZLmnHTrPP4UXLBoOtDfGd/btVJlg6a2pLcb?=
 =?us-ascii?Q?BTs+JxCunA0EKpbKhDZmhv+egnQj78MRVqEztG0AIpl7nZLQu2p8qMEHkQL9?=
 =?us-ascii?Q?ifYufmsRCl0fmc85ptSMvEUfm67uXOTdgdwPkarKoQiZ4T9m8UcwO+oHYn6e?=
 =?us-ascii?Q?jlVRq/Or45cpKVXWhNBdRFLew0t5UWm290QIZ5AXo4La1sat7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tq0Ueek0sE+IyThZvszU561Wysn510kM+IiNfB/fMbzpDuS7gZG6MgnzWnlh?=
 =?us-ascii?Q?dpyYnG5D7bZKZTnyD9+UTeBuWfZfATufFarRtfyH/M7sR6+CeHlghi9Pjp5S?=
 =?us-ascii?Q?RwL4VHSHJpsCCAV+VbFquHD7SxpSDwERwa6ot5S6dPqc2Sv9fodDAp7bxjMQ?=
 =?us-ascii?Q?mA+EvXwqrD+DdsF6Ji5obgCaZ3yV0MUnLJr4/ZLPHCHISzfurtPnnJbR85pX?=
 =?us-ascii?Q?SvV2O0ReOH9eAltLpXeSMf0yRyFPsnc5IPlhBiIkc5fxwAMMCl8K/m3IDZ6b?=
 =?us-ascii?Q?FE8KUGb1AGZdEhk/XKwJdPKCie6pOQlJ1iVXy1VRI5Cm09cG5S9u+NJkjfei?=
 =?us-ascii?Q?0dPoB94SXbKwr+jarnnS8mShs/qoNbT43Mkc7O4Jn+OR5WLnt+oiZZydNksc?=
 =?us-ascii?Q?SR+wX+A8Eqi/7tBczWpAEQxCzL5VZB7dcUHZQS+IuX0UaFZz7SO+3NyaTL+q?=
 =?us-ascii?Q?kdvfs/AjxrcbVTgQSk08QZaEKcZL9zWiw7OUf2QoxsqnHIO+/YHRTgp6Mvc6?=
 =?us-ascii?Q?YznQv+mAVjWG+jBk5tEj3pKl5840MCk1UUmk53c9bhNFZWIbHqs1iFTZUW/0?=
 =?us-ascii?Q?KieYbeVm3O7Ke0r6xl3bRcG0IZbw/LKZWT3I8LJtHEuYls6HgvIyMgh0LDtv?=
 =?us-ascii?Q?YgyNZfsvdUVseaesdml9VEF3rEHPuUVPFl3usXBbK2TZ8UkVFaG0yLB3fi9t?=
 =?us-ascii?Q?NSKlgU3D8YTyqUA/YasTT0M4Mq5l5qnCzochKBl1ffDcALuA8yqJzdvvUscn?=
 =?us-ascii?Q?XJg3+70oh+VzVlFbmi/uMJuVYP4iBgdFRXHEvKKmfPpKYsyke0WEakcb2iLC?=
 =?us-ascii?Q?tC6+VXFBApl/7ksu/HRetqZb7mUNJFBr+FEqafsBPjHDe3D+VMb06RdbkUp5?=
 =?us-ascii?Q?8Rkfp/sGIAhyNuFF+upqIYHxEWxeqrE0Kb1EllHxB/aUhoLV/6mepdMjH/xh?=
 =?us-ascii?Q?KlvrhNUO/fPHz1HL7slJrtHkkZm4Z0He/BShoaI+Au/DXNo4QCUHsSb8u/k3?=
 =?us-ascii?Q?w/LHmYSHEXcW6F60LrirpYDVsJXJT9AQJ+3hIL6JitX1qyaBDWSjYop2NM7s?=
 =?us-ascii?Q?1X7kB1DeN8mGH06fXUsd4ULhhfnJaDoEz+n56+eGiOb5YGP77lWIMXtQkJv9?=
 =?us-ascii?Q?bdkhheZjUP4up3QSAH6sS07wLT8NSP+7a7GiboL3HIFN1LrqJlAIbty20yr1?=
 =?us-ascii?Q?PiFKrh8+6PrsPuBAfaqTEiZ2D+Qd49nSC+Vbu/ro1nhHtigsKFcigT3eTZTO?=
 =?us-ascii?Q?FmrDVaD5iKSMi5N71D4QzzjEiZdzdDXYeiH9q90Ju1XIPzOdtgw4RU4Io9By?=
 =?us-ascii?Q?wedLtJtqHwu9hV6ubuSSY0B/lyg8pIiIrXVh29Y6+WtlsBLqaxtGD/CAzkRG?=
 =?us-ascii?Q?hIXqpWBVlTXYeiDqgHm8nzSLv532yiuWLTa6dAhQYy1vZvr+sjNLKeVdN6JB?=
 =?us-ascii?Q?R3FbynLNenxeFkBif4T9AOX7InGcS+b3/jDJAT7BIqCh9wRb6zMMZNmkeb/k?=
 =?us-ascii?Q?Qxz6buBSsLzH6quZrdD0FGJ+BdmV8JimBT95YWbMVG3947Mwj/yr96BqiOHZ?=
 =?us-ascii?Q?2IXj8Z+BaJUO8njScAcSd8C7UwjMErbdHJPp+bJC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8435befb-e610-44c9-a556-08dccb107303
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 05:31:09.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXq/oJvhABJ4Mx0qzKvXQpMs4CweOP3eq+uzb1sQL5LYmP2uZLBu2VUwBmdttcZd+x+3vRdRnDhaEbTLT5NbdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6263

Use dev_err_probe() to simplify the error path and unify a 
message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v3:
- Modify the message.
- Add the '\n' at the end of the string.

 drivers/soc/mediatek/mtk-mmsys.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 938240714e54..170319163c28 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -397,11 +397,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mmsys->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mmsys->regs)) {
-		ret = PTR_ERR(mmsys->regs);
-		dev_err(dev, "Failed to ioremap mmsys registers: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mmsys->regs))
+		return dev_err_probe(dev, PTR_ERR(mmsys->regs),
+				     "Failed to ioremap mmsys registers\n");
 
 	mmsys->data = of_device_get_match_data(&pdev->dev);
 
@@ -413,10 +411,9 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
 		mmsys->rcdev.of_node = pdev->dev.of_node;
 		ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
-		if (ret) {
-			dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
-			return ret;
-		}
+		if (ret)
+			dev_err_probe(&pdev->dev, ret,
+				      "Couldn't register mmsys reset controller\n");
 	}
 
 	/* CMDQ is optional */
-- 
2.34.1


