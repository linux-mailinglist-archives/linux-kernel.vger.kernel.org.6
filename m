Return-Path: <linux-kernel+bounces-399631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3DE9C01F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF661C21D45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63A1EB9EC;
	Thu,  7 Nov 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QfOW+fuY"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B21DF72F;
	Thu,  7 Nov 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974256; cv=fail; b=UQ/cIuNbMedod60AL4sCieBcTOAZl0P0UJcV5Jo+VMHwOlcj2P9Ub69xxzfwzNrRqB6B4BeeGdBq3DnnucJxuBxcun9Toxmxly+f5lhz+MuF2NTXjB4CUjAskX2yARGaki8DvA6lBbN4IpeS+isP4GxkafXDWxx9TVsQp8xmJCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974256; c=relaxed/simple;
	bh=8FseKqtoGQecVaZikxxlOVUjRAX0USKYKYraDDHn708=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcmQSyzJBAnw31OrxZVHZsp2OH17b1dSNZNnVykK86PlT3pbigPHcwpjTVo8UDI4ANcuJ4D74cQx2ginnvYnJm0yN1+4sU+PYYSWy5YbEqTbkcZzoacHupww5H3oehEDO5FqCoj8GokCQyIQoTHiNREruU0F0ks7dgOcYy9ztwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QfOW+fuY; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih0fANaykd2iq1R72H6IRI74piJka0TPOfF0peEGmDjYAfUE+5KAKvwrgDMxFauqsMqmCIDBYMHzLYuSjdUhLCjMHkqcCFfGHmosKVB5rBQNefBsrV7Ij1OYX8t+9BW+boTy/2PXcTPsoKKn7Qd7VHA1WCRcyB0SHHo5NQwzNcFGlmeQ8g6Y30AFqbxDDpwHaMBC1avD+8dTCAYMsE6RskxLfzJUIKvaHHacVdbl8m5IM/N57VMDgLPR8+D/hBAPvpAfhif2O7yBrdRzjn6PddSfdNnA+D8B62W8CLM6fCSwbtmRnggwZtJ+14m8O8nbpH+T9QgmXZoC+1pZ++1jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wFGMFEfVigbby97/goi1A5Xi++t5bmFd2uXU5qY3xU=;
 b=d5NAKnicpuU7+DVaHJJ8ke1Glpb7tptC2FWJDU9uwhGAlqoixWjLwmbg/gPZh0a2D4hlgOGZCFr28IMYHM6dpWpbLB6/IXayefWWljPbxgreVOTbR9hYCa/iEeHiP/xTKZbdBkOObts52twdEc42M8G3JZqipkFrYmqB0lXq3uiTRZ28+GSy+wVCpv3OdruFfgq5pe6iXS4cNULAP6RELoWkDDaoFRdHQUMgPMhESfUGosZ62LT5fVwnn2WVXwv8RCgvizwlSIyJzdVZYjn8PlamROscZBYEfdDopoCbDOKu3Jon4x/60U79XhV0Xm9O7Rj8z5iKETGHMG/KJKLb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wFGMFEfVigbby97/goi1A5Xi++t5bmFd2uXU5qY3xU=;
 b=QfOW+fuYjOdOfZ8hCWkEVeQ2nUIQfgySiceH6Iw7SP++/a4CiWa8wQoJOJ7rqbOXYorvyN6hR/TjpWL4+GKscFQJaiTuBWYvpLGWkT2EqUat3YMLxjRj0LCvrIbudTWVdY/nnbvTomvNAosR5AheBxUxW2EIafQp1IKDjZ94mCgv514GbULOv7G8o4W2QMsCZ3PXXvSpPZ7ZBUHn/Rn1xplnV588kzfV1znKoMuK0305/Iup5LZ6qNr54MTddLrPaDL+RUKFWamCOfwpWAtngo+8wWlJPW6dA7PhNpDNhqzfxVrgkTMARcwwhFLUHrTP7NsZEcwD0NUZUePZ7LEvKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by PAXPR04MB8991.eurprd04.prod.outlook.com (2603:10a6:102:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:10:50 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:10:50 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: clock: imx93: Add SPDIF IPG clk
Date: Thu,  7 Nov 2024 18:20:06 +0800
Message-Id: <20241107102008.3626023-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
References: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_|PAXPR04MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bd210a-4974-4774-7c74-08dcff146bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lqy31nU5WCRW9hUYLmsvW9edl+wo8EDCVI9IPSJhwJPEUxPgbuYNKiNvq86y?=
 =?us-ascii?Q?DdGaJ/kKEqzfSgkyH97VxKyAdMfqBxUTbOAsc/r+Mo+HovynbQkgaa/oVfVf?=
 =?us-ascii?Q?GXIsCKO3J8CbSe3OSx72BzAsawNYD1iPjPcyZGCR4/e549cgfd01zpGCaQD6?=
 =?us-ascii?Q?ElBo3MFpYWF8MTHb/+NA9TjyMlFXNwptJM+DrteKJ9erpUxvuqIuJxavAxIi?=
 =?us-ascii?Q?LGNO/MM9rgrFW/ZzvnnrvNaBEDyKugrOQtNhJO75uDq3ut1sD2Hwr0pGjU45?=
 =?us-ascii?Q?j/oLyGLPeOY9187zkKXyPpXtwMzCWAIDzkVZ8v6DhYrCsQyp3bNKBo9KXa7K?=
 =?us-ascii?Q?d6AKV6oaoQE2D+F0ZJGdebfynvKbq4R+KjSJzFwQDinxOR20arVpIZ38OBb3?=
 =?us-ascii?Q?sQBwxn/gm2XS8m6rxjOQ6sntIXKLibKegQtOmf0Evbf1+bRh508O4M4wrduc?=
 =?us-ascii?Q?CyydzAp2tvg0RdZCsG06Rokh7o5PBFsipEi5lJNhx9aki1xv5JmMY0lt72Zv?=
 =?us-ascii?Q?0P2K3yk9J0O4C4xZGuEK3aQnzE+bN5NKEQhDVidWJ4wv9PxzBR8Fx2Bvc07Z?=
 =?us-ascii?Q?kzcNq9fu4hPq1wx85H/Jm4Zdqm3GN4minyE+xIk2PY44TQENWxKmnEklIOLu?=
 =?us-ascii?Q?0X7ZvT9d0xqGpfdDj6lJI5Ksji7q5erlzqjTQS6do9CTtIK3VQ6Y3t8aGLer?=
 =?us-ascii?Q?7YyXLL8OLE1QqDpwYRR4O6yQ8AWFytdMx7/akfhmSjH5IfVrLk+vce9kc8xx?=
 =?us-ascii?Q?XfUoLHEYqrR4tb7PcZnARKCnTpo6xhpa7RdOI9Vs+Ekh86X/IZ5bEprf42nP?=
 =?us-ascii?Q?yHqpC3NZRZxfOha/bvmx4lF117BedVGjiL3nomv3gFlVqHhA9JfIzxF/JNLz?=
 =?us-ascii?Q?n5pPVv0G9fRvmXSL8RGbCUs0duZQcVqvpHXoHVUV+ijL+pZue6zsPgr1naES?=
 =?us-ascii?Q?ZT7bVBhkaCkQhHMRxyqtYsCAVlFuyJ56nBxcY73MNPufiPochcfN4L0a8Bv3?=
 =?us-ascii?Q?3RJUNxDcZpkD8o6h/G4s0Ri2L2YB1n1xgCeHKu89Sd32S/bKZHEBe6AbqcJ9?=
 =?us-ascii?Q?s/RbAL2MdyR2XuLFwT7va5UJLPI88OPbuxblQ8ksKKlkEYwfaP08NInQxiPA?=
 =?us-ascii?Q?N08yV3Oah1SRns8O4wL4XzDkxLt33z9TheZatK7CcthFyxNDc9ycR6IUy9rP?=
 =?us-ascii?Q?82ms9kT4U5lryphwmTCWw/OgCUNp2Lt7GX9KS4xfuwXbYa6bhXiqPZf2JqFO?=
 =?us-ascii?Q?sQygsj6POqXPrRp8cGnWNgd5FM5o2hIkJm1CVFFlKl7BEQ4IcOUKTllxE52C?=
 =?us-ascii?Q?Lv5YyrkoTmUTa6i+2y6aXESxlmCp2CjaOJ2U4PjU+/T36k2cf6dccdJfg10I?=
 =?us-ascii?Q?f7jVAjSC7AJ0hyV73GAM6ZX2oQ9y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BytLIvKxOOrjHJbYmgzAVFiAbT/io7/q1o/CEZMKCuG+HO0mfk/R3XhJ+caW?=
 =?us-ascii?Q?6Xka42CZ3l6wXE/2mH3HDV8QzFowplYsb4SkvOtXAgolRgMvSLVBcsh3doWU?=
 =?us-ascii?Q?eUe4xYRQCy8weSpSGCyBkfXItDfcjVutjYX7BmrSBoAHUYVTbe0AsSR3a5tI?=
 =?us-ascii?Q?eiUQf6o7YUYvkhzFsR+31dclseAiT9wlmpki3qZ0Eqbj/MeuzJHrGPxu2kzr?=
 =?us-ascii?Q?luYwcvrVq0s9Pp0pLEd7k7logOUUT6kc204ubuJVmieuYAa2fOC+BOEj+OHX?=
 =?us-ascii?Q?VBQVuSQYQx63eVOuBh/VhnAGtlxggYhiHA8J8z+AmO7qz0Wl5ElSAB1L+JCo?=
 =?us-ascii?Q?/YdWYW8nlYJs+VqvzR0dNHgEvhqloxtSSXp/ckXaJKhk3ReeoHABkIpSClW2?=
 =?us-ascii?Q?yd8LFymJ2FKoRNqSb0sBCuqSFZ5tCpeOKwX3wsBTF/PUEigjLGpD4SwVOu5j?=
 =?us-ascii?Q?y4PPrDuae9aS/z1CCQTk4jQqMOWaxJAr/zpzHTJI1ZGS/RlslkGQkS3QIJOr?=
 =?us-ascii?Q?LuVyyZUtdMRBEEOG86PBYihY7uouDTW5ZokAgaHqVpVyg9vTvDhJ6rByBktL?=
 =?us-ascii?Q?mWEVavp8Uzlo4iqIxGtOI1Z5IyeP9+i7T24Cf1IkUZU8Jlrb8TjIpWyynhLQ?=
 =?us-ascii?Q?qz6Fhb7vxdgHugzp6bvhLycIAbgmJNxTnjyWquvqIrqwmSjmH+waHNMMBsUh?=
 =?us-ascii?Q?ZtRfQce4Cr/wHiX1PXea+2ENV8iqcSq+c9fRC/1h19zz5tbvXQxRQsqD8Lx/?=
 =?us-ascii?Q?LzmzZHPAJ116r+Ca3N+11zdUeRVWrzmemxENWLeh51lSzfDTWAsmaralYmFb?=
 =?us-ascii?Q?CbXUHyorGQDlv5GAZvirju4S6pH3PlwowSwBRBjfnDYmaSir7NFFJwoUjSHP?=
 =?us-ascii?Q?q14+n9O00611LmYg8VxKE+o0juJyPcD82gIRIQlehnPWg9sQV9oYshJIn2qH?=
 =?us-ascii?Q?tztcBlgdckGNUmF8CwJlLxuEJKn2YrFr/8M1NYmtQI9UOWWdm3MGi5S2qBQW?=
 =?us-ascii?Q?c5pKd6ZEiAHjo1sFw4aeo8TtOkw0SnuvDbcBAgHbDVrM3Qtc4bAwbIloR7e2?=
 =?us-ascii?Q?xFPmlClFC9MHUCLKCBr0oi5ec+jlMqfwRahtkgJjOrJkUZm1grY2jHIN5lOC?=
 =?us-ascii?Q?KG0KImRVvMRT4qjjUNKr/F9SNJqqVBj9welJx+okLrBcTm5WUWpbr6Pkafd7?=
 =?us-ascii?Q?kGc14PfUKe3beVBP2HXIPhs9yvPTiO4yUXYOhMcBD5in436/5GV2iQtHwl1B?=
 =?us-ascii?Q?UcK+/kIxgcu9dSQmyHMj4QF2mhSPUqZeTRoLhbPwqd5v/QJJIzkR/PGbm3KS?=
 =?us-ascii?Q?4AWtcKnwxRIBRrK7EeFEx7pEgLNBZ3CWwf3Fek+PjOJnQis+9pgIolGHOtTt?=
 =?us-ascii?Q?kwMnXUHceCiF/oABMPTDpN7fOy9RhSoB/h6EPkDTD9bm2XiBOvwGxklyj0UN?=
 =?us-ascii?Q?UCXIvvhuIv8KcOvITz15mMql7DLG5JpnnWPw0esJf9SPbxonKwfzj/S6eK74?=
 =?us-ascii?Q?xpI6A5L95L42xE/dNXE0RoScrqHfnAbCFMmDlSLzPlUcJ0Y1Q92qVAfW+lzc?=
 =?us-ascii?Q?QFitqptK8iwT1DpAwiYOZ6OBMX/12GyjlWQxPIGu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bd210a-4974-4774-7c74-08dcff146bd4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:10:35.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvqgvABQuPd4HldwruDUxLT/whWLqTbDNpFZJzT+cVDeSDDkAsUVYv7jAj5CbNfQq6TeBVRDYmuWbQGZTDrjsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8991

Add SPDIF IPG clk. The SPDIF IPG clock and root clock share
same clock gate.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 6c685067288b..c393fad3a346 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -209,5 +209,6 @@
 #define IMX91_CLK_ENET2_REGULAR     204
 #define IMX91_CLK_ENET2_REGULAR_GATE		205
 #define IMX91_CLK_ENET1_QOS_TSN_GATE		206
+#define IMX93_CLK_SPDIF_IPG		207
 
 #endif
-- 
2.34.1


