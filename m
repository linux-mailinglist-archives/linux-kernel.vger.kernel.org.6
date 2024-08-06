Return-Path: <linux-kernel+bounces-275764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FD94898D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E250A2811BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB801BCA10;
	Tue,  6 Aug 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EVMjfsKw"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3A1BBBEB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926467; cv=fail; b=p1h+weR8R2nbHXFAPmV1pdeOoXIwlM9Tqq7/I0Kh6sZyUGqgHxd8NQXd07b8CyEkTaLd9vVjZxLZEss5PAuoMXiD5lnMZTC5UfueKUHKmImKu0hYXhgmswfo0X45Y2syCMFQpNnDSzHONs75TA6mecEoWqZVIqmEakScXteff0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926467; c=relaxed/simple;
	bh=LYFXIyBXEdhnbilpaOxXIkP2lvVdi0a1V8iK6C2W4GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJ4csbmYQmNasl32jRdzLPwnS8x2V9fPHXerEaYuTqrv6iQc+YCzSWmcKy/cB5RdnIZAyIpYPMTu7imbEtXzSkY6adHDr/1VMdJQNpMxW86STxnYJsRDnCIITEeN8QPn6e6pUKr9GveSkcByGCf6rBT/NzoH/SWsiCDCc07NEgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EVMjfsKw; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BunZl9NgqadfgDKOPtm7o08o7sU/ijmS6sKqxjj/Zy6c4AcFMtdYLSiIuG28Ox1PoZtmpqcSPOeKgVS1+bJS5a2zh+kNlGATnonRolLVS0u4B/fz/5RD5Osh4fDe4HH7y8rIhTSAGGNJtIH8sbZ1D58680oLnICI+wkT70+GBMMbSE7jyPRg3poqB4yT5CBOCK958+cgVF2tTAedBSJaa3VKhbkgS1AbI74yeK+Pnjr63QjWd4Sr24X0RwCdiokPe7yj9K7zgh6pnW98XQlG1IcZ7kwKm1XVK1JLBUoFunykGULnC/lI662BexAxju9N3q1YmgXIj4dh5IW8+puj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjSRBH6HICk+8sMLXJGzYuvzBGfIO1amZRqN2268VWA=;
 b=pAd4TXFaXBQOvbDVXkxJvbpisFT6LHMuTpNO9l4SkmbVh71r42s5U8K+rMuQYVh1bDT0COFiDwN2SFqYcQ/jDSXD46EVmKcNTF7Lxyz1RJ7w3cdhGSad40hRL/UqZKH6jFRucXSpyPkcQTlLHBAHvdA4AIvBVusmP27J2Hks8mHqS7f9lKhd7CENffedtjtpnpy3g/lknd1aDzfTaKzwvnLCtKHPS0o6qmGpJ8svnchELCZm6UOktiMK6Nda+bASMhZqaapXuwDC7ao0J/WRfkiN/bjEIWDO8dxV7//Xb4rZhbzbUhsmaOePxuQoQNte8+RANTNCx6KveSeffLPOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjSRBH6HICk+8sMLXJGzYuvzBGfIO1amZRqN2268VWA=;
 b=EVMjfsKwInPcFUVV/I970WRxmdLGhnrS+dZI4Ym/QhxremnzHY9NmzW1OmqA7wXLr0EsE+rqa7X6H/FeyBzVi9fctqXaanAZhzb/9W+nlH+QQoo5jj6CccYLjf01+/xBWCGUhdZANg3sf16gXFb6/aFUnb3rL4vQl6qevy6ogWGKLlh+yOViW9hcoKdLzXtOFj6/gwVfh3xxDvK3KE5062Dw3sAs6OGhy/PVZXDGFd0TRz6PQgJRw03CwTO70j5IoWekr3oBzgpMxiplMOOMY0V9rz1Pa0Zj8dkK2R0BYsETr9y5qP40AkbPkt5fRJs8fm2R7V3hiJg4g6WJSGUrsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 06:41:02 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7828.021; Tue, 6 Aug 2024
 06:41:02 +0000
From: carlos.song@nxp.com
To: alexandre.belloni@bootlin.com,
	frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: [PATCH 2/2] i3c: master: svc: use slow speed for first broadcast address
Date: Tue,  6 Aug 2024 14:48:51 +0800
Message-Id: <20240806064851.2425797-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806064851.2425797-1-carlos.song@nxp.com>
References: <20240806064851.2425797-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: e2926492-bc41-4217-fefb-08dcb5e2bd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbzwdgkJWNAU/iHJQQc3rX8vl7QR4PitPdrnFlCoVsoJYYADgXbNcC3f7bsA?=
 =?us-ascii?Q?dYVVA5ANFneNTyRKCPq5XnfJem/c10KDOOHnLIW10D0O7VAE/SLfUZ+uGxZ+?=
 =?us-ascii?Q?fNT/9kYNQzQgHye+sdXWFmG0B/W2FdOE57QvhMr79CgRNl2Kvfxv9/gNxOdm?=
 =?us-ascii?Q?IfXIVDrPZYjEhkR/ycsRPpD1MIunNOTSAiQU52jPfC1GOSTbtOwZujmur8gn?=
 =?us-ascii?Q?1XXgG19FBiGyMGzIpk6d/H1pFN6qbh2mZm5RjjHhgmNieWxKFbJdbXAPoeGc?=
 =?us-ascii?Q?nLbFd8wyNrR9AKLHvmlirJBlRRg/bajkdK7jqX3p7bDUW6EVUDe/Wx9JaDPD?=
 =?us-ascii?Q?K+PnjeIiImvfeDN/RmTHYz8y1l8tl3g0EBjdCvUMsTwpWLKU5rt4jUw6Lq8E?=
 =?us-ascii?Q?RnUaNfE/yVuF2r7LTot5NwWm9XcjUY2S8cmARdFJ0VnAWuq5jf2QDQSQgvrt?=
 =?us-ascii?Q?pd9OrAMhvXtYTMz6EWHqc77zXtZJ00yTte9TUCnSXp2MGaYjdORc5iRnQg69?=
 =?us-ascii?Q?cYX3unJn4+FS+Y6imwP5UeeKYCBnOyeFJOcXORr3USVSfS8lcRk71uGuPoD7?=
 =?us-ascii?Q?Uk0P8RUGvPqHNicvCLTTJpDbh2JKw0SqK+S2hb34KbwismgOtbNQyl+Hfy+x?=
 =?us-ascii?Q?UCfnx0xq28nXjG3iTsiwY5ARVwAi9i9cpK5RdwD9+MwmgpraAXWyy/cOb/Zl?=
 =?us-ascii?Q?X5stQluXeC/FBRkqCmvZYBh5qLf0wNd3u3mcHb+j9OsBKB0RIiXFxt4L9xRV?=
 =?us-ascii?Q?sD9ti13do9ZJAkBl8djWeFR+Gjnt8z8J35vyM5SVuFuj0p2pKTTkuTLBpxWM?=
 =?us-ascii?Q?dgHjnw6MSJjF9zJskLDZY+uELoIP9UIGUt5RQMRJs6C6snfBfkclgLpBvL7E?=
 =?us-ascii?Q?RaYgse2L1emvLcwzr2xSgc9aB2yTyB18GbAN/EMAvPXk8ywVHxKmwBS1BRsD?=
 =?us-ascii?Q?xwW1VQkJ94xNb9DmdBYTNY32G/UIHS3nSbCBYkEGGLbVjRsrIc3YcwrMtBR2?=
 =?us-ascii?Q?NFU3zoQySVgKRQbbVhtQea9zdDRqeDQ8cJBLcv/zHued2njOpe6iTHM9UM/k?=
 =?us-ascii?Q?wVnhne7MvkvTTIZg0XdTHZupYD/XemAgTIBvWvVUlDww7bfPhk7CljKEjRS+?=
 =?us-ascii?Q?pcdaisO6DJyCR+HaidSZPER8PZ/TR7ZE4Z6Z5yY1hZ2DYYnimX2j2IideC2w?=
 =?us-ascii?Q?dzH+uosasnRzUwVMZBrRyCXIW6K/0YliWeifZbN6UW9BES7a76Nk9ghtb62B?=
 =?us-ascii?Q?lbzwFcDH2yVuBnBgjOSs5S7J9E5/SKmezCNnWwYK5JMcizf/ZAUUhAQX5Pao?=
 =?us-ascii?Q?z8upelF0DEFcpYLesTptYNWlhjuFeHIpeYYcr9AOuccW0NJ6VXxjrrBpSnoX?=
 =?us-ascii?Q?yLsnSXoxwD6jQp4uAI8Z/1zrBx7CfGImHx140gcrcVRdrNSj6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3LZQRRDNBMcFXDLUoXLQLQ2jxsjoPCAt8A8fA7AuXsS7kF9k6XuKxarcEbF?=
 =?us-ascii?Q?7q5XllrnFB/kwj/o4DJJapzzUfZnJtfYYRreY7JypexOm8w8ZmpDStaAezSt?=
 =?us-ascii?Q?YNi2eu0DunGhcPlZIJjdfK7DrMB8OQLnNA68mALAwmMZxvUSAq1f75ysmztU?=
 =?us-ascii?Q?Zp4bOF0ft+uM48pqamyolxnY70NZbS4WiArlegwfp/U7CaB/MNlRH1PCo59J?=
 =?us-ascii?Q?mYBPH7nz1urjOE8qtTbbl/SiSSMtTr8FQHYG4tUNbGqPs12Qy5iVchkGAHWc?=
 =?us-ascii?Q?NhI9FO9Ak0dcmSM5dd+b1ZPl6+tC7E2c2qJ9sHvHUbK0866j9oXL37QiYubT?=
 =?us-ascii?Q?JGy+kG/6GoY9s5bFOXC8G3bLkZF78U0YUtaYZpmG/lP09486BxG4UWLJ00Ws?=
 =?us-ascii?Q?OjXKM7/8LFthOZVXstQvAke6HMF58NxOgHNjmWRXkJETQ0swXN4PggTcHfEH?=
 =?us-ascii?Q?drkjp9zXA/7U4/Eixv1NKpEvuHMp9PCIAxTftexRHbmJkHaoyH62VrarKI2l?=
 =?us-ascii?Q?Yj717kLOEj1FLvT5358knpj2qf3i6DOBRo5JeA7ID6Inx+dIeqXH9ma2AMnL?=
 =?us-ascii?Q?fnAH+fyLYAdBazWNSQWsrMiDx1mpyxTbvH8N3/Z9cirmhHN3DB4fI2my53GE?=
 =?us-ascii?Q?8FZ8k4eid0on+T8b//EmwtmoItZBbI6D95cbBRsQoBFffqkkmSEkB5f/gOiD?=
 =?us-ascii?Q?z/xOX37Xbb9dSf78wwSV3O+RjYKZejdr+zi2DcpEvj8YeYBVrcq7JSTBYAaI?=
 =?us-ascii?Q?WXWVImrIGEi//F4ddWojvMfGIeVC8V2bmBBkbDbRloGvBKFci009AjQlJOy7?=
 =?us-ascii?Q?L5fYRtkyuud0npBSCivdJ/01EZDbofe/KBOj/MJ6Uokn4h1GfjGIEU0HpOm5?=
 =?us-ascii?Q?ub/buUSlhKrvSyl3KcBg0ob1l+FW2Igmg8KxoNu3hptVyO2YA+/EsQHunmG5?=
 =?us-ascii?Q?q0z4/fD90/5X6dMMXItSMiJIcu6I4xPUP3gLq6LvISSTA4heVmg+RqodG2FY?=
 =?us-ascii?Q?fs3HYcMMRkDOSz3xTn0RhiuO09ekdNcDK3QyTNtCSvOTdEzBzPz7FPxCyS5N?=
 =?us-ascii?Q?+TwU9Z0+mowUQhL9v2mDUmh1FvBa4+1hoFp9CYrpyV6gq25B5v+a9N4PRfUE?=
 =?us-ascii?Q?h1gmbImM2J9rH6opcgCcvyBJ58Q1l0CD9EagBOzkecEk70x0vw5wi/R2tGqd?=
 =?us-ascii?Q?ydeEULQe3sOuCrLWnuouGJUgnpf9Nx1glQcHxa90ppSrkScvHNGx0T14oQGd?=
 =?us-ascii?Q?UKLMS0+UaAHcs+2o97P3etbR8/O/dQJn0fbHWad0uGwfYpKn1gjuQ8gLUsGB?=
 =?us-ascii?Q?zgmejOSZRh+cb1ZAX3UuaOEXxkXscTOp01MUYISOtimoWlPAwGZZG7vYjAVa?=
 =?us-ascii?Q?7Mco/Dfl7ZoWdjt87g3sIFlS2NKF3eUM302Zft3R4XAstGvohXyz20my8bAv?=
 =?us-ascii?Q?0ZoaT+NwrMc/kz0hk4gNtJvrBpXvk4Y65Qx36EHK+Wtzo4jdRxP3ss01Gmb0?=
 =?us-ascii?Q?upWM1b3i7VKP/uGauxPyXowGhfUHO7NJEjX6kUJF/SlATAuWqofisEi8v8Ca?=
 =?us-ascii?Q?mxqxpJDJWaNIlfvlM2W413RsseHov9O+A6rtmURa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2926492-bc41-4217-fefb-08dcb5e2bd45
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:41:02.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpgwOrbNlRYBGnoTscVJGHOHv9XBctYPPsEhtIPdd07054LrCABjDoYDboGzMvmDWWbq8agmYzMRSwEzy70C/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912

From: Carlos Song <carlos.song@nxp.com>

I3C controller should support adjusting open drain timing for the first
broadcast address to make I3C device working as a i2c device can see slow
broadcast address to close its Spike Filter to change working at i3c mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 51 +++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 0a68fd1b81d4..4cdce25c5cf7 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -212,6 +212,7 @@ struct svc_i3c_master {
 	} ibi;
 	struct mutex lock;
 	int enabled_events;
+	u32 mctrl_config;
 };
 
 /**
@@ -529,6 +530,54 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int svc_i3c_master_set_speed(struct i3c_master_controller *m,
+				     enum i3c_open_drain_speed speed)
+{
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	struct i3c_bus *bus = i3c_master_get_bus(&master->base);
+	unsigned long fclk_rate;
+	u32 ppbaud, odbaud, odhpp, mconfig;
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
@@ -611,6 +660,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
 	writel(reg, master->regs + SVC_I3C_MCONFIG);
 
+	master->mctrl_config = reg;
 	/* Master core's registration */
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
@@ -1645,6 +1695,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.disable_ibi = svc_i3c_master_disable_ibi,
 	.enable_hotjoin = svc_i3c_master_enable_hotjoin,
 	.disable_hotjoin = svc_i3c_master_disable_hotjoin,
+	.set_speed = svc_i3c_master_set_speed,
 };
 
 static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
-- 
2.34.1


