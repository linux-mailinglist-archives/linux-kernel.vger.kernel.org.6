Return-Path: <linux-kernel+bounces-300877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D950B95E9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5765D1F23C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9C7128369;
	Mon, 26 Aug 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VvwcRIQ8"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12343FE4;
	Mon, 26 Aug 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656018; cv=fail; b=pHhtwVtz06UuBKS5Hj64aru/CP5q6OHfzxJIDzBgkX7p/pBS7XrVdLkoOwCPIbYOCm8cTfTJm5Y4yl16Ule3laTYhoF4ADQqrSXMWp8RLoVaXB1i1q9X6nDWLo0inVA+fcx3GMuuTxA30mZGNxe+jGQ1kV4HjZCCRQufk3Aif8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656018; c=relaxed/simple;
	bh=4JEh5659lE4oCzyGydPMyjW1bqFusCVtsG62nasmUeo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GCMch4/1jN+sGbOJSmo9TqFo3xAurAiLOKdLQn+uZgR38ID2F3tpYhshILL6UJsjpNOBaT9/zVAa3IZb5cRBEoLDlMJb4ZcV0zfdMpUl3rm6/uhaiQRJHwoGohMq5CSdMiSdRS5Q3sbbBLtLKpLqf5JzmOMy2340WoIuE+V3nr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VvwcRIQ8; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8Ia4RD+EfgRBOCtym3+x5OvzgkGS85dKAoTtbEY7vwNMyDZAys75xYl0OeYN0sVu6V/uxSu5gJsDLDYLzxQv5Kq1LliGg7aT8atRYnivcyHQVGzTav6NdWgLm73kmY4Hxq6d/QElR+cOLHEdXjzkpMFoToj1RyxLuvOMmLCmeNr7lnBFBwafWE1lTn5Bp4wxET/AkPtK+OSQICZylYDnoGtK8HKOsq+MEHpFHd/Yh+aYHjp/xYiMwB8hAqq//+3H9O9RlwjmjXC+W2u5m7pYjYjYCbbSaCR3bdWX3YS26mXeT9dA9ekLdDCM7aEb+3I1K5Vd3Y090AqPHQngvugzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=Pr5OZlD25G3cseMvZnsH/V7528jz5LD13DJ3CUBtJAio8ISRMirIucdmoIK9s9M3OdjVWj/ckDZYbyXOZkPQ8MvlPzHw+L2hNkpRgWZienKXikKib6EXyTd+ZZtyBk5JGw2/PaYYpp7KKrQSQpGCnL9BIX3qd7LJfag4Ox6MOgMcQoSxuaEdtvEsP3yKR/CypyU0cUkaPVOjvQR1dz0OUAbEzL0IjGHDPVH1QVSG2B4THXUWjDz3IbbtBo5RNE/iUCf35gbm+BVkPgl+0SC9o3j4bX58j9fYBp3qBZMldMKzVXS2H47sxq0g0id/dgTvWv1v8patK+7mFjIzgNXmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYwqVf5nC1G106y3/JeoEY92jkLlLo2RAUiFL4iAX5k=;
 b=VvwcRIQ8QUGiwhXeqaVGbGyBJv0JhXFfx8MNXslgPeDSmnf0p7pW+2rIgyrKqWdqXu07HGLpYgMpr3R6t+KBkUh3tjdocS3b/WuzL7K5wiGXrXOmp4bW2HsOunSDTK1Fd43+iot0wmPAPJ4NTeHTlTc+NBj5A8xIg0Dsi2kZc+s0qrVf98RAUW9463rQ+st+CoQ1KqgJ9XuTuzyj1kco+q2sU6B2QtmyVkqvS9bHYp26QWY3BgTMoC5jjG16b5IhVEwy67nmNm93uc8dx4JEjcBg/lN9FdjL5aENP8T4dWZAisXED6aOfXaWw/U/7vIPmJEM9ay28M3jdIZwAvHlrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:06:53 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:06:53 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lei Liu <liulei.rjpt@vivo.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 3/5] usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 15:06:39 +0800
Message-Id: <20240826070642.1911-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d227fd-bc7c-4e4b-a0e4-08dcc59da9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NW/L+O2xU/9lJGfCfd+hJv/pEjplIB/gx7jdKwn2nkUQMCxstBRNE2ChXZTM?=
 =?us-ascii?Q?tEgEQMfd2EU44CaygqJaRonb8suPPjcFtBPEHDVkFnxkeO+RJaoEqIHDOPu+?=
 =?us-ascii?Q?xST/SiYatFZ/lOU7hjLwIcRTYMO2LCni3w5xQdOouNQr7TiumxT0cdUy3sxe?=
 =?us-ascii?Q?C460hTXWGJKc9hbugSlUsvfjw4eE4yk1z7+51SN5tBC2rx2I7fXMrD1W3Y5s?=
 =?us-ascii?Q?vbdWrK7ab9cQiXm/eYsDLhFGZq+iEPnXeBv6fk9MYY5nLafmSDBFHnzSCjdB?=
 =?us-ascii?Q?dV6BC53CEoMS5aNVD+YH/djCsnvIdgXPUxD7vHS/LFdUkKnkkpnsZ+wGpuJF?=
 =?us-ascii?Q?1HNNXM011yyUemBRLGchb7Hl+a4EPDrE+LKaW9QqCQ4oAiDUx1kixG3MJbrB?=
 =?us-ascii?Q?EkhXJozHSZDuL0IwAB+vzvh6L7z3KHe08Z0cVE0XHvxTj53zvZEovwnm4Frn?=
 =?us-ascii?Q?sipH8RsNbTPAT2DTjIK6g7IRVEqz6igzEwV3aNEt1ccKo6gKvzWoo7+8U4b9?=
 =?us-ascii?Q?yGUI2PhwNFXhhSZ8Vuf3iSBXePQrznUM3VpxFPa8zpMfIlXEZsvbCdtJgnmZ?=
 =?us-ascii?Q?3nwGq7iHKw/K1YyE46iY8ZKHg1Uh10Na6M3YquEVtQJ7QA35ES258WSTjPSD?=
 =?us-ascii?Q?2+EaTYaOPKyUeb8PcaD62FM40zBc0TKOwlYChItpIETP/LH9RxWTVuFIZHwR?=
 =?us-ascii?Q?iAd6fkSaE0TxJM+F+jQYsJPnL2daPoppoylxsFGwlkeOonQrxMqH+FCQgfIN?=
 =?us-ascii?Q?38AXFL6NRSDN2ZfLZYTY6ekbfCpjULUHsrCM96psUez4JFdTGJimtB1TRqIr?=
 =?us-ascii?Q?VXFVGFS907GIvCF9FW9lM0dzOwxfiwfsByQcLWBd75BbbjT21+xHGSSBTAr9?=
 =?us-ascii?Q?6oA2KZO/Vdrjc4e8rYngeMB5LLOycgPfnz71SJZKJfcd+clIjA1SlKU0JM2c?=
 =?us-ascii?Q?6Z4gStsK5vp6zQ3k+zCbXGSDNY6bJ4SXwrMRWkbkWHiiSmH2hHLOT3FT5yRr?=
 =?us-ascii?Q?sNt1SWfE5aYbEQ/WUfS6fTKAWMhnGTNP4FnWlPe4vlOj+ZQ/SIGrHOSnTVB1?=
 =?us-ascii?Q?Cc8MwF4PrHfpvEejsD/ygMmKuum59wGk9WeRQtYX8CTq2qKTmGM6t6zdz9cz?=
 =?us-ascii?Q?7YBko6DqJHXQAtiaZWRmTKdVXc9dKaeAZzg2ZvXIl/eThpSxI0C+BnmPt9tu?=
 =?us-ascii?Q?ARLSWxADPH7lynUt10sfI0La+RGxe4Gx+fG1zwGx7/fk3SJBCjKZbp3lVyqD?=
 =?us-ascii?Q?AC5r8CROS9pT+L4XxYI8EwI0QdFU8jC6WZS4Maw1/avaqOVBzsCwzuV8PzM9?=
 =?us-ascii?Q?fyZ7FAwvxKBX3u29wR9qOKhlF8cdcXfxh3Kwt6syblCKBLvj6pp8Ylt5gfbY?=
 =?us-ascii?Q?wc3VyS5xoTRZimzPILiTHTen1FM3qQGXV4PWJ257T+pfQsdnew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CMsnUeyuiY0HFMWw0VI4i2lxzDHP2DBe49hK0S/CFTGxg6oyWFAgV35Z3eN?=
 =?us-ascii?Q?g3d6P6J1pHh+OwMw3fauVk77cMeCCromWlC0djZt/+MhGiYBMlMA1AJJarwk?=
 =?us-ascii?Q?wb53sKJIXQjp/tHrQkEPTh0HE8lkUPqet4wl0T6FGxMm0VqOwHP8m58XzVHJ?=
 =?us-ascii?Q?7M4RWArztWokMp1cHh1mrn4YkhulGm71QIcwIBVza4bjKvV8irE6DSz2OzSj?=
 =?us-ascii?Q?rwvHK8EQMXKh/HgXt43Anww5b7UrP4IPUVlit6QO/rGitJQ+aGWQMOKTL1QZ?=
 =?us-ascii?Q?KVS9gH2UqGmFXPBXc6vfOBfXPdkSVM56hlri2fg9GHPv+cUfiYdiURBC69n1?=
 =?us-ascii?Q?VDwi+N8K1489vxu0OLkShqV6Nl2MDqGYey25Dx7MZZu1gedVVsuAhVkuvdNC?=
 =?us-ascii?Q?ze4l6ruFiDzTUtw3IWfZkNyWeTlnmU2289xQmWmLNNAfN/3iGJi1AhPpP4xM?=
 =?us-ascii?Q?HxEe1kFZvNy5SAJm9JRnte8rgzDitwA/mHSVnf6rVtmQhf1yq5mBO41WYOst?=
 =?us-ascii?Q?Jphfa4bh2/px4i9zq6/5DxpU+vp6oDcFSqTW16tVZVV/pTDVfseIJYLMW+s+?=
 =?us-ascii?Q?THnLIVqEFPXORJHS35w+xtop4sPuGHQgfQ4ymxD9vRhajdCUnn9EQ+yYHgoy?=
 =?us-ascii?Q?tcITyjLEG6Tgb9SBV0MSrtkkSF2HxwnejH5YKRbEcjZJMrQyzDP0HsNsxdYd?=
 =?us-ascii?Q?vfJvZp7eelt0Rg4KAabW2bZH1JkqdBTR1RYyHNY9UjCHZgAWz30a+D8MlpbB?=
 =?us-ascii?Q?0XjXtVwC+gVlIeVq5Re4HZYXGgeDkQ7fuAyvLFqMYCY/98qdYQMlExZbZeSg?=
 =?us-ascii?Q?l0pwFty9O6P2SuLWEvvn17/TD9uaW7gisI/wBOO0MV3I1Srjc6fir3Udhgoy?=
 =?us-ascii?Q?0ej3REWiuk0sMV8Baj+J2EP0VZKOPMFZ1I73ik7Flld7oQ0wkdMp6zCjwMKQ?=
 =?us-ascii?Q?witgSSYm8kZcWIKU/wbQ0MflPixGg/V63j5S9ufN3tzCJQAC8lhvs2CwHGn7?=
 =?us-ascii?Q?YqhetHamWCnkhT187RWDBXuJIQcr/AY4/sfuTZbnS1HmcibA6EZIJgBvbWY+?=
 =?us-ascii?Q?yL8AcRuWsFsoTsNbe1pOO1PcJZ/ciXeAWPIh+jepcJ/s0EAHL/u13ZSQkkEK?=
 =?us-ascii?Q?FOoyvrKgRAEW8NVhQ74Cain4PH7eJpNURtNhSpf5C2t8VNdzudgNNxL3pLSh?=
 =?us-ascii?Q?bEXd/zAaqYfjxMWsm7MF2KFxO1Y+JSjAfJ/pgd6Ag75xdgxuzbYEebuHu7FL?=
 =?us-ascii?Q?0CTVDRIt5FpaEKfEv50A2LbWZuIHY5VGfsmtkExjweUffaj6mXgPbUPvqzuz?=
 =?us-ascii?Q?OvSc0l6Sz4G8f3AdNqmdwuA0iQBFHPzYTxJpMU5qyuCSKVEiWCEbhNx+1yCd?=
 =?us-ascii?Q?VQAGpTODpq272yURDpzMQpLZcCmnkSSn3eMz6v6wSjvIruFfhY3Opp+fS61m?=
 =?us-ascii?Q?1h7uBj43WmnG9Zhl3USNPd3BrPBlBgWx+sM5uaK4ExGDTx74VNKEG+cHZLTt?=
 =?us-ascii?Q?89RdOreP2a8q8ZnI+tdJ3G0x9k7jCpIHafTgfQDwGY/u/iatqzbE8ogUVVgN?=
 =?us-ascii?Q?lbXGIddeHR0b/ND6nlVpqnq0vAyxhpGhlntaun/E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d227fd-bc7c-4e4b-a0e4-08dcc59da9eb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:06:53.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbJAorJYnatpe+U8KYKJc+rx07TVSnuKbaESB8a5g6dS+jLA40oubBTaKlq54uKdGOByr6Shtv8mjtCGTk49gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index db4a10a979f9..bdbe5ead741e 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1812,10 +1812,6 @@ static void r8a66597_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-
-	if (r8a66597->pdata->on_chip) {
-		clk_disable_unprepare(r8a66597->clk);
-	}
 }
 
 static void nop_completion(struct usb_ep *ep, struct usb_request *r)
@@ -1876,18 +1872,17 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
-		r8a66597->clk = devm_clk_get(dev, clk_name);
+		r8a66597->clk = devm_clk_get_enabled(dev, clk_name);
 		if (IS_ERR(r8a66597->clk)) {
 			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
 			return PTR_ERR(r8a66597->clk);
 		}
-		clk_prepare_enable(r8a66597->clk);
 	}
 
 	if (r8a66597->pdata->sudmac) {
 		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
 		if (ret < 0)
-			goto clean_up2;
+			goto err_add_udc;
 	}
 
 	disable_controller(r8a66597); /* make sure controller is disabled */
@@ -1896,7 +1891,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 			       udc_name, r8a66597);
 	if (ret < 0) {
 		dev_err(dev, "request_irq error (%d)\n", ret);
-		goto clean_up2;
+		goto err_add_udc;
 	}
 
 	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
@@ -1939,7 +1934,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 							GFP_KERNEL);
 	if (r8a66597->ep0_req == NULL) {
 		ret = -ENOMEM;
-		goto clean_up2;
+		goto err_add_udc;
 	}
 	r8a66597->ep0_req->complete = nop_completion;
 
@@ -1952,9 +1947,6 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-clean_up2:
-	if (r8a66597->pdata->on_chip)
-		clk_disable_unprepare(r8a66597->clk);
 
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-- 
2.34.1


