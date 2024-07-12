Return-Path: <linux-kernel+bounces-250934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B57BA92FEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A851C22743
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96099176AA8;
	Fri, 12 Jul 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ffefQIYq"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E2176ABE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802779; cv=fail; b=YFi5a+Ubs3LcEUOlhDOkt0LMFmnWZ9ANp0McILyT5pZYAuVNm0qp6Z0vbEPpnJg7oNi95SU6V2Z0fkO740VXKOi/P/e2rUEdBDkxMsFycvwN91AeD2GY+MWJkvCadQ8uowwkEoTLIbEpDgRzsZzva+tjmMbq6mtkygL66/F9YWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802779; c=relaxed/simple;
	bh=2LW4iG5U0HJUjz92YWDadk9q9jwoIIUbg0TYl3++Qrg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CMzT8ECU88Ha22OJwQW+20AgkxCCDh6hvGvYfBT7cMad2TBn5HYcRD1hACUZM7mWENCvE0RMSbN6vUsDWXqnpBlHczawbaa0Ubvd1hwwtvEpGWgvuOKAMzv9H/F7Ou6FZalM+ebLyiJU2LRw1qrHuRGb6gtkIQeC4W4LjUkjjo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ffefQIYq; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6aRh8QQyeqcL/BNILz6C5HU8Bs1Co1hTkaxVi9GOcOLC9BD/wsThVHqQbo4WIAog396K3AB74JAUS0QRXMwjQDV83HbA/vXvHYyVsYTA620FvZv0/3PCcGnjIiAD1mO6GUBiNGpehxnqlSngS2N2k5WC7lCtNrQTC5KC+AciksHgjzhCBflPMSVENFEv6k3BmigqxZ22AjK8//aSDC6QDqJYWCOUYUrdSXesE3uKiXlJGILoW1bDgQWdwWsmrhTKin/m8ZuzlCBoZjFLcRl2pD+wLKDBIxFbn6558JkXJ0y4lF5iwW0u7rzQb2sAUSTud9LMRr6sKvNRxek/YltSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJTiKcqbvXuQJu/cvx6FQbzHBOJkEOWkZjHAfAhHVE4=;
 b=HEXWfK34fWhCCdaajDN5Gs9uU2ko1o2WExnSqXUuZXb/p6kWFlKWRIwZn3sUbupScT1m/70hFutErUrifj5Q3ZTEhSxfQEEPCBWzJhbvGc1pleh2lsoYmX4g+6LAtbiq87t+eXG0eA9vH2+jsMrPmNN6gfwvueZQlJhmxpIebj7aCLSMNra8MDPyf3qOf2OCbucEyjvlCyuverLCn7gzjCXR/UTeit2XdIFi289OJEk/AC3fCmlFTvChcd72pTiV6OeEXZM6mKIL+yn6Z0b/48NQhmZsLBpQmvucg1D5QlSg3KjTXOlOgCraI/IkXcQ+qejc6FRRZ7VuTGoitWTlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJTiKcqbvXuQJu/cvx6FQbzHBOJkEOWkZjHAfAhHVE4=;
 b=ffefQIYqFBM30FZuom0vNPO0TkCKTR8S8qmqgfeupAc8KEOFIUJq/wuHSTeEU3kJEGGFVLRplAFAAhTG+t8KwptiGiYanoHSjQ+id7Iub0eewf33FrwjLi7XCveyFEieXq9+wDBlugeZoPlKAEWFwD6DKEnqkp3d4GDE6aaVsTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 16:46:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:46:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE MASTER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] i3c: master: svc: adjust SDR timing according to i3c spec
Date: Fri, 12 Jul 2024 12:46:02 -0400
Message-Id: <20240712164602.3600659-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4ddb58-0274-474b-b568-08dca2922476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JC99mTOU6G4a3ZO5ecgAyberam71dvci4RAtNkeEN8m2QVvKAKUqJXt3a1Nb?=
 =?us-ascii?Q?d9aLE0UK+5lf6UnKeEK+clXhjwxhbirgge1/ozXzM0Vo0HA2TxAtEQvVdI7P?=
 =?us-ascii?Q?KUAZGyXGMVcXWSHpHtXOe14C2NxqZMQrJfKYNUhipZ8Y1vcWF+uYYGURHHnt?=
 =?us-ascii?Q?vSohswqwNbB6qrWMoZQTHyesVzr9lzIehIVvZcbMvVKKWPfeQXJd3V/sGays?=
 =?us-ascii?Q?y30LLKydfZjG+c62E2hAMftE4wXYsmrB5YdL70CgmfqU/eNtfpKxtALLVmh2?=
 =?us-ascii?Q?cBIqXWG37khkKWRxOFabwVVIrdSQ8u8tTvxalOxKeKMNlo9cuBQxptOAncNr?=
 =?us-ascii?Q?me+skuEIv6YiUyrke623MdGs1rc69EjDKt5ed7WXF5i+2INLOeOa0gFnoy2u?=
 =?us-ascii?Q?SUujgy3eqSPQM6L6Vlqpf3bzdRo/wIIydnmfymJVcLAwe/ekjCxiIqm8ouCJ?=
 =?us-ascii?Q?2G9LCpjO0R4nOCvbZbO5p1vbVSggn6wHxwgXK1xbkmWdbWfVzs3FpxjtPr1p?=
 =?us-ascii?Q?wyQAhhhrq2AcI4U0FrTYzCsZvaMdX3M3xr3vz4ZFrJVgY2PWWZn0cL53l4ye?=
 =?us-ascii?Q?bTUJTScvroT5UW31URrPZQgJcfgXagkJBbUlLK5kkYzfzmFmG/xSAmd3td2n?=
 =?us-ascii?Q?kzRH6OyRRHoYPB5uCrJ/m+mpGaK2BqJcO26sKLyYor97FTQN/oQ42SAhtGL3?=
 =?us-ascii?Q?sOXVQdEqK6eiZQeQT0xaKE4u/8oSwXRyWyhYJzBb5yG6mxODSeTHZfJSxScC?=
 =?us-ascii?Q?2SKNy4agDiT12hkpUhTEL2khn5x78RqNUQkh8FP6u2MGKuR43kgu+8Xg7Qy6?=
 =?us-ascii?Q?nbcYW0Y/zFPY4TT5wfEVP6qT1ZIq35pMIRNTNoWnGIdj+j36PlHdsQ02T9w9?=
 =?us-ascii?Q?zWSnc4cXJWDM1nbRyZvFnoQAqkNWEzZ3SOK65kr9MYAMy9g058SAAifatuks?=
 =?us-ascii?Q?UsX5XywIz+j0RldkQj17wkXqQMtx7mDsX736lUuhHT4UUp3+QyrpTOjtthDf?=
 =?us-ascii?Q?rYbxktfAiiRfn8vP40hoRh9awAPoy557jjtPtle88bb1CGI0cyyPFklb5Hdj?=
 =?us-ascii?Q?vaFWDtSFN6Givbb1lgWYP4CfApByEcvwAyP7sbOX9GcvrFb3ehnFU6kUXBsP?=
 =?us-ascii?Q?T0DANm29KnFhgEoRxI9EBSuUrR2coLHN/7Tost4ySvWKa1klwj+dKI7YaTKP?=
 =?us-ascii?Q?xAYIAiqNgt/K+Jd1jYm3InoKDngY148DNPlYRmMeV3kg9cPh6j8slGP+5Pae?=
 =?us-ascii?Q?1m+vGAE2ifzTG2uPm2PjR2ZAJte9KJOvPKPM8hrn3xPYS3MuCw366NOqw1sH?=
 =?us-ascii?Q?tus2g+p5eo0ut/5uohm1SWM6DvWQMtzmd0UkaV6k/tvQzece5HhG/KNvyNbX?=
 =?us-ascii?Q?I1N1iT9FdDiXUq2BPeLtCbODEom2mop8OUsFEEQfBSdRLhbhtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4y16WC5k3Hf3Ro46jzSWnkW6tChByvXuSCOU55d3f/oJvO9CawX+o4K7pUbd?=
 =?us-ascii?Q?n64cl4xstKa6fDNP7nA1D1ZHwyXkr4YzMzMFiSmL5tLkJCLpHwP8phim8EbD?=
 =?us-ascii?Q?o9JML7ciCAxccrLSRqfiNiU8u6Q2FoAopJ/4Ty0QVFB/qJAfP9EttiZYcBiC?=
 =?us-ascii?Q?OaTUP2nFYLQeC/9cFSSbxcTG1MjThFZ5WQ3mDhjrVOcduLUg1IPWCrSnTPnO?=
 =?us-ascii?Q?NKwSNFCVHWXQRUpfjbqQcDl+3eAtDCxMl5948i/xjwMkgPkCPK/v5XLvkeFk?=
 =?us-ascii?Q?Ktw6SX389QTyy22r/fZCuPVQ87Jwsa25ngzYMZuFC3dvOG7Im6n/6fM6IzQ5?=
 =?us-ascii?Q?GsvcMxA+t+qMBZHFjgvdDxfrAH0KQpiO4iTKs+jiNmn7fLzuGlEmoD+7WTMq?=
 =?us-ascii?Q?klKjOrlgjSTADUyy4HjGZ0uCdMwzkX8qkKQvsMPqOnO04rfxMx2pRbaBHxNn?=
 =?us-ascii?Q?fnVTWo4gEhtBDFWDrRXOpeF7y+4CeEq3+YFxSNLLFqsSNNZfS3yWpxojRxf5?=
 =?us-ascii?Q?hb/3wEERnWBGVFccWJpdLMOIwxi5wmJHj4PKOpZ6Q8KFv6mwqlwb+x7ND1os?=
 =?us-ascii?Q?BZMO0mpBUJjOnucoZ4TwiNEiJ1MTQXFrF5iH8pOhgrd53WuS0MeO13nKIVlD?=
 =?us-ascii?Q?LlXacegdFGhbjZiub4ThdYNyBtdR8WJ0TQ/Qc86cjzkZqBzD1znxGx/uetz7?=
 =?us-ascii?Q?Y85r7jt/mxijj+hXXZu8e9N0sMXr7HIpaZGDO5Gklijx5WoKi86vrFmLxYgR?=
 =?us-ascii?Q?maMkEVt701ugOIHzZ8FzGcOFSxxbgXn153vKByRaJxpqy+cSHc/EDj4Zcegj?=
 =?us-ascii?Q?t3D5UlFz4EPdrK2SnLk0L0hChxDYn7C4jA3xdSR2p2ksMGBXQFct7xo/7CPu?=
 =?us-ascii?Q?vXC2UieTXwMBSQoXk+J9zSkD/joCGGPhZjVu33fswMit+KLLc/to0ftqauqL?=
 =?us-ascii?Q?lmpfYVKTNaLukWOsk50oprVZTdeKkeMktA7TUcFjDJQIblSQ7R6w9VseqsdV?=
 =?us-ascii?Q?jKsv60Q9Hoi6JBN/Bch+8OumkpBjV/phS2ZsulN11JYj3ysO17TR8vGxoPq2?=
 =?us-ascii?Q?vNQwnYr31wPKMDEWarGp1bpbPsbr6aUnEdHWTnZIB+Kq+Ow2kq1TblK2k0t8?=
 =?us-ascii?Q?GAlfRs7WgzxwOT5P8oTZK+WoU4qF+uAaYyTNCtKQC5VU29o8bFYVO934DE6E?=
 =?us-ascii?Q?Rg1odvRF2/YZ5BfwvjVqpIOE9Ebmj3J0XtTnEEWJKYhRCa5MRZE6S7HTE8eO?=
 =?us-ascii?Q?MM+BnybZcf39mCT5rfeGOsKeZMxrkwoCo3XnIrAyc86VTXsHucztyhpVUdxl?=
 =?us-ascii?Q?dcR6Tl6QH0V+1K5ERr7hNSFe6fu28eRr8j0PZBHWW6rM/YzXE0e3dH1mEdU2?=
 =?us-ascii?Q?FDE5DfhUD5kXBm+wF06ukaxWafQV7uyv/4+VM70NUTCv3CxAgW5b8bb5+x8+?=
 =?us-ascii?Q?ffRHA3tr/Odeb74R441aosWH3/enSHKoF+3MxR+Cvucs+BOLrtLF2pCz3Ndt?=
 =?us-ascii?Q?Irrmf+XN6PsBk2ZgKQhaJKvPI5F/nmIE3Iy4q+Vg8sj9rzQUXfLROi+i02ew?=
 =?us-ascii?Q?ZPP9gPZKgtjL5x6O4zZQTum2jqDF0IgMkf1NFiyR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4ddb58-0274-474b-b568-08dca2922476
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 16:46:14.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8+ELPX7zygIk9+vgeG16+HgJrmXCu1zu5+eFLY3DTb40+9mhNMZ7qwEewVYKt05kAWVDqgNegFaaUJcu3cqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756

From: Carlos Song <carlos.song@nxp.com>

According to I3C Specification(Version 1.1) 5.1.2.4 "Use of Clock
Speed to Prevent Legacy I2C Devices From Seeing I3C traffic", when
slow i2c devices(FM/FM+ rate i2c frequency without 50ns filter)
works on i3c bus, i3c SDR should work at FM/FM+ rate.

Adjust timing for difference mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 66 +++++++++++++++++------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index bb299ce02cccb..26dc6d833c6e3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -127,6 +127,8 @@
 
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
+#define SVC_I3C_PPBAUD_MAX 15
+#define SVC_I3C_QUICK_I2C_CLK 4170000
 
 #define SVC_I3C_EVENT_IBI	BIT(0)
 #define SVC_I3C_EVENT_HOTJOIN	BIT(1)
@@ -535,6 +537,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_bus *bus = i3c_master_get_bus(m);
 	struct i3c_device_info info = {};
 	unsigned long fclk_rate, fclk_period_ns;
+	unsigned long i2c_period_ns, i2c_scl_rate, i3c_scl_rate;
 	unsigned int high_period_ns, od_low_period_ns;
 	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
@@ -555,44 +558,55 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	}
 
 	fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
-
-	/*
-	 * Using I3C Push-Pull mode, target is 12.5MHz/80ns period.
-	 * Simplest configuration is using a 50% duty-cycle of 40ns.
-	 */
-	ppbaud = DIV_ROUND_UP(40, fclk_period_ns) - 1;
-	pplow = 0;
-
-	/*
-	 * Using I3C Open-Drain mode, target is 4.17MHz/240ns with a
-	 * duty-cycle tuned so that high levels are filetered out by
-	 * the 50ns filter (target being 40ns).
-	 */
-	odhpp = 1;
-	high_period_ns = (ppbaud + 1) * fclk_period_ns;
-	odbaud = DIV_ROUND_UP(240 - high_period_ns, high_period_ns) - 1;
-	od_low_period_ns = (odbaud + 1) * high_period_ns;
+	i2c_period_ns = DIV_ROUND_UP(1000000000, bus->scl_rate.i2c);
+	i2c_scl_rate = bus->scl_rate.i2c;
+	i3c_scl_rate = bus->scl_rate.i3c;
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_PURE:
+		/* Using I3C Push-Pull mode and I2C OP 50% duty-cycle. */
+		pplow = 0;
+		ppbaud = DIV_ROUND_UP(fclk_rate / 2, i3c_scl_rate) - 1;
+		high_period_ns = (ppbaud + 1) * fclk_period_ns;
+		odbaud = DIV_ROUND_UP(fclk_rate, SVC_I3C_QUICK_I2C_CLK * (1 + ppbaud)) - 2;
+		od_low_period_ns = (odbaud + 1) * high_period_ns;
 		i2cbaud = 0;
 		odstop = 0;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
-	case I3C_BUS_MODE_MIXED_LIMITED:
 		/*
-		 * Using I2C Fm+ mode, target is 1MHz/1000ns, the difference
-		 * between the high and low period does not really matter.
+		 * I3C in <= 12.5M PP + I3C OP + I2C OP in clk rate
+		 * keep I3C OD clk high period <= 40ns and use odbaud and pplow
+		 * to adjust the i2c/i3c duty cycle.
 		 */
-		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
+		ppbaud = DIV_ROUND_UP(fclk_rate / 2, I3C_BUS_TYP_I3C_SCL_RATE) - 1;
+		high_period_ns = (ppbaud + 1) * fclk_period_ns;
+		pplow =  DIV_ROUND_UP(fclk_rate, i3c_scl_rate) - (2 + 2 * ppbaud);
+
+		odhpp = 1;
+		odbaud = DIV_ROUND_UP(fclk_rate, SVC_I3C_QUICK_I2C_CLK * (1 + ppbaud)) - 2;
+
+		/* i2c FM/FM+ */
+		od_low_period_ns = (odbaud + 1) * high_period_ns;
+		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
 		odstop = 1;
 		break;
+	case I3C_BUS_MODE_MIXED_LIMITED:
 	case I3C_BUS_MODE_MIXED_SLOW:
-		/*
-		 * Using I2C Fm mode, target is 0.4MHz/2500ns, with the same
-		 * constraints as the FM+ mode.
-		 */
-		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
+		/* I3C PP + I3C OP + I2C OP both use i2c clk rate */
+		ppbaud = DIV_ROUND_UP(fclk_rate / 2, i3c_scl_rate) - 1;
+		pplow = 0;
+		if (ppbaud > SVC_I3C_PPBAUD_MAX) {
+			ppbaud = SVC_I3C_PPBAUD_MAX;
+			pplow =  DIV_ROUND_UP(fclk_rate, i3c_scl_rate) - (2 + 2 * ppbaud);
+		}
+
+		high_period_ns = (ppbaud + 1) * fclk_period_ns;
+		odhpp = 0;
+		odbaud = DIV_ROUND_UP(fclk_rate, i2c_scl_rate * (2 + 2 * ppbaud)) - 1;
+
+		od_low_period_ns = (odbaud + 1) * high_period_ns;
+		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
 		odstop = 1;
 		break;
 	default:
-- 
2.34.1


