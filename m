Return-Path: <linux-kernel+bounces-287194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD895247D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7217D1F23E02
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934E744C93;
	Wed, 14 Aug 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OZNtl6VF"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A27210FB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669778; cv=fail; b=Lkrz8Zu9R95J5piLbpI88OYV99QGLPrllTgVyKrfR8r+O2Rjm4xWslVO4tfJGoTYg6L7Bg6DWXQ+zcCu8tCgq24yZnw/b0JocvZBBCro1nKJ/K8QwbnUXLj8ByY4pkOP/FCGUv2C956sMY/2vwDU587ad8lqCPE65hmXuW9Qv+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669778; c=relaxed/simple;
	bh=KHGbUlhskhgJxc5Kwfs4uaIXioz0YAdIXBw0vMpD9JM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UlLrlDo14xim7xoIeTq2cbeAdh1DReyuk5Elf8rSzaYcX7gDxKA5JH9ZYsPmbq64kot9v+1VA0iHLcvV5D2JcrtG+/Y+8VHHvckpqe5DtMAe87NyV3A0FBgHm1yQ93wdIQEJluCNHCVERMWUtOrK7CDiE03AiTqL1X9CjThP2dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OZNtl6VF; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR/Qke1l8fjPZIodLLlzx3t4lkYRROximSPi/U3NR6/TaRuoOK3HnvBOMcHak51676Cm3TUfqW34USlZnP12OWbTq4Mms+7pJMNdrdGhmDVO3lFA4V38+y1rl6dLJZYZOezilnKMUtrD1g/LvnXezGB4rkE1zRRSQbL0taUMfjWmDE9ExMO7hXoPHzWvm/J2rZnu71gJpDZYX6jrMw94HWbBAcwMSZ+dWGJeCkJtdYUmcksuKREgs4+JQVIxQzESuNEjl04CPKphEzBjBWDHX27U8if0pZK5nkg+bXKIEe/V/7pfyX6XiHtgKxBElhYLv0ornaJO+cy/jP4ZCll0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITosHfQJefVGUSPY8CzRgBVXt45rtkpHSFmJ8kQWF1o=;
 b=NUHhdyapCJpYA7DPzdqseE9EkoKZ7kGjQAbb+bMFKDtc7CII4eqRRuRNQ0mmnOqfuL85eBU6EfxNNgOo+L/KweBZqWV1Y327zecHLLwllUywJbO0ukG0AR+a9uNcO+YQArTm+bHqaU23z7Z016MTEvtefs5a12fxiaU+qjGQp2lYzA9X89Vxlx+0M4nzXDzVzgwsveVqmh1lucNPMU1veH6km1v20Z07+EjxDNL0k1bNDp6NtWYehVh2p0is8shjkZfYfPsow2p7g0PpEXeDmPy38cfuls1XweGXTTu0TE5dXZI48HXBJ/TRj6c+Pty3YEKQI9mXurQZivUOI9Eymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITosHfQJefVGUSPY8CzRgBVXt45rtkpHSFmJ8kQWF1o=;
 b=OZNtl6VFr+/rSRNHMS1AsV2Noc2cNCQf+gqRIDigkojcPW7yGfyL/vJ122H3ED645TqTQAgjzui0lNddHTRH4DzhTw6Iclg6lHYpIDEkHdH+iFvuAWwmgmY0CUu3/QXCl+d/8YMvhDfTcyCpZJX1L9f8OXSordx0HQqceaDNJKrrHRgGYnxXwbNCXZTTKdHhba90rKM3TEW9Z3jWB9cfbKbdDApflrYSiN/e2zqFw1UdLoP/afJoAiLe9HwPLagteow1+qFxaDaV1b/4OdJD7my/lu2AtmKGge2aapUeTaZl/Zws1EPg0bDWoFiPULk4QQ9wiRPGY3qOYQyibXc62g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 21:09:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 21:09:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: arnd@arndb.de,
	bbrezillon@kernel.org,
	boris.brezillon@collabora.com,
	conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	pthombar@cadence.com,
	stable@kernel.org
Subject: [PATCH 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C controller driver maintainer
Date: Wed, 14 Aug 2024 17:09:15 -0400
Message-Id: <20240814210915.4046554-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: ac752f12-d3f0-4690-ad32-08dcbca5643d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?v7hZHpRTq6caM9EIkzTIA4fLxHguw1c998H5GWziYhiNy7a+Tz6u8SfT5h5u?=
 =?us-ascii?Q?6twLZd/ezXntTGu2LOr+SQrju9GbN8BtAbpl6e2VJznBzKfwwXedEsFNDNSA?=
 =?us-ascii?Q?tz76wYV8D39nZ9w3VYTsIIe/yqgnt/QGTVx+cwcqipzqNLmBnKhy8i+hOK16?=
 =?us-ascii?Q?tjq1lDzi/BeZBzA+lW7MhECH5DGyYi7SxTGbjA4nqjMX633MLVPYsMBRi5rN?=
 =?us-ascii?Q?CIdM7ftlnjDfr6BqaSFKBHfmYihy5dMfFArzjwhu7YWKTYHylOQpsnv2LUSo?=
 =?us-ascii?Q?j1cKADH9YmdcAcZ+u8EIX9KuFEKAbXDB+/MdZXwypd9rGs1HSoWJMdao/+Tr?=
 =?us-ascii?Q?WDjHhzhzKZXSyyqqgSpG68do+E1O7u9qy+Ve90eq4pPsXjDVv9COq1kgj3kF?=
 =?us-ascii?Q?CewWskA0a9VENhimKGGABxKiq6J0QGhkkFfb3CwQWpETUb+JUjfBegpFkYUV?=
 =?us-ascii?Q?CfdRwlbFX4kkXjSV/UiJjKqFoEqD/IWGbP6v2RMvGJWIB9+wB98AB/GVn1Ks?=
 =?us-ascii?Q?8aNLIcBciwWhbHElc7yAu4m8JVHs35M7m/4iw9P03ngnqbITYXVNad3HRrd6?=
 =?us-ascii?Q?KsocLjyYBjGoZYhR2+ttLRge+T8CJhgv5KM+gQqUWvsSIUQxQhsv5LchbAKf?=
 =?us-ascii?Q?GT77ClYKohmS2Z7TmDJ0DZhFDWWA4kuKj1g4RsKjvSvixZxNCr1UtAKwPb43?=
 =?us-ascii?Q?Auefp9CGXfP+nQ9aIMr2nEoyXRLBDyrxqoACEdo8sFsIr1U+i6lw3eHPsuSX?=
 =?us-ascii?Q?0t4m9m55/Mc//SuUrjBqL7zOfwijumJ4OxrU9jfCi4v+a336uYluX/SeHtKu?=
 =?us-ascii?Q?dKErY36VJ3peaCSuwl47RhHEUSrxmEYoXR4CWlEzwYsa18Fv6/lan3Mwv2Ke?=
 =?us-ascii?Q?QwoPpb6BVqvQ+snlhckaGAnT5LOEtdUtn2PEe9uBdPUwqaPVqrsD06MYHYRD?=
 =?us-ascii?Q?g0oFxhrZmE6d8TfctGGTEMuQEzR+WnkZUo2cu+NSZuUFH5OHzLh6goLGfEbF?=
 =?us-ascii?Q?5TxofBCRsTRX0Gq2Q31PB5RaahNX7kNO9Z+NRBWoidxc1cl+1bPBRyApPah/?=
 =?us-ascii?Q?UJgj8AIMWSbXPC1wgmVW1AQLRYpADRMQvw7KbjSPnC9hW1rKBWNnoDTsEj/N?=
 =?us-ascii?Q?ngrwHBga32xuL14sYU3gz+y/5z7MOdYuAG7xTNQ2nOESHJ9DRhM04KYUnb49?=
 =?us-ascii?Q?P4vIJFGDfQ5mhMuHdBkgxx5QWAd48O50e+KqOsml++vWkN/hbyF9QW0iY3BJ?=
 =?us-ascii?Q?4VHavI3n6TODt8rNFndwWr5u3NtF2q2/SyPCuEfMiVt4byacLrtoinCrTgLj?=
 =?us-ascii?Q?y0jhFtOvzhofEnKIw+b8teUk61i9u2Nc7i+WrilDiMOS+6K9IBMaGanSYxKh?=
 =?us-ascii?Q?3bdxk7wfoW4TBKs8tmXRKvOLB4vR6w218y7Z0MRy+ES130YnYA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?oSdhQyC9MJkgVSSCqgphITHUEaa8S0U85wxgnAR6IhY/WUGVoi2dzHFCqoUE?=
 =?us-ascii?Q?CJoLzHR31KFd/y+Jj7mBsvH0g0/Y1QBEGgcEYwjN7swP4GOxUXYCHRs9CPEE?=
 =?us-ascii?Q?4+6KP9SfVgb7TizRu0pCjguisw2BvpY8T5XL5wHCjWZWJZ/6jIbtMTxIeqwa?=
 =?us-ascii?Q?tbsxuIHT1bU/LXY5k8w+R/teuCX2uD7YhDs3AJoqJgU6UZIZ5UlZcM07RBms?=
 =?us-ascii?Q?cxyofcTDb2wk30mk7B2La01kE0PEo3YtfSOPMmbLaGSxoOV9qzbsqzGE9eR+?=
 =?us-ascii?Q?Lv95WZwKjRNdtf/V4sXmkUM3nwjFP51ckOdPxxvgw9Yb690Eb6Wdsassbu/1?=
 =?us-ascii?Q?5fDVNga+vSFBIg+pqZp7M7mSMTRj+lYT8p26AUWbWEL6ZK1DWKE0bXTgKmPN?=
 =?us-ascii?Q?/3tVFacimVWLRCNr1rKwQDKuQ57CNEKZvwr4LQY88DsmJIHC3GJtXQKh8heb?=
 =?us-ascii?Q?CwF9Z3WZ+WYpXhyuTpt72ixnw4uxxhMNbEsmMlRj73hsNB0oDFD3d+EXIWS+?=
 =?us-ascii?Q?0vEj5dmrHvQRZQv3CT53bO99vDiWSDud2KowyH99aOC1E+aRkV46WOFKd7YO?=
 =?us-ascii?Q?e5/aqVUxZccNzft1l4RUyqVtdEs828z9kXo1DAjnW2sImpUSz9f9u5aGaReJ?=
 =?us-ascii?Q?ZGHBUe38x7vY8yOGrcC6kVSZ4deiY3d6MuByjnO4CIPRP+ObixlQ/B09RR88?=
 =?us-ascii?Q?QrUCDPcqqTl12K/n64xyiZ8V8rQmdAuGiiZpjmfilyHTwkprsnCRT/yBHxB7?=
 =?us-ascii?Q?SuWRC1d/uLVGHwHgtMxWybWYCczqtmx2ioDwpVSBqBnmbyUmEhMjdVYXIHuJ?=
 =?us-ascii?Q?Eljv4Vnlzq9fSdCZIIccEkiXKgfa7NZHMAGeeVFtRr2Rjmk4y/v9JMA3PF6y?=
 =?us-ascii?Q?+ItPlkvqdzbIAdDFPD+WeKycNNg3tCD2NI0jSflsGSn+EYNh6HfnqXnlDi2k?=
 =?us-ascii?Q?urXMDR+IY+2bH8eueWFW2UIm0OVw/A2r7Far+MvKLhl7vPQqHy0/tHMbILI7?=
 =?us-ascii?Q?4pHj/qE5I5WIQhomhtQJvYE+dnMsHhi3aCquuPT1NLqCgcYQsX/TdXTFbqtm?=
 =?us-ascii?Q?SxqvcEoFn5BdV1pw9G94WcHhCBMasPmYJ0pnvyx73NY+kODEE0CIZbFUfG44?=
 =?us-ascii?Q?YrDxtDx/vB4P232XcVUNhSibKMxHkJVAZb2pVWI5l0F9SFd+wgmIYz0YgYAo?=
 =?us-ascii?Q?IQsozy7/DuPeTMsZO/VlBqliaJezH0kJLdMg7ZpKFZDmAG32EFqsMucOOI+k?=
 =?us-ascii?Q?uWAj6BgrYMPV7f8JC2dsbv9+0WYYgss7p0IIWdHHdGIN+e4TWpm6Gia8YUpG?=
 =?us-ascii?Q?HN2JiMgc2sRXCUVMvKjd+yPT5UUHoSSr4RnOx+tr1LDZPPqQ3QiDpSn5Zp7H?=
 =?us-ascii?Q?xubmYG+vSvZeHvwobpbVe6755xPCr5ekI2KagLOptUZDJcv1sIccXgGPRmOF?=
 =?us-ascii?Q?ipn+VJlNLDbt1Jy+jcS+cVKdLDY4yhYVa3HaAkMrqt/Z4UcUfp9lh5IGKziG?=
 =?us-ascii?Q?ewqHxRwTV0z2OTv0vBGi6bmaJJBDB9xiFM3+j4PbZHBjxR3SgKunVO8ajD0r?=
 =?us-ascii?Q?fVSs7Z1jU5MlGO5Pwl/TEht8O6FzGpHtFn/ehF53?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac752f12-d3f0-4690-ad32-08dcbca5643d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 21:09:32.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vXFhrASGC15HHI+tjZjk6mzM/5YpYqe6C8ms+2Oxf+mu7AAEIbgcsPY91ksT7+1Ef7CkkuOGZD0HKPUDSIMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

Add Frank Li as NXP i3c controller driver as maintainer and add mail list
imx@lists.linux.dev for it.

Add Frank Li as I3C subsystem reviewer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Recently, I submit many i3c related patches and become familiar with i3c
protocol. So add me as svc-i3c-master.c maintainer.

I reviewed other i3c patches. So add me as i3c subsystem reviewer.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b96899a78890..92da600c3f189 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10701,6 +10701,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
 F:	drivers/i3c/master/i3c-master-cdns.c
 
+I3C DRIVER FOR NXP I3C IP
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+F:	drivers/i3c/master/svc-i3c-master.c
+
 I3C DRIVER FOR SYNOPSYS DESIGNWARE
 S:	Orphan
 F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -10708,6 +10715,7 @@ F:	drivers/i3c/master/dw*
 
 I3C SUBSYSTEM
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+R:	Frank Li <Frank.Li@nxp.com>
 L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 C:	irc://chat.freenode.net/linux-i3c
-- 
2.34.1


