Return-Path: <linux-kernel+bounces-197088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A378D65FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702952900FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB68155726;
	Fri, 31 May 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qbn6nF8L"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF31420DD
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170212; cv=fail; b=mkSndA/Le23Xl0q7jnmBrhUB3/Ft0wxkTAi0pDfvlr7skiZcwJrEMMxd4b/SNpxDBCqy2v3VIjUKbABs15YuW67/mgYH0U2tQ00yVOvSOrn6+z69lZ5W3bdYMCTQmKpaL/2tmZpV81ngWnFCBRIZ0tfVR4bS9MK68WhyziO/PSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170212; c=relaxed/simple;
	bh=LWyoI2Rb7ciBVh8y0WJrLQpa5VJ/rm2nLGRJ0o91ZJM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AV/Hoy2nbUqgXD7jrp5LxG8F14p9zhEtBV3vBUEn5KQa5aGAmX58BsAQ5kEfHRyg7pVFO4+45cJLVIb7nkjTyzL8is8D5+GkAFW7dmWaYYQA0ue/QfcycZy/6BKsfJ/FGisFUCiSa+WZV1c/53eEcyvS1oOIBtOEiZv0tFTtBTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qbn6nF8L; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBzXdDw/fxQ6ySZxdRq5+UQRO1OSSyImaOMdCikmlL3gkLCAwxrPdT9/NAZVJx4X4l1aRbmdi6wrTI/aJ9npHkMa+fsTHil4o48UcS/9C9XBYCZy4JFseVeadFXXFzOjledN1sOXMqIDdQh3luiuwN48rPx33DeujGAePX9YGDEnsTl1cWnUt9PLn1KfIyEzfYR+PhJeHM+/O+hEwg7GDFC+nyNc/xsGybxSueUEiFeyzr5oAIGzEhiv8Cfv+e8W6AbPn+64z8QOOGwQOKo6XuGEoSyL2LbAG5f8wNOcwqJ1suUs8gmcU+5ml014QGwzFlWAEcPOWJbMZTQ4M5+U5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3HQz8cnIDtSZICFSDsale5sAWPlHWfAZhfoat1UN2k=;
 b=c+4Ac8aimc0eVt9oYzCneGkO8KrkB3M4G7n4lyM5zSa86hrtEmlyhAJO1JareUjJHbLNRELmb7san4wCRRd61I+WZL2sTptFW7fSrMQahYUeFPqXjQwgNmrK8sVjfDICgctGmrP54VC4a6AzD1CY1kc3SYH2VP4eYhN67U37AKyX1t5tHutD2TL4cp1GFd0d4i0MfTcYeX8glZp4IUCe2iXvWrDCLvjJWoBDY4IJ+QcFyw9nq8dxnDiaLeoHeG6P+7Mz4LI6u3jM+7w0Z0H1xSgik1lhUPl9IbRp505X4EwfCTbWkmyTYH5Yeu+H8+TN7ffJuP9aIF2sBmmKbJGP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3HQz8cnIDtSZICFSDsale5sAWPlHWfAZhfoat1UN2k=;
 b=Qbn6nF8L2dP1L9ka9ZjNNesiKtY70OGvrCNdOgxektfx5GuKunOMKcZ0cKXU+G8eI8Vf2LiRA/WN8MI+wv/2LoDNQPFteJ4CY1JWL43sZ79GGtbfrrStWr5ORwQozb4Q3X6K0OJoveoXErIZ/Z07tfxf8esw3eUjtJvk8PDKuKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7605.eurprd04.prod.outlook.com (2603:10a6:20b:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 15:43:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 15:43:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE MASTER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] i3c: master: svc: fix IBIWON not set if IBI follow a hot join
Date: Fri, 31 May 2024 11:43:08 -0400
Message-Id: <20240531154308.1246214-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e69c251-ff58-408e-6f01-08dc818869bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIkaE8I400MQCQ6MCMmTDxzsWc+Y2RXmUUrGTQ51nVAQFlhBA8BI/8a3zn4Q?=
 =?us-ascii?Q?oXkdAjIXZqtlXSUfbBNm9Vuy5NYdUVkw11+lMemzjDW3ljZ6roMrDJ5nhTzz?=
 =?us-ascii?Q?+2NOeGL0Plth9YGpAy/MQu6WgSKg9P5ATpvvv2nhPsSVAB8VLRzBu+UOUDN5?=
 =?us-ascii?Q?4ITvFLGLHJxJeXRf5zXA8Ah/rE04IhTnAyMWLuMlI2LLEmh7m7LLPWNw0CWx?=
 =?us-ascii?Q?EK3BUXHBfQI2eGiZiQmP3eFwyNmzAoRlhRYHXymHxGRWPXdxY6lvZxKyu/WN?=
 =?us-ascii?Q?Hb5GWKDGsKpUXuMjW0dpiTVdtLTx30C0YhHgcVu/R3CYNLw4cuXOZCIwiW4L?=
 =?us-ascii?Q?t0mZBRoTVkgzc7/QZOFaNetlTAQ65QaJhaWR7zmWNe4Iso1GDuXYaa2ydKd7?=
 =?us-ascii?Q?zfVR7JlFTtY5SU3jRAMlv+lFU+feQNn1se89BEF/a/414K6XmmXCHV+/ByUq?=
 =?us-ascii?Q?vClyE5TJqB59seZaSy+taPvbtrMl4eh4+GhLZu8tqUltN2YLhzhGrIpgQNeN?=
 =?us-ascii?Q?U8ATm810rq8B3f7/mMRDsx06iGnV6w6JrL0vGCRuQZWQaFkCC5caHC/1gvH7?=
 =?us-ascii?Q?enSox04C5QZQxE8TpUhMU1MYDYFgKbmBvIWmJHFK5Eg5un8pJO42viiiGmTP?=
 =?us-ascii?Q?oxALBaDy87KKcUdt/V+5bd+7oKNrVEvp7k+AELgCQQiiywpLmz/Ju017RVzd?=
 =?us-ascii?Q?3XUwXzQtnxKnlRVQqYirbNj2Piyj5+p9uRsNZ9bbx2Is7QXUXEBVZDK+IWgQ?=
 =?us-ascii?Q?c5G9UvlYIBX5cpu2MF2lWFvcoU4F4gL11X6xQHFSKsUplIzxjWHpXLSujI8U?=
 =?us-ascii?Q?Y7yndz/Jx+j2tb9hfEV5Lj/3N29PSzBzcM7ctK+XECbClO5r2gY5FiVBol5Z?=
 =?us-ascii?Q?fKxerBYiDRbZLsVGf184XEBW2XxyJlvEcNOtv28SETjtPO4VJ3nicVNUBFvX?=
 =?us-ascii?Q?achrkych8mWRW+uH3pyi8nsDaEdCgUrao1rBPlYZXjtXmP+L40Y06PRJYFq+?=
 =?us-ascii?Q?9E8jMaFMBJNLrvBdwBkTUoo9H1XZrf/1ULPlExWwz0sQQDhapS/lS+3YC3RW?=
 =?us-ascii?Q?20uu0WES/NnAFfSIMWIbdTNm9/lkzJUwdRqdfxP7Op3sSZdqIQCnPKjhFwfm?=
 =?us-ascii?Q?v7AJOaThd+46R0n5gNRlgZuF8UrW04kAMTptqoaeQ7BgrY1WViXSUBZc10RM?=
 =?us-ascii?Q?Y7sdZZc5hWbQCcydUXHY1khqBqLckbdtXsEzTTezrwertRNGeg63OzLyWiiR?=
 =?us-ascii?Q?H3qgzXZxc3a+ft5zKat1evS/wDpoL6jLp54nz4RY7qtRcUhfMVchUBI5aQOx?=
 =?us-ascii?Q?16Q5b07nGG737EJ6PiuZIAA33UFdtolNv+V+clnA9/VYoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rl4zVHo1yr/bKDTdH4m/ew+QOSvY/Jy0P9+xSTtkZZTHmo/0EM6MJLG6uTqc?=
 =?us-ascii?Q?yZi8LXHiLGGf0DOttRzL1BuwTuT21aX7i/s0m9wi58iIr3Xo5WH1pfqvXY9o?=
 =?us-ascii?Q?sJRVsmOOv0yNPeYkgI7k2V+1W6krGXOktwN1qGe8tkD9RliUa+zTad3KcEe+?=
 =?us-ascii?Q?aSqzouskjsidhVzCAkwFP3pEu5awEVfEyU2fS8diaSD+yHQ2YoUqPmz8HB78?=
 =?us-ascii?Q?q6LyVpdwKNd2xg4Fhdi3NNKww2srMk7yMGLzN9rN4Kj0rVjZY5ePthPM2Vau?=
 =?us-ascii?Q?RL4A+SinryZku+JjuJtKi7AuqDSbNG2kHYpDCWPuslY2GQILLGKbiewZModi?=
 =?us-ascii?Q?iheRCxAJHrRoLc88p/r5xaaTia4NzK/C7wJR+hlj5HrdOpFt0nIjTcGN34oo?=
 =?us-ascii?Q?H0dbEPIE4my7ccm+BPa7w83SesgD5b1+cdMZyrrvkfh+HX4ZC9KykWUSDJkf?=
 =?us-ascii?Q?Fwl2j7UzOq7ItcDlog5O0NSfLYdYgo/SalMEBL1mxDeuSHUntoBBMzEB3kC0?=
 =?us-ascii?Q?Bf3dGmhUqDcHIbdI+6gSiYPomXalR+UQzJmqwmjs8lQLDBWTkXO/LOUvuVpW?=
 =?us-ascii?Q?qLOoHlqlQGZ0IlBBJK+ZwNcmNTXI5Tk2SgNSea/9Tn3ca2ujUrjR9pNlxorn?=
 =?us-ascii?Q?odQyuwkteq+uJGo8Z52TDFMepnNOwkz4KmE5ZQnsXKYMv1xJRmz43O4RKMGJ?=
 =?us-ascii?Q?T/QXZFfjYzSjDH0jGFAFVNl2QM4CZnKp3Hizn23OQOBCLfinrNdGfWrBOWl6?=
 =?us-ascii?Q?JtMZAj9i/GhKZNG6mqCgXceUPCFQ785NDI8RdYGv1mgMrE0d96BTOk/RCXa+?=
 =?us-ascii?Q?j65l+aWWMO9nLE7NjkqZwrBMoIY+kF7L98ik2Iy2q+it1DGZACm/Ahkhz0UB?=
 =?us-ascii?Q?ULGngy98yrfWzEaFb01pN5JMLAArXIfWMYUHeyniCYkxDM9zJjtiApFoYpx3?=
 =?us-ascii?Q?WAvsIlc3O+66UsQnZuN1jfhUFd6fp/JDBl3UrJuZPOv4Qf+wDRSF9UOSXr+6?=
 =?us-ascii?Q?vq2lmIee/RhWgBJH2PeNR57txPSnMWZBdeg9OUufxpu67lEIVAeZq/NDGvcZ?=
 =?us-ascii?Q?bBl+hnh5XY4GE3JVJL6bJpnJV5DQ25fXTJMwlcqLKgJIIE9/ntlNFy11QxBs?=
 =?us-ascii?Q?KgcYWXyLwDDW+LpPPZhbDEpdR9utZkL/vkRlotlvWuGzZrpBXtesxEaXpKQT?=
 =?us-ascii?Q?yPtfmmPjijatF1F2y5fidH9KGAfwTp7laxtcCWLqL4tJGgg7kZbIFVOgBaJD?=
 =?us-ascii?Q?Om/XM0sf4rcI9yLD0m5nIABpbVJiem5NJCH+HxTlL+KyjvAuSas1jGSgZ9M8?=
 =?us-ascii?Q?5h7gPy5FCCtuyXusiLFIAxVdECX4NH8SXl5jZqgRsl/SJkhOp0bBVRierzgr?=
 =?us-ascii?Q?lyEhQGcJ+gk6FRntmZD74y3Pn1v1NqSItWazyc5BoHrQ+jADnSrB0gEdWT7d?=
 =?us-ascii?Q?v60HybaU1FljlbQJuIS96cs2rl07N8tBD1zeh2tMBV0SD4JrimVzte4Wzp4Q?=
 =?us-ascii?Q?WMxO8NCvA9UMjhygptosKe/hc1HWThPTXIO2WJzfHK9s3b4AIC9FJg5jCGbj?=
 =?us-ascii?Q?xP4IqqtztuOjL6oGW0LFjiul0wvhC3JwpdH+Irlr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e69c251-ff58-408e-6f01-08dc818869bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:43:27.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtunjkrM1emh+s4EeyFf6gLrD1YZvjNSaBK+7X0V12hKo8zu85VU6FNXxMedWRDGoAtD69qDNWxg6djIYUMWUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7605

When an In-Band Interrupt(IBI) occurs after svc_i3c_master_do_daa_locked(),
typically triggered during a Hot Join (HJ) event, the IBIWON flag fails to
be set when issuing an auto IBI command.

The issue stems from the omission of emitting STOP upon successful
execution of svc_i3c_master_do_daa_locked(). Consequently, the controller
interprets it as a repeat start when emitting the auto IBI command. Per the
I3C specification, an IBI should never occur during a repeat start, thus
preventing the IBIWON flag from being set.

Emit STOP regardless of the success or failure of
svc_i3c_master_do_daa_locked() to match I3C spec requirement.

Cc: <stable@vger.kernel.org>
Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - new patch

 drivers/i3c/master/svc-i3c-master.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index bb299ce02cccb..032fe032ec433 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -961,11 +961,11 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
 	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
-	if (ret) {
-		svc_i3c_master_emit_stop(master);
-		svc_i3c_master_clear_merrwarn(master);
+
+	svc_i3c_master_emit_stop(master);
+	svc_i3c_master_clear_merrwarn(master);
+	if (ret)
 		goto rpm_out;
-	}
 
 	/* Register all devices who participated to the core */
 	for (i = 0; i < dev_nb; i++) {
-- 
2.34.1


