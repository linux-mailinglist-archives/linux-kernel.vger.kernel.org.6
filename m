Return-Path: <linux-kernel+bounces-257063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6AC9374AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8FA1F21244
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31626E619;
	Fri, 19 Jul 2024 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYDgkvj2"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5758ABC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376224; cv=fail; b=HwxMwdvbtmZUYkTs4YW4tjU23IVrYflCO2eWjnr0VcV/jFiFm8COR5YYQ/lBOVUa0q+h63wemqepoSw7dwEDc7r25D0hiN4EHT6QPp9x5nPuGx1uLG42pKXDSjN1M5GXnJprXj29a6VManlc/brhxXVn75nc6r/jOWBpi1KGBWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376224; c=relaxed/simple;
	bh=3FUjAfhtJBZ1WIL2UrUutkR1WUUwy4ywV7HuktDPX8c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Dfx7pNpF2aRY7Vp58GMUqF+JM2WuvdzNyq5TC4hQKVzVGk6Jz2CVWvsc8GmxseUei7EbAbriR2wCTQxoYCFm26p3qkWrWJ9NLNiUqL2QdTMMUngQWghtUb+lQ4MakEenhwUnEl0YNnl8P8zDnrF00vro6ELabWNbsT+QU+VY+6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYDgkvj2; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLemj31dmszdp1WQasmmDsshTIEHjuKmtOTGnll61SUTj4WKGmM1eoII4/FCyTLuMlD93rJ+Utb0IIyD1aJ0ZmcjtAlazVxcBUpvEw8inn71xmSxtQNZCtvT9ui8Xnaw1jd8yWrbMAvMJDx8FjwdPXiqkHIfOyAdRKKmsp4ikSdSkNN+xIf6huXABMcLyjvogs5sx5RITDRiyS2FCakUhOx4qaRTWKu8es1VLTEVXETP3TnLu5O31mmHTLfIYh1JhMKwKzVb6SZIYSv8lDxjedVdWzK/aYLdaNmWNH6QdCNxqzeFvx5xCBmT/Gtk0CICNoLzGAlIl88C7fxF1xJL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuBNxLxat54/G+PClpZ4vUt+iJ2V7Fy2nLfFj2xNL8o=;
 b=MQsvGJAEkQCQAWJkom4Eub+SkhYSKQ3aeFle0K3R7+z3Hw+c5s7F7ONzplhLrHYXsgRL0DrHp3ADw6Ynh0HyepvujzP2vExuv++2AAMHzPH8OYAGC9DcVvomSV2tO3UTDpLFfAi8kdo9TGeGdDgklorm3ZRZU4QLiFnZkSVIBNSrX30QTzOM6fWKgwFgvtlApsg3/KAYpFnJEgjzD0vVswXxqfYYLYjguKiCEiSfyky7GqmGyXPDzQEx/tCGyBbajM9Q0GWZAqoDWGf8sM5IbmkesAashv1ui/y/fq5NZIz7ZqcLXGJGAdEAJHc0c8YPpVWdWhmtZUTn2KMi1id1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuBNxLxat54/G+PClpZ4vUt+iJ2V7Fy2nLfFj2xNL8o=;
 b=CYDgkvj2ZL4n82sLzFMjAuU6MOFziGFlH9RIygxEHD4cjH17uF3YealNN4jqy8IIadmrITuVyyC0pxxvo0yKn75E5DUwQ4AIko1/TN0Thm3w8ViVLivqyezp5Q8xCASaecxZlscNU8/5HbKakGjGWvFkPFlimjTSHyjckCFfqfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 08:03:39 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 08:03:39 +0000
From: carlos.song@nxp.com
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Date: Fri, 19 Jul 2024 16:03:51 +0800
Message-Id: <20240719080351.842848-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB8PR04MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: bb35712d-1c66-48dd-7560-08dca7c94ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YYhTSRfnak2f4RtkBzRE8Zs1/qpkBxfJhQ7bkCS31pb66raiavFh1M+sphx?=
 =?us-ascii?Q?CVumzUV+eoP80DEtagWBLg2XsKJ19ZLzw1XWBYfSyHlTlzGaVDme7Q42eZJH?=
 =?us-ascii?Q?avFA9iUT9L5bw5XMfmsJ4W8JgjkDo0F8FWWZMCNREXib3b3sswJwXy00nIXc?=
 =?us-ascii?Q?RqY0vXXzl/vTNrrZOS5uk52Ikem5yOfADpqGR11RS4DamsFSPX4gComMwauV?=
 =?us-ascii?Q?8JKW9Xs0Odaf9b5Z4QMpeay+kHYxGlJVd6pkOYg30ft55LIS6QCiFmfCISEN?=
 =?us-ascii?Q?xZAF5Ns+JzeLpAXE7DC5gPUCKxRGOk8PHHHE/o+f0LOMOHpKVIIqWZCnU6kK?=
 =?us-ascii?Q?09Zh7mu5sb8ErHaeNIALL3y/bbFK4jE1aYKEzLxGHvo0cSQXp2ibDZn8aPE4?=
 =?us-ascii?Q?CyTzrEme3xIATVefLNtKKuKHQkI5sj5JThB5AzblECc2a0ShZztqo7ZJHiol?=
 =?us-ascii?Q?JtRV6x8YifkHiAipimZHN9+AXtWa8vw0zG0okL3Fu+weQ9RQsC8yJZZZCghU?=
 =?us-ascii?Q?oLthlKgVm1M5NspXR0175DqcCySlEIo2Lmi8pcok0vr+RKPudwkrwvZVvD2e?=
 =?us-ascii?Q?bpIexG9CKXnxp/AeRiPWNFRcR4HXQfybf41JV82y2zFCRkABmYcLeSlBx5di?=
 =?us-ascii?Q?2ZPz5bhwqum4nQPNCjhHA3Ep5ZsTfUR3atYOpDfay8B3cMiUS/jip+OHyRQU?=
 =?us-ascii?Q?TyuMtNdv9cJU4Ij/8Tex9NuHzwyeLlpOt0IUn7zfpmtqJy6GUiITif4GbRdc?=
 =?us-ascii?Q?hNmkqyX4b03IgxZPYzRVP14/QNhQEWIecaASB4gw5sa4/vCmN6JMr77oGhAd?=
 =?us-ascii?Q?hyB/IalNQATFyHvpSue96bosji7xzdc3/1fkQjvTwyoQ/iX2MZjYp9sBxucq?=
 =?us-ascii?Q?siJT1snH9SIDiZEjw2jvi/EwoukPXWXgK8y1N3Ot8ILM+LbNPBpapv8iIMih?=
 =?us-ascii?Q?LJg+ZO7zJerd/7yj9qRFd5IisonLQIAbAoehXpdgaE8MxIvJXjcqeOjXTleZ?=
 =?us-ascii?Q?2r/ypZiBNsyPCZa9p6fRi7hGI3zkMri9seo40TvXmenVeFyNhz241Wl/BU+X?=
 =?us-ascii?Q?CblEZRtePc3lMamsZrqZevb9QbTnorS6xdnXxQkar2dAaR3Ti3Dl1R/aHfwA?=
 =?us-ascii?Q?04ZFqtmJnIZkZolBHY5QyCe/6bzx3rVeOFnWe6oJu45M8Y8b7FQCokTqiLAf?=
 =?us-ascii?Q?Vg9WY4HKlgnHzTlE6aXwvi/pp4myZ83tjzo/BDIYvuU0v761foWVymLCM6kO?=
 =?us-ascii?Q?f4jU3hIQ/fdF71r4fx2AQ9LLINj5FppG7meafKaccJPv6XLEi06lcVY2HULh?=
 =?us-ascii?Q?ioLsrjRYANrEXpb31HiqMYr+/XEXDoLhlXSW+UmSHNSOfz1KnikyiKmNB72h?=
 =?us-ascii?Q?L6s8tdEGDVe3qI3BCPDM5Z+oRDX5/WxUsfv87JiCEig5wBRIxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?reDFBaIhBlWfU1DoUY4M3Fzsy9tHWokYF/oN/cCaF0/Mdt9vJZSjy14agK/s?=
 =?us-ascii?Q?ENjxBf5o9cEtTiRyMiOj7+Jo8Oq8IAIGP4ms6j7B4XwesUve3fs8PglgKrR5?=
 =?us-ascii?Q?s+D4z4yjtLd7L6w7nu/pTQXYG8esAw0oqgrRt90F+rJ9D/yad4Sd7U3NfBeG?=
 =?us-ascii?Q?XMpxKBxMz+kRj3Xvr1+e4AFaNH+hfcMzXNntylv14P1P53D8QwXhC7ZihacO?=
 =?us-ascii?Q?s1tImJvuNWZUrX9m86L2rBvkmTxlZzZgCFTj9FYfKnAYcrHGE/2glzi1FMlJ?=
 =?us-ascii?Q?FcY04yUYfg0Q0FTMp56D45mn+ZRQv9Zn/8FsZU7g3C8t+lgpfvMzEXcJZzcr?=
 =?us-ascii?Q?dnSnHKeVN6dqxhRq6Vtjm3y/IxMi5bJlvsyMasVSXA/xQidNNc8NP+wIxiMW?=
 =?us-ascii?Q?KfVhiPtOZn9V10VwAJTrAET9+aMnp1Rq9QTeo1NXwYlC5xIICYzNrg/ISDGE?=
 =?us-ascii?Q?vBs3tpbl5I8iQWc3mXORv6vS23etDSc9Hz7R6j8uVkAbsroTzVB8zL5Qmw50?=
 =?us-ascii?Q?Tr51HTJlMvaH2T2j3Ab2/jHzR3xbVcEWe+mtjikUB7FoexopQYcisH0hfFx7?=
 =?us-ascii?Q?S8c4O7ieD9fIny1k750SwRzZLJROJU5x9dIm3JsgVadNVehEYa0Xisz53afY?=
 =?us-ascii?Q?YMJADam+DEwLbXFUqvTwKB00IPPBS95trcVOlU16h6q78j1R5QfQK/M+rQr0?=
 =?us-ascii?Q?mJhhd6t4Gakb74yNgmhhGLMcPL/gjAiHjTpwVhPWDlW6aq4bTP057eagwsgT?=
 =?us-ascii?Q?WOs0yWt971JA1XjzyW93f+eewyfngUglcMj83g8RADROyWgtXSv6B7LSKYq0?=
 =?us-ascii?Q?jvysVvRqCnzKgk2JyNHcvGn0lEG09Kynl7Fyg988TGS7NHa8Eb5I+qpVE1Sd?=
 =?us-ascii?Q?Enz8nQE1jV5ZG8+roUd+GBmKJUP/A+DNHciUcubNqvIDJoG5AGw4XIWcEFXW?=
 =?us-ascii?Q?72UAVDUxzySLFKrBfFXJw188gPEPGdkSN4TuWVdxZ8PLVbxAn5pK2+0eMvZI?=
 =?us-ascii?Q?sADSrvHVZ/nYkVrHD3wGQ+t2yzaiZt+c/CSDQFXOskv61h5z86XfZ9qCRtG4?=
 =?us-ascii?Q?egqHJeUJVOBNCvhsZ0K2vfqdzHMfJMrzOib1V924U2Tx1XE6zRa36Xk4RIWY?=
 =?us-ascii?Q?g7qGY7VqqYgofvcfMqZwf4lRLv1xprtz5IK62XalvAVTB+yTOj1al1Puip9G?=
 =?us-ascii?Q?G1WwvbNDW9VC1ccPMndyyD1RXMt0bquV7qU7iVBCbOlwDr6a7dez10c1JYJq?=
 =?us-ascii?Q?7grjxSVWE2GQMGmrLMD5b0+vH8SYLuXoft+qt/t4zcLnfJmv9Yt15W4gcJmF?=
 =?us-ascii?Q?qi77DwhUPIvL6grmLc5KzI4z4UKgmh0QyrrLXxmayfLHh+jsH3a3wnGXr8Vo?=
 =?us-ascii?Q?diP6DsvjkhiaeyNGn9QcRQ0RlTtBpvTTbVxwcnxG/06XEnmFCrzJn52AnXdK?=
 =?us-ascii?Q?0Rb2MvBb+E+T1TcW/jyY7GgBjEhLEu+TR+pgYWBNflOojplk7LZpOZg6uBAf?=
 =?us-ascii?Q?709dB+ez5o8zOknqgmJU7/qGi99Bkciu7fCBWf87XMoe7Tkq3tXV0q65EnDi?=
 =?us-ascii?Q?rJ5JxlgFPFqZMXzhTaFF1CVGtbwOlIB4xVh6V1AR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb35712d-1c66-48dd-7560-08dca7c94ca0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:03:39.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: be/EGyIVvbq+sJIGV7I5cbNoSos9CnNYy7eL/4Yw811qzOHLE5E7uiBk1m4k8SlQKOqp1drkQLjaV0H+B2nxtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

From: Carlos Song <carlos.song@nxp.com>

According to the i3c spec 6.2 Timing Specification, the first
broadcast open drain timing should be adjust to High Period
of SCL Clock is 200ns at least. I3C device working as a i2c
device will see the broadcast to close its Spike Filter to
change to i3c mode. After that I3C open drain SCL high level
should be adjust to 32ns~45ns.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for V2:
- use slow_speed instead of first_broadcast
- add default_speed variable in svc_i3c_xfer to avoid set default
  speed every time
- change start_xfer if else for easy understand
---
 drivers/i3c/master/svc-i3c-master.c | 55 +++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 78116530f431..7cd3a9a4d7dd 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -142,6 +142,7 @@ struct svc_i3c_cmd {
 	unsigned int actual_len;
 	struct i3c_priv_xfer *xfer;
 	bool continued;
+	bool slow_address;
 };
 
 struct svc_i3c_xfer {
@@ -214,6 +215,11 @@ struct svc_i3c_master {
 	} ibi;
 	struct mutex lock;
 	int enabled_events;
+
+	unsigned long fclk_rate;
+	u32 mctrl_config;
+	bool slow_speed;
+	bool default_speed;
 };
 
 /**
@@ -531,6 +537,43 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void svc_i3c_master_set_slow_address_speed(struct svc_i3c_master *master)
+{
+	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
+	u32 ppbaud, odbaud, odhpp, mconfig;
+
+	master->mctrl_config = readl(master->regs + SVC_I3C_MCONFIG);
+	mconfig = master->mctrl_config;
+
+	/*
+	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50% duty-cycle(400K/2500ns),
+	 * so that the first broadcast is visible to all devices on the i3c bus.
+	 * I3C device with 50ns filter will turn off the filter.
+	 */
+
+	ppbaud = FIELD_GET(GENMASK(11, 8), mconfig);
+	odhpp = 0;
+	odbaud = DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2 + 2 * ppbaud)) - 1;
+	mconfig &= ~GENMASK(24, 16);
+	mconfig |= SVC_I3C_MCONFIG_ODBAUD(odbaud) | SVC_I3C_MCONFIG_ODHPP(odhpp);
+
+	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
+	master->slow_speed = false;
+}
+
+static void svc_i3c_master_set_default_speed(struct svc_i3c_master *master)
+{
+	/*
+	 * The bus mode is already determined when the bus is initialized, so setting initial
+	 * configuration back to the controller. No need to set it in every transfer, just
+	 * restore it once time.
+	 */
+	if (!master->default_speed) {
+		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
+		master->default_speed = true;
+	}
+}
+
 static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -624,6 +667,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
 	writel(reg, master->regs + SVC_I3C_MCONFIG);
 
+	master->slow_speed = true;
+	master->fclk_rate = fclk_rate;
 	/* Master core's registration */
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
@@ -1251,6 +1296,11 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
+		if (cmd->slow_address)
+			svc_i3c_master_set_slow_address_speed(master);
+		else
+			svc_i3c_master_set_default_speed(master);
+
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
@@ -1346,6 +1396,11 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->actual_len = 0;
 	cmd->continued = false;
 
+	if (master->slow_speed)
+		cmd->slow_address = true;
+	else
+		cmd->slow_address = false;
+
 	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
-- 
2.34.1


