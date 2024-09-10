Return-Path: <linux-kernel+bounces-322419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8475A9728C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88321C23DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE316A92E;
	Tue, 10 Sep 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gWKhufzA"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6301684AE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944866; cv=fail; b=upaUi70GnXlEqjTN6b77/rMym83spPoUk0PAq6/fyGs8Xk4Cm3RrBMeaUgxP8O3QxqZZSIxjTYLs9vAkzRysRxMS69mx125Vs5BVRDfZQMJTNKwoa1CCF5UoAuxS4PWjtk9y+qMQWcUq239hkkY85gTwqRO99jY82KZydIB5WhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944866; c=relaxed/simple;
	bh=t0Zc+A2q60SYhtENJKabRYeuD/zhjX964LpXpAEr2Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2QxyXIpZmZy7QfznEU3UIz7a8jVrK3sm6bKJwgHaNpDhX8JX1cH35wzYG6kMQwjI7+fLRCrn7yIsHsjketa2/ki2R1M94OamjvpC+uLU681O9GVSVgy1kU6+zDco+Lyq77BTlyBOorgJaT6PJuaY+njo1dlwyUzHg/UfvCf1uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gWKhufzA; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyFy/9Kem+9Q1gvQK2T4Q2aKYslVuCtEL5UNVlpGsYP+R/r26r1jhyDSVYiCNy989GquynFgNnirc55L/LXBweuxM75uU4ppXCKRZnJx3fYAbdAevIZjHlxGmRn+vXalVj4/+W4bbPKmamtnpEeH6/G/xuQgFs9hzi9W6AHzeIAfzIvtzag+KeFSJrs+ou5BMNlqy5bEl8eRRAdz9sJKxsYpKqTF91FUp+4T8hE5SuDOVgp+st8J4mIe8wbEtsRJ6tJb3hj1f8BB/ckGxcYcVTB7fENym0xkzMHCjPcCXrqyfevaH6HT4mwfOMzSBYxfprajLwN9uxk6unzX/TekgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jgYPtL5RXLvu2IOq7Dn3zXwwd7MgHjU4MVS06875VE=;
 b=BXY9BJ+vjYJ0Pg3R7JNPwirZF6qGJRR6iScmgRzAdX0n74I37USmRVTbiLTueOCwpqp/OMAdB/klHcft6ZpURoYMiMFjsjQ+/T95W0SyhDFYCkmzfM2s4o8f8P/OLd5kZa0VX1Hnn9kvNpoCaSfTL4YMTwW/yBDdowlvwNb2C24Aquz73cMIFYeO+w2Tzbkds6NrEFWcAHtp5GdizqIlEVKkGzWtky92LyewNUrf2orjOw9SVoYj7psilCFmfE5cx0pxX4lKeFlJTBQlUcjI3s9KG68g3qFSdwV57vpQkOnr8gvjssTTnwduMpeFQ1eAjyFdGWKpiIJhx/GTDJFr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jgYPtL5RXLvu2IOq7Dn3zXwwd7MgHjU4MVS06875VE=;
 b=gWKhufzAcGGz9lE+8X4y54ubk+RpJc36q02PNiiNkGpkri77r5ixwVhes0G7AHA6iVaMqUnBdooJ5qgP1cgiLsNbwQpK1z/DArafnLlGbPEAIP9F6qDqGbJ1LQiLxCpU5634Aq7UBR2rgCW/1m9OoD+nSsj9Se+P78+ZlY1FkchrxkzWyl8v4xtLivKs74Hrq4a2DaKSUuU+LDGw0vJU7Qy2tbzj0LoJtCjhEvXYCqWbijN2+6zDHLiW/4rlXbA7uBgrevWrgSHe0uFCsGaDazWYM3uDV1JEhYrXROvfcKuaIdcZg9xLKZ7ukNbIkGiulehOBtgcGsv5p40hI1Rk8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by VI1PR04MB7134.eurprd04.prod.outlook.com (2603:10a6:800:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 05:07:41 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 05:07:41 +0000
From: carlos.song@nxp.com
To: alexandre.belloni@bootlin.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH V5 2/2] i3c: master: svc: use slow speed for first broadcast address
Date: Tue, 10 Sep 2024 13:16:26 +0800
Message-Id: <20240910051626.4052552-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910051626.4052552-1-carlos.song@nxp.com>
References: <20240910051626.4052552-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DB7PR04MB5003.eurprd04.prod.outlook.com
 (2603:10a6:10:1a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5003:EE_|VI1PR04MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 913486fb-98ac-4e8c-6418-08dcd1567f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRCNy1gdCjUlDh+GM7VDLiYe0UfiMNH7MVi5cd0jcv+z8uhFljaSnJN939U5?=
 =?us-ascii?Q?0xeMXia89/8pwRfZujGjcIr4a4h1+lJx9NUM1Y3Og5LZu2zMgZLveBhvm/fA?=
 =?us-ascii?Q?mH5DSJr/k7AMgg6tMXbclZABbqmj5qzHB83dl04mbVfulYbfFEPCU/PHr0MO?=
 =?us-ascii?Q?wpwOte7B9Lsz9+Onw20Ib4NnwPn0P9RMsurN1NVIstIRwXc/9f84SooorQAZ?=
 =?us-ascii?Q?AnPZwtQ2xFw1Hg2fbRxBKNcmt/sVtza96JyGxCiP8CPTv68ONcoEuHZul7ek?=
 =?us-ascii?Q?/t/xIioHaGO3U+LD+DqEO5MsIFpDySfnnq7E1OR1MLewdpH6bCN633fnAEqp?=
 =?us-ascii?Q?gYAFKUl0KPWHWrBk+rxjIekKlkxVuBNQeNyGII4qulAXRHCzs8oj2vU1zPPJ?=
 =?us-ascii?Q?6rGnD+q+HQEkk9PdlhPPF/gwy9piuvNbX8D+x4AkM4i9B2yI5ZTa4vmJn4fZ?=
 =?us-ascii?Q?srZAfKeEq+hc80T4REpKJxIyzMKfKz8klGuHqVuAI7np1o0Mt9Vdz1rNwUTQ?=
 =?us-ascii?Q?unaB98Zg/KY7vYSEez6Nmjhx07qODI6eZgAM78e8ZUwgwG3rulBNX0Hp7QvI?=
 =?us-ascii?Q?wTKzVcRQpZ99/9QoBPcDrJxYgCAwkA1mCsEefJRbsAl+Iy6Y5vrqG0bf/85x?=
 =?us-ascii?Q?UO1/NPR1MpyWa7dpBC8ohbDe7kimcxx87nthMG4K1BZwaq1BzcwS4sOmNMK+?=
 =?us-ascii?Q?kl+ll35HR3IUxqdjfCiGHQCSogj2Gb3Qt8fvhvQv/hrPq9a6BYT9iW43gSzV?=
 =?us-ascii?Q?TdPaBI2yk9eTo5iUDOip9cJth1tDd83kQ9Z+geMerE4o0LKECfO8ssKenMVj?=
 =?us-ascii?Q?NrQypiuBbpc6PelGoInV2/y83QsL5uH+zGMore/BXI1JnOqDvYZXS/5ODwcb?=
 =?us-ascii?Q?dsdLNyfbKfngTkkz6YO9q//TXkovTIvVDJTWLdCICh+dIIP44wUeiDwkyUaz?=
 =?us-ascii?Q?5MO3jzXblhuTKkrDPBZx2/MJL9fHdYVxiB8ggsIlmoRtJ9h2VzVcEAoaQcz4?=
 =?us-ascii?Q?cmds6w0p8iZH41TGVA2TQM1NXWA2cN9fiG6lIaqIrzPMMmytlo8iPh9S5Jdp?=
 =?us-ascii?Q?4+2znyTeK03ZVspbmQKn6Sf5DMXhV2yYoiow18TjdIkb4S1nUDu+cs0JmKZK?=
 =?us-ascii?Q?1pfw9KEzyVxDPYsSEajOaHGGg+2YySK1XfgBpNeJNteeaZxc0xt/fLck/6hS?=
 =?us-ascii?Q?D5zNX8prL4giODU4HiOST97BjI6r7E/hkxztTb6X5NtJ2MqMkxzOvEBZHZvy?=
 =?us-ascii?Q?ZmIDb8v0IU6C2GiOfyvPTpe9dLpLii2PDstFJkPc7Z7ZRl7Jil7fhKN1gQuV?=
 =?us-ascii?Q?oBe5QrzHxGBwOkP19t2HVxQgHPv8dFhbLIDNb/eVn4MeFyY8kyqII/44REr0?=
 =?us-ascii?Q?d/olouucro5ren73wx3UMV30G/+I1RcYu4CsLmk9nL6nAO9k6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sWhYhBv+b9fRYwa+AdRDcZhJ/ki2Xm6mPHekOk13YiPkl/OlzvAuoFwYudE8?=
 =?us-ascii?Q?rYiYusfu1Nm3KWYX5skCJEqulGu7yUh3/3FFPYaBXtQXOoSO8ceZoAEABL2P?=
 =?us-ascii?Q?zqDTqV8iAxQp3KgfvqrhVCvUJw86ey+IfPVW01M3Zw8T43fASa6wOcXf6GK5?=
 =?us-ascii?Q?+amsUQcpG8qsuQZduDCXLoQ/YNAaW7qMSO5PkPXSwXiMZZ/LeDKiF3OWJ/6s?=
 =?us-ascii?Q?+DaV2HQHtNB+XYsF1cAWbU+whVD6usP/jLHpeoGvIloLdkgEy/y6nRcimOcd?=
 =?us-ascii?Q?/z19V+YykhztgpFIdo6HcMVhv8jVOGlsJ126h8/POm6p3cNooSmteoMiiPFk?=
 =?us-ascii?Q?GEv9nDcJ0Wcxg/AHIPepY7PXAgbqNAJ3pRG/rGqVzLZFxWXNQcK/mAC9rlQR?=
 =?us-ascii?Q?GyVqKbbCvIQk+5avL1B1sWZ2WzJurFaI5SEQ7U4wG8pwqkCagjVArIQeMYZg?=
 =?us-ascii?Q?lOIL2wg8o5JSAPw9Nf/GjAO1Jj9rKmCgAe2A841u+psCOvunCNoQhuNb5pIX?=
 =?us-ascii?Q?yE3psicnxDkEtmUw9CIJFu62wAeKtQ0LoA9KDMJXpFA9s3uc5yzb/hxAwU7b?=
 =?us-ascii?Q?Rx1H/68Py7CXpbGoi0m5E6CfcLfZZxe1r/J1E1P5H6Z5pF974sfrm7/pg3KN?=
 =?us-ascii?Q?KqksrnkmCntMgm8qJv5wZuE8X3Gl9eReuOZalVYA8YISxRBeVgTPqLMyIOh4?=
 =?us-ascii?Q?gkZQSZizEOR+0pjldRoZcZeG21v/zbyKpL0qBI61wMIU7xImHnuouNjiM0md?=
 =?us-ascii?Q?haH/Fnw9r0Db3amrxQfMrshRIJ+FPLyK1wy67Tkme9VcZwizlnTGED5ZPrjE?=
 =?us-ascii?Q?CupOz+Nw23LITwdPTs6sWH9Wcr9bXGqjoQi2aBlmC77HSVMEEvq3iUu6WQOf?=
 =?us-ascii?Q?GINdWUP+MYljg1yGdPZ0tbwQNlx+R5+Z54RV8QyGbOttlssmrMr4/ljM8YLO?=
 =?us-ascii?Q?kBLjnJns/7ihHDlHuBF2N7hZkv5q3ihOiIxELQvtKEEOIOdH/rmsN/b4NO5M?=
 =?us-ascii?Q?r9FV128ltxmrPsoOPKJenqKL9T5wUOl7c2fwiBIYzu7C7ajUkKDHYML94n9o?=
 =?us-ascii?Q?YepegUNMErSwWaER18eRwlcxXkxyfwmQw3S4EOh2tqHQVnB+7gJ3iThDuzny?=
 =?us-ascii?Q?LUtAWE0UP15RmomKPMCQAoucxzePwr3AaI/BlT2N/jHdoH8gJxIVqt1ZY3Fv?=
 =?us-ascii?Q?oOWeiKwRNfPl6l2tpnwyE5V7a/ssLr8qUjREyB3sttgg0+UWd8+3f2I0kgtL?=
 =?us-ascii?Q?fOuhWfCh6RXOfnEdQETC/jMAOvMSf2H50Dx2lKQOUy0yJwWv6+SfnWz5KVTl?=
 =?us-ascii?Q?udV2s97UbNfi2mqs7NxdFp5Dq2bdv0mj39NaYxxa59M/juHICsxqldDrBqe7?=
 =?us-ascii?Q?/rovdQD9ojNpp/yCafeFXCs2lI/5Gxvn1Cp8SCMe3RjD6mHP9bb7akk5ZzS4?=
 =?us-ascii?Q?vueg1J1FRVUVJ8N8Xm7Oy11OWZrbObjILkwEY7NagAn1O2PTnFnePU8N0hQQ?=
 =?us-ascii?Q?hmpX0rK98ctIjM2VHc33UfsrNWYP8ux9RK1/1vI0h6F05HUeamFX59t7Zjsj?=
 =?us-ascii?Q?m2y/CHPuHNsGARObF1yWmVxRX7EfwRsI/AJcmKfG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913486fb-98ac-4e8c-6418-08dcd1567f29
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:07:41.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCvUoyupMj1pgeRTpml5nwUwCHMTABB8mfmA1LQDQcLQMyVFp6NiThNj9DWno+5WhsFo//RzANEpx1PHd46T1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7134

From: Carlos Song <carlos.song@nxp.com>

I3C controller should support adjusting open drain timing for the first
broadcast address to make I3C device working as a i2c device can see slow
broadcast address to close its Spike Filter to change working at i3c mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
Change for V5:
- No change. Resend this patch to list after subscribe to mail list.
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


