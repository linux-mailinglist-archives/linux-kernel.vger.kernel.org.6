Return-Path: <linux-kernel+bounces-308197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A608C965886
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEE0287EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5EA156668;
	Fri, 30 Aug 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="g0d8rHEj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E63158554;
	Fri, 30 Aug 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002931; cv=fail; b=YoCjUnvTOeD1qsc8HETrSOHsbrvQECdkbqRY3v1SiQtBMZw/6vyNtoJYl3knJg8IvBJNrxHQ2JQva1n4XrXBZdk+bAPOEfj4WkZR5dXap2wg0ImKf+uScWnrSVBWZLuvQgP/b86q44kiDTtYoaWoXk4dJ7P0iRhOJgpTxtS+qG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002931; c=relaxed/simple;
	bh=u3Ro8r+I/E/zf9NJVEX8bN/Yovtdi0VNuyB3/P/jn6E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pdHMjVFpK4SfMv7e6QG4rrvZ61t2BhJiQIUTpFaD+7FSGw8vdwBjPLX1bh9yPq42IxG1RJiEGiNwy+myh93oNNjrn47K6RJ7caM8KMu4rEmyKiM6iDeOwQfIbZSJKP0AeCnXJTLPjKlZ52CkWYUkOvr/bK1I34VNGHUNZ2AgVlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=g0d8rHEj; arc=fail smtp.client-ip=40.107.255.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4iH+qW8E59n0f57lRj06IIwVT/9K1ijDwSVcGCJEY8M70Qj2xGG1DNexN62U/qHNCo906aa7Uzj12VI83U5qn1dEWfAzniKyih4GoRlDQDAD6p0jrh1HdR01zxx8iwjGFZ7BqBsmeXmzE8POsroJkrXQQubXRtM2DK1IgPqCnrIXYv+4viSpdCpVvI7FMbh132FI/5mICBLaU1XHjJyfBs6F5Dp4LFgmXVvwpTEKsmTCiW+kUKyzlkQtfuhvujMawV82dmW65JT/bZL822mhXO77q/D9PE/9AgG8Y4sH4ItkzUNdsL2mUuBAyTPdb7HEImUcI5W2knEIqnKTQwStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyYL06JpEE4EgEdruPC6xYYO1yJyMeMp1dUMmDwtVYg=;
 b=PPi1vxbhDkGCu5WaWuwOfXOQpuw6TO7YC9dTd+XJ9I0Y/Rtr54/t95I74y0yJ5+PCVZODPDB9LTLbxFCXV3nCBcieCT4jlusO88+0FYj5/bH3IoKmRirgDeoobQqyB8mpYAwdpeHEzPJwivK9sQLiix6o0o7HEzmqh+KpOwU34iqkmz8X+Qt36vugZG5JgC4DQ2HWoSwcFu/KRGRU54bhC9oIv12tfjQQTJt5HeLv62cK18AeQO34PcoEzObCwHt+gHCUCqdERMAsYGYH4J7rwD7g2PElu5GhxTRQa6aLASZC4b0FYlDYXoQ/DqaRd7Yqmy2ZBL4/2ZSVd2kcWymRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyYL06JpEE4EgEdruPC6xYYO1yJyMeMp1dUMmDwtVYg=;
 b=g0d8rHEjFLb0kMq5BEQCa5tpFwUuE0feoHR/ZEnWdpGXycJGBBAwv9IcznC4MAkyMT8BUBjSgWV1o/pxD3t6tvDBea7871RVG2wu7r/HEWXMnFPjx6R9LkCZG3zVfdigF/Fpnh7zbvkVQY/ZcbjDceTuOqRIQ4jx0ank7fDg5fatBC7qvKSD+gnM+h4tFZV/Nx5tloCGMiJAlJuo6464UboTp7Qgi6x+9HYNDZRP9W3dzXV8U07H9U6Gba64aowIqpXqoRB6E1w4VKwKda1X1JKSY3YyD+KcDx6aE9ZyolJXTs0VYm7KEZcdQK/ZJAef7cEV2c55WB0kIv7DJrxj/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by KL1PR06MB6274.apcprd06.prod.outlook.com
 (2603:1096:820:e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 07:28:45 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 07:28:45 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Chen Yufan <chenyufan@vivo.com>
Subject: [PATCH v1] clk: sunxi: sun9i-mmc: Use dev_err_probe() to simplfy code
Date: Fri, 30 Aug 2024 15:27:47 +0800
Message-Id: <20240830072747.11032-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::12) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|KL1PR06MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e027bfc-979e-4683-6281-08dcc8c5612b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xs60jA5ICs4KzULqqrHoxq0mnh2GFg0pBfYb8H+GXCtETee9StL/Dly9qqwY?=
 =?us-ascii?Q?xecBtMINmaZxlXoKGd0st/77CE2i01x/Rxe6nydL+Ry8bHSr88tfOkHmX4Qm?=
 =?us-ascii?Q?dDRuSjX+rDa6xXoDAPJ/61Erce2PrP1YESnLMr3hJYCw2SwIzXMo92BWMfJB?=
 =?us-ascii?Q?dgJVnf53BF1uzfLEE5ZFVDosSEg0jcPDRHv0TV0lueAi1kGqA+f9jqcIVNMh?=
 =?us-ascii?Q?ohu8XVJSlorIie8n/fZp4em9gOEKew3SSge/3gSIniDY20LzuanzDiMLQucd?=
 =?us-ascii?Q?IoobnwHWjHM6Fp4YgotYU1XtmEYm3pJNdOMnNuzjYwLY8NsiO5CZql4Fb4ww?=
 =?us-ascii?Q?DjE7EroTNfNCMaIIyAXCtY3a+N71ynpIeKty4XfQNKnxFmoLnIHbbe8QX5Mv?=
 =?us-ascii?Q?QPdSNBHFUyzVU+Uu3a5Uaiipm+WI3uJZhuifmIPH9ZLSttjEw30dlMdPzhov?=
 =?us-ascii?Q?zPzYJXkQWIi7l+azsubORr5sGazwxBodPFTa57eAaKlhZMyvPJ6kcHYL9xLk?=
 =?us-ascii?Q?KhaY9wRuZgD3DizeD5PTtuAoUj5CmgLwapoF5sgYZb6IgMSf0Z0QiACjkX3s?=
 =?us-ascii?Q?bsut+lsriGvjxpPZYwDIMZ6ExWP+AzxS6i5h7Q6oQiYxqEZkkk8Xj+8UWLH4?=
 =?us-ascii?Q?bUhMbX8vlhKEAWGlbs8d59+ZH+YcFsubfQ6F08b0+CcVuOrmVZM0ry5sruw9?=
 =?us-ascii?Q?EoYQ4ZKSiQMcG4b+snjcsk/oy5FR1/YwhV1jlCCQuSovVw6tZMYk0XI6k5Ot?=
 =?us-ascii?Q?DTU2Jc2GnHzgqYDHa7TSeIgDP0qDuT6quu82nQ0LNiSS4y7StKF0Psxzttkt?=
 =?us-ascii?Q?DLvIkEkEbX1RVV92uDv3apl1d8+v4qOUDvTpfsh1NqYP+gdnuPH7F8jGgDy3?=
 =?us-ascii?Q?IaWrcchxZiLn0JlekIRVMECMHdUEaCVW6qX8rT5APkGl4W6y3n+LWUAYPXEH?=
 =?us-ascii?Q?R0BAV5rRF07h9b15Sg5ScyU8Kw3zKW85PK99Ze9OR0+E+1ef4jorq1ymVR3K?=
 =?us-ascii?Q?emUMGjxF3bM7c+4UHqN4t/YyavTYnGOd9hXlB8xYr8ek3fcaer/FKRKN+qjW?=
 =?us-ascii?Q?hrp/3K/rOs85YEWHpd/B1wD6OVLBqVQGNimgCgFYsgc8Yyf4z7FRRAvBHUps?=
 =?us-ascii?Q?OmTn4zdcFjq+eML2UbVVTfGJPL0o+fCLpKYF0jqoDP28TM9izXv9njskDaSx?=
 =?us-ascii?Q?vMw34CoiutJvQkib4k3dZJJ3Gi2RHf5NGEcd/SM3zVqnC+umxNIFafzpTJah?=
 =?us-ascii?Q?XUzg5slxzD3zxJvakOMJ/quIrDrECRQ09yX0/tXmaLts16BzOlF+JXslzlti?=
 =?us-ascii?Q?UjSNfXMwUW3vxneLApYXOdz6JXjc3pmNZpHk4CVrYmQg+tx561XmDArI3xcO?=
 =?us-ascii?Q?OSXmwrbKFYmD4Xmi8lOtL0/I8CpRwFZdsOSwMte9/Px09/PcicTd1kJTiUOS?=
 =?us-ascii?Q?HwTqY9TJddE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rrGqoHN7DjAv6VbF/p/H7uRKXJjLlk7cAU0PZ568qlqYp0ALxPFWOam2RHF?=
 =?us-ascii?Q?BneRGCYBj4hU1idc54STYLCvBJRECSiCm/COJrL6v0T6w3/nkB87/3Dr4oDh?=
 =?us-ascii?Q?tdC+UwrYQp0o+d1oqjZeD+gC7F0c6/NMfrG2clEhn9bY2DmMebW+duw5pyj4?=
 =?us-ascii?Q?OTDfwTuD9vqAsEUV3MKtxBaL33ZrtBwPPxgqFJMTuCtNiKgFn1tS9tvqONl/?=
 =?us-ascii?Q?vP9KNkdoVeolVNz220zloOa8Qh25OPDn4z96WmCKwWusDBK7E2+ISQKsv7gX?=
 =?us-ascii?Q?jHNk/h06dd320O1yCSfBhV0LSzOsgogApjxu/f7CPISDtnMNzFK4wxC9R2vL?=
 =?us-ascii?Q?Hv3exhJRm4ZUIyRz96Knl8YSu1fQ95SWxzPbIK28uopaPLNbwHG8pFm3l/v1?=
 =?us-ascii?Q?9OHwj+sfdIk+0+PHerhgVZHZbZPKbed71f78Q+kiW0K7w4OFoXgffhFjAtpD?=
 =?us-ascii?Q?d642fZ6wkOoOgmObK2aahYxdbefiIuQ8Y180ej/du6jL1Ndudex6FkNXv8k9?=
 =?us-ascii?Q?NDtpmiVqFVvfJTghu5j7Rb5fHbFSwW09YwYxFc9erkcr+2V+EoSpMpXW7MO4?=
 =?us-ascii?Q?sYxLPynS9KDPJ7VD66deTBkxav/7phqCiylXQOu4U7POdUt9dC1MGkWpeLvF?=
 =?us-ascii?Q?kHVJvkiiqhKYEmC3BK/PuLNm2OUKRY0HIYBNATiDyK97Z0MXvhUeNvcA6poP?=
 =?us-ascii?Q?W0V+AljQFfNkMhFrYu/SyPhwHZgUaDoE2x/kraio5V1/Po9Aw0L/iDYmiLI8?=
 =?us-ascii?Q?2kCr6HPilGYFl7LjUPpFEu6WaqXqqppPsBaa6gOvn//fQetty47w4ExsnAtc?=
 =?us-ascii?Q?qKc+anNAaiTPc5HEMd487sTkhpCCdcoB8TZQAqAqfO07NO0Bbj/vfq+gIIZ7?=
 =?us-ascii?Q?/3S11J3owj3b8TN2+33YSuax3pELNkB/1eCdw9tqEgdrk9gWse82UDL7oYim?=
 =?us-ascii?Q?yfuFGy5l2KGQb+g7IZxZT5NRwOb33gJnrngBwPxaSiT8orfJVvtbJHNEdgJD?=
 =?us-ascii?Q?KOJEyM3znKPSzfhgXqf2hR9O5YvJCOgeeV5mXQ+5u87VbjhPsIv9tCW6vuZ6?=
 =?us-ascii?Q?ONVqx/behHApoGD1BinKneo9Dblo1zuCIbCpNuFWT+lkHxH6koA1Xt6rpikk?=
 =?us-ascii?Q?mV7FED0LUC2WYsMyQMsmO+Hv50W4Z9NXj/NHuA7QTpqr6+yZ8F8QiA+bOl/F?=
 =?us-ascii?Q?LafPYMgpkSkV41fG1SdoSoWj1PmaS3BL8G9K8GVEBKAFDZw66FWWb1KfXKL0?=
 =?us-ascii?Q?gANqYgGD42ox1Kyw3ONiW74v3XVLRMfERAdndJ2eOmox2AjgVVn0RXvBhj6Y?=
 =?us-ascii?Q?Q6zKQfrO7AmQ3jAxDuOcRwoitzvYWhZ2r0/HMlRsk3jec7kJd3ygLwRKS26y?=
 =?us-ascii?Q?K3Q/BEJTPQZMmRiv6uFp/QjpM87I93c4m2nNK6MFK5ya2ccsVGf8Yzwn3S4V?=
 =?us-ascii?Q?9IzX3Swm4GmNLbVcmNZ1cueStF1H8lNzlPOE4GRYXwUsfiu63rCL13xt/BUz?=
 =?us-ascii?Q?TG61PvHgane9ItiDSGRHtR1KXPgMowChVp8mBX+EOEIt/f/z5FQzwOFitab5?=
 =?us-ascii?Q?YiBVXwjyU7rSReQrIBZBpXLXKNlnc8Q8gTUC0PUN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e027bfc-979e-4683-6281-08dcc8c5612b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:28:45.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy3/YggptzM6KTq6NoJ0t7zLQmKTUCCzycrPMiF4DJdzaZ9IJpjMh5+nZHN+HWWk8Q3lLa7qtU18IR+h9GMetA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6274

Use dev_err_probe() can make code a bit simpler.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 drivers/clk/sunxi/clk-sun9i-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index 91074017c04f..e6b62e421936 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -134,10 +134,8 @@ static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
 	}
 
 	ret = reset_control_deassert(data->reset);
-	if (ret) {
-		dev_err(&pdev->dev, "Reset deassert err %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Reset deassert err %d\n");
 
 	clk_parent = __clk_get_name(data->clk);
 	for (i = 0; i < count; i++) {
-- 
2.39.0


