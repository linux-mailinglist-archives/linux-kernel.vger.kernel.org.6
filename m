Return-Path: <linux-kernel+bounces-275763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A10994898C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6820280E07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F471BC9FC;
	Tue,  6 Aug 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MqbO70yI"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B63149DF0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926465; cv=fail; b=FJvMx8/rETrEwbH28+L0A8K2Mmkk5ydYuPPFyuQ6/mJ1g1kq4ACt2hvakwJZZsfjEKmlYBlPydWnNTu7xFIz8bBKZunCY7o+pCcGUQxUoftAC2vaUVovJp5lup566yK7ZldRyDDXXesuvqsWKWWS2dK/tBWPujuvY9TFtZQ68CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926465; c=relaxed/simple;
	bh=l/hQ60LzBHmOy0aregeZutt0SmTjDJvQPKwfnJyfLaw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WuvKaT8Fe/fBsvhrNWaKwsRVv06f/01JKkgJFHnZ1rw9xY3GMdyj0pul/MAr8Sb7N48WRCj4rWFn6ZHy2roJU46JbseqOehHqqf+yde5j64hnXxTEfp3+eYYHRnMmIDOJ00U1uq6hhFRK+hd2kZM1wpRL1OelVxI+IVPODwxJPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MqbO70yI; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flKNZt8u2dpsoeGZYgInepSof9zyJ/5TzD5Is9s+G1WvejGkLaoK9P1fl9kC7ilVzbob0X23VycspCZAUebnb2rAw129PELUW1wEZKAMRF3ZiaGpa7l8s6/L5teJRIOmdN9fcV3xkng05uy077Z3s9GmuCxvDs6MDiIjID3Kwt7U/rIEfjNUsE9mZ2+EaZEUXNi3A3gPJxn/GuM2yV54Pa1vGpRbnksU+YhRMQMSPpwUA9enGqxrlYUODF+q2ZIvbmn1itfEiPsPszhhHL0DjzSPSwvO2lcyoz8+Z1GOqmXL9XRRgdT/doAO9jlWzBgjI3qbEAcc7vkzhCA3uy4dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErLV1tIvao2dN0HR063rroJmN3k2/TZ4fzvrDtm5hp4=;
 b=dKQeMhSlXbsEuxYaWeH6saEUf2kDElx93nETpIAnviIrBwgzJDoQoU7Zc5nHG+dWsGsja8EVkQaf8HvSqSpsThyEPDGQ0QkMCDgdsCPAvOpMcJkfx7rbLMGnrb16dbOiMrRlLaJ0SHr3EUSPZkPxmvoA69Lv/zYiQeJ0SFcjKe9RNN9c/m2u6BKHNRRUCCvu2QXczOoy5i5ew2xRJUe7Pfb1nmM67OHDeBD67QjGlYbvctBWWAva7WRtCUNE1fQ3k8wc9WglU8SXjG+B+MDF8GhC717cAIw3vhKjxkU2R1VaXdJ4WFzd5Q5YfCHNytUCF2++cZM/qX4A7/5mkgV8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErLV1tIvao2dN0HR063rroJmN3k2/TZ4fzvrDtm5hp4=;
 b=MqbO70yIj9CM/3pkJVtYQbJqpNr6JMbKH9N//LpGazlokMQaZaW/RXRd2mK8709CvCk3+SkpFXZsMrXHyC4kAzmXZ6+twtg2d4yGrJbpOTIQfN2vHl0SzZlYPRv84sEvRHMRWcBP5Scx+wJBZibxKXjL3sXq+1FPlNIsEFoXpeczzbI1hqbMsMDSRqBC0UL3M5QpuL/eZVQdSYE5Y/1VnrQLN6/7CV+z2KidBBjORfiFn3oOrI6SARxwrp8woZoc57xa9H9+PWFo9vK1f+2LppBoSGDPWOHE7xYxo/p4VpE/wfO4moJxTM1caSC12+bLagRoD0x8x4NW+lhlil9o4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 06:40:59 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7828.021; Tue, 6 Aug 2024
 06:40:59 +0000
From: carlos.song@nxp.com
To: alexandre.belloni@bootlin.com,
	frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: [PATCH 1/2] i3c: master: support to adjust first broadcast address speed
Date: Tue,  6 Aug 2024 14:48:50 +0800
Message-Id: <20240806064851.2425797-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 5df0112c-45f7-4b43-2214-08dcb5e2bb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rEoVqTOQNRIbJPDGEb3iHPmuDJsmMTit7shaimgEHh7ADBTCSb753lFCPnDV?=
 =?us-ascii?Q?PZufg/bAO7JubAB4X8YhjBHUPJfwGjWlnE3lfLScYXZ2MUDnaiO5fTnu9Piy?=
 =?us-ascii?Q?Vr4KrPzBr3YujtbtJuJohAnJYDw8F1oUT09keclL5UC6LlgKaIdpLj4nyFkh?=
 =?us-ascii?Q?KZ7IggMoSH/SiObHvRnrz90GdMs901iDOG+MGAH0LwOMe2dM+FNFIDD++gdI?=
 =?us-ascii?Q?oCEp/BiaKpyncqJBZ9KkyWCgI/Xy0fFK77whoeQ2o4NLOOMxw/mRW+IH7RoY?=
 =?us-ascii?Q?mFQ34OPulskJvHQWuRxf/6JucYkd3W9BPRSZq5ci9RWYL9mqXiiT5w7xHmqs?=
 =?us-ascii?Q?L7QV94CtuM5J9HkpNxaeTzneucHSqV7T00G97tMX8KtOxNqMKPIwh/V996qt?=
 =?us-ascii?Q?4TW/dpRs4/LQbGIr3NfDciqescRHTN6WtUldaMSfNjhWlw8qQCqhkCmQvmxe?=
 =?us-ascii?Q?Va7cKajEkp6Gfcjr6krUnLsWYKIyoZanOs5hF/Xxa8TLLL8A2ETAey0ZU1BM?=
 =?us-ascii?Q?s26fjvZziLgXdo/1A9Lb3AVJxbMUeCrTUETvmPHyI46NlzAxSzZH86wAFAGs?=
 =?us-ascii?Q?YnxVJOUyDQihmj6mt78YwG04nMbjYNiud+/GBRlLuHXgmHljA6DFzuEgnS68?=
 =?us-ascii?Q?Xm4l4JzKH6edoVXswZqnHTBvhe7ZwXuCSXTpnyEs9EYfI4QoTQigyPF5X6M0?=
 =?us-ascii?Q?OzXIf19esIoG16qDUAVmMfUwVEmR+VBZCyFYOtQ52XoHf+vQSrR5ey5QAUB7?=
 =?us-ascii?Q?kteo8t9oaMsSBVVtG0skpfqGpY0D/z0dlGFKI8bglBTHCb8G+5X/aj+sJi2W?=
 =?us-ascii?Q?ovcXEhnfnCl+Znk3tdppKAi+mXGvSPNPQ4CWk/MnAiEyrIKbyoyayPSYVpEh?=
 =?us-ascii?Q?O0+qfeBt5GcnLB3y0ygru7rG/mkOxU8i64xbOx+dLi7Uk9jFAFoBWONp3awO?=
 =?us-ascii?Q?xWxpnh1zfGjG23VbqgjCYJUu+p4DxcZeeVAyMbbxUxhPgQ8wbHSOYO4DeZgG?=
 =?us-ascii?Q?x1raMe2M7/NS2J14hPD5cLuXU4yEarSl3HfN68X6H/9/Qig1v7GlFichjOAS?=
 =?us-ascii?Q?bIKvoXOHd+1TMdcKZ3cbBSBA3Sbj8I8kG5Ddjgd7G0ahMDAZR6mz32G/Owdt?=
 =?us-ascii?Q?CvWAJ5c+QoHO5/a/crPudTnBM12w14DElNyQqE5kQ6uDXfNaNA+yfgtAAwmC?=
 =?us-ascii?Q?SoZGJ4ydx8mPGAMoaCHf87hcDWwGaLEEezZZzBMlc4hBVUswq3QCqW87zqRy?=
 =?us-ascii?Q?LOXgfZ7TLLrPSRr1TnAeRHg9in10ho+oIgSXMa8VX98IYZW+vDd1tW5sEMDY?=
 =?us-ascii?Q?D79yqhVNDPMFE4p6x8sCsBNiK8+e58QUPhWRo4Fn+qddkOUQmf981Un8BR5Y?=
 =?us-ascii?Q?GY4yiG+IBa+sKYl9fgs+Eoo9g8eR4KyemG3vqrKehJjQh21KLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wkeTZqE/zZnd+TKcyOVGktKmhZbZKyF+Lu6FVyZpZdGPO69r6aVtDCYNSflt?=
 =?us-ascii?Q?DiCFZpVj3yYr69xMnB1lT27llt/03rJbe4eJFUydHR6fSH2km/YK1l9fsVX6?=
 =?us-ascii?Q?Q7c43672yY7dzbL3r5zWWKSJEcpuA8WseNqOLr3K7Cr9/TdKRURUz89nfLAQ?=
 =?us-ascii?Q?0QGUBR8uaUgoLM4nccOFCY+KpN3tFt+Y70RcPWYYCmFoiqhssvT1Vowh9C3Z?=
 =?us-ascii?Q?d6Vat5354hKDeJNQXLCiOy/W2JhAq94w6T0XWGzhk4oQsP3orkkglK15rd77?=
 =?us-ascii?Q?G7tvTAIj+sRiBsnkpOs2cVUymGmxzQRTJtQBgKKd0eBRjpKP4fsok4XTuUI7?=
 =?us-ascii?Q?240UQAdf6lZRAPf5zqISSf+2QqA5VQ9vjF/gSfs0OR2HxTDXRUPXJkEbv7sW?=
 =?us-ascii?Q?2RJk5Buj2DVfF0n4lR1izh/NRbxkbXzk7TF7StKKs1FGWI9PYm5z8yPcwLpT?=
 =?us-ascii?Q?uhfHc+BPV57uUncrmiEpsUorNDvSlNpHsKxHeuzrrcfOy/NwCCVz6Fwpr2pO?=
 =?us-ascii?Q?L/2GGYNruO/yxDBeKW6lR+FsCU7UjirocB9zuD74T9R3f409oqsQkL8gS9CD?=
 =?us-ascii?Q?6c7E0nSDbA/76CHKLoLh0Yp726tvmMyl27r3AkvwvYFEXt0i+4TUifnqDG4n?=
 =?us-ascii?Q?Bw/R5+r3/17r10TpfDMPVuPEHQ5Fu3QyvbbgxlphUZy+yE3Knmrv74Tyxih0?=
 =?us-ascii?Q?tlEUEDuC4TCyqPAsi7xqKbirOvCNECjRmCwVXIBKS9c76TmTg9WB+2n3ZNUJ?=
 =?us-ascii?Q?Ve2u7NtM0NXbpRxwu9Am+scbalC6p4LzPxc6NhClpj3LtEfjd5sIbOaI1mrW?=
 =?us-ascii?Q?RGYLzMCgndjU9a02/RN8p/8D9s+OTshR9iJFIt8z5/ADCXvU29Y3Y0kGR58D?=
 =?us-ascii?Q?AbP1Cz7YOK5CdC4qHTiRzZlDK35sl8b0ORPiuEM2FxxM17TjQAR19s7vNv6T?=
 =?us-ascii?Q?pOya3u2O1NEx6mWNkiqVwZB9jXgPHeZbyHx9rNgdTLiKBd6KDz11pvs+42ti?=
 =?us-ascii?Q?YRUOoh445EzHIH/IAW3l9vfgoRG+lPb49zlr++wlOTPacyDLE0mQ9qMa0T9n?=
 =?us-ascii?Q?zeWdyygR2lTBvYmVnRT01o0ulXmO+VgA8Smw2ukqvIDpnB4SEW5KVUW+KErI?=
 =?us-ascii?Q?NSgiYVW9Kb+4fCSLl3OmMJiK4CYm7EmD3Ij25bwx2LOyieSNErLbtPVlL2mH?=
 =?us-ascii?Q?ceoDmyTbWzfJH7x1aiU+/bs8hzTP0NQJ/gIatfEjlLZmixMSHHoOlGpThOtG?=
 =?us-ascii?Q?prZHxim+uJEDhds1JKGvpbEZYa+Zyx27C5bKPEGKSb4w2/fqE6uNP0LQUu/V?=
 =?us-ascii?Q?o9eir859wL+nfxuTCu6L0yF/gVp5AOwGMz4Hlx+l29FJQ5ZgFvvJ5dahZiVs?=
 =?us-ascii?Q?OsbyfUhSPZ/jRaZs9Gb9kJFH14Y25pqcGn+diM8iZV0AzolF1wzvkroSItH/?=
 =?us-ascii?Q?GpTN3lWFSTkb/tvPT9zUjxMTDeKGK8OeCBCvylX/uMYnEbilbO/MEDrijBCv?=
 =?us-ascii?Q?uuacfWV7mvTP/6TkQUg6Ku7zcMdjH7+QYAau4HOBaPv4kPRHPi4thAnsnK2K?=
 =?us-ascii?Q?X+NtsEHlj1wvp/NQGTBRo40XybYuaItRR26APiJG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df0112c-45f7-4b43-2214-08dcb5e2bb79
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:40:59.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ7P+od+H2XnmfLZypJhdmKl9ocnvZkfQFNzQ8Nc91X7oQ5tJ5Kv/+1QA8bFgV5jR9X/bGa6tOT95xQkgMukcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912

From: Carlos Song <carlos.song@nxp.com>

According to I3C spec 6.2 Timing Specification, the Open Drain High Period
of SCL Clock timing for first broadcast address should be adjusted to 200ns
at least. I3C device working as i2c device will see the broadcast to close
its Spike Filter then change to work at I3C mode. After that I3C open drain
SCL high level should be adjusted back.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
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
index 074f632868d9..02e4f47f9d01 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -277,6 +277,20 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+/**
+ * enum i3c_open_drain_speed - I3C open drain speed
+ * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open drain speed for First Broadcast Address.
+ *				First Broadcast Address in this speed is visible to all I2C/I3C
+ *				devices on the I3C bus. I3C device working as a I2C device will
+ *				turn off its 50ns Spike Filter to change to work in I3C mode.
+ * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open drain speed configured according to
+ *				I3C bus mode.
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


