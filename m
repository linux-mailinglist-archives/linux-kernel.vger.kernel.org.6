Return-Path: <linux-kernel+bounces-300744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21E95E7CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ADA1F21494
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F66BB5B;
	Mon, 26 Aug 2024 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R47/V6p8"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2051.outbound.protection.outlook.com [40.107.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C825622
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724648454; cv=fail; b=YjJGwH+d052Peb/At6xgTaBGwSoFMM3wfmQddp2SZ1YGhm4d+mC0N8B0mwlz1S4wUsKiZwqReRWlEM1M5nZzWwVyAGBfQXGyCxJjl8GFkPdboHCeOIZNs56sbibZ/evE3PEIx9SLPnhZIyB9x0U8rrkWIYd2TIJ91SPfAVJN7Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724648454; c=relaxed/simple;
	bh=9OuVVNUTBCZrLo+ZoFXRYOgugKpZWyiCeqMxsAy1RnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G+UvaDzj0fErIJ9MhWQjh52phAhWM0a08bXI5AGruUkDjeFDbqgQKR9D0AN81aXrx97sdy5lgZuwMzLvwJEzFBsvve0iQU4CYBhRg549AL6Y1mWYCMzkeyLBaD4sN7LdSCZM+tCHZn4DA14XPKPCgxVBO3dRJ3X0wIvPqFmXibg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R47/V6p8; arc=fail smtp.client-ip=40.107.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLnZSwgdpGzo+3vBqaHEDDRdomP09DWCmOpLbGWvz0RqY9aRaAomb/2fT0UD9hRHrCbFPppWhTwUBIWcxI7DlhF49NtLLNHQpG2w7PiZy7RcY2lTFyY79MYmnNquYkdchLbbLYFMgsU51Cwvt5rIRcLBm6BGezlp5CnHb33I4fnkUQTGSwKjYMFbaEIN8zjG9mlD/Wa3IbJ9BJeZMzHevdAzdnYdpqhzw4zTgi+2sBzF9qKTxuWleCa3+GilBbQs33bdDlqnMqCAI3WFhr2VknO2fzkoTpuKOhF9cR3usfFggIyhNLYTwgthxKD5hwTG4OLOSxck4gnrFvhF5jH4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/jaS4Z0npCG7Py3zy4lPBjPEoFbJmfApCQ1POa4AaA=;
 b=pGkfITC0UatnqaR2T6WeN/mhRg5xszhnYA0jEbjmDB7QTMZGhjprSjaHEWIvejaTXshvo46ohxekxOr9XRwqhIYf20tmDU5kQABIx8lhYCCARP8OBvJMrUlxqCZ7QzSueKgHQzStuHQr6975JGRzUGxXJK5kOq7pqMS9wGVzJeg1IK0oE8/aMpY2C7g5lOZNb38SPGcVMI490HmJqeGs7L7QeK4gm3qLdpSQ6NJxD7PR3RGcJMRlh7PCvyy/XooZFsyzCb4YEQKUfT9wVER/2WjFb6QxY3YW5mVvJegRzULiymy8vrHOaWwsyLjbSUtJkKC+24rpYargaxQeRUT5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/jaS4Z0npCG7Py3zy4lPBjPEoFbJmfApCQ1POa4AaA=;
 b=R47/V6p8rHUAQV9tsUNLuFcrWIlzJlYXKfoe/VTM5YHxNDkf45vnjeSUasRA9Cd0ZR724q14iaB7mzX6WcA4fUwgYCjzR8kplEl42nkAmWGh1HCppmDiS52wtC38/B09CY/E2CiymYjRgNq5CI+gbhHEdDe3rpXOxCY+oyK/ilc4uHRlrcCrha/qaDNa17qDIBUE5qbqh77+GG7v2dhOQILWGPGKcKZ2M+5Rz10tsBWBbmRTUjtbcRmvjG223CZBFCNzFtWSNPey4hZWAwRwuLbReTfEMU7xYdsLJPMXThec2YkdP+0N8GuKXdg+niV2P/9IGmXBRlRoVmJk2ibIbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DBBPR04MB8058.eurprd04.prod.outlook.com (2603:10a6:10:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 05:00:48 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:00:48 +0000
From: carlos.song@nxp.com
To: miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: [PATCH v3] i3c: master: support to adjust first broadcast address speed
Date: Mon, 26 Aug 2024 13:09:57 +0800
Message-Id: <20240826050957.1881563-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DBBPR04MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9e4f80-da91-43eb-e3fc-08dcc58c0c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?paN8oqPyRgdp866YNMoAwgQKEP5J/RRK6VQjkrOGfg3wObhcwthu+LOaH5AP?=
 =?us-ascii?Q?yyRz81fIJ7/EvRjAY8FQkA7JGO8YPVfNFXX+qUa9WJdq2VlZ3vRdfbKWzQGZ?=
 =?us-ascii?Q?S1hXsz/fHPR0hw9eaw8EAY6Nv4wLtZjHjcb9Skk7zYR39CmDasxHvpPd3SFC?=
 =?us-ascii?Q?LKvD116o+J1mDzwGTE19wjBqCj72x4BfVx/1f4imuiw/zAxS5Jt3xRQboYse?=
 =?us-ascii?Q?BBGcWALuXG6YzMlo1ftZF/nfoV+2RbRlBAKtcXopdoUt0lupwJpMfgmlOVVS?=
 =?us-ascii?Q?qnFZCUhwTw7hb+10a/ke6F44L3psmMGEHbU4ak30oTbvUfHwZ+/WXA2CSXMs?=
 =?us-ascii?Q?5pe3jnzIVYgPY4xPMYZ7ZUg0PLDQSbR2mwwuXpR61luIDdrOBo9IoV8UewYs?=
 =?us-ascii?Q?xV98CSRtzD8FDi0XLzx2QutWUaCb7hX6hQYakKa+UBKjCtj4jdidXmgmn9PQ?=
 =?us-ascii?Q?n1pEmqW7rMcYfd1x/RRIfW64BxI1ke/lUvbicfqhFSc7PF2PwF/uH9sL5kUl?=
 =?us-ascii?Q?NQpnFsdFhnfhY7O3X0BSbB/nSXuZKUvyHa0KBlTRDY6eRIs58AtUYBVdlBjK?=
 =?us-ascii?Q?WysWosYLJ3tvQGFl/M3b16Y8lb2ADFVKVX0jKS5BjsqPu+5SstAMKyQVQIZd?=
 =?us-ascii?Q?ar5+bN8SVr5HFnsT/KTu9b6vS3hB76jbyiu5JXh8WHLP38+0wdM38MoVNbRt?=
 =?us-ascii?Q?7Wq4J/AJ+vl+ukjDgfqBbL59sFrNEmmoQjhATy2VndxbB4nLA95ztIT9ZVFK?=
 =?us-ascii?Q?hyMNACpA+vvuEoZQFogKLvUvCRFhJUq2QXHaKoALFlULLJeynFrIptrD6r3D?=
 =?us-ascii?Q?Pf26ab/AtUZWX2F/fjApQHPEJzmxNPZNjHw84v2K+FDkDL3oHQNqOOqS7sKV?=
 =?us-ascii?Q?zsMjVwi/RkXdKOK2xwLWVQQ+tMly1fugNTwhZypAu0q0v7zuUu7uo6z4+Yu5?=
 =?us-ascii?Q?3nzw8cmXTQQOEzhr52ZxFO1afcGg+AgTPH/MWx0a4Ei9q/4b4nxclzKc7pvw?=
 =?us-ascii?Q?16P4wKXc917IIATAJkpMKiGbAt2Uq8YZCOu4k8b5aO7Hv3ajVJ3DlmGVDzs4?=
 =?us-ascii?Q?nXAp8FwFdOa8VJsLIhBWCaE7b84nuS56iAAS9DJns1v/Igp6uQ4HDoNJ42ot?=
 =?us-ascii?Q?uIWKbTsUTSXAcXczut6wOH2tC9dGW6GIRuFd7pSnVSDis/lVmunMpmQdXI5E?=
 =?us-ascii?Q?irbch6CJaT/auTsAkbEOT6MeYIT/anZnJ7xs/yVJzepgh0Fr065ebZVMoGZQ?=
 =?us-ascii?Q?aMPQu+zMx87EcnHab0BOpiKWSWBWCEv6n1Hv06x0YXrup3CXaA4GZWhMEH0g?=
 =?us-ascii?Q?0h0OSWLO5+0bsSldE86j8EqgHsoQqw8fqAtNzuiIKojvt1DCxMuwRJ8LKk9U?=
 =?us-ascii?Q?YTx851iZqGAizozu5CJOyAtEOw7oLPADt1z5UvrKjMB2QD4OKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEZ4pV4T2l77DksRDnJoGzRbqiOb7qkSoLQRdHMaZfBK7IRs+xZNQa/KqoAh?=
 =?us-ascii?Q?0wG/milvwa33Cs3BoFBLICZ/ac0gNQyyJ/IN4+TM68gsY28w/fDjZLxcMw8b?=
 =?us-ascii?Q?b11nmi4l8S4/DtJigrW1zsxiashLjDuV8PZ3Q8uFz+KNdjORoCEn8iDFl7ma?=
 =?us-ascii?Q?lbVmoBLq3o9Pv6Sb4/D4gRi3FFuqYYO/b1Ux7uWvod2kyRaiDWaq53alqQaD?=
 =?us-ascii?Q?QKZzx7IL7WIg+hQBgQRZ0wgPEGgwgNIxnon/v+2qWFMyGRiof+hqhXVFxqmM?=
 =?us-ascii?Q?Dbj+dr0G5lVfzgtfQA5FuShePbR7mMzy6DX4pAdlp4JB0e7JPKrw8Q3zvy3E?=
 =?us-ascii?Q?Y0CZLwlWWj74E5SKePS5vwbqOaHNabfuT9VbdUHtwmWha6KHUY9lF2jdjQIz?=
 =?us-ascii?Q?anPYb+9Yws677oe8hXBy+U36PvfA/XHBca5bGGdbzRnXUg8xTasX5IaMdH6p?=
 =?us-ascii?Q?paEi12IK+EeD3wv263O5DTBvNkMFn45mZsDQGdexilnHZDd19YzbLHjg7IaN?=
 =?us-ascii?Q?9oDWtqnHv/SwmTShXxb8FNAYZAbwCgLQ61Nb+Qv3Dx1RXppoPLPdJsY8JqHx?=
 =?us-ascii?Q?Yo6sOT/0aXglGF6Sgh+v/sQ5ZV3UVpNoUhk1ia7QhkeDdmmcqLhPrOLnooeT?=
 =?us-ascii?Q?Frjqftv/lX75puMSSI80h50o7A2NjVCqiM5ShEyg9lPWsZwAJ00+Iznc2XF+?=
 =?us-ascii?Q?Kw4vprQqVQu1FqvZ6saJGnVeXYv3we5iZ/J+mbn/yCguDp/EV7MEYDE40UAJ?=
 =?us-ascii?Q?PMlZb8aSnf6qHDtsGskt57NAC/FXFHf+oAyIgTy/WJzbizlBBZysrr54eXez?=
 =?us-ascii?Q?SiNnFwn4f6mZeHdMioPAEfdWbjD/QUla6QCNigCDDmqA55pWXEyxW95kdMUM?=
 =?us-ascii?Q?+HIeARVMbAW1rSRQ6PE2NcdieRIIr8+4NvOA5spYxHSox8xvAohSe//ZbDyk?=
 =?us-ascii?Q?5X7DtJ0L5PLObaq6uM6FnDjzxk6JPUF7qAyeZOFyTGeLf2AN+8L3MmgiD2gU?=
 =?us-ascii?Q?LvipQwa86n6UcZFnVCNmtNH5jlhglaS8YBVG9HFvFJKjkD5JF/d01M6rsSLA?=
 =?us-ascii?Q?gJWFzrkOAG1xTq59DcJh0QIcInugRSejjWjUIYHJbrymmKu9a3qlzs50QnBg?=
 =?us-ascii?Q?R2C2EtDd8okzVl5iEvNwSsVfEKiwjdiYON3QIVvPfPRJsozsdoaZOhPyhF8K?=
 =?us-ascii?Q?kgbNrUnZACXLvskGCqAcomYMNStR3ZPMiUnoqBOLH86LLVLTAzSPj16zP9R4?=
 =?us-ascii?Q?dX8nxLcpzhZt0ufNUzBASd6CrvFgXQB1DnTEQO0IVIjkhzHaTXaSISC5+HVa?=
 =?us-ascii?Q?m3nm4kp+qI9wYU6A3r1rgLgJDfg3CJZ1uMyEhXlUBCzbVgT4oVALmAdckgMu?=
 =?us-ascii?Q?tvB45MdC2f404oVmMX164JoFsIF3NlkkJ/x8wEm5IO9PFkKf7CPeJrCItNGw?=
 =?us-ascii?Q?qXQ4UzOlTqKqwtGfKPxyF0vOIv7GaljYMMWGiVFeev/ogF7ZfPStyyjE2wdt?=
 =?us-ascii?Q?/Oup5v2xpLB1o2fWJEH+c7onS/WF9gYEV4iCLojx16n1aU6bWx+O7+meua+q?=
 =?us-ascii?Q?HNaVTsP6x3CiIHNFjGpMvVe9XJgEIPyOMzfMGvqG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9e4f80-da91-43eb-e3fc-08dcc58c0c9f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:00:47.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf/oLFBCHKzrbBJJsGLXavZ1Ip3tzov5pa2ok/OLToXJd9QSpVVAhxwIb1NPTsCBExHV6CyWXRPh6coNf3yYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8058

From: Carlos Song <carlos.song@nxp.com>

According to I3C spec 6.2 Timing Specification, the Open Drain High Period
of SCL Clock timing for first broadcast address should be adjusted to 200ns
at least. I3C device working as i2c device will see the broadcast to close
its Spike Filter then change to work at I3C mode. After that I3C open drain
SCL high level should be adjusted back.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c       | 12 ++++++++++++
 include/linux/i3c/master.h | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42..6f3eb710a75d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 	}
 
+	if (master->ops->set_speed) {
+		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/*
 	 * Reset all dynamic address that may have been assigned before
 	 * (assigned by the bootloader for example).
@@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	if (ret && ret != I3C_ERROR_M2)
 		goto err_bus_cleanup;
 
+	if (master->ops->set_speed) {
+		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/* Disable all slave events before starting DAA. */
 	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
 				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d9..2a1ed05d5782 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -277,6 +277,20 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+/**
+ * enum i3c_open_drain_speed - I3C open-drain speed
+ * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending the first
+ *				broadcast address. The first broadcast address at this speed
+ *				will be visible to all devices on the I3C bus. I3C devices
+ *				working in I2C mode will turn off their spike filter when
+ *				switching into I3C mode.
+ * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in I3C bus mode.
+ */
+enum i3c_open_drain_speed {
+	I3C_OPEN_DRAIN_SLOW_SPEED,
+	I3C_OPEN_DRAIN_NORMAL_SPEED,
+};
+
 /**
  * enum i3c_addr_slot_status - I3C address slot status
  * @I3C_ADDR_SLOT_FREE: address is free
@@ -436,6 +450,7 @@ struct i3c_bus {
  *		      NULL.
  * @enable_hotjoin: enable hot join event detect.
  * @disable_hotjoin: disable hot join event detect.
+ * @set_speed: adjust I3C open drain mode timing.
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -464,6 +479,7 @@ struct i3c_master_controller_ops {
 				 struct i3c_ibi_slot *slot);
 	int (*enable_hotjoin)(struct i3c_master_controller *master);
 	int (*disable_hotjoin)(struct i3c_master_controller *master);
+	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
 };
 
 /**
-- 
2.34.1


