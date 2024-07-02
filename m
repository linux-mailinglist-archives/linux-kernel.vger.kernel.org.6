Return-Path: <linux-kernel+bounces-238531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF96924B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BAA1F230DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB501DA311;
	Tue,  2 Jul 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VAqcyx9M"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A71DA309
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959487; cv=fail; b=XaGdWD/usVCfSe/JFfYxt2xCSQf9r/rZGR2Up2TWZMcaRP89/TmuQ6koQ6q2TxNZ8s8+oPpOOQqNBVOBXW4wEsP6NbM80pn9MDs1s7w6h1bsfmuJ3QhoP5hppJZfc7dj9l1hvpZoe8V/9HuQPCTpm5LAZVAMr33JIZaEa7pxjtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959487; c=relaxed/simple;
	bh=IJheg0Xit9CUEsgmyysdHXeRLNiNZLBBCUhTiEtshJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JKGEXoPwjHn8a2Gn8dafATLSkkkpySYPB5SIQX01ALKWv03pTmv9bCGSM/aTB6m8AY8TF8TL+jviCWVha6TdItVYPFCyggXVDyQtu96LmJBIfV13C5jXY5JtSKXLaBINvBip9x2FlBKpeDa+7vjUdz5aNe+moPGAsIrsPX5czF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VAqcyx9M; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByM2DvtA/7tIVxZve1AfSa1UlF0Heh5iEAHP0j2y+C/lLPUGtRC8EQLHv53FPBezqB54FZGZO1j+OovXzoCxzf9PnlZvmoxqydAGSr9czJBlqob6Rcp2zN/SefxjoFDXdLLsw1jqDMRa5d0K33dWNanYFMpx/qSbpEhV2+eUri4xr5N72AePRmfCdqJpTxE9+11kQV8xo5KAICTP/8eaLS90GTTYZ1lzNJZkIbYyep2OdfChyM0CFP2zrbfr5odCXNWNj6sQU4ZqneD5sgf2txaaiwnOZt2RFqJU4wTVJMqvQFciFB6On4BxUbLwcXOaLLP+gouBy/IaBPzrKbZkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzAL42YO20r7weK4io8vj2inehx28JjVrNU+qQ6Tiss=;
 b=bkl1446SIB4cwbPwlpKxn20Ejsx/v1bTZObiFx+fVnpCAfCFefJ/aYTC1t5cG8mZONSB9I1RHSdtgqilNSbRqmlSRpTNN6lu6zf+zJkH93pCvJaDBPJnANFJ0cQPLpCG9sHzY/O3SUPcp9ezONo38FCIWUB6mRHcyzhshIXqRY23nXHO4IQvAy8NwzyNVwyJ/mi0Bupl31RShQKVzI+YcnIq9UhB4vPGKLqCPyfYUKOGOAcQdAsvJcRMMt+7X2z/titnLsUEzdi8AePFwvDi0vNofIagfaZJ0Oj9zOgbdw2IT1rlDAHSRzP8eYiMzqtK88oXqgt+JrrEuoUh05Tg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzAL42YO20r7weK4io8vj2inehx28JjVrNU+qQ6Tiss=;
 b=VAqcyx9MnNA79cb+unV0WX0ND7IMNjx3vsZiAhcewjrUo3D5dsRb8gBvOtovyz5eZJ7sB6VB0C4C91RzzPKlsOPY/+BSc4dR2zGZLMaYk5zRCKYAeIbUpCWPPQSMzoYzF4i4KhdccYlInW2NnQ3PwxxfXjeyWwsRHfvJqHhXzvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10961.eurprd04.prod.outlook.com (2603:10a6:102:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 22:31:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:31:23 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE MASTER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] i3c: master: svc: Improve DAA STOP handle code logic
Date: Tue,  2 Jul 2024 18:31:07 -0400
Message-Id: <20240702223107.403057-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10961:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b514486-ddc9-4896-1003-08dc9ae6b3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QtEm0DMHjFUMtfFOwuh9EbiYxXLDj/84iJORaDQTK1KH+Jm/OH+tDAr5GPFV?=
 =?us-ascii?Q?2qKkTxEcl36eJcoMZSLrTmnuFx0ngISjiGh0W2BIj16PJlbOwJ0vjQt32czV?=
 =?us-ascii?Q?D50bMEwaNmSo3z/bWo/abPmADhugeF8Y2D8QXFPf34P9CYVOz5Aps55shaOt?=
 =?us-ascii?Q?zqr5WiQF604aY2RATwXsoKWjlTNJ2jKSV1RyiLjKicOx+CJ6JNP4ad+UOeML?=
 =?us-ascii?Q?ZMzNQ0QYOmonAANurSRhgRNfGWdeSH8b0csLC3VWhUWBt9MafDbWhbofKr52?=
 =?us-ascii?Q?tig53LxU5yryOi9s3E4pDhCcyN2UevljTshxPKi3N9ed+CpLwlbuxYt+lzvg?=
 =?us-ascii?Q?OZbOUdZ54/BZqY/2ue9E3NThtnGTJcSXMC0aPubUxgqSE21dqeroYOZBPibG?=
 =?us-ascii?Q?Iu1PHRazHGwwAkQK1eCp+ubjiEyaQG4mNfvdclYLBPqcuTv9bbAPrGjVhUZO?=
 =?us-ascii?Q?UjzJAm3Q6bxCUMhcgdkm2Y6wRUixNWt//stAMQ2wAB+HVnboLHyEkk+jzMeZ?=
 =?us-ascii?Q?0dTKVp3kt1bMOHCX6O2tlpojXGYOOk7qho5f062Y/KZTHHYGVnMJ+J9sPPtF?=
 =?us-ascii?Q?KFZiksfV9BM2uyuFwYaZ+b9KudXRqP7BGkxEnR9ZHHLLOTL/tDryVdpwRRbq?=
 =?us-ascii?Q?haT4ICMAxtULDBDjSET1NbXGWMLldUMMKk8QRO7a/JBV+bYydhyN6EXnoZzL?=
 =?us-ascii?Q?lIvCPbsxRNGiD8p7DUokd0sDpJcvoBYUjsdTlaTcY0R985zRUCNsSoscmkMB?=
 =?us-ascii?Q?iq2aIuT4ZFCSA+W0V7obsMeeUonoxUXEgKnFLdf66p5xyUqJWQJFUCUuwKz2?=
 =?us-ascii?Q?ydyq95EM+EJxoiMsymAKt9LsKnqLHgU59M2vtXYBgPkaeyW+VbFKfHNNRx6v?=
 =?us-ascii?Q?m6oUIhGGGWp8MZY5m5risMAAp694Q/NydrmTN7hBLnbbUdHy9B9B/zpIs4Jx?=
 =?us-ascii?Q?Eq2MVDrKGSfsLmHnVzS/URE8vMRkhVPEGyVE54ajLcxVejVtwuIUza42HHq/?=
 =?us-ascii?Q?iv7qFnae7yQuJLsdStFaLYwaeyCWSwLMH/KmKvCdrqSaQp7UdeKzrmG9TvxB?=
 =?us-ascii?Q?jK2wlizo6I2VZjjmgg2Mwj2jsIAeKg+Ewc0iNKhXdPUE6UwDHSYWiqP4zFSz?=
 =?us-ascii?Q?emg6MozUJTGifkFZCnlH+Gfqcx7eAsOiBAS1ZWgsY/Rk8bJhg+AOOWR0tnrt?=
 =?us-ascii?Q?bknD+BWxT2X4FdWWkPd4ii0hAlqG7u9hUq8cM0r1JohGCjrQwFXr6ilXk1d7?=
 =?us-ascii?Q?9AKsaOk3PlsRpjcWVmvp9jmAWixGzw2Puc4Y4PS4t6B+28WCV2x14Sj5siXg?=
 =?us-ascii?Q?mi/tmzOC9fttYB4mJzLhq4nWk+SsSnotuIRt0wfpfsqoe5IohUgI0o82VsJV?=
 =?us-ascii?Q?nP8F4fj/epYegX/2DzmRjgkARE884P3KtHS4vUZX0wF7Ac1NEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0PkNxK5F5obSg6HNqZ9YLjfMP3psbg4UK/wbCJVyptEOfIn7t2YOiKFoNsl0?=
 =?us-ascii?Q?jeRJIvVjUhuilkxVVzcDAaRSdPMR0o9ffQEv8oWuSx5rWBw9TISdxxy1jnzj?=
 =?us-ascii?Q?wqEuIpPIX0OJn+g6BksATclCbEFUQJvalAkEIG/cF+1DRffHT5dvZY5fjN5H?=
 =?us-ascii?Q?PuknsgRgOZ8qEjDzCvbhdBTgaYJGhzsvvxdyxRDsxozJvjvoC9NiQ37QDxg4?=
 =?us-ascii?Q?XkPhWjlAgSz/ZkeYrR+iocorphk8RI8wX1glWFDn5ldSwCTNLw2fsJM1h6El?=
 =?us-ascii?Q?n/ZImETt5IusO8sMa6DwxiJNRgSUyDW9weZlaiwYGcDCFTgUIlLDd3jcPA5x?=
 =?us-ascii?Q?JRSAv9hm/4BCugYSi0rj4oyOOEGkgq4yCyev7GRlZMHxPMGSdcVSqprYImWH?=
 =?us-ascii?Q?lF4mTRz6XRmJVSbY7w7T/akvkomWC/Qt8kwSyip4P5q0b2rMW7l8+vEgNWQV?=
 =?us-ascii?Q?/VAqHB/Hvw13NCi84xj0rf7JUkRL2qTA2ZxEgslwPmcGZtdQ3yk5QEB+DYZm?=
 =?us-ascii?Q?Eko3zZpmI4USyT6piMY0Rm9qnKkPen4cZXG/UDNK7MKI7G13aT5CCiDfkr/A?=
 =?us-ascii?Q?viwsNseU/fZdCVKOD1mSHoCl8bapvEj4dQAc536bK1AttVnvO24fHQgY0vf5?=
 =?us-ascii?Q?oTIkh/AwxT7uKL6HgpWoOZEIY86GY0+t3aBR543ZwZ54kci3zyjv/0tkJPh7?=
 =?us-ascii?Q?C6YTnva/7W8Y8rEyt33VWYBTzRbcsHOOA/m5ypxLlcUdw5ak5CcKz7zDVWuE?=
 =?us-ascii?Q?ZeoQO23zjxBERFI04MDYX2YeFQLRgP+l8zLEnjxy0qBtj0fj7k/nheKxor10?=
 =?us-ascii?Q?uWiklmkXxEMZmX4GEY2Mtih60w3EbmPOQUSC/yPbGFRb7fyMI90+qEQ4/Vi2?=
 =?us-ascii?Q?K0/b9GU7yI2QNyayv9ABZqiQp7ktPUoSa0qMbw+2hODA7hm6nYOAKLrOQ2X4?=
 =?us-ascii?Q?bIgbZCpj9lhFKee8SgHUu2D9rMKOwFwbImINtAfqdiSUAh7fcm58h+1wHP11?=
 =?us-ascii?Q?op5mqN1UGj9zorNPpBH/4xf4KdC034aYaiGBlEuoVRz31MOuseDWWGYvT32T?=
 =?us-ascii?Q?60v33CdGBzVkY+MgkU0yrbyrXxBtthd8McWqNopOD9wd0r/19IZzaLPccIz0?=
 =?us-ascii?Q?tLv4z0DYs6uoyaqcfuah97PMcYqfaD/zXCnVaXHqlSSrxogU1hMNppzGzGp2?=
 =?us-ascii?Q?MPbO9RxQ1zgj8Aq22DU6xuXlQ+I9TU0ApywIxIwjnbLKEKSOmKyaGLWBciRC?=
 =?us-ascii?Q?tbqjzGMghuQIHIXBDZPT4cGhm8Nq5eaJucy49At1v40pVH9uxCp6amV215t+?=
 =?us-ascii?Q?MSuctrVmd4c5QjtzWD7wcH2wD7LtJiOLqpeKqysGGUl0CS+yejXy7isJq7Pr?=
 =?us-ascii?Q?lcpIxhD6svnCkzi+d8Nx3N7pax+axiTa22HV7lotisg4n840TReI0k3OriEH?=
 =?us-ascii?Q?VX0dJDcoDlp89xc686hVCtom9nan09Gk7PXQwYit55LZreQJZMegjviL+zrn?=
 =?us-ascii?Q?lxSAqM2c2uxdHL9TlCpMNaZY3Pel9pmlY6j1iFUXiSM87aiBjUrC7+11hG4/?=
 =?us-ascii?Q?ysQIPiOVEqgMKeJsyyuAcCscjurHR9Owj6lg2BeH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b514486-ddc9-4896-1003-08dc9ae6b3d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:31:23.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxvSJarpg0uDj/FJYvgqGMQRt9ARX5CSk/HgFWJF2ESzGPuEvLDtqGuMdiGcboKW2mIcaZUwjoAEpJMRzSZy9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10961

The REQUEST_PROC_DAA command behaves differently from other commands.
Sometimes the hardware can auto emit STOP, but in other conditions, it
cannot.

Improves the code logic to better handle these situations.

Hardware can auto emit STOP only when the following conditions are met:
- The previous I3C device correctly returns a PID and ACKs an I3C address.
- A NACK is received when emitting 7E to try to get the next I3C device's
PID.

In all other cases, a manual STOP emission is needed.

The code is changed to emit STOP when break the while loop and 'return 0'
only when the hardware can auto emit STOP.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 61 ++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f0362509319e0..15fa56383bdc9 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -790,7 +790,20 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	int ret, i;
 
 	while (true) {
-		/* Enter/proceed with DAA */
+		/* SVC_I3C_MCTRL_REQUEST_PROC_DAA have two mode, ENTER DAA or PROCESS DAA.
+		 *
+		 * ENTER DAA:
+		 *   1 will issue START, 7E, ENTDAA, and then emits 7E/R to process first target.
+		 *   2 Stops just before the new Dynamic Address (DA) is to be emitted.
+		 *
+		 * PROCESS DAA:
+		 *   1 The DA is written using MWDATAB or ADDR bits 6:0.
+		 *   2 ProcessDAA is requested again to write the new address, and then starts the
+		 *     next (START, 7E, ENTDAA)  unless marked to STOP; an MSTATUS indicating NACK
+		 *     means DA was not accepted (e.g. parity error). If PROCESSDAA is NACKed on the
+		 *     7E/R, which means no more Slaves need a DA, then a COMPLETE will be signaled
+		 *     (along with DONE), and a STOP issued automatically.
+		 */
 		writel(SVC_I3C_MCTRL_REQUEST_PROC_DAA |
 		       SVC_I3C_MCTRL_TYPE_I3C |
 		       SVC_I3C_MCTRL_IBIRESP_NACK |
@@ -807,7 +820,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 						SVC_I3C_MSTATUS_MCTRLDONE(reg),
 						1, 1000);
 		if (ret)
-			return ret;
+			break;
 
 		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
 			u8 data[6];
@@ -819,7 +832,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			 */
 			ret = svc_i3c_master_readb(master, data, 6);
 			if (ret)
-				return ret;
+				break;
 
 			for (i = 0; i < 6; i++)
 				prov_id[dev_nb] |= (u64)(data[i]) << (8 * (5 - i));
@@ -827,7 +840,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			/* We do not care about the BCR and DCR yet */
 			ret = svc_i3c_master_readb(master, data, 2);
 			if (ret)
-				return ret;
+				break;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
 			    SVC_I3C_MSTATUS_COMPLETE(reg)) {
@@ -835,12 +848,23 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 				 * All devices received and acked they dynamic
 				 * address, this is the natural end of the DAA
 				 * procedure.
+				 *
+				 * Hardware will auto emit STOP at this case.
 				 */
-				break;
+				*count = dev_nb;
+				return 0;
+
 			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
 				/* No I3C devices attached */
-				if (dev_nb == 0)
+				if (dev_nb == 0) {
+					/*
+					 * Hardware can't treat first NACK for ENTAA as normal
+					 * COMPLETE. So need manual emit STOP.
+					 */
+					ret = 0;
+					*count = 0;
 					break;
+				}
 
 				/*
 				 * A slave device nacked the address, this is
@@ -849,8 +873,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 				 * answer again immediately and shall ack the
 				 * address this time.
 				 */
-				if (prov_id[dev_nb] == nacking_prov_id)
-					return -EIO;
+				if (prov_id[dev_nb] == nacking_prov_id) {
+					ret = EIO;
+					break;
+				}
 
 				dev_nb--;
 				nacking_prov_id = prov_id[dev_nb];
@@ -858,7 +884,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 
 				continue;
 			} else {
-				return -EIO;
+				break;
 			}
 		}
 
@@ -870,12 +896,12 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 						SVC_I3C_MSTATUS_BETWEEN(reg),
 						0, 1000);
 		if (ret)
-			return ret;
+			break;
 
 		/* Give the slave device a suitable dynamic address */
 		ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
 		if (ret < 0)
-			return ret;
+			break;
 
 		addrs[dev_nb] = ret;
 		dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
@@ -885,9 +911,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		last_addr = addrs[dev_nb++];
 	}
 
-	*count = dev_nb;
-
-	return 0;
+	/* Need manual issue STOP except for Complete condition */
+	svc_i3c_master_emit_stop(master);
+	return ret;
 }
 
 static int svc_i3c_update_ibirules(struct svc_i3c_master *master)
@@ -961,11 +987,10 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
 	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
-	if (ret) {
-		svc_i3c_master_emit_stop(master);
-		svc_i3c_master_clear_merrwarn(master);
+
+	svc_i3c_master_clear_merrwarn(master);
+	if (ret)
 		goto rpm_out;
-	}
 
 	/* Register all devices who participated to the core */
 	for (i = 0; i < dev_nb; i++) {
-- 
2.34.1


