Return-Path: <linux-kernel+bounces-316512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60A96D088
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0035BB24DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045FF193411;
	Thu,  5 Sep 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CHnS8Pqz"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B72193434
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521825; cv=fail; b=T0jwEfCcnLI8RBzZ52ixHkoEPtHVcCBabhyTbLvsvKq29pxVD9OL+HYdddIcNWFbTcgiSNASS/6Nbt0BVBWU2F+LaIHEiDLti6+jo7HtFtIjx9LLGlYQwgHH+CztYmNqTTOdpxQUA09U/G2t/wsu39E109Ln19YbvuAJoEaXMKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521825; c=relaxed/simple;
	bh=CsUsnJy8ztpf35b0ZzvNRxsSC5u0/Y1KmIwlmoomrRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eD7dpZJsek0EaU4MVDKdQywTVSAnOXn84nLaSk1T/4ArKH5PZ05vsTYEnqgeEmiNEe1+7szQKhX5hZJgQKKHIS5O+FvUrlOEQyDFq1AE2GNEXOpDlNiCKwBrVjq7UTAlhqHKKNHeOf+LUQxfD77AiH7AmCK7Btq34DQ31sfF+b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CHnS8Pqz; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkO6KOvnuDtWg2c7Rm45rA0kdMjfVsOJeegVhYdVi3K7Ej3iwEGvPJr1J+XuPnK95t4BQl+cAarIu7pAqUkxoSoPr8PGkMBYuzVEOH5Fs++jApzE5YNW3sBsyLZ5jiOxOZ9gGmcqXw83XSirpVsenYOraKEpFYbiIMhIScfgfayt018RUnYXj5yQ5SjUWBo16WLxoUBJvhX9tD9o89qWzii46EnwSnLBXxMo4oUE1/2ZxGKKBy8O5vxmg4KEyc9nAgyxYl2l1u7oo6Kni8F+H4ivPR6zo2sAtA6uvSFsbEt9kRfCwhxEkjgxpZT93d3MygVKKnOW105KoEGp24hPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx4y3l2O4+orKNReYkqXIuKrIO9LyEVNaXBtRVkvCPQ=;
 b=GxDeKgG3bQ8Z4EgAmX0+YNhjhgpcu5LBP7J+qW44XsfAOtGtHdjr+X4nwkx8Vi8XMeUmQcH6LUfuuMC9tTEkr01+UpifPsxksMuFaf9bJRd4H/u2jm8/fJGRRmTPf/C2iqHlTnwnRrJBu8wLLYEvlSiwKrVosdgpSM97ei9hEAUzr1FDgS18sHALqrYrkRz1b7NSDE6N5VAeaVEzTbmHij+wzh9/KhT3nos9rcsicUpl2WlueidEOZMp5lSt29227UJtQmhlb1GHl0NEHzfmruERtamcEIzMx5wbV8VMHkU+s/DrkhGhm9xuWFgK151KpVBbTHvvcPvzGAEiRh3HDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx4y3l2O4+orKNReYkqXIuKrIO9LyEVNaXBtRVkvCPQ=;
 b=CHnS8Pqz0ExUE4zdr6ZgrY6Pismh3QMOX19a4GWLAWTMKYN14683mxAhdXCXovvRQqjj79zJWLYSNr23C3AbeV9N4P8Dvuhr9BfdKRXfOGYvlh+oYY0xDLaX7t4jp6hHjA3FtjkPYrunT9UE45qzLxLBxbSfZvR5xi2BNNOXUJZnTLu9s2SjOXp2hg/Sgq6ySphSqJyjwm4K93JHpqoG8smAxnOha9lRWcRCvFHhowGNIS69HPLoQpfunvuCRn4o7jdNtFoPjjYA17rDZrG4hYtInSgvFx53qhdvWCwSCl/so3JFYW+c4L7SH6SK9PqbjCU9+agsomppJcSQszLdGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:37:00 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7918.019; Thu, 5 Sep 2024
 07:37:00 +0000
From: Carlos Song <carlos.song@nxp.com>
To: alexandre.belloni@bootlin.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH V4 2/2] i3c: master: svc: use slow speed for first broadcast address
Date: Thu,  5 Sep 2024 15:45:57 +0800
Message-Id: <20240905074557.3810026-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905074557.3810026-1-carlos.song@nxp.com>
References: <20240905074557.3810026-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2feb133b-771d-4bd0-1188-08dccd7d86fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FL0L03QJQSDjbJQTUrI0EmFxRpEEQjWw6jq1nEbs6kJiub44BstWpKKXMcuA?=
 =?us-ascii?Q?upNvCUv9NILl51h1DqQ9FEZnOofin8bSh6Rd9h01UwkldjY0ttjDgOnzqZK9?=
 =?us-ascii?Q?8snIfISGWnNKQfokjXqUqfK/EdM5+jTX2llW5hBta6Y1XbAkIjrZu4vU3xZC?=
 =?us-ascii?Q?xU/heF+EzWjpZFdTQfGzQO1UiedXbNKXlPG+ZO3L7gUZorZLfLrdyOzHO6KI?=
 =?us-ascii?Q?LmkIykTakD5JlMsYi6YpAas1e7hcgeWLK1mjne/NCLzhMo+mxnGUFAUKWpZp?=
 =?us-ascii?Q?KPzaKymEoeq+aFWzAWo5obrFxUvb2ujz2xSr0ZqWwZHeFWrabT08ieAeb41Z?=
 =?us-ascii?Q?IXYZfRizvSIGxLO08f5HXILhNBaaHL/imK44ruXnSoYB6lmhNuYV82/Ag3cy?=
 =?us-ascii?Q?6RVkNmDPb+FeZWUWHpdZwjapuYLdLChR7ZFvnOvcjNwU+iFs6F9NBr2G/xm4?=
 =?us-ascii?Q?Z4Wm1P2M7C5sWSiIyagnuKtefPaMtrlaRbFPVy3MfWAjVXFuxQAY+JA+jszk?=
 =?us-ascii?Q?ea99pDSyKSgUOvgdo6+rBq7Yc2LudH8SiTifQ5Cc0PUlfOci7Qij6/UMECx7?=
 =?us-ascii?Q?OLLi8PNZng6JpB/GSXugEbfVUMua+KTuzti1+Tf/Cn0jZebY0sZXj1fnxD02?=
 =?us-ascii?Q?2o5M2ixjKYAdQGm4Ye5eX3IK1f32kPpamAMiYplL4MM9+/6qa5l0v9G//HPI?=
 =?us-ascii?Q?okr6BzHp/GOkhTYsv7q11eu3aETgMmNPedFeWO/0WQl2dr6bH3L2LhPAw6xF?=
 =?us-ascii?Q?ul0crRb274R9gf1Zqoypt3sZNSyPnExY2g8bwpUlnBxsAUKLeRIKuv/Qen4h?=
 =?us-ascii?Q?oTsfn/y2GZy55MOLWPwJvY3G2COzgMLawm+mDpPxJs8xexsLYKrWTp+soOzz?=
 =?us-ascii?Q?+wZDtB4hDO0X4qFogaf9zVcM2zZoS0BkhRd8YQHz7wE3+6FHCAaVFhxpwQBi?=
 =?us-ascii?Q?Ow3SWfry/TrAUNQMCIL0M/SXPdAkvho5fM6e5+gCy/V9aHjPdO6Bbcavjbfi?=
 =?us-ascii?Q?pwyzpDXTwxzDgyC/Ox1gKoS9Vczoj3qdB2CXgUSNMbSjofFTglBsNAZhXaSu?=
 =?us-ascii?Q?k12/cSZ2uSfZ2q55pOiJSrvmbMozcgOcUIPaXrMvl5T37gnc/OA67dePoEUS?=
 =?us-ascii?Q?JVYmcIOQPnkd3FviDEcHNWQMCGACiFAi60ioSdbNwOBTLCrPEPzTEXWz1IRH?=
 =?us-ascii?Q?3dTNHxUNrvbZVz5wNXv9C7q2iPjYFYzGSaJ+nrTNCOaarNOARmQjgIblJIuW?=
 =?us-ascii?Q?ttkimyCNcDmE+Vfco+KoS3HdcHfUelVPIVaw91/tvHUeqg5h7A2ZZcYbPowF?=
 =?us-ascii?Q?7nZg4yWukASDc+kiLPLHkEMGpJxxsmg9fUjr5JQLZD+Nq9IGmiDbzPvBJdZm?=
 =?us-ascii?Q?FZ4/LTBPYq+R4zLflmxLwjrwyDmnNGEG3OzBBDg72+EpKzOH9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+J6wp7oAzyzMl9ncwI96UobBZKysl9/1odRwVpPHd3RM3Dv/SqvB9wZWNq2?=
 =?us-ascii?Q?cPNsM4AzoMXAm4kCbPR5OHBx/uAS9pnjRAQv6wIfpRgY9PJitwlQkklvtq0K?=
 =?us-ascii?Q?h0YKK74IA+I6RYjs+hU9roMCB1JOV7cjZfVyoq5SuOW2cfyXGFBUMhEe3I9w?=
 =?us-ascii?Q?MPzQFlCSX3NsoCm9/V7l8g79zy4tRGYN12XGkEh/oBBo9X2qFlVF/IwDzTpI?=
 =?us-ascii?Q?BdtNsNzWd0wF5o67lpSIIYv1OJ1HF/sApG3wa+rzSc+CCYFmIXM+pxeFC9u9?=
 =?us-ascii?Q?4ddM1oR9zTU0Mow9os7/2Jmf0ak38eoht/OYGNg/SE6kiQjUJ72BMjYBAgvj?=
 =?us-ascii?Q?q0IRTR6NYm3sI6BGPbXubW3ISkath0SFfrLNXAumTa/ldtAEAR9VmbYTd7c6?=
 =?us-ascii?Q?222IMQGXgu0OGHzqui60gl46pjsvPLheQS/VFC3pP7qL/axxo8+LAlXtaeDc?=
 =?us-ascii?Q?XpSAgh4xtfrGSSB1GJbDu5b/gBXIYg9z4HtYygCLOxJEnWkKfLEIWZIQDMTx?=
 =?us-ascii?Q?n7galKlD2yDPDqvFXNOuxEF3tFNUtow+v+SM0sZRarKsUYyBdTZ78EFDTw9N?=
 =?us-ascii?Q?JKxY7NmRlVvWu9SIFKEunJ4JQEn96X6ITgZFBFv9tpXNANcFD1Y5A6TBDPI5?=
 =?us-ascii?Q?5X63tUXisJj5acoWAmQvZ3Fc85gTYkvsQ4w4wO04jhy5DKL3oKrpFjZhF10H?=
 =?us-ascii?Q?DQe+ywfeRQRuKj2XdqVNHdW9k7Vk9j0x24aEVxzexe0cA3hxcaoKJIBHP9Tm?=
 =?us-ascii?Q?AbKnB9fFRE2UwzbTpAhAJYWf57HP1F1T4DmlSQvhnv+g15VRBBYkEaxiM2Pz?=
 =?us-ascii?Q?IRJ3KpG+lffEwnTxs7/JIytfDzPlezw2lwW9sXcaPj8NlKiwMsgBROQBzgM3?=
 =?us-ascii?Q?VPmXoqLk4CRbKajhudap8MPBIa+ZcUiWWMY6MPKN9+z6R3rAnyuFTmWFiiOZ?=
 =?us-ascii?Q?lhoUbs+Tc3smRRk2MuNRYYpoAqpfdhrpG6EiOQ2oC8S2l1i80I/1noEKRgUF?=
 =?us-ascii?Q?wtpGY6BcLUzRPbkSOpL6XzB7yx+BXzGr5yR6gC1ykhGglLM0BWtBfOj2+U7e?=
 =?us-ascii?Q?HsrIscUXE/ag/BoQ53WOyow2eynG2bCMYqWTtWpLTZAcDJ9PAQ+PACXCk7jI?=
 =?us-ascii?Q?ToQPdtbIjlU9icQqjqssBH/hUhL6CRJZb3Xqjwjn/2Qf3tr7BVYD2XhwyRMC?=
 =?us-ascii?Q?Enrf3p7Eyy6Mux3D6rsHN64gJT1k2b99bKTOq/5czsckNeclzH0JOfmzuAyW?=
 =?us-ascii?Q?7Textw0lqhA7ho/EwpAZZDgqloXu0qVs6vAdoYSnN338xS++U2RxPa5m9Fkz?=
 =?us-ascii?Q?8GU2W/+gCcXY31lAr5doaff/Xa55cpQHEEoMFNgrEQ86V6ThPPAeMt7n3zrn?=
 =?us-ascii?Q?WEGlS5/qQKYvqPxDs9Tm0AEIyNRkC/R06ONYNHHaVh6PcicXl+Xla6yQs7Rn?=
 =?us-ascii?Q?m3eRDB7DRbmwUSrzQTbVuwXXKAsMOUMbpxvrho/9y6gSkoGKPcHbU19trRQK?=
 =?us-ascii?Q?n2vDILcXVTp4gk4zQ6cue7JF5jPlsr6XIh3p3GS29kf/HSy3hqBDJT7oUlhg?=
 =?us-ascii?Q?+DXQvxEfbdun7uK8hg3y0Aalc2CSnSm9qORChNEy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2feb133b-771d-4bd0-1188-08dccd7d86fe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:37:00.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhozXW8tW2QMGs7YXyHiDmnzPB1LZtFaOC96OHq8yW2T0uG1h/N4A2sVvQ/l1THR+0BsQ88fDHZDSX9efGc3Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429

I3C controller should support adjusting open drain timing for the first
broadcast address to make I3C device working as a i2c device can see slow
broadcast address to close its Spike Filter to change working at i3c mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
Change for V4:
- No change. Send out together with I3C master.c fix patch.
Change for V3:
- No change. But miss sending it with I3C master.c fix patch.
Change for V2:
- Adjust variable definition order
- Add mctrl_config description to fix build warning
---
 drivers/i3c/master/svc-i3c-master.c | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7c30f58e344b..423db3dca257 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -184,6 +184,7 @@ struct svc_i3c_regs_save {
  * @ibi.lock: IBI lock
  * @lock: Transfer lock, protect between IBI work thread and callbacks from master
  * @enabled_events: Bit masks for enable events (IBI, HotJoin).
+ * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
  */
 struct svc_i3c_master {
 	struct i3c_master_controller base;
@@ -214,6 +215,7 @@ struct svc_i3c_master {
 	} ibi;
 	struct mutex lock;
 	int enabled_events;
+	u32 mctrl_config;
 };
 
 /**
@@ -531,6 +533,54 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int svc_i3c_master_set_speed(struct i3c_master_controller *m,
+				     enum i3c_open_drain_speed speed)
+{
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
+	u32 ppbaud, odbaud, odhpp, mconfig;
+	unsigned long fclk_rate;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
+
+	switch (speed) {
+	case I3C_OPEN_DRAIN_SLOW_SPEED:
+		fclk_rate = clk_get_rate(master->fclk);
+		if (!fclk_rate) {
+			ret = -EINVAL;
+			goto rpm_out;
+		}
+		/*
+		 * Set 50% duty-cycle I2C speed to I3C OPEN-DRAIN mode, so the first
+		 * broadcast address is visible to all I2C/I3C devices on the I3C bus.
+		 * I3C device working as a I2C device will turn off its 50ns Spike
+		 * Filter to change to I3C mode.
+		 */
+		mconfig = master->mctrl_config;
+		ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
+		odhpp = 0;
+		odbaud = DIV_ROUND_UP(fclk_rate, bus->scl_rate.i2c * (2 + 2 * ppbaud)) - 1;
+		mconfig &= ~GENMASK(24, 16);
+		mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) | SVC_I3C_MCONFIG_ODHPP(odhpp);
+		writel(mconfig, master->regs + SVC_I3C_MCONFIG);
+		break;
+	case I3C_OPEN_DRAIN_NORMAL_SPEED:
+		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
+		break;
+	}
+
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
+	return ret;
+}
+
 static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -624,6 +674,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
 	writel(reg, master->regs + SVC_I3C_MCONFIG);
 
+	master->mctrl_config = reg;
 	/* Master core's registration */
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
@@ -1658,6 +1709,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.disable_ibi = svc_i3c_master_disable_ibi,
 	.enable_hotjoin = svc_i3c_master_enable_hotjoin,
 	.disable_hotjoin = svc_i3c_master_disable_hotjoin,
+	.set_speed = svc_i3c_master_set_speed,
 };
 
 static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
-- 
2.34.1


