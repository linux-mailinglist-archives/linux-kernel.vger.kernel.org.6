Return-Path: <linux-kernel+bounces-277352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B19949FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49538B25E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA31990B2;
	Wed,  7 Aug 2024 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7SqC2Pv"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B4198E89
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010737; cv=fail; b=BEOvxSX3dw3YPxXDtjrw3SvmeKjJFmANNNMD8QJc3HyIS5ShnQjxfao6r8yJFIi97Da9g1I+WWDidr9djJbK4Hd3DuJaVI+JmqLjX8KyCxk1x18Ft02Z7bgRV2dOp13e18nZVp1zG9C05XDlS78hNLTFS4+W/zwXVsbs1u65KGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010737; c=relaxed/simple;
	bh=kFng2WcW24cmV3IcM6Gd+2bCsqRBN8YrU4zi+H5e4TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejVEYdo08+nsAmufIis2Qi8VAAz+rPdL3KqLGSHmt6sLgOnFiPGdM3OAsJ9Rxs1MUmJhCaUH9VUryl0mOQQy/O0ss+xzGoWRY9+Rhm2emYX9WkTjVMfdPvEhObMsN2vHZMACSRecvUqG+sfLasXPLjc98zyp77e/RW69xo4vJZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I7SqC2Pv; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjEZNYL+od6uVhaeNU/iWbdVcV0qteJqNX/7vE1hIkGEGg6NF8f2+xMtMkH5bHCOMoL1Fbx0kxwhDk2pQeVIh7iR9LIbJWKb+2ZrLyfy2aVXNT+HOw/4K4qrsmXz9wfTAz4VErWZOz+ZytHhes0tJmEA5uv8jEjaKR5YN6A264jud0T+qWCu/K+mRqup0HWJxRnlJQUhVAzl8FPsPjSAByT9LnJoGAZNNJDd+gmQRWaLH6HN6xTXcbN56SHssQrp2EmQmipUbUzLofaSXdHY1fuxWkQp1TOqngoHAsPTCDAPooWhio86a8nUNSaiE+z3BM1qdNEMeuHp9pegKIoa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfwVIVXbnxi04ZiwWSwOZ/aDvyNp+O+sq00J0HqLhTM=;
 b=LtkaQnT6DfzeCsjkJ1RQ8VwUrMOPGvfjQCu8zeBTleyO6BvgVlb4RIJRVPwEcxkj8K+FbtZamUtPUs0JRO5aC/W2aUkbslykLjv08S/Y5yqXg9H2cywqVKOzh8dsyM0y7aUXRynI6H9c2VxZH5plw46xq6Eyp3pawnDjrXW0osYurpHuiFfkK4x0/yes2DOix2gb9z1lUG5SivYmZrGiTLzz6S0b+C1kduyx3N1qbq3jIxETPWnBE+ALIsAGtLOKWd6bdnMJG5qoSY5TWcc10f5N7O/Vnu/0ocU5tEsH3dD4bnha2O7LwfO6XLM2+6ODJ50rsmwN8OTgQwd3ZHDoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfwVIVXbnxi04ZiwWSwOZ/aDvyNp+O+sq00J0HqLhTM=;
 b=I7SqC2PvwPxn3cUkRbqK31J8R6TjdVm8GW/PT05z/bp2Scu9I+d6vZTfrpWaHP9e4O2Q9uxb9jPpIM/KI6zcPj1l/LA+oJs5qtTqWErYBuCDu74WoG/GsM0mmegqMabUb86Hv2zu42w5G/5IJ4h7z6sMO0clmecaXwfMlExcDVVAQj9F37a7/9kmsbiEeDJv9dXisRjstlv6Kqr+Mbu7WwFu3wdWw5eu22WE9O47xOkiFFoya1b8ODnHFBxP3cP01yz8zQI+vPWUUDCNVUpxxg8k3u8o83/yVGPLR+gml2ekTir3XwEIwDIjAP7BNvwIpdQFTFOdNTPBcWCxw80BNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by DU4PR04MB10696.eurprd04.prod.outlook.com (2603:10a6:10:590::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 06:05:32 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b%5]) with mapi id 15.20.7807.026; Wed, 7 Aug 2024
 06:05:32 +0000
From: carlos.song@nxp.com
To: alexandre.belloni@bootlin.com,
	frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: [PATCH v2 2/2] i3c: master: svc: use slow speed for first broadcast address
Date: Wed,  7 Aug 2024 14:13:06 +0800
Message-Id: <20240807061306.3143528-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807061306.3143528-1-carlos.song@nxp.com>
References: <20240807061306.3143528-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5003:EE_|DU4PR04MB10696:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfa919a-5f58-40d0-3dc9-08dcb6a6f1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wuVR1W8WAocyiSEpUJm/Xm7xeOuSR3aZKLONy7KXWyIJcaFdtbQsKG5/m+D5?=
 =?us-ascii?Q?rSXtQlQe1d/HE1B42miWNRfQpKwmLVblf0Aj3G98h0FvouHCesoBNYP+8Qxu?=
 =?us-ascii?Q?EMsFgpQWv1mUPiT6b/S9OmupKxvZkchKir/uIEEEgX+fHzAEtaE8904++nsG?=
 =?us-ascii?Q?w8rWCM16vdoak1KrxVF6gtWgC+dgz2aMarVXRI6u74taO5hv070ZYLMDa9yC?=
 =?us-ascii?Q?nobNpDxA1HPptptXQZP3NRx+PP60Ij90VgoLHQfub8lEuaN+0g4c6wx0uVpt?=
 =?us-ascii?Q?cN9gtAj6NOuWdQVA/OgHxx9KlTZP+qGi2o9pMV2bo7RFZB4fUsN3PGH/r1gP?=
 =?us-ascii?Q?CdJ1tKNqWoimFeiKykZnpPGPnk8gHPozEFLVEVetE9uxeXuD69MhltM98gLT?=
 =?us-ascii?Q?yWqUw17QXAEXarvkdLTm8WF7GvsjRs0sOApdORwj7GZekzu7cj819IiEw2y7?=
 =?us-ascii?Q?bcQL/G/aJ9eEd52TclpkPt+PG4rL4WioU+60KJhOGr07oSy7zrKUxDCyYJWh?=
 =?us-ascii?Q?Cbcti8lZSEE899hsQwThxn5xY1xvEB8kQlDLgpMYS9ZhrxfK+WRdOrQbo7om?=
 =?us-ascii?Q?PEKhyoTuHOLC5RIUylo2MAI8iZ+Tc8F47jNDDtnK//rWkv/Bv97HbOeFFI4J?=
 =?us-ascii?Q?UcLIQtleNiJtc5hxQN5GNm3lB0MDNFAfqa/oFRShFPD7AddQEMNrQCU7jwwD?=
 =?us-ascii?Q?NOBJazDaLVsf4iIKMsl0M08mdY/6zwtIbIfnAc5hSnU3ElfP7uG7xMFRpoW9?=
 =?us-ascii?Q?3JEAr7jrhG8SkOQU8F7y4F+Zb3UhTDpVQaRkPsN3+CqlUmQB0EsgNqc+jF9b?=
 =?us-ascii?Q?nUUI6WBrZ82ttxOJ51O/mFFDzi0UwkbSB621Tgu+MFAtSyyuGaZy6nxtLMcQ?=
 =?us-ascii?Q?eskf5oxVYBVgFk/Onor+3R1h46fXch/pzyR6XGeCq1PnTjtR4NTIzPghRETU?=
 =?us-ascii?Q?D/8IAc5tiYCEJTACpOruLmnqs2+LSz9CkSBPbBzz396EqSX2RkoYyK/r+Q9j?=
 =?us-ascii?Q?VD2ec12fbwwb0Gez+UbU5RMwmqi8Zi3Ky9I2W6NE5l/9C1Cgxr90Rjo1Q+TB?=
 =?us-ascii?Q?yk6VrdYZZm8UIyvsDY+W2P8oYRA9bieXIAz4iVpHMEqnsrLRta/eItTSQma7?=
 =?us-ascii?Q?TkviRs1a21xJCPlrWt5q03R+nGggsw71sjeuZ1uAV6uKxJsskvw9kTLquirE?=
 =?us-ascii?Q?0c0WIzhg5RztRIZ4lOug8bsmqrs2Hp6RgvUo0WcJV64+gEPLAam6KWCjkJOC?=
 =?us-ascii?Q?IWf+IcZG2ZG10A0QZvNsq1bFT3zMOM29LSb+T6zO8owod2uYclzbLLhxqFig?=
 =?us-ascii?Q?pt2I49VJUoNOHf9hyPqooOGrtZ7CnkOCgA6O/9Tl4sLSrJw2R+3sBu9pGYUy?=
 =?us-ascii?Q?/V3v8QiT9Y2G8a14sJMm2K7Ern43kRfj0HfexUwMyAln1yjq4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4q4e1kpXDU8imiiyugd48Q2B8jVy5skkuUMYSUru4L55b4KIqVRw+nLn4sK0?=
 =?us-ascii?Q?T3p43Zu0HayGC3HRGBDU9m5cZf6PkGnLD/JMzBEjrwZwAiMFE4LMt9K1YaDF?=
 =?us-ascii?Q?0peo4KirBvgip023LjWVmDP6ZhhgmveCV0ZLS3eglTt9H3iuzSU9YcHqaRlq?=
 =?us-ascii?Q?gSGk+AL/qXL0YC8wY4Pr62SMiOdXlQdKAE3AOkZWmp4fkcQPl8+6XimewuVC?=
 =?us-ascii?Q?WD4syPUbf3fUlkz6MjeyjIWXpVH5uh+AOJSOp83XgaKYBciFDR6M5DVh2Pwl?=
 =?us-ascii?Q?piuxFJDeODNp/vN0lHmpZTvLFvid3XaBvWmc+0IYzVnKskeJ2RxEsa+PHV/v?=
 =?us-ascii?Q?QaO/KNPkyJ9Uzyxyv7+SFanc3HzrTkebBiDLvHn5siloJcQlugtvrbeTPGAl?=
 =?us-ascii?Q?xJau5MqDY3ArJsEm4QF74vBjIfiGaPVhBLuWGWHM7/ayHYox8dHnXYG7sqEb?=
 =?us-ascii?Q?+CA2NRpA4a/R2KdQ75gFUmDgHMHqNBA4wcKe2SjXbgYZVb1dQ8J/67RRcTAu?=
 =?us-ascii?Q?fSu85tO8OCtNM3EzVuDOjCvh0AevwOR4XGwW6Q/MPXioeH4Bx5OicLyA7Roq?=
 =?us-ascii?Q?2mwfmbhxfUStlgoaYm/O/S9JeRFK4AksMMR0Hr+GtFSRrLjG0Q/vCYeMU/z4?=
 =?us-ascii?Q?iqhAWQv/vUSSx1wdPvu5thPj5O0T7AAD2b4Syyf3fv1gte3VqmOTdPxrD7zv?=
 =?us-ascii?Q?ok3AmFwkUUNzJnhRgsNY0nM1rAJYDPUOVrLy6sWia7eqxsIWu7pP3CtSJWM3?=
 =?us-ascii?Q?Lxvm+TxZoHeXSFAtZ2CD3JqZA6MQn8DBQK0uFEt8YPQiCCXL+NZq4b8nqTzn?=
 =?us-ascii?Q?/RB01Z7fTp9slr88gPmVwwoscyXcCQYjYqSxx9NR+7OcHBfPlNApP2LU7hZe?=
 =?us-ascii?Q?CyxM1J61H9BtpLjLj/YrMdEp+zOxo9FwpOrt7pcAOofD09kYb++RMSbHdzMj?=
 =?us-ascii?Q?3pVI9nd4XfNw896kKpUgWCfx5OK/zo3zQo7K6fpMku+lwNoXKaIV3tPL7fDZ?=
 =?us-ascii?Q?1JMb0+3cpY42hrAtNVWQBdzDp9mOq8EnEPifYQ6e229sD2WPfNWyf7Bmyw+G?=
 =?us-ascii?Q?RheShlPcqi0f9L8pgVlsWbduzULQcy4wcD2nUKNZnZydyt+JoMNUeBCaQEt1?=
 =?us-ascii?Q?j9nyluwSE5k7gAuhapt8yK/Iy+itHJal/WigwYXXCNaQV9yJnGbLBg6VNyB8?=
 =?us-ascii?Q?c1cZ9yP20qzl6rFbUL3Ep+SBT7PYfEJb8oVNUW8fm3nx553636PSqgKL9Rwn?=
 =?us-ascii?Q?I10hFVxfg10CiWOg6ELBassDk+7Suejd/jWBI2hFDE53pgsA7CV6VomD1Sl5?=
 =?us-ascii?Q?Xhia3/yLUFmSg9fYZHUD/zaOmBs2dcY1m+/L/SYGjlAQjhDvCVqTPfQnYWUh?=
 =?us-ascii?Q?JVQWlHuH8eHvkfTuOfXUnCRS/LIhBouvqZJRxPwMFyLgcwSvade7vXZGnrnE?=
 =?us-ascii?Q?PCtD84aQmX+93CVrSxRh+gXFehk5xrh7774h9FbDc+pjPuHwp8apAlLORPD+?=
 =?us-ascii?Q?RRTNUybkqW5sFrQxjmnwPUv4ndur2U/v79B92KP4WKdsXllnpkEvrLfr7PbV?=
 =?us-ascii?Q?FkhCd54NAAdayozMldhKb/4dC+0UUqo1NXxRlAlE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfa919a-5f58-40d0-3dc9-08dcb6a6f1fe
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 06:05:32.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5umQ/uovLK/u2zxp1neutaXCE8rTNuzDA35pZOYuVPMIhDAT9XJLkRoMNjzc+yzj+qnPnfmTKVEOlo3V6U+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10696

From: Carlos Song <carlos.song@nxp.com>

I3C controller should support adjusting open drain timing for the first
broadcast address to make I3C device working as a i2c device can see slow
broadcast address to close its Spike Filter to change working at i3c mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
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


