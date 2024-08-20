Return-Path: <linux-kernel+bounces-294496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC878958E57
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D21F1F2444D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6A156228;
	Tue, 20 Aug 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVAxr0jN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454618E359;
	Tue, 20 Aug 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180435; cv=fail; b=a53+GWFPc+XPIahTCZGfhclivldn+3VDPQhYREsBYXj6Nco4TnLUIgoaPqxVxVl8vAd4FB/jgbEuD1/fPPwmVIXtEhbBMyUW6i60fSSjSvYh31NDr1At8kYxwizDVZSGMf9r1iG7SqzTjXe/Sd/aM4ijLZCg3vAC+wKfOEZ6awc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180435; c=relaxed/simple;
	bh=f2x8DE1elpHQpMXDAcorj9SKa91MDmsokH+pRbFJrUo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NrmVPg+nYP3ZCrnGijLfkP/DhLPbwZzUxTjjzil95Tf1Wt/MU/JAj+VWflPnt3h4NZGsuKWHTHtqL3SBzX73+YdvwJmCCGC83axfsoJX4371JmnGdgigPnSVBMgFS2gC837AMNaBhh8+u5gaHwb3FCATwH1TOZuc8mjRXqkDTOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVAxr0jN; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okusF7X8OvfU6axhFEorzFw0soHrmTZmer9b9kdVWGt0mYGUMk//s3GrAGjpPk7lv/FdovjMToY6hPaixu3wAju577ZTwWvlk5ZZYH00W46OtgEXp+tOvLcAhtAiVTzXPDha9S8vaolY+QhvzaejW1qsYzleyB+JoxIlq3oyGyTXBbqMu1vAjWMhkl//UBTfIeRgvmacHTPKTn/Rs6urytZwPrNFF2FDkxJDWed+cLVe6kmxQ18ctcQUVw3YIdSLtGgCY3WnPHL41MZo343VWfXGtLDkL294UH8lpXiAhjCo/7sz3xnVwJTrajZqf1WLyW5B252kJsPV5RRLKB3elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zELuV6Eg056v2Jzypry+neHQTEiWCA/yZftqWA54dE=;
 b=p3tHl9doIjrMc3b0mZoEfzTYMYOshtbo9GYhVxRvzidujLzVicn3keUoUWygWLL/n0iMfCIBUHbsY5fO+utD8CSfF23ogpn+ZbiRUlHj3y05viiVx20vs0/COddXdaI1hLT0xeLpqPyyLuTUXLZAQZquXUlZyyUsKlBW0eYWl/fHcXwnY+DVJOLMME1QeHlyUPhm+PAZ3oEM2X4LB8keaBn7KzrAKpcZ90YH3S3+K0OL0EVLHdnNX0QbsgRSBKZ/HH1hdkDaRrTtsb8/MvwDQPS/80f5ZvrEVj5dc1iVFjyxRdkrfprYIVCucKxtFS8fX8YJ9Pq5ENs9YewJVKOKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zELuV6Eg056v2Jzypry+neHQTEiWCA/yZftqWA54dE=;
 b=ZVAxr0jN9IZP/5yFL22tbDwKCkqUmBIuWV9rfxZRPYXdMx9k+uj+V0oXHodA75qPKJK+5wNpCcW/EAYHAN82s4EMlGscEglzV/XKgxAf8CpW4X2Jc/sJY9RLRaOIqRvk7Lum+BmzOjwyMM7VeRv1lah3KVZ8O3o8wr9Zl5r1A4ucFA7Rr5oCRhZ62AyQIL4XFJd6p6N/t70t2A97R9Ee1VFfzps2qJgQGVDhILpUw459JxIliNUxjDfyFU/Sr3P+YKdENJ5AkwzruROWWKZ/cxloisIih3jhof0M1+bRZUGcmnKdvtMF3cQ8tOn8F/TTPaLqTUX+TRbL6VEUsWyqXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10844.eurprd04.prod.outlook.com (2603:10a6:102:493::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 19:00:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 19:00:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	laurentiu.tudor@nxp.com,
	linux-kernel@vger.kernel.org,
	stuyoder@gmail.com
Subject: [PATCH 1/1] MAINTAINERS: misc: update fsl,qoriq-mc.txt to fsl,qoriq-mc.yaml
Date: Tue, 20 Aug 2024 15:00:15 -0400
Message-Id: <20240820190015.499641-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10844:EE_
X-MS-Office365-Filtering-Correlation-Id: eac89d25-ab3c-439d-1866-08dcc14a5ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CwfEkFF4sqr+xIitdU3XGXx0ZOHL6WRuTiEM4AUESPd9LL3pY44vMzb2JyOD?=
 =?us-ascii?Q?+fBn4R9UXtNUSUDSOpjhqWUuNiXumkY6OXEwuj/Jv46ZtENi7z2g7ytSc18b?=
 =?us-ascii?Q?wgM27pnAqiXtu/5xyNUtxGWsI5ytJ5nxb2KVHMUk30vNTIakCja0CrUwaGpM?=
 =?us-ascii?Q?DYe88KiUJz07Kab+XHt2QrKbYiiFUPnUFFYRCqs3TtPUEosPjjOhEjHlqtrh?=
 =?us-ascii?Q?7jCcxDrQfNiCC0guAIpXJ2uWkNsfGhBWGoQfu4fDxEWCNSjMPKY0Fnx0FJwc?=
 =?us-ascii?Q?/bZkTG2xe5n+MvSA1DhoqteqBbTNI8W2YeLRmui2H4LFA4dx8jGwcoFvsuSL?=
 =?us-ascii?Q?TchK3j+Uotwn6xmFczndQcCe6LpRQjtPAQgT1r9eGtcNACr0tYIzlXEKdZaw?=
 =?us-ascii?Q?Hr+e5jGDpxvBHgMAHNMa8tg69wPP9spaL0s0UZUtyfD8p/c1x/jZEV9+yzcE?=
 =?us-ascii?Q?BH3gW8tRuO1T7io5NvjDoVMe3+IumRLhNXjDAOWI5BiLzzULQ8olAdvm6+UN?=
 =?us-ascii?Q?2P8ukl9uQ9tszC8kxqZvoRVkUL0SRqknGOzVF2YwwHHEyISww2oyE1O0ghEI?=
 =?us-ascii?Q?bwCATb8xkJWBLZrrXieybWrKXcs4qoHbb2l6acKmDYy4DPkZiMq17tHcwTph?=
 =?us-ascii?Q?P5r+JXsCkbRYpYwWr95UQ6UFhZ/JXZKOwuxGwVeBtPuVgxZ/swvtxUejIRBV?=
 =?us-ascii?Q?XLZA/UoaQnlQUko+TLqr40LPuEGtOSukcasxvMR7+M2PX5rxXr7wZX68wG58?=
 =?us-ascii?Q?4WFPQ5vMKY/QtsHD0kD3DFo61jM+3kpCHTM2H0JtdmT9R5gY0xg5dTJBkptN?=
 =?us-ascii?Q?W+/eGiood4AS0V9ayJn0nzO7WxE3vSV2rYV7fOhJ85iUjBhi9FrC8JKlwSaL?=
 =?us-ascii?Q?romqYqyjWgG54YaLasMZ6IxbaPJYVW6BGlD8x1Pn7mLv/LtQQUSXBxY9eJpA?=
 =?us-ascii?Q?i1U4Cs0DOadRxnro3bkPYUAmvA9Uh1jc6ivqpjW4L279czCwyz9HF7WdEpXM?=
 =?us-ascii?Q?0BfC0T7svr0D4MCh6dH6LwSiEfnmGpfZhL8fgJifYiq8N1O8V8QcPOg1vV35?=
 =?us-ascii?Q?dO9DArXV7bTVgiAeH9GRkw0s0fiVF4zfPApl4ciT4eV6lnBxzGctRDF+bute?=
 =?us-ascii?Q?l57FSme2bO+FT/hhO03F4uMEu7P5Y5fk4uoQ9hnkwbF5ugggaC3IXcM2fVw5?=
 =?us-ascii?Q?GSoC+rQ+iVRaLRJA3f0NhXsNbOfUa8bCIQbzQdjnhqvQMyp19mrYfzwQASPh?=
 =?us-ascii?Q?uBTGUG0HxOoGRCaVJyWGM1s0kGsLLg7OCwFUlZvHdGSgW35vwno80bXMrn6L?=
 =?us-ascii?Q?8rlqRKX5lb8igQ5DejHQSYj+/aJO+c56gU+LopD21lVL8LxsjMmDJXMWWDhh?=
 =?us-ascii?Q?u02sXf35eRuXqjwk43i0RLjEzrnlips9j1Sz/wcLUbMSt5l22Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bzF1eap7Rq9DeutnvGwvHuZQmKJc1jgAk8DimegenzJOCEuo7b/ma3OARQNP?=
 =?us-ascii?Q?ECU4zeN1wAPrdmZ9cE/SywcyZC+j3htzzNEa3ugiXMdceaNBnWkFmrmCwWXs?=
 =?us-ascii?Q?VSaU+y5j/vRSY8/NAI7g+1nxEWUwbUvq4dzmQFOHgf3UDlaN6SVTTxdFVE7S?=
 =?us-ascii?Q?ePaMJO2LhBhhw00h9a14SiQ6KQOdr1L3whp/0YkpNf3TMyFLL8lZX7Bc2D3A?=
 =?us-ascii?Q?YnpzGjPYb56zrVcE68uafhRAu9mSJiEYxJMFvGYl0h7RPk39gp03sCSGrr+F?=
 =?us-ascii?Q?1xooPTH59eKW0WdeOuc/gKOOU4MltKXbyaDyxTBvHsmOdh/5/4xK7Byh0wud?=
 =?us-ascii?Q?zge+KlyElJDKhz6E0gJ8Tv7WPeYT9npurRYD/7GfPx0LQEkGBiJgK5DQZ+Bv?=
 =?us-ascii?Q?vKM+jtJqSqOZrgT5AOrqKHQeoWx8XjM5BaattIXy78Ob7Jt39B8j88Ke1d/T?=
 =?us-ascii?Q?DOPEsWXfWLoyC5xJvI7JD13PVw5Eifv6+QPDTgBEx2tNLqvBtvwTd3Yp6AHZ?=
 =?us-ascii?Q?6B+n0vryvvOAMAYmTTBBTj3bPVjG0KTqRMeJrFEZNllYJOJl261ECUDak6sP?=
 =?us-ascii?Q?Wy6huAmi/vBAL++9RVfyAPJfpuT1aGFBPLiwZo0qbFtXt2zhEY2gCaMGPuKB?=
 =?us-ascii?Q?GCwypUiDdxR5T0aLjSejaiQUqDlfFMx5DGOCYtwHWcIo3IDKIp/hLKV25dX4?=
 =?us-ascii?Q?yjunCYc59L+vOR5f6r0ZnJK28VWyZsYG0oVDDOEZWA7rFZCk133Ox/HwruMQ?=
 =?us-ascii?Q?YV9mfl+aSmfNoT9TbFY1T+X2FIf4f7VaXhnvt+y0u2padUSyMzhHeqNkm3Fe?=
 =?us-ascii?Q?P0O8LzNi0DIlhNVMgbaSjwPd27fcOx8K2kyE+RvpY97N/KuUiLBtsucHYXs8?=
 =?us-ascii?Q?2F8EeuzFxrpvm5A7Hj8G3ZVeg5lQ5HNXdvgqcLVxHmneiwoPmX2FxWyhPPab?=
 =?us-ascii?Q?V5ju2V/so+ydQPw+WCZTmF27whoAF74SVcPCz3R8TLEufH55wzbvfDych2ih?=
 =?us-ascii?Q?D+rD0KwMdlQ34k9J0uijOgRRDHFTqHFLAw4P5fREmx4+czY0s0BZ3LtIPRtK?=
 =?us-ascii?Q?hI2K7hmrfEai0p1fY4QCt0pLfzFYIqHfXZHOa9KPL1EPo5FpkOJRNJ+3UB3q?=
 =?us-ascii?Q?7KkCVib0EQ+z2gJUcqvCGbfAh5+5k+BBMMvwZ2JQpVieXOPfu2GmvlGTn8fK?=
 =?us-ascii?Q?OTF+04Pzz/SEx3Jg5ieIA+QRtIJ1P6GVKBQWHSsYbYwiI4Tg4ZYF7l1gTbC/?=
 =?us-ascii?Q?WYLZC+AFYkGzt5xnHIc+cbeMOUsDRp7OGTj48kF/ovqDUTQqMTay8qu0Kjke?=
 =?us-ascii?Q?dyR63Yut54mA1fXLnquG3Wf/MrZd3ICfN6a/Mk5dXU9Hwko4gKG4WrR9hAyu?=
 =?us-ascii?Q?643VBAPJWsYLTxr/ozSA2p5sNZDlOMCOVQNZwZ8nNdPTCZTOpn05n4YTLFU0?=
 =?us-ascii?Q?/TUUU2OUZUPAMEozFX0DYm1NX0Mc3I4AParPpXSCAbqRBdl3GYCVwzof1YO+?=
 =?us-ascii?Q?OXWHIdWIrSuwTWKVHoZP5pvMWKXpIkzgXEGA8TG/qdWBff6ipeZ8eeo0Fye8?=
 =?us-ascii?Q?mCH7ycWe8+axkyuCDvigyn090AxwN2JWp7BLCjFo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac89d25-ab3c-439d-1866-08dcc14a5ca7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 19:00:30.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hW3+SjOENg8dacd/A+0qIc4kT8r/73Tw0On9H9gRAbubFoxddOyq98whloRfY3+ErQL5ITBhLHQWS+oXfJKItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10844

Fix below refcheckdocs check error
  MAINTAINERS: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt

Add nxp mailist: imx@lists.linux.dev.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fbee89eaecf6..d174cc3ae4347 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18765,9 +18765,10 @@ QORIQ DPAA2 FSL-MC BUS DRIVER
 M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel@vger.kernel.org
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
-F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
-- 
2.34.1


