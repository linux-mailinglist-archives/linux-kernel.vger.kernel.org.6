Return-Path: <linux-kernel+bounces-265263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E310593EE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCDB282600
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91A12A177;
	Mon, 29 Jul 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d3Hb5lr8"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192F12BF23
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238705; cv=fail; b=hPdWAPwqyd6sH538zKGHS+FBEASRT5xaUjKOqlJjFPBPJMpkrKmG35U/NQ1cXoTSOcUFPq85222SXQuuw02TNA7mXT0EiPSQh4W8PlhWn9x9dUI9vcbmhk3Ot7oNoRRkokuNQg1kMYCk3PXWg6vRktaF4xKoam5sU0NlSDgbgDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238705; c=relaxed/simple;
	bh=eJ5SNdVVoF0XtsgfprGl9ayTteShMbsE0ORhIk5sOzs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DRyQgs4ftfREcEWSbr6m47TACUShWnu5jpLyByxhlaMy21WLRo9jUb8K5pP/x5TN/xD3IM4xDxAJsneQ1iVriXjYrS02Jc22wl/HPvf6ijkd+2ZBYQHdRdVi2Ls1zOjAVdWQ6gS6NziB7I4+5+nb0kreMgu6mp94FbSTl8Mllns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d3Hb5lr8; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLhdc0kau7ruCYJ3h0gw9dg71WCw8S83t3NaBRXFxBHfDxFlybyRwMVzGRsIpcWxvhcrJ81Pw2EohoMCOP5+TTE+9QI/UTBjy6A9ohn818JHWYjpA7szBAzmTAt0V0bMUtWf+CAzHq6yD5QX7yvg7yVVJX9p+i8b5PagjuzKzMAb2Or/C8lRAWZzHh7TXqu4K34aUxiJOWidSE4JkMnSUoqD4QWEEYDzsGbiOL+bya9CDXAvBcioQHIKVj8AZzGenU+Xg4O3BuBLAvTQnADCQffGwy66ACgMz9+0xPfNKAS/NTjnNAUX6+gnMbsCWPXqc2UDZpLSzRMaM03iHSHIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlWLNdaxiVLj+jo6z8oPvLsrRO9t1OFmgrzytngQcJ4=;
 b=rMyMx7VrbRwz/cy7FUjk3EwXWhIVlFTusFy/76w98515kAlkDeW8uWk425fotu0N2wObo/n1K+YxYUncXr2qHhj7W2FDxdZOnwcWjBd+17jIda/7RKfaRSf8Mg8l+P8RgUIg76PtujLqPKjBZXJ+WjaGJGa0C/ijQqiXOzXZYyona+58LRhPlKf+6mvn4JLya13pSbhEAn1zMldAih5D5d56rqsHgIQk52tlmJ+OSfXnVs0skmb63JwL7vrvTPE/knfiokJXotTlFvNBMmFgr1UVOm9idopKy7fMUKLbgoZWyhS91leD9M8MPmZUq0zvS6rLHsecekGNoBUKGmOuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlWLNdaxiVLj+jo6z8oPvLsrRO9t1OFmgrzytngQcJ4=;
 b=d3Hb5lr803im3xiQ3hFUO/jGfqByJChH1H0sEUoQ92ilm8shBuivDzFOkXyFCZYIAz/BfjvYhodriffVxIXY2GpTG/GInAeg3ruBES59tEt5c9hsqV1+HiOzQ5rqVkJAV387oXIXFYXqxD4W5sLRqLzfPZ4i+XB32wrRjj+S4fUOZyuoBcn/9nKMxJDYqlOnDOam2waCtx1cu+XckXn7JRsBw2+p2X/gXLCXKeAwUBYMeG2bsQWYRS+/ad0RyvDhXp67erfmvMtccMZzueVHdlOqcbB5Ff9OfZXQIlnUXKj8GO8trE7cAKsGhmz+vx9WBBt7TX3NS9YtSZyRTvkR+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9671.eurprd04.prod.outlook.com (2603:10a6:10:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 07:38:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 07:38:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: jassisinghbrar@gmail.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mailbox: imx: use device name in interrupt name
Date: Mon, 29 Jul 2024 15:47:09 +0800
Message-Id: <20240729074709.2293935-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd3cf26-076e-439b-ec64-08dcafa16ab4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lBh54U541K8DmEfR+vyDcHA3movXOGneiiugWE2hafQrefzyZHtK5EDHdXKk?=
 =?us-ascii?Q?yCI5ISAY/x7QdKBeFyS+ct+hl4U/fPMNZSn5PH446zfu9qKYpXI50qvqXCrD?=
 =?us-ascii?Q?xBlKr+JvZwUOkwrmNbCrjFNmY8XWN2uEbZejbeQA6fwAg1FLfgKcQRhqKQPz?=
 =?us-ascii?Q?sLrTT6NdqB2K11YLEtqc1v8R3CNLmltI5/Ie/y/d9348Teetx8g5FWNkoZuI?=
 =?us-ascii?Q?eFqA+whfwW5evox5uAOPoGSVT7dot4Tz7O8MppZ/2Ro0lkLozQnhEw/cSFn8?=
 =?us-ascii?Q?vs9l/zGQjU7xdwszBOyxVQCAIUupDI6YeJBS1jhKX6kc6368tIor/ehYlAyx?=
 =?us-ascii?Q?KWKE4rn1ZrN1RfOnL/Tnr3w96grpOhiinEKKnVBceBiXIP3Nue8sH0Pj1Ldr?=
 =?us-ascii?Q?HEntOXJZv92Yn2IicmZ+bTifIFzD2ADlVEBPr3vyI/1xMMkNdHu8L5hTtI63?=
 =?us-ascii?Q?VvNT60IjTfcNgUwrjQKuVShKAftDZE8Khrr+okKwrc1ZJa3kgSTQil2EYHIB?=
 =?us-ascii?Q?+KnLDffg6US1n/sbalYznVt9G1MXZFQ1taW/H7vgJkwppfhfdsfDAGYuI5Vu?=
 =?us-ascii?Q?VSrTTdxIe1A8jDnyisT+hc+CCQfqOryJCdqIMRKWJnL+1imG07S4epVjOUPR?=
 =?us-ascii?Q?b1F7Yp41V0PJIIZVtf56xjkC4Q8yCAHP9JEEyNwv4XCQZwAz0RJKm9QOuzY2?=
 =?us-ascii?Q?8dsQmAOdKmW81fVFRhm4kK15cEnJ0E4hycGROPKDjA9MYNehXRas4TzwUMZQ?=
 =?us-ascii?Q?hnE6l8wOmqVKLAHVsemdPioJVjbb0/BgrincQ7JXrRTBdPluiyhRTHjZgRc0?=
 =?us-ascii?Q?KwPGB31Q56gbdHBq4Askvq38T/Zht2WFxRpLK+uh58qeiaY4to6Fx9WOnTf1?=
 =?us-ascii?Q?PXG8ayHLHFtc4Jq5HZbT/YXWuYqF3qkfpQXFwjnJYdHNq67tlCYy0eQc3UQC?=
 =?us-ascii?Q?4d/BIJ7gTxmtvPkcdG5sM8V31gHyayBl/c67xmJTw0acWOTmCTlyh8p9YqCs?=
 =?us-ascii?Q?slQC/GMx7UrxZdxpzPX9c+5pg3eTtVoNCiWJwX4tiriWtw/sqx3Nyk4ClS0w?=
 =?us-ascii?Q?4wl/tgwLuIBPkfKM15Mr4u2wlNDkonMWuwa9tlZQDZ9ePI7qDH0sOlOj7xgK?=
 =?us-ascii?Q?Uv4FNWmgJQ1qa9Ma1z/SMN/VSnYHWi5lMcZnJBfy7VTw71d+RAfuWN9dhzlT?=
 =?us-ascii?Q?SxSjAKpmIGRyKKXCVUrM4BuDYQKLVQZsMfUjLDCLjbDSv5dcO4fbL+B9nCBG?=
 =?us-ascii?Q?lSx14X1vk0Pcn/4jrHckemRluR7rGxD1E24J4Z73A9ICNZfvJvxRsmL5aX04?=
 =?us-ascii?Q?sguK8ZsF2ZXVPzhR028Xv2IMEsyFNaoZFKWzUTihSY+1Oeg/pje8kz5FP9rh?=
 =?us-ascii?Q?EmTikqyd9rutJTUrahrndV6RvVPYCJMdBRtvj4m8uLcRyBbGAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NfEVLUM69pwDc5NEvA6a9TYXOLqd5tLi1Q096v3+6/FejJEE5Ee/vMp16qNH?=
 =?us-ascii?Q?KxcZRrQpCd49WOVlFpl3NMdk2rJhsJR0CkZgOaRl84Ne7vM8FvGIkoHrBr5v?=
 =?us-ascii?Q?FbFiSaF0ZMA/zMPWlxBGUw9yJhci4+OmLkBUNGtH0x3YH1NJEAu/CquO4lMR?=
 =?us-ascii?Q?cO2XRkXRFuvBBEzbWV9Bct3GHTsqlq5ukE4Fu0Wq0YRGYufzOb/VKyD8b/j6?=
 =?us-ascii?Q?NzvFxvCTBc2mEUb2ON+WaR+AFmeJkTrkZIi2mLkJ9hspd1pkASeuuwyu7wuT?=
 =?us-ascii?Q?DrWcD/yMssdMoBq/ZWCMUutnFKIYAPkpk6MqMS+Qs5BRUJiIwMdMZpz8pTi6?=
 =?us-ascii?Q?ewqdtOpWWNNDVsMkYg9tMowfvJSc0DEX+j2s04xW37K95DRQR2pZ6i0fIh/M?=
 =?us-ascii?Q?dsVNh3C2bYze7rV4d8EdUhAz9Jcj27G3fADBkIcudPhr3bJEM/ae1s4BhIrd?=
 =?us-ascii?Q?UDai4jAqP264PxfY7xGkz+Cn44QAN6U+KdAYdbWzEsnwFNr6WAmhysHwfisi?=
 =?us-ascii?Q?30Hn7xg4Sw8bM1TBTgmTQl5KRdg1iXdDfo21JFpGwrK0Ff0aBwVKJtFy+iqt?=
 =?us-ascii?Q?AJnWxi+Y7VuPuR7utfOPOx/aAzWMj355jtRv8M7Mwpea3KqDgJwrqWSTsrDK?=
 =?us-ascii?Q?qVtHfzxOueT/XbnNLCGhuYQ9ZkPK/f1UpzX+w1toZ+N5lVUMsrgYgsPu0DB9?=
 =?us-ascii?Q?oOJjYU9tNHtZeCv7bR3i+LcYcGb/p7i/ZD6cd1Q2GJfoz12xZGm/PjdpHaH8?=
 =?us-ascii?Q?GGymcuQrCQfPT726U7ShCMGW1J7qqEBUJtfQEmTcTjYy2zVuPSrqc4OL8Pa0?=
 =?us-ascii?Q?6WRZ/aBHytaoq6il2ZftmtkwR2/WsVb0vMYat+RxKIjWf4fyMu/rsnWojwHB?=
 =?us-ascii?Q?w2Lkn35OKiEtDNudFU7oD1ETXvY5PxKPzfdHtQGWNmCMVx2AWF8dTjfjeTN6?=
 =?us-ascii?Q?G/S0mtsN6tMI/VvSmUot7UabWPJzMI0wL/260PUsmLdHkSktCjdrG7VeYshq?=
 =?us-ascii?Q?hYc+nCQ9Zec3S+jtEf3I4Avi3NAC/NfN6TGS/EiRgqqsrBg5a0aGFYnEdOeN?=
 =?us-ascii?Q?dHrY7H2SRXtAb+LEjxtr/3y9oBlBkW4sbf4EzoCWVQzBQdfui/oMrVLTZE9z?=
 =?us-ascii?Q?ZsJ4HzU2m9lWVgi+PUHgeYnlgd35VFhO3Os9VC4EGVSNgnUP3OQDJ614hx6/?=
 =?us-ascii?Q?EAGdZuRhEhNRQzfb/yJ0ZhNYAnEbiRQBYrm/J4Y/ZEYgn3TWmc17NO00yjbD?=
 =?us-ascii?Q?HKlXIKZDXnRhOJV2U0q/quISEcIA6LixZh31dNZay4PwYcJuI4rVg5khvguu?=
 =?us-ascii?Q?K6Rl4Y70hzR0QyFwl4RKm7plmBRSAoRO6VkL6KGGKOOKG/uvGIlhLqPNG3wR?=
 =?us-ascii?Q?yFJYNpFzrK+htrZ+p9EXAC0PMJwwdWR/elN//HiSdthT8PyUnHdpBxjDRp1G?=
 =?us-ascii?Q?bzriIgO0lY+GiXTDMhboZ8ELgDqa1jNZNGn9bvV3+zS2hmNsD0k+x0Y49R7n?=
 =?us-ascii?Q?tAyUtFPcys6jhityd8RdiOMHfq2f+nkZ+X8mceT1x7IkPXBVijU4bNXd8wYL?=
 =?us-ascii?Q?BzFGYBxxn9toN1KRFY05K5XzdDEDWZ+gAf/irlfj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd3cf26-076e-439b-ec64-08dcafa16ab4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:38:19.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqrcqCVo5sZs9TD4PSKUXC1OgjMG5FGGFo9Y67wf2Yzz9jwzuhv4XKUOXA3xcp58Sobd7uh4cJtZo+w+dDCiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9671

From: Peng Fan <peng.fan@nxp.com>

There are several MUs for different usage, SCMI MU, ELE MU, RemotePROC
MU. Using "imx_mu_chan" in interrupt name would be hard to identify
which MU triggers interrupt, so use device name to make it easy to know
which MU triggers which interrupt.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index d17efb1dd0cb..f815dab3be50 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -30,7 +30,7 @@
 #define IMX_MU_SCU_CHANS	6
 /* TX0/RX0 */
 #define IMX_MU_S4_CHANS		2
-#define IMX_MU_CHAN_NAME_SIZE	20
+#define IMX_MU_CHAN_NAME_SIZE	32
 
 #define IMX_MU_V2_PAR_OFF	0x4
 #define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
@@ -782,7 +782,7 @@ static int imx_mu_init_generic(struct imx_mu_priv *priv)
 		cp->chan = &priv->mbox_chans[i];
 		priv->mbox_chans[i].con_priv = cp;
 		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
-			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
+			 "%s[%i-%i]", dev_name(priv->dev), cp->type, cp->idx);
 	}
 
 	priv->mbox.num_chans = IMX_MU_CHANS;
@@ -819,7 +819,7 @@ static int imx_mu_init_specific(struct imx_mu_priv *priv)
 		cp->chan = &priv->mbox_chans[i];
 		priv->mbox_chans[i].con_priv = cp;
 		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
-			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
+			 "%s[%i-%i]", dev_name(priv->dev), cp->type, cp->idx);
 	}
 
 	priv->mbox.num_chans = num_chans;
-- 
2.37.1


